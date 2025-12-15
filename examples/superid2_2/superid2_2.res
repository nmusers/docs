Thu 12/12/2019 
05:31 PM
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
0.03
0.00001 0.03

$OMEGA BLOCK(2)
0.03
0.00001 0.03

$OMEGA BLOCK(2)
0.03
0.00001 0.03

$SIGMA 
0.05

$LEVEL
SID=(3[1],4[2])
CID=(5[3],6[4])

$EST METHOD=ITS INTERACTION PRINT=1 NSIG=3 NITER=4 SIGL=6 FNLETA=0 MCETA=3
     LEVCENTER=0
$EST METHOD=IMP INTERACTION PRINT=1 NSIG=3 NITER=50 CTYPE=3 ISAMPLE=300 SIGL=6 FNLETA=0 NOABORT MCETA=3
$COV MATRIX=R UNCONDITIONAL
$TABLE  ID TIME CONC DOSE RATE EVID MDV CMT SID CID ETA1 ETA2 ETA3 ETA4 ETA5 ETA6
NOAPPEND ONEHEADER FILE=superid2_2.tab  NOPRINT
  
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
                  0.3000E-01
                  0.1000E-04   0.3000E-01
        2                                                                                   NO
                  0.3000E-01
                  0.1000E-04   0.3000E-01
        3                                                                                   NO
                  0.3000E-01
                  0.1000E-04   0.3000E-01
0INITIAL ESTIMATE OF SIGMA:
 0.5000E-01
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
 RAW OUTPUT FILE (FILE): superid2_2.ext
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
 ITERATIONS (NITER):                        4
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

 iteration            0 OBJ=   106639.360291286
 iteration            1 OBJ=  -22330.0809609037
 iteration            2 OBJ=  -29075.0757471278
 iteration            3 OBJ=  -34725.4403304900
 iteration            4 OBJ=  -39624.3127224652
 
 #TERM:
 OPTIMIZATION WAS NOT TESTED FOR CONVERGENCE


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -2.2809E-03 -1.1301E-03 -7.6383E-18 -1.2357E-17 -2.3360E-02 -1.3881E-02
 SE:             1.4565E-03  1.4200E-03  9.5756E-03  1.0357E-02  5.9875E-02  5.3947E-02
 N:                    2500        2500         250         250          25          25
 
 P VAL.:         1.1733E-01  4.2613E-01  1.0000E+00  1.0000E+00  6.9643E-01  7.9695E-01
 
 ETASHRINKSD(%)  2.4959E+01  2.7189E+01  1.0000E-10  1.0000E-10  1.0000E-10  1.0000E-10
 ETASHRINKVR(%)  4.3688E+01  4.6986E+01  1.0000E-10  1.0000E-10  1.0000E-10  1.0000E-10
 EBVSHRINKSD(%)  1.7799E+01  2.0177E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  3.2430E+01  3.6283E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  6.8036E+01  6.4048E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  3.4087E+01
 EPSSHRINKVR(%)  5.6555E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):        17500
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    32162.8486621635     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -39624.3127224652     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -7461.46406030163     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          5548
  
 #TERE:
 Elapsed estimation  time in seconds:    18.99
 Elapsed covariance  time in seconds:     0.49
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -39624.313       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         2.04E+00  3.65E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.42E-03
 
 ETA2
+        1.78E-03  9.51E-03
 
 ETA3
+        0.00E+00  0.00E+00  2.15E-02
 
 ETA4
+        0.00E+00  0.00E+00  1.08E-03  2.46E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  8.78E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.71E-02  7.02E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        2.09E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.70E-02
 
 ETA2
+        1.88E-01  9.75E-02
 
 ETA3
+        0.00E+00  0.00E+00  1.47E-01
 
 ETA4
+        0.00E+00  0.00E+00  4.71E-02  1.57E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.96E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.18E-01  2.65E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.44E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                          STANDARD ERROR OF ESTIMATE (S)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         6.52E-02  5.95E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        4.80E-04
 
 ETA2
+        3.71E-04  5.26E-04
 
 ETA3
+        0.00E+00  0.00E+00  1.71E-03
 
 ETA4
+        0.00E+00  0.00E+00  1.34E-03  1.93E-03
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.84E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.15E-02  2.34E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.05E-04
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        2.47E-03
 
 ETA2
+        3.47E-02  2.70E-03
 
 ETA3
+       ......... .........  5.82E-03
 
 ETA4
+       ......... .........  5.86E-02  6.16E-03
 
 ETA5
+       ......... ......... ......... .........  4.79E-02
 
 ETA6
+       ......... ......... ......... .........  2.40E-01  4.42E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.06E-03
 
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
+        4.25E-03
 
 TH 2
+       -5.98E-04  3.54E-03
 
 OM11
+       -3.52E-07  7.56E-07  2.30E-07
 
 OM12
+        7.34E-07 -4.78E-07  9.83E-08  1.37E-07
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        9.60E-07  4.85E-07  2.00E-08  8.47E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.77E-07
 
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
+        1.11E-06  1.92E-05  2.28E-08  7.55E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.10E-08  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.92E-06
 
 OM34
+        8.19E-06  1.97E-06 -1.45E-08 -1.85E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.65E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -1.49E-07  1.80E-06
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -1.72E-06  3.20E-06  1.21E-08  6.41E-10  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.71E-08  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -2.92E-08 -4.68E-08  0.00E+00  0.00E+00  3.73E-06
 
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
+        7.72E-05  4.40E-04  4.08E-08 -7.46E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.62E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  6.90E-06  1.49E-06  0.00E+00  0.00E+00  3.37E-06  0.00E+00  0.00E+00  8.06E-04
 
 OM56
+        4.05E-04 -2.02E-04 -2.30E-08  1.20E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.20E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -4.06E-06  1.70E-06  0.00E+00  0.00E+00 -1.24E-06  0.00E+00  0.00E+00 -4.13E-04  4.62E-04
 
 OM66
+       -1.07E-04  5.78E-04  7.50E-10 -2.27E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -6.34E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.52E-06 -2.75E-06  0.00E+00  0.00E+00  1.13E-06  0.00E+00  0.00E+00  2.00E-04 -1.91E-04  5.48E-04
 
 SG11
+       -1.30E-06  6.08E-07 -2.95E-08 -2.83E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.38E-08  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.56E-08 -3.88E-09  0.00E+00  0.00E+00  3.11E-08  0.00E+00  0.00E+00  5.71E-07 -4.44E-07  7.09E-07  9.33E-08
 
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
+        6.52E-02
 
 TH 2
+       -1.54E-01  5.95E-02
 
 OM11
+       -1.12E-02  2.65E-02  4.80E-04
 
 OM12
+        3.04E-02 -2.17E-02  5.53E-01  3.71E-04
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        2.80E-02  1.55E-02  7.94E-02  4.34E-01  0.00E+00  0.00E+00  0.00E+00  0.00E+00  5.26E-04
 
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
+        1.00E-02  1.89E-01  2.78E-02  1.19E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.22E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.71E-03
 
 OM34
+        9.35E-02  2.47E-02 -2.25E-02 -3.73E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  9.41E-03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -6.51E-02  1.34E-03
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -1.36E-02  2.78E-02  1.30E-02  8.95E-04  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.68E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -8.84E-03 -1.80E-02  0.00E+00  0.00E+00  1.93E-03
 
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
+        4.17E-02  2.61E-01  3.00E-03 -7.09E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.75E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.42E-01  3.91E-02  0.00E+00  0.00E+00  6.14E-02  0.00E+00  0.00E+00  2.84E-02
 
 OM56
+        2.89E-01 -1.58E-01 -2.24E-03  1.51E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.95E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -1.11E-01  5.90E-02  0.00E+00  0.00E+00 -2.99E-02  0.00E+00  0.00E+00 -6.77E-01  2.15E-02
 
 OM66
+       -7.04E-02  4.15E-01  6.69E-05 -2.62E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -5.15E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  6.32E-02 -8.75E-02  0.00E+00  0.00E+00  2.50E-02  0.00E+00  0.00E+00  3.02E-01 -3.79E-01  2.34E-02
 
 SG11
+       -6.53E-02  3.34E-02 -2.01E-01 -2.50E-01  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.10E-01  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.99E-02 -9.47E-03  0.00E+00  0.00E+00  5.27E-02  0.00E+00  0.00E+00  6.58E-02 -6.77E-02  9.92E-02  3.05E-04
 
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
+        3.10E+02
 
 TH 2
+        8.32E+01  3.92E+02
 
 OM11
+        1.15E+03 -2.28E+03  6.67E+06
 
 OM12
+       -9.39E+02  4.09E+03 -5.38E+06  1.36E+07
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -6.64E+02 -2.86E+03  1.28E+06 -3.67E+06  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.78E+06
 
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
+       -6.43E+02 -2.14E+03 -2.58E+04 -2.77E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.44E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  3.64E+05
 
 OM34
+       -8.69E+02 -1.05E+03 -9.23E+03  1.11E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.15E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  3.67E+04  5.75E+05
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+        1.67E+02 -9.03E+01 -2.13E+04 -1.07E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  9.38E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  6.83E+03  8.54E+03  0.00E+00  0.00E+00  2.70E+05
 
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
+       -3.46E+02 -2.66E+02  4.10E+02 -3.50E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.50E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -1.20E+03 -3.06E+03  0.00E+00  0.00E+00 -1.58E+03  0.00E+00  0.00E+00  2.83E+03
 
 OM56
+       -5.89E+02 -3.23E+02  4.79E+02 -3.79E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.01E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.40E+03 -2.63E+03  0.00E+00  0.00E+00 -9.51E+02  0.00E+00  0.00E+00  2.77E+03  5.50E+03
 
 OM66
+       -1.14E+02 -4.12E+02  7.43E+02 -3.86E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  5.83E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.00E+03  3.85E+03  0.00E+00  0.00E+00 -5.05E+01  0.00E+00  0.00E+00  1.47E+02  1.12E+03  2.61E+03
 
 SG11
+        3.81E+03  1.65E+03  9.82E+05  1.11E+06  0.00E+00  0.00E+00  0.00E+00  0.00E+00  9.89E+05  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -6.08E+04  5.93E+03  0.00E+00  0.00E+00 -8.89E+04  0.00E+00  0.00E+00 -7.77E+03 -5.09E+03 -1.33E+04  1.19E+07
 
1
 
 
 #TBLN:      2
 #METH: Importance Sampling
 
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
 RAW OUTPUT FILE (FILE): superid2_2.ext
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
 EM OR BAYESIAN METHOD USED:                IMPORTANCE SAMPLING (IMP)
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          1
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 ITERATIONS (NITER):                        50
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
 MC SAMPLES PER SUBJECT (ISAMPLE):          300
 RANDOM SAMPLING METHOD (RANMETHOD):        3U
 EXPECTATION ONLY (EONLY):                  0
 PROPOSAL DENSITY SCALING RANGE
              (ISCALE_MIN, ISCALE_MAX):     0.100000000000000       ,10.0000000000000
 SAMPLE ACCEPTANCE RATE (IACCEPT):          0.400000000000000
 LONG TAIL SAMPLE ACCEPT. RATE (IACCEPTL):   0.00000000000000
 T-DIST. PROPOSAL DENSITY (DF):             0
 NO. ITERATIONS FOR MAP (MAPITER):          1
 INTERVAL ITER. FOR MAP (MAPINTER):         0
 MAP COVARIANCE/MODE SETTING (MAPCOV):      1
 Gradient Quick Value (GRDQ):               0.00000000000000

 
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

 iteration            0 OBJ=  -39621.4177488188 eff.=     302. Smpl.=     300. Fit.= 0.97732
 iteration            1 OBJ=  -42354.2370219864 eff.=      77. Smpl.=     300. Fit.= 0.72611
 iteration            2 OBJ=  -42438.4612266081 eff.=     174. Smpl.=     300. Fit.= 0.86844
 iteration            3 OBJ=  -42440.3739926160 eff.=     133. Smpl.=     300. Fit.= 0.80909
 iteration            4 OBJ=  -42443.4178380578 eff.=     118. Smpl.=     300. Fit.= 0.78560
 iteration            5 OBJ=  -42444.5768418082 eff.=     120. Smpl.=     300. Fit.= 0.78859
 iteration            6 OBJ=  -42442.0626538553 eff.=     120. Smpl.=     300. Fit.= 0.78881
 iteration            7 OBJ=  -42436.4329920486 eff.=     120. Smpl.=     300. Fit.= 0.78877
 iteration            8 OBJ=  -42438.6309974882 eff.=     120. Smpl.=     300. Fit.= 0.78899
 iteration            9 OBJ=  -42442.7696923600 eff.=     120. Smpl.=     300. Fit.= 0.78950
 iteration           10 OBJ=  -42438.9314939620 eff.=     120. Smpl.=     300. Fit.= 0.78959
 iteration           11 OBJ=  -42446.2482377669 eff.=     121. Smpl.=     300. Fit.= 0.78921
 Convergence achieved
 iteration           11 OBJ=  -42440.6225876104 eff.=     120. Smpl.=     300. Fit.= 0.78913
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.4764E-03 -2.4171E-04  1.7242E-17 -2.2438E-17 -2.2349E-04  5.9169E-06
 SE:             1.6223E-03  1.6965E-03  9.9755E-03  1.0720E-02  6.2375E-02  5.5626E-02
 N:                    2500        2500         250         250          25          25
 
 P VAL.:         3.6276E-01  8.8670E-01  1.0000E+00  1.0000E+00  9.9714E-01  9.9992E-01
 
 ETASHRINKSD(%)  1.2200E+01  1.2059E+01  1.0000E-10  1.0000E-10  3.6245E-03  1.0000E-10
 ETASHRINKVR(%)  2.2912E+01  2.2664E+01  1.0000E-10  1.0000E-10  7.2488E-03  1.0000E-10
 EBVSHRINKSD(%)  1.2166E+01  1.1901E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  2.2852E+01  2.2385E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  7.6851E+01  7.7316E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  1.1694E+01
 EPSSHRINKVR(%)  2.2021E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):        17500
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    32162.8486621635     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -42440.6225876104     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -10277.7739254469     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          5548
  
 #TERE:
 Elapsed estimation  time in seconds:   321.45
 Elapsed covariance  time in seconds:    28.85
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -42440.623       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         1.99E+00  3.63E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        8.53E-03
 
 ETA2
+       -1.01E-04  9.30E-03
 
 ETA3
+        0.00E+00  0.00E+00  2.48E-02
 
 ETA4
+        0.00E+00  0.00E+00  1.13E-03  2.87E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.01E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.81E-02  8.05E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.24E-02
 
 ETA2
+       -1.14E-02  9.65E-02
 
 ETA3
+        0.00E+00  0.00E+00  1.58E-01
 
 ETA4
+        0.00E+00  0.00E+00  4.24E-02  1.69E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.18E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.00E-01  2.84E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                          STANDARD ERROR OF ESTIMATE (R)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         6.93E-02  6.33E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        3.10E-04
 
 ETA2
+        2.33E-04  3.44E-04
 
 ETA3
+        0.00E+00  0.00E+00  2.12E-03
 
 ETA4
+        0.00E+00  0.00E+00  1.68E-03  2.45E-03
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.24E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.46E-02  2.72E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.26E-04
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.68E-03
 
 ETA2
+        2.62E-02  1.78E-03
 
 ETA3
+       ......... .........  6.73E-03
 
 ETA4
+       ......... .........  6.30E-02  7.22E-03
 
 ETA5
+       ......... ......... ......... .........  5.09E-02
 
 ETA6
+       ......... ......... ......... .........  2.45E-01  4.79E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        6.30E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (R)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        4.80E-03
 
 TH 2
+       -6.92E-04  4.01E-03
 
 OM11
+       -3.36E-07  5.06E-07  9.62E-08
 
 OM12
+        3.21E-08 -1.64E-07  6.48E-09  5.43E-08
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        1.07E-06  5.32E-08 -4.28E-11  5.08E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.18E-07
 
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
+        5.09E-06  2.17E-05  1.78E-08  3.53E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -7.44E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  4.50E-06
 
 OM34
+        5.58E-06  6.45E-06 -5.76E-09 -1.69E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00  9.56E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -2.41E-07  2.81E-06
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -1.97E-06  2.40E-06  1.28E-08  4.30E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -8.26E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -7.84E-08 -1.55E-09  0.00E+00  0.00E+00  5.99E-06
 
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
+        4.72E-05  5.26E-04  1.29E-07 -1.77E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.95E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  7.31E-06  3.22E-06  0.00E+00  0.00E+00  3.64E-06  0.00E+00  0.00E+00  1.05E-03
 
 OM56
+        4.28E-04 -2.66E-04 -7.52E-08  1.12E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.65E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -4.22E-06  1.67E-06  0.00E+00  0.00E+00 -8.66E-07  0.00E+00  0.00E+00 -4.95E-04  6.04E-04
 
 OM66
+       -8.03E-05  5.45E-04 -9.69E-09 -1.24E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -4.78E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.76E-06 -3.56E-06  0.00E+00  0.00E+00  1.59E-07  0.00E+00  0.00E+00  2.03E-04 -2.01E-04  7.39E-04
 
 SG11
+        4.05E-08  5.42E-08 -3.09E-09 -1.18E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.99E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.42E-09  2.98E-10  0.00E+00  0.00E+00 -1.24E-09  0.00E+00  0.00E+00 -9.15E-08  2.29E-08  5.18E-09  1.59E-08
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (R)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        6.93E-02
 
 TH 2
+       -1.58E-01  6.33E-02
 
 OM11
+       -1.57E-02  2.58E-02  3.10E-04
 
 OM12
+        1.99E-03 -1.11E-02  8.96E-02  2.33E-04
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        4.49E-02  2.44E-03 -4.01E-04  6.34E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.44E-04
 
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
+        3.47E-02  1.62E-01  2.70E-02  7.15E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.02E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.12E-03
 
 OM34
+        4.80E-02  6.08E-02 -1.11E-02 -4.34E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.66E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -6.77E-02  1.68E-03
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -1.16E-02  1.55E-02  1.69E-02  7.54E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -9.81E-03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -1.51E-02 -3.79E-04  0.00E+00  0.00E+00  2.45E-03
 
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
+        2.11E-02  2.57E-01  1.28E-02 -2.35E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.65E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.06E-01  5.93E-02  0.00E+00  0.00E+00  4.60E-02  0.00E+00  0.00E+00  3.24E-02
 
 OM56
+        2.52E-01 -1.71E-01 -9.86E-03  1.96E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.95E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -8.11E-02  4.05E-02  0.00E+00  0.00E+00 -1.44E-02  0.00E+00  0.00E+00 -6.22E-01  2.46E-02
 
 OM66
+       -4.26E-02  3.17E-01 -1.15E-03 -1.97E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -5.11E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  3.05E-02 -7.80E-02  0.00E+00  0.00E+00  2.40E-03  0.00E+00  0.00E+00  2.31E-01 -3.01E-01  2.72E-02
 
 SG11
+        4.63E-03  6.79E-03 -7.89E-02 -4.01E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -9.19E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  9.07E-03  1.41E-03  0.00E+00  0.00E+00 -4.01E-03  0.00E+00  0.00E+00 -2.24E-02  7.39E-03  1.51E-03  1.26E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (R)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        2.47E+02
 
 TH 2
+        5.53E+01  3.11E+02
 
 OM11
+        5.28E+02 -1.25E+03  1.06E+07
 
 OM12
+        5.49E+02  6.57E+02 -1.22E+06  1.87E+07
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.55E+03 -1.85E+03  1.18E+05 -7.81E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00  8.62E+06
 
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
+       -5.61E+02 -1.38E+03 -3.55E+04 -1.00E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.86E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.33E+05
 
 OM34
+       -3.37E+02 -9.58E+02  1.42E+04  1.20E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.30E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.54E+04  3.69E+05
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+        1.07E+02 -4.07E+01 -2.08E+04 -1.06E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.05E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  4.06E+03  1.58E+03  0.00E+00  0.00E+00  1.68E+05
 
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
+       -1.72E+02 -1.56E+02 -3.04E+02 -3.66E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.56E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -6.39E+02 -2.29E+03  0.00E+00  0.00E+00 -8.47E+02  0.00E+00  0.00E+00  1.76E+03
 
 OM56
+       -3.12E+02 -1.08E+02  3.81E+02 -6.28E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.80E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.17E+03 -2.10E+03  0.00E+00  0.00E+00 -4.92E+02  0.00E+00  0.00E+00  1.50E+03  3.25E+03
 
 OM66
+       -5.35E+01 -2.12E+02  1.32E+03  2.10E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.42E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.03E+03  2.45E+03  0.00E+00  0.00E+00  1.07E+02  0.00E+00  0.00E+00  1.46E+01  5.06E+02  1.65E+03
 
 SG11
+       -1.73E+03 -2.30E+03  1.99E+06  9.35E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.15E+06  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -3.82E+04 -1.16E+04  0.00E+00  0.00E+00  5.88E+03  0.00E+00  0.00E+00  9.82E+03  5.61E+03  1.50E+03  6.39E+07
 
 SKIPPING EXECUTION OF SLOW FNLMOD/FNLETA BY USER REQUEST
 Elapsed postprocess time in seconds:     0.00
 Elapsed finaloutput time in seconds:     1.34
 #CPUT: Total CPU Time in Seconds,      368.240
Stop Time: 
Thu 12/12/2019 
05:37 PM
