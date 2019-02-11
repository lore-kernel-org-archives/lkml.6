Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E78C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84965218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfBKWLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:11:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41760 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726173AbfBKWLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:11:39 -0500
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gtJnK-0007aH-PM; Mon, 11 Feb 2019 22:11:35 +0000
Date:   Mon, 11 Feb 2019 22:11:18 +0000
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>,
        stable@vger.kernel.org
Cc:     lwn@lwn.net
Message-ID: <lsq.1549923033.352388006@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zipnbsui6glc6tn7"
Content-Disposition: inline
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: Linux 3.16.63
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zipnbsui6glc6tn7
Content-Type: multipart/mixed; boundary="wbfb4lsvb6x7vkhu"
Content-Disposition: inline


--wbfb4lsvb6x7vkhu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.16.63 kernel.

All users of the 3.16 kernel series should upgrade.

The updated 3.16.y git tree can be found at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
=2Egit linux-3.16.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git

The diff from 3.16.62 is attached to this message.

Ben.

------------

 Makefile                                         |   6 +-
 arch/alpha/include/asm/termios.h                 |   8 +-
 arch/alpha/include/uapi/asm/ioctls.h             |   5 +
 arch/alpha/include/uapi/asm/termbits.h           |  17 ++++
 arch/arm/boot/dts/exynos4210-origen.dts          |   9 ++
 arch/arm/include/asm/uaccess.h                   |   2 +-
 arch/arm/mach-mmp/include/mach/cputype.h         |   6 +-
 arch/arm/mach-omap1/board-ams-delta.c            |   3 +
 arch/mips/include/asm/syscall.h                  |   2 +-
 arch/parisc/kernel/entry.S                       |   2 +-
 arch/parisc/kernel/traps.c                       |   3 +-
 arch/parisc/mm/init.c                            |   8 +-
 arch/powerpc/boot/crt0.S                         |   4 +-
 arch/powerpc/platforms/pseries/dtl.c             |   4 +-
 arch/s390/hypfs/hypfs_vm.c                       |   2 +-
 arch/s390/include/asm/timex.h                    |  10 +-
 arch/sparc/kernel/signal_32.c                    |   4 +-
 arch/um/os-Linux/skas/process.c                  |   5 +
 arch/x86/boot/boot.h                             |   1 -
 arch/x86/boot/compressed/eboot.c                 |   3 +-
 arch/x86/boot/video-mode.c                       |   2 +
 arch/x86/boot/video.c                            |   2 +
 arch/x86/include/asm/kvm_host.h                  |   2 -
 arch/x86/include/asm/page_64_types.h             |   3 -
 arch/x86/include/asm/page_types.h                |  13 ++-
 arch/x86/include/asm/pgtable-3level.h            |   7 +-
 arch/x86/include/asm/pgtable.h                   |  19 ++--
 arch/x86/include/asm/pgtable_types.h             |  34 ++++++-
 arch/x86/include/asm/x86_init.h                  |   1 -
 arch/x86/include/uapi/asm/msr-index.h            |   1 +
 arch/x86/kernel/check.c                          |  15 +++
 arch/x86/kernel/cpu/mshyperv.c                   |  11 +++
 arch/x86/kernel/cpu/mtrr/if.c                    |   2 +
 arch/x86/kernel/eisa.c                           |   1 +
 arch/x86/kernel/setup.c                          |   2 +-
 arch/x86/kvm/mmu.c                               |  27 ++---
 arch/x86/kvm/svm.c                               |  62 ++++--------
 arch/x86/kvm/vmx.c                               | 121 +++----------------=
----
 arch/x86/kvm/x86.c                               |  21 ++--
 arch/x86/um/shared/sysdep/ptrace_32.h            |  10 --
 arch/x86/vdso/vclock_gettime.c                   |   8 +-
 arch/xtensa/boot/Makefile                        |   2 +-
 arch/xtensa/include/asm/processor.h              |   6 +-
 arch/xtensa/kernel/asm-offsets.c                 |  16 +--
 arch/xtensa/kernel/head.S                        |   7 +-
 arch/xtensa/kernel/process.c                     |   5 +-
 arch/xtensa/kernel/ptrace.c                      |  42 +++++++-
 arch/xtensa/kernel/vmlinux.lds.S                 |   1 +
 crypto/lrw.c                                     |   7 +-
 drivers/acpi/acpi_platform.c                     |   1 +
 drivers/acpi/acpica/dsopcode.c                   |   4 +
 drivers/ata/libata-core.c                        |   5 +
 drivers/block/floppy.c                           |   3 +-
 drivers/clk/clk-s2mps11.c                        |  27 +++++
 drivers/clocksource/i8253.c                      |  14 ++-
 drivers/devfreq/devfreq.c                        |  53 +++++++++-
 drivers/dma/at_hdmac.c                           |  10 +-
 drivers/edac/i7core_edac.c                       |   1 +
 drivers/edac/sb_edac.c                           |   1 +
 drivers/gpio/gpio-max7301.c                      |  12 +--
 drivers/gpu/drm/ast/ast_drv.c                    |  21 ++++
 drivers/gpu/drm/ast/ast_mode.c                   |   3 +-
 drivers/gpu/drm/drm_drv.c                        |  21 ++--
 drivers/gpu/drm/i915/i915_gem.c                  |  15 ++-
 drivers/gpu/drm/i915/intel_pm.c                  |  43 +++++++-
 drivers/hid/hid-ids.h                            |   3 +
 drivers/hid/hid-sensor-hub.c                     |  13 ++-
 drivers/hid/uhid.c                               |  13 +++
 drivers/hid/usbhid/hid-quirks.c                  |   3 +
 drivers/hid/usbhid/hiddev.c                      |  18 +++-
 drivers/hv/channel.c                             |   8 ++
 drivers/hv/hv_kvp.c                              |  24 ++++-
 drivers/hv/vmbus_drv.c                           |  20 ++++
 drivers/hwmon/pmbus/pmbus.c                      |   2 +
 drivers/hwmon/pmbus/pmbus_core.c                 |   5 +-
 drivers/hwmon/w83795.c                           |   2 +-
 drivers/iio/accel/hid-sensor-accel-3d.c          |   5 +-
 drivers/iio/adc/at91_adc.c                       |   6 +-
 drivers/iio/dac/ad5064.c                         |  55 ++++++++---
 drivers/iio/gyro/hid-sensor-gyro-3d.c            |   5 +-
 drivers/iio/light/hid-sensor-als.c               |   8 +-
 drivers/iio/light/hid-sensor-prox.c              |   8 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c    |   8 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c     |   8 +-
 drivers/iio/pressure/hid-sensor-press.c          |   8 +-
 drivers/infiniband/core/cm.c                     |  42 +++++---
 drivers/infiniband/core/user_mad.c               |  10 +-
 drivers/infiniband/hw/mthca/mthca_main.c         |   3 +-
 drivers/infiniband/ulp/iser/iser_verbs.c         |   7 +-
 drivers/input/keyboard/matrix_keypad.c           |  23 +++--
 drivers/iommu/ipmmu-vmsa.c                       |   3 +
 drivers/md/bcache/btree.c                        |   2 +-
 drivers/md/bcache/request.c                      |   6 +-
 drivers/md/dm-ioctl.c                            |  18 ++--
 drivers/media/i2c/tvp5150.c                      |  14 ++-
 drivers/media/pci/cx23885/altera-ci.c            |  10 ++
 drivers/media/usb/cx231xx/cx231xx-video.c        |   2 +-
 drivers/media/usb/em28xx/em28xx-cards.c          |   4 +-
 drivers/media/usb/em28xx/em28xx-video.c          |   8 +-
 drivers/media/usb/uvc/uvc_driver.c               |   2 +-
 drivers/media/v4l2-core/v4l2-event.c             |  43 ++++----
 drivers/media/v4l2-core/videobuf2-core.c         |   4 +-
 drivers/misc/atmel-ssc.c                         |   2 +-
 drivers/misc/genwqe/card_base.h                  |   2 +-
 drivers/misc/genwqe/card_dev.c                   |   9 +-
 drivers/misc/sgi-gru/grukdump.c                  |   4 +
 drivers/misc/vmw_vmci/vmci_resource.c            |   3 +-
 drivers/mmc/card/block.c                         |  15 ++-
 drivers/mmc/core/mmc.c                           |  19 +++-
 drivers/mmc/host/omap.c                          |  11 ++-
 drivers/mmc/host/omap_hsmmc.c                    |  12 ++-
 drivers/mtd/devices/Kconfig                      |   2 +-
 drivers/mtd/spi-nor/fsl-quadspi.c                |  14 ++-
 drivers/net/can/dev.c                            |  48 ++++++---
 drivers/net/ethernet/broadcom/genet/bcmmii.c     |   2 +-
 drivers/net/ethernet/cadence/macb.c              |  22 ++++-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c  |   4 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h        |   4 +-
 drivers/net/ethernet/neterion/vxge/vxge-config.c |   2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.c  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h     |   3 +-
 drivers/net/ethernet/stmicro/stmmac/descs_com.h  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c  |   2 +-
 drivers/net/phy/phy_device.c                     |   2 -
 drivers/net/rionet.c                             |   2 +-
 drivers/net/team/team.c                          |   2 -
 drivers/net/tun.c                                |   2 +-
 drivers/net/vxlan.c                              |  13 ++-
 drivers/net/wireless/iwlwifi/mvm/rs.c            |  29 ++++--
 drivers/net/wireless/libertas/if_usb.c           |   2 -
 drivers/net/wireless/libertas_tf/if_usb.c        |   5 +-
 drivers/net/wireless/mac80211_hwsim.c            |   8 +-
 drivers/of/base.c                                |  25 +++++
 drivers/pci/pcie/aspm.c                          |   2 +-
 drivers/pci/quirks.c                             |   4 +
 drivers/pci/remove.c                             |   4 +-
 drivers/pcmcia/ricoh.h                           |  35 +++++++
 drivers/pcmcia/yenta_socket.c                    |   3 +-
 drivers/power/max8998_charger.c                  |   2 +-
 drivers/rtc/rtc-hid-sensor-time.c                |   2 +-
 drivers/s390/block/dasd_alias.c                  |   3 +-
 drivers/s390/kvm/virtio_ccw.c                    |  17 +++-
 drivers/s390/net/qeth_core_main.c                |  27 +++--
 drivers/s390/net/qeth_l2_main.c                  |   3 +
 drivers/s390/net/qeth_l3_main.c                  |   3 +
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                |   3 +-
 drivers/scsi/esp_scsi.c                          |   1 +
 drivers/scsi/esp_scsi.h                          |   2 +
 drivers/scsi/mac_esp.c                           |   2 +
 drivers/scsi/qla2xxx/qla_init.c                  |   2 +-
 drivers/scsi/qla2xxx/qla_mbx.c                   |   5 +-
 drivers/scsi/sd.c                                |  17 +++-
 drivers/spi/spi-sh-msiof.c                       |   4 +-
 drivers/staging/comedi/drivers/ni_mio_common.c   |  22 +++--
 drivers/staging/comedi/drivers/quatech_daqp_cs.c |  25 ++++-
 drivers/staging/rtl8712/mlme_linux.c             |   2 +-
 drivers/staging/rtl8712/rtl871x_mlme.c           |   2 +-
 drivers/thermal/rcar_thermal.c                   |   9 +-
 drivers/tty/serial/kgdboc.c                      |   9 +-
 drivers/tty/tty_ioctl.c                          |   4 +-
 drivers/uio/uio.c                                |   7 +-
 drivers/usb/chipidea/otg.h                       |   3 +-
 drivers/usb/class/cdc-acm.c                      |   3 +
 drivers/usb/core/hub.c                           |  16 ++-
 drivers/usb/core/quirks.c                        |  18 ++++
 drivers/usb/core/usb.c                           |   6 +-
 drivers/usb/dwc3/gadget.c                        |   6 --
 drivers/usb/gadget/fsl_udc_core.c                |  30 +++++-
 drivers/usb/host/hwa-hc.c                        |   2 +-
 drivers/usb/host/xhci-hub.c                      |  67 +++++++++----
 drivers/usb/host/xhci-pci.c                      |   4 +
 drivers/usb/host/xhci-ring.c                     |   2 +-
 drivers/usb/host/xhci.c                          |  42 +++++++-
 drivers/usb/host/xhci.h                          |   5 +-
 drivers/usb/misc/appledisplay.c                  |   2 +
 drivers/usb/serial/cypress_m8.c                  |   2 +-
 drivers/usb/serial/option.c                      |   8 +-
 drivers/usb/storage/unusual_realtek.h            |  10 ++
 drivers/vhost/vhost.c                            |   2 +
 drivers/video/fbdev/aty/mach64_accel.c           |  28 +++---
 drivers/w1/masters/omap_hdq.c                    |   2 +
 drivers/xen/swiotlb-xen.c                        |   6 ++
 fs/aio.c                                         |   2 +
 fs/btrfs/dev-replace.c                           |   7 +-
 fs/btrfs/disk-io.c                               |  10 +-
 fs/btrfs/extent-tree.c                           |   1 +
 fs/btrfs/file.c                                  |  30 ++++--
 fs/btrfs/free-space-cache.c                      |   2 +
 fs/btrfs/inode.c                                 |   6 +-
 fs/btrfs/ioctl.c                                 |  12 ++-
 fs/btrfs/qgroup.c                                |   3 +-
 fs/btrfs/relocation.c                            |   1 +
 fs/btrfs/super.c                                 |   1 +
 fs/cifs/cifs_debug.c                             |   3 +
 fs/cifs/cifs_spnego.c                            |   6 +-
 fs/cifs/dir.c                                    |   2 +-
 fs/cifs/inode.c                                  |  10 +-
 fs/cramfs/inode.c                                |   3 +-
 fs/exportfs/expfs.c                              |   3 +-
 fs/ext2/xattr.c                                  |   2 +-
 fs/ext4/ext4.h                                   |   3 +-
 fs/ext4/inline.c                                 |   2 +-
 fs/ext4/ioctl.c                                  |  33 +++++--
 fs/ext4/namei.c                                  |   5 +-
 fs/ext4/resize.c                                 |  28 +++---
 fs/ext4/super.c                                  |  91 ++++++++++-------
 fs/ext4/xattr.c                                  |   4 +
 fs/fuse/dev.c                                    |  19 +++-
 fs/fuse/dir.c                                    |   4 +-
 fs/fuse/file.c                                   |  37 +++----
 fs/fuse/fuse_i.h                                 |   3 +-
 fs/gfs2/ops_fstype.c                             |   3 +
 fs/hfs/btree.c                                   |   3 +-
 fs/jffs2/super.c                                 |   4 +-
 fs/lockd/host.c                                  |   2 +-
 fs/namespace.c                                   |  22 ++++-
 fs/nfs/nfs4state.c                               |   8 +-
 fs/ocfs2/dir.c                                   |   3 +-
 fs/sysv/inode.c                                  |   2 +-
 fs/xfs/xfs_stats.c                               |   2 +-
 include/linux/can/dev.h                          |   1 +
 include/linux/ceph/libceph.h                     |   8 +-
 include/linux/hid-sensor-hub.h                   |   4 +-
 include/linux/i8253.h                            |   1 +
 include/linux/kvm_host.h                         |   2 -
 include/linux/netfilter/x_tables.h               |   2 +
 include/linux/of.h                               |   8 ++
 include/linux/uaccess.h                          |   3 +
 include/linux/usb.h                              |   4 +-
 include/linux/usb/quirks.h                       |   3 +
 include/net/cipso_ipv4.h                         |  25 +++--
 kernel/bounds.c                                  |   4 +-
 kernel/events/uprobes.c                          |  12 ++-
 kernel/irq/manage.c                              |   8 +-
 kernel/printk/printk.c                           |   7 +-
 kernel/signal.c                                  |   2 +-
 kernel/time/timer_list.c                         |   2 +-
 kernel/trace/ftrace.c                            |   1 +
 kernel/trace/trace_events_trigger.c              |   6 +-
 mm/hugetlb.c                                     |  29 +++++-
 mm/memory_hotplug.c                              |   2 +
 net/batman-adv/fragmentation.c                   |  20 ++--
 net/batman-adv/types.h                           |   2 +
 net/can/raw.c                                    |  15 +--
 net/core/dev.c                                   |   4 +
 net/core/rtnetlink.c                             |  13 +++
 net/ipv4/cipso_ipv4.c                            |  62 ++++++++----
 net/ipv6/ip6_fib.c                               |   6 +-
 net/ipv6/ip6_vti.c                               |   1 +
 net/ipv6/ndisc.c                                 |   3 +-
 net/l2tp/l2tp_core.c                             |   9 +-
 net/llc/af_llc.c                                 |  13 +--
 net/mac80211/iface.c                             |   2 +
 net/mac80211/rx.c                                |   1 +
 net/mac80211/tx.c                                |   4 +-
 net/netfilter/nf_tables_api.c                    |  22 ++---
 net/netfilter/nft_compat.c                       |   3 +-
 net/netfilter/x_tables.c                         |  30 ++++++
 net/netfilter/xt_IDLETIMER.c                     |  20 ++++
 net/netfilter/xt_hashlimit.c                     |   5 +-
 net/netfilter/xt_recent.c                        |   6 +-
 net/netlabel/netlabel_kapi.c                     |  15 ++-
 net/sched/sch_gred.c                             |   2 +-
 net/sunrpc/auth_gss/auth_gss.c                   |   4 +
 net/sunrpc/svc_xprt.c                            |   2 +-
 net/sunrpc/xdr.c                                 |   7 +-
 net/sunrpc/xprt.c                                |  11 ++-
 net/vmw_vsock/vmci_transport.c                   |  67 +++++++++----
 net/xfrm/xfrm_state.c                            |   2 +-
 security/integrity/ima/ima_fs.c                  |   6 +-
 sound/core/control.c                             |  79 ++++++++-------
 sound/core/oss/pcm_oss.c                         |   2 +-
 sound/core/oss/pcm_plugin.c                      |   2 +-
 sound/core/pcm_native.c                          |   3 +-
 sound/isa/wss/wss_lib.c                          |   2 -
 sound/pci/ac97/ac97_codec.c                      |   2 +-
 sound/pci/ca0106/ca0106.h                        |   2 +-
 sound/pci/hda/hda_intel.c                        |   4 +
 sound/pci/hda/patch_conexant.c                   |   1 +
 sound/sparc/cs4231.c                             |   8 +-
 sound/usb/card.c                                 |  81 ++++++++++-----
 sound/usb/endpoint.c                             |  10 +-
 sound/usb/mixer.c                                |  32 ++----
 sound/usb/mixer_quirks.c                         | 112 ++++++++++---------=
--
 sound/usb/pcm.c                                  |  32 +++---
 sound/usb/proc.c                                 |   4 +-
 sound/usb/quirks-table.h                         |   9 +-
 sound/usb/usbaudio.h                             |  11 ++-
 tools/power/cpupower/bench/parse.c               |   2 +-
 290 files changed, 2171 insertions(+), 1072 deletions(-)

Aaro Koskinen (1):
      MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310

Aaron Ma (2):
      usb: xhci: fix uninitialized completion when USB3 port got wrong stat=
us
      usb: xhci: fix timeout for transition from RExit to U0

Ahmad Fatoum (1):
      mtd: spi-nor: fsl-quadspi: Don't let -EINVAL on the bus

Al Viro (2):
      gfs2_meta: ->mount() can get NULL dev_name
      new helper: uaccess_kernel()

Alex Stanoev (1):
      ALSA: ca0106: Disable IZD on SB0570 DAC to fix audio pops

Alexander Theissen (1):
      usb: appledisplay: Add 27" Apple Cinema Display

Amir Goldstein (1):
      lockd: fix access beyond unterminated strings in prints

Anders Roxell (1):
      cpupower: remove stringop-truncation waring

Andrea Parri (1):
      uprobes: Fix handle_swbp() vs. unregister() + register() race once mo=
re

Andreas Kemnade (1):
      w1: omap-hdq: fix missing bus unregister at removal

Andreas Larsson (1):
      sparc32: Fix inverted invalid_frame_pointer checks on sigreturns

Andy Lutomirski (1):
      x86/vdso: Fix vDSO syscall fallback asm constraint regression

Anssi Hannula (2):
      net: macb: fix dropped RX frames due to a race
      net: macb: add missing barriers when reading descriptors

Arnd Bergmann (4):
      ARM: fix put_user() for gcc-8
      turn off -Wattribute-alias
      kbuild: fix kernel/bounds.c 'W=3D1' warning
      mtd: docg3: don't set conflicting BCH_CONST_PARAMS option

Aya Levin (1):
      net/mlx4: Fix UBSAN warning of signed integer overflow

Ben Greear (1):
      mac80211: Clear beacon_int in ieee80211_do_stop

Ben Hutchings (4):
      x86/boot: eboot.c: Include string function declarations
      s390/dasd: Restore a necessary cast
      ipv6: Fix another sparse warning on rt6i_node
      Linux 3.16.63

Benjamin Poirier (1):
      xfrm: Fix bucket count reported to userspace

Bin Meng (1):
      PCI: Add Device IDs for Intel GPU "spurious interrupt" quirk

Breno Leitao (1):
      HID: hiddev: fix potential Spectre v1

Carlos Maiolino (1):
      xfs: Fix xqmstats offsets in /proc/fs/xfs/xqmstat

Chad Austin (1):
      fuse: continue to send FUSE_RELEASEDIR when FUSE_OPEN returns ENOSYS

Changwei Ge (1):
      ocfs2: fix a misuse a of brelse after failing ocfs2_check_dir_entry

Chen Gang (1):
      s390/timex: fix get_tod_clock_ext() inline assembly

Chris Mason (1):
      Btrfs: don't clean dirty pages during buffered writes

Chris Wilson (1):
      drm/i915: Large page offsets for pread/pwrite

Christian Hoff (1):
      Input: matrix_keypad - check for errors from of_get_named_gpio()

Christophe Leroy (1):
      gpio: max7301: fix driver for use with CONFIG_VMAP_STACK

Chuck Lever (1):
      SUNRPC: Fix leak of krb5p encode pages

Colin Ian King (3):
      media: cx231xx: fix potential sign-extension overflow on large shift
      x86/mtrr: Don't copy uninitialized gentry fields back to userspace
      vxge: ensure data0 is initialized in when fetching firmware version i=
nformation

Dan Carpenter (6):
      staging: comedi: quatech_daqp_cs: fix no-op loop daqp_ao_insn_write()
      libertas_tf: prevent underflow in process_cmdrequest()
      qlcnic: fix a return in qlcnic_dcb_get_capability()
      uio: Fix an Oops on load
      bnx2fc: fix an error code in _bnx2fc_create()
      scsi: bnx2fc: Fix NULL dereference in error handling

Dennis Wassenberg (1):
      usb: core: Fix hub port connection events lost

Dexuan Cui (4):
      Drivers: hv: kvp: Fix two "this statement may fall through" warnings
      Drivers: hv: kvp: Fix the recent regression caused by incorrect clean=
-up
      Drivers: hv: vmbus: check the creation_status in vmbus_establish_gpad=
l()
      Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened cha=
nnels

Diego Viola (2):
      libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9
      libata: blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD

Dmitry Bazhenov (1):
      hwmon: (pmbus) Fix page count auto-detection.

Dmitry Bilunov (1):
      KVM: Handle MSR_IA32_PERF_CTL

Dmitry V. Levin (1):
      mips: fix mips_get_syscall_arg o32 check

Eduardo Habkost (1):
      kvm: x86: Add AMD's EX_CFG to the list of ignored MSRs

Emmanuel Grumbach (1):
      mac80211: ignore NullFunc frames in the duplicate detection

Emmanuel Pescosta (1):
      usb: quirks: Add delay-init quirk for Corsair K70 LUX RGB

Enric Balletbo i Serra (1):
      PM / devfreq: Fix devfreq_add_device() when drivers are built as modu=
les.

Eric Biggers (2):
      ima: fix showing large 'violations' or 'runtime_measurements_count'
      HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges

Eric Dumazet (4):
      llc: do not use sk_eat_skb()
      net-gro: reset skb->pkt_type in napi_reuse_skb()
      rtnetlink: ndo_dflt_fdb_dump() only work for ARPHRD_ETHER devices
      ipv6: tunnels: fix two use-after-free

Eric W. Biederman (5):
      signal: Always deliver the kernel's SIGKILL and SIGSTOP to a pid name=
space init
      signal/GenWQE: Fix sending of SIGKILL
      mount: Retest MNT_LOCKED in do_umount
      mount: Don't allow copying MNT_UNBINDABLE|MNT_LOCKED mounts
      mount: Prevent MNT_DETACH from disconnecting locked mounts

Erik Schmauss (1):
      ACPICA: AML interpreter: add region addresses in global list during i=
nitialization

Eugen Hristev (2):
      iio: adc: at91: fix acking DRDY irq on simple conversions
      iio: adc: at91: fix wrong channel number in triggered buffer mode

Felipe Balbi (1):
      Revert "usb: dwc3: gadget: skip Set/Clear Halt when invalid"

Felix Fietkau (1):
      mac80211: fix reordering of buffered broadcast packets

Filipe Manana (5):
      Btrfs: fix null pointer dereference on compressed write path error
      Btrfs: fix use-after-free when dumping free space
      Btrfs: fix data corruption due to cloning of eof block
      Btrfs: ensure path name is null terminated at btrfs_control_ioctl
      Btrfs: fix race between enabling quotas and subvolume creation

Finn Thain (1):
      scsi: esp_scsi: Track residual for PIO transfers

Florian Fainelli (1):
      net: phy: Stop with excessive soft reset

Florian Westphal (4):
      netfilter: x_tables: add and use xt_check_proc_name
      netfilter: nf_tables: don't use position attribute on rule replacement
      netfilter: nf_tables: fix oob access
      netfilter: nf_tables: fix use-after-free when deleting compat express=
ions

Frank Sorenson (1):
      sunrpc: correct the computation for page_ptr when truncating

Fran=E7ois Cami (1):
      libata: Apply NOLPM quirk for SAMSUNG PM830 CXM13D1Q.

Geert Uytterhoeven (4):
      thermal: rcar_thermal: Prevent hardware access during system suspend
      thermal: rcar: Make error and remove paths symmetrical with init
      thermal: rcar_thermal: Prevent doing work after unbind
      iommu/ipmmu-vmsa: Fix crash on early domain free

Gustavo A. R. Silva (2):
      drivers/misc/sgi-gru: fix Spectre v1 vulnerability
      drm/ioctl: Fix Spectre v1 vulnerabilities

H Hartley Sweeten (2):
      staging: comedi: quatech_daqp_cs: fix bug in daqp_ao_insn_write()
      staging: comedi: quatech_daqp_cs: use comedi_timeout() in ao (*insn_w=
rite)

H. Peter Anvin (1):
      termios, tty/tty_baudrate.c: fix buffer overrun

H. Peter Anvin (Intel) (1):
      arch/alpha, termios: implement BOTHER, IBSHIFT and termios2

Halil Pasic (2):
      virtio/s390: avoid race on vcdev->config
      virtio/s390: fix race in ccw_io_helper()

Hangbin Liu (1):
      team: no need to do team_notify_peers or team_mcast_rejoin when disab=
ling port

Hans Verkuil (1):
      media: vb2: don't call __vb2_queue_cancel if vb2_start_streaming fail=
ed

Hans de Goede (3):
      libata: Apply NOLPM quirk for SAMSUNG MZMPC128HBFU-000MV SSD
      iio/hid-sensors: Fix IIO_CHAN_INFO_RAW returning wrong values for sig=
ned numbers
      ACPI / platform: Add SMB0001 HID to forbidden_id_list

Harry Pan (1):
      usb: quirk: add no-LPM quirk on SanDisk Ultra Flair device

He Zhe (3):
      x86/corruption-check: Fix panic in memory_corruption_check() when boo=
t option without value is provided
      kgdboc: Passing ekgdboc to command line causes panic
      printk: Fix panic caused by passing log_buf_len to command line

Helge Deller (1):
      parisc: Fix map_pages() to not overwrite existing pte entries

Himanshu Madhani (1):
      scsi: qla2xxx: Fix incorrect port speed being set for FC adapters

Hou Tao (1):
      jffs2: free jffs2_sb_info through jffs2_kill_sb()

Huacai Chen (1):
      hwmon: (w83795) temp4_type has writable permission

Hui Peng (1):
      ALSA: usb-audio: Fix UAF decrement if card has no live interfaces in =
card.c

Ido Schimmel (1):
      rtnetlink: Disallow FDB configuration for non-Ethernet device

Ilya Dryomov (1):
      libceph: bump CEPH_MSG_MAX_DATA_LEN

Ingo Molnar (1):
      timer/debug: Change /proc/timer_list from 0444 to 0400

Jakub Kicinski (1):
      net: sched: gred: pass the right attribute to gred_change_table_def()

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix possible use of uninitialized field

Jason Wang (1):
      vhost: make sure used idx is seen before log in vhost_add_used_n()

Jeff Mahoney (1):
      btrfs: fix error handling in btrfs_dev_replace_start

Jeff Moyer (1):
      aio: fix spectre gadget in lookup_ioctx

Jens Axboe (2):
      floppy: fix race condition in __floppy_read_block_0()
      scsi: sd: use mempool for discard special page

Jeremy Cline (1):
      ALSA: hda - Add mic quirk for the Lenovo G50-30 (17aa:3905)

Jim Mattson (2):
      KVM: nVMX: Always reflect #NM VM-exits to L1
      kvm: svm: Ensure an IBPB on all affected CPUs when freeing a vmcb

Joe Jin (1):
      xen-swiotlb: use actually allocated size on check physical continuous

Johan Hovold (3):
      USB: serial: cypress_m8: fix interrupt-out transfer length
      of: add helper to lookup compatible child node
      net: bcmgenet: fix OF child-node lookup

John David Anglin (1):
      parisc: Fix address in HPMC IVA

Jorgen Hansen (2):
      VMCI: Resource wildcard match fixed
      VSOCK: Send reset control packet when socket is partially bound

Josef Bacik (1):
      btrfs: wait on caching when putting the bg cache

Juergen Gross (1):
      x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear

Julian Wiedmann (2):
      s390/qeth: invoke softirqs after napi_schedule()
      s390/qeth: fix length check in SNMP processing

Junaid Shahid (1):
      kvm: mmu: Fix race in emulated page table writes

J=F6rgen Storvist (1):
      USB: serial: option: add Simcom SIM7500/SIM7600 (MBIM mode)

Kai-Heng Feng (4):
      USB: Wait for extra delay time after USB_PORT_FEAT_RESET for quirky h=
ub
      USB: quirks: Add no-lpm quirk for Raydium touchscreens
      USB: usb-storage: Add new IDs to ums-realtek
      ALSA: hda: Add support for AMD Stoney Ridge

Kirill A. Shutemov (1):
      x86/mm: Fix regression with huge pages on PAE

Krzysztof Kozlowski (1):
      clk: s2mps11: Fix matching when built as module and DT node contains =
compatible

Ladi Prosek (1):
      KVM: x86: Add MSR_AMD64_DC_CFG to the list of ignored MSRs

Lars-Peter Clausen (1):
      iio: ad5064: Fix regulator handling

Leon Romanovsky (1):
      RDMA/cm: Respect returned status of cm_init_av_by_path

Linus Torvalds (1):
      disable new gcc-7.1.1 warnings for now

Loic Poulain (1):
      usb: chipidea: Prevent unbalanced IRQ disable

Lubomir Rintel (2):
      libertas: don't set URB_ZERO_PACKET on IN USB transfer
      ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt

Luca Coelho (1):
      iwlwifi: mvm: check return value of rs_rate_from_ucode_rate()

Lukas Czerner (1):
      ext4: initialize retries variable in ext4_da_write_inline_data_begin()

Lukas Wunner (2):
      PCI/ASPM: Fix link_state teardown on device removal
      genirq: Fix race on spurious interrupt detection

Maarten Jacobs (1):
      usb: cdc-acm: add entry for Hiro (Conexant) modem

Maciej S. Szmigiero (1):
      pcmcia: Implement CLKRUN protocol disabling for Ricoh bridges

Macpaul Lin (1):
      kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()

Marc Kleine-Budde (4):
      can: dev: can_get_echo_skb(): factor out non sending code to __can_ge=
t_echo_skb()
      can: dev: __can_get_echo_skb(): replace struct can_frame by canfd_fra=
me to access frame length
      can: dev: __can_get_echo_skb(): Don't crash the kernel if can_priv::e=
cho_skb is accessed out of bounds
      can: dev: __can_get_echo_skb(): print error message, if trying to ech=
o non existing skb

Marco Felsch (1):
      media: tvp5150: fix width alignment during set_selection()

Marek Szyprowski (1):
      ARM: dts: exynos: Disable pull control for MAX8997 interrupts on Orig=
en

Mathias Nyman (3):
      usb: xhci: Prevent bus suspend if a port connect change or polling st=
ate is detected
      xhci: Prevent U1/U2 link pm states if exit latency is too long
      xhci: Don't prevent USB2 bus suspend in state check intended for USB3=
 only

Mathias Payer (1):
      USB: check usb_get_extra_descriptor for proper size

Mattias Jacobsson (1):
      USB: misc: appledisplay: add 20" Apple Cinema Display

Mauro Carvalho Chehab (3):
      media: em28xx: use a default format if TRY_FMT fails
      media: em28xx: fix input name for Terratec AV 350
      media: em28xx: make v4l2-compliance happier by starting sequence on z=
ero

Max Filippov (6):
      xtensa: add NOTES section to the linker script
      xtensa: make sure bFLT stack is 16 byte aligned
      xtensa: fix boot parameters address translation
      xtensa: enable coprocessors that are being flushed
      xtensa: fix coprocessor context offset definitions
      xtensa: fix coprocessor part of ptrace_{get,set}xregs

Michael Kelley (2):
      clockevents/drivers/i8253: Add support for PIT shutdown quirk
      x86/hyper-v: Enable PIT shutdown quirk

Michael Niew=F6hner (1):
      usb: core: quirks: add RESET_RESUME quirk for Cherry G230 Stream seri=
es

Michal Hocko (1):
      memory_hotplug: cond_resched in __remove_pages

Mike Kravetz (2):
      hugetlbfs: dirty pages as they are added to pagecache
      hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!

Miklos Szeredi (3):
      fuse: fix blocked_waitq wakeup
      fuse: fix leaked notify reply
      fuse: cleanup fuse_file refcounting

Mikulas Patocka (2):
      mach64: fix display corruption on big endian machines
      mach64: fix image corruption due to reading accelerator registers

Nadav Amit (1):
      media: uvcvideo: Fix uvc_alloc_entity() allocation alignment

Nathan Chancellor (2):
      clk: s2mps11: Add used attribute to s2mps11_dt_match
      misc: atmel-ssc: Fix section annotation on atmel_ssc_get_driver_data

Naveen N. Rao (2):
      powerpc/pseries: Fix DTL buffer registration
      powerpc/pseries: Fix how we iterate over the DTL entries

Nicholas Mc Guire (2):
      media: pci: cx23885: handle adding to list failure
      usb: gadget: fsl_udc_core: check allocation return value and cleanup =
on failure

Nicolas Dichtel (1):
      tun: forbid iface creation with rtnl ops

Nicolas Huaman (1):
      ALSA: usb-audio: update quirk for B&W PX to remove microphone

Nicolas Pitre (1):
      Cramfs: fix abad comparison when wrap-arounds occur

Nikolay Borisov (1):
      btrfs: Always try all copies when reading extent buffers

Oliver Hartkopp (1):
      can: raw: check for CAN FD capable netdev in raw_sendmsg()

Ondrej Mosnacek (1):
      crypto: lrw - Fix out-of bounds access on counter overflow

Pan Bian (5):
      btrfs: relocation: set trans to be NULL after ending transaction
      exportfs: do not read dentry after free
      ext2: fix potential use after free
      rapidio/rionet: do not free skb before reading its length
      hfs: do not free node before using

Paolo Bonzini (1):
      KVM: x86: remove code for lazy FPU handling

Parav Pandit (3):
      IB/{cm, umad}: Handle av init error
      IB/cm: Fix sleeping while spin lock is held
      IB/cm: Avoid AV ah_attr overwriting during LAP message handling

Paul Mackerras (1):
      powerpc: Fix COFF zImage booting on old powermacs

Paul Moore (1):
      cipso: don't use IPCB() to locate the CIPSO IP option

Paulo Alcantara (1):
      cifs: Fix separator when building path from dentry

Petr Machata (1):
      vxlan: Fix error path in __vxlan_dev_create()

Punnaiah Choudary Kalluri (1):
      net: macb: Fix race condition in driver when Rx frame is dropped

Quinn Tran (1):
      scsi: qla2xxx: shutdown chip if reset fail

Richard Genoud (2):
      dmaengine: at_hdmac: fix memory leak in at_dma_xlate()
      dmaengine: at_hdmac: fix module unloading

Richard Weinberger (2):
      um: Drop own definition of PTRACE_SYSEMU/_SINGLESTEP
      um: Give start_idle_thread() a return code

Robbie Ko (1):
      Btrfs: fix cur_offset in the error case for nocow

Russell King (1):
      mmc: omap_hsmmc: fix DMA API warning

Sagi Grimberg (1):
      iser: set sector for ambiguous mr status errors

Sakari Ailus (1):
      media: v4l: event: Add subscription to list before calling "add" oper=
ation

Sandeep Singh (1):
      xhci: workaround CSS timeout on AMD SNPS 3.0 xHC

Sebastian Parschauer (2):
      HID: Add quirk for Microsoft PIXART OEM mouse
      HID: Add quirk for Primax PIXART OEM mice

Sergei Shtylyov (1):
      spi: sh-msiof: fix deferred probing

Serhey Popovych (1):
      tun: Consistently configure generic netdev params via rtnetlink

Spencer E. Olson (1):
      staging: comedi: ni_mio_common: protect register write overflow

Stefan Nuernberger (1):
      net/ipv4: defensive cipso option parsing

Stefano Brivio (1):
      ipv6/ndisc: Preserve IPv6 control buffer if protocol error handlers a=
re called

Steve French (3):
      smb3: allow stats which track session and share reconnects to be reset
      smb3: do not attempt cifs operation in smb3 query info error path
      smb3: on kerberos mount if server doesn't specify auth type use krb5

Steven Rostedt (VMware) (2):
      tracing: Fix memory leak in set_trigger_filter()
      tracing: Fix memory leak of instance function hash filters

Sven Eckelmann (3):
      batman-adv: Check total_size when queueing fragments
      batman-adv: Use only queued fragments when merging
      batman-adv: Expand merged fragment buffer for full packet

Taehee Yoo (1):
      netfilter: xt_IDLETIMER: add sysfs filename checking routine

Takashi Iwai (8):
      ALSA: oss: Use kvzalloc() for local buffer allocations
      ALSA: ac97: Fix incorrect bit shift at AC97-SPSA control write
      ALSA: wss: Fix invalid snd_free_pages() at error path
      ALSA: sparc: Fix invalid snd_free_pages() at error path
      ALSA: control: Fix race between adding and removing a user element
      ALSA: pcm: Call snd_pcm_unlink() conditionally at closing
      ALSA: usb-audio: Avoid nested autoresume calls
      ALSA: usb-audio: Replace probing flag with active refcount

Takashi Sakamoto (1):
      ALSA: control: fix failure to return numerical ID in 'add' event

Tang Junhui (1):
      bcache: fix miss key refill->end in writeback

Tarick Bedeir (1):
      net/mlx4_core: Correctly set PFC param if global pause is turned off.

Theodore Ts'o (4):
      ext4: fix EXT4_IOC_SWAP_BOOT
      ext4: fix use-after-free race in ext4_remount()'s error path
      ext4: avoid possible double brelse() in add_new_gdb() on error path
      ext4: fix possible leak of sbi->s_group_desc_leak in error path

Thomas Gleixner (2):
      x86/eisa: Add missing include
      mac80211_hwsim: Replace bogus hrtimer clockid

Thomas Zimmermann (1):
      drm/ast: Remove existing framebuffers before loading driver

Thor Thayer (1):
      net: stmmac: Fix RX packet size > 8191

Tom Lendacky (1):
      x86/mm: Simplify p[g4um]d_page() macros

Tomasz Figa (1):
      power: supply: max8998-charger: Fix platform data retrieval

Tony Luck (1):
      EDAC, {i7core,sb,skx}_edac: Fix uncorrected error counting

Tore Anderson (1):
      USB: serial: option: add HP lt4132

Toshi Kani (3):
      x86/asm: Add pud/pmd mask interfaces to handle large PAT bit
      x86/asm: Move PUD_PAGE macros to page_types.h
      x86/asm: Fix pud/pmd interfaces to handle large PAT bit

Trond Myklebust (3):
      nfsd: Fix an Oops in free_session()
      NFSv4: Don't exit the state manager without clearing NFS4CLNT_MANAGER=
_RUNNING
      SUNRPC: Fix a potential race in xprt_connect()

Ulf Hansson (2):
      mmc: core: Reset HPI enabled state during re-init and in case of erro=
rs
      mmc: core: Use a minimum 1600ms timeout when enabling CACHE ctrl

Vasily Averin (10):
      ext4: avoid potential extra brelse in setup_new_flex_group_blocks()
      ext4: add missing brelse() in set_flexbg_block_bitmap()'s error path
      ext4: add missing brelse() add_new_gdb_meta_bg()'s error path
      ext4: add missing brelse() update_backups()'s error path
      ext4: fix missing cleanup if ext4_alloc_flex_bg_array() fails while r=
esizing
      ext4: fix possible inode leak in the retry loop of ext4_resize_fs()
      ext4: avoid buffer leak in ext4_orphan_add() after prior errors
      ext4: release bs.bh before re-using in ext4_xattr_block_find()
      ext4: fix buffer leak in ext4_xattr_move_to_block() on error path
      ext4: fix buffer leak in __ext4_read_dirblock() on error path

Vasyl Vavrychuk (1):
      mac80211_hwsim: Timer should be initialized before device registered

Ville Syrj=E4l=E4 (2):
      drm/i915: Disable LP3 watermarks on all SNB machines
      drm: Rewrite drm_ioctl_flags() to resemble the new drm_ioctl() code

Wanpeng Li (1):
      KVM: X86: Fix NULL deref in vcpu_scan_ioapic

Wei Yongjun (1):
      IB/mthca: Fix error return code in __mthca_init_one()

Wenwen Wang (1):
      dm ioctl: harden copy_params()'s copy_from_user() from malicious users

Wolfram Sang (1):
      mmc: core: use mrq->sbc when sending CMD23 for RPMB

Xin Long (1):
      l2tp: fix a sock refcnt leak in l2tp_tunnel_register

Y.C. Chen (2):
      drm/ast: change resolution may cause screen blurred
      drm/ast: fixed cursor may disappear sometimes

Yogesh Gaur (1):
      mtd: spi-nor: fsl-quadspi: fix api naming typo _init_ahb_read

Young Xiao (1):
      staging: rtl8712: Fix possible buffer overrun

YueHaibing (3):
      SUNRPC: drop pointless static qualifier in xdr_get_next_encode_buffer=
()
      sysv: return 'err' instead of 0 in __sysv_write_inode
      exportfs: fix 'passing zero to ERR_PTR()' warning

Zhimin Gu (1):
      x86, hibernate: Fix nosave_regions setup for hibernation

tang.junhui (1):
      bcache: fix wrong cache_misses statistics

yujuan.qi (1):
      Cipso: cipso_v4_optptr enter infinite loop


--wbfb4lsvb6x7vkhu
Content-Type: text/x-diff; charset=UTF-8; name="linux-3.16.63.patch"
Content-Disposition: attachment; filename="linux-3.16.63.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/Makefile b/Makefile
index e8aa5044ebdd..8d67c849c7e8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION =3D 3
 PATCHLEVEL =3D 16
-SUBLEVEL =3D 62
+SUBLEVEL =3D 63
 EXTRAVERSION =3D
 NAME =3D Museum of Fishiegoodies
=20
@@ -617,6 +617,10 @@ include $(srctree)/arch/$(SRCARCH)/Makefile
=20
 KBUILD_CFLAGS	+=3D $(call cc-option,-fno-delete-null-pointer-checks,)
 KBUILD_CFLAGS	+=3D $(call cc-disable-warning,frame-address,)
+KBUILD_CFLAGS	+=3D $(call cc-disable-warning, format-truncation)
+KBUILD_CFLAGS	+=3D $(call cc-disable-warning, format-overflow)
+KBUILD_CFLAGS	+=3D $(call cc-disable-warning, int-in-bool-context)
+KBUILD_CFLAGS	+=3D $(call cc-disable-warning, attribute-alias)
=20
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+=3D -Os $(call cc-disable-warning,maybe-uninitialized,)
diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/term=
ios.h
index 7fde0f88da88..51ed90be770a 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios.h
@@ -72,9 +72,15 @@
 })
=20
 #define user_termios_to_kernel_termios(k, u) \
-	copy_from_user(k, u, sizeof(struct termios))
+	copy_from_user(k, u, sizeof(struct termios2))
=20
 #define kernel_termios_to_user_termios(u, k) \
+	copy_to_user(u, k, sizeof(struct termios2))
+
+#define user_termios_to_kernel_termios_1(k, u) \
+	copy_from_user(k, u, sizeof(struct termios))
+
+#define kernel_termios_to_user_termios_1(u, k) \
 	copy_to_user(u, k, sizeof(struct termios))
=20
 #endif	/* _ALPHA_TERMIOS_H */
diff --git a/arch/alpha/include/uapi/asm/ioctls.h b/arch/alpha/include/uapi=
/asm/ioctls.h
index 92c557be49fc..6a25cdeb049e 100644
--- a/arch/alpha/include/uapi/asm/ioctls.h
+++ b/arch/alpha/include/uapi/asm/ioctls.h
@@ -31,6 +31,11 @@
 #define TCXONC		_IO('t', 30)
 #define TCFLSH		_IO('t', 31)
=20
+#define TCGETS2		_IOR('T', 42, struct termios2)
+#define TCSETS2		_IOW('T', 43, struct termios2)
+#define TCSETSW2	_IOW('T', 44, struct termios2)
+#define TCSETSF2	_IOW('T', 45, struct termios2)
+
 #define TIOCSWINSZ	_IOW('t', 103, struct winsize)
 #define TIOCGWINSZ	_IOR('t', 104, struct winsize)
 #define	TIOCSTART	_IO('t', 110)		/* start output, like ^Q */
diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/ua=
pi/asm/termbits.h
index 879dd3589921..483c7ec2a879 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -25,6 +25,19 @@ struct termios {
 	speed_t c_ospeed;		/* output speed */
 };
=20
+/* Alpha has identical termios and termios2 */
+
+struct termios2 {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_cc[NCCS];		/* control characters */
+	cc_t c_line;			/* line discipline (=3D=3D c_cc[19]) */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* Alpha has matching termios and ktermios */
=20
 struct ktermios {
@@ -147,6 +160,7 @@ struct ktermios {
 #define B3000000  00034
 #define B3500000  00035
 #define B4000000  00036
+#define BOTHER    00037
=20
 #define CSIZE	00001400
 #define   CS5	00000000
@@ -164,6 +178,9 @@ struct ktermios {
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
=20
+#define CIBAUD	07600000
+#define IBSHIFT	16
+
 /* c_lflag bits */
 #define ISIG	0x00000080
 #define ICANON	0x00000100
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/ex=
ynos4210-origen.dts
index f767c425d0b5..90e8eb16ba5f 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -115,6 +115,8 @@
 			reg =3D <0x66>;
 			interrupt-parent =3D <&gpx0>;
 			interrupts =3D <4 0>, <3 0>;
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&max8997_irq>;
=20
 			max8997,pmic-buck1-dvs-voltage =3D <1350000>;
 			max8997,pmic-buck2-dvs-voltage =3D <1100000>;
@@ -334,3 +336,10 @@
 		};
 	};
 };
+
+&pinctrl_1 {
+	max8997_irq: max8997-irq {
+		samsung,pins =3D "gpx0-3", "gpx0-4";
+		samsung,pin-pud =3D <0>;
+	};
+};
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 75d95799b6e6..3ff5d9a26eee 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -172,7 +172,7 @@ extern int __put_user_8(void *, unsigned long long);
 	({								\
 		unsigned long __limit =3D current_thread_info()->addr_limit - 1; \
 		const typeof(*(p)) __user *__tmp_p =3D (p);		\
-		register const typeof(*(p)) __r2 asm("r2") =3D (x);	\
+		register typeof(*(p)) __r2 asm("r2") =3D (x);	\
 		register const typeof(*(p)) __user *__p asm("r0") =3D __tmp_p; \
 		register unsigned long __l asm("r1") =3D __limit;		\
 		register int __e asm("r0");				\
diff --git a/arch/arm/mach-mmp/include/mach/cputype.h b/arch/arm/mach-mmp/i=
nclude/mach/cputype.h
index 8a3b56dfd35d..8f94addd9bce 100644
--- a/arch/arm/mach-mmp/include/mach/cputype.h
+++ b/arch/arm/mach-mmp/include/mach/cputype.h
@@ -43,10 +43,12 @@ static inline int cpu_is_pxa910(void)
 #define cpu_is_pxa910()	(0)
 #endif
=20
-#ifdef CONFIG_CPU_MMP2
+#if defined(CONFIG_CPU_MMP2) || defined(CONFIG_MACH_MMP2_DT)
 static inline int cpu_is_mmp2(void)
 {
-	return (((read_cpuid_id() >> 8) & 0xff) =3D=3D 0x58);
+	return (((read_cpuid_id() >> 8) & 0xff) =3D=3D 0x58) &&
+		(((mmp_chip_id & 0xfff) =3D=3D 0x410) ||
+		 ((mmp_chip_id & 0xfff) =3D=3D 0x610));
 }
 #else
 #define cpu_is_mmp2()	(0)
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/bo=
ard-ams-delta.c
index 2aab761ee68d..a5e9a80077a9 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -511,6 +511,9 @@ static void modem_pm(struct uart_port *port, unsigned i=
nt state, unsigned old)
 {
 	struct modem_private_data *priv =3D port->private_data;
=20
+	if (!priv)
+		return;
+
 	if (IS_ERR(priv->regulator))
 		return;
=20
diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscal=
l.h
index 1c7e4526cbf3..324f099b2b50 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -57,7 +57,7 @@ static inline unsigned long mips_get_syscall_arg(unsigned=
 long *arg,
 #ifdef CONFIG_64BIT
 	case 4: case 5: case 6: case 7:
 #ifdef CONFIG_MIPS32_O32
-		if (test_thread_flag(TIF_32BIT_REGS))
+		if (test_tsk_thread_flag(task, TIF_32BIT_REGS))
 			return get_user(*arg, (int *)usp + n);
 		else
 #endif
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index e8f07dd28401..d4f4540414c1 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -176,7 +176,7 @@
 	bv,n	0(%r3)
 	nop
 	.word	0		/* checksum (will be patched) */
-	.word	PA(os_hpmc)	/* address of handler */
+	.word	0		/* address of handler */
 	.word	0		/* length of handler */
 	.endm
=20
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index 05aab1333dfa..9b9233523415 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -833,7 +833,8 @@ int __init check_ivt(void *iva)
 	for (i =3D 0; i < 8; i++)
 	    *ivap++ =3D 0;
=20
-	/* Compute Checksum for HPMC handler */
+	/* Setup IVA and compute checksum for HPMC handler */
+	ivap[6] =3D (u32)__pa(os_hpmc);
 	length =3D os_hpmc_size;
 	ivap[7] =3D length;
=20
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 0bef864264c0..6417a31facda 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -492,12 +492,8 @@ static void __init map_pages(unsigned long start_vaddr,
 #endif
 					pte =3D __mk_pte(address, pgprot);
=20
-				if (address >=3D end_paddr) {
-					if (force)
-						break;
-					else
-						pte_val(pte) =3D 0;
-				}
+				if (address >=3D end_paddr)
+					break;
=20
 				set_pte(pg_table, pte);
=20
diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index 14de4f8778a7..38e90750672d 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -15,7 +15,7 @@
 RELA =3D 7
 RELACOUNT =3D 0x6ffffff9
=20
-	.text
+	.data
 	/* A procedure descriptor used when booting this as a COFF file.
 	 * When making COFF, this comes first in the link and we're
 	 * linked at 0x500000.
@@ -23,6 +23,8 @@ RELACOUNT =3D 0x6ffffff9
 	.globl	_zimage_start_opd
 _zimage_start_opd:
 	.long	0x500000, 0, 0, 0
+	.text
+	b	_zimage_start
=20
 #ifdef __powerpc64__
 .balign 8
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/=
pseries/dtl.c
index 7d61498e45c0..36895f6de163 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -149,7 +149,7 @@ static int dtl_start(struct dtl *dtl)
=20
 	/* Register our dtl buffer with the hypervisor. The HV expects the
 	 * buffer size to be passed in the second word of the buffer */
-	((u32 *)dtl->buf)[1] =3D DISPATCH_LOG_BYTES;
+	((u32 *)dtl->buf)[1] =3D cpu_to_be32(DISPATCH_LOG_BYTES);
=20
 	hwcpu =3D get_hard_smp_processor_id(dtl->cpu);
 	addr =3D __pa(dtl->buf);
@@ -184,7 +184,7 @@ static void dtl_stop(struct dtl *dtl)
=20
 static u64 dtl_current_index(struct dtl *dtl)
 {
-	return lppaca_of(dtl->cpu).dtl_idx;
+	return be64_to_cpu(lppaca_of(dtl->cpu).dtl_idx);
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
=20
diff --git a/arch/s390/hypfs/hypfs_vm.c b/arch/s390/hypfs/hypfs_vm.c
index 32040ace00ea..afbe07907c10 100644
--- a/arch/s390/hypfs/hypfs_vm.c
+++ b/arch/s390/hypfs/hypfs_vm.c
@@ -231,7 +231,7 @@ int hypfs_vm_create_files(struct dentry *root)
 struct dbfs_d2fc_hdr {
 	u64	len;		/* Length of d2fc buffer without header */
 	u16	version;	/* Version of header */
-	char	tod_ext[16];	/* TOD clock for d2fc */
+	char	tod_ext[STORE_CLOCK_EXT_SIZE]; /* TOD clock for d2fc */
 	u64	count;		/* Number of VM guests in d2fc buffer */
 	char	reserved[30];
 } __attribute__ ((packed));
diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 8beee1cceba4..98eb2a579223 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -67,20 +67,22 @@ static inline void local_tick_enable(unsigned long long=
 comp)
 	set_clock_comparator(S390_lowcore.clock_comparator);
 }
=20
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
+#define CLOCK_TICK_RATE		1193180 /* Underlying HZ */
+#define STORE_CLOCK_EXT_SIZE	16	/* stcke writes 16 bytes */
=20
 typedef unsigned long long cycles_t;
=20
-static inline void get_tod_clock_ext(char clk[16])
+static inline void get_tod_clock_ext(char *clk)
 {
-	typedef struct { char _[sizeof(clk)]; } addrtype;
+	typedef struct { char _[STORE_CLOCK_EXT_SIZE]; } addrtype;
=20
 	asm volatile("stcke %0" : "=3DQ" (*(addrtype *) clk) : : "cc");
 }
=20
 static inline unsigned long long get_tod_clock(void)
 {
-	unsigned char clk[16];
+	unsigned char clk[STORE_CLOCK_EXT_SIZE];
+
 	get_tod_clock_ext(clk);
 	return *((unsigned long long *)&clk[1]);
 }
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 8492291424ab..d6ab14c2353d 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -89,7 +89,7 @@ asmlinkage void do_sigreturn(struct pt_regs *regs)
 	sf =3D (struct signal_frame __user *) regs->u_regs[UREG_FP];
=20
 	/* 1. Make sure we are not getting garbage from the user */
-	if (!invalid_frame_pointer(sf, sizeof(*sf)))
+	if (invalid_frame_pointer(sf, sizeof(*sf)))
 		goto segv_and_exit;
=20
 	if (get_user(ufp, &sf->info.si_regs.u_regs[UREG_FP]))
@@ -150,7 +150,7 @@ asmlinkage void do_rt_sigreturn(struct pt_regs *regs)
=20
 	synchronize_user_stack();
 	sf =3D (struct rt_signal_frame __user *) regs->u_regs[UREG_FP];
-	if (!invalid_frame_pointer(sf, sizeof(*sf)))
+	if (invalid_frame_pointer(sf, sizeof(*sf)))
 		goto segv;
=20
 	if (get_user(ufp, &sf->regs.u_regs[UREG_FP]))
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/proces=
s.c
index 908579f2b0ab..258e741f61a8 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -694,6 +694,11 @@ int start_idle_thread(void *stack, jmp_buf *switch_buf)
 		fatal_sigsegv();
 	}
 	longjmp(*switch_buf, 1);
+
+	/* unreachable */
+	printk(UM_KERN_ERR "impossible long jump!");
+	fatal_sigsegv();
+	return 0;
 }
=20
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index f673f92596fa..43e37404178b 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -23,7 +23,6 @@
 #include <stdarg.h>
 #include <linux/types.h>
 #include <linux/edd.h>
-#include <asm/boot.h>
 #include <asm/setup.h>
 #include "bitops.h"
 #include "ctype.h"
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eb=
oot.c
index a1f905ca1c48..b5577acef092 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -13,8 +13,7 @@
 #include <asm/setup.h>
 #include <asm/desc.h>
=20
-#undef memcpy			/* Use memcpy from misc.c */
-
+#include "../string.h"
 #include "eboot.h"
=20
 static efi_system_table_t *sys_table;
diff --git a/arch/x86/boot/video-mode.c b/arch/x86/boot/video-mode.c
index 748e8d06290a..a0bb0ada348d 100644
--- a/arch/x86/boot/video-mode.c
+++ b/arch/x86/boot/video-mode.c
@@ -19,6 +19,8 @@
 #include "video.h"
 #include "vesa.h"
=20
+#include <uapi/asm/boot.h>
+
 /*
  * Common variables
  */
diff --git a/arch/x86/boot/video.c b/arch/x86/boot/video.c
index 43eda284d27f..ef69e889bab1 100644
--- a/arch/x86/boot/video.c
+++ b/arch/x86/boot/video.c
@@ -13,6 +13,8 @@
  * Select video mode
  */
=20
+#include <uapi/asm/boot.h>
+
 #include "boot.h"
 #include "video.h"
 #include "vesa.h"
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index f695719a41bd..24e6e92cef86 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -711,8 +711,6 @@ struct kvm_x86_ops {
 	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
 	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
 	void (*set_rflags)(struct kvm_vcpu *vcpu, unsigned long rflags);
-	void (*fpu_activate)(struct kvm_vcpu *vcpu);
-	void (*fpu_deactivate)(struct kvm_vcpu *vcpu);
=20
 	void (*tlb_flush)(struct kvm_vcpu *vcpu);
=20
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/pa=
ge_64_types.h
index 75450b2c7be4..c708f8f9fb56 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -20,9 +20,6 @@
 #define MCE_STACK 4
 #define N_EXCEPTION_STACKS 4  /* hw limit: 7 */
=20
-#define PUD_PAGE_SIZE		(_AC(1, UL) << PUD_SHIFT)
-#define PUD_PAGE_MASK		(~(PUD_PAGE_SIZE-1))
-
 /*
  * Set __PAGE_OFFSET to the most negative possible address +
  * PGDIR_SIZE*16 (pgd slot 272).  The gap is to allow a space for a
diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_=
types.h
index f97fbe3abb67..9d0de079af48 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -9,16 +9,21 @@
 #define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
=20
+#define PMD_PAGE_SIZE		(_AC(1, UL) << PMD_SHIFT)
+#define PMD_PAGE_MASK		(~(PMD_PAGE_SIZE-1))
+
+#define PUD_PAGE_SIZE		(_AC(1, UL) << PUD_SHIFT)
+#define PUD_PAGE_MASK		(~(PUD_PAGE_SIZE-1))
+
 #define __PHYSICAL_MASK		((phys_addr_t)((1ULL << __PHYSICAL_MASK_SHIFT) - =
1))
 #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
=20
-/* Cast PAGE_MASK to a signed type so that it is sign-extended if
+/* Cast *PAGE_MASK to a signed type so that it is sign-extended if
    virtual addresses are 32-bits but physical addresses are larger
    (ie, 32-bit PAE). */
 #define PHYSICAL_PAGE_MASK	(((signed long)PAGE_MASK) & __PHYSICAL_MASK)
-
-#define PMD_PAGE_SIZE		(_AC(1, UL) << PMD_SHIFT)
-#define PMD_PAGE_MASK		(~(PMD_PAGE_SIZE-1))
+#define PHYSICAL_PMD_PAGE_MASK	(((signed long)PMD_PAGE_MASK) & __PHYSICAL_=
MASK)
+#define PHYSICAL_PUD_PAGE_MASK	(((signed long)PUD_PAGE_MASK) & __PHYSICAL_=
MASK)
=20
 #define HPAGE_SHIFT		PMD_SHIFT
 #define HPAGE_SIZE		(_AC(1,UL) << HPAGE_SHIFT)
diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/p=
gtable-3level.h
index 5c686382d84b..095dbc25122a 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_X86_PGTABLE_3LEVEL_H
 #define _ASM_X86_PGTABLE_3LEVEL_H
=20
+#include <asm/atomic64_32.h>
+
 /*
  * Intel Physical Address Extension (PAE) Mode - three-level page
  * tables on PPro+ CPUs.
@@ -142,10 +144,7 @@ static inline pte_t native_ptep_get_and_clear(pte_t *p=
tep)
 {
 	pte_t res;
=20
-	/* xchg acts as a barrier before the setting of the high bits */
-	res.pte_low =3D xchg(&ptep->pte_low, 0);
-	res.pte_high =3D ptep->pte_high;
-	ptep->pte_high =3D 0;
+	res.pte =3D (pteval_t)atomic64_xchg((atomic64_t *)ptep, 0);
=20
 	return res;
 }
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5a102146341b..f8dad5a0bc84 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -156,14 +156,19 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
 {
 	phys_addr_t pfn =3D pmd_val(pmd);
 	pfn ^=3D protnone_mask(pfn);
-	return (pfn & PTE_PFN_MASK) >> PAGE_SHIFT;
+	return (pfn & pmd_pfn_mask(pmd)) >> PAGE_SHIFT;
 }
=20
 static inline unsigned long pud_pfn(pud_t pud)
 {
 	phys_addr_t pfn =3D pud_val(pud);
 	pfn ^=3D protnone_mask(pfn);
-	return (pfn & PTE_PFN_MASK) >> PAGE_SHIFT;
+	return (pfn & pud_pfn_mask(pud)) >> PAGE_SHIFT;
+}
+
+static inline unsigned long pgd_pfn(pgd_t pgd)
+{
+	return (pgd_val(pgd) & PTE_PFN_MASK) >> PAGE_SHIFT;
 }
=20
 #define pte_page(pte)	pfn_to_page(pte_pfn(pte))
@@ -584,14 +589,14 @@ static inline int pmd_none(pmd_t pmd)
=20
 static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 {
-	return (unsigned long)__va(pmd_val(pmd) & PTE_PFN_MASK);
+	return (unsigned long)__va(pmd_val(pmd) & pmd_pfn_mask(pmd));
 }
=20
 /*
  * Currently stuck as a macro due to indirect forward reference to
  * linux/mmzone.h's __section_mem_map_addr() definition:
  */
-#define pmd_page(pmd)	pfn_to_page((pmd_val(pmd) & PTE_PFN_MASK) >> PAGE_SH=
IFT)
+#define pmd_page(pmd)	pfn_to_page(pmd_pfn(pmd))
=20
 /*
  * the pmd page can be thought of an array like this: pmd_t[PTRS_PER_PMD]
@@ -657,14 +662,14 @@ static inline int pud_present(pud_t pud)
=20
 static inline unsigned long pud_page_vaddr(pud_t pud)
 {
-	return (unsigned long)__va((unsigned long)pud_val(pud) & PTE_PFN_MASK);
+	return (unsigned long)__va(pud_val(pud) & pud_pfn_mask(pud));
 }
=20
 /*
  * Currently stuck as a macro due to indirect forward reference to
  * linux/mmzone.h's __section_mem_map_addr() definition:
  */
-#define pud_page(pud)		pfn_to_page(pud_val(pud) >> PAGE_SHIFT)
+#define pud_page(pud)	pfn_to_page(pud_pfn(pud))
=20
 /* Find an entry in the second-level page table.. */
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
@@ -704,7 +709,7 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
  * Currently stuck as a macro due to indirect forward reference to
  * linux/mmzone.h's __section_mem_map_addr() definition:
  */
-#define pgd_page(pgd)		pfn_to_page(pgd_val(pgd) >> PAGE_SHIFT)
+#define pgd_page(pgd)		pfn_to_page(pgd_pfn(pgd))
=20
 /* to find an entry in a page-table-directory. */
 static inline unsigned long pud_index(unsigned long address)
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pg=
table_types.h
index 32f1f8cac398..562f2d516d29 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -257,10 +257,10 @@
=20
 #include <linux/types.h>
=20
-/* PTE_PFN_MASK extracts the PFN from a (pte|pmd|pud|pgd)val_t */
+/* Extracts the PFN from a (pte|pmd|pud|pgd)val_t of a 4KB page */
 #define PTE_PFN_MASK		((pteval_t)PHYSICAL_PAGE_MASK)
=20
-/* PTE_FLAGS_MASK extracts the flags from a (pte|pmd|pud|pgd)val_t */
+/* Extracts the flags from a (pte|pmd|pud|pgd)val_t of a 4KB page */
 #define PTE_FLAGS_MASK		(~PTE_PFN_MASK)
=20
 typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
@@ -329,14 +329,40 @@ static inline pmdval_t native_pmd_val(pmd_t pmd)
 }
 #endif
=20
+static inline pudval_t pud_pfn_mask(pud_t pud)
+{
+	if (native_pud_val(pud) & _PAGE_PSE)
+		return PHYSICAL_PUD_PAGE_MASK;
+	else
+		return PTE_PFN_MASK;
+}
+
+static inline pudval_t pud_flags_mask(pud_t pud)
+{
+	return ~pud_pfn_mask(pud);
+}
+
 static inline pudval_t pud_flags(pud_t pud)
 {
-	return native_pud_val(pud) & PTE_FLAGS_MASK;
+	return native_pud_val(pud) & pud_flags_mask(pud);
+}
+
+static inline pmdval_t pmd_pfn_mask(pmd_t pmd)
+{
+	if (native_pmd_val(pmd) & _PAGE_PSE)
+		return PHYSICAL_PMD_PAGE_MASK;
+	else
+		return PTE_PFN_MASK;
+}
+
+static inline pmdval_t pmd_flags_mask(pmd_t pmd)
+{
+	return ~pmd_pfn_mask(pmd);
 }
=20
 static inline pmdval_t pmd_flags(pmd_t pmd)
 {
-	return native_pmd_val(pmd) & PTE_FLAGS_MASK;
+	return native_pmd_val(pmd) & pmd_flags_mask(pmd);
 }
=20
 static inline pte_t native_make_pte(pteval_t val)
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_ini=
t.h
index e45e4da96bf1..c77cbb595724 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -1,7 +1,6 @@
 #ifndef _ASM_X86_PLATFORM_H
 #define _ASM_X86_PLATFORM_H
=20
-#include <asm/pgtable_types.h>
 #include <asm/bootparam.h>
=20
 struct mpc_bus;
diff --git a/arch/x86/include/uapi/asm/msr-index.h b/arch/x86/include/uapi/=
asm/msr-index.h
index bde8fb38d06e..c0e06e5e47a0 100644
--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -236,6 +236,7 @@
 #define MSR_F15H_PERF_CTR		0xc0010201
 #define MSR_F15H_NB_PERF_CTL		0xc0010240
 #define MSR_F15H_NB_PERF_CTR		0xc0010241
+#define MSR_F15H_EX_CFG			0xc001102c
=20
 /* Fam 10h MSRs */
 #define MSR_FAM10H_MMIO_CONF_BASE	0xc0010058
diff --git a/arch/x86/kernel/check.c b/arch/x86/kernel/check.c
index 83a7995625a6..2c989db325e4 100644
--- a/arch/x86/kernel/check.c
+++ b/arch/x86/kernel/check.c
@@ -30,6 +30,11 @@ static __init int set_corruption_check(char *arg)
 	ssize_t ret;
 	unsigned long val;
=20
+	if (!arg) {
+		pr_err("memory_corruption_check config string not provided\n");
+		return -EINVAL;
+	}
+
 	ret =3D kstrtoul(arg, 10, &val);
 	if (ret)
 		return ret;
@@ -44,6 +49,11 @@ static __init int set_corruption_check_period(char *arg)
 	ssize_t ret;
 	unsigned long val;
=20
+	if (!arg) {
+		pr_err("memory_corruption_check_period config string not provided\n");
+		return -EINVAL;
+	}
+
 	ret =3D kstrtoul(arg, 10, &val);
 	if (ret)
 		return ret;
@@ -58,6 +68,11 @@ static __init int set_corruption_check_size(char *arg)
 	char *end;
 	unsigned size;
=20
+	if (!arg) {
+		pr_err("memory_corruption_check_size config string not provided\n");
+		return -EINVAL;
+	}
+
 	size =3D memparse(arg, &end);
=20
 	if (*end =3D=3D '\0')
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 939155ffdece..ffef5852fe4e 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -18,6 +18,7 @@
 #include <linux/efi.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/i8253.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv.h>
@@ -143,6 +144,16 @@ static void __init ms_hyperv_init_platform(void)
 	no_timer_check =3D 1;
 #endif
=20
+	/*
+	 * Hyper-V VMs have a PIT emulation quirk such that zeroing the
+	 * counter register during PIT shutdown restarts the PIT. So it
+	 * continues to interrupt @18.2 HZ. Setting i8253_clear_counter
+	 * to false tells pit_shutdown() not to zero the counter so that
+	 * the PIT really is shutdown. Generation 2 VMs don't have a PIT,
+	 * and setting this value has no effect.
+	 */
+	i8253_clear_counter_on_shutdown =3D false;
+
 }
=20
 const __refconst struct hypervisor_x86 x86_hyper_ms_hyperv =3D {
diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index a041e094b8b9..5598de02d2b4 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -173,6 +173,8 @@ mtrr_ioctl(struct file *file, unsigned int cmd, unsigne=
d long __arg)
 	struct mtrr_gentry gentry;
 	void __user *arg =3D (void __user *) __arg;
=20
+	memset(&gentry, 0, sizeof(gentry));
+
 	switch (cmd) {
 	case MTRRIOC_ADD_ENTRY:
 	case MTRRIOC_SET_ENTRY:
diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
index 7d299ff294fb..e8c8c5d78dbd 100644
--- a/arch/x86/kernel/eisa.c
+++ b/arch/x86/kernel/eisa.c
@@ -5,6 +5,7 @@
  */
 #include <linux/ioport.h>
 #include <linux/eisa.h>
+#include <linux/io.h>
=20
 #include <xen/xen.h>
=20
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 464c49cdbbb9..d3e36b45befb 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1234,7 +1234,7 @@ void __init setup_arch(char **cmdline_p)
 	kvm_guest_init();
=20
 	e820_reserve_resources();
-	e820_mark_nosave_regions(max_low_pfn);
+	e820_mark_nosave_regions(max_pfn);
=20
 	x86_init.resources.reserve_resources();
=20
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index a2da841d3792..c81ccc0d8da0 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3926,9 +3926,9 @@ static void mmu_pte_write_flush_tlb(struct kvm_vcpu *=
vcpu, bool zap_page,
 }
=20
 static u64 mmu_pte_write_fetch_gpte(struct kvm_vcpu *vcpu, gpa_t *gpa,
-				    const u8 *new, int *bytes)
+				    int *bytes)
 {
-	u64 gentry;
+	u64 gentry =3D 0;
 	int r;
=20
 	/*
@@ -3940,22 +3940,12 @@ static u64 mmu_pte_write_fetch_gpte(struct kvm_vcpu=
 *vcpu, gpa_t *gpa,
 		/* Handle a 32-bit guest writing two halves of a 64-bit gpte */
 		*gpa &=3D ~(gpa_t)7;
 		*bytes =3D 8;
-		r =3D kvm_read_guest(vcpu->kvm, *gpa, &gentry, 8);
-		if (r)
-			gentry =3D 0;
-		new =3D (const u8 *)&gentry;
 	}
=20
-	switch (*bytes) {
-	case 4:
-		gentry =3D *(const u32 *)new;
-		break;
-	case 8:
-		gentry =3D *(const u64 *)new;
-		break;
-	default:
-		gentry =3D 0;
-		break;
+	if (*bytes =3D=3D 4 || *bytes =3D=3D 8) {
+		r =3D kvm_read_guest_atomic(vcpu->kvm, *gpa, &gentry, *bytes);
+		if (r)
+			gentry =3D 0;
 	}
=20
 	return gentry;
@@ -4064,8 +4054,6 @@ void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t g=
pa,
=20
 	pgprintk("%s: gpa %llx bytes %d\n", __func__, gpa, bytes);
=20
-	gentry =3D mmu_pte_write_fetch_gpte(vcpu, &gpa, new, &bytes);
-
 	/*
 	 * No need to care whether allocation memory is successful
 	 * or not since pte prefetch is skiped if it does not have
@@ -4074,6 +4062,9 @@ void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t g=
pa,
 	mmu_topup_memory_caches(vcpu);
=20
 	spin_lock(&vcpu->kvm->mmu_lock);
+
+	gentry =3D mmu_pte_write_fetch_gpte(vcpu, &gpa, &bytes);
+
 	++vcpu->kvm->stat.mmu_pte_write;
 	kvm_mmu_audit(vcpu, AUDIT_PRE_PTE_WRITE);
=20
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 481661815246..69012e84e229 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1119,7 +1119,6 @@ static void init_vmcb(struct vcpu_svm *svm)
 	struct vmcb_control_area *control =3D &svm->vmcb->control;
 	struct vmcb_save_area *save =3D &svm->vmcb->save;
=20
-	svm->vcpu.fpu_active =3D 1;
 	svm->vcpu.arch.hflags =3D 0;
=20
 	set_cr_intercept(svm, INTERCEPT_CR0_READ);
@@ -1318,21 +1317,31 @@ static struct kvm_vcpu *svm_create_vcpu(struct kvm =
*kvm, unsigned int id)
 	return ERR_PTR(err);
 }
=20
+static void svm_clear_current_vmcb(struct vmcb *vmcb)
+{
+	int i;
+
+	for_each_online_cpu(i)
+		cmpxchg(&per_cpu(svm_data, i)->current_vmcb, vmcb, NULL);
+}
+
 static void svm_free_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm =3D to_svm(vcpu);
=20
+	/*
+	 * The vmcb page can be recycled, causing a false negative in
+	 * svm_vcpu_load(). So, ensure that no logical CPU has this
+	 * vmcb page recorded as its current vmcb.
+	 */
+	svm_clear_current_vmcb(svm->vmcb);
+
 	__free_page(pfn_to_page(svm->vmcb_pa >> PAGE_SHIFT));
 	__free_pages(virt_to_page(svm->msrpm), MSRPM_ALLOC_ORDER);
 	__free_page(virt_to_page(svm->nested.hsave));
 	__free_pages(virt_to_page(svm->nested.msrpm), MSRPM_ALLOC_ORDER);
 	kvm_vcpu_uninit(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, svm);
-	/*
-	 * The vmcb page can be recycled, causing a false negative in
-	 * svm_vcpu_load(). So do a full IBPB now.
-	 */
-	indirect_branch_prediction_barrier();
 }
=20
 static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
@@ -1574,15 +1583,12 @@ static void update_cr0_intercept(struct vcpu_svm *s=
vm)
 	ulong gcr0 =3D svm->vcpu.arch.cr0;
 	u64 *hcr0 =3D &svm->vmcb->save.cr0;
=20
-	if (!svm->vcpu.fpu_active)
-		*hcr0 |=3D SVM_CR0_SELECTIVE_MASK;
-	else
-		*hcr0 =3D (*hcr0 & ~SVM_CR0_SELECTIVE_MASK)
-			| (gcr0 & SVM_CR0_SELECTIVE_MASK);
+	*hcr0 =3D (*hcr0 & ~SVM_CR0_SELECTIVE_MASK)
+		| (gcr0 & SVM_CR0_SELECTIVE_MASK);
=20
 	mark_dirty(svm->vmcb, VMCB_CR);
=20
-	if (gcr0 =3D=3D *hcr0 && svm->vcpu.fpu_active) {
+	if (gcr0 =3D=3D *hcr0) {
 		clr_cr_intercept(svm, INTERCEPT_CR0_READ);
 		clr_cr_intercept(svm, INTERCEPT_CR0_WRITE);
 	} else {
@@ -1613,8 +1619,6 @@ static void svm_set_cr0(struct kvm_vcpu *vcpu, unsign=
ed long cr0)
 	if (!npt_enabled)
 		cr0 |=3D X86_CR0_PG | X86_CR0_WP;
=20
-	if (!vcpu->fpu_active)
-		cr0 |=3D X86_CR0_TS;
 	/*
 	 * re-enable caching here because the QEMU bios
 	 * does not do it - this results in some delay at
@@ -1834,22 +1838,6 @@ static int ac_interception(struct vcpu_svm *svm)
 	return 1;
 }
=20
-static void svm_fpu_activate(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm =3D to_svm(vcpu);
-
-	clr_exception_intercept(svm, NM_VECTOR);
-
-	svm->vcpu.fpu_active =3D 1;
-	update_cr0_intercept(svm);
-}
-
-static int nm_interception(struct vcpu_svm *svm)
-{
-	svm_fpu_activate(&svm->vcpu);
-	return 1;
-}
-
 static bool is_erratum_383(void)
 {
 	int err, i;
@@ -2227,9 +2215,6 @@ static int nested_svm_exit_special(struct vcpu_svm *s=
vm)
 		if (!npt_enabled && svm->apf_reason =3D=3D 0)
 			return NESTED_EXIT_HOST;
 		break;
-	case SVM_EXIT_EXCP_BASE + NM_VECTOR:
-		nm_interception(svm);
-		break;
 	default:
 		break;
 	}
@@ -3448,7 +3433,6 @@ static int (*const svm_exit_handlers[])(struct vcpu_s=
vm *svm) =3D {
 	[SVM_EXIT_EXCP_BASE + BP_VECTOR]	=3D bp_interception,
 	[SVM_EXIT_EXCP_BASE + UD_VECTOR]	=3D ud_interception,
 	[SVM_EXIT_EXCP_BASE + PF_VECTOR]	=3D pf_interception,
-	[SVM_EXIT_EXCP_BASE + NM_VECTOR]	=3D nm_interception,
 	[SVM_EXIT_EXCP_BASE + MC_VECTOR]	=3D mc_interception,
 	[SVM_EXIT_EXCP_BASE + AC_VECTOR]	=3D ac_interception,
 	[SVM_EXIT_INTR]				=3D intr_interception,
@@ -4285,14 +4269,6 @@ static bool svm_has_wbinvd_exit(void)
 	return true;
 }
=20
-static void svm_fpu_deactivate(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm =3D to_svm(vcpu);
-
-	set_exception_intercept(svm, NM_VECTOR);
-	update_cr0_intercept(svm);
-}
-
 #define PRE_EX(exit)  { .exit_code =3D (exit), \
 			.stage =3D X86_ICPT_PRE_EXCEPT, }
 #define POST_EX(exit) { .exit_code =3D (exit), \
@@ -4526,8 +4502,6 @@ static struct kvm_x86_ops svm_x86_ops =3D {
 	.cache_reg =3D svm_cache_reg,
 	.get_rflags =3D svm_get_rflags,
 	.set_rflags =3D svm_set_rflags,
-	.fpu_activate =3D svm_fpu_activate,
-	.fpu_deactivate =3D svm_fpu_deactivate,
=20
 	.tlb_flush =3D svm_flush_tlb,
=20
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index f931787e067b..d3f1873eafc4 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -847,13 +847,6 @@ static inline bool is_page_fault(u32 intr_info)
 		(INTR_TYPE_HARD_EXCEPTION | PF_VECTOR | INTR_INFO_VALID_MASK);
 }
=20
-static inline bool is_no_device(u32 intr_info)
-{
-	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK |
-			     INTR_INFO_VALID_MASK)) =3D=3D
-		(INTR_TYPE_HARD_EXCEPTION | NM_VECTOR | INTR_INFO_VALID_MASK);
-}
-
 static inline bool is_invalid_opcode(u32 intr_info)
 {
 	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK |
@@ -1491,7 +1484,7 @@ static void update_exception_bitmap(struct kvm_vcpu *=
vcpu)
 	u32 eb;
=20
 	eb =3D (1u << PF_VECTOR) | (1u << UD_VECTOR) | (1u << MC_VECTOR) |
-	     (1u << NM_VECTOR) | (1u << DB_VECTOR) | (1u << AC_VECTOR);
+	     (1u << DB_VECTOR) | (1u << AC_VECTOR);
 	if ((vcpu->guest_debug &
 	     (KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP)) =3D=3D
 	    (KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP))
@@ -1500,8 +1493,6 @@ static void update_exception_bitmap(struct kvm_vcpu *=
vcpu)
 		eb =3D ~0;
 	if (enable_ept)
 		eb &=3D ~(1u << PF_VECTOR); /* bypass_guest_pf =3D 0 */
-	if (vcpu->fpu_active)
-		eb &=3D ~(1u << NM_VECTOR);
=20
 	/* When we are running a nested L2 guest and L1 specified for it a
 	 * certain exception bitmap, we must trap the same exceptions and pass
@@ -1904,25 +1895,6 @@ static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
 	}
 }
=20
-static void vmx_fpu_activate(struct kvm_vcpu *vcpu)
-{
-	ulong cr0;
-
-	if (vcpu->fpu_active)
-		return;
-	vcpu->fpu_active =3D 1;
-	cr0 =3D vmcs_readl(GUEST_CR0);
-	cr0 &=3D ~(X86_CR0_TS | X86_CR0_MP);
-	cr0 |=3D kvm_read_cr0_bits(vcpu, X86_CR0_TS | X86_CR0_MP);
-	vmcs_writel(GUEST_CR0, cr0);
-	update_exception_bitmap(vcpu);
-	vcpu->arch.cr0_guest_owned_bits =3D X86_CR0_TS;
-	if (is_guest_mode(vcpu))
-		vcpu->arch.cr0_guest_owned_bits &=3D
-			~get_vmcs12(vcpu)->cr0_guest_host_mask;
-	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
-}
-
 static void vmx_decache_cr0_guest_bits(struct kvm_vcpu *vcpu);
=20
 /*
@@ -1941,33 +1913,6 @@ static inline unsigned long nested_read_cr4(struct v=
mcs12 *fields)
 		(fields->cr4_read_shadow & fields->cr4_guest_host_mask);
 }
=20
-static void vmx_fpu_deactivate(struct kvm_vcpu *vcpu)
-{
-	/* Note that there is no vcpu->fpu_active =3D 0 here. The caller must
-	 * set this *before* calling this function.
-	 */
-	vmx_decache_cr0_guest_bits(vcpu);
-	vmcs_set_bits(GUEST_CR0, X86_CR0_TS | X86_CR0_MP);
-	update_exception_bitmap(vcpu);
-	vcpu->arch.cr0_guest_owned_bits =3D 0;
-	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
-	if (is_guest_mode(vcpu)) {
-		/*
-		 * L1's specified read shadow might not contain the TS bit,
-		 * so now that we turned on shadowing of this bit, we need to
-		 * set this bit of the shadow. Like in nested_vmx_run we need
-		 * nested_read_cr0(vmcs12), but vmcs12->guest_cr0 is not yet
-		 * up-to-date here because we just decached cr0.TS (and we'll
-		 * only update vmcs12->guest_cr0 on nested exit).
-		 */
-		struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);
-		vmcs12->guest_cr0 =3D (vmcs12->guest_cr0 & ~X86_CR0_TS) |
-			(vcpu->arch.cr0 & X86_CR0_TS);
-		vmcs_writel(CR0_READ_SHADOW, nested_read_cr0(vmcs12));
-	} else
-		vmcs_writel(CR0_READ_SHADOW, vcpu->arch.cr0);
-}
-
 static unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
 {
 	unsigned long rflags, save_rflags;
@@ -3586,9 +3531,6 @@ static void vmx_set_cr0(struct kvm_vcpu *vcpu, unsign=
ed long cr0)
 	if (enable_ept)
 		ept_update_paging_mode_cr0(&hw_cr0, cr0, vcpu);
=20
-	if (!vcpu->fpu_active)
-		hw_cr0 |=3D X86_CR0_TS | X86_CR0_MP;
-
 	vmcs_writel(CR0_READ_SHADOW, cr0);
 	vmcs_writel(GUEST_CR0, hw_cr0);
 	vcpu->arch.cr0 =3D cr0;
@@ -4644,7 +4586,9 @@ static int vmx_vcpu_setup(struct vcpu_vmx *vmx)
 	/* 22.2.1, 20.8.1 */
 	vm_entry_controls_init(vmx, vmcs_config.vmentry_ctrl);
=20
-	vmcs_writel(CR0_GUEST_HOST_MASK, ~0UL);
+	vmx->vcpu.arch.cr0_guest_owned_bits =3D X86_CR0_TS;
+	vmcs_writel(CR0_GUEST_HOST_MASK, ~X86_CR0_TS);
+
 	set_cr4_guest_host_mask(vmx);
=20
 	return 0;
@@ -4736,7 +4680,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu)
 	vmx_set_cr0(&vmx->vcpu, kvm_read_cr0(vcpu)); /* enter rmode */
 	vmx_set_cr4(&vmx->vcpu, 0);
 	vmx_set_efer(&vmx->vcpu, 0);
-	vmx_fpu_activate(&vmx->vcpu);
+
 	update_exception_bitmap(&vmx->vcpu);
=20
 	vpid_sync_context(vmx);
@@ -5022,11 +4966,6 @@ static int handle_exception(struct kvm_vcpu *vcpu)
 	if (is_nmi(intr_info))
 		return 1;  /* already handled by vmx_vcpu_run() */
=20
-	if (is_no_device(intr_info)) {
-		vmx_fpu_activate(vcpu);
-		return 1;
-	}
-
 	if (is_invalid_opcode(intr_info)) {
 		er =3D emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
 		if (er =3D=3D EMULATE_USER_EXIT)
@@ -5218,22 +5157,6 @@ static int handle_set_cr4(struct kvm_vcpu *vcpu, uns=
igned long val)
 		return kvm_set_cr4(vcpu, val);
 }
=20
-/* called to set cr0 as approriate for clts instruction exit. */
-static void handle_clts(struct kvm_vcpu *vcpu)
-{
-	if (is_guest_mode(vcpu)) {
-		/*
-		 * We get here when L2 did CLTS, and L1 didn't shadow CR0.TS
-		 * but we did (!fpu_active). We need to keep GUEST_CR0.TS on,
-		 * just pretend it's off (also in arch.cr0 for fpu_activate).
-		 */
-		vmcs_writel(CR0_READ_SHADOW,
-			vmcs_readl(CR0_READ_SHADOW) & ~X86_CR0_TS);
-		vcpu->arch.cr0 &=3D ~X86_CR0_TS;
-	} else
-		vmx_set_cr0(vcpu, kvm_read_cr0_bits(vcpu, ~X86_CR0_TS));
-}
-
 static int handle_cr(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qualification, val;
@@ -5276,10 +5199,10 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 		}
 		break;
 	case 2: /* clts */
-		handle_clts(vcpu);
+		WARN_ONCE(1, "Guest should always own CR0.TS");
+		vmx_set_cr0(vcpu, kvm_read_cr0_bits(vcpu, ~X86_CR0_TS));
 		trace_kvm_cr_write(0, kvm_read_cr0(vcpu));
 		skip_emulated_instruction(vcpu);
-		vmx_fpu_activate(vcpu);
 		return 1;
 	case 1: /*mov from cr*/
 		switch (cr) {
@@ -7009,9 +6932,6 @@ static bool nested_vmx_exit_handled(struct kvm_vcpu *=
vcpu)
 			return 0;
 		else if (is_page_fault(intr_info))
 			return enable_ept;
-		else if (is_no_device(intr_info) &&
-			 !(vmcs12->guest_cr0 & X86_CR0_TS))
-			return 0;
 		return vmcs12->exception_bitmap &
 				(1u << (intr_info & INTR_INFO_VECTOR_MASK));
 	case EXIT_REASON_EXTERNAL_INTERRUPT:
@@ -8299,8 +8219,8 @@ static void prepare_vmcs02(struct kvm_vcpu *vcpu, str=
uct vmcs12 *vmcs12)
 	vmx_set_efer(vcpu, vcpu->arch.efer);
=20
 	/*
-	 * This sets GUEST_CR0 to vmcs12->guest_cr0, with possibly a modified
-	 * TS bit (for lazy fpu) and bits which we consider mandatory enabled.
+	 * This sets GUEST_CR0 to vmcs12->guest_cr0, possibly modifying those
+	 * bits which we consider mandatory enabled.
 	 * The CR0_READ_SHADOW is what L2 should have expected to read given
 	 * the specifications by L1; It's not enough to take
 	 * vmcs12->cr0_read_shadow because on our cr0_guest_host_mask we we
@@ -8814,24 +8734,15 @@ static void load_vmcs12_host_state(struct kvm_vcpu =
*vcpu,
 	vmx_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	/*
 	 * Note that calling vmx_set_cr0 is important, even if cr0 hasn't
-	 * actually changed, because it depends on the current state of
-	 * fpu_active (which may have changed).
-	 * Note that vmx_set_cr0 refers to efer set above.
+	 * actually changed, because vmx_set_cr0 refers to efer set above.
+	 *
+	 * CR0_GUEST_HOST_MASK is already set in the original vmcs01
+	 * (KVM doesn't change it);
 	 */
+	vcpu->arch.cr0_guest_owned_bits =3D X86_CR0_TS;
 	vmx_set_cr0(vcpu, vmcs12->host_cr0);
-	/*
-	 * If we did fpu_activate()/fpu_deactivate() during L2's run, we need
-	 * to apply the same changes to L1's vmcs. We just set cr0 correctly,
-	 * but we also need to update cr0_guest_host_mask and exception_bitmap.
-	 */
-	update_exception_bitmap(vcpu);
-	vcpu->arch.cr0_guest_owned_bits =3D (vcpu->fpu_active ? X86_CR0_TS : 0);
-	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
=20
-	/*
-	 * Note that CR4_GUEST_HOST_MASK is already set in the original vmcs01
-	 * (KVM doesn't change it)- no reason to call set_cr4_guest_host_mask();
-	 */
+	/* Same as above - no reason to call set_cr4_guest_host_mask().  */
 	vcpu->arch.cr4_guest_owned_bits =3D ~vmcs_readl(CR4_GUEST_HOST_MASK);
 	vmx_set_cr4(vcpu, vmcs12->host_cr4);
=20
@@ -9081,8 +8992,6 @@ static struct kvm_x86_ops vmx_x86_ops =3D {
 	.cache_reg =3D vmx_cache_reg,
 	.get_rflags =3D vmx_get_rflags,
 	.set_rflags =3D vmx_set_rflags,
-	.fpu_activate =3D vmx_fpu_activate,
-	.fpu_deactivate =3D vmx_fpu_deactivate,
=20
 	.tlb_flush =3D vmx_flush_tlb,
=20
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5a5345d2ba61..ffb64cfc7989 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2085,6 +2085,8 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct =
msr_data *msr_info)
 	case MSR_VM_HSAVE_PA:
 	case MSR_AMD64_PATCH_LOADER:
 	case MSR_AMD64_BU_CFG2:
+	case MSR_AMD64_DC_CFG:
+	case MSR_F15H_EX_CFG:
 		break;
=20
 	case MSR_EFER:
@@ -2461,6 +2463,9 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct =
msr_data *msr_info)
 	case MSR_AMD64_NB_CFG:
 	case MSR_FAM10H_MMIO_CONF_BASE:
 	case MSR_AMD64_BU_CFG2:
+	case MSR_IA32_PERF_CTL:
+	case MSR_AMD64_DC_CFG:
+	case MSR_F15H_EX_CFG:
 		msr_info->data =3D 0;
 		break;
 	case MSR_P6_PERFCTR0:
@@ -5698,6 +5703,12 @@ int kvm_arch_init(void *opaque)
 		goto out;
 	}
=20
+	if (!boot_cpu_has(X86_FEATURE_EAGER_FPU)) {
+		pr_err("kvm: requires eagerfpu\n");
+		r =3D -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (!ops->cpu_has_kvm_support()) {
 		printk(KERN_ERR "kvm: no hardware support\n");
 		r =3D -EOPNOTSUPP;
@@ -6048,7 +6059,7 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 	u64 eoi_exit_bitmap[4];
 	u32 tmr[8];
=20
-	if (!kvm_apic_hw_enabled(vcpu->arch.apic))
+	if (!kvm_apic_present(vcpu))
 		return;
=20
 	memset(eoi_exit_bitmap, 0, 32);
@@ -6099,10 +6110,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			r =3D 0;
 			goto out;
 		}
-		if (kvm_check_request(KVM_REQ_DEACTIVATE_FPU, vcpu)) {
-			vcpu->fpu_active =3D 0;
-			kvm_x86_ops->fpu_deactivate(vcpu);
-		}
 		if (kvm_check_request(KVM_REQ_APF_HALT, vcpu)) {
 			/* Page is swapped out. Do synthetic halt */
 			vcpu->arch.apf.halted =3D true;
@@ -6159,8 +6166,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	preempt_disable();
=20
 	kvm_x86_ops->prepare_guest_switch(vcpu);
-	if (vcpu->fpu_active)
-		kvm_load_guest_fpu(vcpu);
+	kvm_load_guest_fpu(vcpu);
 	vcpu->mode =3D IN_GUEST_MODE;
=20
 	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
@@ -6917,7 +6923,6 @@ void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
 	fpu_save_init(&vcpu->arch.guest_fpu);
 	__kernel_fpu_end();
 	++vcpu->stat.fpu_reload;
-	kvm_make_request(KVM_REQ_DEACTIVATE_FPU, vcpu);
 	trace_kvm_fpu(0);
 }
=20
diff --git a/arch/x86/um/shared/sysdep/ptrace_32.h b/arch/x86/um/shared/sys=
dep/ptrace_32.h
index b94a108de1dc..ae00d22bce02 100644
--- a/arch/x86/um/shared/sysdep/ptrace_32.h
+++ b/arch/x86/um/shared/sysdep/ptrace_32.h
@@ -10,20 +10,10 @@
=20
 static inline void update_debugregs(int seq) {}
=20
-/* syscall emulation path in ptrace */
-
-#ifndef PTRACE_SYSEMU
-#define PTRACE_SYSEMU 31
-#endif
-
 void set_using_sysemu(int value);
 int get_using_sysemu(void);
 extern int sysemu_supported;
=20
-#ifndef PTRACE_SYSEMU_SINGLESTEP
-#define PTRACE_SYSEMU_SINGLESTEP 32
-#endif
-
 #define UPT_SYSCALL_ARG1(r) UPT_BX(r)
 #define UPT_SYSCALL_ARG2(r) UPT_CX(r)
 #define UPT_SYSCALL_ARG3(r) UPT_DX(r)
diff --git a/arch/x86/vdso/vclock_gettime.c b/arch/x86/vdso/vclock_gettime.c
index 00b5ea4d9189..a3d5326b9e93 100644
--- a/arch/x86/vdso/vclock_gettime.c
+++ b/arch/x86/vdso/vclock_gettime.c
@@ -147,11 +147,11 @@ notrace static long vdso_fallback_gettime(long clock,=
 struct timespec *ts)
=20
 	asm (
 		"mov %%ebx, %%edx \n"
-		"mov %2, %%ebx \n"
+		"mov %[clock], %%ebx \n"
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
 		: "=3Da" (ret), "=3Dm" (*ts)
-		: "0" (__NR_clock_gettime), "g" (clock), "c" (ts)
+		: "0" (__NR_clock_gettime), [clock] "g" (clock), "c" (ts)
 		: "memory", "edx");
 	return ret;
 }
@@ -162,11 +162,11 @@ notrace static long vdso_fallback_gtod(struct timeval=
 *tv, struct timezone *tz)
=20
 	asm (
 		"mov %%ebx, %%edx \n"
-		"mov %2, %%ebx \n"
+		"mov %[tv], %%ebx \n"
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
 		: "=3Da" (ret), "=3Dm" (*tv), "=3Dm" (*tz)
-		: "0" (__NR_gettimeofday), "g" (tv), "c" (tz)
+		: "0" (__NR_gettimeofday), [tv] "g" (tv), "c" (tz)
 		: "memory", "edx");
 	return ret;
 }
diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
index ca20a892021b..6c6877d628ef 100644
--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -31,7 +31,7 @@ $(bootdir-y): $(addprefix $(obj)/,$(subdir-y)) \
 	      $(addprefix $(obj)/,$(host-progs))
 	$(Q)$(MAKE) $(build)=3D$(obj)/$@ $(MAKECMDGOALS)
=20
-OBJCOPYFLAGS =3D --strip-all -R .comment -R .note.gnu.build-id -O binary
+OBJCOPYFLAGS =3D --strip-all -R .comment -R .notes -O binary
=20
 vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/=
processor.h
index abb59708a3b7..c4e49610fb8a 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -25,7 +25,11 @@
 # error Linux requires the Xtensa Windowed Registers Option.
 #endif
=20
-#define ARCH_SLAB_MINALIGN	XCHAL_DATA_WIDTH
+/* Xtensa ABI requires stack alignment to be at least 16 */
+
+#define STACK_ALIGN (XCHAL_DATA_WIDTH > 16 ? XCHAL_DATA_WIDTH : 16)
+
+#define ARCH_SLAB_MINALIGN STACK_ALIGN
=20
 /*
  * User space process size: 1 GB.
diff --git a/arch/xtensa/kernel/asm-offsets.c b/arch/xtensa/kernel/asm-offs=
ets.c
index 1915c7c889ba..50edae17181b 100644
--- a/arch/xtensa/kernel/asm-offsets.c
+++ b/arch/xtensa/kernel/asm-offsets.c
@@ -82,14 +82,14 @@ int main(void)
 	DEFINE(THREAD_SP, offsetof (struct task_struct, thread.sp));
 	DEFINE(THREAD_CPENABLE, offsetof (struct thread_info, cpenable));
 #if XTENSA_HAVE_COPROCESSORS
-	DEFINE(THREAD_XTREGS_CP0, offsetof (struct thread_info, xtregs_cp));
-	DEFINE(THREAD_XTREGS_CP1, offsetof (struct thread_info, xtregs_cp));
-	DEFINE(THREAD_XTREGS_CP2, offsetof (struct thread_info, xtregs_cp));
-	DEFINE(THREAD_XTREGS_CP3, offsetof (struct thread_info, xtregs_cp));
-	DEFINE(THREAD_XTREGS_CP4, offsetof (struct thread_info, xtregs_cp));
-	DEFINE(THREAD_XTREGS_CP5, offsetof (struct thread_info, xtregs_cp));
-	DEFINE(THREAD_XTREGS_CP6, offsetof (struct thread_info, xtregs_cp));
-	DEFINE(THREAD_XTREGS_CP7, offsetof (struct thread_info, xtregs_cp));
+	DEFINE(THREAD_XTREGS_CP0, offsetof(struct thread_info, xtregs_cp.cp0));
+	DEFINE(THREAD_XTREGS_CP1, offsetof(struct thread_info, xtregs_cp.cp1));
+	DEFINE(THREAD_XTREGS_CP2, offsetof(struct thread_info, xtregs_cp.cp2));
+	DEFINE(THREAD_XTREGS_CP3, offsetof(struct thread_info, xtregs_cp.cp3));
+	DEFINE(THREAD_XTREGS_CP4, offsetof(struct thread_info, xtregs_cp.cp4));
+	DEFINE(THREAD_XTREGS_CP5, offsetof(struct thread_info, xtregs_cp.cp5));
+	DEFINE(THREAD_XTREGS_CP6, offsetof(struct thread_info, xtregs_cp.cp6));
+	DEFINE(THREAD_XTREGS_CP7, offsetof(struct thread_info, xtregs_cp.cp7));
 #endif
 	DEFINE(THREAD_XTREGS_USER, offsetof (struct thread_info, xtregs_user));
 	DEFINE(XTREGS_USER_SIZE, sizeof(xtregs_user_t));
diff --git a/arch/xtensa/kernel/head.S b/arch/xtensa/kernel/head.S
index 9d0abeeb6533..d6a21972a515 100644
--- a/arch/xtensa/kernel/head.S
+++ b/arch/xtensa/kernel/head.S
@@ -88,9 +88,12 @@ ENTRY(_start)
 	initialize_mmu
 #if defined(CONFIG_MMU) && XCHAL_HAVE_PTP_MMU && XCHAL_HAVE_SPANNING_WAY
 	rsr	a2, excsave1
-	movi	a3, 0x08000000
+	movi	a3, XCHAL_KSEG_PADDR
+	bltu	a2, a3, 1f
+	sub	a2, a2, a3
+	movi	a3, XCHAL_KSEG_SIZE
 	bgeu	a2, a3, 1f
-	movi	a3, 0xd0000000
+	movi	a3, XCHAL_KSEG_CACHED_VADDR
 	add	a2, a2, a3
 	wsr	a2, excsave1
 1:
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 1c85323f01d7..df70d47d14ab 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -83,18 +83,21 @@ void coprocessor_release_all(struct thread_info *ti)
=20
 void coprocessor_flush_all(struct thread_info *ti)
 {
-	unsigned long cpenable;
+	unsigned long cpenable, old_cpenable;
 	int i;
=20
 	preempt_disable();
=20
+	RSR_CPENABLE(old_cpenable);
 	cpenable =3D ti->cpenable;
+	WSR_CPENABLE(cpenable);
=20
 	for (i =3D 0; i < XCHAL_CP_MAX; i++) {
 		if ((cpenable & 1) !=3D 0 && coprocessor_owner[i] =3D=3D ti)
 			coprocessor_flush(ti, i);
 		cpenable >>=3D 1;
 	}
+	WSR_CPENABLE(old_cpenable);
=20
 	preempt_enable();
 }
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index 562fac664751..b0aa9e313a05 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -124,12 +124,37 @@ int ptrace_setregs(struct task_struct *child, void __=
user *uregs)
 }
=20
=20
+#if XTENSA_HAVE_COPROCESSORS
+#define CP_OFFSETS(cp) \
+	{ \
+		.elf_xtregs_offset =3D offsetof(elf_xtregs_t, cp), \
+		.ti_offset =3D offsetof(struct thread_info, xtregs_cp.cp), \
+		.sz =3D sizeof(xtregs_ ## cp ## _t), \
+	}
+
+static const struct {
+	size_t elf_xtregs_offset;
+	size_t ti_offset;
+	size_t sz;
+} cp_offsets[] =3D {
+	CP_OFFSETS(cp0),
+	CP_OFFSETS(cp1),
+	CP_OFFSETS(cp2),
+	CP_OFFSETS(cp3),
+	CP_OFFSETS(cp4),
+	CP_OFFSETS(cp5),
+	CP_OFFSETS(cp6),
+	CP_OFFSETS(cp7),
+};
+#endif
+
 int ptrace_getxregs(struct task_struct *child, void __user *uregs)
 {
 	struct pt_regs *regs =3D task_pt_regs(child);
 	struct thread_info *ti =3D task_thread_info(child);
 	elf_xtregs_t __user *xtregs =3D uregs;
 	int ret =3D 0;
+	int i __maybe_unused;
=20
 	if (!access_ok(VERIFY_WRITE, uregs, sizeof(elf_xtregs_t)))
 		return -EIO;
@@ -137,8 +162,13 @@ int ptrace_getxregs(struct task_struct *child, void __=
user *uregs)
 #if XTENSA_HAVE_COPROCESSORS
 	/* Flush all coprocessor registers to memory. */
 	coprocessor_flush_all(ti);
-	ret |=3D __copy_to_user(&xtregs->cp0, &ti->xtregs_cp,
-			      sizeof(xtregs_coprocessor_t));
+
+	for (i =3D 0; i < ARRAY_SIZE(cp_offsets); ++i)
+		ret |=3D __copy_to_user((char __user *)xtregs +
+				      cp_offsets[i].elf_xtregs_offset,
+				      (const char *)ti +
+				      cp_offsets[i].ti_offset,
+				      cp_offsets[i].sz);
 #endif
 	ret |=3D __copy_to_user(&xtregs->opt, &regs->xtregs_opt,
 			      sizeof(xtregs->opt));
@@ -154,6 +184,7 @@ int ptrace_setxregs(struct task_struct *child, void __u=
ser *uregs)
 	struct pt_regs *regs =3D task_pt_regs(child);
 	elf_xtregs_t *xtregs =3D uregs;
 	int ret =3D 0;
+	int i __maybe_unused;
=20
 	if (!access_ok(VERIFY_READ, uregs, sizeof(elf_xtregs_t)))
 		return -EFAULT;
@@ -163,8 +194,11 @@ int ptrace_setxregs(struct task_struct *child, void __=
user *uregs)
 	coprocessor_flush_all(ti);
 	coprocessor_release_all(ti);
=20
-	ret |=3D __copy_from_user(&ti->xtregs_cp, &xtregs->cp0,
-				sizeof(xtregs_coprocessor_t));
+	for (i =3D 0; i < ARRAY_SIZE(cp_offsets); ++i)
+		ret |=3D __copy_from_user((char *)ti + cp_offsets[i].ti_offset,
+					(const char __user *)xtregs +
+					cp_offsets[i].elf_xtregs_offset,
+					cp_offsets[i].sz);
 #endif
 	ret |=3D __copy_from_user(&regs->xtregs_opt, &xtregs->opt,
 				sizeof(xtregs->opt));
diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.=
lds.S
index 126de5b30b9f..a805f1bc19f1 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -110,6 +110,7 @@ SECTIONS
   .fixup   : { *(.fixup) }
=20
   EXCEPTION_TABLE(16)
+  NOTES
   /* Data section */
=20
   _sdata =3D .;
diff --git a/crypto/lrw.c b/crypto/lrw.c
index 6f9908a7ebcb..d38a382b09eb 100644
--- a/crypto/lrw.c
+++ b/crypto/lrw.c
@@ -132,7 +132,12 @@ static inline int get_index128(be128 *block)
 		return x + ffz(val);
 	}
=20
-	return x;
+	/*
+	 * If we get here, then x =3D=3D 128 and we are incrementing the counter
+	 * from all ones to all zeros. This means we must return index 127, i.e.
+	 * the one corresponding to key2*{ 1,...,1 }.
+	 */
+	return 127;
 }
=20
 static int crypt(struct blkcipher_desc *d,
diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 1beef6aa9904..7446372234e1 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -28,6 +28,7 @@ static const struct acpi_device_id forbidden_id_list[] =
=3D {
 	{"PNP0200",  0},	/* AT DMA Controller */
 	{"ACPI0009", 0},	/* IOxAPIC */
 	{"ACPI000A", 0},	/* IOAPIC */
+	{"SMB0001",  0},	/* ACPI SMBUS virtual device */
 	{"", 0},
 };
=20
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 5e7c7c301c5c..ea5c6f780b49 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -449,6 +449,10 @@ acpi_ds_eval_region_operands(struct acpi_walk_state *w=
alk_state,
 			  ACPI_FORMAT_UINT64(obj_desc->region.address),
 			  obj_desc->region.length));
=20
+	status =3D acpi_ut_add_address_range(obj_desc->region.space_id,
+					   obj_desc->region.address,
+					   obj_desc->region.length, node);
+
 	/* Now the address and length are valid for this opregion */
=20
 	obj_desc->region.flags |=3D AOPOBJ_DATA_VALID;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2ff6e1933ef5..48ef233d1f02 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4246,6 +4246,11 @@ static const struct ata_blacklist_entry ata_device_b=
lacklist [] =3D {
 	{ "Crucial_CT960M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_NOLPM, },
=20
+	/* These specific Samsung models/firmware-revs do not handle LPM well */
+	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
+	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
+	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM, },
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f824836d2e7a..df51673d6591 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3819,10 +3819,11 @@ static int __floppy_read_block_0(struct block_devic=
e *bdev, int drive)
 	bio.bi_private =3D &cbdata;
 	bio.bi_end_io =3D floppy_rb0_cb;
=20
+	init_completion(&cbdata.complete);
+
 	submit_bio(READ, &bio);
 	process_fd_request();
=20
-	init_completion(&cbdata.complete);
 	wait_for_completion(&cbdata.complete);
=20
 	__free_page(page);
diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index 3757e9e72d37..cfedd8d2f769 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -296,6 +296,33 @@ static const struct platform_device_id s2mps11_clk_id[=
] =3D {
 };
 MODULE_DEVICE_TABLE(platform, s2mps11_clk_id);
=20
+#ifdef CONFIG_OF
+/*
+ * Device is instantiated through parent MFD device and device matching is=
 done
+ * through platform_device_id.
+ *
+ * However if device's DT node contains proper clock compatible and driver=
 is
+ * built as a module, then the *module* matching will be done trough DT al=
iases.
+ * This requires of_device_id table.  In the same time this will not chang=
e the
+ * actual *device* matching so do not add .of_match_table.
+ */
+static const struct of_device_id s2mps11_dt_match[] __used =3D {
+	{
+		.compatible =3D "samsung,s2mps11-clk",
+		.data =3D (void *)S2MPS11X,
+	}, {
+		.compatible =3D "samsung,s2mps14-clk",
+		.data =3D (void *)S2MPS14X,
+	}, {
+		.compatible =3D "samsung,s5m8767-clk",
+		.data =3D (void *)S5M8767X,
+	}, {
+		/* Sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, s2mps11_dt_match);
+#endif
+
 static struct platform_driver s2mps11_clk_driver =3D {
 	.driver =3D {
 		.name  =3D "s2mps11-clk",
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 14ee3efcc404..d927ebd6c35b 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -19,6 +19,13 @@
 DEFINE_RAW_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
=20
+/*
+ * Handle PIT quirk in pit_shutdown() where zeroing the counter register
+ * restarts the PIT, negating the shutdown. On platforms with the quirk,
+ * platform specific code can set this to false.
+ */
+bool i8253_clear_counter_on_shutdown =3D true;
+
 #ifdef CONFIG_CLKSRC_I8253
 /*
  * Since the PIT overflows every tick, its not very useful
@@ -123,8 +130,11 @@ static void init_pit_timer(enum clock_event_mode mode,
 		if (evt->mode =3D=3D CLOCK_EVT_MODE_PERIODIC ||
 		    evt->mode =3D=3D CLOCK_EVT_MODE_ONESHOT) {
 			outb_p(0x30, PIT_MODE);
-			outb_p(0, PIT_CH0);
-			outb_p(0, PIT_CH0);
+
+			if (i8253_clear_counter_on_shutdown) {
+				outb_p(0, PIT_CH0);
+				outb_p(0, PIT_CH0);
+			}
 		}
 		break;
=20
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index decaa3698e12..df02406ce085 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -11,6 +11,7 @@
  */
=20
 #include <linux/kernel.h>
+#include <linux/kmod.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/err.h>
@@ -148,6 +149,49 @@ static struct devfreq_governor *find_devfreq_governor(=
const char *name)
 	return ERR_PTR(-ENODEV);
 }
=20
+/**
+ * try_then_request_governor() - Try to find the governor and request the
+ *                               module if is not found.
+ * @name:	name of the governor
+ *
+ * Search the list of devfreq governors and request the module and try aga=
in
+ * if is not found. This can happen when both drivers (the governor driver
+ * and the driver that call devfreq_add_device) are built as modules.
+ * devfreq_list_lock should be held by the caller. Returns the matched
+ * governor's pointer.
+ */
+static struct devfreq_governor *try_then_request_governor(const char *name)
+{
+	struct devfreq_governor *governor;
+	int err =3D 0;
+
+	if (IS_ERR_OR_NULL(name)) {
+		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+	WARN(!mutex_is_locked(&devfreq_list_lock),
+	     "devfreq_list_lock must be locked.");
+
+	governor =3D find_devfreq_governor(name);
+	if (IS_ERR(governor)) {
+		mutex_unlock(&devfreq_list_lock);
+
+		if (!strncmp(name, "simple_ondemand",
+			     DEVFREQ_NAME_LEN))
+			err =3D request_module("governor_%s", "simpleondemand");
+		else
+			err =3D request_module("governor_%s", name);
+		/* Restore previous state before return */
+		mutex_lock(&devfreq_list_lock);
+		if (err)
+			return NULL;
+
+		governor =3D find_devfreq_governor(name);
+	}
+
+	return governor;
+}
+
 /* Load monitoring helper functions for governors use */
=20
 /**
@@ -499,9 +543,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	mutex_unlock(&devfreq->lock);
=20
 	mutex_lock(&devfreq_list_lock);
-	list_add(&devfreq->node, &devfreq_list);
=20
-	governor =3D find_devfreq_governor(devfreq->governor_name);
+	governor =3D try_then_request_governor(devfreq->governor_name);
 	if (IS_ERR(governor)) {
 		dev_err(dev, "%s: Unable to find governor for the device\n",
 			__func__);
@@ -517,12 +560,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
 			__func__);
 		goto err_init;
 	}
+
+	list_add(&devfreq->node, &devfreq_list);
+
 	mutex_unlock(&devfreq_list_lock);
=20
 	return devfreq;
=20
 err_init:
-	list_del(&devfreq->node);
 	mutex_unlock(&devfreq_list_lock);
=20
 	device_unregister(&devfreq->dev);
@@ -798,7 +843,7 @@ static ssize_t governor_store(struct device *dev, struc=
t device_attribute *attr,
 		return -EINVAL;
=20
 	mutex_lock(&devfreq_list_lock);
-	governor =3D find_devfreq_governor(str_governor);
+	governor =3D try_then_request_governor(str_governor);
 	if (IS_ERR(governor)) {
 		ret =3D PTR_ERR(governor);
 		goto out;
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index c13a3bb0f594..d5cdc0d3d23a 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1231,6 +1231,12 @@ static void atc_free_chan_resources(struct dma_chan =
*chan)
 	atchan->status =3D 0;
 	atchan->remain_desc =3D 0;
=20
+	/*
+	 * Free atslave allocated in at_dma_xlate()
+	 */
+	kfree(chan->private);
+	chan->private =3D NULL;
+
 	dev_vdbg(chan2dev(chan), "free_chan_resources: done\n");
 }
=20
@@ -1265,7 +1271,7 @@ static struct dma_chan *at_dma_xlate(struct of_phandl=
e_args *dma_spec,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
=20
-	atslave =3D devm_kzalloc(&dmac_pdev->dev, sizeof(*atslave), GFP_KERNEL);
+	atslave =3D kzalloc(sizeof(*atslave), GFP_KERNEL);
 	if (!atslave)
 		return NULL;
=20
@@ -1558,6 +1564,8 @@ static int at_dma_remove(struct platform_device *pdev)
 	struct resource		*io;
=20
 	at_dma_off(atdma);
+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&atdma->dma_common);
=20
 	dma_pool_destroy(atdma->dma_desc_pool);
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 8f4ac40dd979..a0702c483a17 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1729,6 +1729,7 @@ static void i7core_mce_output_error(struct mem_ctl_in=
fo *mci,
 	u32 errnum =3D find_first_bit(&error, 32);
=20
 	if (uncorrected_error) {
+		core_err_cnt =3D 1;
 		if (ripv)
 			tp_event =3D HW_EVENT_ERR_FATAL;
 		else
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index beac1858e94f..1f92d55eb37d 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -1659,6 +1659,7 @@ static void sbridge_mce_output_error(struct mem_ctl_i=
nfo *mci,
 		recoverable =3D GET_BITFIELD(m->status, 56, 56);
=20
 	if (uncorrected_error) {
+		core_err_cnt =3D 1;
 		if (ripv) {
 			type =3D "FATAL";
 			tp_event =3D HW_EVENT_ERR_FATAL;
diff --git a/drivers/gpio/gpio-max7301.c b/drivers/gpio/gpio-max7301.c
index 6e1c984a75d4..e6f11c4f8d1c 100644
--- a/drivers/gpio/gpio-max7301.c
+++ b/drivers/gpio/gpio-max7301.c
@@ -25,7 +25,7 @@ static int max7301_spi_write(struct device *dev, unsigned=
 int reg,
 	struct spi_device *spi =3D to_spi_device(dev);
 	u16 word =3D ((reg & 0x7F) << 8) | (val & 0xFF);
=20
-	return spi_write(spi, (const u8 *)&word, sizeof(word));
+	return spi_write_then_read(spi, &word, sizeof(word), NULL, 0);
 }
=20
 /* A read from the MAX7301 means two transfers; here, one message each */
@@ -37,14 +37,8 @@ static int max7301_spi_read(struct device *dev, unsigned=
 int reg)
 	struct spi_device *spi =3D to_spi_device(dev);
=20
 	word =3D 0x8000 | (reg << 8);
-	ret =3D spi_write(spi, (const u8 *)&word, sizeof(word));
-	if (ret)
-		return ret;
-	/*
-	 * This relies on the fact, that a transfer with NULL tx_buf shifts out
-	 * zero bytes (=3DNOOP for MAX7301)
-	 */
-	ret =3D spi_read(spi, (u8 *)&word, sizeof(word));
+	ret =3D spi_write_then_read(spi, &word, sizeof(word), &word,
+				  sizeof(word));
 	if (ret)
 		return ret;
 	return word & 0xff;
diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index 44074fbcf7ff..7a66431a1074 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -60,8 +60,29 @@ static DEFINE_PCI_DEVICE_TABLE(pciidlist) =3D {
=20
 MODULE_DEVICE_TABLE(pci, pciidlist);
=20
+static void ast_kick_out_firmware_fb(struct pci_dev *pdev)
+{
+	struct apertures_struct *ap;
+	bool primary =3D false;
+
+	ap =3D alloc_apertures(1);
+	if (!ap)
+		return;
+
+	ap->ranges[0].base =3D pci_resource_start(pdev, 0);
+	ap->ranges[0].size =3D pci_resource_len(pdev, 0);
+
+#ifdef CONFIG_X86
+	primary =3D pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADO=
W;
+#endif
+	remove_conflicting_framebuffers(ap, "astdrmfb", primary);
+	kfree(ap);
+}
+
 static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id =
*ent)
 {
+	ast_kick_out_firmware_fb(pdev);
+
 	return drm_get_pci_dev(pdev, ent, &driver);
 }
=20
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index d7e615282d38..c760bcb8d6ca 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -527,6 +527,7 @@ static int ast_crtc_do_set_base(struct drm_crtc *crtc,
 	}
 	ast_bo_unreserve(bo);
=20
+	ast_set_offset_reg(crtc);
 	ast_set_start_address_crt1(crtc, (u32)gpu_addr);
=20
 	return 0;
@@ -1232,7 +1233,7 @@ static int ast_cursor_move(struct drm_crtc *crtc,
 	ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0xc7, ((y >> 8) & 0x07));
=20
 	/* dummy write to fire HWC */
-	ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xCB, 0xFF, 0x00);
+	ast_show_cursor(crtc);
=20
 	return 0;
 }
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 8218078b6133..7549b9fe4d42 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -49,6 +49,7 @@
 #include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
 #include <drm/drmP.h>
 #include <drm/drm_core.h>
=20
@@ -360,7 +361,10 @@ long drm_ioctl(struct file *filp,
 	if ((nr >=3D DRM_COMMAND_BASE) && (nr < DRM_COMMAND_END) &&
 	    (nr < DRM_COMMAND_BASE + dev->driver->num_ioctls)) {
 		u32 drv_size;
-		ioctl =3D &dev->driver->ioctls[nr - DRM_COMMAND_BASE];
+		unsigned int index =3D nr - DRM_COMMAND_BASE;
+
+		index =3D array_index_nospec(index, dev->driver->num_ioctls);
+		ioctl =3D &dev->driver->ioctls[index];
 		drv_size =3D _IOC_SIZE(ioctl->cmd_drv);
 		usize =3D asize =3D _IOC_SIZE(cmd);
 		if (drv_size > asize)
@@ -370,6 +374,7 @@ long drm_ioctl(struct file *filp,
 	else if ((nr >=3D DRM_COMMAND_END) || (nr < DRM_COMMAND_BASE)) {
 		u32 drv_size;
=20
+		nr =3D array_index_nospec(nr, DRM_CORE_IOCTL_COUNT);
 		ioctl =3D &drm_ioctls[nr];
=20
 		drv_size =3D _IOC_SIZE(ioctl->cmd);
@@ -460,12 +465,14 @@ EXPORT_SYMBOL(drm_ioctl);
  */
 bool drm_ioctl_flags(unsigned int nr, unsigned int *flags)
 {
-	if ((nr >=3D DRM_COMMAND_END && nr < DRM_CORE_IOCTL_COUNT) ||
-	    (nr < DRM_COMMAND_BASE)) {
-		*flags =3D drm_ioctls[nr].flags;
-		return true;
-	}
+	if (nr >=3D DRM_COMMAND_BASE && nr < DRM_COMMAND_END)
+		return false;
+
+	if (nr >=3D DRM_CORE_IOCTL_COUNT)
+		return false;
+	nr =3D array_index_nospec(nr, DRM_CORE_IOCTL_COUNT);
=20
-	return false;
+	*flags =3D drm_ioctls[nr].flags;
+	return true;
 }
 EXPORT_SYMBOL(drm_ioctl_flags);
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_ge=
m.c
index 3b2bca469cd4..6b2a948ab33b 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -573,7 +573,7 @@ i915_gem_shmem_pread(struct drm_device *dev,
 	char __user *user_data;
 	ssize_t remain;
 	loff_t offset;
-	int shmem_page_offset, page_length, ret =3D 0;
+	int shmem_page_offset, ret =3D 0;
 	int obj_do_bit17_swizzling, page_do_bit17_swizzling;
 	int prefaulted =3D 0;
 	int needs_clflush =3D 0;
@@ -593,6 +593,7 @@ i915_gem_shmem_pread(struct drm_device *dev,
 	for_each_sg_page(obj->pages->sgl, &sg_iter, obj->pages->nents,
 			 offset >> PAGE_SHIFT) {
 		struct page *page =3D sg_page_iter_page(&sg_iter);
+		unsigned int page_length;
=20
 		if (remain <=3D 0)
 			break;
@@ -603,9 +604,7 @@ i915_gem_shmem_pread(struct drm_device *dev,
 		 * page_length =3D bytes to copy for this page
 		 */
 		shmem_page_offset =3D offset_in_page(offset);
-		page_length =3D remain;
-		if ((shmem_page_offset + page_length) > PAGE_SIZE)
-			page_length =3D PAGE_SIZE - shmem_page_offset;
+		page_length =3D min_t(u64, remain, PAGE_SIZE - shmem_page_offset);
=20
 		page_do_bit17_swizzling =3D obj_do_bit17_swizzling &&
 			(page_to_phys(page) & (1 << 17)) !=3D 0;
@@ -870,7 +869,7 @@ i915_gem_shmem_pwrite(struct drm_device *dev,
 	ssize_t remain;
 	loff_t offset;
 	char __user *user_data;
-	int shmem_page_offset, page_length, ret =3D 0;
+	int shmem_page_offset, ret =3D 0;
 	int obj_do_bit17_swizzling, page_do_bit17_swizzling;
 	int hit_slowpath =3D 0;
 	int needs_clflush_after =3D 0;
@@ -913,6 +912,7 @@ i915_gem_shmem_pwrite(struct drm_device *dev,
 			 offset >> PAGE_SHIFT) {
 		struct page *page =3D sg_page_iter_page(&sg_iter);
 		int partial_cacheline_write;
+		unsigned int page_length;
=20
 		if (remain <=3D 0)
 			break;
@@ -923,10 +923,7 @@ i915_gem_shmem_pwrite(struct drm_device *dev,
 		 * page_length =3D bytes to copy for this page
 		 */
 		shmem_page_offset =3D offset_in_page(offset);
-
-		page_length =3D remain;
-		if ((shmem_page_offset + page_length) > PAGE_SIZE)
-			page_length =3D PAGE_SIZE - shmem_page_offset;
+		page_length =3D min_t(u64, remain, PAGE_SIZE - shmem_page_offset);
=20
 		/* If we don't overwrite a cacheline completely we need to be
 		 * careful to have up-to-date data by first clflushing. Don't
diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_p=
m.c
index aa83a835965c..e19c3201db30 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -1749,6 +1749,9 @@ static uint32_t ilk_compute_pri_wm(const struct ilk_p=
ipe_wm_parameters *params,
 {
 	uint32_t method1, method2;
=20
+	if (mem_value =3D=3D 0)
+		return U32_MAX;
+
 	if (!params->active || !params->pri.enabled)
 		return 0;
=20
@@ -1777,6 +1780,9 @@ static uint32_t ilk_compute_spr_wm(const struct ilk_p=
ipe_wm_parameters *params,
 {
 	uint32_t method1, method2;
=20
+	if (mem_value =3D=3D 0)
+		return U32_MAX;
+
 	if (!params->active || !params->spr.enabled)
 		return 0;
=20
@@ -1798,6 +1804,9 @@ static uint32_t ilk_compute_spr_wm(const struct ilk_p=
ipe_wm_parameters *params,
 static uint32_t ilk_compute_cur_wm(const struct ilk_pipe_wm_parameters *pa=
rams,
 				   uint32_t mem_value)
 {
+	if (mem_value =3D=3D 0)
+		return U32_MAX;
+
 	if (!params->active || !params->cur.enabled)
 		return 0;
=20
@@ -2149,6 +2158,36 @@ static void snb_wm_latency_quirk(struct drm_device *=
dev)
 	intel_print_wm_latency(dev, "Cursor", dev_priv->wm.cur_latency);
 }
=20
+static void snb_wm_lp3_irq_quirk(struct drm_device *dev)
+{
+	struct drm_i915_private *dev_priv =3D dev->dev_private;
+
+	/*
+	 * On some SNB machines (Thinkpad X220 Tablet at least)
+	 * LP3 usage can cause vblank interrupts to be lost.
+	 * The DEIIR bit will go high but it looks like the CPU
+	 * never gets interrupted.
+	 *
+	 * It's not clear whether other interrupt source could
+	 * be affected or if this is somehow limited to vblank
+	 * interrupts only. To play it safe we disable LP3
+	 * watermarks entirely.
+	 */
+	if (dev_priv->wm.pri_latency[3] =3D=3D 0 &&
+	    dev_priv->wm.spr_latency[3] =3D=3D 0 &&
+	    dev_priv->wm.cur_latency[3] =3D=3D 0)
+		return;
+
+	dev_priv->wm.pri_latency[3] =3D 0;
+	dev_priv->wm.spr_latency[3] =3D 0;
+	dev_priv->wm.cur_latency[3] =3D 0;
+
+	DRM_DEBUG_KMS("LP3 watermarks disabled due to potential for lost interrup=
ts\n");
+	intel_print_wm_latency(dev, "Primary", dev_priv->wm.pri_latency);
+	intel_print_wm_latency(dev, "Sprite", dev_priv->wm.spr_latency);
+	intel_print_wm_latency(dev, "Cursor", dev_priv->wm.cur_latency);
+}
+
 static void ilk_setup_wm_latency(struct drm_device *dev)
 {
 	struct drm_i915_private *dev_priv =3D dev->dev_private;
@@ -2167,8 +2206,10 @@ static void ilk_setup_wm_latency(struct drm_device *=
dev)
 	intel_print_wm_latency(dev, "Sprite", dev_priv->wm.spr_latency);
 	intel_print_wm_latency(dev, "Cursor", dev_priv->wm.cur_latency);
=20
-	if (IS_GEN6(dev))
+	if (IS_GEN6(dev)) {
 		snb_wm_latency_quirk(dev);
+		snb_wm_lp3_irq_quirk(dev);
+	}
 }
=20
 static void ilk_compute_wm_parameters(struct drm_crtc *crtc,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0c7f18197e4c..5e3a4ef4a3de 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -704,6 +704,7 @@
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP 0x07e9
 #define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
+#define USB_DEVICE_ID_MS_PIXART_MOUSE    0x00cb
=20
 #define USB_VENDOR_ID_MOJO		0x8282
 #define USB_DEVICE_ID_RETRO_ADAPTER	0x3201
@@ -1054,6 +1055,8 @@
 #define USB_VENDOR_ID_PRIMAX	0x0461
 #define USB_DEVICE_ID_PRIMAX_MOUSE_4D22	0x4d22
 #define USB_DEVICE_ID_PRIMAX_KEYBOARD	0x4e05
+#define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D0F	0x4d0f
+#define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4E22	0x4e22
=20
=20
 #define USB_VENDOR_ID_RISO_KAGAKU	0x1294	/* Riso Kagaku Corp. */
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index e244e449cbba..248a436e222a 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -257,7 +257,8 @@ EXPORT_SYMBOL_GPL(sensor_hub_get_feature);
=20
 int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsde=
v,
 					u32 usage_id,
-					u32 attr_usage_id, u32 report_id)
+					u32 attr_usage_id, u32 report_id,
+					bool is_signed)
 {
 	struct sensor_hub_data *data =3D hid_get_drvdata(hsdev->hdev);
 	unsigned long flags;
@@ -282,10 +283,16 @@ int sensor_hub_input_attr_get_raw_value(struct hid_se=
nsor_hub_device *hsdev,
 	wait_for_completion_interruptible_timeout(&data->pending.ready, HZ*5);
 	switch (data->pending.raw_size) {
 	case 1:
-		ret_val =3D *(u8 *)data->pending.raw_data;
+		if (is_signed)
+			ret_val =3D *(s8 *)data->pending.raw_data;
+		else
+			ret_val =3D *(u8 *)data->pending.raw_data;
 		break;
 	case 2:
-		ret_val =3D *(u16 *)data->pending.raw_data;
+		if (is_signed)
+			ret_val =3D *(s16 *)data->pending.raw_data;
+		else
+			ret_val =3D *(u16 *)data->pending.raw_data;
 		break;
 	case 4:
 		ret_val =3D *(u32 *)data->pending.raw_data;
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index e0453b6a21a8..035c7c2863dc 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -12,6 +12,7 @@
=20
 #include <linux/atomic.h>
 #include <linux/compat.h>
+#include <linux/cred.h>
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/hid.h>
@@ -22,6 +23,7 @@
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/uaccess.h>
 #include <linux/uhid.h>
 #include <linux/wait.h>
=20
@@ -676,6 +678,17 @@ static ssize_t uhid_char_write(struct file *file, cons=
t char __user *buffer,
=20
 	switch (uhid->input_buf.type) {
 	case UHID_CREATE:
+		/*
+		 * 'struct uhid_create_req' contains a __user pointer which is
+		 * copied from, so it's unsafe to allow this with elevated
+		 * privileges (e.g. from a setuid binary) or via kernel_write().
+		 */
+		if (file->f_cred !=3D current_cred() || uaccess_kernel()) {
+			pr_err_once("UHID_CREATE from different security context by process %d =
(%s), this is not allowed.\n",
+				    task_tgid_vnr(current), current->comm);
+			ret =3D -EACCES;
+			goto unlock;
+		}
 		ret =3D uhid_dev_create(uhid, &uhid->input_buf);
 		break;
 	case UHID_CREATE2:
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirk=
s.c
index 2858cce95d9f..dd70a28d6771 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -117,6 +117,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP, HID_QUIR=
K_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_IN=
IT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INI=
T_REPORTS },
+	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PIXART_MOUSE, HID_QUIRK_ALWAY=
S_POLL },
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GX680R_LED_PANEL, HID_QUIRK_NO_INI=
T_REPORTS },
 	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_=
NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE, HID_QUIRK_NO_INIT_R=
EPORTS },
@@ -128,6 +129,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN1, HID_Q=
UIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN2, HID_Q=
UIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_MOUSE_4D22, HID_QUIRK_ALWAYS=
_POLL },
+	{ USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D0F, HID_QUIRK=
_ALWAYS_POLL },
+	{ USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4E22, HID_QUIRK=
_ALWAYS_POLL },
 	{ USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS, HID_QUIRK_NOGET =
},
 	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001, HID_QUIR=
K_NOGET },
 	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003, HID_QUIR=
K_NOGET },
diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index b59b15d4caa9..308d8432fea3 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -521,14 +521,24 @@ static noinline int hiddev_ioctl_usage(struct hiddev =
*hiddev, unsigned int cmd,
 			if (cmd =3D=3D HIDIOCGCOLLECTIONINDEX) {
 				if (uref->usage_index >=3D field->maxusage)
 					goto inval;
+				uref->usage_index =3D
+					array_index_nospec(uref->usage_index,
+							   field->maxusage);
 			} else if (uref->usage_index >=3D field->report_count)
 				goto inval;
 		}
=20
-		if ((cmd =3D=3D HIDIOCGUSAGES || cmd =3D=3D HIDIOCSUSAGES) &&
-		    (uref_multi->num_values > HID_MAX_MULTI_USAGES ||
-		     uref->usage_index + uref_multi->num_values > field->report_count))
-			goto inval;
+		if (cmd =3D=3D HIDIOCGUSAGES || cmd =3D=3D HIDIOCSUSAGES) {
+			if (uref_multi->num_values > HID_MAX_MULTI_USAGES ||
+			    uref->usage_index + uref_multi->num_values >
+			    field->report_count)
+				goto inval;
+
+			uref->usage_index =3D
+				array_index_nospec(uref->usage_index,
+						   field->report_count -
+						   uref_multi->num_values);
+		}
=20
 		switch (cmd) {
 		case HIDIOCGUSAGE:
diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index db2e7fecae49..acebfddb1e29 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -416,6 +416,14 @@ int vmbus_establish_gpadl(struct vmbus_channel *channe=
l, void *kbuffer,
 	}
 	wait_for_completion(&msginfo->waitevent);
=20
+	if (msginfo->response.gpadl_created.creation_status !=3D 0) {
+		pr_err("Failed to establish GPADL: err =3D 0x%x\n",
+		       msginfo->response.gpadl_created.creation_status);
+
+		ret =3D -EDQUOT;
+		goto cleanup;
+	}
+
 	/* At this point, we received the gpadl created msg */
 	*gpadl_handle =3D gpadlmsg->gpadl;
=20
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 521c14625b3a..9ad9194024f7 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -326,7 +326,9 @@ static void process_ib_ipinfo(void *in_msg, void *out_m=
sg, int op)
=20
 		out->body.kvp_ip_val.dhcp_enabled =3D in->kvp_ip_val.dhcp_enabled;
=20
-	default:
+		/* fallthrough */
+
+	case KVP_OP_GET_IP_INFO:
 		utf16s_to_utf8s((wchar_t *)in->kvp_ip_val.adapter_id,
 				MAX_ADAPTER_ID_SIZE,
 				UTF16_LITTLE_ENDIAN,
@@ -379,6 +381,10 @@ kvp_send_key(struct work_struct *dummy)
 		process_ib_ipinfo(in_msg, message, KVP_OP_SET_IP_INFO);
 		break;
 	case KVP_OP_GET_IP_INFO:
+		/*
+		 * We only need to pass on the info of operation, adapter_id
+		 * and addr_family to the userland kvp daemon.
+		 */
 		process_ib_ipinfo(in_msg, message, KVP_OP_GET_IP_INFO);
 		break;
 	case KVP_OP_SET:
@@ -419,7 +425,10 @@ kvp_send_key(struct work_struct *dummy)
 			break;
=20
 		}
-	case KVP_OP_GET:
+
+		/*
+		 * The key is always a string - utf16 encoding.
+		 */
 		message->body.kvp_set.data.key_size =3D
 			utf16s_to_utf8s(
 			(wchar_t *)in_msg->body.kvp_set.data.key,
@@ -427,6 +436,17 @@ kvp_send_key(struct work_struct *dummy)
 			UTF16_LITTLE_ENDIAN,
 			message->body.kvp_set.data.key,
 			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;
+
+		break;
+
+	case KVP_OP_GET:
+		message->body.kvp_get.data.key_size =3D
+			utf16s_to_utf8s(
+			(wchar_t *)in_msg->body.kvp_get.data.key,
+			in_msg->body.kvp_get.data.key_size,
+			UTF16_LITTLE_ENDIAN,
+			message->body.kvp_get.data.key,
+			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;
 			break;
=20
 	case KVP_OP_DELETE:
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 1f2fff71dbe3..68523636410b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -260,6 +260,8 @@ static ssize_t out_intr_mask_show(struct device *dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_interrupt_mask);
 }
@@ -273,6 +275,8 @@ static ssize_t out_read_index_show(struct device *dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_read_index);
 }
@@ -287,6 +291,8 @@ static ssize_t out_write_index_show(struct device *dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_write_index);
 }
@@ -301,6 +307,8 @@ static ssize_t out_read_bytes_avail_show(struct device =
*dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.bytes_avail_toread);
 }
@@ -315,6 +323,8 @@ static ssize_t out_write_bytes_avail_show(struct device=
 *dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.bytes_avail_towrite);
 }
@@ -328,6 +338,8 @@ static ssize_t in_intr_mask_show(struct device *dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_interrupt_mask);
 }
@@ -341,6 +353,8 @@ static ssize_t in_read_index_show(struct device *dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_read_index);
 }
@@ -354,6 +368,8 @@ static ssize_t in_write_index_show(struct device *dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_write_index);
 }
@@ -368,6 +384,8 @@ static ssize_t in_read_bytes_avail_show(struct device *=
dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.bytes_avail_toread);
 }
@@ -382,6 +400,8 @@ static ssize_t in_write_bytes_avail_show(struct device =
*dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.bytes_avail_towrite);
 }
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index 7e91700131a7..adb97e452fad 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -117,6 +117,8 @@ static int pmbus_identify(struct i2c_client *client,
 		} else {
 			info->pages =3D 1;
 		}
+
+		pmbus_clear_faults(client);
 	}
=20
 	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE)) {
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index 6f3fabb5350f..1b0b4125f8a5 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1705,7 +1705,10 @@ static int pmbus_init_common(struct i2c_client *clie=
nt, struct pmbus_data *data,
 		}
 	}
=20
-	pmbus_clear_faults(client);
+	if (data->info->pages)
+		pmbus_clear_faults(client);
+	else
+		pmbus_clear_fault_page(client, -1);
=20
 	if (info->identify) {
 		ret =3D (*info->identify)(client, info);
diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index 21894131190f..9b838fff7e4d 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -1693,7 +1693,7 @@ store_sf_setup(struct device *dev, struct device_attr=
ibute *attr,
  * somewhere else in the code
  */
 #define SENSOR_ATTR_TEMP(index) {					\
-	SENSOR_ATTR_2(temp##index##_type, S_IRUGO | (index < 4 ? S_IWUSR : 0), \
+	SENSOR_ATTR_2(temp##index##_type, S_IRUGO | (index < 5 ? S_IWUSR : 0), \
 		show_temp_mode, store_temp_mode, NOT_USED, index - 1),	\
 	SENSOR_ATTR_2(temp##index##_input, S_IRUGO, show_temp,		\
 		NULL, TEMP_READ, index - 1),				\
diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hi=
d-sensor-accel-3d.c
index 54e464e4bb72..1c4b0248d7bf 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -112,6 +112,7 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
 	u32 address;
 	int ret_type;
 	s32 poll_value;
+	s32 min;
=20
 	*val =3D 0;
 	*val2 =3D 0;
@@ -125,12 +126,14 @@ static int accel_3d_read_raw(struct iio_dev *indio_de=
v,
 		hid_sensor_power_state(&accel_state->common_attributes, true);
 		msleep_interruptible(poll_value * 2);
 		report_id =3D accel_state->accel[chan->scan_index].report_id;
+		min =3D accel_state->accel[chan->scan_index].logical_minimum;
 		address =3D accel_3d_addresses[chan->scan_index];
 		if (report_id >=3D 0)
 			*val =3D sensor_hub_input_attr_get_raw_value(
 					accel_state->common_attributes.hsdev,
 					HID_USAGE_SENSOR_ACCEL_3D, address,
-					report_id);
+					report_id,
+					min < 0);
 		else {
 			*val =3D 0;
 			hid_sensor_power_state(&accel_state->common_attributes,
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index e98515fc469f..10d5ec213091 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -245,12 +245,14 @@ static irqreturn_t at91_adc_trigger_handler(int irq, =
void *p)
 	struct iio_poll_func *pf =3D p;
 	struct iio_dev *idev =3D pf->indio_dev;
 	struct at91_adc_state *st =3D iio_priv(idev);
+	struct iio_chan_spec const *chan;
 	int i, j =3D 0;
=20
 	for (i =3D 0; i < idev->masklength; i++) {
 		if (!test_bit(i, idev->active_scan_mask))
 			continue;
-		st->buffer[j] =3D at91_adc_readl(st, AT91_ADC_CHAN(st, i));
+		chan =3D idev->channels + i;
+		st->buffer[j] =3D at91_adc_readl(st, AT91_ADC_CHAN(st, chan->channel));
 		j++;
 	}
=20
@@ -276,6 +278,8 @@ void handle_adc_eoc_trigger(int irq, struct iio_dev *id=
ev)
 		iio_trigger_poll(idev->trig, iio_get_time_ns());
 	} else {
 		st->last_value =3D at91_adc_readl(st, AT91_ADC_CHAN(st, st->chnb));
+		/* Needed to ACK the DRDY interruption */
+		at91_adc_readl(st, AT91_ADC_LCDR);
 		st->done =3D true;
 		wake_up_interruptible(&st->wq_data_avail);
 	}
diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index aac16fecdfa8..ed76d8c88e91 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -469,6 +469,41 @@ static const char * const ad5064_vref_name(struct ad50=
64_state *st,
 	return st->chip_info->shared_vref ? "vref" : ad5064_vref_names[vref];
 }
=20
+static int ad5064_request_vref(struct ad5064_state *st, struct device *dev)
+{
+	unsigned int i;
+	int ret;
+
+	for (i =3D 0; i < ad5064_num_vref(st); ++i)
+		st->vref_reg[i].supply =3D ad5064_vref_name(st, i);
+
+	if (!st->chip_info->internal_vref)
+		return devm_regulator_bulk_get(dev, ad5064_num_vref(st),
+					       st->vref_reg);
+
+	/*
+	 * This assumes that when the regulator has an internal VREF
+	 * there is only one external VREF connection, which is
+	 * currently the case for all supported devices.
+	 */
+	st->vref_reg[0].consumer =3D devm_regulator_get_optional(dev, "vref");
+	if (!IS_ERR(st->vref_reg[0].consumer))
+		return 0;
+
+	ret =3D PTR_ERR(st->vref_reg[0].consumer);
+	if (ret !=3D -ENODEV)
+		return ret;
+
+	/* If no external regulator was supplied use the internal VREF */
+	st->use_internal_vref =3D true;
+	ret =3D ad5064_write(st, AD5064_CMD_CONFIG, 0,
+		AD5064_CONFIG_INT_VREF_ENABLE, 0);
+	if (ret)
+		dev_err(dev, "Failed to enable internal vref: %d\n", ret);
+
+	return ret;
+}
+
 static int ad5064_probe(struct device *dev, enum ad5064_type type,
 			const char *name, ad5064_write_func write)
 {
@@ -489,23 +524,11 @@ static int ad5064_probe(struct device *dev, enum ad50=
64_type type,
 	st->dev =3D dev;
 	st->write =3D write;
=20
-	for (i =3D 0; i < ad5064_num_vref(st); ++i)
-		st->vref_reg[i].supply =3D ad5064_vref_name(st, i);
+	ret =3D ad5064_request_vref(st, dev);
+	if (ret)
+		return ret;
=20
-	ret =3D devm_regulator_bulk_get(dev, ad5064_num_vref(st),
-		st->vref_reg);
-	if (ret) {
-		if (!st->chip_info->internal_vref)
-			return ret;
-		st->use_internal_vref =3D true;
-		ret =3D ad5064_write(st, AD5064_CMD_CONFIG, 0,
-			AD5064_CONFIG_INT_VREF_ENABLE, 0);
-		if (ret) {
-			dev_err(dev, "Failed to enable internal vref: %d\n",
-				ret);
-			return ret;
-		}
-	} else {
+	if (!st->use_internal_vref) {
 		ret =3D regulator_bulk_enable(ad5064_num_vref(st), st->vref_reg);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-s=
ensor-gyro-3d.c
index fa034a3dad78..15fe41bf7c67 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -112,6 +112,7 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 	u32 address;
 	int ret_type;
 	s32 poll_value;
+	s32 min;
=20
 	*val =3D 0;
 	*val2 =3D 0;
@@ -125,12 +126,14 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
 		hid_sensor_power_state(&gyro_state->common_attributes, true);
 		msleep_interruptible(poll_value * 2);
 		report_id =3D gyro_state->gyro[chan->scan_index].report_id;
+		min =3D gyro_state->gyro[chan->scan_index].logical_minimum;
 		address =3D gyro_3d_addresses[chan->scan_index];
 		if (report_id >=3D 0)
 			*val =3D sensor_hub_input_attr_get_raw_value(
 					gyro_state->common_attributes.hsdev,
 					HID_USAGE_SENSOR_GYRO_3D, address,
-					report_id);
+					report_id,
+					min < 0);
 		else {
 			*val =3D 0;
 			hid_sensor_power_state(&gyro_state->common_attributes,
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sen=
sor-als.c
index 96e71e103ea7..f032906ab5ff 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -81,6 +81,7 @@ static int als_read_raw(struct iio_dev *indio_dev,
 	u32 address;
 	int ret_type;
 	s32 poll_value;
+	s32 min;
=20
 	*val =3D 0;
 	*val2 =3D 0;
@@ -89,8 +90,8 @@ static int als_read_raw(struct iio_dev *indio_dev,
 		switch (chan->scan_index) {
 		case  CHANNEL_SCAN_INDEX_ILLUM:
 			report_id =3D als_state->als_illum.report_id;
-			address =3D
-			HID_USAGE_SENSOR_LIGHT_ILLUM;
+			min =3D als_state->als_illum.logical_minimum;
+			address =3D HID_USAGE_SENSOR_LIGHT_ILLUM;
 			break;
 		default:
 			report_id =3D -1;
@@ -109,7 +110,8 @@ static int als_read_raw(struct iio_dev *indio_dev,
 			*val =3D sensor_hub_input_attr_get_raw_value(
 					als_state->common_attributes.hsdev,
 					HID_USAGE_SENSOR_ALS, address,
-					report_id);
+					report_id,
+					min < 0);
 			hid_sensor_power_state(&als_state->common_attributes,
 						false);
 		} else {
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-se=
nsor-prox.c
index c95b9682f0da..607a6fb5adb0 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -74,6 +74,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 	u32 address;
 	int ret_type;
 	s32 poll_value;
+	s32 min;
=20
 	*val =3D 0;
 	*val2 =3D 0;
@@ -82,8 +83,8 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 		switch (chan->scan_index) {
 		case  CHANNEL_SCAN_INDEX_PRESENCE:
 			report_id =3D prox_state->prox_attr.report_id;
-			address =3D
-			HID_USAGE_SENSOR_HUMAN_PRESENCE;
+			min =3D prox_state->prox_attr.logical_minimum;
+			address =3D HID_USAGE_SENSOR_HUMAN_PRESENCE;
 			break;
 		default:
 			report_id =3D -1;
@@ -103,7 +104,8 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 			*val =3D sensor_hub_input_attr_get_raw_value(
 				prox_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_PROX, address,
-				report_id);
+				report_id,
+				min < 0);
 			hid_sensor_power_state(&prox_state->common_attributes,
 						false);
 		} else {
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/ma=
gnetometer/hid-sensor-magn-3d.c
index b2b0937d5133..0de504b70c93 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -112,6 +112,7 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
 	u32 address;
 	int ret_type;
 	s32 poll_value;
+	s32 min;
=20
 	*val =3D 0;
 	*val2 =3D 0;
@@ -125,14 +126,15 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
 		hid_sensor_power_state(&magn_state->common_attributes, true);
 		msleep_interruptible(poll_value * 2);
=20
-		report_id =3D
-			magn_state->magn[chan->scan_index].report_id;
+		report_id =3D magn_state->magn[chan->scan_index].report_id;
+		min =3D magn_state->magn[chan->scan_index].logical_minimum;
 		address =3D magn_3d_addresses[chan->scan_index];
 		if (report_id >=3D 0)
 			*val =3D sensor_hub_input_attr_get_raw_value(
 				magn_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_COMPASS_3D, address,
-				report_id);
+				report_id,
+				min < 0);
 		else {
 			*val =3D 0;
 			hid_sensor_power_state(&magn_state->common_attributes,
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/ori=
entation/hid-sensor-incl-3d.c
index 2478f6c2ef25..e037175d813a 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -112,6 +112,7 @@ static int incl_3d_read_raw(struct iio_dev *indio_dev,
 	u32 address;
 	int ret_type;
 	s32 poll_value;
+	s32 min;
=20
 	*val =3D 0;
 	*val2 =3D 0;
@@ -125,14 +126,15 @@ static int incl_3d_read_raw(struct iio_dev *indio_dev,
 		hid_sensor_power_state(&incl_state->common_attributes, true);
 		msleep_interruptible(poll_value * 2);
=20
-		report_id =3D
-			incl_state->incl[chan->scan_index].report_id;
+		report_id =3D incl_state->incl[chan->scan_index].report_id;
+		min =3D incl_state->incl[chan->scan_index].logical_minimum;
 		address =3D incl_3d_addresses[chan->scan_index];
 		if (report_id >=3D 0)
 			*val =3D sensor_hub_input_attr_get_raw_value(
 				incl_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_INCLINOMETER_3D, address,
-				report_id);
+				report_id,
+				min < 0);
 		else {
 			hid_sensor_power_state(&incl_state->common_attributes,
 						false);
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure=
/hid-sensor-press.c
index 759b153f1955..7118aa68a866 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -78,6 +78,7 @@ static int press_read_raw(struct iio_dev *indio_dev,
 	u32 address;
 	int ret_type;
 	s32 poll_value;
+	s32 min;
=20
 	*val =3D 0;
 	*val2 =3D 0;
@@ -86,8 +87,8 @@ static int press_read_raw(struct iio_dev *indio_dev,
 		switch (chan->scan_index) {
 		case  CHANNEL_SCAN_INDEX_PRESSURE:
 			report_id =3D press_state->press_attr.report_id;
-			address =3D
-			HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE;
+			min =3D press_state->press_attr.logical_minimum;
+			address =3D HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE;
 			break;
 		default:
 			report_id =3D -1;
@@ -106,7 +107,8 @@ static int press_read_raw(struct iio_dev *indio_dev,
 			*val =3D sensor_hub_input_attr_get_raw_value(
 				press_state->common_attributes.hsdev,
 				HID_USAGE_SENSOR_PRESSURE, address,
-				report_id);
+				report_id,
+				min < 0);
 			hid_sensor_power_state(&press_state->common_attributes,
 						false);
 		} else {
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 1cf32b827806..eb8575a88b0c 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -380,13 +380,13 @@ static void cm_set_private_data(struct cm_id_private =
*cm_id_priv,
 	cm_id_priv->private_data_len =3D private_data_len;
 }
=20
-static void cm_init_av_for_response(struct cm_port *port, struct ib_wc *wc,
-				    struct ib_grh *grh, struct cm_av *av)
+static int cm_init_av_for_response(struct cm_port *port, struct ib_wc *wc,
+				   struct ib_grh *grh, struct cm_av *av)
 {
 	av->port =3D port;
 	av->pkey_index =3D wc->pkey_index;
-	ib_init_ah_from_wc(port->cm_dev->ib_device, port->port_num, wc,
-			   grh, &av->ah_attr);
+	return ib_init_ah_from_wc(port->cm_dev->ib_device, port->port_num, wc,
+				  grh, &av->ah_attr);
 }
=20
 static int cm_init_av_by_path(struct ib_sa_path_rec *path, struct cm_av *a=
v,
@@ -1601,9 +1601,11 @@ static int cm_req_handler(struct cm_work *work)
=20
 	cm_id_priv =3D container_of(cm_id, struct cm_id_private, id);
 	cm_id_priv->id.remote_id =3D req_msg->local_comm_id;
-	cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
-				work->mad_recv_wc->recv_buf.grh,
-				&cm_id_priv->av);
+	ret =3D cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
+				      work->mad_recv_wc->recv_buf.grh,
+				      &cm_id_priv->av);
+	if (ret)
+		goto destroy;
 	cm_id_priv->timewait_info =3D cm_create_timewait_info(cm_id_priv->
 							    id.local_id);
 	if (IS_ERR(cm_id_priv->timewait_info)) {
@@ -2805,13 +2807,19 @@ static int cm_lap_handler(struct cm_work *work)
 		goto unlock;
 	}
=20
+	ret =3D cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
+				      work->mad_recv_wc->recv_buf.grh,
+				      &cm_id_priv->av);
+	if (ret)
+		goto unlock;
+
+	ret =3D cm_init_av_by_path(param->alternate_path,
+				 &cm_id_priv->alt_av, cm_id_priv);
+	if (ret)
+		goto unlock;
+
 	cm_id_priv->id.lap_state =3D IB_CM_LAP_RCVD;
 	cm_id_priv->tid =3D lap_msg->hdr.tid;
-	cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
-				work->mad_recv_wc->recv_buf.grh,
-				&cm_id_priv->av);
-	cm_init_av_by_path(param->alternate_path, &cm_id_priv->alt_av,
-			   cm_id_priv);
 	ret =3D atomic_inc_and_test(&cm_id_priv->work_count);
 	if (!ret)
 		list_add_tail(&work->list, &cm_id_priv->work_list);
@@ -3060,6 +3068,7 @@ static int cm_sidr_req_handler(struct cm_work *work)
 	struct cm_id_private *cm_id_priv, *cur_cm_id_priv;
 	struct cm_sidr_req_msg *sidr_req_msg;
 	struct ib_wc *wc;
+	int ret;
=20
 	cm_id =3D ib_create_cm_id(work->port->cm_dev->ib_device, NULL, NULL);
 	if (IS_ERR(cm_id))
@@ -3072,9 +3081,12 @@ static int cm_sidr_req_handler(struct cm_work *work)
 	wc =3D work->mad_recv_wc->wc;
 	cm_id_priv->av.dgid.global.subnet_prefix =3D cpu_to_be64(wc->slid);
 	cm_id_priv->av.dgid.global.interface_id =3D 0;
-	cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
-				work->mad_recv_wc->recv_buf.grh,
-				&cm_id_priv->av);
+	ret =3D cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
+				      work->mad_recv_wc->recv_buf.grh,
+				      &cm_id_priv->av);
+	if (ret)
+		goto out;
+
 	cm_id_priv->id.remote_id =3D sidr_req_msg->request_id;
 	cm_id_priv->tid =3D sidr_req_msg->hdr.tid;
 	atomic_inc(&cm_id_priv->work_count);
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/u=
ser_mad.c
index 1acb99100556..163b2f63d9d8 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -234,10 +234,14 @@ static void recv_handler(struct ib_mad_agent *agent,
 	packet->mad.hdr.grh_present =3D !!(mad_recv_wc->wc->wc_flags & IB_WC_GRH);
 	if (packet->mad.hdr.grh_present) {
 		struct ib_ah_attr ah_attr;
+		int ret;
=20
-		ib_init_ah_from_wc(agent->device, agent->port_num,
-				   mad_recv_wc->wc, mad_recv_wc->recv_buf.grh,
-				   &ah_attr);
+		ret =3D ib_init_ah_from_wc(agent->device, agent->port_num,
+					 mad_recv_wc->wc,
+					 mad_recv_wc->recv_buf.grh,
+					 &ah_attr);
+		if (ret)
+			goto err2;
=20
 		packet->mad.hdr.gid_index =3D ah_attr.grh.sgid_index;
 		packet->mad.hdr.hop_limit =3D ah_attr.grh.hop_limit;
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/=
hw/mthca/mthca_main.c
index ded76c101dde..834b06aacc2b 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -989,7 +989,8 @@ static int __mthca_init_one(struct pci_dev *pdev, int h=
ca_type)
 		goto err_free_dev;
 	}
=20
-	if (mthca_cmd_init(mdev)) {
+	err =3D mthca_cmd_init(mdev);
+	if (err) {
 		mthca_err(mdev, "Failed to init command interface, aborting.\n");
 		goto err_free_dev;
 	}
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/=
ulp/iser/iser_verbs.c
index ea01075f9f9b..a8dd7b077e0f 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -1165,7 +1165,9 @@ u8 iser_check_task_pi_status(struct iscsi_iser_task *=
iser_task,
 					 IB_MR_CHECK_SIG_STATUS, &mr_status);
 		if (ret) {
 			pr_err("ib_check_mr_status failed, ret %d\n", ret);
-			goto err;
+			/* Not a lot we can do, return ambiguous guard error */
+			*sector =3D 0;
+			return 0x1;
 		}
=20
 		if (mr_status.fail_status & IB_MR_CHECK_SIG_STATUS) {
@@ -1193,7 +1195,4 @@ u8 iser_check_task_pi_status(struct iscsi_iser_task *=
iser_task,
 	}
=20
 	return 0;
-err:
-	/* Not alot we can do here, return ambiguous guard error */
-	return 0x1;
 }
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboar=
d/matrix_keypad.c
index fde979216d58..d26ecfdf866b 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -404,7 +404,7 @@ matrix_keypad_parse_dt(struct device *dev)
 	struct matrix_keypad_platform_data *pdata;
 	struct device_node *np =3D dev->of_node;
 	unsigned int *gpios;
-	int i, nrow, ncol;
+	int ret, i, nrow, ncol;
=20
 	if (!np) {
 		dev_err(dev, "device lacks DT data\n");
@@ -444,12 +444,19 @@ matrix_keypad_parse_dt(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 	}
=20
-	for (i =3D 0; i < pdata->num_row_gpios; i++)
-		gpios[i] =3D of_get_named_gpio(np, "row-gpios", i);
+	for (i =3D 0; i < nrow; i++) {
+		ret =3D of_get_named_gpio(np, "row-gpios", i);
+		if (ret < 0)
+			return ERR_PTR(ret);
+		gpios[i] =3D ret;
+	}
=20
-	for (i =3D 0; i < pdata->num_col_gpios; i++)
-		gpios[pdata->num_row_gpios + i] =3D
-			of_get_named_gpio(np, "col-gpios", i);
+	for (i =3D 0; i < ncol; i++) {
+		ret =3D of_get_named_gpio(np, "col-gpios", i);
+		if (ret < 0)
+			return ERR_PTR(ret);
+		gpios[nrow + i] =3D ret;
+	}
=20
 	pdata->row_gpios =3D gpios;
 	pdata->col_gpios =3D &gpios[pdata->num_row_gpios];
@@ -476,10 +483,8 @@ static int matrix_keypad_probe(struct platform_device =
*pdev)
 	pdata =3D dev_get_platdata(&pdev->dev);
 	if (!pdata) {
 		pdata =3D matrix_keypad_parse_dt(&pdev->dev);
-		if (IS_ERR(pdata)) {
-			dev_err(&pdev->dev, "no platform data defined\n");
+		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
-		}
 	} else if (!pdata->keymap_data) {
 		dev_err(&pdev->dev, "no keymap data defined\n");
 		return -EINVAL;
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 53cde086e83b..2bbe414e9b0f 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -383,6 +383,9 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_=
domain *domain)
=20
 static void ipmmu_domain_destroy_context(struct ipmmu_vmsa_domain *domain)
 {
+	if (!domain->mmu)
+		return;
+
 	/*
 	 * Disable the context. Flush the TLB as required when modifying the
 	 * context registers.
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 181d3fc29957..a7ddc11f58ab 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -2354,7 +2354,7 @@ static int refill_keybuf_fn(struct btree_op *op, stru=
ct btree *b,
 	struct keybuf *buf =3D refill->buf;
 	int ret =3D MAP_CONTINUE;
=20
-	if (bkey_cmp(k, refill->end) >=3D 0) {
+	if (bkey_cmp(k, refill->end) > 0) {
 		ret =3D MAP_DONE;
 		goto out;
 	}
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 046d7fa71243..16a4f2624a3c 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -462,6 +462,7 @@ struct search {
 	unsigned		recoverable:1;
 	unsigned		write:1;
 	unsigned		read_dirty_data:1;
+	unsigned		cache_missed:1;
=20
 	unsigned long		start_time;
=20
@@ -651,6 +652,7 @@ static inline struct search *search_alloc(struct bio *b=
io,
=20
 	s->orig_bio		=3D bio;
 	s->cache_miss		=3D NULL;
+	s->cache_missed		=3D 0;
 	s->d			=3D d;
 	s->recoverable		=3D 1;
 	s->write		=3D (bio->bi_rw & REQ_WRITE) !=3D 0;
@@ -774,7 +776,7 @@ static void cached_dev_read_done_bh(struct closure *cl)
 	struct cached_dev *dc =3D container_of(s->d, struct cached_dev, disk);
=20
 	bch_mark_cache_accounting(s->iop.c, s->d,
-				  !s->cache_miss, s->iop.bypass);
+				  !s->cache_missed, s->iop.bypass);
 	trace_bcache_read(s->orig_bio, !s->cache_miss, s->iop.bypass);
=20
 	if (s->iop.error)
@@ -793,6 +795,8 @@ static int cached_dev_cache_miss(struct btree *b, struc=
t search *s,
 	struct cached_dev *dc =3D container_of(s->d, struct cached_dev, disk);
 	struct bio *miss, *cache_bio;
=20
+	s->cache_missed =3D 1;
+
 	if (s->cache_miss || s->iop.bypass) {
 		miss =3D bio_next_split(bio, sectors, GFP_NOIO, s->d->bio_split);
 		ret =3D miss =3D=3D bio ? MAP_DONE : MAP_CONTINUE;
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index d20c2de3fd72..7ca3a95d939a 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1681,8 +1681,7 @@ static void free_params(struct dm_ioctl *param, size_=
t param_size, int param_fla
 }
=20
 static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *para=
m_kernel,
-		       int ioctl_flags,
-		       struct dm_ioctl **param, int *param_flags)
+		       int ioctl_flags, struct dm_ioctl **param, int *param_flags)
 {
 	struct dm_ioctl *dmi;
 	int secure_data;
@@ -1730,18 +1729,13 @@ static int copy_params(struct dm_ioctl __user *user=
, struct dm_ioctl *param_kern
 		return -ENOMEM;
 	}
=20
-	if (copy_from_user(dmi, user, param_kernel->data_size))
-		goto bad;
+	/* Copy from param_kernel (which was already copied from user) */
+	memcpy(dmi, param_kernel, minimum_data_size);
=20
-data_copied:
-	/*
-	 * Abort if something changed the ioctl data while it was being copied.
-	 */
-	if (dmi->data_size !=3D param_kernel->data_size) {
-		DMERR("rejecting ioctl: data size modified while processing parameters");
+	if (copy_from_user(&dmi->data, (char __user *)user + minimum_data_size,
+			   param_kernel->data_size - minimum_data_size))
 		goto bad;
-	}
-
+data_copied:
 	/* Wipe the user buffer so we do not return it to userspace */
 	if (secure_data && clear_user(user, param_kernel->data_size))
 		goto bad;
diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index a9121254e37a..543e9f7dd37a 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -873,9 +873,6 @@ static int tvp5150_s_crop(struct v4l2_subdev *sd, const=
 struct v4l2_crop *a)
=20
 	/* tvp5150 has some special limits */
 	rect.left =3D clamp(rect.left, 0, TVP5150_MAX_CROP_LEFT);
-	rect.width =3D clamp_t(unsigned int, rect.width,
-			     TVP5150_H_MAX - TVP5150_MAX_CROP_LEFT - rect.left,
-			     TVP5150_H_MAX - rect.left);
 	rect.top =3D clamp(rect.top, 0, TVP5150_MAX_CROP_TOP);
=20
 	/* Calculate height based on current standard */
@@ -889,9 +886,16 @@ static int tvp5150_s_crop(struct v4l2_subdev *sd, cons=
t struct v4l2_crop *a)
 	else
 		hmax =3D TVP5150_V_MAX_OTHERS;
=20
-	rect.height =3D clamp_t(unsigned int, rect.height,
+	/*
+	 * alignments:
+	 *  - width =3D 2 due to UYVY colorspace
+	 *  - height, image =3D no special alignment
+	 */
+	v4l_bound_align_image(&rect.width,
+			      TVP5150_H_MAX - TVP5150_MAX_CROP_LEFT - rect.left,
+			      TVP5150_H_MAX - rect.left, 1, &rect.height,
 			      hmax - TVP5150_MAX_CROP_TOP - rect.top,
-			      hmax - rect.top);
+			      hmax - rect.top, 0, 0);
=20
 	tvp5150_write(sd, TVP5150_VERT_BLANKING_START, rect.top);
 	tvp5150_write(sd, TVP5150_VERT_BLANKING_STOP,
diff --git a/drivers/media/pci/cx23885/altera-ci.c b/drivers/media/pci/cx23=
885/altera-ci.c
index 2926f7fadccd..23ef564bfadb 100644
--- a/drivers/media/pci/cx23885/altera-ci.c
+++ b/drivers/media/pci/cx23885/altera-ci.c
@@ -666,6 +666,10 @@ static int altera_hw_filt_init(struct altera_ci_config=
 *config, int hw_filt_nr)
 		}
=20
 		temp_int =3D append_internal(inter);
+		if (!temp_int) {
+			ret =3D -ENOMEM;
+			goto err;
+		}
 		inter->filts_used =3D 1;
 		inter->dev =3D config->dev;
 		inter->fpga_rw =3D config->fpga_rw;
@@ -700,6 +704,7 @@ static int altera_hw_filt_init(struct altera_ci_config =
*config, int hw_filt_nr)
 		     __func__, ret);
=20
 	kfree(pid_filt);
+	kfree(inter);
=20
 	return ret;
 }
@@ -735,6 +740,10 @@ int altera_ci_init(struct altera_ci_config *config, in=
t ci_nr)
 		}
=20
 		temp_int =3D append_internal(inter);
+		if (!temp_int) {
+			ret =3D -ENOMEM;
+			goto err;
+		}
 		inter->cis_used =3D 1;
 		inter->dev =3D config->dev;
 		inter->fpga_rw =3D config->fpga_rw;
@@ -803,6 +812,7 @@ int altera_ci_init(struct altera_ci_config *config, int=
 ci_nr)
 	ci_dbg_print("%s: Cannot initialize CI: Error %d.\n", __func__, ret);
=20
 	kfree(state);
+	kfree(inter);
=20
 	return ret;
 }
diff --git a/drivers/media/usb/cx231xx/cx231xx-video.c b/drivers/media/usb/=
cx231xx/cx231xx-video.c
index 1f8751379e24..ca02f7c47226 100644
--- a/drivers/media/usb/cx231xx/cx231xx-video.c
+++ b/drivers/media/usb/cx231xx/cx231xx-video.c
@@ -1271,7 +1271,7 @@ int cx231xx_g_register(struct file *file, void *priv,
 		ret =3D cx231xx_read_ctrl_reg(dev, VRT_GET_REGISTER,
 				(u16)reg->reg, value, 4);
 		reg->val =3D value[0] | value[1] << 8 |
-			value[2] << 16 | value[3] << 24;
+			value[2] << 16 | (u32)value[3] << 24;
 		reg->size =3D 4;
 		break;
 	case 1:	/* AFE - read byte */
diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em=
28xx/em28xx-cards.c
index 15ad47045553..7360d9da9f8f 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -2001,13 +2001,13 @@ struct em28xx_board em28xx_boards[] =3D {
 		.input           =3D { {
 			.type     =3D EM28XX_VMUX_COMPOSITE1,
 			.vmux     =3D TVP5150_COMPOSITE1,
-			.amux     =3D EM28XX_AUDIO_SRC_LINE,
+			.amux     =3D EM28XX_AMUX_LINE_IN,
 			.gpio     =3D terratec_av350_unmute_gpio,
=20
 		}, {
 			.type     =3D EM28XX_VMUX_SVIDEO,
 			.vmux     =3D TVP5150_SVIDEO,
-			.amux     =3D EM28XX_AUDIO_SRC_LINE,
+			.amux     =3D EM28XX_AMUX_LINE_IN,
 			.gpio     =3D terratec_av350_unmute_gpio,
 		} },
 	},
diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em=
28xx/em28xx-video.c
index 69810fa0151a..b654ea88b12d 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -928,6 +928,8 @@ int em28xx_start_analog_streaming(struct vb2_queue *vq,=
 unsigned int count)
=20
 	em28xx_videodbg("%s\n", __func__);
=20
+	dev->v4l2->field_count =3D 0;
+
 	/* Make sure streaming is not already in progress for this type
 	   of filehandle (e.g. video, vbi) */
 	rc =3D res_get(dev, vq->type);
@@ -1279,9 +1281,9 @@ static int vidioc_try_fmt_vid_cap(struct file *file, =
void *priv,
=20
 	fmt =3D format_by_fourcc(f->fmt.pix.pixelformat);
 	if (!fmt) {
-		em28xx_videodbg("Fourcc format (%08x) invalid.\n",
-				f->fmt.pix.pixelformat);
-		return -EINVAL;
+		fmt =3D &format[0];
+		em28xx_videodbg("Fourcc format (%08x) invalid. Using default (%08x).\n",
+				f->fmt.pix.pixelformat, fmt->fourcc);
 	}
=20
 	if (dev->board.is_em2800) {
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc=
_driver.c
index 0c2a2466fc36..bb002b9120de 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -826,7 +826,7 @@ static struct uvc_entity *uvc_alloc_entity(u16 type, u8=
 id,
 	unsigned int size;
 	unsigned int i;
=20
-	extra_size =3D ALIGN(extra_size, sizeof(*entity->pads));
+	extra_size =3D roundup(extra_size, sizeof(*entity->pads));
 	num_inputs =3D (type & UVC_TERM_OUTPUT) ? num_pads : num_pads - 1;
 	size =3D sizeof(*entity) + extra_size + sizeof(*entity->pads) * num_pads
 	     + num_inputs;
diff --git a/drivers/media/v4l2-core/v4l2-event.c b/drivers/media/v4l2-core=
/v4l2-event.c
index fcf65f131a2a..35901f5b3971 100644
--- a/drivers/media/v4l2-core/v4l2-event.c
+++ b/drivers/media/v4l2-core/v4l2-event.c
@@ -194,6 +194,22 @@ int v4l2_event_pending(struct v4l2_fh *fh)
 }
 EXPORT_SYMBOL_GPL(v4l2_event_pending);
=20
+static void __v4l2_event_unsubscribe(struct v4l2_subscribed_event *sev)
+{
+	struct v4l2_fh *fh =3D sev->fh;
+	unsigned int i;
+
+	lockdep_assert_held(&fh->subscribe_lock);
+	assert_spin_locked(&fh->vdev->fh_lock);
+
+	/* Remove any pending events for this subscription */
+	for (i =3D 0; i < sev->in_use; i++) {
+		list_del(&sev->events[sev_pos(sev, i)].list);
+		fh->navailable--;
+	}
+	list_del(&sev->list);
+}
+
 int v4l2_event_subscribe(struct v4l2_fh *fh,
 			 const struct v4l2_event_subscription *sub, unsigned elems,
 			 const struct v4l2_subscribed_event_ops *ops)
@@ -225,27 +241,23 @@ int v4l2_event_subscribe(struct v4l2_fh *fh,
=20
 	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
 	found_ev =3D v4l2_event_subscribed(fh, sub->type, sub->id);
+	if (!found_ev)
+		list_add(&sev->list, &fh->subscribed);
 	spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
=20
 	if (found_ev) {
 		/* Already listening */
 		kfree(sev);
-		goto out_unlock;
-	}
-
-	if (sev->ops && sev->ops->add) {
+	} else if (sev->ops && sev->ops->add) {
 		ret =3D sev->ops->add(sev, elems);
 		if (ret) {
+			spin_lock_irqsave(&fh->vdev->fh_lock, flags);
+			__v4l2_event_unsubscribe(sev);
+			spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
 			kfree(sev);
-			goto out_unlock;
 		}
 	}
=20
-	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
-	list_add(&sev->list, &fh->subscribed);
-	spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
-
-out_unlock:
 	mutex_unlock(&fh->subscribe_lock);
=20
 	return ret;
@@ -280,7 +292,6 @@ int v4l2_event_unsubscribe(struct v4l2_fh *fh,
 {
 	struct v4l2_subscribed_event *sev;
 	unsigned long flags;
-	int i;
=20
 	if (sub->type =3D=3D V4L2_EVENT_ALL) {
 		v4l2_event_unsubscribe_all(fh);
@@ -292,14 +303,8 @@ int v4l2_event_unsubscribe(struct v4l2_fh *fh,
 	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
=20
 	sev =3D v4l2_event_subscribed(fh, sub->type, sub->id);
-	if (sev !=3D NULL) {
-		/* Remove any pending events for this subscription */
-		for (i =3D 0; i < sev->in_use; i++) {
-			list_del(&sev->events[sev_pos(sev, i)].list);
-			fh->navailable--;
-		}
-		list_del(&sev->list);
-	}
+	if (sev !=3D NULL)
+		__v4l2_event_unsubscribe(sev);
=20
 	spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
=20
diff --git a/drivers/media/v4l2-core/videobuf2-core.c b/drivers/media/v4l2-=
core/videobuf2-core.c
index ee8b697972bb..b259d08971ee 100644
--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -2200,10 +2200,8 @@ static int vb2_internal_streamon(struct vb2_queue *q=
, enum v4l2_buf_type type)
 	 */
 	if (q->queued_count >=3D q->min_buffers_needed) {
 		ret =3D vb2_start_streaming(q);
-		if (ret) {
-			__vb2_queue_cancel(q);
+		if (ret)
 			return ret;
-		}
 	}
=20
 	q->streaming =3D 1;
diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index 22de13727641..6e790ab486cc 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -116,7 +116,7 @@ static const struct of_device_id atmel_ssc_dt_ids[] =3D=
 {
 MODULE_DEVICE_TABLE(of, atmel_ssc_dt_ids);
 #endif
=20
-static inline const struct atmel_ssc_platform_data * __init
+static inline const struct atmel_ssc_platform_data *
 	atmel_ssc_get_driver_data(struct platform_device *pdev)
 {
 	if (pdev->dev.of_node) {
diff --git a/drivers/misc/genwqe/card_base.h b/drivers/misc/genwqe/card_bas=
e.h
index 0e608a288603..976064880026 100644
--- a/drivers/misc/genwqe/card_base.h
+++ b/drivers/misc/genwqe/card_base.h
@@ -401,7 +401,7 @@ struct genwqe_file {
 	struct file *filp;
=20
 	struct fasync_struct *async_queue;
-	struct task_struct *owner;
+	struct pid *opener;
 	struct list_head list;		/* entry in list of open files */
=20
 	spinlock_t map_lock;		/* lock for dma_mappings */
diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
index 1d2f163a1906..ceac798c1d9c 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -52,7 +52,7 @@ static void genwqe_add_file(struct genwqe_dev *cd, struct=
 genwqe_file *cfile)
 {
 	unsigned long flags;
=20
-	cfile->owner =3D current;
+	cfile->opener =3D get_pid(task_tgid(current));
 	spin_lock_irqsave(&cd->file_lock, flags);
 	list_add(&cfile->list, &cd->file_list);
 	spin_unlock_irqrestore(&cd->file_lock, flags);
@@ -65,6 +65,7 @@ static int genwqe_del_file(struct genwqe_dev *cd, struct =
genwqe_file *cfile)
 	spin_lock_irqsave(&cd->file_lock, flags);
 	list_del(&cfile->list);
 	spin_unlock_irqrestore(&cd->file_lock, flags);
+	put_pid(cfile->opener);
=20
 	return 0;
 }
@@ -275,7 +276,7 @@ static int genwqe_kill_fasync(struct genwqe_dev *cd, in=
t sig)
 	return files;
 }
=20
-static int genwqe_force_sig(struct genwqe_dev *cd, int sig)
+static int genwqe_terminate(struct genwqe_dev *cd)
 {
 	unsigned int files =3D 0;
 	unsigned long flags;
@@ -283,7 +284,7 @@ static int genwqe_force_sig(struct genwqe_dev *cd, int =
sig)
=20
 	spin_lock_irqsave(&cd->file_lock, flags);
 	list_for_each_entry(cfile, &cd->file_list, list) {
-		force_sig(sig, cfile->owner);
+		kill_pid(cfile->opener, SIGKILL, 1);
 		files++;
 	}
 	spin_unlock_irqrestore(&cd->file_lock, flags);
@@ -1346,7 +1347,7 @@ static int genwqe_inform_and_stop_processes(struct ge=
nwqe_dev *cd)
 		dev_warn(&pci_dev->dev,
 			 "[%s] send SIGKILL and wait ...\n", __func__);
=20
-		rc =3D genwqe_force_sig(cd, SIGKILL); /* force terminate */
+		rc =3D genwqe_terminate(cd);
 		if (rc) {
 			/* Give kill_timout more seconds to end processes */
 			for (i =3D 0; (i < genwqe_kill_timeout) &&
diff --git a/drivers/misc/sgi-gru/grukdump.c b/drivers/misc/sgi-gru/grukdum=
p.c
index a3700a56b8ff..1bc9469ad520 100644
--- a/drivers/misc/sgi-gru/grukdump.c
+++ b/drivers/misc/sgi-gru/grukdump.c
@@ -27,6 +27,9 @@
 #include <linux/delay.h>
 #include <linux/bitops.h>
 #include <asm/uv/uv_hub.h>
+
+#include <linux/nospec.h>
+
 #include "gru.h"
 #include "grutables.h"
 #include "gruhandles.h"
@@ -198,6 +201,7 @@ int gru_dump_chiplet_request(unsigned long arg)
 	/* Currently, only dump by gid is implemented */
 	if (req.gid >=3D gru_max_gids || req.gid < 0)
 		return -EINVAL;
+	req.gid =3D array_index_nospec(req.gid, gru_max_gids);
=20
 	gru =3D GID_TO_GRU(req.gid);
 	ubuf =3D req.buf;
diff --git a/drivers/misc/vmw_vmci/vmci_resource.c b/drivers/misc/vmw_vmci/=
vmci_resource.c
index 9a53a30de445..f1164602cec1 100644
--- a/drivers/misc/vmw_vmci/vmci_resource.c
+++ b/drivers/misc/vmw_vmci/vmci_resource.c
@@ -56,7 +56,8 @@ static struct vmci_resource *vmci_resource_lookup(struct =
vmci_handle handle,
=20
 		if (r->type =3D=3D type &&
 		    rid =3D=3D handle.resource &&
-		    (cid =3D=3D handle.context || cid =3D=3D VMCI_INVALID_ID)) {
+		    (cid =3D=3D handle.context || cid =3D=3D VMCI_INVALID_ID ||
+		     handle.context =3D=3D VMCI_INVALID_ID)) {
 			resource =3D r;
 			break;
 		}
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 20a32d14a636..0604d6742b0c 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -449,7 +449,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 	struct mmc_blk_ioc_data *idata;
 	struct mmc_blk_data *md;
 	struct mmc_card *card;
-	struct mmc_command cmd =3D {0};
+	struct mmc_command cmd =3D {}, sbc =3D {};
 	struct mmc_data data =3D {0};
 	struct mmc_request mrq =3D {NULL};
 	struct scatterlist sg;
@@ -539,10 +539,15 @@ static int mmc_blk_ioctl_cmd(struct block_device *bde=
v,
 	}
=20
 	if (is_rpmb) {
-		err =3D mmc_set_blockcount(card, data.blocks,
-			idata->ic.write_flag & (1 << 31));
-		if (err)
-			goto cmd_rel_host;
+		sbc.opcode =3D MMC_SET_BLOCK_COUNT;
+		/*
+		 * We don't do any blockcount validation because the max size
+		 * may be increased by a future standard. We just copy the
+		 * 'Reliable Write' bit here.
+		 */
+		sbc.arg =3D data.blocks | (idata->ic.write_flag & BIT(31));
+		sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
+		mrq.sbc =3D &sbc;
 	}
=20
 	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) =3D=3D EXT_CSD_SANITIZE_START) &&
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index d87f81f3eae4..008ea4c52290 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -24,6 +24,8 @@
 #include "mmc_ops.h"
 #include "sd_ops.h"
=20
+#define MIN_CACHE_EN_TIMEOUT_MS 1600
+
 static const unsigned int tran_exp[] =3D {
 	10000,		100000,		1000000,	10000000,
 	0,		0,		0,		0
@@ -1418,19 +1420,26 @@ static int mmc_init_card(struct mmc_host *host, u32=
 ocr,
 		if (err) {
 			pr_warning("%s: Enabling HPI failed\n",
 				   mmc_hostname(card->host));
+			card->ext_csd.hpi_en =3D 0;
 			err =3D 0;
-		} else
+		} else {
 			card->ext_csd.hpi_en =3D 1;
+		}
 	}
=20
 	/*
-	 * If cache size is higher than 0, this indicates
-	 * the existence of cache and it can be turned on.
+	 * If cache size is higher than 0, this indicates the existence of cache
+	 * and it can be turned on. Note that some eMMCs from Micron has been
+	 * reported to need ~800 ms timeout, while enabling the cache after
+	 * sudden power failure tests. Let's extend the timeout to a minimum of
+	 * DEFAULT_CACHE_EN_TIMEOUT_MS and do it for all cards.
 	 */
 	if (card->ext_csd.cache_size > 0) {
+		unsigned int timeout_ms =3D MIN_CACHE_EN_TIMEOUT_MS;
+
+		timeout_ms =3D max(card->ext_csd.generic_cmd6_time, timeout_ms);
 		err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_CACHE_CTRL, 1,
-				card->ext_csd.generic_cmd6_time);
+				EXT_CSD_CACHE_CTRL, 1, timeout_ms);
 		if (err && err !=3D -EBADMSG)
 			goto free_card;
=20
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 81974ecdfcbc..1996467481e9 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -105,6 +105,7 @@ struct mmc_omap_slot {
 	unsigned int		vdd;
 	u16			saved_con;
 	u16			bus_mode;
+	u16			power_mode;
 	unsigned int		fclk_freq;
=20
 	struct tasklet_struct	cover_tasklet;
@@ -1155,7 +1156,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, st=
ruct mmc_ios *ios)
 	struct mmc_omap_slot *slot =3D mmc_priv(mmc);
 	struct mmc_omap_host *host =3D slot->host;
 	int i, dsor;
-	int clk_enabled;
+	int clk_enabled, init_stream;
=20
 	mmc_omap_select_slot(slot, 0);
=20
@@ -1165,6 +1166,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, st=
ruct mmc_ios *ios)
 		slot->vdd =3D ios->vdd;
=20
 	clk_enabled =3D 0;
+	init_stream =3D 0;
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		mmc_omap_set_power(slot, 0, ios->vdd);
@@ -1172,13 +1174,17 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, =
struct mmc_ios *ios)
 	case MMC_POWER_UP:
 		/* Cannot touch dsor yet, just power up MMC */
 		mmc_omap_set_power(slot, 1, ios->vdd);
+		slot->power_mode =3D ios->power_mode;
 		goto exit;
 	case MMC_POWER_ON:
 		mmc_omap_fclk_enable(host, 1);
 		clk_enabled =3D 1;
 		dsor |=3D 1 << 11;
+		if (slot->power_mode !=3D MMC_POWER_ON)
+			init_stream =3D 1;
 		break;
 	}
+	slot->power_mode =3D ios->power_mode;
=20
 	if (slot->bus_mode !=3D ios->bus_mode) {
 		if (slot->pdata->set_bus_mode !=3D NULL)
@@ -1194,7 +1200,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, st=
ruct mmc_ios *ios)
 	for (i =3D 0; i < 2; i++)
 		OMAP_MMC_WRITE(host, CON, dsor);
 	slot->saved_con =3D dsor;
-	if (ios->power_mode =3D=3D MMC_POWER_ON) {
+	if (init_stream) {
 		/* worst case at 400kHz, 80 cycles makes 200 microsecs */
 		int usecs =3D 250;
=20
@@ -1232,6 +1238,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *ho=
st, int id)
 	slot->host =3D host;
 	slot->mmc =3D mmc;
 	slot->id =3D id;
+	slot->power_mode =3D MMC_POWER_OFF;
 	slot->pdata =3D &host->pdata->slots[id];
=20
 	host->slots[id] =3D slot;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a0a02a8a572e..2c0b99bb1e3a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1964,7 +1964,6 @@ static int omap_hsmmc_probe(struct platform_device *p=
dev)
 	mmc->max_blk_size =3D 512;       /* Block Length at max can be 1024 */
 	mmc->max_blk_count =3D 0xFFFF;    /* No. of Blocks is 16 bits */
 	mmc->max_req_size =3D mmc->max_blk_size * mmc->max_blk_count;
-	mmc->max_seg_size =3D mmc->max_req_size;
=20
 	mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
@@ -2021,6 +2020,17 @@ static int omap_hsmmc_probe(struct platform_device *=
pdev)
 		goto err_irq;
 	}
=20
+	/*
+	 * Limit the maximum segment size to the lower of the request size
+	 * and the DMA engine device segment size limits.  In reality, with
+	 * 32-bit transfers, the DMA engine can do longer segments than this
+	 * but there is no way to represent that in the DMA model - if we
+	 * increase this figure here, we get warnings from the DMA API debug.
+	 */
+	mmc->max_seg_size =3D min3(mmc->max_req_size,
+			dma_get_max_seg_size(host->rx_chan->device->dev),
+			dma_get_max_seg_size(host->tx_chan->device->dev));
+
 	/* Request IRQ for MMC operations */
 	ret =3D devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0,
 			mmc_hostname(mmc), host);
diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index c49d0b127fef..0b84840cdbb0 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -200,7 +200,7 @@ comment "Disk-On-Chip Device Drivers"
 config MTD_DOCG3
 	tristate "M-Systems Disk-On-Chip G3"
 	select BCH
-	select BCH_CONST_PARAMS
+	select BCH_CONST_PARAMS if !MTD_NAND_BCH
 	select BITREVERSE
 	---help---
 	  This provides an MTD device driver for the M-Systems DiskOnChip
diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-qu=
adspi.c
index 56d39f2b22ce..89173e8a0c16 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -451,6 +451,9 @@ fsl_qspi_runcmd(struct fsl_qspi *q, u8 cmd, unsigned in=
t addr, int len)
=20
 	/* trigger the LUT now */
 	seqid =3D fsl_qspi_get_seqid(q, cmd);
+	if (seqid < 0)
+		return seqid;
+
 	writel((seqid << QUADSPI_IPCR_SEQID_SHIFT) | len, base + QUADSPI_IPCR);
=20
 	/* Wait for the interrupt. */
@@ -574,7 +577,7 @@ static void fsl_qspi_set_map_addr(struct fsl_qspi *q)
  * causes the controller to clear the buffer, and use the sequence pointed
  * by the QUADSPI_BFGENCR[SEQID] to initiate a read from the flash.
  */
-static void fsl_qspi_init_abh_read(struct fsl_qspi *q)
+static int fsl_qspi_init_ahb_read(struct fsl_qspi *q)
 {
 	void __iomem *base =3D q->iobase;
 	int seqid;
@@ -592,8 +595,13 @@ static void fsl_qspi_init_abh_read(struct fsl_qspi *q)
=20
 	/* Set the default lut sequence for AHB Read. */
 	seqid =3D fsl_qspi_get_seqid(q, q->nor[0].read_opcode);
+	if (seqid < 0)
+		return seqid;
+
 	writel(seqid << QUADSPI_BFGENCR_SEQID_SHIFT,
 		q->iobase + QUADSPI_BFGENCR);
+
+	return 0;
 }
=20
 /* We use this function to do some basic init for spi_nor_scan(). */
@@ -647,9 +655,7 @@ static int fsl_qspi_nor_setup_last(struct fsl_qspi *q)
 	fsl_qspi_init_lut(q);
=20
 	/* Init for AHB read */
-	fsl_qspi_init_abh_read(q);
-
-	return 0;
+	return fsl_qspi_init_ahb_read(q);
 }
=20
 static struct of_device_id fsl_qspi_dt_ids[] =3D {
diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index dafc042a5f17..fbb67db07c57 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -422,6 +422,34 @@ void can_put_echo_skb(struct sk_buff *skb, struct net_=
device *dev,
 }
 EXPORT_SYMBOL_GPL(can_put_echo_skb);
=20
+struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int id=
x, u8 *len_ptr)
+{
+	struct can_priv *priv =3D netdev_priv(dev);
+	struct sk_buff *skb =3D priv->echo_skb[idx];
+	struct canfd_frame *cf;
+
+	if (idx >=3D priv->echo_skb_max) {
+		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bou=
nds (%u/max %u)\n",
+			   __func__, idx, priv->echo_skb_max);
+		return NULL;
+	}
+
+	if (!skb) {
+		netdev_err(dev, "%s: BUG! Trying to echo non existing skb: can_priv::ech=
o_skb[%u]\n",
+			   __func__, idx);
+		return NULL;
+	}
+
+	/* Using "struct canfd_frame::len" for the frame
+	 * length is supported on both CAN and CANFD frames.
+	 */
+	cf =3D (struct canfd_frame *)skb->data;
+	*len_ptr =3D cf->len;
+	priv->echo_skb[idx] =3D NULL;
+
+	return skb;
+}
+
 /*
  * Get the skb from the stack and loop it back locally
  *
@@ -431,22 +459,16 @@ EXPORT_SYMBOL_GPL(can_put_echo_skb);
  */
 unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
 {
-	struct can_priv *priv =3D netdev_priv(dev);
-
-	BUG_ON(idx >=3D priv->echo_skb_max);
-
-	if (priv->echo_skb[idx]) {
-		struct sk_buff *skb =3D priv->echo_skb[idx];
-		struct can_frame *cf =3D (struct can_frame *)skb->data;
-		u8 dlc =3D cf->can_dlc;
+	struct sk_buff *skb;
+	u8 len;
=20
-		netif_rx(priv->echo_skb[idx]);
-		priv->echo_skb[idx] =3D NULL;
+	skb =3D __can_get_echo_skb(dev, idx, &len);
+	if (!skb)
+		return 0;
=20
-		return dlc;
-	}
+	netif_rx(skb);
=20
-	return 0;
+	return len;
 }
 EXPORT_SYMBOL_GPL(can_get_echo_skb);
=20
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/eth=
ernet/broadcom/genet/bcmmii.c
index add8d8596084..da62cc910fb7 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -410,7 +410,7 @@ static int bcmgenet_mii_of_init(struct bcmgenet_priv *p=
riv)
 	if (!compat)
 		return -ENOMEM;
=20
-	mdio_dn =3D of_find_compatible_node(dn, NULL, compat);
+	mdio_dn =3D of_get_compatible_child(dn, compat);
 	kfree(compat);
 	if (!mdio_dn) {
 		dev_err(kdev, "unable to find MDIO bus node\n");
diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cad=
ence/macb.c
index 996b3b7d93ec..ced827330d98 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -629,11 +629,19 @@ static void gem_rx_refill(struct macb *bp)
=20
 			if (entry =3D=3D RX_RING_SIZE - 1)
 				paddr |=3D MACB_BIT(RX_WRAP);
-			bp->rx_ring[entry].addr =3D paddr;
 			bp->rx_ring[entry].ctrl =3D 0;
+			/* Setting addr clears RX_USED and allows reception,
+			 * make sure ctrl is cleared first to avoid a race.
+			 */
+			wmb();
+			bp->rx_ring[entry].addr =3D paddr;
=20
 			/* properly align Ethernet header */
 			skb_reserve(skb, NET_IP_ALIGN);
+		} else {
+			bp->rx_ring[entry].ctrl =3D 0;
+			wmb();
+			bp->rx_ring[entry].addr &=3D ~MACB_BIT(RX_USED);
 		}
 	}
=20
@@ -683,11 +691,15 @@ static int gem_rx(struct macb *bp, int budget)
 		rmb();
=20
 		addr =3D desc->addr;
-		ctrl =3D desc->ctrl;
=20
 		if (!(addr & MACB_BIT(RX_USED)))
 			break;
=20
+		/* Ensure ctrl is at least as up-to-date as rxused */
+		rmb();
+
+		ctrl =3D desc->ctrl;
+
 		bp->rx_tail++;
 		count++;
=20
@@ -830,11 +842,15 @@ static int macb_rx(struct macb *bp, int budget)
 		rmb();
=20
 		addr =3D desc->addr;
-		ctrl =3D desc->ctrl;
=20
 		if (!(addr & MACB_BIT(RX_USED)))
 			break;
=20
+		/* Ensure ctrl is at least as up-to-date as addr */
+		rmb();
+
+		ctrl =3D desc->ctrl;
+
 		if (ctrl & MACB_BIT(RX_SOF)) {
 			if (first_frag !=3D -1)
 				discard_partial_frame(bp, first_frag, tail);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/=
ethernet/mellanox/mlx4/en_ethtool.c
index 9885108fcd1b..05bed4118d14 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -498,8 +498,8 @@ static int mlx4_en_set_pauseparam(struct net_device *de=
v,
=20
 	tx_pause =3D !!(pause->tx_pause);
 	rx_pause =3D !!(pause->rx_pause);
-	rx_ppp =3D priv->prof->rx_ppp && !(tx_pause || rx_pause);
-	tx_ppp =3D priv->prof->tx_ppp && !(tx_pause || rx_pause);
+	rx_ppp =3D (tx_pause || rx_pause) ? 0 : priv->prof->rx_ppp;
+	tx_ppp =3D (tx_pause || rx_pause) ? 0 : priv->prof->tx_ppp;
=20
 	err =3D mlx4_SET_PORT_general(mdev->dev, priv->port,
 				    priv->rx_skb_size + ETH_FCS_LEN,
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4.h b/drivers/net/ethern=
et/mellanox/mlx4/mlx4.h
index 971ba25b919d..0baa98edb66a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
@@ -518,8 +518,8 @@ struct slave_list {
 struct resource_allocator {
 	spinlock_t alloc_lock; /* protect quotas */
 	union {
-		int res_reserved;
-		int res_port_rsvd[MLX4_MAX_PORTS];
+		unsigned int res_reserved;
+		unsigned int res_port_rsvd[MLX4_MAX_PORTS];
 	};
 	union {
 		int res_free;
diff --git a/drivers/net/ethernet/neterion/vxge/vxge-config.c b/drivers/net=
/ethernet/neterion/vxge/vxge-config.c
index 2bbd01fcb9b0..4332ebbd7162 100644
--- a/drivers/net/ethernet/neterion/vxge/vxge-config.c
+++ b/drivers/net/ethernet/neterion/vxge/vxge-config.c
@@ -808,7 +808,7 @@ __vxge_hw_vpath_fw_ver_get(struct __vxge_hw_virtualpath=
 *vpath,
 	struct vxge_hw_device_date *fw_date =3D &hw_info->fw_date;
 	struct vxge_hw_device_version *flash_version =3D &hw_info->flash_version;
 	struct vxge_hw_device_date *flash_date =3D &hw_info->flash_date;
-	u64 data0, data1 =3D 0, steer_ctrl =3D 0;
+	u64 data0 =3D 0, data1 =3D 0, steer_ctrl =3D 0;
 	enum vxge_hw_status status;
=20
 	status =3D vxge_hw_vpath_fw_api(vpath,
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.c b/drivers/net/=
ethernet/qlogic/qlcnic/qlcnic_dcb.c
index 561cb11ca58c..c6bdcefc12ea 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.c
@@ -883,7 +883,7 @@ static u8 qlcnic_dcb_get_capability(struct net_device *=
netdev, int capid,
 	struct qlcnic_adapter *adapter =3D netdev_priv(netdev);
=20
 	if (!test_bit(QLCNIC_DCB_STATE, &adapter->dcb->state))
-		return 0;
+		return 1;
=20
 	switch (capid) {
 	case DCB_CAP_ATTR_PG:
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/eth=
ernet/stmicro/stmmac/common.h
index 74610f3aca9e..1ad65fefa7aa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -272,7 +272,8 @@ struct dma_features {
=20
 /* GMAC TX FIFO is 8K, Rx FIFO is 16K */
 #define BUF_SIZE_16KiB 16384
-#define BUF_SIZE_8KiB 8192
+/* RX Buffer size must be < 8191 and multiple of 4/8/16 bytes */
+#define BUF_SIZE_8KiB 8188
 #define BUF_SIZE_4KiB 4096
 #define BUF_SIZE_2KiB 2048
=20
diff --git a/drivers/net/ethernet/stmicro/stmmac/descs_com.h b/drivers/net/=
ethernet/stmicro/stmmac/descs_com.h
index 6f2cc78c5cf5..166add5dc40b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/descs_com.h
+++ b/drivers/net/ethernet/stmicro/stmmac/descs_com.h
@@ -35,7 +35,7 @@
 /* Enhanced descriptors */
 static inline void ehn_desc_rx_set_on_ring(struct dma_desc *p, int end)
 {
-	p->des01.erx.buffer2_size =3D BUF_SIZE_8KiB - 1;
+	p->des01.erx.buffer2_size =3D BUF_SIZE_8KiB;
 	if (end)
 		p->des01.erx.end_ring =3D 1;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/e=
thernet/stmicro/stmmac/enh_desc.c
index 7d944449f5ef..9d64428a327a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -242,7 +242,7 @@ static void enh_desc_init_rx_desc(struct dma_desc *p, i=
nt disable_rx_ic,
 {
 	p->des01.all_flags =3D 0;
 	p->des01.erx.own =3D 1;
-	p->des01.erx.buffer1_size =3D BUF_SIZE_8KiB - 1;
+	p->des01.erx.buffer1_size =3D BUF_SIZE_8KiB;
=20
 	if (mode =3D=3D STMMAC_CHAIN_MODE)
 		ehn_desc_rx_set_on_chain(p, end);
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/=
ethernet/stmicro/stmmac/ring_mode.c
index 650a4be6bce5..2d1e652c3324 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -120,7 +120,7 @@ static void stmmac_clean_desc3(void *priv_ptr, struct d=
ma_desc *p)
 static int stmmac_set_16kib_bfsize(int mtu)
 {
 	int ret =3D 0;
-	if (unlikely(mtu >=3D BUF_SIZE_8KiB))
+	if (unlikely(mtu > BUF_SIZE_8KiB))
 		ret =3D BUF_SIZE_16KiB;
 	return ret;
 }
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 70a495733d81..7a6d2f8c5201 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -543,8 +543,6 @@ int phy_init_hw(struct phy_device *phydev)
=20
 	if (phydev->drv->soft_reset)
 		ret =3D phydev->drv->soft_reset(phydev);
-	else
-		ret =3D genphy_soft_reset(phydev);
=20
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
index 18cc2c8d5447..45b939b1506d 100644
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -215,9 +215,9 @@ static int rionet_start_xmit(struct sk_buff *skb, struc=
t net_device *ndev)
 			 * it just report sending a packet to the target
 			 * (without actual packet transfer).
 			 */
-			dev_kfree_skb_any(skb);
 			ndev->stats.tx_packets++;
 			ndev->stats.tx_bytes +=3D skb->len;
+			dev_kfree_skb_any(skb);
 		}
 	}
=20
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index d42bc7a55a03..6e98f32fdf5e 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -978,8 +978,6 @@ static void team_port_disable(struct team *team,
 	team->en_port_count--;
 	team_queue_override_port_del(team, port);
 	team_adjust_ops(team);
-	team_notify_peers(team);
-	team_mcast_rejoin(team);
 }
=20
 #define TEAM_VLAN_FEATURES (NETIF_F_ALL_CSUM | NETIF_F_SG | \
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b37e06722388..48ac45f26fa3 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1415,7 +1415,7 @@ static void tun_setup(struct net_device *dev)
  */
 static int tun_validate(struct nlattr *tb[], struct nlattr *data[])
 {
-	return -EINVAL;
+	return -EOPNOTSUPP;
 }
=20
 static struct rtnl_link_ops tun_link_ops __read_mostly =3D {
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index b1aeef151ed4..941d73b9baff 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2615,6 +2615,7 @@ static int vxlan_newlink(struct net *net, struct net_=
device *dev,
 	struct vxlan_dev *vxlan =3D netdev_priv(dev), *tmp;
 	struct vxlan_rdst *dst =3D &vxlan->default_dst;
 	struct vxlan_fdb *f =3D NULL;
+	bool unregister =3D false;
 	__u32 vni;
 	int err;
 	bool use_ipv6 =3D false;
@@ -2766,12 +2767,11 @@ static int vxlan_newlink(struct net *net, struct ne=
t_device *dev,
 	err =3D register_netdevice(dev);
 	if (err)
 		goto errout;
+	unregister =3D true;
=20
 	err =3D rtnl_configure_link(dev, NULL);
-	if (err) {
-		unregister_netdevice(dev);
+	if (err)
 		goto errout;
-	}
=20
 	/* notify default fdb entry */
 	if (f)
@@ -2780,9 +2780,16 @@ static int vxlan_newlink(struct net *net, struct net=
_device *dev,
 	list_add(&vxlan->next, &vn->vxlan_list);
=20
 	return 0;
+
 errout:
+	/* unregister_netdevice() destroys the default FDB entry with deletion
+	 * notification. But the addition notification was not sent yet, so
+	 * destroy the entry by hand here.
+	 */
 	if (f)
 		vxlan_fdb_destroy(vxlan, f);
+	if (unregister)
+		unregister_netdevice(dev);
 	return err;
 }
=20
diff --git a/drivers/net/wireless/iwlwifi/mvm/rs.c b/drivers/net/wireless/i=
wlwifi/mvm/rs.c
index e65714168e8e..a7572cd23e68 100644
--- a/drivers/net/wireless/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/iwlwifi/mvm/rs.c
@@ -1057,7 +1057,10 @@ static void rs_tx_status(void *mvm_r, struct ieee802=
11_supported_band *sband,
 	 */
 	table =3D &lq_sta->lq;
 	ucode_rate =3D le32_to_cpu(table->rs_table[0]);
-	rs_rate_from_ucode_rate(ucode_rate, info->band, &rate);
+	if (rs_rate_from_ucode_rate(ucode_rate, info->band, &rate)) {
+		WARN_ON_ONCE(1);
+		return;
+	}
 	if (info->band =3D=3D IEEE80211_BAND_5GHZ)
 		rate.index -=3D IWL_FIRST_OFDM_RATE;
 	mac_flags =3D info->status.rates[0].flags;
@@ -1161,7 +1164,10 @@ static void rs_tx_status(void *mvm_r, struct ieee802=
11_supported_band *sband,
 	 */
 	if (info->flags & IEEE80211_TX_STAT_AMPDU) {
 		ucode_rate =3D le32_to_cpu(table->rs_table[0]);
-		rs_rate_from_ucode_rate(ucode_rate, info->band, &rate);
+		if (rs_rate_from_ucode_rate(ucode_rate, info->band, &rate)) {
+			WARN_ON_ONCE(1);
+			return;
+		}
 		rs_collect_tx_data(lq_sta, curr_tbl, rate.index,
 				   info->status.ampdu_len,
 				   info->status.ampdu_ack_len,
@@ -1186,7 +1192,12 @@ static void rs_tx_status(void *mvm_r, struct ieee802=
11_supported_band *sband,
 		/* Collect data for each rate used during failed TX attempts */
 		for (i =3D 0; i <=3D retries; ++i) {
 			ucode_rate =3D le32_to_cpu(table->rs_table[i]);
-			rs_rate_from_ucode_rate(ucode_rate, info->band, &rate);
+			if (rs_rate_from_ucode_rate(ucode_rate, info->band,
+						    &rate)) {
+				WARN_ON_ONCE(1);
+				return;
+			}
+
 			/*
 			 * Only collect stats if retried rate is in the same RS
 			 * table as active/search.
@@ -2677,7 +2688,10 @@ static void rs_build_rates_table_from_fixed(struct i=
wl_mvm *mvm,
 	for (i =3D 0; i < num_rates; i++)
 		lq_cmd->rs_table[i] =3D ucode_rate_le32;
=20
-	rs_rate_from_ucode_rate(ucode_rate, band, &rate);
+	if (rs_rate_from_ucode_rate(ucode_rate, band, &rate)) {
+		WARN_ON_ONCE(1);
+		return;
+	}
=20
 	if (is_mimo(&rate))
 		lq_cmd->mimo_delim =3D num_rates - 1;
@@ -2928,8 +2942,11 @@ static void rs_program_fix_rate(struct iwl_mvm *mvm,
=20
 	if (lq_sta->dbg_fixed_rate) {
 		struct rs_rate rate;
-		rs_rate_from_ucode_rate(lq_sta->dbg_fixed_rate,
-					lq_sta->band, &rate);
+		if (rs_rate_from_ucode_rate(lq_sta->dbg_fixed_rate,
+					    lq_sta->band, &rate)) {
+			WARN_ON_ONCE(1);
+			return;
+		}
 		rs_fill_lq_cmd(mvm, NULL, lq_sta, &rate);
 		iwl_mvm_send_lq_cmd(lq_sta->drv, &lq_sta->lq, false);
 	}
diff --git a/drivers/net/wireless/libertas/if_usb.c b/drivers/net/wireless/=
libertas/if_usb.c
index dff08a2896a3..92821f8a1501 100644
--- a/drivers/net/wireless/libertas/if_usb.c
+++ b/drivers/net/wireless/libertas/if_usb.c
@@ -467,8 +467,6 @@ static int __if_usb_submit_rx_urb(struct if_usb_card *c=
ardp,
 			  MRVDRV_ETH_RX_PACKET_BUFFER_SIZE, callbackfn,
 			  cardp);
=20
-	cardp->rx_urb->transfer_flags |=3D URB_ZERO_PACKET;
-
 	lbs_deb_usb2(&cardp->udev->dev, "Pointer for rx_urb %p\n", cardp->rx_urb);
 	if ((ret =3D usb_submit_urb(cardp->rx_urb, GFP_ATOMIC))) {
 		lbs_deb_usbd(&cardp->udev->dev, "Submit Rx URB failed: %d\n", ret);
diff --git a/drivers/net/wireless/libertas_tf/if_usb.c b/drivers/net/wirele=
ss/libertas_tf/if_usb.c
index d576dd6665d3..cdb1afca58b6 100644
--- a/drivers/net/wireless/libertas_tf/if_usb.c
+++ b/drivers/net/wireless/libertas_tf/if_usb.c
@@ -610,9 +610,10 @@ static inline void process_cmdrequest(int recvlength, =
uint8_t *recvbuff,
 				      struct if_usb_card *cardp,
 				      struct lbtf_private *priv)
 {
-	if (recvlength > LBS_CMD_BUFFER_SIZE) {
+	if (recvlength < MESSAGE_HEADER_LEN ||
+	    recvlength > LBS_CMD_BUFFER_SIZE) {
 		lbtf_deb_usbd(&cardp->udev->dev,
-			     "The receive buffer is too large\n");
+			     "The receive buffer is invalid: %d\n", recvlength);
 		kfree_skb(skb);
 		return;
 	}
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/m=
ac80211_hwsim.c
index aa41c05dc014..da5e4d24f137 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2153,6 +2153,10 @@ static int mac80211_hwsim_create_radio(int channels,=
 const char *reg_alpha2,
 		schedule_timeout_interruptible(1);
 	}
=20
+	tasklet_hrtimer_init(&data->beacon_timer,
+			     mac80211_hwsim_beacon,
+			     CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+
 	err =3D ieee80211_register_hw(hw);
 	if (err < 0) {
 		printk(KERN_DEBUG "mac80211_hwsim: ieee80211_register_hw failed (%d)\n",
@@ -2174,10 +2178,6 @@ static int mac80211_hwsim_create_radio(int channels,=
 const char *reg_alpha2,
 				    data->debugfs,
 				    data, &hwsim_simulate_radar);
=20
-	tasklet_hrtimer_init(&data->beacon_timer,
-			     mac80211_hwsim_beacon,
-			     CLOCK_MONOTONIC_RAW, HRTIMER_MODE_ABS);
-
 	spin_lock_bh(&hwsim_radio_lock);
 	list_add_tail(&data->list, &hwsim_radios);
 	spin_unlock_bh(&hwsim_radio_lock);
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 9985665f7397..52d245587ba3 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -767,6 +767,31 @@ struct device_node *of_get_next_available_child(const =
struct device_node *node,
 }
 EXPORT_SYMBOL(of_get_next_available_child);
=20
+/**
+ * of_get_compatible_child - Find compatible child node
+ * @parent:	parent node
+ * @compatible:	compatible string
+ *
+ * Lookup child node whose compatible property contains the given compatib=
le
+ * string.
+ *
+ * Returns a node pointer with refcount incremented, use of_node_put() on =
it
+ * when done; or NULL if not found.
+ */
+struct device_node *of_get_compatible_child(const struct device_node *pare=
nt,
+				const char *compatible)
+{
+	struct device_node *child;
+
+	for_each_child_of_node(parent, child) {
+		if (of_device_is_compatible(child, compatible))
+			break;
+	}
+
+	return child;
+}
+EXPORT_SYMBOL(of_get_compatible_child);
+
 /**
  *	of_get_child_by_name - Find the child node by name for a given parent
  *	@node:	parent node
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index e1e7026b838d..0dc5f2bece17 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -646,7 +646,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	 * All PCIe functions are in one slot, remove one function will remove
 	 * the whole slot, so just wait until we are the last function left.
 	 */
-	if (!list_is_last(&pdev->bus_list, &parent->subordinate->devices))
+	if (!list_empty(&parent->subordinate->devices))
 		goto out;
=20
 	link =3D parent->link_state;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 35a6fc073730..f5d1f51101cf 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3068,7 +3068,11 @@ static void disable_igfx_irq(struct pci_dev *dev)
=20
 	pci_iounmap(dev, regs);
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0042, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0046, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x004a, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0106, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
=20
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 8bd76c9ba21c..74177dcb2646 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -25,9 +25,6 @@ static void pci_stop_dev(struct pci_dev *dev)
 		device_release_driver(&dev->dev);
 		dev->is_added =3D 0;
 	}
-
-	if (dev->bus->self)
-		pcie_aspm_exit_link_state(dev);
 }
=20
 static void pci_destroy_dev(struct pci_dev *dev)
@@ -41,6 +38,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
=20
+	pcie_aspm_exit_link_state(dev);
 	pci_free_resources(dev);
 	put_device(&dev->dev);
 }
diff --git a/drivers/pcmcia/ricoh.h b/drivers/pcmcia/ricoh.h
index 01098c841f87..8ac7b138c094 100644
--- a/drivers/pcmcia/ricoh.h
+++ b/drivers/pcmcia/ricoh.h
@@ -119,6 +119,10 @@
 #define  RL5C4XX_MISC_CONTROL           0x2F /* 8 bit */
 #define  RL5C4XX_ZV_ENABLE              0x08
=20
+/* Misc Control 3 Register */
+#define RL5C4XX_MISC3			0x00A2 /* 16 bit */
+#define  RL5C47X_MISC3_CB_CLKRUN_DIS	BIT(1)
+
 #ifdef __YENTA_H
=20
 #define rl_misc(socket)		((socket)->private[0])
@@ -156,6 +160,35 @@ static void ricoh_set_zv(struct yenta_socket *socket)
         }
 }
=20
+static void ricoh_set_clkrun(struct yenta_socket *socket, bool quiet)
+{
+	u16 misc3;
+
+	/*
+	 * RL5C475II likely has this setting, too, however no datasheet
+	 * is publicly available for this chip
+	 */
+	if (socket->dev->device !=3D PCI_DEVICE_ID_RICOH_RL5C476 &&
+	    socket->dev->device !=3D PCI_DEVICE_ID_RICOH_RL5C478)
+		return;
+
+	if (socket->dev->revision < 0x80)
+		return;
+
+	misc3 =3D config_readw(socket, RL5C4XX_MISC3);
+	if (misc3 & RL5C47X_MISC3_CB_CLKRUN_DIS) {
+		if (!quiet)
+			dev_dbg(&socket->dev->dev,
+				"CLKRUN feature already disabled\n");
+	} else if (disable_clkrun) {
+		if (!quiet)
+			dev_info(&socket->dev->dev,
+				 "Disabling CLKRUN feature\n");
+		misc3 |=3D RL5C47X_MISC3_CB_CLKRUN_DIS;
+		config_writew(socket, RL5C4XX_MISC3, misc3);
+	}
+}
+
 static void ricoh_save_state(struct yenta_socket *socket)
 {
 	rl_misc(socket) =3D config_readw(socket, RL5C4XX_MISC);
@@ -172,6 +205,7 @@ static void ricoh_restore_state(struct yenta_socket *so=
cket)
 	config_writew(socket, RL5C4XX_16BIT_IO_0, rl_io(socket));
 	config_writew(socket, RL5C4XX_16BIT_MEM_0, rl_mem(socket));
 	config_writew(socket, RL5C4XX_CONFIG, rl_config(socket));
+	ricoh_set_clkrun(socket, true);
 }
=20
=20
@@ -197,6 +231,7 @@ static int ricoh_override(struct yenta_socket *socket)
 	config_writew(socket, RL5C4XX_CONFIG, config);
=20
 	ricoh_set_zv(socket);
+	ricoh_set_clkrun(socket, false);
=20
 	return 0;
 }
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 946f90ef6020..04bf186886d6 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -26,7 +26,8 @@
=20
 static bool disable_clkrun;
 module_param(disable_clkrun, bool, 0444);
-MODULE_PARM_DESC(disable_clkrun, "If PC card doesn't function properly, pl=
ease try this option");
+MODULE_PARM_DESC(disable_clkrun,
+		 "If PC card doesn't function properly, please try this option (TI and R=
icoh bridges only)");
=20
 static bool isa_probe =3D 1;
 module_param(isa_probe, bool, 0444);
diff --git a/drivers/power/max8998_charger.c b/drivers/power/max8998_charge=
r.c
index 5017470c2fc9..b0f4fe5c157b 100644
--- a/drivers/power/max8998_charger.c
+++ b/drivers/power/max8998_charger.c
@@ -78,7 +78,7 @@ static int max8998_battery_get_property(struct power_supp=
ly *psy,
 static int max8998_battery_probe(struct platform_device *pdev)
 {
 	struct max8998_dev *iodev =3D dev_get_drvdata(pdev->dev.parent);
-	struct max8998_platform_data *pdata =3D dev_get_platdata(iodev->dev);
+	struct max8998_platform_data *pdata =3D iodev->pdata;
 	struct max8998_battery_data *max8998;
 	struct i2c_client *i2c;
 	int ret =3D 0;
diff --git a/drivers/rtc/rtc-hid-sensor-time.c b/drivers/rtc/rtc-hid-sensor=
-time.c
index 965a9da70867..4f4c336e9a64 100644
--- a/drivers/rtc/rtc-hid-sensor-time.c
+++ b/drivers/rtc/rtc-hid-sensor-time.c
@@ -213,7 +213,7 @@ static int hid_rtc_read_time(struct device *dev, struct=
 rtc_time *tm)
 	/* get a report with all values through requesting one value */
 	sensor_hub_input_attr_get_raw_value(time_state->common_attributes.hsdev,
 			HID_USAGE_SENSOR_TIME, hid_time_addresses[0],
-			time_state->info[0].report_id);
+			time_state->info[0].report_id, false);
 	/* wait for all values (event) */
 	ret =3D wait_for_completion_killable_timeout(
 			&time_state->comp_last_time, HZ*6);
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alia=
s.c
index 0aa661f3e453..9ce22828d71e 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -608,7 +608,8 @@ static int _schedule_lcu_update(struct alias_lcu *lcu,
=20
 int dasd_alias_add_device(struct dasd_device *device)
 {
-	struct dasd_eckd_private *private =3D device->private;
+	struct dasd_eckd_private *private =3D
+		(struct dasd_eckd_private *)device->private;
 	__u8 uaddr =3D private->uid.real_unit_addr;
 	struct alias_lcu *lcu =3D private->lcu;
 	unsigned long flags;
diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index b6ade163445c..bf6cab931472 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -57,6 +57,7 @@ struct virtio_ccw_device {
 	int err;
 	wait_queue_head_t wait_q;
 	spinlock_t lock;
+	struct mutex io_lock; /* Serializes I/O requests */
 	struct list_head virtqueues;
 	unsigned long indicators;
 	unsigned long indicators2;
@@ -282,6 +283,7 @@ static int ccw_io_helper(struct virtio_ccw_device *vcde=
v,
 	unsigned long flags;
 	int flag =3D intparm & VIRTIO_CCW_INTPARM_MASK;
=20
+	mutex_lock(&vcdev->io_lock);
 	do {
 		spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), flags);
 		ret =3D ccw_device_start(vcdev->cdev, ccw, intparm, 0, 0);
@@ -294,7 +296,9 @@ static int ccw_io_helper(struct virtio_ccw_device *vcde=
v,
 		cpu_relax();
 	} while (ret =3D=3D -EBUSY);
 	wait_event(vcdev->wait_q, doing_io(vcdev, flag) =3D=3D 0);
-	return ret ? ret : vcdev->err;
+	ret =3D ret ? ret : vcdev->err;
+	mutex_unlock(&vcdev->io_lock);
+	return ret;
 }
=20
 static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
@@ -741,6 +745,7 @@ static void virtio_ccw_get_config(struct virtio_device =
*vdev,
 	int ret;
 	struct ccw1 *ccw;
 	void *config_area;
+	unsigned long flags;
=20
 	ccw =3D kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
 	if (!ccw)
@@ -759,11 +764,13 @@ static void virtio_ccw_get_config(struct virtio_devic=
e *vdev,
 	if (ret)
 		goto out_free;
=20
+	spin_lock_irqsave(&vcdev->lock, flags);
 	memcpy(vcdev->config, config_area, offset + len);
-	if (buf)
-		memcpy(buf, &vcdev->config[offset], len);
 	if (vcdev->config_ready < offset + len)
 		vcdev->config_ready =3D offset + len;
+	spin_unlock_irqrestore(&vcdev->lock, flags);
+	if (buf)
+		memcpy(buf, config_area + offset, len);
=20
 out_free:
 	kfree(config_area);
@@ -777,6 +784,7 @@ static void virtio_ccw_set_config(struct virtio_device =
*vdev,
 	struct virtio_ccw_device *vcdev =3D to_vc_device(vdev);
 	struct ccw1 *ccw;
 	void *config_area;
+	unsigned long flags;
=20
 	ccw =3D kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
 	if (!ccw)
@@ -789,9 +797,11 @@ static void virtio_ccw_set_config(struct virtio_device=
 *vdev,
 	/* Make sure we don't overwrite fields. */
 	if (vcdev->config_ready < offset)
 		virtio_ccw_get_config(vdev, 0, NULL, offset);
+	spin_lock_irqsave(&vcdev->lock, flags);
 	memcpy(&vcdev->config[offset], buf, len);
 	/* Write the config area to the host. */
 	memcpy(config_area, vcdev->config, sizeof(vcdev->config));
+	spin_unlock_irqrestore(&vcdev->lock, flags);
 	ccw->cmd_code =3D CCW_CMD_WRITE_CONF;
 	ccw->flags =3D 0;
 	ccw->count =3D offset + len;
@@ -1080,6 +1090,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	init_waitqueue_head(&vcdev->wait_q);
 	INIT_LIST_HEAD(&vcdev->virtqueues);
 	spin_lock_init(&vcdev->lock);
+	mutex_init(&vcdev->io_lock);
=20
 	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
 	dev_set_drvdata(&cdev->dev, vcdev);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core=
_main.c
index 34209b33c70e..40fec0c463ea 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4414,8 +4414,8 @@ static int qeth_snmp_command_cb(struct qeth_card *car=
d,
 {
 	struct qeth_ipa_cmd *cmd;
 	struct qeth_arp_query_info *qinfo;
-	struct qeth_snmp_cmd *snmp;
 	unsigned char *data;
+	void *snmp_data;
 	__u16 data_len;
=20
 	QETH_CARD_TEXT(card, 3, "snpcmdcb");
@@ -4423,7 +4423,6 @@ static int qeth_snmp_command_cb(struct qeth_card *car=
d,
 	cmd =3D (struct qeth_ipa_cmd *) sdata;
 	data =3D (unsigned char *)((char *)cmd - reply->offset);
 	qinfo =3D (struct qeth_arp_query_info *) reply->param;
-	snmp =3D &cmd->data.setadapterparms.data.snmp;
=20
 	if (cmd->hdr.return_code) {
 		QETH_CARD_TEXT_(card, 4, "scer1%i", cmd->hdr.return_code);
@@ -4436,10 +4435,15 @@ static int qeth_snmp_command_cb(struct qeth_card *c=
ard,
 		return 0;
 	}
 	data_len =3D *((__u16 *)QETH_IPA_PDU_LEN_PDU1(data));
-	if (cmd->data.setadapterparms.hdr.seq_no =3D=3D 1)
-		data_len -=3D (__u16)((char *)&snmp->data - (char *)cmd);
-	else
-		data_len -=3D (__u16)((char *)&snmp->request - (char *)cmd);
+	if (cmd->data.setadapterparms.hdr.seq_no =3D=3D 1) {
+		snmp_data =3D &cmd->data.setadapterparms.data.snmp;
+		data_len -=3D offsetof(struct qeth_ipa_cmd,
+				     data.setadapterparms.data.snmp);
+	} else {
+		snmp_data =3D &cmd->data.setadapterparms.data.snmp.request;
+		data_len -=3D offsetof(struct qeth_ipa_cmd,
+				     data.setadapterparms.data.snmp.request);
+	}
=20
 	/* check if there is enough room in userspace */
 	if ((qinfo->udata_len - qinfo->udata_offset) < data_len) {
@@ -4452,16 +4456,9 @@ static int qeth_snmp_command_cb(struct qeth_card *ca=
rd,
 	QETH_CARD_TEXT_(card, 4, "sseqn%i",
 		cmd->data.setadapterparms.hdr.seq_no);
 	/*copy entries to user buffer*/
-	if (cmd->data.setadapterparms.hdr.seq_no =3D=3D 1) {
-		memcpy(qinfo->udata + qinfo->udata_offset,
-		       (char *)snmp,
-		       data_len + offsetof(struct qeth_snmp_cmd, data));
-		qinfo->udata_offset +=3D offsetof(struct qeth_snmp_cmd, data);
-	} else {
-		memcpy(qinfo->udata + qinfo->udata_offset,
-		       (char *)&snmp->request, data_len);
-	}
+	memcpy(qinfo->udata + qinfo->udata_offset, snmp_data, data_len);
 	qinfo->udata_offset +=3D data_len;
+
 	/* check if all replies received ... */
 		QETH_CARD_TEXT_(card, 4, "srtot%i",
 			       cmd->data.setadapterparms.hdr.used_total);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_mai=
n.c
index 784ba56bb5d3..ac58a8132402 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -856,7 +856,10 @@ static int __qeth_l2_open(struct net_device *dev)
=20
 	if (qdio_stop_irq(card->data.ccwdev, 0) >=3D 0) {
 		napi_enable(&card->napi);
+		local_bh_disable();
 		napi_schedule(&card->napi);
+		/* kick-start the NAPI softirq: */
+		local_bh_enable();
 	} else
 		rc =3D -EIO;
 	return rc;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_mai=
n.c
index 4ba6cf34e522..4276369d3da1 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -3127,7 +3127,10 @@ static int __qeth_l3_open(struct net_device *dev)
=20
 	if (qdio_stop_irq(card->data.ccwdev, 0) >=3D 0) {
 		napi_enable(&card->napi);
+		local_bh_disable();
 		napi_schedule(&card->napi);
+		/* kick-start the NAPI softirq: */
+		local_bh_enable();
 	} else
 		rc =3D -EIO;
 	return rc;
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc=
_fcoe.c
index a190ab663133..8fbf01ad2890 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -2201,7 +2201,8 @@ static int _bnx2fc_create(struct net_device *netdev,
 	interface =3D bnx2fc_interface_create(hba, netdev, fip_mode);
 	if (!interface) {
 		printk(KERN_ERR PFX "bnx2fc_interface_create failed\n");
-		goto ifput_err;
+		rc =3D -ENOMEM;
+		goto netdev_err;
 	}
=20
 	if (netdev->priv_flags & IFF_802_1Q_VLAN) {
diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index 55548dc5cec3..cc674370b4b0 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -1316,6 +1316,7 @@ static int esp_data_bytes_sent(struct esp *esp, struc=
t esp_cmd_entry *ent,
=20
 	bytes_sent =3D esp->data_dma_len;
 	bytes_sent -=3D ecount;
+	bytes_sent -=3D esp->send_cmd_residual;
=20
 	if (!(ent->flags & ESP_CMD_FLAG_WRITE))
 		bytes_sent -=3D fifo_cnt;
diff --git a/drivers/scsi/esp_scsi.h b/drivers/scsi/esp_scsi.h
index cd68805e8d78..20b229b53639 100644
--- a/drivers/scsi/esp_scsi.h
+++ b/drivers/scsi/esp_scsi.h
@@ -524,6 +524,8 @@ struct esp {
=20
 	void			*dma;
 	int			dmarev;
+
+	u32			send_cmd_residual;
 };
=20
 /* A front-end driver for the ESP chip should do the following in
diff --git a/drivers/scsi/mac_esp.c b/drivers/scsi/mac_esp.c
index c1497fddf0b4..364eb9969e8c 100644
--- a/drivers/scsi/mac_esp.c
+++ b/drivers/scsi/mac_esp.c
@@ -426,6 +426,8 @@ static void mac_esp_send_pio_cmd(struct esp *esp, u32 a=
ddr, u32 esp_count,
 			scsi_esp_cmd(esp, ESP_CMD_TI);
 		}
 	}
+
+	esp->send_cmd_residual =3D esp_count;
 }
=20
 static int mac_esp_irq_pending(struct esp *esp)
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_ini=
t.c
index ec08cc55ae4d..c533c9ee80fa 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4667,7 +4667,7 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 					 * The next call disables the board
 					 * completely.
 					 */
-					ha->isp_ops->reset_adapter(vha);
+					qla2x00_abort_isp_cleanup(vha);
 					vha->flags.online =3D 0;
 					clear_bit(ISP_ABORT_RETRY,
 					    &vha->dpc_flags);
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 1c33a77db5c2..50f5e6043268 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -3264,10 +3264,7 @@ qla2x00_set_idma_speed(scsi_qla_host_t *vha, uint16_=
t loop_id,
 	mcp->mb[0] =3D MBC_PORT_PARAMS;
 	mcp->mb[1] =3D loop_id;
 	mcp->mb[2] =3D BIT_0;
-	if (IS_CNA_CAPABLE(vha->hw))
-		mcp->mb[3] =3D port_speed & (BIT_5|BIT_4|BIT_3|BIT_2|BIT_1|BIT_0);
-	else
-		mcp->mb[3] =3D port_speed & (BIT_2|BIT_1|BIT_0);
+	mcp->mb[3] =3D port_speed & (BIT_5|BIT_4|BIT_3|BIT_2|BIT_1|BIT_0);
 	mcp->mb[9] =3D vha->vp_idx;
 	mcp->out_mb =3D MBX_9|MBX_3|MBX_2|MBX_1|MBX_0;
 	mcp->in_mb =3D MBX_3|MBX_1|MBX_0;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index f88e3748cb18..184ffbc92eba 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -129,6 +129,7 @@ static DEFINE_MUTEX(sd_ref_mutex);
=20
 static struct kmem_cache *sd_cdb_cache;
 static mempool_t *sd_cdb_pool;
+static mempool_t *sd_page_pool;
=20
 static const char *sd_cache_types[] =3D {
 	"write through", "none", "write back",
@@ -704,9 +705,10 @@ static int sd_setup_discard_cmnd(struct scsi_device *s=
dp, struct request *rq)
=20
 	memset(rq->cmd, 0, rq->cmd_len);
=20
-	page =3D alloc_page(GFP_ATOMIC | __GFP_ZERO);
+	page =3D mempool_alloc(sd_page_pool, GFP_ATOMIC);
 	if (!page)
 		return BLKPREP_DEFER;
+	clear_highpage(page);
=20
 	switch (sdkp->provisioning_mode) {
 	case SD_LBP_UNMAP:
@@ -758,7 +760,7 @@ static int sd_setup_discard_cmnd(struct scsi_device *sd=
p, struct request *rq)
=20
 out:
 	if (ret !=3D BLKPREP_OK)
-		__free_page(page);
+		mempool_free(page, sd_page_pool);
 	return ret;
 }
=20
@@ -3260,6 +3262,13 @@ static int __init init_sd(void)
 		goto err_out_cache;
 	}
=20
+	sd_page_pool =3D mempool_create_page_pool(SD_MEMPOOL_SIZE, 0);
+	if (!sd_page_pool) {
+		printk(KERN_ERR "sd: can't init discard page pool\n");
+		err =3D -ENOMEM;
+		goto err_out_ppool;
+	}
+
 	err =3D scsi_register_driver(&sd_template.gendrv);
 	if (err)
 		goto err_out_driver;
@@ -3267,6 +3276,9 @@ static int __init init_sd(void)
 	return 0;
=20
 err_out_driver:
+	mempool_destroy(sd_page_pool);
+
+err_out_ppool:
 	mempool_destroy(sd_cdb_pool);
=20
 err_out_cache:
@@ -3293,6 +3305,7 @@ static void __exit exit_sd(void)
=20
 	scsi_unregister_driver(&sd_template.gendrv);
 	mempool_destroy(sd_cdb_pool);
+	mempool_destroy(sd_page_pool);
 	kmem_cache_destroy(sd_cdb_cache);
=20
 	class_unregister(&sd_disk_class);
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index e53bff9f56b7..85f9cb77f08e 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -766,8 +766,8 @@ static int sh_msiof_spi_probe(struct platform_device *p=
dev)
=20
 	i =3D platform_get_irq(pdev, 0);
 	if (i < 0) {
-		dev_err(&pdev->dev, "cannot get platform IRQ\n");
-		ret =3D -ENOENT;
+		dev_err(&pdev->dev, "cannot get IRQ\n");
+		ret =3D i;
 		goto err1;
 	}
=20
diff --git a/drivers/staging/comedi/drivers/ni_mio_common.c b/drivers/stagi=
ng/comedi/drivers/ni_mio_common.c
index 83a96bcb21b6..325950a0bd4b 100644
--- a/drivers/staging/comedi/drivers/ni_mio_common.c
+++ b/drivers/staging/comedi/drivers/ni_mio_common.c
@@ -5486,6 +5486,9 @@ static int ni_valid_rtsi_output_source(struct comedi_=
device *dev, unsigned chan,
 	case NI_RTSI_OUTPUT_G_GATE0:
 	case NI_RTSI_OUTPUT_RGOUT0:
 	case NI_RTSI_OUTPUT_RTSI_BRD_0:
+	case NI_RTSI_OUTPUT_RTSI_BRD_0 + 1:
+	case NI_RTSI_OUTPUT_RTSI_BRD_0 + 2:
+	case NI_RTSI_OUTPUT_RTSI_BRD_0 + 3:
 		return 1;
 		break;
 	case NI_RTSI_OUTPUT_RTSI_OSC:
@@ -5513,12 +5516,19 @@ static int ni_set_rtsi_routing(struct comedi_device=
 *dev, unsigned chan,
 		    RTSI_Trig_Output_Bits(chan, source);
 		devpriv->stc_writew(dev, devpriv->rtsi_trig_a_output_reg,
 				    RTSI_Trig_A_Output_Register);
-	} else if (chan < 8) {
+	} else if (chan < num_configurable_rtsi_channels(dev)) {
 		devpriv->rtsi_trig_b_output_reg &=3D ~RTSI_Trig_Output_Mask(chan);
 		devpriv->rtsi_trig_b_output_reg |=3D
 		    RTSI_Trig_Output_Bits(chan, source);
 		devpriv->stc_writew(dev, devpriv->rtsi_trig_b_output_reg,
 				    RTSI_Trig_B_Output_Register);
+	} else if (chan !=3D old_RTSI_clock_channel) {
+		/* probably should never reach this, since the
+		 * ni_valid_rtsi_output_source above errors out if chan is too
+		 * high
+		 */
+		dev_err(dev->class_dev, "%s: unknown rtsi channel\n", __func__);
+		return -EINVAL;
 	}
 	return 2;
 }
@@ -5533,12 +5543,12 @@ static unsigned ni_get_rtsi_routing(struct comedi_d=
evice *dev, unsigned chan)
 	} else if (chan < num_configurable_rtsi_channels(dev)) {
 		return RTSI_Trig_Output_Source(chan,
 					       devpriv->rtsi_trig_b_output_reg);
-	} else {
-		if (chan =3D=3D old_RTSI_clock_channel)
-			return NI_RTSI_OUTPUT_RTSI_OSC;
-		printk("%s: bug! should never get here?\n", __func__);
-		return 0;
+	} else if (chan =3D=3D old_RTSI_clock_channel) {
+		return NI_RTSI_OUTPUT_RTSI_OSC;
 	}
+
+	dev_err(dev->class_dev, "%s: unknown rtsi channel\n", __func__);
+	return -EINVAL;
 }
=20
 static int ni_rtsi_insn_config(struct comedi_device *dev,
diff --git a/drivers/staging/comedi/drivers/quatech_daqp_cs.c b/drivers/sta=
ging/comedi/drivers/quatech_daqp_cs.c
index b3bbec0a0d23..21f4e7ef14c6 100644
--- a/drivers/staging/comedi/drivers/quatech_daqp_cs.c
+++ b/drivers/staging/comedi/drivers/quatech_daqp_cs.c
@@ -633,6 +633,19 @@ static int daqp_ai_cmd(struct comedi_device *dev, stru=
ct comedi_subdevice *s)
 	return 0;
 }
=20
+static int daqp_ao_empty(struct comedi_device *dev,
+			 struct comedi_subdevice *s,
+			 struct comedi_insn *insn,
+			 unsigned long context)
+{
+	unsigned int status;
+
+	status =3D inb(dev->iobase + DAQP_AUX);
+	if ((status & DAQP_AUX_DA_BUFFER) =3D=3D 0)
+		return 0;
+	return -EBUSY;
+}
+
 static int daqp_ao_insn_write(struct comedi_device *dev,
 			      struct comedi_subdevice *s,
 			      struct comedi_insn *insn,
@@ -640,7 +653,6 @@ static int daqp_ao_insn_write(struct comedi_device *dev,
 {
 	struct daqp_private *devpriv =3D dev->private;
 	unsigned int chan =3D CR_CHAN(insn->chanspec);
-	unsigned int val;
 	int i;
=20
 	if (devpriv->stop)
@@ -649,8 +661,15 @@ static int daqp_ao_insn_write(struct comedi_device *de=
v,
 	/* Make sure D/A update mode is direct update */
 	outb(0, dev->iobase + DAQP_AUX);
=20
-	for (i =3D 0; i > insn->n; i++) {
-		val =3D data[0];
+	for (i =3D 0; i < insn->n; i++) {
+		unsigned val =3D data[i];
+		int ret;
+
+		/* D/A transfer rate is about 8ms */
+		ret =3D comedi_timeout(dev, s, insn, daqp_ao_empty, 0);
+		if (ret)
+			return ret;
+
 		val &=3D 0x0fff;
 		val ^=3D 0x0800;		/* Flip the sign */
 		val |=3D (chan << 12);
diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712=
/mlme_linux.c
index 377efb88676f..1027786bcbb0 100644
--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -153,7 +153,7 @@ void r8712_report_sec_ie(struct _adapter *adapter, u8 a=
uthmode, u8 *sec_ie)
 		p =3D buff;
 		p +=3D sprintf(p, "ASSOCINFO(ReqIEs=3D");
 		len =3D sec_ie[1] + 2;
-		len =3D  (len < IW_CUSTOM_MAX) ? len : IW_CUSTOM_MAX - 1;
+		len =3D  (len < IW_CUSTOM_MAX) ? len : IW_CUSTOM_MAX;
 		for (i =3D 0; i < len; i++)
 			p +=3D sprintf(p, "%02x", sec_ie[i]);
 		p +=3D sprintf(p, ")");
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl87=
12/rtl871x_mlme.c
index 02339e100014..c0ece79c7821 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -1373,7 +1373,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, =
u8 *in_ie,
 		     u8 *out_ie, uint in_len)
 {
 	u8 authmode =3D 0, securitytype, match;
-	u8 sec_ie[255], uncst_oui[4], bkup_ie[255];
+	u8 sec_ie[IW_CUSTOM_MAX], uncst_oui[4], bkup_ie[255];
 	u8 wpa_oui[4] =3D {0x0, 0x50, 0xf2, 0x01};
 	uint ielength, cnt, remove_cnt;
 	int iEntry;
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 8803e693fe68..7a1625d5780b 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -351,8 +351,8 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
 	rcar_thermal_for_each_priv(priv, common) {
 		if (rcar_thermal_had_changed(priv, status)) {
 			rcar_thermal_irq_disable(priv);
-			schedule_delayed_work(&priv->work,
-					      msecs_to_jiffies(300));
+			queue_delayed_work(system_freezable_wq, &priv->work,
+					   msecs_to_jiffies(300));
 		}
 	}
=20
@@ -462,9 +462,10 @@ static int rcar_thermal_probe(struct platform_device *=
pdev)
=20
 error_unregister:
 	rcar_thermal_for_each_priv(priv, common) {
-		thermal_zone_device_unregister(priv->zone);
 		if (rcar_has_irq_support(priv))
 			rcar_thermal_irq_disable(priv);
+		cancel_delayed_work_sync(&priv->work);
+		thermal_zone_device_unregister(priv->zone);
 	}
=20
 	pm_runtime_put(dev);
@@ -480,9 +481,9 @@ static int rcar_thermal_remove(struct platform_device *=
pdev)
 	struct rcar_thermal_priv *priv;
=20
 	rcar_thermal_for_each_priv(priv, common) {
-		thermal_zone_device_unregister(priv->zone);
 		if (rcar_has_irq_support(priv))
 			rcar_thermal_irq_disable(priv);
+		thermal_zone_device_unregister(priv->zone);
 	}
=20
 	pm_runtime_put(dev);
diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index a260cde743e2..8b6638fc2d57 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -133,6 +133,11 @@ static void kgdboc_unregister_kbd(void)
=20
 static int kgdboc_option_setup(char *opt)
 {
+	if (!opt) {
+		pr_err("kgdboc: config string not provided\n");
+		return -EINVAL;
+	}
+
 	if (strlen(opt) >=3D MAX_CONFIG_LEN) {
 		printk(KERN_ERR "kgdboc: config string too long\n");
 		return -ENOSPC;
@@ -247,7 +252,7 @@ static void kgdboc_put_char(u8 chr)
=20
 static int param_set_kgdboc_var(const char *kmessage, struct kernel_param =
*kp)
 {
-	int len =3D strlen(kmessage);
+	size_t len =3D strlen(kmessage);
=20
 	if (len >=3D MAX_CONFIG_LEN) {
 		printk(KERN_ERR "kgdboc: config string too long\n");
@@ -269,7 +274,7 @@ static int param_set_kgdboc_var(const char *kmessage, s=
truct kernel_param *kp)
=20
 	strcpy(config, kmessage);
 	/* Chop out \n char as a result of echo */
-	if (config[len - 1] =3D=3D '\n')
+	if (len && config[len - 1] =3D=3D '\n')
 		config[len - 1] =3D '\0';
=20
 	if (configured =3D=3D 1)
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 7107991dc4cc..ee6a21308649 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -327,7 +327,7 @@ speed_t tty_termios_baud_rate(struct ktermios *termios)
 		else
 			cbaud +=3D 15;
 	}
-	return baud_table[cbaud];
+	return cbaud >=3D n_baud_table ? 0 : baud_table[cbaud];
 }
 EXPORT_SYMBOL(tty_termios_baud_rate);
=20
@@ -363,7 +363,7 @@ speed_t tty_termios_input_baud_rate(struct ktermios *te=
rmios)
 		else
 			cbaud +=3D 15;
 	}
-	return baud_table[cbaud];
+	return cbaud >=3D n_baud_table ? 0 : baud_table[cbaud];
 #else
 	return tty_termios_baud_rate(termios);
 #endif
diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 452cf8e98131..e0450c6924d1 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -852,14 +852,17 @@ int __uio_register_device(struct module *owner,
 	if (ret)
 		goto err_uio_dev_add_attributes;
=20
+	info->uio_dev =3D idev;
+
 	if (info->irq && (info->irq !=3D UIO_IRQ_CUSTOM)) {
 		ret =3D devm_request_irq(idev->dev, info->irq, uio_interrupt,
 				  info->irq_flags, info->name, idev);
-		if (ret)
+		if (ret) {
+			info->uio_dev =3D NULL;
 			goto err_request_irq;
+		}
 	}
=20
-	info->uio_dev =3D idev;
 	return 0;
=20
 err_request_irq:
diff --git a/drivers/usb/chipidea/otg.h b/drivers/usb/chipidea/otg.h
index 9ecb598e48f0..a5557c70034a 100644
--- a/drivers/usb/chipidea/otg.h
+++ b/drivers/usb/chipidea/otg.h
@@ -20,7 +20,8 @@ void ci_handle_vbus_change(struct ci_hdrc *ci);
 static inline void ci_otg_queue_work(struct ci_hdrc *ci)
 {
 	disable_irq_nosync(ci->irq);
-	queue_work(ci->wq, &ci->work);
+	if (queue_work(ci->wq, &ci->work) =3D=3D false)
+		enable_irq(ci->irq);
 }
=20
 #endif /* __DRIVERS_USB_CHIPIDEA_OTG_H */
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 530f1b36d4fe..7109eeaa2288 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1729,6 +1729,9 @@ static const struct usb_device_id acm_ids[] =3D {
 	{ USB_DEVICE(0x0572, 0x1328), /* Shiro / Aztech USB MODEM UM-3100 */
 	.driver_info =3D NO_UNION_NORMAL, /* has no union descriptor */
 	},
+	{ USB_DEVICE(0x0572, 0x1349), /* Hiro (Conexant) USB MODEM H50228 */
+	.driver_info =3D NO_UNION_NORMAL, /* has no union descriptor */
+	},
 	{ USB_DEVICE(0x20df, 0x0001), /* Simtec Electronics Entropy Key */
 	.driver_info =3D QUIRK_CONTROL_LINE_STATE, },
 	{ USB_DEVICE(0x2184, 0x001c) },	/* GW Instek AFG-2225 */
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index a8ee99e56071..cec7a62b4028 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2211,7 +2211,7 @@ static int usb_enumerate_device_otg(struct usb_device=
 *udev)
 		/* descriptor may appear anywhere in config */
 		if (__usb_get_extra_descriptor (udev->rawdescriptors[0],
 					le16_to_cpu(udev->config[0].desc.wTotalLength),
-					USB_DT_OTG, (void **) &desc) =3D=3D 0) {
+					USB_DT_OTG, (void **) &desc, sizeof(*desc)) =3D=3D 0) {
 			if (desc->bmAttributes & USB_OTG_HNP) {
 				unsigned		port1 =3D udev->portnum;
=20
@@ -2671,6 +2671,7 @@ static int hub_port_reset(struct usb_hub *hub, int po=
rt1,
 	int i, status;
 	u16 portchange, portstatus;
 	struct usb_port *port_dev =3D hub->ports[port1 - 1];
+	int reset_recovery_time;
=20
 	if (!hub_is_superspeed(hub->hdev)) {
 		if (warm) {
@@ -2724,7 +2725,9 @@ static int hub_port_reset(struct usb_hub *hub, int po=
rt1,
 					USB_PORT_FEAT_C_BH_PORT_RESET);
 			usb_clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_PORT_LINK_STATE);
-			usb_clear_port_feature(hub->hdev, port1,
+
+			if (udev)
+				usb_clear_port_feature(hub->hdev, port1,
 					USB_PORT_FEAT_C_CONNECTION);
=20
 			/*
@@ -2760,7 +2763,14 @@ static int hub_port_reset(struct usb_hub *hub, int p=
ort1,
 done:
 	if (status =3D=3D 0) {
 		/* TRSTRCY =3D 10 ms; plus some extra */
-		msleep(10 + 40);
+		reset_recovery_time =3D 10 + 40;
+
+		/* Hub needs extra delay after resetting its port. */
+		if (hub->hdev->quirks & USB_QUIRK_HUB_SLOW_RESET)
+			reset_recovery_time +=3D 100;
+
+		msleep(reset_recovery_time);
+
 		if (udev) {
 			struct usb_hcd *hcd =3D bus_to_hcd(udev->bus);
=20
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 7b722da17880..a11668825749 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -64,6 +64,9 @@ static const struct usb_device_id usb_quirk_list[] =3D {
 	/* Microsoft LifeCam-VX700 v2.0 */
 	{ USB_DEVICE(0x045e, 0x0770), .driver_info =3D USB_QUIRK_RESET_RESUME },
=20
+	/* Cherry Stream G230 2.0 (G85-231) and 3.0 (G85-232) */
+	{ USB_DEVICE(0x046a, 0x0023), .driver_info =3D USB_QUIRK_RESET_RESUME },
+
 	/* Logitech HD Pro Webcams C920, C920-C, C925e and C930e */
 	{ USB_DEVICE(0x046d, 0x082d), .driver_info =3D USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x046d, 0x0841), .driver_info =3D USB_QUIRK_DELAY_INIT },
@@ -182,6 +185,10 @@ static const struct usb_device_id usb_quirk_list[] =3D=
 {
 	/* Midiman M-Audio Keystation 88es */
 	{ USB_DEVICE(0x0763, 0x0192), .driver_info =3D USB_QUIRK_RESET_RESUME },
=20
+	/* SanDisk Ultra Fit and Ultra Flair */
+	{ USB_DEVICE(0x0781, 0x5583), .driver_info =3D USB_QUIRK_NO_LPM },
+	{ USB_DEVICE(0x0781, 0x5591), .driver_info =3D USB_QUIRK_NO_LPM },
+
 	/* M-Systems Flash Disk Pioneers */
 	{ USB_DEVICE(0x08ec, 0x1000), .driver_info =3D USB_QUIRK_RESET_RESUME },
=20
@@ -229,6 +236,9 @@ static const struct usb_device_id usb_quirk_list[] =3D {
 	{ USB_DEVICE(0x1a0a, 0x0200), .driver_info =3D
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
=20
+	/* Terminus Technology Inc. Hub */
+	{ USB_DEVICE(0x1a40, 0x0101), .driver_info =3D USB_QUIRK_HUB_SLOW_RESET },
+
 	/* Corsair K70 RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info =3D USB_QUIRK_DELAY_INIT },
=20
@@ -240,6 +250,9 @@ static const struct usb_device_id usb_quirk_list[] =3D {
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info =3D USB_QUIRK_DELAY_INIT |
 	  USB_QUIRK_DELAY_CTRL_MSG },
=20
+	/* Corsair K70 LUX RGB */
+	{ USB_DEVICE(0x1b1c, 0x1b33), .driver_info =3D USB_QUIRK_DELAY_INIT },
+
 	/* Corsair K70 LUX */
 	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info =3D USB_QUIRK_DELAY_INIT },
=20
@@ -260,6 +273,11 @@ static const struct usb_device_id usb_quirk_list[] =3D=
 {
 	{ USB_DEVICE(0x2040, 0x7200), .driver_info =3D
 			USB_QUIRK_CONFIG_INTF_STRINGS },
=20
+	/* Raydium Touchscreen */
+	{ USB_DEVICE(0x2386, 0x3114), .driver_info =3D USB_QUIRK_NO_LPM },
+
+	{ USB_DEVICE(0x2386, 0x3119), .driver_info =3D USB_QUIRK_NO_LPM },
+
 	/* DJI CineSSD */
 	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info =3D USB_QUIRK_NO_LPM },
=20
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index d885a07be4df..b35bde5e5e11 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -663,14 +663,14 @@ EXPORT_SYMBOL_GPL(usb_get_current_frame_number);
  */
=20
 int __usb_get_extra_descriptor(char *buffer, unsigned size,
-			       unsigned char type, void **ptr)
+			       unsigned char type, void **ptr, size_t minsize)
 {
 	struct usb_descriptor_header *header;
=20
 	while (size >=3D sizeof(struct usb_descriptor_header)) {
 		header =3D (struct usb_descriptor_header *)buffer;
=20
-		if (header->bLength < 2) {
+		if (header->bLength < 2 || header->bLength > size) {
 			printk(KERN_ERR
 				"%s: bogus descriptor, type %d length %d\n",
 				usbcore_name,
@@ -679,7 +679,7 @@ int __usb_get_extra_descriptor(char *buffer, unsigned s=
ize,
 			return -1;
 		}
=20
-		if (header->bDescriptorType =3D=3D type) {
+		if (header->bDescriptorType =3D=3D type && header->bLength >=3D minsize)=
 {
 			*ptr =3D header;
 			return 0;
 		}
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f8a20b88ccfd..1f45a444c07f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1346,9 +1346,6 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, in=
t value, int protocol)
 	memset(&params, 0x00, sizeof(params));
=20
 	if (value) {
-		if (dep->flags & DWC3_EP_STALL)
-			return 0;
-
 		if (!protocol && ((dep->direction && dep->flags & DWC3_EP_BUSY) ||
 				(!list_empty(&dep->req_queued) ||
 				 !list_empty(&dep->request_list)))) {
@@ -1365,9 +1362,6 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, in=
t value, int protocol)
 		else
 			dep->flags |=3D DWC3_EP_STALL;
 	} else {
-		if (!(dep->flags & DWC3_EP_STALL))
-			return 0;
-
 		ret =3D dwc3_send_gadget_ep_cmd(dwc, dep->number,
 			DWC3_DEPCMD_CLEARSTALL, &params);
 		if (ret)
diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc=
_core.c
index 28e4fc957026..5fd9135b72fd 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2256,8 +2256,10 @@ static int __init struct_udc_setup(struct fsl_udc *u=
dc,
 	udc->phy_mode =3D pdata->phy_mode;
=20
 	udc->eps =3D kzalloc(sizeof(struct fsl_ep) * udc->max_ep, GFP_KERNEL);
-	if (!udc->eps)
-		return -1;
+	if (!udc->eps) {
+		ERR("kmalloc udc endpoint status failed\n");
+		goto eps_alloc_failed;
+	}
=20
 	/* initialized QHs, take care of alignment */
 	size =3D udc->max_ep * sizeof(struct ep_queue_head);
@@ -2271,8 +2273,7 @@ static int __init struct_udc_setup(struct fsl_udc *ud=
c,
 					&udc->ep_qh_dma, GFP_KERNEL);
 	if (!udc->ep_qh) {
 		ERR("malloc QHs for udc failed\n");
-		kfree(udc->eps);
-		return -1;
+		goto ep_queue_alloc_failed;
 	}
=20
 	udc->ep_qh_size =3D size;
@@ -2281,8 +2282,17 @@ static int __init struct_udc_setup(struct fsl_udc *u=
dc,
 	/* FIXME: fsl_alloc_request() ignores ep argument */
 	udc->status_req =3D container_of(fsl_alloc_request(NULL, GFP_KERNEL),
 			struct fsl_req, req);
+	if (!udc->status_req) {
+		ERR("kzalloc for udc status request failed\n");
+		goto udc_status_alloc_failed;
+	}
+
 	/* allocate a small amount of memory to get valid address */
 	udc->status_req->req.buf =3D kmalloc(8, GFP_KERNEL);
+	if (!udc->status_req->req.buf) {
+		ERR("kzalloc for udc request buffer failed\n");
+		goto udc_req_buf_alloc_failed;
+	}
=20
 	udc->resume_state =3D USB_STATE_NOTATTACHED;
 	udc->usb_state =3D USB_STATE_POWERED;
@@ -2290,6 +2300,18 @@ static int __init struct_udc_setup(struct fsl_udc *u=
dc,
 	udc->remote_wakeup =3D 0;	/* default to 0 on reset */
=20
 	return 0;
+
+udc_req_buf_alloc_failed:
+	kfree(udc->status_req);
+udc_status_alloc_failed:
+	kfree(udc->ep_qh);
+	udc->ep_qh_size =3D 0;
+ep_queue_alloc_failed:
+	kfree(udc->eps);
+eps_alloc_failed:
+	udc->phy_mode =3D 0;
+	return -1;
+
 }
=20
 /*----------------------------------------------------------------
diff --git a/drivers/usb/host/hwa-hc.c b/drivers/usb/host/hwa-hc.c
index d0d8fadf7066..1931a2b029eb 100644
--- a/drivers/usb/host/hwa-hc.c
+++ b/drivers/usb/host/hwa-hc.c
@@ -654,7 +654,7 @@ static int hwahc_security_create(struct hwahc *hwahc)
 	top =3D itr + itr_size;
 	result =3D __usb_get_extra_descriptor(usb_dev->rawdescriptors[index],
 			le16_to_cpu(usb_dev->actconfig->desc.wTotalLength),
-			USB_DT_SECURITY, (void **) &secd);
+			USB_DT_SECURITY, (void **) &secd, sizeof(*secd));
 	if (result =3D=3D -1) {
 		dev_warn(dev, "BUG? WUSB host has no security descriptors\n");
 		return 0;
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index f16bf70b54ba..fd697bba07ff 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -620,7 +620,7 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
 			status |=3D USB_PORT_STAT_SUSPEND;
 	}
 	if ((raw_port_status & PORT_PLS_MASK) =3D=3D XDEV_RESUME &&
-			!DEV_SUPERSPEED(raw_port_status)) {
+		!DEV_SUPERSPEED(raw_port_status) && hcd->speed < HCD_USB3) {
 		if ((raw_port_status & PORT_RESET) ||
 				!(raw_port_status & PORT_PE))
 			return 0xffffffff;
@@ -666,7 +666,7 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
 			time_left =3D wait_for_completion_timeout(
 					&bus_state->rexit_done[wIndex],
 					msecs_to_jiffies(
-						XHCI_MAX_REXIT_TIMEOUT));
+						XHCI_MAX_REXIT_TIMEOUT_MS));
 			spin_lock_irqsave(&xhci->lock, flags);
=20
 			if (time_left) {
@@ -680,7 +680,7 @@ static u32 xhci_get_port_status(struct usb_hcd *hcd,
 			} else {
 				int port_status =3D readl(port_array[wIndex]);
 				xhci_warn(xhci, "Port resume took longer than %i msec, port status =3D=
 0x%x\n",
-						XHCI_MAX_REXIT_TIMEOUT,
+						XHCI_MAX_REXIT_TIMEOUT_MS,
 						port_status);
 				status |=3D USB_PORT_STAT_SUSPEND;
 				clear_bit(wIndex, &bus_state->rexit_ports);
@@ -1174,13 +1174,16 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
 	__le32 __iomem **port_array;
 	struct xhci_bus_state *bus_state;
 	unsigned long flags;
+	u32 portsc_buf[USB_MAXCHILDREN];
+	bool wake_enabled;
=20
 	max_ports =3D xhci_get_ports(hcd, &port_array);
 	bus_state =3D &xhci->bus_state[hcd_index(hcd)];
+	wake_enabled =3D hcd->self.root_hub->do_remote_wakeup;
=20
 	spin_lock_irqsave(&xhci->lock, flags);
=20
-	if (hcd->self.root_hub->do_remote_wakeup) {
+	if (wake_enabled) {
 		if (bus_state->resuming_ports ||	/* USB2 */
 		    bus_state->port_remote_wakeup) {	/* USB3 */
 			spin_unlock_irqrestore(&xhci->lock, flags);
@@ -1188,26 +1191,37 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
 			return -EBUSY;
 		}
 	}
-
-	port_index =3D max_ports;
+	/*
+	 * Prepare ports for suspend, but don't write anything before all ports
+	 * are checked and we know bus suspend can proceed
+	 */
 	bus_state->bus_suspended =3D 0;
+	port_index =3D max_ports;
 	while (port_index--) {
-		/* suspend the port if the port is not suspended */
 		u32 t1, t2;
-		int slot_id;
=20
 		t1 =3D readl(port_array[port_index]);
 		t2 =3D xhci_port_state_to_neutral(t1);
+		portsc_buf[port_index] =3D 0;
=20
-		if ((t1 & PORT_PE) && !(t1 & PORT_PLS_MASK)) {
-			xhci_dbg(xhci, "port %d not suspended\n", port_index);
-			slot_id =3D xhci_find_slot_id_by_port(hcd, xhci,
-					port_index + 1);
-			if (slot_id) {
+		/* Bail out if a USB3 port has a new device in link training */
+		if ((hcd->speed >=3D HCD_USB3) &&
+		    (t1 & PORT_PLS_MASK) =3D=3D XDEV_POLLING) {
+			bus_state->bus_suspended =3D 0;
+			spin_unlock_irqrestore(&xhci->lock, flags);
+			xhci_dbg(xhci, "Bus suspend bailout, port in polling\n");
+			return -EBUSY;
+		}
+
+		/* suspend ports in U0, or bail out for new connect changes */
+		if ((t1 & PORT_PE) && (t1 & PORT_PLS_MASK) =3D=3D XDEV_U0) {
+			if ((t1 & PORT_CSC) && wake_enabled) {
+				bus_state->bus_suspended =3D 0;
 				spin_unlock_irqrestore(&xhci->lock, flags);
-				xhci_stop_device(xhci, slot_id, 1);
-				spin_lock_irqsave(&xhci->lock, flags);
+				xhci_dbg(xhci, "Bus suspend bailout, port connect change\n");
+				return -EBUSY;
 			}
+			xhci_dbg(xhci, "port %d not suspended\n", port_index);
 			t2 &=3D ~PORT_PLS_MASK;
 			t2 |=3D PORT_LINK_STROBE | XDEV_U3;
 			set_bit(port_index, &bus_state->bus_suspended);
@@ -1216,7 +1230,7 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
 		 * including the USB 3.0 roothub, but only if CONFIG_PM_RUNTIME
 		 * is enabled, so also enable remote wake here.
 		 */
-		if (hcd->self.root_hub->do_remote_wakeup) {
+		if (wake_enabled) {
 			if (t1 & PORT_CONNECT) {
 				t2 |=3D PORT_WKOC_E | PORT_WKDISC_E;
 				t2 &=3D ~PORT_WKCONN_E;
@@ -1232,7 +1246,26 @@ int xhci_bus_suspend(struct usb_hcd *hcd)
=20
 		t1 =3D xhci_port_state_to_neutral(t1);
 		if (t1 !=3D t2)
-			writel(t2, port_array[port_index]);
+			portsc_buf[port_index] =3D t2;
+	}
+
+	/* write port settings, stopping and suspending ports if needed */
+	port_index =3D max_ports;
+	while (port_index--) {
+		if (!portsc_buf[port_index])
+			continue;
+		if (test_bit(port_index, &bus_state->bus_suspended)) {
+			int slot_id;
+
+			slot_id =3D xhci_find_slot_id_by_port(hcd, xhci,
+							    port_index + 1);
+			if (slot_id) {
+				spin_unlock_irqrestore(&xhci->lock, flags);
+				xhci_stop_device(xhci, slot_id, 1);
+				spin_lock_irqsave(&xhci->lock, flags);
+			}
+		}
+		writel(portsc_buf[port_index], port_array[port_index]);
 	}
 	hcd->state =3D HC_STATE_SUSPENDED;
 	bus_state->next_statechange =3D jiffies + msecs_to_jiffies(10);
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 06dd8d8a2f8a..6227764ffaa9 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -130,6 +130,10 @@ static void xhci_pci_quirks(struct device *dev, struct=
 xhci_hcd *xhci)
 		 pdev->device =3D=3D 0x43bb))
 		xhci->quirks |=3D XHCI_SUSPEND_DELAY;
=20
+	if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD &&
+	    (pdev->device =3D=3D 0x15e0 || pdev->device =3D=3D 0x15e1))
+		xhci->quirks |=3D XHCI_SNPS_BROKEN_SUSPEND;
+
 	if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD)
 		xhci->quirks |=3D XHCI_TRUST_TX_LENGTH;
=20
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index a37823354b72..1a308f971a7e 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1676,7 +1676,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
 	 * RExit to a disconnect state).  If so, let the the driver know it's
 	 * out of the RExit state.
 	 */
-	if (!DEV_SUPERSPEED(temp) &&
+	if (!DEV_SUPERSPEED(temp) && hcd->speed < HCD_USB3 &&
 			test_and_clear_bit(faked_port_index,
 				&bus_state->rexit_ports)) {
 		complete(&bus_state->rexit_done[faked_port_index]);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index a30b16b3c847..40f8ff381c44 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -908,6 +908,7 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
 	unsigned int		delay =3D XHCI_MAX_HALT_USEC;
 	struct usb_hcd		*hcd =3D xhci_to_hcd(xhci);
 	u32			command;
+	u32			res;
=20
 	if (hcd->state !=3D HC_STATE_SUSPENDED ||
 			xhci->shared_hcd->state !=3D HC_STATE_SUSPENDED)
@@ -954,11 +955,28 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeu=
p)
 	command =3D readl(&xhci->op_regs->command);
 	command |=3D CMD_CSS;
 	writel(command, &xhci->op_regs->command);
+	xhci->broken_suspend =3D 0;
 	if (xhci_handshake(xhci, &xhci->op_regs->status,
 				STS_SAVE, 0, 10 * 1000)) {
-		xhci_warn(xhci, "WARN: xHC save state timeout\n");
-		spin_unlock_irq(&xhci->lock);
-		return -ETIMEDOUT;
+	/*
+	 * AMD SNPS xHC 3.0 occasionally does not clear the
+	 * SSS bit of USBSTS and when driver tries to poll
+	 * to see if the xHC clears BIT(8) which never happens
+	 * and driver assumes that controller is not responding
+	 * and times out. To workaround this, its good to check
+	 * if SRE and HCE bits are not set (as per xhci
+	 * Section 5.4.2) and bypass the timeout.
+	 */
+		res =3D readl(&xhci->op_regs->status);
+		if ((xhci->quirks & XHCI_SNPS_BROKEN_SUSPEND) &&
+		    (((res & STS_SRE) =3D=3D 0) &&
+				((res & STS_HCE) =3D=3D 0))) {
+			xhci->broken_suspend =3D 1;
+		} else {
+			xhci_warn(xhci, "WARN: xHC save state timeout\n");
+			spin_unlock_irq(&xhci->lock);
+			return -ETIMEDOUT;
+		}
 	}
 	spin_unlock_irq(&xhci->lock);
=20
@@ -1007,7 +1025,7 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernate=
d)
 	set_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);
=20
 	spin_lock_irq(&xhci->lock);
-	if (xhci->quirks & XHCI_RESET_ON_RESUME)
+	if ((xhci->quirks & XHCI_RESET_ON_RESUME) || xhci->broken_suspend)
 		hibernated =3D true;
=20
 	if (!hibernated) {
@@ -4448,9 +4466,25 @@ static u16 xhci_call_host_update_timeout_for_endpoin=
t(struct xhci_hcd *xhci,
 		u16 *timeout)
 {
 	if (state =3D=3D USB3_LPM_U1) {
+		/* Prevent U1 if service interval is shorter than U1 exit latency */
+		if (usb_endpoint_xfer_int(desc) || usb_endpoint_xfer_isoc(desc)) {
+			if (xhci_service_interval_to_ns(desc) <=3D udev->u1_params.mel) {
+				dev_dbg(&udev->dev, "Disable U1, ESIT shorter than exit latency\n");
+				return USB3_LPM_DISABLED;
+			}
+		}
+
 		if (xhci->quirks & XHCI_INTEL_HOST)
 			return xhci_calculate_intel_u1_timeout(udev, desc);
 	} else {
+		/* Prevent U2 if service interval is shorter than U2 exit latency */
+		if (usb_endpoint_xfer_int(desc) || usb_endpoint_xfer_isoc(desc)) {
+			if (xhci_service_interval_to_ns(desc) <=3D udev->u2_params.mel) {
+				dev_dbg(&udev->dev, "Disable U2, ESIT shorter than exit latency\n");
+				return USB3_LPM_DISABLED;
+			}
+		}
+
 		if (xhci->quirks & XHCI_INTEL_HOST)
 			return xhci_calculate_intel_u2_timeout(udev, desc);
 	}
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index df47cb8e5ec8..feb702516470 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1433,7 +1433,7 @@ struct xhci_bus_state {
  * It can take up to 20 ms to transition from RExit to U0 on the
  * Intel Lynx Point LP xHCI host.
  */
-#define	XHCI_MAX_REXIT_TIMEOUT	(20 * 1000)
+#define	XHCI_MAX_REXIT_TIMEOUT_MS	20
=20
 static inline unsigned int hcd_index(struct usb_hcd *hcd)
 {
@@ -1572,6 +1572,7 @@ struct xhci_hcd {
 #define XHCI_U2_DISABLE_WAKE	(1 << 27)
 #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
 #define XHCI_SUSPEND_DELAY	(1 << 30)
+#define XHCI_SNPS_BROKEN_SUSPEND    BIT(31)
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
 	/* There are two roothubs to keep track of bus suspend info for */
@@ -1588,6 +1589,8 @@ struct xhci_hcd {
 	unsigned		sw_lpm_support:1;
 	/* support xHCI 1.0 spec USB2 hardware LPM */
 	unsigned		hw_lpm_support:1;
+	/* Broken Suspend flag for SNPS Suspend resume issue */
+	unsigned		broken_suspend:1;
 	/* cached usb2 extened protocol capabilites */
 	u32                     *ext_caps;
 	unsigned int            num_ext_caps;
diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledispla=
y.c
index b3d245ef46ef..a1648fe0937e 100644
--- a/drivers/usb/misc/appledisplay.c
+++ b/drivers/usb/misc/appledisplay.c
@@ -63,6 +63,8 @@ static const struct usb_device_id appledisplay_table[] =
=3D {
 	{ APPLEDISPLAY_DEVICE(0x9219) },
 	{ APPLEDISPLAY_DEVICE(0x921c) },
 	{ APPLEDISPLAY_DEVICE(0x921d) },
+	{ APPLEDISPLAY_DEVICE(0x9222) },
+	{ APPLEDISPLAY_DEVICE(0x9226) },
 	{ APPLEDISPLAY_DEVICE(0x9236) },
=20
 	/* Terminating entry */
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m=
8.c
index 244acb1299a9..e92cd1eceefa 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -773,7 +773,7 @@ static void cypress_send(struct usb_serial_port *port)
=20
 	usb_fill_int_urb(port->interrupt_out_urb, port->serial->dev,
 		usb_sndintpipe(port->serial->dev, port->interrupt_out_endpointAddress),
-		port->interrupt_out_buffer, port->interrupt_out_size,
+		port->interrupt_out_buffer, actual_size,
 		cypress_write_int_callback, port, priv->write_urb_interval);
 	result =3D usb_submit_urb(port->interrupt_out_urb, GFP_ATOMIC);
 	if (result) {
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 93e7fcf18088..0ec4a883b614 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1888,6 +1888,7 @@ static const struct usb_device_id option_ids[] =3D {
 	{ USB_DEVICE_AND_INTERFACE_INFO(ALINK_VENDOR_ID, ALINK_PRODUCT_3GU, 0xff,=
 0xff, 0xff) },
 	{ USB_DEVICE(ALINK_VENDOR_ID, SIMCOM_PRODUCT_SIM7100E),
 	  .driver_info =3D (kernel_ulong_t)&simcom_sim7100e_blacklist },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1e0e, 0x9003, 0xff) },	/* Simcom SIM7500/S=
IM7600 MBIM mode */
 	{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_X060S_X200),
 	  .driver_info =3D (kernel_ulong_t)&alcatel_x200_blacklist
 	},
@@ -2075,7 +2076,12 @@ static const struct usb_device_id option_ids[] =3D {
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_WM=
D200, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_68=
02, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_WM=
D300, 0xff, 0xff, 0xff) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x421d, 0xff, 0xff, 0xff) }, /* H=
P lt2523 (Novatel E371) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x421d, 0xff, 0xff, 0xff) },	/* H=
P lt2523 (Novatel E371) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x10) },	/* H=
P lt4132 (Huawei ME906s-158) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x12) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x13) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x14) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x1b) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/drivers/usb/storage/unusual_realtek.h b/drivers/usb/storage/un=
usual_realtek.h
index e41f50c95ed4..f5fc3271e19c 100644
--- a/drivers/usb/storage/unusual_realtek.h
+++ b/drivers/usb/storage/unusual_realtek.h
@@ -38,4 +38,14 @@ UNUSUAL_DEV(0x0bda, 0x0159, 0x0000, 0x9999,
 		"USB Card Reader",
 		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
=20
+UNUSUAL_DEV(0x0bda, 0x0177, 0x0000, 0x9999,
+		"Realtek",
+		"USB Card Reader",
+		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
+
+UNUSUAL_DEV(0x0bda, 0x0184, 0x0000, 0x9999,
+		"Realtek",
+		"USB Card Reader",
+		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
+
 #endif  /* defined(CONFIG_USB_STORAGE_REALTEK) || ... */
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a9dfe6bd70eb..337e1d04871f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1411,6 +1411,8 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, stru=
ct vring_used_elem *heads,
 		return -EFAULT;
 	}
 	if (unlikely(vq->log_used)) {
+		/* Make sure used idx is seen before log. */
+		smp_wmb();
 		/* Log used index update. */
 		log_write(vq->log_base,
 			  vq->log_addr + offsetof(struct vring_used, idx),
diff --git a/drivers/video/fbdev/aty/mach64_accel.c b/drivers/video/fbdev/a=
ty/mach64_accel.c
index 182bd680141f..e9dfe0e40b8b 100644
--- a/drivers/video/fbdev/aty/mach64_accel.c
+++ b/drivers/video/fbdev/aty/mach64_accel.c
@@ -126,7 +126,7 @@ void aty_init_engine(struct atyfb_par *par, struct fb_i=
nfo *info)
=20
 	/* set host attributes */
 	wait_for_fifo(13, par);
-	aty_st_le32(HOST_CNTL, 0, par);
+	aty_st_le32(HOST_CNTL, HOST_BYTE_ALIGN, par);
=20
 	/* set pattern attributes */
 	aty_st_le32(PAT_REG0, 0, par);
@@ -232,7 +232,8 @@ void atyfb_copyarea(struct fb_info *info, const struct =
fb_copyarea *area)
 		rotation =3D rotation24bpp(dx, direction);
 	}
=20
-	wait_for_fifo(4, par);
+	wait_for_fifo(5, par);
+	aty_st_le32(DP_PIX_WIDTH, par->crtc.dp_pix_width, par);
 	aty_st_le32(DP_SRC, FRGD_SRC_BLIT, par);
 	aty_st_le32(SRC_Y_X, (sx << 16) | sy, par);
 	aty_st_le32(SRC_HEIGHT1_WIDTH1, (width << 16) | area->height, par);
@@ -268,7 +269,8 @@ void atyfb_fillrect(struct fb_info *info, const struct =
fb_fillrect *rect)
 		rotation =3D rotation24bpp(dx, DST_X_LEFT_TO_RIGHT);
 	}
=20
-	wait_for_fifo(3, par);
+	wait_for_fifo(4, par);
+	aty_st_le32(DP_PIX_WIDTH, par->crtc.dp_pix_width, par);
 	aty_st_le32(DP_FRGD_CLR, color, par);
 	aty_st_le32(DP_SRC,
 		    BKGD_SRC_BKGD_CLR | FRGD_SRC_FRGD_CLR | MONO_SRC_ONE,
@@ -283,7 +285,7 @@ void atyfb_imageblit(struct fb_info *info, const struct=
 fb_image *image)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
 	u32 src_bytes, dx =3D image->dx, dy =3D image->dy, width =3D image->width;
-	u32 pix_width_save, pix_width, host_cntl, rotation =3D 0, src, mix;
+	u32 pix_width, rotation =3D 0, src, mix;
=20
 	if (par->asleep)
 		return;
@@ -295,8 +297,7 @@ void atyfb_imageblit(struct fb_info *info, const struct=
 fb_image *image)
 		return;
 	}
=20
-	pix_width =3D pix_width_save =3D aty_ld_le32(DP_PIX_WIDTH, par);
-	host_cntl =3D aty_ld_le32(HOST_CNTL, par) | HOST_BYTE_ALIGN;
+	pix_width =3D par->crtc.dp_pix_width;
=20
 	switch (image->depth) {
 	case 1:
@@ -344,7 +345,7 @@ void atyfb_imageblit(struct fb_info *info, const struct=
 fb_image *image)
 		 * since Rage 3D IIc we have DP_HOST_TRIPLE_EN bit
 		 * this hwaccelerated triple has an issue with not aligned data
 		 */
-		if (M64_HAS(HW_TRIPLE) && image->width % 8 =3D=3D 0)
+		if (image->depth =3D=3D 1 && M64_HAS(HW_TRIPLE) && image->width % 8 =3D=
=3D 0)
 			pix_width |=3D DP_HOST_TRIPLE_EN;
 	}
=20
@@ -369,19 +370,18 @@ void atyfb_imageblit(struct fb_info *info, const stru=
ct fb_image *image)
 		mix =3D FRGD_MIX_D_XOR_S | BKGD_MIX_D;
 	}
=20
-	wait_for_fifo(6, par);
-	aty_st_le32(DP_WRITE_MASK, 0xFFFFFFFF, par);
+	wait_for_fifo(5, par);
 	aty_st_le32(DP_PIX_WIDTH, pix_width, par);
 	aty_st_le32(DP_MIX, mix, par);
 	aty_st_le32(DP_SRC, src, par);
-	aty_st_le32(HOST_CNTL, host_cntl, par);
+	aty_st_le32(HOST_CNTL, HOST_BYTE_ALIGN, par);
 	aty_st_le32(DST_CNTL, DST_Y_TOP_TO_BOTTOM | DST_X_LEFT_TO_RIGHT | rotatio=
n, par);
=20
 	draw_rect(dx, dy, width, image->height, par);
 	src_bytes =3D (((image->width * image->depth) + 7) / 8) * image->height;
=20
 	/* manual triple each pixel */
-	if (info->var.bits_per_pixel =3D=3D 24 && !(pix_width & DP_HOST_TRIPLE_EN=
)) {
+	if (image->depth =3D=3D 1 && info->var.bits_per_pixel =3D=3D 24 && !(pix_=
width & DP_HOST_TRIPLE_EN)) {
 		int inbit, outbit, mult24, byte_id_in_dword, width;
 		u8 *pbitmapin =3D (u8*)image->data, *pbitmapout;
 		u32 hostdword;
@@ -414,7 +414,7 @@ void atyfb_imageblit(struct fb_info *info, const struct=
 fb_image *image)
 				}
 			}
 			wait_for_fifo(1, par);
-			aty_st_le32(HOST_DATA0, hostdword, par);
+			aty_st_le32(HOST_DATA0, le32_to_cpu(hostdword), par);
 		}
 	} else {
 		u32 *pbitmap, dwords =3D (src_bytes + 3) / 4;
@@ -423,8 +423,4 @@ void atyfb_imageblit(struct fb_info *info, const struct=
 fb_image *image)
 			aty_st_le32(HOST_DATA0, get_unaligned_le32(pbitmap), par);
 		}
 	}
-
-	/* restore pix_width */
-	wait_for_fifo(1, par);
-	aty_st_le32(DP_PIX_WIDTH, pix_width_save, par);
 }
diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 9900e8ec7393..8612816dfb32 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -622,6 +622,8 @@ static int omap_hdq_remove(struct platform_device *pdev)
 	/* remove module dependency */
 	pm_runtime_disable(&pdev->dev);
=20
+	w1_remove_master_device(&omap_w1_master);
+
 	return 0;
 }
=20
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 42212c8e4453..73c1254e3943 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -311,6 +311,9 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t=
 size,
 	*/
 	flags &=3D ~(__GFP_DMA | __GFP_HIGHMEM);
=20
+	/* Convert the size to actually allocated. */
+	size =3D 1UL << (order + PAGE_SHIFT);
+
 	if (dma_alloc_from_coherent(hwdev, size, dma_handle, &ret))
 		return ret;
=20
@@ -366,6 +369,9 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t =
size, void *vaddr,
 	 * physical address */
 	phys =3D xen_bus_to_phys(dev_addr);
=20
+	/* Convert the size to actually allocated. */
+	size =3D 1UL << (order + PAGE_SHIFT);
+
 	if (((dev_addr + size - 1 <=3D dma_mask)) ||
 	    range_straddles_page_boundary(phys, size))
 		xen_destroy_contiguous_region(phys, order);
diff --git a/fs/aio.c b/fs/aio.c
index 4dddb2a5298f..f15e87e8a1dd 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -43,6 +43,7 @@
=20
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
+#include <linux/nospec.h>
=20
 #include "internal.h"
=20
@@ -1022,6 +1023,7 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_=
id)
 	if (!table || id >=3D table->nr)
 		goto out;
=20
+	id =3D array_index_nospec(id, table->nr);
 	ctx =3D rcu_dereference(table->table[id]);
 	if (ctx && ctx->user_id =3D=3D ctx_id) {
 		if (percpu_ref_tryget_live(&ctx->users))
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index d738ff8ab81c..28e15b6f13c7 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -362,6 +362,7 @@ int btrfs_dev_replace_start(struct btrfs_root *root,
 		break;
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
+		ASSERT(0);
 		args->result =3D BTRFS_IOCTL_DEV_REPLACE_RESULT_ALREADY_STARTED;
 		goto leave;
 	}
@@ -406,6 +407,10 @@ int btrfs_dev_replace_start(struct btrfs_root *root,
 	if (IS_ERR(trans)) {
 		ret =3D PTR_ERR(trans);
 		btrfs_dev_replace_lock(dev_replace);
+		dev_replace->replace_state =3D
+			BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED;
+		dev_replace->srcdev =3D NULL;
+		dev_replace->tgtdev =3D NULL;
 		goto leave;
 	}
=20
@@ -423,8 +428,6 @@ int btrfs_dev_replace_start(struct btrfs_root *root,
 	return 0;
=20
 leave:
-	dev_replace->srcdev =3D NULL;
-	dev_replace->tgtdev =3D NULL;
 	btrfs_dev_replace_unlock(dev_replace);
 leave_no_lock:
 	if (tgt_device)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 430c27e3aa1d..64cd85a24ab8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -430,9 +430,9 @@ static int btree_read_extent_buffer_pages(struct btrfs_=
root *root,
 	int mirror_num =3D 0;
 	int failed_mirror =3D 0;
=20
-	clear_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags);
 	io_tree =3D &BTRFS_I(root->fs_info->btree_inode)->io_tree;
 	while (1) {
+		clear_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags);
 		ret =3D read_extent_buffer_pages(io_tree, eb, start,
 					       WAIT_COMPLETE,
 					       btree_get_extent, mirror_num);
@@ -444,14 +444,6 @@ static int btree_read_extent_buffer_pages(struct btrfs=
_root *root,
 				ret =3D -EIO;
 		}
=20
-		/*
-		 * This buffer's crc is fine, but its contents are corrupted, so
-		 * there is no reason to read the other copies, they won't be
-		 * any less wrong.
-		 */
-		if (test_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags))
-			break;
-
 		num_copies =3D btrfs_num_copies(root->fs_info,
 					      eb->start, eb->len);
 		if (num_copies =3D=3D 1)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f34b210aaed8..62a92d7ed0aa 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -8590,6 +8590,7 @@ void btrfs_put_block_group_cache(struct btrfs_fs_info=
 *info)
=20
 		block_group =3D btrfs_lookup_first_block_group(info, last);
 		while (block_group) {
+			wait_block_group_cache_done(block_group);
 			spin_lock(&block_group->lock);
 			if (block_group->iref)
 				break;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c8f953b7c084..15934d342b5f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -506,6 +506,16 @@ int btrfs_dirty_pages(struct btrfs_root *root, struct =
inode *inode,
 	num_bytes =3D ALIGN(write_bytes + pos - start_pos, root->sectorsize);
=20
 	end_of_last_block =3D start_pos + num_bytes - 1;
+
+	/*
+	 * The pages may have already been dirty, clear out old accounting so
+	 * we can set things up properly
+	 */
+	clear_extent_bit(&BTRFS_I(inode)->io_tree, start_pos, end_of_last_block,
+			 EXTENT_DIRTY | EXTENT_DELALLOC |
+			 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 0, 0, cached,
+			 GFP_NOFS);
+
 	err =3D btrfs_set_extent_delalloc(inode, start_pos, end_of_last_block,
 					cached);
 	if (err)
@@ -1408,18 +1418,26 @@ lock_and_cleanup_extent_if_need(struct inode *inode=
, struct page **pages,
 		if (ordered)
 			btrfs_put_ordered_extent(ordered);
=20
-		clear_extent_bit(&BTRFS_I(inode)->io_tree, start_pos,
-				  last_pos, EXTENT_DIRTY | EXTENT_DELALLOC |
-				  EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-				  0, 0, cached_state, GFP_NOFS);
 		*lockstart =3D start_pos;
 		*lockend =3D last_pos;
 		ret =3D 1;
 	}
=20
+	/*
+	 * It's possible the pages are dirty right now, but we don't want
+	 * to clean them yet because copy_from_user may catch a page fault
+	 * and we might have to fall back to one page at a time.  If that
+	 * happens, we'll unlock these pages and we'd have a window where
+	 * reclaim could sneak in and drop the once-dirty page on the floor
+	 * without writing it.
+	 *
+	 * We have the pages locked and the extent range locked, so there's
+	 * no way someone can start IO on any dirty pages in this range.
+	 *
+	 * We'll call btrfs_dirty_pages() later on, and that will flip around
+	 * delalloc bits and dirty the pages as required.
+	 */
 	for (i =3D 0; i < num_pages; i++) {
-		if (clear_page_dirty_for_io(pages[i]))
-			account_page_redirty(pages[i]);
 		set_page_extent_mapped(pages[i]);
 		WARN_ON(!PageLocked(pages[i]));
 	}
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 2b0a627cb5f9..be5f24c860d0 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2141,6 +2141,7 @@ void btrfs_dump_free_space(struct btrfs_block_group_c=
ache *block_group,
 	struct rb_node *n;
 	int count =3D 0;
=20
+	spin_lock(&ctl->tree_lock);
 	for (n =3D rb_first(&ctl->free_space_offset); n; n =3D rb_next(n)) {
 		info =3D rb_entry(n, struct btrfs_free_space, offset_index);
 		if (info->bytes >=3D bytes && !block_group->ro)
@@ -2150,6 +2151,7 @@ void btrfs_dump_free_space(struct btrfs_block_group_c=
ache *block_group,
 			   info->offset, info->bytes,
 		       (info->bitmap) ? "yes" : "no");
 	}
+	spin_unlock(&ctl->tree_lock);
 	btrfs_info(block_group->fs_info, "block group has cluster?: %s",
 	       list_empty(&block_group->cluster_list) ? "no" : "yes");
 	btrfs_info(block_group->fs_info,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4ebcbac19678..67e036ccb63d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -452,6 +452,7 @@ static noinline int compress_file_range(struct inode *i=
node,
 		pages =3D kzalloc(sizeof(struct page *) * nr_pages, GFP_NOFS);
 		if (!pages) {
 			/* just bail out to the uncompressed code */
+			nr_pages =3D 0;
 			goto cont;
 		}
=20
@@ -1448,12 +1449,11 @@ static noinline int run_delalloc_nocow(struct inode=
 *inode,
 	}
 	btrfs_release_path(path);
=20
-	if (cur_offset <=3D end && cow_start =3D=3D (u64)-1) {
+	if (cur_offset <=3D end && cow_start =3D=3D (u64)-1)
 		cow_start =3D cur_offset;
-		cur_offset =3D end;
-	}
=20
 	if (cow_start !=3D (u64)-1) {
+		cur_offset =3D end;
 		ret =3D cow_file_range(inode, locked_page, cow_start, end,
 				     page_started, nr_written, 1);
 		if (ret)
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9568810444ea..379c88b17c07 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3806,9 +3806,17 @@ static noinline long btrfs_ioctl_clone(struct file *=
file, unsigned long srcfd,
 		goto out_unlock;
 	if (len =3D=3D 0)
 		olen =3D len =3D src->i_size - off;
-	/* if we extend to eof, continue to block boundary */
-	if (off + len =3D=3D src->i_size)
+	/*
+	 * If we extend to eof, continue to block boundary if and only if the
+	 * destination end offset matches the destination file's size, otherwise
+	 * we would be corrupting data by placing the eof block into the middle
+	 * of a file.
+	 */
+	if (off + len =3D=3D src->i_size) {
+		if (!IS_ALIGNED(len, bs) && destoff + len < inode->i_size)
+			goto out_unlock;
 		len =3D ALIGN(src->i_size, bs) - off;
+	}
=20
 	if (len =3D=3D 0) {
 		ret =3D 0;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 0e32f21e0868..1ad1be17e9c2 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2024,7 +2024,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *t=
rans,
 	int ret =3D 0;
 	int i;
 	u64 *i_qgroups;
-	struct btrfs_root *quota_root =3D fs_info->quota_root;
+	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *srcgroup;
 	struct btrfs_qgroup *dstgroup;
 	u32 level_size =3D 0;
@@ -2034,6 +2034,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *t=
rans,
 	if (!fs_info->quota_enabled)
 		goto out;
=20
+	quota_root =3D fs_info->quota_root;
 	if (!quota_root) {
 		ret =3D -EINVAL;
 		goto out;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e0029f1a0da8..9cba36820c72 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3955,6 +3955,7 @@ static noinline_for_stack int relocate_block_group(st=
ruct reloc_control *rc)
 restart:
 		if (update_backref_cache(trans, &rc->backref_cache)) {
 			btrfs_end_transaction(trans, rc->extent_root);
+			trans =3D NULL;
 			continue;
 		}
=20
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 838723d6a252..30635044e7e0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1771,6 +1771,7 @@ static long btrfs_control_ioctl(struct file *file, un=
signed int cmd,
 	vol =3D memdup_user((void __user *)arg, sizeof(*vol));
 	if (IS_ERR(vol))
 		return PTR_ERR(vol);
+	vol->name[BTRFS_PATH_NAME_MAX] =3D '\0';
=20
 	switch (cmd) {
 	case BTRFS_IOC_SCAN_DEV:
diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index 6ac55e2ccd2f..720af6c80997 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -383,6 +383,9 @@ static int cifs_stats_proc_show(struct seq_file *m, voi=
d *v)
 				if (server->ops->print_stats)
 					server->ops->print_stats(m, tcon);
 			}
+		atomic_set(&tcpSesReconnectCount, 0);
+		atomic_set(&tconInfoReconnectCount, 0);
+
 		}
 	}
 	spin_unlock(&cifs_tcp_ses_lock);
diff --git a/fs/cifs/cifs_spnego.c b/fs/cifs/cifs_spnego.c
index 2f5a7e0103d0..58b5dcdd94c5 100644
--- a/fs/cifs/cifs_spnego.c
+++ b/fs/cifs/cifs_spnego.c
@@ -148,8 +148,10 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo)
 		sprintf(dp, ";sec=3Dkrb5");
 	else if (server->sec_mskerberos)
 		sprintf(dp, ";sec=3Dmskrb5");
-	else
-		goto out;
+	else {
+		cifs_dbg(VFS, "unknown or missing server auth type, use krb5\n");
+		sprintf(dp, ";sec=3Dkrb5");
+	}
=20
 	dp =3D description + strlen(description);
 	sprintf(dp, ";uid=3D0x%x",
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 75eac1424c5b..07e2465c0d50 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -163,7 +163,7 @@ build_path_from_dentry(struct dentry *direntry)
=20
 		cifs_dbg(FYI, "using cifs_sb prepath <%s>\n", cifs_sb->prepath);
 		memcpy(full_path+dfsplen+1, cifs_sb->prepath, pplen-1);
-		full_path[dfsplen] =3D '\\';
+		full_path[dfsplen] =3D dirsep;
 		for (i =3D 0; i < pplen-1; i++)
 			if (full_path[dfsplen+1+i] =3D=3D '/')
 				full_path[dfsplen+1+i] =3D CIFS_DIR_SEP(cifs_sb);
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 353d8b690329..09ca7c978700 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -735,7 +735,15 @@ cifs_get_inode_info(struct inode **inode, const char *=
full_path,
 	} else if (rc =3D=3D -EREMOTE) {
 		cifs_create_dfs_fattr(&fattr, sb);
 		rc =3D 0;
-	} else if (rc =3D=3D -EACCES && backup_cred(cifs_sb)) {
+	} else if ((rc =3D=3D -EACCES) && backup_cred(cifs_sb) &&
+		   (strcmp(server->vals->version_string, SMB1_VERSION_STRING)
+		      =3D=3D 0)) {
+			/*
+			 * For SMB2 and later the backup intent flag is already
+			 * sent if needed on open and there is no path based
+			 * FindFirst operation to use to retry with
+			 */
+
 			srchinf =3D kzalloc(sizeof(struct cifs_search_info),
 						GFP_KERNEL);
 			if (srchinf =3D=3D NULL) {
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index ddcfe590b8a8..dd12099e3d5e 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -183,7 +183,8 @@ static void *cramfs_read(struct super_block *sb, unsign=
ed int offset, unsigned i
 			continue;
 		blk_offset =3D (blocknr - buffer_blocknr[i]) << PAGE_CACHE_SHIFT;
 		blk_offset +=3D offset;
-		if (blk_offset + len > BUFFER_SIZE)
+		if (blk_offset > BUFFER_SIZE ||
+		    blk_offset + len > BUFFER_SIZE)
 			continue;
 		return read_buffers[i] + blk_offset;
 	}
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index a3aa6baad1a1..78ff747c4fad 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -76,7 +76,7 @@ static bool dentry_connected(struct dentry *dentry)
 		struct dentry *parent =3D dget_parent(dentry);
=20
 		dput(dentry);
-		if (IS_ROOT(dentry)) {
+		if (dentry =3D=3D parent) {
 			dput(parent);
 			return false;
 		}
@@ -148,6 +148,7 @@ static struct dentry *reconnect_one(struct vfsmount *mn=
t,
 	mutex_unlock(&parent->d_inode->i_mutex);
 	if (IS_ERR(tmp)) {
 		dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
+		err =3D PTR_ERR(tmp);
 		goto out_err;
 	}
 	if (tmp !=3D dentry) {
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 91426141c33a..d5d6ec134d5c 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -606,9 +606,9 @@ bad_block:		ext2_error(sb, "ext2_xattr_set",
 	}
=20
 cleanup:
-	brelse(bh);
 	if (!(bh && header =3D=3D HDR(bh)))
 		kfree(header);
+	brelse(bh);
 	up_write(&EXT2_I(inode)->xattr_sem);
=20
 	return error;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 05ea39cc4b4c..ea1db0e2a714 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1300,7 +1300,8 @@ struct ext4_sb_info {
 	u32 s_min_batch_time;
 	struct block_device *journal_bdev;
 #ifdef CONFIG_QUOTA
-	char *s_qf_names[MAXQUOTAS];		/* Names of quota files with journalled quo=
ta */
+	/* Names of quota files with journalled quota */
+	char __rcu *s_qf_names[MAXQUOTAS];
 	int s_jquota_fmt;			/* Format of quota to use */
 #endif
 	unsigned int s_want_extra_isize; /* New inodes should reserve # bytes */
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 06b31f567cf8..68308d7ed190 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -859,7 +859,7 @@ int ext4_da_write_inline_data_begin(struct address_spac=
e *mapping,
 	handle_t *handle;
 	struct page *page;
 	struct ext4_iloc iloc;
-	int retries;
+	int retries =3D 0;
=20
 	ret =3D ext4_get_inode_loc(inode, &iloc);
 	if (ret)
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index bfda18a15592..723a2307a9e8 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -64,7 +64,6 @@ static void swap_inode_data(struct inode *inode1, struct =
inode *inode2)
 	ei1 =3D EXT4_I(inode1);
 	ei2 =3D EXT4_I(inode2);
=20
-	memswap(&inode1->i_flags, &inode2->i_flags, sizeof(inode1->i_flags));
 	memswap(&inode1->i_version, &inode2->i_version,
 		  sizeof(inode1->i_version));
 	memswap(&inode1->i_blocks, &inode2->i_blocks,
@@ -86,6 +85,21 @@ static void swap_inode_data(struct inode *inode1, struct=
 inode *inode2)
 	i_size_write(inode2, isize);
 }
=20
+static void reset_inode_seed(struct inode *inode)
+{
+	struct ext4_inode_info *ei =3D EXT4_I(inode);
+	struct ext4_sb_info *sbi =3D EXT4_SB(inode->i_sb);
+	__le32 inum =3D cpu_to_le32(inode->i_ino);
+	__le32 gen =3D cpu_to_le32(inode->i_generation);
+	__u32 csum;
+
+	if (!ext4_has_metadata_csum(inode->i_sb))
+		return;
+
+	csum =3D ext4_chksum(sbi, sbi->s_csum_seed, (__u8 *)&inum, sizeof(inum));
+	ei->i_csum_seed =3D ext4_chksum(sbi, csum, (__u8 *)&gen, sizeof(gen));
+}
+
 /**
  * Swap the information from the given @inode and the inode
  * EXT4_BOOT_LOADER_INO. It will basically swap i_data and all other
@@ -104,10 +118,13 @@ static long swap_inode_boot_loader(struct super_block=
 *sb,
 	struct ext4_inode_info *ei_bl;
 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
=20
-	if (inode->i_nlink !=3D 1 || !S_ISREG(inode->i_mode))
+	if (inode->i_nlink !=3D 1 || !S_ISREG(inode->i_mode) ||
+	    IS_SWAPFILE(inode) ||
+	    ext4_has_inline_data(inode))
 		return -EINVAL;
=20
-	if (!inode_owner_or_capable(inode) || !capable(CAP_SYS_ADMIN))
+	if (IS_RDONLY(inode) || IS_APPEND(inode) || IS_IMMUTABLE(inode) ||
+	    !inode_owner_or_capable(inode) || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
=20
 	inode_bl =3D ext4_iget(sb, EXT4_BOOT_LOADER_INO);
@@ -122,15 +139,15 @@ static long swap_inode_boot_loader(struct super_block=
 *sb,
 	 * that only 1 swap_inode_boot_loader is running. */
 	lock_two_nondirectories(inode, inode_bl);
=20
-	truncate_inode_pages(&inode->i_data, 0);
-	truncate_inode_pages(&inode_bl->i_data, 0);
-
 	/* Wait for all existing dio workers */
 	ext4_inode_block_unlocked_dio(inode);
 	ext4_inode_block_unlocked_dio(inode_bl);
 	inode_dio_wait(inode);
 	inode_dio_wait(inode_bl);
=20
+	truncate_inode_pages(&inode->i_data, 0);
+	truncate_inode_pages(&inode_bl->i_data, 0);
+
 	handle =3D ext4_journal_start(inode_bl, EXT4_HT_MOVE_EXTENTS, 2);
 	if (IS_ERR(handle)) {
 		err =3D -EINVAL;
@@ -166,6 +183,8 @@ static long swap_inode_boot_loader(struct super_block *=
sb,
 	inode->i_generation =3D sbi->s_next_generation++;
 	inode_bl->i_generation =3D sbi->s_next_generation++;
 	spin_unlock(&sbi->s_next_gen_lock);
+	reset_inode_seed(inode);
+	reset_inode_seed(inode_bl);
=20
 	ext4_discard_preallocations(inode);
=20
@@ -176,6 +195,7 @@ static long swap_inode_boot_loader(struct super_block *=
sb,
 			inode->i_ino, err);
 		/* Revert all changes: */
 		swap_inode_data(inode, inode_bl);
+		ext4_mark_inode_dirty(handle, inode);
 	} else {
 		err =3D ext4_mark_inode_dirty(handle, inode_bl);
 		if (err < 0) {
@@ -185,6 +205,7 @@ static long swap_inode_boot_loader(struct super_block *=
sb,
 			/* Revert all changes: */
 			swap_inode_data(inode, inode_bl);
 			ext4_mark_inode_dirty(handle, inode);
+			ext4_mark_inode_dirty(handle, inode_bl);
 		}
 	}
 	ext4_journal_stop(handle);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index deebe58586c2..e5282863d9d4 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -122,6 +122,7 @@ static struct buffer_head *__ext4_read_dirblock(struct =
inode *inode,
 	if (!is_dx_block && type =3D=3D INDEX) {
 		ext4_error_inode(inode, __func__, line, block,
 		       "directory leaf block found instead of index block");
+		brelse(bh);
 		return ERR_PTR(-EIO);
 	}
 	if (!ext4_has_metadata_csum(inode->i_sb) ||
@@ -2629,7 +2630,9 @@ int ext4_orphan_add(handle_t *handle, struct inode *i=
node)
 			list_del_init(&EXT4_I(inode)->i_orphan);
 			mutex_unlock(&sbi->s_orphan_lock);
 		}
-	}
+	} else
+		brelse(iloc.bh);
+
 	jbd_debug(4, "superblock will point to %lu\n", inode->i_ino);
 	jbd_debug(4, "orphan inode %lu will point to %d\n",
 			inode->i_ino, NEXT_ORPHAN(inode));
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 52fb5c7db73d..15b9e5dea908 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -442,16 +442,18 @@ static int set_flexbg_block_bitmap(struct super_block=
 *sb, handle_t *handle,
=20
 		BUFFER_TRACE(bh, "get_write_access");
 		err =3D ext4_journal_get_write_access(handle, bh);
-		if (err)
+		if (err) {
+			brelse(bh);
 			return err;
+		}
 		ext4_debug("mark block bitmap %#04llx (+%llu/%u)\n", block,
 			   block - start, count2);
 		ext4_set_bits(bh->b_data, block - start, count2);
=20
 		err =3D ext4_handle_dirty_metadata(handle, NULL, bh);
+		brelse(bh);
 		if (unlikely(err))
 			return err;
-		brelse(bh);
 	}
=20
 	return 0;
@@ -588,7 +590,6 @@ static int setup_new_flex_group_blocks(struct super_blo=
ck *sb,
 		bh =3D bclean(handle, sb, block);
 		if (IS_ERR(bh)) {
 			err =3D PTR_ERR(bh);
-			bh =3D NULL;
 			goto out;
 		}
 		overhead =3D ext4_group_overhead_blocks(sb, group);
@@ -600,9 +601,9 @@ static int setup_new_flex_group_blocks(struct super_blo=
ck *sb,
 		ext4_mark_bitmap_end(group_data[i].blocks_count,
 				     sb->s_blocksize * 8, bh->b_data);
 		err =3D ext4_handle_dirty_metadata(handle, NULL, bh);
+		brelse(bh);
 		if (err)
 			goto out;
-		brelse(bh);
=20
 handle_ib:
 		if (bg_flags[i] & EXT4_BG_INODE_UNINIT)
@@ -617,18 +618,16 @@ static int setup_new_flex_group_blocks(struct super_b=
lock *sb,
 		bh =3D bclean(handle, sb, block);
 		if (IS_ERR(bh)) {
 			err =3D PTR_ERR(bh);
-			bh =3D NULL;
 			goto out;
 		}
=20
 		ext4_mark_bitmap_end(EXT4_INODES_PER_GROUP(sb),
 				     sb->s_blocksize * 8, bh->b_data);
 		err =3D ext4_handle_dirty_metadata(handle, NULL, bh);
+		brelse(bh);
 		if (err)
 			goto out;
-		brelse(bh);
 	}
-	bh =3D NULL;
=20
 	/* Mark group tables in block bitmap */
 	for (j =3D 0; j < GROUP_TABLE_COUNT; j++) {
@@ -659,7 +658,6 @@ static int setup_new_flex_group_blocks(struct super_blo=
ck *sb,
 	}
=20
 out:
-	brelse(bh);
 	err2 =3D ext4_journal_stop(handle);
 	if (err2 && !err)
 		err =3D err2;
@@ -847,6 +845,7 @@ static int add_new_gdb(handle_t *handle, struct inode *=
inode,
 	err =3D ext4_handle_dirty_metadata(handle, NULL, gdb_bh);
 	if (unlikely(err)) {
 		ext4_std_error(sb, err);
+		iloc.bh =3D NULL;
 		goto exit_inode;
 	}
 	brelse(dind);
@@ -898,6 +897,7 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
 				     sizeof(struct buffer_head *),
 				     GFP_NOFS);
 	if (!n_group_desc) {
+		brelse(gdb_bh);
 		err =3D -ENOMEM;
 		ext4_warning(sb, "not enough memory for %lu groups",
 			     gdb_num + 1);
@@ -913,8 +913,6 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
 	ext4_kvfree(o_group_desc);
 	BUFFER_TRACE(gdb_bh, "get_write_access");
 	err =3D ext4_journal_get_write_access(handle, gdb_bh);
-	if (unlikely(err))
-		brelse(gdb_bh);
 	return err;
 }
=20
@@ -1096,8 +1094,10 @@ static void update_backups(struct super_block *sb, s=
ector_t blk_off, char *data,
 			   backup_block, backup_block -
 			   ext4_group_first_block_no(sb, group));
 		BUFFER_TRACE(bh, "get_write_access");
-		if ((err =3D ext4_journal_get_write_access(handle, bh)))
+		if ((err =3D ext4_journal_get_write_access(handle, bh))) {
+			brelse(bh);
 			break;
+		}
 		lock_buffer(bh);
 		memcpy(bh->b_data, data, size);
 		if (rest)
@@ -1994,7 +1994,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk=
_t n_blocks_count)
=20
 	err =3D ext4_alloc_flex_bg_array(sb, n_group + 1);
 	if (err)
-		return err;
+		goto out;
=20
 	err =3D ext4_mb_alloc_groupinfo(sb, n_group + 1);
 	if (err)
@@ -2030,6 +2030,10 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsbl=
k_t n_blocks_count)
 		n_blocks_count_retry =3D 0;
 		free_flex_gd(flex_gd);
 		flex_gd =3D NULL;
+		if (resize_inode) {
+			iput(resize_inode);
+			resize_inode =3D NULL;
+		}
 		goto retry;
 	}
=20
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 535bbf0b4fe4..0b1cd5a7a48b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -780,6 +780,20 @@ static void dump_orphan_list(struct super_block *sb, s=
truct ext4_sb_info *sbi)
 	}
 }
=20
+#ifdef CONFIG_QUOTA
+/*
+ * This is a helper function which is used in the mount/remount
+ * codepaths (which holds s_umount) to fetch the quota file name.
+ */
+static inline char *get_qf_name(struct super_block *sb,
+				struct ext4_sb_info *sbi,
+				int type)
+{
+	return rcu_dereference_protected(sbi->s_qf_names[type],
+					 lockdep_is_held(&sb->s_umount));
+}
+#endif
+
 static void ext4_put_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
@@ -833,7 +847,7 @@ static void ext4_put_super(struct super_block *sb)
 	brelse(sbi->s_sbh);
 #ifdef CONFIG_QUOTA
 	for (i =3D 0; i < MAXQUOTAS; i++)
-		kfree(sbi->s_qf_names[i]);
+		kfree(get_qf_name(sb, sbi, i));
 #endif
=20
 	/* Debugging code just in case the in-memory inode orphan list
@@ -1293,11 +1307,10 @@ static char deprecated_msg[] =3D "Mount option \"%s=
\" will be removed by %s\n"
 static int set_qf_name(struct super_block *sb, int qtype, substring_t *arg=
s)
 {
 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
-	char *qname;
+	char *qname, *old_qname =3D get_qf_name(sb, sbi, qtype);
 	int ret =3D -1;
=20
-	if (sb_any_quota_loaded(sb) &&
-		!sbi->s_qf_names[qtype]) {
+	if (sb_any_quota_loaded(sb) && !old_qname) {
 		ext4_msg(sb, KERN_ERR,
 			"Cannot change journaled "
 			"quota options when quota turned on");
@@ -1314,8 +1327,8 @@ static int set_qf_name(struct super_block *sb, int qt=
ype, substring_t *args)
 			"Not enough memory for storing quotafile name");
 		return -1;
 	}
-	if (sbi->s_qf_names[qtype]) {
-		if (strcmp(sbi->s_qf_names[qtype], qname) =3D=3D 0)
+	if (old_qname) {
+		if (strcmp(old_qname, qname) =3D=3D 0)
 			ret =3D 1;
 		else
 			ext4_msg(sb, KERN_ERR,
@@ -1328,7 +1341,7 @@ static int set_qf_name(struct super_block *sb, int qt=
ype, substring_t *args)
 			"quotafile must be on filesystem root");
 		goto errout;
 	}
-	sbi->s_qf_names[qtype] =3D qname;
+	rcu_assign_pointer(sbi->s_qf_names[qtype], qname);
 	set_opt(sb, QUOTA);
 	return 1;
 errout:
@@ -1340,15 +1353,16 @@ static int clear_qf_name(struct super_block *sb, in=
t qtype)
 {
=20
 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
+	char *old_qname =3D get_qf_name(sb, sbi, qtype);
=20
-	if (sb_any_quota_loaded(sb) &&
-		sbi->s_qf_names[qtype]) {
+	if (sb_any_quota_loaded(sb) && old_qname) {
 		ext4_msg(sb, KERN_ERR, "Cannot change journaled quota options"
 			" when quota turned on");
 		return -1;
 	}
-	kfree(sbi->s_qf_names[qtype]);
-	sbi->s_qf_names[qtype] =3D NULL;
+	rcu_assign_pointer(sbi->s_qf_names[qtype], NULL);
+	synchronize_rcu();
+	kfree(old_qname);
 	return 1;
 }
 #endif
@@ -1677,7 +1691,7 @@ static int parse_options(char *options, struct super_=
block *sb,
 			 int is_remount)
 {
 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
-	char *p;
+	char *p, __maybe_unused *usr_qf_name, __maybe_unused *grp_qf_name;
 	substring_t args[MAX_OPT_ARGS];
 	int token;
=20
@@ -1704,11 +1718,13 @@ static int parse_options(char *options, struct supe=
r_block *sb,
 			 "feature is enabled");
 		return 0;
 	}
-	if (sbi->s_qf_names[USRQUOTA] || sbi->s_qf_names[GRPQUOTA]) {
-		if (test_opt(sb, USRQUOTA) && sbi->s_qf_names[USRQUOTA])
+	usr_qf_name =3D get_qf_name(sb, sbi, USRQUOTA);
+	grp_qf_name =3D get_qf_name(sb, sbi, GRPQUOTA);
+	if (usr_qf_name || grp_qf_name) {
+		if (test_opt(sb, USRQUOTA) && usr_qf_name)
 			clear_opt(sb, USRQUOTA);
=20
-		if (test_opt(sb, GRPQUOTA) && sbi->s_qf_names[GRPQUOTA])
+		if (test_opt(sb, GRPQUOTA) && grp_qf_name)
 			clear_opt(sb, GRPQUOTA);
=20
 		if (test_opt(sb, GRPQUOTA) || test_opt(sb, USRQUOTA)) {
@@ -1742,6 +1758,7 @@ static inline void ext4_show_quota_options(struct seq=
_file *seq,
 {
 #if defined(CONFIG_QUOTA)
 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
+	char *usr_qf_name, *grp_qf_name;
=20
 	if (sbi->s_jquota_fmt) {
 		char *fmtname =3D "";
@@ -1760,11 +1777,14 @@ static inline void ext4_show_quota_options(struct s=
eq_file *seq,
 		seq_printf(seq, ",jqfmt=3D%s", fmtname);
 	}
=20
-	if (sbi->s_qf_names[USRQUOTA])
-		seq_show_option(seq, "usrjquota", sbi->s_qf_names[USRQUOTA]);
-
-	if (sbi->s_qf_names[GRPQUOTA])
-		seq_show_option(seq, "grpjquota", sbi->s_qf_names[GRPQUOTA]);
+	rcu_read_lock();
+	usr_qf_name =3D rcu_dereference(sbi->s_qf_names[USRQUOTA]);
+	grp_qf_name =3D rcu_dereference(sbi->s_qf_names[GRPQUOTA]);
+	if (usr_qf_name)
+		seq_show_option(seq, "usrjquota", usr_qf_name);
+	if (grp_qf_name)
+		seq_show_option(seq, "grpjquota", grp_qf_name);
+	rcu_read_unlock();
 #endif
 }
=20
@@ -3960,6 +3980,14 @@ static int ext4_fill_super(struct super_block *sb, v=
oid *data, int silent)
 	sbi->s_groups_count =3D blocks_count;
 	sbi->s_blockfile_groups =3D min_t(ext4_group_t, sbi->s_groups_count,
 			(EXT4_MAX_BLOCK_FILE_PHYS / EXT4_BLOCKS_PER_GROUP(sb)));
+	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=3D
+	    le32_to_cpu(es->s_inodes_count)) {
+		ext4_msg(sb, KERN_ERR, "inodes count not valid: %u vs %llu",
+			 le32_to_cpu(es->s_inodes_count),
+			 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
+		ret =3D -EINVAL;
+		goto failed_mount;
+	}
 	db_count =3D (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
 		   EXT4_DESC_PER_BLOCK(sb);
 	if (EXT4_HAS_INCOMPAT_FEATURE(sb,EXT4_FEATURE_INCOMPAT_META_BG)) {
@@ -3979,14 +4007,6 @@ static int ext4_fill_super(struct super_block *sb, v=
oid *data, int silent)
 		ret =3D -ENOMEM;
 		goto failed_mount;
 	}
-	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=3D
-	    le32_to_cpu(es->s_inodes_count)) {
-		ext4_msg(sb, KERN_ERR, "inodes count not valid: %u vs %llu",
-			 le32_to_cpu(es->s_inodes_count),
-			 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
-		ret =3D -EINVAL;
-		goto failed_mount;
-	}
=20
 	if (ext4_proc_root)
 		sbi->s_proc =3D proc_mkdir(sb->s_id, ext4_proc_root);
@@ -4936,6 +4956,7 @@ static int ext4_remount(struct super_block *sb, int *=
flags, char *data)
 	int err =3D 0;
 #ifdef CONFIG_QUOTA
 	int i, j;
+	char *to_free[MAXQUOTAS];
 #endif
 	char *orig_data =3D kstrdup(data, GFP_KERNEL);
=20
@@ -4952,8 +4973,9 @@ static int ext4_remount(struct super_block *sb, int *=
flags, char *data)
 	old_opts.s_jquota_fmt =3D sbi->s_jquota_fmt;
 	for (i =3D 0; i < MAXQUOTAS; i++)
 		if (sbi->s_qf_names[i]) {
-			old_opts.s_qf_names[i] =3D kstrdup(sbi->s_qf_names[i],
-							 GFP_KERNEL);
+			char *qf_name =3D get_qf_name(sb, sbi, i);
+
+			old_opts.s_qf_names[i] =3D kstrdup(qf_name, GFP_KERNEL);
 			if (!old_opts.s_qf_names[i]) {
 				for (j =3D 0; j < i; j++)
 					kfree(old_opts.s_qf_names[j]);
@@ -5141,9 +5163,12 @@ static int ext4_remount(struct super_block *sb, int =
*flags, char *data)
 #ifdef CONFIG_QUOTA
 	sbi->s_jquota_fmt =3D old_opts.s_jquota_fmt;
 	for (i =3D 0; i < MAXQUOTAS; i++) {
-		kfree(sbi->s_qf_names[i]);
-		sbi->s_qf_names[i] =3D old_opts.s_qf_names[i];
+		to_free[i] =3D get_qf_name(sb, sbi, i);
+		rcu_assign_pointer(sbi->s_qf_names[i], old_opts.s_qf_names[i]);
 	}
+	synchronize_rcu();
+	for (i =3D 0; i < MAXQUOTAS; i++)
+		kfree(to_free[i]);
 #endif
 	kfree(orig_data);
 	return err;
@@ -5291,7 +5316,7 @@ static int ext4_write_info(struct super_block *sb, in=
t type)
  */
 static int ext4_quota_on_mount(struct super_block *sb, int type)
 {
-	return dquot_quota_on_mount(sb, EXT4_SB(sb)->s_qf_names[type],
+	return dquot_quota_on_mount(sb, get_qf_name(sb, EXT4_SB(sb), type),
 					EXT4_SB(sb)->s_jquota_fmt, type);
 }
=20
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 61e89046f8dd..9047f04f9bc6 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1202,6 +1202,8 @@ ext4_xattr_set_handle(handle_t *handle, struct inode =
*inode, int name_index,
 			error =3D ext4_xattr_block_set(handle, inode, &i, &bs);
 		} else if (error =3D=3D -ENOSPC) {
 			if (EXT4_I(inode)->i_file_acl && !bs.s.base) {
+				brelse(bs.bh);
+				bs.bh =3D NULL;
 				error =3D ext4_xattr_block_find(inode, &i, &bs);
 				if (error)
 					goto cleanup;
@@ -1527,6 +1529,8 @@ int ext4_expand_extra_isize_ea(struct inode *inode, i=
nt new_extra_isize,
 	kfree(buffer);
 	if (is)
 		brelse(is->iloc.bh);
+	if (bs)
+		brelse(bs->bh);
 	kfree(is);
 	kfree(bs);
 	brelse(bh);
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0834f5640875..db2963a54f16 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -376,12 +376,19 @@ __releases(fc->lock)
 	if (req->background) {
 		req->background =3D 0;
=20
-		if (fc->num_background =3D=3D fc->max_background)
+		if (fc->num_background =3D=3D fc->max_background) {
 			fc->blocked =3D 0;
-
-		/* Wake up next waiter, if any */
-		if (!fc->blocked && waitqueue_active(&fc->blocked_waitq))
 			wake_up(&fc->blocked_waitq);
+		} else if (!fc->blocked) {
+			/*
+			 * Wake up next waiter, if any.  It's okay to use
+			 * waitqueue_active(), as we've already synced up
+			 * fc->blocked with waiters with the wake_up() call
+			 * above.
+			 */
+			if (waitqueue_active(&fc->blocked_waitq))
+				wake_up(&fc->blocked_waitq);
+		}
=20
 		if (fc->num_background =3D=3D fc->congestion_threshold &&
 		    fc->connected && fc->bdi_initialized) {
@@ -1675,8 +1682,10 @@ static int fuse_retrieve(struct fuse_conn *fc, struc=
t inode *inode,
 	req->in.args[1].size =3D total_len;
=20
 	err =3D fuse_request_send_notify_reply(fc, req, outarg->notify_unique);
-	if (err)
+	if (err) {
 		fuse_retrieve_end(fc, req);
+		fuse_put_request(fc, req);
+	}
=20
 	return err;
 }
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 70f4c4361843..a692583913c9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -488,7 +488,7 @@ static int fuse_create_open(struct inode *dir, struct d=
entry *entry,
 	if (err) {
 		fuse_sync_release(ff, flags);
 	} else {
-		file->private_data =3D fuse_file_get(ff);
+		file->private_data =3D ff;
 		fuse_finish_open(inode, file);
 	}
 	return err;
@@ -1510,7 +1510,7 @@ static int fuse_dir_open(struct inode *inode, struct =
file *file)
=20
 static int fuse_dir_release(struct inode *inode, struct file *file)
 {
-	fuse_release_common(file, FUSE_RELEASEDIR);
+	fuse_release_common(file, true);
=20
 	return 0;
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3bae40c4d40f..b2203c5113cf 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -66,7 +66,7 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc)
 	}
=20
 	INIT_LIST_HEAD(&ff->write_entry);
-	atomic_set(&ff->count, 0);
+	atomic_set(&ff->count, 1);
 	RB_CLEAR_NODE(&ff->polled_node);
 	init_waitqueue_head(&ff->poll_wait);
=20
@@ -83,7 +83,7 @@ void fuse_file_free(struct fuse_file *ff)
 	kfree(ff);
 }
=20
-struct fuse_file *fuse_file_get(struct fuse_file *ff)
+static struct fuse_file *fuse_file_get(struct fuse_file *ff)
 {
 	atomic_inc(&ff->count);
 	return ff;
@@ -122,12 +122,12 @@ static void fuse_release_end(struct fuse_conn *fc, st=
ruct fuse_req *req)
 	}
 }
=20
-static void fuse_file_put(struct fuse_file *ff, bool sync)
+static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 {
 	if (atomic_dec_and_test(&ff->count)) {
 		struct fuse_req *req =3D ff->reserved_req;
=20
-		if (ff->fc->no_open) {
+		if (ff->fc->no_open && !isdir) {
 			/*
 			 * Drop the release request when client does not
 			 * implement 'open'
@@ -183,7 +183,7 @@ int fuse_do_open(struct fuse_conn *fc, u64 nodeid, stru=
ct file *file,
 		ff->open_flags &=3D ~FOPEN_DIRECT_IO;
=20
 	ff->nodeid =3D nodeid;
-	file->private_data =3D fuse_file_get(ff);
+	file->private_data =3D ff;
=20
 	return 0;
 }
@@ -280,10 +280,11 @@ static void fuse_prepare_release(struct fuse_file *ff=
, int flags, int opcode)
 	req->in.args[0].value =3D inarg;
 }
=20
-void fuse_release_common(struct file *file, int opcode)
+void fuse_release_common(struct file *file, bool isdir)
 {
 	struct fuse_file *ff;
 	struct fuse_req *req;
+	int opcode =3D isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
=20
 	ff =3D file->private_data;
 	if (unlikely(!ff))
@@ -311,7 +312,7 @@ void fuse_release_common(struct file *file, int opcode)
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
 	 */
-	fuse_file_put(ff, ff->fc->destroy_req !=3D NULL);
+	fuse_file_put(ff, ff->fc->destroy_req !=3D NULL, isdir);
 }
=20
 static int fuse_open(struct inode *inode, struct file *file)
@@ -327,7 +328,7 @@ static int fuse_release(struct inode *inode, struct fil=
e *file)
 	if (fc->writeback_cache)
 		write_inode_now(inode, 1);
=20
-	fuse_release_common(file, FUSE_RELEASE);
+	fuse_release_common(file, false);
=20
 	/* return value is ignored by VFS */
 	return 0;
@@ -335,13 +336,13 @@ static int fuse_release(struct inode *inode, struct f=
ile *file)
=20
 void fuse_sync_release(struct fuse_file *ff, int flags)
 {
-	WARN_ON(atomic_read(&ff->count) > 1);
+	WARN_ON(atomic_read(&ff->count) !=3D 1);
 	fuse_prepare_release(ff, flags, FUSE_RELEASE);
-	ff->reserved_req->force =3D 1;
-	ff->reserved_req->background =3D 0;
-	fuse_request_send(ff->fc, ff->reserved_req);
-	fuse_put_request(ff->fc, ff->reserved_req);
-	kfree(ff);
+	/*
+	 * iput(NULL) is a no-op and since the refcount is 1 and everything's
+	 * synchronous, we are fine with not doing igrab() here"
+	 */
+	fuse_file_put(ff, true, false);
 }
 EXPORT_SYMBOL_GPL(fuse_sync_release);
=20
@@ -849,7 +850,7 @@ static void fuse_readpages_end(struct fuse_conn *fc, st=
ruct fuse_req *req)
 		page_cache_release(page);
 	}
 	if (req->ff)
-		fuse_file_put(req->ff, false);
+		fuse_file_put(req->ff, false, false);
 }
=20
 static void fuse_send_readpages(struct fuse_req *req, struct file *file)
@@ -1528,7 +1529,7 @@ static void fuse_writepage_free(struct fuse_conn *fc,=
 struct fuse_req *req)
 		__free_page(req->pages[i]);
=20
 	if (req->ff)
-		fuse_file_put(req->ff, false);
+		fuse_file_put(req->ff, false, false);
 }
=20
 static void fuse_writepage_finish(struct fuse_conn *fc, struct fuse_req *r=
eq)
@@ -1685,7 +1686,7 @@ int fuse_write_inode(struct inode *inode, struct writ=
eback_control *wbc)
 	ff =3D __fuse_write_file_get(fc, fi);
 	err =3D fuse_flush_times(inode, ff);
 	if (ff)
-		fuse_file_put(ff, 0);
+		fuse_file_put(ff, false, false);
=20
 	return err;
 }
@@ -1998,7 +1999,7 @@ static int fuse_writepages(struct address_space *mapp=
ing,
 		err =3D 0;
 	}
 	if (data.ff)
-		fuse_file_put(data.ff, false);
+		fuse_file_put(data.ff, false, false);
=20
 	kfree(data.orig_pages);
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8ed9ed08d2a0..66019e05e3ad 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -663,7 +663,6 @@ void fuse_read_fill(struct fuse_req *req, struct file *=
file,
 int fuse_open_common(struct inode *inode, struct file *file, bool isdir);
=20
 struct fuse_file *fuse_file_alloc(struct fuse_conn *fc);
-struct fuse_file *fuse_file_get(struct fuse_file *ff);
 void fuse_file_free(struct fuse_file *ff);
 void fuse_finish_open(struct inode *inode, struct file *file);
=20
@@ -672,7 +671,7 @@ void fuse_sync_release(struct fuse_file *ff, int flags);
 /**
  * Send RELEASE or RELEASEDIR request
  */
-void fuse_release_common(struct file *file, int opcode);
+void fuse_release_common(struct file *file, bool isdir);
=20
 /**
  * Send FSYNC or FSYNCDIR request
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index bc564c0d6d16..b95d935cf3ee 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1365,6 +1365,9 @@ static struct dentry *gfs2_mount_meta(struct file_sys=
tem_type *fs_type,
 	struct path path;
 	int error;
=20
+	if (!dev_name || !*dev_name)
+		return ERR_PTR(-EINVAL);
+
 	error =3D kern_path(dev_name, LOOKUP_FOLLOW, &path);
 	if (error) {
 		pr_warn("path_lookup on %s returned error %d\n",
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 1ab19e660e69..1ff5774a5382 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -328,13 +328,14 @@ void hfs_bmap_free(struct hfs_bnode *node)
=20
 		nidx -=3D len * 8;
 		i =3D node->next;
-		hfs_bnode_put(node);
 		if (!i) {
 			/* panic */;
 			pr_crit("unable to free bnode %u. bmap not found!\n",
 				node->this);
+			hfs_bnode_put(node);
 			return;
 		}
+		hfs_bnode_put(node);
 		node =3D hfs_bnode_find(tree, i);
 		if (IS_ERR(node))
 			return;
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 10902f70883d..f3194e5147fd 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -285,10 +285,8 @@ static int jffs2_fill_super(struct super_block *sb, vo=
id *data, int silent)
 	sb->s_fs_info =3D c;
=20
 	ret =3D jffs2_parse_options(c, data);
-	if (ret) {
-		kfree(c);
+	if (ret)
 		return -EINVAL;
-	}
=20
 	/* Initialize JFFS2 superblock locks, the further initialization will
 	 * be done later */
diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index b5f3c3ab0d5f..b31117c12102 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -339,7 +339,7 @@ struct nlm_host *nlmsvc_lookup_host(const struct svc_rq=
st *rqstp,
 	};
 	struct lockd_net *ln =3D net_generic(net, lockd_net_id);
=20
-	dprintk("lockd: %s(host=3D'%*s', vers=3D%u, proto=3D%s)\n", __func__,
+	dprintk("lockd: %s(host=3D'%.*s', vers=3D%u, proto=3D%s)\n", __func__,
 			(int)hostname_len, hostname, rqstp->rq_vers,
 			(rqstp->rq_prot =3D=3D IPPROTO_UDP ? "udp" : "tcp"));
=20
diff --git a/fs/namespace.c b/fs/namespace.c
index ad7a0f80b103..5acf789efbab 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1423,8 +1423,13 @@ static int do_umount(struct mount *mnt, int flags)
=20
 	namespace_lock();
 	lock_mount_hash();
-	event++;
=20
+	/* Recheck MNT_LOCKED with the locks held */
+	retval =3D -EINVAL;
+	if (mnt->mnt.mnt_flags & MNT_LOCKED)
+		goto out;
+
+	event++;
 	if (flags & MNT_DETACH) {
 		if (!list_empty(&mnt->mnt_list))
 			umount_tree(mnt, UMOUNT_PROPAGATE);
@@ -1438,6 +1443,7 @@ static int do_umount(struct mount *mnt, int flags)
 			retval =3D 0;
 		}
 	}
+out:
 	unlock_mount_hash();
 	namespace_unlock();
 	return retval;
@@ -1484,7 +1490,7 @@ SYSCALL_DEFINE2(umount, char __user *, name, int, fla=
gs)
 		goto dput_and_out;
 	if (!check_mnt(mnt))
 		goto dput_and_out;
-	if (mnt->mnt.mnt_flags & MNT_LOCKED)
+	if (mnt->mnt.mnt_flags & MNT_LOCKED) /* Check optimistically */
 		goto dput_and_out;
 	retval =3D -EPERM;
 	if (flags & MNT_FORCE && !capable(CAP_SYS_ADMIN))
@@ -1568,8 +1574,14 @@ struct mount *copy_tree(struct mount *mnt, struct de=
ntry *dentry,
 			struct mount *t =3D NULL;
 			if (!(flag & CL_COPY_UNBINDABLE) &&
 			    IS_MNT_UNBINDABLE(s)) {
-				s =3D skip_mnt_tree(s);
-				continue;
+				if (s->mnt.mnt_flags & MNT_LOCKED) {
+					/* Both unbindable and locked. */
+					q =3D ERR_PTR(-EPERM);
+					goto out;
+				} else {
+					s =3D skip_mnt_tree(s);
+					continue;
+				}
 			}
 			if (!(flag & CL_COPY_MNT_NS_FILE) &&
 			    is_mnt_ns_file(s->mnt.mnt_root)) {
@@ -1629,7 +1641,7 @@ void drop_collected_mounts(struct vfsmount *mnt)
 {
 	namespace_lock();
 	lock_mount_hash();
-	umount_tree(real_mount(mnt), UMOUNT_SYNC);
+	umount_tree(real_mount(mnt), 0);
 	unlock_mount_hash();
 	namespace_unlock();
 }
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f96c66b4d504..474cb8195245 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2427,11 +2427,12 @@ static void nfs4_state_manager(struct nfs_client *c=
lp)
 		nfs4_clear_state_manager_bit(clp);
 		/* Did we race with an attempt to give us more work? */
 		if (clp->cl_state =3D=3D 0)
-			break;
+			return;
 		if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) !=3D 0)
-			break;
+			return;
 	} while (atomic_read(&clp->cl_count) > 1);
-	return;
+	goto out_drain;
+
 out_error:
 	if (strlen(section))
 		section_sep =3D ": ";
@@ -2439,6 +2440,7 @@ static void nfs4_state_manager(struct nfs_client *clp)
 			" with error %d\n", section_sep, section,
 			clp->cl_hostname, -status);
 	ssleep(1);
+out_drain:
 	nfs4_end_drain_session(clp);
 	nfs4_clear_state_manager_bit(clp);
 }
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 0717662b4aef..0165e4ff163c 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1906,8 +1906,7 @@ static int ocfs2_dir_foreach_blk_el(struct inode *ino=
de,
 				/* On error, skip the f_pos to the
 				   next block. */
 				ctx->pos =3D (ctx->pos | (sb->s_blocksize - 1)) + 1;
-				brelse(bh);
-				continue;
+				break;
 			}
 			if (le64_to_cpu(de->inode)) {
 				unsigned char d_type =3D DT_UNKNOWN;
diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index 02fa1dcc5969..29f5b2e589a1 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -275,7 +275,7 @@ static int __sysv_write_inode(struct inode *inode, int =
wait)
                 }
         }
 	brelse(bh);
-	return 0;
+	return err;
 }
=20
 int sysv_write_inode(struct inode *inode, struct writeback_control *wbc)
diff --git a/fs/xfs/xfs_stats.c b/fs/xfs/xfs_stats.c
index f2240383d4bb..cd35b2eae811 100644
--- a/fs/xfs/xfs_stats.c
+++ b/fs/xfs/xfs_stats.c
@@ -135,7 +135,7 @@ static int xqmstat_proc_show(struct seq_file *m, void *=
v)
 	int j;
=20
 	seq_printf(m, "qm");
-	for (j =3D XFSSTAT_END_IBT_V2; j < XFSSTAT_END_XQMSTAT; j++)
+	for (j =3D XFSSTAT_END_FIBT_V2; j < XFSSTAT_END_XQMSTAT; j++)
 		seq_printf(m, " %u", counter_val(j));
 	seq_putc(m, '\n');
 	return 0;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 108d2efcb015..0e3249c1a0ec 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -127,6 +127,7 @@ void can_change_state(struct net_device *dev, struct ca=
n_frame *cf,
=20
 void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		      unsigned int idx);
+struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int id=
x, u8 *len_ptr);
 unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
 void can_free_echo_skb(struct net_device *dev, unsigned int idx);
=20
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 279b0afac1c1..4f22e21806c3 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -67,7 +67,13 @@ struct ceph_options {
=20
 #define CEPH_MSG_MAX_FRONT_LEN	(16*1024*1024)
 #define CEPH_MSG_MAX_MIDDLE_LEN	(16*1024*1024)
-#define CEPH_MSG_MAX_DATA_LEN	(16*1024*1024)
+
+/*
+ * Handle the largest possible rbd object in one message.
+ * There is no limit on the size of cephfs objects, but it has to obey
+ * rsize and wsize mount options anyway.
+ */
+#define CEPH_MSG_MAX_DATA_LEN	(32*1024*1024)
=20
 #define CEPH_AUTH_NAME_DEFAULT   "guest"
=20
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index 51f7ccadf923..0d182665f142 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -149,6 +149,7 @@ int sensor_hub_input_get_attribute_info(struct hid_sens=
or_hub_device *hsdev,
 * @usage_id:	Attribute usage id of parent physical device as per spec
 * @attr_usage_id:	Attribute usage id as per spec
 * @report_id:	Report id to look for
+* @is_signed:   If true then fields < 32 bits will be sign-extended
 *
 * Issues a synchronous read request for an input attribute. Returns
 * data upto 32 bits. Since client can get events, so this call should
@@ -157,7 +158,8 @@ int sensor_hub_input_get_attribute_info(struct hid_sens=
or_hub_device *hsdev,
=20
 int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsde=
v,
 			u32 usage_id,
-			u32 attr_usage_id, u32 report_id);
+			u32 attr_usage_id, u32 report_id,
+			bool is_signed);
 /**
 * sensor_hub_set_feature() - Feature set request
 * @report_id:	Report id to look for
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index e6bb36a97519..8336b2f6f834 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,6 +21,7 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
=20
 extern raw_spinlock_t i8253_lock;
+extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
=20
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 23f1ce4e554e..0b9b56809dab 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -121,7 +121,6 @@ static inline bool is_error_page(struct page *page)
 #define KVM_REQ_MMU_SYNC           7
 #define KVM_REQ_CLOCK_UPDATE       8
 #define KVM_REQ_KICK               9
-#define KVM_REQ_DEACTIVATE_FPU    10
 #define KVM_REQ_EVENT             11
 #define KVM_REQ_APF_HALT          12
 #define KVM_REQ_STEAL_UPDATE      13
@@ -232,7 +231,6 @@ struct kvm_vcpu {
 	struct mutex mutex;
 	struct kvm_run *run;
=20
-	int fpu_active;
 	int guest_fpu_loaded, guest_xcr0_loaded;
 	wait_queue_head_t wq;
 	struct pid *pid;
diff --git a/include/linux/netfilter/x_tables.h b/include/linux/netfilter/x=
_tables.h
index cc615e273f80..b95f00cb6219 100644
--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -247,6 +247,8 @@ unsigned int *xt_alloc_entry_offsets(unsigned int size);
 bool xt_find_jump_offset(const unsigned int *offsets,
 			 unsigned int target, unsigned int size);
=20
+int xt_check_proc_name(const char *name, unsigned int size);
+
 int xt_check_match(struct xt_mtchk_param *, unsigned int size, u_int8_t pr=
oto,
 		   bool inv_proto);
 int xt_check_target(struct xt_tgchk_param *, unsigned int size, u_int8_t p=
roto,
diff --git a/include/linux/of.h b/include/linux/of.h
index 0c220cf91e92..15e6a340c1bd 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -237,6 +237,8 @@ extern struct device_node *of_get_next_child(const stru=
ct device_node *node,
 extern struct device_node *of_get_next_available_child(
 	const struct device_node *node, struct device_node *prev);
=20
+extern struct device_node *of_get_compatible_child(const struct device_nod=
e *parent,
+					const char *compatible);
 extern struct device_node *of_get_child_by_name(const struct device_node *=
node,
 					const char *name);
=20
@@ -412,6 +414,12 @@ static inline bool of_have_populated_dt(void)
 	return false;
 }
=20
+static inline struct device_node *of_get_compatible_child(const struct dev=
ice_node *parent,
+					const char *compatible)
+{
+	return NULL;
+}
+
 static inline struct device_node *of_get_child_by_name(
 					const struct device_node *node,
 					const char *name)
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ecd3319dac33..ee7e1b8afd3a 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -2,6 +2,9 @@
 #define __LINUX_UACCESS_H__
=20
 #include <linux/preempt.h>
+
+#define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)
+
 #include <asm/uaccess.h>
=20
 /*
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 7199f201c7a8..a53e036b2252 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -334,11 +334,11 @@ struct usb_host_bos {
 };
=20
 int __usb_get_extra_descriptor(char *buffer, unsigned size,
-	unsigned char type, void **ptr);
+	unsigned char type, void **ptr, size_t min);
 #define usb_get_extra_descriptor(ifpoint, type, ptr) \
 				__usb_get_extra_descriptor((ifpoint)->extra, \
 				(ifpoint)->extralen, \
-				type, (void **)ptr)
+				type, (void **)ptr, sizeof(**(ptr)))
=20
 /* -----------------------------------------------------------------------=
 */
=20
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index 70b965c25e3a..efc4e51c425a 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -59,4 +59,7 @@
 /* Device needs a pause after every control message. */
 #define USB_QUIRK_DELAY_CTRL_MSG		BIT(13)
=20
+/* Hub needs extra delay after resetting its port. */
+#define USB_QUIRK_HUB_SLOW_RESET		BIT(14)
+
 #endif /* __LINUX_USB_QUIRKS_H */
diff --git a/include/net/cipso_ipv4.h b/include/net/cipso_ipv4.h
index c8b8852ce9b8..a34b141f125f 100644
--- a/include/net/cipso_ipv4.h
+++ b/include/net/cipso_ipv4.h
@@ -120,13 +120,6 @@ extern int cipso_v4_rbm_optfmt;
 extern int cipso_v4_rbm_strictvalid;
 #endif
=20
-/*
- * Helper Functions
- */
-
-#define CIPSO_V4_OPTEXIST(x) (IPCB(x)->opt.cipso !=3D 0)
-#define CIPSO_V4_OPTPTR(x) (skb_network_header(x) + IPCB(x)->opt.cipso)
-
 /*
  * DOI List Functions
  */
@@ -190,7 +183,7 @@ static inline int cipso_v4_doi_domhsh_remove(struct cip=
so_v4_doi *doi_def,
=20
 #ifdef CONFIG_NETLABEL
 void cipso_v4_cache_invalidate(void);
-int cipso_v4_cache_add(const struct sk_buff *skb,
+int cipso_v4_cache_add(const unsigned char *cipso_ptr,
 		       const struct netlbl_lsm_secattr *secattr);
 #else
 static inline void cipso_v4_cache_invalidate(void)
@@ -198,7 +191,7 @@ static inline void cipso_v4_cache_invalidate(void)
 	return;
 }
=20
-static inline int cipso_v4_cache_add(const struct sk_buff *skb,
+static inline int cipso_v4_cache_add(const unsigned char *cipso_ptr,
 				     const struct netlbl_lsm_secattr *secattr)
 {
 	return 0;
@@ -211,6 +204,8 @@ static inline int cipso_v4_cache_add(const struct sk_bu=
ff *skb,
=20
 #ifdef CONFIG_NETLABEL
 void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway);
+int cipso_v4_getattr(const unsigned char *cipso,
+		     struct netlbl_lsm_secattr *secattr);
 int cipso_v4_sock_setattr(struct sock *sk,
 			  const struct cipso_v4_doi *doi_def,
 			  const struct netlbl_lsm_secattr *secattr);
@@ -226,6 +221,7 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb,
 int cipso_v4_skbuff_delattr(struct sk_buff *skb);
 int cipso_v4_skbuff_getattr(const struct sk_buff *skb,
 			    struct netlbl_lsm_secattr *secattr);
+unsigned char *cipso_v4_optptr(const struct sk_buff *skb);
 int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option);
 #else
 static inline void cipso_v4_error(struct sk_buff *skb,
@@ -235,6 +231,12 @@ static inline void cipso_v4_error(struct sk_buff *skb,
 	return;
 }
=20
+static inline int cipso_v4_getattr(const unsigned char *cipso,
+				   struct netlbl_lsm_secattr *secattr)
+{
+	return -ENOSYS;
+}
+
 static inline int cipso_v4_sock_setattr(struct sock *sk,
 				      const struct cipso_v4_doi *doi_def,
 				      const struct netlbl_lsm_secattr *secattr)
@@ -282,6 +284,11 @@ static inline int cipso_v4_skbuff_getattr(const struct=
 sk_buff *skb,
 	return -ENOSYS;
 }
=20
+static inline unsigned char *cipso_v4_optptr(const struct sk_buff *skb)
+{
+	return NULL;
+}
+
 static inline int cipso_v4_validate(const struct sk_buff *skb,
 				    unsigned char **option)
 {
diff --git a/kernel/bounds.c b/kernel/bounds.c
index 9fd4246b04b8..a4af3e34357f 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -13,7 +13,7 @@
 #include <linux/log2.h>
 #include <linux/spinlock_types.h>
=20
-void foo(void)
+int main(void)
 {
 	/* The enum constants to put into include/generated/bounds.h */
 	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
@@ -24,4 +24,6 @@ void foo(void)
 #endif
 	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
 	/* End of constants */
+
+	return 0;
 }
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 9a4d44f93015..29d45591076f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -610,7 +610,7 @@ static int prepare_uprobe(struct uprobe *uprobe, struct=
 file *file,
 	BUG_ON((uprobe->offset & ~PAGE_MASK) +
 			UPROBE_SWBP_INSN_SIZE > PAGE_SIZE);
=20
-	smp_wmb(); /* pairs with rmb() in find_active_uprobe() */
+	smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
 	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
=20
  out:
@@ -1858,10 +1858,18 @@ static void handle_swbp(struct pt_regs *regs)
 	 * After we hit the bp, _unregister + _register can install the
 	 * new and not-yet-analyzed uprobe at the same address, restart.
 	 */
-	smp_rmb(); /* pairs with wmb() in install_breakpoint() */
 	if (unlikely(!test_bit(UPROBE_COPY_INSN, &uprobe->flags)))
 		goto out;
=20
+	/*
+	 * Pairs with the smp_wmb() in prepare_uprobe().
+	 *
+	 * Guarantees that if we see the UPROBE_COPY_INSN bit set, then
+	 * we must also see the stores to &uprobe->arch performed by the
+	 * prepare_uprobe() call.
+	 */
+	smp_rmb();
+
 	/* Tracing handlers use ->utask to communicate with fetch methods */
 	if (!get_utask())
 		goto out;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1ce20fc82364..e900d079957e 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -805,6 +805,9 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqa=
ction *action)
=20
 	local_bh_disable();
 	ret =3D action->thread_fn(action->irq, action->dev_id);
+	if (ret =3D=3D IRQ_HANDLED)
+		atomic_inc(&desc->threads_handled);
+
 	irq_finalize_oneshot(desc, action);
 	local_bh_enable();
 	return ret;
@@ -821,6 +824,9 @@ static irqreturn_t irq_thread_fn(struct irq_desc *desc,
 	irqreturn_t ret;
=20
 	ret =3D action->thread_fn(action->irq, action->dev_id);
+	if (ret =3D=3D IRQ_HANDLED)
+		atomic_inc(&desc->threads_handled);
+
 	irq_finalize_oneshot(desc, action);
 	return ret;
 }
@@ -886,8 +892,6 @@ static int irq_thread(void *data)
 		irq_thread_check_affinity(desc, action);
=20
 		action_ret =3D handler_fn(desc, action);
-		if (action_ret =3D=3D IRQ_HANDLED)
-			atomic_inc(&desc->threads_handled);
=20
 		wake_threads_waitq(desc);
 	}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 09d5b8143b94..eab6a64517c3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -837,7 +837,12 @@ static unsigned long __initdata new_log_buf_len;
 /* save requested log_buf_len since it's too early to process it */
 static int __init log_buf_len_setup(char *str)
 {
-	unsigned size =3D memparse(str, &str);
+	unsigned int size;
+
+	if (!str)
+		return -EINVAL;
+
+	size =3D memparse(str, &str);
=20
 	if (size)
 		size =3D roundup_pow_of_two(size);
diff --git a/kernel/signal.c b/kernel/signal.c
index 998e9f173c45..ce4d529e7f3c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1040,7 +1040,7 @@ static int __send_signal(int sig, struct siginfo *inf=
o, struct task_struct *t,
=20
 	result =3D TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t,
-			from_ancestor_ns || (info =3D=3D SEND_SIG_FORCED)))
+			from_ancestor_ns || (info =3D=3D SEND_SIG_PRIV) || (info =3D=3D SEND_SI=
G_FORCED)))
 		goto ret;
=20
 	pending =3D group ? &t->signal->shared_pending : &t->pending;
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 61ed862cdd37..37d7e4d29e5f 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -362,7 +362,7 @@ static int __init init_timer_list_procfs(void)
 {
 	struct proc_dir_entry *pe;
=20
-	pe =3D proc_create("timer_list", 0444, NULL, &timer_list_fops);
+	pe =3D proc_create("timer_list", 0400, NULL, &timer_list_fops);
 	if (!pe)
 		return -ENOMEM;
 	return 0;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3b1f547a80e1..8ee705e1d472 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4127,6 +4127,7 @@ void ftrace_destroy_filter_files(struct ftrace_ops *o=
ps)
 	if (ops->flags & FTRACE_OPS_FL_ENABLED)
 		ftrace_shutdown(ops, 0);
 	ops->flags |=3D FTRACE_OPS_FL_DELETED;
+	ftrace_free_filter(ops);
 	mutex_unlock(&ftrace_lock);
 }
=20
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_event=
s_trigger.c
index a958d3397a52..909502d8710f 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -727,8 +727,10 @@ static int set_trigger_filter(char *filter_str,
=20
 	/* The filter is for the 'trigger' event, not the triggered event */
 	ret =3D create_event_filter(file->event_call, filter_str, false, &filter);
-	if (ret)
-		goto out;
+	/*
+	 * If create_event_filter() fails, filter still needs to be freed.
+	 * Which the calling code will do with data->filter.
+	 */
  assign:
 	tmp =3D rcu_access_pointer(data->filter);
=20
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f6ff7414c439..3ca4e9eb205b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2606,7 +2606,7 @@ static int is_hugetlb_entry_hwpoisoned(pte_t pte)
 int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			    struct vm_area_struct *vma)
 {
-	pte_t *src_pte, *dst_pte, entry;
+	pte_t *src_pte, *dst_pte, entry, dst_entry;
 	struct page *ptepage;
 	unsigned long addr;
 	int cow;
@@ -2634,15 +2634,30 @@ int copy_hugetlb_page_range(struct mm_struct *dst, =
struct mm_struct *src,
 			break;
 		}
=20
-		/* If the pagetables are shared don't copy or take references */
-		if (dst_pte =3D=3D src_pte)
+		/*
+		 * If the pagetables are shared don't copy or take references.
+		 * dst_pte =3D=3D src_pte is the common case of src/dest sharing.
+		 *
+		 * However, src could have 'unshared' and dst shares with
+		 * another vma.  If dst_pte !none, this implies sharing.
+		 * Check here before taking page table lock, and once again
+		 * after taking the lock below.
+		 */
+		dst_entry =3D huge_ptep_get(dst_pte);
+		if ((dst_pte =3D=3D src_pte) || !huge_pte_none(dst_entry))
 			continue;
=20
 		dst_ptl =3D huge_pte_lock(h, dst, dst_pte);
 		src_ptl =3D huge_pte_lockptr(h, src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		entry =3D huge_ptep_get(src_pte);
-		if (huge_pte_none(entry)) { /* skip none entry */
+		dst_entry =3D huge_ptep_get(dst_pte);
+		if (huge_pte_none(entry) || !huge_pte_none(dst_entry)) {
+			/*
+			 * Skip if src entry none.  Also, skip in the
+			 * unlikely case dst entry !none as this implies
+			 * sharing with another vma.
+			 */
 			;
 		} else if (unlikely(is_hugetlb_entry_migration(entry) ||
 				    is_hugetlb_entry_hwpoisoned(entry))) {
@@ -3085,6 +3100,12 @@ static int hugetlb_no_page(struct mm_struct *mm, str=
uct vm_area_struct *vma,
 			}
 			ClearPagePrivate(page);
=20
+			/*
+			 * set page dirty so that it will not be removed from
+			 * cache/file by non-hugetlbfs specific code paths.
+			 */
+			set_page_dirty(page);
+
 			spin_lock(&inode->i_lock);
 			inode->i_blocks +=3D blocks_per_huge_page(h);
 			spin_unlock(&inode->i_lock);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1e0ec777523e..a5033435b9ca 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -780,6 +780,8 @@ int __remove_pages(struct zone *zone, unsigned long phy=
s_start_pfn,
 	sections_to_remove =3D nr_pages / PAGES_PER_SECTION;
 	for (i =3D 0; i < sections_to_remove; i++) {
 		unsigned long pfn =3D phys_start_pfn + i*PAGES_PER_SECTION;
+
+		cond_resched();
 		ret =3D __remove_section(zone, __pfn_to_section(pfn));
 		if (ret)
 			break;
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 50de6a07c65e..9dbe19f9d0ba 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -162,6 +162,7 @@ static bool batadv_frag_insert_packet(struct batadv_ori=
g_node *orig_node,
 		hlist_add_head(&frag_entry_new->list, &chain->head);
 		chain->size =3D skb->len - hdr_size;
 		chain->timestamp =3D jiffies;
+		chain->total_size =3D ntohs(frag_packet->total_size);
 		ret =3D true;
 		goto out;
 	}
@@ -196,9 +197,11 @@ static bool batadv_frag_insert_packet(struct batadv_or=
ig_node *orig_node,
=20
 out:
 	if (chain->size > batadv_frag_size_limit() ||
-	    ntohs(frag_packet->total_size) > batadv_frag_size_limit()) {
+	    chain->total_size !=3D ntohs(frag_packet->total_size) ||
+	    chain->total_size > batadv_frag_size_limit()) {
 		/* Clear chain if total size of either the list or the packet
-		 * exceeds the maximum size of one merged packet.
+		 * exceeds the maximum size of one merged packet. Don't allow
+		 * packets to have different total_size.
 		 */
 		batadv_frag_clear_chain(&chain->head);
 		chain->size =3D 0;
@@ -231,19 +234,13 @@ static bool batadv_frag_insert_packet(struct batadv_o=
rig_node *orig_node,
  * Returns the merged skb or NULL on error.
  */
 static struct sk_buff *
-batadv_frag_merge_packets(struct hlist_head *chain, struct sk_buff *skb)
+batadv_frag_merge_packets(struct hlist_head *chain)
 {
 	struct batadv_frag_packet *packet;
 	struct batadv_frag_list_entry *entry;
 	struct sk_buff *skb_out =3D NULL;
 	int size, hdr_size =3D sizeof(struct batadv_frag_packet);
=20
-	/* Make sure incoming skb has non-bogus data. */
-	packet =3D (struct batadv_frag_packet *)skb->data;
-	size =3D ntohs(packet->total_size);
-	if (size > batadv_frag_size_limit())
-		goto free;
-
 	/* Remove first entry, as this is the destination for the rest of the
 	 * fragments.
 	 */
@@ -252,6 +249,9 @@ batadv_frag_merge_packets(struct hlist_head *chain, str=
uct sk_buff *skb)
 	skb_out =3D entry->skb;
 	kfree(entry);
=20
+	packet =3D (struct batadv_frag_packet *)skb_out->data;
+	size =3D ntohs(packet->total_size) + hdr_size;
+
 	/* Make room for the rest of the fragments. */
 	if (pskb_expand_head(skb_out, 0, size - skb_out->len, GFP_ATOMIC) < 0) {
 		kfree_skb(skb_out);
@@ -308,7 +308,7 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
 	if (hlist_empty(&head))
 		goto out;
=20
-	skb_out =3D batadv_frag_merge_packets(&head, *skb);
+	skb_out =3D batadv_frag_merge_packets(&head);
 	if (!skb_out)
 		goto out_err;
=20
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c6388ce62f82..e43e4cb70421 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -132,6 +132,7 @@ struct batadv_orig_ifinfo {
  * @timestamp: time (jiffie) of last received fragment
  * @seqno: sequence number of the fragments in the list
  * @size: accumulated size of packets in list
+ * @total_size: expected size of the assembled packet
  */
 struct batadv_frag_table_entry {
 	struct hlist_head head;
@@ -139,6 +140,7 @@ struct batadv_frag_table_entry {
 	unsigned long timestamp;
 	uint16_t seqno;
 	uint16_t size;
+	uint16_t total_size;
 };
=20
 /**
diff --git a/net/can/raw.c b/net/can/raw.c
index 59e4cab9cd76..2b13d49867ab 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -686,18 +686,19 @@ static int raw_sendmsg(struct kiocb *iocb, struct soc=
ket *sock,
 	} else
 		ifindex =3D ro->ifindex;
=20
-	if (ro->fd_frames) {
+	dev =3D dev_get_by_index(&init_net, ifindex);
+	if (!dev)
+		return -ENXIO;
+
+	err =3D -EINVAL;
+	if (ro->fd_frames && dev->mtu =3D=3D CANFD_MTU) {
 		if (unlikely(size !=3D CANFD_MTU && size !=3D CAN_MTU))
-			return -EINVAL;
+			goto put_dev;
 	} else {
 		if (unlikely(size !=3D CAN_MTU))
-			return -EINVAL;
+			goto put_dev;
 	}
=20
-	dev =3D dev_get_by_index(&init_net, ifindex);
-	if (!dev)
-		return -ENXIO;
-
 	skb =3D sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
 				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
diff --git a/net/core/dev.c b/net/core/dev.c
index 0a32a1dcb101..5fdda6aa5d1e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4170,6 +4170,10 @@ static void napi_reuse_skb(struct napi_struct *napi,=
 struct sk_buff *skb)
 	skb->vlan_tci =3D 0;
 	skb->dev =3D napi->dev;
 	skb->skb_iif =3D 0;
+
+	/* eth_type_trans() assumes pkt_type is PACKET_HOST */
+	skb->pkt_type =3D PACKET_HOST;
+
 	skb->encapsulation =3D 0;
 	skb_shinfo(skb)->gso_type =3D 0;
 	skb->truesize =3D SKB_TRUESIZE(skb_end_offset(skb));
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 2373ca1d1493..5fa63c1c7baa 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2360,6 +2360,11 @@ static int rtnl_fdb_add(struct sk_buff *skb, struct =
nlmsghdr *nlh)
 		return -EINVAL;
 	}
=20
+	if (dev->type !=3D ARPHRD_ETHER) {
+		pr_info("PF_BRIDGE: FDB add only supported for Ethernet devices\n");
+		return -EINVAL;
+	}
+
 	addr =3D nla_data(tb[NDA_LLADDR]);
=20
 	err =3D -EOPNOTSUPP;
@@ -2457,6 +2462,11 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct =
nlmsghdr *nlh)
 		return -EINVAL;
 	}
=20
+	if (dev->type !=3D ARPHRD_ETHER) {
+		pr_info("PF_BRIDGE: FDB delete only supported for Ethernet devices\n");
+		return -EINVAL;
+	}
+
 	addr =3D nla_data(tb[NDA_LLADDR]);
=20
 	err =3D -EOPNOTSUPP;
@@ -2536,6 +2546,9 @@ int ndo_dflt_fdb_dump(struct sk_buff *skb,
 {
 	int err;
=20
+	if (dev->type !=3D ARPHRD_ETHER)
+		return -EINVAL;
+
 	netif_addr_lock_bh(dev);
 	err =3D nlmsg_populate_fdb(skb, cb, dev, &idx, &dev->uc);
 	if (err)
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 25be314d0e17..8914ccb1cb60 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -376,20 +376,18 @@ static int cipso_v4_cache_check(const unsigned char *=
key,
  * negative values on failure.
  *
  */
-int cipso_v4_cache_add(const struct sk_buff *skb,
+int cipso_v4_cache_add(const unsigned char *cipso_ptr,
 		       const struct netlbl_lsm_secattr *secattr)
 {
 	int ret_val =3D -EPERM;
 	u32 bkt;
 	struct cipso_v4_map_cache_entry *entry =3D NULL;
 	struct cipso_v4_map_cache_entry *old_entry =3D NULL;
-	unsigned char *cipso_ptr;
 	u32 cipso_ptr_len;
=20
 	if (!cipso_v4_cache_enabled || cipso_v4_cache_bucketsize <=3D 0)
 		return 0;
=20
-	cipso_ptr =3D CIPSO_V4_OPTPTR(skb);
 	cipso_ptr_len =3D cipso_ptr[1];
=20
 	entry =3D kzalloc(sizeof(*entry), GFP_ATOMIC);
@@ -1591,6 +1589,44 @@ static int cipso_v4_parsetag_loc(const struct cipso_=
v4_doi *doi_def,
 	return 0;
 }
=20
+/**
+ * cipso_v4_optptr - Find the CIPSO option in the packet
+ * @skb: the packet
+ *
+ * Description:
+ * Parse the packet's IP header looking for a CIPSO option.  Returns a poi=
nter
+ * to the start of the CIPSO option on success, NULL if one is not found.
+ *
+ */
+unsigned char *cipso_v4_optptr(const struct sk_buff *skb)
+{
+	const struct iphdr *iph =3D ip_hdr(skb);
+	unsigned char *optptr =3D (unsigned char *)&(ip_hdr(skb)[1]);
+	int optlen;
+	int taglen;
+
+	for (optlen =3D iph->ihl*4 - sizeof(struct iphdr); optlen > 1; ) {
+		switch (optptr[0]) {
+		case IPOPT_END:
+			return NULL;
+		case IPOPT_NOOP:
+			taglen =3D 1;
+			break;
+		default:
+			taglen =3D optptr[1];
+		}
+		if (!taglen || taglen > optlen)
+			return NULL;
+		if (optptr[0] =3D=3D IPOPT_CIPSO)
+			return optptr;
+
+		optlen -=3D taglen;
+		optptr +=3D taglen;
+	}
+
+	return NULL;
+}
+
 /**
  * cipso_v4_validate - Validate a CIPSO option
  * @option: the start of the option, on error it is set to point to the er=
ror
@@ -2136,8 +2172,8 @@ void cipso_v4_req_delattr(struct request_sock *req)
  * on success and negative values on failure.
  *
  */
-static int cipso_v4_getattr(const unsigned char *cipso,
-			    struct netlbl_lsm_secattr *secattr)
+int cipso_v4_getattr(const unsigned char *cipso,
+		     struct netlbl_lsm_secattr *secattr)
 {
 	int ret_val =3D -ENOMSG;
 	u32 doi;
@@ -2322,22 +2358,6 @@ int cipso_v4_skbuff_delattr(struct sk_buff *skb)
 	return 0;
 }
=20
-/**
- * cipso_v4_skbuff_getattr - Get the security attributes from the CIPSO op=
tion
- * @skb: the packet
- * @secattr: the security attributes
- *
- * Description:
- * Parse the given packet's CIPSO option and return the security attribute=
s.
- * Returns zero on success and negative values on failure.
- *
- */
-int cipso_v4_skbuff_getattr(const struct sk_buff *skb,
-			    struct netlbl_lsm_secattr *secattr)
-{
-	return cipso_v4_getattr(CIPSO_V4_OPTPTR(skb), secattr);
-}
-
 /*
  * Setup Functions
  */
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 567a8646bd47..2f1a3da67262 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1681,10 +1681,10 @@ static void fib6_prune_clones(struct net *net, stru=
ct fib6_node *fn)
 static int fib6_update_sernum(struct rt6_info *rt, void *arg)
 {
 	__u32 sernum =3D *(__u32 *)arg;
+	struct fib6_node *fn =3D rcu_dereference(rt->rt6i_node);
=20
-	if (rt->rt6i_node &&
-	    rt->rt6i_node->fn_sernum !=3D sernum)
-		rt->rt6i_node->fn_sernum =3D sernum;
+	if (fn && fn->fn_sernum !=3D sernum)
+		fn->fn_sernum =3D sernum;
=20
 	return 0;
 }
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 922353050495..6542693e1c17 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -297,6 +297,7 @@ static int vti6_rcv(struct sk_buff *skb)
 			return 0;
 		}
=20
+		ipv6h =3D ipv6_hdr(skb);
 		if (!ip6_tnl_rcv_ctl(t, &ipv6h->daddr, &ipv6h->saddr)) {
 			t->dev->stats.rx_dropped++;
 			rcu_read_unlock();
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 79763be1fda6..283f4fd27b2b 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1568,10 +1568,9 @@ int ndisc_rcv(struct sk_buff *skb)
 		return 0;
 	}
=20
-	memset(NEIGH_CB(skb), 0, sizeof(struct neighbour_cb));
-
 	switch (msg->icmph.icmp6_type) {
 	case NDISC_NEIGHBOUR_SOLICITATION:
+		memset(NEIGH_CB(skb), 0, sizeof(struct neighbour_cb));
 		ndisc_recv_ns(skb);
 		break;
=20
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 943fc485b5ed..22b7bd8299ed 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1627,12 +1627,7 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel,=
 struct net *net,
 			goto err_sock;
 	}
=20
-	sk =3D sock->sk;
-
-	sock_hold(sk);
-	tunnel->sock =3D sk;
 	tunnel->l2tp_net =3D net;
-
 	pn =3D l2tp_pernet(net);
=20
 	spin_lock_bh(&pn->l2tp_tunnel_list_lock);
@@ -1647,6 +1642,10 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel,=
 struct net *net,
 	list_add_rcu(&tunnel->list, &pn->l2tp_tunnel_list);
 	spin_unlock_bh(&pn->l2tp_tunnel_list_lock);
=20
+	sk =3D sock->sk;
+	sock_hold(sk);
+	tunnel->sock =3D sk;
+
 	if (tunnel->encap =3D=3D L2TP_ENCAPTYPE_UDP) {
 		udp_sk(sk)->encap_type =3D UDP_ENCAP_L2TPINUDP;
 		udp_sk(sk)->encap_rcv =3D l2tp_udp_encap_recv;
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 9735705f0618..3fdbc4fe6976 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -723,7 +723,6 @@ static int llc_ui_recvmsg(struct kiocb *iocb, struct so=
cket *sock,
 	struct sk_buff *skb =3D NULL;
 	struct sock *sk =3D sock->sk;
 	struct llc_sock *llc =3D llc_sk(sk);
-	unsigned long cpu_flags;
 	size_t copied =3D 0;
 	u32 peek_seq =3D 0;
 	u32 *seq, skb_len;
@@ -849,9 +848,8 @@ static int llc_ui_recvmsg(struct kiocb *iocb, struct so=
cket *sock,
 			goto copy_uaddr;
=20
 		if (!(flags & MSG_PEEK)) {
-			spin_lock_irqsave(&sk->sk_receive_queue.lock, cpu_flags);
-			sk_eat_skb(sk, skb, false);
-			spin_unlock_irqrestore(&sk->sk_receive_queue.lock, cpu_flags);
+			skb_unlink(skb, &sk->sk_receive_queue);
+			kfree_skb(skb);
 			*seq =3D 0;
 		}
=20
@@ -872,10 +870,9 @@ static int llc_ui_recvmsg(struct kiocb *iocb, struct s=
ocket *sock,
 		llc_cmsg_rcv(msg, skb);
=20
 	if (!(flags & MSG_PEEK)) {
-			spin_lock_irqsave(&sk->sk_receive_queue.lock, cpu_flags);
-			sk_eat_skb(sk, skb, false);
-			spin_unlock_irqrestore(&sk->sk_receive_queue.lock, cpu_flags);
-			*seq =3D 0;
+		skb_unlink(skb, &sk->sk_receive_queue);
+		kfree_skb(skb);
+		*seq =3D 0;
 	}
=20
 	goto out;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index da555f878db7..cb35c4f48747 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -955,6 +955,8 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_d=
ata *sdata,
 	if (local->open_count =3D=3D 0)
 		ieee80211_clear_tx_pending(local);
=20
+	sdata->vif.bss_conf.beacon_int =3D 0;
+
 	/*
 	 * If the interface goes down while suspended, presumably because
 	 * the device was unplugged and that happens before our resume,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index ebdc2d160817..87d1722b6b1b 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -967,6 +967,7 @@ ieee80211_rx_h_check(struct ieee80211_rx_data *rx)
 	 */
 	if (rx->skb->len >=3D 24 && rx->sta &&
 	    !ieee80211_is_ctl(hdr->frame_control) &&
+	    !ieee80211_is_nullfunc(hdr->frame_control) &&
 	    !ieee80211_is_qos_nullfunc(hdr->frame_control) &&
 	    !is_multicast_ether_addr(hdr->addr1)) {
 		if (unlikely(ieee80211_has_retry(hdr->frame_control) &&
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ca6131c452b5..d698d23dceed 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -417,8 +417,8 @@ ieee80211_tx_h_multicast_ps_buf(struct ieee80211_tx_dat=
a *tx)
 	if (tx->local->hw.flags & IEEE80211_HW_QUEUE_CONTROL)
 		info->hw_queue =3D tx->sdata->vif.cab_queue;
=20
-	/* no stations in PS mode */
-	if (!atomic_read(&ps->num_sta_ps))
+	/* no stations in PS mode and no buffered packets */
+	if (!atomic_read(&ps->num_sta_ps) && skb_queue_empty(&ps->bc_buf))
 		return TX_CONTINUE;
=20
 	info->flags |=3D IEEE80211_TX_CTL_SEND_AFTER_DTIM;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 1a41bf30bb2e..92f32efde30b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1682,16 +1682,17 @@ static int nf_tables_getrule(struct sock *nlsk, str=
uct sk_buff *skb,
 static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
 				   struct nft_rule *rule)
 {
-	struct nft_expr *expr;
+	struct nft_expr *expr, *next;
=20
 	/*
 	 * Careful: some expressions might not be initialized in case this
 	 * is called on error from nf_tables_newrule().
 	 */
 	expr =3D nft_expr_first(rule);
-	while (expr->ops && expr !=3D nft_expr_last(rule)) {
+	while (expr !=3D nft_expr_last(rule) && expr->ops) {
+		next =3D nft_expr_next(expr);
 		nf_tables_expr_destroy(ctx, expr);
-		expr =3D nft_expr_next(expr);
+		expr =3D next;
 	}
 	kfree(rule);
 }
@@ -1767,16 +1768,13 @@ static int nf_tables_newrule(struct sock *nlsk, str=
uct sk_buff *skb,
=20
 		if (chain->use =3D=3D UINT_MAX)
 			return -EOVERFLOW;
-	}
=20
-	if (nla[NFTA_RULE_POSITION]) {
-		if (!(nlh->nlmsg_flags & NLM_F_CREATE))
-			return -EOPNOTSUPP;
-
-		pos_handle =3D be64_to_cpu(nla_get_be64(nla[NFTA_RULE_POSITION]));
-		old_rule =3D __nf_tables_rule_lookup(chain, pos_handle);
-		if (IS_ERR(old_rule))
-			return PTR_ERR(old_rule);
+		if (nla[NFTA_RULE_POSITION]) {
+			pos_handle =3D be64_to_cpu(nla_get_be64(nla[NFTA_RULE_POSITION]));
+			old_rule =3D __nf_tables_rule_lookup(chain, pos_handle);
+			if (IS_ERR(old_rule))
+				return PTR_ERR(old_rule);
+		}
 	}
=20
 	nft_ctx_init(&ctx, skb, nlh, afi, table, chain, nla);
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 55be1e0a4a7f..cf8b3de56f63 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -398,6 +398,7 @@ nft_match_destroy(const struct nft_ctx *ctx, const stru=
ct nft_expr *expr)
 {
 	struct xt_match *match =3D expr->ops->data;
 	void *info =3D nft_expr_priv(expr);
+	struct module *me =3D match->me;
 	struct xt_mtdtor_param par;
=20
 	par.net =3D ctx->net;
@@ -407,7 +408,7 @@ nft_match_destroy(const struct nft_ctx *ctx, const stru=
ct nft_expr *expr)
 	if (par.match->destroy !=3D NULL)
 		par.match->destroy(&par);
=20
-	module_put(match->me);
+	module_put(me);
 }
=20
 static int
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 7a4e43a8acfa..acc74eba473f 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -380,6 +380,36 @@ textify_hooks(char *buf, size_t size, unsigned int mas=
k, uint8_t nfproto)
 	return buf;
 }
=20
+/**
+ * xt_check_proc_name - check that name is suitable for /proc file creation
+ *
+ * @name: file name candidate
+ * @size: length of buffer
+ *
+ * some x_tables modules wish to create a file in /proc.
+ * This function makes sure that the name is suitable for this
+ * purpose, it checks that name is NUL terminated and isn't a 'special'
+ * name, like "..".
+ *
+ * returns negative number on error or 0 if name is useable.
+ */
+int xt_check_proc_name(const char *name, unsigned int size)
+{
+	if (name[0] =3D=3D '\0')
+		return -EINVAL;
+
+	if (strnlen(name, size) =3D=3D size)
+		return -ENAMETOOLONG;
+
+	if (strcmp(name, ".") =3D=3D 0 ||
+	    strcmp(name, "..") =3D=3D 0 ||
+	    strchr(name, '/'))
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(xt_check_proc_name);
+
 int xt_check_match(struct xt_mtchk_param *par,
 		   unsigned int size, u_int8_t proto, bool inv_proto)
 {
diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
index 95b6dedc5ac7..5761e8e5a2f8 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -116,6 +116,22 @@ static void idletimer_tg_expired(unsigned long data)
 	schedule_work(&timer->work);
 }
=20
+static int idletimer_check_sysfs_name(const char *name, unsigned int size)
+{
+	int ret;
+
+	ret =3D xt_check_proc_name(name, size);
+	if (ret < 0)
+		return ret;
+
+	if (!strcmp(name, "power") ||
+	    !strcmp(name, "subsystem") ||
+	    !strcmp(name, "uevent"))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int idletimer_tg_create(struct idletimer_tg_info *info)
 {
 	int ret;
@@ -126,6 +142,10 @@ static int idletimer_tg_create(struct idletimer_tg_inf=
o *info)
 		goto out;
 	}
=20
+	ret =3D idletimer_check_sysfs_name(info->label, sizeof(info->label));
+	if (ret < 0)
+		goto out_free_timer;
+
 	info->timer->attr.attr.name =3D kstrdup(info->label, GFP_KERNEL);
 	if (!info->timer->attr.attr.name) {
 		ret =3D -ENOMEM;
diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
index 47dc6836830a..597d722fb645 100644
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -668,8 +668,9 @@ static int hashlimit_mt_check(const struct xt_mtchk_par=
am *par)
=20
 	if (info->cfg.gc_interval =3D=3D 0 || info->cfg.expire =3D=3D 0)
 		return -EINVAL;
-	if (info->name[sizeof(info->name)-1] !=3D '\0')
-		return -EINVAL;
+	ret =3D xt_check_proc_name(info->name, sizeof(info->name));
+	if (ret)
+		return ret;
 	if (par->family =3D=3D NFPROTO_IPV4) {
 		if (info->cfg.srcmask > 32 || info->cfg.dstmask > 32)
 			return -EINVAL;
diff --git a/net/netfilter/xt_recent.c b/net/netfilter/xt_recent.c
index a9faae89f955..e0228d23ceae 100644
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -355,9 +355,9 @@ static int recent_mt_check(const struct xt_mtchk_param =
*par,
 			info->hit_count, ip_pkt_list_tot);
 		return -EINVAL;
 	}
-	if (info->name[0] =3D=3D '\0' ||
-	    strnlen(info->name, XT_RECENT_NAME_LEN) =3D=3D XT_RECENT_NAME_LEN)
-		return -EINVAL;
+	ret =3D xt_check_proc_name(info->name, sizeof(info->name));
+	if (ret)
+		return ret;
=20
 	mutex_lock(&recent_mutex);
 	t =3D recent_table_lookup(recent_net, info->name);
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 8473d34f2e3a..892b26196c60 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -948,10 +948,12 @@ int netlbl_skbuff_getattr(const struct sk_buff *skb,
 			  u16 family,
 			  struct netlbl_lsm_secattr *secattr)
 {
+	unsigned char *ptr;
+
 	switch (family) {
 	case AF_INET:
-		if (CIPSO_V4_OPTEXIST(skb) &&
-		    cipso_v4_skbuff_getattr(skb, secattr) =3D=3D 0)
+		ptr =3D cipso_v4_optptr(skb);
+		if (ptr && cipso_v4_getattr(ptr, secattr) =3D=3D 0)
 			return 0;
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -977,7 +979,7 @@ int netlbl_skbuff_getattr(const struct sk_buff *skb,
  */
 void netlbl_skbuff_err(struct sk_buff *skb, int error, int gateway)
 {
-	if (CIPSO_V4_OPTEXIST(skb))
+	if (cipso_v4_optptr(skb))
 		cipso_v4_error(skb, error, gateway);
 }
=20
@@ -1009,11 +1011,14 @@ void netlbl_cache_invalidate(void)
 int netlbl_cache_add(const struct sk_buff *skb,
 		     const struct netlbl_lsm_secattr *secattr)
 {
+	unsigned char *ptr;
+
 	if ((secattr->flags & NETLBL_SECATTR_CACHE) =3D=3D 0)
 		return -ENOMSG;
=20
-	if (CIPSO_V4_OPTEXIST(skb))
-		return cipso_v4_cache_add(skb, secattr);
+	ptr =3D cipso_v4_optptr(skb);
+	if (ptr)
+		return cipso_v4_cache_add(ptr, secattr);
=20
 	return -ENOMSG;
 }
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index bf5882a4737f..62d69641f6e5 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -437,7 +437,7 @@ static int gred_change(struct Qdisc *sch, struct nlattr=
 *opt)
 		return err;
=20
 	if (tb[TCA_GRED_PARMS] =3D=3D NULL && tb[TCA_GRED_STAB] =3D=3D NULL)
-		return gred_change_table_def(sch, opt);
+		return gred_change_table_def(sch, tb[TCA_GRED_DPS]);
=20
 	if (tb[TCA_GRED_PARMS] =3D=3D NULL ||
 	    tb[TCA_GRED_STAB] =3D=3D NULL)
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 265be00a4ac5..4ba1fd4527fa 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1641,6 +1641,7 @@ priv_release_snd_buf(struct rpc_rqst *rqstp)
 	for (i=3D0; i < rqstp->rq_enc_pages_num; i++)
 		__free_page(rqstp->rq_enc_pages[i]);
 	kfree(rqstp->rq_enc_pages);
+	rqstp->rq_release_snd_buf =3D NULL;
 }
=20
 static int
@@ -1649,6 +1650,9 @@ alloc_enc_pages(struct rpc_rqst *rqstp)
 	struct xdr_buf *snd_buf =3D &rqstp->rq_snd_buf;
 	int first, last, i;
=20
+	if (rqstp->rq_release_snd_buf)
+		rqstp->rq_release_snd_buf(rqstp);
+
 	if (snd_buf->page_len =3D=3D 0) {
 		rqstp->rq_enc_pages_num =3D 0;
 		return 0;
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index b4737fbdec13..de5e3636d5ad 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -906,7 +906,7 @@ static void call_xpt_users(struct svc_xprt *xprt)
 	spin_lock(&xprt->xpt_lock);
 	while (!list_empty(&xprt->xpt_users)) {
 		u =3D list_first_entry(&xprt->xpt_users, struct svc_xpt_user, list);
-		list_del(&u->list);
+		list_del_init(&u->list);
 		u->callback(u);
 	}
 	spin_unlock(&xprt->xpt_lock);
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 25ef792dfee6..6809eca6fce3 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -511,7 +511,7 @@ EXPORT_SYMBOL_GPL(xdr_commit_encode);
=20
 __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr, size_t nbytes)
 {
-	static __be32 *p;
+	__be32 *p;
 	int space_left;
 	int frag1bytes, frag2bytes;
=20
@@ -637,11 +637,10 @@ void xdr_truncate_encode(struct xdr_stream *xdr, size=
_t len)
 		/* xdr->iov should already be NULL */
 		return;
 	}
-	if (fraglen) {
+	if (fraglen)
 		xdr->end =3D head->iov_base + head->iov_len;
-		xdr->page_ptr--;
-	}
 	/* (otherwise assume xdr->end is already set) */
+	xdr->page_ptr--;
 	head->iov_len =3D len;
 	buf->len =3D len;
 	xdr->p =3D head->iov_base + head->iov_len;
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 51c63165073c..7d030e4032bf 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -721,8 +721,15 @@ void xprt_connect(struct rpc_task *task)
 			return;
 		if (xprt_test_and_set_connecting(xprt))
 			return;
-		xprt->stat.connect_start =3D jiffies;
-		xprt->ops->connect(xprt, task);
+		/* Race breaker */
+		if (!xprt_connected(xprt)) {
+			xprt->stat.connect_start =3D jiffies;
+			xprt->ops->connect(xprt, task);
+		} else {
+			xprt_clear_connecting(xprt);
+			task->tk_status =3D 0;
+			rpc_wake_up_queued_task(&xprt->pending, task);
+		}
 	}
 }
=20
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index fcee044f2ee8..28a8e0b924db 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -274,6 +274,31 @@ vmci_transport_send_control_pkt_bh(struct sockaddr_vm =
*src,
 						 false);
 }
=20
+static int
+vmci_transport_alloc_send_control_pkt(struct sockaddr_vm *src,
+				      struct sockaddr_vm *dst,
+				      enum vmci_transport_packet_type type,
+				      u64 size,
+				      u64 mode,
+				      struct vmci_transport_waiting_info *wait,
+				      u16 proto,
+				      struct vmci_handle handle)
+{
+	struct vmci_transport_packet *pkt;
+	int err;
+
+	pkt =3D kmalloc(sizeof(*pkt), GFP_KERNEL);
+	if (!pkt)
+		return -ENOMEM;
+
+	err =3D __vmci_transport_send_control_pkt(pkt, src, dst, type, size,
+						mode, wait, proto, handle,
+						true);
+	kfree(pkt);
+
+	return err;
+}
+
 static int
 vmci_transport_send_control_pkt(struct sock *sk,
 				enum vmci_transport_packet_type type,
@@ -283,9 +308,7 @@ vmci_transport_send_control_pkt(struct sock *sk,
 				u16 proto,
 				struct vmci_handle handle)
 {
-	struct vmci_transport_packet *pkt;
 	struct vsock_sock *vsk;
-	int err;
=20
 	vsk =3D vsock_sk(sk);
=20
@@ -295,17 +318,10 @@ vmci_transport_send_control_pkt(struct sock *sk,
 	if (!vsock_addr_bound(&vsk->remote_addr))
 		return -EINVAL;
=20
-	pkt =3D kmalloc(sizeof(*pkt), GFP_KERNEL);
-	if (!pkt)
-		return -ENOMEM;
-
-	err =3D __vmci_transport_send_control_pkt(pkt, &vsk->local_addr,
-						&vsk->remote_addr, type, size,
-						mode, wait, proto, handle,
-						true);
-	kfree(pkt);
-
-	return err;
+	return vmci_transport_alloc_send_control_pkt(&vsk->local_addr,
+						     &vsk->remote_addr,
+						     type, size, mode,
+						     wait, proto, handle);
 }
=20
 static int vmci_transport_send_reset_bh(struct sockaddr_vm *dst,
@@ -323,12 +339,29 @@ static int vmci_transport_send_reset_bh(struct sockad=
dr_vm *dst,
 static int vmci_transport_send_reset(struct sock *sk,
 				     struct vmci_transport_packet *pkt)
 {
+	struct sockaddr_vm *dst_ptr;
+	struct sockaddr_vm dst;
+	struct vsock_sock *vsk;
+
 	if (pkt->type =3D=3D VMCI_TRANSPORT_PACKET_TYPE_RST)
 		return 0;
-	return vmci_transport_send_control_pkt(sk,
-					VMCI_TRANSPORT_PACKET_TYPE_RST,
-					0, 0, NULL, VSOCK_PROTO_INVALID,
-					VMCI_INVALID_HANDLE);
+
+	vsk =3D vsock_sk(sk);
+
+	if (!vsock_addr_bound(&vsk->local_addr))
+		return -EINVAL;
+
+	if (vsock_addr_bound(&vsk->remote_addr)) {
+		dst_ptr =3D &vsk->remote_addr;
+	} else {
+		vsock_addr_init(&dst, pkt->dg.src.context,
+				pkt->src_port);
+		dst_ptr =3D &dst;
+	}
+	return vmci_transport_alloc_send_control_pkt(&vsk->local_addr, dst_ptr,
+					     VMCI_TRANSPORT_PACKET_TYPE_RST,
+					     0, 0, NULL, VSOCK_PROTO_INVALID,
+					     VMCI_INVALID_HANDLE);
 }
=20
 static int vmci_transport_send_negotiate(struct sock *sk, size_t size)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1f9558155e1e..346e741dd3b2 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -631,7 +631,7 @@ void xfrm_sad_getinfo(struct net *net, struct xfrmk_sad=
info *si)
 {
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
 	si->sadcnt =3D net->xfrm.state_num;
-	si->sadhcnt =3D net->xfrm.state_hmask;
+	si->sadhcnt =3D net->xfrm.state_hmask + 1;
 	si->sadhmcnt =3D xfrm_state_hashmax;
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 }
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_f=
s.c
index d30afe461070..cc5b47ae7519 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -26,14 +26,14 @@
 #include "ima.h"
=20
 static int valid_policy =3D 1;
-#define TMPBUFLEN 12
+
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
 				     loff_t *ppos, atomic_long_t *val)
 {
-	char tmpbuf[TMPBUFLEN];
+	char tmpbuf[32];	/* greater than largest 'long' string value */
 	ssize_t len;
=20
-	len =3D scnprintf(tmpbuf, TMPBUFLEN, "%li\n", atomic_long_read(val));
+	len =3D scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", atomic_long_read(val));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
 }
=20
diff --git a/sound/core/control.c b/sound/core/control.c
index fdffe37d40b8..e5d673e13d3a 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -318,6 +318,40 @@ static int snd_ctl_find_hole(struct snd_card *card, un=
signed int count)
 	return 0;
 }
=20
+/* add a new kcontrol object; call with card->controls_rwsem locked */
+static int __snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcont=
rol)
+{
+	struct snd_ctl_elem_id id;
+	unsigned int idx;
+	unsigned int count;
+
+	id =3D kcontrol->id;
+	if (id.index > UINT_MAX - kcontrol->count)
+		return -EINVAL;
+
+	if (snd_ctl_find_id(card, &id)) {
+		dev_err(card->dev,
+			"control %i:%i:%i:%s:%i is already present\n",
+			id.iface, id.device, id.subdevice, id.name, id.index);
+		return -EBUSY;
+	}
+
+	if (snd_ctl_find_hole(card, kcontrol->count) < 0)
+		return -ENOMEM;
+
+	list_add_tail(&kcontrol->list, &card->controls);
+	card->controls_count +=3D kcontrol->count;
+	kcontrol->id.numid =3D card->last_numid + 1;
+	card->last_numid +=3D kcontrol->count;
+
+	id =3D kcontrol->id;
+	count =3D kcontrol->count;
+	for (idx =3D 0; idx < count; idx++, id.index++, id.numid++)
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_ADD, &id);
+
+	return 0;
+}
+
 /**
  * snd_ctl_add - add the control instance to the card
  * @card: the card instance
@@ -334,44 +368,18 @@ static int snd_ctl_find_hole(struct snd_card *card, u=
nsigned int count)
  */
 int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 {
-	struct snd_ctl_elem_id id;
-	unsigned int idx;
-	unsigned int count;
 	int err =3D -EINVAL;
=20
 	if (! kcontrol)
 		return err;
 	if (snd_BUG_ON(!card || !kcontrol->info))
 		goto error;
-	id =3D kcontrol->id;
-	if (id.index > UINT_MAX - kcontrol->count)
-		goto error;
=20
 	down_write(&card->controls_rwsem);
-	if (snd_ctl_find_id(card, &id)) {
-		up_write(&card->controls_rwsem);
-		dev_err(card->dev, "control %i:%i:%i:%s:%i is already present\n",
-					id.iface,
-					id.device,
-					id.subdevice,
-					id.name,
-					id.index);
-		err =3D -EBUSY;
-		goto error;
-	}
-	if (snd_ctl_find_hole(card, kcontrol->count) < 0) {
-		up_write(&card->controls_rwsem);
-		err =3D -ENOMEM;
-		goto error;
-	}
-	list_add_tail(&kcontrol->list, &card->controls);
-	card->controls_count +=3D kcontrol->count;
-	kcontrol->id.numid =3D card->last_numid + 1;
-	card->last_numid +=3D kcontrol->count;
-	count =3D kcontrol->count;
+	err =3D __snd_ctl_add(card, kcontrol);
 	up_write(&card->controls_rwsem);
-	for (idx =3D 0; idx < count; idx++, id.index++, id.numid++)
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_ADD, &id);
+	if (err < 0)
+		goto error;
 	return 0;
=20
  error:
@@ -1260,14 +1268,17 @@ static int snd_ctl_elem_add(struct snd_ctl_file *fi=
le,
 	_kctl->private_data =3D ue;
 	for (idx =3D 0; idx < _kctl->count; idx++)
 		_kctl->vd[idx].owner =3D file;
-	err =3D snd_ctl_add(card, _kctl);
-	if (err < 0)
-		return err;
-
 	down_write(&card->controls_rwsem);
+	err =3D __snd_ctl_add(card, _kctl);
+	if (err < 0) {
+		snd_ctl_free_one(_kctl);
+		goto unlock;
+	}
+
 	card->user_ctl_count++;
-	up_write(&card->controls_rwsem);
=20
+ unlock:
+	up_write(&card->controls_rwsem);
 	return 0;
 }
=20
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index c89154b318cf..41bae2baea71 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1075,7 +1075,7 @@ static int snd_pcm_oss_change_params_locked(struct sn=
d_pcm_substream *substream)
 	runtime->oss.rate =3D params_rate(params);
=20
 	vfree(runtime->oss.buffer);
-	runtime->oss.buffer =3D vmalloc(runtime->oss.period_bytes);
+	runtime->oss.buffer =3D vzalloc(runtime->oss.period_bytes);
 	if (!runtime->oss.buffer) {
 		err =3D -ENOMEM;
 		goto failure;
diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index a84a1d3d23e5..ef1f8b11ba60 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -67,7 +67,7 @@ static int snd_pcm_plugin_alloc(struct snd_pcm_plugin *pl=
ugin, snd_pcm_uframes_t
 	size /=3D 8;
 	if (plugin->buf_frames < frames) {
 		vfree(plugin->buf);
-		plugin->buf =3D vmalloc(size);
+		plugin->buf =3D vzalloc(size);
 		plugin->buf_frames =3D frames;
 	}
 	if (!plugin->buf) {
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index d38c60671969..7c407ab2d82a 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2025,7 +2025,8 @@ int snd_pcm_hw_constraints_complete(struct snd_pcm_su=
bstream *substream)
=20
 static void pcm_release_private(struct snd_pcm_substream *substream)
 {
-	snd_pcm_unlink(substream);
+	if (snd_pcm_stream_linked(substream))
+		snd_pcm_unlink(substream);
 }
=20
 void snd_pcm_release_substream(struct snd_pcm_substream *substream)
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 360b08b03e1d..1e9748a89664 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1531,7 +1531,6 @@ static int snd_wss_playback_open(struct snd_pcm_subst=
ream *substream)
 	if (err < 0) {
 		if (chip->release_dma)
 			chip->release_dma(chip, chip->dma_private_data, chip->dma1);
-		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
 		return err;
 	}
 	chip->playback_substream =3D substream;
@@ -1572,7 +1571,6 @@ static int snd_wss_capture_open(struct snd_pcm_substr=
eam *substream)
 	if (err < 0) {
 		if (chip->release_dma)
 			chip->release_dma(chip, chip->dma_private_data, chip->dma2);
-		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
 		return err;
 	}
 	chip->capture_substream =3D substream;
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 14ad54b7928c..416c46bf2a12 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -829,7 +829,7 @@ static int snd_ac97_put_spsa(struct snd_kcontrol *kcont=
rol, struct snd_ctl_elem_
 {
 	struct snd_ac97 *ac97 =3D snd_kcontrol_chip(kcontrol);
 	int reg =3D kcontrol->private_value & 0xff;
-	int shift =3D (kcontrol->private_value >> 8) & 0xff;
+	int shift =3D (kcontrol->private_value >> 8) & 0x0f;
 	int mask =3D (kcontrol->private_value >> 16) & 0xff;
 	// int invert =3D (kcontrol->private_value >> 24) & 0xff;
 	unsigned short value, old, new;
diff --git a/sound/pci/ca0106/ca0106.h b/sound/pci/ca0106/ca0106.h
index 04402c14cb23..9847b669cf3c 100644
--- a/sound/pci/ca0106/ca0106.h
+++ b/sound/pci/ca0106/ca0106.h
@@ -582,7 +582,7 @@
 #define SPI_PL_BIT_R_R		(2<<7)	/* right channel =3D right */
 #define SPI_PL_BIT_R_C		(3<<7)	/* right channel =3D (L+R)/2 */
 #define SPI_IZD_REG		2
-#define SPI_IZD_BIT		(1<<4)	/* infinite zero detect */
+#define SPI_IZD_BIT		(0<<4)	/* infinite zero detect */
=20
 #define SPI_FMT_REG		3
 #define SPI_FMT_BIT_RJ		(0<<0)	/* right justified mode */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 93cfc305f04e..ab5b15cede80 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1914,6 +1914,10 @@ static const struct pci_device_id azx_ids[] =3D {
 	/* AMD Hudson */
 	{ PCI_DEVICE(0x1022, 0x780d),
 	  .driver_data =3D AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
+	/* AMD Stoney */
+	{ PCI_DEVICE(0x1022, 0x157a),
+	  .driver_data =3D AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB |
+			 AZX_DCAPS_PM_RUNTIME },
 	/* AMD Raven */
 	{ PCI_DEVICE(0x1022, 0x15e3),
 	  .driver_data =3D AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 67398f350eea..b66c787d66b6 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3465,6 +3465,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] =
=3D {
 	SND_PCI_QUIRK(0x17aa, 0x21da, "Lenovo X220", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21db, "Lenovo X220-tablet", CXT_PINCFG_LENOVO_TP4=
10),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo IdeaPad Z560", CXT_FIXUP_MUTE_LED_E=
APD),
+	SND_PCI_QUIRK(0x17aa, 0x3905, "Lenovo G50-30", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x390b, "Lenovo G50-80", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "Lenovo IdeaPad U310", CXT_FIXUP_STEREO_DMI=
C),
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 4e91bcaa3664..a3e759157b26 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -1146,10 +1146,8 @@ static int snd_cs4231_playback_open(struct snd_pcm_s=
ubstream *substream)
 	runtime->hw =3D snd_cs4231_playback;
=20
 	err =3D snd_cs4231_open(chip, CS4231_MODE_PLAY);
-	if (err < 0) {
-		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
+	if (err < 0)
 		return err;
-	}
 	chip->playback_substream =3D substream;
 	chip->p_periods_sent =3D 0;
 	snd_pcm_set_sync(substream);
@@ -1167,10 +1165,8 @@ static int snd_cs4231_capture_open(struct snd_pcm_su=
bstream *substream)
 	runtime->hw =3D snd_cs4231_capture;
=20
 	err =3D snd_cs4231_open(chip, CS4231_MODE_RECORD);
-	if (err < 0) {
-		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
+	if (err < 0)
 		return err;
-	}
 	chip->capture_substream =3D substream;
 	chip->c_periods_sent =3D 0;
 	snd_pcm_set_sync(substream);
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 32ed66722c54..7b56673170c0 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -396,13 +396,15 @@ static int snd_usb_audio_create(struct usb_interface =
*intf,
 	}
=20
 	mutex_init(&chip->mutex);
-	init_rwsem(&chip->shutdown_rwsem);
+	init_waitqueue_head(&chip->shutdown_wait);
 	chip->index =3D idx;
 	chip->dev =3D dev;
 	chip->card =3D card;
 	chip->setup =3D device_setup[idx];
 	chip->autoclock =3D autoclock;
-	chip->probing =3D 1;
+	atomic_set(&chip->active, 1); /* avoid autopm during probing */
+	atomic_set(&chip->usage_count, 0);
+	atomic_set(&chip->shutdown, 0);
=20
 	chip->usb_id =3D USB_ID(le16_to_cpu(dev->descriptor.idVendor),
 			      le16_to_cpu(dev->descriptor.idProduct));
@@ -525,12 +527,12 @@ snd_usb_audio_probe(struct usb_device *dev,
 	mutex_lock(&register_mutex);
 	for (i =3D 0; i < SNDRV_CARDS; i++) {
 		if (usb_chip[i] && usb_chip[i]->dev =3D=3D dev) {
-			if (usb_chip[i]->shutdown) {
+			if (atomic_read(&usb_chip[i]->shutdown)) {
 				dev_err(&dev->dev, "USB device is in the shutdown state, cannot create=
 a card instance\n");
 				goto __error;
 			}
 			chip =3D usb_chip[i];
-			chip->probing =3D 1;
+			atomic_inc(&chip->active); /* avoid autopm */
 			break;
 		}
 	}
@@ -586,15 +588,18 @@ snd_usb_audio_probe(struct usb_device *dev,
=20
 	usb_chip[chip->index] =3D chip;
 	chip->num_interfaces++;
-	chip->probing =3D 0;
+	atomic_dec(&chip->active);
 	mutex_unlock(&register_mutex);
 	return chip;
=20
  __error:
 	if (chip) {
+		/* chip->active is inside the chip->card object,
+		 * decrement before memory is possibly returned.
+		 */
+		atomic_dec(&chip->active);
 		if (!chip->num_interfaces)
 			snd_card_free(chip->card);
-		chip->probing =3D 0;
 	}
 	mutex_unlock(&register_mutex);
  __err_val:
@@ -610,21 +615,21 @@ static void snd_usb_audio_disconnect(struct usb_devic=
e *dev,
 {
 	struct snd_card *card;
 	struct list_head *p;
-	bool was_shutdown;
=20
 	if (chip =3D=3D (void *)-1L)
 		return;
=20
 	card =3D chip->card;
-	down_write(&chip->shutdown_rwsem);
-	was_shutdown =3D chip->shutdown;
-	chip->shutdown =3D 1;
-	up_write(&chip->shutdown_rwsem);
=20
 	mutex_lock(&register_mutex);
-	if (!was_shutdown) {
+	if (atomic_inc_return(&chip->shutdown) =3D=3D 1) {
 		struct snd_usb_endpoint *ep;
=20
+		/* wait until all pending tasks done;
+		 * they are protected by snd_usb_lock_shutdown()
+		 */
+		wait_event(chip->shutdown_wait,
+			   !atomic_read(&chip->usage_count));
 		snd_card_disconnect(card);
 		/* release the pcm resources */
 		list_for_each(p, &chip->pcm_list) {
@@ -675,28 +680,50 @@ static void usb_audio_disconnect(struct usb_interface=
 *intf)
 				 usb_get_intfdata(intf));
 }
=20
-#ifdef CONFIG_PM
-
-int snd_usb_autoresume(struct snd_usb_audio *chip)
+/* lock the shutdown (disconnect) task and autoresume */
+int snd_usb_lock_shutdown(struct snd_usb_audio *chip)
 {
-	int err =3D -ENODEV;
+	int err;
=20
-	down_read(&chip->shutdown_rwsem);
-	if (chip->probing || chip->in_pm)
-		err =3D 0;
-	else if (!chip->shutdown)
-		err =3D usb_autopm_get_interface(chip->pm_intf);
-	up_read(&chip->shutdown_rwsem);
+	atomic_inc(&chip->usage_count);
+	if (atomic_read(&chip->shutdown)) {
+		err =3D -EIO;
+		goto error;
+	}
+	err =3D snd_usb_autoresume(chip);
+	if (err < 0)
+		goto error;
+	return 0;
=20
+ error:
+	if (atomic_dec_and_test(&chip->usage_count))
+		wake_up(&chip->shutdown_wait);
 	return err;
 }
=20
+/* autosuspend and unlock the shutdown */
+void snd_usb_unlock_shutdown(struct snd_usb_audio *chip)
+{
+	snd_usb_autosuspend(chip);
+	if (atomic_dec_and_test(&chip->usage_count))
+		wake_up(&chip->shutdown_wait);
+}
+
+#ifdef CONFIG_PM
+
+int snd_usb_autoresume(struct snd_usb_audio *chip)
+{
+	if (atomic_read(&chip->shutdown))
+		return -EIO;
+	if (atomic_inc_return(&chip->active) =3D=3D 1)
+		return usb_autopm_get_interface(chip->pm_intf);
+	return 0;
+}
+
 void snd_usb_autosuspend(struct snd_usb_audio *chip)
 {
-	down_read(&chip->shutdown_rwsem);
-	if (!chip->shutdown && !chip->probing && !chip->in_pm)
+	if (atomic_dec_and_test(&chip->active))
 		usb_autopm_put_interface(chip->pm_intf);
-	up_read(&chip->shutdown_rwsem);
 }
=20
 static int usb_audio_suspend(struct usb_interface *intf, pm_message_t mess=
age)
@@ -744,7 +771,7 @@ static int __usb_audio_resume(struct usb_interface *int=
f, bool reset_resume)
 	if (--chip->num_suspended_intf)
 		return 0;
=20
-	chip->in_pm =3D 1;
+	atomic_inc(&chip->active); /* avoid autopm */
 	/*
 	 * ALSA leaves material resumption to user space
 	 * we just notify and restart the mixers
@@ -760,7 +787,7 @@ static int __usb_audio_resume(struct usb_interface *int=
f, bool reset_resume)
 	chip->autosuspended =3D 0;
=20
 err_out:
-	chip->in_pm =3D 0;
+	atomic_dec(&chip->active); /* allow autopm after this point */
 	return err;
 }
=20
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index e87436826b3b..0f95338aa81d 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -353,8 +353,10 @@ static void snd_complete_urb(struct urb *urb)
 	if (unlikely(urb->status =3D=3D -ENOENT ||		/* unlinked */
 		     urb->status =3D=3D -ENODEV ||		/* device removed */
 		     urb->status =3D=3D -ECONNRESET ||	/* unlinked */
-		     urb->status =3D=3D -ESHUTDOWN ||	/* device disabled */
-		     ep->chip->shutdown))		/* device disconnected */
+		     urb->status =3D=3D -ESHUTDOWN))	/* device disabled */
+		goto exit_clear;
+	/* device disconnected */
+	if (unlikely(atomic_read(&ep->chip->shutdown)))
 		goto exit_clear;
=20
 	if (usb_pipeout(ep->pipe)) {
@@ -529,7 +531,7 @@ static int deactivate_urbs(struct snd_usb_endpoint *ep,=
 bool force)
 {
 	unsigned int i;
=20
-	if (!force && ep->chip->shutdown) /* to be sure... */
+	if (!force && atomic_read(&ep->chip->shutdown)) /* to be sure... */
 		return -EBADFD;
=20
 	clear_bit(EP_FLAG_RUNNING, &ep->flags);
@@ -868,7 +870,7 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep,=
 bool can_sleep)
 	int err;
 	unsigned int i;
=20
-	if (ep->chip->shutdown)
+	if (atomic_read(&ep->chip->shutdown))
 		return -EBADFD;
=20
 	/* already running? */
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 9bce76497c48..caf392f2aea0 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -296,14 +296,11 @@ static int get_ctl_value_v1(struct usb_mixer_elem_inf=
o *cval, int request,
 	int timeout =3D 10;
 	int idx =3D 0, err;
=20
-	err =3D snd_usb_autoresume(cval->mixer->chip);
+	err =3D snd_usb_lock_shutdown(chip);
 	if (err < 0)
 		return -EIO;
=20
-	down_read(&chip->shutdown_rwsem);
 	while (timeout-- > 0) {
-		if (chip->shutdown)
-			break;
 		idx =3D snd_usb_ctrl_intf(chip) | (cval->id << 8);
 		if (snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), request,
 				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
@@ -319,8 +316,7 @@ static int get_ctl_value_v1(struct usb_mixer_elem_info =
*cval, int request,
 	err =3D -EINVAL;
=20
  out:
-	up_read(&chip->shutdown_rwsem);
-	snd_usb_autosuspend(cval->mixer->chip);
+	snd_usb_unlock_shutdown(chip);
 	return err;
 }
=20
@@ -343,21 +339,15 @@ static int get_ctl_value_v2(struct usb_mixer_elem_inf=
o *cval, int request,
=20
 	memset(buf, 0, sizeof(buf));
=20
-	ret =3D snd_usb_autoresume(chip) ? -EIO : 0;
+	ret =3D snd_usb_lock_shutdown(chip) ? -EIO : 0;
 	if (ret)
 		goto error;
=20
-	down_read(&chip->shutdown_rwsem);
-	if (chip->shutdown) {
-		ret =3D -ENODEV;
-	} else {
-		idx =3D snd_usb_ctrl_intf(chip) | (cval->id << 8);
-		ret =3D snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), bReque=
st,
+	idx =3D snd_usb_ctrl_intf(chip) | (cval->id << 8);
+	ret =3D snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), bReques=
t,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			      validx, idx, buf, size);
-	}
-	up_read(&chip->shutdown_rwsem);
-	snd_usb_autosuspend(chip);
+	snd_usb_unlock_shutdown(chip);
=20
 	if (ret < 0) {
 error:
@@ -469,13 +459,12 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem=
_info *cval,
 	value_set =3D convert_bytes_value(cval, value_set);
 	buf[0] =3D value_set & 0xff;
 	buf[1] =3D (value_set >> 8) & 0xff;
-	err =3D snd_usb_autoresume(chip);
+
+	err =3D snd_usb_lock_shutdown(chip);
 	if (err < 0)
 		return -EIO;
-	down_read(&chip->shutdown_rwsem);
+
 	while (timeout-- > 0) {
-		if (chip->shutdown)
-			break;
 		idx =3D snd_usb_ctrl_intf(chip) | (cval->id << 8);
 		if (snd_usb_ctl_msg(chip->dev,
 				    usb_sndctrlpipe(chip->dev, 0), request,
@@ -490,8 +479,7 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_i=
nfo *cval,
 	err =3D -EINVAL;
=20
  out:
-	up_read(&chip->shutdown_rwsem);
-	snd_usb_autosuspend(chip);
+	snd_usb_unlock_shutdown(chip);
 	return err;
 }
=20
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 89d32f066561..f1de40dc7091 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -302,11 +302,10 @@ static int snd_audigy2nx_led_put(struct snd_kcontrol =
*kcontrol, struct snd_ctl_e
 	if (value > 1)
 		return -EINVAL;
 	changed =3D value !=3D mixer->audigy2nx_leds[index];
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown) {
-		err =3D -ENODEV;
-		goto out;
-	}
+	err =3D snd_usb_lock_shutdown(mixer->chip);
+	if (err < 0)
+		return err;
+
 	if (mixer->chip->usb_id =3D=3D USB_ID(0x041e, 0x3042))
 		err =3D snd_usb_ctl_msg(mixer->chip->dev,
 			      usb_sndctrlpipe(mixer->chip->dev, 0), 0x24,
@@ -323,8 +322,7 @@ static int snd_audigy2nx_led_put(struct snd_kcontrol *k=
control, struct snd_ctl_e
 			      usb_sndctrlpipe(mixer->chip->dev, 0), 0x24,
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 			      value, index + 2, NULL, 0);
- out:
-	up_read(&mixer->chip->shutdown_rwsem);
+	snd_usb_unlock_shutdown(mixer->chip);
 	if (err < 0)
 		return err;
 	mixer->audigy2nx_leds[index] =3D value;
@@ -418,16 +416,15 @@ static void snd_audigy2nx_proc_read(struct snd_info_e=
ntry *entry,
=20
 	for (i =3D 0; jacks[i].name; ++i) {
 		snd_iprintf(buffer, "%s: ", jacks[i].name);
-		down_read(&mixer->chip->shutdown_rwsem);
-		if (mixer->chip->shutdown)
-			err =3D 0;
-		else
-			err =3D snd_usb_ctl_msg(mixer->chip->dev,
+		err =3D snd_usb_lock_shutdown(mixer->chip);
+		if (err < 0)
+			return;
+		err =3D snd_usb_ctl_msg(mixer->chip->dev,
 				      usb_rcvctrlpipe(mixer->chip->dev, 0),
 				      UAC_GET_MEM, USB_DIR_IN | USB_TYPE_CLASS |
 				      USB_RECIP_INTERFACE, 0,
 				      jacks[i].unitid << 8, buf, 3);
-		up_read(&mixer->chip->shutdown_rwsem);
+		snd_usb_unlock_shutdown(mixer->chip);
 		if (err =3D=3D 3 && (buf[0] =3D=3D 3 || buf[0] =3D=3D 6))
 			snd_iprintf(buffer, "%02x %02x\n", buf[1], buf[2]);
 		else
@@ -476,17 +473,14 @@ static int snd_emu0204_ch_switch_put(struct snd_kcont=
rol *kcontrol,
 	buf[1] =3D value ? 0x02 : 0x01;
=20
 	changed =3D value !=3D kcontrol->private_value;
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown) {
-		err =3D -ENODEV;
-		goto out;
-	}
+	err =3D snd_usb_lock_shutdown(mixer->chip);
+	if (err < 0)
+		return err;
 	err =3D snd_usb_ctl_msg(mixer->chip->dev,
 		      usb_sndctrlpipe(mixer->chip->dev, 0), UAC_SET_CUR,
 		      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 		      0x0400, 0x0e00, buf, 2);
- out:
-	up_read(&mixer->chip->shutdown_rwsem);
+	snd_usb_unlock_shutdown(mixer->chip);
 	if (err < 0)
 		return err;
 	kcontrol->private_value =3D value;
@@ -542,15 +536,14 @@ static int snd_xonar_u1_switch_put(struct snd_kcontro=
l *kcontrol,
 	else
 		new_status =3D old_status & ~0x02;
 	changed =3D new_status !=3D old_status;
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown)
-		err =3D -ENODEV;
-	else
-		err =3D snd_usb_ctl_msg(mixer->chip->dev,
+	err =3D snd_usb_lock_shutdown(mixer->chip);
+	if (err < 0)
+		return err;
+	err =3D snd_usb_ctl_msg(mixer->chip->dev,
 			      usb_sndctrlpipe(mixer->chip->dev, 0), 0x08,
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 			      50, 0, &new_status, 1);
-	up_read(&mixer->chip->shutdown_rwsem);
+	snd_usb_unlock_shutdown(mixer->chip);
 	if (err < 0)
 		return err;
 	mixer->xonar_u1_status =3D new_status;
@@ -591,15 +584,14 @@ static int snd_nativeinstruments_control_get(struct s=
nd_kcontrol *kcontrol,
 	u8 tmp;
 	int ret;
=20
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown)
-		ret =3D -ENODEV;
-	else
-		ret =3D usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), bRequest,
-				  USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-				  0, wIndex,
-				  &tmp, sizeof(tmp), 1000);
-	up_read(&mixer->chip->shutdown_rwsem);
+	ret =3D snd_usb_lock_shutdown(mixer->chip);
+	if (ret < 0)
+		return ret;
+	ret =3D usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), bRequest,
+			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
+			      0, wIndex,
+			      &tmp, sizeof(tmp), 1000);
+	snd_usb_unlock_shutdown(mixer->chip);
=20
 	if (ret < 0) {
 		dev_err(&dev->dev,
@@ -622,15 +614,14 @@ static int snd_nativeinstruments_control_put(struct s=
nd_kcontrol *kcontrol,
 	u16 wValue =3D ucontrol->value.integer.value[0];
 	int ret;
=20
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown)
-		ret =3D -ENODEV;
-	else
-		ret =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0), bRequest,
-				  USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-				  wValue, wIndex,
-				  NULL, 0, 1000);
-	up_read(&mixer->chip->shutdown_rwsem);
+	ret =3D snd_usb_lock_shutdown(mixer->chip);
+	if (ret < 0)
+		return ret;
+	ret =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0), bRequest,
+			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
+			      wValue, wIndex,
+			      NULL, 0, 1000);
+	snd_usb_unlock_shutdown(mixer->chip);
=20
 	if (ret < 0) {
 		dev_err(&dev->dev,
@@ -792,16 +783,15 @@ static int snd_ftu_eff_switch_get(struct snd_kcontrol=
 *kctl,
 	id =3D pval->bUnitID;
 	validx =3D pval->validx;
=20
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown)
-		err =3D -ENODEV;
-	else
-		err =3D snd_usb_ctl_msg(chip->dev,
+	err =3D snd_usb_lock_shutdown(mixer->chip);
+	if (err < 0)
+		return err;
+	err =3D snd_usb_ctl_msg(chip->dev,
 			usb_rcvctrlpipe(chip->dev, 0), UAC_GET_CUR,
 			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			validx << 8, snd_usb_ctrl_intf(chip) | (id << 8),
 			value, val_len);
-	up_read(&mixer->chip->shutdown_rwsem);
+	snd_usb_unlock_shutdown(mixer->chip);
 	if (err < 0)
 		return err;
=20
@@ -845,16 +835,15 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol=
 *kctl,
=20
 	if (!pval->is_cached) {
 		/* Read current value */
-		down_read(&mixer->chip->shutdown_rwsem);
-		if (mixer->chip->shutdown)
-			err =3D -ENODEV;
-		else
-			err =3D snd_usb_ctl_msg(chip->dev,
+		err =3D snd_usb_lock_shutdown(mixer->chip);
+		if (err < 0)
+			return err;
+		err =3D snd_usb_ctl_msg(chip->dev,
 				usb_rcvctrlpipe(chip->dev, 0), UAC_GET_CUR,
 				USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 				validx << 8, snd_usb_ctrl_intf(chip) | (id << 8),
 				value, val_len);
-		up_read(&mixer->chip->shutdown_rwsem);
+		snd_usb_unlock_shutdown(mixer->chip);
 		if (err < 0)
 			return err;
=20
@@ -866,16 +855,15 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol=
 *kctl,
 	if (cur_val !=3D new_val) {
 		value[0] =3D new_val;
 		value[1] =3D 0;
-		down_read(&mixer->chip->shutdown_rwsem);
-		if (mixer->chip->shutdown)
-			err =3D -ENODEV;
-		else
-			err =3D snd_usb_ctl_msg(chip->dev,
+		err =3D snd_usb_lock_shutdown(chip);
+		if (err < 0)
+			return err;
+		err =3D snd_usb_ctl_msg(chip->dev,
 				usb_sndctrlpipe(chip->dev, 0), UAC_SET_CUR,
 				USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 				validx << 8, snd_usb_ctrl_intf(chip) | (id << 8),
 				value, val_len);
-		up_read(&mixer->chip->shutdown_rwsem);
+		snd_usb_unlock_shutdown(chip);
 		if (err < 0)
 			return err;
=20
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 17e611064334..e4e4a7e3a96c 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -80,7 +80,7 @@ static snd_pcm_uframes_t snd_usb_pcm_pointer(struct snd_p=
cm_substream *substream
 	unsigned int hwptr_done;
=20
 	subs =3D (struct snd_usb_substream *)substream->runtime->private_data;
-	if (subs->stream->chip->shutdown)
+	if (atomic_read(&subs->stream->chip->shutdown))
 		return SNDRV_PCM_POS_XRUN;
 	spin_lock(&subs->lock);
 	hwptr_done =3D subs->hwptr_done;
@@ -713,12 +713,11 @@ static int snd_usb_hw_params(struct snd_pcm_substream=
 *substream,
 		return -EINVAL;
 	}
=20
-	down_read(&subs->stream->chip->shutdown_rwsem);
-	if (subs->stream->chip->shutdown)
-		ret =3D -ENODEV;
-	else
-		ret =3D set_format(subs, fmt);
-	up_read(&subs->stream->chip->shutdown_rwsem);
+	ret =3D snd_usb_lock_shutdown(subs->stream->chip);
+	if (ret < 0)
+		return ret;
+	ret =3D set_format(subs, fmt);
+	snd_usb_unlock_shutdown(subs->stream->chip);
 	if (ret < 0)
 		return ret;
=20
@@ -741,13 +740,12 @@ static int snd_usb_hw_free(struct snd_pcm_substream *=
substream)
 	subs->cur_audiofmt =3D NULL;
 	subs->cur_rate =3D 0;
 	subs->period_bytes =3D 0;
-	down_read(&subs->stream->chip->shutdown_rwsem);
-	if (!subs->stream->chip->shutdown) {
+	if (!snd_usb_lock_shutdown(subs->stream->chip)) {
 		stop_endpoints(subs, true);
 		snd_usb_endpoint_deactivate(subs->sync_endpoint);
 		snd_usb_endpoint_deactivate(subs->data_endpoint);
+		snd_usb_unlock_shutdown(subs->stream->chip);
 	}
-	up_read(&subs->stream->chip->shutdown_rwsem);
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
=20
@@ -769,11 +767,9 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substrea=
m *substream)
 		return -ENXIO;
 	}
=20
-	down_read(&subs->stream->chip->shutdown_rwsem);
-	if (subs->stream->chip->shutdown) {
-		ret =3D -ENODEV;
-		goto unlock;
-	}
+	ret =3D snd_usb_lock_shutdown(subs->stream->chip);
+	if (ret < 0)
+		return ret;
 	if (snd_BUG_ON(!subs->data_endpoint)) {
 		ret =3D -EIO;
 		goto unlock;
@@ -822,7 +818,7 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream=
 *substream)
 		ret =3D start_endpoints(subs, true);
=20
  unlock:
-	up_read(&subs->stream->chip->shutdown_rwsem);
+	snd_usb_unlock_shutdown(subs->stream->chip);
 	return ret;
 }
=20
@@ -1224,9 +1220,11 @@ static int snd_usb_pcm_close(struct snd_pcm_substrea=
m *substream, int direction)
=20
 	stop_endpoints(subs, true);
=20
-	if (!as->chip->shutdown && subs->interface >=3D 0) {
+	if (subs->interface >=3D 0 &&
+	    !snd_usb_lock_shutdown(subs->stream->chip)) {
 		usb_set_interface(subs->dev, subs->interface, 0);
 		subs->interface =3D -1;
+		snd_usb_unlock_shutdown(subs->stream->chip);
 	}
=20
 	subs->pcm_substream =3D NULL;
diff --git a/sound/usb/proc.c b/sound/usb/proc.c
index 5f761ab34c01..0ac89e294d31 100644
--- a/sound/usb/proc.c
+++ b/sound/usb/proc.c
@@ -46,14 +46,14 @@ static inline unsigned get_high_speed_hz(unsigned int u=
sb_rate)
 static void proc_audio_usbbus_read(struct snd_info_entry *entry, struct sn=
d_info_buffer *buffer)
 {
 	struct snd_usb_audio *chip =3D entry->private_data;
-	if (!chip->shutdown)
+	if (!atomic_read(&chip->shutdown))
 		snd_iprintf(buffer, "%03d/%03d\n", chip->dev->bus->busnum, chip->dev->de=
vnum);
 }
=20
 static void proc_audio_usbid_read(struct snd_info_entry *entry, struct snd=
_info_buffer *buffer)
 {
 	struct snd_usb_audio *chip =3D entry->private_data;
-	if (!chip->shutdown)
+	if (!atomic_read(&chip->shutdown))
 		snd_iprintf(buffer, "%04x:%04x\n",=20
 			    USB_ID_VENDOR(chip->usb_id),
 			    USB_ID_PRODUCT(chip->usb_id));
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index d74a9927c3d9..53c171f26b7b 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3281,19 +3281,14 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950=
Q"),
 				.ifnum =3D 0,
 				.type =3D QUIRK_AUDIO_STANDARD_MIXER,
 			},
-			/* Capture */
-			{
-				.ifnum =3D 1,
-				.type =3D QUIRK_IGNORE_INTERFACE,
-			},
 			/* Playback */
 			{
-				.ifnum =3D 2,
+				.ifnum =3D 1,
 				.type =3D QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data =3D &(const struct audioformat) {
 					.formats =3D SNDRV_PCM_FMTBIT_S16_LE,
 					.channels =3D 2,
-					.iface =3D 2,
+					.iface =3D 1,
 					.altsetting =3D 1,
 					.altset_idx =3D 1,
 					.attributes =3D UAC_EP_CS_ATTR_FILL_MAX |
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 991aa84491cd..4b4327b45606 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -37,11 +37,11 @@ struct snd_usb_audio {
 	struct usb_interface *pm_intf;
 	u32 usb_id;
 	struct mutex mutex;
-	struct rw_semaphore shutdown_rwsem;
-	unsigned int shutdown:1;
-	unsigned int probing:1;
-	unsigned int in_pm:1;
 	unsigned int autosuspended:1;=09
+	atomic_t active;
+	atomic_t shutdown;
+	atomic_t usage_count;
+	wait_queue_head_t shutdown_wait;
 	unsigned int txfr_quirk:1; /* Subframe boundaries on transfers */
 =09
 	int num_interfaces;
@@ -116,4 +116,7 @@ struct snd_usb_audio_quirk {
 #define combine_triple(s)  (combine_word(s) | ((unsigned int)(s)[2] << 16))
 #define combine_quad(s)    (combine_triple(s) | ((unsigned int)(s)[3] << 2=
4))
=20
+int snd_usb_lock_shutdown(struct snd_usb_audio *chip);
+void snd_usb_unlock_shutdown(struct snd_usb_audio *chip);
+
 #endif /* __USBAUDIO_H */
diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/benc=
h/parse.c
index 543bba14ae2c..bdbe1da587af 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -135,7 +135,7 @@ struct config *prepare_default_config()
 	config->cpu =3D 0;
 	config->prio =3D SCHED_HIGH;
 	config->verbose =3D 0;
-	strncpy(config->governor, "ondemand", 8);
+	strncpy(config->governor, "ondemand", sizeof(config->governor));
=20
 	config->output =3D stdout;
=20

--wbfb4lsvb6x7vkhu--

--zipnbsui6glc6tn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlxh8wEACgkQ57/I7JWG
EQnXBw/+LaCpuXJT7RLSvvKZ+6O2JYEw06ZnocamTw/ualeeDfYzh/OX3fs2eBl2
7Sf513rDa+3rLqAeSkDWfTS+Hq8Y/aw7D7bNSgKizGmKD5lD4zJboCk9BjTYUPCC
nPqSh+68qBsgh6f7Rx8ZZmHR2qgDFfbo7MP5cynDjLG8zWAT+v/etb57yeAPInVn
CoK4R8Zz+vkxEMie99ZppuPMc6jI1joGxnUAkDG8XLorEsqmOnN0haOklYpAvrhl
4Q1TgLtQWhTZShWvEhdH4bPl2fVpQQlQSYK1z1BXltXkozr5VdFBeplVqzpBtKaA
zTDS9QlftMlrMvIHVv8sp8gkeQFBTOqzicbcAfgLTyukvPFxZoUu7xppthJ/TNop
k5mirIBWpZe2g5hihHjw8/it91MKCHuAe1oL761WM47fQr4vCOEWeRypgQ8xogEe
RxaZ1BusMokmDqbTlwQlXj4JgSg5NKdO1cL6b+HYe+Mt6dpYztSQXvbN0bKGEvuh
yFut+NcbnXivz5grNhS9F2vTgIBGz8L8chlYFj0az+bFXVTdzFpHB0Nwl/KVgs+n
sGcScT2TSDZeaM6Zln9chVz7fzSmmW5VM/jo6qq7Dbibs9iJppCW66Qi14SthCpd
v9sqHmIHfP8+Ny2cyE3/n+E+oLP4tApI4vz6kNeBUJ/lmDSm/Rg=
=K/Hq
-----END PGP SIGNATURE-----

--zipnbsui6glc6tn7--
