Tue 01/11/2022 
05:55 PM
$PROBLEM PDLIDR
$ABBR PROTECT
$ABBR DERIV2=NO DERIV2=NOCOMMON ; DERIV1=NO
$INPUT ID TIME DV MDV CMT
$DATA data_LDL_Cholesterol.csv IGNORE=@
$SUBROUTINES ADVAN16 TOL=12
$MODEL NCOMPARTMENTS=3 

$PK
Imax=THETA(1)
IC50=THETA(2)
Gam=THETA(3)
RZ0=THETA(4)
kout=THETA(5)
kin = RZ0*kout 
Dm = 50*0.3;  % 300 gr rat
ka1 = 1.255;
ka2 = 0.219;
FZ = 0.214;
Fr = 0.715;
kel = 5.57;   
k12 = 3.61;
k21 = 2.84;
V = 0.719*0.3;
;  TAUy
TAU1=THETA(6)
; Initial conditions
A_0(1)=0
A_0(2)=0
A_0(3)=RZ0

$DES
; AD_x_y is the State value of A(x) delayed for time TAUy.  
; AP_x_y is the State value of A(x) in the past, for time delay TAUy.  
AP_3_1=RZ0

;BASE EQUATIONS 

CC = (A(1)/V)*1000

DADT(1) = ka1*Dm*FZ*Fr*exp(-ka1*t)+ka2*Dm*FZ*(1-Fr)*exp(-ka2*t)-(kel+k12)*A(1)+k21*A(2)
DADT(2) = k12*A(1)-k21*A(2)
DADT(3) = kin*A(3)-kout*(1-(Imax*(CC**Gam))/((IC50**Gam)+(CC**Gam)))*A(3)*AD_3_1

$ERROR
IPRED = A(3)
IRES = DV-IPRED
W = SQRT((THETA(8)*IPRED)**2+THETA(7)**2)
IWRES =  IRES/W
Y = IPRED+W*ERR(1)

$THETA
1 FIX       ; 1: Imax
(0,100)     ; 2: IC50
0.2 FIX     ; 3: Gam
(0,31.3)    ; 4: RZ0
(0,0.0065)  ; 5: kout
(0,7.12)    ; 6: T
0 FIX       ; 7: Add
(0,1)       ; 8: Prop

$OMEGA
1 FIX

$EST METHOD=0 NOHABORT MAXEVAL=9999 PRINT=1 NSIG=3 SIGL=12
$COV MATRIX=R UNCONDITIONAL
$TABLE ID TIME IPRED NOPRINT ONEHEADER
FILE=dloidr.tab
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  1) NM-TRAN INFERS THAT THE DATA ARE SINGLE-SUBJECT.
  NONMEM RUN CANNOT BE PARALLELIZED.
             
 (WARNING  83) FUNCTIONS ARE USED IN ABBREVIATED CODE, BUT THE $SUBROUTINES
 RECORD DOES NOT INCLUDE THE "OTHER" OPTION.
  
License Registered to: NONMEM license (with RADAR5NM) for ICON Pharmacometrics Team
Expiration Date:    31 DEC 2030
Current Date:       11 JAN 2022
Days until program expires :3270
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.1
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 PDLIDR
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:       19
 NO. OF DATA ITEMS IN DATA SET:   7
 ID DATA ITEM IS DATA ITEM NO.:   7
 DEP VARIABLE IS DATA ITEM NO.:   3
 MDV DATA ITEM IS DATA ITEM NO.:  4
0INDICES PASSED TO SUBROUTINE PRED:
   6   2   0   0   0   0   5   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID TIME DV MDV CMT EVID .ID.
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 IPRED
0FORMAT FOR DATA:
 (5E8.0,2F2.0)

 TOT. NO. OF OBS RECS:       18
 TOT. NO. OF INDIVIDUALS:       18
0LENGTH OF THETA:   8
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
  0.1000E+01     0.1000E+01     0.1000E+01
  0.0000E+00     0.1000E+03     0.1000E+07
  0.2000E+00     0.2000E+00     0.2000E+00
  0.0000E+00     0.3130E+02     0.1000E+07
  0.0000E+00     0.6500E-02     0.1000E+07
  0.0000E+00     0.7120E+01     0.1000E+07
  0.0000E+00     0.0000E+00     0.0000E+00
  0.0000E+00     0.1000E+01     0.1000E+07
0INITIAL ESTIMATE OF OMEGA:
 0.1000E+01
0OMEGA CONSTRAINED TO BE THIS INITIAL ESTIMATE
0COVARIANCE STEP OMITTED:        NO
 R MATRIX SUBSTITUTED:          YES
 S MATRIX SUBSTITUTED:           NO
 EIGENVLS. PRINTED:              NO
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
 HEADER:                YES
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID TIME IPRED
1DOUBLE PRECISION PREDPP VERSION 7.5.1

 GENERAL NONLINEAR KINETICS MODEL WITH STIFF/NONSTIFF AND DELAY EQUATIONS (RADAR5, ADVAN16)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:  16
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         COMP 1       ON         YES        YES        YES        YES
    2         COMP 2       ON         YES        YES        NO         NO
    3         COMP 3       ON         YES        YES        NO         NO
    4         OUTPUT       OFF        YES        NO         NO         NO
 INITIAL (BASE) TOLERANCE SETTINGS:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  12
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            *           *           *           *           *
    2            *           *           *           *           *
    3            *           *           *           *           *
    4            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      6
   TIME DATA ITEM IS DATA ITEM NO.:          2
   COMPT. NO. DATA ITEM IS DATA ITEM NO.:    5

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0PK SUBROUTINE INDICATES THAT COMPARTMENT AMOUNTS ARE INITIALIZED.
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
0DES SUBROUTINE USES FULL STORAGE MODE.
1


 #TBLN:      1
 #METH: First Order

 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           SINGLE-SUBJECT
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               SLOW
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      12
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     12
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): dloidr.ext
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
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  12
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  12
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
 TOLERANCES FOR TABLE/SCATTER STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  12
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12

 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=NPRED
 RES=NRES
 WRES=NWRES
 IWRS=NIWRES
 IPRD=NIPRED
 IRS=NIRES

 MONITORING OF SEARCH:


0ITERATION NO.:    0    OBJECTIVE VALUE:   139.171211475111        NO. OF FUNC. EVALS.:   6
 CUMULATIVE NO. OF FUNC. EVALS.:        6
 NPARAMETR:  1.0000E+02  3.1300E+01  6.5000E-03  7.1200E+00  1.0000E+00
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:  -1.4721E+00  4.5860E+01  9.5791E+00 -5.7037E+00  3.4562E+01

0ITERATION NO.:    1    OBJECTIVE VALUE:   125.159692998921        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       13
 NPARAMETR:  1.0097E+02  2.3188E+01  6.1052E-03  7.3907E+00  7.9764E-01
 PARAMETER:  1.0963E-01 -2.0000E-01  3.7336E-02  1.3731E-01 -1.2609E-01
 GRADIENT:   3.2344E-01 -1.1891E+01 -6.6165E+00  2.4682E+00  1.8530E+01

0ITERATION NO.:    2    OBJECTIVE VALUE:   105.328339202569        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       21
 NPARAMETR:  1.0065E+02  2.7119E+01  7.1945E-03  7.0236E+00  3.7432E-01
 PARAMETER:  1.0646E-01 -4.3398E-02  2.0152E-01  8.6365E-02 -8.8265E-01
 GRADIENT:   4.8352E-01 -1.2674E+01 -5.8345E+00  3.1126E+00  2.0573E+01

0ITERATION NO.:    3    OBJECTIVE VALUE:   104.631607974254        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       28
 NPARAMETR:  1.0033E+02  2.8943E+01  7.5490E-03  6.8401E+00  2.7807E-01
 PARAMETER:  1.0326E-01  2.1699E-02  2.4962E-01  5.9889E-02 -1.1799E+00
 GRADIENT:  -7.1088E-01  1.2418E+02  1.2515E+02 -3.5648E+01  7.2820E+00

0ITERATION NO.:    4    OBJECTIVE VALUE:   102.414316661925        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       35
 NPARAMETR:  9.9624E+01  3.0889E+01  6.9442E-03  6.8656E+00  2.3856E-01
 PARAMETER:  9.6232E-02  8.6795E-02  1.6610E-01  6.3611E-02 -1.3331E+00
 GRADIENT:  -1.8267E+00  1.3784E+02  1.0317E+02 -3.4513E+01  5.1420E+00

0ITERATION NO.:    5    OBJECTIVE VALUE:   102.334199404743        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:       45
 NPARAMETR:  9.9445E+01  3.0903E+01  6.9521E-03  6.9265E+00  2.3748E-01
 PARAMETER:  9.4439E-02  8.7239E-02  1.6724E-01  7.2447E-02 -1.3377E+00
 GRADIENT:  -2.0793E+00  1.4221E+02  1.0732E+02 -1.9304E+01  4.9936E+00

0ITERATION NO.:    6    OBJECTIVE VALUE:   97.1959418668751        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       53
 NPARAMETR:  8.7681E+01  2.9305E+01  6.8843E-03  7.0198E+00  1.8178E-01
 PARAMETER: -3.1463E-02  3.4153E-02  1.5745E-01  8.5830E-02 -1.6049E+00
 GRADIENT:   6.7674E-01  6.8886E+00  2.6714E+01  2.2103E+01 -8.5675E+00

0ITERATION NO.:    7    OBJECTIVE VALUE:   96.4547447196865        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       60
 NPARAMETR:  7.2598E+01  2.9241E+01  6.8179E-03  6.9836E+00  1.9893E-01
 PARAMETER: -2.2024E-01  3.1959E-02  1.4775E-01  8.0651E-02 -1.5148E+00
 GRADIENT:   2.7003E-01  4.7633E+00  1.1340E+01  8.3817E+00 -3.6513E-01

0ITERATION NO.:    8    OBJECTIVE VALUE:   96.3220077712074        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       67
 NPARAMETR:  5.4757E+01  2.9236E+01  6.7300E-03  6.9305E+00  1.9481E-01
 PARAMETER: -5.0226E-01  3.1766E-02  1.3477E-01  7.3025E-02 -1.5357E+00
 GRADIENT:  -3.5026E-02  3.1660E+00  2.2227E+00 -1.5011E+00 -9.7553E-01

0ITERATION NO.:    9    OBJECTIVE VALUE:   96.3119684144776        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       74
 NPARAMETR:  5.3591E+01  2.9147E+01  6.7366E-03  6.9347E+00  1.9760E-01
 PARAMETER: -5.2378E-01  2.8741E-02  1.3576E-01  7.3630E-02 -1.5215E+00
 GRADIENT:  -6.4255E-04 -7.8521E-01 -1.2592E-03  9.4129E-01 -1.3045E-01

0ITERATION NO.:   10    OBJECTIVE VALUE:   96.3113090646794        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       81
 NPARAMETR:  5.4584E+01  2.9187E+01  6.7286E-03  6.9342E+00  1.9787E-01
 PARAMETER: -5.0543E-01  3.0106E-02  1.3456E-01  7.3563E-02 -1.5202E+00
 GRADIENT:  -8.4591E-04  1.3556E-01  1.5702E-01  2.7798E-02  1.6582E-02

0ITERATION NO.:   11    OBJECTIVE VALUE:   96.3112925898059        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:       88
 NPARAMETR:  5.4543E+01  2.9188E+01  6.7272E-03  6.9340E+00  1.9782E-01
 PARAMETER: -5.0618E-01  3.0151E-02  1.3436E-01  7.3536E-02 -1.5204E+00
 GRADIENT:  -2.3403E-04  2.2266E-02  2.3755E-02 -1.0126E-02  1.2021E-03

0ITERATION NO.:   12    OBJECTIVE VALUE:   96.3112925898059        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:       98
 NPARAMETR:  5.4543E+01  2.9188E+01  6.7272E-03  6.9340E+00  1.9782E-01
 PARAMETER: -5.0618E-01  3.0151E-02  1.3436E-01  7.3536E-02 -1.5204E+00
 GRADIENT:  -2.3468E-04  2.2140E-02  2.3683E-02 -1.0302E-02  1.1468E-03

0ITERATION NO.:   13    OBJECTIVE VALUE:   96.3112925898059        NO. OF FUNC. EVALS.:   0
 CUMULATIVE NO. OF FUNC. EVALS.:       98
 NPARAMETR:  5.4543E+01  2.9188E+01  6.7272E-03  6.9340E+00  1.9782E-01
 PARAMETER: -5.0618E-01  3.0151E-02  1.3436E-01  7.3536E-02 -1.5204E+00
 GRADIENT:  -2.3468E-04  2.2140E-02  2.3683E-02 -1.0302E-02  1.1468E-03

 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:       98
 NO. OF SIG. DIGITS IN FINAL EST.:  3.5
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):           18
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    33.081787195368214     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    96.311292589805873     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       129.39307978517408     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            18
  
 #TERE:
 Elapsed estimation  time in seconds:     1.09
 Elapsed covariance  time in seconds:     0.45
 Elapsed postprocess time in seconds:     0.04
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************       96.311       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8     
 
         1.00E+00  5.45E+01  2.00E-01  2.92E+01  6.73E-03  6.93E+00  0.00E+00  1.98E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1     
 
 ETA1
+        1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1     
 
 ETA1
+        1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8     
 
        .........  7.91E+01 .........  2.18E+00  5.69E-04  2.54E-01 .........  3.42E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1     
 
 ETA1
+       .........
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1     
 
 ETA1
+       .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11  
 
 TH 1
+       .........
 
 TH 2
+       .........  6.25E+03
 
 TH 3
+       ......... ......... .........
 
 TH 4
+       .........  1.31E+02 .........  4.74E+00
 
 TH 5
+       ......... -2.15E-02 ......... -1.02E-03  3.24E-07
 
 TH 6
+       .........  1.23E+01 .........  2.74E-01 -4.59E-05  6.46E-02
 
 TH 7
+       ......... ......... ......... ......... ......... ......... .........
 
 TH 8
+       .........  1.22E-02 ......... -1.23E-02  2.82E-06  2.67E-05 .........  1.17E-03
 
 OM11
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11  
 
 TH 1
+       .........
 
 TH 2
+       .........  7.91E+01
 
 TH 3
+       ......... ......... .........
 
 TH 4
+       .........  7.63E-01 .........  2.18E+00
 
 TH 5
+       ......... -4.77E-01 ......... -8.20E-01  5.69E-04
 
 TH 6
+       .........  6.11E-01 .........  4.95E-01 -3.17E-01  2.54E-01
 
 TH 7
+       ......... ......... ......... ......... ......... ......... .........
 
 TH 8
+       .........  4.51E-03 ......... -1.65E-01  1.45E-01  3.07E-03 .........  3.42E-02
 
 OM11
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11  
 
 TH 1
+       .........
 
 TH 2
+       .........  5.53E-04
 
 TH 3
+       ......... ......... .........
 
 TH 4
+       ......... -1.94E-02 .........  1.48E+00
 
 TH 5
+       ......... -2.91E+01 .........  3.25E+03  1.13E+07
 
 TH 6
+       ......... -4.34E-02 ......... -2.98E-01 -2.74E+02  2.48E+01
 
 TH 7
+       ......... ......... ......... ......... ......... ......... .........
 
 TH 8
+       ......... -1.38E-01 .........  7.91E+00  7.29E+03 -2.57E+00 .........  9.20E+02
 
 OM11
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 Elapsed finaloutput time in seconds:     0.02
 #CPUT: Total CPU Time in Seconds,        1.578
Stop Time: 
Tue 01/11/2022 
05:55 PM
