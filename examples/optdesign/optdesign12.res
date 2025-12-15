Tue 04/23/2019 
12:02 PM

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


$DESIGN DISCRETE_SG FIMTYPE=1 NMIN=NMIN NMAX=NMAX DESEL=TIME DESELSTRAT=TSTRAT DESELMIN=TMIN DESELMAX=TMAX
        MAXEVAL=100 SIGL=10 nohabort PRINT=10
$TABLE ID TIME EVID MDV DV NOPRINT NOAPPEND FILE=optdesign12.tab  FORMAT=S1PE23.16
  
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
 NO. OF FUNCT. EVALS. ALLOWED:            100
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
 RAW OUTPUT FILE (FILE): optdesign12.ext
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
 DESIGN OPTIMIZATION:  DISCRETE NUMBER OF TIME POINTS SEARCH WITH STOCHASTIC GRADIENT (DISCRETE_SG)
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
                ITERATION NO.:         10    OBJECTIVE VALUE:  -30.3711095157442        NO. OF FUNC. EVALS.:         251
                ITERATION NO.:         20    OBJECTIVE VALUE:  -30.3787714428638        NO. OF FUNC. EVALS.:         501
                ITERATION NO.:         30    OBJECTIVE VALUE:  -30.3814817734013        NO. OF FUNC. EVALS.:         751
                ITERATION NO.:         40    OBJECTIVE VALUE:  -30.3828996154865        NO. OF FUNC. EVALS.:        1001
                ITERATION NO.:         50    OBJECTIVE VALUE:  -30.3837334572763        NO. OF FUNC. EVALS.:        1251
                ITERATION NO.:         60    OBJECTIVE VALUE:  -30.3842709991235        NO. OF FUNC. EVALS.:        1501
                ITERATION NO.:         70    OBJECTIVE VALUE:  -30.3846482153324        NO. OF FUNC. EVALS.:        1751
                ITERATION NO.:         80    OBJECTIVE VALUE:  -30.3849260046085        NO. OF FUNC. EVALS.:        2001
                ITERATION NO.:         90    OBJECTIVE VALUE:  -30.3851378698873        NO. OF FUNC. EVALS.:        2251
                ITERATION NO.:        100    OBJECTIVE VALUE:  -30.3852955863991        NO. OF FUNC. EVALS.:        2501
                ITERATION NO.:        100    OBJECTIVE VALUE:  -30.3852955863991        NO. OF FUNC. EVALS.:        2501
0INITIAL VALUE, ITERATION NO.:        100    OBJECTIVE VALUE:  -30.3852955863991        NO. OF FUNC. EVALS.:        2501
 
                ITERATION NO.:        100    OBJECTIVE VALUE:  -29.9894484392417        NO. OF FUNC. EVALS.:        2502
                ITERATION NO.:        110    OBJECTIVE VALUE:  -30.5320837675221        NO. OF FUNC. EVALS.:        2752
                ITERATION NO.:        120    OBJECTIVE VALUE:  -30.5375092666767        NO. OF FUNC. EVALS.:        3002
                ITERATION NO.:        130    OBJECTIVE VALUE:  -30.5382329135306        NO. OF FUNC. EVALS.:        3252
                ITERATION NO.:        140    OBJECTIVE VALUE:  -30.5384617016914        NO. OF FUNC. EVALS.:        3502
                ITERATION NO.:        150    OBJECTIVE VALUE:  -30.5385607415346        NO. OF FUNC. EVALS.:        3752
                ITERATION NO.:        160    OBJECTIVE VALUE:  -30.5386079515358        NO. OF FUNC. EVALS.:        4002
                ITERATION NO.:        170    OBJECTIVE VALUE:  -30.5386318035193        NO. OF FUNC. EVALS.:        4252
                ITERATION NO.:        180    OBJECTIVE VALUE:  -30.5386479535824        NO. OF FUNC. EVALS.:        4502
                ITERATION NO.:        190    OBJECTIVE VALUE:  -30.5386588773119        NO. OF FUNC. EVALS.:        4752
                ITERATION NO.:        200    OBJECTIVE VALUE:  -30.5386647762233        NO. OF FUNC. EVALS.:        5002
                ITERATION NO.:        200    OBJECTIVE VALUE:  -30.5386647762233        NO. OF FUNC. EVALS.:        5002
0CONFIG TEST,   ITERATION NO.:        200    OBJECTIVE VALUE:  -30.5386647762233        NO. OF FUNC. EVALS.:        5002
 
                ITERATION NO.:        200    OBJECTIVE VALUE:  -30.3034043344162        NO. OF FUNC. EVALS.:        5003
                ITERATION NO.:        210    OBJECTIVE VALUE:  -30.5782176822610        NO. OF FUNC. EVALS.:        5253
                ITERATION NO.:        220    OBJECTIVE VALUE:  -30.5840298677231        NO. OF FUNC. EVALS.:        5503
                ITERATION NO.:        230    OBJECTIVE VALUE:  -30.5854428575236        NO. OF FUNC. EVALS.:        5753
                ITERATION NO.:        240    OBJECTIVE VALUE:  -30.5860497534134        NO. OF FUNC. EVALS.:        6003
                ITERATION NO.:        250    OBJECTIVE VALUE:  -30.5863090769734        NO. OF FUNC. EVALS.:        6253
                ITERATION NO.:        260    OBJECTIVE VALUE:  -30.5864324373428        NO. OF FUNC. EVALS.:        6503
                ITERATION NO.:        270    OBJECTIVE VALUE:  -30.5864919583545        NO. OF FUNC. EVALS.:        6753
                ITERATION NO.:        280    OBJECTIVE VALUE:  -30.5865301719522        NO. OF FUNC. EVALS.:        7003
                ITERATION NO.:        290    OBJECTIVE VALUE:  -30.5865528750941        NO. OF FUNC. EVALS.:        7253
                ITERATION NO.:        300    OBJECTIVE VALUE:  -30.5865675752103        NO. OF FUNC. EVALS.:        7503
                ITERATION NO.:        300    OBJECTIVE VALUE:  -30.5865675752103        NO. OF FUNC. EVALS.:        7503
0CONFIG TEST,   ITERATION NO.:        300    OBJECTIVE VALUE:  -30.5865675752103        NO. OF FUNC. EVALS.:        7503
 
                ITERATION NO.:        300    OBJECTIVE VALUE:  -29.8559895464190        NO. OF FUNC. EVALS.:        7504
                ITERATION NO.:        310    OBJECTIVE VALUE:  -30.6314278183212        NO. OF FUNC. EVALS.:        7754
                ITERATION NO.:        320    OBJECTIVE VALUE:  -30.6779037731872        NO. OF FUNC. EVALS.:        8004
                ITERATION NO.:        330    OBJECTIVE VALUE:  -30.6881516941321        NO. OF FUNC. EVALS.:        8254
                ITERATION NO.:        340    OBJECTIVE VALUE:  -30.6911554357736        NO. OF FUNC. EVALS.:        8504
                ITERATION NO.:        350    OBJECTIVE VALUE:  -30.6928714569209        NO. OF FUNC. EVALS.:        8754
                ITERATION NO.:        360    OBJECTIVE VALUE:  -30.6935845169577        NO. OF FUNC. EVALS.:        9004
                ITERATION NO.:        370    OBJECTIVE VALUE:  -30.6939922677532        NO. OF FUNC. EVALS.:        9254
                ITERATION NO.:        380    OBJECTIVE VALUE:  -30.6942815603095        NO. OF FUNC. EVALS.:        9504
                ITERATION NO.:        390    OBJECTIVE VALUE:  -30.6944405062667        NO. OF FUNC. EVALS.:        9754
                ITERATION NO.:        400    OBJECTIVE VALUE:  -30.6945314035003        NO. OF FUNC. EVALS.:       10004
                ITERATION NO.:        400    OBJECTIVE VALUE:  -30.6945314035003        NO. OF FUNC. EVALS.:       10004
0CONFIG TEST,   ITERATION NO.:        400    OBJECTIVE VALUE:  -30.6945314035003        NO. OF FUNC. EVALS.:       10004
 
                ITERATION NO.:        400    OBJECTIVE VALUE:  -30.4976942320547        NO. OF FUNC. EVALS.:       10005
                ITERATION NO.:        410    OBJECTIVE VALUE:  -30.7369188729986        NO. OF FUNC. EVALS.:       10255
                ITERATION NO.:        420    OBJECTIVE VALUE:  -30.7399005819113        NO. OF FUNC. EVALS.:       10505
                ITERATION NO.:        430    OBJECTIVE VALUE:  -30.7404761395047        NO. OF FUNC. EVALS.:       10755
                ITERATION NO.:        440    OBJECTIVE VALUE:  -30.7406492025184        NO. OF FUNC. EVALS.:       11005
                ITERATION NO.:        450    OBJECTIVE VALUE:  -30.7407398824287        NO. OF FUNC. EVALS.:       11255
                ITERATION NO.:        460    OBJECTIVE VALUE:  -30.7407923406858        NO. OF FUNC. EVALS.:       11505
                ITERATION NO.:        470    OBJECTIVE VALUE:  -30.7408357410947        NO. OF FUNC. EVALS.:       11755
                ITERATION NO.:        480    OBJECTIVE VALUE:  -30.7408699368746        NO. OF FUNC. EVALS.:       12005
                ITERATION NO.:        490    OBJECTIVE VALUE:  -30.7408954707612        NO. OF FUNC. EVALS.:       12255
                ITERATION NO.:        500    OBJECTIVE VALUE:  -30.7409181658167        NO. OF FUNC. EVALS.:       12505
                ITERATION NO.:        500    OBJECTIVE VALUE:  -30.7409181658167        NO. OF FUNC. EVALS.:       12505
0CONFIG TEST,   ITERATION NO.:        500    OBJECTIVE VALUE:  -30.7409181658167        NO. OF FUNC. EVALS.:       12505
 
                ITERATION NO.:        500    OBJECTIVE VALUE:  -29.9734456240137        NO. OF FUNC. EVALS.:       12506
                ITERATION NO.:        510    OBJECTIVE VALUE:  -30.4900625531726        NO. OF FUNC. EVALS.:       12756
                ITERATION NO.:        520    OBJECTIVE VALUE:  -30.4903037301936        NO. OF FUNC. EVALS.:       13006
                ITERATION NO.:        530    OBJECTIVE VALUE:  -30.4903762134569        NO. OF FUNC. EVALS.:       13256
                ITERATION NO.:        540    OBJECTIVE VALUE:  -30.4904070343785        NO. OF FUNC. EVALS.:       13506
                ITERATION NO.:        550    OBJECTIVE VALUE:  -30.4904273892407        NO. OF FUNC. EVALS.:       13756
                ITERATION NO.:        560    OBJECTIVE VALUE:  -30.4904436227022        NO. OF FUNC. EVALS.:       14006
                ITERATION NO.:        570    OBJECTIVE VALUE:  -30.4904555419341        NO. OF FUNC. EVALS.:       14256
                ITERATION NO.:        580    OBJECTIVE VALUE:  -30.4904662146215        NO. OF FUNC. EVALS.:       14506
                ITERATION NO.:        590    OBJECTIVE VALUE:  -30.4904765526267        NO. OF FUNC. EVALS.:       14756
                ITERATION NO.:        600    OBJECTIVE VALUE:  -30.4904866270493        NO. OF FUNC. EVALS.:       15006
                ITERATION NO.:        600    OBJECTIVE VALUE:  -30.4904866270493        NO. OF FUNC. EVALS.:       15006
0CONFIG TEST,   ITERATION NO.:        600    OBJECTIVE VALUE:  -30.4904866270493        NO. OF FUNC. EVALS.:       15006
 
                ITERATION NO.:        600    OBJECTIVE VALUE:  -30.1140245891492        NO. OF FUNC. EVALS.:       15007
                ITERATION NO.:        610    OBJECTIVE VALUE:  -30.3882470124877        NO. OF FUNC. EVALS.:       15257
                ITERATION NO.:        620    OBJECTIVE VALUE:  -30.4211907145090        NO. OF FUNC. EVALS.:       15507
                ITERATION NO.:        630    OBJECTIVE VALUE:  -30.4262911352631        NO. OF FUNC. EVALS.:       15757
                ITERATION NO.:        640    OBJECTIVE VALUE:  -30.4285673775174        NO. OF FUNC. EVALS.:       16007
                ITERATION NO.:        650    OBJECTIVE VALUE:  -30.4301818244548        NO. OF FUNC. EVALS.:       16257
                ITERATION NO.:        660    OBJECTIVE VALUE:  -30.4310927691190        NO. OF FUNC. EVALS.:       16507
                ITERATION NO.:        670    OBJECTIVE VALUE:  -30.4317381619793        NO. OF FUNC. EVALS.:       16757
                ITERATION NO.:        680    OBJECTIVE VALUE:  -30.4322619613556        NO. OF FUNC. EVALS.:       17007
                ITERATION NO.:        690    OBJECTIVE VALUE:  -30.4326914111826        NO. OF FUNC. EVALS.:       17257
                ITERATION NO.:        700    OBJECTIVE VALUE:  -30.4330463655299        NO. OF FUNC. EVALS.:       17507
                ITERATION NO.:        700    OBJECTIVE VALUE:  -30.4330463655299        NO. OF FUNC. EVALS.:       17507
0CONFIG TEST,   ITERATION NO.:        700    OBJECTIVE VALUE:  -30.4330463655299        NO. OF FUNC. EVALS.:       17507
 
                ITERATION NO.:        700    OBJECTIVE VALUE:  -30.4377468249446        NO. OF FUNC. EVALS.:       17508
                ITERATION NO.:        710    OBJECTIVE VALUE:  -30.6650197020510        NO. OF FUNC. EVALS.:       17758
                ITERATION NO.:        720    OBJECTIVE VALUE:  -30.6761573448590        NO. OF FUNC. EVALS.:       18008
                ITERATION NO.:        730    OBJECTIVE VALUE:  -30.6949378071349        NO. OF FUNC. EVALS.:       18258
                ITERATION NO.:        740    OBJECTIVE VALUE:  -30.7210771320282        NO. OF FUNC. EVALS.:       18508
                ITERATION NO.:        750    OBJECTIVE VALUE:  -30.7338645837848        NO. OF FUNC. EVALS.:       18758
                ITERATION NO.:        760    OBJECTIVE VALUE:  -30.7382281873480        NO. OF FUNC. EVALS.:       19008
                ITERATION NO.:        770    OBJECTIVE VALUE:  -30.7397056669517        NO. OF FUNC. EVALS.:       19258
                ITERATION NO.:        780    OBJECTIVE VALUE:  -30.7401799914684        NO. OF FUNC. EVALS.:       19508
                ITERATION NO.:        790    OBJECTIVE VALUE:  -30.7404306884512        NO. OF FUNC. EVALS.:       19758
                ITERATION NO.:        800    OBJECTIVE VALUE:  -30.7405675321609        NO. OF FUNC. EVALS.:       20008
                ITERATION NO.:        800    OBJECTIVE VALUE:  -30.7405675321609        NO. OF FUNC. EVALS.:       20008
0BEST CONFIG,   ITERATION NO.:        800    OBJECTIVE VALUE:  -30.7405675321609        NO. OF FUNC. EVALS.:       20008
 
 
 #TERM:
 NO. OF FUNCTION EVALUATIONS USED:    20008
0MINIMIZATION TERMINATED
  DUE TO MAXIMUM NUMBER OF ITERATIONS EXCEEDED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 SE:             0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 N:                       3           3           3           3
 
 P VAL.:         1.0000E+00  1.0000E+00  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 ETASHRINKVR(%)  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 EBVSHRINKSD(%)  8.0105E+00  2.4308E+01  4.1885E+01  4.0414E+01
 EBVSHRINKVR(%)  1.5379E+01  4.2708E+01  6.6227E+01  6.4495E+01
 EPSSHRINKSD(%)  1.0000E+02  1.0000E+02
 EPSSHRINKVR(%)  1.0000E+02  1.0000E+02
 
 #TERE:
 Elapsed opt. design time in seconds:    24.07
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 #OBJT:**************                MINIMUM VALUE OF OBJECTIVE FUNCTION: D-OPTIMALITY               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************      -30.741       **************************************************
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
 
         1.66E-01  1.23E-01  1.63E-01  1.56E-01  1.63E-01  1.69E-01
 


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
+        1.70E-02
 
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
+        5.67E-02
 
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
     2.76E-02         2.85E-03         1.50E-02         4.00E-03         5.15E-03         2.66E-02         3.31E-03

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
     4.24E-03         7.65E-03         2.44E-02         8.04E-04         2.45E-03         2.53E-03         2.76E-03

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     2.67E-02         9.50E-04         2.92E-03         3.64E-03         2.39E-03         7.26E-04         2.86E-02

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | TH 5      SG11 | TH 6      SG11 | SG11      
     0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         2.89E-04
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     1.66E-01         1.40E-01         1.23E-01         1.48E-01         2.58E-01         1.63E-01         1.28E-01

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
     2.21E-01         3.00E-01         1.56E-01         2.97E-02         1.22E-01         9.51E-02         1.08E-01

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     1.63E-01         3.39E-02         1.41E-01         1.32E-01         9.06E-02         2.63E-02         1.69E-01

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | TH 5      SG11 | TH 6      SG11 | SG11      
     0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         1.70E-02
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     3.77E+01        -4.98E+00         7.51E+01        -3.83E+00        -1.03E+01         4.40E+01        -3.05E+00

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
    -8.06E+00        -1.09E+01         4.67E+01         0.00E+00        -4.79E+00        -1.89E+00        -2.92E+00

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     3.84E+01         0.00E+00        -5.42E+00        -3.47E+00        -1.52E+00        -6.58E-11         3.62E+01

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | TH 5      SG11 | TH 6      SG11 | SG11      
     0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         3.46E+03
 Elapsed finaloutput time in seconds:     0.03
 #CPUT: Total CPU Time in Seconds,       22.059
Stop Time: 
Tue 04/23/2019 
12:02 PM
