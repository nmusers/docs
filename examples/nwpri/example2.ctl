 ; These  examples illustrate the use of the NONMEM utility routine NWPRI
 ; by the NM-TRAN $PRIOR record, and also by an equivalent  user-supplied
 ; routine PRIOR.

 ; See
 ; https://nmusers.github.io/docs/reference-manual/control-records/prior/
 ; https://nmusers.github.io/docs/reference-manual/api/subroutines/#prior

 ; Example 2

 ; This example obtains parameter estimates from population data, using a
 ; two-compartment  PK model, and it incorporates a prior of multivariate
 ; normal/inverse Wishart form for all of  the  THETA  vector  and  OMEGA
 ; matrix.

 $PROB POPULATION DATA WITH PRIOR ON THETA AND OMEGA
 $INPUT ID DOSE TIME DV WT
 $DATA data2
 $PRIOR NWPRI NTHETA=3 NETA=3 NTHP=3 NETP=3 NPEXP=1
 $PRED
 ;
 ;     THETA(1)=MEAN ABSORPTION RATE CONSTANT - MEAN ELIM. RATE CONSTANT (l/HR)
 ;     THETA(2)=MEAN ELIM. RATE CONSTANT (1/HR)
 ;     THETA(3)=SLOPE OF CLEARANCE VS WEIGHT RELATIONSHIP (LITERS/HR/KG)
 ;     DOSE=WEIGHT-ADJUSTED DOSE (MG/KG)
 ;
       IF (NEWIND.NE.2) THEN
          AMT=DOSE*WT
          W=WT
       ENDIF
       T0=THETA(1)*EXP(ETA(1))
       T2=THETA(2)*EXP(ETA(2))
       T1=T2+T0
       T3=THETA(3)*W*EXP(ETA(3))
       A=EXP(-T2*TIME)
       B=EXP(-T1*TIME)
       C=T1-T2
       D=A-B
       E=T3*C
       Y=AMT*T1*T2/E*D+EPS(1)
 $THETA  (0,4,5) (0,.09,.5) (.004,.01,.9)
 ;prior of THETA:
 $THETAP 3 FIX .08 FIX .04 FIX
 ;df of prior of OMEGA:
 $OMEGAPD 12 FIX
 $OMEGA BLOCK (3) .7 .04 .05 .02 .06 .08
 ;prior of THETA's covariance matrix:
 $THETAPV BLOCK (3) .494 .00207 .0000847 .000692 .0000471 .0000292 FIX
 ;prior of OMEGA:
 $OMEGAP BLOCK (3) .7 .04 .05 .02 .06 .08 FIX
 $SIGMA  .4

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
 ;       NETA=3
 ;       NTHP=3
 ;       NETP=3
 ;       NPEXP=1
 ;       PLEV=0.
 ;       ITYP=0
 ;       NSAM=0
 ;       ISS=0
 ;       NEPS=0
 ;       NEPP=0
 ;       CALL NWPRI(NTHETA,NETA,NEPS,NTHP,NETP,NEPP,NPEXP,ITYP,PLEV, &
 ;                   NSAM,ISS,CNT)
 ;       RETURN
 ;       END


 REFERENCES: none.


  <pre>Go to <A HREF=index.htm>main index</A>.</pre>
<pre>
  <hr ALIGN=LEFT WIDTH="450"></pre>
    <i><font size=-1>Created by nmhelp2html v. 1.0 written by Niclas Jonsson (Modified by AJB 5/2006,11/2007,10/2012)</font>
      </i><br>
</BODY></HTML>
