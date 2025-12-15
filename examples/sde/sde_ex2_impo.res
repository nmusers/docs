Thu 09/23/2021 
03:39 PM
; Based on sde_ex2_base.ctl, using SDE.f90 OTHER file, and .dat file modified.  From Christoffer Tornoe, example 2
$PROBLEM PK ODE HANDS ON ONE
$ABBR DES=FULL ; Must have this, so DA array is simple-mapped.

$INPUT ID TIME DV AMT CMT FLAG MDV SDE ; Add SDE data item.  Should have values between 0 and 5, as described in comments of SDE.f90
; The data item SDE must be added. It has values of 0,1,2,3,4, or 5:
; SDE (SDE data item)=0, BEGINNING OF SUBJECT, OR WHENEVER YOU WANT TO INITIALIZE SDE SYSTEM (SOMETIMES YOU WANT TO DO THIS
; EVEN WITHIN A SUBJECT, LIKE A NEW OCCASION)
; SDE=1, FIRST OBSERVATION OF PRESENT TIME.
; SDE=2 LAST OBSERVATION FOR PRESENT TIME.
; SDE=5 FIRST AND LAST OBSERVATION FOR PRESENT TIME.
; SDE=6, MIDDLE OBSERVAION FOR PRESENT TIME.
; THUS:
; DOSE RECORD, TIME=0, THEN SDE=0
; PK OBSERVATION, TIME=0.1, SDE=1
; PD OBSERVATION, TIME=0.1, SDE=6
; EFFICACY OBSERVATION, TIME=0.1, SDE=2  (SDE=2 SINCE NEXT RECORD HAS A NEW TIME)
; PK OBSERVATION, TIME=0.2, SDE=1
; PD OBSERVATION, TIME=0.2, SDE=2
; PK OBSERVATION, TIME=0.5, SDE=5
; PK OBSERVATION, TIME=1.0, SDE=5

$DATA   sde_ex2o.dat
        IGNORE=@

$SUBROUTINE ADVAN6 TOL=9 DP OTHER=SDE.f90

; nde=number of base equations, ncmt=number of observation compartments
$ABBR DECLARE SGW(3) ; need at least nde of these
$MODEL 
       COMP = (CENTRAL); there are nde base states from original sde_ex2_base.ctl
       COMP = (DFDX1)  ; need to add ncmt observation compartments for SDE
       COMP = (DPDT11) ; Will need (nde+1)*nde/2 of these for SDE

$PK
  IF(NEWIND.NE.2) OT = 0
   
  MU_1  = THETA(1)
  CL    = EXP(MU_1+ETA(1)) 
  MU_2  = THETA(2)
  VD    = EXP(MU_2+ETA(2))
  SGW1 = THETA(4) ;  Add estimable scalar for modeling the SDE noise.
  NCMT=1.0 ; number of compartments.  Added for calls to SDE_DER and SDE_CADD
  NDE=1.0 ; Number of original, base ODEs.  Added for calls to SDE_DER and SDE_CADD


$DES
 FIRSTEM=1 ; MAke sure FIRSTEM=1 so that DA arrays (Derivatives of DADT() wrt A()), are calculated, even when IMP is done.
 DADT(1) = - CL/VD*A(1) ; Original base derivative from sde_ex2_base.ctl
; NEXT DERIVATIVES ARE ACUALLY PREDICTIVE VALUES FOR COMPARTMENTS 1 AND 2, RESPECTIVELY
;  Derivatives of these with respect to A() will be calculated symbolically by DES routine created by NMTRAN
 DADT(2) = A(1)/VD ;  Add output equations, required for each CMT value.
; DUMMY PLACEMENT FOR DERIVATIVES OF THE STOCHASTIC ERROR SYSTEM.  THESE ARE FILLED OUT BY SDE_DER
SGW(1)=SGW1 ; Specify SGW with appropriate index , for appropriate DES equation number
;  the DA() array THEN contains all derivatives of DADT (=DXDT) with respect to A(=X).
; number of base model derivative equations (nde)=1, Number of compartments (ncmt)=1. 
; DA is a reserved array, dimensioned DA(IR,*)
"LAST
"      CALL SDE_DER(DADT,A,DA,IR,SGW,NDE,NCMT)
 
$ERROR (OBS ONLY)
  
     IPRED = A(1)/VD
     IRES  = DV - IPRED
     W     = THETA(3)
     IWRES = IRES/W
     WS=1000.0
; CENTRAL COMPARTMENT, PLASMA LEVELS
; EPS(1) = USER MODEL ERROR CONTRIBUTION
; EPS(2) = STOCHASTIC ERROR CONTRIBUTION.  THE WS IS JUST A PLACEHOLDER COEFFICIENT.  SDE_CADD WILL REPLACE THIS
; WITH THE CORRECT VALUE
     Y     = IPRED+W*EPS(1) + WS*EPS(2)
; SDE_CADD WILL EVALUATE THE TRUE COEFFICIENTS (WS) TO THE STOCHASTIC COMPONENTS.
;  In general, if you have nmcmt observation compartments, then first ncmt EPS() will pertain to
; measurement error, and the second ncmt set of EPS() will pertain to stochastic errors.
;  This means you cannot have L2 type correlations, and prop+additive should be packaged into a single EPS().
;  For two obervations, you may have:
;  IF(CMT==1) THEN
;  IPRED=A(1)/V
;  W=SQRT(THETA((5)*THETA(5)*IPED*IPRED+THETA(6)*THETA(6))
;  Y=IPRED+W*EPS(1)+WS*EPS(3)
;  ENDIF
;  IF(CMT==2) THEN
;  IPRED=A(2)/V
;  W=SQRT(THETA((7)*THETA(7)*IPED*IPRED+THETA(8)*THETA(8))
;  Y=IPRED+W*EPS(2)+WS*EPS(4)
;  ENDIF

; Number of compartments=1, number of base model derivative equations=1
"LAST
"       CALL SDE_CADD(A,HH,TIME,DV,CMT,NDE,NCMT,SDE)



$THETA (0,2.3)               ;1 CL
$THETA (0,3.5)               ;2 VD
$THETA (0, 2)               ;4 SIGMA
$THETA (0,1) ; SGW1

$OMEGA 0.1                  ;1 CL
$OMEGA 0.01                 ;2 VD

$SIGMA (1 FIX) (1 FIX)               ; PK

$EST METHOD=ITS INTERACTION LAPLACE NUMERICAL SLOW NOABORT PRINT=1 CTYPE=3 SIGL=5
$EST METHOD=IMP INTERACTION NOABORT SIGL=5 PRINT=1 IACCEPT=1.0 CTYPE=3
$EST MAXEVAL=9999 METHOD=1 LAPLACE INTER NOABORT NUMERICAL SLOW NSIG=3 PRINT=1 SIGL=9
$COV MATRIX=R UNCONDITIONAL

$TABLE ID TIME FLAG AMT CMT IPRED IRES IWRES
       ONEHEADER NOPRINT FILE=sde_ex2_impo.tab
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
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
 PK ODE HANDS ON ONE
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:      570
 NO. OF DATA ITEMS IN DATA SET:   9
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   3
 MDV DATA ITEM IS DATA ITEM NO.:  7
0INDICES PASSED TO SUBROUTINE PRED:
   9   2   4   0   0   0   5   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID TIME DV AMT CMT FLAG MDV SDE EVID
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 IPRED IRES IWRES
0FORMAT FOR DATA:
 (8E9.0,1F2.0)

 TOT. NO. OF OBS RECS:      540
 TOT. NO. OF INDIVIDUALS:       30
0LENGTH OF THETA:   4
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   2
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   2
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
 ID TIME FLAG AMT CMT IPRED IRES IWRES
1DOUBLE PRECISION PREDPP VERSION 7.5.1

 GENERAL NONLINEAR KINETICS MODEL (DVERK1, ADVAN6)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:   3
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         CENTRAL      ON         YES        YES        YES        YES
    2         DFDX1        ON         YES        YES        NO         NO
    3         DPDT11       ON         YES        YES        NO         NO
    4         OUTPUT       OFF        YES        NO         NO         NO
 INITIAL (BASE) TOLERANCE SETTINGS:
 NRD (RELATIVE) VALUE OF TOLERANCE:   9
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            *           *           *           *           *
    2            *           *           *           *           *
    3            *           *           *           *           *
    4            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      9
   TIME DATA ITEM IS DATA ITEM NO.:          2
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   4
   COMPT. NO. DATA ITEM IS DATA ITEM NO.:    5

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0DURING SIMULATION, ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 OTHERWISE, ERROR SUBROUTINE CALLED ONLY WITH OBSERVATION EVENTS.
0ERROR SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
0DES SUBROUTINE USES FULL STORAGE MODE.
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
 NO. OF FUNCT. EVALS. ALLOWED:            440
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
 RAW OUTPUT FILE (FILE): sde_ex2_impo.ext
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
 NRD (RELATIVE) VALUE OF TOLERANCE:   9
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:   9
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

 iteration            0 OBJ=   1537.57902768775
 iteration            1 OBJ=   1753.55883854614
 iteration            2 OBJ=   1728.07662769979
 iteration            3 OBJ=   1715.70076250636
 iteration            4 OBJ=   1698.16057081844
 iteration            5 OBJ=   1676.36101754834
 iteration            6 OBJ=   1657.78723625789
 iteration            7 OBJ=   1647.25566928682
 iteration            8 OBJ=   1589.73727526680
 iteration            9 OBJ=   1563.89045387455
 iteration           10 OBJ=   1531.82137447496
 iteration           11 OBJ=   1500.49123600692
 iteration           12 OBJ=   1440.93258964631
 iteration           13 OBJ=   1390.71151373010
 iteration           14 OBJ=   1377.44706678778
 iteration           15 OBJ=   1371.91879779123
 iteration           16 OBJ=   1364.80668092919
 iteration           17 OBJ=   1347.87820103457
 iteration           18 OBJ=   1345.47732068899
 iteration           19 OBJ=   1340.37997499244
 iteration           20 OBJ=   1320.16059100684
 iteration           21 OBJ=   1323.06165890303
 iteration           22 OBJ=   1308.42336285347
 iteration           23 OBJ=   1304.68626209014
 iteration           24 OBJ=   1292.38502074953
 iteration           25 OBJ=   1272.08404295541
 iteration           26 OBJ=   1268.49025384701
 iteration           27 OBJ=   1260.23874683432
 iteration           28 OBJ=   1253.97173523045
 iteration           29 OBJ=   1252.88314715909
 iteration           30 OBJ=   1253.25082997323
 iteration           31 OBJ=   1253.05252014757
 iteration           32 OBJ=   1252.72286733708
 iteration           33 OBJ=   1253.04782657632
 iteration           34 OBJ=   1253.22061261891
 iteration           35 OBJ=   1253.02763000660
 iteration           36 OBJ=   1253.07224209645
 Convergence achieved
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         8.0922E-04  9.3056E-05
 SE:             4.7426E-02  6.1818E-02
 N:                      30          30
 
 P VAL.:         9.8639E-01  9.9880E-01
 
 ETASHRINKSD(%)  5.1395E+00  1.8674E+00
 ETASHRINKVR(%)  1.0015E+01  3.6999E+00
 EBVSHRINKSD(%)  4.6241E+00  1.8122E+00
 EBVSHRINKVR(%)  9.0345E+00  3.5916E+00
 RELATIVEINF(%)  9.0960E+01  9.6402E+01
 EPSSHRINKSD(%)  7.2003E+00  7.2003E+00
 EPSSHRINKVR(%)  1.3882E+01  1.3882E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          540
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    992.453615861047     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    1253.07224209645     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       2245.52585795749     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            60
  
 #TERE:
 Elapsed estimation  time in seconds:    36.73
 Elapsed covariance  time in seconds:     0.01
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     1253.072       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         2.40E+00  3.47E+00  1.00E+00  5.25E+01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        7.50E-02
 
 ETA2
+        0.00E+00  1.19E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        1.00E+00
 
 EPS2
+        0.00E+00  1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        2.74E-01
 
 ETA2
+        0.00E+00  3.45E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        1.00E+00
 
 EPS2
+        0.00E+00  1.00E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                          STANDARD ERROR OF ESTIMATE (S)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         5.78E-02  7.89E-02  9.10E-02  2.30E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        2.77E-02
 
 ETA2
+        0.00E+00  3.83E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        0.00E+00
 
 EPS2
+        0.00E+00  0.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        5.06E-02
 
 ETA2
+       .........  5.55E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+       .........
 
 EPS2
+       ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (S)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11      SG12      SG22  
 
 TH 1
+        3.34E-03
 
 TH 2
+        7.39E-04  6.23E-03
 
 TH 3
+       -1.13E-03  2.40E-03  8.28E-03
 
 TH 4
+        2.39E-02 -6.49E-02 -1.86E-01  5.30E+00
 
 OM11
+       -5.26E-04 -3.34E-04  4.53E-04 -5.07E-03  7.69E-04
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.95E-04 -1.13E-03  4.06E-04  4.42E-04  1.24E-04  0.00E+00  1.47E-03
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (S)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11      SG12      SG22  
 
 TH 1
+        5.78E-02
 
 TH 2
+        1.62E-01  7.89E-02
 
 TH 3
+       -2.15E-01  3.34E-01  9.10E-02
 
 TH 4
+        1.79E-01 -3.57E-01 -8.89E-01  2.30E+00
 
 OM11
+       -3.28E-01 -1.52E-01  1.80E-01 -7.95E-02  2.77E-02
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -1.33E-01 -3.75E-01  1.16E-01  5.02E-03  1.17E-01  0.00E+00  3.83E-02
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (S)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11      SG12      SG22  
 
 TH 1
+        3.60E+02
 
 TH 2
+       -5.35E+01  2.43E+02
 
 TH 3
+        3.22E+01 -8.68E+01  6.81E+02
 
 TH 4
+       -9.56E-01  2.37E-01  2.25E+01  9.81E-01
 
 OM11
+        1.97E+02  9.02E+01 -2.30E+02 -6.38E+00  1.56E+03
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+        5.88E+00  1.93E+02 -2.36E+02 -5.99E+00  4.25E+01  0.00E+00  8.96E+02
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
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
 NO. OF FUNCT. EVALS. ALLOWED:            440
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
 RAW OUTPUT FILE (FILE): sde_ex2_impo.ext
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
 NRD (RELATIVE) VALUE OF TOLERANCE:   9
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:   9
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

 iteration            0 OBJ=   1213.24384792240 eff.=     449. Smpl.=     300. Fit.= 0.83721
 iteration            1 OBJ=   1211.07771150723 eff.=     235. Smpl.=     300. Fit.= 0.89591
 iteration            2 OBJ=   1210.72681834278 eff.=     307. Smpl.=     300. Fit.= 0.94590
 iteration            3 OBJ=   1210.84520148725 eff.=     277. Smpl.=     300. Fit.= 0.95796
 iteration            4 OBJ=   1210.58817184008 eff.=     314. Smpl.=     300. Fit.= 0.95890
 iteration            5 OBJ=   1210.87899408757 eff.=     288. Smpl.=     300. Fit.= 0.96143
 iteration            6 OBJ=   1210.50870282287 eff.=     308. Smpl.=     300. Fit.= 0.96269
 iteration            7 OBJ=   1210.60333626366 eff.=     299. Smpl.=     300. Fit.= 0.96101
 iteration            8 OBJ=   1210.68365609848 eff.=     304. Smpl.=     300. Fit.= 0.95989
 iteration            9 OBJ=   1210.83056768033 eff.=     304. Smpl.=     300. Fit.= 0.95715
 iteration           10 OBJ=   1210.67553684203 eff.=     296. Smpl.=     300. Fit.= 0.95885
 iteration           11 OBJ=   1210.67142510558 eff.=     304. Smpl.=     300. Fit.= 0.95919
 Convergence achieved
 iteration           11 OBJ=   1210.79229321802 eff.=     301. Smpl.=     300. Fit.= 0.95612
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -3.1272E-03  2.2694E-03
 SE:             4.4462E-02  6.1701E-02
 N:                      30          30
 
 P VAL.:         9.4393E-01  9.7066E-01
 
 ETASHRINKSD(%)  1.1634E+01  2.3091E+00
 ETASHRINKVR(%)  2.1914E+01  4.5649E+00
 EBVSHRINKSD(%)  1.0808E+01  1.6866E+00
 EBVSHRINKVR(%)  2.0449E+01  3.3448E+00
 RELATIVEINF(%)  7.9524E+01  9.6622E+01
 EPSSHRINKSD(%)  4.8343E+00  4.8343E+00
 EPSSHRINKVR(%)  9.4349E+00  9.4349E+00
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          540
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    992.453615861047     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    1210.79229321802     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       2203.24590907907     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            60
  
 #TERE:
 Elapsed estimation  time in seconds:    50.65
 Elapsed covariance  time in seconds:    17.48
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     1210.792       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         2.38E+00  3.48E+00  9.09E-01  5.30E+01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        7.59E-02
 
 ETA2
+        0.00E+00  1.20E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        1.00E+00
 
 EPS2
+        0.00E+00  1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        2.76E-01
 
 ETA2
+        0.00E+00  3.46E-01
 


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


         TH 1      TH 2      TH 3      TH 4     
 
         5.65E-02  6.43E-02  7.81E-02  3.87E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        2.65E-02
 
 ETA2
+        0.00E+00  3.51E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        0.00E+00
 
 EPS2
+        0.00E+00  0.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        4.81E-02
 
 ETA2
+       .........  5.08E-02
 


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
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11      SG12      SG22  
 
 TH 1
+        3.20E-03
 
 TH 2
+       -6.41E-05  4.13E-03
 
 TH 3
+       -1.55E-04  2.89E-05  6.10E-03
 
 TH 4
+        9.40E-03  5.13E-03 -1.99E-01  1.50E+01
 
 OM11
+       -7.18E-05 -9.82E-06  1.56E-04 -1.19E-02  7.04E-04
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -1.43E-05 -1.96E-05  7.09E-05 -5.29E-03  8.77E-05  0.00E+00  1.23E-03
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (R)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11      SG12      SG22  
 
 TH 1
+        5.65E-02
 
 TH 2
+       -1.77E-02  6.43E-02
 
 TH 3
+       -3.50E-02  5.75E-03  7.81E-02
 
 TH 4
+        4.30E-02  2.06E-02 -6.59E-01  3.87E+00
 
 OM11
+       -4.79E-02 -5.76E-03  7.52E-02 -1.16E-01  2.65E-02
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -7.22E-03 -8.69E-03  2.59E-02 -3.90E-02  9.42E-02  0.00E+00  3.51E-02
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (R)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM22      SG11      SG12      SG22  
 
 TH 1
+        3.14E+02
 
 TH 2
+        5.11E+00  2.42E+02
 
 TH 3
+        2.56E+00 -6.77E+00  2.90E+02
 
 TH 4
+       -1.42E-01 -1.74E-01  3.86E+00  1.19E-01
 
 OM11
+        2.91E+01  2.04E+00  1.20E+00  1.12E+00  1.45E+03
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+        9.11E-01  3.41E+00 -2.73E-01  2.06E-01 -9.84E+01  0.00E+00  8.19E+02
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      9
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     9
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): sde_ex2_impo.ext
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
 NRD (RELATIVE) VALUE OF TOLERANCE:   9
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:   9
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 TOLERANCES FOR TABLE/SCATTER STEP:
 NRD (RELATIVE) VALUE OF TOLERANCE:   9
 ANRD (ABSOLUTE) VALUE OF TOLERANCE:  12
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 MONITORING OF SEARCH:

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   1253.27929295461        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:        7
 NPARAMETR:  2.3821E+00  3.4770E+00  9.0872E-01  5.3041E+01  7.5949E-02  1.1967E-01
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:   1.1865E+05 -3.5781E+04  5.9465E+03  2.7879E+04  4.3748E+02 -1.5166E+04
 
0ITERATION NO.:    1    OBJECTIVE VALUE:   1251.44814984088        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:       17
 NPARAMETR:  2.3643E+00  3.4849E+00  9.0838E-01  5.2948E+01  7.5945E-02  1.1990E-01
 PARAMETER:  9.2500E-02  1.0226E-01  9.9624E-02  9.8238E-02  9.9972E-02  1.0096E-01
 GRADIENT:   6.1152E+05  1.0911E+06  3.7118E+05  1.0557E+06 -3.2160E+03  1.5737E+04
 
0ITERATION NO.:    2    OBJECTIVE VALUE:   1251.44814984088        NO. OF FUNC. EVALS.:  28
 CUMULATIVE NO. OF FUNC. EVALS.:       45
 NPARAMETR:  2.3643E+00  3.4849E+00  9.0838E-01  5.2948E+01  7.5945E-02  1.1990E-01
 PARAMETER:  9.2500E-02  1.0226E-01  9.9624E-02  9.8238E-02  9.9972E-02  1.0096E-01
 GRADIENT:   4.0259E+03  1.4487E+03  2.9960E+03  1.9095E+02  1.5474E+02  2.5997E+02
 
0ITERATION NO.:    3    OBJECTIVE VALUE:   1251.44814984088        NO. OF FUNC. EVALS.:  17
 CUMULATIVE NO. OF FUNC. EVALS.:       62
 NPARAMETR:  2.3643E+00  3.4849E+00  9.0838E-01  5.2948E+01  7.5945E-02  1.1990E-01
 PARAMETER:  9.2500E-02  1.0226E-01  9.9624E-02  9.8238E-02  9.9972E-02  1.0096E-01
 GRADIENT:   4.0259E+03  1.4487E+03  2.9960E+03  1.9095E+02  1.2536E+02  2.5997E+02
 NUMSIGDIG:         3.9         4.4         4.3         5.1         2.7         3.5
 
 #TERM:
0MINIMIZATION TERMINATED
 DUE TO ROUNDING ERRORS (ERROR=134)
 NO. OF FUNCTION EVALUATIONS USED:       62
 NO. OF SIG. DIGITS IN FINAL EST.:  2.7
 ADDITIONAL PROBLEMS OCCURRED WITH THE MINIMIZATION.
 REGARD THE RESULTS OF THE ESTIMATION STEP CAREFULLY, AND ACCEPT THEM ONLY
 AFTER CHECKING THAT THE COVARIANCE STEP PRODUCES REASONABLE OUTPUT.

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         3.3706E-02 -8.5058E-03
 SE:             4.7837E-02  6.2007E-02
 N:                      30          30
 
 P VAL.:         4.8106E-01  8.9089E-01
 
 ETASHRINKSD(%)  4.9239E+00  1.9181E+00
 ETASHRINKVR(%)  9.6053E+00  3.7994E+00
 EBVSHRINKSD(%)  4.9011E+00  1.7600E+00
 EBVSHRINKVR(%)  9.5619E+00  3.4891E+00
 RELATIVEINF(%)  9.0435E+01  9.6508E+01
 EPSSHRINKSD(%)  3.2845E+00  3.2845E+00
 EPSSHRINKVR(%)  6.4612E+00  6.4612E+00
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          540
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    992.453615861047     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    1251.44814984088     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       2243.90176570192     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            60
  
 #TERE:
 Elapsed estimation  time in seconds:    31.61
0R MATRIX ALGORITHMICALLY NON-POSITIVE-SEMIDEFINITE
 BUT NONSINGULAR
0COVARIANCE STEP ABORTED
 Elapsed covariance  time in seconds:    37.79
 Elapsed postprocess time in seconds:     0.51
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     1251.448       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         2.36E+00  3.48E+00  9.08E-01  5.29E+01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        7.59E-02
 
 ETA2
+        0.00E+00  1.20E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        1.00E+00
 
 EPS2
+        0.00E+00  1.00E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2     
 
 ETA1
+        2.76E-01
 
 ETA2
+        0.00E+00  3.46E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        1.00E+00
 
 EPS2
+        0.00E+00  1.00E+00
 
 Elapsed finaloutput time in seconds:     0.05
 #CPUT: Total CPU Time in Seconds,      174.953
Stop Time: 
Thu 09/23/2021 
03:42 PM
