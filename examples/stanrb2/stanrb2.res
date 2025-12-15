Wed 09/18/2019 
09:07 AM
$PROBLEM Stan model
$DATA full2.csv IGNORE=@
$INPUT DV TIME MDV EVID AMT CMT DRUG SARM ID

$THETAI
THETA(4:5)=LOG(EXP(THETAI(4:5))+1.0)
THETA(9:10)=LOG(EXP(THETAI(9:10))+1.0)

$THETAR
THETAR(4:5)=LOG(EXP(THETA(4:5))-1.0)
THETAR(9:10)=LOG(EXP(THETA(9:10))-1.0)

$PRED
ALPHAC=50.0
; MU REFERENCE NEEDED TO do Gibbs sampling
LALPHA0=THETA(1)
LALPHAS=THETA(2)
LKAPPA=THETA(3)
LEMAX1=THETA(4)
LEMAX2=THETA(5)
STIM=0.0
IF(SARM==2) STIM=LEMAX1
IF(SARM==3) STIM=LEMAX2
MU_1=LALPHA0
MU_2=(LKAPPA+LALPHAS)/2.0+STIM
MU_3=(LKAPPA-LALPHAS)/2.0
G0=ALPHAC*EXP(MU_1+ETA(1))
KIN=EXP(MU_2+ETA(2))
KOUT=EXP(MU_3+ETA(3))
ALPHA=KIN/KOUT
F=ALPHA+(G0-ALPHA)*EXP(-KOUT*TIME)
Y=F+EPS(1)

$THETA 0.01 4.0 -5.0 -1.1 -1.6

$OMEGA BLOCK(3) VALUES(0.5,0.001)

$SIGMA 25.0

$PRIOR NWPRI

$THETAP (0.0 FIXED) (3.738 FIXED) (-4.451 FIXED) (-1.386 FIXED) (-1.386 FIXED)

$THETAPV BLOCK(5)
0.0086529 FIXED
0.0 0.042795
0.0 0.0 0.125065
0.0 0.0 0.0  0.67427
0.0 0.0 0.0  0.0   0.67427

$OMEGAP BLOCK(3)
0.01 FIX
0.0  0.16
0.0  0.0 0.04

$OMEGAPD (4 FIX)

$SIGMAP BLOCK(1)
16.0 FIX

$SIGMAPD (2 FIX)

$EST METHOD=ITS NITER=0 file=stanrb2_its.ext
$EST METHOD=NUTS NBURN=500 NITER=500 PRINT=20 file=stanrb2.ext
     OLKJDF=6.0 NUTSREG=1.0
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  121) INTERACTION IS IMPLIED WITH EM/BAYES ESTIMATION METHODS

 (MU_WARNING 6) THETA(003): SHOULD BE ASSOCIATED WITH ONLY ONE MU_.

 (MU_WARNING 6) THETA(002): SHOULD BE ASSOCIATED WITH ONLY ONE MU_.
  
License Registered to: IDS NONMEM 7 TEAM
Expiration Date:     2 JUN 2030
Current Date:       18 SEP 2019
Days until program expires :3909
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.0 alpha version 9
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 Stan model
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:     9900
 NO. OF DATA ITEMS IN DATA SET:   9
 ID DATA ITEM IS DATA ITEM NO.:   9
 DEP VARIABLE IS DATA ITEM NO.:   1
 MDV DATA ITEM IS DATA ITEM NO.:  3
0LABELS FOR DATA ITEMS:
 DV TIME MDV EVID AMT CMT DRUG SARM ID
0FORMAT FOR DATA:
 (9E7.0)

 TOT. NO. OF OBS RECS:     9000
 TOT. NO. OF INDIVIDUALS:      900
0LENGTH OF THETA:  12
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS BLOCK FORM:
  1
  1  1
  1  1  1
  0  0  0  2
  0  0  0  2  2
  0  0  0  2  2  2
  0  0  0  2  2  2  2
  0  0  0  2  2  2  2  2
  0  0  0  0  0  0  0  0  3
  0  0  0  0  0  0  0  0  3  3
  0  0  0  0  0  0  0  0  3  3  3
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS BLOCK FORM:
  1
  0  2
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
 -0.1000E+07     0.1000E-01     0.1000E+07
 -0.1000E+07     0.4000E+01     0.1000E+07
 -0.1000E+07    -0.5000E+01     0.1000E+07
 -0.1000E+07    -0.1100E+01     0.1000E+07
 -0.1000E+07    -0.1600E+01     0.1000E+07
  0.0000E+00     0.0000E+00     0.0000E+00
  0.3738E+01     0.3738E+01     0.3738E+01
 -0.4451E+01    -0.4451E+01    -0.4451E+01
 -0.1386E+01    -0.1386E+01    -0.1386E+01
 -0.1386E+01    -0.1386E+01    -0.1386E+01
  0.4000E+01     0.4000E+01     0.4000E+01
  0.2000E+01     0.2000E+01     0.2000E+01
0INITIAL ESTIMATE OF OMEGA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.5000E+00
                  0.1000E-02   0.5000E+00
                  0.1000E-02   0.1000E-02   0.5000E+00
        2                                                                                  YES
                  0.8653E-02
                  0.0000E+00   0.4279E-01
                  0.0000E+00   0.0000E+00   0.1251E+00
                  0.0000E+00   0.0000E+00   0.0000E+00   0.6743E+00
                  0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.6743E+00
        3                                                                                  YES
                  0.1000E-01
                  0.0000E+00   0.1600E+00
                  0.0000E+00   0.0000E+00   0.4000E-01
0INITIAL ESTIMATE OF SIGMA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.2500E+02
        2                                                                                  YES
                  0.1600E+02
0
 THETAI SUBROUTINE USER-SUPPLIED
 THETAR SUBROUTINE USER-SUPPLIED
 PRIOR SUBROUTINE USER-SUPPLIED
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
 NO. OF FUNCT. EVALS. ALLOWED:            3024
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
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): stanrb2_its.ext
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
 CONVERGENCE TYPE (CTYPE):                  0
 ITERATIONS (NITER):                        0
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
   1   2   3   4   5
 THETAS THAT ARE SIGMA-LIKE:
 
 
 MONITORING OF SEARCH:

 iteration            0 OBJ=   43737.6892825327
 
 #TERM:
 OPTIMIZATION WAS NOT TESTED FOR CONVERGENCE


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.1121E-03 -1.0864E-01  1.6909E-01
 SE:             3.9030E-03  1.1687E-02  9.1065E-03
 N:                     900         900         900
 
 P VAL.:         7.7570E-01  1.4853E-20  6.2288E-77
 
 ETASHRINKSD(%)  8.3432E+01  5.0389E+01  6.1343E+01
 ETASHRINKVR(%)  9.7255E+01  7.5387E+01  8.5056E+01
 EBVSHRINKSD(%)  6.8202E-01  2.0376E+01  1.9329E+01
 EBVSHRINKVR(%)  1.3594E+00  3.6601E+01  3.4921E+01
 EPSSHRINKSD(%)  3.1003E+01
 EPSSHRINKVR(%)  5.2395E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         9000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    16540.8935976841     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    43737.6892825327     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       60278.5828802168     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2700
  
 PRIOR CONSTANT TO OBJECTIVE FUNCTION:    19.9404013334959     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    43737.6892825327     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       43757.6296838662     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:     0.41
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************    43737.689       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
         1.00E-02  4.00E+00 -5.00E+00 -1.10E+00 -1.60E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        5.00E-01
 
 ETA2
+        1.00E-03  5.00E-01
 
 ETA3
+        1.00E-03  1.00E-03  5.00E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        2.50E+01
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        7.07E-01
 
 ETA2
+        2.00E-03  7.07E-01
 
 ETA3
+        2.00E-03  2.00E-03  7.07E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.00E+00
 
1
 
 
 #TBLN:      2
 #METH: NUTS Bayesian Analysis
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            3024
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
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): stanrb2.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 EM OR BAYESIAN METHOD USED:                MCMC BAYESIAN (BAYES)
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  0
 KEEP ITERATIONS (THIN):            1
 BURN-IN ITERATIONS (NBURN):                500
 FIRST ITERATION FOR MAP (MAPITERS):          NO
 ITERATIONS (NITER):                        500
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
 MC SAMPLES PER SUBJECT (ISAMPLE):          1
 RANDOM SAMPLING METHOD (RANMETHOD):        3U
 PROPOSAL DENSITY SCALING RANGE
              (ISCALE_MIN, ISCALE_MAX):     1.000000000000000E-06   ,1000000.00000000
 SAMPLE ACCEPTANCE RATE (IACCEPT):          0.400000000000000
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
 SAMPLES FOR LOCAL SEARCH KERNEL (OSAMPLE_M2):           -1
 SAMPLES FOR LOCAL UNIVARIATE SEARCH KERNEL (OSAMPLE_M3):-1
 MASS/IMP./POST. MATRIX REFRESH SETTING (MASSREST):      -1
 MASS MATRIX ACCUMULATION ITERATIONS (MADAPT):          -1
 MASS MATRIX BLOCKING TYPE (NUTS_MASS):                 B
 MODEL PARAMETERS TRANSFORMED BY MASS MATRIX (NUTS_TRANSFORM=0)
 POWER TERM WEIGHTING FOR MASS MATRIX ACCUM. (KAPPA):   1.00000000000000
 NUTS SAMPLE ACCEPTANCE RATE (NUTS_DELTA):                   0.800000000000000
 NUTS GAMMA SETTING (NUTS_GAMMA):                            5.000000000000000E-02
 USER DEFINED PRIOR SETTING FOR THETAS: (TPU):        0.00000000000000
 DEG. FR. FOR LKJ CORRELATION PRIOR FOR OMEGAS (OLKJDF): 6.00000000000000
 WEIGHT FACTOR FOR STD PRIOR FOR SIGMAS (SVARF): -1.000000000000000+300
 NUTS WARMUP METHOD (NUTS_TEST):       0
 NUTS MAXIMAL DEPTH SEARCH (NUTS_MAXDEPTH):       10
 NUTS STAGE I WARMUP ITERATIONS (NUTS_INIT):       7.500000000000000E-02
 NUTS STAGE II BASE WARMUP ITERATIONS (NUTS_BASE): 2.500000000000000E-02
 NUTS STAGE III FINAL ITERATIONS (NUTS_TERM): 5.000000000000000E-02
 INITIAL ITERATIONS FOR STEP NUTS SIZE ASSESSMENT (NUTS_STEPITER): 1
 INTERVAL ITERATIONS FOR STEP NUTS SIZE ASSESSMENT (NUTS_STEPINTER):0
 ETA PARAMETERIZATION (NUTS_EPARAM):0
 OMEGA PARAMETERIZATION (NUTS_OPARAM):1
 SIGMA PARAMETERIZATION (NUTS_SPARAM):1
 NUTS REGULARIZING METHOD (NUTS_REG): 1.00000000000000

 
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
 THETAS THAT ARE GIBBS SAMPLED:
   1   2   3   4   5
 THETAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 SIGMAS THAT ARE GIBBS SAMPLED:
   1
 SIGMAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 OMEGAS ARE GIBBS SAMPLED
 
 MONITORING OF SEARCH:

 Burn-in Mode
 iteration         -466 MCMCOBJ=    31189.1781747669     
 iteration         -460 MCMCOBJ=    27962.8159539293     
 iteration         -440 MCMCOBJ=    27066.6217256265     
 iteration         -420 MCMCOBJ=    26294.5685145671     
 iteration         -400 MCMCOBJ=    26453.2279356515     
 iteration         -380 MCMCOBJ=    27147.6316067215     
 iteration         -360 MCMCOBJ=    26718.8566690904     
 iteration         -340 MCMCOBJ=    26979.7851303122     
 iteration         -320 MCMCOBJ=    26984.9670983957     
 iteration         -300 MCMCOBJ=    27593.1759530618     
 iteration         -280 MCMCOBJ=    27448.3806707689     
 iteration         -260 MCMCOBJ=    27341.2204697386     
 iteration         -240 MCMCOBJ=    27331.2770516393     
 iteration         -220 MCMCOBJ=    27368.8098991054     
 iteration         -200 MCMCOBJ=    27581.6213448878     
 iteration         -180 MCMCOBJ=    27831.7632818273     
 iteration         -160 MCMCOBJ=    27232.4180626775     
 iteration         -140 MCMCOBJ=    27298.5425684417     
 iteration         -120 MCMCOBJ=    27367.3794540751     
 iteration         -100 MCMCOBJ=    26916.2605155052     
 iteration          -80 MCMCOBJ=    27218.3133063000     
 iteration          -60 MCMCOBJ=    27602.0397211051     
 iteration          -40 MCMCOBJ=    27125.5787451209     
 iteration          -20 MCMCOBJ=    27453.5613162734     
 Sampling Mode
 iteration            0 MCMCOBJ=    27184.6364720010     
 iteration           20 MCMCOBJ=    27052.5547330797     
 iteration           40 MCMCOBJ=    27076.2416506293     
 iteration           60 MCMCOBJ=    27430.8911746531     
 iteration           80 MCMCOBJ=    27531.0147100300     
 iteration          100 MCMCOBJ=    27775.0415118003     
 iteration          120 MCMCOBJ=    27837.0743206259     
 iteration          140 MCMCOBJ=    27475.3819452881     
 iteration          160 MCMCOBJ=    27447.5448718488     
 iteration          180 MCMCOBJ=    27161.6532976097     
 iteration          200 MCMCOBJ=    27550.5682347814     
 iteration          220 MCMCOBJ=    27204.2039490470     
 iteration          240 MCMCOBJ=    27470.8586015604     
 iteration          260 MCMCOBJ=    27686.5444248701     
 iteration          280 MCMCOBJ=    27888.7514074382     
 iteration          300 MCMCOBJ=    27624.1203461192     
 iteration          320 MCMCOBJ=    27685.9674620253     
 iteration          340 MCMCOBJ=    27610.8581656901     
 iteration          360 MCMCOBJ=    27153.1551890293     
 iteration          380 MCMCOBJ=    27158.6745307588     
 iteration          400 MCMCOBJ=    27180.9448740368     
 iteration          420 MCMCOBJ=    27271.3647437800     
 iteration          440 MCMCOBJ=    26937.0257612575     
 iteration          460 MCMCOBJ=    27276.6865800702     
 iteration          480 MCMCOBJ=    27175.6769203242     
 iteration          500 MCMCOBJ=    27250.7780099045     
 
 #TERM:
 BURN-IN WAS NOT TESTED FOR CONVERGENCE
 STATISTICAL PORTION WAS COMPLETED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -2.3061E-04 -1.3285E-03 -1.2386E-04
 SE:             2.8592E-03  1.2592E-02  6.1258E-03
 N:                     900         900         900
 
 P VAL.:         9.3571E-01  9.1597E-01  9.8387E-01
 
 ETASHRINKSD(%)  1.3729E+01  6.7688E+00  2.1233E+01
 ETASHRINKVR(%)  2.5573E+01  1.3079E+01  3.7958E+01
 EBVSHRINKSD(%)  1.3836E+01  7.0118E+00  2.1652E+01
 EBVSHRINKVR(%)  2.5757E+01  1.3532E+01  3.8615E+01
 EPSSHRINKSD(%)  9.0926E+00
 EPSSHRINKVR(%)  1.7358E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         9000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    16540.8935976841     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    27382.8413999173     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       43923.7349976015     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2700
 NIND*NETA*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    4962.26807930523     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    27382.8413999173     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       32345.1094792226     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 PRIOR CONSTANT TO OBJECTIVE FUNCTION:   -10.0300439664667     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    27382.8413999173     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       27372.8113559509     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:  2473.71
 Elapsed covariance  time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 #OBJT:**************                       AVERAGE VALUE OF LIKELIHOOD FUNCTION                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************    27382.841       **************************************************
 #OBJS:********************************************      227.711 (STD) **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
         1.02E-02  3.67E+00 -5.00E+00 -9.17E-01 -1.15E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        9.90E-03
 
 ETA2
+        2.45E-02  1.64E-01
 
 ETA3
+       -8.06E-04 -3.52E-02  5.45E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.56E+01
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        9.94E-02
 
 ETA2
+        6.07E-01  4.05E-01
 
 ETA3
+       -3.65E-02 -3.81E-01  2.33E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        3.95E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************                STANDARD ERROR OF ESTIMATE (From Sample Variance)               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
         4.08E-03  2.82E-02  4.60E-02  1.34E-01  1.66E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        6.96E-04
 
 ETA2
+        2.41E-03  1.34E-02
 
 ETA3
+        1.71E-03  7.38E-03  8.48E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        2.73E-01
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        3.49E-03
 
 ETA2
+        4.38E-02  1.65E-02
 
 ETA3
+        7.46E-02  1.00E-01  1.80E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        3.46E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************               COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM22      OM23      OM33      SG11  

 
 TH 1
+        1.66E-05
 
 TH 2
+        3.16E-05  7.96E-04
 
 TH 3
+        3.77E-05  6.07E-04  2.12E-03
 
 TH 4
+        1.31E-05 -2.55E-03 -2.46E-03  1.79E-02
 
 TH 5
+       -4.39E-05 -3.30E-03 -2.80E-03  1.22E-02  2.74E-02
 
 OM11
+       -1.32E-07  6.46E-07 -2.87E-06  1.66E-06 -4.11E-07  4.84E-07
 
 OM12
+        2.78E-07  3.98E-06 -1.13E-05 -1.34E-05 -6.46E-06  7.82E-07  5.80E-06
 
 OM13
+        2.06E-07  6.47E-07  1.27E-05 -7.65E-06  3.07E-07 -1.22E-07  1.75E-06  2.93E-06
 
 OM22
+       -2.70E-06  2.70E-05 -1.24E-04 -2.49E-04 -9.65E-05  3.08E-08  1.68E-05  5.70E-06  1.79E-04
 
 OM23
+       -5.56E-07 -6.42E-06  2.15E-05  2.81E-05  2.61E-05 -7.23E-07  4.32E-06  7.17E-06  4.02E-05  5.45E-05
 
 OM33
+        3.88E-06 -3.44E-06  8.62E-05  5.08E-05  9.33E-05 -1.04E-06  1.53E-06  4.33E-06  1.14E-05  3.67E-05  7.20E-05
 
 SG11
+        5.23E-05  1.16E-04  7.53E-04 -4.32E-04 -7.14E-04 -1.83E-05  1.32E-05  1.15E-05 -4.94E-05 -1.63E-04 -1.85E-04  7.48E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************              CORRELATION MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM22      OM23      OM33      SG11  

 
 TH 1
+        4.08E-03
 
 TH 2
+        2.74E-01  2.82E-02
 
 TH 3
+        2.01E-01  4.67E-01  4.60E-02
 
 TH 4
+        2.40E-02 -6.76E-01 -4.00E-01  1.34E-01
 
 TH 5
+       -6.50E-02 -7.05E-01 -3.68E-01  5.53E-01  1.66E-01
 
 OM11
+       -4.65E-02  3.29E-02 -8.95E-02  1.78E-02 -3.57E-03  6.96E-04
 
 OM12
+        2.83E-02  5.85E-02 -1.02E-01 -4.16E-02 -1.62E-02  4.67E-01  2.41E-03
 
 OM13
+        2.94E-02  1.34E-02  1.61E-01 -3.34E-02  1.08E-03 -1.02E-01  4.25E-01  1.71E-03
 
 OM22
+       -4.94E-02  7.16E-02 -2.01E-01 -1.39E-01 -4.36E-02  3.31E-03  5.21E-01  2.49E-01  1.34E-02
 
 OM23
+       -1.84E-02 -3.08E-02  6.33E-02  2.85E-02  2.13E-02 -1.41E-01  2.43E-01  5.67E-01  4.07E-01  7.38E-03
 
 OM33
+        1.12E-01 -1.44E-02  2.21E-01  4.48E-02  6.64E-02 -1.76E-01  7.48E-02  2.98E-01  1.00E-01  5.86E-01  8.48E-03
 
 SG11
+        4.69E-02  1.50E-02  5.98E-02 -1.18E-02 -1.58E-02 -9.64E-02  2.00E-02  2.45E-02 -1.35E-02 -8.07E-02 -7.97E-02  2.73E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************           INVERSE COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM22      OM23      OM33      SG11  

 
 TH 1
+        7.61E+04
 
 TH 2
+       -6.69E+03  4.10E+03
 
 TH 3
+       -7.80E+02 -3.26E+02  7.90E+02
 
 TH 4
+       -8.70E+02  3.39E+02  6.13E+01  1.22E+02
 
 TH 5
+       -3.65E+02  2.96E+02  1.88E+01 -8.01E+00  7.72E+01
 
 OM11
+        4.81E+04 -7.75E+03 -1.24E+03 -7.60E+02 -6.65E+02  3.64E+06
 
 OM12
+       -1.42E+04 -7.77E+02  1.63E+03 -2.12E+02  1.23E+02 -8.30E+05  4.75E+05
 
 OM13
+        1.06E+03  2.26E+03 -4.42E+03  3.23E+02 -3.00E+02  5.24E+05 -2.92E+05  7.06E+05
 
 OM22
+        7.07E+02 -3.32E+02  6.88E+02  2.04E+02 -2.77E+01  6.42E+04 -3.95E+04  2.04E+04  1.13E+04
 
 OM23
+        4.65E+03  6.36E+01  1.76E+02 -2.16E+02  1.24E+02 -2.91E+04  2.64E+04 -8.85E+04 -9.02E+03  4.68E+04
 
 OM33
+       -4.03E+03  1.24E+02 -9.92E+02 -3.53E+01 -1.36E+02  4.61E+04 -1.37E+04  1.87E+04  2.39E+03 -1.84E+04  2.45E+04
 
 SG11
+       -2.87E+01  4.49E+00 -7.89E+00 -5.28E-01  7.49E-02  1.03E+03 -2.50E+02 -2.22E+01  7.33E+00  4.69E+01  4.39E+01  1.40E+01
 
 Elapsed postprocess time in seconds:     0.00
 Elapsed finaloutput time in seconds:     0.00
 #CPUT: Total CPU Time in Seconds,     2435.519
Stop Time: 
Wed 09/18/2019 
09:48 AM
