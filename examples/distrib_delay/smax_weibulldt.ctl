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
