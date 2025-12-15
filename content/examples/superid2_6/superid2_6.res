Thu 12/12/2019 
06:55 PM
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

;$EST METHOD=ITS INTERACTION PRINT=1 NSIG=3 NITER=12 SIGL=6 FNLETA=0
$EST METHOD=SAEM INTERACTION PRINT=1 NSIG=3 NBURN=30 NITER=100 CTYPE=3 CINTERVAL=50 SIGL=6
     levcenter=0
$EST METHOD=IMP INTERACTION PRINT=1 NSIG=3 NITER=10 CTYPE=3 ISAMPLE=300 SIGL=6 EONLY=1 MAPITER=0
$COV MATRIX=R UNCONDITIONAL
$TABLE  ID TIME CONC DOSE RATE EVID MDV CMT SID CID ETA1 ETA2 ETA3 ETA4 ETA5 ETA6
NOAPPEND ONEHEADER FILE=superid2_6.tab  NOPRINT
  
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
 #METH: Stochastic Approximation Expectation-Maximization
 
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
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    0
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      6
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     6
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): superid2_6.ext
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
 EM OR BAYESIAN METHOD USED:                STOCHASTIC APPROXIMATION EXPECTATION MAXIMIZATION (SAEM)
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          50
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 BURN-IN ITERATIONS (NBURN):                30
 FIRST ITERATION FOR MAP (MAPITERS):          NO
 ITERATIONS (NITER):                        100
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
 MC SAMPLES PER SUBJECT (ISAMPLE):          2
 RANDOM SAMPLING METHOD (RANMETHOD):        3U
 EXPECTATION ONLY (EONLY):                  0
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

 Stochastic/Burn-in Mode
 iteration          -30 SAEMOBJ=   22833.0787444951
 iteration          -29 SAEMOBJ=  -20276.2347835822
 iteration          -28 SAEMOBJ=  -29727.5594031926
 iteration          -27 SAEMOBJ=  -39004.0950721308
 iteration          -26 SAEMOBJ=  -47465.1113555143
 iteration          -25 SAEMOBJ=  -56646.3446640157
 iteration          -24 SAEMOBJ=  -64643.6105808550
 iteration          -23 SAEMOBJ=  -71179.3257888366
 iteration          -22 SAEMOBJ=  -75048.5374442100
 iteration          -21 SAEMOBJ=  -75871.6204559663
 iteration          -20 SAEMOBJ=  -76371.2264364016
 iteration          -19 SAEMOBJ=  -76623.4256004123
 iteration          -18 SAEMOBJ=  -76778.8866165759
 iteration          -17 SAEMOBJ=  -76812.7020158524
 iteration          -16 SAEMOBJ=  -76828.4144092772
 iteration          -15 SAEMOBJ=  -76873.2674039358
 iteration          -14 SAEMOBJ=  -76972.2763576185
 iteration          -13 SAEMOBJ=  -76888.0428125318
 iteration          -12 SAEMOBJ=  -77093.7404974990
 iteration          -11 SAEMOBJ=  -77029.2970383819
 iteration          -10 SAEMOBJ=  -77133.4235749066
 iteration           -9 SAEMOBJ=  -77168.2088674985
 iteration           -8 SAEMOBJ=  -77172.3866296333
 iteration           -7 SAEMOBJ=  -77099.2049533741
 iteration           -6 SAEMOBJ=  -77093.1615535859
 iteration           -5 SAEMOBJ=  -77102.9588578689
 iteration           -4 SAEMOBJ=  -77114.0931232178
 iteration           -3 SAEMOBJ=  -77179.6096458777
 iteration           -2 SAEMOBJ=  -77169.6223470074
 iteration           -1 SAEMOBJ=  -77025.5944772646
 Reduced Stochastic/Accumulation Mode
 iteration            0 SAEMOBJ=  -77178.3559697457
 iteration            1 SAEMOBJ=  -77457.9226680440
 iteration            2 SAEMOBJ=  -77585.7454195067
 iteration            3 SAEMOBJ=  -77649.4207860015
 iteration            4 SAEMOBJ=  -77693.2226917848
 iteration            5 SAEMOBJ=  -77708.1642129331
 iteration            6 SAEMOBJ=  -77731.9268886011
 iteration            7 SAEMOBJ=  -77753.4556525753
 iteration            8 SAEMOBJ=  -77765.5801852028
 iteration            9 SAEMOBJ=  -77783.2954556182
 iteration           10 SAEMOBJ=  -77795.4759292731
 iteration           11 SAEMOBJ=  -77807.7553012188
 iteration           12 SAEMOBJ=  -77814.9466687479
 iteration           13 SAEMOBJ=  -77820.4284606560
 iteration           14 SAEMOBJ=  -77823.9625200662
 iteration           15 SAEMOBJ=  -77824.5101380194
 iteration           16 SAEMOBJ=  -77827.2719061078
 iteration           17 SAEMOBJ=  -77826.6358723980
 iteration           18 SAEMOBJ=  -77828.7063699618
 iteration           19 SAEMOBJ=  -77829.7526083590
 iteration           20 SAEMOBJ=  -77830.2786146634
 iteration           21 SAEMOBJ=  -77832.0178227954
 iteration           22 SAEMOBJ=  -77830.9687008870
 iteration           23 SAEMOBJ=  -77831.6881366255
 iteration           24 SAEMOBJ=  -77833.0809936085
 iteration           25 SAEMOBJ=  -77836.0057868872
 iteration           26 SAEMOBJ=  -77836.3464320375
 iteration           27 SAEMOBJ=  -77839.3321559776
 iteration           28 SAEMOBJ=  -77838.0760974024
 iteration           29 SAEMOBJ=  -77839.1051482629
 iteration           30 SAEMOBJ=  -77838.5617388409
 iteration           31 SAEMOBJ=  -77841.4065685597
 iteration           32 SAEMOBJ=  -77842.4811566994
 iteration           33 SAEMOBJ=  -77843.1891315932
 iteration           34 SAEMOBJ=  -77845.6956443209
 iteration           35 SAEMOBJ=  -77846.3654323293
 iteration           36 SAEMOBJ=  -77847.0121355203
 iteration           37 SAEMOBJ=  -77846.9135531450
 iteration           38 SAEMOBJ=  -77847.7100481850
 iteration           39 SAEMOBJ=  -77850.7120310951
 iteration           40 SAEMOBJ=  -77850.9071154738
 iteration           41 SAEMOBJ=  -77850.0552545592
 iteration           42 SAEMOBJ=  -77849.4729880684
 iteration           43 SAEMOBJ=  -77851.0491253789
 iteration           44 SAEMOBJ=  -77852.4297696892
 iteration           45 SAEMOBJ=  -77852.7481499329
 iteration           46 SAEMOBJ=  -77854.8032921657
 iteration           47 SAEMOBJ=  -77854.5943338908
 iteration           48 SAEMOBJ=  -77856.2342330367
 iteration           49 SAEMOBJ=  -77857.5728926537
 iteration           50 SAEMOBJ=  -77858.4870753352
 iteration           51 SAEMOBJ=  -77858.6679247696
 iteration           52 SAEMOBJ=  -77859.7824137341
 iteration           53 SAEMOBJ=  -77860.7530387559
 iteration           54 SAEMOBJ=  -77861.8618445181
 iteration           55 SAEMOBJ=  -77861.9473263534
 iteration           56 SAEMOBJ=  -77863.1729048620
 iteration           57 SAEMOBJ=  -77863.9408158295
 iteration           58 SAEMOBJ=  -77865.2304989649
 iteration           59 SAEMOBJ=  -77865.3224402130
 iteration           60 SAEMOBJ=  -77865.2709043920
 iteration           61 SAEMOBJ=  -77865.7022414131
 iteration           62 SAEMOBJ=  -77865.0799381671
 iteration           63 SAEMOBJ=  -77866.2092960737
 iteration           64 SAEMOBJ=  -77866.9063362066
 iteration           65 SAEMOBJ=  -77866.4322777951
 iteration           66 SAEMOBJ=  -77866.7664685319
 iteration           67 SAEMOBJ=  -77867.0642504356
 iteration           68 SAEMOBJ=  -77866.9701160579
 iteration           69 SAEMOBJ=  -77867.5905082029
 iteration           70 SAEMOBJ=  -77869.3842255319
 iteration           71 SAEMOBJ=  -77868.4808572500
 iteration           72 SAEMOBJ=  -77867.7630310938
 iteration           73 SAEMOBJ=  -77868.2156165650
 iteration           74 SAEMOBJ=  -77868.4094940345
 iteration           75 SAEMOBJ=  -77868.2915111067
 iteration           76 SAEMOBJ=  -77867.8818012513
 iteration           77 SAEMOBJ=  -77868.1492715307
 iteration           78 SAEMOBJ=  -77869.0828396894
 iteration           79 SAEMOBJ=  -77869.4818334484
 iteration           80 SAEMOBJ=  -77870.4895311746
 iteration           81 SAEMOBJ=  -77870.7225217438
 iteration           82 SAEMOBJ=  -77871.3372379555
 iteration           83 SAEMOBJ=  -77871.1837592065
 iteration           84 SAEMOBJ=  -77871.7665749719
 iteration           85 SAEMOBJ=  -77872.1446612634
 iteration           86 SAEMOBJ=  -77872.4757706604
 iteration           87 SAEMOBJ=  -77872.6794675645
 iteration           88 SAEMOBJ=  -77873.0220287876
 iteration           89 SAEMOBJ=  -77873.2448321799
 iteration           90 SAEMOBJ=  -77872.8888511601
 iteration           91 SAEMOBJ=  -77872.9945561148
 iteration           92 SAEMOBJ=  -77873.1674519252
 iteration           93 SAEMOBJ=  -77873.1602181255
 iteration           94 SAEMOBJ=  -77873.4454955034
 iteration           95 SAEMOBJ=  -77873.5662505186
 iteration           96 SAEMOBJ=  -77873.8953342858
 iteration           97 SAEMOBJ=  -77873.8087519270
 iteration           98 SAEMOBJ=  -77873.8941623766
 iteration           99 SAEMOBJ=  -77874.0272939032
 iteration          100 SAEMOBJ=  -77874.4994413118
 
 #TERM:
 STOCHASTIC PORTION WAS NOT TESTED FOR CONVERGENCE
 REDUCED STOCHASTIC PORTION WAS COMPLETED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.9366E-03  5.1347E-04  1.2712E-17  1.2038E-17  5.5158E-06  1.6309E-05
 SE:             1.6229E-03  1.6985E-03  9.9605E-03  1.0729E-02  6.2284E-02  5.5727E-02
 N:                    2500        2500         250         250          25          25
 
 P VAL.:         2.3275E-01  7.6242E-01  1.0000E+00  1.0000E+00  9.9993E-01  9.9977E-01
 
 ETASHRINKSD(%)  1.2271E+01  1.2048E+01  1.0000E-10  3.4349E-03  3.2768E-04  1.0000E-10
 ETASHRINKVR(%)  2.3036E+01  2.2644E+01  1.0000E-10  6.8696E-03  6.5536E-04  1.0000E-10
 EBVSHRINKSD(%)  1.2253E+01  1.2039E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  2.3004E+01  2.2629E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  7.6721E+01  7.7095E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  1.1745E+01
 EPSSHRINKVR(%)  2.2111E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):        17500
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    32162.8486621635     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -77874.4994413118     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -45711.6507791483     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          5548
 NIND*NETA*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    10196.5419644385     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -77874.4994413118     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -67677.9574768733     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:   371.40
 Elapsed covariance  time in seconds:     0.52
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION               ********************
 #OBJT:**************                        FINAL VALUE OF LIKELIHOOD FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -77874.499       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION               ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         1.99E+00  3.63E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        8.56E-03
 
 ETA2
+       -5.49E-05  9.32E-03
 
 ETA3
+        0.00E+00  0.00E+00  2.48E-02
 
 ETA4
+        0.00E+00  0.00E+00  1.13E-03  2.88E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.01E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.81E-02  8.09E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.25E-02
 
 ETA2
+       -6.14E-03  9.66E-02
 
 ETA3
+        0.00E+00  0.00E+00  1.57E-01
 
 ETA4
+        0.00E+00  0.00E+00  4.22E-02  1.70E-01
 
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
 ********************                STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION               ********************
 ********************                          STANDARD ERROR OF ESTIMATE (S)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         6.94E-02  6.42E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        3.08E-04
 
 ETA2
+        2.31E-04  3.46E-04
 
 ETA3
+        0.00E+00  0.00E+00  2.13E-03
 
 ETA4
+        0.00E+00  0.00E+00  1.68E-03  2.46E-03
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.40E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.58E-02  2.88E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.28E-04
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.66E-03
 
 ETA2
+        2.59E-02  1.79E-03
 
 ETA3
+       ......... .........  6.76E-03
 
 ETA4
+       ......... .........  6.30E-02  7.25E-03
 
 ETA5
+       ......... ......... ......... .........  5.35E-02
 
 ETA6
+       ......... ......... ......... .........  2.56E-01  5.06E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        6.41E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION               ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (S)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        4.82E-03
 
 TH 2
+       -7.01E-04  4.12E-03
 
 OM11
+       -3.42E-07  6.70E-07  9.47E-08
 
 OM12
+       -5.54E-09 -1.64E-07  7.60E-09  5.36E-08
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        1.11E-06  2.62E-07 -1.03E-09 -7.71E-11  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.20E-07
 
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
+        5.59E-06  2.34E-05  1.98E-08  4.86E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -8.52E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  4.53E-06
 
 OM34
+        5.73E-06  6.38E-06 -5.00E-09 -1.60E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.08E-08  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -2.47E-07  2.82E-06
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -2.07E-06  4.04E-06  1.37E-08  3.54E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -9.55E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -7.20E-08 -2.17E-09  0.00E+00  0.00E+00  6.05E-06
 
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
+        3.92E-05  6.21E-04  2.97E-07  3.36E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.51E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  9.17E-06  3.36E-06  0.00E+00  0.00E+00  4.99E-06  0.00E+00  0.00E+00  1.16E-03
 
 OM56
+        4.57E-04 -3.26E-04 -1.57E-07  1.24E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.16E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -5.29E-06  1.77E-06  0.00E+00  0.00E+00 -1.45E-06  0.00E+00  0.00E+00 -5.66E-04  6.66E-04
 
 OM66
+       -8.64E-05  6.30E-04  1.47E-07 -1.02E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.20E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  3.06E-06 -3.92E-06  0.00E+00  0.00E+00  1.26E-06  0.00E+00  0.00E+00  2.66E-04 -2.41E-04  8.29E-04
 
 SG11
+        2.72E-08  3.15E-08 -3.45E-09 -1.20E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -4.48E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.43E-09  3.14E-10  0.00E+00  0.00E+00 -9.63E-10  0.00E+00  0.00E+00 -1.12E-07  3.03E-08 -5.83E-09  1.65E-08
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION               ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (S)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        6.94E-02
 
 TH 2
+       -1.57E-01  6.42E-02
 
 OM11
+       -1.60E-02  3.39E-02  3.08E-04
 
 OM12
+       -3.45E-04 -1.11E-02  1.07E-01  2.31E-04
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        4.60E-02  1.18E-02 -9.61E-03 -9.61E-04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.46E-04
 
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
+        3.78E-02  1.71E-01  3.03E-02  9.86E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.16E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.13E-03
 
 OM34
+        4.92E-02  5.92E-02 -9.68E-03 -4.11E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.86E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -6.91E-02  1.68E-03
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -1.21E-02  2.56E-02  1.81E-02  6.22E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.12E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -1.38E-02 -5.26E-04  0.00E+00  0.00E+00  2.46E-03
 
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
+        1.66E-02  2.84E-01  2.83E-02  4.27E-04  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.28E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.27E-01  5.88E-02  0.00E+00  0.00E+00  5.96E-02  0.00E+00  0.00E+00  3.40E-02
 
 OM56
+        2.55E-01 -1.97E-01 -1.97E-02  2.08E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.30E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -9.63E-02  4.09E-02  0.00E+00  0.00E+00 -2.29E-02  0.00E+00  0.00E+00 -6.44E-01  2.58E-02
 
 OM66
+       -4.33E-02  3.41E-01  1.66E-02 -1.53E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.21E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  4.99E-02 -8.10E-02  0.00E+00  0.00E+00  1.78E-02  0.00E+00  0.00E+00  2.72E-01 -3.24E-01  2.88E-02
 
 SG11
+        3.05E-03  3.83E-03 -8.74E-02 -4.06E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.01E-01  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  8.92E-03  1.46E-03  0.00E+00  0.00E+00 -3.05E-03  0.00E+00  0.00E+00 -2.55E-02  9.14E-03 -1.58E-03  1.28E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                STOCHASTIC APPROXIMATION EXPECTATION-MAXIMIZATION               ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (S)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        2.47E+02
 
 TH 2
+        5.54E+01  3.09E+02
 
 OM11
+        5.65E+02 -1.26E+03  1.08E+07
 
 OM12
+        6.60E+02  7.74E+02 -1.48E+06  1.90E+07
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.51E+03 -1.95E+03  1.63E+05  2.68E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  8.47E+06
 
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
+       -5.92E+02 -1.38E+03 -3.74E+04 -1.45E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.13E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.33E+05
 
 OM34
+       -3.34E+02 -9.63E+02  9.62E+03  1.12E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.07E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.59E+04  3.68E+05
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+        1.14E+02 -5.79E+01 -2.11E+04 -6.64E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.15E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  4.38E+03  1.78E+03  0.00E+00  0.00E+00  1.66E+05
 
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
+       -1.74E+02 -1.56E+02 -1.46E+03 -4.20E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.02E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -8.12E+02 -2.38E+03  0.00E+00  0.00E+00 -9.94E+02  0.00E+00  0.00E+00  1.70E+03
 
 OM56
+       -3.12E+02 -1.03E+02 -5.27E+01 -7.32E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.62E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.13E+03 -2.15E+03  0.00E+00  0.00E+00 -5.81E+02  0.00E+00  0.00E+00  1.47E+03  3.09E+03
 
 OM66
+       -5.17E+01 -2.09E+02 -3.36E+02  1.92E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.36E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  8.46E+02  2.48E+03  0.00E+00  0.00E+00 -4.68E+01  0.00E+00  0.00E+00 -2.22E+01  4.59E+02  1.51E+03
 
 SG11
+       -1.55E+03 -2.14E+03  2.19E+06  1.07E+06  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.36E+06  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -4.14E+04 -1.51E+04  0.00E+00  0.00E+00  1.48E+03  0.00E+00  0.00E+00  9.68E+03  5.44E+03  1.11E+03  6.20E+07
 
1
 
 
 #TBLN:      2
 #METH: Objective Function Evaluation by Importance Sampling
 
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
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    0
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      6
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     6
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): superid2_6.ext
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
 CONVERGENCE INTERVAL (CINTERVAL):          50
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 ITERATIONS (NITER):                        10
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
 MC SAMPLES PER SUBJECT (ISAMPLE):          300
 RANDOM SAMPLING METHOD (RANMETHOD):        3U
 EXPECTATION ONLY (EONLY):                  1
 PROPOSAL DENSITY SCALING RANGE
              (ISCALE_MIN, ISCALE_MAX):     0.100000000000000       ,10.0000000000000
 SAMPLE ACCEPTANCE RATE (IACCEPT):          0.400000000000000
 LONG TAIL SAMPLE ACCEPT. RATE (IACCEPTL):   0.00000000000000
 T-DIST. PROPOSAL DENSITY (DF):             0
 NO. ITERATIONS FOR MAP (MAPITER):          0
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

 iteration            0 OBJ=  -42315.2833918636 eff.=     300. Smpl.=     300. Fit.= 0.95205
 iteration            1 OBJ=  -42388.8589397547 eff.=     122. Smpl.=     300. Fit.= 0.79258
 iteration            2 OBJ=  -42422.4590903263 eff.=     120. Smpl.=     300. Fit.= 0.78797
 iteration            3 OBJ=  -42431.4688729780 eff.=     120. Smpl.=     300. Fit.= 0.78882
 iteration            4 OBJ=  -42438.7524563301 eff.=     120. Smpl.=     300. Fit.= 0.78875
 iteration            5 OBJ=  -42443.1107688027 eff.=     121. Smpl.=     300. Fit.= 0.78924
 iteration            6 OBJ=  -42443.3242183589 eff.=     120. Smpl.=     300. Fit.= 0.78871
 iteration            7 OBJ=  -42435.3595255774 eff.=     120. Smpl.=     300. Fit.= 0.78869
 iteration            8 OBJ=  -42437.1987220529 eff.=     120. Smpl.=     300. Fit.= 0.78890
 iteration            9 OBJ=  -42443.6295411257 eff.=     121. Smpl.=     300. Fit.= 0.78952
 iteration           10 OBJ=  -42437.9469488681 eff.=     121. Smpl.=     300. Fit.= 0.78988
 
 #TERM:
 EXPECTATION ONLY PROCESS WAS NOT TESTED FOR CONVERGENCE


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.2990E-03 -2.4796E-04  6.5392E-18 -5.7176E-18  5.2220E-04  5.7388E-04
 SE:             1.6221E-03  1.6988E-03  9.9749E-03  1.0718E-02  6.2388E-02  5.5598E-02
 N:                    2500        2500         250         250          25          25
 
 P VAL.:         4.2327E-01  8.8395E-01  1.0000E+00  1.0000E+00  9.9332E-01  9.9176E-01
 
 ETASHRINKSD(%)  1.2312E+01  1.2034E+01  1.0000E-10  1.0536E-01  1.0000E-10  2.3193E-01
 ETASHRINKVR(%)  2.3108E+01  2.2620E+01  1.0000E-10  2.1061E-01  1.0000E-10  4.6332E-01
 EBVSHRINKSD(%)  1.2170E+01  1.1919E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  2.2859E+01  2.2418E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  7.6878E+01  7.7318E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  1.1815E+01
 EPSSHRINKVR(%)  2.2235E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):        17500
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    32162.8486621635     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -42437.9469488681     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -10275.0982867045     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          5548
  
 #TERE:
 Elapsed estimation  time in seconds:   254.85
 Elapsed covariance  time in seconds:    27.12
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               OBJECTIVE FUNCTION EVALUATION BY IMPORTANCE SAMPLING             ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -42437.947       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               OBJECTIVE FUNCTION EVALUATION BY IMPORTANCE SAMPLING             ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         1.99E+00  3.63E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        8.56E-03
 
 ETA2
+       -5.49E-05  9.32E-03
 
 ETA3
+        0.00E+00  0.00E+00  2.48E-02
 
 ETA4
+        0.00E+00  0.00E+00  1.13E-03  2.88E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.01E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.81E-02  8.09E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.25E-02
 
 ETA2
+       -6.14E-03  9.66E-02
 
 ETA3
+        0.00E+00  0.00E+00  1.57E-01
 
 ETA4
+        0.00E+00  0.00E+00  4.22E-02  1.70E-01
 
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
 ********************               OBJECTIVE FUNCTION EVALUATION BY IMPORTANCE SAMPLING             ********************
 ********************                          STANDARD ERROR OF ESTIMATE (R)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         6.90E-02  6.36E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        3.12E-04
 
 ETA2
+        2.34E-04  3.45E-04
 
 ETA3
+        0.00E+00  0.00E+00  2.12E-03
 
 ETA4
+        0.00E+00  0.00E+00  1.68E-03  2.46E-03
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.22E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.46E-02  2.74E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.27E-04
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.69E-03
 
 ETA2
+        2.62E-02  1.78E-03
 
 ETA3
+       ......... .........  6.72E-03
 
 ETA4
+       ......... .........  6.29E-02  7.26E-03
 
 ETA5
+       ......... ......... ......... .........  5.07E-02
 
 ETA6
+       ......... ......... ......... .........  2.46E-01  4.82E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        6.33E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               OBJECTIVE FUNCTION EVALUATION BY IMPORTANCE SAMPLING             ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (R)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        4.76E-03
 
 TH 2
+       -7.02E-04  4.04E-03
 
 OM11
+       -3.44E-07  4.98E-07  9.73E-08
 
 OM12
+        3.21E-08 -1.76E-07  7.21E-09  5.47E-08
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        1.05E-06  8.08E-08  2.05E-10  5.92E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.19E-07
 
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
+        5.08E-06  2.19E-05  1.65E-08  3.47E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -8.18E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  4.48E-06
 
 OM34
+        5.29E-06  6.63E-06 -5.37E-09 -1.64E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.02E-08  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -2.27E-07  2.81E-06
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -1.79E-06  2.41E-06  1.41E-08  3.85E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.03E-08  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -8.96E-08  1.01E-08  0.00E+00  0.00E+00  6.07E-06
 
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
+        4.19E-05  5.32E-04  1.31E-07 -6.79E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.32E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  7.21E-06  3.32E-06  0.00E+00  0.00E+00  3.62E-06  0.00E+00  0.00E+00  1.04E-03
 
 OM56
+        4.28E-04 -2.75E-04 -7.59E-08  1.14E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.82E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -4.22E-06  1.65E-06  0.00E+00  0.00E+00 -7.90E-07  0.00E+00  0.00E+00 -4.94E-04  6.06E-04
 
 OM66
+       -8.29E-05  5.46E-04 -2.84E-08 -1.14E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -4.69E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.71E-06 -3.56E-06  0.00E+00  0.00E+00  1.43E-07  0.00E+00  0.00E+00  2.03E-04 -2.04E-04  7.52E-04
 
 SG11
+        3.74E-08  5.04E-08 -3.29E-09 -1.21E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -4.16E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.29E-09  2.66E-10  0.00E+00  0.00E+00 -1.59E-09  0.00E+00  0.00E+00 -8.45E-08  2.15E-08  6.86E-09  1.61E-08
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               OBJECTIVE FUNCTION EVALUATION BY IMPORTANCE SAMPLING             ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (R)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        6.90E-02
 
 TH 2
+       -1.60E-01  6.36E-02
 
 OM11
+       -1.60E-02  2.51E-02  3.12E-04
 
 OM12
+        1.99E-03 -1.18E-02  9.88E-02  2.34E-04
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        4.43E-02  3.69E-03  1.90E-03  7.34E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.45E-04
 
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
+        3.48E-02  1.63E-01  2.50E-02  7.00E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.12E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.12E-03
 
 OM34
+        4.57E-02  6.22E-02 -1.03E-02 -4.19E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.77E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -6.41E-02  1.68E-03
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -1.05E-02  1.54E-02  1.84E-02  6.68E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.21E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -1.72E-02  2.46E-03  0.00E+00  0.00E+00  2.46E-03
 
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
+        1.88E-02  2.60E-01  1.30E-02 -9.01E-04  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.99E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.06E-01  6.15E-02  0.00E+00  0.00E+00  4.56E-02  0.00E+00  0.00E+00  3.22E-02
 
 OM56
+        2.52E-01 -1.76E-01 -9.89E-03  1.98E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.14E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -8.11E-02  4.00E-02  0.00E+00  0.00E+00 -1.30E-02  0.00E+00  0.00E+00 -6.23E-01  2.46E-02
 
 OM66
+       -4.38E-02  3.13E-01 -3.32E-03 -1.77E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -4.96E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.95E-02 -7.75E-02  0.00E+00  0.00E+00  2.12E-03  0.00E+00  0.00E+00  2.30E-01 -3.03E-01  2.74E-02
 
 SG11
+        4.27E-03  6.25E-03 -8.33E-02 -4.07E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -9.51E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  8.52E-03  1.25E-03  0.00E+00  0.00E+00 -5.10E-03  0.00E+00  0.00E+00 -2.07E-02  6.88E-03  1.97E-03  1.27E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               OBJECTIVE FUNCTION EVALUATION BY IMPORTANCE SAMPLING             ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (R)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        2.48E+02
 
 TH 2
+        5.53E+01  3.08E+02
 
 OM11
+        5.35E+02 -1.25E+03  1.05E+07
 
 OM12
+        6.54E+02  8.54E+02 -1.34E+06  1.86E+07
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.55E+03 -1.92E+03  1.17E+05 -9.08E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00  8.60E+06
 
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
+       -5.67E+02 -1.38E+03 -3.23E+04 -1.10E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.02E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.34E+05
 
 OM34
+       -3.10E+02 -9.48E+02  1.30E+04  1.16E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.67E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.44E+04  3.69E+05
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+        1.01E+02 -4.13E+01 -2.24E+04 -8.91E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.33E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  4.40E+03  9.52E+02  0.00E+00  0.00E+00  1.65E+05
 
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
+       -1.72E+02 -1.56E+02 -3.12E+02 -4.20E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.99E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -6.21E+02 -2.37E+03  0.00E+00  0.00E+00 -8.48E+02  0.00E+00  0.00E+00  1.78E+03
 
 OM56
+       -3.11E+02 -1.03E+02  4.94E+02 -6.83E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.81E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.17E+03 -2.19E+03  0.00E+00  0.00E+00 -5.09E+02  0.00E+00  0.00E+00  1.51E+03  3.24E+03
 
 OM66
+       -5.22E+01 -2.05E+02  1.57E+03  1.50E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.10E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.02E+03  2.39E+03  0.00E+00  0.00E+00  1.01E+02  0.00E+00  0.00E+00  1.50E+01  5.00E+02  1.62E+03
 
 SG11
+       -1.62E+03 -2.17E+03  2.08E+06  8.72E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.21E+06  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -3.51E+04 -1.19E+04  0.00E+00  0.00E+00  1.00E+04  0.00E+00  0.00E+00  9.20E+03  5.10E+03  1.32E+03  6.34E+07
 
 Elapsed postprocess time in seconds:     0.87
 Elapsed finaloutput time in seconds:     1.19
 #CPUT: Total CPU Time in Seconds,      639.339
Stop Time: 
Thu 12/12/2019 
07:06 PM
