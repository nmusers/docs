Thu 09/23/2021 
12:16 PM
; Based on sde_ex2_base.ctl, with SDE equations put in, and .dat file modified.  From Christoffer Tornoe, example 2, and can work with NONMEM VI
$PROBLEM PK ODE HANDS ON ONE
$INPUT ID HOUR DV AMT CMT FLAG EVID MDV SDE TIME
$DATA   sde_ex2.dat
        IGNORE=@
$SUBROUTINE ADVAN6 TOL 10 DP
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

$ERROR (OBS ONLY)
     IPRED = A(1)/VD
     IRES  = DV - IPRED
W=SQRT(A(2)*(1/VD)**2+ THETA(3)**2)
     IWRES = IRES/W
     Y     = IPRED+W*EPS(1)

$EST MAXEVAL=9999 METHOD=1 LAPLACE NUMERICAL SLOW INTER NOABORT SIGDIGITS=3 PRINT=1
$COV MATRIX=R
$TABLE ID TIME FLAG AMT CMT IPRED IRES IWRES EVID
       ONEHEADER NOPRINT FILE=sde_ex2_foce.tab
  
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
 #METH: Laplacian Conditional Estimation with Interaction
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               SLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    YES
 NUMERICAL 2ND DERIVATIVES:               YES
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
 RAW OUTPUT FILE (FILE): sde_ex2_foce.ext
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

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   1535.08929944482        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:        7
 NPARAMETR:  1.0000E+01  3.2000E+01  2.0000E+00  1.0000E+00  1.0000E-01  1.0000E-02
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:  -4.6991E+01 -1.3934E+00  7.6894E+01 -2.3749E-01 -1.7681E+00 -2.9096E+02
 
0ITERATION NO.:    1    OBJECTIVE VALUE:   1399.75291105668        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       15
 NPARAMETR:  1.1018E+01  3.2092E+01  1.7067E+00  1.0005E+00  1.0073E-01  3.3201E-02
 PARAMETER:  1.9690E-01  1.0287E-01 -5.8567E-02  1.0049E-01  1.0365E-01  7.0000E-01
 GRADIENT:   1.6908E+01 -8.7848E+00 -6.6643E+01 -4.1949E-01 -7.9531E-01 -1.2891E+02
 
0ITERATION NO.:    2    OBJECTIVE VALUE:   1398.61093849114        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       23
 NPARAMETR:  1.0432E+01  3.2706E+01  2.0346E+00  1.0013E+00  1.0096E-01  4.7472E-02
 PARAMETER:  1.4226E-01  1.2181E-01  1.1713E-01  1.0133E-01  1.0476E-01  8.7878E-01
 GRADIENT:  -1.4614E+01  1.4103E+01  2.3959E+02 -1.6861E-01  2.7505E-01 -7.4618E+01
 
0ITERATION NO.:    3    OBJECTIVE VALUE:   1397.14204980654        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       32
 NPARAMETR:  9.7320E+00  3.2796E+01  2.0126E+00  1.0021E+00  1.0085E-01  4.9286E-02
 PARAMETER:  7.2836E-02  1.2458E-01  1.0628E-01  1.0207E-01  1.0422E-01  8.9752E-01
 GRADIENT:  -5.4057E+01  1.5982E+01  2.2531E+02 -1.7614E-01 -4.5284E+00 -7.1650E+01
 
0ITERATION NO.:    4    OBJECTIVE VALUE:   1396.17232989474        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       40
 NPARAMETR:  9.5646E+00  3.1615E+01  2.0003E+00  1.0171E+00  1.3786E-01  5.0902E-02
 PARAMETER:  5.5488E-02  8.7908E-02  1.0016E-01  1.1696E-01  2.6054E-01  9.1365E-01
 GRADIENT:  -4.7286E+01 -2.4418E+01  2.1781E+02 -1.8069E-01  1.0034E+01 -6.8653E+01
 
0ITERATION NO.:    5    OBJECTIVE VALUE:   1395.94491347472        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       48
 NPARAMETR:  9.4590E+00  3.3702E+01  1.9719E+00  1.0374E+00  1.9322E-01  5.2618E-02
 PARAMETER:  4.4382E-02  1.5181E-01  8.5850E-02  1.3674E-01  4.2932E-01  9.3023E-01
 GRADIENT:  -3.7017E+01  4.2564E+01  1.9769E+02 -2.0600E-01  2.2700E+01 -6.7647E+01
 
0ITERATION NO.:    6    OBJECTIVE VALUE:   1365.97652896241        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:       58
 NPARAMETR:  1.0283E+01  3.2639E+01  1.7783E+00  1.4139E+00  1.1258E-01  8.3383E-02
 PARAMETER:  1.2789E-01  1.1977E-01 -1.7468E-02  4.4634E-01  1.5924E-01  1.1604E+00
 GRADIENT:  -1.8730E+01  5.1854E+00  3.0142E+01 -6.7136E-01  4.3803E+00 -2.6305E+01
 
0ITERATION NO.:    7    OBJECTIVE VALUE:   1335.86000964175        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:       68
 NPARAMETR:  1.2740E+01  3.2062E+01  1.6080E+00  6.1446E+01  4.9708E-02  2.4145E-01
 PARAMETER:  3.4212E-01  1.0193E-01 -1.1815E-01  4.2182E+00 -2.4950E-01  1.6920E+00
 GRADIENT:   1.2714E+02 -5.7153E+00  3.2262E+02  1.5094E+02 -1.9248E+01  2.9665E+01
 
0ITERATION NO.:    8    OBJECTIVE VALUE:   1302.39727072358        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       76
 NPARAMETR:  1.2542E+01  3.2104E+01  1.6198E+00  4.2532E+01  5.2762E-02  2.2366E-01
 PARAMETER:  3.2652E-01  1.0325E-01 -1.1085E-01  3.8503E+00 -2.1969E-01  1.6538E+00
 GRADIENT:   1.3462E+02 -2.6409E+00  3.0412E+02  3.0208E+01 -3.2843E+01  2.6776E+01
 
0ITERATION NO.:    9    OBJECTIVE VALUE:   1268.97615667795        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       84
 NPARAMETR:  1.0297E+01  3.2495E+01  1.5113E+00  3.8236E+01  1.2443E-01  1.9320E-01
 PARAMETER:  1.2930E-01  1.1536E-01 -1.8016E-01  3.7438E+00  2.0927E-01  1.5806E+00
 GRADIENT:  -1.5956E+01 -3.5062E-02  2.3884E+02  2.3294E+00  1.3934E+01  2.1191E+01
 
0ITERATION NO.:   10    OBJECTIVE VALUE:   1230.30181151370        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       92
 NPARAMETR:  1.0085E+01  3.2788E+01  1.1618E+00  3.8623E+01  1.1293E-01  1.5125E-01
 PARAMETER:  1.0849E-01  1.2432E-01 -4.4315E-01  3.7539E+00  1.6078E-01  1.4582E+00
 GRADIENT:  -2.8018E+01  5.0518E+00  3.5546E+01 -7.1026E+01  9.3847E+00  1.0817E+01
 
0ITERATION NO.:   11    OBJECTIVE VALUE:   1213.39616129343        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:      100
 NPARAMETR:  1.0324E+01  3.2728E+01  1.0054E+00  5.0336E+01  8.3823E-02  1.2794E-01
 PARAMETER:  1.3185E-01  1.2248E-01 -5.8771E-01  4.0187E+00  1.1772E-02  1.3745E+00
 GRADIENT:  -2.5150E+01  3.6955E+00  3.3380E+01  4.7852E+00  1.8486E+00  3.7054E+00
 
0ITERATION NO.:   12    OBJECTIVE VALUE:   1211.32273067818        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:      108
 NPARAMETR:  1.0931E+01  3.2568E+01  8.9401E-01  5.4535E+01  7.2781E-02  1.1285E-01
 PARAMETER:  1.8904E-01  1.1758E-01 -7.0518E-01  4.0988E+00 -5.8858E-02  1.3117E+00
 GRADIENT:   6.2400E+00  2.2554E+00  2.1617E+00  1.1797E+01 -1.3545E-01 -2.5752E+00
 
0ITERATION NO.:   13    OBJECTIVE VALUE:   1211.15969750686        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:      116
 NPARAMETR:  1.0827E+01  3.2520E+01  9.0991E-01  5.2767E+01  7.4747E-02  1.1659E-01
 PARAMETER:  1.7948E-01  1.1611E-01 -6.8756E-01  4.0659E+00 -4.5532E-02  1.3280E+00
 GRADIENT:   8.4439E-01  1.7605E+00 -1.6816E+00 -3.0743E+00  4.1861E-02 -9.8656E-01
 
0ITERATION NO.:   14    OBJECTIVE VALUE:   1211.14149163473        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:      124
 NPARAMETR:  1.0812E+01  3.2477E+01  9.1113E-01  5.2968E+01  7.4647E-02  1.1782E-01
 PARAMETER:  1.7810E-01  1.1479E-01 -6.8622E-01  4.0697E+00 -4.6198E-02  1.3333E+00
 GRADIENT:  -9.7593E-02  9.7561E-01  3.7360E-01 -1.9106E-02  3.4808E-02 -3.6371E-01
 
0ITERATION NO.:   15    OBJECTIVE VALUE:   1211.13793055825        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:      132
 NPARAMETR:  1.0817E+01  3.2406E+01  9.0971E-01  5.3046E+01  7.4381E-02  1.1888E-01
 PARAMETER:  1.7857E-01  1.1260E-01 -6.8778E-01  4.0712E+00 -4.7987E-02  1.3377E+00
 GRADIENT:   1.3320E-01 -8.3907E-02  1.9419E-01  3.9604E-01 -5.1472E-02  1.4836E-01
 
0ITERATION NO.:   16    OBJECTIVE VALUE:   1211.13793055825        NO. OF FUNC. EVALS.:  15
 CUMULATIVE NO. OF FUNC. EVALS.:      147
 NPARAMETR:  1.0817E+01  3.2406E+01  9.0971E-01  5.3046E+01  7.4381E-02  1.1888E-01
 PARAMETER:  1.7857E-01  1.1260E-01 -6.8778E-01  4.0712E+00 -4.7987E-02  1.3377E+00
 GRADIENT:   7.3250E-02 -1.2263E-01  2.9036E-02 -9.3833E-01 -6.1919E-02  7.3297E-02
 
0ITERATION NO.:   17    OBJECTIVE VALUE:   1211.13668098084        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      161
 NPARAMETR:  1.0819E+01  3.2409E+01  9.0818E-01  5.3168E+01  7.4335E-02  1.1863E-01
 PARAMETER:  1.7871E-01  1.1271E-01 -6.8946E-01  4.0734E+00 -4.8296E-02  1.3367E+00
 GRADIENT:   1.0941E-01 -9.7485E-02  7.1875E-02 -6.9065E-02 -4.4282E-02 -2.3990E-02
 
0ITERATION NO.:   18    OBJECTIVE VALUE:   1211.13663435265        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      175
 NPARAMETR:  1.0817E+01  3.2413E+01  9.0794E-01  5.3183E+01  7.4386E-02  1.1864E-01
 PARAMETER:  1.7858E-01  1.1283E-01 -6.8972E-01  4.0737E+00 -4.7952E-02  1.3367E+00
 GRADIENT:   2.6308E-02 -4.0957E-02  4.8908E-02  2.7562E-02 -1.6737E-02 -2.0199E-02
 
0ITERATION NO.:   19    OBJECTIVE VALUE:   1211.13662769341        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      189
 NPARAMETR:  1.0817E+01  3.2415E+01  9.0785E-01  5.3184E+01  7.4418E-02  1.1867E-01
 PARAMETER:  1.7852E-01  1.1289E-01 -6.8983E-01  4.0738E+00 -4.7738E-02  1.3369E+00
 GRADIENT:   2.7326E-03 -1.7314E-02  1.1718E-02  1.6296E-02  6.7614E-03 -6.4151E-03
 
0ITERATION NO.:   20    OBJECTIVE VALUE:   1211.13662769341        NO. OF FUNC. EVALS.:   0
 CUMULATIVE NO. OF FUNC. EVALS.:      189
 NPARAMETR:  1.0817E+01  3.2415E+01  9.0785E-01  5.3184E+01  7.4418E-02  1.1867E-01
 PARAMETER:  1.7852E-01  1.1289E-01 -6.8983E-01  4.0738E+00 -4.7738E-02  1.3369E+00
 GRADIENT:   2.7326E-03 -1.7314E-02  1.1718E-02  1.6296E-02  6.7614E-03 -6.4151E-03
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      189
 NO. OF SIG. DIGITS IN FINAL EST.:  3.5

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.4607E-02  1.8859E-03
 SE:             4.4277E-02  6.1657E-02
 N:                      30          30
 
 P VAL.:         7.4147E-01  9.7560E-01
 
 ETASHRINKSD(%)  1.1100E+01  1.9647E+00
 ETASHRINKVR(%)  2.0968E+01  3.8909E+00
 EBVSHRINKSD(%)  1.0795E+01  1.7065E+00
 EBVSHRINKVR(%)  2.0425E+01  3.3839E+00
 RELATIVEINF(%)  7.9540E+01  9.6574E+01
 EPSSHRINKSD(%)  4.7788E+00
 EPSSHRINKVR(%)  9.3292E+00
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          540
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    992.453615861047     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    1211.13662769341     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       2203.59024355445     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            60
  
 #TERE:
 Elapsed estimation  time in seconds:    42.62
 Elapsed covariance  time in seconds:    11.32
 Elapsed postprocess time in seconds:     0.14
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     1211.137       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         1.08E+01  3.24E+01  9.08E-01  5.32E+01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        7.44E-02
 
 ETA2
+        0.00E+00  1.19E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        2.73E-01
 
 ETA2
+        0.00E+00  3.44E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         6.17E-01  2.08E+00  7.87E-02  3.93E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        2.41E-02
 
 ETA2
+       .........  3.19E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+       .........
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        4.42E-02
 
 ETA2
+       .........  4.63E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+       .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        3.81E-01
 
 TH 2
+        2.69E-02  4.34E+00
 
 TH 3
+       -2.35E-03  4.55E-05  6.19E-03
 
 TH 4
+        1.52E-01  2.35E-01 -2.04E-01  1.55E+01
 
 OM11
+       -2.87E-03 -2.66E-03  1.07E-04 -1.08E-02  5.81E-04
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -1.47E-04  3.70E-05  5.59E-05 -4.26E-03 -1.87E-05 .........  1.02E-03
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        6.17E-01
 
 TH 2
+        2.09E-02  2.08E+00
 
 TH 3
+       -4.85E-02  2.77E-04  7.87E-02
 
 TH 4
+        6.27E-02  2.87E-02 -6.60E-01  3.93E+00
 
 OM11
+       -1.93E-01 -5.30E-02  5.64E-02 -1.14E-01  2.41E-02
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -7.46E-03  5.57E-04  2.23E-02 -3.40E-02 -2.44E-02 .........  3.19E-02
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        2.73E+00
 
 TH 2
+       -8.23E-03  2.31E-01
 
 TH 3
+        4.13E-01 -1.99E-01  2.87E+02
 
 TH 4
+       -1.19E-02 -5.41E-03  3.80E+00  1.16E-01
 
 OM11
+        1.32E+01  9.55E-01  1.93E+01  1.40E+00  1.81E+03
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+        5.64E-01 -3.72E-03  6.01E-01  3.02E-01  4.00E+01 .........  9.85E+02
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 Elapsed finaloutput time in seconds:     0.12
1THERE ARE ERROR MESSAGES IN FILE PRDERR                                                                  
 #CPUT: Total CPU Time in Seconds,       38.312
Stop Time: 
Thu 09/23/2021 
12:17 PM
