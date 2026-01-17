$PROB Two compartment Model
$INPUT C SET ID JID TIME  DV=CONC AMT=DOSE RATE EVID MDV CMT
$DATA w15.csv IGNORE=@

$SUBROUTINES ADVAN3 TRANS4

$PK
MU_1=THETA(1)
MU_2=THETA(2)
MU_3=THETA(3)
MU_4=THETA(4)
;# Etas are always normally distruted with mean 0, variance OMEGA().
;# phis (mu+eta) are normally distruted with mean MU, and variance OMEGA()
;# Individual parameters will be whatever the transformation is.  In this case, transformatioin is exponential of a
;# normally distributed parameter (phi), so individual parameters are log-normally distributed.
CL=DEXP(MU_1+ETA(1))
V1=DEXP(MU_2+ETA(2))
Q=DEXP(MU_3+ETA(3))
V2=DEXP(MU_4+ETA(4))
S1=V1

$ERROR
;# Data DV are normally distributed, with residual variance F*F*SIGMA(1,1), and its SD is F*SQRT(SIGMA(1,1))
;#  This is because EPS() is scaled with sqrt(SIGMA)
Y = F + F*EPS(1)

;# Initial values of THETA
$THETA
 2.0 ;#[LN(CL)]
 2.0 ;#[LN(V1)]
 2.0 ;#[LN(Q)]
 2.0 ;#[LN(V2)]
;#INITIAL values of OMEGA
$OMEGA BLOCK(4)
0.15   ;#[P]
0.01  ;#[F]
0.15   ;#[P]
0.01  ;#[F]
0.01  ;#[F]
0.15   ;#[P]
0.01  ;#[F]
0.01  ;#[F]
0.01  ;#[F]
0.15   ;#[P]
;#Initial value of SIGMA
$SIGMA
(0.6 )   ;#[P]

$PRIOR NWPRI
;# Prior information of THETAS.  Normal distribution of thetas assumed unless $TTDF is set, in which case it is then T distriuted
$THETAP (2.0 FIX) (2.0 FIX) (2.0 FIX) (2.0 FIX)
;# Variance to prior information of THETAS.
$THETAPV BLOCK(4) FIXED VALUES(10.0,0.0)
;# Inverse Wishart distribution assumed, unless $OLKJDF, $OVARF are set.
$OMEGAP BLOCK(4) FIXED VALUES(0.15,0.0)
;# Low degrees of freedom, equivalent to block dimension, means low information.
$OMEGAPD (4 FIX)
;# Prior information to the SIGMAS.
;# Inverse Wishart distribution assumed, unless $SLKJDF, $SVARF
$SIGMAP (0.06 FIXED)
$SIGMAPD (1 FIXED)

$EST METHOD=ITS INTERACTION NITER=0 NOABORT NOPRIOR=1 file=w15_its.ext
$EST METHOD=NUTS AUTO=1 PRINT=100 NITER=1000 NOPRIOR=0 BAYES_PHI_STORE=1 file=w15.ext
