;DDE
;Define as a comment the largest size for NU1 that one is likely to need.
;ddexpand will create up to 10 transfer compartments for this example. 
; Specify as ;NNx or ;NUx
;NN1=10
$PROBLEM LOGISTIC with fractional transit compartments
; turn off second derivative assessments, sometimes even 1st derivatives if only simulating
$ABBR DERIV2=NO DERIV2=NOCOMMON ; DERIV1=NO 
$INPUT ID AMT TIME PRDV DV EVID MDV 
$DATA logt.dat IGNORE=C
$SUBROUTINES ADVAN16 TOL=10 ATOL=10 ; OTHER=ddeslvu.f90
$MODEL NCOMPARTMENTS=1

$PK
CALLFL=-2
MXSTEP=2000000000
KG=THETA(1)
Y0=THETA(2)
YSS=THETA(3)
TAU1=THETA(4)
; The NU1 specified here should be no greater than the NN1 transit compartments
; defined in the comment earlier.  
NU1=2.5

; Initial conditions
A_0(1)=Y0


$DES
; AD_1_1 is the State value of A(1) delayed for time TAU1.
; AP_1_1 is the State value of A(1) in the past, for time delay TAU1.

 APT_1_1=Y0
 DADT(1)=KG*(1.0-ADT_1_1/YSS)*A(1)

$ERROR
A1=A(1)


Y1=1.0
IPRED=A(1)
Y=IPRED*(1.0+EPS(1))

$THETA
0.2D+00
1.0D+00
10.0D+00
5.0D+00

$OMEGA (0.0 fixed)x4

$SIGMA (0.0 fixed)

$SIML (122345) ONLYSIM SUBP=1

$TABLE TIME ID IPRED NOPRINT NOAPPEND FILE=logt.tab ONEHEADER
