Tue 09/24/2024 
04:29 PM
;DDE
;NN1=27
;PRC1=0.01
;DISTRIB1=WEIBULLCDF(VG)
$PROBLEM LOGISTIC with distributed transit compartments
; turn off second derivative assessments, sometimes even 1st derivatives if only simulating
$ABBR DERIV2=NO DERIV2=NOCOMMON ; DERIV1=NO 
$INPUT ID AMT TIME PRDV DV EVID MDV 
$DATA logt.dat IGNORE=C
$SUBROUTINES ADVAN15 TOL=10 ATOL=10 ; OTHER=ddeslvu.f90
$MODEL NCOMPARTMENTS=1

$PK
CALLFL=-2
MXSTEP=2000000000
KG=THETA(1)
Y0=THETA(2)
YSS=THETA(3)
TAU1=THETA(4)
NU1=2.5
; Define parameters to Weibull distribution
VG(2)=NU1
VG(3)=TAU1

; Initial conditions
A_0(1)=Y0


$DES
; Define parameters to Weibull distribution again, for $DES record
VG(2)=NU1
VG(3)=TAU1
; ADG_1_1 is the State value of A(1) delayed for time TAU1, using a general distribution.
; APG_1_1 is the State value of A(1) in the past, for time delay TAU1.

 APG_1_1=Y0

 DADT(1)=KG*(1.0-ADG_1_1/YSS)*A(1)

$ERROR
A1=A(1)


Y1=1.0
IPRED=A(1)
Y=IPRED*(1.0+EPS(1))

$THETA
0.2D+00
1.0D+00
10.0D+00
2.0D+00

$OMEGA (0.0 fixed)x4

$SIGMA (0.0 fixed)

$SIML (122345) ONLYSIM SUBP=1

$TABLE TIME IPRED NOPRINT NOAPPEND FILE=logdt.tab ONEHEADER FORMAT=S1PE20.13
  
NM-TRAN MESSAGES 
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  84) VALUES HAVE NOT BEEN ASSIGNED TO THE FOLLOWING ELEMENTS IN
 ABBREVIATED CODE:
  
   VG(4) VG(5) VG(6) VG(7) VG(8) VG(9) VG(10) VG(11)

             
 (WARNING  46) ETA VARIABLES ARE NOT USED, BUT DATA ARE POPULATION TYPE.
             
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
 LOGISTIC with distributed transit compartments
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 CREATE/ADD TO FDATA.csv:        YES
 NO. OF DATA RECS IN DATA SET:       60
 NO. OF DATA ITEMS IN DATA SET:   7
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   5
 MDV DATA ITEM IS DATA ITEM NO.:  7
0INDICES PASSED TO SUBROUTINE PRED:
   6   3   2   0   0   0   0   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID AMT TIME PRDV DV EVID MDV
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 IPRED
0FORMAT FOR DATA:
 (5E14.0/2E14.0)

 TOT. NO. OF OBS RECS:       60
 TOT. NO. OF INDIVIDUALS:        1
0LENGTH OF THETA:   4
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   4
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.2000E+00  0.1000E+01  0.1000E+02  0.2000E+01
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
 TIME IPRED
1DOUBLE PRECISION PREDPP VERSION 7.5.2

 GENERAL NONLINEAR KINETICS MODEL WITH EQUILIBRIUM COMPARTMENTS (IDAS, ADVAN15)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:   5
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
   29         OUTPUT       OFF        YES        NO         NO         NO
0COMPT. NO.   FUNCTION   EQUILIB    EXCLUDE
                          RIUM      FROM TOTAL
    1         COMP 1       NO         NO
    2         COMP 2       NO         NO
    3         COMP 3       NO         NO
    4         COMP 4       NO         NO
    5         COMP 5       NO         NO
    6         COMP 6       NO         NO
    7         COMP 7       NO         NO
    8         COMP 8       NO         NO
    9         COMP 9       NO         NO
   10         COMP 10      NO         NO
   11         COMP 11      NO         NO
   12         COMP 12      NO         NO
   13         COMP 13      NO         NO
   14         COMP 14      NO         NO
   15         COMP 15      NO         NO
   16         COMP 16      NO         NO
   17         COMP 17      NO         NO
   18         COMP 18      NO         NO
   19         COMP 19      NO         NO
   20         COMP 20      NO         NO
   21         COMP 21      NO         NO
   22         COMP 22      NO         NO
   23         COMP 23      NO         NO
   24         COMP 24      NO         NO
   25         COMP 25      NO         NO
   26         COMP 26      NO         NO
   27         COMP 27      NO         NO
   28         COMP 28      NO         NO
   29         OUTPUT       NO         YES
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
   29            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      6
   TIME DATA ITEM IS DATA ITEM NO.:          3
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   2

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE CALLED AT NONEVENT (ADDITIONAL AND LAGGED) DOSE TIMES.
0PK SUBROUTINE INDICATES THAT COMPARTMENT AMOUNTS ARE INITIALIZED.
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
0DES SUBROUTINE USES FULL STORAGE MODE.
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
    SEED1:     182936576   SEED2:             0
 Elapsed simulation  time in seconds:     1.29
 ESTIMATION STEP OMITTED:                 YES
 Elapsed finaloutput time in seconds:     0.01
 #CPUT: Total CPU Time in Seconds,        1.375
Stop Time: 
Tue 09/24/2024 
04:29 PM
