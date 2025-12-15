Sun 03/21/2021 
07:12 PM
$PROBLEM WARFARIN
$INPUT  ID TIME AMT EVID MDV DV IPREDZ
; data file based on 15 time points, from warfarin_fob4
$DATA warfarin_fobc5.tab ignore=@ REPL=100

$SUBROUTINES ADVAN2 TRANS2

$PK
MU_1=LOG(THETA(1))
MU_2=LOG(THETA(2))
MU_3=LOG(THETA(3))
CL=THETA(1)*EXP(ETA(1))
V=THETA(2)*EXP(ETA(2))
KA=THETA(3)*EXP(ETA(3))
S2=V
F1=1.0

$ERROR
IPRED=A(2)/V
Y=IPRED*(1.0+EPS(1)) + EPS(2)

$THETA
0.15 ;[CL]
8.0  ;[V]
1.0  ;[KA]

$OMEGA (0.07 ) (0.02 ) (0.6 )
$SIGMA (0.01 ) (0.001 FIX )

$SIML (3344567) SUBP=1

$EST METHOD=1 INTERACTION MAXEVAL=0 nohabort PRINT=1
$COV MATRIX=R UNCONDITIONAL
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
  
Note: Analytical 2nd Derivatives are constructed in FSUBS but are never used.
      You may insert $ABBR DERIV2=NO after the first $PROB to save FSUBS construction and compilation time
  
  
License Registered to: IDS NONMEM 7 TEAM
Expiration Date:     2 JUN 2030
Current Date:       21 MAR 2021
Days until program expires :3356
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.1
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 WARFARIN
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA ITEMS IN DATA SET:   7
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   6
 MDV DATA ITEM IS DATA ITEM NO.:  5
0INDICES PASSED TO SUBROUTINE PRED:
   4   2   3   0   0   0   0   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID TIME AMT EVID MDV DV IPREDZ
0FORMAT FOR DATA:
 (6E11.0/E11.0)

 TOT. NO. OF DATA RECS:       900
 TOT. NO. OF OBS RECS:      800
 TOT. NO. OF INDIVIDUALS:      100
0LENGTH OF THETA:   3
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   3
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS BLOCK FORM:
  1
  0  2
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.1500E+00  0.8000E+01  0.1000E+01
0INITIAL ESTIMATE OF OMEGA:
 0.7000E-01
 0.0000E+00   0.2000E-01
 0.0000E+00   0.0000E+00   0.6000E+00
0INITIAL ESTIMATE OF SIGMA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.1000E-01
        2                                                                                  YES
                  0.1000E-02
0SIMULATION STEP OMITTED:    NO
 ORIGINAL DATA USED ON EACH NEW SIMULATION:         NO
 SEEDS RESET ON EACH NEW SUPERSET ITERATION:        YES
0SIMULATION RANDOM METHOD SELECTED (RANMETHOD): 4U
SEED   1 RESET TO INITIAL: YES
 SOURCE   1:
   SEED1:       3344567   SEED2:             0   PSEUDO-NORMAL
 NUMBER OF SUBPROBLEMS:    1
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
    1            *           5           *           *           *
    2            4           *           *           *           *
    3            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      4
   TIME DATA ITEM IS DATA ITEM NO.:          2
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   3

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
0ERROR SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
1
 PROBLEM NO.:           1      SUBPROBLEM NO.:           1

 SIMULATION STEP PERFORMED
 SOURCE  1:
    SEED1:    1836723036   SEED2:             0
 Elapsed simulation  time in seconds:     0.01
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
 RAW OUTPUT FILE (FILE): cts_fobc5.ext
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

 Elapsed evaluation time in seconds:     0.09
 Elapsed covariance  time in seconds:     3.09
 Elapsed postprocess time in seconds:     0.01
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************         FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (EVALUATION)       ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************       54.930       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************         FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (EVALUATION)       ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         1.50E-01  8.00E+00  1.00E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        7.00E-02
 
 ETA2
+        0.00E+00  2.00E-02
 
 ETA3
+        0.00E+00  0.00E+00  6.00E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        1.00E-02
 
 EPS2
+        0.00E+00  1.00E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        2.65E-01
 
 ETA2
+        0.00E+00  1.41E-01
 
 ETA3
+        0.00E+00  0.00E+00  7.75E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        1.00E-01
 
 EPS2
+        0.00E+00  3.16E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************         FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (EVALUATION)       ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         4.34E-03  1.24E-01  7.60E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        1.10E-02
 
 ETA2
+       .........  3.17E-03
 
 ETA3
+       ......... .........  1.03E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        6.94E-04
 
 EPS2
+       ......... .........
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        2.08E-02
 
 ETA2
+       .........  1.12E-02
 
 ETA3
+       ......... .........  6.65E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        3.47E-03
 
 EPS2
+       ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************         FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (EVALUATION)       ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM22      OM23      OM33      SG11      SG12      SG22  

 
 TH 1
+        1.88E-05
 
 TH 2
+        2.24E-05  1.54E-02
 
 TH 3
+        3.20E-06  3.72E-04  5.78E-03
 
 OM11
+        1.41E-05  1.69E-05  2.60E-06  1.21E-04
 
 OM12
+       ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -8.24E-08 -6.22E-05 -5.97E-08  1.37E-07 ......... .........  1.01E-05
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM33
+        8.92E-07  7.25E-05 -1.97E-03  3.23E-06 ......... .........  5.45E-06 .........  1.06E-02
 
 SG11
+        6.90E-08  4.08E-06 -1.17E-07 -1.29E-07 ......... ......... -2.28E-07 ......... -1.80E-06  4.82E-07
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************         FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (EVALUATION)       ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM22      OM23      OM33      SG11      SG12      SG22  

 
 TH 1
+        4.34E-03
 
 TH 2
+        4.17E-02  1.24E-01
 
 TH 3
+        9.71E-03  3.95E-02  7.60E-02
 
 OM11
+        2.95E-01  1.23E-02  3.10E-03  1.10E-02
 
 OM12
+       ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -5.99E-03 -1.58E-01 -2.48E-04  3.91E-03 ......... .........  3.17E-03
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM33
+        2.00E-03  5.67E-03 -2.51E-01  2.84E-03 ......... .........  1.67E-02 .........  1.03E-01
 
 SG11
+        2.29E-02  4.73E-02 -2.22E-03 -1.69E-02 ......... ......... -1.04E-01 ......... -2.52E-02  6.94E-04
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************         FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION (EVALUATION)       ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      OM12      OM13      OM22      OM23      OM33      SG11      SG12      SG22  

 
 TH 1
+        5.83E+04
 
 TH 2
+       -7.47E+01  6.69E+01
 
 TH 3
+       -2.77E+01 -4.82E+00  1.85E+02
 
 OM11
+       -6.77E+03 -1.34E+00 -7.27E-01  9.02E+03
 
 OM12
+       ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -1.06E+02  4.06E+02 -4.31E+01 -1.10E+02 ......... .........  1.03E+05
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM33
+       -9.07E+00 -1.62E+00  3.44E+01 -1.68E+00 ......... ......... -5.60E+01 .........  1.01E+02
 
 SG11
+       -9.63E+03 -3.71E+02  1.98E+02  3.34E+03 ......... .........  4.51E+04 .........  3.74E+02  2.10E+06
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 Elapsed finaloutput time in seconds:     0.02
 #CPUT: Total CPU Time in Seconds,        4.000
Stop Time: 
Sun 03/21/2021 
07:13 PM
