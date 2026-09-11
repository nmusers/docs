 ; These  examples illustrate the use of the NONMEM utility routine NWPRI
 ; by the NM-TRAN $PRIOR record, and also by an equivalent  user-supplied
 ; routine PRIOR.

 ; See
 ; https://nmusers.github.io/docs/reference-manual/control-records/prior/
 ; https://nmusers.github.io/docs/reference-manual/api/subroutines/#prior

 ; Example 1

 ; Use of PRIOR and NWPRI and a control stream for single-subject data:

 ; This  example  obtains  parameter  estimates from single subject data,
 ; using a two-compartment PK model, and it incorporates a prior of  mul-
 ; tivariate normal form for all of the THETA vector.

 $PROB SINGLE SUBJECT DATA WITH PRIOR ON THETA
 $INPUT ID DOSE TIME DV WT
 $DATA data1
 $PRIOR NWPRI NTHETA=3,NETA=1,NTHP=3,NPEXP=1
 $PRED
 ;
 ;     THETA(1)=MEAN ABSORPTION RATE CONSTANT
 ;     THETA(2)=MEAN ELIM. RATE CONSTANT (1/HR)
 ;     THETA(3)=CLEARANCE (LITERS/HR)
 ;     DOSE=WEIGHT-ADJUSTED DOSE (MG/KG)
 ;
       IF (NEWIND.EQ.0) AMT=DOSE*WT
       T1=THETA(1)
       T2=THETA(2)
       T3=THETA(3)
       A=EXP(-T2*TIME)
       B=EXP(-T1*TIME)
       C=T1-T2
       D=A-B
       E=T3*C
       Y=AMT*T1*T2/E*D+ETA(1)

 $THETA  (.4,1.7,7) (.025,.102,.4) (.3,3,30)
 ; prior for THETA:
 $THETAP 2.77 FIX .0781 FIX 2.63 FIX
 $OMEGA .388
 ; prior for THETA's covariance matrix:
 $THETAPV BLOCK (3) 5.55 .00524 .00024 -.128 .00911 .515 FIX

 $EST

 ; Instead of a $PRIOR record, the following may be used:

 ; $SUBROUTINE PRIOR=prior

 ; The Fortran prior routine is as follows:

 ;       SUBROUTINE PRIOR (ICALL,CNT)
 ;       USE SIZES,     ONLY: DPSIZE,ISIZE
 ;       REAL(KIND=DPSIZE) :: CNT
 ;       REAL(KIND=DPSIZE) :: PLEV
 ;       INTEGER(KIND=ISIZE) :: ICALL
 ;       NTHETA=3
 ;       NETA=1
 ;       NTHP=3
 ;       NPEXP=1
 ;       PLEV=0.
 ;       ITYP=0
 ;       NSAM=0
 ;       ISS=0
 ;       NEPS=0
 ;       NETP=0
 ;       NEPP=0
 ;       CALL NWPRI(NTHETA,NETA,NEPS,NTHP,NETP,NEPP,NPEXP,ITYP,PLEV, &
 ;                   NSAM,ISS,CNT)
 ;       RETURN
 ;       END
