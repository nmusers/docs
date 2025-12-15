Thu 09/23/2021 
12:18 PM
; Based on sde_ex2_base.ctl, with SDE equations put in, and .dat file modified.  From Christoffer Tornoe, example 2
; This example shows SDE with FAST (analytical) derivatives
$PROBLEM PK ODE HANDS ON ONE
$INPUT ID HOUR DV AMT CMT FLAG EVID MDV SDE TIME
$DATA   sde_ex2.dat
        IGNORE=@
$SUBROUTINE ADVAN6 TOL 10
$MODEL 
       COMP = (CENTRAL);
       COMP = (P1)

$THETA (0,10)               ;1 CL
$THETA (0,32)               ;2 VD
$THETA (0, 2)               ;4 SIGMA
$THETA (0,1) ; SGW1

$OMEGA 0.1                  ;1 CL
$OMEGA 0.01                 ;2 VD
$OMEGA 0.0 FIXED 0.0 FIXED

$SIGMA 1 FIX                ; PK

$PK
  IF(NEWIND.NE.2) OT = 0
  TVCL  = THETA(1)
  CL    = TVCL*EXP(ETA(1))
  TVVD  = THETA(2)
  VD    = TVVD*EXP(ETA(2))
  MU_1=LOG(THETA(1))
  MU_2=LOG(THETA(2))
  MU_3=THETA(3)
  MU_4=THETA(4)
  SV1=MU_3+ETA(3)
  SGW1=MU_4+ETA(4)
  

IF(NEWIND.NE.2) THEN
  AHT1 = 0
  PHT1 = 0
ENDIF

IF(EVID.NE.3) THEN
  A1 = A(1)
  A2 = A(2)
ELSE
  A1 = A1
  A2 = A2
ENDIF

IF(EVID.EQ.0) OBS = DV

IF(EVID.GT.2.AND.SDE.EQ.2) THEN
  RVAR = A2*(1/VD)**2+ SV1**2
  K1   = A2*(1/VD)/RVAR
  AHT1 = A1 + K1*(OBS -( A1/VD))
  PHT1 = A2 - K1*RVAR*K1
ENDIF

IF(EVID.GT.2.AND.SDE.EQ.3) THEN
  AHT1 = A1
  PHT1 = 0
ENDIF

IF(EVID.GT.2.AND.SDE.EQ.4) THEN
  AHT1 = 0
  PHT1 = A2
ENDIF

IF(A_0FLG.EQ.1) THEN
  A_0(1) = AHT1
  A_0(2) = PHT1
ENDIF

$DES
 DADT(1) = - CL/VD*A(1) ;+0
DADT(2) = (-CL/VD)*(A(2))+(-CL/VD)*(A(2))+SGW1*SGW1

$ERROR (OBS ONLY)
     IPRED = A(1)/VD
     IRES  = DV - IPRED
     W=SQRT(A(2)*(1/VD)**2+ SV1**2)
     IWRES = IRES/W
     Y     = IPRED+W*EPS(1)

$EST MAXEVAL=9999 METHOD=1 INTER NOHABORT SIGDIGITS=3 PRINT=1 FAST
$COV MATRIX=R
$TABLE ID TIME FLAG AMT CMT IPRED IRES IWRES EVID
       ONEHEADER NOPRINT FILE=sde_ex2_foce_fast.tab
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  3) THERE MAY BE AN ERROR IN THE ABBREVIATED CODE. THE FOLLOWING
 ONE OR MORE RANDOM VARIABLES ARE DEFINED WITH "IF" STATEMENTS THAT DO NOT
 PROVIDE DEFINITIONS FOR BOTH THE "THEN" AND "ELSE" CASES. IF ALL
 CONDITIONS FAIL, THE VALUES OF THESE VARIABLES WILL BE ZERO.
  
   RVAR K1


 (MU_WARNING 24) ABBREVIATED CODE IS TOO COMPLEX. UNABLE TO CHECK USE OF MU_ VARIABLES.
  
Note: Analytical 2nd Derivatives are constructed in FSUBS but are never used.
      You may insert $ABBR DERIV2=NO after the first $PROB to save FSUBS construction and compilation time
  
  
License Registered to: NONMEM license (with RADAR5NM) for ICON Pharmacometrics Team
Expiration Date:    31 DEC 2030
Current Date:       23 SEP 2021
Days until program expires :3383
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.1
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 PK ODE HANDS ON ONE
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:     1650
 NO. OF DATA ITEMS IN DATA SET:  10
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   3
 MDV DATA ITEM IS DATA ITEM NO.:  8
0INDICES PASSED TO SUBROUTINE PRED:
   7  10   4   0   0   0   5   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID HOUR DV AMT CMT FLAG EVID MDV SDE TIME
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 IPRED IRES IWRES
0FORMAT FOR DATA:
 (E3.0,E5.0,E9.0,E5.0,5E2.0,E5.0)

 TOT. NO. OF OBS RECS:      540
 TOT. NO. OF INDIVIDUALS:       30
0LENGTH OF THETA:   4
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS BLOCK FORM:
  1
  0  2
  0  0  3
  0  0  0  4
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
  0.0000E+00     0.1000E+02     0.1000E+07
  0.0000E+00     0.3200E+02     0.1000E+07
  0.0000E+00     0.2000E+01     0.1000E+07
  0.0000E+00     0.1000E+01     0.1000E+07
0INITIAL ESTIMATE OF OMEGA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.1000E+00
        2                                                                                   NO
                  0.1000E-01
        3                                                                                  YES
                  0.0000E+00
        4                                                                                  YES
                  0.0000E+00
0INITIAL ESTIMATE OF SIGMA:
 0.1000E+01
0SIGMA CONSTRAINED TO BE THIS INITIAL ESTIMATE
0COVARIANCE STEP OMITTED:        NO
 R MATRIX SUBSTITUTED:          YES
 S MATRIX SUBSTITUTED:           NO
 EIGENVLS. PRINTED:              NO
 COMPRESSED FORMAT:              NO
 GRADIENT METHOD USED:       FAST
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
0TABLES STEP OMITTED:    NO
 NO. OF TABLES:           1
 SEED NUMBER (SEED):    11456
 NPDTYPE:    0
 INTERPTYPE:    0
 RANMETHOD:             3U
 MC SAMPLES (ESAMPLE):    300
 WRES SQUARE ROOT TYPE (WRESCHOL): EIGENVALUE
0-- TABLE   1 --
0RECORDS ONLY:    ALL
04 COLUMNS APPENDED:    YES
 PRINTED:                NO
 HEADERS:               ONE
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID TIME FLAG AMT CMT IPRED IRES IWRES EVID
1DOUBLE PRECISION PREDPP VERSION 7.5.1

 GENERAL NONLINEAR KINETICS MODEL (DVERK1, ADVAN6)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:   3
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         CENTRAL      ON         YES        YES        YES        YES
    2         P1           ON         YES        YES        NO         NO
    3         OUTPUT       OFF        YES        NO         NO         NO
 INITIAL (BASE) TOLERANCE SETTINGS:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            *           *           *           *           *
    2            *           *           *           *           *
    3            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      7
   TIME DATA ITEM IS DATA ITEM NO.:         10
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   4
   COMPT. NO. DATA ITEM IS DATA ITEM NO.:    5

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0PK SUBROUTINE INDICATES THAT COMPARTMENT AMOUNTS ARE INITIALIZED.
0PK SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
0DURING SIMULATION, ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 OTHERWISE, ERROR SUBROUTINE CALLED ONLY WITH OBSERVATION EVENTS.
0ERROR SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
0DES SUBROUTINE USES COMPACT STORAGE MODE.
1
 
 
 #TBLN:      1
 #METH: First Order Conditional Estimation with Interaction
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               FAST
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
 RAW OUTPUT FILE (FILE): sde_ex2_foce_fast.ext
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

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 TOLERANCES FOR TABLE/SCATTER STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 MONITORING OF SEARCH:

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   1535.37718602512        NO. OF FUNC. EVALS.:   2
 CUMULATIVE NO. OF FUNC. EVALS.:        2
 NPARAMETR:  1.0000E+01  3.2000E+01  2.0000E+00  1.0000E+00  1.0000E-01  1.0000E-02
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:  -4.7382E+01 -3.5532E+00  7.7459E+01 -2.3815E-01 -1.6322E+00 -2.9175E+02
 
0ITERATION NO.:    1    OBJECTIVE VALUE:   1399.68958144657        NO. OF FUNC. EVALS.:   3
 CUMULATIVE NO. OF FUNC. EVALS.:        5
 NPARAMETR:  1.1023E+01  3.2235E+01  1.7055E+00  1.0005E+00  1.0067E-01  3.3201E-02
 PARAMETER:  1.9744E-01  1.0731E-01 -5.9300E-02  1.0049E-01  1.0336E-01  7.0000E-01
 GRADIENT:   1.6652E+01 -2.0078E+00 -6.8116E+01 -4.3184E-01 -7.2223E-01 -1.2928E+02
 
0ITERATION NO.:    2    OBJECTIVE VALUE:   1398.58563526405        NO. OF FUNC. EVALS.:   3
 CUMULATIVE NO. OF FUNC. EVALS.:        8
 NPARAMETR:  1.0448E+01  3.2337E+01  2.0375E+00  1.0014E+00  1.0088E-01  4.7707E-02
 PARAMETER:  1.4381E-01  1.1047E-01  1.1860E-01  1.0136E-01  1.0437E-01  8.8125E-01
 GRADIENT:  -1.4628E+01  7.3516E-01  2.4171E+02 -1.5705E-01  4.0229E-01 -7.3987E+01
 
0ITERATION NO.:    3    OBJECTIVE VALUE:   1397.13556814732        NO. OF FUNC. EVALS.:   4
 CUMULATIVE NO. OF FUNC. EVALS.:       12
 NPARAMETR:  9.7503E+00  3.2322E+01  2.0163E+00  1.0021E+00  1.0074E-01  4.9525E-02
 PARAMETER:  7.4716E-02  1.1002E-01  1.0811E-01  1.0211E-01  1.0370E-01  8.9995E-01
 GRADIENT:  -5.3957E+01 -4.7682E-01  2.2806E+02 -1.6702E-01 -4.3754E+00 -7.0904E+01
 
0ITERATION NO.:    4    OBJECTIVE VALUE:   1395.84841737255        NO. OF FUNC. EVALS.:   3
 CUMULATIVE NO. OF FUNC. EVALS.:       15
 NPARAMETR:  9.5996E+00  3.3267E+01  1.9987E+00  1.0177E+00  1.3751E-01  5.1005E-02
 PARAMETER:  5.9141E-02  1.3882E-01  9.9328E-02  1.1757E-01  2.5926E-01  9.1467E-01
 GRADIENT:  -4.6212E+01  2.9888E+01  2.1677E+02 -1.7950E-01  1.0153E+01 -6.9453E+01
 
0ITERATION NO.:    5    OBJECTIVE VALUE:   1395.09613818035        NO. OF FUNC. EVALS.:   4
 CUMULATIVE NO. OF FUNC. EVALS.:       19
 NPARAMETR:  9.5516E+00  3.2201E+01  1.9906E+00  1.0267E+00  1.5704E-01  5.1855E-02
 PARAMETER:  5.4121E-02  1.0626E-01  9.5266E-02  1.2637E-01  3.2567E-01  9.2293E-01
 GRADIENT:  -4.2541E+01 -5.1710E+00  2.1134E+02 -1.8694E-01  1.5571E+01 -6.6904E+01
 
0ITERATION NO.:    6    OBJECTIVE VALUE:   1365.84274000601        NO. OF FUNC. EVALS.:   5
 CUMULATIVE NO. OF FUNC. EVALS.:       24
 NPARAMETR:  1.0318E+01  3.2627E+01  1.7813E+00  1.4219E+00  1.0752E-01  8.3011E-02
 PARAMETER:  1.3130E-01  1.1940E-01 -1.5796E-02  4.5200E-01  1.3627E-01  1.1582E+00
 GRADIENT:  -1.8496E+01  4.8381E+00  3.2974E+01 -6.7388E-01  2.1765E+00 -2.6717E+01
 
0ITERATION NO.:    7    OBJECTIVE VALUE:   1335.49576588369        NO. OF FUNC. EVALS.:   4
 CUMULATIVE NO. OF FUNC. EVALS.:       28
 NPARAMETR:  1.2389E+01  3.2419E+01  1.5930E+00  6.4941E+01  6.5311E-02  2.4846E-01
 PARAMETER:  3.1421E-01  1.1300E-01 -1.2755E-01  4.2735E+00 -1.1301E-01  1.7063E+00
 GRADIENT:   7.6406E+01 -5.1802E+00  3.1643E+02  1.7725E+02 -4.7896E+00  3.0515E+01
 
0ITERATION NO.:    8    OBJECTIVE VALUE:   1293.84530370840        NO. OF FUNC. EVALS.:   3
 CUMULATIVE NO. OF FUNC. EVALS.:       31
 NPARAMETR:  1.2063E+01  3.2448E+01  1.6193E+00  3.0912E+01  7.0247E-02  2.1191E-01
 PARAMETER:  2.8753E-01  1.1389E-01 -1.1117E-01  3.5311E+00 -7.6579E-02  1.6268E+00
 GRADIENT:   8.5288E+01  5.0932E-01  2.4510E+02 -3.4436E+01 -2.0261E+01  2.4462E+01
 
0ITERATION NO.:    9    OBJECTIVE VALUE:   1260.18887381027        NO. OF FUNC. EVALS.:   3
 CUMULATIVE NO. OF FUNC. EVALS.:       34
 NPARAMETR:  9.5260E+00  3.2229E+01  1.4059E+00  3.5301E+01  1.7608E-01  1.8155E-01
 PARAMETER:  5.1439E-02  1.0714E-01 -2.5246E-01  3.6639E+00  3.8289E-01  1.5495E+00
 GRADIENT:  -3.7831E+01 -2.5906E+00  1.6148E+02 -3.7111E+01  2.1221E+01  1.8496E+01
 
0ITERATION NO.:   10    OBJECTIVE VALUE:   1226.21470868086        NO. OF FUNC. EVALS.:   3
 CUMULATIVE NO. OF FUNC. EVALS.:       37
 NPARAMETR:  9.5988E+00  3.2148E+01  1.0682E+00  5.5722E+01  1.2385E-01  1.4620E-01
 PARAMETER:  5.9058E-02  1.0461E-01 -5.2714E-01  4.1204E+00  2.0694E-01  1.4412E+00
 GRADIENT:  -5.0811E+01 -7.7534E+00  9.3231E+01  7.9946E+01  1.0778E+01  1.0684E+01
 
0ITERATION NO.:   11    OBJECTIVE VALUE:   1212.76109962599        NO. OF FUNC. EVALS.:   3
 CUMULATIVE NO. OF FUNC. EVALS.:       40
 NPARAMETR:  1.0396E+01  3.2248E+01  9.7941E-01  4.9314E+01  9.3464E-02  1.2883E-01
 PARAMETER:  1.3882E-01  1.0771E-01 -6.1396E-01  3.9982E+00  6.6204E-02  1.3780E+00
 GRADIENT:  -2.3782E+01 -3.5719E+00  1.0301E+01 -1.7128E+01  5.4616E+00  3.9888E+00
 
0ITERATION NO.:   12    OBJECTIVE VALUE:   1210.80925716907        NO. OF FUNC. EVALS.:   3
 CUMULATIVE NO. OF FUNC. EVALS.:       43
 NPARAMETR:  1.1028E+01  3.2373E+01  9.2057E-01  5.2391E+01  7.4635E-02  1.1923E-01
 PARAMETER:  1.9784E-01  1.1159E-01 -6.7591E-01  4.0587E+00 -4.6283E-02  1.3393E+00
 GRADIENT:   6.6630E+00 -1.8298E+00  1.8301E-02 -5.7914E+00 -4.2695E-01  3.1538E-01
 
0ITERATION NO.:   13    OBJECTIVE VALUE:   1210.73459912935        NO. OF FUNC. EVALS.:   3
 CUMULATIVE NO. OF FUNC. EVALS.:       46
 NPARAMETR:  1.0926E+01  3.2429E+01  9.1480E-01  5.3157E+01  7.5518E-02  1.1827E-01
 PARAMETER:  1.8856E-01  1.1331E-01 -6.8220E-01  4.0732E+00 -4.0399E-02  1.3352E+00
 GRADIENT:   4.4728E-01 -1.3254E+00  2.2089E+00  1.5413E+00  2.2813E-01 -3.6749E-02
 
0ITERATION NO.:   14    OBJECTIVE VALUE:   1210.72838973364        NO. OF FUNC. EVALS.:   3
 CUMULATIVE NO. OF FUNC. EVALS.:       49
 NPARAMETR:  1.0920E+01  3.2470E+01  9.1188E-01  5.3163E+01  7.5120E-02  1.1805E-01
 PARAMETER:  1.8800E-01  1.1457E-01 -6.8540E-01  4.0734E+00 -4.3042E-02  1.3343E+00
 GRADIENT:   6.2300E-02 -6.8454E-01  7.0661E-01  3.8345E-01  2.8706E-02 -1.3676E-01
 
0ITERATION NO.:   15    OBJECTIVE VALUE:   1210.72734442245        NO. OF FUNC. EVALS.:   3
 CUMULATIVE NO. OF FUNC. EVALS.:       52
 NPARAMETR:  1.0918E+01  3.2503E+01  9.1025E-01  5.3185E+01  7.4977E-02  1.1817E-01
 PARAMETER:  1.8786E-01  1.1560E-01 -6.8718E-01  4.0738E+00 -4.3992E-02  1.3348E+00
 GRADIENT:  -4.3897E-02 -1.6735E-01 -4.5923E-03 -3.0521E-02 -3.5561E-02 -7.7595E-02
 
0ITERATION NO.:   16    OBJECTIVE VALUE:   1210.72728693400        NO. OF FUNC. EVALS.:   3
 CUMULATIVE NO. OF FUNC. EVALS.:       55
 NPARAMETR:  1.0919E+01  3.2511E+01  9.1017E-01  5.3187E+01  7.5014E-02  1.1828E-01
 PARAMETER:  1.8789E-01  1.1584E-01 -6.8727E-01  4.0738E+00 -4.3744E-02  1.3352E+00
 GRADIENT:  -2.4363E-02 -5.0916E-02 -3.1605E-02 -2.8280E-02 -1.6310E-02 -2.3163E-02
 
0ITERATION NO.:   17    OBJECTIVE VALUE:   1210.72727875354        NO. OF FUNC. EVALS.:   3
 CUMULATIVE NO. OF FUNC. EVALS.:       58
 NPARAMETR:  1.0919E+01  3.2514E+01  9.1021E-01  5.3188E+01  7.5044E-02  1.1834E-01
 PARAMETER:  1.8791E-01  1.1593E-01 -6.8723E-01  4.0738E+00 -4.3548E-02  1.3355E+00
 GRADIENT:  -2.6858E-03 -6.0810E-03 -7.3226E-03 -2.9083E-03 -1.4042E-03  2.6780E-03
 
0ITERATION NO.:   18    OBJECTIVE VALUE:   1210.72727875354        NO. OF FUNC. EVALS.:   1
 CUMULATIVE NO. OF FUNC. EVALS.:       59
 NPARAMETR:  1.0919E+01  3.2514E+01  9.1021E-01  5.3188E+01  7.5044E-02  1.1834E-01
 PARAMETER:  1.8791E-01  1.1593E-01 -6.8723E-01  4.0738E+00 -4.3548E-02  1.3355E+00
 GRADIENT:  -2.6858E-03 -6.0810E-03 -7.3226E-03 -2.9083E-03 -1.4042E-03  2.6780E-03
 
0ITERATION NO.:   19    OBJECTIVE VALUE:   1210.72727875354        NO. OF FUNC. EVALS.:   0
 CUMULATIVE NO. OF FUNC. EVALS.:       59
 NPARAMETR:  1.0919E+01  3.2514E+01  9.1021E-01  5.3188E+01  7.5044E-02  1.1834E-01
 PARAMETER:  1.8791E-01  1.1593E-01 -6.8723E-01  4.0738E+00 -4.3548E-02  1.3355E+00
 GRADIENT:  -2.6858E-03 -6.0810E-03 -7.3226E-03 -2.9083E-03 -1.4042E-03  2.6780E-03
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:       59
 NO. OF SIG. DIGITS IN FINAL EST.:  3.8

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         7.0376E-03 -1.2219E-03  0.0000E+00  0.0000E+00
 SE:             4.4311E-02  6.1645E-02  0.0000E+00  0.0000E+00
 N:                      30          30          30          30
 
 P VAL.:         8.7381E-01  9.8419E-01  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  1.1404E+01  1.8480E+00  0.0000E+00  0.0000E+00
 ETASHRINKVR(%)  2.1508E+01  3.6618E+00  0.0000E+00  0.0000E+00
 EBVSHRINKSD(%)  1.0823E+01  1.7219E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  2.0474E+01  3.4141E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  7.9492E+01  9.6545E+01  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  4.8808E+00
 EPSSHRINKVR(%)  9.5234E+00
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          540
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    992.453615861047     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    1210.72727875354     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       2203.18089461458     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            60
  
 #TERE:
 Elapsed estimation  time in seconds:    19.25
 Elapsed covariance  time in seconds:     5.24
 Elapsed postprocess time in seconds:     0.26
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     1210.727       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         1.09E+01  3.25E+01  9.10E-01  5.32E+01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        7.50E-02
 
 ETA2
+        0.00E+00  1.18E-01
 
 ETA3
+        0.00E+00  0.00E+00  0.00E+00
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        2.74E-01
 
 ETA2
+        0.00E+00  3.44E-01
 
 ETA3
+        0.00E+00  0.00E+00  0.00E+00
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         6.15E-01  2.08E+00  7.85E-02  3.93E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        2.50E-02
 
 ETA2
+       .........  3.18E-02
 
 ETA3
+       ......... ......... .........
 
 ETA4
+       ......... ......... ......... .........
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+       .........
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        4.57E-02
 
 ETA2
+       .........  4.62E-02
 
 ETA3
+       ......... ......... .........
 
 ETA4
+       ......... ......... ......... .........
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+       .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        3.78E-01
 
 TH 2
+       -2.50E-02  4.32E+00
 
 TH 3
+       -2.17E-03  1.32E-05  6.16E-03
 
 TH 4
+        1.42E-01  2.25E-01 -2.03E-01  1.55E+01
 
 OM11
+       -1.02E-03 -2.33E-04  1.51E-04 -1.19E-02  6.26E-04
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -9.72E-05  1.21E-04  5.94E-05 -4.71E-03  7.79E-06 ......... ......... .........  1.01E-03
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM33
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM44
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        6.15E-01
 
 TH 2
+       -1.95E-02  2.08E+00
 
 TH 3
+       -4.49E-02  8.06E-05  7.85E-02
 
 TH 4
+        5.86E-02  2.75E-02 -6.58E-01  3.93E+00
 
 OM11
+       -6.63E-02 -4.49E-03  7.70E-02 -1.21E-01  2.50E-02
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -4.97E-03  1.84E-03  2.38E-02 -3.77E-02  9.79E-03 ......... ......... .........  3.18E-02
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM33
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM44
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        2.66E+00
 
 TH 2
+        1.65E-02  2.32E-01
 
 TH 3
+        2.25E-01 -1.96E-01  2.87E+02
 
 TH 4
+       -1.86E-02 -6.07E-03  3.77E+00  1.15E-01
 
 OM11
+        3.94E+00  4.60E-02  2.50E+00  1.24E+00  1.63E+03
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        1.24E-01 -4.34E-02  7.31E-01  3.06E-01 -6.52E+00 ......... ......... .........  9.91E+02
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM33
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM44
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... .........
 
 Elapsed finaloutput time in seconds:     0.19
 #CPUT: Total CPU Time in Seconds,       25.781
Stop Time: 
Thu 09/23/2021 
12:18 PM
