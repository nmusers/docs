Mon 03/20/2023 
07:09 PM
$PROBLEM Log Linear Model Visual Acuity
$INPUT C ID TIME DOSEQ MDV DV 
$DATA ed50s_fit.dat ignore=@

$PRED
MU_1=LOG(THETA(1))
MU_2=LOG(THETA(2))
MU_3=LOG(THETA(3))
MU_4=LOG(THETA(4))

IF(MDV==1) THEN
DOSE=DOSEQ
ELSE
DOSE=DOSE
ENDIF

VA0=EXP(MU_1+ETA(1))
KK=EXP(MU_2+ETA(2))
BETA=EXP(MU_3+ETA(3))

ALPHALL=EXP(MU_4+ETA(4))

EE=ALPHALL*LOG(DOSE+1.0)

IPRED=VA0+(1.0-EXP(-KK*TIME))*(EE-BETA*VA0)
Y=IPRED + EPS(1)

$THETA
55.0     ;[VA0]
0.005    ;[KK]
0.2      ; [BETA]
3.5     ; ALPHALL]

$OMEGA 0.07 0.5 1.0 0.122
$SIGMA 28.0

$EST METHOD=1 INTERACTION MAXEVAL=999 PRINT=1 NOHABORT
$COV MATRIX=R PRINT=E UNCONDITIONAL

  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
  
Note: Analytical 2nd Derivatives are constructed in FSUBS but are never used.
      You may insert $ABBR DERIV2=NO after the first $PROB to save FSUBS construction and compilation time
  
  
License Registered to: NONMEM license (with RADAR5NM) for ICON Pharmacometrics Team
Expiration Date:    31 DEC 2030
Current Date:       20 MAR 2023
Days until program expires :2836
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.2
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 Log Linear Model Visual Acuity
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 CREATE/ADD TO FDATA.csv:        YES
 NO. OF DATA RECS IN DATA SET:     1200
 NO. OF DATA ITEMS IN DATA SET:   6
 ID DATA ITEM IS DATA ITEM NO.:   2
 DEP VARIABLE IS DATA ITEM NO.:   6
 MDV DATA ITEM IS DATA ITEM NO.:  5
0LABELS FOR DATA ITEMS:
 C ID TIME DOSEQ MDV DV
0FORMAT FOR DATA:
 (6E12.0)

 TOT. NO. OF OBS RECS:      900
 TOT. NO. OF INDIVIDUALS:      300
0LENGTH OF THETA:   4
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   4
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.5500E+02  0.5000E-02  0.2000E+00  0.3500E+01
0INITIAL ESTIMATE OF OMEGA:
 0.7000E-01
 0.0000E+00   0.5000E+00
 0.0000E+00   0.0000E+00   0.1000E+01
 0.0000E+00   0.0000E+00   0.0000E+00   0.1220E+00
0INITIAL ESTIMATE OF SIGMA:
 0.2800E+02
0COVARIANCE STEP OMITTED:        NO
 R MATRIX SUBSTITUTED:          YES
 S MATRIX SUBSTITUTED:           NO
 EIGENVLS. PRINTED:             YES
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
1
 
 
 #TBLN:      1
 #METH: First Order Conditional Estimation with Interaction
 
 ESTIMATION STEP OMITTED:                 NO
 SHRINK INFO WITH EVALUATION (EVALSHRINK) NO
 ANALYSIS TYPE:                           POPULATION
 NUMBER OF SADDLE POINT RESET ITERATIONS:      0
 GRADIENT METHOD USED:               NOSLOW
 CONDITIONAL ESTIMATES USED:              YES
 CENTERED ETA:                            NO
 EPS-ETA INTERACTION:                     YES
 LAPLACIAN OBJ. FUNC.:                    NO
 NO. OF FUNCT. EVALS. ALLOWED:            999
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
 SIGDIGITS FOR MAP ESTIMATION (SIGLO):      100
 GRADIENT SIGDIGITS OF
       FIXED EFFECTS PARAMETERS (SIGL):     100
 NOPRIOR SETTING (NOPRIOR):                 0
 NOCOV SETTING (NOCOV):                     OFF
 DERCONT SETTING (DERCONT):                 OFF
 FINAL ETA RE-EVALUATION (FNLETA):          1
 EXCLUDE NON-INFLUENTIAL (NON-INFL.) ETAS
       IN SHRINKAGE (ETASTYPE):             NO
 NON-INFL. ETA CORRECTION (NONINFETA):      0
 RAW OUTPUT FILE (FILE): llinear_fit.ext
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

 
 THE FOLLOWING LABELS ARE EQUIVALENT
 PRED=PREDI
 RES=RESI
 WRES=WRESI
 IWRS=IWRESI
 IPRD=IPREDI
 IRS=IRESI
 
 MONITORING OF SEARCH:

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   5621.29512691739        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:        7
 NPARAMETR:  5.5000E+01  5.0000E-03  2.0000E-01  3.5000E+00  7.0000E-02  5.0000E-01  1.0000E+00  1.2200E-01  2.8000E+01
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:   2.0266E+03 -1.3349E+02 -7.3836E+02  2.1136E+02 -8.5495E+01  1.7108E+01  4.0716E+01 -8.4261E+01 -8.9548E+01
 
0ITERATION NO.:    1    OBJECTIVE VALUE:   5619.71440736004        NO. OF FUNC. EVALS.:  13
 CUMULATIVE NO. OF FUNC. EVALS.:       20
 NPARAMETR:  5.3844E+01  5.0069E-03  2.0153E-01  3.4923E+00  7.0012E-02  4.9998E-01  9.9992E-01  1.2202E-01  2.8005E+01
 PARAMETER:  9.7898E-02  1.0014E-01  1.0077E-01  9.9781E-02  1.0009E-01  9.9982E-02  9.9958E-02  1.0009E-01  1.0009E-01
 GRADIENT:   4.3027E+02 -1.2449E+02 -6.6477E+02  1.4175E+02 -8.8343E+01  1.6926E+01  4.2038E+01 -8.5699E+01 -9.0735E+01
 
0ITERATION NO.:    2    OBJECTIVE VALUE:   5619.50939935066        NO. OF FUNC. EVALS.:  12
 CUMULATIVE NO. OF FUNC. EVALS.:       32
 NPARAMETR:  5.2954E+01  5.0303E-03  2.0653E-01  3.4737E+00  7.0059E-02  4.9992E-01  9.9960E-01  1.2210E-01  2.8024E+01
 PARAMETER:  9.6280E-02  1.0061E-01  1.0327E-01  9.9248E-02  1.0042E-01  9.9919E-02  9.9800E-02  1.0041E-01  1.0043E-01
 GRADIENT:  -9.0498E+02 -1.0872E+02 -5.1337E+02  1.3372E+01 -9.4187E+01  1.6854E+01  4.8533E+01 -8.7731E+01 -9.1591E+01
 
0ITERATION NO.:    3    OBJECTIVE VALUE:   5612.19090841162        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       41
 NPARAMETR:  5.4054E+01  5.1815E-03  2.3751E-01  3.3908E+00  7.0383E-02  4.9949E-01  9.9733E-01  1.2264E-01  2.8155E+01
 PARAMETER:  9.8279E-02  1.0363E-01  1.1876E-01  9.6879E-02  1.0273E-01  9.9487E-02  9.8664E-02  1.0262E-01  1.0276E-01
 GRADIENT:   4.2044E+02 -4.0439E+01  7.8109E+01 -4.8368E+02 -7.9860E+01  1.7639E+01  8.3321E+01 -9.3417E+01 -8.7542E+01
 
0ITERATION NO.:    4    OBJECTIVE VALUE:   5609.27830341405        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       50
 NPARAMETR:  5.4029E+01  5.3952E-03  2.6140E-01  3.8994E+00  7.1095E-02  4.9847E-01  9.8950E-01  1.2395E-01  2.8452E+01
 PARAMETER:  9.8235E-02  1.0790E-01  1.3070E-01  1.1141E-01  1.0776E-01  9.8470E-02  9.4720E-02  1.0795E-01  1.0800E-01
 GRADIENT:   4.4662E+02  9.6706E+01  1.1902E+02  3.4833E+02 -7.4965E+01  1.8197E+01  1.1074E+02 -5.4313E+01 -6.4305E+01
 
0ITERATION NO.:    5    OBJECTIVE VALUE:   5592.00949387694        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       58
 NPARAMETR:  5.3659E+01  4.3541E-03  2.7724E-01  3.8340E+00  9.1824E-02  4.7136E-01  7.4474E-01  1.5641E-01  3.6309E+01
 PARAMETER:  9.7561E-02  8.7082E-02  1.3862E-01  1.0954E-01  2.3569E-01  7.0508E-02 -4.7360E-02  2.2423E-01  2.2993E-01
 GRADIENT:   9.2989E+01 -2.2261E+02  1.1660E+02  2.1311E+02  5.7807E+01  1.7973E+01  6.1755E+01 -4.1346E+01  6.4222E+01
 
0ITERATION NO.:    6    OBJECTIVE VALUE:   5589.06530533128        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       67
 NPARAMETR:  5.3606E+01  5.3566E-03  2.6942E-01  3.7003E+00  9.4892E-02  4.6549E-01  7.0361E-01  1.6410E-01  3.7430E+01
 PARAMETER:  9.7466E-02  1.0713E-01  1.3471E-01  1.0572E-01  2.5212E-01  6.4244E-02 -7.5762E-02  2.4822E-01  2.4514E-01
 GRADIENT:  -1.3813E+01  4.6290E+01  1.0309E+02  1.8480E+02  7.0312E+01  2.6203E+01  4.7813E+01 -4.2583E+01  8.3317E+01
 
0ITERATION NO.:    7    OBJECTIVE VALUE:   5575.74264240670        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       75
 NPARAMETR:  5.3926E+01  5.3460E-03  2.9705E-01  3.6031E+00  8.6988E-02  3.8638E-01  4.4660E-01  2.7145E-01  3.2602E+01
 PARAMETER:  9.8048E-02  1.0692E-01  1.4852E-01  1.0295E-01  2.0864E-01 -2.8892E-02 -3.0305E-01  4.9988E-01  1.7609E-01
 GRADIENT:  -7.0031E+01  4.8806E+01  2.3951E+02  1.5334E+02  3.1546E+01  1.6396E+01 -4.7808E+01 -8.7068E+00 -1.4780E+01
 
0ITERATION NO.:    8    OBJECTIVE VALUE:   5571.10372189571        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       83
 NPARAMETR:  5.4021E+01  5.4943E-03  2.7832E-01  3.2120E+00  7.7405E-02  3.2488E-01  4.8142E-01  3.9553E-01  3.6112E+01
 PARAMETER:  9.8221E-02  1.0989E-01  1.3916E-01  9.1772E-02  1.5028E-01 -1.1557E-01 -2.6550E-01  6.8811E-01  2.2721E-01
 GRADIENT:  -2.0420E+02  5.5660E+01  2.3869E+02  1.3024E+02 -1.4640E+01  1.5674E+01 -3.1052E+01  1.6104E+01  3.5769E+01
 
0ITERATION NO.:    9    OBJECTIVE VALUE:   5569.34026374804        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       92
 NPARAMETR:  5.3879E+01  5.6839E-03  2.6523E-01  3.0309E+00  8.3301E-02  2.8668E-01  5.2465E-01  4.6957E-01  3.4188E+01
 PARAMETER:  9.7962E-02  1.1368E-01  1.3262E-01  8.6597E-02  1.8698E-01 -1.7812E-01 -2.2251E-01  7.7390E-01  1.9984E-01
 GRADIENT:  -1.5928E+02  8.8912E+01  2.4656E+02  1.5115E+02  1.4254E+01  1.1429E+01 -1.9226E+01  2.7272E+01  9.9084E+00
 
0ITERATION NO.:   10    OBJECTIVE VALUE:   5569.02266317759        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:      100
 NPARAMETR:  5.3949E+01  6.3054E-03  2.6627E-01  3.1112E+00  8.1978E-02  9.8457E-02  5.0760E-01  3.8070E-01  3.7213E+01
 PARAMETER:  9.8089E-02  1.2611E-01  1.3314E-01  8.8892E-02  1.7898E-01 -7.1249E-01 -2.3903E-01  6.6900E-01  2.4223E-01
 GRADIENT:  -2.3752E+02  2.4461E+02  2.0636E+02  9.4055E+01  8.7623E+00 -3.8614E+00 -2.2643E+01  8.0758E+00  1.8835E+01
 
0ITERATION NO.:   11    OBJECTIVE VALUE:   5565.12673807690        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:      110
 NPARAMETR:  5.3889E+01  5.8200E-03  2.4025E-01  2.8968E+00  8.1663E-02  1.4195E-01  6.0963E-01  4.0154E-01  3.4942E+01
 PARAMETER:  9.7979E-02  1.1640E-01  1.2013E-01  8.2765E-02  1.7705E-01 -5.2958E-01 -1.4745E-01  6.9564E-01  2.1074E-01
 GRADIENT:  -3.6164E+01  5.2523E+01  1.9960E+01  5.4501E+01  3.6232E+00 -1.7631E+00 -4.7279E+00  9.0889E-01  1.5324E+00
 
0ITERATION NO.:   12    OBJECTIVE VALUE:   5565.10679171713        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:      119
 NPARAMETR:  5.3887E+01  5.7847E-03  2.3856E-01  2.8730E+00  8.1520E-02  1.4783E-01  6.1686E-01  4.0600E-01  3.4816E+01
 PARAMETER:  9.7976E-02  1.1569E-01  1.1928E-01  8.2087E-02  1.7618E-01 -5.0928E-01 -1.4156E-01  7.0117E-01  2.0894E-01
 GRADIENT:  -2.6350E+01  3.8966E+01  1.2960E+01  4.2258E+01  2.7279E+00 -1.3429E+00 -3.7266E+00  6.9308E-01  1.0235E+00
 
0ITERATION NO.:   13    OBJECTIVE VALUE:   5565.10646597159        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:      127
 NPARAMETR:  5.3887E+01  5.7795E-03  2.3833E-01  2.8694E+00  8.1498E-02  1.4876E-01  6.1801E-01  4.0667E-01  3.4798E+01
 PARAMETER:  9.7976E-02  1.1559E-01  1.1916E-01  8.1984E-02  1.7604E-01 -5.0615E-01 -1.4063E-01  7.0199E-01  2.0868E-01
 GRADIENT:  -2.4999E+01  3.7010E+01  1.2323E+01  4.0180E+01  2.5921E+00 -1.2744E+00 -3.5352E+00  6.5880E-01  9.7275E-01
 
0ITERATION NO.:   14    OBJECTIVE VALUE:   5565.10646597159        NO. OF FUNC. EVALS.:  17
 CUMULATIVE NO. OF FUNC. EVALS.:      144
 NPARAMETR:  5.3887E+01  5.7795E-03  2.3833E-01  2.8694E+00  8.1498E-02  1.4876E-01  6.1801E-01  4.0667E-01  3.4798E+01
 PARAMETER:  9.7976E-02  1.1559E-01  1.1916E-01  8.1984E-02  1.7604E-01 -5.0615E-01 -1.4063E-01  7.0199E-01  2.0868E-01
 GRADIENT:  -7.0334E+02  3.0820E+01 -6.6759E+01 -2.2916E+01  2.5921E+00 -1.2744E+00 -3.5352E+00  6.5880E-01  5.9725E-01
 
0ITERATION NO.:   15    OBJECTIVE VALUE:   5564.50050786420        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      162
 NPARAMETR:  5.4306E+01  5.6355E-03  2.4778E-01  2.9714E+00  8.0349E-02  1.5845E-01  6.0654E-01  3.8415E-01  3.4811E+01
 PARAMETER:  9.8738E-02  1.1271E-01  1.2389E-01  8.4896E-02  1.6894E-01 -4.7460E-01 -1.4999E-01  6.7351E-01  2.0887E-01
 GRADIENT:  -2.3615E+02 -9.7507E+00  4.0840E+00  4.7137E-01 -9.2218E-01 -7.2055E-01  1.1305E+00  2.7480E-01  2.0333E+00
 
0ITERATION NO.:   16    OBJECTIVE VALUE:   5564.44348813781        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:      178
 NPARAMETR:  5.4503E+01  5.6576E-03  2.4823E-01  2.9727E+00  8.0266E-02  1.6687E-01  6.0303E-01  3.8324E-01  3.4611E+01
 PARAMETER:  9.9096E-02  1.1315E-01  1.2412E-01  8.4935E-02  1.6842E-01 -4.4870E-01 -1.5289E-01  6.7231E-01  2.0599E-01
 GRADIENT:  -1.2489E+00  2.0790E+00  1.1681E+00 -6.7466E-01 -8.7305E-01  3.9842E-02  7.1963E-02  5.9001E-02  5.2499E-02
 
0ITERATION NO.:   17    OBJECTIVE VALUE:   5564.44291774665        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:      194
 NPARAMETR:  5.4502E+01  5.6528E-03  2.4824E-01  2.9740E+00  8.0423E-02  1.6670E-01  6.0294E-01  3.8281E-01  3.4606E+01
 PARAMETER:  9.9094E-02  1.1306E-01  1.2412E-01  8.4972E-02  1.6940E-01 -4.4919E-01 -1.5297E-01  6.7176E-01  2.0592E-01
 GRADIENT:  -2.5510E-01 -5.8431E-02  1.9061E-01 -1.7718E-01 -2.3973E-03  4.7120E-03 -3.1657E-03 -1.3176E-02  4.5093E-02
 
0ITERATION NO.:   18    OBJECTIVE VALUE:   5564.44291774665        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:      204
 NPARAMETR:  5.4502E+01  5.6528E-03  2.4824E-01  2.9740E+00  8.0423E-02  1.6670E-01  6.0294E-01  3.8281E-01  3.4606E+01
 PARAMETER:  9.9094E-02  1.1306E-01  1.2412E-01  8.4972E-02  1.6940E-01 -4.4919E-01 -1.5297E-01  6.7176E-01  2.0592E-01
 GRADIENT:  -2.5510E-01 -5.8431E-02  1.9061E-01 -1.7718E-01 -2.3973E-03  4.7120E-03 -3.1657E-03 -1.3176E-02  4.5093E-02
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      204
 NO. OF SIG. DIGITS IN FINAL EST.:  3.6

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.8838E-02  8.0355E-03  1.5333E-01  7.5215E-02
 SE:             1.5085E-02  6.9639E-03  3.2687E-02  1.7666E-02
 N:                     300         300         300         300
 
 P VAL.:         2.1173E-01  2.4855E-01  2.7249E-06  2.0676E-05
 
 ETASHRINKSD(%)  7.8667E+00  7.0458E+01  2.7088E+01  5.0545E+01
 ETASHRINKVR(%)  1.5115E+01  9.1273E+01  4.6838E+01  7.5542E+01
 EBVSHRINKSD(%)  6.3562E+00  7.0773E+01  2.6175E+01  5.0051E+01
 EBVSHRINKVR(%)  1.2308E+01  9.1458E+01  4.5499E+01  7.5051E+01
 RELATIVEINF(%)  8.6689E+01  8.3394E+00  3.7675E+01  1.7443E+01
 EPSSHRINKSD(%)  3.5993E+01
 EPSSHRINKVR(%)  5.9032E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          900
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    1654.08935976841     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    5564.44291774665     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       7218.53227751506     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          1200
  
 #TERE:
 Elapsed estimation  time in seconds:     3.96
 Elapsed covariance  time in seconds:     2.88
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     5564.443       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         5.45E+01  5.65E-03  2.48E-01  2.97E+00
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        8.04E-02
 
 ETA2
+        0.00E+00  1.67E-01
 
 ETA3
+        0.00E+00  0.00E+00  6.03E-01
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  3.83E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.46E+01
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        2.84E-01
 
 ETA2
+        0.00E+00  4.08E-01
 
 ETA3
+        0.00E+00  0.00E+00  7.76E-01
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  6.19E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.88E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         9.65E-01  5.16E-04  2.18E-02  3.15E-01
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        7.67E-03
 
 ETA2
+       .........  8.74E-02
 
 ETA3
+       ......... .........  8.82E-02
 
 ETA4
+       ......... ......... .........  9.32E-02
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.06E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        1.35E-02
 
 ETA2
+       .........  1.07E-01
 
 ETA3
+       ......... .........  5.68E-02
 
 ETA4
+       ......... ......... .........  7.53E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        2.60E-01
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                          COVARIANCE MATRIX OF ESTIMATE                         ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        9.31E-01
 
 TH 2
+        1.14E-05  2.66E-07
 
 TH 3
+        2.09E-03 -1.72E-06  4.74E-04
 
 TH 4
+       -2.59E-04 -2.06E-05  4.34E-03  9.90E-02
 
 OM11
+       -6.65E-04  6.49E-08 -7.15E-06  2.25E-05  5.88E-05
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.06E-03 -9.26E-06  6.19E-05  1.32E-03  1.71E-05 ......... ......... .........  7.64E-03
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM33
+       -7.79E-03  4.03E-07 -1.07E-03 -9.65E-03  2.08E-05 ......... ......... .........  2.90E-04 ......... .........  7.78E-03
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM44
+       -4.34E-04  1.80E-06 -8.56E-04 -1.95E-02 -4.77E-06 ......... ......... ......... -1.83E-04 ......... .........  1.38E-03
         .........  8.69E-03
 
 SG11
+        9.47E-02  1.17E-04  2.77E-03 -5.59E-03 -2.77E-03 ......... ......... ......... -9.37E-02 ......... ......... -3.16E-02
         ......... -5.80E-03  9.39E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        9.65E-01
 
 TH 2
+        2.28E-02  5.16E-04
 
 TH 3
+        9.95E-02 -1.53E-01  2.18E-02
 
 TH 4
+       -8.52E-04 -1.27E-01  6.33E-01  3.15E-01
 
 OM11
+       -8.99E-02  1.64E-02 -4.28E-02  9.32E-03  7.67E-03
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.44E-02 -2.05E-01  3.25E-02  4.80E-02  2.56E-02 ......... ......... .........  8.74E-02
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM33
+       -9.15E-02  8.84E-03 -5.55E-01 -3.48E-01  3.07E-02 ......... ......... .........  3.76E-02 ......... .........  8.82E-02
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM44
+       -4.83E-03  3.73E-02 -4.22E-01 -6.64E-01 -6.68E-03 ......... ......... ......... -2.24E-02 ......... .........  1.68E-01
         .........  9.32E-02
 
 SG11
+        3.20E-02  7.43E-02  4.16E-02 -5.80E-03 -1.18E-01 ......... ......... ......... -3.50E-01 ......... ......... -1.17E-01
         ......... -2.03E-02  3.06E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      OM11      OM12      OM13      OM14      OM22      OM23      OM24      OM33  
             OM34      OM44      SG11  
 
 TH 1
+        1.10E+00
 
 TH 2
+       -6.11E+01  4.07E+06
 
 TH 3
+       -6.72E+00  1.75E+04  4.62E+03
 
 TH 4
+        3.62E-01  6.62E+02 -1.45E+02  2.53E+01
 
 OM11
+        1.13E+01 -5.39E+03  3.72E+02 -1.85E+01  1.74E+04
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        1.56E-01  4.61E+03 -1.00E+01 -4.82E-01  2.16E+01 ......... ......... .........  1.55E+02
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM33
+        5.72E-01  2.42E+03  4.34E+02  4.74E+00  1.20E+01 ......... ......... ......... -2.11E+00 ......... .........  1.92E+02
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM44
+        1.37E-01  2.07E+03  5.57E+01  4.15E+01  8.40E+00 ......... ......... .........  1.59E+00 ......... .........  2.26E+01
         .........  2.10E+02
 
 SG11
+       -1.26E-03 -1.20E+00 -9.46E-02  7.73E-02  5.24E+00 ......... ......... .........  1.49E+00 ......... .........  4.83E-01
         .........  2.05E-01  1.25E-01
 
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                      EIGENVALUES OF COR MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

             1         2         3         4         5         6         7         8         9
 
         2.62E-01  3.66E-01  6.18E-01  8.28E-01  9.02E-01  9.70E-01  1.10E+00  1.49E+00  2.46E+00
 
 Elapsed finaloutput time in seconds:     0.02
 #CPUT: Total CPU Time in Seconds,        6.844
Stop Time: 
Mon 03/20/2023 
07:09 PM
