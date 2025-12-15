Tue 01/11/2022 
05:43 PM
; Pre-Control stream template
;TAU1=75.0
;TAU2=42.0
;TAU3=147.0
;TAU4=114.0
;TAU5=1587.0
;TAU6=1554.0
;TSTOP=200.0
$SIZES PC=80 DIMNEW=3000 DIMTMP=1000 PG=200
$PROB EPO
$ABBR DERIV2=NO DERIV2=NOCOMMON ; DERIV1=NO
$INPUT ID AMT TIME DV EVID MDV  CMT
$DATA EPO_dde.csv IGNORE=C
$SUBROUTINES ADVAN13  TOL=9 ATOL=9
$MODEL NCOMPARTMENTS=72

$PK

KON  =THETA(1)+ETA(1)
KOFF =THETA(2)
KEL  =THETA(3)
KPT  =THETA(4)
KTP  =THETA(5)
VP   =THETA(6)
KINT =THETA(7)
SMAX =THETA(8)
SC50 =THETA(9)
IMAX =THETA(10)
IC50 =THETA(11)
MCH  =THETA(12)
C0   =THETA(13)
RR0   =THETA(14)
KDEG =THETA(15)
RBC0 =THETA(16)
TP1  =THETA(17)
TP2  =THETA(18)
TRET =THETA(19)
TRBC =THETA(20)

;TAUy
TAU1=TP1+TP2
TAU2=TP2
TAU3=TP1+TP2+TRET
TAU4=TP2+TRET
TAU5=TP1+TP2+TRET+TRBC
TAU6=TP2+TRET+TRBC

RET0=TRET*RBC0/(TRET+TRBC)
RBCM0=RBC0-RET0
HB0=MCH*RBC0
AT0=KPT*C0*VP/KTP
RC0=KON*RR0*C0/(KOFF+KINT)
KEPO=KEL*C0*VP+KINT*RC0*VP
KSYN=KDEG*RR0+KINT*RC0
KIN=RET0/(TRET*(1+SMAX*RC0/(SC50+RC0))**2)

; Initial conditions for Base equations
A_0(1)=C0*VP
A_0(2)=AT0
A_0(3)=RR0
A_0(4)=RC0
A_0(5)=RET0
A_0(6)=RBCM0


TSTOP=200.0
; INITIALIZING EQUATIONS FOR DDE COMPARTMENTS
  A_0(7)=C0*VP
  A_0(13)=C0*VP
  A_0(19)=C0*VP
  A_0(23)=C0*VP
  A_0(27)=C0*VP
  A_0(31)=C0*VP
  A_0(35)=C0*VP
  A_0(39)=C0*VP
  A_0(43)=C0*VP
  A_0(47)=C0*VP
  A_0(53)=C0*VP
  A_0(57)=C0*VP
  A_0(61)=C0*VP
  A_0(65)=C0*VP
  A_0(69)=C0*VP
  A_0(8)=AT0
  A_0(14)=AT0
  A_0(20)=AT0
  A_0(24)=AT0
  A_0(28)=AT0
  A_0(32)=AT0
  A_0(36)=AT0
  A_0(40)=AT0
  A_0(44)=AT0
  A_0(48)=AT0
  A_0(54)=AT0
  A_0(58)=AT0
  A_0(62)=AT0
  A_0(66)=AT0
  A_0(70)=AT0
  A_0(9)=RR0
  A_0(15)=RR0
  A_0(21)=RR0
  A_0(25)=RR0
  A_0(29)=RR0
  A_0(33)=RR0
  A_0(37)=RR0
  A_0(41)=RR0
  A_0(45)=RR0
  A_0(49)=RR0
  A_0(55)=RR0
  A_0(59)=RR0
  A_0(63)=RR0
  A_0(67)=RR0
  A_0(71)=RR0
  A_0(10)=RC0
  A_0(16)=RC0
  A_0(22)=RC0
  A_0(26)=RC0
  A_0(30)=RC0
  A_0(34)=RC0
  A_0(38)=RC0
  A_0(42)=RC0
  A_0(46)=RC0
  A_0(50)=RC0
  A_0(56)=RC0
  A_0(60)=RC0
  A_0(64)=RC0
  A_0(68)=RC0
  A_0(72)=RC0
  A_0(11)=RET0
  A_0(17)=RET0
  A_0(51)=RET0
  A_0(12)=RBCM0
  A_0(18)=RBCM0
  A_0(52)=RBCM0
  TAU_1=1*TAU1
  TAU_2=2*TAU1
  TAU_3=3*TAU1
  TAU_4=2*TAU1+1*TAU2
  TAU_5=2*TAU1+1*TAU3
  TAU_6=2*TAU1+1*TAU4
  TAU_7=2*TAU1+1*TAU5
  TAU_8=2*TAU1+1*TAU6
  TAU_9=1*TAU1+1*TAU2
  TAU_10=1*TAU1+1*TAU3
  TAU_11=1*TAU1+1*TAU4
  TAU_12=1*TAU1+1*TAU5
  TAU_13=1*TAU1+1*TAU6
  TAU_14=1*TAU2
  TAU_15=1*TAU3
  TAU_16=1*TAU2+1*TAU3
  TAU_17=2*TAU3
  TAU_18=1*TAU3+1*TAU4
  TAU_19=1*TAU3+1*TAU5
  TAU_20=1*TAU3+1*TAU6
  TAU_21=1*TAU4
  TAU_22=1*TAU5
  TAU_23=1*TAU6
  MTDIFF=1
  MTIME(1)=PASTZERO+TAU_1
    DTAU_1=0.0
    IF((TSTATE-PASTZERO)>=TAU_1) DTAU_1=1.0
    CTAU_1=0.0
    IF(TSTATE-PASTZERO>=TAU_1) CTAU_1=1.0
  MTIME(2)=PASTZERO+TAU_2
    DTAU_2=0.0
    IF((TSTATE-PASTZERO)>=TAU_2) DTAU_2=1.0
    CTAU_2=0.0
    IF(TSTATE-PASTZERO>=TAU_2) CTAU_2=1.0
  MTIME(3)=PASTZERO+TAU_4
    DTAU_4=0.0
    IF((TSTATE-PASTZERO)>=TAU_4) DTAU_4=1.0
    CTAU_4=0.0
    IF(TSTATE-PASTZERO>=TAU_4) CTAU_4=1.0
  MTIME(4)=PASTZERO+TAU_6
    DTAU_6=0.0
    IF((TSTATE-PASTZERO)>=TAU_6) DTAU_6=1.0
    CTAU_6=0.0
    IF(TSTATE-PASTZERO>=TAU_6) CTAU_6=1.0
  MTIME(5)=PASTZERO+TAU_8
    DTAU_8=0.0
    IF((TSTATE-PASTZERO)>=TAU_8) DTAU_8=1.0
    CTAU_8=0.0
    IF(TSTATE-PASTZERO>=TAU_8) CTAU_8=1.0
  MTIME(6)=PASTZERO+TAU_9
    DTAU_9=0.0
    IF((TSTATE-PASTZERO)>=TAU_9) DTAU_9=1.0
    CTAU_9=0.0
    IF(TSTATE-PASTZERO>=TAU_9) CTAU_9=1.0
  MTIME(7)=PASTZERO+TAU_11
    DTAU_11=0.0
    IF((TSTATE-PASTZERO)>=TAU_11) DTAU_11=1.0
    CTAU_11=0.0
    IF(TSTATE-PASTZERO>=TAU_11) CTAU_11=1.0
  MTIME(8)=PASTZERO+TAU_13
    DTAU_13=0.0
    IF((TSTATE-PASTZERO)>=TAU_13) DTAU_13=1.0
    CTAU_13=0.0
    IF(TSTATE-PASTZERO>=TAU_13) CTAU_13=1.0
  MTIME(9)=PASTZERO+TAU_14
    DTAU_14=0.0
    IF((TSTATE-PASTZERO)>=TAU_14) DTAU_14=1.0
    CTAU_14=0.0
    IF(TSTATE-PASTZERO>=TAU_14) CTAU_14=1.0
  MTIME(10)=PASTZERO+TAU_15
    DTAU_15=0.0
    IF((TSTATE-PASTZERO)>=TAU_15) DTAU_15=1.0
    CTAU_15=0.0
    IF(TSTATE-PASTZERO>=TAU_15) CTAU_15=1.0
  MTIME(11)=PASTZERO+TAU_16
    DTAU_16=0.0
    IF((TSTATE-PASTZERO)>=TAU_16) DTAU_16=1.0
    CTAU_16=0.0
    IF(TSTATE-PASTZERO>=TAU_16) CTAU_16=1.0
  MTIME(12)=PASTZERO+TAU_18
    DTAU_18=0.0
    IF((TSTATE-PASTZERO)>=TAU_18) DTAU_18=1.0
    CTAU_18=0.0
    IF(TSTATE-PASTZERO>=TAU_18) CTAU_18=1.0
  MTIME(13)=PASTZERO+TAU_20
    DTAU_20=0.0
    IF((TSTATE-PASTZERO)>=TAU_20) DTAU_20=1.0
    CTAU_20=0.0
    IF(TSTATE-PASTZERO>=TAU_20) CTAU_20=1.0
  MTIME(14)=PASTZERO+TAU_21
    DTAU_21=0.0
    IF((TSTATE-PASTZERO)>=TAU_21) DTAU_21=1.0
    CTAU_21=0.0
    IF(TSTATE-PASTZERO>=TAU_21) CTAU_21=1.0
  MTIME(15)=PASTZERO+TAU_23
    DTAU_23=0.0
    IF((TSTATE-PASTZERO)>=TAU_23) DTAU_23=1.0
    CTAU_23=0.0
    IF(TSTATE-PASTZERO>=TAU_23) CTAU_23=1.0
  ALAG7=TAU_1
  ALAG8=TAU_1
  ALAG9=TAU_1
  ALAG10=TAU_1
  ALAG11=TAU_1
  ALAG12=TAU_1
  ALAG13=TAU_2
  ALAG14=TAU_2
  ALAG15=TAU_2
  ALAG16=TAU_2
  ALAG17=TAU_2
  ALAG18=TAU_2
  ALAG19=TAU_4
  ALAG20=TAU_4
  ALAG21=TAU_4
  ALAG22=TAU_4
  ALAG23=TAU_6
  ALAG24=TAU_6
  ALAG25=TAU_6
  ALAG26=TAU_6
  ALAG27=TAU_8
  ALAG28=TAU_8
  ALAG29=TAU_8
  ALAG30=TAU_8
  ALAG31=TAU_9
  ALAG32=TAU_9
  ALAG33=TAU_9
  ALAG34=TAU_9
  ALAG35=TAU_11
  ALAG36=TAU_11
  ALAG37=TAU_11
  ALAG38=TAU_11
  ALAG39=TAU_13
  ALAG40=TAU_13
  ALAG41=TAU_13
  ALAG42=TAU_13
  ALAG43=TAU_14
  ALAG44=TAU_14
  ALAG45=TAU_14
  ALAG46=TAU_14
  ALAG47=TAU_15
  ALAG48=TAU_15
  ALAG49=TAU_15
  ALAG50=TAU_15
  ALAG51=TAU_15
  ALAG52=TAU_15
  ALAG53=TAU_16
  ALAG54=TAU_16
  ALAG55=TAU_16
  ALAG56=TAU_16
  ALAG57=TAU_18
  ALAG58=TAU_18
  ALAG59=TAU_18
  ALAG60=TAU_18
  ALAG61=TAU_20
  ALAG62=TAU_20
  ALAG63=TAU_20
  ALAG64=TAU_20
  ALAG65=TAU_21
  ALAG66=TAU_21
  ALAG67=TAU_21
  ALAG68=TAU_21
  ALAG69=TAU_23
  ALAG70=TAU_23
  ALAG71=TAU_23
  ALAG72=TAU_23

$DES
  ; AD_x_y is the State value of A(x) delayed for time TAUy.
  ; AP_x_y is the State value of A(x) in the past, for time delay TAUy.
  ; PASTS
   AP_4_1=RC0
   AP_5_1=RET0
   AP_6_1=RBCM0
    AD_4_1=(1.0-DTAU_1)*AP_4_1+DTAU_1*A(10)
    AD_5_1=(1.0-DTAU_1)*AP_5_1+DTAU_1*A(11)
    AD_6_1=(1.0-DTAU_1)*AP_6_1+DTAU_1*A(12)
   AP_4_1_2=RC0
   AP_5_1_2=RET0
   AP_6_1_2=RBCM0
    AD_4_1_2=(1.0-DTAU_2)*AP_4_1_2+DTAU_2*A(16)
    AD_5_1_2=(1.0-DTAU_2)*AP_5_1_2+DTAU_2*A(17)
    AD_6_1_2=(1.0-DTAU_2)*AP_6_1_2+DTAU_2*A(18)
   AP_4_1_3=RC0
   AP_5_1_3=RET0
   AP_6_1_3=RBCM0
    AD_4_1_3=AP_4_1_3
    AD_5_1_3=AP_5_1_3
    AD_6_1_3=AP_6_1_3
   AP_4_2_4=RC0
    AD_4_2_4=(1.0-DTAU_4)*AP_4_2_4+DTAU_4*A(22)
   AP_4_3_5=RC0
   AP_5_3_5=RET0
   AP_6_3_5=RBCM0
    AD_4_3_5=AP_4_3_5
    AD_5_3_5=AP_5_3_5
    AD_6_3_5=AP_6_3_5
   AP_4_4_6=RC0
    AD_4_4_6=(1.0-DTAU_6)*AP_4_4_6+DTAU_6*A(26)
   AP_4_5_7=RC0
   AP_5_5_7=RET0
   AP_6_5_7=RBCM0
    AD_4_5_7=AP_4_5_7
    AD_5_5_7=AP_5_5_7
    AD_6_5_7=AP_6_5_7
   AP_4_6_8=RC0
    AD_4_6_8=(1.0-DTAU_8)*AP_4_6_8+DTAU_8*A(30)
   AP_4_2_9=RC0
    AD_4_2_9=(1.0-DTAU_9)*AP_4_2_9+DTAU_9*A(34)
   AP_4_1_10=RC0
   AP_4_3_10=RC0
   AP_5_1_10=RET0
   AP_5_3_10=RET0
   AP_6_1_10=RBCM0
   AP_6_3_10=RBCM0
    AD_4_1_10=AP_4_1_10
    AD_4_3_10=AP_4_3_10
    AD_5_1_10=AP_5_1_10
    AD_6_1_10=AP_6_1_10
    AD_5_3_10=AP_5_3_10
    AD_6_3_10=AP_6_3_10
   AP_4_4_11=RC0
    AD_4_4_11=(1.0-DTAU_11)*AP_4_4_11+DTAU_11*A(38)
   AP_4_5_12=RC0
   AP_5_5_12=RET0
   AP_6_5_12=RBCM0
    AD_4_5_12=AP_4_5_12
    AD_5_5_12=AP_5_5_12
    AD_6_5_12=AP_6_5_12
   AP_4_6_13=RC0
    AD_4_6_13=(1.0-DTAU_13)*AP_4_6_13+DTAU_13*A(42)
   AP_4_2=RC0
    AD_4_2=(1.0-DTAU_14)*AP_4_2+DTAU_14*A(46)
   AP_4_3=RC0
   AP_5_3=RET0
   AP_6_3=RBCM0
    AD_4_3=(1.0-DTAU_15)*AP_4_3+DTAU_15*A(50)
    AD_5_3=(1.0-DTAU_15)*AP_5_3+DTAU_15*A(51)
    AD_6_3=(1.0-DTAU_15)*AP_6_3+DTAU_15*A(52)
   AP_4_2_16=RC0
    AD_4_2_16=(1.0-DTAU_16)*AP_4_2_16+DTAU_16*A(56)
   AP_4_3_17=RC0
   AP_5_3_17=RET0
   AP_6_3_17=RBCM0
    AD_4_3_17=AP_4_3_17
    AD_5_3_17=AP_5_3_17
    AD_6_3_17=AP_6_3_17
   AP_4_4_18=RC0
    AD_4_4_18=(1.0-DTAU_18)*AP_4_4_18+DTAU_18*A(60)
   AP_4_5_19=RC0
   AP_5_5_19=RET0
   AP_6_5_19=RBCM0
    AD_4_5_19=AP_4_5_19
    AD_5_5_19=AP_5_5_19
    AD_6_5_19=AP_6_5_19
   AP_4_6_20=RC0
    AD_4_6_20=(1.0-DTAU_20)*AP_4_6_20+DTAU_20*A(64)
   AP_4_4=RC0
    AD_4_4=(1.0-DTAU_21)*AP_4_4+DTAU_21*A(68)
   AP_4_5=RC0
   AP_5_5=RET0
   AP_6_5=RBCM0
    AD_4_5=AP_4_5
    AD_5_5=AP_5_5
    AD_6_5=AP_6_5
   AP_4_6=RC0
    AD_4_6=(1.0-DTAU_23)*AP_4_6+DTAU_23*A(72)

 CC=A(1)/VP
 AT=A(2)
 RR=A(3)
 RC=A(4)
 RET=A(5)
 RBCM=A(6)

 X1=1+SMAX*AD_4_1/(SC50+AD_4_1)
 X2=1+SMAX*AD_4_2/(SC50+AD_4_2)
 X3=1+SMAX*AD_4_3/(SC50+AD_4_3)
 X4=1+SMAX*AD_4_4/(SC50+AD_4_4)
 X5=1+SMAX*AD_4_5/(SC50+AD_4_5)
 X6=1+SMAX*AD_4_6/(SC50+AD_4_6)
 X0=1+SMAX*RC0/(SC50+RC0)

 I1=1-IMAX*(MCH*(AD_5_1+AD_6_1)-HB0)/(IC50+(MCH*(AD_5_1+AD_6_1)-HB0))
 I3=1-IMAX*(MCH*(AD_5_3+AD_6_3)-HB0)/(IC50+(MCH*(AD_5_3+AD_6_3)-HB0))
 I5=1-IMAX*(MCH*(AD_5_5+AD_6_5)-HB0)/(IC50+(MCH*(AD_5_5+AD_6_5)-HB0))



; BASE EQUATIONS.

 DADT(1)=KEPO-KON*CC*VP*RR+KOFF*RC*VP-(KEL+KPT)*CC*VP+KTP*AT
 DADT(2)=KPT*CC*VP-KTP*AT
 DADT(3)=KSYN-KON*CC*RR+KOFF*RC-KDEG*RR
 DADT(4)=KON*CC*RR-(KOFF+KINT)*RC
 DADT(5)=KIN*X1*X2*I1-KIN*X3*X4*I3
 DADT(6)=KIN*X3*X4*I3-KIN*X5*X6*I5


 CC_1=A(7)/VP
 AT_1=A(8)
 RR_1=A(9)
 RC_1=A(10)
 X1_1=1+SMAX*AD_4_1_2/(SC50+AD_4_1_2)
 X2_1=1+SMAX*AD_4_2_9/(SC50+AD_4_2_9)
 X3_1=1+SMAX*AD_4_3_10/(SC50+AD_4_3_10)
 X4_1=1+SMAX*AD_4_4_11/(SC50+AD_4_4_11)
 X5_1=1+SMAX*AD_4_5_12/(SC50+AD_4_5_12)
 X6_1=1+SMAX*AD_4_6_13/(SC50+AD_4_6_13)
 I1_1=1-IMAX*(MCH*(AD_5_1_2+AD_6_1_2)-HB0)/(IC50+(MCH*(AD_5_1_2+AD_6_1_2)-HB0))
 I3_1=1-IMAX*(MCH*(AD_5_3_10+AD_6_3_10)-HB0)/(IC50+(MCH*(AD_5_3_10+AD_6_3_10) &
  -HB0))
 I5_1=1-IMAX*(MCH*(AD_5_5_12+AD_6_5_12)-HB0)/(IC50+(MCH*(AD_5_5_12+AD_6_5_12) &
  -HB0))
   DADT(7)=CTAU_1*(KEPO-KON*CC_1*VP*RR_1+KOFF*RC_1*VP-(KEL+KPT)*CC_1*VP &
  +KTP*AT_1)
   DADT(8)=CTAU_1*(KPT*CC_1*VP-KTP*AT_1)
   DADT(9)=CTAU_1*(KSYN-KON*CC_1*RR_1+KOFF*RC_1-KDEG*RR_1)
   DADT(10)=CTAU_1*(KON*CC_1*RR_1-(KOFF+KINT)*RC_1)
   DADT(11)=CTAU_1*(KIN*X1_1*X2_1*I1_1-KIN*X3_1*X4_1*I3_1)
   DADT(12)=CTAU_1*(KIN*X3_1*X4_1*I3_1-KIN*X5_1*X6_1*I5_1)
 CC_2=A(13)/VP
 AT_2=A(14)
 RR_2=A(15)
 RC_2=A(16)
 X1_2=1+SMAX*AD_4_1_3/(SC50+AD_4_1_3)
 X2_2=1+SMAX*AD_4_2_4/(SC50+AD_4_2_4)
 X3_2=1+SMAX*AD_4_3_5/(SC50+AD_4_3_5)
 X4_2=1+SMAX*AD_4_4_6/(SC50+AD_4_4_6)
 X5_2=1+SMAX*AD_4_5_7/(SC50+AD_4_5_7)
 X6_2=1+SMAX*AD_4_6_8/(SC50+AD_4_6_8)
 I1_2=1-IMAX*(MCH*(AD_5_1_3+AD_6_1_3)-HB0)/(IC50+(MCH*(AD_5_1_3+AD_6_1_3)-HB0))
 I3_2=1-IMAX*(MCH*(AD_5_3_5+AD_6_3_5)-HB0)/(IC50+(MCH*(AD_5_3_5+AD_6_3_5)-HB0))
 I5_2=1-IMAX*(MCH*(AD_5_5_7+AD_6_5_7)-HB0)/(IC50+(MCH*(AD_5_5_7+AD_6_5_7)-HB0))
   DADT(13)=CTAU_2*(KEPO-KON*CC_2*VP*RR_2+KOFF*RC_2*VP-(KEL+KPT)*CC_2 &
  *VP+KTP*AT_2)
   DADT(14)=CTAU_2*(KPT*CC_2*VP-KTP*AT_2)
   DADT(15)=CTAU_2*(KSYN-KON*CC_2*RR_2+KOFF*RC_2-KDEG*RR_2)
   DADT(16)=CTAU_2*(KON*CC_2*RR_2-(KOFF+KINT)*RC_2)
   DADT(17)=CTAU_2*(KIN*X1_2*X2_2*I1_2-KIN*X3_2*X4_2*I3_2)
   DADT(18)=CTAU_2*(KIN*X3_2*X4_2*I3_2-KIN*X5_2*X6_2*I5_2)
 CC_4=A(19)/VP
 AT_4=A(20)
 RR_4=A(21)
 RC_4=A(22)
   DADT(19)=CTAU_4*(KEPO-KON*CC_4*VP*RR_4+KOFF*RC_4*VP-(KEL+KPT)*CC_4 &
  *VP+KTP*AT_4)
   DADT(20)=CTAU_4*(KPT*CC_4*VP-KTP*AT_4)
   DADT(21)=CTAU_4*(KSYN-KON*CC_4*RR_4+KOFF*RC_4-KDEG*RR_4)
   DADT(22)=CTAU_4*(KON*CC_4*RR_4-(KOFF+KINT)*RC_4)
 CC_6=A(23)/VP
 AT_6=A(24)
 RR_6=A(25)
 RC_6=A(26)
   DADT(23)=CTAU_6*(KEPO-KON*CC_6*VP*RR_6+KOFF*RC_6*VP-(KEL+KPT)*CC_6 &
  *VP+KTP*AT_6)
   DADT(24)=CTAU_6*(KPT*CC_6*VP-KTP*AT_6)
   DADT(25)=CTAU_6*(KSYN-KON*CC_6*RR_6+KOFF*RC_6-KDEG*RR_6)
   DADT(26)=CTAU_6*(KON*CC_6*RR_6-(KOFF+KINT)*RC_6)
 CC_8=A(27)/VP
 AT_8=A(28)
 RR_8=A(29)
 RC_8=A(30)
   DADT(27)=CTAU_8*(KEPO-KON*CC_8*VP*RR_8+KOFF*RC_8*VP-(KEL+KPT)*CC_8 &
  *VP+KTP*AT_8)
   DADT(28)=CTAU_8*(KPT*CC_8*VP-KTP*AT_8)
   DADT(29)=CTAU_8*(KSYN-KON*CC_8*RR_8+KOFF*RC_8-KDEG*RR_8)
   DADT(30)=CTAU_8*(KON*CC_8*RR_8-(KOFF+KINT)*RC_8)
 CC_9=A(31)/VP
 AT_9=A(32)
 RR_9=A(33)
 RC_9=A(34)
   DADT(31)=CTAU_9*(KEPO-KON*CC_9*VP*RR_9+KOFF*RC_9*VP-(KEL+KPT)*CC_9 &
  *VP+KTP*AT_9)
   DADT(32)=CTAU_9*(KPT*CC_9*VP-KTP*AT_9)
   DADT(33)=CTAU_9*(KSYN-KON*CC_9*RR_9+KOFF*RC_9-KDEG*RR_9)
   DADT(34)=CTAU_9*(KON*CC_9*RR_9-(KOFF+KINT)*RC_9)
 CC_11=A(35)/VP
 AT_11=A(36)
 RR_11=A(37)
 RC_11=A(38)
   DADT(35)=CTAU_11*(KEPO-KON*CC_11*VP*RR_11+KOFF*RC_11*VP-(KEL+KPT)*CC_11 &
  *VP+KTP*AT_11)
   DADT(36)=CTAU_11*(KPT*CC_11*VP-KTP*AT_11)
   DADT(37)=CTAU_11*(KSYN-KON*CC_11*RR_11+KOFF*RC_11-KDEG*RR_11)
   DADT(38)=CTAU_11*(KON*CC_11*RR_11-(KOFF+KINT)*RC_11)
 CC_13=A(39)/VP
 AT_13=A(40)
 RR_13=A(41)
 RC_13=A(42)
   DADT(39)=CTAU_13*(KEPO-KON*CC_13*VP*RR_13+KOFF*RC_13*VP-(KEL+KPT)*CC_13 &
  *VP+KTP*AT_13)
   DADT(40)=CTAU_13*(KPT*CC_13*VP-KTP*AT_13)
   DADT(41)=CTAU_13*(KSYN-KON*CC_13*RR_13+KOFF*RC_13-KDEG*RR_13)
   DADT(42)=CTAU_13*(KON*CC_13*RR_13-(KOFF+KINT)*RC_13)
 CC_14=A(43)/VP
 AT_14=A(44)
 RR_14=A(45)
 RC_14=A(46)
   DADT(43)=CTAU_14*(KEPO-KON*CC_14*VP*RR_14+KOFF*RC_14*VP-(KEL+KPT)*CC_14 &
  *VP+KTP*AT_14)
   DADT(44)=CTAU_14*(KPT*CC_14*VP-KTP*AT_14)
   DADT(45)=CTAU_14*(KSYN-KON*CC_14*RR_14+KOFF*RC_14-KDEG*RR_14)
   DADT(46)=CTAU_14*(KON*CC_14*RR_14-(KOFF+KINT)*RC_14)
 CC_15=A(47)/VP
 AT_15=A(48)
 RR_15=A(49)
 RC_15=A(50)
 X1_15=1+SMAX*AD_4_1_10/(SC50+AD_4_1_10)
 X2_15=1+SMAX*AD_4_2_16/(SC50+AD_4_2_16)
 X3_15=1+SMAX*AD_4_3_17/(SC50+AD_4_3_17)
 X4_15=1+SMAX*AD_4_4_18/(SC50+AD_4_4_18)
 X5_15=1+SMAX*AD_4_5_19/(SC50+AD_4_5_19)
 X6_15=1+SMAX*AD_4_6_20/(SC50+AD_4_6_20)
 I1_15=1-IMAX*(MCH*(AD_5_1_10+AD_6_1_10)-HB0)/(IC50+(MCH*(AD_5_1_10+AD_6_1_10) &
  -HB0))
 I3_15=1-IMAX*(MCH*(AD_5_3_17+AD_6_3_17)-HB0)/(IC50+(MCH*(AD_5_3_17+AD_6_3_17) &
  -HB0))
 I5_15=1-IMAX*(MCH*(AD_5_5_19+AD_6_5_19)-HB0)/(IC50+(MCH*(AD_5_5_19+AD_6_5_19) &
  -HB0))
   DADT(47)=CTAU_15*(KEPO-KON*CC_15*VP*RR_15+KOFF*RC_15*VP-(KEL+KPT)*CC_15 &
  *VP+KTP*AT_15)
   DADT(48)=CTAU_15*(KPT*CC_15*VP-KTP*AT_15)
   DADT(49)=CTAU_15*(KSYN-KON*CC_15*RR_15+KOFF*RC_15-KDEG*RR_15)
   DADT(50)=CTAU_15*(KON*CC_15*RR_15-(KOFF+KINT)*RC_15)
   DADT(51)=CTAU_15*(KIN*X1_15*X2_15*I1_15-KIN*X3_15*X4_15*I3_15)
   DADT(52)=CTAU_15*(KIN*X3_15*X4_15*I3_15-KIN*X5_15*X6_15*I5_15)
 CC_16=A(53)/VP
 AT_16=A(54)
 RR_16=A(55)
 RC_16=A(56)
   DADT(53)=CTAU_16*(KEPO-KON*CC_16*VP*RR_16+KOFF*RC_16*VP-(KEL+KPT)*CC_16 &
  *VP+KTP*AT_16)
   DADT(54)=CTAU_16*(KPT*CC_16*VP-KTP*AT_16)
   DADT(55)=CTAU_16*(KSYN-KON*CC_16*RR_16+KOFF*RC_16-KDEG*RR_16)
   DADT(56)=CTAU_16*(KON*CC_16*RR_16-(KOFF+KINT)*RC_16)
 CC_18=A(57)/VP
 AT_18=A(58)
 RR_18=A(59)
 RC_18=A(60)
   DADT(57)=CTAU_18*(KEPO-KON*CC_18*VP*RR_18+KOFF*RC_18*VP-(KEL+KPT)*CC_18 &
  *VP+KTP*AT_18)
   DADT(58)=CTAU_18*(KPT*CC_18*VP-KTP*AT_18)
   DADT(59)=CTAU_18*(KSYN-KON*CC_18*RR_18+KOFF*RC_18-KDEG*RR_18)
   DADT(60)=CTAU_18*(KON*CC_18*RR_18-(KOFF+KINT)*RC_18)
 CC_20=A(61)/VP
 AT_20=A(62)
 RR_20=A(63)
 RC_20=A(64)
   DADT(61)=CTAU_20*(KEPO-KON*CC_20*VP*RR_20+KOFF*RC_20*VP-(KEL+KPT)*CC_20 &
  *VP+KTP*AT_20)
   DADT(62)=CTAU_20*(KPT*CC_20*VP-KTP*AT_20)
   DADT(63)=CTAU_20*(KSYN-KON*CC_20*RR_20+KOFF*RC_20-KDEG*RR_20)
   DADT(64)=CTAU_20*(KON*CC_20*RR_20-(KOFF+KINT)*RC_20)
 CC_21=A(65)/VP
 AT_21=A(66)
 RR_21=A(67)
 RC_21=A(68)
   DADT(65)=CTAU_21*(KEPO-KON*CC_21*VP*RR_21+KOFF*RC_21*VP-(KEL+KPT)*CC_21 &
  *VP+KTP*AT_21)
   DADT(66)=CTAU_21*(KPT*CC_21*VP-KTP*AT_21)
   DADT(67)=CTAU_21*(KSYN-KON*CC_21*RR_21+KOFF*RC_21-KDEG*RR_21)
   DADT(68)=CTAU_21*(KON*CC_21*RR_21-(KOFF+KINT)*RC_21)
 CC_23=A(69)/VP
 AT_23=A(70)
 RR_23=A(71)
 RC_23=A(72)
   DADT(69)=CTAU_23*(KEPO-KON*CC_23*VP*RR_23+KOFF*RC_23*VP-(KEL+KPT)*CC_23 &
  *VP+KTP*AT_23)
   DADT(70)=CTAU_23*(KPT*CC_23*VP-KTP*AT_23)
   DADT(71)=CTAU_23*(KSYN-KON*CC_23*RR_23+KOFF*RC_23-KDEG*RR_23)
   DADT(72)=CTAU_23*(KON*CC_23*RR_23-(KOFF+KINT)*RC_23)
  ; FOR FINEDATA $EXTRADOSE: CMT=1:,7,13,19,23,27,31,35,39,43,47,53,57,61,65,69,2:,8,14,20,24,28,32,36,40,44,48,54,58,62,66,70,3:,9,15,21,25,29,33,37,41,45,49,55,59,63,67,71,4:,10,16,22,26,30,34,38,42,46,50,56,60,64,68,72,5:,11,17,51,6:,12,18,52

$ERROR

Y1=A(1)/VP
Y2=A(2)
Y3=A(3)
Y4=A(4)
Y5=A(5)
Y6=A(5)+A(6)
Y7=MCH*Y6
IF(CMT==1) IPRED=Y1*(1.0+EPS(1))
IF(CMT==2) IPRED=Y2
IF(CMT==3) IPRED=Y3
IF(CMT==4) IPRED=Y4
IF(CMT==5) IPRED=Y5
IF(CMT==6) IPRED=Y6

Y=IPRED

$THETA
0.01132    ; 1: KON    1/nM/h
1.297      ; 2: KOFF   1/h
0.2256     ; 3: KEL    1/h
0.2092     ; 4: KPT    1/h
0.1721     ; 5: KTP    1/h
0.05694    ; 6: VP     mL/kg
0.8228     ; 7: KINT   1/h
3.48       ; 8: SMAX   1
1.7        ; 9: SC50   pM
1.0        ; 10: IMAX  1
1.79       ; 11: IC50  g/dL
2.0        ; 12: MCH   0.1 g/dL
3.248      ; 13: C0    pM
63.2       ; 14: RR0    pM
0.1133     ; 15: KDEG  1/h
6.128      ; 16: RBC0  10^6 cells/uL
42.97      ; 17: TP1   h
33.6       ; 18: TP2   h
72.33      ; 19: TRET  h
1440       ; 20: TRBC  h

$OMEGA (0.0 FIXED)
$SIGMA (0.0 FIXED)

$SIMULATION (567811 NORMAL) (2933012 UNIFORM) ONLYSIMULATION SUBPROBLEMS=1
$TABLE ID TIME IPRED CMT MDV Y7
NOAPPEND NOPRINT ONEHEADER FILE=EPO.tab
  
NM-TRAN MESSAGES 
 WARNING: -prdefault OPTION IS OVER-RIDING USER SPECIFIED PC VALUE OF 80 WITH 30
THEREFORE OVER-RIDING -prdefault
  
 WARNINGS AND ERRORS (IF ANY) FOR PROBLEM    1
             
 (WARNING  2) NM-TRAN INFERS THAT THE DATA ARE POPULATION.
             
 (WARNING  3) THERE MAY BE AN ERROR IN THE ABBREVIATED CODE. THE FOLLOWING
 ONE OR MORE RANDOM VARIABLES ARE DEFINED WITH "IF" STATEMENTS THAT DO NOT
 PROVIDE DEFINITIONS FOR BOTH THE "THEN" AND "ELSE" CASES. IF ALL
 CONDITIONS FAIL, THE VALUES OF THESE VARIABLES WILL BE ZERO.
  
   IPRED

  
License Registered to: Temporary License for Installing NONMEM7.5.1
Expiration Date:    28 FEB 2022
Current Date:       11 JAN 2022
Days until program expires :  47
1NONLINEAR MIXED EFFECTS MODEL PROGRAM (NONMEM) VERSION 7.5.1
 ORIGINALLY DEVELOPED BY STUART BEAL, LEWIS SHEINER, AND ALISON BOECKMANN
 CURRENT DEVELOPERS ARE ROBERT BAUER, ICON DEVELOPMENT SOLUTIONS,
 AND ALISON BOECKMANN. IMPLEMENTATION, EFFICIENCY, AND STANDARDIZATION
 PERFORMED BY NOUS INFOSYSTEMS.

 PROBLEM NO.:         1
 EPO
0DATA CHECKOUT RUN:              NO
 DATA SET LOCATED ON UNIT NO.:    2
 THIS UNIT TO BE REWOUND:        NO
 NO. OF DATA RECS IN DATA SET:     1222
 NO. OF DATA ITEMS IN DATA SET:   7
 ID DATA ITEM IS DATA ITEM NO.:   1
 DEP VARIABLE IS DATA ITEM NO.:   4
 MDV DATA ITEM IS DATA ITEM NO.:  6
0INDICES PASSED TO SUBROUTINE PRED:
   5   3   2   0   0   0   7   0   0   0   0
0LABELS FOR DATA ITEMS:
 ID AMT TIME DV EVID MDV CMT
0(NONBLANK) LABELS FOR PRED-DEFINED ITEMS:
 Y7 IPRED
0FORMAT FOR DATA:
 (7E6.0)

 TOT. NO. OF OBS RECS:     1206
 TOT. NO. OF INDIVIDUALS:        1
0LENGTH OF THETA:  20
0DEFAULT THETA BOUNDARY TEST OMITTED:    NO
0OMEGA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT OMEGA BOUNDARY TEST OMITTED:    NO
0SIGMA HAS SIMPLE DIAGONAL FORM WITH DIMENSION:   1
0DEFAULT SIGMA BOUNDARY TEST OMITTED:    NO
0INITIAL ESTIMATE OF THETA:
   0.1132E-01  0.1297E+01  0.2256E+00  0.2092E+00  0.1721E+00  0.5694E-01  0.8228E+00  0.3480E+01  0.1700E+01  0.1000E+01  0.1790E+01
   0.2000E+01  0.3248E+01  0.6320E+02  0.1133E+00  0.6128E+01  0.4297E+02  0.3360E+02  0.7233E+02  0.1440E+04
0INITIAL ESTIMATE OF OMEGA:
 0.0000E+00
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
   SEED1:        567811   SEED2:             0   PSEUDO-NORMAL
SEED   2 RESET TO INITIAL: YES
 SOURCE   2:
   SEED1:       2933012   SEED2:             0   PSEUDO-UNIFORM
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
 HEADERS:               ONE
 FILE TO BE FORWARDED:   NO
 FORMAT:                S1PE11.4
 IDFORMAT:
 LFORMAT:
 RFORMAT:
 FIXED_EFFECT_ETAS:
0USER-CHOSEN ITEMS:
 ID TIME IPRED CMT MDV Y7
1DOUBLE PRECISION PREDPP VERSION 7.5.1

 GENERAL NONLINEAR KINETICS MODEL WITH STIFF/NONSTIFF EQUATIONS (LSODA, ADVAN13)
0MODEL SUBROUTINE USER-SUPPLIED - ID NO. 9999
0MAXIMUM NO. OF BASIC PK PARAMETERS:  50
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
   29         COMP 29      ON         YES        YES        NO         NO
   30         COMP 30      ON         YES        YES        NO         NO
   31         COMP 31      ON         YES        YES        NO         NO
   32         COMP 32      ON         YES        YES        NO         NO
   33         COMP 33      ON         YES        YES        NO         NO
   34         COMP 34      ON         YES        YES        NO         NO
   35         COMP 35      ON         YES        YES        NO         NO
   36         COMP 36      ON         YES        YES        NO         NO
   37         COMP 37      ON         YES        YES        NO         NO
   38         COMP 38      ON         YES        YES        NO         NO
   39         COMP 39      ON         YES        YES        NO         NO
   40         COMP 40      ON         YES        YES        NO         NO
   41         COMP 41      ON         YES        YES        NO         NO
   42         COMP 42      ON         YES        YES        NO         NO
   43         COMP 43      ON         YES        YES        NO         NO
   44         COMP 44      ON         YES        YES        NO         NO
   45         COMP 45      ON         YES        YES        NO         NO
   46         COMP 46      ON         YES        YES        NO         NO
   47         COMP 47      ON         YES        YES        NO         NO
   48         COMP 48      ON         YES        YES        NO         NO
   49         COMP 49      ON         YES        YES        NO         NO
   50         COMP 50      ON         YES        YES        NO         NO
   51         COMP 51      ON         YES        YES        NO         NO
   52         COMP 52      ON         YES        YES        NO         NO
   53         COMP 53      ON         YES        YES        NO         NO
   54         COMP 54      ON         YES        YES        NO         NO
   55         COMP 55      ON         YES        YES        NO         NO
   56         COMP 56      ON         YES        YES        NO         NO
   57         COMP 57      ON         YES        YES        NO         NO
   58         COMP 58      ON         YES        YES        NO         NO
   59         COMP 59      ON         YES        YES        NO         NO
   60         COMP 60      ON         YES        YES        NO         NO
   61         COMP 61      ON         YES        YES        NO         NO
   62         COMP 62      ON         YES        YES        NO         NO
   63         COMP 63      ON         YES        YES        NO         NO
   64         COMP 64      ON         YES        YES        NO         NO
   65         COMP 65      ON         YES        YES        NO         NO
   66         COMP 66      ON         YES        YES        NO         NO
   67         COMP 67      ON         YES        YES        NO         NO
   68         COMP 68      ON         YES        YES        NO         NO
   69         COMP 69      ON         YES        YES        NO         NO
   70         COMP 70      ON         YES        YES        NO         NO
   71         COMP 71      ON         YES        YES        NO         NO
   72         COMP 72      ON         YES        YES        NO         NO
   73         OUTPUT       OFF        YES        NO         NO         NO
 INITIAL (BASE) TOLERANCE SETTINGS:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   9
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   9
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
    7            *           *           *           *          51
    8            *           *           *           *          52
    9            *           *           *           *          53
   10            *           *           *           *          54
   11            *           *           *           *          55
   12            *           *           *           *          56
   13            *           *           *           *          57
   14            *           *           *           *          58
   15            *           *           *           *          59
   16            *           *           *           *          60
   17            *           *           *           *          61
   18            *           *           *           *          62
   19            *           *           *           *          63
   20            *           *           *           *          64
   21            *           *           *           *          65
   22            *           *           *           *          66
   23            *           *           *           *          67
   24            *           *           *           *          68
   25            *           *           *           *          69
   26            *           *           *           *          70
   27            *           *           *           *          71
   28            *           *           *           *          72
   29            *           *           *           *          73
   30            *           *           *           *          74
   31            *           *           *           *          75
   32            *           *           *           *          76
   33            *           *           *           *          77
   34            *           *           *           *          78
   35            *           *           *           *          79
   36            *           *           *           *          80
   37            *           *           *           *          81
   38            *           *           *           *          82
   39            *           *           *           *          83
   40            *           *           *           *          84
   41            *           *           *           *          85
   42            *           *           *           *          86
   43            *           *           *           *          87
   44            *           *           *           *          88
   45            *           *           *           *          89
   46            *           *           *           *          90
   47            *           *           *           *          91
   48            *           *           *           *          92
   49            *           *           *           *          93
   50            *           *           *           *          94
   51            *           *           *           *          95
   52            *           *           *           *          96
   53            *           *           *           *          97
   54            *           *           *           *          98
   55            *           *           *           *          99
   56            *           *           *           *         100
   57            *           *           *           *         101
   58            *           *           *           *         102
   59            *           *           *           *         103
   60            *           *           *           *         104
   61            *           *           *           *         105
   62            *           *           *           *         106
   63            *           *           *           *         107
   64            *           *           *           *         108
   65            *           *           *           *         109
   66            *           *           *           *         110
   67            *           *           *           *         111
   68            *           *           *           *         112
   69            *           *           *           *         113
   70            *           *           *           *         114
   71            *           *           *           *         115
   72            *           *           *           *         116
   73            *           -           -           -           -
             - PARAMETER IS NOT ALLOWED FOR THIS MODEL
             * PARAMETER IS NOT SUPPLIED BY PK SUBROUTINE;
               WILL DEFAULT TO ONE IF APPLICABLE
0FIRST MODEL TIME PARAMETER ASSIGNED TO ROW NO.:117
 LAST  MODEL TIME PARAMETER ASSIGNED TO ROW NO.:131
0DATA ITEM INDICES USED BY PRED ARE:
   EVENT ID DATA ITEM IS DATA ITEM NO.:      5
   TIME DATA ITEM IS DATA ITEM NO.:          3
   DOSE AMOUNT DATA ITEM IS DATA ITEM NO.:   2
   COMPT. NO. DATA ITEM IS DATA ITEM NO.:    7

0PK SUBROUTINE CALLED WITH EVERY EVENT RECORD.
 PK SUBROUTINE CALLED AT NONEVENT (ADDITIONAL AND LAGGED) DOSE TIMES AND AT MODEL TIMES.

0PK SUBROUTINE INDICATES THAT COMPARTMENT AMOUNTS ARE INITIALIZED.
0ERROR SUBROUTINE CALLED WITH EVERY EVENT RECORD.
0ERROR SUBROUTINE INDICATES THAT DERIVATIVES OF COMPARTMENT AMOUNTS ARE USED.
0DES SUBROUTINE USES COMPACT STORAGE MODE.
 TOLERANCES FOR SIMULATION STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   9
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   9
 TOLERANCES FOR TABLE/SCATTER STEP:
 NRD (RELATIVE) VALUE(S) OF TOLERANCE:   9
 ANRD (ABSOLUTE) VALUE(S) OF TOLERANCE:   9
1
 PROBLEM NO.:           1      SUBPROBLEM NO.:           1

 SIMULATION STEP PERFORMED
 SOURCE  1:
    SEED1:    1526186844   SEED2:   -1097888122
 SOURCE  2:
    SEED1:       2933012   SEED2:             0
 Elapsed simulation  time in seconds:     0.02
 ESTIMATION STEP OMITTED:                 YES
 Elapsed finaloutput time in seconds:     0.20
 #CPUT: Total CPU Time in Seconds,        0.516
Stop Time: 
Tue 01/11/2022 
05:44 PM
