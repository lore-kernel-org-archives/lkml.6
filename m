Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C683C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13E920652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13E920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJDWqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:46:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbeJDWqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:46:50 -0400
Received: from localhost (unknown [104.132.1.111])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B0738481;
        Thu,  4 Oct 2018 15:52:54 +0000 (UTC)
Date:   Thu, 4 Oct 2018 08:52:53 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.12
Message-ID: <20181004155253.GA7745@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.12 kernel.

All users of the 4.18 kernel series must upgrade.

The updated 4.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/hwmon/ina2xx                                          |    2=
=20
 Documentation/process/2.Process.rst                                 |    2=
=20
 Makefile                                                            |    2=
=20
 arch/arm/boot/dts/dra7.dtsi                                         |    4=
=20
 arch/arm/boot/dts/imx7d.dtsi                                        |   12=
=20
 arch/arm/boot/dts/ls1021a.dtsi                                      |    1=
=20
 arch/arm/boot/dts/mt7623.dtsi                                       |    3=
=20
 arch/arm/boot/dts/omap4-droid4-xt894.dts                            |   20=
 -
 arch/arm/mach-mvebu/pmsu.c                                          |    6=
=20
 arch/arm/mach-omap2/omap_hwmod.c                                    |   39=
 ++
 arch/arm/mach-omap2/omap_hwmod_reset.c                              |   12=
=20
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi                        |    2=
=20
 arch/arm64/boot/dts/renesas/r8a7795.dtsi                            |    6=
=20
 arch/arm64/boot/dts/renesas/r8a7796.dtsi                            |    6=
=20
 arch/arm64/boot/dts/renesas/r8a77965.dtsi                           |    4=
=20
 arch/arm64/boot/dts/renesas/r8a77970.dtsi                           |    2=
=20
 arch/arm64/boot/dts/renesas/r8a77995.dtsi                           |    4=
=20
 arch/arm64/boot/dts/renesas/salvator-common.dtsi                    |    4=
=20
 arch/arm64/kvm/guest.c                                              |   55=
 ++
 arch/mips/boot/Makefile                                             |    6=
=20
 arch/powerpc/kernel/exceptions-64s.S                                |    4=
=20
 arch/powerpc/kernel/machine_kexec.c                                 |    7=
=20
 arch/powerpc/lib/checksum_64.S                                      |    3=
=20
 arch/powerpc/mm/numa.c                                              |    3=
=20
 arch/powerpc/mm/pkeys.c                                             |    2=
=20
 arch/powerpc/platforms/powernv/pci-ioda.c                           |    2=
=20
 arch/s390/kernel/sysinfo.c                                          |    4=
=20
 arch/s390/mm/extmem.c                                               |    4=
=20
 arch/s390/mm/pgalloc.c                                              |    2=
=20
 arch/x86/entry/entry_64.S                                           |    4=
=20
 arch/x86/events/intel/lbr.c                                         |   32=
 +
 arch/x86/events/perf_event.h                                        |    1=
=20
 arch/x86/include/asm/fixmap.h                                       |   10=
=20
 arch/x86/include/asm/pgtable_64.h                                   |    3=
=20
 arch/x86/kernel/head64.c                                            |    4=
=20
 arch/x86/kernel/head_64.S                                           |   16=
=20
 arch/x86/kernel/tsc_msr.c                                           |    1=
=20
 arch/x86/mm/numa_emulation.c                                        |    2=
=20
 arch/x86/mm/pgtable.c                                               |    9=
=20
 arch/x86/mm/pti.c                                                   |    2=
=20
 arch/x86/xen/mmu_pv.c                                               |    8=
=20
 block/elevator.c                                                    |    2=
=20
 crypto/ablkcipher.c                                                 |    2=
=20
 crypto/blkcipher.c                                                  |    1=
=20
 drivers/acpi/button.c                                               |   13=
=20
 drivers/ata/pata_ftide010.c                                         |   27=
 -
 drivers/block/floppy.c                                              |    3=
=20
 drivers/bluetooth/btusb.c                                           |    1=
=20
 drivers/bus/ti-sysc.c                                               |   37=
 -
 drivers/clk/x86/clk-st.c                                            |    2=
=20
 drivers/crypto/cavium/nitrox/nitrox_dev.h                           |    3=
=20
 drivers/crypto/cavium/nitrox/nitrox_lib.c                           |    1=
=20
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c                        |   57=
 +--
 drivers/crypto/chelsio/chtls/chtls.h                                |    5=
=20
 drivers/crypto/chelsio/chtls/chtls_main.c                           |    7=
=20
 drivers/edac/altera_edac.c                                          |    3=
=20
 drivers/edac/edac_mc_sysfs.c                                        |    6=
=20
 drivers/edac/i7core_edac.c                                          |   22=
 -
 drivers/gpio/gpio-menz127.c                                         |    4=
=20
 drivers/gpio/gpio-tegra.c                                           |   15=
=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                              |   16=
=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c                              |    3=
=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                              |    3=
=20
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                               |   11=
=20
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                                 |    4=
=20
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                                 |    3=
=20
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c               |   10=
=20
 drivers/gpu/drm/amd/display/dc/dml/dml1_display_rq_dlg_calc.c       |    2=
=20
 drivers/gpu/drm/omapdrm/omap_debugfs.c                              |    2=
=20
 drivers/gpu/drm/omapdrm/omap_drv.c                                  |    2=
=20
 drivers/gpu/drm/omapdrm/omap_drv.h                                  |    2=
=20
 drivers/gpu/drm/omapdrm/omap_gem.c                                  |   15=
=20
 drivers/gpu/drm/sun4i/sun4i_drv.c                                   |    3=
=20
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c                              |    7=
=20
 drivers/gpu/drm/v3d/v3d_drv.h                                       |    5=
=20
 drivers/gpu/drm/v3d/v3d_gem.c                                       |    4=
=20
 drivers/gpu/drm/vc4/vc4_plane.c                                     |    3=
=20
 drivers/hid/hid-ntrig.c                                             |    2=
=20
 drivers/hid/i2c-hid/i2c-hid.c                                       |    9=
=20
 drivers/hwmon/adt7475.c                                             |   14=
=20
 drivers/hwmon/ina2xx.c                                              |   13=
=20
 drivers/hwtracing/intel_th/core.c                                   |   16=
=20
 drivers/i2c/busses/i2c-i801.c                                       |    9=
=20
 drivers/iio/accel/adxl345_core.c                                    |   21=
 -
 drivers/iio/adc/ina2xx-adc.c                                        |   17=
=20
 drivers/iio/counter/104-quad-8.c                                    |    2=
=20
 drivers/infiniband/core/rw.c                                        |    2=
=20
 drivers/infiniband/core/uverbs_cmd.c                                |    5=
=20
 drivers/infiniband/core/uverbs_main.c                               |    1=
=20
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                            |   12=
=20
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                            |    4=
=20
 drivers/infiniband/hw/hfi1/chip.c                                   |    6=
=20
 drivers/infiniband/hw/hfi1/pio.c                                    |   51=
 ++
 drivers/infiniband/hw/hfi1/pio.h                                    |    2=
=20
 drivers/infiniband/hw/hfi1/user_sdma.c                              |    2=
=20
 drivers/infiniband/hw/hfi1/verbs.c                                  |    8=
=20
 drivers/infiniband/hw/i40iw/i40iw_verbs.c                           |    2=
=20
 drivers/infiniband/hw/mlx4/qp.c                                     |    2=
=20
 drivers/infiniband/hw/mlx5/main.c                                   |    2=
=20
 drivers/infiniband/ulp/srp/ib_srp.c                                 |    6=
=20
 drivers/input/misc/xen-kbdfront.c                                   |    8=
=20
 drivers/input/mouse/elantech.c                                      |    2=
=20
 drivers/iommu/amd_iommu.c                                           |    2=
=20
 drivers/iommu/msm_iommu.c                                           |   16=
=20
 drivers/md/md-cluster.c                                             |   19=
 -
 drivers/media/i2c/ov772x.c                                          |   40=
 +-
 drivers/media/i2c/soc_camera/ov772x.c                               |    2=
=20
 drivers/media/platform/exynos4-is/fimc-isp-video.c                  |   11=
=20
 drivers/media/platform/fsl-viu.c                                    |   38=
 +-
 drivers/media/platform/omap3isp/isp.c                               |    2=
=20
 drivers/media/platform/s3c-camif/camif-capture.c                    |    2=
=20
 drivers/media/usb/tm6000/tm6000-dvb.c                               |    5=
=20
 drivers/media/v4l2-core/v4l2-event.c                                |   38=
 +-
 drivers/media/v4l2-core/v4l2-fh.c                                   |    2=
=20
 drivers/misc/ibmvmc.c                                               |    2=
=20
 drivers/misc/sram.c                                                 |   13=
=20
 drivers/misc/tsl2550.c                                              |    2=
=20
 drivers/misc/vmw_vmci/vmci_queue_pair.c                             |    4=
=20
 drivers/mmc/host/android-goldfish.c                                 |    4=
=20
 drivers/mmc/host/atmel-mci.c                                        |   12=
=20
 drivers/mtd/nand/raw/atmel/nand-controller.c                        |    7=
=20
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c                     |    2=
=20
 drivers/net/ethernet/hisilicon/hns/hnae.h                           |    6=
=20
 drivers/net/ethernet/hisilicon/hns/hns_enet.c                       |    2=
=20
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h                     |    6=
=20
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c                  |    2=
=20
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c               |    9=
=20
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c           |   11=
=20
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c            |    3=
=20
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c                    |    7=
=20
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                      |    2=
=20
 drivers/net/ethernet/intel/i40e/i40e_main.c                         |   15=
=20
 drivers/net/ethernet/intel/ice/ice.h                                |    7=
=20
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h                     |   25=
 -
 drivers/net/ethernet/intel/ice/ice_common.c                         |   27=
 -
 drivers/net/ethernet/intel/ice/ice_controlq.c                       |   29=
 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c                        |   52=
 ++
 drivers/net/ethernet/intel/ice/ice_main.c                           |   98=
 +++--
 drivers/net/ethernet/intel/ice/ice_switch.c                         |    4=
=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                      |   26=
 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h                       |    1=
=20
 drivers/net/ethernet/qlogic/qed/qed_mcp.c                           |  187=
 ++++++++--
 drivers/net/ethernet/qlogic/qed/qed_mcp.h                           |   27=
 -
 drivers/net/ethernet/qlogic/qed/qed_reg_addr.h                      |    2=
=20
 drivers/net/phy/xilinx_gmii2rgmii.c                                 |   10=
=20
 drivers/net/wireless/ath/ath10k/ce.c                                |    2=
=20
 drivers/net/wireless/ath/ath10k/htt_rx.c                            |   13=
=20
 drivers/net/wireless/ath/ath10k/mac.c                               |    1=
=20
 drivers/net/wireless/ath/ath10k/sdio.c                              |    9=
=20
 drivers/net/wireless/ath/ath10k/snoc.c                              |    2=
=20
 drivers/net/wireless/ath/ath10k/wmi.c                               |    8=
=20
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_qmath.c    |    2=
=20
 drivers/net/wireless/mediatek/mt76/mt76x2_mac.c                     |    6=
=20
 drivers/net/wireless/rndis_wlan.c                                   |    2=
=20
 drivers/net/wireless/ti/wlcore/cmd.c                                |    6=
=20
 drivers/nvme/target/fcloop.c                                        |    3=
=20
 drivers/pci/hotplug/acpiphp_glue.c                                  |   11=
=20
 drivers/platform/x86/asus-wireless.c                                |   23=
 -
 drivers/power/reset/vexpress-poweroff.c                             |   12=
=20
 drivers/power/supply/axp288_charger.c                               |    2=
=20
 drivers/power/supply/power_supply_core.c                            |   11=
=20
 drivers/regulator/core.c                                            |    4=
=20
 drivers/regulator/of_regulator.c                                    |    2=
=20
 drivers/s390/block/dasd.c                                           |    1=
=20
 drivers/s390/block/scm_blk.c                                        |    1=
=20
 drivers/scsi/bnx2i/bnx2i_hwi.c                                      |    2=
=20
 drivers/scsi/hisi_sas/hisi_sas.h                                    |    1=
=20
 drivers/scsi/hisi_sas/hisi_sas_main.c                               |    6=
=20
 drivers/scsi/ibmvscsi/ibmvscsi.c                                    |    4=
=20
 drivers/scsi/megaraid/megaraid_sas_base.c                           |    3=
=20
 drivers/siox/siox-core.c                                            |   10=
=20
 drivers/spi/spi-orion.c                                             |   77=
 ++--
 drivers/spi/spi-rspi.c                                              |   34=
 +
 drivers/spi/spi-sh-msiof.c                                          |   28=
 +
 drivers/spi/spi-tegra20-slink.c                                     |   31=
 +
 drivers/staging/android/ashmem.c                                    |    6=
=20
 drivers/staging/media/imx/imx-ic-prpencvf.c                         |    1=
=20
 drivers/staging/media/imx/imx-media-csi.c                           |    1=
=20
 drivers/staging/mt7621-dts/gbpc1.dts                                |    2=
=20
 drivers/staging/mt7621-dts/mt7621.dtsi                              |   21=
 -
 drivers/staging/mt7621-eth/mtk_eth_soc.c                            |   13=
=20
 drivers/staging/pi433/pi433_if.c                                    |    7=
=20
 drivers/staging/rts5208/sd.c                                        |    2=
=20
 drivers/target/iscsi/iscsi_target_tpg.c                             |    3=
=20
 drivers/target/target_core_device.c                                 |   22=
 -
 drivers/thermal/imx_thermal.c                                       |    5=
=20
 drivers/thermal/of-thermal.c                                        |    7=
=20
 drivers/tty/serial/8250/serial_cs.c                                 |    6=
=20
 drivers/tty/serial/cpm_uart/cpm_uart_core.c                         |   10=
=20
 drivers/tty/serial/fsl_lpuart.c                                     |    3=
=20
 drivers/tty/serial/imx.c                                            |    8=
=20
 drivers/tty/serial/mvebu-uart.c                                     |    1=
=20
 drivers/tty/serial/pxa.c                                            |    3=
=20
 drivers/tty/serial/sh-sci.c                                         |    2=
=20
 drivers/usb/class/cdc-wdm.c                                         |    2=
=20
 drivers/usb/common/roles.c                                          |   15=
=20
 drivers/usb/core/devio.c                                            |   24=
 +
 drivers/usb/core/driver.c                                           |   28=
 -
 drivers/usb/core/quirks.c                                           |    3=
=20
 drivers/usb/core/usb.c                                              |    2=
=20
 drivers/usb/musb/musb_dsps.c                                        |   12=
=20
 drivers/usb/serial/kobil_sct.c                                      |   12=
=20
 drivers/usb/wusbcore/security.c                                     |    2=
=20
 drivers/uwb/hwa-rc.c                                                |    1=
=20
 drivers/vhost/net.c                                                 |   35=
 +
 fs/dax.c                                                            |   13=
=20
 fs/ext2/inode.c                                                     |    2=
=20
 fs/iomap.c                                                          |   21=
 -
 fs/isofs/inode.c                                                    |    7=
=20
 fs/locks.c                                                          |    7=
=20
 fs/nfsd/nfs4proc.c                                                  |    1=
=20
 include/linux/arm-smccc.h                                           |   38=
 +-
 include/linux/bitfield.h                                            |    6=
=20
 include/linux/platform_data/ina2xx.h                                |    2=
=20
 include/linux/posix-timers.h                                        |    4=
=20
 include/linux/power_supply.h                                        |    1=
=20
 include/linux/regulator/machine.h                                   |    6=
=20
 include/linux/uio.h                                                 |    2=
=20
 include/media/v4l2-fh.h                                             |    4=
=20
 include/rdma/opa_addr.h                                             |    2=
=20
 kernel/bpf/sockmap.c                                                |   11=
=20
 kernel/events/hw_breakpoint.c                                       |   57=
 ++-
 kernel/module.c                                                     |    6=
=20
 kernel/time/alarmtimer.c                                            |    7=
=20
 kernel/time/posix-cpu-timers.c                                      |    2=
=20
 kernel/time/posix-timers.c                                          |   33=
 +
 kernel/time/posix-timers.h                                          |    2=
=20
 lib/klist.c                                                         |   10=
=20
 net/6lowpan/iphc.c                                                  |    1=
=20
 net/ipv4/tcp_bbr.c                                                  |   38=
 +-
 net/ncsi/ncsi-netlink.c                                             |    4=
=20
 net/tls/tls_main.c                                                  |    9=
=20
 sound/aoa/core/gpio-feature.c                                       |    4=
=20
 sound/pci/hda/hda_intel.c                                           |    3=
=20
 sound/soc/codecs/rt1305.c                                           |    4=
=20
 sound/soc/intel/boards/bytcr_rt5640.c                               |    2=
=20
 sound/soc/qcom/qdsp6/q6afe.c                                        |    6=
=20
 sound/soc/sh/rcar/ssi.c                                             |   32=
 +
 sound/soc/soc-dapm.c                                                |    7=
=20
 tools/bpf/bpftool/map_perf_ring.c                                   |    5=
=20
 tools/perf/tests/builtin-test.c                                     |    2=
=20
 tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d_vlan.sh |    6=
=20
 tools/testing/selftests/net/forwarding/mirror_gre_lib.sh            |    2=
=20
 tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh |    6=
=20
 244 files changed, 1764 insertions(+), 807 deletions(-)

Aaron Ma (1):
      Input: elantech - enable middle button of touchpad on ThinkPad P72

Akinobu Mita (6):
      iio: adc: ina2xx: avoid kthread_stop() with stale task_struct
      iio: accel: adxl345: convert address field usage in iio_chan_spec
      media: s3c-camif: ignore -ENOIOCTLCMD from v4l2_subdev_call for s_pow=
er
      media: soc_camera: ov772x: correct setting of banding filter
      media: ov772x: add checks for register read errors
      media: ov772x: allow i2c controllers without I2C_FUNC_PROTOCOL_MANGLI=
NG

Akshu Agrawal (1):
      clk: x86: Set default parent to 48Mhz

Alagu Sankar (2):
      ath10k: sdio: use same endpoint id for all packets in a bundle
      ath10k: sdio: set skb len for all rx packets

Alan Stern (3):
      USB: fix error handling in usb_driver_claim_interface()
      USB: handle NULL config in usb_find_alt_setting()
      USB: remove LPM management from usb_driver_claim_interface()

Alexander Shishkin (2):
      intel_th: Fix device removal logic
      intel_th: Fix resource handling for ACPI glue layer

Alexey Kardashevskiy (1):
      powerpc/powernv/ioda2: Reduce upper limit for DMA window size

Alexey Khoroshilov (1):
      media: fsl-viu: fix error handling in viu_of_probe()

Alistair Strachan (1):
      staging: android: ashmem: Fix mmap size validation

Andreas Gruenbacher (1):
      iomap: complete partial direct I/O writes synchronously

Andy Shevchenko (1):
      x86/tsc: Add missing header to tsc_msr.c

Andy Whitcroft (1):
      floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl

Anirudh Venkataramanan (3):
      ice: Fix multiple static analyser warnings
      ice: Fix bugs in control queue processing
      ice: Fix a few null pointer dereference issues

Anson Huang (1):
      thermal: of-thermal: disable passive polling when thermal zone is dis=
abled

Anton Vasilyev (1):
      uwb: hwa-rc: fix memory leak at probe

Bart Van Assche (5):
      include/rdma/opa_addr.h: Fix an endianness issue
      scsi: target/iscsi: Make iscsit_ta_authentication() respect the outpu=
t buffer size
      scsi: klist: Make it safe to use klists in atomic context
      scsi: target: Avoid that EXTENDED COPY commands trigger lock inversion
      IB/srp: Avoid that sg_reset -d ${srp_device} triggers an infinite loop

Ben Greear (1):
      ath10k: protect ath10k_htt_rx_ring_free with rx_ring.lock

Benjamin Tissoires (1):
      power: remove possible deadlock when unregistering power_supply

Bin Liu (1):
      usb: musb: dsps: do not disable CPPI41 irq in driver teardown

Bo Chen (2):
      e1000: check on netif_running() before calling e1000_up()
      e1000: ensure to free old tx/rx rings in set_ringparam()

Bob Copeland (1):
      ath10k: use locked skb_dequeue for rx completions

Brandon Maier (2):
      net: phy: xgmiitorgmii: Check read_status results
      net: phy: xgmiitorgmii: Check phy_driver ready before accessing

Breno Leitao (1):
      scsi: ibmvscsi: Improve strings handling

Brett Creeley (1):
      ice: Set VLAN flags correctly

Brian Norris (1):
      ath10k: snoc: use correct bus-specific pointer in RX retry

Christian K=F6nig (2):
      drm/amdgpu: fix VM clearing for the root PD
      drm/amdgpu: fix preamble handling

Christophe JAILLET (2):
      serial: pxa: Fix an error handling path in 'serial_pxa_probe()'
      EDAC, altera: Fix an error handling path in altr_s10_sdram_probe()

Christophe Leroy (2):
      serial: cpm_uart: return immediately from console poll
      powerpc: fix csum_ipv6_magic() on little endian platforms

Colin Ian King (2):
      staging: rts5208: fix missing error check on call to rtsx_write_regis=
ter
      ath10k: fix memory leak of tpc_stats

Damien Le Moal (1):
      block: fix deadline elevator drain for zoned block devices

Dan Carpenter (7):
      vmci: type promotion bug in qp_host_get_user_memory()
      RDMA/bnxt_re: Fix a couple off by one bugs
      RDMA/bnxt_re: Fix a bunch of off by one bugs in qplib_fp.c
      IB/core: type promotion bug in rdma_rw_init_one_mr()
      ASoC: qdsp6: qdafe: fix some off by one bugs
      rndis_wlan: potential buffer overflow in rndis_wlan_auth_indication()
      hwmon: (adt7475) Make adt7475_read_word() return errors

Dan Williams (1):
      x86/numa_emulation: Fix emulated-to-physical node mapping

Daniel Borkmann (2):
      bpf, sockmap: fix sock_hash_alloc and reject zero-sized keys
      bpf, sockmap: fix sock hash count in alloc_sock_hash_elem

Daniel Vetter (1):
      drm/omap: gem: Fix mm_list locking

Dave Gerlach (1):
      ARM: hwmod: RTC: Don't assume lock/unlock will be called with irq ena=
bled

Dave Jiang (1):
      uaccess: Fix is_source param for check_copy_size() in copy_to_iter_mc=
safe()

Dave Martin (1):
      arm64: KVM: Tighten guest core register access from userspace

Dmitry Osipenko (1):
      gpio: tegra: Fix tegra_gpio_irq_set_type()

Emily Deng (2):
      amdgpu: fix multi-process hang issue
      drm/amdgpu: Need to set moved to true when evict bo

Eric Anholt (2):
      drm/v3d: Take a lock across GPU scheduler job creation and queuing.
      drm/vc4: Add missing formats to vc4_format_mod_supported().

Eric Sandeen (1):
      isofs: reject hardware sector size > 2048 bytes

Ethan Tuttle (1):
      ARM: mvebu: declare asm symbols as character arrays in pmsu.c

Feng Tang (1):
      x86/mm: Expand static page table for fixmap space

Frederic Weisbecker (1):
      perf/hw_breakpoint: Split attribute parse and commit

Fuyun Liang (1):
      net: hns3: Fix for mailbox message truncated problem

Gaku Inami (1):
      spi: sh-msiof: Fix invalid SPI use during system suspend

Ganesh Goudar (2):
      cxgb4: Fix the condition to check if the card is T5
      crypto: chtls - fix null dereference chtls_free_uld()

Geert Uytterhoeven (5):
      serial: sh-sci: Stop RX FIFO timer during port shutdown
      arm64: dts: renesas: salvator-common: Fix adv7482 decimal unit addres=
ses
      ASoC: rt1305: Use ULL suffixes for 64-bit constants
      spi: rspi: Fix invalid SPI use during system suspend
      spi: rspi: Fix interrupted DMA transfers

Greg Kroah-Hartman (1):
      Linux 4.18.12

Guoqing Jiang (1):
      md-cluster: clear another node's suspend_area after the copy is finis=
hed

Gustavo A. R. Silva (1):
      drm/amd/display/dc/dce: Fix multiple potential integer overflows

Hans de Goede (2):
      power: supply: axp288_charger: Fix initial constant_charge_current va=
lue
      ASoC: Intel: bytcr_rt5640: Fix Acer Iconia 8 over-current detect thre=
shold

Hari Bathini (1):
      powerpc/kdump: Handle crashkernel memory reservation failure

Harry Pan (1):
      usb: core: safely deal with the dynamic quirk lists

Heikki Krogerus (1):
      usb: roles: Take care of driver module reference counting

Heiko Carstens (1):
      s390/sysinfo: add missing #ifdef CONFIG_PROC_FS

Hiromitsu Yamasaki (1):
      spi: sh-msiof: Fix handling of write value for SISTR register

Huazhong Tan (3):
      net: hns: fix length and page_offset overflow when CONFIG_ARM64_64K_P=
AGES
      net: hns: fix skb->truesize underestimation
      net: hns3: fix page_offset overflow when CONFIG_ARM64_64K_PAGES

Hugo Lefeuvre (1):
      staging: pi433: fix race condition in pi433_ioctl

Ira Weiny (1):
      IB/hfi1: Fix SL array bounds check

J. Bruce Fields (1):
      nfsd: fix corrupted reply to badly ordered compound

Jacob Keller (3):
      ice: Report stats for allocated queues via ethtool stats
      ice: Use order_base_2 to calculate higher power of 2
      i40e: fix condition of WARN_ONCE for stat strings

James Smart (1):
      nvme-fcloop: Fix dropped LS's to removed target port

Jan Beulich (1):
      x86/entry/64: Add two more instruction suffixes

Jan Kiszka (1):
      serial: mvebu-uart: Fix reporting of effective CSIZE to userspace

Jan Kundr=E1t (1):
      spi: orion: fix CS GPIO handling again

Javier Martinez Canillas (1):
      media: omap3isp: zero-initialize the isp cam_xclk{a,b} initial data

Jean-Christophe Dubois (1):
      thermal: i.MX: Allow thermal probe to fail gracefully in case of bad =
calibration.

Jernej Skrabec (2):
      drm/sun4i: Enable DW HDMI PHY clock
      drm/sun4i: Fix releasing node when enumerating enpoints

Jesse Brandeburg (1):
      ice: Fix potential return of uninitialized value

Jessica Yu (1):
      module: exclude SHN_UNDEF symbols from kallsyms api

Jian-Hong Pan (1):
      Bluetooth: Add a new Realtek 8723DE ID 0bda:b009

Johan Hovold (4):
      misc: sram: enable clock before registering regions
      USB: serial: kobil_sct: fix modem-status error handling
      EDAC, i7core: Fix memleaks and use-after-free on probe and remove
      EDAC: Fix memleak in module init error path

Johannes Berg (1):
      bitfield: fix *_encode_bits()

John Fastabend (2):
      tls: possible hang when do_tcp_sendpages hits sndbuf is full case
      bpf: sockmap: write_space events need to be passed to TCP handler

Jo=E3o Paulo Rechi Vita (1):
      platform/x86: asus-wireless: Fix uninitialized symbol usage

Julia Lawall (1):
      usb: wusbcore: security: cast sizeof to int for comparison

Kai-Heng Feng (1):
      ALSA: hda: Add AZX_DCAPS_PM_RUNTIME for AMD Raven Ridge

Kamal Heib (1):
      staging: mt7621-eth: Fix memory leak in mtk_add_mac() error path

Kan Liang (1):
      perf/x86/intel/lbr: Fix incomplete LBR call stack

Kevin Hilman (1):
      ARM: dts: dra7: fix DCAN node addresses

Kevin Yang (2):
      tcp_bbr: add bbr_check_probe_rtt_done() helper
      tcp_bbr: in restart from idle, see if we should exit PROBE_RTT

Konstantin Khorenko (1):
      fs/lock: skip lock owner pid translation in case we are in init_pid_ns

Kuninori Morimoto (1):
      ASoC: rsnd: SSI parent cares SWSP bit

Laurent Pinchart (1):
      arm64: dts: renesas: Fix VSPD registers range

Leon Romanovsky (2):
      RDMA/i40w: Hold read semaphore while looking after VMA
      RDMA/uverbs: Don't overwrite NULL pointer with ZERO_SIZE_PTR

Leonard Crestez (1):
      Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"

Liam Girdwood (1):
      ASoC: dapm: Fix potential DAI widget pointer deref when linking DAIs

Linus Walleij (1):
      ata: ftide010: Add a quirk for SQ201

Lorenzo Bianconi (1):
      mt76x2: fix mrr idx/count estimation in mt76x2_mac_fill_tx_status()

Lothar Felten (1):
      hwmon: (ina2xx) fix sysfs shunt resistor read access

Ludovic Desroches (2):
      mmc: atmel-mci: fix bad logic of sg_copy_{from,to}_buffer conversion
      mmc: android-goldfish: fix bad logic of sg_copy_{from,to}_buffer conv=
ersion

Maor Gottlieb (1):
      IB/mlx5: Fix GRE flow specification

Marc Zyngier (3):
      arm/arm64: smccc-1.1: Make return values unsigned long
      arm/arm64: smccc-1.1: Handle function result as parameters
      arm64: KVM: Sanitize PSTATE.M when being set from userspace

Marcel Ziswiler (1):
      spi: tegra20-slink: explicitly enable/disable clock

Marek Szyprowski (1):
      regulator: Fix 'do-nothing' value for regulators without suspend state

Martyna Szapar (1):
      i40e: Fix for Tx timeouts when interface is brought up if DCB is enab=
led

Masahiro Yamada (1):
      MIPS: boot: fix build rule of vmlinux.its.S

Matt Ranostay (1):
      tsl2550: fix lux1_input error in low light

Matthew Wilcox (1):
      filesystem-dax: Fix use of zero page

Maxime Ripard (1):
      drm/vc4: plane: Expand the lower bits by repeating the higher bits

Michael Bringmann (1):
      powerpc/pseries: Fix unitialized timer reset on migration

Michael J. Ruhl (3):
      IB/hfi1: Invalid user input can result in crash
      IB/hfi1: Fix context recovery when PBC has an UnsupportedVL
      IB/hfi1: Fix destroy_qp hang after a link down

Michael Neuling (1):
      KVM: PPC: Book3S HV: Fix guest r11 corruption with POWER9 TM workarou=
nds

Michael Scott (1):
      6lowpan: iphc: reset mac_header after decompress to fix panic

Mika Westerberg (2):
      ACPI / hotplug / PCI: Don't scan for non-hotplug bridges if slot is n=
ot bridge
      i2c: i801: Allow ACPI AML access I/O ports not reserved for SMBus

Nadav Amit (1):
      gpio: Fix wrong rounding in gpio-menz127

Nicholas Mc Guire (1):
      ALSA: snd-aoa: add of_node_put() in error path

Niklas Cassel (2):
      iommu/msm: Don't call iommu_device_{,un}link from atomic context
      ath10k: transmit queued frames after processing rx packets

Oleksandr Andrushchenko (1):
      Input: xen-kbdfront - fix multi-touch XenStore node's locations

Oliver Neukum (2):
      USB: usbdevfs: sanitize flags more
      USB: usbdevfs: restore warning for nonsensical flags

Pavel Machek (1):
      ARM: dts: omap4-droid4: fix vibrations on Droid 4

Peter Rosin (1):
      mtd: rawnand: atmel: add module param to avoid using dma

Peter Seiderer (1):
      media: staging/imx: fill vb2_v4l2_buffer field entry

Petr Machata (1):
      selftests: forwarding: Tweak tc filters for mirror-to-gretap tests

Preethi Banala (1):
      ice: Clean control queues only when they are initialized

Quentin Monnet (1):
      tools: bpftool: return from do_event_pipe() on bad arguments

Randy Dunlap (2):
      Documentation/process: fix reST table border error
      x86/pti: Fix section mismatch warning/error

Ravi Chandra Sadineni (1):
      ACPI / button: increment wakeup count only when notified

Rex Zhu (2):
      drm/amdgpu: Enable/disable gfx PG feature in rlc safe mode
      drm/amdgpu: Update power state at the end of smu hw_init.

Rosen Penev (1):
      staging: mt7621-dts: Fix remaining pcie warnings

Sakari Ailus (1):
      media: v4l: event: Prevent freeing event subscriptions while accessed

Samuel Mendoza-Jonas (1):
      net/ncsi: Fixup .dumpit message flags and ID check in Netlink handler

Sandipan Das (1):
      perf tests: Fix indexing when invoking subtests

Sebastian Andrzej Siewior (1):
      Revert "usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_ou=
tstanding_interrupt()"

Sebastian Basierski (1):
      ixgbe: fix driver behaviour after issuing VFLR

Shivasharan S (1):
      scsi: megaraid_sas: Update controller info during resume

Srikanth Jampala (1):
      crypto: cavium/nitrox - fix for command corruption in queue full case=
 with backlog submissions.

Stafford Horne (1):
      crypto: skcipher - Fix -Wstringop-truncation warnings

Stefan Agner (2):
      brcmsmac: fix wrap around in conversion from constant to s16
      tty: serial: lpuart: avoid leaking struct tty_struct

Stephen Boyd (1):
      HID: i2c-hid: Use devm to allocate i2c_hid struct

Steve Wise (1):
      RDMA/uverbs: Atomically flush and mark closed the comp event queue

Sudeep Holla (1):
      power: vexpress: fix corruption in notifier registration

Sylwester Nawrocki (1):
      media: exynos4-is: Prevent NULL pointer dereference in __isp_video_tr=
y_fmt()

Tarick Bedeir (1):
      IB/mlx4: Test port number before querying type.

Thiago Jung Bauermann (1):
      powerpc/pkeys: Fix reading of ibm, processor-storage-keys property

Thomas Gleixner (3):
      alarmtimer: Prevent overflow for relative nanosleep
      posix-timers: Make forward callback return s64
      posix-timers: Sanitize overrun handling

Tomer Tayar (4):
      qed: Wait for ready indication before rereading the shmem
      qed: Wait for MCP halt and resume commands to take place
      qed: Prevent a possible deadlock during driver load and unload
      qed: Avoid sending mailbox commands when MFW is not responsive

Tony Lindgren (6):
      wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()
      ARM: OMAP2+: Fix null hwmod for ti-sysc debug
      ARM: OMAP2+: Fix module address for modules using mpu_rt_idx
      bus: ti-sysc: Fix module register ioremap for larger offsets
      bus: ti-sysc: Fix no_console_suspend handling
      ARM: dts: omap4-droid4: Fix emmc errors seen on some devices

Toshi Kani (1):
      ext2, dax: set ext2_dax_aops for dax files

Toshiaki Makita (1):
      vhost_net: Avoid tx vring kicks during busyloop

Uwe Kleine-K=F6nig (2):
      siox: don't create a thread without starting it
      serial: imx: restore handshaking irq for imx1

Vasily Gorbik (4):
      s390/mm: correct allocate_pgste proc_handler callback
      s390/dasd: correct numa_node in dasd_alloc_queue
      s390/scm_blk: correct numa_node in scm_blk_dev_setup
      s390/extmem: fix gcc 8 stringop-overflow warning

Viresh Kumar (2):
      ARM: dts: ls1021a: Add missing cooling device properties for CPUs
      arm: dts: mediatek: Add missing cooling device properties for CPUs

Wei Yongjun (1):
      misc: ibmvmc: Use GFP_ATOMIC under spin lock

Wesley Chalmers (1):
      drm/amd/display: fix use of uninitialized memory

William Breathitt Gray (1):
      iio: 104-quad-8: Fix off-by-one error in register selection

Xiaofei Tan (1):
      scsi: hisi_sas: Fix the conflict between dev gone and host reset

Yu Zhao (1):
      regulator: fix crash caused by null driver data

YueHaibing (1):
      ath10k: fix incorrect size of dma_free_coherent in ath10k_ce_alloc_sr=
c_ring_64

Yunsheng Lin (3):
      net: hns3: Fix for mac pause not disable in pfc mode
      net: hns3: Fix warning bug when doing lp selftest
      net: hns3: Fix get_vector ops in hclgevf_main module

Zhen Lei (1):
      iommu/amd: make sure TLB to be flushed before IOVA freed

Zhouyang Jia (4):
      drivers/tty: add error handling for pcmcia_loop_config
      media: tm6000: add error handling for dvb_register_adapter
      HID: hid-ntrig: add error handling for sysfs_create_group
      scsi: bnx2i: add error handling for ioremap_nocache


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlu2N1UACgkQONu9yGCS
aT5VyBAAoKA4RiOYN+bnvqUHwBGh+LU5KBchZ51Jcikd7To+gqNe0+OMzM/bpFvu
IOknjKYFjAhmQhTCSO84IFfsVQ840bJSsAsfZJ+Myx5inMcdZ8MXkrqiW7pCOGpZ
Tr/hgFE7L9+HNZFb1ryot/RwOHm0Pq+c4pbWWD/H0RPsaIJrjF/kXiE+2ZXyh/uQ
cLZ4qi2we1cQVB3Kejb5SFSBHAznGCW2E/Ydoa65GNg51wFa4BJCT96C8oodeEQ3
GOlzo1XyNO8JA9z7EGQUQ26f1POLP6qJ0qC6pxFvYK8hJYhz4rVNoaa3+CSdylm/
BBz+ftKaNOIjxk356vxL6fsA6LETBcOOB6acc/Tz9VIVmMvoMvyllcaVt3Mc9Mb7
/IsSmgyHBkaAWtyLmgzr+McvGNc+E6JF1lTN+0/ZtTl0bJYuDEAoYoahYEi2XRfw
OCAX7M+lXt7Ww7Fa3xPpOmwyru0feeSHJV4iCpWp2It+Z4IuKC15M1r/+z6Fc+x2
p6ThXB6Yzb045lL87eoyBqRLtP878PZxa8UydkIqBJr2/4dKZarawllksBGxWRpR
Zv+tk18VL8YblqK8WRwBx3SIZGHSKG/mHAAhIdqMm5wl4eGs4Dkxs6exVpbtM4pQ
uZUo6pBlUhaGMkzXXONtW/bUC7Wv0O+gWpwe7Oi+bn5x4BcLFKA=
=lkPy
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
