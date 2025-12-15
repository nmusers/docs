Thu 09/23/2021 
09:34 AM
$PROBLEM EX4model2, FOCE, using OTHER routine sde.f90
$ABBR DECLARE SGW(3) ; need at least nde of these
$ABBR DES=FULL

$INPUT ID TIME DV MDV EVID AMT CMT AGE SEX BSA SDEX SDE

$DATA sde_ex4o.dat
      IGNORE @

$SUBROUTINE ADVAN13 TOL=7 ATOL=7 OTHER=SDE.F90

$MODEL
COMP=(CENTRAL)
COMP=(PERIPH)
COMP=(ISR)
COMP=(OBSQ)
COMP=(P1)
COMP=(P2)
COMP=(P3)
COMP=(P4)
COMP=(P5)
COMP=(P6)

$THETA (0 0.1) ; ISR0
$THETA (0 0.6) ; W
$THETA (0, 0.1) ; SGW3

$OMEGA 0.5     ; ISR0

$SIGMA 1 FIX
$SIGMA 1 FIX

$PK
T12A=4.52
ALPHA=LOG(2)/T12A
FRACA=0.78
FRACB=1-FRACA
T12B=0.14*AGE+29.2
BETA=LOG(2)/T12B
K21=(FRACA*BETA+FRACB*ALPHA)/(FRACA+FRACB)
K10=(ALPHA*BETA)/K21
K12=ALPHA+BETA-K21-K10
V1=1
IF (SEX.EQ.0) V1=1.92*BSA+0.64
IF (SEX.EQ.1) V1=1.11*BSA+2.04
TVISR0=THETA(1)
ISR0=TVISR0*EXP(ETA(1))
F1=ISR0/K10
F2=K12*F1/K21
F3=ISR0
SGW3=THETA(3)

ISR=A(3)
ISRV=0

NCMT=1
NDE=3

$DES
FIRSTEM=1
DADT(1) = A(3)-K10*A(1)-K12*A(1)+K21*A(2)
DADT(2) = K12*A(1)-K21*A(2)
DADT(3) = 0
DADT(4)=A(1)/V1
SGW(1)=0.0
SGW(2)=0.0
SGW(3)=SGW3
"LAST
"      CALL SDE_DER(DADT,A,DA,IR,SGW,NDE,NCMT)


$ERROR (OBS ONLY)
IPRED=A(1)/V1
IRES=DV-IPRED
W=THETA(2)
IWRES=IRES/W
WS=1000.0
Y=IPRED+W*EPS(1)+WS*EPS(2)
"LAST
"       CALL SDE_CADD(A,HH,TIME,DV,CMT,NDE,NCMT,SDE)

$EST MAXEVAL=9999 METHOD=1 INTER NOABORT NSIG=2 PRINT=1 OPTMAP=1 ETADER=2 SIGL=6 MCETA=1 SLOW
;$EST METHOD=IMP PRINT=1 CTYPE=3 OPTMAP=1 ETADER=2 SIGL=6 MCETA=1 SLOW

$COVARIANCE UNCONDITIONAL MATRIX=R

$TABLE ID TIME EVID SDE IPRED IRES IWRES
       TVISR0 W
       ISR ISRV
       AGE SEX BSA
       NOPRINT ONEHEADER FILE=sde_ex4_foceo.tab
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  45) $DES: VALUES HAVE NOT BEEN ASSIGNED TO ALL DADT VARIABLES.
 UNUSED COMPARTMENTS SHOULD BE OFF.
  
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
 EX4model2, FOCE, using OTHER routine sde.f90
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:      456
 NO. OF DATA ITEMS IN DATA SET:  12
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   3
 MDV DATA ITEM IS DATA ITEM NO.:  4
0INDICES PASSED TO SUBROUTINE PRED:
   5   2   6   0   0   0   7   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID TIME DV MDV EVID AMT CMT AGE SEX BSA SDEX SDE
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 TVISR0 ISR ISRV IPRED IRES W IWRES
0FORMAT FOR DATA:
 (12E6.0)

 TOT. NO. OF OBS RECS:      420
 TOT. NO. OF INDIVIDUALS:       12
0LENGTH OF THETA:   3
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   2
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
  0.0000E+00     0.1000E+00     0.1000E+07
  0.0000E+00     0.6000E+00     0.1000E+07
  0.0000E+00     0.1000E+00     0.1000E+07
0INITIAL ESTIMATE OF OMEGA:
 0.5000E+00
0INITIAL ESTIMATE OF SIGMA:
 0.1000E+01
 0.0000E+00   0.1000E+01
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
 HEADER:                YES
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID TIME EVID SDE IPRED IRES IWRES TVISR0 W ISR ISRV AGE SEX BSA
1DOUBLE PRECISION PREDPP VERSION 7.5.1

 GENERAL NONLINEAR KINETICS MODEL WITH STIFF/NONSTIFF EQUATIONS (LSODA, ADVAN13)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:   5
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         CENTRAL      ON         YES        YES        YES        YES
    2         PERIPH       ON         YES        YES        NO         NO
    3         ISR          ON         YES        YES        NO         NO
    4         OBSQ         ON         YES        YES        NO         NO
    5         P1           ON         YES        YES        NO         NO
    6         P2           ON         YES        YES        NO         NO
    7         P3           ON         YES        YES        NO         NO
    8         P4           ON         YES        YES        NO         NO
    9         P5           ON         YES        YES        NO         NO
   10         P6           ON         YES        YES        NO         NO
   11         OUTPUT       OFF        YES        NO         NO         NO
 INITIAL (BASE) TOLERANCE SETTINGS:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   7
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   7
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            *           6           *           *           *
    2            *           7           *           *           *
    3            *           8           *           *           *
    4            *           *           *           *           *
    5            *           *           *           *           *
    6            *           *           *           *           *
    7            *           *           *           *           *
    8            *           *           *           *           *
    9            *           *           *           *           *
   10            *           *           *           *           *
   11            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      5
   TIME DATA ITEM IS DATA ITEM NO.:          2
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   6
   COMPT. NO. DATA ITEM IS DATA ITEM NO.:    7

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0DURING SIMULATION, ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 OTHERWISE, ERROR SUBROUTINE CALLED ONLY WITH OBSERVATION EVENTS.
0ERROR SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
0DES SUBROUTINE USES FULL STORAGE MODE.
1
 
 
 #TBLN:      1
 #METH: First Order Conditional Estimation with Interaction
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               SLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            9999
 NO. OF SIG. FIGURES REQUIRED:            2
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   1
 ETA HESSIAN EVALUATION METHOD (ETADER):    2
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    1
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      6
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     6
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): sde_ex4_foceo.ext
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
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   7
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   7
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   7
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   7
 TOLERANCES FOR TABLE/SCATTER STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   7
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   7
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 MONITORING OF SEARCH:

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   329.049942207423        NO. OF FUNC. EVALS.:   5
 CUMULATIVE NO. OF FUNC. EVALS.:        5
 NPARAMETR:  1.0000E-01  6.0000E-01  1.0000E-01  5.0000E-01
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:  -1.5286E+01  3.5067E+02  4.1040E+02 -9.6247E+00
 
0ITERATION NO.:    1    OBJECTIVE VALUE:  -396.888115699404        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       13
 NPARAMETR:  1.0457E-01  2.1520E-01  3.0119E-02  5.2895E-01
 PARAMETER:  1.4470E-01 -9.2535E-01 -1.1000E+00  1.2814E-01
 GRADIENT:  -4.2725E+01  2.7610E+02  1.3063E+02 -1.2004E+01
 
0ITERATION NO.:    2    OBJECTIVE VALUE:  -517.146797370048        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       20
 NPARAMETR:  1.1536E-01  1.1407E-01  2.2305E-02  5.5897E-01
 PARAMETER:  2.4293E-01 -1.5601E+00 -1.4003E+00  1.5574E-01
 GRADIENT:  -2.0804E+01  6.2303E+01 -1.5037E+02 -5.1476E+00
 
0ITERATION NO.:    3    OBJECTIVE VALUE:  -536.854632190015        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       27
 NPARAMETR:  1.1965E-01  9.7524E-02  2.5207E-02  5.6966E-01
 PARAMETER:  2.7936E-01 -1.7168E+00 -1.2780E+00  1.6522E-01
 GRADIENT:  -2.3759E+01  2.5405E+01 -4.1824E+01 -3.3111E+00
 
0ITERATION NO.:    4    OBJECTIVE VALUE:  -544.638211149185        NO. OF FUNC. EVALS.:   6
 CUMULATIVE NO. OF FUNC. EVALS.:       33
 NPARAMETR:  2.7661E-01  1.0124E-01  2.6169E-02  6.6067E-01
 PARAMETER:  1.1175E+00 -1.6794E+00 -1.2406E+00  2.3932E-01
 GRADIENT:   5.9849E+00  4.3095E+01  2.5578E+00  2.5555E+01
 
0ITERATION NO.:    5    OBJECTIVE VALUE:  -545.751487918947        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       40
 NPARAMETR:  3.1844E-01  1.0110E-01  2.6357E-02  4.8013E-01
 PARAMETER:  1.2583E+00 -1.6808E+00 -1.2334E+00  7.9720E-02
 GRADIENT:   1.4884E+01  4.2551E+01  9.3639E+00  1.3367E+01
 
0ITERATION NO.:    6    OBJECTIVE VALUE:  -552.436192951457        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       48
 NPARAMETR:  2.5812E-01  9.0257E-02  2.6582E-02  3.5891E-01
 PARAMETER:  1.0483E+00 -1.7943E+00 -1.2249E+00 -6.5771E-02
 GRADIENT:   4.6210E+00  7.7908E+00  2.6796E+00  1.2341E+01
 
0ITERATION NO.:    7    OBJECTIVE VALUE:  -554.781223127888        NO. OF FUNC. EVALS.:   6
 CUMULATIVE NO. OF FUNC. EVALS.:       54
 NPARAMETR:  2.3005E-01  8.7330E-02  2.6715E-02  2.4188E-01
 PARAMETER:  9.3314E-01 -1.8272E+00 -1.2199E+00 -2.6309E-01
 GRADIENT:  -3.6337E+00 -4.6442E-01  3.4017E+00  1.0665E+01
 
0ITERATION NO.:    8    OBJECTIVE VALUE:  -555.475729298146        NO. OF FUNC. EVALS.:   6
 CUMULATIVE NO. OF FUNC. EVALS.:       60
 NPARAMETR:  2.2495E-01  8.5223E-02  2.6749E-02  1.5300E-01
 PARAMETER:  9.1071E-01 -1.8517E+00 -1.2187E+00 -4.9208E-01
 GRADIENT:  -9.9401E+00 -7.8400E+00  4.0063E-01  7.4550E-01
 
0ITERATION NO.:    9    OBJECTIVE VALUE:  -555.869097449522        NO. OF FUNC. EVALS.:   6
 CUMULATIVE NO. OF FUNC. EVALS.:       66
 NPARAMETR:  2.4018E-01  8.5500E-02  2.6704E-02  1.4614E-01
 PARAMETER:  9.7623E-01 -1.8484E+00 -1.2203E+00 -5.1501E-01
 GRADIENT:  -3.8536E-01 -7.7444E+00 -3.7284E-01  1.2536E+00
 
0ITERATION NO.:   10    OBJECTIVE VALUE:  -555.955273318167        NO. OF FUNC. EVALS.:   6
 CUMULATIVE NO. OF FUNC. EVALS.:       72
 NPARAMETR:  2.4238E-01  8.7153E-02  2.6666E-02  1.3970E-01
 PARAMETER:  9.8534E-01 -1.8293E+00 -1.2218E+00 -5.3755E-01
 GRADIENT:   1.2864E+00 -1.8141E+00  7.3294E-01  5.9675E-01
 
0ITERATION NO.:   11    OBJECTIVE VALUE:  -555.956319480250        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       79
 NPARAMETR:  2.4204E-01  8.7280E-02  2.6659E-02  1.3904E-01
 PARAMETER:  9.8393E-01 -1.8278E+00 -1.2221E+00 -5.3992E-01
 GRADIENT:   9.2547E-01 -1.8786E+00  1.1298E+00 -4.2465E-01
 
0ITERATION NO.:   12    OBJECTIVE VALUE:  -555.956319480250        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       87
 NPARAMETR:  2.4204E-01  8.7280E-02  2.6659E-02  1.3904E-01
 PARAMETER:  9.8393E-01 -1.8278E+00 -1.2221E+00 -5.3992E-01
 GRADIENT:   1.8785E-01 -2.2175E+00 -1.1082E-01 -1.2942E+00
 
0ITERATION NO.:   13    OBJECTIVE VALUE:  -555.976981364578        NO. OF FUNC. EVALS.:   6
 CUMULATIVE NO. OF FUNC. EVALS.:       93            RESET HESSIAN, TYPE II
 NPARAMETR:  2.4180E-01  8.7916E-02  2.6662E-02  1.4290E-01
 PARAMETER:  9.8292E-01 -1.8205E+00 -1.2219E+00 -5.2624E-01
 GRADIENT:   9.8608E-01  4.4738E-03  1.4909E+00 -1.0421E+00
 
0ITERATION NO.:   14    OBJECTIVE VALUE:  -555.980818223201        NO. OF FUNC. EVALS.:   6
 CUMULATIVE NO. OF FUNC. EVALS.:       99
 NPARAMETR:  2.4076E-01  8.8213E-02  2.6635E-02  1.4706E-01
 PARAMETER:  9.7861E-01 -1.8172E+00 -1.2229E+00 -5.1189E-01
 GRADIENT:  -7.7112E-01  8.6332E-01  1.6989E+00  9.0447E-01
 
0ITERATION NO.:   15    OBJECTIVE VALUE:  -555.981784656561        NO. OF FUNC. EVALS.:   6
 CUMULATIVE NO. OF FUNC. EVALS.:      105
 NPARAMETR:  2.4095E-01  8.8146E-02  2.6627E-02  1.4640E-01
 PARAMETER:  9.7943E-01 -1.8179E+00 -1.2232E+00 -5.1412E-01
 GRADIENT:  -3.8183E-01  1.1206E+00  1.0655E+00 -6.1484E-01
 
0ITERATION NO.:   16    OBJECTIVE VALUE:  -555.981784656561        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:      113
 NPARAMETR:  2.4095E-01  8.8146E-02  2.6627E-02  1.4640E-01
 PARAMETER:  9.7943E-01 -1.8179E+00 -1.2232E+00 -5.1412E-01
 GRADIENT:  -5.1726E-01  6.6244E-01  1.6606E-01 -1.8687E-01
 
0ITERATION NO.:   17    OBJECTIVE VALUE:  -555.981784656561        NO. OF FUNC. EVALS.:   0
 CUMULATIVE NO. OF FUNC. EVALS.:      113
 NPARAMETR:  2.4095E-01  8.8146E-02  2.6627E-02  1.4640E-01
 PARAMETER:  9.7943E-01 -1.8179E+00 -1.2232E+00 -5.1412E-01
 GRADIENT:  -5.1726E-01  6.6244E-01  1.6606E-01 -1.8687E-01
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      113
 NO. OF SIG. DIGITS IN FINAL EST.:  2.6

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.0320E-02
 SE:             1.0658E-01
 N:                      12
 
 P VAL.:         9.2286E-01
 
 ETASHRINKSD(%)  3.5054E+00
 ETASHRINKVR(%)  6.8879E+00
 EBVSHRINKSD(%)  2.8527E+00
 EBVSHRINKVR(%)  5.6240E+00
 RELATIVEINF(%)  9.4376E+01
 EPSSHRINKSD(%)  1.3802E+00  1.8401E-01
 EPSSHRINKVR(%)  2.7413E+00  3.6768E-01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          420
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    771.908367891925     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -555.981784656561     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       215.926583235364     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            12
  
 #TERE:
 Elapsed estimation  time in seconds:   140.54
 Elapsed covariance  time in seconds:    41.61
 Elapsed postprocess time in seconds:     1.12
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     -555.982       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         2.41E-01  8.81E-02  2.66E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1     
 
 ETA1
+        1.46E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        1.00E+00
 
 EPS2
+        0.00E+00  1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1     
 
 ETA1
+        3.83E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        1.00E+00
 
 EPS2
+        0.00E+00  1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         2.74E-02  7.47E-03  1.22E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1     
 
 ETA1
+        6.35E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+       .........
 
 EPS2
+       ......... .........
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1     
 
 ETA1
+        8.29E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+       .........
 
 EPS2
+       ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      SG11      SG12      SG22  
 
 TH 1
+        7.51E-04
 
 TH 2
+        5.97E-06  5.58E-05
 
 TH 3
+       -5.34E-07 -2.52E-06  1.50E-06
 
 OM11
+       -3.45E-05 -1.21E-05 -2.28E-07  4.03E-03
 
 SG11
+       ......... ......... ......... ......... .........
 
 SG12
+       ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      SG11      SG12      SG22  
 
 TH 1
+        2.74E-02
 
 TH 2
+        2.91E-02  7.47E-03
 
 TH 3
+       -1.59E-02 -2.75E-01  1.22E-03
 
 OM11
+       -1.98E-02 -2.54E-02 -2.93E-03  6.35E-02
 
 SG11
+       ......... ......... ......... ......... .........
 
 SG12
+       ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      SG11      SG12      SG22  
 
 TH 1
+        1.33E+03
 
 TH 2
+       -1.28E+02  1.94E+04
 
 TH 3
+        2.60E+02  3.26E+04  7.22E+05
 
 OM11
+        1.11E+01  5.89E+01  1.41E+02  2.49E+02
 
 SG11
+       ......... ......... ......... ......... .........
 
 SG12
+       ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... .........
 
 Elapsed finaloutput time in seconds:     0.05
 #CPUT: Total CPU Time in Seconds,      183.547
Stop Time: 
Thu 09/23/2021 
09:37 AM
