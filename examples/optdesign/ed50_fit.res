Mon 03/20/2023 
07:13 PM
$PROBLEM EDS50 Model Visual Acuity
$INPUT C ID TIME DOSEQ MDV DV 
$DATA ed50s_fit.dat ignore=@

$PRED
MU_1=LOG(THETA(1))
MU_2=LOG(THETA(2))
MU_3=LOG(THETA(3))
MU_4=LOG(THETA(4))
MU_5=LOG(THETA(5))

IF(MDV==1) THEN
DOSE=DOSEQ
ELSE
DOSE=DOSE
ENDIF

VA0=EXP(MU_1+ETA(1))
KK=EXP(MU_2+ETA(2))
BETA=EXP(MU_3+ETA(3))

EMAX=EXP(MU_4+ETA(4))
ED50=EXP(MU_5+ETA(5))

EE=EMAX*DOSE/(ED50+DOSE)

IPRED=VA0+(1.0-EXP(-KK*TIME))*(EE-BETA*VA0)
Y=IPRED + EPS(1)

$THETA
55.0     ;[VA0]
0.005    ;[KK]
0.2      ; [BETA]
30.0     ;[EMAXS]
150.0    ;[ED50S]

$OMEGA 0.07 0.5 1.0 0.17 0.49
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
 EDS50 Model Visual Acuity
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
0LENGTH OF THETA:   5
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   5
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.5500E+02  0.5000E-02  0.2000E+00  0.3000E+02  0.1500E+03
0INITIAL ESTIMATE OF OMEGA:
 0.7000E-01
 0.0000E+00   0.5000E+00
 0.0000E+00   0.0000E+00   0.1000E+01
 0.0000E+00   0.0000E+00   0.0000E+00   0.1700E+00
 0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00   0.4900E+00
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
 RAW OUTPUT FILE (FILE): ed50_fit.ext
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

 
0ITERATION NO.:    0    OBJECTIVE VALUE:   5591.85423830893        NO. OF FUNC. EVALS.:   8
 CUMULATIVE NO. OF FUNC. EVALS.:        8
 NPARAMETR:  5.5000E+01  5.0000E-03  2.0000E-01  3.0000E+01  1.5000E+02  7.0000E-02  5.0000E-01  1.0000E+00  1.7000E-01  4.9000E-01
             2.8000E+01
 PARAMETER:  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01  1.0000E-01
             1.0000E-01
 GRADIENT:   2.0959E+03 -9.9423E+01 -5.8836E+02  6.8204E+02 -3.1032E+02 -8.4087E+01  1.7750E+01  6.1974E+01 -2.4828E+01 -5.4976E+00
            -7.2498E+01
 
0ITERATION NO.:    1    OBJECTIVE VALUE:   5589.93133005536        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:       22
 NPARAMETR:  5.3754E+01  5.0054E-03  2.0127E-01  2.9779E+01  1.5050E+02  7.0013E-02  4.9998E-01  9.9987E-01  1.7001E-01  4.9001E-01
             2.8004E+01
 PARAMETER:  9.7734E-02  1.0011E-01  1.0064E-01  9.9263E-02  1.0034E-01  1.0009E-01  9.9981E-02  9.9933E-02  1.0003E-01  1.0001E-01
             1.0008E-01
 GRADIENT:   3.6997E+02 -9.2707E+01 -5.1006E+02  5.9407E+02 -2.8235E+02 -8.7141E+01  1.7595E+01  6.2386E+01 -2.6318E+01 -5.6206E+00
            -7.4113E+01
 
0ITERATION NO.:    2    OBJECTIVE VALUE:   5588.98525248606        NO. OF FUNC. EVALS.:  14
 CUMULATIVE NO. OF FUNC. EVALS.:       36
 NPARAMETR:  5.3086E+01  5.0206E-03  2.0462E-01  2.9194E+01  1.5189E+02  7.0053E-02  4.9992E-01  9.9946E-01  1.7004E-01  4.9002E-01
             2.8018E+01
 PARAMETER:  9.6521E-02  1.0041E-01  1.0231E-01  9.7315E-02  1.0126E-01  1.0038E-01  9.9923E-02  9.9728E-02  1.0011E-01  1.0002E-01
             1.0032E-01
 GRADIENT:  -6.4665E+02 -8.8261E+01 -3.7608E+02  4.1520E+02 -2.2676E+02 -9.1048E+01  1.7628E+01  6.5626E+01 -2.9953E+01 -5.9921E+00
            -7.5622E+01
 
0ITERATION NO.:    3    OBJECTIVE VALUE:   5585.32131085201        NO. OF FUNC. EVALS.:  12
 CUMULATIVE NO. OF FUNC. EVALS.:       48
 NPARAMETR:  5.4814E+01  5.1095E-03  2.2194E-01  2.6238E+01  1.5937E+02  7.0299E-02  4.9958E-01  9.9694E-01  1.7023E-01  4.9014E-01
             2.8101E+01
 PARAMETER:  9.9661E-02  1.0219E-01  1.1097E-01  8.7461E-02  1.0625E-01  1.0213E-01  9.9577E-02  9.8468E-02  1.0067E-01  1.0014E-01
             1.0179E-01
 GRADIENT:   1.4902E+03 -8.6656E+01  1.2238E+02 -4.8427E+02  6.8346E+00 -7.5652E+01  1.8708E+01  8.0103E+01 -5.3216E+01 -9.0834E+00
            -7.9472E+01
 
0ITERATION NO.:    4    OBJECTIVE VALUE:   5581.02938204726        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:       58
 NPARAMETR:  5.5048E+01  5.8206E-03  2.5152E-01  3.0174E+01  1.8297E+02  7.2310E-02  4.9658E-01  9.7289E-01  1.7263E-01  4.9137E-01
             2.8836E+01
 PARAMETER:  1.0009E-01  1.1641E-01  1.2576E-01  1.0058E-01  1.2198E-01  1.1624E-01  9.6569E-02  8.6257E-02  1.0769E-01  1.0140E-01
             1.1472E-01
 GRADIENT:   1.6819E+03  1.6760E+02  3.8598E+02 -2.3612E+01 -5.2802E+01 -5.9205E+01  2.0741E+01  1.0799E+02 -2.5718E+01 -5.3694E+00
            -5.3475E+01
 
0ITERATION NO.:    5    OBJECTIVE VALUE:   5576.40585510222        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       67
 NPARAMETR:  5.4817E+01  7.0268E-03  1.8753E-01  3.5604E+01  4.0654E+02  9.3128E-02  4.6816E-01  7.5107E-01  1.9343E-01  5.0191E-01
             3.6067E+01
 PARAMETER:  9.9667E-02  1.4054E-01  9.3764E-02  1.1868E-01  2.7103E-01  2.4274E-01  6.7104E-02 -4.3129E-02  1.6457E-01  1.1200E-01
             2.2658E-01
 GRADIENT:   1.4403E+03  2.2826E+02 -6.4069E+02 -5.0910E+00 -1.2050E+01  6.0725E+01  2.6076E+01 -1.6822E+01 -2.3676E+01 -1.4697E+01
             5.2227E+01
 
0ITERATION NO.:    6    OBJECTIVE VALUE:   5576.07089820504        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       76
 NPARAMETR:  5.5039E+01  4.2917E-03  2.2323E-01  4.3302E+01  4.9943E+02  1.0312E-01  4.5066E-01  6.5992E-01  2.0553E-01  5.0941E-01
             3.9369E+01
 PARAMETER:  1.0007E-01  8.5834E-02  1.1162E-01  1.4434E-01  3.3295E-01  2.9372E-01  4.8050E-02 -1.0782E-01  1.9489E-01  1.1942E-01
             2.7038E-01
 GRADIENT:   1.5247E+03 -3.9627E+02 -2.7161E+02  3.4449E+01 -1.7466E+00  1.1072E+02  1.9492E+01 -9.5428E+00 -6.9085E+00 -9.0738E+00
             1.0404E+02
 
0ITERATION NO.:    7    OBJECTIVE VALUE:   5572.31310214580        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       85
 NPARAMETR:  5.5472E+01  4.1702E-03  2.3716E-01  4.7802E+01  5.8005E+02  9.3453E-02  3.9016E-01  4.9064E-01  2.3216E-01  5.3881E-01
             3.4379E+01
 PARAMETER:  1.0086E-01  8.3403E-02  1.1858E-01  1.5934E-01  3.8670E-01  2.4448E-01 -2.4025E-02 -2.5602E-01  2.5581E-01  1.4747E-01
             2.0263E-01
 GRADIENT:   1.8836E+03 -5.7482E+02 -4.3459E+02  4.0964E+01  5.3661E+00  6.8598E+01  7.7186E+00 -8.5452E+01  3.6037E-01 -7.3752E+00
             1.4255E+01
 
0ITERATION NO.:    8    OBJECTIVE VALUE:   5570.61163193841        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:       94
 NPARAMETR:  5.5465E+01  4.3665E-03  2.4439E-01  4.4578E+01  5.2123E+02  8.8384E-02  3.3778E-01  4.5467E-01  2.5269E-01  5.7466E-01
             3.7307E+01
 PARAMETER:  1.0085E-01  8.7330E-02  1.2219E-01  1.4859E-01  3.4748E-01  2.1660E-01 -9.6101E-02 -2.9410E-01  2.9819E-01  1.7969E-01
             2.4349E-01
 GRADIENT:   1.7324E+03 -4.8188E+02 -3.5618E+02  2.0268E+01  1.1269E+01  4.9745E+01  8.4297E+00 -9.2844E+01  3.7080E+00 -4.7813E+00
             5.1490E+01
 
0ITERATION NO.:    9    OBJECTIVE VALUE:   5570.07438456757        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:      103
 NPARAMETR:  5.5027E+01  4.9314E-03  2.4925E-01  3.5393E+01  3.6680E+02  1.0271E-01  1.8977E-01  4.4892E-01  3.4287E-01  7.1846E-01
             3.6104E+01
 PARAMETER:  1.0005E-01  9.8628E-02  1.2463E-01  1.1798E-01  2.4453E-01  2.9169E-01 -3.8440E-01 -3.0045E-01  4.5077E-01  2.9135E-01
             2.2710E-01
 GRADIENT:   1.1936E+03 -3.4121E+02 -9.2945E+01 -3.0057E+01  2.7144E+01  1.0910E+02 -4.7668E-01 -8.4380E+01  1.7053E+01  1.9035E+00
             2.6922E+01
 
0ITERATION NO.:   10    OBJECTIVE VALUE:   5568.45000674218        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:      113
 NPARAMETR:  5.5091E+01  4.9310E-03  2.3443E-01  3.5583E+01  4.0147E+02  9.8994E-02  1.4267E-01  4.9726E-01  3.9207E-01  7.8732E-01
             3.6627E+01
 PARAMETER:  1.0017E-01  9.8621E-02  1.1721E-01  1.1861E-01  2.6765E-01  2.7328E-01 -5.2704E-01 -2.4932E-01  5.1783E-01  3.3711E-01
             2.3429E-01
 GRADIENT:   1.3323E+03 -4.1483E+02 -2.0606E+02  5.8447E+01  9.6281E+00  9.4264E+01 -4.8253E+00 -7.0764E+01  2.5478E+01  4.7341E+00
             2.9183E+01
 
0ITERATION NO.:   11    OBJECTIVE VALUE:   5566.81664106680        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:      122
 NPARAMETR:  5.5142E+01  5.2803E-03  2.4166E-01  4.3891E+01  4.8630E+02  9.6913E-02  3.8036E-02  5.1308E-01  1.6792E-01  6.6013E-01
             3.9487E+01
 PARAMETER:  1.0026E-01  1.0561E-01  1.2083E-01  1.4630E-01  3.2420E-01  2.6266E-01 -1.1880E+00 -2.3366E-01  9.3831E-02  2.4902E-01
             2.7189E-01
 GRADIENT:   1.3410E+03 -3.8120E+02 -1.9038E+02  3.7703E+00  3.4023E+00  8.6291E+01 -8.3487E+00 -5.2621E+01 -8.4791E+00 -9.8966E+00
             3.9122E+01
 
0ITERATION NO.:   12    OBJECTIVE VALUE:   5560.94809765737        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:      131
 NPARAMETR:  5.5013E+01  5.5038E-03  2.3643E-01  4.4976E+01  5.0669E+02  9.3526E-02  4.6288E-02  5.3920E-01  1.4319E-01  1.1307E+00
             3.7959E+01
 PARAMETER:  1.0002E-01  1.1008E-01  1.1822E-01  1.4992E-01  3.3780E-01  2.4487E-01 -1.0899E+00 -2.0883E-01  1.4182E-02  5.1809E-01
             2.5215E-01
 GRADIENT:   1.2786E+03 -1.9459E+02 -1.7063E+02  1.6043E+02 -2.5334E+01  6.9612E+01 -8.5365E+00 -3.6873E+01  2.2515E+00  1.7809E+00
             2.5695E+01
 
0ITERATION NO.:   13    OBJECTIVE VALUE:   5555.83085802716        NO. OF FUNC. EVALS.:  10
 CUMULATIVE NO. OF FUNC. EVALS.:      141
 NPARAMETR:  5.4713E+01  5.7763E-03  2.3247E-01  4.0036E+01  4.4070E+02  8.7574E-02  6.3546E-02  5.7899E-01  2.0124E-01  7.9722E-01
             3.6183E+01
 PARAMETER:  9.9477E-02  1.1553E-01  1.1623E-01  1.3345E-01  2.9380E-01  2.1199E-01 -9.3142E-01 -1.7324E-01  1.8436E-01  3.4336E-01
             2.2819E-01
 GRADIENT:   9.6082E+02 -2.4154E+01 -1.0433E+02  5.5988E+01 -5.0633E+00  3.9522E+01 -8.2346E+00 -2.4752E+01 -7.4324E-01 -3.9606E+00
             1.7163E+00
 
0ITERATION NO.:   14    OBJECTIVE VALUE:   5552.70296834866        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:      150
 NPARAMETR:  5.3950E+01  5.6377E-03  2.3018E-01  3.3564E+01  3.3963E+02  8.0355E-02  2.0286E-01  6.4011E-01  2.7000E-01  9.4240E-01
             3.3706E+01
 PARAMETER:  9.8091E-02  1.1275E-01  1.1509E-01  1.1188E-01  2.2642E-01  1.6898E-01 -3.5105E-01 -1.2306E-01  3.3131E-01  4.2701E-01
             1.9274E-01
 GRADIENT:   8.4292E+01  1.1403E+01  4.2403E+01  2.0476E+01  2.9054E+00 -3.2200E+00  2.4836E+00 -2.6694E+00  7.2778E+00  6.5938E-01
            -3.7858E+00
 
0ITERATION NO.:   15    OBJECTIVE VALUE:   5552.51325503628        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:      159
 NPARAMETR:  5.3794E+01  5.6883E-03  2.2851E-01  3.3773E+01  3.3365E+02  8.0898E-02  1.5146E-01  6.5151E-01  2.2145E-01  1.1196E+00
             3.4502E+01
 PARAMETER:  9.7807E-02  1.1377E-01  1.1425E-01  1.1258E-01  2.2243E-01  1.7235E-01 -4.9715E-01 -1.1423E-01  2.3219E-01  5.1315E-01
             2.0441E-01
 GRADIENT:  -9.1580E+01  8.3194E+00  2.0076E+01  1.5277E+01 -5.1244E+00 -7.4402E-01 -1.9538E+00  1.5366E+00  7.0935E-01 -4.6064E-01
             9.8039E-01
 
0ITERATION NO.:   16    OBJECTIVE VALUE:   5552.29859529003        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:      168
 NPARAMETR:  5.3855E+01  5.6519E-03  2.2464E-01  3.5042E+01  3.6156E+02  8.1244E-02  1.9108E-01  6.5863E-01  2.0468E-01  1.2807E+00
             3.3876E+01
 PARAMETER:  9.7919E-02  1.1304E-01  1.1232E-01  1.1681E-01  2.4104E-01  1.7448E-01 -3.8096E-01 -1.0880E-01  1.9282E-01  5.8036E-01
             1.9525E-01
 GRADIENT:   4.4147E+01  9.9987E+00 -2.9941E+01  6.3306E+01 -1.2520E+01  6.2942E-01  1.3040E+00  3.0245E-01  2.3818E+00  8.6703E-01
            -4.0546E-01
 
0ITERATION NO.:   17    OBJECTIVE VALUE:   5552.29692215001        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:      177
 NPARAMETR:  5.3850E+01  5.6555E-03  2.2514E-01  3.4677E+01  3.5565E+02  8.1185E-02  1.8389E-01  6.5743E-01  2.0657E-01  1.2675E+00
             3.4002E+01
 PARAMETER:  9.7909E-02  1.1311E-01  1.1257E-01  1.1559E-01  2.3710E-01  1.7412E-01 -4.0013E-01 -1.0971E-01  1.9743E-01  5.7521E-01
             1.9711E-01
 GRADIENT:   2.5161E+01  7.7459E+00 -2.0172E+01  4.5678E+01 -9.9725E+00  4.8292E-01  7.2253E-01  2.8432E-01  1.6692E+00  4.7191E-01
             1.3800E-01
 
0ITERATION NO.:   18    OBJECTIVE VALUE:   5552.25963887045        NO. OF FUNC. EVALS.:  11
 CUMULATIVE NO. OF FUNC. EVALS.:      188
 NPARAMETR:  5.3853E+01  5.6511E-03  2.2536E-01  3.4588E+01  3.5688E+02  8.1028E-02  1.7580E-01  6.5652E-01  2.0434E-01  1.2850E+00
             3.4119E+01
 PARAMETER:  9.7915E-02  1.1302E-01  1.1268E-01  1.1529E-01  2.3792E-01  1.7315E-01 -4.2262E-01 -1.1040E-01  1.9200E-01  5.8204E-01
             1.9883E-01
 GRADIENT:   1.6086E+01  2.0391E+00 -1.0456E+01  2.8083E+01 -6.8992E+00 -1.6394E-01 -2.6173E-03  1.8499E-01  9.6588E-01  2.5723E-01
             3.6664E-01
 
0ITERATION NO.:   19    OBJECTIVE VALUE:   5552.25667529048        NO. OF FUNC. EVALS.:   9
 CUMULATIVE NO. OF FUNC. EVALS.:      197
 NPARAMETR:  5.3852E+01  5.6482E-03  2.2498E-01  3.4544E+01  3.6115E+02  8.1013E-02  1.7337E-01  6.5713E-01  2.0117E-01  1.3161E+00
             3.4153E+01
 PARAMETER:  9.7912E-02  1.1296E-01  1.1249E-01  1.1515E-01  2.4076E-01  1.7306E-01 -4.2959E-01 -1.0994E-01  1.8417E-01  5.9401E-01
             1.9932E-01
 GRADIENT:   8.6566E+00 -1.4933E+00 -3.7612E+00  8.0962E+00 -3.2847E+00 -1.4161E-01 -2.3242E-01 -5.5436E-02  2.4839E-01  3.0523E-02
             3.9269E-01
 
0ITERATION NO.:   20    OBJECTIVE VALUE:   5552.05894508890        NO. OF FUNC. EVALS.:  13
 CUMULATIVE NO. OF FUNC. EVALS.:      210
 NPARAMETR:  5.3865E+01  5.6228E-03  2.2193E-01  3.6846E+01  4.3032E+02  8.0722E-02  1.6595E-01  6.6335E-01  1.7263E-01  1.5152E+00
             3.4079E+01
 PARAMETER:  9.7937E-02  1.1246E-01  1.1096E-01  1.2282E-01  2.8688E-01  1.7126E-01 -4.5147E-01 -1.0523E-01  1.0766E-01  6.6445E-01
             1.9824E-01
 GRADIENT:   2.3491E+01 -1.4771E+01  3.3173E+00  1.5285E+00  2.8555E+00 -1.6923E+00 -1.2584E+00 -2.0545E-01  4.5803E-01  1.4109E+00
            -1.5438E+00
 
0ITERATION NO.:   21    OBJECTIVE VALUE:   5552.05894508890        NO. OF FUNC. EVALS.:  23
 CUMULATIVE NO. OF FUNC. EVALS.:      233
 NPARAMETR:  5.3865E+01  5.6228E-03  2.2193E-01  3.6846E+01  4.3032E+02  8.0722E-02  1.6595E-01  6.6335E-01  1.7263E-01  1.5152E+00
             3.4079E+01
 PARAMETER:  9.7937E-02  1.1246E-01  1.1096E-01  1.2282E-01  2.8688E-01  1.7126E-01 -4.5147E-01 -1.0523E-01  1.0766E-01  6.6445E-01
             1.9824E-01
 GRADIENT:  -6.8201E+02 -2.1464E+01 -7.6910E+01 -3.1736E+01  5.3456E-01 -1.6923E+00 -1.2584E+00 -2.0545E-01  4.5803E-01  1.4109E+00
            -1.9010E+00
 
0ITERATION NO.:   22    OBJECTIVE VALUE:   5551.22085408496        NO. OF FUNC. EVALS.:  21
 CUMULATIVE NO. OF FUNC. EVALS.:      254
 NPARAMETR:  5.4490E+01  5.5996E-03  2.3271E-01  3.9674E+01  4.6083E+02  8.0258E-02  1.6231E-01  6.2988E-01  1.6808E-01  1.2615E+00
             3.4192E+01
 PARAMETER:  9.9073E-02  1.1199E-01  1.1635E-01  1.3225E-01  3.0722E-01  1.6838E-01 -4.6255E-01 -1.3112E-01  9.4308E-02  5.7283E-01
             1.9989E-01
 GRADIENT:   1.9975E+01 -2.1978E+01 -9.4464E+00 -6.2491E+00  4.0893E-01 -6.0273E-01 -1.5738E+00 -1.6161E+00  1.4960E+00  8.2095E-01
            -2.4774E+00
 
0ITERATION NO.:   23    OBJECTIVE VALUE:   5551.12126856788        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      273
 NPARAMETR:  5.4552E+01  5.6292E-03  2.3438E-01  4.1882E+01  5.0225E+02  8.0238E-02  1.8304E-01  6.3026E-01  1.4438E-01  1.2957E+00
             3.4115E+01
 PARAMETER:  9.9186E-02  1.1258E-01  1.1719E-01  1.3961E-01  3.3483E-01  1.6825E-01 -4.0245E-01 -1.3081E-01  1.8320E-02  5.8620E-01
             1.9876E-01
 GRADIENT:   8.9779E+01  5.9591E+00  1.9721E+01  4.7837E-02  1.4078E-01 -4.6764E-01  4.5534E-01  8.5205E-01  3.6235E-01  1.0896E+00
             1.0075E+00
 
0ITERATION NO.:   24    OBJECTIVE VALUE:   5551.09635843234        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      292
 NPARAMETR:  5.4503E+01  5.6312E-03  2.3337E-01  4.2140E+01  5.0833E+02  8.0373E-02  1.7933E-01  6.3248E-01  1.4642E-01  1.2283E+00
             3.4095E+01
 PARAMETER:  9.9097E-02  1.1262E-01  1.1668E-01  1.4047E-01  3.3889E-01  1.6909E-01 -4.1268E-01 -1.2905E-01  2.5327E-02  5.5948E-01
             1.9847E-01
 GRADIENT:   3.8287E+01  2.3834E+00  3.9029E+00 -5.7600E+00  7.6993E-01 -3.5131E-02  8.7175E-02  1.5827E-01 -9.1929E-02 -2.1873E-01
            -1.4319E-01
 
0ITERATION NO.:   25    OBJECTIVE VALUE:   5551.09320438933        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      311
 NPARAMETR:  5.4466E+01  5.6268E-03  2.3296E-01  4.2431E+01  5.1413E+02  8.0402E-02  1.7803E-01  6.3312E-01  1.4410E-01  1.2396E+00
             3.4096E+01
 PARAMETER:  9.9029E-02  1.1254E-01  1.1648E-01  1.4144E-01  3.4275E-01  1.6927E-01 -4.1632E-01 -1.2855E-01  1.7359E-02  5.6405E-01
             1.9849E-01
 GRADIENT:  -2.2587E+00  3.9771E-01 -1.3104E+00  5.4520E-01 -1.9191E-01 -4.8391E-02 -7.1392E-02  7.2078E-02  3.9570E-02  5.5812E-02
            -1.8701E-01
 
0ITERATION NO.:   26    OBJECTIVE VALUE:   5551.09293641293        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      330
 NPARAMETR:  5.4468E+01  5.6253E-03  2.3307E-01  4.2528E+01  5.1596E+02  8.0401E-02  1.7869E-01  6.3274E-01  1.4354E-01  1.2364E+00
             3.4098E+01
 PARAMETER:  9.9033E-02  1.1251E-01  1.1654E-01  1.4176E-01  3.4397E-01  1.6926E-01 -4.1448E-01 -1.2885E-01  1.5411E-02  5.6277E-01
             1.9852E-01
 GRADIENT:  -8.5938E-01  2.3622E-01 -2.7896E-01 -1.7750E-02 -3.9383E-02 -3.0665E-02 -9.1964E-03  1.1802E-02 -6.9833E-03 -4.9810E-03
            -4.7997E-02
 
0ITERATION NO.:   27    OBJECTIVE VALUE:   5551.09292301775        NO. OF FUNC. EVALS.:  19
 CUMULATIVE NO. OF FUNC. EVALS.:      349
 NPARAMETR:  5.4469E+01  5.6246E-03  2.3309E-01  4.2558E+01  5.1660E+02  8.0404E-02  1.7880E-01  6.3265E-01  1.4337E-01  1.2363E+00
             3.4100E+01
 PARAMETER:  9.9034E-02  1.1249E-01  1.1655E-01  1.4186E-01  3.4440E-01  1.6929E-01 -4.1418E-01 -1.2892E-01  1.4801E-02  5.6273E-01
             1.9854E-01
 GRADIENT:   3.4053E-03  1.5890E-02 -3.4666E-02 -2.3116E-02 -6.8035E-03 -1.0392E-03  3.0250E-04 -2.8238E-03 -6.5510E-03 -3.0061E-03
             3.8963E-04
 
0ITERATION NO.:   28    OBJECTIVE VALUE:   5551.09292301775        NO. OF FUNC. EVALS.:  12
 CUMULATIVE NO. OF FUNC. EVALS.:      361
 NPARAMETR:  5.4469E+01  5.6246E-03  2.3309E-01  4.2558E+01  5.1660E+02  8.0404E-02  1.7880E-01  6.3265E-01  1.4337E-01  1.2363E+00
             3.4100E+01
 PARAMETER:  9.9034E-02  1.1249E-01  1.1655E-01  1.4186E-01  3.4440E-01  1.6929E-01 -4.1418E-01 -1.2892E-01  1.4801E-02  5.6273E-01
             1.9854E-01
 GRADIENT:   3.4053E-03  1.5890E-02 -3.4666E-02 -2.3116E-02 -6.8035E-03 -1.0392E-03  3.0250E-04 -2.8238E-03 -6.5510E-03 -3.0061E-03
             3.8963E-04
 
 #TERM:
0MINIMIZATION SUCCESSFUL
 NO. OF FUNCTION EVALUATIONS USED:      361
 NO. OF SIG. DIGITS IN FINAL EST.:  3.8

 ETABAR IS THE ARITHMETIC MEAN OF THE ETA-ESTIMATES,
 AND THE P-VALUE IS GIVEN FOR THE NULL HYPOTHESIS THAT THE TRUE MEAN IS 0.
 
 ETABAR:         1.8933E-02  9.2866E-03  1.5480E-01  3.3899E-02 -7.6325E-02
 SE:             1.5114E-02  7.3474E-03  3.3160E-02  7.3994E-03  2.3687E-02
 N:                     300         300         300         300         300
 
 P VAL.:         2.1032E-01  2.0625E-01  3.0416E-06  4.6258E-06  1.2720E-03
 
 ETASHRINKSD(%)  7.6788E+00  6.9904E+01  2.7791E+01  6.6152E+01  6.3101E+01
 ETASHRINKVR(%)  1.4768E+01  9.0942E+01  4.7859E+01  8.8543E+01  8.6385E+01
 EBVSHRINKSD(%)  6.2548E+00  6.9997E+01  2.7926E+01  6.9431E+01  5.7856E+01
 EBVSHRINKVR(%)  1.2118E+01  9.0998E+01  4.8053E+01  9.0655E+01  8.2239E+01
 RELATIVEINF(%)  8.6852E+01  8.7860E+00  3.2696E+01  9.4341E-01  1.5761E+00
 EPSSHRINKSD(%)  3.5983E+01
 EPSSHRINKVR(%)  5.9018E+01
 
  
 TOTAL DATA POINTS NORMALLY DISTRIBUTED (N):          900
 N*LOG(2PI) CONSTANT TO OBJECTIVE FUNCTION:    1654.08935976841     
 OBJECTIVE FUNCTION VALUE WITHOUT CONSTANT:    5551.09292301775     
 OBJECTIVE FUNCTION VALUE WITH CONSTANT:       7205.18228278616     
 REPORTED OBJECTIVE FUNCTION DOES NOT CONTAIN CONSTANT
  
 TOTAL EFFECTIVE ETAS (NIND*NETA):                          1500
  
 #TERE:
 Elapsed estimation  time in seconds:     8.02
 Elapsed covariance  time in seconds:     4.98
 Elapsed postprocess time in seconds:     0.00
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 #OBJT:**************                       MINIMUM VALUE OF OBJECTIVE FUNCTION                      ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 





 #OBJV:********************************************     5551.093       **************************************************
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                             FINAL PARAMETER ESTIMATE                           ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
         5.45E+01  5.62E-03  2.33E-01  4.26E+01  5.17E+02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        8.04E-02
 
 ETA2
+        0.00E+00  1.79E-01
 
 ETA3
+        0.00E+00  0.00E+00  6.33E-01
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  1.43E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.24E+00
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.41E+01
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        2.84E-01
 
 ETA2
+        0.00E+00  4.23E-01
 
 ETA3
+        0.00E+00  0.00E+00  7.95E-01
 
 ETA4
+        0.00E+00  0.00E+00  0.00E+00  3.79E-01
 
 ETA5
+        0.00E+00  0.00E+00  0.00E+00  0.00E+00  1.11E+00
 


 SIGMA - CORR MATRIX FOR RANDOM EFFECTS - EPSILONS  ***


         EPS1     
 
 EPS1
+        5.84E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                            STANDARD ERROR OF ESTIMATE                          ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 


 THETA - VECTOR OF FIXED EFFECTS PARAMETERS   *********


         TH 1      TH 2      TH 3      TH 4      TH 5     
 
         9.63E-01  5.16E-04  2.20E-02  1.20E+01  2.78E+02
 


 OMEGA - COV MATRIX FOR RANDOM EFFECTS - ETAS  ********


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        7.65E-03
 
 ETA2
+       .........  9.14E-02
 
 ETA3
+       ......... .........  9.49E-02
 
 ETA4
+       ......... ......... .........  9.65E-02
 
 ETA5
+       ......... ......... ......... .........  6.46E-01
 


 SIGMA - COV MATRIX FOR RANDOM EFFECTS - EPSILONS  ****


         EPS1     
 
 EPS1
+        3.03E+00
 
1


 OMEGA - CORR MATRIX FOR RANDOM EFFECTS - ETAS  *******


         ETA1      ETA2      ETA3      ETA4      ETA5     
 
 ETA1
+        1.35E-02
 
 ETA2
+       .........  1.08E-01
 
 ETA3
+       ......... .........  5.97E-02
 
 ETA4
+       ......... ......... .........  1.27E-01
 
 ETA5
+       ......... ......... ......... .........  2.90E-01
 


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
 

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM14      OM15      OM22      OM23  
             OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 TH 1
+        9.27E-01
 
 TH 2
+        1.07E-05  2.66E-07
 
 TH 3
+        2.15E-03 -1.54E-06  4.84E-04
 
 TH 4
+       -7.37E-02 -3.37E-04 -1.80E-02  1.44E+02
 
 TH 5
+       -1.57E+00 -1.12E-03 -1.88E+00  3.08E+03  7.71E+04
 
 OM11
+       -6.49E-04  7.27E-08 -7.45E-06  2.06E-04 -2.96E-03  5.85E-05
 
 OM12
+       ......... ......... ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.11E-03 -9.86E-06  2.52E-05  5.32E-02  8.65E-01  1.67E-05 ......... ......... ......... .........  8.36E-03
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+       -8.52E-03  3.24E-07 -1.21E-03  3.34E-02  4.56E+00  2.42E-05 ......... ......... ......... .........  3.62E-04 .........
         ......... .........  9.01E-03
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+        1.06E-03  1.99E-06  2.53E-04 -8.16E-01 -1.79E+01 -9.81E-06 ......... ......... ......... ......... -6.29E-04 .........
         ......... ......... -3.82E-04 ......... .........  9.31E-03
 
 OM45
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM14      OM15      OM22      OM23  
             OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 OM55
+       -7.81E-03 -1.55E-06 -4.17E-03 -1.05E+00  3.56E+00  4.75E-05 ......... ......... ......... .........  2.54E-03 .........
         ......... .........  5.71E-03 ......... ......... -2.37E-02 .........  4.17E-01
 
 SG11
+        8.92E-02  1.14E-04  3.58E-03 -1.31E+00 -3.02E+01 -2.69E-03 ......... ......... ......... ......... -9.83E-02 .........
         ......... ......... -3.35E-02 ......... .........  1.55E-02 ......... -1.11E-01  9.19E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                          CORRELATION MATRIX OF ESTIMATE                        ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM14      OM15      OM22      OM23  
             OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 TH 1
+        9.63E-01
 
 TH 2
+        2.15E-02  5.16E-04
 
 TH 3
+        1.01E-01 -1.36E-01  2.20E-02
 
 TH 4
+       -6.38E-03 -5.45E-02 -6.83E-02  1.20E+01
 
 TH 5
+       -5.89E-03 -7.82E-03 -3.08E-01  9.25E-01  2.78E+02
 
 OM11
+       -8.81E-02  1.84E-02 -4.43E-02  2.25E-03 -1.40E-03  7.65E-03
 
 OM12
+       ......... ......... ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+       -2.40E-02 -2.09E-01  1.25E-02  4.86E-02  3.41E-02  2.39E-02 ......... ......... ......... .........  9.14E-02
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+       -9.32E-02  6.62E-03 -5.77E-01  2.94E-02  1.73E-01  3.34E-02 ......... ......... ......... .........  4.18E-02 .........
         ......... .........  9.49E-02
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+        1.14E-02  3.99E-02  1.19E-01 -7.05E-01 -6.67E-01 -1.33E-02 ......... ......... ......... ......... -7.13E-02 .........
         ......... ......... -4.18E-02 ......... .........  9.65E-02
 
 OM45
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM14      OM15      OM22      OM23  
             OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 OM55
+       -1.26E-02 -4.64E-03 -2.93E-01 -1.36E-01  1.98E-02  9.62E-03 ......... ......... ......... .........  4.30E-02 .........
         ......... .........  9.31E-02 ......... ......... -3.81E-01 .........  6.46E-01
 
 SG11
+        3.06E-02  7.32E-02  5.37E-02 -3.60E-02 -3.59E-02 -1.16E-01 ......... ......... ......... ......... -3.55E-01 .........
         ......... ......... -1.16E-01 ......... .........  5.31E-02 ......... -5.68E-02  3.03E+00
 
1
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                      INVERSE COVARIANCE MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM14      OM15      OM22      OM23  
             OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 TH 1
+        1.11E+00
 
 TH 2
+       -5.71E+01  4.08E+06
 
 TH 3
+       -6.83E+00  1.76E+04  4.73E+03
 
 TH 4
+        2.43E-02  5.75E+01 -8.72E+00  1.27E-01
 
 TH 5
+       -1.11E-03 -1.48E+00  4.39E-01 -4.32E-03  1.79E-04
 
 OM11
+        1.11E+01 -5.85E+03  3.69E+02 -1.16E+00  6.28E-02  1.75E+04
 
 OM12
+       ......... ......... ......... ......... ......... ......... .........
 
 OM13
+       ......... ......... ......... ......... ......... ......... ......... .........
 
 OM14
+       ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM15
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM22
+        1.44E-01  4.52E+03 -9.37E+00 -3.39E-02  1.66E-03  2.34E+01 ......... ......... ......... .........  1.43E+02
 
 OM23
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
 
 OM24
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         .........
 
 OM25
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... .........
 
 OM33
+        5.62E-01  2.36E+03  4.25E+02  4.51E-01 -1.34E-02  4.38E+00 ......... ......... ......... ......... -1.94E+00 .........
         ......... .........  1.73E+02
 
 OM34
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... .........
 
 OM35
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... .........
 
 OM44
+        1.75E-01  2.32E+03  4.01E+00  4.41E+00 -7.68E-02  2.30E+01 ......... ......... ......... .........  5.91E+00 .........
         ......... .........  1.89E+01 ......... .........  4.40E+02
 
 OM45
+       ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... ......... .........
         ......... ......... ......... ......... ......... ......... .........
 
1

            TH 1      TH 2      TH 3      TH 4      TH 5      OM11      OM12      OM13      OM14      OM15      OM22      OM23  
             OM24      OM25      OM33      OM34      OM35      OM44      OM45      OM55      SG11  
 
 OM55
+        2.31E-02  4.21E+02  1.58E+01  5.18E-01 -1.23E-02  9.27E-01 ......... ......... ......... ......... -2.94E-01 .........
         ......... .........  4.36E+00 ......... .........  3.66E+01 .........  6.01E+00
 
 SG11
+       -7.67E-04  2.59E+00 -5.26E-02  6.12E-03 -1.98E-04  5.23E+00 ......... ......... ......... .........  1.46E+00 .........
         ......... .........  4.52E-01 ......... .........  1.82E-01 .........  4.55E-02  1.28E-01
 
1
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ************************************************************************************************************************
 ********************                                                                                ********************
 ********************               FIRST ORDER CONDITIONAL ESTIMATION WITH INTERACTION              ********************
 ********************                      EIGENVALUES OF COR MATRIX OF ESTIMATE                     ********************
 ********************                                                                                ********************
 ************************************************************************************************************************
 

             1         2         3         4         5         6         7         8         9        10        11
 
         3.05E-02  1.83E-01  4.04E-01  6.11E-01  8.45E-01  9.67E-01  1.03E+00  1.12E+00  1.46E+00  1.67E+00  2.68E+00
 
 Elapsed finaloutput time in seconds:     0.02
 #CPUT: Total CPU Time in Seconds,       12.844
Stop Time: 
Mon 03/20/2023 
07:14 PM
