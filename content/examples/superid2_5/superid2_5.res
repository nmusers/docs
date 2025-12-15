Thu 12/12/2019 
06:19 PM
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

$PRIOR NWPRI NTHETA=2 NETA=6 NTHP=0 NETP=6
$OMEGA BLOCK(2)
0.01 FIX
0.0 0.01

;$OMEGA 0.03 0.03
$OMEGA BLOCK(2)
0.03 FIX
0.0 0.03

$OMEGA BLOCK(2)
0.1 FIX
0.0 0.1

$THETA (2 FIX) (2 FIX) (2 FIX)

$EST METHOD=ITS INTERACTION PRINT=1 NSIG=3 NITER=12 SIGL=5 FNLETA=0 NOABORT SIGLO=8 MCETA=10 NOPRIOR=1
     LEVCENTER=0
;$EST METHOD=IMP INTERACTION PRINT=1 NSIG=3 NITER=500 CTYPE=3 ISAMPLE=300 MCETA=3 FNLETA=0 NOABORT SIGL=5 SIGLO=8
;$EST METHOD=1 INTERACTION PRINT=1 MAXEVAL=9999 NSIG=3 FNLETA=0 SIGL=10
$EST METHOD=BAYES INTERACTION PRINT=10 NSIG=3 NBURN=1000 NITER=1000 CTYPE=3 FNLETA=0 NOABORT NOPRIOR=0
$COV MATRIX=R UNCONDITIONAL
$TABLE  ID TIME CONC DOSE RATE EVID MDV CMT SID CID CL V ETA1 ETA2 ETA3 ETA4 ETA5 ETA6 
NOAPPEND ONEHEADER FILE=superid2_5.tab  NOPRINT
  
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
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 CL V
0FORMAT FOR DATA:
 (7E10.0/3E10.0)

 TOT. NO. OF OBS RECS:    17500
 TOT. NO. OF INDIVIDUALS:     2500
0LENGTH OF THETA:   5
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS BLOCK FORM:
  1
  1  1
  0  0  2
  0  0  2  2
  0  0  0  0  3
  0  0  0  0  3  3
  0  0  0  0  0  0  4
  0  0  0  0  0  0  4  4
  0  0  0  0  0  0  0  0  5
  0  0  0  0  0  0  0  0  5  5
  0  0  0  0  0  0  0  0  0  0  6
  0  0  0  0  0  0  0  0  0  0  6  6
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
 -0.1000E+07     0.5000E+01     0.1000E+07
 -0.1000E+07     0.5000E+01     0.1000E+07
  0.2000E+01     0.2000E+01     0.2000E+01
  0.2000E+01     0.2000E+01     0.2000E+01
  0.2000E+01     0.2000E+01     0.2000E+01
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
        4                                                                                  YES
                  0.1000E-01
                  0.0000E+00   0.1000E-01
        5                                                                                  YES
                  0.3000E-01
                  0.0000E+00   0.3000E-01
        6                                                                                  YES
                  0.1000E+00
                  0.0000E+00   0.1000E+00
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
 ID TIME CONC DOSE RATE EVID MDV CMT SID CID CL V ETA1 ETA2 ETA3 ETA4 ETA5 ETA6
0
 PRIOR SUBROUTINE USER-SUPPLIED
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
 #METH: Iterative Two Stage (No Prior)
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            1680
 NO. OF SIG. FIGURES REQUIRED:            3
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    10
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      8
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     5
 NOPRIOR SETTING (NOPRIOR):                 1
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          0
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): superid2_5.ext
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

 iteration            0 OBJ=   7033.34645369272
 iteration            1 OBJ=  -30643.0438100404
 iteration            2 OBJ=  -36605.3564619004
 iteration            3 OBJ=  -41064.9848151580
 iteration            4 OBJ=  -42328.2396959070
 iteration            5 OBJ=  -42417.3723064964
 iteration            6 OBJ=  -42419.9285910728
 iteration            7 OBJ=  -42419.9163617153
 iteration            8 OBJ=  -42419.9201102837
 iteration            9 OBJ=  -42419.9184339545
 iteration           10 OBJ=  -42419.9168539887
 iteration           11 OBJ=  -42419.9159216108
 iteration           12 OBJ=  -42419.9154415730
 
 #TERM:
 OPTIMIZATION WAS NOT TESTED FOR CONVERGENCE


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -4.3915E-04 -3.7237E-04 -4.1156E-17 -1.0408E-17 -9.0633E-05 -4.6842E-05
 SE:             1.6259E-03  1.6982E-03  9.8791E-03  1.0699E-02  6.1638E-02  5.5498E-02
 N:                    2500        2500         250         250          25          25
 
 P VAL.:         7.8709E-01  8.2644E-01  1.0000E+00  1.0000E+00  9.9883E-01  9.9933E-01
 
 ETASHRINKSD(%)  1.1916E+01  1.1832E+01  4.9877E-05  4.5629E-05  4.7489E-05  3.8301E-05
 ETASHRINKVR(%)  2.2412E+01  2.2264E+01  9.9753E-05  9.1258E-05  9.4978E-05  7.6602E-05
 EBVSHRINKSD(%)  1.1912E+01  1.1829E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  2.2405E+01  2.2259E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  7.7331E+01  7.7477E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  1.1332E+01
 EPSSHRINKVR(%)  2.1380E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):        17500
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    32162.8486621635     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -42419.9154415730     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -10257.0667794095     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          5548
  
 #TERE:
 Elapsed estimation  time in seconds:   109.52
 Elapsed covariance  time in seconds:     2.49
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -42419.915       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
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
+       -3.22E-05  9.27E-03
 
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
+        9.97E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.23E-02
 
 ETA2
+       -3.63E-03  9.63E-02
 
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
+        9.98E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
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
+        2.56E-02  1.78E-03
 
 ETA3
+       ......... .........  6.66E-03
 
 ETA4
+       ......... .........  6.30E-02  7.23E-03
 
 ETA5
+       ......... ......... ......... .........  5.27E-02
 
 ETA6
+       ......... ......... ......... .........  2.58E-01  5.04E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        6.42E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (S)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        4.74E-03
 
 TH 2
+       -6.59E-04  4.10E-03
 
 OM11
+       -2.45E-07  6.47E-07  9.30E-08
 
 OM12
+        3.85E-08 -1.67E-07  6.98E-09  5.19E-08
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        1.12E-06  2.42E-07 -2.26E-09 -1.73E-10  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.17E-07
 
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
+        4.40E-06  2.39E-05  1.77E-08  3.89E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -7.37E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  4.33E-06
 
 OM34
+        6.34E-06  5.70E-06 -5.43E-09 -1.61E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.11E-08  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -1.45E-07  2.76E-06
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -1.81E-06  3.97E-06  1.43E-08  4.43E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -9.16E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -6.15E-08  8.68E-08  0.00E+00  0.00E+00  5.98E-06
 
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
+        3.07E-05  6.10E-04  2.68E-07  5.40E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.68E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  8.70E-06  3.22E-06  0.00E+00  0.00E+00  4.96E-06  0.00E+00  0.00E+00  1.10E-03
 
 OM56
+        4.62E-04 -3.18E-04 -1.36E-07  1.07E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.05E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -5.01E-06  1.81E-06  0.00E+00  0.00E+00 -1.48E-06  0.00E+00  0.00E+00 -5.32E-04  6.44E-04
 
 OM66
+       -8.44E-05  6.27E-04  1.50E-07 -8.98E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.35E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  3.01E-06 -3.82E-06  0.00E+00  0.00E+00  1.32E-06  0.00E+00  0.00E+00  2.53E-04 -2.25E-04  8.15E-04
 
 SG11
+        6.58E-08  6.25E-08 -1.88E-09 -3.85E-10  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.32E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.06E-09 -2.95E-10  0.00E+00  0.00E+00 -2.33E-09  0.00E+00  0.00E+00 -1.14E-07  2.94E-08 -1.06E-08  1.64E-08
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
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
+       -1.17E-02  3.31E-02  3.05E-04
 
 OM12
+        2.46E-03 -1.14E-02  1.00E-01  2.28E-04
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        4.74E-02  1.10E-02 -2.16E-02 -2.21E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.42E-04
 
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
+        3.07E-02  1.79E-01  2.79E-02  8.20E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.03E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.08E-03
 
 OM34
+        5.55E-02  5.36E-02 -1.07E-02 -4.26E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.95E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -4.21E-02  1.66E-03
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -1.07E-02  2.53E-02  1.92E-02  7.96E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.09E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -1.21E-02  2.14E-02  0.00E+00  0.00E+00  2.45E-03
 
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
+        1.35E-02  2.87E-01  2.66E-02  7.15E-04  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.49E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.26E-01  5.85E-02  0.00E+00  0.00E+00  6.12E-02  0.00E+00  0.00E+00  3.31E-02
 
 OM56
+        2.65E-01 -1.96E-01 -1.76E-02  1.86E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.21E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -9.48E-02  4.28E-02  0.00E+00  0.00E+00 -2.38E-02  0.00E+00  0.00E+00 -6.33E-01  2.54E-02
 
 OM66
+       -4.30E-02  3.43E-01  1.72E-02 -1.38E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.43E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  5.06E-02 -8.05E-02  0.00E+00  0.00E+00  1.89E-02  0.00E+00  0.00E+00  2.68E-01 -3.11E-01  2.85E-02
 
 SG11
+        7.46E-03  7.61E-03 -4.80E-02 -1.32E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -5.30E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  7.70E-03 -1.38E-03  0.00E+00  0.00E+00 -7.42E-03  0.00E+00  0.00E+00 -2.69E-02  9.03E-03 -2.89E-03  1.28E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
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
+        3.40E+02 -1.30E+03  1.09E+07
 
 OM12
+        4.26E+02  8.04E+02 -1.45E+06  1.95E+07
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.64E+03 -1.98E+03  2.24E+05 -7.10E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  8.62E+06
 
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
+       -5.46E+02 -1.44E+03 -3.35E+04 -1.36E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.09E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.43E+05
 
 OM34
+       -3.61E+02 -8.69E+02  1.43E+04  1.20E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.33E+04  0.00E+00  0.00E+00  0.00E+00
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
+       -1.76E+02 -1.59E+02 -1.41E+03 -3.99E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.37E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -8.09E+02 -2.38E+03  0.00E+00  0.00E+00 -9.82E+02  0.00E+00  0.00E+00  1.75E+03
 
 OM56
+       -3.19E+02 -9.87E+01 -7.17E+01 -6.58E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.16E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.13E+03 -2.21E+03  0.00E+00  0.00E+00 -5.23E+02  0.00E+00  0.00E+00  1.48E+03  3.11E+03
 
 OM66
+       -4.92E+01 -2.10E+02 -3.81E+02  1.90E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.66E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  8.12E+02  2.46E+03  0.00E+00  0.00E+00 -9.54E+01  0.00E+00  0.00E+00 -3.70E+01  4.32E+02  1.53E+03
 
 SG11
+       -2.14E+03 -2.71E+03  1.24E+06  2.73E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.28E+06  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -3.01E+04 -1.22E+03  0.00E+00  0.00E+00  1.57E+04  0.00E+00  0.00E+00  1.09E+04  6.79E+03  1.54E+03  6.13E+07
 
1
 
 
 #TBLN:      2
 #METH: MCMC Bayesian Analysis
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            1680
 NO. OF SIG. FIGURES REQUIRED:            3
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    10
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      8
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     5
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          0
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): superid2_5.ext
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
 EM OR BAYESIAN METHOD USED:                MCMC BAYESIAN (BAYES)
 BAYES INDIVIDUAL PARAMETERS ONLY: NO
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  3
 KEEP ITERATIONS (THIN):            1
 CONVERGENCE INTERVAL (CINTERVAL):          10
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 BURN-IN ITERATIONS (NBURN):                1000
 FIRST ITERATION FOR MAP (MAPITERS):          NO
 ITERATIONS (NITER):                        1000
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
 MC SAMPLES PER SUBJECT (ISAMPLE):          1
 RANDOM SAMPLING METHOD (RANMETHOD):        3U
 PROPOSAL DENSITY SCALING RANGE
              (ISCALE_MIN, ISCALE_MAX):     1.000000000000000E-06   ,1000000.00000000
 SAMPLE ACCEPTANCE RATE (IACCEPT):          0.400000000000000
 METROPOLIS HASTINGS SAMPLING FOR INDIVIDUAL ETAS:
 SAMPLES FOR GLOBAL SEARCH KERNEL (ISAMPLE_M1):          2
 SAMPLES FOR NEIGHBOR SEARCH KERNEL (ISAMPLE_M1A):       0
 SAMPLES FOR MASS/IMP/POST. MATRIX SEARCH (ISAMPLE_M1B): 2
 SAMPLES FOR LOCAL SEARCH KERNEL (ISAMPLE_M2):           2
 SAMPLES FOR LOCAL UNIVARIATE KERNEL (ISAMPLE_M3):       2
 PWR. WT. MASS/IMP/POST MATRIX ACCUM. FOR ETAS (IKAPPA): 1.00000000000000
 MASS/IMP./POST. MATRIX REFRESH SETTING (MASSRESET):      -1
 METROPOLIS HASTINGS POPULATION SAMPLING FOR NON-GIBBS
 SAMPLED THETAS AND SIGMAS:
 PROPOSAL DENSITY SCALING RANGE
              (PSCALE_MIN, PSCALE_MAX):   1.000000000000000E-02   ,1000.00000000000
 SAMPLE ACCEPTANCE RATE (PACCEPT):                       0.500000000000000
 SAMPLES FOR GLOBAL SEARCH KERNEL (PSAMPLE_M1):          1
 SAMPLES FOR LOCAL SEARCH KERNEL (PSAMPLE_M2):           -1
 SAMPLES FOR LOCAL UNIVARIATE KERNEL (PSAMPLE_M3):       1
 METROPOLIS HASTINGS POPULATION SAMPLING FOR NON-GIBBS
 SAMPLED OMEGAS:
 SAMPLE ACCEPTANCE RATE (OACCEPT):                       0.500000000000000
 SAMPLES FOR GLOBAL SEARCH KERNEL (OSAMPLE_M1):          -1
 SAMPLES FOR LOCAL SEARCH KERNEL (OSAMPLE_M2):           9
 SAMPLES FOR LOCAL UNIVARIATE SEARCH KERNEL (OSAMPLE_M3):9
 USER DEFINED PRIOR SETTING FOR THETAS: (TPU):        0.00000000000000
 WEIGHT FACTOR FOR STD PRIOR FOR SIGMAS (SVARF): -1.000000000000000+300

 
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
 THETAS THAT ARE GIBBS SAMPLED:
   1   2
 THETAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 SIGMAS THAT ARE GIBBS SAMPLED:
   1
 SIGMAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 OMEGAS ARE GIBBS SAMPLED
 
 MONITORING OF SEARCH:

 Burn-in Mode
 iteration        -1000 MCMCOBJ=   -76182.1745775148     
 iteration         -990 MCMCOBJ=   -75839.0789185761     
 iteration         -980 MCMCOBJ=   -76291.3290104226     
 iteration         -970 MCMCOBJ=   -76187.2865435629     
 iteration         -960 MCMCOBJ=   -76175.9716315581     
 iteration         -950 MCMCOBJ=   -76173.8892026367     
 iteration         -940 MCMCOBJ=   -76079.8737219026     
 iteration         -930 MCMCOBJ=   -76354.6849319015     
 iteration         -920 MCMCOBJ=   -76278.8299380107     
 iteration         -910 MCMCOBJ=   -76161.5892879902     
 iteration         -900 MCMCOBJ=   -76068.7224859997     
 Convergence achieved
 Sampling Mode
 iteration            0 MCMCOBJ=   -75976.5878512571     
 iteration           10 MCMCOBJ=   -76207.3230193192     
 iteration           20 MCMCOBJ=   -76313.0402256869     
 iteration           30 MCMCOBJ=   -76163.9911373151     
 iteration           40 MCMCOBJ=   -76167.6548675871     
 iteration           50 MCMCOBJ=   -75976.4443962737     
 iteration           60 MCMCOBJ=   -76097.4869975364     
 iteration           70 MCMCOBJ=   -76278.8936991178     
 iteration           80 MCMCOBJ=   -76353.7396731711     
 iteration           90 MCMCOBJ=   -76179.3610181024     
 iteration          100 MCMCOBJ=   -75977.7882139822     
 iteration          110 MCMCOBJ=   -76285.0976257016     
 iteration          120 MCMCOBJ=   -76004.7044861162     
 iteration          130 MCMCOBJ=   -76245.3772545071     
 iteration          140 MCMCOBJ=   -76021.2480676614     
 iteration          150 MCMCOBJ=   -76210.1635739754     
 iteration          160 MCMCOBJ=   -76048.9012001155     
 iteration          170 MCMCOBJ=   -76336.4814385712     
 iteration          180 MCMCOBJ=   -76169.8800548587     
 iteration          190 MCMCOBJ=   -76167.1614091637     
 iteration          200 MCMCOBJ=   -76051.3235751035     
 iteration          210 MCMCOBJ=   -76000.7644624000     
 iteration          220 MCMCOBJ=   -76148.9384517878     
 iteration          230 MCMCOBJ=   -76259.5320693844     
 iteration          240 MCMCOBJ=   -76311.8891446268     
 iteration          250 MCMCOBJ=   -76248.3228037628     
 iteration          260 MCMCOBJ=   -76232.0079109950     
 iteration          270 MCMCOBJ=   -76086.0818262852     
 iteration          280 MCMCOBJ=   -76331.6033038580     
 iteration          290 MCMCOBJ=   -76236.7289465763     
 iteration          300 MCMCOBJ=   -76205.0273609367     
 iteration          310 MCMCOBJ=   -76262.5132484754     
 iteration          320 MCMCOBJ=   -76186.5760031439     
 iteration          330 MCMCOBJ=   -76180.5341779562     
 iteration          340 MCMCOBJ=   -76262.6896622747     
 iteration          350 MCMCOBJ=   -76092.6044748318     
 iteration          360 MCMCOBJ=   -76178.7590956158     
 iteration          370 MCMCOBJ=   -76340.8890235775     
 iteration          380 MCMCOBJ=   -76157.0853146399     
 iteration          390 MCMCOBJ=   -76182.9759905370     
 iteration          400 MCMCOBJ=   -76261.4848151059     
 iteration          410 MCMCOBJ=   -75958.4049571920     
 iteration          420 MCMCOBJ=   -76151.3684842526     
 iteration          430 MCMCOBJ=   -76242.9735532071     
 iteration          440 MCMCOBJ=   -76036.1095412056     
 iteration          450 MCMCOBJ=   -76394.5542162295     
 iteration          460 MCMCOBJ=   -76230.8419475004     
 iteration          470 MCMCOBJ=   -76144.3184102459     
 iteration          480 MCMCOBJ=   -76296.8048931625     
 iteration          490 MCMCOBJ=   -76254.5004669008     
 iteration          500 MCMCOBJ=   -76132.2640905681     
 iteration          510 MCMCOBJ=   -76043.7108359980     
 iteration          520 MCMCOBJ=   -76247.7111248924     
 iteration          530 MCMCOBJ=   -76067.0149820148     
 iteration          540 MCMCOBJ=   -76025.4536418285     
 iteration          550 MCMCOBJ=   -76038.1559028641     
 iteration          560 MCMCOBJ=   -76298.8416323111     
 iteration          570 MCMCOBJ=   -76306.3972308968     
 iteration          580 MCMCOBJ=   -76164.6942692421     
 iteration          590 MCMCOBJ=   -76269.1922171167     
 iteration          600 MCMCOBJ=   -76039.8287977145     
 iteration          610 MCMCOBJ=   -76356.3111330537     
 iteration          620 MCMCOBJ=   -76175.5921933109     
 iteration          630 MCMCOBJ=   -75992.3775965916     
 iteration          640 MCMCOBJ=   -76063.0466113566     
 iteration          650 MCMCOBJ=   -76346.0206351218     
 iteration          660 MCMCOBJ=   -76161.4652998103     
 iteration          670 MCMCOBJ=   -76354.7669236868     
 iteration          680 MCMCOBJ=   -76142.4464754154     
 iteration          690 MCMCOBJ=   -76256.7885239408     
 iteration          700 MCMCOBJ=   -76014.8238135125     
 iteration          710 MCMCOBJ=   -76163.9475184248     
 iteration          720 MCMCOBJ=   -75984.5852562576     
 iteration          730 MCMCOBJ=   -76220.5956329885     
 iteration          740 MCMCOBJ=   -76106.2042621181     
 iteration          750 MCMCOBJ=   -76219.2697584705     
 iteration          760 MCMCOBJ=   -76031.1133195841     
 iteration          770 MCMCOBJ=   -76229.0163419763     
 iteration          780 MCMCOBJ=   -76319.3563944724     
 iteration          790 MCMCOBJ=   -76262.2263836574     
 iteration          800 MCMCOBJ=   -76293.9952219783     
 iteration          810 MCMCOBJ=   -76099.5102570243     
 iteration          820 MCMCOBJ=   -76255.0008760218     
 iteration          830 MCMCOBJ=   -76177.5059704114     
 iteration          840 MCMCOBJ=   -76328.5623193363     
 iteration          850 MCMCOBJ=   -76132.3920506764     
 iteration          860 MCMCOBJ=   -76155.5949275112     
 iteration          870 MCMCOBJ=   -76131.8219287817     
 iteration          880 MCMCOBJ=   -76296.3109587577     
 iteration          890 MCMCOBJ=   -76201.0828914329     
 iteration          900 MCMCOBJ=   -76123.6973004633     
 iteration          910 MCMCOBJ=   -76024.8544474167     
 iteration          920 MCMCOBJ=   -76128.1761564965     
 iteration          930 MCMCOBJ=   -76351.7587313481     
 iteration          940 MCMCOBJ=   -76179.3923540980     
 iteration          950 MCMCOBJ=   -76272.8887757625     
 iteration          960 MCMCOBJ=   -76161.2036328281     
 iteration          970 MCMCOBJ=   -76236.0392501829     
 iteration          980 MCMCOBJ=   -76095.6999134938     
 iteration          990 MCMCOBJ=   -76156.4729806846     
 iteration         1000 MCMCOBJ=   -76277.7119000570     
 
 #TERM:
 BURN-IN WAS COMPLETED
 STATISTICAL PORTION WAS COMPLETED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.3143E-03 -2.6105E-04  6.2950E-18  8.2823E-18  1.4770E-03  1.7965E-05
 SE:             1.6278E-03  1.7066E-03  9.9855E-03  1.0727E-02  6.2430E-02  5.5668E-02
 N:                    2500        2500         250         250          25          25
 
 P VAL.:         4.1945E-01  8.7842E-01  1.0000E+00  1.0000E+00  9.8112E-01  9.9974E-01
 
 ETASHRINKSD(%)  1.2945E+01  1.2718E+01  1.2854E+00  1.0779E+00  5.7601E+00  7.5513E+00
 ETASHRINKVR(%)  2.4215E+01  2.3819E+01  2.5543E+00  2.1442E+00  1.1188E+01  1.4532E+01
 EBVSHRINKSD(%)  1.2881E+01  1.2569E+01  5.4099E-01  4.2202E-01  1.7222E-02  1.6327E-02
 EBVSHRINKVR(%)  2.4102E+01  2.3557E+01  1.0791E+00  8.4225E-01  3.4440E-02  3.2652E-02
 RELATIVEINF(%)  7.5608E+01  7.6153E+01  9.8907E+01  9.9147E+01  9.9963E+01  9.9965E+01
 EPSSHRINKSD(%)  1.1929E+01
 EPSSHRINKVR(%)  2.2436E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):        17500
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    32162.8486621635     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -76172.9916010688     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -44010.1429389052     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          5548
 NIND*NETA*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    10196.5419644385     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -76172.9916010688     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -65976.4496366303     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 PRIOR CONSTANT TO OBJECTIVE FUNCTION:    48.5256320203051     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -76172.9916010688     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -76124.4659690485     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:  1985.62
 Elapsed covariance  time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 #OBJT:**************                       AVERAGE VALUE OF LIKELIHOOD FUNCTION                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -76172.992       **************************************************
 #OBJS:********************************************      114.655 (STD) **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         1.99E+00  3.63E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        8.74E-03
 
 ETA2
+       -4.21E-05  9.56E-03
 
 ETA3
+        0.00E+00  0.00E+00  2.56E-02
 
 ETA4
+        0.00E+00  0.00E+00  1.24E-03  2.94E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.14E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.06E-02  9.44E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.35E-02
 
 ETA2
+       -4.68E-03  9.77E-02
 
 ETA3
+        0.00E+00  0.00E+00  1.60E-01
 
 ETA4
+        0.00E+00  0.00E+00  4.49E-02  1.71E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.34E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.92E-01  3.04E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************                STANDARD ERROR OF ESTIMATE (From Sample Variance)               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         6.89E-02  5.96E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        3.09E-04
 
 ETA2
+        2.31E-04  3.52E-04
 
 ETA3
+        0.00E+00  0.00E+00  2.35E-03
 
 ETA4
+        0.00E+00  0.00E+00  1.77E-03  2.66E-03
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.46E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.21E-02  2.88E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.37E-04
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.65E-03
 
 ETA2
+        2.53E-02  1.80E-03
 
 ETA3
+        0.00E+00  0.00E+00  7.32E-03
 
 ETA4
+        0.00E+00  0.00E+00  6.43E-02  7.71E-03
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.90E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.86E-01  4.40E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        6.86E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************               COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        4.75E-03
 
 TH 2
+       -8.85E-04  3.55E-03
 
 OM11
+       -1.04E-08  2.93E-07  9.53E-08
 
 OM12
+        2.95E-07 -5.29E-07  7.76E-09  5.35E-08
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -6.24E-07  6.62E-07  6.01E-10  3.56E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.24E-07
 
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
+       -4.19E-06  9.53E-08 -4.72E-09 -3.82E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.99E-08  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  5.52E-06
 
 OM34
+        4.38E-07  2.11E-06  3.23E-08  1.37E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.90E-08  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  3.21E-07  3.15E-06
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+        1.37E-05 -4.99E-06 -5.57E-09 -3.22E-10  0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.08E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -7.86E-08  3.89E-07  0.00E+00  0.00E+00  7.06E-06
 
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
+       -4.54E-05  2.78E-05 -5.58E-07  8.00E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.42E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -1.84E-06  1.17E-06  0.00E+00  0.00E+00  2.78E-06  0.00E+00  0.00E+00  1.20E-03
 
 OM56
+       -7.44E-05 -2.54E-05 -1.81E-08 -2.53E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.75E-08  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -2.71E-07 -1.01E-06  0.00E+00  0.00E+00  4.27E-08  0.00E+00  0.00E+00 -2.63E-04  4.90E-04
 
 OM66
+        8.04E-05  8.82E-05 -3.01E-09  2.18E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.89E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -2.14E-06 -3.20E-06  0.00E+00  0.00E+00  3.93E-06  0.00E+00  0.00E+00  8.16E-05 -2.12E-04  8.30E-04
 
 SG11
+       -1.59E-07  2.60E-07 -3.74E-09 -2.41E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -4.82E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  9.14E-09  2.97E-09  0.00E+00  0.00E+00 -3.70E-09  0.00E+00  0.00E+00  4.62E-10  3.41E-08  1.31E-08  1.88E-08
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************              CORRELATION MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        6.89E-02
 
 TH 2
+       -2.15E-01  5.96E-02
 
 OM11
+       -4.91E-04  1.59E-02  3.09E-04
 
 OM12
+        1.85E-02 -3.84E-02  1.09E-01  2.31E-04
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.57E-02  3.16E-02  5.53E-03  4.37E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.52E-04
 
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
+       -2.59E-02  6.81E-04 -6.52E-03 -7.04E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.41E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.35E-03
 
 OM34
+        3.59E-03  2.00E-02  5.89E-02  3.34E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.05E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  7.69E-02  1.77E-03
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+        7.50E-02 -3.15E-02 -6.80E-03 -5.24E-04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.51E-03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -1.26E-02  8.26E-02  0.00E+00  0.00E+00  2.66E-03
 
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
+       -1.90E-02  1.35E-02 -5.22E-02  9.98E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.81E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -2.26E-02  1.91E-02  0.00E+00  0.00E+00  3.02E-02  0.00E+00  0.00E+00  3.46E-02
 
 OM56
+       -4.88E-02 -1.93E-02 -2.65E-03 -4.93E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.10E-03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -5.22E-03 -2.57E-02  0.00E+00  0.00E+00  7.27E-04  0.00E+00  0.00E+00 -3.43E-01  2.21E-02
 
 OM66
+        4.05E-02  5.14E-02 -3.39E-04  3.26E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.84E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -3.16E-02 -6.26E-02  0.00E+00  0.00E+00  5.13E-02  0.00E+00  0.00E+00  8.17E-02 -3.33E-01  2.88E-02
 
 SG11
+       -1.68E-02  3.18E-02 -8.81E-02 -7.58E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -9.99E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.84E-02  1.22E-02  0.00E+00  0.00E+00 -1.01E-02  0.00E+00  0.00E+00  9.73E-05  1.12E-02  3.31E-03  1.37E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************           INVERSE COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        2.23E+02
 
 TH 2
+        5.54E+01  2.98E+02
 
 OM11
+        3.89E+01 -1.21E+03  1.08E+07
 
 OM12
+       -3.51E+02  3.05E+03 -1.46E+06  1.92E+07
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        9.78E+02 -1.42E+03  1.05E+05 -4.91E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00  8.23E+06
 
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
+        1.60E+02  7.11E+01  4.03E+03  1.35E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.39E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.84E+05
 
 OM34
+       -5.49E+01 -2.54E+02 -1.09E+05 -8.51E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -5.22E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -1.90E+04  3.26E+05
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -3.89E+02  1.36E+02  1.22E+04  1.17E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -4.62E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.43E+03 -1.93E+04  0.00E+00  0.00E+00  1.44E+05
 
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
+        1.84E+01 -1.54E+00  5.75E+03  1.59E+02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.39E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  3.77E+02 -2.05E+02  0.00E+00  0.00E+00 -4.20E+02  0.00E+00  0.00E+00  9.53E+02
 
 OM56
+        3.86E+01  8.79E+00  2.32E+03  8.56E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.01E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  5.69E+02  1.24E+03  0.00E+00  0.00E+00 -7.00E+02  0.00E+00  0.00E+00  5.33E+02  2.61E+03
 
 OM66
+       -1.78E+01 -3.62E+01  2.43E+01 -2.99E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -4.72E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  4.57E+02  1.72E+03  0.00E+00  0.00E+00 -8.67E+02  0.00E+00  0.00E+00  4.19E+01  6.19E+02  1.38E+03
 
 SG11
+        1.13E+03 -3.81E+03  2.00E+06  1.93E+06  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.12E+06  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -7.75E+04 -9.22E+04  0.00E+00  0.00E+00  2.96E+04  0.00E+00  0.00E+00  7.00E+02 -4.53E+03 -3.98E+03  5.44E+07
 
 SKIPPING EXECUTION OF SLOW FNLMOD/FNLETA BY USER REQUEST
 Elapsed postprocess time in seconds:     0.05
 Elapsed finaloutput time in seconds:     1.33
 #CPUT: Total CPU Time in Seconds,     2082.988
Stop Time: 
Thu 12/12/2019 
06:55 PM
