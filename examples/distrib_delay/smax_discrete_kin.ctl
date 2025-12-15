;DDE
$PROBLEM Discrete Delay on Smax Drug Responsive Input function kin
; turn off second derivative assessments, sometimes even 1st derivatives if only simulating
$ABBR DERIV2=NO DERIV2=NOCOMMON
$INPUT ID AMT TIME DV EVID MDV
$DATA smax_discrete.dat IGNORE=C
$SUBROUTINES ADVAN16 TOL=10 ATOL=10
$MODEL NCOMPARTMENTS=3

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
TAU1 = aa*dexp(gamln(1.0+1.0/bb))

; Initial conditions
A_0(1)=0.0
A_0(2)=5.0
; KIN at time 0 actually contains the bolus dose contribution into A(1).
; So it is not kin0, but rather;
CCC = AMT/V
A_0(3)=kin0*(1.0+(Smax*ccc)/(SC50+ccc))

$DES
 c = A(1)/V
; DERIVATIVE OF A WRT T, WHICH EQUALS V TIMES DERIVATIVE OF C WRT T
 DADT1=-(Vmax*A(1))/(V50+A(1))
; DERIVATIVE OF KIN WRT C
 DKINC=KIN0*SMAX*SC50/(SC50+C)/(SC50+C)

; The past, is when T<0, so before the bolus dose into A(1) is given, which is:
 AP_3_1=KIN0

 DADT(1) = DADT1
; DERIVATIVE OF KIN WRT C TIMES DERIVATIVE OF C WRT T YIELDS DERIVATIVE OF KIN WRT T
 DADT(3) = DKINC*DADT1/V
; SUBMIT STATE VARIABLE A(3), WHICH REPRESENTS KIN, FOR WEIBULL-DISTRIBUTED DELAY
 DADT(2) = A(3) - AD_3_1

$ERROR
CC = A(1)/V
kin = kin0*(1.0+(Smax*cc)/(SC50+cc))
A1=A(2)
KINCALC=A(3)


Y1=1.0
IPRED=A(2)
Y=IPRED*(1.0+EPS(1))

$THETA
0.5
10.0
0.8
7.0
6.5
$OMEGA (0.0 fixed)x5
$SIGMA (0.0 fixed)
$SIML (122345) ONLYSIM SUBP=1
$TABLE TIME KIN KINCALC IPRED NOPRINT NOAPPEND FILE=smax_discrete_kin.tab ONEHEADER FORMAT=S1PE20.13
