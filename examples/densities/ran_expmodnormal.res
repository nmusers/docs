Wed 12/06/2017 
06:29 PM
$PROB TESTING RANDOM SAMPLERS
$ABBR FUNCTION EXPMODNORMAL(VQI,10)
$ABBR VECTOR VV(10)
$INPUT  AMT TVAL DV
$DATA  rsampler.csv

$PRED
QM=theta(1)
SIGV=THETA(2)
LAMBDA=THETA(3)
IF(ICALL==4) THEN
VV(1)=1.0
VV(2)=QM
VV(3)=SIGV
VV(4)=LAMBDA
" CALL EXPMODNORMAL_RNG(3,2,VV)
Y=VV(1)
DV=Y
ELSE
VQI(1)=DV
VQI(2)=QM
VQI(3)=SIGV
VQI(4)=LAMBDA
WW=EXPMODNORMAL(VQI)
Y=2.0*WW
ENDIF

$THETA 30.0 (0.0,5.0) (0.0,0.4)

$SIMULATION (567811 NORMAL) (2933012 UNIFORM) (445678 NORMAL) SUBPROBLEMS=1 
$EST METHOD=0 MAXEVAL=9999 PRINT=1 -2LL NOTHETABOUNDTEST 
$COVR
$TABLE TVAL DV NOAPPEND NOPRINT FILE=ran_expmodnormal.tab
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  1) NM-TRAN INFERS THAT THE DATA ARE SINGLE-SUBJECT.
  NONMEM RUN CANNOT BE PARALLELIZED.
             
 (WARNING  13) WITH USER-WRITTEN PRED OR $PRED, NM-TRAN CANNOT APPEND THE
 MDV DATA ITEM.
             
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
 NO. OF DATA ITEMS IN DATA SET:   4
 ID DATA ITEM IS DATA ITEM NO.:   4
 DEP VARIABLE IS DATA ITEM NO.:   3
0LABELS FOR DATA ITEMS:
 AMT TVAL DV .ID.
0FORMAT FOR DATA:
 (3E5.0,1F2.0)

 TOT. NO. OF OBS RECS:    10000
 TOT. NO. OF INDIVIDUALS:    10000
0LENGTH OF THETA:   3
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
 -0.1000E+07     0.3000E+02     0.1000E+07
  0.0000E+00     0.5000E+01     0.1000E+07
  0.0000E+00     0.4000E+00     0.1000E+07
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
 TVAL DV
1
 PROBLEM NO.:           1      SUBPROBLEM NO.:           1

 SIMULATION STEP PERFORMED
 SOURCE  1:
    SEED1:        567811   SEED2:             0
 SOURCE  2:
    SEED1:     574522919   SEED2:             0
 SOURCE  3:
    SEED1:     571320281   SEED2:             0
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
 RAW OUTPUT FILE (FILE): ran_expmodnormal.ext
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

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   76444.6267368035        NO. OF FUNC. EVALS.:   4
 CUMULATIVE NO. OF FUNC. EVALS.:        4
 NPARAMETR:  3.0000E+01  5.0000E+00  4.0000E-01
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:   7.1697E+03  1.9922E+02 -1.0290E+02
 
0ITERATION NO.:    1    OBJECTIVE VALUE:   76444.4952639449        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:       14
 NPARAMETR:  2.9970E+01  5.0000E+00  4.0000E-01
 PARAMETER:  9.9900E-02  9.9997E-02  1.0000E-01
 GRADIENT:   1.3077E+03  2.1119E+02 -5.8193E+01
 
0ITERATION NO.:    2    OBJECTIVE VALUE:   76444.3080347134        NO. OF FUNC. EVALS.:   6
 CUMULATIVE NO. OF FUNC. EVALS.:       20
 NPARAMETR:  2.9969E+01  4.9255E+00  4.0136E-01
 PARAMETER:  9.9895E-02  8.4998E-02  1.0338E-01
 GRADIENT:   1.3705E+03 -1.9165E+02  2.2298E+01
 
0ITERATION NO.:    3    OBJECTIVE VALUE:   76443.4243050940        NO. OF FUNC. EVALS.:   6
 CUMULATIVE NO. OF FUNC. EVALS.:       26
 NPARAMETR:  3.0126E+01  4.9910E+00  4.2838E-01
 PARAMETER:  1.0042E-01  9.8193E-02  1.6854E-01
 GRADIENT:   1.9888E+03 -1.7264E+02  4.4977E+01
 
0ITERATION NO.:    4    OBJECTIVE VALUE:   76443.1039438395        NO. OF FUNC. EVALS.:   5
 CUMULATIVE NO. OF FUNC. EVALS.:       31
 NPARAMETR:  3.0035E+01  4.9766E+00  4.1285E-01
 PARAMETER:  1.0012E-01  9.5318E-02  1.3161E-01
 GRADIENT:   5.0750E+02 -6.3755E+01  1.9515E+01
 
0ITERATION NO.:    5    OBJECTIVE VALUE:   76443.1039438395        NO. OF FUNC. EVALS.:  11
 CUMULATIVE NO. OF FUNC. EVALS.:       42
 NPARAMETR:  3.0035E+01  4.9766E+00  4.1285E-01
 PARAMETER:  1.0012E-01  9.5318E-02  1.3161E-01
 GRADIENT:  -2.4746E+03 -6.5080E+01  1.9199E+01
 
0ITERATION NO.:    6    OBJECTIVE VALUE:   76442.8106614148        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       50
 NPARAMETR:  3.0114E+01  5.0164E+00  4.2442E-01
 PARAMETER:  1.0038E-01  1.0327E-01  1.5926E-01
 GRADIENT:   1.5027E+02  5.2117E+00 -7.9366E-01
 
0ITERATION NO.:    7    OBJECTIVE VALUE:   76442.8080911592        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       58
 NPARAMETR:  3.0107E+01  5.0128E+00  4.2324E-01
 PARAMETER:  1.0036E-01  1.0255E-01  1.5649E-01
 GRADIENT:  -1.1440E+01 -2.7240E-01  1.5556E-01
 
0ITERATION NO.:    8    OBJECTIVE VALUE:   76442.8080911592        NO. OF FUNC. EVALS.:   0
 CUMULATIVE NO. OF FUNC. EVALS.:       58
 NPARAMETR:  3.0107E+01  5.0128E+00  4.2324E-01
 PARAMETER:  1.0036E-01  1.0255E-01  1.5649E-01
 GRADIENT:  -1.1440E+01 -2.7240E-01  1.5556E-01
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:       58
 NO. OF SIG. DIGITS IN FINAL EST.:  3.6
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):            0
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:   0.000000000000000E+000
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    76442.8080911592     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       76442.8080911592     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                             0
  
 #TERE:
 Elapsed estimation  time in seconds:     4.38
 Elapsed covariance  time in seconds:     1.72
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************    76442.808       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         3.01E+01  5.01E+00  4.23E-01
 
1
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         1.60E-01  7.34E-02  2.74E-02
 
1
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3  
 
 TH 1
+        2.56E-02
 
 TH 2
+        9.17E-03  5.38E-03
 
 TH 3
+        4.11E-03  1.63E-03  7.49E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3  
 
 TH 1
+        1.60E-01
 
 TH 2
+        7.81E-01  7.34E-02
 
 TH 3
+        9.38E-01  8.10E-01  2.74E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                                   FIRST ORDER                                  ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3  
 
 TH 1
+        3.30E+02
 
 TH 2
+       -4.36E+01  5.45E+02
 
 TH 3
+       -1.72E+03 -9.44E+02  1.28E+04
 
 Elapsed finaloutput time in seconds:     0.39
 #CPUT: Total CPU Time in Seconds,        6.895
Stop Time: 
Wed 12/06/2017 
06:29 PM
