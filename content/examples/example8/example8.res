Fri 08/26/2022 
03:50 PM
;Model Desc: Two compartment Model, Using ADVAN3, TRANS4
;Project Name: nm7examples
;Project ID: NO PROJECT DESCRIPTION

$PROB RUN# Example 8 (from samp5l)
$abbr DECLARE INTEGER FIRST_WRITE 
$abbr DECLARE INTEGER FIRST_WRITE2

$INPUT C SET ID JID TIME  DV=CONC AMT=DOSE RATE EVID MDV CMT CLX V1X QX V2X SDIX SDSX
$DATA example8.csv IGNORE=C

$SUBROUTINES ADVAN3 TRANS4

$PK
include nonmem_reserved_general
; Request extra information for Bayesian analysis.  
; An extra call will then be made
; for accepted samples
BAYES_EXTRA_REQUEST=1
MU_1=THETA(1)
MU_2=THETA(2)
MU_3=THETA(3)
MU_4=THETA(4)
CL=DEXP(MU_1+ETA(1))
V1=DEXP(MU_2+ETA(2))
Q=DEXP(MU_3+ETA(3))
V2=DEXP(MU_4+ETA(4))
S1=V1
; When Bayes_extra=1, then this particular set of individual 
; parameters were "accepted"
; So you may record them if you wish

IF(BAYES_EXTRA==1 .AND. ITER_REPORT>=0 .AND.  FIRST_WRITE==0  .AND. NEWIND/=2) THEN
IF(PNM_RUN_MODE==PNM_SINGLE) THEN 

" OPEN(UNIT=53,FILE='example8.prr')
; If parallel, need to have different file name for each node
; best if a pnm file with -awnf is used, such as mpiwini8_awnf.pnm, 
; and command line option -maxlim=3.  This allows all files to be
; written to primary run directory, and not into worker folders.
ELSE 

" OPEN(UNIT=53,FILE='example8_'//trim(tfi(pnm_node_number))//'.prr')
ENDIF
IF(PNM_NODE_NUMBER==1) THEN ; Only first file should have header, 
; for easy merging later
; When a parallel run is completed you can merge the files with 
; (Windows):
; copy example8_*.prr example.prr
; (Linux):
; cat example8_*.prr > example.prr

" WRITE(53,94) 'ITER_REPORT  ',' ID          ',' CL            ',' V1            ',' Q            ',' V2            ',' OBJI '

" 94 FORMAT(A12,1X,A14,5(1X,A12))
ENDIF
FIRST_WRITE=1
ENDIF

IF(BAYES_EXTRA==1 .AND. ITER_REPORT>=0 .AND. NEWIND/=2 ) THEN
" WRITE(53,95) ITER_REPORT,ID,CL,V1,Q,V2,OBJI(NIREC,1)
" 95 FORMAT(I12,1X,F14.0,5(1X,1PG12.5))
ENDIF

$ERROR
include nonmem_reserved_general
BAYES_EXTRA_REQUEST=1
Y = F + F*EPS(1)

IF(BAYES_EXTRA==1 .AND. ITER_REPORT>=0 .AND. FIRST_WRITE2==0 ) THEN
IF(PNM_RUN_MODE==PNM_SINGLE) THEN
" OPEN(UNIT=54,FILE='example8.iwr')
ELSE
" OPEN(UNIT=54,FILE='example8_'//trim(tfi(pnm_node_number))//'.iwr')
ENDIF
IF(PNM_NODE_NUMBER==1) THEN ; Only one file should have header, 
; for easy merging later
; When a parallel run is completed you can merge the files with 
; (Windows):
; copy example8_*.iwr example.iwr
; (Linux):
; cat example8_*.iwr > example.iwr

" WRITE(54,96) 'ITER_REPORT      ','ID          ','TIME        ','F       '

" 96 FORMAT(A12,1X,A14,2(1X,A12))
ENDIF
FIRST_WRITE2=1
ENDIF

IF(BAYES_EXTRA==1 .AND. ITER_REPORT>=0 ) THEN

" WRITE(54,97) ITER_REPORT,ID,TIME,F

" 97 FORMAT(I12,1X,F14.0,2(1X,1PG12.5))
ENDIF

; Initial values of THETA

$THETA 
(2.0) ;[LN(CL)]
(2.0) ;[LN(V1)]
(2.0) ;[LN(Q)]
(2.0) ;[LN(V2)]
;INITIAL values of OMEGA

$OMEGA BLOCK(4)
0.15   ;[P]
0.01  ;[F]
0.15   ;[P]
0.01  ;[F]
0.01  ;[F]
0.15   ;[P]
0.01  ;[F]
0.01  ;[F]
0.01  ;[F]
0.15   ;[P]
;Initial value of SIGMA

$SIGMA 
(0.6 )   ;[P]

$PRIOR NWPRI
; Prior information to the THETAS.

$THETAP (2.0 FIX) (2.0 FIX) (2.0 FIX) (2.0 FIX)

$THETAPV BLOCK(4)
10000 FIX 
0.00 10000
0.00  0.00 10000
0.00  0.00 0.0 10000

; Prior information to the OMEGAS.

$OMEGAP BLOCK(4)
0.2 FIX 
0.0  0.2 
0.0  0.0 0.2
0.0  0.0 0.0 0.2

$OMEGAPD (4 FIX)

$EST METHOD=BAYES INTERACTION FILE=example8.ext NBURN=10000 NITER=1000 PRINT=100 NOPRIOR=0 RANMETHOD=P
     CTYPE=3 CINTERVAL=100
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.

 (MU_WARNING 20) MU_001: MU_ VARIABLE SHOULD NOT BE DEFINED AFTER VERBATIM CODE.
 
 LIM VALUES MAXLIM ASSESSED BY NMTRAN: 1,2,3,4,5,6,7,8,10,11,13,15,16,17        
  
Note: Analytical 2nd Derivatives are constructed in FSUBS but are never used.
      You may insert $ABBR DERIV2=NO after the first $PROB to save FSUBS construction and compilation time
  
  
License Registered to: NONMEM license (with RADAR5NM) for ICON Pharmacometrics Team
Expiration Date:    31 DEC 2030
Current Date:       26 AUG 2022
Days until program expires :3045
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.2
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 RUN# Example 8 (from samp5l)
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 CREATE/ADD TO FDATA.csv:        YES
 NO. OF DATA RECS IN DATA SET:      600
 NO. OF DATA ITEMS IN DATA SET:  17
 ID DATA ITEM IS DATA ITEM NO.:   3
 DEP VARIABLE IS DATA ITEM NO.:   6
 MDV DATA ITEM IS DATA ITEM NO.: 10
0INDICES PASSED TO SUBROUTINE PRED:
   9   5   7   8   0   0  11   0   0   0   0
0LABELS FOR DATA ITEMS:
 C SET ID JID TIME CONC DOSE RATE EVID MDV CMT CLX V1X QX V2X SDIX SDSX
0FORMAT FOR DATA:
 (2E2.0,3E4.0,E11.0,E4.0,4E2.0,2E7.0,E8.0,E7.0,E2.0,E5.0)

 TOT. NO. OF OBS RECS:      500
 TOT. NO. OF INDIVIDUALS:      100
0LENGTH OF THETA:   9
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS BLOCK FORM:
  1
  1  1
  1  1  1
  1  1  1  1
  0  0  0  0  2
  0  0  0  0  2  2
  0  0  0  0  2  2  2
  0  0  0  0  2  2  2  2
  0  0  0  0  0  0  0  0  3
  0  0  0  0  0  0  0  0  3  3
  0  0  0  0  0  0  0  0  3  3  3
  0  0  0  0  0  0  0  0  3  3  3  3
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
 -0.1000E+07     0.2000E+01     0.1000E+07
 -0.1000E+07     0.2000E+01     0.1000E+07
 -0.1000E+07     0.2000E+01     0.1000E+07
 -0.1000E+07     0.2000E+01     0.1000E+07
  0.2000E+01     0.2000E+01     0.2000E+01
  0.2000E+01     0.2000E+01     0.2000E+01
  0.2000E+01     0.2000E+01     0.2000E+01
  0.2000E+01     0.2000E+01     0.2000E+01
  0.4000E+01     0.4000E+01     0.4000E+01
0INITIAL ESTIMATE OF OMEGA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.1500E+00
                  0.1000E-01   0.1500E+00
                  0.1000E-01   0.1000E-01   0.1500E+00
                  0.1000E-01   0.1000E-01   0.1000E-01   0.1500E+00
        2                                                                                  YES
                  0.1000E+05
                  0.0000E+00   0.1000E+05
                  0.0000E+00   0.0000E+00   0.1000E+05
                  0.0000E+00   0.0000E+00   0.0000E+00   0.1000E+05
        3                                                                                  YES
                  0.2000E+00
                  0.0000E+00   0.2000E+00
                  0.0000E+00   0.0000E+00   0.2000E+00
                  0.0000E+00   0.0000E+00   0.0000E+00   0.2000E+00
0INITIAL ESTIMATE OF SIGMA:
 0.6000E+00
0
 PRIOR SUBROUTINE USER-SUPPLIED
1DOUBLE PRECISION PREDPP VERSION 7.5.2

 TWO COMPARTMENT MODEL (ADVAN3)
0MAXIMUM NO. OF BASIC PK PARAMETERS:   4
0BASIC PK PARAMETERS (AFTER TRANSLATION):
   BASIC PK PARAMETER NO.  1: ELIMINATION RATE (K)
   BASIC PK PARAMETER NO.  2: CENTRAL-TO-PERIPH. RATE (K12)
   BASIC PK PARAMETER NO.  3: PERIPH.-TO-CENTRAL RATE (K21)
 TRANSLATOR WILL CONVERT PARAMETERS
 CL, V1, Q, V2 TO K, K12, K21 (TRANS4)
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         CENTRAL      ON         NO         YES        YES        YES
    2         PERIPH.      ON         NO         YES        NO         NO
    3         OUTPUT       OFF        YES        NO         NO         NO
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            5           *           *           *           *
    2            *           *           *           *           *
    3            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      9
   TIME DATA ITEM IS DATA ITEM NO.:          5
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   7
   DOSE RATE DATA ITEM IS DATA ITEM NO.:     8
   COMPT. NO. DATA ITEM IS DATA ITEM NO.:   11

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 
 #PARA: PARAFILE=mpiwini8_awnf.pnm, PROTOCOL=MPI, NODES= 3
 
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
 NO. OF FUNCT. EVALS. ALLOWED:            2400
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
 RAW OUTPUT FILE (FILE): example8.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 EM OR BAYESIAN METHOD USED:                MCMC BAYESIAN (BAYES)
 BAYES INDIVIDUAL PARAMETERS ONLY: NO
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          0
 CONVERGENCE TYPE (CTYPE):                  3
 KEEP ITERATIONS (THIN):            1
 CONVERGENCE INTERVAL (CINTERVAL):          100
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 BURN-IN ITERATIONS (NBURN):                10000
 FIRST ITERATION FOR MAP (MAPITERS):          NO
 ITERATIONS (NITER):                        1000
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
 MC SAMPLES PER SUBJECT (ISAMPLE):          1
 RANDOM SAMPLING METHOD (RANMETHOD):        3UP
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
 SAMPLES FOR LOCAL SEARCH KERNEL (OSAMPLE_M2):           10
 SAMPLES FOR LOCAL UNIVARIATE SEARCH KERNEL (OSAMPLE_M3):10
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
   1   2   3   4
 THETAS THAT ARE GIBBS SAMPLED:
   1   2   3   4
 THETAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 SIGMAS THAT ARE GIBBS SAMPLED:
   1
 SIGMAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 OMEGAS ARE GIBBS SAMPLED
 
 MONITORING OF SEARCH:

 Burn-in Mode
 iteration       -10000 MCMCOBJ=    13544794135.2401     
 iteration        -9900 MCMCOBJ=   -2288.23232960127     
 iteration        -9800 MCMCOBJ=   -2294.12363448548     
 iteration        -9700 MCMCOBJ=   -2327.61762585588     
 iteration        -9600 MCMCOBJ=   -2330.81854442723     
 iteration        -9500 MCMCOBJ=   -2397.21331653637     
 iteration        -9400 MCMCOBJ=   -2318.20262620059     
 iteration        -9300 MCMCOBJ=   -2259.42238378596     
 iteration        -9200 MCMCOBJ=   -2264.89787101135     
 iteration        -9100 MCMCOBJ=   -2409.40681637208     
 iteration        -9000 MCMCOBJ=   -2268.49855008911     
 iteration        -8900 MCMCOBJ=   -2323.73531186842     
 Convergence achieved
 Sampling Mode
 iteration            0 MCMCOBJ=   -2257.91199923520     
 iteration          100 MCMCOBJ=   -2350.45370931749     
 iteration          200 MCMCOBJ=   -2326.59738060049     
 iteration          300 MCMCOBJ=   -2303.08504982790     
 iteration          400 MCMCOBJ=   -2237.86002263628     
 iteration          500 MCMCOBJ=   -2360.00108570786     
 iteration          600 MCMCOBJ=   -2259.82493598391     
 iteration          700 MCMCOBJ=   -2371.30336697537     
 iteration          800 MCMCOBJ=   -2385.93233218491     
 iteration          900 MCMCOBJ=   -2256.09126469926     
 iteration         1000 MCMCOBJ=   -2366.26587976205     
 
 #TERM:
 BURN-IN WAS COMPLETED
 STATISTICAL PORTION WAS COMPLETED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -1.9004E-04 -1.9299E-04  1.7416E-03 -3.1269E-05
 SE:             3.9049E-02  2.8574E-02  3.0711E-02  3.2288E-02
 N:                     100         100         100         100
 
 P VAL.:         9.9612E-01  9.9461E-01  9.5478E-01  9.9923E-01
 
 ETASHRINKSD(%)  6.5384E+00  2.6651E+01  3.1635E+01  1.9983E+01
 ETASHRINKVR(%)  1.2649E+01  4.6200E+01  5.3262E+01  3.5973E+01
 EBVSHRINKSD(%)  3.6237E+00  2.3367E+01  2.8976E+01  1.7161E+01
 EBVSHRINKVR(%)  7.1160E+00  4.1274E+01  4.9556E+01  3.1377E+01
 RELATIVEINF(%)  8.8982E+01  5.8059E+01  4.7276E+01  6.2014E+01
 EPSSHRINKSD(%)  3.0048E+01
 EPSSHRINKVR(%)  5.1067E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          500
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    918.938533204673     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -2304.77525938414     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -1385.83672617947     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                           400
 NIND*NETA*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    735.150826563738     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -2304.77525938414     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -1569.62443282040     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 PRIOR CONSTANT TO OBJECTIVE FUNCTION:    66.6250661892040     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -2304.77525938414     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -2238.15019319493     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:    28.66
 Elapsed covariance  time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 #OBJT:**************                       AVERAGE VALUE OF LIKELIHOOD FUNCTION                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************    -2304.775       **************************************************
 #OBJS:********************************************       42.193 (STD) **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         1.63E+00  1.56E+00  7.46E-01  2.35E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        1.75E-01
 
 ETA2
+       -1.22E-03  1.52E-01
 
 ETA3
+        1.17E-02 -2.48E-03  2.02E-01
 
 ETA4
+       -1.71E-02  1.57E-02  2.77E-02  1.63E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        5.86E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        4.16E-01
 
 ETA2
+       -9.95E-03  3.87E-01
 
 ETA3
+        5.56E-02 -1.46E-02  4.45E-01
 
 ETA4
+       -1.08E-01  9.74E-02  1.30E-01  4.01E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        2.42E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************                STANDARD ERROR OF ESTIMATE (From Sample Variance)               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         4.54E-02  5.59E-02  6.89E-02  5.32E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        2.92E-02
 
 ETA2
+        2.41E-02  3.40E-02
 
 ETA3
+        2.89E-02  3.43E-02  5.72E-02
 
 ETA4
+        2.23E-02  2.47E-02  3.56E-02  3.68E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        6.71E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        3.45E-02
 
 ETA2
+        1.47E-01  4.33E-02
 
 ETA3
+        1.47E-01  1.98E-01  6.38E-02
 
 ETA4
+        1.34E-01  1.50E-01  1.77E-01  4.52E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.38E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************               COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        2.06E-03
 
 TH 2
+        3.34E-04  3.12E-03
 
 TH 3
+        4.84E-04  3.76E-04  4.74E-03
 
 TH 4
+        1.45E-04  4.81E-04  1.60E-03  2.83E-03
 
 OM11
+        9.36E-05  1.85E-04  1.53E-04  4.79E-05  8.53E-04
 
 OM12
+        9.25E-05  1.91E-04  1.98E-04  7.46E-05  1.70E-04  5.83E-04
 
 OM13
+        7.35E-05  1.25E-04 -5.57E-05  1.39E-04  2.31E-04  7.78E-05  8.34E-04
 
 OM14
+        4.72E-05  6.84E-05  1.38E-04  8.29E-05  1.12E-04  1.14E-04  2.85E-04  4.99E-04
 
 OM22
+       -8.50E-05 -2.95E-04 -2.94E-04 -1.16E-04  1.08E-06 -2.66E-05 -2.80E-05  5.60E-06  1.16E-03
 
 OM23
+        9.23E-05  2.42E-04  5.49E-04  7.94E-05  7.94E-05  2.19E-04  5.73E-05  5.86E-05 -1.47E-04  1.18E-03
 
 OM24
+        4.60E-05  3.70E-05  2.40E-04  1.54E-04  3.05E-05  2.12E-05  1.78E-05  4.17E-05  9.19E-05  2.40E-04  6.09E-04
 
 OM33
+        3.32E-05 -2.62E-04  5.07E-04  1.84E-04  2.45E-04  1.28E-04  4.44E-04  2.26E-04  8.50E-05  1.22E-04  6.66E-05  3.27E-03
 
 OM34
+        8.32E-05 -1.33E-04  1.88E-04  1.18E-05  1.32E-04  1.11E-04  2.22E-04  2.19E-04  7.04E-05  2.11E-04  1.13E-04  1.30E-03
          1.27E-03
 
 OM44
+       -1.56E-05  3.50E-05  3.84E-05  1.88E-04  6.22E-05  1.97E-05  1.26E-04  5.92E-05  1.84E-05  1.27E-04  2.29E-04  4.37E-04
          7.14E-04  1.36E-03
 
 SG11
+       -1.76E-05  2.48E-05  3.30E-05  1.06E-05 -1.74E-05 -1.89E-05 -2.74E-05 -2.28E-05 -3.38E-05  6.19E-07 -3.96E-06 -1.20E-04
         -8.50E-05 -6.55E-05  4.50E-05
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************              CORRELATION MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        4.54E-02
 
 TH 2
+        1.32E-01  5.59E-02
 
 TH 3
+        1.55E-01  9.77E-02  6.89E-02
 
 TH 4
+        5.99E-02  1.62E-01  4.36E-01  5.32E-02
 
 OM11
+        7.07E-02  1.13E-01  7.63E-02  3.09E-02  2.92E-02
 
 OM12
+        8.45E-02  1.42E-01  1.19E-01  5.81E-02  2.41E-01  2.41E-02
 
 OM13
+        5.62E-02  7.72E-02 -2.80E-02  9.04E-02  2.74E-01  1.12E-01  2.89E-02
 
 OM14
+        4.65E-02  5.48E-02  8.97E-02  6.97E-02  1.71E-01  2.10E-01  4.43E-01  2.23E-02
 
 OM22
+       -5.51E-02 -1.55E-01 -1.25E-01 -6.39E-02  1.09E-03 -3.23E-02 -2.85E-02  7.37E-03  3.40E-02
 
 OM23
+        5.93E-02  1.26E-01  2.32E-01  4.35E-02  7.93E-02  2.64E-01  5.79E-02  7.65E-02 -1.26E-01  3.43E-02
 
 OM24
+        4.11E-02  2.68E-02  1.41E-01  1.17E-01  4.24E-02  3.56E-02  2.50E-02  7.57E-02  1.09E-01  2.84E-01  2.47E-02
 
 OM33
+        1.28E-02 -8.19E-02  1.29E-01  6.05E-02  1.46E-01  9.26E-02  2.69E-01  1.77E-01  4.37E-02  6.22E-02  4.72E-02  5.72E-02
 
 OM34
+        5.16E-02 -6.71E-02  7.66E-02  6.24E-03  1.27E-01  1.30E-01  2.16E-01  2.75E-01  5.82E-02  1.73E-01  1.29E-01  6.41E-01
          3.56E-02
 
 OM44
+       -9.32E-03  1.70E-02  1.52E-02  9.57E-02  5.78E-02  2.21E-02  1.19E-01  7.19E-02  1.47E-02  1.00E-01  2.52E-01  2.07E-01
          5.45E-01  3.68E-02
 
 SG11
+       -5.79E-02  6.61E-02  7.15E-02  2.97E-02 -8.86E-02 -1.16E-01 -1.42E-01 -1.52E-01 -1.48E-01  2.69E-03 -2.39E-02 -3.13E-01
         -3.56E-01 -2.65E-01  6.71E-03
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************           INVERSE COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        5.16E+02
 
 TH 2
+       -4.73E+01  3.58E+02
 
 TH 3
+       -5.35E+01  5.11E+00  3.00E+02
 
 TH 4
+        9.76E+00 -5.15E+01 -1.60E+02  4.65E+02
 
 OM11
+       -2.04E+01 -5.44E+01 -3.84E+01  3.61E+01  1.36E+03
 
 OM12
+       -3.35E+01 -7.77E+01 -1.81E+01 -2.14E+01 -3.17E+02  2.06E+03
 
 OM13
+       -4.46E+01 -3.04E+01  1.16E+02 -9.20E+01 -3.17E+02  7.51E+01  1.71E+03
 
 OM14
+        3.24E+01 -2.15E+01 -8.19E+01 -2.51E+00 -1.10E+01 -3.41E+02 -8.85E+02  2.78E+03
 
 OM22
+        2.55E+01  6.62E+01  4.58E+01  1.05E-01 -2.68E+01 -8.00E+00  5.26E+01 -7.19E+00  9.51E+02
 
 OM23
+        1.59E+01 -5.03E+01 -1.05E+02  6.60E+01  2.02E+01 -3.41E+02 -6.88E+01  9.88E+01  1.33E+02  1.09E+03
 
 OM24
+       -3.60E+01  1.03E+01 -4.14E+01 -5.71E+01 -3.15E+01  1.08E+02  6.30E+01 -1.65E+02 -2.31E+02 -4.06E+02  1.99E+03
 
 OM33
+        3.87E+01  2.23E+01 -5.31E+01 -2.31E+01 -3.95E+01  3.01E+00 -2.05E+02  1.64E+02  9.72E+00  6.68E+01 -2.29E+01  6.03E+02
 
 OM34
+       -7.80E+01  5.42E+01  1.06E-01  9.55E+01 -2.61E+00 -5.61E+01  1.42E+02 -5.71E+02 -6.69E+01 -2.36E+02  1.30E+02 -6.92E+02
          2.17E+03
 
 OM44
+        5.82E+01 -3.53E+01  2.79E+01 -9.19E+01 -8.18E+00  7.26E+01 -1.09E+02  2.62E+02  7.13E+01  6.12E+01 -3.62E+02  2.15E+02
         -8.91E+02  1.24E+03
 
 SG11
+        2.89E+02 -1.28E+02 -2.68E+02 -3.35E+01  8.73E+01  6.77E+02  4.85E+01  5.28E+02  6.52E+02 -1.62E+02 -3.23E+02  6.12E+02
          6.06E+02  8.61E+02  2.77E+04
 
 Elapsed postprocess time in seconds:     0.00
 Elapsed finaloutput time in seconds:     0.00
 #CPUT: Total CPU Time in Seconds,       82.078
Stop Time: 
Fri 08/26/2022 
03:51 PM
