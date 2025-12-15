Thu 12/12/2019 
05:30 PM
$PROB RUN# Example 1 (from samp5l)
$INPUT ID TIME  DV=CONC AMT=DOSE RATE EVID MDV CMT SID CID
$DATA superid2.csv

$SUBROUTINES ADVAN1 TRANS2

$PK
MU_5=THETA(1)
MU_6=THETA(2)
CL=DEXP(MU_5+ETA(5)+ETA(1)+ETA(3))
V=DEXP(MU_6+ETA(6)+ETA(2)+ETA(4))
S1=V

$ERROR
Y = F + F*EPS(1)

; Initial values of THETA
$THETA 5.0 5
$OMEGA BLOCK(2)
0.03
0.00001 0.03

;$OMEGA 0.03 0.03
$OMEGA BLOCK(2)
0.1
0.00001 0.1

$OMEGA BLOCK(2)
0.3
0.00001 0.3

$SIGMA 
0.1

$LEVEL
SID=(3[1],4[2])
CID=(5[3],6[4])

$EST METHOD=ITS INTERACTION PRINT=1 NSIG=2 NITER=500 SIGL=6 FNLETA=0 NOABORT MCETA=2 CTYPE=3
     LEVCENTER=0
$COV MATRIX=R UNCONDITIONAL
$TABLE  ID TIME CONC DOSE RATE EVID MDV CMT SID CID CL V ETA1 ETA2 ETA3 ETA4 ETA5 ETA6 
NOAPPEND ONEHEADER FILE=superid2_1.tab  NOPRINT
$TABLE  ID SID CID CL V ETA1 ETA2 ETA3 ETA4 ETA5 ETA6 NOAPPEND ONEHEADER FILE=superid2_1.dat FIRSTONLY NOPRINT FORMAT=,1PE15.8
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.

 (MU_WARNING 12) MU_005: SHOULD NOT BE ASSOCIATED WITH ETA(001)

 (MU_WARNING 12) MU_005: SHOULD NOT BE ASSOCIATED WITH ETA(003)

 (MU_WARNING 11) MU_005: SHOULD NOT BE ASSOCIATED WITH MORE THAN ONE ETA.

 (MU_WARNING 22) MU_005: HAS ALREADY BEEN MU_ ASSOCIATED, CANNOT BE USED AGAIN.

 (MU_WARNING 12) MU_006: SHOULD NOT BE ASSOCIATED WITH ETA(002)

 (MU_WARNING 12) MU_006: SHOULD NOT BE ASSOCIATED WITH ETA(004)

 (MU_WARNING 11) MU_006: SHOULD NOT BE ASSOCIATED WITH MORE THAN ONE ETA.

 (MU_WARNING 22) MU_006: HAS ALREADY BEEN MU_ ASSOCIATED, CANNOT BE USED AGAIN.
  
License Registered to: IDS NONMEM 7 TEAM
Expiration Date:     2 JUN 2030
Current Date:       12 DEC 2019
Days until program expires :3825
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.0 Beta version 3
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 RUN# Example 1 (from samp5l)
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:    20000
 NO. OF DATA ITEMS IN DATA SET:  10
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   3
 MDV DATA ITEM IS DATA ITEM NO.:  7
0INDICES PASSED TO SUBROUTINE PRED:
   6   2   4   5   0   0   8   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID TIME CONC DOSE RATE EVID MDV CMT SID CID
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 CL V
0FORMAT FOR DATA:
 (7E10.0/3E10.0)

 TOT. NO. OF OBS RECS:    17500
 TOT. NO. OF INDIVIDUALS:     2500
0LENGTH OF THETA:   2
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS BLOCK FORM:
  1
  1  1
  0  0  2
  0  0  2  2
  0  0  0  0  3
  0  0  0  0  3  3
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.5000E+01  0.5000E+01
0INITIAL ESTIMATE OF OMEGA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.3000E-01
                  0.1000E-04   0.3000E-01
        2                                                                                   NO
                  0.1000E+00
                  0.1000E-04   0.1000E+00
        3                                                                                   NO
                  0.3000E+00
                  0.1000E-04   0.3000E+00
0INITIAL ESTIMATE OF SIGMA:
 0.1000E+00
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
 NO. OF TABLES:           2
 SEED NUMBER (SEED):    11456
 RANMETHOD:             3U
 MC SAMPLES (ESAMPLE):    300
 WRES SQUARE ROOT TYPE (WRESCHOL): EIGENVALUE
0-- TABLE   1 --
0RECORDS ONLY:    ALL
04 COLUMNS APPENDED:    NO
 PRINTED:                NO
 HEADERS:               ONE
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID TIME CONC DOSE RATE EVID MDV CMT SID CID CL V ETA1 ETA2 ETA3 ETA4 ETA5 ETA6
0-- TABLE   2 --
0RECORDS ONLY:    FIRSTONLY
04 COLUMNS APPENDED:    NO
 PRINTED:                NO
 HEADERS:               ONE
 FILE TO BE FORWARDED:   NO
 FORMAT:                ,1PE15.8
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID SID CID CL V ETA1 ETA2 ETA3 ETA4 ETA5 ETA6
1DOUBLE PRECISION PREDPP VERSION 7.5.0 Beta version 3

 ONE COMPARTMENT MODEL (ADVAN1)
0MAXIMUM NO. OF BASIC PK PARAMETERS:   2
0BASIC PK PARAMETERS (AFTER TRANSLATION):
   ELIMINATION RATE (K) IS BASIC PK PARAMETER NO.:  1

 TRANSLATOR WILL CONVERT PARAMETERS
 CLEARANCE (CL) AND VOLUME (V) TO K (TRANS2)
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         CENTRAL      ON         NO         YES        YES        YES
    2         OUTPUT       OFF        YES        NO         NO         NO
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            3           *           *           *           *
    2            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0ERROR IN LOG Y IS MODELED
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      6
   TIME DATA ITEM IS DATA ITEM NO.:          2
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   4
   DOSE RATE DATA ITEM IS DATA ITEM NO.:     5
   COMPT. NO. DATA ITEM IS DATA ITEM NO.:    8

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0DURING SIMULATION, ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 OTHERWISE, ERROR SUBROUTINE CALLED ONCE IN THIS PROBLEM.
1
 
 
 #TBLN:      1
 #METH: Iterative Two Stage
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            528
 NO. OF SIG. FIGURES REQUIRED:            2
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    2
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      6
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     6
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          0
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): superid2_1.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 NESTED LEVEL MAPS:
  SID=(3[1],4[2])
  CID=(5[3],6[4])
 Level Weighting Type (LEVWT):0
 Center Level Etas about 0 (LEVCENTER):0
 EM OR BAYESIAN METHOD USED:                ITERATIVE TWO STAGE (ITS)
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          1
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 ITERATIONS (NITER):                        500
 ANNEAL SETTING (CONSTRAIN):                 1

 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2
 THETAS THAT ARE SIGMA-LIKE:
 
 
 MONITORING OF SEARCH:

 iteration            0 OBJ=   7033.34654356703
 iteration            1 OBJ=  -30629.9434780429
 iteration            2 OBJ=  -36593.7587093094
 iteration            3 OBJ=  -41056.5557201640
 iteration            4 OBJ=  -42332.2039587090
 iteration            5 OBJ=  -42417.8890204107
 iteration            6 OBJ=  -42419.9813312006
 iteration            7 OBJ=  -42419.9695457565
 iteration            8 OBJ=  -42419.9698052368
 iteration            9 OBJ=  -42419.9665409695
 iteration           10 OBJ=  -42419.9641642384
 iteration           11 OBJ=  -42419.9628653542
 Convergence achieved
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -4.4079E-04 -3.7256E-04 -1.1657E-18 -2.5563E-18 -2.8496E-05 -1.4752E-05
 SE:             1.6252E-03  1.6973E-03  9.8784E-03  1.0698E-02  6.1634E-02  5.5496E-02
 N:                    2500        2500         250         250          25          25
 
 P VAL.:         7.8622E-01  8.2625E-01  1.0000E+00  1.0000E+00  9.9963E-01  9.9979E-01
 
 ETASHRINKSD(%)  1.1940E+01  1.1859E+01  1.0503E-04  9.3372E-05  8.9231E-05  7.4082E-05
 ETASHRINKVR(%)  2.2455E+01  2.2312E+01  2.1007E-04  1.8674E-04  1.7846E-04  1.4816E-04
 EBVSHRINKSD(%)  1.1933E+01  1.1854E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  2.2442E+01  2.2303E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  7.7293E+01  7.7432E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  1.1413E+01
 EPSSHRINKVR(%)  2.1523E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):        17500
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    32162.8486621635     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -42419.9628653542     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -10257.1142031907     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          5548
  
 #TERE:
 Elapsed estimation  time in seconds:    38.17
 Elapsed covariance  time in seconds:     0.52
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -42419.963       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         2.00E+00  3.63E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        8.52E-03
 
 ETA2
+       -3.26E-05  9.27E-03
 
 ETA3
+        0.00E+00  0.00E+00  2.44E-02
 
 ETA4
+        0.00E+00  0.00E+00  1.56E-03  2.86E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  9.89E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.69E-02  8.02E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        9.99E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.23E-02
 
 ETA2
+       -3.67E-03  9.63E-02
 
 ETA3
+        0.00E+00  0.00E+00  1.56E-01
 
 ETA4
+        0.00E+00  0.00E+00  5.91E-02  1.69E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.15E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.90E-01  2.83E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                          STANDARD ERROR OF ESTIMATE (S)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         6.88E-02  6.41E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        3.05E-04
 
 ETA2
+        2.28E-04  3.42E-04
 
 ETA3
+        0.00E+00  0.00E+00  2.08E-03
 
 ETA4
+        0.00E+00  0.00E+00  1.66E-03  2.45E-03
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.31E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.54E-02  2.85E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.28E-04
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.65E-03
 
 ETA2
+        2.57E-02  1.78E-03
 
 ETA3
+       ......... .........  6.66E-03
 
 ETA4
+       ......... .........  6.30E-02  7.23E-03
 
 ETA5
+       ......... ......... ......... .........  5.26E-02
 
 ETA6
+       ......... ......... ......... .........  2.58E-01  5.04E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        6.42E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (S)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        4.73E-03
 
 TH 2
+       -6.60E-04  4.10E-03
 
 OM11
+       -2.47E-07  6.48E-07  9.30E-08
 
 OM12
+        4.01E-08 -1.68E-07  7.00E-09  5.19E-08
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        1.12E-06  2.42E-07 -2.27E-09 -1.56E-10  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.17E-07
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM33
+        4.39E-06  2.39E-05  1.77E-08  3.88E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -7.37E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  4.33E-06
 
 OM34
+        6.34E-06  5.69E-06 -5.44E-09 -1.61E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.11E-08  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -1.45E-07  2.76E-06
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -1.81E-06  3.97E-06  1.43E-08  4.43E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -9.17E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -6.15E-08  8.67E-08  0.00E+00  0.00E+00  5.98E-06
 
 OM45
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 OM46
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... .........
 
 OM55
+        3.00E-05  6.10E-04  2.68E-07  5.37E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.69E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  8.70E-06  3.22E-06  0.00E+00  0.00E+00  4.96E-06  0.00E+00  0.00E+00  1.10E-03
 
 OM56
+        4.62E-04 -3.18E-04 -1.37E-07  1.07E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.05E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -5.01E-06  1.81E-06  0.00E+00  0.00E+00 -1.48E-06  0.00E+00  0.00E+00 -5.32E-04  6.44E-04
 
 OM66
+       -8.46E-05  6.26E-04  1.50E-07 -8.98E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.35E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  3.01E-06 -3.82E-06  0.00E+00  0.00E+00  1.32E-06  0.00E+00  0.00E+00  2.53E-04 -2.25E-04  8.15E-04
 
 SG11
+        6.61E-08  6.24E-08 -1.88E-09 -3.86E-10  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.33E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.06E-09 -2.96E-10  0.00E+00  0.00E+00 -2.33E-09  0.00E+00  0.00E+00 -1.14E-07  2.94E-08 -1.06E-08  1.65E-08
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (S)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        6.88E-02
 
 TH 2
+       -1.50E-01  6.41E-02
 
 OM11
+       -1.18E-02  3.32E-02  3.05E-04
 
 OM12
+        2.56E-03 -1.15E-02  1.01E-01  2.28E-04
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        4.74E-02  1.11E-02 -2.17E-02 -2.00E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.42E-04
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM33
+        3.07E-02  1.79E-01  2.79E-02  8.19E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.04E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.08E-03
 
 OM34
+        5.55E-02  5.35E-02 -1.07E-02 -4.26E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.95E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -4.21E-02  1.66E-03
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -1.08E-02  2.53E-02  1.92E-02  7.94E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.10E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -1.21E-02  2.13E-02  0.00E+00  0.00E+00  2.45E-03
 
 OM45
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 OM46
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... .........
 
 OM55
+        1.31E-02  2.87E-01  2.66E-02  7.11E-04  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.49E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.26E-01  5.85E-02  0.00E+00  0.00E+00  6.12E-02  0.00E+00  0.00E+00  3.31E-02
 
 OM56
+        2.65E-01 -1.96E-01 -1.76E-02  1.86E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.21E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -9.48E-02  4.29E-02  0.00E+00  0.00E+00 -2.38E-02  0.00E+00  0.00E+00 -6.33E-01  2.54E-02
 
 OM66
+       -4.31E-02  3.43E-01  1.72E-02 -1.38E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.43E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  5.07E-02 -8.06E-02  0.00E+00  0.00E+00  1.89E-02  0.00E+00  0.00E+00  2.68E-01 -3.11E-01  2.85E-02
 
 SG11
+        7.49E-03  7.59E-03 -4.80E-02 -1.32E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -5.30E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  7.70E-03 -1.39E-03  0.00E+00  0.00E+00 -7.41E-03  0.00E+00  0.00E+00 -2.69E-02  9.03E-03 -2.90E-03  1.28E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (S)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        2.52E+02
 
 TH 2
+        5.30E+01  3.10E+02
 
 OM11
+        3.42E+02 -1.30E+03  1.09E+07
 
 OM12
+        4.18E+02  8.10E+02 -1.46E+06  1.95E+07
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.64E+03 -1.98E+03  2.25E+05 -9.97E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  8.61E+06
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM33
+       -5.46E+02 -1.44E+03 -3.36E+04 -1.36E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.09E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.43E+05
 
 OM34
+       -3.62E+02 -8.68E+02  1.42E+04  1.20E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.33E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.80E+04  3.75E+05
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+        1.12E+02 -3.94E+01 -2.25E+04 -1.19E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.14E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  3.91E+03 -4.06E+03  0.00E+00  0.00E+00  1.68E+05
 
 OM45
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 OM46
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... .........
 
 OM55
+       -1.75E+02 -1.59E+02 -1.40E+03 -3.99E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.37E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -8.11E+02 -2.38E+03  0.00E+00  0.00E+00 -9.82E+02  0.00E+00  0.00E+00  1.75E+03
 
 OM56
+       -3.19E+02 -9.84E+01 -7.12E+01 -6.57E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.16E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.13E+03 -2.21E+03  0.00E+00  0.00E+00 -5.23E+02  0.00E+00  0.00E+00  1.48E+03  3.11E+03
 
 OM66
+       -4.92E+01 -2.10E+02 -3.81E+02  1.90E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.66E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  8.11E+02  2.46E+03  0.00E+00  0.00E+00 -9.55E+01  0.00E+00  0.00E+00 -3.71E+01  4.32E+02  1.53E+03
 
 SG11
+       -2.14E+03 -2.71E+03  1.24E+06  2.72E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.28E+06  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -3.01E+04 -1.19E+03  0.00E+00  0.00E+00  1.57E+04  0.00E+00  0.00E+00  1.09E+04  6.78E+03  1.53E+03  6.11E+07
 
 SKIPPING EXECUTION OF SLOW FNLMOD/FNLETA BY USER REQUEST
 Elapsed postprocess time in seconds:     0.04
 Elapsed finaloutput time in seconds:     1.47
 #CPUT: Total CPU Time in Seconds,       38.595
Stop Time: 
Thu 12/12/2019 
05:31 PM
