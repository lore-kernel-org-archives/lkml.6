Date: Mon, 5 Mar 2018 13:49:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.120
Message-ID: <20180305124943.GA17081@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.120 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                         |    2=20
 arch/arm/boot/dts/ls1021a-qds.dts                |    2=20
 arch/arm/boot/dts/ls1021a-twr.dts                |    2=20
 arch/arm/lib/csumpartialcopyuser.S               |    4 +
 arch/mips/lib/Makefile                           |    3 -
 arch/mips/lib/libgcc.h                           |   17 +++++++
 arch/mips/lib/multi3.c                           |   54 ++++++++++++++++++=
+++++
 arch/sh/boards/mach-se/770x/setup.c              |   10 +++-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c   |    7 ++
 drivers/gpu/drm/ttm/ttm_page_alloc.c             |    2=20
 drivers/infiniband/hw/mlx4/mr.c                  |    2=20
 drivers/infiniband/ulp/ipoib/ipoib_main.c        |   25 +++++++---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c   |    5 +-
 drivers/leds/led-core.c                          |    2=20
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c           |    6 +-
 drivers/net/can/flexcan.c                        |    2=20
 drivers/net/ethernet/arc/emac_main.c             |   53 +++++++++++++-----=
----
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c  |    4 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c |   14 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c  |    2=20
 drivers/net/ethernet/broadcom/tg3.c              |   13 +++++
 drivers/net/ethernet/broadcom/tg3.h              |    4 +
 drivers/net/ethernet/freescale/gianfar_ptp.c     |    3 -
 drivers/net/ethernet/intel/e1000/e1000.h         |    3 -
 drivers/net/ethernet/intel/e1000/e1000_main.c    |   27 +++++++++--
 drivers/net/phy/mdio-sun4i.c                     |    6 +-
 drivers/net/xen-netfront.c                       |    1=20
 drivers/s390/block/dasd_3990_erp.c               |   10 ++++
 drivers/scsi/storvsc_drv.c                       |    3 -
 drivers/spi/spi-atmel.c                          |    2=20
 drivers/xen/gntdev.c                             |    8 +--
 fs/f2fs/extent_cache.c                           |   10 +++-
 fs/super.c                                       |    6 ++
 fs/xfs/xfs_qm.c                                  |   46 ++++++++++++-------
 kernel/time/hrtimer.c                            |    7 ++
 lib/mpi/longlong.h                               |   18 +++++++
 net/ipv6/route.c                                 |    1=20
 net/mac80211/rx.c                                |    2=20
 net/sctp/socket.c                                |   16 ++++--
 39 files changed, 315 insertions(+), 89 deletions(-)

Al Viro (1):
      sget(): handle failures of register_shrinker()

Alexander Kochetkov (1):
      net: arc_emac: fix arc_emac_rx() error paths

Aliaksei Karaliou (2):
      xfs: quota: fix missed destroy of qi_tree_lock
      xfs: quota: check result of register_shrinker()

Anna-Maria Gleixner (1):
      hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)

Arnd Bergmann (1):
      ARM: dts: ls1021a: fix incorrect clock references

Brendan McGrath (1):
      ipv6: icmp6: Allow icmp messages to be looped back

Cathy Avery (1):
      scsi: storvsc: Fix scsi_cmd error assignments in storvsc_handle_error

Christophe JAILLET (1):
      mdio-sun4i: Fix a memory leak

Chunyan Zhang (1):
      ARM: 8731/1: Fix csum_partial_copy_from_user() stack mismatch

Eduardo Otubo (1):
      xen-netfront: enable device after manual module load

Erez Shitrit (1):
      IB/ipoib: Fix race condition in neigh creation

Greg Kroah-Hartman (1):
      Linux 4.4.120

Guilherme G. Piccoli (1):
      bnx2x: Improve reliability in case of nested PCI errors

James Hogan (2):
      lib/mpi: Fix umul_ppmm() for MIPS64r6
      MIPS: Implement __multi3 for GCC7 MIPS64r6 builds

Johannes Berg (1):
      mac80211: mesh: drop frames appearing to be from us

Karol Herbst (1):
      drm/nouveau/pci: do a msi rearm on init

Leon Romanovsky (1):
      IB/mlx4: Fix mlx4_ib_alloc_mr error flow

Luu An Phu (1):
      can: flex_can: Correct the checking for frame length in flexcan_start=
_xmit()

Marcelo Ricardo Leitner (1):
      sctp: make use of pre-calculated len

Matthieu CASTET (1):
      led: core: Fix brightness setting when setting delay_off=3D0

Radu Pirea (1):
      spi: atmel: fixed spin_lock usage inside atmel_spi_remove

Ross Lagerwall (2):
      xen/gntdev: Fix off-by-one error when unmapping with holes
      xen/gntdev: Fix partial gntdev_mmap() cleanup

Sascha Hauer (1):
      mtd: nand: gpmi: Fix failure when a erased page has a bitflip at BBM

Sergei Shtylyov (1):
      SolutionEngine771x: fix Ether platform data

Siva Reddy Kallam (2):
      tg3: Add workaround to restrict 5762 MRRS to 2048
      tg3: Enable PHY reset in MTU change path for 5720

Stefan Haberland (1):
      s390/dasd: fix wrongly assigned configuration data

Tushar Dave (1):
      e1000: fix disabling already-disabled warning

Venkat Duvvuru (1):
      bnxt_en: Fix the 'Invalid VF' id check in bnxt_vf_ndo_prep routine.

Xiongwei Song (1):
      drm/ttm: check the return value of kzalloc

Yangbo Lu (1):
      net: gianfar_ptp: move set_fipers() to spinlock protecting area

Yunlei He (1):
      f2fs: fix a bug caused by NULL extent tree


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqdPOYACgkQONu9yGCS
aT7G3A//ayKTWic+9BYP4xygKPcqN8djaaNsGA7CwM5eZCVsbjLEk4jwaX9ZQVa2
YCIQXrUS5HnQZA5FjuuYHyZnqo/KiXupnYHiopdtqHiJURLNINq4YlHFBLUHBRNJ
a1wKK2oQ2+c/Au+aZ+ijJ+/lN5GSWi2/VE4rN2ISeuddZbg8CwJhMWmvYHOmehmi
XkgXqeHm+bgRuDHRq6rv7QazhTXMAFzNM6sm1WNBg/pVW9h0C9nVk6xDHtqRzzNG
mx94/6t+IZqNySbN7prPD0eUJPSIV/HdGwFhPHnIoXVZMb9TGIvvFbnF0ubnbYoQ
vdEPSGQRF5McJ7gEZkQxyRYYTyaql7R2+DKKoLq/PiLx85Md7Z9lvQrZHn+CXbGT
ErJgO03l+WLEdfjJHRTk8Z2Q1rePGRzeo+BePtOeHPfLmVeMi7sSjDE+e11YTNck
nwqLXugbykO66V+ZA1Dt5JIxOnpTWFeVdyFQhFdYBthkvrA5GOpHQJugDlZlYxk0
2do7WjCUknMDCkU+WzlcOAr/usvXCcCr5XLSSNR9CQpdcU13nZgTPNG5UOUXpZBK
8237agYv6U/gHuoXqU4DCHVAE29e+iWtONkTo5D/Q63hU1CbQ7eImHtD9b583Vy7
XpJCkaYyx33/NgPjWhugqKQd8uuoxlYDKUMU9TXlpiTsg0212vI=
=7I+2
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
