Wed 10/04/2023 
02:20 PM
;$SIZES ISAMPLEMAX=30
;Model Desc: Receptor Mediated Clearance model with Dynamic Change 
;            in Receptors
;Project Name: nm7examples
;Project ID: NO PROJECT DESCRIPTION

$PROB RUN# example6 (from r2compl)
$ABBR DERIV2=NO
$INPUT C SET ID JID TIME DV=CONC DOSE=AMT RATE EVID MDV CMT
$DATA example6.csv IGNORE=C

; The new numerical integration solver is used, although ADVAN=9 
; is also efficient for this problem.

$SUBROUTINES ADVAN13 TRANS1 TOL=4
$MODEL NCOMPARTMENTS=3

$PK
include c:\nm75g64\util\nonmem_reserved_general
; MUFIRSTREC=1 calls MU reference evaluation only once per individual, saving time
MUFIRSTREC=1
; OBJQUICK=2 uses faster evaluation of model, can be used for simple models.
OBJQUICK=2
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
CALLFL=0
ETYPE=1
IF(CMT.NE.1) ETYPE=0
IPRED=F
Y = F + F*ETYPE*EPS(1) + F*(1.0-ETYPE)*EPS(2)


$THETA 
;Initial Thetas
( 4.0 )  ;[MU_1]
( -2.1 ) ;[MU_2]
( 0.7 )  ;[MU_3]
( -0.17 );[MU_4]      
( 2.2 ) ;[MU_5]
( 0.14 )  ;[MU_6]
( 3.7 )  ;[MU_7]
( -0.7) ;[MU_8]


;Initial Omegas
$OMEGA BLOCK(8) VALUES(0.1,0.01)

$SIGMA  
0.02 ;[p]
0.02;[p]

$PRIOR NWPRI
; Omega prior
$OMEGAP BLOCK(8)
0.2 FIX
0.0 0.2
0.0 0.0 0.2
0.0 0.0 0.0 0.2
0.0 0.0 0.0 0.0 0.2
0.0 0.0 0.0 0.0 0.0 0.2
0.0 0.0 0.0 0.0 0.0 0.0 0.2
0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.2
; degrees of freedom for OMEGA prior
$OMEGAPD
(8 FIXED)           ;[dfo]

; Starting with a short iterative two stage analysis brings the 
; results closer so less time needs to be spent during the 
; burn-in of the BAYES analysis


$EST METHOD=ITS INTERACTION SIGL=4 NITER=15 PRINT=1 NOABORT NOPRIOR=1 file=nuts_example6_itsh.ext
$EST METHOD=bayes INTERACTION NBURN=200 NITER=0 PRINT=10 MASSRESET=1 NOPRIOR=0 file=nuts_example6_bayesh.ext
$EST METHOD=NUTS INTERACTION  NBURN=100 NUTS_BASE=20 NITER=200 PRINT=1 MASSRESET=0 PMADAPT=100  file=nuts_example6h.ext

;$EST METHOD=ITS INTERACTION NITER=25 NOABORT NOPRIOR=1 PRINT=1 SIGL=4 file=nuts_example6_its.ext
;$EST METHOD=NUTS AUTO=1 PRINT=1 NITER=1000 NOPRIOR=0 NUTS_INIT=5 file=nuts_example6.ext ; OLKJDF=5.0  SLKJDF=2.0

$COV MATRIX=R UNCONDITIONAL
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.

 (MU_WARNING 20) MU_001: MU_ VARIABLE SHOULD NOT BE DEFINED AFTER VERBATIM CODE.
  
License Registered to: NONMEM license (with RADAR5NM) for ICON Pharmacometrics Team
Expiration Date:    31 DEC 2030
Current Date:        4 OCT 2023
Days until program expires :2642
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.1
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 RUN# example6 (from r2compl)
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:     1750
 NO. OF DATA ITEMS IN DATA SET:  11
 ID DATA ITEM IS DATA ITEM NO.:   3
 DEP VARIABLE IS DATA ITEM NO.:   6
 MDV DATA ITEM IS DATA ITEM NO.: 10
0INDICES PASSED TO SUBROUTINE PRED:
   9   5   7   8   0   0  11   0   0   0   0
0LABELS FOR DATA ITEMS:
 C SET ID JID TIME CONC DOSE RATE EVID MDV CMT
0FORMAT FOR DATA:
 (2E2.0,2E3.0,E5.0,E10.0,2E5.0,3E2.0)

 TOT. NO. OF OBS RECS:     1568
 TOT. NO. OF INDIVIDUALS:       50
0LENGTH OF THETA:   9
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS BLOCK FORM:
  1
  1  1
  1  1  1
  1  1  1  1
  1  1  1  1  1
  1  1  1  1  1  1
  1  1  1  1  1  1  1
  1  1  1  1  1  1  1  1
  0  0  0  0  0  0  0  0  2
  0  0  0  0  0  0  0  0  2  2
  0  0  0  0  0  0  0  0  2  2  2
  0  0  0  0  0  0  0  0  2  2  2  2
  0  0  0  0  0  0  0  0  2  2  2  2  2
  0  0  0  0  0  0  0  0  2  2  2  2  2  2
  0  0  0  0  0  0  0  0  2  2  2  2  2  2  2
  0  0  0  0  0  0  0  0  2  2  2  2  2  2  2  2
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   2
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
 LOWER BOUND    INITIAL EST    UPPER BOUND
 -0.1000E+07     0.4000E+01     0.1000E+07
 -0.1000E+07    -0.2100E+01     0.1000E+07
 -0.1000E+07     0.7000E+00     0.1000E+07
 -0.1000E+07    -0.1700E+00     0.1000E+07
 -0.1000E+07     0.2200E+01     0.1000E+07
 -0.1000E+07     0.1400E+00     0.1000E+07
 -0.1000E+07     0.3700E+01     0.1000E+07
 -0.1000E+07    -0.7000E+00     0.1000E+07
  0.8000E+01     0.8000E+01     0.8000E+01
0INITIAL ESTIMATE OF OMEGA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.1000E+00
                  0.1000E-01   0.1000E+00
                  0.1000E-01   0.1000E-01   0.1000E+00
                  0.1000E-01   0.1000E-01   0.1000E-01   0.1000E+00
                  0.1000E-01   0.1000E-01   0.1000E-01   0.1000E-01   0.1000E+00
                  0.1000E-01   0.1000E-01   0.1000E-01   0.1000E-01   0.1000E-01   0.1000E+00
                  0.1000E-01   0.1000E-01   0.1000E-01   0.1000E-01   0.1000E-01   0.1000E-01   0.1000E+00
                  0.1000E-01   0.1000E-01   0.1000E-01   0.1000E-01   0.1000E-01   0.1000E-01   0.1000E-01   0.1000E+00
        2                                                                                  YES
                  0.2000E+00
                  0.0000E+00   0.2000E+00
                  0.0000E+00   0.0000E+00   0.2000E+00
                  0.0000E+00   0.0000E+00   0.0000E+00   0.2000E+00
                  0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.2000E+00
                  0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.2000E+00
                  0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.2000E+00
                  0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.2000E+00
0INITIAL ESTIMATE OF SIGMA:
 0.2000E-01
 0.0000E+00   0.2000E-01
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
0
 PRIOR SUBROUTINE USER-SUPPLIED
1DOUBLE PRECISION PREDPP VERSION 7.5.1

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
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   4
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
0DURING SIMULATION, ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 OTHERWISE, ERROR SUBROUTINE CALLED ONLY WITH OBSERVATION EVENTS.
0DES SUBROUTINE USES COMPACT STORAGE MODE.
1


 #TBLN:      1
 #METH: Iterative Two Stage (No Prior)

 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            3480
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      4
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     4
 NOPRIOR SETTING (NOPRIOR):                 1
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): nuts_example6_itsh.ext
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
 CONVERGENCE TYPE (CTYPE):                  0
 ITERATIONS (NITER):                        15
 ANNEAL SETTING (CONSTRAIN):                 1

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   4
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   4
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12

 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI

 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2   3   4   5   6   7   8
 THETAS THAT ARE SIGMA-LIKE:
 

 MONITORING OF SEARCH:

 iteration            0  OBJ=  -4402.1428207279678
 iteration            1  OBJ=  -4646.9007477989426
 iteration            2  OBJ=  -4687.9150554475636
 iteration            3  OBJ=  -4693.8553036554295
 iteration            4  OBJ=  -4696.5040886496390
 iteration            5  OBJ=  -4698.0484197011292
 iteration            6  OBJ=  -4699.0474610012971
 iteration            7  OBJ=  -4699.7427717699848
 iteration            8  OBJ=  -4700.2461488751615
 iteration            9  OBJ=  -4700.6213651255111
 iteration           10  OBJ=  -4700.9032372167831
 iteration           11  OBJ=  -4701.1297707994045
 iteration           12  OBJ=  -4701.3136571239138
 iteration           13  OBJ=  -4701.4586091751480
 iteration           14  OBJ=  -4701.5883501892658
 iteration           15  OBJ=  -4701.6887932586660

 #TERM:
 OPTIMIZATION WAS NOT TESTED FOR CONVERGENCE


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.

 ETABAR:         9.2524E-05 -1.2895E-03 -1.1590E-04  1.6553E-05  1.6669E-04  3.9397E-04  2.3376E-04  2.2385E-04
 SE:             6.9230E-02  5.5070E-02  3.7225E-02  6.6817E-02  5.4993E-02  5.7660E-02  6.4235E-02  5.8872E-02
 N:                      50          50          50          50          50          50          50          50

 P VAL.:         9.9893E-01  9.8132E-01  9.9752E-01  9.9980E-01  9.9758E-01  9.9455E-01  9.9710E-01  9.9697E-01

 ETASHRINKSD(%)  6.5907E-01  4.7536E+00  1.0405E+01  2.0737E+00  1.6018E+00  6.1047E+00  3.5433E-01  1.8560E+00
 ETASHRINKVR(%)  1.3138E+00  9.2813E+00  1.9728E+01  4.1043E+00  3.1780E+00  1.1837E+01  7.0741E-01  3.6775E+00
 EBVSHRINKSD(%)  6.6867E-01  4.9564E+00  1.0368E+01  2.0725E+00  1.5795E+00  6.0827E+00  3.8653E-01  1.8458E+00
 EBVSHRINKVR(%)  1.3329E+00  9.6671E+00  1.9661E+01  4.1021E+00  3.1341E+00  1.1795E+01  7.7157E-01  3.6574E+00
 RELATIVEINF(%)  1.0000E+02  3.5869E+01  6.3261E+01  9.2919E+01  7.0983E+01  4.7122E+01  1.0000E+02  6.5881E+01
 EPSSHRINKSD(%)  1.5444E+01  6.8830E+00
 EPSSHRINKVR(%)  2.8503E+01  1.3292E+01

  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         1568
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    2881.7912401298536     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -4701.6887932586660     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -1819.8975531288124     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                           400
  
 #TERE:
 Elapsed estimation  time in seconds:    81.50
 Elapsed covariance  time in seconds:     0.09
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************    -4701.689       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8     
 
         3.89E+00 -2.20E+00  5.96E-01 -1.69E-01  2.31E+00  2.52E-01  3.66E+00 -7.27E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        2.43E-01
 
 ETA2
+       -3.86E-02  1.67E-01
 
 ETA3
+        4.62E-02 -1.59E-02  8.63E-02
 
 ETA4
+        2.75E-02  5.68E-02 -3.71E-03  2.33E-01
 
 ETA5
+        3.16E-02  2.81E-02 -4.19E-03 -3.09E-02  1.56E-01
 
 ETA6
+       -2.37E-02  1.05E-02  2.44E-02  1.69E-02 -8.05E-02  1.89E-01
 
 ETA7
+        2.71E-02 -4.62E-02  2.49E-02 -7.70E-02  3.13E-02  5.84E-03  2.08E-01
 
 ETA8
+        9.18E-02  7.87E-02  3.94E-02  4.42E-02  1.12E-02 -4.61E-02  4.41E-02  1.80E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        9.31E-03
 
 EPS2
+        0.00E+00  2.25E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        4.93E-01
 
 ETA2
+       -1.92E-01  4.09E-01
 
 ETA3
+        3.19E-01 -1.33E-01  2.94E-01
 
 ETA4
+        1.16E-01  2.88E-01 -2.62E-02  4.82E-01
 
 ETA5
+        1.62E-01  1.74E-01 -3.60E-02 -1.62E-01  3.95E-01
 
 ETA6
+       -1.11E-01  5.91E-02  1.91E-01  8.09E-02 -4.69E-01  4.34E-01
 
 ETA7
+        1.21E-01 -2.48E-01  1.86E-01 -3.50E-01  1.74E-01  2.95E-02  4.56E-01
 
 ETA8
+        4.39E-01  4.54E-01  3.16E-01  2.16E-01  6.68E-02 -2.50E-01  2.28E-01  4.24E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        9.65E-02
 
 EPS2
+        0.00E+00  1.50E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                          STANDARD ERROR OF ESTIMATE (S)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8     
 
         3.20E-01  2.25E-01  2.41E-01  2.42E-01  1.64E-01  2.90E-01  1.56E-01  3.04E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        1.54E-01
 
 ETA2
+        2.63E-01  4.05E-01
 
 ETA3
+        1.20E-01  1.56E-01  2.08E-01
 
 ETA4
+        9.04E-02  1.76E-01  1.19E-01  1.79E-01
 
 ETA5
+        1.44E-01  1.02E-01  9.78E-02  1.62E-01  2.83E-01
 
 ETA6
+        1.12E-01  1.75E-01  1.37E-01  1.74E-01  7.18E-02  1.59E-01
 
 ETA7
+        1.64E-01  1.18E-01  1.39E-01  1.01E-01  1.12E-01  9.81E-02  1.39E-01
 
 ETA8
+        2.05E-01  1.54E-01  7.42E-02  1.03E-01  1.26E-01  1.85E-01  1.13E-01  2.50E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        2.66E-03
 
 EPS2
+        0.00E+00  4.20E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        1.56E-01
 
 ETA2
+        1.13E+00  4.96E-01
 
 ETA3
+        7.42E-01  1.14E+00  3.54E-01
 
 ETA4
+        3.77E-01  7.43E-01  8.57E-01  1.85E-01
 
 ETA5
+        7.30E-01  7.15E-01  8.40E-01  9.22E-01  3.58E-01
 
 ETA6
+        5.31E-01  9.62E-01  1.07E+00  8.20E-01  6.92E-01  1.83E-01
 
 ETA7
+        7.18E-01  4.92E-01  1.14E+00  4.36E-01  6.98E-01  4.99E-01  1.53E-01
 
 ETA8
+        6.41E-01  9.68E-01  3.75E-01  3.96E-01  7.95E-01  8.79E-01  5.28E-01  2.95E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        1.38E-02
 
 EPS2
+       .........  1.40E-02
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (S)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 TH 1
+        1.02E-01
 
 TH 2
+       -7.23E-03  5.04E-02
 
 TH 3
+        4.32E-02 -4.84E-03  5.82E-02
 
 TH 4
+        4.31E-02 -8.15E-03 -3.64E-03  5.86E-02
 
 TH 5
+       -3.37E-02  1.07E-02 -8.75E-03 -2.31E-02  2.70E-02
 
 TH 6
+       -5.47E-02 -2.44E-03 -4.04E-02 -1.01E-02  2.11E-02  8.41E-02
 
 TH 7
+       -1.63E-02 -3.72E-03  5.73E-03 -2.14E-02  1.13E-02  1.01E-02  2.43E-02
 
 TH 8
+        7.31E-02 -1.74E-02  2.52E-02  4.74E-02 -2.74E-02 -3.41E-02 -1.41E-02  9.26E-02
 
 OM11
+       -2.99E-02 -3.58E-03 -2.52E-02 -1.59E-03  1.03E-02  2.27E-02  1.15E-03 -1.38E-02  2.36E-02
 
 OM12
+       -9.12E-03  3.75E-02  5.77E-03 -1.92E-02  9.19E-03 -4.12E-03  1.45E-03 -4.39E-02 -1.02E-02  6.93E-02
 
 OM13
+       -1.20E-02 -1.53E-02 -1.55E-03 -5.67E-03  3.58E-03  7.69E-03  4.12E-03  9.85E-04  8.70E-03 -2.19E-02  1.43E-02
 
 OM14
+       -3.08E-03 -2.57E-03  5.45E-03 -9.73E-03  1.75E-03 -8.90E-03  6.54E-03 -4.54E-03 -1.46E-03 -3.14E-03  2.97E-03  8.17E-03
 
 OM15
+       -4.04E-03 -6.46E-03 -1.27E-02  9.17E-03  1.04E-03  2.39E-02 -4.36E-03 -2.95E-03  7.05E-03 -5.01E-04  6.15E-04 -9.18E-03
          2.08E-02
 
 OM16
+       -8.83E-03  1.42E-02 -1.37E-03 -9.54E-03  6.39E-03 -3.25E-03  9.68E-04 -6.44E-03  1.13E-03  1.17E-02 -2.93E-03  1.48E-03
         -7.75E-03  1.25E-02
 
 OM17
+       -3.67E-03 -9.83E-03 -2.15E-02  1.89E-02 -6.15E-04  1.40E-02 -8.08E-03  1.82E-02  1.63E-02 -2.70E-02  7.59E-03 -5.24E-03
          9.03E-03 -3.54E-03  2.68E-02
 
 OM18
+       -3.32E-02  3.96E-03 -4.09E-02  6.68E-03  1.15E-02  3.94E-02 -3.96E-03 -1.56E-02  2.47E-02 -2.23E-03  1.82E-03 -7.78E-03
          1.51E-02  4.33E-05  2.30E-02  4.20E-02
 
 OM22
+       -4.55E-02 -5.11E-02 -5.76E-02  1.23E-02  1.70E-03  6.27E-02 -2.47E-03  1.27E-02  3.51E-02 -8.09E-02  3.05E-02 -4.21E-03
          2.19E-02 -1.64E-02  4.47E-02  4.06E-02  1.64E-01
 
 OM23
+        2.09E-02  1.08E-02  2.57E-02 -7.52E-03 -2.44E-03 -2.65E-02  4.37E-03 -4.36E-04 -1.66E-02  2.09E-02 -1.05E-02  4.78E-03
         -1.11E-02  3.02E-03 -1.81E-02 -2.12E-02 -5.26E-02  2.45E-02
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM24
+       -2.68E-02 -1.02E-02 -2.35E-02  1.79E-03  3.51E-03  3.11E-02 -3.94E-03 -1.56E-02  1.27E-02  2.02E-04  2.95E-03 -9.29E-03
          1.88E-02 -4.46E-03  9.76E-03  2.19E-02  3.81E-02 -1.80E-02  3.10E-02
 
 OM25
+        1.39E-02  1.88E-04  6.44E-03  1.51E-03 -4.26E-03 -1.09E-02  1.44E-03  1.07E-02 -4.10E-03 -5.55E-03 -4.60E-04  3.47E-03
         -6.39E-03  9.75E-04 -1.66E-03 -9.44E-03 -5.95E-03  6.08E-03 -1.23E-02  1.04E-02
 
 OM26
+       -2.53E-02  1.48E-02 -2.85E-02 -1.81E-03  1.20E-02  3.44E-02 -1.77E-03 -1.96E-02  1.36E-02  1.45E-02 -4.71E-03 -8.72E-03
          1.28E-02  5.42E-03  7.62E-03  2.66E-02  1.31E-02 -1.09E-02  1.75E-02 -7.05E-03  3.08E-02
 
 OM27
+       -3.64E-03  1.82E-02  1.44E-03 -8.28E-03  6.28E-03 -6.99E-03  2.78E-03 -1.40E-02 -7.50E-04  2.07E-02 -6.85E-03  1.49E-03
         -6.03E-03  7.97E-03 -7.41E-03 -6.69E-04 -3.28E-02  9.40E-03 -8.27E-03  2.25E-03  5.12E-03  1.38E-02
 
 OM28
+       -3.33E-02  1.12E-02 -1.71E-02 -1.69E-02  1.06E-02  1.45E-02  4.49E-03 -3.94E-02  9.32E-03  2.43E-02 -2.98E-03 -8.14E-04
          3.49E-03  5.88E-03 -5.91E-03  1.11E-02 -5.46E-03 -2.24E-03  1.20E-02 -4.81E-03  1.38E-02  8.18E-03  2.36E-02
 
 OM33
+        3.77E-02 -2.63E-02  5.08E-03  2.85E-02 -1.96E-02 -1.17E-02 -1.05E-02  5.31E-02 -3.55E-03 -4.37E-02  7.98E-03 -2.19E-03
          3.28E-03 -1.09E-02  1.76E-02 -5.15E-03  4.15E-02 -9.39E-03 -2.44E-03  5.69E-03 -1.34E-02 -1.67E-02 -2.55E-02  4.33E-02
 
 OM34
+        1.29E-02 -1.31E-02  1.28E-02  4.42E-03 -5.95E-03 -1.76E-02  2.69E-03  1.92E-02 -3.47E-03 -1.90E-02  6.09E-03  5.41E-03
         -7.81E-03 -2.75E-03  2.09E-03 -1.21E-02  5.17E-03  2.81E-03 -1.03E-02  5.91E-03 -1.60E-02 -4.12E-03 -1.08E-02  1.37E-02
         1.41E-02
 
 OM35
+       -2.28E-03  3.17E-03 -1.21E-02  5.74E-03  8.18E-04  1.63E-02 -4.00E-03 -3.69E-03  3.13E-03  8.03E-04 -2.06E-03 -4.27E-03
          9.01E-03 -3.38E-03  4.84E-03  1.15E-02  1.21E-02 -5.71E-03  7.22E-03 -3.56E-03  9.59E-03 -2.23E-03  8.59E-04  7.62E-04
        -7.71E-03  9.56E-03
 
 OM36
+        1.60E-02  4.30E-03 -3.31E-03  1.14E-02 -1.10E-02 -1.93E-02 -1.16E-02  1.37E-02 -2.07E-03  3.55E-03 -6.47E-03 -3.42E-03
         -8.11E-04  4.40E-03  3.40E-03 -1.10E-03 -8.52E-03  1.59E-03  5.81E-04  2.01E-03  1.80E-03  2.69E-03  5.38E-04  6.30E-03
        -6.98E-05 -2.12E-03  1.87E-02
 
 OM37
+       -2.63E-02  8.84E-03 -2.31E-02 -4.35E-03  7.06E-03  2.24E-02 -2.68E-03 -2.32E-02  1.27E-02  1.09E-02 -2.95E-05 -5.29E-03
          9.90E-03  3.24E-03  4.70E-03  1.93E-02  1.34E-02 -1.24E-02  1.66E-02 -8.17E-03  1.84E-02  2.01E-03  1.50E-02 -1.25E-02
        -1.29E-02  7.18E-03  1.49E-03  1.94E-02
 
 OM38
+        4.56E-03 -1.01E-02 -2.14E-03  6.50E-03 -3.30E-03  4.44E-03 -1.80E-03  1.08E-02  2.60E-03 -1.52E-02  5.34E-03 -9.70E-04
          3.91E-03 -4.14E-03  7.18E-03  2.54E-03  2.02E-02 -6.52E-03  2.47E-03  6.84E-05 -1.19E-03 -5.67E-03 -5.98E-03  1.20E-02
         2.40E-03  2.26E-03 -9.32E-04 -2.45E-04  5.51E-03
 
 OM44
+       -2.39E-02 -1.45E-02  1.06E-02 -2.23E-02  7.47E-03  8.07E-05  1.02E-02 -1.88E-02  3.50E-03 -2.65E-03  1.13E-02  4.27E-03
         -2.72E-04 -2.25E-03 -5.74E-03 -6.94E-03  6.95E-03 -1.64E-03  8.54E-03 -5.05E-03 -9.13E-03 -3.86E-03  7.26E-03 -7.83E-03
         4.88E-03 -7.89E-03 -6.90E-03  2.01E-04 -7.44E-04  3.20E-02
 
 OM45
+       -1.82E-02  1.85E-02 -1.79E-02 -4.38E-03  9.31E-03  2.47E-02  1.24E-04 -2.74E-02  5.64E-03  2.68E-02 -7.82E-03 -4.96E-03
          9.02E-03  4.03E-03 -3.84E-03  1.61E-02 -1.13E-02 -2.92E-03  9.64E-03 -5.38E-03  2.21E-02  7.87E-03  1.47E-02 -2.06E-02
        -1.66E-02  9.26E-03 -2.18E-03  1.61E-02 -3.37E-03 -9.26E-03  2.61E-02
 
 OM46
+       -1.82E-02 -1.66E-02 -9.26E-03 -5.71E-03  6.33E-03  2.05E-02  9.53E-03  6.74E-03  1.10E-02 -3.26E-02  1.50E-02  3.53E-03
         -1.79E-03 -4.29E-04  1.05E-02  4.34E-03  4.98E-02 -1.40E-02  1.59E-03  4.16E-03  3.91E-05 -7.87E-03 -4.64E-03  1.22E-02
         7.67E-03 -2.01E-03 -9.00E-03 -1.82E-03  6.38E-03  5.59E-03 -8.56E-03  3.03E-02
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM47
+       -1.14E-02  8.52E-03 -5.19E-03 -4.35E-03  8.08E-03  1.02E-02  7.10E-03 -7.94E-03  5.42E-03  3.37E-03  5.78E-04  1.91E-03
         -3.16E-03  4.64E-03  1.82E-04  5.88E-03 -3.12E-03 -1.20E-03 -3.50E-03  5.19E-04  5.94E-03  5.55E-03  4.18E-03 -9.20E-03
        -2.15E-03  4.78E-04 -5.27E-03  3.40E-03 -1.43E-03 -3.80E-03  6.72E-03  5.17E-03  1.03E-02
 
 OM48
+       -2.44E-02 -2.91E-03 -1.72E-02 -4.51E-03  6.25E-03  1.72E-02  3.11E-03 -1.67E-02  1.01E-02 -2.83E-03  3.88E-03 -4.56E-05
          5.29E-03 -1.88E-03  5.43E-03  1.36E-02  2.31E-02 -9.66E-03  1.18E-02 -5.36E-03  7.74E-03 -1.54E-03  8.55E-03 -5.67E-03
        -3.42E-03  3.07E-03 -3.39E-03  8.52E-03  6.29E-04  5.86E-03  5.00E-03  4.09E-03  2.34E-03  1.06E-02
 
 OM55
+       -4.19E-02  2.40E-02 -1.30E-02 -3.15E-02  1.74E-02  1.24E-02  1.21E-02 -6.49E-02  1.07E-02  5.34E-02 -8.28E-03 -9.46E-04
          3.76E-03  1.17E-02 -1.78E-02  9.07E-03 -4.22E-02  6.75E-03  1.20E-02 -4.29E-03  2.05E-02  2.06E-02  3.90E-02 -4.90E-02
        -1.65E-02 -3.38E-03  2.40E-03  2.04E-02 -1.34E-02  1.40E-02  2.48E-02 -1.45E-02  7.75E-03  8.46E-03  8.01E-02
 
 OM56
+       -1.53E-03  6.71E-03 -8.91E-03  2.08E-03 -4.81E-04  2.94E-03 -5.65E-03 -2.53E-03  1.62E-03  4.69E-03 -3.50E-03 -2.70E-03
          1.93E-03  2.61E-03  2.67E-03  6.23E-03  7.19E-04 -2.19E-03  3.08E-03 -6.38E-04  6.79E-03  2.31E-03  3.05E-03 -1.80E-03
        -4.83E-03  2.98E-03  5.10E-03  4.98E-03 -4.46E-04 -5.93E-03  5.26E-03 -3.79E-03 -3.16E-04  8.37E-04  3.12E-03  5.15E-03
 
 OM57
+       -8.68E-03 -5.03E-03 -1.94E-02  8.33E-03  2.25E-03  1.46E-02 -4.07E-03  4.10E-03  1.16E-02 -1.51E-02  5.08E-03 -3.10E-03
          6.31E-03 -1.59E-03  1.49E-02  1.64E-02  3.28E-02 -1.43E-02  7.94E-03 -1.45E-03  8.40E-03 -3.38E-03 -4.37E-04  8.42E-03
        -1.36E-03  4.62E-03  7.04E-04  6.48E-03  4.85E-03 -4.35E-03  1.86E-03  8.89E-03  1.23E-03  5.38E-03 -6.84E-03  2.85E-03
          1.25E-02
 
 OM58
+        1.32E-02 -9.97E-03 -9.10E-03  1.85E-02 -6.56E-03  5.55E-03 -6.11E-03  2.30E-02  5.04E-03 -2.27E-02  4.12E-03 -3.17E-03
          7.38E-03 -6.01E-03  1.53E-02  7.48E-03  3.00E-02 -9.63E-03  1.83E-03  4.48E-03  4.97E-04 -7.19E-03 -9.32E-03  2.01E-02
         4.02E-03  4.04E-03  2.60E-03 -1.61E-03  6.81E-03 -8.54E-03 -4.40E-03  8.44E-03 -1.79E-03 -1.05E-04 -1.96E-02  7.00E-04
          9.19E-03  1.60E-02
 
 OM66
+       -2.91E-02  5.02E-03 -1.84E-02 -1.17E-02  1.29E-02  3.25E-02  5.02E-03 -2.18E-02  7.75E-03  4.63E-03  1.16E-03 -2.41E-03
          8.40E-03  5.59E-04  7.58E-04  1.57E-02  2.14E-02 -8.67E-03  1.34E-02 -8.40E-03  1.73E-02 -1.90E-03  8.23E-03 -9.72E-03
        -1.14E-02  9.33E-03 -8.35E-03  1.30E-02  9.07E-04 -5.23E-04  1.47E-02  5.62E-03  4.35E-03  7.98E-03  5.06E-03  7.57E-04
          3.90E-03 -2.34E-03  2.53E-02
 
 OM67
+        1.10E-02 -1.43E-02  7.79E-03  3.99E-03 -8.77E-03 -8.51E-03 -1.71E-03  1.11E-02 -5.53E-03 -1.02E-02  2.33E-03  8.11E-04
          4.97E-04 -5.75E-03 -1.02E-03 -8.88E-03  9.09E-03  1.08E-03  7.08E-04  9.09E-04 -9.61E-03 -7.34E-03 -6.40E-03  1.15E-02
         5.62E-03 -2.00E-03  1.87E-03 -6.29E-03  2.24E-03  4.65E-03 -9.27E-03  5.13E-04 -7.01E-03 -1.89E-03 -1.20E-02 -2.48E-03
         -2.52E-03  2.18E-03 -3.59E-03  9.63E-03
 
 OM68
+        4.83E-02 -4.14E-04  1.64E-02  2.64E-02 -1.90E-02 -2.90E-02 -1.40E-02  4.46E-02 -1.29E-02 -4.62E-03 -8.49E-03 -5.28E-03
         -1.45E-03  4.27E-04  3.59E-03 -1.18E-02 -1.91E-02  7.81E-03 -8.35E-03  5.09E-03 -6.44E-03 -2.31E-03 -1.66E-02  2.20E-02
         5.90E-03 -2.15E-03  1.65E-02 -1.10E-02  1.63E-03 -1.43E-02 -1.02E-02 -9.93E-03 -7.96E-03 -1.28E-02 -2.28E-02  1.73E-03
         -2.80E-03  7.49E-03 -1.51E-02  6.05E-03  3.42E-02
 
 OM77
+       -5.17E-03  9.83E-03  1.28E-04 -3.66E-03  1.09E-03 -6.79E-03 -4.40E-03 -1.97E-02 -2.26E-03  2.24E-02 -7.53E-03 -1.13E-03
          1.64E-03 -7.04E-04 -6.77E-03  7.08E-04 -2.44E-02  7.39E-03  3.17E-03 -3.11E-03  7.50E-04  4.46E-03  9.41E-03 -1.45E-02
        -5.16E-03  4.62E-04  2.42E-03  3.58E-03 -5.80E-03  3.81E-03  5.48E-03 -1.66E-02 -4.23E-03  1.48E-03  1.83E-02  1.79E-03
         -5.05E-03 -6.94E-03 -1.02E-03 -3.97E-04 -3.28E-03  1.94E-02
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM78
+        6.97E-03  5.45E-03 -9.46E-03  1.66E-02 -1.41E-03  6.11E-03 -8.48E-03  8.81E-03  5.06E-03  1.36E-03 -4.30E-03 -6.06E-03
          6.95E-03 -7.77E-04  1.11E-02  1.45E-02  1.55E-03 -4.23E-03  4.54E-03 -2.24E-03  8.81E-03  9.49E-04 -1.65E-03  3.43E-03
        -4.63E-03  5.79E-03  3.75E-03  4.60E-03  1.50E-03 -1.08E-02  5.74E-03 -5.57E-03  1.26E-03  4.25E-04 -4.10E-03  3.65E-03
          5.77E-03  6.38E-03  7.04E-04 -4.28E-03  6.25E-03  2.30E-03  1.28E-02
 
 OM88
+       -5.12E-02  1.98E-02 -4.34E-02 -7.86E-03  2.20E-02  4.70E-02  1.78E-03 -4.63E-02  2.50E-02  2.42E-02 -3.90E-03 -7.24E-03
          1.52E-02  5.66E-03  1.12E-02  4.31E-02  1.45E-02 -1.50E-02  2.30E-02 -1.16E-02  3.56E-02  1.01E-02  2.65E-02 -2.97E-02
        -2.18E-02  1.30E-02 -4.48E-03  2.81E-02 -2.93E-03 -5.08E-03  3.13E-02 -3.45E-03  1.18E-02  1.66E-02  3.77E-02  8.12E-03
          1.22E-02 -2.57E-03  2.28E-02 -1.65E-02 -2.48E-02  8.53E-03  1.35E-02  6.27E-02
 
 SG11
+        5.98E-04 -2.65E-04  1.24E-04  4.95E-04 -2.96E-04 -2.31E-04 -1.89E-04  6.38E-04 -9.06E-05 -3.14E-04  4.21E-06 -7.51E-05
          7.04E-05 -1.12E-04  1.51E-04 -8.65E-05  1.77E-04 -6.69E-05 -1.34E-05  5.74E-05 -1.46E-04 -1.41E-04 -2.57E-04  4.33E-04
         1.19E-04  3.13E-06  1.29E-04 -1.27E-04  1.06E-04 -1.42E-04 -1.70E-04  1.57E-05 -1.03E-04 -1.02E-04 -4.25E-04 -9.75E-06
          7.04E-05  2.07E-04 -1.98E-04  1.06E-04  3.35E-04 -1.25E-04  8.88E-05 -3.14E-04  7.09E-06
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+        7.57E-06 -6.07E-04  1.30E-04 -5.18E-05 -5.63E-05  5.96E-05  1.13E-04  4.24E-04  2.60E-05 -8.93E-04  3.72E-04  1.08E-04
         -3.95E-05 -2.03E-04  2.02E-04 -1.30E-04  1.01E-03 -2.25E-04 -1.52E-05  2.25E-05 -3.46E-04 -3.28E-04 -3.56E-04  5.32E-04
         2.85E-04 -5.16E-05 -2.14E-04 -2.07E-04  2.07E-04  2.43E-04 -4.31E-04  4.59E-04 -7.47E-05  3.40E-05 -7.61E-04 -1.28E-04
          1.20E-04  1.83E-04 -7.02E-06  1.80E-04 -9.20E-05 -2.80E-04 -1.38E-04 -4.66E-04  2.56E-06  0.00E+00  1.76E-05
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (S)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 TH 1
+        3.20E-01
 
 TH 2
+       -1.01E-01  2.25E-01
 
 TH 3
+        5.60E-01 -8.93E-02  2.41E-01
 
 TH 4
+        5.57E-01 -1.50E-01 -6.24E-02  2.42E-01
 
 TH 5
+       -6.41E-01  2.91E-01 -2.21E-01 -5.81E-01  1.64E-01
 
 TH 6
+       -5.90E-01 -3.75E-02 -5.77E-01 -1.44E-01  4.44E-01  2.90E-01
 
 TH 7
+       -3.27E-01 -1.06E-01  1.52E-01 -5.66E-01  4.42E-01  2.24E-01  1.56E-01
 
 TH 8
+        7.51E-01 -2.54E-01  3.43E-01  6.43E-01 -5.47E-01 -3.86E-01 -2.97E-01  3.04E-01
 
 OM11
+       -6.08E-01 -1.04E-01 -6.79E-01 -4.27E-02  4.10E-01  5.09E-01  4.80E-02 -2.96E-01  1.54E-01
 
 OM12
+       -1.08E-01  6.35E-01  9.08E-02 -3.01E-01  2.13E-01 -5.40E-02  3.53E-02 -5.47E-01 -2.52E-01  2.63E-01
 
 OM13
+       -3.15E-01 -5.68E-01 -5.36E-02 -1.96E-01  1.82E-01  2.22E-01  2.21E-01  2.71E-02  4.73E-01 -6.97E-01  1.20E-01
 
 OM14
+       -1.07E-01 -1.27E-01  2.50E-01 -4.45E-01  1.18E-01 -3.39E-01  4.64E-01 -1.65E-01 -1.05E-01 -1.32E-01  2.75E-01  9.04E-02
 
 OM15
+       -8.76E-02 -1.99E-01 -3.65E-01  2.63E-01  4.38E-02  5.70E-01 -1.94E-01 -6.71E-02  3.18E-01 -1.32E-02  3.56E-02 -7.04E-01
          1.44E-01
 
 OM16
+       -2.47E-01  5.63E-01 -5.07E-02 -3.52E-01  3.48E-01 -1.00E-01  5.55E-02 -1.89E-01  6.57E-02  3.96E-01 -2.19E-01  1.46E-01
         -4.80E-01  1.12E-01
 
 OM17
+       -7.02E-02 -2.68E-01 -5.44E-01  4.76E-01 -2.29E-02  2.96E-01 -3.17E-01  3.66E-01  6.46E-01 -6.27E-01  3.88E-01 -3.54E-01
          3.82E-01 -1.93E-01  1.64E-01
 
 OM18
+       -5.07E-01  8.60E-02 -8.27E-01  1.35E-01  3.43E-01  6.63E-01 -1.24E-01 -2.50E-01  7.85E-01 -4.13E-02  7.42E-02 -4.20E-01
          5.12E-01  1.89E-03  6.86E-01  2.05E-01
 
 OM22
+       -3.51E-01 -5.62E-01 -5.89E-01  1.26E-01  2.56E-02  5.34E-01 -3.91E-02  1.03E-01  5.64E-01 -7.59E-01  6.29E-01 -1.15E-01
          3.75E-01 -3.62E-01  6.74E-01  4.89E-01  4.05E-01
 
 OM23
+        4.18E-01  3.08E-01  6.80E-01 -1.99E-01 -9.48E-02 -5.85E-01  1.79E-01 -9.15E-03 -6.91E-01  5.08E-01 -5.60E-01  3.38E-01
         -4.92E-01  1.73E-01 -7.07E-01 -6.62E-01 -8.30E-01  1.56E-01
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM24
+       -4.75E-01 -2.57E-01 -5.52E-01  4.21E-02  1.21E-01  6.10E-01 -1.44E-01 -2.92E-01  4.70E-01  4.36E-03  1.40E-01 -5.84E-01
          7.40E-01 -2.26E-01  3.39E-01  6.07E-01  5.34E-01 -6.54E-01  1.76E-01
 
 OM25
+        4.26E-01  8.19E-03  2.61E-01  6.10E-02 -2.54E-01 -3.68E-01  9.05E-02  3.44E-01 -2.62E-01 -2.07E-01 -3.77E-02  3.76E-01
         -4.34E-01  8.54E-02 -9.94E-02 -4.52E-01 -1.44E-01  3.81E-01 -6.82E-01  1.02E-01
 
 OM26
+       -4.50E-01  3.75E-01 -6.74E-01 -4.27E-02  4.18E-01  6.77E-01 -6.47E-02 -3.67E-01  5.05E-01  3.13E-01 -2.25E-01 -5.50E-01
          5.04E-01  2.76E-01  2.65E-01  7.40E-01  1.85E-01 -3.97E-01  5.68E-01 -3.94E-01  1.75E-01
 
 OM27
+       -9.68E-02  6.91E-01  5.07E-02 -2.91E-01  3.25E-01 -2.05E-01  1.52E-01 -3.90E-01 -4.15E-02  6.68E-01 -4.87E-01  1.40E-01
         -3.55E-01  6.06E-01 -3.85E-01 -2.78E-02 -6.87E-01  5.11E-01 -4.00E-01  1.87E-01  2.48E-01  1.18E-01
 
 OM28
+       -6.76E-01  3.24E-01 -4.60E-01 -4.55E-01  4.22E-01  3.25E-01  1.87E-01 -8.43E-01  3.95E-01  6.01E-01 -1.62E-01 -5.86E-02
          1.57E-01  3.42E-01 -2.35E-01  3.53E-01 -8.76E-02 -9.30E-02  4.44E-01 -3.07E-01  5.10E-01  4.52E-01  1.54E-01
 
 OM33
+        5.66E-01 -5.63E-01  1.01E-01  5.66E-01 -5.74E-01 -1.94E-01 -3.24E-01  8.39E-01 -1.11E-01 -7.98E-01  3.20E-01 -1.16E-01
          1.09E-01 -4.66E-01  5.17E-01 -1.21E-01  4.92E-01 -2.88E-01 -6.66E-02  2.68E-01 -3.66E-01 -6.81E-01 -7.97E-01  2.08E-01
 
 OM34
+        3.40E-01 -4.91E-01  4.48E-01  1.54E-01 -3.06E-01 -5.12E-01  1.45E-01  5.32E-01 -1.90E-01 -6.08E-01  4.29E-01  5.05E-01
         -4.56E-01 -2.07E-01  1.08E-01 -4.98E-01  1.08E-01  1.52E-01 -4.91E-01  4.88E-01 -7.67E-01 -2.95E-01 -5.90E-01  5.55E-01
         1.19E-01
 
 OM35
+       -7.28E-02  1.45E-01 -5.12E-01  2.43E-01  5.10E-02  5.76E-01 -2.63E-01 -1.24E-01  2.08E-01  3.12E-02 -1.76E-01 -4.83E-01
          6.39E-01 -3.09E-01  3.02E-01  5.73E-01  3.05E-01 -3.74E-01  4.19E-01 -3.57E-01  5.60E-01 -1.94E-01  5.72E-02  3.74E-02
        -6.65E-01  9.78E-02
 
 OM36
+        3.66E-01  1.40E-01 -1.00E-01  3.44E-01 -4.90E-01 -4.86E-01 -5.44E-01  3.30E-01 -9.86E-02  9.87E-02 -3.95E-01 -2.77E-01
         -4.11E-02  2.87E-01  1.52E-01 -3.93E-02 -1.54E-01  7.41E-02  2.41E-02  1.44E-01  7.52E-02  1.67E-01  2.56E-02  2.21E-01
        -4.30E-03 -1.58E-01  1.37E-01
 
 OM37
+       -5.90E-01  2.83E-01 -6.87E-01 -1.29E-01  3.09E-01  5.55E-01 -1.23E-01 -5.46E-01  5.93E-01  2.98E-01 -1.77E-03 -4.20E-01
          4.93E-01  2.08E-01  2.06E-01  6.77E-01  2.37E-01 -5.68E-01  6.77E-01 -5.75E-01  7.55E-01  1.23E-01  6.99E-01 -4.32E-01
        -7.82E-01  5.28E-01  7.83E-02  1.39E-01
 
 OM38
+        1.92E-01 -6.05E-01 -1.20E-01  3.62E-01 -2.71E-01  2.06E-01 -1.56E-01  4.80E-01  2.28E-01 -7.79E-01  6.02E-01 -1.44E-01
          3.65E-01 -4.98E-01  5.91E-01  1.67E-01  6.72E-01 -5.61E-01  1.89E-01  9.03E-03 -9.14E-02 -6.50E-01 -5.24E-01  7.78E-01
         2.73E-01  3.12E-01 -9.18E-02 -2.37E-02  7.42E-02
 
 OM44
+       -4.17E-01 -3.60E-01  2.45E-01 -5.15E-01  2.54E-01  1.56E-03  3.65E-01 -3.45E-01  1.27E-01 -5.62E-02  5.27E-01  2.64E-01
         -1.05E-02 -1.12E-01 -1.96E-01 -1.89E-01  9.58E-02 -5.87E-02  2.71E-01 -2.76E-01 -2.91E-01 -1.83E-01  2.64E-01 -2.10E-01
         2.30E-01 -4.51E-01 -2.82E-01  8.06E-03 -5.60E-02  1.79E-01
 
 OM45
+       -3.51E-01  5.09E-01 -4.59E-01 -1.12E-01  3.51E-01  5.28E-01  4.92E-03 -5.57E-01  2.27E-01  6.30E-01 -4.04E-01 -3.39E-01
          3.87E-01  2.23E-01 -1.45E-01  4.85E-01 -1.73E-01 -1.16E-01  3.39E-01 -3.26E-01  7.81E-01  4.14E-01  5.91E-01 -6.13E-01
        -8.65E-01  5.86E-01 -9.87E-02  7.13E-01 -2.81E-01 -3.20E-01  1.62E-01
 
 OM46
+       -3.27E-01 -4.24E-01 -2.20E-01 -1.35E-01  2.21E-01  4.06E-01  3.51E-01  1.27E-01  4.12E-01 -7.10E-01  7.19E-01  2.24E-01
         -7.12E-02 -2.20E-02  3.68E-01  1.22E-01  7.05E-01 -5.12E-01  5.20E-02  2.34E-01  1.28E-03 -3.84E-01 -1.73E-01  3.38E-01
         3.71E-01 -1.18E-01 -3.78E-01 -7.49E-02  4.93E-01  1.79E-01 -3.04E-01  1.74E-01
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM47
+       -3.53E-01  3.75E-01 -2.12E-01 -1.78E-01  4.86E-01  3.48E-01  4.50E-01 -2.58E-01  3.48E-01  1.26E-01  4.77E-02  2.08E-01
         -2.16E-01  4.09E-01  1.10E-02  2.83E-01 -7.61E-02 -7.60E-02 -1.96E-01  5.03E-02  3.35E-01  4.66E-01  2.69E-01 -4.37E-01
        -1.79E-01  4.82E-02 -3.80E-01  2.41E-01 -1.90E-01 -2.10E-01  4.11E-01  2.93E-01  1.01E-01
 
 OM48
+       -7.41E-01 -1.26E-01 -6.92E-01 -1.81E-01  3.70E-01  5.75E-01  1.94E-01 -5.31E-01  6.39E-01 -1.04E-01  3.15E-01 -4.90E-03
          3.56E-01 -1.63E-01  3.22E-01  6.45E-01  5.54E-01 -5.99E-01  6.52E-01 -5.09E-01  4.28E-01 -1.27E-01  5.40E-01 -2.64E-01
        -2.79E-01  3.05E-01 -2.41E-01  5.93E-01  8.22E-02  3.18E-01  3.00E-01  2.28E-01  2.24E-01  1.03E-01
 
 OM55
+       -4.63E-01  3.78E-01 -1.90E-01 -4.60E-01  3.73E-01  1.51E-01  2.74E-01 -7.53E-01  2.45E-01  7.17E-01 -2.45E-01 -3.70E-02
          9.20E-02  3.69E-01 -3.84E-01  1.56E-01 -3.68E-01  1.52E-01  2.40E-01 -1.48E-01  4.12E-01  6.20E-01  8.96E-01 -8.31E-01
        -4.93E-01 -1.22E-01  6.20E-02  5.18E-01 -6.37E-01  2.77E-01  5.41E-01 -2.93E-01  2.71E-01  2.90E-01  2.83E-01
 
 OM56
+       -6.66E-02  4.16E-01 -5.14E-01  1.19E-01 -4.08E-02  1.41E-01 -5.05E-01 -1.16E-01  1.47E-01  2.48E-01 -4.08E-01 -4.15E-01
          1.86E-01  3.25E-01  2.27E-01  4.24E-01  2.47E-02 -1.95E-01  2.44E-01 -8.72E-02  5.40E-01  2.73E-01  2.76E-01 -1.21E-01
        -5.67E-01  4.25E-01  5.19E-01  4.98E-01 -8.38E-02 -4.61E-01  4.53E-01 -3.03E-01 -4.34E-02  1.13E-01  1.54E-01  7.18E-02
 
 OM57
+       -2.43E-01 -2.01E-01 -7.20E-01  3.08E-01  1.22E-01  4.50E-01 -2.34E-01  1.21E-01  6.74E-01 -5.12E-01  3.80E-01 -3.07E-01
          3.92E-01 -1.27E-01  8.13E-01  7.17E-01  7.25E-01 -8.17E-01  4.04E-01 -1.27E-01  4.29E-01 -2.58E-01 -2.55E-02  3.62E-01
        -1.03E-01  4.23E-01  4.61E-02  4.17E-01  5.85E-01 -2.18E-01  1.03E-01  4.57E-01  1.09E-01  4.68E-01 -2.16E-01  3.55E-01
          1.12E-01
 
 OM58
+        3.27E-01 -3.51E-01 -2.98E-01  6.05E-01 -3.16E-01  1.51E-01 -3.11E-01  5.97E-01  2.60E-01 -6.83E-01  2.73E-01 -2.78E-01
          4.05E-01 -4.25E-01  7.40E-01  2.89E-01  5.87E-01 -4.87E-01  8.24E-02  3.47E-01  2.24E-02 -4.84E-01 -4.80E-01  7.64E-01
         2.68E-01  3.27E-01  1.50E-01 -9.16E-02  7.26E-01 -3.78E-01 -2.15E-01  3.84E-01 -1.40E-01 -8.06E-03 -5.47E-01  7.72E-02
          6.51E-01  1.26E-01
 
 OM66
+       -5.72E-01  1.40E-01 -4.79E-01 -3.05E-01  4.95E-01  7.05E-01  2.03E-01 -4.51E-01  3.17E-01  1.11E-01  6.09E-02 -1.67E-01
          3.66E-01  3.14E-02  2.91E-02  4.82E-01  3.32E-01 -3.49E-01  4.77E-01 -5.18E-01  6.20E-01 -1.02E-01  3.36E-01 -2.94E-01
        -6.06E-01  6.00E-01 -3.84E-01  5.85E-01  7.68E-02 -1.84E-02  5.72E-01  2.03E-01  2.70E-01  4.87E-01  1.12E-01  6.63E-02
          2.19E-01 -1.16E-01  1.59E-01
 
 OM67
+        3.50E-01 -6.48E-01  3.29E-01  1.68E-01 -5.44E-01 -2.99E-01 -1.12E-01  3.73E-01 -3.67E-01 -3.95E-01  1.98E-01  9.14E-02
          3.51E-02 -5.24E-01 -6.32E-02 -4.42E-01  2.28E-01  7.05E-02  4.10E-02  9.08E-02 -5.58E-01 -6.36E-01 -4.24E-01  5.61E-01
         4.82E-01 -2.08E-01  1.40E-01 -4.60E-01  3.07E-01  2.65E-01 -5.84E-01  3.00E-02 -7.06E-01 -1.87E-01 -4.33E-01 -3.52E-01
         -2.30E-01  1.76E-01 -2.30E-01  9.81E-02
 
 OM68
+        8.16E-01 -9.98E-03  3.68E-01  5.90E-01 -6.25E-01 -5.41E-01 -4.85E-01  7.93E-01 -4.54E-01 -9.49E-02 -3.84E-01 -3.16E-01
         -5.45E-02  2.06E-02  1.19E-01 -3.11E-01 -2.55E-01  2.70E-01 -2.57E-01  2.70E-01 -1.99E-01 -1.06E-01 -5.84E-01  5.73E-01
         2.69E-01 -1.19E-01  6.54E-01 -4.26E-01  1.19E-01 -4.32E-01 -3.41E-01 -3.08E-01 -4.25E-01 -6.74E-01 -4.37E-01  1.31E-01
         -1.35E-01  3.21E-01 -5.15E-01  3.34E-01  1.85E-01
 
 OM77
+       -1.16E-01  3.14E-01  3.79E-03 -1.08E-01  4.77E-02 -1.68E-01 -2.02E-01 -4.64E-01 -1.05E-01  6.09E-01 -4.51E-01 -8.94E-02
          8.15E-02 -4.51E-02 -2.97E-01  2.48E-02 -4.31E-01  3.39E-01  1.29E-01 -2.19E-01  3.07E-02  2.72E-01  4.39E-01 -4.99E-01
        -3.12E-01  3.39E-02  1.27E-01  1.84E-01 -5.60E-01  1.53E-01  2.43E-01 -6.85E-01 -3.00E-01  1.03E-01  4.64E-01  1.79E-01
         -3.24E-01 -3.94E-01 -4.60E-02 -2.90E-02 -1.27E-01  1.39E-01
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM78
+        1.93E-01  2.14E-01 -3.46E-01  6.05E-01 -7.58E-02  1.86E-01 -4.81E-01  2.56E-01  2.91E-01  4.57E-02 -3.17E-01 -5.92E-01
          4.25E-01 -6.13E-02  6.00E-01  6.25E-01  3.39E-02 -2.39E-01  2.28E-01 -1.94E-01  4.44E-01  7.12E-02 -9.48E-02  1.46E-01
        -3.45E-01  5.23E-01  2.42E-01  2.92E-01  1.78E-01 -5.35E-01  3.14E-01 -2.83E-01  1.10E-01  3.65E-02 -1.28E-01  4.50E-01
          4.57E-01  4.46E-01  3.91E-02 -3.85E-01  2.99E-01  1.46E-01  1.13E-01
 
 OM88
+       -6.39E-01  3.52E-01 -7.18E-01 -1.30E-01  5.35E-01  6.48E-01  4.57E-02 -6.08E-01  6.51E-01  3.68E-01 -1.30E-01 -3.20E-01
          4.20E-01  2.02E-01  2.74E-01  8.41E-01  1.43E-01 -3.84E-01  5.21E-01 -4.55E-01  8.10E-01  3.42E-01  6.90E-01 -5.69E-01
        -7.34E-01  5.30E-01 -1.31E-01  8.06E-01 -1.58E-01 -1.13E-01  7.72E-01 -7.91E-02  4.64E-01  6.42E-01  5.33E-01  4.52E-01
          4.35E-01 -8.11E-02  5.74E-01 -6.71E-01 -5.36E-01  2.44E-01  4.75E-01  2.50E-01
 
 SG11
+        7.02E-01 -4.43E-01  1.93E-01  7.69E-01 -6.77E-01 -2.99E-01 -4.55E-01  7.87E-01 -2.22E-01 -4.49E-01  1.32E-02 -3.12E-01
          1.83E-01 -3.76E-01  3.47E-01 -1.59E-01  1.64E-01 -1.61E-01 -2.85E-02  2.11E-01 -3.12E-01 -4.51E-01 -6.28E-01  7.81E-01
         3.77E-01  1.20E-02  3.53E-01 -3.43E-01  5.39E-01 -2.98E-01 -3.94E-01  3.39E-02 -3.82E-01 -3.74E-01 -5.64E-01 -5.10E-02
          2.37E-01  6.16E-01 -4.68E-01  4.06E-01  6.80E-01 -3.38E-01  2.95E-01 -4.71E-01  2.66E-03
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+        5.64E-03 -6.44E-01  1.28E-01 -5.09E-02 -8.16E-02  4.90E-02  1.72E-01  3.32E-01  4.03E-02 -8.08E-01  7.40E-01  2.84E-01
         -6.52E-02 -4.32E-01  2.93E-01 -1.51E-01  5.91E-01 -3.42E-01 -2.05E-02  5.25E-02 -4.70E-01 -6.64E-01 -5.51E-01  6.08E-01
         5.72E-01 -1.26E-01 -3.73E-01 -3.54E-01  6.66E-01  3.23E-01 -6.35E-01  6.28E-01 -1.76E-01  7.87E-02 -6.41E-01 -4.26E-01
          2.56E-01  3.45E-01 -1.05E-02  4.37E-01 -1.19E-01 -4.78E-01 -2.90E-01 -4.44E-01  2.29E-01  0.00E+00  4.20E-03
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                          ITERATIVE TWO STAGE (NO PRIOR)                        ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (S)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 TH 1
+        3.21E+02
 
 TH 2
+        1.72E+02  4.37E+02
 
 TH 3
+       -1.87E+01  5.75E+01  5.20E+02
 
 TH 4
+       -1.74E+01 -1.54E+01  6.72E+00  2.69E+02
 
 TH 5
+       -9.66E+01 -1.36E+02 -1.19E+01  2.02E+01  4.09E+02
 
 TH 6
+       -4.16E+01 -8.32E+01 -6.72E+01 -4.30E+01  1.33E+02  2.90E+02
 
 TH 7
+        6.79E+01  1.75E+02 -7.79E-01  1.15E+02 -1.14E+02 -9.57E+01  3.93E+02
 
 TH 8
+       -2.25E+02 -3.03E+02 -1.52E+02 -9.41E+01  1.23E+02  1.61E+02 -2.38E+02  6.28E+02
 
 OM11
+        8.43E+01  5.47E+01 -9.32E+01  3.85E+01  1.01E+01  1.17E+02  1.35E+02 -5.52E+01  9.71E+02
 
 OM12
+        1.51E+02  1.40E+02  2.37E+01  4.29E+02  4.55E+01  6.56E+01  4.03E+02 -3.95E+02  9.28E+02  3.64E+03
 
 OM13
+       -2.16E+02 -6.74E+01 -2.86E+02  7.24E+01 -1.47E+02  3.42E+01  1.66E+02  2.24E+02 -6.41E+02 -4.85E+02  3.06E+03
 
 OM14
+        9.13E+01  4.83E+02  1.14E+02  5.12E+01 -1.04E+02  9.03E+01  1.24E+02 -1.84E+02 -1.01E+02  5.66E+02 -1.54E+02  2.45E+03
 
 OM15
+        4.19E+01  1.25E+02 -1.77E+02 -9.43E+01 -4.34E+02 -3.89E+02 -3.55E+01 -5.70E+01 -7.87E+02 -2.00E+03  9.44E+02 -3.95E+02
          3.20E+03
 
 OM16
+        2.21E+02  7.08E+01 -3.62E+00  1.01E+02 -3.48E+02 -3.25E+02  1.42E+02 -2.35E+02  3.59E+01 -5.27E+02 -3.61E+02 -6.59E+02
          1.05E+03  1.79E+03
 
 OM17
+        2.13E+02  2.25E+02  1.65E+02  1.10E+02 -1.58E+00  1.90E+02  1.61E+02 -2.66E+02  5.98E+02  2.27E+03 -1.27E+03  1.29E+03
         -1.94E+03 -5.66E+02  3.21E+03
 
 OM18
+       -1.29E+02 -3.37E+02  1.56E+02 -1.37E+02  1.46E+01 -2.39E+02 -3.86E+02  3.30E+02 -1.20E+03 -3.12E+03  5.43E+02 -1.14E+03
          2.17E+03  7.36E+02 -2.69E+03  4.55E+03
 
 OM22
+        1.41E+02  2.25E+02  1.27E+01  2.58E+02 -7.80E+01 -8.67E+00  3.14E+02 -3.62E+02  4.21E+02  2.22E+03 -8.60E+01  3.01E+02
         -1.01E+03 -2.99E+02  1.23E+03 -1.92E+03  1.91E+03
 
 OM23
+       -1.05E+01 -1.71E+02 -1.70E+02 -4.71E+01 -1.18E+02  1.85E+02 -2.25E+02  2.61E+02 -4.51E+02 -6.11E+02  1.52E+03 -5.48E+02
          6.24E+02 -6.80E+01 -6.17E+02  1.14E+03 -5.80E+01  3.19E+03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM24
+        4.82E+02  6.39E+02 -6.05E+01 -2.33E+01 -1.09E+02  7.09E+01  2.43E+02 -5.35E+02  3.48E+02  7.59E+02 -5.46E+02  1.93E+03
         -9.99E+02 -2.45E+02  1.66E+03 -1.41E+03  2.01E+02 -6.35E+02  4.16E+03
 
 OM25
+        5.91E+01  2.58E+01 -1.54E+02 -7.75E+01 -1.70E+02 -4.41E+02 -5.10E+01 -1.46E+02 -7.60E+02 -2.29E+03  3.93E+02 -9.53E+02
          3.39E+03  1.19E+03 -2.30E+03  2.63E+03 -1.49E+03 -4.82E+02 -7.77E+02  6.79E+03
 
 OM26
+        1.90E+01  1.27E+00  1.12E+02  8.42E+01 -3.52E+02 -4.03E+02  2.23E+02 -1.87E+01 -1.06E+02 -7.17E+02 -2.75E+02 -2.18E+02
          1.16E+03  1.23E+03 -7.72E+02  8.96E+02 -7.21E+02 -6.91E+02 -8.71E+02  2.14E+03  3.31E+03
 
 OM27
+        2.81E+02  2.17E+02 -2.23E+02  2.18E+02  4.87E+01  3.40E+02  3.05E+02 -2.35E+02  7.43E+02  2.48E+03 -4.46E+02  1.59E+03
         -2.20E+03 -7.36E+02  2.53E+03 -2.73E+03  1.57E+03 -6.04E+02  2.88E+03 -3.06E+03 -1.63E+03  4.79E+03
 
 OM28
+       -4.51E+02 -5.58E+02  1.24E+02 -4.43E+02 -2.11E+01 -4.20E+01 -5.01E+02  1.06E+03 -1.04E+03 -4.62E+03  6.92E+02 -1.26E+03
          2.65E+03  9.32E+02 -3.02E+03  4.65E+03 -3.33E+03  8.44E+02 -2.52E+03  3.17E+03  2.50E+03 -4.09E+03  9.05E+03
 
 OM33
+       -1.28E+02 -7.72E+01  2.30E+01  1.52E+02 -1.50E+01  2.33E+01 -6.30E+00 -1.12E+02 -7.35E+01 -8.23E+01  7.34E+02  1.66E+02
          2.95E+02  3.94E+02  7.32E+01 -4.97E+02 -2.91E+02  2.68E+02  2.41E+02 -1.25E+02  9.52E+01  3.39E+02  1.46E+02  2.85E+03
 
 OM34
+        1.22E+02 -5.16E+01  5.18E+01 -2.45E+02  6.04E+01  8.93E+01 -1.61E+02  1.51E+02 -7.04E+01 -4.40E+02  8.23E+01 -4.58E+02
          2.76E+02  8.72E+01 -3.79E+02  1.49E+02 -2.61E+02  2.28E+02 -5.73E+01  9.87E+02  2.40E+02 -3.75E+02  6.77E+02  1.75E+02
         2.44E+03
 
 OM35
+       -1.68E+02 -6.58E+01  2.76E+01  7.32E+01  1.91E+02  3.86E+01  1.32E+02  2.75E+02  5.52E+02  6.13E+02 -5.68E+02  2.80E+02
         -8.19E+02  4.36E+02  6.31E+02 -1.18E+03 -2.37E+02 -1.84E+03  9.74E+02  5.26E+01  9.29E+02  9.41E+02  5.77E+01  7.66E+02
         8.60E+02  4.30E+03
 
 OM36
+       -3.28E+00  1.73E+02  9.40E+01  4.74E+01  8.71E+01  1.90E+01  1.74E+02 -1.40E+02  6.14E+01  4.24E+01  8.85E+01  3.53E+01
          3.25E+02  6.87E+01 -3.33E+02  1.03E+01 -1.14E+02 -7.32E+02  2.23E+02  7.59E+02  3.81E+02 -3.48E+02  3.21E+01 -2.51E+01
        -8.46E+01  1.28E+03  1.67E+03
 
 OM37
+        1.52E+02 -3.06E+02 -3.20E+01 -1.30E+02  1.60E+02  2.05E+02 -2.97E+02  1.03E+02 -6.46E+02 -4.88E+02  8.70E+02 -4.24E+02
          6.08E+02 -3.89E+02 -4.74E+02  1.02E+03 -1.50E+02  2.37E+03 -4.40E+02  8.94E+02 -5.45E+02 -3.20E+02  2.28E+02  1.85E+02
         1.23E+03 -1.85E+03 -9.93E+02  4.05E+03
 
 OM38
+        1.81E+02  2.79E+02 -1.66E+02  1.13E+02  3.11E+02 -1.61E+02  6.56E+01 -1.64E+02  7.59E+02  1.06E+03 -3.60E+03  1.23E+02
         -1.27E+03  2.51E+02  1.13E+03 -3.70E+01  5.36E+02 -2.70E+03  7.79E+02  8.04E+01  4.23E+02  5.20E+02 -1.29E+03 -3.31E+03
        -1.54E+03  3.07E+02  4.34E+02 -2.91E+03  1.03E+04
 
 OM44
+        3.57E+01 -7.56E+00 -1.57E+02  1.79E+02 -1.22E+02 -7.45E+01  1.31E+02 -1.06E+02  1.84E+02  5.16E+02 -2.30E+02 -1.69E+02
          1.43E+01  2.93E+02  1.24E+02 -2.94E+02  4.55E+02 -1.69E+02 -3.53E+02  9.36E+01  4.53E+02  1.32E+02 -4.13E+02  6.60E+01
        -1.47E+02  2.23E+02  6.17E+01 -4.20E+02  4.21E+02  6.92E+02
 
 OM45
+       -1.06E+02 -1.10E+02  6.91E+01 -2.28E+02  1.25E+02  1.52E+02 -2.67E+02  2.96E+02 -2.53E+02 -1.04E+03  3.20E+02 -4.70E+02
          1.57E+02 -1.41E+02 -3.28E+02  8.36E+02 -4.53E+02  1.01E+03 -5.21E+02 -5.84E+02 -1.03E+03 -4.60E+02  1.34E+03  2.66E+02
         3.68E+02 -3.93E+02 -1.17E+02  4.49E+02 -1.35E+03 -2.57E+02  1.77E+03
 
 OM46
+        8.46E+01  7.38E+01  1.10E+02 -1.46E+02  1.57E+02  3.04E+01 -1.71E+02  1.56E+01 -2.00E+02 -1.55E+02  7.48E+01  3.24E+02
         -2.20E+02 -5.02E+02  1.97E+02  8.88E+01 -2.99E+02  2.94E+02  4.65E+02 -1.12E+03 -1.18E+03  3.26E+02 -3.10E+02  8.12E+01
        -1.02E+02 -1.41E+02  6.11E+01  3.53E+02 -5.98E+02 -5.28E+02  7.28E+02  1.56E+03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM47
+        1.36E+02  2.67E+02 -1.55E+02  2.70E+02 -2.83E+02 -1.90E+02  2.69E+02 -4.92E+02  2.75E+02  1.20E+03 -4.42E+02  6.42E+02
         -4.81E+01  3.04E+02  7.95E+02 -8.68E+02  8.39E+02 -6.23E+02  1.23E+03 -2.14E+01  4.67E+02  1.08E+03 -1.84E+03  1.93E+02
        -8.32E+02  4.71E+02  4.26E+02 -1.25E+03  1.63E+03  7.48E+02 -1.09E+03 -8.14E+02  2.80E+03
 
 OM48
+       -1.92E+02 -5.40E+02  1.83E+02 -2.13E+02  2.98E+02  1.46E+01 -4.64E+02  3.60E+02 -2.61E+02 -1.05E+03  1.87E+02 -1.84E+03
          5.73E+02  1.46E+02 -1.32E+03  1.62E+03 -8.00E+02  9.39E+02 -2.43E+03  9.70E+02 -3.24E+02 -2.30E+03  1.87E+03 -5.09E+02
         1.16E+02 -1.40E+03 -5.18E+02  1.30E+03 -4.16E+02 -4.91E+02  8.37E+02  5.11E+02 -1.94E+03  3.67E+03
 
 OM55
+       -2.10E+02 -1.23E+02  1.08E+02  6.21E+01  2.71E+02  1.50E+02 -1.72E+02  1.43E+02  1.73E+02  9.53E+02 -3.40E+02  1.38E+02
         -1.41E+03 -6.95E+02  8.30E+02 -1.14E+03  7.10E+02 -2.54E+02 -2.23E+02 -1.99E+03 -1.26E+03  6.78E+02 -1.81E+03 -2.84E+01
        -1.97E+02 -4.88E+00 -4.62E+02 -4.08E+02  4.08E+02 -9.22E+01  1.92E+02  3.22E+02 -2.46E+02  2.22E+02  1.50E+03
 
 OM56
+       -3.39E+02 -4.27E+02  8.12E+01  1.61E+02  2.17E+02  1.78E+02 -7.44E+01  3.23E+02  1.78E+02  9.07E+02  5.64E+02 -1.06E+02
         -1.63E+03 -1.29E+03  5.11E+02 -6.12E+02  6.61E+02  8.42E+02 -1.01E+03 -3.15E+03 -1.52E+03  6.07E+02 -1.06E+03 -1.18E+02
        -1.92E+02 -1.51E+03 -1.59E+03  3.71E+02 -9.31E+02  1.49E+01  3.10E+02  3.29E+02 -4.47E+02  6.74E+02  1.62E+03  4.78E+03
 
 OM57
+       -1.58E+00  1.16E+02  1.40E+02 -2.65E+02 -3.64E+02 -1.18E+02 -1.68E+02  4.62E+01 -6.60E+02 -2.01E+03  5.91E+02 -3.03E+02
          2.03E+03  4.81E+02 -1.46E+03  1.97E+03 -1.17E+03  1.12E+03 -4.24E+02  2.57E+03  6.89E+02 -2.32E+03  2.80E+03 -3.18E+02
         4.26E+02 -8.52E+02  1.83E+02  7.72E+02 -1.02E+03 -2.18E+02  4.67E+02 -2.34E+02 -2.02E+02  6.64E+02 -1.08E+03 -1.30E+03
          3.23E+03
 
 OM58
+       -1.87E+00 -1.85E+02  3.31E+02  2.72E+02  2.03E+02  3.39E+02  1.56E+02 -1.23E+02  9.65E+02  2.94E+03 -9.38E+02  7.49E+02
         -4.22E+03 -1.10E+03  2.46E+03 -2.51E+03  1.69E+03  1.65E+02  1.25E+03 -6.62E+03 -1.76E+03  3.46E+03 -3.99E+03 -5.69E+02
        -1.39E+03 -4.27E+02 -1.10E+03 -6.91E+02  1.14E+03  8.36E+01 -2.92E+02  5.04E+02  5.54E+02 -8.87E+02  1.93E+03  3.58E+03
         -3.01E+03  8.50E+03
 
 OM66
+       -1.42E+02 -1.96E+02  1.49E+01  2.86E+01  4.40E+01  8.62E+01 -9.73E+01  1.14E+02  8.94E+00  2.14E+02  1.70E+02 -1.87E+02
         -4.33E+02 -5.72E+02  1.45E+02 -1.22E+02  2.89E+02  1.24E+02 -5.43E+02 -4.88E+02 -7.76E+02  5.47E+01 -4.05E+02 -3.34E+02
        -4.55E+00 -8.74E+02 -6.32E+02  8.67E+01 -1.79E+01  3.24E+01  6.24E+01 -1.59E+02 -1.64E+02  4.51E+02  6.84E+02  1.65E+03
         -1.81E+02  7.77E+02  1.10E+03
 
 OM67
+        1.67E+02  3.55E+02  1.84E+02 -1.85E+02 -7.65E+01 -2.17E+02  5.31E+01 -1.93E+02 -3.51E+01 -6.31E+02 -4.60E+02  1.67E+02
          4.97E+02  5.55E+02 -2.36E+02  2.14E+02 -6.11E+02 -4.92E+02  2.06E+02  8.11E+02  9.41E+02 -7.40E+02  9.51E+02 -9.87E+01
         3.26E+02  3.89E+02  1.23E+02 -1.59E+02  1.53E+02 -2.05E+02 -1.15E+02  2.18E+02 -2.29E+02  9.72E+01 -4.42E+02 -9.10E+02
          6.85E+02 -9.96E+02 -5.88E+02  1.78E+03
 
 OM68
+       -1.87E+02 -4.47E+01 -1.22E+02  1.79E+01  2.37E+02  2.39E+02 -1.15E+02 -2.15E+01 -1.58E+01  7.91E+02  4.79E+02  2.72E+02
         -8.71E+02 -1.33E+03  3.96E+02 -8.84E+02  9.26E+02  2.86E+02 -1.28E+02 -1.45E+03 -2.20E+03  9.36E+02 -2.03E+03 -5.40E+02
        -4.76E+02 -1.21E+03 -6.33E+02  2.66E+02  4.72E+01 -1.09E+02  3.71E+02  4.72E+02 -1.00E+02  3.46E+02  1.15E+03  1.76E+03
         -6.29E+02  1.43E+03  9.76E+02 -9.56E+02  2.61E+03
 
 OM77
+        6.34E+01  8.22E+01 -1.45E+02  1.32E+02 -7.46E+01  3.81E+01  1.67E+02 -6.02E+01  2.11E+02  7.34E+02 -1.91E+02  5.28E+02
         -4.59E+02  3.42E+00  7.20E+02 -6.66E+02  5.19E+02 -4.05E+02  8.28E+02 -8.78E+02 -1.87E+02  1.32E+03 -1.17E+03  6.94E+01
        -6.14E+02  4.13E+02  1.50E+02 -8.09E+02  1.07E+03  2.40E+02 -3.23E+02 -7.35E+01  1.11E+03 -1.11E+03  8.91E+01 -2.41E+01
         -7.17E+02  9.32E+02 -6.80E+01 -4.62E+02  2.27E+02  1.03E+03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM78
+       -2.94E+02 -1.65E+02  6.49E+01 -4.56E+02  9.39E+01 -2.01E+02 -2.00E+02  3.52E+02 -7.74E+02 -2.65E+03  9.84E+02 -1.43E+03
          2.16E+03  3.72E+02 -2.73E+03  2.35E+03 -1.53E+03  5.31E+02 -2.71E+03  3.09E+03  1.03E+03 -3.78E+03  4.25E+03 -4.50E+02
         1.18E+03 -7.66E+02  8.49E+01  1.06E+03 -1.66E+03 -4.62E+02  9.70E+02  1.32E+02 -2.38E+03  2.67E+03 -6.47E+02 -5.84E+02
          2.12E+03 -4.04E+03  2.01E+01  1.27E+03 -7.12E+02 -1.84E+03  5.86E+03
 
 OM88
+        2.02E+02  4.79E+02 -3.77E+01  1.48E+02 -1.36E+02 -4.61E+00  2.82E+02 -5.24E+02  4.13E+02  1.96E+03  3.66E+02  1.07E+03
         -8.86E+02 -4.96E+02  1.28E+03 -3.05E+03  1.44E+03 -8.34E+02  1.29E+03 -1.43E+03 -9.46E+02  1.80E+03 -4.03E+03  1.06E+03
        -6.00E+01  6.40E+02  3.09E+02 -6.37E+02 -1.40E+03  1.29E+02 -6.75E+02  2.65E+02  7.90E+02 -1.62E+03  7.24E+02  2.69E+01
         -1.41E+03  1.06E+03 -1.18E+02 -1.37E+02  9.72E+02  5.40E+02 -2.08E+03  3.64E+03
 
 SG11
+       -2.79E+03  5.86E+03 -2.37E+03 -1.09E+03 -2.81E+03  2.19E+03  9.94E+03 -1.35E+03  7.27E+03  1.95E+04  1.75E+04  6.06E+03
         -1.00E+04 -6.77E+03  1.09E+04 -2.22E+04  2.30E+04  1.04E+04 -1.99E+04 -1.93E+04  1.75E+04  9.91E+03 -1.05E+04 -7.60E+03
         6.86E+02 -8.09E+03 -7.14E+03 -5.57E+02 -1.57E+04  1.07E+04 -1.01E+04 -2.06E+04  8.32E+03 -1.40E+04  1.09E+03  2.67E+04
         -2.03E+04  2.00E+04  1.04E+04 -4.35E+03  5.40E+03  8.57E+03 -6.86E+03  1.06E+04  2.57E+06
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+       -3.04E+03 -3.12E+03  2.47E+03  4.03E+03  2.16E+03  8.60E+02 -1.60E+03  4.44E+03  5.69E+03  4.53E+03 -4.49E+03 -7.49E+03
         -4.29E+03  5.52E+03 -1.08E+03 -8.17E+02 -5.54E+02 -2.12E+03 -1.95E+04 -5.12E+03  1.12E+04 -6.97E+03  1.71E+04  2.30E+03
         1.01E+03  1.48E+04  4.26E+03 -8.46E+03 -8.02E+03  3.32E+03  5.17E+03 -3.98E+03 -5.94E+03  6.45E+03  3.48E+03  1.04E+03
         -9.05E+03  5.94E+03 -2.37E+03  1.23E+03 -2.38E+03 -1.57E+03  4.23E+02 -9.08E+02  2.27E+05  0.00E+00  9.09E+05
 
1


 #TBLN:      2
 #METH: MCMC Bayesian Analysis

 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            3480
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      4
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     4
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): nuts_example6_bayesh.ext
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
 CONVERGENCE TYPE (CTYPE):                  0
 KEEP ITERATIONS (THIN):            1
 BURN-IN ITERATIONS (NBURN):                200
 FIRST ITERATION FOR MAP (MAPITERS):          NO
 ITERATIONS (NITER):                        0
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
 MC SAMPLES PER SUBJECT (ISAMPLE):          1
 RANDOM SAMPLING METHOD (RANMETHOD):        3U
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
 MASS/IMP./POST. MATRIX REFRESH SETTING (MASSRESET):      1
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
 SAMPLES FOR LOCAL SEARCH KERNEL (OSAMPLE_M2):           36
 SAMPLES FOR LOCAL UNIVARIATE SEARCH KERNEL (OSAMPLE_M3):36
 USER DEFINED PRIOR SETTING FOR THETAS: (TPU):        0.00000000000000
 WEIGHT FACTOR FOR STD PRIOR FOR SIGMAS (SVARF): -1.000000000000000+300

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   4
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   4
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12

 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI

 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2   3   4   5   6   7   8
 THETAS THAT ARE GIBBS SAMPLED:
   1   2   3   4   5   6   7   8
 THETAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 SIGMAS THAT ARE GIBBS SAMPLED:
   1   2
 SIGMAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 OMEGAS ARE GIBBS SAMPLED

 MONITORING OF SEARCH:

 Burn-in Mode
 iteration         -200 MCMCOBJ=   -6764.8164814468400     
 iteration         -190 MCMCOBJ=   -6612.4729414266285     
 iteration         -180 MCMCOBJ=   -6689.4987314205482     
 iteration         -170 MCMCOBJ=   -6620.5370224478829     
 iteration         -160 MCMCOBJ=   -6605.7944369081279     
 iteration         -150 MCMCOBJ=   -6578.9854888854334     
 iteration         -140 MCMCOBJ=   -6596.5569629567963     
 iteration         -130 MCMCOBJ=   -6609.5417771023067     
 iteration         -120 MCMCOBJ=   -6607.8230341523386     
 iteration         -110 MCMCOBJ=   -6546.7535324214014     
 iteration         -100 MCMCOBJ=   -6577.2403138823447     
 iteration          -90 MCMCOBJ=   -6627.1213321474434     
 iteration          -80 MCMCOBJ=   -6511.9164960127364     
 iteration          -70 MCMCOBJ=   -6538.2771173740111     
 iteration          -60 MCMCOBJ=   -6607.3077612599664     
 iteration          -50 MCMCOBJ=   -6533.0007492141895     
 iteration          -40 MCMCOBJ=   -6590.7907515882616     
 iteration          -30 MCMCOBJ=   -6555.8721124792628     
 iteration          -20 MCMCOBJ=   -6518.5178433062783     
 iteration          -10 MCMCOBJ=   -6496.2000439150006     
 Sampling Mode
 iteration            0 MCMCOBJ=   -6558.0531258444526     

 #TERM:
 BURN-IN WAS NOT TESTED FOR CONVERGENCE
 STATISTICAL PORTION WAS NOT PERFORMED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.

 ETABAR:         1.6810E-02  9.2679E-03 -5.3423E-03  1.7155E-02  1.6454E-02 -5.8283E-02 -8.1883E-02  3.9032E-02
 SE:             7.0167E-02  5.7384E-02  3.9397E-02  6.5741E-02  5.7511E-02  5.7025E-02  6.4560E-02  6.1283E-02
 N:                      50          50          50          50          50          50          50          50

 P VAL.:         8.1066E-01  8.7169E-01  8.9214E-01  7.9413E-01  7.7480E-01  3.0675E-01  2.0469E-01  5.2419E-01

 ETASHRINKSD(%)  1.0672E+01  1.3079E+01  2.0746E+01  2.0131E+01  1.4081E+01  1.0530E+01  3.6825E+01  1.5248E+01
 ETASHRINKVR(%)  2.0205E+01  2.4448E+01  3.7188E+01  3.6209E+01  2.6179E+01  1.9951E+01  6.0089E+01  2.8171E+01
 EBVSHRINKSD(%)         NaN         NaN         NaN         NaN         NaN         NaN         NaN         NaN
 EBVSHRINKVR(%)         NaN         NaN         NaN         NaN         NaN         NaN         NaN         NaN
 RELATIVEINF(%)  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00  0.0000E+00
 EPSSHRINKSD(%)  1.9513E+00  1.0000E-10
 EPSSHRINKVR(%)  3.8645E+00  1.0000E-10

  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         1568
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    2881.7912401298536     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -6558.0531258444526     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -3676.2618857145990     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                           400
 NIND*NETA*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    735.15082656373818     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -6558.0531258444526     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -5822.9022992807140     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 PRIOR CONSTANT TO OBJECTIVE FUNCTION:    55.177915743687578     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -6558.0531258444526     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -6502.8752101007649     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:    85.42
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 #OBJT:**************                       AVERAGE VALUE OF LIKELIHOOD FUNCTION                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************    -6558.053       **************************************************
 #OBJS:********************************************        0.000 (STD) **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              MCMC BAYESIAN ANALYSIS                            ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8     
 
         3.87E+00 -2.22E+00  6.01E-01 -1.87E-01  2.27E+00  2.69E-01  3.75E+00 -7.55E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        3.09E-01
 
 ETA2
+       -8.70E-02  2.18E-01
 
 ETA3
+        6.42E-02 -3.81E-02  1.24E-01
 
 ETA4
+       -7.58E-02  7.97E-02 -1.01E-01  3.39E-01
 
 ETA5
+        1.03E-01  3.39E-02  3.86E-02 -8.93E-02  2.24E-01
 
 ETA6
+       -1.10E-01  9.47E-03  4.13E-04  2.91E-02 -9.78E-02  2.03E-01
 
 ETA7
+        1.07E-01 -9.50E-02  6.16E-02 -1.92E-01  8.20E-02  3.88E-03  5.22E-01
 
 ETA8
+        7.79E-02  8.12E-02  2.61E-02 -4.72E-02  5.76E-02 -2.27E-02  1.40E-01  2.61E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        9.80E-03
 
 EPS2
+        0.00E+00  2.11E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        5.55E-01
 
 ETA2
+       -3.35E-01  4.67E-01
 
 ETA3
+        3.29E-01 -2.32E-01  3.51E-01
 
 ETA4
+       -2.34E-01  2.93E-01 -4.95E-01  5.82E-01
 
 ETA5
+        3.91E-01  1.54E-01  2.32E-01 -3.24E-01  4.73E-01
 
 ETA6
+       -4.39E-01  4.50E-02  2.60E-03  1.11E-01 -4.59E-01  4.51E-01
 
 ETA7
+        2.67E-01 -2.82E-01  2.42E-01 -4.57E-01  2.40E-01  1.19E-02  7.23E-01
 
 ETA8
+        2.74E-01  3.40E-01  1.45E-01 -1.59E-01  2.38E-01 -9.87E-02  3.78E-01  5.11E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        9.90E-02
 
 EPS2
+        0.00E+00  1.45E-01
 
1


 #TBLN:      3
 #METH: NUTS Bayesian Analysis

 ESTIMATION STEP OMITTED:                 NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            3480
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      4
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     4
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): nuts_example6h.ext
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
 CONVERGENCE TYPE (CTYPE):                  0
 KEEP ITERATIONS (THIN):            1
 BURN-IN ITERATIONS (NBURN):                100
 FIRST ITERATION FOR MAP (MAPITERS):          NO
 ITERATIONS (NITER):                        200
 ANNEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
 MC SAMPLES PER SUBJECT (ISAMPLE):          1
 RANDOM SAMPLING METHOD (RANMETHOD):        3U
 PROPOSAL DENSITY SCALING RANGE
              (ISCALE_MIN, ISCALE_MAX):     1.000000000000000E-06   ,1000000.00000000
 SAMPLE ACCEPTANCE RATE (IACCEPT):          0.400000000000000
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
 SAMPLES FOR LOCAL SEARCH KERNEL (OSAMPLE_M2):           -1
 SAMPLES FOR LOCAL UNIVARIATE SEARCH KERNEL (OSAMPLE_M3):-1
 MASS/IMP./POST. MATRIX REFRESH SETTING (MASSREST):      0
 MASS MATRIX ACCUMULATION ITERATIONS (MADAPT):          100
 MASS MATRIX BLOCKING TYPE (NUTS_MASS):                 B
 MODEL PARAMETERS TRANSFORMED BY MASS MATRIX (NUTS_TRANSFORM=0)
 POWER TERM WEIGHTING FOR MASS MATRIX ACCUM. (KAPPA):   1.00000000000000
 NUTS SAMPLE ACCEPTANCE RATE (NUTS_DELTA):                   0.800000000000000
 NUTS GAMMA SETTING (NUTS_GAMMA):                            5.000000000000000E-02
 USER DEFINED PRIOR SETTING FOR THETAS: (TPU):        0.00000000000000
 WEIGHT FACTOR FOR STD PRIOR FOR SIGMAS (SVARF): -1.000000000000000+300
 NUTS WARMUP METHOD (NUTS_TEST):       0
 NUTS MAXIMAL DEPTH SEARCH (NUTS_MAXDEPTH):       10
 NUTS STAGE I WARMUP ITERATIONS (NUTS_INIT):       7.500000000000000E-02
 NUTS STAGE II BASE WARMUP ITERATIONS (NUTS_BASE): 20.0000000000000
 NUTS STAGE III FINAL ITERATIONS (NUTS_TERM): 5.000000000000000E-02
 INITIAL ITERATIONS FOR STEP NUTS SIZE ASSESSMENT (NUTS_STEPITER): 1
 INTERVAL ITERATIONS FOR STEP NUTS SIZE ASSESSMENT (NUTS_STEPINTER):0
 ETA PARAMETERIZATION (NUTS_EPARAM):0
 OMEGA PARAMETERIZATION (NUTS_OPARAM):1
 SIGMA PARAMETERIZATION (NUTS_SPARAM):1
 NUTS REGULARIZING METHOD (NUTS_REG): 0.00000000000000

 TOLERANCES FOR ESTIMATION/EVALUATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   4
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12
 TOLERANCES FOR COVARIANCE STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   4
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  12

 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI

 EM/BAYES SETUP:
 THETAS THAT ARE MU MODELED:
   1   2   3   4   5   6   7   8
 THETAS THAT ARE GIBBS SAMPLED:
   1   2   3   4   5   6   7   8
 THETAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 SIGMAS THAT ARE GIBBS SAMPLED:
   1   2
 SIGMAS THAT ARE METROPOLIS-HASTINGS SAMPLED:
 
 OMEGAS ARE GIBBS SAMPLED

 MONITORING OF SEARCH:

 Burn-in Mode
 iteration         -100 MCMCOBJ=   -6552.2240856054068     
 iteration          -99 MCMCOBJ=   -6552.2240857580218     
 iteration          -98 MCMCOBJ=   -6505.0666192081844     
 iteration          -97 MCMCOBJ=   -6515.0102220445797     
 iteration          -96 MCMCOBJ=   -6555.5180130225626     
 iteration          -95 MCMCOBJ=   -6572.5510012185578     
 iteration          -94 MCMCOBJ=   -6561.8070342006013     
 iteration          -93 MCMCOBJ=   -6632.5743878243611     
 iteration          -92 MCMCOBJ=   -6631.5277500167485     
 iteration          -91 MCMCOBJ=   -6643.2400574413195     
 iteration          -90 MCMCOBJ=   -6617.6832766388288     
 iteration          -89 MCMCOBJ=   -6648.9752001474353     
 iteration          -88 MCMCOBJ=   -6570.9230812282103     
 iteration          -87 MCMCOBJ=   -6579.9432290853429     
 iteration          -86 MCMCOBJ=   -6577.2622975501554     
 iteration          -85 MCMCOBJ=   -6554.6139799806760     
 iteration          -84 MCMCOBJ=   -6494.0247476381755     
 iteration          -83 MCMCOBJ=   -6554.0390052013909     
 iteration          -82 MCMCOBJ=   -6573.4481905869798     
 iteration          -81 MCMCOBJ=   -6639.5047216834710     
 iteration          -80 MCMCOBJ=   -6638.6734753035480     
 iteration          -79 MCMCOBJ=   -6652.0268138110714     
 iteration          -78 MCMCOBJ=   -6615.8801361397109     
 iteration          -77 MCMCOBJ=   -6581.0822740877920     
 iteration          -76 MCMCOBJ=   -6622.3972886790343     
 iteration          -75 MCMCOBJ=   -6587.3491054154729     
 iteration          -74 MCMCOBJ=   -6647.9068975052114     
 iteration          -73 MCMCOBJ=   -6647.9068973518179     
 iteration          -72 MCMCOBJ=   -6681.9441886909872     
 iteration          -71 MCMCOBJ=   -6632.5265809258963     
 iteration          -70 MCMCOBJ=   -6656.3002975029713     
 iteration          -69 MCMCOBJ=   -6654.5868372964851     
 iteration          -68 MCMCOBJ=   -6654.5867992558033     
 iteration          -67 MCMCOBJ=   -6690.0023262668365     
 iteration          -66 MCMCOBJ=   -6676.2298704496161     
 iteration          -65 MCMCOBJ=   -6636.4015569998664     
 iteration          -64 MCMCOBJ=   -6605.2035385915869     
 iteration          -63 MCMCOBJ=   -6681.8514925666741     
 iteration          -62 MCMCOBJ=   -6673.0404378913354     
 iteration          -61 MCMCOBJ=   -6675.2670345191809     
 iteration          -60 MCMCOBJ=   -6637.7488536701030     
 iteration          -59 MCMCOBJ=   -6591.6327207587847     
 iteration          -58 MCMCOBJ=   -6562.8845916299770     
 iteration          -57 MCMCOBJ=   -6553.3907794347842     
 iteration          -56 MCMCOBJ=   -6606.4402100728157     
 iteration          -55 MCMCOBJ=   -6591.2793090283658     
 iteration          -54 MCMCOBJ=   -6587.4392939454574     
 iteration          -53 MCMCOBJ=   -6589.1116514475116     
 iteration          -52 MCMCOBJ=   -6604.0068992922197     
 iteration          -51 MCMCOBJ=   -6626.5838186722085     
 iteration          -50 MCMCOBJ=   -6596.6534542984500     
 iteration          -49 MCMCOBJ=   -6588.2838367833629     
 iteration          -48 MCMCOBJ=   -6684.3061578704492     
 iteration          -47 MCMCOBJ=   -6655.9498808214130     
 iteration          -46 MCMCOBJ=   -6662.9234243218216     
 iteration          -45 MCMCOBJ=   -6650.8421884569252     
 iteration          -44 MCMCOBJ=   -6642.1598805313006     
 iteration          -43 MCMCOBJ=   -6630.0360719951859     
 iteration          -42 MCMCOBJ=   -6610.7359957425842     
 iteration          -41 MCMCOBJ=   -6618.8918515706937     
 iteration          -40 MCMCOBJ=   -6586.4421910108831     
 iteration          -39 MCMCOBJ=   -6610.2617908688371     
 iteration          -38 MCMCOBJ=   -6610.2617923949947     
 iteration          -37 MCMCOBJ=   -6649.8667148193554     
 iteration          -36 MCMCOBJ=   -6664.1682784434006     
 iteration          -35 MCMCOBJ=   -6607.2877644376713     
 iteration          -34 MCMCOBJ=   -6619.9087771115574     
 iteration          -33 MCMCOBJ=   -6643.4167755953340     
 iteration          -32 MCMCOBJ=   -6643.4167770320109     
 iteration          -31 MCMCOBJ=   -6626.5228293045693     
 iteration          -30 MCMCOBJ=   -6686.4122039258309     
 iteration          -29 MCMCOBJ=   -6603.6926011142796     
 iteration          -28 MCMCOBJ=   -6632.9302085798408     
 iteration          -27 MCMCOBJ=   -6670.9009844160501     
 iteration          -26 MCMCOBJ=   -6662.5624841216440     
 iteration          -25 MCMCOBJ=   -6651.8360327668997     
 iteration          -24 MCMCOBJ=   -6559.8429328592429     
 iteration          -23 MCMCOBJ=   -6576.3919481348803     
 iteration          -22 MCMCOBJ=   -6656.0131588295280     
 iteration          -21 MCMCOBJ=   -6655.6028087706045     
 iteration          -20 MCMCOBJ=   -6662.5976195111507     
 iteration          -19 MCMCOBJ=   -6630.3820866342876     
 iteration          -18 MCMCOBJ=   -6640.9518952322478     
 iteration          -17 MCMCOBJ=   -6687.9084930316412     
 iteration          -16 MCMCOBJ=   -6693.5176553104429     
 iteration          -15 MCMCOBJ=   -6650.1583669079309     
 iteration          -14 MCMCOBJ=   -6661.6130540730628     
 iteration          -13 MCMCOBJ=   -6643.3758174226768     
 iteration          -12 MCMCOBJ=   -6640.6236263247592     
 iteration          -11 MCMCOBJ=   -6601.0097105050663     
 iteration          -10 MCMCOBJ=   -6662.4009876843611     
 iteration           -9 MCMCOBJ=   -6649.5162566037789     
 iteration           -8 MCMCOBJ=   -6624.2039536634811     
 iteration           -7 MCMCOBJ=   -6637.8327516452155     
 iteration           -6 MCMCOBJ=   -6622.3242952963046     
 iteration           -5 MCMCOBJ=   -6575.7963745037359     
 iteration           -4 MCMCOBJ=   -6611.0002701304984     
 iteration           -3 MCMCOBJ=   -6602.5900720058462     
 iteration           -2 MCMCOBJ=   -6604.1972406242076     
 iteration           -1 MCMCOBJ=   -6588.2899764103104     
 Sampling Mode
 iteration            0 MCMCOBJ=   -6677.5007123177675     
 iteration            1 MCMCOBJ=   -6637.7358124972570     
 iteration            2 MCMCOBJ=   -6641.9608032571468     
 iteration            3 MCMCOBJ=   -6645.9246939742461     
 iteration            4 MCMCOBJ=   -6632.9031333143039     
 iteration            5 MCMCOBJ=   -6631.0650362361648     
 iteration            6 MCMCOBJ=   -6608.3054947466571     
 iteration            7 MCMCOBJ=   -6607.4493441778550     
 iteration            8 MCMCOBJ=   -6648.3716322993096     
 iteration            9 MCMCOBJ=   -6691.5336104590979     
 iteration           10 MCMCOBJ=   -6647.3756074088442     
 iteration           11 MCMCOBJ=   -6617.8736672743880     
 iteration           12 MCMCOBJ=   -6574.4551245479352     
 iteration           13 MCMCOBJ=   -6593.3057175451650     
 iteration           14 MCMCOBJ=   -6573.2363252345358     
 iteration           15 MCMCOBJ=   -6608.0786454419558     
 iteration           16 MCMCOBJ=   -6609.2880888196978     
 iteration           17 MCMCOBJ=   -6581.1266375339010     
 iteration           18 MCMCOBJ=   -6592.3382557480409     
 iteration           19 MCMCOBJ=   -6592.3382474544051     
 iteration           20 MCMCOBJ=   -6626.8870416776908     
 iteration           21 MCMCOBJ=   -6640.5141713647745     
 iteration           22 MCMCOBJ=   -6605.4442857678532     
 iteration           23 MCMCOBJ=   -6609.1640890010058     
 iteration           24 MCMCOBJ=   -6637.1888335160747     
 iteration           25 MCMCOBJ=   -6685.9632595130952     
 iteration           26 MCMCOBJ=   -6649.8605049389935     
 iteration           27 MCMCOBJ=   -6627.0080279057793     
 iteration           28 MCMCOBJ=   -6611.4205322616708     
 iteration           29 MCMCOBJ=   -6602.0716272189693     
 iteration           30 MCMCOBJ=   -6647.9972616656032     
 iteration           31 MCMCOBJ=   -6644.6898916778619     
 iteration           32 MCMCOBJ=   -6662.3184188627201     
 iteration           33 MCMCOBJ=   -6704.1413623987773     
 iteration           34 MCMCOBJ=   -6698.0572924967864     
 iteration           35 MCMCOBJ=   -6656.2076907818237     
 iteration           36 MCMCOBJ=   -6601.1222451548574     
 iteration           37 MCMCOBJ=   -6611.1485073931981     
 iteration           38 MCMCOBJ=   -6584.6345709637799     
 iteration           39 MCMCOBJ=   -6643.0226223681302     
 iteration           40 MCMCOBJ=   -6633.5025204897602     
 iteration           41 MCMCOBJ=   -6637.7094289774914     
 iteration           42 MCMCOBJ=   -6639.3213193085658     
 iteration           43 MCMCOBJ=   -6663.2307866528008     
 iteration           44 MCMCOBJ=   -6673.5788951721424     
 iteration           45 MCMCOBJ=   -6648.5418774994632     
 iteration           46 MCMCOBJ=   -6632.3895745135169     
 iteration           47 MCMCOBJ=   -6628.9281251462262     
 iteration           48 MCMCOBJ=   -6562.5145740122571     
 iteration           49 MCMCOBJ=   -6585.2004390758802     
 iteration           50 MCMCOBJ=   -6574.7904801510495     
 iteration           51 MCMCOBJ=   -6590.3419359717627     
 iteration           52 MCMCOBJ=   -6571.2486729166740     
 iteration           53 MCMCOBJ=   -6608.4745585512464     
 iteration           54 MCMCOBJ=   -6633.1198117223312     
 iteration           55 MCMCOBJ=   -6659.1831332436086     
 iteration           56 MCMCOBJ=   -6675.5687461593643     
 iteration           57 MCMCOBJ=   -6675.5687456395372     
 iteration           58 MCMCOBJ=   -6684.4513178583602     
 iteration           59 MCMCOBJ=   -6657.8921935394146     
 iteration           60 MCMCOBJ=   -6640.8208966668135     
 iteration           61 MCMCOBJ=   -6662.0565120468709     
 iteration           62 MCMCOBJ=   -6594.7270950241145     
 iteration           63 MCMCOBJ=   -6565.1172720613567     
 iteration           64 MCMCOBJ=   -6538.2399979200154     
 iteration           65 MCMCOBJ=   -6542.2081580631129     
 iteration           66 MCMCOBJ=   -6629.7359743173474     
 iteration           67 MCMCOBJ=   -6626.8085719112605     
 iteration           68 MCMCOBJ=   -6624.4319987903882     
 iteration           69 MCMCOBJ=   -6609.9349815918304     
 iteration           70 MCMCOBJ=   -6607.0067418881481     
 iteration           71 MCMCOBJ=   -6637.5833571135245     
 iteration           72 MCMCOBJ=   -6593.5559178667618     
 iteration           73 MCMCOBJ=   -6634.5074833966182     
 iteration           74 MCMCOBJ=   -6626.9639756356564     
 iteration           75 MCMCOBJ=   -6667.2082648356363     
 iteration           76 MCMCOBJ=   -6657.6910228191018     
 iteration           77 MCMCOBJ=   -6597.8648942585287     
 iteration           78 MCMCOBJ=   -6662.5103151906669     
 iteration           79 MCMCOBJ=   -6637.3953960313092     
 iteration           80 MCMCOBJ=   -6642.5049229401375     
 iteration           81 MCMCOBJ=   -6620.5886421282103     
 iteration           82 MCMCOBJ=   -6653.1367144525948     
 iteration           83 MCMCOBJ=   -6656.3739060331300     
 iteration           84 MCMCOBJ=   -6658.8789106498934     
 iteration           85 MCMCOBJ=   -6668.2149598771439     
 iteration           86 MCMCOBJ=   -6617.3010619345259     
 iteration           87 MCMCOBJ=   -6631.7367800398788     
 iteration           88 MCMCOBJ=   -6633.7818844117928     
 iteration           89 MCMCOBJ=   -6639.7245289520470     
 iteration           90 MCMCOBJ=   -6562.7269427573610     
 iteration           91 MCMCOBJ=   -6549.3402661537748     
 iteration           92 MCMCOBJ=   -6609.8041946785370     
 iteration           93 MCMCOBJ=   -6676.6869416648497     
 iteration           94 MCMCOBJ=   -6668.1575870163097     
 iteration           95 MCMCOBJ=   -6606.0938110350417     
 iteration           96 MCMCOBJ=   -6632.1427442975928     
 iteration           97 MCMCOBJ=   -6669.8145079852384     
 iteration           98 MCMCOBJ=   -6642.0252060117064     
 iteration           99 MCMCOBJ=   -6618.2089294411689     
 iteration          100 MCMCOBJ=   -6624.0244585088221     
 iteration          101 MCMCOBJ=   -6613.3632277834949     
 iteration          102 MCMCOBJ=   -6542.0356106429908     
 iteration          103 MCMCOBJ=   -6563.5007583532451     
 iteration          104 MCMCOBJ=   -6609.1456338110684     
 iteration          105 MCMCOBJ=   -6632.3925014204833     
 iteration          106 MCMCOBJ=   -6632.3925014952856     
 iteration          107 MCMCOBJ=   -6636.6167618378840     
 iteration          108 MCMCOBJ=   -6636.9831132006157     
 iteration          109 MCMCOBJ=   -6678.2337094396844     
 iteration          110 MCMCOBJ=   -6676.6314076089138     
 iteration          111 MCMCOBJ=   -6652.2542566968032     
 iteration          112 MCMCOBJ=   -6657.4743320093794     
 iteration          113 MCMCOBJ=   -6589.3602649141631     
 iteration          114 MCMCOBJ=   -6549.9770475056439     
 iteration          115 MCMCOBJ=   -6544.5388608334542     
 iteration          116 MCMCOBJ=   -6613.0001026768232     
 iteration          117 MCMCOBJ=   -6639.8213421813834     
 iteration          118 MCMCOBJ=   -6609.9065572255486     
 iteration          119 MCMCOBJ=   -6617.0834836476697     
 iteration          120 MCMCOBJ=   -6589.2106501219987     
 iteration          121 MCMCOBJ=   -6611.5460636899434     
 iteration          122 MCMCOBJ=   -6667.6091344490724     
 iteration          123 MCMCOBJ=   -6667.6091337889602     
 iteration          124 MCMCOBJ=   -6632.8063311379856     
 iteration          125 MCMCOBJ=   -6629.2327655159006     
 iteration          126 MCMCOBJ=   -6615.7705279414431     
 iteration          127 MCMCOBJ=   -6598.9566360865638     
 iteration          128 MCMCOBJ=   -6613.2648050230191     
 iteration          129 MCMCOBJ=   -6601.6699055851750     
 iteration          130 MCMCOBJ=   -6565.1432757136881     
 iteration          131 MCMCOBJ=   -6571.7818127477221     
 iteration          132 MCMCOBJ=   -6599.2876482621923     
 iteration          133 MCMCOBJ=   -6616.8090531718499     
 iteration          134 MCMCOBJ=   -6645.8758844893009     
 iteration          135 MCMCOBJ=   -6618.0412702094036     
 iteration          136 MCMCOBJ=   -6588.5129724066719     
 iteration          137 MCMCOBJ=   -6531.6310759940834     
 iteration          138 MCMCOBJ=   -6558.3659408554659     
 iteration          139 MCMCOBJ=   -6566.7013538022957     
 iteration          140 MCMCOBJ=   -6554.7937695131341     
 iteration          141 MCMCOBJ=   -6567.0433589268978     
 iteration          142 MCMCOBJ=   -6624.6349276745668     
 iteration          143 MCMCOBJ=   -6591.6399133585955     
 iteration          144 MCMCOBJ=   -6656.7133703362497     
 iteration          145 MCMCOBJ=   -6659.9364269531516     
 iteration          146 MCMCOBJ=   -6600.1484942898078     
 iteration          147 MCMCOBJ=   -6626.2439492814101     
 iteration          148 MCMCOBJ=   -6657.0638867471835     
 iteration          149 MCMCOBJ=   -6648.6959897739061     
 iteration          150 MCMCOBJ=   -6653.1003852769099     
 iteration          151 MCMCOBJ=   -6623.7237032183893     
 iteration          152 MCMCOBJ=   -6620.4970016203843     
 iteration          153 MCMCOBJ=   -6617.2266905418692     
 iteration          154 MCMCOBJ=   -6650.7242786437982     
 iteration          155 MCMCOBJ=   -6608.6457644901211     
 iteration          156 MCMCOBJ=   -6615.3842971145441     
 iteration          157 MCMCOBJ=   -6611.6149870697691     
 iteration          158 MCMCOBJ=   -6590.1823817393815     
 iteration          159 MCMCOBJ=   -6595.2500991031939     
 iteration          160 MCMCOBJ=   -6657.0973565409668     
 iteration          161 MCMCOBJ=   -6672.2507930092943     
 iteration          162 MCMCOBJ=   -6614.1962357969933     
 iteration          163 MCMCOBJ=   -6602.4010295392236     
 iteration          164 MCMCOBJ=   -6603.2571180763280     
 iteration          165 MCMCOBJ=   -6591.3010280198987     
 iteration          166 MCMCOBJ=   -6587.0794111013529     
 iteration          167 MCMCOBJ=   -6551.5212882604219     
 iteration          168 MCMCOBJ=   -6545.0255192409586     
 iteration          169 MCMCOBJ=   -6545.0255159185353     
 iteration          170 MCMCOBJ=   -6533.1767802610484     
 iteration          171 MCMCOBJ=   -6600.2147738264648     
 iteration          172 MCMCOBJ=   -6600.2147739834745     
 iteration          173 MCMCOBJ=   -6648.8447049152664     
 iteration          174 MCMCOBJ=   -6625.4996407870840     
 iteration          175 MCMCOBJ=   -6613.5974014751446     
 iteration          176 MCMCOBJ=   -6639.2379194535670     
 iteration          177 MCMCOBJ=   -6626.8152338168375     
 iteration          178 MCMCOBJ=   -6666.0840807770046     
 iteration          179 MCMCOBJ=   -6657.4183316240787     
 iteration          180 MCMCOBJ=   -6664.7404612234759     
 iteration          181 MCMCOBJ=   -6655.9652651460956     
 iteration          182 MCMCOBJ=   -6647.9708292226569     
 iteration          183 MCMCOBJ=   -6666.4628614051098     
 iteration          184 MCMCOBJ=   -6670.8107191256386     
 iteration          185 MCMCOBJ=   -6669.9266859668905     
 iteration          186 MCMCOBJ=   -6664.0515096495474     
 iteration          187 MCMCOBJ=   -6650.4105796163158     
 iteration          188 MCMCOBJ=   -6632.4672016901141     
 iteration          189 MCMCOBJ=   -6550.9987249441619     
 iteration          190 MCMCOBJ=   -6629.8547924048380     
 iteration          191 MCMCOBJ=   -6634.9494755907317     
 iteration          192 MCMCOBJ=   -6629.4879664465716     
 iteration          193 MCMCOBJ=   -6630.5930203281287     
 iteration          194 MCMCOBJ=   -6560.3979748179136     
 iteration          195 MCMCOBJ=   -6665.0294379365887     
 iteration          196 MCMCOBJ=   -6650.4625173472596     
 iteration          197 MCMCOBJ=   -6612.5669738250017     
 iteration          198 MCMCOBJ=   -6621.2451652455102     
 iteration          199 MCMCOBJ=   -6640.3360453827872     
 iteration          200 MCMCOBJ=   -6639.3398271770375     

 #TERM:
 BURN-IN WAS NOT TESTED FOR CONVERGENCE
 STATISTICAL PORTION WAS COMPLETED

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.

 ETABAR:         9.0231E-03  4.5783E-03 -4.9293E-03  2.6726E-03  7.1382E-03  1.2317E-03  1.1003E-03  4.8048E-04
 SE:             6.9319E-02  5.4105E-02  4.0150E-02  6.6966E-02  5.5231E-02  5.8557E-02  6.4203E-02  5.9216E-02
 N:                      50          50          50          50          50          50          50          50

 P VAL.:         8.9643E-01  9.3256E-01  9.0229E-01  9.6817E-01  8.9716E-01  9.8322E-01  9.8633E-01  9.9353E-01

 ETASHRINKSD(%)  8.6567E+00  2.0638E+01  2.5019E+01  9.2978E+00  1.1707E+01  1.5877E+01  9.3344E+00  1.0948E+01
 ETASHRINKVR(%)  1.6564E+01  3.7016E+01  4.3779E+01  1.7731E+01  2.2044E+01  2.9233E+01  1.7797E+01  2.0697E+01
 EBVSHRINKSD(%)  7.0327E-01  9.3925E+00  9.0017E+00  2.2495E+00  1.9021E+00  7.4163E+00  6.1106E-01  1.9156E+00
 EBVSHRINKVR(%)  1.4016E+00  1.7903E+01  1.7193E+01  4.4484E+00  3.7679E+00  1.4283E+01  1.2184E+00  3.7944E+00
 RELATIVEINF(%)  9.7668E+01  6.9028E+01  7.8295E+01  9.3511E+01  9.0276E+01  7.6331E+01  1.0000E+02  9.0773E+01
 EPSSHRINKSD(%)  1.6764E+01  8.0601E+00
 EPSSHRINKVR(%)  3.0718E+01  1.5471E+01

  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):         1568
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    2881.7912401298536     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -6622.6883136969445     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -3740.8970735670910     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                           400
 NIND*NETA*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    735.15082656373818     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -6622.6883136969445     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -5887.5374871332060     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 PRIOR CONSTANT TO OBJECTIVE FUNCTION:    55.177915743687578     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -6622.6883136969445     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -6567.5103979532569     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 #TERE:
 Elapsed estimation  time in seconds:  1204.94
 Elapsed covariance  time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 #OBJT:**************                       AVERAGE VALUE OF LIKELIHOOD FUNCTION                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************    -6622.688       **************************************************
 #OBJS:********************************************       36.522 (STD) **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8     
 
         3.88E+00 -2.22E+00  5.93E-01 -1.70E-01  2.31E+00  2.75E-01  3.66E+00 -7.27E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        2.88E-01
 
 ETA2
+       -3.84E-02  2.32E-01
 
 ETA3
+        4.61E-02 -1.01E-02  1.43E-01
 
 ETA4
+        2.78E-02  6.17E-02  5.30E-04  2.73E-01
 
 ETA5
+        3.44E-02  1.84E-02 -5.93E-03 -3.00E-02  1.96E-01
 
 ETA6
+       -2.62E-02  4.89E-03  1.54E-02  9.42E-03 -7.45E-02  2.42E-01
 
 ETA7
+        3.19E-02 -6.08E-02  2.64E-02 -8.30E-02  2.96E-02  6.82E-03  2.51E-01
 
 ETA8
+        9.33E-02  7.05E-02  4.35E-02  4.65E-02  1.32E-02 -4.67E-02  4.74E-02  2.21E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        9.46E-03
 
 EPS2
+        0.00E+00  2.25E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        5.33E-01
 
 ETA2
+       -1.41E-01  4.78E-01
 
 ETA3
+        2.24E-01 -5.29E-02  3.75E-01
 
 ETA4
+        9.68E-02  2.44E-01 -3.82E-04  5.19E-01
 
 ETA5
+        1.48E-01  8.87E-02 -3.37E-02 -1.29E-01  4.40E-01
 
 ETA6
+       -1.02E-01  1.92E-02  8.41E-02  3.94E-02 -3.45E-01  4.89E-01
 
 ETA7
+        1.14E-01 -2.44E-01  1.36E-01 -3.15E-01  1.33E-01  2.32E-02  4.98E-01
 
 ETA8
+        3.63E-01  3.12E-01  2.39E-01  1.84E-01  6.67E-02 -2.06E-01  1.98E-01  4.67E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        9.72E-02
 
 EPS2
+        0.00E+00  1.50E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************                STANDARD ERROR OF ESTIMATE (From Sample Variance)               ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8     
 
         7.27E-02  7.64E-02  5.22E-02  6.94E-02  6.79E-02  7.46E-02  7.15E-02  7.06E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        7.06E-02
 
 ETA2
+        4.56E-02  6.28E-02
 
 ETA3
+        3.30E-02  3.25E-02  3.88E-02
 
 ETA4
+        4.38E-02  3.70E-02  3.54E-02  6.47E-02
 
 ETA5
+        3.68E-02  3.39E-02  2.53E-02  3.55E-02  3.89E-02
 
 ETA6
+        4.27E-02  4.00E-02  3.14E-02  3.86E-02  3.03E-02  5.56E-02
 
 ETA7
+        4.11E-02  4.48E-02  2.80E-02  4.05E-02  3.13E-02  3.64E-02  5.17E-02
 
 ETA8
+        4.30E-02  3.81E-02  2.89E-02  4.18E-02  2.91E-02  3.24E-02  3.48E-02  5.01E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1      EPS2     
 
 EPS1
+        7.08E-04
 
 EPS2
+        0.00E+00  1.09E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        6.24E-02
 
 ETA2
+        1.52E-01  6.37E-02
 
 ETA3
+        1.43E-01  1.73E-01  4.98E-02
 
 ETA4
+        1.50E-01  1.29E-01  1.67E-01  6.05E-02
 
 ETA5
+        1.48E-01  1.55E-01  1.46E-01  1.43E-01  4.31E-02
 
 ETA6
+        1.55E-01  1.62E-01  1.67E-01  1.45E-01  1.25E-01  5.48E-02
 
 ETA7
+        1.42E-01  1.59E-01  1.36E-01  1.31E-01  1.37E-01  1.41E-01  5.03E-02
 
 ETA8
+        1.20E-01  1.38E-01  1.43E-01  1.42E-01  1.36E-01  1.30E-01  1.31E-01  5.16E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1      EPS2     
 
 EPS1
+        3.63E-03
 
 EPS2
+        0.00E+00  3.61E-03
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************               COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 TH 1
+        5.28E-03
 
 TH 2
+       -7.04E-04  5.84E-03
 
 TH 3
+        1.34E-03 -4.25E-05  2.72E-03
 
 TH 4
+       -3.56E-05  1.34E-04 -3.97E-04  4.81E-03
 
 TH 5
+        8.86E-04  4.51E-04  1.47E-04  1.17E-05  4.61E-03
 
 TH 6
+        1.30E-04 -4.56E-04  1.53E-04 -1.50E-04 -1.53E-03  5.57E-03
 
 TH 7
+        6.20E-04 -1.38E-03  1.09E-03 -1.46E-03  6.16E-04  2.76E-04  5.11E-03
 
 TH 8
+        1.37E-03  1.33E-03  9.59E-04  7.80E-04  9.76E-04 -9.45E-04  1.53E-03  4.98E-03
 
 OM11
+       -4.28E-04 -5.87E-04 -1.89E-06  1.41E-04 -7.92E-04  5.96E-04 -8.87E-05 -1.35E-05  4.98E-03
 
 OM12
+       -4.12E-04  1.34E-04 -7.65E-05 -2.00E-04 -3.41E-04  2.14E-04  3.83E-05 -4.98E-04 -1.34E-03  2.08E-03
 
 OM13
+        1.87E-04 -8.92E-06 -1.16E-04  1.42E-04  1.38E-04  2.92E-04 -3.34E-04 -1.79E-04  7.14E-04 -2.30E-04  1.09E-03
 
 OM14
+       -1.52E-04 -6.54E-04  2.01E-04  1.19E-04 -3.18E-04  5.21E-04  1.01E-04 -7.27E-05  9.28E-04  2.82E-04  2.07E-04  1.92E-03
 
 OM15
+       -5.21E-05 -7.79E-05  5.67E-05  4.14E-05 -1.89E-04  1.67E-04 -4.15E-06  7.76E-05  5.88E-05  1.39E-04 -9.82E-05 -1.21E-04
          1.36E-03
 
 OM16
+        1.85E-04 -3.19E-05 -2.66E-04  1.36E-04  2.77E-04 -5.94E-04 -2.86E-04 -1.22E-04  6.45E-06 -1.94E-04  1.89E-04 -1.15E-04
         -6.73E-04  1.83E-03
 
 OM17
+       -3.89E-04  5.47E-05 -3.66E-04 -2.26E-04  1.94E-04 -2.94E-04 -5.12E-04 -4.44E-04  5.06E-04 -4.60E-04  3.39E-04 -5.02E-04
          2.02E-04  1.85E-04  1.69E-03
 
 OM18
+       -4.01E-04 -2.51E-04 -1.31E-04  6.88E-05 -5.94E-04  5.03E-04 -1.77E-04 -3.00E-04  2.00E-03 -7.81E-05  4.16E-04  5.57E-04
          1.36E-04 -3.23E-04  5.66E-04  1.85E-03
 
 OM22
+        2.73E-05 -3.67E-04 -1.21E-04  8.08E-05 -4.00E-04 -6.79E-05 -5.23E-04  8.71E-04  7.72E-04 -1.09E-03 -9.28E-05 -1.78E-04
         -2.06E-04  1.59E-04  1.85E-04  1.96E-04  3.94E-03
 
 OM23
+       -3.30E-04  3.48E-04  2.59E-04 -1.86E-04  1.19E-04 -3.52E-04 -9.61E-05 -1.52E-04 -2.21E-04  1.57E-04 -2.99E-04  2.97E-05
          2.19E-04 -2.24E-04  8.85E-05 -5.91E-06 -1.11E-04  1.06E-03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM24
+       -1.15E-04 -2.34E-04 -7.51E-05  1.55E-05 -1.57E-04 -3.53E-05 -1.47E-04  2.97E-04  3.20E-04 -1.60E-05  7.49E-05 -2.54E-04
         -1.99E-05 -1.15E-04  1.71E-04  3.35E-04  9.64E-04 -1.22E-04  1.37E-03
 
 OM25
+        7.93E-05 -8.80E-06  1.32E-04  2.08E-04 -1.21E-05  4.20E-06 -4.15E-05  6.21E-05 -2.21E-04  1.98E-04  3.92E-05  1.36E-04
         -2.91E-04  1.95E-04 -1.14E-04 -9.67E-05  1.65E-04 -1.84E-04 -9.60E-05  1.15E-03
 
 OM26
+       -3.52E-04  6.42E-04 -1.59E-04  2.91E-04 -1.19E-04  3.13E-04 -2.90E-04  2.05E-04  1.92E-04 -3.19E-05 -2.81E-05  4.93E-05
          2.06E-04 -3.94E-04 -3.73E-05  1.84E-04  3.75E-04  3.20E-04  5.77E-05 -4.54E-04  1.60E-03
 
 OM27
+       -6.04E-04  6.08E-04 -1.02E-04 -2.80E-04  3.66E-04 -3.69E-04 -7.53E-05 -5.83E-04 -3.61E-04  5.76E-04 -8.86E-05  3.26E-04
         -4.61E-05 -6.12E-05 -4.08E-04 -1.37E-04 -1.02E-03  3.51E-04 -8.00E-04  8.52E-05  3.32E-04  2.01E-03
 
 OM28
+       -5.87E-04  4.90E-05 -8.04E-05 -3.20E-04 -1.78E-04 -2.31E-04 -1.60E-04 -1.52E-04 -1.02E-04  5.18E-04 -4.63E-05  1.18E-04
         -2.60E-05  1.33E-04 -2.12E-04 -1.47E-05  5.76E-04  1.68E-04  3.26E-04  2.08E-04 -1.59E-04  4.74E-04  1.45E-03
 
 OM33
+        3.73E-04  2.76E-04 -1.64E-04 -1.10E-04 -8.86E-05  6.89E-04  1.10E-04 -1.70E-04 -1.19E-04  1.22E-04  5.09E-04  1.03E-04
         -4.64E-05 -4.39E-06  8.93E-05  1.32E-04 -3.54E-04 -2.18E-04 -1.64E-04  5.53E-05 -3.40E-06  3.05E-05 -1.97E-04  1.51E-03
 
 OM34
+       -1.68E-04  3.86E-04  2.58E-04  1.35E-04  2.04E-04 -1.49E-04  7.64E-06  3.19E-04  4.46E-04  4.62E-06  2.81E-04  5.07E-04
         -1.64E-05  7.72E-05 -1.13E-05  2.44E-04 -1.20E-06  2.43E-04 -5.61E-05 -9.56E-05  1.96E-04  2.85E-04  1.21E-04 -4.33E-05
         1.25E-03
 
 OM35
+       -1.38E-04 -1.19E-04 -9.68E-05  1.33E-04  1.72E-04 -8.75E-06  1.87E-05 -2.41E-04 -2.18E-04  4.47E-05  1.08E-04 -2.21E-05
          1.57E-04 -1.43E-04  7.26E-05 -1.41E-05 -2.29E-04  1.92E-04  2.36E-05  1.70E-05  1.90E-05  8.43E-05  5.72E-05 -1.50E-04
        -1.00E-04  6.40E-04
 
 OM36
+        2.74E-04  2.10E-04 -8.52E-05  1.59E-05  2.23E-04 -2.23E-04 -1.08E-04  1.72E-04  1.35E-04 -8.10E-05 -2.67E-05 -1.08E-04
         -1.88E-04  4.09E-04 -4.10E-05 -4.66E-05  7.02E-06 -1.36E-04 -1.22E-05  6.34E-05 -1.59E-04 -8.91E-05 -2.63E-05  3.15E-05
        -1.52E-05 -2.99E-04  9.83E-04
 
 OM37
+        3.41E-04 -3.31E-04 -3.30E-06 -3.15E-04  4.20E-06  2.09E-04  2.45E-04 -1.09E-04  1.48E-04 -4.16E-05  1.20E-04 -9.61E-05
         -8.50E-05  1.33E-04  1.12E-04  1.18E-04  9.95E-05 -3.14E-04  1.39E-04  6.48E-05 -2.00E-04 -2.40E-04  5.39E-05  2.56E-04
        -3.02E-04 -5.71E-05  2.11E-04  7.85E-04
 
 OM38
+        2.13E-05 -3.16E-05  1.05E-04 -2.14E-04 -2.44E-04  5.22E-04  2.27E-04 -1.22E-04  2.65E-04  1.73E-04  3.65E-04  3.19E-04
          1.33E-05 -1.04E-04  1.02E-04  4.25E-04 -9.90E-05  1.82E-04  6.68E-05  2.27E-05  2.70E-05  4.03E-05  1.65E-04  4.44E-04
         1.76E-04  1.01E-04 -2.59E-04  2.32E-04  8.36E-04
 
 OM44
+        3.75E-04  4.39E-04  4.05E-04  3.46E-04  4.72E-04 -7.70E-05 -2.32E-04  5.53E-04  1.27E-03 -9.82E-05  3.58E-04  2.65E-04
          6.73E-05  4.57E-05  3.26E-04  5.66E-04  3.84E-04  6.63E-05  7.67E-04  4.91E-05 -1.06E-04 -5.76E-04  1.02E-04  1.66E-04
         5.11E-04 -1.67E-04  1.37E-04  1.21E-04  1.85E-04  4.18E-03
 
 OM45
+        1.57E-04 -2.00E-04  1.69E-04 -2.54E-04 -8.15E-06  1.26E-04  1.06E-04  2.33E-04  3.76E-04 -1.87E-04  2.93E-05  2.43E-04
          3.56E-05  1.82E-04 -1.51E-05  1.71E-04  1.89E-04 -3.28E-05  8.10E-06  2.58E-04 -1.23E-04 -1.75E-04  8.71E-05 -8.90E-05
        -2.31E-06  7.30E-06  4.23E-05  1.48E-04  9.12E-05 -3.47E-04  1.26E-03
 
 OM46
+       -2.71E-04  3.27E-04 -1.37E-04 -2.20E-04  2.93E-04  1.35E-04  3.64E-04  2.16E-04  9.30E-05  9.01E-05  2.93E-05 -7.75E-05
         -1.69E-04  1.19E-05 -3.08E-05  1.92E-04 -1.72E-04  6.95E-05 -5.17E-05 -6.55E-05  4.67E-04  3.35E-04  1.46E-04  1.18E-04
         6.86E-05  5.27E-05  1.01E-06 -4.58E-06  4.23E-05 -1.11E-04 -2.25E-04  1.49E-03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM47
+       -2.50E-04  9.50E-05 -1.94E-06 -1.94E-04 -1.36E-04  1.40E-04  1.77E-05 -1.06E-04  1.80E-04  7.25E-05 -8.94E-05  4.73E-04
          2.10E-04 -7.04E-05 -2.75E-05  1.97E-04 -3.46E-04  1.78E-04 -5.31E-04 -1.67E-04  3.18E-04  8.80E-04  2.25E-04 -5.82E-05
         2.56E-04  3.90E-05 -9.36E-05 -6.07E-05  9.78E-05 -1.07E-03  2.70E-04  1.22E-04  1.64E-03
 
 OM48
+       -4.62E-05 -1.44E-04  1.86E-04 -5.43E-05 -4.82E-04  2.03E-04  2.85E-05  1.19E-04  9.70E-04  4.62E-05  3.09E-04  7.64E-04
          4.42E-05 -1.32E-04  2.04E-04  7.26E-04  3.55E-04  9.96E-05  4.83E-04 -1.40E-04  1.53E-04 -1.37E-04  5.11E-04  1.32E-04
         5.80E-04 -6.11E-05 -1.15E-04  3.15E-05  4.20E-04  1.00E-03  9.56E-05 -1.75E-05  2.66E-04  1.75E-03
 
 OM55
+       -4.58E-04  6.66E-04 -1.08E-04  2.73E-04 -4.58E-04  3.12E-04 -1.98E-04 -2.62E-04  4.96E-05 -1.51E-04 -9.29E-05  2.44E-05
          4.70E-05 -4.42E-05  3.47E-05 -4.40E-05 -1.52E-05  4.20E-05  9.60E-06 -6.82E-05  1.85E-04 -7.33E-05 -2.62E-04  1.84E-04
         4.98E-05 -8.63E-05  7.12E-05 -5.95E-05 -2.99E-05  1.17E-04 -2.39E-04  8.17E-05 -1.96E-04 -4.43E-05  1.51E-03
 
 OM56
+        1.97E-04 -2.76E-04  1.43E-04  2.98E-04  4.89E-05 -2.07E-04  1.78E-04  3.47E-04 -1.17E-04  4.96E-05  2.92E-05  2.20E-04
         -4.21E-05  4.09E-05 -1.73E-04 -1.97E-05  1.70E-04 -1.17E-04  8.16E-05  1.23E-04  1.05E-04 -1.76E-04 -4.17E-05  1.06E-05
        -3.63E-05  8.56E-05 -7.77E-05 -7.33E-05 -5.78E-06  3.56E-05  1.67E-04 -1.39E-04 -1.10E-04  2.69E-05 -2.78E-04  9.17E-04
 
 OM57
+       -6.16E-05 -1.28E-04 -1.64E-04  2.99E-04  1.05E-04 -3.24E-04 -1.56E-04 -1.03E-04  3.27E-05 -1.76E-04  3.82E-05 -1.14E-04
          1.42E-04 -1.37E-04  2.74E-04  3.91E-05  9.22E-05 -1.38E-05  9.74E-05 -3.27E-04  1.96E-04 -1.83E-04 -1.96E-04 -6.68E-05
        -2.17E-05  1.14E-04 -7.08E-05 -7.24E-05 -1.17E-04 -8.08E-05 -3.28E-04 -3.66E-05 -1.77E-04  3.48E-05  1.36E-04  8.90E-05
          9.82E-04
 
 OM58
+        3.51E-05  9.58E-05 -6.53E-05  4.11E-05 -4.19E-05 -4.78E-05 -6.19E-05  1.31E-04 -2.29E-04  7.84E-05 -2.88E-05 -1.20E-04
          3.77E-04 -9.78E-05  1.22E-04  4.89E-05  7.73E-05  1.01E-04 -6.26E-05  2.48E-04 -7.75E-05 -1.64E-05  3.24E-05 -1.60E-05
        -1.45E-04  1.77E-04 -7.26E-05 -8.02E-05 -4.57E-05 -1.46E-04  7.54E-05 -1.04E-04  2.10E-05 -1.34E-04 -1.54E-04 -3.39E-05
          1.78E-04  8.48E-04
 
 OM66
+       -3.44E-04 -2.56E-04 -7.39E-04 -1.89E-04  3.31E-04 -1.82E-04  2.24E-04  4.83E-05  2.37E-04 -1.83E-04 -4.64E-05 -3.03E-04
          1.36E-04 -1.15E-04  3.17E-04  1.63E-04  1.99E-04 -1.73E-04  1.00E-04 -2.51E-04 -1.90E-05 -1.60E-04 -2.93E-05 -3.33E-04
        -4.85E-05  1.81E-06  1.13E-04  5.89E-05 -1.95E-04  8.03E-05 -3.44E-05 -1.27E-04  8.15E-05 -8.94E-05 -4.18E-04 -4.94E-04
          1.14E-04  4.29E-05  3.10E-03
 
 OM67
+        5.90E-04  1.82E-04 -2.12E-05  1.10E-05  8.73E-05 -2.04E-04 -5.78E-05  3.97E-04  6.82E-05 -7.10E-06  8.14E-05 -1.07E-04
         -1.35E-04  3.16E-04 -8.02E-05 -4.73E-05  1.03E-04 -2.19E-04  1.50E-04  2.18E-04 -4.93E-04 -3.26E-04  1.47E-05 -3.57E-05
        -3.68E-05 -1.60E-04  3.09E-04  1.43E-04 -1.25E-04  4.85E-04  1.64E-04 -4.44E-04 -2.41E-04 -7.54E-05 -2.05E-04  8.37E-05
         -3.60E-04  6.11E-05  2.90E-04  1.32E-03
 
 OM68
+        3.03E-04  1.83E-06 -1.37E-04 -1.19E-05  4.31E-05 -9.46E-05 -1.30E-04  3.94E-05  5.05E-04 -1.70E-04  1.94E-04  7.47E-05
         -2.29E-04  6.29E-04  5.14E-05  1.11E-04  1.27E-04 -1.41E-04  6.88E-05 -1.02E-05  2.08E-04 -3.62E-05  1.16E-04  9.99E-05
        -2.07E-05 -8.28E-05  3.37E-04  3.03E-04  9.97E-05  1.32E-04  1.59E-04  2.42E-04 -4.34E-06  1.56E-04  8.76E-05 -3.56E-05
         -9.66E-05 -2.69E-04 -3.25E-04  2.15E-04  1.05E-03
 
 OM77
+        6.80E-04 -4.02E-04 -3.76E-05  2.16E-04  3.12E-04 -1.29E-04  3.57E-05  2.18E-04  5.62E-04 -4.40E-04  2.75E-04 -5.20E-04
         -1.51E-04  5.60E-04  7.69E-04  2.64E-04  3.15E-04 -2.09E-04  5.78E-04  4.87E-05 -4.83E-04 -1.20E-03 -1.97E-04 -3.82E-05
         2.43E-05 -1.32E-04  2.93E-04  4.50E-04 -5.97E-08  1.13E-03  8.58E-05  4.28E-05 -9.64E-04  2.91E-05  5.92E-05 -1.32E-04
          2.32E-04  4.55E-05  2.44E-04  5.00E-04  3.71E-04  2.67E-03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM78
+       -1.40E-04  2.97E-06 -1.11E-04 -4.94E-05  3.68E-04 -2.55E-05 -1.65E-04 -2.98E-04  2.35E-04 -8.08E-05  6.50E-05 -6.92E-05
          9.37E-05  5.03E-05  6.02E-04  4.30E-04 -1.62E-04  1.15E-04 -7.29E-05 -5.34E-06 -1.35E-04  2.42E-04 -1.27E-04  2.48E-05
        -4.35E-05  3.33E-05  2.97E-05  2.05E-04  1.26E-04  1.90E-04  4.18E-05  6.18E-05  2.54E-04 -2.06E-04 -1.81E-05 -1.68E-04
          1.86E-05  8.07E-05  1.42E-04 -3.81E-05 -2.38E-06  5.31E-04  1.21E-03
 
 OM88
+       -5.65E-04  3.64E-04  3.45E-05 -1.18E-04 -3.85E-04  4.67E-04 -6.35E-05 -5.63E-05  1.17E-03  2.57E-04  1.03E-04  4.54E-04
          6.31E-05 -2.11E-04  2.02E-04  1.24E-03  3.39E-04  3.10E-04  4.78E-04 -7.22E-05  9.60E-05  3.02E-04  9.41E-04  5.02E-05
         2.54E-04  5.26E-05 -1.75E-04  1.23E-04  6.27E-04  6.52E-04  2.48E-04  3.49E-04  4.86E-04  9.98E-04 -1.60E-04 -1.04E-04
         -1.92E-04 -9.05E-05 -7.88E-05 -1.20E-04  1.12E-04  7.77E-05  6.36E-04  2.51E-03
 
 SG11
+        4.49E-07 -6.58E-06 -8.21E-06 -4.08E-06 -4.28E-06  6.31E-06  2.35E-06 -2.26E-06 -2.67E-07  1.22E-06 -1.76E-07 -1.96E-06
          1.29E-06  1.12E-06  1.99E-06  2.41E-06  6.10E-07 -2.46E-06  5.85E-07 -2.59E-06 -1.56E-06 -4.25E-06 -2.48E-06  1.85E-06
        -3.92E-06 -1.25E-06  1.52E-06  2.61E-06 -6.71E-07  7.06E-07 -2.28E-06 -1.30E-07 -4.10E-06 -2.10E-06 -2.90E-08 -2.40E-06
          3.37E-06  1.72E-06  3.88E-06 -6.32E-08  4.13E-07  2.63E-06  2.01E-06  9.54E-07  5.02E-07
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+       -1.46E-05 -8.68E-06 -6.79E-06 -3.74E-06 -2.80E-07 -9.20E-06 -9.40E-06 -9.70E-06 -2.22E-07  5.26E-06  4.63E-07  2.27E-06
          3.60E-06 -1.98E-06  4.15E-06 -5.71E-07  2.37E-06  9.56E-07  3.11E-06  5.01E-06 -2.65E-06  4.71E-07  4.96E-06 -6.33E-06
         3.07E-06  9.12E-07 -7.33E-08 -2.24E-06 -3.01E-06 -6.16E-08 -9.28E-07 -3.27E-06 -1.27E-06 -1.73E-07  7.53E-07 -7.05E-08
          9.32E-08 -1.56E-06  7.23E-06  3.08E-06  1.42E-06  1.48E-06  9.72E-07 -1.86E-06 -5.49E-09  0.00E+00  1.18E-06
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************              CORRELATION MATRIX OF ESTIMATE (From Sample Variance)             ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 TH 1
+        7.27E-02
 
 TH 2
+       -1.27E-01  7.64E-02
 
 TH 3
+        3.52E-01 -1.07E-02  5.22E-02
 
 TH 4
+       -7.06E-03  2.54E-02 -1.10E-01  6.94E-02
 
 TH 5
+        1.80E-01  8.69E-02  4.16E-02  2.49E-03  6.79E-02
 
 TH 6
+        2.40E-02 -7.98E-02  3.93E-02 -2.90E-02 -3.02E-01  7.46E-02
 
 TH 7
+        1.19E-01 -2.53E-01  2.91E-01 -2.94E-01  1.27E-01  5.17E-02  7.15E-02
 
 TH 8
+        2.66E-01  2.47E-01  2.60E-01  1.59E-01  2.04E-01 -1.79E-01  3.03E-01  7.06E-02
 
 OM11
+       -8.34E-02 -1.09E-01 -5.13E-04  2.88E-02 -1.65E-01  1.13E-01 -1.76E-02 -2.70E-03  7.06E-02
 
 OM12
+       -1.24E-01  3.83E-02 -3.21E-02 -6.32E-02 -1.10E-01  6.29E-02  1.18E-02 -1.55E-01 -4.15E-01  4.56E-02
 
 OM13
+        7.78E-02 -3.54E-03 -6.73E-02  6.22E-02  6.14E-02  1.18E-01 -1.42E-01 -7.69E-02  3.07E-01 -1.53E-01  3.30E-02
 
 OM14
+       -4.76E-02 -1.95E-01  8.79E-02  3.93E-02 -1.07E-01  1.60E-01  3.21E-02 -2.35E-02  3.00E-01  1.41E-01  1.44E-01  4.38E-02
 
 OM15
+       -1.94E-02 -2.76E-02  2.95E-02  1.62E-02 -7.57E-02  6.08E-02 -1.58E-03  2.98E-02  2.26E-02  8.29E-02 -8.08E-02 -7.48E-02
          3.68E-02
 
 OM16
+        5.96E-02 -9.77E-03 -1.19E-01  4.57E-02  9.55E-02 -1.86E-01 -9.37E-02 -4.06E-02  2.14E-03 -9.94E-02  1.34E-01 -6.14E-02
         -4.28E-01  4.27E-02
 
 OM17
+       -1.30E-01  1.74E-02 -1.71E-01 -7.93E-02  6.96E-02 -9.60E-02 -1.74E-01 -1.53E-01  1.74E-01 -2.45E-01  2.50E-01 -2.79E-01
          1.33E-01  1.05E-01  4.11E-02
 
 OM18
+       -1.28E-01 -7.64E-02 -5.83E-02  2.30E-02 -2.03E-01  1.56E-01 -5.77E-02 -9.88E-02  6.59E-01 -3.98E-02  2.93E-01  2.96E-01
          8.57E-02 -1.76E-01  3.20E-01  4.30E-02
 
 OM22
+        5.99E-03 -7.65E-02 -3.69E-02  1.85E-02 -9.38E-02 -1.45E-02 -1.17E-01  1.97E-01  1.74E-01 -3.79E-01 -4.48E-02 -6.49E-02
         -8.91E-02  5.92E-02  7.18E-02  7.24E-02  6.28E-02
 
 OM23
+       -1.40E-01  1.40E-01  1.53E-01 -8.27E-02  5.39E-02 -1.45E-01 -4.14E-02 -6.60E-02 -9.64E-02  1.06E-01 -2.79E-01  2.09E-02
          1.82E-01 -1.61E-01  6.62E-02 -4.22E-03 -5.42E-02  3.25E-02
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM24
+       -4.27E-02 -8.29E-02 -3.89E-02  6.06E-03 -6.27E-02 -1.28E-02 -5.57E-02  1.14E-01  1.23E-01 -9.49E-03  6.14E-02 -1.57E-01
         -1.46E-02 -7.26E-02  1.12E-01  2.11E-01  4.15E-01 -1.02E-01  3.70E-02
 
 OM25
+        3.22E-02 -3.40E-03  7.44E-02  8.86E-02 -5.28E-03  1.66E-03 -1.72E-02  2.60E-02 -9.23E-02  1.28E-01  3.51E-02  9.14E-02
         -2.33E-01  1.35E-01 -8.17E-02 -6.64E-02  7.77E-02 -1.67E-01 -7.66E-02  3.39E-02
 
 OM26
+       -1.21E-01  2.10E-01 -7.61E-02  1.05E-01 -4.38E-02  1.05E-01 -1.02E-01  7.27E-02  6.81E-02 -1.74E-02 -2.13E-02  2.81E-02
          1.40E-01 -2.30E-01 -2.27E-02  1.07E-01  1.49E-01  2.46E-01  3.90E-02 -3.35E-01  4.00E-02
 
 OM27
+       -1.86E-01  1.77E-01 -4.37E-02 -9.00E-02  1.21E-01 -1.11E-01 -2.35E-02 -1.84E-01 -1.14E-01  2.82E-01 -5.99E-02  1.66E-01
         -2.79E-02 -3.20E-02 -2.21E-01 -7.14E-02 -3.64E-01  2.41E-01 -4.83E-01  5.62E-02  1.86E-01  4.48E-02
 
 OM28
+       -2.12E-01  1.68E-02 -4.05E-02 -1.21E-01 -6.90E-02 -8.14E-02 -5.90E-02 -5.64E-02 -3.80E-02  2.98E-01 -3.68E-02  7.09E-02
         -1.85E-02  8.16E-02 -1.35E-01 -8.96E-03  2.41E-01  1.36E-01  2.31E-01  1.61E-01 -1.04E-01  2.78E-01  3.81E-02
 
 OM33
+        1.32E-01  9.30E-02 -8.08E-02 -4.09E-02 -3.36E-02  2.38E-01  3.96E-02 -6.20E-02 -4.35E-02  6.89E-02  3.98E-01  6.06E-02
         -3.24E-02 -2.65E-03  5.60E-02  7.91E-02 -1.45E-01 -1.73E-01 -1.14E-01  4.20E-02 -2.19E-03  1.75E-02 -1.33E-01  3.88E-02
 
 OM34
+       -6.53E-02  1.43E-01  1.40E-01  5.51E-02  8.47E-02 -5.64E-02  3.02E-03  1.28E-01  1.79E-01  2.86E-03  2.41E-01  3.27E-01
         -1.26E-02  5.11E-02 -7.80E-03  1.61E-01 -5.39E-04  2.11E-01 -4.29E-02 -7.97E-02  1.38E-01  1.80E-01  8.97E-02 -3.15E-02
         3.54E-02
 
 OM35
+       -7.53E-02 -6.16E-02 -7.33E-02  7.57E-02  1.00E-01 -4.63E-03  1.03E-02 -1.35E-01 -1.22E-01  3.87E-02  1.29E-01 -1.99E-02
          1.69E-01 -1.32E-01  6.98E-02 -1.29E-02 -1.44E-01  2.34E-01  2.52E-02  1.98E-02  1.88E-02  7.44E-02  5.93E-02 -1.53E-01
        -1.12E-01  2.53E-02
 
 OM36
+        1.20E-01  8.77E-02 -5.21E-02  7.29E-03  1.05E-01 -9.54E-02 -4.81E-02  7.78E-02  6.10E-02 -5.66E-02 -2.58E-02 -7.85E-02
         -1.62E-01  3.05E-01 -3.18E-02 -3.45E-02  3.56E-03 -1.34E-01 -1.05E-02  5.96E-02 -1.26E-01 -6.34E-02 -2.20E-02  2.58E-02
        -1.37E-02 -3.77E-01  3.14E-02
 
 OM37
+        1.67E-01 -1.54E-01 -2.26E-03 -1.62E-01  2.21E-03  1.00E-01  1.23E-01 -5.49E-02  7.48E-02 -3.25E-02  1.30E-01 -7.83E-02
         -8.23E-02  1.11E-01  9.77E-02  9.83E-02  5.66E-02 -3.44E-01  1.34E-01  6.82E-02 -1.79E-01 -1.91E-01  5.05E-02  2.36E-01
        -3.05E-01 -8.05E-02  2.40E-01  2.80E-02
 
 OM38
+        1.01E-02 -1.43E-02  6.99E-02 -1.07E-01 -1.24E-01  2.42E-01  1.10E-01 -5.97E-02  1.30E-01  1.31E-01  3.83E-01  2.52E-01
          1.25E-02 -8.42E-02  8.56E-02  3.42E-01 -5.45E-02  1.93E-01  6.25E-02  2.31E-02  2.33E-02  3.11E-02  1.49E-01  3.95E-01
         1.72E-01  1.39E-01 -2.85E-01  2.86E-01  2.89E-02
 
 OM44
+        7.98E-02  8.88E-02  1.20E-01  7.71E-02  1.07E-01 -1.59E-02 -5.01E-02  1.21E-01  2.79E-01 -3.33E-02  1.68E-01  9.36E-02
          2.82E-02  1.65E-02  1.22E-01  2.04E-01  9.45E-02  3.15E-02  3.21E-01  2.24E-02 -4.09E-02 -1.99E-01  4.13E-02  6.60E-02
         2.23E-01 -1.02E-01  6.73E-02  6.66E-02  9.92E-02  6.47E-02
 
 OM45
+        6.08E-02 -7.37E-02  9.13E-02 -1.03E-01 -3.38E-03  4.77E-02  4.19E-02  9.31E-02  1.50E-01 -1.15E-01  2.50E-02  1.57E-01
          2.72E-02  1.20E-01 -1.04E-02  1.12E-01  8.50E-02 -2.85E-02  6.17E-03  2.15E-01 -8.68E-02 -1.10E-01  6.45E-02 -6.47E-02
        -1.84E-03  8.14E-03  3.81E-02  1.49E-01  8.90E-02 -1.51E-01  3.55E-02
 
 OM46
+       -9.67E-02  1.11E-01 -6.80E-02 -8.21E-02  1.12E-01  4.68E-02  1.32E-01  7.94E-02  3.41E-02  5.11E-02  2.30E-02 -4.58E-02
         -1.19E-01  7.20E-03 -1.94E-02  1.15E-01 -7.10E-02  5.54E-02 -3.62E-02 -5.01E-02  3.02E-01  1.94E-01  9.95E-02  7.86E-02
         5.02E-02  5.39E-02  8.34E-04 -4.24E-03  3.79E-02 -4.44E-02 -1.64E-01  3.86E-02
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM47
+       -8.48E-02  3.07E-02 -9.17E-04 -6.91E-02 -4.96E-02  4.63E-02  6.12E-03 -3.73E-02  6.31E-02  3.93E-02 -6.70E-02  2.67E-01
          1.41E-01 -4.07E-02 -1.65E-02  1.13E-01 -1.36E-01  1.35E-01 -3.55E-01 -1.22E-01  1.97E-01  4.85E-01  1.46E-01 -3.71E-02
         1.79E-01  3.81E-02 -7.37E-02 -5.35E-02  8.36E-02 -4.07E-01  1.88E-01  7.82E-02  4.05E-02
 
 OM48
+       -1.52E-02 -4.51E-02  8.51E-02 -1.87E-02 -1.70E-01  6.51E-02  9.54E-03  4.05E-02  3.29E-01  2.42E-02  2.24E-01  4.17E-01
          2.87E-02 -7.39E-02  1.19E-01  4.04E-01  1.35E-01  7.33E-02  3.12E-01 -9.90E-02  9.15E-02 -7.31E-02  3.21E-01  8.16E-02
         3.92E-01 -5.77E-02 -8.76E-02  2.69E-02  3.48E-01  3.70E-01  6.44E-02 -1.08E-02  1.57E-01  4.18E-02
 
 OM55
+       -1.62E-01  2.24E-01 -5.32E-02  1.01E-01 -1.73E-01  1.07E-01 -7.12E-02 -9.56E-02  1.81E-02 -8.51E-02 -7.24E-02  1.43E-02
          3.28E-02 -2.66E-02  2.17E-02 -2.63E-02 -6.22E-03  3.32E-02  6.67E-03 -5.17E-02  1.19E-01 -4.20E-02 -1.77E-01  1.22E-01
         3.61E-02 -8.77E-02  5.84E-02 -5.46E-02 -2.66E-02  4.65E-02 -1.73E-01  5.44E-02 -1.24E-01 -2.72E-02  3.89E-02
 
 OM56
+        8.96E-02 -1.19E-01  9.05E-02  1.42E-01  2.38E-02 -9.15E-02  8.23E-02  1.62E-01 -5.47E-02  3.59E-02  2.92E-02  1.66E-01
         -3.78E-02  3.16E-02 -1.39E-01 -1.51E-02  8.94E-02 -1.19E-01  7.29E-02  1.20E-01  8.67E-02 -1.30E-01 -3.61E-02  8.98E-03
        -3.39E-02  1.12E-01 -8.18E-02 -8.64E-02 -6.60E-03  1.82E-02  1.56E-01 -1.19E-01 -9.00E-02  2.13E-02 -2.36E-01  3.03E-02
 
 OM57
+       -2.71E-02 -5.34E-02 -1.00E-01  1.38E-01  4.95E-02 -1.39E-01 -6.95E-02 -4.66E-02  1.48E-02 -1.23E-01  3.70E-02 -8.33E-02
          1.23E-01 -1.02E-01  2.12E-01  2.90E-02  4.69E-02 -1.36E-02  8.41E-02 -3.08E-01  1.56E-01 -1.30E-01 -1.64E-01 -5.49E-02
        -1.96E-02  1.44E-01 -7.20E-02 -8.25E-02 -1.29E-01 -3.99E-02 -2.95E-01 -3.02E-02 -1.40E-01  2.65E-02  1.11E-01  9.38E-02
          3.13E-02
 
 OM58
+        1.66E-02  4.30E-02 -4.30E-02  2.03E-02 -2.12E-02 -2.20E-02 -2.97E-02  6.37E-02 -1.11E-01  5.90E-02 -3.00E-02 -9.40E-02
          3.51E-01 -7.86E-02  1.02E-01  3.91E-02  4.23E-02  1.07E-01 -5.81E-02  2.52E-01 -6.65E-02 -1.26E-02  2.92E-02 -1.41E-02
        -1.41E-01  2.40E-01 -7.95E-02 -9.83E-02 -5.43E-02 -7.78E-02  7.30E-02 -9.22E-02  1.78E-02 -1.10E-01 -1.36E-01 -3.84E-02
          1.95E-01  2.91E-02
 
 OM66
+       -8.51E-02 -6.03E-02 -2.54E-01 -4.89E-02  8.76E-02 -4.38E-02  5.63E-02  1.23E-02  6.03E-02 -7.22E-02 -2.53E-02 -1.24E-01
          6.64E-02 -4.83E-02  1.39E-01  6.82E-02  5.70E-02 -9.56E-02  4.86E-02 -1.33E-01 -8.51E-03 -6.40E-02 -1.38E-02 -1.54E-01
        -2.46E-02  1.29E-03  6.49E-02  3.78E-02 -1.21E-01  2.23E-02 -1.74E-02 -5.89E-02  3.62E-02 -3.84E-02 -1.93E-01 -2.93E-01
          6.52E-02  2.65E-02  5.56E-02
 
 OM67
+        2.23E-01  6.55E-02 -1.12E-02  4.35E-03  3.53E-02 -7.50E-02 -2.22E-02  1.54E-01  2.65E-02 -4.28E-03  6.78E-02 -6.74E-02
         -1.01E-01  2.03E-01 -5.36E-02 -3.02E-02  4.52E-02 -1.85E-01  1.12E-01  1.77E-01 -3.39E-01 -2.00E-01  1.06E-02 -2.53E-02
        -2.86E-02 -1.74E-01  2.71E-01  1.40E-01 -1.19E-01  2.06E-01  1.27E-01 -3.16E-01 -1.63E-01 -4.95E-02 -1.45E-01  7.60E-02
         -3.16E-01  5.76E-02  1.43E-01  3.64E-02
 
 OM68
+        1.29E-01  7.40E-04 -8.13E-02 -5.30E-03  1.96E-02 -3.91E-02 -5.63E-02  1.72E-02  2.21E-01 -1.15E-01  1.81E-01  5.27E-02
         -1.92E-01  4.54E-01  3.86E-02  7.98E-02  6.24E-02 -1.33E-01  5.75E-02 -9.30E-03  1.61E-01 -2.49E-02  9.40E-02  7.94E-02
        -1.81E-02 -1.01E-01  3.32E-01  3.34E-01  1.07E-01  6.28E-02  1.38E-01  1.93E-01 -3.31E-03  1.15E-01  6.96E-02 -3.63E-02
         -9.52E-02 -2.85E-01 -1.80E-01  1.82E-01  3.24E-02
 
 OM77
+        1.81E-01 -1.02E-01 -1.40E-02  6.02E-02  8.90E-02 -3.34E-02  9.66E-03  5.98E-02  1.54E-01 -1.87E-01  1.61E-01 -2.30E-01
         -7.96E-02  2.54E-01  3.62E-01  1.19E-01  9.71E-02 -1.24E-01  3.02E-01  2.78E-02 -2.33E-01 -5.17E-01 -1.00E-01 -1.90E-02
         1.33E-02 -1.01E-01  1.81E-01  3.11E-01 -4.00E-05  3.37E-01  4.69E-02  2.14E-02 -4.61E-01  1.35E-02  2.94E-02 -8.42E-02
          1.43E-01  3.03E-02  8.48E-02  2.66E-01  2.22E-01  5.17E-02
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM78
+       -5.54E-02  1.12E-03 -6.14E-02 -2.05E-02  1.56E-01 -9.81E-03 -6.66E-02 -1.22E-01  9.56E-02 -5.09E-02  5.66E-02 -4.54E-02
          7.31E-02  3.38E-02  4.21E-01  2.87E-01 -7.40E-02  1.01E-01 -5.67E-02 -4.53E-03 -9.73E-02  1.55E-01 -9.62E-02  1.84E-02
        -3.53E-02  3.79E-02  2.72E-02  2.10E-01  1.25E-01  8.46E-02  3.39E-02  4.60E-02  1.80E-01 -1.42E-01 -1.33E-02 -1.60E-01
          1.71E-02  7.96E-02  7.35E-02 -3.01E-02 -2.11E-03  2.95E-01  3.48E-02
 
 OM88
+       -1.55E-01  9.50E-02  1.32E-02 -3.40E-02 -1.13E-01  1.25E-01 -1.77E-02 -1.59E-02  3.31E-01  1.12E-01  6.22E-02  2.07E-01
          3.42E-02 -9.84E-02  9.83E-02  5.76E-01  1.08E-01  1.90E-01  2.58E-01 -4.26E-02  4.79E-02  1.35E-01  4.93E-01  2.58E-02
         1.43E-01  4.15E-02 -1.12E-01  8.75E-02  4.33E-01  2.01E-01  1.40E-01  1.80E-01  2.40E-01  4.77E-01 -8.22E-02 -6.89E-02
         -1.22E-01 -6.21E-02 -2.83E-02 -6.58E-02  6.91E-02  3.01E-02  3.65E-01  5.01E-02
 
 SG11
+        8.73E-03 -1.22E-01 -2.22E-01 -8.30E-02 -8.90E-02  1.19E-01  4.63E-02 -4.52E-02 -5.34E-03  3.77E-02 -7.52E-03 -6.33E-02
          4.94E-02  3.70E-02  6.84E-02  7.91E-02  1.37E-02 -1.07E-01  2.23E-02 -1.08E-01 -5.51E-02 -1.34E-01 -9.20E-02  6.73E-02
        -1.56E-01 -6.95E-02  6.86E-02  1.32E-01 -3.28E-02  1.54E-02 -9.09E-02 -4.75E-03 -1.43E-01 -7.09E-02 -1.05E-03 -1.12E-01
          1.52E-01  8.33E-02  9.84E-02 -2.45E-03  1.80E-02  7.18E-02  8.15E-02  2.69E-02  7.08E-04
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+       -1.85E-01 -1.05E-01 -1.20E-01 -4.97E-02 -3.80E-03 -1.14E-01 -1.21E-01 -1.27E-01 -2.89E-03  1.06E-01  1.29E-02  4.77E-02
          9.01E-02 -4.27E-02  9.30E-02 -1.22E-02  3.48E-02  2.71E-02  7.75E-02  1.36E-01 -6.09E-02  9.69E-03  1.20E-01 -1.50E-01
         7.99E-02  3.32E-02 -2.15E-03 -7.38E-02 -9.59E-02 -8.78E-04 -2.41E-02 -7.80E-02 -2.89E-02 -3.82E-03  1.78E-02 -2.14E-03
          2.74E-03 -4.94E-02  1.20E-01  7.78E-02  4.04E-02  2.63E-02  2.57E-02 -3.43E-02 -7.14E-03  0.00E+00  1.09E-03
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                              NUTS BAYESIAN ANALYSIS                            ********************
 ********************           INVERSE COVARIANCE MATRIX OF ESTIMATE (From Sample Variance)         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 TH 1
+        3.47E+02
 
 TH 2
+        8.11E+01  3.82E+02
 
 TH 3
+       -1.52E+02 -2.00E+01  6.89E+02
 
 TH 4
+        4.45E+01  9.70E+01  4.79E+01  3.58E+02
 
 TH 5
+       -5.93E+01 -3.27E+01  4.16E+01 -2.41E+01  3.59E+02
 
 TH 6
+       -1.12E+01 -2.57E+00 -5.07E+01 -7.24E+00  4.94E+01  2.96E+02
 
 TH 7
+        7.59E+01  1.77E+02 -1.24E+02  1.52E+02 -7.13E+01 -2.38E+01  4.33E+02
 
 TH 8
+       -7.84E+01 -1.85E+02 -7.36E+01 -1.45E+02 -1.82E+01  9.07E+01 -1.89E+02  4.78E+02
 
 OM11
+        5.36E+01  3.40E+00  4.50E+01  2.45E+01  7.99E+01 -3.41E+01 -6.45E+01 -2.18E+01  7.63E+02
 
 OM12
+        1.07E+01 -2.90E+01  5.72E+01  4.57E+01  8.79E+01 -3.16E+01 -2.45E+01  1.42E+01  5.12E+02  1.39E+03
 
 OM13
+       -2.36E+01  7.05E+00 -1.94E+02  3.84E+00 -1.15E+02  3.51E+01  2.10E+02  4.03E+01 -2.74E+02  2.69E+02  2.73E+03
 
 OM14
+        8.72E+01  2.11E+02  2.65E+00  8.17E+01 -1.01E+02 -5.51E+01  1.43E+02 -1.08E+02 -1.94E+02 -2.82E+02 -3.95E+01  1.41E+03
 
 OM15
+       -4.23E+01  9.67E+01 -4.66E+01 -6.61E+01  1.18E+01 -2.29E+00  4.67E+01 -4.14E+01 -1.83E+02 -2.70E+02  6.09E+01  2.67E+02
          1.62E+03
 
 OM16
+        4.63E+00  9.63E+00 -7.14E+00 -1.04E+02  1.72E+01  6.66E+01  2.03E+01  1.11E+02 -1.23E+02 -2.67E+02 -1.94E+02  7.54E+01
          6.91E+02  1.48E+03
 
 OM17
+        1.46E+02  1.01E+01  8.13E+01  1.97E+02 -1.01E+02  3.42E+01  9.92E+01 -3.12E+01  1.30E+02  2.47E+02 -2.49E+02  6.11E+02
         -2.52E+02 -3.62E+02  1.75E+03
 
 OM18
+       -8.55E+00  5.78E+01 -7.88E+01 -1.15E+02  7.67E+01  7.55E+01  4.72E+01  1.65E+02 -7.94E+02 -7.07E+02 -2.24E+02 -1.90E+02
          2.78E+02  6.29E+02 -7.84E+02  2.70E+03
 
 OM22
+       -4.15E+01  8.20E+01  7.30E+01  8.09E+01  1.54E+01 -1.68E+01  7.44E+01 -1.13E+02  4.14E+01  4.98E+02  1.80E+02  3.44E+00
          8.12E+01 -1.67E+02  9.97E+01 -2.40E+02  7.70E+02
 
 OM23
+        5.81E+01  3.94E+01 -3.52E+02  6.26E+01 -7.49E+01  2.43E+02  1.03E+02  1.38E+02 -7.33E+01  4.34E+01  1.38E+03 -1.63E+01
          2.40E+01  4.93E+01 -2.35E+02  1.26E+02 -3.55E+01  2.88E+03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM24
+        8.93E+01  1.62E+02  1.93E+01  1.23E+02 -8.71E+01  5.79E+01  1.02E+02 -1.26E+02  7.44E+00 -2.24E+02  2.89E+01  5.02E+02
          1.82E+02  5.81E+01  2.97E+02 -2.89E+02 -1.23E+02  4.04E+02  1.96E+03
 
 OM25
+       -2.65E+01 -5.28E+01 -1.63E+02 -2.20E+02  2.29E+01 -4.98E+00 -1.09E+01  6.58E+01 -7.00E+01 -3.18E+02  8.55E+01 -1.03E+02
          6.44E+02  3.78E+02 -3.75E+02  2.75E+02 -3.09E+02  4.04E+02  1.15E+02  2.06E+03
 
 OM26
+        1.83E+01 -1.63E+02  4.80E+01 -1.73E+02  4.23E+01 -1.70E+02  1.17E+01  3.59E+01 -1.23E+01 -4.07E+02 -5.27E+02  6.75E+01
          1.13E+02  6.17E+02 -2.04E+02  3.48E+02 -5.22E+02 -8.28E+02 -4.55E+02  6.43E+02  2.23E+03
 
 OM27
+       -3.06E+01  1.78E+01  1.20E+02  1.23E+02 -1.03E+02  1.35E+02 -2.07E+01  7.00E+01 -6.72E+01  1.13E+02  5.70E+01  2.07E+02
          1.97E+02 -1.32E+02  5.33E+02 -2.98E+02  5.66E+02  1.31E+01  7.36E+02 -4.68E+02 -8.39E+02  2.32E+03
 
 OM28
+        1.86E+02  3.25E+01 -2.34E+01 -3.33E+00  3.11E+01 -5.91E+00  6.15E+01  6.49E+01 -6.87E+01 -7.60E+02 -6.53E+02  3.36E+01
         -1.95E+02  2.01E+02 -2.20E+02  1.17E+03 -8.03E+02 -4.41E+02 -4.90E+02  1.00E+02  1.17E+03 -1.35E+03  3.28E+03
 
 OM33
+       -7.96E+01 -6.27E+01  1.87E+02 -2.07E+01  6.52E+00 -7.32E+01 -8.71E+01  5.23E+01  1.47E+02 -4.30E+01 -6.92E+02 -1.16E+01
         -3.14E+01  8.30E+01 -9.79E+01  9.59E+01 -2.05E+01 -7.33E+01  8.60E+01  2.87E+01  1.71E+02 -1.08E+02  3.12E+02  1.34E+03
 
 OM34
+        7.54E+01 -1.02E+02 -8.96E+01 -1.89E+01 -6.78E+01  2.23E+01 -8.01E+01 -4.03E+01  1.09E+02  1.42E+01 -4.18E+02 -1.92E+02
         -2.14E+02 -2.61E+02  2.02E+02 -2.73E+02 -1.58E+02 -7.10E+01  6.89E+01  3.88E+00 -1.27E+02 -3.26E+02  2.48E+01  1.70E+02
         1.81E+03
 
 OM35
+       -7.89E+01 -7.39E+01  2.57E+02 -1.68E+02 -4.28E+01 -1.27E+02 -1.64E+02  1.46E+02  2.15E+02  1.60E+02 -1.17E+03 -1.04E+02
         -4.98E+01  2.06E+02 -7.71E+01  1.32E+02  2.12E+02 -1.22E+03 -4.62E+02 -6.68E+01  6.33E+02 -2.66E+01  1.98E+02  6.76E+02
         1.56E+02  3.36E+03
 
 OM36
+       -5.67E+01 -7.02E+01  1.26E+02 -2.34E+01 -4.39E+01 -8.31E+01 -8.55E+00 -4.36E+01  2.47E+01 -6.48E+00 -3.90E+02  5.11E+01
          6.42E+01 -9.92E+01  1.62E+02 -2.09E+02  1.31E+02 -8.13E+02 -1.18E+02 -1.09E+02  3.81E+02  1.27E+02 -1.97E+01 -1.91E+01
        -2.34E+02  9.72E+02  2.02E+03
 
 OM37
+        4.60E+01  2.44E+01 -2.41E+02  9.16E+01 -7.43E+01  1.37E+02 -2.17E+01  1.28E+02 -3.31E+01 -9.23E+00  6.92E+02  1.57E+02
          1.01E+01  1.73E+02  1.84E+02 -1.17E+02 -1.23E+02  1.44E+03  1.41E+02  4.30E+01 -3.19E+02  1.41E+02 -5.33E+02 -2.73E+02
         7.82E+02 -6.82E+02 -9.22E+02  3.47E+03
 
 OM38
+       -5.53E+01 -2.23E+01  2.29E+02  3.82E+01  1.25E+02 -1.97E+02 -1.51E+02 -1.39E+02  1.90E+02 -1.51E+02 -1.40E+03 -1.55E+02
          4.03E+01  2.40E+01  1.87E+01 -1.94E+02  6.32E+01 -1.80E+03 -1.16E+02 -2.30E+02  5.25E+02  1.03E+02  3.93E+02 -3.81E+02
        -5.13E+02  5.23E+02  1.24E+03 -1.87E+03  4.19E+03
 
 OM44
+       -1.01E+01 -3.33E+01 -7.37E+01 -5.09E+00 -7.90E+01 -1.06E+01  5.44E+01 -2.07E+01 -1.84E+02 -5.67E+01  6.70E+01 -6.18E+01
         -1.50E+02 -7.83E+01 -2.10E+01  1.60E+02  2.20E+01 -8.45E+01 -9.49E+01 -6.96E+01 -6.02E+01 -5.27E+01  5.67E+01 -7.69E+01
        -1.28E+02 -2.15E+01  3.89E+01 -1.52E+02  1.42E+02  6.03E+02
 
 OM45
+        3.17E+01  9.44E+00 -9.24E+00  1.26E+02 -7.39E+01 -2.91E+01  6.64E+01 -6.71E+01 -4.65E+01  1.23E+02 -7.36E+01 -1.09E+02
         -1.43E+02 -9.10E+01  7.36E+01 -7.79E-01  8.64E+01 -1.97E+02 -5.75E+01 -3.17E+02 -1.27E+01  1.84E+02  1.04E+02  4.43E+01
        -9.84E+01  5.48E+01  1.01E+02 -2.90E+02  2.69E+02  2.27E+02  1.39E+03
 
 OM46
+        3.59E+01  2.37E+01  8.06E+01  1.18E+02 -7.69E+01 -2.71E+01 -4.01E+01 -1.41E+02  5.71E+01  2.86E+01 -5.66E+01  9.47E+01
          1.53E+02 -9.27E+00  1.27E+02 -3.02E+02  1.09E+02  3.30E+00  1.08E+02 -1.35E+02 -3.16E+02  3.63E+01 -1.69E+02 -1.12E+02
        -3.65E+01 -1.67E+02  3.20E+01  2.53E+01  3.39E+02  1.93E+01  3.19E+02  1.23E+03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM47
+       -7.59E+01  2.59E+01  6.94E+00 -1.86E+01  3.70E+01 -4.81E+01  2.90E+01 -8.09E+01 -9.05E+01  1.23E+02  2.89E+02 -1.87E+02
         -2.22E+02 -2.58E+02 -2.14E+02  9.73E+01  1.37E+02  1.32E+02  2.97E+02  1.96E+02 -3.26E+02 -1.47E+02 -2.02E+02  4.52E+00
        -3.52E+02 -7.96E+01  2.80E+01 -4.01E+02  2.25E+02  4.98E+02 -1.25E+02 -7.79E+01  1.97E+03
 
 OM48
+       -1.04E+02  1.78E+00  4.73E+01 -3.72E+01  1.47E+02  3.60E+01 -1.06E+02  4.35E+01  1.47E+02  1.10E+02 -1.78E+02 -5.92E+02
          1.05E+02  1.86E+02 -5.87E+02 -2.02E+01  5.82E+01 -9.85E+01 -4.74E+02  9.39E+01  1.18E+02  1.78E+01 -1.44E+02 -1.91E+01
        -3.88E+02  3.01E+02  7.83E+01 -2.10E+02  8.34E+01 -3.85E+02  7.61E+00  1.36E+02 -5.15E+02  1.97E+03
 
 OM55
+        5.33E+01 -1.86E+02  4.31E+01 -6.81E+01  1.15E+02 -7.11E+00 -1.28E+02  9.32E+01  9.03E+01  2.19E+02  2.77E+02 -2.64E+02
         -3.03E+02 -1.80E+02  1.91E+01 -1.23E+02 -2.27E+01  1.11E+02 -1.47E+02 -1.93E+02 -1.87E+02  1.50E+01  4.58E+01 -1.59E+02
         5.03E+01 -1.38E+02 -1.56E+02  1.37E+02 -9.30E+01 -1.64E+01  8.50E+00 -2.20E+01  1.30E+02  4.00E+01  1.19E+03
 
 OM56
+        1.92E+01  4.03E+01  5.40E+01  9.43E-01  3.22E+01  1.29E+02 -1.52E+02 -7.32E+01  1.91E+02  2.04E+02  3.67E+02 -2.80E+02
         -3.40E+02 -5.59E+02  1.75E+02 -5.41E+02  6.96E+01  6.26E+02  1.68E+02 -4.53E+02 -1.00E+03  4.29E+02 -4.89E+02 -1.97E+02
         2.95E+02 -7.13E+02 -2.83E+02  4.89E+02 -4.08E+02 -1.06E+02 -3.73E+02  7.96E+01  1.82E+02  4.07E+01  6.65E+02  2.58E+03
 
 OM57
+       -3.75E+01 -3.44E+01 -1.00E+02 -1.05E+02 -6.74E+01  1.00E+02  5.05E+01  8.41E+01 -1.48E+02 -1.43E+02 -6.18E+01 -6.95E+01
          3.18E+02  4.00E+02 -3.05E+02  3.51E+02 -1.11E+02  1.72E+02 -7.92E+01  7.76E+02  2.61E+02 -2.40E+02  3.01E+02  4.99E+01
        -1.53E+02 -7.79E+01  5.64E+00 -8.83E+01  2.60E+02  2.11E+02  5.00E+02  2.47E+02  1.54E+02 -1.59E+02 -3.15E+02 -8.46E+02
          2.35E+03
 
 OM58
+        1.71E+01 -7.26E+01  1.19E+02  1.30E+02  5.00E+01  6.49E+00 -5.83E+01 -1.47E+02  2.33E+02  2.66E+02  1.71E+02 -8.37E+01
         -1.05E+03 -7.30E+02  3.52E+02 -9.04E+02  7.52E+00 -4.19E+01  1.67E+02 -1.14E+03 -6.78E+02  1.75E+02 -5.96E+02 -2.14E+02
         5.31E+02 -7.68E+02 -2.25E+02  4.38E+02 -1.91E+02  8.73E+00 -2.12E+02 -1.10E+01 -7.36E+01 -1.18E+02  5.19E+02  1.10E+03
         -1.15E+03  3.15E+03
 
 OM66
+        1.11E+01  5.85E+00  1.45E+02  1.73E+01 -1.50E+01  2.38E+01 -8.35E+01 -2.49E+01  4.66E+01  1.07E+02  1.59E+02 -1.91E+01
         -1.14E+02 -1.83E+02  3.44E+01 -2.46E+02  2.29E+01  2.82E+02  1.11E+02 -5.54E+01 -3.88E+02  1.31E+02 -2.40E+02  4.06E+01
         1.11E+02 -2.50E+02 -1.96E+02  1.16E+02 -2.13E+02 -6.43E+01 -1.09E+02  2.13E+01 -2.34E+01 -9.72E+00  2.73E+02  6.68E+02
         -2.74E+02  4.10E+02  6.49E+02
 
 OM67
+       -9.29E+01 -1.30E+02  9.73E+01 -1.68E+01  2.52E+01 -2.70E+01 -1.68E+01 -2.19E+01  1.68E+01 -1.67E+02 -3.95E+02  4.81E+01
          2.46E+02  2.96E+02  3.16E+01  5.60E+01 -8.48E+01 -3.00E+02 -1.93E+02  2.48E+02  7.29E+02 -1.71E+02  3.58E+02  9.90E+01
        -1.09E+02  4.01E+02  8.85E+01 -1.91E+02  5.52E+02 -1.05E+02  2.05E+02  4.69E+02 -2.08E+02  2.15E+02 -8.05E+01 -6.98E+02
          8.52E+02 -7.29E+02 -3.34E+02  1.83E+03
 
 OM68
+       -9.06E+01  3.43E+01  7.48E+01  7.11E+01 -8.92E+00  9.93E+01 -3.38E+00 -7.47E+01 -7.42E+01  3.04E+02  3.77E+02 -1.60E+02
         -4.39E+02 -1.07E+03  1.60E+02 -4.10E+02  1.78E+02  5.24E+02  2.05E+02 -3.33E+02 -1.34E+03  1.48E+02 -7.12E+02 -6.03E+01
         4.88E+02 -7.14E+02 -6.84E+02 -9.37E+01 -7.72E+02  6.61E+01 -2.69E+02 -2.62E+02  1.73E+02 -2.70E+02  1.86E+02  1.02E+03
         -5.01E+02  1.31E+03  6.04E+02 -9.06E+02  3.10E+03
 
 OM77
+       -1.20E+02  6.05E+01  1.06E+02 -4.92E+01  3.21E+01 -3.86E+01 -4.87E+01 -6.75E+00 -6.82E+01  6.35E+01 -4.66E+01  1.49E+02
          9.94E+01 -1.70E+02 -1.18E+02  3.28E+01  2.73E+02 -2.19E+02  4.09E+01 -8.01E+01 -7.65E+01  7.47E+02 -4.02E+02  1.01E+02
        -4.38E+02  2.98E+02  1.92E+02 -4.88E+02  2.60E+02 -2.21E+01 -1.37E+02 -2.39E+02  5.89E+02 -2.79E+01 -3.10E+01  1.67E+02
         -3.54E+02 -1.40E+02 -2.44E+00 -2.87E+02 -1.24E+02  1.35E+03
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      TH 6      TH 7      TH 8      OM11      OM12      OM13      OM14  
             OM15      OM16      OM17      OM18      OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33  
            OM34      OM35      OM36      OM37      OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56  
             OM57      OM58      OM66      OM67      OM68      OM77      OM78      OM88      SG11      SG12      SG22  
 
 OM78
+        5.42E+01  3.71E+01 -2.48E+01 -5.51E+01 -4.16E+01 -3.08E+01  1.49E+01  3.15E+01  2.11E+02 -1.39E+02 -3.68E+02 -3.73E+02
         -7.02E+01  2.05E+02 -8.27E+02  2.46E+02 -3.58E+02 -3.03E+02 -3.49E+02  1.65E+02  7.02E+02 -1.16E+03  1.42E+03  1.78E+02
         1.05E+02  2.75E+02 -2.25E+01 -6.09E+02  2.86E+02 -2.16E+02  1.21E+02  1.28E+02 -6.72E+02  9.97E+02 -7.68E+01 -2.89E+02
          2.16E+02 -3.58E+02 -1.11E+02  3.88E+02 -2.51E+02 -7.90E+02  2.99E+03
 
 OM88
+       -2.15E+01 -1.83E+02 -3.73E+01 -5.64E+01 -3.07E+01 -3.90E+01 -3.86E+01 -7.90E+00 -1.81E+01  2.48E+02  6.28E+02  1.64E+02
         -2.69E+00 -1.84E+02  4.71E+02 -1.12E+03  1.67E+02  1.90E+02 -3.92E+01  1.85E+01 -3.03E+02  3.41E+02 -1.53E+03 -1.52E+02
         3.05E+02 -3.00E+02 -2.36E+01  6.17E+02 -8.52E+02 -5.26E+01 -2.67E+02 -1.71E+02 -1.09E+02 -5.80E+02  1.61E+02  3.31E+02
         -1.73E+02  6.28E+02  1.92E+02 -2.34E+02  4.45E+02  6.89E+01 -1.32E+03  2.17E+03
 
 SG11
+       -1.34E+03  3.35E+03  1.09E+04  3.40E+03  2.73E+03 -3.68E+03 -2.15E+03 -3.83E+03  4.37E+03 -1.70E+03 -6.60E+03 -5.24E+02
         -3.38E+03 -6.96E+03  1.14E+03 -5.12E+03  7.56E+02 -6.34E+03  5.62E+03  1.92E+03  1.47E+03  5.77E+03  6.05E+03  1.88E+03
        -4.89E+02  8.96E+03  2.20E+03 -1.27E+04  1.41E+04 -1.59E+03  2.31E+03  1.79E+03  1.11E+04  4.21E+03  2.55E+03  8.64E+03
         -1.16E+04 -3.40E+03  8.86E+02  8.68E+02 -1.91E+03  9.23E+03 -1.85E+03 -1.08E+04  2.72E+06
 
 SG12
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 SG22
+        2.37E+03  2.38E+03  8.63E+02  2.38E+03 -4.42E+02  1.03E+03  2.26E+03  1.15E+02 -7.84E+02 -3.67E+03 -4.42E+03 -1.74E+03
         -4.94E+03  4.98E+03 -2.63E+03  3.86E+03 -1.55E+02 -3.95E+03 -2.41E+03 -9.91E+03  2.47E+03  1.51E+03 -2.91E+02  2.07E+03
        -5.16E+03  1.41E+03  2.29E+03  1.23E+03  6.40E+03  1.82E+03  3.41E+03  1.46E+03 -1.06E+02  1.76E+03 -2.58E+03 -3.68E+03
         -7.49E+02  5.11E+03 -3.84E+03 -1.73E+03 -8.80E+03 -2.13E+01 -1.02E+03 -9.39E+02 -2.34E+04  0.00E+00  1.14E+06
 
 Elapsed postprocess time in seconds:     0.00
 Elapsed finaloutput time in seconds:     0.00
 #CPUT: Total CPU Time in Seconds,     1368.797
Stop Time: 
Wed 10/04/2023 
02:43 PM
