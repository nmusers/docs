;Model Desc: Two compartment Model, Using ADVAN3, TRANS4
;Project Name: nm7examples
;Project ID: NO PROJECT DESCRIPTION

$PROB RUN# Example 8 (from samp5l)
$abbr DECLARE INTEGER FIRST_WRITE 
$abbr DECLARE INTEGER FIRST_WRITE2

$INPUT C SET ID JID TIME  DV=CONC AMT=DOSE RATE EVID MDV CMT CLX V1X QX V2X SDIX SDSX
$DATA example8.csv IGNORE=C

$SUBROUTINES ADVAN3 TRANS4

$PK
include nonmem_reserved_general
; Request extra information for Bayesian analysis.  
; An extra call will then be made
; for accepted samples
BAYES_EXTRA_REQUEST=1
MU_1=THETA(1)
MU_2=THETA(2)
MU_3=THETA(3)
MU_4=THETA(4)
CL=DEXP(MU_1+ETA(1))
V1=DEXP(MU_2+ETA(2))
Q=DEXP(MU_3+ETA(3))
V2=DEXP(MU_4+ETA(4))
S1=V1
; When Bayes_extra=1, then this particular set of individual 
; parameters were "accepted"
; So you may record them if you wish

IF(BAYES_EXTRA==1 .AND. ITER_REPORT>=0 .AND.  FIRST_WRITE==0  .AND. NEWIND/=2) THEN
IF(PNM_RUN_MODE==PNM_SINGLE) THEN 

" OPEN(UNIT=53,FILE='example8.prr')
; If parallel, need to have different file name for each node
; best if a pnm file with -awnf is used, such as mpiwini8_awnf.pnm, 
; and command line option -maxlim=3.  This allows all files to be
; written to primary run directory, and not into worker folders.
ELSE 

" OPEN(UNIT=53,FILE='example8_'//trim(tfi(pnm_node_number))//'.prr')
ENDIF
IF(PNM_NODE_NUMBER==1) THEN ; Only first file should have header, 
; for easy merging later
; When a parallel run is completed you can merge the files with 
; (Windows):
; copy example8_*.prr example.prr
; (Linux):
; cat example8_*.prr > example.prr

" WRITE(53,94) 'ITER_REPORT  ',' ID          ',' CL            ',' V1            ',' Q            ',' V2            ',' OBJI '

" 94 FORMAT(A12,1X,A14,5(1X,A12))
ENDIF
FIRST_WRITE=1
ENDIF

IF(BAYES_EXTRA==1 .AND. ITER_REPORT>=0 .AND. NEWIND/=2 ) THEN
" WRITE(53,95) ITER_REPORT,ID,CL,V1,Q,V2,OBJI(NIREC,1)
" 95 FORMAT(I12,1X,F14.0,5(1X,1PG12.5))
ENDIF

$ERROR
include nonmem_reserved_general
BAYES_EXTRA_REQUEST=1
Y = F + F*EPS(1)

IF(BAYES_EXTRA==1 .AND. ITER_REPORT>=0 .AND. FIRST_WRITE2==0 ) THEN
IF(PNM_RUN_MODE==PNM_SINGLE) THEN
" OPEN(UNIT=54,FILE='example8.iwr')
ELSE
" OPEN(UNIT=54,FILE='example8_'//trim(tfi(pnm_node_number))//'.iwr')
ENDIF
IF(PNM_NODE_NUMBER==1) THEN ; Only one file should have header, 
; for easy merging later
; When a parallel run is completed you can merge the files with 
; (Windows):
; copy example8_*.iwr example.iwr
; (Linux):
; cat example8_*.iwr > example.iwr

" WRITE(54,96) 'ITER_REPORT      ','ID          ','TIME        ','F       '

" 96 FORMAT(A12,1X,A14,2(1X,A12))
ENDIF
FIRST_WRITE2=1
ENDIF

IF(BAYES_EXTRA==1 .AND. ITER_REPORT>=0 ) THEN

" WRITE(54,97) ITER_REPORT,ID,TIME,F

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
; Prior information to the THETAS.

$THETAP (2.0 FIX) (2.0 FIX) (2.0 FIX) (2.0 FIX)

$THETAPV BLOCK(4)
10000 FIX 
0.00 10000
0.00  0.00 10000
0.00  0.00 0.0 10000

; Prior information to the OMEGAS.

$OMEGAP BLOCK(4)
0.2 FIX 
0.0  0.2 
0.0  0.0 0.2
0.0  0.0 0.0 0.2

$OMEGAPD (4 FIX)

$EST METHOD=BAYES INTERACTION FILE=example8.ext NBURN=10000 NITER=1000 PRINT=100 NOPRIOR=0 RANMETHOD=P
     CTYPE=3 CINTERVAL=100
