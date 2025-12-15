Fri 10/01/2021 
04:24 PM
$PROBLEM PK ODE HANDS ON ONE
$INPUT ID HOUR DV AMT CMT FLAG EVID MDV SDE TIME
$DATA   PKDATA_ref.dtaSDE
        IGNORE=@
$SUBROUTINE ADVAN6 TOL 6 DP
$MODEL 
       COMP = (CENTRAL);
       COMP = (P1)

$THETA (0,10)               ;1 CL
$THETA (0,32)               ;2 VD
$THETA (0, 2)               ;4 SIGMA
$THETA (0,1) ; SGW1

$OMEGA 0.1                  ;1 CL
$OMEGA 0.01                 ;2 VD

$SIGMA 1 FIX                ; PK

$PK
  IF(NEWIND.NE.2) OT = 0
  TVCL  = THETA(1)
  CL    = TVCL*EXP(ETA(1))
  TVVD  = THETA(2)
  VD    = TVVD*EXP(ETA(2))
SGW1 = THETA(4)

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
  RVAR = A2*(1/VD)**2+ THETA(3)**2
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

$ERROR 
     IPRED = A(1)/VD
     IRES  = DV - IPRED
W=SQRT(A(2)*(1/VD)**2+ THETA(3)**2)
     IWRES = IRES/W
     Y     = IPRED+W*EPS(1)
$EST MAXEVAL=9999 METHOD=1 INTER NOABORT SIGDIGITS=3 PRINT=1 MSFO=run1_ref.msfSDE
$COV 
$TABLE ID TIME FLAG AMT CMT IPRED IRES IWRES EVID
       ONEHEADER NOPRINT FILE=run1_ref.fitsde
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  3) THERE MAY BE AN ERROR IN THE ABBREVIATED CODE. THE FOLLOWING
 ONE OR MORE RANDOM VARIABLES ARE DEFINED WITH "IF" STATEMENTS THAT DO NOT
 PROVIDE DEFINITIONS FOR BOTH THE "THEN" AND "ELSE" CASES. IF ALL
 CONDITIONS FAIL, THE VALUES OF THESE VARIABLES WILL BE ZERO.
  
   RVAR K1

  
Note: Analytical 2nd Derivatives are constructed in FSUBS but are never used.
      You may insert $ABBR DERIV2=NO after the first $PROB to save FSUBS construction and compilation time
  
  
License Registered to: NONMEM license (with RADAR5NM) for ICON Pharmacometrics Team
Expiration Date:    31 DEC 2030
Current Date:        1 OCT 2021
Days until program expires :3375
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
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   2
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
 0.1000E+00
 0.0000E+00   0.1000E-01
0INITIAL ESTIMATE OF SIGMA:
 0.1000E+01
0SIGMA CONSTRAINED TO BE THIS INITIAL ESTIMATE
0COVARIANCE STEP OMITTED:        NO
 EIGENVLS. PRINTED:              NO
 SPECIAL COMPUTATION:            NO
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
 NRD (RELATIVE) VALUE OF TOLERANCE:   6
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
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
0ERROR SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
0DES SUBROUTINE USES COMPACT STORAGE MODE.
1
 
 
 #TBLN:      1
 #METH: First Order Conditional Estimation with Interaction
 
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
 ESTIMATE OUTPUT TO MSF:                  YES
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
 RAW OUTPUT FILE (FILE): run1_ref.ext
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
 NRD (RELATIVE) VALUE OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 TOLERANCES FOR TABLE/SCATTER STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 MONITORING OF SEARCH:

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   1535.37718598625        NO. OF FUNC. EVALS.:   6
 CUMULATIVE NO. OF FUNC. EVALS.:        6
 NPARAMETR:  1.0000E+01  3.2000E+01  2.0000E+00  1.0000E+00  1.0000E-01  1.0000E-02
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:  -4.6424E+01 -2.8150E+00  7.7559E+01 -2.3817E-01 -1.6322E+00 -2.9175E+02
 
0ITERATION NO.:    1    OBJECTIVE VALUE:   1399.67692364250        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       13
 NPARAMETR:  1.1002E+01  3.2186E+01  1.7051E+00  1.0005E+00  1.0067E-01  3.3201E-02
 PARAMETER:  1.9547E-01  1.0579E-01 -5.9506E-02  1.0049E-01  1.0336E-01  7.0000E-01
 GRADIENT:   1.8091E+01 -3.4289E+00 -6.8409E+01 -4.3237E-01 -6.5738E-01 -1.2929E+02
 
0ITERATION NO.:    2    OBJECTIVE VALUE:   1398.59485247827        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       20
 NPARAMETR:  1.0399E+01  3.2399E+01  2.0384E+00  1.0014E+00  1.0085E-01  4.7925E-02
 PARAMETER:  1.3917E-01  1.1238E-01  1.1901E-01  1.0136E-01  1.0424E-01  8.8352E-01
 GRADIENT:  -1.5969E+01  3.6384E+00  2.4253E+02 -1.5657E-01  2.3625E-01 -7.3543E+01
 
0ITERATION NO.:    3    OBJECTIVE VALUE:   1397.22228512155        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       28
 NPARAMETR:  9.7248E+00  3.2412E+01  2.0166E+00  1.0021E+00  1.0073E-01  4.9665E-02
 PARAMETER:  7.2098E-02  1.1278E-01  1.0828E-01  1.0209E-01  1.0362E-01  9.0135E-01
 GRADIENT:  -5.4487E+01  3.3360E+00  2.2848E+02 -1.6680E-01 -4.6679E+00 -7.0653E+01
 
0ITERATION NO.:    4    OBJECTIVE VALUE:   1396.19626639209        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       35
 NPARAMETR:  9.4234E+00  3.3011E+01  1.9826E+00  1.0317E+00  1.8757E-01  5.2581E-02
 PARAMETER:  4.0612E-02  1.3111E-01  9.1276E-02  1.3124E-01  4.1450E-01  9.2988E-01
 GRADIENT:  -3.8857E+01  2.1582E+01  2.0596E+02 -1.9263E-01  2.1363E+01 -6.6321E+01
 
0ITERATION NO.:    5    OBJECTIVE VALUE:   1395.77709266530        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       43
 NPARAMETR:  9.4146E+00  3.2133E+01  1.9794E+00  1.0371E+00  1.9362E-01  5.3063E-02
 PARAMETER:  3.9681E-02  1.0416E-01  8.9670E-02  1.3645E-01  4.3036E-01  9.3445E-01
 GRADIENT:  -3.7984E+01 -6.7635E+00  2.0376E+02 -1.9668E-01  2.2461E+01 -6.4875E+01
 
0ITERATION NO.:    6    OBJECTIVE VALUE:   1365.86235841468        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       52
 NPARAMETR:  1.0270E+01  3.2467E+01  1.7794E+00  1.4269E+00  1.1138E-01  8.3466E-02
 PARAMETER:  1.2664E-01  1.1449E-01 -1.6850E-02  4.5550E-01  1.5388E-01  1.1609E+00
 GRADIENT:  -1.8759E+01  2.4556E+00  3.1294E+01 -6.8223E-01  3.8416E+00 -2.6288E+01
 
0ITERATION NO.:    7    OBJECTIVE VALUE:   1348.01432499278        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       60
 NPARAMETR:  1.2713E+01  3.2324E+01  1.6011E+00  6.7657E+01  5.0077E-02  2.4596E-01
 PARAMETER:  3.4007E-01  1.1006E-01 -1.2243E-01  4.3145E+00 -2.4581E-01  1.7013E+00
 GRADIENT:   1.0727E+02 -5.7812E+00  3.1742E+02  1.8727E+02 -1.3604E+01  3.0337E+01
 
0ITERATION NO.:    8    OBJECTIVE VALUE:   1299.14308564718        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       67
 NPARAMETR:  1.2322E+01  3.2344E+01  1.6262E+00  3.1816E+01  5.6312E-02  2.1017E-01
 PARAMETER:  3.0879E-01  1.1070E-01 -1.0689E-01  3.5600E+00 -1.8713E-01  1.6227E+00
 GRADIENT:   1.2159E+02  5.7762E-01  2.5435E+02 -3.2257E+01 -3.6671E+01  2.4322E+01
 
0ITERATION NO.:    9    OBJECTIVE VALUE:   1272.36902753809        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       74
 NPARAMETR:  8.9906E+00  3.2243E+01  1.4423E+00  3.2817E+01  2.2709E-01  1.7369E-01
 PARAMETER: -6.4001E-03  1.0755E-01 -2.2692E-01  3.5909E+00  5.1009E-01  1.5273E+00
 GRADIENT:  -4.3561E+01 -1.5716E+00  1.6210E+02 -4.6936E+01  2.4862E+01  1.6537E+01
 
0ITERATION NO.:   10    OBJECTIVE VALUE:   1228.06292765057        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       82
 NPARAMETR:  9.7083E+00  3.2241E+01  1.1657E+00  4.9745E+01  1.1814E-01  1.5665E-01
 PARAMETER:  7.0401E-02  1.0751E-01 -4.3978E-01  4.0069E+00  1.8336E-01  1.4757E+00
 GRADIENT:  -4.7799E+01 -4.1906E+00  1.1611E+02  4.3204E+01  9.4357E+00  1.3326E+01
 
0ITERATION NO.:   11    OBJECTIVE VALUE:   1212.16919295660        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       89
 NPARAMETR:  1.0940E+01  3.2270E+01  9.9117E-01  5.1668E+01  7.4298E-02  1.3522E-01
 PARAMETER:  1.8983E-01  1.0839E-01 -6.0202E-01  4.0448E+00 -4.8544E-02  1.4022E+00
 GRADIENT:   2.4699E+00 -2.7615E+00  3.3349E+01  1.3528E+01 -9.0809E-01  6.8178E+00
 
0ITERATION NO.:   12    OBJECTIVE VALUE:   1211.00990802181        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       96
 NPARAMETR:  1.0968E+01  3.2337E+01  9.4215E-01  5.1404E+01  7.2843E-02  1.2286E-01
 PARAMETER:  1.9238E-01  1.1047E-01 -6.5274E-01  4.0397E+00 -5.8432E-02  1.3542E+00
 GRADIENT:   3.9746E+00 -1.3829E+00  4.8579E+00 -7.6693E+00 -1.7521E+00  1.8246E+00
 
0ITERATION NO.:   13    OBJECTIVE VALUE:   1210.73899997082        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:      103
 NPARAMETR:  1.0927E+01  3.2403E+01  9.1316E-01  5.3233E+01  7.3864E-02  1.1666E-01
 PARAMETER:  1.8861E-01  1.1251E-01 -6.8399E-01  4.0747E+00 -5.1472E-02  1.3284E+00
 GRADIENT:   6.4135E-01 -8.5985E-01  2.0456E+00  3.2844E+00 -5.5295E-01 -7.8420E-01
 
0ITERATION NO.:   14    OBJECTIVE VALUE:   1210.73599686175        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:      110
 NPARAMETR:  1.0900E+01  3.2426E+01  9.1410E-01  5.2898E+01  7.5092E-02  1.1752E-01
 PARAMETER:  1.8617E-01  1.1321E-01 -6.8296E-01  4.0684E+00 -4.3230E-02  1.3320E+00
 GRADIENT:  -6.5178E-01 -3.9803E-01  2.3472E-01 -2.1145E-01 -1.0659E-01 -4.2441E-01
 
0ITERATION NO.:   15    OBJECTIVE VALUE:   1210.73199872195        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:      117
 NPARAMETR:  1.0919E+01  3.2452E+01  9.1307E-01  5.2943E+01  7.5213E-02  1.1854E-01
 PARAMETER:  1.8791E-01  1.1403E-01 -6.8409E-01  4.0692E+00 -4.2422E-02  1.3363E+00
 GRADIENT:   4.5643E-01  3.0345E-02  2.8390E-03 -7.7710E-02 -9.0054E-03  6.0549E-02
 
0ITERATION NO.:   16    OBJECTIVE VALUE:   1210.73188228441        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:      124
 NPARAMETR:  1.0912E+01  3.2450E+01  9.1300E-01  5.2950E+01  7.5267E-02  1.1838E-01
 PARAMETER:  1.8725E-01  1.1397E-01 -6.8416E-01  4.0694E+00 -4.2066E-02  1.3357E+00
 GRADIENT:   3.6071E-02 -9.2087E-03  1.5236E-02  1.1033E-03  1.1431E-02 -1.0935E-02
 
0ITERATION NO.:   17    OBJECTIVE VALUE:   1210.73188228441        NO. OF FUNC. EVALS.:  12
 CUMULATIVE NO. OF FUNC. EVALS.:      136
 NPARAMETR:  1.0912E+01  3.2450E+01  9.1300E-01  5.2950E+01  7.5267E-02  1.1838E-01
 PARAMETER:  1.8725E-01  1.1397E-01 -6.8416E-01  4.0694E+00 -4.2066E-02  1.3357E+00
 GRADIENT:  -3.1588E-01 -9.1568E-01 -1.6067E-01 -1.7139E+00  1.1431E-02 -1.0935E-02
 
0ITERATION NO.:   18    OBJECTIVE VALUE:   1210.72768100235        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:      152
 NPARAMETR:  1.0918E+01  3.2481E+01  9.1077E-01  5.3140E+01  7.5159E-02  1.1836E-01
 PARAMETER:  1.8784E-01  1.1493E-01 -6.8661E-01  4.0729E+00 -4.2783E-02  1.3356E+00
 GRADIENT:  -2.7988E-02 -4.8699E-01 -3.4238E-02 -3.3264E-01  3.5709E-02  7.8367E-03
 
0ITERATION NO.:   19    OBJECTIVE VALUE:   1210.72731650805        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      166
 NPARAMETR:  1.0919E+01  3.2503E+01  9.1010E-01  5.3193E+01  7.5080E-02  1.1836E-01
 PARAMETER:  1.8796E-01  1.1559E-01 -6.8735E-01  4.0739E+00 -4.3306E-02  1.3356E+00
 GRADIENT:   2.3577E-02 -1.7503E-01 -2.2591E-02  3.2655E-02  1.8737E-02  1.2088E-02
 
0ITERATION NO.:   20    OBJECTIVE VALUE:   1210.72728398406        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      180
 NPARAMETR:  1.0919E+01  3.2518E+01  9.1015E-01  5.3193E+01  7.5024E-02  1.1834E-01
 PARAMETER:  1.8792E-01  1.1605E-01 -6.8729E-01  4.0739E+00 -4.3681E-02  1.3355E+00
 GRADIENT:  -4.4806E-03  5.1559E-02 -4.9523E-03  3.0968E-02 -9.2308E-03  4.2411E-03
 
0ITERATION NO.:   21    OBJECTIVE VALUE:   1210.72727871987        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      194
 NPARAMETR:  1.0919E+01  3.2514E+01  9.1021E-01  5.3188E+01  7.5042E-02  1.1834E-01
 PARAMETER:  1.8791E-01  1.1594E-01 -6.8722E-01  4.0738E+00 -4.3562E-02  1.3355E+00
 GRADIENT:  -2.3090E-03 -1.1464E-03 -3.3874E-03  3.4091E-03 -2.1973E-03  2.6564E-03
 
0ITERATION NO.:   22    OBJECTIVE VALUE:   1210.72727871987        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:      202
 NPARAMETR:  1.0919E+01  3.2514E+01  9.1021E-01  5.3188E+01  7.5042E-02  1.1834E-01
 PARAMETER:  1.8791E-01  1.1594E-01 -6.8722E-01  4.0738E+00 -4.3562E-02  1.3355E+00
 GRADIENT:  -2.3090E-03 -1.1464E-03 -3.3874E-03  3.4091E-03 -2.1973E-03  2.6564E-03
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      202
 NO. OF SIG. DIGITS IN FINAL EST.:  3.7

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         7.0371E-03 -1.2315E-03
 SE:             4.4310E-02  6.1645E-02
 N:                      30          30
 
 P VAL.:         8.7382E-01  9.8406E-01
 
 ETASHRINKSD(%)  1.1404E+01  1.8480E+00
 ETASHRINKVR(%)  2.1507E+01  3.6618E+00
 EBVSHRINKSD(%)  1.0823E+01  1.7219E+00
 EBVSHRINKVR(%)  2.0475E+01  3.4141E+00
 RELATIVEINF(%)  7.9491E+01  9.6545E+01
 EPSSHRINKSD(%)  4.8813E+00
 EPSSHRINKVR(%)  9.5243E+00
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          540
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    992.453615861047     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    1210.72727871987     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       2203.18089458092     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            60
  
 #TERE:
 Elapsed estimation  time in seconds:     7.95
 Elapsed covariance  time in seconds:     3.98
 Elapsed postprocess time in seconds:     0.08
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


         ETA1      ETA2     
 
 ETA1
+        7.50E-02
 
 ETA2
+        0.00E+00  1.18E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        2.74E-01
 
 ETA2
+        0.00E+00  3.44E-01
 


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
 
         6.02E-01  2.09E+00  8.00E-02  3.97E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        1.94E-02
 
 ETA2
+       .........  2.99E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+       .........
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        3.54E-02
 
 ETA2
+       .........  4.34E-02
 


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
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        3.63E-01
 
 TH 2
+       -2.87E-01  4.37E+00
 
 TH 3
+        1.05E-02 -6.01E-02  6.40E-03
 
 TH 4
+       -5.40E-01  2.39E+00 -2.49E-01  1.58E+01
 
 OM11
+        1.87E-03  1.02E-02 -1.22E-04 -1.29E-03  3.77E-04
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -1.27E-03  2.99E-02 -2.39E-04 -6.54E-03  5.02E-05 .........  8.93E-04
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        6.02E-01
 
 TH 2
+       -2.28E-01  2.09E+00
 
 TH 3
+        2.18E-01 -3.60E-01  8.00E-02
 
 TH 4
+       -2.25E-01  2.88E-01 -7.84E-01  3.97E+00
 
 OM11
+        1.60E-01  2.51E-01 -7.89E-02 -1.67E-02  1.94E-02
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -7.05E-02  4.79E-01 -9.98E-02 -5.50E-02  8.65E-02 .........  2.99E-02
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        3.16E+00
 
 TH 2
+        2.22E-01  3.85E-01
 
 TH 3
+       -2.04E+00  1.09E+00  4.42E+02
 
 TH 4
+        3.93E-02 -3.92E-02  6.81E+00  1.80E-01
 
 OM11
+       -2.19E+01 -9.67E+00  1.32E+02  3.11E+00  3.05E+03
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.00E+00 -1.20E+01  1.21E+02  4.33E+00  1.79E+02 .........  1.57E+03
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 Elapsed finaloutput time in seconds:     0.14
 #CPUT: Total CPU Time in Seconds,       12.562
Stop Time: 
Fri 10/01/2021 
04:24 PM
