;DDE
$PROBLEM Discrete Delay on Smax Drug Responsive Input function
; turn off second derivative assessments, sometimes even 1st derivatives if only simulating
$ABBR DERIV2=NO DERIV2=NOCOMMON DERIV1=NO
$INPUT ID AMT TIME DV EVID MDV
$DATA smax_discrete.dat IGNORE=C
$SUBROUTINES ADVAN18 TOL=10 ATOL=10 ; OTHER=ddeslvu.f90
$MODEL NCOMPARTMENTS=2

$PK
CALLFL=-2
MXSTEP=2000000000
SMAX=THETA(1)
SC50=THETA(2)
KIN0=THETA(3)
AA=THETA(4)
BB=THETA(5)
TAU1 = aa*dexp(gamln(1.0+1.0/bb))

Vmax = 2
V50 = 3
V = 1

; Initial conditions
A_0(1)=0.0
A_0(2)=5.0

$DES
AP_1_1=0.0
 c = A(1)/V
 kin = kin0*(1.0+(Smax*c)/(SC50+c))
 cdelay=AD_1_1/V
 kindelay=kin0*(1.0+(Smax*cdelay)/(SC50+cdelay))

 DADT(1) = -(Vmax*A(1))/(V50+A(1))
 DADT(2) = kin - kindelay

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
$TABLE TIME KIN IPRED NOPRINT NOAPPEND FILE=smax_discrete.tab ONEHEADER FORMAT=S1PE20.13
