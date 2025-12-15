Tue 09/24/2024 
04:20 PM
;DDE
;NN1=100
;PRC=0.01
;DISTRIB=WEIBULLCDF(VG)
$SIZES PC=110
$PROBLEM LOGISTIC Distributed transit compartments on Smax Drug Responsive Input function
; turn off second derivative assessments, sometimes even 1st derivatives if only simulating
$ABBR DERIV2=NO DERIV2=NOCOMMON DERIV1=NO
$INPUT ID AMT TIME DV EVID MDV
$DATA smax_weibull.dat IGNORE=C
$SUBROUTINES ADVAN13 TOL=10 ATOL=10 
$MODEL NCOMPARTMENTS=2

$PK
CALLFL=-2
MXSTEP=2000000000
SMAX=THETA(1)
SC50=THETA(2)
KIN0=THETA(3)
AA=THETA(4)
BB=THETA(5)
Vmax = 2
V50 = 3
V = 1

VG(2)=AA
VG(3)=BB

; Initial conditions
A_0(1)=0.0
A_0(2)=5.0

$DES
VG(2)=AA
VG(3)=BB

  ; AD_1_1 is the State value of A(1) delayed for time TAU1.
  ; AP_1_1 is the State value of A(1) in the past, for time delay TAU1.


; DELAY SETUP FOR EQUATION SET 1
 c = A(1)/V
 kin = kin0*(1.0+(Smax*c)/(SC50+c))
 APG_KIN_1=KIN0

 DADT(1) = -(Vmax*A(1))/(V50+A(1))
 DADT(2) = kin - ADG_KIN_1

$ERROR
A1=A(2)


Y1=1.0
IPRED=A(2)
Y=IPRED*(1.0+EPS(1))

$THETA
0.5
10.0
0.8
7.0
6.5

$OMEGA (0.0 fixed)x4

$SIGMA (0.0 fixed)

$SIML (122345) ONLYSIM SUBP=1

$TABLE TIME KIN IPRED NOPRINT NOAPPEND FILE=smax_weibulldt.tab ONEHEADER FORMAT=S1PE20.13
  
NM-TRAN MESSAGES 
 WARNING: -prdefault OPTION IS OVER-RIDING USER SPECIFIED PC VALUE OF 110 WITH 30
THEREFORE OVER-RIDING -prdefault
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  84) VALUES HAVE NOT BEEN ASSIGNED TO THE FOLLOWING ELEMENTS IN
 ABBREVIATED CODE:
  
   VG(4) VG(5) VG(6) VG(7) VG(8) VG(9) VG(10) VG(11)

             
 (WARNING  46) ETA VARIABLES ARE NOT USED, BUT DATA ARE POPULATION TYPE.
             
 (WARNING  48) DES-DEFINED ITEMS ARE COMPUTED ONLY WHEN EVENT TIME
 INCREASES. E.G., DISPLAYED VALUES ASSOCIATED WITH THE FIRST EVENT RECORD
 OF AN INDIVIDUAL RECORD ARE COMPUTED WITH (THE LAST ADVANCE TO) AN EVENT
 TIME OF THE PRIOR INDIVIDUAL RECORD.
             
 (WARNING  83) FUNCTIONS ARE USED IN ABBREVIATED CODE, BUT THE $SUBROUTINES
 RECORD DOES NOT INCLUDE THE "OTHER" OPTION.
  
License Registered to: NONMEM license (with RADAR5NM) for ICON Pharmacometrics Team
Expiration Date:    31 DEC 2030
Current Date:       24 SEP 2024
Days until program expires :2287
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.2
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 LOGISTIC Distributed transit compartments on Smax Drug Responsive Input
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 CREATE/ADD TO FDATA.csv:        YES
 NO. OF DATA RECS IN DATA SET:       33
 NO. OF DATA ITEMS IN DATA SET:   6
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   4
 MDV DATA ITEM IS DATA ITEM NO.:  6
0INDICES PASSED TO SUBROUTINE PRED:
   5   3   2   0   0   0   0   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID AMT TIME DV EVID MDV
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 KIN IPRED
0FORMAT FOR DATA:
 (6E5.0)

 TOT. NO. OF OBS RECS:       32
 TOT. NO. OF INDIVIDUALS:        1
0LENGTH OF THETA:   5
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   4
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.5000E+00  0.1000E+02  0.8000E+00  0.7000E+01  0.6500E+01
0INITIAL ESTIMATE OF OMEGA:
 0.0000E+00
 0.0000E+00   0.0000E+00
 0.0000E+00   0.0000E+00   0.0000E+00
 0.0000E+00   0.0000E+00   0.0000E+00   0.0000E+00
0OMEGA CONSTRAINED TO BE THIS INITIAL ESTIMATE
0INITIAL ESTIMATE OF SIGMA:
 0.0000E+00
0SIGMA CONSTRAINED TO BE THIS INITIAL ESTIMATE
0SIMULATION STEP OMITTED:    NO
 OBJ FUNC EVALUATED:         NO
 ORIGINAL DATA USED ON EACH NEW SIMULATION:         NO
 SEEDS RESET ON EACH NEW SUPERSET ITERATION:        YES
0SIMULATION RANDOM METHOD SELECTED (RANMETHOD): 4U
SEED   1 RESET TO INITIAL: YES
 SOURCE   1:
   SEED1:        122345   SEED2:             0   PSEUDO-NORMAL
 NUMBER OF SUBPROBLEMS:    1
0WARNING: NO. OF OBS RECS IN INDIVIDUAL REC NO.      1 (IN INDIVIDUAL
 REC ORDERING) EXCEEDS ONE WHILE INITIAL ESTIMATE OF WITHIN INDIVIDUAL VARIANCE IS ZERO
0TABLES STEP OMITTED:    NO
 NO. OF TABLES:           1
 SEED NUMBER (SEED):    11456
 NPDTYPE:    0
 INTERPTYPE:    0
 RANMETHOD:             3U
 MC SAMPLES (ESAMPLE):    300
 WRES SQUARE ROOT TYPE (WRESCHOL): EIGENVALUE
0-- TABLE   1 --
0RECORDS ONLY:    ALL
04 COLUMNS APPENDED:    NO
 PRINTED:                NO
 HEADER:                YES
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE20.13
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 TIME KIN IPRED
1DOUBLE PRECISION PREDPP VERSION 7.5.2

 GENERAL NONLINEAR KINETICS MODEL WITH STIFF/NONSTIFF EQUATIONS (LSODA, ADVAN13)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:   8
0COMPARTMENT ATTRIBUTES
 COMPT. NO.   FUNCTION   INITIAL    ON/OFF      DOSE      DEFAULT    DEFAULT
                         STATUS     ALLOWED    ALLOWED    FOR DOSE   FOR OBS.
    1         COMP 1       ON         YES        YES        YES        YES
    2         COMP 2       ON         YES        YES        NO         NO
    3         COMP 3       ON         YES        YES        NO         NO
    4         COMP 4       ON         YES        YES        NO         NO
    5         COMP 5       ON         YES        YES        NO         NO
    6         COMP 6       ON         YES        YES        NO         NO
    7         COMP 7       ON         YES        YES        NO         NO
    8         COMP 8       ON         YES        YES        NO         NO
    9         COMP 9       ON         YES        YES        NO         NO
   10         COMP 10      ON         YES        YES        NO         NO
   11         COMP 11      ON         YES        YES        NO         NO
   12         COMP 12      ON         YES        YES        NO         NO
   13         COMP 13      ON         YES        YES        NO         NO
   14         COMP 14      ON         YES        YES        NO         NO
   15         COMP 15      ON         YES        YES        NO         NO
   16         COMP 16      ON         YES        YES        NO         NO
   17         COMP 17      ON         YES        YES        NO         NO
   18         COMP 18      ON         YES        YES        NO         NO
   19         COMP 19      ON         YES        YES        NO         NO
   20         COMP 20      ON         YES        YES        NO         NO
   21         COMP 21      ON         YES        YES        NO         NO
   22         COMP 22      ON         YES        YES        NO         NO
   23         COMP 23      ON         YES        YES        NO         NO
   24         COMP 24      ON         YES        YES        NO         NO
   25         COMP 25      ON         YES        YES        NO         NO
   26         COMP 26      ON         YES        YES        NO         NO
   27         COMP 27      ON         YES        YES        NO         NO
   28         COMP 28      ON         YES        YES        NO         NO
   29         COMP 29      ON         YES        YES        NO         NO
   30         COMP 30      ON         YES        YES        NO         NO
   31         COMP 31      ON         YES        YES        NO         NO
   32         COMP 32      ON         YES        YES        NO         NO
   33         COMP 33      ON         YES        YES        NO         NO
   34         COMP 34      ON         YES        YES        NO         NO
   35         COMP 35      ON         YES        YES        NO         NO
   36         COMP 36      ON         YES        YES        NO         NO
   37         COMP 37      ON         YES        YES        NO         NO
   38         COMP 38      ON         YES        YES        NO         NO
   39         COMP 39      ON         YES        YES        NO         NO
   40         COMP 40      ON         YES        YES        NO         NO
   41         COMP 41      ON         YES        YES        NO         NO
   42         COMP 42      ON         YES        YES        NO         NO
   43         COMP 43      ON         YES        YES        NO         NO
   44         COMP 44      ON         YES        YES        NO         NO
   45         COMP 45      ON         YES        YES        NO         NO
   46         COMP 46      ON         YES        YES        NO         NO
   47         COMP 47      ON         YES        YES        NO         NO
   48         COMP 48      ON         YES        YES        NO         NO
   49         COMP 49      ON         YES        YES        NO         NO
   50         COMP 50      ON         YES        YES        NO         NO
   51         COMP 51      ON         YES        YES        NO         NO
   52         COMP 52      ON         YES        YES        NO         NO
   53         COMP 53      ON         YES        YES        NO         NO
   54         COMP 54      ON         YES        YES        NO         NO
   55         COMP 55      ON         YES        YES        NO         NO
   56         COMP 56      ON         YES        YES        NO         NO
   57         COMP 57      ON         YES        YES        NO         NO
   58         COMP 58      ON         YES        YES        NO         NO
   59         COMP 59      ON         YES        YES        NO         NO
   60         COMP 60      ON         YES        YES        NO         NO
   61         COMP 61      ON         YES        YES        NO         NO
   62         COMP 62      ON         YES        YES        NO         NO
   63         COMP 63      ON         YES        YES        NO         NO
   64         COMP 64      ON         YES        YES        NO         NO
   65         COMP 65      ON         YES        YES        NO         NO
   66         COMP 66      ON         YES        YES        NO         NO
   67         COMP 67      ON         YES        YES        NO         NO
   68         COMP 68      ON         YES        YES        NO         NO
   69         COMP 69      ON         YES        YES        NO         NO
   70         COMP 70      ON         YES        YES        NO         NO
   71         COMP 71      ON         YES        YES        NO         NO
   72         COMP 72      ON         YES        YES        NO         NO
   73         COMP 73      ON         YES        YES        NO         NO
   74         COMP 74      ON         YES        YES        NO         NO
   75         COMP 75      ON         YES        YES        NO         NO
   76         COMP 76      ON         YES        YES        NO         NO
   77         COMP 77      ON         YES        YES        NO         NO
   78         COMP 78      ON         YES        YES        NO         NO
   79         COMP 79      ON         YES        YES        NO         NO
   80         COMP 80      ON         YES        YES        NO         NO
   81         COMP 81      ON         YES        YES        NO         NO
   82         COMP 82      ON         YES        YES        NO         NO
   83         COMP 83      ON         YES        YES        NO         NO
   84         COMP 84      ON         YES        YES        NO         NO
   85         COMP 85      ON         YES        YES        NO         NO
   86         COMP 86      ON         YES        YES        NO         NO
   87         COMP 87      ON         YES        YES        NO         NO
   88         COMP 88      ON         YES        YES        NO         NO
   89         COMP 89      ON         YES        YES        NO         NO
   90         COMP 90      ON         YES        YES        NO         NO
   91         COMP 91      ON         YES        YES        NO         NO
   92         COMP 92      ON         YES        YES        NO         NO
   93         COMP 93      ON         YES        YES        NO         NO
   94         COMP 94      ON         YES        YES        NO         NO
   95         COMP 95      ON         YES        YES        NO         NO
   96         COMP 96      ON         YES        YES        NO         NO
   97         COMP 97      ON         YES        YES        NO         NO
   98         COMP 98      ON         YES        YES        NO         NO
   99         COMP 99      ON         YES        YES        NO         NO
  100         COMP 100     ON         YES        YES        NO         NO
  101         COMP 101     ON         YES        YES        NO         NO
  102         COMP 102     ON         YES        YES        NO         NO
  103         OUTPUT       OFF        YES        NO         NO         NO
 INITIAL (BASE) TOLERANCE SETTINGS:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  10
1
 ADDITIONAL PK PARAMETERS - ASSIGNMENT OF ROWS IN GG
 COMPT. NO.                             INDICES
              SCALE      BIOAVAIL.   ZERO-ORDER  ZERO-ORDER  ABSORB
                         FRACTION    RATE        DURATION    LAG
    1            *           *           *           *           *
    2            *           *           *           *           *
    3            *           *           *           *           *
    4            *           *           *           *           *
    5            *           *           *           *           *
    6            *           *           *           *           *
    7            *           *           *           *           *
    8            *           *           *           *           *
    9            *           *           *           *           *
   10            *           *           *           *           *
   11            *           *           *           *           *
   12            *           *           *           *           *
   13            *           *           *           *           *
   14            *           *           *           *           *
   15            *           *           *           *           *
   16            *           *           *           *           *
   17            *           *           *           *           *
   18            *           *           *           *           *
   19            *           *           *           *           *
   20            *           *           *           *           *
   21            *           *           *           *           *
   22            *           *           *           *           *
   23            *           *           *           *           *
   24            *           *           *           *           *
   25            *           *           *           *           *
   26            *           *           *           *           *
   27            *           *           *           *           *
   28            *           *           *           *           *
   29            *           *           *           *           *
   30            *           *           *           *           *
   31            *           *           *           *           *
   32            *           *           *           *           *
   33            *           *           *           *           *
   34            *           *           *           *           *
   35            *           *           *           *           *
   36            *           *           *           *           *
   37            *           *           *           *           *
   38            *           *           *           *           *
   39            *           *           *           *           *
   40            *           *           *           *           *
   41            *           *           *           *           *
   42            *           *           *           *           *
   43            *           *           *           *           *
   44            *           *           *           *           *
   45            *           *           *           *           *
   46            *           *           *           *           *
   47            *           *           *           *           *
   48            *           *           *           *           *
   49            *           *           *           *           *
   50            *           *           *           *           *
   51            *           *           *           *           *
   52            *           *           *           *           *
   53            *           *           *           *           *
   54            *           *           *           *           *
   55            *           *           *           *           *
   56            *           *           *           *           *
   57            *           *           *           *           *
   58            *           *           *           *           *
   59            *           *           *           *           *
   60            *           *           *           *           *
   61            *           *           *           *           *
   62            *           *           *           *           *
   63            *           *           *           *           *
   64            *           *           *           *           *
   65            *           *           *           *           *
   66            *           *           *           *           *
   67            *           *           *           *           *
   68            *           *           *           *           *
   69            *           *           *           *           *
   70            *           *           *           *           *
   71            *           *           *           *           *
   72            *           *           *           *           *
   73            *           *           *           *           *
   74            *           *           *           *           *
   75            *           *           *           *           *
   76            *           *           *           *           *
   77            *           *           *           *           *
   78            *           *           *           *           *
   79            *           *           *           *           *
   80            *           *           *           *           *
   81            *           *           *           *           *
   82            *           *           *           *           *
   83            *           *           *           *           *
   84            *           *           *           *           *
   85            *           *           *           *           *
   86            *           *           *           *           *
   87            *           *           *           *           *
   88            *           *           *           *           *
   89            *           *           *           *           *
   90            *           *           *           *           *
   91            *           *           *           *           *
   92            *           *           *           *           *
   93            *           *           *           *           *
   94            *           *           *           *           *
   95            *           *           *           *           *
   96            *           *           *           *           *
   97            *           *           *           *           *
   98            *           *           *           *           *
   99            *           *           *           *           *
  100            *           *           *           *           *
  101            *           *           *           *           *
  102            *           *           *           *           *
  103            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      5
   TIME DATA ITEM IS DATA ITEM NO.:          3
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   2

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE CALLED AT NONEVENT (ADDITIONAL AND LAGGED) DOSE TIMES.
0PK SUBROUTINE INDICATES THAT COMPARTMENT AMOUNTS ARE INITIALIZED.
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
0DES SUBROUTINE USES COMPACT STORAGE MODE.
 TOLERANCES FOR SIMULATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  10
 TOLERANCES FOR TABLE/SCATTER STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:  10
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:  10
1
 PROBLEM NO.:           1      SUBPROBLEM NO.:           1

 SIMULATION STEP PERFORMED
 SOURCE  1:
    SEED1:      87840084   SEED2:    1072350630
 Elapsed simulation  time in seconds:     0.38
 ESTIMATION STEP OMITTED:                 YES
 Elapsed finaloutput time in seconds:     0.01
 #CPUT: Total CPU Time in Seconds,        0.500
Stop Time: 
Tue 09/24/2024 
04:20 PM
