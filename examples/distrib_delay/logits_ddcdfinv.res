Tue 12/07/2021 
12:48 PM
;DDE
$PROBLEM LOGISTIC
$ABBR DERIV2=NO DERIV2=NOCOMMON ; DERIV1=NO
$ABBR FUNCTION GAMMACDFINV(VG,10)
$INPUT ID AMT TIME PRDV DV EVID MDV
$DATA logistic6.csv IGNORE=C
$SUBROUTINES ADVAN16 TOL=6 ATOL=6
$MODEL NCOMPARTMENTS=1

$PK
MXSTEP=2000000000
MU_1=THETA(1)
MU_2=THETA(2)
MU_3=THETA(3)
MU_4=THETA(4)
MU_5=THETA(5)
KG=EXP(MU_1+ETA(1))
Y0=EXP(MU_2+ETA(2))
YSS=EXP(MU_3+ETA(3))
KK=EXP(MU_4+ETA(4))
NU1=EXP(MU_5+ETA(5))
DEN=KK/EXP(GAMLN(NU1))
A_0(1)=Y0

$DES

VG(2)=NU1
VG(3)=KK
ADC=0.0
;DOC1 10 TSS CS GQ(U,0.0,1.0)
VG(10)=II_1
VG(1)=TSS
TS=GAMMACDFINV(VG)
TAU1=TS
AP_1_1=Y0
ADC=ADC+CS*AD_1_1
;ENDDOC1

 DADT(1)=KG*(1.0-ADC/YSS)*A(1)

$ERROR
A1=A(1)
Y1=1.0
IPRED=A(1)
Y=IPRED*(1.0+EPS(1))

$THETA
-1.61764E+00
-2.40835E-02
 2.29145E+00
 -0.5
 1.098612289

$OMEGA BLOCK(3)
 8.45335E-03
 6.59591E-04  7.39132E-03
 1.01727E-03 -1.73680E-03  6.86871E-03

$OMEGA 0.01 0.01

$SIGMA
 3.23154E-03

$EST METHOD=CHAIN FILE=temp14.ext ISAMPLE=-1000000000 TBLN=1 NSAMPLE=0
$EST METHOD=ITS INTERACTION NOHABORT SIGL=5 MCETA=10 NSIG=2 PRINT=1 NITER=0 CTYPE=3 OPTMAP=0 ETADER=0 FNLETA=0
$EST METHOD=ITS INTERACTION NOHABORT SIGL=5 MCETA=10 NSIG=2 PRINT=1 NITER=0 CTYPE=3 OPTMAP=1 ETADER=2 FNLETA=0

  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  126) ONLY THE LAST FNLETA LISTED IN THE SERIES OF $EST RECORDS FOR
 THIS PROBLEM WILL BE USED
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  84) VALUES HAVE NOT BEEN ASSIGNED TO THE FOLLOWING ELEMENTS IN
 ABBREVIATED CODE:
  
   VG(4) VG(5) VG(6) VG(7) VG(8) VG(9)

             
 (WARNING  118) THE DERIVATIVE OF THE LOG GAMMA OF A RANDOM VARIABLE IS
 BEING COMPUTED. IF THE FUNCTION VALUE AFFECTS THE VALUE OF THE OBJECTIVE
 FUNCTION, THE USER SHOULD ENSURE THAT THE RANDOM VARIABLE IS ALWAYS
 POSITIVE
             
 (WARNING  83) FUNCTIONS ARE USED IN ABBREVIATED CODE, BUT THE $SUBROUTINES
 RECORD DOES NOT INCLUDE THE "OTHER" OPTION.
  
License Registered to: NONMEM license (with RADAR5NM) for ICON Pharmacometrics Team
Expiration Date:    31 DEC 2030
Current Date:        7 DEC 2021
Days until program expires :3309
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.1
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 LOGISTIC
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:     2340
 NO. OF DATA ITEMS IN DATA SET:   7
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   5
 MDV DATA ITEM IS DATA ITEM NO.:  7
0INDICES PASSED TO SUBROUTINE PRED:
   6   3   2   0   0   0   0   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID AMT TIME PRDV DV EVID MDV
0FORMAT FOR DATA:
 (5E14.0/2E14.0)

 TOT. NO. OF OBS RECS:     2340
 TOT. NO. OF INDIVIDUALS:       30
0LENGTH OF THETA:   5
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS BLOCK FORM:
  1
  1  1
  1  1  1
  0  0  0  2
  0  0  0  0  3
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
  -0.1618E+01 -0.2408E-01  0.2291E+01 -0.5000E+00  0.1099E+01
0INITIAL ESTIMATE OF OMEGA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.8453E-02
                  0.6596E-03   0.7391E-02
                  0.1017E-02  -0.1737E-02   0.6869E-02
        2                                                                                   NO
                  0.1000E-01
        3                                                                                   NO
                  0.1000E-01
0INITIAL ESTIMATE OF SIGMA:
 0.3232E-02
1DOUBLE PRECISION PREDPP VERSION 7.5.1

 GENERAL NONLINEAR KINETICS MODEL WITH STIFF/NONSTIFF AND DELAY EQUATIONS (RADAR5, ADVAN16)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:  10
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         COMP 1       ON         YES        YES        YES        YES
    2         OUTPUT       OFF        YES        NO         NO         NO
 INITIAL (BASE) TOLERANCE SETTINGS:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            *           *           *           *           *
    2            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      6
   TIME DATA ITEM IS DATA ITEM NO.:          3
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   2

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0PK SUBROUTINE INDICATES THAT COMPARTMENT AMOUNTS ARE INITIALIZED.
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
0ERROR SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
0DES SUBROUTINE USES FULL STORAGE MODE.
1
 
 
 #TBLN:      1
 #METH: Chain Method Processing
 
 RANDOM GENERATION TYPE (CTYPE):     0
 RANDOM GENERATION SEED (SEED):      11456
 RANDOM SAMPLE SELECTION (ISAMPLE):  -1000000000
 RANDOM SAMPLE RANGE END (ISAMPEND): -2147483647
 NUMBER OF RANDOM SAMPLES (NSAMPLE): 0
 UNIFORM FRACTIONAL RANGE (IACCEPT): 0.400000000000000
 RANDOM SELECTION TYPE (SELECT):     0
 DEG. FR. TO GENERATE OMEGAS (DF):   0
 DEG. FR. TO GENERATE SIGMAS (DFS):  -1
 CHAIN FILE (FILE):                  temp14.ext
 EXCL. TITLE IN CHAIN FILE (NOTITLE):NO
 EX. COL. LBS. IN CHAIN FL.(NOLABEL):NO
 FORMAT FOR CHAIN FILE (FORMAT):     S1PE12.5
 PAR. ORDER in CHAIN FILE (ORDER):   TSOL
 RANDOM SAMPLING METHOD (RANMETHOD):3U
 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=NPRED
 RES=NRES
 WRES=NWRES
 IWRS=NIWRES
 IPRD=NIPRED
 IRS=NIRES
 
 
 
 FROM SAMPLE -1000000000 OF TABLE 1 OF CHAIN FILE temp14.ext
 NEW INITIAL ESTIMATES OF THETA
 -0.1594E+01
 -0.4164E-01
  0.2288E+01
 -0.1622E-01
  0.1514E+01
 NEW INITIAL ESTIMATES OF OMEGA
  0.8738E-02
  0.4736E-03  0.7226E-02
  0.9122E-03 -0.1856E-02  0.6827E-02
  0.2065E-01 -0.2416E-03  0.7772E-03  0.8984E-01
  0.2199E-01  0.2078E-03  0.2440E-02  0.1064E+00  0.1295E+00
 NEW INITIAL ESTIMATES OF SIGMA
  0.3286E-02
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
 NO. OF FUNCT. EVALS. ALLOWED:            728
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      5
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     5
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          0
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): logits_ddcdfinv.ext
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
 ITERATIONS (NITER):                        0
 ANNEAL SETTING (CONSTRAIN):                 1

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2   3   4   5
 THETAS THAT ARE SIGMA-LIKE:
 
 
 MONITORING OF SEARCH:

 iteration            0 OBJ=  -884.128552544604
 
 #TERM:
 OPTIMIZATION WAS NOT TESTED FOR CONVERGENCE


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         7.4598E-03 -4.4802E-03 -6.4488E-04  1.2474E-01  1.5664E-01
 SE:             1.7332E-02  1.4883E-02  1.4987E-02  2.2283E-02  3.2433E-02
 N:                      30          30          30          30          30
 
 P VAL.:         6.6689E-01  7.6340E-01  9.6568E-01  2.1737E-08  1.3701E-06
 
 ETASHRINKSD(%)  1.0000E-10  4.1041E+00  6.5305E-01  5.9282E+01  5.0632E+01
 ETASHRINKVR(%)  1.0000E-10  8.0398E+00  1.3018E+00  8.3420E+01  7.5628E+01
 EBVSHRINKSD(%)  1.8265E+00  4.8566E+00  4.2583E-01  3.1277E+01  2.0709E+01
 EBVSHRINKVR(%)  3.6195E+00  9.4773E+00  8.4984E-01  5.2772E+01  3.7129E+01
 RELATIVEINF(%)  9.2806E+01  8.9893E+01  9.9680E+01  1.0000E-10  2.4523E+01
 EPSSHRINKSD(%)  1.4229E+00
 EPSSHRINKVR(%)  2.8257E+00
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         2340
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    4300.63233539787     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -884.128552544604     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       3416.50378285326     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                           150
  
 #TERE:
 Elapsed estimation  time in seconds:    14.10
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     -884.129       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
        -1.59E+00 -4.16E-02  2.29E+00 -1.62E-02  1.51E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        8.74E-03
 
 ETA2
+        4.74E-04  7.23E-03
 
 ETA3
+        9.12E-04 -1.86E-03  6.83E-03
 
 ETA4
+        2.06E-02 -2.42E-04  7.77E-04  8.98E-02
 
 ETA5
+        2.20E-02  2.08E-04  2.44E-03  1.06E-01  1.29E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.29E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        9.35E-02
 
 ETA2
+        5.96E-02  8.50E-02
 
 ETA3
+        1.18E-01 -2.64E-01  8.26E-02
 
 ETA4
+        7.37E-01 -9.48E-03  3.14E-02  3.00E-01
 
 ETA5
+        6.54E-01  6.79E-03  8.21E-02  9.87E-01  3.60E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.73E-02
 
1
 
 
 #TBLN:      2
 #METH: Iterative Two Stage
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            728
 NO. OF SIG. FIGURES REQUIRED:            2
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   1
 ETA HESSIAN EVALUATION METHOD (ETADER):    2
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    10
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      5
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     5
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          0
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): logits_ddcdfinv.ext
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
 ITERATIONS (NITER):                        0
 ANNEAL SETTING (CONSTRAIN):                 1

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2   3   4   5
 THETAS THAT ARE SIGMA-LIKE:
 
 
 MONITORING OF SEARCH:

 iteration            0 OBJ=  -884.150382220351
 
 #TERM:
 OPTIMIZATION WAS NOT TESTED FOR CONVERGENCE


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         7.4598E-03 -4.4802E-03 -6.4488E-04  1.2474E-01  1.5664E-01
 SE:             1.7332E-02  1.4883E-02  1.4987E-02  2.2283E-02  3.2433E-02
 N:                      30          30          30          30          30
 
 P VAL.:         6.6689E-01  7.6340E-01  9.6568E-01  2.1737E-08  1.3701E-06
 
 ETASHRINKSD(%)  1.0000E-10  4.1041E+00  6.5305E-01  5.9282E+01  5.0632E+01
 ETASHRINKVR(%)  1.0000E-10  8.0398E+00  1.3018E+00  8.3420E+01  7.5628E+01
 EBVSHRINKSD(%)  1.8278E+00  4.8560E+00  4.2582E-01  3.1296E+01  2.0722E+01
 EBVSHRINKVR(%)  3.6221E+00  9.4762E+00  8.4983E-01  5.2798E+01  3.7151E+01
 RELATIVEINF(%)  9.2812E+01  8.9894E+01  9.9679E+01  1.0000E-10  2.4516E+01
 EPSSHRINKSD(%)  1.4230E+00
 EPSSHRINKVR(%)  2.8257E+00
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         4680
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    8601.26467079574     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -884.150382220351     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       7717.11428857539     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                           150
  
 #TERE:
 Elapsed estimation  time in seconds:    24.81
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     -884.150       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
        -1.59E+00 -4.16E-02  2.29E+00 -1.62E-02  1.51E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        8.74E-03
 
 ETA2
+        4.74E-04  7.23E-03
 
 ETA3
+        9.12E-04 -1.86E-03  6.83E-03
 
 ETA4
+        2.06E-02 -2.42E-04  7.77E-04  8.98E-02
 
 ETA5
+        2.20E-02  2.08E-04  2.44E-03  1.06E-01  1.29E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.29E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        9.35E-02
 
 ETA2
+        5.96E-02  8.50E-02
 
 ETA3
+        1.18E-01 -2.64E-01  8.26E-02
 
 ETA4
+        7.37E-01 -9.48E-03  3.14E-02  3.00E-01
 
 ETA5
+        6.54E-01  6.79E-03  8.21E-02  9.87E-01  3.60E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.73E-02
 
 Elapsed postprocess time in seconds:     0.00
 Elapsed finaloutput time in seconds:     0.00
 #CPUT: Total CPU Time in Seconds,       39.609
Stop Time: 
Tue 12/07/2021 
12:49 PM
