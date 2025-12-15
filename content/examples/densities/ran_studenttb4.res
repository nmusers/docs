Sun 01/07/2018 
11:00 PM
$PROB TESTING RANDOM SAMPLERS
$ABBR FUNCTION STUDENTTB(VQI,10)
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
; DESCRIPTION : Given Normal Random generator K, and parameters X(3)..., 
;               return two random univariate t-samples X(1),X(2) followed by superimposed correlation C12=X(7)
" CALL STUDENTTB4_RNG(3,VV)
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

$THETA (4.0 FIXED) 30.0 35.0 (0.0,10.0) (0.8) (0.0,12.0)

$SIMULATION (567811 NORMAL) (2933012 UNIFORM) (445678 NORMAL) SUBPROBLEMS=1
$EST METHOD=0 MAXEVAL=9999 PRINT=10 -2LL NOHABORT
$COVR
$TABLE TVAL DV DV2 IPRED IPRED2 NOAPPEND NOPRINT FILE=ran_studenttb4.tab
  
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
 LOWER BOUND    INITIAL EST    UPPER BOUND
  0.4000E+01     0.4000E+01     0.4000E+01
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
 Elapsed simulation  time in seconds:     0.08
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
 RAW OUTPUT FILE (FILE): ran_studenttb4.ext
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

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   152321.601141126        NO. OF FUNC. EVALS.:   6
 CUMULATIVE NO. OF FUNC. EVALS.:        6
 NPARAMETR:  3.0000E+01  3.5000E+01  1.0000E+01  8.0000E-01  1.2000E+01
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:   1.6402E+04 -1.6816E+04  1.6650E+02 -4.8100E+02 -7.0758E+02
 
0ITERATION NO.:   10    OBJECTIVE VALUE:   152308.797289656        NO. OF FUNC. EVALS.: 104
 CUMULATIVE NO. OF FUNC. EVALS.:      110
 NPARAMETR:  3.0019E+01  3.5206E+01  1.0153E+01  8.0601E-01  1.2298E+01
 PARAMETER:  1.0006E-01  1.0059E-01  1.1521E-01  1.0075E-01  1.2456E-01
 GRADIENT:  -1.6372E+00  5.6117E-01 -4.6095E-02 -4.6980E-01 -5.5724E-02
 
0ITERATION NO.:   11    OBJECTIVE VALUE:   152308.797289656        NO. OF FUNC. EVALS.:   0
 CUMULATIVE NO. OF FUNC. EVALS.:      110
 NPARAMETR:  3.0019E+01  3.5206E+01  1.0153E+01  8.0601E-01  1.2298E+01
 PARAMETER:  1.0006E-01  1.0059E-01  1.1521E-01  1.0075E-01  1.2456E-01
 GRADIENT:  -1.6372E+00  5.6117E-01 -4.6095E-02 -4.6980E-01 -5.5724E-02
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      110
 NO. OF SIG. DIGITS IN FINAL EST.:  4.4
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):            0
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:   0.000000000000000E+000
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    152308.797289656     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       152308.797289656     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                             0
  
 #TERE:
 Elapsed estimation  time in seconds:     8.22
 Elapsed covariance  time in seconds:     4.63
 Elapsed postprocess time in seconds:     0.02
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   152308.797       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6     
 
         4.00E+00  3.00E+01  3.52E+01  1.02E+01  8.06E-01  1.23E+01
 
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
 
        .........  1.19E-01  1.45E-01  9.60E-02  4.14E-03  1.02E-01
 
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
+       .........
 
 TH 2
+       .........  1.41E-02
 
 TH 3
+       .........  1.39E-02  2.10E-02
 
 TH 4
+       .........  1.72E-04  1.68E-04  9.22E-03
 
 TH 5
+       .........  3.27E-07  6.21E-07  2.43E-04  1.71E-05
 
 TH 6
+       .........  1.85E-04  2.89E-04  7.12E-03  1.97E-04  1.04E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6  
 
 TH 1
+       .........
 
 TH 2
+       .........  1.19E-01
 
 TH 3
+       .........  8.05E-01  1.45E-01
 
 TH 4
+       .........  1.51E-02  1.21E-02  9.60E-02
 
 TH 5
+       .........  6.64E-04  1.03E-03  6.10E-01  4.14E-03
 
 TH 6
+       .........  1.53E-02  1.95E-02  7.28E-01  4.67E-01  1.02E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6  
 
 TH 1
+       .........
 
 TH 2
+       .........  2.01E+02
 
 TH 3
+       ......... -1.33E+02  1.35E+02
 
 TH 4
+       ......... -3.77E+00  2.36E+00  2.88E+02
 
 TH 5
+       .........  2.99E+01 -1.47E+00 -2.31E+03  9.32E+04
 
 TH 6
+       .........  2.13E+00 -2.99E+00 -1.54E+02 -1.84E+02  2.05E+02
 
 Elapsed finaloutput time in seconds:     0.42
 #CPUT: Total CPU Time in Seconds,       14.040
Stop Time: 
Sun 01/07/2018 
11:01 PM
