Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968648AbeE3Hcp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935179AbeE3Hcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:32:35 -0400
Date: Wed, 30 May 2018 09:32:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.111
Message-ID: <20180530073211.GA22422@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.111 kernel.

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

 Documentation/device-mapper/thin-provisioning.txt                  |    8=
=20
 Makefile                                                           |    2=
=20
 arch/alpha/include/asm/xchg.h                                      |   30 =
++-
 arch/arm/boot/dts/socfpga.dtsi                                     |    2=
=20
 arch/arm/mach-omap1/clock.c                                        |    6=
=20
 arch/arm/mach-omap2/pm.c                                           |    4=
=20
 arch/arm/plat-omap/dmtimer.c                                       |    7=
=20
 arch/m68k/coldfire/device.c                                        |   12 +
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h                     |    2=
=20
 arch/mips/kernel/ptrace.c                                          |   22 =
+-
 arch/mips/kernel/ptrace32.c                                        |    4=
=20
 arch/mips/kvm/mips.c                                               |    2=
=20
 arch/mips/txx9/rbtx4939/setup.c                                    |    4=
=20
 arch/powerpc/include/asm/irq_work.h                                |    1=
=20
 arch/powerpc/perf/core-book3s.c                                    |   25 =
++
 arch/powerpc/sysdev/mpic.c                                         |    2=
=20
 arch/sh/kernel/entry-common.S                                      |    2=
=20
 arch/sparc/include/asm/atomic_64.h                                 |    6=
=20
 arch/x86/kernel/smpboot.c                                          |    1=
=20
 arch/x86/kvm/vmx.c                                                 |   20 =
+-
 arch/x86/kvm/x86.c                                                 |    7=
=20
 arch/x86/power/hibernate_32.c                                      |    2=
=20
 arch/x86/power/hibernate_64.c                                      |    2=
=20
 drivers/acpi/acpi_pad.c                                            |    3=
=20
 drivers/acpi/acpica/evevent.c                                      |    9=
=20
 drivers/acpi/acpica/nseval.c                                       |    8=
=20
 drivers/acpi/processor_perflib.c                                   |    2=
=20
 drivers/ata/libata-core.c                                          |    4=
=20
 drivers/block/paride/pcd.c                                         |    2=
=20
 drivers/cdrom/cdrom.c                                              |    3=
=20
 drivers/cdrom/gdrom.c                                              |    3=
=20
 drivers/clk/samsung/clk-exynos3250.c                               |    4=
=20
 drivers/clk/samsung/clk-exynos5250.c                               |    8=
=20
 drivers/clk/samsung/clk-exynos5260.c                               |    2=
=20
 drivers/clk/samsung/clk-s3c2410.c                                  |   16 -
 drivers/clocksource/fsl_ftm_timer.c                                |    2=
=20
 drivers/dma/pl330.c                                                |    6=
=20
 drivers/firewire/ohci.c                                            |    8=
=20
 drivers/firmware/dmi_scan.c                                        |   22 =
--
 drivers/gpu/drm/exynos/regs-fimc.h                                 |    2=
=20
 drivers/hid/hid-roccat-kovaplus.c                                  |    2=
=20
 drivers/hwmon/nct6775.c                                            |   10 -
 drivers/hwmon/pmbus/adm1275.c                                      |    4=
=20
 drivers/hwmon/pmbus/max8688.c                                      |    2=
=20
 drivers/i2c/busses/i2c-mv64xxx.c                                   |    8=
=20
 drivers/ide/ide-cd.c                                               |    2=
=20
 drivers/infiniband/hw/mlx5/qp.c                                    |    5=
=20
 drivers/infiniband/ulp/ipoib/ipoib_main.c                          |    3=
=20
 drivers/irqchip/irq-gic-v3.c                                       |    2=
=20
 drivers/md/bcache/alloc.c                                          |    4=
=20
 drivers/md/bcache/bcache.h                                         |    2=
=20
 drivers/md/bcache/btree.c                                          |    9=
=20
 drivers/md/bcache/request.c                                        |    2=
=20
 drivers/md/bcache/super.c                                          |   23 =
+-
 drivers/md/bcache/sysfs.c                                          |   11 -
 drivers/md/bcache/writeback.c                                      |   27 =
++
 drivers/md/raid1.c                                                 |   11 +
 drivers/md/raid10.c                                                |    6=
=20
 drivers/media/dvb-core/dmxdev.c                                    |    2=
=20
 drivers/media/pci/cx23885/cx23885-cards.c                          |    4=
=20
 drivers/media/pci/cx23885/cx23885-core.c                           |   10 +
 drivers/media/pci/cx25821/cx25821-core.c                           |    7=
=20
 drivers/media/platform/s3c-camif/camif-capture.c                   |    7=
=20
 drivers/media/usb/em28xx/em28xx.h                                  |    2=
=20
 drivers/message/fusion/mptctl.c                                    |    2=
=20
 drivers/net/ethernet/intel/e1000e/ich8lan.c                        |    2=
=20
 drivers/net/ethernet/intel/e1000e/mac.c                            |    2=
=20
 drivers/net/ethernet/intel/e1000e/netdev.c                         |    4=
=20
 drivers/net/ethernet/marvell/mvneta.c                              |    1=
=20
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                      |    2=
=20
 drivers/net/phy/dp83640.c                                          |   18 +
 drivers/net/usb/qmi_wwan.c                                         |    4=
=20
 drivers/net/usb/r8152.c                                            |    2=
=20
 drivers/net/usb/smsc75xx.c                                         |    7=
=20
 drivers/net/virtio_net.c                                           |    2=
=20
 drivers/net/wireless/ath/ath10k/mac.c                              |   10 +
 drivers/parisc/lba_pci.c                                           |   20 =
+-
 drivers/pci/pci-driver.c                                           |   17 +
 drivers/pci/quirks.c                                               |    5=
=20
 drivers/regulator/of_regulator.c                                   |    1=
=20
 drivers/rtc/rtc-tx4939.c                                           |    6=
=20
 drivers/s390/cio/device_fsm.c                                      |    7=
=20
 drivers/s390/cio/io_sch.h                                          |    1=
=20
 drivers/scsi/aacraid/commsup.c                                     |    4=
=20
 drivers/scsi/aacraid/linit.c                                       |    5=
=20
 drivers/scsi/arm/fas216.c                                          |    2=
=20
 drivers/scsi/bnx2fc/bnx2fc_io.c                                    |    1=
=20
 drivers/scsi/lpfc/lpfc_attr.c                                      |    5=
=20
 drivers/scsi/lpfc/lpfc_hbadisc.c                                   |    5=
=20
 drivers/scsi/lpfc/lpfc_sli.c                                       |    2=
=20
 drivers/scsi/qla2xxx/qla_isr.c                                     |    6=
=20
 drivers/scsi/qla4xxx/ql4_def.h                                     |    2=
=20
 drivers/scsi/qla4xxx/ql4_os.c                                      |   46 =
++++
 drivers/scsi/sd.c                                                  |    3=
=20
 drivers/scsi/sr.c                                                  |   21 =
+-
 drivers/scsi/sym53c8xx_2/sym_hipd.c                                |    2=
=20
 drivers/scsi/ufs/ufshcd.c                                          |    2=
=20
 drivers/staging/rtl8192u/r8192U_core.c                             |    2=
=20
 drivers/tty/serial/arc_uart.c                                      |    5=
=20
 drivers/tty/serial/fsl_lpuart.c                                    |    4=
=20
 drivers/tty/serial/imx.c                                           |    6=
=20
 drivers/tty/serial/samsung.c                                       |    4=
=20
 drivers/tty/serial/xilinx_uartps.c                                 |    2=
=20
 drivers/usb/dwc2/core.h                                            |    2=
=20
 drivers/usb/dwc3/core.h                                            |    2=
=20
 drivers/usb/gadget/composite.c                                     |   40 =
+---
 drivers/usb/gadget/function/f_fs.c                                 |    2=
=20
 drivers/usb/gadget/function/f_uac2.c                               |    2=
=20
 drivers/usb/gadget/udc/fsl_udc_core.c                              |    4=
=20
 drivers/usb/gadget/udc/goku_udc.h                                  |    2=
=20
 drivers/usb/host/ohci-hcd.c                                        |    3=
=20
 drivers/usb/host/xhci-mem.c                                        |    2=
=20
 drivers/usb/musb/musb_core.c                                       |    2=
=20
 drivers/video/fbdev/sbuslib.c                                      |    4=
=20
 drivers/watchdog/f71808e_wdt.c                                     |    3=
=20
 drivers/watchdog/sp5100_tco.h                                      |    2=
=20
 drivers/xen/events/events_base.c                                   |    4=
=20
 drivers/xen/grant-table.c                                          |    4=
=20
 drivers/xen/swiotlb-xen.c                                          |    2=
=20
 drivers/xen/xen-acpi-processor.c                                   |    6=
=20
 drivers/xen/xenbus/xenbus_probe.c                                  |    5=
=20
 drivers/zorro/zorro.c                                              |   12 +
 fs/affs/namei.c                                                    |   10 -
 fs/aio.c                                                           |    4=
=20
 fs/btrfs/ctree.c                                                   |   12 -
 fs/btrfs/disk-io.c                                                 |    2=
=20
 fs/btrfs/extent-tree.c                                             |    1=
=20
 fs/btrfs/inode.c                                                   |   16 -
 fs/btrfs/send.c                                                    |    3=
=20
 fs/btrfs/tests/qgroup-tests.c                                      |    2=
=20
 fs/btrfs/tree-log.c                                                |   12 -
 fs/cifs/cifssmb.c                                                  |    4=
=20
 fs/dcache.c                                                        |   22 =
++
 fs/ecryptfs/inode.c                                                |    3=
=20
 fs/ext2/namei.c                                                    |    6=
=20
 fs/ext4/namei.c                                                    |    6=
=20
 fs/f2fs/namei.c                                                    |   12 -
 fs/jffs2/dir.c                                                     |   12 -
 fs/jffs2/fs.c                                                      |    1=
=20
 fs/jfs/namei.c                                                     |   12 -
 fs/nfs/nfs4sysctl.c                                                |    2=
=20
 fs/nilfs2/namei.c                                                  |    6=
=20
 fs/ocfs2/acl.c                                                     |    6=
=20
 fs/ocfs2/super.c                                                   |    5=
=20
 fs/ocfs2/xattr.c                                                   |    2=
=20
 fs/proc/base.c                                                     |   29 =
++
 fs/proc/proc_sysctl.c                                              |    3=
=20
 fs/reiserfs/namei.c                                                |   12 -
 fs/udf/namei.c                                                     |    6=
=20
 fs/udf/super.c                                                     |    5=
=20
 fs/ufs/namei.c                                                     |    6=
=20
 fs/xfs/xfs_discard.c                                               |   14 -
 include/asm-generic/pgtable.h                                      |   15 +
 include/linux/dcache.h                                             |    1=
=20
 include/linux/suspend.h                                            |    2=
=20
 include/linux/usb/composite.h                                      |    3=
=20
 include/net/llc_conn.h                                             |    2=
=20
 include/net/mac80211.h                                             |    2=
=20
 include/net/regulatory.h                                           |    2=
=20
 include/trace/events/timer.h                                       |   20 =
+-
 include/uapi/linux/if_ether.h                                      |    1=
=20
 kernel/audit.c                                                     |    2=
=20
 kernel/debug/kdb/kdb_main.c                                        |   27 =
++
 kernel/events/core.c                                               |    3=
=20
 kernel/power/power.h                                               |    3=
=20
 kernel/relay.c                                                     |    2=
=20
 kernel/sched/rt.c                                                  |    2=
=20
 kernel/signal.c                                                    |    4=
=20
 mm/ksm.c                                                           |   28 =
++
 mm/mempolicy.c                                                     |   36 =
+++
 mm/swapfile.c                                                      |    4=
=20
 mm/vmscan.c                                                        |   22 =
+-
 net/batman-adv/distributed-arp-table.c                             |    2=
=20
 net/batman-adv/fragmentation.c                                     |    3=
=20
 net/batman-adv/gateway_client.c                                    |    3=
=20
 net/batman-adv/multicast.c                                         |    4=
=20
 net/batman-adv/soft-interface.c                                    |    8=
=20
 net/bridge/netfilter/ebtables.c                                    |   33 =
++-
 net/core/skbuff.c                                                  |    9=
=20
 net/ipv4/ip_vti.c                                                  |    2=
=20
 net/ipv4/tcp_illinois.c                                            |    2=
=20
 net/ipv6/sit.c                                                     |    7=
=20
 net/llc/llc_c_ac.c                                                 |   15 -
 net/llc/llc_conn.c                                                 |   32 =
++-
 net/netlabel/netlabel_unlabeled.c                                  |   10 +
 net/nfc/llcp_commands.c                                            |    4=
=20
 net/nfc/netlink.c                                                  |    3=
=20
 scripts/kconfig/expr.c                                             |    2=
=20
 scripts/kconfig/menu.c                                             |    1=
=20
 scripts/kconfig/zconf.y                                            |   33 =
++-
 security/integrity/ima/ima_crypto.c                                |    2=
=20
 security/integrity/ima/ima_main.c                                  |   13 +
 sound/core/vmaster.c                                               |    5=
=20
 sound/soc/au1x/ac97c.c                                             |    6=
=20
 tools/lib/traceevent/parse-filter.c                                |   10 -
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc |   46 =
++++
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc |   97 =
++++++++++
 tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc         |   43 =
++++
 tools/testing/selftests/memfd/config                               |    1=
=20
 tools/thermal/tmon/sysfs.c                                         |   12 -
 tools/thermal/tmon/tmon.c                                          |    1=
=20
 201 files changed, 1218 insertions(+), 395 deletions(-)

Al Viro (3):
      affs_lookup(): close a race with affs_remove_link()
      aio: fix io_destroy(2) vs. lookup_ioctx() race
      do d_instantiate/unlock_new_inode combinations safely

Alex Estrin (1):
      IB/ipoib: Fix for potential no-carrier state

Alex Williamson (1):
      PCI: Add function 1 DMA alias quirk for Marvell 9128

Alexey Dobriyan (1):
      proc: fix /proc/*/map_files lookup

Anders Roxell (1):
      selftests: memfd: add config fragment for fuse

Andrea Parri (2):
      locking/xchg/alpha: Add unconditional memory barrier to cmpxchg()
      locking/xchg/alpha: Fix xchg() and cmpxchg() memory ordering bugs

Andrzej Hajda (4):
      clk: samsung: s3c2410: Fix PLL rates
      clk: samsung: exynos5260: Fix PLL rates
      clk: samsung: exynos5250: Fix PLL rates
      clk: samsung: exynos3250: Fix PLL rates

Anna-Maria Gleixner (1):
      tracing/hrtimer: Fix tracing bugs by taking all clock bases and modes=
 into account

Arnd Bergmann (4):
      scsi: fas216: fix sense buffer initialization
      x86/power: Fix swsusp_arch_resume prototype
      cifs: silence compiler warnings showing up with gcc-8.0.0
      media: s3c-camif: fix out-of-bounds array access

Arvind Yadav (1):
      xen: xenbus: use put_device() instead of kfree()

Bart Van Assche (1):
      scsi: qla2xxx: Avoid triggering undefined behavior in qla2x00_mbx_com=
pletion()

Benjamin Poirier (1):
      e1000e: Fix check_for_link return value with autoneg off

Brad Love (3):
      media: cx23885: Override 888 ImpactVCBe crystal frequency
      media: cx23885: Set subdev host data to clk_freq pointer
      media: em28xx: USB bulk packet size fix

Carlos Maiolino (1):
      Force log to disk before reading the AGF during a fstrim

Chad Dupuis (1):
      scsi: bnx2fc: Fix check in SCSI completion handler for timed out requ=
est

Chen Yu (1):
      ACPI: processor_perflib: Do not send _PPC change notification if not =
ready

Chris Dickens (1):
      usb: gadget: composite: fix incorrect handling of OS desc requests

Christophe JAILLET (1):
      regulator: of: Add a missing 'of_node_put()' in an error handling pat=
h of 'of_regulator_match()'

Claudio Imbrenda (1):
      mm/ksm: fix interaction with THP

Colin Ian King (5):
      KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"
      clocksource/drivers/fsl_ftm_timer: Fix error return checking
      staging: rtl8192u: return -ENOMEM on failed allocation of priv->oldad=
dr
      rtc: tx4939: avoid unintended sign extension on a 24 bit shift
      media: cx25821: prevent out-of-bounds read on array card

Coly Li (2):
      bcache: properly set task state in bch_writeback_thread()
      bcache: quit dc->writeback_thread when BCACHE_DEV_DETACHING is set

Cong Wang (1):
      llc: properly handle dev_queue_xmit() return value

Dan Carpenter (5):
      ASoC: au1x: Fix timeout tests in au1xac97c_ac97_read()
      HID: roccat: prevent an out of bounds read in kovaplus_profile_activa=
ted()
      scsi: sym53c8xx_2: iterator underflow in sym_getsync()
      scsi: mptfusion: Add bounds check in mptctl_hp_targetinfo()
      xen/acpi: off by one in read_acpi_id()

Danilo Krummrich (1):
      fs/proc/proc_sysctl.c: fix potential page fault while unregistering s=
ysctl table

Dave Carroll (1):
      scsi: aacraid: Insure command thread is not recursively stopped

David Rientjes (1):
      kernel/relay.c: limit kmalloc size to KMALLOC_MAX_SIZE

David S. Miller (1):
      sparc64: Make atomic_xchg() an inline function rather than a macro.

Davidlohr Bueso (1):
      sched/rt: Fix rq->clock_update_flags < RQCF_ACT_SKIP warning

Eric Dumazet (2):
      smsc75xx: fix smsc75xx_set_features()
      r8152: fix tx packets accounting

Erik Schmauss (1):
      ACPICA: Events: add a return on failure from acpi_hw_register_read

Esben Haabendal (1):
      dp83640: Ensure against premature access to PHY registers after reset

Felix Fietkau (1):
      mac80211: round IEEE80211_TX_STATUS_HEADROOM up to multiple of 4

Filipe Manana (2):
      Btrfs: send, fix issuing write op when processing hole in no data mode
      Btrfs: fix copy_items() return value when logging an inode

Florian Westphal (2):
      netfilter: ebtables: convert BUG_ONs to WARN_ONs
      netfilter: ebtables: fix erroneous reject of last rule

Frank Asseg (1):
      tools/thermal: tmon: fix for segfault

Fredrik Noring (1):
      USB: OHCI: Fix NULL dereference in HCDs using HCD_LOCAL_MEM

Geert Uytterhoeven (6):
      ARM: OMAP1: clock: Fix debugfs_create_*() usage
      serial: xuartps: Fix out-of-bounds access through DT alias
      serial: samsung: Fix out-of-bounds access through serial port index
      serial: imx: Fix out-of-bounds access through serial port index
      serial: fsl_lpuart: Fix out-of-bounds access through DT alias
      serial: arc_uart: Fix out-of-bounds access through DT alias

Giuseppe Lippolis (1):
      net-usb: add qmi_wwan if on lte modem wistron neweb d18q1

Greg Kroah-Hartman (1):
      Linux 3.18.111

Greg Ungerer (1):
      m68k: set dma and coherent masks for platform FEC ethernets

Gregory CLEMENT (1):
      i2c: mv64xxx: Apply errata delay only in standard mode

Grigor Tovmasyan (1):
      usb: dwc2: Fix interval type issue

Guenter Roeck (4):
      watchdog: sp5100_tco: Fix watchdog disable bit
      hwmon: (nct6775) Fix writing pwmX_mode
      hwmon: (pmbus/max8688) Accept negative page register values
      hwmon: (pmbus/adm1275) Accept negative page register values

Hector Martin (1):
      firewire-ohci: work around oversized DMA reads on JMicron controllers

Helge Deller (1):
      parisc/pci: Switch LBA PCI bus from Hard Fail to Soft Fail mode

Huang Ying (1):
      mm: fix races between address_space dereference and free in page_evic=
atable

Igor Pylypiv (1):
      watchdog: f71808e_wdt: Fix magic close handling

Jake Daryll Obina (1):
      jffs2: Fix use-after-free bug in jffs2_iget()'s error handling path

James Smart (3):
      scsi: lpfc: Fix issue_lip if link is disabled
      scsi: lpfc: Fix soft lockup in lpfc worker thread during LIP testing
      scsi: lpfc: Fix frequency of Release WQE CQEs

Jan Chochol (1):
      nfs: Do not convert nfs_idmap_cache_timeout to jiffies

Jan Kara (1):
      udf: Provide saner default for invalid uid / gid

Jay Vosburgh (1):
      virtio-net: Fix operstate for virtio when no VIRTIO_NET_F_STATUS

Jean Delvare (1):
      firmware: dmi_scan: Fix handling of empty DMI strings

Jeff Mahoney (1):
      btrfs: fix lockdep splat in btrfs_alloc_subvolume_writers

Jens Axboe (1):
      sr: get/drop reference to device in revalidate and check_events

Jeremy Cline (1):
      scsi: sd: Keep disk read-only when re-reading partition

Joe Jin (1):
      xen-swiotlb: fix the check condition for xen_swiotlb_free_coherent

Joey Pabalinas (1):
      net/tcp/illinois: replace broken algorithm reference link

Johannes Berg (1):
      regulatory: add NUL to request alpha2

John Keeping (1):
      usb: gadget: f_uac2: fix bFirstInterface in composite gadget

Karthikeyan Periyasamy (1):
      ath10k: Fix kernel panic while using worker (ath10k_sta_rc_update_wk)

Kees Cook (1):
      NFC: llcp: Limit size of SDP URI

Kirill A. Shutemov (1):
      asm-generic: provide generic_pmdp_establish()

Lars-Peter Clausen (1):
      usb: gadget: ffs: Let setup() return USB_GADGET_DELAYED_STATUS

Lenny Szubowicz (1):
      ACPI: acpi_pad: Fix memory leak in power saving threads

Leon Romanovsky (2):
      RDMA/mlx5: Avoid memory leak in case of XRCD dealloc failure
      net/mlx5: Protect from command bit overflow

Linus L=FCssing (2):
      batman-adv: fix multicast-via-unicast transmission with AP isolation
      batman-adv: fix packet loss for broadcasted DHCP packets to a server

Liu Bo (2):
      Btrfs: bail out on error during replay_dir_deletes
      Btrfs: fix NULL pointer dereference in log_dir_items

Maciej W. Rozycki (2):
      MIPS: ptrace: Expose FIR register through FP regset
      MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32=
 FGRs

Madhavan Srinivasan (1):
      powerpc/perf: Prevent kernel address leak to userspace via BHRB buffer

Manish Rangankar (1):
      scsi: qla4xxx: skip error recovery in case of register disconnect.

Mark Salter (1):
      irqchip/gic-v3: Change pr_debug message to pr_devel

Masami Hiramatsu (3):
      selftests: ftrace: Add probe event argument syntax testcase
      selftests: ftrace: Add a testcase for string type with kprobe_event
      selftests: ftrace: Add a testcase for probepoint

Mathias Kresin (1):
      MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset

Mathias Nyman (1):
      xhci: zero usb device slot_id member when disabling and freeing a xhc=
i slot

Mathieu Malaterre (1):
      powerpc: Add missing prototype for arch_irq_work_raise()

Matt Redfearn (1):
      MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS

Matthias Schiffer (3):
      batman-adv: fix packet checksum in receive path
      batman-adv: invalidate checksum on fragment reassembly
      batman-adv: fix header size check in batadv_dbg_arp()

Maurizio Lombardi (1):
      cdrom: do not call check_disk_change() inside cdrom_open()

Mauro Carvalho Chehab (1):
      media: dmxdev: fix error code for invalid ioctls

Meelis Roos (1):
      scsi: aacraid: fix shutdown crash when init fails

Mel Gorman (1):
      mm: pin address_space before dereferencing it while isolating an LRU =
page

Merlijn Wajer (1):
      usb: musb: call pm_runtime_{get,put}_sync before reading vbus registe=
rs

Michael Ellerman (2):
      powerpc/mpic: Check if cpu_possible() in mpic_physmask()
      powerpc/perf: Fix kernel address leak via sampling registers

Michael Schmitz (1):
      zorro: Set up z->dev.dma_mask for the DMA API

Nikolay Borisov (2):
      btrfs: Fix out of bounds access in btrfs_search_slot
      btrfs: Fix possible softlock on single core machines

Paolo Bonzini (1):
      kvm: x86: fix KVM_XEN_HVM_CONFIG ioctl

Pawel Dembicki (1):
      net: qmi_wwan: add BroadMobi BM806U 2020:2033

Peter Malone (1):
      fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbus=
fb_ioctl_helper().

Peter Zijlstra (1):
      perf/core: Fix perf_output_read_group()

Petr Vorel (1):
      ima: Fallback to the builtin hash algorithm

Philipp Puschmann (1):
      arm: dts: socfpga: fix GIC PPI warning

Pierre-Yves Kerbrat (1):
      e1000e: allocate ring descriptors with dma_zalloc_coherent

Qi Hou (1):
      dmaengine: pl330: fix a race condition in case of threaded irqs

Qu Wenruo (1):
      btrfs: tests/qgroup: Fix wrong tree backref level

Rafael J. Wysocki (1):
      PCI: Restore config space on runtime resume despite being unbound

Randy Dunlap (1):
      kdb: make "mdr" command repeat

Rich Felker (1):
      sh: fix debug trap failure to process signals before return to user

Richard Guy Briggs (1):
      audit: return on memory error to avoid null pointer dereference

Richard Haines (1):
      netlabel: If PF_INET6, check sk_buff ip header version

Roger Pau Monne (1):
      xen/pirq: fix error path cleanup when binding MSIs

Ross Lagerwall (1):
      xen/grant-table: Use put_page instead of free_page

Samuel Neves (1):
      x86/topology: Update the 'cpu cores' field in /proc/cpuinfo correctly=
 across CPU hotplug operations

Sean Christopherson (1):
      KVM: VMX: raise internal error for exception during invalid protected=
 mode state

Sebastian Ott (2):
      s390/cio: fix return code after missing interrupt
      s390/cio: clear timer when terminating driver I/O

Seunghun Han (1):
      ACPICA: acpi: acpica: fix acpi operand cache leak in nseval.c

Stefan Agner (1):
      usb: gadget: fsl_udc_core: fix ep valid checks

Stefano Brivio (2):
      vti4: Don't count header length twice on tunnel setup
      vti4: Don't override MTU passed on link creation via IFLA_MTU

Steven Rostedt (VMware) (1):
      tools lib traceevent: Fix get_field_str() for dynamic strings

Sujit Reddy Thumma (1):
      scsi: ufs: Enable quirk to ignore sending WRITE_SAME command

Takashi Iwai (1):
      ALSA: vmaster: Propagate slave error

Tang Junhui (4):
      bcache: fix for allocator and register thread race
      bcache: fix for data collapse after re-attaching an attached device
      bcache: return attach error when no cache set exist
      bcache: fix kcrashes with fio in RAID5 backend dev

Tejun Heo (1):
      libata: Blacklist some Sandisk SSDs for NCQ

Thinh Nguyen (1):
      usb: dwc3: Update DWC_usb31 GTXFIFOSIZ reg fields

Thomas Vincent-Cross (1):
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9220

Tom Abraham (1):
      swap: divide-by-zero when zero length swap file on ssd

Tony Lindgren (2):
      ARM: OMAP3: Fix prm wake interrupt for resume
      ARM: OMAP: Fix dmtimer init for omap1

Toshiaki Makita (2):
      net: Fix vlan untag for bridge and vlan_dev with reorder_hdr off
      net: Fix untag for vlan packets without ethernet header

Ulf Magnusson (3):
      kconfig: Don't leak main menus during parsing
      kconfig: Fix automatic menu creation mem leak
      kconfig: Fix expr_free() E_NOT leak

Wolfram Sang (2):
      drm/exynos: fix comparison to bitshift when dealing with a mask
      usb: gadget: udc: change comparison to bitshift when dealing with a m=
ask

Xin Long (1):
      sit: fix IFLA_MTU ignored on NEWLINK

Yelena Krivosheev (1):
      net: mvneta: fix enable of all initialized RXQs

Yisheng Xie (3):
      mm/mempolicy: fix the check of nodemask from user
      mm/mempolicy: add nodes_empty check in SYSC_migrate_pages
      mm/mempolicy.c: avoid use uninitialized preferred_node

Yufen Yu (2):
      md raid10: fix NULL deference in handle_write_completed()
      md/raid1: fix NULL pointer dereference

mulhern (1):
      dm thin: fix documentation relative to low water mark threshold

piaojun (2):
      ocfs2: return -EROFS to mount.ocfs2 if inode block is invalid
      ocfs2/acl: use 'ip_xattr_sem' to protect getting extended attribute

zhongjiang (1):
      kernel/signal.c: avoid undefined behaviour in kill_something_info


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsOU3gACgkQONu9yGCS
aT7bKw//W5etHC9Grnwy3BkEizuzSCme40Wad618gw7NcZZ2Va0hQ9+yDE80GXRU
W6dJINaPK/6NFDTBaMXP2v4GCtVPBq686xiAZJpzuWrvivDdcEb8vNoE4hC8I7hC
pcEENQzNFORBpEO1pxiiz5aAjMad4KYvj3RUgfS6FuLfUnjwDCXKE2KTcW9wyrVv
yrEuFSLCNTyYfgVtg70CARrCUKuUb/7RKxDomxxuwVTtTsQlt4OHYWvj6olEukXm
tliZTxFaghTpoV3TXKIMFeIHysa0E32T27Y0eLbOMno0xV1R/CabgX63RcgAFweU
cPqdecOIarrA9HlvOGEK4KWJ+UQysB+l7pfzgM2bhzBnPkelMXdekDchYCjapRAW
cgSPA9QHpQmOEy/8Xn8FMkdfxQ20654HJaidRBlZZMneUi0Kyo5nT+sif+iwAYMh
910j/W6UJl+BQ1bTa/VsrrsE9ygVRxhgFs1NRNrAK9fXifMzTOWBGOyH2OfwqU0u
o0zYH73HsCMdTycYx9CylxcDnPlaeewiVb40Er9kM1z7ILTlGQM3cst8FUYro6SH
Qsm/2QutqnMWU8ksyoPHyrH42R8UxgK+yfCqB6FcMNbjkbk2Wx2hYdvAkEpC8tju
U7Ka+ht+lEechqT2r+ZCnWgfiVNTYN9pYH3gSHvakgiWh8XUCew=
=Q1kh
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
