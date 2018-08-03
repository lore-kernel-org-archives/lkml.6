Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37BFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0AE2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0AE2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeHCIXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:23:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47098 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeHCIXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:23:21 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 21DCF3EE;
        Fri,  3 Aug 2018 06:28:30 +0000 (UTC)
Date:   Fri, 3 Aug 2018 08:28:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.12
Message-ID: <20180803062828.GA9708@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.17.12 kernel.

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

 Documentation/devicetree/bindings/net/dsa/qca8k.txt                 |   23=
 +
 Documentation/devicetree/bindings/net/meson-dwmac.txt               |    1=
=20
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt         |    2=
=20
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt          |    1=
=20
 Documentation/vfio-mediated-device.txt                              |    5=
=20
 Makefile                                                            |    2=
=20
 arch/arm/boot/dts/emev2.dtsi                                        |    5=
=20
 arch/arm/boot/dts/imx53-ppd.dts                                     |    2=
=20
 arch/arm/boot/dts/imx53.dtsi                                        |    8=
=20
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi                      |    1=
=20
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi                      |    1=
=20
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi                      |    1=
=20
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi                            |    8=
=20
 arch/arm/boot/dts/sh73a0.dtsi                                       |    5=
=20
 arch/arm/boot/dts/stih407-pinctrl.dtsi                              |   10=
=20
 arch/arm/boot/dts/stih410.dtsi                                      |   18=
 -
 arch/arm/net/bpf_jit_32.c                                           |   10=
=20
 arch/arm64/boot/dts/renesas/salvator-common.dtsi                    |   38=
 +-
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
 arch/powerpc/include/asm/pkeys.h                                    |    2=
=20
 arch/powerpc/kernel/eeh_driver.c                                    |   28=
 +-
 arch/powerpc/kernel/head_8xx.S                                      |    2=
=20
 arch/powerpc/kernel/pci_32.c                                        |    1=
=20
 arch/powerpc/kernel/prom_init.c                                     |  114=
 ++++----
 arch/powerpc/lib/string.S                                           |    7=
=20
 arch/powerpc/mm/slb.c                                               |    8=
=20
 arch/powerpc/net/bpf_jit_comp64.c                                   |   34=
 +-
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
 arch/sh/boards/mach-migor/setup.c                                   |    2=
=20
 arch/x86/events/intel/uncore.c                                      |    2=
=20
 arch/x86/events/intel/uncore_nhmex.c                                |    2=
=20
 arch/x86/kernel/cpu/microcode/core.c                                |    6=
=20
 arch/x86/kvm/mmu.c                                                  |    2=
=20
 arch/x86/kvm/svm.c                                                  |    8=
=20
 block/bfq-iosched.c                                                 |    2=
=20
 block/bio.c                                                         |   19=
 -
 crypto/authenc.c                                                    |    1=
=20
 crypto/authencesn.c                                                 |    1=
=20
 drivers/acpi/acpi_lpss.c                                            |   32=
 +-
 drivers/acpi/acpica/psloop.c                                        |   19=
 -
 drivers/acpi/pci_root.c                                             |    4=
=20
 drivers/ata/libata-eh.c                                             |   12=
=20
 drivers/bluetooth/btusb.c                                           |    4=
=20
 drivers/bluetooth/hci_qca.c                                         |    2=
=20
 drivers/char/random.c                                               |   10=
=20
 drivers/clk/clk-si544.c                                             |    1=
=20
 drivers/clk/ingenic/jz4770-cgu.c                                    |    3=
=20
 drivers/edac/altera_edac.c                                          |    2=
=20
 drivers/gpio/gpio-uniphier.c                                        |    6=
=20
 drivers/gpio/gpiolib-of.c                                           |    3=
=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c                              |   17=
 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                          |    8=
=20
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                   |    8=
=20
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c               |    3=
=20
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c         |    4=
=20
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c                    |    7=
=20
 drivers/gpu/drm/drm_atomic.c                                        |    4=
=20
 drivers/gpu/drm/drm_atomic_helper.c                                 |   78=
 ++---
 drivers/gpu/drm/drm_dp_mst_topology.c                               |    9=
=20
 drivers/gpu/drm/gma500/psb_intel_drv.h                              |    2=
=20
 drivers/gpu/drm/gma500/psb_intel_lvds.c                             |    2=
=20
 drivers/gpu/drm/i915/i915_drv.h                                     |    1=
=20
 drivers/gpu/drm/i915/intel_ddi.c                                    |   13=
=20
 drivers/gpu/drm/i915/intel_display.c                                |   21=
 +
 drivers/gpu/drm/i915/intel_drv.h                                    |    3=
=20
 drivers/gpu/drm/nouveau/nouveau_dma.c                               |   10=
=20
 drivers/gpu/drm/nouveau/nouveau_dma.h                               |    5=
=20
 drivers/gpu/drm/nouveau/nouveau_drm.c                               |   30=
 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c                               |   19=
 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c                    |    8=
=20
 drivers/gpu/drm/radeon/radeon_connectors.c                          |   10=
=20
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c                     |    9=
=20
 drivers/gpu/drm/stm/ltdc.c                                          |    3=
=20
 drivers/gpu/host1x/dev.c                                            |   11=
=20
 drivers/hid/hid-plantronics.c                                       |    6=
=20
 drivers/hid/i2c-hid/i2c-hid.c                                       |    8=
=20
 drivers/i2c/busses/i2c-rcar.c                                       |   54=
 +++-
 drivers/infiniband/core/mad.c                                       |   11=
=20
 drivers/infiniband/core/ucma.c                                      |    6=
=20
 drivers/infiniband/core/uverbs_cmd.c                                |    5=
=20
 drivers/infiniband/sw/rdmavt/Kconfig                                |    2=
=20
 drivers/infiniband/sw/rxe/Kconfig                                   |    1=
=20
 drivers/input/mouse/elan_i2c_core.c                                 |    2=
=20
 drivers/input/serio/i8042-x86ia64io.h                               |    7=
=20
 drivers/irqchip/irq-ls-scfg-msi.c                                   |    3=
=20
 drivers/lightnvm/pblk-core.c                                        |    6=
=20
 drivers/lightnvm/pblk-rb.c                                          |    5=
=20
 drivers/lightnvm/pblk-read.c                                        |    8=
=20
 drivers/md/md.c                                                     |    3=
=20
 drivers/md/raid1.c                                                  |    2=
=20
 drivers/media/cec/cec-pin-error-inj.c                               |   33=
 +-
 drivers/media/common/siano/smsendian.c                              |   14=
 -
 drivers/media/common/videobuf2/videobuf2-core.c                     |    9=
=20
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
 drivers/media/platform/renesas-ceu.c                                |   20=
 +
 drivers/media/radio/si470x/radio-si470x-i2c.c                       |    6=
=20
 drivers/media/rc/ir-mce_kbd-decoder.c                               |   12=
=20
 drivers/media/usb/em28xx/em28xx-dvb.c                               |    4=
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
 drivers/mmc/host/sdhci-omap.c                                       |   17=
 -
 drivers/mtd/nand/raw/fsl_ifc_nand.c                                 |   17=
 -
 drivers/net/dsa/qca8k.c                                             |   52=
 +++
 drivers/net/dsa/qca8k.h                                             |    7=
=20
 drivers/net/ethernet/amazon/ena/ena_com.c                           |    1=
=20
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                           |    4=
=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                           |    5=
=20
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c                     |    3=
=20
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c                     |    2=
=20
 drivers/net/ethernet/hisilicon/hns3/hnae3.c                         |    1=
=20
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                         |    2=
=20
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                     |    5=
=20
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h                     |    2=
=20
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c             |   17=
 -
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h             |    2=
=20
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c           |   28=
 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h           |    2=
=20
 drivers/net/ethernet/intel/e1000e/netdev.c                          |   15=
 -
 drivers/net/ethernet/intel/i40e/i40e.h                              |    2=
=20
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                      |    4=
=20
 drivers/net/ethernet/intel/i40e/i40e_ptp.c                          |   48=
 ++-
 drivers/net/ethernet/intel/igb/igb_main.c                           |    9=
=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c                        |    8=
=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                       |    8=
=20
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c                   |    1=
=20
 drivers/net/ethernet/marvell/mvpp2.c                                |    3=
=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c               |   14=
 -
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c            |    4=
=20
 drivers/net/ethernet/socionext/netsec.c                             |   23=
 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                   |    2=
=20
 drivers/net/ethernet/ti/cpsw-phy-sel.c                              |    8=
=20
 drivers/net/hyperv/hyperv_net.h                                     |    2=
=20
 drivers/net/hyperv/netvsc_drv.c                                     |   43=
 +--
 drivers/net/netdevsim/devlink.c                                     |    1=
=20
 drivers/net/phy/mdio-mux-bcm-iproc.c                                |    2=
=20
 drivers/net/phy/phylink.c                                           |    2=
=20
 drivers/net/phy/sfp-bus.c                                           |    7=
=20
 drivers/net/usb/lan78xx.c                                           |    2=
=20
 drivers/net/virtio_net.c                                            |   41=
 +--
 drivers/net/wireless/ath/ath10k/core.c                              |  134=
 +++++-----
 drivers/net/wireless/ath/ath10k/debug.c                             |    8=
=20
 drivers/net/wireless/ath/ath10k/wmi.c                               |    6=
=20
 drivers/net/wireless/ath/ath10k/wmi.h                               |    2=
=20
 drivers/net/wireless/ath/regd.h                                     |    5=
=20
 drivers/net/wireless/ath/regd_common.h                              |   13=
=20
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c           |    1=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                   |    8=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c                         |   38=
 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h                         |    7=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c                        |    2=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h                        |   10=
=20
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                        |    2=
=20
 drivers/net/wireless/marvell/mwifiex/usb.c                          |    3=
=20
 drivers/net/wireless/marvell/mwifiex/util.c                         |    8=
=20
 drivers/net/wireless/mediatek/mt76/mt76x2_init.c                    |    3=
=20
 drivers/net/wireless/mediatek/mt76/mt76x2_main.c                    |    3=
=20
 drivers/net/wireless/mediatek/mt76/mt76x2_phy.c                     |    6=
=20
 drivers/net/wireless/mediatek/mt76/tx.c                             |    2=
=20
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c                   |   21=
 +
 drivers/net/wireless/quantenna/qtnfmac/event.c                      |    8=
=20
 drivers/net/wireless/quantenna/qtnfmac/pearl/pcie.c                 |    4=
=20
 drivers/net/wireless/rsi/rsi_91x_hal.c                              |   35=
 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c                         |    7=
=20
 drivers/net/wireless/rsi/rsi_91x_sdio.c                             |   23=
 +
 drivers/net/wireless/rsi/rsi_sdio.h                                 |    2=
=20
 drivers/net/wireless/ti/wlcore/sdio.c                               |    5=
=20
 drivers/net/xen-netfront.c                                          |   10=
=20
 drivers/nvme/host/pci.c                                             |   16=
 -
 drivers/nvme/host/rdma.c                                            |   10=
=20
 drivers/nvme/target/fc.c                                            |   44=
 ++-
 drivers/nvmem/core.c                                                |    7=
=20
 drivers/pci/pci-sysfs.c                                             |   15=
 -
 drivers/pci/pcie/aspm.c                                             |    9=
=20
 drivers/pci/pcie/dpc.c                                              |    5=
=20
 drivers/pci/probe.c                                                 |    4=
=20
 drivers/perf/arm-cci.c                                              |    6=
=20
 drivers/perf/arm-ccn.c                                              |   20=
 -
 drivers/pinctrl/pinctrl-at91-pio4.c                                 |    4=
=20
 drivers/pinctrl/qcom/pinctrl-msm.c                                  |   23=
 +
 drivers/platform/x86/dell-smbios-base.c                             |    5=
=20
 drivers/regulator/cpcap-regulator.c                                 |    2=
=20
 drivers/regulator/internal.h                                        |    9=
=20
 drivers/regulator/of_regulator.c                                    |   13=
=20
 drivers/regulator/pfuze100-regulator.c                              |    1=
=20
 drivers/regulator/twl-regulator.c                                   |    2=
=20
 drivers/rtc/interface.c                                             |    5=
=20
 drivers/rtc/rtc-tps6586x.c                                          |   14=
 -
 drivers/rtc/rtc-tps65910.c                                          |   12=
=20
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
 drivers/soc/qcom/qmi_interface.c                                    |    5=
=20
 drivers/soc/qcom/smem.c                                             |   27=
 +-
 drivers/soc/tegra/pmc.c                                             |   20=
 -
 drivers/spi/spi-meson-spicc.c                                       |   11=
=20
 drivers/spi/spi-s3c64xx.c                                           |    4=
=20
 drivers/spi/spi-sh-msiof.c                                          |    6=
=20
 drivers/spi/spi.c                                                   |    1=
=20
 drivers/staging/ks7010/ks7010_sdio.c                                |    3=
=20
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c                 |    2=
=20
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c              |   30=
 +-
 drivers/staging/lustre/lustre/ldlm/ldlm_lock.c                      |    6=
=20
 drivers/staging/lustre/lustre/llite/xattr.c                         |    6=
=20
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c                  |    6=
=20
 drivers/staging/media/atomisp/i2c/gc2235.h                          |    9=
=20
 drivers/staging/media/atomisp/i2c/ov2680.h                          |    5=
=20
 drivers/staging/media/atomisp/i2c/ov2722.h                          |    6=
=20
 drivers/staging/media/atomisp/i2c/ov5693/ov5693.h                   |   18=
 +
 drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_ioctl32.c |   49=
 +--
 drivers/staging/most/cdev/cdev.c                                    |    6=
=20
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
 drivers/vfio/mdev/mdev_core.c                                       |  102=
 ++-----
 drivers/vfio/mdev/mdev_private.h                                    |    2=
=20
 drivers/vfio/platform/vfio_platform_common.c                        |   15=
 -
 drivers/vfio/vfio_iommu_type1.c                                     |   73=
 +++--
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
 fs/ceph/super.c                                                     |   13=
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
 fs/ext4/super.c                                                     |   13=
=20
 fs/f2fs/data.c                                                      |   14=
 -
 fs/f2fs/f2fs.h                                                      |    8=
=20
 fs/f2fs/file.c                                                      |   20=
 +
 fs/f2fs/gc.c                                                        |   11=
=20
 fs/f2fs/segment.c                                                   |    5=
=20
 fs/f2fs/super.c                                                     |    6=
=20
 fs/nfs/inode.c                                                      |    3=
=20
 fs/nfs/nfs4proc.c                                                   |   14=
 -
 fs/nfs/pnfs.c                                                       |    6=
=20
 fs/nfsd/nfs4state.c                                                 |    5=
=20
 fs/nfsd/nfs4xdr.c                                                   |    2=
=20
 fs/proc/task_mmu.c                                                  |   30=
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
 include/linux/memcontrol.h                                          |   23=
 +
 include/linux/mm.h                                                  |    9=
=20
 include/linux/mmc/sdio_ids.h                                        |    1=
=20
 include/linux/netfilter/ipset/ip_set_timeout.h                      |   10=
=20
 include/linux/regulator/consumer.h                                  |    1=
=20
 include/linux/serial_core.h                                         |    3=
=20
 include/net/tcp.h                                                   |    2=
=20
 include/soc/tegra/mc.h                                              |    2=
=20
 include/uapi/sound/asoc.h                                           |   23=
 +
 ipc/msg.c                                                           |    6=
=20
 ipc/sem.c                                                           |    6=
=20
 kernel/auditfilter.c                                                |    2=
=20
 kernel/auditsc.c                                                    |    2=
=20
 kernel/bpf/syscall.c                                                |   37=
 ++
 kernel/bpf/verifier.c                                               |    4=
=20
 kernel/delayacct.c                                                  |   17=
 -
 kernel/fork.c                                                       |    8=
=20
 kernel/hung_task.c                                                  |   11=
=20
 kernel/kcov.c                                                       |    3=
=20
 kernel/kthread.c                                                    |    8=
=20
 kernel/memremap.c                                                   |   18=
 +
 kernel/power/suspend.c                                              |   14=
 -
 kernel/printk/printk_safe.c                                         |    2=
=20
 kernel/sched/cpufreq_schedutil.c                                    |   17=
 -
 kernel/stop_machine.c                                               |   24=
 -
 kernel/time/clocksource.c                                           |    4=
=20
 kernel/trace/trace_events_trigger.c                                 |   18=
 -
 kernel/trace/trace_kprobe.c                                         |   15=
 -
 lib/dma-direct.c                                                    |    7=
=20
 mm/slub.c                                                           |    2=
=20
 mm/vmalloc.c                                                        |    3=
=20
 net/core/dev.c                                                      |   17=
 -
 net/ipv4/fib_frontend.c                                             |    4=
=20
 net/ipv4/ipconfig.c                                                 |   13=
=20
 net/ipv4/tcp_bbr.c                                                  |    4=
=20
 net/ipv4/tcp_dctcp.c                                                |    4=
=20
 net/ipv4/tcp_input.c                                                |   57=
 ++--
 net/netfilter/ipset/ip_set_hash_gen.h                               |    5=
=20
 net/netfilter/nf_tables_api.c                                       |   11=
=20
 net/netlink/af_netlink.c                                            |    5=
=20
 net/rds/ib_frmr.c                                                   |    5=
=20
 net/rds/ib_mr.h                                                     |    3=
=20
 net/rds/ib_rdma.c                                                   |   21=
 -
 net/rds/rdma.c                                                      |   13=
=20
 net/rds/rds.h                                                       |    5=
=20
 net/rds/send.c                                                      |   12=
=20
 net/rxrpc/conn_event.c                                              |    2=
=20
 security/integrity/ima/ima_main.c                                   |    1=
=20
 sound/pci/emu10k1/emupcm.c                                          |    4=
=20
 sound/pci/emu10k1/memory.c                                          |    6=
=20
 sound/pci/fm801.c                                                   |   16=
 -
 sound/pci/hda/patch_ca0132.c                                        |    8=
=20
 sound/soc/fsl/fsl_ssi.c                                             |    3=
=20
 sound/soc/soc-compress.c                                            |   52=
 ++-
 sound/soc/soc-pcm.c                                                 |    6=
=20
 sound/soc/soc-topology.c                                            |   19=
 +
 sound/usb/pcm.c                                                     |    2=
=20
 tools/perf/util/parse-events.y                                      |   14=
 -
 tools/testing/selftests/filesystems/Makefile                        |    1=
=20
 tools/testing/selftests/filesystems/devpts_pts.c                    |   13=
=20
 tools/testing/selftests/intel_pstate/run.sh                         |   29=
 +-
 tools/testing/selftests/kvm/lib/assert.c                            |    9=
=20
 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c                   |    2=
=20
 tools/testing/selftests/memfd/run_tests.sh                          |   14=
 -
 tools/usb/usbip/libsrc/vhci_driver.c                                |   32=
 +-
 tools/usb/usbip/libsrc/vhci_driver.h                                |    3=
=20
 tools/usb/usbip/src/usbip_detach.c                                  |    9=
=20
 349 files changed, 2486 insertions(+), 1290 deletions(-)

Aaron Lu (1):
      mem_cgroup: make sure moving_account, move_lock_task and stat_cpu in =
the same cacheline

Alex Elder (3):
      soc: qcom: qmi: fix a buffer sizing bug
      soc: qcom: smem: fix qcom_smem_set_global_partition()
      soc: qcom: smem: byte swap values properly

Alex Williamson (2):
      vfio/mdev: Check globally for duplicate devices
      vfio/type1: Fix task tracking for QEMU vCPU hotplug

Alexander Duyck (1):
      ixgbe: Fix setting of TC configuration for macvlan case

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

Anders Roxell (1):
      selftests/filesystems: devpts_pts included wrong header

Andrew Elble (1):
      nfsd: fix error handling in nfs4_set_delegation()

Andrey Smirnov (1):
      soc: imx: gpcv2: Do not pass static memory as platform data

Andy Shevchenko (1):
      drm/dp/mst: Fix off-by-one typo when dump payload table

Anson Huang (1):
      regulator: pfuze100: add .is_enable() for pfuze100_swb_regulator_ops

Antoine Tenart (1):
      net: phy: sfp: handle cases where neither BR, min nor BR, max is given

Anton Vasilyev (1):
      net: mdio-mux: bcm-iproc: fix wrong getter and setter pair

Arjun Vynipadath (1):
      cxgb4: Added missing break in ndo_udp_tunnel_{add/del}

Arnd Bergmann (2):
      drivers/bus: arm-cci: fix build warnings
      y2038: ipc: Use ktime_get_real_seconds consistently

Artem Savkov (1):
      tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failu=
re

Avinash Repaka (1):
      RDS: RDMA: Fix the NULL-ptr deref in rds_ib_get_mr

Bartlomiej Zolnierkiewicz (1):
      thermal: exynos: fix setting rising_threshold for Exynos5433

Ben Hutchings (1):
      IB: Fix RDMA_RXE and INFINIBAND_RDMAVT dependencies for DMA_VIRT_OPS

Ben Skeggs (3):
      drm/nouveau: remove fence wait code from deferred client work handler
      drm/nouveau/gem: lookup VMAs for buffers referenced by pushbuf ioctl
      drm/nouveau/fifo/gk104-: poll for runlist update completion

Benjamin Poirier (1):
      e1000e: Ignore TSYNCRXCTL when getting I219 clock attributes

Bjorn Helgaas (1):
      PCI/ASPM: Disable ASPM L1.2 Substate if we don't have LTR

Brad Love (2):
      media: saa7164: Fix driver name in debug output
      media: em28xx: Fix DualHD broken second tuner

Chad Dupuis (1):
      scsi: qedf: Set the UNLOADING flag when removing a vport

Changbin Du (1):
      regulator: add dummy function of_find_regulator_by_node

Chao Yu (6):
      f2fs: fix error path of move_data_page
      f2fs: don't drop dentry pages after fs shutdown
      f2fs: fix to don't trigger writeback during recovery
      f2fs: fix to wait page writeback during revoking atomic write
      f2fs: fix to detect failure of dquot_initialize
      f2fs: fix race in between GC and atomic open

Charles Keepax (1):
      ASoC: compress: Only call free for components which have been opened

Chen-Yu Tsai (1):
      Input: i8042 - add Lenovo LaVie Z to the i8042 reset list

Chengguang Xu (1):
      ceph: fix alignment of rasize

Chintan Pandya (1):
      mm: vmalloc: avoid racy handling of debugobjects in vunmap

Chris Novakovic (1):
      ipconfig: Correctly initialise ic_nameservers

Christian Gromm (1):
      staging: most: cdev: fix chrdev_region leak

Christian Lamparter (1):
      pinctrl: msm: fix gpio-hog related boot issues

Christoph Hellwig (1):
      PCI: Prevent sysfs disable of device while driver is attached

Christophe Leroy (2):
      powerpc/lib: Adjust .balign inside string functions for PPC32
      powerpc/8xx: fix invalid register expression in head_8xx.S

Clint Taylor (1):
      drm/i915/glk: Add Quirk for GLK NUC HDMI port issues.

Colin Ian King (1):
      media: smiapp: fix timeout checking in smiapp_read_nvm

Cong Wang (1):
      infiniband: fix a possible use-after-free bug

DaeRyong Jeong (1):
      tty: Fix data race in tty_insert_flip_string_fixed_flag

Damien Le Moal (1):
      libata: Fix command retry decision

Dan Carpenter (2):
      KVM: x86: prevent integer overflows in KVM_MEMORY_ENCRYPT_REG_REGION
      scsi: megaraid: silence a static checker bug

Daniel D=C3=ADaz (1):
      selftests/intel_pstate: Improve test, minor fixes

Dave Jiang (1):
      mm: disallow mappings that conflict for devm_memremap_pages()

David Howells (1):
      rxrpc: Fix terminal retransmission connection ID to include the chann=
el

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

Erik Schmauss (1):
      ACPICA: AML Parser: ignore control method status in module-level code

Ethan Lien (1):
      btrfs: balance dirty metadata pages in btrfs_finish_ordered_io

Eugeniy Paltsev (1):
      NET: stmmac: align DMA stuff to largest cache line length

Eyal Reizer (1):
      wlcore: sdio: check for valid platform device data before suspend

Ezequiel Garcia (1):
      media: tw686x: Fix incorrect vb2_mem_ops GFP flags

Fabio Estevam (2):
      ASoC: fsl_ssi: Use u32 variable type when using regmap_read()
      ARM: dts: imx6qdl-wandboard: Let the codec control MCLK pinctrl

Felix Fietkau (1):
      mt76: add rcu locking around tx scheduling

Felix Kuehling (1):
      drm/amdgpu: Avoid reclaim while holding locks taken in MMU notifier

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
      Linux 4.17.12

Gregory Greenman (1):
      iwlwifi: mvm: open BA session only when sta is authorized

Grygorii Strashko (1):
      net: ethernet: ti: cpsw-phy-sel: check bus_find_device() ret value

Gustavo A. R. Silva (1):
      qtnfmac: pearl: pcie: fix memory leak in qtnf_fw_work_handler

Hans Verkuil (2):
      media: videobuf2-core: don't call memop 'finish' when queueing
      media: cec: fix smatch error

Hans de Goede (1):
      ACPI / LPSS: Only call pwm_add_table() for Bay Trail PWM if PMIC HRV =
is 2

Huang Ying (1):
      mm: /proc/pid/pagemap: hide swap entries from unprivileged users

Huazhong Tan (1):
      net: hns3: Fixes the out of bounds access in hclge_map_tqp

Ido Schimmel (1):
      mlxsw: spectrum_router: Return an error for non-default FIB rules

Igor Konopko (2):
      lightnvm: fix partial read error path
      lightnvm: proper error handling for pblk_bio_add_pages

Jacob Keller (2):
      i40e: free the skb after clearing the bitlock
      i40e: avoid overflow in i40e_ptp_adjfreq()

Jacopo Mondi (2):
      media: arch: sh: migor: Fix TW9910 PDN gpio
      media: renesas-ceu: Set mbus_fmt on subdev operations

Jaegeuk Kim (2):
      f2fs: avoid fsync() failure caused by EAGAIN in writepage()
      f2fs: check cap_resource only for data blocks

Jakub Kicinski (2):
      bpf: fix references to free_bpf_prog_info() in comments
      netdevsim: don't leak devlink resources

Jakub Pawlak (1):
      i40e: Add advertising 10G LR mode

James Simmons (1):
      staging: lustre: llite: correct removexattr detection

James Smart (1):
      nvmet-fc: fix target sgl list on large transfers

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

Keith Busch (1):
      nvme-pci: Fix AER reset handling

Kenneth Feng (1):
      drm/amd/powerplay: Set higher SCLK&MCLK frequency than dpm7 in OD (v2)

Kirill Marinushkin (2):
      ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
      ASoC: topology: Add missing clock gating parameter when parsing hw_co=
nfigs

Kishon Vijay Abraham I (1):
      mmc: sdhci-omap: Fix when capabilities are obtained from SDHCI_CAPABI=
LITIES reg

Kuninori Morimoto (1):
      arm64: dts: renesas: salvator-common: use audio-graph-card for Sound

Laurentiu Tudor (1):
      irqchip/ls-scfg-msi: Map MSIs in the iommu

Lawrence Brakmo (1):
      tcp: ack immediately when a cwr packet arrives

Leo (Sunpeng) Li (1):
      drm/amd/display: Fix dim display on DCE11

Leon Romanovsky (2):
      RDMA/mad: Convert BUG_ONs to error flows
      RDMA/uverbs: Protect from attempts to create flows on unsupported QP

Lijun Ou (1):
      net: hns3: Fixes initalization of RoCE handle and makes it conditional

Linus Torvalds (1):
      squashfs: be more careful about metadata corruption

Linus Walleij (1):
      gpio: of: Handle fixed regulator flags properly

Lorenzo Bianconi (3):
      mt76x2: apply coverage class on slot time too
      mt76x2: fix avg_rssi estimation
      ipv4: remove BUG_ON() from fib_compute_spec_dst

Luc Van Oostenryck (2):
      drm/radeon: fix mode_valid's return type
      drm/gma500: fix psb_intel_lvds_mode_valid()'s return type

Luis Henriques (1):
      ceph: fix use-after-free in ceph_statfs()

Marc Zyngier (1):
      dma-iommu: Fix compilation when !CONFIG_IOMMU_DMA

Marco Felsch (1):
      watchdog: da9063: Fix updating timeout value

Marek Szyprowski (1):
      spi: spi-s3c64xx: Fix system resume support

Mario Limonciello (1):
      platform/x86: dell-smbios: Match on www.dell.com in OEM strings too

Mark Rutland (2):
      kcov: ensure irq code sees a valid area
      drivers/perf: arm-ccn: don't log to dmesg in event_init

Martin Blumenstingl (1):
      dt-bindings: pinctrl: meson: add support for the Meson8m2 SoC

Martin Wilck (2):
      block: bio_iov_iter_get_pages: fix size of last iovec
      blkdev: __blkdev_direct_IO_simple: fix leak in error case

Masahiro Yamada (1):
      gpio: uniphier: set legitimate irq trigger type in .to_irq hook

Masahisa KOJIMA (1):
      net: socionext: reset hardware in ndo_stop

Mathieu Malaterre (8):
      mm/slub.c: add __printf verification to slab_err()
      powerpc/32: Add a missing include header
      powerpc/chrp/time: Make some functions static, add missing header inc=
lude
      powerpc/powermac: Add missing prototype for note_bootable_part()
      powerpc/powermac: Mark variable x as unused
      powerpc: Add __printf verification to prom_printf
      clocksource: Move inline keyword to the beginning of function declara=
tions
      nvmem: properly handle returned value nvmem_reg_read

Matthew R. Ochs (1):
      scsi: cxlflash: Avoid clobbering context control register value

Mauro Carvalho Chehab (7):
      media: cec-pin-error-inj: avoid a false-positive Spectre detection
      media: atomisp: ov2680: don't declare unused vars
      media: staging: atomisp: Comment out several unused sensor resolutions
      media: em28xx: fix a regression with HVR-950
      media: siano: get rid of __le32/__le16 cast warnings
      media: atomisp: compat32: fix __user annotations
      media: si470x: fix __be16 annotations

Maxime Chevallier (1):
      net: mvpp2: Add missing VLAN tag detection

Maya Erez (1):
      scsi: ufs: fix exception event handling

Michael Chan (2):
      bnxt_en: Check unsupported speeds in bnxt_update_link() on PF only.
      bnxt_en: Always forward VF MAC address to the PF.

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

Mike Looijmans (1):
      clk-si544: Properly round requested frequency to nearest match

Mikita Lipski (1):
      drm/amd/display: Do not program interrupt status on disabled crtc

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

Oza Pawandeep (1):
      PCI/DPC: Clear interrupt status in interrupt handler top half

Patrice Chotard (2):
      ARM: dts: stih410: Fix complain about IRQ_TYPE_NONE usage
      ARM: dts: stih407-pinctrl: Fix complain about IRQ_TYPE_NONE usage

Patrick Bellasi (1):
      sched/cpufreq: Modify aggregate utilization to always include blocked=
 FAIR utilization

Paul Cercueil (1):
      clk: ingenic: jz4770: Modify C1CLK clock to disable CPU clock stop on=
 idle

Petr Machata (1):
      mlxsw: spectrum_switchdev: Fix port_vlan refcounting

Philippe CORNU (1):
      drm/stm: ltdc: fix warning in ltdc_crtc_update_clut()

Qu Wenruo (1):
      btrfs: qgroup: Finish rescan when hit the last leaf of extent tree

Rafael J. Wysocki (1):
      ACPI / LPSS: Avoid PM quirks on suspend and resume from hibernation

Ram Pai (1):
      mm, powerpc, x86: define VM_PKEY_BITx bits if CONFIG_ARCH_HAS_PKEYS i=
s enabled

Rob Herring (1):
      ARM: dts: imx53: Fix LDB OF graph warning

Sahitya Tummala (1):
      f2fs: Fix deadlock in shutdown ioctl

Sam Bobroff (1):
      powerpc/eeh: Fix use-after-release of EEH driver

Sami Tolvanen (1):
      media: media-device: fix ioctl function types

Samuel Li (1):
      drm/amdgpu: Remove VRAM from shared bo domains.

Sandipan Das (2):
      bpf: fix multi-function JITed dump obtained via syscall
      bpf: powerpc64: pad function address loads with NOPs

Sanjay Kumar Konduri (1):
      rsi: Add null check for virtual interfaces in wowlan config

Satendra Singh Thakur (1):
      drm/atomic: Handling the case when setting old crtc for plane

Scott Mayhew (1):
      nfsd: fix potential use-after-free in nfsd4_decode_getdeviceinfo

Scott Wood (1):
      x86/microcode: Make the late update update_lock a raw lock for RT

Sean Lanigan (1):
      brcmfmac: Add support for bcm43364 wireless chipset

Sean Young (1):
      media: rc: mce_kbd decoder: low timeout values cause double keydowns

Sebastian Andrzej Siewior (2):
      PM / wakeup: Make s2idle_lock a RAW_SPINLOCK
      delayacct: Use raw_spinlocks

Sergey Matyukevich (1):
      qtnfmac: fix invalid STA state on EAPOL failure

Sergey Senozhatsky (1):
      printk: drop in_nmi check from printk_safe_flush_on_panic()

Sergio Paracuellos (1):
      staging: ks7010: fix error handling in ks7010_upload_firmware

Shakeel Butt (1):
      kvm, mm: account shadow page tables to kmemcg

Shaul Triebitz (1):
      iwlwifi: pcie: fix race in Rx buffer allocator

Shawn Lin (1):
      mmc: dw_mmc: update actual clock for mmc debugfs

Shirish S (1):
      drm/amd/display: remove need of modeset flag for overlay planes (V2)

Shivasharan S (1):
      scsi: megaraid_sas: Increase timeout by 1 sec for non-RAID fastpath I=
Os

Shuah Khan (Samsung OSG) (5):
      usbip: usbip_detach: Fix memory, udev context and udev leak
      selftests: memfd: return Kselftest Skip code for skipped tests
      selftests: kvm: return Kselftest Skip code for skipped tests
      selftests: intel_pstate: return Kselftest Skip code for skipped tests
      selftests: filesystems: return Kselftest Skip code for skipped tests

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

Takashi Iwai (3):
      ALSA: emu10k1: Rate-limit error messages about page errors
      ALSA: usb-audio: Apply rate limit to warning messages in URB complete=
 callback
      dma-direct: try reallocation with GFP_DMA32 if possible

Takashi Sakamoto (1):
      ALSA: hda/ca0132: fix build failure when a local macro is defined

Tamizh Chelvam (1):
      ath10k: fix kernel panic while reading tpc_stats

Tariq Toukan (1):
      net: rollback orig value on failure of dev_qdisc_change_tx_queue_len

Tejun Heo (1):
      delayacct: fix crash in delayacct_blkio_end() after delayacct init fa=
ilure

Terry Junge (1):
      HID: hid-plantronics: Re-resend Update to map button for PTT products

Tetsuo Handa (2):
      mm: check for SIGKILL inside dup_mmap() loop
      kernel/hung_task.c: show all hung tasks before panic

Theodore Ts'o (5):
      random: mix rdrand with entropy sent in from userspace
      ext4: fix false negatives *and* false positives in ext4_check_descrip=
tors()
      ext4: fix inline data updates with checksums enabled
      ext4: check for allocation block validity with block group locked
      ext4: fix check to prevent initializing reserved inodes

Thierry Escande (1):
      Bluetooth: hci_qca: Fix "Sleep inside atomic section" warning

Thierry Reding (1):
      gpu: host1x: Acquire a reference to the IOVA cache

Thomas Gleixner (1):
      stop_machine: Use raw spinlocks

Thomas Hebb (1):
      ath10k: search all IEs for variant before falling back

Thomas Richter (2):
      s390/cpum_sf: Add data entry sizes to sampling trailer entry
      perf: fix invalid bit in diagnostic entry

Thor Thayer (1):
      EDAC, altera: Fix ARM64 build warning

Tobin C. Harding (1):
      mmc: pwrseq: Use kmalloc_array instead of stack VLA

Tomasz Figa (1):
      drm/rockchip: analogix_dp: Do not call Analogix code before bind

Tony Lindgren (1):
      spi: Add missing pm_runtime_put_noidle() after failed get

Toshiaki Makita (1):
      virtio_net: Fix incosistent received bytes counter

Trond Myklebust (3):
      NFSv4.1: Fix the client behaviour on NFS4ERR_SEQ_FALSE_RETRY
      pnfs: Don't release the sequence slot until we've processed layoutget=
 on open
      NFS: Fix up nfs_post_op_update_inode() to force ctime updates

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

Viresh Kumar (1):
      soc/tegra: pmc: Don't allocate struct tegra_powergate on stack

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

Wolfram Sang (3):
      watchdog: renesas-wdt: Add support for the R8A77965 WDT
      backlight: pwm_bl: Don't use GPIOF_* with gpiod_get_direction
      i2c: rcar: handle RXDMA HW behaviour on Gen3

Xi Wang (3):
      net: hns3: Fix for VF mailbox cannot receiving PF response
      net: hns3: Fix the missing client list node initialization
      net: hns3: Fix for hns3 module is loaded multiple times problem

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

Yousuk Seung (1):
      tcp: refactor tcp_ecn_check_ce to remove sk type cast

Yufen Yu (1):
      md: fix NULL dereference of mddev->pers in remove_and_add_spares()

Yunlei He (1):
      f2fs: fix missing clear FI_NO_PREALLOC in some error case

Yunsheng Lin (4):
      net: hns3: Fix for phy not link up problem after resetting
      net: hns3: Fix for service_task not running problem after resetting
      net: hns3: Fix for CMDQ and Misc. interrupt init order problem
      net: hns3: Fix for fiber link up problem

Zhouyang Jia (2):
      ALSA: emu10k1: add error handling for snd_ctl_add
      ALSA: fm801: add error handling for snd_ctl_add

tangpengpeng (1):
      net: fix amd-xgbe flow-control issue


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltj9gkACgkQONu9yGCS
aT7JMQ/9E6Z2VWPFpoye2bx9DY2LGgaG4zsJAxVQ1RhQMy+e2tPI1k1wEE2K1wJC
Z4Cx+cTjCorYjoX2kR3X8CipzjS0jnbEU9GcPnYbF/z4wcttoLM2ABSzlMyZ1kZn
79G7a6CUL0L708IvPoRljPyJqCNxJYO5gtURrdOM5BT0Hmx4iWIGVsEkYRTygqFZ
OjZtsT6yCRlUSsmd0gnspWo48DP7logHla7ruSIJ57ly08l1Cjt1GqIv5j6i/Xal
SouUAKnfHcXlymA673+CiCtl+KEHNO2lWTwABMsfAKv4b3k68jvHVAVbwyZe5ceS
DXH9roc0WRRP5pXDEcvgJAkh7ecG+j/DYlUyCE97Jfg94jCPccHuIYPe7vrwK02L
f/6jNv4DIz4jZ49XdIL4h29H2MHmM3SRrRPyWjP7YUGj3Y94ViMhw2QPQjM079DA
1Sko/9niGdsbszswDbJ1rw+bTB+fjmflh/ee27zgkuPenX9QER0DpUa5Rl+oks1q
cg3GXn/VJMPeahESztysOTXtSivUzQ1QeS4YtYF4ObCCXBP5Skbs0GvyXfR4iHfC
dvjd8nG0TyY+w79/iJm5wZWnIQRacmQm0+0imzSlsQyBhKpiebloxyFRh51iV1ez
XmqChLakAZ62FMoYV2YhEZWoG5AlBxdgBpUR4Ko5d6zg+0CBz+s=
=ZJmB
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
