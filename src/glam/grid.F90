module grid

  use units, only: m_to_km
  use ncutils, only: nc_open, nc_close, nc_get_int
  use box, only: box_type

  implicit none

  private

  type grid_type

     ! User settable grid parameters:
     integer :: nxaooc, nyaooc
     integer :: ndxr

     ! Derived grid parameters:
     integer :: nxtaor,nytaor,nxpaor,nypaor
     integer :: nxtoar,nytoar,nxpoar,nypoar
     integer :: nx1, ny1

     ! nxtaor, nytaor are the numbers of atmos. T points at ocean resolution
     ! nxpaor, nypaor are the numbers of atmos. p points at ocean resolution
     ! nxtoar, nytoar are the numbers of ocean T points at atmos. resolution
     ! nxpoar, nypoar are the numbers of ocean p points at atmos. resolution
     ! nx1, ny1 are starting indices for the ocean in the atmos. grid.
     ! We choose them to centre the ocean in the atmospheric domain (if possible).

  end type grid_type

  public grid_type
  public print_grid
  public load_grid

contains

  type(grid_type) function load_grid(go, ga)
    type(box_type), intent(in) :: go
    type(box_type), intent(in) :: ga

    load_grid%ndxr = nint(ga%dx/go%dx)

    load_grid%nxtaor = ga%nxt*load_grid%ndxr
    load_grid%nytaor = ga%nyt*load_grid%ndxr
    load_grid%nxpaor = load_grid%nxtaor + 1
    load_grid%nypaor = load_grid%nytaor + 1

    load_grid%nxtoar = go%nxt/load_grid%ndxr
    load_grid%nytoar = go%nyt/load_grid%ndxr
    load_grid%nxpoar = load_grid%nxtoar + 1
    load_grid%nypoar = load_grid%nytoar + 1

    load_grid%nxaooc = go%nxt/load_grid%ndxr
    load_grid%nyaooc = go%nyt/load_grid%ndxr

    load_grid%nx1 = 1
    load_grid%ny1 = 1 + (ga%nyt - load_grid%nyaooc)/2

  end function load_grid

  subroutine new_print_grid(g)
    type(grid_type), intent(in) :: g

    print *, "Coupling Grid Summary"
    print *, "Atmos/Ocean ratio (ndxr): ", g%ndxr
    print *, "# Atmos T. cells at ocean res (nxtaor,nytaor): ", g%nxtaor, g%nytaor
    print *, "# Atmos cells over ocean (nxaooc, nyaooc): ", g%nxaooc, g%nyaooc
    print *, "# Index on atmos T-grid of first ocean cell (nx1, ny1): ", g%nx1, g%ny1

  end subroutine new_print_grid

  subroutine print_grid(g, go, ga)

    type(grid_type), intent(in) :: g
    type(box_type), intent(in) :: go
    type(box_type), intent(in) :: ga

    integer :: k

    print *
    print *,' Grid parameters:'
    print *,' ----------------'
    print 201, '  Atmos/ocean grid ratio ndxr = ',g%ndxr
    print 201, '  Atmos. gridcells over ocean = ',g%nxaooc,g%nyaooc
    print 201, '  Ocn start indices  nx1, ny1 = ',g%nx1,g%ny1
    print 214, '  Coriolis par. f0 (rad s^-1) = ',go%fnot
    print 214, '  Beta =df/dy (rad s^-1 m^-1) = ',go%beta

    print *
    print *,' Oceanic grid:'
    print *,' -------------'
    print 201, '  No. of ocean QG layers  nlo = ', go%nl
    print 201, '  No. of gridcells nxto, nyto = ', go%nxt,go%nyt
    print 204, '  Gridlength dxo         (km) = ', m_to_km(go%dx)
    print 203, '  Domain sizes xlo, ylo  (km) = ', m_to_km(go%xl),m_to_km(go%yl)
    print 205, '  Rossby number   Beta*ylo/f0 = ', go%beta*go%yl/abs(go%fnot)
    print 214, '  f range S -> N   (rad s^-1) = ', go%fnot+go%beta*go%yprel(1),go%fnot+go%beta*go%yprel(go%nyp)
    print 214, '  Midlatitude Coriolis param  = ', go%fnot+go%beta*0.5d0*( go%yprel(1) + go%yprel(go%nyp) )
    print 203, '  Layer thicknesses hoc   (m) = ', (go%h(k),k=1,go%nl)
    print 203, '  Total thickness   hto   (m) = ', sum(go%h)

    print *
    print *,' Atmospheric grid:'
    print *,' -----------------'
    print 201, '  No. of atmos. QG layers nla = ', ga%nl
    print 201, '  No. of gridcells nxta, nyta = ', ga%nxt,ga%nyt
    print 204, '  Gridlength dxa         (km) = ', m_to_km(ga%dx)
    print 203, '  Domain sizes xla, yla  (km) = ', m_to_km(ga%xl),m_to_km(ga%yl)
    print 205, '  Rossby number   Beta*yla/f0 = ', go%beta*ga%yl/abs(ga%fnot)
    print 214, '  f range S -> N   (rad s^-1) = ', ga%fnot+ga%beta*ga%yprel(1),ga%fnot+go%beta*ga%yprel(ga%nyp)
    print 214, '  Midlatitude Coriolis param  = ', ga%fnot+ga%beta*0.5d0*( ga%yprel(1) + ga%yprel(ga%nyp) )
    print 203, '  Layer thicknesses hat   (m) = ', (ga%h(k),k=1,ga%nl)
    print 203, '  Total thickness   hta   (m) = ', sum(ga%h)

  201 format(a,9i13)
  203 format(a,9f13.3)
  204 format(a,9f13.4)
  205 format(a,9f13.5)
  214 format(a,1p,9d13.4)

  end subroutine print_grid

end module grid
