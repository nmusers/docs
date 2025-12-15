Thu 09/23/2021 
12:20 PM
; Using the SDE in-line equations after the manner of Christoffer Tornoe, but MU modeling theta(1) and theta(2).  
; Note that IMP method results are similar in sde_ex2_impo and sde_ex2_imp_mu, since this method did not 
; rely on NMTRAN having 
; exposure to analytical SDE equations.  But ITS and Laplace in sde_ex2_impo is not correct, relative to sde_ex2_impo_mu.  
; Although their LAPLACE OBJ's are far apart, in fact the parameters are similar.
$PROBLEM PK ODE HANDS ON ONE
$INPUT ID HOUR DV AMT CMT FLAG EVID MDV SDE TIME
$DATA   sde_ex2.dat
        IGNORE=@
$SUBROUTINE ADVAN6 TOL 10 DP
$MODEL 
       COMP = (CENTRAL);
       COMP = (P1)

$THETA (0,2.3)               ;1 CL
$THETA (0,3.5)               ;2 VD
$THETA (0, 2)               ;4 SIGMA
$THETA (0,1) ; SGW1

$OMEGA 0.1                  ;1 CL
$OMEGA 0.01                 ;2 VD

$SIGMA 1 FIX                ; PK

$PK
  IF(NEWIND.NE.2) OT = 0

  MU_1  = THETA(1)
  CL    = EXP(MU_1+ETA(1)) 
  MU_2  = THETA(2)
  VD    = EXP(MU_2+ETA(2))
  SGW1 = THETA(4)

IF(NEWIND.NE.2) THEN
  AHT1 = 0
  PHT1 = 0
ENDIF

IF(EVID.NE.3) THEN
  A1 = A(1)
  A2 = A(2)
ELSE
  A1 = A1
  A2 = A2
ENDIF

IF(EVID.EQ.0) OBS = DV

IF(EVID.GT.2.AND.SDE.EQ.2) THEN
  RVAR = A2*(1/VD)**2+ THETA(3)**2
  K1   = A2*(1/VD)/RVAR
  AHT1 = A1 + K1*(OBS -( A1/VD))
  PHT1 = A2 - K1*RVAR*K1
ENDIF

IF(EVID.GT.2.AND.SDE.EQ.3) THEN
  AHT1 = A1
  PHT1 = 0
ENDIF

IF(EVID.GT.2.AND.SDE.EQ.4) THEN
  AHT1 = 0
  PHT1 = A2
ENDIF

IF(A_0FLG.EQ.1) THEN
  A_0(1) = AHT1
  A_0(2) = PHT1
ENDIF

$DES
 DADT(1) = - CL/VD*A(1) ;+0
DADT(2) = (-CL/VD)*(A(2))+(-CL/VD)*(A(2))+SGW1*SGW1

$ERROR (OBS ONLY)
     IPRED = A(1)/VD
     IRES  = DV - IPRED
W=SQRT(ABS(A(2))*(1/VD)**2+ THETA(3)**2)
     IWRES = IRES/W
     Y     = IPRED+W*EPS(1)

$EST METHOD=ITS INTERACTION LAPLACE NUMERICAL SLOW NOABORT PRINT=1 CTYPE=3
$EST METHOD=IMP INTERACTION NOABORT SIGL=5 PRINT=1 IACCEPT=1.0 CTYPE=3
$EST MAXEVAL=9999 METHOD=1 LAPLACE INTER NOABORT NUMERICAL SLOW NSIG=3 PRINT=1
$COV MATRIX=R
$TABLE ID TIME FLAG AMT CMT IPRED IRES IWRES EVID
       ONEHEADER NOPRINT FILE=sde_ex2_imp_mu.tab
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  3) THERE MAY BE AN ERROR IN THE ABBREVIATED CODE. THE FOLLOWING
 ONE OR MORE RANDOM VARIABLES ARE DEFINED WITH "IF" STATEMENTS THAT DO NOT
 PROVIDE DEFINITIONS FOR BOTH THE "THEN" AND "ELSE" CASES. IF ALL
 CONDITIONS FAIL, THE VALUES OF THESE VARIABLES WILL BE ZERO.
  
   RVAR K1

             
 (WARNING  26) THE DERIVATIVE OF THE ABSOLUTE VALUE OF A RANDOM VARIABLE IS
 BEING COMPUTED. IF THE ABSOLUTE VALUE AFFECTS THE VALUE OF THE OBJECTIVE
 FUNCTION, THE USER SHOULD ENSURE THAT THE RANDOM VARIABLE IS ALWAYS
 POSITIVE OR ALWAYS NEGATIVE.

 (MU_WARNING 24) ABBREVIATED CODE IS TOO COMPLEX. UNABLE TO CHECK USE OF MU_ VARIABLES.
  
Note: Analytical 2nd Derivatives are constructed in FSUBS but are never used.
      You may insert $ABBR DERIV2=NO after the first $PROB to save FSUBS construction and compilation time
  
  
License Registered to: NONMEM license (with RADAR5NM) for ICON Pharmacometrics Team
Expiration Date:    31 DEC 2030
Current Date:       23 SEP 2021
Days until program expires :3383
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.1
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 PK ODE HANDS ON ONE
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:     1650
 NO. OF DATA ITEMS IN DATA SET:  10
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   3
 MDV DATA ITEM IS DATA ITEM NO.:  8
0INDICES PASSED TO SUBROUTINE PRED:
   7  10   4   0   0   0   5   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID HOUR DV AMT CMT FLAG EVID MDV SDE TIME
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 IPRED IRES IWRES
0FORMAT FOR DATA:
 (E3.0,E5.0,E9.0,E5.0,5E2.0,E5.0)

 TOT. NO. OF OBS RECS:      540
 TOT. NO. OF INDIVIDUALS:       30
0LENGTH OF THETA:   4
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   2
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
  0.0000E+00     0.2300E+01     0.1000E+07
  0.0000E+00     0.3500E+01     0.1000E+07
  0.0000E+00     0.2000E+01     0.1000E+07
  0.0000E+00     0.1000E+01     0.1000E+07
0INITIAL ESTIMATE OF OMEGA:
 0.1000E+00
 0.0000E+00   0.1000E-01
0INITIAL ESTIMATE OF SIGMA:
 0.1000E+01
0SIGMA CONSTRAINED TO BE THIS INITIAL ESTIMATE
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
 NPDTYPE:    0
 INTERPTYPE:    0
 RANMETHOD:             3U
 MC SAMPLES (ESAMPLE):    300
 WRES SQUARE ROOT TYPE (WRESCHOL): EIGENVALUE
0-- TABLE   1 --
0RECORDS ONLY:    ALL
04 COLUMNS APPENDED:    YES
 PRINTED:                NO
 HEADERS:               ONE
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID TIME FLAG AMT CMT IPRED IRES IWRES EVID
1DOUBLE PRECISION PREDPP VERSION 7.5.1

 GENERAL NONLINEAR KINETICS MODEL (DVERK1, ADVAN6)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:   3
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         CENTRAL      ON         YES        YES        YES        YES
    2         P1           ON         YES        YES        NO         NO
    3         OUTPUT       OFF        YES        NO         NO         NO
 INITIAL (BASE) TOLERANCE SETTINGS:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            *           *           *           *           *
    2            *           *           *           *           *
    3            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      7
   TIME DATA ITEM IS DATA ITEM NO.:         10
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   4
   COMPT. NO. DATA ITEM IS DATA ITEM NO.:    5

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0PK SUBROUTINE INDICATES THAT COMPARTMENT AMOUNTS ARE INITIALIZED.
0PK SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
0DURING SIMULATION, ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 OTHERWISE, ERROR SUBROUTINE CALLED ONLY WITH OBSERVATION EVENTS.
0ERROR SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
0DES SUBROUTINE USES COMPACT STORAGE MODE.
1
 
 
 #TBLN:      1
 #METH: Iterative Two Stage
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               SLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    YES
 NUMERICAL 2ND DERIVATIVES:               YES
 NO. OF FUNCT. EVALS. ALLOWED:            360
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
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): sde_ex2_imp_mu.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 EM OR BAYESIAN METHOD USED:                ITERATIVE TWO STAGE (ITS)
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          1
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 ITERATIONS (NITER):                        50
 ANNEAL SETTING (CONSTRAIN):                 1

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 
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

 iteration            0 OBJ=   1537.54893586748
 iteration            1 OBJ=   1388.96713037458
 iteration            2 OBJ=   1326.41717048535
 iteration            3 OBJ=   1275.07385373142
 iteration            4 OBJ=   1234.32854051772
 iteration            5 OBJ=   1213.80226207655
 iteration            6 OBJ=   1211.33330342438
 iteration            7 OBJ=   1211.23122341226
 iteration            8 OBJ=   1211.24159399419
 iteration            9 OBJ=   1211.24375943084
 iteration           10 OBJ=   1211.24717238243
 iteration           11 OBJ=   1211.24734829013
 iteration           12 OBJ=   1211.24823836106
 iteration           13 OBJ=   1211.24800970114
 iteration           14 OBJ=   1211.24811527964
 iteration           15 OBJ=   1211.24824518520
 iteration           16 OBJ=   1211.24834809953
 iteration           17 OBJ=   1211.24825285921
 iteration           18 OBJ=   1211.24837404934
 iteration           19 OBJ=   1211.24834629237
 Convergence achieved
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -1.8754E-05 -1.1413E-05
 SE:             4.4021E-02  6.1628E-02
 N:                      30          30
 
 P VAL.:         9.9966E-01  9.9985E-01
 
 ETASHRINKSD(%)  1.0854E+01  1.7157E+00
 ETASHRINKVR(%)  2.0530E+01  3.4020E+00
 EBVSHRINKSD(%)  1.0862E+01  1.7185E+00
 EBVSHRINKVR(%)  2.0545E+01  3.4074E+00
 RELATIVEINF(%)  7.9421E+01  9.6550E+01
 EPSSHRINKSD(%)  4.7476E+00
 EPSSHRINKVR(%)  9.2698E+00
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          540
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    992.453615861047     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    1211.24834629237     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       2203.70196215341     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            60
  
 #TERE:
 Elapsed estimation  time in seconds:     8.61
 Elapsed covariance  time in seconds:     0.02
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     1211.248       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         2.40E+00  3.48E+00  9.07E-01  5.33E+01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        7.32E-02
 
 ETA2
+        0.00E+00  1.18E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        2.70E-01
 
 ETA2
+        0.00E+00  3.43E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                          STANDARD ERROR OF ESTIMATE (S)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         6.27E-02  8.18E-02  8.65E-02  4.30E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        3.43E-02
 
 ETA2
+        0.00E+00  3.96E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        0.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        6.34E-02
 
 ETA2
+       .........  5.77E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+       .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (S)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        3.93E-03
 
 TH 2
+        8.38E-04  6.69E-03
 
 TH 3
+       -1.36E-03  1.73E-03  7.48E-03
 
 TH 4
+        7.89E-02 -6.90E-02 -2.00E-01  1.85E+01
 
 OM11
+       -8.00E-04 -7.44E-04  5.76E-04 -2.84E-02  1.18E-03
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -7.62E-05 -1.55E-03  5.71E-05  2.40E-02  1.07E-04  0.00E+00  1.57E-03
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (S)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        6.27E-02
 
 TH 2
+        1.63E-01  8.18E-02
 
 TH 3
+       -2.50E-01  2.44E-01  8.65E-02
 
 TH 4
+        2.93E-01 -1.97E-01 -5.38E-01  4.30E+00
 
 OM11
+       -3.72E-01 -2.65E-01  1.94E-01 -1.93E-01  3.43E-02
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -3.06E-02 -4.78E-01  1.67E-02  1.41E-01  7.88E-02  0.00E+00  3.96E-02
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (S)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        3.26E+02
 
 TH 2
+       -4.90E+01  2.46E+02
 
 TH 3
+        3.38E+01 -7.08E+01  2.14E+02
 
 TH 4
+       -9.33E-01  2.86E-01  1.93E+00  8.27E-02
 
 OM11
+        1.54E+02  1.43E+02 -7.08E+01  7.03E-01  1.09E+03
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -3.00E+01  2.28E+02 -1.01E+02 -1.14E+00  6.59E+01  0.00E+00  8.77E+02
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
1
 
 
 #TBLN:      2
 #METH: Importance Sampling
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               SLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    YES
 NUMERICAL 2ND DERIVATIVES:               YES
 NO. OF FUNCT. EVALS. ALLOWED:            360
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      5
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     5
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): sde_ex2_imp_mu.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
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
 SAMPLE ACCEPTANCE RATE (IACCEPT):          1.00000000000000
 LONG TAIL SAMPLE ACCEPT. RATE (IACCEPTL):   0.00000000000000
 T-DIST. PROPOSAL DENSITY (DF):             0
 NO. ITERATIONS FOR MAP (MAPITER):          1
 INTERVAL ITER. FOR MAP (MAPINTER):         0
 MAP COVARIANCE/MODE SETTING (MAPCOV):      1
 Gradient Quick Value (GRDQ):               0.00000000000000

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 
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

 iteration            0 OBJ=   1210.83495783601 eff.=     302. Smpl.=     300. Fit.= 0.98510
 iteration            1 OBJ=   1210.80135376707 eff.=     299. Smpl.=     300. Fit.= 0.96495
 iteration            2 OBJ=   1210.64697493875 eff.=     301. Smpl.=     300. Fit.= 0.96074
 iteration            3 OBJ=   1210.84220125629 eff.=     302. Smpl.=     300. Fit.= 0.96072
 iteration            4 OBJ=   1210.60878042626 eff.=     307. Smpl.=     300. Fit.= 0.96013
 iteration            5 OBJ=   1210.87455236069 eff.=     292. Smpl.=     300. Fit.= 0.96224
 iteration            6 OBJ=   1210.48929331494 eff.=     305. Smpl.=     300. Fit.= 0.96312
 iteration            7 OBJ=   1210.59739746388 eff.=     299. Smpl.=     300. Fit.= 0.96162
 iteration            8 OBJ=   1210.68417687857 eff.=     305. Smpl.=     300. Fit.= 0.95943
 iteration            9 OBJ=   1210.82551260097 eff.=     304. Smpl.=     300. Fit.= 0.95716
 iteration           10 OBJ=   1210.70185985721 eff.=     295. Smpl.=     300. Fit.= 0.95954
 iteration           11 OBJ=   1210.67568416083 eff.=     305. Smpl.=     300. Fit.= 0.95939
 Convergence achieved
 iteration           11 OBJ=   1210.75309142988 eff.=     300. Smpl.=     300. Fit.= 0.95640
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -2.9781E-03  2.3678E-03
 SE:             4.4842E-02  6.1761E-02
 N:                      30          30
 
 P VAL.:         9.4705E-01  9.6942E-01
 
 ETASHRINKSD(%)  1.0391E+01  1.8693E+00
 ETASHRINKVR(%)  1.9701E+01  3.7037E+00
 EBVSHRINKSD(%)  1.0928E+01  1.6905E+00
 EBVSHRINKVR(%)  2.0661E+01  3.3524E+00
 RELATIVEINF(%)  7.9311E+01  9.6614E+01
 EPSSHRINKSD(%)  4.9295E+00
 EPSSHRINKVR(%)  9.6160E+00
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          540
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    992.453615861047     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    1210.75309142988     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       2203.20670729093     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            60
  
 #TERE:
 Elapsed estimation  time in seconds:    31.83
 Elapsed covariance  time in seconds:    11.47
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     1210.753       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         2.38E+00  3.48E+00  9.07E-01  5.32E+01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        7.51E-02
 
 ETA2
+        0.00E+00  1.19E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        2.74E-01
 
 ETA2
+        0.00E+00  3.45E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                          STANDARD ERROR OF ESTIMATE (R)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         5.63E-02  6.41E-02  7.83E-02  3.89E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        2.55E-02
 
 ETA2
+        0.00E+00  3.44E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        0.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        4.64E-02
 
 ETA2
+       .........  4.99E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+       .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (R)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        3.17E-03
 
 TH 2
+       -6.47E-05  4.11E-03
 
 TH 3
+       -1.47E-04  2.46E-05  6.14E-03
 
 TH 4
+        8.60E-03  5.48E-03 -2.01E-01  1.51E+01
 
 OM11
+       -5.78E-05 -9.78E-06  1.57E-04 -1.19E-02  6.48E-04
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -1.02E-05 -2.25E-05  7.99E-05 -6.05E-03  7.38E-05  0.00E+00  1.18E-03
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (R)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        5.63E-02
 
 TH 2
+       -1.80E-02  6.41E-02
 
 TH 3
+       -3.34E-02  4.90E-03  7.83E-02
 
 TH 4
+        3.93E-02  2.20E-02 -6.60E-01  3.89E+00
 
 OM11
+       -4.04E-02 -6.00E-03  7.88E-02 -1.20E-01  2.55E-02
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -5.25E-03 -1.02E-02  2.96E-02 -4.53E-02  8.42E-02  0.00E+00  3.44E-02
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (R)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        3.17E+02
 
 TH 2
+        5.21E+00  2.44E+02
 
 TH 3
+        2.88E+00 -6.82E+00  2.89E+02
 
 TH 4
+       -1.24E-01 -1.79E-01  3.84E+00  1.18E-01
 
 OM11
+        2.53E+01  2.06E+00  5.14E-01  1.19E+00  1.58E+03
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+        4.11E-01  4.10E+00  2.13E-02  2.68E-01 -9.20E+01  0.00E+00  8.53E+02
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
1
 
 
 #TBLN:      3
 #METH: Laplacian Conditional Estimation with Interaction
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               SLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    YES
 NUMERICAL 2ND DERIVATIVES:               YES
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      5
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     5
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): sde_ex2_imp_mu.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 ADDITIONAL CONVERGENCE TEST (CTYPE=4)?:    NO
 EM OR BAYESIAN METHOD USED:                 NONE

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 TOLERANCES FOR TABLE/SCATTER STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 MONITORING OF SEARCH:

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   1211.13853055401        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:        7
 NPARAMETR:  2.3819E+00  3.4770E+00  9.0723E-01  5.3164E+01  7.5124E-02  1.1883E-01
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:   1.5186E+00 -2.3848E+00 -3.9575E-01 -3.2262E-01  3.5396E-01  7.2518E-02
 
0ITERATION NO.:    1    OBJECTIVE VALUE:   1211.13793851564        NO. OF FUNC. EVALS.:  11
 CUMULATIVE NO. OF FUNC. EVALS.:       18
 NPARAMETR:  2.3807E+00  3.4799E+00  9.0736E-01  5.3170E+01  7.5106E-02  1.1883E-01
 PARAMETER:  9.9480E-02  1.0082E-01  1.0014E-01  1.0011E-01  9.9879E-02  9.9975E-02
 GRADIENT:  -2.6015E-01  2.4174E+00 -3.3590E-01 -2.3442E-01  3.3052E-01  7.0608E-02
 
0ITERATION NO.:    2    OBJECTIVE VALUE:   1211.13758207811        NO. OF FUNC. EVALS.:  12
 CUMULATIVE NO. OF FUNC. EVALS.:       30
 NPARAMETR:  2.3808E+00  3.4780E+00  9.0742E-01  5.3173E+01  7.5095E-02  1.1882E-01
 PARAMETER:  9.9538E-02  1.0028E-01  1.0021E-01  1.0016E-01  9.9806E-02  9.9960E-02
 GRADIENT:  -1.4745E-01 -7.8781E-01 -2.5131E-01 -1.5164E-01  3.2966E-01  6.8116E-02
 
0ITERATION NO.:    3    OBJECTIVE VALUE:   1211.13747777391        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:       40
 NPARAMETR:  2.3818E+00  3.4782E+00  9.0804E-01  5.3196E+01  7.4971E-02  1.1878E-01
 PARAMETER:  9.9974E-02  1.0033E-01  1.0089E-01  1.0059E-01  9.8981E-02  9.9788E-02
 GRADIENT:   1.4098E+00 -5.4275E-01  2.2871E-01  3.4660E-01  2.9491E-01  5.4521E-02
 
0ITERATION NO.:    4    OBJECTIVE VALUE:   1211.13732772183        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:       50
 NPARAMETR:  2.3813E+00  3.4782E+00  9.0847E-01  5.3207E+01  7.4850E-02  1.1874E-01
 PARAMETER:  9.9739E-02  1.0034E-01  1.0136E-01  1.0080E-01  9.8172E-02  9.9622E-02
 GRADIENT:   5.4476E-01 -5.3923E-01  5.2436E-01  6.4700E-01  2.3334E-01  3.7954E-02
 
0ITERATION NO.:    5    OBJECTIVE VALUE:   1211.13687002225        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       59
 NPARAMETR:  2.3814E+00  3.4782E+00  9.0874E-01  5.3169E+01  7.4428E-02  1.1861E-01
 PARAMETER:  9.9805E-02  1.0033E-01  1.0166E-01  1.0009E-01  9.5341E-02  9.9062E-02
 GRADIENT:   7.2304E-01 -5.1923E-01  4.0210E-01  2.2075E-01  1.4422E-02 -2.8157E-02
 
0ITERATION NO.:    6    OBJECTIVE VALUE:   1211.13680120793        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       68
 NPARAMETR:  2.3815E+00  3.4782E+00  9.0817E-01  5.3196E+01  7.4331E-02  1.1862E-01
 PARAMETER:  9.9816E-02  1.0033E-01  1.0104E-01  1.0060E-01  9.4689E-02  9.9109E-02
 GRADIENT:   6.9521E-01 -5.5483E-01  2.9425E-01  3.1513E-01 -2.2212E-02 -1.8728E-02
 
0ITERATION NO.:    7    OBJECTIVE VALUE:   1211.13679195925        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       76
 NPARAMETR:  2.3814E+00  3.4782E+00  9.0821E-01  5.3192E+01  7.4315E-02  1.1878E-01
 PARAMETER:  9.9803E-02  1.0033E-01  1.0107E-01  1.0053E-01  9.4583E-02  9.9801E-02
 GRADIENT:   6.6538E-01 -5.0145E-01  2.8538E-01  2.8523E-01 -3.2209E-02  5.7358E-02
 
0ITERATION NO.:    8    OBJECTIVE VALUE:   1211.13663752407        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       85
 NPARAMETR:  2.3811E+00  3.4784E+00  9.0796E-01  5.3184E+01  7.4374E-02  1.1871E-01
 PARAMETER:  9.9675E-02  1.0039E-01  1.0080E-01  1.0038E-01  9.4983E-02  9.9484E-02
 GRADIENT:   1.8221E-01 -1.6405E-01  9.5155E-02  9.1575E-02 -1.0942E-02  2.0797E-02
 
0ITERATION NO.:    9    OBJECTIVE VALUE:   1211.13662289577        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       93
 NPARAMETR:  2.3810E+00  3.4785E+00  9.0781E-01  5.3181E+01  7.4403E-02  1.1867E-01
 PARAMETER:  9.9628E-02  1.0042E-01  1.0064E-01  1.0032E-01  9.5175E-02  9.9299E-02
 GRADIENT:   2.5564E-02  2.9821E-02 -1.0317E-03 -4.0922E-04  7.1589E-05 -7.5130E-04
 
0ITERATION NO.:   10    OBJECTIVE VALUE:   1211.13662289577        NO. OF FUNC. EVALS.:  12
 CUMULATIVE NO. OF FUNC. EVALS.:      105
 NPARAMETR:  2.3810E+00  3.4785E+00  9.0781E-01  5.3181E+01  7.4403E-02  1.1867E-01
 PARAMETER:  9.9628E-02  1.0042E-01  1.0064E-01  1.0032E-01  9.5175E-02  9.9299E-02
 GRADIENT:  -1.4624E-01 -2.8080E-01 -2.4866E-02 -3.3400E-02 -3.5571E-03 -6.3033E-03
 
0ITERATION NO.:   11    OBJECTIVE VALUE:   1211.13662289577        NO. OF FUNC. EVALS.:   0
 CUMULATIVE NO. OF FUNC. EVALS.:      105
 NPARAMETR:  2.3810E+00  3.4785E+00  9.0781E-01  5.3181E+01  7.4403E-02  1.1867E-01
 PARAMETER:  9.9628E-02  1.0042E-01  1.0064E-01  1.0032E-01  9.5175E-02  9.9299E-02
 GRADIENT:  -1.4624E-01 -2.8080E-01 -2.4866E-02 -3.3400E-02 -3.5571E-03 -6.3033E-03
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      105
 NO. OF SIG. DIGITS IN FINAL EST.:  3.3

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.4677E-02  2.0258E-03
 SE:             4.4277E-02  6.1657E-02
 N:                      30          30
 
 P VAL.:         7.4027E-01  9.7379E-01
 
 ETASHRINKSD(%)  1.1092E+01  1.9644E+00
 ETASHRINKVR(%)  2.0954E+01  3.8901E+00
 EBVSHRINKSD(%)  1.0796E+01  1.7063E+00
 EBVSHRINKVR(%)  2.0427E+01  3.3836E+00
 RELATIVEINF(%)  7.9538E+01  9.6575E+01
 EPSSHRINKSD(%)  4.7801E+00
 EPSSHRINKVR(%)  9.3318E+00
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          540
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    992.453615861047     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    1211.13662289577     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       2203.59023875681     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            60
  
 #TERE:
 Elapsed estimation  time in seconds:    17.07
 Elapsed covariance  time in seconds:    10.75
 Elapsed postprocess time in seconds:     0.15
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     1211.137       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         2.38E+00  3.48E+00  9.08E-01  5.32E+01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        7.44E-02
 
 ETA2
+        0.00E+00  1.19E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        2.73E-01
 
 ETA2
+        0.00E+00  3.44E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         5.63E-02  6.40E-02  7.87E-02  3.93E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        2.50E-02
 
 ETA2
+       .........  3.19E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+       .........
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        4.58E-02
 
 ETA2
+       .........  4.63E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+       .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        3.17E-03
 
 TH 2
+       -7.53E-05  4.10E-03
 
 TH 3
+       -1.74E-04  2.56E-05  6.19E-03
 
 TH 4
+        1.03E-02  5.17E-03 -2.05E-01  1.55E+01
 
 OM11
+       -1.07E-04 -5.81E-06  1.61E-04 -1.26E-02  6.24E-04
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -8.78E-06  2.10E-06  6.04E-05 -4.75E-03  8.16E-06 .........  1.02E-03
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        5.63E-02
 
 TH 2
+       -2.09E-02  6.40E-02
 
 TH 3
+       -3.94E-02  5.08E-03  7.87E-02
 
 TH 4
+        4.63E-02  2.05E-02 -6.61E-01  3.93E+00
 
 OM11
+       -7.57E-02 -3.63E-03  8.17E-02 -1.28E-01  2.50E-02
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -4.89E-03  1.03E-03  2.41E-02 -3.79E-02  1.03E-02 .........  3.19E-02
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11  
 
 TH 1
+        3.18E+02
 
 TH 2
+        6.04E+00  2.44E+02
 
 TH 3
+        3.46E+00 -6.52E+00  2.87E+02
 
 TH 4
+       -1.25E-01 -1.71E-01  3.80E+00  1.16E-01
 
 OM11
+        5.09E+01  1.54E+00  3.38E+00  1.34E+00  1.64E+03
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+        1.53E+00 -8.76E-01  7.16E-01  3.06E-01 -6.64E+00 .........  9.85E+02
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 Elapsed finaloutput time in seconds:     0.17
 #CPUT: Total CPU Time in Seconds,       80.500
Stop Time: 
Thu 09/23/2021 
12:22 PM
