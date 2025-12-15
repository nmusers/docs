Mon 02/01/2021 
09:56 AM
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
     LEVCENTER=0 LEVOBJTYPE=2
;$EST METHOD=IMP AUTO=1 PRINT=1 NOPRIOR=1
;$EST METHOD=BAYES AUTO=1 PRINT=25 NITER=2000 NOPRIOR=0
$EST METHOD=1 PRINT=1 NSIG=3 SIGL=10 FNLETA=0 SLOW NONINFETA=1 NOPRIOR=1
     LEVCENTER=0 LEVOBJTYPE=2
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
Current Date:        1 FEB 2021
Days until program expires :3615
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
 RAW OUTPUT FILE (FILE): superid3_21c.ext
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
 Level OBJECTIVE FUNCTION TYPE (LEVOBJTYPE):2
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

 iteration            0 OBJ=   3103.59355394363
 iteration            1 OBJ=  -3271.60748130417
 iteration            2 OBJ=  -5280.81623082040
 iteration            3 OBJ=  -7094.41417537641
 iteration            4 OBJ=  -8845.42346398656
 iteration            5 OBJ=  -10564.2463183095
 iteration            6 OBJ=  -12253.1087860932
 iteration            7 OBJ=  -13896.5462778284
 iteration            8 OBJ=  -15444.4549277498
 iteration            9 OBJ=  -16719.5314500154
 iteration           10 OBJ=  -17184.8502679331
 iteration           11 OBJ=  -17187.9422414207
 iteration           12 OBJ=  -17188.2905812295
 iteration           13 OBJ=  -17188.4231099116
 iteration           14 OBJ=  -17188.4715244916
 iteration           15 OBJ=  -17188.4847554309
 iteration           16 OBJ=  -17188.4841722988
 iteration           17 OBJ=  -17188.4790148983
 iteration           18 OBJ=  -17188.4730901915
 iteration           19 OBJ=  -17188.4678048095
 iteration           20 OBJ=  -17188.4635406286
 iteration           21 OBJ=  -17188.4602736687
 iteration           22 OBJ=  -17188.4578445646
 iteration           23 OBJ=  -17188.4560717731
 iteration           24 OBJ=  -17188.4547935850
 iteration           25 OBJ=  -17188.4538793487
 iteration           26 OBJ=  -17188.4532290368
 iteration           27 OBJ=  -17188.4527681638
 iteration           28 OBJ=  -17188.4524424318
 iteration           29 OBJ=  -17188.4522126435
 iteration           30 OBJ=  -17188.4520507140
 iteration           31 OBJ=  -17188.4519367147
 iteration           32 OBJ=  -17188.4518565283
 iteration           33 OBJ=  -17188.4518001565
 iteration           34 OBJ=  -17188.4517604780
 iteration           35 OBJ=  -17188.4517325631
 iteration           36 OBJ=  -17188.4517130704
 iteration           37 OBJ=  -17188.4516992906
 iteration           38 OBJ=  -17188.4516895856
 iteration           39 OBJ=  -17188.4516828379
 Convergence achieved
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.0497E-04 -3.3514E-05 -3.6480E-05  1.8460E-07 -5.6683E-07 -5.5145E-07
 SE:             2.2443E-03  3.3919E-03  3.3554E-03  4.2783E-02  3.9225E-02  5.5270E-02
 N:                     800         800         800          16          16          16
 
 P VAL.:         9.6270E-01  9.9212E-01  9.9133E-01  1.0000E+00  9.9999E-01  9.9999E-01
 
 ETASHRINKSD(%)  3.6009E+01  2.0808E+00  2.7414E+00  7.8535E-06  5.1742E-06  5.3079E-06
 ETASHRINKVR(%)  5.9051E+01  4.1182E+00  5.4076E+00  1.5707E-05  1.0348E-05  1.0616E-05
 EBVSHRINKSD(%)  3.6008E+01  2.0807E+00  2.7414E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  5.9051E+01  4.1182E+00  5.4076E+00  0.0000E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  4.0919E+01  9.5854E+01  9.4821E+01  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  1.2278E+01
 EPSSHRINKVR(%)  2.3049E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -17188.4516828379     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -2485.43515156312     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2445
  
 #TERE:
 Elapsed estimation  time in seconds:    58.07
 Elapsed covariance  time in seconds:     0.24
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
+        8.43E+01  1.40E+03  7.87E+03  1.02E+06 -7.73E+04  1.38E+06  0.00E+00  0.00E+00  0.00E+00  1.48E+06  2.25E+06  0.00E+00
          0.00E+00  0.00E+00  1.82E+06  0.00E+00  0.00E+00  0.00E+00 -2.52E+04 -4.66E+04 -1.36E+05 -7.09E+04 -1.07E+04  7.39E+04
         3.31E+08
 
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
 RAW OUTPUT FILE (FILE): superid3_21c.ext
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
 Level OBJECTIVE FUNCTION TYPE (LEVOBJTYPE):2
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

 
0ITERATION NO.:    0    OBJECTIVE VALUE:  -17193.8076920130        NO. OF FUNC. EVALS.:  17
 CUMULATIVE NO. OF FUNC. EVALS.:       17
 NPARAMETR:  1.7879E-01 -5.3130E+00 -3.0822E+00  9.8407E-03  1.3193E-04  5.1010E-04  9.5990E-03  6.3474E-04  9.5221E-03  3.1238E-02
            -5.6199E-03  2.7276E-02  2.6259E-02 -6.2888E-03  5.2134E-02  2.9997E-03
 PARAMETER:  1.0000E-01 -1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
            -1.0000E-01  1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:  -4.7870E+01 -2.7094E+02  2.8534E+02 -3.7477E+00 -5.2922E-01 -7.8128E-01  4.1411E+00 -8.1805E-01  5.8632E+00 -1.3136E+01
            -3.4409E+01  1.0972E+02  1.2660E+01 -2.9460E+00  1.8812E+01 -1.2273E+00
 
0ITERATION NO.:    1    OBJECTIVE VALUE:  -17193.8102063195        NO. OF FUNC. EVALS.:  27
 CUMULATIVE NO. OF FUNC. EVALS.:       44
 NPARAMETR:  1.7880E-01 -5.3124E+00 -3.0825E+00  9.8407E-03  1.3193E-04  5.1010E-04  9.5990E-03  6.3475E-04  9.5221E-03  3.1238E-02
            -5.6198E-03  2.7274E-02  2.6259E-02 -6.2885E-03  5.2132E-02  2.9997E-03
 PARAMETER:  1.0000E-01 -9.9989E-02 -1.0001E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
            -9.9999E-02  9.9995E-02  9.9999E-02 -1.0000E-01  9.9999E-02  1.0000E-01
 GRADIENT:  -4.2496E+01  4.2401E+02  1.2977E+02 -3.7683E+00 -5.2678E-01 -7.5721E-01  4.1361E+00 -8.1988E-01  5.8537E+00 -1.3091E+01
            -3.4362E+01  1.0958E+02  1.2658E+01 -2.9235E+00  1.8851E+01 -1.2109E+00
 
0ITERATION NO.:    2    OBJECTIVE VALUE:  -17193.8122266181        NO. OF FUNC. EVALS.:  26
 CUMULATIVE NO. OF FUNC. EVALS.:       70
 NPARAMETR:  1.7880E-01 -5.3126E+00 -3.0830E+00  9.8407E-03  1.3193E-04  5.1010E-04  9.5990E-03  6.3475E-04  9.5221E-03  3.1238E-02
            -5.6197E-03  2.7272E-02  2.6259E-02 -6.2880E-03  5.2129E-02  2.9997E-03
 PARAMETER:  1.0000E-01 -9.9992E-02 -1.0003E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  9.9999E-02  1.0000E-01
            -9.9996E-02  9.9988E-02  9.9999E-02 -1.0000E-01  9.9998E-02  1.0000E-01
 GRADIENT:  -3.7506E+01  1.8203E+02 -9.9064E+01 -3.7127E+00 -5.0265E-01 -7.4687E-01  4.1897E+00 -8.1388E-01  5.8848E+00 -1.3035E+01
            -3.4327E+01  1.0930E+02  1.2714E+01 -2.8866E+00  1.8845E+01 -1.1532E+00
 
0ITERATION NO.:    3    OBJECTIVE VALUE:  -17193.8381867175        NO. OF FUNC. EVALS.:  20
 CUMULATIVE NO. OF FUNC. EVALS.:       90
 NPARAMETR:  1.8374E-01 -5.3129E+00 -3.0806E+00  9.8458E-03  1.3201E-04  5.1049E-04  9.5935E-03  6.3492E-04  9.5146E-03  3.1294E-02
            -5.4923E-03  2.5250E-02  2.6168E-02 -5.8093E-03  4.8618E-02  3.0002E-03
 PARAMETER:  1.0277E-01 -9.9998E-02 -9.9950E-02  1.0026E-01  1.0003E-01  1.0005E-01  9.9713E-02  1.0006E-01  9.9596E-02  1.0090E-01
            -9.7642E-02  9.2489E-02  9.9128E-02 -9.9801E-02  9.8707E-02  1.0008E-01
 GRADIENT:   5.8831E+01  2.3191E+02  1.2626E+02  1.1499E+00 -5.0070E-01 -2.6256E+00  3.4689E+00 -7.8237E-01 -1.1572E-01 -4.7519E+00
            -3.1740E+01 -1.2593E+02  1.1932E+01 -1.9900E+00  2.6188E+00  1.0316E+00
 
0ITERATION NO.:    4    OBJECTIVE VALUE:  -17194.1515194413        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      109
 NPARAMETR:  1.7785E-01 -5.3125E+00 -3.0830E+00  9.8605E-03  1.3244E-04  5.1510E-04  9.5555E-03  6.3632E-04  9.4850E-03  3.1592E-02
            -4.5573E-03  2.5210E-02  2.5544E-02 -4.9884E-03  4.8034E-02  3.0006E-03
 PARAMETER:  9.9472E-02 -9.9991E-02 -1.0003E-01  1.0101E-01  1.0029E-01  1.0088E-01  9.7728E-02  1.0047E-01  9.7988E-02  1.0563E-01
            -8.0637E-02  9.1909E-02  9.2784E-02 -9.8532E-02  9.2871E-02  1.0015E-01
 GRADIENT:  -5.8467E+01  2.4101E+02  3.3046E+01  2.9260E+00 -2.2380E-01 -2.4495E+00 -2.1983E+00  6.5281E-01 -3.9411E+00 -7.1941E-01
            -6.7495E+00 -1.6212E+02  3.9964E+00  7.6220E-01 -1.8660E+00  3.0400E+00
 
0ITERATION NO.:    5    OBJECTIVE VALUE:  -17194.3681737469        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      128
 NPARAMETR:  1.8359E-01 -5.3129E+00 -3.0806E+00  9.8721E-03  1.3281E-04  5.1931E-04  9.5264E-03  6.3730E-04  9.4619E-03  3.1855E-02
            -3.7597E-03  2.5897E-02  2.5061E-02 -4.3869E-03  4.8684E-02  3.0003E-03
 PARAMETER:  1.0268E-01 -9.9999E-02 -9.9949E-02  1.0159E-01  1.0051E-01  1.0164E-01  9.6201E-02  1.0077E-01  9.6725E-02  1.0978E-01
            -6.6249E-02  9.4021E-02  8.7340E-02 -9.7508E-02  8.7753E-02  1.0011E-01
 GRADIENT:   5.4360E+01  7.4490E+01  1.6423E+02  2.8435E+00  7.1201E-02 -1.6366E+00 -6.8932E+00  1.9797E+00 -5.0554E+00 -3.3201E-01
             1.4973E+01 -1.1122E+02 -2.9786E+00  2.8857E+00  2.4449E-01  2.0707E+00
 
0ITERATION NO.:    6    OBJECTIVE VALUE:  -17194.4729227260        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      147
 NPARAMETR:  1.8361E-01 -5.3129E+00 -3.0806E+00  9.8717E-03  1.3298E-04  5.2692E-04  9.6308E-03  6.2964E-04  9.4824E-03  3.2392E-02
            -3.8477E-03  2.6430E-02  2.4958E-02 -4.4890E-03  4.8483E-02  2.9932E-03
 PARAMETER:  1.0270E-01 -9.9998E-02 -9.9948E-02  1.0157E-01  1.0064E-01  1.0314E-01  1.0165E-01  9.8982E-02  9.7851E-02  1.1813E-01
            -6.7235E-02  9.5158E-02  8.4970E-02 -9.9145E-02  7.4590E-02  9.8909E-02
 GRADIENT:   5.3447E+01  1.3040E+02  1.7865E+02  2.8167E+00  3.1853E-02 -8.5333E-01  1.1902E+00  5.5483E-01 -4.9416E+00  3.4651E+00
             1.3025E+01 -1.1181E+02 -3.1381E+00  2.4216E+00 -4.7353E+00 -2.6359E+01
 
0ITERATION NO.:    7    OBJECTIVE VALUE:  -17194.4888911014        NO. OF FUNC. EVALS.:  20
 CUMULATIVE NO. OF FUNC. EVALS.:      167
 NPARAMETR:  1.8366E-01 -5.3129E+00 -3.0805E+00  9.8714E-03  1.3306E-04  5.3003E-04  9.6662E-03  6.2636E-04  9.4924E-03  3.2618E-02
            -3.8937E-03  2.6664E-02  2.4917E-02 -4.5413E-03  4.8418E-02  3.0055E-03
 PARAMETER:  1.0272E-01 -9.9998E-02 -9.9946E-02  1.0156E-01  1.0070E-01  1.0375E-01  1.0348E-01  9.8273E-02  9.8391E-02  1.2161E-01
            -6.7803E-02  9.5669E-02  8.3985E-02 -9.9887E-02  6.8996E-02  1.0097E-01
 GRADIENT:   5.3790E+01  1.3715E+02  1.8321E+02  3.0123E+00  6.8640E-02 -4.8514E-01  3.9442E+00  1.3408E-01 -4.6481E+00  5.0821E+00
             1.2024E+01 -1.1099E+02 -3.2538E+00  2.2152E+00 -6.7212E+00  2.3287E+01
 
0ITERATION NO.:    8    OBJECTIVE VALUE:  -17194.5052982104        NO. OF FUNC. EVALS.:  20
 CUMULATIVE NO. OF FUNC. EVALS.:      187
 NPARAMETR:  1.8368E-01 -5.3129E+00 -3.0806E+00  9.8664E-03  1.3315E-04  5.3093E-04  9.5719E-03  6.2329E-04  9.5134E-03  3.2757E-02
            -3.9993E-03  2.6833E-02  2.4901E-02 -4.6502E-03  4.8329E-02  3.0052E-03
 PARAMETER:  1.0273E-01 -9.9998E-02 -9.9948E-02  1.0131E-01  1.0080E-01  1.0395E-01  9.8581E-02  9.8263E-02  9.9503E-02  1.2374E-01
            -6.9494E-02  9.6070E-02  8.3177E-02 -1.0113E-01  6.3821E-02  1.0091E-01
 GRADIENT:   5.4403E+01  1.4022E+02  1.5879E+02  2.6907E+00  6.0668E-02 -2.1968E-01 -4.1083E+00  1.7414E-01 -3.6827E+00  5.9475E+00
             9.6030E+00 -1.1074E+02 -5.2943E+00  1.7208E+00 -8.5227E+00  2.1543E+01
 
0ITERATION NO.:    9    OBJECTIVE VALUE:  -17194.5094822772        NO. OF FUNC. EVALS.:  20
 CUMULATIVE NO. OF FUNC. EVALS.:      207
 NPARAMETR:  1.8368E-01 -5.3129E+00 -3.0806E+00  9.8658E-03  1.3337E-04  5.2698E-04  9.5624E-03  6.2831E-04  9.5203E-03  3.2700E-02
            -3.9466E-03  2.6843E-02  2.5030E-02 -4.6344E-03  4.8274E-02  3.0052E-03
 PARAMETER:  1.0273E-01 -9.9998E-02 -9.9948E-02  1.0127E-01  1.0097E-01  1.0318E-01  9.8084E-02  9.9119E-02  9.9850E-02  1.2286E-01
            -6.8639E-02  9.6191E-02  8.6062E-02 -1.0234E-01  6.1672E-02  1.0091E-01
 GRADIENT:   5.4550E+01  1.5182E+02  1.5788E+02  2.3980E+00  4.7359E-02 -1.8700E-01 -4.1122E+00  4.7900E-01 -3.4822E+00  5.4699E+00
             1.0250E+01 -1.1040E+02 -3.2225E+00  1.7623E+00 -9.2754E+00  2.1427E+01
 
0ITERATION NO.:   10    OBJECTIVE VALUE:  -17194.5173239056        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      226
 NPARAMETR:  1.8364E-01 -5.3129E+00 -3.0806E+00  9.9173E-03  1.3515E-04  5.0252E-04  9.5724E-03  6.4298E-04  9.5106E-03  3.2532E-02
            -3.9225E-03  2.6825E-02  2.4971E-02 -4.7193E-03  4.8264E-02  3.0050E-03
 PARAMETER:  1.0271E-01 -9.9998E-02 -9.9950E-02  1.0388E-01  1.0205E-01  9.8133E-02  9.8605E-02  1.0145E-01  9.9377E-02  1.2029E-01
            -6.8395E-02  9.6373E-02  8.4928E-02 -1.0909E-01  5.9676E-02  1.0089E-01
 GRADIENT:   5.4801E+01  1.7114E+02  1.2476E+02  3.6952E+00  7.9248E-02 -6.5344E-01 -3.9247E+00  9.5192E-01 -4.3534E+00  4.4851E+00
             9.7189E+00 -1.0835E+02 -4.0814E+00  1.2151E+00 -9.4902E+00  2.1233E+01
 
0ITERATION NO.:   11    OBJECTIVE VALUE:  -17194.5230528833        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      245
 NPARAMETR:  1.8359E-01 -5.3129E+00 -3.0807E+00  9.8903E-03  1.3623E-04  4.8417E-04  9.5785E-03  6.4592E-04  9.5511E-03  3.2568E-02
            -3.8842E-03  2.6830E-02  2.4951E-02 -4.7505E-03  4.8283E-02  3.0050E-03
 PARAMETER:  1.0268E-01 -9.9998E-02 -9.9951E-02  1.0251E-01  1.0300E-01  9.4679E-02  9.8921E-02  1.0192E-01  1.0159E-01  1.2084E-01
            -6.7690E-02  9.6337E-02  8.4710E-02 -1.1395E-01  6.0195E-02  1.0088E-01
 GRADIENT:   5.4264E+01  1.6892E+02  1.1367E+02  3.1931E+00  1.6157E-01 -9.4230E-01 -3.5732E+00  8.7731E-01 -9.1208E-01  4.5129E+00
             1.0037E+01 -1.0635E+02 -4.3004E+00  8.7281E-01 -8.8224E+00  2.0976E+01
 
0ITERATION NO.:   12    OBJECTIVE VALUE:  -17194.5328044359        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      264
 NPARAMETR:  1.8353E-01 -5.3129E+00 -3.0807E+00  9.8186E-03  1.3774E-04  4.5754E-04  9.5762E-03  6.4568E-04  9.5107E-03  3.2725E-02
            -3.8608E-03  2.6918E-02  2.4978E-02 -4.8263E-03  4.8397E-02  3.0050E-03
 PARAMETER:  1.0265E-01 -9.9998E-02 -9.9954E-02  9.8874E-02  1.0452E-01  8.9797E-02  9.8798E-02  1.0193E-01  9.9581E-02  1.2325E-01
            -6.7119E-02  9.6422E-02  8.5419E-02 -1.2121E-01  6.1388E-02  1.0088E-01
 GRADIENT:   5.3456E+01  1.4335E+02  8.8126E+01  1.5902E+00  2.5412E-01 -1.1965E+00 -3.6815E+00  7.8579E-01 -3.6808E+00  5.0464E+00
             9.5285E+00 -1.0294E+02 -3.8868E+00  3.4701E-01 -8.4537E+00  2.0399E+01
 
0ITERATION NO.:   13    OBJECTIVE VALUE:  -17194.5455779575        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      282
 NPARAMETR:  1.8339E-01 -5.3129E+00 -3.0808E+00  9.9041E-03  1.3974E-04  4.5596E-04  9.5600E-03  6.2783E-04  9.5053E-03  3.2963E-02
            -3.8625E-03  2.7082E-02  2.5106E-02 -4.8612E-03  4.8631E-02  3.0046E-03
 PARAMETER:  1.0257E-01 -9.9998E-02 -9.9954E-02  1.0321E-01  1.0558E-01  8.9101E-02  9.7954E-02  9.9165E-02  9.9435E-02  1.2687E-01
            -6.6906E-02  9.6659E-02  8.8077E-02 -1.2361E-01  6.3680E-02  1.0081E-01
 GRADIENT:   4.9669E+01  1.5517E+02  1.1045E+02  4.8751E+00  2.6445E-01 -1.4963E+00 -4.0796E+00 -1.4075E-01 -3.2419E+00  7.2622E+00
             9.0511E+00 -9.6663E+01 -2.0478E+00  2.1055E-02 -6.7566E+00  1.9307E+01
 
0ITERATION NO.:   14    OBJECTIVE VALUE:  -17194.6841106034        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      301
 NPARAMETR:  1.8225E-01 -5.3129E+00 -3.0813E+00  9.8963E-03  1.4690E-04  5.1418E-04  9.5687E-03  5.4879E-04  9.4998E-03  3.2377E-02
            -3.9384E-03  2.7105E-02  2.5146E-02 -4.9776E-03  4.9099E-02  3.0027E-03
 PARAMETER:  1.0193E-01 -9.9997E-02 -9.9972E-02  1.0281E-01  1.1104E-01  1.0052E-01  9.8398E-02  8.6323E-02  9.9359E-02  1.1790E-01
            -6.8836E-02  9.7611E-02  8.8348E-02 -1.2304E-01  6.4240E-02  1.0050E-01
 GRADIENT:   2.9417E+01  1.0928E+02  3.5973E+01  1.8671E+00  2.2635E-01 -1.9172E-01 -2.4337E+00 -4.7399E+00 -2.1310E+00  1.3519E+00
             5.6261E+00 -5.2311E+01 -1.5762E+00 -9.8880E-01 -4.7089E+00  1.1115E+01
 
0ITERATION NO.:   15    OBJECTIVE VALUE:  -17194.7931198573        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      319
 NPARAMETR:  1.8081E-01 -5.3128E+00 -3.0819E+00  9.8791E-03  1.5449E-04  5.7850E-04  9.6106E-03  6.8186E-04  9.5409E-03  3.2517E-02
            -4.3184E-03  2.7561E-02  2.5245E-02 -5.1840E-03  4.9961E-02  2.9996E-03
 PARAMETER:  1.0113E-01 -9.9997E-02 -9.9991E-02  1.0195E-01  1.1687E-01  1.1319E-01  1.0057E-01  1.0709E-01  1.0028E-01  1.2007E-01
            -7.5315E-02  9.9040E-02  8.8442E-02 -1.1155E-01  6.8266E-02  9.9982E-02
 GRADIENT:  -4.1714E-01  6.7904E+01  4.4330E+01  1.8325E-01  2.7765E-02  1.0124E+00  3.5596E-03  2.0779E+00  9.7902E-02  5.4309E-01
             1.9840E-01  2.0554E+00  3.1625E-01 -2.3901E-01  1.0190E-01 -2.6907E-01
 
0ITERATION NO.:   16    OBJECTIVE VALUE:  -17194.8027493774        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      338
 NPARAMETR:  1.8073E-01 -5.3128E+00 -3.0819E+00  9.8650E-03  1.5341E-04  5.1468E-04  9.6087E-03  6.6755E-04  9.5338E-03  3.2527E-02
            -4.3863E-03  2.7665E-02  2.5254E-02 -5.1156E-03  5.0013E-02  2.9995E-03
 PARAMETER:  1.0108E-01 -9.9996E-02 -9.9992E-02  1.0123E-01  1.1614E-01  1.0078E-01  1.0047E-01  1.0499E-01  1.0037E-01  1.2022E-01
            -7.6487E-02  9.9398E-02  8.8268E-02 -1.0141E-01  6.6368E-02  9.9967E-02
 GRADIENT:  -1.9217E+00  8.3632E+01  4.2353E+01 -1.6855E-03  1.0434E-02  1.8385E-01  1.6577E-01  1.7712E+00  3.2983E-01  4.0085E-01
            -1.1471E-01  5.5001E+00  4.1895E-01  4.1566E-01  2.3188E-01 -9.5479E-01
 
0ITERATION NO.:   17    OBJECTIVE VALUE:  -17194.8059685797        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      356
 NPARAMETR:  1.8076E-01 -5.3129E+00 -3.0821E+00  9.8493E-03  1.0672E-04  4.9832E-04  9.6059E-03  6.4633E-04  9.5278E-03  3.2519E-02
            -4.3210E-03  2.7627E-02  2.5221E-02 -5.1261E-03  4.9993E-02  2.9998E-03
 PARAMETER:  1.0110E-01 -9.9998E-02 -9.9996E-02  1.0043E-01  8.0861E-02  9.7650E-02  1.0039E-01  1.0203E-01  1.0028E-01  1.2010E-01
            -7.5357E-02  9.9273E-02  8.7939E-02 -1.0659E-01  6.6944E-02  1.0003E-01
 GRADIENT:   4.4304E-01 -1.4785E+01 -4.0929E+01 -5.8926E-02 -1.7648E-01 -6.1438E-02  1.6496E-01  7.3382E-01  3.6119E-01  2.8820E-01
            -1.8887E-01  2.9978E+00 -1.8938E-01  7.7831E-02  3.4867E-01  9.4386E-02
 
0ITERATION NO.:   18    OBJECTIVE VALUE:  -17194.8092713014        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      374
 NPARAMETR:  1.8077E-01 -5.3129E+00 -3.0820E+00  9.8585E-03  1.3682E-04  5.0298E-04  9.6034E-03  6.3419E-04  9.5228E-03  3.2458E-02
            -4.3256E-03  2.7570E-02  2.5232E-02 -5.1170E-03  4.9936E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9998E-02 -9.9994E-02  1.0090E-01  1.0362E-01  9.8517E-02  1.0022E-01  9.9867E-02  1.0008E-01  1.1916E-01
            -7.5508E-02  9.9162E-02  8.8122E-02 -1.0567E-01  6.6894E-02  1.0002E-01
 GRADIENT:  -6.7092E-02 -5.9313E+00 -5.0519E+00  1.4350E-03 -1.8180E-02 -6.2992E-02  3.7498E-03  1.6938E-02  9.7671E-02  2.3631E-02
            -1.8299E-02  1.6680E-01 -2.8995E-03 -4.1348E-03  4.5675E-02 -1.7313E-02
 
0ITERATION NO.:   19    OBJECTIVE VALUE:  -17194.8093005288        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      392
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8605E-03  1.4096E-04  5.0767E-04  9.6037E-03  6.3416E-04  9.5221E-03  3.2452E-02
            -4.3285E-03  2.7563E-02  2.5232E-02 -5.1162E-03  4.9931E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9998E-02 -9.9994E-02  1.0100E-01  1.0674E-01  9.9425E-02  1.0023E-01  9.9817E-02  1.0002E-01  1.1906E-01
            -7.5567E-02  9.9147E-02  8.8096E-02 -1.0544E-01  6.6941E-02  1.0002E-01
 GRADIENT:   6.2116E-02 -4.9252E-01 -5.6803E-01 -3.6677E-02  2.3858E-05  1.1078E-02  3.7397E-02 -6.1649E-02 -3.1803E-02 -2.8750E-02
            -6.9685E-02 -2.6295E-02 -2.4062E-02  1.6182E-03  4.6821E-03  2.6545E-02
 
0ITERATION NO.:   20    OBJECTIVE VALUE:  -17194.8093032805        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      410
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8613E-03  1.4112E-04  5.0755E-04  9.6034E-03  6.3508E-04  9.5225E-03  3.2454E-02
            -4.3258E-03  2.7565E-02  2.5233E-02 -5.1160E-03  4.9931E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9998E-02 -9.9993E-02  1.0104E-01  1.0686E-01  9.9397E-02  1.0021E-01  9.9965E-02  1.0004E-01  1.1909E-01
            -7.5518E-02  9.9151E-02  8.8133E-02 -1.0559E-01  6.6894E-02  1.0002E-01
 GRADIENT:   1.3259E-02  7.0218E-01  3.3426E-01  9.3250E-03  1.7128E-02  3.1130E-02 -8.8035E-03  3.0122E-03 -5.0512E-03  1.3484E-02
             5.9208E-02 -1.4024E-02 -5.3769E-03 -8.0175E-03 -4.3619E-03  3.0528E-02
 
0ITERATION NO.:   21    OBJECTIVE VALUE:  -17194.8093063178        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      429
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8613E-03  1.4045E-04  5.0695E-04  9.6032E-03  6.3527E-04  9.5226E-03  3.2455E-02
            -4.3251E-03  2.7566E-02  2.5233E-02 -5.1160E-03  4.9931E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9998E-02 -9.9993E-02  1.0104E-01  1.0635E-01  9.9279E-02  1.0021E-01  1.0000E-01  1.0005E-01  1.1910E-01
            -7.5504E-02  9.9154E-02  8.8147E-02 -1.0562E-01  6.6870E-02  1.0002E-01
 GRADIENT:  -5.7971E-02  7.1450E-01  4.0087E-01 -1.0683E-02 -2.1400E-02 -4.1749E-02 -2.9360E-02 -2.8412E-03 -3.0262E-02 -1.3956E-02
             7.9381E-03 -3.1188E-02 -4.4081E-02 -3.9327E-02 -1.8423E-02 -4.0061E-02
 
0ITERATION NO.:   22    OBJECTIVE VALUE:  -17194.8093067183        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      447
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8613E-03  1.4059E-04  5.0700E-04  9.6032E-03  6.3524E-04  9.5227E-03  3.2455E-02
            -4.3259E-03  2.7566E-02  2.5233E-02 -5.1156E-03  4.9931E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9998E-02 -9.9993E-02  1.0104E-01  1.0645E-01  9.9290E-02  1.0021E-01  9.9997E-02  1.0005E-01  1.1910E-01
            -7.5519E-02  9.9154E-02  8.8148E-02 -1.0555E-01  6.6876E-02  1.0002E-01
 GRADIENT:  -9.8082E-03  5.7200E-01  3.3165E-01 -6.4662E-03 -1.3615E-02  2.4476E-02 -8.5861E-03  2.4585E-02  7.6397E-03  1.0110E-02
             3.2414E-02  3.3069E-03 -1.8983E-02 -1.4218E-02  2.9886E-02  2.5956E-02
 
0ITERATION NO.:   23    OBJECTIVE VALUE:  -17194.8093067825        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      465
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8613E-03  1.4066E-04  5.0696E-04  9.6032E-03  6.3523E-04  9.5227E-03  3.2455E-02
            -4.3262E-03  2.7567E-02  2.5233E-02 -5.1155E-03  4.9931E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9998E-02 -9.9993E-02  1.0105E-01  1.0651E-01  9.9282E-02  1.0021E-01  9.9994E-02  1.0005E-01  1.1910E-01
            -7.5524E-02  9.9154E-02  8.8148E-02 -1.0552E-01  6.6874E-02  1.0002E-01
 GRADIENT:   3.2994E-03  5.0645E-01  2.9376E-01  1.0707E-02 -1.9104E-02  2.3974E-02  4.5671E-03  3.6969E-02  8.8433E-03 -4.1358E-03
             4.1837E-02  2.0453E-02  4.5795E-02 -9.4913E-03  6.5447E-03 -3.4409E-03
 
0ITERATION NO.:   24    OBJECTIVE VALUE:  -17194.8093069220        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      483
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8612E-03  1.4076E-04  5.0691E-04  9.6033E-03  6.3519E-04  9.5226E-03  3.2455E-02
            -4.3266E-03  2.7567E-02  2.5233E-02 -5.1155E-03  4.9931E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9998E-02 -9.9993E-02  1.0104E-01  1.0659E-01  9.9272E-02  1.0021E-01  9.9986E-02  1.0005E-01  1.1910E-01
            -7.5531E-02  9.9154E-02  8.8140E-02 -1.0550E-01  6.6880E-02  1.0002E-01
 GRADIENT:   3.6232E-03  4.7022E-01  3.0932E-01  3.7942E-02  1.2147E-02  1.5189E-02  7.8018E-03  8.3746E-02  6.9234E-03  1.5358E-02
             2.7761E-02 -2.4047E-03 -4.2965E-03  2.3280E-02  5.1114E-03  2.0060E-02
 
0ITERATION NO.:   25    OBJECTIVE VALUE:  -17194.8093071834        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      501
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8610E-03  1.4082E-04  5.0692E-04  9.6033E-03  6.3500E-04  9.5226E-03  3.2455E-02
            -4.3267E-03  2.7566E-02  2.5233E-02 -5.1156E-03  4.9932E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9998E-02 -9.9993E-02  1.0103E-01  1.0663E-01  9.9275E-02  1.0021E-01  9.9956E-02  1.0005E-01  1.1911E-01
            -7.5533E-02  9.9153E-02  8.8135E-02 -1.0550E-01  6.6890E-02  1.0002E-01
 GRADIENT:  -1.5259E-02  3.3784E-01  1.9195E-01  1.9747E-02  2.8076E-02  2.5440E-02 -2.3954E-02 -7.5343E-03  1.0909E-03  3.3506E-03
             5.3678E-02 -1.3919E-02 -1.3308E-02 -1.5311E-02  3.2196E-03  1.1457E-03
 
0ITERATION NO.:   26    OBJECTIVE VALUE:  -17194.8093071834        NO. OF FUNC. EVALS.:  32
 CUMULATIVE NO. OF FUNC. EVALS.:      533
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8610E-03  1.4082E-04  5.0692E-04  9.6033E-03  6.3500E-04  9.5226E-03  3.2455E-02
            -4.3267E-03  2.7566E-02  2.5233E-02 -5.1156E-03  4.9932E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9998E-02 -9.9993E-02  1.0103E-01  1.0663E-01  9.9275E-02  1.0021E-01  9.9956E-02  1.0005E-01  1.1911E-01
            -7.5533E-02  9.9153E-02  8.8135E-02 -1.0550E-01  6.6890E-02  1.0002E-01
 GRADIENT:  -3.2937E-02 -3.2892E+01 -7.8757E+00  4.4347E-03  5.1852E-03  7.8285E-03 -1.2551E-02  1.1758E-02 -8.7746E-03  4.3528E-03
             3.0034E-02 -2.1411E-02 -5.6333E-03 -8.5805E-04 -6.7593E-04 -8.1444E-03
 
0ITERATION NO.:   27    OBJECTIVE VALUE:  -17194.8093151000        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      551            RESET HESSIAN, TYPE II
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8610E-03  1.3870E-04  5.0669E-04  9.6033E-03  6.3478E-04  9.5226E-03  3.2455E-02
            -4.3273E-03  2.7566E-02  2.5233E-02 -5.1161E-03  4.9932E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9997E-02 -9.9993E-02  1.0103E-01  1.0502E-01  9.9231E-02  1.0021E-01  9.9938E-02  1.0005E-01  1.1910E-01
            -7.5543E-02  9.9154E-02  8.8139E-02 -1.0549E-01  6.6891E-02  1.0002E-01
 GRADIENT:  -8.6122E-02  1.7297E+01  4.5657E+00  3.7486E-02 -2.5602E-02 -1.6425E-02  4.0997E-02  4.0127E-02  2.5453E-04  1.3009E-02
            -1.2602E-02 -8.7311E-04  9.0986E-03  2.7388E-02  1.3457E-02  8.5149E-03
 
0ITERATION NO.:   28    OBJECTIVE VALUE:  -17194.8093183892        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      569
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8609E-03  1.3951E-04  5.0669E-04  9.6033E-03  6.3473E-04  9.5226E-03  3.2455E-02
            -4.3275E-03  2.7566E-02  2.5233E-02 -5.1164E-03  4.9932E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9997E-02 -9.9993E-02  1.0102E-01  1.0564E-01  9.9231E-02  1.0021E-01  9.9924E-02  1.0005E-01  1.1910E-01
            -7.5546E-02  9.9154E-02  8.8139E-02 -1.0551E-01  6.6889E-02  1.0002E-01
 GRADIENT:  -1.0187E-01  2.1333E+01  5.4410E+00 -2.0872E-02 -2.1272E-02 -1.3904E-02 -1.2942E-02 -3.7147E-02  9.9957E-03 -3.5347E-02
            -4.7585E-02 -2.1337E-02 -3.5248E-02 -2.0222E-02 -3.5252E-02 -1.4906E-02
 
0ITERATION NO.:   29    OBJECTIVE VALUE:  -17194.8093188377        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      588
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8609E-03  1.3995E-04  5.0669E-04  9.6033E-03  6.3477E-04  9.5226E-03  3.2455E-02
            -4.3275E-03  2.7566E-02  2.5233E-02 -5.1163E-03  4.9932E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9997E-02 -9.9993E-02  1.0102E-01  1.0597E-01  9.9231E-02  1.0021E-01  9.9927E-02  1.0005E-01  1.1910E-01
            -7.5546E-02  9.9154E-02  8.8142E-02 -1.0550E-01  6.6893E-02  1.0002E-01
 GRADIENT:  -8.4233E-02  2.2873E+01  5.7773E+00 -2.0613E-02 -1.9708E-02 -4.5111E-04  5.4527E-03  3.4168E-02 -3.9997E-03  1.4900E-02
            -2.0373E-03  4.7294E-05 -1.0121E-02 -5.5828E-03 -8.6475E-03  1.0403E-02
 
0ITERATION NO.:   30    OBJECTIVE VALUE:  -17194.8093188692        NO. OF FUNC. EVALS.:  20
 CUMULATIVE NO. OF FUNC. EVALS.:      608
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8609E-03  1.3998E-04  5.0669E-04  9.6033E-03  6.3477E-04  9.5226E-03  3.2455E-02
            -4.3275E-03  2.7566E-02  2.5234E-02 -5.1163E-03  4.9932E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9997E-02 -9.9993E-02  1.0102E-01  1.0600E-01  9.9230E-02  1.0021E-01  9.9927E-02  1.0005E-01  1.1910E-01
            -7.5546E-02  9.9154E-02  8.8142E-02 -1.0550E-01  6.6893E-02  1.0002E-01
 GRADIENT:  -5.1016E-02  2.2997E+01  5.8276E+00  5.4996E-02  3.0367E-02  3.8304E-02  2.1099E-02  1.8819E-02  5.9578E-02  2.6504E-02
             3.5387E-02  3.6842E-02  5.1543E-02  3.0425E-02  4.0101E-02  3.6136E-02
 
0ITERATION NO.:   31    OBJECTIVE VALUE:  -17194.8093188692        NO. OF FUNC. EVALS.:  37
 CUMULATIVE NO. OF FUNC. EVALS.:      645
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8609E-03  1.3998E-04  5.0669E-04  9.6033E-03  6.3477E-04  9.5226E-03  3.2455E-02
            -4.3275E-03  2.7566E-02  2.5234E-02 -5.1163E-03  4.9932E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9997E-02 -9.9993E-02  1.0102E-01  1.0600E-01  9.9230E-02  1.0021E-01  9.9927E-02  1.0005E-01  1.1910E-01
            -7.5546E-02  9.9154E-02  8.8142E-02 -1.0550E-01  6.6893E-02  1.0002E-01
 GRADIENT:  -9.7418E-02 -1.0289E+01 -2.2788E+00  3.3556E-03  9.4568E-04  5.9531E-03  2.3245E-03  2.0057E-03 -5.9787E-04 -1.9459E-04
            -4.6602E-03 -4.1945E-03  9.1808E-04 -2.2805E-03  3.9775E-03 -1.1219E-02
 
0ITERATION NO.:   32    OBJECTIVE VALUE:  -17194.8093188692        NO. OF FUNC. EVALS.:   0
 CUMULATIVE NO. OF FUNC. EVALS.:      645
 NPARAMETR:  1.8078E-01 -5.3129E+00 -3.0820E+00  9.8609E-03  1.3998E-04  5.0669E-04  9.6033E-03  6.3477E-04  9.5226E-03  3.2455E-02
            -4.3275E-03  2.7566E-02  2.5234E-02 -5.1163E-03  4.9932E-02  2.9998E-03
 PARAMETER:  1.0111E-01 -9.9997E-02 -9.9993E-02  1.0102E-01  1.0600E-01  9.9230E-02  1.0021E-01  9.9927E-02  1.0005E-01  1.1910E-01
            -7.5546E-02  9.9154E-02  8.8142E-02 -1.0550E-01  6.6893E-02  1.0002E-01
 GRADIENT:  -9.7418E-02 -1.0289E+01 -2.2788E+00  3.3556E-03  9.4568E-04  5.9531E-03  2.3245E-03  2.0057E-03 -5.9787E-04 -1.9459E-04
            -4.6602E-03 -4.1945E-03  9.1808E-04 -2.2805E-03  3.9775E-03 -1.1219E-02
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      645
 NO. OF SIG. DIGITS IN FINAL EST.:  3.3

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         4.3425E-05 -4.8406E-05 -5.0784E-05 -1.8308E-03 -1.2017E-04 -1.8899E-04
 SE:             2.2444E-03  3.3920E-03  3.3554E-03  4.2888E-02  3.9227E-02  5.5279E-02
 N:                     800         800         800          16          16          16
 
 P VAL.:         9.8456E-01  9.8861E-01  9.8792E-01  9.6595E-01  9.9756E-01  9.9727E-01
 
 ETASHRINKSD(%)  3.6073E+01  2.0992E+00  2.7464E+00  1.6506E+00  1.0000E-10  1.0000E-10
 ETASHRINKVR(%)  5.9133E+01  4.1544E+00  5.4173E+00  3.2740E+00  1.0000E-10  1.0000E-10
 EBVSHRINKSD(%)  3.5998E+01  2.0801E+00  2.7417E+00  5.5756E-02  1.5670E-02  1.0314E-02
 EBVSHRINKVR(%)  5.9038E+01  4.1170E+00  5.4081E+00  1.1148E-01  3.1337E-02  2.0628E-02
 RELATIVEINF(%)  4.0935E+01  9.5861E+01  9.4816E+01  9.9799E+01  9.9965E+01  9.9970E+01
 EPSSHRINKSD(%)  1.2282E+01
 EPSSHRINKVR(%)  2.3056E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -17194.8093188692     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -2491.79278759448     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2448
  
 #TERE:
 Elapsed estimation  time in seconds:  1005.15
 Elapsed covariance  time in seconds:   194.20
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
 
         1.33E-02  9.26E-03  1.21E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        8.59E-04
 
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
+        1.77E-04
 
 TH 2
+       -8.94E-06  8.57E-05
 
 TH 3
+        7.09E-05 -9.94E-06  1.46E-04
 
 OM11
+       -3.27E-09 -2.55E-10 -2.78E-10  7.38E-07
 
 OM12
+       -2.00E-08 -4.08E-09 -4.75E-09  5.06E-08  2.81E-07
 
 OM13
+        2.84E-08  5.36E-09  6.48E-09  9.44E-08  3.62E-08  3.49E-07
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        5.58E-10  1.76E-10  2.22E-10  2.27E-09  2.27E-08  2.60E-09 ......... ......... .........  2.53E-07
 
 OM23
+        3.45E-11 -1.92E-10 -1.89E-10  3.26E-09  1.91E-08  1.32E-08 ......... ......... .........  2.90E-08  1.29E-07
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        2.41E-09  1.96E-10  2.47E-10  4.93E-09  3.86E-09  3.53E-08 ......... ......... .........  3.31E-09  2.83E-08 .........
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
+        1.10E-06 -1.56E-08  3.39E-07  6.66E-08  1.33E-08  1.19E-08 ......... ......... .........  1.37E-09  2.92E-09 .........
         ......... .........  8.59E-10 ......... ......... .........  1.53E-04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -3.54E-08  1.74E-07 -3.60E-08  9.10E-09  1.86E-08  3.25E-09 ......... ......... .........  7.54E-09  1.31E-09 .........
         ......... .........  1.27E-09 ......... ......... ......... -1.59E-05  6.01E-05
 
 OM46
+        4.32E-07 -1.32E-08  3.75E-07  1.49E-08  4.25E-09  2.31E-08 ......... ......... .........  1.07E-09  5.01E-09 .........
         ......... .........  1.20E-09 ......... ......... .........  1.26E-04 -1.67E-05  1.66E-04
 
 OM55
+       -8.00E-09  4.07E-08 -1.47E-09  2.98E-09  5.96E-09  1.13E-09 ......... ......... .........  6.82E-09  2.24E-09 .........
         ......... .........  7.56E-10 ......... ......... .........  1.67E-06 -9.32E-06  1.86E-06  8.25E-05
 
 OM56
+        1.12E-08  2.26E-08  1.27E-08  3.59E-09  5.09E-09  4.48E-09 ......... ......... .........  4.74E-09  3.44E-09 .........
         ......... .........  2.44E-09 ......... ......... ......... -1.25E-05  4.90E-05 -1.81E-05 -1.28E-05  8.39E-05
 
 OM66
+        9.42E-08 -2.34E-08  1.14E-07  2.08E-09  1.30E-09  1.08E-08 ......... ......... .........  1.21E-09  5.07E-09 .........
         ......... .........  4.59E-09 ......... ......... .........  1.03E-04 -1.64E-05  1.86E-04  2.26E-06 -2.66E-05  3.24E-04
 
 SG11
+       -2.06E-10  3.03E-09  3.03E-09 -1.11E-09 -3.71E-10 -3.59E-10 ......... ......... ......... -2.53E-10 -2.47E-10 .........
         ......... ......... -2.73E-10 ......... ......... ......... -1.07E-08 -5.13E-09 -6.13E-09 -5.10E-09 -5.69E-09 -6.98E-09
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
+        1.33E-02
 
 TH 2
+       -7.26E-02  9.26E-03
 
 TH 3
+        4.40E-01 -8.87E-02  1.21E-02
 
 OM11
+       -2.87E-04 -3.21E-05 -2.67E-05  8.59E-04
 
 OM12
+       -2.84E-03 -8.30E-04 -7.40E-04  1.11E-01  5.31E-04
 
 OM13
+        3.62E-03  9.81E-04  9.07E-04  1.86E-01  1.16E-01  5.91E-04
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        8.33E-05  3.78E-05  3.64E-05  5.25E-03  8.50E-02  8.75E-03 ......... ......... .........  5.03E-04
 
 OM23
+        7.23E-06 -5.79E-05 -4.35E-05  1.06E-02  1.00E-01  6.22E-02 ......... ......... .........  1.60E-01  3.59E-04
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        3.59E-04  4.20E-05  4.05E-05  1.14E-02  1.44E-02  1.18E-01 ......... ......... .........  1.30E-02  1.56E-01 .........
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
+        6.67E-03 -1.36E-04  2.26E-03  6.27E-03  2.03E-03  1.63E-03 ......... ......... .........  2.20E-04  6.58E-04 .........
         ......... .........  1.38E-04 ......... ......... .........  1.24E-02
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -3.43E-04  2.42E-03 -3.84E-04  1.37E-03  4.52E-03  7.10E-04 ......... ......... .........  1.93E-03  4.72E-04 .........
         ......... .........  3.24E-04 ......... ......... ......... -1.65E-01  7.75E-03
 
 OM46
+        2.52E-03 -1.11E-04  2.41E-03  1.34E-03  6.21E-04  3.04E-03 ......... ......... .........  1.64E-04  1.08E-03 .........
         ......... .........  1.84E-04 ......... ......... .........  7.90E-01 -1.67E-01  1.29E-02
 
 OM55
+       -6.62E-05  4.84E-04 -1.34E-05  3.83E-04  1.24E-03  2.11E-04 ......... ......... .........  1.49E-03  6.87E-04 .........
         ......... .........  1.65E-04 ......... ......... .........  1.49E-02 -1.32E-01  1.59E-02  9.08E-03
 
 OM56
+        9.20E-05  2.66E-04  1.15E-04  4.56E-04  1.05E-03  8.29E-04 ......... ......... .........  1.03E-03  1.05E-03 .........
         ......... .........  5.28E-04 ......... ......... ......... -1.10E-01  6.89E-01 -1.53E-01 -1.54E-01  9.16E-03
 
 OM66
+        3.94E-04 -1.40E-04  5.24E-04  1.34E-04  1.37E-04  1.02E-03 ......... ......... .........  1.34E-04  7.84E-04 .........
         ......... .........  5.06E-04 ......... ......... .........  4.62E-01 -1.18E-01  8.02E-01  1.39E-02 -1.61E-01  1.80E-02
 
 SG11
+       -2.82E-04  5.97E-03  4.56E-03 -2.35E-02 -1.28E-02 -1.11E-02 ......... ......... ......... -9.15E-03 -1.26E-02 .........
         ......... ......... -9.86E-03 ......... ......... ......... -1.57E-02 -1.21E-02 -8.67E-03 -1.02E-02 -1.13E-02 -7.08E-03
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
+        7.02E+03
 
 TH 2
+        3.41E+02  1.18E+04
 
 TH 3
+       -3.38E+03  6.35E+02  8.51E+03
 
 OM11
+        8.26E+01  5.80E+00 -3.71E+01  1.42E+06
 
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
+       -4.93E+01 -3.77E+01 -1.17E+00  6.95E+03 -2.73E+05  2.52E+04 ......... ......... .........  4.07E+06
 
 OM23
+       -1.14E+01 -6.18E+00  2.88E+00  2.67E+04 -4.56E+05 -1.76E+05 ......... ......... ......... -8.87E+05  8.23E+06
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        1.46E+01  7.03E+00 -2.00E+00  2.37E+04  4.59E+04 -3.90E+05 ......... ......... .........  4.66E+04 -8.73E+05 .........
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
+       -1.04E+02 -6.54E+00  5.64E+01 -1.60E+03 -6.31E+02  1.23E+03 ......... ......... ......... -1.16E+01  3.26E+02 .........
         ......... ......... -2.08E+02 ......... ......... .........  2.24E+04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -8.42E+00 -6.26E+01  2.62E+00 -3.15E+02 -1.82E+03  1.09E+02 ......... ......... ......... -5.15E+02  5.39E+02 .........
         ......... .........  1.85E+01 ......... ......... .........  1.39E+03  3.24E+04
 
 OM46
+        9.03E+01 -4.71E+00 -8.70E+01  1.58E+03  4.79E+02 -2.15E+03 ......... ......... ......... -1.98E+01 -5.47E+02 .........
         ......... .........  4.77E+02 ......... ......... ......... -2.52E+04  1.52E+03  4.56E+04
 
 OM55
+        6.65E-01 -8.79E+00 -1.43E+00 -7.74E+00 -2.71E+02 -7.80E+00 ......... ......... ......... -3.24E+02 -1.03E+02 .........
         ......... ......... -7.81E+00 ......... ......... ......... -1.51E+01  7.45E+02  6.25E+01  1.24E+04
 
 OM56
+        2.36E+00  3.05E+01 -4.31E+00  1.62E+02  8.56E+02 -2.09E+02 ......... ......... .........  8.18E+01 -5.64E+02 .........
         ......... ......... -6.58E+01 ......... ......... ......... -5.55E+02 -1.86E+04 -5.78E+02  1.48E+03  2.33E+04
 
 OM66
+       -1.97E+01  4.44E+00  2.97E+01 -3.90E+02 -8.39E+01  7.47E+02 ......... ......... .........  1.42E+00  9.69E+01 .........
         ......... ......... -2.38E+02 ......... ......... .........  7.38E+03 -1.21E+03 -1.81E+04  4.23E+01  1.47E+03  1.12E+04
 
 SG11
+        3.32E+03 -1.26E+04 -9.37E+03  4.53E+05  2.80E+05  1.45E+05 ......... ......... .........  2.44E+05  4.56E+05 .........
         ......... .........  2.69E+05 ......... ......... .........  4.60E+04  2.63E+04 -3.66E+04  2.53E+04  1.51E+04  1.59E+04
         3.33E+08
 
 Elapsed finaloutput time in seconds:     0.05
 #CPUT: Total CPU Time in Seconds,     1262.781
Stop Time: 
Mon 02/01/2021 
10:17 AM
