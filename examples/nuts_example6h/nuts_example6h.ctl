;$SIZES ISAMPLEMAX=30
;Model Desc: Receptor Mediated Clearance model with Dynamic Change 
;            in Receptors
;Project Name: nm7examples
;Project ID: NO PROJECT DESCRIPTION

$PROB RUN# example6 (from r2compl)
$ABBR DERIV2=NO
$INPUT C SET ID JID TIME DV=CONC DOSE=AMT RATE EVID MDV CMT
$DATA example6.csv IGNORE=C

; The new numerical integration solver is used, although ADVAN=9 
; is also efficient for this problem.

$SUBROUTINES ADVAN13 TRANS1 TOL=4
$MODEL NCOMPARTMENTS=3

$PK
include c:\nm75g64\util\nonmem_reserved_general
; MUFIRSTREC=1 calls MU reference evaluation only once per individual, saving time
MUFIRSTREC=1
; OBJQUICK=2 uses faster evaluation of model, can be used for simple models.
OBJQUICK=2
MU_1=THETA(1)
MU_2=THETA(2)
MU_3=THETA(3)
MU_4=THETA(4)
MU_5=THETA(5)
MU_6=THETA(6)
MU_7=THETA(7)
MU_8=THETA(8)
VC=EXP(MU_1+ETA(1))
K10=EXP(MU_2+ETA(2))
K12=EXP(MU_3+ETA(3))
K21=EXP(MU_4+ETA(4))
VM=EXP(MU_5+ETA(5))
KMC=EXP(MU_6+ETA(6))
K03=EXP(MU_7+ETA(7))
K30=EXP(MU_8+ETA(8))
S3=VC
S1=VC
KM=KMC*S1
F3=K03/K30

$DES
DADT(1) = -(K10+K12)*A(1) + K21*A(2) - VM*A(1)*A(3)/(A(1)+KM)
DADT(2) = K12*A(1) - K21*A(2)
DADT(3) =  -(VM-K30)*A(1)*A(3)/(A(1)+KM) - K30*A(3) + K03

$ERROR
CALLFL=0
ETYPE=1
IF(CMT.NE.1) ETYPE=0
IPRED=F
Y = F + F*ETYPE*EPS(1) + F*(1.0-ETYPE)*EPS(2)


$THETA 
;Initial Thetas
( 4.0 )  ;[MU_1]
( -2.1 ) ;[MU_2]
( 0.7 )  ;[MU_3]
( -0.17 );[MU_4]      
( 2.2 ) ;[MU_5]
( 0.14 )  ;[MU_6]
( 3.7 )  ;[MU_7]
( -0.7) ;[MU_8]


;Initial Omegas
$OMEGA BLOCK(8) VALUES(0.1,0.01)

$SIGMA  
0.02 ;[p]
0.02;[p]

$PRIOR NWPRI
; Omega prior
$OMEGAP BLOCK(8)
0.2 FIX
0.0 0.2
0.0 0.0 0.2
0.0 0.0 0.0 0.2
0.0 0.0 0.0 0.0 0.2
0.0 0.0 0.0 0.0 0.0 0.2
0.0 0.0 0.0 0.0 0.0 0.0 0.2
0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.2
; degrees of freedom for OMEGA prior
$OMEGAPD
(8 FIXED)           ;[dfo]

; Starting with a short iterative two stage analysis brings the 
; results closer so less time needs to be spent during the 
; burn-in of the BAYES analysis


$EST METHOD=ITS INTERACTION SIGL=4 NITER=15 PRINT=1 NOABORT NOPRIOR=1 file=nuts_example6_itsh.ext
$EST METHOD=bayes INTERACTION NBURN=200 NITER=0 PRINT=10 MASSRESET=1 NOPRIOR=0 file=nuts_example6_bayesh.ext
$EST METHOD=NUTS INTERACTION  NBURN=100 NUTS_BASE=20 NITER=200 PRINT=1 MASSRESET=0 PMADAPT=100  file=nuts_example6h.ext

;$EST METHOD=ITS INTERACTION NITER=25 NOABORT NOPRIOR=1 PRINT=1 SIGL=4 file=nuts_example6_its.ext
;$EST METHOD=NUTS AUTO=1 PRINT=1 NITER=1000 NOPRIOR=0 NUTS_INIT=5 file=nuts_example6.ext ; OLKJDF=5.0  SLKJDF=2.0

$COV MATRIX=R UNCONDITIONAL
