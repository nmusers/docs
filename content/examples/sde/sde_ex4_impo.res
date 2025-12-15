Thu 09/23/2021 
10:37 AM
$PROBLEM EX4model2, FOCE, using OTHER routine sde.f90
$ABBR DECLARE SGW(3) ; need at least nde of these
$ABBR DES=FULL

$INPUT ID TIME DV MDV EVID AMT CMT AGE SEX BSA SDEX SDE

$DATA sde_ex4o.dat
      IGNORE @

$SUBROUTINE ADVAN13 TOL=6 ATOL=6 OTHER=SDE.F90

$MODEL
COMP=(CENTRAL)
COMP=(PERIPH)
COMP=(ISR)
COMP=(OBSQ)
COMP=(P1)
COMP=(P2)
COMP=(P3)
COMP=(P4)
COMP=(P5)
COMP=(P6)

$THETA (0 0.1) ; ISR0
$THETA (0 0.6) ; W
$THETA (0, 0.1) ; SGW3

$OMEGA 0.5     ; ISR0

$SIGMA 1 FIX
$SIGMA 1 FIX

$PK
T12A=4.52
ALPHA=LOG(2)/T12A
FRACA=0.78
FRACB=1-FRACA
T12B=0.14*AGE+29.2
BETA=LOG(2)/T12B
K21=(FRACA*BETA+FRACB*ALPHA)/(FRACA+FRACB)
K10=(ALPHA*BETA)/K21
K12=ALPHA+BETA-K21-K10
V1=1
IF (SEX.EQ.0) V1=1.92*BSA+0.64
IF (SEX.EQ.1) V1=1.11*BSA+2.04
TVISR0=THETA(1)
ISR0=TVISR0*EXP(ETA(1))
F1=ISR0/K10
F2=K12*F1/K21
F3=ISR0
SGW3=THETA(3)

ISR=A(3)
ISRV=0

NCMT=1
NDE=3

$DES
FIRSTEM=1
DADT(1) = A(3)-K10*A(1)-K12*A(1)+K21*A(2)
DADT(2) = K12*A(1)-K21*A(2)
DADT(3) = 0
DADT(4)=A(1)/V1
SGW(1)=0.0
SGW(2)=0.0
SGW(3)=SGW3
"LAST
"      CALL SDE_DER(DADT,A,DA,IR,SGW,NDE,NCMT)


$ERROR (OBS ONLY)
IPRED=A(1)/V1
IRES=DV-IPRED
W=THETA(2)
IWRES=IRES/W
WS=1000.0
Y=IPRED+W*EPS(1)+WS*EPS(2)
"LAST
"       CALL SDE_CADD(A,HH,TIME,DV,CMT,NDE,NCMT,SDE)

;$EST MAXEVAL=9999 METHOD=1 INTER NOABORT NSIG=2 PRINT=1 OPTMAP=1 ETADER=2 SIGL=6 MCETA=1 SLOW
$EST METHOD=IMP PRINT=1 CTYPE=3 OPTMAP=1 ETADER=2 SIGL=5 MCETA=1 SLOW NITER=200 IACCEPT=0.4

$COVARIANCE UNCONDITIONAL MATRIX=R

$TABLE ID TIME EVID SDE IPRED IRES IWRES
       TVISR0 W
       ISR ISRV
       AGE SEX BSA
       NOPRINT ONEHEADER FILE=sde_ex4_impo.tab
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  121) INTERACTION IS IMPLIED WITH EM/BAYES ESTIMATION METHODS
             
 (WARNING  45) $DES: VALUES HAVE NOT BEEN ASSIGNED TO ALL DADT VARIABLES.
 UNUSED COMPARTMENTS SHOULD BE OFF.
  
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
 EX4model2, FOCE, using OTHER routine sde.f90
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:      456
 NO. OF DATA ITEMS IN DATA SET:  12
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   3
 MDV DATA ITEM IS DATA ITEM NO.:  4
0INDICES PASSED TO SUBROUTINE PRED:
   5   2   6   0   0   0   7   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID TIME DV MDV EVID AMT CMT AGE SEX BSA SDEX SDE
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 TVISR0 ISR ISRV IPRED IRES W IWRES
0FORMAT FOR DATA:
 (12E6.0)

 TOT. NO. OF OBS RECS:      420
 TOT. NO. OF INDIVIDUALS:       12
0LENGTH OF THETA:   3
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   2
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
  0.0000E+00     0.1000E+00     0.1000E+07
  0.0000E+00     0.6000E+00     0.1000E+07
  0.0000E+00     0.1000E+00     0.1000E+07
0INITIAL ESTIMATE OF OMEGA:
 0.5000E+00
0INITIAL ESTIMATE OF SIGMA:
 0.1000E+01
 0.0000E+00   0.1000E+01
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
 HEADER:                YES
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID TIME EVID SDE IPRED IRES IWRES TVISR0 W ISR ISRV AGE SEX BSA
1DOUBLE PRECISION PREDPP VERSION 7.5.1

 GENERAL NONLINEAR KINETICS MODEL WITH STIFF/NONSTIFF EQUATIONS (LSODA, ADVAN13)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:   5
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         CENTRAL      ON         YES        YES        YES        YES
    2         PERIPH       ON         YES        YES        NO         NO
    3         ISR          ON         YES        YES        NO         NO
    4         OBSQ         ON         YES        YES        NO         NO
    5         P1           ON         YES        YES        NO         NO
    6         P2           ON         YES        YES        NO         NO
    7         P3           ON         YES        YES        NO         NO
    8         P4           ON         YES        YES        NO         NO
    9         P5           ON         YES        YES        NO         NO
   10         P6           ON         YES        YES        NO         NO
   11         OUTPUT       OFF        YES        NO         NO         NO
 INITIAL (BASE) TOLERANCE SETTINGS:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            *           6           *           *           *
    2            *           7           *           *           *
    3            *           8           *           *           *
    4            *           *           *           *           *
    5            *           *           *           *           *
    6            *           *           *           *           *
    7            *           *           *           *           *
    8            *           *           *           *           *
    9            *           *           *           *           *
   10            *           *           *           *           *
   11            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      5
   TIME DATA ITEM IS DATA ITEM NO.:          2
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   6
   COMPT. NO. DATA ITEM IS DATA ITEM NO.:    7

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0DURING SIMULATION, ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 OTHERWISE, ERROR SUBROUTINE CALLED ONLY WITH OBSERVATION EVENTS.
0ERROR SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
0DES SUBROUTINE USES FULL STORAGE MODE.
1
 
 
 #TBLN:      1
 #METH: Importance Sampling
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               SLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            288
 NO. OF SIG. FIGURES REQUIRED:            3
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   1
 ETA HESSIAN EVALUATION METHOD (ETADER):    2
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    1
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
 RAW OUTPUT FILE (FILE): sde_ex4_impo.ext
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
 ITERATIONS (NITER):                        200
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

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   6
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   6
 TOLERANCES FOR TABLE/SCATTER STEP:
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
 
 THETAS THAT ARE SIGMA-LIKE:
 
 
 MONITORING OF SEARCH:

 iteration            0 OBJ=   324.805584061531 eff.=     362. Smpl.=     300. Fit.= 0.94710
 iteration            1 OBJ=   301.943934597249 eff.=      96. Smpl.=     300. Fit.= 0.66952
 iteration            2 OBJ=   276.872073402801 eff.=     123. Smpl.=     300. Fit.= 0.70215
 iteration            3 OBJ=   252.289793717898 eff.=     120. Smpl.=     300. Fit.= 0.69421
 iteration            4 OBJ=   228.369771866092 eff.=     118. Smpl.=     300. Fit.= 0.68118
 iteration            5 OBJ=   204.123194961788 eff.=     119. Smpl.=     300. Fit.= 0.68710
 iteration            6 OBJ=   179.752518915381 eff.=     119. Smpl.=     300. Fit.= 0.68494
 iteration            7 OBJ=   154.398600694415 eff.=     126. Smpl.=     300. Fit.= 0.69498
 iteration            8 OBJ=   130.315228643691 eff.=     120. Smpl.=     300. Fit.= 0.67837
 iteration            9 OBJ=   105.223182176321 eff.=     122. Smpl.=     300. Fit.= 0.67821
 iteration           10 OBJ=   82.0190677623738 eff.=     118. Smpl.=     300. Fit.= 0.67367
 iteration           11 OBJ=   56.3675031356305 eff.=     125. Smpl.=     300. Fit.= 0.68684
 iteration           12 OBJ=   32.4252412429912 eff.=     122. Smpl.=     300. Fit.= 0.67739
 iteration           13 OBJ=   8.29284502559595 eff.=     120. Smpl.=     300. Fit.= 0.67235
 iteration           14 OBJ=  -16.2251464220672 eff.=     123. Smpl.=     300. Fit.= 0.67545
 iteration           15 OBJ=  -39.5947434698906 eff.=     117. Smpl.=     300. Fit.= 0.66526
 iteration           16 OBJ=  -64.3374706471601 eff.=     124. Smpl.=     300. Fit.= 0.67259
 iteration           17 OBJ=  -88.3050022780328 eff.=     121. Smpl.=     300. Fit.= 0.66916
 iteration           18 OBJ=  -112.161604482445 eff.=     120. Smpl.=     300. Fit.= 0.66247
 iteration           19 OBJ=  -135.705445579640 eff.=     118. Smpl.=     300. Fit.= 0.66330
 iteration           20 OBJ=  -160.293952875401 eff.=     123. Smpl.=     300. Fit.= 0.67502
 iteration           21 OBJ=  -183.589567609384 eff.=     122. Smpl.=     300. Fit.= 0.67562
 iteration           22 OBJ=  -207.406535979760 eff.=     121. Smpl.=     300. Fit.= 0.67601
 iteration           23 OBJ=  -231.130037302641 eff.=     122. Smpl.=     300. Fit.= 0.67164
 iteration           24 OBJ=  -254.572637743449 eff.=     120. Smpl.=     300. Fit.= 0.66842
 iteration           25 OBJ=  -277.987347813973 eff.=     120. Smpl.=     300. Fit.= 0.66557
 iteration           26 OBJ=  -301.842725138930 eff.=     122. Smpl.=     300. Fit.= 0.67461
 iteration           27 OBJ=  -324.779352208384 eff.=     121. Smpl.=     300. Fit.= 0.67438
 iteration           28 OBJ=  -347.530438702689 eff.=     118. Smpl.=     300. Fit.= 0.68241
 iteration           29 OBJ=  -370.509000974578 eff.=     123. Smpl.=     300. Fit.= 0.67406
 iteration           30 OBJ=  -391.519876401282 eff.=     118. Smpl.=     300. Fit.= 0.67165
 iteration           31 OBJ=  -412.784574492502 eff.=     114. Smpl.=     300. Fit.= 0.72885
 iteration           32 OBJ=  -432.938036049478 eff.=     130. Smpl.=     300. Fit.= 0.73565
 iteration           33 OBJ=  -400.174020049804 eff.=     141. Smpl.=     300. Fit.= 0.94692
 iteration           34 OBJ=  -419.742397459796 eff.=     187. Smpl.=     300. Fit.= 0.73477
 iteration           35 OBJ=  -442.910834342826 eff.=     125. Smpl.=     300. Fit.= 0.69704
 iteration           36 OBJ=  -464.184512846005 eff.=     121. Smpl.=     300. Fit.= 0.68952
 iteration           37 OBJ=  -480.170595344526 eff.=     120. Smpl.=     300. Fit.= 0.67323
 iteration           38 OBJ=  -494.827776638438 eff.=     134. Smpl.=     300. Fit.= 0.67053
 iteration           39 OBJ=  -505.590124747692 eff.=     118. Smpl.=     300. Fit.= 0.72157
 iteration           40 OBJ=  -515.187841660726 eff.=     116. Smpl.=     300. Fit.= 0.72171
 iteration           41 OBJ=  -521.671989641992 eff.=     124. Smpl.=     300. Fit.= 0.69933
 iteration           42 OBJ=  -526.661959290776 eff.=     121. Smpl.=     300. Fit.= 0.68213
 iteration           43 OBJ=  -531.727974076297 eff.=     121. Smpl.=     300. Fit.= 0.67862
 iteration           44 OBJ=  -536.008343719693 eff.=     123. Smpl.=     300. Fit.= 0.67236
 iteration           45 OBJ=  -538.303539553658 eff.=     118. Smpl.=     300. Fit.= 0.71289
 iteration           46 OBJ=  -542.177699286647 eff.=     122. Smpl.=     300. Fit.= 0.67549
 iteration           47 OBJ=  -543.940592560862 eff.=     121. Smpl.=     300. Fit.= 0.69484
 iteration           48 OBJ=  -545.221130077086 eff.=     117. Smpl.=     300. Fit.= 0.69287
 iteration           49 OBJ=  -546.693488472223 eff.=     121. Smpl.=     300. Fit.= 0.73128
 iteration           50 OBJ=  -548.179056662515 eff.=     118. Smpl.=     300. Fit.= 0.69628
 iteration           51 OBJ=  -549.616944477384 eff.=     121. Smpl.=     300. Fit.= 0.67016
 iteration           52 OBJ=  -550.723898016077 eff.=     121. Smpl.=     300. Fit.= 0.67219
 iteration           53 OBJ=  -551.010443781890 eff.=     120. Smpl.=     300. Fit.= 0.73664
 iteration           54 OBJ=  -552.301009816070 eff.=     121. Smpl.=     300. Fit.= 0.70223
 iteration           55 OBJ=  -552.658958735561 eff.=     121. Smpl.=     300. Fit.= 0.66833
 iteration           56 OBJ=  -553.500018877324 eff.=     123. Smpl.=     300. Fit.= 0.72709
 iteration           57 OBJ=  -553.555294110002 eff.=     119. Smpl.=     300. Fit.= 0.67000
 iteration           58 OBJ=  -553.711720161313 eff.=     118. Smpl.=     300. Fit.= 0.65959
 iteration           59 OBJ=  -553.679222791966 eff.=     124. Smpl.=     300. Fit.= 0.73542
 iteration           60 OBJ=  -553.817189230619 eff.=     119. Smpl.=     300. Fit.= 0.70127
 iteration           61 OBJ=  -554.911324259637 eff.=     121. Smpl.=     300. Fit.= 0.66348
 iteration           62 OBJ=  -555.228003477762 eff.=     122. Smpl.=     300. Fit.= 0.71633
 iteration           63 OBJ=  -553.948914369896 eff.=     120. Smpl.=     300. Fit.= 0.74774
 iteration           64 OBJ=  -555.364715869970 eff.=     117. Smpl.=     300. Fit.= 0.72065
 iteration           65 OBJ=  -555.465478709737 eff.=     127. Smpl.=     300. Fit.= 0.73643
 iteration           66 OBJ=  -555.426097839947 eff.=     119. Smpl.=     300. Fit.= 0.66640
 iteration           67 OBJ=  -555.580057293627 eff.=     118. Smpl.=     300. Fit.= 0.70737
 iteration           68 OBJ=  -555.757369583143 eff.=     123. Smpl.=     300. Fit.= 0.72940
 iteration           69 OBJ=  -555.613279904120 eff.=     119. Smpl.=     300. Fit.= 0.67768
 iteration           70 OBJ=  -555.523602597833 eff.=     119. Smpl.=     300. Fit.= 0.72361
 iteration           71 OBJ=  -555.522712154733 eff.=     121. Smpl.=     300. Fit.= 0.67010
 iteration           72 OBJ=  -554.729674635564 eff.=     115. Smpl.=     300. Fit.= 0.66703
 iteration           73 OBJ=  -555.377391787683 eff.=     121. Smpl.=     300. Fit.= 0.68470
 iteration           74 OBJ=  -556.193376340986 eff.=     127. Smpl.=     300. Fit.= 0.69141
 iteration           75 OBJ=  -553.877120954118 eff.=     120. Smpl.=     300. Fit.= 0.73666
 Ending Mode
 iteration           76 OBJ=  -555.112658688314 eff.=     113. Smpl.=     300. Fit.= 0.74752
 iteration           76 OBJ=  -556.408319712375 eff.=     128. Smpl.=     300. Fit.= 0.69043
 
 #TERM:
 OPTIMIZATION WAS NOT COMPLETED PRIOR TO USER INTERRUPT


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -5.5438E-03
 SE:             1.0919E-01
 N:                      12
 
 P VAL.:         9.5951E-01
 
 ETASHRINKSD(%)  1.0163E+01
 ETASHRINKVR(%)  1.9293E+01
 EBVSHRINKSD(%)  2.4056E+00
 EBVSHRINKVR(%)  4.7534E+00
 RELATIVEINF(%)  9.5247E+01
 EPSSHRINKSD(%)  2.0080E+00  7.6722E-01
 EPSSHRINKVR(%)  3.9757E+00  1.5286E+00
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          420
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    771.908367891925     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -556.408319712375     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       215.500048179550     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            12
  
 #TERE:
 Elapsed estimation  time in seconds:  2170.50
 Elapsed covariance  time in seconds:   165.13
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     -556.408       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         2.42E-01  9.00E-02  2.66E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1     
 
 ETA1
+        1.77E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        1.00E+00
 
 EPS2
+        0.00E+00  1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1     
 
 ETA1
+        4.21E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        1.00E+00
 
 EPS2
+        0.00E+00  1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                          STANDARD ERROR OF ESTIMATE (R)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         2.19E-02  7.65E-03  1.22E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1     
 
 ETA1
+        7.88E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        0.00E+00
 
 EPS2
+        0.00E+00  0.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1     
 
 ETA1
+        9.36E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+       .........
 
 EPS2
+       ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (R)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      SG11      SG12      SG22  
 
 TH 1
+        4.78E-04
 
 TH 2
+        9.83E-06  5.85E-05
 
 TH 3
+       -5.13E-07 -2.48E-06  1.48E-06
 
 OM11
+       -1.73E-04 -4.96E-05  3.94E-07  6.21E-03
 
 SG11
+       ......... ......... ......... ......... .........
 
 SG12
+       ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (R)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      SG11      SG12      SG22  
 
 TH 1
+        2.19E-02
 
 TH 2
+        5.88E-02  7.65E-03
 
 TH 3
+       -1.93E-02 -2.67E-01  1.22E-03
 
 OM11
+       -1.01E-01 -8.24E-02  4.11E-03  7.88E-02
 
 SG11
+       ......... ......... ......... ......... .........
 
 SG12
+       ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (R)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      OM11      SG11      SG12      SG22  
 
 TH 1
+        2.12E+03
 
 TH 2
+       -2.99E+02  1.86E+04
 
 TH 3
+        2.17E+02  3.10E+04  7.27E+05
 
 OM11
+        5.68E+01  1.38E+02  2.08E+02  1.64E+02
 
 SG11
+       ......... ......... ......... ......... .........
 
 SG12
+       ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... .........
 
 Elapsed postprocess time in seconds:     1.31
 Elapsed finaloutput time in seconds:     0.04
 #CPUT: Total CPU Time in Seconds,     2334.719
Stop Time: 
Thu 09/23/2021 
11:16 AM
