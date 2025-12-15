Tue 01/11/2022 
06:11 PM
;DDE
$PROBLEM LOGISTIC
; turn off second derivative assessments, sometimes even 1st derivatives if only simulating
$ABBR DERIV2=NO DERIV2=NOCOMMON 
$INPUT ID AMT TIME PRDV DV EVID MDV 
$DATA LOGISTIC6.csv IGNORE=C
$SUBROUTINES ADVAN16 TOL=6 ATOL=6 
$MODEL NCOMPARTMENTS=1

$PK
CALLFL=-2
MXSTEP=2000000000
MU_1=THETA(1)
MU_2=THETA(2)
MU_3=THETA(3)
MU_4=THETA(4)
KG=EXP(MU_1+ETA(1))
Y0=EXP(MU_2+ETA(2))
YSS=EXP(MU_3+ETA(3))
TAU1=EXP(MU_4+ETA(4))
; Initial conditions
A_0(1)=Y0



TSTOP=500.0

$DES
; AD_1_1 is the State value of A(1) delayed for time TAU1.
; AP_1_1 is the State value of A(1) in the past, for time delay TAU1.

; DELAY SETUP FOR EQUATION SET 1
 AP_1_1=Y0
; DELAY EQUATIONS FOR EQUATION SET 0 (BASE EQUATIONS)
;BASE EQUATIONS
 DADT(1)=KG*(1.0-AD_1_1/YSS)*A(1)

$ERROR
A1=A(1)


Y1=1.0
IPRED=A(1)
Y=IPRED*(1.0+EPS(1))

;$THETA
;-1.609     ; KG
;-0.0001     ; Y0
;2.3026    ; YSS
;1.609     ; TAU1

;$OMEGA (0.01)x4

;$SIGMA
;0.003


$THETA
-1.2
-2.34841E-02 
2.8
0.9

$OMEGA BLOCK(4)
0.1
6.83328E-04  0.1
1.05324E-03 -1.82494E-03  0.1
7.11753E-04  8.46056E-04  1.47772E-03  0.1

$SIGMA
0.01

$EST METHOD=ITS INTERACTION NOABORT SIGL=4 SIGLO=6 MCETA=10 NSIG=2 PRINT=1 NITER=100 CTYPE=3 FAST
$EST METHOD=IMP INTERACTION MAXEVAL=9999 NOABORT SIGL=6 NSIG=2 PRINT=1 NITER=100 CTYPE=3 MAPITER=0
$COV MATRIX=R UNCONDITIONAL
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
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
 LOGISTIC
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:     2340
 NO. OF DATA ITEMS IN DATA SET:   7
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   5
 MDV DATA ITEM IS DATA ITEM NO.:  7
0INDICES PASSED TO SUBROUTINE PRED:
   6   3   2   0   0   0   0   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID AMT TIME PRDV DV EVID MDV
0FORMAT FOR DATA:
 (5E14.0/2E14.0)

 TOT. NO. OF OBS RECS:     2340
 TOT. NO. OF INDIVIDUALS:       30
0LENGTH OF THETA:   4
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS BLOCK FORM:
  1
  1  1
  1  1  1
  1  1  1  1
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
  -0.1200E+01 -0.2348E-01  0.2800E+01  0.9000E+00
0INITIAL ESTIMATE OF OMEGA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.1000E+00
                  0.6833E-03   0.1000E+00
                  0.1053E-02  -0.1825E-02   0.1000E+00
                  0.7118E-03   0.8461E-03   0.1478E-02   0.1000E+00
0INITIAL ESTIMATE OF SIGMA:
 0.1000E-01
0COVARIANCE STEP OMITTED:        NO
 R MATRIX SUBSTITUTED:          YES
 S MATRIX SUBSTITUTED:           NO
 EIGENVLS. PRINTED:              NO
 COMPRESSED FORMAT:              NO
 GRADIENT METHOD USED:       FAST
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
1DOUBLE PRECISION PREDPP VERSION 7.5.1

 GENERAL NONLINEAR KINETICS MODEL WITH STIFF/NONSTIFF AND DELAY EQUATIONS (RADAR5, ADVAN16)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:   8
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         COMP 1       ON         YES        YES        YES        YES
    2         OUTPUT       OFF        YES        NO         NO         NO
 INITIAL (BASE) TOLERANCE SETTINGS:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            *           *           *           *           *
    2            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      6
   TIME DATA ITEM IS DATA ITEM NO.:          3
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   2

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE CALLED AT NONEVENT (ADDITIONAL AND LAGGED) DOSE TIMES.
0PK SUBROUTINE INDICATES THAT COMPARTMENT AMOUNTS ARE INITIALIZED.
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
0ERROR SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
0DES SUBROUTINE USES FULL STORAGE MODE.
1


 #TBLN:      1
 #METH: Iterative Two Stage

 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               FAST
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            528
 NO. OF SIG. FIGURES REQUIRED:            2
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    10
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      6
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     4
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): logistic7c.ext
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
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          1
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 ITERATIONS (NITER):                        100
 ANNEAL SETTING (CONSTRAIN):                 1

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6

 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI

 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2   3   4
 THETAS THAT ARE SIGMA-LIKE:
 

 MONITORING OF SEARCH:

 iteration            0  OBJ=   562.80404571172960
 iteration            1  OBJ=   63.887987199132098
 iteration            2  OBJ=  -6.8252989064559229
 iteration            3  OBJ=  -68.674826204532053
 iteration            4  OBJ=  -128.79835414588470
 iteration            5  OBJ=  -188.37896316321073
 iteration            6  OBJ=  -247.69873981296305
 iteration            7  OBJ=  -306.82369402698345
 iteration            8  OBJ=  -365.74897105049877
 iteration            9  OBJ=  -424.43498072790891
 iteration           10  OBJ=  -482.81482672885272
 iteration           11  OBJ=  -540.78896168226936
 iteration           12  OBJ=  -598.20861369000397
 iteration           13  OBJ=  -654.84234942016349
 iteration           14  OBJ=  -710.30555617096365
 iteration           15  OBJ=  -763.90117022873005
 iteration           16  OBJ=  -814.21238236297677
 iteration           17  OBJ=  -857.89777092337658
 iteration           18  OBJ=  -885.99466110711114
 iteration           19  OBJ=  -888.67467717565398
 iteration           20  OBJ=  -889.26379346881356
 iteration           21  OBJ=  -889.35133260275768
 iteration           22  OBJ=  -889.38507256838386
 iteration           23  OBJ=  -889.39312778637247
 iteration           24  OBJ=  -889.39645071033772
 iteration           25  OBJ=  -889.39710705206596
 iteration           26  OBJ=  -889.39749626429148
 iteration           27  OBJ=  -889.39753367532990
 Convergence achieved

 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.

 ETABAR:         2.8077E-07  1.0773E-06  1.5677E-06 -8.2281E-07
 SE:             1.6556E-02  1.5029E-02  1.5071E-02  1.2929E-02
 N:                      30          30          30          30

 P VAL.:         9.9999E-01  9.9994E-01  9.9992E-01  9.9995E-01

 ETASHRINKSD(%)  1.3735E+00  4.3014E+00  3.8900E-01  1.0124E+01
 ETASHRINKVR(%)  2.7282E+00  8.4178E+00  7.7648E-01  1.9222E+01
 EBVSHRINKSD(%)  1.3739E+00  4.3029E+00  3.8914E-01  1.0125E+01
 EBVSHRINKVR(%)  2.7290E+00  8.4206E+00  7.7677E-01  1.9225E+01
 RELATIVEINF(%)  9.6213E+01  9.0819E+01  9.8870E+01  7.9205E+01
 EPSSHRINKSD(%)  2.3501E+00
 EPSSHRINKVR(%)  4.6450E+00

  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         2340
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    4300.6323353978678     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -889.39753367532990     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       3411.2348017225377     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                           120
  
 #TERE:
 Elapsed estimation  time in seconds:    50.91
 Elapsed covariance  time in seconds:     0.03
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     -889.398       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
        -1.62E+00 -2.42E-02  2.29E+00  1.58E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        8.45E-03
 
 ETA2
+        6.53E-04  7.40E-03
 
 ETA3
+        1.02E-03 -1.74E-03  6.87E-03
 
 ETA4
+        5.48E-04  6.79E-04  1.44E-03  6.21E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.23E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        9.19E-02
 
 ETA2
+        8.25E-02  8.60E-02
 
 ETA3
+        1.33E-01 -2.44E-01  8.29E-02
 
 ETA4
+        7.56E-02  1.00E-01  2.20E-01  7.88E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.68E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                          STANDARD ERROR OF ESTIMATE (S)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         2.80E-02  4.38E-02  2.58E-02  2.61E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        4.92E-03
 
 ETA2
+        2.41E-03  3.09E-03
 
 ETA3
+        3.47E-03  2.07E-03  3.16E-03
 
 ETA4
+        1.76E-03  4.38E-03  2.24E-03  2.79E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.34E-04
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        2.68E-02
 
 ETA2
+        3.11E-01  1.80E-02
 
 ETA3
+        4.58E-01  2.67E-01  1.91E-02
 
 ETA4
+        2.38E-01  6.43E-01  3.32E-01  1.77E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.18E-03
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (S)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        7.82E-04
 
 TH 2
+       -4.59E-05  1.92E-03
 
 TH 3
+       -8.83E-05  1.73E-04  6.68E-04
 
 TH 4
+        1.21E-04  9.95E-05 -1.64E-04  6.82E-04
 
 OM11
+        6.08E-05  1.02E-04 -1.81E-05  2.81E-05  2.42E-05
 
 OM12
+       -3.86E-07 -5.09E-05 -1.50E-05  8.40E-07 -5.28E-06  5.82E-06
 
 OM13
+        2.15E-05 -7.68E-05 -4.59E-05  2.98E-05  3.72E-06  6.11E-07  1.21E-05
 
 OM14
+        6.04E-06  3.53E-06  8.29E-06  4.93E-06  1.62E-06 -7.24E-07  1.53E-06  3.11E-06
 
 OM22
+        2.83E-05 -5.48E-05 -3.41E-05  3.06E-05  5.17E-07  2.81E-06  5.98E-06  2.83E-07  9.54E-06
 
 OM23
+       -2.95E-05  1.48E-05  2.29E-05 -1.55E-05 -3.54E-06  1.55E-07 -2.73E-06 -2.20E-07 -3.61E-06  4.28E-06
 
 OM24
+        2.12E-05  1.47E-04  6.35E-06  2.62E-05  1.10E-05 -5.66E-06 -3.65E-06  1.70E-06 -1.85E-06  6.45E-07  1.92E-05
 
 OM33
+       -2.78E-05  6.49E-05  2.20E-06  1.64E-05  2.65E-06 -4.61E-07 -2.56E-06 -7.08E-07 -2.09E-06 -1.31E-07  1.18E-06  1.00E-05
 
 OM34
+        2.45E-05 -1.30E-05  1.98E-05 -2.10E-06  2.54E-06 -5.74E-07  6.38E-07  1.50E-06  5.15E-07 -1.50E-06 -1.87E-06 -1.17E-07
          5.01E-06
 
 OM44
+        1.43E-05  3.57E-05  2.19E-05 -3.08E-05  2.84E-06 -1.65E-06 -2.01E-06  8.18E-07 -7.78E-07  1.12E-07  3.82E-06 -7.52E-07
          2.29E-06  7.76E-06
 
 SG11
+        4.73E-07  1.07E-07 -3.08E-07 -4.70E-07  4.65E-08  2.42E-08 -3.94E-08 -1.32E-08 -2.33E-08 -1.90E-08 -2.38E-08 -7.69E-08
          2.45E-08  5.35E-08  1.81E-08
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (S)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        2.80E-02
 
 TH 2
+       -3.75E-02  4.38E-02
 
 TH 3
+       -1.22E-01  1.52E-01  2.58E-02
 
 TH 4
+        1.66E-01  8.70E-02 -2.44E-01  2.61E-02
 
 OM11
+        4.42E-01  4.71E-01 -1.42E-01  2.18E-01  4.92E-03
 
 OM12
+       -5.72E-03 -4.82E-01 -2.41E-01  1.33E-02 -4.45E-01  2.41E-03
 
 OM13
+        2.21E-01 -5.05E-01 -5.12E-01  3.29E-01  2.17E-01  7.29E-02  3.47E-03
 
 OM14
+        1.22E-01  4.57E-02  1.82E-01  1.07E-01  1.87E-01 -1.70E-01  2.49E-01  1.76E-03
 
 OM22
+        3.28E-01 -4.05E-01 -4.28E-01  3.79E-01  3.40E-02  3.77E-01  5.58E-01  5.20E-02  3.09E-03
 
 OM23
+       -5.09E-01  1.63E-01  4.28E-01 -2.87E-01 -3.48E-01  3.10E-02 -3.80E-01 -6.03E-02 -5.66E-01  2.07E-03
 
 OM24
+        1.73E-01  7.64E-01  5.61E-02  2.29E-01  5.09E-01 -5.36E-01 -2.40E-01  2.20E-01 -1.37E-01  7.11E-02  4.38E-03
 
 OM33
+       -3.14E-01  4.69E-01  2.69E-02  1.99E-01  1.70E-01 -6.05E-02 -2.33E-01 -1.27E-01 -2.14E-01 -2.01E-02  8.49E-02  3.16E-03
 
 OM34
+        3.92E-01 -1.33E-01  3.42E-01 -3.60E-02  2.31E-01 -1.06E-01  8.20E-02  3.80E-01  7.45E-02 -3.24E-01 -1.91E-01 -1.66E-02
          2.24E-03
 
 OM44
+        1.84E-01  2.93E-01  3.05E-01 -4.24E-01  2.07E-01 -2.46E-01 -2.07E-01  1.66E-01 -9.04E-02  1.95E-02  3.13E-01 -8.54E-02
          3.68E-01  2.79E-03
 
 SG11
+        1.26E-01  1.81E-02 -8.85E-02 -1.34E-01  7.02E-02  7.47E-02 -8.43E-02 -5.55E-02 -5.61E-02 -6.83E-02 -4.03E-02 -1.81E-01
          8.14E-02  1.43E-01  1.34E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (S)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        3.52E+03
 
 TH 2
+       -2.83E+02  4.08E+03
 
 TH 3
+       -6.14E+02  1.23E+03  4.94E+03
 
 TH 4
+        7.68E+01 -7.65E+02 -1.02E+03  4.16E+03
 
 OM11
+       -4.29E+03 -9.67E+03 -3.27E+03  6.46E+03  1.46E+05
 
 OM12
+       -1.93E+04  1.29E+04  2.41E+04 -1.08E+04 -2.07E+04  6.12E+05
 
 OM13
+       -6.49E+03  2.40E+04  2.91E+04 -1.89E+04 -1.49E+05  2.92E+05  5.10E+05
 
 OM14
+        1.40E+04 -1.10E+04 -1.87E+04  1.19E+04  8.28E+04 -2.38E+05 -3.24E+05  6.93E+05
 
 OM22
+        6.44E+03  1.58E+02 -7.33E+03 -5.71E+03  3.43E+04 -2.61E+05 -1.69E+05  1.12E+05  3.73E+05
 
 OM23
+        2.39E+04 -1.46E+04 -3.52E+04  8.81E+03  7.68E+04 -4.09E+05 -2.84E+05  1.90E+05  3.26E+05  8.93E+05
 
 OM24
+       -1.07E+04 -1.10E+04  8.91E+03 -1.84E+04 -7.36E+04  2.29E+05  1.76E+05 -2.43E+05 -1.10E+05 -1.66E+05  3.85E+05
 
 OM33
+        1.44E+04 -1.76E+04 -4.22E+03 -5.14E+03 -1.44E+04 -1.30E+05 -5.20E+04  8.90E+04  6.83E+04  1.65E+05  5.38E+04  2.74E+05
 
 OM34
+       -1.77E+04  9.10E+03 -1.01E+04 -1.74E+04 -1.01E+05  1.74E+05  1.67E+05 -3.57E+05 -2.87E+04  2.83E+04  2.71E+05 -7.52E+04
          7.28E+05
 
 OM44
+        3.13E+03 -9.48E+03 -9.30E+03  2.52E+04  5.19E+04 -8.74E+04 -1.31E+05  1.29E+05 -4.10E+04  5.38E+04 -1.58E+05  1.91E+04
         -2.52E+05  3.61E+05
 
 SG11
+        2.91E+04 -5.25E+04  8.08E+04 -3.67E+04 -3.80E+05 -7.40E+05  5.54E+05  1.03E+05  6.63E+05  6.06E+05  6.28E+05  1.23E+06
         -2.94E+05 -5.89E+05  6.82E+07
 
1


 #TBLN:      2
 #METH: Importance Sampling

 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               FAST
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
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    10
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      6
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     6
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): logistic7c.ext
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

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6

 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI

 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2   3   4
 THETAS THAT ARE SIGMA-LIKE:
 

 MONITORING OF SEARCH:

 iteration            0  OBJ=  -889.40363261248785 eff.=     300. Smpl.=     300. Fit.= 0.99098
 iteration            1  OBJ=  -889.62396837778522 eff.=     124. Smpl.=     300. Fit.= 0.90144
 iteration            2  OBJ=  -888.91028986958349 eff.=     119. Smpl.=     300. Fit.= 0.89974
 iteration            3  OBJ=  -889.74445283490388 eff.=     121. Smpl.=     300. Fit.= 0.89865
 iteration            4  OBJ=  -889.41751801601856 eff.=     122. Smpl.=     300. Fit.= 0.90053
 iteration            5  OBJ=  -889.58100364447989 eff.=     121. Smpl.=     300. Fit.= 0.90006
 iteration            6  OBJ=  -889.12471764240649 eff.=     119. Smpl.=     300. Fit.= 0.89981
 iteration            7  OBJ=  -889.97288854289138 eff.=     123. Smpl.=     300. Fit.= 0.90017
 iteration            8  OBJ=  -889.34673067526694 eff.=     120. Smpl.=     300. Fit.= 0.90033
 iteration            9  OBJ=  -889.58577981463634 eff.=     120. Smpl.=     300. Fit.= 0.89796
 iteration           10  OBJ=  -889.81795786390876 eff.=     122. Smpl.=     300. Fit.= 0.90049
 iteration           11  OBJ=  -889.39693968155007 eff.=     120. Smpl.=     300. Fit.= 0.89962
 Convergence achieved
 iteration           11  OBJ=  -889.33314761729252 eff.=     119. Smpl.=     300. Fit.= 0.89985

 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.

 ETABAR:         5.5489E-05 -1.1679E-04 -3.2618E-05 -1.8009E-04
 SE:             1.6429E-02  1.5021E-02  1.5088E-02  1.2972E-02
 N:                      30          30          30          30

 P VAL.:         9.9731E-01  9.9380E-01  9.9828E-01  9.8892E-01

 ETASHRINKSD(%)  1.5285E+00  4.8731E+00  2.7607E-01  1.0330E+01
 ETASHRINKVR(%)  3.0337E+00  9.5088E+00  5.5138E-01  1.9593E+01
 EBVSHRINKSD(%)  1.4311E+00  4.2813E+00  3.8276E-01  1.0236E+01
 EBVSHRINKVR(%)  2.8417E+00  8.3793E+00  7.6405E-01  1.9424E+01
 RELATIVEINF(%)  9.5903E+01  9.0827E+01  9.8893E+01  7.8756E+01
 EPSSHRINKSD(%)  2.3196E+00
 EPSSHRINKVR(%)  4.5853E+00

  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         2340
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    4300.6323353978678     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -889.33314761729252     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       3411.2991877805753     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                           120
  
 #TERE:
 Elapsed estimation  time in seconds:   100.67
 Elapsed covariance  time in seconds:     8.54
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     -889.333       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
        -1.62E+00 -2.37E-02  2.29E+00  1.57E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        8.35E-03
 
 ETA2
+        6.94E-04  7.48E-03
 
 ETA3
+        1.00E-03 -1.75E-03  6.87E-03
 
 ETA4
+        7.12E-04  7.01E-04  1.46E-03  6.28E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.23E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        9.14E-02
 
 ETA2
+        8.78E-02  8.65E-02
 
 ETA3
+        1.32E-01 -2.44E-01  8.29E-02
 
 ETA4
+        9.84E-02  1.02E-01  2.22E-01  7.92E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.68E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                          STANDARD ERROR OF ESTIMATE (R)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         1.70E-02  1.65E-02  1.52E-02  1.64E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        2.23E-03
 
 ETA2
+        1.55E-03  2.15E-03
 
 ETA3
+        1.42E-03  1.42E-03  1.78E-03
 
 ETA4
+        1.53E-03  1.50E-03  1.37E-03  1.97E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        9.71E-05
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        1.22E-02
 
 ETA2
+        1.96E-01  1.24E-02
 
 ETA3
+        1.83E-01  1.83E-01  1.08E-02
 
 ETA4
+        2.09E-01  2.13E-01  1.95E-01  1.24E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        8.54E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (R)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        2.88E-04
 
 TH 2
+        1.15E-05  2.73E-04
 
 TH 3
+        3.42E-05 -5.91E-05  2.31E-04
 
 TH 4
+        8.45E-06  3.71E-05  4.54E-05  2.68E-04
 
 OM11
+       -4.90E-07  3.08E-07 -2.22E-08  1.21E-06  4.97E-06
 
 OM12
+        2.28E-07 -9.79E-08  9.01E-09 -3.58E-07  2.13E-07  2.40E-06
 
 OM13
+       -1.26E-07  7.81E-08 -2.80E-08  3.85E-07  5.90E-07 -4.97E-07  2.02E-06
 
 OM14
+        4.45E-07 -1.88E-07  1.42E-07 -2.44E-06  1.57E-07  3.18E-07  4.08E-07  2.33E-06
 
 OM22
+       -7.75E-08  2.10E-07 -2.75E-08  7.03E-08 -3.18E-10  1.36E-07 -4.82E-08  4.12E-08  4.64E-06
 
 OM23
+        7.99E-08 -5.18E-08  2.01E-08 -6.48E-08  1.81E-08  2.59E-07  2.10E-08  4.97E-08 -9.55E-07  2.02E-06
 
 OM24
+        2.64E-07 -1.16E-07  3.72E-08 -9.54E-07 -1.62E-08  9.40E-08 -7.18E-09  1.85E-07  6.17E-07  3.29E-07  2.24E-06
 
 OM33
+        2.50E-09 -1.90E-08  2.08E-08  3.31E-08  6.68E-08 -1.17E-07  4.67E-07  8.70E-08  2.11E-07 -8.02E-07 -1.49E-07  3.18E-06
 
 OM34
+        2.67E-07 -1.34E-07  7.23E-08 -8.50E-07 -1.67E-10  3.05E-08  1.15E-07  2.86E-07 -1.40E-07  1.81E-07 -4.24E-07  6.45E-07
          1.89E-06
 
 OM44
+        1.02E-06 -6.77E-07  1.49E-07 -3.76E-06 -2.34E-08  3.25E-09 -4.32E-09  2.97E-07  7.48E-08  1.22E-07  6.32E-07  1.30E-07
          8.73E-07  3.89E-06
 
 SG11
+       -1.38E-09 -6.45E-09 -8.88E-09 -5.83E-10 -1.26E-10  1.08E-09  7.27E-11  1.28E-09 -1.47E-09 -1.45E-12 -1.60E-09  3.53E-10
         -3.60E-11 -1.80E-09  9.42E-09
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (R)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        1.70E-02
 
 TH 2
+        4.11E-02  1.65E-02
 
 TH 3
+        1.33E-01 -2.35E-01  1.52E-02
 
 TH 4
+        3.04E-02  1.37E-01  1.83E-01  1.64E-02
 
 OM11
+       -1.29E-02  8.36E-03 -6.54E-04  3.31E-02  2.23E-03
 
 OM12
+        8.67E-03 -3.82E-03  3.83E-04 -1.41E-02  6.16E-02  1.55E-03
 
 OM13
+       -5.22E-03  3.32E-03 -1.30E-03  1.65E-02  1.86E-01 -2.26E-01  1.42E-03
 
 OM14
+        1.72E-02 -7.44E-03  6.15E-03 -9.78E-02  4.61E-02  1.35E-01  1.88E-01  1.53E-03
 
 OM22
+       -2.12E-03  5.91E-03 -8.41E-04  1.99E-03 -6.62E-05  4.09E-02 -1.57E-02  1.26E-02  2.15E-03
 
 OM23
+        3.31E-03 -2.20E-03  9.30E-04 -2.78E-03  5.71E-03  1.18E-01  1.04E-02  2.29E-02 -3.12E-01  1.42E-03
 
 OM24
+        1.04E-02 -4.67E-03  1.64E-03 -3.89E-02 -4.87E-03  4.05E-02 -3.37E-03  8.10E-02  1.92E-01  1.55E-01  1.50E-03
 
 OM33
+        8.26E-05 -6.43E-04  7.66E-04  1.13E-03  1.68E-02 -4.23E-02  1.84E-01  3.20E-02  5.48E-02 -3.16E-01 -5.57E-02  1.78E-03
 
 OM34
+        1.14E-02 -5.87E-03  3.46E-03 -3.77E-02 -5.44E-05  1.43E-02  5.88E-02  1.37E-01 -4.74E-02  9.24E-02 -2.06E-01  2.63E-01
          1.37E-03
 
 OM44
+        3.05E-02 -2.08E-02  4.97E-03 -1.16E-01 -5.33E-03  1.06E-03 -1.54E-03  9.89E-02  1.76E-02  4.35E-02  2.14E-01  3.70E-02
          3.22E-01  1.97E-03
 
 SG11
+       -8.36E-04 -4.02E-03 -6.02E-03 -3.67E-04 -5.81E-04  7.17E-03  5.26E-04  8.62E-03 -7.02E-03 -1.05E-05 -1.10E-02  2.04E-03
         -2.70E-04 -9.41E-03  9.71E-05
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (R)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        3.56E+03
 
 TH 2
+       -2.85E+02  4.04E+03
 
 TH 3
+       -6.02E+02  1.23E+03  4.94E+03
 
 TH 4
+        8.96E+00 -7.61E+02 -1.01E+03  4.10E+03
 
 OM11
+        3.69E+02 -9.94E+01  1.08E+02 -8.98E+02  2.11E+05
 
 OM12
+       -2.78E+02  1.99E+02  1.65E+02 -1.34E+02 -3.44E+04  4.71E+05
 
 OM13
+        1.55E+02  1.64E+02  4.18E+02 -1.33E+03 -7.16E+04  1.48E+05  5.98E+05
 
 OM14
+       -5.43E+02 -5.41E+02 -1.15E+03  4.17E+03  1.24E+03 -8.75E+04 -1.21E+05  4.81E+05
 
 OM22
+        1.29E+02 -1.63E+02  2.58E+01 -2.81E+02  8.91E+02 -2.84E+04 -7.64E+03  6.51E+03  2.59E+05
 
 OM23
+        5.49E+01  1.66E+01  5.16E+01 -3.88E+02  5.19E+03 -8.37E+04 -6.75E+04  2.87E+04  1.53E+05  6.97E+05
 
 OM24
+       -1.67E+02 -4.72E+01 -1.15E+02  4.65E+02  2.55E+03  5.70E+03  1.10E+04 -5.20E+04 -1.01E+05 -1.74E+05  5.80E+05
 
 OM33
+        1.77E+01  4.70E+01  1.54E+00 -1.07E+02  5.56E+03 -2.22E+04 -9.71E+04  2.22E+04  2.26E+04  1.98E+05 -5.01E+04  4.07E+05
 
 OM34
+       -5.35E+01 -6.33E+01 -4.14E+01 -1.95E+02  3.14E+03  7.92E+03  1.67E+04 -7.99E+04 -3.18E+04 -1.77E+05  2.24E+05 -1.77E+05
          7.52E+05
 
 OM44
+       -8.75E+02  6.08E+01 -6.75E+02  3.53E+03 -1.34E+03  7.42E+03  7.99E+03 -8.10E+03  1.23E+04  3.39E+04 -1.31E+05  2.57E+04
         -1.87E+05  3.23E+05
 
 SG11
+       -3.09E+02  3.86E+03  5.34E+03 -1.05E+03  7.29E+03 -4.46E+04  1.38E+02 -6.60E+04  2.69E+04 -8.23E+02  6.67E+04 -1.56E+04
          1.66E+04  3.93E+04  1.06E+08
 
 Elapsed postprocess time in seconds:     0.00
 Elapsed finaloutput time in seconds:     0.01
 #CPUT: Total CPU Time in Seconds,      160.234
Stop Time: 
Tue 01/11/2022 
06:14 PM
