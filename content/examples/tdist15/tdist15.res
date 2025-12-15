Sun 01/07/2018 
07:46 PM
$PROB RUN# Example 1 (from samp5l)
$INPUT ID TIME  DV=CONC AMT=DOSE RATE EVID MDV CMT
$DATA tdist15.csv IGNORE=C

$SUBROUTINES ADVAN3 TRANS4

$PK
MU_1=THETA(1)
MU_2=THETA(2)
MU_3=THETA(3)
MU_4=THETA(4)
NU=2.0
CLA=ETA(1)/SQRT(OMEGA(1,1))
V1A=ETA(2)/SQRT(OMEGA(2,2))
QQA=ETA(3)/SQRT(OMEGA(3,3))
V2A=ETA(4)/SQRT(OMEGA(4,4))
;CLA=ETA(1)/0.173
;V1A=ETA(2)/0.173
;QQA=ETA(3)/0.173
;V2A=ETA(4)/0.173
CLB=ETA(5)
V1B=ETA(6)
QQB=ETA(7)
V2B=ETA(8)
CLR=(CLA*CLA+CLB*CLB)/NU
V1R=(V1A*V1A+V1B*V1B)/NU
QQR=(QQA*QQA+QQB*QQB)/NU
V2R=(V2A*V2A+V2B*V2B)/NU
DEL=1.0E-08
IF (CLR.GT.40.0) CLR=40.0
IF (V1R.GT.40.0) V1R=40.0
IF (QQR.GT.40.0) QQR=40.0
IF (V2R.GT.40.0) V2R=40.0
CLRQ=1.0
V1RQ=1.0
QQRQ=1.0
V2RQ=1.0
IF(CLR.GT.DEL) CLRQ=SQRT((EXP(CLR)-1.0)/CLR)
IF(V1R.GT.DEL) V1RQ=SQRT((EXP(V1R)-1.0)/V1R)
IF(QQR.GT.DEL) QQRQ=SQRT((EXP(QQR)-1.0)/QQR)
IF(V2R.GT.DEL) V2RQ=SQRT((EXP(V2R)-1.0)/V2R)
CL=EXP(MU_1+ETA(1)*CLRQ)
V1=EXP(MU_2+ETA(2)*V1RQ)
Q= EXP(MU_3+ETA(3)*QQRQ)
V2=EXP(MU_4+ETA(4)*V2RQ)
S1=V1

$ERROR
Y = F + F*EPS(1)

;$THETA 1.68338E+00  1.58811E+00  8.12694E-01  2.37435E+00  
$THETA 2 2 2 2
$OMEGA BLOCK(4)
0.1
0.01 0.1
0.01 0.01 0.1
0.01 0.01 0.01 0.1

$OMEGA (1.0 FIXED) (1.0 FIXED) (1.0 FIXED) (1.0 FIXED)

$SIGMA 
0.1

;$EST METHOD=ITS INTERACTION LAPLACE MAXEVAL=9999 PRINT=5 NOHABORT SIGL=9 CTYPE=3 NITER=200 NONINFETA=1 MCETA=10
$EST METHOD=IMP INTERACTION LAPLACE MAXEVAL=9999 PRINT=1 NOHABORT ISAMPLE=3000 NITER=200 SIGL=9 DF=2 RANMETHOD=3S2P
     CTYPE=3 MCETA=10
$EST METHOD=1 INTERACTION LAPLACE MAXEVAL=9999 PRINT=1 NOHABORT NSIG=3 SIGL=9 NONINFETA=1 SLOW MCETA=10
$COV MATRIX=R UNCONDITIONAL
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  87) WITH "LAPLACIAN" AND "INTERACTION", "NUMERICAL" AND "SLOW"
 ARE ALSO REQUIRED ON $ESTIM RECORD, AND "SLOW" IS REQUIRED ON $COV
 RECORD. NM-TRAN HAS SUPPLIED THESE OPTIONS.
             
 (WARNING  78) OMEGA IS USED ON THE RIGHT. WITH A SUBSEQUENT RUN, IF AN
 INITIAL ESTIMATE OF A DIAGONAL BLOCK OF OMEGA IS TO BE COMPUTED BY
 NONMEM, THAT BLOCK WILL BE SET TO AN IDENTITY MATRIX DURING THAT
 COMPUTATION. THIS COULD LEAD TO AN ARITHMETIC EXCEPTION.*

 (MU_WARNING 24) ABBREVIATED CODE IS TOO COMPLEX. UNABLE TO CHECK USE OF MU_ VARIABLES.
             
 (WARNING  87) WITH "LAPLACIAN" AND "INTERACTION", "NUMERICAL" AND "SLOW"
 ARE ALSO REQUIRED ON $ESTIM RECORD, AND "SLOW" IS REQUIRED ON $COV
 RECORD. NM-TRAN HAS SUPPLIED THESE OPTIONS.

 * THE MAXIMUM NUMBER OF WARNINGS OF ONE OR MORE TYPES WAS REACHED.
 IT IS POSSIBLE THAT SOME WARNING MESSAGES WERE SUPPRESSED.
  
License Registered to: IDS NONMEM 7 TEAM
Expiration Date:     2 JUN 2030
Current Date:        7 JAN 2018
Days until program expires :4525
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.4.2
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 RUN# Example 1 (from samp5l)
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:      600
 NO. OF DATA ITEMS IN DATA SET:   8
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   3
 MDV DATA ITEM IS DATA ITEM NO.:  7
0INDICES PASSED TO SUBROUTINE PRED:
   6   2   4   5   0   0   8   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID TIME CONC DOSE RATE EVID MDV CMT
0FORMAT FOR DATA:
 (7E10.0/E10.0)

 TOT. NO. OF OBS RECS:      500
 TOT. NO. OF INDIVIDUALS:      100
0LENGTH OF THETA:   4
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS BLOCK FORM:
  1
  1  1
  1  1  1
  1  1  1  1
  0  0  0  0  2
  0  0  0  0  0  3
  0  0  0  0  0  0  4
  0  0  0  0  0  0  0  5
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.2000E+01  0.2000E+01  0.2000E+01  0.2000E+01
0INITIAL ESTIMATE OF OMEGA:
 BLOCK SET NO.   BLOCK                                                                    FIXED
        1                                                                                   NO
                  0.1000E+00
                  0.1000E-01   0.1000E+00
                  0.1000E-01   0.1000E-01   0.1000E+00
                  0.1000E-01   0.1000E-01   0.1000E-01   0.1000E+00
        2                                                                                  YES
                  0.1000E+01
        3                                                                                  YES
                  0.1000E+01
        4                                                                                  YES
                  0.1000E+01
        5                                                                                  YES
                  0.1000E+01
0INITIAL ESTIMATE OF SIGMA:
 0.1000E+00
0COVARIANCE STEP OMITTED:        NO
 R MATRIX SUBSTITUTED:          YES
 S MATRIX SUBSTITUTED:           NO
 EIGENVLS. PRINTED:              NO
 COMPRESSED FORMAT:              NO
 GRADIENT METHOD USED:       SLOW
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
 FORCED POS. DEFINITE SETTING: (FPOSDEF):0
1DOUBLE PRECISION PREDPP VERSION 7.4.2

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
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    10
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      9
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     9
 NOPRIOR SETTING (NOPRIOR):                 OFF
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          ON
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      OFF
 RAW OUTPUT FILE (FILE): tdist15.ext
 EXCLUDE TITLE (NOTITLE):                   NO
 EXCLUDE COLUMN LABELS (NOLABEL):           NO
 FORMAT FOR ADDITIONAL FILES (FORMAT):      S1PE12.5
 PARAMETER ORDER FOR OUTPUTS (ORDER):       TSOL
 WISHART PRIOR DF INTERPRETATION (WISHTYPE):0
 KNUTHSUMOFF:                               0
 INCLUDE LNTWOPI:                           NO
 INCLUDE CONSTANT TERM TO PRIOR (PRIORC):   NO
 INCLUDE CONSTANT TERM TO OMEGA (ETA) (OLNTWOPI):NO
 EM OR BAYESIAN METHOD USED:                IMPORTANCE SAMPLING (IMP)
 MU MODELING PATTERN (MUM):
 GRADIENT/GIBBS PATTERN (GRD):
 AUTOMATIC SETTING FEATURE (AUTO):          OFF
 CONVERGENCE TYPE (CTYPE):                  3
 CONVERGENCE INTERVAL (CINTERVAL):          1
 CONVERGENCE ITERATIONS (CITER):            10
 CONVERGENCE ALPHA ERROR (CALPHA):          5.000000000000000E-02
 ITERATIONS (NITER):                        200
 ANEAL SETTING (CONSTRAIN):                 1
 STARTING SEED FOR MC METHODS (SEED):       11456
 MC SAMPLES PER SUBJECT (ISAMPLE):          3000
 RANDOM SAMPLING METHOD (RANMETHOD):        3US2P
 EXPECTATION ONLY (EONLY):                  0
 PROPOSAL DENSITY SCALING RANGE
              (ISCALE_MIN, ISCALE_MAX):     0.100000000000000       ,10.0000000000000
 SAMPLE ACCEPTANCE RATE (IACCEPT):          0.400000000000000
 LONG TAIL SAMPLE ACCEPT. RATE (IACCEPTL):   0.00000000000000
 T-DIST. PROPOSAL DENSITY (DF):             2
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
   1   2   3   4
 THETAS THAT ARE SIGMA-LIKE:
 
 
 MONITORING OF SEARCH:

 iteration            0 OBJ=  -247.032085090246 eff.=    1029. Smpl.=    3000. Fit.= 0.98240
 iteration            1 OBJ=  -345.456658022267 eff.=  415473. Smpl.=    3000. Fit.= 0.99491
 iteration            2 OBJ=  -812.411124140665 eff.=  860770. Smpl.=    2950. Fit.= 0.98066
 iteration            3 OBJ=  -920.326204519872 eff.= 5467774. Smpl.=    2973. Fit.= 0.97966
 iteration            4 OBJ=  -1070.98693801785 eff.=  373502. Smpl.=    2992. Fit.= 0.98251
 iteration            5 OBJ=  -1117.48510066984 eff.=   36061. Smpl.=    2985. Fit.= 0.98576
 iteration            6 OBJ=  -1200.54307853616 eff.=   13774. Smpl.=    3000. Fit.= 0.98684
 iteration            7 OBJ=  -1084.02593283515 eff.=   73197. Smpl.=    2997. Fit.= 0.98831
 iteration            8 OBJ=  -1205.18927142925 eff.= 5673398. Smpl.=    2987. Fit.= 0.98871
 iteration            9 OBJ=  -1198.78397853480 eff.=   86147. Smpl.=    2997. Fit.= 0.98922
 iteration           10 OBJ=  -1264.98034353816 eff.=   12134. Smpl.=    2997. Fit.= 0.98989
 iteration           11 OBJ=  -1303.34396766899 eff.=    1157. Smpl.=    3000. Fit.= 0.98949
 iteration           12 OBJ=  -1332.58827686656 eff.=     970. Smpl.=    3000. Fit.= 0.98895
 iteration           13 OBJ=  -1364.50369891286 eff.=     820. Smpl.=    2983. Fit.= 0.98831
 iteration           14 OBJ=  -1393.96167454708 eff.=     960. Smpl.=    3000. Fit.= 0.98923
 iteration           15 OBJ=  -1438.50453925336 eff.=     790. Smpl.=    3000. Fit.= 0.98988
 iteration           16 OBJ=  -1449.96628757023 eff.=     910. Smpl.=    2993. Fit.= 0.98968
 iteration           17 OBJ=  -1467.06795571236 eff.=     829. Smpl.=    2999. Fit.= 0.99005
 iteration           18 OBJ=  -1485.18255050095 eff.=     836. Smpl.=    3000. Fit.= 0.99027
 iteration           19 OBJ=  -1480.16500607327 eff.=     829. Smpl.=    3000. Fit.= 0.98945
 iteration           20 OBJ=  -1517.51334283338 eff.=    1231. Smpl.=    3000. Fit.= 0.99020
 iteration           21 OBJ=  -1470.24179823700 eff.=     958. Smpl.=    3000. Fit.= 0.99000
 iteration           22 OBJ=  -1491.30959954762 eff.=    2617. Smpl.=    3000. Fit.= 0.98998
 iteration           23 OBJ=  -1514.70491222193 eff.=     811. Smpl.=    3000. Fit.= 0.98958
 iteration           24 OBJ=  -1512.90126763288 eff.=     834. Smpl.=    2996. Fit.= 0.98876
 iteration           25 OBJ=  -1533.65722349511 eff.=     875. Smpl.=    2995. Fit.= 0.99061
 iteration           26 OBJ=  -1530.90240637747 eff.=     862. Smpl.=    3000. Fit.= 0.98982
 iteration           27 OBJ=  -1526.31435639899 eff.=     808. Smpl.=    2992. Fit.= 0.98906
 iteration           28 OBJ=  -1537.89849011075 eff.=     793. Smpl.=    3000. Fit.= 0.98975
 iteration           29 OBJ=  -1540.28249319135 eff.=     784. Smpl.=    3000. Fit.= 0.99001
 iteration           30 OBJ=  -1553.51733085446 eff.=     750. Smpl.=    3000. Fit.= 0.99049
 iteration           31 OBJ=  -1544.85047526703 eff.=     852. Smpl.=    3000. Fit.= 0.99058
 iteration           32 OBJ=  -1544.30448274947 eff.=     879. Smpl.=    3000. Fit.= 0.98996
 iteration           33 OBJ=  -1550.76091206897 eff.=     733. Smpl.=    3000. Fit.= 0.99084
 iteration           34 OBJ=  -1562.96611121691 eff.=     739. Smpl.=    3000. Fit.= 0.99070
 iteration           35 OBJ=  -1559.65920487663 eff.=     748. Smpl.=    3000. Fit.= 0.99077
 iteration           36 OBJ=  -1538.83016360527 eff.=    1276. Smpl.=    3000. Fit.= 0.98976
 iteration           37 OBJ=  -1559.57706378358 eff.=     787. Smpl.=    3000. Fit.= 0.98987
 iteration           38 OBJ=  -1562.36457487848 eff.=     722. Smpl.=    3000. Fit.= 0.98971
 iteration           39 OBJ=  -1557.98261651618 eff.=     781. Smpl.=    3000. Fit.= 0.98982
 iteration           40 OBJ=  -1565.66520283622 eff.=     792. Smpl.=    3000. Fit.= 0.98951
 iteration           41 OBJ=  -1567.32918775855 eff.=     898. Smpl.=    3000. Fit.= 0.99052
 iteration           42 OBJ=  -1569.88290009236 eff.=    7586. Smpl.=    3000. Fit.= 0.98946
 iteration           43 OBJ=  -1552.53746203648 eff.=    2511. Smpl.=    3000. Fit.= 0.98970
 iteration           44 OBJ=  -1564.84638064030 eff.=     765. Smpl.=    3000. Fit.= 0.98980
 iteration           45 OBJ=  -1574.03888877971 eff.=     742. Smpl.=    3000. Fit.= 0.98944
 iteration           46 OBJ=  -1571.85670869808 eff.=     723. Smpl.=    3000. Fit.= 0.98874
 iteration           47 OBJ=  -1560.10152162637 eff.=   83638. Smpl.=    3000. Fit.= 0.98983
 iteration           48 OBJ=  -1574.31321411723 eff.=     727. Smpl.=    3000. Fit.= 0.98999
 iteration           49 OBJ=  -1562.80222560576 eff.=     737. Smpl.=    2989. Fit.= 0.99014
 iteration           50 OBJ=  -1569.37848989375 eff.=     777. Smpl.=    3000. Fit.= 0.98980
 iteration           51 OBJ=  -1558.73766610616 eff.=    1312. Smpl.=    3000. Fit.= 0.99014
 iteration           52 OBJ=  -1564.32134008146 eff.=     765. Smpl.=    3000. Fit.= 0.99013
 iteration           53 OBJ=  -1567.69854014575 eff.=     710. Smpl.=    3000. Fit.= 0.99021
 iteration           54 OBJ=  -1557.91175785214 eff.=     880. Smpl.=    3000. Fit.= 0.98991
 iteration           55 OBJ=  -1571.64698503251 eff.=     735. Smpl.=    3000. Fit.= 0.99027
 iteration           56 OBJ=  -1567.99275548580 eff.=     979. Smpl.=    3000. Fit.= 0.98975
 iteration           57 OBJ=  -1573.06156009538 eff.=     771. Smpl.=    3000. Fit.= 0.99042
 iteration           58 OBJ=  -1564.33927756801 eff.=     742. Smpl.=    3000. Fit.= 0.98944
 iteration           59 OBJ=  -1571.99232584634 eff.=     697. Smpl.=    2998. Fit.= 0.99042
 iteration           60 OBJ=  -1578.19371459217 eff.=     812. Smpl.=    3000. Fit.= 0.98949
 iteration           61 OBJ=  -1562.91932397394 eff.=    1013. Smpl.=    3000. Fit.= 0.99004
 iteration           62 OBJ=  -1569.64371374630 eff.=     797. Smpl.=    3000. Fit.= 0.98946
 iteration           63 OBJ=  -1577.73168167215 eff.=    5212. Smpl.=    3000. Fit.= 0.99031
 iteration           64 OBJ=  -1555.23558058013 eff.=    8038. Smpl.=    3000. Fit.= 0.98978
 iteration           65 OBJ=  -1559.79847328967 eff.=     697. Smpl.=    3000. Fit.= 0.99031
 iteration           66 OBJ=  -1571.48872793919 eff.=    1602. Smpl.=    3000. Fit.= 0.99001
 iteration           67 OBJ=  -1576.30394311413 eff.=     725. Smpl.=    3000. Fit.= 0.99034
 iteration           68 OBJ=  -1576.83408968971 eff.=    7916. Smpl.=    3000. Fit.= 0.98986
 iteration           69 OBJ=  -1558.90309342931 eff.=     786. Smpl.=    2998. Fit.= 0.98967
 iteration           70 OBJ=  -1577.65896794294 eff.=     841. Smpl.=    3000. Fit.= 0.98964
 iteration           71 OBJ=  -1564.89212705824 eff.=   28790. Smpl.=    3000. Fit.= 0.99012
 iteration           72 OBJ=  -1573.11342883452 eff.=     805. Smpl.=    3000. Fit.= 0.99028
 Convergence achieved
 iteration           72 OBJ=  -1589.48204896261 eff.=     724. Smpl.=    3000. Fit.= 0.98921
 
 #TERM:
 OPTIMIZATION WAS COMPLETED


 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         8.9428E-04 -4.4198E-04 -9.2651E-04  1.7012E-03  7.3919E-03 -8.0952E-03 -1.2639E-02 -2.0965E-02
 SE:             1.8001E-02  1.5171E-02  1.6537E-02  1.4987E-02  1.7875E-02  2.1461E-02  2.7636E-02  2.1653E-02
 N:                     100         100         100         100         100         100         100         100
 
 P VAL.:         9.6038E-01  9.7676E-01  9.5532E-01  9.0962E-01  6.7922E-01  7.0602E-01  6.4743E-01  3.3294E-01
 
 ETASHRINKSD(%)  2.4306E+00  7.0575E+00  1.1377E+01  8.4673E+00  8.2035E+01  7.8431E+01  7.2225E+01  7.8238E+01
 ETASHRINKVR(%)  4.8021E+00  1.3617E+01  2.1459E+01  1.6218E+01  9.6773E+01  9.5348E+01  9.2285E+01  9.5264E+01
 EBVSHRINKSD(%)  2.4936E+00  6.3755E+00  9.8553E+00  9.8768E+00  6.5349E+01  6.9993E+01  7.0474E+01  6.7727E+01
 EBVSHRINKVR(%)  4.9249E+00  1.2344E+01  1.8739E+01  1.8778E+01  8.7993E+01  9.0996E+01  9.1282E+01  8.9584E+01
 EPSSHRINKSD(%)  1.0000E-10
 EPSSHRINKVR(%)  1.0000E-10
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          500
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    918.938533204673     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -1589.48204896261     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -670.543515757936     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                           800
  
 #TERE:
 Elapsed estimation  time in seconds:   707.91

 Number of Negative Eigenvalues in Matrix=           1
 Most negative value=  -8587657.92412205
 Most positive value=   12612852.3345340
 Forcing positive definiteness
 Root mean square deviation of matrix from original=    1.11707554422659

 Elapsed covariance  time in seconds:    11.16
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 #OBJT:**************                        FINAL VALUE OF OBJECTIVE FUNCTION                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************    -1589.482       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         1.68E+00  1.56E+00  8.56E-01  2.43E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        3.44E-02
 
 ETA2
+        1.03E-02  2.69E-02
 
 ETA3
+       -1.48E-02  1.33E-02  3.52E-02
 
 ETA4
+        1.20E-02 -7.23E-03  3.04E-03  2.71E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 
 ETA7
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 
 ETA8
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.27E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        1.85E-01
 
 ETA2
+        3.38E-01  1.64E-01
 
 ETA3
+       -4.25E-01  4.31E-01  1.88E-01
 
 ETA4
+        3.94E-01 -2.68E-01  9.85E-02  1.65E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 
 ETA7
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 
 ETA8
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.13E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                          STANDARD ERROR OF ESTIMATE (R)                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         1.92E-02  1.79E-02  2.18E-02  1.86E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        4.99E-03
 
 ETA2
+        3.74E-03  4.33E-03
 
 ETA3
+        4.07E-03  4.38E-03  5.82E-03
 
 ETA4
+        3.41E-03  3.20E-03  3.77E-03  4.19E-03
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00
 
 ETA7
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00
 
 ETA8
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.42E-03
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        1.34E-02
 
 ETA2
+        1.09E-01  1.32E-02
 
 ETA3
+        8.52E-02  1.10E-01  1.55E-02
 
 ETA4
+        8.95E-02  1.07E-01  1.21E-01  1.27E-02
 
 ETA5
+       ......... ......... ......... ......... .........
 
 ETA6
+       ......... ......... ......... ......... ......... .........
 
 ETA7
+       ......... ......... ......... ......... ......... ......... .........
 
 ETA8
+       ......... ......... ......... ......... ......... ......... ......... .........
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        6.27E-03
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                        COVARIANCE MATRIX OF ESTIMATE (R)                       ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 TH 1
+        3.67E-04
 
 TH 2
+        1.20E-04  3.20E-04
 
 TH 3
+       -1.30E-04  1.63E-04  4.77E-04
 
 TH 4
+        1.43E-04 -5.58E-05  1.07E-04  3.48E-04
 
 OM11
+       -1.49E-06  2.67E-07  2.39E-06  5.40E-07  2.49E-05
 
 OM12
+       -1.64E-06 -3.54E-07  3.36E-06  2.45E-06  7.56E-06  1.40E-05
 
 OM13
+        1.48E-06 -7.30E-07  9.22E-07  1.65E-06 -1.18E-05  4.14E-06  1.65E-05
 
 OM14
+       -1.13E-06  1.17E-06  3.03E-06  9.43E-07  8.41E-06 -1.48E-06 -1.33E-06  1.16E-05
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM17
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM18
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        4.34E-08  3.20E-06 -5.13E-06 -2.18E-06  2.15E-06  5.27E-06  2.68E-06 -1.44E-06  0.00E+00  0.00E+00  0.00E+00  0.00E+00
          1.87E-05
 
 OM23
+        2.25E-06  1.28E-06 -2.70E-06 -3.15E-06 -4.17E-06 -6.15E-06  9.65E-07  9.36E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00
          1.01E-05  1.91E-05
 
 OM24
+        6.35E-08  6.70E-08  1.56E-06  1.98E-06  2.10E-06  3.83E-06  3.01E-06  1.33E-06  0.00E+00  0.00E+00  0.00E+00  0.00E+00
         -4.60E-06 -1.96E-07  1.03E-05
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM27
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 OM28
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... .........
 
 OM33
+       -8.55E-07  8.16E-07  7.14E-08 -2.16E-06  3.55E-06 -7.05E-06 -1.34E-05 -2.39E-06  0.00E+00  0.00E+00  0.00E+00  0.00E+00
          4.64E-06  1.44E-05  2.99E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00  3.38E-05
 
 OM34
+        8.83E-07 -1.18E-06 -3.14E-06  8.08E-07 -5.50E-06  3.01E-06  4.46E-06 -5.69E-06  0.00E+00  0.00E+00  0.00E+00  0.00E+00
         -2.98E-06 -3.73E-06  4.51E-06  0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.90E-06  1.42E-05
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM37
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM38
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        .........
 
 OM44
+       -1.06E-06  1.20E-06  6.07E-07 -1.21E-06  1.93E-06 -2.69E-06  8.27E-08  6.80E-06  0.00E+00  0.00E+00  0.00E+00  0.00E+00
          1.74E-07 -2.13E-06 -5.21E-06  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -3.09E-07  2.06E-06  0.00E+00  0.00E+00  0.00E+00
         0.00E+00  1.76E-05
 
 OM45
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... .........
 
 OM46
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... .........
 
 OM47
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... .........
 
 OM48
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... .........
 
 OM55
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... .........
 
 OM56
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 OM57
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM58
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM66
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM67
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM68
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM77
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM78
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... .........
 
 OM88
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 SG11
+        7.67E-07 -1.29E-07  4.77E-07  6.27E-07 -1.82E-07 -4.57E-07 -7.27E-08 -1.48E-08  0.00E+00  0.00E+00  0.00E+00  0.00E+00
         -4.93E-07  4.34E-08 -8.02E-09  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -7.27E-07 -6.95E-07  0.00E+00  0.00E+00  0.00E+00
         0.00E+00 -7.18E-07  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  0.00E+00  0.00E+00  0.00E+00  2.01E-06
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                        CORRELATION MATRIX OF ESTIMATE (R)                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 TH 1
+        1.92E-02
 
 TH 2
+        3.51E-01  1.79E-02
 
 TH 3
+       -3.11E-01  4.18E-01  2.18E-02
 
 TH 4
+        3.99E-01 -1.67E-01  2.63E-01  1.86E-02
 
 OM11
+       -1.55E-02  2.99E-03  2.19E-02  5.80E-03  4.99E-03
 
 OM12
+       -2.28E-02 -5.29E-03  4.11E-02  3.51E-02  4.05E-01  3.74E-03
 
 OM13
+        1.89E-02 -1.00E-02  1.04E-02  2.18E-02 -5.84E-01  2.72E-01  4.07E-03
 
 OM14
+       -1.73E-02  1.92E-02  4.06E-02  1.48E-02  4.94E-01 -1.16E-01 -9.57E-02  3.41E-03
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM17
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM18
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        5.24E-04  4.14E-02 -5.44E-02 -2.70E-02  9.99E-02  3.26E-01  1.52E-01 -9.78E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00
          4.33E-03
 
 OM23
+        2.68E-02  1.63E-02 -2.83E-02 -3.87E-02 -1.91E-01 -3.76E-01  5.42E-02  6.27E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00
          5.33E-01  4.38E-03
 
 OM24
+        1.03E-03  1.17E-03  2.23E-02  3.31E-02  1.32E-01  3.19E-01  2.31E-01  1.22E-01  0.00E+00  0.00E+00  0.00E+00  0.00E+00
         -3.32E-01 -1.40E-02  3.20E-03
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM27
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 OM28
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... .........
 
 OM33
+       -7.68E-03  7.85E-03  5.62E-04 -1.99E-02  1.22E-01 -3.24E-01 -5.67E-01 -1.20E-01  0.00E+00  0.00E+00  0.00E+00  0.00E+00
          1.84E-01  5.68E-01  1.61E-02  0.00E+00  0.00E+00  0.00E+00  0.00E+00  5.82E-03
 
 OM34
+        1.22E-02 -1.76E-02 -3.81E-02  1.15E-02 -2.92E-01  2.14E-01  2.90E-01 -4.42E-01  0.00E+00  0.00E+00  0.00E+00  0.00E+00
         -1.83E-01 -2.26E-01  3.73E-01  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.32E-01  3.77E-03
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM37
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM38
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        .........
 
 OM44
+       -1.33E-02  1.60E-02  6.63E-03 -1.55E-02  9.26E-02 -1.71E-01  4.85E-03  4.75E-01  0.00E+00  0.00E+00  0.00E+00  0.00E+00
          9.61E-03 -1.16E-01 -3.88E-01  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -1.27E-02  1.30E-01  0.00E+00  0.00E+00  0.00E+00
         0.00E+00  4.19E-03
 
 OM45
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... .........
 
 OM46
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... .........
 
 OM47
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... .........
 
 OM48
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... .........
 
 OM55
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... .........
 
 OM56
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 OM57
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM58
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM66
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM67
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM68
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM77
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM78
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... .........
 
 OM88
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 SG11
+        2.83E-02 -5.11E-03  1.54E-02  2.37E-02 -2.57E-02 -8.63E-02 -1.26E-02 -3.07E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00
         -8.05E-02  7.01E-03 -1.77E-03  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -8.83E-02 -1.30E-01  0.00E+00  0.00E+00  0.00E+00
         0.00E+00 -1.21E-01  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.42E-03
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                               IMPORTANCE SAMPLING                              ********************
 ********************                    INVERSE COVARIANCE MATRIX OF ESTIMATE (R)                   ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 TH 1
+        1.78E+04
 
 TH 2
+       -1.52E+04  1.69E+04
 
 TH 3
+        1.32E+04 -1.28E+04  1.27E+04
 
 TH 4
+       -1.39E+04  1.29E+04 -1.14E+04  1.42E+04
 
 OM11
+       -1.65E+05  1.71E+05 -1.44E+05  1.36E+05  2.27E+06
 
 OM12
+        2.87E+05 -3.00E+05  2.50E+05 -2.36E+05 -1.92E+06  3.93E+05
 
 OM13
+       -2.73E+05  2.85E+05 -2.43E+05  2.24E+05  3.53E+06 -2.99E+06  6.02E+06
 
 OM14
+        2.60E+05 -2.70E+05  2.28E+05 -2.18E+05 -1.43E+06 -8.93E+04 -2.02E+06  7.45E+05
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM17
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM18
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -1.18E+05  1.26E+05 -1.04E+05  9.76E+04 -2.97E+05  1.54E+06 -4.99E+05  1.49E+06  0.00E+00  0.00E+00  0.00E+00  0.00E+00
         -1.20E+06
 
 OM23
+        2.34E+05 -2.48E+05  2.09E+05 -1.92E+05 -1.26E+06 -1.05E+05 -2.34E+06 -5.47E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00
          1.35E+06 -5.92E+03
 
 OM24
+       -2.23E+05  2.35E+05 -1.97E+05  1.87E+05 -4.93E+05  2.66E+06 -9.92E+05  1.58E+06  0.00E+00  0.00E+00  0.00E+00  0.00E+00
         -2.17E+06  2.48E+06 -2.80E+06
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM27
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 OM28
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... .........
 
 OM33
+       -1.14E+05  1.20E+05 -1.04E+05  9.30E+04  1.32E+06 -1.06E+06  2.46E+06 -6.14E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00
         -2.52E+05 -1.02E+06 -5.47E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.13E+06
 
 OM34
+        2.13E+05 -2.24E+05  1.91E+05 -1.78E+05 -8.89E+05 -4.08E+05 -1.56E+06  1.66E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00
          1.30E+06 -4.01E+05  1.51E+06  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -6.29E+05  1.43E+05
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM37
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM38
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        .........
 
 OM44
+       -1.02E+05  1.06E+05 -8.99E+04  8.67E+04 -1.80E+05  1.13E+06 -4.50E+05  2.41E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00
         -9.45E+05  1.11E+06 -8.66E+05  0.00E+00  0.00E+00  0.00E+00  0.00E+00 -2.73E+05  3.52E+05  0.00E+00  0.00E+00  0.00E+00
         0.00E+00 -8.37E+03
 
 OM45
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... .........
 
 OM46
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... .........
 
 OM47
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... .........
 
 OM48
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... .........
 
 OM55
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... .........
 
 OM56
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 OM57
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM58
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM66
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM67
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM68
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM77
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM78
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... .........
 
 OM88
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 SG11
+       -2.97E+03  2.53E+03 -2.69E+03  1.27E+03  9.97E+03 -3.73E+04  6.65E+04 -1.51E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00
          5.11E+04 -9.12E+04  4.43E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  6.25E+04 -3.38E+04  0.00E+00  0.00E+00  0.00E+00
         0.00E+00  2.71E+04  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00
          0.00E+00  0.00E+00  0.00E+00  0.00E+00  5.30E+05
 
1
 
 
 #TBLN:      2
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
 INITIAL ETA FOR MAP ESTIMATION (MCETA):    10
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      9
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     9
 NOPRIOR SETTING (NOPRIOR):                 OFF
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          ON
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      ON
 RAW OUTPUT FILE (FILE): tdist15.ext
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

 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 MONITORING OF SEARCH:

 
0ITERATION NO.:    0    OBJECTIVE VALUE:  -1606.58690274283        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:       16
 NPARAMETR:  1.6791E+00  1.5643E+00  8.5603E-01  2.4303E+00  3.4382E-02  1.0285E-02 -1.4770E-02  1.2033E-02  2.6914E-02  1.3265E-02
            -7.2259E-03  3.5173E-02  3.0386E-03  2.7079E-02  1.2749E-02
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
            -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:  -5.7970E+02 -5.1308E+02  6.9818E+02  1.7100E+03  7.1397E+01 -3.5145E+02  2.9970E+02 -3.4651E+02  5.3371E+00 -1.1771E+02
             1.9361E+02 -3.3344E+01  4.4635E+02  8.9435E+00  7.2136E+01
 
0ITERATION NO.:    1    OBJECTIVE VALUE:  -1606.58690274283        NO. OF FUNC. EVALS.:  46
 CUMULATIVE NO. OF FUNC. EVALS.:       62
 NPARAMETR:  1.6791E+00  1.5643E+00  8.5603E-01  2.4303E+00  3.4382E-02  1.0285E-02 -1.4770E-02  1.2033E-02  2.6914E-02  1.3265E-02
            -7.2259E-03  3.5173E-02  3.0386E-03  2.7079E-02  1.2749E-02
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
            -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:  -7.4352E+02 -4.8125E+02  5.3163E+02  1.8903E+03  5.2634E+01 -3.8762E+02  3.4083E+02 -3.7388E+02  3.7787E+00 -1.0733E+02
             1.6466E+02 -2.2881E+01  4.2319E+02  6.5175E+00  6.3408E+01
 
0ITERATION NO.:    2    OBJECTIVE VALUE:  -1606.58690274283        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:       78
 NPARAMETR:  1.6791E+00  1.5643E+00  8.5602E-01  2.4302E+00  3.4382E-02  1.0285E-02 -1.4770E-02  1.2033E-02  2.6914E-02  1.3265E-02
            -7.2259E-03  3.5173E-02  3.0384E-03  2.7078E-02  1.2749E-02
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01 -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
            -1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:  -7.4352E+02 -4.8125E+02  5.3163E+02  1.8903E+03  5.2634E+01 -3.8762E+02  3.4083E+02 -3.7388E+02  3.7787E+00 -1.0733E+02
             1.6466E+02 -2.2881E+01  4.2319E+02  6.5175E+00  6.3408E+01
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 HOWEVER, PROBLEMS OCCURRED WITH THE MINIMIZATION.
 REGARD THE RESULTS OF THE ESTIMATION STEP CAREFULLY, AND ACCEPT THEM ONLY
 AFTER CHECKING THAT THE COVARIANCE STEP PRODUCES REASONABLE OUTPUT.
 NO. OF FUNCTION EVALUATIONS USED:       78
 NO. OF SIG. DIGITS IN FINAL EST.:  5.3

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         2.2238E-03 -1.7470E-03 -1.0330E-02 -5.8043E-03 -4.0283E-02  3.0731E-02  2.0761E-02  2.7868E-02
 SE:             2.0057E-02  1.7564E-02  1.9424E-02  1.7339E-02  2.8198E-02  3.0577E-02  2.4102E-02  2.7728E-02
 N:                     100         100         100         100         100         100         100         100
 
 P VAL.:         9.1171E-01  9.2077E-01  5.9486E-01  7.3781E-01  1.5313E-01  3.1488E-01  3.8902E-01  3.1488E-01
 
 ETASHRINKSD(%)  1.0000E-10  1.0000E-10  1.0000E-10  1.0000E-10  7.1660E+01  6.9269E+01  7.5777E+01  7.2132E+01
 ETASHRINKVR(%)  1.0000E-10  1.0000E-10  1.0000E-10  1.0000E-10  9.1968E+01  9.0556E+01  9.4132E+01  9.2234E+01
 EBVSHRINKSD(%)  2.9664E+00  7.0256E+00  1.3196E+01  1.2540E+01  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 EBVSHRINKVR(%)  5.8448E+00  1.3558E+01  2.4651E+01  2.3507E+01  1.0000E+02  1.0000E+02  1.0000E+02  1.0000E+02
 EPSSHRINKSD(%)  3.4877E+01
 EPSSHRINKVR(%)  5.7590E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          500
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    918.938533204673     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:   -1606.58690274283     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:      -687.648369538154     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                           800
  
 #TERE:
 Elapsed estimation  time in seconds:     8.06
 Elapsed covariance  time in seconds:    86.12
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************    -1606.587       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         1.68E+00  1.56E+00  8.56E-01  2.43E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        3.44E-02
 
 ETA2
+        1.03E-02  2.69E-02
 
 ETA3
+       -1.48E-02  1.33E-02  3.52E-02
 
 ETA4
+        1.20E-02 -7.23E-03  3.04E-03  2.71E-02
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 
 ETA7
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 
 ETA8
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        1.27E-02
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        1.85E-01
 
 ETA2
+        3.38E-01  1.64E-01
 
 ETA3
+       -4.25E-01  4.31E-01  1.88E-01
 
 ETA4
+        3.94E-01 -2.68E-01  9.85E-02  1.65E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 
 ETA6
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 
 ETA7
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 
 ETA8
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.00E+00
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        1.13E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         1.69E+01  2.59E-01  3.16E-01  1.39E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        1.05E-04
 
 ETA2
+        3.73E-05  2.39E-05
 
 ETA3
+        3.00E-04  9.13E-05  3.23E-04
 
 ETA4
+        1.29E-05  9.91E-06  1.55E-04  1.96E-05
 
 ETA5
+       ......... ......... ......... ......... .........
 
 ETA6
+       ......... ......... ......... ......... ......... .........
 
 ETA7
+       ......... ......... ......... ......... ......... ......... .........
 
 ETA8
+       ......... ......... ......... ......... ......... ......... ......... .........
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        4.85E-08
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5      ETA6      ETA7      ETA8     
 
 ETA1
+        2.83E-04
 
 ETA2
+        1.59E-03  7.28E-05
 
 ETA3
+        7.32E-03  5.13E-03  8.61E-04
 
 ETA4
+        8.16E-05  2.46E-04  5.51E-03  5.94E-05
 
 ETA5
+       ......... ......... ......... ......... .........
 
 ETA6
+       ......... ......... ......... ......... ......... .........
 
 ETA7
+       ......... ......... ......... ......... ......... ......... .........
 
 ETA8
+       ......... ......... ......... ......... ......... ......... ......... .........
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        2.15E-07
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 TH 1
+        2.87E+02
 
 TH 2
+       -4.40E+00  6.73E-02
 
 TH 3
+        5.36E+00 -8.20E-02  9.99E-02
 
 TH 4
+       -2.35E-01  3.60E-03 -4.38E-03  1.92E-04
 
 OM11
+       -1.78E-03  2.72E-05 -3.32E-05  1.46E-06  1.10E-08
 
 OM12
+        6.30E-04 -9.65E-06  1.18E-05 -5.15E-07 -3.90E-09  1.39E-09
 
 OM13
+       -5.07E-03  7.76E-05 -9.45E-05  4.15E-06  3.14E-08 -1.11E-08  8.99E-08
 
 OM14
+       -2.19E-04  3.35E-06 -4.08E-06  1.79E-07  1.36E-09 -4.79E-10  3.86E-09  1.67E-10
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM17
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM18
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        4.04E-04 -6.18E-06  7.53E-06 -3.30E-07 -2.50E-09  8.89E-10 -7.13E-09 -3.07E-10 ......... ......... ......... .........
          5.71E-10
 
 OM23
+       -1.54E-03  2.36E-05 -2.87E-05  1.26E-06  9.54E-09 -3.38E-09  2.73E-08  1.17E-09 ......... ......... ......... .........
         -2.17E-09  8.33E-09
 
 OM24
+       -1.12E-04  1.71E-06 -2.09E-06  9.16E-08  6.94E-10 -2.44E-10  1.98E-09  8.53E-11 ......... ......... ......... .........
         -1.56E-10  6.00E-10  9.81E-11
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM27
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 OM28
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... .........
 
 OM33
+        5.46E-03 -8.36E-05  1.02E-04 -4.47E-06 -3.38E-08  1.20E-08 -9.67E-08 -4.16E-09 ......... ......... ......... .........
          7.68E-09 -2.93E-08 -2.13E-09 ......... ......... ......... .........  1.04E-07
 
 OM34
+       -2.62E-03  4.02E-05 -4.89E-05  2.14E-06  1.63E-08 -5.76E-09  4.64E-08  2.00E-09 ......... ......... ......... .........
         -3.69E-09  1.41E-08  1.06E-09 ......... ......... ......... ......... -5.00E-08  2.40E-08
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM37
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM38
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        .........
 
 OM44
+        2.98E-04 -4.57E-06  5.57E-06 -2.44E-07 -1.85E-09  6.55E-10 -5.27E-09 -2.27E-10 ......... ......... ......... .........
          4.20E-10 -1.60E-09 -1.65E-10 ......... ......... ......... .........  5.67E-09 -2.75E-09 ......... ......... .........
        .........  3.83E-10
 
 OM45
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... .........
 
 OM46
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... .........
 
 OM47
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... .........
 
 OM48
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... .........
 
 OM55
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... .........
 
 OM56
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 OM57
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM58
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM66
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM67
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM68
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM77
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM78
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... .........
 
 OM88
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 SG11
+        5.81E-07 -8.89E-09  1.08E-08 -4.75E-10 -3.60E-12  1.27E-12 -1.02E-11 -4.42E-13 ......... ......... ......... .........
          8.16E-13 -3.11E-12 -2.26E-13 ......... ......... ......... .........  1.10E-11 -5.30E-12 ......... ......... .........
        .........  6.03E-13 ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........  2.35E-15
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 TH 1
+        1.69E+01
 
 TH 2
+       -1.00E+00  2.59E-01
 
 TH 3
+        1.00E+00 -1.00E+00  3.16E-01
 
 TH 4
+       -1.00E+00  1.00E+00 -1.00E+00  1.39E-02
 
 OM11
+       -9.99E-01  9.99E-01 -9.99E-01  9.99E-01  1.05E-04
 
 OM12
+        9.98E-01 -9.98E-01  9.98E-01 -9.98E-01 -9.97E-01  3.73E-05
 
 OM13
+       -9.98E-01  9.98E-01 -9.98E-01  9.97E-01  9.97E-01 -9.96E-01  3.00E-04
 
 OM14
+       -9.98E-01  9.98E-01 -9.98E-01  9.98E-01  9.99E-01 -9.96E-01  9.96E-01  1.29E-05
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM17
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM18
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        9.97E-01 -9.97E-01  9.97E-01 -9.97E-01 -9.97E-01  9.99E-01 -9.95E-01 -9.96E-01 ......... ......... ......... .........
          2.39E-05
 
 OM23
+       -9.96E-01  9.96E-01 -9.96E-01  9.96E-01  9.95E-01 -9.94E-01  9.98E-01  9.94E-01 ......... ......... ......... .........
         -9.94E-01  9.13E-05
 
 OM24
+       -6.67E-01  6.67E-01 -6.67E-01  6.67E-01  6.67E-01 -6.60E-01  6.66E-01  6.66E-01 ......... ......... ......... .........
         -6.61E-01  6.63E-01  9.91E-06
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM27
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 OM28
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... .........
 
 OM33
+        9.98E-01 -9.98E-01  9.98E-01 -9.98E-01 -9.98E-01  9.96E-01 -1.00E+00 -9.96E-01 ......... ......... ......... .........
          9.96E-01 -9.96E-01 -6.66E-01 ......... ......... ......... .........  3.23E-04
 
 OM34
+       -9.98E-01  9.98E-01 -9.98E-01  9.98E-01  9.98E-01 -9.96E-01  9.99E-01  9.96E-01 ......... ......... ......... .........
         -9.95E-01  9.96E-01  6.92E-01 ......... ......... ......... ......... -9.99E-01  1.55E-04
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM37
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM38
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        .........
 
 OM44
+        9.00E-01 -9.00E-01  9.00E-01 -9.00E-01 -9.00E-01  8.98E-01 -8.98E-01 -8.98E-01 ......... ......... ......... .........
          8.98E-01 -8.97E-01 -8.52E-01 ......... ......... ......... .........  8.99E-01 -9.07E-01 ......... ......... .........
        .........  1.96E-05
 
 OM45
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... .........
 
 OM46
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... .........
 
 OM47
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... .........
 
 OM48
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... .........
 
 OM55
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... .........
 
 OM56
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 OM57
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM58
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM66
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM67
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM68
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM77
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM78
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... .........
 
 OM88
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 SG11
+        7.07E-01 -7.07E-01  7.07E-01 -7.07E-01 -7.07E-01  7.06E-01 -7.05E-01 -7.06E-01 ......... ......... ......... .........
          7.05E-01 -7.04E-01 -4.72E-01 ......... ......... ......... .........  7.06E-01 -7.06E-01 ......... ......... .........
        .........  6.37E-01 ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........  4.85E-08
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************                LAPLACIAN CONDITIONAL ESTIMATION WITH INTERACTION               ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 TH 1
+        7.60E+01
 
 TH 2
+        2.54E+03  1.66E+05
 
 TH 3
+       -1.27E+03  1.42E+02  6.93E+04
 
 TH 4
+        8.29E+03 -7.29E+03  1.83E+03  1.03E+07
 
 OM11
+        3.12E+06 -8.45E+04  1.12E+06 -1.98E+05  1.78E+14
 
 OM12
+       -5.92E+06  1.57E+05  1.31E+06  3.86E+05 -4.05E+14  9.23E+14
 
 OM13
+        6.75E+06 -8.38E+04  7.34E+05 -2.21E+05  5.46E+14 -1.24E+15  1.67E+15
 
 OM14
+       -1.42E+06  1.61E+05 -8.62E+04  3.94E+05 -1.53E+12  1.72E+12 -1.48E+12  5.39E+12
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM16
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM17
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM18
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        3.36E+06 -5.79E+04 -1.40E+06 -1.66E+05  2.31E+14 -5.26E+14  7.08E+14 -9.08E+11 ......... ......... ......... .........
          3.00E+14
 
 OM23
+       -7.66E+06  5.65E+04 -5.57E+05  1.82E+05 -6.22E+14  1.42E+15 -1.91E+15  1.56E+12 ......... ......... ......... .........
         -8.06E+14  2.17E+15
 
 OM24
+        1.45E+05 -9.81E+04  7.95E+04 -3.03E+05  8.81E+11 -1.85E+12  1.58E+12 -1.46E+12 ......... ......... ......... .........
          9.73E+11 -1.66E+12  1.57E+12
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM26
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM27
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 OM28
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... .........
 
 OM33
+        5.11E+06 -1.96E+04  1.57E+04 -5.99E+04  4.19E+14 -9.53E+14  1.28E+15 -6.58E+11 ......... ......... ......... .........
          5.43E+14 -1.46E+15  7.04E+11 ......... ......... ......... .........  9.86E+14
 
 OM34
+       -7.93E+04  5.14E+04 -4.28E+04  1.74E+05 -7.79E+11  1.63E+12 -1.41E+12  1.27E+12 ......... ......... ......... .........
         -8.62E+11  1.49E+12 -1.36E+12 ......... ......... ......... ......... -6.30E+11  1.22E+12
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM36
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM37
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM38
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        .........
 
 OM44
+        6.11E+04 -4.86E+04  3.39E+04 -1.44E+05  3.31E+11 -6.89E+11  5.84E+11 -5.60E+11 ......... ......... ......... .........
          3.63E+11 -6.15E+11  5.95E+11 ......... ......... ......... .........  2.60E+11 -5.04E+11 ......... ......... .........
        .........  2.44E+11
 
 OM45
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... .........
 
 OM46
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... .........
 
 OM47
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... .........
 
 OM48
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... .........
 
 OM55
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... .........
 
 OM56
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM15      OM16      OM17      OM18  
             OM22      OM23      OM24      OM25      OM26      OM27      OM28      OM33      OM34      OM35      OM36      OM37  
            OM38      OM44      OM45      OM46      OM47      OM48      OM55      OM56      OM57      OM58      OM66      OM67  
             OM68      OM77      OM78      OM88      SG11  
 
 OM57
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM58
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM66
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM67
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM68
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM77
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM78
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... .........
 
 OM88
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
        ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 SG11
+       -1.73E+06 -4.03E+04  3.50E+04 -2.63E+04 -1.52E+10  3.25E+10 -2.68E+10  2.59E+10 ......... ......... ......... .........
         -1.72E+10  2.82E+10 -2.73E+10 ......... ......... ......... ......... -1.20E+10  2.31E+10 ......... ......... .........
        ......... -1.12E+10 ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........  8.52E+14
 
 Elapsed finaloutput time in seconds:     0.05
1THERE ARE ERROR MESSAGES IN FILE PRDERR                                                                  
 #CPUT: Total CPU Time in Seconds,      797.774
Stop Time: 
Sun 01/07/2018 
07:59 PM
