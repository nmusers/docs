!*********************************COPYRIGHT******************************************
!                                                                                   !
!       THE NONMEM SYSTEM MAY BE DISTRIBUTED ONLY BY ICON DEVELOPMENT               !
!       SOLUTIONS.                                                                  !
!                                                                                   !
!       COPYRIGHT BY ICON DEVELOPMENT SOLUTIONS                                     !
!       2009-2020 ALL RIGHTS RESERVED.                                              !
!                                                                                   !
!************************************************************************************
!
!-----------------------------HISTORY------------------------------------------------
! VERSION     : NONMEM VII
! AUTHOR      : ROBERT J. BAUER
! CREATED ON  : MAR/2023
! LANGUAGE    : FORTRAN 90/95
! LAST UPDATE : MAR/2023 - nm752, #9.  WFIMS is a User defined routine for applying weights
!                          to different parts of the FIM.  Good for robust design, for OFVTYPE=0,1,6,8.  
!
!------------------------------------ PFIM.F90 --------------------------------------
!
! SUBROUTINE WFIMS(FIMDIM)
!
! DESCRIPTION : Allow User to Define weight on Fisher Information Matrix for Robust Optimal Design
!
!
! ARGUMENTS   : FIMDIM
!               IN     - FIMDIM
!
! CALLED BY   : PFIM
!
! CALLS       : NONE
!
! ALGORITHM   : Set WFIM values
!
! MODULES USED: SIZES,FSIZES,NMBAYES_INT,CMNM3_INT,CMNM1_INT,NMPRD_INT,CMNM2_INT,
!               NMBAYES_REAL,NMPRD_REAL,CMNM7_REAL,CMNM3_REAL,ROCM_REAL
!
! CONTAINS    : NONE
!
!
!---------------------------- END OF HEADER -----------------------------------------
!
      SUBROUTINE WFIMS(FIMDIM)
      
      USE SIZES,        ONLY: ISIZE,DPSIZE
      USE CMNM2_INT,    ONLY: OFVTYPE
      USE NMPRD_INT,    ONLY: NTHETA,NETA,NEPS,NOEPS,ETA_INDEX
      USE CMNM2_REAL,   ONLY: WFIM


      IMPLICIT NONE
      INTEGER(KIND=ISIZE), INTENT(IN) :: FIMDIM
      INTEGER(KIND=ISIZE) :: I,J,K,NUM_MODELS
      REAL(KIND=DPSIZE)  :: DVAL,DVAL2,DVAL3,MODWEIGHT(100),SUMWT,WT(100)

!   For Robust design, set WFIM(I,J) to some weight value, where:
!   I=0:  Theta
!   I=1:  Omega
!   I=2: Sigma
!   J=index to parameter: THETA(j), OMEGA(J,J), SIGMA(J,J)
!   Then the LOG(DET(FIM)) component pertaining to that parameter is multiplied by the appropraite WFIM
!   The entire dimension of the FIM is FIMDIM, in case it is needed in the assessment
!   If OFVTYPE=8, then use I=0, and J=index to parameter eta(J)

! An example below of how to use WFIMS.  This example is for robust5.ctl
! Uncomment the various code lines and modify values in accordance to need.
! At first stage, WT() are all equal, as it is unknown what model is best fitting to real data (or simulated data in a mock process).
! When real data is fitted to various models, weights to next stage should be in proportion to goodness of fit equation (9) of 
! Fayette, Mentre, and Seurat. Robust and adaptive two-stage designs in nonlinear mixed ffect models, AAPS journal, 2023:
! wt(m)=exp(-AIC_previous_stage(m)/2)
! where m=model number

      NUM_MODELS=4
      WT(1)=0.01742d+00
      WT(2)=0.2019D+00
      WT(3)=21.1d+00
      WT(4)=13.12d+00

      SUMWT=0.0D+00
      DO I=1,NUM_MODELS
      SUMWT=SUMWT+WT(I)
      ENDDO

! Always Multiply back the Total dimension FIMDIM.  To follow Fayette exactly, set $DESIGN ... OFVDIMSCALED=1 in control stream
! The final result is not impacted, there is just a different scaling of the LOG(DET((FIM)) OFV.
      DVAL=FIMDIM/SUMWT
!      
! According to equation (5) of Fayette, Various parts of FIM should also be weighted according to
! 1/P(m), where P(m)=dimension (number of estimated parameters) to a given model block in the FIM. 
!  Model 1: thetas 1-4, omegas 1-4, sigma(1),=9 model parameters.
      MODWEIGHT(1)=DVAL*WT(1)/9.0D+00
      WFIM(0,1:4)=MODWEIGHT(1)
      WFIM(1,1:4)=MODWEIGHT(1)
      WFIM(2,1)=MODWEIGHT(1)
!  Model 2: thetas 5-8, omegas 5-8, sigma(2),=9 model parameters.
      MODWEIGHT(2)=DVAL*WT(2)/9.0D+00
      WFIM(0,5:8)=MODWEIGHT(2)
      WFIM(1,5:8)=MODWEIGHT(2)
      WFIM(2,2)=MODWEIGHT(2)
!  Model 3: thetas 9-13, omegas 9-13, sigma(3),=11 model parameters.
      MODWEIGHT(3)=DVAL*WT(3)/11.0D+00
      WFIM(0,9:13)=MODWEIGHT(3)
      WFIM(1,9:13)=MODWEIGHT(3)
      WFIM(2,3)=MODWEIGHT(3)
!  Model 4: thetas 14-18, omegas 14-18, sigma(4),=11 model parameters.
      MODWEIGHT(4)=DVAL*WT(4)/11.0D+00
      WFIM(0,14:18)=MODWEIGHT(4)
      WFIM(1,14:18)=MODWEIGHT(4)
      WFIM(2,4)=MODWEIGHT(4)

! To use the WFIMS routine, refer to it in the control stream as follows:
!  $SUBRTOUINES ... OTHER=WFIMS.f90

 999  CONTINUE
      RETURN
      END SUBROUTINE WFIMS
