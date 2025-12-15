Tue 12/17/2019 
12:43 AM
$PROB RUN# 
$INPUT C ID TIME DV AMT RATE EVID MDV CMT ROWNUM SID
$DATA superid3.csv IGNORE=C

$SUBROUTINES ADVAN2 TRANS2

$PK
MU_1=THETA(1)
MU_2=THETA(2)
MU_3=THETA(3)
KA=DEXP(MU_1+ETA(1)+ETA(4))
CL=DEXP(MU_2+ETA(2)+ETA(5))
V=DEXP(MU_3+ETA(3)+ETA(6))
S2=V

$ERROR
IPRE=F
Y = IPRE + IPRE*EPS(1)

; Initial values of THETA
$THETA 0.2 -4 -2
;INITIAL values of OMEGA
$OMEGA BLOCK(3)
0.1
0.001 0.1
0.001 0.001 0.1

$OMEGA BLOCK(3)
0.3
0.001 0.3
0.001 0.001 0.3

;Initial value of SIGMA
$SIGMA 
0.1     ;[P]

$PRIOR NWPRI 
$OMEGAP BLOCK(3)
0.01
0.001 0.01
0.001 0.001 0.01

$OMEGAP BLOCK(3)
0.03
0.001 0.03
0.001 0.001 0.03

$OMEGAPD (3 FIXED)X2

$LEVEL
SID=(4[1],5[2],6[3])

$EST METHOD=ITS AUTO=1 PRINT=1 SIGL=8 FNLETA=0 NOPRIOR=1 MCETA=10
     LEVCENTER=1
$EST METHOD=IMP AUTO=1 PRINT=1 NOPRIOR=1
$EST METHOD=BAYES AUTO=1 PRINT=25 NITER=500 NOPRIOR=0 MCETA=0
$EST METHOD=1 PRINT=5 NSIG=3 SIGL=10 FNLETA=0 SLOW NONINFETA=1 NOPRIOR=1 MCETA=10 NOHABORT
$COV MATRIX=R UNCONDITIONAL
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  126) ONLY THE LAST FNLETA LISTED IN THE SERIES OF $EST RECORDS FOR
 THIS PROBLEM WILL BE USED
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  121) INTERACTION IS IMPLIED WITH EM/BAYES ESTIMATION METHODS

 (MU_WARNING 12) MU_001: SHOULD NOT BE ASSOCIATED WITH ETA(004)

 (MU_WARNING 11) MU_001: SHOULD NOT BE ASSOCIATED WITH MORE THAN ONE ETA.

 (MU_WARNING 12) MU_002: SHOULD NOT BE ASSOCIATED WITH ETA(005)

 (MU_WARNING 11) MU_002: SHOULD NOT BE ASSOCIATED WITH MORE THAN ONE ETA.

 (MU_WARNING 12) MU_003: SHOULD NOT BE ASSOCIATED WITH ETA(006)

 (MU_WARNING 11) MU_003: SHOULD NOT BE ASSOCIATED WITH MORE THAN ONE ETA.
  
License Registered to: IDS NONMEM 7 TEAM
Expiration Date:     2 JUN 2030
Current Date:       17 DEC 2019
Days until program expires :3820
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.0 Beta version 3
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 RUN#
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:     8800
 NO. OF DATA ITEMS IN DATA SET:  11
 ID DATA ITEM IS DATA ITEM NO.:   2
 DEP VARIABLE IS DATA ITEM NO.:   4
 MDV DATA ITEM IS DATA ITEM NO.:  8
0INDICES PASSED TO SUBROUTINE PRED:
   7   3   5   6   0   0   9   0   0   0   0
0LABELS FOR DATA ITEMS:
 C ID TIME DV AMT RATE EVID MDV CMT ROWNUM SID
0FORMAT FOR DATA:
 (7E10.0/4E10.0)

 TOT. NO. OF OBS RECS:     8000
 TOT. NO. OF INDIVIDUALS:      800
0LENGTH OF THETA:   5
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS BLOCK FORM:
  1
  1  1
  1  1  1
  0  0  0  2
  0  0  0  2  2
  0  0  0  2  2  2
  0  0  0  0  0  0  3
  0  0  0  0  0  0  3  3
  0  0  0  0  0  0  3  3  3
  0  0  0  0  0  0  0  0  0  4
  0  0  0  0  0  0  0  0  0  4  4
  0  0  0  0  0  0  0  0  0  4  4  4
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
 -0.1000E+07     0.2000E+00     0.1000E+07
 -0.1000E+07    -0.4000E+01     0.1000E+07
 -0.1000E+07    -0.2000E+01     0.1000E+07
  0.3000E+01     0.3000E+01     0.3000E+01
  0.3000E+01     0.3000E+01     0.3000E+01
0INITIAL ESTIMATE OF OMEGA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.1000E+00
                  0.1000E-02   0.1000E+00
                  0.1000E-02   0.1000E-02   0.1000E+00
        2                                                                                   NO
                  0.3000E+00
                  0.1000E-02   0.3000E+00
                  0.1000E-02   0.1000E-02   0.3000E+00
        3                                                                                  YES
                  0.1000E-01
                  0.1000E-02   0.1000E-01
                  0.1000E-02   0.1000E-02   0.1000E-01
        4                                                                                  YES
                  0.3000E-01
                  0.1000E-02   0.3000E-01
                  0.1000E-02   0.1000E-02   0.3000E-01
0INITIAL ESTIMATE OF SIGMA:
 0.1000E+00
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
0
 PRIOR SUBROUTINE USER-SUPPLIED
1DOUBLE PRECISION PREDPP VERSION 7.5.0 Beta version 3

 ONE COMPARTMENT MODEL WITH FIRST-ORDER ABSORPTION (ADVAN2)
0MAXIMUM NO. OF BASIC PK PARAMETERS:   3
0BASIC PK PARAMETERS (AFTER TRANSLATION):
   ELIMINATION RATE (K) IS BASIC PK PARAMETER NO.:  1
   ABSORPTION RATE (KA) IS BASIC PK PARAMETER NO.:  3

 TRANSLATOR WILL CONVERT PARAMETERS
 CLEARANCE (CL) AND VOLUME (V) TO K (TRANS2)
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         DEPOT        OFF        YES        YES        YES        NO
    2         CENTRAL      ON         NO         YES        NO         YES
    3         OUTPUT       OFF        YES        NO         NO         NO
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            *           *           *           *           *
    2            4           *           *           *           *
    3            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      7
   TIME DATA ITEM IS DATA ITEM NO.:          3
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   5
   DOSE RATE DATA ITEM IS DATA ITEM NO.:     6
   COMPT. NO. DATA ITEM IS DATA ITEM NO.:    9

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
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
 NO. OF FUNCT. EVALS. ALLOWED:            1680
 NO. OF SIG. FIGURES REQUIRED:            3
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    10
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      8
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     8
 NOPRIOR SETTING (NOPRIOR):                 1
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          0
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): superid3_1.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 NESTED LEVEL MAPS:
  SID=(4[1],5[2],6[3])
 Level Weighting Type (LEVWT):0
 Center Level Etas about 0 (LEVCENTER):1
 EM OR BAYESIAN METHOD USED:                ITERATIVE TWO STAGE (ITS)
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          1
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          1
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 ITERATIONS (NITER):                        500
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
   1   2   3
 THETAS THAT ARE SIGMA-LIKE:
 
 
 MONITORING OF SEARCH:

 iteration            0 OBJ=   11349.3822969680
 iteration            1 OBJ=  -3372.65923935546
 iteration            2 OBJ=  -6542.79098243871
 iteration            3 OBJ=  -8624.99227579612
 iteration            4 OBJ=  -10460.5264893803
 iteration            5 OBJ=  -12196.3749674390
 iteration            6 OBJ=  -13857.3120133849
 iteration            7 OBJ=  -15405.3231042796
 iteration            8 OBJ=  -16657.8758812349
 iteration            9 OBJ=  -17072.0922352619
 iteration           10 OBJ=  -17076.9008915409
 iteration           11 OBJ=  -17077.3316721862
 iteration           12 OBJ=  -17077.4611565584
 iteration           13 OBJ=  -17077.4774440252
 iteration           14 OBJ=  -17077.4547426725
 iteration           15 OBJ=  -17077.4230631610
 iteration           16 OBJ=  -17077.3935316232
 iteration           17 OBJ=  -17077.3694173125
 iteration           18 OBJ=  -17077.3509237130
 iteration           19 OBJ=  -17077.3372227660
 iteration           20 OBJ=  -17077.3272803602
 iteration           21 OBJ=  -17077.3201583828
 iteration           22 OBJ=  -17077.3150992729
 iteration           23 OBJ=  -17077.3115252332
 iteration           24 OBJ=  -17077.3090096157
 iteration           25 OBJ=  -17077.3072430808
 iteration           26 OBJ=  -17077.3060046894
 iteration           27 OBJ=  -17077.3051373707
 iteration           28 OBJ=  -17077.3045303566
 iteration           29 OBJ=  -17077.3041057106
 iteration           30 OBJ=  -17077.3038086909
 iteration           31 OBJ=  -17077.3036009926
 iteration           32 OBJ=  -17077.3034557732
 iteration           33 OBJ=  -17077.3033541602
 iteration           34 OBJ=  -17077.3032831593
 iteration           35 OBJ=  -17077.3032334629
 iteration           36 OBJ=  -17077.3031987557
 iteration           37 OBJ=  -17077.3031744265
 iteration           38 OBJ=  -17077.3031574773
 Convergence achieved
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         6.8210E-08 -5.2477E-07 -5.0360E-07 -3.2037E-16 -1.2820E-16  4.4340E-17
 SE:             2.2545E-03  3.3949E-03  3.3592E-03  4.2798E-02  3.9229E-02  5.5272E-02
 N:                     800         800         800          16          16          16
 
 P VAL.:         9.9998E-01  9.9988E-01  9.9988E-01  1.0000E+00  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  3.5864E+01  2.0426E+00  2.6910E+00  8.2643E-06  5.1467E-06  5.3177E-06
 ETASHRINKVR(%)  5.8866E+01  4.0436E+00  5.3096E+00  1.6529E-05  1.0293E-05  1.0635E-05
 EBVSHRINKSD(%)  3.5864E+01  2.0426E+00  2.6910E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  5.8866E+01  4.0436E+00  5.3096E+00  0.0000E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  4.1109E+01  9.5950E+01  9.4940E+01  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  1.2308E+01
 EPSSHRINKVR(%)  2.3101E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -17077.3031574773     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -2374.28662620259     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2397
  
 #TERE:
 Elapsed estimation  time in seconds:    71.34
 Elapsed covariance  time in seconds:     0.15
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -17077.303       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         1.79E-01 -5.31E+00 -3.08E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.01E-02
 
 ETA2
+        1.49E-04  9.80E-03
 
 ETA3
+        5.39E-04  6.58E-04  9.73E-03
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  3.13E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -5.61E-03  2.63E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  2.73E-02 -6.28E-03  5.21E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.00E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.00E-01
 
 ETA2
+        1.50E-02  9.90E-02
 
 ETA3
+        5.44E-02  6.74E-02  9.86E-02
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.77E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -1.96E-01  1.62E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  6.76E-01 -1.70E-01  2.28E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.48E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                          STANDARD ERROR OF ESTIMATE (S)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         5.72E-03  3.67E-03  3.64E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.16E-04
 
 ETA2
+        5.44E-04  5.23E-04
 
 ETA3
+        6.90E-04  3.85E-04  5.27E-04
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.16E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  1.01E-02  1.53E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  1.64E-02  1.20E-02  2.89E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        5.56E-05
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        4.56E-03
 
 ETA2
+        5.46E-02  2.64E-03
 
 ETA3
+        6.92E-02  3.89E-02  2.67E-03
 
 ETA4
+       ......... ......... .........  3.28E-02
 
 ETA5
+       ......... ......... .........  3.24E-01  4.72E-02
 
 ETA6
+       ......... ......... .........  1.79E-01  2.80E-01  6.33E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.08E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (S)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 TH 1
+        3.27E-05
 
 TH 2
+        1.15E-06  1.35E-05
 
 TH 3
+        1.86E-06  1.44E-06  1.33E-05
 
 OM11
+       -3.52E-07  1.18E-07  2.04E-07  8.39E-07
 
 OM12
+        1.62E-07 -1.95E-08  2.84E-08  3.28E-08  2.96E-07
 
 OM13
+        7.16E-07  5.13E-08  5.66E-08  6.81E-08  5.92E-08  4.76E-07
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -4.39E-10  2.75E-07 -3.41E-08  6.57E-09  1.78E-08  1.29E-08  0.00E+00  0.00E+00  0.00E+00  2.74E-07
 
 OM23
+        4.29E-08 -3.89E-08  7.11E-08  1.20E-08  2.65E-08  2.78E-08  0.00E+00  0.00E+00  0.00E+00  4.04E-08  1.48E-07
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        8.29E-08  8.73E-08  5.73E-09  3.89E-08  1.30E-08  7.33E-08  0.00E+00  0.00E+00  0.00E+00  1.51E-08  2.58E-08  0.00E+00
          0.00E+00  0.00E+00  2.77E-07
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
 OM44
+        2.38E-06  6.51E-07  3.56E-07 -6.99E-07  1.69E-07  2.08E-07  0.00E+00  0.00E+00  0.00E+00  1.36E-07 -1.71E-07  0.00E+00
          0.00E+00  0.00E+00 -1.03E-07  0.00E+00  0.00E+00  0.00E+00  1.34E-04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        5.81E-07  5.79E-07  4.03E-07  3.00E-07 -8.00E-08  3.23E-07  0.00E+00  0.00E+00  0.00E+00  7.58E-08 -9.85E-08  0.00E+00
          0.00E+00  0.00E+00  1.53E-07  0.00E+00  0.00E+00  0.00E+00 -1.78E-05  1.03E-04
 
 OM46
+        1.67E-06  1.22E-06  7.41E-07 -6.48E-08  3.62E-08 -3.34E-08  0.00E+00  0.00E+00  0.00E+00  3.94E-07 -1.57E-07  0.00E+00
          0.00E+00  0.00E+00 -3.58E-07  0.00E+00  0.00E+00  0.00E+00  1.33E-04 -5.24E-05  2.67E-04
 
 OM55
+        4.13E-08 -3.75E-07  1.32E-08 -3.00E-07  1.48E-07 -7.19E-07  0.00E+00  0.00E+00  0.00E+00 -8.05E-08  2.42E-07  0.00E+00
          0.00E+00  0.00E+00  3.60E-08  0.00E+00  0.00E+00  0.00E+00  2.95E-05 -8.17E-05  2.77E-05  2.34E-04
 
 OM56
+        1.03E-06  3.62E-07  1.03E-07 -1.07E-07 -4.87E-08  8.41E-08  0.00E+00  0.00E+00  0.00E+00  8.59E-08 -1.74E-07  0.00E+00
          0.00E+00  0.00E+00 -7.70E-09  0.00E+00  0.00E+00  0.00E+00 -3.85E-05  9.44E-05 -1.03E-04 -7.75E-05  1.43E-04
 
 OM66
+       -3.47E-07  1.44E-06  6.05E-07  2.60E-07 -4.59E-07 -4.31E-07  0.00E+00  0.00E+00  0.00E+00  5.82E-07 -1.94E-07  0.00E+00
          0.00E+00  0.00E+00 -4.62E-07  0.00E+00  0.00E+00  0.00E+00  1.76E-04 -9.02E-05  4.24E-04  1.97E-05 -2.00E-04  8.37E-04
 
 SG11
+        3.80E-09 -5.28E-10  3.08E-09 -3.27E-09 -4.02E-10 -2.65E-09  0.00E+00  0.00E+00  0.00E+00 -1.59E-09 -1.41E-09  0.00E+00
          0.00E+00  0.00E+00 -2.14E-09  0.00E+00  0.00E+00  0.00E+00  3.10E-08 -5.33E-09  2.25E-08  4.78E-08  1.81E-09 -1.19E-08
         3.09E-09
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (S)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 TH 1
+        5.72E-03
 
 TH 2
+        5.46E-02  3.67E-03
 
 TH 3
+        8.93E-02  1.08E-01  3.64E-03
 
 OM11
+       -6.71E-02  3.52E-02  6.12E-02  9.16E-04
 
 OM12
+        5.21E-02 -9.75E-03  1.43E-02  6.57E-02  5.44E-04
 
 OM13
+        1.81E-01  2.02E-02  2.25E-02  1.08E-01  1.58E-01  6.90E-04
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -1.47E-04  1.43E-01 -1.79E-02  1.37E-02  6.26E-02  3.58E-02  0.00E+00  0.00E+00  0.00E+00  5.23E-04
 
 OM23
+        1.95E-02 -2.76E-02  5.07E-02  3.42E-02  1.27E-01  1.05E-01  0.00E+00  0.00E+00  0.00E+00  2.01E-01  3.85E-04
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        2.75E-02  4.52E-02  2.99E-03  8.06E-02  4.56E-02  2.02E-01  0.00E+00  0.00E+00  0.00E+00  5.49E-02  1.27E-01  0.00E+00
          0.00E+00  0.00E+00  5.27E-04
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
 OM44
+        3.59E-02  1.53E-02  8.42E-03 -6.59E-02  2.69E-02  2.60E-02  0.00E+00  0.00E+00  0.00E+00  2.24E-02 -3.83E-02  0.00E+00
          0.00E+00  0.00E+00 -1.69E-02  0.00E+00  0.00E+00  0.00E+00  1.16E-02
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        1.00E-02  1.56E-02  1.09E-02  3.23E-02 -1.45E-02  4.62E-02  0.00E+00  0.00E+00  0.00E+00  1.43E-02 -2.53E-02  0.00E+00
          0.00E+00  0.00E+00  2.87E-02  0.00E+00  0.00E+00  0.00E+00 -1.51E-01  1.01E-02
 
 OM46
+        1.78E-02  2.03E-02  1.24E-02 -4.33E-03  4.07E-03 -2.96E-03  0.00E+00  0.00E+00  0.00E+00  4.61E-02 -2.49E-02  0.00E+00
          0.00E+00  0.00E+00 -4.16E-02  0.00E+00  0.00E+00  0.00E+00  7.03E-01 -3.17E-01  1.64E-02
 
 OM55
+        4.71E-04 -6.69E-03  2.37E-04 -2.14E-02  1.78E-02 -6.81E-02  0.00E+00  0.00E+00  0.00E+00 -1.01E-02  4.10E-02  0.00E+00
          0.00E+00  0.00E+00  4.47E-03  0.00E+00  0.00E+00  0.00E+00  1.66E-01 -5.27E-01  1.11E-01  1.53E-02
 
 OM56
+        1.50E-02  8.23E-03  2.36E-03 -9.80E-03 -7.47E-03  1.02E-02  0.00E+00  0.00E+00  0.00E+00  1.37E-02 -3.78E-02  0.00E+00
          0.00E+00  0.00E+00 -1.22E-03  0.00E+00  0.00E+00  0.00E+00 -2.78E-01  7.78E-01 -5.25E-01 -4.23E-01  1.20E-02
 
 OM66
+       -2.09E-03  1.36E-02  5.74E-03  9.80E-03 -2.92E-02 -2.16E-02  0.00E+00  0.00E+00  0.00E+00  3.85E-02 -1.74E-02  0.00E+00
          0.00E+00  0.00E+00 -3.03E-02  0.00E+00  0.00E+00  0.00E+00  5.25E-01 -3.08E-01  8.97E-01  4.45E-02 -5.78E-01  2.89E-02
 
 SG11
+        1.19E-02 -2.59E-03  1.52E-02 -6.43E-02 -1.33E-02 -6.90E-02  0.00E+00  0.00E+00  0.00E+00 -5.45E-02 -6.61E-02  0.00E+00
          0.00E+00  0.00E+00 -7.32E-02  0.00E+00  0.00E+00  0.00E+00  4.82E-02 -9.46E-03  2.47E-02  5.62E-02  2.71E-03 -7.40E-03
         5.56E-05
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (S)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 TH 1
+        3.23E+04
 
 TH 2
+       -2.35E+03  7.76E+04
 
 TH 3
+       -4.27E+03 -8.41E+03  7.75E+04
 
 OM11
+        1.86E+04 -9.19E+03 -1.97E+04  1.25E+06
 
 OM12
+       -9.35E+03  1.01E+04 -1.40E+03 -1.13E+05  3.55E+06
 
 OM13
+       -4.99E+04 -7.10E+02  1.88E+03 -1.67E+05 -3.70E+05  2.38E+06
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        4.84E+03 -8.53E+04  2.50E+04  8.25E+03 -1.48E+05 -1.08E+04  0.00E+00  0.00E+00  0.00E+00  3.95E+06
 
 OM23
+       -1.16E+03  5.08E+04 -4.61E+04 -8.70E+03 -5.11E+05 -2.56E+05  0.00E+00  0.00E+00  0.00E+00 -1.08E+06  7.38E+06
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        1.07E+03 -2.30E+04  6.69E+03 -1.16E+05 -1.96E+03 -5.31E+05  0.00E+00  0.00E+00  0.00E+00 -8.78E+04 -5.16E+05  0.00E+00
          0.00E+00  0.00E+00  3.86E+06
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
 OM44
+       -1.21E+02  6.33E+01  7.12E+01  1.34E+04 -3.84E+03 -7.73E+03  0.00E+00  0.00E+00  0.00E+00  4.01E+03  1.10E+04  0.00E+00
          0.00E+00  0.00E+00 -5.91E+03  0.00E+00  0.00E+00  0.00E+00  1.74E+04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        1.78E+02 -4.03E+02 -4.82E+02 -1.14E+04  3.12E+03 -8.75E+03  0.00E+00  0.00E+00  0.00E+00  3.83E+03 -9.48E+03  0.00E+00
          0.00E+00  0.00E+00 -1.44E+04  0.00E+00  0.00E+00  0.00E+00 -2.66E+03  3.02E+04
 
 OM46
+       -5.95E+02 -5.64E+02 -6.19E+02 -7.40E+03 -1.37E+04 -5.24E+03  0.00E+00  0.00E+00  0.00E+00 -1.15E+04  4.03E+03  0.00E+00
          0.00E+00  0.00E+00  1.42E+04  0.00E+00  0.00E+00  0.00E+00 -1.43E+04  4.18E+03  3.20E+04
 
 OM55
+       -1.88E+02 -5.78E+01 -6.97E+01 -1.56E+03  1.80E+02  9.78E+03  0.00E+00  0.00E+00  0.00E+00 -6.68E+02 -7.79E+03  0.00E+00
          0.00E+00  0.00E+00 -3.99E+03  0.00E+00  0.00E+00  0.00E+00 -1.77E+03  4.05E+03 -1.64E+02  6.51E+03
 
 OM56
+       -6.03E+02  2.55E+01  3.74E+01  7.01E+03  2.65E+03  1.34E+04  0.00E+00  0.00E+00  0.00E+00 -1.53E+04  1.88E+04  0.00E+00
          0.00E+00  0.00E+00  1.22E+04  0.00E+00  0.00E+00  0.00E+00 -1.56E+02 -1.98E+04 -2.30E+03  1.91E+03  2.71E+04
 
 OM66
+        1.87E+02  1.74E+02  1.95E+02  8.74E+02  1.05E+04  7.03E+03  0.00E+00  0.00E+00  0.00E+00 -1.24E+03  1.05E+03  0.00E+00
          0.00E+00  0.00E+00 -2.59E+03  0.00E+00  0.00E+00  0.00E+00  3.30E+03 -3.15E+03 -1.33E+04  1.20E+03  5.53E+03  8.20E+03
 
 SG11
+       -4.75E+04 -1.66E+04 -9.15E+04  1.00E+06 -9.36E+04  1.35E+06  0.00E+00  0.00E+00  0.00E+00  1.47E+06  2.18E+06  0.00E+00
          0.00E+00  0.00E+00  1.78E+06  0.00E+00  0.00E+00  0.00E+00 -2.53E+04 -4.61E+04 -1.36E+05 -7.08E+04 -1.09E+04  7.37E+04
         3.31E+08
 
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
 NO. OF FUNCT. EVALS. ALLOWED:            1680
 NO. OF SIG. FIGURES REQUIRED:            3
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    3
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      8
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     8
 NOPRIOR SETTING (NOPRIOR):                 1
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          0
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): superid3_1.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 NESTED LEVEL MAPS:
  SID=(4[1],5[2],6[3])
 Level Weighting Type (LEVWT):0
 Center Level Etas about 0 (LEVCENTER):1
 EM OR BAYESIAN METHOD USED:                IMPORTANCE SAMPLING (IMP)
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          1
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          1
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 ITERATIONS (NITER):                        500
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
 MC SAMPLES PER SUBJECT (ISAMPLE):          300
 MAXIMUM SAMPLES PER SUBJECT FOR AUTOMATIC
 ISAMPLE ADJUSTMENT (ISAMPEND):             10000
 RANDOM SAMPLING METHOD (RANMETHOD):        3U
 EXPECTATION ONLY (EONLY):                  0
 PROPOSAL DENSITY SCALING RANGE
              (ISCALE_MIN, ISCALE_MAX):     0.100000000000000       ,10.0000000000000
 SAMPLE ACCEPTANCE RATE (IACCEPT):          0.00000000000000
 LONG TAIL SAMPLE ACCEPT. RATE (IACCEPTL):   0.00000000000000
 T-DIST. PROPOSAL DENSITY (DF):             0
 NO. ITERATIONS FOR MAP (MAPITER):          1
 INTERVAL ITER. FOR MAP (MAPINTER):         0
 MAP COVARIANCE/MODE SETTING (MAPCOV):      1
 Gradient Quick Value (GRDQ):               0.00000000000000
 STOCHASTIC OBJ VARIATION TOLERANCE FOR
 AUTOMATIC ISAMPLE ADJUSTMENT (STDOBJ):     1.00000000000000

 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2   3
 THETAS THAT ARE SIGMA-LIKE:
 
 
 MONITORING OF SEARCH:

 iteration            0 OBJ=  -17080.5983067617 eff.=     301. Smpl.=     300. Fit.= 0.99194
 iteration            1 OBJ=  -17080.5554590301 eff.=     107. Smpl.=     300. Fit.= 0.83983
 iteration            2 OBJ=  -17083.0193920491 eff.=     118. Smpl.=     300. Fit.= 0.85146
 iteration            3 OBJ=  -17079.9193847190 eff.=     128. Smpl.=     300. Fit.= 0.86355
 iteration            4 OBJ=  -17078.8707201819 eff.=     136. Smpl.=     300. Fit.= 0.87121
 iteration            5 OBJ=  -17075.9865197540 eff.=     139. Smpl.=     300. Fit.= 0.87595
 iteration            6 OBJ=  -17079.6420199098 eff.=     143. Smpl.=     300. Fit.= 0.87946
 iteration            7 OBJ=  -17078.6411278714 eff.=     146. Smpl.=     300. Fit.= 0.88202
 iteration            8 OBJ=  -17079.9536048771 eff.=     148. Smpl.=     300. Fit.= 0.88412
 iteration            9 OBJ=  -17077.0806499609 eff.=     149. Smpl.=     300. Fit.= 0.88489
 iteration           10 OBJ=  -17081.2647426952 eff.=     149. Smpl.=     300. Fit.= 0.88526
 iteration           11 OBJ=  -17078.9337295218 eff.=     151. Smpl.=     300. Fit.= 0.88638
 Convergence achieved
 iteration           11 OBJ=  -17081.2540098845 eff.=     151. Smpl.=     300. Fit.= 0.88654
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         2.1863E-04  2.9119E-05  3.1749E-05 -3.4400E-17 -1.3364E-16 -3.5527E-17
 SE:             2.2628E-03  3.3962E-03  3.3559E-03  4.2804E-02  3.9242E-02  5.5277E-02
 N:                     800         800         800          16          16          16
 
 P VAL.:         9.2303E-01  9.9316E-01  9.9245E-01  1.0000E+00  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  3.5872E+01  1.9948E+00  2.8199E+00  1.2693E-01  1.1999E-03  1.0000E-10
 ETASHRINKVR(%)  5.8876E+01  3.9498E+00  5.5602E+00  2.5369E-01  2.3998E-03  1.0000E-10
 EBVSHRINKSD(%)  3.5659E+01  2.0396E+00  2.6855E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  5.8602E+01  4.0377E+00  5.2988E+00  0.0000E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  4.1372E+01  9.5954E+01  9.4946E+01  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  1.2387E+01
 EPSSHRINKVR(%)  2.3240E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -17081.2540098845     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -2378.23747860969     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2397
  
 #TERE:
 Elapsed estimation  time in seconds:   141.11
 Elapsed covariance  time in seconds:    12.32
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          IMPORTANCE SAMPLING (NO PRIOR)                        ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -17081.254       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          IMPORTANCE SAMPLING (NO PRIOR)                        ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         1.81E-01 -5.31E+00 -3.08E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.02E-02
 
 ETA2
+        1.48E-04  9.80E-03
 
 ETA3
+        5.38E-04  6.53E-04  9.73E-03
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  3.13E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -5.64E-03  2.63E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  2.73E-02 -6.32E-03  5.21E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.00E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.01E-01
 
 ETA2
+        1.48E-02  9.90E-02
 
 ETA3
+        5.41E-02  6.69E-02  9.87E-02
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.77E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -1.96E-01  1.62E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  6.75E-01 -1.71E-01  2.28E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.48E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          IMPORTANCE SAMPLING (NO PRIOR)                        ********************
 ********************                          STANDARD ERROR OF ESTIMATE (R)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         5.55E-03  3.58E-03  3.59E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        8.55E-04
 
 ETA2
+        5.29E-04  5.06E-04
 
 ETA3
+        5.92E-04  3.63E-04  5.10E-04
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.08E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  9.43E-03  1.37E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  1.51E-02  1.11E-02  2.62E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        5.50E-05
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        4.24E-03
 
 ETA2
+        5.29E-02  2.55E-03
 
 ETA3
+        5.90E-02  3.67E-02  2.58E-03
 
 ETA4
+       ......... ......... .........  3.05E-02
 
 ETA5
+       ......... ......... .........  3.04E-01  4.23E-02
 
 ETA6
+       ......... ......... .........  1.69E-01  2.63E-01  5.75E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.02E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          IMPORTANCE SAMPLING (NO PRIOR)                        ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (R)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 TH 1
+        3.08E-05
 
 TH 2
+        1.14E-06  1.28E-05
 
 TH 3
+        1.82E-06  1.46E-06  1.29E-05
 
 OM11
+        1.26E-08  1.51E-09  3.22E-09  7.30E-07
 
 OM12
+       -4.18E-08 -5.10E-09 -1.04E-09  4.43E-08  2.80E-07
 
 OM13
+        8.59E-08  1.02E-09 -3.81E-09  9.75E-08  3.63E-08  3.51E-07
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        9.03E-09  7.64E-09  2.83E-09 -4.23E-09  2.00E-08  1.70E-09  0.00E+00  0.00E+00  0.00E+00  2.56E-07
 
 OM23
+       -5.09E-09 -2.85E-09 -1.96E-09  3.13E-09  1.91E-08  1.19E-08  0.00E+00  0.00E+00  0.00E+00  2.80E-08  1.32E-07
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        1.33E-10 -1.98E-09 -2.63E-09  1.60E-10  3.55E-09  3.57E-08  0.00E+00  0.00E+00  0.00E+00 -4.64E-10  2.95E-08  0.00E+00
          0.00E+00  0.00E+00  2.60E-07
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
 OM44
+        6.11E-07  3.75E-07  4.23E-07 -8.89E-07  1.22E-07  4.88E-08  0.00E+00  0.00E+00  0.00E+00 -2.22E-08 -1.80E-07  0.00E+00
          0.00E+00  0.00E+00 -2.70E-07  0.00E+00  0.00E+00  0.00E+00  1.17E-04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        7.72E-07  3.38E-07  4.00E-07  3.72E-07 -5.71E-08  2.02E-07  0.00E+00  0.00E+00  0.00E+00  1.21E-07 -7.01E-08  0.00E+00
          0.00E+00  0.00E+00  1.49E-07  0.00E+00  0.00E+00  0.00E+00 -1.34E-05  8.88E-05
 
 OM46
+        7.03E-07  6.22E-07  6.65E-07 -3.92E-07  3.36E-08 -3.59E-08  0.00E+00  0.00E+00  0.00E+00  1.95E-07 -1.82E-07  0.00E+00
          0.00E+00  0.00E+00 -4.96E-07  0.00E+00  0.00E+00  0.00E+00  1.13E-04 -4.12E-05  2.27E-04
 
 OM55
+       -9.46E-07 -2.23E-07 -2.26E-07 -7.30E-07  6.97E-08 -5.12E-07  0.00E+00  0.00E+00  0.00E+00 -2.55E-07  1.79E-07  0.00E+00
          0.00E+00  0.00E+00 -1.00E-07  0.00E+00  0.00E+00  0.00E+00  1.60E-05 -6.42E-05  1.39E-05  1.88E-04
 
 OM56
+        1.64E-06  2.72E-07  3.38E-07  1.36E-07 -3.84E-08  1.09E-08  0.00E+00  0.00E+00  0.00E+00  2.01E-07 -1.27E-07  0.00E+00
          0.00E+00  0.00E+00  6.74E-08  0.00E+00  0.00E+00  0.00E+00 -2.84E-05  7.99E-05 -8.13E-05 -5.88E-05  1.23E-04
 
 OM66
+       -1.02E-06  4.57E-07  4.38E-07 -5.12E-07 -3.91E-07 -2.79E-07  0.00E+00  0.00E+00  0.00E+00  1.77E-07 -2.40E-07  0.00E+00
          0.00E+00  0.00E+00 -7.35E-07  0.00E+00  0.00E+00  0.00E+00  1.40E-04 -6.93E-05  3.50E-04 -1.98E-06 -1.58E-04  6.88E-04
 
 SG11
+        9.67E-10  2.45E-09  2.74E-09 -2.29E-09 -6.00E-10 -8.68E-10  0.00E+00  0.00E+00  0.00E+00 -4.33E-10 -5.13E-10  0.00E+00
          0.00E+00  0.00E+00 -6.07E-10  0.00E+00  0.00E+00  0.00E+00  2.62E-08  8.03E-10  1.99E-08  3.48E-08  5.03E-09 -1.31E-08
         3.03E-09
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          IMPORTANCE SAMPLING (NO PRIOR)                        ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (R)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 TH 1
+        5.55E-03
 
 TH 2
+        5.71E-02  3.58E-03
 
 TH 3
+        9.13E-02  1.13E-01  3.59E-03
 
 OM11
+        2.66E-03  4.93E-04  1.05E-03  8.55E-04
 
 OM12
+       -1.43E-02 -2.69E-03 -5.46E-04  9.81E-02  5.29E-04
 
 OM13
+        2.61E-02  4.82E-04 -1.79E-03  1.93E-01  1.16E-01  5.92E-04
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        3.22E-03  4.22E-03  1.56E-03 -9.80E-03  7.47E-02  5.68E-03  0.00E+00  0.00E+00  0.00E+00  5.06E-04
 
 OM23
+       -2.53E-03 -2.19E-03 -1.50E-03  1.01E-02  9.93E-02  5.55E-02  0.00E+00  0.00E+00  0.00E+00  1.52E-01  3.63E-04
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        4.70E-05 -1.08E-03 -1.43E-03  3.67E-04  1.32E-02  1.18E-01  0.00E+00  0.00E+00  0.00E+00 -1.80E-03  1.59E-01  0.00E+00
          0.00E+00  0.00E+00  5.10E-04
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
 OM44
+        1.02E-02  9.68E-03  1.09E-02 -9.62E-02  2.14E-02  7.62E-03  0.00E+00  0.00E+00  0.00E+00 -4.06E-03 -4.58E-02  0.00E+00
          0.00E+00  0.00E+00 -4.89E-02  0.00E+00  0.00E+00  0.00E+00  1.08E-02
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        1.48E-02  1.00E-02  1.18E-02  4.61E-02 -1.15E-02  3.62E-02  0.00E+00  0.00E+00  0.00E+00  2.55E-02 -2.05E-02  0.00E+00
          0.00E+00  0.00E+00  3.10E-02  0.00E+00  0.00E+00  0.00E+00 -1.31E-01  9.43E-03
 
 OM46
+        8.40E-03  1.15E-02  1.23E-02 -3.04E-02  4.22E-03 -4.02E-03  0.00E+00  0.00E+00  0.00E+00  2.56E-02 -3.33E-02  0.00E+00
          0.00E+00  0.00E+00 -6.45E-02  0.00E+00  0.00E+00  0.00E+00  6.95E-01 -2.90E-01  1.51E-02
 
 OM55
+       -1.24E-02 -4.54E-03 -4.59E-03 -6.24E-02  9.63E-03 -6.31E-02  0.00E+00  0.00E+00  0.00E+00 -3.68E-02  3.59E-02  0.00E+00
          0.00E+00  0.00E+00 -1.44E-02  0.00E+00  0.00E+00  0.00E+00  1.08E-01 -4.97E-01  6.71E-02  1.37E-02
 
 OM56
+        2.67E-02  6.85E-03  8.48E-03  1.43E-02 -6.56E-03  1.66E-03  0.00E+00  0.00E+00  0.00E+00  3.60E-02 -3.17E-02  0.00E+00
          0.00E+00  0.00E+00  1.19E-02  0.00E+00  0.00E+00  0.00E+00 -2.37E-01  7.65E-01 -4.87E-01 -3.88E-01  1.11E-02
 
 OM66
+       -7.02E-03  4.86E-03  4.65E-03 -2.29E-02 -2.82E-02 -1.80E-02  0.00E+00  0.00E+00  0.00E+00  1.33E-02 -2.52E-02  0.00E+00
          0.00E+00  0.00E+00 -5.49E-02  0.00E+00  0.00E+00  0.00E+00  4.93E-01 -2.80E-01  8.85E-01 -5.52E-03 -5.43E-01  2.62E-02
 
 SG11
+        3.16E-03  1.24E-02  1.38E-02 -4.88E-02 -2.06E-02 -2.66E-02  0.00E+00  0.00E+00  0.00E+00 -1.55E-02 -2.57E-02  0.00E+00
          0.00E+00  0.00E+00 -2.16E-02  0.00E+00  0.00E+00  0.00E+00  4.40E-02  1.55E-03  2.40E-02  4.62E-02  8.25E-03 -9.09E-03
         5.50E-05
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          IMPORTANCE SAMPLING (NO PRIOR)                        ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (R)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 TH 1
+        3.29E+04
 
 TH 2
+       -2.38E+03  7.92E+04
 
 TH 3
+       -4.33E+03 -8.54E+03  7.90E+04
 
 OM11
+        2.24E+02 -2.80E+02 -6.15E+02  1.46E+06
 
 OM12
+        6.48E+03  1.24E+03 -5.95E+02 -1.88E+05  3.72E+06
 
 OM13
+       -8.77E+03  3.21E+02  2.32E+03 -3.83E+05 -3.13E+05  3.06E+06
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -5.49E+02 -2.00E+03 -1.05E+01  5.13E+04 -2.41E+05  1.48E+04  0.00E+00  0.00E+00  0.00E+00  4.05E+06
 
 OM23
+        7.98E+00  1.01E+03 -8.64E+01  1.89E+04 -4.62E+05 -1.45E+05  0.00E+00  0.00E+00  0.00E+00 -8.69E+05  8.09E+06
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        4.92E+02 -7.12E+01  5.64E-01  6.65E+04  4.34E+04 -3.92E+05  0.00E+00  0.00E+00  0.00E+00  9.50E+04 -8.73E+05  0.00E+00
          0.00E+00  0.00E+00  4.03E+06
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
 OM44
+        1.57E+02  9.59E+01  8.62E+01  1.91E+04 -4.57E+03 -6.99E+03  0.00E+00  0.00E+00  0.00E+00  1.12E+04  9.78E+03  0.00E+00
          0.00E+00  0.00E+00  1.26E+03  0.00E+00  0.00E+00  0.00E+00  1.96E+04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        3.51E+02 -3.28E+02 -4.10E+02 -9.84E+03  1.98E+03 -9.46E+03  0.00E+00  0.00E+00  0.00E+00  5.04E+03 -9.60E+03  0.00E+00
          0.00E+00  0.00E+00 -1.27E+04  0.00E+00  0.00E+00  0.00E+00 -2.13E+03  3.22E+04
 
 OM46
+       -8.99E+02 -5.84E+02 -6.21E+02 -1.30E+04 -1.36E+04 -4.90E+03  0.00E+00  0.00E+00  0.00E+00 -1.89E+04  4.93E+03  0.00E+00
          0.00E+00  0.00E+00  6.55E+03  0.00E+00  0.00E+00  0.00E+00 -1.66E+04  3.89E+03  3.53E+04
 
 OM55
+        8.41E+01 -6.15E+00 -2.66E+01  3.00E+03  4.92E+02  9.07E+03  0.00E+00  0.00E+00  0.00E+00  4.11E+03 -8.26E+03  0.00E+00
          0.00E+00  0.00E+00  1.24E+03  0.00E+00  0.00E+00  0.00E+00 -1.15E+03  4.32E+03 -7.57E+02  7.69E+03
 
 OM56
+       -7.15E+02 -2.48E+01 -1.72E+01  7.48E+03  3.86E+03  1.43E+04  0.00E+00  0.00E+00  0.00E+00 -1.50E+04  1.88E+04  0.00E+00
          0.00E+00  0.00E+00  1.26E+04  0.00E+00  0.00E+00  0.00E+00 -2.96E+02 -2.08E+04 -2.15E+03  2.09E+03  2.85E+04
 
 OM66
+        3.50E+02  1.88E+02  2.01E+02  4.38E+03  1.07E+04  6.55E+03  0.00E+00  0.00E+00  0.00E+00  3.10E+03  6.46E+02  0.00E+00
          0.00E+00  0.00E+00  1.94E+03  0.00E+00  0.00E+00  0.00E+00  4.18E+03 -3.08E+03 -1.47E+04  1.56E+03  5.62E+03  9.06E+03
 
 SG11
+        4.91E+02 -5.14E+04 -5.85E+04  8.78E+05  5.61E+05  4.21E+05  0.00E+00  0.00E+00  0.00E+00  4.65E+05  9.05E+05  0.00E+00
          0.00E+00  0.00E+00  5.42E+05  0.00E+00  0.00E+00  0.00E+00 -1.35E+04 -5.68E+04 -1.54E+05 -6.69E+04 -1.04E+04  8.08E+04
         3.34E+08
 
1
 
 
 #TBLN:      3
 #METH: MCMC Bayesian Analysis
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            1680
 NO. OF SIG. FIGURES REQUIRED:            3
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
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
 FINAL ETA RE-EVALUATION (FNLETA):          0
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): superid3_1.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 NESTED LEVEL MAPS:
  SID=(4[1],5[2],6[3])
 Level Weighting Type (LEVWT):0
 Center Level Etas about 0 (LEVCENTER):1
 EM OR BAYESIAN METHOD USED:                MCMC BAYESIAN (BAYES)
 BAYES INDIVIDUAL PARAMETERS ONLY: NO
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          1
 CONVERGENCE TYPE (CTYPE):                  3
 KEEP ITERATIONS (THIN):            1
 CONVERGENCE INTERVAL (CINTERVAL):          0
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 BURN-IN ITERATIONS (NBURN):                4000
 FIRST ITERATION FOR MAP (MAPITERS):          NO
 ITERATIONS (NITER):                        500
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
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
 SAMPLES FOR LOCAL SEARCH KERNEL (PSAMPLE_M2):           -1
 SAMPLES FOR LOCAL UNIVARIATE KERNEL (PSAMPLE_M3):       1
 METROPOLIS HASTINGS POPULATION SAMPLING FOR NON-GIBBS
 SAMPLED OMEGAS:
 SAMPLE ACCEPTANCE RATE (OACCEPT):                       0.500000000000000
 SAMPLES FOR GLOBAL SEARCH KERNEL (OSAMPLE_M1):          -1
 SAMPLES FOR LOCAL SEARCH KERNEL (OSAMPLE_M2):           12
 SAMPLES FOR LOCAL UNIVARIATE SEARCH KERNEL (OSAMPLE_M3):12
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
   1   2   3
 THETAS THAT ARE GIBBS SAMPLED:
   1   2   3
 THETAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 SIGMAS THAT ARE GIBBS SAMPLED:
   1
 SIGMAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 OMEGAS ARE GIBBS SAMPLED
 
 MONITORING OF SEARCH:

 Burn-in Mode
 iteration        -4000 MCMCOBJ=   -37043.9574893235     
 iteration        -3975 MCMCOBJ=   -35963.3959465492     
 CINTERVAL IS           24
 iteration        -3950 MCMCOBJ=   -35741.5139590302     
 iteration        -3925 MCMCOBJ=   -35634.9278796769     
 iteration        -3900 MCMCOBJ=   -35651.8360329475     
 iteration        -3875 MCMCOBJ=   -35502.7546667424     
 iteration        -3850 MCMCOBJ=   -35497.6511192787     
 iteration        -3825 MCMCOBJ=   -35427.6439671255     
 iteration        -3800 MCMCOBJ=   -35386.9202752134     
 iteration        -3775 MCMCOBJ=   -35365.7939365196     
 iteration        -3750 MCMCOBJ=   -35356.0673512698     
 iteration        -3725 MCMCOBJ=   -35305.1668770744     
 iteration        -3700 MCMCOBJ=   -35337.1659088144     
 iteration        -3675 MCMCOBJ=   -35268.3058449121     
 iteration        -3650 MCMCOBJ=   -35401.3079403295     
 iteration        -3625 MCMCOBJ=   -35249.2839596260     
 Convergence achieved
 iteration        -3624 MCMCOBJ=   -35375.3741357829     
 Sampling Mode
 iteration            0 MCMCOBJ=   -35422.3788116666     
 iteration           25 MCMCOBJ=   -35294.3781269184     
 iteration           50 MCMCOBJ=   -35387.0858562854     
 iteration           75 MCMCOBJ=   -35247.1089741272     
 iteration          100 MCMCOBJ=   -35308.6847885458     
 iteration          125 MCMCOBJ=   -35369.9226586255     
 iteration          150 MCMCOBJ=   -35170.6900642481     
 iteration          175 MCMCOBJ=   -35239.7609417788     
 iteration          200 MCMCOBJ=   -35449.4863041372     
 iteration          225 MCMCOBJ=   -35336.3118454260     
 iteration          250 MCMCOBJ=   -35218.2936080111     
 iteration          275 MCMCOBJ=   -35317.6207284332     
 iteration          300 MCMCOBJ=   -35299.2072556713     
 iteration          325 MCMCOBJ=   -35326.2781768248     
 iteration          350 MCMCOBJ=   -35270.9183669555     
 iteration          375 MCMCOBJ=   -35221.1111923386     
 iteration          400 MCMCOBJ=   -35062.5500352852     
 iteration          425 MCMCOBJ=   -35386.2132414252     
 iteration          450 MCMCOBJ=   -35404.7926814362     
 iteration          475 MCMCOBJ=   -35443.1657936448     
 iteration          500 MCMCOBJ=   -35248.4111158355     
 
 #TERM:
 BURN-IN WAS COMPLETED
 STATISTICAL PORTION WAS COMPLETED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -1.3509E-04 -2.0136E-04  9.8776E-05  2.6271E-16  3.5076E-17 -1.7458E-16
 SE:             2.2559E-03  3.3975E-03  3.3587E-03  4.2892E-02  3.9274E-02  5.5236E-02
 N:                     800         800         800          16          16          16
 
 P VAL.:         9.5225E-01  9.5274E-01  9.7654E-01  1.0000E+00  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  3.6099E+01  2.3573E+00  2.9646E+00  1.0934E+01  1.1857E+01  7.6012E+00
 ETASHRINKVR(%)  5.9166E+01  4.6591E+00  5.8414E+00  2.0673E+01  2.2309E+01  1.4625E+01
 EBVSHRINKSD(%)  3.5096E+01  2.0222E+00  2.6739E+00  1.0807E-01  1.2133E-02  8.8168E-03
 EBVSHRINKVR(%)  5.7875E+01  4.0036E+00  5.2762E+00  2.1602E-01  2.4265E-02  1.7633E-02
 RELATIVEINF(%)  4.2107E+01  9.6015E+01  9.4987E+01  9.9692E+01  9.9969E+01  1.0000E+02
 EPSSHRINKSD(%)  1.2327E+01
 EPSSHRINKVR(%)  2.3134E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -35295.4037369886     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -20592.3872057138     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2397
 NIND*NETA*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    4405.39132818319     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -35295.4037369886     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -30890.0124088054     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 PRIOR CONSTANT TO OBJECTIVE FUNCTION:    74.4768831102865     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -35295.4037369886     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -35220.9268538783     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:   576.50
 Elapsed covariance  time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 #OBJT:**************                       AVERAGE VALUE OF LIKELIHOOD FUNCTION                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -35295.404       **************************************************
 #OBJS:********************************************       89.172 (STD) **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         1.80E-01 -5.31E+00 -3.08E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.02E-02
 
 ETA2
+        1.76E-04  9.88E-03
 
 ETA3
+        5.64E-04  6.59E-04  9.78E-03
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  3.96E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -5.59E-03  3.39E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  2.91E-02 -6.73E-03  6.10E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.00E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.01E-01
 
 ETA2
+        1.75E-02  9.94E-02
 
 ETA3
+        5.62E-02  6.70E-02  9.89E-02
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.96E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -1.54E-01  1.81E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  5.84E-01 -1.51E-01  2.43E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.47E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************                STANDARD ERROR OF ESTIMATE (From Sample Variance)               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         5.64E-03  3.67E-03  3.64E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        8.32E-04
 
 ETA2
+        4.91E-04  5.40E-04
 
 ETA3
+        5.87E-04  3.61E-04  5.31E-04
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.42E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  9.50E-03  1.25E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  1.45E-02  1.15E-02  2.28E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        5.44E-05
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        4.11E-03
 
 ETA2
+        4.86E-02  2.71E-03
 
 ETA3
+        5.83E-02  3.64E-02  2.68E-03
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  3.33E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  2.28E-01  3.24E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  1.58E-01  2.25E-01  4.29E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        4.97E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************               COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 TH 1
+        3.18E-05
 
 TH 2
+        1.62E-06  1.35E-05
 
 TH 3
+        2.54E-06  1.29E-06  1.32E-05
 
 OM11
+       -1.07E-07  9.57E-08  3.90E-07  6.93E-07
 
 OM12
+       -8.12E-08  9.04E-08  5.29E-08  5.87E-09  2.41E-07
 
 OM13
+       -2.90E-07  3.72E-08  8.53E-08  6.46E-08  4.76E-08  3.45E-07
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -1.48E-07  4.39E-08  4.18E-08 -3.33E-08  2.74E-08 -1.67E-08  0.00E+00  0.00E+00  0.00E+00  2.92E-07
 
 OM23
+        4.86E-08 -1.52E-08 -2.56E-08  4.77E-09  1.75E-08  1.09E-09  0.00E+00  0.00E+00  0.00E+00  4.15E-08  1.30E-07
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        2.56E-08  8.78E-08  1.12E-07  1.47E-08  5.60E-09  4.38E-08  0.00E+00  0.00E+00  0.00E+00 -4.33E-10  6.09E-09  0.00E+00
          0.00E+00  0.00E+00  2.82E-07
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
 OM44
+       -5.40E-06  1.31E-06 -3.64E-06 -4.92E-07 -4.95E-07  2.24E-07  0.00E+00  0.00E+00  0.00E+00  3.30E-07 -1.40E-07  0.00E+00
          0.00E+00  0.00E+00 -6.89E-08  0.00E+00  0.00E+00  0.00E+00  2.03E-04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -1.84E-07 -9.26E-07  7.41E-07  2.24E-07  2.09E-07  1.93E-07  0.00E+00  0.00E+00  0.00E+00 -2.20E-07  8.91E-08  0.00E+00
          0.00E+00  0.00E+00  1.76E-07  0.00E+00  0.00E+00  0.00E+00 -1.45E-05  9.03E-05
 
 OM46
+       -8.34E-07  2.07E-06 -3.97E-06 -3.41E-07 -5.14E-07 -4.67E-07  0.00E+00  0.00E+00  0.00E+00 -1.24E-07 -2.91E-07  0.00E+00
          0.00E+00  0.00E+00 -1.15E-07  0.00E+00  0.00E+00  0.00E+00  1.50E-04 -8.96E-06  2.11E-04
 
 OM55
+        6.80E-07  3.17E-06  2.97E-06 -5.67E-07 -1.04E-07 -6.48E-07  0.00E+00  0.00E+00  0.00E+00 -7.53E-09 -3.24E-09  0.00E+00
          0.00E+00  0.00E+00  3.58E-07  0.00E+00  0.00E+00  0.00E+00  3.84E-06 -1.56E-05 -6.37E-06  1.55E-04
 
 OM56
+       -4.80E-06 -1.67E-07  8.37E-07  1.20E-07  9.11E-08  9.94E-08  0.00E+00  0.00E+00  0.00E+00 -1.99E-07  1.22E-07  0.00E+00
          0.00E+00  0.00E+00  2.47E-07  0.00E+00  0.00E+00  0.00E+00 -6.37E-06  6.81E-05 -1.41E-05 -1.94E-05  1.33E-04
 
 OM66
+       -2.50E-06  2.76E-06 -3.27E-06  3.55E-07 -3.18E-07 -1.21E-06  0.00E+00  0.00E+00  0.00E+00 -7.44E-07 -4.20E-07  0.00E+00
          0.00E+00  0.00E+00  2.09E-07  0.00E+00  0.00E+00  0.00E+00  1.06E-04 -2.45E-06  2.26E-04 -7.06E-07 -1.68E-05  5.19E-04
 
 SG11
+       -2.48E-09  5.96E-09 -2.35E-09  4.19E-10 -1.04E-09  3.23E-10  0.00E+00  0.00E+00  0.00E+00 -1.54E-10 -1.01E-09  0.00E+00
          0.00E+00  0.00E+00 -7.16E-10  0.00E+00  0.00E+00  0.00E+00 -5.23E-09 -1.66E-08 -4.47E-08  1.76E-08  4.37E-09 -7.99E-08
         2.96E-09
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************              CORRELATION MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 TH 1
+        5.64E-03
 
 TH 2
+        7.81E-02  3.67E-03
 
 TH 3
+        1.24E-01  9.65E-02  3.64E-03
 
 OM11
+       -2.28E-02  3.13E-02  1.29E-01  8.32E-04
 
 OM12
+       -2.94E-02  5.01E-02  2.97E-02  1.44E-02  4.91E-04
 
 OM13
+       -8.75E-02  1.72E-02  4.00E-02  1.32E-01  1.65E-01  5.87E-04
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -4.85E-02  2.21E-02  2.13E-02 -7.41E-02  1.04E-01 -5.28E-02  0.00E+00  0.00E+00  0.00E+00  5.40E-04
 
 OM23
+        2.39E-02 -1.15E-02 -1.95E-02  1.59E-02  9.89E-02  5.12E-03  0.00E+00  0.00E+00  0.00E+00  2.13E-01  3.61E-04
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        8.54E-03  4.50E-02  5.79E-02  3.33E-02  2.15E-02  1.41E-01  0.00E+00  0.00E+00  0.00E+00 -1.51E-03  3.17E-02  0.00E+00
          0.00E+00  0.00E+00  5.31E-04
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
 OM44
+       -6.72E-02  2.50E-02 -7.02E-02 -4.14E-02 -7.08E-02  2.68E-02  0.00E+00  0.00E+00  0.00E+00  4.29E-02 -2.71E-02  0.00E+00
          0.00E+00  0.00E+00 -9.11E-03  0.00E+00  0.00E+00  0.00E+00  1.42E-02
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -3.43E-03 -2.65E-02  2.15E-02  2.83E-02  4.49E-02  3.46E-02  0.00E+00  0.00E+00  0.00E+00 -4.28E-02  2.60E-02  0.00E+00
          0.00E+00  0.00E+00  3.48E-02  0.00E+00  0.00E+00  0.00E+00 -1.07E-01  9.50E-03
 
 OM46
+       -1.02E-02  3.88E-02 -7.53E-02 -2.83E-02 -7.22E-02 -5.48E-02  0.00E+00  0.00E+00  0.00E+00 -1.58E-02 -5.54E-02  0.00E+00
          0.00E+00  0.00E+00 -1.50E-02  0.00E+00  0.00E+00  0.00E+00  7.27E-01 -6.50E-02  1.45E-02
 
 OM55
+        9.68E-03  6.91E-02  6.55E-02 -5.47E-02 -1.70E-02 -8.85E-02  0.00E+00  0.00E+00  0.00E+00 -1.12E-03 -7.20E-04  0.00E+00
          0.00E+00  0.00E+00  5.40E-02  0.00E+00  0.00E+00  0.00E+00  2.16E-02 -1.32E-01 -3.52E-02  1.25E-02
 
 OM56
+       -7.40E-02 -3.96E-03  2.00E-02  1.25E-02  1.61E-02  1.47E-02  0.00E+00  0.00E+00  0.00E+00 -3.20E-02  2.92E-02  0.00E+00
          0.00E+00  0.00E+00  4.03E-02  0.00E+00  0.00E+00  0.00E+00 -3.88E-02  6.22E-01 -8.45E-02 -1.35E-01  1.15E-02
 
 OM66
+       -1.95E-02  3.30E-02 -3.95E-02  1.87E-02 -2.84E-02 -9.07E-02  0.00E+00  0.00E+00  0.00E+00 -6.05E-02 -5.11E-02  0.00E+00
          0.00E+00  0.00E+00  1.73E-02  0.00E+00  0.00E+00  0.00E+00  3.28E-01 -1.13E-02  6.83E-01 -2.49E-03 -6.42E-02  2.28E-02
 
 SG11
+       -8.08E-03  2.98E-02 -1.19E-02  9.25E-03 -3.91E-02  1.01E-02  0.00E+00  0.00E+00  0.00E+00 -5.23E-03 -5.16E-02  0.00E+00
          0.00E+00  0.00E+00 -2.48E-02  0.00E+00  0.00E+00  0.00E+00 -6.75E-03 -3.21E-02 -5.67E-02  2.60E-02  6.98E-03 -6.44E-02
         5.44E-05
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************           INVERSE COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 TH 1
+        3.32E+04
 
 TH 2
+       -3.77E+03  7.62E+04
 
 TH 3
+       -6.55E+03 -6.06E+03  8.02E+04
 
 OM11
+        8.18E+03 -8.84E+03 -4.50E+04  1.51E+06
 
 OM12
+        8.46E+03 -3.01E+04 -9.12E+03  2.91E+04  4.41E+06
 
 OM13
+        2.88E+04 -7.58E+03 -1.56E+04 -2.55E+05 -6.31E+05  3.22E+06
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        2.31E+04 -1.41E+04 -2.48E+04  1.75E+05 -3.95E+05  2.74E+05  0.00E+00  0.00E+00  0.00E+00  3.72E+06
 
 OM23
+       -2.35E+04  1.49E+04  3.36E+04 -1.29E+05 -4.46E+05  1.14E+04  0.00E+00  0.00E+00  0.00E+00 -1.15E+06  8.18E+06
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+       -5.76E+03 -1.79E+04 -2.13E+04 -2.05E+04  4.51E+04 -4.96E+05  0.00E+00  0.00E+00  0.00E+00 -2.12E+04 -1.60E+05  0.00E+00
          0.00E+00  0.00E+00  3.67E+06
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
 OM44
+        1.57E+03  1.87E+02  4.54E+02  1.98E+03  8.08E+03 -1.82E+04  0.00E+00  0.00E+00  0.00E+00 -1.30E+04 -2.46E+03  0.00E+00
          0.00E+00  0.00E+00 -2.21E+02  0.00E+00  0.00E+00  0.00E+00  1.24E+04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -1.23E+03  1.26E+03 -1.18E+02 -2.23E+03 -9.92E+03 -8.67E+03  0.00E+00  0.00E+00  0.00E+00  4.59E+03 -3.20E+03  0.00E+00
          0.00E+00  0.00E+00 -1.99E+03  0.00E+00  0.00E+00  0.00E+00  1.70E+03  1.86E+04
 
 OM46
+       -1.63E+03 -1.08E+03  1.14E+03  3.87E+03  7.76E+03  1.08E+04  0.00E+00  0.00E+00  0.00E+00  4.02E+03  9.95E+03  0.00E+00
          0.00E+00  0.00E+00  5.77E+03  0.00E+00  0.00E+00  0.00E+00 -1.14E+04 -8.70E+02  1.96E+04
 
 OM55
+        2.39E+02 -1.49E+03 -1.65E+03  5.67E+03  3.89E+02  1.47E+04  0.00E+00  0.00E+00  0.00E+00  4.17E+03 -2.14E+03  0.00E+00
          0.00E+00  0.00E+00 -1.07E+04  0.00E+00  0.00E+00  0.00E+00 -8.24E+02  5.28E+02  1.18E+03  6.83E+03
 
 OM56
+        1.92E+03 -9.50E+02 -7.74E+02  1.81E+03  3.24E+03  8.51E+03  0.00E+00  0.00E+00  0.00E+00  6.36E+03 -7.22E+03  0.00E+00
          0.00E+00  0.00E+00 -7.11E+03  0.00E+00  0.00E+00  0.00E+00 -1.27E+03 -9.53E+03  1.28E+03  8.07E+02  1.27E+04
 
 OM66
+        6.68E+02 -1.12E+02 -1.07E+02 -3.74E+03 -4.35E+03  7.23E+03  0.00E+00  0.00E+00  0.00E+00  5.84E+03  1.24E+03  0.00E+00
          0.00E+00  0.00E+00 -5.41E+03  0.00E+00  0.00E+00  0.00E+00  2.33E+03 -2.10E+02 -6.11E+03 -2.73E+02  9.78E+01  4.15E+03
 
 SG11
+        5.59E+03 -1.72E+05  1.06E+05 -3.15E+05  1.47E+06 -4.36E+05  0.00E+00  0.00E+00  0.00E+00 -1.86E+05  2.73E+06  0.00E+00
          0.00E+00  0.00E+00  9.24E+05  0.00E+00  0.00E+00  0.00E+00 -6.69E+04  9.22E+04  1.06E+05 -3.34E+04 -5.82E+04  2.23E+04
         3.43E+08
 
1
 
 
 #TBLN:      4
 #METH: First Order Conditional Estimation with Interaction (No Prior)
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               SLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            1680
 NO. OF SIG. FIGURES REQUIRED:            3
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    10
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      10
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     10
 NOPRIOR SETTING (NOPRIOR):                 1
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          0
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      1
 RAW OUTPUT FILE (FILE): superid3_1.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 NESTED LEVEL MAPS:
  SID=(4[1],5[2],6[3])
 Level Weighting Type (LEVWT):0
 Center Level Etas about 0 (LEVCENTER):1
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

 
0ITERATION NO.:    0    OBJECTIVE VALUE:  -17061.3668890291        NO. OF FUNC. EVALS.:  17
 CUMULATIVE NO. OF FUNC. EVALS.:       17
 NPARAMETR:  1.8010E-01 -5.3135E+00 -3.0826E+00  1.0174E-02  1.7644E-04  5.6390E-04  9.8834E-03  6.5948E-04  9.7799E-03  3.9581E-02
            -5.5877E-03  2.9068E-02  3.3883E-02 -6.7281E-03  6.0991E-02  2.9965E-03
 PARAMETER:  1.0000E-01 -1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
            -1.0000E-01  1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:   3.1058E+01 -2.5786E+03 -1.4110E+03  1.4001E+01  2.4850E-01 -6.7417E+00  4.1051E+01  5.8625E-01  2.7902E+01  4.8229E+01
            -2.4724E+01  1.3029E+02  1.2454E+02 -3.7768E+00  1.0610E+02 -5.0167E+00
 
0ITERATION NO.:    5    OBJECTIVE VALUE:  -17069.3233959022        NO. OF FUNC. EVALS.: 106
 CUMULATIVE NO. OF FUNC. EVALS.:      123
 NPARAMETR:  1.8222E-01 -5.3119E+00 -3.0818E+00  9.5963E-03  1.7049E-04  6.3221E-04  8.5055E-03  6.0571E-04  8.9330E-03  3.1981E-02
            -2.4978E-03  2.8783E-02  2.0445E-02 -4.1704E-03  5.3091E-02  2.9906E-03
 PARAMETER:  1.0118E-01 -9.9971E-02 -9.9975E-02  7.0760E-02  9.9500E-02  1.1544E-01  2.4908E-02  9.8637E-02  5.3830E-02 -6.6126E-03
            -4.9730E-02  1.1016E-01 -1.4562E-01 -9.3634E-02 -8.9367E-02  9.9022E-02
 GRADIENT:   1.9560E+02  6.0820E+03 -2.5975E+02 -3.1560E+01  1.6627E+00  4.3630E+00 -1.5797E+02  6.1418E+00 -6.3311E+01 -1.3335E+01
             5.1487E+01  1.9241E+02 -1.1303E+02 -4.2356E+00  9.5268E+00 -4.6337E+01
 
0ITERATION NO.:   10    OBJECTIVE VALUE:  -17074.3751735208        NO. OF FUNC. EVALS.:  94
 CUMULATIVE NO. OF FUNC. EVALS.:      217
 NPARAMETR:  1.8178E-01 -5.3119E+00 -3.0819E+00  1.0791E-02  1.7807E-04  5.9291E-04  9.3651E-03  6.9444E-04  9.5005E-03  2.8288E-02
            -3.2188E-03  2.9256E-02  2.0517E-02 -4.4340E-03  5.1642E-02  2.9999E-03
 PARAMETER:  1.0093E-01 -9.9970E-02 -9.9977E-02  1.2945E-01  9.7996E-02  1.0209E-01  7.3064E-02  1.0826E-01  8.4933E-02 -6.7961E-02
            -6.8141E-02  1.1906E-01 -1.4807E-01 -5.3956E-02 -2.0743E-01  1.0058E-01
 GRADIENT:   1.4674E+02  5.7601E+03 -3.4059E+02 -2.1192E+01  4.3354E-01  8.3061E+00 -7.6018E+01  4.2095E+00 -2.4281E+01 -3.6079E+01
             3.8558E+01  2.8872E+02 -8.9531E+01  2.5775E-02 -1.5590E+01 -1.1493E+00
 
0ITERATION NO.:   15    OBJECTIVE VALUE:  -17082.5521917596        NO. OF FUNC. EVALS.:  93
 CUMULATIVE NO. OF FUNC. EVALS.:      310
 NPARAMETR:  1.8010E-01 -5.3127E+00 -3.0821E+00  1.0421E-02  5.6779E-04  2.6576E-04  9.6572E-03  5.9151E-04  9.6932E-03  3.1312E-02
            -4.1423E-03  2.8054E-02  2.3965E-02 -5.0525E-03  4.8466E-02  3.0013E-03
 PARAMETER:  9.9999E-02 -9.9985E-02 -9.9982E-02  1.1198E-01  3.1798E-01  4.6568E-02  8.6977E-02  8.9979E-02  9.7206E-02 -1.7181E-02
            -8.3348E-02  1.0851E-01 -7.2950E-02 -6.0748E-02 -1.6410E-01  1.0080E-01
 GRADIENT:   2.6142E+01  1.2100E+03  1.5160E+01 -6.9612E+00  2.8734E+00 -3.0011E+00 -2.2963E+01 -4.6701E+00 -7.0232E+00 -4.8038E+00
             9.4605E+00 -1.4237E+01 -2.0089E+01 -3.7156E+00 -1.7297E+01  8.0885E+00
 
0ITERATION NO.:   20    OBJECTIVE VALUE:  -17083.8177645263        NO. OF FUNC. EVALS.:  91
 CUMULATIVE NO. OF FUNC. EVALS.:      401
 NPARAMETR:  1.7989E-01 -5.3129E+00 -3.0821E+00  1.0476E-02  1.9024E-04  5.9032E-04  9.8203E-03  6.7035E-04  9.7419E-03  3.1852E-02
            -4.3828E-03  2.7455E-02  2.5020E-02 -5.1543E-03  4.9710E-02  2.9987E-03
 PARAMETER:  9.9884E-02 -9.9990E-02 -9.9984E-02  1.1459E-01  1.0626E-01  1.0317E-01  9.6779E-02  1.0186E-01  9.7852E-02 -8.6283E-03
            -8.7437E-02  1.0529E-01 -5.2054E-02 -6.1055E-02 -1.0894E-01  1.0037E-01
 GRADIENT:  -2.2537E-01  4.8572E+00 -1.2414E+00  2.4235E-02  3.0381E-02  3.6268E-02  7.9865E-02  2.1394E-02 -3.8453E-03  4.5842E-02
            -1.4632E-02 -3.5059E-02  8.0327E-03  3.1847E-02 -3.3565E-02 -5.9650E-02
 
0ITERATION NO.:   23    OBJECTIVE VALUE:  -17083.8178326007        NO. OF FUNC. EVALS.:  74
 CUMULATIVE NO. OF FUNC. EVALS.:      475
 NPARAMETR:  1.7990E-01 -5.3129E+00 -3.0821E+00  1.0477E-02  1.9109E-04  5.9259E-04  9.8197E-03  6.7056E-04  9.7426E-03  3.1851E-02
            -4.3812E-03  2.7453E-02  2.5024E-02 -5.1537E-03  4.9714E-02  2.9987E-03
 PARAMETER:  9.9889E-02 -9.9989E-02 -9.9983E-02  1.1468E-01  1.0673E-01  1.0356E-01  9.6744E-02  1.0188E-01  9.7874E-02 -8.6467E-03
            -8.7406E-02  1.0528E-01 -5.1965E-02 -6.1099E-02 -1.0878E-01  1.0037E-01
 GRADIENT:  -1.6898E-02  7.5696E+00  1.7294E+00  2.6108E-03 -2.1469E-03 -3.4718E-03 -1.2189E-02 -2.0779E-04  4.5947E-03 -9.7799E-03
             5.0668E-03  7.8103E-02  1.5300E-02 -1.0001E-03 -1.4483E-03 -5.9314E-03
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      475
 NO. OF SIG. DIGITS IN FINAL EST.:  3.1

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -3.3310E-04 -9.7709E-05 -8.9215E-05  3.3681E-16 -2.3752E-16 -2.0997E-16
 SE:             2.2705E-03  3.3954E-03  3.3597E-03  4.2888E-02  3.9227E-02  5.5279E-02
 N:                     800         800         800          16          16          16
 
 P VAL.:         8.8337E-01  9.7704E-01  9.7882E-01  1.0000E+00  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  3.6623E+01  2.1010E+00  2.7483E+00  7.2282E-01  1.0000E-10  1.0000E-10
 ETASHRINKVR(%)  5.9833E+01  4.1579E+00  5.4211E+00  1.4404E+00  1.0000E-10  1.0000E-10
 EBVSHRINKSD(%)  3.5634E+01  2.0438E+00  2.6933E+00  5.7536E-02  1.5878E-02  1.0415E-02
 EBVSHRINKVR(%)  5.8570E+01  4.0459E+00  5.3141E+00  1.1504E-01  3.1753E-02  2.0828E-02
 RELATIVEINF(%)  4.1413E+01  9.5982E+01  9.4973E+01  9.9790E+01  9.9964E+01  9.9970E+01
 EPSSHRINKSD(%)  1.2337E+01
 EPSSHRINKVR(%)  2.3153E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -17083.8178326007     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -2380.80130132590     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2400
  
 #TERE:
 Elapsed estimation  time in seconds:   423.35
 Elapsed covariance  time in seconds:   122.99
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -17083.818       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         1.80E-01 -5.31E+00 -3.08E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.05E-02
 
 ETA2
+        1.91E-04  9.82E-03
 
 ETA3
+        5.93E-04  6.71E-04  9.74E-03
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  3.19E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -4.38E-03  2.50E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  2.75E-02 -5.15E-03  4.97E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.00E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.02E-01
 
 ETA2
+        1.88E-02  9.91E-02
 
 ETA3
+        5.87E-02  6.86E-02  9.87E-02
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.78E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -1.55E-01  1.58E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  6.90E-01 -1.46E-01  2.23E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.48E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         5.63E-03  3.58E-03  3.60E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.20E-04
 
 ETA2
+        5.54E-04  5.19E-04
 
 ETA3
+        6.17E-04  3.71E-04  5.21E-04
 
 ETA4
+       ......... ......... .........  1.20E-02
 
 ETA5
+       ......... ......... .........  7.57E-03  8.97E-03
 
 ETA6
+       ......... ......... .........  1.27E-02  9.11E-03  1.79E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        5.47E-05
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        4.49E-03
 
 ETA2
+        5.45E-02  2.62E-03
 
 ETA3
+        6.04E-02  3.74E-02  2.64E-03
 
 ETA4
+       ......... ......... .........  3.38E-02
 
 ETA5
+       ......... ......... .........  2.62E-01  2.83E-02
 
 ETA6
+       ......... ......... .........  1.38E-01  2.52E-01  4.02E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.00E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 TH 1
+        3.17E-05
 
 TH 2
+        1.18E-06  1.28E-05
 
 TH 3
+        1.88E-06  1.47E-06  1.29E-05
 
 OM11
+        7.70E-08  4.51E-09  5.61E-09  8.46E-07
 
 OM12
+       -6.25E-08  4.50E-09 -1.05E-09  5.64E-08  3.07E-07
 
 OM13
+        1.16E-07  3.43E-09  1.03E-08  1.06E-07  3.87E-08  3.80E-07
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        8.05E-10  3.34E-09  2.69E-09  2.60E-09  2.49E-08  2.87E-09 ......... ......... .........  2.70E-07
 
 OM23
+        1.23E-09  7.13E-10  5.66E-10  3.75E-09  2.11E-08  1.45E-08 ......... ......... .........  3.11E-08  1.37E-07
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        9.37E-09 -2.16E-10  1.22E-09  5.71E-09  4.29E-09  3.91E-08 ......... ......... .........  3.61E-09  3.05E-08 .........
         ......... .........  2.71E-07
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
 OM44
+        7.57E-08  1.64E-08  4.38E-09  6.55E-08  1.12E-08  1.02E-08 ......... ......... ......... -6.20E-10  1.06E-09 .........
         ......... ......... -1.36E-09 ......... ......... .........  1.45E-04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -1.45E-08  2.24E-09  3.09E-09  5.18E-09  1.81E-08  1.81E-09 ......... ......... .........  6.82E-09  4.03E-10 .........
         ......... .........  1.87E-10 ......... ......... ......... -1.60E-05  5.74E-05
 
 OM46
+        5.61E-08  1.40E-08  7.01E-09  9.91E-09  2.09E-09  2.21E-08 ......... ......... ......... -5.90E-10  3.51E-09 .........
         ......... ......... -5.50E-10 ......... ......... .........  1.22E-04 -1.68E-05  1.62E-04
 
 OM55
+       -3.88E-09  3.64E-09  3.27E-09 -1.25E-10  5.23E-09  2.95E-11 ......... ......... .........  6.41E-09  1.61E-09 .........
         ......... ......... -4.78E-11 ......... ......... .........  1.73E-06 -9.78E-06  1.95E-06  8.04E-05
 
 OM56
+        9.37E-10  3.90E-09  3.30E-09 -9.15E-10  3.79E-09  3.11E-09 ......... ......... .........  3.90E-09  2.54E-09 .........
         ......... .........  1.36E-09 ......... ......... ......... -1.29E-05  4.81E-05 -1.86E-05 -1.31E-05  8.29E-05
 
 OM66
+        2.00E-08  7.90E-09  7.14E-09 -5.07E-09 -1.10E-09  9.00E-09 ......... ......... ......... -4.33E-10  3.61E-09 .........
         ......... .........  2.98E-09 ......... ......... .........  1.02E-04 -1.66E-05  1.84E-04  2.36E-06 -2.72E-05  3.22E-04
 
 SG11
+       -4.31E-10  2.90E-09  2.86E-09 -1.81E-09 -6.05E-10 -6.85E-10 ......... ......... ......... -4.22E-10 -4.49E-10 .........
         ......... ......... -5.02E-10 ......... ......... .........  7.80E-09  4.03E-09  8.27E-09  2.11E-09  4.20E-09  7.77E-09
         3.00E-09
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 TH 1
+        5.63E-03
 
 TH 2
+        5.83E-02  3.58E-03
 
 TH 3
+        9.29E-02  1.14E-01  3.60E-03
 
 OM11
+        1.49E-02  1.37E-03  1.70E-03  9.20E-04
 
 OM12
+       -2.00E-02  2.27E-03 -5.29E-04  1.11E-01  5.54E-04
 
 OM13
+        3.34E-02  1.55E-03  4.62E-03  1.88E-01  1.13E-01  6.17E-04
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        2.75E-04  1.79E-03  1.44E-03  5.45E-03  8.66E-02  8.94E-03 ......... ......... .........  5.19E-04
 
 OM23
+        5.88E-04  5.37E-04  4.25E-04  1.10E-02  1.03E-01  6.36E-02 ......... ......... .........  1.62E-01  3.71E-04
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        3.19E-03 -1.15E-04  6.53E-04  1.19E-02  1.49E-02  1.22E-01 ......... ......... .........  1.34E-02  1.58E-01 .........
         ......... .........  5.21E-04
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
 OM44
+        1.12E-03  3.80E-04  1.01E-04  5.91E-03  1.67E-03  1.37E-03 ......... ......... ......... -9.91E-05  2.37E-04 .........
         ......... ......... -2.17E-04 ......... ......... .........  1.20E-02
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -3.40E-04  8.26E-05  1.14E-04  7.44E-04  4.32E-03  3.88E-04 ......... ......... .........  1.73E-03  1.43E-04 .........
         ......... .........  4.73E-05 ......... ......... ......... -1.76E-01  7.57E-03
 
 OM46
+        7.84E-04  3.06E-04  1.53E-04  8.47E-04  2.97E-04  2.82E-03 ......... ......... ......... -8.93E-05  7.44E-04 .........
         ......... ......... -8.30E-05 ......... ......... .........  7.98E-01 -1.74E-01  1.27E-02
 
 OM55
+       -7.69E-05  1.13E-04  1.02E-04 -1.52E-05  1.05E-03  5.34E-06 ......... ......... .........  1.38E-03  4.85E-04 .........
         ......... ......... -1.02E-05 ......... ......... .........  1.60E-02 -1.44E-01  1.71E-02  8.97E-03
 
 OM56
+        1.83E-05  1.19E-04  1.01E-04 -1.09E-04  7.52E-04  5.54E-04 ......... ......... .........  8.25E-04  7.52E-04 .........
         ......... .........  2.87E-04 ......... ......... ......... -1.17E-01  6.98E-01 -1.61E-01 -1.60E-01  9.11E-03
 
 OM66
+        1.98E-04  1.23E-04  1.11E-04 -3.07E-04 -1.11E-04  8.14E-04 ......... ......... ......... -4.64E-05  5.43E-04 .........
         ......... .........  3.19E-04 ......... ......... .........  4.72E-01 -1.22E-01  8.08E-01  1.47E-02 -1.66E-01  1.79E-02
 
 SG11
+       -1.40E-03  1.48E-02  1.45E-02 -3.60E-02 -1.99E-02 -2.03E-02 ......... ......... ......... -1.48E-02 -2.21E-02 .........
         ......... ......... -1.76E-02 ......... ......... .........  1.18E-02  9.71E-03  1.19E-02  4.29E-03  8.43E-03  7.92E-03
         5.47E-05
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 TH 1
+        3.20E+04
 
 TH 2
+       -2.43E+03  7.91E+04
 
 TH 3
+       -4.37E+03 -8.64E+03  7.90E+04
 
 OM11
+       -2.16E+03 -2.20E+02 -1.00E+02  1.24E+06
 
 OM12
+        8.24E+03 -1.75E+03 -4.45E+02 -1.87E+05  3.38E+06
 
 OM13
+       -9.83E+03  3.81E+02 -7.39E+02 -3.29E+05 -2.79E+05  2.80E+06
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -6.10E+02 -8.14E+02 -7.09E+02  6.66E+03 -2.57E+05  2.38E+04 ......... ......... .........  3.83E+06
 
 OM23
+       -3.21E+02 -1.75E+02 -1.09E+02  2.53E+04 -4.34E+05 -1.66E+05 ......... ......... ......... -8.40E+05  7.74E+06
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        3.07E+02  6.54E+01 -2.01E+02  2.26E+04  4.35E+04 -3.72E+05 ......... ......... .........  4.47E+04 -8.28E+05 .........
         ......... .........  3.83E+06
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
 OM44
+       -1.64E+01 -2.74E+00  6.79E+00 -1.71E+03 -6.77E+02  1.31E+03 ......... ......... ......... -1.36E+01  3.48E+02 .........
         ......... ......... -2.21E+02 ......... ......... .........  2.49E+04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        6.91E+00  2.61E+00  1.07E-01 -3.40E+02 -1.90E+03  1.20E+02 ......... ......... ......... -5.38E+02  5.61E+02 .........
         ......... .........  1.85E+01 ......... ......... .........  1.77E+03  3.48E+04
 
 OM46
+       -3.08E+00 -2.82E+00 -1.94E+00  1.69E+03  5.16E+02 -2.27E+03 ......... ......... ......... -2.03E+01 -5.79E+02 .........
         ......... .........  4.99E+02 ......... ......... ......... -2.82E+04  1.39E+03  5.00E+04
 
 OM55
+        1.27E+00 -1.25E+00 -1.06E+00 -9.02E+00 -2.82E+02 -7.79E+00 ......... ......... ......... -3.31E+02 -1.04E+02 .........
         ......... ......... -8.04E+00 ......... ......... ......... -3.63E+00  9.73E+02  7.42E+01  1.28E+04
 
 OM56
+       -5.94E+00 -1.67E+00  1.07E+00  1.74E+02  8.97E+02 -2.20E+02 ......... ......... .........  9.07E+01 -5.81E+02 .........
         ......... ......... -6.61E+01 ......... ......... ......... -7.77E+02 -1.99E+04 -3.91E+02  1.48E+03  2.41E+04
 
 OM66
+        5.05E+00  2.54E+00 -5.46E-01 -4.17E+02 -9.12E+01  7.85E+02 ......... ......... .........  1.84E+00  1.06E+02 .........
         ......... ......... -2.47E+02 ......... ......... .........  8.26E+03 -1.25E+03 -1.97E+04  4.03E+01  1.47E+03  1.18E+04
 
 SG11
+        9.18E+03 -6.92E+04 -6.81E+04  6.45E+05  4.16E+05  3.01E+05 ......... ......... .........  3.80E+05  7.93E+05 .........
         ......... .........  4.62E+05 ......... ......... ......... -1.07E+04 -2.53E+04 -1.44E+04 -1.28E+04 -8.71E+03  1.61E+03
         3.35E+08
 
 Elapsed finaloutput time in seconds:     0.07
 #CPUT: Total CPU Time in Seconds,     1339.752
Stop Time: 
Tue 12/17/2019 
01:05 AM
