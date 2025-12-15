$PROBLEM Weibull Distributed Delay on Smax Drug Responsive Input function using NONMEM’s repetition variables
$ABBR DERIV2=NO DERIV2=NOCOMMON ; DERIV1=NO
$INPUT ID AMT TIME DV EVID MDV
$DATA smax_weibull.dat IGNORE=C
$SUBROUTINES ADVAN13 TOL=6 ATOL=6 ; OTHER=ddeslvu.f90
$MODEL NCOMPARTMENTS=2

$INFN
 IF (ICALL.EQ.0) RPTO=1      ;enables use of repetition feature

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
 IF (RPTI.EQ.0) TI=TIME
 IF (NEWIND.EQ.2) RPTO=-1

; Initial conditions
A_0(1)=0.0
A_0(2)=5.0


$DES
 c = A(1)/V
 kin = kin0*(1.0+(Smax*c)/(SC50+c))
  DD=0.0
  if(ti-t>=0.0) DD=EXP(-((TI-T)/BB)**AA) ; DD=1-WEIBULLCDF(TI-T)

 DADT(1) = -(Vmax*A(1))/(V50+A(1))
 DADT(2) = DD*(KIN-KIN0) ; A(2)=N(t)

$ERROR
A1=A(2)

Y1=1.0
IPRED=A(2)
Y=IPRED*(1.0+EPS(1))
A3=A(3)

$THETA
0.5
10.0
0.8
7.0
6.5

$OMEGA (0.0 fixed)x4
$SIGMA (0.0 fixed)
$SIML (122345) ONLYSIM SUBP=1
$TABLE TIME KIN IPRED NOPRINT NOAPPEND FILE=smax_weibull_rep.tab ONEHEADER FORMAT=S1PE20.13
