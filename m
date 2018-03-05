Date: Mon, 5 Mar 2018 13:50:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.24
Message-ID: <20180305125027.GA17253@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.24 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                            |    2=
=20
 arch/arm/boot/dts/ls1021a-qds.dts                                   |    2=
=20
 arch/arm/boot/dts/ls1021a-twr.dts                                   |    2=
=20
 arch/arm/lib/csumpartialcopyuser.S                                  |    4=
=20
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts                   |    9=
 +
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi                |   38=
 ++++
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi                 |   38=
 ++++
 arch/arm64/boot/dts/renesas/ulcb.dtsi                               |    1=
=20
 arch/ia64/kernel/time.c                                             |    2=
=20
 arch/mips/lib/Makefile                                              |    3=
=20
 arch/mips/lib/libgcc.h                                              |   17=
 ++
 arch/mips/lib/multi3.c                                              |   54=
 ++++++
 arch/parisc/include/asm/thread_info.h                               |    5=
=20
 arch/powerpc/platforms/pseries/dlpar.c                              |   21=
 ++
 arch/powerpc/platforms/pseries/pseries.h                            |    2=
=20
 arch/powerpc/platforms/pseries/ras.c                                |   30=
 ++-
 arch/sh/boards/mach-se/770x/setup.c                                 |   10=
 -
 arch/x86/events/intel/core.c                                        |    5=
=20
 arch/x86/include/asm/asm.h                                          |    2=
=20
 arch/x86/kernel/setup.c                                             |    5=
=20
 arch/x86/kernel/stacktrace.c                                        |    6=
=20
 arch/x86/platform/intel-mid/device_libs/platform_bt.c               |    2=
=20
 arch/x86/xen/enlighten.c                                            |   81=
 +++++++++
 arch/x86/xen/enlighten_pv.c                                         |    3=
=20
 arch/x86/xen/mmu_pv.c                                               |   12=
 +
 arch/x86/xen/setup.c                                                |    6=
=20
 block/blk-core.c                                                    |    9=
 -
 block/blk-mq.c                                                      |    2=
=20
 block/blk.h                                                         |    2=
=20
 crypto/af_alg.c                                                     |    4=
=20
 crypto/algif_aead.c                                                 |    2=
=20
 crypto/algif_skcipher.c                                             |    2=
=20
 drivers/crypto/inside-secure/safexcel.c                             |    1=
=20
 drivers/crypto/inside-secure/safexcel_cipher.c                      |   85=
 +++++++---
 drivers/crypto/inside-secure/safexcel_hash.c                        |   79=
 ++++++---
 drivers/dma/fsl-edma.c                                              |   28=
 +--
 drivers/gpu/drm/i915/intel_display.c                                |    2=
=20
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c                      |    7=
=20
 drivers/gpu/drm/ttm/ttm_page_alloc.c                                |    2=
=20
 drivers/infiniband/core/core_priv.h                                 |    2=
=20
 drivers/infiniband/core/device.c                                    |   18=
 ++
 drivers/infiniband/core/nldev.c                                     |   54=
 ++++--
 drivers/infiniband/hw/mlx4/mr.c                                     |    2=
=20
 drivers/infiniband/hw/mlx5/mr.c                                     |    1=
=20
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c                        |    7=
=20
 drivers/infiniband/ulp/ipoib/ipoib_main.c                           |   25=
 ++
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c                      |    5=
=20
 drivers/input/misc/xen-kbdfront.c                                   |    2=
=20
 drivers/leds/led-core.c                                             |    1=
=20
 drivers/mtd/nand/brcmnand/brcmnand.c                                |    2=
=20
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c                              |    6=
=20
 drivers/net/can/flexcan.c                                           |    2=
=20
 drivers/net/ethernet/amazon/ena/ena_netdev.c                        |   26=
 +--
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h                      |    4=
=20
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c                     |    7=
=20
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h                     |    2=
=20
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c                |    5=
=20
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c           |   13=
 +
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c           |   25=
 ++
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h |    6=
=20
 drivers/net/ethernet/arc/emac_main.c                                |   53=
 +++---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c                     |    4=
=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c                    |   14=
 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c                     |    2=
=20
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c                        |    2=
=20
 drivers/net/ethernet/broadcom/tg3.c                                 |   13=
 +
 drivers/net/ethernet/broadcom/tg3.h                                 |    4=
=20
 drivers/net/ethernet/freescale/gianfar_ptp.c                        |    3=
=20
 drivers/net/ethernet/intel/e1000/e1000.h                            |    3=
=20
 drivers/net/ethernet/intel/e1000/e1000_main.c                       |   27=
 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c                         |   17=
 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                         |   26=
 ++-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c                       |   26=
 ++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                         |   11=
 -
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c                  |   10=
 -
 drivers/net/ethernet/mellanox/mlx5/core/eq.c                        |   18=
 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c                           |    7=
=20
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h                        |    1=
=20
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c                 |    2=
=20
 drivers/net/ethernet/stmicro/stmmac/common.h                        |    2=
=20
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c                  |    5=
=20
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c                      |    3=
=20
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c                     |    2=
=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c               |    6=
=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                   |    2=
=20
 drivers/net/macvlan.c                                               |    7=
=20
 drivers/net/phy/mdio-sun4i.c                                        |    6=
=20
 drivers/net/phy/mdio-xgene.c                                        |   21=
 +-
 drivers/net/usb/qmi_wwan.c                                          |    2=
=20
 drivers/net/vxlan.c                                                 |   14=
 +
 drivers/net/wireless/ath/wcn36xx/main.c                             |   23=
 +-
 drivers/net/wireless/ath/wcn36xx/pmc.c                              |    6=
=20
 drivers/net/wireless/mac80211_hwsim.c                               |    2=
=20
 drivers/net/xen-netfront.c                                          |    1=
=20
 drivers/nvme/host/core.c                                            |    3=
=20
 drivers/nvme/host/fabrics.c                                         |    1=
=20
 drivers/nvme/host/fc.c                                              |    1=
=20
 drivers/of/of_mdio.c                                                |    9=
 -
 drivers/phy/motorola/phy-cpcap-usb.c                                |    2=
=20
 drivers/s390/block/dasd_3990_erp.c                                  |   10=
 +
 drivers/scsi/aacraid/aacraid.h                                      |    1=
=20
 drivers/scsi/aacraid/linit.c                                        |    2=
=20
 drivers/scsi/storvsc_drv.c                                          |    3=
=20
 drivers/spi/spi-atmel.c                                             |    2=
=20
 drivers/staging/android/ion/Kconfig                                 |    2=
=20
 drivers/staging/android/ion/ion_cma_heap.c                          |   15=
 +
 drivers/xen/balloon.c                                               |   65=
 ++++++-
 drivers/xen/gntdev.c                                                |    8=
=20
 fs/afs/write.c                                                      |    8=
=20
 fs/btrfs/volumes.c                                                  |    1=
=20
 fs/exec.c                                                           |    7=
=20
 fs/super.c                                                          |    6=
=20
 fs/xfs/xfs_qm.c                                                     |   46=
 +++--
 include/crypto/if_alg.h                                             |    5=
=20
 include/linux/mlx5/driver.h                                         |    2=
=20
 include/linux/sched.h                                               |    6=
=20
 include/net/sch_generic.h                                           |    1=
=20
 include/net/xfrm.h                                                  |    3=
=20
 include/uapi/linux/libc-compat.h                                    |   55=
 ++++++
 include/uapi/linux/netfilter/nf_conntrack_common.h                  |    2=
=20
 include/xen/balloon.h                                               |    5=
=20
 kernel/bpf/sockmap.c                                                |   11=
 +
 kernel/cgroup/cgroup-v1.c                                           |    6=
=20
 kernel/irq/debug.h                                                  |    5=
=20
 kernel/time/hrtimer.c                                               |    7=
=20
 lib/mpi/longlong.h                                                  |   18=
 ++
 mm/frame_vector.c                                                   |    6=
=20
 net/ipv4/ip_gre.c                                                   |    1=
=20
 net/ipv4/xfrm4_input.c                                              |   12=
 +
 net/ipv6/ip6_gre.c                                                  |    1=
=20
 net/ipv6/ip6_tunnel.c                                               |   15=
 +
 net/ipv6/route.c                                                    |    1=
=20
 net/ipv6/xfrm6_input.c                                              |   10=
 +
 net/mac80211/rx.c                                                   |    2=
=20
 net/netfilter/nf_tables_api.c                                       |    8=
=20
 net/sched/cls_api.c                                                 |   48=
 ++---
 net/sctp/socket.c                                                   |   26=
 ++-
 net/sctp/ulpqueue.c                                                 |   24=
 --
 net/tipc/bearer.c                                                   |    5=
=20
 net/tipc/monitor.c                                                  |    6=
=20
 net/wireless/nl80211.c                                              |    3=
=20
 net/xfrm/xfrm_input.c                                               |   57=
 ++++++
 sound/soc/codecs/nau8825.c                                          |    1=
=20
 sound/soc/sh/rcar/adg.c                                             |    6=
=20
 144 files changed, 1331 insertions(+), 366 deletions(-)

Abhijeet Kumar (1):
      ASoC: nau8825: fix issue that pop noise when start capture

Al Viro (1):
      sget(): handle failures of register_shrinker()

Albert Hsieh (1):
      mtd: nand: brcmnand: Zero bitflip is not an error

Alexander Duyck (1):
      i40e/i40evf: Account for frags split over multiple descriptors in che=
ck linearize

Alexander Kochetkov (1):
      net: arc_emac: fix arc_emac_rx() error paths

Alexey Khoroshilov (1):
      net: phy: xgene: disable clk on error paths

Aliaksei Karaliou (2):
      xfs: quota: fix missed destroy of qi_tree_lock
      xfs: quota: check result of register_shrinker()

Andreas Platschek (1):
      dmaengine: fsl-edma: disable clks on all error paths

Andy Shevchenko (1):
      x86/platform/intel-mid: Revert "Make 'bt_sfi_data' const"

Anna-Maria Gleixner (1):
      hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)

Antoine Tenart (4):
      crypto: inside-secure - free requests even if their handling failed
      crypto: inside-secure - fix request allocations in invalidation path
      arm64: dts: marvell: add comphy nodes on cp110 master and slave
      arm64: dts: marvell: mcbin: add comphy references to Ethernet ports

Arnaldo Carvalho de Melo (1):
      x86/asm: Allow again using asm.h when building for the 'bpf' clang ta=
rget

Arnd Bergmann (2):
      exec: avoid gcc-8 warning for get_task_comm
      ARM: dts: ls1021a: fix incorrect clock references

Arvind Yadav (1):
      phy: cpcap-usb: Fix platform_get_irq_byname's error checking.

Bogdan Mirea (1):
      arm64: dts: renesas: ulcb: Remove renesas, no-ether-link property

Boris Ostrovsky (1):
      xen/balloon: Mark unallocated host memory as UNUSABLE

Brendan McGrath (1):
      ipv6: icmp6: Allow icmp messages to be looped back

Bryan Tan (1):
      RDMA/vmw_pvrdma: Call ib_umem_release on destroy QP path

Cathy Avery (1):
      scsi: storvsc: Fix scsi_cmd error assignments in storvsc_handle_error

Christophe JAILLET (2):
      mm/frame_vector.c: release a semaphore in 'get_vaddr_frames()'
      mdio-sun4i: Fix a memory leak

Chunyan Zhang (1):
      ARM: 8731/1: Fix csum_partial_copy_from_user() stack mismatch

Cong Wang (1):
      net_sched: get rid of rcu_barrier() in tcf_block_put_ext()

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit ME910 PID 0x1101 support

Dave Young (1):
      x86/efi: Fix kernel param add_efi_memmap regression

David Howells (1):
      afs: Fix missing error handling in afs_write_end()

Eduardo Otubo (1):
      xen-netfront: enable device after manual module load

Erez Shitrit (1):
      IB/ipoib: Fix race condition in neigh creation

Ewan D. Milne (1):
      nvme-fabrics: initialize default host->id in nvmf_host_default()

Felix Janda (1):
      uapi libc compat: add fallback for unsupported libcs

Florian Westphal (1):
      netfilter: uapi: correct UNTRACKED conntrack state bit number

Fredrik Hallenberg (2):
      net: stmmac: Fix TX timestamp calculation
      net: stmmac: Fix bad RX timestamp extraction

Gabriel Krisman Bertazi (1):
      i915: Reject CCS modifiers for pipe C on Geminilake

Gao Feng (1):
      macvlan: Fix one possible double free

Greg Kroah-Hartman (1):
      Linux 4.14.24

Guenter Roeck (1):
      genirq: Guard handle_bad_irq log messages

Guilherme G. Piccoli (1):
      bnx2x: Improve reliability in case of nested PCI errors

Hangbin Liu (1):
      netfilter: nf_tables: fix potential NULL-ptr deref in nf_tables_dump_=
obj_done()

Hao Chen (1):
      nl80211: Check for the required netlink attribute presence

Herbert Xu (1):
      xfrm: Reinject transport-mode packets through tasklet

Huy Nguyen (1):
      net/mlx5e: Fix ETS BW check

Igor Russkikh (2):
      net: aquantia: Fix actual speed capabilities reporting
      net: aquantia: Fix hardware DMA stream overload on large MRRS

Jacek Anaszewski (1):
      leds: core: Fix regression caused by commit 2b83ff96f51d

Jacob Keller (1):
      i40e: don't remove netdev->dev_addr when syncing uc list

Jakub Kicinski (1):
      nfp: always unmask aux interrupts at init

James Hogan (2):
      lib/mpi: Fix umul_ppmm() for MIPS64r6
      MIPS: Implement __multi3 for GCC7 MIPS64r6 builds

James Smart (1):
      nvme-fc: remove double put reference if admin connect fails

Jan Beulich (1):
      x86-64/Xen: eliminate W+X mappings

Jia-Ju Bai (1):
      mac80211_hwsim: Fix a possible sleep-in-atomic bug in hwsim_get_radio=
_nl

Jiri Pirko (1):
      net: sched: fix use-after-free in tcf_block_put_ext

Johannes Berg (1):
      mac80211: mesh: drop frames appearing to be from us

John David Anglin (1):
      parisc: Reduce thread stack to 16 kb

John Fastabend (1):
      bpf: sockmap missing NULL psock check

John Stultz (1):
      staging: ion: Fix ion_cma_heap allocations

Jonathan Cameron (1):
      crypto: af_alg - Fix race around ctx->rcvused by making it atomic_t

Josh Poimboeuf (1):
      x86/stacktrace: Make zombie stack traces reliable

Karol Herbst (1):
      drm/nouveau/pci: do a msi rearm on init

Keith Busch (1):
      nvme: check hw sectors before setting chunk sectors

Kuninori Morimoto (1):
      ASoC: rsnd: fixup ADG register mask

Leon Romanovsky (2):
      IB/mlx4: Fix mlx4_ib_alloc_mr error flow
      RDMA/netlink: Fix locking around __ib_get_device_by_index

Loic Poulain (1):
      wcn36xx: Fix dynamic power saving

Luu An Phu (1):
      can: flex_can: Correct the checking for frame length in flexcan_start=
_xmit()

Madalin Bucur (1):
      of_mdio: avoid MDIO bus removal when a PHY is missing

Marcelo Ricardo Leitner (2):
      sctp: add a ceiling to optlen in some sockopts
      sctp: make use of pre-calculated len

Matthieu CASTET (1):
      led: core: Fix brightness setting when setting delay_off=3D0

Michael Ellerman (1):
      powerpc/pseries: Make RAS IRQ explicitly dependent on DLPAR WQ

Ming Lei (1):
      block: drain queue before waiting for q_usage_counter becoming zero

Moshe Shemesh (2):
      net/mlx5: Cleanup IRQs in case of unload failure
      net/mlx5: Stay in polling mode when command EQ destroy fails

Netanel Belgazal (1):
      net: ena: unmask MSI-X only after device initialization is completed

Nikolay Borisov (1):
      btrfs: Fix flush bio leak

Nitzan Carmi (1):
      IB/mlx5: Fix mlx5_ib_alloc_mr error flow

Ofer Heifetz (1):
      crypto: inside-secure - per request invalidation

Oleksandr Andrushchenko (1):
      Input: xen-kbdfront - do not advertise multi-touch pressure support

Pablo Neira Ayuso (1):
      netfilter: nf_tables: fix chain filter in nf_tables_dump_rules()

Prasad B Munirathnam (1):
      scsi: aacraid: Fix I/O drop during reset

Prateek Sood (1):
      cgroup: Fix deadlock in cpu hotplug path

Radu Pirea (1):
      spi: atmel: fixed spin_lock usage inside atmel_spi_remove

Roman Kapl (2):
      net: sched: fix crash when deleting secondary chains
      net: sched: crash on blocks with goto chain action

Ross Lagerwall (2):
      xen/gntdev: Fix off-by-one error when unmapping with holes
      xen/gntdev: Fix partial gntdev_mmap() cleanup

SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) (1):
      NET: usb: qmi_wwan: add support for YUGA CLM920-NC5 PID 0x9625

Sam Bobroff (1):
      powerpc/pseries: Enable RAS hotplug events later

Sascha Hauer (1):
      mtd: nand: gpmi: Fix failure when a erased page has a bitflip at BBM

Sean Wang (1):
      net: mediatek: setup proper state for disabled GMAC on the default

Sergei Shtylyov (1):
      SolutionEngine771x: fix Ether platform data

Siva Reddy Kallam (2):
      tg3: Add workaround to restrict 5762 MRRS to 2048
      tg3: Enable PHY reset in MTU change path for 5720

Stefan Haberland (1):
      s390/dasd: fix wrongly assigned configuration data

Sunil Challa (1):
      bnxt_en: Fix population of flow_type in bnxt_hwrm_cfa_flow_alloc()

Thomas Gleixner (1):
      perf/x86/intel: Plug memory leak in intel_pmu_init()

Tommi Rantala (2):
      tipc: error path leak fixes in tipc_enable_bearer()
      tipc: fix tipc_mon_delete() oops in tipc_enable_bearer() error path

Tushar Dave (1):
      e1000: fix disabling already-disabled warning

Valentin Ilie (1):
      ia64, sched/cputime: Fix build error if CONFIG_VIRT_CPU_ACCOUNTING_NA=
TIVE=3Dy

Venkat Duvvuru (1):
      bnxt_en: Fix the 'Invalid VF' id check in bnxt_vf_ndo_prep routine.

Xin Long (6):
      sctp: fix the issue that a __u16 variable may overflow in sctp_ulpq_r=
enege
      vxlan: update skb dst pmtu on tx path
      ip_gre: remove the incorrect mtu limit for ipgre tap
      ip6_gre: remove the incorrect mtu limit for ipgre tap
      ip6_tunnel: get the min mtu properly in ip6_tnl_xmit
      ip6_tunnel: allow ip6gre dev mtu to be set below 1280

Xiongwei Song (1):
      drm/ttm: check the return value of kzalloc

Yangbo Lu (1):
      net: gianfar_ptp: move set_fipers() to spinlock protecting area

Yuval Mintz (1):
      mlxsw: pci: Wait after reset before accessing HW


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqdPRIACgkQONu9yGCS
aT5bWA//VnQHwWEM3nXDGyb5gHHzfG+5lyMjpFtjV3HovNATRtdUKTuvcACl2NmS
C0igaQZWBt6h3nRsJHrt3nDpzj/N2cTcQO/S1c7SaBAVJdUwzg8WXoxIMFRvCDGw
CYdhfD0/mk2zVpDcorGzetUdW05VsG1WXD9979rt34xWr9DytaFBGYCft7FnOIzF
g5xVEIV7yG3aLO4Sj7xpIDodeXMmqsrqashoxJU9y/ED4PJm/HKX62d2shFdLBmt
eP4U9oMbmWkf/22HCZv1jsPNTas90Ht3yyaXTkZ3PKNSPdPfw+LD+Aqyv9GTZ/aG
JbjjOlXQwAfWMFjXMDkqVQJkzfwdo4omF4SOJjLDYCFbAl9Hc1wXuAiAqhvM+ODv
4TVnKgmLbNcDmMPeV8rwqHJHNQ5Ul0sdadeeEgZipYysfyvTOwiBVu9oUOJZ74no
bNXGk0APTazLUYad9n8bPrqZ7z6QPYWjXh25LJUcbhOcqejoyo9DCg7XPn0Yaxm6
1hzyIeEPPkNGlrG+hSewkw/5NCx5yR4ipuxnxrSB9fJS2P1JI/8Z0xcjFLa6k4a1
n8ZFthmfeaSuo8AXdMFifdiz1X9FIvKFCoHdc2HIN/mRjwTIir1+pGt/lqJi8MCp
qCsbPq4VBvKA2l/L9SnWCEVlThFQUAxGoPN2JrYGjgqa1+msYo4=
=85XI
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
