Tue 04/23/2019 
12:12 PM
;Model Desc: Receptor Mediated Clearance model with Dynamic Change 
;            in Receptors
;Project Name: nm7examples
;Project ID: NO PROJECT DESCRIPTION

$PROB RUN# example6 (from r2compl)
$INPUT C SET ID JID TIME DV=CONC DOSE=AMT RATE EVID MDV CMT TSTRAT TMIN TMAX DSTRAT DMIN DMAX
$DATA optex6d17.csv IGNORE=C

; The new numerical integration solver is used, although ADVAN=9 
; is also efficient for this problem.

$SUBROUTINES ADVAN13 TRANS1 TOL=12 ATOL=12
$MODEL NCOMPARTMENTS=3

$PK
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
ETYPE=1
IF(CMT.NE.1) ETYPE=0
IPRED=F
Y = F + ETYPE*( F*EPS(1)+EPS(2) ) + F*(1.0-ETYPE)*EPS(3)


$THETA 
3.90834E+00 
-2.18787E+00  
5.57985E-01 
-1.86377E-01  
2.26146E+00  
2.10476E-01  
3.70795E+00 
-7.08909E-01 

$OMEGA (0.0625 FIXED)X8
$SIGMA  (9.27944E-03 FIXED) (0.0001 FIXED) (2.24692E-02 FIXED)

$DESIGN MODE=0 FIMDIAG=1 OFVTYPE=8 NELDER DESEL=TIME DESELSTRAT=TSTRAT DESELMIN=TMIN DESELMAX=TMAX
           MAXEVAL=1000 SIGL=10 nohabort PRINT=100 FORMAT=QCSV 
$COV PRINT=E
$TABLE ID DOSE CMT TIME EVID MDV DV TSTRAT NOPRINT NOAPPEND FILE=optex6d17_8.tab 
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
  
License Registered to: IDS NONMEM 7 TEAM
Expiration Date:     2 JUN 2030
Current Date:       23 APR 2019
Days until program expires :4054
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.0 alpha version 7
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 RUN# example6 (from r2compl)
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:       11
 NO. OF DATA ITEMS IN DATA SET:  17
 ID DATA ITEM IS DATA ITEM NO.:   3
 DEP VARIABLE IS DATA ITEM NO.:   6
 MDV DATA ITEM IS DATA ITEM NO.: 10
0INDICES PASSED TO SUBROUTINE PRED:
   9   5   7   8   0   0  11   0   0   0   0
0LABELS FOR DATA ITEMS:
 C SET ID JID TIME CONC DOSE RATE EVID MDV CMT TSTRAT TMIN TMAX DSTRAT DMIN DMAX
0FORMAT FOR DATA:
 (4E2.0,E9.0,E2.0,E5.0,4E2.0,E3.0,E5.0,E3.0,E2.0,2E4.0)

 TOT. NO. OF OBS RECS:        9
 TOT. NO. OF INDIVIDUALS:        1
0LENGTH OF THETA:   8
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   8
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   3
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.3908E+01 -0.2188E+01  0.5580E+00 -0.1864E+00  0.2261E+01  0.2105E+00  0.3708E+01 -0.7089E+00
0INITIAL ESTIMATE OF OMEGA:
 0.6250E-01
 0.0000E+00   0.6250E-01
 0.0000E+00   0.0000E+00   0.6250E-01
 0.0000E+00   0.0000E+00   0.0000E+00   0.6250E-01
 0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.6250E-01
 0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.6250E-01
 0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.6250E-01
 0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.6250E-01
0OMEGA CONSTRAINED TO BE THIS INITIAL ESTIMATE
0INITIAL ESTIMATE OF SIGMA:
 0.9279E-02
 0.0000E+00   0.1000E-03
 0.0000E+00   0.0000E+00   0.2247E-01
0SIGMA CONSTRAINED TO BE THIS INITIAL ESTIMATE
0COVARIANCE STEP OMITTED:        NO
 R MATRIX SUBSTITUTED:          YES
 S MATRIX SUBSTITUTED:           NO
 EIGENVLS. PRINTED:             YES
 COMPRESSED FORMAT:              NO
 GRADIENT METHOD USED:     NOSLOW
 SIGDIGITS ETAHAT (SIGLO):                  -1
 SIGDIGITS GRADIENTS (SIGL):                -1
 EXCLUDE COV FOR FOCE (NOFCOV):              NO
 TURN OFF Cholesky Transposition of R Matrix (CHOLROFF): NO
 KNUTHSUMOFF:                                -1
 RESUME COV ANALYSIS (RESUME):               NO
 SIR SAMPLE SIZE (SIRSAMPLE):              -1
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
 RANMETHOD:             3U
 MC SAMPLES (ESAMPLE):    300
 WRES SQUARE ROOT TYPE (WRESCHOL): EIGENVALUE
0-- TABLE   1 --
0RECORDS ONLY:    ALL
04 COLUMNS APPENDED:    NO
 PRINTED:                NO
 HEADER:                YES
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID DOSE CMT TIME EVID MDV CONC TSTRAT
0WARNING: THE NUMBER OF PARAMETERS TO BE ESTIMATED
 EXCEEDS THE NUMBER OF INDIVIDUALS WITH DATA.
1DOUBLE PRECISION PREDPP VERSION 7.5.0 alpha version 7

 GENERAL NONLINEAR KINETICS MODEL WITH STIFF/NONSTIFF EQUATIONS (LSODA, ADVAN13)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:   7
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         COMP 1       ON         YES        YES        YES        YES
    2         COMP 2       ON         YES        YES        NO         NO
    3         COMP 3       ON         YES        YES        NO         NO
    4         OUTPUT       OFF        YES        NO         NO         NO
 INITIAL (BASE) TOLERANCE SETTINGS:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  12
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            9           *           *           *           *
    2            *           *           *           *           *
    3            8          10           *           *           *
    4            *           -           -           -           -
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
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
0DES SUBROUTINE USES COMPACT STORAGE MODE.
1
 
 
 #TBLN:      1
 #METH: First Order: BAYESIAN-OPTIMALITY
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 EPS-ETA INTERACTION:                     NO
 NO. OF FUNCT. EVALS. ALLOWED:            1000
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      10
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     10
 NOPRIOR SETTING (NOPRIOR):                 OFF
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          ON
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      OFF
 RAW OUTPUT FILE (FILE): optex6d17_8.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      ,CSV
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 WISHART PRIOR DF INTERPRETATION (WISHTYPE):0
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 ADDITIONAL CONVERGENCE TEST (CTYPE=4)?:    NO
 EM OR BAYESIAN METHOD USED:                 NONE

 DESIGN TYPE: B-OPTIMALITY, -LOG(DET(BAYES FIM))
 SIMULATE OBSERVED DATA FOR DESIGN:  NO
 BLOCK DIAGONALIZATION TYPE FOR DESIGN:  1
 STANDARD NONMEM RESIDUAL VARIANCE MODELING (VAR_CROSS=0)
 DESIGN GROUPSIZE=  1.0000000000000000E+00
 OPTIMALITY RANDOM GENERATION SEED: -1
 DESIGN OPTIMIZATION: NELDER
 OPTIMAL DESIGN ELEMENT, STRAT, MIN, MAX COLUMNS: TIME,TSTRAT,TMIN,TMAX
 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  12
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  12
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
 TOLERANCES FOR TABLE/SCATTER STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  12
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=NPRED
 RES=NRES
 WRES=NWRES
 IWRS=NIWRES
 IPRD=NIPRED
 IRS=NIRES
 
 MONITORING OF SEARCH:

 ITERATION NO.:          0    OBJECTIVE VALUE:  -37.2482433180567        NO. OF FUNC. EVALS.:           1
 ITERATION NO.:        100    OBJECTIVE VALUE:  -39.6415307323049        NO. OF FUNC. EVALS.:         396
 ITERATION NO.:        200    OBJECTIVE VALUE:  -39.6475318897389        NO. OF FUNC. EVALS.:         663
 ITERATION NO.:        300    OBJECTIVE VALUE:  -39.6539802622191        NO. OF FUNC. EVALS.:         956
 ITERATION NO.:        400    OBJECTIVE VALUE:  -39.6602626196011        NO. OF FUNC. EVALS.:        1264
 ITERATION NO.:        500    OBJECTIVE VALUE:  -39.6658682673094        NO. OF FUNC. EVALS.:        1563
 ITERATION NO.:        600    OBJECTIVE VALUE:  -39.6711297467532        NO. OF FUNC. EVALS.:        1891
 ITERATION NO.:        700    OBJECTIVE VALUE:  -39.6748085402088        NO. OF FUNC. EVALS.:        2198
 ITERATION NO.:        800    OBJECTIVE VALUE:  -39.6776540455096        NO. OF FUNC. EVALS.:        2521
 ITERATION NO.:        900    OBJECTIVE VALUE:  -39.6795101512724        NO. OF FUNC. EVALS.:        2850
 ITERATION NO.:       1000    OBJECTIVE VALUE:  -39.6809253894553        NO. OF FUNC. EVALS.:        3185
 ITERATION NO.:       1000    OBJECTIVE VALUE:  -39.6809253894553        NO. OF FUNC. EVALS.:        3185
 
 #TERM:
 NO. OF FUNCTION EVALUATIONS USED:     3185
0MINIMIZATION TERMINATED
  DUE TO MAXIMUM NUMBER OF ITERATIONS EXCEEDED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 SE:             0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 N:                       1           1           1           1           1           1           1           1
 
 P VAL.:         1.0000E+00  1.0000E+00  1.0000E+00  1.0000E+00  1.0000E+00  1.0000E+00  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 ETASHRINKVR(%)  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 EBVSHRINKSD(%)  4.4190E+00  5.7628E+01  2.1200E+01  2.3886E+01  3.8608E+00  3.4582E+01  5.2362E+00  1.8031E+01
 EBVSHRINKVR(%)  8.6427E+00  8.2046E+01  3.7906E+01  4.2067E+01  7.5726E+00  5.7205E+01  1.0198E+01  3.2812E+01
 EPSSHRINKSD(%)  6.6667E+01  6.6667E+01  6.6667E+01
 EPSSHRINKVR(%)  8.8889E+01  8.8889E+01  8.8889E+01
 
 #TERE:
 Elapsed opt. design time in seconds:    13.09
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                         FIRST ORDER: BAYESIAN-OPTIMALITY                       ********************
 #OBJT:**************             MINIMUM VALUE OF OBJECTIVE FUNCTION: BAYESIAN-OPTIMALITY           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************      -39.681       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                         FIRST ORDER: BAYESIAN-OPTIMALITY                       ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8     
 
         3.91E+00 -2.19E+00  5.58E-01 -1.86E-01  2.26E+00  2.10E-01  3.71E+00 -7.09E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        6.25E-02
 
 ETA2
+        0.00E+00  6.25E-02
 
 ETA3
+        0.00E+00  0.00E+00  6.25E-02
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  6.25E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.25E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.25E-02
 
 ETA7
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.25E-02
 
 ETA8
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.25E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2      EPS3     
 
 EPS1
+        9.28E-03
 
 EPS2
+        0.00E+00  1.00E-04
 
 EPS3
+        0.00E+00  0.00E+00  2.25E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        2.50E-01
 
 ETA2
+        0.00E+00  2.50E-01
 
 ETA3
+        0.00E+00  0.00E+00  2.50E-01
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  2.50E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.50E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.50E-01
 
 ETA7
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.50E-01
 
 ETA8
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.50E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2      EPS3     
 
 EPS1
+        9.63E-02
 
 EPS2
+        0.00E+00  1.00E-02
 
 EPS3
+        0.00E+00  0.00E+00  1.50E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                         FIRST ORDER: BAYESIAN-OPTIMALITY                       ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8     
 
         2.69E-01  6.83E+00  4.02E-01  9.58E-01  4.60E-01  2.15E+00  2.40E+00  2.50E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+       .........
 
 ETA2
+       ......... .........
 
 ETA3
+       ......... ......... .........
 
 ETA4
+       ......... ......... ......... .........
 
 ETA5
+       ......... ......... ......... ......... .........
 
 ETA6
+       ......... ......... ......... ......... ......... .........
 
 ETA7
+       ......... ......... ......... ......... ......... ......... .........
 
 ETA8
+       ......... ......... ......... ......... ......... ......... ......... .........
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2      EPS3     
 
 EPS1
+       .........
 
 EPS2
+       ......... .........
 
 EPS3
+       ......... ......... .........
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+       .........
 
 ETA2
+       ......... .........
 
 ETA3
+       ......... ......... .........
 
 ETA4
+       ......... ......... ......... .........
 
 ETA5
+       ......... ......... ......... ......... .........
 
 ETA6
+       ......... ......... ......... ......... ......... .........
 
 ETA7
+       ......... ......... ......... ......... ......... ......... .........
 
 ETA8
+       ......... ......... ......... ......... ......... ......... ......... .........
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2      EPS3     
 
 EPS1
+       .........
 
 EPS2
+       ......... .........
 
 EPS3
+       ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                         FIRST ORDER: BAYESIAN-OPTIMALITY                       ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     7.22E-02        -4.43E-02         4.67E+01        -1.31E-02        -1.30E+00         1.62E-01        -3.79E-03

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
     6.07E+00        -1.26E-01         9.18E-01         1.06E-03        -2.58E+00         7.50E-02        -3.35E-01

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     2.12E-01         2.31E-03         1.44E+01        -4.18E-01         1.90E+00        -7.88E-01         4.61E+00

     TH 7 | TH 1      TH 7 | TH 2      TH 7 | TH 3      TH 7 | TH 4      TH 7 | TH 5      TH 7 | TH 6      TH 7 | TH 7  
     1.19E-02        -1.63E+01         4.59E-01        -2.12E+00         9.03E-01        -5.03E+00         5.74E+00

     TH 8 | TH 1      TH 8 | TH 2      TH 8 | TH 3      TH 8 | TH 4      TH 8 | TH 5      TH 8 | TH 6      TH 8 | TH 7  
     2.42E-03        -1.69E+01         4.95E-01        -2.20E+00         9.36E-01        -5.25E+00         5.91E+00

     TH 8 | TH 8    
     6.23E+00
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                         FIRST ORDER: BAYESIAN-OPTIMALITY                       ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     2.69E-01        -2.41E-02         6.83E+00        -1.21E-01        -4.72E-01         4.02E-01        -1.47E-02

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
     9.27E-01        -3.27E-01         9.58E-01         8.60E-03        -8.22E-01         4.05E-01        -7.59E-01

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     4.60E-01         4.00E-03         9.82E-01        -4.84E-01         9.22E-01        -7.97E-01         2.15E+00

     TH 7 | TH 1      TH 7 | TH 2      TH 7 | TH 3      TH 7 | TH 4      TH 7 | TH 5      TH 7 | TH 6      TH 7 | TH 7  
     1.85E-02        -9.94E-01         4.77E-01        -9.23E-01         8.18E-01        -9.77E-01         2.40E+00

     TH 8 | TH 1      TH 8 | TH 2      TH 8 | TH 3      TH 8 | TH 4      TH 8 | TH 5      TH 8 | TH 6      TH 8 | TH 7  
     3.61E-03        -9.91E-01         4.93E-01        -9.21E-01         8.15E-01        -9.79E-01         9.88E-01

     TH 8 | TH 8    
     2.50E+00
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                         FIRST ORDER: BAYESIAN-OPTIMALITY                       ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     1.46E+01         8.99E-01         2.86E+00         1.44E+00        -4.97E-01         9.89E+00        -4.74E-01

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
    -4.25E-01        -3.54E+00         9.21E+00         3.72E-01         9.39E-01        -5.16E-01         1.92E-01

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     1.47E+01        -9.41E-01        -1.19E+00         1.04E+00        -1.51E+00        -9.72E-01         6.72E+00

     TH 7 | TH 1      TH 7 | TH 2      TH 7 | TH 3      TH 7 | TH 4      TH 7 | TH 5      TH 7 | TH 6      TH 7 | TH 7  
     1.29E-01         4.11E+00        -5.82E-01         4.73E-01        -3.96E-01         4.00E-01         1.44E+01

     TH 8 | TH 1      TH 8 | TH 2      TH 8 | TH 3      TH 8 | TH 4      TH 8 | TH 5      TH 8 | TH 6      TH 8 | TH 7  
     1.18E+00         2.59E+00        -1.88E+00         6.34E-01        -1.19E-03         1.58E+00        -1.85E+00

     TH 8 | TH 8    
     1.07E+01
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                         FIRST ORDER: BAYESIAN-OPTIMALITY                       ********************
 ********************                      EIGENVALUES OF COR MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

             1         2         3         4         5         6         7         8
 
         5.30E-03  1.21E-02  2.55E-02  9.05E-02  2.94E-01  7.20E-01  1.06E+00  5.80E+00
 
 Elapsed finaloutput time in seconds:     0.11
 #CPUT: Total CPU Time in Seconds,       11.981
Stop Time: 
Tue 04/23/2019 
12:12 PM
