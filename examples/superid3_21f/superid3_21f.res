Mon 02/01/2021 
12:22 PM
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



; theta results from superid3_21c.ext
$THETA  1.80785E-01 -5.31285E+00 -3.08196E+00 
;INITIAL values of OMEGA
$OMEGA BLOCK(3)

 9.86080E-03 
 1.39934E-04  9.60331E-03 
 5.06628E-04  6.34611E-04  9.52273E-03 


$OMEGA BLOCK(3)
 3.24545E-02 
 -4.32801E-03  2.52337E-02 
  2.75669E-02 -5.11563E-03  4.99318E-02 

;Initial value of SIGMA
$SIGMA 
 2.99981E-03 FIXED    ;[P]

$EST METHOD=ITS PRINT=1 SIGL=8 FNLETA=0 NOPRIOR=1 NITER=0
$EST METHOD=1 PRINT=1 NSIG=3 SIGL=10 FNLETA=0 SLOW NONINFETA=1 NOPRIOR=1 MAXEVAL=0
$COV MATRIX=R PRINT=R UNCONDITIONAL
  
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
0LENGTH OF THETA:   3
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS BLOCK FORM:
  1
  1  1
  1  1  1
  0  0  0  2
  0  0  0  2  2
  0  0  0  2  2  2
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.1808E+00 -0.5313E+01 -0.3082E+01
0INITIAL ESTIMATE OF OMEGA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.9861E-02
                  0.1399E-03   0.9603E-02
                  0.5066E-03   0.6346E-03   0.9523E-02
        2                                                                                   NO
                  0.3245E-01
                 -0.4328E-02   0.2523E-01
                  0.2757E-01  -0.5116E-02   0.4993E-01
0INITIAL ESTIMATE OF SIGMA:
 0.3000E-02
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
 NO. OF FUNCT. EVALS. ALLOWED:            624
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
 NOPRIOR SETTING (NOPRIOR):                 1
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          0
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): superid3_21f.ext
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
 CONVERGENCE TYPE (CTYPE):                  0
 ITERATIONS (NITER):                        0
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

 iteration            0 OBJ=  -15727.3111414415
 
 #TERM:
 OPTIMIZATION WAS NOT TESTED FOR CONVERGENCE


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -7.0928E-05 -4.4218E-05 -9.0351E-06 -2.1901E-04 -8.0933E-05 -1.8677E-04
 SE:             1.3770E-03  1.8235E-03  1.5080E-03  4.8373E-03  4.7599E-03  7.2218E-03
 N:                     800         800         800         800         800         800
 
 P VAL.:         9.5892E-01  9.8065E-01  9.9522E-01  9.6389E-01  9.8643E-01  9.7937E-01
 
 ETASHRINKSD(%)  6.0754E+01  4.7336E+01  5.6264E+01  2.4006E+01  1.5194E+01  8.5311E+00
 ETASHRINKVR(%)  8.4597E+01  7.2265E+01  8.0872E+01  4.2249E+01  2.8079E+01  1.6334E+01
 EBVSHRINKSD(%)  6.0751E+01  4.7336E+01  5.6277E+01  2.3951E+01  1.5220E+01  8.5037E+00
 EBVSHRINKVR(%)  8.4596E+01  7.2265E+01  8.0883E+01  4.2165E+01  2.8124E+01  1.6284E+01
 RELATIVEINF(%)  1.0000E-10  1.0000E-10  0.0000E+00  1.0000E-10  1.0000E-10  0.0000E+00
 EPSSHRINKSD(%)  1.2991E+01
 EPSSHRINKVR(%)  2.4294E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -15727.3111414415     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -1024.29461016677     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          4800
  
 #TERE:
 Elapsed estimation  time in seconds:     0.62

 Number of Negative Eigenvalues in Matrix=           4
 Most negative value=  -1639589083.86486
 Most positive value=   1371274.13052806
 Forcing positive definiteness
 Root mean square deviation of matrix from original=   7.890621044962660E-016

 Elapsed covariance  time in seconds:     0.16
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -15727.311       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
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
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                          STANDARD ERROR OF ESTIMATE (S)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         1.03E-02  6.99E-03  9.03E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        6.55E+04
 
 ETA2
+        9.22E+04  5.48E+04
 
 ETA3
+        1.10E+05  5.11E+04  6.23E+04
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  6.55E+04
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  9.22E+04  5.48E+04
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  1.10E+05  5.11E+04  6.23E+04
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        0.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        3.30E+05
 
 ETA2
+        9.47E+06  2.79E+05
 
 ETA3
+        1.20E+10  5.27E+06  3.19E+05
 
 ETA4
+       ......... ......... .........  1.82E+05
 
 ETA5
+       ......... ......... .........  3.25E+06  1.72E+05
 
 ETA6
+       ......... ......... .........  1.20E+10  1.45E+06  1.39E+05
 


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
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 TH 1
+        1.07E-04
 
 TH 2
+       -6.15E-06  4.89E-05
 
 TH 3
+        3.89E-05 -5.96E-06  8.16E-05
 
 OM11
+       -1.99E-05  4.92E-06 -8.02E-05  4.29E+09
 
 OM12
+        1.39E-04 -3.50E-06  1.02E-04 -8.27E+08  8.50E+09
 
 OM13
+       -2.29E-04  1.33E-04 -1.70E-04 -1.55E+09 -3.68E+09  1.20E+10
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        4.56E-04 -2.58E-04  8.69E-04 -7.94E+07  1.40E+09 -1.91E+09  0.00E+00  0.00E+00  0.00E+00  3.00E+09
 
 OM23
+       -3.64E-04  1.98E-04 -8.20E-04  5.58E+08  4.45E+08 -1.82E+09  0.00E+00  0.00E+00  0.00E+00 -1.01E+09  2.61E+09
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+       -1.71E-04  8.09E-05 -4.34E-04  6.86E+08  2.13E+09 -3.73E+09  0.00E+00  0.00E+00  0.00E+00 -5.01E+08  2.16E+09  0.00E+00
          0.00E+00  0.00E+00  3.88E+09
 
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
+        2.62E-05 -4.32E-06  8.37E-05 -4.29E+09  8.27E+08  1.55E+09  0.00E+00  0.00E+00  0.00E+00  7.94E+07 -5.58E+08  0.00E+00
          0.00E+00  0.00E+00 -6.86E+08  0.00E+00  0.00E+00  0.00E+00  4.29E+09
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -1.41E-04  2.97E-06 -9.85E-05  8.27E+08 -8.50E+09  3.68E+09  0.00E+00  0.00E+00  0.00E+00 -1.40E+09 -4.45E+08  0.00E+00
          0.00E+00  0.00E+00 -2.13E+09  0.00E+00  0.00E+00  0.00E+00 -8.27E+08  8.50E+09
 
 OM46
+        2.32E-04 -1.28E-04  1.72E-04  1.55E+09  3.68E+09 -1.20E+10  0.00E+00  0.00E+00  0.00E+00  1.91E+09  1.82E+09  0.00E+00
          0.00E+00  0.00E+00  3.73E+09  0.00E+00  0.00E+00  0.00E+00 -1.55E+09 -3.68E+09  1.20E+10
 
 OM55
+       -4.56E-04  2.59E-04 -8.71E-04  7.94E+07 -1.40E+09  1.91E+09  0.00E+00  0.00E+00  0.00E+00 -3.00E+09  1.01E+09  0.00E+00
          0.00E+00  0.00E+00  5.01E+08  0.00E+00  0.00E+00  0.00E+00 -7.94E+07  1.40E+09 -1.91E+09  3.00E+09
 
 OM56
+        3.67E-04 -2.00E-04  8.23E-04 -5.58E+08 -4.45E+08  1.82E+09  0.00E+00  0.00E+00  0.00E+00  1.01E+09 -2.61E+09  0.00E+00
          0.00E+00  0.00E+00 -2.16E+09  0.00E+00  0.00E+00  0.00E+00  5.58E+08  4.45E+08 -1.82E+09 -1.01E+09  2.61E+09
 
 OM66
+        1.71E-04 -7.60E-05  4.36E-04 -6.86E+08 -2.13E+09  3.73E+09  0.00E+00  0.00E+00  0.00E+00  5.01E+08 -2.16E+09  0.00E+00
          0.00E+00  0.00E+00 -3.88E+09  0.00E+00  0.00E+00  0.00E+00  6.86E+08  2.13E+09 -3.73E+09 -5.01E+08  2.16E+09  3.88E+09
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        .........
 
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
+        1.03E-02
 
 TH 2
+       -8.51E-02  6.99E-03
 
 TH 3
+        4.17E-01 -9.43E-02  9.03E-03
 
 OM11
+       -2.94E-08  1.07E-08 -1.36E-07  6.55E+04
 
 OM12
+        1.46E-07 -5.43E-09  1.23E-07 -1.37E-01  9.22E+04
 
 OM13
+       -2.02E-07  1.73E-07 -1.72E-07 -2.15E-01 -3.64E-01  1.10E+05
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        8.05E-07 -6.73E-07  1.76E-06 -2.22E-02  2.78E-01 -3.19E-01  0.00E+00  0.00E+00  0.00E+00  5.48E+04
 
 OM23
+       -6.89E-07  5.54E-07 -1.78E-06  1.67E-01  9.45E-02 -3.25E-01  0.00E+00  0.00E+00  0.00E+00 -3.63E-01  5.11E+04
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+       -2.65E-07  1.86E-07 -7.71E-07  1.68E-01  3.72E-01 -5.47E-01  0.00E+00  0.00E+00  0.00E+00 -1.47E-01  6.78E-01  0.00E+00
          0.00E+00  0.00E+00  6.23E+04
 
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
+        3.87E-08 -9.44E-09  1.41E-07 -1.00E+00  1.37E-01  2.15E-01  0.00E+00  0.00E+00  0.00E+00  2.22E-02 -1.67E-01  0.00E+00
          0.00E+00  0.00E+00 -1.68E-01  0.00E+00  0.00E+00  0.00E+00  6.55E+04
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+       -1.48E-07  4.60E-09 -1.18E-07  1.37E-01 -1.00E+00  3.64E-01  0.00E+00  0.00E+00  0.00E+00 -2.78E-01 -9.45E-02  0.00E+00
          0.00E+00  0.00E+00 -3.72E-01  0.00E+00  0.00E+00  0.00E+00 -1.37E-01  9.22E+04
 
 OM46
+        2.05E-07 -1.67E-07  1.74E-07  2.15E-01  3.64E-01 -1.00E+00  0.00E+00  0.00E+00  0.00E+00  3.19E-01  3.25E-01  0.00E+00
          0.00E+00  0.00E+00  5.47E-01  0.00E+00  0.00E+00  0.00E+00 -2.15E-01 -3.64E-01  1.10E+05
 
 OM55
+       -8.05E-07  6.77E-07 -1.76E-06  2.22E-02 -2.78E-01  3.19E-01  0.00E+00  0.00E+00  0.00E+00 -1.00E+00  3.63E-01  0.00E+00
          0.00E+00  0.00E+00  1.47E-01  0.00E+00  0.00E+00  0.00E+00 -2.22E-02  2.78E-01 -3.19E-01  5.48E+04
 
 OM56
+        6.95E-07 -5.61E-07  1.78E-06 -1.67E-01 -9.45E-02  3.25E-01  0.00E+00  0.00E+00  0.00E+00  3.63E-01 -1.00E+00  0.00E+00
          0.00E+00  0.00E+00 -6.78E-01  0.00E+00  0.00E+00  0.00E+00  1.67E-01  9.45E-02 -3.25E-01 -3.63E-01  5.11E+04
 
 OM66
+        2.66E-07 -1.74E-07  7.75E-07 -1.68E-01 -3.72E-01  5.47E-01  0.00E+00  0.00E+00  0.00E+00  1.47E-01 -6.78E-01  0.00E+00
          0.00E+00  0.00E+00 -1.00E+00  0.00E+00  0.00E+00  0.00E+00  1.68E-01  3.72E-01 -5.47E-01 -1.47E-01  6.78E-01  6.23E+04
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        .........
 
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
+        1.31E+04
 
 TH 2
+        5.56E+02  2.28E+04
 
 TH 3
+       -6.28E+03  1.22E+03  1.64E+04
 
 OM11
+       -5.72E+03  9.86E+03 -1.40E+03  2.20E+05
 
 OM12
+        2.05E+04 -5.20E+03 -1.97E+04 -1.37E+04  3.81E+05
 
 OM13
+       -3.61E+03 -1.94E+04  2.20E+03 -1.81E+05 -9.92E+03  3.67E+05
 
 OM14
+       ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.49E+03 -4.15E+03  4.79E+03 -4.15E+03  1.65E+04 -1.28E+04  0.00E+00  0.00E+00  0.00E+00  2.34E+05
 
 OM23
+       -1.98E+04  9.65E+03  3.13E+03 -1.79E+04 -2.18E+05  2.37E+04  0.00E+00  0.00E+00  0.00E+00  4.93E+04  5.17E+05
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        1.30E+03  1.55E+03 -4.28E+03  3.71E+04  9.06E+02 -1.36E+05  0.00E+00  0.00E+00  0.00E+00  1.09E+04  6.31E+04  0.00E+00
          0.00E+00  0.00E+00  1.38E+05
 
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
+       -5.72E+03  9.86E+03 -1.40E+03  2.20E+05 -1.37E+04 -1.81E+05  0.00E+00  0.00E+00  0.00E+00 -4.15E+03 -1.79E+04  0.00E+00
          0.00E+00  0.00E+00  3.71E+04  0.00E+00  0.00E+00  0.00E+00  2.20E+05
 
1

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24  
             OM25      OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66  
            SG11  
 
 OM45
+        2.05E+04 -5.20E+03 -1.97E+04 -1.37E+04  3.81E+05 -9.92E+03  0.00E+00  0.00E+00  0.00E+00  1.65E+04 -2.18E+05  0.00E+00
          0.00E+00  0.00E+00  9.06E+02  0.00E+00  0.00E+00  0.00E+00 -1.37E+04  3.81E+05
 
 OM46
+       -3.61E+03 -1.94E+04  2.20E+03 -1.81E+05 -9.92E+03  3.67E+05  0.00E+00  0.00E+00  0.00E+00 -1.28E+04  2.37E+04  0.00E+00
          0.00E+00  0.00E+00 -1.36E+05  0.00E+00  0.00E+00  0.00E+00 -1.81E+05 -9.92E+03  3.67E+05
 
 OM55
+       -2.49E+03 -4.15E+03  4.79E+03 -4.15E+03  1.65E+04 -1.28E+04  0.00E+00  0.00E+00  0.00E+00  2.34E+05  4.93E+04  0.00E+00
          0.00E+00  0.00E+00  1.09E+04  0.00E+00  0.00E+00  0.00E+00 -4.15E+03  1.65E+04 -1.28E+04  2.34E+05
 
 OM56
+       -1.98E+04  9.65E+03  3.13E+03 -1.79E+04 -2.18E+05  2.37E+04  0.00E+00  0.00E+00  0.00E+00  4.93E+04  5.17E+05  0.00E+00
          0.00E+00  0.00E+00  6.31E+04  0.00E+00  0.00E+00  0.00E+00 -1.79E+04 -2.18E+05  2.37E+04  4.93E+04  5.17E+05
 
 OM66
+        1.30E+03  1.55E+03 -4.28E+03  3.71E+04  9.06E+02 -1.36E+05  0.00E+00  0.00E+00  0.00E+00  1.09E+04  6.31E+04  0.00E+00
          0.00E+00  0.00E+00  1.38E+05  0.00E+00  0.00E+00  0.00E+00  3.71E+04  9.06E+02 -1.36E+05  1.09E+04  6.31E+04  1.38E+05
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        .........
 
1
 
 
 #TBLN:      2
 #METH: First Order Conditional Estimation with Interaction (No Prior) (Evaluation)
 
 ESTIMATION STEP OMITTED:                 YES
 ANALYSIS TYPE:                           POPULATION
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
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
 RAW OUTPUT FILE (FILE): superid3_21f.ext
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
 
 Elapsed evaluation time in seconds:     0.77
0R MATRIX ALGORITHMICALLY SINGULAR
 AND ALGORITHMICALLY NON-POSITIVE-SEMIDEFINITE
0COVARIANCE STEP ABORTED
 Elapsed covariance  time in seconds:    48.80
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************   FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR) (EVALUATION)  ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -15727.311       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************   FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR) (EVALUATION)  ********************
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
 
 Elapsed finaloutput time in seconds:     0.01
 #CPUT: Total CPU Time in Seconds,       57.641
Stop Time: 
Mon 02/01/2021 
12:23 PM
