$PROBLEM PDLIDR
$ABBR PROTECT
$ABBR DERIV2=NO DERIV2=NOCOMMON ; DERIV1=NO
$INPUT ID TIME DV MDV CMT
$DATA data_LDL_Cholesterol.csv IGNORE=@
$SUBROUTINES ADVAN16 TOL=12
$MODEL NCOMPARTMENTS=3 

$PK
Imax=THETA(1)
IC50=THETA(2)
Gam=THETA(3)
RZ0=THETA(4)
kout=THETA(5)
kin = RZ0*kout 
Dm = 50*0.3;  % 300 gr rat
ka1 = 1.255;
ka2 = 0.219;
FZ = 0.214;
Fr = 0.715;
kel = 5.57;   
k12 = 3.61;
k21 = 2.84;
V = 0.719*0.3;
;  TAUy
TAU1=THETA(6)
; Initial conditions
A_0(1)=0
A_0(2)=0
A_0(3)=RZ0

$DES
; AD_x_y is the State value of A(x) delayed for time TAUy.  
; AP_x_y is the State value of A(x) in the past, for time delay TAUy.  
AP_3_1=RZ0

;BASE EQUATIONS 

CC = (A(1)/V)*1000

DADT(1) = ka1*Dm*FZ*Fr*exp(-ka1*t)+ka2*Dm*FZ*(1-Fr)*exp(-ka2*t)-(kel+k12)*A(1)+k21*A(2)
DADT(2) = k12*A(1)-k21*A(2)
DADT(3) = kin*A(3)-kout*(1-(Imax*(CC**Gam))/((IC50**Gam)+(CC**Gam)))*A(3)*AD_3_1

$ERROR
IPRED = A(3)
IRES = DV-IPRED
W = SQRT((THETA(8)*IPRED)**2+THETA(7)**2)
IWRES =  IRES/W
Y = IPRED+W*ERR(1)

$THETA
1 FIX       ; 1: Imax
(0,100)     ; 2: IC50
0.2 FIX     ; 3: Gam
(0,31.3)    ; 4: RZ0
(0,0.0065)  ; 5: kout
(0,7.12)    ; 6: T
0 FIX       ; 7: Add
(0,1)       ; 8: Prop

$OMEGA
1 FIX

$EST METHOD=0 NOHABORT MAXEVAL=9999 PRINT=1 NSIG=3 SIGL=12
$COV MATRIX=R UNCONDITIONAL
$TABLE ID TIME IPRED NOPRINT ONEHEADER
FILE=dloidr.tab
