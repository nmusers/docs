!*********************************COPYRIGHT******************************************
!                                                                                   !
!       THE NONMEM SYSTEM MAY BE DISTRIBUTED ONLY BY ICON DEVELOPMENT               !
!       SOLUTIONS.                                                                  !
!                                                                                   !
!       COPYRIGHT BY ICON DEVELOPMENT SOLUTIONS                                     !
!       2009-2017 ALL RIGHTS RESERVED.                                              !
!                                                                                   !
!************************************************************************************
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!---------------------------------- FIDAINIT.F90 ------------------------------------
!
! SUBROUTINE FIDAINIT(NTOTAL,NBASE,NSENSE,NDES,IPAR,RPAR)
!
! DESCRIPTION :  User may define settings to IDAS in this routine
!
!
! ARGUMENTS   : NTOTAL,NBASE,NSENSE,NDES,IPAR,RPAR
!               IN     - NTOTAL,NDES
!               OUT    - NONE
!               IN OUT - NBASE,NSENSE,IPAR,RPAR
!
! CALLED BY   : IDANM
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf), v2.6.2 to change settings
!
! MODULES USED: PRIDA,CVIDAROOT,PRSIZES,NMPRD_INT
!
! CONTAINS    : NONE
!
! LOCALS      : ALLOC_FLAG,IFIRST,NCORE
!
!---------------------------- END OF HEADER -----------------------------------------
!
      SUBROUTINE FIDAINIT(NTOTAL,NBASE,NSENSE,NDES,IPAR,RPAR)
!
      USE PRIDA,        ONLY: IFIDAEWT,IFIDASOLVE,IFIDAJAC,IFIDAJTIMES,FIDAMU,FIDAML,&
                              IFIDAMAXL,IFIDAGSTYPE,FIDANNZ,FIDAORDERING,IFIDAMAXRS, &
                              FIDAEPLIFAC,FIDADQINCFAC,IFIDAPRETYPE
!
      USE CVIDAROOT,    ONLY: NRTFN,NRTCT,RTINFO,RTSIGNAL,TRTINFO,YRTINFO,YPRTINFO,  &
                              GRTINFO
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
! INTEGER
      USE NMPRD_INT,    ONLY: IFIRSTEMJAC
!
!IN-NTOTAL,NDES
!inout-NBASE,NSENSE,IPAR,RPAR
! Consult chapter 5 of IDA v2.8.2, Sundials manual, v2.6.2 to change settings
      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE), INTENT(IN) :: NTOTAL,NDES
      INTEGER(KIND=ISIZE), INTENT(IN OUT) :: IPAR(*),NBASE,NSENSE
      REAL(KIND=DPSIZE), INTENT(IN OUT) :: RPAR(*)
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
      INTEGER(KIND=ISIZE) :: ALLOC_FLAG,IFIRST,NCORE
!
      DATA IFIRST /1/
      DATA ALLOC_FLAG /0/
      SAVE
!

! METHOD USED IS ALWAYS BDF STIFF

      NCORE=NBASE
! COMMENT OUT THE NEXT TWO LINES IF YOU WANT IDAS TO CARRY OUT SENSITIVITY EQUATION MANIPULATIONS
! When NRTFN>0, you may need to uncomment the next two lines if not working properly, for ITS/FOCE/LAPLACE
!      NBASE=NTOTAL
!      NSENSE=0

! User Should Initialize Based On Desired Settings.
! The IPAR array will be available for subsequent user-supplied routines
      IPAR(1)=NBASE ! NUMBER OF TOTAL USER EQUATIONS (DES + AES)
      IPAR(2)=NSENSE ! NUMBER OF PARAMETERS TO BE OPTIMIZED (OR NUMBER OF SENSITIVITY ITEMS)
      IPAR(3)=NTOTAL ! NTOTAL=(NSENSE+1)*NBASE, TOTAL NUMBER OF EQUATIONS IN PROBLEM
      IPAR(4)=NDES ! NUMBER OF DES EQUATIONS

! If set to 1, provide routine FIDAEWT algorithm to provide error weights used in WRMS norm evaluations.
      IFIDAEWT=0

! IFIDASOLVE:
!         =1 not used (there is no FIDA DIAG solver)
!         =2 FOR IDA DENSE SOLVER
!         =3 FOR LAPACK-DENSE SOLVER
!         =4 FOR  IDA DIRECT BAND SOLVER
!         =5 FOR LAPACK BAND SOLVER
!6: SPGMR treatment
!7: SPBCG treatment
!8: SPTFQMR treatment
!9: KLU sparse treatment
!10: Super LUMT sparse treatment
      IFIDASOLVE=2


! band treatment values (FOR IFIDASOLVE=9, 10)
      FIDAMU=MAX(NBASE-2,1)
      FIDAML=MAX(NBASE-2,1)
! Ordering for IFIDASOLVE=9,10: 0=AMD, 1=COLAMD
      FIDAORDERING=0
      FIDANNZ=NBASE*NBASE


! jacobian type IFIDAJAC
!0: no user Jacobian
!1: user Jacobian (set to 1 only if IFIRSTEMJAC>0
      IFIDAJAC=0
      IF(IFIRSTEMJAC>0) IFIDAJAC=1
!     IFIRSTEMJAC IS 1 IF IFIRSTEM=1 IN $PK.  THIS MAY OCCUR IF CLASSICAL FO/FOCE/LAPLACE, ESTIMATION IS DONE, OR
!     IF USER IMPOSES IT AS THE FIRST LINE IN $PK:
!     $PK
!     IFIRSTEM=1
! OR
!     $PK
!     "IFIRSTEM=1


! set IFIDAJTIMES=1 to implent user supplied FIDAJTIMES  routine, also set IFIDAJAC=1
      IFIDAJTIMES=0

      IFIDAPRETYPE=0
      IF(IFIDASOLVE>=6.AND.IFIDASOLVE<=8) IFIDAPRETYPE=1
! arguments to treatment IFIDASOLVE= 6-8
      IFIDAGSTYPE=1
! Normally,  IFIDAMAXL=0, using default of 5.  But for Sensitivity, methods, needs more.
      IFIDAMAXL=20
      FIDAEPLIFAC=0.0D+00
      FIDADQINCFAC=0.0D+00
      IFIDAMAXRS=0



!     RPAR(1 TO NEQ*NEQ) RESERVED FOR JACOBIAN EVALUATIONS

! SET NRTFN TO THE NUMBER OF ROOT FINDING EQUATIONS TO BE ADDED
! remember TO DEFINE FCVROOTFN (SEE END OF THIS FILE FOR ITS HOOK)
! PLACE AT BEGINNING OF $PK:
!"      USE CVIDAROOT, ONLY: NRTFN,RTINFO,RTSIGNAL
! OR
! include nonmem_reserved_general
! THEN IN TEST IF RTSIGNAL>0, AND CAN CHECK ON RTINFO()
! HERE IS AN EXAMPLE OF $PK CODE:
!include nonmem_reserved_general
!; GRTINFO ARRAY CAN BE USED TO SEND INFORMATION TO ROOT FINDER ROUTINE
!" IF(NRTCT>0) THEN
!" GRTINFO(1)=16.0
!" GRTINFO(2)=17.0
!" ENDIF
!" IF(RTSIGNAL>0.AND.ID==1) THEN
!" DO I=1,RTSIGNAL
!" WRITE(50,*) I,TRTINFO(I),RTINFO(1,I),RTINFO(2,I),YRTINFO(1,I),YRTINFO(2,I),YRTINFO(3,I)
!" ENDDO
!" RTSIGNAL=0
!" ENDIF

! RTSIGNAL IS THE NUMBER OF DISTINCT TIMES BETWEEN TIME1 AND TIME2 (WHERE INTEGRATION OCCURS IN THAT INTERVAL)
! WHERE A 0 CROSSING OCCURED FOR THE G ARRAY DEFINED IN FCVROOTFN.
! TRTINFO(I) IS THE TIME OF THE ITH 0 CROSSING THAT OCCURRED BETWEEN TIME1 AND TIME2
! RTINFO(J,I) CROSSING INFORMATION FOR G(J), AT TIME TRTINFO(I)
! (0=NO ZERO CROSSING, 1=ZERO CORSSING INCREASING, -1=ZERO CROSSING DECREASING)
! YRTINFO(K,I) IS A(K) AT TIME TRTINFO(I)
! YPRTINFO(K,I) IS DADT(K) AT TIME AT TRTINFO(I)
! NRTCT=MAXIMUM NUMBER OF TIME CROSSINGS THAT MAY OCCUR FROM ANY INTERVAL TIME1 TO TIME2
! USUALLY NRTCT=NRTFN IS SUFFICIENT, BUT IF YOU HAVE SOME PERIODIC PROCESS SUCH AS A SIN FUNCTION,
! THEN A GIVEN ROOT FUNCTION COULD CROSS SEVERAL TIMES BETWEEN TIME1 AND TIME2
! YOU MAY USE GRTINFO AS AN ARRAY OF PARAMETERS THAT CAN BE PASSED FROM $PK TO FCVROOTFN/FIDAROOTFN ROUTINE


      NRTFN=1
      NRTCT=NRTFN
      IF(NRTFN/=0.AND.ALLOC_FLAG==0) THEN
        ALLOCATE(RTINFO(NRTFN,NRTCT))
        ALLOCATE(YRTINFO(NCORE,NRTCT))
        ALLOCATE(YPRTINFO(NCORE,NRTCT))
        ALLOCATE(TRTINFO(NRTCT))
! ALLOCATE GRTINFO TO DIMENSION NECESSARY FOR PASSING PARAMETER INFORMATION TO FCVROOTFN/FIDAROOTFN
        ALLOCATE(GRTINFO(50))
        ALLOC_FLAG=1
      ENDIF

 999  RETURN
      END SUBROUTINE FIDAINIT
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!----------------------------------- FIDAEWT.F90 ------------------------------------
!
! SUBROUTINE FIDAEWT(Y,EWT,IPAR,RPAR,IER)
!
! DESCRIPTION : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
!
! ARGUMENTS   : Y,EWT,IPAR,RPAR,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FIDAEWT(Y, EWT, IPAR, RPAR, IER)
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
!
!NOINOUT-Y, EWT, IPAR, RPAR, IER
!SET IFIDAEWT TO 1 IF YOU WANT THIS ROUTINE TO BE USED.
      IMPLICIT NONE
!
      REAL(KIND=DPSIZE)   :: Y(*),EWT(*),RPAR(*)
      INTEGER(KIND=ISIZE) :: IER,IPAR(*)
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
! SUPPLY CODE HERE
 999  RETURN
      END SUBROUTINE FIDAEWT
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!---------------------------------- FIDADJAC.F90 ------------------------------------
!
! SUBROUTINE FIDADJAC(NEQ,T,Y,YP,R,DJAC,CJ,EWT,H,IPAR,RPAR,WK1,WK2,WK3,IER)
!
! DESCRIPTION : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
!
! ARGUMENTS   : NEQ,T,Y,YP,R,DJAC,CJ,EWT,H,IPAR,RPAR,WK1,WK2,WK3,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : JAC
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
! MODULES USED: PRSIZES,PR_INTERFACE
!
! CONTAINS    : NONE
!
! LOCALS      : I,J,IRES
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FIDADJAC(NEQ, T, Y, YP, R ,DJAC, CJ, EWT, H,IPAR,RPAR,WK1,WK2,WK3,IER)
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
! INTERFACE
      USE PR_INTERFACE, ONLY: JAC
!
!NOINOUT-NEQ, T, Y, YP, R ,DJAC, CJ, EWT, H,IPAR,RPAR,WK1,WK2,WK3,IER
! When using Dense solver, IFIDASOLVE=2-3), and IFIDAJAC=1, user must supply dense JAcobian evaluator
      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE) :: NEQ,IER,IPAR(*)
      REAL(KIND=DPSIZE)   :: T,Y(*),YP(*),DJAC(NEQ,*),RPAR(NEQ,*),WK1(*),WK2(*),     &
                             WK3(*),H,R(*),CJ,EWT(*)
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
      INTEGER(KIND=ISIZE) :: I,J,IRES
!

      CALL JAC(NEQ,DJAC,NEQ)
! ADD CONSTANT TO DIAGONALS OF JACOBIANS OF DES TYPE COMPARTMENTS (THE FIRST NDES=IPAR(4) EQUATIONS).
!  SIMILAR TO WHAT ADDA ROUTINE DOES FOR ADVAN9/LSODI1
      DO I=1,IPAR(4)
        DJAC(I,I)=DJAC(I,I)-CJ
      ENDDO
      IER=0
 999  RETURN
      END SUBROUTINE FIDADJAC
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!---------------------------------- FIDABJAC.F90 ------------------------------------
!
! SUBROUTINE FIDABJAC(NEQ,MU,ML,MDIM,T,Y,YP,R,CJ,BJAC,EWT,H,IPAR,RPAR,WK1,WK2,WK3,&
!    IER)
!
! DESCRIPTION : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
!
! ARGUMENTS   : NEQ,MU,ML,MDIM,T,Y,YP,R,CJ,BJAC,EWT,H,IPAR,RPAR,WK1,WK2,WK3,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : JAC
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
! MODULES USED: PRSIZES,PR_INTERFACE
!
! CONTAINS    : NONE
!
! LOCALS      : I,J,K
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FIDABJAC(NEQ, MU, ML, MDIM, T, Y, YP, R, CJ, BJAC,EWT, H,IPAR,RPAR,WK1,WK2,WK3,IER)
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
! INTERFACE
      USE PR_INTERFACE, ONLY: JAC
!
!NOINOUT-NEQ, MU, ML, MDIM, T, Y, YP, R, CJ, BJAC,EWT, H,IPAR,RPAR,WK1,WK2,WK3,IER
! if IFIDASOLVE=4-5, and IFIDAJAC=1, user must suply FIDABJAC
      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE) :: NEQ,IER,MU,ML,MDIM,IPAR(*)
      REAL(KIND=DPSIZE)   :: T,Y(*),YP(*),BJAC(MDIM,*),RPAR(NEQ,*),WK1(*),WK2(*),    &
                             WK3(*),H,CJ,EWT(*),R(*)
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
      INTEGER(KIND=ISIZE) :: I,J,K
!
      CALL JAC(NEQ,RPAR,NEQ)
! LOAD MDIM BY NEQ ARRAY BJAC WITH J(I,J)
      DO I=1,NEQ
        DO J=1,NEQ
          K=I-J+MU+1
          IF(K<1) CYCLE
          IF(K>ML+MU+1) CYCLE
          BJAC(K,J)=RPAR(I,J)
        ENDDO
      ENDDO
      IER=0
 999  RETURN
      END SUBROUTINE FIDABJAC
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!---------------------------------- FIDASPJAC.F90 -----------------------------------
!
! SUBROUTINE FIDASPJAC(T,CJ,Y,YP,R,N,NNZ,JDATA,JRVALS,JCPTRS,H,IPAR,RPAR,WK1,WK2,WK3,&
!    IER)
!
! DESCRIPTION : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
!
! ARGUMENTS   : T,CJ,Y,YP,R,N,NNZ,JDATA,JRVALS,JCPTRS,H,IPAR,RPAR,WK1,WK2,WK3,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FIDASPJAC(T, CJ, Y, YP, R, N, NNZ, JDATA, JRVALS, JCPTRS, H, IPAR, RPAR, &
        WK1, WK2, WK3, IER)
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
!
!noinout-T, CJ, Y, YP, R, N, NNZ, JDATA, JRVALS, JCPTRS, H, IPAR, RPAR, WK1, WK2, WK3, IER
! Used if IFIDASOLVE=9-10
      IMPLICIT NONE
!
      REAL(KIND=DPSIZE)   :: T,Y(*),YP(*),RPAR(*),WK1(*),WK2(*),WK3(*),H,CJ,R(*)
      INTEGER(KIND=ISIZE) :: N,NNZ,IPAR(*),JDATA,JRVALS,JCPTRS,IER
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
      IER=0
 999  RETURN
      END SUBROUTINE FIDASPJAC
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!--------------------------------- FIDAJTIMES.F90 -----------------------------------
!
! SUBROUTINE FIDAJTIMES(T,Y,YP,R,V,FJV,CJ,EWT,H,IPAR,RPAR,WORK,IER)
!
! DESCRIPTION : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
!
! ARGUMENTS   : T,Y,YP,R,V,FJV,CJ,EWT,H,IPAR,RPAR,WORK,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : JAC
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : DVAL,I,J,NEQ
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FIDAJTIMES( T, Y, YP, R, V, FJV, CJ, EWT, H, IPAR, RPAR, WORK, IER)
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
!
!NOINOUT-T, Y, YP, R, V, FJV, CJ, EWT, H, IPAR, RPAR, WORK, IER
! Used if IFIDAJTIMES=1, IFIDAJAC=1, and IFIDASOLVE=6-8
      IMPLICIT NONE
!
      REAL(KIND=DPSIZE)   :: Y(*),YP(*),RPAR(*),WORK(*),H,T,R(*),V(*),FJV(*),EWT(*), &
                             CJ
      INTEGER(KIND=ISIZE) :: IPAR(*),IER
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
      REAL(KIND=DPSIZE)   :: DVAL
      INTEGER(KIND=ISIZE) :: I,J,NEQ
!
      NEQ=IPAR(1)
      CALL JAC(NEQ,RPAR,NEQ)

      DO I=1,NEQ
        DVAL=0.0D+00
        DO J=1,NEQ
          DVAL=DVAL+RPAR( (J-1)*NEQ + I )* V(J)
        ENDDO
        FJV(I)=DVAL
      ENDDO

      IER=0
 999  RETURN
      END SUBROUTINE FIDAJTIMES
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!---------------------------------- FIDAPSOL.F90 ------------------------------------
!
! SUBROUTINE FIDAPSOL(T,Y,YP,R,RV,ZV,CJ,DELTA,EWT,IPAR,RPAR,WORK,IER)
!
! DESCRIPTION : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
!
! ARGUMENTS   : T,Y,YP,R,RV,ZV,CJ,DELTA,EWT,IPAR,RPAR,WORK,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : LR
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FIDAPSOL(T, Y, YP, R, RV, ZV, CJ, DELTA, EWT, IPAR, RPAR, &
        WORK, IER)
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
!
!NOINOUT-T, Y, YP, R, RV, ZV, CJ, DELTA, EWT, IPAR, RPAR,WORK, IER
! Used if IFIDASOLVE=6-8, IFIDAJAC=1, and IFIDAPRETYPE>0
      IMPLICIT NONE
!
      REAL(KIND=DPSIZE)   :: T,Y(*),YP(*),R(*),RPAR(*),WORK(*),DELTA,RV(*),ZV(*),    &
                             EWT(*),CJ
      INTEGER(KIND=ISIZE) :: IER,IPAR(*)
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
      INTEGER(KIND=ISIZE) :: LR
!
      IER=0
 999  RETURN
      END SUBROUTINE FIDAPSOL
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!---------------------------------- FIDAPSET.F90 ------------------------------------
!
! SUBROUTINE FIDAPSET(T,Y,YP,R,CJ,EWT,H,IPAR,RPAR,WORK1,WORK2,WORK3,IER)
!
! DESCRIPTION : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
!
! ARGUMENTS   : T,Y,YP,R,CJ,EWT,H,IPAR,RPAR,WORK1,WORK2,WORK3,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FIDAPSET(T, Y, YP, R,  CJ, EWT, H, IPAR, RPAR, WORK1, WORK2, &
        WORK3, IER)
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
!
!NOINOUT-T, Y, YP, R,  CJ, EWT, H, IPAR, RPAR, WORK1, WORK2, WORK3, IER
! May be Used if IFIDASOLVE=6-8, IFIDAJAC=1, and IFIDAPRETYPE>0, and if user's preconditioner requires  Jacobian related data
! be evaluated or preprocessed
      IMPLICIT NONE
!
      REAL(KIND=DPSIZE)   :: T,Y(*),YP(*),H,WORK1(*),WORK2(*),WORK3(*),RPAR(*),R(*), &
                             EWT(*),CJ
      INTEGER(KIND=ISIZE) :: IPAR(*),IER
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
      IER=0
 999  RETURN
      END SUBROUTINE FIDAPSET
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!------------------------------ FIDALAPACKDENSE2.F90 --------------------------------
!
! SUBROUTINE FIDALAPACKDENSE2(NEQ,IER)
!
! DESCRIPTION : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
!
! ARGUMENTS   : NEQ,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : IDANM
!
! CALLS       : FIDALAPACKDENSE
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

! the following are connector routines to additional packs.  Uncomment when packs are available.
      SUBROUTINE FIDALAPACKDENSE2(NEQ,IER)
!
      USE PRSIZES,      ONLY: ISIZE
!
!
!NOINOUT-NEQ,IER
      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE) :: NEQ,IER
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
      CALL FIDALAPACKDENSE(NEQ,IER)
 999  RETURN
      END SUBROUTINE FIDALAPACKDENSE2
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!------------------------------- FIDALAPACKBAND2.F90 --------------------------------
!
! SUBROUTINE FIDALAPACKBAND2(NEQ,FIDAMU,FIDAML,IER)
!
! DESCRIPTION : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
!
! ARGUMENTS   : NEQ,FIDAMU,FIDAML,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : IDANM
!
! CALLS       : FIDALAPACKBAND
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!


      SUBROUTINE FIDALAPACKBAND2(NEQ,FIDAMU,FIDAML,IER)
!
      USE PRSIZES,      ONLY: ISIZE
!
!
!NOINOUT-NEQ,FIDAMU,FIDAML,IER
      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE) :: NEQ,FIDAMU,FIDAML,IER
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
      CALL FIDALAPACKBAND(NEQ,FIDAMU,FIDAML,IER)
 999  RETURN
      END SUBROUTINE FIDALAPACKBAND2
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!--------------------------- FIDALAPACKDENSESETJAC2.F90 -----------------------------
!
! SUBROUTINE FIDALAPACKDENSESETJAC2(IFLAG,IER)
!
! DESCRIPTION : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
!
! ARGUMENTS   : IFLAG,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : IDANM
!
! CALLS       : FIDALAPACKDENSESETJAC
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FIDALAPACKDENSESETJAC2(IFLAG,IER)
!
      USE PRSIZES,      ONLY: ISIZE
!
!
!NOINOUT-IFLAG,IER
      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE) :: IFLAG,IER
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
      CALL FIDALAPACKDENSESETJAC(IFLAG,IER)
 999  RETURN
      END SUBROUTINE FIDALAPACKDENSESETJAC2
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!---------------------------- FIDALAPACKBANDSETJAC2.F90 -----------------------------
!
! SUBROUTINE FIDALAPACKBANDSETJAC2(IFLAG,IER)
!
! DESCRIPTION : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
!
! ARGUMENTS   : IFLAG,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : IDANM
!
! CALLS       : FIDALAPACKBANDSETJAC
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FIDALAPACKBANDSETJAC2(IFLAG,IER)
!
      USE PRSIZES,      ONLY: ISIZE
!
!
!NOINOUT-IFLAG,IER
      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE) :: IFLAG,IER
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
      CALL FIDALAPACKBANDSETJAC(IFLAG,IER)
 999  RETURN
      END SUBROUTINE FIDALAPACKBANDSETJAC2
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!---------------------------------- FIDAKLU2.F90 ------------------------------------
!
! SUBROUTINE FIDAKLU2(NEQ,FIDANNZ,FIDAORDERING,IER)
!
! DESCRIPTION : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
!
! ARGUMENTS   : NEQ,FIDANNZ,FIDAORDERING,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : IDANM
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FIDAKLU2(NEQ,FIDANNZ,FIDAORDERING,IER)
!
      USE PRSIZES,      ONLY: ISIZE
!
!
!NOINOUT-NEQ,FIDANNZ,FIDAORDERING,IER
! KLU sparse routines not presently included in IDAode.a or IDAode.lib of NONMEM
      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE) :: NEQ,FIDANNZ,FIDAORDERING,IER
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
!            CALL FIDAKLU(NEQ,FIDANNZ,FIDAORDERING,IER)
 999  RETURN
      END SUBROUTINE FIDAKLU2
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!------------------------------- FIDASUPERLUMT2.F90 ---------------------------------
!
! SUBROUTINE FIDASUPERLUMT2(NEQ,FIDANNZ,FIDAORDERING,IER)
!
! DESCRIPTION : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
!
! ARGUMENTS   : NEQ,FIDANNZ,FIDAORDERING,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : IDANM
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!


      SUBROUTINE FIDASUPERLUMT2(NEQ,FIDANNZ,FIDAORDERING,IER)
!
      USE PRSIZES,      ONLY: ISIZE
!
!
!NOINOUT-NEQ,FIDANNZ,FIDAORDERING,IER
! SUPER LUMT sparse routines not presently included in IDAode.a or IDAode.lib of NONMEM
      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE) :: NEQ,FIDANNZ,FIDAORDERING,IER
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
!      CALL FIDASUPERLUMT(NEQ,FIDANNZ,FIDAORDERING,IER)
 999  RETURN
      END SUBROUTINE FIDASUPERLUMT2
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!--------------------------------- FIDAROOTFN.F90 -----------------------------------
!
! SUBROUTINE FIDAROOTFN(T,Y,YP,G,IPAR,RPAR,IER)
!
! DESCRIPTION : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
!
! ARGUMENTS   : T,Y,YP,G,IPAR,RPAR,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of IDA 2.8.2, of Sundials manual (ida_guide.pdf)
!
! MODULES USED: CVIDAROOT,PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

! DEFINE SUBROUTINE FOR ROOT FINDING
      SUBROUTINE FIDAROOTFN(T, Y, YP, G, IPAR, RPAR, IER)
!
      USE CVIDAROOT,    ONLY: NRTFN,NRTCT,RTINFO,RTSIGNAL,TRTINFO,YRTINFO,YPRTINFO,  &
                              GRTINFO
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
!
!NOINOUT-T, Y, YP, G, IPAR, RPAR, IER
! T=TIME, G()=ARRAY OF FUNCTIONS OF TIME AND STATES Y(*) AND DERIVATIVES YP(*): THERE ARE NRTFN OF THE G() ARRAY
      REAL(KIND=DPSIZE)   :: T,G(*),Y(*),YP(*),RPAR(*)
      INTEGER(KIND=ISIZE) :: IPAR(*),IER,IRES

!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
! IER=0 MEANS SUCCESSFUL
!      IRES=1
!      IER=0
!      CALL RES(IPAR(1),T,Y,YP,RPAR,IRES)
! ENTER SPECIFIC CODE HERE
! THIS ROOT-FINDER EXAMPLE CAN FIND THE EXACT TMAX AND CMAX, BY FINDING WHEN DADT(2) (here YP(2)) IS ZERO
      G(1)=YP(2)
!      G(1)= (GRTINFO(1)*Y(1)-GRTINFO(2)*Y(2))/GRTINFO(3)
      IER=0
 999  RETURN
      END SUBROUTINE FIDAROOTFN
