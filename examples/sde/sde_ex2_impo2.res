Thu 09/23/2021 
03:42 PM
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

$EST METHOD=ITS INTERACTION NOABORT PRINT=1 CTYPE=3 OPTMAP=1 ETADER=2 SIGLO=6 SIGL=6 MCETA=1
$EST METHOD=IMP INTERACTION NOABORT PRINT=1 IACCEPT=1.0 CTYPE=3 OPTMAP=0 ETADER=0 SIGLO=6 SIGL=6 MCETA=1 MAPITER=0
$EST MAXEVAL=9999 METHOD=1 INTER NOABORT NSIG=1 PRINT=1 OPTMAP=1 ETADER=2 SIGLO=6 SIGL=6 MCETA=1 SLOW
$COV MATRIX=R UNCONDITIONAL TOL=9 SIGL=8 SIGLO=8

$TABLE ID TIME FLAG AMT CMT IPRED IRES IWRES
       ONEHEADER NOPRINT FILE=sde_ex2_impo2.tab
  
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
 SIGDIGITS ETAHAT (SIGLO):                  8
 SIGDIGITS GRADIENTS (SIGL):                8
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
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            440
 NO. OF SIG. FIGURES REQUIRED:            3
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   1
 ETA HESSIAN EVALUATION METHOD (ETADER):    2
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    1
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
 RAW OUTPUT FILE (FILE): sde_ex2_impo2.ext
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

 iteration            0 OBJ=   1537.77408276645
 iteration            1 OBJ=   1370.60750277145
 iteration            2 OBJ=   1309.41661772743
 iteration            3 OBJ=   1261.14482634907
 iteration            4 OBJ=   1225.50222119930
 iteration            5 OBJ=   1211.66974600254
 iteration            6 OBJ=   1210.76818232865
 iteration            7 OBJ=   1210.85135242152
 iteration            8 OBJ=   1210.75424701526
 iteration            9 OBJ=   1210.75257137664
 iteration           10 OBJ=   1210.75631096532
 iteration           11 OBJ=   1210.75852853338
 iteration           12 OBJ=   1210.75641878960
 iteration           13 OBJ=   1210.75814660982
 iteration           14 OBJ=   1210.75999212043
 iteration           15 OBJ=   1210.75991762544
 iteration           16 OBJ=   1210.75862988061
 iteration           17 OBJ=   1210.75890551444
 iteration           18 OBJ=   1210.75846986851
 iteration           19 OBJ=   1210.75871157905
 Convergence achieved
 iteration           19 OBJ=   1210.75870482882
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         3.3991E-05  1.3228E-04
 SE:             4.4027E-02  6.1614E-02
 N:                      30          30
 
 P VAL.:         9.9938E-01  9.9829E-01
 
 ETASHRINKSD(%)  1.1056E+01  1.7454E+00
 ETASHRINKVR(%)  2.0889E+01  3.4603E+00
 EBVSHRINKSD(%)  1.1023E+01  1.7345E+00
 EBVSHRINKVR(%)  2.0832E+01  3.4390E+00
 RELATIVEINF(%)  7.9134E+01  9.6519E+01
 EPSSHRINKSD(%)  5.0125E+00  5.0125E+00
 EPSSHRINKVR(%)  9.7737E+00  9.7737E+00
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         1080
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    1984.90723172209     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    1210.75870482882     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       3195.66593655091     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            60
  
 #TERE:
 Elapsed estimation  time in seconds:    23.43
 Elapsed covariance  time in seconds:     0.23
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     1210.759       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               ITERATIVE TWO STAGE                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         2.40E+00  3.48E+00  9.10E-01  5.34E+01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        7.35E-02
 
 ETA2
+        0.00E+00  1.18E-01
 


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
+        2.71E-01
 
 ETA2
+        0.00E+00  3.43E-01
 


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
 
         6.28E-02  8.15E-02  8.56E-02  4.29E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        3.44E-02
 
 ETA2
+        0.00E+00  3.96E-02
 


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
+        6.35E-02
 
 ETA2
+       .........  5.76E-02
 


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
+        3.95E-03
 
 TH 2
+        8.48E-04  6.65E-03
 
 TH 3
+       -1.35E-03  1.66E-03  7.32E-03
 
 TH 4
+        8.12E-02 -5.96E-02 -1.97E-01  1.84E+01
 
 OM11
+       -7.79E-04 -7.58E-04  5.74E-04 -2.82E-02  1.19E-03
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -7.27E-05 -1.54E-03  3.52E-05  2.21E-02  1.10E-04  0.00E+00  1.56E-03
 
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
+        6.28E-02
 
 TH 2
+        1.66E-01  8.15E-02
 
 TH 3
+       -2.51E-01  2.38E-01  8.56E-02
 
 TH 4
+        3.02E-01 -1.71E-01 -5.36E-01  4.29E+00
 
 OM11
+       -3.60E-01 -2.70E-01  1.95E-01 -1.91E-01  3.44E-02
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.93E-02 -4.77E-01  1.04E-02  1.30E-01  8.06E-02  0.00E+00  3.96E-02
 
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
+        3.23E+02
 
 TH 2
+       -4.87E+01  2.46E+02
 
 TH 3
+        3.32E+01 -7.19E+01  2.18E+02
 
 TH 4
+       -9.74E-01  1.88E-01  1.95E+00  8.24E-02
 
 OM11
+        1.44E+02  1.43E+02 -7.43E+01  5.99E-01  1.07E+03
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -3.00E+01  2.28E+02 -9.64E+01 -1.11E+00  6.53E+01  0.00E+00  8.75E+02
 
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
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
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
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    1
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
 RAW OUTPUT FILE (FILE): sde_ex2_impo2.ext
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
 NO. ITERATIONS FOR MAP (MAPITER):          0
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

 iteration            0 OBJ=   1210.69377567411 eff.=     301. Smpl.=     300. Fit.= 0.98191
 iteration            1 OBJ=   1210.81946320248 eff.=     298. Smpl.=     300. Fit.= 0.96062
 iteration            2 OBJ=   1210.67652527951 eff.=     307. Smpl.=     300. Fit.= 0.96101
 iteration            3 OBJ=   1210.82955302516 eff.=     302. Smpl.=     300. Fit.= 0.96143
 iteration            4 OBJ=   1210.60940849871 eff.=     304. Smpl.=     300. Fit.= 0.96004
 iteration            5 OBJ=   1210.88986132490 eff.=     293. Smpl.=     300. Fit.= 0.96194
 iteration            6 OBJ=   1210.50549975135 eff.=     305. Smpl.=     300. Fit.= 0.96322
 iteration            7 OBJ=   1210.62095155276 eff.=     301. Smpl.=     300. Fit.= 0.96088
 iteration            8 OBJ=   1210.68054008964 eff.=     303. Smpl.=     300. Fit.= 0.95991
 iteration            9 OBJ=   1210.83507381709 eff.=     304. Smpl.=     300. Fit.= 0.95711
 iteration           10 OBJ=   1210.66912519674 eff.=     295. Smpl.=     300. Fit.= 0.95884
 iteration           11 OBJ=   1210.67028318268 eff.=     304. Smpl.=     300. Fit.= 0.95916
 Convergence achieved
 iteration           11 OBJ=   1210.79097763898 eff.=     301. Smpl.=     300. Fit.= 0.95610
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:        -3.1267E-03  2.2824E-03
 SE:             4.4431E-02  6.1693E-02
 N:                      30          30
 
 P VAL.:         9.4390E-01  9.7049E-01
 
 ETASHRINKSD(%)  1.1668E+01  2.3132E+00
 ETASHRINKVR(%)  2.1974E+01  4.5728E+00
 EBVSHRINKSD(%)  1.0837E+01  1.6897E+00
 EBVSHRINKVR(%)  2.0499E+01  3.3509E+00
 RELATIVEINF(%)  7.9473E+01  9.6616E+01
 EPSSHRINKSD(%)  4.9104E+00  4.9104E+00
 EPSSHRINKVR(%)  9.5796E+00  9.5796E+00
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          540
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    992.453615861047     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    1210.79097763898     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       2203.24459350002     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            60
  
 #TERE:
 Elapsed estimation  time in seconds:    58.92
 Elapsed covariance  time in seconds:    21.34
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     1210.791       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         2.38E+00  3.48E+00  9.09E-01  5.31E+01
 


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
 
         5.65E-02  6.43E-02  7.83E-02  3.90E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        2.66E-02
 
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
+        4.82E-02
 
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
+       -6.42E-05  4.13E-03
 
 TH 3
+       -1.55E-04  2.79E-05  6.12E-03
 
 TH 4
+        9.57E-03  5.31E-03 -2.00E-01  1.52E+01
 
 OM11
+       -7.23E-05 -1.03E-05  1.57E-04 -1.25E-02  7.05E-04
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -1.46E-05 -2.02E-05  7.09E-05 -5.91E-03  8.83E-05  0.00E+00  1.23E-03
 
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
+       -3.51E-02  5.54E-03  7.83E-02
 
 TH 4
+        4.34E-02  2.12E-02 -6.57E-01  3.90E+00
 
 OM11
+       -4.82E-02 -6.06E-03  7.54E-02 -1.21E-01  2.66E-02
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+       -7.38E-03 -8.95E-03  2.58E-02 -4.31E-02  9.47E-02  0.00E+00  3.51E-02
 
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
+        5.12E+00  2.42E+02
 
 TH 3
+        2.56E+00 -6.76E+00  2.88E+02
 
 TH 4
+       -1.42E-01 -1.74E-01  3.80E+00  1.17E-01
 
 OM11
+        2.91E+01  2.05E+00  3.72E+00  1.19E+00  1.45E+03
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM22
+        9.09E-01  3.44E+00  1.32E+00  2.53E-01 -9.83E+01  0.00E+00  8.19E+02
 
 SG11
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
1
 
 
 #TBLN:      3
 #METH: First Order Conditional Estimation with Interaction
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               SLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            9999
 NO. OF SIG. FIGURES REQUIRED:            1
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 ABORT WITH PRED EXIT CODE 1:             NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   1
 ETA HESSIAN EVALUATION METHOD (ETADER):    2
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    1
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
 RAW OUTPUT FILE (FILE): sde_ex2_impo2.ext
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

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   1210.75780922782        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:        7
 NPARAMETR:  2.3821E+00  3.4770E+00  9.0892E-01  5.3115E+01  7.5901E-02  1.1965E-01
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:  -7.4254E+00 -5.3923E+00  1.8309E+00  1.5870E+00  6.1172E-01 -2.0042E+00
 
0ITERATION NO.:    1    OBJECTIVE VALUE:   1210.73731868989        NO. OF FUNC. EVALS.:  11
 CUMULATIVE NO. OF FUNC. EVALS.:       18
 NPARAMETR:  2.3892E+00  3.4845E+00  9.0825E-01  5.3081E+01  7.5864E-02  1.1984E-01
 PARAMETER:  1.0297E-01  1.0215E-01  9.9269E-02  9.9366E-02  9.9756E-02  1.0080E-01
 GRADIENT:  -8.8879E+00  2.1691E+00 -1.0827E+01 -2.2030E+01 -2.0505E+00 -7.0373E-01
 
0ITERATION NO.:    2    OBJECTIVE VALUE:   1210.73203824808        NO. OF FUNC. EVALS.:  11
 CUMULATIVE NO. OF FUNC. EVALS.:       29
 NPARAMETR:  2.3914E+00  3.4838E+00  9.0925E-01  5.3200E+01  7.5896E-02  1.1986E-01
 PARAMETER:  1.0386E-01  1.0193E-01  1.0036E-01  1.0159E-01  9.9963E-02  1.0087E-01
 GRADIENT:   2.5774E+00  1.7321E+01 -6.3225E+00 -5.0761E+00 -1.5740E+00  2.5303E+00
 
0ITERATION NO.:    3    OBJECTIVE VALUE:   1210.73179658490        NO. OF FUNC. EVALS.:  11
 CUMULATIVE NO. OF FUNC. EVALS.:       40
 NPARAMETR:  2.3914E+00  3.4811E+00  9.0965E-01  5.3230E+01  7.5911E-02  1.1984E-01
 PARAMETER:  1.0390E-01  1.0117E-01  1.0080E-01  1.0215E-01  1.0006E-01  1.0078E-01
 GRADIENT:  -8.0071E-01 -7.6490E+00 -1.0933E+01 -2.4990E+00 -5.6521E+00  1.0152E-01
 
0ITERATION NO.:    4    OBJECTIVE VALUE:   1210.73113694749        NO. OF FUNC. EVALS.:  12
 CUMULATIVE NO. OF FUNC. EVALS.:       52
 NPARAMETR:  2.3912E+00  3.4808E+00  9.0999E-01  5.3231E+01  7.5939E-02  1.1983E-01
 PARAMETER:  1.0382E-01  1.0109E-01  1.0118E-01  1.0219E-01  1.0025E-01  1.0072E-01
 GRADIENT:   1.0998E+00  9.2932E+00  3.2521E+00  8.9326E+00  9.4859E-01  2.8991E+00
 
0ITERATION NO.:    5    OBJECTIVE VALUE:   1210.73113694749        NO. OF FUNC. EVALS.:  20
 CUMULATIVE NO. OF FUNC. EVALS.:       72
 NPARAMETR:  2.3912E+00  3.4808E+00  9.0999E-01  5.3231E+01  7.5939E-02  1.1983E-01
 PARAMETER:  1.0382E-01  1.0109E-01  1.0118E-01  1.0219E-01  1.0025E-01  1.0072E-01
 GRADIENT:   7.0538E-01 -1.4729E+00  9.4143E-02  2.6267E-01  5.5475E-01  9.0376E-02
 
0ITERATION NO.:    6    OBJECTIVE VALUE:   1210.73064252129        NO. OF FUNC. EVALS.:  17
 CUMULATIVE NO. OF FUNC. EVALS.:       89
 NPARAMETR:  2.3904E+00  3.4813E+00  9.0993E-01  5.3240E+01  7.5884E-02  1.1981E-01
 PARAMETER:  1.0345E-01  1.0123E-01  1.0111E-01  1.0234E-01  9.9887E-02  1.0064E-01
 GRADIENT:   2.5745E-01 -6.5187E-01 -1.9264E-02  6.1866E-01  9.6965E-02  5.2347E-01
 
0ITERATION NO.:    7    OBJECTIVE VALUE:   1210.73022710834        NO. OF FUNC. EVALS.:  15
 CUMULATIVE NO. OF FUNC. EVALS.:      104
 NPARAMETR:  2.3894E+00  3.4830E+00  9.1018E-01  5.3256E+01  7.5717E-02  1.1917E-01
 PARAMETER:  1.0305E-01  1.0171E-01  1.0138E-01  1.0266E-01  9.8785E-02  9.7973E-02
 GRADIENT:  -1.8570E+00  1.7154E+00  9.2146E-01  1.0939E+00  1.2399E-01 -1.6025E-01
 
0ITERATION NO.:    8    OBJECTIVE VALUE:   1210.72880211137        NO. OF FUNC. EVALS.:  15
 CUMULATIVE NO. OF FUNC. EVALS.:      119
 NPARAMETR:  2.3905E+00  3.4828E+00  9.1124E-01  5.3231E+01  7.5483E-02  1.1908E-01
 PARAMETER:  1.0353E-01  1.0167E-01  1.0254E-01  1.0218E-01  9.7240E-02  9.7601E-02
 GRADIENT:   9.9508E-01  1.3360E+00  1.3904E+00  7.3623E-01  4.9866E-01  3.3279E-01
 
0ITERATION NO.:    9    OBJECTIVE VALUE:   1210.72880211137        NO. OF FUNC. EVALS.:   0
 CUMULATIVE NO. OF FUNC. EVALS.:      119
 NPARAMETR:  2.3905E+00  3.4828E+00  9.1124E-01  5.3231E+01  7.5483E-02  1.1908E-01
 PARAMETER:  1.0353E-01  1.0167E-01  1.0254E-01  1.0218E-01  9.7240E-02  9.7601E-02
 GRADIENT:   9.9508E-01  1.3360E+00  1.3904E+00  7.3623E-01  4.9866E-01  3.3279E-01
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      119
 NO. OF SIG. DIGITS IN FINAL EST.:  1.6

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         6.9714E-03 -2.3038E-03
 SE:             4.4349E-02  6.1655E-02
 N:                      30          30
 
 P VAL.:         8.7509E-01  9.7019E-01
 
 ETASHRINKSD(%)  1.1587E+01  2.1387E+00
 ETASHRINKVR(%)  2.1832E+01  4.2317E+00
 EBVSHRINKSD(%)  1.0787E+01  1.7146E+00
 EBVSHRINKVR(%)  2.0410E+01  3.3997E+00
 RELATIVEINF(%)  7.9556E+01  9.6559E+01
 EPSSHRINKSD(%)  4.9710E+00  4.9710E+00
 EPSSHRINKVR(%)  9.6948E+00  9.6948E+00
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          540
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    992.453615861047     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    1210.72880211137     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       2203.18241797241     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                            60
  
 #TERE:
 Elapsed estimation  time in seconds:    47.87
0R MATRIX ALGORITHMICALLY NON-POSITIVE-SEMIDEFINITE
 BUT NONSINGULAR
0COVARIANCE STEP ABORTED
 Elapsed covariance  time in seconds:    26.47
 Elapsed postprocess time in seconds:     0.71
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     1210.729       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         2.39E+00  3.48E+00  9.11E-01  5.32E+01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2     
 
 ETA1
+        7.55E-02
 
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
+        2.75E-01
 
 ETA2
+        0.00E+00  3.45E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        1.00E+00
 
 EPS2
+        0.00E+00  1.00E+00
 
 Elapsed finaloutput time in seconds:     0.05
 #CPUT: Total CPU Time in Seconds,      179.062
Stop Time: 
Thu 09/23/2021 
03:45 PM
