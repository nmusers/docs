Mon 01/04/2021 
07:03 PM
$PROBLEM WARFARIN PK, not using design priors in data file
$INPUT ID TIME AMT RATE EVID MDV DV TSTRAT TMIN TMAX STRAT STRATF REPX
$DATA warfarin_desprior4.csv ignore=C

$SUBROUTINES ADVAN2 TRANS1

$PK
MU_1=LOG(THETA(1))
MU_2=LOG(THETA(2))
MU_3=LOG(THETA(3))
KA=EXP(MU_1+ETA(1))
K=EXP(MU_2+ETA(2))
V=EXP(MU_3+ETA(3))
S2=V
F1=1.0

$ERROR
IPRED=A(2)/V
Y=IPRED + IPRED*EPS(1)+EPS(2)

$THETA
2.0 ;[KA]
0.25  ;[K]
15.0  ;[V]

$OMEGA 1.0 0.25 0.1
$SIGMA 0.0225 0.25

$DESIGN GROUPSIZE=12.5 FIMTYPE=1 VARCROSS=1 APPROX=FO 
        STRAT=STRAT STRATF=STRATF
$TABLE ID STRAT STRATF TIME TSTRAT TMIN TMAX EVID MDV IPRED NOAPPEND NOPRINT FILE=warfarin_desprior_opt4.tab
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
  
Note: Analytical 2nd Derivatives are constructed in FSUBS but are never used.
      You may insert $ABBR DERIV2=NO after the first $PROB to save FSUBS construction and compilation time
  
  
License Registered to: IDS NONMEM 7 TEAM
Expiration Date:     2 JUN 2030
Current Date:        4 JAN 2021
Days until program expires :3433
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.1
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 WARFARIN PK, not using design priors in data file
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:       16
 NO. OF DATA ITEMS IN DATA SET:  13
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   7
 MDV DATA ITEM IS DATA ITEM NO.:  6
0INDICES PASSED TO SUBROUTINE PRED:
   5   2   3   4   0   0   0   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID TIME AMT RATE EVID MDV DV TSTRAT TMIN TMAX STRAT STRATF REPX
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 IPRED
0FORMAT FOR DATA:
 (E4.0,E5.0,E6.0,E4.0,2E2.0,E4.0,E2.0,E5.0,E3.0,E2.0,E5.0,E3.0)

 TOT. NO. OF OBS RECS:       12
 TOT. NO. OF INDIVIDUALS:        4
0LENGTH OF THETA:   3
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   3
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   2
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.2000E+01  0.2500E+00  0.1500E+02
0INITIAL ESTIMATE OF OMEGA:
 0.1000E+01
 0.0000E+00   0.2500E+00
 0.0000E+00   0.0000E+00   0.1000E+00
0INITIAL ESTIMATE OF SIGMA:
 0.2250E-01
 0.0000E+00   0.2500E+00
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
 ID STRAT STRATF TIME TSTRAT TMIN TMAX EVID MDV IPRED
1DOUBLE PRECISION PREDPP VERSION 7.5.1

 ONE COMPARTMENT MODEL WITH FIRST-ORDER ABSORPTION (ADVAN2)
0MAXIMUM NO. OF BASIC PK PARAMETERS:   3
0BASIC PK PARAMETERS (AFTER TRANSLATION):
   ELIMINATION RATE (K) IS BASIC PK PARAMETER NO.:  1
   ABSORPTION RATE (KA) IS BASIC PK PARAMETER NO.:  3

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
 POP. ETAS OBTAINED POST HOC:             YES
 DESIGN TYPE: D-OPTIMALITY, -LOG(DET(FIM))
 SIMULATE OBSERVED DATA FOR DESIGN:  NO
 BLOCK DIAGONALIZATION TYPE FOR DESIGN:  1
 RESIDUAL STANDARD DEVIATION MODELING (VAR_CROSS=1)
 DESIGN GROUPSIZE=  1.2500000000000000E+01
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
 N:                       4           4           4
 
 P VAL.:         1.0000E+00  1.0000E+00  1.0000E+00
 
 ETASHRINKSD(%)  1.0000E+02  1.0000E+02  1.0000E+02
 ETASHRINKVR(%)  1.0000E+02  1.0000E+02  1.0000E+02
 EBVSHRINKSD(%)  2.3194E+01  2.6628E+01  3.1144E+01
 EBVSHRINKVR(%)  4.1008E+01  4.6165E+01  5.2588E+01
 RELATIVEINF(%)  4.2963E+01  3.9018E+01  2.9476E+01
 EPSSHRINKSD(%)  1.0000E+02  1.0000E+02
 EPSSHRINKVR(%)  1.0000E+02  1.0000E+02
 
 #TERE:
 Elapsed opt. design time in seconds:     0.02
 Elapsed postprocess time in seconds:     0.01
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                      FIRST ORDER (EVALUATION): D-OPTIMALITY                    ********************
 #OBJT:**************                MINIMUM VALUE OF OBJECTIVE FUNCTION: D-OPTIMALITY               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************      -36.130       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                      FIRST ORDER (EVALUATION): D-OPTIMALITY                    ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         2.00E+00  2.50E-01  1.50E+01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        1.00E+00
 
 ETA2
+        0.00E+00  2.50E-01
 
 ETA3
+        0.00E+00  0.00E+00  1.00E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        2.25E-02
 
 EPS2
+        0.00E+00  2.50E-01
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        1.00E+00
 
 ETA2
+        0.00E+00  5.00E-01
 
 ETA3
+        0.00E+00  0.00E+00  3.16E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        1.50E-01
 
 EPS2
+        0.00E+00  5.00E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                      FIRST ORDER (EVALUATION): D-OPTIMALITY                    ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3     
 
         4.12E-01  2.86E-02  1.19E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3     
 
 ETA1
+        3.04E-01
 
 ETA2
+       .........  9.22E-02
 
 ETA3
+       ......... .........  4.35E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        1.57E-02
 
 EPS2
+       .........  1.10E-01
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3     
 
 ETA1
+        1.52E-01
 
 ETA2
+       .........  9.22E-02
 
 ETA3
+       ......... .........  6.88E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        5.24E-02
 
 EPS2
+       .........  1.10E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                      FIRST ORDER (EVALUATION): D-OPTIMALITY                    ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3    OM11 | TH 1    
     1.70E-01        -4.01E-03         8.15E-04         2.33E-01        -1.69E-02         1.42E+00         0.00E+00

   OM11 | TH 2      OM11 | TH 3      OM11 | OM11      OM22 | TH 1      OM22 | TH 2      OM22 | TH 3      OM22 | OM11    
     0.00E+00         0.00E+00         9.22E-02         0.00E+00         0.00E+00         0.00E+00         5.86E-04

   OM22 | OM22      OM33 | TH 1      OM33 | TH 2      OM33 | TH 3      OM33 | OM11      OM33 | OM22      OM33 | OM33    
     8.51E-03         0.00E+00         0.00E+00         0.00E+00        -8.07E-04        -5.35E-04         1.89E-03

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | OM11      SG11 | OM22      SG11 | OM33      SG11 | SG11    
     0.00E+00         0.00E+00         0.00E+00        -5.28E-04         1.68E-04        -2.51E-04         2.48E-04

   SG22 | TH 1      SG22 | TH 2      SG22 | TH 3      SG22 | OM11      SG22 | OM22      SG22 | OM33      SG22 | SG11    
     0.00E+00         0.00E+00         0.00E+00        -5.27E-04        -2.83E-03         7.05E-04        -1.15E-03

   SG22 | SG22      
     1.22E-02
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                      FIRST ORDER (EVALUATION): D-OPTIMALITY                    ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3    OM11 | TH 1    
     4.12E-01        -3.40E-01         2.86E-02         4.75E-01        -4.96E-01         1.19E+00         0.00E+00

   OM11 | TH 2      OM11 | TH 3      OM11 | OM11      OM22 | TH 1      OM22 | TH 2      OM22 | TH 3      OM22 | OM11    
     0.00E+00         0.00E+00         3.04E-01         0.00E+00         0.00E+00         0.00E+00         2.09E-02

   OM22 | OM22      OM33 | TH 1      OM33 | TH 2      OM33 | TH 3      OM33 | OM11      OM33 | OM22      OM33 | OM33    
     9.22E-02         0.00E+00         0.00E+00         0.00E+00        -6.11E-02        -1.33E-01         4.35E-02

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | OM11      SG11 | OM22      SG11 | OM33      SG11 | SG11    
     0.00E+00         0.00E+00         0.00E+00        -1.11E-01         1.16E-01        -3.66E-01         1.57E-02

   SG22 | TH 1      SG22 | TH 2      SG22 | TH 3      SG22 | OM11      SG22 | OM22      SG22 | OM33      SG22 | SG11    
     0.00E+00         0.00E+00         0.00E+00        -1.57E-02        -2.78E-01         1.47E-01        -6.65E-01

   SG22 | SG22      
     1.10E-01
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                      FIRST ORDER (EVALUATION): D-OPTIMALITY                    ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

     TH 1 | TH 1      TH 2 | TH 1      TH 2 | TH 2      TH 3 | TH 1      TH 3 | TH 2      TH 3 | TH 3    OM11 | TH 1    
     7.75E+00         1.55E+01         1.66E+03        -1.09E+00         1.72E+01         1.09E+00         0.00E+00

   OM11 | TH 2      OM11 | TH 3      OM11 | OM11      OM22 | TH 1      OM22 | TH 2      OM22 | TH 3      OM22 | OM11    
     0.00E+00         0.00E+00         1.13E+01         0.00E+00         0.00E+00         0.00E+00         6.55E-01

   OM22 | OM22      OM33 | TH 1      OM33 | TH 2      OM33 | TH 3      OM33 | OM11      OM33 | OM22      OM33 | OM33    
     1.31E+02         0.00E+00         0.00E+00         0.00E+00         1.11E+01         4.19E+01         6.47E+02

   SG11 | TH 1      SG11 | TH 2      SG11 | TH 3      SG11 | OM11      SG11 | OM22      SG11 | OM33      SG11 | SG11    
     0.00E+00         0.00E+00         0.00E+00         6.27E+01         1.53E+02         9.37E+02         8.86E+03

   SG22 | TH 1      SG22 | TH 2      SG22 | TH 3      SG22 | OM11      SG22 | OM22      SG22 | OM33      SG22 | SG11    
     0.00E+00         0.00E+00         0.00E+00         5.94E+00         4.27E+01         6.16E+01         8.24E+02

   SG22 | SG22      
     1.67E+02
 Elapsed finaloutput time in seconds:     0.02
 #CPUT: Total CPU Time in Seconds,        0.125
Stop Time: 
Mon 01/04/2021 
07:03 PM
