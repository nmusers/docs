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
!----------------------------------- FCVINIT.F90 ------------------------------------
!
! SUBROUTINE FCVINIT(NTOTAL,NBASE,NSENSE,IPAR,RPAR)
!
! DESCRIPTION :  User may define settings to CVODES in this routine
!
!
! ARGUMENTS   : NTOTAL,NBASE,NSENSE,IPAR,RPAR
!               IN     - NTOTAL
!               OUT    - NONE
!               IN OUT - NBASE,NSENSE,IPAR,RPAR
!
! CALLED BY   : CVODENM
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf), v2.6.2 to change settings
!
! MODULES USED: PRCVODE,CVIDAROOT,PRSIZES,NMPRD_INT,PRCOM_INT
!
! CONTAINS    : NONE
!
! LOCALS      : ALLOC_FLAG,IFIRST,NCORE
!
!---------------------------- END OF HEADER -----------------------------------------
!
      SUBROUTINE FCVINIT(NTOTAL,NBASE,NSENSE,IPAR,RPAR)
!
      USE PRCVODE,      ONLY: IFCVEWT,IFCSOLVE,IFCVJAC,IFCVJTIMES,IFCVPRETYPE,FCVMU, &
                              FCVML,IFCVMAXL,FCVDELT,IFCVGSTYPE,FCVNNZ,FCVORDERING
!
      USE CVIDAROOT,    ONLY: NRTFN,NRTCT,RTINFO,RTSIGNAL,TRTINFO,YRTINFO,YPRTINFO,  &
                              GRTINFO
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
! INTEGER
      USE NMPRD_INT,    ONLY: IFIRSTEMJAC
      USE PRCOM_INT,    ONLY: METH
!
!IN-NTOTAL
!inout-NBASE,NSENSE,IPAR,RPAR
! Consult chapter 5 of CVODE 2.8.2, of Sundials manual, v2.6.2 to change settings

      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE), INTENT(IN) :: NTOTAL
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

! METH=1: ADAMS NONSTIFF
! METH=2: BDF, STIFF
! BY DEFAULT, METH=-1, WHICH IS INTERPRETED AS METH=2.  You can set METH in $PK, but better to set it here.

      NCORE=NBASE
! COMMENT OUT THE NEXT TWO LINES IF YOU WANT CVODES TO CARRY OUT SENSITIVITY EQUATION MANIPULATIONS
! When NRTFN>0, you may need to uncomment the next two lines if not working properly, for ITS/FOCE/LAPLACE
!      NBASE=NTOTAL
!      NSENSE=0

! User Should Initialize Based On Desired Settings
      IPAR(1)=NBASE ! NUMBER OF TOTAL USER EQUATIONS (DES + AES)
      IPAR(2)=NSENSE ! NUMBER OF PARAMETERS TO BE OPTIMIZED (OR NUMBER OF SENSITIVITY ITEMS)
      IPAR(3)=NTOTAL ! NTOTAL=(NSENSE+1)*NBASE, TOTAL NUMBER OF EQUATIONS IN PROBLEM

! If set to 1, provide routine FCVEWT algorithm to provide error weights used in WRMS norm evaluations.
      IFCVEWT=0

! IFCSOLVE:
!         =1 FOR CVODE DIAG SOLVER
!         =2 FOR CVODE DENSE SOLVER
!         =3 FOR LAPACK-DENSE SOLVER
!         =4 FOR CVODE DIRECT BAND SOLVER
!         =5 FOR LAPACK BAND SOLVER
!6: SPGMR treatment
!7: SPBCG treatment
!8: SPTFQMR treatment
!9: KLU sparse treatment
!10: Super LUMT sparse treatment
      IFCSOLVE=2


! band treatment values (FOR IFCSOLVE=9, 10)
      FCVMU=MAX(NBASE-2,1)
      FCVML=MAX(NBASE-2,1)
! Ordering for IFCSOLVE=9,10: 0=AMD, 1=COLAMD
      FCVORDERING=0
      FCVNNZ=NBASE*NBASE


! jacobian type IFCVJAC
!0: no user Jacobian
!1: user Jacobian (set to 1 only if IFIRSTEMJAC=1
      IFCVJAC=0
      IF(IFIRSTEMJAC>0) IFCVJAC=1
!     IFIRSTEMJAC IS 1 IF IFIRSTEM=1 IN $PK.  THIS MAY OCCUR IF CLASSICAL FO/FOCE/LAPLACE, ESTIMATION IS DONE, OR
!     IF USER IMPOSES IT AS THE FIRST LINE IN $PK:
!     $PK
!     IFIRSTEM=1
! OR
!     $PK
!     "IFIRSTEM=1

! set IFCVJTIMES=1 to implent user supplied FCVJTIMES  routine. Also must set IFCVJAC to 1
      IFCVJTIMES=0


! arguments to treatment ifcsolve= 6-8

!IFCVPRETYPE:
!|0|: NO PRECONDITIONING
!|1|: left only
!|2|: right only
![3]: both sides
! if (IFCVPRETYPE<0), then preconditioner supplied as CVBANDPRE

      IFCVPRETYPE=0
      IFCVGSTYPE=1
      IFCVMAXL=0
      FCVDELT=0.0D+00



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
        ALLOCATE(YPRTINFO(NCORE+1,NRTCT))
        ALLOCATE(TRTINFO(NRTCT))
! ALLOCATE GRTINFO TO DIMENSION NECESSARY FOR PASSING PARAMETER INFORMATION TO FCVROOTFN/FIDAROOTFN
        ALLOCATE(GRTINFO(50))
        ALLOC_FLAG=1
      ENDIF

 999  RETURN
      END SUBROUTINE FCVINIT
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!----------------------------------- FCVEWT.F90 -------------------------------------
!
! SUBROUTINE FCVEWT(Y,EWT,IPAR,RPAR,IER)
!
! DESCRIPTION : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
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
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FCVEWT(Y, EWT, IPAR, RPAR, IER)
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
!
!NOINOUT-Y, EWT, IPAR, RPAR, IER
!SET IFCVEWT TO 1 IF YOU WANT THIS ROUTINE TO BE USED.
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
      END SUBROUTINE FCVEWT
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!----------------------------------- FCVDJAC.F90 ------------------------------------
!
! SUBROUTINE FCVDJAC(NEQ,T,Y,FY,DJAC,H,IPAR,RPAR,WK1,WK2,WK3,IER)
!
! DESCRIPTION : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
!
! ARGUMENTS   : NEQ,T,Y,FY,DJAC,H,IPAR,RPAR,WK1,WK2,WK3,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : JAC
!
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
! MODULES USED: PRSIZES,PR_INTERFACE
!
! CONTAINS    : NONE
!
! LOCALS      : I,J,SWAP
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FCVDJAC(NEQ, T, Y, FY,DJAC,H,IPAR,RPAR,WK1,WK2,WK3,IER)
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
! INTERFACE
      USE PR_INTERFACE, ONLY: JAC
!
!NOINOUT-NEQ, T, Y, FY,DJAC,H,IPAR,RPAR,WK1,WK2,WK3,IER
! When using Dense solver, IFCSOLVE=2-3), and IFCVJAC=1, user must supply dense JAcobian evaluator
      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE) :: NEQ,IER,IPAR(*)
      REAL(KIND=DPSIZE)   :: T,Y(*),FY(*),DJAC(NEQ,*),RPAR(NEQ,*),WK1(*),WK2(*),     &
                             WK3(*),H
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
      INTEGER(KIND=ISIZE) :: I,J
      REAL(KIND=DPSIZE)   :: SWAP
!
!      write(*,*) 'user jac'
      CALL JAC(NEQ,DJAC,NEQ)
      DO I=1,NEQ
        DO J=1,NEQ
          RPAR(I,J)=DJAC(I,J)
        ENDDO
      ENDDO
      IER=0
 999  RETURN
      END SUBROUTINE FCVDJAC
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!----------------------------------- FCVBJAC.F90 ------------------------------------
!
! SUBROUTINE FCVBJAC(NEQ,MU,ML,MDIM,T,Y,FY,BJAC,H,IPAR,RPAR,WK1,WK2,WK3,IER)
!
! DESCRIPTION : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
!
! ARGUMENTS   : NEQ,MU,ML,MDIM,T,Y,FY,BJAC,H,IPAR,RPAR,WK1,WK2,WK3,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : JAC
!
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
! MODULES USED: PRSIZES,PR_INTERFACE
!
! CONTAINS    : NONE
!
! LOCALS      : I,J,K
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FCVBJAC(NEQ, MU, ML, MDIM, T, Y, FY, BJAC,H,IPAR,RPAR,WK1,WK2,WK3,IER)
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
! INTERFACE
      USE PR_INTERFACE, ONLY: JAC
!
!NOINOUT-NEQ, MU, ML, MDIM, T, Y, FY, BJAC,H,IPAR,RPAR,WK1,WK2,WK3,IER
! if IFCSOLVE=4-5, and IFCVJAC=1, user must suply FCVBJAC
      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE) :: NEQ,IER,MU,ML,MDIM,IPAR(*)
      REAL(KIND=DPSIZE)   :: T,Y(*),FY(*),BJAC(MDIM,*),RPAR(NEQ,*),WK1(*),WK2(*),    &
                             WK3(*),H
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
      END SUBROUTINE FCVBJAC
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!---------------------------------- FCVSPJAC.F90 ------------------------------------
!
! SUBROUTINE FCVSPJAC(T,Y,FY,N,NNZ,JDATA,JRVALS,JCPTRS,H,IPAR,RPAR,WK1,WK2,WK3,IER)
!
! DESCRIPTION : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
!
! ARGUMENTS   : T,Y,FY,N,NNZ,JDATA,JRVALS,JCPTRS,H,IPAR,RPAR,WK1,WK2,WK3,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FCVSPJAC(T, Y, FY, N, NNZ, JDATA, JRVALS, JCPTRS, H, IPAR, RPAR, &
        WK1, WK2, WK3, IER)
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
!
!NOINOUT-T, Y, FY, N, NNZ, JDATA, JRVALS, JCPTRS, H, IPAR, RPAR, WK1, WK2, WK3, IER
! Used if IFCSOLVE=9-10
      IMPLICIT NONE
!
      REAL(KIND=DPSIZE)   :: T,Y(*),FY(*),RPAR(*),WK1(*),WK2(*),WK3(*),H
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
      END SUBROUTINE FCVSPJAC
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!---------------------------------- FCVJTIMES.F90 -----------------------------------
!
! SUBROUTINE FCVJTIMES(V,FJV,T,Y,FY,H,IPAR,RPAR,WORK,IER)
!
! DESCRIPTION : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
!
! ARGUMENTS   : V,FJV,T,Y,FY,H,IPAR,RPAR,WORK,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : JAC
!
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : DVAL,I,J,NEQ
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FCVJTIMES(V, FJV, T, Y, FY, H, IPAR, RPAR, WORK, IER)
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
!
!NOINOUT-V, FJV, T, Y, FY, H, IPAR, RPAR, WORK, IER
! Used if IFCVJTIMES=1, IFCVJAC=1, and IFCSOLVE=6-8
      IMPLICIT NONE
!
      REAL(KIND=DPSIZE)   :: V(*),FJV(*),Y(*),FY(*),RPAR(*),WORK(*),H,T
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
      END SUBROUTINE FCVJTIMES
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!----------------------------------- FCVPSOL.F90 ------------------------------------
!
! SUBROUTINE FCVPSOL(T,Y,FY,R,Z,GAMMA,DELTA,LR,IPAR,RPAR,WORK,IER)
!
! DESCRIPTION : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
!
! ARGUMENTS   : T,Y,FY,R,Z,GAMMA,DELTA,LR,IPAR,RPAR,WORK,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FCVPSOL(T, Y, FY, R, Z, GAMMA, DELTA, LR, IPAR, RPAR, &
        WORK, IER)
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
!
!NOINOUT-T, Y, FY, R, Z, GAMMA, DELTA, LR, IPAR, RPAR, WORK, IER
! Used if IFCSOLVE=6-8, IFCVJAC=1, and IFCVPRETYPE>0
      IMPLICIT NONE
!
      REAL(KIND=DPSIZE)   :: T,Y(*),FY(*),R(*),Z(*),RPAR(*),WORK(*),GAMMA,DELTA
      INTEGER(KIND=ISIZE) :: LR,IER,IPAR(*)
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
      IER=0
 999  RETURN
      END SUBROUTINE FCVPSOL
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!----------------------------------- FCVPSET.F90 ------------------------------------
!
! SUBROUTINE FCVPSET(T,Y,FY,JOK,JCUR,GAMMA,H,IPAR,RPAR,WORK1,WORK2,WORK3,IER)
!
! DESCRIPTION : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
!
! ARGUMENTS   : T,Y,FY,JOK,JCUR,GAMMA,H,IPAR,RPAR,WORK1,WORK2,WORK3,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FCVPSET(T, Y, FY, JOK, JCUR, GAMMA, H, IPAR, RPAR, WORK1, WORK2, &
        WORK3, IER)
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
!
!
!NOINOUT-T, Y, FY, JOK, JCUR, GAMMA, H, IPAR, RPAR, WORK1, WORK2,WORK3, IER
! May be Used if IFCSOLVE=6-8, IFCVJAC=1, and IFCVPRETYPE>0, and if user's preconditioner requires  Jacobian related data
! be evaluated or preprocessed
      IMPLICIT NONE
!
      REAL(KIND=DPSIZE)   :: T,Y(*),FY(*),GAMMA,H,WORK1(*),WORK2(*),WORK3(*),RPAR(*)
      INTEGER(KIND=ISIZE) :: JOK,JCUR,IPAR(*),IER
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
      IER=0
 999  RETURN
      END SUBROUTINE FCVPSET
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!------------------------------- FCVLAPACKDENSE2.F90 --------------------------------
!
! SUBROUTINE FCVLAPACKDENSE2(NEQ,IER)
!
! DESCRIPTION : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
!
! ARGUMENTS   : NEQ,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : CVODENM
!
! CALLS       : FCVLAPACKDENSE
!
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
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
      SUBROUTINE FCVLAPACKDENSE2(NEQ,IER)
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
      CALL FCVLAPACKDENSE(NEQ,IER)
 999  RETURN
      END SUBROUTINE FCVLAPACKDENSE2
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!------------------------------- FCVLAPACKBAND2.F90 ---------------------------------
!
! SUBROUTINE FCVLAPACKBAND2(NEQ,FCVMU,FCVML,IER)
!
! DESCRIPTION : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
!
! ARGUMENTS   : NEQ,FCVMU,FCVML,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : CVODENM
!
! CALLS       : FCVLAPACKBAND
!
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!


      SUBROUTINE FCVLAPACKBAND2(NEQ,FCVMU,FCVML,IER)
!
      USE PRSIZES,      ONLY: ISIZE
!
!
!NOINOUT-NEQ,FCVMU,FCVML,IER
      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE) :: NEQ,FCVMU,FCVML,IER
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
      CALL FCVLAPACKBAND(NEQ,FCVMU,FCVML,IER)
 999  RETURN
      END SUBROUTINE FCVLAPACKBAND2
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!---------------------------- FCVLAPACKDENSESETJAC2.F90 -----------------------------
!
! SUBROUTINE FCVLAPACKDENSESETJAC2(IFLAG,IER)
!
! DESCRIPTION : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
!
! ARGUMENTS   : IFLAG,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : CVODENM
!
! CALLS       : FCVLAPACKDENSESETJAC
!
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FCVLAPACKDENSESETJAC2(IFLAG,IER)
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
      CALL FCVLAPACKDENSESETJAC(IFLAG,IER)
 999  RETURN
      END SUBROUTINE FCVLAPACKDENSESETJAC2
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!---------------------------- FCVLAPACKBANDSETJAC2.F90 ------------------------------
!
! SUBROUTINE FCVLAPACKBANDSETJAC2(IFLAG,IER)
!
! DESCRIPTION : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
!
! ARGUMENTS   : IFLAG,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : CVODENM
!
! CALLS       : FCVLAPACKBANDSETJAC
!
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FCVLAPACKBANDSETJAC2(IFLAG,IER)
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
      CALL FCVLAPACKBANDSETJAC(IFLAG,IER)
 999  RETURN
      END SUBROUTINE FCVLAPACKBANDSETJAC2
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!----------------------------------- FCVKLU2.F90 ------------------------------------
!
! SUBROUTINE FCVKLU2(NEQ,FCVNNZ,FCVORDERING,IER)
!
! DESCRIPTION : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
!
! ARGUMENTS   : NEQ,FCVNNZ,FCVORDERING,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : CVODENM
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!

      SUBROUTINE FCVKLU2(NEQ,FCVNNZ,FCVORDERING,IER)
!
      USE PRSIZES,      ONLY: ISIZE
!
!
!NOINOUT-NEQ,FCVNNZ,FCVORDERING,IER
! KLU sparse routines not presently included in cvode.a or cvode.lib of NONMEM
      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE) :: NEQ,FCVNNZ,FCVORDERING,IER
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
!            CALL FCVKLU(NEQ,FCVNNZ,FCVORDERING,IER)
 999  RETURN
      END SUBROUTINE FCVKLU2
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!-------------------------------- FCVSUPERLUMT2.F90 ---------------------------------
!
! SUBROUTINE FCVSUPERLUMT2(NEQ,FCVNNZ,FCVORDERING,IER)
!
! DESCRIPTION : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
!
! ARGUMENTS   : NEQ,FCVNNZ,FCVORDERING,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : CVODENM
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
! MODULES USED: PRSIZES
!
! CONTAINS    : NONE
!
! LOCALS      : NONE
!
!---------------------------- END OF HEADER -----------------------------------------
!


      SUBROUTINE FCVSUPERLUMT2(NEQ,FCVNNZ,FCVORDERING,IER)
!
      USE PRSIZES,      ONLY: ISIZE
!
!
!NOINOUT-NEQ,FCVNNZ,FCVORDERING,IER
! SUPER LUMT sparse routines not presently included in cvode.a or cvode.lib of NONMEM
      IMPLICIT NONE
!
      INTEGER(KIND=ISIZE) :: NEQ,FCVNNZ,FCVORDERING,IER
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
!      CALL FCVSUPERLUMT(NEQ,FCVNNZ,FCVORDERING,IER)
 999  RETURN
      END SUBROUTINE FCVSUPERLUMT2
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : AUG/2016
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : NOV/2016 - INTRODUCED HEADER INFORMATIONS AND RESTRUCTURED AS PER
!                          THE NONMEM STANDARDS
!
!---------------------------------- FCVROOTFN.F90 -----------------------------------
!
! SUBROUTINE FCVROOTFN(T,Y,G,IPAR,RPAR,IER)
!
! DESCRIPTION : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
!
!
! ARGUMENTS   : T,Y,G,IPAR,RPAR,IER
!               IN     - NONE
!               OUT    - NONE
!               IN OUT - NONE
!
! CALLED BY   : NONE
!
! CALLS       : NONE
!
! ALGORITHM   : Consult chapter 5 of CVODE 2.8.2, of Sundials manual (cv_guide.pdf)
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
      SUBROUTINE FCVROOTFN(T, Y, G, IPAR, RPAR, IER)
!
      USE CVIDAROOT,    ONLY: NRTFN,NRTCT,RTINFO,RTSIGNAL,TRTINFO,YRTINFO,YPRTINFO,  &
                              GRTINFO
!
      USE PRSIZES,      ONLY: ISIZE,DPSIZE
      IMPLICIT NONE
!
!
!NOINOUT-T, Y, G, IPAR, RPAR, IER
! T=TIME, G()=ARRAY OF FUNCTIONS OF TIME AND STATES Y(*): THERE ARE NRTFN OF THE G() ARRAY
! RPAR IS A LARGE ARRAY, CAN BE USED FOR TEMPORARY USAGE IN VARIOUS PLACES.
      REAL(KIND=DPSIZE)   :: T,G(*),Y(*),RPAR(*)
      INTEGER(KIND=ISIZE) :: IPAR(*),IER
      
!
!
!------------------------------------------------------------------------------------
!
! Local Variables
!
!
! IER=0 MEANS SUCCESSFUL
! ENTER SPECIFIC CODE HERE
! THIS ROOT-FINDER EXAMPLE CAN FIND THE EXACT TMAX AND CMAX, BY FINDING WHEN DADT(2) IS ZERO
! NOTE THAT CALLING FCN1() CALLS DES, PLUS ADDS ANY INFUSION INPUTS.  SO, RPAR() CONTAINS
! FULL DADT() VALUES, AND WHEN G(1) (THAT IS, RPAR(2)=DADT(2)) CROSSES ZERO, IS WHEN CMAX OCCURS.
      CALL FCN1(Y,RPAR,IPAR(1),T)
      G(1)=RPAR(2)
!      G(1)= (GRTINFO(1)*Y(1)-GRTINFO(2)*Y(2))/GRTINFO(3)
      IER=0
 999  RETURN
      END SUBROUTINE FCVROOTFN
