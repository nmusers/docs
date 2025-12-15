Sun 01/07/2018 
10:51 PM
$PROB TESTING RANDOM SAMPLERS
$ABBR FUNCTION STUDENTTb(VQI,10)
$ABBR VECTOR VV(10)
$INPUT  AMT TVAL DV DV2
$DATA  rsampler.csv

$PRED
NU=THETA(1)
QM1=THETA(2)
QM2=THETA(3)
SC11=THETA(4)
SC12=THETA(5)
SC22=THETA(6)
IPRED=QM1
F=QM1
IPRED2=QM2
IF(ICALL==4) THEN
VV(1)=1.0
VV(2)=1.0
VV(3)=NU
VV(4)=QM1
VV(5)=QM2
VV(6)=SC11
VV(7)=SC12
VV(8)=SC22
; DESCRIPTION : Given NORMAL random genrator K1, uniform Random generator K2, and parameters X(3)..., 
;               return Student T random bivariate deviate X(1),X(2). NU=X(3) may be non-integer.
" CALL STUDENTTB_RNG(3,2,VV)
Y=VV(1)
DV=Y
DV2=VV(2)
ELSE
VQI(1)=DV
VQI(2)=DV2
VQI(3)=NU
VQI(4)=QM1
VQI(5)=QM2
VQI(6)=SC11
VQI(7)=SC12
VQI(8)=SC22
WW=STUDENTTB(VQI)
Y=2.0*WW
ENDIF

$THETA 4.0 30.0 35.0 10.0 0.8 12.0

$SIMULATION (567811 NORMAL) (2933012 UNIFORM) (445678 NORMAL) SUBPROBLEMS=1
$EST METHOD=0 MAXEVAL=9999 PRINT=10 -2LL NOHABORT
$COVR
$TABLE TVAL DV DV2 IPRED IPRED2 NOAPPEND NOPRINT FILE=ran_studenttb.tab
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  1) NM-TRAN INFERS THAT THE DATA ARE SINGLE-SUBJECT.
  NONMEM RUN CANNOT BE PARALLELIZED.
             
 (WARNING  13) WITH USER-WRITTEN PRED OR $PRED, NM-TRAN CANNOT APPEND THE
 MDV DATA ITEM.

 (DATA WARNING   2) RECORD         1, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD         2, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD         3, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD         4, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD         5, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD         6, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD         7, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD         8, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD         9, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD        10, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD        11, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD        12, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD        13, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD        14, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD        15, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD        16, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD        17, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD        18, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD        19, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.

 (DATA WARNING   2) RECORD        20, DATA ITEM   4, CONTENTS:  
 THE NUMBER OF DATA ITEMS SPECIFIED IN $INPUT EXCEEDS THE NUMBER OF VALUES
 IN A RECORD OF THE NM-TRAN DATA FILE. NULLS WERE SUPPLIED FOR MISSING
 VALUES, STARTING WITH THE ABOVE NUMBERED DATA ITEM.*

 * THE MAXIMUM NUMBER OF WARNINGS OF ONE OR MORE TYPES WAS REACHED.
 IT IS POSSIBLE THAT SOME WARNING MESSAGES WERE SUPPRESSED.
             
 (WARNING  83) FUNCTIONS ARE USED IN ABBREVIATED CODE, BUT THE $SUBROUTINES
 RECORD DOES NOT INCLUDE THE "OTHER" OPTION.
  
License Registered to: IDS NONMEM 7 TEAM
Expiration Date:     2 JUN 2030
Current Date:        7 JAN 2018
Days until program expires :4525
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.4.2
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 TESTING RANDOM SAMPLERS
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:    10000
 NO. OF DATA ITEMS IN DATA SET:   5
 ID DATA ITEM IS DATA ITEM NO.:   5
 DEP VARIABLE IS DATA ITEM NO.:   3
0LABELS FOR DATA ITEMS:
 AMT TVAL DV DV2 .ID.
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 IPRED IPRED2
0FORMAT FOR DATA:
 (4E5.0,1F2.0)

 TOT. NO. OF OBS RECS:    10000
 TOT. NO. OF INDIVIDUALS:    10000
0LENGTH OF THETA:   6
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.4000E+01  0.3000E+02  0.3500E+02  0.1000E+02  0.8000E+00  0.1200E+02
0SIMULATION STEP OMITTED:    NO
 ORIGINAL DATA USED ON EACH NEW SIMULATION:         NO
 SEEDS RESET ON EACH NEW SUPERSET ITERATION:        YES
0SIMULATION RANDOM METHOD SELECTED (RANMETHOD): 4U
SEED   1 RESET TO INITIAL: YES
 SOURCE   1:
   SEED1:        567811   SEED2:             0   PSEUDO-NORMAL
SEED   2 RESET TO INITIAL: YES
 SOURCE   2:
   SEED1:       2933012   SEED2:             0   PSEUDO-UNIFORM
SEED   3 RESET TO INITIAL: YES
 SOURCE   3:
   SEED1:        445678   SEED2:             0   PSEUDO-NORMAL
 NUMBER OF SUBPROBLEMS:    1
0COVARIANCE STEP OMITTED:        NO
 EIGENVLS. PRINTED:              NO
 SPECIAL COMPUTATION:            NO
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
 FORCED POS. DEFINITE SETTING: (FPOSDEF):0
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
 HEADERS:               YES
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 TVAL DV DV2 IPRED IPRED2
1
 PROBLEM NO.:           1      SUBPROBLEM NO.:           1

 SIMULATION STEP PERFORMED
 SOURCE  1:
    SEED1:        567811   SEED2:             0
 SOURCE  2:
    SEED1:    1163575756   SEED2:             0
 SOURCE  3:
    SEED1:     954409204   SEED2:             0
 Elapsed simulation  time in seconds:     0.06
1
 
 
 #TBLN:      1
 #METH: First Order
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           SINGLE-SUBJECT
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               SLOW
 EPS-ETA INTERACTION:                     NO
 PRED F SET TO -2 LOG LIKELIHOOD:         YES
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
 NOPRIOR SETTING (NOPRIOR):                 OFF
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          ON
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      OFF
 RAW OUTPUT FILE (FILE): ran_studenttb.ext
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

 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=NPRED
 RES=NRES
 WRES=NWRES
 IWRS=NIWRES
 IPRD=NIPRED
 IRS=NIRES
 
 MONITORING OF SEARCH:

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   151935.628211664        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:        7
 NPARAMETR:  4.0000E+00  3.0000E+01  3.5000E+01  1.0000E+01  8.0000E-01  1.2000E+01
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:  -2.1687E+02  1.2347E+03  5.8862E+03 -1.1335E+03 -2.6990E+03  5.9104E+03
 
0ITERATION NO.:   10    OBJECTIVE VALUE:   151930.860117192        NO. OF FUNC. EVALS.: 136
 CUMULATIVE NO. OF FUNC. EVALS.:      143
 NPARAMETR:  3.9209E+00  2.9942E+01  3.4906E+01  9.8966E+00  7.9947E-01  1.1776E+01
 PARAMETER:  9.8023E-02  9.9807E-02  9.9731E-02  9.8966E-02  9.9933E-02  9.8131E-02
 GRADIENT:  -5.2794E-02  7.9935E-01 -4.6539E-01  3.0506E-01  4.7789E-02  5.0252E-01
 
0ITERATION NO.:   11    OBJECTIVE VALUE:   151930.860117192        NO. OF FUNC. EVALS.:   0
 CUMULATIVE NO. OF FUNC. EVALS.:      143
 NPARAMETR:  3.9209E+00  2.9942E+01  3.4906E+01  9.8966E+00  7.9947E-01  1.1776E+01
 PARAMETER:  9.8023E-02  9.9807E-02  9.9731E-02  9.8966E-02  9.9933E-02  9.8131E-02
 GRADIENT:  -5.2794E-02  7.9935E-01 -4.6539E-01  3.0506E-01  4.7789E-02  5.0252E-01
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      143
 NO. OF SIG. DIGITS IN FINAL EST.:  5.5
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):            0
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:   0.000000000000000E+000
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    151930.860117192     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       151930.860117192     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                             0
  
 #TERE:
 Elapsed estimation  time in seconds:    10.60
 Elapsed covariance  time in seconds:     6.23
 Elapsed postprocess time in seconds:     0.02
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   151930.860       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6     
 
         3.92E+00  2.99E+01  3.49E+01  9.90E+00  7.99E-01  1.18E+01
 
1
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6     
 
         1.16E-01  1.15E-01  1.37E-01  1.03E-01  4.14E-03  1.21E-01
 
1
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6  
 
 TH 1
+        1.34E-02
 
 TH 2
+       -3.52E-04  1.32E-02
 
 TH 3
+       -5.23E-04  1.26E-02  1.88E-02
 
 TH 4
+        5.71E-03 -2.16E-04 -3.92E-04  1.06E-02
 
 TH 5
+        2.36E-06 -4.38E-07 -5.15E-06  1.83E-04  1.71E-05
 
 TH 6
+        6.67E-03 -4.28E-04 -7.56E-04  9.55E-03  2.16E-04  1.45E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6  
 
 TH 1
+        1.16E-01
 
 TH 2
+       -2.65E-02  1.15E-01
 
 TH 3
+       -3.29E-02  8.03E-01  1.37E-01
 
 TH 4
+        4.79E-01 -1.83E-02 -2.78E-02  1.03E-01
 
 TH 5
+        4.92E-03 -9.22E-04 -9.07E-03  4.31E-01  4.14E-03
 
 TH 6
+        4.77E-01 -3.09E-02 -4.57E-02  7.70E-01  4.33E-01  1.21E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6  
 
 TH 1
+        1.10E+02
 
 TH 2
+        4.88E-01  2.14E+02
 
 TH 3
+        6.55E-01 -1.43E+02  1.50E+02
 
 TH 4
+       -4.28E+01  3.25E-01 -1.69E+00  2.56E+02
 
 TH 5
+        8.93E+02 -2.58E+01  5.33E+00 -1.06E+03  8.13E+04
 
 TH 6
+       -3.56E+01 -1.22E+00  4.28E+00 -1.33E+02 -9.20E+02  1.86E+02
 
 Elapsed finaloutput time in seconds:     0.39
 #CPUT: Total CPU Time in Seconds,       18.049
Stop Time: 
Sun 01/07/2018 
10:51 PM
