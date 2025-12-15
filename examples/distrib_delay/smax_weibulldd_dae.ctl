;DDE
;NN1=100
;PRC=0.01
;DISTRIB=WEIBULLCDF(VG,2)
$PROBLEM LOGISTIC Distributed discrete delay on Smax Drug Responsive Input function using dae
; turn off second derivative assessments, sometimes even 1st derivatives if only simulating
$ABBR DERIV2=NO DERIV2=NOCOMMON
$INPUT ID AMT TIME DV EVID MDV
$DATA smax_weibull.dat IGNORE=C
$SUBROUTINES ADVAN17 TOL=6 ATOL=6
$MODEL NCOMPARTMENTS=3
       COMP(COMP1)
       COMP(COMP2)
       COMP(COMP3 EQUILIBRIUM)

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

; Initial conditions
A_0(1)=0.0
A_0(2)=5.0
; KIN at time 0 actually contains the bolus dose contribution into A(1).
; So it is not kin0, but rather;

$DES
VG(2)=AA
VG(3)=BB

 APG_3_1=kin0

 DADT(1) = -(Vmax*A(1))/(V50+A(1))
 DADT(2) = A(3) - ADG_3_1

$AESINIT
INIT=0

$AES
 c = A(1)/V
 kin = kin0*(1.0+(Smax*c)/(SC50+c))
E(3)=A(3)-kin


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

$TABLE TIME KIN IPRED NOPRINT NOAPPEND FILE=smax_weibulldd_dae.tab ONEHEADER FORMAT=S1PE20.13
