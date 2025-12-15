Tue 01/11/2022 
06:17 PM
$PROBLEM PDLIDR
$INPUT ID AMT TIME DV EVID  CMT
$DATA PDLIDR.csv IGNORE=C
$SUBROUTINES ADVAN16 TOL=4
$MODEL NCOMPARTMENTS=3 

$PK
MU_1=LOG(THETA(3))
MU_2=LOG(THETA(4))
MU_3=LOG(THETA(5))
MU_4=LOG(THETA(6))
MU_5=LOG(THETA(7))
MXSTEP=2000000000
KEL=THETA(1)
V=THETA(2)
K0=EXP(MU_1+ETA(1))
K1=EXP(MU_2+ETA(2))
SMAX=EXP(MU_3+ETA(3))
SC50=EXP(MU_4+ETA(4))
;  TAUy
TAU1=EXP(MU_5+ETA(5))
; Initial conditions
A_0(1)=0
A_0(2)=K0/K1
A_0(3)=K0*TAU1

$DES
; AD_x_y is the State value of A(x) delayed for time TAUy.  
; AP_x_y is the State value of A(x) in the past, for time delay TAUy.  
AP_2_1=K0/K1
;BASE EQUATIONS 
CC=A(1)/V
DADT(1)=-KEL*A(1)
DADT(2)=K0*(1+SMAX*CC/(SC50+CC))-K1*A(2)
DADT(3)=K1*A(2)-K1*AD_2_1

$ERROR

Y1=LOG(A(3))  
IF(CMT==3) IPRED=Y1
IF(CMT==3) Y=IPRED+EPS(1)

$THETA
0.25 FIX    ; 1: KEL
1    FIX    ; 2: V
(0,0.5,5)   ; 3: K0
(0,0.05,0.5); 4: K1
(0,50,500)  ; 5: SMAX
(0,1,10)    ; 6: SC50
(5,20,200)  ; 7: TR

$OMEGA BLOCK(5) VALUES(0.2,0.001)

$SIGMA
0.01
$EST METHOD=SAEM INTERACTION ISAMPLE=2 NBURN=200 NITER=200 PRINT=10 NOHABORT CTYPE=3 SIGL=3 RANMETHOD=3S2P
$EST METHOD=IMP INTERACTION MAPITER=0 NITER=200 ISAMPLE=300 CTYPE=3 PRINT=1
$COV UNCONDITIONAL MATRIX=R
$TABLE ID TIME IPRED EVID CMT NOPRINT ONEHEADER
FILE=PDLIDR.tab
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  3) THERE MAY BE AN ERROR IN THE ABBREVIATED CODE. THE FOLLOWING
 ONE OR MORE RANDOM VARIABLES ARE DEFINED WITH "IF" STATEMENTS THAT DO NOT
 PROVIDE DEFINITIONS FOR BOTH THE "THEN" AND "ELSE" CASES. IF ALL
 CONDITIONS FAIL, THE VALUES OF THESE VARIABLES WILL BE ZERO.
  
   IPRED Y

             
 (WARNING  83) FUNCTIONS ARE USED IN ABBREVIATED CODE, BUT THE $SUBROUTINES
 RECORD DOES NOT INCLUDE THE "OTHER" OPTION.
  
License Registered to: NONMEM license (with RADAR5NM) for ICON Pharmacometrics Team
Expiration Date:    31 DEC 2030
Current Date:       11 JAN 2022
Days until program expires :3270
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.1
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 PDLIDR
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:     3250
 NO. OF DATA ITEMS IN DATA SET:   7
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   4
 MDV DATA ITEM IS DATA ITEM NO.:  7
0INDICES PASSED TO SUBROUTINE PRED:
   5   3   2   0   0   0   6   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID AMT TIME DV EVID CMT MDV
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 IPRED
0FORMAT FOR DATA:
 (6E12.0,1F2.0)

 TOT. NO. OF OBS RECS:     3125
 TOT. NO. OF INDIVIDUALS:      125
0LENGTH OF THETA:   7
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS BLOCK FORM:
  1
  1  1
  1  1  1
  1  1  1  1
  1  1  1  1  1
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
  0.2500E+00     0.2500E+00     0.2500E+00
  0.1000E+01     0.1000E+01     0.1000E+01
  0.0000E+00     0.5000E+00     0.5000E+01
  0.0000E+00     0.5000E-01     0.5000E+00
  0.0000E+00     0.5000E+02     0.5000E+03
  0.0000E+00     0.1000E+01     0.1000E+02
  0.5000E+01     0.2000E+02     0.2000E+03
0INITIAL ESTIMATE OF OMEGA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.2000E+00
                  0.1000E-02   0.2000E+00
                  0.1000E-02   0.1000E-02   0.2000E+00
                  0.1000E-02   0.1000E-02   0.1000E-02   0.2000E+00
                  0.1000E-02   0.1000E-02   0.1000E-02   0.1000E-02   0.2000E+00
0INITIAL ESTIMATE OF SIGMA:
 0.1000E-01
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
0TABLES STEP OMITTED:    NO
 NO. OF TABLES:           1
 SEED NUMBER (SEED):    11456
 NPDTYPE:    0
 INTERPTYPE:    0
 RANMETHOD:             3U
 MC SAMPLES (ESAMPLE):    300
 WRES SQUARE ROOT TYPE (WRESCHOL): EIGENVALUE
0-- TABLE   1 --
0RECORDS ONLY:    ALL
04 COLUMNS APPENDED:    YES
 PRINTED:                NO
 HEADERS:               ONE
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID TIME IPRED EVID CMT
1DOUBLE PRECISION PREDPP VERSION 7.5.1

 GENERAL NONLINEAR KINETICS MODEL WITH STIFF/NONSTIFF AND DELAY EQUATIONS (RADAR5, ADVAN16)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:  12
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         COMP 1       ON         YES        YES        YES        YES
    2         COMP 2       ON         YES        YES        NO         NO
    3         COMP 3       ON         YES        YES        NO         NO
    4         OUTPUT       OFF        YES        NO         NO         NO
 INITIAL (BASE) TOLERANCE SETTINGS:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   4
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            *           *           *           *           *
    2            *           *           *           *           *
    3            *           *           *           *           *
    4            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      5
   TIME DATA ITEM IS DATA ITEM NO.:          3
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   2
   COMPT. NO. DATA ITEM IS DATA ITEM NO.:    6

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0PK SUBROUTINE INDICATES THAT COMPARTMENT AMOUNTS ARE INITIALIZED.
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
0ERROR SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
0DES SUBROUTINE USES FULL STORAGE MODE.
1


 #TBLN:      1
 #METH: Stochastic Approximation Expectation-Maximization

 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            960
 NO. OF SIG. FIGURES REQUIRED:            3
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    0
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      3
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     3
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): pdlidr.ext
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
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          10
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 BURN-IN ITERATIONS (NBURN):                200
 FIRST ITERATION FOR MAP (MAPITERS):          NO
 ITERATIONS (NITER):                        200
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
 MC SAMPLES PER SUBJECT (ISAMPLE):          2
 RANDOM SAMPLING METHOD (RANMETHOD):        3US2P
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

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   4
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   4
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12

 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI

 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   3   4   5   6   7
 THETAS THAT ARE SIGMA-LIKE:
 

 MONITORING OF SEARCH:

 Stochastic/Burn-in Mode
 iteration         -200  SAEMOBJ=  -842.70319169627840
 iteration         -190  SAEMOBJ=  -12340.980588635033
 iteration         -180  SAEMOBJ=  -13117.878256455133
 iteration         -170  SAEMOBJ=  -13339.435067742008
 iteration         -160  SAEMOBJ=  -13520.241650403053
 iteration         -150  SAEMOBJ=  -13573.225727209439
 iteration         -140  SAEMOBJ=  -13711.939364391503
 iteration         -130  SAEMOBJ=  -13769.418438275763
 iteration         -120  SAEMOBJ=  -13822.707859611884
 iteration         -110  SAEMOBJ=  -13817.964473499993
 iteration         -100  SAEMOBJ=  -13832.027483639853
 iteration          -90  SAEMOBJ=  -13844.228609507660
 iteration          -80  SAEMOBJ=  -13838.481398842490
 iteration          -70  SAEMOBJ=  -13821.064998122278
 iteration          -60  SAEMOBJ=  -13861.416023684838
 iteration          -50  SAEMOBJ=  -13911.528686666037
 iteration          -40  SAEMOBJ=  -13953.931192122805
 iteration          -30  SAEMOBJ=  -13991.753655807273
 iteration          -20  SAEMOBJ=  -14044.506596632866
 iteration          -10  SAEMOBJ=  -14100.476904709900
 Reduced Stochastic/Accumulation Mode
 iteration            0  SAEMOBJ=  -14191.508370072208
 iteration           10  SAEMOBJ=  -14237.081468019409
 iteration           20  SAEMOBJ=  -14242.097140512218
 iteration           30  SAEMOBJ=  -14244.976361541923
 iteration           40  SAEMOBJ=  -14243.875780103730
 iteration           50  SAEMOBJ=  -14247.379202546565
 iteration           60  SAEMOBJ=  -14249.649601057798
 iteration           70  SAEMOBJ=  -14250.678081494149
 iteration           80  SAEMOBJ=  -14249.618934053957
 iteration           90  SAEMOBJ=  -14249.642372382650
 iteration          100  SAEMOBJ=  -14249.997638532866
 iteration          110  SAEMOBJ=  -14249.180481121188
 iteration          120  SAEMOBJ=  -14249.363460677318
 iteration          130  SAEMOBJ=  -14249.474814291500
 iteration          140  SAEMOBJ=  -14248.162210549850
 iteration          150  SAEMOBJ=  -14247.456579760679
 iteration          160  SAEMOBJ=  -14248.212640918207
 iteration          170  SAEMOBJ=  -14248.104036023353
 iteration          180  SAEMOBJ=  -14247.936175014103
 iteration          190  SAEMOBJ=  -14248.219674615439
 iteration          200  SAEMOBJ=  -14248.615891917265

 #TERM:
 STOCHASTIC PORTION WAS NOT COMPLETED
 REDUCED STOCHASTIC PORTION WAS COMPLETED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.

 ETABAR:        -2.3273E-06  2.0354E-05  7.6759E-07 -3.8333E-07  1.0044E-05
 SE:             2.1746E-03  1.4795E-02  3.9898E-03  6.9911E-03  1.9502E-02
 N:                     125         125         125         125         125

 P VAL.:         9.9915E-01  9.9890E-01  9.9985E-01  9.9996E-01  9.9959E-01

 ETASHRINKSD(%)  4.0977E+01  8.7375E+00  4.4420E+01  4.9983E+01  1.6248E+00
 ETASHRINKVR(%)  6.5163E+01  1.6712E+01  6.9109E+01  7.4983E+01  3.2233E+00
 EBVSHRINKSD(%)  4.0996E+01  8.7668E+00  4.4434E+01  4.9993E+01  1.6376E+00
 EBVSHRINKVR(%)  6.5185E+01  1.6765E+01  6.9124E+01  7.4993E+01  3.2483E+00
 RELATIVEINF(%)  1.9831E+00  7.1260E+01  8.7007E+00  1.5269E+01  1.0000E-10
 EPSSHRINKSD(%)  4.4417E+00
 EPSSHRINKVR(%)  8.6861E+00

  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         3125
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    5743.3658325292045     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -14248.615891917265     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -8505.2500593880613     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                           625
 NIND*NETA*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    1148.6731665058408     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -14248.615891917265     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -13099.942725411423     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:  1052.33
 Elapsed covariance  time in seconds:     0.10
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION               ********************
 #OBJT:**************                        FINAL VALUE OF LIKELIHOOD FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -14248.616       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION               ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7     
 
         2.50E-01  1.00E+00  4.92E-01  4.96E-02  5.12E+01  1.02E+00  1.99E+01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        1.70E-03
 
 ETA2
+        2.72E-04  3.29E-02
 
 ETA3
+       -3.21E-03 -2.02E-04  6.44E-03
 
 ETA4
+       -4.69E-03  4.30E-03  8.77E-03  2.44E-02
 
 ETA5
+       -4.42E-03  1.57E-03  7.02E-03  1.40E-02  4.91E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        9.37E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        4.12E-02
 
 ETA2
+        3.64E-02  1.81E-01
 
 ETA3
+       -9.72E-01 -1.39E-02  8.03E-02
 
 ETA4
+       -7.28E-01  1.52E-01  6.99E-01  1.56E-01
 
 ETA5
+       -4.84E-01  3.91E-02  3.95E-01  4.04E-01  2.22E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        9.68E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION               ********************
 ********************                          STANDARD ERROR OF ESTIMATE (S)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7     
 
         0.00E+00  0.00E+00  5.03E-03  9.98E-04  8.08E-01  3.67E-02  4.85E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        1.20E-03
 
 ETA2
+        1.93E-03  5.71E-03
 
 ETA3
+        2.04E-03  3.21E-03  3.72E-03
 
 ETA4
+        3.87E-03  8.41E-03  7.18E-03  1.74E-02
 
 ETA5
+        2.21E-03  5.58E-03  3.93E-03  1.00E-02  9.12E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        2.98E-04
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        1.46E-02
 
 ETA2
+        2.58E-01  1.58E-02
 
 ETA3
+        5.29E-02  2.21E-01  2.32E-02
 
 ETA4
+        2.71E-01  2.73E-01  2.76E-01  5.57E-02
 
 ETA5
+        2.13E-01  1.38E-01  1.88E-01  1.97E-01  2.06E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.54E-03
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION               ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (S)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      OM11      OM12      OM13      OM14      OM15  
             OM22      OM23      OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 TH 1
+       .........
 
 TH 2
+       ......... .........
 
 TH 3
+        0.00E+00  0.00E+00  2.54E-05
 
 TH 4
+        0.00E+00  0.00E+00 -3.82E-07  9.96E-07
 
 TH 5
+        0.00E+00  0.00E+00 -3.11E-03 -1.76E-05  6.54E-01
 
 TH 6
+        0.00E+00  0.00E+00 -1.10E-04  8.48E-06  2.05E-02  1.34E-03
 
 TH 7
+        0.00E+00  0.00E+00 -1.27E-03  5.91E-05  1.35E-01  7.64E-03  2.36E-01
 
 OM11
+        0.00E+00  0.00E+00  2.44E-06  5.60E-08 -2.19E-04 -8.95E-06 -2.00E-04  1.44E-06
 
 OM12
+        0.00E+00  0.00E+00 -8.76E-07  2.29E-07  1.24E-05  1.10E-05 -6.76E-06  1.06E-07  3.73E-06
 
 OM13
+        0.00E+00  0.00E+00 -3.35E-06 -1.77E-07  3.26E-04  1.20E-05  2.88E-04 -2.33E-06 -4.24E-07  4.18E-06
 
 OM14
+        0.00E+00  0.00E+00 -6.04E-06  2.18E-07  5.45E-04  3.48E-05  4.54E-04 -3.79E-06  1.32E-06  6.43E-06  1.50E-05
 
 OM15
+        0.00E+00  0.00E+00 -3.79E-06  1.28E-07  4.12E-04  1.71E-05  2.36E-04 -1.13E-06  7.55E-07  1.64E-06  4.83E-06  4.89E-06
 
 OM22
+        0.00E+00  0.00E+00  3.78E-06 -5.05E-08 -9.91E-05 -1.48E-05 -5.81E-04  1.31E-06  1.23E-06 -1.80E-06 -3.54E-06 -1.33E-06
          3.26E-05
 
 OM23
+        0.00E+00  0.00E+00  5.11E-07  1.53E-07  9.55E-05 -1.30E-05  1.18E-05  6.41E-08 -4.91E-06  2.84E-07 -1.83E-06 -5.57E-07
          3.78E-07  1.03E-05
 
 OM24
+        0.00E+00  0.00E+00  8.77E-06 -2.01E-07 -8.00E-04 -1.05E-04 -8.75E-04  2.10E-06 -9.09E-06 -2.24E-06 -1.11E-05 -4.57E-06
          1.54E-05  1.85E-05  7.08E-05
 
 OM25
+        0.00E+00  0.00E+00 -4.49E-07 -1.41E-06  5.05E-05 -3.63E-05 -2.44E-04 -4.07E-07 -5.10E-06  1.42E-06 -2.20E-06 -1.22E-06
         -5.72E-07  5.05E-06  1.58E-05  3.12E-05
 
 OM33
+        0.00E+00  0.00E+00  3.91E-06  4.44E-07 -4.37E-04 -1.32E-05 -3.85E-04  3.58E-06  1.03E-06 -7.17E-06 -1.05E-05 -2.33E-06
          2.06E-06 -8.87E-07  1.93E-06 -3.50E-06  1.38E-05
 
 OM34
+        0.00E+00  0.00E+00  7.89E-06 -3.53E-07 -8.44E-04 -5.30E-05 -7.76E-04  6.01E-06 -7.22E-07 -1.14E-05 -2.52E-05 -7.65E-06
          5.18E-06 -1.06E-07  1.37E-05  3.53E-06  2.10E-05  5.16E-05
 
 OM35
+        0.00E+00  0.00E+00  5.89E-06 -5.49E-08 -6.22E-04 -2.37E-05 -4.31E-04  2.03E-06 -2.20E-07 -3.76E-06 -8.61E-06 -6.85E-06
          2.27E-06 -5.96E-07  5.96E-06 -1.93E-06  6.61E-06  1.64E-05  1.54E-05
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      OM11      OM12      OM13      OM14      OM15  
             OM22      OM23      OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 OM44
+        0.00E+00  0.00E+00  1.52E-05 -3.13E-06 -1.55E-03 -1.73E-04 -1.15E-03  8.09E-06 -7.39E-06 -1.51E-05 -4.75E-05 -1.90E-05
          7.89E-06  6.54E-06  6.47E-05  2.24E-05  2.74E-05  9.43E-05  3.61E-05  3.03E-04
 
 OM45
+        0.00E+00  0.00E+00  1.13E-05 -1.57E-06 -1.03E-03 -8.34E-05 -1.10E-03  4.43E-06 -3.65E-06 -7.05E-06 -2.49E-05 -1.62E-05
          6.89E-06  3.83E-06  3.06E-05  1.09E-05  1.08E-05  4.21E-05  2.98E-05  1.23E-04  1.00E-04
 
 OM55
+        0.00E+00  0.00E+00  5.57E-06 -1.87E-06 -7.12E-04 -6.02E-05 -5.63E-04  1.28E-06 -6.01E-07 -1.23E-06 -9.01E-06 -1.04E-05
          6.93E-06 -1.61E-06  6.24E-06  1.16E-05  7.76E-07  1.62E-05  1.11E-05  4.99E-05  4.99E-05  8.31E-05
 
 SG11
+        0.00E+00  0.00E+00 -4.59E-09  3.29E-09 -1.06E-05 -5.59E-07  3.56E-06 -7.07E-08 -1.06E-07  1.39E-07  7.48E-08 -7.44E-09
          6.40E-08  1.88E-07  1.93E-07  1.63E-07 -2.60E-07 -1.96E-07 -6.50E-09 -6.71E-07  1.38E-07 -1.74E-07  8.88E-08
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION               ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (S)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      OM11      OM12      OM13      OM14      OM15  
             OM22      OM23      OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 TH 1
+       .........
 
 TH 2
+       ......... .........
 
 TH 3
+        0.00E+00  0.00E+00  5.03E-03
 
 TH 4
+        0.00E+00  0.00E+00 -7.60E-02  9.98E-04
 
 TH 5
+        0.00E+00  0.00E+00 -7.65E-01 -2.18E-02  8.08E-01
 
 TH 6
+        0.00E+00  0.00E+00 -5.96E-01  2.32E-01  6.91E-01  3.67E-02
 
 TH 7
+        0.00E+00  0.00E+00 -5.21E-01  1.22E-01  3.44E-01  4.29E-01  4.85E-01
 
 OM11
+        0.00E+00  0.00E+00  4.03E-01  4.67E-02 -2.25E-01 -2.03E-01 -3.44E-01  1.20E-03
 
 OM12
+        0.00E+00  0.00E+00 -9.00E-02  1.19E-01  7.97E-03  1.55E-01 -7.21E-03  4.59E-02  1.93E-03
 
 OM13
+        0.00E+00  0.00E+00 -3.25E-01 -8.70E-02  1.97E-01  1.60E-01  2.90E-01 -9.51E-01 -1.07E-01  2.04E-03
 
 OM14
+        0.00E+00  0.00E+00 -3.10E-01  5.66E-02  1.74E-01  2.45E-01  2.42E-01 -8.17E-01  1.77E-01  8.13E-01  3.87E-03
 
 OM15
+        0.00E+00  0.00E+00 -3.41E-01  5.79E-02  2.30E-01  2.11E-01  2.20E-01 -4.26E-01  1.77E-01  3.64E-01  5.65E-01  2.21E-03
 
 OM22
+        0.00E+00  0.00E+00  1.31E-01 -8.86E-03 -2.15E-02 -7.08E-02 -2.10E-01  1.91E-01  1.11E-01 -1.54E-01 -1.60E-01 -1.05E-01
          5.71E-03
 
 OM23
+        0.00E+00  0.00E+00  3.16E-02  4.77E-02  3.68E-02 -1.10E-01  7.55E-03  1.66E-02 -7.91E-01  4.33E-02 -1.48E-01 -7.84E-02
          2.06E-02  3.21E-03
 
 OM24
+        0.00E+00  0.00E+00  2.07E-01 -2.39E-02 -1.18E-01 -3.42E-01 -2.14E-01  2.09E-01 -5.59E-01 -1.30E-01 -3.41E-01 -2.46E-01
          3.21E-01  6.83E-01  8.41E-03
 
 OM25
+        0.00E+00  0.00E+00 -1.60E-02 -2.53E-01  1.12E-02 -1.77E-01 -9.02E-02 -6.07E-02 -4.73E-01  1.25E-01 -1.02E-01 -9.89E-02
         -1.79E-02  2.81E-01  3.36E-01  5.58E-03
 
 OM33
+        0.00E+00  0.00E+00  2.09E-01  1.20E-01 -1.46E-01 -9.67E-02 -2.13E-01  8.03E-01  1.43E-01 -9.43E-01 -7.30E-01 -2.83E-01
          9.71E-02 -7.42E-02  6.18E-02 -1.68E-01  3.72E-03
 
 OM34
+        0.00E+00  0.00E+00  2.18E-01 -4.93E-02 -1.45E-01 -2.01E-01 -2.23E-01  6.97E-01 -5.21E-02 -7.78E-01 -9.08E-01 -4.82E-01
          1.26E-01 -4.59E-03  2.26E-01  8.82E-02  7.87E-01  7.18E-03
 
 OM35
+        0.00E+00  0.00E+00  2.98E-01 -1.40E-02 -1.96E-01 -1.65E-01 -2.26E-01  4.31E-01 -2.90E-02 -4.68E-01 -5.67E-01 -7.90E-01
          1.01E-01 -4.72E-02  1.81E-01 -8.81E-02  4.53E-01  5.80E-01  3.93E-03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      OM11      OM12      OM13      OM14      OM15  
             OM22      OM23      OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 OM44
+        0.00E+00  0.00E+00  1.74E-01 -1.80E-01 -1.10E-01 -2.70E-01 -1.36E-01  3.87E-01 -2.20E-01 -4.25E-01 -7.05E-01 -4.93E-01
          7.93E-02  1.17E-01  4.41E-01  2.31E-01  4.22E-01  7.54E-01  5.28E-01  1.74E-02
 
 OM45
+        0.00E+00  0.00E+00  2.25E-01 -1.57E-01 -1.28E-01 -2.27E-01 -2.27E-01  3.69E-01 -1.89E-01 -3.44E-01 -6.43E-01 -7.31E-01
          1.20E-01  1.19E-01  3.64E-01  1.95E-01  2.89E-01  5.85E-01  7.57E-01  7.03E-01  1.00E-02
 
 OM55
+        0.00E+00  0.00E+00  1.21E-01 -2.06E-01 -9.66E-02 -1.80E-01 -1.27E-01  1.17E-01 -3.41E-02 -6.58E-02 -2.56E-01 -5.18E-01
          1.33E-01 -5.49E-02  8.13E-02  2.28E-01  2.29E-02  2.47E-01  3.11E-01  3.14E-01  5.47E-01  9.12E-03
 
 SG11
+        0.00E+00  0.00E+00 -3.06E-03  1.11E-02 -4.42E-02 -5.11E-02  2.46E-02 -1.98E-01 -1.83E-01  2.28E-01  6.49E-02 -1.13E-02
          3.76E-02  1.96E-01  7.71E-02  9.77E-02 -2.34E-01 -9.17E-02 -5.56E-03 -1.29E-01  4.62E-02 -6.41E-02  2.98E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION               ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (S)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      OM11      OM12      OM13      OM14      OM15  
             OM22      OM23      OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 TH 1
+       .........
 
 TH 2
+       ......... .........
 
 TH 3
+        0.00E+00  0.00E+00  1.47E+05
 
 TH 4
+        0.00E+00  0.00E+00  4.48E+04  1.36E+06
 
 TH 5
+        0.00E+00  0.00E+00  5.75E+02  6.74E+02  5.76E+00
 
 TH 6
+        0.00E+00  0.00E+00 -1.14E+01 -1.49E+04 -5.77E+01  2.08E+03
 
 TH 7
+        0.00E+00  0.00E+00  3.43E+02 -8.73E+01  1.15E+00 -2.81E+01  7.32E+00
 
 OM11
+        0.00E+00  0.00E+00 -2.42E+05  7.66E+05 -3.66E+02 -4.36E+04  2.69E+03  6.02E+07
 
 OM12
+        0.00E+00  0.00E+00  6.50E+04 -1.52E+05  1.14E+02  2.47E+03  7.83E+01 -9.09E+05  1.14E+06
 
 OM13
+        0.00E+00  0.00E+00 -2.76E+04  7.80E+05  1.48E+02 -3.75E+04  1.71E+03  5.61E+07 -4.16E+05  5.82E+07
 
 OM14
+        0.00E+00  0.00E+00  4.79E+03 -3.97E+04  1.22E+02 -4.62E+03  5.94E+02  1.29E+06 -2.41E+05 -6.31E+05  1.29E+06
 
 OM15
+        0.00E+00  0.00E+00  4.64E+03  1.20E+05 -1.76E+02  1.44E+03  8.19E+01  3.04E+06 -7.54E+04  2.82E+06 -2.12E+05  1.06E+06
 
 OM22
+        0.00E+00  0.00E+00 -7.34E+03  1.64E+04 -3.40E+01 -1.12E+03  4.74E+01  2.26E+05 -4.85E+04  2.15E+05  1.63E+04  7.03E+03
          4.54E+04
 
 OM23
+        0.00E+00  0.00E+00  9.65E+03 -7.93E+04 -6.88E+01 -5.65E+02 -5.60E+01  1.05E+03  4.66E+05 -1.31E+05  6.76E+04  2.28E+04
          1.24E+04  4.66E+05
 
 OM24
+        0.00E+00  0.00E+00  3.56E+03 -4.43E+04 -1.67E+01  2.69E+03  3.84E+01 -5.09E+05  2.50E+03 -4.22E+05 -1.56E+04 -3.51E+04
         -2.35E+04 -8.48E+04  5.89E+04
 
 OM25
+        0.00E+00  0.00E+00  1.20E+04  3.11E+04  1.76E+01  3.60E+02  5.68E+01  4.80E+04  9.63E+04  1.19E+05 -4.64E+04  2.78E+04
          2.31E+03  3.26E+04 -9.38E+03  5.80E+04
 
 OM33
+        0.00E+00  0.00E+00  2.89E+04  1.45E+05  1.90E+02 -9.66E+03  4.17E+02  1.38E+07 -1.60E+05  1.53E+07 -3.49E+05  6.12E+05
          6.10E+04 -1.20E+05 -9.33E+04  5.39E+04  4.52E+06
 
 OM34
+        0.00E+00  0.00E+00  1.39E+04 -2.41E+04  5.76E+01 -1.28E+03  2.45E+02  1.57E+05 -3.56E+04 -3.71E+05  4.44E+05 -9.18E+04
         -4.29E+03  3.77E+04  1.15E+04 -2.88E+04 -3.03E+05  3.04E+05
 
 OM35
+        0.00E+00  0.00E+00 -2.21E+04  2.38E+04 -7.49E+01 -3.19E+02 -1.59E+01  1.59E+06  7.08E+04  1.58E+06 -1.99E+05  4.54E+05
          2.41E+03  6.93E+04 -2.21E+04  4.48E+04  3.20E+05 -9.11E+04  4.29E+05
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      OM11      OM12      OM13      OM14      OM15  
             OM22      OM23      OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 OM44
+        0.00E+00  0.00E+00 -3.51E+03  1.74E+04 -1.71E+01  3.26E+02 -5.03E+01  2.02E+05  5.26E+03  1.46E+05  1.01E+02  1.64E+04
          4.43E+03  1.64E+04 -1.29E+04  1.69E+03  4.46E+04 -3.12E+04  1.59E+04  1.72E+04
 
 OM45
+        0.00E+00  0.00E+00  6.24E+03  6.57E+03  1.15E+01 -8.76E+02  1.07E+02 -2.90E+04 -4.53E+04 -1.19E+05  1.11E+05 -2.48E+04
          4.04E+03 -1.61E+04 -2.00E+03 -9.76E+03 -1.57E+04  3.87E+04 -9.30E+04 -1.18E+04  6.36E+04
 
 OM55
+        0.00E+00  0.00E+00  5.47E+02  1.29E+04 -6.60E+00  8.67E+02 -2.65E+01 -2.91E+04 -1.68E+03 -2.24E+04 -3.20E+04  6.25E+04
         -5.32E+03  1.34E+03  4.16E+03 -2.19E+03 -1.03E+03 -1.69E+04  3.59E+04  2.80E+03 -1.82E+04  2.56E+04
 
 SG11
+        0.00E+00  0.00E+00  1.87E+04 -8.66E+04  4.76E+02  8.62E+03 -1.86E+02  1.18E+06 -5.68E+04 -5.59E+04  2.55E+05  4.73E+04
         -6.61E+04 -2.80E+05  3.15E+04 -2.60E+04  4.57E+05 -3.27E+05 -4.53E+03  1.45E+05 -1.33E+05  1.05E+05  1.49E+07
 
1


 #TBLN:      2
 #METH: Importance Sampling

 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            960
 NO. OF SIG. FIGURES REQUIRED:            3
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    0
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      3
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     3
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): pdlidr.ext
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
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          1
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 ITERATIONS (NITER):                        200
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
 MC SAMPLES PER SUBJECT (ISAMPLE):          300
 RANDOM SAMPLING METHOD (RANMETHOD):        3US2P
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

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   4
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   4
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
 TOLERANCES FOR TABLE/SCATTER STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   4
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12

 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI

 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   3   4   5   6   7
 THETAS THAT ARE SIGMA-LIKE:
 

 MONITORING OF SEARCH:

 iteration            0  OBJ=  -10447.656808382228 eff.=     335. Smpl.=     300. Fit.= 0.97155
 iteration            1  OBJ=  -10447.906860585696 eff.=     111. Smpl.=     300. Fit.= 0.92511
 iteration            2  OBJ=  -10448.480087573600 eff.=     120. Smpl.=     300. Fit.= 0.93008
 iteration            3  OBJ=  -10448.562609244625 eff.=     120. Smpl.=     300. Fit.= 0.93061
 iteration            4  OBJ=  -10448.742630212993 eff.=     120. Smpl.=     300. Fit.= 0.93032
 iteration            5  OBJ=  -10448.761223543055 eff.=     120. Smpl.=     300. Fit.= 0.93035
 iteration            6  OBJ=  -10448.929584336985 eff.=     120. Smpl.=     300. Fit.= 0.93038
 iteration            7  OBJ=  -10448.976420762869 eff.=     120. Smpl.=     300. Fit.= 0.93048
 iteration            8  OBJ=  -10449.107591338145 eff.=     120. Smpl.=     300. Fit.= 0.93029
 iteration            9  OBJ=  -10449.085466054794 eff.=     120. Smpl.=     300. Fit.= 0.93050
 iteration           10  OBJ=  -10449.208232818184 eff.=     120. Smpl.=     300. Fit.= 0.93029
 iteration           11  OBJ=  -10449.244437591429 eff.=     120. Smpl.=     300. Fit.= 0.93051
 iteration           12  OBJ=  -10449.299910703092 eff.=     120. Smpl.=     300. Fit.= 0.93033
 iteration           13  OBJ=  -10449.381173468491 eff.=     120. Smpl.=     300. Fit.= 0.93044
 iteration           14  OBJ=  -10449.446112964946 eff.=     120. Smpl.=     300. Fit.= 0.93038
 iteration           15  OBJ=  -10449.466470746927 eff.=     120. Smpl.=     300. Fit.= 0.93046
 iteration           16  OBJ=  -10449.488845500164 eff.=     120. Smpl.=     300. Fit.= 0.93037
 iteration           17  OBJ=  -10449.548196835725 eff.=     120. Smpl.=     300. Fit.= 0.93044
 iteration           18  OBJ=  -10449.581882381874 eff.=     120. Smpl.=     300. Fit.= 0.93043
 iteration           19  OBJ=  -10449.645491931671 eff.=     120. Smpl.=     300. Fit.= 0.93036
 iteration           20  OBJ=  -10449.645825912563 eff.=     120. Smpl.=     300. Fit.= 0.93043
 iteration           21  OBJ=  -10449.744938749647 eff.=     120. Smpl.=     300. Fit.= 0.93041
 iteration           22  OBJ=  -10449.715811115822 eff.=     120. Smpl.=     300. Fit.= 0.93044
 iteration           23  OBJ=  -10449.808994143130 eff.=     120. Smpl.=     300. Fit.= 0.93043
 iteration           24  OBJ=  -10449.755506413470 eff.=     120. Smpl.=     300. Fit.= 0.93040
 iteration           25  OBJ=  -10449.886387564942 eff.=     120. Smpl.=     300. Fit.= 0.93041
 iteration           26  OBJ=  -10449.827700577634 eff.=     120. Smpl.=     300. Fit.= 0.93044
 iteration           27  OBJ=  -10449.921506497651 eff.=     120. Smpl.=     300. Fit.= 0.93038
 iteration           28  OBJ=  -10449.879083375954 eff.=     120. Smpl.=     300. Fit.= 0.93039
 iteration           29  OBJ=  -10449.985787216889 eff.=     120. Smpl.=     300. Fit.= 0.93042
 iteration           30  OBJ=  -10449.909686459348 eff.=     120. Smpl.=     300. Fit.= 0.93043
 iteration           31  OBJ=  -10450.047825101450 eff.=     120. Smpl.=     300. Fit.= 0.93042
 iteration           32  OBJ=  -10449.917668429020 eff.=     120. Smpl.=     300. Fit.= 0.93036
 iteration           33  OBJ=  -10450.090837373316 eff.=     120. Smpl.=     300. Fit.= 0.93043
 iteration           34  OBJ=  -10449.931719336300 eff.=     120. Smpl.=     300. Fit.= 0.93044
 iteration           35  OBJ=  -10450.134357313382 eff.=     120. Smpl.=     300. Fit.= 0.93040
 iteration           36  OBJ=  -10449.986258613771 eff.=     120. Smpl.=     300. Fit.= 0.93040
 iteration           37  OBJ=  -10450.161723149778 eff.=     120. Smpl.=     300. Fit.= 0.93045
 iteration           38  OBJ=  -10450.027467542681 eff.=     120. Smpl.=     300. Fit.= 0.93035
 iteration           39  OBJ=  -10450.197307321700 eff.=     120. Smpl.=     300. Fit.= 0.93050
 iteration           40  OBJ=  -10450.041592045020 eff.=     120. Smpl.=     300. Fit.= 0.93039
 iteration           41  OBJ=  -10450.219852760700 eff.=     120. Smpl.=     300. Fit.= 0.93038
 iteration           42  OBJ=  -10450.093571419708 eff.=     120. Smpl.=     300. Fit.= 0.93045
 iteration           43  OBJ=  -10450.249082883425 eff.=     120. Smpl.=     300. Fit.= 0.93039
 iteration           44  OBJ=  -10450.136765574758 eff.=     120. Smpl.=     300. Fit.= 0.93046
 iteration           45  OBJ=  -10450.275504528343 eff.=     120. Smpl.=     300. Fit.= 0.93038
 iteration           46  OBJ=  -10450.153188364357 eff.=     120. Smpl.=     300. Fit.= 0.93042
 iteration           47  OBJ=  -10450.301941913196 eff.=     120. Smpl.=     300. Fit.= 0.93043
 iteration           48  OBJ=  -10450.153174989702 eff.=     120. Smpl.=     300. Fit.= 0.93044
 iteration           49  OBJ=  -10450.344952102436 eff.=     120. Smpl.=     300. Fit.= 0.93041
 iteration           50  OBJ=  -10450.175051482003 eff.=     120. Smpl.=     300. Fit.= 0.93038
 iteration           51  OBJ=  -10450.391624599451 eff.=     120. Smpl.=     300. Fit.= 0.93046
 iteration           52  OBJ=  -10450.220398911613 eff.=     120. Smpl.=     300. Fit.= 0.93041
 iteration           53  OBJ=  -10450.391602815773 eff.=     120. Smpl.=     300. Fit.= 0.93043
 iteration           54  OBJ=  -10450.252762966014 eff.=     120. Smpl.=     300. Fit.= 0.93040
 iteration           55  OBJ=  -10450.426480643961 eff.=     120. Smpl.=     300. Fit.= 0.93044
 iteration           56  OBJ=  -10450.259683030479 eff.=     120. Smpl.=     300. Fit.= 0.93046
 iteration           57  OBJ=  -10450.401625464921 eff.=     120. Smpl.=     300. Fit.= 0.93041
 iteration           58  OBJ=  -10450.313042945145 eff.=     120. Smpl.=     300. Fit.= 0.93036
 iteration           59  OBJ=  -10450.433452353886 eff.=     120. Smpl.=     300. Fit.= 0.93056
 iteration           60  OBJ=  -10450.378679871850 eff.=     120. Smpl.=     300. Fit.= 0.93038
 iteration           61  OBJ=  -10450.409687296555 eff.=     120. Smpl.=     300. Fit.= 0.93048
 iteration           62  OBJ=  -10450.378004694072 eff.=     120. Smpl.=     300. Fit.= 0.93029
 iteration           63  OBJ=  -10450.435913254927 eff.=     120. Smpl.=     300. Fit.= 0.93052
 iteration           64  OBJ=  -10450.407845207465 eff.=     120. Smpl.=     300. Fit.= 0.93038
 iteration           65  OBJ=  -10450.440709696226 eff.=     120. Smpl.=     300. Fit.= 0.93048
 iteration           66  OBJ=  -10450.399048563890 eff.=     120. Smpl.=     300. Fit.= 0.93040
 iteration           67  OBJ=  -10450.490121166549 eff.=     120. Smpl.=     300. Fit.= 0.93043
 iteration           68  OBJ=  -10450.429243941511 eff.=     120. Smpl.=     300. Fit.= 0.93041
 iteration           69  OBJ=  -10450.513252131914 eff.=     120. Smpl.=     300. Fit.= 0.93048
 iteration           70  OBJ=  -10450.406636741160 eff.=     120. Smpl.=     300. Fit.= 0.93029
 iteration           71  OBJ=  -10450.562433470992 eff.=     120. Smpl.=     300. Fit.= 0.93057
 iteration           72  OBJ=  -10450.441212812493 eff.=     120. Smpl.=     300. Fit.= 0.93032
 iteration           73  OBJ=  -10450.576423619435 eff.=     120. Smpl.=     300. Fit.= 0.93049
 iteration           74  OBJ=  -10450.433867148307 eff.=     120. Smpl.=     300. Fit.= 0.93034
 iteration           75  OBJ=  -10450.638475585331 eff.=     120. Smpl.=     300. Fit.= 0.93051
 iteration           76  OBJ=  -10450.482524100120 eff.=     120. Smpl.=     300. Fit.= 0.93036
 iteration           77  OBJ=  -10450.574383604413 eff.=     120. Smpl.=     300. Fit.= 0.93045
 iteration           78  OBJ=  -10450.479404628495 eff.=     120. Smpl.=     300. Fit.= 0.93034
 iteration           79  OBJ=  -10450.638370061703 eff.=     120. Smpl.=     300. Fit.= 0.93056
 iteration           80  OBJ=  -10450.494809644691 eff.=     120. Smpl.=     300. Fit.= 0.93035
 iteration           81  OBJ=  -10450.672535788803 eff.=     120. Smpl.=     300. Fit.= 0.93047
 iteration           82  OBJ=  -10450.479432399365 eff.=     120. Smpl.=     300. Fit.= 0.93034
 iteration           83  OBJ=  -10450.677842513998 eff.=     120. Smpl.=     300. Fit.= 0.93049
 iteration           84  OBJ=  -10450.515403580486 eff.=     120. Smpl.=     300. Fit.= 0.93033
 iteration           85  OBJ=  -10450.689097287628 eff.=     120. Smpl.=     300. Fit.= 0.93050
 iteration           86  OBJ=  -10450.562098128150 eff.=     120. Smpl.=     300. Fit.= 0.93039
 iteration           87  OBJ=  -10450.645321764465 eff.=     120. Smpl.=     300. Fit.= 0.93044
 iteration           88  OBJ=  -10450.570082599397 eff.=     120. Smpl.=     300. Fit.= 0.93035
 iteration           89  OBJ=  -10450.683202225360 eff.=     120. Smpl.=     300. Fit.= 0.93050
 iteration           90  OBJ=  -10450.573537622828 eff.=     120. Smpl.=     300. Fit.= 0.93035
 iteration           91  OBJ=  -10450.695029227219 eff.=     120. Smpl.=     300. Fit.= 0.93048
 iteration           92  OBJ=  -10450.604856326037 eff.=     120. Smpl.=     300. Fit.= 0.93031
 iteration           93  OBJ=  -10450.727900152204 eff.=     120. Smpl.=     300. Fit.= 0.93060
 iteration           94  OBJ=  -10450.629274834833 eff.=     120. Smpl.=     300. Fit.= 0.93031
 iteration           95  OBJ=  -10450.691059341301 eff.=     120. Smpl.=     300. Fit.= 0.93046
 iteration           96  OBJ=  -10450.667821748370 eff.=     120. Smpl.=     300. Fit.= 0.93036
 iteration           97  OBJ=  -10450.696527649878 eff.=     120. Smpl.=     300. Fit.= 0.93049
 iteration           98  OBJ=  -10450.690782859838 eff.=     120. Smpl.=     300. Fit.= 0.93038
 iteration           99  OBJ=  -10450.723151681834 eff.=     120. Smpl.=     300. Fit.= 0.93053
 iteration          100  OBJ=  -10450.710182848443 eff.=     120. Smpl.=     300. Fit.= 0.93025
 iteration          101  OBJ=  -10450.722871357995 eff.=     120. Smpl.=     300. Fit.= 0.93054
 iteration          102  OBJ=  -10450.693919233321 eff.=     120. Smpl.=     300. Fit.= 0.93035
 iteration          103  OBJ=  -10450.772586420229 eff.=     120. Smpl.=     300. Fit.= 0.93050
 iteration          104  OBJ=  -10450.718827430444 eff.=     120. Smpl.=     300. Fit.= 0.93033
 iteration          105  OBJ=  -10450.736052947768 eff.=     120. Smpl.=     300. Fit.= 0.93052
 iteration          106  OBJ=  -10450.753130878671 eff.=     120. Smpl.=     300. Fit.= 0.93032
 iteration          107  OBJ=  -10450.757885401174 eff.=     120. Smpl.=     300. Fit.= 0.93046
 iteration          108  OBJ=  -10450.724805413201 eff.=     120. Smpl.=     300. Fit.= 0.93037
 iteration          109  OBJ=  -10450.800102263693 eff.=     120. Smpl.=     300. Fit.= 0.93051
 iteration          110  OBJ=  -10450.758409786336 eff.=     120. Smpl.=     300. Fit.= 0.93034
 iteration          111  OBJ=  -10450.776969407396 eff.=     120. Smpl.=     300. Fit.= 0.93046
 iteration          112  OBJ=  -10450.786806620166 eff.=     120. Smpl.=     300. Fit.= 0.93040
 iteration          113  OBJ=  -10450.824518597763 eff.=     120. Smpl.=     300. Fit.= 0.93050
 iteration          114  OBJ=  -10450.806601480921 eff.=     120. Smpl.=     300. Fit.= 0.93025
 iteration          115  OBJ=  -10450.807978852677 eff.=     120. Smpl.=     300. Fit.= 0.93054
 iteration          116  OBJ=  -10450.796529073308 eff.=     120. Smpl.=     300. Fit.= 0.93033
 iteration          117  OBJ=  -10450.843719443499 eff.=     120. Smpl.=     300. Fit.= 0.93046
 iteration          118  OBJ=  -10450.812606153895 eff.=     120. Smpl.=     300. Fit.= 0.93035
 iteration          119  OBJ=  -10450.866527293922 eff.=     120. Smpl.=     300. Fit.= 0.93049
 iteration          120  OBJ=  -10450.783005883010 eff.=     120. Smpl.=     300. Fit.= 0.93038
 iteration          121  OBJ=  -10450.894518200448 eff.=     120. Smpl.=     300. Fit.= 0.93046
 iteration          122  OBJ=  -10450.822033857323 eff.=     120. Smpl.=     300. Fit.= 0.93034
 iteration          123  OBJ=  -10450.907981058506 eff.=     120. Smpl.=     300. Fit.= 0.93048
 iteration          124  OBJ=  -10450.812112542642 eff.=     120. Smpl.=     300. Fit.= 0.93033
 iteration          125  OBJ=  -10450.900171877518 eff.=     120. Smpl.=     300. Fit.= 0.93049
 iteration          126  OBJ=  -10450.822839061064 eff.=     120. Smpl.=     300. Fit.= 0.93036
 iteration          127  OBJ=  -10450.926925777698 eff.=     120. Smpl.=     300. Fit.= 0.93050
 iteration          128  OBJ=  -10450.863499045516 eff.=     120. Smpl.=     300. Fit.= 0.93034
 iteration          129  OBJ=  -10450.897620574027 eff.=     120. Smpl.=     300. Fit.= 0.93045
 iteration          130  OBJ=  -10450.860236732889 eff.=     120. Smpl.=     300. Fit.= 0.93036
 iteration          131  OBJ=  -10450.914225600131 eff.=     120. Smpl.=     300. Fit.= 0.93046
 iteration          132  OBJ=  -10450.904815781012 eff.=     120. Smpl.=     300. Fit.= 0.93041
 iteration          133  OBJ=  -10450.936767439023 eff.=     120. Smpl.=     300. Fit.= 0.93045
 iteration          134  OBJ=  -10450.900488887366 eff.=     120. Smpl.=     300. Fit.= 0.93041
 iteration          135  OBJ=  -10451.004506143650 eff.=     120. Smpl.=     300. Fit.= 0.93042
 iteration          136  OBJ=  -10450.898055726149 eff.=     120. Smpl.=     300. Fit.= 0.93041
 iteration          137  OBJ=  -10450.949399637246 eff.=     120. Smpl.=     300. Fit.= 0.93044
 iteration          138  OBJ=  -10450.920413186082 eff.=     120. Smpl.=     300. Fit.= 0.93032
 iteration          139  OBJ=  -10450.995007972710 eff.=     120. Smpl.=     300. Fit.= 0.93053
 iteration          140  OBJ=  -10450.873835588640 eff.=     120. Smpl.=     300. Fit.= 0.93033
 iteration          141  OBJ=  -10450.991134504420 eff.=     120. Smpl.=     300. Fit.= 0.93051
 iteration          142  OBJ=  -10450.932837592618 eff.=     120. Smpl.=     300. Fit.= 0.93026
 iteration          143  OBJ=  -10450.990794394798 eff.=     120. Smpl.=     300. Fit.= 0.93058
 iteration          144  OBJ=  -10450.893652324481 eff.=     120. Smpl.=     300. Fit.= 0.93037
 iteration          145  OBJ=  -10451.018413072330 eff.=     120. Smpl.=     300. Fit.= 0.93044
 iteration          146  OBJ=  -10450.919391966097 eff.=     120. Smpl.=     300. Fit.= 0.93042
 iteration          147  OBJ=  -10451.025015696541 eff.=     120. Smpl.=     300. Fit.= 0.93040
 iteration          148  OBJ=  -10450.941286777568 eff.=     120. Smpl.=     300. Fit.= 0.93048
 iteration          149  OBJ=  -10451.008522242140 eff.=     120. Smpl.=     300. Fit.= 0.93039
 iteration          150  OBJ=  -10450.923822105102 eff.=     120. Smpl.=     300. Fit.= 0.93041
 Convergence achieved
 iteration          150  OBJ=  -10451.007550964636 eff.=     120. Smpl.=     300. Fit.= 0.93040

 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.

 ETABAR:        -5.6465E-06  2.9355E-06  3.7409E-06  9.1366E-05  1.2763E-05
 SE:             3.0327E-03  1.4713E-02  5.5233E-03  1.0218E-02  1.9768E-02
 N:                     125         125         125         125         125

 P VAL.:         9.9851E-01  9.9984E-01  9.9946E-01  9.9287E-01  9.9948E-01

 ETASHRINKSD(%)  4.0373E+01  9.4505E+00  4.2296E+01  4.4950E+01  2.1010E+00
 ETASHRINKVR(%)  6.4446E+01  1.8008E+01  6.6703E+01  6.9695E+01  4.1579E+00
 EBVSHRINKSD(%)  4.0291E+01  9.3474E+00  4.2195E+01  4.4902E+01  2.1210E+00
 EBVSHRINKVR(%)  6.4349E+01  1.7821E+01  6.6586E+01  6.9642E+01  4.1969E+00
 RELATIVEINF(%)  1.3481E+00  1.0000E+02  9.3534E+00  1.4165E+01  1.0000E-10
 EPSSHRINKSD(%)  4.6183E+00
 EPSSHRINKVR(%)  9.0233E+00

  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         3125
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    5743.3658325292045     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -10451.007550964636     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -4707.6417184354314     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                           625
  
 #TERE:
 Elapsed estimation  time in seconds:  3744.05

 Number of Negative Eigenvalues in Matrix=           2
 Most negative value=  -21014885.383107502
 Most positive value=   2565623.6772675412
 Forcing positive definiteness
 Root mean square deviation of matrix from original=    1.9769880540104174

 Elapsed covariance  time in seconds:    20.91
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -10451.008       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7     
 
         2.50E-01  1.00E+00  4.91E-01  4.98E-02  5.12E+01  1.03E+00  2.00E+01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        3.23E-03
 
 ETA2
+       -1.21E-04  3.30E-02
 
 ETA3
+       -5.99E-03 -3.76E-04  1.15E-02
 
 ETA4
+       -9.72E-03  3.27E-03  1.90E-02  4.31E-02
 
 ETA5
+       -5.76E-03  2.52E-03  9.15E-03  1.92E-02  5.10E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        9.32E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        5.69E-02
 
 ETA2
+       -1.18E-02  1.82E-01
 
 ETA3
+       -9.85E-01 -1.93E-02  1.07E-01
 
 ETA4
+       -8.23E-01  8.67E-02  8.53E-01  2.08E-01
 
 ETA5
+       -4.49E-01  6.14E-02  3.79E-01  4.10E-01  2.26E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        9.65E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                          STANDARD ERROR OF ESTIMATE (R)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7     
 
         0.00E+00  0.00E+00  5.49E-03  9.26E-04  9.07E-01  3.95E-02  4.44E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        1.95E-03
 
 ETA2
+        2.60E-03  5.34E-03
 
 ETA3
+        2.77E-03  3.43E-03  4.87E-03
 
 ETA4
+        5.05E-03  9.20E-03  9.21E-03  2.06E-02
 
 ETA5
+        2.65E-03  4.91E-03  4.62E-03  1.03E-02  7.25E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        2.54E-04
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        1.71E-02
 
 ETA2
+        2.51E-01  1.47E-02
 
 ETA3
+        6.93E-02  1.77E-01  2.28E-02
 
 ETA4
+        2.30E-01  2.32E-01  1.14E-01  4.95E-02
 
 ETA5
+        1.82E-01  1.17E-01  1.57E-01  1.65E-01  1.60E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.32E-03
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (R)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      OM11      OM12      OM13      OM14      OM15  
             OM22      OM23      OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 TH 1
+       .........
 
 TH 2
+       ......... .........
 
 TH 3
+        0.00E+00  0.00E+00  3.01E-05
 
 TH 4
+        0.00E+00  0.00E+00 -7.22E-07  8.57E-07
 
 TH 5
+        0.00E+00  0.00E+00 -3.92E-03  2.41E-05  8.22E-01
 
 TH 6
+        0.00E+00  0.00E+00 -1.37E-04  7.57E-06  2.70E-02  1.56E-03
 
 TH 7
+        0.00E+00  0.00E+00 -1.16E-03  7.10E-05  1.35E-01  7.51E-03  1.97E-01
 
 OM11
+        0.00E+00  0.00E+00  2.09E-06 -1.38E-07 -2.18E-04 -1.75E-05 -1.23E-04  3.80E-06
 
 OM12
+        0.00E+00  0.00E+00 -2.55E-06  1.38E-07  1.38E-04  1.25E-05  1.17E-04 -7.41E-07  6.75E-06
 
 OM13
+        0.00E+00  0.00E+00 -2.56E-06  1.59E-07  2.76E-04  2.28E-05  1.46E-04 -4.86E-06  1.30E-06  7.68E-06
 
 OM14
+        0.00E+00  0.00E+00 -3.03E-06  1.96E-07  3.95E-04  3.28E-05  1.67E-04 -6.55E-06  5.17E-06  1.15E-05  2.55E-05
 
 OM15
+        0.00E+00  0.00E+00 -2.56E-06  5.83E-08  2.45E-04  1.85E-05  1.10E-04 -2.22E-06  2.06E-06  3.73E-06  7.12E-06  7.02E-06
 
 OM22
+        0.00E+00  0.00E+00  2.15E-06 -2.37E-07 -7.79E-05 -1.54E-05 -1.13E-04  1.55E-06 -3.34E-06 -1.86E-06 -3.57E-06 -1.85E-06
          2.85E-05
 
 OM23
+        0.00E+00  0.00E+00  1.82E-06 -1.02E-07 -2.80E-04 -1.39E-05 -8.13E-05  1.09E-06 -6.71E-06 -1.09E-06 -3.77E-06 -1.02E-06
          1.09E-06  1.18E-05
 
 OM24
+        0.00E+00  0.00E+00  6.58E-06 -5.72E-07 -6.15E-04 -6.03E-05 -3.66E-04  4.51E-06 -1.76E-05 -6.45E-06 -1.84E-05 -6.35E-06
          1.43E-05  2.29E-05  8.46E-05
 
 OM25
+        0.00E+00  0.00E+00  2.29E-06 -3.83E-08 -6.04E-05 -1.26E-05 -1.21E-04  2.38E-06 -7.36E-06 -2.98E-06 -6.53E-06 -3.15E-06
          7.05E-06  6.61E-06  2.49E-05  2.41E-05
 
 OM33
+        0.00E+00  0.00E+00  2.87E-06 -1.32E-07 -3.53E-04 -2.94E-05 -1.52E-04  5.71E-06 -1.61E-06 -1.17E-05 -2.00E-05 -6.84E-06
          7.10E-07  7.27E-07  7.62E-06  2.57E-06  2.37E-05
 
 OM34
+        0.00E+00  0.00E+00  4.23E-06 -2.57E-07 -6.88E-04 -5.33E-05 -2.28E-04  1.09E-05 -5.90E-06 -2.07E-05 -4.32E-05 -1.24E-05
          1.96E-06  5.84E-06  2.51E-05  6.81E-06  4.00E-05  8.47E-05
 
 OM35
+        0.00E+00  0.00E+00  4.09E-06 -1.44E-07 -3.92E-04 -3.11E-05 -1.76E-04  4.13E-06 -3.30E-06 -6.71E-06 -1.36E-05 -1.05E-05
          2.73E-06  2.18E-06  1.15E-05  4.47E-06  1.09E-05  2.30E-05  2.13E-05
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      OM11      OM12      OM13      OM14      OM15  
             OM22      OM23      OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 OM44
+        0.00E+00  0.00E+00  9.83E-06 -7.83E-07 -1.30E-03 -1.15E-04 -5.56E-04  2.20E-05 -2.01E-05 -3.79E-05 -8.77E-05 -2.28E-05
          1.38E-05  1.90E-05  9.36E-05  2.77E-05  6.79E-05  1.67E-04  4.74E-05  4.23E-04
 
 OM45
+        0.00E+00  0.00E+00  9.74E-06 -2.91E-07 -9.45E-04 -7.46E-05 -4.32E-04  9.22E-06 -1.05E-05 -1.43E-05 -3.26E-05 -1.94E-05
          8.90E-06  7.15E-06  3.94E-05  1.84E-05  2.20E-05  5.13E-05  3.98E-05  1.29E-04  1.07E-04
 
 OM55
+        0.00E+00  0.00E+00  3.02E-06 -4.54E-08 -2.22E-04 -2.16E-05 -1.48E-04  4.54E-06 -2.82E-06 -5.76E-06 -8.64E-06 -1.09E-05
          2.89E-06  1.97E-06  9.80E-06  8.16E-06  7.61E-06  1.33E-05  1.59E-05  2.93E-05  3.84E-05  5.25E-05
 
 SG11
+        0.00E+00  0.00E+00 -5.29E-08  4.16E-09  3.99E-06  4.58E-07  3.36E-06 -6.17E-08  2.69E-09  9.31E-08  9.83E-08  4.07E-08
         -6.05E-08 -7.96E-09 -1.10E-07 -6.27E-08 -1.39E-07 -2.38E-07 -3.77E-08 -6.58E-07 -1.64E-07 -1.19E-07  6.45E-08
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (R)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      OM11      OM12      OM13      OM14      OM15  
             OM22      OM23      OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 TH 1
+       .........
 
 TH 2
+       ......... .........
 
 TH 3
+        0.00E+00  0.00E+00  5.49E-03
 
 TH 4
+        0.00E+00  0.00E+00 -1.42E-01  9.26E-04
 
 TH 5
+        0.00E+00  0.00E+00 -7.89E-01  2.88E-02  9.07E-01
 
 TH 6
+        0.00E+00  0.00E+00 -6.33E-01  2.07E-01  7.55E-01  3.95E-02
 
 TH 7
+        0.00E+00  0.00E+00 -4.78E-01  1.73E-01  3.36E-01  4.29E-01  4.44E-01
 
 OM11
+        0.00E+00  0.00E+00  1.96E-01 -7.66E-02 -1.23E-01 -2.28E-01 -1.42E-01  1.95E-03
 
 OM12
+        0.00E+00  0.00E+00 -1.78E-01  5.72E-02  5.86E-02  1.21E-01  1.02E-01 -1.46E-01  2.60E-03
 
 OM13
+        0.00E+00  0.00E+00 -1.68E-01  6.21E-02  1.10E-01  2.09E-01  1.19E-01 -9.00E-01  1.80E-01  2.77E-03
 
 OM14
+        0.00E+00  0.00E+00 -1.09E-01  4.20E-02  8.64E-02  1.65E-01  7.46E-02 -6.66E-01  3.94E-01  8.21E-01  5.05E-03
 
 OM15
+        0.00E+00  0.00E+00 -1.76E-01  2.38E-02  1.02E-01  1.77E-01  9.38E-02 -4.31E-01  3.00E-01  5.08E-01  5.33E-01  2.65E-03
 
 OM22
+        0.00E+00  0.00E+00  7.35E-02 -4.80E-02 -1.61E-02 -7.32E-02 -4.79E-02  1.49E-01 -2.41E-01 -1.26E-01 -1.33E-01 -1.31E-01
          5.34E-03
 
 OM23
+        0.00E+00  0.00E+00  9.67E-02 -3.20E-02 -9.00E-02 -1.03E-01 -5.34E-02  1.63E-01 -7.53E-01 -1.15E-01 -2.18E-01 -1.13E-01
          5.98E-02  3.43E-03
 
 OM24
+        0.00E+00  0.00E+00  1.30E-01 -6.72E-02 -7.38E-02 -1.66E-01 -8.97E-02  2.51E-01 -7.37E-01 -2.53E-01 -3.97E-01 -2.61E-01
          2.91E-01  7.26E-01  9.20E-03
 
 OM25
+        0.00E+00  0.00E+00  8.51E-02 -8.43E-03 -1.36E-02 -6.52E-02 -5.57E-02  2.49E-01 -5.77E-01 -2.19E-01 -2.64E-01 -2.42E-01
          2.69E-01  3.93E-01  5.51E-01  4.91E-03
 
 OM33
+        0.00E+00  0.00E+00  1.07E-01 -2.93E-02 -7.99E-02 -1.53E-01 -7.01E-02  6.02E-01 -1.27E-01 -8.70E-01 -8.12E-01 -5.30E-01
          2.73E-02  4.35E-02  1.70E-01  1.07E-01  4.87E-03
 
 OM34
+        0.00E+00  0.00E+00  8.38E-02 -3.01E-02 -8.25E-02 -1.47E-01 -5.59E-02  6.06E-01 -2.47E-01 -8.10E-01 -9.31E-01 -5.10E-01
          3.99E-02  1.85E-01  2.96E-01  1.51E-01  8.93E-01  9.21E-03
 
 OM35
+        0.00E+00  0.00E+00  1.61E-01 -3.38E-02 -9.36E-02 -1.71E-01 -8.62E-02  4.58E-01 -2.75E-01 -5.25E-01 -5.84E-01 -8.63E-01
          1.11E-01  1.38E-01  2.70E-01  1.97E-01  4.87E-01  5.42E-01  4.62E-03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      OM11      OM12      OM13      OM14      OM15  
             OM22      OM23      OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 OM44
+        0.00E+00  0.00E+00  8.71E-02 -4.11E-02 -6.96E-02 -1.41E-01 -6.10E-02  5.48E-01 -3.77E-01 -6.66E-01 -8.45E-01 -4.18E-01
          1.26E-01  2.70E-01  4.95E-01  2.75E-01  6.77E-01  8.82E-01  4.99E-01  2.06E-02
 
 OM45
+        0.00E+00  0.00E+00  1.72E-01 -3.04E-02 -1.01E-01 -1.83E-01 -9.43E-02  4.58E-01 -3.93E-01 -5.00E-01 -6.25E-01 -7.10E-01
          1.61E-01  2.02E-01  4.15E-01  3.63E-01  4.38E-01  5.39E-01  8.35E-01  6.07E-01  1.03E-02
 
 OM55
+        0.00E+00  0.00E+00  7.59E-02 -6.77E-03 -3.38E-02 -7.57E-02 -4.59E-02  3.21E-01 -1.50E-01 -2.87E-01 -2.36E-01 -5.66E-01
          7.47E-02  7.91E-02  1.47E-01  2.29E-01  2.16E-01  2.00E-01  4.75E-01  1.97E-01  5.13E-01  7.25E-03
 
 SG11
+        0.00E+00  0.00E+00 -3.79E-02  1.77E-02  1.73E-02  4.57E-02  2.98E-02 -1.25E-01  4.07E-03  1.32E-01  7.67E-02  6.05E-02
         -4.46E-02 -9.14E-03 -4.70E-02 -5.03E-02 -1.12E-01 -1.02E-01 -3.21E-02 -1.26E-01 -6.26E-02 -6.45E-02  2.54E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (R)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      OM11      OM12      OM13      OM14      OM15  
             OM22      OM23      OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 TH 1
+       .........
 
 TH 2
+       ......... .........
 
 TH 3
+        0.00E+00  0.00E+00  1.13E+05
 
 TH 4
+        0.00E+00  0.00E+00  5.91E+04  1.32E+06
 
 TH 5
+        0.00E+00  0.00E+00  5.25E+02  6.61E+02  5.43E+00
 
 TH 6
+        0.00E+00  0.00E+00 -1.14E+03 -1.22E+04 -5.91E+01  1.82E+03
 
 TH 7
+        0.00E+00  0.00E+00  3.06E+02 -1.23E+02  1.21E+00 -2.85E+01  7.16E+00
 
 OM11
+        0.00E+00  0.00E+00  2.07E+05  6.67E+04  1.44E+03 -1.61E+04  1.11E+02 -8.67E+06
 
 OM12
+        0.00E+00  0.00E+00  6.76E+04 -5.38E+02  3.60E+02 -1.26E+03  2.17E+01  1.36E+06  6.46E+05
 
 OM13
+        0.00E+00  0.00E+00  2.53E+05  6.69E+04  1.79E+03 -1.95E+04  1.25E+02 -9.52E+06  2.07E+06 -1.04E+07
 
 OM14
+        0.00E+00  0.00E+00 -5.53E+04 -1.03E+04 -3.31E+02  3.08E+03 -3.09E+01 -1.14E+05 -4.69E+05 -7.14E+05  7.98E+05
 
 OM15
+        0.00E+00  0.00E+00  4.24E+04  3.88E+04  2.44E+02 -4.00E+03  2.29E+01 -1.87E+06  9.34E+04 -1.97E+06  7.47E+04  4.70E+05
 
 OM22
+        0.00E+00  0.00E+00  6.32E+02  3.65E+03  5.50E+00  4.69E+01 -3.97E+00 -1.50E+04  3.30E+04 -5.32E+03 -6.56E+03  1.52E+03
          4.32E+04
 
 OM23
+        0.00E+00  0.00E+00  3.60E+04  4.75E+02  2.64E+02 -2.38E+03  1.29E+01  9.04E+05  2.81E+05  1.48E+06 -3.16E+05  5.69E+04
          3.97E+04  3.43E+05
 
 OM24
+        0.00E+00  0.00E+00 -2.78E+03  3.86E+03 -4.54E+01  1.21E+03 -4.09E+00 -1.65E+05  7.93E+03 -2.78E+05  5.99E+04 -4.75E+03
         -1.22E+04 -7.08E+04  4.94E+04
 
 OM25
+        0.00E+00  0.00E+00  4.51E+03 -9.59E+03  2.25E+01 -4.67E+02  5.45E+00  5.61E+04  7.76E+04  9.86E+04 -2.97E+04  2.71E+04
         -3.25E+03  2.95E+04 -1.40E+04  7.61E+04
 
 OM33
+        0.00E+00  0.00E+00  7.64E+04  1.19E+04  5.52E+02 -6.26E+03  3.60E+01 -3.11E+06  7.83E+05 -3.18E+06 -4.11E+05 -5.57E+05
          5.01E+03  6.46E+05 -1.33E+05  3.33E+04 -5.70E+05
 
 OM34
+        0.00E+00  0.00E+00 -2.94E+04 -1.28E+03 -1.89E+02  2.67E+03 -1.61E+01  1.46E+04 -3.12E+05 -5.34E+05  5.18E+05  8.29E+04
         -7.51E+03 -2.79E+05  7.27E+04 -1.66E+04 -5.42E+05  5.70E+05
 
 OM35
+        0.00E+00  0.00E+00  2.36E+04  2.01E+04  1.31E+02 -2.30E+03 -1.12E+00 -9.56E+05  8.70E+04 -8.55E+05 -2.12E+04  1.95E+05
          3.48E+02  4.18E+04 -4.81E+03  3.69E+04 -2.16E+05 -2.64E+04  2.64E+05
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      OM11      OM12      OM13      OM14      OM15  
             OM22      OM23      OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 OM44
+        0.00E+00  0.00E+00  2.99E+03  6.40E+02  1.90E+01 -4.30E+02  2.32E+00  1.02E+05  2.53E+04  2.05E+05 -5.75E+04 -6.06E+03
          2.31E+03  3.58E+04 -1.70E+04  3.05E+03  1.27E+05 -9.85E+04  1.51E+04  2.65E+04
 
 OM45
+        0.00E+00  0.00E+00 -8.50E+03 -8.98E+03 -4.17E+01  8.08E+02 -7.91E+00  9.20E+04 -1.78E+04  2.64E+04  5.08E+04 -9.05E+03
          6.15E+02 -3.54E+03  6.10E+01 -1.36E+04 -3.74E+03  3.57E+04 -7.28E+04 -1.16E+04  5.01E+04
 
 OM55
+        0.00E+00  0.00E+00  1.43E+03  2.33E+03  2.43E+00 -1.48E+02  4.23E+00 -3.53E+04 -3.60E+03 -4.16E+04 -8.97E+03  6.15E+04
         -1.19E+01 -1.56E+03  1.24E+03 -3.25E+03 -1.23E+04 -2.43E+03  2.53E+04  1.32E+03 -1.35E+04  3.27E+04
 
 SG11
+        0.00E+00  0.00E+00 -5.05E+03 -7.62E+03  3.20E+01 -1.19E+03  3.68E-01  1.10E+06 -3.21E+04  7.52E+05  1.72E+05  1.91E+04
          2.13E+04 -6.38E+03 -1.37E+04  1.37E+03  3.79E+05 -1.06E+05 -3.90E+04  5.75E+04  2.65E+03  5.48E+03  1.61E+07
 
 Elapsed postprocess time in seconds:     4.55
 Elapsed finaloutput time in seconds:     0.63
 #CPUT: Total CPU Time in Seconds,     4813.328
Stop Time: 
Tue 01/11/2022 
07:37 PM
