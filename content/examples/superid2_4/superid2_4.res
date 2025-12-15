Thu 12/12/2019 
05:46 PM
$PROB RUN# Example 1 (from samp5l)
$INPUT ID TIME  DV=CONC AMT=DOSE RATE EVID MDV CMT SID CID
$DATA superid2.csv

$SUBROUTINES ADVAN1 TRANS2

$PK
MU_5=THETA(1)
MU_6=THETA(2)
CL=DEXP(MU_5+ETA(5)+ETA(3)+ETA(1))
V=DEXP(MU_6+ETA(6)+ETA(4)+ETA(2))
S1=V

$ERROR
Y = F + F*EPS(1)

; Initial values of THETA
$THETA 5.0 5.0
;$OMEGA 0.02 0.02 0.0 FIXED 0.0 FIXED 0.0 FIXED 0.0 FIXED
$OMEGA BLOCK(2)
0.1
0.00001 0.1

$OMEGA BLOCK(2)
0.3
0.00001 0.3

$OMEGA BLOCK(2)
1.0
0.00001 1.0

$SIGMA 
0.1

$LEVEL
SID=(3[1],4[2])
CID=(5[3],6[4])

$EST METHOD=ITS INTERACTION PRINT=1 NSIG=3 NITER=12 SIGL=6 FNLETA=0 MCETA=3 NOABORT
     LEVCENTER=0
$EST METHOD=1 INTERACTION PRINT=1 MAXEVAL=9999 NSIG=2 FNLETA=0 NOHABORT  SIGL=10 MCETA=10 SLOW
$COV MATRIX=R UNCONDITIONAL
$TABLE  ID TIME CONC DOSE RATE EVID MDV CMT SID CID ETA1 ETA2 ETA3 ETA4 ETA5 ETA6
NOAPPEND ONEHEADER FILE=superid2_4.tab  NOPRINT
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  126) ONLY THE LAST FNLETA LISTED IN THE SERIES OF $EST RECORDS FOR
 THIS PROBLEM WILL BE USED
             
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
                  0.1000E+00
                  0.1000E-04   0.1000E+00
        2                                                                                   NO
                  0.3000E+00
                  0.1000E-04   0.3000E+00
        3                                                                                   NO
                  0.1000E+01
                  0.1000E-04   0.1000E+01
0INITIAL ESTIMATE OF SIGMA:
 0.1000E+00
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
 ID TIME CONC DOSE RATE EVID MDV CMT SID CID ETA1 ETA2 ETA3 ETA4 ETA5 ETA6
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
 NO. OF SIG. FIGURES REQUIRED:            3
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    3
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
 RAW OUTPUT FILE (FILE): superid2_4.ext
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
 CONVERGENCE TYPE (CTYPE):                  0
 ITERATIONS (NITER):                        12
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

 iteration            0 OBJ=  -8536.02565069154
 iteration            1 OBJ=  -29603.7095049685
 iteration            2 OBJ=  -35554.8434722919
 iteration            3 OBJ=  -40334.8073987270
 iteration            4 OBJ=  -42401.2530134274
 iteration            5 OBJ=  -42419.5176490056
 iteration            6 OBJ=  -42419.9105627313
 iteration            7 OBJ=  -42419.9630647633
 iteration            8 OBJ=  -42419.9673292333
 iteration            9 OBJ=  -42419.9654050015
 iteration           10 OBJ=  -42419.9636269902
 iteration           11 OBJ=  -42419.9626189064
 iteration           12 OBJ=  -42419.9620686161
 
 #TERM:
 OPTIMIZATION WAS NOT TESTED FOR CONVERGENCE


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -4.4097E-04 -3.7267E-04  2.4758E-18 -1.3511E-17 -2.8633E-05 -1.4818E-05
 SE:             1.6251E-03  1.6972E-03  9.8784E-03  1.0698E-02  6.1634E-02  5.5496E-02
 N:                    2500        2500         250         250          25          25
 
 P VAL.:         7.8613E-01  8.2620E-01  1.0000E+00  1.0000E+00  9.9963E-01  9.9979E-01
 
 ETASHRINKSD(%)  1.1937E+01  1.1857E+01  4.0864E-05  3.7107E-05  3.6573E-05  2.9959E-05
 ETASHRINKVR(%)  2.2450E+01  2.2308E+01  8.1728E-05  7.4214E-05  7.3146E-05  5.9918E-05
 EBVSHRINKSD(%)  1.1934E+01  1.1855E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  2.2444E+01  2.2304E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  7.7290E+01  7.7429E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  1.1413E+01
 EPSSHRINKVR(%)  2.1523E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):        17500
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    32162.8486621635     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -42419.9620686161     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -10257.1134064525     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          5548
  
 #TERE:
 Elapsed estimation  time in seconds:    86.77
 Elapsed covariance  time in seconds:     1.71
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -42419.962       **************************************************
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
+        8.51E-03
 
 ETA2
+       -3.36E-05  9.27E-03
 
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
+       -3.79E-03  9.63E-02
 
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
+        4.00E-08 -1.68E-07  6.98E-09  5.19E-08
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        1.12E-06  2.42E-07 -2.27E-09 -1.74E-10  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.17E-07
 
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
          0.00E+00 -6.15E-08  8.66E-08  0.00E+00  0.00E+00  5.98E-06
 
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
+        3.00E-05  6.10E-04  2.68E-07  5.36E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.69E-07  0.00E+00  0.00E+00  0.00E+00
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
+        2.55E-03 -1.15E-02  1.01E-01  2.28E-04
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        4.74E-02  1.10E-02 -2.17E-02 -2.24E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.42E-04
 
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
+        7.48E-03  7.59E-03 -4.80E-02 -1.32E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -5.30E-02  0.00E+00  0.00E+00  0.00E+00
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
+        3.43E+02 -1.30E+03  1.09E+07
 
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
+       -2.64E+03 -1.98E+03  2.25E+05 -6.87E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  8.62E+06
 
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
+       -3.62E+02 -8.68E+02  1.43E+04  1.20E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.33E+04  0.00E+00  0.00E+00  0.00E+00
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
+       -1.75E+02 -1.59E+02 -1.41E+03 -3.99E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.37E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -8.11E+02 -2.38E+03  0.00E+00  0.00E+00 -9.82E+02  0.00E+00  0.00E+00  1.75E+03
 
 OM56
+       -3.19E+02 -9.84E+01 -7.15E+01 -6.57E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.16E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.13E+03 -2.21E+03  0.00E+00  0.00E+00 -5.23E+02  0.00E+00  0.00E+00  1.48E+03  3.11E+03
 
 OM66
+       -4.92E+01 -2.10E+02 -3.81E+02  1.90E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.66E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  8.11E+02  2.46E+03  0.00E+00  0.00E+00 -9.55E+01  0.00E+00  0.00E+00 -3.71E+01  4.32E+02  1.53E+03
 
 SG11
+       -2.14E+03 -2.71E+03  1.24E+06  2.74E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.28E+06  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -3.01E+04 -1.18E+03  0.00E+00  0.00E+00  1.57E+04  0.00E+00  0.00E+00  1.09E+04  6.78E+03  1.53E+03  6.11E+07
 
1
 
 
 #TBLN:      2
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
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    10
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      10
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     10
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          0
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): superid2_4.ext
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
 ADDITIONAL CONVERGENCE TEST (CTYPE=4)?:    NO
 EM OR BAYESIAN METHOD USED:                 NONE

 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 MONITORING OF SEARCH:

 
0ITERATION NO.:    0    OBJECTIVE VALUE:  -42422.3987711347        NO. OF FUNC. EVALS.:  13
 CUMULATIVE NO. OF FUNC. EVALS.:       13
 NPARAMETR:  2.0030E+00  3.6309E+00  8.5142E-03 -3.3647E-05  9.2692E-03  2.4396E-02  1.5625E-03  2.8612E-02  9.8927E-02 -1.6906E-02
             8.0203E-02  9.9912E-03
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01 -1.0000E-01
             1.0000E-01  1.0000E-01
 GRADIENT:   1.1377E+03 -1.6653E+03 -6.3121E+00 -7.1195E-02 -7.8404E+00 -1.4427E+01 -5.1460E+00 -1.6167E+01 -5.3010E+01 -1.9713E+01
            -4.3190E+01 -2.5375E+01
 
0ITERATION NO.:    1    OBJECTIVE VALUE:  -42422.5013232229        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:       32
 NPARAMETR:  2.0018E+00  3.6340E+00  8.5142E-03 -3.3647E-05  9.2692E-03  2.4396E-02  1.5625E-03  2.8612E-02  9.8927E-02 -1.6905E-02
             8.0203E-02  9.9912E-03
 PARAMETER:  9.9943E-02  1.0008E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01 -9.9999E-02
             1.0000E-01  1.0000E-01
 GRADIENT:   8.4481E+02  5.9088E+02 -6.8970E+00 -1.7857E-01 -8.4500E+00 -1.4877E+01 -5.2570E+00 -1.6473E+01 -5.3619E+01 -2.0264E+01
            -4.3771E+01 -2.6850E+01
 
0ITERATION NO.:    2    OBJECTIVE VALUE:  -42422.5507094131        NO. OF FUNC. EVALS.:  20
 CUMULATIVE NO. OF FUNC. EVALS.:       52
 NPARAMETR:  1.9997E+00  3.6335E+00  8.5142E-03 -3.3647E-05  9.2693E-03  2.4396E-02  1.5625E-03  2.8612E-02  9.8929E-02 -1.6905E-02
             8.0204E-02  9.9913E-03
 PARAMETER:  9.9836E-02  1.0007E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0001E-01 -9.9997E-02
             1.0001E-01  1.0000E-01
 GRADIENT:  -2.5680E+00  1.1734E+01 -6.2975E+00 -1.3523E-01 -8.1034E+00 -1.4279E+01 -4.7339E+00 -1.5958E+01 -5.3001E+01 -1.9711E+01
            -4.3199E+01 -2.4877E+01
 
0ITERATION NO.:    3    OBJECTIVE VALUE:  -42422.9363333239        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:       68
 NPARAMETR:  2.0000E+00  3.6338E+00  8.5294E-03 -3.3670E-05  9.2905E-03  2.4495E-02  1.5762E-03  2.8742E-02  1.0042E-01 -1.6557E-02
             8.0996E-02  1.0062E-02
 PARAMETER:  9.9853E-02  1.0008E-01  1.0089E-01 -9.9981E-02  1.0115E-01  1.0202E-01  1.0067E-01  1.0226E-01  1.0751E-01 -9.7207E-02
             1.0612E-01  1.0352E-01
 GRADIENT:   1.2222E+02  2.5088E+02  1.4954E+00  2.7474E-02  6.0940E-01 -6.7783E+00 -2.2954E+00 -9.0087E+00 -2.9350E+01 -5.5143E+00
            -2.7472E+01  1.5469E+02
 
0ITERATION NO.:    4    OBJECTIVE VALUE:  -42423.3289163427        NO. OF FUNC. EVALS.:  15
 CUMULATIVE NO. OF FUNC. EVALS.:       83
 NPARAMETR:  2.0003E+00  3.6342E+00  8.5559E-03 -3.3712E-05  9.3296E-03  2.4704E-02  1.6051E-03  2.9025E-02  1.0372E-01 -1.5855E-02
             8.2814E-02  9.9753E-03
 PARAMETER:  9.9869E-02  1.0009E-01  1.0245E-01 -9.9948E-02  1.0325E-01  1.0628E-01  1.0208E-01  1.0712E-01  1.2364E-01 -9.1596E-02
             1.1951E-01  9.9203E-02
 GRADIENT:   3.1139E+02  6.2295E+02  8.0139E+00 -8.4401E-02  7.3983E+00  7.4373E+00  1.1093E+00  4.3994E+00  1.8835E+01  1.9023E+01
             4.3892E+00 -5.9583E+01
 
0ITERATION NO.:    5    OBJECTIVE VALUE:  -42423.3567734108        NO. OF FUNC. EVALS.:  17
 CUMULATIVE NO. OF FUNC. EVALS.:      100
 NPARAMETR:  2.0003E+00  3.6342E+00  8.5314E-03 -3.3660E-05  9.3076E-03  2.4681E-02  1.6053E-03  2.9043E-02  1.0378E-01 -1.6291E-02
             8.3350E-02  9.9766E-03
 PARAMETER:  9.9868E-02  1.0009E-01  1.0101E-01 -9.9938E-02  1.0207E-01  1.0581E-01  1.0215E-01  1.0743E-01  1.2396E-01 -9.4086E-02
             1.2201E-01  9.9268E-02
 GRADIENT:   3.1170E+02  6.0072E+02  4.0086E+00  1.2989E-01  4.8834E+00  7.1514E+00  9.9863E-01  7.2407E+00  1.9329E+01  7.9632E+00
             1.0711E+01 -5.7768E+01
 
0ITERATION NO.:    6    OBJECTIVE VALUE:  -42423.3606172402        NO. OF FUNC. EVALS.:  17
 CUMULATIVE NO. OF FUNC. EVALS.:      117
 NPARAMETR:  2.0003E+00  3.6342E+00  8.5205E-03 -3.3667E-05  9.2905E-03  2.4640E-02  1.6060E-03  2.8987E-02  1.0375E-01 -1.6159E-02
             8.3462E-02  9.9771E-03
 PARAMETER:  9.9867E-02  1.0009E-01  1.0037E-01 -1.0002E-01  1.0115E-01  1.0499E-01  1.0227E-01  1.0646E-01  1.2378E-01 -9.3340E-02
             1.2295E-01  9.9293E-02
 GRADIENT:   3.0399E+02  5.8853E+02  1.6614E+00 -4.8287E-02  1.8257E+00  6.1232E+00  6.4112E-01  6.1357E+00  1.7454E+01  1.0012E+01
             1.1004E+01 -5.8549E+01
 
0ITERATION NO.:    7    OBJECTIVE VALUE:  -42423.3616139531        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:      133
 NPARAMETR:  2.0003E+00  3.6342E+00  8.5414E-03 -3.3745E-05  9.3088E-03  2.4499E-02  1.6194E-03  2.8773E-02  1.0381E-01 -1.6241E-02
             8.3804E-02  9.9766E-03
 PARAMETER:  9.9866E-02  1.0009E-01  1.0160E-01 -1.0013E-01  1.0213E-01  1.0210E-01  1.0342E-01  1.0270E-01  1.2407E-01 -9.3783E-02
             1.2491E-01  9.9267E-02
 GRADIENT:   2.9425E+02  5.8254E+02  5.1822E+00  6.5688E-03  5.0119E+00  4.4657E+00  6.0583E-01  5.1066E+00  1.6766E+01  7.8793E+00
             1.3070E+01 -5.8152E+01
 
0ITERATION NO.:    8    OBJECTIVE VALUE:  -42423.3617249329        NO. OF FUNC. EVALS.:  17
 CUMULATIVE NO. OF FUNC. EVALS.:      150
 NPARAMETR:  2.0003E+00  3.6342E+00  8.5399E-03 -3.3743E-05  9.3088E-03  2.4494E-02  1.6220E-03  2.8757E-02  1.0385E-01 -1.6257E-02
             8.3796E-02  9.9766E-03
 PARAMETER:  9.9866E-02  1.0009E-01  1.0151E-01 -1.0014E-01  1.0213E-01  1.0200E-01  1.0360E-01  1.0242E-01  1.2427E-01 -9.3857E-02
             1.2483E-01  9.9270E-02
 GRADIENT:   2.9417E+02  5.8102E+02  5.4207E+00 -3.7333E-02  5.2944E+00  4.8853E+00  1.0100E+00  5.0329E+00  1.7538E+01  8.1689E+00
             1.3112E+01 -5.7877E+01
 
0ITERATION NO.:    9    OBJECTIVE VALUE:  -42423.3617466919        NO. OF FUNC. EVALS.:  17
 CUMULATIVE NO. OF FUNC. EVALS.:      167
 NPARAMETR:  2.0003E+00  3.6342E+00  8.5390E-03 -3.3732E-05  9.3092E-03  2.4488E-02  1.6212E-03  2.8755E-02  1.0387E-01 -1.6262E-02
             8.3788E-02  9.9767E-03
 PARAMETER:  9.9866E-02  1.0009E-01  1.0146E-01 -1.0011E-01  1.0215E-01  1.0188E-01  1.0356E-01  1.0238E-01  1.2437E-01 -9.3875E-02
             1.2478E-01  9.9271E-02
 GRADIENT:   2.9286E+02  5.7915E+02  5.0519E+00 -2.5664E-02  5.0959E+00  4.4516E+00  4.9907E-01  4.5892E+00  1.7550E+01  7.7132E+00
             1.2562E+01 -5.8263E+01
 
0ITERATION NO.:   10    OBJECTIVE VALUE:  -42423.3620157340        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:      183
 NPARAMETR:  2.0003E+00  3.6342E+00  8.5346E-03 -3.3635E-05  9.3128E-03  2.4457E-02  1.6282E-03  2.8772E-02  1.0389E-01 -1.6253E-02
             8.3762E-02  9.9767E-03
 PARAMETER:  9.9866E-02  1.0009E-01  1.0120E-01 -9.9844E-02  1.0234E-01  1.0124E-01  1.0408E-01  1.0265E-01  1.2449E-01 -9.3814E-02
             1.2464E-01  9.9273E-02
 GRADIENT:   2.9208E+02  5.7672E+02  3.8315E+00  1.9405E-02  5.4364E+00  3.7667E+00 -6.3596E-02  4.5214E+00  1.7125E+01  7.8763E+00
             1.2376E+01 -5.8186E+01
 
0ITERATION NO.:   11    OBJECTIVE VALUE:  -42423.3623233816        NO. OF FUNC. EVALS.:  15
 CUMULATIVE NO. OF FUNC. EVALS.:      198
 NPARAMETR:  2.0003E+00  3.6342E+00  8.5362E-03 -3.3458E-05  9.3083E-03  2.4401E-02  1.6403E-03  2.8805E-02  1.0396E-01 -1.6256E-02
             8.3706E-02  9.9768E-03
 PARAMETER:  9.9866E-02  1.0009E-01  1.0130E-01 -9.9311E-02  1.0210E-01  1.0010E-01  1.0497E-01  1.0320E-01  1.2480E-01 -9.3802E-02
             1.2430E-01  9.9280E-02
 GRADIENT:   2.9142E+02  5.7259E+02  3.9519E+00 -8.7304E-02  4.5189E+00  3.4172E+00  4.4464E-01  4.7900E+00  1.7412E+01  8.2040E+00
             1.2041E+01 -5.7757E+01
 
0ITERATION NO.:   12    OBJECTIVE VALUE:  -42423.4236403363        NO. OF FUNC. EVALS.:  15
 CUMULATIVE NO. OF FUNC. EVALS.:      213
 NPARAMETR:  2.0001E+00  3.6340E+00  8.5006E-03 -1.5697E-05  9.2890E-03  2.4349E-02  1.8161E-03  2.8551E-02  1.0367E-01 -1.6380E-02
             8.3345E-02  9.9858E-03
 PARAMETER:  9.9857E-02  1.0008E-01  9.9203E-02 -4.6689E-02  1.0107E-01  9.9038E-02  1.1634E-01  9.8305E-02  1.2342E-01 -9.4649E-02
             1.2179E-01  9.9728E-02
 GRADIENT:   2.0950E+02  4.2667E+02 -2.6585E+00  2.0108E-01  8.7643E-01  2.1620E+00  1.7081E+00  1.6735E-02  1.2915E+01  1.0242E+01
             4.0519E+00 -3.6876E+01
 
0ITERATION NO.:   13    OBJECTIVE VALUE:  -42423.4764444991        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      227
 NPARAMETR:  1.9998E+00  3.6336E+00  8.4786E-03 -3.5557E-05  9.3470E-03  2.4568E-02  1.7894E-03  2.8649E-02  1.0278E-01 -1.6779E-02
             8.3086E-02  9.9970E-03
 PARAMETER:  9.9842E-02  1.0007E-01  9.7908E-02 -1.0590E-01  1.0417E-01  1.0351E-01  1.1412E-01  1.0013E-01  1.1909E-01 -9.7376E-02
             1.1924E-01  1.0029E-01
 GRADIENT:   7.6224E+01  1.0136E+02 -7.0816E+00 -9.1828E-02  1.0360E+01  1.6546E+00  2.5166E-01 -3.0111E-01  2.6904E+00 -3.1173E+00
             1.0178E+00 -7.1975E+00
 
0ITERATION NO.:   14    OBJECTIVE VALUE:  -42423.5035385130        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      241
 NPARAMETR:  1.9996E+00  3.6334E+00  8.5203E-03 -3.1160E-05  9.2989E-03  2.4527E-02  1.7784E-03  2.8673E-02  1.0276E-01 -1.6682E-02
             8.2977E-02  1.0003E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0036E-01 -9.2576E-02  1.0160E-01  1.0267E-01  1.1351E-01  1.0056E-01  1.1899E-01 -9.6822E-02
             1.1876E-01  1.0059E-01
 GRADIENT:  -6.1574E+00 -4.6247E+01  1.5702E+00  1.3481E+00  3.5430E+00  2.1415E+00  1.9342E+00  3.5252E-01  4.4134E+00  4.1271E-01
             4.8158E-01  9.1329E+00
 
0ITERATION NO.:   15    OBJECTIVE VALUE:  -42423.5056783715        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      255
 NPARAMETR:  1.9995E+00  3.6334E+00  8.5399E-03 -3.6461E-05  9.2822E-03  2.4549E-02  1.7384E-03  2.8716E-02  1.0265E-01 -1.6625E-02
             8.2959E-02  1.0005E-02
 PARAMETER:  9.9828E-02  1.0007E-01  1.0151E-01 -1.0820E-01  1.0070E-01  1.0313E-01  1.1091E-01  1.0142E-01  1.1848E-01 -9.6540E-02
             1.1874E-01  1.0071E-01
 GRADIENT:  -4.3822E+01 -1.1454E+02  3.9894E+00  6.3775E-02 -1.3028E-01  1.1067E+00  7.7959E-01 -4.4836E-01  2.7450E+00 -5.9418E-01
            -5.5955E-01  1.4045E+01
 
0ITERATION NO.:   16    OBJECTIVE VALUE:  -42423.5105515202        NO. OF FUNC. EVALS.:  15
 CUMULATIVE NO. OF FUNC. EVALS.:      270
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5273E-03 -3.7063E-05  9.2884E-03  2.4547E-02  1.7442E-03  2.8727E-02  1.0257E-01 -1.6577E-02
             8.3002E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0077E-01 -1.1007E-01  1.0103E-01  1.0309E-01  1.1128E-01  1.0161E-01  1.1811E-01 -9.6298E-02
             1.1909E-01  1.0045E-01
 GRADIENT:  -4.8536E+00 -8.8773E+00  1.5227E+00 -1.7514E-01  8.1781E-01  4.0352E-01 -2.0569E-01 -2.4347E-02  1.4598E-01  6.1467E-02
            -2.1291E-01 -4.8610E-02
 
0ITERATION NO.:   17    OBJECTIVE VALUE:  -42423.5105583005        NO. OF FUNC. EVALS.:  15
 CUMULATIVE NO. OF FUNC. EVALS.:      285
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5265E-03 -3.7004E-05  9.2883E-03  2.4545E-02  1.7456E-03  2.8726E-02  1.0257E-01 -1.6579E-02
             8.3006E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0073E-01 -1.0990E-01  1.0103E-01  1.0305E-01  1.1138E-01  1.0158E-01  1.1811E-01 -9.6308E-02
             1.1912E-01  1.0045E-01
 GRADIENT:  -2.4738E+00 -5.5498E+00  2.1372E+00 -8.2294E-03  1.4254E+00  1.2784E+00  4.3009E-01  4.5982E-01  7.4744E-01  1.1120E+00
             7.5422E-01  8.9169E-01
 
0ITERATION NO.:   18    OBJECTIVE VALUE:  -42423.5105598416        NO. OF FUNC. EVALS.:  15
 CUMULATIVE NO. OF FUNC. EVALS.:      300
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5261E-03 -3.6981E-05  9.2882E-03  2.4544E-02  1.7463E-03  2.8725E-02  1.0257E-01 -1.6580E-02
             8.3008E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0070E-01 -1.0983E-01  1.0102E-01  1.0303E-01  1.1142E-01  1.0157E-01  1.1811E-01 -9.6313E-02
             1.1912E-01  1.0045E-01
 GRADIENT:  -1.9407E+00 -4.2111E+00  2.1434E+00  2.3378E-02  1.6519E+00  1.4870E+00  6.0368E-01  9.0182E-01  1.2506E+00  1.5118E+00
             1.2307E+00  1.0127E+00
 
0ITERATION NO.:   19    OBJECTIVE VALUE:  -42423.5105598677        NO. OF FUNC. EVALS.:  20
 CUMULATIVE NO. OF FUNC. EVALS.:      320
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5261E-03 -3.6981E-05  9.2882E-03  2.4544E-02  1.7463E-03  2.8725E-02  1.0257E-01 -1.6580E-02
             8.3008E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0070E-01 -1.0983E-01  1.0102E-01  1.0303E-01  1.1142E-01  1.0157E-01  1.1811E-01 -9.6313E-02
             1.1912E-01  1.0045E-01
 GRADIENT:  -1.7372E+00 -3.9250E+00  2.2243E+00  5.0751E-02  1.6782E+00  1.7335E+00  1.0549E+00  9.0822E-01  1.3743E+00  1.5884E+00
             1.1998E+00  9.4330E-01
 
0ITERATION NO.:   20    OBJECTIVE VALUE:  -42423.5106058490        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      334
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5248E-03 -3.6898E-05  9.2871E-03  2.4542E-02  1.7468E-03  2.8720E-02  1.0257E-01 -1.6580E-02
             8.3027E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0062E-01 -1.0959E-01  1.0096E-01  1.0299E-01  1.1146E-01  1.0147E-01  1.1810E-01 -9.6313E-02
             1.1924E-01  1.0044E-01
 GRADIENT:  -7.6878E-01 -4.3096E-01  1.4756E+00 -4.4282E-02  7.8765E-01  6.7176E-01  4.6851E-02  5.9876E-02 -2.8616E-02  1.3005E-01
             3.3664E-01 -4.0748E-01
 
0ITERATION NO.:   21    OBJECTIVE VALUE:  -42423.5106058490        NO. OF FUNC. EVALS.:  24
 CUMULATIVE NO. OF FUNC. EVALS.:      358
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5248E-03 -3.6898E-05  9.2871E-03  2.4542E-02  1.7468E-03  2.8720E-02  1.0257E-01 -1.6580E-02
             8.3027E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0062E-01 -1.0959E-01  1.0096E-01  1.0299E-01  1.1146E-01  1.0147E-01  1.1810E-01 -9.6313E-02
             1.1924E-01  1.0044E-01
 GRADIENT:  -4.6754E+00 -1.2948E+01  1.0155E+00  5.9153E-02  6.6619E-01  7.6402E-01  8.6983E-01 -3.7624E-02  1.2122E+00  2.8678E-01
             7.1487E-01  1.5176E-02
 
0ITERATION NO.:   22    OBJECTIVE VALUE:  -42423.5136321237        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:      374            RESET HESSIAN, TYPE II
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5247E-03 -3.7089E-05  9.2871E-03  2.4540E-02  1.6157E-03  2.8702E-02  1.0257E-01 -1.6580E-02
             8.3027E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0062E-01 -1.1016E-01  1.0096E-01  1.0294E-01  1.0310E-01  1.0147E-01  1.1810E-01 -9.6313E-02
             1.1924E-01  1.0044E-01
 GRADIENT:   1.8521E+00 -8.7668E-01  1.5197E+00  5.5830E-02  1.0353E+00  1.0859E+00 -4.6020E-01  4.9139E-01  4.2910E-01 -2.5042E+00
             3.2347E-01  2.0403E-01
 
0ITERATION NO.:   23    OBJECTIVE VALUE:  -42423.5148673733        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      388
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5227E-03 -4.1469E-05  9.2856E-03  2.4465E-02  1.6137E-03  2.8689E-02  1.0256E-01 -1.6564E-02
             8.3013E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0050E-01 -1.2319E-01  1.0088E-01  1.0142E-01  1.0313E-01  1.0124E-01  1.1803E-01 -9.6226E-02
             1.1919E-01  1.0044E-01
 GRADIENT:   9.3173E-01  2.2348E+00  1.2539E+00  4.4007E-01  6.9982E-01 -1.3415E-02  3.4374E-01  7.8176E-02  3.1882E-01 -2.3620E+00
             2.0068E-01  1.2305E-01
 
0ITERATION NO.:   24    OBJECTIVE VALUE:  -42423.5152546288        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      402
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5222E-03 -4.8863E-05  9.2854E-03  2.4464E-02  1.6109E-03  2.8687E-02  1.0256E-01 -1.6557E-02
             8.3010E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0047E-01 -1.4515E-01  1.0086E-01  1.0140E-01  1.0296E-01  1.0121E-01  1.1803E-01 -9.6188E-02
             1.1918E-01  1.0044E-01
 GRADIENT:   1.0194E+00  1.0563E+00  1.0033E+00 -9.0878E-02  7.4982E-01 -2.6233E-01 -7.1307E-01 -2.3242E-01 -1.0621E+00 -2.7693E+00
            -5.0614E-01 -4.2744E-01
 
0ITERATION NO.:   25    OBJECTIVE VALUE:  -42423.5158003131        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      416
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5211E-03 -4.9213E-05  9.2846E-03  2.4487E-02  1.6216E-03  2.8702E-02  1.0257E-01 -1.6544E-02
             8.3010E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0041E-01 -1.4621E-01  1.0082E-01  1.0187E-01  1.0359E-01  1.0145E-01  1.1807E-01 -9.6110E-02
             1.1921E-01  1.0045E-01
 GRADIENT:   1.6593E+00  1.8084E+00  1.0213E+00 -5.1323E-02  8.7597E-01  8.4462E-02 -6.6819E-01  1.3221E-01 -3.6707E-01 -2.1109E+00
            -9.1402E-02 -3.1779E-01
 
0ITERATION NO.:   26    OBJECTIVE VALUE:  -42423.5160354556        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      430
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5190E-03 -4.9754E-05  9.2827E-03  2.4498E-02  1.6405E-03  2.8713E-02  1.0257E-01 -1.6527E-02
             8.3002E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0028E-01 -1.4783E-01  1.0072E-01  1.0210E-01  1.0477E-01  1.0160E-01  1.1807E-01 -9.6012E-02
             1.1919E-01  1.0045E-01
 GRADIENT:   2.5215E+00  3.9300E+00  1.1696E+00 -9.9913E-03  7.3831E-01  7.3852E-01  2.0734E-01  7.2447E-01  2.0292E-02 -5.1644E-01
             3.6375E-01  6.8741E-03
 
0ITERATION NO.:   27    OBJECTIVE VALUE:  -42423.5161421772        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      444
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5172E-03 -4.9475E-05  9.2815E-03  2.4488E-02  1.6387E-03  2.8708E-02  1.0258E-01 -1.6512E-02
             8.2998E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0018E-01 -1.4701E-01  1.0065E-01  1.0188E-01  1.0468E-01  1.0151E-01  1.1813E-01 -9.5917E-02
             1.1920E-01  1.0045E-01
 GRADIENT:   1.4661E+00  3.4923E+00  2.8437E-01 -1.2772E-01  8.6566E-02  4.4811E-01 -6.0773E-01  1.6719E-01 -2.9848E-01 -5.8390E-01
             5.8898E-02 -1.4540E-01
 
0ITERATION NO.:   28    OBJECTIVE VALUE:  -42423.5161510150        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      458
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5164E-03 -4.9310E-05  9.2810E-03  2.4481E-02  1.6386E-03  2.8707E-02  1.0258E-01 -1.6506E-02
             8.2996E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0013E-01 -1.4653E-01  1.0063E-01  1.0175E-01  1.0469E-01  1.0149E-01  1.1815E-01 -9.5879E-02
             1.1920E-01  1.0045E-01
 GRADIENT:   1.5506E+00  4.2207E+00  8.7812E-01  7.4448E-01  9.0367E-01  1.1461E+00  1.1719E+00  9.7742E-01  1.3882E+00  9.0600E-02
             7.0529E-01  5.8390E-01
 
0ITERATION NO.:   29    OBJECTIVE VALUE:  -42423.5161510150        NO. OF FUNC. EVALS.:  30
 CUMULATIVE NO. OF FUNC. EVALS.:      488
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5164E-03 -4.9310E-05  9.2810E-03  2.4481E-02  1.6386E-03  2.8707E-02  1.0258E-01 -1.6506E-02
             8.2996E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0013E-01 -1.4653E-01  1.0063E-01  1.0175E-01  1.0469E-01  1.0149E-01  1.1815E-01 -9.5879E-02
             1.1920E-01  1.0045E-01
 GRADIENT:  -3.0679E+00 -9.7776E+00 -3.2109E-01 -1.1052E-03 -2.3942E-01 -3.1745E-02  1.4804E-01 -3.0616E-01  3.6519E-01 -9.0069E-01
            -1.2220E-01 -5.3500E-01
 
0ITERATION NO.:   30    OBJECTIVE VALUE:  -42423.5161510150        NO. OF FUNC. EVALS.:   0
 CUMULATIVE NO. OF FUNC. EVALS.:      488
 NPARAMETR:  1.9996E+00  3.6335E+00  8.5164E-03 -4.9310E-05  9.2810E-03  2.4481E-02  1.6386E-03  2.8707E-02  1.0258E-01 -1.6506E-02
             8.2996E-02  1.0000E-02
 PARAMETER:  9.9833E-02  1.0007E-01  1.0013E-01 -1.4653E-01  1.0063E-01  1.0175E-01  1.0469E-01  1.0149E-01  1.1815E-01 -9.5879E-02
             1.1920E-01  1.0045E-01
 GRADIENT:  -3.0679E+00 -9.7776E+00 -3.2109E-01 -1.1052E-03 -2.3942E-01 -3.1745E-02  1.4804E-01 -3.0616E-01  3.6519E-01 -9.0069E-01
            -1.2220E-01 -5.3500E-01
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      488
 NO. OF SIG. DIGITS IN FINAL EST.:  2.2

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -3.5864E-04 -4.3025E-04 -2.4869E-17 -1.5049E-17  3.1718E-03 -2.4806E-03
 SE:             1.6245E-03  1.6971E-03  9.8873E-03  1.0705E-02  6.1685E-02  5.5528E-02
 N:                    2500        2500         250         250          25          25
 
 P VAL.:         8.2527E-01  7.9987E-01  1.0000E+00  1.0000E+00  9.5899E-01  9.6437E-01
 
 ETASHRINKSD(%)  1.1983E+01  1.1918E+01  8.5337E-02  9.5763E-02  1.7173E+00  1.6403E+00
 ETASHRINKVR(%)  2.2531E+01  2.2416E+01  1.7060E-01  1.9143E-01  3.4051E+00  3.2537E+00
 EBVSHRINKSD(%)  1.1942E+01  1.1848E+01  3.9140E-01  3.6103E-01  9.3227E-03  1.2465E-02
 EBVSHRINKVR(%)  2.2458E+01  2.2293E+01  7.8126E-01  7.2075E-01  1.8645E-02  2.4929E-02
 RELATIVEINF(%)  7.7265E+01  7.7429E+01  9.9225E+01  9.9285E+01  9.9980E+01  9.9973E+01
 EPSSHRINKSD(%)  1.1452E+01
 EPSSHRINKVR(%)  2.1593E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):        17500
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    32162.8486621635     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -42423.5161510150     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -10260.6674888515     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          5550
  
 #TERE:
 Elapsed estimation  time in seconds:  1618.65
 Elapsed covariance  time in seconds:   285.76
 SKIPPING EXECUTION OF SLOW FNLMOD/FNLETA BY USER REQUEST
 Elapsed postprocess time in seconds:     0.05
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -42423.516       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
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
+       -4.93E-05  9.28E-03
 
 ETA3
+        0.00E+00  0.00E+00  2.45E-02
 
 ETA4
+        0.00E+00  0.00E+00  1.64E-03  2.87E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.03E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.65E-02  8.30E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.23E-02
 
 ETA2
+       -5.55E-03  9.63E-02
 
 ETA3
+        0.00E+00  0.00E+00  1.56E-01
 
 ETA4
+        0.00E+00  0.00E+00  6.18E-02  1.69E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.20E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.79E-01  2.88E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         5.40E-02  5.00E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        3.08E-04
 
 ETA2
+        2.30E-04  3.41E-04
 
 ETA3
+       ......... .........  2.20E-03
 
 ETA4
+       ......... .........  1.69E-03  2.59E-03
 
 ETA5
+       ......... ......... ......... .........  3.08E-02
 
 ETA6
+       ......... ......... ......... .........  1.97E-02  2.47E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.26E-04
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.67E-03
 
 ETA2
+        2.59E-02  1.77E-03
 
 ETA3
+       ......... .........  7.04E-03
 
 ETA4
+       ......... .........  6.35E-02  7.63E-03
 
 ETA5
+       ......... ......... ......... .........  4.81E-02
 
 ETA6
+       ......... ......... ......... .........  2.05E-01  4.29E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        6.32E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        2.91E-03
 
 TH 2
+       -6.30E-04  2.50E-03
 
 OM11
+        3.61E-07  6.63E-08  9.46E-08
 
 OM12
+        1.65E-07  7.86E-08  6.44E-09  5.31E-08
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        1.38E-08  9.09E-09  1.49E-10  5.24E-09 ......... ......... ......... .........  1.16E-07
 
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
+       -3.52E-06  2.27E-06  7.57E-10  9.31E-11 ......... ......... ......... .........  2.67E-10 ......... ......... .........
         .........  4.86E-06
 
 OM34
+        3.63E-06 -1.51E-06  5.77E-10  8.57E-10 ......... ......... ......... .........  4.16E-10 ......... ......... .........
         .........  3.29E-07  2.87E-06
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -2.42E-06  4.68E-07 -1.12E-10  1.65E-10 ......... ......... ......... .........  1.42E-09 ......... ......... .........
         .........  3.13E-08  4.05E-07 ......... .........  6.68E-06
 
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
+       -3.99E-05  1.73E-05 -4.05E-08 -1.40E-08 ......... ......... ......... ......... -5.32E-08 ......... ......... .........
         .........  2.45E-07 -3.74E-08 ......... .........  1.28E-08 ......... .........  9.48E-04
 
 OM56
+        2.21E-05 -1.54E-05  8.88E-09  4.61E-09 ......... ......... ......... .........  9.24E-09 ......... ......... .........
         ......... -1.29E-08  1.30E-07 ......... .........  2.59E-08 ......... ......... -1.46E-04  3.90E-04
 
 OM66
+       -1.28E-05  1.53E-05 -2.41E-08 -6.87E-09 ......... ......... ......... ......... -2.67E-08 ......... ......... .........
         .........  1.11E-08  9.82E-09 ......... .........  2.27E-07 ......... .........  2.23E-05 -1.12E-04  6.11E-04
 
 SG11
+       -1.77E-07  8.39E-08 -2.94E-09 -9.27E-10 ......... ......... ......... ......... -3.86E-09 ......... ......... .........
         ......... -6.61E-10 -6.01E-10 ......... ......... -3.21E-10 ......... .........  2.21E-07 -3.67E-08  1.28E-07  1.60E-08
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        5.40E-02
 
 TH 2
+       -2.33E-01  5.00E-02
 
 OM11
+        2.18E-02  4.31E-03  3.08E-04
 
 OM12
+        1.33E-02  6.82E-03  9.09E-02  2.30E-04
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        7.49E-04  5.34E-04  1.43E-03  6.67E-02 ......... ......... ......... .........  3.41E-04
 
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
+       -2.96E-02  2.06E-02  1.12E-03  1.83E-04 ......... ......... ......... .........  3.55E-04 ......... ......... .........
         .........  2.20E-03
 
 OM34
+        3.97E-02 -1.78E-02  1.11E-03  2.20E-03 ......... ......... ......... .........  7.22E-04 ......... ......... .........
         .........  8.80E-02  1.69E-03
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -1.73E-02  3.62E-03 -1.41E-04  2.77E-04 ......... ......... ......... .........  1.61E-03 ......... ......... .........
         .........  5.50E-03  9.25E-02 ......... .........  2.59E-03
 
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
+       -2.40E-02  1.13E-02 -4.27E-03 -1.98E-03 ......... ......... ......... ......... -5.08E-03 ......... ......... .........
         .........  3.61E-03 -7.17E-04 ......... .........  1.61E-04 ......... .........  3.08E-02
 
 OM56
+        2.07E-02 -1.56E-02  1.46E-03  1.01E-03 ......... ......... ......... .........  1.37E-03 ......... ......... .........
         ......... -2.98E-04  3.90E-03 ......... .........  5.08E-04 ......... ......... -2.40E-01  1.97E-02
 
 OM66
+       -9.57E-03  1.24E-02 -3.17E-03 -1.21E-03 ......... ......... ......... ......... -3.18E-03 ......... ......... .........
         .........  2.04E-04  2.35E-04 ......... .........  3.56E-03 ......... .........  2.93E-02 -2.30E-01  2.47E-02
 
 SG11
+       -2.60E-02  1.33E-02 -7.57E-02 -3.18E-02 ......... ......... ......... ......... -8.96E-02 ......... ......... .........
         ......... -2.37E-03 -2.81E-03 ......... ......... -9.83E-04 ......... .........  5.68E-02 -1.47E-02  4.08E-02  1.26E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        3.64E+02
 
 TH 2
+        9.10E+01  4.23E+02
 
 OM11
+       -1.28E+03 -6.29E+02  1.07E+07
 
 OM12
+       -1.06E+03 -8.54E+02 -1.27E+06  1.91E+07
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        1.08E+02 -5.07E+01  1.08E+05 -8.37E+05 ......... ......... ......... .........  8.73E+06
 
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
+        2.52E+02 -1.40E+02 -2.03E+03 -1.10E+02 ......... ......... ......... ......... -4.87E+01 ......... ......... .........
         .........  2.08E+05
 
 OM34
+       -4.62E+02  1.23E+02  1.53E+02 -4.23E+03 ......... ......... ......... ......... -5.25E+02 ......... ......... .........
         ......... -2.43E+04  3.55E+05
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+        1.52E+02 -3.30E+00 -1.39E+02 -3.49E+02 ......... ......... ......... ......... -1.65E+03 ......... ......... .........
         .........  5.99E+02 -2.16E+04 ......... .........  1.51E+05
 
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
+        1.09E+01 -2.10E+00 -4.75E+01 -1.77E+01 ......... ......... ......... ......... -5.40E-01 ......... ......... .........
         ......... -4.75E+01 -1.76E+01 ......... ......... -5.48E-01 ......... .........  1.12E+03
 
 OM56
+       -1.19E+01  8.74E+00 -2.13E+01 -1.02E+02 ......... ......... ......... ......... -2.82E+01 ......... ......... .........
         ......... -2.13E+01 -1.02E+02 ......... ......... -2.82E+01 ......... .........  4.30E+02  2.87E+03
 
 OM66
+        2.01E+00 -6.76E+00  4.98E-01 -2.98E+01 ......... ......... ......... ......... -5.87E+01 ......... ......... .........
         .........  5.08E-01 -2.93E+01 ......... ......... -5.87E+01 ......... .........  4.13E+01  5.13E+02  1.73E+03
 
 SG11
+        3.10E+03 -1.29E+03  1.92E+06  6.64E+05 ......... ......... ......... .........  2.08E+06 ......... ......... .........
         .........  1.14E+04  6.04E+03 ......... .........  3.93E+03 ......... ......... -1.48E+04 -3.64E+03 -1.32E+04  6.39E+07
 
 Elapsed finaloutput time in seconds:     2.06
 #CPUT: Total CPU Time in Seconds,     1972.024
Stop Time: 
Thu 12/12/2019 
06:19 PM
