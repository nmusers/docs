Wed 09/18/2019 
10:55 AM
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

$EST METHOD=ITS NITER=0 file=stanrb_177_its.ext
$EST METHOD=NUTS NBURN=500 NITER=500 PRINT=20 file=stanrb_177.ext
     OLKJDF=6.0
  
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
 RAW OUTPUT FILE (FILE): stanrb_177_its.ext
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

 iteration            0 OBJ=   43819.4442693216
 
 #TERM:
 OPTIMIZATION WAS NOT TESTED FOR CONVERGENCE


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -1.1334E-02 -1.0260E-01  1.6265E-01
 SE:             3.9766E-03  1.2304E-02  8.9866E-03
 N:                     900         900         900
 
 P VAL.:         4.3687E-03  7.5881E-17  3.4896E-73
 
 ETASHRINKSD(%)  8.3119E+01  4.7771E+01  6.1852E+01
 ETASHRINKVR(%)  9.7150E+01  7.2721E+01  8.5447E+01
 EBVSHRINKSD(%)  6.9891E-01  2.0245E+01  1.9313E+01
 EBVSHRINKVR(%)  1.3929E+00  3.6392E+01  3.4896E+01
 EPSSHRINKSD(%)  3.0548E+01
 EPSSHRINKVR(%)  5.1765E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         9000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    16540.8935976841     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    43819.4442693216     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       60360.3378670057     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2700
  
 PRIOR CONSTANT TO OBJECTIVE FUNCTION:    19.4354679649146     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    43819.4442693216     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       43838.8797372865     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:     0.56
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************    43819.444       **************************************************
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
 RAW OUTPUT FILE (FILE): stanrb_177.ext
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
 
 OMEGAS ARE GIBBS SAMPLED
 
 MONITORING OF SEARCH:

 Burn-in Mode
 iteration         -466 MCMCOBJ=    30719.1557357150     
 iteration         -460 MCMCOBJ=    28304.2388671178     
 iteration         -440 MCMCOBJ=    27960.8725276514     
 iteration         -420 MCMCOBJ=    27150.1190359443     
 iteration         -400 MCMCOBJ=    27252.8647156397     
 iteration         -380 MCMCOBJ=    27020.2144314653     
 iteration         -360 MCMCOBJ=    27074.4258472364     
 iteration         -340 MCMCOBJ=    26974.9869690016     
 iteration         -320 MCMCOBJ=    27262.0705089495     
 iteration         -300 MCMCOBJ=    27520.0335451677     
 iteration         -280 MCMCOBJ=    27676.3873472670     
 iteration         -260 MCMCOBJ=    27282.1226443583     
 iteration         -240 MCMCOBJ=    27066.1156189563     
 iteration         -220 MCMCOBJ=    27316.0778048555     
 iteration         -200 MCMCOBJ=    27355.7476576300     
 iteration         -180 MCMCOBJ=    27569.2757734804     
 iteration         -160 MCMCOBJ=    27421.7442152948     
 iteration         -140 MCMCOBJ=    27461.6313036796     
 iteration         -120 MCMCOBJ=    27651.2373275413     
 iteration         -100 MCMCOBJ=    27458.4183838388     
 iteration          -80 MCMCOBJ=    27466.1764904663     
 iteration          -60 MCMCOBJ=    27195.1733134800     
 iteration          -40 MCMCOBJ=    26977.1089988997     
 iteration          -20 MCMCOBJ=    27114.0296543944     
 Sampling Mode
 iteration            0 MCMCOBJ=    27483.3522544074     
 iteration           20 MCMCOBJ=    27337.5685930380     
 iteration           40 MCMCOBJ=    27616.8749403148     
 iteration           60 MCMCOBJ=    27432.2403395653     
 iteration           80 MCMCOBJ=    27478.9628198305     
 iteration          100 MCMCOBJ=    27543.6915849725     
 iteration          120 MCMCOBJ=    27265.6211893143     
 iteration          140 MCMCOBJ=    27210.4725930366     
 iteration          160 MCMCOBJ=    27415.6903674376     
 iteration          180 MCMCOBJ=    27135.6327849731     
 iteration          200 MCMCOBJ=    27656.9572666105     
 iteration          220 MCMCOBJ=    27570.5722165042     
 iteration          240 MCMCOBJ=    27555.2236849786     
 iteration          260 MCMCOBJ=    27510.2088659774     
 iteration          280 MCMCOBJ=    27387.3619709268     
 iteration          300 MCMCOBJ=    27388.4744376287     
 iteration          320 MCMCOBJ=    27298.7834674884     
 iteration          340 MCMCOBJ=    26971.9013092073     
 iteration          360 MCMCOBJ=    26568.3684053335     
 iteration          380 MCMCOBJ=    26722.6441227816     
 iteration          400 MCMCOBJ=    27189.4751133794     
 iteration          420 MCMCOBJ=    26477.4375966293     
 iteration          440 MCMCOBJ=    26442.3691839293     
 iteration          460 MCMCOBJ=    26783.1924405283     
 iteration          480 MCMCOBJ=    26469.5853467384     
 iteration          500 MCMCOBJ=    26804.1116481744     
 
 #TERM:
 BURN-IN WAS NOT TESTED FOR CONVERGENCE
 STATISTICAL PORTION WAS COMPLETED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.2493E-04  4.8643E-04 -2.9191E-04
 SE:             2.9168E-03  1.3458E-02  5.8507E-03
 N:                     900         900         900
 
 P VAL.:         9.6584E-01  9.7117E-01  9.6021E-01
 
 ETASHRINKSD(%)  1.3503E+01  4.2866E+00  1.7992E+01
 ETASHRINKVR(%)  2.5183E+01  8.3895E+00  3.2746E+01
 EBVSHRINKSD(%)  1.3659E+01  4.6060E+00  1.8369E+01
 EBVSHRINKVR(%)  2.5452E+01  8.9998E+00  3.3364E+01
 EPSSHRINKSD(%)  8.9481E+00
 EPSSHRINKVR(%)  1.7096E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         9000
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    16540.8935976841     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    27180.1659408618     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       43721.0595385459     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          2700
 NIND*NETA*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    4962.26807930523     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    27180.1659408618     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       32142.4340201671     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 PRIOR CONSTANT TO OBJECTIVE FUNCTION:   -10.0300439664667     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    27180.1659408618     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       27170.1358968954     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:  2916.96
 Elapsed covariance  time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 #OBJT:**************                       AVERAGE VALUE OF LIKELIHOOD FUNCTION                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************    27180.166       **************************************************
 #OBJS:********************************************      391.581 (STD) **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
        -2.86E-03  3.68E+00 -5.01E+00 -9.93E-01 -1.12E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        1.02E-02
 
 ETA2
+        2.61E-02  1.78E-01
 
 ETA3
+        1.42E-04 -4.24E-02  4.59E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.58E+01
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        1.01E-01
 
 ETA2
+        6.12E-01  4.22E-01
 
 ETA3
+        6.25E-03 -4.77E-01  2.14E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        3.97E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************                STANDARD ERROR OF ESTIMATE (From Sample Variance)               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
         4.07E-03  2.84E-02  4.24E-02  1.38E-01  1.65E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        6.86E-04
 
 ETA2
+        2.43E-03  1.29E-02
 
 ETA3
+        1.80E-03  6.32E-03  6.75E-03
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        2.75E-01
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        3.39E-03
 
 ETA2
+        4.06E-02  1.53E-02
 
 ETA3
+        8.21E-02  9.79E-02  1.59E-02
 


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
+        2.79E-05  8.09E-04
 
 TH 3
+        3.19E-05  6.78E-04  1.80E-03
 
 TH 4
+       -3.74E-06 -2.58E-03 -2.65E-03  1.91E-02
 
 TH 5
+        5.42E-05 -3.07E-03 -3.20E-03  1.08E-02  2.72E-02
 
 OM11
+       -1.47E-07  8.05E-07  4.25E-07 -4.48E-06 -1.48E-06  4.71E-07
 
 OM12
+        2.96E-07  2.65E-06 -1.95E-05 -2.96E-05  1.40E-06  8.41E-07  5.92E-06
 
 OM13
+        3.05E-07 -3.77E-06 -6.61E-06  5.04E-06  2.39E-05 -6.54E-08  1.34E-06  3.23E-06
 
 OM22
+        3.25E-06  1.55E-05 -1.21E-04 -1.08E-04 -2.01E-04  1.91E-06  1.88E-05  4.52E-06  1.65E-04
 
 OM23
+        1.26E-06  1.48E-05 -9.49E-06 -3.41E-05 -6.56E-05  2.01E-07  2.33E-06  5.63E-06  1.92E-05  3.99E-05
 
 OM33
+        4.63E-06  1.84E-05  3.24E-05 -3.04E-05  1.32E-05  4.07E-07  1.69E-06  1.15E-06  1.09E-05  1.72E-05  4.55E-05
 
 SG11
+        3.27E-06  7.28E-04  4.98E-04 -6.04E-04 -3.34E-03 -2.10E-05 -8.01E-05 -6.66E-06 -4.92E-04  1.25E-04 -8.47E-05  7.58E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************              CORRELATION MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM22      OM23      OM33      SG11  

 
 TH 1
+        4.07E-03
 
 TH 2
+        2.41E-01  2.84E-02
 
 TH 3
+        1.85E-01  5.62E-01  4.24E-02
 
 TH 4
+       -6.64E-03 -6.55E-01 -4.53E-01  1.38E-01
 
 TH 5
+        8.07E-02 -6.53E-01 -4.58E-01  4.72E-01  1.65E-01
 
 OM11
+       -5.25E-02  4.13E-02  1.46E-02 -4.72E-02 -1.31E-02  6.86E-04
 
 OM12
+        2.99E-02  3.82E-02 -1.89E-01 -8.79E-02  3.49E-03  5.04E-01  2.43E-03
 
 OM13
+        4.17E-02 -7.37E-02 -8.67E-02  2.03E-02  8.06E-02 -5.30E-02  3.06E-01  1.80E-03
 
 OM22
+        6.22E-02  4.25E-02 -2.21E-01 -6.06E-02 -9.45E-02  2.17E-01  6.02E-01  1.95E-01  1.29E-02
 
 OM23
+        4.90E-02  8.25E-02 -3.54E-02 -3.90E-02 -6.29E-02  4.63E-02  1.51E-01  4.95E-01  2.36E-01  6.32E-03
 
 OM33
+        1.69E-01  9.60E-02  1.13E-01 -3.25E-02  1.18E-02  8.78E-02  1.03E-01  9.52E-02  1.26E-01  4.04E-01  6.75E-03
 
 SG11
+        2.92E-03  9.30E-02  4.26E-02 -1.59E-02 -7.35E-02 -1.11E-01 -1.20E-01 -1.35E-02 -1.39E-01  7.17E-02 -4.56E-02  2.75E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************           INVERSE COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM22      OM23      OM33      SG11  

 
 TH 1
+        7.95E+04
 
 TH 2
+       -6.54E+03  3.88E+03
 
 TH 3
+       -1.58E+03 -3.99E+02  1.04E+03
 
 TH 4
+       -6.26E+02  3.03E+02  6.15E+01  1.01E+02
 
 TH 5
+       -8.42E+02  2.76E+02  6.53E+01  2.64E+00  7.81E+01
 
 OM11
+        5.21E+04  1.24E+02 -9.01E+03 -1.06E+03 -7.38E+02  3.26E+06
 
 OM12
+       -3.70E+03 -3.09E+03  3.64E+03  6.09E+02 -2.53E+02 -6.26E+05  4.16E+05
 
 OM13
+       -5.52E+03  4.57E+03 -2.53E+03  8.19E+01 -3.56E+02  3.65E+05 -1.73E+05  5.11E+05
 
 OM22
+       -3.47E+03  3.14E+02  6.75E+02  3.86E+01  1.81E+02  2.17E+04 -3.49E+04  7.16E+03  1.10E+04
 
 OM23
+        1.98E+03 -1.09E+03  8.26E+02 -1.78E+01  1.16E+02 -4.92E+04  2.55E+04 -7.85E+04 -3.83E+03  4.42E+04
 
 OM33
+       -4.59E+03 -1.98E+02 -8.53E+02 -5.73E+01 -1.54E+02 -2.31E+02 -7.26E+03  1.91E+04 -4.52E+02 -1.49E+04  2.88E+04
 
 SG11
+        6.77E+00 -1.90E+01  3.65E+00 -1.79E+00  7.25E-01  5.09E+02 -2.54E+01  1.18E+02  4.77E+01 -9.79E+01  4.81E+01  1.40E+01
 
 Elapsed postprocess time in seconds:     0.00
 Elapsed finaloutput time in seconds:     0.00
 #CPUT: Total CPU Time in Seconds,     2840.544
Stop Time: 
Wed 09/18/2019 
11:44 AM
