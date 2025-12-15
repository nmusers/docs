; Based on sde_ex2_base.ctl, using SDE.f90 OTHER file, and .dat file modified.  From Christoffer Tornoe, example 2
$PROBLEM PK ODE HANDS ON ONE
$ABBR DES=FULL ; Must have this, so DA array is simple-mapped.

$INPUT ID TIME DV AMT CMT FLAG MDV SDE ; Add SDE data item.  Should have values between 0 and 5, as described in comments of SDE.f90
; The data item SDE must be added. It has values of 0,1,2,3,4, or 5:
; SDE (SDE data item)=0, BEGINNING OF SUBJECT, OR WHENEVER YOU WANT TO INITIALIZE SDE SYSTEM (SOMETIMES YOU WANT TO DO THIS
; EVEN WITHIN A SUBJECT, LIKE A NEW OCCASION)
; SDE=1, FIRST OBSERVATION OF PRESENT TIME.
; SDE=2 LAST OBSERVATION FOR PRESENT TIME.
; SDE=5 FIRST AND LAST OBSERVATION FOR PRESENT TIME.
; SDE=6, MIDDLE OBSERVAION FOR PRESENT TIME.
; THUS:
; DOSE RECORD, TIME=0, THEN SDE=0
; PK OBSERVATION, TIME=0.1, SDE=1
; PD OBSERVATION, TIME=0.1, SDE=6
; EFFICACY OBSERVATION, TIME=0.1, SDE=2  (SDE=2 SINCE NEXT RECORD HAS A NEW TIME)
; PK OBSERVATION, TIME=0.2, SDE=1
; PD OBSERVATION, TIME=0.2, SDE=2
; PK OBSERVATION, TIME=0.5, SDE=5
; PK OBSERVATION, TIME=1.0, SDE=5

$DATA   sde_ex2o.dat
        IGNORE=@

$SUBROUTINE ADVAN6 TOL=9 DP OTHER=SDE.f90

; nde=number of base equations, ncmt=number of observation compartments
$ABBR DECLARE SGW(3) ; need at least nde of these
$MODEL 
       COMP = (CENTRAL); there are nde base states from original sde_ex2_base.ctl
       COMP = (DFDX1)  ; need to add ncmt observation compartments for SDE
       COMP = (DPDT11) ; Will need (nde+1)*nde/2 of these for SDE

$PK
  IF(NEWIND.NE.2) OT = 0
   
  MU_1  = THETA(1)
  CL    = EXP(MU_1+ETA(1)) 
  MU_2  = THETA(2)
  VD    = EXP(MU_2+ETA(2))
  SGW1 = THETA(4) ;  Add estimable scalar for modeling the SDE noise.
  NCMT=1.0 ; number of compartments.  Added for calls to SDE_DER and SDE_CADD
  NDE=1.0 ; Number of original, base ODEs.  Added for calls to SDE_DER and SDE_CADD


$DES
 FIRSTEM=1 ; MAke sure FIRSTEM=1 so that DA arrays (Derivatives of DADT() wrt A()), are calculated, even when IMP is done.
 DADT(1) = - CL/VD*A(1) ; Original base derivative from sde_ex2_base.ctl
; NEXT DERIVATIVES ARE ACUALLY PREDICTIVE VALUES FOR COMPARTMENTS 1 AND 2, RESPECTIVELY
;  Derivatives of these with respect to A() will be calculated symbolically by DES routine created by NMTRAN
 DADT(2) = A(1)/VD ;  Add output equations, required for each CMT value.
; DUMMY PLACEMENT FOR DERIVATIVES OF THE STOCHASTIC ERROR SYSTEM.  THESE ARE FILLED OUT BY SDE_DER
SGW(1)=SGW1 ; Specify SGW with appropriate index , for appropriate DES equation number
;  the DA() array THEN contains all derivatives of DADT (=DXDT) with respect to A(=X).
; number of base model derivative equations (nde)=1, Number of compartments (ncmt)=1. 
; DA is a reserved array, dimensioned DA(IR,*)
"LAST
"      CALL SDE_DER(DADT,A,DA,IR,SGW,NDE,NCMT)
 
$ERROR (OBS ONLY)
  
     IPRED = A(1)/VD
     IRES  = DV - IPRED
     W     = THETA(3)
     IWRES = IRES/W
     WS=1000.0
; CENTRAL COMPARTMENT, PLASMA LEVELS
; EPS(1) = USER MODEL ERROR CONTRIBUTION
; EPS(2) = STOCHASTIC ERROR CONTRIBUTION.  THE WS IS JUST A PLACEHOLDER COEFFICIENT.  SDE_CADD WILL REPLACE THIS
; WITH THE CORRECT VALUE
     Y     = IPRED+W*EPS(1) + WS*EPS(2)
; SDE_CADD WILL EVALUATE THE TRUE COEFFICIENTS (WS) TO THE STOCHASTIC COMPONENTS.
;  In general, if you have nmcmt observation compartments, then first ncmt EPS() will pertain to
; measurement error, and the second ncmt set of EPS() will pertain to stochastic errors.
;  This means you cannot have L2 type correlations, and prop+additive should be packaged into a single EPS().
;  For two obervations, you may have:
;  IF(CMT==1) THEN
;  IPRED=A(1)/V
;  W=SQRT(THETA((5)*THETA(5)*IPED*IPRED+THETA(6)*THETA(6))
;  Y=IPRED+W*EPS(1)+WS*EPS(3)
;  ENDIF
;  IF(CMT==2) THEN
;  IPRED=A(2)/V
;  W=SQRT(THETA((7)*THETA(7)*IPED*IPRED+THETA(8)*THETA(8))
;  Y=IPRED+W*EPS(2)+WS*EPS(4)
;  ENDIF

; Number of compartments=1, number of base model derivative equations=1
"LAST
"       CALL SDE_CADD(A,HH,TIME,DV,CMT,NDE,NCMT,SDE)



$THETA (0,2.3)               ;1 CL
$THETA (0,3.5)               ;2 VD
$THETA (0, 2)               ;4 SIGMA
$THETA (0,1) ; SGW1

$OMEGA 0.1                  ;1 CL
$OMEGA 0.01                 ;2 VD

$SIGMA (1 FIX) (1 FIX)               ; PK

$EST METHOD=ITS INTERACTION LAPLACE NUMERICAL SLOW NOABORT PRINT=1 CTYPE=3 SIGL=5
$EST METHOD=IMP INTERACTION NOABORT SIGL=5 PRINT=1 IACCEPT=1.0 CTYPE=3
$EST MAXEVAL=9999 METHOD=1 LAPLACE INTER NOABORT NUMERICAL SLOW NSIG=3 PRINT=1 SIGL=9
$COV MATRIX=R UNCONDITIONAL

$TABLE ID TIME FLAG AMT CMT IPRED IRES IWRES
       ONEHEADER NOPRINT FILE=sde_ex2_impo.tab
