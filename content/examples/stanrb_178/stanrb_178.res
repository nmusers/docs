Wed 09/18/2019 
11:50 AM
$PROBLEM Stan model
$DATA full3.csv IGNORE=@
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
0.011 FIX
0.0  0.161
0.0  0.0 0.041

$OMEGAPD (4 FIX)

$SIGMAP BLOCK(1)
16.0 FIX

$SIGMAPD (2 FIX)

$EST METHOD=BAYES NBURN=1000 NITER=0 PRINT=50 MASSRESET=1 file=stanrb_178_beys.ext
     OLKJDF=6 OSAMPLE_M1=1 PKAPPA=0.75
$EST METHOD=NUTS NBURN=500 NITER=500 PRINT=20 file=stanrb_178.ext
     OLKJDF=6.0 MASSRESET=0 PKAPPA=1.0
  
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
 (E11.0,6E10.0/2E10.0)

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
                  0.1100E-01
                  0.0000E+00   0.1610E+00
                  0.0000E+00   0.0000E+00   0.4100E-01
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
 #METH: MCMC Bayesian Analysis
 
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
 RAW OUTPUT FILE (FILE): stanrb_178_beys.ext
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
 BURN-IN ITERATIONS (NBURN):                1000
 FIRST ITERATION FOR MAP (MAPITERS):          NO
 ITERATIONS (NITER):                        0
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
 MASS/IMP./POST. MATRIX REFRESH SETTING (MASSRESET):      1
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
 SAMPLES FOR GLOBAL SEARCH KERNEL (OSAMPLE_M1):          1
 SAMPLES FOR LOCAL SEARCH KERNEL (OSAMPLE_M2):           6
 SAMPLES FOR LOCAL UNIVARIATE SEARCH KERNEL (OSAMPLE_M3):6
 USER DEFINED PRIOR SETTING FOR THETAS: (TPU):        0.00000000000000
 DEG. FR. FOR LKJ CORRELATION PRIOR FOR OMEGAS (OLKJDF): 6.00000000000000
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
   1   2   3   4   5
 THETAS THAT ARE GIBBS SAMPLED:
   1   2   3   4   5
 THETAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 SIGMAS THAT ARE GIBBS SAMPLED:
   1
 SIGMAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 OMEGAS ARE METROPOLIS-HASTINGS SAMPLED
 
 MONITORING OF SEARCH:

 Burn-in Mode
 iteration        -1000 MCMCOBJ=    66288.3298539771     
 iteration         -950 MCMCOBJ=    28629.5789178114     
 iteration         -900 MCMCOBJ=    27630.3659568675     
 iteration         -850 MCMCOBJ=    27590.7277256389     
 iteration         -800 MCMCOBJ=    27090.8908579927     
 iteration         -750 MCMCOBJ=    27254.6331105777     
 iteration         -700 MCMCOBJ=    27421.2664647859     
 iteration         -650 MCMCOBJ=    27136.9009620201     
 iteration         -600 MCMCOBJ=    26880.3028202436     
 iteration         -550 MCMCOBJ=    27644.8961141143     
 iteration         -500 MCMCOBJ=    27193.6156364769     
 iteration         -450 MCMCOBJ=    27071.5597696319     
 iteration         -400 MCMCOBJ=    27383.0067452893     
 iteration         -350 MCMCOBJ=    26922.1266765414     
 iteration         -300 MCMCOBJ=    26610.6646154326     
 iteration         -250 MCMCOBJ=    27095.8989023066     
 iteration         -200 MCMCOBJ=    27098.2031063561     
 iteration         -150 MCMCOBJ=    27119.5872858891     
 iteration         -100 MCMCOBJ=    26851.0036415510     
 iteration          -50 MCMCOBJ=    27210.2998876630     
 Sampling Mode
 iteration            0 MCMCOBJ=    27086.0605517604     
 
 #TERM:
 BURN-IN WAS NOT TESTED FOR CONVERGENCE
 STATISTICAL PORTION WAS NOT PERFORMED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         8.8871E-04 -3.9544E-03  5.8599E-03
 SE:             3.3659E-03  1.3705E-02  6.7136E-03
 N:                     900         900         900
 
 P VAL.:         7.9176E-01  7.7294E-01  3.8275E-01
 
 ETASHRINKSD(%)  1.0000E-10  1.0000E-10  3.6918E+00
 ETASHRINKVR(%)  1.0000E-10  1.0000E-10  7.2473E+00
 EBVSHRINKSD(%)         NaN         NaN         NaN
 EBVSHRINKVR(%)         NaN         NaN         NaN
 EPSSHRINKSD(%)  1.0000E-10
 EPSSHRINKVR(%)  1.0000E-10
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         9000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    16540.8935976841     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    27086.0605517604     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       43626.9541494445     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2700
 NIND*NETA*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    4962.26807930523     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    27086.0605517604     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       32048.3286310656     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 PRIOR CONSTANT TO OBJECTIVE FUNCTION:   -10.0300439664667     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    27086.0605517604     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       27076.0305077939     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:   378.98
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 #OBJT:**************                       AVERAGE VALUE OF LIKELIHOOD FUNCTION                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************    27086.061       **************************************************
 #OBJS:********************************************        0.000 (STD) **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
        -7.43E-03  3.69E+00 -5.00E+00 -9.02E-01 -1.21E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        9.85E-03
 
 ETA2
+        2.24E-02  1.59E-01
 
 ETA3
+       -5.06E-04 -4.78E-02  4.38E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.58E+01
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        9.93E-02
 
 ETA2
+        5.67E-01  3.98E-01
 
 ETA3
+       -2.43E-02 -5.73E-01  2.09E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        3.97E+00
 
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
 RAW OUTPUT FILE (FILE): stanrb_178.ext
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
 SAMPLES FOR GLOBAL SEARCH KERNEL (OSAMPLE_M1):          1
 SAMPLES FOR LOCAL SEARCH KERNEL (OSAMPLE_M2):           -1
 SAMPLES FOR LOCAL UNIVARIATE SEARCH KERNEL (OSAMPLE_M3):-1
 MASS/IMP./POST. MATRIX REFRESH SETTING (MASSREST):      0
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
 NUTS REGULARIZING METHOD (NUTS_REG): 0.00000000000000

 
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
 
 OMEGAS ARE METROPOLIS-HASTINGS SAMPLED
 
 MONITORING OF SEARCH:

 Burn-in Mode
 iteration         -466 MCMCOBJ=    27969.7550330762     
 iteration         -460 MCMCOBJ=    27869.7009247765     
 iteration         -440 MCMCOBJ=    27761.3946105530     
 iteration         -420 MCMCOBJ=    27552.5094185796     
 iteration         -400 MCMCOBJ=    27421.9171745866     
 iteration         -380 MCMCOBJ=    27241.5157519808     
 iteration         -360 MCMCOBJ=    27245.7688239719     
 iteration         -340 MCMCOBJ=    26965.3205588525     
 iteration         -320 MCMCOBJ=    27191.2594572854     
 iteration         -300 MCMCOBJ=    27284.9369647579     
 iteration         -280 MCMCOBJ=    26968.8613872800     
 iteration         -260 MCMCOBJ=    27054.9653286031     
 iteration         -240 MCMCOBJ=    26764.2261189389     
 iteration         -220 MCMCOBJ=    27112.8882473926     
 iteration         -200 MCMCOBJ=    27206.9832404517     
 iteration         -180 MCMCOBJ=    27101.6244886793     
 iteration         -160 MCMCOBJ=    27255.7725664025     
 iteration         -140 MCMCOBJ=    27153.8036672256     
 iteration         -120 MCMCOBJ=    27061.8000792322     
 iteration         -100 MCMCOBJ=    26996.3040614093     
 iteration          -80 MCMCOBJ=    26889.4887069305     
 iteration          -60 MCMCOBJ=    27142.9716701667     
 iteration          -40 MCMCOBJ=    26780.8733121928     
 iteration          -20 MCMCOBJ=    26962.8199730867     
 Sampling Mode
 iteration            0 MCMCOBJ=    27373.5092608694     
 iteration           20 MCMCOBJ=    27584.1302219376     
 iteration           40 MCMCOBJ=    27354.7352543231     
 iteration           60 MCMCOBJ=    27349.1848062878     
 iteration           80 MCMCOBJ=    27268.6476424058     
 iteration          100 MCMCOBJ=    27294.2808815911     
 iteration          120 MCMCOBJ=    27203.0461120277     
 iteration          140 MCMCOBJ=    27095.6723820768     
 iteration          160 MCMCOBJ=    27276.2097621416     
 iteration          180 MCMCOBJ=    27039.7847723256     
 iteration          200 MCMCOBJ=    27019.9766616900     
 iteration          220 MCMCOBJ=    27039.2220854740     
 iteration          240 MCMCOBJ=    27282.6814722628     
 iteration          260 MCMCOBJ=    27283.4819323382     
 iteration          280 MCMCOBJ=    26364.7684164739     
 iteration          300 MCMCOBJ=    26616.5099959806     
 iteration          320 MCMCOBJ=    26365.2235069352     
 iteration          340 MCMCOBJ=    26675.9368147269     
 iteration          360 MCMCOBJ=    26946.2438552986     
 iteration          380 MCMCOBJ=    27290.0939093683     
 iteration          400 MCMCOBJ=    26978.5749237336     
 iteration          420 MCMCOBJ=    26517.8085654903     
 iteration          440 MCMCOBJ=    26703.9669740266     
 iteration          460 MCMCOBJ=    26929.5921567245     
 iteration          480 MCMCOBJ=    26722.5561693646     
 iteration          500 MCMCOBJ=    26766.9569803721     
 
 #TERM:
 BURN-IN WAS NOT TESTED FOR CONVERGENCE
 STATISTICAL PORTION WAS COMPLETED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -3.7047E-04 -1.3486E-03 -1.8483E-04
 SE:             2.9344E-03  1.3636E-02  5.6303E-03
 N:                     900         900         900
 
 P VAL.:         8.9953E-01  9.2122E-01  9.7381E-01
 
 ETASHRINKSD(%)  1.3563E+01  3.5232E+00  1.6470E+01
 ETASHRINKVR(%)  2.5286E+01  6.9223E+00  3.0228E+01
 EBVSHRINKSD(%)  1.3625E+01  3.7424E+00  1.6921E+01
 EBVSHRINKVR(%)  2.5394E+01  7.3448E+00  3.0979E+01
 EPSSHRINKSD(%)  9.0585E+00
 EPSSHRINKVR(%)  1.7296E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         9000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    16540.8935976841     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    27026.4984961368     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       43567.3920938209     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2700
 NIND*NETA*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    4962.26807930523     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    27026.4984961368     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       31988.7665754420     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 PRIOR CONSTANT TO OBJECTIVE FUNCTION:   -10.0300439664667     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    27026.4984961368     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       27016.4684521703     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:  1761.95
 Elapsed covariance  time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 #OBJT:**************                       AVERAGE VALUE OF LIKELIHOOD FUNCTION                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************    27026.498       **************************************************
 #OBJS:********************************************      312.833 (STD) **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
        -2.43E-03  3.68E+00 -5.03E+00 -9.86E-01 -1.13E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        1.04E-02
 
 ETA2
+        2.64E-02  1.80E-01
 
 ETA3
+       -7.55E-05 -4.50E-02  4.09E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.58E+01
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        1.02E-01
 
 ETA2
+        6.11E-01  4.24E-01
 
 ETA3
+       -4.64E-03 -5.29E-01  2.02E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        3.98E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************                STANDARD ERROR OF ESTIMATE (From Sample Variance)               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
         4.02E-03  2.72E-02  4.18E-02  1.47E-01  1.57E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        6.75E-04
 
 ETA2
+        2.51E-03  1.23E-02
 
 ETA3
+        1.44E-03  4.79E-03  5.54E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        2.80E-01
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        3.31E-03
 
 ETA2
+        4.08E-02  1.44E-02
 
 ETA3
+        7.02E-02  7.28E-02  1.38E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        3.52E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************               COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM22      OM23      OM33      SG11  

 
 TH 1
+        1.62E-05
 
 TH 2
+        2.51E-05  7.38E-04
 
 TH 3
+        2.40E-05  4.79E-04  1.75E-03
 
 TH 4
+        4.81E-05 -2.59E-03 -2.15E-03  2.17E-02
 
 TH 5
+       -7.65E-06 -2.60E-03 -2.56E-03  1.07E-02  2.48E-02
 
 OM11
+       -3.72E-07 -9.30E-07 -5.89E-06  2.23E-06  4.26E-06  4.56E-07
 
 OM12
+       -4.86E-07  4.94E-06 -3.37E-05 -3.44E-05 -4.12E-05  9.58E-07  6.30E-06
 
 OM13
+        3.78E-07 -1.73E-06 -5.26E-06 -9.01E-07 -5.38E-07  7.94E-08  9.72E-07  2.09E-06
 
 OM22
+       -5.98E-06  1.17E-05 -1.79E-04 -1.43E-04 -8.47E-05  1.89E-06  1.80E-05  4.56E-07  1.51E-04
 
 OM23
+       -1.37E-06 -3.45E-07 -1.53E-05 -3.54E-05  3.87E-05 -1.42E-07  9.32E-07  3.03E-06  1.09E-06  2.29E-05
 
 OM33
+        4.21E-07  6.49E-06  2.46E-05 -3.04E-05  2.28E-05  2.85E-08  8.34E-07  1.19E-06 -8.51E-06  4.13E-06  3.07E-05
 
 SG11
+        5.13E-05 -3.87E-04 -1.94E-04  1.61E-03 -1.21E-03 -2.43E-05 -2.54E-05 -3.26E-05 -6.29E-05 -2.44E-05 -7.07E-05  7.86E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************              CORRELATION MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM22      OM23      OM33      SG11  

 
 TH 1
+        4.02E-03
 
 TH 2
+        2.30E-01  2.72E-02
 
 TH 3
+        1.42E-01  4.22E-01  4.18E-02
 
 TH 4
+        8.13E-02 -6.49E-01 -3.49E-01  1.47E-01
 
 TH 5
+       -1.21E-02 -6.07E-01 -3.88E-01  4.63E-01  1.57E-01
 
 OM11
+       -1.37E-01 -5.07E-02 -2.09E-01  2.25E-02  4.01E-02  6.75E-04
 
 OM12
+       -4.81E-02  7.24E-02 -3.21E-01 -9.31E-02 -1.04E-01  5.65E-01  2.51E-03
 
 OM13
+        6.51E-02 -4.42E-02 -8.71E-02 -4.24E-03 -2.37E-03  8.14E-02  2.68E-01  1.44E-03
 
 OM22
+       -1.21E-01  3.52E-02 -3.48E-01 -7.91E-02 -4.38E-02  2.28E-01  5.83E-01  2.57E-02  1.23E-02
 
 OM23
+       -7.12E-02 -2.65E-03 -7.62E-02 -5.02E-02  5.13E-02 -4.38E-02  7.75E-02  4.38E-01  1.84E-02  4.79E-03
 
 OM33
+        1.89E-02  4.31E-02  1.06E-01 -3.72E-02  2.61E-02  7.61E-03  5.99E-02  1.49E-01 -1.25E-01  1.55E-01  5.54E-03
 
 SG11
+        4.55E-02 -5.08E-02 -1.65E-02  3.90E-02 -2.75E-02 -1.28E-01 -3.61E-02 -8.07E-02 -1.83E-02 -1.82E-02 -4.55E-02  2.80E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************           INVERSE COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM22      OM23      OM33      SG11  

 
 TH 1
+        7.94E+04
 
 TH 2
+       -6.59E+03  3.65E+03
 
 TH 3
+       -7.52E+02 -2.42E+02  9.60E+02
 
 TH 4
+       -8.18E+02  3.10E+02  4.79E+01  9.17E+01
 
 TH 5
+       -4.40E+02  2.21E+02  6.19E+01 -1.61E+00  7.26E+01
 
 OM11
+        7.80E+04 -1.27E+03 -6.17E+02 -8.47E+02 -1.46E+03  3.59E+06
 
 OM12
+       -1.69E+04 -1.27E+03  4.08E+03  3.66E+02  8.18E+02 -6.88E+05  4.23E+05
 
 OM13
+       -3.23E+04  6.71E+03  1.18E+02  3.31E+02  5.13E+02  1.08E+05 -1.48E+05  6.86E+05
 
 OM22
+        2.88E+03 -2.75E+02  6.86E+02  5.09E+01 -9.22E+00  3.87E+04 -3.75E+04  1.34E+04  1.17E+04
 
 OM23
+        8.58E+03 -1.12E+03  4.68E+02  6.92E+01 -1.85E+02  3.70E+04  4.03E+03 -8.50E+04 -4.28E+02  5.69E+04
 
 OM33
+        1.56E+03 -4.48E+02 -6.85E+02 -1.72E+01 -1.58E+02  1.90E+04 -1.94E+04 -8.03E+03  3.33E+03 -4.71E+03  3.57E+04
 
 SG11
+       -6.45E+01  1.97E+01  2.90E+00  3.14E-01  2.50E+00  9.28E+02 -1.63E+02  3.03E+02  1.49E+01 -2.37E+01  2.26E+01  1.33E+01
 
 Elapsed postprocess time in seconds:     0.00
 Elapsed finaloutput time in seconds:     0.00
 #CPUT: Total CPU Time in Seconds,     2055.142
Stop Time: 
Wed 09/18/2019 
12:26 PM
