Tue 04/23/2019 
12:05 PM

$PROB RUN# Example 1 (from samp5l)
$INPUT C SET ID JID TIME  DV=CONC AMT=DOSE RATE EVID MDV CMT TYPE STRAT STRATF 	TSTRAT TMIN TMAX NMIN NMAX
$DATA optdesign15.csv IGNORE=C

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

$DESIGN DISCRETE FIMTYPE=1 NMIN=NMIN NMAX=NMAX STRAT=STRAT 
        STRATF=STRATF DESEL=TIME DESELSTRAT=TSTRAT DESELMIN=TMIN DESELMAX=TMAX
        MAXEVAL=400 SIGL=10 nohabort PRINT=10
$TABLE ID STRAT STRATF TIME EVID MDV DV NOPRINT NOAPPEND FILE=optdesign15.tab  FORMAT=S1PE23.16
  
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
 NO. OF DATA ITEMS IN DATA SET:  19
 ID DATA ITEM IS DATA ITEM NO.:   3
 DEP VARIABLE IS DATA ITEM NO.:   6
 MDV DATA ITEM IS DATA ITEM NO.: 10
0INDICES PASSED TO SUBROUTINE PRED:
   9   5   7   8   0   0  11   0   0   0   0
0LABELS FOR DATA ITEMS:
 C SET ID JID TIME CONC DOSE RATE EVID MDV CMT TYPE STRAT STRATF TSTRAT TMIN TMAX NMIN NMAX
0FORMAT FOR DATA:
 (4E2.0,E5.0,E2.0,E4.0,6E2.0,E4.0,E3.0,E5.0,3E3.0)

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
 ID STRAT STRATF TIME EVID MDV CONC
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
 RAW OUTPUT FILE (FILE): optdesign15.ext
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
 DESIGN OPTIMIZATION: DISCRETE NUMBER OF TIME POINTS SEARCH WITH NELDER (DISCRETE)
 OPTIMAL DESIGN MINIMAL NUMBER OF TIME POINTS COLUMN:        NMIN
 OPTIMAL DESIGN MAXIMAL NUMBER OF TIME POINTS COLUMN:        NMAX
 OPTIMAL DESIGN SUBJECT TYPE STRATIFICATION COLUMN:          STRAT
 OPTIMAL DESIGN SUBJECT TYPE STRATIFICATION FRACTION COLUMN: STRATF
 OPTIMAL DESIGN ELEMENT, STRAT, MIN, MAX COLUMNS: TIME,TSTRAT,TMIN,TMAX
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=NPRED
 RES=NRES
 WRES=NWRES
 IWRS=NIWRES
 IPRD=NIPRED
 IRS=NIRES
 
 MONITORING OF SEARCH:

                ITERATION NO.:          0    OBJECTIVE VALUE:  -28.8302919436672        NO. OF FUNC. EVALS.:           1
                ITERATION NO.:         10    OBJECTIVE VALUE:  -30.1343878077612        NO. OF FUNC. EVALS.:          56
                ITERATION NO.:         20    OBJECTIVE VALUE:  -30.3574706600969        NO. OF FUNC. EVALS.:         142
                ITERATION NO.:         30    OBJECTIVE VALUE:  -30.4615983727020        NO. OF FUNC. EVALS.:         199
                ITERATION NO.:         40    OBJECTIVE VALUE:  -30.5260854103131        NO. OF FUNC. EVALS.:         272
                ITERATION NO.:         50    OBJECTIVE VALUE:  -30.5694682547235        NO. OF FUNC. EVALS.:         325
                ITERATION NO.:         60    OBJECTIVE VALUE:  -30.6071070310690        NO. OF FUNC. EVALS.:         373
                ITERATION NO.:         70    OBJECTIVE VALUE:  -30.6578916963847        NO. OF FUNC. EVALS.:         411
                ITERATION NO.:         80    OBJECTIVE VALUE:  -30.6922641219298        NO. OF FUNC. EVALS.:         446
                ITERATION NO.:         90    OBJECTIVE VALUE:  -30.7162270822389        NO. OF FUNC. EVALS.:         489
                ITERATION NO.:        100    OBJECTIVE VALUE:  -30.7483153526960        NO. OF FUNC. EVALS.:         537
                ITERATION NO.:        110    OBJECTIVE VALUE:  -30.7689598520571        NO. OF FUNC. EVALS.:         583
                ITERATION NO.:        120    OBJECTIVE VALUE:  -30.7848971997959        NO. OF FUNC. EVALS.:         619
                ITERATION NO.:        130    OBJECTIVE VALUE:  -30.8050275743963        NO. OF FUNC. EVALS.:         708
                ITERATION NO.:        140    OBJECTIVE VALUE:  -30.8135946830158        NO. OF FUNC. EVALS.:         774
                ITERATION NO.:        150    OBJECTIVE VALUE:  -30.8205561112345        NO. OF FUNC. EVALS.:         834
                ITERATION NO.:        160    OBJECTIVE VALUE:  -30.8246210905544        NO. OF FUNC. EVALS.:         880
                ITERATION NO.:        170    OBJECTIVE VALUE:  -30.8276007273456        NO. OF FUNC. EVALS.:         932
                ITERATION NO.:        180    OBJECTIVE VALUE:  -30.8299267858294        NO. OF FUNC. EVALS.:         983
                ITERATION NO.:        190    OBJECTIVE VALUE:  -30.8321630480700        NO. OF FUNC. EVALS.:        1055
                ITERATION NO.:        200    OBJECTIVE VALUE:  -30.8332885704837        NO. OF FUNC. EVALS.:        1116
                ITERATION NO.:        210    OBJECTIVE VALUE:  -30.8338431145352        NO. OF FUNC. EVALS.:        1184
                ITERATION NO.:        220    OBJECTIVE VALUE:  -30.8343214251434        NO. OF FUNC. EVALS.:        1242
                ITERATION NO.:        230    OBJECTIVE VALUE:  -30.8345416073323        NO. OF FUNC. EVALS.:        1274
                ITERATION NO.:        240    OBJECTIVE VALUE:  -30.8348516400431        NO. OF FUNC. EVALS.:        1324
                ITERATION NO.:        250    OBJECTIVE VALUE:  -30.8350923675996        NO. OF FUNC. EVALS.:        1400
                ITERATION NO.:        260    OBJECTIVE VALUE:  -30.8352718227896        NO. OF FUNC. EVALS.:        1465
                ITERATION NO.:        270    OBJECTIVE VALUE:  -30.8353781944085        NO. OF FUNC. EVALS.:        1556
                ITERATION NO.:        280    OBJECTIVE VALUE:  -30.8354214866310        NO. OF FUNC. EVALS.:        1604
                ITERATION NO.:        290    OBJECTIVE VALUE:  -30.8354593423021        NO. OF FUNC. EVALS.:        1679
                ITERATION NO.:        295    OBJECTIVE VALUE:  -30.8354683850978        NO. OF FUNC. EVALS.:        1711
0INITIAL VALUE, ITERATION NO.:        295    OBJECTIVE VALUE:  -30.8354637212250        NO. OF FUNC. EVALS.:        1711
 
                ITERATION NO.:        295    OBJECTIVE VALUE:  -30.1175866949864        NO. OF FUNC. EVALS.:        1712
                ITERATION NO.:        300    OBJECTIVE VALUE:  -30.5831779472886        NO. OF FUNC. EVALS.:        1860
                ITERATION NO.:        310    OBJECTIVE VALUE:  -30.6673041079617        NO. OF FUNC. EVALS.:        1900
                ITERATION NO.:        320    OBJECTIVE VALUE:  -30.7265368893009        NO. OF FUNC. EVALS.:        1926
                ITERATION NO.:        330    OBJECTIVE VALUE:  -30.7607643776553        NO. OF FUNC. EVALS.:        1975
                ITERATION NO.:        340    OBJECTIVE VALUE:  -30.7741330478419        NO. OF FUNC. EVALS.:        2013
                ITERATION NO.:        350    OBJECTIVE VALUE:  -30.7879830062727        NO. OF FUNC. EVALS.:        2053
                ITERATION NO.:        360    OBJECTIVE VALUE:  -30.8001106658472        NO. OF FUNC. EVALS.:        2100
                ITERATION NO.:        370    OBJECTIVE VALUE:  -30.8106586375781        NO. OF FUNC. EVALS.:        2158
                ITERATION NO.:        380    OBJECTIVE VALUE:  -30.8169803289478        NO. OF FUNC. EVALS.:        2203
                ITERATION NO.:        390    OBJECTIVE VALUE:  -30.8210728031944        NO. OF FUNC. EVALS.:        2245
                ITERATION NO.:        400    OBJECTIVE VALUE:  -30.8235266129261        NO. OF FUNC. EVALS.:        2295
                ITERATION NO.:        410    OBJECTIVE VALUE:  -30.8252625709499        NO. OF FUNC. EVALS.:        2348
                ITERATION NO.:        420    OBJECTIVE VALUE:  -30.8266828229657        NO. OF FUNC. EVALS.:        2403
                ITERATION NO.:        430    OBJECTIVE VALUE:  -30.8278046179594        NO. OF FUNC. EVALS.:        2445
                ITERATION NO.:        440    OBJECTIVE VALUE:  -30.8287591592973        NO. OF FUNC. EVALS.:        2485
                ITERATION NO.:        450    OBJECTIVE VALUE:  -30.8296971606068        NO. OF FUNC. EVALS.:        2524
                ITERATION NO.:        460    OBJECTIVE VALUE:  -30.8305138385022        NO. OF FUNC. EVALS.:        2564
                ITERATION NO.:        470    OBJECTIVE VALUE:  -30.8313399689752        NO. OF FUNC. EVALS.:        2602
                ITERATION NO.:        480    OBJECTIVE VALUE:  -30.8321401774969        NO. OF FUNC. EVALS.:        2653
                ITERATION NO.:        490    OBJECTIVE VALUE:  -30.8328008472660        NO. OF FUNC. EVALS.:        2706
                ITERATION NO.:        500    OBJECTIVE VALUE:  -30.8333022313673        NO. OF FUNC. EVALS.:        2757
                ITERATION NO.:        510    OBJECTIVE VALUE:  -30.8337033048273        NO. OF FUNC. EVALS.:        2794
                ITERATION NO.:        520    OBJECTIVE VALUE:  -30.8341472099330        NO. OF FUNC. EVALS.:        2847
                ITERATION NO.:        530    OBJECTIVE VALUE:  -30.8345981380294        NO. OF FUNC. EVALS.:        2901
                ITERATION NO.:        540    OBJECTIVE VALUE:  -30.8350275886324        NO. OF FUNC. EVALS.:        2952
                ITERATION NO.:        550    OBJECTIVE VALUE:  -30.8356729616628        NO. OF FUNC. EVALS.:        3012
                ITERATION NO.:        560    OBJECTIVE VALUE:  -30.8362741163477        NO. OF FUNC. EVALS.:        3079
                ITERATION NO.:        570    OBJECTIVE VALUE:  -30.8367135520093        NO. OF FUNC. EVALS.:        3129
                ITERATION NO.:        580    OBJECTIVE VALUE:  -30.8370910764294        NO. OF FUNC. EVALS.:        3178
                ITERATION NO.:        590    OBJECTIVE VALUE:  -30.8372863768309        NO. OF FUNC. EVALS.:        3211
                ITERATION NO.:        600    OBJECTIVE VALUE:  -30.8374926466313        NO. OF FUNC. EVALS.:        3246
                ITERATION NO.:        610    OBJECTIVE VALUE:  -30.8377835764889        NO. OF FUNC. EVALS.:        3280
                ITERATION NO.:        620    OBJECTIVE VALUE:  -30.8381188284639        NO. OF FUNC. EVALS.:        3322
                ITERATION NO.:        630    OBJECTIVE VALUE:  -30.8383965108785        NO. OF FUNC. EVALS.:        3360
                ITERATION NO.:        640    OBJECTIVE VALUE:  -30.8386148383679        NO. OF FUNC. EVALS.:        3392
                ITERATION NO.:        650    OBJECTIVE VALUE:  -30.8388471532361        NO. OF FUNC. EVALS.:        3424
                ITERATION NO.:        660    OBJECTIVE VALUE:  -30.8390400608951        NO. OF FUNC. EVALS.:        3455
                ITERATION NO.:        670    OBJECTIVE VALUE:  -30.8393447364528        NO. OF FUNC. EVALS.:        3501
                ITERATION NO.:        680    OBJECTIVE VALUE:  -30.8396365593020        NO. OF FUNC. EVALS.:        3539
                ITERATION NO.:        690    OBJECTIVE VALUE:  -30.8399224073351        NO. OF FUNC. EVALS.:        3586
                ITERATION NO.:        695    OBJECTIVE VALUE:  -30.8400723176256        NO. OF FUNC. EVALS.:        3602
                ITERATION NO.:        695    OBJECTIVE VALUE:  -30.8400723176256        NO. OF FUNC. EVALS.:        3602
0CONFIG TEST,   ITERATION NO.:        695    OBJECTIVE VALUE:  -30.8401129642496        NO. OF FUNC. EVALS.:        3602
 
                ITERATION NO.:        695    OBJECTIVE VALUE:  -30.3675751798736        NO. OF FUNC. EVALS.:        3603
                ITERATION NO.:        700    OBJECTIVE VALUE:  -30.4482668986587        NO. OF FUNC. EVALS.:        3660
                ITERATION NO.:        710    OBJECTIVE VALUE:  -30.4917697693460        NO. OF FUNC. EVALS.:        3714
                ITERATION NO.:        720    OBJECTIVE VALUE:  -30.5233490104361        NO. OF FUNC. EVALS.:        3800
                ITERATION NO.:        730    OBJECTIVE VALUE:  -30.5397926157195        NO. OF FUNC. EVALS.:        3840
                ITERATION NO.:        740    OBJECTIVE VALUE:  -30.5551069551003        NO. OF FUNC. EVALS.:        3871
                ITERATION NO.:        750    OBJECTIVE VALUE:  -30.5698443498187        NO. OF FUNC. EVALS.:        3903
                ITERATION NO.:        760    OBJECTIVE VALUE:  -30.5841105855969        NO. OF FUNC. EVALS.:        3937
                ITERATION NO.:        770    OBJECTIVE VALUE:  -30.5958719201244        NO. OF FUNC. EVALS.:        3978
                ITERATION NO.:        780    OBJECTIVE VALUE:  -30.6066761731540        NO. OF FUNC. EVALS.:        4024
                ITERATION NO.:        790    OBJECTIVE VALUE:  -30.6130416743070        NO. OF FUNC. EVALS.:        4053
                ITERATION NO.:        800    OBJECTIVE VALUE:  -30.6213004579419        NO. OF FUNC. EVALS.:        4096
                ITERATION NO.:        810    OBJECTIVE VALUE:  -30.6301909271197        NO. OF FUNC. EVALS.:        4133
                ITERATION NO.:        820    OBJECTIVE VALUE:  -30.6375782905055        NO. OF FUNC. EVALS.:        4181
                ITERATION NO.:        830    OBJECTIVE VALUE:  -30.6455253865065        NO. OF FUNC. EVALS.:        4230
                ITERATION NO.:        840    OBJECTIVE VALUE:  -30.6498529662440        NO. OF FUNC. EVALS.:        4262
                ITERATION NO.:        850    OBJECTIVE VALUE:  -30.6561812671872        NO. OF FUNC. EVALS.:        4299
                ITERATION NO.:        860    OBJECTIVE VALUE:  -30.6611954242290        NO. OF FUNC. EVALS.:        4333
                ITERATION NO.:        870    OBJECTIVE VALUE:  -30.6660409067198        NO. OF FUNC. EVALS.:        4373
                ITERATION NO.:        880    OBJECTIVE VALUE:  -30.6712758871192        NO. OF FUNC. EVALS.:        4408
                ITERATION NO.:        890    OBJECTIVE VALUE:  -30.6750986672539        NO. OF FUNC. EVALS.:        4445
                ITERATION NO.:        900    OBJECTIVE VALUE:  -30.6807347874084        NO. OF FUNC. EVALS.:        4487
                ITERATION NO.:        910    OBJECTIVE VALUE:  -30.6858063644908        NO. OF FUNC. EVALS.:        4535
                ITERATION NO.:        920    OBJECTIVE VALUE:  -30.6904421262717        NO. OF FUNC. EVALS.:        4594
                ITERATION NO.:        930    OBJECTIVE VALUE:  -30.6935859455346        NO. OF FUNC. EVALS.:        4630
                ITERATION NO.:        940    OBJECTIVE VALUE:  -30.6967803630787        NO. OF FUNC. EVALS.:        4668
                ITERATION NO.:        950    OBJECTIVE VALUE:  -30.6992237887292        NO. OF FUNC. EVALS.:        4702
                ITERATION NO.:        960    OBJECTIVE VALUE:  -30.7016724362003        NO. OF FUNC. EVALS.:        4742
                ITERATION NO.:        970    OBJECTIVE VALUE:  -30.7035471594191        NO. OF FUNC. EVALS.:        4781
                ITERATION NO.:        980    OBJECTIVE VALUE:  -30.7052622096540        NO. OF FUNC. EVALS.:        4817
                ITERATION NO.:        990    OBJECTIVE VALUE:  -30.7075495463204        NO. OF FUNC. EVALS.:        4863
                ITERATION NO.:       1000    OBJECTIVE VALUE:  -30.7096624288584        NO. OF FUNC. EVALS.:        4917
                ITERATION NO.:       1010    OBJECTIVE VALUE:  -30.7112736076776        NO. OF FUNC. EVALS.:        4956
                ITERATION NO.:       1020    OBJECTIVE VALUE:  -30.7124768362633        NO. OF FUNC. EVALS.:        4989
                ITERATION NO.:       1030    OBJECTIVE VALUE:  -30.7136903983627        NO. OF FUNC. EVALS.:        5024
                ITERATION NO.:       1040    OBJECTIVE VALUE:  -30.7150767019683        NO. OF FUNC. EVALS.:        5064
                ITERATION NO.:       1050    OBJECTIVE VALUE:  -30.7170405757721        NO. OF FUNC. EVALS.:        5125
                ITERATION NO.:       1060    OBJECTIVE VALUE:  -30.7183463877541        NO. OF FUNC. EVALS.:        5176
                ITERATION NO.:       1070    OBJECTIVE VALUE:  -30.7194515825385        NO. OF FUNC. EVALS.:        5225
                ITERATION NO.:       1080    OBJECTIVE VALUE:  -30.7203467152074        NO. OF FUNC. EVALS.:        5267
                ITERATION NO.:       1090    OBJECTIVE VALUE:  -30.7212835442479        NO. OF FUNC. EVALS.:        5307
                ITERATION NO.:       1095    OBJECTIVE VALUE:  -30.7216131321499        NO. OF FUNC. EVALS.:        5329
                ITERATION NO.:       1095    OBJECTIVE VALUE:  -30.7216131321499        NO. OF FUNC. EVALS.:        5329
0CONFIG TEST,   ITERATION NO.:       1095    OBJECTIVE VALUE:  -30.7216080492056        NO. OF FUNC. EVALS.:        5329
 
                ITERATION NO.:       1095    OBJECTIVE VALUE:  -29.8449393661367        NO. OF FUNC. EVALS.:        5330
                ITERATION NO.:       1100    OBJECTIVE VALUE:  -30.1141809672935        NO. OF FUNC. EVALS.:        5389
                ITERATION NO.:       1110    OBJECTIVE VALUE:  -30.2542101392847        NO. OF FUNC. EVALS.:        5416
                ITERATION NO.:       1120    OBJECTIVE VALUE:  -30.4013136402329        NO. OF FUNC. EVALS.:        5484
                ITERATION NO.:       1130    OBJECTIVE VALUE:  -30.4634303652136        NO. OF FUNC. EVALS.:        5522
                ITERATION NO.:       1140    OBJECTIVE VALUE:  -30.5171043412307        NO. OF FUNC. EVALS.:        5556
                ITERATION NO.:       1150    OBJECTIVE VALUE:  -30.5672313757681        NO. OF FUNC. EVALS.:        5589
                ITERATION NO.:       1160    OBJECTIVE VALUE:  -30.6055705115263        NO. OF FUNC. EVALS.:        5618
                ITERATION NO.:       1170    OBJECTIVE VALUE:  -30.6565923838908        NO. OF FUNC. EVALS.:        5663
                ITERATION NO.:       1180    OBJECTIVE VALUE:  -30.6893018881311        NO. OF FUNC. EVALS.:        5719
                ITERATION NO.:       1190    OBJECTIVE VALUE:  -30.7050211842092        NO. OF FUNC. EVALS.:        5822
                ITERATION NO.:       1200    OBJECTIVE VALUE:  -30.7069194217812        NO. OF FUNC. EVALS.:        5897
                ITERATION NO.:       1210    OBJECTIVE VALUE:  -30.7074374992156        NO. OF FUNC. EVALS.:        5964
                ITERATION NO.:       1220    OBJECTIVE VALUE:  -30.7077238573182        NO. OF FUNC. EVALS.:        6041
                ITERATION NO.:       1230    OBJECTIVE VALUE:  -30.7079150724726        NO. OF FUNC. EVALS.:        6113
                ITERATION NO.:       1240    OBJECTIVE VALUE:  -30.7080206610559        NO. OF FUNC. EVALS.:        6154
                ITERATION NO.:       1250    OBJECTIVE VALUE:  -30.7081123340241        NO. OF FUNC. EVALS.:        6204
                ITERATION NO.:       1260    OBJECTIVE VALUE:  -30.7082276421093        NO. OF FUNC. EVALS.:        6282
                ITERATION NO.:       1270    OBJECTIVE VALUE:  -30.7082901759121        NO. OF FUNC. EVALS.:        6347
                ITERATION NO.:       1280    OBJECTIVE VALUE:  -30.7083287974977        NO. OF FUNC. EVALS.:        6400
                ITERATION NO.:       1290    OBJECTIVE VALUE:  -30.7083603529585        NO. OF FUNC. EVALS.:        6455
                ITERATION NO.:       1300    OBJECTIVE VALUE:  -30.7083871901212        NO. OF FUNC. EVALS.:        6509
                ITERATION NO.:       1302    OBJECTIVE VALUE:  -30.7083930972413        NO. OF FUNC. EVALS.:        6525
0CONFIG TEST,   ITERATION NO.:       1302    OBJECTIVE VALUE:  -30.7083930884436        NO. OF FUNC. EVALS.:        6525
 
                ITERATION NO.:       1302    OBJECTIVE VALUE:  -30.0693636399116        NO. OF FUNC. EVALS.:        6526
                ITERATION NO.:       1310    OBJECTIVE VALUE:  -30.2895204618061        NO. OF FUNC. EVALS.:        6590
                ITERATION NO.:       1320    OBJECTIVE VALUE:  -30.4729899327001        NO. OF FUNC. EVALS.:        6632
                ITERATION NO.:       1330    OBJECTIVE VALUE:  -30.5747305543263        NO. OF FUNC. EVALS.:        6680
                ITERATION NO.:       1340    OBJECTIVE VALUE:  -30.6499038292131        NO. OF FUNC. EVALS.:        6731
                ITERATION NO.:       1350    OBJECTIVE VALUE:  -30.7076261073313        NO. OF FUNC. EVALS.:        6774
                ITERATION NO.:       1360    OBJECTIVE VALUE:  -30.7314121966710        NO. OF FUNC. EVALS.:        6851
                ITERATION NO.:       1370    OBJECTIVE VALUE:  -30.7350557414435        NO. OF FUNC. EVALS.:        6941
                ITERATION NO.:       1380    OBJECTIVE VALUE:  -30.7355221352301        NO. OF FUNC. EVALS.:        6986
                ITERATION NO.:       1390    OBJECTIVE VALUE:  -30.7358087674522        NO. OF FUNC. EVALS.:        7049
                ITERATION NO.:       1400    OBJECTIVE VALUE:  -30.7359803667810        NO. OF FUNC. EVALS.:        7090
                ITERATION NO.:       1410    OBJECTIVE VALUE:  -30.7361538885486        NO. OF FUNC. EVALS.:        7143
                ITERATION NO.:       1420    OBJECTIVE VALUE:  -30.7362991165261        NO. OF FUNC. EVALS.:        7197
                ITERATION NO.:       1430    OBJECTIVE VALUE:  -30.7363871730317        NO. OF FUNC. EVALS.:        7256
                ITERATION NO.:       1440    OBJECTIVE VALUE:  -30.7364592706641        NO. OF FUNC. EVALS.:        7293
                ITERATION NO.:       1450    OBJECTIVE VALUE:  -30.7365415269003        NO. OF FUNC. EVALS.:        7345
                ITERATION NO.:       1460    OBJECTIVE VALUE:  -30.7365919192513        NO. OF FUNC. EVALS.:        7382
                ITERATION NO.:       1470    OBJECTIVE VALUE:  -30.7366397899093        NO. OF FUNC. EVALS.:        7419
                ITERATION NO.:       1480    OBJECTIVE VALUE:  -30.7366812604259        NO. OF FUNC. EVALS.:        7453
                ITERATION NO.:       1490    OBJECTIVE VALUE:  -30.7367246522868        NO. OF FUNC. EVALS.:        7498
                ITERATION NO.:       1500    OBJECTIVE VALUE:  -30.7367717399084        NO. OF FUNC. EVALS.:        7537
                ITERATION NO.:       1510    OBJECTIVE VALUE:  -30.7368069209976        NO. OF FUNC. EVALS.:        7574
                ITERATION NO.:       1520    OBJECTIVE VALUE:  -30.7368434557944        NO. OF FUNC. EVALS.:        7622
                ITERATION NO.:       1530    OBJECTIVE VALUE:  -30.7368871296384        NO. OF FUNC. EVALS.:        7671
                ITERATION NO.:       1540    OBJECTIVE VALUE:  -30.7369084963900        NO. OF FUNC. EVALS.:        7714
                ITERATION NO.:       1550    OBJECTIVE VALUE:  -30.7369563752458        NO. OF FUNC. EVALS.:        7775
                ITERATION NO.:       1560    OBJECTIVE VALUE:  -30.7369770460685        NO. OF FUNC. EVALS.:        7821
                ITERATION NO.:       1562    OBJECTIVE VALUE:  -30.7369801056841        NO. OF FUNC. EVALS.:        7831
0CONFIG TEST,   ITERATION NO.:       1562    OBJECTIVE VALUE:  -30.7369797537518        NO. OF FUNC. EVALS.:        7831
 
                ITERATION NO.:       1562    OBJECTIVE VALUE:  -30.4213604462533        NO. OF FUNC. EVALS.:        7832
                ITERATION NO.:       1570    OBJECTIVE VALUE:  -30.6521971984236        NO. OF FUNC. EVALS.:        7912
                ITERATION NO.:       1580    OBJECTIVE VALUE:  -30.7038713460079        NO. OF FUNC. EVALS.:        7996
                ITERATION NO.:       1590    OBJECTIVE VALUE:  -30.7280459079284        NO. OF FUNC. EVALS.:        8057
                ITERATION NO.:       1600    OBJECTIVE VALUE:  -30.7404466466160        NO. OF FUNC. EVALS.:        8097
                ITERATION NO.:       1610    OBJECTIVE VALUE:  -30.7508068820589        NO. OF FUNC. EVALS.:        8137
                ITERATION NO.:       1620    OBJECTIVE VALUE:  -30.7625904266041        NO. OF FUNC. EVALS.:        8186
                ITERATION NO.:       1630    OBJECTIVE VALUE:  -30.7704474200181        NO. OF FUNC. EVALS.:        8221
                ITERATION NO.:       1640    OBJECTIVE VALUE:  -30.7809118611971        NO. OF FUNC. EVALS.:        8272
                ITERATION NO.:       1650    OBJECTIVE VALUE:  -30.7862356490772        NO. OF FUNC. EVALS.:        8305
                ITERATION NO.:       1660    OBJECTIVE VALUE:  -30.7912018813766        NO. OF FUNC. EVALS.:        8335
                ITERATION NO.:       1670    OBJECTIVE VALUE:  -30.7972777307795        NO. OF FUNC. EVALS.:        8368
                ITERATION NO.:       1680    OBJECTIVE VALUE:  -30.8030688023147        NO. OF FUNC. EVALS.:        8404
                ITERATION NO.:       1690    OBJECTIVE VALUE:  -30.8077281149227        NO. OF FUNC. EVALS.:        8439
                ITERATION NO.:       1700    OBJECTIVE VALUE:  -30.8125736748957        NO. OF FUNC. EVALS.:        8471
                ITERATION NO.:       1710    OBJECTIVE VALUE:  -30.8174472898337        NO. OF FUNC. EVALS.:        8504
                ITERATION NO.:       1720    OBJECTIVE VALUE:  -30.8235012744765        NO. OF FUNC. EVALS.:        8545
                ITERATION NO.:       1730    OBJECTIVE VALUE:  -30.8286156988295        NO. OF FUNC. EVALS.:        8582
                ITERATION NO.:       1740    OBJECTIVE VALUE:  -30.8334198500158        NO. OF FUNC. EVALS.:        8620
                ITERATION NO.:       1750    OBJECTIVE VALUE:  -30.8380956236469        NO. OF FUNC. EVALS.:        8661
                ITERATION NO.:       1760    OBJECTIVE VALUE:  -30.8416607680981        NO. OF FUNC. EVALS.:        8697
                ITERATION NO.:       1770    OBJECTIVE VALUE:  -30.8458660121176        NO. OF FUNC. EVALS.:        8743
                ITERATION NO.:       1780    OBJECTIVE VALUE:  -30.8506361926290        NO. OF FUNC. EVALS.:        8801
                ITERATION NO.:       1790    OBJECTIVE VALUE:  -30.8545133641058        NO. OF FUNC. EVALS.:        8843
                ITERATION NO.:       1800    OBJECTIVE VALUE:  -30.8575001386349        NO. OF FUNC. EVALS.:        8894
                ITERATION NO.:       1810    OBJECTIVE VALUE:  -30.8602804431489        NO. OF FUNC. EVALS.:        8943
                ITERATION NO.:       1820    OBJECTIVE VALUE:  -30.8630613613380        NO. OF FUNC. EVALS.:        9004
                ITERATION NO.:       1830    OBJECTIVE VALUE:  -30.8650875778740        NO. OF FUNC. EVALS.:        9070
                ITERATION NO.:       1840    OBJECTIVE VALUE:  -30.8663018898317        NO. OF FUNC. EVALS.:        9135
                ITERATION NO.:       1850    OBJECTIVE VALUE:  -30.8669775616731        NO. OF FUNC. EVALS.:        9170
                ITERATION NO.:       1860    OBJECTIVE VALUE:  -30.8675060740339        NO. OF FUNC. EVALS.:        9205
                ITERATION NO.:       1870    OBJECTIVE VALUE:  -30.8680493025541        NO. OF FUNC. EVALS.:        9264
                ITERATION NO.:       1880    OBJECTIVE VALUE:  -30.8682100013097        NO. OF FUNC. EVALS.:        9353
                ITERATION NO.:       1883    OBJECTIVE VALUE:  -30.8682181971519        NO. OF FUNC. EVALS.:        9382
0BEST CONFIG,   ITERATION NO.:       1883    OBJECTIVE VALUE:  -30.8682104027335        NO. OF FUNC. EVALS.:        9382
 
 
 #TERM:
 NO. OF FUNCTION EVALUATIONS USED:     9382
0MINIMIZATION SUCCESSFUL

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 SE:             0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 N:                       3           3           3           3
 
 P VAL.:         1.0000E+00  1.0000E+00  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 ETASHRINKVR(%)  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 EBVSHRINKSD(%)  8.0790E+00  2.1320E+01  4.4550E+01  4.0665E+01
 EBVSHRINKVR(%)  1.5505E+01  3.8095E+01  6.9253E+01  6.4794E+01
 EPSSHRINKSD(%)  1.0000E+02  1.0000E+02
 EPSSHRINKVR(%)  1.0000E+02  1.0000E+02
 
 #TERE:
 Elapsed opt. design time in seconds:    10.95
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 #OBJT:**************                MINIMUM VALUE OF OBJECTIVE FUNCTION: D-OPTIMALITY               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************      -30.868       **************************************************
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
 
         2.06E-01  1.14E-01  1.67E-01  1.53E-01  1.68E-01  1.41E-01
 


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
+        1.63E-02
 
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
+        5.43E-02
 
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
     4.26E-02         2.47E-03         1.31E-02         3.33E-03         4.26E-03         2.78E-02         2.90E-03

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
     3.57E-03         9.65E-03         2.33E-02         8.72E-04         2.33E-03         3.85E-03         3.52E-03

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     2.82E-02         7.61E-04         1.93E-03         3.88E-03         2.76E-03         8.40E-04         1.99E-02

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | TH 5      SG11 | TH 6      SG11 | SG11      
     0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         2.65E-04
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     2.06E-01         1.05E-01         1.14E-01         9.67E-02         2.24E-01         1.67E-01         9.20E-02

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
     2.04E-01         3.79E-01         1.53E-01         2.51E-02         1.21E-01         1.38E-01         1.37E-01

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     1.68E-01         2.61E-02         1.20E-01         1.65E-01         1.28E-01         3.54E-02         1.41E-01

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | TH 5      SG11 | TH 6      SG11 | SG11      
     0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         1.63E-02
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     2.39E+01        -3.48E+00         8.34E+01        -1.73E+00        -8.42E+00         4.41E+01        -1.73E+00

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
    -7.57E+00        -1.56E+01         5.16E+01         0.00E+00        -4.53E+00        -3.16E+00        -3.54E+00

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     3.67E+01         0.00E+00        -5.09E+00        -5.41E+00        -3.15E+00         2.22E-16         5.22E+01

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | TH 5      SG11 | TH 6      SG11 | SG11      
     0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         0.00E+00         3.77E+03
 Elapsed finaloutput time in seconds:     0.05
 #CPUT: Total CPU Time in Seconds,        8.767
Stop Time: 
Tue 04/23/2019 
12:05 PM
