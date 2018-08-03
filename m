Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15BFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F24214FB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F24214FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeHCIXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:23:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47116 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeHCIXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:23:44 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 50B47C50;
        Fri,  3 Aug 2018 06:28:54 +0000 (UTC)
Date:   Fri, 3 Aug 2018 08:28:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.60
Message-ID: <20180803062851.GA11325@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.60 kernel.

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

 Documentation/devicetree/bindings/net/dsa/qca8k.txt                 |   23=
 +-
 Documentation/devicetree/bindings/net/meson-dwmac.txt               |    1=
=20
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt         |    2=
=20
 Documentation/vfio-mediated-device.txt                              |    5=
=20
 Makefile                                                            |    2=
=20
 arch/arm/boot/dts/emev2.dtsi                                        |    5=
=20
 arch/arm/boot/dts/sh73a0.dtsi                                       |    5=
=20
 arch/arm/boot/dts/stih407-pinctrl.dtsi                              |   10=
=20
 arch/arm/net/bpf_jit_32.c                                           |   10=
=20
 arch/arm64/boot/dts/renesas/salvator-common.dtsi                    |   38=
 +--
 arch/arm64/configs/defconfig                                        |    2=
=20
 arch/arm64/include/asm/cmpxchg.h                                    |    4=
=20
 arch/arm64/mm/init.c                                                |    4=
=20
 arch/microblaze/boot/Makefile                                       |   10=
=20
 arch/powerpc/include/asm/barrier.h                                  |   15=
 +
 arch/powerpc/include/asm/cache.h                                    |    3=
=20
 arch/powerpc/kernel/eeh_driver.c                                    |   28=
 +-
 arch/powerpc/kernel/head_8xx.S                                      |    2=
=20
 arch/powerpc/kernel/pci_32.c                                        |    1=
=20
 arch/powerpc/kernel/prom_init.c                                     |  114=
 +++++-----
 arch/powerpc/lib/string.S                                           |    7=
=20
 arch/powerpc/mm/slb.c                                               |    8=
=20
 arch/powerpc/net/bpf_jit_comp64.c                                   |   34=
 ++
 arch/powerpc/platforms/chrp/time.c                                  |    6=
=20
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c                       |    5=
=20
 arch/powerpc/platforms/powermac/bootx_init.c                        |    4=
=20
 arch/powerpc/platforms/powermac/setup.c                             |    1=
=20
 arch/s390/include/asm/cpu_mf.h                                      |    6=
=20
 arch/x86/events/intel/uncore.c                                      |    2=
=20
 arch/x86/events/intel/uncore_nhmex.c                                |    2=
=20
 arch/x86/kernel/cpu/microcode/core.c                                |    6=
=20
 arch/x86/kvm/mmu.c                                                  |    2=
=20
 block/bfq-iosched.c                                                 |    2=
=20
 block/bio.c                                                         |   19=
 -
 crypto/authenc.c                                                    |    1=
=20
 crypto/authencesn.c                                                 |    1=
=20
 drivers/acpi/acpi_lpss.c                                            |    6=
=20
 drivers/acpi/pci_root.c                                             |    4=
=20
 drivers/ata/libata-eh.c                                             |   12=
 -
 drivers/bluetooth/btusb.c                                           |    4=
=20
 drivers/bluetooth/hci_qca.c                                         |    2=
=20
 drivers/bus/arm-ccn.c                                               |   20=
 -
 drivers/char/random.c                                               |   10=
=20
 drivers/edac/altera_edac.c                                          |    2=
=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                          |    8=
=20
 drivers/gpu/drm/drm_atomic.c                                        |    4=
=20
 drivers/gpu/drm/drm_atomic_helper.c                                 |   78=
 +++---
 drivers/gpu/drm/drm_dp_mst_topology.c                               |    9=
=20
 drivers/gpu/drm/gma500/psb_intel_drv.h                              |    2=
=20
 drivers/gpu/drm/gma500/psb_intel_lvds.c                             |    2=
=20
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c                    |    8=
=20
 drivers/gpu/drm/radeon/radeon_connectors.c                          |   10=
=20
 drivers/hid/hid-plantronics.c                                       |    6=
=20
 drivers/hid/i2c-hid/i2c-hid.c                                       |    8=
=20
 drivers/i2c/i2c-core-base.c                                         |    5=
=20
 drivers/infiniband/core/mad.c                                       |   11=
=20
 drivers/infiniband/core/ucma.c                                      |    6=
=20
 drivers/infiniband/core/uverbs_cmd.c                                |    5=
=20
 drivers/infiniband/core/verbs.c                                     |   12=
 -
 drivers/infiniband/ulp/srpt/ib_srpt.c                               |   16=
 -
 drivers/input/mouse/elan_i2c_core.c                                 |    2=
=20
 drivers/input/serio/i8042-x86ia64io.h                               |    7=
=20
 drivers/irqchip/irq-ls-scfg-msi.c                                   |    3=
=20
 drivers/lightnvm/pblk-rb.c                                          |    5=
=20
 drivers/md/md.c                                                     |    3=
=20
 drivers/md/raid1.c                                                  |    2=
=20
 drivers/media/common/siano/smsendian.c                              |   14=
 -
 drivers/media/i2c/smiapp/smiapp-core.c                              |   11=
=20
 drivers/media/media-device.c                                        |   21=
 -
 drivers/media/pci/saa7164/saa7164-fw.c                              |    3=
=20
 drivers/media/pci/tw686x/tw686x-video.c                             |    3=
=20
 drivers/media/platform/omap3isp/isp.c                               |    7=
=20
 drivers/media/platform/rcar_jpu.c                                   |    4=
=20
 drivers/media/radio/si470x/radio-si470x-i2c.c                       |    6=
=20
 drivers/media/v4l2-core/videobuf2-core.c                            |    9=
=20
 drivers/memory/tegra/mc.c                                           |   22=
 -
 drivers/memory/tegra/mc.h                                           |    9=
=20
 drivers/memory/tegra/tegra114.c                                     |    2=
=20
 drivers/memory/tegra/tegra124.c                                     |    6=
=20
 drivers/memory/tegra/tegra210.c                                     |    3=
=20
 drivers/memory/tegra/tegra30.c                                      |    2=
=20
 drivers/mfd/cros_ec.c                                               |    6=
=20
 drivers/mmc/core/pwrseq_simple.c                                    |   14=
 -
 drivers/mmc/host/dw_mmc.c                                           |    4=
=20
 drivers/mtd/nand/fsl_ifc_nand.c                                     |   17=
 -
 drivers/net/dsa/qca8k.c                                             |   52=
 ++++
 drivers/net/dsa/qca8k.h                                             |    7=
=20
 drivers/net/ethernet/amazon/ena/ena_com.c                           |    1=
=20
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                           |    4=
=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                           |    3=
=20
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c             |    7=
=20
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c              |    4=
=20
 drivers/net/ethernet/intel/e1000e/netdev.c                          |   15=
 -
 drivers/net/ethernet/intel/i40e/i40e_ptp.c                          |    7=
=20
 drivers/net/ethernet/intel/igb/igb_main.c                           |    9=
=20
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c                   |    1=
=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c            |    4=
=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                   |    2=
=20
 drivers/net/ethernet/ti/cpsw-phy-sel.c                              |    8=
=20
 drivers/net/hyperv/hyperv_net.h                                     |    2=
=20
 drivers/net/hyperv/netvsc_drv.c                                     |   43=
 +--
 drivers/net/phy/mdio-mux-bcm-iproc.c                                |    2=
=20
 drivers/net/phy/phylink.c                                           |    2=
=20
 drivers/net/usb/lan78xx.c                                           |    2=
=20
 drivers/net/wireless/ath/regd.h                                     |    5=
=20
 drivers/net/wireless/ath/regd_common.h                              |   13=
 +
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c           |    1=
=20
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                        |    2=
=20
 drivers/net/wireless/marvell/mwifiex/usb.c                          |    3=
=20
 drivers/net/wireless/marvell/mwifiex/util.c                         |    8=
=20
 drivers/net/wireless/rsi/rsi_91x_hal.c                              |   35=
 +--
 drivers/net/wireless/rsi/rsi_91x_sdio.c                             |   23=
 +-
 drivers/net/wireless/rsi/rsi_sdio.h                                 |    2=
=20
 drivers/net/wireless/ti/wlcore/sdio.c                               |    5=
=20
 drivers/net/xen-netfront.c                                          |   10=
=20
 drivers/nvme/host/pci.c                                             |    5=
=20
 drivers/nvme/host/rdma.c                                            |   10=
=20
 drivers/nvmem/core.c                                                |    7=
=20
 drivers/pci/host/pci-xgene.c                                        |    1=
=20
 drivers/pci/hotplug/pciehp_hpc.c                                    |    7=
=20
 drivers/pci/pci-sysfs.c                                             |   15=
 -
 drivers/pci/probe.c                                                 |    4=
=20
 drivers/pinctrl/pinctrl-at91-pio4.c                                 |    4=
=20
 drivers/regulator/cpcap-regulator.c                                 |    2=
=20
 drivers/regulator/of_regulator.c                                    |   13=
 -
 drivers/regulator/pfuze100-regulator.c                              |    1=
=20
 drivers/regulator/twl-regulator.c                                   |    2=
=20
 drivers/rtc/interface.c                                             |    5=
=20
 drivers/rtc/rtc-tps6586x.c                                          |   14=
 -
 drivers/rtc/rtc-tps65910.c                                          |   12=
 -
 drivers/rtc/rtc-vr41xx.c                                            |    9=
=20
 drivers/s390/scsi/zfcp_dbf.c                                        |    2=
=20
 drivers/scsi/3w-9xxx.c                                              |    5=
=20
 drivers/scsi/3w-xxxx.c                                              |    3=
=20
 drivers/scsi/cxlflash/main.c                                        |   11=
=20
 drivers/scsi/cxlflash/sislite.h                                     |    1=
=20
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                              |   11=
=20
 drivers/scsi/megaraid.c                                             |    3=
=20
 drivers/scsi/megaraid/megaraid_sas_fusion.c                         |    3=
=20
 drivers/scsi/qedf/qedf_main.c                                       |   10=
=20
 drivers/scsi/scsi_dh.c                                              |    5=
=20
 drivers/scsi/ufs/ufshcd.c                                           |   28=
 +-
 drivers/soc/imx/gpcv2.c                                             |   22=
 +
 drivers/spi/spi-meson-spicc.c                                       |   11=
=20
 drivers/spi/spi-s3c64xx.c                                           |    4=
=20
 drivers/spi/spi-sh-msiof.c                                          |    6=
=20
 drivers/spi/spi.c                                                   |    1=
=20
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c                 |    2=
=20
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c              |   30=
 +-
 drivers/staging/lustre/lustre/ldlm/ldlm_lock.c                      |    6=
=20
 drivers/staging/lustre/lustre/llite/xattr.c                         |    6=
=20
 drivers/staging/media/atomisp/i2c/ov2680.c                          |    6=
=20
 drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_ioctl32.c |   49=
 ++--
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c      |    1=
=20
 drivers/thermal/samsung/exynos_tmu.c                                |    1=
=20
 drivers/tty/hvc/hvc_opal.c                                          |    1=
=20
 drivers/tty/pty.c                                                   |    3=
=20
 drivers/usb/core/hub.c                                              |    4=
=20
 drivers/usb/gadget/udc/renesas_usb3.c                               |    8=
=20
 drivers/vfio/mdev/mdev_core.c                                       |  102=
 +++-----
 drivers/vfio/mdev/mdev_private.h                                    |    2=
=20
 drivers/vfio/platform/vfio_platform_common.c                        |   15=
 -
 drivers/vfio/vfio_iommu_type1.c                                     |   73=
 ++++--
 drivers/video/backlight/pwm_bl.c                                    |    6=
=20
 drivers/watchdog/da9063_wdt.c                                       |   17=
 +
 fs/block_dev.c                                                      |    9=
=20
 fs/btrfs/inode.c                                                    |   33=
 +-
 fs/btrfs/qgroup.c                                                   |   19=
 +
 fs/btrfs/tree-log.c                                                 |   10=
=20
 fs/ceph/super.c                                                     |    2=
=20
 fs/crypto/crypto.c                                                  |   11=
=20
 fs/ext4/balloc.c                                                    |    3=
=20
 fs/ext4/ialloc.c                                                    |    8=
=20
 fs/ext4/inline.c                                                    |   19=
 -
 fs/ext4/inode.c                                                     |   16=
 -
 fs/ext4/super.c                                                     |    8=
=20
 fs/f2fs/data.c                                                      |    8=
=20
 fs/f2fs/file.c                                                      |   18=
 +
 fs/f2fs/gc.c                                                        |   11=
=20
 fs/f2fs/segment.c                                                   |    5=
=20
 fs/f2fs/super.c                                                     |    6=
=20
 fs/nfs/nfs4proc.c                                                   |   14=
 -
 fs/nfs/pnfs.c                                                       |    6=
=20
 fs/nfsd/nfs4xdr.c                                                   |    2=
=20
 fs/overlayfs/super.c                                                |   19=
 +
 fs/proc/task_mmu.c                                                  |   26=
 +-
 fs/squashfs/cache.c                                                 |    3=
=20
 fs/squashfs/file.c                                                  |    8=
=20
 fs/squashfs/fragment.c                                              |    4=
=20
 fs/squashfs/squashfs_fs.h                                           |    6=
=20
 include/drm/drm_dp_helper.h                                         |    1=
=20
 include/linux/delayacct.h                                           |    4=
=20
 include/linux/dma-iommu.h                                           |    1=
=20
 include/linux/mmc/sdio_ids.h                                        |    1=
=20
 include/linux/netfilter/ipset/ip_set_timeout.h                      |   10=
=20
 include/linux/regulator/consumer.h                                  |    1=
=20
 include/linux/serial_core.h                                         |    3=
=20
 include/linux/thread_info.h                                         |    6=
=20
 include/net/tcp.h                                                   |    2=
=20
 include/soc/tegra/mc.h                                              |    2=
=20
 include/uapi/sound/asoc.h                                           |   23=
 +-
 kernel/auditfilter.c                                                |    2=
=20
 kernel/auditsc.c                                                    |    2=
=20
 kernel/bpf/verifier.c                                               |    4=
=20
 kernel/delayacct.c                                                  |   17=
 -
 kernel/fork.c                                                       |    3=
=20
 kernel/hung_task.c                                                  |   11=
=20
 kernel/kcov.c                                                       |    3=
=20
 kernel/kthread.c                                                    |    8=
=20
 kernel/power/suspend.c                                              |   14=
 -
 kernel/printk/printk_safe.c                                         |    2=
=20
 kernel/stop_machine.c                                               |   24=
 +-
 kernel/trace/trace_events_trigger.c                                 |   18=
 +
 kernel/trace/trace_kprobe.c                                         |   15=
 +
 mm/slub.c                                                           |    2=
=20
 mm/vmalloc.c                                                        |    3=
=20
 net/ipv4/fib_frontend.c                                             |    4=
=20
 net/ipv4/ipconfig.c                                                 |   13=
 +
 net/ipv4/tcp_bbr.c                                                  |    4=
=20
 net/ipv4/tcp_dctcp.c                                                |    4=
=20
 net/ipv4/tcp_input.c                                                |   48=
 ++--
 net/netfilter/ipset/ip_set_hash_gen.h                               |    5=
=20
 net/netfilter/nf_tables_api.c                                       |   11=
=20
 net/netlink/af_netlink.c                                            |    5=
=20
 security/integrity/ima/ima_main.c                                   |    1=
=20
 sound/pci/emu10k1/emupcm.c                                          |    4=
=20
 sound/pci/emu10k1/memory.c                                          |    6=
=20
 sound/pci/fm801.c                                                   |   16=
 +
 sound/pci/hda/patch_ca0132.c                                        |    8=
=20
 sound/soc/soc-pcm.c                                                 |    6=
=20
 sound/soc/soc-topology.c                                            |   19=
 +
 sound/usb/pcm.c                                                     |    2=
=20
 tools/perf/util/parse-events.y                                      |   14=
 +
 tools/testing/selftests/intel_pstate/run.sh                         |   29=
 +-
 tools/testing/selftests/memfd/run_tests.sh                          |   14=
 -
 tools/usb/usbip/libsrc/vhci_driver.c                                |   32=
 +-
 tools/usb/usbip/libsrc/vhci_driver.h                                |    3=
=20
 tools/usb/usbip/src/usbip_detach.c                                  |    9=
=20
 238 files changed, 1564 insertions(+), 825 deletions(-)

Alex Williamson (2):
      vfio/mdev: Check globally for duplicate devices
      vfio/type1: Fix task tracking for QEMU vCPU hotplug

Alexandre Belloni (4):
      rtc: ensure rtc_set_alarm fails when alarms are not supported
      rtc: tps6586x: fix possible race condition
      rtc: vr41xx: fix possible race condition
      rtc: tps65910: fix possible race condition

Alexey Khoroshilov (1):
      spi: meson-spicc: Fix error handling in meson_spicc_probe()

Alexey Kodanev (1):
      netfilter: nf_tables: check msg_type before nft_trans_set(trans)

Anatoly Pugachev (1):
      disable loading f2fs module on PAGE_SIZE > 4KB

Andrew Morton (2):
      drivers/infiniband/core/verbs.c: fix build with gcc-4.4.4
      drivers/infiniband/ulp/srpt/ib_srpt.c: fix build with gcc-4.4.4

Andrey Smirnov (1):
      soc: imx: gpcv2: Do not pass static memory as platform data

Andy Shevchenko (1):
      drm/dp/mst: Fix off-by-one typo when dump payload table

Anson Huang (1):
      regulator: pfuze100: add .is_enable() for pfuze100_swb_regulator_ops

Anton Vasilyev (1):
      net: mdio-mux: bcm-iproc: fix wrong getter and setter pair

Artem Savkov (1):
      tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failu=
re

Bart Van Assche (2):
      RDMA/core: Avoid that ib_drain_qp() triggers an out-of-bounds stack a=
ccess
      IB/srpt: Fix an out-of-bounds stack access in srpt_zerolength_write()

Bartlomiej Zolnierkiewicz (1):
      thermal: exynos: fix setting rising_threshold for Exynos5433

Ben Skeggs (1):
      drm/nouveau/fifo/gk104-: poll for runlist update completion

Benjamin Poirier (1):
      e1000e: Ignore TSYNCRXCTL when getting I219 clock attributes

Brad Love (1):
      media: saa7164: Fix driver name in debug output

Chad Dupuis (1):
      scsi: qedf: Set the UNLOADING flag when removing a vport

Chao Yu (5):
      f2fs: fix error path of move_data_page
      f2fs: fix to don't trigger writeback during recovery
      f2fs: fix to wait page writeback during revoking atomic write
      f2fs: fix to detect failure of dquot_initialize
      f2fs: fix race in between GC and atomic open

Chen-Yu Tsai (1):
      Input: i8042 - add Lenovo LaVie Z to the i8042 reset list

Chengguang Xu (2):
      ceph: fix alignment of rasize
      ovl: Sync upper dirty data when syncing overlayfs

Chintan Pandya (1):
      mm: vmalloc: avoid racy handling of debugobjects in vunmap

Chris Novakovic (1):
      ipconfig: Correctly initialise ic_nameservers

Christoph Hellwig (1):
      PCI: Prevent sysfs disable of device while driver is attached

Christophe Leroy (2):
      powerpc/lib: Adjust .balign inside string functions for PPC32
      powerpc/8xx: fix invalid register expression in head_8xx.S

Colin Ian King (1):
      media: smiapp: fix timeout checking in smiapp_read_nvm

Cong Wang (1):
      infiniband: fix a possible use-after-free bug

DaeRyong Jeong (1):
      tty: Fix data race in tty_insert_flip_string_fixed_flag

Damien Le Moal (1):
      libata: Fix command retry decision

Dan Carpenter (1):
      scsi: megaraid: silence a static checker bug

Daniel D=C3=ADaz (1):
      selftests/intel_pstate: Improve test, minor fixes

David Sterba (1):
      btrfs: add barriers to btrfs_sync_log before log_commit_wait wakeups

Dmitry Osipenko (2):
      memory: tegra: Do not handle spurious interrupts
      memory: tegra: Apply interrupts mask per SoC

Dmitry Safonov (2):
      netlink: Do not subscribe to non-existent groups
      netlink: Don't shift with UB on nlk->ngroups

Dmitry Torokhov (1):
      HID: i2c-hid: check if device is there before really probing

Dominik Bozek (1):
      usb: hub: Don't wait for connect state at resume for powered-off ports

Donald Shanty III (1):
      Input: elan_i2c - add ACPI ID for lenovo ideapad 330

Doug Oucahrek (1):
      staging: lustre: o2iblnd: fix race at kiblnd_connect_peer

Doug Oucharek (1):
      staging: lustre: o2iblnd: Fix FastReg map/unmap for MLX5

Douglas Anderson (2):
      serial: core: Make sure compiler barfs for 16-byte earlycon names
      regulator: Don't return or expect -errno from of_map_mode()

Emil Tantilov (1):
      ixgbevf: fix MAC address changes through ixgbevf_set_mac()

Enric Balletbo i Serra (1):
      arm64: defconfig: Enable Rockchip io-domain driver

Eric Biggers (1):
      fscrypt: use unbound workqueue for decryption

Eric Dumazet (4):
      tcp: do not force quickack when receiving out-of-order packets
      tcp: add max_quickacks param to tcp_incr_quickack and tcp_enter_quick=
ack_mode
      tcp: do not aggressively quick ack after ECN events
      tcp: add one more quick ack after after ECN events

Ethan Lien (1):
      btrfs: balance dirty metadata pages in btrfs_finish_ordered_io

Eugeniy Paltsev (1):
      NET: stmmac: align DMA stuff to largest cache line length

Eyal Reizer (1):
      wlcore: sdio: check for valid platform device data before suspend

Ezequiel Garcia (1):
      media: tw686x: Fix incorrect vb2_mem_ops GFP flags

Filippo Muzzini (1):
      block, bfq: remove wrong lock in bfq_requests_merged

Florent Fourcot (1):
      netfilter: ipset: forbid family for hash:mac sets

Florian Fainelli (1):
      net: phy: phylink: Release link GPIO

Fuyun Liang (1):
      net: hns3: Fixes the init of the VALID BD info in the descriptor

Gal Pressman (1):
      net: ena: Fix use of uninitialized DMA address bits field

Ganapathi Bhat (1):
      mwifiex: handle race during mwifiex_usb_disconnect

Geert Uytterhoeven (4):
      vfio: platform: Fix reset module leak in error path
      spi: sh-msiof: Fix setting SIRMDR1.SYNCAC to match SITMDR1.SYNCAC
      ARM: dts: emev2: Add missing interrupt-affinity to PMU node
      ARM: dts: sh73a0: Add missing interrupt-affinity to PMU node

Gioh Kim (1):
      md/raid1: add error handling of read error from FailFast device

Greg Edwards (1):
      block: reset bi_iter.bi_done after splitting bio

Greg Kroah-Hartman (1):
      Linux 4.14.60

Grygorii Strashko (1):
      net: ethernet: ti: cpsw-phy-sel: check bus_find_device() ret value

Hans Verkuil (1):
      media: videobuf2-core: don't call memop 'finish' when queueing

Hans de Goede (1):
      ACPI / LPSS: Only call pwm_add_table() for Bay Trail PWM if PMIC HRV =
is 2

Huang Ying (1):
      mm: /proc/pid/pagemap: hide swap entries from unprivileged users

Huazhong Tan (1):
      net: hns3: Fixes the out of bounds access in hclge_map_tqp

Jacob Keller (1):
      i40e: free the skb after clearing the bitlock

Jaegeuk Kim (1):
      f2fs: avoid fsync() failure caused by EAGAIN in writepage()

Jakub Kicinski (1):
      bpf: fix references to free_bpf_prog_info() in comments

James Simmons (1):
      staging: lustre: llite: correct removexattr detection

Jan Kiszka (1):
      PCI: Fix devm_pci_alloc_host_bridge() memory leak

Jane Wan (1):
      mtd: rawnand: fsl_ifc: fix FSL NAND driver to read all ONFI parameter=
 pages

Javier Gonz=C3=A1lez (1):
      lightnvm: pblk: warn in case of corrupted write buffer

Jens Remus (1):
      scsi: zfcp: assert that the ERP lock is held when tracing a recovery =
trigger

Jian-Hong Pan (1):
      Bluetooth: btusb: Add a new Realtek 8723DE ID 2ff8:b011

Jianchao Wang (1):
      nvme-rdma: stop admin queue before freeing it

Jiri Olsa (1):
      perf tools: Fix pmu events parsing rule

Johannes Weiner (1):
      arm64: fix vmemmap BUILD_BUG_ON() triggering on !vmemmap setups

Jonathan Neusch=C3=A4fer (1):
      powerpc/embedded6xx/hlwd-pic: Prevent interrupts from being handled b=
y Starlet

Jos=C3=A9 Roberto de Souza (1):
      drm: Add DP PSR2 sink enable bit

Jozsef Kadlecsik (1):
      netfilter: ipset: List timing out entries with "timeout 1" instead of=
 zero

Juergen Gross (1):
      xen/netfront: raise max number of slots in xennet_get_responses()

Julia Lawall (1):
      pinctrl: at91-pio4: add missing of_node_put

KT Liao (1):
      Input: elan_i2c - add another ACPI ID for Lenovo Ideapad 330-15AST

Kai Chieh Chuang (1):
      ASoC: dpcm: fix BE dai not hw_free and shutdown

Kan Liang (2):
      perf/x86/intel/uncore: Correct fixed counter index check in generic c=
ode
      perf/x86/intel/uncore: Correct fixed counter index check for NHM

Kees Cook (1):
      fork: unconditionally clear stack on fork

Keith Busch (1):
      nvme-pci: Fix AER reset handling

Kirill Marinushkin (2):
      ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
      ASoC: topology: Add missing clock gating parameter when parsing hw_co=
nfigs

Kuninori Morimoto (1):
      arm64: dts: renesas: salvator-common: use audio-graph-card for Sound

Laurentiu Tudor (1):
      irqchip/ls-scfg-msi: Map MSIs in the iommu

Leon Romanovsky (2):
      RDMA/mad: Convert BUG_ONs to error flows
      RDMA/uverbs: Protect from attempts to create flows on unsupported QP

Linus Torvalds (1):
      squashfs: be more careful about metadata corruption

Lixin Wang (1):
      i2c: core: decrease reference count of device node in i2c_unregister_=
device

Lorenzo Bianconi (1):
      ipv4: remove BUG_ON() from fib_compute_spec_dst

Lorenzo Pieralisi (1):
      PCI: xgene: Remove leftover pci_scan_child_bus() call

Luc Van Oostenryck (2):
      drm/radeon: fix mode_valid's return type
      drm/gma500: fix psb_intel_lvds_mode_valid()'s return type

Lukas Wunner (1):
      PCI: pciehp: Assume NoCompl+ for Thunderbolt ports

Marc Zyngier (1):
      dma-iommu: Fix compilation when !CONFIG_IOMMU_DMA

Marco Felsch (1):
      watchdog: da9063: Fix updating timeout value

Marek Szyprowski (1):
      spi: spi-s3c64xx: Fix system resume support

Mark Rutland (2):
      kcov: ensure irq code sees a valid area
      drivers/perf: arm-ccn: don't log to dmesg in event_init

Martin Blumenstingl (1):
      dt-bindings: pinctrl: meson: add support for the Meson8m2 SoC

Martin Wilck (2):
      block: bio_iov_iter_get_pages: fix size of last iovec
      blkdev: __blkdev_direct_IO_simple: fix leak in error case

Mathieu Malaterre (7):
      mm/slub.c: add __printf verification to slab_err()
      powerpc/32: Add a missing include header
      powerpc/chrp/time: Make some functions static, add missing header inc=
lude
      powerpc/powermac: Add missing prototype for note_bootable_part()
      powerpc/powermac: Mark variable x as unused
      powerpc: Add __printf verification to prom_printf
      nvmem: properly handle returned value nvmem_reg_read

Matthew R. Ochs (1):
      scsi: cxlflash: Avoid clobbering context control register value

Mauro Carvalho Chehab (4):
      media: atomisp: ov2680: don't declare unused vars
      media: siano: get rid of __le32/__le16 cast warnings
      media: atomisp: compat32: fix __user annotations
      media: si470x: fix __be16 annotations

Maya Erez (1):
      scsi: ufs: fix exception event handling

Michael Chan (1):
      bnxt_en: Check unsupported speeds in bnxt_update_link() on PF only.

Michael Grzeschik (1):
      usbip: dynamically allocate idev by nports found in sysfs

Michal Simek (1):
      microblaze: Fix simpleImage format generation

Michal Suchanek (1):
      powerpc/64s: Add barrier_nospec

Michal Vok=C3=A1=C4=8D (5):
      net: dsa: qca8k: Add support for QCA8334 switch
      net: dsa: qca8k: Force CPU port to its highest bandwidth
      net: dsa: qca8k: Enable RXMAC when bringing up a port
      net: dsa: qca8k: Add QCA8334 binding documentation
      net: dsa: qca8k: Allow overwriting CPU port setting

Mika Westerberg (1):
      PCI: pciehp: Request control of native hotplug only if supported

Mimi Zohar (1):
      ima: based on policy verify firmware signatures (pre-allocated buffer)

Neal Cardwell (1):
      tcp_bbr: fix bw probing to raise in-flight data for very small BDPs

NeilBrown (1):
      staging: lustre: ldlm: free resource when ldlm_lock_create() fails.

Nicholas Piggin (1):
      powerpc/64s: Fix compiler store ordering to SLB shadow area

Olga Kornievskaia (1):
      skip LAYOUTRETURN if layout is invalid

Omar Sandoval (2):
      Btrfs: don't return ino to ino cache if inode item removal fails
      Btrfs: don't BUG_ON() in btrfs_truncate_inode_items()

Ondrej Mosn=C3=A1=C4=8Dek (1):
      audit: allow not equal op for audit by executable

Patrice Chotard (1):
      ARM: dts: stih407-pinctrl: Fix complain about IRQ_TYPE_NONE usage

Petr Machata (1):
      mlxsw: spectrum_switchdev: Fix port_vlan refcounting

Qu Wenruo (1):
      btrfs: qgroup: Finish rescan when hit the last leaf of extent tree

Sahitya Tummala (1):
      f2fs: Fix deadlock in shutdown ioctl

Sam Bobroff (1):
      powerpc/eeh: Fix use-after-release of EEH driver

Sami Tolvanen (1):
      media: media-device: fix ioctl function types

Samuel Li (1):
      drm/amdgpu: Remove VRAM from shared bo domains.

Sandipan Das (1):
      bpf: powerpc64: pad function address loads with NOPs

Satendra Singh Thakur (1):
      drm/atomic: Handling the case when setting old crtc for plane

Scott Mayhew (1):
      nfsd: fix potential use-after-free in nfsd4_decode_getdeviceinfo

Scott Wood (1):
      x86/microcode: Make the late update update_lock a raw lock for RT

Sean Lanigan (1):
      brcmfmac: Add support for bcm43364 wireless chipset

Sebastian Andrzej Siewior (2):
      PM / wakeup: Make s2idle_lock a RAW_SPINLOCK
      delayacct: Use raw_spinlocks

Sergey Senozhatsky (1):
      printk: drop in_nmi check from printk_safe_flush_on_panic()

Shakeel Butt (1):
      kvm, mm: account shadow page tables to kmemcg

Shaul Triebitz (1):
      iwlwifi: pcie: fix race in Rx buffer allocator

Shawn Lin (1):
      mmc: dw_mmc: update actual clock for mmc debugfs

Shivasharan S (1):
      scsi: megaraid_sas: Increase timeout by 1 sec for non-RAID fastpath I=
Os

Shuah Khan (Samsung OSG) (3):
      usbip: usbip_detach: Fix memory, udev context and udev leak
      selftests: memfd: return Kselftest Skip code for skipped tests
      selftests: intel_pstate: return Kselftest Skip code for skipped tests

Siva Rebbagondla (2):
      rsi: Fix 'invalid vdd' warning in mmc
      rsi: fix nommu_map_sg overflow kernel panic

Snild Dolkow (1):
      kthread, tracing: Don't expose half-written comm when creating kthrea=
ds

Stefan Wahren (2):
      staging: vchiq_core: Fix missing semaphore release in error case
      net: lan78xx: fix rx handling before first packet is send

Stephen Hemminger (1):
      hv_netvsc: fix network namespace issues with VF support

Steven Rostedt (VMware) (3):
      tracing: Fix double free of event_trigger_data
      tracing: Fix possible double free in event_enable_trigger_func()
      tracing: Quiet gcc warning about maybe unused link variable

Stewart Smith (1):
      hvc_opal: don't set tb_ticks_per_usec in udbg_init_opal_common()

Subhash Jadavani (1):
      scsi: ufs: ufshcd: fix possible unclocked register access

Suman Anna (1):
      media: omap3isp: fix unbalanced dma_iommu_mapping

Sven Eckelmann (9):
      ath: Add regulatory mapping for FCC3_ETSIC
      ath: Add regulatory mapping for ETSI8_WORLD
      ath: Add regulatory mapping for APL13_WORLD
      ath: Add regulatory mapping for APL2_FCCA
      ath: Add regulatory mapping for Uganda
      ath: Add regulatory mapping for Tanzania
      ath: Add regulatory mapping for Serbia
      ath: Add regulatory mapping for Bermuda
      ath: Add regulatory mapping for Bahamas

Takashi Iwai (2):
      ALSA: emu10k1: Rate-limit error messages about page errors
      ALSA: usb-audio: Apply rate limit to warning messages in URB complete=
 callback

Takashi Sakamoto (1):
      ALSA: hda/ca0132: fix build failure when a local macro is defined

Tejun Heo (1):
      delayacct: fix crash in delayacct_blkio_end() after delayacct init fa=
ilure

Terry Junge (1):
      HID: hid-plantronics: Re-resend Update to map button for PTT products

Tetsuo Handa (1):
      kernel/hung_task.c: show all hung tasks before panic

Theodore Ts'o (4):
      random: mix rdrand with entropy sent in from userspace
      ext4: fix inline data updates with checksums enabled
      ext4: check for allocation block validity with block group locked
      ext4: fix check to prevent initializing reserved inodes

Thierry Escande (1):
      Bluetooth: hci_qca: Fix "Sleep inside atomic section" warning

Thomas Gleixner (1):
      stop_machine: Use raw spinlocks

Thomas Richter (2):
      s390/cpum_sf: Add data entry sizes to sampling trailer entry
      perf: fix invalid bit in diagnostic entry

Thor Thayer (1):
      EDAC, altera: Fix ARM64 build warning

Tobin C. Harding (1):
      mmc: pwrseq: Use kmalloc_array instead of stack VLA

Tony Lindgren (1):
      spi: Add missing pm_runtime_put_noidle() after failed get

Trond Myklebust (2):
      NFSv4.1: Fix the client behaviour on NFS4ERR_SEQ_FALSE_RETRY
      pnfs: Don't release the sequence slot until we've processed layoutget=
 on open

Tudor-Dan Ambarus (2):
      crypto: authencesn - don't leak pointers to authenc keys
      crypto: authenc - don't leak pointers to authenc keys

Uma Krishnan (1):
      scsi: cxlflash: Synchronize reset and remove ops

Vic Wei (1):
      Bluetooth: btusb: add ID for LiteOn 04ca:301a

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/atomic-helper: Drop plane->fb references only for drm_atomic_help=
er_shutdown()

Vincent Palatin (1):
      mfd: cros_ec: Fail early if we cannot identify the EC

Vinicius Costa Gomes (1):
      igb: Fix queue selection on MAC filters on i210

Wang YanQing (1):
      bpf, arm32: fix inconsistent naming about emit_a32_lsr_{r64,i64}

Wei Xu (1):
      nvme: lightnvm: add granby support

Wei Yongjun (1):
      media: rcar_jpu: Add missing clk_disable_unprepare() on error in jpu_=
open()

Wenwen Wang (2):
      scsi: 3w-9xxx: fix a missing-check bug
      scsi: 3w-xxxx: fix a missing-check bug

Will Deacon (1):
      arm64: cmpwait: Clear event register before arming exclusive monitor

Wolfram Sang (1):
      backlight: pwm_bl: Don't use GPIOF_* with gpiod_get_direction

Xi Wang (1):
      net: hns3: Fix the missing client list node initialization

Xiang Chen (1):
      scsi: hisi_sas: config ATA de-reset as an constrained command for v3 =
hw

Xiao Liang (1):
      xen-netfront: wait xenbus state change when load module manually

Xinming Hu (1):
      mwifiex: correct histogram data with appropriate index

Xose Vazquez Perez (1):
      scsi: scsi_dh: replace too broad "TP9" string with the exact models

Yixun Lan (1):
      dt-bindings: net: meson-dwmac: new compatible name for AXG SoC

Yoshihiro Shimoda (1):
      usb: gadget: udc: renesas_usb3: should remove debugfs

Yousuk Seung (1):
      tcp: refactor tcp_ecn_check_ce to remove sk type cast

Yufen Yu (1):
      md: fix NULL dereference of mddev->pers in remove_and_add_spares()

Zhouyang Jia (2):
      ALSA: emu10k1: add error handling for snd_ctl_add
      ALSA: fm801: add error handling for snd_ctl_add

tangpengpeng (1):
      net: fix amd-xgbe flow-control issue


--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltj9iMACgkQONu9yGCS
aT6P5w//aaDDHUNxGRXxyruZRokamQjpB/nS5MfYSKqS7d16M/WHCQ4DUqVJ+6V8
XeWQXbsY6EyNEQerYvq+djBjX+yQdxePt+/toq6USgKOjlFEV4OSrGRCWPJrx8Z4
O9/jnn2kbheF7bNoJZ2LHjq22NKNWcYUvq4naZamIJLEdyxrp3qbexDZVCE8qfin
985iIiFuURbP6ADrlRVRuSled2uY7D/NDOgW1Z98cKmDugWghp3BMg8NXAr8fFzT
1ydx3eQSIX0CDiiNa/f6wSL5yEww6Aul59JfOF1DeXyg8Kq+nUsMnX8MBHZ9vrFZ
9P+K/aoncu+5eEVT9yTrAfV8B6TcIrPGuQzYwe8IL2utCZkdtPQUvlakbWFY+a7Q
8dzcj7CpmjL/wMBGF0m1DPwm5ylF053RW558pjxbZRzeJRYwq4WFWjAbw/aG5g33
HeG33QCOcM4EH6cf4s3fPxtBQKTD2/cehQ1LYa4xMX7JtA2MZv7ic/lj7Ny3xEc6
I7ctZJQ2q4t4gi14Ti3/A/9cXCDLEyK84sY9rjNUwT3MSrjsxkm+dajMwLoVfjHe
SitA+S3znT/WyRZU+zUvLM+DCMoIXyg+7YgPn8CkyErCLmyRH3VDD5kSnhQh4h1I
y5V557urK0lbEGmEHmV3F/itkSUTi4gjPWo83q2gBItw/bylVX4=
=XVQp
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
