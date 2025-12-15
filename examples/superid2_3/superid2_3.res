Thu 12/12/2019 
05:37 PM
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
0.05
0.00001 0.05

$OMEGA BLOCK(2)
0.1
0.00001 0.1

$OMEGA BLOCK(2)
0.5
0.00001 0.5

$SIGMA 
0.05

$LEVEL
SID=(3[1],4[2])
CID=(5[3],6[4])

;$EST METHOD=ITS INTERACTION PRINT=1 NSIG=3 NITER=0 SIGL=6 FNLETA=0
$EST METHOD=IMPMAP INTERACTION PRINT=1 NSIG=3 NITER=50 CTYPE=3 ISAMPLE=300 SIGL=8 FNLETA=0 MCETA=3
     LEVCENTER=0
$COV MATRIX=R UNCONDITIONAL
$TABLE  ID TIME CONC DOSE RATE EVID MDV CMT SID CID ETA1 ETA2 ETA3 ETA4 ETA5 ETA6
NOAPPEND ONEHEADER FILE=superid2_3.tab  NOPRINT
$TABLE  ID SID CID CL V ETA1 ETA2 ETA3 ETA4 ETA5 ETA6 NOAPPEND ONEHEADER FILE=superid2_3.dat FIRSTONLY NOPRINT FORMAT=,1PE15.8
  
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
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 CL V
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
                  0.5000E-01
                  0.1000E-04   0.5000E-01
        2                                                                                   NO
                  0.1000E+00
                  0.1000E-04   0.1000E+00
        3                                                                                   NO
                  0.5000E+00
                  0.1000E-04   0.5000E+00
0INITIAL ESTIMATE OF SIGMA:
 0.5000E-01
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
 NO. OF TABLES:           2
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
0-- TABLE   2 --
0RECORDS ONLY:    FIRSTONLY
04 COLUMNS APPENDED:    NO
 PRINTED:                NO
 HEADERS:               ONE
 FILE TO BE FORWARDED:   NO
 FORMAT:                ,1PE15.8
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID SID CID CL V ETA1 ETA2 ETA3 ETA4 ETA5 ETA6
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
 #METH: Importance Sampling assisted by MAP Estimation
 
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
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    3
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      8
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     8
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          0
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): superid2_3.ext
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
 EM OR BAYESIAN METHOD USED:                IMPORTANCE SAMPLING ASSISTED BY MAP ESTIMATION (IMPMAP)
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
 SAMPLE ACCEPTANCE RATE (IACCEPT):          0.400000000000000
 LONG TAIL SAMPLE ACCEPT. RATE (IACCEPTL):   0.00000000000000
 T-DIST. PROPOSAL DENSITY (DF):             0
 NO. ITERATIONS FOR MAP (MAPITER):          1
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

 iteration            0 OBJ=  -7491.23345603273 eff.=     294. Smpl.=     300. Fit.= 0.96389
 iteration            1 OBJ=  -36661.8338664997 eff.=     123. Smpl.=     300. Fit.= 0.78912
 iteration            2 OBJ=  -41149.4718823560 eff.=     121. Smpl.=     300. Fit.= 0.78544
 iteration            3 OBJ=  -42369.0116882877 eff.=     120. Smpl.=     300. Fit.= 0.78524
 iteration            4 OBJ=  -42440.1362462387 eff.=     120. Smpl.=     300. Fit.= 0.78537
 iteration            5 OBJ=  -42443.9554687557 eff.=     120. Smpl.=     300. Fit.= 0.78489
 iteration            6 OBJ=  -42442.2240391776 eff.=     120. Smpl.=     300. Fit.= 0.78496
 iteration            7 OBJ=  -42437.3408343915 eff.=     120. Smpl.=     300. Fit.= 0.78499
 iteration            8 OBJ=  -42438.5075159775 eff.=     120. Smpl.=     300. Fit.= 0.78529
 iteration            9 OBJ=  -42444.5789368893 eff.=     120. Smpl.=     300. Fit.= 0.78564
 iteration           10 OBJ=  -42437.1687603492 eff.=     120. Smpl.=     300. Fit.= 0.78512
 iteration           11 OBJ=  -42448.1690725886 eff.=     121. Smpl.=     300. Fit.= 0.78529
 Convergence achieved
 iteration           11 OBJ=  -42442.9936440914 eff.=     120. Smpl.=     300. Fit.= 0.78472
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.3451E-03 -2.8608E-04 -4.6185E-18  4.0218E-18 -6.4980E-05  9.6045E-05
 SE:             1.6225E-03  1.7004E-03  9.9752E-03  1.0720E-02  6.2376E-02  5.5619E-02
 N:                    2500        2500         250         250          25          25
 
 P VAL.:         4.0709E-01  8.6639E-01  1.0000E+00  1.0000E+00  9.9917E-01  9.9862E-01
 
 ETASHRINKSD(%)  1.2169E+01  1.1893E+01  3.2772E-02  1.0000E-10  1.0000E-10  1.0000E-10
 ETASHRINKVR(%)  2.2858E+01  2.2371E+01  6.5533E-02  1.0000E-10  1.0000E-10  1.0000E-10
 EBVSHRINKSD(%)  1.2172E+01  1.1915E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EBVSHRINKVR(%)  2.2862E+01  2.2411E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 RELATIVEINF(%)  7.6837E+01  7.7287E+01  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  1.1726E+01
 EPSSHRINKVR(%)  2.2078E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):        17500
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    32162.8486621635     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -42442.9936440914     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -10280.1449819278     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          5548
  
 #TERE:
 Elapsed estimation  time in seconds:   448.98
 Elapsed covariance  time in seconds:    49.43
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                  IMPORTANCE SAMPLING ASSISTED BY MAP ESTIMATION                ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************   -42442.994       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                  IMPORTANCE SAMPLING ASSISTED BY MAP ESTIMATION                ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         1.99E+00  3.63E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        8.53E-03
 
 ETA2
+       -9.76E-05  9.31E-03
 
 ETA3
+        0.00E+00  0.00E+00  2.49E-02
 
 ETA4
+        0.00E+00  0.00E+00  1.15E-03  2.87E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.01E-01
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.81E-02  8.05E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.00E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        9.24E-02
 
 ETA2
+       -1.10E-02  9.65E-02
 
 ETA3
+        0.00E+00  0.00E+00  1.58E-01
 
 ETA4
+        0.00E+00  0.00E+00  4.32E-02  1.69E-01
 
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
 ********************                  IMPORTANCE SAMPLING ASSISTED BY MAP ESTIMATION                ********************
 ********************                          STANDARD ERROR OF ESTIMATE (R)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2     
 
         6.93E-02  6.33E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        3.10E-04
 
 ETA2
+        2.32E-04  3.43E-04
 
 ETA3
+        0.00E+00  0.00E+00  2.13E-03
 
 ETA4
+        0.00E+00  0.00E+00  1.68E-03  2.45E-03
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.24E-02
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.45E-02  2.72E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.26E-04
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6     
 
 ETA1
+        1.68E-03
 
 ETA2
+        2.61E-02  1.78E-03
 
 ETA3
+       ......... .........  6.75E-03
 
 ETA4
+       ......... .........  6.30E-02  7.23E-03
 
 ETA5
+       ......... ......... ......... .........  5.09E-02
 
 ETA6
+       ......... ......... ......... .........  2.45E-01  4.79E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        6.31E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                  IMPORTANCE SAMPLING ASSISTED BY MAP ESTIMATION                ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (R)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        4.80E-03
 
 TH 2
+       -6.97E-04  4.00E-03
 
 OM11
+       -3.10E-07  4.73E-07  9.59E-08
 
 OM12
+        2.84E-08 -1.85E-07  6.35E-09  5.40E-08
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        1.10E-06  5.65E-08 -1.50E-10  4.84E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.18E-07
 
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
+        5.09E-06  2.18E-05  1.72E-08  4.16E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -7.86E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  4.54E-06
 
 OM34
+        5.44E-06  6.51E-06 -5.17E-09 -1.66E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00  9.48E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -2.35E-07  2.82E-06
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -1.82E-06  2.41E-06  1.43E-08  3.92E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -8.03E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -8.03E-08  3.63E-09  0.00E+00  0.00E+00  6.00E-06
 
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
+        4.67E-05  5.28E-04  1.06E-07 -2.14E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.36E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  7.28E-06  3.35E-06  0.00E+00  0.00E+00  3.66E-06  0.00E+00  0.00E+00  1.05E-03
 
 OM56
+        4.29E-04 -2.69E-04 -5.55E-08  1.21E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.89E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -4.20E-06  1.62E-06  0.00E+00  0.00E+00 -8.23E-07  0.00E+00  0.00E+00 -4.95E-04  6.02E-04
 
 OM66
+       -8.20E-05  5.40E-04 -3.08E-08 -1.33E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -4.79E-07  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.70E-06 -3.53E-06  0.00E+00  0.00E+00  1.64E-07  0.00E+00  0.00E+00  2.03E-04 -2.02E-04  7.38E-04
 
 SG11
+        2.20E-08  6.32E-08 -3.13E-09 -1.17E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -4.00E-09  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.32E-09  7.67E-11  0.00E+00  0.00E+00 -2.00E-09  0.00E+00  0.00E+00 -8.56E-08  2.01E-08  7.34E-09  1.59E-08
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                  IMPORTANCE SAMPLING ASSISTED BY MAP ESTIMATION                ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (R)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        6.93E-02
 
 TH 2
+       -1.59E-01  6.33E-02
 
 OM11
+       -1.44E-02  2.41E-02  3.10E-04
 
 OM12
+        1.76E-03 -1.26E-02  8.82E-02  2.32E-04
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        4.62E-02  2.60E-03 -1.42E-03  6.08E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.43E-04
 
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
+        3.45E-02  1.62E-01  2.61E-02  8.40E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.08E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.13E-03
 
 OM34
+        4.67E-02  6.13E-02 -9.94E-03 -4.25E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.65E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -6.56E-02  1.68E-03
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+       -1.07E-02  1.55E-02  1.88E-02  6.89E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -9.56E-03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -1.54E-02  8.83E-04  0.00E+00  0.00E+00  2.45E-03
 
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
+        2.08E-02  2.58E-01  1.06E-02 -2.84E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.03E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.05E-01  6.16E-02  0.00E+00  0.00E+00  4.62E-02  0.00E+00  0.00E+00  3.24E-02
 
 OM56
+        2.52E-01 -1.73E-01 -7.30E-03  2.12E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.25E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -8.04E-02  3.94E-02  0.00E+00  0.00E+00 -1.37E-02  0.00E+00  0.00E+00 -6.22E-01  2.45E-02
 
 OM66
+       -4.36E-02  3.14E-01 -3.66E-03 -2.10E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -5.14E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.93E-02 -7.73E-02  0.00E+00  0.00E+00  2.46E-03  0.00E+00  0.00E+00  2.30E-01 -3.03E-01  2.72E-02
 
 SG11
+        2.52E-03  7.91E-03 -8.01E-02 -4.00E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -9.25E-02  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  8.62E-03  3.62E-04  0.00E+00  0.00E+00 -6.46E-03  0.00E+00  0.00E+00 -2.09E-02  6.50E-03  2.14E-03  1.26E-04
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                  IMPORTANCE SAMPLING ASSISTED BY MAP ESTIMATION                ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (R)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      OM11      OM12      OM13      OM14      OM15      OM16      OM22      OM23      OM24      OM25  
             OM26      OM33      OM34      OM35      OM36      OM44      OM45      OM46      OM55      OM56      OM66      SG11  

 
 TH 1
+        2.47E+02
 
 TH 2
+        5.55E+01  3.11E+02
 
 OM11
+        4.89E+02 -1.24E+03  1.06E+07
 
 OM12
+        6.42E+02  7.78E+02 -1.21E+06  1.88E+07
 
 OM13
+       ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.62E+03 -1.93E+03  1.29E+05 -7.53E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00  8.67E+06
 
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
+       -5.58E+02 -1.37E+03 -3.43E+04 -1.37E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.95E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.31E+05
 
 OM34
+       -3.19E+02 -9.44E+02  1.29E+04  1.18E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.29E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  2.46E+04  3.67E+05
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+        1.04E+02 -3.99E+01 -2.33E+04 -9.09E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.02E+04  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  4.07E+03  1.32E+03  0.00E+00  0.00E+00  1.67E+05
 
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
+       -1.72E+02 -1.56E+02 -1.77E+02 -3.90E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.94E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -6.20E+02 -2.34E+03  0.00E+00  0.00E+00 -8.54E+02  0.00E+00  0.00E+00  1.76E+03
 
 OM56
+       -3.13E+02 -1.06E+02  2.65E+02 -6.68E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  4.78E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.16E+03 -2.13E+03  0.00E+00  0.00E+00 -5.10E+02  0.00E+00  0.00E+00  1.51E+03  3.26E+03
 
 OM66
+       -5.31E+01 -2.10E+02  1.51E+03  2.18E+03  0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.39E+03  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  1.03E+03  2.42E+03  0.00E+00  0.00E+00  9.94E+01  0.00E+00  0.00E+00  1.61E+01  5.09E+02  1.65E+03
 
 SG11
+       -1.49E+03 -2.39E+03  2.03E+06  9.44E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.18E+06  0.00E+00  0.00E+00  0.00E+00
          0.00E+00 -3.51E+04 -6.49E+03  0.00E+00  0.00E+00  1.37E+04  0.00E+00  0.00E+00  9.33E+03  5.13E+03  1.50E+03  6.38E+07
 
 SKIPPING EXECUTION OF SLOW FNLMOD/FNLETA BY USER REQUEST
 Elapsed postprocess time in seconds:     0.11
 Elapsed finaloutput time in seconds:     2.45
 #CPUT: Total CPU Time in Seconds,      498.579
Stop Time: 
Thu 12/12/2019 
05:46 PM
