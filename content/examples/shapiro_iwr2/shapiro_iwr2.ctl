$SIZES ISAMPLEMAX=1100
;Model Desc: Two compartment Model, Using ADVAN3, TRANS4
;Project Name: example1
;Project ID: gm00-001

$PROB RUN# shapiro_iwr2 (from samp5l)
$ABBR DECLARE INTEGER FIRST_WRITE
$INPUT C SET ID JID TIME  DV=CONC AMT=DOSE RATE EVID MDV CMT 
       CLX V1X QX V2X SDIX SDSX
$DATA shapiro_iwr2.csv IGNORE=C

$SUBROUTINES ADVAN3 TRANS4

$PK
include \users\bauerr\pdxpop540\nonmem_reserved_general
SAEM_EXTRA_REQUEST=1
MU_1=THETA(1)
MU_2=THETA(2)
MU_3=THETA(3)
MU_4=THETA(4)
CL=DEXP(MU_1+ETA(1))
V1=DEXP(MU_2+ETA(2))
Q=DEXP(MU_3+ETA(3))
V2=DEXP(MU_4+ETA(4))
S1=V1

$ERROR
include \users\bauerr\pdxpop540\nonmem_reserved_general
SAEM_EXTRA_REQUEST=1
IPRE=F
IWRES=(DV-IPRE)/IPRE/SQRT(SIGMA(1,1))
Y = F + F*EPS(1)

; When SAEM_extra=1, then this particular set of individual 
; parameters were "accepted" So you may record them if you wish

IF(SAEM_EXTRA==1 .AND. EVID==0 .AND. FIRST_WRITE==0) THEN
IF(PNM_RUN_MODE==PNM_SINGLE) THEN ; best if a pnm file with -awnf is used.
" OPEN(UNIT=52,FILE='shapiro_iwr2.iwr')
ELSE ;If parallel, need to have different file name for each node
" OPEN(UNIT=52,FILE='shapiro_iwr2_'//trim(tfi(pnm_node_number))//'.iwr')
ENDIF
IF(PNM_NODE_NUMBER==1) THEN ; Only one file should have header, for easy merging later
" WRITE(52,96) 'SAMPLE      ','ID          ','TIME        ','IWRES       '
" 96 FORMAT(A12,1X,A14,2(1X,A12))
ENDIF
FIRST_WRITE=1
ENDIF



IF(SAEM_EXTRA==1 .AND. EVID==0 ) THEN
" WRITE(52,97) SAEM_SAMPLE,ID,TIME,IWRES
" 97 FORMAT(I12,1X,F14.0,2(1X,1PG12.5))
ENDIF

; Initial values of THETA
$THETA 
(2.0) ;[LN(CL)]
(2.0) ;[LN(V1)]
(2.0) ;[LN(Q)]
(2.0) ;[LN(V2)]
;INITIAL values of OMEGA
$OMEGA BLOCK(4)
0.15   ;[P]
0.01  ;[F]
0.15   ;[P]
0.01  ;[F]
0.01  ;[F]
0.15   ;[P]
0.01  ;[F]
0.01  ;[F]
0.01  ;[F]
0.15   ;[P]
;Initial value of SIGMA
$SIGMA 
(0.6 )   ;[P]


$PRIOR NWPRI
; Prior information to the Thetas.
$THETAP (2.0 FIX)x4
$THETAPV BLOCK(4) FIX VALUES(10000.0,0.0)

; Prior information to the OMEGAS.
$OMEGAP BLOCK(4)
0.2 FIX 
0.0  0.2 
0.0  0.0 0.2
0.0  0.0 0.0 0.2
$OMEGAPD (4 FIX)

$EST METHOD=SAEM NBURN=500 NITER=300 MASSRESET=1 PRINT=20 NOPRIOR=1 RANMETHOD=P CTYPE=3
$EST METHOD=SAEM NBURN=0 NITER=0 MASSRESET=0 ETASAMPLES=1 ISAMPLE=1000 EONLY=1
$EST METHOD=IMP NITER=5 MASSRESET=1 ETASAMPLES=0 ISAMPLE=1000 EONLY=1 PRINT=1 MAPITER=0
$TABLE ID TIME CL V1 Q V2 ONEHEADER FIRSTONLY NOAPPEND NOPRINT FILE=shapiro_iwr2.tab ; need a .tab file produced, so PDx-pop R script loader works
