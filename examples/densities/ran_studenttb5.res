Wed 01/10/2018 
07:41 PM
$PROB TESTING RANDOM SAMPLERS
$ABBR FUNCTION STUDENTTB2(VQI,10)
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
;               Given Normal Random generator K, and parameters X(3)..., 
;               Create two correlated (C12=X(7)) cnormal samples, followed by univariate t-sample transformation.
;               This tests the algorithms used in tdist6_sim.ctl, tdist7.ctl 
" CALL STUDENTTB5_RNG(3,VV)
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
WW=STUDENTTB2(VQI)
Y=2.0*WW
ENDIF

$THETA 4.0 30.0 35.0 (0.0,10.0) (0.8) (0.0,12.0)

$SIMULATION (567811 NORMAL) (2933012 UNIFORM) (445678 NORMAL) SUBPROBLEMS=1
$EST METHOD=0 MAXEVAL=9999 PRINT=10 -2LL NOHABORT
$COVR
$TABLE TVAL DV DV2 IPRED IPRED2 NOAPPEND NOPRINT FILE=ran_studenttb5.tab
  
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
Current Date:       10 JAN 2018
Days until program expires :4522
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
 LOWER BOUND    INITIAL EST    UPPER BOUND
 -0.1000E+07     0.4000E+01     0.1000E+07
 -0.1000E+07     0.3000E+02     0.1000E+07
 -0.1000E+07     0.3500E+02     0.1000E+07
  0.0000E+00     0.1000E+02     0.1000E+07
 -0.1000E+07     0.8000E+00     0.1000E+07
  0.0000E+00     0.1200E+02     0.1000E+07
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
    SEED1:       2933012   SEED2:             0
 SOURCE  3:
    SEED1:     134785036   SEED2:             0
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
 RAW OUTPUT FILE (FILE): ran_studenttb5.ext
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

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   153772.598263985        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:        7
 NPARAMETR:  4.0000E+00  3.0000E+01  3.5000E+01  1.0000E+01  8.0000E-01  1.2000E+01
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:   1.3923E+03 -1.3599E+04  1.7026E+04 -2.0188E+03  5.7332E+04  7.4806E+02
 
0ITERATION NO.:   10    OBJECTIVE VALUE:   153604.312569564        NO. OF FUNC. EVALS.: 107
 CUMULATIVE NO. OF FUNC. EVALS.:      114
 NPARAMETR:  4.1009E+00  3.0060E+01  3.4892E+01  9.8299E+00  7.4653E-01  1.1609E+01
 PARAMETER:  1.0252E-01  1.0020E-01  9.9690E-02  8.2844E-02  9.3316E-02  6.6892E-02
 GRADIENT:   2.7656E+01  8.9105E+01 -1.3530E+02 -4.9902E+00 -3.6667E+01  4.9926E-01
 
0ITERATION NO.:   12    OBJECTIVE VALUE:   153604.310586722        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      128
 NPARAMETR:  4.0970E+00  3.0060E+01  3.4893E+01  9.8309E+00  7.4664E-01  1.1609E+01
 PARAMETER:  1.0243E-01  1.0020E-01  9.9696E-02  8.2946E-02  9.3330E-02  6.6849E-02
 GRADIENT:  -4.7862E+00  1.4528E+01 -9.1010E+00  7.7538E-01 -9.5476E+00  4.4079E-03
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      128
 NO. OF SIG. DIGITS IN FINAL EST.:  3.6
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):            0
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:   0.000000000000000E+000
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    153604.310586722     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       153604.310586722     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                             0
  
 #TERE:
 Elapsed estimation  time in seconds:    10.21
 Elapsed covariance  time in seconds:     6.29
 Elapsed postprocess time in seconds:     0.11
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   153604.311       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6     
 
         4.10E+00  3.01E+01  3.49E+01  9.83E+00  7.47E-01  1.16E+01
 
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
 
         1.45E-01  1.16E-01  1.41E-01  1.08E-01  5.10E-03  1.45E-01
 
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
+        2.10E-02
 
 TH 2
+        1.81E-04  1.34E-02
 
 TH 3
+        1.63E-05  1.23E-02  1.99E-02
 
 TH 4
+        8.29E-03  1.87E-04  1.66E-04  1.16E-02
 
 TH 5
+        1.28E-04  7.12E-06  1.70E-06  2.46E-04  2.60E-05
 
 TH 6
+        1.20E-02  2.12E-04 -1.12E-04  1.05E-02  4.02E-04  2.09E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6  
 
 TH 1
+        1.45E-01
 
 TH 2
+        1.08E-02  1.16E-01
 
 TH 3
+        7.98E-04  7.55E-01  1.41E-01
 
 TH 4
+        5.31E-01  1.50E-02  1.10E-02  1.08E-01
 
 TH 5
+        1.73E-01  1.21E-02  2.37E-03  4.49E-01  5.10E-03
 
 TH 6
+        5.73E-01  1.26E-02 -5.47E-03  6.77E-01  5.45E-01  1.45E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6  
 
 TH 1
+        7.97E+01
 
 TH 2
+       -5.07E-01  1.73E+02
 
 TH 3
+        2.50E-01 -1.07E+02  1.17E+02
 
 TH 4
+       -3.21E+01  1.86E+00 -2.87E+00  1.75E+02
 
 TH 5
+        5.26E+02 -1.36E+01  1.59E+00 -6.00E+02  5.91E+04
 
 TH 6
+       -3.98E+01 -2.71E+00  2.98E+00 -5.83E+01 -1.14E+03  1.22E+02
 
 Elapsed finaloutput time in seconds:     0.41
 #CPUT: Total CPU Time in Seconds,       17.597
Stop Time: 
Wed 01/10/2018 
07:42 PM
