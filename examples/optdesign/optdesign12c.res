Tue 04/23/2019 
12:03 PM

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


$DESIGN STGR DESEL=TIME DESELSTRAT=TSTRAT DESELMIN=TMIN DESELMAX=TMAX
        MAXEVAL=9999 SIGL=10 nohabort PRINT=10
$COV MATRIX=R UNCONDITIONAL SIGL=10 CHOLROFF=0
$TABLE ID TIME EVID MDV DV NOPRINT NOAPPEND FILE=optdesign12c.tab  FORMAT=S1PE23.16
  
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
 SIGDIGITS GRADIENTS (SIGL):                10
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      10
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     10
 NOPRIOR SETTING (NOPRIOR):                 OFF
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          ON
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      OFF
 RAW OUTPUT FILE (FILE): optdesign12c.ext
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
 DESIGN GROUPSIZE=  1.0000000000000000E+00
 OPTIMALITY RANDOM GENERATION SEED: -1
 DESIGN OPTIMIZATION: STOCHASTIC GRADIENT (STGR)
 OPTIMAL DESIGN ELEMENT, STRAT, MIN, MAX COLUMNS: TIME,TSTRAT,TMIN,TMAX
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=NPRED
 RES=NRES
 WRES=NWRES
 IWRS=NIWRES
 IPRD=NIPRED
 IRS=NIRES
 
 MONITORING OF SEARCH:

 ITERATION NO.:          0    OBJECTIVE VALUE:  -30.0325156338264        NO. OF FUNC. EVALS.:           1
 ITERATION NO.:         10    OBJECTIVE VALUE:  -31.5133081967232        NO. OF FUNC. EVALS.:         251
 ITERATION NO.:         20    OBJECTIVE VALUE:  -31.5348972784839        NO. OF FUNC. EVALS.:         501
 ITERATION NO.:         30    OBJECTIVE VALUE:  -31.5389926552621        NO. OF FUNC. EVALS.:         751
 ITERATION NO.:         40    OBJECTIVE VALUE:  -31.5405337959520        NO. OF FUNC. EVALS.:        1001
 ITERATION NO.:         50    OBJECTIVE VALUE:  -31.5413379132839        NO. OF FUNC. EVALS.:        1251
 ITERATION NO.:         60    OBJECTIVE VALUE:  -31.5418121139653        NO. OF FUNC. EVALS.:        1501
 ITERATION NO.:         70    OBJECTIVE VALUE:  -31.5421286191105        NO. OF FUNC. EVALS.:        1751
 ITERATION NO.:         80    OBJECTIVE VALUE:  -31.5423404731903        NO. OF FUNC. EVALS.:        2001
 ITERATION NO.:         90    OBJECTIVE VALUE:  -31.5424946248673        NO. OF FUNC. EVALS.:        2251
 ITERATION NO.:        100    OBJECTIVE VALUE:  -31.5426159366225        NO. OF FUNC. EVALS.:        2501
 ITERATION NO.:        110    OBJECTIVE VALUE:  -31.5427071741033        NO. OF FUNC. EVALS.:        2751
 ITERATION NO.:        120    OBJECTIVE VALUE:  -31.5427804473568        NO. OF FUNC. EVALS.:        3001
 ITERATION NO.:        130    OBJECTIVE VALUE:  -31.5428376850841        NO. OF FUNC. EVALS.:        3251
 ITERATION NO.:        140    OBJECTIVE VALUE:  -31.5428852997477        NO. OF FUNC. EVALS.:        3501
 ITERATION NO.:        150    OBJECTIVE VALUE:  -31.5429250562664        NO. OF FUNC. EVALS.:        3751
 ITERATION NO.:        160    OBJECTIVE VALUE:  -31.5429577948637        NO. OF FUNC. EVALS.:        4001
 ITERATION NO.:        170    OBJECTIVE VALUE:  -31.5429862987872        NO. OF FUNC. EVALS.:        4251
 ITERATION NO.:        180    OBJECTIVE VALUE:  -31.5430137943386        NO. OF FUNC. EVALS.:        4501
 ITERATION NO.:        190    OBJECTIVE VALUE:  -31.5430367587513        NO. OF FUNC. EVALS.:        4751
 ITERATION NO.:        200    OBJECTIVE VALUE:  -31.5430572541894        NO. OF FUNC. EVALS.:        5001
 ITERATION NO.:        210    OBJECTIVE VALUE:  -31.5430739480179        NO. OF FUNC. EVALS.:        5251
 ITERATION NO.:        220    OBJECTIVE VALUE:  -31.5430879627135        NO. OF FUNC. EVALS.:        5501
 ITERATION NO.:        230    OBJECTIVE VALUE:  -31.5431011984260        NO. OF FUNC. EVALS.:        5751
 ITERATION NO.:        240    OBJECTIVE VALUE:  -31.5431130927167        NO. OF FUNC. EVALS.:        6001
 ITERATION NO.:        250    OBJECTIVE VALUE:  -31.5431242294688        NO. OF FUNC. EVALS.:        6251
 ITERATION NO.:        260    OBJECTIVE VALUE:  -31.5431340241294        NO. OF FUNC. EVALS.:        6501
 ITERATION NO.:        270    OBJECTIVE VALUE:  -31.5431422884438        NO. OF FUNC. EVALS.:        6751
 ITERATION NO.:        280    OBJECTIVE VALUE:  -31.5431490028666        NO. OF FUNC. EVALS.:        7001
 ITERATION NO.:        290    OBJECTIVE VALUE:  -31.5431549649895        NO. OF FUNC. EVALS.:        7251
 ITERATION NO.:        300    OBJECTIVE VALUE:  -31.5431612007541        NO. OF FUNC. EVALS.:        7501
 ITERATION NO.:        310    OBJECTIVE VALUE:  -31.5431670410222        NO. OF FUNC. EVALS.:        7751
 ITERATION NO.:        320    OBJECTIVE VALUE:  -31.5431719583970        NO. OF FUNC. EVALS.:        8001
 ITERATION NO.:        330    OBJECTIVE VALUE:  -31.5431762173366        NO. OF FUNC. EVALS.:        8251
 ITERATION NO.:        340    OBJECTIVE VALUE:  -31.5431807028276        NO. OF FUNC. EVALS.:        8501
 ITERATION NO.:        350    OBJECTIVE VALUE:  -31.5431842877764        NO. OF FUNC. EVALS.:        8751
 ITERATION NO.:        360    OBJECTIVE VALUE:  -31.5431878221536        NO. OF FUNC. EVALS.:        9001
 ITERATION NO.:        370    OBJECTIVE VALUE:  -31.5431909752623        NO. OF FUNC. EVALS.:        9251
 ITERATION NO.:        380    OBJECTIVE VALUE:  -31.5431929102643        NO. OF FUNC. EVALS.:        9501
 ITERATION NO.:        390    OBJECTIVE VALUE:  -31.5431946596422        NO. OF FUNC. EVALS.:        9751
 ITERATION NO.:        400    OBJECTIVE VALUE:  -31.5431961394490        NO. OF FUNC. EVALS.:       10001
 ITERATION NO.:        410    OBJECTIVE VALUE:  -31.5431973641270        NO. OF FUNC. EVALS.:       10251
 ITERATION NO.:        420    OBJECTIVE VALUE:  -31.5431985572373        NO. OF FUNC. EVALS.:       10501
 ITERATION NO.:        430    OBJECTIVE VALUE:  -31.5431995221027        NO. OF FUNC. EVALS.:       10751
 ITERATION NO.:        440    OBJECTIVE VALUE:  -31.5432006591231        NO. OF FUNC. EVALS.:       11001
 ITERATION NO.:        450    OBJECTIVE VALUE:  -31.5432016407158        NO. OF FUNC. EVALS.:       11251
 ITERATION NO.:        460    OBJECTIVE VALUE:  -31.5432025516588        NO. OF FUNC. EVALS.:       11501
 ITERATION NO.:        470    OBJECTIVE VALUE:  -31.5432035603025        NO. OF FUNC. EVALS.:       11751
 ITERATION NO.:        480    OBJECTIVE VALUE:  -31.5432045522971        NO. OF FUNC. EVALS.:       12001
 ITERATION NO.:        490    OBJECTIVE VALUE:  -31.5432053832575        NO. OF FUNC. EVALS.:       12251
 ITERATION NO.:        500    OBJECTIVE VALUE:  -31.5432060899794        NO. OF FUNC. EVALS.:       12501
 ITERATION NO.:        510    OBJECTIVE VALUE:  -31.5432070633559        NO. OF FUNC. EVALS.:       12751
 ITERATION NO.:        515    OBJECTIVE VALUE:  -31.5432071280923        NO. OF FUNC. EVALS.:       12863
 
 #TERM:
 NO. OF FUNCTION EVALUATIONS USED:    12863
0MINIMIZATION SUCCESSFUL

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 SE:             0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 N:                       3           3           3           3
 
 P VAL.:         1.0000E+00  1.0000E+00  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 ETASHRINKVR(%)  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 EBVSHRINKSD(%)  1.0512E+01  2.3576E+01  4.7460E+01  4.0549E+01
 EBVSHRINKVR(%)  1.9919E+01  4.1594E+01  7.2395E+01  6.4655E+01
 EPSSHRINKSD(%)  1.0000E+02  1.0000E+02
 EPSSHRINKVR(%)  1.0000E+02  1.0000E+02
 
 #TERE:
 Elapsed opt. design time in seconds:   101.88
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 #OBJT:**************                MINIMUM VALUE OF OBJECTIVE FUNCTION: D-OPTIMALITY               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************      -31.543       **************************************************
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
 
         1.80E-01  1.13E-01  1.78E-01  1.61E-01  1.42E-01  1.40E-01
 


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
+        1.73E-02
 
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
+        5.75E-02
 
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
     3.24E-02         3.79E-03         1.28E-02         3.54E-03         5.12E-03         3.18E-02        -3.13E-03

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
     4.47E-03         1.19E-02         2.59E-02         9.25E-04         3.42E-03         4.62E-03         4.33E-03

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     2.00E-02         1.44E-03         4.09E-03         5.60E-03         3.78E-03         2.74E-03         1.96E-02

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | TH 5      SG11 | TH 6      SG11 | SG11      
     1.29E-04         2.14E-04         3.16E-04         3.57E-04         6.52E-04         6.97E-04         2.98E-04
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     1.80E-01         1.86E-01         1.13E-01         1.10E-01         2.54E-01         1.78E-01        -1.08E-01

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
     2.45E-01         4.15E-01         1.61E-01         3.63E-02         2.14E-01         1.83E-01         1.90E-01

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     1.42E-01         5.71E-02         2.58E-01         2.24E-01         1.68E-01         1.38E-01         1.40E-01

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | TH 5      SG11 | TH 6      SG11 | SG11      
     4.17E-02         1.10E-01         1.03E-01         1.29E-01         2.67E-01         2.88E-01         1.73E-02
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     3.35E+01        -1.06E+01         9.45E+01        -5.04E+00        -5.98E+00         4.09E+01         8.35E+00

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
    -1.12E+01        -1.69E+01         5.06E+01        -3.52E-11        -1.03E+01        -3.88E+00        -4.49E+00

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     5.71E+01         0.00E+00        -1.41E+01        -6.53E+00        -1.70E+00        -3.29E-11         6.06E+01

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | TH 5      SG11 | TH 6      SG11 | SG11      
    -1.16E+01         1.19E+01         7.09E+00        -2.46E+01        -1.08E+02        -1.23E+02         3.90E+03
 Elapsed finaloutput time in seconds:     1.00
 #CPUT: Total CPU Time in Seconds,       77.564
Stop Time: 
Tue 04/23/2019 
12:04 PM
