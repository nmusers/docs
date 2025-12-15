Tue 04/23/2019 
12:11 PM
;Model Desc: Receptor Mediated Clearance model with Dynamic Change 
;            in Receptors
;Project Name: nm7examples
;Project ID: NO PROJECT DESCRIPTION

$PROB RUN# example6 (from r2compl)
$INPUT C SET ID JID TIME DV=CONC DOSE=AMT RATE EVID MDV CMT TSTRAT TMIN TMAX DSTRAT DMIN DMAX
$DATA optex6d17.csv IGNORE=C

; The new numerical integration solver is used, although ADVAN=9 
; is also efficient for this problem.

$SUBROUTINES ADVAN13 TRANS1 TOL=12 ATOL=12
$MODEL NCOMPARTMENTS=3

$PK
MU_1=THETA(1)
MU_2=THETA(2)
MU_3=THETA(3)
MU_4=THETA(4)
MU_5=THETA(5)
MU_6=THETA(6)
MU_7=THETA(7)
MU_8=THETA(8)
VC=EXP(MU_1+ETA(1))
K10=EXP(MU_2+ETA(2))
K12=EXP(MU_3+ETA(3))
K21=EXP(MU_4+ETA(4))
VM=EXP(MU_5+ETA(5))
KMC=EXP(MU_6+ETA(6))
K03=EXP(MU_7+ETA(7))
K30=EXP(MU_8+ETA(8))
S3=VC
S1=VC
KM=KMC*S1
F3=K03/K30

$DES
DADT(1) = -(K10+K12)*A(1) + K21*A(2) - VM*A(1)*A(3)/(A(1)+KM)
DADT(2) = K12*A(1) - K21*A(2)
DADT(3) =  -(VM-K30)*A(1)*A(3)/(A(1)+KM) - K30*A(3) + K03

$ERROR
ETYPE=1
IF(CMT.NE.1) ETYPE=0
IPRED=F
Y = F + ETYPE*( F*EPS(1)+EPS(2) ) + F*(1.0-ETYPE)*EPS(3)


$THETA 
3.90834E+00 
-2.18787E+00  
5.57985E-01 
-1.86377E-01  
2.26146E+00  
2.10476E-01  
3.70795E+00 
-7.08909E-01 

$OMEGA (0.0625 FIXED)X8
$SIGMA  (9.27944E-03 FIXED) (0.0001 FIXED) (2.24692E-02 FIXED)

$DESIGN MODE=0 FIMDIAG=1 OFVTYPE=2 NELDER DESEL=TIME DESELSTRAT=TSTRAT DESELMIN=TMIN DESELMAX=TMAX
           MAXEVAL=2000 SIGL=8 nohabort PRINT=100
$COV PRINT=E
$TABLE ID DOSE CMT TIME EVID MDV DV TSTRAT NOPRINT NOAPPEND FILE=optex6d17.tab 

  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
  
License Registered to: IDS NONMEM 7 TEAM
Expiration Date:     2 JUN 2030
Current Date:       23 APR 2019
Days until program expires :4054
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.0 alpha version 7
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 RUN# example6 (from r2compl)
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:       11
 NO. OF DATA ITEMS IN DATA SET:  17
 ID DATA ITEM IS DATA ITEM NO.:   3
 DEP VARIABLE IS DATA ITEM NO.:   6
 MDV DATA ITEM IS DATA ITEM NO.: 10
0INDICES PASSED TO SUBROUTINE PRED:
   9   5   7   8   0   0  11   0   0   0   0
0LABELS FOR DATA ITEMS:
 C SET ID JID TIME CONC DOSE RATE EVID MDV CMT TSTRAT TMIN TMAX DSTRAT DMIN DMAX
0FORMAT FOR DATA:
 (4E2.0,E9.0,E2.0,E5.0,4E2.0,E3.0,E5.0,E3.0,E2.0,2E4.0)

 TOT. NO. OF OBS RECS:        9
 TOT. NO. OF INDIVIDUALS:        1
0LENGTH OF THETA:   8
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   8
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   3
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.3908E+01 -0.2188E+01  0.5580E+00 -0.1864E+00  0.2261E+01  0.2105E+00  0.3708E+01 -0.7089E+00
0INITIAL ESTIMATE OF OMEGA:
 0.6250E-01
 0.0000E+00   0.6250E-01
 0.0000E+00   0.0000E+00   0.6250E-01
 0.0000E+00   0.0000E+00   0.0000E+00   0.6250E-01
 0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.6250E-01
 0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.6250E-01
 0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.6250E-01
 0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.6250E-01
0OMEGA CONSTRAINED TO BE THIS INITIAL ESTIMATE
0INITIAL ESTIMATE OF SIGMA:
 0.9279E-02
 0.0000E+00   0.1000E-03
 0.0000E+00   0.0000E+00   0.2247E-01
0SIGMA CONSTRAINED TO BE THIS INITIAL ESTIMATE
0COVARIANCE STEP OMITTED:        NO
 R MATRIX SUBSTITUTED:          YES
 S MATRIX SUBSTITUTED:           NO
 EIGENVLS. PRINTED:             YES
 COMPRESSED FORMAT:              NO
 GRADIENT METHOD USED:     NOSLOW
 SIGDIGITS ETAHAT (SIGLO):                  -1
 SIGDIGITS GRADIENTS (SIGL):                -1
 EXCLUDE COV FOR FOCE (NOFCOV):              NO
 TURN OFF Cholesky Transposition of R Matrix (CHOLROFF): NO
 KNUTHSUMOFF:                                -1
 RESUME COV ANALYSIS (RESUME):               NO
 SIR SAMPLE SIZE (SIRSAMPLE):              -1
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
 HEADER:                YES
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID DOSE CMT TIME EVID MDV CONC TSTRAT
0WARNING: THE NUMBER OF PARAMETERS TO BE ESTIMATED
 EXCEEDS THE NUMBER OF INDIVIDUALS WITH DATA.
1DOUBLE PRECISION PREDPP VERSION 7.5.0 alpha version 7

 GENERAL NONLINEAR KINETICS MODEL WITH STIFF/NONSTIFF EQUATIONS (LSODA, ADVAN13)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:   7
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         COMP 1       ON         YES        YES        YES        YES
    2         COMP 2       ON         YES        YES        NO         NO
    3         COMP 3       ON         YES        YES        NO         NO
    4         OUTPUT       OFF        YES        NO         NO         NO
 INITIAL (BASE) TOLERANCE SETTINGS:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  12
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            9           *           *           *           *
    2            *           *           *           *           *
    3            8          10           *           *           *
    4            *           -           -           -           -
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
0DES SUBROUTINE USES COMPACT STORAGE MODE.
1
 
 
 #TBLN:      1
 #METH: First Order: A-OPTIMALITY
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 EPS-ETA INTERACTION:                     NO
 NO. OF FUNCT. EVALS. ALLOWED:            2000
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      8
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     8
 NOPRIOR SETTING (NOPRIOR):                 OFF
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          ON
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      OFF
 RAW OUTPUT FILE (FILE): optex6d17.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 WISHART PRIOR DF INTERPRETATION (WISHTYPE):0
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 ADDITIONAL CONVERGENCE TEST (CTYPE=4)?:    NO
 EM OR BAYESIAN METHOD USED:                 NONE

 DESIGN TYPE: A-OPTIMALITY, -1/(TR(1/FIM))
 SIMULATE OBSERVED DATA FOR DESIGN:  NO
 BLOCK DIAGONALIZATION TYPE FOR DESIGN:  1
 STANDARD NONMEM RESIDUAL VARIANCE MODELING (VAR_CROSS=0)
 DESIGN GROUPSIZE=  1.0000000000000000E+00
 OPTIMALITY RANDOM GENERATION SEED: -1
 DESIGN OPTIMIZATION: NELDER
 OPTIMAL DESIGN ELEMENT, STRAT, MIN, MAX COLUMNS: TIME,TSTRAT,TMIN,TMAX
 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  12
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  12
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
 TOLERANCES FOR TABLE/SCATTER STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  12
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=NPRED
 RES=NRES
 WRES=NWRES
 IWRS=NIWRES
 IPRD=NIPRED
 IRS=NIRES
 
 MONITORING OF SEARCH:

 ITERATION NO.:          0    OBJECTIVE VALUE: -0.125411818042123        NO. OF FUNC. EVALS.:           1
 ITERATION NO.:         35    OBJECTIVE VALUE: -0.669596241631039        NO. OF FUNC. EVALS.:         261
 
 #TERM:
 NO. OF FUNCTION EVALUATIONS USED:      261
0MINIMIZATION SUCCESSFUL

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 SE:             0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 N:                       1           1           1           1           1           1           1           1
 
 P VAL.:         1.0000E+00  1.0000E+00  1.0000E+00  1.0000E+00  1.0000E+00  1.0000E+00  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 ETASHRINKVR(%)  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 EBVSHRINKSD(%)  4.0442E+00  5.4864E+01  2.0365E+01  2.2509E+01  6.7223E+00  3.3877E+01  4.4675E+00  1.3909E+01
 EBVSHRINKVR(%)  7.9248E+00  7.9627E+01  3.6583E+01  3.9952E+01  1.2993E+01  5.6277E+01  8.7355E+00  2.5884E+01
 EPSSHRINKSD(%)  6.6667E+01  6.6667E+01  6.6667E+01
 EPSSHRINKVR(%)  8.8889E+01  8.8889E+01  8.8889E+01
 
 #TERE:
 Elapsed opt. design time in seconds:     3.76
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: A-OPTIMALITY                           ********************
 #OBJT:**************                MINIMUM VALUE OF OBJECTIVE FUNCTION: A-OPTIMALITY               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************       -0.670       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: A-OPTIMALITY                           ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8     
 
         3.91E+00 -2.19E+00  5.58E-01 -1.86E-01  2.26E+00  2.10E-01  3.71E+00 -7.09E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        6.25E-02
 
 ETA2
+        0.00E+00  6.25E-02
 
 ETA3
+        0.00E+00  0.00E+00  6.25E-02
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  6.25E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.25E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.25E-02
 
 ETA7
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.25E-02
 
 ETA8
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.25E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2      EPS3     
 
 EPS1
+        9.28E-03
 
 EPS2
+        0.00E+00  1.00E-04
 
 EPS3
+        0.00E+00  0.00E+00  2.25E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        2.50E-01
 
 ETA2
+        0.00E+00  2.50E-01
 
 ETA3
+        0.00E+00  0.00E+00  2.50E-01
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  2.50E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.50E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.50E-01
 
 ETA7
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.50E-01
 
 ETA8
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.50E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2      EPS3     
 
 EPS1
+        9.63E-02
 
 EPS2
+        0.00E+00  1.00E-02
 
 EPS3
+        0.00E+00  0.00E+00  1.50E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: A-OPTIMALITY                           ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8     
 
         2.69E-01  8.22E-01  3.49E-01  3.66E-01  2.79E-01  4.16E-01  3.50E-01  3.42E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+       .........
 
 ETA2
+       ......... .........
 
 ETA3
+       ......... ......... .........
 
 ETA4
+       ......... ......... ......... .........
 
 ETA5
+       ......... ......... ......... ......... .........
 
 ETA6
+       ......... ......... ......... ......... ......... .........
 
 ETA7
+       ......... ......... ......... ......... ......... ......... .........
 
 ETA8
+       ......... ......... ......... ......... ......... ......... ......... .........
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2      EPS3     
 
 EPS1
+       .........
 
 EPS2
+       ......... .........
 
 EPS3
+       ......... ......... .........
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+       .........
 
 ETA2
+       ......... .........
 
 ETA3
+       ......... ......... .........
 
 ETA4
+       ......... ......... ......... .........
 
 ETA5
+       ......... ......... ......... ......... .........
 
 ETA6
+       ......... ......... ......... ......... ......... .........
 
 ETA7
+       ......... ......... ......... ......... ......... ......... .........
 
 ETA8
+       ......... ......... ......... ......... ......... ......... ......... .........
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2      EPS3     
 
 EPS1
+       .........
 
 EPS2
+       ......... .........
 
 EPS3
+       ......... ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: A-OPTIMALITY                           ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     7.22E-02        -3.87E-02         6.75E-01        -1.38E-02         5.34E-02         1.22E-01        -3.33E-03

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
     7.28E-02         4.75E-02         1.34E-01         7.52E-04        -5.12E-02         7.35E-04        -4.04E-03

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     7.81E-02         5.07E-03         8.62E-02         3.13E-03         3.86E-02         9.11E-03         1.73E-01

     TH 7 | TH 1      TH 7 | TH 2      TH 7 | TH 3      TH 7 | TH 4      TH 7 | TH 5      TH 7 | TH 6      TH 7 | TH 7  
     9.83E-03        -1.89E-01        -1.24E-02        -2.40E-02         1.67E-02        -2.84E-02         1.23E-01

     TH 8 | TH 1      TH 8 | TH 2      TH 8 | TH 3      TH 8 | TH 4      TH 8 | TH 5      TH 8 | TH 6      TH 8 | TH 7  
     2.74E-04        -1.34E-01         2.92E-03        -1.77E-02         1.01E-02        -3.76E-02         4.67E-02

     TH 8 | TH 8    
     1.17E-01
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: A-OPTIMALITY                           ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     2.69E-01        -1.75E-01         8.22E-01        -1.47E-01         1.86E-01         3.49E-01        -3.39E-02

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
     2.42E-01         3.72E-01         3.66E-01         1.00E-02        -2.23E-01         7.54E-03        -3.96E-02

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     2.79E-01         4.54E-02         2.52E-01         2.15E-02         2.54E-01         7.84E-02         4.16E-01

     TH 7 | TH 1      TH 7 | TH 2      TH 7 | TH 3      TH 7 | TH 4      TH 7 | TH 5      TH 7 | TH 6      TH 7 | TH 7  
     1.05E-01        -6.57E-01        -1.01E-01        -1.88E-01         1.71E-01        -1.95E-01         3.50E-01

     TH 8 | TH 1      TH 8 | TH 2      TH 8 | TH 3      TH 8 | TH 4      TH 8 | TH 5      TH 8 | TH 6      TH 8 | TH 7  
     2.97E-03        -4.76E-01         2.45E-02        -1.41E-01         1.05E-01        -2.64E-01         3.89E-01

     TH 8 | TH 8    
     3.42E-01
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: A-OPTIMALITY                           ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     1.47E+01         1.07E+00         3.22E+00         1.32E+00        -8.27E-01         1.01E+01        -3.45E-01

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4      TH 5 | TH 1      TH 5 | TH 2      TH 5 | TH 3      TH 5 | TH 4  
    -3.10E-01        -3.55E+00         9.55E+00         5.18E-01         1.12E+00        -6.75E-01         3.86E-01

     TH 5 | TH 5      TH 6 | TH 1      TH 6 | TH 2      TH 6 | TH 3      TH 6 | TH 4      TH 6 | TH 5      TH 6 | TH 6  
     1.39E+01        -7.64E-01        -5.88E-01         6.77E-01        -1.76E+00        -1.48E+00         6.87E+00

     TH 7 | TH 1      TH 7 | TH 2      TH 7 | TH 3      TH 7 | TH 4      TH 7 | TH 5      TH 7 | TH 6      TH 7 | TH 7  
    -2.61E-02         3.73E+00        -2.98E-01         4.50E-01        -5.01E-01         1.76E-01         1.46E+01

     TH 8 | TH 1      TH 8 | TH 2      TH 8 | TH 3      TH 8 | TH 4      TH 8 | TH 5      TH 8 | TH 6      TH 8 | TH 7  
     8.25E-01         1.88E+00        -1.34E+00         4.00E-01        -1.15E-01         1.31E+00        -1.37E+00

     TH 8 | TH 8    
     1.18E+01
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: A-OPTIMALITY                           ********************
 ********************                      EIGENVALUES OF COR MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

             1         2         3         4         5         6         7         8
 
         3.13E-01  5.44E-01  5.99E-01  7.25E-01  9.60E-01  1.16E+00  1.29E+00  2.41E+00
 
 Elapsed finaloutput time in seconds:     0.25
 #CPUT: Total CPU Time in Seconds,        2.668
Stop Time: 
Tue 04/23/2019 
12:12 PM
