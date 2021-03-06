!--------------------------------------------------------------------------------------------------!
!  DFTB+: general package for performing fast atomistic simulations                                !
!  Copyright (C) 2018  DFTB+ developers group                                                      !
!                                                                                                  !
!  See the LICENSE file for terms of usage and distribution.                                       !
!--------------------------------------------------------------------------------------------------!

#:include 'common.fypp'

!> Simple mixer for mixing charges
module simplemixer
  use assert
  use accuracy
  implicit none

  private


  !> Contains data for a simple mixer
  type OSimpleMixer
    private

    !> Mixing parameter
    real(dp) :: mixParam
  end type OSimpleMixer


  !> Creates a SimpleMixer instance
  interface init
    module procedure SimpleMixer_init
  end interface


  !> Resets a SimpleMixer
  interface reset
    module procedure SimpleMixer_reset
  end interface


  !> Does the simple mixing
  interface mix
    module procedure SimpleMixer_mix
  end interface

  public :: OSimpleMixer
  public :: init, reset, mix

contains


  !> Creates a simple mixer
  subroutine SimpleMixer_init(self, mixParam)

    !> Simple mixer instance on exit
    type(OSimpleMixer), intent(out) :: self

    !> Mixing parameter
    real(dp), intent(in) :: mixParam

    self%mixParam = mixParam

  end subroutine SimpleMixer_init


  !> Resets the mixer
  subroutine SimpleMixer_reset(self, nElem)

    !> Simple mixer instance
    type(OSimpleMixer), intent(inout) :: self

    !> Length of the vectors to mix
    integer, intent(in) :: nElem

    @:ASSERT(nElem > 0)

    continue

  end subroutine SimpleMixer_reset


  !> Does the actual mixing
  subroutine SimpleMixer_mix(self, qInpResult, qDiff)

    !> SimpleMixer instance
    type(OSimpleMixer), intent(inout) :: self

    !> Input charge on entry, mixed charge on exit
    real(dp), intent(inout) :: qInpResult(:)

    !> Charge difference
    real(dp), intent(in) :: qDiff(:)

    @:ASSERT(size(qInpResult) == size(qDiff))

    qInpResult(:) = qInpResult(:) + self%mixParam * qDiff(:)

  end subroutine SimpleMixer_mix

end module simplemixer
