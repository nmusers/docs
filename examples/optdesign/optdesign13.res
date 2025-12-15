Tue 04/23/2019 
12:04 PM

$PROB RUN# Example 1 (from samp5l)
$INPUT C SET ID JID TIME  DV=CONC AMT=DOSE RATE EVID MDV CMT TYPE NMIN NMAX TSTRAT TMIN TMAX
$DATA optdesign11.csv IGNORE=C

$SUBROUTINES ADVAN3 TRANS4

$PK
; The thetas are MU modeled.  
; Best that there is a linear relationship between THETAs and Mus
; The linear MU modeling of THETAS allows them to be efficiently 
; Gibbs sampled.

IF(TYPE==1) MU_1=THETA(1)
IF(TYPE==2) MU_1=THETA(5)
IF(TYPE==3) MU_1=THETA(6)
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
 1.68338E+00  1.58812E+00  8.12710E-01  2.37436E+00 1.50 1.80


;INITIAL values of OMEGA
;$OMEGA BLOCK(4) VALUES(0.0225,0.001)
$OMEGA (0.0225 FIXED)X4

;Initial value of SIGMA
$SIGMA 
( 0.0225)
( 0.0001 FIXED)


$DESIGN DISCRETE_RS FIMTYPE=1 
        NMIN=NMIN NMAX=NMAX DESEL=TIME DESELSTRAT=TSTRAT DESELMIN=TMIN DESELMAX=TMAX
        MAXEVAL=400 SIGL=12 nohabort PRINT=100
$TABLE ID TIME EVID MDV DV NOPRINT NOAPPEND FILE=optdesign13.tab  FORMAT=S1PE23.16
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.

 (DATA WARNING   5) RECORD         4, DATA ITEM   6, CONTENTS: 1
 THE DV DATA ITEM IS POSITIVE, BUT THE MDV DATA ITEM IS 1

 (DATA WARNING   5) RECORD         5, DATA ITEM   6, CONTENTS: 1
 THE DV DATA ITEM IS POSITIVE, BUT THE MDV DATA ITEM IS 1

 (DATA WARNING   5) RECORD         6, DATA ITEM   6, CONTENTS: 1
 THE DV DATA ITEM IS POSITIVE, BUT THE MDV DATA ITEM IS 1

 (MU_WARNING 8) MU_001: SHOULD NOT BE DEFINED CONDITIONALLY.

 (MU_WARNING 2) MU_001: SHOULD BE DEFINED ONLY ONCE.

 (MU_WARNING 2) MU_001: SHOULD BE DEFINED ONLY ONCE.
  
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
 NO. OF DATA RECS IN DATA SET:       18
 NO. OF DATA ITEMS IN DATA SET:  17
 ID DATA ITEM IS DATA ITEM NO.:   3
 DEP VARIABLE IS DATA ITEM NO.:   6
 MDV DATA ITEM IS DATA ITEM NO.: 10
0INDICES PASSED TO SUBROUTINE PRED:
   9   5   7   8   0   0  11   0   0   0   0
0LABELS FOR DATA ITEMS:
 C SET ID JID TIME CONC DOSE RATE EVID MDV CMT TYPE NMIN NMAX TSTRAT TMIN TMAX
0FORMAT FOR DATA:
 (4E2.0,E5.0,E2.0,E4.0,5E2.0,3E3.0,E5.0,E3.0)

 TOT. NO. OF OBS RECS:       12
 TOT. NO. OF INDIVIDUALS:        3
0LENGTH OF THETA:   6
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   4
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS BLOCK FORM:
  1
  0  2
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.1683E+01  0.1588E+01  0.8127E+00  0.2374E+01  0.1500E+01  0.1800E+01
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
 ID TIME EVID MDV CONC
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
 #METH: First Order: D-OPTIMALITY
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 EPS-ETA INTERACTION:                     NO
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      12
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     12
 NOPRIOR SETTING (NOPRIOR):                 OFF
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          ON
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      OFF
 RAW OUTPUT FILE (FILE): optdesign13.ext
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
 DESIGN GROUPSIZE=  1.0000000000000000E+00
 OPTIMALITY RANDOM GENERATION SEED: -1
 DESIGN OPTIMIZATION:  DISCRETE NUMBER OF TIME POINTS SEARCH WITH RANDOM SEARCH (DISCRETE_RS)
 OPTIMAL DESIGN MINIMAL NUMBER OF TIME POINTS COLUMN:        NMIN
 OPTIMAL DESIGN MAXIMAL NUMBER OF TIME POINTS COLUMN:        NMAX
 OPTIMAL DESIGN ELEMENT, STRAT, MIN, MAX COLUMNS: TIME,TSTRAT,TMIN,TMAX
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=NPRED
 RES=NRES
 WRES=NWRES
 IWRS=NIWRES
 IPRD=NIPRED
 IRS=NIRES
 
 MONITORING OF SEARCH:

                ITERATION NO.:          0    OBJECTIVE VALUE:  -28.6464500040091        NO. OF FUNC. EVALS.:           1
                ITERATION NO.:        100    OBJECTIVE VALUE:  -29.2009690630405        NO. OF FUNC. EVALS.:         101
                ITERATION NO.:        200    OBJECTIVE VALUE:  -29.7084100547511        NO. OF FUNC. EVALS.:         201
                ITERATION NO.:        300    OBJECTIVE VALUE:  -29.9260142522814        NO. OF FUNC. EVALS.:         301
                ITERATION NO.:        400    OBJECTIVE VALUE:  -30.2685833617655        NO. OF FUNC. EVALS.:         401
0INITIAL VALUE, ITERATION NO.:        400    OBJECTIVE VALUE:  -30.2685833617655        NO. OF FUNC. EVALS.:         401
 
                ITERATION NO.:        400    OBJECTIVE VALUE:  -30.0973878697449        NO. OF FUNC. EVALS.:         402
                ITERATION NO.:        500    OBJECTIVE VALUE:  -30.0973878697449        NO. OF FUNC. EVALS.:         502
                ITERATION NO.:        600    OBJECTIVE VALUE:  -30.2729983411617        NO. OF FUNC. EVALS.:         602
                ITERATION NO.:        700    OBJECTIVE VALUE:  -30.3014485604952        NO. OF FUNC. EVALS.:         702
                ITERATION NO.:        800    OBJECTIVE VALUE:  -30.3510736380141        NO. OF FUNC. EVALS.:         802
0CONFIG TEST,   ITERATION NO.:        800    OBJECTIVE VALUE:  -30.3510736380141        NO. OF FUNC. EVALS.:         802
 
                ITERATION NO.:        800    OBJECTIVE VALUE:  -30.0220075279570        NO. OF FUNC. EVALS.:         803
                ITERATION NO.:        900    OBJECTIVE VALUE:  -30.0220075279570        NO. OF FUNC. EVALS.:         903
                ITERATION NO.:       1000    OBJECTIVE VALUE:  -30.0220075279570        NO. OF FUNC. EVALS.:        1003
                ITERATION NO.:       1100    OBJECTIVE VALUE:  -30.1206324237930        NO. OF FUNC. EVALS.:        1103
                ITERATION NO.:       1200    OBJECTIVE VALUE:  -30.2141317990551        NO. OF FUNC. EVALS.:        1203
0CONFIG TEST,   ITERATION NO.:       1200    OBJECTIVE VALUE:  -30.2141317990551        NO. OF FUNC. EVALS.:        1203
 
                ITERATION NO.:       1200    OBJECTIVE VALUE:  -29.8654909331568        NO. OF FUNC. EVALS.:        1204
                ITERATION NO.:       1300    OBJECTIVE VALUE:  -29.8654909331568        NO. OF FUNC. EVALS.:        1304
                ITERATION NO.:       1400    OBJECTIVE VALUE:  -29.8654909331568        NO. OF FUNC. EVALS.:        1404
                ITERATION NO.:       1500    OBJECTIVE VALUE:  -30.1217812178504        NO. OF FUNC. EVALS.:        1504
                ITERATION NO.:       1600    OBJECTIVE VALUE:  -30.5287647221401        NO. OF FUNC. EVALS.:        1604
0CONFIG TEST,   ITERATION NO.:       1600    OBJECTIVE VALUE:  -30.5287647221401        NO. OF FUNC. EVALS.:        1604
 
                ITERATION NO.:       1600    OBJECTIVE VALUE:  -30.1932062795006        NO. OF FUNC. EVALS.:        1605
0R MATRIX ALGORITHMICALLY NON-POSITIVE-SEMIDEFINITE
 BUT NONSINGULAR
0COVARIANCE STEP ABORTED
                ITERATION NO.:       1700    OBJECTIVE VALUE:  -30.1932062795006        NO. OF FUNC. EVALS.:        1705
                ITERATION NO.:       1800    OBJECTIVE VALUE:  -30.1932062795006        NO. OF FUNC. EVALS.:        1805
                ITERATION NO.:       1900    OBJECTIVE VALUE:  -30.1932062795006        NO. OF FUNC. EVALS.:        1905
                ITERATION NO.:       2000    OBJECTIVE VALUE:  -30.4826538140014        NO. OF FUNC. EVALS.:        2005
0CONFIG TEST,   ITERATION NO.:       2000    OBJECTIVE VALUE:  -30.4826538140014        NO. OF FUNC. EVALS.:        2005
 
                ITERATION NO.:       2000    OBJECTIVE VALUE:  -29.6995951997675        NO. OF FUNC. EVALS.:        2006
0R MATRIX ALGORITHMICALLY NON-POSITIVE-SEMIDEFINITE
 BUT NONSINGULAR
0COVARIANCE STEP ABORTED
                ITERATION NO.:       2100    OBJECTIVE VALUE:  -29.6995951997675        NO. OF FUNC. EVALS.:        2106
                ITERATION NO.:       2200    OBJECTIVE VALUE:  -29.8019158931080        NO. OF FUNC. EVALS.:        2206
                ITERATION NO.:       2300    OBJECTIVE VALUE:  -29.8511523255465        NO. OF FUNC. EVALS.:        2306
                ITERATION NO.:       2400    OBJECTIVE VALUE:  -30.2732980907847        NO. OF FUNC. EVALS.:        2406
0CONFIG TEST,   ITERATION NO.:       2400    OBJECTIVE VALUE:  -30.2732980907847        NO. OF FUNC. EVALS.:        2406
 
                ITERATION NO.:       2400    OBJECTIVE VALUE:  -29.9104050484532        NO. OF FUNC. EVALS.:        2407
                ITERATION NO.:       2500    OBJECTIVE VALUE:  -29.9104050484532        NO. OF FUNC. EVALS.:        2507
                ITERATION NO.:       2600    OBJECTIVE VALUE:  -30.0059488373032        NO. OF FUNC. EVALS.:        2607
                ITERATION NO.:       2700    OBJECTIVE VALUE:  -30.0111257671109        NO. OF FUNC. EVALS.:        2707
                ITERATION NO.:       2800    OBJECTIVE VALUE:  -30.5077595122393        NO. OF FUNC. EVALS.:        2807
0CONFIG TEST,   ITERATION NO.:       2800    OBJECTIVE VALUE:  -30.5077595122393        NO. OF FUNC. EVALS.:        2807
 
                ITERATION NO.:       2800    OBJECTIVE VALUE:  -29.9130241957214        NO. OF FUNC. EVALS.:        2808
                ITERATION NO.:       2900    OBJECTIVE VALUE:  -29.9130241957214        NO. OF FUNC. EVALS.:        2908
                ITERATION NO.:       3000    OBJECTIVE VALUE:  -30.2272721598190        NO. OF FUNC. EVALS.:        3008
                ITERATION NO.:       3100    OBJECTIVE VALUE:  -30.4850547922309        NO. OF FUNC. EVALS.:        3108
                ITERATION NO.:       3200    OBJECTIVE VALUE:  -30.5129589912319        NO. OF FUNC. EVALS.:        3208
0BEST CONFIG,   ITERATION NO.:       3200    OBJECTIVE VALUE:  -30.5129589912319        NO. OF FUNC. EVALS.:        3208
 
 
 #TERM:
 NO. OF FUNCTION EVALUATIONS USED:     3208
0MINIMIZATION SUCCESSFUL

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 SE:             0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 N:                       3           3           3           3
 
 P VAL.:         1.0000E+00  1.0000E+00  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 ETASHRINKVR(%)  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 EBVSHRINKSD(%)  8.9018E+00  2.1484E+01  4.8723E+01  3.2072E+01
 EBVSHRINKVR(%)  1.7011E+01  3.8353E+01  7.3707E+01  5.3858E+01
 EPSSHRINKSD(%)  1.0000E+02  1.0000E+02
 EPSSHRINKVR(%)  1.0000E+02  1.0000E+02
 
 #TERE:
 Elapsed opt. design time in seconds:     4.40
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 #OBJT:**************                MINIMUM VALUE OF OBJECTIVE FUNCTION: D-OPTIMALITY               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************      -30.513       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6     
 
         1.68E+00  1.59E+00  8.13E-01  2.37E+00  1.50E+00  1.80E+00
 


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
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6     
 
         1.66E-01  1.18E-01  1.97E-01  1.49E-01  1.75E-01  1.65E-01
 


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
+        1.79E-02
 
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
+        5.96E-02
 
 EPS2
+       ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     2.77E-02         2.76E-03         1.38E-02         6.25E-03         5.02E-03         3.90E-02         4.01E-03

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
     4.47E-03         1.37E-02         2.22E-02         6.77E-04         3.12E-03         7.42E-05         3.10E-03

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     3.06E-02         1.13E-03         2.24E-03         5.09E-03         3.10E-03         5.25E-04         2.71E-02

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | TH 5      SG11 | TH 6      SG11 | SG11      
     0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         3.20E-04
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     1.66E-01         1.41E-01         1.18E-01         1.90E-01         2.17E-01         1.97E-01         1.62E-01

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
     2.55E-01         4.68E-01         1.49E-01         2.32E-02         1.52E-01         2.15E-03         1.19E-01

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     1.75E-01         4.13E-02         1.16E-01         1.57E-01         1.26E-01         1.82E-02         1.65E-01

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | TH 5      SG11 | TH 6      SG11 | SG11      
     0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         1.79E-02
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     3.81E+01        -4.98E+00         8.10E+01        -4.33E+00        -5.37E+00         3.43E+01        -3.19E+00

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
    -1.05E+01        -1.92E+01         6.07E+01         0.00E+00        -6.98E+00         2.57E+00        -4.93E+00

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     3.39E+01         5.86E-10        -4.13E+00        -3.66E+00        -2.23E+00         1.11E-16         3.82E+01

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | TH 5      SG11 | TH 6      SG11 | SG11      
     0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         3.12E+03
 Elapsed finaloutput time in seconds:     0.03
 #CPUT: Total CPU Time in Seconds,        3.510
Stop Time: 
Tue 04/23/2019 
12:05 PM
