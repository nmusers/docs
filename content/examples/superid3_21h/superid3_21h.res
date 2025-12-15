Wed 02/03/2021 
11:58 AM
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
     LEVCENTER=0 LEVOBJTYPE=1
$EST METHOD=1 PRINT=1 NSIG=3 SIGL=10 FNLETA=0 SLOW NONINFETA=1 NOPRIOR=1
     LEVCENTER=0 LEVOBJTYPE=1 MAXEVAL=9999
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
  
Note: Analytical 2nd Derivatives are constructed in FSUBS but are never used.
      You may insert $ABBR DERIV2=NO after the first $PROB to save FSUBS construction and compilation time
  
  
License Registered to: NONMEM license (with RADAR5NM) for ICON Pharmacometrics Team
Expiration Date:    31 DEC 2030
Current Date:        3 FEB 2021
Days until program expires :3613
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.1
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
1DOUBLE PRECISION PREDPP VERSION 7.5.1

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
 RAW OUTPUT FILE (FILE): superid3_21h.ext
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
 Level OBJECTIVE FUNCTION TYPE (LEVOBJTYPE):1
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

 iteration            0 OBJ=  -450.686530955961
 iteration            1 OBJ=  -4238.78465274780
 iteration            2 OBJ=  -6205.51399658358
 iteration            3 OBJ=  -8027.52659452551
 iteration            4 OBJ=  -9789.41636498357
 iteration            5 OBJ=  -11513.6685746254
 iteration            6 OBJ=  -13203.5859209228
 iteration            7 OBJ=  -14852.1907774977
 iteration            8 OBJ=  -16429.5304004747
 iteration            9 OBJ=  -17820.7099404075
 iteration           10 OBJ=  -18615.2300050467
 iteration           11 OBJ=  -18649.1611802510
 iteration           12 OBJ=  -18650.7993607602
 iteration           13 OBJ=  -18651.1343531117
 iteration           14 OBJ=  -18651.2846979545
 iteration           15 OBJ=  -18651.3524070503
 iteration           16 OBJ=  -18651.3822040445
 iteration           17 OBJ=  -18651.3946769505
 iteration           18 OBJ=  -18651.3993679711
 iteration           19 OBJ=  -18651.4006890559
 iteration           20 OBJ=  -18651.4006546077
 iteration           21 OBJ=  -18651.4001592928
 iteration           22 OBJ=  -18651.3995803996
 iteration           23 OBJ=  -18651.3990602733
 iteration           24 OBJ=  -18651.3986389522
 iteration           25 OBJ=  -18651.3983156954
 iteration           26 OBJ=  -18651.3980750142
 iteration           27 OBJ=  -18651.3978992858
 iteration           28 OBJ=  -18651.3977726801
 iteration           29 OBJ=  -18651.3976821030
 iteration           30 OBJ=  -18651.3976176691
 iteration           31 OBJ=  -18651.3975720694
 iteration           32 OBJ=  -18651.3975397581
 iteration           33 OBJ=  -18651.3975170395
 iteration           34 OBJ=  -18651.3975010010
 iteration           35 OBJ=  -18651.3974897195
 iteration           36 OBJ=  -18651.3974818327
 iteration           37 OBJ=  -18651.3974761855
 iteration           38 OBJ=  -18651.3974723079
 iteration           39 OBJ=  -18651.3974695694
 Convergence achieved
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.0496E-04 -3.3463E-05 -3.6423E-05  1.8469E-07 -5.6652E-07 -5.5114E-07
 SE:             2.2446E-03  3.3919E-03  3.3556E-03  4.2784E-02  3.9226E-02  5.5270E-02
 N:                     800         800         800          16          16          16
 
 P VAL.:         9.6270E-01  9.9213E-01  9.9134E-01  1.0000E+00  9.9999E-01  9.9999E-01
 
 ETASHRINKSD(%)  3.6005E+01  2.0796E+00  2.7399E+00  7.8635E-06  5.1639E-06  5.3017E-06
 ETASHRINKVR(%)  5.9046E+01  4.1160E+00  5.4047E+00  1.5727E-05  1.0328E-05  1.0603E-05
 EBVSHRINKSD(%)  3.6004E+01  2.0796E+00  2.7399E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  5.9046E+01  4.1160E+00  5.4047E+00  0.0000E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  4.0925E+01  9.5857E+01  9.4824E+01  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  1.2254E+01
 EPSSHRINKVR(%)  2.3006E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -18651.3974695694     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -3948.38093829464     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2445
  
 #TERE:
 Elapsed estimation  time in seconds:    55.91
 Elapsed covariance  time in seconds:     0.24
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -18651.397       **************************************************
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
+        5.11E-04  6.35E-04  9.52E-03
 
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
+        8.97E-04
 
 ETA2
+        5.34E-04  5.11E-04
 
 ETA3
+        6.68E-04  3.78E-04  5.18E-04
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.32E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  1.48E-02  1.85E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  2.04E-02  1.40E-02  3.24E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        5.57E-05
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        4.52E-03
 
 ETA2
+        5.49E-02  2.61E-03
 
 ETA3
+        6.84E-02  3.90E-02  2.65E-03
 
 ETA4
+       ......... ......... .........  3.75E-02
 
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
+       -5.39E-04  3.53E-03
 
 TH 3
+        3.18E-03 -2.80E-04  8.36E-03
 
 OM11
+       -4.90E-08 -3.43E-06 -1.70E-06  8.04E-07
 
 OM12
+       -2.27E-06 -8.12E-08 -2.34E-06  3.45E-08  2.85E-07
 
 OM13
+       -2.07E-06 -6.82E-07 -7.11E-07  7.51E-08  5.57E-08  4.46E-07
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.11E-06  8.70E-07  1.51E-06  4.12E-09  1.93E-08  1.44E-08  0.00E+00  0.00E+00  0.00E+00  2.61E-07
 
 OM23
+       -7.52E-07  7.49E-07  8.54E-07  1.11E-08  2.57E-08  2.70E-08  0.00E+00  0.00E+00  0.00E+00  4.18E-08  1.43E-07
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        1.69E-06 -1.97E-06  7.36E-07  4.07E-08  1.18E-08  6.85E-08  0.00E+00  0.00E+00  0.00E+00  1.14E-08  2.45E-08  0.00E+00
          0.00E+00  0.00E+00  2.68E-07
 
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
+        2.91E-04  1.52E-04  4.48E-04 -9.06E-07 -7.59E-08 -5.50E-08  0.00E+00  0.00E+00  0.00E+00  7.68E-08 -1.57E-07  0.00E+00
          0.00E+00  0.00E+00 -8.25E-08  0.00E+00  0.00E+00  0.00E+00  1.75E-04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        2.21E-04 -5.42E-05  9.49E-04  9.73E-08 -2.51E-07  3.53E-07  0.00E+00  0.00E+00  0.00E+00  4.02E-07  6.01E-08  0.00E+00
          0.00E+00  0.00E+00  1.56E-07  0.00E+00  0.00E+00  0.00E+00  2.23E-05  2.20E-04
 
 OM46
+        1.31E-04  6.84E-04  2.58E-04 -7.85E-07 -1.56E-07 -3.45E-07  0.00E+00  0.00E+00  0.00E+00  4.50E-07 -3.49E-08  0.00E+00
          0.00E+00  0.00E+00 -6.54E-07  0.00E+00  0.00E+00  0.00E+00  1.88E-04 -3.57E-05  4.18E-04
 
 OM55
+       -4.94E-05  1.12E-04 -7.91E-04 -1.81E-07  1.82E-07 -8.97E-07  0.00E+00  0.00E+00  0.00E+00 -5.08E-07  4.74E-08  0.00E+00
          0.00E+00  0.00E+00  7.28E-08  0.00E+00  0.00E+00  0.00E+00  8.96E-06 -1.90E-04  3.51E-05  3.44E-04
 
 OM56
+        3.22E-04 -2.60E-04  5.10E-04  3.08E-08 -2.51E-07 -2.72E-08  0.00E+00  0.00E+00  0.00E+00 -1.97E-08 -2.20E-07  0.00E+00
          0.00E+00  0.00E+00  2.15E-07  0.00E+00  0.00E+00  0.00E+00 -1.62E-05  1.47E-04 -1.29E-04 -1.19E-04  1.96E-04
 
 OM66
+       -1.62E-05  8.30E-04  3.17E-04 -6.34E-07 -5.48E-07 -5.80E-07  0.00E+00  0.00E+00  0.00E+00  8.72E-07  4.67E-08  0.00E+00
          0.00E+00  0.00E+00 -9.04E-07  0.00E+00  0.00E+00  0.00E+00  2.30E-04 -5.74E-05  5.97E-04  6.12E-06 -2.40E-04  1.05E-03
 
 SG11
+        4.81E-08  1.13E-07 -1.64E-07 -4.17E-09 -8.22E-10 -3.28E-09  0.00E+00  0.00E+00  0.00E+00 -1.85E-09 -1.75E-09  0.00E+00
          0.00E+00  0.00E+00 -2.45E-09  0.00E+00  0.00E+00  0.00E+00  3.84E-08 -3.08E-08  4.90E-08  8.11E-08 -8.34E-09  9.62E-09
         3.10E-09
 
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
+        6.01E-01 -5.16E-02  9.14E-02
 
 OM11
+       -9.45E-04 -6.44E-02 -2.07E-02  8.97E-04
 
 OM12
+       -7.34E-02 -2.56E-03 -4.80E-02  7.21E-02  5.34E-04
 
 OM13
+       -5.37E-02 -1.72E-02 -1.17E-02  1.25E-01  1.56E-01  6.68E-04
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -7.13E-02  2.86E-02  3.24E-02  9.00E-03  7.07E-02  4.23E-02  0.00E+00  0.00E+00  0.00E+00  5.11E-04
 
 OM23
+       -3.44E-02  3.34E-02  2.47E-02  3.28E-02  1.28E-01  1.07E-01  0.00E+00  0.00E+00  0.00E+00  2.16E-01  3.78E-04
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        5.65E-02 -6.41E-02  1.56E-02  8.76E-02  4.26E-02  1.98E-01  0.00E+00  0.00E+00  0.00E+00  4.32E-02  1.25E-01  0.00E+00
          0.00E+00  0.00E+00  5.18E-04
 
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
+        3.80E-01  1.93E-01  3.70E-01 -7.63E-02 -1.07E-02 -6.22E-03  0.00E+00  0.00E+00  0.00E+00  1.14E-02 -3.13E-02  0.00E+00
          0.00E+00  0.00E+00 -1.20E-02  0.00E+00  0.00E+00  0.00E+00  1.32E-02
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        2.58E-01 -6.14E-02  7.00E-01  7.31E-03 -3.17E-02  3.56E-02  0.00E+00  0.00E+00  0.00E+00  5.30E-02  1.07E-02  0.00E+00
          0.00E+00  0.00E+00  2.04E-02  0.00E+00  0.00E+00  0.00E+00  1.14E-01  1.48E-02
 
 OM46
+        1.11E-01  5.63E-01  1.38E-01 -4.28E-02 -1.43E-02 -2.53E-02  0.00E+00  0.00E+00  0.00E+00  4.31E-02 -4.51E-03  0.00E+00
          0.00E+00  0.00E+00 -6.18E-02  0.00E+00  0.00E+00  0.00E+00  6.93E-01 -1.18E-01  2.04E-02
 
 OM55
+       -4.60E-02  1.02E-01 -4.66E-01 -1.09E-02  1.84E-02 -7.25E-02  0.00E+00  0.00E+00  0.00E+00 -5.37E-02  6.77E-03  0.00E+00
          0.00E+00  0.00E+00  7.59E-03  0.00E+00  0.00E+00  0.00E+00  3.65E-02 -6.90E-01  9.26E-02  1.85E-02
 
 OM56
+        3.97E-01 -3.13E-01  3.99E-01  2.46E-03 -3.36E-02 -2.91E-03  0.00E+00  0.00E+00  0.00E+00 -2.75E-03 -4.17E-02  0.00E+00
          0.00E+00  0.00E+00  2.97E-02  0.00E+00  0.00E+00  0.00E+00 -8.75E-02  7.09E-01 -4.52E-01 -4.60E-01  1.40E-02
 
 OM66
+       -8.67E-03  4.31E-01  1.07E-01 -2.18E-02 -3.16E-02 -2.68E-02  0.00E+00  0.00E+00  0.00E+00  5.27E-02  3.82E-03  0.00E+00
          0.00E+00  0.00E+00 -5.39E-02  0.00E+00  0.00E+00  0.00E+00  5.37E-01 -1.19E-01  9.02E-01  1.02E-02 -5.30E-01  3.24E-02
 
 SG11
+        1.49E-02  3.41E-02 -3.22E-02 -8.35E-02 -2.76E-02 -8.82E-02  0.00E+00  0.00E+00  0.00E+00 -6.51E-02 -8.32E-02  0.00E+00
          0.00E+00  0.00E+00 -8.49E-02  0.00E+00  0.00E+00  0.00E+00  5.20E-02 -3.73E-02  4.30E-02  7.86E-02 -1.07E-02  5.33E-03
         5.57E-05
 
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
+       -4.58E+02  2.91E+01  5.31E+02
 
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
+        5.85E+03  1.16E+03 -2.18E+03  7.89E+03 -1.56E+05 -1.10E+04  0.00E+00  0.00E+00  0.00E+00  4.11E+06
 
 OM23
+        2.45E+02 -1.98E+03 -2.41E+03 -8.92E+03 -5.32E+05 -2.66E+05  0.00E+00  0.00E+00  0.00E+00 -1.12E+06  7.69E+06
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+       -4.76E+03  4.22E+02  2.02E+03 -1.22E+05 -1.93E+03 -5.53E+05  0.00E+00  0.00E+00  0.00E+00 -9.26E+04 -5.37E+05  0.00E+00
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
+        4.68E+01  8.35E+02  7.18E+01  7.70E+02  1.07E+04  7.17E+03  0.00E+00  0.00E+00  0.00E+00 -1.39E+03  1.08E+03  0.00E+00
          0.00E+00  0.00E+00 -2.78E+03  0.00E+00  0.00E+00  0.00E+00  3.30E+03 -3.15E+03 -1.33E+04  1.20E+03  5.53E+03  8.21E+03
 
 SG11
+        3.29E+02  4.30E+03  9.90E+03  1.35E+06  1.84E+05  1.58E+06  0.00E+00  0.00E+00  0.00E+00  1.61E+06  2.71E+06  0.00E+00
          0.00E+00  0.00E+00  2.08E+06  0.00E+00  0.00E+00  0.00E+00 -2.49E+04 -6.43E+04 -1.48E+05 -7.47E+04 -6.91E+03  7.75E+04
         3.34E+08
 
1
 
 
 #TBLN:      2
 #METH: First Order Conditional Estimation with Interaction (No Prior)
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               SLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            9999
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
 RAW OUTPUT FILE (FILE): superid3_21h.ext
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
 Level OBJECTIVE FUNCTION TYPE (LEVOBJTYPE):1
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

 
0ITERATION NO.:    0    OBJECTIVE VALUE:  -18662.1093781973        NO. OF FUNC. EVALS.:  17
 CUMULATIVE NO. OF FUNC. EVALS.:       17
 NPARAMETR:  1.7879E-01 -5.3130E+00 -3.0822E+00  9.8419E-03  1.3233E-04  5.1055E-04  9.5993E-03  6.3503E-04  9.5224E-03  3.1240E-02
            -5.6194E-03  2.7277E-02  2.6260E-02 -6.2883E-03  5.2135E-02  2.9979E-03
 PARAMETER:  1.0000E-01 -1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
            -1.0000E-01  1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:  -9.1857E+00 -1.0509E+02  3.4513E+01 -2.1177E+00 -1.8989E-01 -2.1595E-02 -1.1980E+00 -1.0485E-01 -2.5822E-01 -3.7668E+00
            -7.2564E+00 -4.4994E+00 -6.5284E-01 -3.4831E-01  1.7276E+00 -1.2371E+00
 
0ITERATION NO.:    1    OBJECTIVE VALUE:  -18662.1108076253        NO. OF FUNC. EVALS.:  25
 CUMULATIVE NO. OF FUNC. EVALS.:       42
 NPARAMETR:  1.7880E-01 -5.3105E+00 -3.0827E+00  9.8419E-03  1.3233E-04  5.1055E-04  9.5993E-03  6.3503E-04  9.5224E-03  3.1240E-02
            -5.6192E-03  2.7277E-02  2.6260E-02 -6.2883E-03  5.2136E-02  2.9979E-03
 PARAMETER:  1.0000E-01 -9.9953E-02 -1.0002E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
            -9.9997E-02  1.0000E-01  1.0000E-01 -1.0000E-01  9.9999E-02  1.0000E-01
 GRADIENT:  -7.0063E+00  6.9821E+01  2.3271E+01 -2.0225E+00 -2.0202E-01 -6.4538E-02 -1.2101E+00 -9.4136E-02 -2.7005E-01 -3.7023E+00
            -7.2323E+00 -4.4737E+00 -6.1115E-01 -3.3854E-01  1.7347E+00 -1.2065E+00
 
0ITERATION NO.:    2    OBJECTIVE VALUE:  -18662.1111135453        NO. OF FUNC. EVALS.:  25
 CUMULATIVE NO. OF FUNC. EVALS.:       67
 NPARAMETR:  1.7882E-01 -5.3107E+00 -3.0841E+00  9.8420E-03  1.3233E-04  5.1055E-04  9.5994E-03  6.3503E-04  9.5225E-03  3.1241E-02
            -5.6185E-03  2.7279E-02  2.6259E-02 -6.2880E-03  5.2139E-02  2.9979E-03
 PARAMETER:  1.0002E-01 -9.9956E-02 -1.0006E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0001E-01
            -9.9984E-02  1.0001E-01  1.0000E-01 -9.9999E-02  9.9996E-02  1.0000E-01
 GRADIENT:  -4.7047E+00  5.2960E+01 -2.7561E+01 -2.0439E+00 -2.0941E-01 -7.8973E-02 -1.1302E+00 -1.2173E-01 -2.7399E-01 -3.6963E+00
            -7.2598E+00 -4.4911E+00 -6.8238E-01 -3.1032E-01  1.7482E+00 -1.1549E+00
 
0ITERATION NO.:    3    OBJECTIVE VALUE:  -18662.1486927314        NO. OF FUNC. EVALS.:  21
 CUMULATIVE NO. OF FUNC. EVALS.:       88
 NPARAMETR:  1.8535E-01 -5.3126E+00 -3.0787E+00  9.8648E-03  1.3263E-04  5.1131E-04  9.6119E-03  6.3585E-04  9.5254E-03  3.1371E-02
            -5.4013E-03  2.8024E-02  2.6198E-02 -6.2050E-03  5.3298E-02  3.0019E-03
 PARAMETER:  1.0367E-01 -9.9993E-02 -9.9887E-02  1.0116E-01  1.0011E-01  1.0003E-01  1.0065E-01  1.0006E-01  1.0015E-01  1.0209E-01
            -9.5919E-02  1.0253E-01  1.0037E-01 -9.9816E-02  9.9022E-02  1.0067E-01
 GRADIENT:   8.6549E+00  2.2396E+01 -3.9119E+01 -6.4265E-01 -1.6383E-01 -1.1423E-01  7.8724E-01 -1.1392E-01  2.7628E-01 -4.1805E+00
            -6.5391E+00  2.3947E+00 -5.8763E-01 -2.9445E-01  1.6695E+00  1.4887E+01
 
0ITERATION NO.:    4    OBJECTIVE VALUE:  -18662.1613831919        NO. OF FUNC. EVALS.:  21
 CUMULATIVE NO. OF FUNC. EVALS.:      109
 NPARAMETR:  1.8659E-01 -5.3130E+00 -3.0777E+00  9.8734E-03  1.3275E-04  5.1162E-04  9.6149E-03  6.3613E-04  9.5259E-03  3.1435E-02
            -5.3021E-03  2.8228E-02  2.6170E-02 -6.1401E-03  5.3587E-02  2.9962E-03
 PARAMETER:  1.0436E-01 -1.0000E-01 -9.9856E-02  1.0160E-01  1.0016E-01  1.0005E-01  1.0081E-01  1.0009E-01  1.0018E-01  1.0311E-01
            -9.4060E-02  1.0317E-01  1.0054E-01 -9.9731E-02  9.8569E-02  9.9715E-02
 GRADIENT:   1.1261E+01  1.3742E+01 -4.4304E+01 -3.5640E-01 -2.1994E-01 -1.7137E-01  1.2273E+00 -1.9900E-01  2.8634E-01 -4.1567E+00
            -6.2198E+00  4.1178E+00 -5.2556E-01 -2.4003E-01  1.6506E+00 -8.0142E+00
 
0ITERATION NO.:    5    OBJECTIVE VALUE:  -18662.3377963544        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      128
 NPARAMETR:  1.8009E-01 -5.3121E+00 -3.0837E+00  9.9926E-03  1.3479E-04  5.1698E-04  9.6225E-03  6.4031E-04  9.5257E-03  3.2636E-02
            -3.5531E-03  2.9438E-02  2.5803E-02 -4.5676E-03  5.4341E-02  2.9984E-03
 PARAMETER:  1.0073E-01 -9.9983E-02 -1.0005E-01  1.0760E-01  1.0109E-01  1.0049E-01  1.0120E-01  1.0070E-01  1.0013E-01  1.2185E-01
            -6.1863E-02  1.0559E-01  1.0330E-01 -9.8279E-02  9.0543E-02  1.0008E-01
 GRADIENT:  -7.8296E-01 -1.8629E+01 -5.4115E+01  6.9517E+00 -1.2841E-01 -1.5920E-01  2.6848E+00  3.8312E-01  3.5973E-01 -2.5997E+00
            -1.4910E+00  7.2460E+00 -1.1386E-01 -1.7328E-01  1.3255E+00  1.2883E+00
 
0ITERATION NO.:    6    OBJECTIVE VALUE:  -18662.3846136521        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      147
 NPARAMETR:  1.8468E-01 -5.3135E+00 -3.0801E+00  9.9221E-03  1.3488E-04  5.1653E-04  9.5873E-03  6.3840E-04  9.5206E-03  3.3200E-02
            -2.8667E-03  2.8423E-02  2.5714E-02 -3.8089E-03  5.1907E-02  2.9987E-03
 PARAMETER:  1.0329E-01 -1.0001E-01 -9.9932E-02  1.0406E-01  1.0151E-01  1.0076E-01  9.9370E-02  1.0057E-01  9.9858E-02  1.3042E-01
            -4.9486E-02  1.0108E-01  1.0429E-01 -9.7609E-02  8.6689E-02  1.0013E-01
 GRADIENT:   7.7262E+00 -7.1855E+01 -6.5103E+01  3.4763E+00 -1.0542E-01  7.7734E-03 -2.7880E+00  4.1933E-01 -5.7257E-01 -8.3304E-01
            -3.2673E-01 -6.7276E+00 -1.2632E-01 -2.2477E-01  9.6041E-01  1.0714E+00
 
0ITERATION NO.:    7    OBJECTIVE VALUE:  -18662.3898554258        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      166
 NPARAMETR:  1.8291E-01 -5.3129E+00 -3.0815E+00  9.7332E-03  1.3411E-04  5.1254E-04  9.6138E-03  6.3404E-04  9.5281E-03  3.3642E-02
            -2.4529E-03  2.9395E-02  2.5674E-02 -3.4882E-03  5.3050E-02  2.9994E-03
 PARAMETER:  1.0230E-01 -9.9999E-02 -9.9979E-02  9.4444E-02  1.0191E-01  1.0095E-01  1.0075E-01  9.9736E-02  1.0028E-01  1.3703E-01
            -4.2063E-02  1.0385E-01  1.0485E-01 -9.6852E-02  8.2909E-02  1.0026E-01
 GRADIENT:   4.7093E+00 -4.9881E+01 -6.4340E+01 -6.8527E+00  2.2125E-02  7.3354E-01  1.5431E+00 -2.1923E-01  7.8657E-01 -1.0191E+00
             8.5917E-01 -7.4785E-02 -5.5257E-02 -6.6117E-02  8.8541E-01  2.2031E+00
 
0ITERATION NO.:    8    OBJECTIVE VALUE:  -18662.3900958661        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      185
 NPARAMETR:  1.8260E-01 -5.3130E+00 -3.0818E+00  9.7256E-03  1.3432E-04  5.0412E-04  9.5686E-03  6.2630E-04  9.5016E-03  3.4026E-02
            -2.6022E-03  3.0030E-02  2.5682E-02 -3.6300E-03  5.3607E-02  2.9997E-03
 PARAMETER:  1.0213E-01 -9.9999E-02 -9.9988E-02  9.4053E-02  1.0211E-01  9.9330E-02  9.8394E-02  9.8754E-02  9.8969E-02  1.4271E-01
            -4.4372E-02  1.0549E-01  1.0461E-01 -9.6039E-02  7.8101E-02  1.0030E-01
 GRADIENT:   4.2133E+00 -5.3444E+01 -6.6211E+01 -7.2096E+00  4.0693E-02  4.7845E-01 -5.3543E+00 -4.3487E-01 -3.0717E+00 -9.6354E-01
             5.0937E-01  2.7080E+00 -1.3694E-01 -1.9653E-01  5.2466E-01  2.4832E+00
 
0ITERATION NO.:    9    OBJECTIVE VALUE:  -18662.4038295817        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      204
 NPARAMETR:  1.8261E-01 -5.3131E+00 -3.0815E+00  9.7297E-03  1.3485E-04  4.8774E-04  9.5878E-03  6.1515E-04  9.5096E-03  3.4817E-02
            -2.9475E-03  3.0595E-02  2.5707E-02 -3.8980E-03  5.3471E-02  2.9999E-03
 PARAMETER:  1.0213E-01 -1.0000E-01 -9.9979E-02  9.4265E-02  1.0249E-01  9.6083E-02  9.9395E-02  9.6911E-02  9.9562E-02  1.5420E-01
            -4.9686E-02  1.0625E-01  1.0411E-01 -9.4252E-02  6.8473E-02  1.0034E-01
 GRADIENT:   3.8734E+00 -6.2470E+01 -5.8754E+01 -6.6829E+00  9.6013E-03  2.1657E-02 -2.2145E+00 -1.7747E+00 -1.2025E+00 -1.9954E-01
            -1.6096E-01  1.5573E+00 -1.4714E-01 -1.5039E-01 -6.2493E-02  3.3250E+00
 
0ITERATION NO.:   10    OBJECTIVE VALUE:  -18662.4049845998        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      223
 NPARAMETR:  1.8264E-01 -5.3132E+00 -3.0815E+00  9.7274E-03  1.3513E-04  4.8782E-04  9.5933E-03  6.3663E-04  9.5093E-03  3.4999E-02
            -3.0380E-03  3.0741E-02  2.5711E-02 -3.9643E-03  5.3466E-02  2.9999E-03
 PARAMETER:  1.0215E-01 -1.0000E-01 -9.9978E-02  9.4149E-02  1.0272E-01  9.6109E-02  9.9681E-02  1.0030E-01  9.9401E-02  1.5681E-01
            -5.1078E-02  1.0648E-01  1.0392E-01 -9.3407E-02  6.6226E-02  1.0033E-01
 GRADIENT:   3.9384E+00 -6.5015E+01 -5.8834E+01 -6.7733E+00  3.1344E-03 -7.4553E-02 -1.8332E+00  3.9684E-01 -1.9782E+00 -2.5107E-02
            -3.2157E-01  1.4701E+00 -1.9944E-01 -1.5790E-01 -2.8216E-01  3.5047E+00
 
0ITERATION NO.:   11    OBJECTIVE VALUE:  -18662.4050883596        NO. OF FUNC. EVALS.:  21
 CUMULATIVE NO. OF FUNC. EVALS.:      244
 NPARAMETR:  1.8263E-01 -5.3132E+00 -3.0815E+00  9.7277E-03  1.3519E-04  4.8871E-04  9.5911E-03  6.3715E-04  9.5139E-03  3.5006E-02
            -3.0423E-03  3.0755E-02  2.5712E-02 -3.9669E-03  5.3481E-02  2.9999E-03
 PARAMETER:  1.0215E-01 -1.0000E-01 -9.9979E-02  9.4161E-02  1.0276E-01  9.6283E-02  9.9565E-02  1.0039E-01  9.9631E-02  1.5691E-01
            -5.1145E-02  1.0651E-01  1.0391E-01 -9.3271E-02  6.6151E-02  1.0033E-01
 GRADIENT:   3.9971E+00 -6.4961E+01 -5.8967E+01 -6.7130E+00 -1.1223E-03 -2.0344E-02 -2.1328E+00  4.3003E-01 -1.2914E+00 -1.8107E-03
            -2.3228E-01  1.6098E+00 -2.0095E-01 -1.2363E-01 -1.8570E-01  3.5631E+00
 
0ITERATION NO.:   12    OBJECTIVE VALUE:  -18662.4059077770        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      263
 NPARAMETR:  1.8266E-01 -5.3132E+00 -3.0815E+00  9.7330E-03  1.3618E-04  5.0415E-04  9.5919E-03  6.3684E-04  9.5123E-03  3.5042E-02
            -3.0762E-03  3.0777E-02  2.5718E-02 -3.9691E-03  5.3444E-02  2.9999E-03
 PARAMETER:  1.0216E-01 -1.0000E-01 -9.9977E-02  9.4436E-02  1.0349E-01  9.9299E-02  9.9606E-02  1.0030E-01  9.9468E-02  1.5743E-01
            -5.1689E-02  1.0654E-01  1.0393E-01 -9.1341E-02  6.5296E-02  1.0033E-01
 GRADIENT:   3.9495E+00 -6.2697E+01 -5.7998E+01 -6.5861E+00  7.5734E-02  5.0051E-01 -1.9986E+00  3.1242E-01 -1.7053E+00  7.3857E-02
            -3.5754E-01  1.5234E+00 -1.2476E-01 -9.0651E-02 -2.0733E-01  3.5875E+00
 
0ITERATION NO.:   13    OBJECTIVE VALUE:  -18662.4102359443        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      281
 NPARAMETR:  1.8252E-01 -5.3129E+00 -3.0812E+00  9.7477E-03  1.3930E-04  5.0332E-04  9.5901E-03  6.3603E-04  9.5130E-03  3.4731E-02
            -2.9900E-03  3.0511E-02  2.5554E-02 -3.7150E-03  5.2953E-02  2.9997E-03
 PARAMETER:  1.0209E-01 -9.9999E-02 -9.9968E-02  9.5189E-02  1.0578E-01  9.9060E-02  9.9507E-02  1.0016E-01  9.9522E-02  1.5296E-01
            -5.0464E-02  1.0609E-01  1.0094E-01 -7.8676E-02  6.0567E-02  1.0030E-01
 GRADIENT:   2.9972E+00 -4.6971E+01 -4.3498E+01 -5.9220E+00  5.9321E-02  3.4535E-01 -2.3508E+00  2.2222E-01 -1.5797E+00 -2.1017E-01
            -1.9918E-01  1.4285E+00 -3.4670E-01 -3.7915E-02 -5.4680E-01  3.1678E+00
 
0ITERATION NO.:   14    OBJECTIVE VALUE:  -18662.4140090121        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      299
 NPARAMETR:  1.8250E-01 -5.3129E+00 -3.0809E+00  9.7588E-03  1.4202E-04  4.9376E-04  9.5939E-03  6.3513E-04  9.4994E-03  3.4733E-02
            -2.9910E-03  3.0467E-02  2.5617E-02 -3.5536E-03  5.2986E-02  2.9998E-03
 PARAMETER:  1.0207E-01 -9.9998E-02 -9.9957E-02  9.5761E-02  1.0778E-01  9.7123E-02  9.9703E-02  9.9994E-02  9.8859E-02  1.5300E-01
            -5.0479E-02  1.0593E-01  1.0219E-01 -6.7152E-02  6.2974E-02  1.0031E-01
 GRADIENT:   2.3597E+00 -4.3466E+01 -3.0153E+01 -5.1423E+00  1.3649E-01 -3.0450E-03 -1.7837E+00  2.2738E-01 -3.4662E+00 -7.8935E-02
            -2.0143E-01  8.8722E-01 -2.5021E-01  9.5446E-02 -3.9525E-01  3.3086E+00
 
0ITERATION NO.:   15    OBJECTIVE VALUE:  -18662.4181824538        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      317
 NPARAMETR:  1.8225E-01 -5.3128E+00 -3.0812E+00  9.7792E-03  1.3809E-04  4.9169E-04  9.5925E-03  6.3598E-04  9.5075E-03  3.4532E-02
            -2.9800E-03  3.0277E-02  2.6113E-02 -3.5492E-03  5.2700E-02  2.9996E-03
 PARAMETER:  1.0193E-01 -9.9997E-02 -9.9969E-02  9.6803E-02  1.0469E-01  9.6615E-02  9.9633E-02  1.0018E-01  9.9296E-02  1.5008E-01
            -5.0440E-02  1.0558E-01  1.1188E-01 -6.6960E-02  6.0904E-02  1.0028E-01
 GRADIENT:   2.1347E+00 -4.0681E+01 -3.5148E+01 -4.0413E+00 -2.4290E-03 -1.0175E-01 -1.9444E+00  2.8603E-01 -2.1744E+00 -3.0634E-01
            -1.8844E-01  5.5019E-01  3.5389E-01  7.4408E-02 -5.0570E-01  2.7720E+00
 
0ITERATION NO.:   16    OBJECTIVE VALUE:  -18662.4296003967        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      336
 NPARAMETR:  1.8205E-01 -5.3125E+00 -3.0808E+00  9.8244E-03  1.3060E-04  5.0022E-04  9.6036E-03  6.3436E-04  9.5074E-03  3.4606E-02
            -2.9657E-03  3.0266E-02  2.5876E-02 -3.6616E-03  5.2841E-02  2.9991E-03
 PARAMETER:  1.0182E-01 -9.9990E-02 -9.9954E-02  9.9111E-02  9.8784E-02  9.8065E-02  1.0022E-01  9.9906E-02  9.9263E-02  1.5116E-01
            -5.0144E-02  1.0543E-01  1.0732E-01 -7.6706E-02  6.4848E-02  1.0019E-01
 GRADIENT:   7.9327E-01 -1.5840E+01 -1.1010E+01 -1.4604E+00 -3.6252E-02  4.4536E-02 -6.5976E-02  1.0231E-01 -2.2436E+00 -7.3100E-02
            -5.2994E-02 -8.0233E-02  1.2210E-01  3.1541E-02 -2.6197E-01  1.2892E+00
 
0ITERATION NO.:   17    OBJECTIVE VALUE:  -18662.4307497114        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      355
 NPARAMETR:  1.8198E-01 -5.3124E+00 -3.0808E+00  9.8320E-03  1.4335E-04  4.9544E-04  9.6036E-03  6.3558E-04  9.5147E-03  3.4578E-02
            -2.9709E-03  3.0237E-02  2.5884E-02 -3.7284E-03  5.2830E-02  2.9988E-03
 PARAMETER:  1.0178E-01 -9.9988E-02 -9.9957E-02  9.9498E-02  1.0839E-01  9.7089E-02  1.0021E-01  1.0001E-01  9.9671E-02  1.5075E-01
            -5.0252E-02  1.0537E-01  1.0747E-01 -8.1195E-02  6.5068E-02  1.0014E-01
 GRADIENT:   6.4145E-01 -9.8847E+00 -1.2438E+01 -1.1450E+00  3.8801E-02 -1.9257E-01 -3.1487E-01  7.3341E-02 -1.0928E+00 -1.8246E-01
            -1.3530E-01 -2.9002E-01  7.5451E-02 -6.1002E-02 -2.8010E-01  2.7956E-01
 
0ITERATION NO.:   18    OBJECTIVE VALUE:  -18662.4321879650        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      373
 NPARAMETR:  1.8187E-01 -5.3122E+00 -3.0806E+00  9.8477E-03  1.3846E-04  4.9830E-04  9.6044E-03  6.3488E-04  9.5180E-03  3.4675E-02
            -3.0157E-03  3.0323E-02  2.5813E-02 -3.7703E-03  5.2995E-02  2.9987E-03
 PARAMETER:  1.0172E-01 -9.9986E-02 -9.9949E-02  1.0029E-01  1.0460E-01  9.7572E-02  1.0026E-01  9.9929E-02  9.9837E-02  1.5216E-01
            -5.0940E-02  1.0552E-01  1.0595E-01 -8.1503E-02  6.6764E-02  1.0013E-01
 GRADIENT:  -1.1405E-01 -1.5972E+00  6.1140E-01 -2.6720E-01 -2.4004E-02 -1.2775E-01  1.6060E-02  5.7469E-02 -5.9182E-01 -4.0914E-02
            -2.4229E-01 -1.6948E-01  6.9430E-03 -3.5867E-02 -1.6353E-01 -2.2835E-02
 
0ITERATION NO.:   19    OBJECTIVE VALUE:  -18662.4325790862        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      391
 NPARAMETR:  1.8186E-01 -5.3122E+00 -3.0806E+00  9.8564E-03  1.4146E-04  5.0044E-04  9.6056E-03  6.3449E-04  9.5198E-03  3.4690E-02
            -2.9577E-03  3.0332E-02  2.5782E-02 -3.7269E-03  5.3071E-02  2.9986E-03
 PARAMETER:  1.0171E-01 -9.9985E-02 -9.9947E-02  1.0073E-01  1.0683E-01  9.7949E-02  1.0032E-01  9.9833E-02  9.9923E-02  1.5238E-01
            -4.9949E-02  1.0553E-01  1.0553E-01 -8.2097E-02  6.8122E-02  1.0011E-01
 GRADIENT:  -1.8979E-01  2.3943E+00  2.3609E+00  1.7692E-01  2.1731E-02 -8.4136E-02  1.3880E-01 -5.6330E-02 -3.6276E-01  2.7845E-02
            -8.4652E-02 -1.7676E-01 -4.7740E-02 -2.3323E-02 -1.4687E-01 -2.4466E-01
 
0ITERATION NO.:   20    OBJECTIVE VALUE:  -18662.4326681958        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      409
 NPARAMETR:  1.8186E-01 -5.3122E+00 -3.0805E+00  9.8584E-03  1.4016E-04  5.0238E-04  9.6062E-03  6.3457E-04  9.5202E-03  3.4667E-02
            -2.9227E-03  3.0315E-02  2.5783E-02 -3.7038E-03  5.3172E-02  2.9986E-03
 PARAMETER:  1.0171E-01 -9.9985E-02 -9.9947E-02  1.0084E-01  1.0583E-01  9.8318E-02  1.0035E-01  9.9848E-02  9.9934E-02  1.5204E-01
            -4.9373E-02  1.0550E-01  1.0566E-01 -8.2601E-02  7.0224E-02  1.0012E-01
 GRADIENT:  -2.8818E-01  2.8833E+00  3.0808E+00  3.4773E-01  1.5978E-02 -7.2312E-02  2.6550E-01 -4.9986E-02 -2.3420E-01 -1.1246E-02
            -4.5951E-02 -9.9064E-02  2.8973E-02 -6.2344E-02  8.4587E-02 -1.0534E-01
 
0ITERATION NO.:   21    OBJECTIVE VALUE:  -18662.4328054867        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      428
 NPARAMETR:  1.8189E-01 -5.3122E+00 -3.0805E+00  9.8553E-03  1.3866E-04  5.0358E-04  9.6051E-03  6.3482E-04  9.5212E-03  3.4656E-02
            -2.9159E-03  3.0308E-02  2.5770E-02 -3.6572E-03  5.3140E-02  2.9986E-03
 PARAMETER:  1.0173E-01 -9.9985E-02 -9.9947E-02  1.0068E-01  1.0471E-01  9.8569E-02  1.0029E-01  9.9902E-02  9.9980E-02  1.5188E-01
            -4.9267E-02  1.0550E-01  1.0543E-01 -7.9674E-02  6.9753E-02  1.0012E-01
 GRADIENT:  -1.8837E-01  1.3121E+00  2.0699E+00  1.2865E-01 -1.0850E-02 -6.0012E-02  3.7543E-02 -3.8417E-02 -1.5191E-01 -2.0272E-02
             2.9857E-02 -7.8265E-02 -7.3707E-02 -2.4953E-02  2.9540E-03 -5.8936E-03
 
0ITERATION NO.:   22    OBJECTIVE VALUE:  -18662.4328361215        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      446
 NPARAMETR:  1.8192E-01 -5.3122E+00 -3.0805E+00  9.8538E-03  1.3929E-04  5.0402E-04  9.6046E-03  6.3529E-04  9.5224E-03  3.4662E-02
            -2.9257E-03  3.0319E-02  2.5803E-02 -3.6417E-03  5.3135E-02  2.9986E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9947E-02  1.0060E-01  1.0520E-01  9.8661E-02  1.0026E-01  9.9974E-02  1.0004E-01  1.5197E-01
            -4.9428E-02  1.0552E-01  1.0605E-01 -7.7862E-02  6.9445E-02  1.0012E-01
 GRADIENT:  -5.2650E-02  1.7430E-01  1.0066E+00  3.5210E-02  1.7956E-02 -1.0361E-02 -3.7775E-02  1.6335E-03  4.6778E-02 -5.6643E-02
            -3.5743E-02 -7.3484E-02 -3.2349E-02  3.5987E-02 -4.3896E-02 -2.2989E-02
 
0ITERATION NO.:   23    OBJECTIVE VALUE:  -18662.4328409157        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      464
 NPARAMETR:  1.8192E-01 -5.3122E+00 -3.0806E+00  9.8533E-03  1.3905E-04  5.0413E-04  9.6045E-03  6.3529E-04  9.5225E-03  3.4676E-02
            -2.9244E-03  3.0331E-02  2.5809E-02 -3.6441E-03  5.3145E-02  2.9986E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9947E-02  1.0058E-01  1.0502E-01  9.8686E-02  1.0026E-01  9.9976E-02  1.0004E-01  1.5217E-01
            -4.9396E-02  1.0555E-01  1.0617E-01 -7.8112E-02  6.9439E-02  1.0012E-01
 GRADIENT:  -9.3096E-02 -1.7838E-01  5.5625E-01 -3.8597E-02 -6.2841E-02 -5.2252E-02 -9.5524E-02 -5.9114E-02 -3.0147E-02 -5.0108E-02
            -6.9540E-02 -1.1190E-01 -4.8456E-02 -6.7652E-02 -1.1556E-01 -1.1518E-01
 
0ITERATION NO.:   24    OBJECTIVE VALUE:  -18662.4328423368        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      482
 NPARAMETR:  1.8193E-01 -5.3122E+00 -3.0806E+00  9.8531E-03  1.3903E-04  5.0419E-04  9.6045E-03  6.3531E-04  9.5225E-03  3.4684E-02
            -2.9226E-03  3.0338E-02  2.5812E-02 -3.6430E-03  5.3155E-02  2.9986E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9947E-02  1.0057E-01  1.0501E-01  9.8699E-02  1.0026E-01  9.9980E-02  1.0004E-01  1.5229E-01
            -4.9359E-02  1.0556E-01  1.0624E-01 -7.8138E-02  6.9483E-02  1.0012E-01
 GRADIENT:  -3.4552E-02 -1.5047E-01  3.9888E-01  6.3591E-02 -2.5104E-02  9.0367E-03 -3.4976E-02  3.8148E-02  2.2601E-02 -1.5346E-02
             1.3242E-02 -6.0794E-02 -2.4772E-02 -2.7921E-02 -2.3003E-02 -2.9824E-02
 
0ITERATION NO.:   25    OBJECTIVE VALUE:  -18662.4328424838        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      500
 NPARAMETR:  1.8193E-01 -5.3122E+00 -3.0806E+00  9.8529E-03  1.3906E-04  5.0410E-04  9.6045E-03  6.3527E-04  9.5225E-03  3.4687E-02
            -2.9231E-03  3.0342E-02  2.5814E-02 -3.6434E-03  5.3158E-02  2.9986E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9947E-02  1.0056E-01  1.0503E-01  9.8682E-02  1.0026E-01  9.9974E-02  1.0004E-01  1.5233E-01
            -4.9366E-02  1.0557E-01  1.0627E-01 -7.8131E-02  6.9482E-02  1.0012E-01
 GRADIENT:  -1.2210E-02 -1.2507E-01  2.8800E-01 -1.4413E-02  3.2034E-02 -3.3542E-03 -5.3624E-02  2.7427E-02  5.5486E-02  4.4061E-03
             2.7721E-03 -3.0492E-02  4.1022E-02 -1.3562E-02 -2.3188E-02 -3.3733E-02
 
0ITERATION NO.:   26    OBJECTIVE VALUE:  -18662.4328425362        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      518
 NPARAMETR:  1.8193E-01 -5.3122E+00 -3.0806E+00  9.8528E-03  1.3900E-04  5.0406E-04  9.6045E-03  6.3523E-04  9.5224E-03  3.4689E-02
            -2.9236E-03  3.0343E-02  2.5814E-02 -3.6433E-03  5.3160E-02  2.9987E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9947E-02  1.0055E-01  1.0499E-01  9.8675E-02  1.0026E-01  9.9967E-02  1.0004E-01  1.5236E-01
            -4.9373E-02  1.0557E-01  1.0627E-01 -7.8091E-02  6.9497E-02  1.0012E-01
 GRADIENT:  -1.1945E-02 -1.8067E-01  1.9447E-01 -3.1093E-02  3.2025E-02  9.0695E-03 -5.0634E-02 -5.3660E-03  2.7231E-02 -2.4265E-02
             4.4201E-03  4.1277E-02  3.3893E-02  1.1783E-02 -4.9393E-02 -7.3070E-03
 
0ITERATION NO.:   27    OBJECTIVE VALUE:  -18662.4328425405        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      537
 NPARAMETR:  1.8193E-01 -5.3122E+00 -3.0806E+00  9.8528E-03  1.3899E-04  5.0405E-04  9.6045E-03  6.3522E-04  9.5224E-03  3.4689E-02
            -2.9236E-03  3.0344E-02  2.5814E-02 -3.6433E-03  5.3161E-02  2.9987E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9947E-02  1.0055E-01  1.0498E-01  9.8674E-02  1.0026E-01  9.9966E-02  1.0004E-01  1.5236E-01
            -4.9374E-02  1.0557E-01  1.0628E-01 -7.8087E-02  6.9499E-02  1.0012E-01
 GRADIENT:  -2.1373E-02 -1.8940E-01  2.6332E-01 -2.7812E-02 -2.1790E-02  2.7052E-02 -3.6925E-02  3.3568E-02  2.2710E-02 -1.3123E-02
            -2.0158E-02 -1.7313E-02 -2.6903E-02 -4.7185E-03 -1.5792E-02 -3.9224E-02
 
0ITERATION NO.:   28    OBJECTIVE VALUE:  -18662.4328428867        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      555
 NPARAMETR:  1.8193E-01 -5.3122E+00 -3.0806E+00  9.8528E-03  1.3895E-04  5.0391E-04  9.6045E-03  6.3512E-04  9.5224E-03  3.4691E-02
            -2.9233E-03  3.0345E-02  2.5815E-02 -3.6426E-03  5.3163E-02  2.9987E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9948E-02  1.0055E-01  1.0495E-01  9.8645E-02  1.0026E-01  9.9950E-02  1.0004E-01  1.5238E-01
            -4.9367E-02  1.0557E-01  1.0629E-01 -7.8055E-02  6.9521E-02  1.0012E-01
 GRADIENT:  -1.2113E-02 -1.2224E-01  9.5744E-02  6.5378E-03 -3.3763E-03 -2.3625E-02 -2.4808E-02  3.6762E-02  4.0244E-02  9.8720E-03
             2.3887E-02 -3.1169E-02  7.5028E-03  7.0304E-02  3.3375E-02  5.6519E-02
 
0ITERATION NO.:   29    OBJECTIVE VALUE:  -18662.4328428867        NO. OF FUNC. EVALS.:  32
 CUMULATIVE NO. OF FUNC. EVALS.:      587
 NPARAMETR:  1.8193E-01 -5.3122E+00 -3.0806E+00  9.8528E-03  1.3895E-04  5.0391E-04  9.6045E-03  6.3512E-04  9.5224E-03  3.4691E-02
            -2.9233E-03  3.0345E-02  2.5815E-02 -3.6426E-03  5.3163E-02  2.9987E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9948E-02  1.0055E-01  1.0495E-01  9.8645E-02  1.0026E-01  9.9950E-02  1.0004E-01  1.5238E-01
            -4.9367E-02  1.0557E-01  1.0629E-01 -7.8055E-02  6.9521E-02  1.0012E-01
 GRADIENT:   1.7787E-03 -1.9834E+00 -4.1831E-01 -9.6087E-03 -5.2611E-03  1.0066E-03 -2.2974E-02  1.0883E-02  1.4024E-02 -6.1657E-03
            -5.6731E-03 -1.2843E-02  2.3949E-02  4.3974E-03 -9.1407E-03 -2.8159E-02
 
0ITERATION NO.:   30    OBJECTIVE VALUE:  -18662.4328474961        NO. OF FUNC. EVALS.:  36
 CUMULATIVE NO. OF FUNC. EVALS.:      623
 NPARAMETR:  1.8192E-01 -5.3122E+00 -3.0806E+00  9.8527E-03  1.3916E-04  5.0365E-04  9.6046E-03  6.3492E-04  9.5222E-03  3.4691E-02
            -2.9230E-03  3.0348E-02  2.5807E-02 -3.6428E-03  5.3170E-02  2.9987E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9947E-02  1.0055E-01  1.0510E-01  9.8595E-02  1.0027E-01  9.9916E-02  1.0003E-01  1.5239E-01
            -4.9361E-02  1.0558E-01  1.0614E-01 -7.8088E-02  6.9563E-02  1.0013E-01
 GRADIENT:  -5.5876E-03 -5.0476E-01 -2.0431E-01 -1.0295E-02 -2.5703E-03 -5.9780E-03 -4.5143E-03 -1.0113E-02 -2.5126E-03 -6.8094E-03
            -4.7997E-03  1.0114E-02  1.4580E-02  3.4755E-03 -6.3341E-03 -1.5194E-03
 
0ITERATION NO.:   31    OBJECTIVE VALUE:  -18662.4328489989        NO. OF FUNC. EVALS.:  34
 CUMULATIVE NO. OF FUNC. EVALS.:      657
 NPARAMETR:  1.8193E-01 -5.3122E+00 -3.0805E+00  9.8528E-03  1.3935E-04  5.0348E-04  9.6046E-03  6.3487E-04  9.5221E-03  3.4694E-02
            -2.9225E-03  3.0350E-02  2.5800E-02 -3.6424E-03  5.3171E-02  2.9987E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9947E-02  1.0055E-01  1.0525E-01  9.8562E-02  1.0027E-01  9.9908E-02  1.0003E-01  1.5242E-01
            -4.9352E-02  1.0558E-01  1.0599E-01 -7.8101E-02  6.9559E-02  1.0013E-01
 GRADIENT:  -6.7327E-03  2.2181E-01  2.5744E-02 -9.5939E-03 -5.7069E-04 -1.1975E-02 -4.0240E-03 -1.4781E-02 -6.5823E-03 -5.3502E-03
            -2.9002E-03  7.1741E-03  5.9666E-03  3.5371E-03 -7.2061E-03  8.2366E-03
 
0ITERATION NO.:   32    OBJECTIVE VALUE:  -18662.4328501498        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      676            RESET HESSIAN, TYPE II
 NPARAMETR:  1.8193E-01 -5.3122E+00 -3.0805E+00  9.8528E-03  1.3936E-04  5.0353E-04  9.6046E-03  6.3489E-04  9.5221E-03  3.4694E-02
            -2.9224E-03  3.0350E-02  2.5799E-02 -3.6492E-03  5.3172E-02  2.9987E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9947E-02  1.0055E-01  1.0525E-01  9.8572E-02  1.0027E-01  9.9911E-02  1.0003E-01  1.5243E-01
            -4.9349E-02  1.0558E-01  1.0598E-01 -7.8604E-02  6.9576E-02  1.0013E-01
 GRADIENT:   3.2535E-04  2.0309E+00  5.7113E-01  1.3072E-02  4.0232E-03 -7.0213E-03  3.4622E-02  1.8001E-02  9.1906E-03 -3.8711E-03
            -1.1241E-03  2.2059E-02 -1.7061E-02  2.2515E-02 -4.5227E-02  4.8819E-02
 
0ITERATION NO.:   33    OBJECTIVE VALUE:  -18662.4328501498        NO. OF FUNC. EVALS.:  39
 CUMULATIVE NO. OF FUNC. EVALS.:      715
 NPARAMETR:  1.8193E-01 -5.3122E+00 -3.0805E+00  9.8528E-03  1.3936E-04  5.0353E-04  9.6046E-03  6.3489E-04  9.5221E-03  3.4694E-02
            -2.9224E-03  3.0350E-02  2.5799E-02 -3.6492E-03  5.3172E-02  2.9987E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9947E-02  1.0055E-01  1.0525E-01  9.8572E-02  1.0027E-01  9.9911E-02  1.0003E-01  1.5243E-01
            -4.9349E-02  1.0558E-01  1.0598E-01 -7.8604E-02  6.9576E-02  1.0013E-01
 GRADIENT:  -6.8292E-03  1.8524E-01  1.8888E-02 -7.8607E-03 -1.2286E-03 -1.1110E-02 -3.3068E-03 -1.3278E-02 -5.9580E-03 -4.5533E-03
            -2.8849E-03  5.1166E-03  4.2909E-03 -1.0391E-03 -5.7821E-03  9.4502E-03
 
0ITERATION NO.:   34    OBJECTIVE VALUE:  -18662.4328504979        NO. OF FUNC. EVALS.:  34
 CUMULATIVE NO. OF FUNC. EVALS.:      749
 NPARAMETR:  1.8193E-01 -5.3122E+00 -3.0805E+00  9.8528E-03  1.3939E-04  5.0364E-04  9.6046E-03  6.3494E-04  9.5222E-03  3.4695E-02
            -2.9220E-03  3.0350E-02  2.5797E-02 -3.6440E-03  5.3173E-02  2.9987E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9947E-02  1.0055E-01  1.0528E-01  9.8593E-02  1.0027E-01  9.9918E-02  1.0003E-01  1.5245E-01
            -4.9342E-02  1.0558E-01  1.0594E-01 -7.8256E-02  6.9606E-02  1.0013E-01
 GRADIENT:  -3.7610E-03  1.3144E-01 -1.1350E-02 -7.0704E-03 -8.4927E-04 -8.3590E-03 -3.4700E-03 -9.0091E-03 -4.3884E-03 -2.1591E-03
            -3.9906E-04 -4.0803E-04  1.8304E-03  2.0881E-03 -4.1037E-03  7.0292E-03
 
0ITERATION NO.:   35    OBJECTIVE VALUE:  -18662.4328513645        NO. OF FUNC. EVALS.:  35
 CUMULATIVE NO. OF FUNC. EVALS.:      784
 NPARAMETR:  1.8193E-01 -5.3122E+00 -3.0805E+00  9.8529E-03  1.3945E-04  5.0385E-04  9.6046E-03  6.3503E-04  9.5222E-03  3.4697E-02
            -2.9215E-03  3.0351E-02  2.5794E-02 -3.6464E-03  5.3176E-02  2.9987E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9947E-02  1.0056E-01  1.0532E-01  9.8633E-02  1.0027E-01  9.9931E-02  1.0003E-01  1.5247E-01
            -4.9332E-02  1.0558E-01  1.0590E-01 -7.8474E-02  6.9665E-02  1.0013E-01
 GRADIENT:  -1.1587E-03  1.7268E-02 -4.9306E-02 -4.1263E-03 -5.3324E-04 -1.5053E-03 -4.7407E-03 -2.0217E-03 -9.3144E-04  4.6269E-04
            -6.2310E-04 -7.3475E-03 -1.1480E-03 -4.1897E-04 -4.9801E-04  5.5968E-03
 
0ITERATION NO.:   36    OBJECTIVE VALUE:  -18662.4328513645        NO. OF FUNC. EVALS.:   0
 CUMULATIVE NO. OF FUNC. EVALS.:      784
 NPARAMETR:  1.8193E-01 -5.3122E+00 -3.0805E+00  9.8529E-03  1.3945E-04  5.0385E-04  9.6046E-03  6.3503E-04  9.5222E-03  3.4697E-02
            -2.9215E-03  3.0351E-02  2.5794E-02 -3.6464E-03  5.3176E-02  2.9987E-03
 PARAMETER:  1.0175E-01 -9.9985E-02 -9.9947E-02  1.0056E-01  1.0532E-01  9.8633E-02  1.0027E-01  9.9931E-02  1.0003E-01  1.5247E-01
            -4.9332E-02  1.0558E-01  1.0590E-01 -7.8474E-02  6.9665E-02  1.0013E-01
 GRADIENT:  -1.1587E-03  1.7268E-02 -4.9306E-02 -4.1263E-03 -5.3324E-04 -1.5053E-03 -4.7407E-03 -2.0217E-03 -9.3144E-04  4.6269E-04
            -6.2310E-04 -7.3475E-03 -1.1480E-03 -4.1897E-04 -4.9801E-04  5.5968E-03
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      784
 NO. OF SIG. DIGITS IN FINAL EST.:  3.4

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         4.5768E-06 -6.7702E-05 -7.5372E-05 -2.8744E-03 -7.5287E-04 -1.5759E-03
 SE:             2.2433E-03  3.3919E-03  3.3552E-03  4.3020E-02  3.9252E-02  5.5339E-02
 N:                     800         800         800          16          16          16
 
 P VAL.:         9.9837E-01  9.8408E-01  9.8208E-01  9.4673E-01  9.8470E-01  9.7728E-01
 
 ETASHRINKSD(%)  3.6077E+01  2.1079E+00  2.7495E+00  4.5892E+00  1.0000E-10  8.6075E-01
 ETASHRINKVR(%)  5.9139E+01  4.1715E+00  5.4233E+00  8.9678E+00  1.0000E-10  1.7141E+00
 EBVSHRINKSD(%)  3.6002E+01  2.0790E+00  2.7407E+00  5.2127E-02  1.5323E-02  9.6814E-03
 EBVSHRINKVR(%)  5.9042E+01  4.1148E+00  5.4063E+00  1.0423E-01  3.0644E-02  1.9362E-02
 RELATIVEINF(%)  4.0931E+01  9.5863E+01  9.4816E+01  9.9802E+01  9.9967E+01  9.9971E+01
 EPSSHRINKSD(%)  1.2266E+01
 EPSSHRINKVR(%)  2.3028E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -18662.4328513645     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -3959.41632008970     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2448
  
 #TERE:
 Elapsed estimation  time in seconds:  1165.53
 Elapsed covariance  time in seconds:   170.12
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -18662.433       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         1.82E-01 -5.31E+00 -3.08E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.85E-03
 
 ETA2
+        1.39E-04  9.60E-03
 
 ETA3
+        5.04E-04  6.35E-04  9.52E-03
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  3.47E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -2.92E-03  2.58E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  3.04E-02 -3.65E-03  5.32E-02
 


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
+        1.43E-02  9.80E-02
 
 ETA3
+        5.20E-02  6.64E-02  9.76E-02
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.86E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00 -9.77E-02  1.61E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  7.07E-01 -9.85E-02  2.31E-01
 


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
 
         4.47E-02  3.97E-02  5.64E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        8.59E-04
 
 ETA2
+        5.31E-04  5.04E-04
 
 ETA3
+        5.91E-04  3.59E-04  5.05E-04
 
 ETA4
+       ......... ......... .........  1.37E-02
 
 ETA5
+       ......... ......... .........  8.37E-03  9.43E-03
 
 ETA6
+       ......... ......... .........  1.45E-02  9.91E-03  2.01E-02
 


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
+       ......... ......... .........  3.68E-02
 
 ETA5
+       ......... ......... .........  2.80E-01  2.94E-02
 
 ETA6
+       ......... ......... .........  1.37E-01  2.67E-01  4.37E-02
 


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
+        2.00E-03
 
 TH 2
+       -2.77E-04  1.57E-03
 
 TH 3
+        1.72E-03 -3.05E-04  3.18E-03
 
 OM11
+       -6.15E-10  1.97E-08  2.15E-08  7.38E-07
 
 OM12
+       -1.74E-07 -4.93E-08 -9.43E-08  5.11E-08  2.81E-07
 
 OM13
+        2.62E-07  8.27E-08  1.54E-07  9.48E-08  3.64E-08  3.49E-07
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        7.27E-09  7.48E-09  9.60E-09  2.49E-09  2.29E-08  2.71E-09 ......... ......... .........  2.54E-07
 
 OM23
+        1.40E-09  1.38E-09  2.04E-09  3.50E-09  1.92E-08  1.34E-08 ......... ......... .........  2.91E-08  1.29E-07
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        2.25E-08  7.15E-09  1.27E-08  5.19E-09  3.97E-09  3.54E-08 ......... ......... .........  3.38E-09  2.84E-08 .........
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
+        1.74E-05 -1.14E-06  1.36E-05  5.46E-08  7.01E-09  8.70E-09 ......... ......... ......... -1.10E-09  3.14E-10 .........
         ......... ......... -1.94E-09 ......... ......... .........  1.88E-04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        8.33E-07  5.63E-06  4.27E-07  4.01E-09  1.66E-08  1.66E-09 ......... ......... .........  6.29E-09 -1.26E-10 .........
         ......... ......... -1.19E-10 ......... ......... ......... -6.18E-06  7.00E-05
 
 OM46
+        1.25E-05 -1.20E-06  1.62E-05  5.02E-09 -6.54E-10  2.08E-08 ......... ......... ......... -1.08E-09  2.83E-09 .........
         ......... ......... -1.46E-09 ......... ......... .........  1.62E-04 -8.46E-06  2.11E-04
 
 OM55
+       -2.74E-07  3.57E-06 -2.50E-07 -2.14E-10  5.66E-09  1.32E-10 ......... ......... .........  6.20E-09  1.23E-09 .........
         ......... ......... -1.70E-10 ......... ......... .........  1.05E-06  1.25E-06  7.87E-07  8.89E-05
 
 OM56
+        1.40E-06  3.27E-06  2.74E-06 -2.13E-09  3.74E-09  3.30E-09 ......... ......... .........  3.94E-09  2.20E-09 .........
         ......... .........  9.52E-10 ......... ......... ......... -4.56E-06  6.02E-05 -5.94E-06 -2.60E-06  9.82E-05
 
 OM66
+        7.75E-06 -1.31E-06  1.39E-05 -9.26E-09 -3.46E-09  9.77E-09 ......... ......... ......... -9.44E-10  3.37E-09 .........
         ......... .........  2.12E-09 ......... ......... .........  1.39E-04 -9.76E-06  2.43E-04  7.59E-07 -1.00E-05  4.06E-04
 
 SG11
+        4.18E-09  4.18E-09  5.49E-09 -1.99E-09 -6.71E-10 -7.70E-10 ......... ......... ......... -4.48E-10 -4.70E-10 .........
         ......... ......... -5.24E-10 ......... ......... .........  1.04E-08  5.25E-09  1.01E-08  2.73E-09  4.85E-09  9.22E-09
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
+        4.47E-02
 
 TH 2
+       -1.56E-01  3.97E-02
 
 TH 3
+        6.84E-01 -1.37E-01  5.64E-02
 
 OM11
+       -1.60E-05  5.78E-04  4.44E-04  8.59E-04
 
 OM12
+       -7.34E-03 -2.34E-03 -3.15E-03  1.12E-01  5.31E-04
 
 OM13
+        9.94E-03  3.53E-03  4.63E-03  1.87E-01  1.16E-01  5.91E-04
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        3.23E-04  3.74E-04  3.38E-04  5.75E-03  8.56E-02  9.11E-03 ......... ......... .........  5.04E-04
 
 OM23
+        8.75E-05  9.71E-05  1.01E-04  1.13E-02  1.01E-01  6.30E-02 ......... ......... .........  1.61E-01  3.59E-04
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        9.97E-04  3.57E-04  4.47E-04  1.20E-02  1.48E-02  1.19E-01 ......... ......... .........  1.33E-02  1.57E-01 .........
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
+        2.83E-02 -2.10E-03  1.76E-02  4.63E-03  9.63E-04  1.07E-03 ......... ......... ......... -1.59E-04  6.37E-05 .........
         ......... ......... -2.80E-04 ......... ......... .........  1.37E-02
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        2.23E-03  1.70E-02  9.05E-04  5.58E-04  3.75E-03  3.36E-04 ......... ......... .........  1.49E-03 -4.19E-05 .........
         ......... ......... -2.81E-05 ......... ......... ......... -5.39E-02  8.37E-03
 
 OM46
+        1.92E-02 -2.08E-03  1.97E-02  4.02E-04 -8.48E-05  2.42E-03 ......... ......... ......... -1.47E-04  5.43E-04 .........
         ......... ......... -1.98E-04 ......... ......... .........  8.13E-01 -6.96E-02  1.45E-02
 
 OM55
+       -6.49E-04  9.55E-03 -4.71E-04 -2.64E-05  1.13E-03  2.36E-05 ......... ......... .........  1.31E-03  3.62E-04 .........
         ......... ......... -3.57E-05 ......... ......... .........  8.15E-03  1.58E-02  5.74E-03  9.43E-03
 
 OM56
+        3.15E-03  8.32E-03  4.90E-03 -2.50E-04  7.11E-04  5.64E-04 ......... ......... .........  7.89E-04  6.17E-04 .........
         ......... .........  1.90E-04 ......... ......... ......... -3.36E-02  7.26E-01 -4.13E-02 -2.78E-02  9.91E-03
 
 OM66
+        8.61E-03 -1.64E-03  1.23E-02 -5.35E-04 -3.24E-04  8.21E-04 ......... ......... ......... -9.30E-05  4.65E-04 .........
         ......... .........  2.09E-04 ......... ......... .........  5.01E-01 -5.79E-02  8.29E-01  3.99E-03 -5.03E-02  2.01E-02
 
 SG11
+        1.71E-03  1.92E-03  1.78E-03 -4.23E-02 -2.31E-02 -2.38E-02 ......... ......... ......... -1.62E-02 -2.39E-02 .........
         ......... ......... -1.89E-02 ......... ......... .........  1.38E-02  1.15E-02  1.27E-02  5.28E-03  8.93E-03  8.36E-03
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
+        9.49E+02
 
 TH 2
+        6.87E+01  6.53E+02
 
 TH 3
+       -5.08E+02  2.55E+01  5.92E+02
 
 OM11
+        6.05E+01 -3.01E+00 -3.27E+01  1.42E+06
 
 OM12
+        5.01E+02  2.03E+02 -1.26E+02 -2.11E+05  3.69E+06
 
 OM13
+       -5.78E+02 -2.39E+02  1.39E+02 -3.65E+05 -3.12E+05  3.05E+06
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -4.85E+01 -3.65E+01  6.67E-01  7.04E+03 -2.74E+05  2.54E+04 ......... ......... .........  4.07E+06
 
 OM23
+       -1.38E+01 -9.59E+00  1.93E+00  2.69E+04 -4.57E+05 -1.77E+05 ......... ......... ......... -8.87E+05  8.23E+06
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        1.21E+01  3.94E+00 -3.33E+00  2.37E+04  4.58E+04 -3.91E+05 ......... ......... .........  4.66E+04 -8.74E+05 .........
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
+       -1.15E+02 -3.71E+00  6.50E+01 -1.50E+03 -4.63E+02  1.28E+03 ......... ......... .........  1.38E+01  2.77E+02 .........
         ......... ......... -2.47E+02 ......... ......... .........  2.19E+04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -2.70E+01 -6.92E+01  1.56E+01 -1.64E+02 -1.59E+03  1.15E+02 ......... ......... ......... -4.00E+02  5.61E+02 .........
         ......... .........  3.06E+00 ......... ......... ......... -6.77E+02  3.04E+04
 
 OM46
+        8.46E+01 -5.20E+00 -8.71E+01  1.60E+03  4.46E+02 -2.15E+03 ......... ......... ......... -1.20E+01 -4.69E+02 .........
         ......... .........  5.23E+02 ......... ......... ......... -2.63E+04  2.05E+03  4.68E+04
 
 OM55
+        2.07E-01 -2.44E+01 -1.87E+00  4.23E+00 -1.83E+02  1.96E+00 ......... ......... ......... -2.58E+02 -7.33E+01 .........
         ......... ......... -2.22E+00 ......... ......... ......... -6.75E+01 -9.73E+02 -1.46E+01  1.13E+04
 
 OM56
+        1.35E+01  1.83E+01 -2.00E+01  9.43E+01  8.17E+02 -1.61E+02 ......... ......... .........  8.51E+01 -5.10E+02 .........
         ......... ......... -4.19E+01 ......... ......... .........  6.83E+02 -1.87E+04 -1.59E+03  8.94E+02  2.17E+04
 
 OM66
+       -1.21E+01  3.16E+00  1.92E+01 -4.23E+02 -1.05E+02  7.62E+02 ......... ......... .........  2.99E-01  1.02E+02 .........
         ......... ......... -2.45E+02 ......... ......... .........  8.25E+03 -7.20E+02 -1.90E+04  9.59E+00  8.01E+02  1.10E+04
 
 SG11
+       -3.17E+02 -9.42E+02 -4.11E+02  8.11E+05  5.01E+05  3.79E+05 ......... ......... .........  4.27E+05  8.76E+05 .........
         ......... .........  5.07E+05 ......... ......... ......... -1.30E+04 -2.49E+04 -8.76E+03 -9.80E+03 -2.50E+03  1.46E+03
         3.35E+08
 
 Elapsed finaloutput time in seconds:     0.04
 #CPUT: Total CPU Time in Seconds,     1396.422
Stop Time: 
Wed 02/03/2021 
12:22 PM
