####################################################################################
###   NONMEM SDE script (Copyright: Christoffer Wenzel Tornoe, 2008)             ###
###   Last edited: 9/17-2008                                                      ###
####################################################################################
#NONMEM SDE S-PLUS SCRIPT REQUIREMENTS

#Only works for ADVAN6, ADVAN8, and ADVAN9 
#Script only works for univariate observations
#$DATA data should be on a line by itself, i.e. no IGNORE=@ on the same line
#The intra-individual model can only be additive using this script (additive on the log scale=proportional is also allowed) 
#All state dependencies must be explicit stated in the differential equations, i.e. ABS <- -KA*A(1), DADT(1)=ABS, does not work
#Required data file columns: ID, TIME, DV
##SYNTAX
#       SDEmodel(CS,datafile)
#
#       where
#               CS is the path and name of the control stream 
#               datafile is the path and name of the data file or NULL if already generated

##Examples
#path <- "C:/SDECourse"
#SDEmodel(CS=paste(path,"/Exercise/HandsOn6/run1.mod",sep=""),datafile=paste(path,"/Exercise/HandsOn6/simdata.dta",sep=""))

gsub2<- function(pattern, replacement, x, ignore.case = FALSE, extended = TRUE,perl = FALSE)
 {
         # arguments ignore.case, extended, and perl not used.
         # (pat) in pattern and matching \1 in replacement are not implemented.
         # E.g., gsub(pat="([ab][ab]*)", rep="<\\1>", "abcd") will not return "<ab>cd".
         gsub1 <- function(pattern, replacement, x)
         {
                 val <- character()
                 while(nchar(x) > 0 && (re <- regexpr(pattern, x)) > 0) {
                         if((ml <- attr(re, "match.length")) > 0) {
                                 val <- paste(val, substring(x, 1, 1 + re - 2),
                                         replacement, sep = "")
                                 x <- substring(x, re + ml)
                         }
                         else {
                                 val <- paste(sep = "", val, substring(x,1,1 + re - 1), replacement)
                                 x <- substring(x, re + ml + 1)
                         }
                 }
                 if(nchar(x) > 0)
                         val <- paste(sep = "", val, x)
                 val
         }
         unlist(lapply(x, gsub1, pattern = pattern[1], replacement = replacement[1]))
 }

gsub3 <- function(pattern,replacement,x)
{
	for(i in 1:length(x)){
		temp <- x[i]
		x[i] <- gsub2(pattern,replacement,temp)
	}
	return(x)
}


SDEmodel <- function(CS,datafile){

CSin <- scan(file=CS,sep="\n",what="character")

if(is.character(datafile)){
  data <- read.table(file=datafile,stringsAsFactors=F,header=T)
}else{
	data <- NULL
}

#####################################
###          Get positions        ###
#####################################

inputPos <- grep("\\$INPUT",CSin)
dataPos <- grep("\\$DATA",CSin)
subPos <- grep("\\$SUBROUTINE",CSin)
modelPos <- grep("\\$MODEL",CSin)
pkPos <- grep("\\$PK",CSin)
desPos  <- grep("\\$DES",CSin)
dadtPos <- grep("DADT",CSin)[1]
errorPos <- grep("\\$ERROR",CSin)
simPos <- grep("\\$SIM",CSin)
thetaPos <- grep("\\$THETA",CSin)
omegaPos <- grep("\\$OMEGA",CSin)
sigmaPos <- grep("\\$SIGMA",CSin)
ipredPos <- grep("IPRED",CSin)[1]
wPos <- grep("W",CSin[errorPos:length(CSin)])[1]+errorPos-1

SIGWpos <- grep("SGW",CSin[desPos:errorPos])+desPos-1

dynNoise <- integer()
for(i in 1:length(SIGWpos)) dynNoise[i] <- as.integer(substring(CSin[SIGWpos[i]],first=regexpr("DADT\\(",CSin[SIGWpos[i]])[1]+5,last=regexpr("\\)",CSin[SIGWpos[i]])[1]-1))

dynNoise <- sort(dynNoise)

#####################################
###      Number of parameters     ###
#####################################

compLast <- rev(grep("COMP",CSin))[1]
compNo <- length(grep("COMP",CSin))

sigmaW <- logical(compNo)
sigmaW[dynNoise] <- TRUE

pNo <- compNo*(compNo+1)/2
thetaNo <- length(grep("\\$THETA",CSin))
omegaNo <- length(grep("\\$OMEGA",CSin))
sigmaNo <- length(grep("\\$SIGMA",CSin))

#####################################
###         Get variables         ###
#####################################

#IPRED
ipredTemp <- character()
for(i in 1:compNo) ipredTemp[i] <- regexpr(paste("A\\(",i,sep=""),CSin[ipredPos])[1]
noPos <- grep("^[123456789]",ipredTemp)
ipred <- gsub3(paste("A\\(",noPos,"\\)",sep=""),paste("A",noPos,sep=""),substring(CSin[ipredPos],first=regexpr("=",CSin[ipredPos])[1]+1))
ipred <- paste("(",ipred,")",sep="")

#Weight
w <- substring(CSin[wPos],first=regexpr("=",CSin[wPos])[1]+1)

#A matrix
Amat <- matrix(0,nrow=compNo,ncol=compNo)

for(i in 1:compNo){
	xstate <- substring(CSin[dadtPos+i-1],first=regexpr("=",CSin[dadtPos+i-1])[1]+1)
	for(j in 1:compNo) xstate <- gsub3(paste("A\\(",j,"\\)",sep=""),paste("A",j,sep=""),xstate)
	xstate <- gsub3("EXP","exp",xstate)
	xstate <- gsub3("LOG","log",xstate)
	for(j in 1:compNo){
	   Amat[i,j] <- deparse(D(parse(text=xstate),paste("A",j,sep="")))
   }
}

for(i in 1:10)  Amat <- gsub3(" ","",Amat)
Amat <- gsub3("exp","EXP",Amat)
Amat <- gsub3("log","LOG",Amat)
Amat <- gsub3(0.693147180559945,"LOG(2)",Amat)

for(i in 1:compNo) Amat <- gsub3(paste("A",i,sep=""),paste("A\\(",i,"\\)",sep=""),Amat)

#Calculate C matrix
ipredTemp <- gsub3("LOG","log",ipred)

Cmat <- matrix(0,ncol=compNo)
for(i in 1:compNo){
	if(regexpr(paste("A",i,sep=""),ipred)[1]>0) Cmat <- deparse(D(parse(text=ipredTemp),paste("A",i,sep="")))
}

for(i in 1:10)  Cmat <- gsub3(" ","",Cmat)

#####################################
###     Create new variables      ###
#####################################
thetaSIGW <- character()
SIGW <- character()

for(i in 1:length(SIGWpos)){
  SIGW <- c(SIGW,paste("SGW",dynNoise[i]," = THETA(",thetaNo+i,")",sep=""))
  thetaSIGW <- c(thetaSIGW,paste("$THETA (0,1) ; SGW",dynNoise[i],sep=""))
}

Pmat <- matrix(0,nrow=compNo,ncol=compNo)
i <- compNo+1
while(i < (pNo+compNo)){
	for(j in 1:compNo){
		for(k in j:compNo){
			Pmat[j,k] <- paste("A(",i,")",sep="")
			i <- i + 1
		}
	}
}

i <- compNo+1
while(i < (pNo+compNo)){
	for(j in 1:compNo){
		for(k in j:compNo){
			Pmat[k,j] <- paste("A(",i,")",sep="")
			i <- i + 1
		}
	}
}

if(pNo==1) Pmat[1,1] <- "A(2)"

Ptemp <- gsub3("A\\(","",Pmat)
Ptemp <- gsub3("\\)","",Ptemp)

#Get observation compartment
for(i in 1:compNo) if(regexpr(paste("A",i,sep=""),ipred)[1]>0){obsNo <- i}

#Get P compartment to be used in Rvar
phtNo <- 0
	for(j in 1:obsNo){
		if(j==obsNo){
			phtNo <- phtNo + 1
		}else{
			for(k in j:compNo) phtNo <- phtNo + 1
		}
	}

#####################################
###  Write output control stream  ###
#####################################

tempCS <- CSin[1:compLast]

#Write $INPUT

if(!is.null(data)){
	tempCS[inputPos] <-  gsub3("TIME","HOUR",CSin[inputPos])

	if(is.null(data$AMT)){
		tempCS[inputPos] <- paste(tempCS[inputPos],"AMT",sep=" ")
	}
	
	if(is.null(data$CMT)){
		tempCS[inputPos] <- paste(tempCS[inputPos],"CMT",sep=" ")
	}
	if(is.null(data$EVID)){
		tempCS[inputPos] <- paste(tempCS[inputPos],"EVID",sep=" ")
	}
	if(is.null(data$MDV)){
		tempCS[inputPos] <- paste(tempCS[inputPos],"MDV",sep=" ")
	}

	tempCS[inputPos] <-  paste(tempCS[inputPos],"SDE","TIME",sep=" ")

    tempCS[dataPos] <- paste(CSin[dataPos],"SDE",sep="")
}
	
#Write $MODEL
for(i in 1:pNo) tempCS <- c(tempCS,paste("       COMP = (P",i,")",sep=""))

#Write $THETA, $SIGMA, $OMEGA
tempCS <- c(tempCS,"",CSin[thetaPos],thetaSIGW,"",CSin[omegaPos],"",CSin[sigmaPos],"")

#Write $PK	
tempCS <- c(tempCS,CSin[pkPos:(desPos-1)],SIGW)

#Insert Kalman Filter in $PK
if(length(unique(data$ID))>1){
	tempCS <- c(tempCS,"","IF(NEWIND.NE.2) THEN")

	for(i in 1:compNo) tempCS <- c(tempCS,paste("  AHT",i," = 0",sep=""))
	for(i in 1:pNo)    tempCS <- c(tempCS,paste("  PHT",i," = 0",sep=""))
		
	tempCS <- c(tempCS,"ENDIF","")

}

tempCS <- c(tempCS,"IF(EVID.NE.3) THEN")

for(i in 1:(compNo+pNo)) tempCS <- c(tempCS,paste("  A",i," = A(",i,")",sep=""))
tempCS <- c(tempCS,"ELSE")
for(i in 1:(compNo+pNo)) tempCS <- c(tempCS,paste("  A",i," = A",i,sep=""))

tempCS <- c(tempCS,"ENDIF","","IF(EVID.EQ.0) OBS = DV","","IF(EVID.GT.2.AND.SDE.EQ.2) THEN")

#One-step prediction error variance  	R = C P_j|j-1 C^T + sigma_obs^2

tempCS <- c(tempCS,paste("  RVAR = A",compNo+phtNo,"*(",Cmat[1],")**2+",w,"**2",sep=""))

#Kalman gain						K_k = P_j|j-1 C^T R_j|j-1^-1
for(i in 1:compNo) tempCS <- c(tempCS,paste("  K",i,"   = A",Ptemp[i,obsNo],"*(",Cmat[1],")/RVAR",sep=""))

#State update equations			x_j|j = x_j|j-1 + K_j*(y_j - yhat_j|j-1)
for(i in 1:compNo) tempCS <- c(tempCS,paste("  AHT",i," = A",i," + K",i,"*(OBS -",ipred,")",sep=""))
	
#State covariance update equations  P_j|j = P_j|j-1 - K_j R_j|j-1 K_j^T
j <- rep(1:compNo,times=compNo:1)
for(i in 1:compNo) if(i==1) k <- i:compNo else k <- c(k,i:compNo)

for(i in 1:pNo) tempCS <- c(tempCS,paste("  PHT",i," = A",compNo+i," - K",j[i],"*RVAR*K",k[i],sep=""))

tempCS <- c(tempCS,"ENDIF","","IF(EVID.GT.2.AND.SDE.EQ.3) THEN")
for(i in 1:compNo) tempCS <- c(tempCS,paste("  AHT",i," = A",i,sep=""))
for(i in 1:pNo)    tempCS <- c(tempCS,paste("  PHT",i," = 0",sep=""))

tempCS <- c(tempCS,"ENDIF","","IF(EVID.GT.2.AND.SDE.EQ.4) THEN")
for(i in 1:compNo) tempCS <- c(tempCS,paste("  AHT",i," = 0",sep=""))
for(i in 1:pNo)    tempCS <- c(tempCS,paste("  PHT",i," = A",i+compNo,sep=""))

tempCS <- c(tempCS,"ENDIF","","IF(A_0FLG.EQ.1) THEN")

for(i in 1:compNo) tempCS <- c(tempCS,paste("  A_0(",i,") = AHT",i,sep=""))
for(i in (compNo+1):(compNo+pNo)) tempCS <- c(tempCS,paste("  A_0(",i,") = PHT",i-compNo,sep=""))
tempCS <- c(tempCS,"ENDIF","")

#Write $DES
CSin[SIGWpos] <- gsub3("SGW[0-9]+","0",CSin[SIGWpos]) 
tempCS <- c(tempCS,CSin[desPos:(errorPos-1)])

#Insert P equations in $DES

k <- 1
for(i in 1:compNo){
	for(j in i:compNo){
		tempCS <- c(tempCS,paste("DADT(",compNo+k,") = ",paste("(",Amat[i,],")*(",Pmat[,j],")",collapse="+",sep=""),"+",paste("(",t(Amat[j,]),")*(",Pmat[,i],")",collapse="+",sep=""),sep=""))			

		if(sigmaW[i] & j==i) tempCS[length(tempCS)] <- paste(tempCS[length(tempCS)],"+SGW",i,"*SGW",i,sep="")
		tempCS[length(tempCS)] <- gsub2("\\+\\-","-",tempCS[length(tempCS)])
		tempCS[length(tempCS)] <- gsub2("\\-\\+","-",tempCS[length(tempCS)])
		tempCS[length(tempCS)] <- gsub2("\\^","**",tempCS[length(tempCS)])

		#Remove 0*x
		EqPos <- regexpr("=",tempCS[length(tempCS)])
		temp1 <- 1
		while(temp1!=-1){
			temp1 <- regexpr("(0)\\*",tempCS[length(tempCS)])[1]
			if(temp1!=-1){
				temp2 <- regexpr("[+-]",substring(tempCS[length(tempCS)],first=temp1))[1]
				if(temp2!=-1){
					if(temp1==(EqPos+1)){
						nterm <- substring(tempCS[length(tempCS)],temp1,temp1+temp2-1)
					}else{
						nterm <- substring(tempCS[length(tempCS)],temp1-1,temp1+temp2-2)
					}	
				}else{
					if(temp1==(EqPos+1)){
						nterm <- substring(tempCS[length(tempCS)],temp1)
					}else{
						nterm <- substring(tempCS[length(tempCS)],temp1-1)
					}
				}
				nterm <- gsub2("*","\\*",nterm)   
				nterm <- gsub2("+","\\+",nterm)   
				nterm <- gsub2("-","\\-",nterm)  

				tempCS[length(tempCS)] <- gsub2(nterm,"",tempCS[length(tempCS)])
				tempCS[length(tempCS)] <- gsub2("=\\+","=",tempCS[length(tempCS)])
			}
		}
					
		k <- k + 1
	}
}

#Insert $ERROR
tempCS <- c(tempCS,"",CSin[errorPos:(wPos-1)])
tempCS <- c(tempCS,paste("W=SQRT(A",compNo+phtNo,"*(",Cmat[1],")**2+",w,"**2)",sep=""))

for(i in 1:(compNo+pNo)) tempCS[length(tempCS)] <- gsub3(paste("A",i,sep=""),paste("A(",i,")",sep=""),tempCS[length(tempCS)])	

CSinNew <- CSin[-c(thetaPos,omegaPos,sigmaPos)]
errorPosNew <- grep("\\$ERROR",CSinNew)
wPosNew <- grep("W",CSinNew[errorPosNew:length(CSinNew)])[1]+errorPosNew-1
tempCS <- c(tempCS,CSinNew[(wPosNew+1):length(CSinNew)])
write.table(tempCS,file=paste(CS,"SDE",sep=""),row.names=F,col.names=F,quote=F)

#################################
###     Data file setup       ###
#################################
if(!is.null(data)){
	
data$ID <- as.character(data$ID)

if(!is.null(data$AMT)){
	data$AMT <- as.character(data$AMT)
	data$AMT[data$AMT=="."] <- 0
	data$AMT <- as.numeric(data$AMT)
}else{
	data$AMT <- rep(0,nrow(data))
}

if(is.null(data$CMT)){
	data$CMT <- rep(".",nrow(data))
}else{
   data$CMT <- as.character(data$CMT)
}

if(is.null(data$EVID)){
	data$EVID <- rep(0,nrow(data))
	data$EVID[data$AMT!=0] <- 1
}

if(is.null(data$MDV)){
	data$MDV <- rep(0,nrow(data))
	data$MDV[data$EVID==1 | data$DV==0 | data$DV=="."] <- 1
}

SDE <- data[data$EVID==0 & data$DV!=0 & data$DV!="." & data$MDV==0,]

N <- length(unique(SDE$ID))
ni <- numeric()
index <- 1
for (i in as.character(unique(SDE$ID))){
    ni[index] <- nrow(SDE[SDE$ID==i,])
    index <- index+1
}

if(!is.null(data$RATE)){
	SDE$RATE <- as.character(SDE$RATE)
	SDE$RATE[SDE$RATE=="."] <- "0"
	SDE$RATE <- as.numeric(SDE$RATE)
	Dose <- data[data$AMT!=0,]
	Dose$AMT <- as.numeric(Dose$AMT)
	Dose$RATE <- as.character(Dose$RATE)
	Dose$RATE[Dose$RATE=="."] <- "0"
	Dose$RATE <- as.numeric(Dose$RATE)
	SDE$EVID <- rep(4,length(SDE[,1]))
	SDE$DV <- rep(".",length(SDE[,1]))
	SDE$CMT <- rep(Dose$CMT,ni)
	SDE$RATE <- rep(Dose$RATE,ni)
	SDE$AMT <- rep(Dose$AMT,ni)-SDE$TIME*SDE$RATE
	SDE$RATE[SDE$TIME>=rep(Dose$AMT/Dose$RATE,ni)] <- "."
	SDE$AMT[SDE$TIME>=rep(Dose$AMT/Dose$RATE,ni)] <- "."
	SDE$EVID[SDE$TIME>=rep(Dose$AMT/Dose$RATE,ni)] <- 3
	SDE$CMT[SDE$TIME>=rep(Dose$AMT/Dose$RATE,ni)] <- "."
}else{
	SDE$EVID <- rep(3,length(SDE[,1]))
	SDE$DV   <- rep(".",length(SDE[,1]))
}

SDE$MDV <- rep(1,nrow(SDE))

SDE2 <- SDE
SDE2$EVID <- rep(2,length(SDE2[,1]))
if(!is.null(data$RATE))	SDE2$RATE <- rep(".",length(SDE2[,1]))
SDE2$AMT <- rep(".",length(SDE2[,1]))
SDE2$CMT <- rep(".",length(SDE2[,1]))

dataSDE <- rbind(data,SDE2,SDE)
dataSDE$SDE <- rep(1,nrow(dataSDE))
dataSDE$SDE[dataSDE$EVID==1] <- 0
dataSDE$SDE[dataSDE$EVID>1] <- 2

#R code
dataSDE <- dataSDE[order(dataSDE$ID,dataSDE$TIME,dataSDE$SDE,dataSDE$EVID),] 

#S-PLUS code
#dataSDE <- sort.col(dataSDE, "@ALL", c("ID","TIME","SDE","EVID"), ascending=T) 

SDEMB <- dataSDE[dataSDE$MDV==0,]

x <- match(unique(SDEMB$ID), SDEMB$ID) # takes the first row from each subject 

test1 <- SDEMB[x,] # takes the first row from each subject 
test2 <- SDEMB[x+1,]

DoseLines <- dataSDE[dataSDE$EVID==1,]
#DoseLines <- dataSDE[dataSDE$TIME==0 & dataSDE$EVID==1,]

N <- length(unique(DoseLines$ID))
if(N!=length(unique(data$ID))) print("All patients need a dose line")
	
ni <- numeric()
index <- 1
for (i in unique(DoseLines$ID)){
    ni[index] <- nrow(DoseLines[DoseLines$ID==i,])
    index <- index+1
}

NegLines <- DoseLines[match(unique(DoseLines$ID),DoseLines$ID),]
NegLines <- NegLines[(test1$TIME - (test2$TIME-test1$TIME))<0,]

NegLines$AMT <- rep(".",nrow(NegLines))
NegLines$CMT <- rep(".",nrow(NegLines))
NegLines$DV <- rep(".",nrow(NegLines))
NegLines$MDV <- rep(1,nrow(NegLines))
NegLines$EVID <- rep(2,nrow(NegLines))
NegLines$SDE <- rep(-1,nrow(NegLines))
NegLines2 <- NegLines
NegLines2$EVID <- rep(3,nrow(NegLines))

NegLinesExtra <- NegLines
NegLinesExtra$EVID <- rep(0,nrow(NegLinesExtra))

DoseLines$TIME <- rep(test1$TIME - (test2$TIME-test1$TIME),ni)
AddDoses <- DoseLines[DoseLines$TIME<0,]

PosLines <- DoseLines[match(unique(DoseLines$ID),DoseLines$ID),]
PosLines <- PosLines[PosLines$TIME>0,]
PosLines$AMT <- rep(".",nrow(PosLines))
PosLines$CMT <- rep(".",nrow(PosLines))
PosLines$DV <- rep(".",nrow(PosLines))
PosLines$MDV <- rep(1,nrow(PosLines))
PosLines$EVID <- rep(2,nrow(PosLines))
PosLines$SDE <- rep(3,nrow(PosLines))

PosLines2 <- PosLines
PosLines2$EVID <- rep(3,nrow(PosLines2))


dataSDEMB <- rbind(AddDoses,NegLines,NegLines2,NegLinesExtra,PosLines,PosLines2,dataSDE)

#R code
dataSDEMB <- dataSDEMB[order(dataSDEMB$ID,dataSDEMB$TIME,dataSDEMB$SDE,dataSDEMB$EVID),] 

#S-PLUS code
#dataSDEMB <- sort.col(dataSDEMB, "@ALL", c("ID","TIME","SDE","EVID"), ascending=T) 


testPos <- test1$TIME-(test2$TIME-test1$TIME)

N <- length(unique(dataSDEMB$ID))

ni <- numeric()
index <- 1
for (i in unique(dataSDEMB$ID)){
    ni[index] <- nrow(dataSDEMB[dataSDEMB$ID==i,])
    index <- index+1
}

dataSDEMB$NTIME <- dataSDEMB$TIME
NewTime <- rep(testPos,ni)
dataSDEMB$NTIME[rep(testPos,ni)<0] <- dataSDEMB$TIME[rep(testPos,ni)<0] - NewTime[NewTime<0]
dataSDEMB$SDE[dataSDEMB$SDE==-1] <- 4

write.table(format(dataSDEMB), file=paste(datafile,"SDE",sep=""),sep=",", quote=F,row.names=F)
}
}



