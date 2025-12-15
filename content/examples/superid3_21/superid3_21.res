Sat 12/14/2019 
09:02 AM
$PROB RUN# 
$INPUT C ID TIME DV AMT RATE EVID MDV CMT ROWNUM SID
$DATA superid3.csv IGNORE=C

$SUBROUTINES ADVAN2 TRANS2

$PK
MU_4=THETA(1)
MU_5=THETA(2)
MU_6=THETA(3)
KA=DEXP(MU_4+ETA(4)+ETA(1))
CL=DEXP(MU_5+ETA(5)+ETA(2))
V=DEXP(MU_6+ETA(6)+ETA(3))
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

$EST METHOD=ITS AUTO=1 PRINT=1 SIGL=8 FNLETA=0 NOPRIOR=1
     LEVCENTER=0
$EST METHOD=IMP AUTO=1 PRINT=1 NOPRIOR=1
$EST METHOD=BAYES AUTO=1 PRINT=25 NITER=2000 NOPRIOR=0
$EST METHOD=1 PRINT=5 NSIG=3 SIGL=10 FNLETA=0 SLOW NONINFETA=1 NOPRIOR=1
$COV MATRIX=R UNCONDITIONAL
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  126) ONLY THE LAST FNLETA LISTED IN THE SERIES OF $EST RECORDS FOR
 THIS PROBLEM WILL BE USED
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  121) INTERACTION IS IMPLIED WITH EM/BAYES ESTIMATION METHODS

 (MU_WARNING 12) MU_004: SHOULD NOT BE ASSOCIATED WITH ETA(001)

 (MU_WARNING 22) MU_004: HAS ALREADY BEEN MU_ ASSOCIATED, CANNOT BE USED AGAIN.

 (MU_WARNING 12) MU_005: SHOULD NOT BE ASSOCIATED WITH ETA(002)

 (MU_WARNING 22) MU_005: HAS ALREADY BEEN MU_ ASSOCIATED, CANNOT BE USED AGAIN.

 (MU_WARNING 12) MU_006: SHOULD NOT BE ASSOCIATED WITH ETA(003)

 (MU_WARNING 22) MU_006: HAS ALREADY BEEN MU_ ASSOCIATED, CANNOT BE USED AGAIN.
  
License Registered to: IDS NONMEM 7 TEAM
Expiration Date:     2 JUN 2030
Current Date:       14 DEC 2019
Days until program expires :3823
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
 RAW OUTPUT FILE (FILE): superid3_21.ext
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
 Center Level Etas about 0 (LEVCENTER):0
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

 iteration            0 OBJ=   3103.59355394311
 iteration            1 OBJ=  -3271.60754662329
 iteration            2 OBJ=  -5280.81643636313
 iteration            3 OBJ=  -7094.41483264664
 iteration            4 OBJ=  -8845.42394705036
 iteration            5 OBJ=  -10564.2465950295
 iteration            6 OBJ=  -12253.1079610288
 iteration            7 OBJ=  -13896.5453610684
 iteration            8 OBJ=  -15444.4539462435
 iteration            9 OBJ=  -16719.5307146428
 iteration           10 OBJ=  -17184.8502893316
 iteration           11 OBJ=  -17187.9422414271
 iteration           12 OBJ=  -17188.2905813104
 iteration           13 OBJ=  -17188.4231099586
 iteration           14 OBJ=  -17188.4715244745
 iteration           15 OBJ=  -17188.4847554625
 iteration           16 OBJ=  -17188.4841722407
 iteration           17 OBJ=  -17188.4790148595
 iteration           18 OBJ=  -17188.4730902091
 iteration           19 OBJ=  -17188.4678047340
 iteration           20 OBJ=  -17188.4635406421
 iteration           21 OBJ=  -17188.4602735786
 iteration           22 OBJ=  -17188.4578445309
 iteration           23 OBJ=  -17188.4560717842
 iteration           24 OBJ=  -17188.4547935801
 iteration           25 OBJ=  -17188.4538793488
 iteration           26 OBJ=  -17188.4532290561
 iteration           27 OBJ=  -17188.4527681781
 iteration           28 OBJ=  -17188.4524424658
 iteration           29 OBJ=  -17188.4522126213
 iteration           30 OBJ=  -17188.4520507282
 iteration           31 OBJ=  -17188.4519367017
 iteration           32 OBJ=  -17188.4518565161
 iteration           33 OBJ=  -17188.4518001426
 iteration           34 OBJ=  -17188.4517605306
 iteration           35 OBJ=  -17188.4517326484
 iteration           36 OBJ=  -17188.4517130639
 iteration           37 OBJ=  -17188.4516993047
 iteration           38 OBJ=  -17188.4516896201
 iteration           39 OBJ=  -17188.4516828165
 Convergence achieved
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.0497E-04 -3.3514E-05 -3.6480E-05  1.8470E-07 -5.6694E-07 -5.5156E-07
 SE:             2.2443E-03  3.3919E-03  3.3554E-03  4.2783E-02  3.9225E-02  5.5270E-02
 N:                     800         800         800          16          16          16
 
 P VAL.:         9.6270E-01  9.9212E-01  9.9133E-01  1.0000E+00  9.9999E-01  9.9999E-01
 
 ETASHRINKSD(%)  3.6009E+01  2.0808E+00  2.7414E+00  7.7013E-06  5.1254E-06  5.2641E-06
 ETASHRINKVR(%)  5.9051E+01  4.1182E+00  5.4076E+00  1.5403E-05  1.0251E-05  1.0528E-05
 EBVSHRINKSD(%)  3.6008E+01  2.0807E+00  2.7414E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  5.9051E+01  4.1182E+00  5.4076E+00  0.0000E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  4.0919E+01  9.5854E+01  9.4821E+01  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  1.2278E+01
 EPSSHRINKVR(%)  2.3049E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -17188.4516828165     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -2485.43515154171     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2445
  
 #TERE:
 Elapsed estimation  time in seconds:    55.71
 Elapsed covariance  time in seconds:     0.15
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -17188.452       **************************************************
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
+        9.84E-03
 
 ETA2
+        1.32E-04  9.60E-03
 
 ETA3
+        5.10E-04  6.35E-04  9.52E-03
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  3.12E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -5.62E-03  2.63E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  2.73E-02 -6.29E-03  5.21E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.00E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.92E-02
 
 ETA2
+        1.36E-02  9.80E-02
 
 ETA3
+        5.27E-02  6.64E-02  9.76E-02
 
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
 
         5.78E-02  5.94E-02  9.14E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        8.95E-04
 
 ETA2
+        5.34E-04  5.11E-04
 
 ETA3
+        6.67E-04  3.77E-04  5.17E-04
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.32E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  1.48E-02  1.85E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  2.04E-02  1.40E-02  3.24E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        5.58E-05
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        4.51E-03
 
 ETA2
+        5.49E-02  2.61E-03
 
 ETA3
+        6.84E-02  3.89E-02  2.65E-03
 
 ETA4
+       ......... ......... .........  3.74E-02
 
 ETA5
+       ......... ......... .........  4.80E-01  5.72E-02
 
 ETA6
+       ......... ......... .........  2.47E-01  3.28E-01  7.10E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.09E-04
 
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
+        3.34E-03
 
 TH 2
+       -5.38E-04  3.53E-03
 
 TH 3
+        3.18E-03 -2.81E-04  8.36E-03
 
 OM11
+       -3.68E-08 -3.41E-06 -1.76E-06  8.02E-07
 
 OM12
+       -2.26E-06 -7.02E-08 -2.36E-06  3.40E-08  2.85E-07
 
 OM13
+       -2.07E-06 -6.74E-07 -7.43E-07  7.36E-08  5.53E-08  4.45E-07
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.10E-06  8.71E-07  1.50E-06  3.39E-09  1.90E-08  1.40E-08  0.00E+00  0.00E+00  0.00E+00  2.61E-07
 
 OM23
+       -7.48E-07  7.55E-07  8.35E-07  1.03E-08  2.55E-08  2.65E-08  0.00E+00  0.00E+00  0.00E+00  4.15E-08  1.42E-07
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        1.70E-06 -1.97E-06  7.13E-07  3.96E-08  1.15E-08  6.78E-08  0.00E+00  0.00E+00  0.00E+00  1.11E-08  2.41E-08  0.00E+00
          0.00E+00  0.00E+00  2.67E-07
 
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
+        2.91E-04  1.52E-04  4.48E-04 -8.92E-07 -7.13E-08 -4.73E-08  0.00E+00  0.00E+00  0.00E+00  8.03E-08 -1.52E-07  0.00E+00
          0.00E+00  0.00E+00 -7.69E-08  0.00E+00  0.00E+00  0.00E+00  1.75E-04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        2.21E-04 -5.43E-05  9.49E-04  9.00E-08 -2.54E-07  3.49E-07  0.00E+00  0.00E+00  0.00E+00  4.01E-07  5.79E-08  0.00E+00
          0.00E+00  0.00E+00  1.54E-07  0.00E+00  0.00E+00  0.00E+00  2.23E-05  2.20E-04
 
 OM46
+        1.31E-04  6.84E-04  2.58E-04 -7.70E-07 -1.51E-07 -3.36E-07  0.00E+00  0.00E+00  0.00E+00  4.54E-07 -2.96E-08  0.00E+00
          0.00E+00  0.00E+00 -6.48E-07  0.00E+00  0.00E+00  0.00E+00  1.88E-04 -3.57E-05  4.18E-04
 
 OM55
+       -4.93E-05  1.13E-04 -7.90E-04 -1.57E-07  1.91E-07 -8.84E-07  0.00E+00  0.00E+00  0.00E+00 -5.03E-07  5.51E-08  0.00E+00
          0.00E+00  0.00E+00  8.18E-08  0.00E+00  0.00E+00  0.00E+00  8.90E-06 -1.90E-04  3.51E-05  3.44E-04
 
 OM56
+        3.22E-04 -2.60E-04  5.11E-04  3.02E-08 -2.52E-07 -2.69E-08  0.00E+00  0.00E+00  0.00E+00 -1.93E-08 -2.20E-07  0.00E+00
          0.00E+00  0.00E+00  2.16E-07  0.00E+00  0.00E+00  0.00E+00 -1.62E-05  1.47E-04 -1.29E-04 -1.19E-04  1.96E-04
 
 OM66
+       -1.63E-05  8.30E-04  3.17E-04 -6.29E-07 -5.46E-07 -5.77E-07  0.00E+00  0.00E+00  0.00E+00  8.74E-07  4.84E-08  0.00E+00
          0.00E+00  0.00E+00 -9.02E-07  0.00E+00  0.00E+00  0.00E+00  2.30E-04 -5.74E-05  5.97E-04  6.08E-06 -2.40E-04  1.05E-03
 
 SG11
+        5.00E-08  1.22E-07 -1.56E-07 -3.28E-09 -4.82E-10 -2.82E-09  0.00E+00  0.00E+00  0.00E+00 -1.67E-09 -1.47E-09  0.00E+00
          0.00E+00  0.00E+00 -2.12E-09  0.00E+00  0.00E+00  0.00E+00  3.62E-08 -3.23E-08  4.74E-08  8.08E-08 -9.99E-09  7.95E-09
         3.11E-09
 
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
+        5.78E-02
 
 TH 2
+       -1.57E-01  5.94E-02
 
 TH 3
+        6.01E-01 -5.17E-02  9.14E-02
 
 OM11
+       -7.11E-04 -6.40E-02 -2.14E-02  8.95E-04
 
 OM12
+       -7.33E-02 -2.21E-03 -4.84E-02  7.10E-02  5.34E-04
 
 OM13
+       -5.36E-02 -1.70E-02 -1.22E-02  1.23E-01  1.55E-01  6.67E-04
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -7.13E-02  2.87E-02  3.21E-02  7.42E-03  6.99E-02  4.10E-02  0.00E+00  0.00E+00  0.00E+00  5.11E-04
 
 OM23
+       -3.43E-02  3.37E-02  2.42E-02  3.05E-02  1.27E-01  1.05E-01  0.00E+00  0.00E+00  0.00E+00  2.15E-01  3.77E-04
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        5.67E-02 -6.40E-02  1.51E-02  8.56E-02  4.15E-02  1.97E-01  0.00E+00  0.00E+00  0.00E+00  4.20E-02  1.24E-01  0.00E+00
          0.00E+00  0.00E+00  5.17E-04
 
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
+        3.80E-01  1.94E-01  3.70E-01 -7.53E-02 -1.01E-02 -5.36E-03  0.00E+00  0.00E+00  0.00E+00  1.19E-02 -3.04E-02  0.00E+00
          0.00E+00  0.00E+00 -1.12E-02  0.00E+00  0.00E+00  0.00E+00  1.32E-02
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        2.58E-01 -6.16E-02  7.00E-01  6.77E-03 -3.21E-02  3.53E-02  0.00E+00  0.00E+00  0.00E+00  5.29E-02  1.03E-02  0.00E+00
          0.00E+00  0.00E+00  2.01E-02  0.00E+00  0.00E+00  0.00E+00  1.14E-01  1.48E-02
 
 OM46
+        1.11E-01  5.63E-01  1.38E-01 -4.20E-02 -1.38E-02 -2.47E-02  0.00E+00  0.00E+00  0.00E+00  4.35E-02 -3.83E-03  0.00E+00
          0.00E+00  0.00E+00 -6.13E-02  0.00E+00  0.00E+00  0.00E+00  6.93E-01 -1.18E-01  2.04E-02
 
 OM55
+       -4.60E-02  1.02E-01 -4.66E-01 -9.48E-03  1.93E-02 -7.15E-02  0.00E+00  0.00E+00  0.00E+00 -5.32E-02  7.88E-03  0.00E+00
          0.00E+00  0.00E+00  8.53E-03  0.00E+00  0.00E+00  0.00E+00  3.63E-02 -6.90E-01  9.25E-02  1.85E-02
 
 OM56
+        3.97E-01 -3.13E-01  3.99E-01  2.41E-03 -3.37E-02 -2.88E-03  0.00E+00  0.00E+00  0.00E+00 -2.70E-03 -4.17E-02  0.00E+00
          0.00E+00  0.00E+00  2.98E-02  0.00E+00  0.00E+00  0.00E+00 -8.76E-02  7.09E-01 -4.52E-01 -4.60E-01  1.40E-02
 
 OM66
+       -8.70E-03  4.31E-01  1.07E-01 -2.17E-02 -3.16E-02 -2.67E-02  0.00E+00  0.00E+00  0.00E+00  5.28E-02  3.96E-03  0.00E+00
          0.00E+00  0.00E+00 -5.38E-02  0.00E+00  0.00E+00  0.00E+00  5.37E-01 -1.19E-01  9.02E-01  1.01E-02 -5.30E-01  3.24E-02
 
 SG11
+        1.55E-02  3.69E-02 -3.07E-02 -6.57E-02 -1.62E-02 -7.59E-02  0.00E+00  0.00E+00  0.00E+00 -5.85E-02 -6.97E-02  0.00E+00
          0.00E+00  0.00E+00 -7.34E-02  0.00E+00  0.00E+00  0.00E+00  4.90E-02 -3.90E-02  4.16E-02  7.81E-02 -1.28E-02  4.40E-03
         5.58E-05
 
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
+        8.95E+02
 
 TH 2
+        8.18E+01  5.96E+02
 
 TH 3
+       -4.59E+02  2.91E+01  5.31E+02
 
 OM11
+       -1.74E+03  2.01E+03  1.18E+03  1.30E+06
 
 OM12
+        2.98E+03  1.08E+03 -3.07E+02 -1.19E+05  3.69E+06
 
 OM13
+        5.18E+02  4.28E+02  1.43E+03 -1.75E+05 -3.87E+05  2.47E+06
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        5.86E+03  1.16E+03 -2.18E+03  7.90E+03 -1.56E+05 -1.10E+04  0.00E+00  0.00E+00  0.00E+00  4.11E+06
 
 OM23
+        2.45E+02 -1.98E+03 -2.41E+03 -8.93E+03 -5.32E+05 -2.66E+05  0.00E+00  0.00E+00  0.00E+00 -1.12E+06  7.69E+06
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+       -4.76E+03  4.22E+02  2.02E+03 -1.22E+05 -1.92E+03 -5.53E+05  0.00E+00  0.00E+00  0.00E+00 -9.26E+04 -5.37E+05  0.00E+00
          0.00E+00  0.00E+00  4.02E+06
 
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
+       -2.62E+02  1.19E+03 -3.36E+02  1.35E+04 -3.90E+03 -7.85E+03  0.00E+00  0.00E+00  0.00E+00  3.86E+03  1.12E+04  0.00E+00
          0.00E+00  0.00E+00 -6.27E+03  0.00E+00  0.00E+00  0.00E+00  1.75E+04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        2.38E+03 -9.44E+02 -2.64E+03 -1.16E+04  3.17E+03 -8.92E+03  0.00E+00  0.00E+00  0.00E+00  3.88E+03 -9.65E+03  0.00E+00
          0.00E+00  0.00E+00 -1.47E+04  0.00E+00  0.00E+00  0.00E+00 -2.66E+03  3.02E+04
 
 OM46
+       -6.71E+02 -2.64E+03  9.35E+01 -7.36E+03 -1.41E+04 -5.33E+03  0.00E+00  0.00E+00  0.00E+00 -1.15E+04  4.11E+03  0.00E+00
          0.00E+00  0.00E+00  1.47E+04  0.00E+00  0.00E+00  0.00E+00 -1.43E+04  4.18E+03  3.20E+04
 
 OM55
+       -4.72E+02 -2.27E+02  2.65E+02 -1.74E+03  1.79E+02  9.99E+03  0.00E+00  0.00E+00  0.00E+00 -8.22E+02 -7.92E+03  0.00E+00
          0.00E+00  0.00E+00 -4.22E+03  0.00E+00  0.00E+00  0.00E+00 -1.77E+03  4.06E+03 -1.62E+02  6.52E+03
 
 OM56
+       -2.64E+03  5.30E+02  1.67E+03  7.13E+03  2.72E+03  1.37E+04  0.00E+00  0.00E+00  0.00E+00 -1.57E+04  1.91E+04  0.00E+00
          0.00E+00  0.00E+00  1.24E+04  0.00E+00  0.00E+00  0.00E+00 -1.61E+02 -1.98E+04 -2.29E+03  1.91E+03  2.71E+04
 
 OM66
+        4.68E+01  8.35E+02  7.19E+01  7.70E+02  1.07E+04  7.17E+03  0.00E+00  0.00E+00  0.00E+00 -1.39E+03  1.08E+03  0.00E+00
          0.00E+00  0.00E+00 -2.78E+03  0.00E+00  0.00E+00  0.00E+00  3.30E+03 -3.16E+03 -1.33E+04  1.20E+03  5.53E+03  8.21E+03
 
 SG11
+        8.42E+01  1.40E+03  7.87E+03  1.02E+06 -7.73E+04  1.38E+06  0.00E+00  0.00E+00  0.00E+00  1.48E+06  2.25E+06  0.00E+00
          0.00E+00  0.00E+00  1.82E+06  0.00E+00  0.00E+00  0.00E+00 -2.52E+04 -4.66E+04 -1.36E+05 -7.09E+04 -1.07E+04  7.39E+04
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
 RAW OUTPUT FILE (FILE): superid3_21.ext
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
 Center Level Etas about 0 (LEVCENTER):0
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

 iteration            0 OBJ=  -17191.7837909002 eff.=     301. Smpl.=     300. Fit.= 0.99194
 iteration            1 OBJ=  -17191.7071320156 eff.=     108. Smpl.=     300. Fit.= 0.83992
 iteration            2 OBJ=  -17194.1873690603 eff.=     118. Smpl.=     300. Fit.= 0.85142
 iteration            3 OBJ=  -17191.0702725323 eff.=     128. Smpl.=     300. Fit.= 0.86360
 iteration            4 OBJ=  -17190.0176450227 eff.=     136. Smpl.=     300. Fit.= 0.87125
 iteration            5 OBJ=  -17187.1144585888 eff.=     140. Smpl.=     300. Fit.= 0.87597
 iteration            6 OBJ=  -17190.7700622404 eff.=     143. Smpl.=     300. Fit.= 0.87949
 iteration            7 OBJ=  -17189.7412032612 eff.=     146. Smpl.=     300. Fit.= 0.88200
 iteration            8 OBJ=  -17191.0522062344 eff.=     148. Smpl.=     300. Fit.= 0.88424
 iteration            9 OBJ=  -17188.2007962629 eff.=     149. Smpl.=     300. Fit.= 0.88484
 iteration           10 OBJ=  -17192.3816653094 eff.=     150. Smpl.=     300. Fit.= 0.88537
 iteration           11 OBJ=  -17190.0915328794 eff.=     151. Smpl.=     300. Fit.= 0.88650
 Convergence achieved
 iteration           11 OBJ=  -17192.3803636808 eff.=     151. Smpl.=     300. Fit.= 0.88642
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         3.3323E-04 -5.9875E-06  2.8267E-05  3.1127E-04  1.2155E-04  1.3436E-04
 SE:             2.2525E-03  3.3932E-03  3.3521E-03  4.2788E-02  3.9238E-02  5.5275E-02
 N:                     800         800         800          16          16          16
 
 P VAL.:         8.8239E-01  9.9859E-01  9.9327E-01  9.9420E-01  9.9753E-01  9.9806E-01
 
 ETASHRINKSD(%)  3.6019E+01  2.0329E+00  2.8699E+00  1.2754E-01  1.5647E-03  1.0000E-10
 ETASHRINKVR(%)  5.9065E+01  4.0244E+00  5.6575E+00  2.5491E-01  3.1293E-03  1.0000E-10
 EBVSHRINKSD(%)  3.5804E+01  2.0781E+00  2.7363E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  5.8789E+01  4.1130E+00  5.3978E+00  0.0000E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  4.1182E+01  9.5858E+01  9.4825E+01  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  1.2366E+01
 EPSSHRINKVR(%)  2.3202E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -17192.3803636808     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -2489.36383240605     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2445
  
 #TERE:
 Elapsed estimation  time in seconds:   139.94
 Elapsed covariance  time in seconds:    12.39
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          IMPORTANCE SAMPLING (NO PRIOR)                        ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -17192.380       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          IMPORTANCE SAMPLING (NO PRIOR)                        ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         1.80E-01 -5.31E+00 -3.08E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.92E-03
 
 ETA2
+        1.32E-04  9.60E-03
 
 ETA3
+        5.09E-04  6.30E-04  9.53E-03
 
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
+        9.96E-02
 
 ETA2
+        1.35E-02  9.80E-02
 
 ETA3
+        5.23E-02  6.59E-02  9.76E-02
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.77E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -1.97E-01  1.62E-01
 
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
 
         5.65E-02  5.65E-02  8.38E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        8.77E-04
 
 ETA2
+        5.33E-04  5.07E-04
 
 ETA3
+        6.00E-04  3.61E-04  5.10E-04
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.21E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  1.27E-02  1.58E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  1.83E-02  1.26E-02  2.87E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        5.52E-05
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        4.40E-03
 
 ETA2
+        5.46E-02  2.59E-03
 
 ETA3
+        6.11E-02  3.73E-02  2.61E-03
 
 ETA4
+       ......... ......... .........  3.43E-02
 
 ETA5
+       ......... ......... .........  4.14E-01  4.86E-02
 
 ETA6
+       ......... ......... .........  2.23E-01  3.00E-01  6.30E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.04E-04
 
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
+        3.19E-03
 
 TH 2
+       -4.94E-04  3.19E-03
 
 TH 3
+        2.88E-03 -2.82E-04  7.02E-03
 
 OM11
+       -6.80E-07 -3.17E-06 -1.68E-06  7.69E-07
 
 OM12
+       -2.18E-06 -1.92E-07 -2.01E-06  4.99E-08  2.84E-07
 
 OM13
+       -1.75E-06 -7.13E-07 -1.27E-06  1.07E-07  4.00E-08  3.60E-07
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.35E-06  7.19E-07  7.02E-07  2.93E-09  2.24E-08  4.19E-09  0.00E+00  0.00E+00  0.00E+00  2.57E-07
 
 OM23
+       -4.68E-07  5.93E-07  7.58E-07  4.13E-09  1.98E-08  1.29E-08  0.00E+00  0.00E+00  0.00E+00  2.97E-08  1.30E-07
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        1.62E-06 -1.46E-06  6.35E-07  9.13E-09  3.50E-09  3.72E-08  0.00E+00  0.00E+00  0.00E+00  7.83E-10  2.88E-08  0.00E+00
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
+        2.47E-04  1.23E-04  3.52E-04 -1.08E-06 -6.71E-08 -1.21E-07  0.00E+00  0.00E+00  0.00E+00 -7.76E-08 -1.53E-07  0.00E+00
          0.00E+00  0.00E+00 -1.92E-07  0.00E+00  0.00E+00  0.00E+00  1.48E-04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        1.69E-04 -3.56E-05  6.85E-04  2.24E-07 -1.74E-07  1.59E-07  0.00E+00  0.00E+00  0.00E+00  3.23E-07  4.10E-08  0.00E+00
          0.00E+00  0.00E+00  1.37E-07  0.00E+00  0.00E+00  0.00E+00  1.39E-05  1.62E-04
 
 OM46
+        1.23E-04  5.43E-04  2.12E-04 -9.40E-07 -1.39E-07 -2.68E-07  0.00E+00  0.00E+00  0.00E+00  2.49E-07 -8.18E-08  0.00E+00
          0.00E+00  0.00E+00 -6.27E-07  0.00E+00  0.00E+00  0.00E+00  1.54E-04 -2.74E-05  3.34E-04
 
 OM55
+       -3.39E-05  9.33E-05 -5.32E-04 -6.25E-07  8.50E-08 -5.68E-07  0.00E+00  0.00E+00  0.00E+00 -4.96E-07  7.25E-08  0.00E+00
          0.00E+00  0.00E+00 -2.04E-08  0.00E+00  0.00E+00  0.00E+00  3.88E-06 -1.27E-04  2.01E-05  2.48E-04
 
 OM56
+        2.75E-04 -2.03E-04  3.76E-04  1.55E-07 -2.04E-07 -9.13E-08  0.00E+00  0.00E+00  0.00E+00  4.14E-08 -1.63E-07  0.00E+00
          0.00E+00  0.00E+00  2.22E-07  0.00E+00  0.00E+00  0.00E+00 -1.14E-05  1.11E-04 -9.72E-05 -8.17E-05  1.59E-04
 
 OM66
+       -1.27E-05  6.35E-04  2.31E-04 -1.03E-06 -4.91E-07 -4.41E-07  0.00E+00  0.00E+00  0.00E+00  4.65E-07 -6.85E-08  0.00E+00
          0.00E+00  0.00E+00 -9.48E-07  0.00E+00  0.00E+00  0.00E+00  1.77E-04 -4.63E-05  4.66E-04 -8.31E-06 -1.85E-04  8.26E-04
 
 SG11
+        3.19E-08  9.19E-08 -1.22E-07 -2.64E-09 -7.01E-10 -1.01E-09  0.00E+00  0.00E+00  0.00E+00 -5.77E-10 -5.55E-10  0.00E+00
          0.00E+00  0.00E+00 -6.31E-10  0.00E+00  0.00E+00  0.00E+00  3.19E-08 -1.76E-08  3.82E-08  5.83E-08 -3.57E-09  3.45E-09
         3.05E-09
 
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
+        5.65E-02
 
 TH 2
+       -1.55E-01  5.65E-02
 
 TH 3
+        6.08E-01 -5.96E-02  8.38E-02
 
 OM11
+       -1.37E-02 -6.40E-02 -2.29E-02  8.77E-04
 
 OM12
+       -7.25E-02 -6.38E-03 -4.49E-02  1.07E-01  5.33E-04
 
 OM13
+       -5.18E-02 -2.10E-02 -2.53E-02  2.03E-01  1.25E-01  6.00E-04
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -8.20E-02  2.51E-02  1.65E-02  6.59E-03  8.29E-02  1.38E-02  0.00E+00  0.00E+00  0.00E+00  5.07E-04
 
 OM23
+       -2.29E-02  2.90E-02  2.51E-02  1.30E-02  1.03E-01  5.94E-02  0.00E+00  0.00E+00  0.00E+00  1.62E-01  3.61E-04
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        5.64E-02 -5.07E-02  1.49E-02  2.04E-02  1.29E-02  1.22E-01  0.00E+00  0.00E+00  0.00E+00  3.03E-03  1.57E-01  0.00E+00
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
+        3.60E-01  1.79E-01  3.45E-01 -1.01E-01 -1.04E-02 -1.67E-02  0.00E+00  0.00E+00  0.00E+00 -1.26E-02 -3.50E-02  0.00E+00
          0.00E+00  0.00E+00 -3.11E-02  0.00E+00  0.00E+00  0.00E+00  1.21E-02
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        2.35E-01 -4.96E-02  6.42E-01  2.01E-02 -2.56E-02  2.08E-02  0.00E+00  0.00E+00  0.00E+00  5.00E-02  8.93E-03  0.00E+00
          0.00E+00  0.00E+00  2.11E-02  0.00E+00  0.00E+00  0.00E+00  8.99E-02  1.27E-02
 
 OM46
+        1.19E-01  5.26E-01  1.38E-01 -5.87E-02 -1.42E-02 -2.45E-02  0.00E+00  0.00E+00  0.00E+00  2.69E-02 -1.24E-02  0.00E+00
          0.00E+00  0.00E+00 -6.73E-02  0.00E+00  0.00E+00  0.00E+00  6.92E-01 -1.18E-01  1.83E-02
 
 OM55
+       -3.81E-02  1.05E-01 -4.03E-01 -4.52E-02  1.01E-02 -6.01E-02  0.00E+00  0.00E+00  0.00E+00 -6.20E-02  1.27E-02  0.00E+00
          0.00E+00  0.00E+00 -2.54E-03  0.00E+00  0.00E+00  0.00E+00  2.03E-02 -6.34E-01  6.97E-02  1.58E-02
 
 OM56
+        3.87E-01 -2.85E-01  3.56E-01  1.41E-02 -3.03E-02 -1.21E-02  0.00E+00  0.00E+00  0.00E+00  6.47E-03 -3.58E-02  0.00E+00
          0.00E+00  0.00E+00  3.45E-02  0.00E+00  0.00E+00  0.00E+00 -7.45E-02  6.94E-01 -4.22E-01 -4.12E-01  1.26E-02
 
 OM66
+       -7.83E-03  3.91E-01  9.58E-02 -4.11E-02 -3.20E-02 -2.56E-02  0.00E+00  0.00E+00  0.00E+00  3.19E-02 -6.60E-03  0.00E+00
          0.00E+00  0.00E+00 -6.47E-02  0.00E+00  0.00E+00  0.00E+00  5.07E-01 -1.26E-01  8.88E-01 -1.83E-02 -5.10E-01  2.87E-02
 
 SG11
+        1.02E-02  2.95E-02 -2.63E-02 -5.46E-02 -2.38E-02 -3.06E-02  0.00E+00  0.00E+00  0.00E+00 -2.06E-02 -2.78E-02  0.00E+00
          0.00E+00  0.00E+00 -2.24E-02  0.00E+00  0.00E+00  0.00E+00  4.76E-02 -2.51E-02  3.78E-02  6.71E-02 -5.13E-03  2.17E-03
         5.52E-05
 
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
+        8.85E+02
 
 TH 2
+        8.15E+01  5.96E+02
 
 TH 3
+       -4.53E+02  2.98E+01  5.29E+02
 
 OM11
+       -1.74E+03  2.00E+03  1.11E+03  1.40E+06
 
 OM12
+        2.86E+03  1.16E+03 -1.75E+02 -1.93E+05  3.69E+06
 
 OM13
+        5.11E+02  6.39E+02  1.38E+03 -3.84E+05 -3.18E+05  3.01E+06
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        5.90E+03  1.15E+03 -2.19E+03  7.33E+03 -2.45E+05  2.03E+04  0.00E+00  0.00E+00  0.00E+00  4.08E+06
 
 OM23
+        2.79E+02 -1.98E+03 -2.44E+03  2.49E+04 -4.71E+05 -1.52E+05  0.00E+00  0.00E+00  0.00E+00 -8.94E+05  8.22E+06
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+       -4.76E+03  4.16E+02  2.00E+03  2.44E+04  4.48E+04 -3.98E+05  0.00E+00  0.00E+00  0.00E+00  4.64E+04 -8.77E+05  0.00E+00
          0.00E+00  0.00E+00  4.05E+06
 
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
+       -2.40E+02  1.18E+03 -3.43E+02  1.76E+04 -4.53E+03 -6.89E+03  0.00E+00  0.00E+00  0.00E+00  9.48E+03  1.03E+04  0.00E+00
          0.00E+00  0.00E+00 -8.71E+02  0.00E+00  0.00E+00  0.00E+00  1.97E+04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        2.36E+03 -9.28E+02 -2.62E+03 -1.04E+04  2.06E+03 -9.58E+03  0.00E+00  0.00E+00  0.00E+00  4.84E+03 -9.75E+03  0.00E+00
          0.00E+00  0.00E+00 -1.34E+04  0.00E+00  0.00E+00  0.00E+00 -2.07E+03  3.23E+04
 
 OM46
+       -6.84E+02 -2.62E+03  1.02E+02 -1.14E+04 -1.40E+04 -5.18E+03  0.00E+00  0.00E+00  0.00E+00 -1.73E+04  4.71E+03  0.00E+00
          0.00E+00  0.00E+00  8.87E+03  0.00E+00  0.00E+00  0.00E+00 -1.67E+04  3.79E+03  3.54E+04
 
 OM55
+       -4.68E+02 -2.22E+02  2.64E+02  1.81E+03  5.44E+02  9.41E+03  0.00E+00  0.00E+00  0.00E+00  2.83E+03 -8.24E+03  0.00E+00
          0.00E+00  0.00E+00 -1.27E+02  0.00E+00  0.00E+00  0.00E+00 -1.15E+03  4.32E+03 -7.69E+02  7.70E+03
 
 OM56
+       -2.62E+03  5.26E+02  1.66E+03  7.49E+03  3.94E+03  1.45E+04  0.00E+00  0.00E+00  0.00E+00 -1.55E+04  1.91E+04  0.00E+00
          0.00E+00  0.00E+00  1.28E+04  0.00E+00  0.00E+00  0.00E+00 -3.52E+02 -2.08E+04 -2.09E+03  2.09E+03  2.85E+04
 
 OM66
+        4.78E+01  8.28E+02  7.05E+01  3.34E+03  1.10E+04  6.79E+03  0.00E+00  0.00E+00  0.00E+00  1.95E+03  8.41E+02  0.00E+00
          0.00E+00  0.00E+00  7.22E+02  0.00E+00  0.00E+00  0.00E+00  4.19E+03 -3.05E+03 -1.47E+04  1.56E+03  5.61E+03  9.07E+03
 
 SG11
+        2.48E+02  3.55E+03  9.87E+03  9.22E+05  5.98E+05  4.29E+05  0.00E+00  0.00E+00  0.00E+00  4.65E+05  9.25E+05  0.00E+00
          0.00E+00  0.00E+00  5.42E+05  0.00E+00  0.00E+00  0.00E+00 -2.37E+04 -5.94E+04 -1.43E+05 -7.40E+04 -1.04E+04  7.47E+04
         3.33E+08
 
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
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    100
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
 RAW OUTPUT FILE (FILE): superid3_21.ext
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
 Center Level Etas about 0 (LEVCENTER):0
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
 ITERATIONS (NITER):                        2000
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
 iteration        -4000 MCMCOBJ=   -35661.1671525412     
 iteration        -3975 MCMCOBJ=   -36040.5889281516     
 CINTERVAL IS           23
 iteration        -3950 MCMCOBJ=   -35956.6545321873     
 iteration        -3925 MCMCOBJ=   -35841.3657191444     
 iteration        -3900 MCMCOBJ=   -35673.4925746694     
 iteration        -3875 MCMCOBJ=   -35686.6308119771     
 iteration        -3850 MCMCOBJ=   -35564.2171787774     
 iteration        -3825 MCMCOBJ=   -35579.6867906682     
 iteration        -3800 MCMCOBJ=   -35589.7113140438     
 iteration        -3775 MCMCOBJ=   -35656.4065040154     
 iteration        -3750 MCMCOBJ=   -35622.8403846341     
 Convergence achieved
 iteration        -3726 MCMCOBJ=   -35567.9513929009     
 Sampling Mode
 iteration            0 MCMCOBJ=   -35614.0977764795     
 iteration           25 MCMCOBJ=   -35560.8033657718     
 iteration           50 MCMCOBJ=   -35628.8588953735     
 iteration           75 MCMCOBJ=   -35452.5767171954     
 iteration          100 MCMCOBJ=   -35381.7236498049     
 iteration          125 MCMCOBJ=   -35472.2550510261     
 iteration          150 MCMCOBJ=   -35537.1273005814     
 iteration          175 MCMCOBJ=   -35520.3120329647     
 iteration          200 MCMCOBJ=   -35660.9096274652     
 iteration          225 MCMCOBJ=   -35488.5660887142     
 iteration          250 MCMCOBJ=   -35492.1348424064     
 iteration          275 MCMCOBJ=   -35539.8326614441     
 iteration          300 MCMCOBJ=   -35565.1800958633     
 iteration          325 MCMCOBJ=   -35688.6570519884     
 iteration          350 MCMCOBJ=   -35591.0087090588     
 iteration          375 MCMCOBJ=   -35474.7642775461     
 iteration          400 MCMCOBJ=   -35556.1895028772     
 iteration          425 MCMCOBJ=   -35450.3818084016     
 iteration          450 MCMCOBJ=   -35450.0472318235     
 iteration          475 MCMCOBJ=   -35549.4705849982     
 iteration          500 MCMCOBJ=   -35569.2701485294     
 iteration          525 MCMCOBJ=   -35567.6367395583     
 iteration          550 MCMCOBJ=   -35597.7420674537     
 iteration          575 MCMCOBJ=   -35561.6537240262     
 iteration          600 MCMCOBJ=   -35602.1116104963     
 iteration          625 MCMCOBJ=   -35466.4343414122     
 iteration          650 MCMCOBJ=   -35556.6131013774     
 iteration          675 MCMCOBJ=   -35393.9602892539     
 iteration          700 MCMCOBJ=   -35438.3867065456     
 iteration          725 MCMCOBJ=   -35559.2116258943     
 iteration          750 MCMCOBJ=   -35388.0608164660     
 iteration          775 MCMCOBJ=   -35577.0936650656     
 iteration          800 MCMCOBJ=   -35383.6399718636     
 iteration          825 MCMCOBJ=   -35646.3669950670     
 iteration          850 MCMCOBJ=   -35430.7374994258     
 iteration          875 MCMCOBJ=   -35340.6059359590     
 iteration          900 MCMCOBJ=   -35710.5222066436     
 iteration          925 MCMCOBJ=   -35520.6159488158     
 iteration          950 MCMCOBJ=   -35490.5275595216     
 iteration          975 MCMCOBJ=   -35474.4259652210     
 iteration         1000 MCMCOBJ=   -35510.4677553347     
 iteration         1025 MCMCOBJ=   -35700.8039270618     
 iteration         1050 MCMCOBJ=   -35527.8263342947     
 iteration         1075 MCMCOBJ=   -35281.9672245851     
 iteration         1100 MCMCOBJ=   -35624.5948655859     
 iteration         1125 MCMCOBJ=   -35381.6004831012     
 iteration         1150 MCMCOBJ=   -35567.7340733675     
 iteration         1175 MCMCOBJ=   -35374.7250404732     
 iteration         1200 MCMCOBJ=   -35578.1002577456     
 iteration         1225 MCMCOBJ=   -35535.3577307809     
 iteration         1250 MCMCOBJ=   -35491.2490770759     
 iteration         1275 MCMCOBJ=   -35393.6550027514     
 iteration         1300 MCMCOBJ=   -35493.7881761446     
 iteration         1325 MCMCOBJ=   -35568.6224369713     
 iteration         1350 MCMCOBJ=   -35493.9120542098     
 iteration         1375 MCMCOBJ=   -35525.2379275004     
 iteration         1400 MCMCOBJ=   -35646.9847512294     
 iteration         1425 MCMCOBJ=   -35569.7156372801     
 iteration         1450 MCMCOBJ=   -35383.6791526117     
 iteration         1475 MCMCOBJ=   -35414.4793567303     
 iteration         1500 MCMCOBJ=   -35646.9745744556     
 iteration         1525 MCMCOBJ=   -35575.2282872549     
 iteration         1550 MCMCOBJ=   -35349.7404287628     
 iteration         1575 MCMCOBJ=   -35545.4329399772     
 iteration         1600 MCMCOBJ=   -35630.4443481745     
 iteration         1625 MCMCOBJ=   -35535.2106535865     
 iteration         1650 MCMCOBJ=   -35605.2938152088     
 iteration         1675 MCMCOBJ=   -35556.6458543771     
 iteration         1700 MCMCOBJ=   -35583.8565001015     
 iteration         1725 MCMCOBJ=   -35525.5571534923     
 iteration         1750 MCMCOBJ=   -35582.8831577146     
 iteration         1775 MCMCOBJ=   -35445.5906926623     
 iteration         1800 MCMCOBJ=   -35570.4540921749     
 iteration         1825 MCMCOBJ=   -35426.5776125695     
 iteration         1850 MCMCOBJ=   -35584.4618684718     
 iteration         1875 MCMCOBJ=   -35516.2899378008     
 iteration         1900 MCMCOBJ=   -35355.1018903903     
 iteration         1925 MCMCOBJ=   -35648.2918168522     
 iteration         1950 MCMCOBJ=   -35433.0300970382     
 iteration         1975 MCMCOBJ=   -35532.3933795157     
 iteration         2000 MCMCOBJ=   -35365.7235344740     
 
 #TERM:
 BURN-IN WAS COMPLETED
 STATISTICAL PORTION WAS COMPLETED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.3698E-04  5.1443E-05  7.7355E-05  2.6977E-04  3.3971E-04 -5.7981E-04
 SE:             2.2395E-03  3.3923E-03  3.3569E-03  4.2867E-02  3.9280E-02  5.5245E-02
 N:                     800         800         800          16          16          16
 
 P VAL.:         9.5123E-01  9.8790E-01  9.8162E-01  9.9498E-01  9.9310E-01  9.9163E-01
 
 ETASHRINKSD(%)  3.6221E+01  2.2524E+00  3.0312E+00  1.0918E+01  1.2142E+01  8.3213E+00
 ETASHRINKVR(%)  5.9323E+01  4.4540E+00  5.9705E+00  2.0643E+01  2.2809E+01  1.5950E+01
 EBVSHRINKSD(%)  3.5936E+01  2.0805E+00  2.7348E+00  1.2296E-01  1.3734E-02  9.9678E-03
 EBVSHRINKVR(%)  5.8958E+01  4.1177E+00  5.3947E+00  2.4576E-01  2.7466E-02  1.9935E-02
 RELATIVEINF(%)  4.1006E+01  9.5836E+01  9.4816E+01  9.9647E+01  9.9965E+01  1.0000E+02
 EPSSHRINKSD(%)  1.2299E+01
 EPSSHRINKVR(%)  2.3085E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -35519.9459467963     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -20816.9294155215     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2445
 NIND*NETA*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    4493.60942737092     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -35519.9459467963     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -31026.3365194254     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 PRIOR CONSTANT TO OBJECTIVE FUNCTION:    74.4768831102865     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -35519.9459467963     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -35445.4690636860     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:  2001.21
 Elapsed covariance  time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 #OBJT:**************                       AVERAGE VALUE OF LIKELIHOOD FUNCTION                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -35519.946       **************************************************
 #OBJS:********************************************       85.296 (STD) **************************************************
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
+        9.86E-03
 
 ETA2
+        1.13E-04  9.64E-03
 
 ETA3
+        4.99E-04  6.21E-04  9.59E-03
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  3.95E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -5.78E-03  3.41E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  2.94E-02 -6.25E-03  6.20E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.00E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.92E-02
 
 ETA2
+        1.14E-02  9.81E-02
 
 ETA3
+        5.09E-02  6.45E-02  9.79E-02
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.96E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -1.53E-01  1.82E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  5.83E-01 -1.32E-01  2.45E-01
 


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
 
         4.97E-02  4.52E-02  6.25E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        7.88E-04
 
 ETA2
+        5.29E-04  4.88E-04
 
 ETA3
+        5.58E-04  3.62E-04  5.27E-04
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.52E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  9.68E-03  1.34E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  1.57E-02  1.21E-02  2.45E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        5.53E-05
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        3.96E-03
 
 ETA2
+        5.41E-02  2.48E-03
 
 ETA3
+        5.67E-02  3.72E-02  2.68E-03
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  3.57E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  2.28E-01  3.34E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  1.64E-01  2.26E-01  4.59E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.05E-04
 
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
+        2.47E-03
 
 TH 2
+       -3.14E-04  2.04E-03
 
 TH 3
+        1.78E-03 -3.34E-04  3.91E-03
 
 OM11
+        1.14E-07  6.43E-07  1.09E-06  6.21E-07
 
 OM12
+        2.72E-07 -7.86E-08  6.34E-07  4.30E-08  2.79E-07
 
 OM13
+        7.28E-07  4.04E-07  2.99E-07  9.75E-08  3.07E-08  3.11E-07
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -1.33E-07  7.34E-08 -1.14E-06 -4.76E-10  1.05E-08 -5.74E-09  0.00E+00  0.00E+00  0.00E+00  2.38E-07
 
 OM23
+        1.35E-07  3.77E-07 -4.11E-07 -8.37E-09  1.46E-08 -5.44E-10  0.00E+00  0.00E+00  0.00E+00  2.83E-08  1.31E-07
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        4.15E-07  4.17E-07 -1.13E-07  1.21E-08 -3.52E-09  1.74E-08  0.00E+00  0.00E+00  0.00E+00  2.17E-09  2.13E-08  0.00E+00
          0.00E+00  0.00E+00  2.78E-07
 
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
+        6.17E-06  2.81E-05  3.06E-05 -1.16E-07 -2.34E-08 -1.75E-07  0.00E+00  0.00E+00  0.00E+00  2.88E-07  1.53E-07  0.00E+00
          0.00E+00  0.00E+00  4.30E-07  0.00E+00  0.00E+00  0.00E+00  2.32E-04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        4.01E-06 -2.25E-05 -1.68E-05  1.24E-08  1.65E-07 -8.33E-09  0.00E+00  0.00E+00  0.00E+00  1.85E-07  9.99E-08  0.00E+00
          0.00E+00  0.00E+00 -1.32E-07  0.00E+00  0.00E+00  0.00E+00 -3.37E-05  9.37E-05
 
 OM46
+       -6.12E-06  2.78E-05 -1.89E-06  5.25E-08 -4.92E-08 -4.37E-08  0.00E+00  0.00E+00  0.00E+00  1.21E-07  2.40E-08  0.00E+00
          0.00E+00  0.00E+00  5.58E-07  0.00E+00  0.00E+00  0.00E+00  1.72E-04 -3.18E-05  2.46E-04
 
 OM55
+        3.05E-05 -1.05E-05  2.95E-05 -2.06E-07  7.18E-08  1.01E-07  0.00E+00  0.00E+00  0.00E+00 -1.20E-07 -2.83E-07  0.00E+00
          0.00E+00  0.00E+00  2.70E-09  0.00E+00  0.00E+00  0.00E+00  1.64E-05 -2.87E-05  7.84E-06  1.79E-04
 
 OM56
+        4.11E-06 -2.14E-05 -2.82E-05 -1.12E-07  1.93E-07  5.13E-08  0.00E+00  0.00E+00  0.00E+00  1.04E-07  2.06E-07  0.00E+00
          0.00E+00  0.00E+00 -1.28E-07  0.00E+00  0.00E+00  0.00E+00 -2.74E-05  7.13E-05 -3.75E-05 -3.55E-05  1.46E-04
 
 OM66
+       -1.25E-05  1.93E-05 -2.71E-05  5.25E-07  1.25E-07 -4.24E-07  0.00E+00  0.00E+00  0.00E+00  2.26E-07 -9.72E-08  0.00E+00
          0.00E+00  0.00E+00  7.94E-07  0.00E+00  0.00E+00  0.00E+00  1.41E-04 -2.96E-05  2.83E-04  1.54E-05 -5.14E-05  6.02E-04
 
 SG11
+        7.96E-08 -1.87E-08 -8.34E-08 -1.20E-09 -1.31E-09 -2.30E-10  0.00E+00  0.00E+00  0.00E+00  9.93E-10  1.02E-10  0.00E+00
          0.00E+00  0.00E+00 -2.28E-11  0.00E+00  0.00E+00  0.00E+00  7.19E-09 -1.13E-08 -8.87E-09  2.13E-08 -3.88E-09 -1.71E-08
         3.05E-09
 
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
+        4.97E-02
 
 TH 2
+       -1.40E-01  4.52E-02
 
 TH 3
+        5.74E-01 -1.18E-01  6.25E-02
 
 OM11
+        2.91E-03  1.81E-02  2.22E-02  7.88E-04
 
 OM12
+        1.03E-02 -3.29E-03  1.92E-02  1.03E-01  5.29E-04
 
 OM13
+        2.62E-02  1.60E-02  8.58E-03  2.22E-01  1.04E-01  5.58E-04
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -5.47E-03  3.33E-03 -3.73E-02 -1.24E-03  4.05E-02 -2.11E-02  0.00E+00  0.00E+00  0.00E+00  4.88E-04
 
 OM23
+        7.47E-03  2.30E-02 -1.82E-02 -2.93E-02  7.62E-02 -2.69E-03  0.00E+00  0.00E+00  0.00E+00  1.60E-01  3.62E-04
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        1.58E-02  1.75E-02 -3.43E-03  2.92E-02 -1.26E-02  5.93E-02  0.00E+00  0.00E+00  0.00E+00  8.42E-03  1.12E-01  0.00E+00
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
+        8.14E-03  4.09E-02  3.21E-02 -9.71E-03 -2.90E-03 -2.06E-02  0.00E+00  0.00E+00  0.00E+00  3.88E-02  2.78E-02  0.00E+00
          0.00E+00  0.00E+00  5.37E-02  0.00E+00  0.00E+00  0.00E+00  1.52E-02
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        8.33E-03 -5.15E-02 -2.77E-02  1.63E-03  3.23E-02 -1.54E-03  0.00E+00  0.00E+00  0.00E+00  3.93E-02  2.85E-02  0.00E+00
          0.00E+00  0.00E+00 -2.58E-02  0.00E+00  0.00E+00  0.00E+00 -2.29E-01  9.68E-03
 
 OM46
+       -7.85E-03  3.93E-02 -1.93E-03  4.25E-03 -5.94E-03 -5.00E-03  0.00E+00  0.00E+00  0.00E+00  1.59E-02  4.22E-03  0.00E+00
          0.00E+00  0.00E+00  6.75E-02  0.00E+00  0.00E+00  0.00E+00  7.23E-01 -2.10E-01  1.57E-02
 
 OM55
+        4.58E-02 -1.74E-02  3.54E-02 -1.95E-02  1.02E-02  1.35E-02  0.00E+00  0.00E+00  0.00E+00 -1.84E-02 -5.83E-02  0.00E+00
          0.00E+00  0.00E+00  3.83E-04  0.00E+00  0.00E+00  0.00E+00  8.08E-02 -2.22E-01  3.74E-02  1.34E-02
 
 OM56
+        6.83E-03 -3.92E-02 -3.73E-02 -1.17E-02  3.02E-02  7.61E-03  0.00E+00  0.00E+00  0.00E+00  1.77E-02  4.71E-02  0.00E+00
          0.00E+00  0.00E+00 -2.01E-02  0.00E+00  0.00E+00  0.00E+00 -1.49E-01  6.09E-01 -1.98E-01 -2.20E-01  1.21E-02
 
 OM66
+       -1.02E-02  1.74E-02 -1.77E-02  2.72E-02  9.67E-03 -3.10E-02  0.00E+00  0.00E+00  0.00E+00  1.89E-02 -1.09E-02  0.00E+00
          0.00E+00  0.00E+00  6.14E-02  0.00E+00  0.00E+00  0.00E+00  3.78E-01 -1.25E-01  7.35E-01  4.70E-02 -1.73E-01  2.45E-02
 
 SG11
+        2.90E-02 -7.50E-03 -2.41E-02 -2.76E-02 -4.48E-02 -7.45E-03  0.00E+00  0.00E+00  0.00E+00  3.68E-02  5.10E-03  0.00E+00
          0.00E+00  0.00E+00 -7.83E-04  0.00E+00  0.00E+00  0.00E+00  8.55E-03 -2.11E-02 -1.02E-02  2.89E-02 -5.81E-03 -1.27E-02
         5.53E-05
 
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
+        6.12E+02
 
 TH 2
+        4.78E+01  5.04E+02
 
 TH 3
+       -2.77E+02  2.20E+01  3.87E+02
 
 OM11
+        4.55E+02 -4.84E+02 -6.66E+02  1.71E+06
 
 OM12
+        1.92E+02  1.61E+02 -6.53E+02 -2.10E+05  3.69E+06
 
 OM13
+       -1.34E+03 -6.41E+02  5.05E+02 -5.19E+05 -3.09E+05  3.44E+06
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -7.64E+02  9.10E+01  1.54E+03 -1.80E+04 -1.24E+05  8.35E+04  0.00E+00  0.00E+00  0.00E+00  4.35E+06
 
 OM23
+       -1.35E+03 -1.39E+03  1.02E+03  1.42E+05 -4.19E+05  2.95E+04  0.00E+00  0.00E+00  0.00E+00 -9.08E+05  8.02E+06
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+       -9.64E+02 -5.18E+02  4.72E+02 -5.32E+04  1.07E+05 -2.05E+05  0.00E+00  0.00E+00  0.00E+00  3.71E+04 -6.21E+05  0.00E+00
          0.00E+00  0.00E+00  3.69E+06
 
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
+        2.15E+01 -3.58E+01 -8.25E+01 -4.55E+02 -2.10E+03  8.10E+03  0.00E+00  0.00E+00  0.00E+00 -9.89E+03 -7.69E+03  0.00E+00
          0.00E+00  0.00E+00 -2.35E+03  0.00E+00  0.00E+00  0.00E+00  1.04E+04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -3.91E+01  9.18E+01  1.99E+01 -9.76E+02 -4.33E+03  2.16E+03  0.00E+00  0.00E+00  0.00E+00 -1.15E+04  1.88E+03  0.00E+00
          0.00E+00  0.00E+00  2.39E+03  0.00E+00  0.00E+00  0.00E+00  1.44E+03  1.78E+04
 
 OM46
+       -8.17E+00 -3.19E+01  4.46E+01  4.14E+03  4.67E+03 -1.31E+04  0.00E+00  0.00E+00  0.00E+00  7.36E+03  2.56E+03  0.00E+00
          0.00E+00  0.00E+00 -2.65E+03  0.00E+00  0.00E+00  0.00E+00 -9.63E+03  4.72E+02  1.81E+04
 
 OM55
+       -7.39E+01  3.99E+01  7.11E+00  2.97E+03 -3.47E+03 -3.15E+03  0.00E+00  0.00E+00  0.00E+00  1.21E+03  1.14E+04  0.00E+00
          0.00E+00  0.00E+00  1.66E+02  0.00E+00  0.00E+00  0.00E+00 -6.25E+02  1.13E+03  8.35E+02  6.05E+03
 
 OM56
+       -6.19E+01  3.35E+01  7.82E+01  2.29E+03 -3.22E+03 -2.49E+03  0.00E+00  0.00E+00  0.00E+00  3.46E+03 -8.71E+03  0.00E+00
          0.00E+00  0.00E+00  6.80E+02  0.00E+00  0.00E+00  0.00E+00 -6.34E+02 -8.12E+03  6.27E+02  9.19E+02  1.12E+04
 
 OM66
+       -8.50E+00  1.60E+01  1.74E+01 -3.48E+03 -3.06E+03  7.45E+03  0.00E+00  0.00E+00  0.00E+00 -3.16E+03  2.16E+03  0.00E+00
          0.00E+00  0.00E+00 -3.11E+03  0.00E+00  0.00E+00  0.00E+00  2.13E+03 -4.02E+02 -6.19E+03 -2.73E+02  3.83E+02  4.11E+03
 
 SG11
+       -2.26E+04  2.47E+03  1.74E+04  4.86E+05  1.51E+06 -5.17E+04  0.00E+00  0.00E+00  0.00E+00 -1.39E+06 -9.06E+04  0.00E+00
          0.00E+00  0.00E+00  6.94E+04  0.00E+00  0.00E+00  0.00E+00 -3.17E+04  4.70E+04  3.85E+04 -3.35E+04 -1.42E+04  6.07E+02
         3.31E+08
 
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
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    0
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
 RAW OUTPUT FILE (FILE): superid3_21.ext
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
 Center Level Etas about 0 (LEVCENTER):0
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

 
0ITERATION NO.:    0    OBJECTIVE VALUE:  -17172.1445774866        NO. OF FUNC. EVALS.:  17
 CUMULATIVE NO. OF FUNC. EVALS.:       17
 NPARAMETR:  1.7980E-01 -5.3140E+00 -3.0820E+00  9.8638E-03  1.1332E-04  4.9865E-04  9.6351E-03  6.2077E-04  9.5876E-03  3.9520E-02
            -5.7775E-03  2.9416E-02  3.4113E-02 -6.2497E-03  6.1973E-02  2.9960E-03
 PARAMETER:  1.0000E-01 -1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
            -1.0000E-01  1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:  -2.1203E+01 -1.1990E+03  1.0104E+02  2.0728E+01 -7.2567E-02 -6.1270E+00  3.8289E+01  1.2701E+00  3.0631E+01  4.5274E+01
            -2.6087E+01  1.6324E+02  1.2529E+02  3.7036E-01  1.1113E+02 -1.0347E+01
 
0ITERATION NO.:    5    OBJECTIVE VALUE:  -17189.7403908228        NO. OF FUNC. EVALS.: 110
 CUMULATIVE NO. OF FUNC. EVALS.:      127
 NPARAMETR:  1.6458E-01 -5.3131E+00 -3.0877E+00  9.3701E-03  1.1053E-04  5.2641E-04  8.8708E-03  5.8710E-04  9.0368E-03  3.5066E-02
            -3.7669E-03  2.7064E-02  2.5341E-02 -4.6129E-03  5.2793E-02  2.9896E-03
 PARAMETER:  9.1536E-02 -9.9983E-02 -1.0019E-01  7.4330E-02  1.0007E-01  1.0831E-01  5.8674E-02  9.8433E-02  7.0039E-02  4.0214E-02
            -6.9216E-02  9.7671E-02 -4.4143E-02 -1.0107E-01 -1.4423E-02  9.8932E-02
 GRADIENT:  -3.0911E+02 -1.1108E+03  5.7861E+01 -5.0029E+00  2.9776E-01 -2.1227E+00 -6.3984E+01  4.0888E+00 -3.0926E+01  1.6596E+01
             1.4015E+01 -1.2341E+01 -9.5918E+00  1.1264E+00  3.3678E+01 -4.6153E+01
 
0ITERATION NO.:   10    OBJECTIVE VALUE:  -17194.6152571818        NO. OF FUNC. EVALS.:  93
 CUMULATIVE NO. OF FUNC. EVALS.:      220
 NPARAMETR:  1.7921E-01 -5.3139E+00 -3.0826E+00  9.9484E-03  1.1361E-04  5.5611E-04  9.5755E-03  6.3386E-04  9.5289E-03  3.2086E-02
            -4.2394E-03  2.8225E-02  2.4983E-02 -5.3562E-03  5.0754E-02  3.0020E-03
 PARAMETER:  9.9676E-02 -9.9998E-02 -1.0002E-01  1.0427E-01  9.9821E-02  1.1105E-01  9.6899E-02  1.0234E-01  9.6503E-02 -4.1942E-03
            -8.1435E-02  1.0649E-01 -5.4557E-02 -9.7411E-02 -1.1846E-01  1.0100E-01
 GRADIENT:  -3.3556E+01 -1.4247E+03 -4.4140E+01 -1.0911E+00 -8.7850E-02  1.8267E+00 -3.9583E+00 -5.4497E-01  3.2156E-01 -5.1075E+00
            -3.5029E-01  7.5780E+01 -4.8526E+00 -1.9759E+00  1.1368E-01  9.0750E+00
 
0ITERATION NO.:   15    OBJECTIVE VALUE:  -17194.6400512003        NO. OF FUNC. EVALS.:  94
 CUMULATIVE NO. OF FUNC. EVALS.:      314
 NPARAMETR:  1.7952E-01 -5.3138E+00 -3.0825E+00  9.9517E-03  1.3097E-04  4.0787E-04  9.5632E-03  5.9055E-04  9.5140E-03  3.1566E-02
            -4.2075E-03  2.7812E-02  2.5062E-02 -5.1635E-03  5.0531E-02  3.0020E-03
 PARAMETER:  9.9847E-02 -9.9995E-02 -1.0002E-01  1.0444E-01  1.1506E-01  8.1433E-02  9.6232E-02  9.5505E-02  9.6756E-02 -1.2358E-02
            -8.1485E-02  1.0579E-01 -5.2953E-02 -8.7058E-02 -1.1610E-01  1.0099E-01
 GRADIENT:  -2.6428E+01 -1.2155E+03 -4.2839E+01 -5.2737E-01  2.7012E-02 -8.2845E-01 -3.9130E+00 -2.0134E+00  1.4001E+00 -8.3056E+00
             8.4593E-01  6.0240E+01 -3.5169E+00 -9.2132E-01  1.5405E+00  8.1924E+00
 
0ITERATION NO.:   20    OBJECTIVE VALUE:  -17194.8092964034        NO. OF FUNC. EVALS.:  91
 CUMULATIVE NO. OF FUNC. EVALS.:      405
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8605E-03  1.3851E-04  5.0607E-04  9.6029E-03  6.3496E-04  9.5230E-03  3.2451E-02
            -4.3271E-03  2.7565E-02  2.5235E-02 -5.1151E-03  4.9928E-02  2.9998E-03
 PARAMETER:  1.0055E-01 -9.9978E-02 -1.0000E-01  9.9835E-02  1.2224E-01  1.0151E-01  9.8296E-02  1.0226E-01  9.6465E-02  1.4689E-03
            -8.2650E-02  1.0341E-01 -4.9753E-02 -8.5777E-02 -1.0674E-01  1.0063E-01
 GRADIENT:  -1.1839E-02 -1.1195E+01 -2.0408E+00 -1.1030E-02 -5.5444E-03 -7.9565E-04  3.4051E-03  1.2683E-02  2.2650E-02 -1.3591E-02
            -2.8183E-02 -1.0823E-01  2.0344E-02  6.4101E-03 -2.8028E-02  3.8964E-02
 
0ITERATION NO.:   25    OBJECTIVE VALUE:  -17194.8093198058        NO. OF FUNC. EVALS.: 131
 CUMULATIVE NO. OF FUNC. EVALS.:      536
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8608E-03  1.3993E-04  5.0663E-04  9.6033E-03  6.3461E-04  9.5227E-03  3.2454E-02
            -4.3280E-03  2.7567E-02  2.5234E-02 -5.1156E-03  4.9932E-02  2.9998E-03
 PARAMETER:  1.0055E-01 -9.9978E-02 -9.9999E-02  9.9850E-02  1.2350E-01  1.0162E-01  9.8314E-02  1.0218E-01  9.6450E-02  1.5153E-03
            -8.2664E-02  1.0341E-01 -4.9789E-02 -8.5773E-02 -1.0668E-01  1.0063E-01
 GRADIENT:  -2.6333E-02 -3.8540E+00 -7.6081E-01 -2.3168E-03  2.6135E-04  7.1194E-03  4.5471E-03 -3.7661E-03  7.9730E-03 -5.0349E-03
            -7.3199E-03  2.1410E-02  3.4687E-03  3.6807E-03 -1.6669E-03 -7.2361E-03
 
0ITERATION NO.:   26    OBJECTIVE VALUE:  -17194.8093198058        NO. OF FUNC. EVALS.:   0
 CUMULATIVE NO. OF FUNC. EVALS.:      536
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8608E-03  1.3993E-04  5.0663E-04  9.6033E-03  6.3461E-04  9.5227E-03  3.2454E-02
            -4.3280E-03  2.7567E-02  2.5234E-02 -5.1156E-03  4.9932E-02  2.9998E-03
 PARAMETER:  1.0055E-01 -9.9978E-02 -9.9999E-02  9.9850E-02  1.2350E-01  1.0162E-01  9.8314E-02  1.0218E-01  9.6450E-02  1.5153E-03
            -8.2664E-02  1.0341E-01 -4.9789E-02 -8.5773E-02 -1.0668E-01  1.0063E-01
 GRADIENT:  -2.6333E-02 -3.8540E+00 -7.6081E-01 -2.3168E-03  2.6135E-04  7.1194E-03  4.5471E-03 -3.7661E-03  7.9730E-03 -5.0349E-03
            -7.3199E-03  2.1410E-02  3.4687E-03  3.6807E-03 -1.6669E-03 -7.2361E-03
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      536
 NO. OF SIG. DIGITS IN FINAL EST.:  3.3

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         4.3273E-05 -4.8518E-05 -5.0913E-05 -1.8352E-03 -1.2481E-04 -1.9325E-04
 SE:             2.2444E-03  3.3920E-03  3.3554E-03  4.2888E-02  3.9227E-02  5.5279E-02
 N:                     800         800         800          16          16          16
 
 P VAL.:         9.8462E-01  9.8859E-01  9.8789E-01  9.6587E-01  9.9746E-01  9.9721E-01
 
 ETASHRINKSD(%)  3.6072E+01  2.0992E+00  2.7469E+00  1.6501E+00  1.0000E-10  1.0000E-10
 ETASHRINKVR(%)  5.9133E+01  4.1544E+00  5.4184E+00  3.2729E+00  1.0000E-10  1.0000E-10
 EBVSHRINKSD(%)  3.5998E+01  2.0801E+00  2.7416E+00  5.5756E-02  1.5669E-02  1.0315E-02
 EBVSHRINKVR(%)  5.9038E+01  4.1170E+00  5.4081E+00  1.1148E-01  3.1336E-02  2.0628E-02
 RELATIVEINF(%)  4.0935E+01  9.5861E+01  9.4816E+01  9.9799E+01  9.9965E+01  9.9970E+01
 EPSSHRINKSD(%)  1.2282E+01
 EPSSHRINKVR(%)  2.3056E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -17194.8093198058     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -2491.79278853106     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2448
  
 #TERE:
 Elapsed estimation  time in seconds:   720.02
 Elapsed covariance  time in seconds:   164.91
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -17194.809       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         1.81E-01 -5.31E+00 -3.08E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.86E-03
 
 ETA2
+        1.40E-04  9.60E-03
 
 ETA3
+        5.07E-04  6.35E-04  9.52E-03
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  3.25E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -4.33E-03  2.52E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  2.76E-02 -5.12E-03  4.99E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.00E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.93E-02
 
 ETA2
+        1.44E-02  9.80E-02
 
 ETA3
+        5.23E-02  6.64E-02  9.76E-02
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.80E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -1.51E-01  1.59E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  6.85E-01 -1.44E-01  2.23E-01
 


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
 
         4.32E-02  3.93E-02  5.46E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        8.60E-04
 
 ETA2
+        5.31E-04  5.03E-04
 
 ETA3
+        5.91E-04  3.59E-04  5.05E-04
 
 ETA4
+       ......... ......... .........  1.24E-02
 
 ETA5
+       ......... ......... .........  7.75E-03  9.08E-03
 
 ETA6
+       ......... ......... .........  1.29E-02  9.16E-03  1.80E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        5.48E-05
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        4.33E-03
 
 ETA2
+        5.44E-02  2.57E-03
 
 ETA3
+        6.04E-02  3.71E-02  2.59E-03
 
 ETA4
+       ......... ......... .........  3.43E-02
 
 ETA5
+       ......... ......... .........  2.65E-01  2.86E-02
 
 ETA6
+       ......... ......... .........  1.42E-01  2.53E-01  4.02E-02
 


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
+        1.87E-03
 
 TH 2
+       -3.56E-04  1.54E-03
 
 TH 3
+        1.56E-03 -3.90E-04  2.98E-03
 
 OM11
+       -2.54E-08  1.39E-08  8.63E-09  7.39E-07
 
 OM12
+       -1.76E-07 -4.85E-08 -9.50E-08  5.09E-08  2.82E-07
 
 OM13
+        2.50E-07  7.44E-08  1.43E-07  9.48E-08  3.63E-08  3.49E-07
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        5.60E-09  6.19E-09  8.10E-09  2.46E-09  2.28E-08  2.68E-09 ......... ......... .........  2.53E-07
 
 OM23
+       -3.38E-10  3.10E-10  1.90E-10  3.47E-09  1.92E-08  1.33E-08 ......... ......... .........  2.90E-08  1.29E-07
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        1.99E-08  5.52E-09  1.01E-08  5.17E-09  3.94E-09  3.54E-08 ......... ......... .........  3.36E-09  2.84E-08 .........
         ......... .........  2.55E-07
 
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
+        1.09E-05 -1.20E-06  7.80E-06  5.68E-08  9.09E-09  9.76E-09 ......... ......... ......... -7.68E-10  6.83E-10 .........
         ......... ......... -1.52E-09 ......... ......... .........  1.53E-04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -9.30E-07  3.26E-06 -1.01E-06  4.30E-09  1.69E-08  1.62E-09 ......... ......... .........  6.47E-09  1.97E-10 .........
         ......... .........  3.57E-11 ......... ......... ......... -1.59E-05  6.01E-05
 
 OM46
+        5.95E-06 -8.35E-07  7.95E-06  6.88E-09  1.10E-09  2.08E-08 ......... ......... ......... -6.98E-10  3.15E-09 .........
         ......... ......... -8.26E-10 ......... ......... .........  1.26E-04 -1.67E-05  1.66E-04
 
 OM55
+       -1.57E-07  8.34E-07 -3.20E-08 -3.03E-10  4.82E-09  5.09E-12 ......... ......... .........  6.08E-09  1.48E-09 .........
         ......... ......... -7.97E-11 ......... ......... .........  1.66E-06 -9.32E-06  1.85E-06  8.25E-05
 
 OM56
+        1.48E-07  4.87E-07  3.34E-07 -1.47E-09  3.35E-09  2.70E-09 ......... ......... .........  3.61E-09  2.27E-09 .........
         ......... .........  1.14E-09 ......... ......... ......... -1.25E-05  4.90E-05 -1.81E-05 -1.28E-05  8.39E-05
 
 OM66
+        1.61E-06 -4.82E-07  2.55E-06 -6.03E-09 -1.54E-09  7.98E-09 ......... ......... ......... -5.99E-10  3.18E-09 .........
         ......... .........  2.50E-09 ......... ......... .........  1.03E-04 -1.64E-05  1.86E-04  2.26E-06 -2.66E-05  3.24E-04
 
 SG11
+        4.44E-09  4.11E-09  5.54E-09 -1.97E-09 -6.69E-10 -7.64E-10 ......... ......... ......... -4.38E-10 -4.66E-10 .........
         ......... ......... -5.21E-10 ......... ......... .........  8.79E-09  4.48E-09  8.75E-09  2.16E-09  4.52E-09  8.44E-09
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
+        4.32E-02
 
 TH 2
+       -2.10E-01  3.93E-02
 
 TH 3
+        6.60E-01 -1.82E-01  5.46E-02
 
 OM11
+       -6.84E-04  4.12E-04  1.84E-04  8.60E-04
 
 OM12
+       -7.67E-03 -2.33E-03 -3.28E-03  1.12E-01  5.31E-04
 
 OM13
+        9.78E-03  3.20E-03  4.43E-03  1.87E-01  1.16E-01  5.91E-04
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        2.57E-04  3.13E-04  2.95E-04  5.69E-03  8.52E-02  9.02E-03 ......... ......... .........  5.03E-04
 
 OM23
+       -2.18E-05  2.19E-05  9.68E-06  1.12E-02  1.01E-01  6.26E-02 ......... ......... .........  1.60E-01  3.59E-04
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        9.14E-04  2.78E-04  3.66E-04  1.19E-02  1.47E-02  1.19E-01 ......... ......... .........  1.32E-02  1.57E-01 .........
         ......... .........  5.05E-04
 
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
+        2.03E-02 -2.47E-03  1.15E-02  5.35E-03  1.39E-03  1.34E-03 ......... ......... ......... -1.23E-04  1.54E-04 .........
         ......... ......... -2.43E-04 ......... ......... .........  1.24E-02
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -2.77E-03  1.07E-02 -2.39E-03  6.45E-04  4.10E-03  3.53E-04 ......... ......... .........  1.66E-03  7.08E-05 .........
         ......... .........  9.12E-06 ......... ......... ......... -1.66E-01  7.75E-03
 
 OM46
+        1.07E-02 -1.65E-03  1.13E-02  6.21E-04  1.61E-04  2.73E-03 ......... ......... ......... -1.08E-04  6.80E-04 .........
         ......... ......... -1.27E-04 ......... ......... .........  7.90E-01 -1.67E-01  1.29E-02
 
 OM55
+       -4.01E-04  2.34E-03 -6.46E-05 -3.88E-05  1.00E-03  9.48E-07 ......... ......... .........  1.33E-03  4.55E-04 .........
         ......... ......... -1.74E-05 ......... ......... .........  1.48E-02 -1.32E-01  1.58E-02  9.08E-03
 
 OM56
+        3.74E-04  1.35E-03  6.68E-04 -1.86E-04  6.89E-04  4.99E-04 ......... ......... .........  7.82E-04  6.90E-04 .........
         ......... .........  2.47E-04 ......... ......... ......... -1.10E-01  6.89E-01 -1.53E-01 -1.54E-01  9.16E-03
 
 OM66
+        2.07E-03 -6.83E-04  2.60E-03 -3.90E-04 -1.61E-04  7.51E-04 ......... ......... ......... -6.61E-05  4.92E-04 .........
         ......... .........  2.76E-04 ......... ......... .........  4.62E-01 -1.18E-01  8.02E-01  1.38E-02 -1.61E-01  1.80E-02
 
 SG11
+        1.88E-03  1.91E-03  1.85E-03 -4.19E-02 -2.30E-02 -2.36E-02 ......... ......... ......... -1.59E-02 -2.37E-02 .........
         ......... ......... -1.89E-02 ......... ......... .........  1.30E-02  1.05E-02  1.24E-02  4.35E-03  9.01E-03  8.56E-03
         5.48E-05
 
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
+        9.64E+02
 
 TH 2
+        9.87E+01  6.81E+02
 
 TH 3
+       -4.91E+02  3.75E+01  5.96E+02
 
 OM11
+        8.26E+01  5.77E+00 -3.71E+01  1.42E+06
 
 OM12
+        5.22E+02  2.29E+02 -1.11E+02 -2.10E+05  3.68E+06
 
 OM13
+       -5.91E+02 -2.58E+02  1.23E+02 -3.65E+05 -3.11E+05  3.04E+06
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -4.92E+01 -3.77E+01 -1.17E+00  6.95E+03 -2.73E+05  2.52E+04 ......... ......... .........  4.07E+06
 
 OM23
+       -1.13E+01 -6.21E+00  2.87E+00  2.67E+04 -4.57E+05 -1.76E+05 ......... ......... ......... -8.87E+05  8.23E+06
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        1.47E+01  7.02E+00 -2.01E+00  2.37E+04  4.59E+04 -3.90E+05 ......... ......... .........  4.66E+04 -8.73E+05 .........
         ......... .........  4.08E+06
 
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
+       -1.05E+02 -6.55E+00  5.65E+01 -1.60E+03 -6.34E+02  1.23E+03 ......... ......... ......... -1.17E+01  3.26E+02 .........
         ......... ......... -2.08E+02 ......... ......... .........  2.24E+04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -8.62E+00 -6.27E+01  2.73E+00 -3.15E+02 -1.82E+03  1.10E+02 ......... ......... ......... -5.15E+02  5.39E+02 .........
         ......... .........  1.84E+01 ......... ......... .........  1.39E+03  3.24E+04
 
 OM46
+        9.03E+01 -4.72E+00 -8.71E+01  1.58E+03  4.81E+02 -2.15E+03 ......... ......... ......... -1.97E+01 -5.48E+02 .........
         ......... .........  4.77E+02 ......... ......... ......... -2.52E+04  1.52E+03  4.56E+04
 
 OM55
+        6.54E-01 -8.92E+00 -1.43E+00 -7.75E+00 -2.71E+02 -7.64E+00 ......... ......... ......... -3.24E+02 -1.03E+02 .........
         ......... ......... -7.79E+00 ......... ......... ......... -1.50E+01  7.47E+02  6.26E+01  1.24E+04
 
 OM56
+        2.47E+00  3.04E+01 -4.44E+00  1.62E+02  8.57E+02 -2.09E+02 ......... ......... .........  8.19E+01 -5.64E+02 .........
         ......... ......... -6.57E+01 ......... ......... ......... -5.57E+02 -1.86E+04 -5.74E+02  1.48E+03  2.33E+04
 
 OM66
+       -1.96E+01  4.44E+00  2.97E+01 -3.90E+02 -8.45E+01  7.47E+02 ......... ......... .........  1.39E+00  9.71E+01 .........
         ......... ......... -2.38E+02 ......... ......... .........  7.39E+03 -1.21E+03 -1.81E+04  4.22E+01  1.47E+03  1.12E+04
 
 SG11
+       -5.35E+02 -1.09E+03 -4.35E+02  8.01E+05  5.03E+05  3.77E+05 ......... ......... .........  4.16E+05  8.69E+05 .........
         ......... .........  5.05E+05 ......... ......... ......... -1.50E+04 -2.64E+04 -8.86E+03 -1.27E+04 -9.02E+03 -8.51E+02
         3.34E+08
 
 Elapsed finaloutput time in seconds:     0.11
 #CPUT: Total CPU Time in Seconds,     3078.929
Stop Time: 
Sat 12/14/2019 
09:54 AM
