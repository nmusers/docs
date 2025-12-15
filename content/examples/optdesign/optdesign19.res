Tue 04/23/2019 
09:03 PM

$PROB RUN# Example 1 (from samp5l)
$INPUT C SET ID JID TIME  DV=CONC AMT=DOSE RATE EVID MDV CMT TSTRAT TMIN TMAX
$DATA optdesign2.csv IGNORE=C

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

$OPTDESIGN APPROX=FOCEI MODE=0 NELDER DESEL=TIME DESELSTRAT=TSTRAT DESELMIN=TMIN DESELMAX=TMAX
         MAXEVAL=9999 SIGL=12 nohabort PRINT=200 FNLETA=0
$SIM (553423 NORMAL) (2933012 UNIFORM) 
$TABLE ID ETA1 ETA2 ETA3 ETA4 TIME EVID MDV DV NOPRINT NOAPPEND FILE=optdesign19.tab  FORMAT=S1PE23.16
  
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
 NO. OF DATA RECS IN DATA SET:        6
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

 TOT. NO. OF OBS RECS:        5
 TOT. NO. OF INDIVIDUALS:        1
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
0SIMULATION STEP OMITTED:    NO
 ORIGINAL DATA USED ON EACH NEW SIMULATION:         NO
 SEEDS RESET ON EACH NEW SUPERSET ITERATION:        YES
0SIMULATION RANDOM METHOD SELECTED (RANMETHOD): 4U
SEED   1 RESET TO INITIAL: YES
 SOURCE   1:
   SEED1:        553423   SEED2:             0   PSEUDO-NORMAL
SEED   2 RESET TO INITIAL: YES
 SOURCE   2:
   SEED1:       2933012   SEED2:             0   PSEUDO-UNIFORM
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
0WARNING: THE NUMBER OF PARAMETERS TO BE ESTIMATED
 EXCEEDS THE NUMBER OF INDIVIDUALS WITH DATA.
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      12
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     12
 NOPRIOR SETTING (NOPRIOR):                 OFF
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          OFF
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      OFF
 RAW OUTPUT FILE (FILE): optdesign19.ext
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
 BLOCK DIAGONALIZATION TYPE FOR DESIGN: -1
 STANDARD NONMEM RESIDUAL VARIANCE MODELING (VAR_CROSS=0)
 EVALUATE AT F(ETAsim) DURING CONDITIONAL DESIGN ASSESSMENT
 DESIGN GROUPSIZE=  1.0000000000000000E+00
 OPTIMALITY RANDOM GENERATION SEED: -1
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

 ITERATION NO.:          0    OBJECTIVE VALUE:  -19.2348760242971        NO. OF FUNC. EVALS.:           1
 ITERATION NO.:        200    OBJECTIVE VALUE:  -19.9737043939518        NO. OF FUNC. EVALS.:         627
 ITERATION NO.:        400    OBJECTIVE VALUE:  -19.9738940425682        NO. OF FUNC. EVALS.:        1109
 ITERATION NO.:        600    OBJECTIVE VALUE:  -19.9740769977723        NO. OF FUNC. EVALS.:        1581
 ITERATION NO.:        800    OBJECTIVE VALUE:  -19.9742809413066        NO. OF FUNC. EVALS.:        2086
 ITERATION NO.:       1000    OBJECTIVE VALUE:  -19.9744855221014        NO. OF FUNC. EVALS.:        2598
 ITERATION NO.:       1200    OBJECTIVE VALUE:  -19.9746860005922        NO. OF FUNC. EVALS.:        3097
 ITERATION NO.:       1400    OBJECTIVE VALUE:  -19.9748798642973        NO. OF FUNC. EVALS.:        3588
 ITERATION NO.:       1600    OBJECTIVE VALUE:  -19.9750850361175        NO. OF FUNC. EVALS.:        4097
 ITERATION NO.:       1800    OBJECTIVE VALUE:  -19.9752812863743        NO. OF FUNC. EVALS.:        4590
 ITERATION NO.:       2000    OBJECTIVE VALUE:  -19.9754872847843        NO. OF FUNC. EVALS.:        5102
 ITERATION NO.:       2200    OBJECTIVE VALUE:  -19.9756744888711        NO. OF FUNC. EVALS.:        5581
 ITERATION NO.:       2400    OBJECTIVE VALUE:  -19.9758582538165        NO. OF FUNC. EVALS.:        6050
 ITERATION NO.:       2600    OBJECTIVE VALUE:  -19.9760433038333        NO. OF FUNC. EVALS.:        6529
 ITERATION NO.:       2800    OBJECTIVE VALUE:  -19.9762421590343        NO. OF FUNC. EVALS.:        7027
 ITERATION NO.:       3000    OBJECTIVE VALUE:  -19.9764484148840        NO. OF FUNC. EVALS.:        7541
 ITERATION NO.:       3200    OBJECTIVE VALUE:  -19.9766452665833        NO. OF FUNC. EVALS.:        8039
 ITERATION NO.:       3400    OBJECTIVE VALUE:  -19.9768452533734        NO. OF FUNC. EVALS.:        8541
 ITERATION NO.:       3600    OBJECTIVE VALUE:  -19.9770408900333        NO. OF FUNC. EVALS.:        9035
 ITERATION NO.:       3800    OBJECTIVE VALUE:  -19.9772452184820        NO. OF FUNC. EVALS.:        9548
 ITERATION NO.:       4000    OBJECTIVE VALUE:  -19.9774302767271        NO. OF FUNC. EVALS.:       10025
 ITERATION NO.:       4200    OBJECTIVE VALUE:  -19.9776162834501        NO. OF FUNC. EVALS.:       10504
 ITERATION NO.:       4400    OBJECTIVE VALUE:  -19.9778010825243        NO. OF FUNC. EVALS.:       10981
 ITERATION NO.:       4600    OBJECTIVE VALUE:  -19.9780103028099        NO. OF FUNC. EVALS.:       11497
 ITERATION NO.:       4800    OBJECTIVE VALUE:  -19.9782007734362        NO. OF FUNC. EVALS.:       11982
 ITERATION NO.:       5000    OBJECTIVE VALUE:  -19.9783920379905        NO. OF FUNC. EVALS.:       12469
 ITERATION NO.:       5200    OBJECTIVE VALUE:  -19.9785795181876        NO. OF FUNC. EVALS.:       12949
 ITERATION NO.:       5400    OBJECTIVE VALUE:  -19.9787718405477        NO. OF FUNC. EVALS.:       13437
 ITERATION NO.:       5600    OBJECTIVE VALUE:  -19.9789718072752        NO. OF FUNC. EVALS.:       13944
 ITERATION NO.:       5800    OBJECTIVE VALUE:  -19.9791594773402        NO. OF FUNC. EVALS.:       14424
 ITERATION NO.:       6000    OBJECTIVE VALUE:  -19.9793573634196        NO. OF FUNC. EVALS.:       14922
 ITERATION NO.:       6200    OBJECTIVE VALUE:  -19.9795598307122        NO. OF FUNC. EVALS.:       15429
 ITERATION NO.:       6400    OBJECTIVE VALUE:  -19.9797442524495        NO. OF FUNC. EVALS.:       15906
 ITERATION NO.:       6600    OBJECTIVE VALUE:  -19.9799409271676        NO. OF FUNC. EVALS.:       16404
 ITERATION NO.:       6800    OBJECTIVE VALUE:  -19.9801444713034        NO. OF FUNC. EVALS.:       16912
 ITERATION NO.:       7000    OBJECTIVE VALUE:  -19.9803365878242        NO. OF FUNC. EVALS.:       17401
 ITERATION NO.:       7200    OBJECTIVE VALUE:  -19.9805300006188        NO. OF FUNC. EVALS.:       17892
 ITERATION NO.:       7400    OBJECTIVE VALUE:  -19.9807155884530        NO. OF FUNC. EVALS.:       18371
 ITERATION NO.:       7600    OBJECTIVE VALUE:  -19.9809117765685        NO. OF FUNC. EVALS.:       18869
 ITERATION NO.:       7800    OBJECTIVE VALUE:  -19.9811044544248        NO. OF FUNC. EVALS.:       19362
 ITERATION NO.:       8000    OBJECTIVE VALUE:  -19.9812916497897        NO. OF FUNC. EVALS.:       19843
 ITERATION NO.:       8200    OBJECTIVE VALUE:  -19.9814888733484        NO. OF FUNC. EVALS.:       20343
 ITERATION NO.:       8400    OBJECTIVE VALUE:  -19.9816910190677        NO. OF FUNC. EVALS.:       20847
 ITERATION NO.:       8600    OBJECTIVE VALUE:  -19.9818828982759        NO. OF FUNC. EVALS.:       21338
 ITERATION NO.:       8800    OBJECTIVE VALUE:  -19.9820712198721        NO. OF FUNC. EVALS.:       21820
 ITERATION NO.:       9000    OBJECTIVE VALUE:  -19.9822749674964        NO. OF FUNC. EVALS.:       22331
 ITERATION NO.:       9200    OBJECTIVE VALUE:  -19.9824714467590        NO. OF FUNC. EVALS.:       22830
 ITERATION NO.:       9400    OBJECTIVE VALUE:  -19.9826847933110        NO. OF FUNC. EVALS.:       23355
 ITERATION NO.:       9600    OBJECTIVE VALUE:  -19.9828765455756        NO. OF FUNC. EVALS.:       23845
 ITERATION NO.:       9800    OBJECTIVE VALUE:  -19.9830610113865        NO. OF FUNC. EVALS.:       24321
 ITERATION NO.:       9999    OBJECTIVE VALUE:  -19.9832592160686        NO. OF FUNC. EVALS.:       24825
 ITERATION NO.:       9999    OBJECTIVE VALUE:  -19.9832592160686        NO. OF FUNC. EVALS.:       24825
 
 #TERM:
 NO. OF FUNCTION EVALUATIONS USED:    24825
0MINIMIZATION TERMINATED
  DUE TO MAXIMUM NUMBER OF ITERATIONS EXCEEDED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         5.1815E-02  2.1686E-01 -4.2523E-02 -2.0890E-01
 SE:             0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 N:                       1           1           1           1
 
 P VAL.:         0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 
 ETASHRINKSD(%)  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 ETASHRINKVR(%)  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 EBVSHRINKSD(%)  8.1439E+00  2.3730E+01  4.1457E+01  4.4382E+01
 EBVSHRINKVR(%)  1.5625E+01  4.1829E+01  6.5727E+01  6.9067E+01
 EPSSHRINKSD(%)  5.5279E+01  5.5279E+01
 EPSSHRINKVR(%)  8.0000E+01  8.0000E+01
 
 #TERE:
 Elapsed opt. design time in seconds:    25.17
 SKIPPING EXECUTION OF SLOW FNLMOD/FNLETA BY USER REQUEST
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************        FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION: D-OPTIMALITY       ********************
 #OBJT:**************                MINIMUM VALUE OF OBJECTIVE FUNCTION: D-OPTIMALITY               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************      -19.983       **************************************************
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
 
         1.56E-01  1.95E-01  2.77E-01  2.78E-01
 


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
+        2.53E-02
 
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
+        8.43E-02
 
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
     2.44E-02         9.63E-03         3.80E-02         1.03E-02         1.01E-02         7.68E-02         8.20E-03

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4    SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4    
     9.78E-03         3.15E-02         7.72E-02         1.39E-03         4.94E-04         7.58E-04         7.02E-04

   SG11 | SG11      
     6.39E-04
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************        FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION: D-OPTIMALITY       ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     1.56E-01         3.17E-01         1.95E-01         2.38E-01         1.86E-01         2.77E-01         1.89E-01

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4    SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4    
     1.81E-01         4.09E-01         2.78E-01         3.52E-01         1.00E-01         1.08E-01         9.99E-02

   SG11 | SG11      
     2.53E-02
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************        FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION: D-OPTIMALITY       ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     5.33E+01        -1.07E+01         3.00E+01        -4.04E+00        -1.71E+00         1.63E+01        -1.74E+00

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4    SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4    
    -2.00E+00        -5.97E+00         1.59E+01        -1.01E+02         4.33E+00        -2.60E+00        -5.02E+00

   SG11 | SG11      
     1.79E+03
 Elapsed finaloutput time in seconds:     0.02
 #CPUT: Total CPU Time in Seconds,       23.572
Stop Time: 
Tue 04/23/2019 
09:03 PM
