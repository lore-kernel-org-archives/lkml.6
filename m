Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E0FC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5E62083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5E62083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeJVQXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:23:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42630 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727523AbeJVQXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:23:35 -0400
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gEVDT-00018r-7t; Mon, 22 Oct 2018 09:05:58 +0100
Date:   Mon, 22 Oct 2018 09:05:35 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>,
        stable@vger.kernel.org
Cc:     lwn@lwn.net
Message-ID: <20181022080534.GB3375@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
X-Mailer: LinuxStableQueue (scripts by bwh)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: Linux 3.16.60
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: multipart/mixed; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.16.60 kernel.

All users of the 3.16 kernel series should upgrade.

The updated 3.16.y git tree can be found at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
=2Egit linux-3.16.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git

The diff from 3.16.59 is attached to this message.

Ben.

------------

 Documentation/networking/ppp_generic.txt         |   6 -
 Makefile                                         |   2 +-
 arch/arc/include/asm/Kbuild                      |   1 +
 arch/arm/boot/compressed/head.S                  |  16 +-
 arch/arm/boot/compressed/misc.c                  |   9 +-
 arch/arm/boot/dts/at91sam9g25.dtsi               |   2 +-
 arch/arm/crypto/Makefile                         |   2 +
 arch/arm/include/asm/assembler.h                 |  10 +
 arch/arm/kernel/traps.c                          |   5 +-
 arch/arm/kvm/arm.c                               |  15 +-
 arch/arm/lib/getuser.S                           |   4 +
 arch/arm/mach-davinci/board-dm646x-evm.c         |   3 +-
 arch/arm/mach-keystone/pm_domain.c               |   1 +
 arch/avr32/include/asm/Kbuild                    |   1 +
 arch/blackfin/include/asm/Kbuild                 |   1 +
 arch/c6x/include/asm/Kbuild                      |   1 +
 arch/cris/include/asm/Kbuild                     |   1 +
 arch/frv/include/asm/Kbuild                      |   1 +
 arch/hexagon/include/asm/Kbuild                  |   1 +
 arch/ia64/include/asm/Kbuild                     |   1 +
 arch/m32r/include/asm/Kbuild                     |   1 +
 arch/metag/include/asm/Kbuild                    |   1 +
 arch/microblaze/include/asm/Kbuild               |   1 +
 arch/mips/include/asm/Kbuild                     |   1 +
 arch/mips/include/asm/uaccess.h                  |  11 +-
 arch/mips/kernel/ptrace.c                        |  24 ++-
 arch/mips/kernel/ptrace32.c                      |   6 +-
 arch/mips/kvm/kvm_mips.c                         |   2 +-
 arch/mips/lib/memset.S                           |  11 +-
 arch/mn10300/include/asm/Kbuild                  |   1 +
 arch/parisc/kernel/drivers.c                     |   4 +
 arch/parisc/kernel/hpmc.S                        |   6 +-
 arch/powerpc/include/asm/barrier.h               |   3 +-
 arch/powerpc/include/asm/opal.h                  |   3 +
 arch/powerpc/include/asm/synch.h                 |   4 -
 arch/powerpc/kernel/cpu_setup_power.S            |   4 +
 arch/powerpc/kernel/eeh_driver.c                 |  61 ++++--
 arch/powerpc/kernel/eeh_pe.c                     |   3 +-
 arch/powerpc/lib/feature-fixups.c                |   2 +-
 arch/powerpc/mm/hugetlbpage.c                    |  17 +-
 arch/powerpc/platforms/powernv/opal-nvram.c      |  21 +-
 arch/s390/hypfs/inode.c                          |   2 +-
 arch/s390/include/asm/Kbuild                     |   1 +
 arch/s390/kernel/ipl.c                           |   1 +
 arch/s390/kernel/perf_cpum_sf.c                  |   4 +
 arch/score/include/asm/Kbuild                    |   1 +
 arch/tile/include/asm/Kbuild                     |   1 +
 arch/um/include/asm/Kbuild                       |   1 +
 arch/um/os-Linux/signal.c                        |   2 +-
 arch/unicore32/include/asm/Kbuild                |   1 +
 arch/x86/boot/compressed/eboot.c                 |   6 +-
 arch/x86/crypto/cast5_avx_glue.c                 |   3 +-
 arch/x86/include/asm/apic.h                      |   4 +-
 arch/x86/include/asm/x2apic.h                    |   2 +-
 arch/x86/kernel/acpi/boot.c                      |  18 +-
 arch/x86/kernel/apic/apic_numachip.c             |   2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c               |   2 +-
 arch/x86/kernel/cpu/perf_event.c                 |   8 +-
 arch/x86/kernel/machine_kexec_32.c               |   6 +-
 arch/x86/kernel/machine_kexec_64.c               |   4 +-
 arch/x86/kernel/smpboot.c                        |   2 +
 arch/x86/kernel/tsc.c                            |   2 +-
 arch/x86/kvm/x86.c                               |   7 +-
 arch/x86/mm/dump_pagetables.c                    |  10 +-
 arch/x86/net/bpf_jit_comp.c                      |   3 +-
 arch/x86/um/stub_segv.c                          |   2 +-
 arch/x86/xen/mmu.c                               |   6 +-
 arch/xtensa/include/asm/Kbuild                   |   1 +
 crypto/af_alg.c                                  |   8 +-
 crypto/ahash.c                                   |   7 +-
 drivers/ata/ahci.c                               |   1 +
 drivers/ata/libata-core.c                        |   8 +
 drivers/atm/zatm.c                               |   3 +
 drivers/base/regmap/regmap.c                     |  22 +-
 drivers/char/virtio_console.c                    | 157 +++++++-------
 drivers/gpu/drm/drm_fops.c                       |   1 +
 drivers/gpu/drm/i915/i915_cmd_parser.c           |  80 ++++---
 drivers/gpu/drm/i915/i915_drv.h                  |   5 +
 drivers/gpu/drm/i915/i915_gem_userptr.c          |   3 +
 drivers/gpu/drm/i915/intel_hdmi.c                |  14 +-
 drivers/gpu/drm/i915/intel_lvds.c                |  11 +-
 drivers/gpu/drm/msm/msm_gem.c                    |  30 ++-
 drivers/gpu/drm/radeon/radeon_device.c           |  15 +-
 drivers/gpu/drm/radeon/si_dpm.c                  |   4 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c        |  10 +-
 drivers/hid/hid-core.c                           |  12 +-
 drivers/hid/hidraw.c                             |   5 +
 drivers/hid/i2c-hid/i2c-hid.c                    |  13 +-
 drivers/hwmon/nct6683.c                          |   4 +-
 drivers/hwmon/nct6775.c                          |  10 +-
 drivers/hwmon/pmbus/adm1275.c                    |   4 +-
 drivers/hwmon/pmbus/max8688.c                    |   2 +-
 drivers/i2c/busses/i2c-pmcmsp.c                  |   4 +-
 drivers/i2c/busses/i2c-viperboard.c              |   2 +-
 drivers/iio/kfifo_buf.c                          |  11 +-
 drivers/infiniband/core/addr.c                   |  16 ++
 drivers/infiniband/core/iwpm_util.c              |   5 +-
 drivers/infiniband/core/ucma.c                   |  43 ++--
 drivers/infiniband/hw/cxgb4/cq.c                 |  11 +-
 drivers/infiniband/hw/cxgb4/device.c             |   8 +
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h           |   6 +-
 drivers/infiniband/hw/cxgb4/qp.c                 |   4 +-
 drivers/infiniband/hw/cxgb4/resource.c           |  26 ++-
 drivers/infiniband/hw/mlx5/qp.c                  |  39 ++--
 drivers/infiniband/ulp/srp/ib_srp.c              |   8 +-
 drivers/input/serio/i8042-x86ia64io.h            |  24 +++
 drivers/media/pci/cx25821/cx25821-core.c         |   7 +-
 drivers/media/platform/s3c-camif/camif-capture.c |   7 +-
 drivers/media/rc/rc-main.c                       |   4 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c    |   4 +-
 drivers/message/fusion/mptsas.c                  |   1 +
 drivers/mmc/host/jz4740_mmc.c                    |   2 +-
 drivers/mtd/chips/cfi_cmdset_0001.c              |  33 ++-
 drivers/mtd/chips/cfi_cmdset_0002.c              |   9 +-
 drivers/mtd/ubi/block.c                          |   2 +-
 drivers/mtd/ubi/build.c                          |  11 +
 drivers/net/bonding/bond_main.c                  |   3 +-
 drivers/net/can/usb/kvaser_usb.c                 |   2 +-
 drivers/net/ethernet/broadcom/bcmsysport.c       |  11 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c   |  11 +-
 drivers/net/ethernet/cisco/enic/enic_main.c      |   8 +-
 drivers/net/ethernet/marvell/sky2.c              |   2 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c  |  16 ++
 drivers/net/ethernet/mellanox/mlx4/main.c        |   4 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h     |   7 +-
 drivers/net/ethernet/mellanox/mlx4/qp.c          |   4 +-
 drivers/net/ethernet/ti/cpsw.c                   |  13 +-
 drivers/net/ethernet/ti/davinci_cpdma.c          |   2 +-
 drivers/net/ethernet/ti/davinci_emac.c           |  62 ++++--
 drivers/net/ppp/ppp_generic.c                    | 136 +++++++-----
 drivers/net/ppp/pppoe.c                          |   4 +
 drivers/net/team/team.c                          |  38 +++-
 drivers/net/usb/qmi_wwan.c                       |  13 ++
 drivers/net/vmxnet3/vmxnet3_drv.c                | 137 ++++++++----
 drivers/net/vmxnet3/vmxnet3_int.h                |   8 +-
 drivers/net/wireless/rtl818x/rtl8187/dev.c       |   2 +-
 drivers/parport/parport_pc.c                     |   4 +
 drivers/pci/hotplug/acpiphp_glue.c               |  23 +-
 drivers/pci/quirks.c                             |  13 ++
 drivers/pinctrl/pinctrl-single.c                 |  22 +-
 drivers/rtc/rtc-snvs.c                           |  15 +-
 drivers/rtc/rtc-tx4939.c                         |   6 +-
 drivers/s390/block/dasd_alias.c                  |  16 +-
 drivers/s390/cio/chsc.c                          |  14 +-
 drivers/s390/cio/qdio_main.c                     |  42 ++--
 drivers/s390/cio/qdio_setup.c                    |  12 +-
 drivers/s390/net/qeth_core_main.c                |   8 +-
 drivers/s390/scsi/zfcp_dbf.c                     |  23 +-
 drivers/s390/scsi/zfcp_ext.h                     |   5 +-
 drivers/s390/scsi/zfcp_scsi.c                    |  14 +-
 drivers/scsi/qla2xxx/qla_init.c                  |   3 +-
 drivers/scsi/sd.c                                |   2 +
 drivers/staging/line6/midi.c                     |   2 +-
 drivers/staging/rtl8192u/r8192U_core.c           |   2 +
 drivers/staging/usbip/usbip_common.h             |   2 +-
 drivers/staging/usbip/vhci_hcd.c                 |   8 +-
 drivers/thermal/imx_thermal.c                    |  19 +-
 drivers/tty/Makefile                             |   3 +-
 drivers/tty/n_null.c                             |  80 +++++++
 drivers/tty/pty.c                                |  21 +-
 drivers/tty/serial/altera_uart.c                 |   6 +-
 drivers/tty/serial/arc_uart.c                    |   8 +-
 drivers/tty/serial/fsl_lpuart.c                  |   4 +
 drivers/tty/serial/imx.c                         |   6 +
 drivers/tty/serial/mxs-auart.c                   |   5 +
 drivers/tty/serial/pxa.c                         |   4 +
 drivers/tty/serial/xilinx_uartps.c               |   2 +-
 drivers/tty/tty_io.c                             |  42 ++--
 drivers/tty/tty_ldisc.c                          |  68 +++---
 drivers/tty/vt/vt.c                              |   6 +-
 drivers/usb/core/config.c                        |   4 +-
 drivers/usb/core/generic.c                       |   9 +-
 drivers/usb/core/hcd.c                           |   1 +
 drivers/usb/core/hub.c                           |  10 +-
 drivers/usb/core/quirks.c                        |   3 +
 drivers/usb/dwc3/dwc3-pci.c                      |   2 +-
 drivers/usb/host/xhci-pci.c                      |   5 +-
 drivers/usb/musb/musb_gadget_ep0.c               |  14 +-
 drivers/usb/musb/musb_host.c                     |   4 +-
 drivers/usb/serial/Kconfig                       |   1 +
 drivers/usb/serial/cp210x.c                      |   2 +
 drivers/usb/serial/ftdi_sio.c                    |   5 +-
 drivers/usb/serial/ftdi_sio_ids.h                |   9 +
 drivers/usb/serial/usb-serial-simple.c           |   7 +
 drivers/usb/serial/visor.c                       |  69 +++---
 drivers/video/fbdev/stifb.c                      |   2 +-
 drivers/watchdog/f71808e_wdt.c                   |   2 +-
 drivers/xen/swiotlb-xen.c                        |   2 +-
 drivers/xen/xen-acpi-processor.c                 |   6 +-
 fs/affs/namei.c                                  |  10 +-
 fs/afs/security.c                                |  13 +-
 fs/aio.c                                         |   7 +-
 fs/autofs4/root.c                                |   2 +-
 fs/btrfs/ctree.c                                 |  16 +-
 fs/btrfs/extent-tree.c                           |   1 +
 fs/btrfs/inode.c                                 | 231 +++++++++++++-------
 fs/btrfs/ioctl.c                                 |  22 +-
 fs/btrfs/tests/qgroup-tests.c                    |   2 +-
 fs/btrfs/tree-log.c                              |  12 +-
 fs/buffer.c                                      |   2 +-
 fs/ceph/inode.c                                  |  10 +-
 fs/cifs/cifsfs.c                                 |  13 ++
 fs/cifs/dir.c                                    |   9 +-
 fs/cifs/smb2pdu.c                                |  49 +++--
 fs/dcache.c                                      |  22 ++
 fs/ecryptfs/inode.c                              |   3 +-
 fs/ext2/inode.c                                  |  10 -
 fs/ext2/namei.c                                  |   6 +-
 fs/ext3/namei.c                                  |   6 +-
 fs/ext4/balloc.c                                 |   3 +-
 fs/ext4/dir.c                                    |   8 +-
 fs/ext4/ialloc.c                                 |  43 +---
 fs/ext4/indirect.c                               |   5 +-
 fs/ext4/namei.c                                  |   6 +-
 fs/ext4/xattr.c                                  |  86 +++++---
 fs/ext4/xattr.h                                  |  11 +
 fs/f2fs/f2fs.h                                   |   1 +
 fs/f2fs/gc.c                                     |   2 +-
 fs/f2fs/inode.c                                  |  23 ++
 fs/f2fs/namei.c                                  |  52 ++---
 fs/fs-writeback.c                                |   2 +-
 fs/hugetlbfs/inode.c                             |  10 +-
 fs/jbd2/journal.c                                |   5 +-
 fs/jbd2/transaction.c                            |   1 +
 fs/jffs2/dir.c                                   |  12 +-
 fs/jffs2/super.c                                 |   2 +-
 fs/jfs/namei.c                                   |  12 +-
 fs/namespace.c                                   |   3 +-
 fs/nilfs2/namei.c                                |   6 +-
 fs/notify/fanotify/fanotify.c                    |  34 ++-
 fs/ocfs2/dlm/dlmcommon.h                         |   1 +
 fs/ocfs2/dlm/dlmdomain.c                         |  15 ++
 fs/ocfs2/dlm/dlmrecovery.c                       |  13 +-
 fs/proc/proc_sysctl.c                            |   3 +
 fs/reiserfs/journal.c                            |   2 +-
 fs/reiserfs/namei.c                              |  12 +-
 fs/ubifs/super.c                                 |  14 +-
 fs/udf/ialloc.c                                  |   7 +-
 fs/udf/namei.c                                   | 106 ++++-----
 fs/ufs/ialloc.c                                  |   6 +-
 fs/ufs/namei.c                                   |  14 +-
 include/asm-generic/word-at-a-time.h             |  80 ++++++-
 include/linux/clk-provider.h                     |   3 +-
 include/linux/dcache.h                           |   1 +
 include/linux/efi.h                              |   8 +-
 include/linux/hid.h                              |   4 +-
 include/linux/iio/buffer.h                       |   6 +-
 include/linux/log2.h                             |  13 +-
 include/linux/msg.h                              |   4 +-
 include/linux/mtd/flashchip.h                    |   1 +
 include/linux/shm.h                              |   4 +-
 include/linux/string.h                           |   3 +
 include/linux/tty.h                              |   6 +-
 include/linux/virtio.h                           |   3 +
 include/net/dst.h                                |   1 +
 include/net/inet_timewait_sock.h                 |   1 +
 include/net/nexthop.h                            |   2 +-
 include/rdma/ib_addr.h                           |   2 +
 include/sound/control.h                          |   7 +-
 include/sound/pcm_oss.h                          |   1 +
 include/trace/events/xen.h                       |  16 --
 include/uapi/linux/ppp-ioctl.h                   |   2 +-
 include/uapi/linux/tty.h                         |   1 +
 ipc/msg.c                                        |  19 +-
 ipc/msgutil.c                                    |   2 +-
 ipc/sem.c                                        |  38 ++--
 ipc/shm.c                                        | 116 +++++++---
 ipc/util.c                                       |   9 +
 ipc/util.h                                       |  11 +
 kernel/resource.c                                |   3 +-
 kernel/sched/auto_group.c                        |   9 +-
 kernel/sched/core.c                              |   3 +
 kernel/sys.c                                     |   4 +
 kernel/time/clocksource.c                        |   2 +
 kernel/time/tick-broadcast.c                     |   8 +
 kernel/trace/trace_events_filter.c               |   3 +
 kernel/trace/trace_events_trigger.c              |   5 +-
 kernel/trace/trace_uprobe.c                      |  32 ++-
 kernel/tracepoint.c                              |   4 +-
 lib/string.c                                     |  88 ++++++++
 mm/filemap.c                                     |   7 +-
 mm/mmap.c                                        |  32 +++
 net/atm/lec.c                                    |   9 +-
 net/batman-adv/translation-table.c               |  93 ++++++--
 net/bridge/netfilter/ebtables.c                  |   3 +-
 net/ceph/messenger.c                             |   7 +
 net/compat.c                                     |   6 +-
 net/core/dev.c                                   |   3 +-
 net/core/dev_addr_lists.c                        |   4 +-
 net/core/neighbour.c                             |  30 ++-
 net/core/skbuff.c                                |   1 +
 net/dccp/ccids/ccid2.c                           |  14 +-
 net/dccp/timer.c                                 |   2 +-
 net/dns_resolver/dns_key.c                       |  14 +-
 net/ipv4/inet_timewait_sock.c                    |   1 +
 net/ipv4/ip_output.c                             |   3 +-
 net/ipv4/ip_tunnel.c                             |  17 +-
 net/ipv4/ping.c                                  |   7 +-
 net/ipv4/route.c                                 | 118 +++++-----
 net/ipv4/tcp.c                                   |   8 +-
 net/ipv4/tcp_input.c                             |   7 +-
 net/ipv4/tcp_output.c                            |   7 +-
 net/ipv4/udp.c                                   |   7 +-
 net/ipv6/ip6_gre.c                               |   8 +-
 net/ipv6/ip6_output.c                            |   3 +-
 net/ipv6/ip6_tunnel.c                            |   8 +-
 net/ipv6/ip6_vti.c                               |   7 +-
 net/ipv6/route.c                                 |   2 +
 net/ipv6/sit.c                                   |   8 +-
 net/ipv6/xfrm6_policy.c                          |   2 +-
 net/l2tp/l2tp_core.c                             | 260 ++++++++++---------=
----
 net/l2tp/l2tp_core.h                             |   7 +-
 net/l2tp/l2tp_debugfs.c                          |  18 +-
 net/l2tp/l2tp_netlink.c                          |  28 ++-
 net/l2tp/l2tp_ppp.c                              |  43 +++-
 net/llc/af_llc.c                                 |  17 +-
 net/netfilter/ipvs/ip_vs_core.c                  |   8 +
 net/netfilter/ipvs/ip_vs_ctl.c                   |  15 +-
 net/netfilter/ipvs/ip_vs_sync.c                  |  10 +-
 net/netfilter/nf_tables_api.c                    |  59 ++---
 net/netlink/af_netlink.c                         |   2 +
 net/packet/af_packet.c                           |  86 +++++---
 net/packet/internal.h                            |  10 +-
 net/rfkill/rfkill-gpio.c                         |   7 +-
 net/sched/sch_fq.c                               |  37 ++--
 net/sctp/inqueue.c                               |   2 +-
 net/sctp/ipv6.c                                  |  65 +++---
 net/sunrpc/rpc_pipe.c                            |   1 +
 security/selinux/ss/services.c                   |   2 +-
 sound/core/control_compat.c                      |   3 +-
 sound/core/oss/pcm_oss.c                         | 186 ++++++++++++----
 sound/core/pcm.c                                 |   8 +-
 sound/core/pcm_compat.c                          |   2 +
 sound/core/pcm_native.c                          |   1 +
 sound/core/rawmidi_compat.c                      |  18 +-
 sound/core/seq/oss/seq_oss_event.c               |  15 +-
 sound/core/seq/oss/seq_oss_midi.c                |   2 +
 sound/core/seq/oss/seq_oss_synth.c               |  85 ++++----
 sound/core/seq/oss/seq_oss_synth.h               |   3 +-
 sound/core/seq/seq_virmidi.c                     |   4 +-
 sound/core/timer.c                               | 222 +++++++++----------
 sound/drivers/aloop.c                            |  17 +-
 sound/drivers/opl3/opl3_synth.c                  |   7 +-
 sound/pci/asihpi/hpimsginit.c                    |  39 ++--
 sound/pci/asihpi/hpioctl.c                       |   4 +-
 sound/pci/hda/hda_hwdep.c                        |  12 +-
 sound/pci/rme9652/hdspm.c                        |  24 ++-
 sound/pci/rme9652/rme9652.c                      |   6 +-
 sound/soc/codecs/ssm2602.c                       |  19 +-
 sound/soc/fsl/fsl_esai.c                         |   7 +
 sound/usb/mixer.c                                |   8 +
 sound/usb/mixer_maps.c                           |   3 +
 tools/perf/Documentation/perf-top.txt            |   3 +
 tools/perf/builtin-record.c                      |   2 +-
 354 files changed, 3603 insertions(+), 1941 deletions(-)

Aaron Ma (2):
      HID: i2c-hid: fix size check and type usage
      HID: core: Fix size as type u32

Al Viro (12):
      hypfs_kill_super(): deal with failed allocations
      jffs2_kill_sb(): deal with failed allocations
      rpc_pipefs: fix double-dput()
      Don't leak MNT_INTERNAL away from internal mounts
      udf: merge the pieces inserting a new non-directory object into direc=
tory
      udf: fix the udf_iget() vs. udf_new_inode() races
      ufs: deal with nfsd/iget races
      do d_instantiate/unlock_new_inode combinations safely
      affs_lookup(): close a race with affs_remove_link()
      ext2: fix a block leak
      aio: fix io_destroy(2) vs. lookup_ioctx() race
      fix io_destroy()/aio_complete() race

Alan Cox (1):
      tty: handle the case where we cannot restore a line discipline

Alan Stern (1):
      USB: Accept bulk endpoints with 1024-byte maxpacket

Alex Smith (1):
      mmc: jz4740: Fix race condition in IRQ mask update

Alexander Gerasiov (1):
      parport_pc: Add support for WCH CH382L PCI-E single parallel port car=
d.

Alexey Khoroshilov (2):
      vmxnet3: fix checks for dma mapping errors
      vmxnet3: avoid assumption about invalid dma_pa in vmxnet3_set_mc()

Amir Goldstein (1):
      fanotify: fix logic of events on child

Andrew Morton (1):
      fs/reiserfs/journal.c: add missing resierfs_warning() arg

Andrey Ignatov (1):
      ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg

Andy King (1):
      VMXNET3: Check for map error in vmxnet3_set_mc

Aneesh Kumar K.V (1):
      powerpc/mm/hugetlb: initialize the pagetable cache correctly for huge=
tlb

Ard Biesheuvel (1):
      efi: Avoid potential crashes, fix the 'struct efi_pci_io_protocol_32'=
 definition for mixed mode

Arnaldo Carvalho de Melo (1):
      perf top: Document --ignore-vmlinux

Arnd Bergmann (1):
      media: s3c-camif: fix out-of-bounds array access

Bai Ping (1):
      thermal: imx: register irq handler later in probe

Bart Van Assche (1):
      IB/srp: Fix srp_abort()

Ben Hutchings (5):
      scsi: qla2xxx: Avoid double completion of abort command
      drm/msm: Fix possible null dereference on failure of get_pages()
      ALSA: timer: Fix pause event notification
      ppp: Fix null pointer dereference on registration failure
      Linux 3.16.60

Bharat Potnuri (1):
      iw_cxgb4: Atomically flush per QP HW CQEs

Bin Liu (1):
      usb: musb: host: fix potential NULL pointer dereference

Bjorn Helgaas (1):
      drm/radeon: make MacBook Pro d3_delay quirk more generic

Bj=C3=B8rn Mork (1):
      qmi_wwan: do not steal interfaces from class drivers

Brad Volkin (1):
      drm/i915: Log a message when rejecting LRM to OACONTROL

Bryan O'Donoghue (1):
      rtc: snvs: Fix usage of snvs_rtc_enable

Chao Yu (2):
      f2fs: reposition unlock_new_inode to prevent accessing invalid inode
      udf: avoid unneeded up_write when fail to add entry in ->symlink

Charles Keepax (2):
      regmap: Correct offset handling in regmap_volatile_range
      regmap: Don't use format_val in regmap_bulk_read

Chris Mason (1):
      Btrfs: use insert_inode_locked4 for inode creation

Chris Metcalf (3):
      Make asm/word-at-a-time.h available on all architectures
      word-at-a-time.h: fix some Kbuild files
      string: provide strscpy()

Clemens Werther (1):
      USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator

Colin Ian King (5):
      media: cx25821: prevent out-of-bounds read on array card
      rtc: tx4939: avoid unintended sign extension on a 24 bit shift
      staging: rtl8192u: return -ENOMEM on failed allocation of priv->oldad=
dr
      RDMA/iwpm: fix memory leak on map_info
      KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"

Collin May (1):
      USB: serial: simple: add libtransistor console

Cong Wang (2):
      llc: hold llc_sap before release_sock()
      llc: fix NULL pointer deref for SOCK_ZAPPED

Dan Carpenter (2):
      xen/acpi: off by one in read_acpi_id()
      net: ethernet: davinci_emac: fix error handling in probe()

Daniel Borkmann (1):
      bpf, x64: fix memleak when not converging after image

Danilo Krummrich (1):
      fs/proc/proc_sysctl.c: fix potential page fault while unregistering s=
ysctl table

Danit Goldberg (1):
      IB/mlx5: Use unlimited rate when static rate is not supported

Dave Airlie (1):
      drm: set FMODE_UNSIGNED_OFFSET for drm files

David Henningsson (1):
      ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr

David Howells (1):
      afs: Fix directory permissions check

David Lechner (1):
      pinctrl: pinctrl-single: Fix pcs_request_gpio() when bits_per_mux !=
=3D 0

Davidlohr Bueso (5):
      ipc,shm: move BUG_ON check into shm_lock
      ipc: convert invalid scenarios to use WARN_ON
      ipc/sem: make semctl setting sempid consistent
      Revert "ipc/shm: Fix shmat mmap nil-page protection"
      ipc/shm: fix shmat() nil address after round-down when remapping

Dennis Wassenberg (1):
      Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list

Dexuan Cui (1):
      tick/broadcast: Use for_each_cpu() specially on UP kernels

Dmitry Safonov (1):
      tracing/uprobe: Drop isdigit() check in create_trace_uprobe

Dou Liyang (1):
      x86/acpi: Prevent X2APIC id 0xffffffff from being accounted

Eliot Blennerhassett (1):
      ALSA: asihpi: used parts of message/response are zeroed before use

Eric Biggers (5):
      crypto: x86/cast5-avx - fix ECB encryption when long sg follows short=
 one
      ipc/shm: fix use-after-free of shm file via remap_file_pages()
      ext4: correctly detect when an xattr value has an invalid size
      KEYS: DNS: limit the length of option strings
      ppp: remove the PPPIOCDETACH ioctl

Eric Dumazet (21):
      ip_tunnel: better validate user provided tunnel names
      ipv6: sit: better validate user provided tunnel names
      ip6_gre: better validate user provided tunnel names
      ip6_tunnel: better validate user provided tunnel names
      vti6: better validate user provided tunnel names
      crypto: af_alg - fix possible uninit-value in alg_bind()
      netlink: fix uninit-value in netlink_sendmsg
      net: fix rtnh_ok()
      net: initialize skb->peeked when cloning
      net: fix uninit-value in __hw_addr_add_ex()
      soreuseport: initialise timewait reuseport field
      sctp: do not leak kernel memory to user space
      tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets
      net: af_packet: fix race in PACKET_{R|T}X_RING
      ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy
      tcp: fix TCP_REPAIR_QUEUE bound checking
      net_sched: fq: take care of throttled flows before reuse
      dccp: fix tasklet usage
      llc: better deal with too small mtu
      xfrm6: avoid potential infinite loop in _decode_session6()
      tcp: purge write queue in tcp_connect_init()

Eric W. Biederman (4):
      ipc/util: Helpers for making the sysvipc operations pid namespace awa=
re
      ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
      ipc/msg: Fix msgctl(..., IPC_STAT, ...) between pid namespaces
      ipc/sem: Fix semctl(..., GETPID, ...) between pid namespaces

Eryu Guan (1):
      ext4: protect i_disksize update by i_data_sem in direct write path

Fabi=C3=A1n Inostroza (1):
      ALSA: line6: Use correct endpoint type for midi output

Federico Cuello (1):
      ALSA: usb: mixer: volume quirk for CM102-A+/102S+

Filipe Manana (3):
      Btrfs: fix copy_items() return value when logging an inode
      Btrfs: ensure tmpfile inode is always persisted with link count of 0
      Btrfs: don't leave dangling dentry if symlink creation failed

Florent Flament (1):
      drm/i915: Fix drm:intel_enable_lvds ERROR message in kernel log

Florian Fainelli (2):
      net: bcmgenet: Fix sparse warnings in bcmgenet_put_tx_csum()
      net: systemport: Fix sparse warnings in bcm_sysport_insert_tsb()

Florian Westphal (1):
      netfilter: nf_tables: can't fail after linking rule into active rule =
list

Francisco Jerez (1):
      drm/i915: Fix command parser to validate multiple register access wit=
h the same command.

Geert Uytterhoeven (6):
      serial: arc_uart: Fix out-of-bounds access through DT alias
      serial: fsl_lpuart: Fix out-of-bounds access through DT alias
      serial: imx: Fix out-of-bounds access through serial port index
      serial: mxs-auart: Fix out-of-bounds access through serial port index
      serial: pxa: Fix out-of-bounds access through serial port index
      serial: xuartps: Fix out-of-bounds access through DT alias

Govindarajulu Varadarajan (1):
      enic: set DMA mask to 47 bit

Greg Kroah-Hartman (1):
      USB: serial: visor: handle potential invalid device configuration

Guenter Roeck (4):
      hwmon: (pmbus/max8688) Accept negative page register values
      hwmon: (pmbus/adm1275) Accept negative page register values
      hwmon: (nct6775) Fix writing pwmX_mode
      hwmon: (nct6683) Enable EC access if disabled at boot

Guillaume Nault (12):
      l2tp: fix races in tunnel creation
      l2tp: fix race in duplicate tunnel detection
      l2tp: hold reference on tunnels in netlink dumps
      l2tp: hold reference on tunnels printed in pppol2tp proc file
      l2tp: hold reference on tunnels printed in l2tp/tunnels debugfs file
      l2tp: fix {pppol2tp, l2tp_dfs}_seq_stop() in case of seq_file overflow
      l2tp: check sockaddr length in pppol2tp_connect()
      pppoe: check sockaddr length in pppoe_connect()
      ppp: fix device unregistration upon netns deletion
      ppp: fix lockdep splat in ppp_dev_uninit()
      ppp: fix race in ppp device destruction
      ppp: unlock all_ppp_mutex before registering device

Gustavo A. R. Silva (3):
      atm: zatm: Fix potential Spectre v1
      net: atm: Fix potential Spectre v1
      kernel/sys.c: fix potential Spectre v1 issue

Hans de Goede (1):
      libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs

Heinrich Schuchardt (1):
      usb: musb: gadget: misplaced out of bounds check

Helge Deller (2):
      parisc: Fix HPMC handler by increasing size to multiple of 16 bytes
      parisc: Fix out of array access in match_pci_device()

Hendrik Brueckner (1):
      s390/cpum_sf: ensure sample frequency of perf event attributes is non=
-zero

Herbert Xu (1):
      crypto: ahash - Fix early termination in hash walk

Huacai Chen (1):
      zboot: fix stack protector in compressed boot phase

Ian Kent (1):
      autofs: mount point create should honour passed in mode

Igor Pylypiv (1):
      watchdog: f71808e_wdt: Fix WD_EN register read

Ilya Dryomov (1):
      libceph: validate con->state at the top of try_write()

Ivan Khoronzhuk (1):
      net: ethernet: ti: cpdma: correct error handling for chan create

Jack Morgenstein (1):
      net/mlx4: Fix irq-unsafe spinlock usage

Jaegeuk Kim (2):
      f2fs: call f2fs_unlock_op after error was handled
      f2fs: go out for insert_inode_locked failure

James Kelly (1):
      ASoC: ssm2602: Replace reg_default_raw with reg_default

Jan Kara (3):
      bdi: Fix oops in wb_workfn()
      ufs: Fix warning from unlock_new_inode()
      ufs: Fix possible deadlock when looking up directories

Jann Horn (1):
      tcp: don't read out-of-bounds opsize

Jason Andryuk (1):
      HID: i2c-hid: Fix "incomplete report" noise

Jeff Moyer (1):
      block_invalidatepage(): only release page if the full page was invali=
dated

Jens Remus (1):
      scsi: zfcp: fix infinite iteration on ERP ready list

Jerome Brunet (1):
      clk: fix mux clock documentation

Jimmy Assarsson (1):
      can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_=
msg()

Jiri Olsa (1):
      perf record: Put new line after target override warning

Joakim Tjernlund (3):
      mtd: cfi: cmdset_0001: Do not allow read/write to suspend erase block.
      mtd: cfi: cmdset_0001: Workaround Micron Erase suspend bug.
      mtd: cfi: cmdset_0002: Do not allow read/write to suspend erase block.

Joe Jin (1):
      xen-swiotlb: fix the check condition for xen_swiotlb_free_coherent

Joerg Roedel (1):
      x86/mm: Prevent kernel Oops in PTDUMP code with HIGHPTE=3Dy

Johan Hovold (2):
      USB: serial: cp210x: add ELDAT Easywave RX09 id
      rfkill: gpio: fix memory leak in probe error path

Jonathan Neusch=C3=A4fer (1):
      net: core: dst: Add kernel-doc for 'net' parameter

Julian Anastasov (3):
      ipv4: fix fnhe usage by non-cached routes
      ipvs: fix stats update from local clients
      ipvs: fix buffer overflow with sync daemon and service

Julian Wiedmann (5):
      s390/qdio: don't merge ERROR output buffers
      s390/qdio: don't retry EQBS after CCQ 96
      s390/qeth: handle failure on workqueue creation
      s390/qdio: fix access to uninitialized qdio_q fields
      s390/qdio: don't release memory in qdio_setup_irq()

Kai-Heng Feng (2):
      sky2: Increase D3 delay to sky2 stops working after suspend
      xhci: Fix USB ports for Dell Inspiron 5775

Kamil Lulko (1):
      usb: core: Add quirk for HP v222w 16GB Mini

Kenny Yu (1):
      uprobe: Find last occurrence of ':' when parsing uprobe PATH:OFFSET

Kirill A. Shutemov (1):
      ipc/shm: handle removed segments gracefully in shm_mmap()

Krzysztof Mazur (1):
      um: Use POSIX ucontext_t instead of struct ucontext

Kyle Roeschley (1):
      USB: serial: cp210x: add ID for NI USB serial console

Lance Richardson (1):
      net: support compat 64-bit time in {s,g}etsockopt

Leon Romanovsky (1):
      RDMA/mlx5: Protect from shift operand overflow

Leonard Crestez (1):
      crypto: arm,arm64 - Fix random regeneration of S_shipped

Li RongQing (1):
      x86/apic: Fix signedness bug in APIC ID validity checks

Linus L=C3=BCssing (1):
      batman-adv: Fix TT sync flags for intermediate TT responses

Linus Torvalds (3):
      mmap: introduce sane default mmap limits
      mmap: relax file size limit for regular files
      give up on gcc ilog2() constant optimizations

Liu Bo (3):
      Btrfs: fix unexpected cow in run_delalloc_nocow
      Btrfs: fix NULL pointer dereference in log_dir_items
      Btrfs: bail out on error during replay_dir_deletes

Long Li (1):
      cifs: Allocate validate negotiation request through kmalloc

Maciej W. Rozycki (3):
      MIPS: ptrace: Expose FIR register through FP regset
      MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32=
 FGRs
      MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs

Mahesh Rajashekhara (1):
      scsi: sd: Defer spinning up drive while SANITIZE is in progress

Major Hayden (1):
      USB: serial: ftdi_sio: add RT Systems VX-8 cable

Marc Dionne (1):
      afs: Ignore AFS_ACE_READ and AFS_ACE_WRITE for directories

Marc Zyngier (1):
      KVM: arm/arm64: Close VMID generation race

Marek Lindner (1):
      batman-adv: prevent TT request storms by not sending inconsistent TT =
TLVLs

Mark Brown (1):
      regmap: Support bulk reads for devices without raw formatting

Markus Elfring (2):
      video/fbdev/stifb: Return -ENOMEM after a failed kzalloc() in stifb_i=
nit_fb()
      tracing: Deletion of an unnecessary check before iput()

Martin K. Petersen (1):
      scsi: mptsas: Disable WRITE SAME

Martin Kelly (2):
      iio:buffer: make length types match kfifo types
      iio:kfifo_buf: check for uint overflow

Masami Hiramatsu (3):
      tracing/uprobe_event: Fix strncpy corner case
      ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr
      ARM: 8772/1: kprobes: Prohibit kprobes on get_user functions

Mathieu Desnoyers (1):
      tracepoint: Do not warn on ENOMEM

Matt Redfearn (4):
      MIPS: memset.S: EVA & fault support for small_memset
      MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
      MIPS: memset.S: Fix clobber of v1 in last_fixup
      MIPS: uaccess: Add micromips clobbers to bzero invocation

Matthew Auld (1):
      drm/i915/userptr: reject zero user_size

Matthew Wilcox (1):
      mm/filemap.c: fix NULL pointer in page_cache_tree_insert()

Mauro Carvalho Chehab (1):
      media: v4l2-compat-ioctl32: don't oops on overlay

Michael Ellerman (1):
      powerpc/lib: Fix off-by-one in alternate feature patching

Michael Neuling (3):
      powerpc/eeh: Fix race with driver un/bind
      powerpc/eeh: Fix enabling bridge MMIO windows
      powerpc/64s: Clear PCR on boot

Michael S. Tsirkin (6):
      virtio_console: don't tie bufs to a vq
      virtio: add ability to iterate over vqs
      virtio_console: free buffers after reset
      virtio_console: drop custom control queue cleanup
      virtio_console: move removal code
      virtio_console: reset on out of memory

Michal Srb (1):
      drm/i915/cmdparser: Do not check past the cmd length.

Mika Westerberg (2):
      ACPI / hotplug / PCI: Check presence of slot itself in get_slot_statu=
s()
      ahci: Add PCI ID for Cannon Lake PCH-LP AHCI

Mike Frysinger (1):
      vt: change SGR 21 to follow the standards

Mike Galbraith (1):
      sched/autogroup: Fix 64-bit kernel nice level adjustment

Mike Kravetz (1):
      hugetlbfs: fix bug in pgoff overflow checking

Mikhail Lappo (1):
      thermal: imx: Fix race condition in imx_thermal_probe()

Moshe Shemesh (1):
      net/mlx4_en: Verify coalescing parameters are in range

Nicholas Piggin (5):
      powerpc/powernv: Handle unknown OPAL errors in opal_nvram_write()
      powerpc/64: Fix smp_wmb barrier definition use use lwsync consistently
      powerpc/powernv: define a standard delay for OPAL_BUSY type retry loo=
ps
      powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops
      powerpc/powernv: Fix NVRAM sleep in invalid context when crashing

Nico Sneck (1):
      drm/radeon: add PX quirk for Asus K73TK

Nicolas Dichtel (1):
      ip_tunnel: restore binding to ifaces with a large mtu

Nicolas Ferre (1):
      ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property

Nicolin Chen (1):
      ASoC: fsl_esai: Fix divisor calculation failure at lower ratio

Nikolay Borisov (3):
      btrfs: Refactor transaction handling in received subvolume ioctl
      btrfs: Handle error from btrfs_uuid_tree_rem call in _btrfs_ioctl_set=
_received_subvol
      btrfs: Fix possible softlock on single core machines

Ondrej Zary (2):
      Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad
      drm/i915: Disable LVDS on Radiant P845

Paolo Abeni (2):
      team: avoid adding twice the same option to the event list
      netfilter: ebtables: handle string from userspace with care

Paul Parsons (1):
      drm/radeon: Fix PCIe lane width calculation

Peng Hao (1):
      kvm: x86: fix a compile warning

Peter Rosin (3):
      i2c: pmcmsp: return message count on master_xfer success
      i2c: pmcmsp: fix error return from master_xfer
      i2c: viperboard: return message count on master_xfer success

Peter Zijlstra (5):
      clocksource: Initialize cs->wd_list
      sched/core: Fix possible Spectre-v1 indexing for sched_prio_to_weight=
[]
      sched/autogroup: Fix possible Spectre-v1 indexing for sched_prio_to_w=
eight[]
      perf/x86: Fix possible Spectre-v1 indexing for x86_pmu::event_map()
      perf/x86: Fix possible Spectre-v1 indexing for hw_perf_event cache_*

Prakash Kamliya (1):
      drm/msm: fix leak in failed get_pages

Qu Wenruo (1):
      btrfs: tests/qgroup: Fix wrong tree backref level

Raju Rangoju (1):
      RDMA/cxgb4: release hw resources on device removal

Rasmus Villemoes (2):
      drivers: tty: Merge alloc_tty_struct and initialize_tty_struct
      drivers: tty: Fix use-after-free in pty_common_install

Ravi Chandra Sadineni (1):
      USB: Increment wakeup count on remote wakeup.

Richard Weinberger (2):
      ubifs: Check ubifs_wbuf_sync() return code
      ubi: Reject MLC NAND

Robbie Ko (1):
      Btrfs: send, fix invalid access to commit roots due to concurrent sna=
pshotting

Rodrigo Rivas Costa (1):
      HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device

Roland Dreier (3):
      RDMA/ucma: Don't allow setting RDMA_OPTION_IB_PATH without an RDMA de=
vice
      RDMA/ucma: Introduce safer rdma_addr_size() variants
      RDMA/ucma: Allow resolving address w/o specifying source address

Romain Izard (1):
      ubi: Fix error for write access

Ronnie Sahlberg (1):
      cifs: fix memory leak in SMB2_open()

Russell King (1):
      ARM: keystone: fix platform_domain_notifier array overrun

SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) (1):
      NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2

Sachin Grover (1):
      selinux: KASAN: slab-out-of-bounds in xattr_getsecurity

Sean Young (1):
      media: rc: oops in ir_timer_keyup after device unplug

Sebastian Ott (1):
      s390/cio: update chpid descriptor after resource accessibility event

Sekhar Nori (1):
      ARM: davinci: board-dm646x-evm: set VPIF capture card name

Sergei Shtylyov (1):
      drm: rcar-du: lvds: Fix LVDS startup on R-Car Gen2

Shamir Rabinovitch (1):
      RDMA/ucma: ucma_context reference leak in error path

Shuah Khan (2):
      usbip: vhci_hcd: check rhport before using in vhci_hub_control()
      usbip: vhci_hcd: Fix usb device and sockfd leaks

Song Liu (1):
      tracing: Fix bad use of igrab in trace_uprobe.c

Stefan Br=C3=BCns (1):
      drm/i915: Try EDID bitbanging on HDMI after failed read

Stefan Haberland (1):
      s390/dasd: fix IO error for newly defined devices

Steve French (2):
      cifs: do not allow creating sockets except with SMB1 posix exensions
      smb3: directory sync should not return an error

Steven Rostedt (VMware) (3):
      tracing: Fix regex_match_front() to not over compare the test string
      tracing/x86/xen: Remove zero data size trace events trace_xen_mmu_flu=
sh_tlb{_all}
      tracing: Fix crash when freeing instances with event triggers

Sudhir Sreedharan (1):
      rtl8187: Fix NULL pointer dereference in priv->conf_mutex

Sudip Mukherjee (1):
      libata: blacklist Micron 500IT SSD with MU01 firmware

Sven Eckelmann (1):
      batman-adv: Avoid race in TT TVLV allocator helper

Takashi Iwai (21):
      ALSA: pcm: Use ERESTARTSYS instead of EINTR in OSS emulation
      ALSA: pcm: Avoid potential races between OSS ioctls and read/write
      ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams
      ALSA: pcm: Fix mutex unbalance in OSS emulation ioctls
      ALSA: pcm: Fix UAF at PCM release via PCM timer access
      ALSA: pcm: Fix endless loop for XRUN recovery in OSS emulation
      resource: fix integer overflow at reallocation
      ALSA: rawmidi: Fix missing input substream checks in compat ioctls
      ALSA: usb-audio: Skip broken EU on Dell dock USB-audio
      ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device
      ALSA: seq: oss: Hardening for potential Spectre v1
      ALSA: control: Hardening for potential Spectre v1
      ALSA: hda: Hardening for potential Spectre v1
      ALSA: opl3: Hardening for potential Spectre v1
      ALSA: asihpi: Hardening for potential Spectre v1
      ALSA: hdspm: Hardening for potential Spectre v1
      ALSA: rme9652: Hardening for potential Spectre v1
      ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()
      ALSA: aloop: Add missing cable lock to ctl API callbacks
      ALSA: pcm: Check PCM state at xfern compat ioctl
      ALSA: timer: Call notifier in the same spinlock

Tarick Bedeir (1):
      net/mlx4_core: Fix error handling in mlx4_init_port_info.

Tejun Heo (1):
      libata: Blacklist some Sandisk SSDs for NCQ

Tetsuo Handa (4):
      tty: Avoid possible error pointer dereference at tty_ldisc_restore().
      tty: Don't call panic() at tty_ldisc_init()
      tty: Use __GFP_NOFAIL for tty_ldisc_get()
      x86/kexec: Avoid double free_page() upon do_kexec_load() failure

Theodore Ts'o (6):
      jbd2: if the journal is aborted then don't allow update of the log ta=
il
      ext4: don't update checksum of new initialized bitmaps
      ext4: add bounds checking to ext4_xattr_find_entry()
      ext4: add extra checks to ext4_xattr_block_get()
      ext4: force revalidation of directory pointer after seekdir(2)
      ext4: set h_journal if there is a failure starting a reserved handle

Thinh Nguyen (1):
      usb: dwc3: pci: Properly cleanup resource

Tony Lindgren (1):
      net: davinci_emac: Fix runtime pm calls for davinci_emac

Toshiaki Makita (1):
      vlan: Fix reading memory beyond skb->tail in skb_vlan_tagged_multi

Uwe Kleine-K=C3=B6nig (1):
      serial: altera: ensure port->regshift is honored consistently

Vasily Gorbik (1):
      s390/ipl: ensure loadparm valid flag is set

Vasyl Vavrychuk (1):
      USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster

Wei Huang (1):
      KVM: x86: Update cpuid properly when CR4.OSXAVE or CR4.PKE is changed

Wenwen Wang (1):
      ALSA: control: fix a redundant-copy issue

Willem de Bruijn (2):
      packet: fix bitfield update race
      net: test tailroom before appending to linear skb

Wolfgang Bumiller (1):
      net: fix deadlock while clearing neighbor proxy table

Xiaoming Gao (1):
      x86/tsc: Prevent 32bit truncation in calc_hpet_ref()

Xin Long (5):
      sctp: do not check port in sctp_inet6_cmp_addr
      bonding: do not set slave_dev npinfo before slave_enable_netpoll in b=
ond_enslave
      team: fix netconsole setup over team
      sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr
      sctp: fix the issue that the cookie-ack with auth can't get processed

Yan, Zheng (1):
      ceph: always update atime/mtime/ctime for new inode

Yazen Ghannam (1):
      x86/smpboot: Don't use mwait_play_dead() on AMD systems

Yishai Hadas (1):
      RDMA/mlx5: Don't assume that medium blueFlame register exists

Zhengjun Xing (1):
      USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw

himanshu.madhani@cavium.com (1):
      scsi: qla2xxx: Fix NULL pointer crash due to active timer for ABTS

hpreg@vmware.com (1):
      vmxnet3: set the DMA mask before the first DMA map operation

piaojun (1):
      ocfs2/dlm: wait for dlm recovery done when migrating all lock resourc=
es

=C5=81ukasz Stelmach (1):
      ARM: 8753/1: decompressor: add a missing parameter to the addruart ma=
cro


--uQr8t48UFsdbeI+V
Content-Type: text/x-diff; charset=UTF-8; name="linux-3.16.60.patch"
Content-Disposition: attachment; filename="linux-3.16.60.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/Documentation/networking/ppp_generic.txt b/Documentation/netwo=
rking/ppp_generic.txt
index 091d20273dcb..61daf4b39600 100644
--- a/Documentation/networking/ppp_generic.txt
+++ b/Documentation/networking/ppp_generic.txt
@@ -300,12 +300,6 @@ to a PPP channel.  The ioctl calls which are available=
 on an
 The ioctl calls available on an instance of /dev/ppp attached to a
 channel are:
=20
-* PPPIOCDETACH detaches the instance from the channel.  This ioctl is
-  deprecated since the same effect can be achieved by closing the
-  instance.  In order to prevent possible races this ioctl will fail
-  with an EINVAL error if more than one file descriptor refers to this
-  instance (i.e. as a result of dup(), dup2() or fork()).
-
 * PPPIOCCONNECT connects this channel to a PPP interface.  The
   argument should point to an int containing the interface unit
   number.  It will return an EINVAL error if the channel is already
diff --git a/Makefile b/Makefile
index d548dd129f44..1e4f63055a10 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION =3D 3
 PATCHLEVEL =3D 16
-SUBLEVEL =3D 59
+SUBLEVEL =3D 60
 EXTRAVERSION =3D
 NAME =3D Museum of Fishiegoodies
=20
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index e76fd79f32b0..66437e516623 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -49,4 +49,5 @@ generic-y +=3D types.h
 generic-y +=3D ucontext.h
 generic-y +=3D user.h
 generic-y +=3D vga.h
+generic-y +=3D word-at-a-time.h
 generic-y +=3D xor.h
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/hea=
d.S
index 624bd3ea0adf..c8b1eac82d2c 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -24,19 +24,19 @@
 #if defined(CONFIG_DEBUG_ICEDCC)
=20
 #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CP=
U_V7)
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c0, c5, 0
 		.endm
 #elif defined(CONFIG_CPU_XSCALE)
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c8, c0, 0
 		.endm
 #else
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c1, c0, 0
@@ -52,7 +52,7 @@
 		.endm
=20
 #if defined(CONFIG_ARCH_SA1100)
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		mov	\rb, #0x80000000	@ physical base address
 #ifdef CONFIG_DEBUG_LL_SER3
 		add	\rb, \rb, #0x00050000	@ Ser3
@@ -61,8 +61,8 @@
 #endif
 		.endm
 #else
-		.macro	loadsp,	rb, tmp
-		addruart \rb, \tmp
+		.macro	loadsp,	rb, tmp1, tmp2
+		addruart \rb, \tmp1, \tmp2
 		.endm
 #endif
 #endif
@@ -1219,7 +1219,7 @@ phex:		adr	r3, phexbuf
 		b	1b
=20
 @ puts corrupts {r0, r1, r2, r3}
-puts:		loadsp	r3, r1
+puts:		loadsp	r3, r2, r1
 1:		ldrb	r2, [r0], #1
 		teq	r2, #0
 		moveq	pc, lr
@@ -1236,8 +1236,8 @@ puts:		loadsp	r3, r1
 @ putc corrupts {r0, r1, r2, r3}
 putc:
 		mov	r2, r0
+		loadsp	r3, r1, r0
 		mov	r0, #0
-		loadsp	r3, r1
 		b	2b
=20
 @ memdump corrupts {r0, r1, r2, r3, r10, r11, r12, lr}
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/mis=
c.c
index d4f891f56996..d39edb1f7f41 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -127,12 +127,7 @@ asmlinkage void __div0(void)
 	error("Attempting division by 0!");
 }
=20
-unsigned long __stack_chk_guard;
-
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard =3D 0x000a0dff;
-}
+const unsigned long __stack_chk_guard =3D 0x000a0dff;
=20
 void __stack_chk_fail(void)
 {
@@ -149,8 +144,6 @@ decompress_kernel(unsigned long output_start, unsigned =
long free_mem_ptr_p,
 {
 	int ret;
=20
-	__stack_chk_guard_setup();
-
 	output_data		=3D (unsigned char *)output_start;
 	free_mem_ptr		=3D free_mem_ptr_p;
 	free_mem_end_ptr	=3D free_mem_ptr_end_p;
diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/at91sam=
9g25.dtsi
index 17b879990914..d69cfb540a07 100644
--- a/arch/arm/boot/dts/at91sam9g25.dtsi
+++ b/arch/arm/boot/dts/at91sam9g25.dtsi
@@ -20,7 +20,7 @@
 				atmel,mux-mask =3D <
 				      /*    A         B          C     */
 				       0xffffffff 0xffe0399f 0xc000001c  /* pioA */
-				       0x0007ffff 0x8000fe3f 0x00000000  /* pioB */
+				       0x0007ffff 0x00047e3f 0x00000000  /* pioB */
 				       0x80000000 0x07c0ffff 0xb83fffff  /* pioC */
 				       0x003fffff 0x003f8000 0x00000000  /* pioD */
 				      >;
diff --git a/arch/arm/crypto/Makefile b/arch/arm/crypto/Makefile
index 81cda39860c5..81720285f2ba 100644
--- a/arch/arm/crypto/Makefile
+++ b/arch/arm/crypto/Makefile
@@ -10,10 +10,12 @@ aes-arm-y	:=3D aes-armv4.o aes_glue.o
 aes-arm-bs-y	:=3D aesbs-core.o aesbs-glue.o
 sha1-arm-y	:=3D sha1-armv4-large.o sha1_glue.o
=20
+ifdef REGENERATE_ARM_CRYPTO
 quiet_cmd_perl =3D PERL    $@
       cmd_perl =3D $(PERL) $(<) > $(@)
=20
 $(src)/aesbs-core.S_shipped: $(src)/bsaes-armv7.pl
 	$(call cmd,perl)
+endif
=20
 .PRECIOUS: $(obj)/aesbs-core.S
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assemb=
ler.h
index 57f0584e8d97..6a1658ee2ba1 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -425,4 +425,14 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
=20
+#ifdef CONFIG_KPROBES
+#define _ASM_NOKPROBE(entry)				\
+	.pushsection "_kprobe_blacklist", "aw" ;	\
+	.balign 4 ;					\
+	.long entry;					\
+	.popsection
+#else
+#define _ASM_NOKPROBE(entry)
+#endif
+
 #endif /* __ASM_ASSEMBLER_H__ */
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index cba3cb0b1a47..a19a69003a6e 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -19,6 +19,7 @@
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 #include <linux/kdebug.h>
+#include <linux/kprobes.h>
 #include <linux/module.h>
 #include <linux/kexec.h>
 #include <linux/bug.h>
@@ -392,7 +393,8 @@ void unregister_undef_hook(struct undef_hook *hook)
 	raw_spin_unlock_irqrestore(&undef_lock, flags);
 }
=20
-static int call_undef_hook(struct pt_regs *regs, unsigned int instr)
+static nokprobe_inline
+int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 {
 	struct undef_hook *hook;
 	unsigned long flags;
@@ -465,6 +467,7 @@ asmlinkage void __exception do_undefinstr(struct pt_reg=
s *regs)
=20
 	arm_notify_die("Oops - undefined instruction", regs, &info, 0, 6);
 }
+NOKPROBE_SYMBOL(do_undefinstr)
=20
 asmlinkage void do_unexp_fiq (struct pt_regs *regs)
 {
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index d75c6e3ed78c..03ab35a58836 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -59,7 +59,7 @@ static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_arm_running_=
vcpu);
 /* The VMID used in the VTTBR */
 static atomic64_t kvm_vmid_gen =3D ATOMIC64_INIT(1);
 static u8 kvm_next_vmid;
-static DEFINE_SPINLOCK(kvm_vmid_lock);
+static DEFINE_RWLOCK(kvm_vmid_lock);
=20
 static bool vgic_present;
=20
@@ -391,11 +391,16 @@ static void update_vttbr(struct kvm *kvm)
 {
 	phys_addr_t pgd_phys;
 	u64 vmid;
+	bool new_gen;
=20
-	if (!need_new_vmid_gen(kvm))
+	read_lock(&kvm_vmid_lock);
+	new_gen =3D need_new_vmid_gen(kvm);
+	read_unlock(&kvm_vmid_lock);
+
+	if (!new_gen)
 		return;
=20
-	spin_lock(&kvm_vmid_lock);
+	write_lock(&kvm_vmid_lock);
=20
 	/*
 	 * We need to re-check the vmid_gen here to ensure that if another vcpu
@@ -403,7 +408,7 @@ static void update_vttbr(struct kvm *kvm)
 	 * use the same vmid.
 	 */
 	if (!need_new_vmid_gen(kvm)) {
-		spin_unlock(&kvm_vmid_lock);
+		write_unlock(&kvm_vmid_lock);
 		return;
 	}
=20
@@ -436,7 +441,7 @@ static void update_vttbr(struct kvm *kvm)
 	vmid =3D ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK;
 	kvm->arch.vttbr =3D pgd_phys | vmid;
=20
-	spin_unlock(&kvm_vmid_lock);
+	write_unlock(&kvm_vmid_lock);
 }
=20
 static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
diff --git a/arch/arm/lib/getuser.S b/arch/arm/lib/getuser.S
index 9b06bb41fca6..75764388f849 100644
--- a/arch/arm/lib/getuser.S
+++ b/arch/arm/lib/getuser.S
@@ -38,6 +38,7 @@ ENTRY(__get_user_1)
 	mov	r0, #0
 	mov	pc, lr
 ENDPROC(__get_user_1)
+_ASM_NOKPROBE(__get_user_1)
=20
 ENTRY(__get_user_2)
 	check_uaccess r0, 2, r1, r2, __get_user_bad
@@ -58,6 +59,7 @@ rb	.req	r0
 	mov	r0, #0
 	mov	pc, lr
 ENDPROC(__get_user_2)
+_ASM_NOKPROBE(__get_user_2)
=20
 ENTRY(__get_user_4)
 	check_uaccess r0, 4, r1, r2, __get_user_bad
@@ -65,12 +67,14 @@ ENTRY(__get_user_4)
 	mov	r0, #0
 	mov	pc, lr
 ENDPROC(__get_user_4)
+_ASM_NOKPROBE(__get_user_4)
=20
 __get_user_bad:
 	mov	r2, #0
 	mov	r0, #-EFAULT
 	mov	pc, lr
 ENDPROC(__get_user_bad)
+_ASM_NOKPROBE(__get_user_bad)
=20
 .pushsection __ex_table, "a"
 	.long	1b, __get_user_bad
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davin=
ci/board-dm646x-evm.c
index 3e3e83b974ca..03248445f24c 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -541,7 +541,7 @@ static struct vpif_display_config dm646x_vpif_display_c=
onfig =3D {
 		.outputs =3D dm6467_ch0_outputs,
 		.output_count =3D ARRAY_SIZE(dm6467_ch0_outputs),
 	},
-	.card_name	=3D "DM646x EVM",
+	.card_name	=3D "DM646x EVM Video Display",
 };
=20
 /**
@@ -699,6 +699,7 @@ static struct vpif_capture_config dm646x_vpif_capture_c=
fg =3D {
 			.fid_pol =3D 0,
 		},
 	},
+	.card_name =3D "DM646x EVM Video Capture",
 };
=20
 static void __init evm_init_video(void)
diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm=
_domain.c
index ca79ddac38bc..2c95d5706717 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -59,6 +59,7 @@ static struct dev_pm_domain keystone_pm_domain =3D {
=20
 static struct pm_clk_notifier_block platform_domain_notifier =3D {
 	.pm_domain =3D &keystone_pm_domain,
+	.con_ids =3D { NULL },
 };
=20
 static struct of_device_id of_keystone_table[] =3D {
diff --git a/arch/avr32/include/asm/Kbuild b/arch/avr32/include/asm/Kbuild
index 00a0f3ccd6eb..52b54b19c5bb 100644
--- a/arch/avr32/include/asm/Kbuild
+++ b/arch/avr32/include/asm/Kbuild
@@ -20,4 +20,5 @@ generic-y +=3D sections.h
 generic-y +=3D topology.h
 generic-y +=3D trace_clock.h
 generic-y +=3D vga.h
+generic-y +=3D word-at-a-time.h
 generic-y +=3D xor.h
diff --git a/arch/blackfin/include/asm/Kbuild b/arch/blackfin/include/asm/K=
build
index 0d93b9a79ca9..328ffecb066e 100644
--- a/arch/blackfin/include/asm/Kbuild
+++ b/arch/blackfin/include/asm/Kbuild
@@ -46,4 +46,5 @@ generic-y +=3D types.h
 generic-y +=3D ucontext.h
 generic-y +=3D unaligned.h
 generic-y +=3D user.h
+generic-y +=3D word-at-a-time.h
 generic-y +=3D xor.h
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index 8dbdce8421b0..91b1ed0b185a 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -58,4 +58,5 @@ generic-y +=3D types.h
 generic-y +=3D ucontext.h
 generic-y +=3D user.h
 generic-y +=3D vga.h
+generic-y +=3D word-at-a-time.h
 generic-y +=3D xor.h
diff --git a/arch/cris/include/asm/Kbuild b/arch/cris/include/asm/Kbuild
index afff5105909d..30684d08b1f7 100644
--- a/arch/cris/include/asm/Kbuild
+++ b/arch/cris/include/asm/Kbuild
@@ -15,4 +15,5 @@ generic-y +=3D module.h
 generic-y +=3D preempt.h
 generic-y +=3D trace_clock.h
 generic-y +=3D vga.h
+generic-y +=3D word-at-a-time.h
 generic-y +=3D xor.h
diff --git a/arch/frv/include/asm/Kbuild b/arch/frv/include/asm/Kbuild
index 87b95eb8aee5..f53f76249b8b 100644
--- a/arch/frv/include/asm/Kbuild
+++ b/arch/frv/include/asm/Kbuild
@@ -6,3 +6,4 @@ generic-y +=3D hash.h
 generic-y +=3D mcs_spinlock.h
 generic-y +=3D preempt.h
 generic-y +=3D trace_clock.h
+generic-y +=3D word-at-a-time.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbu=
ild
index 0e69796b58c7..8462f9081738 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -58,4 +58,5 @@ generic-y +=3D types.h
 generic-y +=3D ucontext.h
 generic-y +=3D unaligned.h
 generic-y +=3D vga.h
+generic-y +=3D word-at-a-time.h
 generic-y +=3D xor.h
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 0da4aa2602ae..0cbf13f261de 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y +=3D mcs_spinlock.h
 generic-y +=3D preempt.h
 generic-y +=3D trace_clock.h
 generic-y +=3D vtime.h
+generic-y +=3D word-at-a-time.h
diff --git a/arch/m32r/include/asm/Kbuild b/arch/m32r/include/asm/Kbuild
index 67779a74b62d..e351b3ef0b10 100644
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y +=3D mcs_spinlock.h
 generic-y +=3D module.h
 generic-y +=3D preempt.h
 generic-y +=3D trace_clock.h
+generic-y +=3D word-at-a-time.h
diff --git a/arch/metag/include/asm/Kbuild b/arch/metag/include/asm/Kbuild
index c29ead89a317..b7d38f05fb0e 100644
--- a/arch/metag/include/asm/Kbuild
+++ b/arch/metag/include/asm/Kbuild
@@ -54,4 +54,5 @@ generic-y +=3D ucontext.h
 generic-y +=3D unaligned.h
 generic-y +=3D user.h
 generic-y +=3D vga.h
+generic-y +=3D word-at-a-time.h
 generic-y +=3D xor.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/a=
sm/Kbuild
index 35b3ecaf25d5..57da9a75130c 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -9,3 +9,4 @@ generic-y +=3D mcs_spinlock.h
 generic-y +=3D preempt.h
 generic-y +=3D syscalls.h
 generic-y +=3D trace_clock.h
+generic-y +=3D word-at-a-time.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 05439187891d..4743a034957c 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -15,4 +15,5 @@ generic-y +=3D segment.h
 generic-y +=3D serial.h
 generic-y +=3D trace_clock.h
 generic-y +=3D ucontext.h
+generic-y +=3D word-at-a-time.h
 generic-y +=3D xor.h
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uacces=
s.h
index a752de97840f..5f675d3c86da 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -1210,6 +1210,13 @@ __clear_user(void __user *addr, __kernel_size_t size)
 {
 	__kernel_size_t res;
=20
+#ifdef CONFIG_CPU_MICROMIPS
+/* micromips memset / bzero also clobbers t7 & t8 */
+#define bzero_clobbers "$4", "$5", "$6", __UA_t0, __UA_t1, "$15", "$24", "=
$31"
+#else
+#define bzero_clobbers "$4", "$5", "$6", __UA_t0, __UA_t1, "$31"
+#endif /* CONFIG_CPU_MICROMIPS */
+
 	if (config_enabled(CONFIG_EVA) && segment_eq(get_fs(), get_ds())) {
 		__asm__ __volatile__(
 			"move\t$4, %1\n\t"
@@ -1219,7 +1226,7 @@ __clear_user(void __user *addr, __kernel_size_t size)
 			"move\t%0, $6"
 			: "=3Dr" (res)
 			: "r" (addr), "r" (size)
-			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+			: bzero_clobbers);
 	} else {
 		might_fault();
 		__asm__ __volatile__(
@@ -1230,7 +1237,7 @@ __clear_user(void __user *addr, __kernel_size_t size)
 			"move\t%0, $6"
 			: "=3Dr" (res)
 			: "r" (addr), "r" (size)
-			: "$4", "$5", "$6", __UA_t0, __UA_t1, "$31");
+			: bzero_clobbers);
 	}
=20
 	return res;
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index cc0f9ee7cf48..3d5b457be415 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -481,7 +481,7 @@ static int fpr_get_msa(struct task_struct *target,
 /*
  * Copy the floating-point context to the supplied NT_PRFPREG buffer.
  * Choose the appropriate helper for general registers, and then copy
- * the FCSR register separately.
+ * the FCSR and FIR registers separately.
  */
 static int fpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
@@ -489,6 +489,7 @@ static int fpr_get(struct task_struct *target,
 		   void *kbuf, void __user *ubuf)
 {
 	const int fcr31_pos =3D NUM_FPU_REGS * sizeof(elf_fpreg_t);
+	const int fir_pos =3D fcr31_pos + sizeof(u32);
 	int err;
=20
 	if (sizeof(target->thread.fpu.fpr[0]) =3D=3D sizeof(elf_fpreg_t))
@@ -501,6 +502,12 @@ static int fpr_get(struct task_struct *target,
 	err =3D user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				  &target->thread.fpu.fcr31,
 				  fcr31_pos, fcr31_pos + sizeof(u32));
+	if (err)
+		return err;
+
+	err =3D user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  &boot_cpu_data.fpu_id,
+				  fir_pos, fir_pos + sizeof(u32));
=20
 	return err;
 }
@@ -549,7 +556,8 @@ static int fpr_set_msa(struct task_struct *target,
 /*
  * Copy the supplied NT_PRFPREG buffer to the floating-point context.
  * Choose the appropriate helper for general registers, and then copy
- * the FCSR register separately.
+ * the FCSR register separately.  Ignore the incoming FIR register
+ * contents though, as the register is read-only.
  *
  * We optimize for the case where `count % sizeof(elf_fpreg_t) =3D=3D 0',
  * which is supposed to have been guaranteed by the kernel before
@@ -563,6 +571,7 @@ static int fpr_set(struct task_struct *target,
 		   const void *kbuf, const void __user *ubuf)
 {
 	const int fcr31_pos =3D NUM_FPU_REGS * sizeof(elf_fpreg_t);
+	const int fir_pos =3D fcr31_pos + sizeof(u32);
 	u32 fcr31;
 	int err;
=20
@@ -590,6 +599,11 @@ static int fpr_set(struct task_struct *target,
 		ptrace_setfcr31(target, fcr31);
 	}
=20
+	if (count > 0)
+		err =3D user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+						fir_pos,
+						fir_pos + sizeof(u32));
+
 	return err;
 }
=20
@@ -727,7 +741,7 @@ long arch_ptrace(struct task_struct *child, long reques=
t,
 			fregs =3D get_fpu_regs(child);
=20
 #ifdef CONFIG_32BIT
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -738,7 +752,7 @@ long arch_ptrace(struct task_struct *child, long reques=
t,
 				break;
 			}
 #endif
-			tmp =3D get_fpr32(&fregs[addr - FPR_BASE], 0);
+			tmp =3D get_fpr64(&fregs[addr - FPR_BASE], 0);
 			break;
 		case PC:
 			tmp =3D regs->cp0_epc;
@@ -816,7 +830,7 @@ long arch_ptrace(struct task_struct *child, long reques=
t,
=20
 			init_fp_ctx(child);
 #ifdef CONFIG_32BIT
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index fdd26c104c6c..38d99886300c 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -97,7 +97,7 @@ long compat_arch_ptrace(struct task_struct *child, compat=
_long_t request,
 				break;
 			}
 			fregs =3D get_fpu_regs(child);
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -107,7 +107,7 @@ long compat_arch_ptrace(struct task_struct *child, comp=
at_long_t request,
 						addr & 1);
 				break;
 			}
-			tmp =3D get_fpr32(&fregs[addr - FPR_BASE], 0);
+			tmp =3D get_fpr64(&fregs[addr - FPR_BASE], 0);
 			break;
 		case PC:
 			tmp =3D regs->cp0_epc;
@@ -203,7 +203,7 @@ long compat_arch_ptrace(struct task_struct *child, comp=
at_long_t request,
 				       sizeof(child->thread.fpu));
 				child->thread.fpu.fcr31 =3D 0;
 			}
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 64f14f6bca52..4d264a77ff92 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -38,7 +38,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] =3D {
 	{ "cache", VCPU_STAT(cache_exits) },
 	{ "signal", VCPU_STAT(signal_exits) },
 	{ "interrupt", VCPU_STAT(int_exits) },
-	{ "cop_unsuable", VCPU_STAT(cop_unusable_exits) },
+	{ "cop_unusable", VCPU_STAT(cop_unusable_exits) },
 	{ "tlbmod", VCPU_STAT(tlbmod_exits) },
 	{ "tlbmiss_ld", VCPU_STAT(tlbmiss_ld_exits) },
 	{ "tlbmiss_st", VCPU_STAT(tlbmiss_st_exits) },
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index fd83406ceccc..3d3377ca2b22 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -178,7 +178,7 @@
 1:	PTR_ADDIU	a0, 1			/* fill bytewise */
 	R10KCBARRIER(0(ra))
 	bne		t1, a0, 1b
-	sb		a1, -1(a0)
+	 EX(sb, a1, -1(a0), .Lsmall_fixup\@)
=20
 2:	jr		ra			/* done */
 	move		a2, zero
@@ -204,13 +204,18 @@
 	PTR_L		t0, TI_TASK($28)
 	andi		a2, STORMASK
 	LONG_L		t0, THREAD_BUADDR(t0)
-	LONG_ADDU	a2, t1
+	LONG_ADDU	a2, a0
 	jr		ra
 	LONG_SUBU	a2, t0
=20
 .Llast_fixup\@:
 	jr		ra
-	andi		v1, a2, STORMASK
+	 nop
+
+.Lsmall_fixup\@:
+	PTR_SUBU	a2, t1, a0
+	jr		ra
+	 PTR_ADDIU	a2, 1
=20
 	.endm
=20
diff --git a/arch/mn10300/include/asm/Kbuild b/arch/mn10300/include/asm/Kbu=
ild
index 654d5ba6e310..686af432e5f0 100644
--- a/arch/mn10300/include/asm/Kbuild
+++ b/arch/mn10300/include/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y +=3D hash.h
 generic-y +=3D mcs_spinlock.h
 generic-y +=3D preempt.h
 generic-y +=3D trace_clock.h
+generic-y +=3D word-at-a-time.h
diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index dba508fe1683..4f7060ec6875 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -648,6 +648,10 @@ static int match_pci_device(struct device *dev, int in=
dex,
 					(modpath->mod =3D=3D PCI_FUNC(devfn)));
 	}
=20
+	/* index might be out of bounds for bc[] */
+	if (index >=3D 6)
+		return 0;
+
 	id =3D PCI_SLOT(pdev->devfn) | (PCI_FUNC(pdev->devfn) << 5);
 	return (modpath->bc[index] =3D=3D id);
 }
diff --git a/arch/parisc/kernel/hpmc.S b/arch/parisc/kernel/hpmc.S
index e158b6fbf1b4..e59bde1637c9 100644
--- a/arch/parisc/kernel/hpmc.S
+++ b/arch/parisc/kernel/hpmc.S
@@ -79,6 +79,7 @@ END(hpmc_pim_data)
 	.text
=20
 	.import intr_save, code
+	.align 16
 ENTRY(os_hpmc)
 .os_hpmc:
=20
@@ -295,11 +296,14 @@ ENTRY(os_hpmc)
=20
 	b .
 	nop
+	.align 16	/* make function length multiple of 16 bytes */
 ENDPROC(os_hpmc)
 .os_hpmc_end:
 	nop
 .data
+.globl os_hpmc_size
 .align 4
-	.export os_hpmc_size
+	.type   os_hpmc_size, @object
+	.size   os_hpmc_size, 4
 os_hpmc_size:
 	.word .os_hpmc_end-.os_hpmc
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/=
barrier.h
index bab79a110c7b..7c63ec5d4fa9 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -39,7 +39,8 @@
=20
 #ifdef CONFIG_SMP
=20
-#ifdef __SUBARCH_HAS_LWSYNC
+/* The sub-arch has lwsync */
+#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
 #    define SMPWMB      LWSYNC
 #else
 #    define SMPWMB      eieio
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opa=
l.h
index 0da1dbd42e02..f7a13fb5c3a0 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -707,6 +707,9 @@ typedef struct oppanel_line {
 	uint64_t 	line_len;
 } oppanel_line_t;
=20
+/* Default time to sleep or delay between OPAL_BUSY/OPAL_BUSY_EVENT loops =
*/
+#define OPAL_BUSY_DELAY_MS	10
+
 /* /sys/firmware/opal */
 extern struct kobject *opal_kobj;
=20
diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/sy=
nch.h
index c50868681f9e..e8d6a842f4bb 100644
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch.h
@@ -5,10 +5,6 @@
 #include <linux/stringify.h>
 #include <asm/feature-fixups.h>
=20
-#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
-#define __SUBARCH_HAS_LWSYNC
-#endif
-
 #ifndef __ASSEMBLY__
 extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
 extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cp=
u_setup_power.S
index 46733535cc0b..4fadf576ec46 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -27,6 +27,7 @@ _GLOBAL(__setup_cpu_power7)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr	r3,SPRN_LPCR
 	bl	__init_LPCR
 	bl	__init_tlb_power7
@@ -40,6 +41,7 @@ _GLOBAL(__restore_cpu_power7)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr	r3,SPRN_LPCR
 	bl	__init_LPCR
 	bl	__init_tlb_power7
@@ -55,6 +57,7 @@ _GLOBAL(__setup_cpu_power8)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr	r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
 	bl	__init_LPCR
@@ -74,6 +77,7 @@ _GLOBAL(__restore_cpu_power8)
 	beqlr
 	li	r0,0
 	mtspr	SPRN_LPID,r0
+	mtspr	SPRN_PCR,r0
 	mfspr   r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
 	bl	__init_LPCR
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_dri=
ver.c
index 0e3ad5591414..da7eb7a2c888 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -198,18 +198,18 @@ static void *eeh_report_error(void *data, void *userd=
ata)
=20
 	if (!dev || eeh_dev_removed(edev))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state =3D pci_channel_io_frozen;
=20
 	driver =3D eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
=20
 	eeh_disable_irq(dev);
=20
 	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    !driver->err_handler->error_detected)
+		goto out;
=20
 	rc =3D driver->err_handler->error_detected(dev, pci_channel_io_frozen);
=20
@@ -217,7 +217,10 @@ static void *eeh_report_error(void *data, void *userda=
ta)
 	if (rc =3D=3D PCI_ERS_RESULT_NEED_RESET) *res =3D rc;
 	if (*res =3D=3D PCI_ERS_RESULT_NONE) *res =3D rc;
=20
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
=20
@@ -240,15 +243,14 @@ static void *eeh_report_mmio_enabled(void *data, void=
 *userdata)
 	if (!dev || eeh_dev_removed(edev))
 		return NULL;
=20
+	device_lock(&dev->dev);
 	driver =3D eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
=20
 	if (!driver->err_handler ||
 	    !driver->err_handler->mmio_enabled ||
-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    (edev->mode & EEH_DEV_NO_HANDLER))
+		goto out;
=20
 	rc =3D driver->err_handler->mmio_enabled(dev);
=20
@@ -256,7 +258,10 @@ static void *eeh_report_mmio_enabled(void *data, void =
*userdata)
 	if (rc =3D=3D PCI_ERS_RESULT_NEED_RESET) *res =3D rc;
 	if (*res =3D=3D PCI_ERS_RESULT_NONE) *res =3D rc;
=20
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
=20
@@ -279,19 +284,19 @@ static void *eeh_report_reset(void *data, void *userd=
ata)
=20
 	if (!dev || eeh_dev_removed(edev))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state =3D pci_channel_io_normal;
=20
 	driver =3D eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
=20
 	eeh_enable_irq(dev);
=20
 	if (!driver->err_handler ||
 	    !driver->err_handler->slot_reset ||
-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    (edev->mode & EEH_DEV_NO_HANDLER))
+		goto out;
=20
 	rc =3D driver->err_handler->slot_reset(dev);
 	if ((*res =3D=3D PCI_ERS_RESULT_NONE) ||
@@ -299,7 +304,10 @@ static void *eeh_report_reset(void *data, void *userda=
ta)
 	if (*res =3D=3D PCI_ERS_RESULT_DISCONNECT &&
 	     rc =3D=3D PCI_ERS_RESULT_NEED_RESET) *res =3D rc;
=20
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
=20
@@ -320,10 +328,12 @@ static void *eeh_report_resume(void *data, void *user=
data)
=20
 	if (!dev || eeh_dev_removed(edev))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state =3D pci_channel_io_normal;
=20
 	driver =3D eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
=20
 	eeh_enable_irq(dev);
=20
@@ -331,13 +341,15 @@ static void *eeh_report_resume(void *data, void *user=
data)
 	    !driver->err_handler->resume ||
 	    (edev->mode & EEH_DEV_NO_HANDLER)) {
 		edev->mode &=3D ~EEH_DEV_NO_HANDLER;
-		eeh_pcid_put(dev);
-		return NULL;
+		goto out;
 	}
=20
 	driver->err_handler->resume(dev);
=20
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
=20
@@ -357,22 +369,25 @@ static void *eeh_report_failure(void *data, void *use=
rdata)
=20
 	if (!dev || eeh_dev_removed(edev))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state =3D pci_channel_io_perm_failure;
=20
 	driver =3D eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
=20
 	eeh_disable_irq(dev);
=20
 	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    !driver->err_handler->error_detected)
+		goto out;
=20
 	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
=20
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
=20
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index b38e8f127f5d..56cf020cc3fc 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -723,7 +723,8 @@ static void eeh_restore_bridge_bars(struct eeh_dev *ede=
v,
 	eeh_ops->write_config(dn, 15*4, 4, edev->config_space[15]);
=20
 	/* PCI Command: 0x4 */
-	eeh_ops->write_config(dn, PCI_COMMAND, 4, edev->config_space[1]);
+	eeh_ops->write_config(dn, PCI_COMMAND, 4, edev->config_space[1] |
+			      PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
=20
 	/* Check the PCIe link is ready */
 	eeh_bridge_check_link(edev, dn);
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-f=
ixups.c
index 7a8a7487cee8..11cd36c622c1 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -52,7 +52,7 @@ static int patch_alt_instruction(unsigned int *src, unsig=
ned int *dest,
 		unsigned int *target =3D (unsigned int *)branch_target(src);
=20
 		/* Branch within the section doesn't need translating */
-		if (target < alt_start || target >=3D alt_end) {
+		if (target < alt_start || target > alt_end) {
 			instr =3D translate_branch(dest, src);
 			if (!instr)
 				return 1;
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 7e70ae968e5f..e95f95996a5b 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -175,9 +175,6 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd=
_t *hpdp,
 #ifdef CONFIG_PPC_FSL_BOOK3E
 #define HUGEPD_PGD_SHIFT PGDIR_SHIFT
 #define HUGEPD_PUD_SHIFT PUD_SHIFT
-#else
-#define HUGEPD_PGD_SHIFT PUD_SHIFT
-#define HUGEPD_PUD_SHIFT PMD_SHIFT
 #endif
=20
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -871,15 +868,17 @@ static int __init hugetlbpage_init(void)
=20
 		shift =3D mmu_psize_to_shift(psize);
=20
-		if (add_huge_page_size(1ULL << shift) < 0)
+		if (shift > PGDIR_SHIFT)
 			continue;
-
-		if (shift < PMD_SHIFT)
-			pdshift =3D PMD_SHIFT;
-		else if (shift < PUD_SHIFT)
+		else if (shift > PUD_SHIFT)
+			pdshift =3D PGDIR_SHIFT;
+		else if (shift > PMD_SHIFT)
 			pdshift =3D PUD_SHIFT;
 		else
-			pdshift =3D PGDIR_SHIFT;
+			pdshift =3D PMD_SHIFT;
+
+		if (add_huge_page_size(1ULL << shift) < 0)
+			continue;
 		/*
 		 * if we have pdshift and shift value same, we don't
 		 * use pgt cache for hugepd.
diff --git a/arch/powerpc/platforms/powernv/opal-nvram.c b/arch/powerpc/pla=
tforms/powernv/opal-nvram.c
index acd9f7e96678..b02efba0632a 100644
--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -11,6 +11,7 @@
=20
 #define DEBUG
=20
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
@@ -42,6 +43,10 @@ static ssize_t opal_nvram_read(char *buf, size_t count, =
loff_t *index)
 	return count;
 }
=20
+/*
+ * This can be called in the panic path with interrupts off, so use
+ * mdelay in that case.
+ */
 static ssize_t opal_nvram_write(char *buf, size_t count, loff_t *index)
 {
 	s64 rc =3D OPAL_BUSY;
@@ -55,9 +60,23 @@ static ssize_t opal_nvram_write(char *buf, size_t count,=
 loff_t *index)
=20
 	while (rc =3D=3D OPAL_BUSY || rc =3D=3D OPAL_BUSY_EVENT) {
 		rc =3D opal_write_nvram(__pa(buf), count, off);
-		if (rc =3D=3D OPAL_BUSY_EVENT)
+		if (rc =3D=3D OPAL_BUSY_EVENT) {
+			if (in_interrupt() || irqs_disabled())
+				mdelay(OPAL_BUSY_DELAY_MS);
+			else
+				msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
+		} else if (rc =3D=3D OPAL_BUSY) {
+			if (in_interrupt() || irqs_disabled())
+				mdelay(OPAL_BUSY_DELAY_MS);
+			else
+				msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
+
+	if (rc)
+		return -EIO;
+
 	*index +=3D count;
 	return count;
 }
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index e86bbf105bdb..c6570e1d6763 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -326,7 +326,7 @@ static void hypfs_kill_super(struct super_block *sb)
=20
 	if (sb->s_root)
 		hypfs_delete_tree(sb->s_root);
-	if (sb_info->update_file)
+	if (sb_info && sb_info->update_file)
 		hypfs_remove(sb_info->update_file);
 	kfree(sb->s_fs_info);
 	sb->s_fs_info =3D NULL;
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 57892a8a9055..f2befb3b16a5 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -5,3 +5,4 @@ generic-y +=3D hash.h
 generic-y +=3D mcs_spinlock.h
 generic-y +=3D preempt.h
 generic-y +=3D trace_clock.h
+generic-y +=3D word-at-a-time.h
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 633ca7504536..1b7a9ef45a6d 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -825,6 +825,7 @@ static ssize_t reipl_generic_loadparm_store(struct ipl_=
parameter_block *ipb,
 	/* copy and convert to ebcdic */
 	memcpy(ipb->ipl_info.ccw.load_parm, buf, lp_len);
 	ASCEBC(ipb->ipl_info.ccw.load_parm, LOADPARM_LEN);
+	ipb->hdr.flags |=3D DIAG308_FLAGS_LP_VALID;
 	return len;
 }
=20
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_s=
f.c
index ea0c7b2ef030..d56489d26982 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -744,6 +744,10 @@ static int __hw_perf_event_init(struct perf_event *eve=
nt)
 	 */
 	rate =3D 0;
 	if (attr->freq) {
+		if (!attr->sample_freq) {
+			err =3D -EINVAL;
+			goto out;
+		}
 		rate =3D freq_to_sample_rate(&si, attr->sample_freq);
 		rate =3D hw_limit_rate(&si, rate);
 		attr->freq =3D 0;
diff --git a/arch/score/include/asm/Kbuild b/arch/score/include/asm/Kbuild
index 2f947aba4bd4..b3ef43fc6270 100644
--- a/arch/score/include/asm/Kbuild
+++ b/arch/score/include/asm/Kbuild
@@ -10,3 +10,4 @@ generic-y +=3D mcs_spinlock.h
 generic-y +=3D preempt.h
 generic-y +=3D trace_clock.h
 generic-y +=3D xor.h
+generic-y +=3D word-at-a-time.h
diff --git a/arch/tile/include/asm/Kbuild b/arch/tile/include/asm/Kbuild
index 0aa5675e7025..53b907eadca0 100644
--- a/arch/tile/include/asm/Kbuild
+++ b/arch/tile/include/asm/Kbuild
@@ -40,4 +40,5 @@ generic-y +=3D termbits.h
 generic-y +=3D termios.h
 generic-y +=3D trace_clock.h
 generic-y +=3D types.h
+generic-y +=3D word-at-a-time.h
 generic-y +=3D xor.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index a5e4b6068213..3c5957b85072 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -25,4 +25,5 @@ generic-y +=3D sections.h
 generic-y +=3D switch_to.h
 generic-y +=3D topology.h
 generic-y +=3D trace_clock.h
+generic-y +=3D word-at-a-time.h
 generic-y +=3D xor.h
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 7b605e4dfffa..2ac6a7e5a179 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -135,7 +135,7 @@ static void (*handlers[_NSIG])(int sig, struct siginfo =
*si, mcontext_t *mc) =3D {
=20
 static void hard_handler(int sig, siginfo_t *si, void *p)
 {
-	struct ucontext *uc =3D p;
+	ucontext_t *uc =3D p;
 	mcontext_t *mc =3D &uc->uc_mcontext;
 	unsigned long pending =3D 1UL << sig;
=20
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm=
/Kbuild
index 1e5fb872a4aa..f6d220b71a97 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -62,4 +62,5 @@ generic-y +=3D ucontext.h
 generic-y +=3D unaligned.h
 generic-y +=3D user.h
 generic-y +=3D vga.h
+generic-y +=3D word-at-a-time.h
 generic-y +=3D xor.h
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eb=
oot.c
index cec4d620843e..a1f905ca1c48 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -358,7 +358,8 @@ __setup_efi_pci32(efi_pci_io_protocol_32 *pci, struct p=
ci_setup_rom **__rom)
 	if (status !=3D EFI_SUCCESS)
 		goto free_struct;
=20
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
=20
 free_struct:
@@ -460,7 +461,8 @@ __setup_efi_pci64(efi_pci_io_protocol_64 *pci, struct p=
ci_setup_rom **__rom)
 	if (status !=3D EFI_SUCCESS)
 		goto free_struct;
=20
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
=20
 free_struct:
diff --git a/arch/x86/crypto/cast5_avx_glue.c b/arch/x86/crypto/cast5_avx_g=
lue.c
index 60ada677a928..0fe3365debef 100644
--- a/arch/x86/crypto/cast5_avx_glue.c
+++ b/arch/x86/crypto/cast5_avx_glue.c
@@ -67,8 +67,6 @@ static int ecb_crypt(struct blkcipher_desc *desc, struct =
blkcipher_walk *walk,
 	void (*fn)(struct cast5_ctx *ctx, u8 *dst, const u8 *src);
 	int err;
=20
-	fn =3D (enc) ? cast5_ecb_enc_16way : cast5_ecb_dec_16way;
-
 	err =3D blkcipher_walk_virt(desc, walk);
 	desc->flags &=3D ~CRYPTO_TFM_REQ_MAY_SLEEP;
=20
@@ -80,6 +78,7 @@ static int ecb_crypt(struct blkcipher_desc *desc, struct =
blkcipher_walk *walk,
=20
 		/* Process multi-block batch */
 		if (nbytes >=3D bsize * CAST5_PARALLEL_BLOCKS) {
+			fn =3D (enc) ? cast5_ecb_enc_16way : cast5_ecb_dec_16way;
 			do {
 				fn(ctx, wdst, wsrc);
=20
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index d24018ef197a..d98aa3bb133c 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -288,7 +288,7 @@ struct apic {
=20
 	int (*probe)(void);
 	int (*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
-	int (*apic_id_valid)(int apicid);
+	int (*apic_id_valid)(u32 apicid);
 	int (*apic_id_registered)(void);
=20
 	u32 irq_delivery_mode;
@@ -547,7 +547,7 @@ static inline unsigned int read_apic_id(void)
 	return apic->get_apic_id(reg);
 }
=20
-static inline int default_apic_id_valid(int apicid)
+static inline int default_apic_id_valid(u32 apicid)
 {
 	return (apicid < 255);
 }
diff --git a/arch/x86/include/asm/x2apic.h b/arch/x86/include/asm/x2apic.h
index f90f0a587c66..5ef84234422a 100644
--- a/arch/x86/include/asm/x2apic.h
+++ b/arch/x86/include/asm/x2apic.h
@@ -9,7 +9,7 @@
 #include <asm/ipi.h>
 #include <linux/cpumask.h>
=20
-static int x2apic_apic_id_valid(int apicid)
+static int x2apic_apic_id_valid(u32 apicid)
 {
 	return 1;
 }
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 239cd7913df6..fc4ebc0e3a8f 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -215,7 +215,7 @@ static int __init
 acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long=
 end)
 {
 	struct acpi_madt_local_x2apic *processor =3D NULL;
-	int apic_id;
+	u32 apic_id;
 	u8 enabled;
=20
 	processor =3D (struct acpi_madt_local_x2apic *)header;
@@ -227,6 +227,11 @@ acpi_parse_x2apic(struct acpi_subtable_header *header,=
 const unsigned long end)
=20
 	apic_id =3D processor->local_apic_id;
 	enabled =3D processor->lapic_flags & ACPI_MADT_ENABLED;
+
+	/* Ignore invalid ID */
+	if (apic_id =3D=3D 0xffffffff)
+		return 0;
+
 #ifdef CONFIG_X86_X2APIC
 	/*
 	 * We need to register disabled CPU as well to permit
@@ -235,10 +240,13 @@ acpi_parse_x2apic(struct acpi_subtable_header *header=
, const unsigned long end)
 	 * to not preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
-	if (!apic->apic_id_valid(apic_id) && enabled)
-		printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
-	else
-		acpi_register_lapic(apic_id, enabled);
+	if (!apic->apic_id_valid(apic_id)) {
+		if (enabled)
+			pr_warn(PREFIX "x2apic entry ignored\n");
+		return 0;
+	}
+
+	acpi_register_lapic(apic_id, enabled);
 #else
 	printk(KERN_WARNING PREFIX "x2apic entry ignored\n");
 #endif
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/ap=
ic_numachip.c
index a5b45df8bc88..3aa94cb856a8 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -58,7 +58,7 @@ static unsigned int read_xapic_id(void)
 	return get_apic_id(apic_read(APIC_ID));
 }
=20
-static int numachip_apic_id_valid(int apicid)
+static int numachip_apic_id_valid(u32 apicid)
 {
 	/* Trust what bootloader passes in MADT */
 	return 1;
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2ap=
ic_uv_x.c
index 4bf4b01696f3..d5dd71c4cfdc 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -272,7 +272,7 @@ static void uv_send_IPI_all(int vector)
 	uv_send_IPI_mask(cpu_online_mask, vector);
 }
=20
-static int uv_apic_id_valid(int apicid)
+static int uv_apic_id_valid(u32 apicid)
 {
 	return 1;
 }
diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_ev=
ent.c
index 33f549ccdcf1..8b969708cb5d 100644
--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -25,6 +25,7 @@
 #include <linux/cpu.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/nospec.h>
=20
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
@@ -273,17 +274,20 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct per=
f_event *event)
=20
 	config =3D attr->config;
=20
-	cache_type =3D (config >>  0) & 0xff;
+	cache_type =3D (config >> 0) & 0xff;
 	if (cache_type >=3D PERF_COUNT_HW_CACHE_MAX)
 		return -EINVAL;
+	cache_type =3D array_index_nospec(cache_type, PERF_COUNT_HW_CACHE_MAX);
=20
 	cache_op =3D (config >>  8) & 0xff;
 	if (cache_op >=3D PERF_COUNT_HW_CACHE_OP_MAX)
 		return -EINVAL;
+	cache_op =3D array_index_nospec(cache_op, PERF_COUNT_HW_CACHE_OP_MAX);
=20
 	cache_result =3D (config >> 16) & 0xff;
 	if (cache_result >=3D PERF_COUNT_HW_CACHE_RESULT_MAX)
 		return -EINVAL;
+	cache_result =3D array_index_nospec(cache_result, PERF_COUNT_HW_CACHE_RES=
ULT_MAX);
=20
 	val =3D hw_cache_event_ids[cache_type][cache_op][cache_result];
=20
@@ -319,6 +323,8 @@ int x86_setup_perfctr(struct perf_event *event)
 	if (attr->config >=3D x86_pmu.max_events)
 		return -EINVAL;
=20
+	attr->config =3D array_index_nospec((unsigned long)attr->config, x86_pmu.=
max_events);
+
 	/*
 	 * The generic map:
 	 */
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_k=
exec_32.c
index 1667b1de8d5d..2eef0723b4ed 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -70,12 +70,17 @@ static void load_segments(void)
 static void machine_kexec_free_page_tables(struct kimage *image)
 {
 	free_page((unsigned long)image->arch.pgd);
+	image->arch.pgd =3D NULL;
 #ifdef CONFIG_X86_PAE
 	free_page((unsigned long)image->arch.pmd0);
+	image->arch.pmd0 =3D NULL;
 	free_page((unsigned long)image->arch.pmd1);
+	image->arch.pmd1 =3D NULL;
 #endif
 	free_page((unsigned long)image->arch.pte0);
+	image->arch.pte0 =3D NULL;
 	free_page((unsigned long)image->arch.pte1);
+	image->arch.pte1 =3D NULL;
 }
=20
 static int machine_kexec_alloc_page_tables(struct kimage *image)
@@ -92,7 +97,6 @@ static int machine_kexec_alloc_page_tables(struct kimage =
*image)
 	    !image->arch.pmd0 || !image->arch.pmd1 ||
 #endif
 	    !image->arch.pte0 || !image->arch.pte1) {
-		machine_kexec_free_page_tables(image);
 		return -ENOMEM;
 	}
 	return 0;
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_k=
exec_64.c
index 679cef0791cd..9d4f0beb7989 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -25,8 +25,11 @@
 static void free_transition_pgtable(struct kimage *image)
 {
 	free_page((unsigned long)image->arch.pud);
+	image->arch.pud =3D NULL;
 	free_page((unsigned long)image->arch.pmd);
+	image->arch.pmd =3D NULL;
 	free_page((unsigned long)image->arch.pte);
+	image->arch.pte =3D NULL;
 }
=20
 static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
@@ -67,7 +70,6 @@ static int init_transition_pgtable(struct kimage *image, =
pgd_t *pgd)
 	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC));
 	return 0;
 err:
-	free_transition_pgtable(image);
 	return result;
 }
=20
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 93ffaccb2f48..f59310ac3261 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1397,6 +1397,8 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
=20
+	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD)
+		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 541bb5fc9d7e..2938f198ee79 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -398,7 +398,7 @@ static unsigned long calc_hpet_ref(u64 deltatsc, u64 hp=
et1, u64 hpet2)
 	hpet2 -=3D hpet1;
 	tmp =3D ((u64)hpet2 * hpet_readl(HPET_PERIOD));
 	do_div(tmp, 1000000);
-	do_div(deltatsc, tmp);
+	deltatsc =3D div64_u64(deltatsc, tmp);
=20
 	return (unsigned long) deltatsc;
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6f38c8385aa9..47e5aff3bf04 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6640,7 +6640,7 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_se=
lector, int idt_index,
 }
 EXPORT_SYMBOL_GPL(kvm_task_switch);
=20
-int kvm_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+static int kvm_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 {
 	if ((sregs->efer & EFER_LME) && (sregs->cr0 & X86_CR0_PG)) {
 		/*
@@ -6668,6 +6668,7 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vc=
pu,
 {
 	struct msr_data apic_base_msr;
 	int mmu_reset_needed =3D 0;
+	int cpuid_update_needed =3D 0;
 	int pending_vec, max_bits, idx;
 	struct desc_ptr dt;
=20
@@ -6702,8 +6703,10 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *v=
cpu,
 	vcpu->arch.cr0 =3D sregs->cr0;
=20
 	mmu_reset_needed |=3D kvm_read_cr4(vcpu) !=3D sregs->cr4;
+	cpuid_update_needed |=3D ((kvm_read_cr4(vcpu) ^ sregs->cr4) &
+				X86_CR4_OSXSAVE);
 	kvm_x86_ops->set_cr4(vcpu, sregs->cr4);
-	if (sregs->cr4 & X86_CR4_OSXSAVE)
+	if (cpuid_update_needed)
 		kvm_update_cpuid(vcpu);
=20
 	idx =3D srcu_read_lock(&vcpu->kvm->srcu);
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 167ffcac16ed..c67c7219e9ab 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
+#include <linux/highmem.h>
=20
 #include <asm/pgtable.h>
=20
@@ -263,15 +264,16 @@ static void walk_pte_level(struct seq_file *m, struct=
 pg_state *st, pmd_t addr,
 							unsigned long P)
 {
 	int i;
-	pte_t *start;
+	pte_t *pte;
=20
-	start =3D (pte_t *) pmd_page_vaddr(addr);
 	for (i =3D 0; i < PTRS_PER_PTE; i++) {
-		pgprot_t prot =3D pte_pgprot(*start);
+		pgprot_t prot;
=20
 		st->current_address =3D normalize_addr(P + i * PTE_LEVEL_MULT);
+		pte =3D pte_offset_map(&addr, st->current_address);
+		prot =3D pte_pgprot(*pte);
 		note_page(m, st, prot, 4);
-		start++;
+		pte_unmap(pte);
 	}
 }
=20
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index cde88080969b..1c1eefa34f8b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -914,6 +914,7 @@ void bpf_int_jit_compile(struct sk_filter *prog)
 	for (pass =3D 0; pass < 10 || image; pass++) {
 		proglen =3D do_jit(prog, addrs, image, oldproglen, &ctx);
 		if (proglen <=3D 0) {
+out_image:
 			image =3D NULL;
 			if (header)
 				module_free(NULL, header);
@@ -923,7 +924,7 @@ void bpf_int_jit_compile(struct sk_filter *prog)
 			if (proglen !=3D oldproglen) {
 				pr_err("bpf_jit: proglen=3D%d !=3D oldproglen=3D%d\n",
 				       proglen, oldproglen);
-				goto out;
+				goto out_image;
 			}
 			break;
 		}
diff --git a/arch/x86/um/stub_segv.c b/arch/x86/um/stub_segv.c
index 1518d2805ae8..fd6825537b97 100644
--- a/arch/x86/um/stub_segv.c
+++ b/arch/x86/um/stub_segv.c
@@ -10,7 +10,7 @@
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig, siginfo_t *info, void *p)
 {
-	struct ucontext *uc =3D p;
+	ucontext_t *uc =3D p;
=20
 	GET_FAULTINFO_FROM_MC(*((struct faultinfo *) STUB_DATA),
 			      &uc->uc_mcontext);
diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index 85003e57b1a3..6ecb05699952 100644
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -1283,8 +1283,6 @@ void xen_flush_tlb_all(void)
 	struct mmuext_op *op;
 	struct multicall_space mcs;
=20
-	trace_xen_mmu_flush_tlb_all(0);
-
 	preempt_disable();
=20
 	mcs =3D xen_mc_entry(sizeof(*op));
@@ -1297,13 +1295,11 @@ void xen_flush_tlb_all(void)
=20
 	preempt_enable();
 }
-static void xen_flush_tlb(void)
+static noinline void xen_flush_tlb(void)
 {
 	struct mmuext_op *op;
 	struct multicall_space mcs;
=20
-	trace_xen_mmu_flush_tlb(0);
-
 	preempt_disable();
=20
 	mcs =3D xen_mc_entry(sizeof(*op));
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index c3d20ba6eb86..98d092cc2c17 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -29,4 +29,5 @@ generic-y +=3D statfs.h
 generic-y +=3D termios.h
 generic-y +=3D topology.h
 generic-y +=3D trace_clock.h
+generic-y +=3D word-at-a-time.h
 generic-y +=3D xor.h
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 9821a116047e..7f06df512f24 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -157,16 +157,16 @@ static int alg_bind(struct socket *sock, struct socka=
ddr *uaddr, int addr_len)
 	void *private;
 	int err;
=20
-	/* If caller uses non-allowed flag, return error. */
-	if ((sa->salg_feat & ~allowed) || (sa->salg_mask & ~allowed))
-		return -EINVAL;
-
 	if (sock->state =3D=3D SS_CONNECTED)
 		return -EINVAL;
=20
 	if (addr_len !=3D sizeof(*sa))
 		return -EINVAL;
=20
+	/* If caller uses non-allowed flag, return error. */
+	if ((sa->salg_feat & ~allowed) || (sa->salg_mask & ~allowed))
+		return -EINVAL;
+
 	sa->salg_type[sizeof(sa->salg_type) - 1] =3D 0;
 	sa->salg_name[sizeof(sa->salg_name) - 1] =3D 0;
=20
diff --git a/crypto/ahash.c b/crypto/ahash.c
index d5f9c1586c42..8ed4d42f9de5 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -90,13 +90,14 @@ int crypto_hash_walk_done(struct crypto_hash_walk *walk=
, int err)
=20
 	if (nbytes && walk->offset & alignmask && !err) {
 		walk->offset =3D ALIGN(walk->offset, alignmask + 1);
-		walk->data +=3D walk->offset;
-
 		nbytes =3D min(nbytes,
 			     ((unsigned int)(PAGE_SIZE)) - walk->offset);
 		walk->entrylen -=3D nbytes;
=20
-		return nbytes;
+		if (nbytes) {
+			walk->data +=3D walk->offset;
+			return nbytes;
+		}
 	}
=20
 	if (walk->flags & CRYPTO_ALG_ASYNC)
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index bc4ff68c9816..61017659621b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -316,6 +316,7 @@ static const struct pci_device_id ahci_pci_tbl[] =3D {
 	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci }, /* Lynx Point-LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci }, /* Lynx Point-LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci }, /* Lynx Point-LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci }, /* Cannon Lake PCH-LP AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f22), board_ahci }, /* Avoton AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f23), board_ahci }, /* Avoton AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f24), board_ahci }, /* Avoton RAID */
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d5fb981acec9..ebe2c296bd92 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4187,6 +4187,10 @@ static const struct ata_blacklist_entry ata_device_b=
lacklist [] =3D {
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=3D15573 */
 	{ "C300-CTFDDAC128MAG",	"0001",		ATA_HORKAGE_NONCQ, },
=20
+	/* Some Sandisk SSDs lock up hard with NCQ enabled.  Reported on
+	   SD7SN6S256G and SD8SN8U256G */
+	{ "SanDisk SD[78]SN*G",	NULL,		ATA_HORKAGE_NONCQ, },
+
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
 	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_HORKAGE_BROKEN_HPA },
@@ -4239,7 +4243,11 @@ static const struct ata_blacklist_entry ata_device_b=
lacklist [] =3D {
 	{ "Crucial_CT960M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_NOLPM, },
=20
+	/* Sandisk devices which are known to not handle LPM well */
+	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle queued TRIM commands */
+	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM, },
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
 	{ "Crucial_CT*M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
 	{ "Micron_M5[15]0_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM, },
diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index 969c3c29000c..377d52976ddd 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -28,6 +28,7 @@
 #include <asm/io.h>
 #include <linux/atomic.h>
 #include <asm/uaccess.h>
+#include <linux/nospec.h>
=20
 #include "uPD98401.h"
 #include "uPD98402.h"
@@ -1455,6 +1456,8 @@ static int zatm_ioctl(struct atm_dev *dev,unsigned in=
t cmd,void __user *arg)
 					return -EFAULT;
 				if (pool < 0 || pool > ZATM_LAST_POOL)
 					return -EINVAL;
+				pool =3D array_index_nospec(pool,
+							  ZATM_LAST_POOL + 1);
 				spin_lock_irqsave(&zatm_dev->lock, flags);
 				info =3D zatm_dev->pool_info[pool];
 				if (cmd =3D=3D ZATM_GETPOOLZ) {
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 27487c289ee0..85ad29f2b718 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -144,7 +144,7 @@ static bool regmap_volatile_range(struct regmap *map, u=
nsigned int reg,
 	unsigned int i;
=20
 	for (i =3D 0; i < num; i++)
-		if (!regmap_volatile(map, reg + i))
+		if (!regmap_volatile(map, reg + (i * map->reg_stride)))
 			return false;
=20
 	return true;
@@ -2240,13 +2240,31 @@ int regmap_bulk_read(struct regmap *map, unsigned i=
nt reg, void *val,
 		for (i =3D 0; i < val_count * val_bytes; i +=3D val_bytes)
 			map->format.parse_inplace(val + i);
 	} else {
+		u32 *u32 =3D val;
+		u16 *u16 =3D val;
+		u8 *u8 =3D val;
+
 		for (i =3D 0; i < val_count; i++) {
 			unsigned int ival;
+
 			ret =3D regmap_read(map, reg + (i * map->reg_stride),
 					  &ival);
 			if (ret !=3D 0)
 				return ret;
-			map->format.format_val(val + (i * val_bytes), ival, 0);
+
+			switch (map->format.val_bytes) {
+			case 4:
+				u32[i] =3D ival;
+				break;
+			case 2:
+				u16[i] =3D ival;
+				break;
+			case 1:
+				u8[i] =3D ival;
+				break;
+			default:
+				return -EINVAL;
+			}
 		}
 	}
=20
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 94be503e236b..00448863f981 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -417,7 +417,7 @@ static void reclaim_dma_bufs(void)
 	}
 }
=20
-static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
+static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t bu=
f_size,
 				     int pages)
 {
 	struct port_buffer *buf;
@@ -440,7 +440,7 @@ static struct port_buffer *alloc_buf(struct virtqueue *=
vq, size_t buf_size,
 		return buf;
 	}
=20
-	if (is_rproc_serial(vq->vdev)) {
+	if (is_rproc_serial(vdev)) {
 		/*
 		 * Allocate DMA memory from ancestor. When a virtio
 		 * device is created by remoteproc, the DMA memory is
@@ -450,9 +450,9 @@ static struct port_buffer *alloc_buf(struct virtqueue *=
vq, size_t buf_size,
 		 * DMA_MEMORY_INCLUDES_CHILDREN had been supported
 		 * in dma-coherent.c
 		 */
-		if (!vq->vdev->dev.parent || !vq->vdev->dev.parent->parent)
+		if (!vdev->dev.parent || !vdev->dev.parent->parent)
 			goto free_buf;
-		buf->dev =3D vq->vdev->dev.parent->parent;
+		buf->dev =3D vdev->dev.parent->parent;
=20
 		/* Increase device refcnt to avoid freeing it */
 		get_device(buf->dev);
@@ -834,7 +834,7 @@ static ssize_t port_fops_write(struct file *filp, const=
 char __user *ubuf,
=20
 	count =3D min((size_t)(32 * 1024), count);
=20
-	buf =3D alloc_buf(port->out_vq, count, 0);
+	buf =3D alloc_buf(port->portdev->vdev, count, 0);
 	if (!buf)
 		return -ENOMEM;
=20
@@ -953,7 +953,7 @@ static ssize_t port_fops_splice_write(struct pipe_inode=
_info *pipe,
 	if (ret < 0)
 		goto error_out;
=20
-	buf =3D alloc_buf(port->out_vq, 0, pipe->nrbufs);
+	buf =3D alloc_buf(port->portdev->vdev, 0, pipe->nrbufs);
 	if (!buf) {
 		ret =3D -ENOMEM;
 		goto error_out;
@@ -1370,7 +1370,7 @@ static unsigned int fill_queue(struct virtqueue *vq, =
spinlock_t *lock)
=20
 	nr_added_bufs =3D 0;
 	do {
-		buf =3D alloc_buf(vq, PAGE_SIZE, 0);
+		buf =3D alloc_buf(vq->vdev, PAGE_SIZE, 0);
 		if (!buf)
 			break;
=20
@@ -1398,7 +1398,6 @@ static int add_port(struct ports_device *portdev, u32=
 id)
 {
 	char debugfs_name[16];
 	struct port *port;
-	struct port_buffer *buf;
 	dev_t devt;
 	unsigned int nr_added_bufs;
 	int err;
@@ -1509,8 +1508,6 @@ static int add_port(struct ports_device *portdev, u32=
 id)
 	return 0;
=20
 free_inbufs:
-	while ((buf =3D virtqueue_detach_unused_buf(port->in_vq)))
-		free_buf(buf, true);
 free_device:
 	device_destroy(pdrvdata.class, port->dev->devt);
 free_cdev:
@@ -1535,34 +1532,14 @@ static void remove_port(struct kref *kref)
=20
 static void remove_port_data(struct port *port)
 {
-	struct port_buffer *buf;
-
 	spin_lock_irq(&port->inbuf_lock);
 	/* Remove unused data this port might have received. */
 	discard_port_data(port);
 	spin_unlock_irq(&port->inbuf_lock);
=20
-	/* Remove buffers we queued up for the Host to send us data in. */
-	do {
-		spin_lock_irq(&port->inbuf_lock);
-		buf =3D virtqueue_detach_unused_buf(port->in_vq);
-		spin_unlock_irq(&port->inbuf_lock);
-		if (buf)
-			free_buf(buf, true);
-	} while (buf);
-
 	spin_lock_irq(&port->outvq_lock);
 	reclaim_consumed_buffers(port);
 	spin_unlock_irq(&port->outvq_lock);
-
-	/* Free pending buffers from the out-queue. */
-	do {
-		spin_lock_irq(&port->outvq_lock);
-		buf =3D virtqueue_detach_unused_buf(port->out_vq);
-		spin_unlock_irq(&port->outvq_lock);
-		if (buf)
-			free_buf(buf, true);
-	} while (buf);
 }
=20
 /*
@@ -1783,13 +1760,24 @@ static void control_work_handler(struct work_struct=
 *work)
 	spin_unlock(&portdev->c_ivq_lock);
 }
=20
+static void flush_bufs(struct virtqueue *vq, bool can_sleep)
+{
+	struct port_buffer *buf;
+	unsigned int len;
+
+	while ((buf =3D virtqueue_get_buf(vq, &len)))
+		free_buf(buf, can_sleep);
+}
+
 static void out_intr(struct virtqueue *vq)
 {
 	struct port *port;
=20
 	port =3D find_port_by_vq(vq->vdev->priv, vq);
-	if (!port)
+	if (!port) {
+		flush_bufs(vq, false);
 		return;
+	}
=20
 	wake_up_interruptible(&port->waitqueue);
 }
@@ -1800,8 +1788,10 @@ static void in_intr(struct virtqueue *vq)
 	unsigned long flags;
=20
 	port =3D find_port_by_vq(vq->vdev->priv, vq);
-	if (!port)
+	if (!port) {
+		flush_bufs(vq, false);
 		return;
+	}
=20
 	spin_lock_irqsave(&port->inbuf_lock, flags);
 	port->inbuf =3D get_inbuf(port);
@@ -1976,24 +1966,54 @@ static const struct file_operations portdev_fops =
=3D {
=20
 static void remove_vqs(struct ports_device *portdev)
 {
+	struct virtqueue *vq;
+
+	virtio_device_for_each_vq(portdev->vdev, vq) {
+		struct port_buffer *buf;
+
+		flush_bufs(vq, true);
+		while ((buf =3D virtqueue_detach_unused_buf(vq)))
+			free_buf(buf, true);
+	}
 	portdev->vdev->config->del_vqs(portdev->vdev);
 	kfree(portdev->in_vqs);
 	kfree(portdev->out_vqs);
 }
=20
-static void remove_controlq_data(struct ports_device *portdev)
+static void virtcons_remove(struct virtio_device *vdev)
 {
-	struct port_buffer *buf;
-	unsigned int len;
+	struct ports_device *portdev;
+	struct port *port, *port2;
=20
-	if (!use_multiport(portdev))
-		return;
+	portdev =3D vdev->priv;
=20
-	while ((buf =3D virtqueue_get_buf(portdev->c_ivq, &len)))
-		free_buf(buf, true);
+	spin_lock_irq(&pdrvdata_lock);
+	list_del(&portdev->list);
+	spin_unlock_irq(&pdrvdata_lock);
=20
-	while ((buf =3D virtqueue_detach_unused_buf(portdev->c_ivq)))
-		free_buf(buf, true);
+	/* Disable interrupts for vqs */
+	vdev->config->reset(vdev);
+	/* Finish up work that's lined up */
+	if (use_multiport(portdev))
+		cancel_work_sync(&portdev->control_work);
+	else
+		cancel_work_sync(&portdev->config_work);
+
+	list_for_each_entry_safe(port, port2, &portdev->ports, list)
+		unplug_port(port);
+
+	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
+
+	/*
+	 * When yanking out a device, we immediately lose the
+	 * (device-side) queues.  So there's no point in keeping the
+	 * guest side around till we drop our final reference.  This
+	 * also means that any ports which are in an open state will
+	 * have to just stop using the port, as the vqs are going
+	 * away.
+	 */
+	remove_vqs(portdev);
+	kfree(portdev);
 }
=20
 /*
@@ -2053,6 +2073,7 @@ static int virtcons_probe(struct virtio_device *vdev)
=20
 	spin_lock_init(&portdev->ports_lock);
 	INIT_LIST_HEAD(&portdev->ports);
+	INIT_LIST_HEAD(&portdev->list);
=20
 	INIT_WORK(&portdev->config_work, &config_work_handler);
 	INIT_WORK(&portdev->control_work, &control_work_handler);
@@ -2068,8 +2089,15 @@ static int virtcons_probe(struct virtio_device *vdev)
 		if (!nr_added_bufs) {
 			dev_err(&vdev->dev,
 				"Error allocating buffers for control queue\n");
-			err =3D -ENOMEM;
-			goto free_vqs;
+			/*
+			 * The host might want to notify mgmt sw about device
+			 * add failure.
+			 */
+			__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
+					   VIRTIO_CONSOLE_DEVICE_READY, 0);
+			/* Device was functional: we need full cleanup. */
+			virtcons_remove(vdev);
+			return -ENOMEM;
 		}
 	} else {
 		/*
@@ -2100,11 +2128,6 @@ static int virtcons_probe(struct virtio_device *vdev)
=20
 	return 0;
=20
-free_vqs:
-	/* The host might want to notify mgmt sw about device add failure */
-	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
-			   VIRTIO_CONSOLE_DEVICE_READY, 0);
-	remove_vqs(portdev);
 free_chrdev:
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 free:
@@ -2113,43 +2136,6 @@ static int virtcons_probe(struct virtio_device *vdev)
 	return err;
 }
=20
-static void virtcons_remove(struct virtio_device *vdev)
-{
-	struct ports_device *portdev;
-	struct port *port, *port2;
-
-	portdev =3D vdev->priv;
-
-	spin_lock_irq(&pdrvdata_lock);
-	list_del(&portdev->list);
-	spin_unlock_irq(&pdrvdata_lock);
-
-	/* Disable interrupts for vqs */
-	vdev->config->reset(vdev);
-	/* Finish up work that's lined up */
-	if (use_multiport(portdev))
-		cancel_work_sync(&portdev->control_work);
-	else
-		cancel_work_sync(&portdev->config_work);
-
-	list_for_each_entry_safe(port, port2, &portdev->ports, list)
-		unplug_port(port);
-
-	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
-
-	/*
-	 * When yanking out a device, we immediately lose the
-	 * (device-side) queues.  So there's no point in keeping the
-	 * guest side around till we drop our final reference.  This
-	 * also means that any ports which are in an open state will
-	 * have to just stop using the port, as the vqs are going
-	 * away.
-	 */
-	remove_controlq_data(portdev);
-	remove_vqs(portdev);
-	kfree(portdev);
-}
-
 static struct virtio_device_id id_table[] =3D {
 	{ VIRTIO_ID_CONSOLE, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -2190,7 +2176,6 @@ static int virtcons_freeze(struct virtio_device *vdev)
 	 */
 	if (use_multiport(portdev))
 		virtqueue_disable_cb(portdev->c_ivq);
-	remove_controlq_data(portdev);
=20
 	list_for_each_entry(port, &portdev->ports, list) {
 		virtqueue_disable_cb(port->in_vq);
diff --git a/drivers/gpu/drm/drm_fops.c b/drivers/gpu/drm/drm_fops.c
index 394bdc6617c7..45e85609fd7e 100644
--- a/drivers/gpu/drm/drm_fops.c
+++ b/drivers/gpu/drm/drm_fops.c
@@ -251,6 +251,7 @@ static int drm_open_helper(struct file *filp, struct dr=
m_minor *minor)
 		return -ENOMEM;
=20
 	filp->private_data =3D priv;
+	filp->f_mode |=3D FMODE_UNSIGNED_OFFSET;
 	priv->filp =3D filp;
 	priv->uid =3D current_euid();
 	priv->pid =3D get_pid(task_pid(current));
diff --git a/drivers/gpu/drm/i915/i915_cmd_parser.c b/drivers/gpu/drm/i915/=
i915_cmd_parser.c
index fa9764a2e080..df9512ef1280 100644
--- a/drivers/gpu/drm/i915/i915_cmd_parser.c
+++ b/drivers/gpu/drm/i915/i915_cmd_parser.c
@@ -123,7 +123,7 @@ static const struct drm_i915_cmd_descriptor common_cmds=
[] =3D {
 	CMD(  MI_SEMAPHORE_MBOX,                SMI,   !F,  0xFF,   R  ),
 	CMD(  MI_STORE_DWORD_INDEX,             SMI,   !F,  0xFF,   R  ),
 	CMD(  MI_LOAD_REGISTER_IMM(1),          SMI,   !F,  0xFF,   W,
-	      .reg =3D { .offset =3D 1, .mask =3D 0x007FFFFC }               ),
+	      .reg =3D { .offset =3D 1, .mask =3D 0x007FFFFC, .step =3D 2 }    ),
 	CMD(  MI_STORE_REGISTER_MEM(1),         SMI,   !F,  0xFF,   W | B,
 	      .reg =3D { .offset =3D 1, .mask =3D 0x007FFFFC },
 	      .bits =3D {{
@@ -859,7 +859,7 @@ bool i915_needs_cmd_parser(struct intel_engine_cs *ring)
=20
 static bool check_cmd(const struct intel_engine_cs *ring,
 		      const struct drm_i915_cmd_descriptor *desc,
-		      const u32 *cmd,
+		      const u32 *cmd, u32 length,
 		      const bool is_master,
 		      bool *oacontrol_set)
 {
@@ -875,36 +875,49 @@ static bool check_cmd(const struct intel_engine_cs *r=
ing,
 	}
=20
 	if (desc->flags & CMD_DESC_REGISTER) {
-		u32 reg_addr =3D cmd[desc->reg.offset] & desc->reg.mask;
-
 		/*
-		 * OACONTROL requires some special handling for writes. We
-		 * want to make sure that any batch which enables OA also
-		 * disables it before the end of the batch. The goal is to
-		 * prevent one process from snooping on the perf data from
-		 * another process. To do that, we need to check the value
-		 * that will be written to the register. Hence, limit
-		 * OACONTROL writes to only MI_LOAD_REGISTER_IMM commands.
+		 * Get the distance between individual register offset
+		 * fields if the command can perform more than one
+		 * access at a time.
 		 */
-		if (reg_addr =3D=3D OACONTROL) {
-			if (desc->cmd.value =3D=3D MI_LOAD_REGISTER_MEM)
-				return false;
-
-			if (desc->cmd.value =3D=3D MI_LOAD_REGISTER_IMM(1))
-				*oacontrol_set =3D (cmd[2] !=3D 0);
-		}
+		const u32 step =3D desc->reg.step ? desc->reg.step : length;
+		u32 offset;
+
+		for (offset =3D desc->reg.offset; offset < length;
+		     offset +=3D step) {
+			const u32 reg_addr =3D cmd[offset] & desc->reg.mask;
+
+			/*
+			 * OACONTROL requires some special handling for
+			 * writes. We want to make sure that any batch which
+			 * enables OA also disables it before the end of the
+			 * batch. The goal is to prevent one process from
+			 * snooping on the perf data from another process. To do
+			 * that, we need to check the value that will be written
+			 * to the register. Hence, limit OACONTROL writes to
+			 * only MI_LOAD_REGISTER_IMM commands.
+			 */
+			if (reg_addr =3D=3D OACONTROL) {
+				if (desc->cmd.value =3D=3D MI_LOAD_REGISTER_MEM) {
+					DRM_DEBUG_DRIVER("CMD: Rejected LRM to OACONTROL\n");
+					return false;
+				}
+
+				if (desc->cmd.value =3D=3D MI_LOAD_REGISTER_IMM(1))
+					*oacontrol_set =3D (cmd[offset + 1] !=3D 0);
+			}
=20
-		if (!valid_reg(ring->reg_table,
-			       ring->reg_count, reg_addr)) {
-			if (!is_master ||
-			    !valid_reg(ring->master_reg_table,
-				       ring->master_reg_count,
-				       reg_addr)) {
-				DRM_DEBUG_DRIVER("CMD: Rejected register 0x%08X in command: 0x%08X (ri=
ng=3D%d)\n",
-						 reg_addr,
-						 *cmd,
-						 ring->id);
-				return false;
+			if (!valid_reg(ring->reg_table,
+				       ring->reg_count, reg_addr)) {
+				if (!is_master ||
+				    !valid_reg(ring->master_reg_table,
+					       ring->master_reg_count,
+					       reg_addr)) {
+					DRM_DEBUG_DRIVER("CMD: Rejected register 0x%08X in command: 0x%08X (r=
ing=3D%d)\n",
+							 reg_addr, *cmd,
+							 ring->id);
+					return false;
+				}
 			}
 		}
 	}
@@ -928,6 +941,12 @@ static bool check_cmd(const struct intel_engine_cs *ri=
ng,
 					continue;
 			}
=20
+			if (desc->bits[i].offset >=3D length) {
+				DRM_DEBUG_DRIVER("CMD: Rejected command 0x%08X, too short to check bit=
mask (ring=3D%d)\n",
+						 *cmd, ring->id);
+				return false;
+			}
+
 			dword =3D cmd[desc->bits[i].offset] &
 				desc->bits[i].mask;
=20
@@ -1018,7 +1037,8 @@ int i915_parse_cmds(struct intel_engine_cs *ring,
 			break;
 		}
=20
-		if (!check_cmd(ring, desc, cmd, is_master, &oacontrol_set)) {
+		if (!check_cmd(ring, desc, cmd, length, is_master,
+			       &oacontrol_set)) {
 			ret =3D -EINVAL;
 			break;
 		}
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_dr=
v.h
index 1378dadc618e..7d9ceaa9ab01 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1828,10 +1828,15 @@ struct drm_i915_cmd_descriptor {
 	 * Describes where to find a register address in the command to check
 	 * against the ring's register whitelist. Only valid if flags has the
 	 * CMD_DESC_REGISTER bit set.
+	 *
+	 * A non-zero step value implies that the command may access multiple
+	 * registers in sequence (e.g. LRI), in that case step gives the
+	 * distance in dwords between individual offset fields.
 	 */
 	struct {
 		u32 offset;
 		u32 mask;
+		u32 step;
 	} reg;
=20
 #define MAX_CMD_DESC_BITMASKS 3
diff --git a/drivers/gpu/drm/i915/i915_gem_userptr.c b/drivers/gpu/drm/i915=
/i915_gem_userptr.c
index 3ac65a3c7124..ff290fc691c8 100644
--- a/drivers/gpu/drm/i915/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/i915_gem_userptr.c
@@ -657,6 +657,9 @@ i915_gem_userptr_ioctl(struct drm_device *dev, void *da=
ta, struct drm_file *file
 			    I915_USERPTR_UNSYNCHRONIZED))
 		return -EINVAL;
=20
+	if (!args->user_size)
+		return -EINVAL;
+
 	if (offset_in_page(args->user_ptr | args->user_size))
 		return -EINVAL;
=20
diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel=
_hdmi.c
index 057366453d27..86377d339144 100644
--- a/drivers/gpu/drm/i915/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/intel_hdmi.c
@@ -971,6 +971,7 @@ intel_hdmi_detect(struct drm_connector *connector, bool=
 force)
 	struct edid *edid;
 	enum intel_display_power_domain power_domain;
 	enum drm_connector_status status =3D connector_status_disconnected;
+	struct i2c_adapter *i2c;
=20
 	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
 		      connector->base.id, connector->name);
@@ -981,9 +982,16 @@ intel_hdmi_detect(struct drm_connector *connector, boo=
l force)
 	intel_hdmi->has_hdmi_sink =3D false;
 	intel_hdmi->has_audio =3D false;
 	intel_hdmi->rgb_quant_range_selectable =3D false;
-	edid =3D drm_get_edid(connector,
-			    intel_gmbus_get_adapter(dev_priv,
-						    intel_hdmi->ddc_bus));
+	i2c =3D intel_gmbus_get_adapter(dev_priv, intel_hdmi->ddc_bus);
+
+	edid =3D drm_get_edid(connector, i2c);
+
+	if (!edid && !intel_gmbus_is_forced_bit(i2c)) {
+		DRM_DEBUG_KMS("HDMI GMBUS EDID read failed, retry using GPIO bit-banging=
\n");
+		intel_gmbus_force_bit(i2c, true);
+		edid =3D drm_get_edid(connector, i2c);
+		intel_gmbus_force_bit(i2c, false);
+	}
=20
 	if (edid) {
 		if (edid->input & DRM_EDID_INPUT_DIGITAL) {
diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel=
_lvds.c
index 2ec2d77e3393..1ec6b87c01bf 100644
--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -219,7 +219,8 @@ static void intel_enable_lvds(struct intel_encoder *enc=
oder)
=20
 	I915_WRITE(ctl_reg, I915_READ(ctl_reg) | POWER_TARGET_ON);
 	POSTING_READ(lvds_encoder->reg);
-	if (wait_for((I915_READ(stat_reg) & PP_ON) !=3D 0, 1000))
+
+	if (wait_for((I915_READ(stat_reg) & PP_ON) !=3D 0, 5000))
 		DRM_ERROR("timed out waiting for panel to power on\n");
=20
 	intel_panel_enable_backlight(intel_connector);
@@ -738,6 +739,14 @@ static const struct dmi_system_id intel_no_lvds[] =3D {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "D525MW"),
 		},
 	},
+	{
+		.callback =3D intel_no_lvds_dmi_callback,
+		.ident =3D "Radiant P845",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Radiant Systems Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P845"),
+		},
+	},
=20
 	{ }	/* terminating entry */
 };
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index f611b079a360..ef6dd28504ce 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -83,14 +83,17 @@ static struct page **get_pages(struct drm_gem_object *o=
bj)
 			return p;
 		}
=20
+		msm_obj->pages =3D p;
+
 		msm_obj->sgt =3D drm_prime_pages_to_sg(p, npages);
 		if (IS_ERR(msm_obj->sgt)) {
+			void *ptr =3D ERR_CAST(msm_obj->sgt);
+
 			dev_err(dev->dev, "failed to allocate sgt\n");
-			return ERR_CAST(msm_obj->sgt);
+			msm_obj->sgt =3D NULL;
+			return ptr;
 		}
=20
-		msm_obj->pages =3D p;
-
 		/* For non-cached buffers, ensure the new pages are clean
 		 * because display controller, GPU, etc. are not coherent:
 		 */
@@ -107,14 +110,19 @@ static void put_pages(struct drm_gem_object *obj)
 	struct msm_gem_object *msm_obj =3D to_msm_bo(obj);
=20
 	if (msm_obj->pages) {
-		/* For non-cached buffers, ensure the new pages are clean
-		 * because display controller, GPU, etc. are not coherent:
-		 */
-		if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
-			dma_unmap_sg(obj->dev->dev, msm_obj->sgt->sgl,
-					msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
-		sg_free_table(msm_obj->sgt);
-		kfree(msm_obj->sgt);
+		if (msm_obj->sgt) {
+			/* For non-cached buffers, ensure the new
+			 * pages are clean because display controller,
+			 * GPU, etc. are not coherent:
+			 */
+			if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
+				dma_unmap_sg(obj->dev->dev, msm_obj->sgt->sgl,
+					     msm_obj->sgt->nents,
+					     DMA_BIDIRECTIONAL);
+
+			sg_free_table(msm_obj->sgt);
+			kfree(msm_obj->sgt);
+		}
=20
 		if (iommu_present(&platform_bus_type))
 			drm_gem_put_pages(obj, msm_obj->pages, true, false);
diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeo=
n/radeon_device.c
index edff18760031..ed631fc6d0c7 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -105,7 +105,6 @@ static const char radeon_family_name[][16] =3D {
 };
=20
 #define RADEON_PX_QUIRK_DISABLE_PX  (1 << 0)
-#define RADEON_PX_QUIRK_LONG_WAKEUP (1 << 1)
=20
 struct radeon_px_quirk {
 	u32 chip_vendor;
@@ -132,8 +131,10 @@ static struct radeon_px_quirk radeon_px_quirk_list[] =
=3D {
 	 * https://bugs.freedesktop.org/show_bug.cgi?id=3D101491
 	 */
 	{ PCI_VENDOR_ID_ATI, 0x6741, 0x1043, 0x2122, RADEON_PX_QUIRK_DISABLE_PX },
-	/* macbook pro 8.2 */
-	{ PCI_VENDOR_ID_ATI, 0x6741, PCI_VENDOR_ID_APPLE, 0x00e2, RADEON_PX_QUIRK=
_LONG_WAKEUP },
+	/* Asus K73TK laptop with AMD A6-3420M APU and Radeon 7670m GPU
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=3D51381#c52
+	 */
+	{ PCI_VENDOR_ID_ATI, 0x6840, 0x1043, 0x2123, RADEON_PX_QUIRK_DISABLE_PX },
 	{ 0, 0, 0, 0, 0 },
 };
=20
@@ -1180,25 +1181,17 @@ static void radeon_check_arguments(struct radeon_de=
vice *rdev)
 static void radeon_switcheroo_set_state(struct pci_dev *pdev, enum vga_swi=
tcheroo_state state)
 {
 	struct drm_device *dev =3D pci_get_drvdata(pdev);
-	struct radeon_device *rdev =3D dev->dev_private;
=20
 	if (radeon_is_px(dev) && state =3D=3D VGA_SWITCHEROO_OFF)
 		return;
=20
 	if (state =3D=3D VGA_SWITCHEROO_ON) {
-		unsigned d3_delay =3D dev->pdev->d3_delay;
-
 		printk(KERN_INFO "radeon: switched on\n");
 		/* don't suspend or resume card normally */
 		dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;
=20
-		if (d3_delay < 20 && (rdev->px_quirk_flags & RADEON_PX_QUIRK_LONG_WAKEUP=
))
-			dev->pdev->d3_delay =3D 20;
-
 		radeon_resume_kms(dev, true, true);
=20
-		dev->pdev->d3_delay =3D d3_delay;
-
 		dev->switch_power_state =3D DRM_SWITCH_POWER_ON;
 		drm_kms_helper_poll_enable(dev);
 	} else {
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dp=
m.c
index b5ef48fdef14..80f659d109f9 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -5828,9 +5828,9 @@ static void si_set_pcie_lane_width_in_smc(struct rade=
on_device *rdev,
 {
 	u32 lane_width;
 	u32 new_lane_width =3D
-		(radeon_new_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLIB=
_PCIE_LINK_WIDTH_SHIFT;
+		((radeon_new_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_PPLI=
B_PCIE_LINK_WIDTH_SHIFT) + 1;
 	u32 current_lane_width =3D
-		(radeon_current_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_P=
PLIB_PCIE_LINK_WIDTH_SHIFT;
+		((radeon_current_state->caps & ATOM_PPLIB_PCIE_LINK_WIDTH_MASK) >> ATOM_=
PPLIB_PCIE_LINK_WIDTH_SHIFT) + 1;
=20
 	if (new_lane_width !=3D current_lane_width) {
 		radeon_set_pcie_lanes(rdev, new_lane_width);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c b/drivers/gpu/drm/rc=
ar-du/rcar_du_lvdsenc.c
index df30a075d793..4bc3c467642e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c
@@ -87,10 +87,8 @@ static int rcar_du_lvdsenc_start(struct rcar_du_lvdsenc =
*lvds,
=20
 	rcar_lvds_write(lvds, LVDCHCR, lvdhcr);
=20
-	/* Select the input, hardcode mode 0, enable LVDS operation and turn
-	 * bias circuitry on.
-	 */
-	lvdcr0 =3D LVDCR0_BEN | LVDCR0_LVEN;
+	/* Select the input and set the LVDS mode. */
+	lvdcr0 =3D 0;
 	if (rcrtc->index =3D=3D 2)
 		lvdcr0 |=3D LVDCR0_DUSEL;
 	rcar_lvds_write(lvds, LVDCR0, lvdcr0);
@@ -99,6 +97,10 @@ static int rcar_du_lvdsenc_start(struct rcar_du_lvdsenc =
*lvds,
 	rcar_lvds_write(lvds, LVDCR1, LVDCR1_CHSTBY(3) | LVDCR1_CHSTBY(2) |
 			LVDCR1_CHSTBY(1) | LVDCR1_CHSTBY(0) | LVDCR1_CLKSTBY);
=20
+	/* Enable LVDS operation and turn bias circuitry on. */
+	lvdcr0 |=3D LVDCR0_BEN | LVDCR0_LVEN;
+	rcar_lvds_write(lvds, LVDCR0, lvdcr0);
+
 	/* Turn the PLL on, wait for the startup delay, and turn the output
 	 * on.
 	 */
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 631622fecaa8..30544beb1a12 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1284,7 +1284,7 @@ void hid_output_report(struct hid_report *report, __u=
8 *data)
 }
 EXPORT_SYMBOL_GPL(hid_output_report);
=20
-static int hid_report_len(struct hid_report *report)
+static u32 hid_report_len(struct hid_report *report)
 {
 	/* equivalent to DIV_ROUND_UP(report->size, 8) + !!(report->id > 0) */
 	return ((report->size - 1) >> 3) + 1 + (report->id > 0);
@@ -1300,7 +1300,7 @@ u8 *hid_alloc_report_buf(struct hid_report *report, g=
fp_t flags)
 	 * of implement() working on 8 byte chunks
 	 */
=20
-	int len =3D hid_report_len(report) + 7;
+	u32 len =3D hid_report_len(report) + 7;
=20
 	return kmalloc(len, flags);
 }
@@ -1365,7 +1365,7 @@ void __hid_request(struct hid_device *hid, struct hid=
_report *report,
 {
 	char *buf;
 	int ret;
-	int len;
+	u32 len;
=20
 	buf =3D hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!buf)
@@ -1391,14 +1391,14 @@ void __hid_request(struct hid_device *hid, struct h=
id_report *report,
 }
 EXPORT_SYMBOL_GPL(__hid_request);
=20
-int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int s=
ize,
+int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 s=
ize,
 		int interrupt)
 {
 	struct hid_report_enum *report_enum =3D hid->report_enum + type;
 	struct hid_report *report;
 	struct hid_driver *hdrv;
 	unsigned int a;
-	int rsize, csize =3D size;
+	u32 rsize, csize =3D size;
 	u8 *cdata =3D data;
 	int ret =3D 0;
=20
@@ -1456,7 +1456,7 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
  *
  * This is data entry for lower layers.
  */
-int hid_input_report(struct hid_device *hid, int type, u8 *data, int size,=
 int interrupt)
+int hid_input_report(struct hid_device *hid, int type, u8 *data, u32 size,=
 int interrupt)
 {
 	struct hid_report_enum *report_enum;
 	struct hid_driver *hdrv;
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 9c2d7c23f296..c0c4df198725 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -197,6 +197,11 @@ static ssize_t hidraw_get_report(struct file *file, ch=
ar __user *buffer, size_t
 	int ret =3D 0, len;
 	unsigned char report_number;
=20
+	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
+		ret =3D -ENODEV;
+		goto out;
+	}
+
 	dev =3D hidraw_table[minor]->hid;
=20
 	if (!dev->ll_driver->raw_request) {
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 149d1da033c0..b6fc3bd5174e 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -136,10 +136,10 @@ struct i2c_hid {
 						   * register of the HID
 						   * descriptor. */
 	unsigned int		bufsize;	/* i2c buffer size */
-	char			*inbuf;		/* Input buffer */
-	char			*rawbuf;	/* Raw Input buffer */
-	char			*cmdbuf;	/* Command buffer */
-	char			*argsbuf;	/* Command arguments buffer */
+	u8			*inbuf;		/* Input buffer */
+	u8			*rawbuf;	/* Raw Input buffer */
+	u8			*cmdbuf;	/* Command buffer */
+	u8			*argsbuf;	/* Command arguments buffer */
=20
 	unsigned long		flags;		/* device flags */
=20
@@ -373,7 +373,8 @@ static int i2c_hid_hwreset(struct i2c_client *client)
=20
 static void i2c_hid_get_input(struct i2c_hid *ihid)
 {
-	int ret, ret_size;
+	int ret;
+	u32 ret_size;
 	int size =3D le16_to_cpu(ihid->hdesc.wMaxInputLength);
=20
 	if (size > ihid->bufsize)
@@ -398,7 +399,7 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 		return;
 	}
=20
-	if (ret_size > size) {
+	if ((ret_size > size) || (ret_size < 2)) {
 		dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
 			__func__, size, ret_size);
 		return;
diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index 7710f4694ba1..0dc1f1be24f8 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -1335,8 +1335,8 @@ static int __init nct6683_find(int sioaddr, struct nc=
t6683_sio_data *sio_data)
 	/* Activate logical device if needed */
 	val =3D superio_inb(sioaddr, SIO_REG_ENABLE);
 	if (!(val & 0x01)) {
-		pr_err("EC is disabled\n");
-		goto fail;
+		pr_warn("Forcibly enabling EC access. Data may be unusable.\n");
+		superio_outb(sioaddr, SIO_REG_ENABLE, val | 0x01);
 	}
=20
 	superio_exit(sioaddr);
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 5ce32bbc41eb..a720a75fd5a6 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1287,7 +1287,7 @@ static void nct6775_update_pwm(struct device *dev)
 		duty_is_dc =3D data->REG_PWM_MODE[i] &&
 		  (nct6775_read_value(data, data->REG_PWM_MODE[i])
 		   & data->PWM_MODE_MASK[i]);
-		data->pwm_mode[i] =3D duty_is_dc;
+		data->pwm_mode[i] =3D !duty_is_dc;
=20
 		fanmodecfg =3D nct6775_read_value(data, data->REG_FAN_MODE[i]);
 		for (j =3D 0; j < ARRAY_SIZE(data->REG_PWM); j++) {
@@ -2146,7 +2146,7 @@ show_pwm_mode(struct device *dev, struct device_attri=
bute *attr, char *buf)
 	struct nct6775_data *data =3D nct6775_update_device(dev);
 	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
=20
-	return sprintf(buf, "%d\n", !data->pwm_mode[sattr->index]);
+	return sprintf(buf, "%d\n", data->pwm_mode[sattr->index]);
 }
=20
 static ssize_t
@@ -2167,9 +2167,9 @@ store_pwm_mode(struct device *dev, struct device_attr=
ibute *attr,
 	if (val > 1)
 		return -EINVAL;
=20
-	/* Setting DC mode is not supported for all chips/channels */
+	/* Setting DC mode (0) is not supported for all chips/channels */
 	if (data->REG_PWM_MODE[nr] =3D=3D 0) {
-		if (val)
+		if (!val)
 			return -EINVAL;
 		return count;
 	}
@@ -2178,7 +2178,7 @@ store_pwm_mode(struct device *dev, struct device_attr=
ibute *attr,
 	data->pwm_mode[nr] =3D val;
 	reg =3D nct6775_read_value(data, data->REG_PWM_MODE[nr]);
 	reg &=3D ~data->PWM_MODE_MASK[nr];
-	if (val)
+	if (!val)
 		reg |=3D data->PWM_MODE_MASK[nr];
 	nct6775_write_value(data, data->REG_PWM_MODE[nr], reg);
 	mutex_unlock(&data->update_lock);
diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 60aad9570f01..4876129c8337 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -67,7 +67,7 @@ static int adm1275_read_word_data(struct i2c_client *clie=
nt, int page, int reg)
 	const struct adm1275_data *data =3D to_adm1275_data(info);
 	int ret =3D 0;
=20
-	if (page)
+	if (page > 0)
 		return -ENXIO;
=20
 	switch (reg) {
@@ -144,7 +144,7 @@ static int adm1275_write_word_data(struct i2c_client *c=
lient, int page, int reg,
 {
 	int ret;
=20
-	if (page)
+	if (page > 0)
 		return -ENXIO;
=20
 	switch (reg) {
diff --git a/drivers/hwmon/pmbus/max8688.c b/drivers/hwmon/pmbus/max8688.c
index f04454a42fdd..893df4dffae4 100644
--- a/drivers/hwmon/pmbus/max8688.c
+++ b/drivers/hwmon/pmbus/max8688.c
@@ -44,7 +44,7 @@ static int max8688_read_word_data(struct i2c_client *clie=
nt, int page, int reg)
 {
 	int ret;
=20
-	if (page)
+	if (page > 0)
 		return -ENXIO;
=20
 	switch (reg) {
diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcms=
p.c
index 8564768fee32..27d87a02bbd4 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -596,10 +596,10 @@ static int pmcmsptwi_master_xfer(struct i2c_adapter *=
adap,
 		 * TODO: We could potentially loop and retry in the case
 		 * of MSP_TWI_XFER_TIMEOUT.
 		 */
-		return -1;
+		return -EIO;
 	}
=20
-	return 0;
+	return num;
 }
=20
 static u32 pmcmsptwi_i2c_func(struct i2c_adapter *adapter)
diff --git a/drivers/i2c/busses/i2c-viperboard.c b/drivers/i2c/busses/i2c-v=
iperboard.c
index 7533fa34d737..d5f600c75aaf 100644
--- a/drivers/i2c/busses/i2c-viperboard.c
+++ b/drivers/i2c/busses/i2c-viperboard.c
@@ -341,7 +341,7 @@ static int vprbrd_i2c_xfer(struct i2c_adapter *i2c, str=
uct i2c_msg *msgs,
 		}
 		mutex_unlock(&vb->lock);
 	}
-	return 0;
+	return num;
 error:
 	mutex_unlock(&vb->lock);
 	return error;
diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
index 7134e8ada09a..2d6cece4893f 100644
--- a/drivers/iio/kfifo_buf.c
+++ b/drivers/iio/kfifo_buf.c
@@ -19,11 +19,18 @@ struct iio_kfifo {
 #define iio_to_kfifo(r) container_of(r, struct iio_kfifo, buffer)
=20
 static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
-				int bytes_per_datum, int length)
+			size_t bytes_per_datum, unsigned int length)
 {
 	if ((length =3D=3D 0) || (bytes_per_datum =3D=3D 0))
 		return -EINVAL;
=20
+	/*
+	 * Make sure we don't overflow an unsigned int after kfifo rounds up to
+	 * the next power of 2.
+	 */
+	if (roundup_pow_of_two(length) > UINT_MAX / bytes_per_datum)
+		return -EINVAL;
+
 	return __kfifo_alloc((struct __kfifo *)&buf->kf, length,
 			     bytes_per_datum, GFP_KERNEL);
 }
@@ -87,7 +94,7 @@ static int iio_set_bytes_per_datum_kfifo(struct iio_buffe=
r *r, size_t bpd)
 	return 0;
 }
=20
-static int iio_set_length_kfifo(struct iio_buffer *r, int length)
+static int iio_set_length_kfifo(struct iio_buffer *r, unsigned int length)
 {
 	/* Avoid an invalid state */
 	if (length < 2)
diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 8172d37f9add..6ee9bac5ab17 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -86,6 +86,22 @@ int rdma_addr_size(struct sockaddr *addr)
 }
 EXPORT_SYMBOL(rdma_addr_size);
=20
+int rdma_addr_size_in6(struct sockaddr_in6 *addr)
+{
+	int ret =3D rdma_addr_size((struct sockaddr *) addr);
+
+	return ret <=3D sizeof(*addr) ? ret : 0;
+}
+EXPORT_SYMBOL(rdma_addr_size_in6);
+
+int rdma_addr_size_kss(struct __kernel_sockaddr_storage *addr)
+{
+	int ret =3D rdma_addr_size((struct sockaddr *) addr);
+
+	return ret <=3D sizeof(*addr) ? ret : 0;
+}
+EXPORT_SYMBOL(rdma_addr_size_kss);
+
 static struct rdma_addr_client self;
=20
 void rdma_addr_register_client(struct rdma_addr_client *client)
diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core/=
iwpm_util.c
index 140209c52571..b626447d761d 100644
--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -96,7 +96,7 @@ int iwpm_create_mapinfo(struct sockaddr_storage *local_so=
ckaddr,
 			struct sockaddr_storage *mapped_sockaddr,
 			u8 nl_client)
 {
-	struct hlist_head *hash_bucket_head;
+	struct hlist_head *hash_bucket_head =3D NULL;
 	struct iwpm_mapping_info *map_info;
 	unsigned long flags;
=20
@@ -121,6 +121,9 @@ int iwpm_create_mapinfo(struct sockaddr_storage *local_=
sockaddr,
 		hlist_add_head(&map_info->hlist_node, hash_bucket_head);
 	}
 	spin_unlock_irqrestore(&iwpm_mapinfo_lock, flags);
+
+	if (!hash_bucket_head)
+		kfree(map_info);
 	return 0;
 }
 EXPORT_SYMBOL(iwpm_create_mapinfo);
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 9acf67de4e9a..a213b01b3ce0 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -528,6 +528,9 @@ static ssize_t ucma_bind_ip(struct ucma_file *file, con=
st char __user *inbuf,
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
=20
+	if (!rdma_addr_size_in6(&cmd.addr))
+		return -EINVAL;
+
 	ctx =3D ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
@@ -541,22 +544,21 @@ static ssize_t ucma_bind(struct ucma_file *file, cons=
t char __user *inbuf,
 			 int in_len, int out_len)
 {
 	struct rdma_ucm_bind cmd;
-	struct sockaddr *addr;
 	struct ucma_context *ctx;
 	int ret;
=20
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
=20
-	addr =3D (struct sockaddr *) &cmd.addr;
-	if (cmd.reserved || !cmd.addr_size || (cmd.addr_size !=3D rdma_addr_size(=
addr)))
+	if (cmd.reserved || !cmd.addr_size ||
+	    cmd.addr_size !=3D rdma_addr_size_kss(&cmd.addr))
 		return -EINVAL;
=20
 	ctx =3D ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
-	ret =3D rdma_bind_addr(ctx->cm_id, addr);
+	ret =3D rdma_bind_addr(ctx->cm_id, (struct sockaddr *) &cmd.addr);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -566,23 +568,22 @@ static ssize_t ucma_resolve_ip(struct ucma_file *file,
 			       int in_len, int out_len)
 {
 	struct rdma_ucm_resolve_ip cmd;
-	struct sockaddr *src, *dst;
 	struct ucma_context *ctx;
 	int ret;
=20
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
=20
-	src =3D (struct sockaddr *) &cmd.src_addr;
-	dst =3D (struct sockaddr *) &cmd.dst_addr;
-	if (!rdma_addr_size(src) || !rdma_addr_size(dst))
+	if ((cmd.src_addr.sin6_family && !rdma_addr_size_in6(&cmd.src_addr)) ||
+	    !rdma_addr_size_in6(&cmd.dst_addr))
 		return -EINVAL;
=20
 	ctx =3D ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
-	ret =3D rdma_resolve_addr(ctx->cm_id, src, dst, cmd.timeout_ms);
+	ret =3D rdma_resolve_addr(ctx->cm_id, (struct sockaddr *) &cmd.src_addr,
+				(struct sockaddr *) &cmd.dst_addr, cmd.timeout_ms);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -592,24 +593,23 @@ static ssize_t ucma_resolve_addr(struct ucma_file *fi=
le,
 				 int in_len, int out_len)
 {
 	struct rdma_ucm_resolve_addr cmd;
-	struct sockaddr *src, *dst;
 	struct ucma_context *ctx;
 	int ret;
=20
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
=20
-	src =3D (struct sockaddr *) &cmd.src_addr;
-	dst =3D (struct sockaddr *) &cmd.dst_addr;
-	if (cmd.reserved || (cmd.src_size && (cmd.src_size !=3D rdma_addr_size(sr=
c))) ||
-	    !cmd.dst_size || (cmd.dst_size !=3D rdma_addr_size(dst)))
+	if (cmd.reserved ||
+	    (cmd.src_size && (cmd.src_size !=3D rdma_addr_size_kss(&cmd.src_addr)=
)) ||
+	    !cmd.dst_size || (cmd.dst_size !=3D rdma_addr_size_kss(&cmd.dst_addr)=
))
 		return -EINVAL;
=20
 	ctx =3D ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
-	ret =3D rdma_resolve_addr(ctx->cm_id, src, dst, cmd.timeout_ms);
+	ret =3D rdma_resolve_addr(ctx->cm_id, (struct sockaddr *) &cmd.src_addr,
+				(struct sockaddr *) &cmd.dst_addr, cmd.timeout_ms);
 	ucma_put_ctx(ctx);
 	return ret;
 }
@@ -1142,6 +1142,9 @@ static int ucma_set_ib_path(struct ucma_context *ctx,
 	if (!optlen)
 		return -EINVAL;
=20
+	if (!ctx->cm_id->device)
+		return -EINVAL;
+
 	memset(&sa_path, 0, sizeof(sa_path));
 	sa_path.vlan_id =3D 0xffff;
=20
@@ -1201,13 +1204,13 @@ static ssize_t ucma_set_option(struct ucma_file *fi=
le, const char __user *inbuf,
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
=20
+	if (unlikely(cmd.optlen > KMALLOC_MAX_SIZE))
+		return -EINVAL;
+
 	ctx =3D ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
-	if (unlikely(cmd.optlen > KMALLOC_MAX_SIZE))
-		return -EINVAL;
-
 	optval =3D memdup_user((void __user *) (unsigned long) cmd.optval,
 			     cmd.optlen);
 	if (IS_ERR(optval)) {
@@ -1321,7 +1324,7 @@ static ssize_t ucma_join_ip_multicast(struct ucma_fil=
e *file,
 	join_cmd.response =3D cmd.response;
 	join_cmd.uid =3D cmd.uid;
 	join_cmd.id =3D cmd.id;
-	join_cmd.addr_size =3D rdma_addr_size((struct sockaddr *) &cmd.addr);
+	join_cmd.addr_size =3D rdma_addr_size_in6(&cmd.addr);
 	if (!join_cmd.addr_size)
 		return -EINVAL;
=20
@@ -1340,7 +1343,7 @@ static ssize_t ucma_join_multicast(struct ucma_file *=
file,
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
=20
-	if (!rdma_addr_size((struct sockaddr *)&cmd.addr))
+	if (!rdma_addr_size_kss(&cmd.addr))
 		return -EINVAL;
=20
 	return ucma_process_join(file, &cmd, out_len);
diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4=
/cq.c
index c46dce3d5154..2961e6080450 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -331,7 +331,7 @@ static void advance_oldest_read(struct t4_wq *wq)
  * Deal with out-of-order and/or completions that complete
  * prior unsignalled WRs.
  */
-void c4iw_flush_hw_cq(struct c4iw_cq *chp)
+void c4iw_flush_hw_cq(struct c4iw_cq *chp, struct c4iw_qp *flush_qhp)
 {
 	struct t4_cqe *hw_cqe, *swcqe, read_cqe;
 	struct c4iw_qp *qhp;
@@ -355,6 +355,13 @@ void c4iw_flush_hw_cq(struct c4iw_cq *chp)
 		if (qhp =3D=3D NULL)
 			goto next_cqe;
=20
+		if (flush_qhp !=3D qhp) {
+			spin_lock(&qhp->lock);
+
+			if (qhp->wq.flushed =3D=3D 1)
+				goto next_cqe;
+		}
+
 		if (CQE_OPCODE(hw_cqe) =3D=3D FW_RI_TERMINATE)
 			goto next_cqe;
=20
@@ -406,6 +413,8 @@ void c4iw_flush_hw_cq(struct c4iw_cq *chp)
 next_cqe:
 		t4_hwcq_consume(&chp->cq);
 		ret =3D t4_next_hw_cqe(&chp->cq, &hw_cqe);
+		if (qhp && flush_qhp !=3D qhp)
+			spin_unlock(&qhp->lock);
 	}
 }
=20
diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/c=
xgb4/device.c
index ea8ce383e57d..5e42f584df59 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -698,6 +698,12 @@ static int c4iw_rdev_open(struct c4iw_rdev *rdev)
 		goto err4;
 	}
 	rdev->status_page->db_off =3D 0;
+
+	init_completion(&rdev->rqt_compl);
+	init_completion(&rdev->pbl_compl);
+	kref_init(&rdev->rqt_kref);
+	kref_init(&rdev->pbl_kref);
+
 	return 0;
 err4:
 	c4iw_rqtpool_destroy(rdev);
@@ -714,6 +720,8 @@ static void c4iw_rdev_close(struct c4iw_rdev *rdev)
 	free_page((unsigned long)rdev->status_page);
 	c4iw_pblpool_destroy(rdev);
 	c4iw_rqtpool_destroy(rdev);
+	wait_for_completion(&rdev->pbl_compl);
+	wait_for_completion(&rdev->rqt_compl);
 	c4iw_destroy_resource(&rdev->resource);
 }
=20
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw=
/cxgb4/iw_cxgb4.h
index 361fff7a0742..47bc55f1d6fb 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -157,6 +157,10 @@ struct c4iw_rdev {
 	void __iomem *oc_mw_kva;
 	struct c4iw_stats stats;
 	struct t4_dev_status_page *status_page;
+	struct completion rqt_compl;
+	struct completion pbl_compl;
+	struct kref rqt_kref;
+	struct kref pbl_kref;
 };
=20
 static inline int c4iw_fatal_error(struct c4iw_rdev *rdev)
@@ -973,7 +977,7 @@ void c4iw_pblpool_free(struct c4iw_rdev *rdev, u32 addr=
, int size);
 u32 c4iw_ocqp_pool_alloc(struct c4iw_rdev *rdev, int size);
 void c4iw_ocqp_pool_free(struct c4iw_rdev *rdev, u32 addr, int size);
 int c4iw_ofld_send(struct c4iw_rdev *rdev, struct sk_buff *skb);
-void c4iw_flush_hw_cq(struct c4iw_cq *chp);
+void c4iw_flush_hw_cq(struct c4iw_cq *chp, struct c4iw_qp *flush_qhp);
 void c4iw_count_rcqes(struct t4_cq *cq, struct t4_wq *wq, int *count);
 int c4iw_ep_disconnect(struct c4iw_ep *ep, int abrupt, gfp_t gfp);
 int c4iw_flush_rq(struct t4_wq *wq, struct t4_cq *cq, int count);
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4=
/qp.c
index 086f62f5dc9e..a8d4ffc0bea8 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1082,7 +1082,7 @@ static void __flush_qp(struct c4iw_qp *qhp, struct c4=
iw_cq *rchp,
 	}
 	qhp->wq.flushed =3D 1;
=20
-	c4iw_flush_hw_cq(rchp);
+	c4iw_flush_hw_cq(rchp, qhp);
 	c4iw_count_rcqes(&rchp->cq, &qhp->wq, &count);
 	flushed =3D c4iw_flush_rq(&qhp->wq, &rchp->cq, count);
 	spin_unlock(&qhp->lock);
@@ -1097,7 +1097,7 @@ static void __flush_qp(struct c4iw_qp *qhp, struct c4=
iw_cq *rchp,
 	spin_lock_irqsave(&schp->lock, flag);
 	spin_lock(&qhp->lock);
 	if (schp !=3D rchp)
-		c4iw_flush_hw_cq(schp);
+		c4iw_flush_hw_cq(schp, qhp);
 	flushed =3D c4iw_flush_sq(qhp);
 	spin_unlock(&qhp->lock);
 	spin_unlock_irqrestore(&schp->lock, flag);
diff --git a/drivers/infiniband/hw/cxgb4/resource.c b/drivers/infiniband/hw=
/cxgb4/resource.c
index 67df71a7012e..803c677e21cd 100644
--- a/drivers/infiniband/hw/cxgb4/resource.c
+++ b/drivers/infiniband/hw/cxgb4/resource.c
@@ -260,12 +260,22 @@ u32 c4iw_pblpool_alloc(struct c4iw_rdev *rdev, int si=
ze)
 		rdev->stats.pbl.cur +=3D roundup(size, 1 << MIN_PBL_SHIFT);
 		if (rdev->stats.pbl.cur > rdev->stats.pbl.max)
 			rdev->stats.pbl.max =3D rdev->stats.pbl.cur;
+		kref_get(&rdev->pbl_kref);
 	} else
 		rdev->stats.pbl.fail++;
 	mutex_unlock(&rdev->stats.lock);
 	return (u32)addr;
 }
=20
+static void destroy_pblpool(struct kref *kref)
+{
+	struct c4iw_rdev *rdev;
+
+	rdev =3D container_of(kref, struct c4iw_rdev, pbl_kref);
+	gen_pool_destroy(rdev->pbl_pool);
+	complete(&rdev->pbl_compl);
+}
+
 void c4iw_pblpool_free(struct c4iw_rdev *rdev, u32 addr, int size)
 {
 	PDBG("%s addr 0x%x size %d\n", __func__, addr, size);
@@ -273,6 +283,7 @@ void c4iw_pblpool_free(struct c4iw_rdev *rdev, u32 addr=
, int size)
 	rdev->stats.pbl.cur -=3D roundup(size, 1 << MIN_PBL_SHIFT);
 	mutex_unlock(&rdev->stats.lock);
 	gen_pool_free(rdev->pbl_pool, (unsigned long)addr, size);
+	kref_put(&rdev->pbl_kref, destroy_pblpool);
 }
=20
 int c4iw_pblpool_create(struct c4iw_rdev *rdev)
@@ -312,7 +323,7 @@ int c4iw_pblpool_create(struct c4iw_rdev *rdev)
=20
 void c4iw_pblpool_destroy(struct c4iw_rdev *rdev)
 {
-	gen_pool_destroy(rdev->pbl_pool);
+	kref_put(&rdev->pbl_kref, destroy_pblpool);
 }
=20
 /*
@@ -333,12 +344,22 @@ u32 c4iw_rqtpool_alloc(struct c4iw_rdev *rdev, int si=
ze)
 		rdev->stats.rqt.cur +=3D roundup(size << 6, 1 << MIN_RQT_SHIFT);
 		if (rdev->stats.rqt.cur > rdev->stats.rqt.max)
 			rdev->stats.rqt.max =3D rdev->stats.rqt.cur;
+		kref_get(&rdev->rqt_kref);
 	} else
 		rdev->stats.rqt.fail++;
 	mutex_unlock(&rdev->stats.lock);
 	return (u32)addr;
 }
=20
+static void destroy_rqtpool(struct kref *kref)
+{
+	struct c4iw_rdev *rdev;
+
+	rdev =3D container_of(kref, struct c4iw_rdev, rqt_kref);
+	gen_pool_destroy(rdev->rqt_pool);
+	complete(&rdev->rqt_compl);
+}
+
 void c4iw_rqtpool_free(struct c4iw_rdev *rdev, u32 addr, int size)
 {
 	PDBG("%s addr 0x%x size %d\n", __func__, addr, size << 6);
@@ -346,6 +367,7 @@ void c4iw_rqtpool_free(struct c4iw_rdev *rdev, u32 addr=
, int size)
 	rdev->stats.rqt.cur -=3D roundup(size << 6, 1 << MIN_RQT_SHIFT);
 	mutex_unlock(&rdev->stats.lock);
 	gen_pool_free(rdev->rqt_pool, (unsigned long)addr, size << 6);
+	kref_put(&rdev->rqt_kref, destroy_rqtpool);
 }
=20
 int c4iw_rqtpool_create(struct c4iw_rdev *rdev)
@@ -383,7 +405,7 @@ int c4iw_rqtpool_create(struct c4iw_rdev *rdev)
=20
 void c4iw_rqtpool_destroy(struct c4iw_rdev *rdev)
 {
-	gen_pool_destroy(rdev->rqt_pool);
+	kref_put(&rdev->rqt_kref, destroy_rqtpool);
 }
=20
 /*
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/q=
p.c
index 8761cf4c003f..074c5d993b33 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -174,7 +174,11 @@ static int set_rq_size(struct mlx5_ib_dev *dev, struct=
 ib_qp_cap *cap,
 	} else {
 		if (ucmd) {
 			qp->rq.wqe_cnt =3D ucmd->rq_wqe_count;
+			if (ucmd->rq_wqe_shift > BITS_PER_BYTE * sizeof(ucmd->rq_wqe_shift))
+				return -EINVAL;
 			qp->rq.wqe_shift =3D ucmd->rq_wqe_shift;
+			if ((1 << qp->rq.wqe_shift) / sizeof(struct mlx5_wqe_data_seg) < qp->wq=
_sig)
+				return -EINVAL;
 			qp->rq.max_gs =3D (1 << qp->rq.wqe_shift) / sizeof(struct mlx5_wqe_data=
_seg) - qp->wq_sig;
 			qp->rq.max_post =3D qp->rq.wqe_cnt;
 		} else {
@@ -352,11 +356,6 @@ static int qp_has_rq(struct ib_qp_init_attr *attr)
 	return 1;
 }
=20
-static int first_med_uuar(void)
-{
-	return 1;
-}
-
 static int next_uuar(int n)
 {
 	n++;
@@ -391,6 +390,11 @@ static int max_uuari(struct mlx5_uuar_info *uuari)
 	return uuari->num_uars * 4;
 }
=20
+static int first_med_uuar(struct mlx5_uuar_info *uuari)
+{
+	return num_med_uuar(uuari) ? 1 : -ENOMEM;
+}
+
 static int first_hi_uuar(struct mlx5_uuar_info *uuari)
 {
 	int med;
@@ -416,10 +420,13 @@ static int alloc_high_class_uuar(struct mlx5_uuar_inf=
o *uuari)
=20
 static int alloc_med_class_uuar(struct mlx5_uuar_info *uuari)
 {
-	int minidx =3D first_med_uuar();
+	int minidx =3D first_med_uuar(uuari);
 	int i;
=20
-	for (i =3D first_med_uuar(); i < first_hi_uuar(uuari); i =3D next_uuar(i)=
) {
+	if (minidx < 0)
+		return minidx;
+
+	for (i =3D minidx; i < first_hi_uuar(uuari); i =3D next_uuar(i)) {
 		if (uuari->count[i] < uuari->count[minidx])
 			minidx =3D i;
 		if (!uuari->count[minidx])
@@ -1281,18 +1288,18 @@ enum {
=20
 static int ib_rate_to_mlx5(struct mlx5_ib_dev *dev, u8 rate)
 {
-	if (rate =3D=3D IB_RATE_PORT_CURRENT) {
+	if (rate =3D=3D IB_RATE_PORT_CURRENT)
 		return 0;
-	} else if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_300_GBPS) {
+
+	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_300_GBPS)
 		return -EINVAL;
-	} else {
-		while (rate !=3D IB_RATE_2_5_GBPS &&
-		       !(1 << (rate + MLX5_STAT_RATE_OFFSET) &
-			 dev->mdev.caps.stat_rate_support))
-			--rate;
-	}
=20
-	return rate + MLX5_STAT_RATE_OFFSET;
+	while (rate !=3D IB_RATE_PORT_CURRENT &&
+	       !(1 << (rate + MLX5_STAT_RATE_OFFSET) &
+		 dev->mdev.caps.stat_rate_support))
+		--rate;
+
+	return rate ? rate + MLX5_STAT_RATE_OFFSET : rate;
 }
=20
 static int mlx5_set_path(struct mlx5_ib_dev *dev, const struct ib_ah_attr =
*ah,
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/s=
rp/ib_srp.c
index 4591cc7b8240..bdc61a935088 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2393,9 +2393,11 @@ static int srp_abort(struct scsi_cmnd *scmnd)
 		ret =3D FAST_IO_FAIL;
 	else
 		ret =3D FAILED;
-	srp_free_req(target, req, scmnd, 0);
-	scmnd->result =3D DID_ABORT << 16;
-	scmnd->scsi_done(scmnd);
+	if (ret =3D=3D SUCCESS) {
+		srp_free_req(target, req, scmnd, 0);
+		scmnd->result =3D DID_ABORT << 16;
+		scmnd->scsi_done(scmnd);
+	}
=20
 	return ret;
 }
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8=
042-x86ia64io.h
index 822d3f6e666b..29ac9d450e8e 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -516,6 +516,20 @@ static const struct dmi_system_id __initconst i8042_dm=
i_nomux_table[] =3D {
 	{ }
 };
=20
+static const struct dmi_system_id i8042_dmi_forcemux_table[] __initconst =
=3D {
+	{
+		/*
+		 * Sony Vaio VGN-CS series require MUX or the touch sensor
+		 * buttons will disturb touchpad operation
+		 */
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
+		},
+	},
+	{ }
+};
+
 static const struct dmi_system_id __initconst i8042_dmi_reset_table[] =3D {
 	{
 		/* MSI Wind U-100 */
@@ -594,6 +608,13 @@ static const struct dmi_system_id __initconst i8042_dm=
i_reset_table[] =3D {
 			DMI_MATCH(DMI_PRODUCT_NAME, "20046"),
 		},
 	},
+	{
+		/* Lenovo ThinkPad L460 */
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
+		},
+	},
 	{
 		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
 		.matches =3D {
@@ -1109,6 +1130,9 @@ static int __init i8042_platform_init(void)
 	if (dmi_check_system(i8042_dmi_nomux_table))
 		i8042_nomux =3D true;
=20
+	if (dmi_check_system(i8042_dmi_forcemux_table))
+		i8042_nomux =3D false;
+
 	if (dmi_check_system(i8042_dmi_notimeout_table))
 		i8042_notimeout =3D true;
=20
diff --git a/drivers/media/pci/cx25821/cx25821-core.c b/drivers/media/pci/c=
x25821/cx25821-core.c
index e81173c41e5a..34335ced002e 100644
--- a/drivers/media/pci/cx25821/cx25821-core.c
+++ b/drivers/media/pci/cx25821/cx25821-core.c
@@ -871,6 +871,10 @@ static int cx25821_dev_setup(struct cx25821_dev *dev)
 	dev->nr =3D ++cx25821_devcount;
 	sprintf(dev->name, "cx25821[%d]", dev->nr);
=20
+	if (dev->nr >=3D ARRAY_SIZE(card)) {
+		CX25821_INFO("dev->nr >=3D %zd", ARRAY_SIZE(card));
+		return -ENODEV;
+	}
 	if (dev->pci->device !=3D 0x8210) {
 		pr_info("%s(): Exiting. Incorrect Hardware device =3D 0x%02x\n",
 			__func__, dev->pci->device);
@@ -887,9 +891,6 @@ static int cx25821_dev_setup(struct cx25821_dev *dev)
 		dev->channels[i].sram_channels =3D &cx25821_sram_channels[i];
 	}
=20
-	if (dev->nr > 1)
-		CX25821_INFO("dev->nr > 1!");
-
 	/* board config */
 	dev->board =3D 1;		/* card[dev->nr]; */
 	dev->_max_num_decoders =3D MAX_DECODERS;
diff --git a/drivers/media/platform/s3c-camif/camif-capture.c b/drivers/med=
ia/platform/s3c-camif/camif-capture.c
index deba425e3d8f..10eea821275c 100644
--- a/drivers/media/platform/s3c-camif/camif-capture.c
+++ b/drivers/media/platform/s3c-camif/camif-capture.c
@@ -1280,16 +1280,17 @@ static void __camif_subdev_try_format(struct camif_=
dev *camif,
 {
 	const struct s3c_camif_variant *variant =3D camif->variant;
 	const struct vp_pix_limits *pix_lim;
-	int i =3D ARRAY_SIZE(camif_mbus_formats);
+	unsigned int i;
=20
 	/* FIXME: constraints against codec or preview path ? */
 	pix_lim =3D &variant->vp_pix_limits[VP_CODEC];
=20
-	while (i-- >=3D 0)
+	for (i =3D 0; i < ARRAY_SIZE(camif_mbus_formats); i++)
 		if (camif_mbus_formats[i] =3D=3D mf->code)
 			break;
=20
-	mf->code =3D camif_mbus_formats[i];
+	if (i =3D=3D ARRAY_SIZE(camif_mbus_formats))
+		mf->code =3D camif_mbus_formats[0];
=20
 	if (pad =3D=3D CAMIF_SD_PAD_SINK) {
 		v4l_bound_align_image(&mf->width, 8, CAMIF_MAX_PIX_WIDTH,
diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index c5a64a111284..0c227ed69b0f 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1427,13 +1427,13 @@ void rc_unregister_device(struct rc_dev *dev)
 	if (!dev)
 		return;
=20
-	del_timer_sync(&dev->timer_keyup);
-
 	clear_bit(dev->devno, ir_core_dev_number);
=20
 	if (dev->driver_type =3D=3D RC_DRIVER_IR_RAW)
 		ir_raw_event_unregister(dev);
=20
+	del_timer_sync(&dev->timer_keyup);
+
 	/* Freeing the table should also call the stop callback */
 	ir_free_table(&dev->rc_map);
 	IR_dprintk(1, "Freed keycode table\n");
diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/=
v4l2-core/v4l2-compat-ioctl32.c
index 412abcc9b6f6..acf4dc31fb79 100644
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -101,7 +101,7 @@ static int get_v4l2_window32(struct v4l2_window __user =
*kp,
 static int put_v4l2_window32(struct v4l2_window __user *kp,
 			     struct v4l2_window32 __user *up)
 {
-	struct v4l2_clip __user *kclips =3D kp->clips;
+	struct v4l2_clip __user *kclips;
 	struct v4l2_clip32 __user *uclips;
 	compat_caddr_t p;
 	u32 clipcount;
@@ -116,6 +116,8 @@ static int put_v4l2_window32(struct v4l2_window __user =
*kp,
 	if (!clipcount)
 		return 0;
=20
+	if (get_user(kclips, &kp->clips))
+		return -EFAULT;
 	if (get_user(p, &up->clips))
 		return -EFAULT;
 	uclips =3D compat_ptr(p);
diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsa=
s.c
index 711fcb5cec87..06a52f823282 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -1996,6 +1996,7 @@ static struct scsi_host_template mptsas_driver_templa=
te =3D {
 	.cmd_per_lun			=3D 7,
 	.use_clustering			=3D ENABLE_CLUSTERING,
 	.shost_attrs			=3D mptscsih_host_attrs,
+	.no_write_same			=3D 1,
 };
=20
 static int mptsas_get_linkerrors(struct sas_phy *phy)
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 537d6c7a5ae4..c4a5b6811cd6 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -148,9 +148,9 @@ static void jz4740_mmc_set_irq_enabled(struct jz4740_mm=
c_host *host,
 		host->irq_mask &=3D ~irq;
 	else
 		host->irq_mask |=3D irq;
-	spin_unlock_irqrestore(&host->lock, flags);
=20
 	writew(host->irq_mask, host->base + JZ_REG_MMC_IMASK);
+	spin_unlock_irqrestore(&host->lock, flags);
 }
=20
 static void jz4740_mmc_clock_enable(struct jz4740_mmc_host *host,
diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cm=
dset_0001.c
index 3096f3ded3ad..8e2a7d077b16 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -45,6 +45,7 @@
 #define I82802AB	0x00ad
 #define I82802AC	0x00ac
 #define PF38F4476	0x881c
+#define M28F00AP30	0x8963
 /* STMicroelectronics chips */
 #define M50LPW080       0x002F
 #define M50FLW080A	0x0080
@@ -375,6 +376,17 @@ static void cfi_fixup_major_minor(struct cfi_private *=
cfi,
 		extp->MinorVersion =3D '1';
 }
=20
+static int cfi_is_micron_28F00AP30(struct cfi_private *cfi, struct flchip =
*chip)
+{
+	/*
+	 * Micron(was Numonyx) 1Gbit bottom boot are buggy w.r.t
+	 * Erase Supend for their small Erase Blocks(0x8000)
+	 */
+	if (cfi->mfr =3D=3D CFI_MFR_INTEL && cfi->id =3D=3D M28F00AP30)
+		return 1;
+	return 0;
+}
+
 static inline struct cfi_pri_intelext *
 read_pri_intelext(struct map_info *map, __u16 adr)
 {
@@ -825,21 +837,30 @@ static int chip_ready (struct map_info *map, struct f=
lchip *chip, unsigned long
 		     (mode =3D=3D FL_WRITING && (cfip->SuspendCmdSupport & 1))))
 			goto sleep;
=20
+		/* Do not allow suspend iff read/write to EB address */
+		if ((adr & chip->in_progress_block_mask) =3D=3D
+		    chip->in_progress_block_addr)
+			goto sleep;
+
+		/* do not suspend small EBs, buggy Micron Chips */
+		if (cfi_is_micron_28F00AP30(cfi, chip) &&
+		    (chip->in_progress_block_mask =3D=3D ~(0x8000-1)))
+			goto sleep;
=20
 		/* Erase suspend */
-		map_write(map, CMD(0xB0), adr);
+		map_write(map, CMD(0xB0), chip->in_progress_block_addr);
=20
 		/* If the flash has finished erasing, then 'erase suspend'
 		 * appears to make some (28F320) flash devices switch to
 		 * 'read' mode.  Make sure that we switch to 'read status'
 		 * mode so we get the right data. --rmk
 		 */
-		map_write(map, CMD(0x70), adr);
+		map_write(map, CMD(0x70), chip->in_progress_block_addr);
 		chip->oldstate =3D FL_ERASING;
 		chip->state =3D FL_ERASE_SUSPENDING;
 		chip->erase_suspended =3D 1;
 		for (;;) {
-			status =3D map_read(map, adr);
+			status =3D map_read(map, chip->in_progress_block_addr);
 			if (map_word_andequal(map, status, status_OK, status_OK))
 			        break;
=20
@@ -1035,8 +1056,8 @@ static void put_chip(struct map_info *map, struct flc=
hip *chip, unsigned long ad
 		   sending the 0x70 (Read Status) command to an erasing
 		   chip and expecting it to be ignored, that's what we
 		   do. */
-		map_write(map, CMD(0xd0), adr);
-		map_write(map, CMD(0x70), adr);
+		map_write(map, CMD(0xd0), chip->in_progress_block_addr);
+		map_write(map, CMD(0x70), chip->in_progress_block_addr);
 		chip->oldstate =3D FL_READY;
 		chip->state =3D FL_ERASING;
 		break;
@@ -1927,6 +1948,8 @@ static int __xipram do_erase_oneblock(struct map_info=
 *map, struct flchip *chip,
 	map_write(map, CMD(0xD0), adr);
 	chip->state =3D FL_ERASING;
 	chip->erase_suspended =3D 0;
+	chip->in_progress_block_addr =3D adr;
+	chip->in_progress_block_mask =3D ~(len - 1);
=20
 	ret =3D INVAL_CACHE_AND_WAIT(map, chip, adr,
 				   adr, len,
diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cm=
dset_0002.c
index e21fde9d4d7e..573d843a73a9 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -780,9 +780,10 @@ static int get_chip(struct map_info *map, struct flchi=
p *chip, unsigned long adr
 		    (mode =3D=3D FL_WRITING && (cfip->EraseSuspend & 0x2))))
 			goto sleep;
=20
-		/* We could check to see if we're trying to access the sector
-		 * that is currently being erased. However, no user will try
-		 * anything like that so we just wait for the timeout. */
+		/* Do not allow suspend iff read/write to EB address */
+		if ((adr & chip->in_progress_block_mask) =3D=3D
+		    chip->in_progress_block_addr)
+			goto sleep;
=20
 		/* Erase suspend */
 		/* It's harmless to issue the Erase-Suspend and Erase-Resume
@@ -1926,6 +1927,7 @@ static int __xipram do_erase_chip(struct map_info *ma=
p, struct flchip *chip)
 	chip->state =3D FL_ERASING;
 	chip->erase_suspended =3D 0;
 	chip->in_progress_block_addr =3D adr;
+	chip->in_progress_block_mask =3D ~(map->size - 1);
=20
 	INVALIDATE_CACHE_UDELAY(map, chip,
 				adr, map->size,
@@ -2015,6 +2017,7 @@ static int __xipram do_erase_oneblock(struct map_info=
 *map, struct flchip *chip,
 	chip->state =3D FL_ERASING;
 	chip->erase_suspended =3D 0;
 	chip->in_progress_block_addr =3D adr;
+	chip->in_progress_block_mask =3D ~(len - 1);
=20
 	INVALIDATE_CACHE_UDELAY(map, chip,
 				adr, len,
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 8b4a182d7cf9..d9580663544d 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -322,7 +322,7 @@ static int ubiblock_open(struct block_device *bdev, fmo=
de_t mode)
 	 * in any case.
 	 */
 	if (mode & FMODE_WRITE) {
-		ret =3D -EPERM;
+		ret =3D -EROFS;
 		goto out_unlock;
 	}
=20
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index c3db383a9000..7bbd11e25f23 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -905,6 +905,17 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_n=
um,
 		return -EINVAL;
 	}
=20
+	/*
+	 * Both UBI and UBIFS have been designed for SLC NAND and NOR flashes.
+	 * MLC NAND is different and needs special care, otherwise UBI or UBIFS
+	 * will die soon and you will lose all your data.
+	 */
+	if (mtd->type =3D=3D MTD_MLCNANDFLASH) {
+		pr_err("ubi: refuse attaching mtd%d - MLC NAND is not supported\n",
+			mtd->index);
+		return -EINVAL;
+	}
+
 	if (ubi_num =3D=3D UBI_DEV_NUM_AUTO) {
 		/* Search for an empty slot in the @ubi_devices array */
 		for (ubi_num =3D 0; ubi_num < UBI_MAX_DEVICES; ubi_num++)
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index d87c0d275aba..54516a8502a6 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1535,8 +1535,7 @@ int bond_enslave(struct net_device *bond_dev, struct =
net_device *slave_dev)
 	} /* switch(bond_mode) */
=20
 #ifdef CONFIG_NET_POLL_CONTROLLER
-	slave_dev->npinfo =3D bond->dev->npinfo;
-	if (slave_dev->npinfo) {
+	if (bond->dev->npinfo) {
 		if (slave_enable_netpoll(new_slave)) {
 			pr_info("Error, %s: master_dev is using netpoll, but new slave device d=
oes not support netpoll\n",
 				bond_dev->name);
diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_=
usb.c
index c5443345d243..e4d9e8be982f 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -845,7 +845,7 @@ static void kvaser_usb_rx_can_msg(const struct kvaser_u=
sb *dev,
=20
 	skb =3D alloc_can_skb(priv->netdev, &cf);
 	if (!skb) {
-		stats->tx_dropped++;
+		stats->rx_dropped++;
 		return;
 	}
=20
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ether=
net/broadcom/bcmsysport.c
index 2d2c6703819e..3d85750a14ab 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -772,7 +772,7 @@ static struct sk_buff *bcm_sysport_insert_tsb(struct sk=
_buff *skb,
 	u32 csum_info;
 	u8 ip_proto;
 	u16 csum_start;
-	u16 ip_ver;
+	__be16 ip_ver;
=20
 	/* Re-allocate SKB if needed */
 	if (unlikely(skb_headroom(skb) < sizeof(*tsb))) {
@@ -791,12 +791,12 @@ static struct sk_buff *bcm_sysport_insert_tsb(struct =
sk_buff *skb,
 	memset(tsb, 0, sizeof(*tsb));
=20
 	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
-		ip_ver =3D htons(skb->protocol);
+		ip_ver =3D skb->protocol;
 		switch (ip_ver) {
-		case ETH_P_IP:
+		case htons(ETH_P_IP):
 			ip_proto =3D ip_hdr(skb)->protocol;
 			break;
-		case ETH_P_IPV6:
+		case htons(ETH_P_IPV6):
 			ip_proto =3D ipv6_hdr(skb)->nexthdr;
 			break;
 		default:
@@ -810,7 +810,8 @@ static struct sk_buff *bcm_sysport_insert_tsb(struct sk=
_buff *skb,
=20
 		if (ip_proto =3D=3D IPPROTO_TCP || ip_proto =3D=3D IPPROTO_UDP) {
 			csum_info |=3D L4_LENGTH_VALID;
-			if (ip_proto =3D=3D IPPROTO_UDP && ip_ver =3D=3D ETH_P_IP)
+			if (ip_proto =3D=3D IPPROTO_UDP &&
+			    ip_ver =3D=3D htons(ETH_P_IP))
 				csum_info |=3D L4_UDP;
 		} else
 			csum_info =3D 0;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/e=
thernet/broadcom/genet/bcmgenet.c
index ebf18200d76d..e65a43287ede 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1093,7 +1093,7 @@ static int bcmgenet_put_tx_csum(struct net_device *de=
v, struct sk_buff *skb)
 	struct sk_buff *new_skb;
 	u16 offset;
 	u8 ip_proto;
-	u16 ip_ver;
+	__be16 ip_ver;
 	u32 tx_csum_info;
=20
 	if (unlikely(skb_headroom(skb) < sizeof(*status))) {
@@ -1114,12 +1114,12 @@ static int bcmgenet_put_tx_csum(struct net_device *=
dev, struct sk_buff *skb)
 	status =3D (struct status_64 *)skb->data;
=20
 	if (skb->ip_summed  =3D=3D CHECKSUM_PARTIAL) {
-		ip_ver =3D htons(skb->protocol);
+		ip_ver =3D skb->protocol;
 		switch (ip_ver) {
-		case ETH_P_IP:
+		case htons(ETH_P_IP):
 			ip_proto =3D ip_hdr(skb)->protocol;
 			break;
-		case ETH_P_IPV6:
+		case htons(ETH_P_IPV6):
 			ip_proto =3D ipv6_hdr(skb)->nexthdr;
 			break;
 		default:
@@ -1135,7 +1135,8 @@ static int bcmgenet_put_tx_csum(struct net_device *de=
v, struct sk_buff *skb)
 		 */
 		if (ip_proto =3D=3D IPPROTO_TCP || ip_proto =3D=3D IPPROTO_UDP) {
 			tx_csum_info |=3D STATUS_TX_CSUM_LV;
-			if (ip_proto =3D=3D IPPROTO_UDP && ip_ver =3D=3D ETH_P_IP)
+			if (ip_proto =3D=3D IPPROTO_UDP &&
+			    ip_ver =3D=3D htons(ETH_P_IP))
 				tx_csum_info |=3D STATUS_TX_CSUM_PROTO_UDP;
 		} else
 			tx_csum_info =3D 0;
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethe=
rnet/cisco/enic/enic_main.c
index 720eed57d255..965260edb010 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2198,11 +2198,11 @@ static int enic_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
 	pci_set_master(pdev);
=20
 	/* Query PCI controller on system for DMA addressing
-	 * limitation for the device.  Try 64-bit first, and
+	 * limitation for the device.  Try 47-bit first, and
 	 * fail to 32-bit.
 	 */
=20
-	err =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	err =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(47));
 	if (err) {
 		err =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
 		if (err) {
@@ -2216,10 +2216,10 @@ static int enic_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
 			goto err_out_release_regions;
 		}
 	} else {
-		err =3D pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+		err =3D pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(47));
 		if (err) {
 			dev_err(dev, "Unable to obtain %u-bit DMA "
-				"for consistent allocations, aborting\n", 64);
+				"for consistent allocations, aborting\n", 47);
 			goto err_out_release_regions;
 		}
 		using_dac =3D 1;
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/mar=
vell/sky2.c
index d72c33cbaeeb..1bebdf650f94 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -5070,7 +5070,7 @@ static int sky2_probe(struct pci_dev *pdev, const str=
uct pci_device_id *ent)
 	INIT_WORK(&hw->restart_work, sky2_restart);
=20
 	pci_set_drvdata(pdev, hw);
-	pdev->d3_delay =3D 150;
+	pdev->d3_delay =3D 200;
=20
 	return 0;
=20
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/=
ethernet/mellanox/mlx4/en_ethtool.c
index d187819b1340..9885108fcd1b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -441,6 +441,22 @@ static int mlx4_en_set_coalesce(struct net_device *dev,
 	if (!coal->tx_max_coalesced_frames_irq)
 		return -EINVAL;
=20
+	if (coal->tx_coalesce_usecs > MLX4_EN_MAX_COAL_TIME ||
+	    coal->rx_coalesce_usecs > MLX4_EN_MAX_COAL_TIME ||
+	    coal->rx_coalesce_usecs_low > MLX4_EN_MAX_COAL_TIME ||
+	    coal->rx_coalesce_usecs_high > MLX4_EN_MAX_COAL_TIME) {
+		netdev_info(dev, "%s: maximum coalesce time supported is %d usecs\n",
+			    __func__, MLX4_EN_MAX_COAL_TIME);
+		return -ERANGE;
+	}
+
+	if (coal->tx_max_coalesced_frames > MLX4_EN_MAX_COAL_PKTS ||
+	    coal->rx_max_coalesced_frames > MLX4_EN_MAX_COAL_PKTS) {
+		netdev_info(dev, "%s: maximum coalesced frames supported is %d\n",
+			    __func__, MLX4_EN_MAX_COAL_PKTS);
+		return -ERANGE;
+	}
+
 	priv->rx_frames =3D (coal->rx_max_coalesced_frames =3D=3D
 			   MLX4_EN_AUTO_CONF) ?
 				MLX4_EN_RX_COAL_TARGET :
diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethern=
et/mellanox/mlx4/main.c
index 0996af50ad5b..8a5992b8f29a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -2048,6 +2048,7 @@ static int mlx4_init_port_info(struct mlx4_dev *dev, =
int port)
 	if (err) {
 		mlx4_err(dev, "Failed to create file for port %d\n", port);
 		info->port =3D -1;
+		return err;
 	}
=20
 	sprintf(info->dev_mtu_name, "mlx4_port%d_mtu", port);
@@ -2066,9 +2067,10 @@ static int mlx4_init_port_info(struct mlx4_dev *dev,=
 int port)
 		mlx4_err(dev, "Failed to create mtu file for port %d\n", port);
 		device_remove_file(&info->dev->pdev->dev, &info->port_attr);
 		info->port =3D -1;
+		return err;
 	}
=20
-	return err;
+	return 0;
 }
=20
 static void mlx4_cleanup_port_info(struct mlx4_port_info *info)
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/eth=
ernet/mellanox/mlx4/mlx4_en.h
index 625537010876..feb76d675d68 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -136,6 +136,9 @@ enum {
 #define MLX4_EN_TX_COAL_PKTS	16
 #define MLX4_EN_TX_COAL_TIME	0x10
=20
+#define MLX4_EN_MAX_COAL_PKTS	U16_MAX
+#define MLX4_EN_MAX_COAL_TIME	U16_MAX
+
 #define MLX4_EN_RX_RATE_LOW		400000
 #define MLX4_EN_RX_COAL_TIME_LOW	0
 #define MLX4_EN_RX_RATE_HIGH		450000
@@ -522,8 +525,8 @@ struct mlx4_en_priv {
 	u16 rx_usecs_low;
 	u32 pkt_rate_high;
 	u16 rx_usecs_high;
-	u16 sample_interval;
-	u16 adaptive_rx_coal;
+	u32 sample_interval;
+	u32 adaptive_rx_coal;
 	u32 msg_enable;
 	u32 loopback_ok;
 	u32 validate_loopback;
diff --git a/drivers/net/ethernet/mellanox/mlx4/qp.c b/drivers/net/ethernet=
/mellanox/mlx4/qp.c
index 230832628116..96afaaf58832 100644
--- a/drivers/net/ethernet/mellanox/mlx4/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx4/qp.c
@@ -363,11 +363,11 @@ struct mlx4_qp *mlx4_qp_lookup(struct mlx4_dev *dev, =
u32 qpn)
 	struct mlx4_qp_table *qp_table =3D &mlx4_priv(dev)->qp_table;
 	struct mlx4_qp *qp;
=20
-	spin_lock(&qp_table->lock);
+	spin_lock_irq(&qp_table->lock);
=20
 	qp =3D __mlx4_qp_lookup(dev, qpn);
=20
-	spin_unlock(&qp_table->lock);
+	spin_unlock_irq(&qp_table->lock);
 	return qp;
 }
=20
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index d7e04d3daf13..5cc2eda1bdd5 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2216,12 +2216,17 @@ static int cpsw_probe(struct platform_device *pdev)
=20
 	priv->txch =3D cpdma_chan_create(priv->dma, tx_chan_num(0),
 				       cpsw_tx_handler);
+	if (IS_ERR(priv->txch)) {
+		dev_err(priv->dev, "error initializing tx dma channel\n");
+		ret =3D PTR_ERR(priv->txch);
+		goto clean_dma_ret;
+	}
+
 	priv->rxch =3D cpdma_chan_create(priv->dma, rx_chan_num(0),
 				       cpsw_rx_handler);
-
-	if (WARN_ON(!priv->txch || !priv->rxch)) {
-		dev_err(priv->dev, "error initializing dma channels\n");
-		ret =3D -ENOMEM;
+	if (IS_ERR(priv->rxch)) {
+		dev_err(priv->dev, "error initializing rx dma channel\n");
+		ret =3D PTR_ERR(priv->rxch);
 		goto clean_dma_ret;
 	}
=20
diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet=
/ti/davinci_cpdma.c
index 4a000f6dd6fc..619b815f9bac 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -503,7 +503,7 @@ struct cpdma_chan *cpdma_chan_create(struct cpdma_ctlr =
*ctlr, int chan_num,
 	unsigned long flags;
=20
 	if (__chan_linear(chan_num) >=3D ctlr->num_chan)
-		return NULL;
+		return ERR_PTR(-EINVAL);
=20
 	chan =3D devm_kzalloc(ctlr->dev, sizeof(*chan), GFP_KERNEL);
 	if (!chan)
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/=
ti/davinci_emac.c
index 16d95002b9c1..547bb8827897 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1537,7 +1537,13 @@ static int emac_dev_open(struct net_device *ndev)
 	int i =3D 0;
 	struct emac_priv *priv =3D netdev_priv(ndev);
=20
-	pm_runtime_get(&priv->pdev->dev);
+	ret =3D pm_runtime_get_sync(&priv->pdev->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&priv->pdev->dev);
+		dev_err(&priv->pdev->dev, "%s: failed to get_sync(%d)\n",
+			__func__, ret);
+		return ret;
+	}
=20
 	netif_carrier_off(ndev);
 	for (cnt =3D 0; cnt < ETH_ALEN; cnt++)
@@ -1724,6 +1730,15 @@ static struct net_device_stats *emac_dev_getnetstats=
(struct net_device *ndev)
 	struct emac_priv *priv =3D netdev_priv(ndev);
 	u32 mac_control;
 	u32 stats_clear_mask;
+	int err;
+
+	err =3D pm_runtime_get_sync(&priv->pdev->dev);
+	if (err < 0) {
+		pm_runtime_put_noidle(&priv->pdev->dev);
+		dev_err(&priv->pdev->dev, "%s: failed to get_sync(%d)\n",
+			__func__, err);
+		return &ndev->stats;
+	}
=20
 	/* update emac hardware stats and reset the registers*/
=20
@@ -1766,6 +1781,8 @@ static struct net_device_stats *emac_dev_getnetstats(=
struct net_device *ndev)
 	ndev->stats.tx_fifo_errors +=3D emac_read(EMAC_TXUNDERRUN);
 	emac_write(EMAC_TXUNDERRUN, stats_clear_mask);
=20
+	pm_runtime_put(&priv->pdev->dev);
+
 	return &ndev->stats;
 }
=20
@@ -1951,18 +1968,25 @@ static int davinci_emac_probe(struct platform_devic=
e *pdev)
=20
 	priv->txchan =3D cpdma_chan_create(priv->dma, tx_chan_num(EMAC_DEF_TX_CH),
 				       emac_tx_handler);
+	if (IS_ERR(priv->txchan)) {
+		dev_err(&pdev->dev, "error initializing tx dma channel\n");
+		rc =3D PTR_ERR(priv->txchan);
+		goto err_free_dma;
+	}
+
 	priv->rxchan =3D cpdma_chan_create(priv->dma, rx_chan_num(EMAC_DEF_RX_CH),
 				       emac_rx_handler);
-	if (WARN_ON(!priv->txchan || !priv->rxchan)) {
-		rc =3D -ENOMEM;
-		goto no_cpdma_chan;
+	if (IS_ERR(priv->rxchan)) {
+		dev_err(&pdev->dev, "error initializing rx dma channel\n");
+		rc =3D PTR_ERR(priv->rxchan);
+		goto err_free_txchan;
 	}
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "error getting irq res\n");
 		rc =3D -ENOENT;
-		goto no_cpdma_chan;
+		goto err_free_rxchan;
 	}
 	ndev->irq =3D res->start;
=20
@@ -1978,13 +2002,23 @@ static int davinci_emac_probe(struct platform_devic=
e *pdev)
 	ndev->ethtool_ops =3D &ethtool_ops;
 	netif_napi_add(ndev, &priv->napi, emac_poll, EMAC_POLL_WEIGHT);
=20
+	pm_runtime_enable(&pdev->dev);
+	rc =3D pm_runtime_get_sync(&pdev->dev);
+	if (rc < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		dev_err(&pdev->dev, "%s: failed to get_sync(%d)\n",
+			__func__, rc);
+		goto err_napi_del;
+	}
+
 	/* register the network device */
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 	rc =3D register_netdev(ndev);
 	if (rc) {
 		dev_err(&pdev->dev, "error in register_netdev\n");
 		rc =3D -ENODEV;
-		goto no_cpdma_chan;
+		pm_runtime_put(&pdev->dev);
+		goto err_napi_del;
 	}
=20
=20
@@ -1993,17 +2027,17 @@ static int davinci_emac_probe(struct platform_devic=
e *pdev)
 			   "(regs: %p, irq: %d)\n",
 			   (void *)priv->emac_base_phys, ndev->irq);
 	}
-
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_resume(&pdev->dev);
+	pm_runtime_put(&pdev->dev);
=20
 	return 0;
=20
-no_cpdma_chan:
-	if (priv->txchan)
-		cpdma_chan_destroy(priv->txchan);
-	if (priv->rxchan)
-		cpdma_chan_destroy(priv->rxchan);
+err_napi_del:
+	netif_napi_del(&priv->napi);
+err_free_rxchan:
+	cpdma_chan_destroy(priv->rxchan);
+err_free_txchan:
+	cpdma_chan_destroy(priv->txchan);
+err_free_dma:
 	cpdma_ctlr_destroy(priv->dma);
 no_pdata:
 	free_netdev(ndev);
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 03054f55073c..9e69c66ac896 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -269,9 +269,9 @@ static void ppp_ccp_peek(struct ppp *ppp, struct sk_buf=
f *skb, int inbound);
 static void ppp_ccp_closed(struct ppp *ppp);
 static struct compressor *find_compressor(int type);
 static void ppp_get_stats(struct ppp *ppp, struct ppp_stats *st);
-static struct ppp *ppp_create_interface(struct net *net, int unit, int *re=
tp);
+static struct ppp *ppp_create_interface(struct net *net, int unit,
+					struct file *file, int *retp);
 static void init_ppp_file(struct ppp_file *pf, int kind);
-static void ppp_shutdown_interface(struct ppp *ppp);
 static void ppp_destroy_interface(struct ppp *ppp);
 static struct ppp *ppp_find_unit(struct ppp_net *pn, int unit);
 static struct channel *ppp_find_channel(struct ppp_net *pn, int unit);
@@ -392,8 +392,10 @@ static int ppp_release(struct inode *unused, struct fi=
le *file)
 		file->private_data =3D NULL;
 		if (pf->kind =3D=3D INTERFACE) {
 			ppp =3D PF_TO_PPP(pf);
+			rtnl_lock();
 			if (file =3D=3D ppp->owner)
-				ppp_shutdown_interface(ppp);
+				unregister_netdevice(ppp->dev);
+			rtnl_unlock();
 		}
 		if (atomic_dec_and_test(&pf->refcnt)) {
 			switch (pf->kind) {
@@ -582,28 +584,13 @@ static long ppp_ioctl(struct file *file, unsigned int=
 cmd, unsigned long arg)
=20
 	if (cmd =3D=3D PPPIOCDETACH) {
 		/*
-		 * We have to be careful here... if the file descriptor
-		 * has been dup'd, we could have another process in the
-		 * middle of a poll using the same file *, so we had
-		 * better not free the interface data structures -
-		 * instead we fail the ioctl.  Even in this case, we
-		 * shut down the interface if we are the owner of it.
-		 * Actually, we should get rid of PPPIOCDETACH, userland
-		 * (i.e. pppd) could achieve the same effect by closing
-		 * this fd and reopening /dev/ppp.
+		 * PPPIOCDETACH is no longer supported as it was heavily broken,
+		 * and is only known to have been used by pppd older than
+		 * ppp-2.4.2 (released November 2003).
 		 */
+		pr_warn_once("%s (%d) used obsolete PPPIOCDETACH ioctl\n",
+			     current->comm, current->pid);
 		err =3D -EINVAL;
-		if (pf->kind =3D=3D INTERFACE) {
-			ppp =3D PF_TO_PPP(pf);
-			if (file =3D=3D ppp->owner)
-				ppp_shutdown_interface(ppp);
-		}
-		if (atomic_long_read(&file->f_count) < 2) {
-			ppp_release(NULL, file);
-			err =3D 0;
-		} else
-			pr_warn("PPPIOCDETACH file->f_count=3D%ld\n",
-				atomic_long_read(&file->f_count));
 		goto out;
 	}
=20
@@ -833,11 +820,10 @@ static int ppp_unattached_ioctl(struct net *net, stru=
ct ppp_file *pf,
 		/* Create a new ppp unit */
 		if (get_user(unit, p))
 			break;
-		ppp =3D ppp_create_interface(net, unit, &err);
+		ppp =3D ppp_create_interface(net, unit, file, &err);
 		if (!ppp)
 			break;
 		file->private_data =3D &ppp->file;
-		ppp->owner =3D file;
 		err =3D -EFAULT;
 		if (put_user(ppp->file.index, p))
 			break;
@@ -911,6 +897,16 @@ static __net_init int ppp_init_net(struct net *net)
 static __net_exit void ppp_exit_net(struct net *net)
 {
 	struct ppp_net *pn =3D net_generic(net, ppp_net_id);
+	struct ppp *ppp;
+	LIST_HEAD(list);
+	int id;
+
+	rtnl_lock();
+	idr_for_each_entry(&pn->units_idr, ppp, id)
+		unregister_netdevice_queue(ppp->dev, &list);
+
+	unregister_netdevice_many(&list);
+	rtnl_unlock();
=20
 	idr_destroy(&pn->units_idr);
 }
@@ -1079,12 +1075,51 @@ ppp_get_stats64(struct net_device *dev, struct rtnl=
_link_stats64 *stats64)
 static struct lock_class_key ppp_tx_busylock;
 static int ppp_dev_init(struct net_device *dev)
 {
+	struct ppp *ppp;
+
 	dev->qdisc_tx_busylock =3D &ppp_tx_busylock;
+
+	ppp =3D netdev_priv(dev);
+	/* Let the netdevice take a reference on the ppp file. This ensures
+	 * that ppp_destroy_interface() won't run before the device gets
+	 * unregistered.
+	 */
+	atomic_inc(&ppp->file.refcnt);
+
 	return 0;
 }
=20
+static void ppp_dev_uninit(struct net_device *dev)
+{
+	struct ppp *ppp =3D netdev_priv(dev);
+	struct ppp_net *pn =3D ppp_pernet(ppp->ppp_net);
+
+	ppp_lock(ppp);
+	ppp->closing =3D 1;
+	ppp_unlock(ppp);
+
+	mutex_lock(&pn->all_ppp_mutex);
+	unit_put(&pn->units_idr, ppp->file.index);
+	mutex_unlock(&pn->all_ppp_mutex);
+
+	ppp->owner =3D NULL;
+
+	ppp->file.dead =3D 1;
+	wake_up_interruptible(&ppp->file.rwait);
+}
+
+static void ppp_dev_priv_destructor(struct net_device *dev)
+{
+	struct ppp *ppp;
+
+	ppp =3D netdev_priv(dev);
+	if (atomic_dec_and_test(&ppp->file.refcnt))
+		ppp_destroy_interface(ppp);
+}
+
 static const struct net_device_ops ppp_netdev_ops =3D {
 	.ndo_init	 =3D ppp_dev_init,
+	.ndo_uninit      =3D ppp_dev_uninit,
 	.ndo_start_xmit  =3D ppp_start_xmit,
 	.ndo_do_ioctl    =3D ppp_net_ioctl,
 	.ndo_get_stats64 =3D ppp_get_stats64,
@@ -1101,6 +1136,7 @@ static void ppp_setup(struct net_device *dev)
 	dev->flags =3D IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->features |=3D NETIF_F_NETNS_LOCAL;
 	dev->priv_flags &=3D ~IFF_XMIT_DST_RELEASE;
+	dev->destructor =3D ppp_dev_priv_destructor;
 }
=20
 /*
@@ -2662,8 +2698,8 @@ ppp_get_stats(struct ppp *ppp, struct ppp_stats *st)
  * or if there is already a unit with the requested number.
  * unit =3D=3D -1 means allocate a new number.
  */
-static struct ppp *
-ppp_create_interface(struct net *net, int unit, int *retp)
+static struct ppp *ppp_create_interface(struct net *net, int unit,
+					struct file *file, int *retp)
 {
 	struct ppp *ppp;
 	struct ppp_net *pn;
@@ -2679,9 +2715,11 @@ ppp_create_interface(struct net *net, int unit, int =
*retp)
=20
 	ppp =3D netdev_priv(dev);
 	ppp->dev =3D dev;
+	ppp->ppp_net =3D net;
 	ppp->mru =3D PPP_MRU;
 	init_ppp_file(&ppp->file, INTERFACE);
 	ppp->file.hdrlen =3D PPP_HDRLEN - 2;	/* don't count proto bytes */
+	ppp->owner =3D file;
 	for (i =3D 0; i < NUM_NP; ++i)
 		ppp->npmode[i] =3D NPMODE_PASS;
 	INIT_LIST_HEAD(&ppp->channels);
@@ -2702,6 +2740,7 @@ ppp_create_interface(struct net *net, int unit, int *=
retp)
 	 */
 	dev_net_set(dev, net);
=20
+	rtnl_lock();
 	mutex_lock(&pn->all_ppp_mutex);
=20
 	if (unit < 0) {
@@ -2732,18 +2771,25 @@ ppp_create_interface(struct net *net, int unit, int=
 *retp)
 	ppp->file.index =3D unit;
 	sprintf(dev->name, "ppp%d", unit);
=20
-	ret =3D register_netdev(dev);
+	mutex_unlock(&pn->all_ppp_mutex);
+
+	ret =3D register_netdevice(dev);
 	if (ret !=3D 0) {
+		/* register_netdevice() may have called ppp_dev_init()
+		 * but will not have called our destructor, so do that
+		 * now.
+		 */
+		if (dev->qdisc_tx_busylock)
+			ppp_dev_priv_destructor(dev);
+		mutex_lock(&pn->all_ppp_mutex);
 		unit_put(&pn->units_idr, unit);
 		netdev_err(ppp->dev, "PPP: couldn't register device %s (%d)\n",
 			   dev->name, ret);
 		goto out2;
 	}
=20
-	ppp->ppp_net =3D net;
-
 	atomic_inc(&ppp_unit_count);
-	mutex_unlock(&pn->all_ppp_mutex);
+	rtnl_unlock();
=20
 	*retp =3D 0;
 	return ppp;
@@ -2769,34 +2815,6 @@ init_ppp_file(struct ppp_file *pf, int kind)
 	init_waitqueue_head(&pf->rwait);
 }
=20
-/*
- * Take down a ppp interface unit - called when the owning file
- * (the one that created the unit) is closed or detached.
- */
-static void ppp_shutdown_interface(struct ppp *ppp)
-{
-	struct ppp_net *pn;
-
-	pn =3D ppp_pernet(ppp->ppp_net);
-	mutex_lock(&pn->all_ppp_mutex);
-
-	/* This will call dev_close() for us. */
-	ppp_lock(ppp);
-	if (!ppp->closing) {
-		ppp->closing =3D 1;
-		ppp_unlock(ppp);
-		unregister_netdev(ppp->dev);
-		unit_put(&pn->units_idr, ppp->file.index);
-	} else
-		ppp_unlock(ppp);
-
-	ppp->file.dead =3D 1;
-	ppp->owner =3D NULL;
-	wake_up_interruptible(&ppp->file.rwait);
-
-	mutex_unlock(&pn->all_ppp_mutex);
-}
-
 /*
  * Free the memory used by a ppp unit.  This is only called once
  * there are no channels connected to the unit and no file structs
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 38712e0b719c..942b887d2d27 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -615,6 +615,10 @@ static int pppoe_connect(struct socket *sock, struct s=
ockaddr *uservaddr,
 	lock_sock(sk);
=20
 	error =3D -EINVAL;
+
+	if (sockaddr_len !=3D sizeof(struct sockaddr_pppox))
+		goto end;
+
 	if (sp->sa_protocol !=3D PX_PROTO_OE)
 		goto end;
=20
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 6b38cbafef09..d0f9aa4c59fc 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -253,6 +253,17 @@ static void __team_option_inst_mark_removed_port(struc=
t team *team,
 	}
 }
=20
+static bool __team_option_inst_tmp_find(const struct list_head *opts,
+					const struct team_option_inst *needle)
+{
+	struct team_option_inst *opt_inst;
+
+	list_for_each_entry(opt_inst, opts, tmp_list)
+		if (opt_inst =3D=3D needle)
+			return true;
+	return false;
+}
+
 static int __team_options_register(struct team *team,
 				   const struct team_option *option,
 				   size_t option_count)
@@ -1041,14 +1052,11 @@ static void team_port_leave(struct team *team, stru=
ct team_port *port)
 }
=20
 #ifdef CONFIG_NET_POLL_CONTROLLER
-static int team_port_enable_netpoll(struct team *team, struct team_port *p=
ort)
+static int __team_port_enable_netpoll(struct team_port *port)
 {
 	struct netpoll *np;
 	int err;
=20
-	if (!team->dev->npinfo)
-		return 0;
-
 	np =3D kzalloc(sizeof(*np), GFP_KERNEL);
 	if (!np)
 		return -ENOMEM;
@@ -1062,6 +1070,14 @@ static int team_port_enable_netpoll(struct team *tea=
m, struct team_port *port)
 	return err;
 }
=20
+static int team_port_enable_netpoll(struct team_port *port)
+{
+	if (!port->team->dev->npinfo)
+		return 0;
+
+	return __team_port_enable_netpoll(port);
+}
+
 static void team_port_disable_netpoll(struct team_port *port)
 {
 	struct netpoll *np =3D port->np;
@@ -1076,7 +1092,7 @@ static void team_port_disable_netpoll(struct team_por=
t *port)
 	kfree(np);
 }
 #else
-static int team_port_enable_netpoll(struct team *team, struct team_port *p=
ort)
+static int team_port_enable_netpoll(struct team_port *port)
 {
 	return 0;
 }
@@ -1164,7 +1180,7 @@ static int team_port_add(struct team *team, struct ne=
t_device *port_dev)
 		goto err_vids_add;
 	}
=20
-	err =3D team_port_enable_netpoll(team, port);
+	err =3D team_port_enable_netpoll(port);
 	if (err) {
 		netdev_err(dev, "Failed to enable netpoll on device %s\n",
 			   portname);
@@ -1869,7 +1885,7 @@ static int team_netpoll_setup(struct net_device *dev,
=20
 	mutex_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list) {
-		err =3D team_port_enable_netpoll(team, port);
+		err =3D __team_port_enable_netpoll(port);
 		if (err) {
 			__team_netpoll_cleanup(team);
 			break;
@@ -2520,6 +2536,14 @@ static int team_nl_cmd_options_set(struct sk_buff *s=
kb, struct genl_info *info)
 			if (err)
 				goto team_put;
 			opt_inst->changed =3D true;
+
+			/* dumb/evil user-space can send us duplicate opt,
+			 * keep only the last one
+			 */
+			if (__team_option_inst_tmp_find(&opt_inst_list,
+							opt_inst))
+				continue;
+
 			list_add(&opt_inst->tmp_list, &opt_inst_list);
 		}
 		if (!opt_found) {
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 010ff1a92747..fff2c6f26b8b 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -677,6 +677,7 @@ static const struct usb_device_id products[] =3D {
 	{QMI_FIXED_INTF(0x05c6, 0x9080, 8)},
 	{QMI_FIXED_INTF(0x05c6, 0x9083, 3)},
 	{QMI_FIXED_INTF(0x05c6, 0x9084, 4)},
+	{QMI_FIXED_INTF(0x05c6, 0x90b2, 3)},    /* ublox R410M */
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 0)},
 	{QMI_FIXED_INTF(0x05c6, 0x920d, 5)},
 	{QMI_FIXED_INTF(0x0846, 0x68a2, 8)},
@@ -898,6 +899,18 @@ static int qmi_wwan_probe(struct usb_interface *intf,
 		id->driver_info =3D (unsigned long)&qmi_wwan_info;
 	}
=20
+	/* There are devices where the same interface number can be
+	 * configured as different functions. We should only bind to
+	 * vendor specific functions when matching on interface number
+	 */
+	if (id->match_flags & USB_DEVICE_ID_MATCH_INT_NUMBER &&
+	    desc->bInterfaceClass !=3D USB_CLASS_VENDOR_SPEC) {
+		dev_dbg(&intf->dev,
+			"Rejecting interface number match for class %02x\n",
+			desc->bInterfaceClass);
+		return -ENODEV;
+	}
+
 	/* Quectel EC20 quirk where we've QMI on interface 4 instead of 0 */
 	if (quectel_ec20_detected(intf) && desc->bInterfaceNumber =3D=3D 0) {
 		dev_dbg(&intf->dev, "Quectel EC20 quirk, skipping interface 0\n");
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet=
3_drv.c
index b76f7dcde0db..f8996dd66368 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -587,6 +587,12 @@ vmxnet3_rq_alloc_rx_buf(struct vmxnet3_rx_queue *rq, u=
32 ring_idx,
 						&adapter->pdev->dev,
 						rbi->skb->data, rbi->len,
 						PCI_DMA_FROMDEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      rbi->dma_addr)) {
+					dev_kfree_skb_any(rbi->skb);
+					rq->stats.rx_buf_alloc_failure++;
+					break;
+				}
 			} else {
 				/* rx buffer skipped by the device */
 			}
@@ -605,13 +611,18 @@ vmxnet3_rq_alloc_rx_buf(struct vmxnet3_rx_queue *rq, =
u32 ring_idx,
 						&adapter->pdev->dev,
 						rbi->page, 0, PAGE_SIZE,
 						PCI_DMA_FROMDEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      rbi->dma_addr)) {
+					put_page(rbi->page);
+					rq->stats.rx_buf_alloc_failure++;
+					break;
+				}
 			} else {
 				/* rx buffers skipped by the device */
 			}
 			val =3D VMXNET3_RXD_BTYPE_BODY << VMXNET3_RXD_BTYPE_SHIFT;
 		}
=20
-		BUG_ON(rbi->dma_addr =3D=3D 0);
 		gd->rxd.addr =3D cpu_to_le64(rbi->dma_addr);
 		gd->dword[2] =3D cpu_to_le32((!ring->gen << VMXNET3_RXD_GEN_SHIFT)
 					   | val | rbi->len);
@@ -655,7 +666,7 @@ vmxnet3_append_frag(struct sk_buff *skb, struct Vmxnet3=
_RxCompDesc *rcd,
 }
=20
=20
-static void
+static int
 vmxnet3_map_pkt(struct sk_buff *skb, struct vmxnet3_tx_ctx *ctx,
 		struct vmxnet3_tx_queue *tq, struct pci_dev *pdev,
 		struct vmxnet3_adapter *adapter)
@@ -715,6 +726,8 @@ vmxnet3_map_pkt(struct sk_buff *skb, struct vmxnet3_tx_=
ctx *ctx,
 		tbi->dma_addr =3D dma_map_single(&adapter->pdev->dev,
 				skb->data + buf_offset, buf_size,
 				PCI_DMA_TODEVICE);
+		if (dma_mapping_error(&adapter->pdev->dev, tbi->dma_addr))
+			return -EFAULT;
=20
 		tbi->len =3D buf_size;
=20
@@ -755,6 +768,8 @@ vmxnet3_map_pkt(struct sk_buff *skb, struct vmxnet3_tx_=
ctx *ctx,
 			tbi->dma_addr =3D skb_frag_dma_map(&adapter->pdev->dev, frag,
 							 buf_offset, buf_size,
 							 DMA_TO_DEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev, tbi->dma_addr))
+				return -EFAULT;
=20
 			tbi->len =3D buf_size;
=20
@@ -782,6 +797,8 @@ vmxnet3_map_pkt(struct sk_buff *skb, struct vmxnet3_tx_=
ctx *ctx,
 	/* set the last buf_info for the pkt */
 	tbi->skb =3D skb;
 	tbi->sop_idx =3D ctx->sop_txd - tq->tx_ring.base;
+
+	return 0;
 }
=20
=20
@@ -1006,7 +1023,8 @@ vmxnet3_tq_xmit(struct sk_buff *skb, struct vmxnet3_t=
x_queue *tq,
 	}
=20
 	/* fill tx descs related to addr & len */
-	vmxnet3_map_pkt(skb, &ctx, tq, adapter->pdev, adapter);
+	if (vmxnet3_map_pkt(skb, &ctx, tq, adapter->pdev, adapter))
+		goto unlock_drop_pkt;
=20
 	/* setup the EOP desc */
 	ctx.eop_txd->dword[3] =3D cpu_to_le32(VMXNET3_TXD_CQ | VMXNET3_TXD_EOP);
@@ -1170,6 +1188,7 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 		struct vmxnet3_rx_buf_info *rbi;
 		struct sk_buff *skb, *new_skb =3D NULL;
 		struct page *new_page =3D NULL;
+		dma_addr_t new_dma_addr;
 		int num_to_alloc;
 		struct Vmxnet3_RxDesc *rxd;
 		u32 idx, ring_idx;
@@ -1227,6 +1246,21 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 				skip_page_frags =3D true;
 				goto rcd_done;
 			}
+			new_dma_addr =3D dma_map_single(&adapter->pdev->dev,
+						      new_skb->data, rbi->len,
+						      PCI_DMA_FROMDEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev,
+					      new_dma_addr)) {
+				dev_kfree_skb(new_skb);
+				/* Skb allocation failed, do not handover this
+				 * skb to stack. Reuse it. Drop the existing pkt
+				 */
+				rq->stats.rx_buf_alloc_failure++;
+				ctx->skb =3D NULL;
+				rq->stats.drop_total++;
+				skip_page_frags =3D true;
+				goto rcd_done;
+			}
=20
 			dma_unmap_single(&adapter->pdev->dev, rbi->dma_addr,
 					 rbi->len,
@@ -1243,9 +1277,7 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
=20
 			/* Immediate refill */
 			rbi->skb =3D new_skb;
-			rbi->dma_addr =3D dma_map_single(&adapter->pdev->dev,
-						       rbi->skb->data, rbi->len,
-						       PCI_DMA_FROMDEVICE);
+			rbi->dma_addr =3D new_dma_addr;
 			rxd->addr =3D cpu_to_le64(rbi->dma_addr);
 			rxd->len =3D rbi->len;
=20
@@ -1275,6 +1307,19 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 				skip_page_frags =3D true;
 				goto rcd_done;
 			}
+			new_dma_addr =3D dma_map_page(&adapter->pdev->dev,
+						rbi->page,
+						0, PAGE_SIZE,
+						PCI_DMA_FROMDEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev,
+					      new_dma_addr)) {
+				put_page(new_page);
+				rq->stats.rx_buf_alloc_failure++;
+				dev_kfree_skb(ctx->skb);
+				ctx->skb =3D NULL;
+				skip_page_frags =3D true;
+				goto rcd_done;
+			}
=20
 			if (rcd->len) {
 				dma_unmap_page(&adapter->pdev->dev,
@@ -1286,10 +1331,7 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
=20
 			/* Immediate refill */
 			rbi->page =3D new_page;
-			rbi->dma_addr =3D dma_map_page(&adapter->pdev->dev,
-						     rbi->page,
-						     0, PAGE_SIZE,
-						     PCI_DMA_FROMDEVICE);
+			rbi->dma_addr =3D new_dma_addr;
 			rxd->addr =3D cpu_to_le64(rbi->dma_addr);
 			rxd->len =3D rbi->len;
 		}
@@ -2036,6 +2078,7 @@ vmxnet3_set_mc(struct net_device *netdev)
 					&adapter->shared->devRead.rxFilterConf;
 	u8 *new_table =3D NULL;
 	dma_addr_t new_table_pa =3D 0;
+	bool new_table_pa_valid =3D false;
 	u32 new_mode =3D VMXNET3_RXM_UCAST;
=20
 	if (netdev->flags & IFF_PROMISC) {
@@ -2056,7 +2099,6 @@ vmxnet3_set_mc(struct net_device *netdev)
 		if (!netdev_mc_empty(netdev)) {
 			new_table =3D vmxnet3_copy_mc(netdev);
 			if (new_table) {
-				new_mode |=3D VMXNET3_RXM_MCAST;
 				rxConf->mfTableLen =3D cpu_to_le16(
 					netdev_mc_count(netdev) * ETH_ALEN);
 				new_table_pa =3D dma_map_single(
@@ -2064,15 +2106,21 @@ vmxnet3_set_mc(struct net_device *netdev)
 							new_table,
 							rxConf->mfTableLen,
 							PCI_DMA_TODEVICE);
-				rxConf->mfTablePA =3D cpu_to_le64(new_table_pa);
-			} else {
-				netdev_info(netdev, "failed to copy mcast list"
-					    ", setting ALL_MULTI\n");
+				if (!dma_mapping_error(&adapter->pdev->dev,
+						       new_table_pa)) {
+					new_mode |=3D VMXNET3_RXM_MCAST;
+					new_table_pa_valid =3D true;
+					rxConf->mfTablePA =3D cpu_to_le64(
+								new_table_pa);
+				}
+			}
+			if (!new_table_pa_valid) {
+				netdev_info(netdev,
+					    "failed to copy mcast list, setting ALL_MULTI\n");
 				new_mode |=3D VMXNET3_RXM_ALL_MULTI;
 			}
 		}
=20
-
 	if (!(new_mode & VMXNET3_RXM_MCAST)) {
 		rxConf->mfTableLen =3D 0;
 		rxConf->mfTablePA =3D 0;
@@ -2091,11 +2139,10 @@ vmxnet3_set_mc(struct net_device *netdev)
 			       VMXNET3_CMD_UPDATE_MAC_FILTERS);
 	spin_unlock_irqrestore(&adapter->cmd_lock, flags);
=20
-	if (new_table) {
+	if (new_table_pa_valid)
 		dma_unmap_single(&adapter->pdev->dev, new_table_pa,
 				 rxConf->mfTableLen, PCI_DMA_TODEVICE);
-		kfree(new_table);
-	}
+	kfree(new_table);
 }
=20
 void
@@ -2398,7 +2445,7 @@ vmxnet3_set_mac_addr(struct net_device *netdev, void =
*p)
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D initializa=
tion and cleanup routines =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
=20
 static int
-vmxnet3_alloc_pci_resources(struct vmxnet3_adapter *adapter, bool *dma64)
+vmxnet3_alloc_pci_resources(struct vmxnet3_adapter *adapter)
 {
 	int err;
 	unsigned long mmio_start, mmio_len;
@@ -2410,30 +2457,12 @@ vmxnet3_alloc_pci_resources(struct vmxnet3_adapter =
*adapter, bool *dma64)
 		return err;
 	}
=20
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) =3D=3D 0) {
-		if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64)) !=3D 0) {
-			dev_err(&pdev->dev,
-				"pci_set_consistent_dma_mask failed\n");
-			err =3D -EIO;
-			goto err_set_mask;
-		}
-		*dma64 =3D true;
-	} else {
-		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32)) !=3D 0) {
-			dev_err(&pdev->dev,
-				"pci_set_dma_mask failed\n");
-			err =3D -EIO;
-			goto err_set_mask;
-		}
-		*dma64 =3D false;
-	}
-
 	err =3D pci_request_selected_regions(pdev, (1 << 2) - 1,
 					   vmxnet3_driver_name);
 	if (err) {
 		dev_err(&pdev->dev,
 			"Failed to request region for adapter: error %d\n", err);
-		goto err_set_mask;
+		goto err_enable_device;
 	}
=20
 	pci_set_master(pdev);
@@ -2461,7 +2490,7 @@ vmxnet3_alloc_pci_resources(struct vmxnet3_adapter *a=
dapter, bool *dma64)
 	iounmap(adapter->hw_addr0);
 err_ioremap:
 	pci_release_selected_regions(pdev, (1 << 2) - 1);
-err_set_mask:
+err_enable_device:
 	pci_disable_device(pdev);
 	return err;
 }
@@ -2926,7 +2955,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 #endif
 	};
 	int err;
-	bool dma64 =3D false; /* stupid gcc */
+	bool dma64;
 	u32 ver;
 	struct net_device *netdev;
 	struct vmxnet3_adapter *adapter;
@@ -2971,10 +3000,33 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	adapter->tx_ring_size =3D VMXNET3_DEF_TX_RING_SIZE;
 	adapter->rx_ring_size =3D VMXNET3_DEF_RX_RING_SIZE;
=20
+	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) =3D=3D 0) {
+		if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64)) !=3D 0) {
+			dev_err(&pdev->dev,
+				"pci_set_consistent_dma_mask failed\n");
+			err =3D -EIO;
+			goto err_set_mask;
+		}
+		dma64 =3D true;
+	} else {
+		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32)) !=3D 0) {
+			dev_err(&pdev->dev,
+				"pci_set_dma_mask failed\n");
+			err =3D -EIO;
+			goto err_set_mask;
+		}
+		dma64 =3D false;
+	}
+
 	spin_lock_init(&adapter->cmd_lock);
 	adapter->adapter_pa =3D dma_map_single(&adapter->pdev->dev, adapter,
 					     sizeof(struct vmxnet3_adapter),
 					     PCI_DMA_TODEVICE);
+	if (dma_mapping_error(&adapter->pdev->dev, adapter->adapter_pa)) {
+		dev_err(&pdev->dev, "Failed to map dma\n");
+		err =3D -EFAULT;
+		goto err_set_mask;
+	}
 	adapter->shared =3D dma_alloc_coherent(
 				&adapter->pdev->dev,
 				sizeof(struct Vmxnet3_DriverShared),
@@ -3024,7 +3076,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 	}
 #endif /* VMXNET3_RSS */
=20
-	err =3D vmxnet3_alloc_pci_resources(adapter, &dma64);
+	err =3D vmxnet3_alloc_pci_resources(adapter);
 	if (err < 0)
 		goto err_alloc_pci;
=20
@@ -3128,6 +3180,7 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 err_alloc_shared:
 	dma_unmap_single(&adapter->pdev->dev, adapter->adapter_pa,
 			 sizeof(struct vmxnet3_adapter), PCI_DMA_TODEVICE);
+err_set_mask:
 	free_netdev(netdev);
 	return err;
 }
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet=
3_int.h
index 29ee77f2c97f..10219fc9e38b 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -69,10 +69,12 @@
 /*
  * Version numbers
  */
-#define VMXNET3_DRIVER_VERSION_STRING   "1.2.0.0-k"
+#define VMXNET3_DRIVER_VERSION_STRING   "1.2.2.0-k"
=20
-/* a 32-bit int, each byte encode a verion number in VMXNET3_DRIVER_VERSIO=
N */
-#define VMXNET3_DRIVER_VERSION_NUM      0x01020000
+/* Each byte of this 32-bit integer encodes a version number in
+ * VMXNET3_DRIVER_VERSION_STRING.
+ */
+#define VMXNET3_DRIVER_VERSION_NUM      0x01020200
=20
 #if defined(CONFIG_PCI_MSI)
 	/* RSS only makes sense if MSI-X is supported. */
diff --git a/drivers/net/wireless/rtl818x/rtl8187/dev.c b/drivers/net/wirel=
ess/rtl818x/rtl8187/dev.c
index 629ad8cfa17b..6952aaa232f7 100644
--- a/drivers/net/wireless/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/rtl818x/rtl8187/dev.c
@@ -1454,6 +1454,7 @@ static int rtl8187_probe(struct usb_interface *intf,
 		goto err_free_dev;
 	}
 	mutex_init(&priv->io_mutex);
+	mutex_init(&priv->conf_mutex);
=20
 	SET_IEEE80211_DEV(dev, &intf->dev);
 	usb_set_intfdata(intf, dev);
@@ -1627,7 +1628,6 @@ static int rtl8187_probe(struct usb_interface *intf,
 		printk(KERN_ERR "rtl8187: Cannot register device\n");
 		goto err_free_dmabuf;
 	}
-	mutex_init(&priv->conf_mutex);
 	skb_queue_head_init(&priv->b_tx_status.queue);
=20
 	wiphy_info(dev->wiphy, "hwaddr %pM, %s V%d + %s, rfkill mask %d\n",
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 76ee7750bc5e..6b9737d392e2 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2616,6 +2616,7 @@ enum parport_pc_pci_cards {
 	netmos_9901,
 	netmos_9865,
 	quatech_sppxp100,
+	wch_ch382l,
 };
=20
=20
@@ -2678,6 +2679,7 @@ static struct parport_pc_pci {
 	/* netmos_9901 */               { 1, { { 0, -1 }, } },
 	/* netmos_9865 */               { 1, { { 0, -1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
+	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
 };
=20
 static const struct pci_device_id parport_pc_pci_tbl[] =3D {
@@ -2767,6 +2769,8 @@ static const struct pci_device_id parport_pc_pci_tbl[=
] =3D {
 	/* Quatech SPPXP-100 Parallel port PCI ExpressCard */
 	{ PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SPPXP_100,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
+	/* WCH CH382L PCI-E single parallel port card */
+	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382l },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, parport_pc_pci_tbl);
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpip=
hp_glue.c
index 0e7399056e23..5e71f485d9ba 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -601,6 +601,7 @@ static unsigned int get_slot_status(struct acpiphp_slot=
 *slot)
 {
 	unsigned long long sta =3D 0;
 	struct acpiphp_func *func;
+	u32 dvid;
=20
 	list_for_each_entry(func, &slot->funcs, sibling) {
 		if (func->flags & FUNC_HAS_STA) {
@@ -611,19 +612,27 @@ static unsigned int get_slot_status(struct acpiphp_sl=
ot *slot)
 			if (ACPI_SUCCESS(status) && sta)
 				break;
 		} else {
-			u32 dvid;
-
-			pci_bus_read_config_dword(slot->bus,
-						  PCI_DEVFN(slot->device,
-							    func->function),
-						  PCI_VENDOR_ID, &dvid);
-			if (dvid !=3D 0xffffffff) {
+			if (pci_bus_read_dev_vendor_id(slot->bus,
+					PCI_DEVFN(slot->device, func->function),
+					&dvid, 0)) {
 				sta =3D ACPI_STA_ALL;
 				break;
 			}
 		}
 	}
=20
+	if (!sta) {
+		/*
+		 * Check for the slot itself since it may be that the
+		 * ACPI slot is a device below PCIe upstream port so in
+		 * that case it may not even be reachable yet.
+		 */
+		if (pci_bus_read_dev_vendor_id(slot->bus,
+				PCI_DEVFN(slot->device, 0), &dvid, 0)) {
+			sta =3D ACPI_STA_ALL;
+		}
+	}
+
 	return (unsigned int)sta;
 }
=20
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 354026cf7ce9..35a6fc073730 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1648,6 +1648,19 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2609,=
 quirk_intel_pcie_pm);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260a, quirk_intel_pcie_pm);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260b, quirk_intel_pcie_pm);
=20
+static void quirk_radeon_pm(struct pci_dev *dev)
+{
+	if (dev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &&
+	    dev->subsystem_device =3D=3D 0x00e2) {
+		if (dev->d3_delay < 20) {
+			dev->d3_delay =3D 20;
+			dev_info(&dev->dev, "extending delay after power-on from D3 to %d msec\=
n",
+				 dev->d3_delay);
+		}
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
+
 #ifdef CONFIG_X86_IO_APIC
 static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
 {
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-sin=
gle.c
index 0d19ac11ab9e..925018da84ad 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -562,9 +562,25 @@ static int pcs_request_gpio(struct pinctrl_dev *pctlde=
v,
 			|| pin < frange->offset)
 			continue;
 		mux_bytes =3D pcs->width / BITS_PER_BYTE;
-		data =3D pcs->read(pcs->base + pin * mux_bytes) & ~pcs->fmask;
-		data |=3D frange->gpiofunc;
-		pcs->write(data, pcs->base + pin * mux_bytes);
+
+		if (pcs->bits_per_mux) {
+			int byte_num, offset, pin_shift;
+
+			byte_num =3D (pcs->bits_per_pin * pin) / BITS_PER_BYTE;
+			offset =3D (byte_num / mux_bytes) * mux_bytes;
+			pin_shift =3D pin % (pcs->width / pcs->bits_per_pin) *
+				    pcs->bits_per_pin;
+
+			data =3D pcs->read(pcs->base + offset);
+			data &=3D ~(pcs->fmask << pin_shift);
+			data |=3D frange->gpiofunc << pin_shift;
+			pcs->write(data, pcs->base + offset);
+		} else {
+			data =3D pcs->read(pcs->base + pin * mux_bytes);
+			data &=3D ~pcs->fmask;
+			data |=3D frange->gpiofunc;
+			pcs->write(data, pcs->base + pin * mux_bytes);
+		}
 		break;
 	}
 	return 0;
diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index fa384fe28988..90beb49e7382 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -130,20 +130,23 @@ static int snvs_rtc_set_time(struct device *dev, stru=
ct rtc_time *tm)
 {
 	struct snvs_rtc_data *data =3D dev_get_drvdata(dev);
 	unsigned long time;
+	int ret;
=20
 	rtc_tm_to_time(tm, &time);
=20
 	/* Disable RTC first */
-	snvs_rtc_enable(data, false);
+	ret =3D snvs_rtc_enable(data, false);
+	if (ret)
+		return ret;
=20
 	/* Write 32-bit time to 47-bit timer, leaving 15 LSBs blank */
 	writel(time << CNTR_TO_SECS_SH, data->ioaddr + SNVS_LPSRTCLR);
 	writel(time >> (32 - CNTR_TO_SECS_SH), data->ioaddr + SNVS_LPSRTCMR);
=20
 	/* Enable RTC again */
-	snvs_rtc_enable(data, true);
+	ret =3D snvs_rtc_enable(data, true);
=20
-	return 0;
+	return ret;
 }
=20
 static int snvs_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -271,7 +274,11 @@ static int snvs_rtc_probe(struct platform_device *pdev)
 	writel(0xffffffff, data->ioaddr + SNVS_LPSR);
=20
 	/* Enable RTC */
-	snvs_rtc_enable(data, true);
+	ret =3D snvs_rtc_enable(data, true);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable rtc %d\n", ret);
+		return ret;
+	}
=20
 	device_init_wakeup(&pdev->dev, true);
=20
diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 2e678c681b13..5d91852af497 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -86,7 +86,8 @@ static int tx4939_rtc_read_time(struct device *dev, struc=
t rtc_time *tm)
 	for (i =3D 2; i < 6; i++)
 		buf[i] =3D __raw_readl(&rtcreg->dat);
 	spin_unlock_irq(&pdata->lock);
-	sec =3D (buf[5] << 24) | (buf[4] << 16) | (buf[3] << 8) | buf[2];
+	sec =3D ((unsigned long)buf[5] << 24) | (buf[4] << 16) |
+		(buf[3] << 8) | buf[2];
 	rtc_time_to_tm(sec, tm);
 	return rtc_valid_tm(tm);
 }
@@ -147,7 +148,8 @@ static int tx4939_rtc_read_alarm(struct device *dev, st=
ruct rtc_wkalrm *alrm)
 	alrm->enabled =3D (ctl & TX4939_RTCCTL_ALME) ? 1 : 0;
 	alrm->pending =3D (ctl & TX4939_RTCCTL_ALMD) ? 1 : 0;
 	spin_unlock_irq(&pdata->lock);
-	sec =3D (buf[5] << 24) | (buf[4] << 16) | (buf[3] << 8) | buf[2];
+	sec =3D ((unsigned long)buf[5] << 24) | (buf[4] << 16) |
+		(buf[3] << 8) | buf[2];
 	rtc_time_to_tm(sec, &alrm->time);
 	return rtc_valid_tm(&alrm->time);
 }
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alia=
s.c
index 6a64e86e8ccd..0aa661f3e453 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -608,18 +608,26 @@ static int _schedule_lcu_update(struct alias_lcu *lcu,
=20
 int dasd_alias_add_device(struct dasd_device *device)
 {
-	struct dasd_eckd_private *private;
-	struct alias_lcu *lcu;
+	struct dasd_eckd_private *private =3D device->private;
+	__u8 uaddr =3D private->uid.real_unit_addr;
+	struct alias_lcu *lcu =3D private->lcu;
 	unsigned long flags;
 	int rc;
=20
-	private =3D (struct dasd_eckd_private *) device->private;
-	lcu =3D private->lcu;
 	rc =3D 0;
=20
 	/* need to take cdev lock before lcu lock */
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	spin_lock(&lcu->lock);
+	/*
+	 * Check if device and lcu type differ. If so, the uac data may be
+	 * outdated and needs to be updated.
+	 */
+	if (private->uid.type !=3D  lcu->uac->unit[uaddr].ua_type) {
+		lcu->flags |=3D UPDATE_PENDING;
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
+			      "uid type mismatch - trigger rescan");
+	}
 	if (!(lcu->flags & UPDATE_PENDING)) {
 		rc =3D _add_device_to_lcu(lcu, device, device);
 		if (rc)
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index e3bf885f4a6c..d5f02c3da878 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -362,6 +362,7 @@ static void chsc_process_sei_link_incident(struct chsc_=
sei_nt0_area *sei_area)
=20
 static void chsc_process_sei_res_acc(struct chsc_sei_nt0_area *sei_area)
 {
+	struct channel_path *chp;
 	struct chp_link link;
 	struct chp_id chpid;
 	int status;
@@ -374,10 +375,17 @@ static void chsc_process_sei_res_acc(struct chsc_sei_=
nt0_area *sei_area)
 	chpid.id =3D sei_area->rsid;
 	/* allocate a new channel path structure, if needed */
 	status =3D chp_get_status(chpid);
-	if (status < 0)
-		chp_new(chpid);
-	else if (!status)
+	if (!status)
 		return;
+
+	if (status < 0) {
+		chp_new(chpid);
+	} else {
+		chp =3D chpid_to_chp(chpid);
+		mutex_lock(&chp->lock);
+		chp_update_desc(chp);
+		mutex_unlock(&chp->lock);
+	}
 	memset(&link, 0, sizeof(struct chp_link));
 	link.chpid =3D chpid;
 	if ((sei_area->vf & 0xc0) !=3D 0) {
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 848e3b64ea6e..fb7298920c8c 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -126,7 +126,7 @@ static inline int qdio_check_ccq(struct qdio_q *q, unsi=
gned int ccq)
 static int qdio_do_eqbs(struct qdio_q *q, unsigned char *state,
 			int start, int count, int auto_ack)
 {
-	int rc, tmp_count =3D count, tmp_start =3D start, nr =3D q->nr, retried =
=3D 0;
+	int rc, tmp_count =3D count, tmp_start =3D start, nr =3D q->nr;
 	unsigned int ccq =3D 0;
=20
 	qperf_inc(q, eqbs);
@@ -149,14 +149,7 @@ static int qdio_do_eqbs(struct qdio_q *q, unsigned cha=
r *state,
 		qperf_inc(q, eqbs_partial);
 		DBF_DEV_EVENT(DBF_WARN, q->irq_ptr, "EQBS part:%02x",
 			tmp_count);
-		/*
-		 * Retry once, if that fails bail out and process the
-		 * extracted buffers before trying again.
-		 */
-		if (!retried++)
-			goto again;
-		else
-			return count - tmp_count;
+		return count - tmp_count;
 	}
=20
 	DBF_ERROR("%4x EQBS ERROR", SCH_NO(q));
@@ -212,7 +205,10 @@ static int qdio_do_sqbs(struct qdio_q *q, unsigned cha=
r state, int start,
 	return 0;
 }
=20
-/* returns number of examined buffers and their common state in *state */
+/*
+ * Returns number of examined buffers and their common state in *state.
+ * Requested number of buffers-to-examine must be > 0.
+ */
 static inline int get_buf_states(struct qdio_q *q, unsigned int bufnr,
 				 unsigned char *state, unsigned int count,
 				 int auto_ack, int merge_pending)
@@ -223,17 +219,23 @@ static inline int get_buf_states(struct qdio_q *q, un=
signed int bufnr,
 	if (is_qebsm(q))
 		return qdio_do_eqbs(q, state, bufnr, count, auto_ack);
=20
-	for (i =3D 0; i < count; i++) {
-		if (!__state) {
-			__state =3D q->slsb.val[bufnr];
-			if (merge_pending && __state =3D=3D SLSB_P_OUTPUT_PENDING)
-				__state =3D SLSB_P_OUTPUT_EMPTY;
-		} else if (merge_pending) {
-			if ((q->slsb.val[bufnr] & __state) !=3D __state)
-				break;
-		} else if (q->slsb.val[bufnr] !=3D __state)
-			break;
+	/* get initial state: */
+	__state =3D q->slsb.val[bufnr];
+	if (merge_pending && __state =3D=3D SLSB_P_OUTPUT_PENDING)
+		__state =3D SLSB_P_OUTPUT_EMPTY;
+
+	for (i =3D 1; i < count; i++) {
 		bufnr =3D next_buf(bufnr);
+
+		/* merge PENDING into EMPTY: */
+		if (merge_pending &&
+		    q->slsb.val[bufnr] =3D=3D SLSB_P_OUTPUT_PENDING &&
+		    __state =3D=3D SLSB_P_OUTPUT_EMPTY)
+			continue;
+
+		/* stop if next state differs from initial state: */
+		if (q->slsb.val[bufnr] !=3D __state)
+			break;
 	}
 	*state =3D __state;
 	return i;
diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index f5f4a91fab44..2c707f8a3521 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -90,7 +90,7 @@ static int __qdio_allocate_qs(struct qdio_q **irq_ptr_qs,=
 int nr_queues)
 	int i;
=20
 	for (i =3D 0; i < nr_queues; i++) {
-		q =3D kmem_cache_alloc(qdio_q_cache, GFP_KERNEL);
+		q =3D kmem_cache_zalloc(qdio_q_cache, GFP_KERNEL);
 		if (!q)
 			return -ENOMEM;
=20
@@ -406,7 +406,6 @@ int qdio_setup_irq(struct qdio_initialize *init_data)
 {
 	struct ciw *ciw;
 	struct qdio_irq *irq_ptr =3D init_data->cdev->private->qdio_data;
-	int rc;
=20
 	memset(&irq_ptr->qib, 0, sizeof(irq_ptr->qib));
 	memset(&irq_ptr->siga_flag, 0, sizeof(irq_ptr->siga_flag));
@@ -443,16 +442,14 @@ int qdio_setup_irq(struct qdio_initialize *init_data)
 	ciw =3D ccw_device_get_ciw(init_data->cdev, CIW_TYPE_EQUEUE);
 	if (!ciw) {
 		DBF_ERROR("%4x NO EQ", irq_ptr->schid.sch_no);
-		rc =3D -EINVAL;
-		goto out_err;
+		return -EINVAL;
 	}
 	irq_ptr->equeue =3D *ciw;
=20
 	ciw =3D ccw_device_get_ciw(init_data->cdev, CIW_TYPE_AQUEUE);
 	if (!ciw) {
 		DBF_ERROR("%4x NO AQ", irq_ptr->schid.sch_no);
-		rc =3D -EINVAL;
-		goto out_err;
+		return -EINVAL;
 	}
 	irq_ptr->aqueue =3D *ciw;
=20
@@ -460,9 +457,6 @@ int qdio_setup_irq(struct qdio_initialize *init_data)
 	irq_ptr->orig_handler =3D init_data->cdev->handler;
 	init_data->cdev->handler =3D qdio_int_handler;
 	return 0;
-out_err:
-	qdio_release_memory(irq_ptr);
-	return rc;
 }
=20
 void qdio_print_subchannel_info(struct qdio_irq *irq_ptr,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core=
_main.c
index 0aacf78d5b19..035529daf379 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5832,10 +5832,14 @@ static int __init qeth_core_init(void)
 	mutex_init(&qeth_mod_mutex);
=20
 	qeth_wq =3D create_singlethread_workqueue("qeth_wq");
+	if (!qeth_wq) {
+		rc =3D -ENOMEM;
+		goto out_err;
+	}
=20
 	rc =3D qeth_register_dbf_views();
 	if (rc)
-		goto out_err;
+		goto dbf_err;
 	qeth_core_root_dev =3D root_device_register("qeth");
 	rc =3D PTR_ERR_OR_ZERO(qeth_core_root_dev);
 	if (rc)
@@ -5872,6 +5876,8 @@ static int __init qeth_core_init(void)
 	root_device_unregister(qeth_core_root_dev);
 register_err:
 	qeth_unregister_dbf_views();
+dbf_err:
+	destroy_workqueue(qeth_wq);
 out_err:
 	pr_err("Initializing the qeth device driver failed\n");
 	return rc;
diff --git a/drivers/s390/scsi/zfcp_dbf.c b/drivers/s390/scsi/zfcp_dbf.c
index 581f5e0ab10a..f22aeb3bab8a 100644
--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -3,7 +3,7 @@
  *
  * Debug traces for zfcp.
  *
- * Copyright IBM Corp. 2002, 2017
+ * Copyright IBM Corp. 2002, 2018
  */
=20
 #define KMSG_COMPONENT "zfcp"
@@ -287,6 +287,27 @@ void zfcp_dbf_rec_trig(char *tag, struct zfcp_adapter =
*adapter,
 	spin_unlock_irqrestore(&dbf->rec_lock, flags);
 }
=20
+/**
+ * zfcp_dbf_rec_trig_lock - trace event related to triggered recovery with=
 lock
+ * @tag: identifier for event
+ * @adapter: adapter on which the erp_action should run
+ * @port: remote port involved in the erp_action
+ * @sdev: scsi device involved in the erp_action
+ * @want: wanted erp_action
+ * @need: required erp_action
+ *
+ * The adapter->erp_lock must not be held.
+ */
+void zfcp_dbf_rec_trig_lock(char *tag, struct zfcp_adapter *adapter,
+			    struct zfcp_port *port, struct scsi_device *sdev,
+			    u8 want, u8 need)
+{
+	unsigned long flags;
+
+	read_lock_irqsave(&adapter->erp_lock, flags);
+	zfcp_dbf_rec_trig(tag, adapter, port, sdev, want, need);
+	read_unlock_irqrestore(&adapter->erp_lock, flags);
+}
=20
 /**
  * zfcp_dbf_rec_run_lvl - trace event related to running recovery
diff --git a/drivers/s390/scsi/zfcp_ext.h b/drivers/s390/scsi/zfcp_ext.h
index 0c8c8b8fc1de..35420ef81de3 100644
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -3,7 +3,7 @@
  *
  * External function declarations.
  *
- * Copyright IBM Corp. 2002, 2016
+ * Copyright IBM Corp. 2002, 2018
  */
=20
 #ifndef ZFCP_EXT_H
@@ -34,6 +34,9 @@ extern int zfcp_dbf_adapter_register(struct zfcp_adapter =
*);
 extern void zfcp_dbf_adapter_unregister(struct zfcp_adapter *);
 extern void zfcp_dbf_rec_trig(char *, struct zfcp_adapter *,
 			      struct zfcp_port *, struct scsi_device *, u8, u8);
+extern void zfcp_dbf_rec_trig_lock(char *tag, struct zfcp_adapter *adapter,
+				   struct zfcp_port *port,
+				   struct scsi_device *sdev, u8 want, u8 need);
 extern void zfcp_dbf_rec_run(char *, struct zfcp_erp_action *);
 extern void zfcp_dbf_rec_run_lvl(int level, char *tag,
 				 struct zfcp_erp_action *erp);
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index 0c03ae19b689..2c6cdc22533b 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -3,7 +3,7 @@
  *
  * Interface to Linux SCSI midlayer.
  *
- * Copyright IBM Corp. 2002, 2017
+ * Copyright IBM Corp. 2002, 2018
  */
=20
 #define KMSG_COMPONENT "zfcp"
@@ -637,9 +637,9 @@ static void zfcp_scsi_rport_register(struct zfcp_port *=
port)
 	ids.port_id =3D port->d_id;
 	ids.roles =3D FC_RPORT_ROLE_FCP_TARGET;
=20
-	zfcp_dbf_rec_trig("scpaddy", port->adapter, port, NULL,
-			  ZFCP_PSEUDO_ERP_ACTION_RPORT_ADD,
-			  ZFCP_PSEUDO_ERP_ACTION_RPORT_ADD);
+	zfcp_dbf_rec_trig_lock("scpaddy", port->adapter, port, NULL,
+			       ZFCP_PSEUDO_ERP_ACTION_RPORT_ADD,
+			       ZFCP_PSEUDO_ERP_ACTION_RPORT_ADD);
 	rport =3D fc_remote_port_add(port->adapter->scsi_host, 0, &ids);
 	if (!rport) {
 		dev_err(&port->adapter->ccw_device->dev,
@@ -661,9 +661,9 @@ static void zfcp_scsi_rport_block(struct zfcp_port *por=
t)
 	struct fc_rport *rport =3D port->rport;
=20
 	if (rport) {
-		zfcp_dbf_rec_trig("scpdely", port->adapter, port, NULL,
-				  ZFCP_PSEUDO_ERP_ACTION_RPORT_DEL,
-				  ZFCP_PSEUDO_ERP_ACTION_RPORT_DEL);
+		zfcp_dbf_rec_trig_lock("scpdely", port->adapter, port, NULL,
+				       ZFCP_PSEUDO_ERP_ACTION_RPORT_DEL,
+				       ZFCP_PSEUDO_ERP_ACTION_RPORT_DEL);
 		fc_remote_port_delete(rport);
 		port->rport =3D NULL;
 	}
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_ini=
t.c
index e2184412617d..a70d1947629a 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -363,7 +363,8 @@ qla24xx_abort_sp_done(void *data, void *ptr, int res)
 	srb_t *sp =3D (srb_t *)ptr;
 	struct srb_iocb *abt =3D &sp->u.iocb_cmd;
=20
-	complete(&abt->u.abt.comp);
+	if (del_timer(&sp->u.iocb_cmd.timer))
+		complete(&abt->u.abt.comp);
 }
=20
 static int
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index c50cfd16a976..f88e3748cb18 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1832,6 +1832,8 @@ sd_spinup_disk(struct scsi_disk *sdkp)
 				break;	/* standby */
 			if (sshdr.asc =3D=3D 4 && sshdr.ascq =3D=3D 0xc)
 				break;	/* unavailable */
+			if (sshdr.asc =3D=3D 4 && sshdr.ascq =3D=3D 0x1b)
+				break;	/* sanitize in progress */
 			/*
 			 * Issue command to spin up drive when not ready
 			 */
diff --git a/drivers/staging/line6/midi.c b/drivers/staging/line6/midi.c
index 1ac343b649c1..9c0ca7d3d76f 100644
--- a/drivers/staging/line6/midi.c
+++ b/drivers/staging/line6/midi.c
@@ -135,7 +135,7 @@ static int send_midi_async(struct usb_line6 *line6, uns=
igned char *data,
 	}
=20
 	usb_fill_int_urb(urb, line6->usbdev,
-			 usb_sndbulkpipe(line6->usbdev,
+			 usb_sndintpipe(line6->usbdev,
 					 line6->ep_control_write),
 			 transfer_buffer, length, midi_sent, line6,
 			 line6->interval);
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl81=
92u/r8192U_core.c
index 24272c51bc9d..c551545c1f8e 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1893,6 +1893,8 @@ static short rtl8192_usb_initendpoints(struct net_dev=
ice *dev)
=20
 		priv->rx_urb[16] =3D usb_alloc_urb(0, GFP_KERNEL);
 		priv->oldaddr =3D kmalloc(16, GFP_KERNEL);
+		if (!priv->oldaddr)
+			return -ENOMEM;
 		oldaddr =3D priv->oldaddr;
 		align =3D ((long)oldaddr) & 3;
 		if (align) {
diff --git a/drivers/staging/usbip/usbip_common.h b/drivers/staging/usbip/u=
sbip_common.h
index 01be15a2066e..58787c49fb68 100644
--- a/drivers/staging/usbip/usbip_common.h
+++ b/drivers/staging/usbip/usbip_common.h
@@ -248,7 +248,7 @@ enum usbip_side {
 #define	SDEV_EVENT_ERROR_SUBMIT	(USBIP_EH_SHUTDOWN | USBIP_EH_RESET)
 #define	SDEV_EVENT_ERROR_MALLOC	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
=20
-#define	VDEV_EVENT_REMOVED	(USBIP_EH_SHUTDOWN | USBIP_EH_BYE)
+#define	VDEV_EVENT_REMOVED (USBIP_EH_SHUTDOWN | USBIP_EH_RESET | USBIP_EH_=
BYE)
 #define	VDEV_EVENT_DOWN		(USBIP_EH_SHUTDOWN | USBIP_EH_RESET)
 #define	VDEV_EVENT_ERROR_TCP	(USBIP_EH_SHUTDOWN | USBIP_EH_RESET)
 #define	VDEV_EVENT_ERROR_MALLOC	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
diff --git a/drivers/staging/usbip/vhci_hcd.c b/drivers/staging/usbip/vhci_=
hcd.c
index 2ae3b63741bd..30fcbac8f162 100644
--- a/drivers/staging/usbip/vhci_hcd.c
+++ b/drivers/staging/usbip/vhci_hcd.c
@@ -266,6 +266,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 ty=
peReq, u16 wValue,
 		usbip_dbg_vhci_rh(" ClearHubFeature\n");
 		break;
 	case ClearPortFeature:
+		if (rhport < 0)
+			goto error;
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 			if (dum->port_status[rhport] & USB_PORT_STAT_SUSPEND) {
@@ -370,6 +372,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 ty=
peReq, u16 wValue,
 		case USB_PORT_FEAT_RESET:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_RESET\n");
+			if (rhport < 0)
+				goto error;
 			/* if it's already running, disconnect first */
 			if (dum->port_status[rhport] & USB_PORT_STAT_ENABLE) {
 				dum->port_status[rhport] &=3D
@@ -385,6 +389,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 ty=
peReq, u16 wValue,
 		default:
 			usbip_dbg_vhci_rh(" SetPortFeature: default %d\n",
 					  wValue);
+			if (rhport < 0)
+				goto error;
 			dum->port_status[rhport] |=3D (1 << wValue);
 			break;
 		}
@@ -392,7 +398,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 ty=
peReq, u16 wValue,
=20
 	default:
 		pr_err("default: no such request\n");
-
+error:
 		/* "protocol stall" on error */
 		retval =3D -EPIPE;
 	}
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 2c516f2eebed..0678f12cae02 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -422,14 +422,6 @@ static int imx_thermal_probe(struct platform_device *p=
dev)
 	if (data->irq < 0)
 		return data->irq;
=20
-	ret =3D devm_request_threaded_irq(&pdev->dev, data->irq,
-			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
-			0, "imx_thermal", data);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, data);
=20
 	ret =3D imx_get_sensor_data(pdev);
@@ -495,6 +487,17 @@ static int imx_thermal_probe(struct platform_device *p=
dev)
 	data->irq_enabled =3D true;
 	data->mode =3D THERMAL_DEVICE_ENABLED;
=20
+	ret =3D devm_request_threaded_irq(&pdev->dev, data->irq,
+			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
+			0, "imx_thermal", data);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
+		clk_disable_unprepare(data->thermal_clk);
+		thermal_zone_device_unregister(data->tz);
+		cpufreq_cooling_unregister(data->cdev);
+		return ret;
+	}
+
 	return 0;
 }
=20
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 58ad1c05b7f8..dd9d779c64d4 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_TTY)		+=3D tty_io.o n_tty.o tty_ioctl.o tty_ldisc.o \
-				   tty_buffer.o tty_port.o tty_mutex.o tty_ldsem.o
+				   tty_buffer.o tty_port.o tty_mutex.o \
+				   tty_ldsem.o n_null.o
 obj-$(CONFIG_LEGACY_PTYS)	+=3D pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+=3D pty.o
 obj-$(CONFIG_AUDIT)		+=3D tty_audit.o
diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
new file mode 100644
index 000000000000..d63261c36e42
--- /dev/null
+++ b/drivers/tty/n_null.c
@@ -0,0 +1,80 @@
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/tty.h>
+#include <linux/module.h>
+
+/*
+ *  n_null.c - Null line discipline used in the failure path
+ *
+ *  Copyright (C) Intel 2017
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
+ */
+
+static int n_null_open(struct tty_struct *tty)
+{
+	return 0;
+}
+
+static void n_null_close(struct tty_struct *tty)
+{
+}
+
+static ssize_t n_null_read(struct tty_struct *tty, struct file *file,
+			   unsigned char __user * buf, size_t nr)
+{
+	return -EOPNOTSUPP;
+}
+
+static ssize_t n_null_write(struct tty_struct *tty, struct file *file,
+			    const unsigned char *buf, size_t nr)
+{
+	return -EOPNOTSUPP;
+}
+
+static void n_null_receivebuf(struct tty_struct *tty,
+				 const unsigned char *cp, char *fp,
+				 int cnt)
+{
+}
+
+static struct tty_ldisc_ops null_ldisc =3D {
+	.owner		=3D	THIS_MODULE,
+	.magic		=3D	TTY_LDISC_MAGIC,
+	.name		=3D	"n_null",
+	.open		=3D	n_null_open,
+	.close		=3D	n_null_close,
+	.read		=3D	n_null_read,
+	.write		=3D	n_null_write,
+	.receive_buf	=3D	n_null_receivebuf
+};
+
+static int __init n_null_init(void)
+{
+	BUG_ON(tty_register_ldisc(N_NULL, &null_ldisc));
+	return 0;
+}
+
+static void __exit n_null_exit(void)
+{
+	tty_unregister_ldisc(N_NULL);
+}
+
+module_init(n_null_init);
+module_exit(n_null_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alan Cox");
+MODULE_ALIAS_LDISC(N_NULL);
+MODULE_DESCRIPTION("Null ldisc driver");
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index c3f9b9920d8d..4cf54fe45d99 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -319,7 +319,7 @@ static int pty_resize(struct tty_struct *tty,  struct w=
insize *ws)
  *	pty_common_install		-	set up the pty pair
  *	@driver: the pty driver
  *	@tty: the tty being instantiated
- *	@bool: legacy, true if this is BSD style
+ *	@legacy: true if this is BSD style
  *
  *	Perform the initial set up for the tty/pty pair. Called from the
  *	tty layer when the port is first opened.
@@ -334,18 +334,17 @@ static int pty_common_install(struct tty_driver *driv=
er, struct tty_struct *tty,
 	int idx =3D tty->index;
 	int retval =3D -ENOMEM;
=20
-	o_tty =3D alloc_tty_struct();
-	if (!o_tty)
-		goto err;
 	ports[0] =3D kmalloc(sizeof **ports, GFP_KERNEL);
 	ports[1] =3D kmalloc(sizeof **ports, GFP_KERNEL);
 	if (!ports[0] || !ports[1])
-		goto err_free_tty;
+		goto err;
 	if (!try_module_get(driver->other->owner)) {
 		/* This cannot in fact currently happen */
-		goto err_free_tty;
+		goto err;
 	}
-	initialize_tty_struct(o_tty, driver->other, idx);
+	o_tty =3D alloc_tty_struct(driver->other, idx);
+	if (!o_tty)
+		goto err_put_module;
=20
 	if (legacy) {
 		/* We always use new tty termios data so we can do this
@@ -390,12 +389,12 @@ static int pty_common_install(struct tty_driver *driv=
er, struct tty_struct *tty,
 		tty_free_termios(tty);
 err_deinit_tty:
 	deinitialize_tty_struct(o_tty);
-	module_put(o_tty->driver->owner);
-err_free_tty:
-	kfree(ports[0]);
-	kfree(ports[1]);
 	free_tty_struct(o_tty);
+err_put_module:
+	module_put(driver->other->owner);
 err:
+	kfree(ports[0]);
+	kfree(ports[1]);
 	return retval;
 }
=20
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_u=
art.c
index 323376668b72..3695897fac39 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -335,7 +335,7 @@ static int altera_uart_startup(struct uart_port *port)
=20
 	/* Enable RX interrupts now */
 	pp->imr =3D ALTERA_UART_CONTROL_RRDY_MSK;
-	writel(pp->imr, port->membase + ALTERA_UART_CONTROL_REG);
+	altera_uart_writel(port, pp->imr, ALTERA_UART_CONTROL_REG);
=20
 	spin_unlock_irqrestore(&port->lock, flags);
=20
@@ -351,7 +351,7 @@ static void altera_uart_shutdown(struct uart_port *port)
=20
 	/* Disable all interrupts now */
 	pp->imr =3D 0;
-	writel(pp->imr, port->membase + ALTERA_UART_CONTROL_REG);
+	altera_uart_writel(port, pp->imr, ALTERA_UART_CONTROL_REG);
=20
 	spin_unlock_irqrestore(&port->lock, flags);
=20
@@ -441,7 +441,7 @@ static void altera_uart_console_putc(struct uart_port *=
port, const char c)
 		 ALTERA_UART_STATUS_TRDY_MSK))
 		cpu_relax();
=20
-	writel(c, port->membase + ALTERA_UART_TXDATA_REG);
+	altera_uart_writel(port, c, ALTERA_UART_TXDATA_REG);
 }
=20
 static void altera_uart_console_write(struct console *co, const char *s,
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 008c223eaf26..99c567ee18d3 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -531,8 +531,14 @@ arc_uart_init_one(struct platform_device *pdev, int de=
v_id)
 {
 	struct resource *res, *res2;
 	unsigned long *plat_data;
-	struct arc_uart_port *uart =3D &arc_uart_ports[dev_id];
+	struct arc_uart_port *uart;
=20
+	if (dev_id >=3D ARRAY_SIZE(arc_uart_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", dev_id);
+		return -EINVAL;
+	}
+
+	uart =3D &arc_uart_ports[dev_id];
 	plat_data =3D dev_get_platdata(&pdev->dev);
 	if (!plat_data)
 		return -ENODEV;
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuar=
t.c
index 2b49f2abd8b5..aff7c5d63a53 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1170,6 +1170,10 @@ static int lpuart_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
 		return ret;
 	}
+	if (ret >=3D ARRAY_SIZE(lpuart_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", ret);
+		return -EINVAL;
+	}
 	sport->port.line =3D ret;
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e30e52e378fe..7450561a2326 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1919,6 +1919,12 @@ static int serial_imx_probe(struct platform_device *=
pdev)
 	else if (ret < 0)
 		return ret;
=20
+	if (sport->port.line >=3D ARRAY_SIZE(imx_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n",
+			sport->port.line);
+		return -EINVAL;
+	}
+
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base =3D devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 7f4bc4845100..8f6d6b5a2eeb 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1050,6 +1050,11 @@ static int mxs_auart_probe(struct platform_device *p=
dev)
 		s->port.line =3D pdev->id < 0 ? 0 : pdev->id;
 	else if (ret < 0)
 		goto out_free;
+	if (s->port.line >=3D ARRAY_SIZE(auart_port)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", s->port.line);
+		ret =3D -EINVAL;
+		goto out_free;
+	}
=20
 	if (of_id) {
 		pdev->id_entry =3D of_id->data;
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index c638c53cd2b6..94c6994e4060 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -888,6 +888,10 @@ static int serial_pxa_probe(struct platform_device *de=
v)
 		sport->port.line =3D dev->id;
 	else if (ret < 0)
 		goto err_clk;
+	if (sport->port.line >=3D ARRAY_SIZE(serial_pxa_ports)) {
+		dev_err(&dev->dev, "serial%d out of range\n", sport->port.line);
+		return -EINVAL;
+	}
 	snprintf(sport->name, PXA_NAME_LEN - 1, "UART%d", sport->port.line + 1);
=20
 	sport->port.membase =3D ioremap(mmres->start, resource_size(mmres));
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx=
_uartps.c
index efbfddf93471..0f646cb2e130 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1007,7 +1007,7 @@ static struct uart_port *cdns_uart_get_port(int id)
 	struct uart_port *port;
=20
 	/* Try the given port id if failed use default method */
-	if (cdns_uart_port[id].mapbase !=3D 0) {
+	if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase !=3D 0) {
 		/* Find the next unused port */
 		for (id =3D 0; id < CDNS_UART_NR_PORTS; id++)
 			if (cdns_uart_port[id].mapbase =3D=3D 0)
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index d121de6f3b89..5ab3e0b7d2a7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -156,20 +156,6 @@ static void release_tty(struct tty_struct *tty, int id=
x);
 static void __proc_set_tty(struct task_struct *tsk, struct tty_struct *tty=
);
 static void proc_set_tty(struct task_struct *tsk, struct tty_struct *tty);
=20
-/**
- *	alloc_tty_struct	-	allocate a tty object
- *
- *	Return a new empty tty structure. The data fields have not
- *	been initialized in any way but has been zeroed
- *
- *	Locking: none
- */
-
-struct tty_struct *alloc_tty_struct(void)
-{
-	return kzalloc(sizeof(struct tty_struct), GFP_KERNEL);
-}
-
 /**
  *	free_tty_struct		-	free a disused tty
  *	@tty: tty struct to free
@@ -1455,12 +1441,11 @@ struct tty_struct *tty_init_dev(struct tty_driver *=
driver, int idx)
 	if (!try_module_get(driver->owner))
 		return ERR_PTR(-ENODEV);
=20
-	tty =3D alloc_tty_struct();
+	tty =3D alloc_tty_struct(driver, idx);
 	if (!tty) {
 		retval =3D -ENOMEM;
 		goto err_module_put;
 	}
-	initialize_tty_struct(tty, driver, idx);
=20
 	tty_lock(tty);
 	retval =3D tty_driver_install_tty(driver, tty);
@@ -3034,22 +3019,27 @@ static struct device *tty_get_device(struct tty_str=
uct *tty)
=20
=20
 /**
- *	initialize_tty_struct
- *	@tty: tty to initialize
+ *	alloc_tty_struct
  *
- *	This subroutine initializes a tty structure that has been newly
- *	allocated.
+ *	This subroutine allocates and initializes a tty structure.
  *
- *	Locking: none - tty in question must not be exposed at this point
+ *	Locking: none - tty in question is not exposed at this point
  */
=20
-void initialize_tty_struct(struct tty_struct *tty,
-		struct tty_driver *driver, int idx)
+struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 {
-	memset(tty, 0, sizeof(struct tty_struct));
+	struct tty_struct *tty;
+
+	tty =3D kzalloc(sizeof(*tty), GFP_KERNEL);
+	if (!tty)
+		return NULL;
+
 	kref_init(&tty->kref);
 	tty->magic =3D TTY_MAGIC;
-	tty_ldisc_init(tty);
+	if (tty_ldisc_init(tty)) {
+		kfree(tty);
+		return NULL;
+	}
 	tty->session =3D NULL;
 	tty->pgrp =3D NULL;
 	mutex_init(&tty->legacy_mutex);
@@ -3070,6 +3060,8 @@ void initialize_tty_struct(struct tty_struct *tty,
 	tty->index =3D idx;
 	tty_line_name(driver, idx, tty->name);
 	tty->dev =3D tty_get_device(tty);
+
+	return tty;
 }
=20
 /**
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 2bf08366cd5b..a35e4b633254 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -171,12 +171,11 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_str=
uct *tty, int disc)
 			return ERR_CAST(ldops);
 	}
=20
-	ld =3D kmalloc(sizeof(struct tty_ldisc), GFP_KERNEL);
-	if (ld =3D=3D NULL) {
-		put_ldops(ldops);
-		return ERR_PTR(-ENOMEM);
-	}
-
+	/*
+	 * There is no way to handle allocation failure of only 16 bytes.
+	 * Let's simplify error handling and save more memory.
+	 */
+	ld =3D kmalloc(sizeof(struct tty_ldisc), GFP_KERNEL | __GFP_NOFAIL);
 	ld->ops =3D ldops;
 	ld->tty =3D tty;
=20
@@ -473,6 +472,29 @@ static void tty_ldisc_close(struct tty_struct *tty, st=
ruct tty_ldisc *ld)
 		ld->ops->close(tty);
 }
=20
+/**
+ *	tty_ldisc_failto	-	helper for ldisc failback
+ *	@tty: tty to open the ldisc on
+ *	@ld: ldisc we are trying to fail back to
+ *
+ *	Helper to try and recover a tty when switching back to the old
+ *	ldisc fails and we need something attached.
+ */
+
+static int tty_ldisc_failto(struct tty_struct *tty, int ld)
+{
+	struct tty_ldisc *disc =3D tty_ldisc_get(tty, ld);
+	int r;
+
+	if (IS_ERR(disc))
+		return PTR_ERR(disc);
+	tty->ldisc =3D disc;
+	tty_set_termios_ldisc(tty, ld);
+	if ((r =3D tty_ldisc_open(tty, disc)) < 0)
+		tty_ldisc_put(disc);
+	return r;
+}
+
 /**
  *	tty_ldisc_restore	-	helper for tty ldisc change
  *	@tty: tty to recover
@@ -485,27 +507,18 @@ static void tty_ldisc_close(struct tty_struct *tty, s=
truct tty_ldisc *ld)
 static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *ol=
d)
 {
 	char buf[64];
-	struct tty_ldisc *new_ldisc;
-	int r;
=20
 	/* There is an outstanding reference here so this is safe */
-	old =3D tty_ldisc_get(tty, old->ops->num);
-	WARN_ON(IS_ERR(old));
-	tty->ldisc =3D old;
-	tty_set_termios_ldisc(tty, old->ops->num);
-	if (tty_ldisc_open(tty, old) < 0) {
-		tty_ldisc_put(old);
-		/* This driver is always present */
-		new_ldisc =3D tty_ldisc_get(tty, N_TTY);
-		if (IS_ERR(new_ldisc))
-			panic("n_tty: get");
-		tty->ldisc =3D new_ldisc;
-		tty_set_termios_ldisc(tty, N_TTY);
-		r =3D tty_ldisc_open(tty, new_ldisc);
-		if (r < 0)
-			panic("Couldn't open N_TTY ldisc for "
-			      "%s --- error %d.",
-			      tty_name(tty, buf), r);
+	if (tty_ldisc_failto(tty, old->ops->num) < 0) {
+		const char *name =3D tty_name(tty, buf);
+
+		pr_warn("Falling back ldisc for %s.\n", name);
+		/* The traditional behaviour is to fall back to N_TTY, we
+		   want to avoid falling back to N_NULL unless we have no
+		   choice to avoid the risk of breaking anything */
+		if (tty_ldisc_failto(tty, N_TTY) < 0 &&
+		    tty_ldisc_failto(tty, N_NULL) < 0)
+			panic("Couldn't open N_NULL ldisc for %s.", name);
 	}
 }
=20
@@ -806,12 +819,13 @@ void tty_ldisc_release(struct tty_struct *tty, struct=
 tty_struct *o_tty)
  *	the tty structure is not completely set up when this call is made.
  */
=20
-void tty_ldisc_init(struct tty_struct *tty)
+int tty_ldisc_init(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld =3D tty_ldisc_get(tty, N_TTY);
 	if (IS_ERR(ld))
-		panic("n_tty: init_tty");
+		return PTR_ERR(ld);
 	tty->ldisc =3D ld;
+	return 0;
 }
=20
 /**
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 23f7f96c7508..d7b435af42d3 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1303,6 +1303,11 @@ static void csi_m(struct vc_data *vc)
 			case 3:
 				vc->vc_italic =3D 1;
 				break;
+			case 21:
+				/*
+				 * No console drivers support double underline, so
+				 * convert it to a single underline.
+				 */
 			case 4:
 				vc->vc_underline =3D 1;
 				break;
@@ -1339,7 +1344,6 @@ static void csi_m(struct vc_data *vc)
 				vc->vc_disp_ctrl =3D 1;
 				vc->vc_toggle_meta =3D 1;
 				break;
-			case 21:
 			case 22:
 				vc->vc_intensity =3D 1;
 				break;
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index b09b4ecb8797..cee00dc829b6 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -157,7 +157,9 @@ static const unsigned short full_speed_maxpacket_maxes[=
4] =3D {
 static const unsigned short high_speed_maxpacket_maxes[4] =3D {
 	[USB_ENDPOINT_XFER_CONTROL] =3D 64,
 	[USB_ENDPOINT_XFER_ISOC] =3D 1024,
-	[USB_ENDPOINT_XFER_BULK] =3D 512,
+
+	/* Bulk should be 512, but some devices use 1024: we will warn below */
+	[USB_ENDPOINT_XFER_BULK] =3D 1024,
 	[USB_ENDPOINT_XFER_INT] =3D 1024,
 };
 static const unsigned short super_speed_maxpacket_maxes[4] =3D {
diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index 358ca8dd784f..a5240b4d7ab9 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -208,8 +208,13 @@ static int generic_suspend(struct usb_device *udev, pm=
_message_t msg)
 	if (!udev->parent)
 		rc =3D hcd_bus_suspend(udev, msg);
=20
-	/* Non-root devices don't need to do anything for FREEZE or PRETHAW */
-	else if (msg.event =3D=3D PM_EVENT_FREEZE || msg.event =3D=3D PM_EVENT_PR=
ETHAW)
+	/*
+	 * Non-root USB2 devices don't need to do anything for FREEZE
+	 * or PRETHAW. USB3 devices don't support global suspend and
+	 * needs to be selectively suspended.
+	 */
+	else if ((msg.event =3D=3D PM_EVENT_FREEZE || msg.event =3D=3D PM_EVENT_P=
RETHAW)
+		 && (udev->speed < USB_SPEED_SUPER))
 		rc =3D 0;
 	else
 		rc =3D usb_port_suspend(udev, msg);
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 865bc662b28c..23d28382057a 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2293,6 +2293,7 @@ void usb_hcd_resume_root_hub (struct usb_hcd *hcd)
=20
 	spin_lock_irqsave (&hcd_root_hub_lock, flags);
 	if (hcd->rh_registered) {
+		pm_wakeup_event(&hcd->self.root_hub->dev, 0);
 		set_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
 		queue_work(pm_wq, &hcd->wakeup_work);
 	}
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 7c89f5e32d88..e97bb39bc53f 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -626,12 +626,17 @@ void usb_wakeup_notification(struct usb_device *hdev,
 		unsigned int portnum)
 {
 	struct usb_hub *hub;
+	struct usb_port *port_dev;
=20
 	if (!hdev)
 		return;
=20
 	hub =3D usb_hub_to_struct_hub(hdev);
 	if (hub) {
+		port_dev =3D hub->ports[portnum - 1];
+		if (port_dev && port_dev->child)
+			pm_wakeup_event(&port_dev->child->dev, 0);
+
 		set_bit(portnum, hub->wakeup_bits);
 		kick_khubd(hub);
 	}
@@ -3313,8 +3318,11 @@ int usb_port_resume(struct usb_device *udev, pm_mess=
age_t msg)
=20
 	/* Skip the initial Clear-Suspend step for a remote wakeup */
 	status =3D hub_port_status(hub, port1, &portstatus, &portchange);
-	if (status =3D=3D 0 && !port_is_suspended(hub, portstatus))
+	if (status =3D=3D 0 && !port_is_suspended(hub, portstatus)) {
+		if (portchange & USB_PORT_STAT_C_SUSPEND)
+			pm_wakeup_event(&udev->dev, 0);
 		goto SuspendCleared;
+	}
=20
 	/* see 7.1.7.7; affects power usage, but not budgeting */
 	if (hub_is_superspeed(hub->hdev))
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 25391bef0642..e5e6a728190a 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -45,6 +45,9 @@ static const struct usb_device_id usb_quirk_list[] =3D {
 	{ USB_DEVICE(0x03f0, 0x0701), .driver_info =3D
 			USB_QUIRK_STRING_FETCH_255 },
=20
+	/* HP v222w 16GB Mini USB Drive */
+	{ USB_DEVICE(0x03f0, 0x3f40), .driver_info =3D USB_QUIRK_DELAY_INIT },
+
 	/* Creative SB Audigy 2 NX */
 	{ USB_DEVICE(0x041e, 0x3020), .driver_info =3D USB_QUIRK_RESET_RESUME },
=20
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index a60bab7dfa0a..69f27169081b 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -144,7 +144,7 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 	ret =3D platform_device_add_resources(dwc3, res, ARRAY_SIZE(res));
 	if (ret) {
 		dev_err(dev, "couldn't add resources to dwc3 device\n");
-		return ret;
+		goto err3;
 	}
=20
 	pci_set_drvdata(pci, glue);
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 33cf347e754b..3a1f57ea174e 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -124,7 +124,10 @@ static void xhci_pci_quirks(struct device *dev, struct=
 xhci_hcd *xhci)
 	if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD && usb_amd_find_chipset_info())
 		xhci->quirks |=3D XHCI_AMD_PLL_FIX;
=20
-	if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD && pdev->device =3D=3D 0x43bb)
+	if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD &&
+		(pdev->device =3D=3D 0x15e0 ||
+		 pdev->device =3D=3D 0x15e1 ||
+		 pdev->device =3D=3D 0x43bb))
 		xhci->quirks |=3D XHCI_SUSPEND_DELAY;
=20
 	if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD)
diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gad=
get_ep0.c
index 2af45a0c8930..a4b991992595 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -114,15 +114,19 @@ static int service_tx_status_request(
 		}
=20
 		is_in =3D epnum & USB_DIR_IN;
-		if (is_in) {
-			epnum &=3D 0x0f;
+		epnum &=3D 0x0f;
+		if (epnum >=3D MUSB_C_NUM_EPS) {
+			handled =3D -EINVAL;
+			break;
+		}
+
+		if (is_in)
 			ep =3D &musb->endpoints[epnum].ep_in;
-		} else {
+		else
 			ep =3D &musb->endpoints[epnum].ep_out;
-		}
 		regs =3D musb->endpoints[epnum].regs;
=20
-		if (epnum >=3D MUSB_C_NUM_EPS || !ep->desc) {
+		if (!ep->desc) {
 			handled =3D -EINVAL;
 			break;
 		}
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 2314186738ba..9e34777dc68d 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1002,7 +1002,9 @@ static void musb_bulk_nak_timeout(struct musb *musb, =
struct musb_hw_ep *ep,
 			/* set tx_reinit and schedule the next qh */
 			ep->tx_reinit =3D 1;
 		}
-		musb_start_urb(musb, is_in, next_qh);
+
+		if (next_qh)
+			musb_start_urb(musb, is_in, next_qh);
 	}
 }
=20
diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index f73009bc7268..6123e9e16f78 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -62,6 +62,7 @@ config USB_SERIAL_SIMPLE
 		- Fundamental Software dongle.
 		- Google USB serial devices
 		- HP4x calculators
+		- Libtransistor USB console
 		- a number of Motorola phones
 		- Motorola Tetra devices
 		- Novatel Wireless GPS receivers
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 08f5274ffd61..791061cbee48 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -151,6 +151,7 @@ static const struct usb_device_id id_table[] =3D {
 	{ USB_DEVICE(0x12B8, 0xEC62) }, /* Link G4+ ECU */
 	{ USB_DEVICE(0x13AD, 0x9999) }, /* Baltech card reader */
 	{ USB_DEVICE(0x1555, 0x0004) }, /* Owen AC4 USB-RS485 Converter */
+	{ USB_DEVICE(0x155A, 0x1006) },	/* ELDAT Easywave RX09 */
 	{ USB_DEVICE(0x166A, 0x0201) }, /* Clipsal 5500PACA C-Bus Pascal Automati=
on Controller */
 	{ USB_DEVICE(0x166A, 0x0301) }, /* Clipsal 5800PC C-Bus Wireless PC Inter=
face */
 	{ USB_DEVICE(0x166A, 0x0303) }, /* Clipsal 5500PCU C-Bus USB interface */
@@ -209,6 +210,7 @@ static const struct usb_device_id id_table[] =3D {
 	{ USB_DEVICE(0x3195, 0xF190) }, /* Link Instruments MSO-19 */
 	{ USB_DEVICE(0x3195, 0xF280) }, /* Link Instruments MSO-28 */
 	{ USB_DEVICE(0x3195, 0xF281) }, /* Link Instruments MSO-28 */
+	{ USB_DEVICE(0x3923, 0x7A0B) }, /* National Instruments USB Serial Consol=
e */
 	{ USB_DEVICE(0x413C, 0x9500) }, /* DW700 GPS USB interface */
 	{ } /* Terminating Entry */
 };
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index dbbf6f382344..d9d4175e01df 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -786,6 +786,7 @@ static const struct usb_device_id id_table_combined[] =
=3D {
 		.driver_info =3D (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(TELLDUS_VID, TELLDUS_TELLSTICK_PID) },
 	{ USB_DEVICE(NOVITUS_VID, NOVITUS_BONO_E_PID) },
+	{ USB_DEVICE(FTDI_VID, RTSYSTEMS_USB_VX8_PID) },
 	{ USB_DEVICE(RTSYSTEMS_VID, RTSYSTEMS_USB_S03_PID) },
 	{ USB_DEVICE(RTSYSTEMS_VID, RTSYSTEMS_USB_59_PID) },
 	{ USB_DEVICE(RTSYSTEMS_VID, RTSYSTEMS_USB_57A_PID) },
@@ -948,6 +949,7 @@ static const struct usb_device_id id_table_combined[] =
=3D {
 	{ USB_DEVICE(FTDI_VID, FTDI_SCIENCESCOPE_LS_LOGBOOK_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_SCIENCESCOPE_HS_LOGBOOK_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CINTERION_MC55I_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FHE_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_DOTEC_PID) },
 	{ USB_DEVICE(QIHARDWARE_VID, MILKYMISTONE_JTAGSERIAL_PID),
 		.driver_info =3D (kernel_ulong_t)&ftdi_jtag_quirk },
@@ -1927,7 +1929,8 @@ static int ftdi_8u2232c_probe(struct usb_serial *seri=
al)
 		return ftdi_jtag_probe(serial);
=20
 	if (udev->product &&
-		(!strcmp(udev->product, "BeagleBone/XDS100V2") ||
+		(!strcmp(udev->product, "Arrow USB Blaster") ||
+		 !strcmp(udev->product, "BeagleBone/XDS100V2") ||
 		 !strcmp(udev->product, "SNAP Connect E10")))
 		return ftdi_jtag_probe(serial);
=20
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_si=
o_ids.h
index b73023fa9904..69db398b352e 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -922,6 +922,9 @@
 /*
  * RT Systems programming cables for various ham radios
  */
+/* This device uses the VID of FTDI */
+#define RTSYSTEMS_USB_VX8_PID   0x9e50  /* USB-VX8 USB to 7 pin modular pl=
ug for Yaesu VX-8 radio */
+
 #define RTSYSTEMS_VID		0x2100	/* Vendor ID */
 #define RTSYSTEMS_USB_S03_PID	0x9001	/* RTS-03 USB to Serial Adapter */
 #define RTSYSTEMS_USB_59_PID	0x9e50	/* USB-59 USB to 8 pin plug */
@@ -1440,6 +1443,12 @@
  */
 #define FTDI_CINTERION_MC55I_PID	0xA951
=20
+/*
+ * Product: FirmwareHubEmulator
+ * Manufacturer: Harman Becker Automotive Systems
+ */
+#define FTDI_FHE_PID		0xA9A0
+
 /*
  * Product: Comet Caller ID decoder
  * Manufacturer: Crucible Technologies
diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/us=
b-serial-simple.c
index a084d4578420..9745f714ee80 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -66,6 +66,11 @@ DEVICE(flashloader, FLASHLOADER_IDS);
 					0x01) }
 DEVICE(google, GOOGLE_IDS);
=20
+/* Libtransistor USB console */
+#define LIBTRANSISTOR_IDS()			\
+	{ USB_DEVICE(0x1209, 0x8b00) }
+DEVICE(libtransistor, LIBTRANSISTOR_IDS);
+
 /* ViVOpay USB Serial Driver */
 #define VIVOPAY_IDS()			\
 	{ USB_DEVICE(0x1d5f, 0x1004) }	/* ViVOpay 8800 */
@@ -113,6 +118,7 @@ static struct usb_serial_driver * const serial_drivers[=
] =3D {
 	&funsoft_device,
 	&flashloader_device,
 	&google_device,
+	&libtransistor_device,
 	&vivopay_device,
 	&moto_modem_device,
 	&motorola_tetra_device,
@@ -129,6 +135,7 @@ static const struct usb_device_id id_table[] =3D {
 	FUNSOFT_IDS(),
 	FLASHLOADER_IDS(),
 	GOOGLE_IDS(),
+	LIBTRANSISTOR_IDS(),
 	VIVOPAY_IDS(),
 	MOTO_IDS(),
 	MOTOROLA_TETRA_IDS(),
diff --git a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
index 337a0be89fcf..dbc3801b43eb 100644
--- a/drivers/usb/serial/visor.c
+++ b/drivers/usb/serial/visor.c
@@ -338,47 +338,48 @@ static int palm_os_3_probe(struct usb_serial *serial,
 		goto exit;
 	}
=20
-	if (retval =3D=3D sizeof(*connection_info)) {
-			connection_info =3D (struct visor_connection_info *)
-							transfer_buffer;
-
-		num_ports =3D le16_to_cpu(connection_info->num_ports);
-		for (i =3D 0; i < num_ports; ++i) {
-			switch (
-			   connection_info->connections[i].port_function_id) {
-			case VISOR_FUNCTION_GENERIC:
-				string =3D "Generic";
-				break;
-			case VISOR_FUNCTION_DEBUGGER:
-				string =3D "Debugger";
-				break;
-			case VISOR_FUNCTION_HOTSYNC:
-				string =3D "HotSync";
-				break;
-			case VISOR_FUNCTION_CONSOLE:
-				string =3D "Console";
-				break;
-			case VISOR_FUNCTION_REMOTE_FILE_SYS:
-				string =3D "Remote File System";
-				break;
-			default:
-				string =3D "unknown";
-				break;
-			}
-			dev_info(dev, "%s: port %d, is for %s use\n",
-				serial->type->description,
-				connection_info->connections[i].port, string);
-		}
+	if (retval !=3D sizeof(*connection_info)) {
+		dev_err(dev, "Invalid connection information received from device\n");
+		retval =3D -ENODEV;
+		goto exit;
 	}
-	/*
-	* Handle devices that report invalid stuff here.
-	*/
+
+	connection_info =3D (struct visor_connection_info *)transfer_buffer;
+
+	num_ports =3D le16_to_cpu(connection_info->num_ports);
+
+	/* Handle devices that report invalid stuff here. */
 	if (num_ports =3D=3D 0 || num_ports > 2) {
 		dev_warn(dev, "%s: No valid connect info available\n",
 			serial->type->description);
 		num_ports =3D 2;
 	}
=20
+	for (i =3D 0; i < num_ports; ++i) {
+		switch (connection_info->connections[i].port_function_id) {
+		case VISOR_FUNCTION_GENERIC:
+			string =3D "Generic";
+			break;
+		case VISOR_FUNCTION_DEBUGGER:
+			string =3D "Debugger";
+			break;
+		case VISOR_FUNCTION_HOTSYNC:
+			string =3D "HotSync";
+			break;
+		case VISOR_FUNCTION_CONSOLE:
+			string =3D "Console";
+			break;
+		case VISOR_FUNCTION_REMOTE_FILE_SYS:
+			string =3D "Remote File System";
+			break;
+		default:
+			string =3D "unknown";
+			break;
+		}
+		dev_info(dev, "%s: port %d, is for %s use\n",
+			serial->type->description,
+			connection_info->connections[i].port, string);
+	}
 	dev_info(dev, "%s: Number of ports: %d\n", serial->type->description,
 		num_ports);
=20
diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index cfe8a2f905c5..14e78f575765 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1091,7 +1091,7 @@ static int __init stifb_init_fb(struct sti_struct *st=
i, int bpp_pref)
 	fb =3D kzalloc(sizeof(*fb), GFP_ATOMIC);
 	if (!fb) {
 		printk(KERN_ERR "stifb: Could not allocate stifb structure\n");
-		return -ENODEV;
+		return -ENOMEM;
 	}
 =09
 	info =3D &fb->info;
diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 016bd9355190..aa93df5833dc 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -450,7 +450,7 @@ static bool watchdog_is_running(void)
=20
 	is_running =3D (superio_inb(watchdog.sioaddr, SIO_REG_ENABLE) & BIT(0))
 		&& (superio_inb(watchdog.sioaddr, F71808FG_REG_WDT_CONF)
-			& F71808FG_FLAG_WD_EN);
+			& BIT(F71808FG_FLAG_WD_EN));
=20
 	superio_exit(watchdog.sioaddr);
=20
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index c9d0d5a0e662..42212c8e4453 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -366,7 +366,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t =
size, void *vaddr,
 	 * physical address */
 	phys =3D xen_bus_to_phys(dev_addr);
=20
-	if (((dev_addr + size - 1 > dma_mask)) ||
+	if (((dev_addr + size - 1 <=3D dma_mask)) ||
 	    range_straddles_page_boundary(phys, size))
 		xen_destroy_contiguous_region(phys, order);
=20
diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi-proces=
sor.c
index 57dbeef2d667..f999548ad702 100644
--- a/drivers/xen/xen-acpi-processor.c
+++ b/drivers/xen/xen-acpi-processor.c
@@ -362,9 +362,9 @@ read_acpi_id(acpi_handle handle, u32 lvl, void *context=
, void **rv)
 	}
 	/* There are more ACPI Processor objects than in x2APIC or MADT.
 	 * This can happen with incorrect ACPI SSDT declerations. */
-	if (acpi_id > nr_acpi_bits) {
-		pr_debug("We only have %u, trying to set %u\n",
-			 nr_acpi_bits, acpi_id);
+	if (acpi_id >=3D nr_acpi_bits) {
+		pr_debug("max acpi id %u, trying to set %u\n",
+			 nr_acpi_bits - 1, acpi_id);
 		return AE_OK;
 	}
 	/* OK, There is a ACPI Processor object */
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index 035bd31556fc..5f15d97bef0e 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -224,9 +224,10 @@ affs_lookup(struct inode *dir, struct dentry *dentry, =
unsigned int flags)
=20
 	affs_lock_dir(dir);
 	bh =3D affs_find_entry(dir, dentry);
-	affs_unlock_dir(dir);
-	if (IS_ERR(bh))
+	if (IS_ERR(bh)) {
+		affs_unlock_dir(dir);
 		return ERR_CAST(bh);
+	}
 	if (bh) {
 		u32 ino =3D bh->b_blocknr;
=20
@@ -240,10 +241,13 @@ affs_lookup(struct inode *dir, struct dentry *dentry,=
 unsigned int flags)
 		}
 		affs_brelse(bh);
 		inode =3D affs_iget(sb, ino);
-		if (IS_ERR(inode))
+		if (IS_ERR(inode)) {
+			affs_unlock_dir(dir);
 			return ERR_CAST(inode);
+		}
 	}
 	d_add(dentry, inode);
+	affs_unlock_dir(dir);
 	return NULL;
 }
=20
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 8d010422dc89..fcf2b07b1571 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -323,19 +323,14 @@ int afs_permission(struct inode *inode, int mask)
 	       mask, access, S_ISDIR(inode->i_mode) ? "dir" : "file");
=20
 	if (S_ISDIR(inode->i_mode)) {
-		if (mask & MAY_EXEC) {
+		if (mask & (MAY_EXEC | MAY_READ | MAY_CHDIR)) {
 			if (!(access & AFS_ACE_LOOKUP))
 				goto permission_denied;
-		} else if (mask & MAY_READ) {
-			if (!(access & AFS_ACE_READ))
-				goto permission_denied;
-		} else if (mask & MAY_WRITE) {
+		}
+		if (mask & MAY_WRITE) {
 			if (!(access & (AFS_ACE_DELETE | /* rmdir, unlink, rename from */
-					AFS_ACE_INSERT | /* create, mkdir, symlink, rename to */
-					AFS_ACE_WRITE))) /* chmod */
+					AFS_ACE_INSERT))) /* create, mkdir, symlink, rename to */
 				goto permission_denied;
-		} else {
-			BUG();
 		}
 	} else {
 		if (!(access & AFS_ACE_LOOKUP))
diff --git a/fs/aio.c b/fs/aio.c
index d01069c5e4b5..4dddb2a5298f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -565,9 +565,8 @@ static void free_ioctx_users(struct percpu_ref *ref)
 	while (!list_empty(&ctx->active_reqs)) {
 		req =3D list_first_entry(&ctx->active_reqs,
 				       struct kiocb, ki_list);
-
-		list_del_init(&req->ki_list);
 		kiocb_cancel(req);
+		list_del_init(&req->ki_list);
 	}
=20
 	spin_unlock_irq(&ctx->ctx_lock);
@@ -1025,8 +1024,8 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_=
id)
=20
 	ctx =3D rcu_dereference(table->table[id]);
 	if (ctx && ctx->user_id =3D=3D ctx_id) {
-		percpu_ref_get(&ctx->users);
-		ret =3D ctx;
+		if (percpu_ref_tryget_live(&ctx->users))
+			ret =3D ctx;
 	}
 out:
 	rcu_read_unlock();
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 9e016e6fb582..080cb24a09e7 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -721,7 +721,7 @@ static int autofs4_dir_mkdir(struct inode *dir, struct =
dentry *dentry, umode_t m
=20
 	autofs4_del_active(dentry);
=20
-	inode =3D autofs4_get_inode(dir->i_sb, S_IFDIR | 0555);
+	inode =3D autofs4_get_inode(dir->i_sb, S_IFDIR | mode);
 	if (!inode)
 		return -ENOMEM;
 	d_add(dentry, inode);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 5d4adb55b07b..ccfeca9105be 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5406,12 +5406,24 @@ int btrfs_compare_trees(struct btrfs_root *left_roo=
t,
 	down_read(&left_root->fs_info->commit_root_sem);
 	left_level =3D btrfs_header_level(left_root->commit_root);
 	left_root_level =3D left_level;
-	left_path->nodes[left_level] =3D left_root->commit_root;
+	left_path->nodes[left_level] =3D
+			btrfs_clone_extent_buffer(left_root->commit_root);
+	if (!left_path->nodes[left_level]) {
+		up_read(&left_root->fs_info->commit_root_sem);
+		ret =3D -ENOMEM;
+		goto out;
+	}
 	extent_buffer_get(left_path->nodes[left_level]);
=20
 	right_level =3D btrfs_header_level(right_root->commit_root);
 	right_root_level =3D right_level;
-	right_path->nodes[right_level] =3D right_root->commit_root;
+	right_path->nodes[right_level] =3D
+			btrfs_clone_extent_buffer(right_root->commit_root);
+	if (!right_path->nodes[right_level]) {
+		up_read(&left_root->fs_info->commit_root_sem);
+		ret =3D -ENOMEM;
+		goto out;
+	}
 	extent_buffer_get(right_path->nodes[right_level]);
 	up_read(&left_root->fs_info->commit_root_sem);
=20
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d7b34e35f34c..f34b210aaed8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3969,6 +3969,7 @@ static int do_chunk_alloc(struct btrfs_trans_handle *=
trans,
 	if (wait_for_alloc) {
 		mutex_unlock(&fs_info->chunk_mutex);
 		wait_for_alloc =3D 0;
+		cond_resched();
 		goto again;
 	}
=20
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 65d2b3130188..6d716c051b24 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1145,6 +1145,8 @@ static noinline int csum_exist_in_range(struct btrfs_=
root *root,
 		list_del(&sums->list);
 		kfree(sums);
 	}
+	if (ret < 0)
+		return ret;
 	return 1;
 }
=20
@@ -1294,10 +1296,23 @@ static noinline int run_delalloc_nocow(struct inode=
 *inode,
 				goto out_check;
 			if (btrfs_extent_readonly(root, disk_bytenr))
 				goto out_check;
-			if (btrfs_cross_ref_exist(trans, root, ino,
-						  found_key.offset -
-						  extent_offset, disk_bytenr))
+			ret =3D btrfs_cross_ref_exist(trans, root, ino,
+						    found_key.offset -
+						    extent_offset, disk_bytenr);
+			if (ret) {
+				/*
+				 * ret could be -EIO if the above fails to read
+				 * metadata.
+				 */
+				if (ret < 0) {
+					if (cow_start !=3D (u64)-1)
+						cur_offset =3D cow_start;
+					goto error;
+				}
+
+				WARN_ON_ONCE(nolock);
 				goto out_check;
+			}
 			disk_bytenr +=3D extent_offset;
 			disk_bytenr +=3D cur_offset - found_key.offset;
 			num_bytes =3D min(end + 1, extent_end) - cur_offset;
@@ -1315,8 +1330,22 @@ static noinline int run_delalloc_nocow(struct inode =
*inode,
 			 * this ensure that csum for a given extent are
 			 * either valid or do not exist.
 			 */
-			if (csum_exist_in_range(root, disk_bytenr, num_bytes))
+			ret =3D csum_exist_in_range(root, disk_bytenr,
+						  num_bytes);
+			if (ret) {
+
+				/*
+				 * ret could be -EIO if the above fails to read
+				 * metadata.
+				 */
+				if (ret < 0) {
+					if (cow_start !=3D (u64)-1)
+						cur_offset =3D cow_start;
+					goto error;
+				}
+				WARN_ON_ONCE(nolock);
 				goto out_check;
+			}
 			nocow =3D 1;
 		} else if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
 			extent_end =3D found_key.offset +
@@ -5673,6 +5702,17 @@ int btrfs_set_inode_index(struct inode *dir, u64 *in=
dex)
 	return ret;
 }
=20
+static int btrfs_insert_inode_locked(struct inode *inode)
+{
+	struct btrfs_iget_args args;
+	args.location =3D &BTRFS_I(inode)->location;
+	args.root =3D BTRFS_I(inode)->root;
+
+	return insert_inode_locked4(inode,
+		   btrfs_inode_hash(inode->i_ino, BTRFS_I(inode)->root),
+		   btrfs_find_actor, &args);
+}
+
 static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root,
 				     struct inode *dir,
@@ -5701,6 +5741,13 @@ static struct inode *btrfs_new_inode(struct btrfs_tr=
ans_handle *trans,
 		return ERR_PTR(-ENOMEM);
 	}
=20
+	/*
+	 * O_TMPFILE, set link count to 0, so that after this point,
+	 * we fill in an inode item with the correct link count.
+	 */
+	if (!name)
+		set_nlink(inode, 0);
+
 	/*
 	 * we have to initialize this early, so we can reclaim the inode
 	 * number if we fail afterwards in this function.
@@ -5758,10 +5805,19 @@ static struct inode *btrfs_new_inode(struct btrfs_t=
rans_handle *trans,
 		sizes[1] =3D name_len + sizeof(*ref);
 	}
=20
+	location =3D &BTRFS_I(inode)->location;
+	location->objectid =3D objectid;
+	location->offset =3D 0;
+	btrfs_set_key_type(location, BTRFS_INODE_ITEM_KEY);
+
+	ret =3D btrfs_insert_inode_locked(inode);
+	if (ret < 0)
+		goto fail;
+
 	path->leave_spinning =3D 1;
 	ret =3D btrfs_insert_empty_items(trans, root, path, key, sizes, nitems);
 	if (ret !=3D 0)
-		goto fail;
+		goto fail_unlock;
=20
 	inode_init_owner(inode, dir, mode);
 	inode_set_bytes(inode, 0);
@@ -5784,11 +5840,6 @@ static struct inode *btrfs_new_inode(struct btrfs_tr=
ans_handle *trans,
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 	btrfs_free_path(path);
=20
-	location =3D &BTRFS_I(inode)->location;
-	location->objectid =3D objectid;
-	location->offset =3D 0;
-	btrfs_set_key_type(location, BTRFS_INODE_ITEM_KEY);
-
 	btrfs_inherit_iflags(inode, dir);
=20
 	if (S_ISREG(mode)) {
@@ -5799,7 +5850,6 @@ static struct inode *btrfs_new_inode(struct btrfs_tra=
ns_handle *trans,
 				BTRFS_INODE_NODATASUM;
 	}
=20
-	btrfs_insert_inode_hash(inode);
 	inode_tree_add(inode);
=20
 	trace_btrfs_inode_new(inode);
@@ -5814,6 +5864,9 @@ static struct inode *btrfs_new_inode(struct btrfs_tra=
ns_handle *trans,
 			  btrfs_ino(inode), root->root_key.objectid, ret);
=20
 	return inode;
+
+fail_unlock:
+	unlock_new_inode(inode);
 fail:
 	if (dir && name)
 		BTRFS_I(dir)->index_cnt--;
@@ -5948,28 +6001,27 @@ static int btrfs_mknod(struct inode *dir, struct de=
ntry *dentry,
 		goto out_unlock;
 	}
=20
-	err =3D btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
-	if (err) {
-		drop_inode =3D 1;
-		goto out_unlock;
-	}
-
 	/*
 	* If the active LSM wants to access the inode during
 	* d_instantiate it needs these. Smack checks to see
 	* if the filesystem supports xattrs by looking at the
 	* ops vector.
 	*/
-
 	inode->i_op =3D &btrfs_special_inode_operations;
-	err =3D btrfs_add_nondir(trans, dir, dentry, inode, 0, index);
+	init_special_inode(inode, inode->i_mode, rdev);
+
+	err =3D btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
-		drop_inode =3D 1;
-	else {
-		init_special_inode(inode, inode->i_mode, rdev);
+		goto out_unlock_inode;
+
+	err =3D btrfs_add_nondir(trans, dir, dentry, inode, 0, index);
+	if (err) {
+		goto out_unlock_inode;
+	} else {
 		btrfs_update_inode(trans, root, inode);
-		d_instantiate(dentry, inode);
+		d_instantiate_new(dentry, inode);
 	}
+
 out_unlock:
 	btrfs_end_transaction(trans, root);
 	btrfs_balance_delayed_items(root);
@@ -5979,6 +6031,12 @@ static int btrfs_mknod(struct inode *dir, struct den=
try *dentry,
 		iput(inode);
 	}
 	return err;
+
+out_unlock_inode:
+	drop_inode =3D 1;
+	unlock_new_inode(inode);
+	goto out_unlock;
+
 }
=20
 static int btrfs_create(struct inode *dir, struct dentry *dentry,
@@ -6013,15 +6071,6 @@ static int btrfs_create(struct inode *dir, struct de=
ntry *dentry,
 		goto out_unlock;
 	}
 	drop_inode_on_err =3D 1;
-
-	err =3D btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
-	if (err)
-		goto out_unlock;
-
-	err =3D btrfs_update_inode(trans, root, inode);
-	if (err)
-		goto out_unlock;
-
 	/*
 	* If the active LSM wants to access the inode during
 	* d_instantiate it needs these. Smack checks to see
@@ -6030,15 +6079,23 @@ static int btrfs_create(struct inode *dir, struct d=
entry *dentry,
 	*/
 	inode->i_fop =3D &btrfs_file_operations;
 	inode->i_op =3D &btrfs_file_inode_operations;
+	inode->i_mapping->a_ops =3D &btrfs_aops;
+	inode->i_mapping->backing_dev_info =3D &root->fs_info->bdi;
+
+	err =3D btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
+	if (err)
+		goto out_unlock_inode;
+
+	err =3D btrfs_update_inode(trans, root, inode);
+	if (err)
+		goto out_unlock_inode;
=20
 	err =3D btrfs_add_nondir(trans, dir, dentry, inode, 0, index);
 	if (err)
-		goto out_unlock;
+		goto out_unlock_inode;
=20
-	inode->i_mapping->a_ops =3D &btrfs_aops;
-	inode->i_mapping->backing_dev_info =3D &root->fs_info->bdi;
 	BTRFS_I(inode)->io_tree.ops =3D &btrfs_extent_io_ops;
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
=20
 out_unlock:
 	btrfs_end_transaction(trans, root);
@@ -6049,6 +6106,11 @@ static int btrfs_create(struct inode *dir, struct de=
ntry *dentry,
 	btrfs_balance_delayed_items(root);
 	btrfs_btree_balance_dirty(root);
 	return err;
+
+out_unlock_inode:
+	unlock_new_inode(inode);
+	goto out_unlock;
+
 }
=20
 static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
@@ -6156,25 +6218,25 @@ static int btrfs_mkdir(struct inode *dir, struct de=
ntry *dentry, umode_t mode)
 	}
=20
 	drop_on_err =3D 1;
+	/* these must be set before we unlock the inode */
+	inode->i_op =3D &btrfs_dir_inode_operations;
+	inode->i_fop =3D &btrfs_dir_file_operations;
=20
 	err =3D btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
-		goto out_fail;
-
-	inode->i_op =3D &btrfs_dir_inode_operations;
-	inode->i_fop =3D &btrfs_dir_file_operations;
+		goto out_fail_inode;
=20
 	btrfs_i_size_write(inode, 0);
 	err =3D btrfs_update_inode(trans, root, inode);
 	if (err)
-		goto out_fail;
+		goto out_fail_inode;
=20
 	err =3D btrfs_add_link(trans, dir, inode, dentry->d_name.name,
 			     dentry->d_name.len, 0, index);
 	if (err)
-		goto out_fail;
+		goto out_fail_inode;
=20
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	drop_on_err =3D 0;
=20
 out_fail:
@@ -6184,6 +6246,10 @@ static int btrfs_mkdir(struct inode *dir, struct den=
try *dentry, umode_t mode)
 	btrfs_balance_delayed_items(root);
 	btrfs_btree_balance_dirty(root);
 	return err;
+
+out_fail_inode:
+	unlock_new_inode(inode);
+	goto out_fail;
 }
=20
 /* helper for btfs_get_extent.  Given an existing extent in the tree,
@@ -8137,6 +8203,7 @@ int btrfs_create_subvol_root(struct btrfs_trans_handl=
e *trans,
=20
 	set_nlink(inode, 1);
 	btrfs_i_size_write(inode, 0);
+	unlock_new_inode(inode);
=20
 	err =3D btrfs_subvol_inherit_props(trans, new_root, parent_root);
 	if (err)
@@ -8787,12 +8854,6 @@ static int btrfs_symlink(struct inode *dir, struct d=
entry *dentry,
 		goto out_unlock;
 	}
=20
-	err =3D btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
-	if (err) {
-		drop_inode =3D 1;
-		goto out_unlock;
-	}
-
 	/*
 	* If the active LSM wants to access the inode during
 	* d_instantiate it needs these. Smack checks to see
@@ -8801,23 +8862,18 @@ static int btrfs_symlink(struct inode *dir, struct =
dentry *dentry,
 	*/
 	inode->i_fop =3D &btrfs_file_operations;
 	inode->i_op =3D &btrfs_file_inode_operations;
+	inode->i_mapping->a_ops =3D &btrfs_aops;
+	inode->i_mapping->backing_dev_info =3D &root->fs_info->bdi;
+	BTRFS_I(inode)->io_tree.ops =3D &btrfs_extent_io_ops;
=20
-	err =3D btrfs_add_nondir(trans, dir, dentry, inode, 0, index);
+	err =3D btrfs_init_inode_security(trans, inode, dir, &dentry->d_name);
 	if (err)
-		drop_inode =3D 1;
-	else {
-		inode->i_mapping->a_ops =3D &btrfs_aops;
-		inode->i_mapping->backing_dev_info =3D &root->fs_info->bdi;
-		BTRFS_I(inode)->io_tree.ops =3D &btrfs_extent_io_ops;
-	}
-	if (drop_inode)
-		goto out_unlock;
+		goto out_unlock_inode;
=20
 	path =3D btrfs_alloc_path();
 	if (!path) {
 		err =3D -ENOMEM;
-		drop_inode =3D 1;
-		goto out_unlock;
+		goto out_unlock_inode;
 	}
 	key.objectid =3D btrfs_ino(inode);
 	key.offset =3D 0;
@@ -8826,9 +8882,8 @@ static int btrfs_symlink(struct inode *dir, struct de=
ntry *dentry,
 	err =3D btrfs_insert_empty_item(trans, root, path, &key,
 				      datasize);
 	if (err) {
-		drop_inode =3D 1;
 		btrfs_free_path(path);
-		goto out_unlock;
+		goto out_unlock_inode;
 	}
 	leaf =3D path->nodes[0];
 	ei =3D btrfs_item_ptr(leaf, path->slots[0],
@@ -8852,12 +8907,21 @@ static int btrfs_symlink(struct inode *dir, struct =
dentry *dentry,
 	inode_set_bytes(inode, name_len);
 	btrfs_i_size_write(inode, name_len);
 	err =3D btrfs_update_inode(trans, root, inode);
-	if (err)
+	/*
+	 * Last step, add directory indexes for our symlink inode. This is the
+	 * last step to avoid extra cleanup of these indexes if an error happens
+	 * elsewhere above.
+	 */
+	if (!err)
+		err =3D btrfs_add_nondir(trans, dir, dentry, inode, 0, index);
+	if (err) {
 		drop_inode =3D 1;
+		goto out_unlock_inode;
+	}
+
+	d_instantiate_new(dentry, inode);
=20
 out_unlock:
-	if (!err)
-		d_instantiate(dentry, inode);
 	btrfs_end_transaction(trans, root);
 	if (drop_inode) {
 		inode_dec_link_count(inode);
@@ -8865,6 +8929,11 @@ static int btrfs_symlink(struct inode *dir, struct d=
entry *dentry,
 	}
 	btrfs_btree_balance_dirty(root);
 	return err;
+
+out_unlock_inode:
+	drop_inode =3D 1;
+	unlock_new_inode(inode);
+	goto out_unlock;
 }
=20
 static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
@@ -9048,14 +9117,6 @@ static int btrfs_tmpfile(struct inode *dir, struct d=
entry *dentry, umode_t mode)
 		goto out;
 	}
=20
-	ret =3D btrfs_init_inode_security(trans, inode, dir, NULL);
-	if (ret)
-		goto out;
-
-	ret =3D btrfs_update_inode(trans, root, inode);
-	if (ret)
-		goto out;
-
 	inode->i_fop =3D &btrfs_file_operations;
 	inode->i_op =3D &btrfs_file_inode_operations;
=20
@@ -9063,10 +9124,26 @@ static int btrfs_tmpfile(struct inode *dir, struct =
dentry *dentry, umode_t mode)
 	inode->i_mapping->backing_dev_info =3D &root->fs_info->bdi;
 	BTRFS_I(inode)->io_tree.ops =3D &btrfs_extent_io_ops;
=20
+	ret =3D btrfs_init_inode_security(trans, inode, dir, NULL);
+	if (ret)
+		goto out_inode;
+
+	ret =3D btrfs_update_inode(trans, root, inode);
+	if (ret)
+		goto out_inode;
 	ret =3D btrfs_orphan_add(trans, inode);
 	if (ret)
-		goto out;
+		goto out_inode;
=20
+	/*
+	 * We set number of links to 0 in btrfs_new_inode(), and here we set
+	 * it to 1 because d_tmpfile() will issue a warning if the count is 0,
+	 * through:
+	 *
+	 *    d_tmpfile() -> inode_dec_link_count() -> drop_nlink()
+	 */
+	set_nlink(inode, 1);
+	unlock_new_inode(inode);
 	d_tmpfile(dentry, inode);
 	mark_inode_dirty(inode);
=20
@@ -9076,8 +9153,12 @@ static int btrfs_tmpfile(struct inode *dir, struct d=
entry *dentry, umode_t mode)
 		iput(inode);
 	btrfs_balance_delayed_items(root);
 	btrfs_btree_balance_dirty(root);
-
 	return ret;
+
+out_inode:
+	unlock_new_inode(inode);
+	goto out;
+
 }
=20
 static const struct inode_operations btrfs_dir_inode_operations =3D {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c740b0202931..9568810444ea 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5051,11 +5051,17 @@ static long _btrfs_ioctl_set_received_subvol(struct=
 file *file,
 	received_uuid_changed =3D memcmp(root_item->received_uuid, sa->uuid,
 				       BTRFS_UUID_SIZE);
 	if (received_uuid_changed &&
-	    !btrfs_is_empty_uuid(root_item->received_uuid))
-		btrfs_uuid_tree_rem(trans, root->fs_info->uuid_root,
-				    root_item->received_uuid,
-				    BTRFS_UUID_KEY_RECEIVED_SUBVOL,
-				    root->root_key.objectid);
+	    !btrfs_is_empty_uuid(root_item->received_uuid)) {
+		ret =3D btrfs_uuid_tree_rem(trans, root->fs_info->uuid_root,
+					  root_item->received_uuid,
+					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
+					  root->root_key.objectid);
+		if (ret && ret !=3D -ENOENT) {
+			btrfs_abort_transaction(trans, root, ret);
+		        btrfs_end_transaction(trans, root);
+		        goto out;
+		}
+	}
 	memcpy(root_item->received_uuid, sa->uuid, BTRFS_UUID_SIZE);
 	btrfs_set_root_stransid(root_item, sa->stransid);
 	btrfs_set_root_rtransid(root_item, sa->rtransid);
@@ -5077,15 +5083,11 @@ static long _btrfs_ioctl_set_received_subvol(struct=
 file *file,
 					  root->root_key.objectid);
 		if (ret < 0 && ret !=3D -EEXIST) {
 			btrfs_abort_transaction(trans, root, ret);
+			btrfs_end_transaction(trans, root);
 			goto out;
 		}
 	}
 	ret =3D btrfs_commit_transaction(trans, root);
-	if (ret < 0) {
-		btrfs_abort_transaction(trans, root, ret);
-		goto out;
-	}
-
 out:
 	up_write(&root->fs_info->subvol_sem);
 	mnt_drop_write_file(file);
diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index ec3dcb202357..84f5ddd3f332 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -69,7 +69,7 @@ static int insert_normal_tree_ref(struct btrfs_root *root=
, u64 bytenr,
 	btrfs_set_extent_generation(leaf, item, 1);
 	btrfs_set_extent_flags(leaf, item, BTRFS_EXTENT_FLAG_TREE_BLOCK);
 	block_info =3D (struct btrfs_tree_block_info *)(item + 1);
-	btrfs_set_tree_block_level(leaf, block_info, 1);
+	btrfs_set_tree_block_level(leaf, block_info, 0);
 	iref =3D (struct btrfs_extent_inline_ref *)(block_info + 1);
 	if (parent > 0) {
 		btrfs_set_extent_inline_ref_type(leaf, iref,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fb049cb4571d..63d9e0a784a1 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1979,8 +1979,10 @@ static noinline int replay_dir_deletes(struct btrfs_=
trans_handle *trans,
 			nritems =3D btrfs_header_nritems(path->nodes[0]);
 			if (path->slots[0] >=3D nritems) {
 				ret =3D btrfs_next_leaf(root, path);
-				if (ret)
+				if (ret =3D=3D 1)
 					break;
+				else if (ret < 0)
+					goto out;
 			}
 			btrfs_item_key_to_cpu(path->nodes[0], &found_key,
 					      path->slots[0]);
@@ -3082,8 +3084,11 @@ static noinline int log_dir_items(struct btrfs_trans=
_handle *trans,
 		 * from this directory and from this transaction
 		 */
 		ret =3D btrfs_next_leaf(root, path);
-		if (ret =3D=3D 1) {
-			last_offset =3D (u64)-1;
+		if (ret) {
+			if (ret =3D=3D 1)
+				last_offset =3D (u64)-1;
+			else
+				err =3D ret;
 			goto done;
 		}
 		btrfs_item_key_to_cpu(path->nodes[0], &tmp, path->slots[0]);
@@ -3524,6 +3529,7 @@ static noinline int copy_items(struct btrfs_trans_han=
dle *trans,
 			ASSERT(ret =3D=3D 0);
 			src =3D src_path->nodes[0];
 			i =3D 0;
+			need_find_last_extent =3D true;
 		}
=20
 		btrfs_item_key_to_cpu(src, &key, i);
diff --git a/fs/buffer.c b/fs/buffer.c
index cdd0320e8f84..8c0ce7d3a967 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1575,7 +1575,7 @@ void block_invalidatepage(struct page *page, unsigned=
 int offset,
 	 * The get_block cached value has been unconditionally invalidated,
 	 * so real IO is not possible anymore.
 	 */
-	if (offset =3D=3D 0)
+	if (length =3D=3D PAGE_SIZE)
 		try_to_release_page(page, 0);
 out:
 	return;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 50efb2a5d3f6..bf29a9972e5b 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -599,13 +599,15 @@ void ceph_fill_file_time(struct inode *inode, int iss=
ued,
 		      CEPH_CAP_FILE_BUFFER|
 		      CEPH_CAP_AUTH_EXCL|
 		      CEPH_CAP_XATTR_EXCL)) {
-		if (timespec_compare(ctime, &inode->i_ctime) > 0) {
+		if (ci->i_version =3D=3D 0 ||
+		    timespec_compare(ctime, &inode->i_ctime) > 0) {
 			dout("ctime %ld.%09ld -> %ld.%09ld inc w/ cap\n",
 			     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
 			     ctime->tv_sec, ctime->tv_nsec);
 			inode->i_ctime =3D *ctime;
 		}
-		if (ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
+		if (ci->i_version =3D=3D 0 ||
+		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
 			/* the MDS did a utimes() */
 			dout("mtime %ld.%09ld -> %ld.%09ld "
 			     "tw %d -> %d\n",
@@ -719,7 +721,6 @@ static int fill_inode(struct inode *inode,
 	new_issued =3D ~issued & le32_to_cpu(info->cap.caps);
=20
 	/* update inode */
-	ci->i_version =3D le64_to_cpu(info->version);
 	inode->i_version++;
 	inode->i_rdev =3D le32_to_cpu(info->rdev);
 	inode->i_blkbits =3D fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
@@ -779,6 +780,9 @@ static int fill_inode(struct inode *inode,
 		xattr_blob =3D NULL;
 	}
=20
+	/* finally update i_version */
+	ci->i_version =3D le64_to_cpu(info->version);
+
 	inode->i_mapping->a_ops =3D &ceph_aops;
 	inode->i_mapping->backing_dev_info =3D
 		&ceph_sb_to_client(inode->i_sb)->backing_dev_info;
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index a0bf3f135a92..bd6ebe78809d 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -899,6 +899,18 @@ const struct inode_operations cifs_symlink_inode_ops =
=3D {
 #endif
 };
=20
+/*
+ * Directory operations under CIFS/SMB2/SMB3 are synchronous, so fsync()
+ * is a dummy operation.
+ */
+static int cifs_dir_fsync(struct file *file, loff_t start, loff_t end, int=
 datasync)
+{
+	cifs_dbg(FYI, "Sync directory - name: %pD datasync: 0x%x\n",
+		 file, datasync);
+
+	return 0;
+}
+
 const struct file_operations cifs_file_ops =3D {
 	.read =3D new_sync_read,
 	.write =3D new_sync_write,
@@ -1018,6 +1030,7 @@ const struct file_operations cifs_dir_ops =3D {
 	.read    =3D generic_read_dir,
 	.unlocked_ioctl  =3D cifs_ioctl,
 	.llseek =3D generic_file_llseek,
+	.fsync =3D cifs_dir_fsync,
 };
=20
 static void
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index a30006636796..75eac1424c5b 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -665,6 +665,9 @@ int cifs_mknod(struct inode *inode, struct dentry *dire=
ntry, umode_t mode,
 		goto mknod_out;
 	}
=20
+	if (!S_ISCHR(mode) && !S_ISBLK(mode))
+		goto mknod_out;
+
 	if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL))
 		goto mknod_out;
=20
@@ -673,10 +676,8 @@ int cifs_mknod(struct inode *inode, struct dentry *dir=
entry, umode_t mode,
=20
 	buf =3D kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
 	if (buf =3D=3D NULL) {
-		kfree(full_path);
 		rc =3D -ENOMEM;
-		free_xid(xid);
-		return rc;
+		goto mknod_out;
 	}
=20
 	if (backup_cred(cifs_sb))
@@ -718,7 +719,7 @@ int cifs_mknod(struct inode *inode, struct dentry *dire=
ntry, umode_t mode,
 		pdev->minor =3D cpu_to_le64(MINOR(device_number));
 		rc =3D CIFSSMBWrite(xid, &io_parms, &bytes_written, (char *)pdev,
 				  NULL, 0);
-	} /* else if (S_ISFIFO) */
+	}
 	CIFSSMBClose(xid, tcon, fid.netfid);
 	d_drop(direntry);
=20
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 422028a7baf5..fac1aa69e1a8 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -477,8 +477,8 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses =
*ses)
=20
 int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 {
-	int rc =3D 0;
-	struct validate_negotiate_info_req vneg_inbuf;
+	int rc;
+	struct validate_negotiate_info_req *pneg_inbuf;
 	struct validate_negotiate_info_rsp *pneg_rsp =3D NULL;
 	u32 rsplen;
=20
@@ -502,42 +502,47 @@ int smb3_validate_negotiate(const unsigned int xid, s=
truct cifs_tcon *tcon)
 	if (tcon->ses->session_flags & SMB2_SESSION_FLAG_IS_NULL)
 		cifs_dbg(VFS, "Unexpected null user (anonymous) auth flag sent by server=
\n");
=20
-	vneg_inbuf.Capabilities =3D
+	pneg_inbuf =3D kmalloc(sizeof(*pneg_inbuf), GFP_NOFS);
+	if (!pneg_inbuf)
+		return -ENOMEM;
+
+	pneg_inbuf->Capabilities =3D
 			cpu_to_le32(tcon->ses->server->vals->req_capabilities);
-	memcpy(vneg_inbuf.Guid, tcon->ses->server->client_guid,
+	memcpy(pneg_inbuf->Guid, tcon->ses->server->client_guid,
 					SMB2_CLIENT_GUID_SIZE);
=20
 	if (tcon->ses->sign)
-		vneg_inbuf.SecurityMode =3D
+		pneg_inbuf->SecurityMode =3D
 			cpu_to_le16(SMB2_NEGOTIATE_SIGNING_REQUIRED);
 	else if (global_secflags & CIFSSEC_MAY_SIGN)
-		vneg_inbuf.SecurityMode =3D
+		pneg_inbuf->SecurityMode =3D
 			cpu_to_le16(SMB2_NEGOTIATE_SIGNING_ENABLED);
 	else
-		vneg_inbuf.SecurityMode =3D 0;
+		pneg_inbuf->SecurityMode =3D 0;
=20
-	vneg_inbuf.DialectCount =3D cpu_to_le16(1);
-	vneg_inbuf.Dialects[0] =3D
+	pneg_inbuf->DialectCount =3D cpu_to_le16(1);
+	pneg_inbuf->Dialects[0] =3D
 		cpu_to_le16(tcon->ses->server->vals->protocol_id);
=20
 	rc =3D SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
 		FSCTL_VALIDATE_NEGOTIATE_INFO, true /* is_fsctl */,
-		(char *)&vneg_inbuf, sizeof(struct validate_negotiate_info_req),
+		(char *)pneg_inbuf, sizeof(struct validate_negotiate_info_req),
 		(char **)&pneg_rsp, &rsplen);
=20
 	if (rc !=3D 0) {
 		cifs_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
-		return -EIO;
+		rc =3D -EIO;
+		goto out_free_inbuf;
 	}
=20
-	if (rsplen !=3D sizeof(struct validate_negotiate_info_rsp)) {
+	rc =3D -EIO;
+	if (rsplen !=3D sizeof(*pneg_rsp)) {
 		cifs_dbg(VFS, "invalid protocol negotiate response size: %d\n",
 			 rsplen);
=20
 		/* relax check since Mac returns max bufsize allowed on ioctl */
-		if ((rsplen > CIFSMaxBufSize)
-		     || (rsplen < sizeof(struct validate_negotiate_info_rsp)))
-			goto err_rsp_free;
+		if (rsplen > CIFSMaxBufSize || rsplen < sizeof(*pneg_rsp))
+			goto out_free_rsp;
 	}
=20
 	/* check validate negotiate info response matches what we got earlier */
@@ -554,15 +559,17 @@ int smb3_validate_negotiate(const unsigned int xid, s=
truct cifs_tcon *tcon)
 		goto vneg_out;
=20
 	/* validate negotiate successful */
+	rc =3D 0;
 	cifs_dbg(FYI, "validate negotiate info successful\n");
-	kfree(pneg_rsp);
-	return 0;
+	goto out_free_rsp;
=20
 vneg_out:
 	cifs_dbg(VFS, "protocol revalidation - security settings mismatch\n");
-err_rsp_free:
+out_free_rsp:
 	kfree(pneg_rsp);
-	return -EIO;
+out_free_inbuf:
+	kfree(pneg_inbuf);
+	return rc;
 }
=20
 int
@@ -1176,8 +1183,10 @@ SMB2_open(const unsigned int xid, struct cifs_open_p=
arms *oparms, __le16 *path,
 			copy_size +=3D 8;
=20
 		copy_path =3D kzalloc(copy_size, GFP_KERNEL);
-		if (!copy_path)
+		if (!copy_path) {
+			cifs_small_buf_release(req);
 			return -ENOMEM;
+		}
 		memcpy((char *)copy_path, (const char *)path,
 			uni_path_len);
 		uni_path_len =3D copy_size;
diff --git a/fs/dcache.c b/fs/dcache.c
index e1380da5c183..7befa3a373cf 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1680,6 +1680,28 @@ void d_instantiate(struct dentry *entry, struct inod=
e * inode)
 }
 EXPORT_SYMBOL(d_instantiate);
=20
+/*
+ * This should be equivalent to d_instantiate() + unlock_new_inode(),
+ * with lockdep-related part of unlock_new_inode() done before
+ * anything else.  Use that instead of open-coding d_instantiate()/
+ * unlock_new_inode() combinations.
+ */
+void d_instantiate_new(struct dentry *entry, struct inode *inode)
+{
+	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
+	BUG_ON(!inode);
+	lockdep_annotate_inode_mutex_key(inode);
+	security_d_instantiate(entry, inode);
+	spin_lock(&inode->i_lock);
+	__d_instantiate(entry, inode);
+	WARN_ON(!(inode->i_state & I_NEW));
+	inode->i_state &=3D ~I_NEW;
+	smp_mb();
+	wake_up_bit(&inode->i_state, __I_NEW);
+	spin_unlock(&inode->i_lock);
+}
+EXPORT_SYMBOL(d_instantiate_new);
+
 /**
  * d_instantiate_unique - instantiate a non-aliased dentry
  * @entry: dentry to instantiate
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 8bc9ec714467..9819a544a160 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -298,8 +298,7 @@ ecryptfs_create(struct inode *directory_inode, struct d=
entry *ecryptfs_dentry,
 		iput(ecryptfs_inode);
 		goto out;
 	}
-	unlock_new_inode(ecryptfs_inode);
-	d_instantiate(ecryptfs_dentry, ecryptfs_inode);
+	d_instantiate_new(ecryptfs_dentry, ecryptfs_inode);
 out:
 	return rc;
 }
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index b822e4a447d6..829fb1e01898 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1169,21 +1169,11 @@ static void __ext2_truncate_blocks(struct inode *in=
ode, loff_t offset)
=20
 static void ext2_truncate_blocks(struct inode *inode, loff_t offset)
 {
-	/*
-	 * XXX: it seems like a bug here that we don't allow
-	 * IS_APPEND inode to have blocks-past-i_size trimmed off.
-	 * review and fix this.
-	 *
-	 * Also would be nice to be able to handle IO errors and such,
-	 * but that's probably too much to ask.
-	 */
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 	    S_ISLNK(inode->i_mode)))
 		return;
 	if (ext2_inode_is_fast_symlink(inode))
 		return;
-	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
-		return;
 	__ext2_truncate_blocks(inode, offset);
 }
=20
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index c268d0af1db9..b31b12ddb99b 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -41,8 +41,7 @@ static inline int ext2_add_nondir(struct dentry *dentry, =
struct inode *inode)
 {
 	int err =3D ext2_add_link(dentry, inode);
 	if (!err) {
-		unlock_new_inode(inode);
-		d_instantiate(dentry, inode);
+		d_instantiate_new(dentry, inode);
 		return 0;
 	}
 	inode_dec_link_count(inode);
@@ -265,8 +264,7 @@ static int ext2_mkdir(struct inode * dir, struct dentry=
 * dentry, umode_t mode)
 	if (err)
 		goto out_fail;
=20
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 out:
 	return err;
=20
diff --git a/fs/ext3/namei.c b/fs/ext3/namei.c
index f197736dccfa..e0053011ce6e 100644
--- a/fs/ext3/namei.c
+++ b/fs/ext3/namei.c
@@ -1671,8 +1671,7 @@ static int ext3_add_nondir(handle_t *handle,
 	int err =3D ext3_add_entry(handle, dentry, inode);
 	if (!err) {
 		ext3_mark_inode_dirty(handle, inode);
-		unlock_new_inode(inode);
-		d_instantiate(dentry, inode);
+		d_instantiate_new(dentry, inode);
 		return 0;
 	}
 	drop_nlink(inode);
@@ -1873,8 +1872,7 @@ static int ext3_mkdir(struct inode * dir, struct dent=
ry * dentry, umode_t mode)
 	if (err)
 		goto out_clear_inode;
=20
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 out_stop:
 	brelse(dir_block);
 	ext3_journal_stop(handle);
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 75aa5bac77d4..a6a13ad3d537 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -239,8 +239,6 @@ static int ext4_init_block_bitmap(struct super_block *s=
b,
 	 */
 	ext4_mark_bitmap_end(num_clusters_in_group(sb, block_group),
 			     sb->s_blocksize * 8, bh->b_data);
-	ext4_block_bitmap_csum_set(sb, block_group, gdp, bh);
-	ext4_group_desc_csum_set(sb, block_group, gdp);
 	return 0;
 }
=20
@@ -464,6 +462,7 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, e=
xt4_group_t block_group)
 		err =3D ext4_init_block_bitmap(sb, bh, block_group, desc);
 		set_bitmap_uptodate(bh);
 		set_buffer_uptodate(bh);
+		set_buffer_verified(bh);
 		ext4_unlock_group(sb, block_group);
 		unlock_buffer(bh);
 		if (err)
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ef1bed66c14f..8dd5c51e2200 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -322,13 +322,15 @@ static loff_t ext4_dir_llseek(struct file *file, loff=
_t offset, int whence)
 {
 	struct inode *inode =3D file->f_mapping->host;
 	int dx_dir =3D is_dx_dir(inode);
-	loff_t htree_max =3D ext4_get_htree_eof(file);
+	loff_t ret, htree_max =3D ext4_get_htree_eof(file);
=20
 	if (likely(dx_dir))
-		return generic_file_llseek_size(file, offset, whence,
+		ret =3D generic_file_llseek_size(file, offset, whence,
 						    htree_max, htree_max);
 	else
-		return ext4_llseek(file, offset, whence);
+		ret =3D ext4_llseek(file, offset, whence);
+	file->f_version =3D inode->i_version - 1;
+	return ret;
 }
=20
 /*
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index bc9b595a2d6d..3830dc1f8957 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -64,45 +64,6 @@ void ext4_mark_bitmap_end(int start_bit, int end_bit, ch=
ar *bitmap)
 		memset(bitmap + (i >> 3), 0xff, (end_bit - i) >> 3);
 }
=20
-/* Initializes an uninitialized inode bitmap */
-static unsigned ext4_init_inode_bitmap(struct super_block *sb,
-				       struct buffer_head *bh,
-				       ext4_group_t block_group,
-				       struct ext4_group_desc *gdp)
-{
-	struct ext4_group_info *grp;
-	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
-	J_ASSERT_BH(bh, buffer_locked(bh));
-
-	/* If checksum is bad mark all blocks and inodes use to prevent
-	 * allocation, essentially implementing a per-group read-only flag. */
-	if (!ext4_group_desc_csum_verify(sb, block_group, gdp)) {
-		ext4_error(sb, "Checksum bad for group %u", block_group);
-		grp =3D ext4_get_group_info(sb, block_group);
-		if (!EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
-			percpu_counter_sub(&sbi->s_freeclusters_counter,
-					   grp->bb_free);
-		set_bit(EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT, &grp->bb_state);
-		if (!EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) {
-			int count;
-			count =3D ext4_free_inodes_count(sb, gdp);
-			percpu_counter_sub(&sbi->s_freeinodes_counter,
-					   count);
-		}
-		set_bit(EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT, &grp->bb_state);
-		return 0;
-	}
-
-	memset(bh->b_data, 0, (EXT4_INODES_PER_GROUP(sb) + 7) / 8);
-	ext4_mark_bitmap_end(EXT4_INODES_PER_GROUP(sb), sb->s_blocksize * 8,
-			bh->b_data);
-	ext4_inode_bitmap_csum_set(sb, block_group, gdp, bh,
-				   EXT4_INODES_PER_GROUP(sb) / 8);
-	ext4_group_desc_csum_set(sb, block_group, gdp);
-
-	return EXT4_INODES_PER_GROUP(sb);
-}
-
 void ext4_end_bitmap_read(struct buffer_head *bh, int uptodate)
 {
 	if (uptodate) {
@@ -166,7 +127,9 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_gro=
up_t block_group)
 			put_bh(bh);
 			return NULL;
 		}
-		ext4_init_inode_bitmap(sb, bh, block_group, desc);
+		memset(bh->b_data, 0, (EXT4_INODES_PER_GROUP(sb) + 7) / 8);
+		ext4_mark_bitmap_end(EXT4_INODES_PER_GROUP(sb),
+				     sb->s_blocksize * 8, bh->b_data);
 		set_bitmap_uptodate(bh);
 		set_buffer_uptodate(bh);
 		set_buffer_verified(bh);
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 0c9ed67fe055..8df46f49a3d5 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -649,7 +649,6 @@ ssize_t ext4_ind_direct_IO(int rw, struct kiocb *iocb,
 {
 	struct file *file =3D iocb->ki_filp;
 	struct inode *inode =3D file->f_mapping->host;
-	struct ext4_inode_info *ei =3D EXT4_I(inode);
 	handle_t *handle;
 	ssize_t ret;
 	int orphan =3D 0;
@@ -672,7 +671,7 @@ ssize_t ext4_ind_direct_IO(int rw, struct kiocb *iocb,
 				goto out;
 			}
 			orphan =3D 1;
-			ei->i_disksize =3D inode->i_size;
+			ext4_update_i_disksize(inode, inode->i_size);
 			ext4_journal_stop(handle);
 		}
 	}
@@ -731,7 +730,7 @@ ssize_t ext4_ind_direct_IO(int rw, struct kiocb *iocb,
 		if (ret > 0) {
 			loff_t end =3D offset + ret;
 			if (end > inode->i_size) {
-				ei->i_disksize =3D end;
+				ext4_update_i_disksize(inode, end);
 				i_size_write(inode, end);
 				/*
 				 * We're going to return a positive `ret'
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 6d6848a9891b..7edf1bee591b 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2227,8 +2227,7 @@ static int ext4_add_nondir(handle_t *handle,
 	int err =3D ext4_add_entry(handle, dentry, inode);
 	if (!err) {
 		ext4_mark_inode_dirty(handle, inode);
-		unlock_new_inode(inode);
-		d_instantiate(dentry, inode);
+		d_instantiate_new(dentry, inode);
 		return 0;
 	}
 	drop_nlink(inode);
@@ -2466,8 +2465,7 @@ static int ext4_mkdir(struct inode *dir, struct dentr=
y *dentry, umode_t mode)
 	err =3D ext4_mark_inode_dirty(handle, dir);
 	if (err)
 		goto out_clear_inode;
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
=20
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 887611069625..82e54e5013bf 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -188,6 +188,7 @@ ext4_xattr_check_names(struct ext4_xattr_entry *entry, =
void *end,
 {
 	struct ext4_xattr_entry *e =3D entry;
=20
+	/* Find the end of the names list */
 	while (!IS_LAST_ENTRY(e)) {
 		struct ext4_xattr_entry *next =3D EXT4_XATTR_NEXT(e);
 		if ((void *)next >=3D end)
@@ -195,13 +196,27 @@ ext4_xattr_check_names(struct ext4_xattr_entry *entry=
, void *end,
 		e =3D next;
 	}
=20
+	/* Check the values */
 	while (!IS_LAST_ENTRY(entry)) {
-		if (entry->e_value_size !=3D 0 &&
-		    (value_start + le16_to_cpu(entry->e_value_offs) <
-		     (void *)e + sizeof(__u32) ||
-		     value_start + le16_to_cpu(entry->e_value_offs) +
-		    le32_to_cpu(entry->e_value_size) > end))
-			return -EIO;
+		if (entry->e_value_size !=3D 0) {
+			u16 offs =3D le16_to_cpu(entry->e_value_offs);
+			u32 size =3D le32_to_cpu(entry->e_value_size);
+			void *value;
+
+			/*
+			 * The value cannot overlap the names, and the value
+			 * with padding cannot extend beyond 'end'.  Check both
+			 * the padded and unpadded sizes, since the size may
+			 * overflow to 0 when adding padding.
+			 */
+			if (offs > end - value_start)
+				return -EIO;
+			value =3D value_start + offs;
+			if (value < (void *)e + sizeof(u32) ||
+			    size > end - value ||
+			    EXT4_XATTR_SIZE(size) > end - value)
+				return -EIO;
+		}
 		entry =3D EXT4_XATTR_NEXT(entry);
 	}
=20
@@ -240,18 +255,23 @@ ext4_xattr_check_entry(struct ext4_xattr_entry *entry=
, size_t size)
 }
=20
 static int
-ext4_xattr_find_entry(struct ext4_xattr_entry **pentry, int name_index,
-		      const char *name, size_t size, int sorted)
+xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
+		 void *end, int name_index, const char *name, size_t size,
+		 int sorted)
 {
-	struct ext4_xattr_entry *entry;
+	struct ext4_xattr_entry *entry, *next;
 	size_t name_len;
 	int cmp =3D 1;
=20
 	if (name =3D=3D NULL)
 		return -EINVAL;
 	name_len =3D strlen(name);
-	entry =3D *pentry;
-	for (; !IS_LAST_ENTRY(entry); entry =3D EXT4_XATTR_NEXT(entry)) {
+	for (entry =3D *pentry; !IS_LAST_ENTRY(entry); entry =3D next) {
+		next =3D EXT4_XATTR_NEXT(entry);
+		if ((void *) next >=3D end) {
+			EXT4_ERROR_INODE(inode, "corrupted xattr entries");
+			return -EIO;
+		}
 		cmp =3D name_index - entry->e_name_index;
 		if (!cmp)
 			cmp =3D name_len - entry->e_name_len;
@@ -273,6 +293,7 @@ ext4_xattr_block_get(struct inode *inode, int name_inde=
x, const char *name,
 	struct buffer_head *bh =3D NULL;
 	struct ext4_xattr_entry *entry;
 	size_t size;
+	void *end;
 	int error;
 	struct mb_cache *ext4_mb_cache =3D EXT4_GET_MB_CACHE(inode);
=20
@@ -298,18 +319,26 @@ ext4_xattr_block_get(struct inode *inode, int name_in=
dex, const char *name,
 	}
 	ext4_xattr_cache_insert(ext4_mb_cache, bh);
 	entry =3D BFIRST(bh);
-	error =3D ext4_xattr_find_entry(&entry, name_index, name, bh->b_size, 1);
+	end =3D bh->b_data + bh->b_size;
+	error =3D xattr_find_entry(inode, &entry, end, name_index, name,
+				 bh->b_size, 1);
 	if (error =3D=3D -EIO)
 		goto bad_block;
 	if (error)
 		goto cleanup;
 	size =3D le32_to_cpu(entry->e_value_size);
+	error =3D -ERANGE;
+	if (unlikely(size > EXT4_XATTR_SIZE_MAX))
+		goto cleanup;
 	if (buffer) {
-		error =3D -ERANGE;
+		u16 offset =3D le16_to_cpu(entry->e_value_offs);
+		void *p =3D bh->b_data + offset;
+
 		if (size > buffer_size)
 			goto cleanup;
-		memcpy(buffer, bh->b_data + le16_to_cpu(entry->e_value_offs),
-		       size);
+		if (unlikely(p + size > end))
+			goto cleanup;
+		memcpy(buffer, p, size);
 	}
 	error =3D size;
=20
@@ -342,17 +371,23 @@ ext4_xattr_ibody_get(struct inode *inode, int name_in=
dex, const char *name,
 	error =3D ext4_xattr_check_names(entry, end, entry);
 	if (error)
 		goto cleanup;
-	error =3D ext4_xattr_find_entry(&entry, name_index, name,
-				      end - (void *)entry, 0);
+	error =3D xattr_find_entry(inode, &entry, end, name_index, name,
+				 end - (void *)entry, 0);
 	if (error)
 		goto cleanup;
 	size =3D le32_to_cpu(entry->e_value_size);
+	error =3D -ERANGE;
+	if (unlikely(size > EXT4_XATTR_SIZE_MAX))
+		goto cleanup;
 	if (buffer) {
-		error =3D -ERANGE;
+		u16 offset =3D le16_to_cpu(entry->e_value_offs);
+		void *p =3D (void *)IFIRST(header) + offset;
+
 		if (size > buffer_size)
 			goto cleanup;
-		memcpy(buffer, (void *)IFIRST(header) +
-		       le16_to_cpu(entry->e_value_offs), size);
+		if (unlikely(p + size > end))
+			goto cleanup;
+		memcpy(buffer, p, size);
 	}
 	error =3D size;
=20
@@ -761,8 +796,9 @@ ext4_xattr_block_find(struct inode *inode, struct ext4_=
xattr_info *i,
 		bs->s.first =3D BFIRST(bs->bh);
 		bs->s.end =3D bs->bh->b_data + bs->bh->b_size;
 		bs->s.here =3D bs->s.first;
-		error =3D ext4_xattr_find_entry(&bs->s.here, i->name_index,
-					      i->name, bs->bh->b_size, 1);
+		error =3D xattr_find_entry(inode, &bs->s.here, bs->s.end,
+					 i->name_index, i->name,
+					 bs->bh->b_size, 1);
 		if (error && error !=3D -ENODATA)
 			goto cleanup;
 		bs->s.not_found =3D error;
@@ -1007,9 +1043,9 @@ int ext4_xattr_ibody_find(struct inode *inode, struct=
 ext4_xattr_info *i,
 		if (error)
 			return error;
 		/* Find the named attribute. */
-		error =3D ext4_xattr_find_entry(&is->s.here, i->name_index,
-					      i->name, is->s.end -
-					      (void *)is->s.base, 0);
+		error =3D xattr_find_entry(inode, &is->s.here, is->s.end,
+					 i->name_index, i->name,
+					 is->s.end - (void *)is->s.base, 0);
 		if (error && error !=3D -ENODATA)
 			return error;
 		is->s.not_found =3D error;
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 2e8f23e78bc2..829f473277e4 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -67,6 +67,17 @@ struct ext4_xattr_entry {
 		EXT4_I(inode)->i_extra_isize))
 #define IFIRST(hdr) ((struct ext4_xattr_entry *)((hdr)+1))
=20
+/*
+ * XATTR_SIZE_MAX is currently 64k, but for the purposes of checking
+ * for file system consistency errors, we use a somewhat bigger value.
+ * This allows XATTR_SIZE_MAX to grow in the future, but by using this
+ * instead of INT_MAX for certain consistency checks, we don't need to
+ * worry about arithmetic overflows.  (Actually XATTR_SIZE_MAX is
+ * defined in include/uapi/linux/limits.h, so changing it is going
+ * not going to be trivial....)
+ */
+#define EXT4_XATTR_SIZE_MAX (1 << 24)
+
 #define BHDR(bh) ((struct ext4_xattr_header *)((bh)->b_data))
 #define ENTRY(ptr) ((struct ext4_xattr_entry *)(ptr))
 #define BFIRST(bh) ENTRY(BHDR(bh)+1)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 22e6307b25e2..c1970422ac47 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1121,6 +1121,7 @@ void update_inode(struct inode *, struct page *);
 void update_inode_page(struct inode *);
 int f2fs_write_inode(struct inode *, struct writeback_control *);
 void f2fs_evict_inode(struct inode *);
+void handle_failed_inode(struct inode *);
=20
 /*
  * namei.c
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b3524f06fd82..140f939a88da 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -602,7 +602,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, s=
truct f2fs_summary *sum,
=20
 		if (phase =3D=3D 2) {
 			inode =3D f2fs_iget(sb, dni.ino);
-			if (IS_ERR(inode))
+			if (IS_ERR(inode) || is_bad_inode(inode))
 				continue;
=20
 			start_bidx =3D start_bidx_of_node(nofs, F2FS_I(inode));
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 4d333b643cc8..d06b36ddbe75 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -299,3 +299,26 @@ void f2fs_evict_inode(struct inode *inode)
 	clear_inode(inode);
 	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
 }
+
+/* caller should call f2fs_lock_op() */
+void handle_failed_inode(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi =3D F2FS_SB(inode->i_sb);
+
+	clear_nlink(inode);
+	make_bad_inode(inode);
+	unlock_new_inode(inode);
+
+	i_size_write(inode, 0);
+	if (F2FS_HAS_BLOCKS(inode))
+		f2fs_truncate(inode);
+
+	remove_inode_page(inode);
+	stat_dec_inline_inode(inode);
+
+	alloc_nid_failed(sbi, inode->i_ino);
+	f2fs_unlock_op(sbi);
+
+	/* iput will drop the inode object */
+	iput(inode);
+}
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a6bdddc33ce2..53cb0731e287 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -52,15 +52,12 @@ static struct inode *f2fs_new_inode(struct inode *dir, =
umode_t mode)
 	if (err) {
 		err =3D -EINVAL;
 		nid_free =3D true;
-		goto out;
+		goto fail;
 	}
 	trace_f2fs_new_inode(inode, 0);
 	mark_inode_dirty(inode);
 	return inode;
=20
-out:
-	clear_nlink(inode);
-	unlock_new_inode(inode);
 fail:
 	trace_f2fs_new_inode(inode, err);
 	make_bad_inode(inode);
@@ -124,21 +121,16 @@ static int f2fs_create(struct inode *dir, struct dent=
ry *dentry, umode_t mode,
=20
 	f2fs_lock_op(sbi);
 	err =3D f2fs_add_link(dentry, inode);
-	f2fs_unlock_op(sbi);
 	if (err)
 		goto out;
+	f2fs_unlock_op(sbi);
=20
 	alloc_nid_done(sbi, ino);
=20
-	d_instantiate(dentry, inode);
-	unlock_new_inode(inode);
+	d_instantiate_new(dentry, inode);
 	return 0;
 out:
-	clear_nlink(inode);
-	unlock_new_inode(inode);
-	make_bad_inode(inode);
-	iput(inode);
-	alloc_nid_failed(sbi, ino);
+	handle_failed_inode(inode);
 	return err;
 }
=20
@@ -158,15 +150,16 @@ static int f2fs_link(struct dentry *old_dentry, struc=
t inode *dir,
 	set_inode_flag(F2FS_I(inode), FI_INC_LINK);
 	f2fs_lock_op(sbi);
 	err =3D f2fs_add_link(dentry, inode);
-	f2fs_unlock_op(sbi);
 	if (err)
 		goto out;
+	f2fs_unlock_op(sbi);
=20
 	d_instantiate(dentry, inode);
 	return 0;
 out:
 	clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
 	iput(inode);
+	f2fs_unlock_op(sbi);
 	return err;
 }
=20
@@ -259,22 +252,17 @@ static int f2fs_symlink(struct inode *dir, struct den=
try *dentry,
=20
 	f2fs_lock_op(sbi);
 	err =3D f2fs_add_link(dentry, inode);
-	f2fs_unlock_op(sbi);
 	if (err)
 		goto out;
+	f2fs_unlock_op(sbi);
=20
 	err =3D page_symlink(inode, symname, symlen);
 	alloc_nid_done(sbi, inode->i_ino);
=20
-	d_instantiate(dentry, inode);
-	unlock_new_inode(inode);
+	d_instantiate_new(dentry, inode);
 	return err;
 out:
-	clear_nlink(inode);
-	unlock_new_inode(inode);
-	make_bad_inode(inode);
-	iput(inode);
-	alloc_nid_failed(sbi, inode->i_ino);
+	handle_failed_inode(inode);
 	return err;
 }
=20
@@ -298,24 +286,19 @@ static int f2fs_mkdir(struct inode *dir, struct dentr=
y *dentry, umode_t mode)
 	set_inode_flag(F2FS_I(inode), FI_INC_LINK);
 	f2fs_lock_op(sbi);
 	err =3D f2fs_add_link(dentry, inode);
-	f2fs_unlock_op(sbi);
 	if (err)
 		goto out_fail;
+	f2fs_unlock_op(sbi);
=20
 	alloc_nid_done(sbi, inode->i_ino);
=20
-	d_instantiate(dentry, inode);
-	unlock_new_inode(inode);
+	d_instantiate_new(dentry, inode);
=20
 	return 0;
=20
 out_fail:
 	clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
-	clear_nlink(inode);
-	unlock_new_inode(inode);
-	make_bad_inode(inode);
-	iput(inode);
-	alloc_nid_failed(sbi, inode->i_ino);
+	handle_failed_inode(inode);
 	return err;
 }
=20
@@ -349,20 +332,15 @@ static int f2fs_mknod(struct inode *dir, struct dentr=
y *dentry,
=20
 	f2fs_lock_op(sbi);
 	err =3D f2fs_add_link(dentry, inode);
-	f2fs_unlock_op(sbi);
 	if (err)
 		goto out;
+	f2fs_unlock_op(sbi);
=20
 	alloc_nid_done(sbi, inode->i_ino);
-	d_instantiate(dentry, inode);
-	unlock_new_inode(inode);
+	d_instantiate_new(dentry, inode);
 	return 0;
 out:
-	clear_nlink(inode);
-	unlock_new_inode(inode);
-	make_bad_inode(inode);
-	iput(inode);
-	alloc_nid_failed(sbi, inode->i_ino);
+	handle_failed_inode(inode);
 	return err;
 }
=20
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cd4fd8aa3c80..108d3612430b 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1071,7 +1071,7 @@ void bdi_writeback_workfn(struct work_struct *work)
 	}
=20
 	if (!list_empty(&bdi->work_list))
-		mod_delayed_work(bdi_wq, &wb->dwork, 0);
+		bdi_wakeup_thread(bdi);
 	else if (wb_has_dirty_io(wb) && dirty_writeback_interval)
 		bdi_wakeup_thread_delayed(bdi);
=20
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 69546f170ccf..e585baa9f037 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -127,10 +127,14 @@ static int hugetlbfs_file_mmap(struct file *file, str=
uct vm_area_struct *vma)
=20
 	/*
 	 * page based offset in vm_pgoff could be sufficiently large to
-	 * overflow a (l)off_t when converted to byte offset.
+	 * overflow a loff_t when converted to byte offset.  This can
+	 * only happen on architectures where sizeof(loff_t) =3D=3D
+	 * sizeof(unsigned long).  So, only check in those instances.
 	 */
-	if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
-		return -EINVAL;
+	if (sizeof(unsigned long) =3D=3D sizeof(loff_t)) {
+		if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
+			return -EINVAL;
+	}
=20
 	/* must be huge page aligned */
 	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 834a9c2585a9..7cc112108df6 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -923,7 +923,7 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t ti=
d, unsigned long block)
 }
=20
 /*
- * This is a variaon of __jbd2_update_log_tail which checks for validity of
+ * This is a variation of __jbd2_update_log_tail which checks for validity=
 of
  * provided log tail and locks j_checkpoint_mutex. So it is safe against r=
aces
  * with other threads updating log tail.
  */
@@ -1399,6 +1399,9 @@ int jbd2_journal_update_sb_log_tail(journal_t *journa=
l, tid_t tail_tid,
 	journal_superblock_t *sb =3D journal->j_superblock;
 	int ret;
=20
+	if (is_journal_aborted(journal))
+		return -EIO;
+
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
 	jbd_debug(1, "JBD2: updating superblock (start %lu, seq %u)\n",
 		  tail_block, tail_tid);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 3ab84e02c6dd..398565726b92 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -515,6 +515,7 @@ int jbd2_journal_start_reserved(handle_t *handle, unsig=
ned int type,
 	 */
 	ret =3D start_this_handle(journal, handle, GFP_NOFS);
 	if (ret < 0) {
+		handle->h_journal =3D journal;
 		jbd2_journal_free_reserved(handle);
 		return ret;
 	}
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 938556025d64..1313e32f66ea 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -207,8 +207,7 @@ static int jffs2_create(struct inode *dir_i, struct den=
try *dentry,
 		  __func__, inode->i_ino, inode->i_mode, inode->i_nlink,
 		  f->inocache->pino_nlink, inode->i_mapping->nrpages);
=20
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	return 0;
=20
  fail:
@@ -427,8 +426,7 @@ static int jffs2_symlink (struct inode *dir_i, struct d=
entry *dentry, const char
 	mutex_unlock(&dir_f->sem);
 	jffs2_complete_reservation(c);
=20
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	return 0;
=20
  fail:
@@ -572,8 +570,7 @@ static int jffs2_mkdir (struct inode *dir_i, struct den=
try *dentry, umode_t mode
 	mutex_unlock(&dir_f->sem);
 	jffs2_complete_reservation(c);
=20
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	return 0;
=20
  fail:
@@ -747,8 +744,7 @@ static int jffs2_mknod (struct inode *dir_i, struct den=
try *dentry, umode_t mode
 	mutex_unlock(&dir_f->sem);
 	jffs2_complete_reservation(c);
=20
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	return 0;
=20
  fail:
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 0918f0e2e266..10902f70883d 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -345,7 +345,7 @@ static void jffs2_put_super (struct super_block *sb)
 static void jffs2_kill_sb(struct super_block *sb)
 {
 	struct jffs2_sb_info *c =3D JFFS2_SB_INFO(sb);
-	if (!(sb->s_flags & MS_RDONLY))
+	if (c && !(sb->s_flags & MS_RDONLY))
 		jffs2_stop_garbage_collect_thread(c);
 	kill_mtd_super(sb);
 	kfree(c);
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index d59c7defb1ef..d071500a2afa 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -176,8 +176,7 @@ static int jfs_create(struct inode *dip, struct dentry =
*dentry, umode_t mode,
 		unlock_new_inode(ip);
 		iput(ip);
 	} else {
-		unlock_new_inode(ip);
-		d_instantiate(dentry, ip);
+		d_instantiate_new(dentry, ip);
 	}
=20
       out2:
@@ -309,8 +308,7 @@ static int jfs_mkdir(struct inode *dip, struct dentry *=
dentry, umode_t mode)
 		unlock_new_inode(ip);
 		iput(ip);
 	} else {
-		unlock_new_inode(ip);
-		d_instantiate(dentry, ip);
+		d_instantiate_new(dentry, ip);
 	}
=20
       out2:
@@ -1043,8 +1041,7 @@ static int jfs_symlink(struct inode *dip, struct dent=
ry *dentry,
 		unlock_new_inode(ip);
 		iput(ip);
 	} else {
-		unlock_new_inode(ip);
-		d_instantiate(dentry, ip);
+		d_instantiate_new(dentry, ip);
 	}
=20
       out2:
@@ -1424,8 +1421,7 @@ static int jfs_mknod(struct inode *dir, struct dentry=
 *dentry,
 		unlock_new_inode(ip);
 		iput(ip);
 	} else {
-		unlock_new_inode(ip);
-		d_instantiate(dentry, ip);
+		d_instantiate_new(dentry, ip);
 	}
=20
       out1:
diff --git a/fs/namespace.c b/fs/namespace.c
index c1c0c8179498..fcf636e37c8e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -903,7 +903,8 @@ static struct mount *clone_mnt(struct mount *old, struc=
t dentry *root,
 			goto out_free;
 	}
=20
-	mnt->mnt.mnt_flags =3D old->mnt.mnt_flags & ~(MNT_WRITE_HOLD|MNT_MARKED);
+	mnt->mnt.mnt_flags =3D old->mnt.mnt_flags;
+	mnt->mnt.mnt_flags &=3D ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
 	/* Don't allow unprivileged users to change mount flags */
 	if (flag & CL_UNPRIVILEGED) {
 		mnt->mnt.mnt_flags |=3D MNT_LOCK_ATIME;
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 0f84b257932c..da65882b5407 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -50,8 +50,7 @@ static inline int nilfs_add_nondir(struct dentry *dentry,=
 struct inode *inode)
 {
 	int err =3D nilfs_add_link(dentry, inode);
 	if (!err) {
-		d_instantiate(dentry, inode);
-		unlock_new_inode(inode);
+		d_instantiate_new(dentry, inode);
 		return 0;
 	}
 	inode_dec_link_count(inode);
@@ -249,8 +248,7 @@ static int nilfs_mkdir(struct inode *dir, struct dentry=
 *dentry, umode_t mode)
 		goto out_fail;
=20
 	nilfs_mark_inode_dirty(inode);
-	d_instantiate(dentry, inode);
-	unlock_new_inode(inode);
+	d_instantiate_new(dentry, inode);
 out:
 	if (!err)
 		err =3D nilfs_transaction_commit(dir->i_sb);
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 0439f6cdb931..0ad2fe727dbd 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -92,7 +92,7 @@ static bool fanotify_should_send_event(struct fsnotify_ma=
rk *inode_mark,
 				       u32 event_mask,
 				       void *data, int data_type)
 {
-	__u32 marks_mask, marks_ignored_mask;
+	__u32 marks_mask =3D 0, marks_ignored_mask =3D 0;
 	struct path *path =3D data;
=20
 	pr_debug("%s: inode_mark=3D%p vfsmnt_mark=3D%p mask=3D%x data=3D%p"
@@ -108,24 +108,20 @@ static bool fanotify_should_send_event(struct fsnotif=
y_mark *inode_mark,
 	    !S_ISDIR(path->dentry->d_inode->i_mode))
 		return false;
=20
-	if (inode_mark && vfsmnt_mark) {
-		marks_mask =3D (vfsmnt_mark->mask | inode_mark->mask);
-		marks_ignored_mask =3D (vfsmnt_mark->ignored_mask | inode_mark->ignored_=
mask);
-	} else if (inode_mark) {
-		/*
-		 * if the event is for a child and this inode doesn't care about
-		 * events on the child, don't send it!
-		 */
-		if ((event_mask & FS_EVENT_ON_CHILD) &&
-		    !(inode_mark->mask & FS_EVENT_ON_CHILD))
-			return false;
-		marks_mask =3D inode_mark->mask;
-		marks_ignored_mask =3D inode_mark->ignored_mask;
-	} else if (vfsmnt_mark) {
-		marks_mask =3D vfsmnt_mark->mask;
-		marks_ignored_mask =3D vfsmnt_mark->ignored_mask;
-	} else {
-		BUG();
+	/*
+	 * if the event is for a child and this inode doesn't care about
+	 * events on the child, don't send it!
+	 */
+	if (inode_mark &&
+	    (!(event_mask & FS_EVENT_ON_CHILD) ||
+	     (inode_mark->mask & FS_EVENT_ON_CHILD))) {
+		marks_mask |=3D inode_mark->mask;
+		marks_ignored_mask |=3D inode_mark->ignored_mask;
+	}
+
+	if (vfsmnt_mark) {
+		marks_mask |=3D vfsmnt_mark->mask;
+		marks_ignored_mask |=3D vfsmnt_mark->ignored_mask;
 	}
=20
 	if (S_ISDIR(path->dentry->d_inode->i_mode) &&
diff --git a/fs/ocfs2/dlm/dlmcommon.h b/fs/ocfs2/dlm/dlmcommon.h
index fae17c640df3..3626a6a39135 100644
--- a/fs/ocfs2/dlm/dlmcommon.h
+++ b/fs/ocfs2/dlm/dlmcommon.h
@@ -140,6 +140,7 @@ struct dlm_ctxt
 	u8 node_num;
 	u32 key;
 	u8  joining_node;
+	u8 migrate_done; /* set to 1 means node has migrated all lock resources */
 	wait_queue_head_t dlm_join_events;
 	unsigned long live_nodes_map[BITS_TO_LONGS(O2NM_MAX_NODES)];
 	unsigned long domain_map[BITS_TO_LONGS(O2NM_MAX_NODES)];
diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index 39efc5057a36..b9933c528d24 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -460,6 +460,19 @@ static int dlm_migrate_all_locks(struct dlm_ctxt *dlm)
 		cond_resched_lock(&dlm->spinlock);
 		num +=3D n;
 	}
+
+	if (!num) {
+		if (dlm->reco.state & DLM_RECO_STATE_ACTIVE) {
+			mlog(0, "%s: perhaps there are more lock resources "
+			     "need to be migrated after dlm recovery\n", dlm->name);
+			ret =3D -EAGAIN;
+		} else {
+			mlog(0, "%s: we won't do dlm recovery after migrating "
+			     "all lock resources\n", dlm->name);
+			dlm->migrate_done =3D 1;
+		}
+	}
+
 	spin_unlock(&dlm->spinlock);
 	wake_up(&dlm->dlm_thread_wq);
=20
@@ -2063,6 +2076,8 @@ static struct dlm_ctxt *dlm_alloc_ctxt(const char *do=
main,
 	dlm->joining_node =3D DLM_LOCK_RES_OWNER_UNKNOWN;
 	init_waitqueue_head(&dlm->dlm_join_events);
=20
+	dlm->migrate_done =3D 0;
+
 	dlm->reco.new_master =3D O2NM_INVALID_NODE_NUM;
 	dlm->reco.dead_node =3D O2NM_INVALID_NODE_NUM;
=20
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 44f93043b2e9..42a941dcb193 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -423,12 +423,11 @@ void dlm_wait_for_recovery(struct dlm_ctxt *dlm)
=20
 static void dlm_begin_recovery(struct dlm_ctxt *dlm)
 {
-	spin_lock(&dlm->spinlock);
+	assert_spin_locked(&dlm->spinlock);
 	BUG_ON(dlm->reco.state & DLM_RECO_STATE_ACTIVE);
 	printk(KERN_NOTICE "o2dlm: Begin recovery on domain %s for node %u\n",
 	       dlm->name, dlm->reco.dead_node);
 	dlm->reco.state |=3D DLM_RECO_STATE_ACTIVE;
-	spin_unlock(&dlm->spinlock);
 }
=20
 static void dlm_end_recovery(struct dlm_ctxt *dlm)
@@ -456,6 +455,13 @@ static int dlm_do_recovery(struct dlm_ctxt *dlm)
=20
 	spin_lock(&dlm->spinlock);
=20
+	if (dlm->migrate_done) {
+		mlog(0, "%s: no need do recovery after migrating all "
+		     "lock resources\n", dlm->name);
+		spin_unlock(&dlm->spinlock);
+		return 0;
+	}
+
 	/* check to see if the new master has died */
 	if (dlm->reco.new_master !=3D O2NM_INVALID_NODE_NUM &&
 	    test_bit(dlm->reco.new_master, dlm->recovery_map)) {
@@ -490,12 +496,13 @@ static int dlm_do_recovery(struct dlm_ctxt *dlm)
 	mlog(0, "%s(%d):recovery thread found node %u in the recovery map!\n",
 	     dlm->name, task_pid_nr(dlm->dlm_reco_thread_task),
 	     dlm->reco.dead_node);
-	spin_unlock(&dlm->spinlock);
=20
 	/* take write barrier */
 	/* (stops the list reshuffling thread, proxy ast handling) */
 	dlm_begin_recovery(dlm);
=20
+	spin_unlock(&dlm->spinlock);
+
 	if (dlm->reco.new_master =3D=3D dlm->node_num)
 		goto master_here;
=20
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 75a00557cfea..bfb8e8d588b8 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -654,7 +654,10 @@ static bool proc_sys_link_fill_cache(struct file *file,
 				    struct ctl_table *table)
 {
 	bool ret =3D true;
+
 	head =3D sysctl_head_grab(head);
+	if (IS_ERR(head))
+		return false;
=20
 	if (S_ISLNK(table->mode)) {
 		/* It is not an error if we can not follow the link ignore it */
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index a88b1b3e7db3..1e7cb5e45b7d 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2641,7 +2641,7 @@ static int journal_init_dev(struct super_block *super,
 	if (IS_ERR(journal->j_dev_bd)) {
 		result =3D PTR_ERR(journal->j_dev_bd);
 		journal->j_dev_bd =3D NULL;
-		reiserfs_warning(super,
+		reiserfs_warning(super, "sh-457",
 				 "journal_init_dev: Cannot open '%s': %i",
 				 jdev_name, result);
 		return result;
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index cd11358b10c7..2e9d82f7c35c 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -682,8 +682,7 @@ static int reiserfs_create(struct inode *dir, struct de=
ntry *dentry, umode_t mod
 	reiserfs_update_inode_transaction(inode);
 	reiserfs_update_inode_transaction(dir);
=20
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	retval =3D journal_end(&th);
=20
 out_failed:
@@ -763,8 +762,7 @@ static int reiserfs_mknod(struct inode *dir, struct den=
try *dentry, umode_t mode
 		goto out_failed;
 	}
=20
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	retval =3D journal_end(&th);
=20
 out_failed:
@@ -857,8 +855,7 @@ static int reiserfs_mkdir(struct inode *dir, struct den=
try *dentry, umode_t mode
 	/* the above add_entry did not update dir's stat data */
 	reiserfs_update_sd(&th, dir);
=20
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	retval =3D journal_end(&th);
 out_failed:
 	reiserfs_write_unlock(dir->i_sb);
@@ -1162,8 +1159,7 @@ static int reiserfs_symlink(struct inode *parent_dir,
 		goto out_failed;
 	}
=20
-	unlock_new_inode(inode);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	retval =3D journal_end(&th);
 out_failed:
 	reiserfs_write_unlock(parent_dir->i_sb);
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index eb25aa9d7710..41433bde933e 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1726,8 +1726,11 @@ static void ubifs_remount_ro(struct ubifs_info *c)
=20
 	dbg_save_space_info(c);
=20
-	for (i =3D 0; i < c->jhead_cnt; i++)
-		ubifs_wbuf_sync(&c->jheads[i].wbuf);
+	for (i =3D 0; i < c->jhead_cnt; i++) {
+		err =3D ubifs_wbuf_sync(&c->jheads[i].wbuf);
+		if (err)
+			ubifs_ro_mode(c, err);
+	}
=20
 	c->mst_node->flags &=3D ~cpu_to_le32(UBIFS_MST_DIRTY);
 	c->mst_node->flags |=3D cpu_to_le32(UBIFS_MST_NO_ORPHS);
@@ -1794,8 +1797,11 @@ static void ubifs_put_super(struct super_block *sb)
 			int err;
=20
 			/* Synchronize write-buffers */
-			for (i =3D 0; i < c->jhead_cnt; i++)
-				ubifs_wbuf_sync(&c->jheads[i].wbuf);
+			for (i =3D 0; i < c->jhead_cnt; i++) {
+				err =3D ubifs_wbuf_sync(&c->jheads[i].wbuf);
+				if (err)
+					ubifs_ro_mode(c, err);
+			}
=20
 			/*
 			 * We are being cleanly unmounted which means the
diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index 6eaf5edf1ea1..99c4b1364786 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -123,7 +123,12 @@ struct inode *udf_new_inode(struct inode *dir, umode_t=
 mode, int *err)
 		iinfo->i_alloc_type =3D ICBTAG_FLAG_AD_LONG;
 	inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =3D
 		iinfo->i_crtime =3D current_fs_time(inode->i_sb);
-	insert_inode_hash(inode);
+	if (unlikely(insert_inode_locked(inode) < 0)) {
+		make_bad_inode(inode);
+		iput(inode);
+		*err =3D -EIO;
+		return NULL;
+	}
 	mark_inode_dirty(inode);
=20
 	*err =3D 0;
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index fd6bfa153f49..2b5dd8043af5 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -551,32 +551,18 @@ static int udf_delete_entry(struct inode *inode, stru=
ct fileIdentDesc *fi,
 	return udf_write_fi(inode, cfi, fi, fibh, NULL, NULL);
 }
=20
-static int udf_create(struct inode *dir, struct dentry *dentry, umode_t mo=
de,
-		      bool excl)
+static int udf_add_nondir(struct dentry *dentry, struct inode *inode)
 {
+	struct udf_inode_info *iinfo =3D UDF_I(inode);
+	struct inode *dir =3D dentry->d_parent->d_inode;
 	struct udf_fileident_bh fibh;
-	struct inode *inode;
 	struct fileIdentDesc cfi, *fi;
 	int err;
-	struct udf_inode_info *iinfo;
-
-	inode =3D udf_new_inode(dir, mode, &err);
-	if (!inode) {
-		return err;
-	}
-
-	iinfo =3D UDF_I(inode);
-	if (iinfo->i_alloc_type =3D=3D ICBTAG_FLAG_AD_IN_ICB)
-		inode->i_data.a_ops =3D &udf_adinicb_aops;
-	else
-		inode->i_data.a_ops =3D &udf_aops;
-	inode->i_op =3D &udf_file_inode_operations;
-	inode->i_fop =3D &udf_file_operations;
-	mark_inode_dirty(inode);
=20
 	fi =3D udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (!fi) {
+	if (unlikely(!fi)) {
 		inode_dec_link_count(inode);
+		unlock_new_inode(inode);
 		iput(inode);
 		return err;
 	}
@@ -590,11 +576,33 @@ static int udf_create(struct inode *dir, struct dentr=
y *dentry, umode_t mode,
 	if (fibh.sbh !=3D fibh.ebh)
 		brelse(fibh.ebh);
 	brelse(fibh.sbh);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
=20
 	return 0;
 }
=20
+static int udf_create(struct inode *dir, struct dentry *dentry, umode_t mo=
de,
+		      bool excl)
+{
+	struct inode *inode;
+	int err;
+
+	inode =3D udf_new_inode(dir, mode, &err);
+	if (!inode) {
+		return err;
+	}
+
+	if (UDF_I(inode)->i_alloc_type =3D=3D ICBTAG_FLAG_AD_IN_ICB)
+		inode->i_data.a_ops =3D &udf_adinicb_aops;
+	else
+		inode->i_data.a_ops =3D &udf_aops;
+	inode->i_op =3D &udf_file_inode_operations;
+	inode->i_fop =3D &udf_file_operations;
+	mark_inode_dirty(inode);
+
+	return udf_add_nondir(dentry, inode);
+}
+
 static int udf_tmpfile(struct inode *dir, struct dentry *dentry, umode_t m=
ode)
 {
 	struct inode *inode;
@@ -615,6 +623,7 @@ static int udf_tmpfile(struct inode *dir, struct dentry=
 *dentry, umode_t mode)
 	mark_inode_dirty(inode);
=20
 	d_tmpfile(dentry, inode);
+	unlock_new_inode(inode);
 	return 0;
 }
=20
@@ -622,10 +631,7 @@ static int udf_mknod(struct inode *dir, struct dentry =
*dentry, umode_t mode,
 		     dev_t rdev)
 {
 	struct inode *inode;
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc cfi, *fi;
 	int err;
-	struct udf_inode_info *iinfo;
=20
 	if (!old_valid_dev(rdev))
 		return -EINVAL;
@@ -633,33 +639,10 @@ static int udf_mknod(struct inode *dir, struct dentry=
 *dentry, umode_t mode,
 	err =3D -EIO;
 	inode =3D udf_new_inode(dir, mode, &err);
 	if (!inode)
-		goto out;
-
-	iinfo =3D UDF_I(inode);
-	init_special_inode(inode, mode, rdev);
-	fi =3D udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (!fi) {
-		inode_dec_link_count(inode);
-		iput(inode);
 		return err;
-	}
-	cfi.icb.extLength =3D cpu_to_le32(inode->i_sb->s_blocksize);
-	cfi.icb.extLocation =3D cpu_to_lelb(iinfo->i_location);
-	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =3D
-		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
-	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
-	if (UDF_I(dir)->i_alloc_type =3D=3D ICBTAG_FLAG_AD_IN_ICB)
-		mark_inode_dirty(dir);
-	mark_inode_dirty(inode);
=20
-	if (fibh.sbh !=3D fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-	d_instantiate(dentry, inode);
-	err =3D 0;
-
-out:
-	return err;
+	init_special_inode(inode, mode, rdev);
+	return udf_add_nondir(dentry, inode);
 }
=20
 static int udf_mkdir(struct inode *dir, struct dentry *dentry, umode_t mod=
e)
@@ -682,6 +665,7 @@ static int udf_mkdir(struct inode *dir, struct dentry *=
dentry, umode_t mode)
 	fi =3D udf_add_entry(inode, NULL, &fibh, &cfi, &err);
 	if (!fi) {
 		inode_dec_link_count(inode);
+		unlock_new_inode(inode);
 		iput(inode);
 		goto out;
 	}
@@ -700,6 +684,7 @@ static int udf_mkdir(struct inode *dir, struct dentry *=
dentry, umode_t mode)
 	if (!fi) {
 		clear_nlink(inode);
 		mark_inode_dirty(inode);
+		unlock_new_inode(inode);
 		iput(inode);
 		goto out;
 	}
@@ -711,7 +696,7 @@ static int udf_mkdir(struct inode *dir, struct dentry *=
dentry, umode_t mode)
 	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
 	inc_nlink(dir);
 	mark_inode_dirty(dir);
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 	if (fibh.sbh !=3D fibh.ebh)
 		brelse(fibh.ebh);
 	brelse(fibh.sbh);
@@ -880,11 +865,8 @@ static int udf_symlink(struct inode *dir, struct dentr=
y *dentry,
 	struct inode *inode;
 	struct pathComponent *pc;
 	const char *compstart;
-	struct udf_fileident_bh fibh;
 	struct extent_position epos =3D {};
 	int eoffset, elen =3D 0;
-	struct fileIdentDesc *fi;
-	struct fileIdentDesc cfi;
 	uint8_t *ea;
 	int err;
 	int block;
@@ -1013,24 +995,7 @@ static int udf_symlink(struct inode *dir, struct dent=
ry *dentry,
 	mark_inode_dirty(inode);
 	up_write(&iinfo->i_data_sem);
=20
-	fi =3D udf_add_entry(dir, dentry, &fibh, &cfi, &err);
-	if (!fi)
-		goto out_no_entry;
-	cfi.icb.extLength =3D cpu_to_le32(sb->s_blocksize);
-	cfi.icb.extLocation =3D cpu_to_lelb(iinfo->i_location);
-	if (UDF_SB(inode->i_sb)->s_lvid_bh) {
-		*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =3D
-			cpu_to_le32(lvid_get_unique_id(sb));
-	}
-	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
-	if (UDF_I(dir)->i_alloc_type =3D=3D ICBTAG_FLAG_AD_IN_ICB)
-		mark_inode_dirty(dir);
-	if (fibh.sbh !=3D fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-	d_instantiate(dentry, inode);
-	err =3D 0;
-
+	err =3D udf_add_nondir(dentry, inode);
 out:
 	kfree(name);
 	return err;
@@ -1038,6 +1003,7 @@ static int udf_symlink(struct inode *dir, struct dent=
ry *dentry,
 out_no_entry:
 	up_write(&iinfo->i_data_sem);
 	inode_dec_link_count(inode);
+	unlock_new_inode(inode);
 	iput(inode);
 	goto out;
 }
diff --git a/fs/ufs/ialloc.c b/fs/ufs/ialloc.c
index 758ab7c305a4..fd0203ce1f7f 100644
--- a/fs/ufs/ialloc.c
+++ b/fs/ufs/ialloc.c
@@ -298,7 +298,10 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t=
 mode)
 	ufsi->i_oeftflag =3D 0;
 	ufsi->i_dir_start_lookup =3D 0;
 	memset(&ufsi->i_u1, 0, sizeof(ufsi->i_u1));
-	insert_inode_hash(inode);
+	if (insert_inode_locked(inode) < 0) {
+		err =3D -EIO;
+		goto failed;
+	}
 	mark_inode_dirty(inode);
=20
 	if (uspi->fs_magic =3D=3D UFS2_MAGIC) {
@@ -337,6 +340,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t =
mode)
 fail_remove_inode:
 	mutex_unlock(&sbi->s_lock);
 	clear_nlink(inode);
+	unlock_new_inode(inode);
 	iput(inode);
 	UFSD("EXIT (FAILED): err %d\n", err);
 	return ERR_PTR(err);
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 90d74b8f8eba..2f446e79de9f 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -38,10 +38,11 @@ static inline int ufs_add_nondir(struct dentry *dentry,=
 struct inode *inode)
 {
 	int err =3D ufs_add_link(dentry, inode);
 	if (!err) {
-		d_instantiate(dentry, inode);
+		d_instantiate_new(dentry, inode);
 		return 0;
 	}
 	inode_dec_link_count(inode);
+	unlock_new_inode(inode);
 	iput(inode);
 	return err;
 }
@@ -155,6 +156,7 @@ static int ufs_symlink (struct inode * dir, struct dent=
ry * dentry,
=20
 out_fail:
 	inode_dec_link_count(inode);
+	unlock_new_inode(inode);
 	iput(inode);
 	goto out;
 }
@@ -171,7 +173,12 @@ static int ufs_link (struct dentry * old_dentry, struc=
t inode * dir,
 	inode_inc_link_count(inode);
 	ihold(inode);
=20
-	error =3D ufs_add_nondir(dentry, inode);
+	error =3D ufs_add_link(dentry, inode);
+	if (error) {
+		inode_dec_link_count(inode);
+		iput(inode);
+	} else
+		d_instantiate(dentry, inode);
 	unlock_ufs(dir->i_sb);
 	return error;
 }
@@ -204,13 +211,14 @@ static int ufs_mkdir(struct inode * dir, struct dentr=
y * dentry, umode_t mode)
 		goto out_fail;
 	unlock_ufs(dir->i_sb);
=20
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 out:
 	return err;
=20
 out_fail:
 	inode_dec_link_count(inode);
 	inode_dec_link_count(inode);
+	unlock_new_inode(inode);
 	iput (inode);
 out_dir:
 	inode_dec_link_count(dir);
diff --git a/include/asm-generic/word-at-a-time.h b/include/asm-generic/wor=
d-at-a-time.h
index 94f9ea8abcae..011dde083f23 100644
--- a/include/asm-generic/word-at-a-time.h
+++ b/include/asm-generic/word-at-a-time.h
@@ -1,15 +1,10 @@
 #ifndef _ASM_WORD_AT_A_TIME_H
 #define _ASM_WORD_AT_A_TIME_H
=20
-/*
- * This says "generic", but it's actually big-endian only.
- * Little-endian can use more efficient versions of these
- * interfaces, see for example
- *	 arch/x86/include/asm/word-at-a-time.h
- * for those.
- */
-
 #include <linux/kernel.h>
+#include <asm/byteorder.h>
+
+#ifdef __BIG_ENDIAN
=20
 struct word_at_a_time {
 	const unsigned long high_bits, low_bits;
@@ -53,4 +48,73 @@ static inline bool has_zero(unsigned long val, unsigned =
long *data, const struct
 #define zero_bytemask(mask) (~1ul << __fls(mask))
 #endif
=20
+#else
+
+/*
+ * The optimal byte mask counting is probably going to be something
+ * that is architecture-specific. If you have a reliably fast
+ * bit count instruction, that might be better than the multiply
+ * and shift, for example.
+ */
+struct word_at_a_time {
+	const unsigned long one_bits, high_bits;
+};
+
+#define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }
+
+#ifdef CONFIG_64BIT
+
+/*
+ * Jan Achrenius on G+: microoptimized version of
+ * the simpler "(mask & ONEBYTES) * ONEBYTES >> 56"
+ * that works for the bytemasks without having to
+ * mask them first.
+ */
+static inline long count_masked_bytes(unsigned long mask)
+{
+	return mask*0x0001020304050608ul >> 56;
+}
+
+#else	/* 32-bit case */
+
+/* Carl Chatfield / Jan Achrenius G+ version for 32-bit */
+static inline long count_masked_bytes(long mask)
+{
+	/* (000000 0000ff 00ffff ffffff) -> ( 1 1 2 3 ) */
+	long a =3D (0x0ff0001+mask) >> 23;
+	/* Fix the 1 for 00 case */
+	return a & mask;
+}
+
+#endif
+
+/* Return nonzero if it has a zero */
+static inline unsigned long has_zero(unsigned long a, unsigned long *bits,=
 const struct word_at_a_time *c)
+{
+	unsigned long mask =3D ((a - c->one_bits) & ~a) & c->high_bits;
+	*bits =3D mask;
+	return mask;
+}
+
+static inline unsigned long prep_zero_mask(unsigned long a, unsigned long =
bits, const struct word_at_a_time *c)
+{
+	return bits;
+}
+
+static inline unsigned long create_zero_mask(unsigned long bits)
+{
+	bits =3D (bits - 1) & ~bits;
+	return bits >> 7;
+}
+
+/* The mask we created is directly usable as a bytemask */
+#define zero_bytemask(mask) (mask)
+
+static inline unsigned long find_zero(unsigned long mask)
+{
+	return count_masked_bytes(mask);
+}
+
+#endif /* __BIG_ENDIAN */
+
 #endif /* _ASM_WORD_AT_A_TIME_H */
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index a4ebe5b78e74..069bf4b0fcb1 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -356,8 +356,9 @@ struct clk *clk_register_divider_table(struct device *d=
ev, const char *name,
  *
  * @hw:		handle between common and hardware-specific interfaces
  * @reg:	register controlling multiplexer
+ * @table:	array of register values corresponding to the parent index
  * @shift:	shift to multiplexer bit field
- * @width:	width of mutliplexer bit field
+ * @mask:	mask of mutliplexer bit field
  * @flags:	hardware-specific flags
  * @lock:	register lock
  *
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index aa586fb8ee1a..de26c9463a5f 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -234,6 +234,7 @@ static inline int dname_external(const struct dentry *d=
entry)
  * These are the low-level FS interfaces to the dcache..
  */
 extern void d_instantiate(struct dentry *, struct inode *);
+extern void d_instantiate_new(struct dentry *, struct inode *);
 extern struct dentry * d_instantiate_unique(struct dentry *, struct inode =
*);
 extern struct dentry * d_materialise_unique(struct dentry *, struct inode =
*);
 extern int d_instantiate_no_diralias(struct dentry *, struct inode *);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 1431089c54dc..fac828d0de08 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -368,8 +368,8 @@ typedef struct {
 	u32 attributes;
 	u32 get_bar_attributes;
 	u32 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u32 romimage;
 } efi_pci_io_protocol_32;
=20
 typedef struct {
@@ -388,8 +388,8 @@ typedef struct {
 	u64 attributes;
 	u64 get_bar_attributes;
 	u64 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u64 romimage;
 } efi_pci_io_protocol_64;
=20
 typedef struct {
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 05eb71003b52..690aa85276fb 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -757,7 +757,7 @@ extern int hidinput_connect(struct hid_device *hid, uns=
igned int force);
 extern void hidinput_disconnect(struct hid_device *);
=20
 int hid_set_field(struct hid_field *, unsigned, __s32);
-int hid_input_report(struct hid_device *, int type, u8 *, int, int);
+int hid_input_report(struct hid_device *, int type, u8 *, u32, int);
 int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigne=
d int code, struct hid_field **field);
 struct hid_field *hidinput_get_led_field(struct hid_device *hid);
 unsigned int hidinput_count_leds(struct hid_device *hid);
@@ -1055,7 +1055,7 @@ static inline void hid_hw_wait(struct hid_device *hde=
v)
 		hdev->ll_driver->wait(hdev);
 }
=20
-int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int s=
ize,
+int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 s=
ize,
 		int interrupt);
=20
 /* HID quirks API */
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 519392763393..04e9bb96a5d5 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -52,7 +52,7 @@ struct iio_buffer_access_funcs {
 	int (*get_bytes_per_datum)(struct iio_buffer *buffer);
 	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
 	int (*get_length)(struct iio_buffer *buffer);
-	int (*set_length)(struct iio_buffer *buffer, int length);
+	int (*set_length)(struct iio_buffer *buffer, unsigned int length);
=20
 	void (*release)(struct iio_buffer *buffer);
 };
@@ -78,8 +78,8 @@ struct iio_buffer_access_funcs {
  * @ref:		[INTERN] reference count of the buffer.
  */
 struct iio_buffer {
-	int					length;
-	int					bytes_per_datum;
+	unsigned int				length;
+	size_t					bytes_per_datum;
 	struct attribute_group			*scan_el_attrs;
 	long					*scan_mask;
 	bool					scan_timestamp;
diff --git a/include/linux/log2.h b/include/linux/log2.h
index fd7ff3d91e6a..f38fae23bdac 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -15,12 +15,6 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
=20
-/*
- * deal with unrepresentable constant logarithms
- */
-extern __attribute__((const, noreturn))
-int ____ilog2_NaN(void);
-
 /*
  * non-constant log of base 2 calculators
  * - the arch may override these in asm/bitops.h if they can be implemented
@@ -85,7 +79,7 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 #define ilog2(n)				\
 (						\
 	__builtin_constant_p(n) ? (		\
-		(n) < 1 ? ____ilog2_NaN() :	\
+		(n) < 2 ? 0 :			\
 		(n) & (1ULL << 63) ? 63 :	\
 		(n) & (1ULL << 62) ? 62 :	\
 		(n) & (1ULL << 61) ? 61 :	\
@@ -148,10 +142,7 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 		(n) & (1ULL <<  4) ?  4 :	\
 		(n) & (1ULL <<  3) ?  3 :	\
 		(n) & (1ULL <<  2) ?  2 :	\
-		(n) & (1ULL <<  1) ?  1 :	\
-		(n) & (1ULL <<  0) ?  0 :	\
-		____ilog2_NaN()			\
-				   ) :		\
+		1 ) :				\
 	(sizeof(n) <=3D 4) ?			\
 	__ilog2_u32(n) :			\
 	__ilog2_u64(n)				\
diff --git a/include/linux/msg.h b/include/linux/msg.h
index f3f302f9c197..7f9ea9104535 100644
--- a/include/linux/msg.h
+++ b/include/linux/msg.h
@@ -23,8 +23,8 @@ struct msg_queue {
 	unsigned long q_cbytes;		/* current number of bytes on queue */
 	unsigned long q_qnum;		/* number of messages in queue */
 	unsigned long q_qbytes;		/* max number of bytes on queue */
-	pid_t q_lspid;			/* pid of last msgsnd */
-	pid_t q_lrpid;			/* last receive pid */
+	struct pid *q_lspid;		/* pid of last msgsnd */
+	struct pid *q_lrpid;		/* last receive pid */
=20
 	struct list_head q_messages;
 	struct list_head q_receivers;
diff --git a/include/linux/mtd/flashchip.h b/include/linux/mtd/flashchip.h
index b63fa457febd..3529683f691e 100644
--- a/include/linux/mtd/flashchip.h
+++ b/include/linux/mtd/flashchip.h
@@ -85,6 +85,7 @@ struct flchip {
 	unsigned int write_suspended:1;
 	unsigned int erase_suspended:1;
 	unsigned long in_progress_block_addr;
+	unsigned long in_progress_block_mask;
=20
 	struct mutex mutex;
 	wait_queue_head_t wq; /* Wait on here when we're waiting for the chip
diff --git a/include/linux/shm.h b/include/linux/shm.h
index 57d77709fbe2..559033e5b9f5 100644
--- a/include/linux/shm.h
+++ b/include/linux/shm.h
@@ -14,8 +14,8 @@ struct shmid_kernel /* private to the kernel */
 	time_t			shm_atim;
 	time_t			shm_dtim;
 	time_t			shm_ctim;
-	pid_t			shm_cprid;
-	pid_t			shm_lprid;
+	struct pid		*shm_cprid;
+	struct pid		*shm_lprid;
 	struct user_struct	*mlock_user;
=20
 	/* The task created the shm object.  NULL if the task is dead. */
diff --git a/include/linux/string.h b/include/linux/string.h
index 3b42b3732da6..54c9b66f1c29 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -25,6 +25,9 @@ extern char * strncpy(char *,const char *, __kernel_size_=
t);
 #ifndef __HAVE_ARCH_STRLCPY
 size_t strlcpy(char *, const char *, size_t);
 #endif
+#ifndef __HAVE_ARCH_STRSCPY
+ssize_t __must_check strscpy(char *, const char *, size_t);
+#endif
 #ifndef __HAVE_ARCH_STRCAT
 extern char * strcat(char *, const char *);
 #endif
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1d02392fa3bd..38394e5a242b 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -477,13 +477,11 @@ extern int tty_mode_ioctl(struct tty_struct *tty, str=
uct file *file,
 			unsigned int cmd, unsigned long arg);
 extern int tty_perform_flush(struct tty_struct *tty, unsigned long arg);
 extern void tty_default_fops(struct file_operations *fops);
-extern struct tty_struct *alloc_tty_struct(void);
+extern struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int =
idx);
 extern int tty_alloc_file(struct file *file);
 extern void tty_add_file(struct tty_struct *tty, struct file *file);
 extern void tty_free_file(struct file *file);
 extern void free_tty_struct(struct tty_struct *tty);
-extern void initialize_tty_struct(struct tty_struct *tty,
-		struct tty_driver *driver, int idx);
 extern void deinitialize_tty_struct(struct tty_struct *tty);
 extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
 extern int tty_release(struct inode *inode, struct file *filp);
@@ -558,7 +556,7 @@ extern int tty_unregister_ldisc(int disc);
 extern int tty_set_ldisc(struct tty_struct *tty, int ldisc);
 extern int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tt=
y);
 extern void tty_ldisc_release(struct tty_struct *tty, struct tty_struct *o=
_tty);
-extern void tty_ldisc_init(struct tty_struct *tty);
+extern int __must_check tty_ldisc_init(struct tty_struct *tty);
 extern void tty_ldisc_deinit(struct tty_struct *tty);
 extern void tty_ldisc_begin(void);
=20
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b46671e28de2..ba845ff92e12 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -108,6 +108,9 @@ void unregister_virtio_device(struct virtio_device *dev=
);
=20
 void virtio_break_device(struct virtio_device *dev);
=20
+#define virtio_device_for_each_vq(vdev, vq) \
+	list_for_each_entry(vq, &vdev->vqs, list)
+
 /**
  * virtio_driver - operations for a virtio I/O driver
  * @driver: underlying device driver (populate name and owner).
diff --git a/include/net/dst.h b/include/net/dst.h
index 673e69d1d7be..707c95b3d184 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -350,6 +350,7 @@ static inline void __skb_tunnel_rx(struct sk_buff *skb,=
 struct net_device *dev,
  *	skb_tunnel_rx - prepare skb for rx reinsert
  *	@skb: buffer
  *	@dev: tunnel device
+ *	@net: netns for packet i/o
  *
  *	After decapsulation, packet is going to re-enter (netif_rx()) our stack,
  *	so make some cleanups, and perform accounting.
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_s=
ock.h
index 61474ea02152..d85cfb5dcef9 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -108,6 +108,7 @@ struct inet_timewait_sock {
 #define tw_family		__tw_common.skc_family
 #define tw_state		__tw_common.skc_state
 #define tw_reuse		__tw_common.skc_reuse
+#define tw_reuseport		__tw_common.skc_reuseport
 #define tw_bound_dev_if		__tw_common.skc_bound_dev_if
 #define tw_node			__tw_common.skc_nulls_node
 #define tw_bind_node		__tw_common.skc_bind_node
diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 3334dbfa5aa4..7fc78663ec9d 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -6,7 +6,7 @@
=20
 static inline int rtnh_ok(const struct rtnexthop *rtnh, int remaining)
 {
-	return remaining >=3D sizeof(*rtnh) &&
+	return remaining >=3D (int)sizeof(*rtnh) &&
 	       rtnh->rtnh_len >=3D sizeof(*rtnh) &&
 	       rtnh->rtnh_len <=3D remaining;
 }
diff --git a/include/rdma/ib_addr.h b/include/rdma/ib_addr.h
index bc45acc195b1..858df4feec0f 100644
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -109,6 +109,8 @@ int rdma_copy_addr(struct rdma_dev_addr *dev_addr, stru=
ct net_device *dev,
 	      const unsigned char *dst_dev_addr);
=20
 int rdma_addr_size(struct sockaddr *addr);
+int rdma_addr_size_in6(struct sockaddr_in6 *addr);
+int rdma_addr_size_kss(struct __kernel_sockaddr_storage *addr);
=20
 int rdma_addr_find_smac_by_sgid(union ib_gid *sgid, u8 *smac, u16 *vlan_id=
);
 int rdma_addr_find_dmac_by_grh(union ib_gid *sgid, union ib_gid *dgid, u8 =
*smac,
diff --git a/include/sound/control.h b/include/sound/control.h
index 5358892b1b39..2d1f2c14ebec 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -22,6 +22,7 @@
  *
  */
=20
+#include <linux/nospec.h>
 #include <sound/asound.h>
=20
 #define snd_kcontrol_chip(kcontrol) ((kcontrol)->private_data)
@@ -135,12 +136,14 @@ int snd_ctl_unregister_ioctl_compat(snd_kctl_ioctl_fu=
nc_t fcn);
=20
 static inline unsigned int snd_ctl_get_ioffnum(struct snd_kcontrol *kctl, =
struct snd_ctl_elem_id *id)
 {
-	return id->numid - kctl->id.numid;
+	unsigned int ioff =3D id->numid - kctl->id.numid;
+	return array_index_nospec(ioff, kctl->count);
 }
=20
 static inline unsigned int snd_ctl_get_ioffidx(struct snd_kcontrol *kctl, =
struct snd_ctl_elem_id *id)
 {
-	return id->index - kctl->id.index;
+	unsigned int ioff =3D id->index - kctl->id.index;
+	return array_index_nospec(ioff, kctl->count);
 }
=20
 static inline unsigned int snd_ctl_get_ioff(struct snd_kcontrol *kctl, str=
uct snd_ctl_elem_id *id)
diff --git a/include/sound/pcm_oss.h b/include/sound/pcm_oss.h
index 760c969d885d..12bbf8c81112 100644
--- a/include/sound/pcm_oss.h
+++ b/include/sound/pcm_oss.h
@@ -57,6 +57,7 @@ struct snd_pcm_oss_runtime {
 	char *buffer;				/* vmallocated period */
 	size_t buffer_used;			/* used length from period buffer */
 	struct mutex params_lock;
+	atomic_t rw_ref;		/* concurrent read/write accesses */
 #ifdef CONFIG_SND_PCM_OSS_PLUGINS
 	struct snd_pcm_plugin *plugin_first;
 	struct snd_pcm_plugin *plugin_last;
diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index d06b6da5c1e3..79c42ed1bcb5 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -377,22 +377,6 @@ DECLARE_EVENT_CLASS(xen_mmu_pgd,
 DEFINE_XEN_MMU_PGD_EVENT(xen_mmu_pgd_pin);
 DEFINE_XEN_MMU_PGD_EVENT(xen_mmu_pgd_unpin);
=20
-TRACE_EVENT(xen_mmu_flush_tlb_all,
-	    TP_PROTO(int x),
-	    TP_ARGS(x),
-	    TP_STRUCT__entry(__array(char, x, 0)),
-	    TP_fast_assign((void)x),
-	    TP_printk("%s", "")
-	);
-
-TRACE_EVENT(xen_mmu_flush_tlb,
-	    TP_PROTO(int x),
-	    TP_ARGS(x),
-	    TP_STRUCT__entry(__array(char, x, 0)),
-	    TP_fast_assign((void)x),
-	    TP_printk("%s", "")
-	);
-
 TRACE_EVENT(xen_mmu_flush_tlb_single,
 	    TP_PROTO(unsigned long addr),
 	    TP_ARGS(addr),
diff --git a/include/uapi/linux/ppp-ioctl.h b/include/uapi/linux/ppp-ioctl.h
index 63a23a3b8bb7..c71599145824 100644
--- a/include/uapi/linux/ppp-ioctl.h
+++ b/include/uapi/linux/ppp-ioctl.h
@@ -105,7 +105,7 @@ struct pppol2tp_ioc_stats {
 #define PPPIOCGIDLE	_IOR('t', 63, struct ppp_idle) /* get idle time */
 #define PPPIOCNEWUNIT	_IOWR('t', 62, int)	/* create new ppp unit */
 #define PPPIOCATTACH	_IOW('t', 61, int)	/* attach to ppp unit */
-#define PPPIOCDETACH	_IOW('t', 60, int)	/* detach from ppp unit/chan */
+#define PPPIOCDETACH	_IOW('t', 60, int)	/* obsolete, do not use */
 #define PPPIOCSMRRU	_IOW('t', 59, int)	/* set multilink MRU */
 #define PPPIOCCONNECT	_IOW('t', 58, int)	/* connect channel to unit */
 #define PPPIOCDISCONN	_IO('t', 57)		/* disconnect channel */
diff --git a/include/uapi/linux/tty.h b/include/uapi/linux/tty.h
index dac199a2dba5..512892743489 100644
--- a/include/uapi/linux/tty.h
+++ b/include/uapi/linux/tty.h
@@ -34,5 +34,6 @@
 #define N_TI_WL		22	/* for TI's WL BT, FM, GPS combo chips */
 #define N_TRACESINK	23	/* Trace data routing for MIPI P1149.7 */
 #define N_TRACEROUTER	24	/* Trace data routing for MIPI P1149.7 */
+#define N_NULL		27	/* Null ldisc used for error handling */
=20
 #endif /* _UAPI_LINUX_TTY_H */
diff --git a/ipc/msg.c b/ipc/msg.c
index c804e11bcbf6..813076a6a053 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -141,7 +141,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_=
params *params)
 	msq->q_ctime =3D get_seconds();
 	msq->q_cbytes =3D msq->q_qnum =3D 0;
 	msq->q_qbytes =3D ns->msg_ctlmnb;
-	msq->q_lspid =3D msq->q_lrpid =3D 0;
+	msq->q_lspid =3D msq->q_lrpid =3D NULL;
 	INIT_LIST_HEAD(&msq->q_messages);
 	INIT_LIST_HEAD(&msq->q_receivers);
 	INIT_LIST_HEAD(&msq->q_senders);
@@ -225,6 +225,8 @@ static void freeque(struct ipc_namespace *ns, struct ke=
rn_ipc_perm *ipcp)
 		free_msg(msg);
 	}
 	atomic_sub(msq->q_cbytes, &ns->msg_bytes);
+	ipc_update_pid(&msq->q_lspid, NULL);
+	ipc_update_pid(&msq->q_lrpid, NULL);
 	ipc_rcu_putref(msq, msg_rcu_free);
 }
=20
@@ -500,8 +502,8 @@ static int msgctl_nolock(struct ipc_namespace *ns, int =
msqid,
 		tbuf.msg_cbytes =3D msq->q_cbytes;
 		tbuf.msg_qnum   =3D msq->q_qnum;
 		tbuf.msg_qbytes =3D msq->q_qbytes;
-		tbuf.msg_lspid  =3D msq->q_lspid;
-		tbuf.msg_lrpid  =3D msq->q_lrpid;
+		tbuf.msg_lspid  =3D pid_vnr(msq->q_lspid);
+		tbuf.msg_lrpid  =3D pid_vnr(msq->q_lrpid);
 		rcu_read_unlock();
=20
 		if (copy_msqid_to_user(buf, &tbuf, version))
@@ -584,7 +586,7 @@ static inline int pipelined_send(struct msg_queue *msq,=
 struct msg_msg *msg)
 				msr->r_msg =3D ERR_PTR(-E2BIG);
 			} else {
 				msr->r_msg =3D NULL;
-				msq->q_lrpid =3D task_pid_vnr(msr->r_tsk);
+				ipc_update_pid(&msq->q_lrpid, task_pid(msr->r_tsk));
 				msq->q_rtime =3D get_seconds();
 				wake_up_process(msr->r_tsk);
 				/*
@@ -693,7 +695,7 @@ long do_msgsnd(int msqid, long mtype, void __user *mtex=
t,
 		}
=20
 	}
-	msq->q_lspid =3D task_tgid_vnr(current);
+	ipc_update_pid(&msq->q_lspid, task_tgid(current));
 	msq->q_stime =3D get_seconds();
=20
 	if (!pipelined_send(msq, msg)) {
@@ -887,7 +889,7 @@ long do_msgrcv(int msqid, void __user *buf, size_t bufs=
z, long msgtyp, int msgfl
 			list_del(&msg->m_list);
 			msq->q_qnum--;
 			msq->q_rtime =3D get_seconds();
-			msq->q_lrpid =3D task_tgid_vnr(current);
+			ipc_update_pid(&msq->q_lrpid, task_tgid(current));
 			msq->q_cbytes -=3D msg->m_ts;
 			atomic_sub(msg->m_ts, &ns->msg_bytes);
 			atomic_dec(&ns->msg_hdrs);
@@ -1043,6 +1045,7 @@ void msg_exit_ns(struct ipc_namespace *ns)
 #ifdef CONFIG_PROC_FS
 static int sysvipc_msg_proc_show(struct seq_file *s, void *it)
 {
+	struct pid_namespace *pid_ns =3D ipc_seq_pid_ns(s);
 	struct user_namespace *user_ns =3D seq_user_ns(s);
 	struct msg_queue *msq =3D it;
=20
@@ -1053,8 +1056,8 @@ static int sysvipc_msg_proc_show(struct seq_file *s, =
void *it)
 		   msq->q_perm.mode,
 		   msq->q_cbytes,
 		   msq->q_qnum,
-		   msq->q_lspid,
-		   msq->q_lrpid,
+		   pid_nr_ns(msq->q_lspid, pid_ns),
+		   pid_nr_ns(msq->q_lrpid, pid_ns),
 		   from_kuid_munged(user_ns, msq->q_perm.uid),
 		   from_kgid_munged(user_ns, msq->q_perm.gid),
 		   from_kuid_munged(user_ns, msq->q_perm.cuid),
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index 7e7095974d54..d86417fc2160 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -120,7 +120,7 @@ struct msg_msg *copy_msg(struct msg_msg *src, struct ms=
g_msg *dst)
 	size_t len =3D src->m_ts;
 	size_t alen;
=20
-	BUG_ON(dst =3D=3D NULL);
+	WARN_ON(dst =3D=3D NULL);
 	if (src->m_ts > dst->m_ts)
 		return ERR_PTR(-EINVAL);
=20
diff --git a/ipc/sem.c b/ipc/sem.c
index e289fa838a20..f78977354ba4 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -92,7 +92,14 @@
 /* One semaphore structure for each semaphore in the system. */
 struct sem {
 	int	semval;		/* current value */
-	int	sempid;		/* pid of last operation */
+	/*
+	 * PID of the process that last modified the semaphore. For
+	 * Linux, specifically these are:
+	 *  - semop
+	 *  - semctl, via SETVAL and SETALL.
+	 *  - at task exit when performing undo adjustments (see exit_sem).
+	 */
+	struct pid *sempid;
 	spinlock_t	lock;	/* spinlock for fine-grained semtimedop */
 	struct list_head pending_alter; /* pending single-sop operations */
 					/* that alter the semaphore */
@@ -106,7 +113,8 @@ struct sem_queue {
 	struct list_head	list;	 /* queue of pending operations */
 	struct task_struct	*sleeper; /* this process */
 	struct sem_undo		*undo;	 /* undo structure */
-	int			pid;	 /* process id of requesting process */
+	struct pid		*pid;	 /* process id of requesting process */
+	int			wake_error;
 	int			status;	 /* completion status of operation */
 	struct sembuf		*sops;	 /* array of pending operations */
 	struct sembuf		*blocking; /* the operation that blocked */
@@ -637,7 +645,8 @@ SYSCALL_DEFINE3(semget, key_t, key, int, nsems, int, se=
mflg)
  */
 static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
 {
-	int result, sem_op, nsops, pid;
+	int result, sem_op, nsops;
+	struct pid *pid;
 	struct sembuf *sop;
 	struct sem *curr;
 	struct sembuf *sops;
@@ -675,7 +684,7 @@ static int perform_atomic_semop(struct sem_array *sma, =
struct sem_queue *q)
 	sop--;
 	pid =3D q->pid;
 	while (sop >=3D sops) {
-		sma->sem_base[sop->sem_num].sempid =3D pid;
+		ipc_update_pid(&sma->sem_base[sop->sem_num].sempid, pid);
 		sop--;
 	}
=20
@@ -723,7 +732,7 @@ static void wake_up_sem_queue_prepare(struct list_head =
*pt,
 		preempt_disable();
 	}
 	q->status =3D IN_WAKEUP;
-	q->pid =3D error;
+	q->wake_error =3D error;
=20
 	list_add_tail(&q->list, pt);
 }
@@ -747,7 +756,7 @@ static void wake_up_sem_queue_do(struct list_head *pt)
 		wake_up_process(q->sleeper);
 		/* q can disappear immediately after writing q->status. */
 		smp_wmb();
-		q->status =3D q->pid;
+		q->status =3D q->wake_error;
 	}
 	if (did_something)
 		preempt_enable();
@@ -805,7 +814,7 @@ static int check_restart(struct sem_array *sma, struct =
sem_queue *q)
  * be called with semnum =3D -1, as well as with the number of each modifi=
ed
  * semaphore.
  * The tasks that must be woken up are added to @pt. The return code
- * is stored in q->pid.
+ * is stored in q->wake_error.
  * The function returns 1 if at least one operation was completed successf=
ully.
  */
 static int wake_const_ops(struct sem_array *sma, int semnum,
@@ -905,7 +914,7 @@ static int do_smart_wakeup_zero(struct sem_array *sma, =
struct sembuf *sops,
  * be called with semnum =3D -1, as well as with the number of each modifi=
ed
  * semaphore.
  * The tasks that must be woken up are added to @pt. The return code
- * is stored in q->pid.
+ * is stored in q->wake_error.
  * The function internally checks if const operations can now succeed.
  *
  * The function return 1 if at least one semop was completed successfully.
@@ -1149,6 +1158,7 @@ static void freeary(struct ipc_namespace *ns, struct =
kern_ipc_perm *ipcp)
 			unlink_queue(sma, q);
 			wake_up_sem_queue_prepare(&tasks, q, -EIDRM);
 		}
+		ipc_update_pid(&sem->sempid, NULL);
 	}
=20
 	/* Remove the semaphore set from the IDR */
@@ -1350,7 +1360,7 @@ static int semctl_setval(struct ipc_namespace *ns, in=
t semid, int semnum,
 		un->semadj[semnum] =3D 0;
=20
 	curr->semval =3D val;
-	curr->sempid =3D task_tgid_vnr(current);
+	ipc_update_pid(&curr->sempid, task_tgid(current));
 	sma->sem_ctime =3D get_seconds();
 	/* maybe some queued-up processes were waiting for this */
 	do_smart_update(sma, NULL, 0, 0, &tasks);
@@ -1469,8 +1479,10 @@ static int semctl_main(struct ipc_namespace *ns, int=
 semid, int semnum,
 			goto out_unlock;
 		}
=20
-		for (i =3D 0; i < nsems; i++)
+		for (i =3D 0; i < nsems; i++) {
 			sma->sem_base[i].semval =3D sem_io[i];
+			ipc_update_pid(&sma->sem_base[i].sempid, task_tgid(current));
+		}
=20
 		ipc_assert_locked_object(&sma->sem_perm);
 		list_for_each_entry(un, &sma->list_id, list_id) {
@@ -1501,7 +1513,7 @@ static int semctl_main(struct ipc_namespace *ns, int =
semid, int semnum,
 		err =3D curr->semval;
 		goto out_unlock;
 	case GETPID:
-		err =3D curr->sempid;
+		err =3D pid_vnr(curr->sempid);
 		goto out_unlock;
 	case GETNCNT:
 		err =3D count_semcnt(sma, semnum, 0);
@@ -1924,7 +1936,7 @@ SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf=
 __user *, tsops,
 	queue.sops =3D sops;
 	queue.nsops =3D nsops;
 	queue.undo =3D un;
-	queue.pid =3D task_tgid_vnr(current);
+	queue.pid =3D task_tgid(current);
 	queue.alter =3D alter;
=20
 	error =3D perform_atomic_semop(sma, &queue);
@@ -2184,7 +2196,7 @@ void exit_sem(struct task_struct *tsk)
 					semaphore->semval =3D 0;
 				if (semaphore->semval > SEMVMX)
 					semaphore->semval =3D SEMVMX;
-				semaphore->sempid =3D task_tgid_vnr(current);
+				ipc_update_pid(&semaphore->sempid, task_tgid(current));
 			}
 		}
 		/* maybe some queued-up processes were waiting for this */
diff --git a/ipc/shm.c b/ipc/shm.c
index f8bb7b3fdd49..6d96289241a9 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -155,9 +155,13 @@ static inline struct shmid_kernel *shm_lock(struct ipc=
_namespace *ns, int id)
 {
 	struct kern_ipc_perm *ipcp =3D ipc_lock(&shm_ids(ns), id);
=20
+	/*
+	 * Callers of shm_lock() must validate the status of the returned ipc
+	 * object pointer (as returned by ipc_lock()), and error out as
+	 * appropriate.
+	 */
 	if (IS_ERR(ipcp))
-		return (struct shmid_kernel *)ipcp;
-
+		return (void *)ipcp;
 	return container_of(ipcp, struct shmid_kernel, shm_perm);
 }
=20
@@ -182,19 +186,39 @@ static inline void shm_rmid(struct ipc_namespace *ns,=
 struct shmid_kernel *s)
 }
=20
=20
-/* This is called by fork, once for every shm attach. */
-static void shm_open(struct vm_area_struct *vma)
+static int __shm_open(struct vm_area_struct *vma)
 {
 	struct file *file =3D vma->vm_file;
 	struct shm_file_data *sfd =3D shm_file_data(file);
 	struct shmid_kernel *shp;
=20
 	shp =3D shm_lock(sfd->ns, sfd->id);
-	BUG_ON(IS_ERR(shp));
+
+	if (IS_ERR(shp))
+		return PTR_ERR(shp);
+
+	if (shp->shm_file !=3D sfd->file) {
+		/* ID was reused */
+		shm_unlock(shp);
+		return -EINVAL;
+	}
+
 	shp->shm_atim =3D get_seconds();
-	shp->shm_lprid =3D task_tgid_vnr(current);
+	ipc_update_pid(&shp->shm_lprid, task_tgid(current));
 	shp->shm_nattch++;
 	shm_unlock(shp);
+	return 0;
+}
+
+/* This is called by fork, once for every shm attach. */
+static void shm_open(struct vm_area_struct *vma)
+{
+	int err =3D __shm_open(vma);
+	/*
+	 * We raced in the idr lookup or with shm_destroy().
+	 * Either way, the ID is busted.
+	 */
+	WARN_ON_ONCE(err);
 }
=20
 /*
@@ -220,6 +244,8 @@ static void shm_destroy(struct ipc_namespace *ns, struc=
t shmid_kernel *shp)
 	else if (shp->mlock_user)
 		user_shm_unlock(file_inode(shm_file)->i_size, shp->mlock_user);
 	fput(shm_file);
+	ipc_update_pid(&shp->shm_cprid, NULL);
+	ipc_update_pid(&shp->shm_lprid, NULL);
 	ipc_rcu_putref(shp, shm_rcu_free);
 }
=20
@@ -256,14 +282,22 @@ static void shm_close(struct vm_area_struct *vma)
 	down_write(&shm_ids(ns).rwsem);
 	/* remove from the list of attaches of the shm segment */
 	shp =3D shm_lock(ns, sfd->id);
-	BUG_ON(IS_ERR(shp));
-	shp->shm_lprid =3D task_tgid_vnr(current);
+
+	/*
+	 * We raced in the idr lookup or with shm_destroy().
+	 * Either way, the ID is busted.
+	 */
+	if (WARN_ON_ONCE(IS_ERR(shp)))
+		goto done; /* no-op */
+
+	ipc_update_pid(&shp->shm_lprid, task_tgid(current));
 	shp->shm_dtim =3D get_seconds();
 	shp->shm_nattch--;
 	if (shm_may_destroy(ns, shp))
 		shm_destroy(ns, shp);
 	else
 		shm_unlock(shp);
+done:
 	up_write(&shm_ids(ns).rwsem);
 }
=20
@@ -384,17 +418,26 @@ static int shm_mmap(struct file *file, struct vm_area=
_struct *vma)
 	struct shm_file_data *sfd =3D shm_file_data(file);
 	int ret;
=20
+	/*
+	 * In case of remap_file_pages() emulation, the file can represent an
+	 * IPC ID that was removed, and possibly even reused by another shm
+	 * segment already.  Propagate this case as an error to caller.
+	 */
+	ret =3D__shm_open(vma);
+	if (ret)
+		return ret;
+
 	ret =3D sfd->file->f_op->mmap(sfd->file, vma);
-	if (ret !=3D 0)
+	if (ret) {
+		shm_close(vma);
 		return ret;
+	}
 	sfd->vm_ops =3D vma->vm_ops;
 #ifdef CONFIG_MMU
-	BUG_ON(!sfd->vm_ops->fault);
+	WARN_ON(!sfd->vm_ops->fault);
 #endif
 	vma->vm_ops =3D &shm_vm_ops;
-	shm_open(vma);
-
-	return ret;
+	return 0;
 }
=20
 static int shm_release(struct inode *ino, struct file *file)
@@ -402,6 +445,7 @@ static int shm_release(struct inode *ino, struct file *=
file)
 	struct shm_file_data *sfd =3D shm_file_data(file);
=20
 	put_ipc_ns(sfd->ns);
+	fput(sfd->file);
 	shm_file_data(file) =3D NULL;
 	kfree(sfd);
 	return 0;
@@ -547,8 +591,8 @@ static int newseg(struct ipc_namespace *ns, struct ipc_=
params *params)
 	if (IS_ERR(file))
 		goto no_file;
=20
-	shp->shm_cprid =3D task_tgid_vnr(current);
-	shp->shm_lprid =3D 0;
+	shp->shm_cprid =3D get_pid(task_tgid(current));
+	shp->shm_lprid =3D NULL;
 	shp->shm_atim =3D shp->shm_dtim =3D 0;
 	shp->shm_ctim =3D get_seconds();
 	shp->shm_segsz =3D size;
@@ -580,6 +624,8 @@ static int newseg(struct ipc_namespace *ns, struct ipc_=
params *params)
 		user_shm_unlock(size, shp->mlock_user);
 	fput(file);
 no_file:
+	ipc_update_pid(&shp->shm_cprid, NULL);
+	ipc_update_pid(&shp->shm_lprid, NULL);
 	ipc_rcu_putref(shp, shm_rcu_free);
 	return error;
 }
@@ -918,8 +964,8 @@ static int shmctl_nolock(struct ipc_namespace *ns, int =
shmid,
 		tbuf.shm_atime	=3D shp->shm_atim;
 		tbuf.shm_dtime	=3D shp->shm_dtim;
 		tbuf.shm_ctime	=3D shp->shm_ctim;
-		tbuf.shm_cpid	=3D shp->shm_cprid;
-		tbuf.shm_lpid	=3D shp->shm_lprid;
+		tbuf.shm_cpid	=3D pid_vnr(shp->shm_cprid);
+		tbuf.shm_lpid	=3D pid_vnr(shp->shm_lprid);
 		tbuf.shm_nattch	=3D shp->shm_nattch;
 		rcu_read_unlock();
=20
@@ -1066,14 +1112,17 @@ long do_shmat(int shmid, char __user *shmaddr, int =
shmflg,
 		goto out;
 	else if ((addr =3D (ulong)shmaddr)) {
 		if (addr & (shmlba - 1)) {
-			/*
-			 * Round down to the nearest multiple of shmlba.
-			 * For sane do_mmap_pgoff() parameters, avoid
-			 * round downs that trigger nil-page and MAP_FIXED.
-			 */
-			if ((shmflg & SHM_RND) && addr >=3D shmlba)
-				addr &=3D ~(shmlba - 1);
-			else
+			if (shmflg & SHM_RND) {
+				addr &=3D ~(shmlba - 1);  /* round down */
+
+				/*
+				 * Ensure that the round-down is non-nil
+				 * when remapping. This can happen for
+				 * cases when addr < shmlba.
+				 */
+				if (!addr && (shmflg & SHM_REMAP))
+					goto out;
+			} else
 #ifndef __ARCH_FORCE_SHMLBA
 				if (addr & ~PAGE_MASK)
 #endif
@@ -1159,7 +1208,16 @@ long do_shmat(int shmid, char __user *shmaddr, int s=
hmflg,
 	file->f_mapping =3D shp->shm_file->f_mapping;
 	sfd->id =3D shp->shm_perm.id;
 	sfd->ns =3D get_ipc_ns(ns);
-	sfd->file =3D shp->shm_file;
+	/*
+	 * We need to take a reference to the real shm file to prevent the
+	 * pointer from becoming stale in cases where the lifetime of the outer
+	 * file extends beyond that of the shm segment.  It's not usually
+	 * possible, but it can happen during remap_file_pages() emulation as
+	 * that unmaps the memory, then does ->mmap() via file reference only.
+	 * We'll deny the ->mmap() if the shm segment was since removed, but to
+	 * detect shm ID reuse we need to compare the file pointers.
+	 */
+	sfd->file =3D get_file(shp->shm_file);
 	sfd->vm_ops =3D NULL;
=20
 	err =3D security_mmap_file(file, prot, flags);
@@ -1199,7 +1257,6 @@ long do_shmat(int shmid, char __user *shmaddr, int sh=
mflg,
 out_nattch:
 	down_write(&shm_ids(ns).rwsem);
 	shp =3D shm_lock(ns, shmid);
-	BUG_ON(IS_ERR(shp));
 	shp->shm_nattch--;
 	if (shm_may_destroy(ns, shp))
 		shm_destroy(ns, shp);
@@ -1330,6 +1387,7 @@ SYSCALL_DEFINE1(shmdt, char __user *, shmaddr)
 #ifdef CONFIG_PROC_FS
 static int sysvipc_shm_proc_show(struct seq_file *s, void *it)
 {
+	struct pid_namespace *pid_ns =3D ipc_seq_pid_ns(s);
 	struct user_namespace *user_ns =3D seq_user_ns(s);
 	struct shmid_kernel *shp =3D it;
 	unsigned long rss =3D 0, swp =3D 0;
@@ -1350,8 +1408,8 @@ static int sysvipc_shm_proc_show(struct seq_file *s, =
void *it)
 		   shp->shm_perm.id,
 		   shp->shm_perm.mode,
 		   shp->shm_segsz,
-		   shp->shm_cprid,
-		   shp->shm_lprid,
+		   pid_nr_ns(shp->shm_cprid, pid_ns),
+		   pid_nr_ns(shp->shm_lprid, pid_ns),
 		   shp->shm_nattch,
 		   from_kuid_munged(user_ns, shp->shm_perm.uid),
 		   from_kgid_munged(user_ns, shp->shm_perm.gid),
diff --git a/ipc/util.c b/ipc/util.c
index 8085966a1d74..36a066ff4881 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -777,9 +777,16 @@ int ipc_parse_version(int *cmd)
 #ifdef CONFIG_PROC_FS
 struct ipc_proc_iter {
 	struct ipc_namespace *ns;
+	struct pid_namespace *pid_ns;
 	struct ipc_proc_iface *iface;
 };
=20
+struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
+{
+	struct ipc_proc_iter *iter =3D s->private;
+	return iter->pid_ns;
+}
+
 /*
  * This routine locks the ipc structure found at least at position pos.
  */
@@ -914,6 +921,7 @@ static int sysvipc_proc_open(struct inode *inode, struc=
t file *file)
=20
 	iter->iface =3D PDE_DATA(inode);
 	iter->ns    =3D get_ipc_ns(current->nsproxy->ipc_ns);
+	iter->pid_ns =3D get_pid_ns(task_active_pid_ns(current));
 out:
 	return ret;
 }
@@ -923,6 +931,7 @@ static int sysvipc_proc_release(struct inode *inode, st=
ruct file *file)
 	struct seq_file *seq =3D file->private_data;
 	struct ipc_proc_iter *iter =3D seq->private;
 	put_ipc_ns(iter->ns);
+	put_pid_ns(iter->pid_ns);
 	return seq_release_private(inode, file);
 }
=20
diff --git a/ipc/util.h b/ipc/util.h
index 1a5a0fcd099c..597405b485b6 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -20,6 +20,7 @@ void msg_init(void);
 void shm_init(void);
=20
 struct ipc_namespace;
+struct pid_namespace;
=20
 #ifdef CONFIG_POSIX_MQUEUE
 extern void mq_clear_sbinfo(struct ipc_namespace *ns);
@@ -90,6 +91,7 @@ void ipc_init_ids(struct ipc_ids *);
 #ifdef CONFIG_PROC_FS
 void __init ipc_init_proc_interface(const char *path, const char *header,
 		int ids, int (*show)(struct seq_file *, void *));
+struct pid_namespace *ipc_seq_pid_ns(struct seq_file *);
 #else
 #define ipc_init_proc_interface(path, header, ids, show) do {} while (0)
 #endif
@@ -141,6 +143,15 @@ struct kern_ipc_perm *ipcctl_pre_down_nolock(struct ip=
c_namespace *ns,
 					     struct ipc_ids *ids, int id, int cmd,
 					     struct ipc64_perm *perm, int extra_perm);
=20
+static inline void ipc_update_pid(struct pid **pos, struct pid *pid)
+{
+	struct pid *old =3D *pos;
+	if (old !=3D pid) {
+		*pos =3D get_pid(pid);
+		put_pid(old);
+	}
+}
+
 #ifndef CONFIG_ARCH_WANT_IPC_PARSE_VERSION
 /* On IA-64, we always use the "64-bit version" of the IPC structures.  */
 # define ipc_parse_version(cmd)	IPC_64
diff --git a/kernel/resource.c b/kernel/resource.c
index db48bab5ea18..a1c3023d318b 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -474,7 +474,8 @@ static int __find_resource(struct resource *root, struc=
t resource *old,
 			alloc.start =3D constraint->alignf(constraint->alignf_data, &avail,
 					size, constraint->align);
 			alloc.end =3D alloc.start + size - 1;
-			if (resource_contains(&avail, &alloc)) {
+			if (alloc.start <=3D alloc.end &&
+			    resource_contains(&avail, &alloc)) {
 				new->start =3D alloc.start;
 				new->end =3D alloc.end;
 				return 0;
diff --git a/kernel/sched/auto_group.c b/kernel/sched/auto_group.c
index 798e912842d5..fbc22ef5b1f8 100644
--- a/kernel/sched/auto_group.c
+++ b/kernel/sched/auto_group.c
@@ -8,6 +8,7 @@
 #include <linux/utsname.h>
 #include <linux/security.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
=20
 unsigned int __read_mostly sysctl_sched_autogroup_enabled =3D 1;
 static struct autogroup autogroup_default;
@@ -197,7 +198,8 @@ int proc_sched_autogroup_set_nice(struct task_struct *p=
, int nice)
 {
 	static unsigned long next =3D INITIAL_JIFFIES;
 	struct autogroup *ag;
-	int err;
+	unsigned long shares;
+	int err, idx;
=20
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -EINVAL;
@@ -216,8 +218,11 @@ int proc_sched_autogroup_set_nice(struct task_struct *=
p, int nice)
 	next =3D HZ / 10 + jiffies;
 	ag =3D autogroup_task_get(p);
=20
+	idx =3D array_index_nospec(nice + 20, 40);
+	shares =3D scale_load(prio_to_weight[idx]);
+
 	down_write(&ag->lock);
-	err =3D sched_group_set_shares(ag->tg, prio_to_weight[nice + 20]);
+	err =3D sched_group_set_shares(ag->tg, shares);
 	if (!err)
 		ag->nice =3D nice;
 	up_write(&ag->lock);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c2e902a52c6d..9f14c79576f5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -74,6 +74,7 @@
 #include <linux/binfmts.h>
 #include <linux/context_tracking.h>
 #include <linux/compiler.h>
+#include <linux/nospec.h>
=20
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
@@ -820,6 +821,8 @@ static void set_load_weight(struct task_struct *p)
 		return;
 	}
=20
+	prio =3D array_index_nospec(prio, 40);
+
 	load->weight =3D scale_load(prio_to_weight[prio]);
 	load->inv_weight =3D prio_to_wmult[prio];
 }
diff --git a/kernel/sys.c b/kernel/sys.c
index 3fb42f9897f1..6afd3be8b57d 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -63,6 +63,9 @@
 #include <asm/io.h>
 #include <asm/unistd.h>
=20
+/* Hardening for Spectre-v1 */
+#include <linux/nospec.h>
+
 #ifndef SET_UNALIGN_CTL
 # define SET_UNALIGN_CTL(a,b)	(-EINVAL)
 #endif
@@ -1294,6 +1297,7 @@ SYSCALL_DEFINE2(old_getrlimit, unsigned int, resource,
 	if (resource >=3D RLIM_NLIMITS)
 		return -EINVAL;
=20
+	resource =3D array_index_nospec(resource, RLIM_NLIMITS);
 	task_lock(current->group_leader);
 	x =3D current->signal->rlim[resource];
 	task_unlock(current->group_leader);
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 64ebaca04fc9..7d890e157452 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -385,6 +385,8 @@ static void clocksource_enqueue_watchdog(struct clockso=
urce *cs)
 {
 	unsigned long flags;
=20
+	INIT_LIST_HEAD(&cs->wd_list);
+
 	spin_lock_irqsave(&watchdog_lock, flags);
 	if (cs->flags & CLOCK_SOURCE_MUST_VERIFY) {
 		/* cs is a clocksource to be watched. */
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 64c5990fd500..c91a974ed11c 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -585,6 +585,14 @@ static void tick_handle_oneshot_broadcast(struct clock=
_event_device *dev)
 	now =3D ktime_get();
 	/* Find all expired events */
 	for_each_cpu(cpu, tick_broadcast_oneshot_mask) {
+		/*
+		 * Required for !SMP because for_each_cpu() reports
+		 * unconditionally CPU0 as set on UP kernels.
+		 */
+		if (!IS_ENABLED(CONFIG_SMP) &&
+		    cpumask_empty(tick_broadcast_oneshot_mask))
+			break;
+
 		td =3D &per_cpu(tick_cpu_device, cpu);
 		if (td->evtdev->next_event.tv64 <=3D now.tv64) {
 			cpumask_set_cpu(cpu, tmpmask);
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events=
_filter.c
index ebbb24147d51..7b5c9a63dfdb 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -273,6 +273,9 @@ static int regex_match_full(char *str, struct regex *r,=
 int len)
=20
 static int regex_match_front(char *str, struct regex *r, int len)
 {
+	if (len < r->len)
+		return 0;
+
 	if (strncmp(str, r->pattern, r->len) =3D=3D 0)
 		return 1;
 	return 0;
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_event=
s_trigger.c
index 4747b476a030..b743e758241e 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -469,9 +469,10 @@ clear_event_triggers(struct trace_array *tr)
 	struct ftrace_event_file *file;
=20
 	list_for_each_entry(file, &tr->events, list) {
-		struct event_trigger_data *data;
-		list_for_each_entry_rcu(data, &file->triggers, list) {
+		struct event_trigger_data *data, *n;
+		list_for_each_entry_safe(data, n, &file->triggers, list) {
 			trace_event_trigger_enable_disable(file, 0);
+			list_del_rcu(&data->list);
 			if (data->ops->free)
 				data->ops->free(data->ops, data);
 		}
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 5224e836acde..68fdc53487a8 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -53,6 +53,7 @@ struct trace_uprobe {
 	struct list_head		list;
 	struct trace_uprobe_filter	filter;
 	struct uprobe_consumer		consumer;
+	struct path			path;
 	struct inode			*inode;
 	char				*filename;
 	unsigned long			offset;
@@ -149,6 +150,8 @@ static void FETCH_FUNC_NAME(memory, string)(struct pt_r=
egs *regs,
 		return;
=20
 	ret =3D strncpy_from_user(dst, src, maxlen);
+	if (ret =3D=3D maxlen)
+		dst[--ret] =3D '\0';
=20
 	if (ret < 0) {	/* Failed to fetch string */
 		((u8 *)get_rloc_data(dest))[0] =3D '\0';
@@ -282,7 +285,7 @@ static void free_trace_uprobe(struct trace_uprobe *tu)
 	for (i =3D 0; i < tu->tp.nr_args; i++)
 		traceprobe_free_probe_arg(&tu->tp.args[i]);
=20
-	iput(tu->inode);
+	path_put(&tu->path);
 	kfree(tu->tp.call.class->system);
 	kfree(tu->tp.call.name);
 	kfree(tu->filename);
@@ -356,7 +359,6 @@ static int register_trace_uprobe(struct trace_uprobe *t=
u)
 static int create_trace_uprobe(int argc, char **argv)
 {
 	struct trace_uprobe *tu;
-	struct inode *inode;
 	char *arg, *event, *group, *filename;
 	char buf[MAX_EVENT_NAME_LEN];
 	struct path path;
@@ -364,7 +366,6 @@ static int create_trace_uprobe(int argc, char **argv)
 	bool is_delete, is_return;
 	int i, ret;
=20
-	inode =3D NULL;
 	ret =3D 0;
 	is_delete =3D false;
 	is_return =3D false;
@@ -428,26 +429,18 @@ static int create_trace_uprobe(int argc, char **argv)
 		pr_info("Probe point is not specified.\n");
 		return -EINVAL;
 	}
-	if (isdigit(argv[1][0])) {
-		pr_info("probe point must be have a filename.\n");
+	/* Find the last occurrence, in case the path contains ':' too. */
+	arg =3D strrchr(argv[1], ':');
+	if (!arg)
 		return -EINVAL;
-	}
-	arg =3D strchr(argv[1], ':');
-	if (!arg) {
-		ret =3D -EINVAL;
-		goto fail_address_parse;
-	}
=20
 	*arg++ =3D '\0';
 	filename =3D argv[1];
 	ret =3D kern_path(filename, LOOKUP_FOLLOW, &path);
 	if (ret)
-		goto fail_address_parse;
-
-	inode =3D igrab(path.dentry->d_inode);
-	path_put(&path);
+		return ret;
=20
-	if (!inode || !S_ISREG(inode->i_mode)) {
+	if (!S_ISREG(path.dentry->d_inode->i_mode)) {
 		ret =3D -EINVAL;
 		goto fail_address_parse;
 	}
@@ -486,7 +479,7 @@ static int create_trace_uprobe(int argc, char **argv)
 		goto fail_address_parse;
 	}
 	tu->offset =3D offset;
-	tu->inode =3D inode;
+	tu->path =3D path;
 	tu->filename =3D kstrdup(filename, GFP_KERNEL);
=20
 	if (!tu->filename) {
@@ -553,8 +546,7 @@ static int create_trace_uprobe(int argc, char **argv)
 	return ret;
=20
 fail_address_parse:
-	if (inode)
-		iput(inode);
+	path_put(&path);
=20
 	pr_info("Failed to parse address or file.\n");
=20
@@ -921,6 +913,7 @@ probe_event_enable(struct trace_uprobe *tu, struct ftra=
ce_event_file *file,
 		goto err_flags;
=20
 	tu->consumer.filter =3D filter;
+	tu->inode =3D tu->path.dentry->d_inode;
 	ret =3D uprobe_register(tu->inode, tu->offset, &tu->consumer);
 	if (ret)
 		goto err_buffer;
@@ -966,6 +959,7 @@ probe_event_disable(struct trace_uprobe *tu, struct ftr=
ace_event_file *file)
 	WARN_ON(!uprobe_filter_is_empty(&tu->filter));
=20
 	uprobe_unregister(tu->inode, tu->offset, &tu->consumer);
+	tu->inode =3D NULL;
 	tu->tp.flags &=3D file ? ~TP_FLAG_TRACE : ~TP_FLAG_PROFILE;
=20
 	uprobe_buffer_disable();
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 3490407dc7b7..4b12034e15b0 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -185,7 +185,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
 			lockdep_is_held(&tracepoints_mutex));
 	old =3D func_add(&tp_funcs, func);
 	if (IS_ERR(old)) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(PTR_ERR(old) !=3D -ENOMEM);
 		return PTR_ERR(old);
 	}
=20
@@ -218,7 +218,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 			lockdep_is_held(&tracepoints_mutex));
 	old =3D func_remove(&tp_funcs, func);
 	if (IS_ERR(old)) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(PTR_ERR(old) !=3D -ENOMEM);
 		return PTR_ERR(old);
 	}
=20
diff --git a/lib/string.c b/lib/string.c
index 30a2f627bc14..d3e7e521ba9c 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -27,6 +27,10 @@
 #include <linux/bug.h>
 #include <linux/errno.h>
=20
+#include <asm/byteorder.h>
+#include <asm/word-at-a-time.h>
+#include <asm/page.h>
+
 #ifndef __HAVE_ARCH_STRNICMP
 /**
  * strnicmp - Case insensitive, length-limited string comparison
@@ -160,6 +164,90 @@ size_t strlcpy(char *dest, const char *src, size_t siz=
e)
 EXPORT_SYMBOL(strlcpy);
 #endif
=20
+#ifndef __HAVE_ARCH_STRSCPY
+/**
+ * strscpy - Copy a C-string into a sized buffer
+ * @dest: Where to copy the string to
+ * @src: Where to copy the string from
+ * @count: Size of destination buffer
+ *
+ * Copy the string, or as much of it as fits, into the dest buffer.
+ * The routine returns the number of characters copied (not including
+ * the trailing NUL) or -E2BIG if the destination buffer wasn't big enough.
+ * The behavior is undefined if the string buffers overlap.
+ * The destination buffer is always NUL terminated, unless it's zero-sized.
+ *
+ * Preferred to strlcpy() since the API doesn't require reading memory
+ * from the src string beyond the specified "count" bytes, and since
+ * the return value is easier to error-check than strlcpy()'s.
+ * In addition, the implementation is robust to the string changing out
+ * from underneath it, unlike the current strlcpy() implementation.
+ *
+ * Preferred to strncpy() since it always returns a valid string, and
+ * doesn't unnecessarily force the tail of the destination buffer to be
+ * zeroed.  If the zeroing is desired, it's likely cleaner to use strscpy()
+ * with an overflow test, then just memset() the tail of the dest buffer.
+ */
+ssize_t strscpy(char *dest, const char *src, size_t count)
+{
+	const struct word_at_a_time constants =3D WORD_AT_A_TIME_CONSTANTS;
+	size_t max =3D count;
+	long res =3D 0;
+
+	if (count =3D=3D 0)
+		return -E2BIG;
+
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	/*
+	 * If src is unaligned, don't cross a page boundary,
+	 * since we don't know if the next page is mapped.
+	 */
+	if ((long)src & (sizeof(long) - 1)) {
+		size_t limit =3D PAGE_SIZE - ((long)src & (PAGE_SIZE - 1));
+		if (limit < max)
+			max =3D limit;
+	}
+#else
+	/* If src or dest is unaligned, don't do word-at-a-time. */
+	if (((long) dest | (long) src) & (sizeof(long) - 1))
+		max =3D 0;
+#endif
+
+	while (max >=3D sizeof(unsigned long)) {
+		unsigned long c, data;
+
+		c =3D *(unsigned long *)(src+res);
+		*(unsigned long *)(dest+res) =3D c;
+		if (has_zero(c, &data, &constants)) {
+			data =3D prep_zero_mask(c, data, &constants);
+			data =3D create_zero_mask(data);
+			return res + find_zero(data);
+		}
+		res +=3D sizeof(unsigned long);
+		count -=3D sizeof(unsigned long);
+		max -=3D sizeof(unsigned long);
+	}
+
+	while (count) {
+		char c;
+
+		c =3D src[res];
+		dest[res] =3D c;
+		if (!c)
+			return res;
+		res++;
+		count--;
+	}
+
+	/* Hit buffer length without finding a NUL; force NUL-termination. */
+	if (res)
+		dest[res-1] =3D '\0';
+
+	return -E2BIG;
+}
+EXPORT_SYMBOL(strscpy);
+#endif
+
 #ifndef __HAVE_ARCH_STRCAT
 /**
  * strcat - Append one %NUL-terminated string to another
diff --git a/mm/filemap.c b/mm/filemap.c
index 94d69f277dae..cdc89ee6af5f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -529,7 +529,7 @@ int replace_page_cache_page(struct page *old, struct pa=
ge *new, gfp_t gfp_mask)
 	VM_BUG_ON_PAGE(!PageLocked(new), new);
 	VM_BUG_ON_PAGE(new->mapping, new);
=20
-	error =3D radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error =3D radix_tree_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (!error) {
 		struct address_space *mapping =3D old->mapping;
 		void (*freepage)(struct page *);
@@ -576,7 +576,7 @@ static int __add_to_page_cache_locked(struct page *page,
 	if (error)
 		return error;
=20
-	error =3D radix_tree_maybe_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error =3D radix_tree_maybe_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (error) {
 		mem_cgroup_uncharge_cache_page(page);
 		return error;
@@ -1111,8 +1111,7 @@ struct page *pagecache_get_page(struct address_space =
*mapping, pgoff_t offset,
 		if (fgp_flags & FGP_ACCESSED)
 			init_page_accessed(page);
=20
-		err =3D add_to_page_cache_lru(page, mapping, offset,
-				gfp_mask & GFP_RECLAIM_MASK);
+		err =3D add_to_page_cache_lru(page, mapping, offset, gfp_mask);
 		if (unlikely(err)) {
 			page_cache_release(page);
 			page =3D NULL;
diff --git a/mm/mmap.c b/mm/mmap.c
index 77118da138fc..9b7beabd9ccc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1234,6 +1234,35 @@ static inline int mlock_future_check(struct mm_struc=
t *mm,
 	return 0;
 }
=20
+static inline u64 file_mmap_size_max(struct file *file, struct inode *inod=
e)
+{
+	if (S_ISREG(inode->i_mode))
+		return MAX_LFS_FILESIZE;
+
+	if (S_ISBLK(inode->i_mode))
+		return MAX_LFS_FILESIZE;
+
+	/* Special "we do even unsigned file positions" case */
+	if (file->f_mode & FMODE_UNSIGNED_OFFSET)
+		return 0;
+
+	/* Yes, random drivers might want more. But I'm tired of buggy drivers */
+	return ULONG_MAX;
+}
+
+static inline bool file_mmap_ok(struct file *file, struct inode *inode,
+				unsigned long pgoff, unsigned long len)
+{
+	u64 maxsize =3D file_mmap_size_max(file, inode);
+
+	if (maxsize && len > maxsize)
+		return false;
+	maxsize -=3D len;
+	if (pgoff > maxsize >> PAGE_SHIFT)
+		return false;
+	return true;
+}
+
 /*
  * The caller must hold down_write(&current->mm->mmap_sem).
  */
@@ -1301,6 +1330,9 @@ unsigned long do_mmap_pgoff(struct file *file, unsign=
ed long addr,
 	if (file) {
 		struct inode *inode =3D file_inode(file);
=20
+		if (!file_mmap_ok(file, inode, pgoff, len))
+			return -EOVERFLOW;
+
 		switch (flags & MAP_TYPE) {
 		case MAP_SHARED:
 			if ((prot&PROT_WRITE) && !(file->f_mode&FMODE_WRITE))
diff --git a/net/atm/lec.c b/net/atm/lec.c
index 4c5b8ba0f84f..3a4a737f14db 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -41,6 +41,9 @@ static unsigned char bridge_ula_lec[] =3D { 0x01, 0x80, 0=
xc2, 0x00, 0x00 };
 #include <linux/module.h>
 #include <linux/init.h>
=20
+/* Hardening for Spectre-v1 */
+#include <linux/nospec.h>
+
 #include "lec.h"
 #include "lec_arpc.h"
 #include "resources.h"
@@ -695,8 +698,10 @@ static int lec_vcc_attach(struct atm_vcc *vcc, void __=
user *arg)
 	bytes_left =3D copy_from_user(&ioc_data, arg, sizeof(struct atmlec_ioc));
 	if (bytes_left !=3D 0)
 		pr_info("copy from user failed for %d bytes\n", bytes_left);
-	if (ioc_data.dev_num < 0 || ioc_data.dev_num >=3D MAX_LEC_ITF ||
-	    !dev_lec[ioc_data.dev_num])
+	if (ioc_data.dev_num < 0 || ioc_data.dev_num >=3D MAX_LEC_ITF)
+		return -EINVAL;
+	ioc_data.dev_num =3D array_index_nospec(ioc_data.dev_num, MAX_LEC_ITF);
+	if (!dev_lec[ioc_data.dev_num])
 		return -EINVAL;
 	vpriv =3D kmalloc(sizeof(struct lec_vcc_priv), GFP_KERNEL);
 	if (!vpriv)
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translatio=
n-table.c
index 118eba81620e..fd8b314d0692 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -718,7 +718,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_n=
ode *orig_node,
 	struct batadv_orig_node_vlan *vlan;
 	uint8_t *tt_change_ptr;
=20
-	rcu_read_lock();
+	spin_lock_bh(&orig_node->vlan_list_lock);
 	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
 		num_vlan++;
 		num_entries +=3D atomic_read(&vlan->tt.num_entries);
@@ -756,7 +756,7 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_n=
ode *orig_node,
 	*tt_change =3D (struct batadv_tvlv_tt_change *)tt_change_ptr;
=20
 out:
-	rcu_read_unlock();
+	spin_unlock_bh(&orig_node->vlan_list_lock);
 	return tvlv_len;
 }
=20
@@ -786,14 +786,21 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv =
*bat_priv,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_softif_vlan *vlan;
-	uint16_t num_vlan =3D 0, num_entries =3D 0, tvlv_len;
+	u16 num_vlan =3D 0;
+	u16 vlan_entries =3D 0;
+	u16 total_entries =3D 0;
+	u16 tvlv_len;
 	uint8_t *tt_change_ptr;
 	int change_offset;
=20
-	rcu_read_lock();
+	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
 	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+		vlan_entries =3D atomic_read(&vlan->tt.num_entries);
+		if (vlan_entries < 1)
+			continue;
+
 		num_vlan++;
-		num_entries +=3D atomic_read(&vlan->tt.num_entries);
+		total_entries +=3D vlan_entries;
 	}
=20
 	change_offset =3D sizeof(**tt_data);
@@ -801,7 +808,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *b=
at_priv,
=20
 	/* if tt_len is negative, allocate the space needed by the full table */
 	if (*tt_len < 0)
-		*tt_len =3D batadv_tt_len(num_entries);
+		*tt_len =3D batadv_tt_len(total_entries);
=20
 	tvlv_len =3D *tt_len;
 	tvlv_len +=3D change_offset;
@@ -818,6 +825,10 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *=
bat_priv,
=20
 	tt_vlan =3D (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
 	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
+		vlan_entries =3D atomic_read(&vlan->tt.num_entries);
+		if (vlan_entries < 1)
+			continue;
+
 		tt_vlan->vid =3D htons(vlan->vid);
 		tt_vlan->crc =3D htonl(vlan->tt.crc);
=20
@@ -828,7 +839,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *b=
at_priv,
 	*tt_change =3D (struct batadv_tvlv_tt_change *)tt_change_ptr;
=20
 out:
-	rcu_read_unlock();
+	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
 	return tvlv_len;
 }
=20
@@ -1219,7 +1230,8 @@ batadv_tt_global_orig_entry_find(const struct batadv_=
tt_global_entry *entry,
  */
 static bool
 batadv_tt_global_entry_has_orig(const struct batadv_tt_global_entry *entry,
-				const struct batadv_orig_node *orig_node)
+				const struct batadv_orig_node *orig_node,
+				u8 *flags)
 {
 	struct batadv_tt_orig_list_entry *orig_entry;
 	bool found =3D false;
@@ -1227,6 +1239,10 @@ batadv_tt_global_entry_has_orig(const struct batadv_=
tt_global_entry *entry,
 	orig_entry =3D batadv_tt_global_orig_entry_find(entry, orig_node);
 	if (orig_entry) {
 		found =3D true;
+
+		if (flags)
+			*flags =3D orig_entry->flags;
+
 		batadv_tt_orig_list_entry_free_ref(orig_entry);
 	}
=20
@@ -1403,7 +1419,7 @@ static bool batadv_tt_global_add(struct batadv_priv *=
bat_priv,
 			if (!(common->flags & BATADV_TT_CLIENT_TEMP))
 				goto out;
 			if (batadv_tt_global_entry_has_orig(tt_global_entry,
-							    orig_node))
+							    orig_node, NULL))
 				goto out_remove;
 			batadv_tt_global_del_orig_list(tt_global_entry);
 			goto add_orig_entry;
@@ -2311,23 +2327,46 @@ batadv_new_tt_req_node(struct batadv_priv *bat_priv,
 }
=20
 /**
- * batadv_tt_local_valid - verify that given tt entry is a valid one
+ * batadv_tt_local_valid() - verify local tt entry and get flags
  * @entry_ptr: to be checked local tt entry
  * @data_ptr: not used but definition required to satisfy the callback pro=
totype
+ * @flags: a pointer to store TT flags for this client to
+ *
+ * Checks the validity of the given local TT entry. If it is, then the pro=
vided
+ * flags pointer is updated.
  *
- * Returns 1 if the entry is a valid, 0 otherwise.
+ * Return: true if the entry is a valid, false otherwise.
  */
-static int batadv_tt_local_valid(const void *entry_ptr, const void *data_p=
tr)
+static bool batadv_tt_local_valid(const void *entry_ptr,
+				  const void *data_ptr,
+				  u8 *flags)
 {
 	const struct batadv_tt_common_entry *tt_common_entry =3D entry_ptr;
=20
 	if (tt_common_entry->flags & BATADV_TT_CLIENT_NEW)
-		return 0;
-	return 1;
+		return false;
+
+	if (flags)
+		*flags =3D tt_common_entry->flags;
+
+	return true;
 }
=20
-static int batadv_tt_global_valid(const void *entry_ptr,
-				  const void *data_ptr)
+/**
+ * batadv_tt_global_valid() - verify global tt entry and get flags
+ * @entry_ptr: to be checked global tt entry
+ * @data_ptr: an orig_node object (may be NULL)
+ * @flags: a pointer to store TT flags for this client to
+ *
+ * Checks the validity of the given global TT entry. If it is, then the pr=
ovided
+ * flags pointer is updated either with the common (summed) TT flags if da=
ta_ptr
+ * is NULL or the specific, per originator TT flags otherwise.
+ *
+ * Return: true if the entry is a valid, false otherwise.
+ */
+static bool batadv_tt_global_valid(const void *entry_ptr,
+				   const void *data_ptr,
+				   u8 *flags)
 {
 	const struct batadv_tt_common_entry *tt_common_entry =3D entry_ptr;
 	const struct batadv_tt_global_entry *tt_global_entry;
@@ -2341,7 +2380,8 @@ static int batadv_tt_global_valid(const void *entry_p=
tr,
 				       struct batadv_tt_global_entry,
 				       common);
=20
-	return batadv_tt_global_entry_has_orig(tt_global_entry, orig_node);
+	return batadv_tt_global_entry_has_orig(tt_global_entry, orig_node,
+					       flags);
 }
=20
 /**
@@ -2351,24 +2391,34 @@ static int batadv_tt_global_valid(const void *entry=
_ptr,
  * @hash: hash table containing the tt entries
  * @tt_len: expected tvlv tt data buffer length in number of bytes
  * @tvlv_buff: pointer to the buffer to fill with the TT data
- * @valid_cb: function to filter tt change entries
+ * @valid_cb: function to filter tt change entries and to return TT flags
  * @cb_data: data passed to the filter function as argument
+ *
+ * Fills the tvlv buff with the tt entries from the specified hash. If val=
id_cb
+ * is not provided then this becomes a no-op.
  */
 static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 				    struct batadv_hashtable *hash,
 				    void *tvlv_buff, uint16_t tt_len,
-				    int (*valid_cb)(const void *, const void *),
+				    bool (*valid_cb)(const void *,
+						     const void *,
+						     u8 *flags),
 				    void *cb_data)
 {
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tvlv_tt_change *tt_change;
 	struct hlist_head *head;
 	uint16_t tt_tot, tt_num_entries =3D 0;
+	u8 flags;
+	bool ret;
 	uint32_t i;
=20
 	tt_tot =3D batadv_tt_entries(tt_len);
 	tt_change =3D (struct batadv_tvlv_tt_change *)tvlv_buff;
=20
+	if (!valid_cb)
+		return;
+
 	rcu_read_lock();
 	for (i =3D 0; i < hash->size; i++) {
 		head =3D &hash->table[i];
@@ -2378,11 +2428,12 @@ static void batadv_tt_tvlv_generate(struct batadv_p=
riv *bat_priv,
 			if (tt_tot =3D=3D tt_num_entries)
 				break;
=20
-			if ((valid_cb) && (!valid_cb(tt_common_entry, cb_data)))
+			ret =3D valid_cb(tt_common_entry, cb_data, &flags);
+			if (!ret)
 				continue;
=20
 			ether_addr_copy(tt_change->addr, tt_common_entry->addr);
-			tt_change->flags =3D tt_common_entry->flags;
+			tt_change->flags =3D flags;
 			tt_change->vid =3D htons(tt_common_entry->vid);
 			memset(tt_change->reserved, 0,
 			       sizeof(tt_change->reserved));
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtable=
s.c
index 72142370bd98..2df71bc7959d 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1897,7 +1897,8 @@ static int compat_mtw_from_user(struct compat_ebt_ent=
ry_mwt *mwt,
 	int off, pad =3D 0;
 	unsigned int size_kern, match_size =3D mwt->match_size;
=20
-	strlcpy(name, mwt->u.name, sizeof(name));
+	if (strscpy(name, mwt->u.name, sizeof(name)) < 0)
+		return -EINVAL;
=20
 	if (state->buf_kern_start)
 		dst =3D state->buf_kern_start + state->buf_kern_offset;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 6a2236aee1ce..a1edd9bd70ad 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2453,6 +2453,11 @@ static int try_write(struct ceph_connection *con)
 	int ret =3D 1;
=20
 	dout("try_write start %p state %lu\n", con, con->state);
+	if (con->state !=3D CON_STATE_PREOPEN &&
+	    con->state !=3D CON_STATE_CONNECTING &&
+	    con->state !=3D CON_STATE_NEGOTIATING &&
+	    con->state !=3D CON_STATE_OPEN)
+		return 0;
=20
 more:
 	dout("try_write out_kvec_bytes %d\n", con->out_kvec_bytes);
@@ -2478,6 +2483,8 @@ static int try_write(struct ceph_connection *con)
 	}
=20
 more_kvec:
+	BUG_ON(!con->sock);
+
 	/* kvec data queued? */
 	if (con->out_skip) {
 		ret =3D write_partial_skip(con);
diff --git a/net/compat.c b/net/compat.c
index 53e933eb78b8..3c8f9daeb6d7 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -386,7 +386,8 @@ static int compat_sock_setsockopt(struct socket *sock, =
int level, int optname,
 	if (optname =3D=3D SO_ATTACH_FILTER)
 		return do_set_attach_filter(sock, level, optname,
 					    optval, optlen);
-	if (optname =3D=3D SO_RCVTIMEO || optname =3D=3D SO_SNDTIMEO)
+	if (!COMPAT_USE_64BIT_TIME &&
+	    (optname =3D=3D SO_RCVTIMEO || optname =3D=3D SO_SNDTIMEO))
 		return do_set_sock_timeout(sock, level, optname, optval, optlen);
=20
 	return sock_setsockopt(sock, level, optname, optval, optlen);
@@ -451,7 +452,8 @@ static int do_get_sock_timeout(struct socket *sock, int=
 level, int optname,
 static int compat_sock_getsockopt(struct socket *sock, int level, int optn=
ame,
 				char __user *optval, int __user *optlen)
 {
-	if (optname =3D=3D SO_RCVTIMEO || optname =3D=3D SO_SNDTIMEO)
+	if (!COMPAT_USE_64BIT_TIME &&
+	    (optname =3D=3D SO_RCVTIMEO || optname =3D=3D SO_SNDTIMEO))
 		return do_get_sock_timeout(sock, level, optname, optval, optlen);
 	return sock_getsockopt(sock, level, optname, optval, optlen);
 }
diff --git a/net/core/dev.c b/net/core/dev.c
index f8f03ebd0507..24afa7203884 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2608,7 +2608,8 @@ netdev_features_t netif_skb_features(struct sk_buff *=
skb)
=20
 	if (!vlan_tx_tag_present(skb)) {
 		if (unlikely(protocol =3D=3D htons(ETH_P_8021Q) ||
-			     protocol =3D=3D htons(ETH_P_8021AD))) {
+			     protocol =3D=3D htons(ETH_P_8021AD)) &&
+		    likely(pskb_may_pull(skb, VLAN_ETH_HLEN))) {
 			struct vlan_ethhdr *veh =3D (struct vlan_ethhdr *)skb->data;
 			protocol =3D veh->h_vlan_encapsulated_proto;
 		} else {
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index b6b230600b97..41aad226c69b 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -57,8 +57,8 @@ static int __hw_addr_add_ex(struct netdev_hw_addr_list *l=
ist,
 		return -EINVAL;
=20
 	list_for_each_entry(ha, &list->list, list) {
-		if (!memcmp(ha->addr, addr, addr_len) &&
-		    ha->type =3D=3D addr_type) {
+		if (ha->type =3D=3D addr_type &&
+		    !memcmp(ha->addr, addr, addr_len)) {
 			if (global) {
 				/* check if addr is already used as global */
 				if (ha->global_use)
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 0478423afd29..be085a7b48df 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -54,7 +54,8 @@ do {						\
 static void neigh_timer_handler(unsigned long arg);
 static void __neigh_notify(struct neighbour *n, int type, int flags);
 static void neigh_update_notify(struct neighbour *neigh);
-static int pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev);
+static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
+				    struct net_device *dev);
=20
 static struct neigh_table *neigh_tables;
 #ifdef CONFIG_PROC_FS
@@ -260,8 +261,7 @@ int neigh_ifdown(struct neigh_table *tbl, struct net_de=
vice *dev)
 {
 	write_lock_bh(&tbl->lock);
 	neigh_flush_dev(tbl, dev);
-	pneigh_ifdown(tbl, dev);
-	write_unlock_bh(&tbl->lock);
+	pneigh_ifdown_and_unlock(tbl, dev);
=20
 	del_timer_sync(&tbl->proxy_timer);
 	pneigh_queue_purge(&tbl->proxy_queue);
@@ -659,9 +659,10 @@ int pneigh_delete(struct neigh_table *tbl, struct net =
*net, const void *pkey,
 	return -ENOENT;
 }
=20
-static int pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev)
+static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
+				    struct net_device *dev)
 {
-	struct pneigh_entry *n, **np;
+	struct pneigh_entry *n, **np, *freelist =3D NULL;
 	u32 h;
=20
 	for (h =3D 0; h <=3D PNEIGH_HASHMASK; h++) {
@@ -669,17 +670,24 @@ static int pneigh_ifdown(struct neigh_table *tbl, str=
uct net_device *dev)
 		while ((n =3D *np) !=3D NULL) {
 			if (!dev || n->dev =3D=3D dev) {
 				*np =3D n->next;
-				if (tbl->pdestructor)
-					tbl->pdestructor(n);
-				if (n->dev)
-					dev_put(n->dev);
-				release_net(pneigh_net(n));
-				kfree(n);
+				n->next =3D freelist;
+				freelist =3D n;
 				continue;
 			}
 			np =3D &n->next;
 		}
 	}
+	write_unlock_bh(&tbl->lock);
+	while ((n =3D freelist)) {
+		freelist =3D n->next;
+		n->next =3D NULL;
+		if (tbl->pdestructor)
+			tbl->pdestructor(n);
+		if (n->dev)
+			dev_put(n->dev);
+		release_net(pneigh_net(n));
+		kfree(n);
+	}
 	return -ENOENT;
 }
=20
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9bb9a01a1478..98352d7fd570 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -767,6 +767,7 @@ static struct sk_buff *__skb_clone(struct sk_buff *n, s=
truct sk_buff *skb)
 	n->hdr_len =3D skb->nohdr ? skb_headroom(skb) : skb->hdr_len;
 	n->cloned =3D 1;
 	n->nohdr =3D 0;
+	n->peeked =3D 0;
 	n->destructor =3D NULL;
 	C(tail);
 	C(end);
diff --git a/net/dccp/ccids/ccid2.c b/net/dccp/ccids/ccid2.c
index 4dbea29d53ca..e66e9f2ed473 100644
--- a/net/dccp/ccids/ccid2.c
+++ b/net/dccp/ccids/ccid2.c
@@ -126,6 +126,16 @@ static void ccid2_change_l_seq_window(struct sock *sk,=
 u64 val)
 						  DCCPF_SEQ_WMAX));
 }
=20
+static void dccp_tasklet_schedule(struct sock *sk)
+{
+	struct tasklet_struct *t =3D &dccp_sk(sk)->dccps_xmitlet;
+
+	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
+		sock_hold(sk);
+		__tasklet_schedule(t);
+	}
+}
+
 static void ccid2_hc_tx_rto_expire(unsigned long data)
 {
 	struct sock *sk =3D (struct sock *)data;
@@ -166,7 +176,7 @@ static void ccid2_hc_tx_rto_expire(unsigned long data)
=20
 	/* if we were blocked before, we may now send cwnd=3D1 packet */
 	if (sender_was_blocked)
-		tasklet_schedule(&dccp_sk(sk)->dccps_xmitlet);
+		dccp_tasklet_schedule(sk);
 	/* restart backed-off timer */
 	sk_reset_timer(sk, &hc->tx_rtotimer, jiffies + hc->tx_rto);
 out:
@@ -706,7 +716,7 @@ static void ccid2_hc_tx_packet_recv(struct sock *sk, st=
ruct sk_buff *skb)
 done:
 	/* check if incoming Acks allow pending packets to be sent */
 	if (sender_was_blocked && !ccid2_cwnd_network_limited(hc))
-		tasklet_schedule(&dccp_sk(sk)->dccps_xmitlet);
+		dccp_tasklet_schedule(sk);
 	dccp_ackvec_parsed_cleanup(&hc->tx_av_chunks);
 }
=20
diff --git a/net/dccp/timer.c b/net/dccp/timer.c
index 1cd46a345cb0..851a212f4915 100644
--- a/net/dccp/timer.c
+++ b/net/dccp/timer.c
@@ -252,12 +252,12 @@ static void dccp_write_xmitlet(unsigned long data)
 	else
 		dccp_write_xmit(sk);
 	bh_unlock_sock(sk);
+	sock_put(sk);
 }
=20
 static void dccp_write_xmit_timer(unsigned long data)
 {
 	dccp_write_xmitlet(data);
-	sock_put((struct sock *)data);
 }
=20
 void dccp_init_xmit_timers(struct sock *sk)
diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index bf8584339048..d11e032f2276 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -29,6 +29,7 @@
 #include <linux/keyctl.h>
 #include <linux/err.h>
 #include <linux/seq_file.h>
+#include <linux/ratelimit.h>
 #include <keys/dns_resolver-type.h>
 #include <keys/user-type.h>
 #include "internal.h"
@@ -93,10 +94,9 @@ dns_resolver_instantiate(struct key *key, struct key_pre=
parsed_payload *prep)
=20
 			next_opt =3D memchr(opt, '#', end - opt) ?: end;
 			opt_len =3D next_opt - opt;
-			if (!opt_len) {
-				printk(KERN_WARNING
-				       "Empty option to dns_resolver key %d\n",
-				       key->serial);
+			if (opt_len <=3D 0 || opt_len > 128) {
+				pr_warn_ratelimited("Invalid option length (%d) for dns_resolver key\n=
",
+						    opt_len);
 				return -EINVAL;
 			}
=20
@@ -130,10 +130,8 @@ dns_resolver_instantiate(struct key *key, struct key_p=
reparsed_payload *prep)
 			}
=20
 		bad_option_value:
-			printk(KERN_WARNING
-			       "Option '%*.*s' to dns_resolver key %d:"
-			       " bad/missing value\n",
-			       opt_nlen, opt_nlen, opt, key->serial);
+			pr_warn_ratelimited("Option '%*.*s' to dns_resolver key: bad/missing va=
lue\n",
+					    opt_nlen, opt_nlen, opt);
 			return -EINVAL;
 		} while (opt =3D next_opt + 1, opt < end);
 	}
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 6d592f8555fb..04ec29ec670a 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -191,6 +191,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct=
 sock *sk, const int stat
 		tw->tw_dport	    =3D inet->inet_dport;
 		tw->tw_family	    =3D sk->sk_family;
 		tw->tw_reuse	    =3D sk->sk_reuse;
+		tw->tw_reuseport    =3D sk->sk_reuseport;
 		tw->tw_hash	    =3D sk->sk_hash;
 		tw->tw_ipv6only	    =3D 0;
 		tw->tw_transparent  =3D inet->transparent;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6561c103e216..109eddf0248a 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1025,7 +1025,8 @@ static int __ip_append_data(struct sock *sk,
 		if (copy > length)
 			copy =3D length;
=20
-		if (!(rt->dst.dev->features&NETIF_F_SG)) {
+		if (!(rt->dst.dev->features&NETIF_F_SG) &&
+		    skb_tailroom(skb) >=3D copy) {
 			unsigned int off;
=20
 			off =3D skb->len;
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 34fce09c5fd1..32f685b35302 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -300,13 +300,14 @@ static struct net_device *__ip_tunnel_create(struct n=
et *net,
 	struct net_device *dev;
 	char name[IFNAMSIZ];
=20
-	if (parms->name[0])
+	err =3D -E2BIG;
+	if (parms->name[0]) {
+		if (!dev_valid_name(parms->name))
+			goto failed;
 		strlcpy(name, parms->name, IFNAMSIZ);
-	else {
-		if (strlen(ops->kind) > (IFNAMSIZ - 3)) {
-			err =3D -E2BIG;
+	} else {
+		if (strlen(ops->kind) > (IFNAMSIZ - 3))
 			goto failed;
-		}
 		strlcpy(name, ops->kind, IFNAMSIZ);
 		strncat(name, "%d", 2);
 	}
@@ -386,7 +387,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
=20
 	if (tdev) {
 		hlen =3D tdev->hard_header_len + tdev->needed_headroom;
-		mtu =3D tdev->mtu;
+		mtu =3D min(tdev->mtu, IP_MAX_MTU);
 	}
 	dev->iflink =3D tunnel->parms.link;
=20
@@ -850,7 +851,7 @@ int ip_tunnel_change_mtu(struct net_device *dev, int ne=
w_mtu)
 	int t_hlen =3D tunnel->hlen + sizeof(struct iphdr);
=20
 	if (new_mtu < 68 ||
-	    new_mtu > 0xFFF8 - dev->hard_header_len - t_hlen)
+	    new_mtu > IP_MAX_MTU - dev->hard_header_len - t_hlen)
 		return -EINVAL;
 	dev->mtu =3D new_mtu;
 	return 0;
@@ -978,7 +979,7 @@ int ip_tunnel_newlink(struct net_device *dev, struct nl=
attr *tb[],
=20
 	mtu =3D ip_tunnel_bind_dev(dev);
 	if (tb[IFLA_MTU]) {
-		unsigned int max =3D 0xfff8 - dev->hard_header_len - nt->hlen;
+		unsigned int max =3D IP_MAX_MTU - dev->hard_header_len - nt->hlen;
=20
 		mtu =3D clamp(dev->mtu, (unsigned int)ETH_MIN_MTU,
 			    (unsigned int)(max - sizeof(struct iphdr)));
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 3e3bd0819987..0dd42abce335 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -779,8 +779,10 @@ static int ping_v4_sendmsg(struct kiocb *iocb, struct =
sock *sk, struct msghdr *m
 	ipc.addr =3D faddr =3D daddr;
=20
 	if (ipc.opt && ipc.opt->opt.srr) {
-		if (!daddr)
-			return -EINVAL;
+		if (!daddr) {
+			err =3D -EINVAL;
+			goto out_free;
+		}
 		faddr =3D ipc.opt->opt.faddr;
 	}
 	tos =3D get_rttos(&ipc, inet);
@@ -845,6 +847,7 @@ static int ping_v4_sendmsg(struct kiocb *iocb, struct s=
ock *sk, struct msghdr *m
=20
 out:
 	ip_rt_put(rt);
+out_free:
 	if (free)
 		kfree(ipc.opt);
 	if (!err) {
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index c75c5e89dfc9..4f7c378c841d 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -684,7 +684,7 @@ static void update_or_create_fnhe(struct fib_nh *nh, __=
be32 daddr, __be32 gw,
 		fnhe->fnhe_gw =3D gw;
 		fnhe->fnhe_pmtu =3D pmtu;
 		fnhe->fnhe_mtu_locked =3D lock;
-		fnhe->fnhe_expires =3D expires;
+		fnhe->fnhe_expires =3D max(1UL, expires);
=20
 		/* Exception created; mark the cached routes for the nexthop
 		 * stale, so anyone caching it rechecks if this exception
@@ -1259,6 +1259,36 @@ static unsigned int ipv4_mtu(const struct dst_entry =
*dst)
 	return min_t(unsigned int, mtu, IP_MAX_MTU);
 }
=20
+static void ip_del_fnhe(struct fib_nh *nh, __be32 daddr)
+{
+	struct fnhe_hash_bucket *hash;
+	struct fib_nh_exception *fnhe, __rcu **fnhe_p;
+	u32 hval =3D fnhe_hashfun(daddr);
+
+	spin_lock_bh(&fnhe_lock);
+
+	hash =3D rcu_dereference_protected(nh->nh_exceptions,
+					 lockdep_is_held(&fnhe_lock));
+	hash +=3D hval;
+
+	fnhe_p =3D &hash->chain;
+	fnhe =3D rcu_dereference_protected(*fnhe_p, lockdep_is_held(&fnhe_lock));
+	while (fnhe) {
+		if (fnhe->fnhe_daddr =3D=3D daddr) {
+			rcu_assign_pointer(*fnhe_p, rcu_dereference_protected(
+				fnhe->fnhe_next, lockdep_is_held(&fnhe_lock)));
+			fnhe_flush_routes(fnhe);
+			kfree_rcu(fnhe, rcu);
+			break;
+		}
+		fnhe_p =3D &fnhe->fnhe_next;
+		fnhe =3D rcu_dereference_protected(fnhe->fnhe_next,
+						 lockdep_is_held(&fnhe_lock));
+	}
+
+	spin_unlock_bh(&fnhe_lock);
+}
+
 static struct fib_nh_exception *find_exception(struct fib_nh *nh, __be32 d=
addr)
 {
 	struct fnhe_hash_bucket *hash =3D nh->nh_exceptions;
@@ -1272,8 +1302,14 @@ static struct fib_nh_exception *find_exception(struc=
t fib_nh *nh, __be32 daddr)
=20
 	for (fnhe =3D rcu_dereference(hash[hval].chain); fnhe;
 	     fnhe =3D rcu_dereference(fnhe->fnhe_next)) {
-		if (fnhe->fnhe_daddr =3D=3D daddr)
+		if (fnhe->fnhe_daddr =3D=3D daddr) {
+			if (fnhe->fnhe_expires &&
+			    time_after(jiffies, fnhe->fnhe_expires)) {
+				ip_del_fnhe(nh, daddr);
+				break;
+			}
 			return fnhe;
+		}
 	}
 	return NULL;
 }
@@ -1568,36 +1604,6 @@ static void ip_handle_martian_source(struct net_devi=
ce *dev,
 #endif
 }
=20
-static void ip_del_fnhe(struct fib_nh *nh, __be32 daddr)
-{
-	struct fnhe_hash_bucket *hash;
-	struct fib_nh_exception *fnhe, __rcu **fnhe_p;
-	u32 hval =3D fnhe_hashfun(daddr);
-
-	spin_lock_bh(&fnhe_lock);
-
-	hash =3D rcu_dereference_protected(nh->nh_exceptions,
-					 lockdep_is_held(&fnhe_lock));
-	hash +=3D hval;
-
-	fnhe_p =3D &hash->chain;
-	fnhe =3D rcu_dereference_protected(*fnhe_p, lockdep_is_held(&fnhe_lock));
-	while (fnhe) {
-		if (fnhe->fnhe_daddr =3D=3D daddr) {
-			rcu_assign_pointer(*fnhe_p, rcu_dereference_protected(
-				fnhe->fnhe_next, lockdep_is_held(&fnhe_lock)));
-			fnhe_flush_routes(fnhe);
-			kfree_rcu(fnhe, rcu);
-			break;
-		}
-		fnhe_p =3D &fnhe->fnhe_next;
-		fnhe =3D rcu_dereference_protected(fnhe->fnhe_next,
-						 lockdep_is_held(&fnhe_lock));
-	}
-
-	spin_unlock_bh(&fnhe_lock);
-}
-
 /* called in rcu_read_lock() section */
 static int __mkroute_input(struct sk_buff *skb,
 			   const struct fib_result *res,
@@ -1651,20 +1657,10 @@ static int __mkroute_input(struct sk_buff *skb,
=20
 	fnhe =3D find_exception(&FIB_RES_NH(*res), daddr);
 	if (do_cache) {
-		if (fnhe) {
+		if (fnhe)
 			rth =3D rcu_dereference(fnhe->fnhe_rth_input);
-			if (rth && rth->dst.expires &&
-			    time_after(jiffies, rth->dst.expires)) {
-				ip_del_fnhe(&FIB_RES_NH(*res), daddr);
-				fnhe =3D NULL;
-			} else {
-				goto rt_cache;
-			}
-		}
-
-		rth =3D rcu_dereference(FIB_RES_NH(*res).nh_rth_input);
-
-rt_cache:
+		else
+			rth =3D rcu_dereference(FIB_RES_NH(*res).nh_rth_input);
 		if (rt_cache_valid(rth)) {
 			skb_dst_set_noref(skb, &rth->dst);
 			goto out;
@@ -2000,39 +1996,31 @@ static struct rtable *__mkroute_output(const struct=
 fib_result *res,
 		 * the loopback interface and the IP_PKTINFO ipi_ifindex will
 		 * be set to the loopback interface as well.
 		 */
-		fi =3D NULL;
+		do_cache =3D false;
 	}
=20
 	fnhe =3D NULL;
 	do_cache &=3D fi !=3D NULL;
-	if (do_cache) {
+	if (fi) {
 		struct rtable __rcu **prth;
 		struct fib_nh *nh =3D &FIB_RES_NH(*res);
=20
 		fnhe =3D find_exception(nh, fl4->daddr);
+		if (!do_cache)
+			goto add;
 		if (fnhe) {
 			prth =3D &fnhe->fnhe_rth_output;
-			rth =3D rcu_dereference(*prth);
-			if (rth && rth->dst.expires &&
-			    time_after(jiffies, rth->dst.expires)) {
-				ip_del_fnhe(nh, fl4->daddr);
-				fnhe =3D NULL;
-			} else {
-				goto rt_cache;
+		} else {
+			if (unlikely(fl4->flowi4_flags &
+				     FLOWI_FLAG_KNOWN_NH &&
+				     !(nh->nh_gw &&
+				       nh->nh_scope =3D=3D RT_SCOPE_LINK))) {
+				do_cache =3D false;
+				goto add;
 			}
+			prth =3D raw_cpu_ptr(nh->nh_pcpu_rth_output);
 		}
-
-		if (unlikely(fl4->flowi4_flags &
-			     FLOWI_FLAG_KNOWN_NH &&
-			     !(nh->nh_gw &&
-			       nh->nh_scope =3D=3D RT_SCOPE_LINK))) {
-			do_cache =3D false;
-			goto add;
-		}
-		prth =3D raw_cpu_ptr(nh->nh_pcpu_rth_output);
 		rth =3D rcu_dereference(*prth);
-
-rt_cache:
 		if (rt_cache_valid(rth)) {
 			dst_hold(&rth->dst);
 			return rth;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 17d425067d27..5fc281b60515 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2551,7 +2551,7 @@ static int do_tcp_setsockopt(struct sock *sk, int lev=
el,
 	case TCP_REPAIR_QUEUE:
 		if (!tp->repair)
 			err =3D -EPERM;
-		else if (val < TCP_QUEUES_NR)
+		else if ((unsigned int)val < TCP_QUEUES_NR)
 			tp->repair_queue =3D val;
 		else
 			err =3D -EINVAL;
@@ -2683,8 +2683,10 @@ static int do_tcp_setsockopt(struct sock *sk, int le=
vel,
=20
 #ifdef CONFIG_TCP_MD5SIG
 	case TCP_MD5SIG:
-		/* Read the IP->Key mappings from userspace */
-		err =3D tp->af_specific->md5_parse(sk, optval, optlen);
+		if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
+			err =3D tp->af_specific->md5_parse(sk, optval, optlen);
+		else
+			err =3D -EINVAL;
 		break;
 #endif
 	case TCP_USER_TIMEOUT:
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9a36ff6346f2..00ffa3d3bcae 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3675,11 +3675,8 @@ const u8 *tcp_parse_md5sig_option(const struct tcphd=
r *th)
 	int length =3D (th->doff << 2) - sizeof(*th);
 	const u8 *ptr =3D (const u8 *)(th + 1);
=20
-	/* If the TCP option is too short, we can short cut */
-	if (length < TCPOLEN_MD5SIG)
-		return NULL;
-
-	while (length > 0) {
+	/* If not enough data remaining, we can short cut */
+	while (length >=3D TCPOLEN_MD5SIG) {
 		int opcode =3D *ptr++;
 		int opsize;
=20
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 52d89fc2b297..0d7ed41b40be 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2450,8 +2450,10 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_=
buff *skb)
 		return -EBUSY;
=20
 	if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
-		if (before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))
-			BUG();
+		if (unlikely(before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))) {
+			WARN_ON_ONCE(1);
+			return -EINVAL;
+		}
 		if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq))
 			return -ENOMEM;
 	}
@@ -2948,6 +2950,7 @@ static void tcp_connect_init(struct sock *sk)
 	sock_reset_flag(sk, SOCK_DONE);
 	tp->snd_wnd =3D 0;
 	tcp_init_wl(tp, 0);
+	tcp_write_queue_purge(sk);
 	tp->snd_una =3D tp->write_seq;
 	tp->snd_sml =3D tp->write_seq;
 	tp->snd_up =3D tp->write_seq;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 41c96cacdbaa..183531ca499d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -997,8 +997,10 @@ int udp_sendmsg(struct kiocb *iocb, struct sock *sk, s=
truct msghdr *msg,
 	ipc.addr =3D faddr =3D daddr;
=20
 	if (ipc.opt && ipc.opt->opt.srr) {
-		if (!daddr)
-			return -EINVAL;
+		if (!daddr) {
+			err =3D -EINVAL;
+			goto out_free;
+		}
 		faddr =3D ipc.opt->opt.faddr;
 		connected =3D 0;
 	}
@@ -1103,6 +1105,7 @@ int udp_sendmsg(struct kiocb *iocb, struct sock *sk, =
struct msghdr *msg,
=20
 out:
 	ip_rt_put(rt);
+out_free:
 	if (free)
 		kfree(ipc.opt);
 	if (!err)
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b277098ed426..3597cfe5416f 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -318,11 +318,13 @@ static struct ip6_tnl *ip6gre_tunnel_locate(struct ne=
t *net,
 	if (t || !create)
 		return t;
=20
-	if (parms->name[0])
+	if (parms->name[0]) {
+		if (!dev_valid_name(parms->name))
+			return NULL;
 		strlcpy(name, parms->name, IFNAMSIZ);
-	else
+	} else {
 		strcpy(name, "ip6gre%d");
-
+	}
 	dev =3D alloc_netdev(sizeof(*t), name, ip6gre_tunnel_setup);
 	if (!dev)
 		return NULL;
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 0d30c9192da3..a94432384bc4 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1453,7 +1453,8 @@ int ip6_append_data(struct sock *sk, int getfrag(void=
 *from, char *to,
 		if (copy > length)
 			copy =3D length;
=20
-		if (!(rt->dst.dev->features&NETIF_F_SG)) {
+		if (!(rt->dst.dev->features&NETIF_F_SG) &&
+		    skb_tailroom(skb) >=3D copy) {
 			unsigned int off;
=20
 			off =3D skb->len;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 88a2d0ce326e..28736de12459 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -307,11 +307,13 @@ static struct ip6_tnl *ip6_tnl_create(struct net *net=
, struct __ip6_tnl_parm *p)
 	char name[IFNAMSIZ];
 	int err;
=20
-	if (p->name[0])
+	if (p->name[0]) {
+		if (!dev_valid_name(p->name))
+			goto failed;
 		strlcpy(name, p->name, IFNAMSIZ);
-	else
+	} else {
 		sprintf(name, "ip6tnl%%d");
-
+	}
 	dev =3D alloc_netdev(sizeof (*t), name, ip6_tnl_dev_setup);
 	if (dev =3D=3D NULL)
 		goto failed;
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index de67f5bd9bf9..922353050495 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -195,10 +195,13 @@ static struct ip6_tnl *vti6_tnl_create(struct net *ne=
t, struct __ip6_tnl_parm *p
 	char name[IFNAMSIZ];
 	int err;
=20
-	if (p->name[0])
+	if (p->name[0]) {
+		if (!dev_valid_name(p->name))
+			goto failed;
 		strlcpy(name, p->name, IFNAMSIZ);
-	else
+	} else {
 		sprintf(name, "ip6_vti%%d");
+	}
=20
 	dev =3D alloc_netdev(sizeof(*t), name, vti6_dev_setup);
 	if (dev =3D=3D NULL)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index d791d769d858..0086660a5370 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2344,11 +2344,13 @@ void rt6_mtu_change(struct net_device *dev, unsigne=
d int mtu)
=20
 static const struct nla_policy rtm_ipv6_policy[RTA_MAX+1] =3D {
 	[RTA_GATEWAY]           =3D { .len =3D sizeof(struct in6_addr) },
+	[RTA_PREFSRC]		=3D { .len =3D sizeof(struct in6_addr) },
 	[RTA_OIF]               =3D { .type =3D NLA_U32 },
 	[RTA_IIF]		=3D { .type =3D NLA_U32 },
 	[RTA_PRIORITY]          =3D { .type =3D NLA_U32 },
 	[RTA_METRICS]           =3D { .type =3D NLA_NESTED },
 	[RTA_MULTIPATH]		=3D { .len =3D sizeof(struct rtnexthop) },
+	[RTA_TABLE]		=3D { .type =3D NLA_U32 },
 };
=20
 static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 96b442ea904a..65597cf87c47 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -244,11 +244,13 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct n=
et *net,
 	if (!create)
 		goto failed;
=20
-	if (parms->name[0])
+	if (parms->name[0]) {
+		if (!dev_valid_name(parms->name))
+			goto failed;
 		strlcpy(name, parms->name, IFNAMSIZ);
-	else
+	} else {
 		strcpy(name, "sit%d");
-
+	}
 	dev =3D alloc_netdev(sizeof(*t), name, ipip6_tunnel_setup);
 	if (dev =3D=3D NULL)
 		return NULL;
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index b7a06749fa11..e79ad58d628f 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -128,7 +128,7 @@ _decode_session6(struct sk_buff *skb, struct flowi *fl,=
 int reverse)
 {
 	struct flowi6 *fl6 =3D &fl->u.ip6;
 	int onlyproto =3D 0;
-	u16 offset =3D skb_network_header_len(skb);
+	u32 offset =3D skb_network_header_len(skb);
 	const struct ipv6hdr *hdr =3D ipv6_hdr(skb);
 	struct ipv6_opt_hdr *exthdr;
 	const unsigned char *nh =3D skb_network_header(skb);
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 0ea33a9f7dfd..8cd87fbef291 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -231,6 +231,26 @@ struct l2tp_tunnel *l2tp_tunnel_get(const struct net *=
net, u32 tunnel_id)
 }
 EXPORT_SYMBOL_GPL(l2tp_tunnel_get);
=20
+struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth)
+{
+	const struct l2tp_net *pn =3D l2tp_pernet(net);
+	struct l2tp_tunnel *tunnel;
+	int count =3D 0;
+
+	rcu_read_lock_bh();
+	list_for_each_entry_rcu(tunnel, &pn->l2tp_tunnel_list, list) {
+		if (++count > nth) {
+			l2tp_tunnel_inc_refcount(tunnel);
+			rcu_read_unlock_bh();
+			return tunnel;
+		}
+	}
+	rcu_read_unlock_bh();
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(l2tp_tunnel_get_nth);
+
 /* Like l2tp_session_find() but takes a reference on the returned session.
  * Optionally calls session->ref() too if do_ref is true.
  */
@@ -395,46 +415,6 @@ int l2tp_session_register(struct l2tp_session *session,
 }
 EXPORT_SYMBOL_GPL(l2tp_session_register);
=20
-/* Lookup a tunnel by id
- */
-struct l2tp_tunnel *l2tp_tunnel_find(struct net *net, u32 tunnel_id)
-{
-	struct l2tp_tunnel *tunnel;
-	struct l2tp_net *pn =3D l2tp_pernet(net);
-
-	rcu_read_lock_bh();
-	list_for_each_entry_rcu(tunnel, &pn->l2tp_tunnel_list, list) {
-		if (tunnel->tunnel_id =3D=3D tunnel_id) {
-			rcu_read_unlock_bh();
-			return tunnel;
-		}
-	}
-	rcu_read_unlock_bh();
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(l2tp_tunnel_find);
-
-struct l2tp_tunnel *l2tp_tunnel_find_nth(struct net *net, int nth)
-{
-	struct l2tp_net *pn =3D l2tp_pernet(net);
-	struct l2tp_tunnel *tunnel;
-	int count =3D 0;
-
-	rcu_read_lock_bh();
-	list_for_each_entry_rcu(tunnel, &pn->l2tp_tunnel_list, list) {
-		if (++count > nth) {
-			rcu_read_unlock_bh();
-			return tunnel;
-		}
-	}
-
-	rcu_read_unlock_bh();
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(l2tp_tunnel_find_nth);
-
 /*************************************************************************=
****
  * Receive data handling
  *************************************************************************=
****/
@@ -1560,74 +1540,11 @@ int l2tp_tunnel_create(struct net *net, int fd, int=
 version, u32 tunnel_id, u32
 {
 	struct l2tp_tunnel *tunnel =3D NULL;
 	int err;
-	struct socket *sock =3D NULL;
-	struct sock *sk =3D NULL;
-	struct l2tp_net *pn;
 	enum l2tp_encap_type encap =3D L2TP_ENCAPTYPE_UDP;
=20
-	/* Get the tunnel socket from the fd, which was opened by
-	 * the userspace L2TP daemon. If not specified, create a
-	 * kernel socket.
-	 */
-	if (fd < 0) {
-		err =3D l2tp_tunnel_sock_create(net, tunnel_id, peer_tunnel_id,
-				cfg, &sock);
-		if (err < 0)
-			goto err;
-	} else {
-		sock =3D sockfd_lookup(fd, &err);
-		if (!sock) {
-			pr_err("tunl %u: sockfd_lookup(fd=3D%d) returned %d\n",
-			       tunnel_id, fd, err);
-			err =3D -EBADF;
-			goto err;
-		}
-
-		/* Reject namespace mismatches */
-		if (!net_eq(sock_net(sock->sk), net)) {
-			pr_err("tunl %u: netns mismatch\n", tunnel_id);
-			err =3D -EINVAL;
-			goto err;
-		}
-	}
-
-	sk =3D sock->sk;
-
 	if (cfg !=3D NULL)
 		encap =3D cfg->encap;
=20
-	/* Quick sanity checks */
-	err =3D -EPROTONOSUPPORT;
-	if (sk->sk_type !=3D SOCK_DGRAM) {
-		pr_debug("tunl %hu: fd %d wrong socket type\n",
-			 tunnel_id, fd);
-		goto err;
-	}
-	switch (encap) {
-	case L2TP_ENCAPTYPE_UDP:
-		if (sk->sk_protocol !=3D IPPROTO_UDP) {
-			pr_err("tunl %hu: fd %d wrong protocol, got %d, expected %d\n",
-			       tunnel_id, fd, sk->sk_protocol, IPPROTO_UDP);
-			goto err;
-		}
-		break;
-	case L2TP_ENCAPTYPE_IP:
-		if (sk->sk_protocol !=3D IPPROTO_L2TP) {
-			pr_err("tunl %hu: fd %d wrong protocol, got %d, expected %d\n",
-			       tunnel_id, fd, sk->sk_protocol, IPPROTO_L2TP);
-			goto err;
-		}
-		break;
-	}
-
-	/* Check if this socket has already been prepped */
-	tunnel =3D l2tp_tunnel(sk);
-	if (tunnel !=3D NULL) {
-		/* This socket has already been prepped */
-		err =3D -EBUSY;
-		goto err;
-	}
-
 	tunnel =3D kzalloc(sizeof(struct l2tp_tunnel), GFP_KERNEL);
 	if (tunnel =3D=3D NULL) {
 		err =3D -ENOMEM;
@@ -1644,17 +1561,93 @@ int l2tp_tunnel_create(struct net *net, int fd, int=
 version, u32 tunnel_id, u32
 	rwlock_init(&tunnel->hlist_lock);
 	tunnel->acpt_newsess =3D true;
=20
-	/* The net we belong to */
-	tunnel->l2tp_net =3D net;
-	pn =3D l2tp_pernet(net);
-
 	if (cfg !=3D NULL)
 		tunnel->debug =3D cfg->debug;
=20
-	/* Mark socket as an encapsulation socket. See net/ipv4/udp.c */
 	tunnel->encap =3D encap;
-	if (encap =3D=3D L2TP_ENCAPTYPE_UDP) {
-		/* Mark socket as an encapsulation socket. See net/ipv4/udp.c */
+
+	atomic_set(&tunnel->ref_count, 1);
+	tunnel->fd =3D fd;
+
+	/* Init delete workqueue struct */
+	INIT_WORK(&tunnel->del_work, l2tp_tunnel_del_work);
+
+	INIT_LIST_HEAD(&tunnel->list);
+
+	err =3D 0;
+err:
+	if (tunnelp)
+		*tunnelp =3D tunnel;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(l2tp_tunnel_create);
+
+static int l2tp_validate_socket(const struct sock *sk, const struct net *n=
et,
+				enum l2tp_encap_type encap)
+{
+	if (!net_eq(sock_net(sk), net))
+		return -EINVAL;
+
+	if (sk->sk_type !=3D SOCK_DGRAM)
+		return -EPROTONOSUPPORT;
+
+	if ((encap =3D=3D L2TP_ENCAPTYPE_UDP && sk->sk_protocol !=3D IPPROTO_UDP)=
 ||
+	    (encap =3D=3D L2TP_ENCAPTYPE_IP && sk->sk_protocol !=3D IPPROTO_L2TP))
+		return -EPROTONOSUPPORT;
+
+	if (sk->sk_user_data)
+		return -EBUSY;
+
+	return 0;
+}
+
+int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
+			 struct l2tp_tunnel_cfg *cfg)
+{
+	struct l2tp_tunnel *tunnel_walk;
+	struct l2tp_net *pn;
+	struct socket *sock;
+	struct sock *sk;
+	int ret;
+
+	if (tunnel->fd < 0) {
+		ret =3D l2tp_tunnel_sock_create(net, tunnel->tunnel_id,
+					      tunnel->peer_tunnel_id, cfg,
+					      &sock);
+		if (ret < 0)
+			goto err;
+	} else {
+		sock =3D sockfd_lookup(tunnel->fd, &ret);
+		if (!sock)
+			goto err;
+
+		ret =3D l2tp_validate_socket(sock->sk, net, tunnel->encap);
+		if (ret < 0)
+			goto err_sock;
+	}
+
+	sk =3D sock->sk;
+
+	sock_hold(sk);
+	tunnel->sock =3D sk;
+	tunnel->l2tp_net =3D net;
+
+	pn =3D l2tp_pernet(net);
+
+	spin_lock_bh(&pn->l2tp_tunnel_list_lock);
+	list_for_each_entry(tunnel_walk, &pn->l2tp_tunnel_list, list) {
+		if (tunnel_walk->tunnel_id =3D=3D tunnel->tunnel_id) {
+			spin_unlock_bh(&pn->l2tp_tunnel_list_lock);
+
+			ret =3D -EEXIST;
+			goto err_sock;
+		}
+	}
+	list_add_rcu(&tunnel->list, &pn->l2tp_tunnel_list);
+	spin_unlock_bh(&pn->l2tp_tunnel_list_lock);
+
+	if (tunnel->encap =3D=3D L2TP_ENCAPTYPE_UDP) {
 		udp_sk(sk)->encap_type =3D UDP_ENCAP_L2TPINUDP;
 		udp_sk(sk)->encap_rcv =3D l2tp_udp_encap_recv;
 		udp_sk(sk)->encap_destroy =3D l2tp_udp_encap_destroy;
@@ -1668,49 +1661,26 @@ int l2tp_tunnel_create(struct net *net, int fd, int=
 version, u32 tunnel_id, u32
=20
 	sk->sk_user_data =3D tunnel;
=20
-	/* Bump the reference count. The tunnel context is deleted
-	 * only when this drops to zero. A reference is also held on
-	 * the tunnel socket to ensure that it is not released while
-	 * the tunnel is extant. Must be done before sk_destruct is
-	 * set.
-	 */
-	atomic_set(&tunnel->ref_count, 1);
-	sock_hold(sk);
-	tunnel->sock =3D sk;
-	tunnel->fd =3D fd;
-
-	/* Hook on the tunnel socket destructor so that we can cleanup
-	 * if the tunnel socket goes away.
-	 */
 	tunnel->old_sk_destruct =3D sk->sk_destruct;
 	sk->sk_destruct =3D &l2tp_tunnel_destruct;
-	lockdep_set_class_and_name(&sk->sk_lock.slock, &l2tp_socket_class, "l2tp_=
sock");
-
+	lockdep_set_class_and_name(&sk->sk_lock.slock, &l2tp_socket_class,
+				   "l2tp_sock");
 	sk->sk_allocation =3D GFP_ATOMIC;
=20
-	/* Init delete workqueue struct */
-	INIT_WORK(&tunnel->del_work, l2tp_tunnel_del_work);
-
-	/* Add tunnel to our list */
-	INIT_LIST_HEAD(&tunnel->list);
-	spin_lock_bh(&pn->l2tp_tunnel_list_lock);
-	list_add_rcu(&tunnel->list, &pn->l2tp_tunnel_list);
-	spin_unlock_bh(&pn->l2tp_tunnel_list_lock);
+	if (tunnel->fd >=3D 0)
+		sockfd_put(sock);
=20
-	err =3D 0;
-err:
-	if (tunnelp)
-		*tunnelp =3D tunnel;
+	return 0;
=20
-	/* If tunnel's socket was created by the kernel, it doesn't
-	 *  have a file.
-	 */
-	if (sock && sock->file)
+err_sock:
+	if (tunnel->fd < 0)
+		sock_release(sock);
+	else
 		sockfd_put(sock);
-
-	return err;
+err:
+	return ret;
 }
-EXPORT_SYMBOL_GPL(l2tp_tunnel_create);
+EXPORT_SYMBOL_GPL(l2tp_tunnel_register);
=20
 /* This function is used by the netlink TUNNEL_DELETE command.
  */
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 48e19b58e334..eb80a6c4ba08 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -227,6 +227,8 @@ static inline void *l2tp_session_priv(struct l2tp_sessi=
on *session)
 }
=20
 struct l2tp_tunnel *l2tp_tunnel_get(const struct net *net, u32 tunnel_id);
+struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth);
+
 void l2tp_tunnel_free(struct l2tp_tunnel *tunnel);
=20
 struct l2tp_session *l2tp_session_get(const struct net *net,
@@ -240,12 +242,13 @@ struct l2tp_session *l2tp_session_get_nth(struct l2tp=
_tunnel *tunnel, int nth,
 struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 						const char *ifname,
 						bool do_ref);
-struct l2tp_tunnel *l2tp_tunnel_find(struct net *net, u32 tunnel_id);
-struct l2tp_tunnel *l2tp_tunnel_find_nth(struct net *net, int nth);
=20
 int l2tp_tunnel_create(struct net *net, int fd, int version, u32 tunnel_id,
 		       u32 peer_tunnel_id, struct l2tp_tunnel_cfg *cfg,
 		       struct l2tp_tunnel **tunnelp);
+int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
+			 struct l2tp_tunnel_cfg *cfg);
+
 void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel);
 void l2tp_tunnel_delete(struct l2tp_tunnel *tunnel);
 struct l2tp_session *l2tp_session_create(int priv_size,
diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
index d100aed3d06f..467aeb3f33a1 100644
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -47,7 +47,11 @@ struct l2tp_dfs_seq_data {
=20
 static void l2tp_dfs_next_tunnel(struct l2tp_dfs_seq_data *pd)
 {
-	pd->tunnel =3D l2tp_tunnel_find_nth(pd->net, pd->tunnel_idx);
+	/* Drop reference taken during previous invocation */
+	if (pd->tunnel)
+		l2tp_tunnel_dec_refcount(pd->tunnel);
+
+	pd->tunnel =3D l2tp_tunnel_get_nth(pd->net, pd->tunnel_idx);
 	pd->tunnel_idx++;
 }
=20
@@ -96,7 +100,17 @@ static void *l2tp_dfs_seq_next(struct seq_file *m, void=
 *v, loff_t *pos)
=20
 static void l2tp_dfs_seq_stop(struct seq_file *p, void *v)
 {
-	/* nothing to do */
+	struct l2tp_dfs_seq_data *pd =3D v;
+
+	if (!pd || pd =3D=3D SEQ_START_TOKEN)
+		return;
+
+	/* Drop reference taken by last invocation of l2tp_dfs_next_tunnel() */
+	if (pd->tunnel) {
+		l2tp_tunnel_dec_refcount(pd->tunnel);
+		pd->tunnel =3D NULL;
+		pd->session =3D NULL;
+	}
 }
=20
 static void l2tp_dfs_seq_tunnel_show(struct seq_file *m, void *v)
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 0fc9e31d1edc..a8b4da65a7ed 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -177,12 +177,6 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *s=
kb, struct genl_info *info
 	if (info->attrs[L2TP_ATTR_DEBUG])
 		cfg.debug =3D nla_get_u32(info->attrs[L2TP_ATTR_DEBUG]);
=20
-	tunnel =3D l2tp_tunnel_find(net, tunnel_id);
-	if (tunnel !=3D NULL) {
-		ret =3D -EEXIST;
-		goto out;
-	}
-
 	ret =3D -EINVAL;
 	switch (cfg.encap) {
 	case L2TP_ENCAPTYPE_UDP:
@@ -192,6 +186,17 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *s=
kb, struct genl_info *info
 		break;
 	}
=20
+	if (ret < 0)
+		goto out;
+
+	l2tp_tunnel_inc_refcount(tunnel);
+	ret =3D l2tp_tunnel_register(tunnel, net, &cfg);
+	if (ret < 0) {
+		kfree(tunnel);
+		goto out;
+	}
+	l2tp_tunnel_dec_refcount(tunnel);
+
 out:
 	return ret;
 }
@@ -390,14 +395,17 @@ static int l2tp_nl_cmd_tunnel_dump(struct sk_buff *sk=
b, struct netlink_callback
 	struct net *net =3D sock_net(skb->sk);
=20
 	for (;;) {
-		tunnel =3D l2tp_tunnel_find_nth(net, ti);
+		tunnel =3D l2tp_tunnel_get_nth(net, ti);
 		if (tunnel =3D=3D NULL)
 			goto out;
=20
 		if (l2tp_nl_tunnel_send(skb, NETLINK_CB(cb->skb).portid,
 					cb->nlh->nlmsg_seq, NLM_F_MULTI,
-					tunnel) <=3D 0)
+					tunnel) <=3D 0) {
+			l2tp_tunnel_dec_refcount(tunnel);
 			goto out;
+		}
+		l2tp_tunnel_dec_refcount(tunnel);
=20
 		ti++;
 	}
@@ -741,7 +749,7 @@ static int l2tp_nl_cmd_session_dump(struct sk_buff *skb=
, struct netlink_callback
=20
 	for (;;) {
 		if (tunnel =3D=3D NULL) {
-			tunnel =3D l2tp_tunnel_find_nth(net, ti);
+			tunnel =3D l2tp_tunnel_get_nth(net, ti);
 			if (tunnel =3D=3D NULL)
 				goto out;
 		}
@@ -749,6 +757,7 @@ static int l2tp_nl_cmd_session_dump(struct sk_buff *skb=
, struct netlink_callback
 		session =3D l2tp_session_get_nth(tunnel, si, false);
 		if (session =3D=3D NULL) {
 			ti++;
+			l2tp_tunnel_dec_refcount(tunnel);
 			tunnel =3D NULL;
 			si =3D 0;
 			continue;
@@ -758,6 +767,7 @@ static int l2tp_nl_cmd_session_dump(struct sk_buff *skb=
, struct netlink_callback
 					 cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					 session) <=3D 0) {
 			l2tp_session_dec_refcount(session);
+			l2tp_tunnel_dec_refcount(tunnel);
 			break;
 		}
 		l2tp_session_dec_refcount(session);
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 6ac543b1330b..e07100e49fa3 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -641,6 +641,13 @@ static int pppol2tp_connect(struct socket *sock, struc=
t sockaddr *uservaddr,
 	lock_sock(sk);
=20
 	error =3D -EINVAL;
+
+	if (sockaddr_len !=3D sizeof(struct sockaddr_pppol2tp) &&
+	    sockaddr_len !=3D sizeof(struct sockaddr_pppol2tpv3) &&
+	    sockaddr_len !=3D sizeof(struct sockaddr_pppol2tpin6) &&
+	    sockaddr_len !=3D sizeof(struct sockaddr_pppol2tpv3in6))
+		goto end;
+
 	if (sp->sa_protocol !=3D PX_PROTO_OL2TP)
 		goto end;
=20
@@ -720,6 +727,15 @@ static int pppol2tp_connect(struct socket *sock, struc=
t sockaddr *uservaddr,
 			error =3D l2tp_tunnel_create(sock_net(sk), fd, ver, tunnel_id, peer_tun=
nel_id, &tcfg, &tunnel);
 			if (error < 0)
 				goto end;
+
+			l2tp_tunnel_inc_refcount(tunnel);
+			error =3D l2tp_tunnel_register(tunnel, sock_net(sk),
+						     &tcfg);
+			if (error < 0) {
+				kfree(tunnel);
+				goto end;
+			}
+			drop_tunnel =3D true;
 		}
 	} else {
 		/* Error if we can't find the tunnel */
@@ -1574,16 +1590,19 @@ struct pppol2tp_seq_data {
=20
 static void pppol2tp_next_tunnel(struct net *net, struct pppol2tp_seq_data=
 *pd)
 {
+	/* Drop reference taken during previous invocation */
+	if (pd->tunnel)
+		l2tp_tunnel_dec_refcount(pd->tunnel);
+
 	for (;;) {
-		pd->tunnel =3D l2tp_tunnel_find_nth(net, pd->tunnel_idx);
+		pd->tunnel =3D l2tp_tunnel_get_nth(net, pd->tunnel_idx);
 		pd->tunnel_idx++;
=20
-		if (pd->tunnel =3D=3D NULL)
-			break;
+		/* Only accept L2TPv2 tunnels */
+		if (!pd->tunnel || pd->tunnel->version =3D=3D 2)
+			return;
=20
-		/* Ignore L2TPv3 tunnels */
-		if (pd->tunnel->version < 3)
-			break;
+		l2tp_tunnel_dec_refcount(pd->tunnel);
 	}
 }
=20
@@ -1632,7 +1651,17 @@ static void *pppol2tp_seq_next(struct seq_file *m, v=
oid *v, loff_t *pos)
=20
 static void pppol2tp_seq_stop(struct seq_file *p, void *v)
 {
-	/* nothing to do */
+	struct pppol2tp_seq_data *pd =3D v;
+
+	if (!pd || pd =3D=3D SEQ_START_TOKEN)
+		return;
+
+	/* Drop reference taken by last invocation of pppol2tp_next_tunnel() */
+	if (pd->tunnel) {
+		l2tp_tunnel_dec_refcount(pd->tunnel);
+		pd->tunnel =3D NULL;
+		pd->session =3D NULL;
+	}
 }
=20
 static void pppol2tp_seq_tunnel_show(struct seq_file *m, void *v)
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index a76a67d38ec3..9735705f0618 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -197,9 +197,19 @@ static int llc_ui_release(struct socket *sock)
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, sk->sk_rcvtimeo);
-	if (!sock_flag(sk, SOCK_ZAPPED))
+	if (!sock_flag(sk, SOCK_ZAPPED)) {
+		struct llc_sap *sap =3D llc->sap;
+
+		/* Hold this for release_sock(), so that llc_backlog_rcv()
+		 * could still use it.
+		 */
+		llc_sap_hold(sap);
 		llc_sap_remove_socket(llc->sap, sk);
-	release_sock(sk);
+		release_sock(sk);
+		llc_sap_put(sap);
+	} else {
+		release_sock(sk);
+	}
 	if (llc->dev)
 		dev_put(llc->dev);
 	sock_put(sk);
@@ -915,6 +925,9 @@ static int llc_ui_sendmsg(struct kiocb *iocb, struct so=
cket *sock,
 	if (size > llc->dev->mtu)
 		size =3D llc->dev->mtu;
 	copied =3D size - hdrlen;
+	rc =3D -EINVAL;
+	if (copied < 0)
+		goto release;
 	release_sock(sk);
 	skb =3D sock_alloc_send_skb(sk, size, noblock, &rc);
 	lock_sock(sk);
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_cor=
e.c
index 4ae958906a6b..963019520174 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -118,6 +118,8 @@ ip_vs_in_stats(struct ip_vs_conn *cp, struct sk_buff *s=
kb)
 		struct ip_vs_cpu_stats *s;
 		struct ip_vs_service *svc;
=20
+		local_bh_disable();
+
 		s =3D this_cpu_ptr(dest->stats.cpustats);
 		s->ustats.inpkts++;
 		u64_stats_update_begin(&s->syncp);
@@ -138,6 +140,8 @@ ip_vs_in_stats(struct ip_vs_conn *cp, struct sk_buff *s=
kb)
 		u64_stats_update_begin(&s->syncp);
 		s->ustats.inbytes +=3D skb->len;
 		u64_stats_update_end(&s->syncp);
+
+		local_bh_enable();
 	}
 }
=20
@@ -152,6 +156,8 @@ ip_vs_out_stats(struct ip_vs_conn *cp, struct sk_buff *=
skb)
 		struct ip_vs_cpu_stats *s;
 		struct ip_vs_service *svc;
=20
+		local_bh_disable();
+
 		s =3D this_cpu_ptr(dest->stats.cpustats);
 		s->ustats.outpkts++;
 		u64_stats_update_begin(&s->syncp);
@@ -172,6 +178,8 @@ ip_vs_out_stats(struct ip_vs_conn *cp, struct sk_buff *=
skb)
 		u64_stats_update_begin(&s->syncp);
 		s->ustats.outbytes +=3D skb->len;
 		u64_stats_update_end(&s->syncp);
+
+		local_bh_enable();
 	}
 }
=20
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 7311cc206d0f..509405afd174 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2417,12 +2417,19 @@ do_ip_vs_set_ctl(struct sock *sk, int cmd, void __u=
ser *user, unsigned int len)
 		}
 	}
=20
+	if ((cmd =3D=3D IP_VS_SO_SET_ADD || cmd =3D=3D IP_VS_SO_SET_EDIT) &&
+	    strnlen(usvc.sched_name, IP_VS_SCHEDNAME_MAXLEN) =3D=3D
+	    IP_VS_SCHEDNAME_MAXLEN) {
+		ret =3D -EINVAL;
+		goto out_unlock;
+	}
+
 	/* Check for valid protocol: TCP or UDP or SCTP, even for fwmark!=3D0 */
 	if (usvc.protocol !=3D IPPROTO_TCP && usvc.protocol !=3D IPPROTO_UDP &&
 	    usvc.protocol !=3D IPPROTO_SCTP) {
-		pr_err("set_ctl: invalid protocol: %d %pI4:%d %s\n",
+		pr_err("set_ctl: invalid protocol: %d %pI4:%d\n",
 		       usvc.protocol, &usvc.addr.ip,
-		       ntohs(usvc.port), usvc.sched_name);
+		       ntohs(usvc.port));
 		ret =3D -EFAULT;
 		goto out_unlock;
 	}
@@ -2845,7 +2852,7 @@ static const struct nla_policy ip_vs_cmd_policy[IPVS_=
CMD_ATTR_MAX + 1] =3D {
 static const struct nla_policy ip_vs_daemon_policy[IPVS_DAEMON_ATTR_MAX + =
1] =3D {
 	[IPVS_DAEMON_ATTR_STATE]	=3D { .type =3D NLA_U32 },
 	[IPVS_DAEMON_ATTR_MCAST_IFN]	=3D { .type =3D NLA_NUL_STRING,
-					    .len =3D IP_VS_IFNAME_MAXLEN },
+					    .len =3D IP_VS_IFNAME_MAXLEN - 1 },
 	[IPVS_DAEMON_ATTR_SYNC_ID]	=3D { .type =3D NLA_U32 },
 };
=20
@@ -2858,7 +2865,7 @@ static const struct nla_policy ip_vs_svc_policy[IPVS_=
SVC_ATTR_MAX + 1] =3D {
 	[IPVS_SVC_ATTR_PORT]		=3D { .type =3D NLA_U16 },
 	[IPVS_SVC_ATTR_FWMARK]		=3D { .type =3D NLA_U32 },
 	[IPVS_SVC_ATTR_SCHED_NAME]	=3D { .type =3D NLA_NUL_STRING,
-					    .len =3D IP_VS_SCHEDNAME_MAXLEN },
+					    .len =3D IP_VS_SCHEDNAME_MAXLEN - 1 },
 	[IPVS_SVC_ATTR_PE_NAME]		=3D { .type =3D NLA_NUL_STRING,
 					    .len =3D IP_VS_PENAME_MAXLEN },
 	[IPVS_SVC_ATTR_FLAGS]		=3D { .type =3D NLA_BINARY,
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_syn=
c.c
index a108953a8c2c..a198b664ed9a 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1738,8 +1738,9 @@ int start_sync_thread(struct net *net, int state, cha=
r *mcast_ifn, __u8 syncid)
 		if (ipvs->ms)
 			return -EEXIST;
=20
-		strlcpy(ipvs->master_mcast_ifn, mcast_ifn,
-			sizeof(ipvs->master_mcast_ifn));
+		if (strscpy(ipvs->master_mcast_ifn, mcast_ifn,
+			    sizeof(ipvs->master_mcast_ifn)) <=3D 0)
+			return -EINVAL;
 		ipvs->master_syncid =3D syncid;
 		name =3D "ipvs-m:%d:%d";
 		threadfn =3D sync_thread_master;
@@ -1747,8 +1748,9 @@ int start_sync_thread(struct net *net, int state, cha=
r *mcast_ifn, __u8 syncid)
 		if (ipvs->backup_threads)
 			return -EEXIST;
=20
-		strlcpy(ipvs->backup_mcast_ifn, mcast_ifn,
-			sizeof(ipvs->backup_mcast_ifn));
+		if (strscpy(ipvs->backup_mcast_ifn, mcast_ifn,
+			    sizeof(ipvs->backup_mcast_ifn)) <=3D 0)
+			return -EINVAL;
 		ipvs->backup_syncid =3D syncid;
 		name =3D "ipvs-b:%d:%d";
 		threadfn =3D sync_thread_backup;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0ae0662ce385..b834cd9232c4 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1829,41 +1829,46 @@ static int nf_tables_newrule(struct sock *nlsk, str=
uct sk_buff *skb,
 	}
=20
 	if (nlh->nlmsg_flags & NLM_F_REPLACE) {
-		if (nft_rule_is_active_next(net, old_rule)) {
-			trans =3D nft_trans_rule_add(&ctx, NFT_MSG_DELRULE,
-						   old_rule);
-			if (trans =3D=3D NULL) {
-				err =3D -ENOMEM;
-				goto err2;
-			}
-			nft_rule_disactivate_next(net, old_rule);
-			chain->use--;
-			list_add_tail_rcu(&rule->list, &old_rule->list);
-		} else {
+		if (!nft_rule_is_active_next(net, old_rule)) {
 			err =3D -ENOENT;
 			goto err2;
 		}
-	} else if (nlh->nlmsg_flags & NLM_F_APPEND)
-		if (old_rule)
-			list_add_rcu(&rule->list, &old_rule->list);
-		else
-			list_add_tail_rcu(&rule->list, &chain->rules);
-	else {
-		if (old_rule)
-			list_add_tail_rcu(&rule->list, &old_rule->list);
-		else
-			list_add_rcu(&rule->list, &chain->rules);
-	}
+		trans =3D nft_trans_rule_add(&ctx, NFT_MSG_DELRULE,
+					   old_rule);
+		if (trans =3D=3D NULL) {
+			err =3D -ENOMEM;
+			goto err2;
+		}
+		nft_rule_disactivate_next(net, old_rule);
+		chain->use--;
=20
-	if (nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule) =3D=3D NULL) {
-		err =3D -ENOMEM;
-		goto err3;
+		if (nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule) =3D=3D NULL) {
+			err =3D -ENOMEM;
+			goto err2;
+		}
+
+		list_add_tail_rcu(&rule->list, &old_rule->list);
+	} else {
+		if (nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule) =3D=3D NULL) {
+			err =3D -ENOMEM;
+			goto err2;
+		}
+
+		if (nlh->nlmsg_flags & NLM_F_APPEND) {
+			if (old_rule)
+				list_add_rcu(&rule->list, &old_rule->list);
+			else
+				list_add_tail_rcu(&rule->list, &chain->rules);
+		 } else {
+			if (old_rule)
+				list_add_tail_rcu(&rule->list, &old_rule->list);
+			else
+				list_add_rcu(&rule->list, &chain->rules);
+		}
 	}
 	chain->use++;
 	return 0;
=20
-err3:
-	list_del_rcu(&rule->list);
 err2:
 	nf_tables_rule_destroy(&ctx, rule);
 err1:
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 95700e349463..555f5b6157f3 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1658,6 +1658,8 @@ static int netlink_sendmsg(struct kiocb *kiocb, struc=
t socket *sock,
=20
 	if (msg->msg_namelen) {
 		err =3D -EINVAL;
+		if (msg->msg_namelen < sizeof(struct sockaddr_nl))
+			goto out;
 		if (addr->nl_family !=3D AF_NETLINK)
 			goto out;
 		dst_portid =3D addr->nl_pid;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index de1af8ae1710..9dd4335edf59 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -343,11 +343,11 @@ static void packet_pick_tx_queue(struct net_device *d=
ev, struct sk_buff *skb)
 	skb_set_queue_mapping(skb, queue_index);
 }
=20
-/* register_prot_hook must be invoked with the po->bind_lock held,
+/* __register_prot_hook must be invoked through register_prot_hook
  * or from a context in which asynchronous accesses to the packet
  * socket is not possible (packet_create()).
  */
-static void register_prot_hook(struct sock *sk)
+static void __register_prot_hook(struct sock *sk)
 {
 	struct packet_sock *po =3D pkt_sk(sk);
=20
@@ -362,8 +362,13 @@ static void register_prot_hook(struct sock *sk)
 	}
 }
=20
-/* {,__}unregister_prot_hook() must be invoked with the po->bind_lock
- * held.   If the sync parameter is true, we will temporarily drop
+static void register_prot_hook(struct sock *sk)
+{
+	lockdep_assert_held_once(&pkt_sk(sk)->bind_lock);
+	__register_prot_hook(sk);
+}
+
+/* If the sync parameter is true, we will temporarily drop
  * the po->bind_lock and do a synchronize_net to make sure no
  * asynchronous packet processing paths still refer to the elements
  * of po->prot_hook.  If the sync parameter is false, it is the
@@ -373,6 +378,8 @@ static void __unregister_prot_hook(struct sock *sk, boo=
l sync)
 {
 	struct packet_sock *po =3D pkt_sk(sk);
=20
+	lockdep_assert_held_once(&po->bind_lock);
+
 	po->running =3D 0;
=20
 	if (po->fanout)
@@ -2651,6 +2658,7 @@ static int packet_release(struct socket *sock)
=20
 	packet_flush_mclist(sk);
=20
+	lock_sock(sk);
 	if (po->rx_ring.pg_vec) {
 		memset(&req_u, 0, sizeof(req_u));
 		packet_set_ring(sk, &req_u, 1, 0);
@@ -2660,6 +2668,7 @@ static int packet_release(struct socket *sock)
 		memset(&req_u, 0, sizeof(req_u));
 		packet_set_ring(sk, &req_u, 1, 1);
 	}
+	release_sock(sk);
=20
 	f =3D fanout_release(sk);
=20
@@ -2885,7 +2894,7 @@ static int packet_create(struct net *net, struct sock=
et *sock, int protocol,
=20
 	if (proto) {
 		po->prot_hook.type =3D proto;
-		register_prot_hook(sk);
+		__register_prot_hook(sk);
 	}
=20
 	mutex_lock(&net->packet.sklist_lock);
@@ -3295,6 +3304,7 @@ packet_setsockopt(struct socket *sock, int level, int=
 optname, char __user *optv
 		union tpacket_req_u req_u;
 		int len;
=20
+		lock_sock(sk);
 		switch (po->tp_version) {
 		case TPACKET_V1:
 		case TPACKET_V2:
@@ -3305,14 +3315,19 @@ packet_setsockopt(struct socket *sock, int level, i=
nt optname, char __user *optv
 			len =3D sizeof(req_u.req3);
 			break;
 		}
-		if (optlen < len)
-			return -EINVAL;
-		if (pkt_sk(sk)->has_vnet_hdr)
-			return -EINVAL;
-		if (copy_from_user(&req_u.req, optval, len))
-			return -EFAULT;
-		return packet_set_ring(sk, &req_u, 0,
-			optname =3D=3D PACKET_TX_RING);
+		if (optlen < len) {
+			ret =3D -EINVAL;
+		} else if (pkt_sk(sk)->has_vnet_hdr) {
+			ret =3D -EINVAL;
+		} else {
+			if (copy_from_user(&req_u.req, optval, len))
+				ret =3D -EFAULT;
+			else
+				ret =3D packet_set_ring(sk, &req_u, 0,
+						    optname =3D=3D PACKET_TX_RING);
+		}
+		release_sock(sk);
+		return ret;
 	}
 	case PACKET_COPY_THRESH:
 	{
@@ -3378,12 +3393,18 @@ packet_setsockopt(struct socket *sock, int level, i=
nt optname, char __user *optv
=20
 		if (optlen !=3D sizeof(val))
 			return -EINVAL;
-		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec)
-			return -EBUSY;
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
-		po->tp_loss =3D !!val;
-		return 0;
+
+		lock_sock(sk);
+		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec) {
+			ret =3D -EBUSY;
+		} else {
+			po->tp_loss =3D !!val;
+			ret =3D 0;
+		}
+		release_sock(sk);
+		return ret;
 	}
 	case PACKET_AUXDATA:
 	{
@@ -3394,7 +3415,9 @@ packet_setsockopt(struct socket *sock, int level, int=
 optname, char __user *optv
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
=20
+		lock_sock(sk);
 		po->auxdata =3D !!val;
+		release_sock(sk);
 		return 0;
 	}
 	case PACKET_ORIGDEV:
@@ -3406,7 +3429,9 @@ packet_setsockopt(struct socket *sock, int level, int=
 optname, char __user *optv
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
=20
+		lock_sock(sk);
 		po->origdev =3D !!val;
+		release_sock(sk);
 		return 0;
 	}
 	case PACKET_VNET_HDR:
@@ -3415,15 +3440,20 @@ packet_setsockopt(struct socket *sock, int level, i=
nt optname, char __user *optv
=20
 		if (sock->type !=3D SOCK_RAW)
 			return -EINVAL;
-		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec)
-			return -EBUSY;
 		if (optlen < sizeof(val))
 			return -EINVAL;
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
=20
-		po->has_vnet_hdr =3D !!val;
-		return 0;
+		lock_sock(sk);
+		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec) {
+			ret =3D -EBUSY;
+		} else {
+			po->has_vnet_hdr =3D !!val;
+			ret =3D 0;
+		}
+		release_sock(sk);
+		return ret;
 	}
 	case PACKET_TIMESTAMP:
 	{
@@ -3454,11 +3484,17 @@ packet_setsockopt(struct socket *sock, int level, i=
nt optname, char __user *optv
=20
 		if (optlen !=3D sizeof(val))
 			return -EINVAL;
-		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec)
-			return -EBUSY;
 		if (copy_from_user(&val, optval, sizeof(val)))
 			return -EFAULT;
-		po->tp_tx_has_off =3D !!val;
+
+		lock_sock(sk);
+		if (po->rx_ring.pg_vec || po->tx_ring.pg_vec) {
+			ret =3D -EBUSY;
+		} else {
+			po->tp_tx_has_off =3D !!val;
+			ret =3D 0;
+		}
+		release_sock(sk);
 		return 0;
 	}
 	case PACKET_QDISC_BYPASS:
@@ -3820,7 +3856,6 @@ static int packet_set_ring(struct sock *sk, union tpa=
cket_req_u *req_u,
 	/* Added to avoid minimal code churn */
 	struct tpacket_req *req =3D &req_u->req;
=20
-	lock_sock(sk);
 	/* Opening a Tx-ring is NOT supported in TPACKET_V3 */
 	if (!closing && tx_ring && (po->tp_version > TPACKET_V2)) {
 		WARN(1, "Tx-ring is not supported.\n");
@@ -3956,7 +3991,6 @@ static int packet_set_ring(struct sock *sk, union tpa=
cket_req_u *req_u,
 	if (pg_vec)
 		free_pg_vec(pg_vec, order, req->tp_block_nr);
 out:
-	release_sock(sk);
 	return err;
 }
=20
diff --git a/net/packet/internal.h b/net/packet/internal.h
index cdddf6a30399..68aa14802768 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -100,10 +100,12 @@ struct packet_sock {
 	int			copy_thresh;
 	spinlock_t		bind_lock;
 	struct mutex		pg_vec_lock;
-	unsigned int		running:1,	/* prot_hook is attached*/
-				auxdata:1,
+	unsigned int		running;	/* bind_lock must be held */
+	unsigned int		auxdata:1,	/* writer must hold sock lock */
 				origdev:1,
-				has_vnet_hdr:1;
+				has_vnet_hdr:1,
+				tp_loss:1,
+				tp_tx_has_off:1;
 	int			ifindex;	/* bound device		*/
 	__be16			num;
 	struct packet_mclist	*mclist;
@@ -111,8 +113,6 @@ struct packet_sock {
 	enum tpacket_versions	tp_version;
 	unsigned int		tp_hdrlen;
 	unsigned int		tp_reserve;
-	unsigned int		tp_loss:1;
-	unsigned int		tp_tx_has_off:1;
 	unsigned int		tp_tstamp;
 	struct net_device __rcu	*cached_dev;
 	int			(*xmit)(struct sk_buff *skb);
diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 14c98e48f261..54da0f8d46c4 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -134,13 +134,18 @@ static int rfkill_gpio_probe(struct platform_device *=
pdev)
=20
 	ret =3D rfkill_register(rfkill->rfkill_dev);
 	if (ret < 0)
-		return ret;
+		goto err_destroy;
=20
 	platform_set_drvdata(pdev, rfkill);
=20
 	dev_info(&pdev->dev, "%s device registered.\n", rfkill->name);
=20
 	return 0;
+
+err_destroy:
+	rfkill_destroy(rfkill->rfkill_dev);
+
+	return ret;
 }
=20
 static int rfkill_gpio_remove(struct platform_device *pdev)
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index bdcedfedc489..da3621feae74 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -124,6 +124,28 @@ static bool fq_flow_is_detached(const struct fq_flow *=
f)
 	return f->next =3D=3D &detached;
 }
=20
+static bool fq_flow_is_throttled(const struct fq_flow *f)
+{
+	return f->next =3D=3D &throttled;
+}
+
+static void fq_flow_add_tail(struct fq_flow_head *head, struct fq_flow *fl=
ow)
+{
+	if (head->first)
+		head->last->next =3D flow;
+	else
+		head->first =3D flow;
+	head->last =3D flow;
+	flow->next =3D NULL;
+}
+
+static void fq_flow_unset_throttled(struct fq_sched_data *q, struct fq_flo=
w *f)
+{
+	rb_erase(&f->rate_node, &q->delayed);
+	q->throttled_flows--;
+	fq_flow_add_tail(&q->old_flows, f);
+}
+
 static void fq_flow_set_throttled(struct fq_sched_data *q, struct fq_flow =
*f)
 {
 	struct rb_node **p =3D &q->delayed.rb_node, *parent =3D NULL;
@@ -151,15 +173,6 @@ static void fq_flow_set_throttled(struct fq_sched_data=
 *q, struct fq_flow *f)
=20
 static struct kmem_cache *fq_flow_cachep __read_mostly;
=20
-static void fq_flow_add_tail(struct fq_flow_head *head, struct fq_flow *fl=
ow)
-{
-	if (head->first)
-		head->last->next =3D flow;
-	else
-		head->first =3D flow;
-	head->last =3D flow;
-	flow->next =3D NULL;
-}
=20
 /* limit number of collected flows per round */
 #define FQ_GC_MAX 8
@@ -251,6 +264,8 @@ static struct fq_flow *fq_classify(struct sk_buff *skb,=
 struct fq_sched_data *q)
 				     f->socket_hash !=3D sk->sk_hash)) {
 				f->credit =3D q->initial_quantum;
 				f->socket_hash =3D sk->sk_hash;
+				if (fq_flow_is_throttled(f))
+					fq_flow_unset_throttled(q, f);
 				f->time_next_packet =3D 0ULL;
 			}
 			return f;
@@ -407,9 +422,7 @@ static void fq_check_throttled(struct fq_sched_data *q,=
 u64 now)
 			q->time_next_delayed_flow =3D f->time_next_packet;
 			break;
 		}
-		rb_erase(p, &q->delayed);
-		q->throttled_flows--;
-		fq_flow_add_tail(&q->old_flows, f);
+		fq_flow_unset_throttled(q, f);
 	}
 }
=20
diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 7e8a16c77039..8d9b7ad25b65 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -178,7 +178,7 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 	skb_pull(chunk->skb, sizeof(sctp_chunkhdr_t));
 	chunk->subh.v =3D NULL; /* Subheader is no longer valid.  */
=20
-	if (chunk->chunk_end + sizeof(sctp_chunkhdr_t) <
+	if (chunk->chunk_end + sizeof(sctp_chunkhdr_t) <=3D
 	    skb_tail_pointer(chunk->skb)) {
 		/* This is not a singleton */
 		chunk->singleton =3D 0;
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 4128c0d7f845..26a208ff25f1 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -496,46 +496,49 @@ static void sctp_v6_to_addr(union sctp_addr *addr, st=
ruct in6_addr *saddr,
 	addr->v6.sin6_scope_id =3D 0;
 }
=20
-/* Compare addresses exactly.
- * v4-mapped-v6 is also in consideration.
- */
-static int sctp_v6_cmp_addr(const union sctp_addr *addr1,
-			    const union sctp_addr *addr2)
+static int __sctp_v6_cmp_addr(const union sctp_addr *addr1,
+			      const union sctp_addr *addr2)
 {
 	if (addr1->sa.sa_family !=3D addr2->sa.sa_family) {
 		if (addr1->sa.sa_family =3D=3D AF_INET &&
 		    addr2->sa.sa_family =3D=3D AF_INET6 &&
-		    ipv6_addr_v4mapped(&addr2->v6.sin6_addr)) {
-			if (addr2->v6.sin6_port =3D=3D addr1->v4.sin_port &&
-			    addr2->v6.sin6_addr.s6_addr32[3] =3D=3D
-			    addr1->v4.sin_addr.s_addr)
-				return 1;
-		}
+		    ipv6_addr_v4mapped(&addr2->v6.sin6_addr) &&
+		    addr2->v6.sin6_addr.s6_addr32[3] =3D=3D
+		    addr1->v4.sin_addr.s_addr)
+			return 1;
+
 		if (addr2->sa.sa_family =3D=3D AF_INET &&
 		    addr1->sa.sa_family =3D=3D AF_INET6 &&
-		    ipv6_addr_v4mapped(&addr1->v6.sin6_addr)) {
-			if (addr1->v6.sin6_port =3D=3D addr2->v4.sin_port &&
-			    addr1->v6.sin6_addr.s6_addr32[3] =3D=3D
-			    addr2->v4.sin_addr.s_addr)
-				return 1;
-		}
+		    ipv6_addr_v4mapped(&addr1->v6.sin6_addr) &&
+		    addr1->v6.sin6_addr.s6_addr32[3] =3D=3D
+		    addr2->v4.sin_addr.s_addr)
+			return 1;
+
 		return 0;
 	}
-	if (addr1->v6.sin6_port !=3D addr2->v6.sin6_port)
-		return 0;
+
 	if (!ipv6_addr_equal(&addr1->v6.sin6_addr, &addr2->v6.sin6_addr))
 		return 0;
+
 	/* If this is a linklocal address, compare the scope_id. */
-	if (ipv6_addr_type(&addr1->v6.sin6_addr) & IPV6_ADDR_LINKLOCAL) {
-		if (addr1->v6.sin6_scope_id && addr2->v6.sin6_scope_id &&
-		    (addr1->v6.sin6_scope_id !=3D addr2->v6.sin6_scope_id)) {
-			return 0;
-		}
-	}
+	if ((ipv6_addr_type(&addr1->v6.sin6_addr) & IPV6_ADDR_LINKLOCAL) &&
+	    addr1->v6.sin6_scope_id && addr2->v6.sin6_scope_id &&
+	    addr1->v6.sin6_scope_id !=3D addr2->v6.sin6_scope_id)
+		return 0;
=20
 	return 1;
 }
=20
+/* Compare addresses exactly.
+ * v4-mapped-v6 is also in consideration.
+ */
+static int sctp_v6_cmp_addr(const union sctp_addr *addr1,
+			    const union sctp_addr *addr2)
+{
+	return __sctp_v6_cmp_addr(addr1, addr2) &&
+	       addr1->v6.sin6_port =3D=3D addr2->v6.sin6_port;
+}
+
 /* Initialize addr struct to INADDR_ANY. */
 static void sctp_v6_inaddr_any(union sctp_addr *addr, __be16 port)
 {
@@ -700,8 +703,10 @@ static int sctp_v6_addr_to_user(struct sctp_sock *sp, =
union sctp_addr *addr)
 			sctp_v6_map_v4(addr);
 	}
=20
-	if (addr->sa.sa_family =3D=3D AF_INET)
+	if (addr->sa.sa_family =3D=3D AF_INET) {
+		memset(addr->v4.sin_zero, 0, sizeof(addr->v4.sin_zero));
 		return sizeof(struct sockaddr_in);
+	}
 	return sizeof(struct sockaddr_in6);
 }
=20
@@ -818,8 +823,8 @@ static int sctp_inet6_cmp_addr(const union sctp_addr *a=
ddr1,
 			       const union sctp_addr *addr2,
 			       struct sctp_sock *opt)
 {
-	struct sctp_af *af1, *af2;
 	struct sock *sk =3D sctp_opt2sk(opt);
+	struct sctp_af *af1, *af2;
=20
 	af1 =3D sctp_get_af_specific(addr1->sa.sa_family);
 	af2 =3D sctp_get_af_specific(addr2->sa.sa_family);
@@ -835,10 +840,10 @@ static int sctp_inet6_cmp_addr(const union sctp_addr =
*addr1,
 	if (sctp_is_any(sk, addr1) || sctp_is_any(sk, addr2))
 		return 1;
=20
-	if (addr1->sa.sa_family !=3D addr2->sa.sa_family)
-		return 0;
+	if (addr1->sa.sa_family =3D=3D AF_INET && addr2->sa.sa_family =3D=3D AF_I=
NET)
+		return addr1->v4.sin_addr.s_addr =3D=3D addr2->v4.sin_addr.s_addr;
=20
-	return af1->cmp_addr(addr1, addr2);
+	return __sctp_v6_cmp_addr(addr1, addr2);
 }
=20
 /* Verify that the provided sockaddr looks bindable.   Common verification,
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index b18554898562..b23156e73469 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1375,6 +1375,7 @@ rpc_gssd_dummy_depopulate(struct dentry *pipe_dentry)
 	struct dentry *clnt_dir =3D pipe_dentry->d_parent;
 	struct dentry *gssd_dir =3D clnt_dir->d_parent;
=20
+	dget(pipe_dentry);
 	__rpc_rmpipe(clnt_dir->d_inode, pipe_dentry);
 	__rpc_depopulate(clnt_dir, gssd_dummy_info_file, 0, 1);
 	__rpc_depopulate(gssd_dir, gssd_dummy_clnt_dir, 0, 1);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 4bca49414a40..45387e2e6bbe 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1270,7 +1270,7 @@ static int security_context_to_sid_core(const char *s=
context, u32 scontext_len,
 				      scontext_len, &context, def_sid);
 	if (rc =3D=3D -EINVAL && force) {
 		context.str =3D str;
-		context.len =3D scontext_len;
+		context.len =3D strlen(str) + 1;
 		str =3D NULL;
 	} else if (rc)
 		goto out_unlock;
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 0608f216f359..ac0a40b9ba1e 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -400,8 +400,7 @@ static int snd_ctl_elem_add_compat(struct snd_ctl_file =
*file,
 	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)) ||
 	    copy_from_user(&data->type, &data32->type, 3 * sizeof(u32)))
 		goto error;
-	if (get_user(data->owner, &data32->owner) ||
-	    get_user(data->type, &data32->type))
+	if (get_user(data->owner, &data32->owner))
 		goto error;
 	switch (data->type) {
 	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index c64b13761aca..c89154b318cf 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -833,8 +833,25 @@ static int choose_rate(struct snd_pcm_substream *subst=
ream,
 	return snd_pcm_hw_param_near(substream, params, SNDRV_PCM_HW_PARAM_RATE, =
best_rate, NULL);
 }
=20
-static int snd_pcm_oss_change_params(struct snd_pcm_substream *substream,
-				     bool trylock)
+/* parameter locking: returns immediately if tried during streaming */
+static int lock_params(struct snd_pcm_runtime *runtime)
+{
+	if (mutex_lock_interruptible(&runtime->oss.params_lock))
+		return -ERESTARTSYS;
+	if (atomic_read(&runtime->oss.rw_ref)) {
+		mutex_unlock(&runtime->oss.params_lock);
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static void unlock_params(struct snd_pcm_runtime *runtime)
+{
+	mutex_unlock(&runtime->oss.params_lock);
+}
+
+/* call with params_lock held */
+static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *subs=
tream)
 {
 	struct snd_pcm_runtime *runtime =3D substream->runtime;
 	struct snd_pcm_hw_params *params, *sparams;
@@ -848,11 +865,8 @@ static int snd_pcm_oss_change_params(struct snd_pcm_su=
bstream *substream,
 	struct snd_mask sformat_mask;
 	struct snd_mask mask;
=20
-	if (trylock) {
-		if (!(mutex_trylock(&runtime->oss.params_lock)))
-			return -EAGAIN;
-	} else if (mutex_lock_interruptible(&runtime->oss.params_lock))
-		return -EINTR;
+	if (!runtime->oss.params)
+		return 0;
 	sw_params =3D kmalloc(sizeof(*sw_params), GFP_KERNEL);
 	params =3D kmalloc(sizeof(*params), GFP_KERNEL);
 	sparams =3D kmalloc(sizeof(*sparams), GFP_KERNEL);
@@ -1080,6 +1094,23 @@ static int snd_pcm_oss_change_params(struct snd_pcm_=
substream *substream,
 	kfree(sw_params);
 	kfree(params);
 	kfree(sparams);
+	return err;
+}
+
+/* this one takes the lock by itself */
+static int snd_pcm_oss_change_params(struct snd_pcm_substream *substream,
+				     bool trylock)
+{
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	int err;
+
+	if (trylock) {
+		if (!(mutex_trylock(&runtime->oss.params_lock)))
+			return -EAGAIN;
+	} else if (mutex_lock_interruptible(&runtime->oss.params_lock))
+		return -ERESTARTSYS;
+
+	err =3D snd_pcm_oss_change_params_locked(substream);
 	mutex_unlock(&runtime->oss.params_lock);
 	return err;
 }
@@ -1108,6 +1139,10 @@ static int snd_pcm_oss_get_active_substream(struct s=
nd_pcm_oss_file *pcm_oss_fil
 	return 0;
 }
=20
+/* call with params_lock held */
+/* NOTE: this always call PREPARE unconditionally no matter whether
+ * runtime->oss.prepare is set or not
+ */
 static int snd_pcm_oss_prepare(struct snd_pcm_substream *substream)
 {
 	int err;
@@ -1132,14 +1167,35 @@ static int snd_pcm_oss_make_ready(struct snd_pcm_su=
bstream *substream)
 	struct snd_pcm_runtime *runtime;
 	int err;
=20
-	if (substream =3D=3D NULL)
-		return 0;
 	runtime =3D substream->runtime;
 	if (runtime->oss.params) {
 		err =3D snd_pcm_oss_change_params(substream, false);
 		if (err < 0)
 			return err;
 	}
+	if (runtime->oss.prepare) {
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
+		err =3D snd_pcm_oss_prepare(substream);
+		mutex_unlock(&runtime->oss.params_lock);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+/* call with params_lock held */
+static int snd_pcm_oss_make_ready_locked(struct snd_pcm_substream *substre=
am)
+{
+	struct snd_pcm_runtime *runtime;
+	int err;
+
+	runtime =3D substream->runtime;
+	if (runtime->oss.params) {
+		err =3D snd_pcm_oss_change_params_locked(substream);
+		if (err < 0)
+			return err;
+	}
 	if (runtime->oss.prepare) {
 		err =3D snd_pcm_oss_prepare(substream);
 		if (err < 0)
@@ -1368,13 +1424,15 @@ static ssize_t snd_pcm_oss_write1(struct snd_pcm_su=
bstream *substream, const cha
 	if (atomic_read(&substream->mmap_count))
 		return -ENXIO;
=20
-	if ((tmp =3D snd_pcm_oss_make_ready(substream)) < 0)
-		return tmp;
+	atomic_inc(&runtime->oss.rw_ref);
 	while (bytes > 0) {
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			tmp =3D -ERESTARTSYS;
 			break;
 		}
+		tmp =3D snd_pcm_oss_make_ready_locked(substream);
+		if (tmp < 0)
+			goto err;
 		if (bytes < runtime->oss.period_bytes || runtime->oss.buffer_used > 0) {
 			tmp =3D bytes;
 			if (tmp + runtime->oss.buffer_used > runtime->oss.period_bytes)
@@ -1430,6 +1488,7 @@ static ssize_t snd_pcm_oss_write1(struct snd_pcm_subs=
tream *substream, const cha
 		}
 		tmp =3D 0;
 	}
+	atomic_dec(&runtime->oss.rw_ref);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 }
=20
@@ -1475,13 +1534,15 @@ static ssize_t snd_pcm_oss_read1(struct snd_pcm_sub=
stream *substream, char __use
 	if (atomic_read(&substream->mmap_count))
 		return -ENXIO;
=20
-	if ((tmp =3D snd_pcm_oss_make_ready(substream)) < 0)
-		return tmp;
+	atomic_inc(&runtime->oss.rw_ref);
 	while (bytes > 0) {
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			tmp =3D -ERESTARTSYS;
 			break;
 		}
+		tmp =3D snd_pcm_oss_make_ready_locked(substream);
+		if (tmp < 0)
+			goto err;
 		if (bytes < runtime->oss.period_bytes || runtime->oss.buffer_used > 0) {
 			if (runtime->oss.buffer_used =3D=3D 0) {
 				tmp =3D snd_pcm_oss_read2(substream, runtime->oss.buffer, runtime->oss=
=2Eperiod_bytes, 1);
@@ -1522,6 +1583,7 @@ static ssize_t snd_pcm_oss_read1(struct snd_pcm_subst=
ream *substream, char __use
 		}
 		tmp =3D 0;
 	}
+	atomic_dec(&runtime->oss.rw_ref);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 }
=20
@@ -1537,10 +1599,12 @@ static int snd_pcm_oss_reset(struct snd_pcm_oss_fil=
e *pcm_oss_file)
 			continue;
 		runtime =3D substream->runtime;
 		snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DROP, NULL);
+		mutex_lock(&runtime->oss.params_lock);
 		runtime->oss.prepare =3D 1;
 		runtime->oss.buffer_used =3D 0;
 		runtime->oss.prev_hw_ptr_period =3D 0;
 		runtime->oss.period_ptr =3D 0;
+		mutex_unlock(&runtime->oss.params_lock);
 	}
 	return 0;
 }
@@ -1626,9 +1690,13 @@ static int snd_pcm_oss_sync(struct snd_pcm_oss_file =
*pcm_oss_file)
 			goto __direct;
 		if ((err =3D snd_pcm_oss_make_ready(substream)) < 0)
 			return err;
+		atomic_inc(&runtime->oss.rw_ref);
+		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
+			atomic_dec(&runtime->oss.rw_ref);
+			return -ERESTARTSYS;
+		}
 		format =3D snd_pcm_oss_format_from(runtime->oss.format);
 		width =3D snd_pcm_format_physical_width(format);
-		mutex_lock(&runtime->oss.params_lock);
 		if (runtime->oss.buffer_used > 0) {
 #ifdef OSS_DEBUG
 			pcm_dbg(substream->pcm, "sync: buffer_used\n");
@@ -1638,10 +1706,8 @@ static int snd_pcm_oss_sync(struct snd_pcm_oss_file =
*pcm_oss_file)
 						   runtime->oss.buffer + runtime->oss.buffer_used,
 						   size);
 			err =3D snd_pcm_oss_sync1(substream, runtime->oss.period_bytes);
-			if (err < 0) {
-				mutex_unlock(&runtime->oss.params_lock);
-				return err;
-			}
+			if (err < 0)
+				goto unlock;
 		} else if (runtime->oss.period_ptr > 0) {
 #ifdef OSS_DEBUG
 			pcm_dbg(substream->pcm, "sync: period_ptr\n");
@@ -1651,10 +1717,8 @@ static int snd_pcm_oss_sync(struct snd_pcm_oss_file =
*pcm_oss_file)
 						   runtime->oss.buffer,
 						   size * 8 / width);
 			err =3D snd_pcm_oss_sync1(substream, size);
-			if (err < 0) {
-				mutex_unlock(&runtime->oss.params_lock);
-				return err;
-			}
+			if (err < 0)
+				goto unlock;
 		}
 		/*
 		 * The ALSA's period might be a bit large than OSS one.
@@ -1685,7 +1749,11 @@ static int snd_pcm_oss_sync(struct snd_pcm_oss_file =
*pcm_oss_file)
 				snd_pcm_lib_writev(substream, buffers, size);
 			}
 		}
+unlock:
 		mutex_unlock(&runtime->oss.params_lock);
+		atomic_dec(&runtime->oss.rw_ref);
+		if (err < 0)
+			return err;
 		/*
 		 * finish sync: drain the buffer
 		 */
@@ -1696,7 +1764,9 @@ static int snd_pcm_oss_sync(struct snd_pcm_oss_file *=
pcm_oss_file)
 		substream->f_flags =3D saved_f_flags;
 		if (err < 0)
 			return err;
+		mutex_lock(&runtime->oss.params_lock);
 		runtime->oss.prepare =3D 1;
+		mutex_unlock(&runtime->oss.params_lock);
 	}
=20
 	substream =3D pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTURE];
@@ -1707,8 +1777,10 @@ static int snd_pcm_oss_sync(struct snd_pcm_oss_file =
*pcm_oss_file)
 		err =3D snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DROP, NULL);
 		if (err < 0)
 			return err;
+		mutex_lock(&runtime->oss.params_lock);
 		runtime->oss.buffer_used =3D 0;
 		runtime->oss.prepare =3D 1;
+		mutex_unlock(&runtime->oss.params_lock);
 	}
 	return 0;
 }
@@ -1720,6 +1792,8 @@ static int snd_pcm_oss_set_rate(struct snd_pcm_oss_fi=
le *pcm_oss_file, int rate)
 	for (idx =3D 1; idx >=3D 0; --idx) {
 		struct snd_pcm_substream *substream =3D pcm_oss_file->streams[idx];
 		struct snd_pcm_runtime *runtime;
+		int err;
+
 		if (substream =3D=3D NULL)
 			continue;
 		runtime =3D substream->runtime;
@@ -1727,10 +1801,14 @@ static int snd_pcm_oss_set_rate(struct snd_pcm_oss_=
file *pcm_oss_file, int rate)
 			rate =3D 1000;
 		else if (rate > 192000)
 			rate =3D 192000;
+		err =3D lock_params(runtime);
+		if (err < 0)
+			return err;
 		if (runtime->oss.rate !=3D rate) {
 			runtime->oss.params =3D 1;
 			runtime->oss.rate =3D rate;
 		}
+		unlock_params(runtime);
 	}
 	return snd_pcm_oss_get_rate(pcm_oss_file);
 }
@@ -1755,13 +1833,19 @@ static int snd_pcm_oss_set_channels(struct snd_pcm_=
oss_file *pcm_oss_file, unsig
 	for (idx =3D 1; idx >=3D 0; --idx) {
 		struct snd_pcm_substream *substream =3D pcm_oss_file->streams[idx];
 		struct snd_pcm_runtime *runtime;
+		int err;
+
 		if (substream =3D=3D NULL)
 			continue;
 		runtime =3D substream->runtime;
+		err =3D lock_params(runtime);
+		if (err < 0)
+			return err;
 		if (runtime->oss.channels !=3D channels) {
 			runtime->oss.params =3D 1;
 			runtime->oss.channels =3D channels;
 		}
+		unlock_params(runtime);
 	}
 	return snd_pcm_oss_get_channels(pcm_oss_file);
 }
@@ -1832,6 +1916,7 @@ static int snd_pcm_oss_get_formats(struct snd_pcm_oss=
_file *pcm_oss_file)
 static int snd_pcm_oss_set_format(struct snd_pcm_oss_file *pcm_oss_file, i=
nt format)
 {
 	int formats, idx;
+	int err;
 =09
 	if (format !=3D AFMT_QUERY) {
 		formats =3D snd_pcm_oss_get_formats(pcm_oss_file);
@@ -1845,10 +1930,14 @@ static int snd_pcm_oss_set_format(struct snd_pcm_os=
s_file *pcm_oss_file, int for
 			if (substream =3D=3D NULL)
 				continue;
 			runtime =3D substream->runtime;
+			err =3D lock_params(runtime);
+			if (err < 0)
+				return err;
 			if (runtime->oss.format !=3D format) {
 				runtime->oss.params =3D 1;
 				runtime->oss.format =3D format;
 			}
+			unlock_params(runtime);
 		}
 	}
 	return snd_pcm_oss_get_format(pcm_oss_file);
@@ -1868,8 +1957,6 @@ static int snd_pcm_oss_set_subdivide1(struct snd_pcm_=
substream *substream, int s
 {
 	struct snd_pcm_runtime *runtime;
=20
-	if (substream =3D=3D NULL)
-		return 0;
 	runtime =3D substream->runtime;
 	if (subdivide =3D=3D 0) {
 		subdivide =3D runtime->oss.subdivision;
@@ -1893,9 +1980,17 @@ static int snd_pcm_oss_set_subdivide(struct snd_pcm_=
oss_file *pcm_oss_file, int
=20
 	for (idx =3D 1; idx >=3D 0; --idx) {
 		struct snd_pcm_substream *substream =3D pcm_oss_file->streams[idx];
+		struct snd_pcm_runtime *runtime;
+
 		if (substream =3D=3D NULL)
 			continue;
-		if ((err =3D snd_pcm_oss_set_subdivide1(substream, subdivide)) < 0)
+		runtime =3D substream->runtime;
+		err =3D lock_params(runtime);
+		if (err < 0)
+			return err;
+		err =3D snd_pcm_oss_set_subdivide1(substream, subdivide);
+		unlock_params(runtime);
+		if (err < 0)
 			return err;
 	}
 	return err;
@@ -1905,8 +2000,6 @@ static int snd_pcm_oss_set_fragment1(struct snd_pcm_s=
ubstream *substream, unsign
 {
 	struct snd_pcm_runtime *runtime;
=20
-	if (substream =3D=3D NULL)
-		return 0;
 	runtime =3D substream->runtime;
 	if (runtime->oss.subdivision || runtime->oss.fragshift)
 		return -EINVAL;
@@ -1926,9 +2019,17 @@ static int snd_pcm_oss_set_fragment(struct snd_pcm_o=
ss_file *pcm_oss_file, unsig
=20
 	for (idx =3D 1; idx >=3D 0; --idx) {
 		struct snd_pcm_substream *substream =3D pcm_oss_file->streams[idx];
+		struct snd_pcm_runtime *runtime;
+
 		if (substream =3D=3D NULL)
 			continue;
-		if ((err =3D snd_pcm_oss_set_fragment1(substream, val)) < 0)
+		runtime =3D substream->runtime;
+		err =3D lock_params(runtime);
+		if (err < 0)
+			return err;
+		err =3D snd_pcm_oss_set_fragment1(substream, val);
+		unlock_params(runtime);
+		if (err < 0)
 			return err;
 	}
 	return err;
@@ -2012,6 +2113,9 @@ static int snd_pcm_oss_set_trigger(struct snd_pcm_oss=
_file *pcm_oss_file, int tr
 	}
       	if (psubstream) {
       		runtime =3D psubstream->runtime;
+		cmd =3D 0;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
 		if (trigger & PCM_ENABLE_OUTPUT) {
 			if (runtime->oss.trigger)
 				goto _skip1;
@@ -2029,13 +2133,19 @@ static int snd_pcm_oss_set_trigger(struct snd_pcm_o=
ss_file *pcm_oss_file, int tr
 			cmd =3D SNDRV_PCM_IOCTL_DROP;
 			runtime->oss.prepare =3D 1;
 		}
-		err =3D snd_pcm_kernel_ioctl(psubstream, cmd, NULL);
-		if (err < 0)
-			return err;
-	}
  _skip1:
+		mutex_unlock(&runtime->oss.params_lock);
+		if (cmd) {
+			err =3D snd_pcm_kernel_ioctl(psubstream, cmd, NULL);
+			if (err < 0)
+				return err;
+		}
+	}
 	if (csubstream) {
       		runtime =3D csubstream->runtime;
+		cmd =3D 0;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
 		if (trigger & PCM_ENABLE_INPUT) {
 			if (runtime->oss.trigger)
 				goto _skip2;
@@ -2050,11 +2160,14 @@ static int snd_pcm_oss_set_trigger(struct snd_pcm_o=
ss_file *pcm_oss_file, int tr
 			cmd =3D SNDRV_PCM_IOCTL_DROP;
 			runtime->oss.prepare =3D 1;
 		}
-		err =3D snd_pcm_kernel_ioctl(csubstream, cmd, NULL);
-		if (err < 0)
-			return err;
-	}
  _skip2:
+		mutex_unlock(&runtime->oss.params_lock);
+		if (cmd) {
+			err =3D snd_pcm_kernel_ioctl(csubstream, cmd, NULL);
+			if (err < 0)
+				return err;
+		}
+	}
 	return 0;
 }
=20
@@ -2306,6 +2419,7 @@ static void snd_pcm_oss_init_substream(struct snd_pcm=
_substream *substream,
 	runtime->oss.maxfrags =3D 0;
 	runtime->oss.subdivision =3D 0;
 	substream->pcm_release =3D snd_pcm_oss_release_substream;
+	atomic_set(&runtime->oss.rw_ref, 0);
 }
=20
 static int snd_pcm_oss_release_file(struct snd_pcm_oss_file *pcm_oss_file)
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index f98703c5ae29..2326e239e8bd 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -28,6 +28,7 @@
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/pcm.h>
+#include <sound/timer.h>
 #include <sound/control.h>
 #include <sound/info.h>
=20
@@ -1002,8 +1003,13 @@ void snd_pcm_detach_substream(struct snd_pcm_substre=
am *substream)
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
 	kfree(runtime->hwptr_log);
 #endif
-	kfree(runtime);
+	/* Avoid concurrent access to runtime via PCM timer interface */
+	if (substream->timer)
+		spin_lock_irq(&substream->timer->lock);
 	substream->runtime =3D NULL;
+	if (substream->timer)
+		spin_unlock_irq(&substream->timer->lock);
+	kfree(runtime);
 	put_pid(substream->pid);
 	substream->pid =3D NULL;
 	substream->pstr->substream_opened--;
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 1bb1a43c7d03..f8b6cd1c900c 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -334,6 +334,8 @@ static int snd_pcm_ioctl_xfern_compat(struct snd_pcm_su=
bstream *substream,
 		return -ENOTTY;
 	if (substream->stream !=3D dir)
 		return -EINVAL;
+	if (substream->runtime->status->state =3D=3D SNDRV_PCM_STATE_OPEN)
+		return -EBADFD;
=20
 	if ((ch =3D substream->runtime->channels) > 128)
 		return -EINVAL;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 3835b818efa8..d38c60671969 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2527,6 +2527,7 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream =
*substream,
 	sync_ptr.s.status.hw_ptr =3D status->hw_ptr;
 	sync_ptr.s.status.tstamp =3D status->tstamp;
 	sync_ptr.s.status.suspended_state =3D status->suspended_state;
+	sync_ptr.s.status.audio_tstamp =3D status->audio_tstamp;
 	snd_pcm_stream_unlock_irq(substream);
 	if (copy_to_user(_sync_ptr, &sync_ptr, sizeof(sync_ptr)))
 		return -EFAULT;
diff --git a/sound/core/rawmidi_compat.c b/sound/core/rawmidi_compat.c
index 09a89094dcf7..4e304a24924a 100644
--- a/sound/core/rawmidi_compat.c
+++ b/sound/core/rawmidi_compat.c
@@ -36,8 +36,6 @@ static int snd_rawmidi_ioctl_params_compat(struct snd_raw=
midi_file *rfile,
 	struct snd_rawmidi_params params;
 	unsigned int val;
=20
-	if (rfile->output =3D=3D NULL)
-		return -EINVAL;
 	if (get_user(params.stream, &src->stream) ||
 	    get_user(params.buffer_size, &src->buffer_size) ||
 	    get_user(params.avail_min, &src->avail_min) ||
@@ -46,8 +44,12 @@ static int snd_rawmidi_ioctl_params_compat(struct snd_ra=
wmidi_file *rfile,
 	params.no_active_sensing =3D val;
 	switch (params.stream) {
 	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		if (!rfile->output)
+			return -EINVAL;
 		return snd_rawmidi_output_params(rfile->output, &params);
 	case SNDRV_RAWMIDI_STREAM_INPUT:
+		if (!rfile->input)
+			return -EINVAL;
 		return snd_rawmidi_input_params(rfile->input, &params);
 	}
 	return -EINVAL;
@@ -67,16 +69,18 @@ static int snd_rawmidi_ioctl_status_compat(struct snd_r=
awmidi_file *rfile,
 	int err;
 	struct snd_rawmidi_status status;
=20
-	if (rfile->output =3D=3D NULL)
-		return -EINVAL;
 	if (get_user(status.stream, &src->stream))
 		return -EFAULT;
=20
 	switch (status.stream) {
 	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		if (!rfile->output)
+			return -EINVAL;
 		err =3D snd_rawmidi_output_status(rfile->output, &status);
 		break;
 	case SNDRV_RAWMIDI_STREAM_INPUT:
+		if (!rfile->input)
+			return -EINVAL;
 		err =3D snd_rawmidi_input_status(rfile->input, &status);
 		break;
 	default:
@@ -113,16 +117,18 @@ static int snd_rawmidi_ioctl_status_x32(struct snd_ra=
wmidi_file *rfile,
 	int err;
 	struct snd_rawmidi_status status;
=20
-	if (rfile->output =3D=3D NULL)
-		return -EINVAL;
 	if (get_user(status.stream, &src->stream))
 		return -EFAULT;
=20
 	switch (status.stream) {
 	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		if (!rfile->output)
+			return -EINVAL;
 		err =3D snd_rawmidi_output_status(rfile->output, &status);
 		break;
 	case SNDRV_RAWMIDI_STREAM_INPUT:
+		if (!rfile->input)
+			return -EINVAL;
 		err =3D snd_rawmidi_input_status(rfile->input, &status);
 		break;
 	default:
diff --git a/sound/core/seq/oss/seq_oss_event.c b/sound/core/seq/oss/seq_os=
s_event.c
index c3908862bc8b..86ca584c27b2 100644
--- a/sound/core/seq/oss/seq_oss_event.c
+++ b/sound/core/seq/oss/seq_oss_event.c
@@ -26,6 +26,7 @@
 #include <sound/seq_oss_legacy.h>
 #include "seq_oss_readq.h"
 #include "seq_oss_writeq.h"
+#include <linux/nospec.h>
=20
=20
 /*
@@ -287,10 +288,10 @@ note_on_event(struct seq_oss_devinfo *dp, int dev, in=
t ch, int note, int vel, st
 {
 	struct seq_oss_synthinfo *info;
=20
-	if (!snd_seq_oss_synth_is_valid(dp, dev))
+	info =3D snd_seq_oss_synth_info(dp, dev);
+	if (!info)
 		return -ENXIO;
=20
-	info =3D &dp->synths[dev];
 	switch (info->arg.event_passing) {
 	case SNDRV_SEQ_OSS_PROCESS_EVENTS:
 		if (! info->ch || ch < 0 || ch >=3D info->nr_voices) {
@@ -298,6 +299,7 @@ note_on_event(struct seq_oss_devinfo *dp, int dev, int =
ch, int note, int vel, st
 			return set_note_event(dp, dev, SNDRV_SEQ_EVENT_NOTEON, ch, note, vel, e=
v);
 		}
=20
+		ch =3D array_index_nospec(ch, info->nr_voices);
 		if (note =3D=3D 255 && info->ch[ch].note >=3D 0) {
 			/* volume control */
 			int type;
@@ -347,10 +349,10 @@ note_off_event(struct seq_oss_devinfo *dp, int dev, i=
nt ch, int note, int vel, s
 {
 	struct seq_oss_synthinfo *info;
=20
-	if (!snd_seq_oss_synth_is_valid(dp, dev))
+	info =3D snd_seq_oss_synth_info(dp, dev);
+	if (!info)
 		return -ENXIO;
=20
-	info =3D &dp->synths[dev];
 	switch (info->arg.event_passing) {
 	case SNDRV_SEQ_OSS_PROCESS_EVENTS:
 		if (! info->ch || ch < 0 || ch >=3D info->nr_voices) {
@@ -358,6 +360,7 @@ note_off_event(struct seq_oss_devinfo *dp, int dev, int=
 ch, int note, int vel, s
 			return set_note_event(dp, dev, SNDRV_SEQ_EVENT_NOTEON, ch, note, vel, e=
v);
 		}
=20
+		ch =3D array_index_nospec(ch, info->nr_voices);
 		if (info->ch[ch].note >=3D 0) {
 			note =3D info->ch[ch].note;
 			info->ch[ch].vel =3D 0;
@@ -381,7 +384,7 @@ note_off_event(struct seq_oss_devinfo *dp, int dev, int=
 ch, int note, int vel, s
 static int
 set_note_event(struct seq_oss_devinfo *dp, int dev, int type, int ch, int =
note, int vel, struct snd_seq_event *ev)
 {
-	if (! snd_seq_oss_synth_is_valid(dp, dev))
+	if (!snd_seq_oss_synth_info(dp, dev))
 		return -ENXIO;
 =09
 	ev->type =3D type;
@@ -399,7 +402,7 @@ set_note_event(struct seq_oss_devinfo *dp, int dev, int=
 type, int ch, int note,
 static int
 set_control_event(struct seq_oss_devinfo *dp, int dev, int type, int ch, i=
nt param, int val, struct snd_seq_event *ev)
 {
-	if (! snd_seq_oss_synth_is_valid(dp, dev))
+	if (!snd_seq_oss_synth_info(dp, dev))
 		return -ENXIO;
 =09
 	ev->type =3D type;
diff --git a/sound/core/seq/oss/seq_oss_midi.c b/sound/core/seq/oss/seq_oss=
_midi.c
index 86353dc0439c..ef3e82a269df 100644
--- a/sound/core/seq/oss/seq_oss_midi.c
+++ b/sound/core/seq/oss/seq_oss_midi.c
@@ -29,6 +29,7 @@
 #include "../seq_lock.h"
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
=20
=20
 /*
@@ -318,6 +319,7 @@ get_mididev(struct seq_oss_devinfo *dp, int dev)
 {
 	if (dev < 0 || dev >=3D dp->max_mididev)
 		return NULL;
+	dev =3D array_index_nospec(dev, dp->max_mididev);
 	return get_mdev(dev);
 }
=20
diff --git a/sound/core/seq/oss/seq_oss_synth.c b/sound/core/seq/oss/seq_os=
s_synth.c
index ac3d7d2125e9..8bf5335d953b 100644
--- a/sound/core/seq/oss/seq_oss_synth.c
+++ b/sound/core/seq/oss/seq_oss_synth.c
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
=20
 /*
  * constants
@@ -339,17 +340,13 @@ snd_seq_oss_synth_cleanup(struct seq_oss_devinfo *dp)
 	dp->max_synthdev =3D 0;
 }
=20
-/*
- * check if the specified device is MIDI mapped device
- */
-static int
-is_midi_dev(struct seq_oss_devinfo *dp, int dev)
+static struct seq_oss_synthinfo *
+get_synthinfo_nospec(struct seq_oss_devinfo *dp, int dev)
 {
 	if (dev < 0 || dev >=3D dp->max_synthdev)
-		return 0;
-	if (dp->synths[dev].is_midi)
-		return 1;
-	return 0;
+		return NULL;
+	dev =3D array_index_nospec(dev, SNDRV_SEQ_OSS_MAX_SYNTH_DEVS);
+	return &dp->synths[dev];
 }
=20
 /*
@@ -359,14 +356,20 @@ static struct seq_oss_synth *
 get_synthdev(struct seq_oss_devinfo *dp, int dev)
 {
 	struct seq_oss_synth *rec;
-	if (dev < 0 || dev >=3D dp->max_synthdev)
-		return NULL;
-	if (! dp->synths[dev].opened)
+	struct seq_oss_synthinfo *info =3D get_synthinfo_nospec(dp, dev);
+
+	if (!info)
 		return NULL;
-	if (dp->synths[dev].is_midi)
-		return &midi_synth_dev;
-	if ((rec =3D get_sdev(dev)) =3D=3D NULL)
+	if (!info->opened)
 		return NULL;
+	if (info->is_midi) {
+		rec =3D &midi_synth_dev;
+		snd_use_lock_use(&rec->use_lock);
+	} else {
+		rec =3D get_sdev(dev);
+		if (!rec)
+			return NULL;
+	}
 	if (! rec->opened) {
 		snd_use_lock_free(&rec->use_lock);
 		return NULL;
@@ -402,10 +405,8 @@ snd_seq_oss_synth_reset(struct seq_oss_devinfo *dp, in=
t dev)
 	struct seq_oss_synth *rec;
 	struct seq_oss_synthinfo *info;
=20
-	if (snd_BUG_ON(dev < 0 || dev >=3D dp->max_synthdev))
-		return;
-	info =3D &dp->synths[dev];
-	if (! info->opened)
+	info =3D get_synthinfo_nospec(dp, dev);
+	if (!info || !info->opened)
 		return;
 	if (info->sysex)
 		info->sysex->len =3D 0; /* reset sysex */
@@ -454,12 +455,14 @@ snd_seq_oss_synth_load_patch(struct seq_oss_devinfo *=
dp, int dev, int fmt,
 			    const char __user *buf, int p, int c)
 {
 	struct seq_oss_synth *rec;
+	struct seq_oss_synthinfo *info;
 	int rc;
=20
-	if (dev < 0 || dev >=3D dp->max_synthdev)
+	info =3D get_synthinfo_nospec(dp, dev);
+	if (!info)
 		return -ENXIO;
=20
-	if (is_midi_dev(dp, dev))
+	if (info->is_midi)
 		return 0;
 	if ((rec =3D get_synthdev(dp, dev)) =3D=3D NULL)
 		return -ENXIO;
@@ -467,24 +470,25 @@ snd_seq_oss_synth_load_patch(struct seq_oss_devinfo *=
dp, int dev, int fmt,
 	if (rec->oper.load_patch =3D=3D NULL)
 		rc =3D -ENXIO;
 	else
-		rc =3D rec->oper.load_patch(&dp->synths[dev].arg, fmt, buf, p, c);
+		rc =3D rec->oper.load_patch(&info->arg, fmt, buf, p, c);
 	snd_use_lock_free(&rec->use_lock);
 	return rc;
 }
=20
 /*
- * check if the device is valid synth device
+ * check if the device is valid synth device and return the synth info
  */
-int
-snd_seq_oss_synth_is_valid(struct seq_oss_devinfo *dp, int dev)
+struct seq_oss_synthinfo *
+snd_seq_oss_synth_info(struct seq_oss_devinfo *dp, int dev)
 {
 	struct seq_oss_synth *rec;
+
 	rec =3D get_synthdev(dp, dev);
 	if (rec) {
 		snd_use_lock_free(&rec->use_lock);
-		return 1;
+		return get_synthinfo_nospec(dp, dev);
 	}
-	return 0;
+	return NULL;
 }
=20
=20
@@ -499,16 +503,18 @@ snd_seq_oss_synth_sysex(struct seq_oss_devinfo *dp, i=
nt dev, unsigned char *buf,
 	int i, send;
 	unsigned char *dest;
 	struct seq_oss_synth_sysex *sysex;
+	struct seq_oss_synthinfo *info;
=20
-	if (! snd_seq_oss_synth_is_valid(dp, dev))
+	info =3D snd_seq_oss_synth_info(dp, dev);
+	if (!info)
 		return -ENXIO;
=20
-	sysex =3D dp->synths[dev].sysex;
+	sysex =3D info->sysex;
 	if (sysex =3D=3D NULL) {
 		sysex =3D kzalloc(sizeof(*sysex), GFP_KERNEL);
 		if (sysex =3D=3D NULL)
 			return -ENOMEM;
-		dp->synths[dev].sysex =3D sysex;
+		info->sysex =3D sysex;
 	}
=20
 	send =3D 0;
@@ -553,10 +559,12 @@ snd_seq_oss_synth_sysex(struct seq_oss_devinfo *dp, i=
nt dev, unsigned char *buf,
 int
 snd_seq_oss_synth_addr(struct seq_oss_devinfo *dp, int dev, struct snd_seq=
_event *ev)
 {
-	if (! snd_seq_oss_synth_is_valid(dp, dev))
+	struct seq_oss_synthinfo *info =3D snd_seq_oss_synth_info(dp, dev);
+
+	if (!info)
 		return -EINVAL;
-	snd_seq_oss_fill_addr(dp, ev, dp->synths[dev].arg.addr.client,
-			      dp->synths[dev].arg.addr.port);
+	snd_seq_oss_fill_addr(dp, ev, info->arg.addr.client,
+			      info->arg.addr.port);
 	return 0;
 }
=20
@@ -568,16 +576,18 @@ int
 snd_seq_oss_synth_ioctl(struct seq_oss_devinfo *dp, int dev, unsigned int =
cmd, unsigned long addr)
 {
 	struct seq_oss_synth *rec;
+	struct seq_oss_synthinfo *info;
 	int rc;
=20
-	if (is_midi_dev(dp, dev))
+	info =3D get_synthinfo_nospec(dp, dev);
+	if (!info || info->is_midi)
 		return -ENXIO;
 	if ((rec =3D get_synthdev(dp, dev)) =3D=3D NULL)
 		return -ENXIO;
 	if (rec->oper.ioctl =3D=3D NULL)
 		rc =3D -ENXIO;
 	else
-		rc =3D rec->oper.ioctl(&dp->synths[dev].arg, cmd, addr);
+		rc =3D rec->oper.ioctl(&info->arg, cmd, addr);
 	snd_use_lock_free(&rec->use_lock);
 	return rc;
 }
@@ -589,7 +599,10 @@ snd_seq_oss_synth_ioctl(struct seq_oss_devinfo *dp, in=
t dev, unsigned int cmd, u
 int
 snd_seq_oss_synth_raw_event(struct seq_oss_devinfo *dp, int dev, unsigned =
char *data, struct snd_seq_event *ev)
 {
-	if (! snd_seq_oss_synth_is_valid(dp, dev) || is_midi_dev(dp, dev))
+	struct seq_oss_synthinfo *info;
+
+	info =3D snd_seq_oss_synth_info(dp, dev);
+	if (!info || info->is_midi)
 		return -ENXIO;
 	ev->type =3D SNDRV_SEQ_EVENT_OSS;
 	memcpy(ev->data.raw8.d, data, 8);
diff --git a/sound/core/seq/oss/seq_oss_synth.h b/sound/core/seq/oss/seq_os=
s_synth.h
index dbdfcbb80eaa..4db5658a8c6e 100644
--- a/sound/core/seq/oss/seq_oss_synth.h
+++ b/sound/core/seq/oss/seq_oss_synth.h
@@ -37,7 +37,8 @@ void snd_seq_oss_synth_cleanup(struct seq_oss_devinfo *dp=
);
 void snd_seq_oss_synth_reset(struct seq_oss_devinfo *dp, int dev);
 int snd_seq_oss_synth_load_patch(struct seq_oss_devinfo *dp, int dev, int =
fmt,
 				 const char __user *buf, int p, int c);
-int snd_seq_oss_synth_is_valid(struct seq_oss_devinfo *dp, int dev);
+struct seq_oss_synthinfo *snd_seq_oss_synth_info(struct seq_oss_devinfo *d=
p,
+						 int dev);
 int snd_seq_oss_synth_sysex(struct seq_oss_devinfo *dp, int dev, unsigned =
char *buf,
 			    struct snd_seq_event *ev);
 int snd_seq_oss_synth_addr(struct seq_oss_devinfo *dp, int dev, struct snd=
_seq_event *ev);
diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index 3b126af4a026..ef494ffc1369 100644
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -174,12 +174,12 @@ static void snd_virmidi_output_trigger(struct snd_raw=
midi_substream *substream,
 			}
 			return;
 		}
+		spin_lock_irqsave(&substream->runtime->lock, flags);
 		if (vmidi->event.type !=3D SNDRV_SEQ_EVENT_NONE) {
 			if (snd_seq_kernel_client_dispatch(vmidi->client, &vmidi->event, in_ato=
mic(), 0) < 0)
-				return;
+				goto out;
 			vmidi->event.type =3D SNDRV_SEQ_EVENT_NONE;
 		}
-		spin_lock_irqsave(&substream->runtime->lock, flags);
 		while (1) {
 			count =3D __snd_rawmidi_transmit_peek(substream, buf, sizeof(buf));
 			if (count <=3D 0)
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 762da0a59ba0..daa03c613c2b 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -347,8 +347,6 @@ int snd_timer_open(struct snd_timer_instance **ti,
 	return err;
 }
=20
-static int _snd_timer_stop(struct snd_timer_instance *timeri, int event);
-
 /*
  * close a timer instance
  * call this with register_mutex down.
@@ -445,7 +443,6 @@ unsigned long snd_timer_resolution(struct snd_timer_ins=
tance *timeri)
 static void snd_timer_notify1(struct snd_timer_instance *ti, int event)
 {
 	struct snd_timer *timer;
-	unsigned long flags;
 	unsigned long resolution =3D 0;
 	struct snd_timer_instance *ts;
 	struct timespec tstamp;
@@ -469,34 +466,66 @@ static void snd_timer_notify1(struct snd_timer_instan=
ce *ti, int event)
 		return;
 	if (timer->hw.flags & SNDRV_TIMER_HW_SLAVE)
 		return;
-	spin_lock_irqsave(&timer->lock, flags);
 	list_for_each_entry(ts, &ti->slave_active_head, active_list)
 		if (ts->ccallback)
 			ts->ccallback(ts, event + 100, &tstamp, resolution);
-	spin_unlock_irqrestore(&timer->lock, flags);
 }
=20
-static int snd_timer_start1(struct snd_timer *timer, struct snd_timer_inst=
ance *timeri,
-			    unsigned long sticks)
+/* start/continue a master timer */
+static int snd_timer_start1(struct snd_timer_instance *timeri,
+			    bool start, unsigned long ticks)
 {
+	struct snd_timer *timer;
+	int result;
+	unsigned long flags;
+
+	timer =3D timeri->timer;
+	if (!timer)
+		return -EINVAL;
+
+	spin_lock_irqsave(&timer->lock, flags);
+	if (timer->card && timer->card->shutdown) {
+		result =3D -ENODEV;
+		goto unlock;
+	}
+	if (timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
+			     SNDRV_TIMER_IFLG_START)) {
+		result =3D -EBUSY;
+		goto unlock;
+	}
+
+	if (start)
+		timeri->ticks =3D timeri->cticks =3D ticks;
+	else if (!timeri->cticks)
+		timeri->cticks =3D 1;
+	timeri->pticks =3D 0;
+
 	list_move_tail(&timeri->active_list, &timer->active_list_head);
 	if (timer->running) {
 		if (timer->hw.flags & SNDRV_TIMER_HW_SLAVE)
 			goto __start_now;
 		timer->flags |=3D SNDRV_TIMER_FLG_RESCHED;
 		timeri->flags |=3D SNDRV_TIMER_IFLG_START;
-		return 1;	/* delayed start */
+		result =3D 1; /* delayed start */
 	} else {
-		timer->sticks =3D sticks;
+		if (start)
+			timer->sticks =3D ticks;
 		timer->hw.start(timer);
 	      __start_now:
 		timer->running++;
 		timeri->flags |=3D SNDRV_TIMER_IFLG_RUNNING;
-		return 0;
+		result =3D 0;
 	}
+	snd_timer_notify1(timeri, start ? SNDRV_TIMER_EVENT_START :
+			  SNDRV_TIMER_EVENT_CONTINUE);
+ unlock:
+	spin_unlock_irqrestore(&timer->lock, flags);
+	return result;
 }
=20
-static int snd_timer_start_slave(struct snd_timer_instance *timeri)
+/* start/continue a slave timer */
+static int snd_timer_start_slave(struct snd_timer_instance *timeri,
+				 bool start)
 {
 	unsigned long flags;
=20
@@ -510,88 +539,37 @@ static int snd_timer_start_slave(struct snd_timer_ins=
tance *timeri)
 		spin_lock(&timeri->timer->lock);
 		list_add_tail(&timeri->active_list,
 			      &timeri->master->slave_active_head);
+		snd_timer_notify1(timeri, start ? SNDRV_TIMER_EVENT_START :
+				  SNDRV_TIMER_EVENT_CONTINUE);
 		spin_unlock(&timeri->timer->lock);
 	}
 	spin_unlock_irqrestore(&slave_active_lock, flags);
 	return 1; /* delayed start */
 }
=20
-/*
- *  start the timer instance
- */
-int snd_timer_start(struct snd_timer_instance *timeri, unsigned int ticks)
-{
-	struct snd_timer *timer;
-	int result =3D -EINVAL;
-	unsigned long flags;
-
-	if (timeri =3D=3D NULL || ticks < 1)
-		return -EINVAL;
-	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE) {
-		result =3D snd_timer_start_slave(timeri);
-		if (result >=3D 0)
-			snd_timer_notify1(timeri, SNDRV_TIMER_EVENT_START);
-		return result;
-	}
-	timer =3D timeri->timer;
-	if (timer =3D=3D NULL)
-		return -EINVAL;
-	if (timer->card && timer->card->shutdown)
-		return -ENODEV;
-	spin_lock_irqsave(&timer->lock, flags);
-	if (timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
-			     SNDRV_TIMER_IFLG_START)) {
-		result =3D -EBUSY;
-		goto unlock;
-	}
-	timeri->ticks =3D timeri->cticks =3D ticks;
-	timeri->pticks =3D 0;
-	result =3D snd_timer_start1(timer, timeri, ticks);
- unlock:
-	spin_unlock_irqrestore(&timer->lock, flags);
-	if (result >=3D 0)
-		snd_timer_notify1(timeri, SNDRV_TIMER_EVENT_START);
-	return result;
-}
-
-static int _snd_timer_stop(struct snd_timer_instance *timeri, int event)
+/* stop/pause a master timer */
+static int snd_timer_stop1(struct snd_timer_instance *timeri, bool stop)
 {
 	struct snd_timer *timer;
+	int result =3D 0;
 	unsigned long flags;
=20
-	if (snd_BUG_ON(!timeri))
-		return -ENXIO;
-
-	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE) {
-		spin_lock_irqsave(&slave_active_lock, flags);
-		if (!(timeri->flags & SNDRV_TIMER_IFLG_RUNNING)) {
-			spin_unlock_irqrestore(&slave_active_lock, flags);
-			return -EBUSY;
-		}
-		if (timeri->timer)
-			spin_lock(&timeri->timer->lock);
-		timeri->flags &=3D ~SNDRV_TIMER_IFLG_RUNNING;
-		list_del_init(&timeri->ack_list);
-		list_del_init(&timeri->active_list);
-		if (timeri->timer)
-			spin_unlock(&timeri->timer->lock);
-		spin_unlock_irqrestore(&slave_active_lock, flags);
-		goto __end;
-	}
 	timer =3D timeri->timer;
 	if (!timer)
 		return -EINVAL;
 	spin_lock_irqsave(&timer->lock, flags);
 	if (!(timeri->flags & (SNDRV_TIMER_IFLG_RUNNING |
 			       SNDRV_TIMER_IFLG_START))) {
-		spin_unlock_irqrestore(&timer->lock, flags);
-		return -EBUSY;
+		result =3D -EBUSY;
+		goto unlock;
 	}
 	list_del_init(&timeri->ack_list);
 	list_del_init(&timeri->active_list);
-	if (timer->card && timer->card->shutdown) {
-		spin_unlock_irqrestore(&timer->lock, flags);
-		return 0;
+	if (timer->card && timer->card->shutdown)
+		goto unlock;
+	if (stop) {
+		timeri->cticks =3D timeri->ticks;
+		timeri->pticks =3D 0;
 	}
 	if ((timeri->flags & SNDRV_TIMER_IFLG_RUNNING) &&
 	    !(--timer->running)) {
@@ -606,17 +584,53 @@ static int _snd_timer_stop(struct snd_timer_instance =
*timeri, int event)
 		}
 	}
 	timeri->flags &=3D ~(SNDRV_TIMER_IFLG_RUNNING | SNDRV_TIMER_IFLG_START);
-	if (event =3D=3D SNDRV_TIMER_EVENT_STOP)
+	if (stop)
 		timeri->flags &=3D ~SNDRV_TIMER_IFLG_PAUSED;
 	else
 		timeri->flags |=3D SNDRV_TIMER_IFLG_PAUSED;
+	snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
+			  SNDRV_TIMER_EVENT_PAUSE);
+ unlock:
 	spin_unlock_irqrestore(&timer->lock, flags);
-      __end:
-	if (event !=3D SNDRV_TIMER_EVENT_RESOLUTION)
-		snd_timer_notify1(timeri, event);
+	return result;
+}
+
+/* stop/pause a slave timer */
+static int snd_timer_stop_slave(struct snd_timer_instance *timeri, bool st=
op)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&slave_active_lock, flags);
+	if (!(timeri->flags & SNDRV_TIMER_IFLG_RUNNING)) {
+		spin_unlock_irqrestore(&slave_active_lock, flags);
+		return -EBUSY;
+	}
+	timeri->flags &=3D ~SNDRV_TIMER_IFLG_RUNNING;
+	if (timeri->timer) {
+		spin_lock(&timeri->timer->lock);
+		list_del_init(&timeri->ack_list);
+		list_del_init(&timeri->active_list);
+		snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
+				  SNDRV_TIMER_EVENT_PAUSE);
+		spin_unlock(&timeri->timer->lock);
+	}
+	spin_unlock_irqrestore(&slave_active_lock, flags);
 	return 0;
 }
=20
+/*
+ *  start the timer instance
+ */
+int snd_timer_start(struct snd_timer_instance *timeri, unsigned int ticks)
+{
+	if (timeri =3D=3D NULL || ticks < 1)
+		return -EINVAL;
+	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+		return snd_timer_start_slave(timeri, true);
+	else
+		return snd_timer_start1(timeri, true, ticks);
+}
+
 /*
  * stop the timer instance.
  *
@@ -624,21 +638,10 @@ static int _snd_timer_stop(struct snd_timer_instance =
*timeri, int event)
  */
 int snd_timer_stop(struct snd_timer_instance *timeri)
 {
-	struct snd_timer *timer;
-	unsigned long flags;
-	int err;
-
-	err =3D _snd_timer_stop(timeri, SNDRV_TIMER_EVENT_STOP);
-	if (err < 0)
-		return err;
-	timer =3D timeri->timer;
-	if (!timer)
-		return -EINVAL;
-	spin_lock_irqsave(&timer->lock, flags);
-	timeri->cticks =3D timeri->ticks;
-	timeri->pticks =3D 0;
-	spin_unlock_irqrestore(&timer->lock, flags);
-	return 0;
+	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+		return snd_timer_stop_slave(timeri, true);
+	else
+		return snd_timer_stop1(timeri, true);
 }
=20
 /*
@@ -646,36 +649,14 @@ int snd_timer_stop(struct snd_timer_instance *timeri)
  */
 int snd_timer_continue(struct snd_timer_instance *timeri)
 {
-	struct snd_timer *timer;
-	int result =3D -EINVAL;
-	unsigned long flags;
-
-	if (timeri =3D=3D NULL)
-		return result;
 	/* timer can continue only after pause */
 	if (!(timeri->flags & SNDRV_TIMER_IFLG_PAUSED))
 		return -EINVAL;
=20
 	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
-		return snd_timer_start_slave(timeri);
-	timer =3D timeri->timer;
-	if (! timer)
-		return -EINVAL;
-	if (timer->card && timer->card->shutdown)
-		return -ENODEV;
-	spin_lock_irqsave(&timer->lock, flags);
-	if (timeri->flags & SNDRV_TIMER_IFLG_RUNNING) {
-		result =3D -EBUSY;
-		goto unlock;
-	}
-	if (!timeri->cticks)
-		timeri->cticks =3D 1;
-	timeri->pticks =3D 0;
-	result =3D snd_timer_start1(timer, timeri, timer->sticks);
- unlock:
-	spin_unlock_irqrestore(&timer->lock, flags);
-	snd_timer_notify1(timeri, SNDRV_TIMER_EVENT_CONTINUE);
-	return result;
+		return snd_timer_start_slave(timeri, false);
+	else
+		return snd_timer_start1(timeri, false, 0);
 }
=20
 /*
@@ -683,7 +664,10 @@ int snd_timer_continue(struct snd_timer_instance *time=
ri)
  */
 int snd_timer_pause(struct snd_timer_instance * timeri)
 {
-	return _snd_timer_stop(timeri, SNDRV_TIMER_EVENT_PAUSE);
+	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+		return snd_timer_stop_slave(timeri, false);
+	else
+		return snd_timer_stop1(timeri, false);
 }
=20
 /*
diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 6c5b4e057521..2b23cb3dfa66 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -829,9 +829,11 @@ static int loopback_rate_shift_get(struct snd_kcontrol=
 *kcontrol,
 {
 	struct loopback *loopback =3D snd_kcontrol_chip(kcontrol);
 =09
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =3D
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].rate_shift;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
=20
@@ -863,9 +865,11 @@ static int loopback_notify_get(struct snd_kcontrol *kc=
ontrol,
 {
 	struct loopback *loopback =3D snd_kcontrol_chip(kcontrol);
 =09
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =3D
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].notify;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
=20
@@ -877,12 +881,14 @@ static int loopback_notify_put(struct snd_kcontrol *k=
control,
 	int change =3D 0;
=20
 	val =3D ucontrol->value.integer.value[0] ? 1 : 0;
+	mutex_lock(&loopback->cable_lock);
 	if (val !=3D loopback->setup[kcontrol->id.subdevice]
 				[kcontrol->id.device].notify) {
 		loopback->setup[kcontrol->id.subdevice]
 			[kcontrol->id.device].notify =3D val;
 		change =3D 1;
 	}
+	mutex_unlock(&loopback->cable_lock);
 	return change;
 }
=20
@@ -890,13 +896,16 @@ static int loopback_active_get(struct snd_kcontrol *k=
control,
 			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct loopback *loopback =3D snd_kcontrol_chip(kcontrol);
-	struct loopback_cable *cable =3D loopback->cables
-			[kcontrol->id.subdevice][kcontrol->id.device ^ 1];
+	struct loopback_cable *cable;
+
 	unsigned int val =3D 0;
=20
+	mutex_lock(&loopback->cable_lock);
+	cable =3D loopback->cables[kcontrol->id.subdevice][kcontrol->id.device ^ =
1];
 	if (cable !=3D NULL)
 		val =3D (cable->running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ?
 									1 : 0;
+	mutex_unlock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =3D val;
 	return 0;
 }
@@ -939,9 +948,11 @@ static int loopback_rate_get(struct snd_kcontrol *kcon=
trol,
 {
 	struct loopback *loopback =3D snd_kcontrol_chip(kcontrol);
 =09
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =3D
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].rate;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
=20
@@ -961,9 +972,11 @@ static int loopback_channels_get(struct snd_kcontrol *=
kcontrol,
 {
 	struct loopback *loopback =3D snd_kcontrol_chip(kcontrol);
 =09
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =3D
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].channels;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
=20
diff --git a/sound/drivers/opl3/opl3_synth.c b/sound/drivers/opl3/opl3_synt=
h.c
index ddcc1a325a61..42920a243328 100644
--- a/sound/drivers/opl3/opl3_synth.c
+++ b/sound/drivers/opl3/opl3_synth.c
@@ -21,6 +21,7 @@
=20
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
 #include <sound/opl3.h>
 #include <sound/asound_fm.h>
=20
@@ -448,7 +449,7 @@ static int snd_opl3_set_voice(struct snd_opl3 * opl3, s=
truct snd_dm_fm_voice * v
 {
 	unsigned short reg_side;
 	unsigned char op_offset;
-	unsigned char voice_offset;
+	unsigned char voice_offset, voice_op;
=20
 	unsigned short opl3_reg;
 	unsigned char reg_val;
@@ -473,7 +474,9 @@ static int snd_opl3_set_voice(struct snd_opl3 * opl3, s=
truct snd_dm_fm_voice * v
 		voice_offset =3D voice->voice - MAX_OPL2_VOICES;
 	}
 	/* Get register offset of operator */
-	op_offset =3D snd_opl3_regmap[voice_offset][voice->op];
+	voice_offset =3D array_index_nospec(voice_offset, MAX_OPL2_VOICES);
+	voice_op =3D array_index_nospec(voice->op, 4);
+	op_offset =3D snd_opl3_regmap[voice_offset][voice_op];
=20
 	reg_val =3D 0x00;
 	/* Set amplitude modulation (tremolo) effect */
diff --git a/sound/pci/asihpi/hpimsginit.c b/sound/pci/asihpi/hpimsginit.c
index 032d563e3708..a31a70dccecf 100644
--- a/sound/pci/asihpi/hpimsginit.c
+++ b/sound/pci/asihpi/hpimsginit.c
@@ -1,7 +1,7 @@
 /*************************************************************************=
*****
=20
     AudioScience HPI driver
-    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2014  AudioScience Inc. <support@audioscience.com>
=20
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -23,6 +23,7 @@
=20
 #include "hpi_internal.h"
 #include "hpimsginit.h"
+#include <linux/nospec.h>
=20
 /* The actual message size for each object type */
 static u16 msg_size[HPI_OBJ_MAXINDEX + 1] =3D HPI_MESSAGE_SIZE_BY_OBJECT;
@@ -37,11 +38,17 @@ static u16 gwSSX2_bypass;
 static void hpi_init_message(struct hpi_message *phm, u16 object,
 	u16 function)
 {
-	memset(phm, 0, sizeof(*phm));
-	if ((object > 0) && (object <=3D HPI_OBJ_MAXINDEX))
-		phm->size =3D msg_size[object];
-	else
-		phm->size =3D sizeof(*phm);
+	u16 size;
+
+	if ((object > 0) && (object <=3D HPI_OBJ_MAXINDEX)) {
+		object =3D array_index_nospec(object, HPI_OBJ_MAXINDEX + 1);
+		size =3D msg_size[object];
+	} else {
+		size =3D sizeof(*phm);
+	}
+
+	memset(phm, 0, size);
+	phm->size =3D size;
=20
 	if (gwSSX2_bypass)
 		phm->type =3D HPI_TYPE_SSX2BYPASS_MESSAGE;
@@ -60,12 +67,18 @@ static void hpi_init_message(struct hpi_message *phm, u=
16 object,
 void hpi_init_response(struct hpi_response *phr, u16 object, u16 function,
 	u16 error)
 {
+	u16 size;
+
+	if ((object > 0) && (object <=3D HPI_OBJ_MAXINDEX)) {
+		object =3D array_index_nospec(object, HPI_OBJ_MAXINDEX + 1);
+		size =3D res_size[object];
+	} else {
+		size =3D sizeof(*phr);
+	}
+
 	memset(phr, 0, sizeof(*phr));
+	phr->size =3D size;
 	phr->type =3D HPI_TYPE_RESPONSE;
-	if ((object > 0) && (object <=3D HPI_OBJ_MAXINDEX))
-		phr->size =3D res_size[object];
-	else
-		phr->size =3D sizeof(*phr);
 	phr->object =3D object;
 	phr->function =3D function;
 	phr->error =3D error;
@@ -86,7 +99,7 @@ void hpi_init_message_response(struct hpi_message *phm,
 static void hpi_init_messageV1(struct hpi_message_header *phm, u16 size,
 	u16 object, u16 function)
 {
-	memset(phm, 0, sizeof(*phm));
+	memset(phm, 0, size);
 	if ((object > 0) && (object <=3D HPI_OBJ_MAXINDEX)) {
 		phm->size =3D size;
 		phm->type =3D HPI_TYPE_REQUEST;
@@ -100,7 +113,9 @@ static void hpi_init_messageV1(struct hpi_message_heade=
r *phm, u16 size,
 void hpi_init_responseV1(struct hpi_response_header *phr, u16 size,
 	u16 object, u16 function)
 {
-	memset(phr, 0, sizeof(*phr));
+	(void)object;
+	(void)function;
+	memset(phr, 0, size);
 	phr->size =3D size;
 	phr->version =3D 1;
 	phr->type =3D HPI_TYPE_RESPONSE;
diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index 7f0272032fbb..d6ac0b2ec3d2 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -35,6 +35,7 @@ Common Linux HPI ioctl and module probe/remove functions
 #include <linux/pci.h>
 #include <linux/stringify.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
=20
 #ifdef MODULE_FIRMWARE
 MODULE_FIRMWARE("asihpi/dsp5000.bin");
@@ -182,7 +183,8 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int c=
md, unsigned long arg)
 		struct hpi_adapter *pa =3D NULL;
=20
 		if (hm->h.adapter_index < ARRAY_SIZE(adapters))
-			pa =3D &adapters[hm->h.adapter_index];
+			pa =3D &adapters[array_index_nospec(hm->h.adapter_index,
+							  ARRAY_SIZE(adapters))];
=20
 		if (!pa || !pa->adapter || !pa->adapter->type) {
 			hpi_init_response(&hr->r0, hm->h.object,
diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 014a7849e8fd..6af0385d73ad 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
+#include <linux/nospec.h>
 #include <sound/core.h>
 #include "hda_codec.h"
 #include "hda_local.h"
@@ -51,7 +52,16 @@ static int get_wcap_ioctl(struct hda_codec *codec,
 =09
 	if (get_user(verb, &arg->verb))
 		return -EFAULT;
-	res =3D get_wcaps(codec, verb >> 24);
+	/* open-code get_wcaps(verb>>24) with nospec */
+	verb >>=3D 24;
+	if (verb < codec->start_nid ||
+	    verb >=3D codec->start_nid + codec->num_nodes) {
+		res =3D 0;
+	} else {
+		verb -=3D codec->start_nid;
+		verb =3D array_index_nospec(verb, codec->num_nodes);
+		res =3D codec->wcaps[verb];
+	}
 	if (put_user(res, &arg->res))
 		return -EFAULT;
 	return 0;
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 811d3c1eb338..a2cad1dccfad 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -137,6 +137,7 @@
 #include <linux/pci.h>
 #include <linux/math64.h>
 #include <asm/io.h>
+#include <linux/nospec.h>
=20
 #include <sound/core.h>
 #include <sound/control.h>
@@ -5724,40 +5725,43 @@ static int snd_hdspm_channel_info(struct snd_pcm_su=
bstream *substream,
 		struct snd_pcm_channel_info *info)
 {
 	struct hdspm *hdspm =3D snd_pcm_substream_chip(substream);
+	unsigned int channel =3D info->channel;
=20
 	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
-		if (snd_BUG_ON(info->channel >=3D hdspm->max_channels_out)) {
+		if (snd_BUG_ON(channel >=3D hdspm->max_channels_out)) {
 			dev_info(hdspm->card->dev,
 				 "snd_hdspm_channel_info: output channel out of range (%d)\n",
-				 info->channel);
+				 channel);
 			return -EINVAL;
 		}
=20
-		if (hdspm->channel_map_out[info->channel] < 0) {
+		channel =3D array_index_nospec(channel, hdspm->max_channels_out);
+		if (hdspm->channel_map_out[channel] < 0) {
 			dev_info(hdspm->card->dev,
 				 "snd_hdspm_channel_info: output channel %d mapped out\n",
-				 info->channel);
+				 channel);
 			return -EINVAL;
 		}
=20
-		info->offset =3D hdspm->channel_map_out[info->channel] *
+		info->offset =3D hdspm->channel_map_out[channel] *
 			HDSPM_CHANNEL_BUFFER_BYTES;
 	} else {
-		if (snd_BUG_ON(info->channel >=3D hdspm->max_channels_in)) {
+		if (snd_BUG_ON(channel >=3D hdspm->max_channels_in)) {
 			dev_info(hdspm->card->dev,
 				 "snd_hdspm_channel_info: input channel out of range (%d)\n",
-				 info->channel);
+				 channel);
 			return -EINVAL;
 		}
=20
-		if (hdspm->channel_map_in[info->channel] < 0) {
+		channel =3D array_index_nospec(channel, hdspm->max_channels_in);
+		if (hdspm->channel_map_in[channel] < 0) {
 			dev_info(hdspm->card->dev,
 				 "snd_hdspm_channel_info: input channel %d mapped out\n",
-				 info->channel);
+				 channel);
 			return -EINVAL;
 		}
=20
-		info->offset =3D hdspm->channel_map_in[info->channel] *
+		info->offset =3D hdspm->channel_map_in[channel] *
 			HDSPM_CHANNEL_BUFFER_BYTES;
 	}
=20
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 1d9be90f7748..25f497c46d04 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -35,6 +35,7 @@
=20
 #include <asm/current.h>
 #include <asm/io.h>
+#include <linux/nospec.h>
=20
 static int index[SNDRV_CARDS] =3D SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] =3D SNDRV_DEFAULT_STR;	/* ID for this card */
@@ -2059,9 +2060,10 @@ static int snd_rme9652_channel_info(struct snd_pcm_s=
ubstream *substream,
 	if (snd_BUG_ON(info->channel >=3D RME9652_NCHANNELS))
 		return -EINVAL;
=20
-	if ((chn =3D rme9652->channel_map[info->channel]) < 0) {
+	chn =3D rme9652->channel_map[array_index_nospec(info->channel,
+						      RME9652_NCHANNELS)];
+	if (chn < 0)
 		return -EINVAL;
-	}
=20
 	info->offset =3D chn * RME9652_CHANNEL_BUFFER_BYTES;
 	info->first =3D 0;
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index eb1bb7414b8b..b3c6186d6177 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -54,10 +54,17 @@ struct ssm2602_priv {
  * using 2 wire for device control, so we cache them instead.
  * There is no point in caching the reset register
  */
-static const u16 ssm2602_reg[SSM2602_CACHEREGNUM] =3D {
-	0x0097, 0x0097, 0x0079, 0x0079,
-	0x000a, 0x0008, 0x009f, 0x000a,
-	0x0000, 0x0000
+static const struct reg_default ssm2602_reg[SSM2602_CACHEREGNUM] =3D {
+	{ .reg =3D 0x00, .def =3D 0x0097 },
+	{ .reg =3D 0x01, .def =3D 0x0097 },
+	{ .reg =3D 0x02, .def =3D 0x0079 },
+	{ .reg =3D 0x03, .def =3D 0x0079 },
+	{ .reg =3D 0x04, .def =3D 0x000a },
+	{ .reg =3D 0x05, .def =3D 0x0008 },
+	{ .reg =3D 0x06, .def =3D 0x009f },
+	{ .reg =3D 0x07, .def =3D 0x000a },
+	{ .reg =3D 0x08, .def =3D 0x0000 },
+	{ .reg =3D 0x09, .def =3D 0x0000 }
 };
=20
=20
@@ -629,8 +636,8 @@ const struct regmap_config ssm2602_regmap_config =3D {
 	.volatile_reg =3D ssm2602_register_volatile,
=20
 	.cache_type =3D REGCACHE_RBTREE,
-	.reg_defaults_raw =3D ssm2602_reg,
-	.num_reg_defaults_raw =3D ARRAY_SIZE(ssm2602_reg),
+	.reg_defaults =3D ssm2602_reg,
+	.num_reg_defaults =3D ARRAY_SIZE(ssm2602_reg),
 };
 EXPORT_SYMBOL_GPL(ssm2602_regmap_config);
=20
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index d719caf26dc2..cd326bbf9c62 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -142,6 +142,13 @@ static int fsl_esai_divisor_cal(struct snd_soc_dai *da=
i, bool tx, u32 ratio,
=20
 	psr =3D ratio <=3D 256 * maxfp ? ESAI_xCCR_xPSR_BYPASS : ESAI_xCCR_xPSR_D=
IV8;
=20
+	/* Do not loop-search if PM (1 ~ 256) alone can serve the ratio */
+	if (ratio <=3D 256) {
+		pm =3D ratio;
+		fp =3D 1;
+		goto out;
+	}
+
 	/* Set the max fluctuation -- 0.1% of the max devisor */
 	savesub =3D (psr ? 1 : 8)  * 256 * maxfp / 1000;
=20
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 600c20d157f5..9bce76497c48 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -885,6 +885,14 @@ static void volume_control_quirks(struct usb_mixer_ele=
m_info *cval,
 		}
 		break;
=20
+	case USB_ID(0x0d8c, 0x0103):
+		if (!strcmp(kctl->id.name, "PCM Playback Volume")) {
+			usb_audio_info(chip,
+				 "set volume quirk for CM102-A+/102S+\n");
+			cval->min =3D -256;
+		}
+		break;
+
 	case USB_ID(0x0471, 0x0101):
 	case USB_ID(0x0471, 0x0104):
 	case USB_ID(0x0471, 0x0105):
diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index bfcc295c7412..f0f526ca86e5 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -346,8 +346,11 @@ static struct usbmix_name_map bose_companion5_map[] =
=3D {
 /*
  * Dell usb dock with ALC4020 codec had a firmware problem where it got
  * screwed up when zero volume is passed; just skip it as a workaround
+ *
+ * Also the extension unit gives an access error, so skip it as well.
  */
 static const struct usbmix_name_map dell_alc4020_map[] =3D {
+	{ 4, NULL },	/* extension unit */
 	{ 16, NULL },
 	{ 19, NULL },
 	{ 0 }
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentati=
on/perf-top.txt
index 180ae02137a5..a9c03256fb8c 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -65,6 +65,9 @@ Default is to monitor all CPUS.
 --vmlinux=3D<path>::
 	Path to vmlinux.  Required for annotation functionality.
=20
+--ignore-vmlinux::
+	Ignore vmlinux files.
+
 -m <pages>::
 --mmap-pages=3D<pages>::
 	Number of mmap data pages (must be a power of two) or size
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 87cebac99533..5b394a862323 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -942,7 +942,7 @@ int cmd_record(int argc, const char **argv, const char =
*prefix __maybe_unused)
 	err =3D target__validate(&rec->opts.target);
 	if (err) {
 		target__strerror(&rec->opts.target, err, errbuf, BUFSIZ);
-		ui__warning("%s", errbuf);
+		ui__warning("%s\n", errbuf);
 	}
=20
 	err =3D target__parse_uid(&rec->opts.target);

--uQr8t48UFsdbeI+V--

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBW82Ezue/yOyVhhEJAQrFJw/8Dx6oZrkQa2jPNURi6/9Vhki1NqGUwGHK
B5RW8UBQ7tuxxi+pwQfkKK3XkVYEYH3S7L1K6he3y4dCSiDUH4HDLFsErL/dV5Bw
Q1r1Ku9B0IfqeUqah/qEFJE6EEOT9jtVuJ01NhV8TizXSnS5QIGWFyCyq+kl0e9/
3X+xLsciNXDfBfaBr04kWtlnSxzrn5XKsqNuGhEQdTYxU2OTfgqJm2O34DHQHKtj
aM1dm4SvyRV7H/BDjuw0mM4BdJqAhV1P7jdvRxoX1trkcoAGPPaKLSDO3xG28/46
BznuEdWJzE2X/U2PoxVjL6bBaSKOrJaiQOi7RcYbzjTIxxBxvS6T3P/DGPzE/PjJ
sZGCUjw/6I4V5/83W4V7N9nxjVJjMO5hYtimY/4FkDBrke9Tc0Li2BUqnZUmzRd0
R4O9zQ91UHT5x0T+qujBf086TkBakM0xFD+1Pj2c1gLxc7OZVsBCgB4XZ2Z6yutp
PgFNcDfTBEJvNow8jZATQ4A/A60qBgMuIO0+SZO7c4k02u8/WKZDTx2qY2WN9d2L
0X9FU6lBbVGZ+mm2rukJVJZZg/DhOp6JE1Awp9BWqDMlhFpxF52Mq0GKafWaiy+Z
vQYSiRhGfTyuT+soBx+L1NeM3riSzjvYwciYH5Ioa+fML5KxZeWFc1S/XgNMI2qV
0WDB5FIz9yo=
=diYM
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
