Wed 12/06/2017 
06:29 PM
$PROB TESTING RANDOM SAMPLERS
$ABBR FUNCTION dirichlet(VQI,10)
$ABBR VECTOR VV(10)
$INPUT  AMT TVAL DV DV2 DV3
$DATA  rsampler.csv

$PRED
NN=THETA(1)
A1=THETA(2)
A2=THETA(3)
A3=THETA(4)
A4=THETA(5)

F=NN
IF(ICALL==4) THEN
VV(1)=NN
VV(2)=1.0
VV(3)=1.0
VV(4)=1.0
VV(5)=A1
VV(6)=A2
VV(7)=A3
VV(8)=A4
" CALL dirichlet_RNG(2,VV)
Y=VV(2)
DV=Y
DV2=VV(3)
DV3=VV(4)
ELSE
VQI(1)=NN
VQI(2)=DV
VQI(3)=DV2
VQI(4)=DV3
VQI(5)=A1
VQI(6)=A2
VQI(7)=A3
VQI(8)=A4
WW=dirichlet(VQI)
Y=2.0*WW
;Y=(DV-QM)*(DV-QM)/SIGV/SIGV + 2.0*DLOG(SIGV)
ENDIF

$THETA (4.0 FIXED) (2.0) (3.0) (1.5) (0.5)
;$OMEGA (0.0 fixed)

$SIMULATION (567811 NORMAL) (2933012 UNIFORM) (445678 NORMAL) SUBPROBLEMS=1
$EST METHOD=0 MAXEVAL=9999 PRINT=10 -2LL
$COVR
$TABLE TVAL DV DV2 DV3 NOAPPEND NOPRINT FILE=ran_dirichlet.tab
  
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
Current Date:        6 DEC 2017
Days until program expires :4561
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
 NO. OF DATA ITEMS IN DATA SET:   6
 ID DATA ITEM IS DATA ITEM NO.:   6
 DEP VARIABLE IS DATA ITEM NO.:   3
0LABELS FOR DATA ITEMS:
 AMT TVAL DV DV2 DV3 .ID.
0FORMAT FOR DATA:
 (5E5.0,1F2.0)

 TOT. NO. OF OBS RECS:    10000
 TOT. NO. OF INDIVIDUALS:    10000
0LENGTH OF THETA:   5
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
  0.4000E+01     0.4000E+01     0.4000E+01
 -0.1000E+07     0.2000E+01     0.1000E+07
 -0.1000E+07     0.3000E+01     0.1000E+07
 -0.1000E+07     0.1500E+01     0.1000E+07
 -0.1000E+07     0.5000E+00     0.1000E+07
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
 TVAL DV DV2 DV3
1
 PROBLEM NO.:           1      SUBPROBLEM NO.:           1

 SIMULATION STEP PERFORMED
 SOURCE  1:
    SEED1:        567811   SEED2:             0
 SOURCE  2:
    SEED1:     997680263   SEED2:             0
 SOURCE  3:
    SEED1:        445678   SEED2:             0
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
 RAW OUTPUT FILE (FILE): ran_dirichlet.ext
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

 
0ITERATION NO.:    0    OBJECTIVE VALUE:  -61432.3694581336        NO. OF FUNC. EVALS.:   5
 CUMULATIVE NO. OF FUNC. EVALS.:        5
 NPARAMETR:  2.0000E+00  3.0000E+00  1.5000E+00  5.0000E-01
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:   1.3370E+03  1.3094E+03  6.8220E+02 -9.9383E+02
 
0ITERATION NO.:    8    OBJECTIVE VALUE:  -61433.4743120511        NO. OF FUNC. EVALS.:  84
 CUMULATIVE NO. OF FUNC. EVALS.:       89
 NPARAMETR:  1.9832E+00  2.9778E+00  1.4897E+00  5.0098E-01
 PARAMETER:  9.9159E-02  9.9261E-02  9.9312E-02  1.0020E-01
 GRADIENT:  -2.4034E+02  2.8351E+02 -1.6673E+02  1.1294E+02
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 HOWEVER, PROBLEMS OCCURRED WITH THE MINIMIZATION.
 REGARD THE RESULTS OF THE ESTIMATION STEP CAREFULLY, AND ACCEPT THEM ONLY
 AFTER CHECKING THAT THE COVARIANCE STEP PRODUCES REASONABLE OUTPUT.
 NO. OF FUNCTION EVALUATIONS USED:       89
 NO. OF SIG. DIGITS IN FINAL EST.:  3.3
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):            0
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:   0.000000000000000E+000
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -61433.4743120511     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -61433.4743120511     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                             0
  
 #TERE:
 Elapsed estimation  time in seconds:     6.54
 Elapsed covariance  time in seconds:     3.06
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -61433.474       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
         4.00E+00  1.98E+00  2.98E+00  1.49E+00  5.01E-01
 
1
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
        .........  1.90E-02  2.84E-02  1.45E-02  4.91E-03
 
1
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5  
 
 TH 1
+       .........
 
 TH 2
+       .........  3.61E-04
 
 TH 3
+       .........  3.46E-04  8.08E-04
 
 TH 4
+       .........  1.45E-04  2.39E-04  2.11E-04
 
 TH 5
+       .........  2.86E-05  4.56E-05  1.96E-05  2.41E-05
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5  
 
 TH 1
+       .........
 
 TH 2
+       .........  1.90E-02
 
 TH 3
+       .........  6.41E-01  2.84E-02
 
 TH 4
+       .........  5.26E-01  5.80E-01  1.45E-02
 
 TH 5
+       .........  3.06E-01  3.26E-01  2.75E-01  4.91E-03
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5  
 
 TH 1
+       .........
 
 TH 2
+       .........  5.07E+03
 
 TH 3
+       ......... -1.64E+03  2.48E+03
 
 TH 4
+       ......... -1.47E+03 -1.55E+03  7.65E+03
 
 TH 5
+       ......... -1.72E+03 -1.48E+03 -1.56E+03  4.75E+04
 
 Elapsed finaloutput time in seconds:     0.47
 #CPUT: Total CPU Time in Seconds,       10.920
Stop Time: 
Wed 12/06/2017 
06:29 PM
