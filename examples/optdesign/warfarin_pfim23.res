Thu 01/07/2021 
12:36 AM
$PROBLEM WARFARIN
$INPUT ID TIME AMT RATE EVID MDV DV TSTRAT TMIN TMAX
$DATA warfarin_pfim2.csv ignore=C

$SUBROUTINES ADVAN2 TRANS2

$PK
MU_1=LOG(THETA(1))
MU_2=LOG(THETA(2))
MU_3=LOG(THETA(3))
;MU_4=LOG(THETA(4))
CL=EXP(MU_1+ETA(1))
V=EXP(MU_2+ETA(2))
KA=EXP(MU_3+ETA(3))
gamma=THETA(4)
S2=V
F1=1.0

$ERROR
IPRED=A(2)/V
Y=IPRED + (IPRED**gamma)*EPS(1)

$THETA
0.15 ;[CL]
8.0  ;[V]
1.0  ;[KA]
1.0 ;[gamma]

$OMEGA (0.07) (0.02) (0.6) 
$SIGMA 0.01

$DESIGN GROUPSIZE=32 FIMTYPE=1 VARCROSS=1 APPROX=FO
$EST GRD=TS(4) SIGL=10
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  97) A RANDOM QUANTITY IS RAISED TO A POWER. IF THE RESULT AFFECTS
 THE VALUE OF THE OBJECTIVE FUNCTION, THE USER SHOULD ENSURE THAT THE
 RANDOM QUANTITY IS NEVER 0 WHEN THE POWER IS < 1.
  
Note: Analytical 2nd Derivatives are constructed in FSUBS but are never used.
      You may insert $ABBR DERIV2=NO after the first $PROB to save FSUBS construction and compilation time
  
  
License Registered to: IDS NONMEM 7 TEAM
Expiration Date:     2 JUN 2030
Current Date:        7 JAN 2021
Days until program expires :3430
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.1
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 WARFARIN
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:        9
 NO. OF DATA ITEMS IN DATA SET:  10
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   7
 MDV DATA ITEM IS DATA ITEM NO.:  6
0INDICES PASSED TO SUBROUTINE PRED:
   5   2   3   4   0   0   0   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID TIME AMT RATE EVID MDV DV TSTRAT TMIN TMAX
0FORMAT FOR DATA:
 (10E6.0)

 TOT. NO. OF OBS RECS:        8
 TOT. NO. OF INDIVIDUALS:        1
0LENGTH OF THETA:   4
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   3
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.1500E+00  0.8000E+01  0.1000E+01  0.1000E+01
0INITIAL ESTIMATE OF OMEGA:
 0.7000E-01
 0.0000E+00   0.2000E-01
 0.0000E+00   0.0000E+00   0.6000E+00
0INITIAL ESTIMATE OF SIGMA:
 0.1000E-01
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
1DOUBLE PRECISION PREDPP VERSION 7.5.1

 ONE COMPARTMENT MODEL WITH FIRST-ORDER ABSORPTION (ADVAN2)
0MAXIMUM NO. OF BASIC PK PARAMETERS:   3
0BASIC PK PARAMETERS (AFTER TRANSLATION):
   ELIMINATION RATE (K) IS BASIC PK PARAMETER NO.:  1
   ABSORPTION RATE (KA) IS BASIC PK PARAMETER NO.:  3

 TRANSLATOR WILL CONVERT PARAMETERS
 CLEARANCE (CL) AND VOLUME (V) TO K (TRANS2)
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         DEPOT        OFF        YES        YES        YES        NO
    2         CENTRAL      ON         NO         YES        NO         YES
    3         OUTPUT       OFF        YES        NO         NO         NO
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            *           5           *           *           *
    2            4           *           *           *           *
    3            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      5
   TIME DATA ITEM IS DATA ITEM NO.:          2
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   3
   DOSE RATE DATA ITEM IS DATA ITEM NO.:     4

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE NOT CALLED AT NONEVENT (ADDITIONAL OR LAGGED) DOSE TIMES.
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
0ERROR SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
1
 
 
 #TBLN:      1
 #METH: First Order (Evaluation): D-OPTIMALITY
 
 ESTIMATION STEP OMITTED:                 YES
 ANALYSIS TYPE:                           POPULATION
 EPS-ETA INTERACTION:                     NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    0
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      10
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     10
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): warfarin_pfim23.ext
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

 DESIGN TYPE: D-OPTIMALITY, -LOG(DET(FIM))
 SIMULATE OBSERVED DATA FOR DESIGN:  NO
 BLOCK DIAGONALIZATION TYPE FOR DESIGN:  1
 RESIDUAL STANDARD DEVIATION MODELING (VAR_CROSS=1)
 DESIGN GROUPSIZE=  3.2000000000000000E+01
 OPTIMALITY RANDOM GENERATION SEED: 11456
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=NPRED
 RES=NRES
 WRES=NWRES
 IWRS=NIWRES
 IPRD=NIPRED
 IRS=NIRES
 
 #TERM:

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         0.0000E+00  0.0000E+00  0.0000E+00
 SE:             0.0000E+00  0.0000E+00  0.0000E+00
 N:                       1           1           1
 
 P VAL.:         1.0000E+00  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  1.0000E+02  1.0000E+02  1.0000E+02
 ETASHRINKVR(%)  1.0000E+02  1.0000E+02  1.0000E+02
 EBVSHRINKSD(%)  1.2059E+00  8.9505E+00  1.4889E+00
 EBVSHRINKVR(%)  2.3973E+00  1.7100E+01  2.9557E+00
 RELATIVEINF(%)  9.7483E+01  8.2560E+01  9.6748E+01
 EPSSHRINKSD(%)  2.0943E+01
 EPSSHRINKVR(%)  3.7500E+01
 
 #TERE:
 Elapsed opt. design time in seconds:     0.02
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                      FIRST ORDER (EVALUATION): D-OPTIMALITY                    ********************
 #OBJT:**************                MINIMUM VALUE OF OBJECTIVE FUNCTION: D-OPTIMALITY               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************      -56.669       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                      FIRST ORDER (EVALUATION): D-OPTIMALITY                    ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         1.50E-01  8.00E+00  1.00E+00  1.00E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        7.00E-02
 
 ETA2
+        0.00E+00  2.00E-02
 
 ETA3
+        0.00E+00  0.00E+00  6.00E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        2.65E-01
 
 ETA2
+        0.00E+00  1.41E-01
 
 ETA3
+        0.00E+00  0.00E+00  7.75E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.00E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                      FIRST ORDER (EVALUATION): D-OPTIMALITY                    ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         7.11E-03  2.20E-01  1.39E-01  1.21E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        1.79E-02
 
 ETA2
+       .........  6.07E-03
 
 ETA3
+       ......... .........  1.55E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.85E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        3.39E-02
 
 ETA2
+       .........  2.15E-02
 
 ETA3
+       ......... .........  9.98E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.92E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                      FIRST ORDER (EVALUATION): D-OPTIMALITY                    ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     5.05E-05         5.43E-05         4.86E-02         1.03E-05         1.71E-03         1.94E-02         0.00E+00

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4    OM11 | TH 1      OM11 | TH 2      OM11 | TH 3      OM11 | TH 4    
     0.00E+00         0.00E+00         1.47E-02         0.00E+00         0.00E+00         0.00E+00         3.25E-05

   OM11 | OM11      OM22 | TH 1      OM22 | TH 2      OM22 | TH 3      OM22 | TH 4      OM22 | OM11      OM22 | OM22    
     3.22E-04         0.00E+00         0.00E+00         0.00E+00        -1.88E-05        -8.28E-08         3.69E-05

   OM33 | TH 1      OM33 | TH 2      OM33 | TH 3      OM33 | TH 4      OM33 | OM11      OM33 | OM22      OM33 | OM33    
     0.00E+00         0.00E+00         0.00E+00         2.85E-05         2.18E-07        -2.04E-06         2.39E-02

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | OM11      SG11 | OM22      SG11 | OM33    
     0.00E+00         0.00E+00         0.00E+00        -4.46E-04        -1.19E-06         6.03E-08        -2.95E-06

   SG11 | SG11      
     1.48E-05
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                      FIRST ORDER (EVALUATION): D-OPTIMALITY                    ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     7.11E-03         3.47E-02         2.20E-01         1.04E-02         5.56E-02         1.39E-01         0.00E+00

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4    OM11 | TH 1      OM11 | TH 2      OM11 | TH 3      OM11 | TH 4    
     0.00E+00         0.00E+00         1.21E-01         0.00E+00         0.00E+00         0.00E+00         1.49E-02

   OM11 | OM11      OM22 | TH 1      OM22 | TH 2      OM22 | TH 3      OM22 | TH 4      OM22 | OM11      OM22 | OM22    
     1.79E-02         0.00E+00         0.00E+00         0.00E+00        -2.56E-02        -7.60E-04         6.07E-03

   OM33 | TH 1      OM33 | TH 2      OM33 | TH 3      OM33 | TH 4      OM33 | OM11      OM33 | OM22      OM33 | OM33    
     0.00E+00         0.00E+00         0.00E+00         1.52E-03         7.86E-05        -2.18E-03         1.55E-01

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | OM11      SG11 | OM22      SG11 | OM33    
     0.00E+00         0.00E+00         0.00E+00        -9.57E-01        -1.73E-02         2.58E-03        -4.95E-03

   SG11 | SG11      
     3.85E-03
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                      FIRST ORDER (EVALUATION): D-OPTIMALITY                    ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     1.98E+04        -2.18E+01         2.07E+01        -8.62E+00        -1.81E+00         5.17E+01         0.00E+00

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4    OM11 | TH 1      OM11 | TH 2      OM11 | TH 3      OM11 | TH 4    
     0.00E+00         0.00E+00         8.14E+02         0.00E+00         0.00E+00         0.00E+00         9.00E+00

   OM11 | OM11      OM22 | TH 1      OM22 | TH 2      OM22 | TH 3      OM22 | TH 4      OM22 | OM11      OM22 | OM22    
     3.11E+03         0.00E+00         0.00E+00         0.00E+00         3.76E+02         1.07E+01         2.73E+04

   OM33 | TH 1      OM33 | TH 2      OM33 | TH 3      OM33 | TH 4      OM33 | OM11      OM33 | OM22      OM33 | OM33    
     0.00E+00         0.00E+00         0.00E+00         2.08E+00         2.61E-02         3.27E+00         4.18E+01

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | OM11      SG11 | OM22      SG11 | OM33    
     0.00E+00         0.00E+00         0.00E+00         2.45E+04         5.22E+02         1.12E+04         7.11E+01

   SG11 | SG11      
     8.06E+05
 Elapsed finaloutput time in seconds:     0.02
 #CPUT: Total CPU Time in Seconds,        0.141
Stop Time: 
Thu 01/07/2021 
12:37 AM
