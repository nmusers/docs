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
