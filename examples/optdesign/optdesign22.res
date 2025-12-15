Tue 04/23/2019 
12:07 PM
$PROB RUN# Example 1 (from samp5l)
$INPUT C SET ID JID TIME  DV=CONC AMT=DOSE RATE EVID MDV CMT TSTRAT TMIN TMAX
$DATA optdesign21.csv IGNORE=C REPL=100

$SUBROUTINES ADVAN3 TRANS4

$PK
; The thetas are MU modeled.  
; Best that there is a linear relationship between THETAs and Mus
; The linear MU modeling of THETAS allows them to be efficiently 
; Gibbs sampled.

MU_1=THETA(1)
MU_2=THETA(2)
MU_3=THETA(3)
MU_4=THETA(4)
CL=DEXP(MU_1+ETA(1))
V1=DEXP(MU_2+ETA(2))
Q=DEXP(MU_3+ETA(3))
V2=DEXP(MU_4+ETA(4))
S1=V1

$ERROR
Y = F + F*EPS(1)+EPS(2)

; Initial values of THETA
$THETA 
 1.68338E+00  1.58812E+00  8.12710E-01  2.37436E+00 


;INITIAL values of OMEGA
;$OMEGA BLOCK(4) VALUES(0.0225,0.001)
$OMEGA (0.0225 FIXED)X4

;Initial value of SIGMA
$SIGMA 
( 0.0225)
( 0.0001 FIXED)

$DESIGN NELDER MODE=1 FIMTYPE=1 GROUPSIZE=0.01 SEED=1222345 APPROX=FOCEI
           DESEL=TIME DESELSTRAT=TSTRAT DESELMIN=TMIN DESELMAX=TMAX
           MAXEVAL=400 SIGL=10 nohabort FNLETA=0 PRINT=10
$TABLE ID ETA1 ETA2 ETA3 ETA4 TIME EVID MDV DV NOPRINT NOAPPEND FILE=optdesign22.tab  FORMAT=S1PE23.16
  
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
 RUN# Example 1 (from samp5l)
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA ITEMS IN DATA SET:  14
 ID DATA ITEM IS DATA ITEM NO.:   3
 DEP VARIABLE IS DATA ITEM NO.:   6
 MDV DATA ITEM IS DATA ITEM NO.: 10
0INDICES PASSED TO SUBROUTINE PRED:
   9   5   7   8   0   0  11   0   0   0   0
0LABELS FOR DATA ITEMS:
 C SET ID JID TIME CONC DOSE RATE EVID MDV CMT TSTRAT TMIN TMAX
0FORMAT FOR DATA:
 (14E5.0)

 TOT. NO. OF DATA RECS:       600
 TOT. NO. OF OBS RECS:      500
 TOT. NO. OF INDIVIDUALS:      100
0LENGTH OF THETA:   4
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   4
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS BLOCK FORM:
  1
  0  2
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.1683E+01  0.1588E+01  0.8127E+00  0.2374E+01
0INITIAL ESTIMATE OF OMEGA:
 0.2250E-01
 0.0000E+00   0.2250E-01
 0.0000E+00   0.0000E+00   0.2250E-01
 0.0000E+00   0.0000E+00   0.0000E+00   0.2250E-01
0OMEGA CONSTRAINED TO BE THIS INITIAL ESTIMATE
0INITIAL ESTIMATE OF SIGMA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.2250E-01
        2                                                                                  YES
                  0.1000E-03
0COVARIANCE STEP OMITTED:        NO
 R MATRIX SUBSTITUTED:          YES
 S MATRIX SUBSTITUTED:           NO
 EIGENVLS. PRINTED:              NO
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
 FORMAT:                S1PE23.16
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID ETA1 ETA2 ETA3 ETA4 TIME EVID MDV CONC
1DOUBLE PRECISION PREDPP VERSION 7.5.0 alpha version 7

 TWO COMPARTMENT MODEL (ADVAN3)
0MAXIMUM NO. OF BASIC PK PARAMETERS:   4
0BASIC PK PARAMETERS (AFTER TRANSLATION):
   BASIC PK PARAMETER NO.  1: ELIMINATION RATE (K)
   BASIC PK PARAMETER NO.  2: CENTRAL-TO-PERIPH. RATE (K12)
   BASIC PK PARAMETER NO.  3: PERIPH.-TO-CENTRAL RATE (K21)
 TRANSLATOR WILL CONVERT PARAMETERS
 CL, V1, Q, V2 TO K, K12, K21 (TRANS4)
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         CENTRAL      ON         NO         YES        YES        YES
    2         PERIPH.      ON         NO         YES        NO         NO
    3         OUTPUT       OFF        YES        NO         NO         NO
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            5           *           *           *           *
    2            *           *           *           *           *
    3            *           -           -           -           -
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
1
 
 
 #TBLN:      1
 #METH: First Order Conditional Estimation with Interaction: D-OPTIMALITY
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            400
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
 FINAL ETA RE-EVALUATION (FNLETA):          OFF
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      OFF
 RAW OUTPUT FILE (FILE): optdesign22.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 WISHART PRIOR DF INTERPRETATION (WISHTYPE):0
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 ADDITIONAL CONVERGENCE TEST (CTYPE=4)?:    NO
 EM OR BAYESIAN METHOD USED:                 NONE

 DESIGN TYPE: D-OPTIMALITY, -LOG(DET(FIM))
 SIMULATE OBSERVED DATA FOR DESIGN:  NO
 BLOCK DIAGONALIZATION TYPE FOR DESIGN:  1
 STANDARD NONMEM RESIDUAL VARIANCE MODELING (VAR_CROSS=0)
 EVALUATE AT THE MODE F(ETAhat) DURING CONDITIONAL DESIGN ASSESSMENT
 DESIGN GROUPSIZE=  1.0000000000000000E-02
 OPTIMALITY RANDOM GENERATION SEED: 1222345
 DESIGN OPTIMIZATION: NELDER
 OPTIMAL DESIGN ELEMENT, STRAT, MIN, MAX COLUMNS: TIME,TSTRAT,TMIN,TMAX
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 MONITORING OF SEARCH:

 ITERATION NO.:          0    OBJECTIVE VALUE:  -18.2934776543376        NO. OF FUNC. EVALS.:           1
 ITERATION NO.:         10    OBJECTIVE VALUE:  -19.9739982297064        NO. OF FUNC. EVALS.:          45
 ITERATION NO.:         20    OBJECTIVE VALUE:  -19.9944437260448        NO. OF FUNC. EVALS.:          85
 ITERATION NO.:         30    OBJECTIVE VALUE:  -19.9969717677008        NO. OF FUNC. EVALS.:         127
 ITERATION NO.:         40    OBJECTIVE VALUE:  -19.9977376182833        NO. OF FUNC. EVALS.:         160
 ITERATION NO.:         50    OBJECTIVE VALUE:  -19.9982888607893        NO. OF FUNC. EVALS.:         188
 ITERATION NO.:         60    OBJECTIVE VALUE:  -19.9985679687487        NO. OF FUNC. EVALS.:         213
 ITERATION NO.:         70    OBJECTIVE VALUE:  -19.9989351311993        NO. OF FUNC. EVALS.:         248
 ITERATION NO.:         80    OBJECTIVE VALUE:  -19.9991058992965        NO. OF FUNC. EVALS.:         283
 ITERATION NO.:         90    OBJECTIVE VALUE:  -19.9991908146657        NO. OF FUNC. EVALS.:         316
 ITERATION NO.:        100    OBJECTIVE VALUE:  -19.9992556832051        NO. OF FUNC. EVALS.:         351
 ITERATION NO.:        108    OBJECTIVE VALUE:  -19.9992866033919        NO. OF FUNC. EVALS.:         374
 
 #TERM:
 NO. OF FUNCTION EVALUATIONS USED:      374
0MINIMIZATION SUCCESSFUL

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.2094E-02  1.1265E-02 -6.2978E-03  6.4610E-03
 SE:             1.3691E-02  8.3599E-03  6.6698E-03  7.5653E-03
 N:                     100         100         100         100
 
 P VAL.:         3.7704E-01  1.7781E-01  3.4505E-01  3.9309E-01
 
 ETASHRINKSD(%)  8.2675E+00  4.3987E+01  5.5311E+01  4.9310E+01
 ETASHRINKVR(%)  1.5851E+01  6.8625E+01  8.0029E+01  7.4306E+01
 EBVSHRINKSD(%)  6.9170E+00  2.3375E+01  3.4261E+01  3.1672E+01
 EBVSHRINKVR(%)  1.3355E+01  4.1286E+01  5.6784E+01  5.3313E+01
 EPSSHRINKSD(%)  5.5279E+01  5.5279E+01
 EPSSHRINKVR(%)  8.0000E+01  8.0000E+01
 
 #TERE:
 Elapsed opt. design time in seconds:    37.27
 SKIPPING EXECUTION OF SLOW FNLMOD/FNLETA BY USER REQUEST
 Elapsed postprocess time in seconds:     0.02
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************        FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION: D-OPTIMALITY       ********************
 #OBJT:**************                MINIMUM VALUE OF OBJECTIVE FUNCTION: D-OPTIMALITY               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************      -19.999       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************        FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION: D-OPTIMALITY       ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         1.68E+00  1.59E+00  8.13E-01  2.37E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        2.25E-02
 
 ETA2
+        0.00E+00  2.25E-02
 
 ETA3
+        0.00E+00  0.00E+00  2.25E-02
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  2.25E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        2.25E-02
 
 EPS2
+        0.00E+00  1.00E-04
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        1.50E-01
 
 ETA2
+        0.00E+00  1.50E-01
 
 ETA3
+        0.00E+00  0.00E+00  1.50E-01
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.50E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        1.50E-01
 
 EPS2
+        0.00E+00  1.00E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************        FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION: D-OPTIMALITY       ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         1.67E-01  2.07E-01  2.59E-01  2.48E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+       .........
 
 ETA2
+       ......... .........
 
 ETA3
+       ......... ......... .........
 
 ETA4
+       ......... ......... ......... .........
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        2.36E-02
 
 EPS2
+       ......... .........
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+       .........
 
 ETA2
+       ......... .........
 
 ETA3
+       ......... ......... .........
 
 ETA4
+       ......... ......... ......... .........
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        7.88E-02
 
 EPS2
+       ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************        FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION: D-OPTIMALITY       ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     2.80E-02         6.79E-03         4.29E-02         7.47E-03         1.07E-02         6.70E-02         6.43E-03

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4    SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4    
     1.01E-02         2.52E-02         6.13E-02         0.00E+00         0.00E+00         0.00E+00         0.00E+00

   SG11 | SG11      
     5.59E-04
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************        FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION: D-OPTIMALITY       ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     1.67E-01         1.96E-01         2.07E-01         1.72E-01         1.99E-01         2.59E-01         1.55E-01

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4    SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4    
     1.98E-01         3.93E-01         2.48E-01         0.00E+00         0.00E+00         0.00E+00         0.00E+00

   SG11 | SG11      
     2.36E-02
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************        FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION: D-OPTIMALITY       ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     3.80E+01        -4.87E+00         2.53E+01        -2.69E+00        -2.50E+00         1.82E+01        -2.08E+00

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4    SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4    
    -2.65E+00        -6.77E+00         1.98E+01         0.00E+00         0.00E+00         0.00E+00         0.00E+00

   SG11 | SG11      
     1.79E+03
 Elapsed finaloutput time in seconds:     0.03
 #CPUT: Total CPU Time in Seconds,       19.999
Stop Time: 
Tue 04/23/2019 
12:07 PM
