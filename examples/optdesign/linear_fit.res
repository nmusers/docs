Mon 03/20/2023 
07:05 PM
$PROBLEM Linear Model Visual Acuity
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

ALPHAL=EXP(MU_4+ETA(4))

EE=ALPHAL*DOSE

IPRED=VA0+(1.0-EXP(-KK*TIME))*(EE-BETA*VA0)
Y=IPRED + EPS(1)

$THETA
55.0     ;[VA0]
0.005    ;[KK]
0.2      ; [BETA]
0.03     ; ALPHAL]

$OMEGA 0.07 0.5 1.0 0.1
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
 Linear Model Visual Acuity
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
   0.5500E+02  0.5000E-02  0.2000E+00  0.3000E-01
0INITIAL ESTIMATE OF OMEGA:
 0.7000E-01
 0.0000E+00   0.5000E+00
 0.0000E+00   0.0000E+00   0.1000E+01
 0.0000E+00   0.0000E+00   0.0000E+00   0.1000E+00
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
 RAW OUTPUT FILE (FILE): linear_fit.ext
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

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   5770.53820597506        NO. OF FUNC. EVALS.:   7
 CUMULATIVE NO. OF FUNC. EVALS.:        7
 NPARAMETR:  5.5000E+01  5.0000E-03  2.0000E-01  3.0000E-02  7.0000E-02  5.0000E-01  1.0000E+00  1.0000E-01  2.8000E+01
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
 GRADIENT:   5.8800E+02 -2.9451E+02  7.1734E+02 -3.5052E+03 -7.3453E+01  1.5407E+01 -2.9319E+01 -2.8450E+02 -3.5704E+02
 
0ITERATION NO.:    1    OBJECTIVE VALUE:   5693.29326302307        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       16
 NPARAMETR:  5.0300E+01  5.2140E-03  1.7915E-01  4.5283E-02  7.0150E-02  4.9978E-01  1.0009E+00  1.0083E-01  2.8292E+01
 PARAMETER:  9.1454E-02  1.0428E-01  8.9574E-02  1.5094E-01  1.0107E-01  9.9776E-02  1.0043E-01  1.0413E-01  1.0519E-01
 GRADIENT:  -5.5304E+03 -9.5019E+01 -3.9031E+02 -7.6350E+02 -1.4179E+02  1.7480E+01 -1.4486E+01 -1.8768E+02 -1.7804E+02
 
0ITERATION NO.:    2    OBJECTIVE VALUE:   5681.97674037833        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       25
 NPARAMETR:  5.7845E+01  5.2258E-03  1.8109E-01  4.5851E-02  7.0199E-02  4.9973E-01  1.0009E+00  1.0092E-01  2.8317E+01
 PARAMETER:  1.0517E-01  1.0452E-01  9.0543E-02  1.5284E-01  1.0142E-01  9.9733E-02  1.0046E-01  1.0460E-01  1.0563E-01
 GRADIENT:   5.2042E+03 -1.1731E+02 -6.2500E+02 -5.2948E+02 -9.5057E+01  1.8884E+01 -1.3102E+00 -1.7338E+02 -1.6622E+02
 
0ITERATION NO.:    3    OBJECTIVE VALUE:   5665.54967772350        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       34
 NPARAMETR:  5.7793E+01  5.3673E-03  2.0825E-01  5.0974E-02  7.0639E-02  4.9925E-01  1.0013E+00  1.0190E-01  2.8577E+01
 PARAMETER:  1.0508E-01  1.0735E-01  1.0412E-01  1.6991E-01  1.0455E-01  9.9249E-02  1.0067E-01  1.0939E-01  1.1020E-01
 GRADIENT:   5.0623E+03 -1.8665E+00 -2.2462E+02 -2.2437E+02 -8.7855E+01  1.9181E+01  4.2342E+01 -1.5083E+02 -1.3099E+02
 
0ITERATION NO.:    4    OBJECTIVE VALUE:   5664.57987157492        NO. OF FUNC. EVALS.:  11
 CUMULATIVE NO. OF FUNC. EVALS.:       45
 NPARAMETR:  5.7539E+01  5.1129E-03  1.9271E-01  5.4183E-02  7.1658E-02  4.9798E-01  9.9302E-01  1.0392E-01  2.9032E+01
 PARAMETER:  1.0462E-01  1.0226E-01  9.6355E-02  1.8061E-01  1.1171E-01  9.7978E-02  9.6497E-02  1.1921E-01  1.1810E-01
 GRADIENT:   4.9459E+03 -7.5901E+01 -7.3482E+02  1.2856E+02 -8.2182E+01  1.8259E+01  1.9311E+01 -1.3787E+02 -1.0690E+02
 
0ITERATION NO.:    5    OBJECTIVE VALUE:   5662.45568086153        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       54
 NPARAMETR:  5.7444E+01  3.0218E-03  2.1134E-01  5.2124E-02  8.1896E-02  4.8613E-01  9.1917E-01  1.2426E-01  3.3210E+01
 PARAMETER:  1.0444E-01  6.0435E-02  1.0567E-01  1.7375E-01  1.7848E-01  8.5937E-02  5.7860E-02  2.0862E-01  1.8532E-01
 GRADIENT:   4.3891E+03 -1.3284E+03 -4.7577E+02 -1.5267E+02 -3.7422E+00 -1.5963E+01  1.1631E+01 -1.2682E+02 -6.5632E+01
 
0ITERATION NO.:    6    OBJECTIVE VALUE:   5640.29532676165        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       62
 NPARAMETR:  5.7223E+01  4.0996E-03  2.0442E-01  4.4487E-02  1.0833E-01  4.6382E-01  7.7270E-01  1.8368E-01  4.4116E+01
 PARAMETER:  1.0404E-01  8.1992E-02  1.0221E-01  1.4829E-01  3.1835E-01  6.2439E-02 -2.8930E-02  4.0402E-01  3.2731E-01
 GRADIENT:   3.2200E+03 -5.0103E+02 -3.7116E+02 -2.8929E+02  1.2378E+02  1.9168E+01 -1.2243E+01 -1.0540E+02  1.1739E+02
 
0ITERATION NO.:    7    OBJECTIVE VALUE:   5600.50282495919        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       70
 NPARAMETR:  5.7293E+01  4.4858E-03  2.1851E-01  4.1452E-02  1.0595E-01  3.8200E-01  5.4606E-01  4.6758E-01  3.6346E+01
 PARAMETER:  1.0417E-01  8.9717E-02  1.0925E-01  1.3817E-01  3.0725E-01 -3.4591E-02 -2.0251E-01  8.7120E-01  2.3044E-01
 GRADIENT:   3.2399E+03 -4.4506E+02 -3.6093E+02 -1.2905E+02  1.1491E+02  1.4142E+01 -8.2262E+01 -2.8114E+01  3.5430E+01
 
0ITERATION NO.:    8    OBJECTIVE VALUE:   5597.58504355960        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       78
 NPARAMETR:  5.7396E+01  4.5565E-03  1.8867E-01  3.3917E-02  8.1892E-02  3.1041E-01  7.1992E-01  7.6386E-01  4.2920E+01
 PARAMETER:  1.0436E-01  9.1131E-02  9.4335E-02  1.1306E-01  1.7845E-01 -1.3837E-01 -6.4310E-02  1.1166E+00  3.1357E-01
 GRADIENT:   3.8502E+03 -4.3331E+02 -4.2777E+02 -7.8573E+01  1.7332E+01  1.3257E+01 -3.0501E+01  1.1951E+01  1.1521E+02
 
0ITERATION NO.:    9    OBJECTIVE VALUE:   5595.97437312371        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       86
 NPARAMETR:  5.7158E+01  4.7600E-03  1.7188E-01  3.2094E-02  9.0464E-02  2.6360E-01  8.7311E-01  8.6479E-01  4.0022E+01
 PARAMETER:  1.0392E-01  9.5200E-02  8.5939E-02  1.0698E-01  2.2823E-01 -2.2008E-01  3.2155E-02  1.1787E+00  2.7861E-01
 GRADIENT:   3.6223E+03 -3.8801E+02 -4.1950E+02 -3.8328E+01  5.2840E+01  9.5564E+00 -1.3714E+00  2.0119E+01  8.8748E+01
 
0ITERATION NO.:   10    OBJECTIVE VALUE:   5591.87348089017        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:       94
 NPARAMETR:  5.7199E+01  5.7467E-03  1.7445E-01  3.2115E-02  8.9052E-02  7.0384E-02  7.8553E-01  7.6529E-01  4.3279E+01
 PARAMETER:  1.0400E-01  1.1493E-01  8.7224E-02  1.0705E-01  2.2036E-01 -8.8032E-01 -2.0699E-02  1.1175E+00  3.1774E-01
 GRADIENT:   3.4985E+03 -1.0428E+02 -4.6624E+02 -8.3705E+01  4.9481E+01 -2.7216E+00 -1.9861E+01  8.4971E+00  9.9009E+01
 
0ITERATION NO.:   11    OBJECTIVE VALUE:   5571.40583869341        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:      104
 NPARAMETR:  5.5254E+01  5.7036E-03  2.0279E-01  3.8300E-02  7.8748E-02  1.0127E-01  7.4329E-01  6.2882E-01  3.5945E+01
 PARAMETER:  1.0046E-01  1.1407E-01  1.0139E-01  1.2767E-01  1.5888E-01 -6.9842E-01 -4.8332E-02  1.0193E+00  2.2489E-01
 GRADIENT:   1.5744E+03 -3.6012E+01 -4.2413E+01 -1.9422E+01 -3.5356E+00 -5.0883E+00  5.3407E-01  3.7302E+00  3.0877E-01
 
0ITERATION NO.:   12    OBJECTIVE VALUE:   5570.22328173201        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:      112
 NPARAMETR:  5.3835E+01  5.5254E-03  2.0766E-01  4.0365E-02  7.8189E-02  1.5513E-01  7.3751E-01  5.7350E-01  3.4770E+01
 PARAMETER:  9.7882E-02  1.1051E-01  1.0383E-01  1.3455E-01  1.5531E-01 -4.8517E-01 -5.2236E-02  9.7330E-01  2.0828E-01
 GRADIENT:  -1.1652E+02 -6.6645E+01  7.8912E+00 -5.3017E+00 -1.3114E+01 -1.4839E+00  7.8902E-02 -1.6629E+00 -5.3348E+00
 
0ITERATION NO.:   13    OBJECTIVE VALUE:   5570.03012405913        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:      120
 NPARAMETR:  5.3889E+01  5.5985E-03  2.0649E-01  4.0127E-02  8.0348E-02  1.5612E-01  7.4044E-01  5.8344E-01  3.4762E+01
 PARAMETER:  9.7980E-02  1.1197E-01  1.0325E-01  1.3376E-01  1.6894E-01 -4.8199E-01 -5.0253E-02  9.8188E-01  2.0816E-01
 GRADIENT:  -1.1810E+00 -3.6671E+01  4.6444E+00 -3.0600E+00 -4.5209E-01 -1.0734E+00  4.8960E-01 -2.4305E-01 -3.3453E+00
 
0ITERATION NO.:   14    OBJECTIVE VALUE:   5570.01867252132        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:      128
 NPARAMETR:  5.3880E+01  5.6533E-03  2.0608E-01  4.0065E-02  8.0637E-02  1.6003E-01  7.3944E-01  5.8579E-01  3.4856E+01
 PARAMETER:  9.7963E-02  1.1307E-01  1.0304E-01  1.3355E-01  1.7073E-01 -4.6962E-01 -5.0933E-02  9.8390E-01  2.0952E-01
 GRADIENT:  -9.4745E+00 -1.2299E+01  1.1594E+00 -1.5383E+00  1.1748E+00 -3.9230E-01  5.2757E-02  1.4169E-01 -6.8827E-01
 
0ITERATION NO.:   15    OBJECTIVE VALUE:   5569.99254202966        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:      136
 NPARAMETR:  5.3895E+01  5.7028E-03  2.0594E-01  4.0103E-02  8.0351E-02  1.6504E-01  7.3846E-01  5.8354E-01  3.4906E+01
 PARAMETER:  9.7990E-02  1.1406E-01  1.0297E-01  1.3368E-01  1.6895E-01 -4.5422E-01 -5.1595E-02  9.8197E-01  2.1023E-01
 GRADIENT:   1.2128E+00  9.8114E+00 -2.3357E+00  8.0005E-01 -3.6925E-01  3.0614E-01 -1.7054E-01 -9.3788E-02  9.3277E-01
 
0ITERATION NO.:   16    OBJECTIVE VALUE:   5569.99241804312        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:      144
 NPARAMETR:  5.3891E+01  5.6806E-03  2.0606E-01  4.0096E-02  8.0428E-02  1.6295E-01  7.3886E-01  5.8436E-01  3.4873E+01
 PARAMETER:  9.7984E-02  1.1361E-01  1.0303E-01  1.3365E-01  1.6944E-01 -4.6058E-01 -5.1321E-02  9.8267E-01  2.0976E-01
 GRADIENT:  -8.5775E-01  2.1919E-01 -1.8248E-01 -8.7602E-02  4.1448E-02  9.6618E-05 -2.1048E-02  3.0664E-03  4.0736E-02
 
0ITERATION NO.:   17    OBJECTIVE VALUE:   5569.99241804312        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:      158
 NPARAMETR:  5.3891E+01  5.6806E-03  2.0606E-01  4.0096E-02  8.0428E-02  1.6295E-01  7.3886E-01  5.8436E-01  3.4873E+01
 PARAMETER:  9.7984E-02  1.1361E-01  1.0303E-01  1.3365E-01  1.6944E-01 -4.6058E-01 -5.1321E-02  9.8267E-01  2.0976E-01
 GRADIENT:  -6.9964E+02 -6.2278E+00 -8.2031E+01 -2.7900E+01  4.1448E-02  9.6618E-05 -2.1048E-02  3.0664E-03 -3.3690E-01
 
0ITERATION NO.:   18    OBJECTIVE VALUE:   5569.35498994229        NO. OF FUNC. EVALS.:  18
 CUMULATIVE NO. OF FUNC. EVALS.:      176
 NPARAMETR:  5.4372E+01  5.6733E-03  2.1423E-01  4.1209E-02  8.0002E-02  1.6000E-01  7.0348E-01  5.6023E-01  3.5176E+01
 PARAMETER:  9.8858E-02  1.1347E-01  1.0712E-01  1.3736E-01  1.6678E-01 -4.6972E-01 -7.5859E-02  9.6159E-01  2.1408E-01
 GRADIENT:  -1.6967E+02 -3.7952E+00 -2.3284E+01 -2.4731E+01  1.0388E+00 -4.1320E-02 -2.7643E+00 -1.5041E+00  2.7557E+00
 
0ITERATION NO.:   19    OBJECTIVE VALUE:   5569.28594363440        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:      192
 NPARAMETR:  5.4526E+01  5.6671E-03  2.1676E-01  4.1807E-02  7.9756E-02  1.6317E-01  7.0084E-01  5.5692E-01  3.4933E+01
 PARAMETER:  9.9138E-02  1.1334E-01  1.0838E-01  1.3936E-01  1.6524E-01 -4.5989E-01 -7.7736E-02  9.5863E-01  2.1061E-01
 GRADIENT:   9.9924E+00  6.8790E-02 -9.2269E-01 -7.9203E+00 -1.5471E-02  1.1849E-02 -5.3561E-01 -4.4657E-01 -3.2577E-01
 
0ITERATION NO.:   20    OBJECTIVE VALUE:   5569.28347474565        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:      208
 NPARAMETR:  5.4522E+01  5.6636E-03  2.1712E-01  4.1965E-02  7.9763E-02  1.6344E-01  7.0086E-01  5.5598E-01  3.4927E+01
 PARAMETER:  9.9131E-02  1.1327E-01  1.0856E-01  1.3988E-01  1.6528E-01 -4.5908E-01 -7.7721E-02  9.5779E-01  2.1052E-01
 GRADIENT:   6.3772E+00 -1.3757E-01  1.1142E+00 -2.4712E+00 -1.0647E-03  1.6116E-02 -3.9856E-02 -1.7918E-01 -2.0455E-01
 
0ITERATION NO.:   21    OBJECTIVE VALUE:   5569.28321162221        NO. OF FUNC. EVALS.:  16
 CUMULATIVE NO. OF FUNC. EVALS.:      224
 NPARAMETR:  5.4516E+01  5.6638E-03  2.1715E-01  4.2011E-02  7.9764E-02  1.6319E-01  7.0079E-01  5.5617E-01  3.4935E+01
 PARAMETER:  9.9121E-02  1.1328E-01  1.0858E-01  1.4004E-01  1.6529E-01 -4.5983E-01 -7.7771E-02  9.5795E-01  2.1065E-01
 GRADIENT:   4.2213E-01  9.2053E-02  4.5039E-01 -1.6189E-01 -1.8199E-02 -2.3024E-03  2.7902E-02 -7.6958E-03 -5.1598E-02
 
0ITERATION NO.:   22    OBJECTIVE VALUE:   5569.28321162221        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:      234
 NPARAMETR:  5.4516E+01  5.6638E-03  2.1715E-01  4.2011E-02  7.9764E-02  1.6319E-01  7.0079E-01  5.5617E-01  3.4935E+01
 PARAMETER:  9.9121E-02  1.1328E-01  1.0858E-01  1.4004E-01  1.6529E-01 -4.5983E-01 -7.7771E-02  9.5795E-01  2.1065E-01
 GRADIENT:   4.2213E-01  9.2053E-02  4.5039E-01 -1.6189E-01 -1.8199E-02 -2.3024E-03  2.7902E-02 -7.6958E-03 -5.1598E-02
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      234
 NO. OF SIG. DIGITS IN FINAL EST.:  3.7

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.8821E-02  7.4012E-03  1.7556E-01  8.7487E-02
 SE:             1.5028E-02  6.8559E-03  3.4839E-02  2.1521E-02
 N:                     300         300         300         300
 
 P VAL.:         2.1043E-01  2.8035E-01  4.6855E-07  4.8009E-05
 
 ETASHRINKSD(%)  7.8355E+00  7.0605E+01  2.7917E+01  5.0018E+01
 ETASHRINKVR(%)  1.5057E+01  9.1359E+01  4.8041E+01  7.5018E+01
 EBVSHRINKSD(%)  6.3393E+00  7.0979E+01  2.7369E+01  4.9906E+01
 EBVSHRINKVR(%)  1.2277E+01  9.1578E+01  4.7247E+01  7.4906E+01
 RELATIVEINF(%)  8.6601E+01  8.2534E+00  3.9537E+01  1.9055E+01
 EPSSHRINKSD(%)  3.5908E+01
 EPSSHRINKVR(%)  5.8923E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          900
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    1654.08935976841     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    5569.28321162221     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       7223.37257139062     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          1200
  
 #TERE:
 Elapsed estimation  time in seconds:     4.30
 Elapsed covariance  time in seconds:     2.84
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     5569.283       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         5.45E+01  5.66E-03  2.17E-01  4.20E-02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        7.98E-02
 
 ETA2
+        0.00E+00  1.63E-01
 
 ETA3
+        0.00E+00  0.00E+00  7.01E-01
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  5.56E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.49E+01
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        2.82E-01
 
 ETA2
+        0.00E+00  4.04E-01
 
 ETA3
+        0.00E+00  0.00E+00  8.37E-01
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  7.46E-01
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.91E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4     
 
         9.62E-01  5.09E-04  1.95E-02  4.64E-03
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        7.60E-03
 
 ETA2
+       .........  8.66E-02
 
 ETA3
+       ......... .........  1.04E-01
 
 ETA4
+       ......... ......... .........  1.22E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.14E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4     
 
 ETA1
+        1.35E-02
 
 ETA2
+       .........  1.07E-01
 
 ETA3
+       ......... .........  6.19E-02
 
 ETA4
+       ......... ......... .........  8.19E-02
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        2.66E-01
 
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
+        9.25E-01
 
 TH 2
+        1.02E-05  2.59E-07
 
 TH 3
+        2.08E-03 -1.36E-06  3.80E-04
 
 TH 4
+       -3.87E-05 -2.79E-07  4.95E-05  2.15E-05
 
 OM11
+       -6.52E-04  6.65E-08 -7.35E-06  4.63E-07  5.78E-05
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -1.89E-03 -8.41E-06  4.94E-05  2.25E-05  1.73E-05 ......... ......... .........  7.51E-03
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM33
+       -9.54E-03 -1.60E-07 -1.13E-03 -1.60E-04  2.74E-05 ......... ......... .........  3.35E-04 ......... .........  1.07E-02
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM44
+       -6.48E-04  1.83E-06 -6.78E-04 -2.84E-04 -1.35E-06 ......... ......... ......... -7.18E-05 ......... .........  1.22E-03
         .........  1.49E-02
 
 SG11
+        9.32E-02  1.13E-04  1.25E-03 -6.69E-04 -2.82E-03 ......... ......... ......... -9.78E-02 ......... ......... -3.18E-02
         ......... -1.73E-02  9.85E+00
 
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
+        9.62E-01
 
 TH 2
+        2.08E-02  5.09E-04
 
 TH 3
+        1.11E-01 -1.38E-01  1.95E-02
 
 TH 4
+       -8.67E-03 -1.18E-01  5.48E-01  4.64E-03
 
 OM11
+       -8.92E-02  1.72E-02 -4.96E-02  1.31E-02  7.60E-03
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.27E-02 -1.91E-01  2.93E-02  5.61E-02  2.63E-02 ......... ......... .........  8.66E-02
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM33
+       -9.58E-02 -3.04E-03 -5.61E-01 -3.34E-01  3.47E-02 ......... ......... .........  3.73E-02 ......... .........  1.04E-01
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM44
+       -5.52E-03  2.95E-02 -2.85E-01 -5.02E-01 -1.46E-03 ......... ......... ......... -6.79E-03 ......... .........  9.61E-02
         .........  1.22E-01
 
 SG11
+        3.09E-02  7.09E-02  2.04E-02 -4.60E-02 -1.18E-01 ......... ......... ......... -3.60E-01 ......... ......... -9.79E-02
         ......... -4.51E-02  3.14E+00
 
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
+        1.11E+00
 
 TH 2
+       -5.62E+01  4.13E+06
 
 TH 3
+       -7.43E+00  1.80E+04  5.06E+03
 
 TH 4
+        2.33E+01  3.53E+04 -7.79E+03  8.41E+04
 
 OM11
+        1.12E+01 -5.55E+03  4.18E+02 -1.14E+03  1.77E+04
 
 OM12
+       ......... ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        1.36E-01  4.35E+03 -8.66E+00 -4.54E+01  2.35E+01 ......... ......... .........  1.58E+02
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM33
+        5.04E-01  2.24E+03  4.06E+02  3.48E+02  5.62E+00 ......... ......... ......... -2.00E+00 ......... .........  1.41E+02
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM44
+        1.21E-01  8.24E+02  4.63E+01  1.23E+03  5.65E+00 ......... ......... .........  8.99E-01 ......... .........  1.37E+01
         .........  9.17E+01
 
 SG11
+       -9.60E-04  3.48E+00  1.20E-01  8.56E+00  5.17E+00 ......... ......... .........  1.52E+00 ......... .........  4.05E-01
         .........  2.82E-01  1.20E-01
 
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                      EIGENVALUES OF COR MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

             1         2         3         4         5         6         7         8         9
 
         3.50E-01  4.22E-01  6.21E-01  8.55E-01  9.27E-01  9.92E-01  1.11E+00  1.49E+00  2.23E+00
 
 Elapsed finaloutput time in seconds:     0.02
 #CPUT: Total CPU Time in Seconds,        7.094
Stop Time: 
Mon 03/20/2023 
07:06 PM
