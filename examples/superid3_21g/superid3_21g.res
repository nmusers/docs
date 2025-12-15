Mon 02/01/2021 
12:50 PM
$PROB RUN# 
$INPUT C ID TIME DV AMT RATE EVID MDV CMT ROWNUM SID
$DATA superid3.csv IGNORE=C

$SUBROUTINES ADVAN2 TRANS2

$PK
MU_1=THETA(1)
MU_2=THETA(2)
MU_3=THETA(3)
KA=DEXP(MU_1+ETA(1))
CL=DEXP(MU_2+ETA(2))
V=DEXP(MU_3+ETA(3))
S2=V

$ERROR
IPRE=F
Y = IPRE + IPRE*EPS(1)

; Initial values of THETA



$THETA  1.80785E-01 -5.31285E+00 -3.08196E+00 
;INITIAL values of OMEGA
$OMEGA BLOCK(3)

 9.86080E-03 
 1.39934E-04  9.60331E-03 
 5.06628E-04  6.34611E-04  9.52273E-03 

;Initial value of SIGMA
$SIGMA 
 2.99981E-03    ;[P]

;$CHAIN FILE=superid3_21_old.ext TBLN=4 ISAMPLE=-1000000000 nsample=0

$EST METHOD=ITS INTERACTION PRINT=1 SIGL=8 FNLETA=0 NOPRIOR=1 NITER=15
$EST METHOD=1 INTERACTION PRINT=1 NSIG=3 SIGL=10 FNLETA=0 SLOW NONINFETA=1 NOPRIOR=1 MAXEVAL=9999
$COV MATRIX=R PRINT=R UNCONDITIONAL
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  126) ONLY THE LAST FNLETA LISTED IN THE SERIES OF $EST RECORDS FOR
 THIS PROBLEM WILL BE USED
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
  
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
0INITIAL ESTIMATE OF SIGMA:
 0.3000E-02
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
 NO. OF FUNCT. EVALS. ALLOWED:            360
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
 RAW OUTPUT FILE (FILE): superid3_21g.ext
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
 ITERATIONS (NITER):                        15
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

 iteration            0 OBJ=  -11519.9956239863
 iteration            1 OBJ=  -15571.4718133479
 iteration            2 OBJ=  -15693.7327112514
 iteration            3 OBJ=  -15718.3904899069
 iteration            4 OBJ=  -15724.8010709249
 iteration            5 OBJ=  -15726.5870776764
 iteration            6 OBJ=  -15727.1010586523
 iteration            7 OBJ=  -15727.2515148191
 iteration            8 OBJ=  -15727.2959635288
 iteration            9 OBJ=  -15727.3091512715
 iteration           10 OBJ=  -15727.3130648952
 iteration           11 OBJ=  -15727.3142209438
 iteration           12 OBJ=  -15727.3145583145
 iteration           13 OBJ=  -15727.3146542729
 iteration           14 OBJ=  -15727.3146800283
 iteration           15 OBJ=  -15727.3146860425
 
 #TERM:
 OPTIMIZATION WAS NOT TESTED FOR CONVERGENCE


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.2540E-06  2.3264E-08  3.0898E-08
 SE:             5.7660E-03  6.5542E-03  8.5710E-03
 N:                     800         800         800
 
 P VAL.:         9.9983E-01  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  2.0576E+01  6.3640E-01  4.8917E-01
 ETASHRINKVR(%)  3.6918E+01  1.2688E+00  9.7595E-01
 EBVSHRINKSD(%)  2.0580E+01  6.3641E-01  4.8921E-01
 EBVSHRINKVR(%)  3.6924E+01  1.2688E+00  9.7603E-01
 RELATIVEINF(%)  4.7073E+01  9.8477E+01  9.9861E+01
 EPSSHRINKSD(%)  1.3007E+01
 EPSSHRINKVR(%)  2.4323E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -15727.3146860425     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -1024.29815476772     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2400
  
 #TERE:
 Elapsed estimation  time in seconds:    12.35
 Elapsed covariance  time in seconds:     0.16
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -15727.315       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         1.80E-01 -5.31E+00 -3.08E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        4.22E-02
 
 ETA2
+       -4.27E-03  3.49E-02
 
 ETA3
+        2.80E-02 -4.54E-03  5.94E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.00E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        2.05E-01
 
 ETA2
+       -1.11E-01  1.87E-01
 
 ETA3
+        5.58E-01 -9.97E-02  2.44E-01
 


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
 
         1.03E-02  7.00E-03  9.03E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        2.96E-03
 
 ETA2
+        2.00E-03  2.15E-03
 
 ETA3
+        2.95E-03  1.82E-03  3.88E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        5.52E-05
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        7.20E-03
 
 ETA2
+        5.18E-02  5.75E-03
 
 ETA3
+        3.85E-02  3.84E-02  7.96E-03
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.04E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (S)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM22      OM23      OM33      SG11  
 
 TH 1
+        1.06E-04
 
 TH 2
+       -6.35E-06  4.90E-05
 
 TH 3
+        3.85E-05 -6.16E-06  8.15E-05
 
 OM11
+        6.19E-06  5.76E-07  3.36E-06  8.76E-06
 
 OM12
+       -1.68E-06 -5.68E-07  3.83E-06  2.17E-07  3.98E-06
 
 OM13
+        3.53E-06  4.86E-06  1.81E-06  5.61E-06 -4.16E-07  8.70E-06
 
 OM22
+       -5.91E-08  1.48E-06 -2.15E-06  3.21E-07 -7.62E-07  6.22E-07  4.61E-06
 
 OM23
+        3.23E-06 -2.30E-06  2.69E-06 -8.23E-08  1.83E-06 -1.35E-06 -8.57E-07  3.33E-06
 
 OM33
+        6.03E-07  4.88E-06  2.04E-06  3.23E-06 -1.13E-06  7.58E-06  4.74E-07 -2.70E-06  1.51E-05
 
 SG11
+       -3.71E-10  3.03E-09 -8.71E-09 -1.55E-09 -2.09E-09  9.90E-10  6.11E-10  6.01E-10 -2.85E-09  3.05E-09
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (S)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM22      OM23      OM33      SG11  
 
 TH 1
+        1.03E-02
 
 TH 2
+       -8.80E-02  7.00E-03
 
 TH 3
+        4.14E-01 -9.76E-02  9.03E-03
 
 OM11
+        2.03E-01  2.78E-02  1.26E-01  2.96E-03
 
 OM12
+       -8.17E-02 -4.07E-02  2.13E-01  3.67E-02  2.00E-03
 
 OM13
+        1.16E-01  2.35E-01  6.81E-02  6.43E-01 -7.07E-02  2.95E-03
 
 OM22
+       -2.67E-03  9.89E-02 -1.11E-01  5.05E-02 -1.78E-01  9.83E-02  2.15E-03
 
 OM23
+        1.72E-01 -1.80E-01  1.63E-01 -1.52E-02  5.03E-01 -2.50E-01 -2.19E-01  1.82E-03
 
 OM33
+        1.51E-02  1.80E-01  5.82E-02  2.81E-01 -1.46E-01  6.62E-01  5.69E-02 -3.81E-01  3.88E-03
 
 SG11
+       -6.52E-04  7.85E-03 -1.75E-02 -9.45E-03 -1.90E-02  6.08E-03  5.15E-03  5.97E-03 -1.33E-02  5.52E-05
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (S)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM22      OM23      OM33      SG11  
 
 TH 1
+        1.31E+04
 
 TH 2
+        6.06E+02  2.28E+04
 
 TH 3
+       -6.23E+03  1.24E+03  1.64E+04
 
 OM11
+       -5.52E+03  9.80E+03 -1.54E+03  2.20E+05
 
 OM12
+        2.05E+04 -4.97E+03 -1.96E+04 -1.18E+04  3.81E+05
 
 OM13
+       -3.83E+03 -1.94E+04  2.34E+03 -1.80E+05 -1.13E+04  3.65E+05
 
 OM22
+       -2.46E+03 -4.04E+03  4.73E+03 -4.23E+03  1.77E+04 -1.27E+04  2.34E+05
 
 OM23
+       -1.97E+04  9.54E+03  3.13E+03 -1.90E+04 -2.16E+05  2.52E+04  4.98E+04  5.16E+05
 
 OM33
+        1.32E+03  1.51E+03 -4.28E+03  3.64E+04  1.11E+03 -1.35E+05  1.10E+04  6.32E+04  1.38E+05
 
 SG11
+        1.31E+03 -1.09E+04  2.42E+04  1.85E+05  2.50E+05 -3.20E+05 -1.50E+04 -2.22E+05  1.63E+05  3.28E+08
 
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
 RAW OUTPUT FILE (FILE): superid3_21g.ext
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

 
0ITERATION NO.:    0    OBJECTIVE VALUE:  -15727.3146860034        NO. OF FUNC. EVALS.:  11
 CUMULATIVE NO. OF FUNC. EVALS.:       11
 NPARAMETR:  1.8025E-01 -5.3130E+00 -3.0822E+00  4.2215E-02 -4.2743E-03  2.7956E-02  3.4851E-02 -4.5381E-03  5.9423E-02  3.0010E-03

 PARAMETER:  1.0000E-01 -1.0000E-01 -1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01

 GRADIENT:  -1.8743E+01 -2.5918E+02  2.1137E+01  5.6129E-01 -1.2993E-01  2.9473E+00  1.8466E+00  3.4221E-02  1.5102E+00 -1.2085E+00

 
0ITERATION NO.:    1    OBJECTIVE VALUE:  -15727.3147988476        NO. OF FUNC. EVALS.:  20
 CUMULATIVE NO. OF FUNC. EVALS.:       31
 NPARAMETR:  1.8025E-01 -5.3127E+00 -3.0822E+00  4.2215E-02 -4.2743E-03  2.7956E-02  3.4851E-02 -4.5381E-03  5.9423E-02  3.0010E-03

 PARAMETER:  1.0000E-01 -9.9995E-02 -1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01

 GRADIENT:  -1.7895E+01  3.4432E+02  2.8078E+01  5.7406E-01 -1.0191E-01  2.9483E+00  1.8404E+00  4.9622E-02  1.5477E+00 -1.2809E+00

 
0ITERATION NO.:    2    OBJECTIVE VALUE:  -15727.3151044247        NO. OF FUNC. EVALS.:  21
 CUMULATIVE NO. OF FUNC. EVALS.:       52
 NPARAMETR:  1.8025E-01 -5.3128E+00 -3.0822E+00  4.2215E-02 -4.2743E-03  2.7956E-02  3.4851E-02 -4.5381E-03  5.9423E-02  3.0010E-03

 PARAMETER:  1.0000E-01 -9.9997E-02 -1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01

 GRADIENT:  -1.7994E+01  6.3691E+01  1.3678E+01  5.9237E-01 -8.8139E-02  2.9502E+00  1.9002E+00  6.0942E-02  1.5452E+00 -1.2348E+00

 
0ITERATION NO.:    3    OBJECTIVE VALUE:  -15727.3151186812        NO. OF FUNC. EVALS.:  21
 CUMULATIVE NO. OF FUNC. EVALS.:       73
 NPARAMETR:  1.8026E-01 -5.3128E+00 -3.0822E+00  4.2215E-02 -4.2743E-03  2.7955E-02  3.4851E-02 -4.5381E-03  5.9423E-02  3.0010E-03

 PARAMETER:  1.0000E-01 -9.9997E-02 -1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01

 GRADIENT:  -1.7220E+01  6.6167E+01 -1.5856E+01  5.7496E-01 -8.1724E-02  2.9465E+00  1.8923E+00  5.3016E-02  1.5648E+00 -1.2139E+00

 
0ITERATION NO.:    4    OBJECTIVE VALUE:  -15727.3172349855        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:       89
 NPARAMETR:  1.8093E-01 -5.3129E+00 -3.0819E+00  4.2214E-02 -4.2741E-03  2.7938E-02  3.4848E-02 -4.5362E-03  5.9397E-02  3.0012E-03

 PARAMETER:  1.0038E-01 -9.9998E-02 -9.9992E-02  9.9987E-02 -9.9998E-02  9.9937E-02  9.9959E-02 -1.0000E-01  9.9967E-02  1.0003E-01

 GRADIENT:   7.7688E+00  6.6502E+01  2.6913E+01  7.2055E-01 -1.0692E-01 -2.8109E-01  1.7599E+00  4.9616E-02  1.2563E+00 -6.0192E-01

 
0ITERATION NO.:    5    OBJECTIVE VALUE:  -15727.3176036274        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:      105
 NPARAMETR:  1.8090E-01 -5.3129E+00 -3.0819E+00  4.2207E-02 -4.2733E-03  2.7910E-02  3.4833E-02 -4.5330E-03  5.9350E-02  3.0018E-03

 PARAMETER:  1.0036E-01 -9.9998E-02 -9.9992E-02  9.9903E-02 -9.9987E-02  9.9845E-02  9.9733E-02 -1.0001E-01  9.9797E-02  1.0012E-01

 GRADIENT:   6.6427E+00  6.0099E+01  2.6718E+01  8.6820E-01 -6.5795E-02 -5.1129E+00  1.0832E+00  4.5260E-02  5.4662E-01  1.7059E+00

 
0ITERATION NO.:    6    OBJECTIVE VALUE:  -15727.3181151026        NO. OF FUNC. EVALS.:  15
 CUMULATIVE NO. OF FUNC. EVALS.:      120
 NPARAMETR:  1.8092E-01 -5.3129E+00 -3.0819E+00  4.2192E-02 -4.2716E-03  2.7938E-02  3.4804E-02 -4.5353E-03  5.9369E-02  3.0021E-03

 PARAMETER:  1.0037E-01 -9.9998E-02 -9.9992E-02  9.9726E-02 -9.9966E-02  9.9964E-02  9.9321E-02 -1.0002E-01  9.9501E-02  1.0017E-01

 GRADIENT:   7.2027E+00  4.8265E+01  2.8358E+01  2.0807E-01  3.0839E-02  3.2323E-01 -1.8974E-01  1.1557E-02  3.1773E-01  2.9173E+00

 
0ITERATION NO.:    7    OBJECTIVE VALUE:  -15727.3182659143        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:      136
 NPARAMETR:  1.8092E-01 -5.3129E+00 -3.0819E+00  4.2187E-02 -4.2712E-03  2.7931E-02  3.4795E-02 -4.5345E-03  5.9353E-02  3.0014E-03

 PARAMETER:  1.0037E-01 -9.9998E-02 -9.9992E-02  9.9662E-02 -9.9961E-02  9.9945E-02  9.9196E-02 -1.0002E-01  9.9388E-02  1.0007E-01

 GRADIENT:   7.1300E+00  4.3982E+01  2.6294E+01  1.4071E-01  4.2031E-02 -7.8029E-01 -5.8145E-01 -1.7022E-03 -4.1477E-02  3.1703E-01

 
0ITERATION NO.:    8    OBJECTIVE VALUE:  -15727.3182945150        NO. OF FUNC. EVALS.:  15
 CUMULATIVE NO. OF FUNC. EVALS.:      151
 NPARAMETR:  1.8091E-01 -5.3129E+00 -3.0819E+00  4.2179E-02 -4.2714E-03  2.7929E-02  3.4801E-02 -4.5351E-03  5.9346E-02  3.0015E-03

 PARAMETER:  1.0037E-01 -9.9998E-02 -9.9992E-02  9.9575E-02 -9.9975E-02  9.9948E-02  9.9274E-02 -1.0003E-01  9.9285E-02  1.0007E-01

 GRADIENT:   7.1965E+00  4.5488E+01  2.5179E+01 -2.3014E-02  2.1151E-02 -6.9337E-01 -3.2550E-01  3.3340E-02 -2.6556E-01  3.8615E-01

 
0ITERATION NO.:    9    OBJECTIVE VALUE:  -15727.3182961474        NO. OF FUNC. EVALS.:  15
 CUMULATIVE NO. OF FUNC. EVALS.:      166
 NPARAMETR:  1.8091E-01 -5.3129E+00 -3.0819E+00  4.2176E-02 -4.2719E-03  2.7927E-02  3.4801E-02 -4.5361E-03  5.9346E-02  3.0015E-03

 PARAMETER:  1.0037E-01 -9.9998E-02 -9.9992E-02  9.9540E-02 -9.9990E-02  9.9945E-02  9.9273E-02 -1.0007E-01  9.9304E-02  1.0007E-01

 GRADIENT:   7.1810E+00  4.4750E+01  2.6280E+01 -4.7181E-02  1.4104E-02 -7.0315E-01 -3.2850E-01 -7.5510E-03 -2.2125E-01  3.9840E-01

 
0ITERATION NO.:   10    OBJECTIVE VALUE:  -15727.3182986952        NO. OF FUNC. EVALS.:  13
 CUMULATIVE NO. OF FUNC. EVALS.:      179
 NPARAMETR:  1.8091E-01 -5.3129E+00 -3.0819E+00  4.2178E-02 -4.2743E-03  2.7928E-02  3.4801E-02 -4.5380E-03  5.9346E-02  3.0015E-03

 PARAMETER:  1.0037E-01 -9.9998E-02 -9.9992E-02  9.9560E-02 -1.0004E-01  9.9947E-02  9.9273E-02 -1.0008E-01  9.9291E-02  1.0007E-01

 GRADIENT:   7.1002E+00  4.4192E+01  2.5290E+01 -6.9349E-02 -8.1504E-02 -6.8753E-01 -3.4575E-01 -1.8947E-02 -2.9606E-01  3.8787E-01

 
0ITERATION NO.:   11    OBJECTIVE VALUE:  -15727.3183938410        NO. OF FUNC. EVALS.:  12
 CUMULATIVE NO. OF FUNC. EVALS.:      191
 NPARAMETR:  1.8087E-01 -5.3129E+00 -3.0819E+00  4.2195E-02 -4.2706E-03  2.7941E-02  3.4805E-02 -4.5411E-03  5.9346E-02  3.0014E-03

 PARAMETER:  1.0035E-01 -9.9998E-02 -9.9993E-02  9.9766E-02 -9.9937E-02  9.9973E-02  9.9336E-02 -1.0039E-01  9.9162E-02  1.0007E-01

 GRADIENT:   5.7479E+00  3.7454E+01  1.6700E+01  2.3405E-01 -2.2685E-02 -4.9438E-01 -1.9965E-01 -8.4960E-02 -4.7094E-01  3.3892E-01

 
0ITERATION NO.:   12    OBJECTIVE VALUE:  -15727.3186526814        NO. OF FUNC. EVALS.:  13
 CUMULATIVE NO. OF FUNC. EVALS.:      204
 NPARAMETR:  1.8079E-01 -5.3129E+00 -3.0820E+00  4.2187E-02 -4.2721E-03  2.7936E-02  3.4807E-02 -4.5393E-03  5.9352E-02  3.0014E-03

 PARAMETER:  1.0030E-01 -9.9998E-02 -9.9994E-02  9.9667E-02 -9.9983E-02  9.9964E-02  9.9360E-02 -1.0022E-01  9.9280E-02  1.0006E-01

 GRADIENT:   2.6970E+00  1.7686E+01  7.9974E+00  7.2752E-02 -5.5637E-02 -2.5186E-01 -9.6190E-02 -5.6010E-02 -2.4715E-01  1.7222E-01

 
0ITERATION NO.:   13    OBJECTIVE VALUE:  -15727.3187103616        NO. OF FUNC. EVALS.:  12
 CUMULATIVE NO. OF FUNC. EVALS.:      216
 NPARAMETR:  1.8071E-01 -5.3129E+00 -3.0820E+00  4.2182E-02 -4.2721E-03  2.7933E-02  3.4808E-02 -4.5361E-03  5.9358E-02  3.0013E-03

 PARAMETER:  1.0026E-01 -9.9998E-02 -9.9995E-02  9.9611E-02 -9.9988E-02  9.9958E-02  9.9378E-02 -1.0004E-01  9.9389E-02  1.0005E-01

 GRADIENT:  -2.3425E-02 -4.1015E-01 -3.5686E-01  1.7666E-02 -2.4764E-02  4.7308E-02 -9.2732E-03 -1.5227E-02  1.5643E-03 -2.9036E-02

 
0ITERATION NO.:   14    OBJECTIVE VALUE:  -15727.3187103616        NO. OF FUNC. EVALS.:  20
 CUMULATIVE NO. OF FUNC. EVALS.:      236
 NPARAMETR:  1.8071E-01 -5.3129E+00 -3.0820E+00  4.2182E-02 -4.2721E-03  2.7933E-02  3.4808E-02 -4.5361E-03  5.9358E-02  3.0013E-03

 PARAMETER:  1.0026E-01 -9.9998E-02 -9.9995E-02  9.9611E-02 -9.9988E-02  9.9958E-02  9.9378E-02 -1.0004E-01  9.9389E-02  1.0005E-01

 GRADIENT:  -6.7243E-02 -6.5035E+01 -1.5959E+01  2.5202E-02 -1.8200E-02  9.4737E-03 -1.9820E-02  1.0044E-02  1.3563E-04 -4.0257E-02

 
0ITERATION NO.:   15    OBJECTIVE VALUE:  -15727.3187103616        NO. OF FUNC. EVALS.:   0
 CUMULATIVE NO. OF FUNC. EVALS.:      236
 NPARAMETR:  1.8071E-01 -5.3129E+00 -3.0820E+00  4.2182E-02 -4.2721E-03  2.7933E-02  3.4808E-02 -4.5361E-03  5.9358E-02  3.0013E-03

 PARAMETER:  1.0026E-01 -9.9998E-02 -9.9995E-02  9.9611E-02 -9.9988E-02  9.9958E-02  9.9378E-02 -1.0004E-01  9.9389E-02  1.0005E-01

 GRADIENT:  -6.7243E-02 -6.5035E+01 -1.5959E+01  2.5202E-02 -1.8200E-02  9.4737E-03 -1.9820E-02  1.0044E-02  1.3563E-04 -4.0257E-02

 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      236
 NO. OF SIG. DIGITS IN FINAL EST.:  3.4

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -2.4704E-04 -8.0332E-05 -1.4134E-04
 SE:             5.7663E-03  6.5541E-03  8.5709E-03
 N:                     800         800         800
 
 P VAL.:         9.6583E-01  9.9022E-01  9.8684E-01
 
 ETASHRINKSD(%)  2.0540E+01  5.7708E-01  4.3542E-01
 ETASHRINKVR(%)  3.6861E+01  1.1508E+00  8.6894E-01
 EBVSHRINKSD(%)  2.0579E+01  6.3723E-01  4.8978E-01
 EBVSHRINKVR(%)  3.6922E+01  1.2704E+00  9.7716E-01
 RELATIVEINF(%)  4.7070E+01  9.8475E+01  9.9860E+01
 EPSSHRINKSD(%)  1.3011E+01
 EPSSHRINKVR(%)  2.4329E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         8000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    14703.0165312748     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -15727.3187103616     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -1024.30217908685     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2400
  
 #TERE:
 Elapsed estimation  time in seconds:   104.43
 Elapsed covariance  time in seconds:    35.80
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -15727.319       **************************************************
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


         ETA1      ETA2      ETA3     
 
 ETA1
+        4.22E-02
 
 ETA2
+       -4.27E-03  3.48E-02
 
 ETA3
+        2.79E-02 -4.54E-03  5.94E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.00E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        2.05E-01
 
 ETA2
+       -1.11E-01  1.87E-01
 
 ETA3
+        5.58E-01 -9.98E-02  2.44E-01
 


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
 
         9.69E-03  6.64E-03  8.66E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        3.06E-03
 
 ETA2
+        1.78E-03  1.76E-03
 
 ETA3
+        2.58E-03  1.63E-03  3.00E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        5.49E-05
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        7.45E-03
 
 ETA2
+        4.59E-02  4.73E-03
 
 ETA3
+        3.41E-02  3.55E-02  6.15E-03
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.01E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM22      OM23      OM33      SG11  
 
 TH 1
+        9.38E-05
 
 TH 2
+       -4.45E-06  4.41E-05
 
 TH 3
+        3.60E-05 -5.03E-06  7.50E-05
 
 OM11
+        4.06E-07  1.42E-08  2.50E-08  9.38E-06
 
 OM12
+       -1.89E-07 -6.24E-09 -1.48E-08 -6.59E-07  3.16E-06
 
 OM13
+        3.21E-07  7.43E-09  2.14E-08  5.40E-06 -5.11E-07  6.67E-06
 
 OM22
+       -4.89E-09  4.13E-09  5.36E-09  3.41E-08 -3.13E-07  3.80E-08  3.11E-06
 
 OM23
+       -8.12E-10 -1.87E-09 -6.74E-09 -2.59E-07  1.29E-06 -4.14E-07 -3.53E-07  2.66E-06
 
 OM33
+        4.55E-08 -5.18E-09  6.63E-09  2.07E-06 -2.91E-07  4.31E-06  4.32E-08 -6.04E-07  8.99E-06
 
 SG11
+       -3.93E-10  3.02E-09  2.99E-09 -2.05E-09 -6.90E-10 -7.70E-10 -4.85E-10 -5.16E-10 -5.85E-10  3.01E-09
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM22      OM23      OM33      SG11  
 
 TH 1
+        9.69E-03
 
 TH 2
+       -6.91E-02  6.64E-03
 
 TH 3
+        4.29E-01 -8.75E-02  8.66E-03
 
 OM11
+        1.37E-02  7.00E-04  9.41E-04  3.06E-03
 
 OM12
+       -1.09E-02 -5.28E-04 -9.64E-04 -1.21E-01  1.78E-03
 
 OM13
+        1.28E-02  4.33E-04  9.56E-04  6.83E-01 -1.11E-01  2.58E-03
 
 OM22
+       -2.86E-04  3.53E-04  3.51E-04  6.32E-03 -9.98E-02  8.35E-03  1.76E-03
 
 OM23
+       -5.13E-05 -1.72E-04 -4.77E-04 -5.19E-02  4.44E-01 -9.82E-02 -1.23E-01  1.63E-03
 
 OM33
+        1.57E-03 -2.60E-04  2.55E-04  2.25E-01 -5.47E-02  5.57E-01  8.17E-03 -1.24E-01  3.00E-03
 
 SG11
+       -7.38E-04  8.27E-03  6.30E-03 -1.22E-02 -7.06E-03 -5.43E-03 -5.01E-03 -5.76E-03 -3.56E-03  5.49E-05
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************          FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (NO PRIOR)        ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM22      OM23      OM33      SG11  
 
 TH 1
+        1.31E+04
 
 TH 2
+        6.07E+02  2.29E+04
 
 TH 3
+       -6.24E+03  1.25E+03  1.64E+04
 
 OM11
+       -2.54E+02 -4.82E+01  1.00E+02  2.15E+05
 
 OM12
+        8.29E+02  7.73E+01 -3.44E+02  2.02E+04  4.00E+05
 
 OM13
+       -5.29E+02 -4.47E+01  2.19E+02 -2.05E+05  7.69E+03  4.14E+05
 
 OM22
+        6.95E+01 -3.03E+01 -5.50E+01  4.30E+02  1.85E+04  7.91E+02  3.27E+05
 
 OM23
+       -4.53E+02 -2.90E+01  2.16E+02 -9.50E+03 -1.90E+05  6.59E+03  3.48E+04  4.77E+05
 
 OM33
+        2.48E+02  4.09E+01 -1.06E+02  4.88E+04 -8.20E+03 -1.51E+05  8.96E+02  2.48E+04  1.74E+05
 
 SG11
+        7.16E+03 -2.41E+04 -1.83E+04  1.06E+05  7.64E+04 -5.96E+04  6.36E+04  4.38E+04  3.09E+04  3.32E+08
 
 Elapsed finaloutput time in seconds:     0.02
 #CPUT: Total CPU Time in Seconds,      159.266
Stop Time: 
Mon 02/01/2021 
12:53 PM
