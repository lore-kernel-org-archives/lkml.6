Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD4BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFCD24B71
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFCD24B71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbeGCLlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:41:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42116 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeGCLlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:41:15 -0400
Received: from localhost (mobile-166-137-176-030.mycingular.net [166.137.176.30])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5450CB4;
        Tue,  3 Jul 2018 11:41:11 +0000 (UTC)
Date:   Tue, 3 Jul 2018 13:40:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.4
Message-ID: <20180703114057.GA19630@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.17.4 kernel.

All users of the 4.17 kernel series must upgrade.

The updated 4.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.17.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-class-cxl                    |    4=20
 Documentation/core-api/printk-formats.rst                    |    3=20
 Makefile                                                     |    2=20
 arch/arm/boot/dts/mt7623.dtsi                                |    3=20
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts                |    1=20
 arch/arm/boot/dts/mt7623n-rfb.dtsi                           |    1=20
 arch/arm/boot/dts/socfpga.dtsi                               |    4=20
 arch/arm/boot/dts/socfpga_arria10.dtsi                       |    5=20
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts           |    8=20
 arch/arm/include/asm/kgdb.h                                  |    2=20
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi            |    6=20
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    |    6=20
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts |    3=20
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                   |    8=20
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi                |    2=20
 arch/arm64/crypto/aes-glue.c                                 |    2=20
 arch/arm64/kernel/cpufeature.c                               |    2=20
 arch/arm64/kernel/signal.c                                   |    5=20
 arch/arm64/mm/proc.S                                         |    5=20
 arch/m68k/mac/config.c                                       |    2=20
 arch/m68k/mm/kmap.c                                          |    3=20
 arch/mips/ath79/mach-pb44.c                                  |    2=20
 arch/mips/bcm47xx/setup.c                                    |    6=20
 arch/mips/include/asm/io.h                                   |    2=20
 arch/mips/include/asm/mipsregs.h                             |    3=20
 arch/mips/kernel/mcount.S                                    |   27 +-
 arch/powerpc/Makefile                                        |    1=20
 arch/powerpc/kernel/dt_cpu_ftrs.c                            |    3=20
 arch/powerpc/kernel/entry_64.S                               |    1=20
 arch/powerpc/kernel/fadump.c                                 |    3=20
 arch/powerpc/kernel/hw_breakpoint.c                          |    4=20
 arch/powerpc/kernel/ptrace.c                                 |    1=20
 arch/powerpc/mm/pkeys.c                                      |    4=20
 arch/powerpc/mm/tlb-radix.c                                  |    2=20
 arch/powerpc/perf/imc-pmu.c                                  |    4=20
 arch/powerpc/platforms/powernv/copy-paste.h                  |    3=20
 arch/powerpc/platforms/powernv/idle.c                        |    4=20
 arch/powerpc/platforms/powernv/pci-ioda.c                    |    1=20
 arch/um/drivers/vector_kern.c                                |   20 +
 arch/x86/entry/entry_64_compat.S                             |   16 -
 arch/x86/include/asm/barrier.h                               |    2=20
 arch/x86/kernel/apic/x2apic_uv_x.c                           |   60 +++++
 arch/x86/kernel/cpu/mcheck/mce-severity.c                    |    5=20
 arch/x86/kernel/cpu/mcheck/mce.c                             |   44 ++-
 arch/x86/kernel/e820.c                                       |   15 +
 arch/x86/kernel/quirks.c                                     |   11=20
 arch/x86/kernel/traps.c                                      |   14 -
 arch/x86/mm/init.c                                           |    4=20
 arch/x86/mm/init_64.c                                        |   20 +
 arch/x86/platform/efi/efi_64.c                               |    4=20
 arch/x86/xen/smp_pv.c                                        |    5=20
 arch/xtensa/kernel/traps.c                                   |    2=20
 block/blk-core.c                                             |    4=20
 crypto/asymmetric_keys/x509_cert_parser.c                    |    9=20
 drivers/acpi/acpi_lpss.c                                     |   20 +
 drivers/auxdisplay/Kconfig                                   |   10=20
 drivers/base/core.c                                          |   15 -
 drivers/base/power/domain.c                                  |    3=20
 drivers/block/rbd.c                                          |    2=20
 drivers/bluetooth/hci_qca.c                                  |    6=20
 drivers/char/hw_random/core.c                                |   11=20
 drivers/char/ipmi/ipmi_bt_sm.c                               |    3=20
 drivers/char/tpm/tpm-dev-common.c                            |   40 +--
 drivers/char/tpm/tpm-dev.h                                   |    2=20
 drivers/char/tpm/tpm2-space.c                                |    3=20
 drivers/clk/at91/clk-pll.c                                   |   13 -
 drivers/clk/clk-aspeed.c                                     |    4=20
 drivers/clk/meson/meson8b.c                                  |    7=20
 drivers/clk/renesas/renesas-cpg-mssr.c                       |    9=20
 drivers/cpufreq/intel_pstate.c                               |   27 +-
 drivers/cpuidle/cpuidle-powernv.c                            |   32 ++
 drivers/firmware/efi/libstub/tpm.c                           |    2=20
 drivers/hwmon/k10temp.c                                      |    5=20
 drivers/i2c/algos/i2c-algo-bit.c                             |    5=20
 drivers/i2c/busses/i2c-gpio.c                                |    4=20
 drivers/iio/accel/sca3000.c                                  |    9=20
 drivers/iio/adc/ad7791.c                                     |   49 ----
 drivers/infiniband/core/umem.c                               |   11=20
 drivers/infiniband/core/uverbs_main.c                        |   14 -
 drivers/infiniband/core/verbs.c                              |   14 -
 drivers/infiniband/hw/hfi1/chip.c                            |    8=20
 drivers/infiniband/hw/hfi1/debugfs.c                         |    8=20
 drivers/infiniband/hw/hfi1/file_ops.c                        |    4=20
 drivers/infiniband/hw/hfi1/hfi.h                             |    1=20
 drivers/infiniband/hw/hfi1/init.c                            |   22 +
 drivers/infiniband/hw/hfi1/pio.c                             |   44 +++
 drivers/infiniband/hw/mlx4/mad.c                             |    1=20
 drivers/infiniband/hw/mlx4/mr.c                              |   50 +++-
 drivers/infiniband/hw/mlx5/cq.c                              |   15 +
 drivers/infiniband/hw/qib/qib.h                              |    4=20
 drivers/infiniband/hw/qib/qib_file_ops.c                     |   10=20
 drivers/infiniband/hw/qib/qib_init.c                         |   13 +
 drivers/infiniband/hw/qib/qib_user_pages.c                   |   20 +
 drivers/infiniband/sw/rdmavt/cq.c                            |   31 +-
 drivers/infiniband/ulp/isert/ib_isert.c                      |   28 +-
 drivers/input/joystick/xpad.c                                |    2=20
 drivers/input/mouse/elan_i2c.h                               |    2=20
 drivers/input/mouse/elan_i2c_core.c                          |    3=20
 drivers/input/mouse/elan_i2c_smbus.c                         |   10=20
 drivers/input/mouse/elantech.c                               |   11=20
 drivers/input/mouse/psmouse-base.c                           |   12 -
 drivers/input/touchscreen/silead.c                           |    1=20
 drivers/iommu/Kconfig                                        |    1=20
 drivers/iommu/amd_iommu.c                                    |   68 ++++--
 drivers/irqchip/irq-gic-v3-its.c                             |    9=20
 drivers/md/dm-thin.c                                         |   11=20
 drivers/md/dm-zoned-target.c                                 |    2=20
 drivers/md/dm.c                                              |    5=20
 drivers/md/md.c                                              |    4=20
 drivers/media/dvb-core/dvb_frontend.c                        |   23 +-
 drivers/media/platform/vsp1/vsp1_video.c                     |   21 +
 drivers/media/rc/ir-mce_kbd-decoder.c                        |    2=20
 drivers/media/usb/cx231xx/cx231xx-cards.c                    |    3=20
 drivers/media/usb/cx231xx/cx231xx-dvb.c                      |    2=20
 drivers/media/usb/uvc/uvc_video.c                            |   24 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c                |    2=20
 drivers/mfd/intel-lpss-pci.c                                 |   25 +-
 drivers/mfd/intel-lpss.c                                     |    4=20
 drivers/mfd/twl-core.c                                       |    2=20
 drivers/misc/cxl/pci.c                                       |    4=20
 drivers/misc/cxl/sysfs.c                                     |   16 +
 drivers/mmc/host/renesas_sdhi_core.c                         |    5=20
 drivers/mmc/host/renesas_sdhi_internal_dmac.c                |    1=20
 drivers/mmc/host/renesas_sdhi_sys_dmac.c                     |    3=20
 drivers/mtd/chips/cfi_cmdset_0002.c                          |   21 +
 drivers/mtd/nand/raw/denali_dt.c                             |    6=20
 drivers/mtd/nand/raw/mxc_nand.c                              |    5=20
 drivers/mtd/nand/raw/nand_base.c                             |   29 --
 drivers/mtd/nand/raw/nand_macronix.c                         |   48 +++-
 drivers/mtd/nand/raw/nand_micron.c                           |    2=20
 drivers/mtd/spi-nor/intel-spi.c                              |   76 +++++-
 drivers/mtd/ubi/build.c                                      |    3=20
 drivers/mtd/ubi/eba.c                                        |   90 ++++++=
+-
 drivers/mtd/ubi/wl.c                                         |    4=20
 drivers/net/ethernet/ti/davinci_emac.c                       |   15 +
 drivers/nvdimm/bus.c                                         |   14 -
 drivers/nvdimm/pmem.c                                        |   10=20
 drivers/nvdimm/region_devs.c                                 |    3=20
 drivers/of/platform.c                                        |    5=20
 drivers/of/resolver.c                                        |    5=20
 drivers/of/unittest.c                                        |    8=20
 drivers/opp/core.c                                           |    2=20
 drivers/pci/host/pci-hyperv.c                                |   11=20
 drivers/pci/hotplug/pciehp.h                                 |    2=20
 drivers/pci/hotplug/pciehp_core.c                            |    2=20
 drivers/pci/hotplug/pciehp_hpc.c                             |   13 +
 drivers/pci/pci-driver.c                                     |    5=20
 drivers/pci/probe.c                                          |   15 +
 drivers/pci/quirks.c                                         |   20 +
 drivers/pinctrl/devicetree.c                                 |    7=20
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c                  |    3=20
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c                 |    4=20
 drivers/platform/chrome/cros_ec_lpc.c                        |   13 -
 drivers/pwm/pwm-lpss-platform.c                              |    5=20
 drivers/pwm/pwm-lpss.c                                       |   30 ++
 drivers/pwm/pwm-lpss.h                                       |    2=20
 drivers/remoteproc/qcom_q6v5_pil.c                           |   10=20
 drivers/rpmsg/qcom_smd.c                                     |   18 -
 drivers/rtc/rtc-sun6i.c                                      |    4=20
 drivers/s390/scsi/zfcp_dbf.c                                 |   40 +++
 drivers/s390/scsi/zfcp_erp.c                                 |  123 ++++++=
++---
 drivers/s390/scsi/zfcp_ext.h                                 |    5=20
 drivers/s390/scsi/zfcp_scsi.c                                |   18 +
 drivers/scsi/hpsa.c                                          |   10=20
 drivers/scsi/qla2xxx/qla_gs.c                                |    4=20
 drivers/scsi/qla2xxx/qla_init.c                              |    3=20
 drivers/scsi/qla2xxx/qla_isr.c                               |    8=20
 drivers/scsi/qla2xxx/qla_target.c                            |    7=20
 drivers/scsi/scsi_debug.c                                    |    2=20
 drivers/soc/rockchip/pm_domains.c                            |    2=20
 drivers/thermal/broadcom/bcm2835_thermal.c                   |    4=20
 drivers/tty/serial/sh-sci.c                                  |    8=20
 drivers/usb/core/hub.c                                       |    4=20
 drivers/video/backlight/as3711_bl.c                          |   33 ++
 drivers/video/backlight/max8925_bl.c                         |    4=20
 drivers/video/backlight/tps65217_bl.c                        |    4=20
 drivers/video/fbdev/uvesafb.c                                |    3=20
 drivers/virt/vboxguest/vboxguest_linux.c                     |    4=20
 drivers/w1/w1.c                                              |    2=20
 drivers/xen/events/events_base.c                             |    2=20
 fs/btrfs/inode.c                                             |    4=20
 fs/f2fs/checkpoint.c                                         |    4=20
 fs/f2fs/inode.c                                              |    4=20
 fs/f2fs/segment.c                                            |    3=20
 fs/f2fs/segment.h                                            |    1=20
 fs/fuse/control.c                                            |   13 -
 fs/fuse/dev.c                                                |    3=20
 fs/fuse/dir.c                                                |   13 +
 fs/fuse/inode.c                                              |    1=20
 fs/nfs/callback_proc.c                                       |    7=20
 fs/nfs/nfs4idmap.c                                           |    5=20
 fs/nfs/nfs4proc.c                                            |    2=20
 fs/nfsd/nfs4xdr.c                                            |    5=20
 fs/ubifs/journal.c                                           |    5=20
 fs/udf/directory.c                                           |    3=20
 include/dt-bindings/clock/aspeed-clock.h                     |    2=20
 include/linux/blkdev.h                                       |    4=20
 include/linux/compiler.h                                     |    2=20
 include/linux/memory.h                                       |    1=20
 include/linux/slub_def.h                                     |    4=20
 include/rdma/ib_verbs.h                                      |   27 +-
 include/rdma/rdma_vt.h                                       |    2=20
 kernel/locking/rwsem.c                                       |    1=20
 kernel/printk/printk_safe.c                                  |    5=20
 kernel/softirq.c                                             |    6=20
 kernel/time/time.c                                           |    6=20
 kernel/trace/trace_events_filter.c                           |   10=20
 lib/Kconfig.kasan                                            |    1=20
 lib/vsprintf.c                                               |    3=20
 mm/gup.c                                                     |   36 ++-
 mm/ksm.c                                                     |   14 -
 mm/slab_common.c                                             |    4=20
 mm/slub.c                                                    |    7=20
 net/sunrpc/xprtrdma/rpc_rdma.c                               |    2=20
 security/selinux/selinuxfs.c                                 |   78 ++----
 sound/core/timer.c                                           |    2=20
 sound/pci/hda/hda_codec.c                                    |    5=20
 sound/pci/hda/hda_codec.h                                    |    1=20
 sound/pci/hda/patch_hdmi.c                                   |    5=20
 sound/pci/hda/patch_realtek.c                                |   20 +
 sound/soc/cirrus/edb93xx.c                                   |    2=20
 sound/soc/cirrus/ep93xx-i2s.c                                |   26 +-
 sound/soc/cirrus/snappercl15.c                               |    2=20
 sound/soc/codecs/cs35l35.c                                   |    1=20
 sound/soc/mediatek/common/mtk-afe-platform-driver.c          |    4=20
 sound/soc/soc-dapm.c                                         |    2=20
 tools/perf/util/dso.c                                        |    2=20
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c          |   23 +-
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h          |    9=20
 tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c      |    2=20
 tools/perf/util/intel-pt.c                                   |    5=20
 tools/testing/selftests/ftrace/test.d/functions              |   21 +
 232 files changed, 1705 insertions(+), 755 deletions(-)

??? (1):
      Input: elantech - fix V4 report decoding for module with middle key

Aaron Ma (1):
      Input: elantech - enable middle button of touchpads on ThinkPad P52

Abhishek Sahu (1):
      mtd: rawnand: fix return value check for bad block status

Adrian Hunter (6):
      perf tools: Fix symbol and object code resolution for vdso32 and vdso=
x32
      perf intel-pt: Fix sync_switch INTEL_PT_SS_NOT_TRACING
      perf intel-pt: Fix decoding to accept CBR between FUP and correspondi=
ng TIP
      perf intel-pt: Fix MTC timing after overflow
      perf intel-pt: Fix "Unexpected indirect branch" error
      perf intel-pt: Fix packet decoding of CYC packets

Akshay Adiga (1):
      powerpc/powernv/cpuidle: Init all present cpus for deep states

Alex Estrin (2):
      IB/{hfi1, qib}: Add handling of kernel restart
      IB/isert: Fix for lib/dma_debug check_sync warning

Alex Williamson (1):
      PCI: Add ACS quirk for Intel 7th & 8th Gen mobile

Alexander Sverdlin (2):
      ASoC: cirrus: i2s: Fix LRCLK configuration
      ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData setup

Alexandr Savca (1):
      Input: elan_i2c - add ELAN0618 (Lenovo v330 15IKB) ACPI ID

Alexandru Ardelean (1):
      iio: adc: ad7791: remove sample freq sysfs attributes

Alexey Kardashevskiy (1):
      powerpc/powernv/ioda2: Remove redundant free of TCE pages

Amit Pundir (1):
      Bluetooth: hci_qca: Avoid missing rampatch failure with userspace fw =
loader

Andy Lutomirski (1):
      x86/entry/64/compat: Fix "x86/entry/64/compat: Preserve r8-r11 in int=
 $0x80"

Andy Shevchenko (1):
      mfd: intel-lpss: Program REMAP register in PIO mode

Aneesh Kumar K.V (1):
      powerpc/mm/hash: Add missing isync prior to kernel stack SLB switch

Anil Gurumurthy (1):
      scsi: qla2xxx: Mask off Scope bits in retry delay

Anju T Sudhakar (1):
      powerpc/perf: Fix memory allocation for core-imc based on num_possibl=
e_cpus()

Anton Ivanov (2):
      um: Fix initialization of vector queues
      um: Fix raw interface options

Bart Van Assche (2):
      block: Fix cloning of requests with a special payload
      dm zoned: avoid triggering reclaim from inside dmz_map()

Bartosz Golaszewski (1):
      net: ethernet: fix suspend/resume in davinci_emac

Ben Hutchings (1):
      Input: elan_i2c_smbus - fix more potential stack buffer overflows

Bharat Potnuri (1):
      RDMA/core: Save kernel caller name when creating CQ using ib_create_c=
q()

Boris Brezillon (1):
      mtd: rawnand: Do not check FAIL bit when executing a SET_FEATURES op

Boris Ostrovsky (1):
      xen: Remove unnecessary BUG_ON from __unbind_from_irq()

Borislav Petkov (1):
      x86/mce: Do not overwrite MCi_STATUS in mce_no_way_out()

Brad Love (1):
      media: cx231xx: Ignore an i2c mux adapter

Chao Yu (1):
      f2fs: don't use GFP_ZERO for page caches

Chen-Yu Tsai (1):
      ARM: dts: sun8i: h3: fix ALL-H3-CC H3 ver VCC-1V2 regulator voltage

Chris Packham (1):
      mtd: rawnand: micron: add ONFI_FEATURE_ON_DIE_ECC to supported featur=
es

Christophe JAILLET (1):
      iio: sca3000: Fix an error handling path in 'sca3000_probe()'

Chuck Lever (1):
      xprtrdma: Return -ENOBUFS when no pages are available

Corey Minyard (1):
      ipmi:bt: Set the timeout before doing a capabilities check

Dan Williams (3):
      x86/spectre_v1: Disable compiler optimizations over array_index_mask_=
nospec()
      mm: fix __gup_device_huge vs unmap
      mm: fix devmem_is_allowed() for sub-page System RAM intersections

Daniel Wagner (1):
      serial: sh-sci: Use spin_{try}lock_irqsave instead of open coding ver=
sion

Dave Martin (1):
      arm64: Fix syscall restarting around signal suppressed by tracer

Dave Wysochanski (1):
      NFSv4: Fix possible 1-byte stack overflow in nfs_idmap_read_and_verif=
y_message

David Rivshin (1):
      ARM: 8764/1: kgdb: fix NUMREGBYTES so that gdb_regs[] is the correct =
size

Dinh Nguyen (1):
      ARM: dts: socfpga: Fix NAND controller node compatible for Arria10

Dmitry Torokhov (2):
      platform/chrome: cros_ec_lpc: do not try DMI match when ACPI device f=
ound
      Input: psmouse - fix button reporting for basic protocols

Dongsheng Yang (1):
      rbd: flush rbd_dev->watch_dwork after watch is unregistered

Enno Boland (1):
      Input: xpad - fix GPD Win 2 controller name

Erez Shitrit (1):
      IB/mlx5: Fetch soft WQE's on fatal error state

Eric W. Biederman (1):
      signal/xtensa: Consistenly use SIGBUS in do_unaligned_user

Fabio Estevam (1):
      pinctrl: devicetree: Fix pctldev pointer overwrite

Filipe Manana (1):
      Btrfs: fix return value on rename exchange failure

Finley Xiao (1):
      soc: rockchip: power-domain: Fix wrong value when power up pd with wr=
itemask

Finn Thain (1):
      m68k/mac: Fix SWIM memory resource end address

Frank Rowand (1):
      of: overlay: validate offset from property fixups

Gautham R. Shenoy (1):
      cpuidle: powernv: Fix promotion from snooze if next state disabled

Geert Uytterhoeven (4):
      thermal: bcm2835: Stop using printk format %pCr
      clk: renesas: cpg-mssr: Stop using printk format %pCr
      lib/vsprintf: Remove atomic-unsafe support for %pCr
      time: Make sure jiffies_to_msecs() preserves non-zero time periods

Greg Kroah-Hartman (1):
      Linux 4.17.4

Guenter Roeck (1):
      hwmon: (k10temp) Add support for Stoney Ridge and Bristol Ridge CPUs

Hans de Goede (4):
      efi/libstub/tpm: Initialize efi_physical_addr_t vars to zero for mixe=
d mode
      ACPI / LPSS: Add missing prv_offset setting for byt/cht PWM devices
      Input: silead - add MSSL0002 ACPI HID
      pwm: lpss: platform: Save/restore the ctrl register over a suspend/re=
sume

Haren Myneni (1):
      powerpc/powernv: copy/paste - Mask SO bit in CR

Himanshu Madhani (1):
      scsi: qla2xxx: Fix setting lower transfer speed if GPSC fails

Huacai Chen (1):
      MIPS: io: Add barrier after register read in inX()

Hui Wang (1):
      ALSA: hda/realtek - Fix the problem of two front mics on more machines

Icenowy Zheng (1):
      ARM: dts: sun8i: h3: fix ALL-H3-CC H3 ver VDD-CPUX voltage

Ingo Flaschberger (1):
      1wire: family module autoload fails because of upper/lower case misma=
tch.

Jack Morgenstein (2):
      IB/mlx4: Mark user MR as writable if actual virtual memory is writable
      IB/core: Make testing MR flags for writability a static inline functi=
on

Jae Hyun Yoo (1):
      clk:aspeed: Fix reset bits for PCI/VGA and PECI

Jan Kara (1):
      udf: Detect incorrect directory size

Jann Horn (1):
      selinux: move user accesses in selinuxfs out of locked regions

Jarkko Nikula (1):
      mfd: intel-lpss: Fix Intel Cannon Lake LPSS I2C input clock

Jason A. Donenfeld (1):
      kasan: depend on CONFIG_SLUB_DEBUG

Jason Gunthorpe (1):
      IB/uverbs: Fix ordering of ucontext check in ib_uverbs_write

Jerome Brunet (1):
      ARM64: dts: meson: disable sd-uhs modes on the libretech-cc

Jia He (2):
      crypto: arm64/aes-blk - fix and move skcipher_walk_done out of kernel=
_neon_begin, _end
      mm/ksm.c: ignore STABLE_FLAG of rmap_item->address in rmap_walk_ksm()

Joakim Tjernlund (4):
      mtd: cfi_cmdset_0002: Use right chip in do_ppb_xxlock()
      mtd: cfi_cmdset_0002: fix SEGV unlocking multiple chips
      mtd: cfi_cmdset_0002: Fix unlocking requests crossing a chip boudary
      mtd: cfi_cmdset_0002: Avoid walking all chips when unlocking.

Joel Fernandes (Google) (1):
      softirq: Reorder trace_softirqs_on to prevent lockdep splat

Johan Hovold (3):
      backlight: as3711_bl: Fix Device Tree node lookup
      backlight: max8925_bl: Fix Device Tree node lookup
      backlight: tps65217_bl: Fix Device Tree node lookup

Juergen Gross (1):
      x86/xen: Add call of speculative_store_bypass_ht_init() to PV paths

Kai Chieh Chuang (1):
      ASoC: mediatek: preallocate pages use platform device

Kai-Heng Feng (1):
      media: cx231xx: Add support for AverMedia DVD EZMaker 7

Kees Cook (1):
      video: uvesafb: Fix integer overflow in allocation

Keith Busch (1):
      block: Fix transfer when chunk sectors exceeds max

Kevin Hilman (1):
      ARM64: dts: meson-gx: fix ATF reserved memory region

Kieran Bingham (1):
      media: vsp1: Release buffers for each video node

Kirill A. Shutemov (1):
      x86/efi: Fix efi_call_phys_epilog() with CONFIG_X86_5LEVEL=3Dy

Leon Romanovsky (1):
      RDMA/mlx4: Discard unknown SQP work requests

Linus Torvalds (1):
      Revert "iommu/amd_iommu: Use CONFIG_DMA_DIRECT_OPS=3Dy and dma_direct=
_{alloc,free}()"

Linus Walleij (1):
      MIPS: pb44: Fix i2c-gpio GPIO descriptor table

Luis Henriques (1):
      scsi: scsi_debug: Fix memory leak on module unload

Maciej S. Szmigiero (1):
      X.509: unpack RSA signatureValue field from BIT STRING

Mahesh Salgaonkar (1):
      powerpc/fadump: Unregister fadump on kexec down path.

Marcin Ziemianowicz (1):
      clk: at91: PLL recalc_rate() now using cached MUL and DIV values

Marek Vasut (2):
      ARM: dts: socfpga: Fix NAND controller node compatible
      ARM: dts: socfpga: Fix NAND controller clock supply

Martin Blumenstingl (1):
      clk: meson: meson8b: mark fclk_div2 gate clocks as CLK_IS_CRITICAL

Martin Kaiser (1):
      mtd: rawnand: mxc: set spare area size register explicitly

Masahiro Yamada (1):
      mtd: rawnand: denali_dt: set clk_x_rate to 200 MHz unconditionally

Mason Yang (1):
      mtd: rawnand: All AC chips have a broken GET_FEATURES(TIMINGS).

Matthias Schiffer (1):
      mips: ftrace: fix static function graph tracing

Mauro Carvalho Chehab (2):
      media: v4l2-compat-ioctl32: prevent go past max size
      media: dvb_frontend: fix locking issues at dvb_frontend_get_event()

Max Gurtovoy (1):
      IB/isert: fix T10-pi check mask setting

Maxim Moseychuk (1):
      usb: do not reset if a low-speed or full-speed device timed out

Michael Buesch (1):
      hwrng: core - Always drop the RNG in hwrng_unregister()

Michael Ellerman (1):
      powerpc/64s: Fix DT CPU features Power9 DD2.1 logic

Michael J. Ruhl (1):
      IB/hfi1: Reorder incorrect send context disable

Michael Jeanson (1):
      powerpc/e500mc: Set assembler machine type to e500mc

Michael Neuling (2):
      powerpc/ptrace: Fix setting 512B aligned breakpoints with PTRACE_SET_=
DEBUGREG
      powerpc/ptrace: Fix enforcement of DAWR constraints

Michael Schmitz (1):
      m68k/mm: Adjust VM area to be unmapped by gap size for __iounmap()

Michael Trimarchi (1):
      rtc: sun6i: Fix bit_idx value for clk_register_gate

Mika Westerberg (4):
      mtd: spi-nor: intel-spi: Fix atomic sequence handling
      PCI: Add ACS quirk for Intel 300 series
      PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed=
 on resume
      PCI: Account for all bridges on bus when distributing bus numbers

Mike Marciniszyn (3):
      IB/qib: Fix DMA api warning with debug kernel
      IB/hfi1: Fix fault injection init/exit issues
      IB/hfi1: Fix user context tail allocation for DMA_RTAIL

Mike Snitzer (2):
      dm: use bio_split() when splitting out the already processed bio
      dm thin: handle running out of data space vs concurrent discard

Mikhail Malygin (1):
      scsi: qla2xxx: Spinlock recursion in qla_target

Miklos Szeredi (2):
      fuse: atomic_o_trunc should truncate pagecache
      fuse: fix control dir setup and teardown

Mikulas Patocka (2):
      branch-check: fix long->int truncation when profiling branches
      slub: fix failure when we delete and create a slab cache

Miquel Raynal (1):
      arm64: dts: marvell: fix CP110 ICU node size

Naoya Horiguchi (1):
      x86/e820: put !E820_TYPE_RAM regions into memblock.reserved

NeilBrown (1):
      md: fix two problems with setting the "re-add" device state.

Nicholas Piggin (1):
      powerpc/64s/radix: Fix radix_kvm_prefetch_workaround paca access of n=
ot possible CPU

Paul Handrigan (1):
      ASoC: cs35l35: Add use_single_rw to regmap config

Pawe=C5=82 Chmiel (1):
      pinctrl: samsung: Correct EINTG banks order

Peter Ujfalusi (1):
      mfd: twl-core: Fix clock initialization

Quinn Tran (1):
      scsi: qla2xxx: Delete session for nport id change

Rafael J. Wysocki (3):
      PCI / PM: Do not clear state_saved for devices that remain suspended
      ACPI / LPSS: Avoid PM quirks on suspend and resume from S3
      PM / core: Fix supplier device runtime PM usage counter imbalance

Ram Pai (1):
      powerpc/pkeys: Detach execute_only key on !PROT_EXEC

Randy Dunlap (1):
      auxdisplay: fix broken menu

Richard Weinberger (2):
      ubi: fastmap: Cancel work upon detach
      ubi: fastmap: Correctly handle interrupted erasures in EBA

Robert Elliott (1):
      linvdimm, pmem: Preserve read-only setting for pmem devices

Ross Zwisler (3):
      libnvdimm, pmem: Do not flush power-fail protected CPU caches
      libnvdimm, pmem: Unconditionally deep flush on *sync
      pmem: only set QUEUE_FLAG_DAX for fsdax mode

Scott Mayhew (1):
      nfsd: restrict rd_maxcount to svc_max_payload in nfsd_encode_readdir

Sean Wang (1):
      arm: dts: mt7623: fix invalid memory node being generated

Sean Young (1):
      media: rc: mce_kbd decoder: fix stuck keys

Sebastian Sanchez (1):
      IB/hfi1: Optimize kthread pointer locking when queuing CQ entries

Siarhei Liakh (1):
      x86: Call fixup_exception() before notify_die() in math_error()

Sibi Sankar (1):
      remoteproc: Prevent incorrect rproc state on xfer mem ownership failu=
re

Silvio Cesare (1):
      UBIFS: Fix potential integer overflow in allocation

Sinan Kaya (1):
      scsi: hpsa: disable device during shutdown

Sridhar Pitchai (1):
      PCI: hv: Make sure the bus domain is really unique

Srinivas Kandagatla (3):
      ASoC: dapm: delete dapm_kcontrol_data paths list before freeing it
      of: platform: stop accessing invalid dev in of_platform_device_destroy
      rpmsg: smd: do not use mananged resources for endpoints and channels

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix scaling max/min limits with Turbo 3.0

Stefan M Schaeckeler (1):
      of: unittest: for strings, account for trailing \0 in property length=
 field

Steffen Maier (7):
      scsi: zfcp: fix missing SCSI trace for result of eh_host_reset_handler
      scsi: zfcp: fix missing SCSI trace for retry of abort / scsi_eh TMF
      scsi: zfcp: fix misleading REC trigger trace where erp_action setup f=
ailed
      scsi: zfcp: fix missing REC trigger trace on terminate_rport_io early=
 return
      scsi: zfcp: fix missing REC trigger trace on terminate_rport_io for E=
RP_FAILED
      scsi: zfcp: fix missing REC trigger trace for all objects in ERP_FAIL=
ED
      scsi: zfcp: fix missing REC trigger trace on enqueue without ERP thre=
ad

Steven Rostedt (VMware) (2):
      ftrace/selftest: Have the reset_trigger code be a bit more careful
      tracing: Check for no filter when processing event filters

Tadeusz Struk (2):
      tpm: fix use after free in tpm2_load_context()
      tpm: fix race condition in tpm_common_write()

Takashi Iwai (4):
      ALSA: timer: Fix UBSAN warning at SNDRV_TIMER_IOCTL_NEXT_DEVICE ioctl
      ALSA: hda - Force to link down at runtime suspend on ATI/AMD HDMI
      ALSA: hda/realtek - Fix pop noise on Lenovo P50 & co
      ALSA: hda/realtek - Add a quirk for FSC ESPRIMO U9210

Tejun Heo (1):
      fuse: fix congested state leak on aborted connections

Terry Zhou (1):
      pinctrl: armada-37xx: Fix spurious irq management

Tetsuo Handa (2):
      printk: fix possible reuse of va_list variable
      fuse: don't keep dead fuse_conn at fuse_fill_super().

Thor Thayer (2):
      ARM: dts: Fix SPI node for Arria10
      arm64: dts: stratix10: Fix SPI nodes for Stratix10

Tokunori Ikegami (2):
      mtd: cfi_cmdset_0002: Change write buffer to check correct value
      MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum

Tony Luck (3):
      x86/mce: Improve error message when kernel cannot recover
      x86/mce: Check for alternate indication of machine check recovery on =
Skylake
      x86/mce: Fix incorrect "Machine check from unknown source" message

Trond Myklebust (2):
      NFSv4: Revert commit 5f83d86cf531d ("NFSv4.x: Fix wraparound issues..=
")
      NFSv4: Fix a typo in nfs41_sequence_process

Ulf Hansson (1):
      PM / Domains: Fix error path during attach in genpd

Vaibhav Jain (2):
      cxl: Configure PSL to not use APC virtual machines
      cxl: Disable prefault_mode in Radix mode

Waiman Long (1):
      locking/rwsem: Fix up_read_non_owner() warning with DEBUG_RWSEMS

Waldemar Rymarkiewicz (1):
      PM / OPP: Update voltage in case freq =3D=3D old_freq

Wenwen Wang (1):
      virt: vbox: Only copy_from_user the request-header once

Will Deacon (2):
      arm64: kpti: Use early_param for kpti=3D command-line option
      arm64: mm: Ensure writes to swapper are ordered wrt subsequent cache =
maintenance

Wolfram Sang (3):
      mmc: renesas_sdhi: really fix WP logic regressions
      Revert "i2c: algo-bit: init the bus to a known state"
      i2c: gpio: initialize SCL to HIGH again

Yang Yingliang (1):
      irqchip/gic-v3-its: Don't bind LPI to unavailable NUMA node

mike.travis@hpe.com (3):
      x86/platform/UV: Add adjustable set memory block size function
      x86/platform/UV: Use new set memory block size function
      x86/platform/UV: Add kernel parameter to set memory block size

ming_qian (1):
      media: uvcvideo: Support realtek's UVC 1.5 device


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAls7YMkACgkQONu9yGCS
aT5WKw/9H6nfvumb8qZ5YDWjLdZMyw2rU6fw3odg4TMuU/8TO7atTs4hguVC1nA3
1css3I4yzF+Ui1kZm/hJwO8vSREft7OoA0EhTKeohodp4Ma4oRkCCe/YjUlO502P
7NAiclelgYdABaog8YVIGrv8jkVZ3Fkgo3nlRMcllzVXhO6P1BUboEmy/JAjrCUY
qOLYOdBPcClz90dEwUEbXRLCw4HBg6WSwAdksUpIacfIGLRmEjNIl4xdb6UHCTN/
7flm7c5OVdmXjiWSjEtVZVex9mdKA1PCBN7xw8RZckMGq8hTzX1DJ2uZnwrNVOVF
Rk5H7UZ94+oZla0cL6+nnuIjdgz8istcgGZXVCHpCoRrhQXQRN1cVmo0O+YM8xHr
Pn5fLt+I2EYdsMLX3es6b7r3n1abjsqGs7YpbBw8o+R/jsyjEZ+fq3CkohxQwgZF
wy36Sz3Y9A6RlAU4W/cb0CNKYwEU91Yk8E622zFyHzqyomFj26K+EWEDOc56xVL0
74vVMWf7eR58cRmPAdc7MGTJ7jyZdaof1o8IiIs4N+QIoJjpGYuw256liMtWflA1
pNWjFPlos706NJKHE2c8IXLkz+/LOvgjuK9xUmmmCxMAI5cVnt2iohAhtNKbU71g
9Dmisysb5EdkApiHS5mV9yUb6tYqHj72/z2kLUzJwn+2zZ9Uwgk=
=3DUo
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
