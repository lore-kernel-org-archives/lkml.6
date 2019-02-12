Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C46C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3118221B68
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550002402;
	bh=DRvIe6sBN9DbKgyLgU1+AbiRimNsJh7KbHyZdWe1aWU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=l2/cG5NJ5cQjrr8gjQ3Z9Vj7zt+XpnH11kAKnDl/8skEfzWiGR8utFLIogFuss3vg
	 D3fKxblPKQQVbhYGpM5A+VXIB7fUGlNr8KgvqtKaodTgB752T73KyNBfgGrXxpkN4G
	 frD57ffYfkS31jBWOAyMuxuTb+q2S8kqdf0zEKoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfBLUNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:13:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731988AbfBLUNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:13:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB90F21B68;
        Tue, 12 Feb 2019 20:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550002391;
        bh=DRvIe6sBN9DbKgyLgU1+AbiRimNsJh7KbHyZdWe1aWU=;
        h=Date:From:To:Cc:Subject:From;
        b=wOSK/q8LedxbfQ/ouBNwPH8J388I2Ju4LxlNtEb4g/J/ilDs78jjGJz7/K4owtVhN
         FOKO0uVg/wsXsSyEalj30crrjlUOIvMNQfynct52pa/+ZcBm4grDv7l8XuXZt8g8/D
         RBqWhBoEgx9Bbzj7thAujDvMs3gKGX6+Iq2biJJM=
Date:   Tue, 12 Feb 2019 21:13:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.20.8
Message-ID: <20190212201309.GA10672@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.20.8 kernel.

All users of the 4.20 kernel series must upgrade.

The updated 4.20.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.20.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts         |    2=20
 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts               |    2=20
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts                 |    3=20
 arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts            |    2=20
 arch/arm/boot/dts/gemini-dlink-dir-685.dts                   |   16 -
 arch/arm/boot/dts/imx51-zii-rdu1.dts                         |   17 +
 arch/arm/boot/dts/mmp2.dtsi                                  |    9=20
 arch/arm/boot/dts/omap4-sdp.dts                              |    1=20
 arch/arm/kernel/smp.c                                        |   15 +
 arch/arm/mach-omap1/board-ams-delta.c                        |    6=20
 arch/arm/mach-omap2/omap_hwmod.c                             |    6=20
 arch/arm/mach-pxa/cm-x300.c                                  |    2=20
 arch/arm/mach-pxa/littleton.c                                |    2=20
 arch/arm/mach-pxa/zeus.c                                     |    2=20
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                   |    2=20
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    |    2=20
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts          |    1=20
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi            |    1=20
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts            |   20 -
 arch/arm64/include/asm/io.h                                  |   32 +-
 arch/arm64/kernel/entry-ftrace.S                             |    1=20
 arch/mips/boot/dts/img/boston.dts                            |    6=20
 arch/mips/include/asm/mach-jz4740/jz4740_mmc.h               |    2=20
 arch/mips/include/uapi/asm/inst.h                            |    2=20
 arch/mips/jz4740/board-qi_lb60.c                             |   12=20
 arch/nds32/mm/Makefile                                       |    6=20
 arch/powerpc/include/asm/uaccess.h                           |    2=20
 arch/powerpc/kernel/vmlinux.lds.S                            |    4=20
 arch/powerpc/kvm/powerpc.c                                   |    5=20
 arch/powerpc/mm/fault.c                                      |    4=20
 arch/powerpc/perf/isa207-common.c                            |    7=20
 arch/powerpc/platforms/powernv/pci-ioda-tce.c                |    2=20
 arch/powerpc/platforms/pseries/dlpar.c                       |    2=20
 arch/s390/include/uapi/asm/zcrypt.h                          |    4=20
 arch/x86/include/asm/fpu/internal.h                          |    3=20
 arch/x86/pci/broadcom_bus.c                                  |    4=20
 arch/xtensa/boot/dts/xtfpga.dtsi                             |    2=20
 crypto/Kconfig                                               |    3=20
 crypto/aes_ti.c                                              |   18 +
 drivers/acpi/apei/ghes.c                                     |    2=20
 drivers/acpi/spcr.c                                          |   11=20
 drivers/ata/sata_rcar.c                                      |    4=20
 drivers/base/bus.c                                           |   12=20
 drivers/base/core.c                                          |    8=20
 drivers/base/dd.c                                            |    6=20
 drivers/block/drbd/drbd_nl.c                                 |   15 -
 drivers/block/drbd/drbd_receiver.c                           |   13 -
 drivers/block/sunvdc.c                                       |    5=20
 drivers/bluetooth/hci_bcm.c                                  |    4=20
 drivers/clk/imgtec/clk-boston.c                              |   11=20
 drivers/clk/imx/clk-imx6sl.c                                 |    6=20
 drivers/clk/meson/meson8b.c                                  |   16 -
 drivers/clk/qcom/gcc-msm8998.c                               |    6=20
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c                         |    4=20
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c                         |    6=20
 drivers/cpuidle/cpuidle-big_little.c                         |    7=20
 drivers/dma/sprd-dma.c                                       |   25 +-
 drivers/dma/xilinx/zynqmp_dma.c                              |    2=20
 drivers/firmware/efi/vars.c                                  |   99 ++++++=
--
 drivers/fpga/altera-cvp.c                                    |   15 +
 drivers/gpio/gpio-mt7621.c                                   |   10=20
 drivers/gpio/gpiolib.c                                       |   25 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c            |    6=20
 drivers/gpu/drm/amd/display/dc/core/dc_link.c                |   26 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c             |    3=20
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c            |    2=20
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c  |   11=20
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c    |   12=20
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c      |   17 +
 drivers/gpu/drm/drm_atomic_helper.c                          |    8=20
 drivers/gpu/drm/drm_bufs.c                                   |    3=20
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c         |    2=20
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c                   |    8=20
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c                       |   14 -
 drivers/gpu/drm/rockchip/cdn-dp-reg.c                        |    2=20
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c                       |    7=20
 drivers/gpu/drm/v3d/v3d_bo.c                                 |    1=20
 drivers/gpu/drm/v3d/v3d_drv.h                                |    5=20
 drivers/gpu/drm/v3d/v3d_gem.c                                |    8=20
 drivers/gpu/drm/vc4/vc4_plane.c                              |   12=20
 drivers/gpu/drm/vgem/vgem_drv.c                              |   16 -
 drivers/gpu/ipu-v3/ipu-image-convert.c                       |   10=20
 drivers/i2c/busses/i2c-axxia.c                               |   32 +-
 drivers/i2c/busses/i2c-sh_mobile.c                           |    2=20
 drivers/iio/accel/kxcjk-1013.c                               |    1=20
 drivers/iio/adc/meson_saradc.c                               |   14 -
 drivers/infiniband/core/core_priv.h                          |    1=20
 drivers/infiniband/core/device.c                             |   26 +-
 drivers/infiniband/core/nldev.c                              |   20 -
 drivers/infiniband/hw/hfi1/rc.c                              |    2=20
 drivers/iommu/amd_iommu.c                                    |    9=20
 drivers/iommu/arm-smmu-v3.c                                  |   14 -
 drivers/iommu/arm-smmu.c                                     |    3=20
 drivers/lightnvm/core.c                                      |    2=20
 drivers/lightnvm/pblk-core.c                                 |   13 -
 drivers/lightnvm/pblk-write.c                                |    8=20
 drivers/md/raid10.c                                          |    4=20
 drivers/media/i2c/Kconfig                                    |    2=20
 drivers/media/i2c/ad9389b.c                                  |    2=20
 drivers/media/i2c/adv7511.c                                  |    2=20
 drivers/media/i2c/adv7604.c                                  |    4=20
 drivers/media/i2c/adv7842.c                                  |    4=20
 drivers/media/i2c/tc358743.c                                 |    2=20
 drivers/media/i2c/ths8200.c                                  |    2=20
 drivers/media/i2c/video-i2c.c                                |   11=20
 drivers/media/platform/coda/coda-bit.c                       |   19 -
 drivers/media/platform/coda/coda-common.c                    |   15 -
 drivers/media/platform/coda/coda.h                           |    6=20
 drivers/media/platform/coda/coda_regs.h                      |    2=20
 drivers/media/platform/davinci/vpbe.c                        |    7=20
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c        |   10=20
 drivers/media/platform/vivid/vivid-core.c                    |    2=20
 drivers/media/rc/rc-main.c                                   |    2=20
 drivers/media/v4l2-core/v4l2-device.c                        |    1=20
 drivers/memstick/core/memstick.c                             |    3=20
 drivers/mmc/host/bcm2835.c                                   |   12=20
 drivers/mmc/host/jz4740_mmc.c                                |   20 -
 drivers/mmc/host/meson-mx-sdio.c                             |    6=20
 drivers/mmc/host/sdhci-of-esdhc.c                            |   16 -
 drivers/mmc/host/sdhci-omap.c                                |   16 -
 drivers/mmc/host/sdhci-xenon-phy.c                           |   10=20
 drivers/mmc/host/sdhci-xenon.c                               |   10=20
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c |    2=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                    |   19 -
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c             |    5=20
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c              |   30 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c      |    4=20
 drivers/net/ethernet/intel/i40e/i40e.h                       |    1=20
 drivers/net/ethernet/intel/i40e/i40e_main.c                  |    8=20
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c           |    3=20
 drivers/net/ethernet/intel/ice/ice_main.c                    |   16 -
 drivers/net/ethernet/intel/igb/igb_main.c                    |    8=20
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c            |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c          |    4=20
 drivers/net/ethernet/mellanox/mlx5/core/main.c               |   14 -
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c               |   23 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c      |    5=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c     |   27 --
 drivers/net/usb/smsc95xx.c                                   |    1=20
 drivers/net/wireless/ath/ath10k/core.c                       |    1=20
 drivers/net/wireless/ath/ath10k/mac.c                        |   28 +-
 drivers/net/wireless/ath/ath9k/dynack.c                      |    3=20
 drivers/net/wireless/ath/wil6210/main.c                      |   11=20
 drivers/net/wireless/ath/wil6210/txrx.c                      |    2=20
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h              |    2=20
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c            |    8=20
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c               |    4=20
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_dfs.c          |    8=20
 drivers/net/wireless/st/cw1200/scan.c                        |   13 -
 drivers/nvme/host/lightnvm.c                                 |    3=20
 drivers/opp/core.c                                           |   11=20
 drivers/pci/switch/switchtec.c                               |    3=20
 drivers/perf/arm_spe_pmu.c                                   |    5=20
 drivers/phy/allwinner/phy-sun4i-usb.c                        |    7=20
 drivers/pinctrl/bcm/pinctrl-bcm2835.c                        |   16 -
 drivers/pinctrl/meson/pinctrl-meson8.c                       |    3=20
 drivers/pinctrl/meson/pinctrl-meson8b.c                      |   13 -
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c                    |    3=20
 drivers/pinctrl/pinctrl-rza1.c                               |    5=20
 drivers/pinctrl/pinctrl-sx150x.c                             |   11=20
 drivers/platform/chrome/cros_ec_proto.c                      |   18 +
 drivers/platform/x86/intel_atomisp2_pm.c                     |   68 +++--
 drivers/platform/x86/mlx-platform.c                          |   12=20
 drivers/ptp/ptp_chardev.c                                    |    5=20
 drivers/ptp/ptp_clock.c                                      |    5=20
 drivers/s390/crypto/zcrypt_error.h                           |    2=20
 drivers/s390/net/qeth_core.h                                 |    1=20
 drivers/s390/net/qeth_core_main.c                            |   12=20
 drivers/s390/net/qeth_core_mpc.h                             |   25 +-
 drivers/s390/net/qeth_l2_main.c                              |   10=20
 drivers/scsi/cxgbi/cxgb4i/Kconfig                            |    4=20
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                       |    2=20
 drivers/scsi/lpfc/lpfc_els.c                                 |   52 +---
 drivers/scsi/lpfc/lpfc_nportdisc.c                           |    5=20
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                         |    2=20
 drivers/scsi/mpt3sas/mpt3sas_transport.c                     |    7=20
 drivers/scsi/smartpqi/smartpqi_init.c                        |    6=20
 drivers/scsi/smartpqi/smartpqi_sis.c                         |    2=20
 drivers/soc/bcm/brcmstb/common.c                             |    6=20
 drivers/soc/tegra/common.c                                   |    6=20
 drivers/spi/spi-at91-usart.c                                 |    1=20
 drivers/staging/erofs/internal.h                             |    3=20
 drivers/staging/erofs/utils.c                                |  134 ++++++=
+----
 drivers/staging/iio/adc/ad7280a.c                            |   17 +
 drivers/staging/iio/adc/ad7780.c                             |    6=20
 drivers/staging/iio/resolver/ad2s90.c                        |    7=20
 drivers/staging/pi433/pi433_if.c                             |    4=20
 drivers/tee/optee/supp.c                                     |   13 -
 drivers/thermal/thermal_core.c                               |   12=20
 drivers/thermal/thermal_sysfs.c                              |   11=20
 drivers/tty/serial/fsl_lpuart.c                              |    4=20
 drivers/tty/serial/samsung.c                                 |    3=20
 drivers/tty/serial/sh-sci.c                                  |   23 +
 drivers/usb/core/hub.c                                       |   10=20
 drivers/usb/dwc2/params.c                                    |   10=20
 drivers/usb/dwc3/gadget.c                                    |   14 -
 drivers/usb/dwc3/trace.h                                     |    2=20
 drivers/usb/mtu3/mtu3_core.c                                 |    4=20
 drivers/usb/mtu3/mtu3_gadget_ep0.c                           |    8=20
 drivers/usb/musb/musb_dsps.c                                 |   21 +
 drivers/usb/renesas_usbhs/common.c                           |    4=20
 drivers/video/fbdev/clps711x-fb.c                            |    5=20
 drivers/video/fbdev/core/fbcon.c                             |    2=20
 drivers/video/fbdev/core/fbmem.c                             |    8=20
 drivers/virt/vboxguest/vboxguest_core.c                      |    2=20
 drivers/watchdog/renesas_wdt.c                               |    9=20
 fs/btrfs/btrfs_inode.h                                       |    1=20
 fs/btrfs/ctree.h                                             |    2=20
 fs/btrfs/extent_io.c                                         |   17 +
 fs/btrfs/inode.c                                             |   11=20
 fs/btrfs/ioctl.c                                             |    2=20
 fs/btrfs/volumes.c                                           |   29 ++
 fs/dlm/ast.c                                                 |   10=20
 fs/f2fs/acl.c                                                |   14 -
 fs/f2fs/checkpoint.c                                         |    7=20
 fs/f2fs/data.c                                               |   12=20
 fs/f2fs/file.c                                               |    3=20
 fs/f2fs/gc.c                                                 |   15 +
 fs/f2fs/node.c                                               |    5=20
 fs/f2fs/segment.c                                            |    3=20
 fs/nfsd/nfsctl.c                                             |    2=20
 fs/udf/inode.c                                               |    6=20
 include/linux/genl_magic_struct.h                            |    5=20
 include/linux/gpio/consumer.h                                |    6=20
 include/linux/mlx5/driver.h                                  |    2=20
 include/linux/skmsg.h                                        |    8=20
 include/rdma/ib_verbs.h                                      |    8=20
 kernel/irq/affinity.c                                        |    5=20
 kernel/module.c                                              |    6=20
 kernel/time/timekeeping.c                                    |    4=20
 mm/percpu-km.c                                               |    5=20
 net/core/skmsg.c                                             |    7=20
 net/ipv4/tcp_bpf.c                                           |    2=20
 net/ipv6/tcp_ipv6.c                                          |    3=20
 net/ipv6/xfrm6_tunnel.c                                      |    3=20
 net/mac80211/rx.c                                            |   31 +-
 net/mac80211/util.c                                          |   49 ++--
 net/tipc/node.c                                              |    6=20
 samples/livepatch/livepatch-shadow-fix1.c                    |    5=20
 samples/livepatch/livepatch-shadow-mod.c                     |    4=20
 scripts/mod/modpost.c                                        |   50 ++--
 security/smack/smack_lsm.c                                   |   12=20
 sound/soc/fsl/Kconfig                                        |    2=20
 sound/soc/intel/atom/sst/sst_loader.c                        |    8=20
 tools/bpf/bpftool/common.c                                   |    4=20
 tools/bpf/bpftool/json_writer.c                              |    6=20
 tools/bpf/bpftool/map.c                                      |   18 +
 tools/bpf/bpftool/prog.c                                     |    4=20
 tools/bpf/bpftool/xlated_dumper.c                            |    7=20
 tools/hv/hv_kvp_daemon.c                                     |   15 +
 tools/lib/bpf/bpf.c                                          |   11=20
 tools/perf/arch/x86/util/kvm-stat.c                          |    2=20
 tools/perf/tests/attr.py                                     |    2=20
 tools/perf/util/dso.c                                        |    2=20
 tools/perf/util/header.c                                     |    6=20
 tools/perf/util/probe-file.c                                 |    2=20
 tools/perf/util/s390-cpumsf.c                                |    2=20
 tools/perf/util/stat-display.c                               |   16 -
 tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py   |    4=20
 tools/testing/selftests/Makefile                             |    1=20
 tools/testing/selftests/bpf/test_progs.c                     |    8=20
 tools/testing/selftests/drivers/dma-buf/Makefile             |    2=20
 tools/testing/selftests/drivers/dma-buf/udmabuf.c            |   11=20
 virt/kvm/arm/mmio.c                                          |   11=20
 264 files changed, 1752 insertions(+), 725 deletions(-)

Abhinav Kumar (1):
      drm/msm/dsi: fix dsi clock names in DSI 10nm PLL driver

Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      i2c-axxia: check for error conditions first

Adrian Hunter (4):
      mmc: sdhci-of-esdhc: Fix timeout checks
      mmc: sdhci-omap: Fix timeout checks
      mmc: sdhci-xenon: Fix timeout checks
      perf test: Fix perf_event_attr test failure

Akinobu Mita (1):
      media: video-i2c: avoid accessing released memory area when removing =
driver

Alan Brady (1):
      i40e: prevent overlapping tx_timeout recover

Alex Deucher (1):
      drm/amdgpu/powerplay: fix clock stretcher limits on polaris (v2)

Alexander Duyck (1):
      driver core: Move async_synchronize_full call

Alexei Avshalom Lazar (1):
      wil6210: fix reset flow for Talyn-mb

Alexey Kardashevskiy (1):
      powerpc/powernv/ioda: Allocate indirect TCE levels of cached userspac=
e addresses on demand

Alexey Khoroshilov (3):
      media: mtk-vcodec: Release device nodes in mtk_vcodec_init_enc_pm()
      media: DaVinci-VPBE: fix error handling in vpbe_initialize()
      video: clps711x-fb: release disp device node in probe()

Anand Jain (1):
      btrfs: harden agaist duplicate fsid on scanned devices

Anatolij Gustschin (1):
      fpga: altera-cvp: fix 'bad IO access' on x86_64

Andreas Puhm (1):
      fpga: altera-cvp: Fix registration for CvP incapable devices

Andrey Smirnov (1):
      ARM: dts: imx51-zii-rdu1: Do not specify "power-gpio" for hpa1

Andy Duan (1):
      serial: fsl_lpuart: clear parity enable bit when disable parity

Andy Shevchenko (2):
      ACPI: SPCR: Consider baud rate 0 as preconfigured state
      usb: dwc3: trace: add missing break statement to make compiler happy

Anson Huang (1):
      clk: imx6sl: ensure MMDC CH0 handshake is bypassed

Anurag Kumar Vulisha (1):
      usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_=
one_trb()

Arend van Spriel (1):
      firmware/efi: Add NULL pointer checks in efivars API functions

Arnaldo Carvalho de Melo (5):
      perf dso: Fix unchecked usage of strncpy()
      perf header: Fix unchecked usage of strncpy()
      perf probe: Fix unchecked usage of strncpy()
      perf header: Fix up argument to ctime()
      perf tools: Cast off_t to s64 to avoid warning on bionic libc

Arnd Bergmann (5):
      ASoC: Intel: mrfld: fix uninitialized variable access
      vbox: fix link error with 'gcc -Og'
      scsi: cxgb4i: fix thermal configuration dependencies
      media: i2c: TDA1997x: select CONFIG_HDMI
      ARM: pxa: avoid section mismatch warning

Bart Van Assche (1):
      timekeeping: Use proper seqcount initializer

Ben Dooks (1):
      usbnet: smsc95xx: fix rx packet alignment

Beomho Seo (1):
      tty: serial: samsung: Properly set flags in autoCTS mode

Bhawanpreet Lakha (1):
      drm/amd/display: Fix potential nullptr error

Bin Liu (2):
      usb: musb: dsps: fix otg state machine
      usb: musb: dsps: fix runtime pm for peripheral mode

Bob Peterson (1):
      dlm: Don't swamp the CPU with callbacks queued during recovery

Boris Brezillon (1):
      drm/vc4: ->x_scaling[1] should never be set to VC4_SCALING_NONE

Brian Norris (2):
      ath10k: assign 'n_cipher_suites' for WCN3990
      platform/chrome: don't report EC_MKBP_EVENT_SENSOR_FIFO as wakeup

Carlo Caione (1):
      arm64: dts: meson: Fix IRQ trigger type for macirq

Chao Yu (1):
      f2fs: fix to reorder set_page_dirty and wait_on_page_writeback

Chen-Yu Tsai (2):
      clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for all audio module cloc=
ks
      Bluetooth: hci_bcm: Handle deferred probing for the clock supply

Christophe Leroy (2):
      powerpc/uaccess: fix warning/error with access_ok()
      powerpc/mm: Fix reporting of kernel execute faults on the 8xx

Chunfeng Yun (1):
      usb: mtu3: fix the issue about SetFeature(U1/U2_Enable)

Colin Ian King (1):
      x86/PCI: Fix Broadcom CNB20LE unintended sign extension (redux)

Dale Zhao (1):
      drm/amd/display: Wait edp HPD to high in detect_sink

Damian Kos (1):
      drm/rockchip: fix for mailbox read size

Dan Carpenter (1):
      ath10k: fixup extended per sta tx statistics

Dave Carroll (1):
      scsi: smartpqi: correct volume status

David Ahern (2):
      bpftool: Improve handling of ENOENT on map dumps
      ipv6: Fix handling of LLA with VRF and sockets bound to VRF

Deepak Sharma (1):
      drm/vgem: Fix vgem_init to get drm device available.

Dennis Zhou (1):
      percpu: convert spin_lock_irq to spin_lock_irqsave.

Dexuan Cui (1):
      Tools: hv: kvp: Fix a warning of buffer overflow with gcc 8.0.1

Doug Smythies (1):
      tools/power/x86/intel_pstate_tracer: Fix non root execution for post =
processing a trace file

Emmanuel Grumbach (1):
      mac80211: fix deauth TX when we disconnect

Eric Anholt (2):
      drm/v3d: Fix a use-after-free race accessing the scheduler's fences.
      drm/v3d: Fix prime imports of buffers from other drivers.

Eric Biggers (1):
      crypto: aes_ti - disable interrupts while accessing S-box

Eric Long (1):
      dmaengine: sprd: Support DMA link-list cyclic callback

Eric Yang (1):
      drm/amd/display: fix YCbCr420 blank color

Ethan Lien (1):
      btrfs: use tagged writepage to mitigate livelock of snapshot

Fabio Estevam (1):
      ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M

Fabrizio Castro (2):
      usb: renesas_usbhs: add support for RZ/G2E
      i2c: sh_mobile: Add support for r8a774c0 (RZ/G2E)

Frank Rowand (1):
      powerpc/pseries: add of_node_put() in dlpar_detach_node()

Gao Xiang (2):
      staging: erofs: fix the definition of DBG_BUGON
      staging: erofs: fix race when the managed cache is enabled

Geert Uytterhoeven (3):
      lightnvm: Fix uninitialized return value in nvm_get_chunk_meta()
      serial: sh-sci: Fix locking in sci_submit_rx()
      serial: sh-sci: Resume PIO in sci_rx_interrupt() on DMA failure

Guoqing Jiang (1):
      md: fix raid10 hang issue caused by barrier

Gustavo A. R. Silva (1):
      drm/bufs: Fix Spectre v1 vulnerability

Hans Holmberg (1):
      lightnvm: pblk: fix resubmission of overwritten write err lbas

Hans Verkuil (2):
      media: vivid: fill in media_device bus_info
      media: adv*/tc358743/ths8200: fill in min width/height/pixelclock

Hans de Goede (1):
      iio: accel: kxcjk1013: Add KIOX010A ACPI Hardware-ID

Harald Freudenberger (1):
      s390/zcrypt: improve special ap message cmd handling

Hoang Le (1):
      tipc: fix node keep alive interval calculation

Hua Su (1):
      lightnvm: pblk: add lock protection to list operations

Huazhong Tan (2):
      net: hns3: fix error handling int the hns3_get_vector_ring_chain
      net: hns3: fix incomplete uninitialization of IRQ in the hns3_nic_uni=
nit_vector_data()

Icenowy Zheng (1):
      phy: sun4i-usb: add support for missing USB PHY index

Ido Schimmel (1):
      mlxsw: spectrum: Properly cleanup LAG uppers when removing port from =
LAG

Ilan Peer (1):
      mac80211: Properly handle SKB with radiotap only

Ioana Ciornei (1):
      dpaa2-ptp: defer probe when portal allocation failed

J. Bruce Fields (1):
      nfsd4: fix crash on writing v4_end_grace before nfsd startup

James Smart (2):
      scsi: lpfc: Correct LCB RJT handling
      scsi: lpfc: Fix LOGO/PLOGI handling when triggerd by ABTS Timeout eve=
nt

Jan Kara (1):
      udf: Fix BUG on corrupted inode

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix audio permanently muted

Jeffrey Hugo (1):
      clk: qcom: Leave mmss noc on for 8998

Jernej Skrabec (2):
      clk: sunxi-ng: h6: Set video PLLs limits
      drm/sun4i: Initialize registers in tcon-top driver

Jia-Ju Bai (1):
      cw1200: Fix concurrency use-after-free bugs in cw1200_hw_scan()

Jian Shen (2):
      net: hns3: add max vector number check for pf
      net: hns3: don't restore rules when flow director is disabled

Jiong Wang (1):
      mips: bpf: fix encoding bug for mm_srlv32_op

Joey Zhang (1):
      switchtec: Fix SWITCHTEC_IOCTL_EVENT_IDX_ALL flags overwrite

Johannes Berg (1):
      mac80211: fix radiotap vendor presence bitmap handling

John Fastabend (2):
      bpf: sk_msg, zap ingress queue on psock down
      bpf: sk_msg, fix socket data_ready events

Julian Wiedmann (1):
      s390/qeth: utilize virtual MAC for Layer2 OSD devices

Kai-Heng Feng (2):
      memstick: Prevent memstick host from getting runtime suspended during=
 card detection
      igb: Fix an issue that PME is not enabled during runtime suspend

Kaike Wan (1):
      IB/hfi1: Unreserve a reserved request when it is completed

Karthikeyan Periyasamy (1):
      ath10k: fix kernel panic due to use after free

Konstantin Khorenko (1):
      i40e: define proper net_device::neigh_priv_len

Lars Ellenberg (2):
      drbd: disconnect, if the wrong UUIDs are attached on a connected peer
      drbd: skip spurious timeout (ping-timeo) when failing promote

Laurent Pinchart (1):
      drm: rcar-du: Fix external clock error checks

Lenny Szubowicz (1):
      ACPI/APEI: Clear GHES block_status before panic()

Linus Walleij (2):
      ARM: dts: Fix up the D-Link DIR-685 MTD partition info
      mmc: jz4740: Get CD/WP GPIOs from descriptors

Lior David (1):
      wil6210: fix memory leak in wil_find_tx_bcast_2

Long Li (1):
      genirq/affinity: Spread IRQs to all available NUMA nodes

Lorenzo Bianconi (2):
      ath9k: dynack: use authentication messages for 'late' ack
      mt76x0: dfs: fix IBI_R11 configuration on non-radar channels

Lubomir Rintel (1):
      ARM: dts: mmp2: fix TWSI2

Luca Ceresoli (1):
      media: imx274: select REGMAP_I2C

Lukas Wunner (1):
      pinctrl: bcm2835: Use raw spinlock for RT compatibility

Madhavan Srinivasan (1):
      powerpc/perf: Fix thresholding counter data for unknown type

Mahesh Rajashekhara (2):
      scsi: smartpqi: correct host serial num for ssa
      scsi: smartpqi: increase fw status register read timeout

Marek Szyprowski (1):
      usb: dwc2: Disable power down feature on Samsung SoCs

Mark Rutland (2):
      arm64: ftrace: don't adjust the LR value
      arm64: KVM: Skip MMIO insn after emulation

Martin Blumenstingl (6):
      clk: meson: meson8b: do not use cpu_div3 for cpu_scale_out_sel
      clk: meson: meson8b: fix the width of the cpu_scale_div clock
      clk: meson: meson8b: mark the CPU clock as CLK_IS_CRITICAL
      iio: adc: meson-saradc: fix internal clock names
      pinctrl: meson: meson8: fix the GPIO function for the GPIOAO pins
      pinctrl: meson: meson8b: fix the GPIO function for the GPIOAO pins

Matheus Tavares (1):
      staging:iio:ad2s90: Make probe handle spi_setup failure

Mathias Nyman (1):
      usb: hub: delay hub autosuspend if USB3 port is still link training

Mathieu Malaterre (1):
      powerpc/32: Add .data..Lubsan_data*/.data..Lubsan_type* sections expl=
icitly

Max Filippov (1):
      xtensa: xtfpga.dtsi: fix dtc warnings about SPI

Michael Chan (1):
      bnxt_en: Disable MSIX before re-reserving NQs/CMPL rings.

Michael Straube (1):
      staging: pi433: fix potential null dereference

Michal Suchanek (1):
      mmc: bcm2835: reset host on timeout

Miroslav Lichvar (2):
      ptp: check gettime64 return code in PTP_SYS_OFFSET ioctl
      mlx5: update timecounter at least twice per counter overflow

Mitch Williams (1):
      i40e: suppress bogus error message

Muchun Song (1):
      gpiolib: Fix possible use after free on label

Murton Liu (1):
      drm/amd/display: fix gamma not being applied correctly

Naftali Goldstein (2):
      iwlwifi: fw: do not set sgi bits for HE connection
      iwlwifi: mvm: fix setting HE ppe FW config

Nathan Chancellor (3):
      ARM: OMAP2+: hwmod: Fix some section annotations
      dmaengine: xilinx_dma: Remove __aligned attribute on zynqmp_dma_desc_=
ll
      drbd: Avoid Clang warning about pointless switch statment

Nicholas Mc Guire (9):
      iio: adc: meson-saradc: check for devm_kasprintf failure
      perf: arm_spe: handle devm_kasprintf() failure
      pinctrl: nuvoton: check for devm_kasprintf() failure
      gpio: mt7621: report failure of devm_kasprintf()
      gpio: mt7621: pass mediatek_gpio_bank_probe() failure up the stack
      pinctrl: sx150x: handle failure case of devm_kstrdup
      mmc: meson-mx-sdio: check devm_kasprintf for failure
      pinctrl: rza1: Handle devm_kasprintf() failure cases
      livepatch: check kzalloc return values

Nickhu (1):
      nds32: Fix gcc 8.0 compiler option incompatible.

Nir Dotan (1):
      mlxsw: spectrum_acl: Limit priority value

Noralf Tr=F8nnes (1):
      fbdev: fbcon: Fix unregister crash when more than one framebuffer

Oskari Lemmela (1):
      arm64: dts: rockchip: fix rk3399-rockpro64 regulator gpios

Parav Pandit (1):
      RDMA/core: Sync unregistration with netlink commands

Paul Burton (1):
      MIPS: Boston: Disable EG20T prefetch

Paul Hsieh (1):
      drm/amd/display: Add retry to read ddc_clock pin

Peng Li (1):
      net: hns3: fix the descriptor index when get rss type

Peter Rajnoha (1):
      kobject: return error code if writing /sys/.../uevent fails

Peter Rosin (1):
      fbdev: fbmem: behave better with small rotated displays and many CPUs

Phil Elwell (1):
      mmc: bcm2835: Recover from MMC_SEND_EXT_CSD

Philipp Zabel (1):
      media: coda: fix H.264 deblocking filter controls

Pu Wen (1):
      perf tools: Add Hygon Dhyana support

Quentin Monnet (1):
      tools: bpftool: fix -Wmissing declaration warnings

Randy Dunlap (1):
      spi: fix spi-at91-usart.c build errors when PINCTRL is not set

Renato Lui Geh (1):
      staging: iio: ad7780: update voltage on read

Rob Herring (1):
      ARM: dts: aspeed: add missing memory unit-address

Roland Kammerer (1):
      drbd: narrow rcu_read_lock in drbd_sync_handshake

Russell King - ARM Linux (1):
      ARM: dts: Fix OMAP4430 SDP Ethernet startup

Saeed Mahameed (1):
      net/mlx5: EQ, Use the right place to store/read IRQ affinity hint

Sami Tolvanen (1):
      modpost: validate symbol names also in find_elf_symbol

Sean Paul (2):
      drm: Clear state->acquire_ctx before leaving drm_atomic_helper_commit=
_duplicated_state()
      drm/msm: dpu: Only check flush register against pending flushes

Sean Young (1):
      media: rc: ensure close() is called on rc_unregister_device

Sebastian Andrzej Siewior (1):
      x86/fpu: Add might_fault() to user_insn()

Sergei Shtylyov (1):
      sata_rcar: fix deferred probing

Sheng Yong (1):
      f2fs: fix race between write_checkpoint and write_begin

Simon Horman (1):
      i2c: sh_mobile: add support for r8a77990 (R-Car E3)

Slawomir Stepien (1):
      staging: iio: adc: ad7280a: handle error from __ad7280_read32()

Stanislav Fomichev (2):
      bpf: libbpf: retry map creation without the name
      selftests/bpf: use __bpf_constant_htons in test_prog.c

Stephane Eranian (1):
      perf stat: Fix CSV mode column output for non-cgroup events

Steve Longerbeam (1):
      gpu: ipu-v3: image-convert: Prevent race between run and unprepare

Suganath Prabu (1):
      scsi: mpt3sas: Call sas_remove_host before removing the target devices

Suraj Jitindar Singh (1):
      KVM: PPC: Book3S: Only report KVM_CAP_SPAPR_TCE_VFIO on powernv machi=
nes

Tejas Joglekar (1):
      usb: dwc3: gadget: Disable CSP for stream OUT ep

Thara Gopinath (1):
      thermal: Fix locking in cooling device sysfs update cur_state

Tiezhu Yang (1):
      f2fs: fix wrong return value of f2fs_acl_create

Tom Murphy (1):
      fix dma-buf/udmabuf selftest

Tomasz Figa (1):
      media: v4l2-device: Link subdevices to their parent devices if availa=
ble

Vadim Pasternak (1):
      platform/x86: mlx-platform: Fix tachometer registers

Ville Syrj=E4l=E4 (1):
      platform/x86: Fix config space access for intel_atomisp2_pm

Viresh Kumar (1):
      OPP: Use opp_table->regulators to verify no regulator case

Vivek Gautam (1):
      iommu/arm-smmu: Add support for qcom,smmu-v2 variant

Wei Wang (1):
      Thermal: do not clear passive state during system sleep

Wenjing Liu (1):
      drm/amd/display: validate extended dongle caps

Will Deacon (3):
      arm64: io: Ensure calls to delay routines are ordered against prior r=
eadX()
      arm64: io: Ensure value passed to __iormb() is held in a 64-bit regis=
ter
      iommu/arm-smmu-v3: Use explicit mb() when moving cons pointer

Wolfram Sang (1):
      watchdog: renesas_wdt: don't set divider while watchdog is running

Xiang Chen (1):
      scsi: hisi_sas: change the time of SAS SSP connection

Yangtao Li (3):
      soc/tegra: Don't leak device tree node reference
      soc: bcm: brcmstb: Don't leak device tree node reference
      cpuidle: big.LITTLE: fix refcount leak

Yi Wang (1):
      clk: boston: fix possible memory leak in clk_boston_setup()

Yogesh Mohan Marimuthu (1):
      drm/amd/display: calculate stream->phy_pix_clk before clock mapping

Young Xiao (2):
      sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns E=
AGAIN
      ice: Do not enable NAPI on q_vectors that have no rings

Yu Zhao (1):
      iommu/amd: Fix amd_iommu=3Dforce_isolation

YueHaibing (3):
      ptp: Fix pass zero to ERR_PTR() in ptp_clock_register
      net: aquantia: return 'err' if set MPI_DEINIT state fails
      xfrm6_tunnel: Fix spi check in __xfrm6_tunnel_alloc_spi

Yufen Wang (1):
      ARM: 8808/1: kexec:offline panic_smp_self_stop CPU

Yunlei He (1):
      f2fs: move dir data flush to write checkpoint process

Yunlong Song (1):
      f2fs: avoid GC causing encrypted file corrupted

Zhen Lei (1):
      iommu/arm-smmu-v3: Avoid memory corruption from Hisilicon MSI payloads

Zhi Chen (1):
      ath10k: fix tx_stats memory leak

Zhizhou Zhang (1):
      tee: optee: avoid possible double list_del()

Zoran Markovic (1):
      smack: fix access permissions for keyring


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxjKNQACgkQONu9yGCS
aT4epw//bUqA/rTSCvKkpwbPlJXH3H8ryKvgeVd5gioOdXJxo6NBgal52aLUcpAM
8w3tsqZAhw6PqDFsLUzYJjCVPIk7t33k++AnBmCeZ1l73K+WVxZaGQLpsiLX/vcE
PvzcL4+bKA9VhJt6nlnUYJBqG7nlA4ldhSZaxsV9qsmscV//ximQSkCJk+1WSuRT
6W623fweJ4A7A2YHVB4/ULYssNwGV1ha+zois7VsQszqgj3x1W+fMDQrij1BEjIu
W5/cmSvfPu2JMnSaKFj6hd+iK8kJOqJ1KY1j9e3vqOc1KOsVfDdhD9/EQsicrpwg
+YzqvnhtArcDvkWMulPdtrArAW8VPYIsiLJ39p3ePQN5nP0BlABIAWAd1ZAd53aU
D6oxI5EEbS7imvRgcVSHd9yPnlIkNdMzPWTj2uHtQjaWV+r4QqCSR691T5bBoDlX
Oep/9aumuDXiW88UiHIKPp0RI8KuzpHdyJWCjZsQNgaW4yrKr0/1ufPsfAETrLB7
LBlLvrb7ux1SAhzU4RuADZv+hYY7/ckmGo/Fb9L8VYUcRO+a8O+Iu0q9k1eN9R8U
XK8MansCyFB+Oduup9xaMgni4FZy7xkfMaBEDEIB6jvQZL/DY9L8WVCARJplt92N
7tQq7f6ufxOXqBmxXZfArlAXZdpu2u6PTMO3qkkkcLYgvJv42jQ=
=BszO
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
