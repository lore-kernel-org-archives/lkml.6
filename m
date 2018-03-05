Date: Mon, 5 Mar 2018 13:49:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.98
Message-ID: <20180305124921.GA16961@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.98 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                         |    2=20
 arch/sh/boards/mach-se/770x/setup.c              |   10 +++-
 drivers/gpu/drm/ttm/ttm_page_alloc.c             |    2=20
 drivers/leds/led-core.c                          |    2=20
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c           |    6 +-
 drivers/net/ethernet/arc/emac_main.c             |   53 +++++++++++++-----=
-----
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c  |    4 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c |   14 +++++-
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
 fs/super.c                                       |    6 ++
 fs/xfs/xfs_qm.c                                  |   46 +++++++++++++------
 kernel/time/hrtimer.c                            |    7 ++-
 net/ipv6/ip6_output.c                            |   11 +---
 net/ipv6/route.c                                 |    1=20
 net/sctp/socket.c                                |   16 ++++--
 25 files changed, 179 insertions(+), 81 deletions(-)

Al Viro (1):
      sget(): handle failures of register_shrinker()

Alexander Kochetkov (1):
      net: arc_emac: fix arc_emac_rx() error paths

Aliaksei Karaliou (2):
      xfs: quota: fix missed destroy of qi_tree_lock
      xfs: quota: check result of register_shrinker()

Anna-Maria Gleixner (1):
      hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)

Brendan McGrath (1):
      ipv6: icmp6: Allow icmp messages to be looped back

Cathy Avery (1):
      scsi: storvsc: Fix scsi_cmd error assignments in storvsc_handle_error

Christophe JAILLET (1):
      mdio-sun4i: Fix a memory leak

Eduardo Otubo (1):
      xen-netfront: enable device after manual module load

Greg Kroah-Hartman (1):
      Linux 3.18.98

Guilherme G. Piccoli (1):
      bnx2x: Improve reliability in case of nested PCI errors

Jakub Sitnicki (1):
      ipv6: Skip XFRM lookup if dst_entry in socket cache is valid

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

Xiongwei Song (1):
      drm/ttm: check the return value of kzalloc

Yangbo Lu (1):
      net: gianfar_ptp: move set_fipers() to spinlock protecting area


--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqdPMsACgkQONu9yGCS
aT4MNRAAvnFYBPRtKaWGlg4nZyme0yuNdBkSHVI9roK36fLtaqZN/lZwGd65nRI7
0khkD6QyxYE0PN8dcbMVsGxvKNS+PZcrQWY0jHJTywpOxzc1kwEfb6Zu2YD1K3bw
/gZN5h6QoMha2LcRjlD8vOhZwWwq9zI7kUMzn+R1d4nvfxiNQy5P7O27kCjScgPU
LxGUJjgI1QgDpZ6RsiIET3wdEozoSYjaSH+UnO+jMYza6d9iFm8QKoGWX9ZOBiVm
qOvkfhTeibrMMf7J0Xtx+ZFIr9xMGplEDgd4en5t+lkd/VZE0uECK+A8yGsFLj8A
jF+Xo0aq1dGor1fdrBY9f8qmpPktgveKGHqm3zbJTAFQ980ceeI5ijkaGtA2nrwm
re2pqXnI4jNbT8JBs2HiUhh6wXAB5yp6B2qU5ZZIkrgkTF/YjVOZy/FPen0xc+ck
wKqC+wV26L54loJr/NMF9bd7GDBfWV6Yv39+4Gm0hZhRyQultYXKrVgvnHSQSDcQ
6QnBLbX7373XhcWYlPrOvd6fqdsx0fFyyJcNvXMc6XSxMcptGOeUGYJ/dXTW+i4/
x26yhXSQIP0hHnu6xZbiHAianvOiDcwQdDbO/VQrzVnoIXdEFl3SbkPxPE+NsDPq
3YOIa69dZ4K+t2o3j1iL9vkoPnsfWydq4kGEKVGkD2T+nvIXK7s=
=KDMH
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
