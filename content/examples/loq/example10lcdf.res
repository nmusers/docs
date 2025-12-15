Wed 12/06/2017 
12:34 PM
$PROB  F_FLAG04est2a.ctl
$INPUT C ID DOSE=AMT TIME DV WT TYPE
$DATA example10lcdf.csv IGNORE=@

$SUBROUTINES  ADVAN2 TRANS2


$PK
   CALLFL=1
   MU_1=THETA(1)
   KA=DEXP(MU_1+ETA(1))
   MU_2=THETA(2)
   V=DEXP(MU_2+ETA(2))
   MU_3=THETA(3)
   CL=DEXP(MU_3+ETA(3))
   SC=V/1000

$THETA  1.6 2.3 0.7 0.1 0.1

$OMEGA BLOCK (3)
0.5
0.01 0.5
0.01 0.01 0.5


; Because THETA(4) and THETA(5) have no inter-subject variability 
; associated with them, the algorithm must use a more computationally 
; expensive gradient evaluation for these two parameters

$SIGMA 0.1


$PRIOR NWPRI
; Priors to Omegas
$OMEGAP BLOCK (3)
0.09 FIX
0.0 0.09
0.0 0.0 0.09
$OMEGAPD (3 FIX)


$ERROR
EXCL2=1.0-TYPE
EXCL=TYPE
EXCL3=0.0
IF(EVID/=0) EXCL=1.0
IF(EVID/=0) EXCL2=1.0
IF(EVID/=0) EXCL3=1.0
    EXPP=THETA(4)+F*THETA(5)
IPRED=F
; Use protected exponent PEXP, to avoid numerical overflow
A=PEXP(EXPP)
B=1.0+A
IF (TYPE.EQ.0.OR.NPDE_MODE==1) THEN
; PK Data
    F_FLAG=0
    Y=F+F*ERR(1) ; a prediction
 ELSE
; Categorical data
    F_FLAG=1
    Y=DV*A/B+(1.0-DV)/B      ; a likelihood
    MDVRES=1
 ENDIF
IF(TYPE==1)  THEN
CDF_L=(1.0-DV)*1.0/B + DV
CDF_LA=DV*1.0/B
DV_LOQ=DV
DV_LAQ=DV-1.0
ENDIF

$EST METHOD=ITS INTER LAP NITER=30 PRINT=5 SIGL=6 NSIG=2 NOHABORT 
     NOPRIOR=1 CTYPE=3 CITER=10 CALPHA=0.05
;$EST METHOD=COND LAP INTER MAXEVAL=9999 PRINT=1 NOPRIOR=1
$COV UNCONDITIONAL PRINT=E MATRIX=R SIGL=10
$TABLE ID TIME DV IPRED PRED RES EPRED EIPRED EIRES EIWRES CPRED CWRES ECWRES EWRES TYPE NPDE NPD CIWRES NOAPPEND ONEHEADER 
 ESAMPLE=1000 NPDTYPE=0 EXCLUDE_BY EXCL3 FILE=example10lcdf.TAB NOPRINT SEED=16993234
$TABLE ID TIME DV IPRED PRED RES EPRED EIPRED EIRES EIWRES CPRED CWRES ECWRES EWRES TYPE NPDE NPD CIWRES NOAPPEND ONEHEADER 
 ESAMPLE=1000 NPDTYPE=0 EXCLUDE_BY EXCL FILE=example10lcdf0.TAB NOPRINT SEED=16993234
$TABLE ID TIME DV IPRED PRED RES EPRED EIPRED EIRES EIWRES CPRED CWRES ECWRES EWRES TYPE NPDE NPD CIWRES NOAPPEND ONEHEADER 
 ESAMPLE=1000 NPDTYPE=0 EXCLUDE_BY EXCL2 FILE=example10lcdf1.TAB NOPRINT SEED=16993234
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  87) WITH "LAPLACIAN" AND "INTERACTION", "NUMERICAL" AND "SLOW"
 ARE ALSO REQUIRED ON $ESTIM RECORD, AND "SLOW" IS REQUIRED ON $COV
 RECORD. NM-TRAN HAS SUPPLIED THESE OPTIONS.
  
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
 F_FLAG04est2a.ctl
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:     4608
 NO. OF DATA ITEMS IN DATA SET:   9
 ID DATA ITEM IS DATA ITEM NO.:   2
 DEP VARIABLE IS DATA ITEM NO.:   5
 MDV DATA ITEM IS DATA ITEM NO.:  9
0INDICES PASSED TO SUBROUTINE PRED:
   8   4   3   0   0   0   0   0   0   0   0
0LABELS FOR DATA ITEMS:
 C ID DOSE TIME DV WT TYPE EVID MDV
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 EXCL2 EXCL EXCL3 IPRED
0FORMAT FOR DATA:
 (7E10.0,2F2.0)

 TOT. NO. OF OBS RECS:     4320
 TOT. NO. OF INDIVIDUALS:      288
0LENGTH OF THETA:   6
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS BLOCK FORM:
  1
  1  1
  1  1  1
  0  0  0  2
  0  0  0  2  2
  0  0  0  2  2  2
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
 -0.1000E+07     0.1600E+01     0.1000E+07
 -0.1000E+07     0.2300E+01     0.1000E+07
 -0.1000E+07     0.7000E+00     0.1000E+07
 -0.1000E+07     0.1000E+00     0.1000E+07
 -0.1000E+07     0.1000E+00     0.1000E+07
  0.3000E+01     0.3000E+01     0.3000E+01
0INITIAL ESTIMATE OF OMEGA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.5000E+00
                  0.1000E-01   0.5000E+00
                  0.1000E-01   0.1000E-01   0.5000E+00
        2                                                                                  YES
                  0.9000E-01
                  0.0000E+00   0.9000E-01
                  0.0000E+00   0.0000E+00   0.9000E-01
0INITIAL ESTIMATE OF SIGMA:
 0.1000E+00
0COVARIANCE STEP OMITTED:        NO
 R MATRIX SUBSTITUTED:          YES
 S MATRIX SUBSTITUTED:           NO
 EIGENVLS. PRINTED:             YES
 COMPRESSED FORMAT:              NO
 GRADIENT METHOD USED:       SLOW
 SIGDIGITS ETAHAT (SIGLO):                  -1
 SIGDIGITS GRADIENTS (SIGL):                10
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
 NO. OF TABLES:           3
 SEED NUMBER (SEED):    16993234
 RANMETHOD:             3U
 MC SAMPLES (ESAMPLE):    1000
 WRES SQUARE ROOT TYPE (WRESCHOL): EIGENVALUE
0-- TABLE   1 --
0RECORDS ONLY:    ALL
04 COLUMNS APPENDED:    NO
 PRINTED:                NO
 HEADERS:               ONE
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID TIME DV IPRED PRED RES EPRED EIPRED EIRES EIWRES CPRED CWRES ECWRES EWRES TYPE NPDE NPD CIWRES
0EXCLUDE-BY ITEMS:
 EXCL3
0-- TABLE   2 --
0RECORDS ONLY:    ALL
04 COLUMNS APPENDED:    NO
 PRINTED:                NO
 HEADERS:               ONE
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID TIME DV IPRED PRED RES EPRED EIPRED EIRES EIWRES CPRED CWRES ECWRES EWRES TYPE NPDE NPD CIWRES
0EXCLUDE-BY ITEMS:
 EXCL
0-- TABLE   3 --
0RECORDS ONLY:    ALL
04 COLUMNS APPENDED:    NO
 PRINTED:                NO
 HEADERS:               ONE
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID TIME DV IPRED PRED RES EPRED EIPRED EIRES EIWRES CPRED CWRES ECWRES EWRES TYPE NPDE NPD CIWRES
0EXCLUDE-BY ITEMS:
 EXCL2
0
 PRIOR SUBROUTINE USER-SUPPLIED
1DOUBLE PRECISION PREDPP VERSION 7.4.2

 ONE COMPARTMENT MODEL WITH FIRST-ORDER ABSORPTION (ADVAN2)
0MAXIMUM NO. OF BASIC PK PARAMETERS:   3
0BASIC PK PARAMETERS (AFTER TRANSLATION):
   ELIMINATION RATE (K) IS BASIC PK PARAMETER NO.:  1
   ABSORPTION RATE (KA) IS BASIC PK PARAMETER NO.:  3

 TRANSLATOR WILL CONVERT PARAMETERS
 CLEARANCE (CL) AND VOLUME (V) TO K (TRANS2)
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         DEPOT        OFF        YES        YES        YES        NO
    2         CENTRAL      ON         NO         YES        NO         YES
    3         OUTPUT       OFF        YES        NO         NO         NO
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            *           *           *           *           *
    2            4           *           *           *           *
    3            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      8
   TIME DATA ITEM IS DATA ITEM NO.:          4
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   3

0PK SUBROUTINE CALLED ONCE PER INDIVIDUAL RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
1
 
 
 #TBLN:      1
 #METH: Iterative Two Stage (No Prior)
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               SLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    YES
 NUMERICAL 2ND DERIVATIVES:               YES
 NO. OF FUNCT. EVALS. ALLOWED:            960
 NO. OF SIG. FIGURES REQUIRED:            2
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    0
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      6
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     6
 NOPRIOR SETTING (NOPRIOR):                 ON
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          ON
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      OFF
 RAW OUTPUT FILE (FILE): example10lcdf.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 WISHART PRIOR DF INTERPRETATION (WISHTYPE):0
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 EM OR BAYESIAN METHOD USED:                ITERATIVE TWO STAGE (ITS)
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          OFF
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          5
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 ITERATIONS (NITER):                        30
 ANEAL SETTING (CONSTRAIN):                 1

 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2   3
 THETAS THAT ARE SIGMA-LIKE:
 
 
 MONITORING OF SEARCH:

 iteration            0 OBJ=   14969.6386288861
 iteration            5 OBJ=   10045.8287347716
 iteration           10 OBJ=   10041.4423686659
 iteration           15 OBJ=   10041.4617710038
 iteration           20 OBJ=   10041.4631628218
 iteration           25 OBJ=   10041.4632274380
 iteration           30 OBJ=   10041.4632422967
 
 #TERM:
 OPTIMIZATION WAS NOT COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -1.1905E-08 -6.3847E-08 -6.4429E-08
 SE:             1.4383E-02  1.5606E-02  1.6943E-02
 N:                     288         288         288
 
 P VAL.:         1.0000E+00  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  1.6452E+01  2.8167E+00  1.6167E+00
 ETASHRINKVR(%)  3.0197E+01  5.5540E+00  3.2073E+00
 EBVSHRINKSD(%)  1.6452E+01  2.8167E+00  1.6167E+00
 EBVSHRINKVR(%)  3.0197E+01  5.5540E+00  3.2073E+00
 EPSSHRINKSD(%)  1.2873E+01
 EPSSHRINKVR(%)  2.4089E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         2880
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    5293.08595125891     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    10041.4632422967     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       15334.5491935556     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                           864
  
 #TERE:
 Elapsed estimation  time in seconds:    25.36
 Elapsed covariance  time in seconds:     0.12
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************    10041.463       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
         1.07E+00  3.39E+00  2.44E+00 -6.48E-01  8.06E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        8.56E-02
 
 ETA2
+        3.73E-03  7.45E-02
 
 ETA3
+        3.59E-02  2.99E-02  8.57E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        2.27E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        2.93E-01
 
 ETA2
+        4.67E-02  2.73E-01
 
 ETA3
+        4.19E-01  3.75E-01  2.93E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.51E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                          STANDARD ERROR OF ESTIMATE (S)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
         2.29E-02  1.67E-02  1.76E-02  9.97E-02  7.20E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        9.94E-03
 
 ETA2
+        6.31E-03  6.42E-03
 
 ETA3
+        7.19E-03  5.17E-03  7.27E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        7.73E-04
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        1.70E-02
 
 ETA2
+        7.83E-02  1.18E-02
 
 ETA3
+        6.12E-02  5.31E-02  1.24E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        2.56E-03
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (S)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM22      OM23      OM33      SG11  

 
 TH 1
+        5.25E-04
 
 TH 2
+        3.38E-05  2.79E-04
 
 TH 3
+        1.35E-04  1.18E-04  3.11E-04
 
 TH 4
+       -3.18E-05 -9.05E-05 -9.62E-05  9.94E-03
 
 TH 5
+        8.05E-06  6.45E-06  5.62E-06 -4.92E-04  5.18E-05
 
 OM11
+        7.31E-05  2.96E-06 -1.99E-06  6.36E-05 -2.34E-06  9.88E-05
 
 OM12
+        1.39E-05  5.56E-06  6.11E-06 -9.16E-05  4.25E-06  1.21E-05  3.98E-05
 
 OM13
+        2.22E-05  4.26E-06  1.78E-06 -2.13E-05  8.53E-07  5.52E-05  1.82E-05  5.17E-05
 
 OM22
+        8.18E-06 -2.54E-06  9.80E-07  3.07E-06  1.77E-06  6.27E-06  4.40E-06  5.14E-06  4.12E-05
 
 OM23
+        5.30E-06  1.20E-06  2.05E-06 -3.00E-05  3.42E-06  5.23E-06  1.49E-05  9.61E-06  1.49E-05  2.67E-05
 
 OM33
+        2.48E-06  3.15E-06  4.35E-06 -5.95E-05  1.47E-06  6.37E-06  1.21E-05  1.99E-05  3.76E-06  1.79E-05  5.29E-05
 
 SG11
+        2.19E-07  9.73E-07  2.13E-07  7.07E-07  3.00E-07 -5.50E-08 -2.56E-07  1.71E-07 -6.57E-07 -6.40E-07  3.38E-07  5.97E-07
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (S)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM22      OM23      OM33      SG11  

 
 TH 1
+        2.29E-02
 
 TH 2
+        8.82E-02  1.67E-02
 
 TH 3
+        3.34E-01  4.02E-01  1.76E-02
 
 TH 4
+       -1.39E-02 -5.44E-02 -5.47E-02  9.97E-02
 
 TH 5
+        4.88E-02  5.36E-02  4.43E-02 -6.86E-01  7.20E-03
 
 OM11
+        3.21E-01  1.78E-02 -1.13E-02  6.42E-02 -3.27E-02  9.94E-03
 
 OM12
+        9.60E-02  5.28E-02  5.49E-02 -1.46E-01  9.35E-02  1.93E-01  6.31E-03
 
 OM13
+        1.35E-01  3.54E-02  1.40E-02 -2.97E-02  1.65E-02  7.72E-01  4.01E-01  7.19E-03
 
 OM22
+        5.56E-02 -2.37E-02  8.65E-03  4.80E-03  3.82E-02  9.82E-02  1.09E-01  1.11E-01  6.42E-03
 
 OM23
+        4.48E-02  1.39E-02  2.25E-02 -5.83E-02  9.20E-02  1.02E-01  4.57E-01  2.59E-01  4.50E-01  5.17E-03
 
 OM33
+        1.49E-02  2.59E-02  3.39E-02 -8.21E-02  2.81E-02  8.81E-02  2.64E-01  3.81E-01  8.05E-02  4.77E-01  7.27E-03
 
 SG11
+        1.23E-02  7.54E-02  1.57E-02  9.17E-03  5.40E-02 -7.16E-03 -5.25E-02  3.08E-02 -1.32E-01 -1.60E-01  6.01E-02  7.73E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (S)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM22      OM23      OM33      SG11  

 
 TH 1
+        2.63E+03
 
 TH 2
+        2.34E+02  4.34E+03
 
 TH 3
+       -1.24E+03 -1.74E+03  4.43E+03
 
 TH 4
+       -6.45E+00  1.25E+01  1.81E+01  1.99E+02
 
 TH 5
+       -4.86E+02 -2.24E+02  1.83E+02  1.88E+03  3.76E+04
 
 OM11
+       -3.85E+03 -4.55E+02  1.97E+03 -1.87E+02  1.56E+02  3.54E+04
 
 OM12
+       -1.08E+03 -3.39E+02  1.15E+02  3.17E+02  1.78E+03  6.83E+03  3.87E+04
 
 OM13
+        3.66E+03  2.35E+02 -1.69E+03  1.38E+02 -3.40E+02 -4.24E+04 -1.86E+04  7.70E+04
 
 OM22
+       -2.76E+02  3.23E+02 -1.16E+02 -2.73E+01 -3.93E+02 -2.73E+02  4.67E+03 -2.25E+03  3.22E+04
 
 OM23
+        2.71E+02 -2.34E+02  1.77E+02 -3.70E+02 -6.02E+03 -1.73E+03 -2.16E+04  5.56E+03 -2.29E+04  7.74E+04
 
 OM33
+       -7.56E+02  3.62E+01  1.20E+02  2.06E+02  3.04E+03  1.05E+04  4.69E+03 -2.12E+04  5.22E+03 -2.22E+04  3.21E+04
 
 SG11
+       -2.10E+03 -6.61E+03  2.30E+03 -1.67E+03 -2.84E+04  1.18E+04  1.46E+03 -1.96E+04  1.03E+04  6.31E+04 -2.88E+04  1.80E+06
 
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                    EIGENVALUES OF COR MATRIX OF ESTIMATE (S)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

             1         2         3         4         5         6         7         8         9        10        11        12

 
         1.33E-01  2.74E-01  3.51E-01  5.04E-01  6.96E-01  8.06E-01  8.78E-01  1.12E+00  1.33E+00  1.58E+00  1.75E+00  2.58E+00
 
 Elapsed postprocess time in seconds:    12.40
 Elapsed finaloutput time in seconds:     0.52
 #CPUT: Total CPU Time in Seconds,       37.971
Stop Time: 
Wed 12/06/2017 
12:35 PM
