$PROB RUN# Example 1 (from samp5l)
$INPUT C SET ID JID TIME  DV=CONC AMT=DOSE RATE EVID MDV CMT
$DATA w15.csv IGNORE=@

$SUBROUTINES ADVAN3 TRANS4 ;# Two compartment Model

$PK
MU_1=THETA(1)
MU_2=THETA(2)
MU_3=THETA(3)
MU_4=THETA(4)
;# ETAs: normally distruted with mean 0, variance OMEGA().
;# PHI=MU+ETA: normally distruted with mean MU, and variance OMEGA()
;# thus individual parameters CL,V1,Q,V2 follow log-normal distribution.
CL=DEXP(MU_1+ETA(1))
V1=DEXP(MU_2+ETA(2))
Q=DEXP(MU_3+ETA(3))
V2=DEXP(MU_4+ETA(4))
S1=V1

;# Y is normally distributed, with sd is F*SQRT(SIGMA(1,1))
$ERROR
Y = F + F*EPS(1)

;# Initial values of THETA, OMEGA, SIGMA
$THETA
 2.0 ;# [LN(CL)]
 2.0 ;# [LN(V1)]
 2.0 ;# [LN(Q)]
 2.0 ;# [LN(V2)]
$OMEGA BLOCK(4)
0.15 ;# [P]
0.01 ;# [F]
0.15 ;# [P]
0.01 ;# [F]
0.01 ;# [F]
0.15 ;# [P]
0.01 ;# [F]
0.01 ;# [F]
0.01 ;# [F]
0.15 ;# [P]
$SIGMA
(0.6 )   ;# [P]

$PRIOR NWPRI
;# THETA Priors follow normal distribution (use $TTDF for t-distriution).
;# This normal prior is specfied by $THETAP (mean) and $THETAPV (covariance)
$THETAP (2.0 FIX) (2.0 FIX) (2.0 FIX) (2.0 FIX)
 ;# uninformative prior with large variance
$THETAPV BLOCK(4) FIXED VALUES(50.0,0.0)

;# Inverse Wishart dist for OMEGA's prior, unless $OLKJDF, $OVARF used.
$OMEGAP BLOCK(4) FIXED VALUES(0.15,0.0)
;# Uninformative prior: low degrees of freedom, equivalent to block dimension.
$OMEGAPD (4 FIX)

;# Inverse Wishart dist for SIGMA's prior, unless $SLKJDF, $SVARF used
$SIGMAP (0.06 FIXED)
$SIGMAPD (1 FIXED)

$EST METHOD=ITS INTERACTION NITER=0 NOABORT NOPRIOR=1 file=w15_its.ext
$EST METHOD=NUTS AUTO=1 PRINT=100 NITER=1000 NOPRIOR=0 BAYES_PHI_STORE=1 file=w15.ext delim=q
