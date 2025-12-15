Thu 09/23/2021 
12:16 PM
; Control problem for sde system.  No SDE matters done.  From Christoffer Tornoe, Examle 2
$PROBLEM PK ODE HANDS ON ONE

$INPUT ID TIME DV AMT CMT FLAG

$DATA   sde_ex2_base.dat
        IGNORE=@

$SUBROUTINE ADVAN6 TOL 10 DP

$MODEL 
       COMP = (CENTRAL);

$PK
  IF(NEWIND.NE.2) OT = 0
   
  TVCL  = THETA(1)
  CL    = TVCL*EXP(ETA(1))
  
  TVVD  = THETA(2)
  VD    = TVVD*EXP(ETA(2))


$DES
 DADT(1) = - CL/VD*A(1) ;+SGW1
 
$ERROR 
  
     IPRED = A(1)/VD
     IRES  = DV - IPRED
     W     = THETA(3)
     IWRES = IRES/W
     Y     = IPRED+W*EPS(1)

$THETA (0,10)               ;1 CL
$THETA (0,32)               ;2 VD
$THETA (0, 2)               ;4 SIGMA

$OMEGA 0.1                  ;1 CL
$OMEGA 0.01                 ;2 VD

$SIGMA 1 FIX                ; PK

$EST MAXEVAL=9999 METHOD=1 LAPLACE NUMERICAL SLOW INTER NOABORT SIGDIGITS=3 PRINT=1 
$COV MATRIX=R

$TABLE ID TIME FLAG AMT CMT IPRED IRES IWRES
       ONEHEADER NOPRINT FILE=sde_ex2_base.tab
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
  
Note: Analytical 2nd Derivatives are constructed in FSUBS but are never used.
      You may insert $ABBR DERIV2=NO after the first $PROB to save FSUBS construction and compilation time
  
  
License Registered to: NONMEM license (with RADAR5NM) for ICON Pharmacometrics Team
Expiration Date:    31 DEC 2030
Current Date:       23 SEP 2021
Days until program expires :3383
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.1
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 PK ODE HANDS ON ONE
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:      570
 NO. OF DATA ITEMS IN DATA SET:   8
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   3
 MDV DATA ITEM IS DATA ITEM NO.:  8
0INDICES PASSED TO SUBROUTINE PRED:
   7   2   4   0   0   0   5   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID TIME DV AMT CMT FLAG EVID MDV
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 IPRED IRES IWRES
0FORMAT FOR DATA:
 (6E10.0,2F2.0)

 TOT. NO. OF OBS RECS:      540
 TOT. NO. OF INDIVIDUALS:       30
0LENGTH OF THETA:   3
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   2
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
  0.0000E+00     0.1000E+02     0.1000E+07
  0.0000E+00     0.3200E+02     0.1000E+07
  0.0000E+00     0.2000E+01     0.1000E+07
0INITIAL ESTIMATE OF OMEGA:
 0.1000E+00
 0.0000E+00   0.1000E-01
0INITIAL ESTIMATE OF SIGMA:
 0.1000E+01
0SIGMA CONSTRAINED TO BE THIS INITIAL ESTIMATE
0COVARIANCE STEP OMITTED:        NO
 R MATRIX SUBSTITUTED:          YES
 S MATRIX SUBSTITUTED:           NO
 EIGENVLS. PRINTED:              NO
 COMPRESSED FORMAT:              NO
 GRADIENT METHOD USED:       SLOW
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
 HEADER:                YES
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID TIME FLAG AMT CMT IPRED IRES IWRES
1DOUBLE PRECISION PREDPP VERSION 7.5.1

 GENERAL NONLINEAR KINETICS MODEL (DVERK1, ADVAN6)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:   2
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         CENTRAL      ON         YES        YES        YES        YES
    2         OUTPUT       OFF        YES        NO         NO         NO
 INITIAL (BASE) TOLERANCE SETTINGS:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
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
   EVENT ID DATA ITEM IS DATA ITEM NO.:      7
   TIME DATA ITEM IS DATA ITEM NO.:          2
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   4
   COMPT. NO. DATA ITEM IS DATA ITEM NO.:    5

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
0ERROR SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
0DES SUBROUTINE USES COMPACT STORAGE MODE.
1
 
 
 #TBLN:      1
 #METH: Laplacian Conditional Estimation with Interaction
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               SLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    YES
 NUMERICAL 2ND DERIVATIVES:               YES
 NO. OF FUNCT. EVALS. ALLOWED:            9999
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      100
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     100
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): sde_ex2_base.ext
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

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 TOLERANCES FOR TABLE/SCATTER STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 MONITORING OF SEARCH:

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   1535.20801663601        NO. OF FUNC. EVALS.:   6
 CUMULATIVE NO. OF FUNC. EVALS.:        6
 NPARAMETR:  1.0000E+01  3.2000E+01  2.0000E+00  1.0000E-01  1.0000E-02
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:  -4.6990E+01 -1.4468E+00  7.6321E+01 -1.7769E+00 -2.9106E+02
 
0ITERATION NO.:    1    OBJECTIVE VALUE:   1399.88360097711        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       13
 NPARAMETR:  1.1017E+01  3.2096E+01  1.7088E+00  1.0074E-01  3.3201E-02
 PARAMETER:  1.9687E-01  1.0298E-01 -5.7329E-02  1.0366E-01  7.0000E-01
 GRADIENT:   1.6878E+01 -8.6039E+00 -6.5270E+01 -7.9123E-01 -1.2884E+02
 
0ITERATION NO.:    2    OBJECTIVE VALUE:   1398.51776875152        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       20
 NPARAMETR:  1.0430E+01  3.2690E+01  2.0295E+00  1.0095E-01  4.6945E-02
 PARAMETER:  1.4213E-01  1.2132E-01  1.1466E-01  1.0473E-01  8.7320E-01
 GRADIENT:  -1.4692E+01  1.3735E+01  2.3535E+02  2.6051E-01 -7.5911E+01
 
0ITERATION NO.:    3    OBJECTIVE VALUE:   1397.05261164228        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       28
 NPARAMETR:  9.7322E+00  3.2775E+01  2.0075E+00  1.0084E-01  4.8735E-02
 PARAMETER:  7.2850E-02  1.2394E-01  1.0372E-01  1.0417E-01  8.9191E-01
 GRADIENT:  -5.4089E+01  1.5494E+01  2.2086E+02 -4.5567E+00 -7.2925E+01
 
0ITERATION NO.:    4    OBJECTIVE VALUE:   1396.07704049794        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       35
 NPARAMETR:  9.5661E+00  3.1633E+01  1.9952E+00  1.3783E-01  5.0339E-02
 PARAMETER:  5.5642E-02  8.8464E-02  9.7611E-02  2.6044E-01  9.0810E-01
 GRADIENT:  -4.7242E+01 -2.4011E+01  2.1332E+02  1.0033E+01 -6.9892E+01
 
0ITERATION NO.:    5    OBJECTIVE VALUE:   1395.99090063809        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       42
 NPARAMETR:  9.4599E+00  3.3765E+01  1.9670E+00  1.9297E-01  5.2055E-02
 PARAMETER:  4.4473E-02  1.5368E-01  8.3356E-02  4.2869E-01  9.2486E-01
 GRADIENT:  -3.7032E+01  4.5030E+01  1.9312E+02  2.2660E+01 -6.9040E+01
 
0ITERATION NO.:    6    OBJECTIVE VALUE:   1366.38204823455        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       51
 NPARAMETR:  1.0285E+01  3.2663E+01  1.7785E+00  1.1264E-01  8.2975E-02
 PARAMETER:  1.2810E-01  1.2050E-01 -1.7354E-02  1.5951E-01  1.1580E+00
 GRADIENT:  -1.8606E+01  5.7157E+00  2.8508E+01  4.4070E+00 -2.6699E+01
 
0ITERATION NO.:    7    OBJECTIVE VALUE:   1363.71811153574        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       58
 NPARAMETR:  1.0835E+01  3.2518E+01  1.7403E+00  9.2393E-02  1.0765E-01
 PARAMETER:  1.8016E-01  1.1605E-01 -3.9062E-02  6.0438E-02  1.2881E+00
 GRADIENT:   1.0450E+01  1.9513E+00 -1.2288E+01 -6.2084E+00 -8.4117E+00
 
0ITERATION NO.:    8    OBJECTIVE VALUE:   1363.21968483074        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       65
 NPARAMETR:  1.0624E+01  3.2509E+01  1.7387E+00  1.0536E-01  1.1887E-01
 PARAMETER:  1.6052E-01  1.1578E-01 -3.9981E-02  1.2611E-01  1.3377E+00
 GRADIENT:  -1.4396E+00  1.3961E+00 -1.3238E+01  1.3404E+00 -2.5377E+00
 
0ITERATION NO.:    9    OBJECTIVE VALUE:   1363.13725196195        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       72
 NPARAMETR:  1.0647E+01  3.2457E+01  1.7497E+00  1.0366E-01  1.2256E-01
 PARAMETER:  1.6266E-01  1.1418E-01 -3.3726E-02  1.1797E-01  1.3530E+00
 GRADIENT:  -2.7199E-01  5.5845E-01 -1.1249E+00  4.8722E-01 -7.4665E-01
 
0ITERATION NO.:   10    OBJECTIVE VALUE:   1363.13253393913        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       79
 NPARAMETR:  1.0654E+01  3.2433E+01  1.7508E+00  1.0283E-01  1.2411E-01
 PARAMETER:  1.6332E-01  1.1345E-01 -3.3084E-02  1.1395E-01  1.3593E+00
 GRADIENT:   1.0302E-01  2.1451E-01  1.1016E-01  5.1143E-02 -3.1480E-02
 
0ITERATION NO.:   11    OBJECTIVE VALUE:   1363.13246130197        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       86
 NPARAMETR:  1.0651E+01  3.2419E+01  1.7506E+00  1.0265E-01  1.2428E-01
 PARAMETER:  1.6307E-01  1.1302E-01 -3.3160E-02  1.1307E-01  1.3600E+00
 GRADIENT:  -3.6287E-02  7.7064E-03 -2.8748E-02 -4.0976E-02  4.5825E-02
 
0ITERATION NO.:   12    OBJECTIVE VALUE:   1363.13245846278        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       93
 NPARAMETR:  1.0651E+01  3.2420E+01  1.7507E+00  1.0268E-01  1.2424E-01
 PARAMETER:  1.6309E-01  1.1304E-01 -3.3153E-02  1.1323E-01  1.3598E+00
 GRADIENT:  -2.9111E-02  1.7368E-02 -2.3626E-02 -3.5973E-02  2.6338E-02
 
0ITERATION NO.:   13    OBJECTIVE VALUE:   1363.13245632835        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:      100
 NPARAMETR:  1.0651E+01  3.2420E+01  1.7507E+00  1.0270E-01  1.2422E-01
 PARAMETER:  1.6311E-01  1.1305E-01 -3.3148E-02  1.1334E-01  1.3597E+00
 GRADIENT:  -1.7733E-02  2.5987E-02 -1.2017E-02 -1.2655E-02  1.9807E-02
 
0ITERATION NO.:   14    OBJECTIVE VALUE:   1363.13245632835        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:      110
 NPARAMETR:  1.0651E+01  3.2420E+01  1.7507E+00  1.0270E-01  1.2422E-01
 PARAMETER:  1.6311E-01  1.1305E-01 -3.3148E-02  1.1334E-01  1.3597E+00
 GRADIENT:  -6.2900E-02 -2.7612E-04 -1.0495E-01 -2.3332E-02 -5.6172E-02
 
0ITERATION NO.:   15    OBJECTIVE VALUE:   1363.13243545995        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:      117            RESET HESSIAN, TYPE II
 NPARAMETR:  1.0653E+01  3.2420E+01  1.7508E+00  1.0273E-01  1.2435E-01
 PARAMETER:  1.6322E-01  1.1305E-01 -3.3091E-02  1.1346E-01  1.3603E+00
 GRADIENT:   4.1170E-02  1.2059E-02  8.3068E-02 -2.1157E-02  7.5087E-02
 
0ITERATION NO.:   16    OBJECTIVE VALUE:   1363.13243545995        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:      127
 NPARAMETR:  1.0653E+01  3.2420E+01  1.7508E+00  1.0273E-01  1.2435E-01
 PARAMETER:  1.6322E-01  1.1305E-01 -3.3091E-02  1.1346E-01  1.3603E+00
 GRADIENT:   2.5271E-03 -9.7811E-04  4.8558E-03 -1.2785E-02  6.7813E-05
 
0ITERATION NO.:   17    OBJECTIVE VALUE:   1363.13243339164        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:      137            RESET HESSIAN, TYPE II
 NPARAMETR:  1.0653E+01  3.2420E+01  1.7508E+00  1.0275E-01  1.2435E-01
 PARAMETER:  1.6322E-01  1.1305E-01 -3.3091E-02  1.1359E-01  1.3603E+00
 GRADIENT:   4.9464E-02  2.9334E-02  1.1282E-01  1.5625E-02  7.6035E-02
 
0ITERATION NO.:   18    OBJECTIVE VALUE:   1363.13243339164        NO. OF FUNC. EVALS.:  12
 CUMULATIVE NO. OF FUNC. EVALS.:      149
 NPARAMETR:  1.0653E+01  3.2420E+01  1.7508E+00  1.0275E-01  1.2435E-01
 PARAMETER:  1.6322E-01  1.1305E-01 -3.3091E-02  1.1359E-01  1.3603E+00
 GRADIENT:  -4.8981E-04 -5.9497E-04  6.3211E-03  5.6951E-03  1.1030E-04
 
0ITERATION NO.:   19    OBJECTIVE VALUE:   1363.13243339164        NO. OF FUNC. EVALS.:   3
 CUMULATIVE NO. OF FUNC. EVALS.:      152
 NPARAMETR:  1.0653E+01  3.2421E+01  1.7508E+00  1.0273E-01  1.2436E-01
 PARAMETER:  1.6322E-01  1.1305E-01 -3.3091E-02  1.1359E-01  1.3603E+00
 GRADIENT:  -4.8981E-04 -5.9497E-04  6.3211E-03  5.6951E-03  1.1030E-04
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 HOWEVER, PROBLEMS OCCURRED WITH THE MINIMIZATION.
 REGARD THE RESULTS OF THE ESTIMATION STEP CAREFULLY, AND ACCEPT THEM ONLY
 AFTER CHECKING THAT THE COVARIANCE STEP PRODUCES REASONABLE OUTPUT.
 NO. OF FUNCTION EVALUATIONS USED:      152
 NO. OF SIG. DIGITS IN FINAL EST.:  3.5

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -3.2829E-04 -3.4874E-03
 SE:             5.7273E-02  6.3135E-02
 N:                      30          30
 
 P VAL.:         9.9543E-01  9.5595E-01
 
 ETASHRINKSD(%)  2.1394E+00  1.9365E+00
 ETASHRINKVR(%)  4.2330E+00  3.8355E+00
 EBVSHRINKSD(%)  1.5684E+00  1.5059E+00
 EBVSHRINKVR(%)  3.1123E+00  2.9891E+00
 RELATIVEINF(%)  9.6886E+01  9.7009E+01
 EPSSHRINKSD(%)  5.4826E+00
 EPSSHRINKVR(%)  1.0665E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          540
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    992.453615861047     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    1363.13243339164     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       2355.58604925269     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            60
  
 #TERE:
 Elapsed estimation  time in seconds:     6.05
 Elapsed covariance  time in seconds:     1.88
 Elapsed postprocess time in seconds:     0.04
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     1363.132       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         1.07E+01  3.24E+01  1.75E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        1.03E-01
 
 ETA2
+        0.00E+00  1.24E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        3.21E-01
 
 ETA2
+        0.00E+00  3.53E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         6.26E-01  2.10E+00  5.61E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        2.64E-02
 
 ETA2
+       .........  3.33E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+       .........
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        4.11E-02
 
 ETA2
+       .........  4.73E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+       .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM22      SG11  
 
 TH 1
+        3.91E-01
 
 TH 2
+        2.29E-02  4.42E+00
 
 TH 3
+        1.96E-04 -1.66E-03  3.14E-03
 
 OM11
+        3.07E-04  2.35E-03  2.54E-05  6.95E-04
 
 OM12
+       ......... ......... ......... ......... .........
 
 OM22
+       -1.61E-04  4.86E-04 -3.10E-05 -1.44E-05 .........  1.11E-03
 
 SG11
+       ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM22      SG11  
 
 TH 1
+        6.26E-01
 
 TH 2
+        1.74E-02  2.10E+00
 
 TH 3
+        5.59E-03 -1.41E-02  5.61E-02
 
 OM11
+        1.86E-02  4.24E-02  1.72E-02  2.64E-02
 
 OM12
+       ......... ......... ......... ......... .........
 
 OM22
+       -7.73E-03  6.93E-03 -1.66E-02 -1.64E-02 .........  3.33E-02
 
 SG11
+       ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM22      SG11  
 
 TH 1
+        2.56E+00
 
 TH 2
+       -1.28E-02  2.27E-01
 
 TH 3
+       -1.54E-01  1.26E-01  3.18E+02
 
 OM11
+       -1.07E+00 -7.68E-01 -1.18E+01  1.44E+03
 
 OM12
+       ......... ......... ......... ......... .........
 
 OM22
+        3.58E-01 -1.07E-01  8.64E+00  1.85E+01 .........  9.00E+02
 
 SG11
+       ......... ......... ......... ......... ......... ......... .........
 
 Elapsed finaloutput time in seconds:     0.06
 #CPUT: Total CPU Time in Seconds,        8.000
Stop Time: 
Thu 09/23/2021 
12:16 PM
