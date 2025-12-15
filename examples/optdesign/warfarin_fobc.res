Thu 03/18/2021 
02:23 PM
$PROBLEM WARFARIN
$INPUT ID TIME AMT RATE EVID MDV DV TSTRAT   TMIN   TMAX   REPZ
$DATA warfarinz.csv ignore=@ 

$SUBROUTINES ADVAN2 TRANS2

$ABBR DECLARE T(NO), INTEGER I, DOWHILE J

$PK
MU_1=LOG(THETA(1))
MU_2=LOG(THETA(2))
MU_3=LOG(THETA(3))
CL=THETA(1)*EXP(ETA(1))
V=THETA(2)*EXP(ETA(2))
KA=THETA(3)*EXP(ETA(3))
S2=V
F1=1.0

$ERROR
 IF(NEWIND.NE.2) I=0
 IF (NEWL2 ==1 .AND. MDV==0) THEN
    I=I+1
    T(I)=TIME
    J=1
    DO WHILE (J<=I)
    CORRL2(J,1)=EXP(-THETA(4)*(TIME-T(J)))
    J=J+1
    ENDDO
 ENDIF
IPRED=A(2)/V
Y=IPRED*(1.0+EPS(1)) + EPS(2)

$THETA
0.15 ;[CL]
8.0  ;[V]
1.0  ;[KA]
(0.1) ; [COR]

$OMEGA (0.07 ) (0.02 ) (0.6 )
$SIGMA (0.01 ) (0.001 FIX )

$DESIGN GROUPSIZE=100 FIMDIAG=1 APPROX=FO 
         MAXEVAL=9999 SIGL=12 DESEL=TIME DESELSTRAT=TSTRAT DESELMIN=TMIN DESELMAX=TMAX
$EST GRD=TS(4) 
$TABLE ID TIME AMT EVID MDV DV IPRED NOPRINT NOAPPEND FILE=warfarin_fobc.tab
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
  
Note: Analytical 2nd Derivatives are constructed in FSUBS but are never used.
      You may insert $ABBR DERIV2=NO after the first $PROB to save FSUBS construction and compilation time
  
  
License Registered to: IDS NONMEM 7 TEAM
Expiration Date:     2 JUN 2030
Current Date:       18 MAR 2021
Days until program expires :3359
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
 NO. OF DATA ITEMS IN DATA SET:  11
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   7
 MDV DATA ITEM IS DATA ITEM NO.:  6
0INDICES PASSED TO SUBROUTINE PRED:
   5   2   3   4   0   0   0   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID TIME AMT RATE EVID MDV DV TSTRAT TMIN TMAX REPZ
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 IPRED
0FORMAT FOR DATA:
 (11E6.0)

 TOT. NO. OF OBS RECS:        8
 TOT. NO. OF INDIVIDUALS:        1
0LENGTH OF THETA:   4
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   3
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS BLOCK FORM:
  1
  0  2
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.1500E+00  0.8000E+01  0.1000E+01  0.1000E+00
0INITIAL ESTIMATE OF OMEGA:
 0.7000E-01
 0.0000E+00   0.2000E-01
 0.0000E+00   0.0000E+00   0.6000E+00
0INITIAL ESTIMATE OF SIGMA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.1000E-01
        2                                                                                  YES
                  0.1000E-02
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
 HEADER:                YES
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID TIME AMT EVID MDV DV IPRED
0WARNING: THE NUMBER OF PARAMETERS TO BE ESTIMATED
 EXCEEDS THE NUMBER OF INDIVIDUALS WITH DATA.
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
 #METH: First Order: D-OPTIMALITY
 
 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 EPS-ETA INTERACTION:                     NO
 NO. OF FUNCT. EVALS. ALLOWED:            9999
 NO. OF SIG. FIGURES REQUIRED:            3
 INTERMEDIATE PRINTOUT:                   YES
 ESTIMATE OUTPUT TO MSF:                  NO
 IND. OBJ. FUNC. VALUES SORTED:           NO
 NUMERICAL DERIVATIVE
       FILE REQUEST (NUMDER):               NONE
 MAP (ETAHAT) ESTIMATION METHOD (OPTMAP):   0
 ETA HESSIAN EVALUATION METHOD (ETADER):    0
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    0
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      12
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     12
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): warfarin_fobc.ext
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
 STANDARD NONMEM RESIDUAL VARIANCE MODELING (VAR_CROSS=0)
 DESIGN GROUPSIZE=  1.0000000000000000E+02
 OPTIMALITY RANDOM GENERATION SEED: 11456
 DESIGN OPTIMIZATION: NELDER
 OPTIMAL DESIGN ELEMENT, STRAT, MIN, MAX COLUMNS: TIME,TSTRAT,TMIN,TMAX
 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=NPRED
 RES=NRES
 WRES=NWRES
 IWRS=NIWRES
 IPRD=NIPRED
 IRS=NIRES
 
 MONITORING OF SEARCH:

 ITERATION NO.:          0    OBJECTIVE VALUE:  -68.4430716323815        NO. OF FUNC. EVALS.:           1
 ITERATION NO.:        208    OBJECTIVE VALUE:  -68.6433832096644        NO. OF FUNC. EVALS.:         924
 
 #TERM:
 NO. OF FUNCTION EVALUATIONS USED:      924
0MINIMIZATION SUCCESSFUL

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         0.0000E+00  0.0000E+00  0.0000E+00
 SE:             0.0000E+00  0.0000E+00  0.0000E+00
 N:                       1           1           1
 
 P VAL.:         1.0000E+00  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  1.0000E+02  1.0000E+02  1.0000E+02
 ETASHRINKVR(%)  1.0000E+02  1.0000E+02  1.0000E+02
 EBVSHRINKSD(%)  1.6179E+00  1.1324E+01  6.2961E-01
 EBVSHRINKVR(%)  3.2096E+00  2.1365E+01  1.2553E+00
 RELATIVEINF(%)  9.6385E+01  7.8286E+01  9.8717E+01
 EPSSHRINKSD(%)  1.0000E+02  1.0000E+02
 EPSSHRINKVR(%)  1.0000E+02  1.0000E+02
 
 #TERE:
 Elapsed opt. design time in seconds:     0.93
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 #OBJT:**************                MINIMUM VALUE OF OBJECTIVE FUNCTION: D-OPTIMALITY               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************      -68.643       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         1.50E-01  8.00E+00  1.00E+00  1.00E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        7.00E-02
 
 ETA2
+        0.00E+00  2.00E-02
 
 ETA3
+        0.00E+00  0.00E+00  6.00E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        1.00E-02
 
 EPS2
+        0.00E+00  1.00E-03
 
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


         EPS1      EPS2     
 
 EPS1
+        1.00E-01
 
 EPS2
+        0.00E+00  3.16E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         4.05E-03  1.29E-01  7.80E-02  1.48E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        1.02E-02
 
 ETA2
+       .........  3.71E-03
 
 ETA3
+       ......... .........  8.59E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        1.09E-03
 
 EPS2
+       ......... .........
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        1.94E-02
 
 ETA2
+       .........  1.31E-02
 
 ETA3
+       ......... .........  5.55E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        5.47E-03
 
 EPS2
+       ......... .........
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     1.64E-05         3.53E-05         1.65E-02         1.41E-06         1.68E-04         6.08E-03         0.00E+00

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4    OM11 | TH 1      OM11 | TH 2      OM11 | TH 3      OM11 | TH 4    
     0.00E+00         0.00E+00         2.20E-04         0.00E+00         0.00E+00         0.00E+00         3.29E-06

   OM11 | OM11      OM22 | TH 1      OM22 | TH 2      OM22 | TH 3      OM22 | TH 4      OM22 | OM11      OM22 | OM22    
     1.05E-04         0.00E+00         0.00E+00         0.00E+00         9.74E-06         1.69E-08         1.38E-05

   OM33 | TH 1      OM33 | TH 2      OM33 | TH 3      OM33 | TH 4      OM33 | OM11      OM33 | OM22      OM33 | OM33    
     0.00E+00         0.00E+00         0.00E+00        -2.39E-06         1.13E-08        -3.20E-08         7.39E-03

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | OM11      SG11 | OM22      SG11 | OM33    
     0.00E+00         0.00E+00         0.00E+00        -1.31E-05        -2.75E-07        -8.05E-07        -1.52E-07

   SG11 | SG11      
     1.20E-06
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     4.05E-03         6.79E-02         1.29E-01         4.46E-03         1.67E-02         7.80E-02         0.00E+00

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4    OM11 | TH 1      OM11 | TH 2      OM11 | TH 3      OM11 | TH 4    
     0.00E+00         0.00E+00         1.48E-02         0.00E+00         0.00E+00         0.00E+00         2.16E-02

   OM11 | OM11      OM22 | TH 1      OM22 | TH 2      OM22 | TH 3      OM22 | TH 4      OM22 | OM11      OM22 | OM22    
     1.02E-02         0.00E+00         0.00E+00         0.00E+00         1.77E-01         4.46E-04         3.71E-03

   OM33 | TH 1      OM33 | TH 2      OM33 | TH 3      OM33 | TH 4      OM33 | OM11      OM33 | OM22      OM33 | OM33    
     0.00E+00         0.00E+00         0.00E+00        -1.88E-03         1.29E-05        -1.00E-04         8.59E-02

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | OM11      SG11 | OM22      SG11 | OM33    
     0.00E+00         0.00E+00         0.00E+00        -8.07E-01        -2.45E-02        -1.98E-01        -1.62E-03

   SG11 | SG11      
     1.09E-03
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                            FIRST ORDER: D-OPTIMALITY                           ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3      TH 4 | TH 1  
     6.14E+04        -1.31E+02         6.08E+01        -1.06E+01        -1.65E+00         1.65E+02         0.00E+00

     TH 4 | TH 2      TH 4 | TH 3      TH 4 | TH 4    OM11 | TH 1      OM11 | TH 2      OM11 | TH 3      OM11 | TH 4    
     0.00E+00         0.00E+00         1.30E+04         0.00E+00         0.00E+00         0.00E+00        -3.65E+01

   OM11 | OM11      OM22 | TH 1      OM22 | TH 2      OM22 | TH 3      OM22 | TH 4      OM22 | OM11      OM22 | OM22    
     9.54E+03         0.00E+00         0.00E+00         0.00E+00        -9.20E+02         1.23E+02         7.56E+04

   OM33 | TH 1      OM33 | TH 2      OM33 | TH 3      OM33 | TH 4      OM33 | OM11      OM33 | OM22      OM33 | OM33    
     0.00E+00         0.00E+00         0.00E+00         7.13E+00         1.26E-02         8.68E-01         1.35E+02

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | TH 4      SG11 | OM11      SG11 | OM22      SG11 | OM33    
     0.00E+00         0.00E+00         0.00E+00         1.42E+05         1.87E+03         4.08E+04         9.58E+01

   SG11 | SG11      
     2.42E+06
 Elapsed finaloutput time in seconds:     0.05
 #CPUT: Total CPU Time in Seconds,        1.109
Stop Time: 
Thu 03/18/2021 
02:23 PM
