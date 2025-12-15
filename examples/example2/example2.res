Wed 01/25/2023 
09:28 AM
;Model Desc: Two Compartment model with Clearance and 
; central volume modeled with covariates age and gender
;Project Name: nm7examples
;Project ID: NO PROJECT DESCRIPTION

$PROB RUN# example2 (from sampc)
$INPUT C SET ID JID TIME DV=CONC AMT=DOSE RATE EVID MDV CMT GNDR AGE
$DATA example2.csv IGNORE=C
$SUBROUTINES ADVAN3 TRANS4

$PK
; LCLM=log transformed clearance, male
LCLM=THETA(1)
;LCLF=log transformed clearance, female.
LCLF=THETA(2)
; CLAM=CL age slope, male
CLAM=THETA(3)
; CLAF=CL age slope, female
CLAF=THETA(4)
; LV1M=log transformed V1, male
LV1M=THETA(5)
; LV1F=log transformed V1, female
LV1F=THETA(6)
; V1AM=V1 age slope, male
V1AM=THETA(7)
; V1AF=V1 age slope, female
V1AF=THETA(8)
; LAGE=log transformed age
LAGE=DLOG(AGE)

;Mean of ETA1, the inter-subject deviation of Clearance,
; is ultimately modeled as linear function of THETA(1) to THETA(4).  
; Relating thetas to Mus by linear functions is not essential for 
; ITS, IMP, or IMPMAP methods, but is very helpful for MCMC methods 
; such as SAEM and BAYES.

MU_1=(1.0-GNDR)*(LCLM+LAGE*CLAM) + GNDR*(LCLF+LAGE*CLAF)

; Mean of ETA2, the inter-subject deviation of V1, 
; is ultimately modeled as linear function of THETA(5) to THETA(8)

MU_2=(1.0-GNDR)*(LV1M+LAGE*V1AM) + GNDR*(LV1F+LAGE*V1AF)
MU_3=THETA(9)
MU_4=THETA(10)
CL=DEXP(MU_1+ETA(1))
V1=DEXP(MU_2+ETA(2))
Q=DEXP(MU_3+ETA(3))
V2=DEXP(MU_4+ETA(4))
S1=V1

$ERROR
CALLFL=0
; Option to model the residual error coefficient in THETA(11), 
; rather than in SIGMA.
SDSL=THETA(11)
W=F*SDSL
Y = F + W*EPS(1)
IPRED=F
IWRES=(DV-F)/W

;Initial THETAs
$THETA
( 0.7 ) ;[LCLM]
( 0.7 ) ;[LCLF]
( 2 )   ;[CLAM]
( 2.0);[CLAF]
( 0.7 ) ;[LV1M]
( 0.7 ) ;[LV1F]
( 2.0 )   ;[V1AM]
( 2.0 )   ;[V1AF]
( 0.7 ) ;[MU_3]
(  0.7 );[MU_4]
(0.01, 0.3 )     ;[SDSL]

;Initial OMEGAs
$OMEGA BLOCK(4)
0.5  ;[p]
0.001  ;[f]
0.5  ;[p]
0.001 ;[f]
0.001 ;[f]
0.5  ;[p]
0.001 ;[f]
0.001 ;[f]
0.001 ;[f]
0.5 ;[p]

; SIGMA is 1.0 fixed, serves as unscaled variance for EPS(1).  
; THETA(11) takes up the residual error scaling.
$SIGMA 
(1.0 FIXED)

;Prior information is important for MCMC Bayesian analysis, 
; not necessary for maximization methods
; In this example, only the OMEGAs have a prior distribution,
; the THETAS do not.
; For Bayesian methods, it is most important for at least the 
; OMEGAs to have a prior, even an uninformative one, 
; to stabilize the analysis. Only if the number of subjects
; exceeds the OMEGA dimension number by at least 100, 
; then you may get away without priors on OMEGA for BAYES analysis.
$PRIOR NWPRI
; Prior OMEGA matrix
$OMEGAP BLOCK(4) FIX VALUES(0.01,0.0)
; Degrees of freedom to OMEGA prior matrix:
$OMEGAPD 4 FIX

; The first analysis is iterative two-stage.  
; Note that the GRD specification is THETA(11) is a 
; Sigma-like parameter.  This will allow NONMEM to make
; efficient gradient evaluations for THETA(11), which is useful 
; for later IMP,IMPMAP, and SAEM methods, but has no impact on 
; ITS and BAYES methods.

$EST METHOD=ITS INTERACTION FILE=example2.ext NITER=1000 NSIG=2 
     PRINT=5 NOABORT SIGL=8 NOPRIOR=1 CTYPE=3 GRD=TS(11)

; Results of ITS serve as initial parameters for the IMP method.

$EST METHOD=IMP INTERACTION EONLY=0 MAPITER=0 NITER=100 ISAMPLE=300 
     PRINT=1 SIGL=8

; The results of IMP are used as the initial values for the SAEM method.

$EST METHOD=SAEM NBURN=3000 NITER=300 PRINT=10 ISAMPLE=2
     CTYPE=3 CITER=10 CALPHA=0.05

; After the SAEM method, obtain good estimates of the marginal density 
; (objective function),
; along with good estimates of the standard errors.

$EST METHOD=IMP INTERACTION EONLY=1 NITER=5 ISAMPLE=3000 
     PRINT=1 SIGL=8 SEED=123334
     CTYPE=3 CITER=10 CALPHA=0.05

; The Bayesian analysis is performed. 

$EST METHOD=BAYES INTERACTION FILE=example2.TXT NBURN=10000 
     NITER=3000 PRINT=100 NOPRIOR=0
     CTYPE=3 CITER=10 CALPHA=0.05

; Just for old-times sake, lets see what the traditional 
; FOCE method will give us.  
; And, remember to introduce a new FILE, so its results wont 
; append to our Bayesian FILE.

$EST  METHOD=COND INTERACTION MAXEVAL=9999 FILE=example2.ext NSIG=2 
  SIGL=14 PRINT=5 NOABORT NOPRIOR=1

$COV MATRIX=R UNCONDITIONAL
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.

 (MU_WARNING 26) DATA ITEM(S) USED IN DEFINITION OF MU_(S) SHOULD BE CONSTANT FOR INDIV. REC.:
  GNDR AGE
  
Note: Analytical 2nd Derivatives are constructed in FSUBS but are never used.
      You may insert $ABBR DERIV2=NO after the first $PROB to save FSUBS construction and compilation time
  
  
License Registered to: NONMEM license (with RADAR5NM) for ICON Pharmacometrics Team
Expiration Date:    31 DEC 2030
Current Date:       25 JAN 2023
Days until program expires :2891
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.1
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 RUN# example2 (from sampc)
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:     2400
 NO. OF DATA ITEMS IN DATA SET:  13
 ID DATA ITEM IS DATA ITEM NO.:   3
 DEP VARIABLE IS DATA ITEM NO.:   6
 MDV DATA ITEM IS DATA ITEM NO.: 10
0INDICES PASSED TO SUBROUTINE PRED:
   9   5   7   8   0   0  11   0   0   0   0
0LABELS FOR DATA ITEMS:
 C SET ID JID TIME CONC DOSE RATE EVID MDV CMT GNDR AGE
0FORMAT FOR DATA:
 (2E2.0,3E4.0,E11.0,E4.0,5E2.0,E6.0)

 TOT. NO. OF OBS RECS:     2000
 TOT. NO. OF INDIVIDUALS:      400
0LENGTH OF THETA:  12
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS BLOCK FORM:
  1
  1  1
  1  1  1
  1  1  1  1
  0  0  0  0  2
  0  0  0  0  2  2
  0  0  0  0  2  2  2
  0  0  0  0  2  2  2  2
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
 -0.1000E+07     0.7000E+00     0.1000E+07
 -0.1000E+07     0.7000E+00     0.1000E+07
 -0.1000E+07     0.2000E+01     0.1000E+07
 -0.1000E+07     0.2000E+01     0.1000E+07
 -0.1000E+07     0.7000E+00     0.1000E+07
 -0.1000E+07     0.7000E+00     0.1000E+07
 -0.1000E+07     0.2000E+01     0.1000E+07
 -0.1000E+07     0.2000E+01     0.1000E+07
 -0.1000E+07     0.7000E+00     0.1000E+07
 -0.1000E+07     0.7000E+00     0.1000E+07
  0.1000E-01     0.3000E+00     0.1000E+07
  0.4000E+01     0.4000E+01     0.4000E+01
0INITIAL ESTIMATE OF OMEGA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.5000E+00
                  0.1000E-02   0.5000E+00
                  0.1000E-02   0.1000E-02   0.5000E+00
                  0.1000E-02   0.1000E-02   0.1000E-02   0.5000E+00
        2                                                                                  YES
                  0.1000E-01
                  0.0000E+00   0.1000E-01
                  0.0000E+00   0.0000E+00   0.1000E-01
                  0.0000E+00   0.0000E+00   0.0000E+00   0.1000E-01
0INITIAL ESTIMATE OF SIGMA:
 0.1000E+01
0SIGMA CONSTRAINED TO BE THIS INITIAL ESTIMATE
0COVARIANCE STEP OMITTED:        NO
 R MATRIX SUBSTITUTED:          YES
 S MATRIX SUBSTITUTED:           NO
 EIGENVLS. PRINTED:              NO
 COMPRESSED FORMAT:              NO
 GRADIENT METHOD USED:     NOSLOW
 SIGDIGITS ETAHAT (SIGLO):                  -1
 SIGDIGITS GRADIENTS (SIGL):                -1
 EXCLUDE COV FOR FOCE (NOFCOV):              NO
 Cholesky Transposition of R Matrix (CHOLROFF):0
 KNUTHSUMOFF:                                -1
 RESUME COV ANALYSIS (RESUME):               NO
 SIR SAMPLE SIZE (SIRSAMPLE):
 NON-LINEARLY TRANSFORM THETAS DURING COV (THBND): 1
 PRECONDTIONING CYCLES (PRECOND):        0
 PRECONDTIONING TYPES (PRECONDS):        TOS
 FORCED PRECONDTIONING CYCLES (PFCOND):0
 PRECONDTIONING TYPE (PRETYPE):        0
 FORCED POS. DEFINITE SETTING DURING PRECONDITIONING: (FPOSDEF):0
 SIMPLE POS. DEFINITE SETTING: (POSDEF):-1
0
 PRIOR SUBROUTINE USER-SUPPLIED
1DOUBLE PRECISION PREDPP VERSION 7.5.1

 TWO COMPARTMENT MODEL (ADVAN3)
0MAXIMUM NO. OF BASIC PK PARAMETERS:   4
0BASIC PK PARAMETERS (AFTER TRANSLATION):
   BASIC PK PARAMETER NO.  1: ELIMINATION RATE (K)
   BASIC PK PARAMETER NO.  2: CENTRAL-TO-PERIPH. RATE (K12)
   BASIC PK PARAMETER NO.  3: PERIPH.-TO-CENTRAL RATE (K21)
 TRANSLATOR WILL CONVERT PARAMETERS
 CL, V1, Q, V2 TO K, K12, K21 (TRANS4)
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         CENTRAL      ON         NO         YES        YES        YES
    2         PERIPH.      ON         NO         YES        NO         NO
    3         OUTPUT       OFF        YES        NO         NO         NO
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            5           *           *           *           *
    2            *           *           *           *           *
    3            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      9
   TIME DATA ITEM IS DATA ITEM NO.:          5
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   7
   DOSE RATE DATA ITEM IS DATA ITEM NO.:     8
   COMPT. NO. DATA ITEM IS DATA ITEM NO.:   11

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0DURING SIMULATION, ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 OTHERWISE, ERROR SUBROUTINE CALLED ONLY WITH OBSERVATION EVENTS.
1


 #TBLN:      1
 #METH: Iterative Two Stage (No Prior)

 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            2208
 NO. OF SIG. FIGURES REQUIRED:            2
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    0
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      8
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     8
 NOPRIOR SETTING (NOPRIOR):                 1
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): example2.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 EM OR BAYESIAN METHOD USED:                ITERATIVE TWO STAGE (ITS)
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):              DDDDDDDDDDS
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          5
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 ITERATIONS (NITER):                        1000
 ANNEAL SETTING (CONSTRAIN):                 1


 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI

 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2   3   4   5   6   7   8   9  10
 THETAS THAT ARE SIGMA-LIKE:
  11

 MONITORING OF SEARCH:

 iteration            0  OBJ=   43391.704883333237
 iteration            5  OBJ=  -10716.826709530133
 iteration           10  OBJ=  -10763.167380316625
 iteration           15  OBJ=  -10768.828282524855
 iteration           20  OBJ=  -10770.460829990696
 iteration           25  OBJ=  -10771.125661699838
 iteration           30  OBJ=  -10771.449056684860
 iteration           35  OBJ=  -10771.622729299399
 iteration           40  OBJ=  -10771.721664289644
 iteration           45  OBJ=  -10771.780117524921
 iteration           50  OBJ=  -10771.815405472742
 iteration           55  OBJ=  -10771.836920606125
 iteration           60  OBJ=  -10771.850020755499
 iteration           65  OBJ=  -10771.857881497777
 iteration           70  OBJ=  -10771.862445593169
 iteration           75  OBJ=  -10771.864924524445
 iteration           80  OBJ=  -10771.866089966477
 iteration           85  OBJ=  -10771.866436703702
 iteration           90  OBJ=  -10771.866285803058
 iteration           95  OBJ=  -10771.865844908360
 iteration          100  OBJ=  -10771.865248851813
 iteration          105  OBJ=  -10771.864584619856
 iteration          110  OBJ=  -10771.863905849059
 iteration          115  OBJ=  -10771.863245870973
 iteration          120  OBJ=  -10771.862625062435
 iteration          125  OBJ=  -10771.862052591823
 iteration          130  OBJ=  -10771.861532833183
 iteration          135  OBJ=  -10771.861066306778
 iteration          140  OBJ=  -10771.860651360876
 iteration          145  OBJ=  -10771.860284319098
 iteration          150  OBJ=  -10771.859961894395
 iteration          155  OBJ=  -10771.859679685585
 iteration          160  OBJ=  -10771.859433329739
 iteration          165  OBJ=  -10771.859218910829
 iteration          170  OBJ=  -10771.859032926721
 iteration          175  OBJ=  -10771.858871945919
 iteration          180  OBJ=  -10771.858732846420
 iteration          185  OBJ=  -10771.858612286604
 iteration          190  OBJ=  -10771.858508503034
 iteration          195  OBJ=  -10771.858418906044
 iteration          200  OBJ=  -10771.858341573396
 Convergence achieved

 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.

 ETABAR:        -4.1683E-08 -5.9017E-08 -1.1047E-07 -1.0157E-07
 SE:             4.7106E-03  2.9771E-03  2.9246E-03  3.6831E-03
 N:                     400         400         400         400

 P VAL.:         9.9999E-01  9.9998E-01  9.9997E-01  9.9998E-01

 ETASHRINKSD(%)  6.9160E+00  3.3019E+01  4.1116E+01  2.5038E+01
 ETASHRINKVR(%)  1.3354E+01  5.5135E+01  6.5326E+01  4.3807E+01
 EBVSHRINKSD(%)  6.9159E+00  3.3019E+01  4.1114E+01  2.5037E+01
 EBVSHRINKVR(%)  1.3354E+01  5.5135E+01  6.5324E+01  4.3806E+01
 RELATIVEINF(%)  7.7675E+01  4.1768E+01  2.7824E+01  4.1730E+01
 EPSSHRINKSD(%)  2.6119E+01
 EPSSHRINKVR(%)  4.5416E+01

  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         2000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    3675.7541328186908     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -10771.858341573396     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -7096.1042087547048     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          1600
  
 #TERE:
 Elapsed estimation  time in seconds:    20.42
 Elapsed covariance  time in seconds:     0.17
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -10771.858       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11     
 
         3.30E+00  3.26E+00 -6.11E-01 -2.08E-01  7.29E-01  1.14E+00  3.37E-01  1.92E-01  6.92E-01  2.30E+00  1.00E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        1.02E-02
 
 ETA2
+        1.53E-04  7.90E-03
 
 ETA3
+        1.18E-03 -3.76E-04  9.87E-03
 
 ETA4
+       -6.46E-04  4.42E-04  1.95E-03  9.66E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        1.01E-01
 
 ETA2
+        1.70E-02  8.89E-02
 
 ETA3
+        1.17E-01 -4.26E-02  9.93E-02
 
 ETA4
+       -6.50E-02  5.06E-02  2.00E-01  9.83E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                          STANDARD ERROR OF ESTIMATE (S)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11     
 
         3.79E-02  2.88E-02  1.11E-02  8.40E-03  4.82E-02  4.09E-02  1.34E-02  1.18E-02  1.05E-02  8.92E-03  2.99E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        1.00E-03
 
 ETA2
+        8.63E-04  1.49E-03
 
 ETA3
+        1.29E-03  1.43E-03  2.82E-03
 
 ETA4
+        1.12E-03  1.15E-03  1.98E-03  2.00E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        0.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        4.96E-03
 
 ETA2
+        9.50E-02  8.40E-03
 
 ETA3
+        1.21E-01  1.66E-01  1.42E-02
 
 ETA4
+        1.16E-01  1.28E-01  1.65E-01  1.02E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+       .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (S)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        1.44E-03
 
 TH 2
+        3.16E-06  8.28E-04
 
 TH 3
+       -4.10E-04  1.27E-06  1.22E-04
 
 TH 4
+       -4.26E-07 -2.31E-04 -1.24E-07  7.06E-05
 
 TH 5
+        6.37E-04  5.15E-05 -1.66E-04 -4.22E-06  2.33E-03
 
 TH 6
+       -1.85E-05  2.12E-04  6.18E-06 -5.18E-05  2.29E-05  1.67E-03
 
 TH 7
+       -1.66E-04 -1.54E-05  4.37E-05  1.60E-06 -6.32E-04 -9.98E-06  1.79E-04
 
 TH 8
+        6.08E-06 -5.22E-05 -1.62E-06  1.47E-05  3.97E-06 -4.68E-04 -6.15E-08  1.40E-04
 
 TH 9
+        1.76E-05  5.99E-05 -1.33E-07 -9.14E-06  1.15E-04  5.08E-05 -3.25E-05 -7.07E-06  1.10E-04
 
 TH10
+        1.39E-05  3.68E-05 -9.36E-08 -4.77E-06  1.07E-04  4.83E-05 -2.96E-05 -5.45E-06  6.57E-05  7.96E-05
 
 TH11
+       -7.57E-06 -3.62E-06  2.68E-06  1.28E-06 -8.73E-06  7.26E-07  2.49E-06 -7.66E-08  1.72E-06  1.46E-06  8.94E-06
 
 OM11
+        4.12E-06 -1.54E-07 -1.32E-06 -1.72E-07  1.27E-06  2.51E-07 -4.56E-07 -4.18E-08 -3.90E-07  1.26E-07 -4.29E-07  1.01E-06
 
 OM12
+        1.54E-06  1.60E-07 -6.64E-07 -5.05E-08  1.88E-06  7.39E-07 -3.71E-07  1.51E-08 -1.55E-07  3.36E-07 -5.64E-07  3.66E-07
          7.45E-07
 
 OM13
+        4.79E-07  1.83E-06 -4.23E-07 -5.80E-07  2.01E-06  4.11E-08 -5.63E-07  5.08E-08  7.48E-07  6.62E-07 -5.21E-07  5.31E-07
          3.31E-07  1.66E-06
 
 OM14
+        1.94E-06 -4.51E-07 -7.42E-07  2.93E-07  6.06E-06 -1.74E-07 -1.51E-06  1.34E-07  7.63E-07  9.25E-07 -3.45E-07  4.30E-07
          2.94E-07  1.03E-06  1.24E-06
 
 OM22
+        3.80E-06  6.65E-07 -1.07E-06 -8.81E-08  5.37E-06 -7.09E-06 -7.25E-07  2.12E-06 -3.23E-08 -4.76E-08 -1.08E-06  9.01E-08
          4.63E-07  6.30E-08  1.47E-07  2.23E-06
 
 OM23
+        3.07E-07  5.64E-07 -2.33E-07 -2.86E-07 -4.84E-07  1.27E-06  1.96E-07 -6.66E-08 -6.83E-07 -3.44E-07 -6.93E-07  2.97E-07
          4.24E-07  7.82E-07  5.02E-07  5.27E-07  2.06E-06
 
 OM24
+        2.54E-06 -3.94E-07 -6.50E-07  7.00E-08  4.96E-06 -2.15E-06 -1.24E-06  9.47E-07 -3.34E-08  8.15E-07 -3.67E-07  1.96E-07
          3.55E-07  4.62E-07  5.23E-07  5.18E-07  1.12E-06  1.33E-06
 
 OM33
+        4.38E-06  1.65E-06 -1.33E-06 -4.41E-07  1.01E-05 -5.16E-06 -2.94E-06  1.15E-06 -1.26E-06 -1.09E-06 -3.19E-06  4.44E-07
          4.59E-07  1.28E-06  6.61E-07  2.92E-07  1.53E-06  7.05E-07  7.97E-06
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+        3.02E-06  2.73E-06 -9.62E-07 -7.23E-07  7.78E-06  2.22E-06 -2.43E-06 -5.46E-07 -2.77E-07  4.36E-07 -2.30E-06  4.17E-07
          3.93E-07  9.02E-07  8.44E-07  2.26E-07  1.21E-06  7.89E-07  4.53E-06  3.93E-06
 
 OM44
+       -1.44E-07  3.52E-06 -2.63E-08 -7.28E-07  8.55E-06  5.81E-06 -2.63E-06 -1.05E-06  1.19E-06  3.19E-06 -1.84E-06  4.12E-07
          3.76E-07  7.34E-07  9.61E-07  9.62E-08  8.18E-07  9.43E-07  2.40E-06  3.04E-06  3.98E-06
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (S)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        3.79E-02
 
 TH 2
+        2.90E-03  2.88E-02
 
 TH 3
+       -9.77E-01  3.98E-03  1.11E-02
 
 TH 4
+       -1.34E-03 -9.55E-01 -1.34E-03  8.40E-03
 
 TH 5
+        3.48E-01  3.71E-02 -3.11E-01 -1.04E-02  4.82E-02
 
 TH 6
+       -1.19E-02  1.80E-01  1.36E-02 -1.51E-01  1.16E-02  4.09E-02
 
 TH 7
+       -3.28E-01 -4.00E-02  2.95E-01  1.42E-02 -9.79E-01 -1.82E-02  1.34E-02
 
 TH 8
+        1.36E-02 -1.54E-01 -1.24E-02  1.48E-01  6.96E-03 -9.68E-01 -3.89E-04  1.18E-02
 
 TH 9
+        4.41E-02  1.98E-01 -1.14E-03 -1.04E-01  2.28E-01  1.18E-01 -2.31E-01 -5.70E-02  1.05E-02
 
 TH10
+        4.09E-02  1.43E-01 -9.48E-04 -6.37E-02  2.49E-01  1.32E-01 -2.48E-01 -5.17E-02  7.02E-01  8.92E-03
 
 TH11
+       -6.68E-02 -4.21E-02  8.09E-02  5.09E-02 -6.05E-02  5.94E-03  6.22E-02 -2.17E-03  5.48E-02  5.48E-02  2.99E-03
 
 OM11
+        1.08E-01 -5.32E-03 -1.19E-01 -2.03E-02  2.63E-02  6.11E-03 -3.39E-02 -3.52E-03 -3.70E-02  1.40E-02 -1.43E-01  1.00E-03
 
 OM12
+        4.69E-02  6.45E-03 -6.95E-02 -6.97E-03  4.52E-02  2.09E-02 -3.22E-02  1.48E-03 -1.71E-02  4.37E-02 -2.19E-01  4.23E-01
          8.63E-04
 
 OM13
+        9.79E-03  4.94E-02 -2.96E-02 -5.35E-02  3.23E-02  7.79E-04 -3.27E-02  3.33E-03  5.53E-02  5.75E-02 -1.35E-01  4.10E-01
          2.97E-01  1.29E-03
 
 OM14
+        4.58E-02 -1.40E-02 -6.01E-02  3.13E-02  1.13E-01 -3.81E-03 -1.01E-01  1.02E-02  6.52E-02  9.30E-02 -1.03E-01  3.84E-01
          3.06E-01  7.15E-01  1.12E-03
 
 OM22
+        6.71E-02  1.55E-02 -6.46E-02 -7.02E-03  7.46E-02 -1.16E-01 -3.63E-02  1.20E-01 -2.06E-03 -3.58E-03 -2.42E-01  6.01E-02
          3.60E-01  3.27E-02  8.85E-02  1.49E-03
 
 OM23
+        5.64E-03  1.37E-02 -1.47E-02 -2.37E-02 -6.99E-03  2.16E-02  1.02E-02 -3.93E-03 -4.54E-02 -2.69E-02 -1.61E-01  2.06E-01
          3.43E-01  4.22E-01  3.14E-01  2.46E-01  1.43E-03
 
 OM24
+        5.80E-02 -1.19E-02 -5.10E-02  7.23E-03  8.93E-02 -4.57E-02 -8.03E-02  6.95E-02 -2.76E-03  7.93E-02 -1.07E-01  1.69E-01
          3.57E-01  3.11E-01  4.07E-01  3.01E-01  6.76E-01  1.15E-03
 
 OM33
+        4.09E-02  2.03E-02 -4.26E-02 -1.86E-02  7.42E-02 -4.47E-02 -7.80E-02  3.45E-02 -4.23E-02 -4.33E-02 -3.78E-01  1.57E-01
          1.89E-01  3.53E-01  2.10E-01  6.93E-02  3.78E-01  2.17E-01  2.82E-03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+        4.02E-02  4.80E-02 -4.39E-02 -4.35E-02  8.14E-02  2.74E-02 -9.15E-02 -2.33E-02 -1.33E-02  2.47E-02 -3.89E-01  2.10E-01
          2.30E-01  3.53E-01  3.82E-01  7.64E-02  4.24E-01  3.45E-01  8.10E-01  1.98E-03
 
 OM44
+       -1.90E-03  6.14E-02 -1.19E-03 -4.34E-02  8.88E-02  7.12E-02 -9.84E-02 -4.45E-02  5.67E-02  1.79E-01 -3.09E-01  2.05E-01
          2.18E-01  2.85E-01  4.32E-01  3.23E-02  2.86E-01  4.10E-01  4.27E-01  7.68E-01  2.00E-03
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (S)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        1.72E+04
 
 TH 2
+        0.00E+00  1.72E+04
 
 TH 3
+        5.70E+04  0.00E+00  1.98E+05
 
 TH 4
+        0.00E+00  5.58E+04  0.00E+00  1.96E+05
 
 TH 5
+       -1.95E+03  0.00E+00 -5.24E+03  0.00E+00  1.16E+04
 
 TH 6
+        0.00E+00 -3.70E+03  0.00E+00 -1.19E+04  0.00E+00  1.16E+04
 
 TH 7
+       -5.24E+03  0.00E+00 -1.54E+04  0.00E+00  4.03E+04  0.00E+00  1.47E+05
 
 TH 8
+        0.00E+00 -1.19E+04  0.00E+00 -3.99E+04  0.00E+00  3.85E+04  0.00E+00  1.35E+05
 
 TH 9
+       -1.69E+03 -3.57E+03 -5.82E+03 -1.02E+04  5.64E+02  8.51E+01  2.83E+03  4.39E+02  1.96E+04
 
 TH10
+       -1.08E+03 -1.21E+02 -4.09E+03 -7.31E+02 -6.82E+02 -3.31E+03 -8.55E+02 -1.07E+04 -1.50E+04  2.83E+04
 
 TH11
+       -1.98E+03 -1.32E+03 -8.56E+03 -5.90E+03 -1.10E+03  2.04E+02 -4.99E+03  1.34E+02  2.83E+02 -3.92E+03  1.49E+05
 
 OM11
+       -1.03E+04  1.38E+04 -2.15E+04  4.71E+04  1.00E+04 -4.11E+02  3.32E+04 -2.49E+03  7.74E+03 -4.83E+03  1.70E+04  1.44E+06
 
 OM12
+        2.10E+04 -5.21E+02  6.96E+04 -4.16E+03 -5.37E+03 -1.18E+04 -1.89E+04 -3.30E+04  5.66E+03 -9.07E+03  3.84E+04 -5.91E+05
          2.11E+06
 
 OM13
+        7.66E+03  9.78E+03  2.39E+04  4.91E+04  6.20E+03 -1.44E+03  1.68E+04 -6.37E+03 -8.84E+03 -4.49E+03  6.11E+03 -2.44E+05
         -3.81E+04  1.68E+06
 
 OM14
+        8.96E+03 -1.87E+04  2.96E+04 -8.29E+04 -1.84E+04  1.03E+04 -5.48E+04  3.38E+04 -5.00E+03  8.32E+03 -3.11E+04 -2.02E+05
         -6.74E+04 -1.31E+06  2.30E+06
 
 OM22
+       -1.88E+03 -5.88E+03 -6.01E+03 -1.65E+04 -1.39E+04  4.63E+03 -4.87E+04  7.38E+03 -2.52E+03  8.78E+02  7.01E+04  5.94E+04
         -3.20E+05  9.13E+04 -2.92E+04  6.21E+05
 
 OM23
+        6.94E+03 -1.32E+00  1.94E+04 -1.38E+03 -1.07E+02 -8.86E+03 -5.65E+03 -2.16E+04 -1.20E+03  9.30E+03 -2.36E+03 -2.50E+04
         -8.61E+04 -4.09E+05  3.14E+05 -4.78E+04  1.21E+06
 
 OM24
+       -1.79E+04  1.14E+04 -5.39E+04  3.75E+04  3.40E+03 -6.15E+02  1.72E+04 -1.33E+04  8.94E+03 -1.07E+04 -4.75E+04  1.35E+05
         -2.15E+05  2.47E+05 -4.89E+05 -1.74E+05 -9.42E+05  1.90E+06
 
 OM33
+       -1.13E+03 -7.05E+03 -6.39E+03 -2.77E+04 -5.55E+03  5.34E+03 -1.62E+04  1.23E+04  3.59E+03 -4.49E+03  4.17E+04  2.05E+04
         -4.05E+04 -2.80E+05  3.00E+05  3.49E+04  3.09E+04 -4.79E+04  5.74E+05
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+       -6.42E+03  8.83E+03 -1.31E+04  3.63E+04  1.14E+04 -9.93E+02  3.88E+04  3.03E+03 -9.11E+03  2.48E+04  6.07E+02 -2.10E+03
          5.16E+04  3.43E+05 -4.63E+05 -5.20E+04 -3.74E+05  3.17E+05 -9.10E+05  2.26E+06
 
 OM44
+        6.12E+03 -5.91E+03  1.24E+04 -1.85E+04 -1.55E+03 -4.65E+03 -5.38E+03 -1.46E+04  1.26E+04 -3.26E+04  5.62E+04 -3.26E+04
         -2.11E+04 -2.45E+04 -8.24E+04  9.64E+04  2.47E+05 -4.04E+05  3.52E+05 -1.14E+06  1.03E+06
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1


 #TBLN:      2
 #METH: Importance Sampling (No Prior)

 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            2208
 NO. OF SIG. FIGURES REQUIRED:            2
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    0
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      8
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     8
 NOPRIOR SETTING (NOPRIOR):                 1
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): example2.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 EM OR BAYESIAN METHOD USED:                IMPORTANCE SAMPLING (IMP)
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):              DDDDDDDDDDS
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          1
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 ITERATIONS (NITER):                        100
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
 MC SAMPLES PER SUBJECT (ISAMPLE):          300
 RANDOM SAMPLING METHOD (RANMETHOD):        3U
 EXPECTATION ONLY (EONLY):                  0
 PROPOSAL DENSITY SCALING RANGE
              (ISCALE_MIN, ISCALE_MAX):     0.100000000000000       ,10.0000000000000
 SAMPLE ACCEPTANCE RATE (IACCEPT):          0.400000000000000
 LONG TAIL SAMPLE ACCEPT. RATE (IACCEPTL):   0.00000000000000
 T-DIST. PROPOSAL DENSITY (DF):             0
 NO. ITERATIONS FOR MAP (MAPITER):          0
 INTERVAL ITER. FOR MAP (MAPINTER):         0
 MAP COVARIANCE/MODE SETTING (MAPCOV):      1
 Gradient Quick Value (GRDQ):               0.00000000000000


 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI

 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2   3   4   5   6   7   8   9  10
 THETAS THAT ARE SIGMA-LIKE:
  11

 MONITORING OF SEARCH:

 iteration            0  OBJ=  -10781.506758606241 eff.=     304. Smpl.=     300. Fit.= 0.98310
 iteration            1  OBJ=  -10782.346350504771 eff.=     125. Smpl.=     300. Fit.= 0.90223
 iteration            2  OBJ=  -10781.275098591472 eff.=     118. Smpl.=     300. Fit.= 0.89773
 iteration            3  OBJ=  -10781.784349159714 eff.=     121. Smpl.=     300. Fit.= 0.89984
 iteration            4  OBJ=  -10781.376087240038 eff.=     121. Smpl.=     300. Fit.= 0.90008
 iteration            5  OBJ=  -10783.131638669796 eff.=     120. Smpl.=     300. Fit.= 0.89923
 iteration            6  OBJ=  -10783.588395172213 eff.=     121. Smpl.=     300. Fit.= 0.89992
 iteration            7  OBJ=  -10780.625410732746 eff.=     120. Smpl.=     300. Fit.= 0.89944
 iteration            8  OBJ=  -10781.908833146019 eff.=     122. Smpl.=     300. Fit.= 0.90080
 iteration            9  OBJ=  -10781.053142674300 eff.=     118. Smpl.=     300. Fit.= 0.89769
 iteration           10  OBJ=  -10784.117968277220 eff.=     123. Smpl.=     300. Fit.= 0.90109
 iteration           11  OBJ=  -10782.320571568269 eff.=     120. Smpl.=     300. Fit.= 0.89938
 iteration           12  OBJ=  -10783.389028353175 eff.=     123. Smpl.=     300. Fit.= 0.90103
 iteration           13  OBJ=  -10783.281490583200 eff.=     119. Smpl.=     300. Fit.= 0.89847
 Convergence achieved
 iteration           13  OBJ=  -10784.653008591595 eff.=     121. Smpl.=     300. Fit.= 0.89990

 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.

 ETABAR:        -1.7327E-04  1.8540E-04 -1.8115E-04 -2.1533E-04
 SE:             4.7180E-03  2.9682E-03  2.8716E-03  3.6921E-03
 N:                     400         400         400         400

 P VAL.:         9.7070E-01  9.5020E-01  9.4970E-01  9.5349E-01

 ETASHRINKSD(%)  6.9657E+00  3.3361E+01  4.1621E+01  2.4839E+01
 ETASHRINKVR(%)  1.3446E+01  5.5593E+01  6.5919E+01  4.3508E+01
 EBVSHRINKSD(%)  6.9560E+00  3.3128E+01  4.1480E+01  2.5084E+01
 EBVSHRINKVR(%)  1.3428E+01  5.5281E+01  6.5754E+01  4.3877E+01
 RELATIVEINF(%)  7.7968E+01  4.2155E+01  2.7526E+01  4.1587E+01
 EPSSHRINKSD(%)  2.6314E+01
 EPSSHRINKVR(%)  4.5704E+01

  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         2000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    3675.7541328186908     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -10784.653008591595     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -7108.8988757729039     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          1600
  
 #TERE:
 Elapsed estimation  time in seconds:    28.10
 Elapsed covariance  time in seconds:     5.45
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          IMPORTANCE SAMPLING (NO PRIOR)                        ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -10784.653       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          IMPORTANCE SAMPLING (NO PRIOR)                        ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11     
 
         3.30E+00  3.25E+00 -6.12E-01 -2.09E-01  7.38E-01  1.14E+00  3.34E-01  1.91E-01  6.91E-01  2.30E+00  1.00E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        1.03E-02
 
 ETA2
+        1.83E-04  7.94E-03
 
 ETA3
+        1.17E-03 -2.50E-04  9.68E-03
 
 ETA4
+       -6.72E-04  4.93E-04  1.86E-03  9.65E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        1.01E-01
 
 ETA2
+        2.03E-02  8.91E-02
 
 ETA3
+        1.17E-01 -2.85E-02  9.84E-02
 
 ETA4
+       -6.75E-02  5.63E-02  1.92E-01  9.82E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          IMPORTANCE SAMPLING (NO PRIOR)                        ********************
 ********************                          STANDARD ERROR OF ESTIMATE (R)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11     
 
         3.27E-02  2.87E-02  9.55E-03  8.33E-03  3.89E-02  3.59E-02  1.13E-02  1.04E-02  1.04E-02  8.52E-03  2.78E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        9.65E-04
 
 ETA2
+        8.33E-04  1.37E-03
 
 ETA3
+        1.21E-03  1.35E-03  2.68E-03
 
 ETA4
+        9.68E-04  1.10E-03  1.87E-03  1.79E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        0.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        4.76E-03
 
 ETA2
+        9.14E-02  7.70E-03
 
 ETA3
+        1.13E-01  1.56E-01  1.36E-02
 
 ETA4
+        1.00E-01  1.23E-01  1.59E-01  9.10E-03
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+       .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          IMPORTANCE SAMPLING (NO PRIOR)                        ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (R)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        1.07E-03
 
 TH 2
+        1.49E-05  8.23E-04
 
 TH 3
+       -3.02E-04 -2.76E-06  9.11E-05
 
 TH 4
+       -1.09E-06 -2.29E-04  1.25E-07  6.93E-05
 
 TH 5
+        2.86E-04  2.43E-05 -7.75E-05 -2.61E-06  1.52E-03
 
 TH 6
+        2.58E-05  2.95E-04 -5.16E-06 -7.75E-05  3.66E-05  1.29E-03
 
 TH 7
+       -7.98E-05 -7.79E-06  2.26E-05  8.84E-07 -4.25E-04 -1.17E-05  1.27E-04
 
 TH 8
+       -4.30E-06 -7.92E-05  8.90E-07  2.27E-05 -4.98E-06 -3.58E-04  1.74E-06  1.08E-04
 
 TH 9
+        4.20E-05  4.42E-05 -8.88E-06 -4.82E-06  5.57E-05  6.68E-05 -1.76E-05 -1.15E-05  1.07E-04
 
 TH10
+        2.56E-05  3.10E-05 -4.72E-06 -3.73E-06  4.97E-05  5.68E-05 -1.45E-05 -9.03E-06  6.16E-05  7.26E-05
 
 TH11
+        1.67E-06  9.08E-07 -4.40E-07 -1.55E-07  3.32E-06  9.74E-07 -9.99E-07 -1.51E-07  2.09E-06  1.47E-06  7.73E-06
 
 OM11
+        1.08E-07 -2.89E-07  1.42E-08  9.74E-08 -7.91E-08 -9.50E-08  1.17E-07  7.89E-08  1.24E-07  1.34E-07 -3.58E-07  9.31E-07
 
 OM12
+        2.23E-07 -2.50E-07 -1.38E-08  1.20E-07 -7.57E-08 -6.73E-07  1.76E-07  3.06E-07  2.67E-07  2.39E-07 -3.93E-07  2.71E-07
          6.95E-07
 
 OM13
+       -2.25E-08 -6.14E-07  1.24E-07  1.84E-07  4.67E-07 -5.40E-07 -1.14E-08  2.65E-07  1.21E-07  2.67E-07 -4.71E-07  4.86E-07
          1.60E-07  1.46E-06
 
 OM14
+        5.85E-07 -1.79E-06 -1.34E-07  5.82E-07  1.22E-07 -1.90E-07  5.60E-08  1.29E-07  1.59E-07  9.17E-08 -4.60E-07  3.31E-07
          1.92E-07  7.91E-07  9.36E-07
 
 OM22
+       -2.29E-07 -3.58E-07  1.12E-07  1.75E-07 -5.18E-07 -1.70E-06  3.36E-07  6.75E-07 -4.70E-08 -1.31E-08 -1.21E-06  8.19E-08
          3.72E-07 -1.81E-09  5.96E-08  1.88E-06
 
 OM23
+        7.56E-07 -2.29E-07 -1.35E-07  1.61E-07  2.64E-06 -1.87E-06 -4.63E-07  7.57E-07  1.15E-06  7.81E-07 -3.07E-07  1.10E-07
          2.86E-07  4.60E-07  2.47E-07  2.90E-07  1.82E-06
 
 OM24
+        4.26E-07 -3.09E-07 -6.35E-08  1.61E-07  2.11E-06 -2.91E-06 -4.56E-07  1.06E-06  7.07E-07  5.21E-07 -3.16E-07  7.30E-08
          2.22E-07  1.89E-07  2.71E-07  4.28E-07  9.26E-07  1.21E-06
 
 OM33
+       -6.18E-07 -8.63E-07  2.94E-07  3.01E-07  6.20E-07 -1.44E-06 -3.13E-08  6.16E-07 -1.10E-06 -4.59E-07 -2.65E-06  2.82E-07
          1.46E-07  1.36E-06  6.77E-07  1.75E-07  9.79E-07  3.42E-07  7.20E-06
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+       -7.49E-07  1.33E-07  2.81E-07 -3.71E-08 -3.11E-07  6.87E-07  2.02E-07 -1.21E-07 -9.32E-07 -6.40E-07 -1.91E-06  1.77E-07
          1.29E-07  7.74E-07  6.22E-07  1.35E-07  7.58E-07  4.34E-07  4.06E-06  3.49E-06
 
 OM44
+       -8.52E-07  6.49E-07  2.79E-07 -2.12E-07 -9.30E-07  2.17E-06  3.66E-07 -6.08E-07 -1.00E-06 -5.65E-07 -1.56E-06  1.20E-07
          1.21E-07  3.97E-07  5.30E-07  1.56E-07  4.43E-07  5.47E-07  2.10E-06  2.57E-06  3.20E-06
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          IMPORTANCE SAMPLING (NO PRIOR)                        ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (R)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        3.27E-02
 
 TH 2
+        1.59E-02  2.87E-02
 
 TH 3
+       -9.68E-01 -1.01E-02  9.55E-03
 
 TH 4
+       -4.00E-03 -9.60E-01  1.57E-03  8.33E-03
 
 TH 5
+        2.24E-01  2.18E-02 -2.09E-01 -8.05E-03  3.89E-02
 
 TH 6
+        2.20E-02  2.86E-01 -1.50E-02 -2.59E-01  2.62E-02  3.59E-02
 
 TH 7
+       -2.17E-01 -2.41E-02  2.10E-01  9.43E-03 -9.69E-01 -2.90E-02  1.13E-02
 
 TH 8
+       -1.26E-02 -2.65E-01  8.97E-03  2.62E-01 -1.23E-02 -9.60E-01  1.49E-02  1.04E-02
 
 TH 9
+        1.24E-01  1.49E-01 -8.98E-02 -5.58E-02  1.38E-01  1.80E-01 -1.51E-01 -1.07E-01  1.04E-02
 
 TH10
+        9.19E-02  1.27E-01 -5.80E-02 -5.26E-02  1.50E-01  1.86E-01 -1.52E-01 -1.02E-01  6.97E-01  8.52E-03
 
 TH11
+        1.84E-02  1.14E-02 -1.66E-02 -6.68E-03  3.07E-02  9.76E-03 -3.19E-02 -5.24E-03  7.25E-02  6.21E-02  2.78E-03
 
 OM11
+        3.43E-03 -1.04E-02  1.54E-03  1.21E-02 -2.10E-03 -2.74E-03  1.07E-02  7.87E-03  1.24E-02  1.63E-02 -1.34E-01  9.65E-04
 
 OM12
+        8.18E-03 -1.05E-02 -1.74E-03  1.73E-02 -2.33E-03 -2.25E-02  1.88E-02  3.54E-02  3.09E-02  3.37E-02 -1.70E-01  3.37E-01
          8.33E-04
 
 OM13
+       -5.68E-04 -1.77E-02  1.07E-02  1.82E-02  9.92E-03 -1.24E-02 -8.40E-04  2.10E-02  9.68E-03  2.59E-02 -1.40E-01  4.16E-01
          1.59E-01  1.21E-03
 
 OM14
+        1.85E-02 -6.45E-02 -1.46E-02  7.23E-02  3.25E-03 -5.47E-03  5.14E-03  1.28E-02  1.59E-02  1.11E-02 -1.71E-01  3.54E-01
          2.38E-01  6.76E-01  9.68E-04
 
 OM22
+       -5.10E-03 -9.08E-03  8.52E-03  1.53E-02 -9.70E-03 -3.45E-02  2.17E-02  4.73E-02 -3.31E-03 -1.12E-03 -3.16E-01  6.19E-02
          3.25E-01 -1.09E-03  4.49E-02  1.37E-03
 
 OM23
+        1.71E-02 -5.91E-03 -1.05E-02  1.43E-02  5.02E-02 -3.86E-02 -3.05E-02  5.39E-02  8.23E-02  6.79E-02 -8.17E-02  8.43E-02
          2.54E-01  2.82E-01  1.89E-01  1.57E-01  1.35E-03
 
 OM24
+        1.19E-02 -9.80E-03 -6.05E-03  1.76E-02  4.93E-02 -7.39E-02 -3.69E-02  9.27E-02  6.21E-02  5.57E-02 -1.04E-01  6.88E-02
          2.42E-01  1.42E-01  2.55E-01  2.84E-01  6.24E-01  1.10E-03
 
 OM33
+       -7.03E-03 -1.12E-02  1.15E-02  1.35E-02  5.94E-03 -1.49E-02 -1.04E-03  2.21E-02 -3.95E-02 -2.01E-02 -3.56E-01  1.09E-01
          6.53E-02  4.18E-01  2.61E-01  4.76E-02  2.70E-01  1.16E-01  2.68E-03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+       -1.22E-02  2.47E-03  1.57E-02 -2.38E-03 -4.28E-03  1.02E-02  9.62E-03 -6.25E-03 -4.81E-02 -4.02E-02 -3.68E-01  9.82E-02
          8.30E-02  3.42E-01  3.44E-01  5.24E-02  3.00E-01  2.11E-01  8.09E-01  1.87E-03
 
 OM44
+       -1.46E-02  1.26E-02  1.64E-02 -1.43E-02 -1.34E-02  3.38E-02  1.82E-02 -3.27E-02 -5.40E-02 -3.71E-02 -3.14E-01  6.96E-02
          8.13E-02  1.84E-01  3.06E-01  6.35E-02  1.84E-01  2.79E-01  4.37E-01  7.68E-01  1.79E-03
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          IMPORTANCE SAMPLING (NO PRIOR)                        ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (R)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        1.58E+04
 
 TH 2
+        0.00E+00  1.85E+04
 
 TH 3
+        5.21E+04  0.00E+00  1.84E+05
 
 TH 4
+        0.00E+00  6.06E+04  0.00E+00  2.15E+05
 
 TH 5
+       -2.13E+03  0.00E+00 -6.78E+03  0.00E+00  1.13E+04
 
 TH 6
+        0.00E+00 -3.47E+03  0.00E+00 -1.11E+04  0.00E+00  1.18E+04
 
 TH 7
+       -6.78E+03  0.00E+00 -2.35E+04  0.00E+00  3.78E+04  0.00E+00  1.35E+05
 
 TH 8
+        0.00E+00 -1.11E+04  0.00E+00 -3.89E+04  0.00E+00  3.87E+04  0.00E+00  1.37E+05
 
 TH 9
+       -1.35E+03 -3.82E+03 -3.62E+03 -1.23E+04  1.10E+03 -4.68E+02  4.27E+03 -9.08E+02  1.96E+04
 
 TH10
+       -9.38E+02 -2.09E+02 -3.45E+03 -5.91E+02 -6.87E+02 -3.10E+03 -1.31E+03 -9.55E+03 -1.49E+04  2.81E+04
 
 TH11
+       -3.59E+02 -2.70E+02 -1.06E+03 -1.10E+03 -9.56E+02 -9.19E+02 -2.82E+03 -3.41E+03 -1.25E+03 -1.02E+03  1.75E+05
 
 OM11
+        2.36E+02  8.14E+01  9.91E+02  4.16E+02 -1.50E+03 -6.37E+01 -5.35E+03  1.44E+02 -1.26E+03  3.69E+02  3.74E+04  1.47E+06
 
 OM12
+       -1.78E+03 -1.60E+02 -5.89E+03  8.27E+02 -4.04E+03 -2.01E+03 -1.61E+04 -8.77E+03  1.65E+02 -3.05E+03  2.29E+04 -4.94E+05
          1.95E+06
 
 OM13
+       -5.23E+03  4.24E+03 -2.16E+04  2.30E+04  6.48E+02 -1.29E+03  2.63E+03 -7.21E+03  4.46E+03 -5.74E+03 -2.75E+04 -4.43E+05
          1.83E+05  1.73E+06
 
 OM14
+        3.72E+03 -4.08E+03  1.83E+04 -3.25E+04 -1.83E+03  5.05E+02 -7.69E+03  6.45E+03 -6.08E+03  5.20E+03  3.20E+04 -8.74E+04
         -3.12E+05 -1.29E+06  2.42E+06
 
 OM22
+       -5.50E+02 -1.59E+03 -2.08E+03 -6.06E+03 -2.45E+03 -2.56E+03 -9.65E+03 -9.50E+03  5.95E+02  9.26E+02  1.04E+05  4.12E+04
         -3.01E+05  1.22E+04  7.11E+04  6.99E+05
 
 OM23
+        2.13E+03  1.25E+02  8.39E+03 -2.50E+03 -6.69E+03  9.37E+02 -2.26E+04  4.84E+03 -6.90E+03  3.02E+02 -1.65E+04  8.46E+04
         -2.44E+05 -3.39E+05  3.19E+05  4.53E+04  1.11E+06
 
 OM24
+       -1.31E+03  1.39E+03 -6.11E+03  9.15E+03  1.52E+03 -2.21E+03  9.21E+03 -1.93E+04 -1.24E+03 -2.41E+03 -2.13E+04  6.20E+03
          3.53E+03  2.60E+05 -4.58E+05 -2.40E+05 -8.32E+05  1.68E+06
 
 OM33
+        1.97E+01 -1.60E+03  7.43E+02 -7.97E+03 -4.54E+02 -9.00E+02 -9.04E+02 -4.40E+03  3.12E+03 -3.96E+03  5.03E+04  3.81E+04
         -8.40E+03 -2.96E+05  2.34E+05  5.87E+03  3.53E+04 -2.51E+04  5.93E+05
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+       -9.82E+02  9.95E+02 -4.72E+03  7.58E+03  1.59E+03 -3.57E+02  5.50E+03 -1.35E+03 -4.46E+03  9.81E+03  3.13E+03  1.10E+04
          6.40E+04  2.23E+05 -3.74E+05  1.21E+04 -3.15E+05  2.55E+05 -9.08E+05  2.27E+06
 
 OM44
+       -1.29E+02 -6.18E+02 -5.67E+02 -1.66E+03 -1.03E+03 -4.29E+02 -4.52E+03  3.05E+03  5.94E+03 -4.89E+03  4.61E+04  2.62E+03
         -1.31E+04  1.38E+04 -3.52E+04  3.52E+04  2.02E+05 -3.19E+05  3.59E+05 -1.19E+06  1.09E+06
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1


 #TBLN:      3
 #METH: Stochastic Approximation Expectation-Maximization (No Prior)

 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            2208
 NO. OF SIG. FIGURES REQUIRED:            2
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    0
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      8
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     8
 NOPRIOR SETTING (NOPRIOR):                 1
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): example2.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 EM OR BAYESIAN METHOD USED:                STOCHASTIC APPROXIMATION EXPECTATION MAXIMIZATION (SAEM)
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):              DDDDDDDDDDS
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          10
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 BURN-IN ITERATIONS (NBURN):                3000
 FIRST ITERATION FOR MAP (MAPITERS):          NO
 ITERATIONS (NITER):                        300
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
 MC SAMPLES PER SUBJECT (ISAMPLE):          2
 RANDOM SAMPLING METHOD (RANMETHOD):        3U
 EXPECTATION ONLY (EONLY):                  0
 PROPOSAL DENSITY SCALING RANGE
              (ISCALE_MIN, ISCALE_MAX):     1.000000000000000E-06   ,1000000.00000000
 SAMPLE ACCEPTANCE RATE (IACCEPT):          0.400000000000000
 METROPOLIS HASTINGS SAMPLING FOR INDIVIDUAL ETAS:
 SAMPLES FOR GLOBAL SEARCH KERNEL (ISAMPLE_M1):          2
 SAMPLES FOR NEIGHBOR SEARCH KERNEL (ISAMPLE_M1A):       0
 SAMPLES FOR MASS/IMP/POST. MATRIX SEARCH (ISAMPLE_M1B): 2
 SAMPLES FOR LOCAL SEARCH KERNEL (ISAMPLE_M2):           2
 SAMPLES FOR LOCAL UNIVARIATE KERNEL (ISAMPLE_M3):       2
 PWR. WT. MASS/IMP/POST MATRIX ACCUM. FOR ETAS (IKAPPA): 1.00000000000000
 MASS/IMP./POST. MATRIX REFRESH SETTING (MASSRESET):      -1


 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI

 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2   3   4   5   6   7   8   9  10
 THETAS THAT ARE SIGMA-LIKE:
  11

 MONITORING OF SEARCH:

 Stochastic/Burn-in Mode
 iteration        -3000  SAEMOBJ=  -19825.514718006256
 iteration        -2990  SAEMOBJ=  -19802.298387070921
 iteration        -2980  SAEMOBJ=  -19915.538974671352
 iteration        -2970  SAEMOBJ=  -19902.727197006097
 iteration        -2960  SAEMOBJ=  -19975.633846072607
 iteration        -2950  SAEMOBJ=  -20015.148111246348
 iteration        -2940  SAEMOBJ=  -20001.971674462013
 iteration        -2930  SAEMOBJ=  -19908.314339092154
 iteration        -2920  SAEMOBJ=  -19972.736018181331
 iteration        -2910  SAEMOBJ=  -19847.218097807930
 iteration        -2900  SAEMOBJ=  -19872.845588740965
 iteration        -2890  SAEMOBJ=  -19961.274020194422
 Convergence achieved
 Reduced Stochastic/Accumulation Mode
 iteration            0  SAEMOBJ=  -20017.895448236155
 iteration           10  SAEMOBJ=  -20177.224534040706
 iteration           20  SAEMOBJ=  -20176.075230426941
 iteration           30  SAEMOBJ=  -20165.297686683632
 iteration           40  SAEMOBJ=  -20161.102684285273
 iteration           50  SAEMOBJ=  -20157.525214256668
 iteration           60  SAEMOBJ=  -20156.665617352188
 iteration           70  SAEMOBJ=  -20155.422565913253
 iteration           80  SAEMOBJ=  -20152.971562086659
 iteration           90  SAEMOBJ=  -20152.294146510576
 iteration          100  SAEMOBJ=  -20150.680088360074
 iteration          110  SAEMOBJ=  -20148.732295802554
 iteration          120  SAEMOBJ=  -20147.541901215936
 iteration          130  SAEMOBJ=  -20146.872672917001
 iteration          140  SAEMOBJ=  -20145.996836413229
 iteration          150  SAEMOBJ=  -20145.597988306930
 iteration          160  SAEMOBJ=  -20145.160591981312
 iteration          170  SAEMOBJ=  -20145.231833381808
 iteration          180  SAEMOBJ=  -20145.503677147066
 iteration          190  SAEMOBJ=  -20145.632896576084
 iteration          200  SAEMOBJ=  -20144.502825020660
 iteration          210  SAEMOBJ=  -20143.714680505607
 iteration          220  SAEMOBJ=  -20143.239963192129
 iteration          230  SAEMOBJ=  -20142.734413282960
 iteration          240  SAEMOBJ=  -20142.436177229782
 iteration          250  SAEMOBJ=  -20142.364078625473
 iteration          260  SAEMOBJ=  -20142.265162284766
 iteration          270  SAEMOBJ=  -20142.204152680904
 iteration          280  SAEMOBJ=  -20142.467729875931
 iteration          290  SAEMOBJ=  -20142.687801712080
 iteration          300  SAEMOBJ=  -20142.822420040578

 #TERM:
 STOCHASTIC PORTION WAS COMPLETED
 REDUCED STOCHASTIC PORTION WAS COMPLETED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.

 ETABAR:        -1.9580E-06  8.2419E-06 -7.0623E-06  1.5471E-06
 SE:             4.6668E-03  2.8642E-03  2.3083E-03  3.3382E-03
 N:                     400         400         400         400

 P VAL.:         9.9967E-01  9.9770E-01  9.9756E-01  9.9963E-01

 ETASHRINKSD(%)  6.1255E+00  3.3381E+01  3.1545E+01  1.7087E+01
 ETASHRINKVR(%)  1.1876E+01  5.5619E+01  5.3139E+01  3.1255E+01
 EBVSHRINKSD(%)  6.1235E+00  3.3398E+01  3.1535E+01  1.7092E+01
 EBVSHRINKVR(%)  1.1872E+01  5.5642E+01  5.3125E+01  3.1262E+01
 RELATIVEINF(%)  6.1494E+01  3.5765E+01  9.7452E+00  1.6624E+01
 EPSSHRINKSD(%)  2.4004E+01
 EPSSHRINKVR(%)  4.2246E+01

  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         2000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    3675.7541328186908     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -20142.822420040578     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -16467.068287221889     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          1600
 NIND*NETA*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    2940.6033062549527     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -20142.822420040578     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -17202.219113785624     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:    39.49
 Elapsed covariance  time in seconds:     0.16
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************           STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION (NO PRIOR)         ********************
 #OBJT:**************                        FINAL VALUE OF LIKELIHOOD FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -20142.822       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************           STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION (NO PRIOR)         ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11     
 
         3.30E+00  3.25E+00 -6.12E-01 -2.08E-01  7.30E-01  1.13E+00  3.37E-01  1.93E-01  6.89E-01  2.30E+00  1.03E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        9.89E-03
 
 ETA2
+       -8.31E-05  7.39E-03
 
 ETA3
+       -4.56E-05 -9.59E-04  4.55E-03
 
 ETA4
+       -1.62E-03 -2.45E-06 -2.23E-03  6.48E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        9.94E-02
 
 ETA2
+       -9.72E-03  8.60E-02
 
 ETA3
+       -6.79E-03 -1.65E-01  6.74E-02
 
 ETA4
+       -2.02E-01 -3.54E-04 -4.11E-01  8.05E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************           STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION (NO PRIOR)         ********************
 ********************                          STANDARD ERROR OF ESTIMATE (S)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11     
 
         3.74E-02  2.87E-02  1.09E-02  8.39E-03  4.50E-02  4.03E-02  1.26E-02  1.16E-02  9.47E-03  8.33E-03  3.06E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        9.65E-04
 
 ETA2
+        8.21E-04  1.42E-03
 
 ETA3
+        1.09E-03  1.20E-03  2.10E-03
 
 ETA4
+        9.57E-04  9.45E-04  1.42E-03  1.58E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        0.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        4.86E-03
 
 ETA2
+        9.65E-02  8.23E-03
 
 ETA3
+        1.64E-01  2.27E-01  1.56E-02
 
 ETA4
+        1.33E-01  1.36E-01  3.67E-01  9.83E-03
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+       .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************           STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION (NO PRIOR)         ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (S)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        1.40E-03
 
 TH 2
+       -3.34E-06  8.22E-04
 
 TH 3
+       -3.99E-04  2.73E-06  1.20E-04
 
 TH 4
+        5.18E-07 -2.30E-04 -3.76E-07  7.05E-05
 
 TH 5
+        5.39E-04  4.82E-05 -1.40E-04 -4.01E-06  2.02E-03
 
 TH 6
+       -1.77E-05  2.22E-04  5.92E-06 -5.52E-05  2.72E-05  1.62E-03
 
 TH 7
+       -1.40E-04 -1.52E-05  3.65E-05  1.69E-06 -5.51E-04 -1.13E-05  1.58E-04
 
 TH 8
+        4.54E-06 -5.49E-05 -1.24E-06  1.56E-05  2.24E-06 -4.53E-04  3.41E-07  1.36E-04
 
 TH 9
+        7.82E-06  5.37E-05  1.23E-06 -8.65E-06  1.04E-04  5.00E-05 -2.99E-05 -7.25E-06  8.97E-05
 
 TH10
+        4.11E-06  3.08E-05  1.58E-06 -3.83E-06  9.51E-05  4.58E-05 -2.69E-05 -5.00E-06  5.05E-05  6.94E-05
 
 TH11
+       -6.16E-06 -3.31E-06  2.19E-06  1.51E-06 -2.35E-06 -1.20E-06  9.84E-07  7.94E-07  2.51E-06  3.72E-06  9.38E-06
 
 OM11
+        3.78E-06 -2.65E-07 -1.23E-06 -1.77E-07 -3.36E-07  4.68E-07 -1.78E-08 -1.47E-07 -4.59E-07 -1.76E-07 -4.00E-07  9.32E-07
 
 OM12
+        8.74E-07  1.51E-07 -4.75E-07 -8.96E-08  2.23E-07  7.64E-07  3.69E-08 -5.29E-08 -1.48E-07  9.33E-08 -4.57E-07  3.13E-07
          6.74E-07
 
 OM13
+        1.93E-07  1.75E-06 -3.12E-07 -6.12E-07 -5.93E-07  8.30E-07  1.74E-07 -1.78E-07  5.12E-07  1.49E-07 -4.04E-07  3.25E-07
          1.99E-07  1.20E-06
 
 OM14
+        1.61E-06 -6.08E-07 -6.38E-07  2.82E-07  3.62E-06  1.30E-08 -8.39E-07  5.25E-08  5.90E-07  4.70E-07 -2.11E-07  2.56E-07
          1.76E-07  6.38E-07  9.15E-07
 
 OM22
+        2.63E-06  7.99E-08 -7.42E-07  3.13E-09  5.32E-06 -6.75E-06 -9.40E-07  1.90E-06 -3.98E-07 -6.43E-07 -9.47E-07  3.82E-08
          3.53E-07 -3.29E-08  4.96E-08  2.00E-06
 
 OM23
+       -7.22E-07  1.11E-06  9.80E-08 -4.87E-07 -3.94E-06  1.64E-06  1.11E-06 -2.25E-07 -2.82E-07 -8.07E-07 -5.05E-07  1.61E-07
          2.22E-07  4.49E-07  2.08E-07  2.97E-07  1.45E-06
 
 OM24
+        1.74E-06 -2.42E-07 -3.98E-07  6.26E-10  2.59E-06 -1.99E-06 -6.36E-07  8.02E-07  2.49E-07  5.26E-07 -1.72E-07  8.41E-08
          1.88E-07  2.07E-07  2.94E-07  3.31E-07  5.84E-07  8.93E-07
 
 OM33
+        2.53E-06  1.50E-06 -8.04E-07 -7.32E-07  1.26E-06 -7.03E-07 -6.00E-07 -1.81E-07 -1.33E-06 -2.90E-06 -2.72E-06  2.25E-07
          2.01E-07  5.41E-07  8.27E-08  6.02E-08  8.83E-07  2.14E-07  4.43E-06
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+        1.77E-06  2.75E-06 -5.56E-07 -1.01E-06  8.37E-07  4.40E-06 -5.55E-07 -1.25E-06 -4.44E-07 -1.19E-06 -1.94E-06  2.13E-07
          1.71E-07  3.34E-07  3.21E-07 -9.36E-10  6.54E-07  3.17E-07  2.16E-06  2.01E-06
 
 OM44
+       -9.93E-07  3.52E-06  2.51E-07 -9.70E-07  2.98E-06  6.65E-06 -1.12E-06 -1.40E-06  8.81E-07  1.86E-06 -1.52E-06  2.32E-07
          1.87E-07  3.02E-07  5.16E-07 -1.03E-07  3.03E-07  4.94E-07  7.66E-07  1.43E-06  2.51E-06
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************           STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION (NO PRIOR)         ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (S)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        3.74E-02
 
 TH 2
+       -3.11E-03  2.87E-02
 
 TH 3
+       -9.77E-01  8.71E-03  1.09E-02
 
 TH 4
+        1.65E-03 -9.56E-01 -4.09E-03  8.39E-03
 
 TH 5
+        3.21E-01  3.74E-02 -2.84E-01 -1.06E-02  4.50E-02
 
 TH 6
+       -1.18E-02  1.92E-01  1.34E-02 -1.63E-01  1.50E-02  4.03E-02
 
 TH 7
+       -2.98E-01 -4.22E-02  2.66E-01  1.60E-02 -9.77E-01 -2.23E-02  1.26E-02
 
 TH 8
+        1.04E-02 -1.65E-01 -9.73E-03  1.59E-01  4.28E-03 -9.66E-01  2.34E-03  1.16E-02
 
 TH 9
+        2.21E-02  1.98E-01  1.19E-02 -1.09E-01  2.43E-01  1.31E-01 -2.51E-01 -6.57E-02  9.47E-03
 
 TH10
+        1.32E-02  1.29E-01  1.73E-02 -5.48E-02  2.54E-01  1.37E-01 -2.58E-01 -5.16E-02  6.40E-01  8.33E-03
 
 TH11
+       -5.38E-02 -3.77E-02  6.54E-02  5.87E-02 -1.70E-02 -9.71E-03  2.56E-02  2.23E-02  8.66E-02  1.46E-01  3.06E-03
 
 OM11
+        1.05E-01 -9.58E-03 -1.17E-01 -2.18E-02 -7.74E-03  1.20E-02 -1.47E-03 -1.30E-02 -5.02E-02 -2.18E-02 -1.35E-01  9.65E-04
 
 OM12
+        2.85E-02  6.40E-03 -5.29E-02 -1.30E-02  6.05E-03  2.31E-02  3.58E-03 -5.53E-03 -1.90E-02  1.36E-02 -1.82E-01  3.94E-01
          8.21E-04
 
 OM13
+        4.73E-03  5.59E-02 -2.61E-02 -6.67E-02 -1.21E-02  1.88E-02  1.27E-02 -1.39E-02  4.94E-02  1.64E-02 -1.21E-01  3.08E-01
          2.22E-01  1.09E-03
 
 OM14
+        4.50E-02 -2.22E-02 -6.10E-02  3.51E-02  8.42E-02  3.38E-04 -6.99E-02  4.71E-03  6.52E-02  5.89E-02 -7.21E-02  2.77E-01
          2.24E-01  6.10E-01  9.57E-04
 
 OM22
+        4.98E-02  1.97E-03 -4.80E-02  2.64E-04  8.35E-02 -1.18E-01 -5.29E-02  1.15E-01 -2.97E-02 -5.45E-02 -2.18E-01  2.80E-02
          3.03E-01 -2.12E-02  3.66E-02  1.42E-03
 
 OM23
+       -1.60E-02  3.21E-02  7.45E-03 -4.82E-02 -7.27E-02  3.38E-02  7.34E-02 -1.60E-02 -2.47E-02 -8.04E-02 -1.37E-01  1.39E-01
          2.25E-01  3.41E-01  1.80E-01  1.74E-01  1.20E-03
 
 OM24
+        4.93E-02 -8.93E-03 -3.86E-02  7.89E-05  6.11E-02 -5.22E-02 -5.36E-02  7.29E-02  2.78E-02  6.68E-02 -5.93E-02  9.22E-02
          2.42E-01  2.00E-01  3.26E-01  2.48E-01  5.13E-01  9.45E-04
 
 OM33
+        3.22E-02  2.49E-02 -3.50E-02 -4.14E-02  1.33E-02 -8.29E-03 -2.27E-02 -7.40E-03 -6.67E-02 -1.65E-01 -4.22E-01  1.11E-01
          1.16E-01  2.35E-01  4.11E-02  2.02E-02  3.49E-01  1.08E-01  2.10E-03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+        3.35E-02  6.76E-02 -3.59E-02 -8.51E-02  1.31E-02  7.70E-02 -3.12E-02 -7.59E-02 -3.31E-02 -1.00E-01 -4.46E-01  1.56E-01
          1.47E-01  2.15E-01  2.36E-01 -4.66E-04  3.83E-01  2.37E-01  7.23E-01  1.42E-03
 
 OM44
+       -1.68E-02  7.76E-02  1.45E-02 -7.30E-02  4.18E-02  1.04E-01 -5.65E-02 -7.60E-02  5.87E-02  1.41E-01 -3.14E-01  1.52E-01
          1.44E-01  1.74E-01  3.40E-01 -4.61E-02  1.59E-01  3.30E-01  2.30E-01  6.37E-01  1.58E-03
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************           STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION (NO PRIOR)         ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (S)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        1.73E+04
 
 TH 2
+        0.00E+00  1.72E+04
 
 TH 3
+        5.70E+04  0.00E+00  1.98E+05
 
 TH 4
+        0.00E+00  5.55E+04  0.00E+00  1.95E+05
 
 TH 5
+       -1.89E+03  0.00E+00 -4.92E+03  0.00E+00  1.20E+04
 
 TH 6
+        0.00E+00 -3.63E+03  0.00E+00 -1.17E+04  0.00E+00  1.16E+04
 
 TH 7
+       -4.92E+03  0.00E+00 -1.40E+04  0.00E+00  4.13E+04  0.00E+00  1.50E+05
 
 TH 8
+        0.00E+00 -1.17E+04  0.00E+00 -3.90E+04  0.00E+00  3.84E+04  0.00E+00  1.35E+05
 
 TH 9
+       -1.43E+03 -3.56E+03 -5.13E+03 -9.98E+03  4.71E+02 -2.98E+02  2.95E+03 -7.04E+02  2.07E+04
 
 TH10
+       -7.77E+02 -2.81E+02 -3.14E+03 -1.24E+03 -3.95E+02 -3.54E+03  6.24E+02 -1.15E+04 -1.36E+04  2.88E+04
 
 TH11
+       -1.05E+03 -1.32E+03 -5.30E+03 -5.36E+03 -1.60E+03 -2.47E+02 -6.16E+03 -1.45E+03  2.09E+02 -5.91E+03  1.57E+05
 
 OM11
+       -7.76E+03  1.37E+04 -1.29E+04  4.62E+04  9.85E+03  1.02E+02  3.24E+04 -2.51E+02  6.37E+03 -2.68E+03  1.50E+04  1.43E+06
 
 OM12
+        2.07E+04  1.07E+02  6.82E+04 -1.24E+03 -5.33E+03 -1.06E+04 -2.10E+04 -3.01E+04  4.54E+03 -9.88E+03  3.00E+04 -5.97E+05
          2.09E+06
 
 OM13
+        6.18E+03  9.28E+03  1.99E+04  4.72E+04  4.95E+03 -2.16E+03  1.24E+04 -7.89E+03 -6.75E+03 -5.24E+03  2.10E+04 -1.91E+05
         -6.48E+04  1.71E+06
 
 OM14
+        1.18E+04 -1.75E+04  4.03E+04 -7.90E+04 -1.90E+04  1.03E+04 -5.69E+04  3.29E+04 -7.36E+03  1.01E+04 -2.85E+04 -1.74E+05
         -7.31E+04 -1.20E+06  2.32E+06
 
 OM22
+       -1.31E+03 -5.15E+03 -5.34E+03 -1.41E+04 -1.15E+04  4.27E+03 -3.58E+04  6.82E+03 -7.29E+02  3.86E+03  8.35E+04  6.33E+04
         -3.12E+05  1.04E+05 -2.26E+04  6.66E+05
 
 OM23
+        6.93E+03  1.01E+03  1.94E+04  3.28E+03 -6.03E+02 -1.14E+04 -1.06E+04 -3.21E+04 -3.46E+03  9.64E+03 -2.37E+04 -2.93E+04
         -5.84E+04 -4.15E+05  2.81E+05 -7.39E+04  1.29E+06
 
 OM24
+       -1.84E+04  1.17E+04 -5.55E+04  3.75E+04  2.98E+03  6.70E+02  1.47E+04 -8.70E+03  4.47E+03 -1.01E+04 -5.44E+04  1.20E+05
         -1.77E+05  2.16E+05 -4.84E+05 -2.05E+05 -7.85E+05  2.01E+06
 
 OM33
+        3.94E+02 -6.22E+03 -9.62E+02 -2.52E+04 -4.67E+03  5.74E+03 -1.22E+04  1.45E+04  1.23E+03 -1.88E+02  6.14E+04  2.87E+03
         -3.34E+04 -2.64E+05  2.99E+05  3.95E+04 -1.21E+04 -4.36E+04  6.71E+05
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+       -9.42E+03  1.02E+04 -2.41E+04  4.33E+04  1.15E+04 -4.01E+03  4.02E+04 -5.78E+03 -1.10E+04  3.22E+04  3.92E+04  5.46E+02
          3.30E+04  3.63E+05 -4.36E+05  1.86E+04 -4.32E+05  2.56E+05 -8.84E+05  2.34E+06
 
 OM44
+        5.62E+03 -4.20E+03  1.11E+04 -1.13E+04 -1.59E+02 -5.30E+03 -1.06E+03 -1.61E+04  1.21E+04 -3.43E+04  7.41E+04 -3.91E+04
         -2.46E+04 -2.63E+04 -1.33E+05  1.04E+05  2.34E+05 -4.00E+05  3.12E+05 -1.00E+06  1.04E+06
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1


 #TBLN:      4
 #METH: Objective Function Evaluation by Importance Sampling (No Prior)

 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            2208
 NO. OF SIG. FIGURES REQUIRED:            2
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    0
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      8
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     8
 NOPRIOR SETTING (NOPRIOR):                 1
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): example2.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 EM OR BAYESIAN METHOD USED:                IMPORTANCE SAMPLING (IMP)
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):              DDDDDDDDDDS
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          1
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 ITERATIONS (NITER):                        5
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       123334
 MC SAMPLES PER SUBJECT (ISAMPLE):          3000
 RANDOM SAMPLING METHOD (RANMETHOD):        3U
 EXPECTATION ONLY (EONLY):                  1
 PROPOSAL DENSITY SCALING RANGE
              (ISCALE_MIN, ISCALE_MAX):     0.100000000000000       ,10.0000000000000
 SAMPLE ACCEPTANCE RATE (IACCEPT):          0.400000000000000
 LONG TAIL SAMPLE ACCEPT. RATE (IACCEPTL):   0.00000000000000
 T-DIST. PROPOSAL DENSITY (DF):             0
 NO. ITERATIONS FOR MAP (MAPITER):          0
 INTERVAL ITER. FOR MAP (MAPINTER):         0
 MAP COVARIANCE/MODE SETTING (MAPCOV):      1
 Gradient Quick Value (GRDQ):               0.00000000000000


 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI

 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2   3   4   5   6   7   8   9  10
 THETAS THAT ARE SIGMA-LIKE:
  11

 MONITORING OF SEARCH:

 iteration            0  OBJ=  -10778.331087414370 eff.=    3043. Smpl.=    3000. Fit.= 0.97495
 iteration            1  OBJ=  -10777.991408053414 eff.=    1181. Smpl.=    3000. Fit.= 0.89893
 iteration            2  OBJ=  -10778.618429161244 eff.=    1200. Smpl.=    3000. Fit.= 0.90041
 iteration            3  OBJ=  -10777.976820772179 eff.=    1199. Smpl.=    3000. Fit.= 0.90045
 iteration            4  OBJ=  -10777.879925429846 eff.=    1200. Smpl.=    3000. Fit.= 0.90065
 iteration            5  OBJ=  -10778.956627674526 eff.=    1201. Smpl.=    3000. Fit.= 0.90037

 #TERM:
 EXPECTATION ONLY PROCESS WAS NOT COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.

 ETABAR:        -2.6739E-05  4.7220E-06  9.9879E-06 -2.7780E-05
 SE:             4.6683E-03  2.8741E-03  2.3053E-03  3.3420E-03
 N:                     400         400         400         400

 P VAL.:         9.9543E-01  9.9869E-01  9.9654E-01  9.9337E-01

 ETASHRINKSD(%)  6.0935E+00  3.3151E+01  3.1635E+01  1.6993E+01
 ETASHRINKVR(%)  1.1816E+01  5.5312E+01  5.3263E+01  3.1099E+01
 EBVSHRINKSD(%)  6.1738E+00  3.3921E+01  3.1840E+01  1.7165E+01
 EBVSHRINKVR(%)  1.1966E+01  5.6336E+01  5.3543E+01  3.1384E+01
 RELATIVEINF(%)  5.9507E+01  3.5130E+01  8.7507E+00  1.5115E+01
 EPSSHRINKSD(%)  2.4132E+01
 EPSSHRINKVR(%)  4.2441E+01

  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         2000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    3675.7541328186908     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -10778.956627674526     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -7103.2024948558355     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          1600
  
 #TERE:
 Elapsed estimation  time in seconds:    36.50
 Elapsed covariance  time in seconds:    53.42
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************         OBJECTIVE FUNCTION EVALUATION BY IMPORTANCE SAMPLING (NO PRIOR)        ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -10778.957       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************         OBJECTIVE FUNCTION EVALUATION BY IMPORTANCE SAMPLING (NO PRIOR)        ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11     
 
         3.30E+00  3.25E+00 -6.12E-01 -2.08E-01  7.30E-01  1.13E+00  3.37E-01  1.93E-01  6.89E-01  2.30E+00  1.03E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        9.89E-03
 
 ETA2
+       -8.31E-05  7.39E-03
 
 ETA3
+       -4.56E-05 -9.59E-04  4.55E-03
 
 ETA4
+       -1.62E-03 -2.45E-06 -2.23E-03  6.48E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        9.94E-02
 
 ETA2
+       -9.72E-03  8.60E-02
 
 ETA3
+       -6.79E-03 -1.65E-01  6.74E-02
 
 ETA4
+       -2.02E-01 -3.54E-04 -4.11E-01  8.05E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************         OBJECTIVE FUNCTION EVALUATION BY IMPORTANCE SAMPLING (NO PRIOR)        ********************
 ********************                          STANDARD ERROR OF ESTIMATE (R)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11     
 
         3.26E-02  2.86E-02  9.51E-03  8.28E-03  3.86E-02  3.49E-02  1.12E-02  1.01E-02  1.02E-02  8.42E-03  3.27E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        9.52E-04
 
 ETA2
+        8.18E-04  1.33E-03
 
 ETA3
+        1.28E-03  1.62E-03  3.35E-03
 
 ETA4
+        9.71E-04  1.09E-03  2.43E-03  2.00E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        0.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        4.79E-03
 
 ETA2
+        9.62E-02  7.74E-03
 
 ETA3
+        1.92E-01  3.27E-01  2.48E-02
 
 ETA4
+        1.42E-01  1.57E-01  6.41E-01  1.24E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+       .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************         OBJECTIVE FUNCTION EVALUATION BY IMPORTANCE SAMPLING (NO PRIOR)        ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (R)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        1.06E-03
 
 TH 2
+        1.46E-05  8.15E-04
 
 TH 3
+       -3.00E-04 -2.53E-06  9.04E-05
 
 TH 4
+       -9.38E-07 -2.27E-04  6.30E-08  6.86E-05
 
 TH 5
+        2.79E-04  2.45E-05 -7.52E-05 -2.35E-06  1.49E-03
 
 TH 6
+        2.81E-05  2.77E-04 -5.13E-06 -7.14E-05  4.09E-05  1.22E-03
 
 TH 7
+       -7.75E-05 -7.60E-06  2.18E-05  7.53E-07 -4.17E-04 -1.23E-05  1.25E-04
 
 TH 8
+       -4.52E-06 -7.36E-05  8.19E-07  2.10E-05 -5.48E-06 -3.38E-04  1.71E-06  1.02E-04
 
 TH 9
+        4.03E-05  4.54E-05 -8.51E-06 -4.76E-06  5.66E-05  7.51E-05 -1.78E-05 -1.27E-05  1.04E-04
 
 TH10
+        2.50E-05  3.15E-05 -4.64E-06 -3.55E-06  5.12E-05  6.24E-05 -1.50E-05 -9.64E-06  5.89E-05  7.09E-05
 
 TH11
+        8.07E-07 -3.76E-06 -5.87E-07  6.17E-07  3.93E-06 -9.99E-06 -1.50E-06  2.33E-06 -3.38E-06 -2.86E-06  1.07E-05
 
 OM11
+        3.76E-07  3.25E-07 -1.07E-08 -6.79E-10  4.13E-07  1.32E-06 -9.05E-09 -2.24E-07  9.07E-07  7.61E-07 -6.50E-07  9.07E-07
 
 OM12
+        1.36E-07  2.15E-07  6.69E-08  5.55E-08  8.88E-08  7.96E-07  1.48E-07 -4.66E-08  8.81E-07  7.29E-07 -6.89E-07  2.78E-07
          6.70E-07
 
 OM13
+        8.00E-07  1.59E-06  6.71E-08 -2.11E-07  1.30E-06  3.99E-06 -1.31E-07 -7.30E-07  2.54E-06  2.23E-06 -1.65E-06  5.03E-07
          2.85E-07  1.63E-06
 
 OM14
+        1.13E-06 -3.07E-07 -1.76E-07  3.27E-07  6.57E-07  2.79E-06 -5.87E-08 -5.11E-07  1.93E-06  1.48E-06 -1.20E-06  3.22E-07
          2.41E-07  8.55E-07  9.42E-07
 
 OM22
+       -4.29E-07  3.49E-07  2.19E-07  1.35E-09 -1.93E-06 -2.37E-08  8.25E-07  1.58E-07  3.61E-07  2.96E-07 -1.50E-06  1.02E-07
          3.50E-07  1.81E-07  1.38E-07  1.77E-06
 
 OM23
+        9.25E-07  2.31E-06  4.49E-08 -2.62E-07  2.27E-06  4.30E-06 -1.70E-07 -6.97E-07  3.95E-06  3.08E-06 -2.13E-06  2.80E-07
          4.33E-07  1.13E-06  6.06E-07  5.18E-07  2.62E-06
 
 OM24
+        4.01E-07  9.92E-07  4.74E-08 -6.08E-08  1.57E-06  4.16E-07 -2.58E-07  2.19E-07  2.19E-06  1.70E-06 -1.14E-06  1.38E-07
          2.42E-07  4.75E-07  4.13E-07  4.43E-07  1.15E-06  1.18E-06
 
 OM33
+        9.77E-07  5.79E-06  4.14E-07 -7.56E-07  1.09E-06  1.40E-05  3.57E-07 -2.83E-06  7.04E-06  6.13E-06 -6.67E-06  6.64E-07
          6.53E-07  2.71E-06  1.52E-06  7.64E-07  3.62E-06  1.56E-06  1.12E-05
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+        6.17E-07  5.22E-06  3.34E-07 -7.94E-07  5.60E-08  1.21E-05  4.14E-07 -2.57E-06  5.82E-06  4.71E-06 -4.96E-06  4.68E-07
          4.71E-07  1.82E-06  1.24E-06  5.07E-07  2.59E-06  1.25E-06  7.35E-06  5.92E-06
 
 OM44
+        1.97E-07  4.21E-06  2.96E-07 -7.01E-07 -7.50E-07  9.94E-06  4.60E-07 -2.19E-06  4.22E-06  3.48E-06 -3.65E-06  3.19E-07
          3.18E-07  1.13E-06  9.24E-07  3.33E-07  1.58E-06  1.02E-06  4.50E-06  4.11E-06  4.01E-06
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************         OBJECTIVE FUNCTION EVALUATION BY IMPORTANCE SAMPLING (NO PRIOR)        ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (R)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        3.26E-02
 
 TH 2
+        1.57E-02  2.86E-02
 
 TH 3
+       -9.68E-01 -9.33E-03  9.51E-03
 
 TH 4
+       -3.47E-03 -9.59E-01  8.01E-04  8.28E-03
 
 TH 5
+        2.22E-01  2.23E-02 -2.05E-01 -7.36E-03  3.86E-02
 
 TH 6
+        2.47E-02  2.78E-01 -1.55E-02 -2.47E-01  3.04E-02  3.49E-02
 
 TH 7
+       -2.13E-01 -2.39E-02  2.05E-01  8.15E-03 -9.69E-01 -3.17E-02  1.12E-02
 
 TH 8
+       -1.37E-02 -2.55E-01  8.53E-03  2.51E-01 -1.40E-02 -9.56E-01  1.51E-02  1.01E-02
 
 TH 9
+        1.21E-01  1.56E-01 -8.78E-02 -5.63E-02  1.44E-01  2.11E-01 -1.56E-01 -1.23E-01  1.02E-02
 
 TH10
+        9.11E-02  1.31E-01 -5.80E-02 -5.09E-02  1.58E-01  2.12E-01 -1.59E-01 -1.13E-01  6.86E-01  8.42E-03
 
 TH11
+        7.56E-03 -4.02E-02 -1.88E-02  2.28E-02  3.12E-02 -8.73E-02 -4.09E-02  7.05E-02 -1.01E-01 -1.04E-01  3.27E-03
 
 OM11
+        1.21E-02  1.19E-02 -1.18E-03 -8.61E-05  1.12E-02  3.98E-02 -8.51E-04 -2.33E-02  9.34E-02  9.49E-02 -2.09E-01  9.52E-04
 
 OM12
+        5.08E-03  9.20E-03  8.60E-03  8.18E-03  2.81E-03  2.78E-02  1.62E-02 -5.64E-03  1.06E-01  1.06E-01 -2.57E-01  3.56E-01
          8.18E-04
 
 OM13
+        1.92E-02  4.36E-02  5.53E-03 -2.00E-02  2.64E-02  8.95E-02 -9.20E-03 -5.66E-02  1.95E-01  2.08E-01 -3.95E-01  4.14E-01
          2.73E-01  1.28E-03
 
 OM14
+        3.59E-02 -1.11E-02 -1.91E-02  4.07E-02  1.75E-02  8.23E-02 -5.42E-03 -5.21E-02  1.95E-01  1.82E-01 -3.76E-01  3.49E-01
          3.03E-01  6.90E-01  9.71E-04
 
 OM22
+       -9.88E-03  9.19E-03  1.73E-02  1.22E-04 -3.76E-02 -5.10E-04  5.55E-02  1.17E-02  2.66E-02  2.64E-02 -3.45E-01  8.04E-02
          3.22E-01  1.06E-01  1.06E-01  1.33E-03
 
 OM23
+        1.75E-02  5.00E-02  2.92E-03 -1.95E-02  3.64E-02  7.61E-02 -9.39E-03 -4.26E-02  2.39E-01  2.26E-01 -4.03E-01  1.82E-01
          3.27E-01  5.45E-01  3.86E-01  2.41E-01  1.62E-03
 
 OM24
+        1.13E-02  3.20E-02  4.59E-03 -6.76E-03  3.75E-02  1.10E-02 -2.13E-02  2.00E-02  1.97E-01  1.86E-01 -3.20E-01  1.33E-01
          2.72E-01  3.43E-01  3.92E-01  3.06E-01  6.54E-01  1.09E-03
 
 OM33
+        8.95E-03  6.05E-02  1.30E-02 -2.72E-02  8.41E-03  1.20E-01  9.56E-03 -8.35E-02  2.06E-01  2.17E-01 -6.08E-01  2.08E-01
          2.38E-01  6.33E-01  4.69E-01  1.71E-01  6.68E-01  4.28E-01  3.35E-03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+        7.78E-03  7.51E-02  1.44E-02 -3.94E-02  5.97E-04  1.43E-01  1.52E-02 -1.05E-01  2.35E-01  2.30E-01 -6.22E-01  2.02E-01
          2.36E-01  5.85E-01  5.24E-01  1.56E-01  6.58E-01  4.74E-01  9.02E-01  2.43E-03
 
 OM44
+        3.03E-03  7.37E-02  1.56E-02 -4.23E-02 -9.71E-03  1.42E-01  2.06E-02 -1.08E-01  2.06E-01  2.07E-01 -5.56E-01  1.67E-01
          1.94E-01  4.41E-01  4.75E-01  1.25E-01  4.88E-01  4.68E-01  6.71E-01  8.45E-01  2.00E-03
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************         OBJECTIVE FUNCTION EVALUATION BY IMPORTANCE SAMPLING (NO PRIOR)        ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (R)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        1.59E+04
 
 TH 2
+        0.00E+00  1.85E+04
 
 TH 3
+        5.24E+04  0.00E+00  1.85E+05
 
 TH 4
+        0.00E+00  6.07E+04  0.00E+00  2.15E+05
 
 TH 5
+       -2.02E+03  0.00E+00 -6.32E+03  0.00E+00  1.14E+04
 
 TH 6
+        0.00E+00 -3.53E+03  0.00E+00 -1.14E+04  0.00E+00  1.19E+04
 
 TH 7
+       -6.32E+03  0.00E+00 -2.16E+04  0.00E+00  3.81E+04  0.00E+00  1.36E+05
 
 TH 8
+        0.00E+00 -1.14E+04  0.00E+00 -3.99E+04  0.00E+00  3.85E+04  0.00E+00  1.36E+05
 
 TH 9
+       -1.23E+03 -3.87E+03 -3.22E+03 -1.24E+04  1.15E+03 -8.00E+02  4.54E+03 -1.87E+03  2.00E+04
 
 TH10
+       -8.19E+02 -3.25E+02 -2.97E+03 -1.00E+03 -4.80E+02 -3.34E+03 -4.24E+02 -1.03E+04 -1.41E+04  2.84E+04
 
 TH11
+       -5.85E+02 -4.08E+02 -1.88E+03 -1.66E+03 -1.13E+03 -9.26E+02 -3.42E+03 -3.70E+03 -1.24E+03 -1.41E+03  1.81E+05
 
 OM11
+        3.62E+02  3.35E+01  1.50E+03 -1.16E+02 -1.46E+03 -4.96E+02 -5.04E+03 -1.24E+03 -2.02E+03 -4.78E+02  3.74E+04  1.48E+06
 
 OM12
+       -2.47E+03 -7.88E+02 -9.81E+03 -2.68E+03 -3.92E+03 -2.81E+03 -1.43E+04 -1.08E+04 -3.70E+02 -2.99E+03  2.19E+04 -4.86E+05
          2.05E+06
 
 OM13
+       -6.63E+03  5.07E+03 -2.55E+04  2.61E+04  8.71E+01 -1.76E+03  1.24E+03 -8.17E+03  2.72E+03 -7.96E+03 -2.06E+04 -4.34E+05
          1.21E+05  1.82E+06
 
 OM14
+        2.86E+03 -3.63E+03  1.57E+04 -3.09E+04 -1.28E+03  1.04E+02 -5.61E+03  4.91E+03 -8.53E+03  3.42E+03  4.13E+04 -8.27E+04
         -3.09E+05 -1.18E+06  2.49E+06
 
 OM22
+       -9.51E+02 -1.69E+03 -3.14E+03 -5.61E+03 -3.31E+03 -1.47E+03 -1.50E+04 -5.05E+03  1.39E+03  1.54E+03  1.12E+05  4.75E+04
         -2.92E+05  1.48E+04  7.37E+04  7.49E+05
 
 OM23
+        2.07E+03  3.03E+02  7.81E+03 -1.43E+03 -7.58E+03  1.86E+03 -2.62E+04  8.39E+03 -8.68E+03 -8.83E+02 -2.38E+04  7.78E+04
         -2.46E+05 -3.62E+05  3.21E+05 -1.36E+04  1.15E+06
 
 OM24
+       -8.22E+02  1.37E+03 -4.97E+03  8.65E+03  1.59E+03  1.31E+02  9.50E+03 -1.19E+04 -3.40E+03 -3.77E+03 -2.37E+04  7.36E+03
          1.98E+04  2.49E+05 -4.65E+05 -2.36E+05 -7.59E+05  1.80E+06
 
 OM33
+       -2.14E+02 -2.07E+03 -2.67E+02 -9.59E+03 -8.57E+02 -6.32E+02 -2.55E+03 -2.31E+03  5.00E+03 -4.81E+03  6.29E+04  4.21E+04
         -4.93E+03 -3.16E+05  2.15E+05  4.94E+03 -7.99E+04  1.44E+03  6.66E+05
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+       -1.19E+03  1.75E+01 -5.37E+03  4.46E+03  1.33E+03 -1.57E+03  3.33E+03 -3.85E+03 -9.23E+03  6.16E+03  3.31E+04  1.32E+04
          6.69E+04  1.92E+05 -3.72E+05  3.91E+04 -3.41E+05  2.00E+05 -9.00E+05  2.22E+06
 
 OM44
+       -5.37E+02 -8.64E+02 -2.22E+03 -2.35E+03 -3.35E+02 -1.33E+03 -2.98E+03  5.33E+01  2.38E+03 -6.08E+03  6.10E+04  1.64E+03
         -8.11E+03  9.27E+03 -3.91E+04  5.79E+04  2.10E+05 -3.31E+05  2.99E+05 -1.12E+06  1.13E+06
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1


 #TBLN:      5
 #METH: MCMC Bayesian Analysis

 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            2208
 NO. OF SIG. FIGURES REQUIRED:            2
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    0
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      8
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     8
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): example2.TXT
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 EM OR BAYESIAN METHOD USED:                MCMC BAYESIAN (BAYES)
 BAYES INDIVIDUAL PARAMETERS ONLY: NO
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):              DDDDDDDDDDS
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  3
 KEEP ITERATIONS (THIN):            1
 CONVERGENCE INTERVAL (CINTERVAL):          100
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 BURN-IN ITERATIONS (NBURN):                10000
 FIRST ITERATION FOR MAP (MAPITERS):          NO
 ITERATIONS (NITER):                        3000
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       123334
 MC SAMPLES PER SUBJECT (ISAMPLE):          1
 RANDOM SAMPLING METHOD (RANMETHOD):        3U
 PROPOSAL DENSITY SCALING RANGE
              (ISCALE_MIN, ISCALE_MAX):     1.000000000000000E-06   ,1000000.00000000
 SAMPLE ACCEPTANCE RATE (IACCEPT):          0.400000000000000
 METROPOLIS HASTINGS SAMPLING FOR INDIVIDUAL ETAS:
 SAMPLES FOR GLOBAL SEARCH KERNEL (ISAMPLE_M1):          2
 SAMPLES FOR NEIGHBOR SEARCH KERNEL (ISAMPLE_M1A):       0
 SAMPLES FOR MASS/IMP/POST. MATRIX SEARCH (ISAMPLE_M1B): 2
 SAMPLES FOR LOCAL SEARCH KERNEL (ISAMPLE_M2):           2
 SAMPLES FOR LOCAL UNIVARIATE KERNEL (ISAMPLE_M3):       2
 PWR. WT. MASS/IMP/POST MATRIX ACCUM. FOR ETAS (IKAPPA): 1.00000000000000
 MASS/IMP./POST. MATRIX REFRESH SETTING (MASSRESET):      -1
 METROPOLIS HASTINGS POPULATION SAMPLING FOR NON-GIBBS
 SAMPLED THETAS AND SIGMAS:
 PROPOSAL DENSITY SCALING RANGE
              (PSCALE_MIN, PSCALE_MAX):   1.000000000000000E-02   ,1000.00000000000
 SAMPLE ACCEPTANCE RATE (PACCEPT):                       0.500000000000000
 SAMPLES FOR GLOBAL SEARCH KERNEL (PSAMPLE_M1):          1
 SAMPLES FOR LOCAL SEARCH KERNEL (PSAMPLE_M2):           1
 SAMPLES FOR LOCAL UNIVARIATE KERNEL (PSAMPLE_M3):       1
 METROPOLIS HASTINGS POPULATION SAMPLING FOR NON-GIBBS
 SAMPLED OMEGAS:
 SAMPLE ACCEPTANCE RATE (OACCEPT):                       0.500000000000000
 SAMPLES FOR GLOBAL SEARCH KERNEL (OSAMPLE_M1):          -1
 SAMPLES FOR LOCAL SEARCH KERNEL (OSAMPLE_M2):           10
 SAMPLES FOR LOCAL UNIVARIATE SEARCH KERNEL (OSAMPLE_M3):10
 USER DEFINED PRIOR SETTING FOR THETAS: (TPU):        0.00000000000000
 WEIGHT FACTOR FOR STD PRIOR FOR SIGMAS (SVARF): -1.000000000000000+300


 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI

 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2   3   4   5   6   7   8   9  10
 THETAS THAT ARE GIBBS SAMPLED:
   1   2   3   4   5   6   7   8   9  10
 THETAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
  11
 SIGMAS THAT ARE GIBBS SAMPLED:
 
 SIGMAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 OMEGAS ARE GIBBS SAMPLED

 MONITORING OF SEARCH:

 Burn-in Mode
 iteration       -10000 MCMCOBJ=   -19659.391468564638     
 iteration        -9900 MCMCOBJ=   -19440.600773073311     
 iteration        -9800 MCMCOBJ=   -19450.139486238455     
 iteration        -9700 MCMCOBJ=   -19449.901883434988     
 iteration        -9600 MCMCOBJ=   -19468.376806318160     
 iteration        -9500 MCMCOBJ=   -19271.480958764234     
 iteration        -9400 MCMCOBJ=   -19433.342833401526     
 iteration        -9300 MCMCOBJ=   -19289.284137973496     
 iteration        -9200 MCMCOBJ=   -19460.236725600262     
 iteration        -9100 MCMCOBJ=   -19255.372132006909     
 iteration        -9000 MCMCOBJ=   -19245.271981742870     
 iteration        -8900 MCMCOBJ=   -19203.031811093642     
 iteration        -8800 MCMCOBJ=   -19361.378974596239     
 Convergence achieved
 Sampling Mode
 iteration            0 MCMCOBJ=   -19283.031094714926     
 iteration          100 MCMCOBJ=   -19287.266732142878     
 iteration          200 MCMCOBJ=   -19394.731803066796     
 iteration          300 MCMCOBJ=   -19273.385976680987     
 iteration          400 MCMCOBJ=   -19192.471012926449     
 iteration          500 MCMCOBJ=   -19244.940865563869     
 iteration          600 MCMCOBJ=   -19315.387521947781     
 iteration          700 MCMCOBJ=   -19317.542400406852     
 iteration          800 MCMCOBJ=   -19225.526309552210     
 iteration          900 MCMCOBJ=   -19392.080679773819     
 iteration         1000 MCMCOBJ=   -19191.097046670842     
 iteration         1100 MCMCOBJ=   -19256.748629706901     
 iteration         1200 MCMCOBJ=   -19389.245341603793     
 iteration         1300 MCMCOBJ=   -19284.082891606005     
 iteration         1400 MCMCOBJ=   -19286.840693137867     
 iteration         1500 MCMCOBJ=   -19262.984341133746     
 iteration         1600 MCMCOBJ=   -19194.542165278268     
 iteration         1700 MCMCOBJ=   -19345.320492840612     
 iteration         1800 MCMCOBJ=   -19584.915163463069     
 iteration         1900 MCMCOBJ=   -19144.755476588551     
 iteration         2000 MCMCOBJ=   -19258.876401527796     
 iteration         2100 MCMCOBJ=   -19446.436965492605     
 iteration         2200 MCMCOBJ=   -19398.478214983330     
 iteration         2300 MCMCOBJ=   -19409.697897364640     
 iteration         2400 MCMCOBJ=   -19507.019194819622     
 iteration         2500 MCMCOBJ=   -19084.555232683950     
 iteration         2600 MCMCOBJ=   -19240.358479221723     
 iteration         2700 MCMCOBJ=   -19124.223510876767     
 iteration         2800 MCMCOBJ=   -19456.282543203819     
 iteration         2900 MCMCOBJ=   -19184.576844993750     
 iteration         3000 MCMCOBJ=   -19108.453776798353     

 #TERM:
 BURN-IN WAS COMPLETED
 STATISTICAL PORTION WAS COMPLETED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.

 ETABAR:        -7.9236E-05  3.5539E-05 -1.0187E-05 -2.8787E-05
 SE:             4.6627E-03  2.8762E-03  2.5225E-03  3.5046E-03
 N:                     400         400         400         400

 P VAL.:         9.8644E-01  9.9014E-01  9.9678E-01  9.9345E-01

 ETASHRINKSD(%)  7.3261E+00  3.4606E+01  4.1871E+01  2.3685E+01
 ETASHRINKVR(%)  1.4115E+01  5.7236E+01  6.6210E+01  4.1760E+01
 EBVSHRINKSD(%)  6.8293E+00  3.4569E+01  4.1703E+01  2.3303E+01
 EBVSHRINKVR(%)  1.3192E+01  5.7188E+01  6.6015E+01  4.1176E+01
 RELATIVEINF(%)  7.0008E+01  3.7500E+01  1.7590E+01  2.8679E+01
 EPSSHRINKSD(%)  2.5575E+01
 EPSSHRINKVR(%)  4.4609E+01

  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         2000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    3675.7541328186908     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -19285.930721363904     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -15610.176588545213     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          1600
 NIND*NETA*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    2940.6033062549527     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -19285.930721363904     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -16345.327415108952     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 PRIOR CONSTANT TO OBJECTIVE FUNCTION:    70.363912812525712     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -19285.930721363904     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -19215.566808551379     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:   257.11
 Elapsed covariance  time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 #OBJT:**************                       AVERAGE VALUE OF LIKELIHOOD FUNCTION                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -19285.931       **************************************************
 #OBJS:********************************************      127.325 (STD) **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11     
 
         3.30E+00  3.25E+00 -6.12E-01 -2.08E-01  7.35E-01  1.13E+00  3.35E-01  1.93E-01  6.90E-01  2.30E+00  1.02E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        1.01E-02
 
 ETA2
+       -4.70E-06  7.74E-03
 
 ETA3
+        5.32E-04 -5.92E-04  7.53E-03
 
 ETA4
+       -1.14E-03  3.02E-04  6.39E-05  8.44E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        1.01E-01
 
 ETA2
+       -3.21E-03  8.77E-02
 
 ETA3
+        5.63E-02 -8.52E-02  8.61E-02
 
 ETA4
+       -1.29E-01  3.55E-02 -1.48E-02  9.15E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************                STANDARD ERROR OF ESTIMATE (From Sample Variance)               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11     
 
         3.29E-02  2.80E-02  9.54E-03  8.19E-03  3.88E-02  3.45E-02  1.13E-02  9.98E-03  1.11E-02  8.98E-03  2.72E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        9.29E-04
 
 ETA2
+        7.55E-04  1.31E-03
 
 ETA3
+        1.07E-03  1.22E-03  1.94E-03
 
 ETA4
+        8.82E-04  9.02E-04  1.37E-03  1.51E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        0.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        4.60E-03
 
 ETA2
+        8.58E-02  7.42E-03
 
 ETA3
+        1.21E-01  1.65E-01  1.10E-02
 
 ETA4
+        1.01E-01  1.12E-01  1.63E-01  8.20E-03
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        0.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************               COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        1.08E-03
 
 TH 2
+        1.49E-05  7.87E-04
 
 TH 3
+       -3.04E-04 -2.17E-06  9.10E-05
 
 TH 4
+       -8.53E-07 -2.19E-04 -8.60E-08  6.71E-05
 
 TH 5
+        2.80E-04  9.62E-06 -7.63E-05  5.34E-06  1.51E-03
 
 TH 6
+        2.69E-05  2.39E-04 -5.52E-06 -6.15E-05 -5.12E-06  1.19E-03
 
 TH 7
+       -7.66E-05 -2.38E-06  2.17E-05 -1.62E-06 -4.25E-04  9.57E-10  1.27E-04
 
 TH 8
+       -1.17E-07 -6.26E-05 -1.55E-07  1.85E-05  1.37E-05 -3.27E-04 -3.75E-06  9.97E-05
 
 TH 9
+        6.20E-05  3.99E-05 -1.45E-05 -9.91E-07  8.14E-05  6.30E-05 -2.40E-05 -5.29E-06  1.23E-04
 
 TH10
+        3.69E-05  3.10E-05 -8.04E-06 -1.96E-06  7.01E-05  6.59E-05 -2.02E-05 -7.78E-06  7.18E-05  8.07E-05
 
 TH11
+       -5.27E-07  3.20E-06  2.93E-07 -6.03E-07  1.39E-06  2.40E-06 -5.59E-07 -2.85E-08  3.78E-06  2.52E-06  7.39E-06
 
 OM11
+       -1.85E-07 -4.64E-07 -5.15E-08  3.87E-08  4.98E-07 -3.32E-07 -4.02E-08  4.73E-08 -2.87E-07 -2.30E-07 -4.43E-07  8.62E-07
 
 OM12
+       -2.95E-07 -4.12E-07  6.50E-08  1.48E-07  5.83E-07 -5.71E-07 -5.15E-08  1.87E-07  2.55E-07  1.22E-07 -2.55E-07  1.86E-07
          5.69E-07
 
 OM13
+       -4.31E-07 -1.24E-06  2.40E-07  2.74E-07 -1.84E-07 -1.28E-06  3.03E-07  4.24E-07 -5.90E-07 -9.47E-08 -4.06E-07  3.73E-07
          9.65E-08  1.15E-06
 
 OM14
+        9.78E-07 -6.28E-07 -2.40E-07  1.49E-07  5.84E-07 -6.99E-08  2.06E-08  3.41E-08 -3.15E-07 -1.56E-07 -4.33E-07  2.61E-07
          1.26E-07  5.74E-07  7.79E-07
 
 OM22
+       -4.05E-07 -1.20E-06  1.80E-07  4.44E-07  1.62E-06 -2.22E-06 -1.26E-07  6.45E-07 -4.51E-08 -3.40E-07 -1.12E-06  2.57E-08
          2.19E-07 -3.19E-08  9.27E-09  1.70E-06
 
 OM23
+       -1.56E-07 -1.58E-07  8.14E-08  1.26E-07  7.55E-07 -7.59E-07  1.36E-08  3.60E-07  1.24E-06  9.13E-07  2.89E-07 -1.70E-08
          1.56E-07  2.80E-07  2.20E-08  7.59E-08  1.48E-06
 
 OM24
+       -2.36E-07 -3.59E-07  6.44E-08  1.65E-07  3.46E-09 -1.23E-06  1.40E-07  3.92E-07  4.94E-07  4.18E-07  5.17E-09  1.33E-08
          9.79E-08  7.51E-08  1.08E-07  2.10E-07  5.34E-07  8.14E-07
 
 OM33
+        7.86E-07 -8.87E-07 -9.97E-08  2.50E-07  7.63E-07  2.10E-07 -1.62E-07  3.51E-08 -2.72E-07 -4.16E-08 -1.21E-06  1.13E-07
          4.67E-08  5.98E-07  1.87E-07 -4.81E-08  4.68E-07  4.72E-08  3.75E-06
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+        1.19E-06  3.17E-08 -2.36E-07 -3.19E-08 -2.31E-07  3.53E-06  1.39E-07 -1.06E-06 -2.44E-07 -6.15E-08 -8.48E-07  4.79E-08
         -8.21E-09  2.72E-07  2.35E-07 -7.75E-08  2.12E-07  7.13E-08  1.74E-06  1.87E-06
 
 OM44
+        5.15E-07  4.73E-07 -1.80E-07 -8.74E-08 -4.44E-07  5.16E-06  9.20E-08 -1.66E-06 -9.87E-08  1.47E-07 -8.83E-07  2.60E-08
         -2.99E-08  8.39E-08  2.54E-07 -1.60E-08 -1.17E-07  1.52E-07  5.63E-07  1.37E-06  2.29E-06
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************              CORRELATION MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        3.29E-02
 
 TH 2
+        1.61E-02  2.80E-02
 
 TH 3
+       -9.69E-01 -8.12E-03  9.54E-03
 
 TH 4
+       -3.16E-03 -9.55E-01 -1.10E-03  8.19E-03
 
 TH 5
+        2.19E-01  8.84E-03 -2.06E-01  1.68E-02  3.88E-02
 
 TH 6
+        2.38E-02  2.48E-01 -1.68E-02 -2.18E-01 -3.83E-03  3.45E-02
 
 TH 7
+       -2.06E-01 -7.51E-03  2.01E-01 -1.75E-02 -9.70E-01  2.46E-06  1.13E-02
 
 TH 8
+       -3.56E-04 -2.23E-01 -1.63E-03  2.27E-01  3.53E-02 -9.51E-01 -3.33E-02  9.98E-03
 
 TH 9
+        1.70E-01  1.28E-01 -1.37E-01 -1.09E-02  1.89E-01  1.65E-01 -1.92E-01 -4.78E-02  1.11E-02
 
 TH10
+        1.25E-01  1.23E-01 -9.39E-02 -2.66E-02  2.01E-01  2.13E-01 -1.99E-01 -8.67E-02  7.21E-01  8.98E-03
 
 TH11
+       -5.90E-03  4.20E-02  1.13E-02 -2.71E-02  1.31E-02  2.56E-02 -1.82E-02 -1.05E-03  1.26E-01  1.03E-01  2.72E-03
 
 OM11
+       -6.06E-03 -1.78E-02 -5.82E-03  5.09E-03  1.38E-02 -1.04E-02 -3.84E-03  5.11E-03 -2.79E-02 -2.75E-02 -1.75E-01  9.29E-04
 
 OM12
+       -1.19E-02 -1.95E-02  9.04E-03  2.39E-02  1.99E-02 -2.19E-02 -6.05E-03  2.48E-02  3.05E-02  1.80E-02 -1.24E-01  2.66E-01
          7.55E-04
 
 OM13
+       -1.22E-02 -4.13E-02  2.35E-02  3.12E-02 -4.41E-03 -3.47E-02  2.50E-02  3.96E-02 -4.96E-02 -9.82E-03 -1.39E-01  3.74E-01
          1.19E-01  1.07E-03
 
 OM14
+        3.37E-02 -2.54E-02 -2.86E-02  2.06E-02  1.70E-02 -2.30E-03  2.07E-03  3.87E-03 -3.22E-02 -1.97E-02 -1.80E-01  3.18E-01
          1.89E-01  6.06E-01  8.82E-04
 
 OM22
+       -9.43E-03 -3.27E-02  1.45E-02  4.15E-02  3.19E-02 -4.94E-02 -8.58E-03  4.95E-02 -3.12E-03 -2.90E-02 -3.17E-01  2.12E-02
          2.22E-01 -2.28E-02  8.04E-03  1.31E-03
 
 OM23
+       -3.91E-03 -4.65E-03  7.02E-03  1.27E-02  1.60E-02 -1.81E-02  9.94E-04  2.97E-02  9.24E-02  8.36E-02  8.73E-02 -1.50E-02
          1.70E-01  2.15E-01  2.05E-02  4.78E-02  1.22E-03
 
 OM24
+       -7.96E-03 -1.42E-02  7.48E-03  2.24E-02  9.87E-05 -3.95E-02  1.37E-02  4.35E-02  4.93E-02  5.15E-02  2.11E-03  1.59E-02
          1.44E-01  7.75E-02  1.36E-01  1.78E-01  4.87E-01  9.02E-04
 
 OM33
+        1.23E-02 -1.63E-02 -5.40E-03  1.58E-02  1.01E-02  3.15E-03 -7.41E-03  1.81E-03 -1.27E-02 -2.39E-03 -2.31E-01  6.31E-02
          3.20E-02  2.88E-01  1.09E-01 -1.90E-02  1.99E-01  2.70E-02  1.94E-03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+        2.64E-02  8.27E-04 -1.81E-02 -2.85E-03 -4.35E-03  7.50E-02  9.00E-03 -7.75E-02 -1.61E-02 -5.01E-03 -2.28E-01  3.77E-02
         -7.96E-03  1.85E-01  1.95E-01 -4.34E-02  1.28E-01  5.78E-02  6.59E-01  1.37E-03
 
 OM44
+        1.04E-02  1.11E-02 -1.25E-02 -7.05E-03 -7.57E-03  9.90E-02  5.39E-03 -1.10E-01 -5.89E-03  1.08E-02 -2.15E-01  1.85E-02
         -2.62E-02  5.17E-02  1.90E-01 -8.13E-03 -6.34E-02  1.11E-01  1.92E-01  6.65E-01  1.51E-03
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************           INVERSE COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        1.63E+04
 
 TH 2
+        1.75E+02  1.81E+04
 
 TH 3
+        5.41E+04  1.60E+02  1.91E+05
 
 TH 4
+        8.38E+02  5.92E+04  1.40E+03  2.09E+05
 
 TH 5
+       -1.99E+03 -3.46E+02 -6.05E+03 -1.05E+03  1.18E+04
 
 TH 6
+       -1.42E+02 -3.47E+03 -2.90E+02 -1.12E+04  4.26E+02  1.17E+04
 
 TH 7
+       -6.39E+03 -1.13E+03 -2.12E+04 -3.28E+03  3.94E+04  1.49E+03  1.40E+05
 
 TH 8
+       -4.84E+02 -1.13E+04 -9.90E+02 -3.94E+04  1.30E+03  3.80E+04  4.99E+03  1.34E+05
 
 TH 9
+       -1.39E+03 -4.00E+03 -3.22E+03 -1.32E+04  4.41E+02 -9.93E+02  2.03E+03 -3.43E+03  1.87E+04
 
 TH10
+       -7.23E+02 -2.73E+02 -2.84E+03 -6.96E+02 -5.96E+02 -3.90E+03 -5.33E+02 -1.14E+04 -1.43E+04  2.79E+04
 
 TH11
+       -4.61E+02 -2.58E+02 -2.87E+03 -2.79E+02 -8.63E+02 -1.75E+03 -2.57E+03 -5.83E+03 -4.04E+03  2.29E+02  1.80E+05
 
 OM11
+        1.02E+04  4.55E+03  3.50E+04  1.66E+04 -2.37E+03  4.10E+02 -5.98E+03  2.98E+03 -5.09E+03  3.72E+03  5.82E+04  1.50E+06
 
 OM12
+        2.02E+03 -8.54E+02  3.75E+03 -4.69E+03 -2.24E+03  5.89E+02 -7.69E+03  1.09E+03 -3.23E+03 -1.46E+03  2.02E+04 -4.22E+05
          2.11E+06
 
 OM13
+       -8.26E+03  3.01E+03 -3.39E+04  7.10E+03 -3.93E+03 -2.56E+03 -1.66E+04 -1.32E+04  1.15E+04 -9.40E+03  1.42E+03 -4.30E+05
          1.85E+05  1.76E+06
 
 OM14
+       -4.54E+02 -1.23E+03  6.21E+03 -4.52E+03 -5.68E+03 -2.29E+03 -1.66E+04 -5.84E+03 -4.09E+03  7.38E+03  4.96E+04 -1.02E+05
         -3.38E+05 -1.19E+06  2.37E+06
 
 OM22
+       -2.14E+03 -2.74E+03 -9.34E+03 -1.14E+04 -8.26E+03 -1.47E+03 -2.61E+04 -6.98E+03 -3.89E+03  6.09E+03  1.22E+05  6.09E+04
         -2.30E+05  1.77E+04  7.13E+04  7.30E+05
 
 OM23
+        4.08E+03  1.24E+03  1.36E+04  4.34E+03 -4.35E+03  1.40E+03 -1.45E+04  5.61E+03 -7.97E+03 -1.20E+03 -4.34E+04  1.37E+05
         -2.44E+05 -3.69E+05  3.20E+05  2.35E+04  1.11E+06
 
 OM24
+        6.29E+02 -7.10E+02  1.09E+03 -3.00E+03 -6.69E+02  2.05E+03 -5.28E+03  2.54E+02  2.89E+03 -6.13E+03 -2.41E+04 -3.36E+04
         -2.91E+03  2.22E+05 -3.70E+05 -1.92E+05 -7.23E+05  1.82E+06
 
 OM33
+        1.69E+03 -1.92E+03  5.25E+03 -6.90E+03  2.08E+03 -1.92E+02  8.88E+03 -2.76E+03 -9.28E+02 -5.84E+02  5.68E+04  3.38E+04
         -3.18E+04 -2.44E+05  1.87E+05  2.32E+04 -1.70E+04 -2.23E+04  6.41E+05
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+       -9.01E+03  4.52E+03 -2.78E+04  1.54E+04 -3.85E+03 -3.96E+03 -1.55E+04 -8.86E+03  1.41E+03  5.42E+03 -8.69E+03 -7.84E+03
          7.92E+04  1.73E+05 -2.53E+05  3.73E+04 -2.53E+05  2.23E+05 -8.06E+05  2.11E+06
 
 OM44
+        5.64E+03 -4.31E+03  1.76E+04 -1.55E+04  2.76E+03  3.67E+03  1.03E+04  1.81E+04 -8.79E+02 -5.15E+03  5.47E+04  3.37E+04
          1.64E+04 -6.21E+03 -5.63E+04  2.30E+04  2.17E+05 -2.67E+05  3.35E+05 -1.07E+06  1.06E+06
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1


 #TBLN:      6
 #METH: First Order Conditional Estimation with Interaction (No Prior)

 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            9999
 NO. OF SIG. FIGURES REQUIRED:            2
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    0
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      14
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     14
 NOPRIOR SETTING (NOPRIOR):                 1
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): example2.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 ADDITIONAL CONVERGENCE TEST (CTYPE=4)?:    NO
 EM OR BAYESIAN METHOD USED:                 NONE


 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI

 MONITORING OF SEARCH:


0ITERATION NO.:    0    OBJECTIVE VALUE:  -10769.8710342768        NO. OF FUNC. EVALS.:  13
 CUMULATIVE NO. OF FUNC. EVALS.:       13
 NPARAMETR:  3.2986E+00  3.2521E+00 -6.1174E-01 -2.0819E-01  7.3500E-01  1.1345E+00  3.3508E-01  1.9271E-01  6.9003E-01  2.2982E+00
             1.0229E-01  1.0126E-02 -4.7003E-06  5.3228E-04 -1.1431E-03  7.7377E-03 -5.9169E-04  3.0205E-04  7.5325E-03  6.3892E-05
             8.4355E-03
 PARAMETER:  1.0000E-01  1.0000E-01 -1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
             1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
             1.0000E-01
 GRADIENT:  -5.3441E+03 -4.9648E+03 -3.2745E+03 -1.0568E+03 -5.4093E+02  2.2638E+02 -9.4208E+02  1.2384E+02 -1.6623E+02 -2.6109E+02
             3.6698E+01  5.3939E+00 -6.8516E-03 -1.5878E+00 -2.2618E+00  2.8139E+00  1.6569E+00 -2.5898E-01  1.9993E+00 -1.4227E+00
             6.4769E+00

0ITERATION NO.:    5    OBJECTIVE VALUE:  -10770.9480923904        NO. OF FUNC. EVALS.:  96
 CUMULATIVE NO. OF FUNC. EVALS.:      109
 NPARAMETR:  3.3051E+00  3.2577E+00 -6.1179E-01 -2.0807E-01  7.3572E-01  1.1367E+00  3.3593E-01  1.9289E-01  6.9590E-01  2.3023E+00
             1.0228E-01  1.0125E-02 -4.7002E-06  5.3230E-04 -1.1430E-03  7.7377E-03 -5.9171E-04  3.0205E-04  7.5324E-03  6.3896E-05
             8.4353E-03
 PARAMETER:  1.0020E-01  1.0017E-01 -1.0001E-01 -9.9944E-02  1.0010E-01  1.0020E-01  1.0026E-01  1.0010E-01  1.0085E-01  1.0018E-01
             9.9924E-02  9.9986E-02 -1.0000E-01  1.0000E-01 -9.9995E-02  9.9996E-02 -1.0000E-01  1.0000E-01  9.9997E-02  1.0000E-01
             9.9986E-02
 GRADIENT:   2.1249E+01 -9.9633E+00  4.2579E+01 -9.2950E-01 -8.5806E+01  1.1890E+02 -1.2641E+02  9.7414E+01  2.0414E+02  2.8494E+02
             3.0625E+01  5.9858E+00 -1.0756E-02 -1.7343E+00 -2.9957E+00  1.3176E+00  1.2397E+00 -1.5428E-01  1.6086E+00 -1.4836E+00
             5.8235E+00

0ITERATION NO.:   10    OBJECTIVE VALUE:  -10771.1327707716        NO. OF FUNC. EVALS.:  88
 CUMULATIVE NO. OF FUNC. EVALS.:      197
 NPARAMETR:  3.3062E+00  3.2563E+00 -6.1216E-01 -2.0773E-01  7.3571E-01  1.1366E+00  3.3591E-01  1.9272E-01  6.9570E-01  2.3021E+00
             1.0112E-01  1.0074E-02 -4.6882E-06  5.3485E-04 -1.1263E-03  7.7303E-03 -5.9482E-04  3.0203E-04  7.5242E-03  6.4897E-05
             8.3918E-03
 PARAMETER:  1.0023E-01  1.0013E-01 -1.0007E-01 -9.9778E-02  1.0010E-01  1.0019E-01  1.0025E-01  1.0000E-01  1.0082E-01  1.0017E-01
             8.7201E-02  9.7463E-02 -9.9995E-02  1.0074E-01 -9.8777E-02  9.9516E-02 -1.0058E-01  1.0004E-01  9.9387E-02  1.0064E-01
             9.7545E-02
 GRADIENT:   6.4824E+01  7.9079E-01  1.5743E+01  2.5512E+01 -7.8720E+01 -4.5342E+00 -1.1697E+02  1.9175E+01  2.3475E+02  2.9456E+02
            -7.5206E+00  1.2677E+00 -1.1303E-02 -1.4515E+00 -2.6345E+00 -2.6578E+00  1.4735E+00  4.0308E-02 -7.7576E-01 -1.4013E+00
             2.3354E+00

0ITERATION NO.:   15    OBJECTIVE VALUE:  -10771.2200211718        NO. OF FUNC. EVALS.:  79
 CUMULATIVE NO. OF FUNC. EVALS.:      276
 NPARAMETR:  3.3062E+00  3.2557E+00 -6.1215E-01 -2.0755E-01  7.3492E-01  1.1362E+00  3.3614E-01  1.9286E-01  6.9563E-01  2.3021E+00
             1.0105E-01  1.0082E-02 -4.6691E-06  7.6958E-04 -9.0199E-04  7.8341E-03 -7.6428E-04  2.8595E-04  7.8272E-03  1.1734E-04
             8.2500E-03
 PARAMETER:  1.0023E-01  1.0011E-01 -1.0007E-01 -9.9692E-02  9.9989E-02  1.0015E-01  1.0032E-01  1.0008E-01  1.0081E-01  1.0017E-01
             8.6486E-02  9.7843E-02 -9.9551E-02  1.4489E-01 -7.9078E-02  1.0619E-01 -1.2837E-01  9.4113E-02  1.1549E-01  1.4334E-01
             9.1557E-02
 GRADIENT:   4.0781E+01 -3.1802E+01  2.7145E+00  1.8885E+01 -7.9700E+01 -4.9297E+00 -1.0695E+02  1.9288E+01  2.2366E+02  3.0031E+02
            -4.8498E+00 -3.7802E+00 -1.5545E-02 -3.1981E-01  4.1920E+00  5.4018E-02 -1.2548E+00  5.8172E-01  1.1182E+00 -1.3770E+00
            -2.7256E+00

0ITERATION NO.:   20    OBJECTIVE VALUE:  -10772.0139468252        NO. OF FUNC. EVALS.:  71
 CUMULATIVE NO. OF FUNC. EVALS.:      347
 NPARAMETR:  3.3055E+00  3.2575E+00 -6.1190E-01 -2.0808E-01  7.3527E-01  1.1393E+00  3.3622E-01  1.9194E-01  6.9481E-01  2.3017E+00
             1.0025E-01  1.0215E-02 -4.1655E-06  1.2738E-03 -6.6237E-04  7.8373E-03 -2.9428E-04  3.6961E-04  9.9048E-03  1.7725E-03
             9.6060E-03
 PARAMETER:  1.0021E-01  1.0016E-01 -1.0003E-01 -9.9950E-02  1.0004E-01  1.0043E-01  1.0034E-01  9.9602E-02  1.0069E-01  1.0015E-01
             7.7706E-02  1.0437E-01 -8.8235E-02  2.3826E-01 -5.7692E-02  1.0639E-01 -4.9352E-02  1.2171E-01  2.3313E-01  1.1127E+00
             1.5125E-01
 GRADIENT:  -1.5783E+01 -6.5458E+01 -1.7496E+01 -6.0167E+00 -2.4224E+01 -2.0805E+01 -3.6772E+01 -1.1001E+00  6.4005E+01  2.3687E+00
             2.7125E+00 -4.6945E-01 -2.4460E-02  1.0194E+00 -1.2475E+00  5.1618E-01  6.7481E-01 -8.9479E-01  3.4764E+00 -8.4206E-01
             7.2246E+00

0ITERATION NO.:   25    OBJECTIVE VALUE:  -10772.1228040374        NO. OF FUNC. EVALS.:  73
 CUMULATIVE NO. OF FUNC. EVALS.:      420
 NPARAMETR:  3.3054E+00  3.2579E+00 -6.1186E-01 -2.0818E-01  7.3523E-01  1.1401E+00  3.3628E-01  1.9177E-01  6.9493E-01  2.3018E+00
             1.0001E-01  1.0256E-02  1.0521E-04  1.3181E-03 -5.6401E-04  7.9088E-03 -1.8679E-04  5.2337E-04  9.9911E-03  2.0133E-03
             9.6432E-03
 PARAMETER:  1.0021E-01  1.0018E-01 -1.0002E-01 -9.9998E-02  1.0003E-01  1.0049E-01  1.0036E-01  9.9512E-02  1.0071E-01  1.0016E-01
             7.4973E-02  1.0641E-01  2.2241E+00  2.4604E-01 -4.9025E-02  1.1086E-01 -3.3502E-02  1.7360E-01  2.3731E-01  1.2445E+00
             1.4803E-01
 GRADIENT:   1.8936E+01  5.2650E+00  9.6105E+00  4.0111E+00 -1.2703E+01  2.1731E+00 -1.5283E+01  1.9108E+00  3.8682E+01  6.0720E+01
            -2.2566E+00 -8.8880E-01 -1.3841E-02  1.6806E-01  1.4485E+00 -4.2299E-02  1.3180E-01 -6.8483E-02 -1.0310E+00  1.3700E-01
            -1.8991E+00

0ITERATION NO.:   30    OBJECTIVE VALUE:  -10772.1430263230        NO. OF FUNC. EVALS.: 116
 CUMULATIVE NO. OF FUNC. EVALS.:      536            RESET HESSIAN, TYPE II
 NPARAMETR:  3.3052E+00  3.2580E+00 -6.1182E-01 -2.0823E-01  7.3532E-01  1.1399E+00  3.3630E-01  1.9180E-01  6.9455E-01  2.3016E+00
             1.0003E-01  1.0282E-02  1.9201E-04  1.2823E-03 -5.9489E-04  7.9493E-03 -1.7025E-04  5.4277E-04  1.0006E-02  2.0015E-03
             9.6717E-03
 PARAMETER:  1.0020E-01  1.0018E-01 -1.0001E-01 -1.0002E-01  1.0004E-01  1.0048E-01  1.0036E-01  9.9531E-02  1.0066E-01  1.0015E-01
             7.5190E-02  1.0767E-01  4.0538E+00  2.3906E-01 -5.1644E-02  1.1326E-01 -3.2401E-02  1.8128E-01  2.3857E-01  1.2371E+00
             1.4952E-01
 GRADIENT:   4.2116E-02 -2.7418E-02  1.7278E-02  1.2367E-02 -8.4546E-02  8.5086E-03 -1.0421E-01  9.6406E-03  2.3836E-01  3.5546E-01
            -1.4552E-03 -5.2689E-03 -8.2833E-06  1.2621E-03  9.4529E-03  1.1986E-03  7.1339E-04 -4.0956E-04 -5.7378E-03  8.3700E-04
            -1.1070E-02

0ITERATION NO.:   32    OBJECTIVE VALUE:  -10772.1430263230        NO. OF FUNC. EVALS.:  55
 CUMULATIVE NO. OF FUNC. EVALS.:      591
 NPARAMETR:  3.3052E+00  3.2580E+00 -6.1182E-01 -2.0823E-01  7.3532E-01  1.1399E+00  3.3630E-01  1.9180E-01  6.9455E-01  2.3016E+00
             1.0003E-01  1.0282E-02  1.9201E-04  1.2823E-03 -5.9489E-04  7.9493E-03 -1.7025E-04  5.4277E-04  1.0006E-02  2.0015E-03
             9.6717E-03
 PARAMETER:  1.0020E-01  1.0018E-01 -1.0001E-01 -1.0002E-01  1.0004E-01  1.0048E-01  1.0036E-01  9.9531E-02  1.0066E-01  1.0015E-01
             7.5190E-02  1.0767E-01  4.0538E+00  2.3906E-01 -5.1644E-02  1.1326E-01 -3.2401E-02  1.8128E-01  2.3857E-01  1.2371E+00
             1.4952E-01
 GRADIENT:  -3.7400E+00 -5.3481E+00 -1.4630E+00 -2.4714E-01 -1.0785E-01 -5.9826E-02 -1.5987E-01 -1.1109E-02 -2.3074E-01 -1.0450E+01
            -1.5240E-03 -5.2689E-03 -8.2833E-06  1.2621E-03  9.4529E-03  1.1986E-03  7.1339E-04 -4.0956E-04 -5.7378E-03  8.3700E-04
            -1.1070E-02

 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      591
 NO. OF SIG. DIGITS IN FINAL EST.:  2.8

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.

 ETABAR:         6.6776E-05 -1.0239E-03 -3.7428E-05 -9.6571E-04
 SE:             4.7163E-03  2.9847E-03  2.9481E-03  3.6727E-03
 N:                     400         400         400         400

 P VAL.:         9.8870E-01  7.3157E-01  9.8987E-01  7.9259E-01

 ETASHRINKSD(%)  6.9775E+00  3.3047E+01  4.1055E+01  2.5310E+01
 ETASHRINKVR(%)  1.3468E+01  5.5173E+01  6.5255E+01  4.4214E+01
 EBVSHRINKSD(%)  6.9637E+00  3.3080E+01  4.1035E+01  2.5320E+01
 EBVSHRINKVR(%)  1.3443E+01  5.5216E+01  6.5232E+01  4.4230E+01
 RELATIVEINF(%)  7.8110E+01  4.2161E+01  2.8287E+01  4.1859E+01
 EPSSHRINKSD(%)  2.6153E+01
 EPSSHRINKVR(%)  4.5466E+01

  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         2000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    3675.7541328186908     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -10772.143026323036     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -7096.3888935043451     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          1600
  
 #TERE:
 Elapsed estimation  time in seconds:    25.46
 Elapsed covariance  time in seconds:    30.24
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -10772.143       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11     
 
         3.31E+00  3.26E+00 -6.12E-01 -2.08E-01  7.35E-01  1.14E+00  3.36E-01  1.92E-01  6.95E-01  2.30E+00  1.00E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        1.03E-02
 
 ETA2
+        1.92E-04  7.95E-03
 
 ETA3
+        1.28E-03 -1.70E-04  1.00E-02
 
 ETA4
+       -5.95E-04  5.43E-04  2.00E-03  9.67E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        1.01E-01
 
 ETA2
+        2.12E-02  8.92E-02
 
 ETA3
+        1.26E-01 -1.91E-02  1.00E-01
 
 ETA4
+       -5.97E-02  6.19E-02  2.03E-01  9.83E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11     
 
         3.27E-02  2.86E-02  9.52E-03  8.30E-03  3.91E-02  3.57E-02  1.13E-02  1.04E-02  1.05E-02  8.57E-03  2.77E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        9.68E-04
 
 ETA2
+        8.27E-04  1.37E-03
 
 ETA3
+        1.28E-03  1.43E-03  3.04E-03
 
 ETA4
+        1.00E-03  1.10E-03  2.14E-03  1.92E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+       .........
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        4.77E-03
 
 ETA2
+        9.06E-02  7.70E-03
 
 ETA3
+        1.15E-01  1.62E-01  1.52E-02
 
 ETA4
+        1.04E-01  1.22E-01  1.75E-01  9.78E-03
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+       .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        1.07E-03
 
 TH 2
+        1.54E-05  8.20E-04
 
 TH 3
+       -3.01E-04 -2.82E-06  9.06E-05
 
 TH 4
+       -9.53E-07 -2.28E-04  9.41E-08  6.90E-05
 
 TH 5
+        2.90E-04  2.46E-05 -7.82E-05 -2.38E-06  1.53E-03
 
 TH 6
+        2.80E-05  2.92E-04 -5.44E-06 -7.61E-05  3.93E-05  1.28E-03
 
 TH 7
+       -8.07E-05 -7.77E-06  2.27E-05  8.00E-07 -4.29E-04 -1.23E-05  1.28E-04
 
 TH 8
+       -4.50E-06 -7.80E-05  9.02E-07  2.23E-05 -5.33E-06 -3.55E-04  1.81E-06  1.07E-04
 
 TH 9
+        4.37E-05  4.49E-05 -9.14E-06 -4.49E-06  5.74E-05  7.03E-05 -1.80E-05 -1.17E-05  1.10E-04
 
 TH10
+        2.72E-05  3.15E-05 -4.96E-06 -3.47E-06  5.17E-05  5.98E-05 -1.50E-05 -9.22E-06  6.31E-05  7.35E-05
 
 TH11
+        1.24E-06 -5.25E-07 -2.92E-07  1.71E-07  3.08E-06 -3.77E-06 -9.98E-07  9.78E-07  4.12E-07  2.26E-08  7.69E-06
 
 OM11
+        2.73E-07 -8.92E-08 -8.60E-09  6.82E-08  3.58E-07  5.16E-07 -1.16E-09 -4.40E-08  4.32E-07  4.02E-07 -3.86E-07  9.37E-07
 
 OM12
+        2.26E-07 -1.85E-07  1.69E-09  1.20E-07  1.46E-07 -1.35E-07  1.43E-07  1.87E-07  3.46E-07  3.24E-07 -4.18E-07  2.73E-07
          6.84E-07
 
 OM13
+        4.93E-07  1.57E-07  4.00E-08  3.16E-08  1.14E-06  1.26E-06 -1.67E-07 -1.47E-07  1.01E-06  1.01E-06 -7.04E-07  5.39E-07
          2.16E-07  1.63E-06
 
 OM14
+        9.70E-07 -1.30E-06 -1.95E-07  4.98E-07  6.41E-07  1.03E-06 -9.46E-08 -1.39E-07  9.01E-07  6.92E-07 -5.90E-07  3.62E-07
          2.10E-07  8.97E-07  1.01E-06
 
 OM22
+       -2.34E-07 -5.97E-08  1.44E-07  1.03E-07 -1.25E-06 -1.05E-06  7.04E-07  5.07E-07  1.44E-07  1.78E-07 -1.20E-06  8.34E-08
          3.68E-07  7.34E-08  7.56E-08  1.89E-06
 
 OM23
+        6.70E-07  1.17E-07 -7.31E-08  7.70E-08  2.06E-06 -5.09E-07 -2.45E-07  3.65E-07  1.21E-06  9.26E-07 -5.59E-07  1.74E-07
          3.51E-07  6.73E-07  3.58E-07  3.79E-07  2.06E-06
 
 OM24
+        2.95E-07 -2.73E-07 -1.53E-08  1.43E-07  1.68E-06 -2.44E-06 -3.22E-07  8.81E-07  6.35E-07  4.81E-07 -3.78E-07  9.30E-08
          2.28E-07  2.85E-07  3.20E-07  4.14E-07  9.96E-07  1.20E-06
 
 OM33
+        8.20E-07  1.84E-06  4.03E-08 -1.41E-07  1.43E-06  5.83E-06 -9.90E-08 -1.07E-06  1.57E-06  1.96E-06 -3.37E-06  4.50E-07
          3.30E-07  1.95E-06  1.07E-06  3.64E-07  1.61E-06  6.22E-07  9.23E-06
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+        4.98E-07  2.19E-06  4.94E-08 -3.31E-07  4.45E-07  6.06E-06  2.76E-08 -1.31E-06  1.71E-06  1.55E-06 -2.41E-06  3.00E-07
          2.37E-07  1.22E-06  9.29E-07  2.11E-07  1.16E-06  6.15E-07  5.54E-06  4.57E-06
 
 OM44
+        8.70E-08  2.11E-06  1.21E-07 -3.87E-07 -3.41E-07  5.92E-06  1.56E-07 -1.41E-06  1.35E-06  1.21E-06 -1.84E-06  1.99E-07
          1.64E-07  7.16E-07  7.57E-07  1.36E-07  6.63E-07  6.44E-07  3.12E-06  3.31E-06  3.70E-06
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        3.27E-02
 
 TH 2
+        1.65E-02  2.86E-02
 
 TH 3
+       -9.68E-01 -1.03E-02  9.52E-03
 
 TH 4
+       -3.52E-03 -9.59E-01  1.19E-03  8.30E-03
 
 TH 5
+        2.27E-01  2.20E-02 -2.10E-01 -7.32E-03  3.91E-02
 
 TH 6
+        2.40E-02  2.85E-01 -1.60E-02 -2.56E-01  2.81E-02  3.57E-02
 
 TH 7
+       -2.19E-01 -2.40E-02  2.11E-01  8.52E-03 -9.69E-01 -3.04E-02  1.13E-02
 
 TH 8
+       -1.33E-02 -2.63E-01  9.16E-03  2.60E-01 -1.32E-02 -9.59E-01  1.55E-02  1.04E-02
 
 TH 9
+        1.28E-01  1.50E-01 -9.17E-02 -5.17E-02  1.40E-01  1.88E-01 -1.52E-01 -1.08E-01  1.05E-02
 
 TH10
+        9.71E-02  1.28E-01 -6.08E-02 -4.88E-02  1.54E-01  1.95E-01 -1.54E-01 -1.04E-01  7.03E-01  8.57E-03
 
 TH11
+        1.37E-02 -6.61E-03 -1.10E-02  7.43E-03  2.84E-02 -3.81E-02 -3.18E-02  3.41E-02  1.42E-02  9.48E-04  2.77E-03
 
 OM11
+        8.62E-03 -3.22E-03 -9.33E-04  8.49E-03  9.45E-03  1.49E-02 -1.06E-04 -4.39E-03  4.26E-02  4.85E-02 -1.44E-01  9.68E-04
 
 OM12
+        8.36E-03 -7.79E-03  2.15E-04  1.75E-02  4.51E-03 -4.58E-03  1.53E-02  2.19E-02  3.99E-02  4.56E-02 -1.82E-01  3.41E-01
          8.27E-04
 
 OM13
+        1.18E-02  4.30E-03  3.29E-03  2.99E-03  2.28E-02  2.76E-02 -1.16E-02 -1.11E-02  7.60E-02  9.20E-02 -1.99E-01  4.37E-01
          2.05E-01  1.28E-03
 
 OM14
+        2.96E-02 -4.52E-02 -2.05E-02  5.98E-02  1.63E-02  2.87E-02 -8.34E-03 -1.34E-02  8.58E-02  8.05E-02 -2.12E-01  3.73E-01
          2.53E-01  7.01E-01  1.00E-03
 
 OM22
+       -5.22E-03 -1.52E-03  1.11E-02  9.01E-03 -2.32E-02 -2.14E-02  4.53E-02  3.56E-02  1.00E-02  1.52E-02 -3.14E-01  6.28E-02
          3.24E-01  4.19E-02  5.49E-02  1.37E-03
 
 OM23
+        1.43E-02  2.84E-03 -5.35E-03  6.46E-03  3.68E-02 -9.93E-03 -1.51E-02  2.46E-02  8.03E-02  7.53E-02 -1.40E-01  1.25E-01
          2.96E-01  3.68E-01  2.49E-01  1.93E-01  1.43E-03
 
 OM24
+        8.24E-03 -8.69E-03 -1.46E-03  1.57E-02  3.92E-02 -6.21E-02 -2.59E-02  7.76E-02  5.53E-02  5.11E-02 -1.24E-01  8.76E-02
          2.51E-01  2.04E-01  2.91E-01  2.75E-01  6.33E-01  1.10E-03
 
 OM33
+        8.27E-03  2.12E-02  1.39E-03 -5.57E-03  1.21E-02  5.37E-02 -2.88E-03 -3.39E-02  4.94E-02  7.52E-02 -4.00E-01  1.53E-01
          1.31E-01  5.03E-01  3.51E-01  8.73E-02  3.70E-01  1.87E-01  3.04E-03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+        7.13E-03  3.58E-02  2.43E-03 -1.86E-02  5.31E-03  7.93E-02  1.14E-03 -5.94E-02  7.65E-02  8.43E-02 -4.06E-01  1.45E-01
          1.34E-01  4.48E-01  4.33E-01  7.19E-02  3.77E-01  2.62E-01  8.52E-01  2.14E-03
 
 OM44
+        1.39E-03  3.83E-02  6.62E-03 -2.42E-02 -4.53E-03  8.61E-02  7.19E-03 -7.08E-02  6.69E-02  7.37E-02 -3.45E-01  1.07E-01
          1.03E-01  2.92E-01  3.93E-01  5.16E-02  2.40E-01  3.05E-01  5.34E-01  8.04E-01  1.92E-03
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 TH 1
+        1.59E+04
 
 TH 2
+        8.45E-07  1.85E+04
 
 TH 3
+        5.24E+04  4.24E-22  1.84E+05
 
 TH 4
+        0.00E+00  6.08E+04  0.00E+00  2.15E+05
 
 TH 5
+       -2.14E+03 -3.80E-06 -6.77E+03  1.69E-21  1.12E+04
 
 TH 6
+       -2.41E-06 -3.51E+03  0.00E+00 -1.13E+04  1.09E-05  1.17E+04
 
 TH 7
+       -6.77E+03  8.30E-06 -2.34E+04 -3.39E-21  3.76E+04 -2.37E-05  1.34E+05
 
 TH 8
+        0.00E+00 -1.13E+04  0.00E+00 -3.94E+04  3.71E-22  3.83E+04  0.00E+00  1.35E+05
 
 TH 9
+       -1.36E+03 -3.88E+03 -3.63E+03 -1.25E+04  1.09E+03 -5.66E+02  4.23E+03 -1.28E+03  1.95E+04
 
 TH10
+       -9.76E+02 -2.73E+02 -3.56E+03 -8.21E+02 -7.37E+02 -3.20E+03 -1.43E+03 -9.86E+03 -1.49E+04  2.83E+04
 
 TH11
+       -1.45E+03 -1.34E+03 -4.71E+03 -4.70E+03 -1.12E+03 -4.23E+02 -3.45E+03 -2.38E+03 -1.08E+03 -6.79E+02  1.81E+05
 
 OM11
+       -7.55E+01 -2.52E+02 -1.80E+02 -7.88E+02 -1.36E+03 -5.09E+02 -4.67E+03 -1.40E+03 -8.11E+02 -4.27E+02  3.48E+04  1.48E+06
 
 OM12
+       -1.88E+03 -1.02E+03 -6.64E+03 -3.07E+03 -4.34E+03 -3.69E+03 -1.57E+04 -1.36E+04  1.02E+03 -1.63E+03  2.18E+04 -4.88E+05
          1.99E+06
 
 OM13
+       -5.14E+03  5.45E+03 -2.12E+04  2.77E+04  2.88E+02 -9.57E+02  1.79E+03 -6.02E+03  1.58E+03 -5.59E+03 -2.71E+04 -4.50E+05
          1.73E+05  1.73E+06
 
 OM14
+        2.63E+03 -3.47E+03  1.47E+04 -3.07E+04 -1.19E+03  7.42E+02 -5.37E+03  6.85E+03 -6.22E+03  3.25E+03  3.14E+04 -1.00E+05
         -2.99E+05 -1.28E+06  2.44E+06
 
 OM22
+       -1.21E+03 -2.00E+03 -4.12E+03 -6.90E+03 -5.32E+03 -2.22E+03 -2.13E+04 -8.45E+03 -4.04E+02 -5.65E+01  1.05E+05  4.63E+04
         -2.96E+05  9.68E+02  7.28E+04  6.95E+05
 
 OM23
+        1.61E+03  3.49E+02  6.42E+03 -1.51E+03 -5.92E+03  1.42E+03 -2.09E+04  7.61E+03 -4.88E+03  3.34E+02 -1.40E+04  8.02E+04
         -2.62E+05 -3.57E+05  3.23E+05  2.27E+04  1.06E+06
 
 OM24
+       -6.04E+02  1.65E+03 -3.82E+03  9.71E+03  1.87E+03 -7.07E+02  1.08E+04 -1.47E+04  6.66E+02 -2.92E+02 -2.51E+04  1.20E+04
          9.63E+03  2.62E+05 -4.60E+05 -2.19E+05 -8.16E+05  1.70E+06
 
 OM33
+       -5.95E+02 -2.29E+03 -1.30E+03 -1.02E+04 -1.02E+03 -1.04E+03 -3.04E+03 -3.93E+03  5.23E+03 -4.08E+03  4.80E+04  3.98E+04
         -1.68E+04 -2.97E+05  2.36E+05 -1.38E+03  1.55E+04 -1.38E+04  5.87E+05
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      TH 9      TH10      TH11      OM11  
             OM12      OM13      OM14      OM22      OM23      OM24      OM33      OM34      OM44      SG11  
 
 OM34
+        4.02E+02  3.13E+02  5.56E+02  5.33E+03  1.53E+03 -7.25E+02  5.04E+03 -2.19E+03 -8.06E+03  6.39E+03  5.88E+03  1.18E+04
          5.93E+04  2.13E+05 -3.85E+05  1.50E+04 -2.97E+05  2.42E+05 -9.11E+05  2.25E+06
 
 OM44
+       -1.36E+03 -9.54E+02 -5.09E+03 -2.86E+03 -1.16E+02 -6.17E+02 -1.68E+03  2.31E+03  3.20E+03 -4.39E+03  4.40E+04  5.53E+03
         -4.65E+03  9.92E+03 -5.09E+04  4.56E+04  2.08E+05 -3.21E+05  3.51E+05 -1.19E+06  1.09E+06
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 Elapsed finaloutput time in seconds:     0.09
 #CPUT: Total CPU Time in Seconds,      496.672
Stop Time: 
Wed 01/25/2023 
09:37 AM
