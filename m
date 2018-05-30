Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968668AbeE3He5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030353AbeE3Hd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:33:56 -0400
Date: Wed, 30 May 2018 09:33:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.45
Message-ID: <20180530073331.GA22702@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.45 kernel.

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

 Documentation/devicetree/bindings/clock/sunxi-ccu.txt              |    4=
=20
 Documentation/devicetree/bindings/dma/mv-xor-v2.txt                |    6=
=20
 Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt |    5=
=20
 Makefile                                                           |    2=
=20
 arch/alpha/include/asm/xchg.h                                      |   30 -
 arch/arc/Kconfig                                                   |    1=
=20
 arch/arc/include/asm/bug.h                                         |    3=
=20
 arch/arc/kernel/mcip.c                                             |   74 =
++-
 arch/arc/kernel/smp.c                                              |   50 =
+-
 arch/arm/boot/dts/at91-tse850-3.dts                                |    2=
=20
 arch/arm/boot/dts/bcm2836.dtsi                                     |    2=
=20
 arch/arm/boot/dts/bcm2837.dtsi                                     |    2=
=20
 arch/arm/boot/dts/bcm283x.dtsi                                     |    6=
=20
 arch/arm/boot/dts/bcm958625hr.dts                                  |    2=
=20
 arch/arm/boot/dts/dra71-evm.dts                                    |    4=
=20
 arch/arm/boot/dts/imx6dl-icore-rqs.dts                             |    2=
=20
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts                            |   52 =
+-
 arch/arm/boot/dts/r8a7791-porter.dts                               |    2=
=20
 arch/arm/boot/dts/rk3036.dtsi                                      |    4=
=20
 arch/arm/boot/dts/rk322x.dtsi                                      |    6=
=20
 arch/arm/boot/dts/rk3288.dtsi                                      |    2=
=20
 arch/arm/boot/dts/socfpga.dtsi                                     |    2=
=20
 arch/arm/include/asm/vdso.h                                        |    2=
=20
 arch/arm/kernel/vdso.c                                             |   12=
=20
 arch/arm/mach-davinci/board-omapl138-hawk.c                        |    4=
=20
 arch/arm/mach-omap1/clock.c                                        |    6=
=20
 arch/arm/mach-omap2/omap-wakeupgen.c                               |    4=
=20
 arch/arm/mach-omap2/pm.c                                           |    4=
=20
 arch/arm/mach-omap2/timer.c                                        |   19=
=20
 arch/arm/mach-orion5x/Kconfig                                      |    3=
=20
 arch/arm/mach-orion5x/dns323-setup.c                               |   53 =
++
 arch/arm/mach-orion5x/tsx09-common.c                               |   49 =
+-
 arch/arm/plat-omap/dmtimer.c                                       |    7=
=20
 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi                      |    3=
=20
 arch/arm64/boot/dts/qcom/msm8996.dtsi                              |    4=
=20
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts                     |    5=
=20
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                           |    6=
=20
 arch/arm64/boot/dts/rockchip/rk3368.dtsi                           |    2=
=20
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi                       |   16=
=20
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi                  |    2=
=20
 arch/arm64/include/asm/atomic_lse.h                                |   24 -
 arch/arm64/include/asm/stacktrace.h                                |    2=
=20
 arch/arm64/kernel/cpu_errata.c                                     |    4=
=20
 arch/arm64/kernel/perf_event.c                                     |    4=
=20
 arch/arm64/kernel/stacktrace.c                                     |    5=
=20
 arch/arm64/kernel/time.c                                           |    2=
=20
 arch/cris/include/arch-v10/arch/bug.h                              |   11=
=20
 arch/ia64/include/asm/bug.h                                        |    6=
=20
 arch/ia64/kernel/err_inject.c                                      |    2=
=20
 arch/m68k/coldfire/device.c                                        |   12=
=20
 arch/m68k/include/asm/bug.h                                        |    3=
=20
 arch/mips/cavium-octeon/octeon-irq.c                               |   10=
=20
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h                     |    2=
=20
 arch/mips/include/asm/machine.h                                    |    2=
=20
 arch/mips/kernel/ptrace.c                                          |   22=
=20
 arch/mips/kernel/ptrace32.c                                        |    4=
=20
 arch/mips/kvm/mips.c                                               |    2=
=20
 arch/mips/mm/c-r4k.c                                               |    9=
=20
 arch/powerpc/boot/Makefile                                         |    3=
=20
 arch/powerpc/include/asm/exception-64s.h                           |   29 +
 arch/powerpc/include/asm/feature-fixups.h                          |   19=
=20
 arch/powerpc/include/asm/hvcall.h                                  |    3=
=20
 arch/powerpc/include/asm/irq_work.h                                |    1=
=20
 arch/powerpc/include/asm/paca.h                                    |    3=
=20
 arch/powerpc/include/asm/security_features.h                       |   85 =
+++
 arch/powerpc/include/asm/setup.h                                   |    2=
=20
 arch/powerpc/kernel/Makefile                                       |    2=
=20
 arch/powerpc/kernel/asm-offsets.c                                  |    3=
=20
 arch/powerpc/kernel/cpu_setup_power.S                              |    6=
=20
 arch/powerpc/kernel/dt_cpu_ftrs.c                                  |    1=
=20
 arch/powerpc/kernel/exceptions-64s.S                               |   95 =
++--
 arch/powerpc/kernel/idle_book3s.S                                  |    2=
=20
 arch/powerpc/kernel/security.c                                     |  237 =
++++++++++
 arch/powerpc/kernel/setup_64.c                                     |   48 =
--
 arch/powerpc/kernel/traps.c                                        |   47 +
 arch/powerpc/kernel/vmlinux.lds.S                                  |   14=
=20
 arch/powerpc/lib/feature-fixups.c                                  |  124 =
+++++
 arch/powerpc/net/bpf_jit_comp.c                                    |    3=
=20
 arch/powerpc/perf/core-book3s.c                                    |   25 +
 arch/powerpc/platforms/powernv/npu-dma.c                           |  229 =
+++++----
 arch/powerpc/platforms/powernv/setup.c                             |   92 =
++-
 arch/powerpc/platforms/pseries/mobility.c                          |    3=
=20
 arch/powerpc/platforms/pseries/pseries.h                           |    2=
=20
 arch/powerpc/platforms/pseries/setup.c                             |   81 =
++-
 arch/powerpc/sysdev/mpic.c                                         |    2=
=20
 arch/powerpc/xmon/xmon.c                                           |    2=
=20
 arch/s390/kvm/vsie.c                                               |    2=
=20
 arch/sh/kernel/entry-common.S                                      |    2=
=20
 arch/sparc/include/asm/atomic_64.h                                 |    6=
=20
 arch/sparc/include/asm/bug.h                                       |    6=
=20
 arch/x86/events/core.c                                             |   15=
=20
 arch/x86/events/intel/core.c                                       |   12=
=20
 arch/x86/events/intel/ds.c                                         |  117 =
++++
 arch/x86/events/perf_event.h                                       |    2=
=20
 arch/x86/include/asm/alternative.h                                 |    4=
=20
 arch/x86/include/asm/tlbflush.h                                    |    7=
=20
 arch/x86/kernel/apic/apic.c                                        |    2=
=20
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c                           |    1=
=20
 arch/x86/kernel/devicetree.c                                       |   21=
=20
 arch/x86/kernel/smpboot.c                                          |    1=
=20
 arch/x86/kvm/cpuid.c                                               |    9=
=20
 arch/x86/kvm/lapic.c                                               |   26 -
 arch/x86/kvm/vmx.c                                                 |   27 -
 arch/x86/kvm/x86.c                                                 |    5=
=20
 arch/x86/mm/pageattr.c                                             |    6=
=20
 arch/x86/mm/pgtable.c                                              |    9=
=20
 block/partition-generic.c                                          |    6=
=20
 crypto/asymmetric_keys/pkcs7_trust.c                               |    1=
=20
 drivers/acpi/acpi_pad.c                                            |    3=
=20
 drivers/acpi/acpica/evevent.c                                      |    9=
=20
 drivers/acpi/acpica/nseval.c                                       |    8=
=20
 drivers/acpi/acpica/psargs.c                                       |    4=
=20
 drivers/ata/libata-core.c                                          |    6=
=20
 drivers/ata/libata-scsi.c                                          |    2=
=20
 drivers/base/regmap/regmap.c                                       |    2=
=20
 drivers/block/nbd.c                                                |    2=
=20
 drivers/block/null_blk.c                                           |   46 +
 drivers/block/paride/pcd.c                                         |    2=
=20
 drivers/block/xen-blkfront.c                                       |   17=
=20
 drivers/cdrom/cdrom.c                                              |    3=
=20
 drivers/cdrom/gdrom.c                                              |    3=
=20
 drivers/char/hw_random/stm32-rng.c                                 |    9=
=20
 drivers/char/ipmi/ipmi_ssif.c                                      |    4=
=20
 drivers/clocksource/fsl_ftm_timer.c                                |    2=
=20
 drivers/clocksource/mips-gic-timer.c                               |    2=
=20
 drivers/cpufreq/cppc_cpufreq.c                                     |   23=
=20
 drivers/cpufreq/cpufreq.c                                          |    6=
=20
 drivers/dma/mv_xor_v2.c                                            |   25 -
 drivers/dma/pl330.c                                                |    6=
=20
 drivers/dma/qcom/bam_dma.c                                         |   27 -
 drivers/dma/sh/rcar-dmac.c                                         |   11=
=20
 drivers/firmware/dmi_scan.c                                        |    2=
=20
 drivers/firmware/efi/arm-runtime.c                                 |    3=
=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                         |    1=
=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c                             |   33 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                              |    8=
=20
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                              |    5=
=20
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c                    |    3=
=20
 drivers/gpu/drm/ast/ast_tables.h                                   |    4=
=20
 drivers/gpu/drm/bridge/sii902x.c                                   |   20=
=20
 drivers/gpu/drm/exynos/exynos_drm_g2d.c                            |    6=
=20
 drivers/gpu/drm/exynos/regs-fimc.h                                 |    2=
=20
 drivers/gpu/drm/imx/ipuv3-crtc.c                                   |    5=
=20
 drivers/gpu/drm/meson/meson_crtc.c                                 |    6=
=20
 drivers/gpu/drm/meson/meson_drv.c                                  |   29 -
 drivers/gpu/drm/meson/meson_drv.h                                  |    3=
=20
 drivers/gpu/drm/meson/meson_plane.c                                |    7=
=20
 drivers/gpu/drm/nouveau/nouveau_backlight.c                        |   10=
=20
 drivers/gpu/drm/omapdrm/dss/dss.c                                  |  193 =
++++----
 drivers/gpu/drm/panel/panel-simple.c                               |    2=
=20
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c                          |   18=
=20
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                        |    7=
=20
 drivers/gpu/drm/sun4i/sun4i_dotclock.c                             |    5=
=20
 drivers/gpu/drm/tegra/drm.c                                        |    1=
=20
 drivers/gpu/drm/virtio/virtgpu_ioctl.c                             |   17=
=20
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.h                                |   25 -
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c                               |   31 -
 drivers/gpu/ipu-v3/ipu-pre.c                                       |    3=
=20
 drivers/gpu/ipu-v3/ipu-prg.c                                       |   15=
=20
 drivers/hwmon/nct6775.c                                            |   10=
=20
 drivers/hwmon/pmbus/adm1275.c                                      |    4=
=20
 drivers/hwmon/pmbus/max8688.c                                      |    2=
=20
 drivers/hwtracing/coresight/coresight-cpu-debug.c                  |    2=
=20
 drivers/hwtracing/intel_th/core.c                                  |    2=
=20
 drivers/i2c/busses/i2c-mv64xxx.c                                   |    8=
=20
 drivers/ide/ide-cd.c                                               |    2=
=20
 drivers/infiniband/core/multicast.c                                |   26 -
 drivers/infiniband/core/rdma_core.c                                |    5=
=20
 drivers/infiniband/core/sa_query.c                                 |    7=
=20
 drivers/infiniband/core/ucma.c                                     |    2=
=20
 drivers/infiniband/core/umem.c                                     |    7=
=20
 drivers/infiniband/core/uverbs_ioctl.c                             |    3=
=20
 drivers/infiniband/core/uverbs_ioctl_merge.c                       |   18=
=20
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                           |   24 -
 drivers/infiniband/hw/bnxt_re/main.c                               |   10=
=20
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                         |    6=
=20
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h                         |    1=
=20
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                           |    3=
=20
 drivers/infiniband/hw/bnxt_re/roce_hsi.h                           |   25 +
 drivers/infiniband/hw/hfi1/chip.c                                  |    4=
=20
 drivers/infiniband/hw/mlx4/cq.c                                    |    4=
=20
 drivers/infiniband/hw/mlx4/main.c                                  |   11=
=20
 drivers/infiniband/hw/mlx5/cq.c                                    |    3=
=20
 drivers/infiniband/hw/mlx5/main.c                                  |    3=
=20
 drivers/infiniband/hw/mlx5/qp.c                                    |    4=
=20
 drivers/infiniband/hw/qedr/main.c                                  |    3=
=20
 drivers/infiniband/hw/qedr/verbs.c                                 |   58 =
+-
 drivers/infiniband/sw/rxe/rxe_verbs.c                              |    2=
=20
 drivers/iommu/amd_iommu.c                                          |    2=
=20
 drivers/iommu/mtk_iommu.c                                          |   15=
=20
 drivers/iommu/mtk_iommu.h                                          |    1=
=20
 drivers/macintosh/rack-meter.c                                     |    4=
=20
 drivers/md/bcache/request.c                                        |    2=
=20
 drivers/md/bcache/writeback.c                                      |   20=
=20
 drivers/md/md.c                                                    |   49 =
+-
 drivers/md/md.h                                                    |    2=
=20
 drivers/md/raid1.c                                                 |   11=
=20
 drivers/md/raid10.c                                                |   14=
=20
 drivers/md/raid5.c                                                 |   15=
=20
 drivers/misc/cxl/cxl.h                                             |    4=
=20
 drivers/misc/cxl/native.c                                          |   11=
=20
 drivers/misc/cxl/pci.c                                             |   19=
=20
 drivers/mmc/host/sdhci-iproc.c                                     |   33 +
 drivers/net/bonding/bond_main.c                                    |    6=
=20
 drivers/net/can/m_can/m_can.c                                      |    7=
=20
 drivers/net/dsa/Makefile                                           |    5=
=20
 drivers/net/dsa/mt7530.c                                           |    1=
=20
 drivers/net/ethernet/broadcom/bgmac.c                              |    3=
=20
 drivers/net/ethernet/broadcom/bgmac.h                              |    6=
=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                          |    3=
=20
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c                    |   12=
=20
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c                     |    1=
=20
 drivers/net/ethernet/cisco/enic/enic_main.c                        |   10=
=20
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                     |   23=
=20
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c                 |    2=
=20
 drivers/net/ethernet/freescale/fman/fman_dtsec.c                   |    2=
=20
 drivers/net/ethernet/freescale/gianfar.c                           |    7=
=20
 drivers/net/ethernet/ibm/ibmvnic.c                                 |   42 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c                        |    2=
=20
 drivers/net/ethernet/intel/e1000e/mac.c                            |    2=
=20
 drivers/net/ethernet/intel/e1000e/netdev.c                         |    4=
=20
 drivers/net/ethernet/intel/i40e/i40e_main.c                        |   11=
=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                      |    3=
=20
 drivers/net/ethernet/marvell/mvneta.c                              |    1=
=20
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig                    |    2=
=20
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                      |    2=
=20
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                  |    4=
=20
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                   |    2=
=20
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                    |    3=
=20
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h           |   20=
=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c                     |    8=
=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h                     |    1=
=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c                 |    2=
=20
 drivers/net/ethernet/qlogic/qed/qed_cxt.c                          |    5=
=20
 drivers/net/ethernet/qlogic/qed/qed_rdma.c                         |    1=
=20
 drivers/net/ethernet/qlogic/qede/qede_fp.c                         |   20=
=20
 drivers/net/ethernet/qualcomm/emac/emac-mac.c                      |   23=
=20
 drivers/net/ethernet/renesas/sh_eth.c                              |    6=
=20
 drivers/net/ethernet/renesas/sh_eth.h                              |    1=
=20
 drivers/net/ethernet/smsc/smsc911x.c                               |    4=
=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                  |   16=
=20
 drivers/net/ethernet/sun/sunvnet.c                                 |    2=
=20
 drivers/net/hyperv/netvsc.c                                        |    2=
=20
 drivers/net/hyperv/netvsc_drv.c                                    |   51 =
+-
 drivers/net/hyperv/rndis_filter.c                                  |   20=
=20
 drivers/net/ieee802154/ca8210.c                                    |   14=
=20
 drivers/net/macvlan.c                                              |    2=
=20
 drivers/net/phy/dp83640.c                                          |   18=
=20
 drivers/net/usb/lan78xx.c                                          |   44 +
 drivers/net/usb/qmi_wwan.c                                         |    1=
=20
 drivers/net/usb/r8152.c                                            |    2=
=20
 drivers/net/usb/smsc75xx.c                                         |    7=
=20
 drivers/net/virtio_net.c                                           |    4=
=20
 drivers/net/wireless/ath/ath10k/mac.c                              |   12=
=20
 drivers/net/wireless/ath/ath9k/common-spectral.c                   |   12=
=20
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c        |    2=
=20
 drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h             |    4=
=20
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                        |   13=
=20
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h                        |    3=
=20
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h                    |    3=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c                   |    5=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c                  |    3=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                  |   54 =
+-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                       |    3=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                       |    8=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c                        |   28 -
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                      |   39 -
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c                       |  107 =
++--
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c                |   21=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                        |   23=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c                     |   11=
=20
 drivers/net/wireless/rsi/rsi_91x_sdio.c                            |   32 -
 drivers/net/wireless/rsi/rsi_sdio.h                                |    2=
=20
 drivers/nvme/host/fabrics.c                                        |    4=
=20
 drivers/nvme/host/pci.c                                            |   27 -
 drivers/nvme/target/core.c                                         |    9=
=20
 drivers/parisc/lba_pci.c                                           |   20=
=20
 drivers/pci/pci-driver.c                                           |   17=
=20
 drivers/pci/quirks.c                                               |    3=
=20
 drivers/pcmcia/cs.c                                                |   10=
=20
 drivers/pcmcia/cs_internal.h                                       |    1=
=20
 drivers/phy/qualcomm/phy-qcom-qmp.c                                |    4=
=20
 drivers/phy/rockchip/phy-rockchip-emmc.c                           |   27 -
 drivers/pinctrl/devicetree.c                                       |    6=
=20
 drivers/pinctrl/pinctrl-mcp23s08.c                                 |   37 +
 drivers/pinctrl/qcom/pinctrl-msm.c                                 |    2=
=20
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c                               |   40 -
 drivers/power/supply/ltc2941-battery-gauge.c                       |    8=
=20
 drivers/power/supply/max17042_battery.c                            |    1=
=20
 drivers/regulator/gpio-regulator.c                                 |   16=
=20
 drivers/regulator/of_regulator.c                                   |    1=
=20
 drivers/remoteproc/imx_rproc.c                                     |    6=
=20
 drivers/s390/block/dasd.c                                          |   21=
=20
 drivers/s390/cio/device_fsm.c                                      |    7=
=20
 drivers/s390/cio/device_ops.c                                      |   72 =
+--
 drivers/s390/cio/io_sch.h                                          |    1=
=20
 drivers/s390/cio/vfio_ccw_fsm.c                                    |    5=
=20
 drivers/scsi/sr.c                                                  |   21=
=20
 drivers/scsi/sr_ioctl.c                                            |   10=
=20
 drivers/soc/imx/gpc.c                                              |   10=
=20
 drivers/soc/qcom/wcnss_ctrl.c                                      |    2=
=20
 drivers/spi/spi-bcm-qspi.c                                         |    4=
=20
 drivers/usb/host/pci-quirks.c                                      |  109 =
++++
 drivers/usb/host/pci-quirks.h                                      |    5=
=20
 drivers/usb/host/xhci-hub.c                                        |    7=
=20
 drivers/usb/host/xhci-pci.c                                        |   11=
=20
 drivers/usb/host/xhci.h                                            |    2=
=20
 drivers/video/fbdev/sbuslib.c                                      |    4=
=20
 drivers/watchdog/asm9260_wdt.c                                     |    8=
=20
 drivers/watchdog/aspeed_wdt.c                                      |   13=
=20
 drivers/watchdog/davinci_wdt.c                                     |   15=
=20
 drivers/watchdog/dw_wdt.c                                          |   23=
=20
 drivers/watchdog/f71808e_wdt.c                                     |    3=
=20
 drivers/watchdog/sbsa_gwdt.c                                       |    3=
=20
 drivers/xen/events/events_base.c                                   |    4=
=20
 drivers/xen/pvcalls-back.c                                         |    2=
=20
 drivers/xen/swiotlb-xen.c                                          |    2=
=20
 drivers/xen/xen-acpi-processor.c                                   |    6=
=20
 drivers/xen/xenbus/xenbus_probe.c                                  |    5=
=20
 drivers/zorro/zorro.c                                              |   12=
=20
 fs/affs/namei.c                                                    |   10=
=20
 fs/aio.c                                                           |    4=
=20
 fs/btrfs/ctree.h                                                   |    2=
=20
 fs/btrfs/disk-io.c                                                 |    5=
=20
 fs/btrfs/extent-tree.c                                             |    1=
=20
 fs/btrfs/inode.c                                                   |   16=
=20
 fs/btrfs/send.c                                                    |    3=
=20
 fs/btrfs/super.c                                                   |    2=
=20
 fs/btrfs/tests/qgroup-tests.c                                      |    2=
=20
 fs/btrfs/transaction.c                                             |   10=
=20
 fs/btrfs/tree-log.c                                                |   77 =
++-
 fs/ceph/super.c                                                    |   27 -
 fs/dcache.c                                                        |   32 +
 fs/ecryptfs/inode.c                                                |    3=
=20
 fs/ext2/namei.c                                                    |    6=
=20
 fs/ext4/namei.c                                                    |    6=
=20
 fs/ext4/super.c                                                    |   12=
=20
 fs/f2fs/checkpoint.c                                               |    2=
=20
 fs/f2fs/extent_cache.c                                             |    3=
=20
 fs/f2fs/file.c                                                     |    8=
=20
 fs/f2fs/namei.c                                                    |   12=
=20
 fs/fscache/page.c                                                  |   13=
=20
 fs/gfs2/file.c                                                     |    5=
=20
 fs/gfs2/quota.h                                                    |    2=
=20
 fs/jffs2/dir.c                                                     |   12=
=20
 fs/jfs/namei.c                                                     |   12=
=20
 fs/nfs/nfs4client.c                                                |    6=
=20
 fs/nilfs2/namei.c                                                  |    6=
=20
 fs/ocfs2/dlm/dlmdomain.c                                           |   14=
=20
 fs/ocfs2/dlm/dlmdomain.h                                           |   25 +
 fs/ocfs2/dlm/dlmrecovery.c                                         |    9=
=20
 fs/orangefs/namei.c                                                |    9=
=20
 fs/proc/proc_sysctl.c                                              |    3=
=20
 fs/reiserfs/namei.c                                                |   12=
=20
 fs/super.c                                                         |   30 +
 fs/udf/namei.c                                                     |    6=
=20
 fs/udf/super.c                                                     |    5=
=20
 fs/ufs/namei.c                                                     |    6=
=20
 fs/xfs/xfs_discard.c                                               |   14=
=20
 include/asm-generic/bug.h                                          |    1=
=20
 include/linux/bio.h                                                |    4=
=20
 include/linux/compiler-gcc.h                                       |   15=
=20
 include/linux/compiler.h                                           |    5=
=20
 include/linux/dcache.h                                             |    1=
=20
 include/linux/if_vlan.h                                            |   79 =
++-
 include/linux/kvm_host.h                                           |    3=
=20
 include/linux/ptr_ring.h                                           |    2=
=20
 include/net/ip.h                                                   |   11=
=20
 include/net/ip_fib.h                                               |    1=
=20
 include/net/llc_conn.h                                             |    2=
=20
 include/net/mac80211.h                                             |    2=
=20
 include/net/regulatory.h                                           |    2=
=20
 include/net/route.h                                                |    3=
=20
 include/rdma/ib_umem.h                                             |    1=
=20
 include/soc/arc/mcip.h                                             |    5=
=20
 include/uapi/drm/virtgpu_drm.h                                     |    1=
=20
 include/uapi/linux/if_ether.h                                      |    1=
=20
 ipc/shm.c                                                          |   19=
=20
 kernel/audit.c                                                     |    2=
=20
 kernel/debug/kdb/kdb_main.c                                        |   27 -
 kernel/events/core.c                                               |   70 =
++
 kernel/rcu/tree_plugin.h                                           |   14=
=20
 kernel/relay.c                                                     |    2=
=20
 kernel/sched/rt.c                                                  |    2=
=20
 kernel/sys.c                                                       |    2=
=20
 kernel/workqueue.c                                                 |    2=
=20
 lib/radix-tree.c                                                   |    4=
=20
 lib/test_kmod.c                                                    |    2=
=20
 mm/huge_memory.c                                                   |    5=
=20
 mm/kasan/kasan.c                                                   |   66 =
++
 mm/khugepaged.c                                                    |    8=
=20
 mm/kmemleak.c                                                      |   12=
=20
 mm/ksm.c                                                           |   28 +
 mm/mempolicy.c                                                     |    3=
=20
 mm/page_idle.c                                                     |   12=
=20
 mm/page_owner.c                                                    |    6=
=20
 mm/slab.c                                                          |    1=
=20
 mm/swapfile.c                                                      |    4=
=20
 mm/vmscan.c                                                        |    8=
=20
 mm/vmstat.c                                                        |    2=
=20
 mm/z3fold.c                                                        |    9=
=20
 net/8021q/vlan_core.c                                              |    4=
=20
 net/batman-adv/bat_iv_ogm.c                                        |    2=
=20
 net/batman-adv/bat_v.c                                             |    2=
=20
 net/batman-adv/bridge_loop_avoidance.c                             |   22=
=20
 net/batman-adv/distributed-arp-table.c                             |    2=
=20
 net/batman-adv/fragmentation.c                                     |    3=
=20
 net/batman-adv/gateway_client.c                                    |    5=
=20
 net/batman-adv/multicast.c                                         |    8=
=20
 net/batman-adv/routing.c                                           |   15=
=20
 net/batman-adv/soft-interface.c                                    |    8=
=20
 net/bridge/netfilter/ebtables.c                                    |   33 -
 net/ceph/ceph_common.c                                             |    7=
=20
 net/core/ethtool.c                                                 |    5=
=20
 net/core/skbuff.c                                                  |    9=
=20
 net/ipv4/ip_gre.c                                                  |    5=
=20
 net/ipv4/ip_tunnel.c                                               |    8=
=20
 net/ipv4/ip_vti.c                                                  |    2=
=20
 net/ipv4/netfilter/ipt_CLUSTERIP.c                                 |   15=
=20
 net/ipv4/route.c                                                   |   26 -
 net/ipv4/tcp_illinois.c                                            |    2=
=20
 net/ipv4/xfrm4_policy.c                                            |    1=
=20
 net/ipv6/ip6_tunnel.c                                              |   12=
=20
 net/ipv6/ip6_vti.c                                                 |    2=
=20
 net/ipv6/sit.c                                                     |    7=
=20
 net/llc/llc_c_ac.c                                                 |   15=
=20
 net/llc/llc_conn.c                                                 |   32 -
 net/mac80211/agg-rx.c                                              |    4=
=20
 net/mac80211/ieee80211_i.h                                         |    2=
=20
 net/mac80211/mesh.c                                                |   17=
=20
 net/mac80211/rx.c                                                  |    2=
=20
 net/mac80211/spectmgmt.c                                           |    7=
=20
 net/mac80211/sta_info.c                                            |    3=
=20
 net/netfilter/ipvs/ip_vs_ftp.c                                     |    2=
=20
 net/netlabel/netlabel_unlabeled.c                                  |   10=
=20
 net/nfc/llcp_commands.c                                            |    4=
=20
 net/nfc/netlink.c                                                  |    3=
=20
 net/qrtr/smd.c                                                     |    1=
=20
 net/rds/tcp_listen.c                                               |   14=
=20
 net/rxrpc/input.c                                                  |   15=
=20
 net/rxrpc/recvmsg.c                                                |    5=
=20
 net/rxrpc/sendmsg.c                                                |    4=
=20
 net/sched/act_bpf.c                                                |    2=
=20
 net/sched/act_ipt.c                                                |    9=
=20
 net/sched/act_pedit.c                                              |    2=
=20
 net/sched/act_police.c                                             |    2=
=20
 net/sched/act_sample.c                                             |    3=
=20
 net/sched/act_simple.c                                             |    2=
=20
 net/sched/act_skbmod.c                                             |    2=
=20
 net/smc/smc_core.c                                                 |    1=
=20
 net/smc/smc_ib.c                                                   |   10=
=20
 net/smc/smc_llc.c                                                  |    2=
=20
 net/smc/smc_wr.h                                                   |    1=
=20
 net/tls/tls_main.c                                                 |    3=
=20
 net/wireless/sme.c                                                 |    2=
=20
 net/xfrm/xfrm_input.c                                              |    6=
=20
 net/xfrm/xfrm_output.c                                             |    5=
=20
 net/xfrm/xfrm_policy.c                                             |    7=
=20
 net/xfrm/xfrm_replay.c                                             |    2=
=20
 scripts/adjust_autoksyms.sh                                        |    7=
=20
 scripts/package/builddeb                                           |    2=
=20
 security/integrity/digsig.c                                        |    1=
=20
 security/integrity/ima/Kconfig                                     |    1=
=20
 security/integrity/ima/ima_crypto.c                                |    2=
=20
 security/integrity/ima/ima_main.c                                  |   13=
=20
 sound/core/timer.c                                                 |    4=
=20
 sound/core/vmaster.c                                               |    5=
=20
 tools/hv/hv_fcopy_daemon.c                                         |    3=
=20
 tools/hv/hv_vss_daemon.c                                           |    1=
=20
 tools/perf/Makefile.perf                                           |    3=
=20
 tools/perf/builtin-record.c                                        |    9=
=20
 tools/perf/builtin-stat.c                                          |    9=
=20
 tools/perf/builtin-top.c                                           |    6=
=20
 tools/perf/perf.h                                                  |    1=
=20
 tools/perf/tests/dwarf-unwind.c                                    |   46 +
 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh               |    6=
=20
 tools/perf/tests/vmlinux-kallsyms.c                                |    2=
=20
 tools/perf/ui/browsers/annotate.c                                  |    9=
=20
 tools/perf/util/c++/clang.cpp                                      |   11=
=20
 tools/perf/util/hist.c                                             |    4=
=20
 tools/perf/util/hist.h                                             |    1=
=20
 tools/perf/util/record.c                                           |    8=
=20
 tools/testing/radix-tree/idr-test.c                                |    7=
=20
 tools/testing/selftests/Makefile                                   |    1=
=20
 tools/testing/selftests/bpf/test_maps.c                            |    2=
=20
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc |   46 +
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc |   97 =
++++
 tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc         |   43 +
 tools/testing/selftests/futex/Makefile                             |    6=
=20
 tools/testing/selftests/memfd/Makefile                             |    1=
=20
 tools/testing/selftests/memfd/config                               |    1=
=20
 tools/testing/selftests/net/psock_fanout.c                         |    3=
=20
 tools/testing/selftests/powerpc/mm/subpage_prot.c                  |   14=
=20
 tools/testing/selftests/pstore/config                              |    1=
=20
 tools/testing/selftests/seccomp/seccomp_bpf.c                      |   61 =
++
 tools/testing/selftests/sync/Makefile                              |    2=
=20
 tools/testing/selftests/vDSO/Makefile                              |   14=
=20
 tools/testing/selftests/vm/run_vmtests                             |   25 -
 tools/thermal/tmon/sysfs.c                                         |   12=
=20
 tools/thermal/tmon/tmon.c                                          |    1=
=20
 virt/kvm/arm/vgic/vgic-mmio.c                                      |    3=
=20
 virt/kvm/arm/vgic/vgic.h                                           |    1=
=20
 502 files changed, 4726 insertions(+), 1694 deletions(-)

Aapo Vienamo (1):
      ARM: dts: imx7d: cl-som-imx7: fix pinctrl_enet

Aaro Koskinen (1):
      drivers: macintosh: rack-meter: really fix bogus memsets

Al Viro (3):
      affs_lookup(): close a race with affs_remove_link()
      aio: fix io_destroy(2) vs. lookup_ioctx() race
      do d_instantiate/unlock_new_inode combinations safely

Alexander Graf (1):
      lan78xx: Connect phy early

Alexander Shishkin (1):
      intel_th: Use correct method of finding hub

Alexey Dobriyan (1):
      x86/alternatives: Fixup alternative_call_2

Alexey Khoroshilov (2):
      watchdog: davinci_wdt: fix error handling in davinci_wdt_probe()
      watchdog: asm9260_wdt: fix error handling in asm9260_wdt_probe()

Alexey Kodanev (1):
      macvlan: fix use-after-free in macvlan_common_newlink()

Alistair Popple (1):
      powerpc/powernv/npu: Fix deadlock in mmio_invalidate()

Amitkumar Karwar (1):
      rsi: fix kernel panic observed on 64bit machine

Anders Roxell (3):
      selftests: sync: missing CFLAGS while compiling
      selftests: memfd: add config fragment for fuse
      selftests/memfd: add run_fuse_test.sh to TEST_FILES

Andre Przywara (1):
      KVM: arm/arm64: vgic: Add missing irq_lock to vgic_mmio_read_pending

Andrea Parri (2):
      locking/xchg/alpha: Add unconditional memory barrier to cmpxchg()
      locking/xchg/alpha: Fix xchg() and cmpxchg() memory ordering bugs

Andreas Gruenbacher (1):
      gfs2: Fix fallocate chunk size

Andrei Otcheretianski (2):
      iwlwifi: mvm: Fix channel switch for count 0 and 1
      iwlwifi: mvm: Increase session protection time after CS

Andrey Ryabinin (1):
      mm/kasan: don't vfree() nonexistent vm_area

Anilkumar Kolli (1):
      ath10k: advertize beacon_int_min_gcd

Anshuman Khandual (1):
      powerpc/fscr: Enable interrupts earlier before calling get_user()

Arjun Vynipadath (2):
      cxgb4: Setup FW queues before registering netdev
      cxgb4: Fix queue free path of ULD drivers

Arnd Bergmann (4):
      drm/exynos: g2d: use monotonic timestamps
      md: raid5: avoid string overflow warning
      bug.h: work around GCC PR82365 in BUG()
      gpu: ipu-v3: prg: avoid possible array underflow

Arvind Yadav (2):
      xen: xenbus: use put_device() instead of kfree()
      workqueue: use put_device() instead of kfree()

Avraham Stern (4):
      cfg80211: clear wep keys after disconnection
      iwlwifi: mvm: clear tx queue id when unreserving aggregation queue
      iwlwifi: mvm: make sure internal station has a valid id
      iwlwifi: mvm: fix array out of bounds reference

Baoquan He (1):
      x86/apic: Set up through-local-APIC mode on the boot CPU if 'noapic' =
specified

Bartosz Golaszewski (1):
      ARM: davinci: fix the GPIO lookup for omapl138-hawk

Ben Hutchings (1):
      ALSA: timer: Fix pause event notification

Beni Lev (1):
      iwlwifi: mvm: Correctly set IGTK for AP

Benjamin Poirier (1):
      e1000e: Fix check_for_link return value with autoneg off

Bhavesh Davda (1):
      xen-blkfront: move negotiate_mq to cover all cases of new VBDs

Bich HEMON (1):
      can: m_can: select pinctrl state in each suspend/resume function

Bill.Baker@oracle.com (1):
      nfs: system crashes after NFS4ERR_MOVED recovery

BingJing Chang (1):
      md: fix a potential deadlock of raid5/raid10 reshape

Bjorn Andersson (2):
      soc: qcom: wcnss_ctrl: Fix increment in NV upload
      pinctrl: msm: Use dynamic GPIO numbering

Bob Moore (1):
      ACPICA: Fix memory leak on unusual memory leak

Boris Pismenny (1):
      tls: retrun the correct IV in getsockopt

Brian Norris (1):
      watchdog: dw: RMW the control register

Carlos Maiolino (1):
      Force log to disk before reading the AGF during a fstrim

Cathy Zhou (1):
      sunvnet: does not support GSO for sctp

Chao Gao (1):
      KVM: nVMX: Don't halt vcpu when L1 is injecting events to L2

Chao Yu (3):
      f2fs: fix to set KEEP_SIZE bit in f2fs_zero_range
      f2fs: fix to clear CP_TRIMMED_FLAG
      f2fs: fix to check extent cache in f2fs_drop_extent_tree

Charles Keepax (1):
      regmap: Correct comparison in regmap_cached

Chengguang Xu (3):
      libceph, ceph: avoid memory leak when specifying same option several =
times
      ceph: fix dentry leak when failing to init debugfs
      ceph: fix potential memory leak in init_caches()

Chien Tin Tung (1):
      RDMA/ucma: Correct option size check using optlen

Christophe JAILLET (4):
      remoteproc: imx_rproc: Fix an error handling path in 'imx_rproc_probe=
()'
      drm/meson: Fix some error handling paths in 'meson_drv_bind_master()'
      drm/meson: Fix an un-handled error path in 'meson_drv_bind_master()'
      regulator: of: Add a missing 'of_node_put()' in an error handling pat=
h of 'of_regulator_match()'

Christophe Jaillet (2):
      regulator: gpio: Fix some error handling paths in 'gpio_regulator_pro=
be()'
      spi: bcm-qspi: fIX some error handling paths

Chunyu Hu (1):
      cpufreq: cppc_cpufreq: Fix cppc_cpufreq_init() failure path

Claudio Imbrenda (1):
      mm/ksm: fix interaction with THP

Claudiu Manoil (1):
      gianfar: Fix Rx byte accounting for ndev stats

Colin Ian King (3):
      KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"
      clocksource/drivers/fsl_ftm_timer: Fix error return checking
      xen/pvcalls: fix null pointer dereference on map->sock

Coly Li (1):
      bcache: quit dc->writeback_thread when BCACHE_DEV_DETACHING is set

Cong Wang (1):
      llc: properly handle dev_queue_xmit() return value

Cornelia Huck (1):
      vfio-ccw: fence off transport mode

Corneliu Doban (2):
      mmc: sdhci-iproc: fix 32bit writes for TRANSFER_MODE register
      mmc: sdhci-iproc: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for cygnus

Dan Carpenter (2):
      IB/mlx5: Fix an error code in __mlx5_ib_modify_qp()
      xen/acpi: off by one in read_acpi_id()

Daniel D=C3=ADaz (1):
      selftests/futex: Fix line continuation in Makefile

Danilo Krummrich (1):
      fs/proc/proc_sysctl.c: fix potential page fault while unregistering s=
ysctl table

Dave Airlie (1):
      virtio-gpu: fix ioctl and expose the fixed status to userspace.

Dave Chinner (1):
      fs: don't scan the inode cache before SB_BORN is set

Dave Hansen (1):
      x86/mm: Do not forbid _PAGE_RW before init for __ro_after_init

David Hildenbrand (3):
      kasan: free allocated shadow memory on MEM_CANCEL_ONLINE
      kasan: fix memory hotplug during boot
      KVM: s390: vsie: fix < 8k check for the itdba

David Howells (4):
      rxrpc: Work around usercopy check
      fscache: Fix hanging wait on page discarded by writeback
      rxrpc: Fix Tx ring annotation after initial Tx failure
      rxrpc: Don't treat call aborts as conn aborts

David Rientjes (2):
      kernel/relay.c: limit kmalloc size to KMALLOC_MAX_SIZE
      mm, thp: do not cause memcg oom for thp

David S. Miller (2):
      ARM: orion5x: Revert commit 4904dbda41c8.
      sparc64: Make atomic_xchg() an inline function rather than a macro.

David Vrabel (1):
      x86/kvm: fix LAPIC timer drift when guest uses periodic mode

Davide Caratti (7):
      net/sched: fix NULL dereference in the error path of tcf_sample_init()
      net/sched: fix idr leak on the error path of tcf_bpf_init()
      net/sched: fix idr leak in the error path of tcf_simp_init()
      net/sched: fix idr leak in the error path of tcf_act_police_init()
      net/sched: fix idr leak in the error path of tcp_pedit_init()
      net/sched: fix idr leak in the error path of __tcf_ipt_init()
      net/sched: fix idr leak in the error path of tcf_skbmod_init()

Davidlohr Bueso (4):
      Revert "ipc/shm: Fix shmat mmap nil-page protection"
      ipc/shm: fix shmat() nil address after round-down when remapping
      ia64/err-inject: Use get_user_pages_fast()
      sched/rt: Fix rq->clock_update_flags < RQCF_ACT_SKIP warning

Deepak Rawat (1):
      drm/vmwgfx: Set dmabuf_size when vmw_dmabuf_init is successful

Denis Kirjanov (1):
      fsl/fman: avoid sleeping in atomic context while adding an address

Devesh Sharma (3):
      RDMA/bnxt_re: Unpin SQ and RQ memory if QP create fails
      RDMA/bnxt_re: Unconditionly fence non wire memory operations
      RDMA/bnxt_re: Fix incorrect DB offset calculation

Dexuan Cui (1):
      tools: hv: fix compiler warnings about major/target_fname

Dominik Brodowski (1):
      selftest/vDSO: fix O=3D

Dong Bo (1):
      libata: Fix compile warning with ATA_DEBUG enabled

Douglas Anderson (1):
      arm64: dts: rockchip: Fix rk3399-gru-* s2r (pinctrl hogs, wifi reset)

Edward Cree (1):
      net: ethtool: don't ignore return from driver get_fecparam method

Emmanuel Grumbach (1):
      iwlwifi: mvm: set the correct tid when we flush the MCAST sta

Eric Anholt (1):
      drm/panel: simple: Fix the bus format for the Ontat panel

Eric Biggers (1):
      PKCS#7: fix direct verification of SignerInfo signature

Eric Dumazet (2):
      smsc75xx: fix smsc75xx_set_features()
      r8152: fix tx packets accounting

Eric Sandeen (1):
      ext4: don't complain about incorrect features when probing

Erik Schmauss (1):
      ACPICA: Events: add a return on failure from acpi_hw_register_read

Esben Haabendal (1):
      dp83640: Ensure against premature access to PHY registers after reset

Eugeniy Paltsev (3):
      ARC: mcip: halt GFRC counter when ARC cores halt
      ARC: mcip: update MCIP debug mask when the new cpu came online
      ARC: setup cpu possible mask according to possible-cpus dts property

Felix Fietkau (3):
      mac80211: round IEEE80211_TX_STATUS_HEADROOM up to multiple of 4
      mac80211: drop frames with unexpected DS bits from fast-rx to slow pa=
th
      clocksource/drivers/mips-gic-timer: Use correct shift count to extrac=
t data

Felix Kuehling (1):
      drm/amdkfd: Fix scratch memory with HWS enabled

Filip Sadowski (1):
      i40e: Add delay after EMP reset for firmware to recover

Filipe Manana (4):
      Btrfs: send, fix issuing write op when processing hole in no data mode
      Btrfs: fix log replay failure after linking special file and fsync
      Btrfs: fix loss of prealloc extents past i_size after fsync log replay
      Btrfs: fix copy_items() return value when logging an inode

Florian Fainelli (4):
      ARM: dts: NSP: Fix amount of RAM on BCM958625HR
      net: dsa: Fix functional dsa-loop dependency on FIXED_PHY
      net: bgmac: Fix endian access in bgmac_dma_tx_ring_free()
      net: bgmac: Correctly annotate register space

Florian Westphal (4):
      netfilter: ipt_CLUSTERIP: put config struct if we can't increment ct =
refcount
      netfilter: ipt_CLUSTERIP: put config instead of freeing it
      netfilter: ebtables: convert BUG_ONs to WARN_ONs
      netfilter: ebtables: fix erroneous reject of last rule

Frank Asseg (1):
      tools/thermal: tmon: fix for segfault

Ganesh Goudar (1):
      cxgb4: do not set needs_free_netdev for mgmt dev's

Geert Uytterhoeven (1):
      ARM: OMAP1: clock: Fix debugfs_create_*() usage

Giulio Benetti (1):
      drm/sun4i: Fix dclk_set_phase

Govindarajulu Varadarajan (1):
      enic: enable rq before updating rq descriptors

Greg Kroah-Hartman (1):
      Linux 4.14.45

Greg Ungerer (1):
      m68k: set dma and coherent masks for platform FEC ethernets

Gregory CLEMENT (2):
      dmaengine: mv_xor_v2: Fix clock resource by adding a register clock
      i2c: mv64xxx: Apply errata delay only in standard mode

Guenter Roeck (4):
      powerpc/boot: Fix random libfdt related build errors
      hwmon: (nct6775) Fix writing pwmX_mode
      hwmon: (pmbus/max8688) Accept negative page register values
      hwmon: (pmbus/adm1275) Accept negative page register values

Gustavo A. R. Silva (2):
      kernel/sys.c: fix potential Spectre v1 issue
      nbd: fix return value in error handling path

Harry Morris (1):
      ieee802154: ca8210: fix uninitialised data read

Heinz Mauelshagen (1):
      md: fix md_write_start() deadlock w/o metadata devices

Helge Deller (1):
      parisc/pci: Switch LBA PCI bus from Hard Fail to Soft Fail mode

Hemanth Puranik (1):
      net: qcom/emac: Use proper free methods during TX

Henry Zhang (1):
      ARM: dts: bcm283x: Fix pin function of JTAG pins

Honggang Li (1):
      IB/mlx5: Set the default active rate and width to QDR and 4X

Huang Ying (1):
      mm: fix races between address_space dereference and free in page_evic=
atable

Icenowy Zheng (1):
      dt-bindings: add device tree binding for Allwinner H6 main CCU

Ido Schimmel (2):
      mlxsw: spectrum: Treat IPv6 unregistered multicast as broadcast
      spectrum: Reference count VLAN entries

Igor Pylypiv (1):
      watchdog: f71808e_wdt: Fix magic close handling

Ilan Peer (4):
      mac80211: Do not disconnect on invalid operating class
      mac80211: Fix sending ADDBA response for an ongoing session
      iwlwifi: mvm: Direct multicast frames to the correct station
      iwlwifi: mvm: Correctly set the tid for mcast queue

Ilia Lin (1):
      arm64: dts: qcom: Fix SPI5 config on MSM8996

Ivan Gorinov (2):
      x86/devicetree: Initialize device tree before using it
      x86/devicetree: Fix device IRQ settings in DT

Jack M (1):
      IB/mlx4: Include GID type when deleting GIDs from HW table under RoCE

Jack Morgenstein (1):
      IB/mlx4: Fix corruption of RoCEv2 IPv4 GIDs

Jacob Keller (1):
      ixgbe: prevent ptp_rx_hang from running when in FILTER_ALL mode

Jake Moroni (1):
      dpaa_eth: fix pause capability advertisement logic

James Hogan (1):
      MIPS: generic: Fix machine compatible matching

Jan Kara (1):
      udf: Provide saner default for invalid uid / gid

Jan Kiszka (1):
      builddeb: Fix header package regarding dtc source links

Jan Kundr=C3=A1t (1):
      pinctrl: mcp23s08: spi: Fix regmap debugfs entries

Jaros=C5=82aw Janik (1):
      nvme-pci: disable APST for Samsung NVMe SSD 960 EVO + ASUS PRIME Z370=
-A

Jason Gunthorpe (1):
      IB/uverbs: Fix unbalanced unlock on error path for rdma_explicit_dest=
roy

Jason Wang (1):
      ptr_ring: prevent integer overflow when calculating size

Jay Vosburgh (1):
      virtio-net: Fix operstate for virtio when no VIRTIO_NET_F_STATUS

Jayachandran C (1):
      watchdog: sbsa: use 32-bit read for WCV

Jean Delvare (1):
      firmware: dmi_scan: Fix UUID length safety check

Jeff Mahoney (2):
      btrfs: use kvzalloc to allocate btrfs_fs_info
      btrfs: fix lockdep splat in btrfs_alloc_subvolume_writers

Jens Axboe (2):
      sr: pass down correctly sized SCSI sense buffer
      sr: get/drop reference to device in revalidate and check_events

Jeremy Linton (1):
      net: smsc911x: Fix unload crash when link is up

Jesper Dangaard Brouer (1):
      virtio_net: fix XDP code path in receive_small()

Jianchao Wang (1):
      nvme-pci: Fix nvme queue cleanup if IRQ setup fails

Jiandi An (1):
      ima: Fix Kconfig to select TPM 2.0 CRB interface

Jim Mattson (1):
      kvm: x86: IA32_ARCH_CAPABILITIES is always supported

Jin Yao (1):
      perf report: Fix wrong jump arrow

Jinbum Park (1):
      ARM: 8748/1: mm: Define vdso_start, vdso_end as array

Jiri Olsa (4):
      perf record: Fix crash in pipe mode
      perf tests: Use arch__compare_symbol_names to compare symbols
      perf report: Fix memory corruption in --branch-history mode --branch-=
history
      perf tests: Fix dwarf unwind for stripped binaries

Jiri Pirko (1):
      mlxsw: core: Fix flex keys scratchpad offset conflict

Jiufei Xue (1):
      block: display the correct diskname for bio

Joe Jin (1):
      xen-swiotlb: fix the check condition for xen_swiotlb_free_coherent

Joe Lee (1):
      xhci: workaround for AMD Promontory disabled ports wakeup

Joe Perches (1):
      MIPS: Octeon: Fix logging messages with spurious periods after newlin=
es

Joerg Roedel (1):
      x86/pgtable: Don't set huge PUD/PMD on non-leaf entries

Joey Pabalinas (1):
      net/tcp/illinois: replace broken algorithm reference link

Johannes Berg (2):
      regulatory: add NUL to request alpha2
      iwlwifi: mvm: fix error checking for multi/broadcast sta

Johannes Thumshirn (1):
      nvme: don't send keep-alives to the discovery controller

Julian Anastasov (1):
      ipvs: remove IPS_NAT_MASK check to fix passive FTP

Jun Piao (1):
      ocfs2/dlm: don't handle migrate lockres if already in shutdown

Ka-Cheong Poon (1):
      rds: Incorrect reference counting in TCP socket creation

Kalderon, Michal (5):
      RDMA/qedr: Fix kernel panic when running fio over NFSoRDMA
      RDMA/qedr: Fix iWARP write and send with immediate
      RDMA/qedr: fix QP's ack timeout configuration
      RDMA/qedr: Fix rc initialization on CNQ allocation failure
      RDMA/qedr: Fix QP state initialization race

Kamil Trzci=C5=84ski (1):
      arm64: dts: rockchip: fix rock64 gmac2io stability issues

Kamlakant Patel (1):
      ipmi_ssif: Fix kernel panic at msg_done_handler

Kan Liang (3):
      perf/x86/intel: Properly save/restore the PMU state in the NMI handler
      perf/x86/intel: Fix large period handling on Broadwell CPUs
      perf/x86/intel: Fix event update for auto-reload

Karol Herbst (1):
      drm/nouveau/bl: fix backlight regression

Karsten Graul (1):
      net/smc: use link_id of server in confirm link reply

Karthikeyan Periyasamy (1):
      ath10k: Fix kernel panic while using worker (ath10k_sta_rc_update_wk)

Kees Cook (1):
      NFC: llcp: Limit size of SDP URI

Konrad Rzeszutek Wilk (1):
      KVM/VMX: Expose SSBD properly to guests

Ladislav Michl (1):
      power: supply: ltc2941-battery-gauge: Fix temperature units

Laurent Pinchart (2):
      drm: omapdrm: dss: Move initialization code from component bind to pr=
obe
      ARM: dts: porter: Fix HDMI output routing

Lenny Szubowicz (1):
      ACPI: acpi_pad: Fix memory leak in power saving threads

Leo Yan (1):
      coresight: Use %px to print pcsr instead of %p

Leon Romanovsky (1):
      net/mlx5: Protect from command bit overflow

Li Zhijian (2):
      selftests/bpf/test_maps: exit child process without error in ENOMEM c=
ase
      selftests/vm/run_vmtests: adjust hugetlb size according to nr_cpus

Lidong Chen (1):
      IB/umem: Use the correct mm during ib_umem_release

Linus L=C3=BCssing (3):
      batman-adv: Fix multicast packet loss with a single WANT_ALL_IPV4/6 f=
lag
      batman-adv: fix multicast-via-unicast transmission with AP isolation
      batman-adv: fix packet loss for broadcasted DHCP packets to a server

Linus Walleij (1):
      drm/bridge: sii902x: Retry status read after DDI I2C

Liu Bo (3):
      Btrfs: clean up resources during umount after trans is aborted
      Btrfs: bail out on error during replay_dir_deletes
      Btrfs: fix NULL pointer dereference in log_dir_items

Luca Coelho (1):
      iwlwifi: mvm: check if mac80211_queue is valid in iwl_mvm_disable_txq

Lucas Stach (1):
      drm/imx: move arming of the vblank event to atomic_flush

Luis R. Rodriguez (1):
      lib/test_kmod.c: fix limit check on number of test devices created

Maciej W. Rozycki (2):
      MIPS: ptrace: Expose FIR register through FP regset
      MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32=
 FGRs

Madalin Bucur (1):
      dpaa_eth: fix SG mapping

Madhavan Srinivasan (1):
      powerpc/perf: Prevent kernel address leak to userspace via BHRB buffer

Maninder Singh (1):
      mm/page_owner: fix recursion bug after changing skip entries

Manish Chopra (2):
      qede: Fix barrier usage after tx doorbell write.
      qede: Do not drop rx-checksum invalidated packets.

Marc Zyngier (1):
      arm64: Relax ARM_SMCCC_ARCH_WORKAROUND_1 discovery

Mark Lord (1):
      powerpc/bpf/jit: Fix 32-bit JIT for seccomp_data access

Mark Rutland (2):
      arm64: perf: correct PMUVer probing
      efi/arm*: Only register page tables when they exist

Masami Hiramatsu (3):
      selftests: ftrace: Add probe event argument syntax testcase
      selftests: ftrace: Add a testcase for string type with kprobe_event
      selftests: ftrace: Add a testcase for probepoint

Matan Barak (2):
      IB/uverbs: Fix method merging in uverbs_ioctl_merge
      IB/uverbs: Fix possible oops with duplicate ioctl attributes

Mathias Kresin (1):
      MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset

Mathieu Malaterre (1):
      powerpc: Add missing prototype for arch_irq_work_raise()

Matthew Wilcox (1):
      idr: fix invalid ptr dereference on item delete

Matthias Schiffer (3):
      batman-adv: fix packet checksum in receive path
      batman-adv: invalidate checksum on fragment reassembly
      batman-adv: fix header size check in batadv_dbg_arp()

Mauricio Faria de Oliveira (4):
      powerpc/rfi-flush: Differentiate enabled and patched flush types
      powerpc/pseries: Fix clearing of security feature flags
      powerpc: Move default security feature flags
      powerpc/pseries: Restore default security feature flags on setup

Maurizio Lombardi (1):
      cdrom: do not call check_disk_change() inside cdrom_open()

Max Gurtovoy (1):
      nvmet: fix PSDT field check in command format

Michael Chan (1):
      bnxt_en: Check valid VNIC ID in bnxt_hwrm_vnic_set_tpa().

Michael Ellerman (21):
      powerpc/pseries: Support firmware disable of RFI flush
      powerpc/powernv: Support firmware disable of RFI flush
      powerpc/rfi-flush: Move the logic to avoid a redo into the debugfs co=
de
      powerpc/rfi-flush: Make it possible to call setup_rfi_flush() again
      powerpc/rfi-flush: Always enable fallback flush on pseries
      powerpc/rfi-flush: Call setup_rfi_flush() after LPM migration
      powerpc/pseries: Add new H_GET_CPU_CHARACTERISTICS flags
      powerpc: Add security feature flags for Spectre/Meltdown
      powerpc/pseries: Set or clear security feature flags
      powerpc/powernv: Set or clear security feature flags
      powerpc/64s: Move cpu_show_meltdown()
      powerpc/64s: Enhance the information in cpu_show_meltdown()
      powerpc/powernv: Use the security flags in pnv_setup_rfi_flush()
      powerpc/pseries: Use the security flags in pseries_setup_rfi_flush()
      powerpc/64s: Wire up cpu_show_spectre_v1()
      powerpc/64s: Wire up cpu_show_spectre_v2()
      powerpc/64s: Fix section mismatch warnings from setup_rfi_flush()
      selftests/powerpc: Skip the subpage_prot tests if the syscall is unav=
ailable
      powerpc/mpic: Check if cpu_possible() in mpic_physmask()
      powerpc/perf: Fix kernel address leak via sampling registers
      selftests: Print the test we're running to /dev/kmsg

Michael J. Ruhl (1):
      IB/hfi1: Use after free race condition in send context error path

Michael Neuling (1):
      powerpc/64s: Clear PCR on boot

Michael Schmitz (1):
      zorro: Set up z->dev.dma_mask for the DMA API

Michal Kalderon (1):
      qed: Free RoCE ILT Memory on rmmod qedr

Mikhail Malygin (1):
      IB/rxe: Fix for oops in rxe_register_device on ppc64le arch

Milton Miller (2):
      watchdog: aspeed: Allow configuring for alternate boot
      watchdog: aspeed: Fix translation of reset mode to ctrl register

Ming Lei (2):
      nvme: pci: pass max vectors as num_possible_cpus() to pci_alloc_irq_v=
ectors
      block: null_blk: fix 'Invalid parameters' when loading module

Moni Shoua (1):
      IB/mlx: Set slid to zero in Ethernet completion struct

Monk Liu (2):
      drm/amdgpu: disable GFX ring and disable PQ wptr in hw_fini
      drm/amdgpu: adjust timeout for ib_ring_tests(v2)

Naftali Goldstein (1):
      iwlwifi: mvm: always init rs with 20mhz bandwidth rates

Naresh Kamboju (1):
      selftests: pstore: Adding config fragment CONFIG_PSTORE_RAM=3Dm

Neil Armstrong (1):
      drm/meson: fix vsync buffer update

NeilBrown (1):
      MIPS: c-r4k: Fix data corruption related to cache coherence

Nicholas Piggin (4):
      powerpc/64s: Improve RFI L1-D cache flush fallback
      powerpc/64s: Add support for a store forwarding barrier at kernel ent=
ry/exit
      powerpc/64s/idle: Fix restore of AMOR on POWER9 after deep sleep
      powerpc/64s: sreset panic if there is no debugger or crash dump handl=
ers

Nicolas Pitre (1):
      kbuild: make scripts/adjust_autoksyms.sh robust against timestamp rac=
es

Niklas Cassel (4):
      pinctrl: artpec6: dt: add missing pin group uart5nocts
      net: stmmac: ensure that the device has released ownership before rea=
ding data
      net: stmmac: ensure that the MSS desc is the last desc to set the own=
 bit
      net: stmmac: call correct function in stmmac_mac_config_rx_queues_rou=
ting()

Nikolay Borisov (1):
      btrfs: Fix possible softlock on single core machines

Oded Gabbay (1):
      drm/amdkfd: add missing include of mm.h

Or Gerlitz (2):
      net/mlx5e: Return error if prio is specified when offloading eswitch =
vlan push
      net/mlx5: Make eswitch support to depend on switchdev

Parav Pandit (2):
      IB/core: Fix possible crash to access NULL netdev
      IB/core: Honor port_num while resolving GID for IB link layer

Pawel Dembicki (1):
      net: qmi_wwan: add BroadMobi BM806U 2020:2033

Peter Malone (1):
      fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbus=
fb_ioctl_helper().

Peter Oh (1):
      mac80211: mesh: fix wrong mesh TTL offset calculation

Peter Rosin (1):
      ARM: dts: at91: tse850: use the correct compatible for the eeprom

Peter Zijlstra (1):
      perf/core: Fix perf_output_read_group()

Petr Vorel (1):
      ima: Fallback to the builtin hash algorithm

Philipp Puschmann (1):
      arm: dts: socfpga: fix GIC PPI warning

Pierre Bourdon (1):
      max17042: propagate of_node to power supply device

Pierre-Yves Kerbrat (1):
      e1000e: allocate ring descriptors with dma_zalloc_coherent

Prashant Bhole (1):
      selftests/net: fixes psock_fanout eBPF test case

Pratyush Anand (1):
      arm64: fix unwind_frame() for filtered out fn for function graph trac=
ing

Qi Hou (2):
      ARM: OMAP2+: timer: fix a kmemleak caused in omap_get_timer_dt
      dmaengine: pl330: fix a race condition in case of threaded irqs

Qu Wenruo (2):
      btrfs: tests/qgroup: Fix wrong tree backref level
      btrfs: qgroup: Fix root item corruption when multiple same source sna=
pshots are created with quota enabled

Rafael J. Wysocki (2):
      PCI: Restore config space on runtime resume despite being unbound
      PCMCIA / PM: Avoid noirq suspend aborts during suspend-to-idle

Raghuram Chary J (1):
      lan78xx: Set ASD in MAC_CR when EEE is enabled.

Ramon Fried (1):
      qrtr: add MODULE_ALIAS macro to smd

Randy Dunlap (2):
      integrity/security: fix digsig.c build error with header file
      kdb: make "mdr" command repeat

Ravikumar Kattekola (1):
      ARM: dts: dra71-evm: Correct evm_sd regulator max voltage

Rich Felker (1):
      sh: fix debug trap failure to process signals before return to user

Richard Fitzgerald (1):
      pinctrl: devicetree: Fix dt_to_map_one_config handling of hogs

Richard Guy Briggs (1):
      audit: return on memory error to avoid null pointer dereference

Richard Haines (1):
      netlabel: If PF_INET6, check sk_buff ip header version

Rob Herring (2):
      arm64: dts: cavium: fix PCI bus dtc warnings
      ARM: dts: rockchip: Add missing #sound-dai-cells on rk3288

Robin Murphy (2):
      arm64: dts: rockchip: Fix DWMMC clocks
      ARM: dts: rockchip: Fix DWMMC clocks

Roger Pau Monne (1):
      xen/pirq: fix error path cleanup when binding MSIs

Sabrina Dubroca (1):
      ipv4: lock mtu in fnhe when received PMTU < net.ipv4.route.min_pmtu

Sai Praneeth (1):
      x86/mm: Fix bogus warning during EFI bootup, use boot_cpu_has() inste=
ad of this_cpu_has() in build_cr3_noflush()

Samuel Neves (1):
      x86/topology: Update the 'cpu cores' field in /proc/cpuinfo correctly=
 across CPU hotplug operations

Sandipan Das (2):
      perf tools: Fix perf builds with clang support
      perf clang: Add support for recent clang versions

Sara Sharon (7):
      iwlwifi: mvm: fix security bug in PN checking
      iwlwifi: mvm: fix IBSS for devices that support station type API
      mac80211: fix a possible leak of station stats
      mac80211: fix calling sleeping function in atomic context
      iwlwifi: mvm: fix TX of CCMP 256
      iwlwifi: mvm: fix assert 0x2B00 on older FWs
      iwlwifi: mvm: fix "failed to remove key" message

Sean Christopherson (1):
      KVM: VMX: raise internal error for exception during invalid protected=
 mode state

Sean Wang (1):
      net: dsa: mt7530: fix module autoloading for OF platform drivers

Sebastian Andrzej Siewior (1):
      iommu/amd: Take into account that alloc_dev_data() may return NULL

Sebastian Gottschall (1):
      ath9k: fix crash in spectral scan

Sebastian Ott (4):
      s390/cio: fix ccw_device_start_timeout API
      s390/cio: fix return code after missing interrupt
      s390/cio: clear timer when terminating driver I/O
      kvm: fix warning for CONFIG_HAVE_KVM_EVENTFD builds

Selvin Xavier (2):
      RDMA/bnxt_re: Fix system crash during load/unload
      RDMA/bnxt_re: Fix the ib_reg failure cleanup

Sergei Shtylyov (3):
      sh_eth: fix TSU init on SH7734/R8A7740
      drm: rcar-du: lvds: Fix LVDS startup on R-Car Gen3
      drm: rcar-du: lvds: Fix LVDS startup on R-Car Gen2

Seunghun Han (1):
      ACPICA: acpi: acpica: fix acpi operand cache leak in nseval.c

Shakeel Butt (1):
      mm, slab: memcg_link the SLAB's kmem_cache

Shaul Triebitz (1):
      iwlwifi: avoid collecting firmware dump if not loaded

Shawn Lin (2):
      arm64: dts: rockchip: correct ep-gpios for rk3399-sapphire
      phy: rockchip-emmc: retry calpad busy trimming

Shunyong Yang (1):
      cpufreq: CPPC: Initialize shared perf capabilities of CPUs

Shyam Saini (1):
      ARM: dts: imx6dl: Include correct dtsi file for Engicam i.CoreM6 Dual=
Lite/Solo RQS

Song Liu (1):
      perf/cgroup: Fix child event counting bug

Srinath Mannam (1):
      mmc: sdhci-iproc: remove hard coded mmc cap 1.8v

Srinivas Kandagatla (1):
      dmaengine: qcom: bam_dma: get num-channels and num-ees from dt

Stefan Agner (1):
      soc: imx: gpc: de-register power domains only if initialized

Stefan Haberland (1):
      s390/dasd: fix handling of internal requests

Stefan Wahren (3):
      ARM: dts: bcm283x: Fix unit address of local_intc
      brcmfmac: Fix check for ISO3166 code
      ARM: dts: bcm283x: Fix probing of bcm2835-i2s

Stefano Brivio (4):
      vti4: Don't count header length twice on tunnel setup
      ip_tunnel: Clamp MTU to bounds on new link
      vti4: Don't override MTU passed on link creation via IFLA_MTU
      vti6: Fix dev->max_mtu setting

Steffen Klassert (2):
      xfrm: Fix ESN sequence number handling for IPsec GSO packets.
      xfrm: Fix transport mode skb control buffer usage.

Stephane Eranian (1):
      perf/x86/intel: Fix linear IP of PEBS real_ip on Haswell and later CP=
Us

Stephen Hemminger (7):
      hv_netvsc: use napi_schedule_irqoff
      hv_netvsc: filter multicast/broadcast
      hv_netvsc: propagate rx filters to VF
      hv_netvsc: fix filter flags
      hv_netvsc: fix locking for rx_mode
      hv_netvsc: fix locking during VF setup
      hv_netvsc: enable multicast if necessary

Steven J. Hill (1):
      mm/vmstat.c: fix vmstat_update() preemption BUG

Sudip Mukherjee (1):
      libata: blacklist Micron 500IT SSD with MU01 firmware

Sven Eckelmann (5):
      batman-adv: Ignore invalid batadv_iv_gw during netlink send
      batman-adv: Ignore invalid batadv_v_gw during netlink send
      batman-adv: Fix netlink dumping of BLA claims
      batman-adv: Fix netlink dumping of BLA backbones
      batman-adv: Fix skbuff rcsum on packet reroute

Taehee Yoo (1):
      xfrm: fix rcu_read_unlock usage in xfrm_local_error

Takashi Iwai (1):
      ALSA: vmaster: Propagate slave error

Takeshi Kihara (1):
      pinctrl: sh-pfc: r8a7796: Fix MOD_SEL register pin assignment for SSI=
 pins group

Tang Junhui (1):
      bcache: fix kcrashes with fio in RAID5 backend dev

Tejun Heo (2):
      libata: Blacklist some Sandisk SSDs for NCQ
      rcu: Call touch_nmi_watchdog() while printing stall warnings

Thierry Reding (1):
      drm/tegra: Shutdown on driver unbind

Thomas Falcon (5):
      ibmvnic: Wait until reset is complete to set carrier on
      ibmvnic: Free RX socket buffer in case of adapter error
      ibmvnic: Clean RX pool buffers during device close
      ibmvnic: Check for NULL skb's in NAPI poll routine
      ibmvnic: Zero used TX descriptor counter on reset

Thomas Hellstrom (2):
      drm/vmwgfx: Fix 32-bit VMW_PORT_HB_[IN|OUT] macros
      drm/vmwgfx: Unpin the screen object backup buffer when not used

Thomas Richter (2):
      perf stat: Fix core dump when flag T is used
      perf test: Fix test case inet_pton to accept inlines.

Thomas Vincent-Cross (1):
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9220

Tobias Jordan (2):
      gpu: ipu-v3: pre: fix device node leak in ipu_pre_lookup_by_phandle
      gpu: ipu-v3: prg: fix device node leak in ipu_prg_lookup_by_phandle

Tom Abraham (1):
      swap: divide-by-zero when zero length swap file on ssd

Tom St Denis (1):
      drm/amd/amdgpu: Correct VRAM width for APUs with GMC9

Tony Lindgren (3):
      ARM: OMAP3: Fix prm wake interrupt for resume
      ARM: OMAP2+: Fix sar_base inititalization for HS omaps
      ARM: OMAP: Fix dmtimer init for omap1

Toshiaki Makita (4):
      net: Fix vlan untag for bridge and vlan_dev with reorder_hdr off
      vlan: Fix out of order vlan headers with reorder header off
      net: Fix untag for vlan packets without ethernet header
      vlan: Fix vlan insertion for packets without ethernet header

Tycho Andersen (1):
      seccomp: add a selftest for get_metadata

Ulf Magnusson (1):
      ARC: Fix malformed ARC_EMUL_UNALIGNED default

Ursula Braun (1):
      net/smc: pay attention to MAX_ORDER for CQ entries

Vaibhav Jain (1):
      cxl: Check if PSL data-cache is available before issue flush request

Vinayak Menon (1):
      mm/kmemleak.c: wait for scan completion before disabling free

Viresh Kumar (1):
      cpufreq: Reorder cpufreq_online() error code path

Vitaly Kuznetsov (1):
      KVM: lapic: stop advertising DIRECTED_EOI when in-kernel IOAPIC is in=
 use

Vivek Gautam (1):
      phy: qcom-qmp: Fix phy pipe clock gating

Wang Hui (1):
      x86/intel_rdt: Fix incorrect returned value when creating rdgroup sub=
-directory in resctrl file system

Wei Huang (1):
      KVM: x86: Update cpuid properly when CR4.OSXAVE or CR4.PKE is changed

Wen Xiong (1):
      nvme-pci: Fix EEH failure on ppc

Will Deacon (3):
      arm64: lse: Add early clobbers to some input/output asm operands
      fs: dcache: Avoid livelock between d_alloc_parallel and __d_add
      fs: dcache: Use READ_ONCE when accessing i_dir_seq

Wolfram Sang (2):
      drm/exynos: fix comparison to bitshift when dealing with a mask
      can: m_can: change comparison to bitshift when dealing with a mask

Xiao Ni (1):
      MD: Free bioset when md_run fails

Xidong Wang (1):
      z3fold: fix memory leak

Xin Long (5):
      xfrm: do not call rcu_read_unlock when afinfo is NULL in xfrm_get_tos
      ip_gre: fix IFLA_MTU ignored on NEWLINK
      ip6_tunnel: fix IFLA_MTU ignored on NEWLINK
      sit: fix IFLA_MTU ignored on NEWLINK
      bonding: fix the err path for dev hwaddr sync in bond_enslave

Y.C. Chen (1):
      drm/ast: Fixed 1280x800 Display Issue

Yang Shi (1):
      mm: thp: fix potential clearing to referenced flag in page_idle_clear=
_pte_refs_one()

Yelena Krivosheev (1):
      net: mvneta: fix enable of all initialized RXQs

Yisheng Xie (2):
      mm/mempolicy.c: avoid use uninitialized preferred_node
      perf top: Fix top.call-graph config option reading

Yong Wu (1):
      iommu/mediatek: Fix protect memory setting

Yoshihiro Shimoda (2):
      dmaengine: rcar-dmac: fix max_chunk_size for R-Car Gen3
      dmaengine: rcar-dmac: Check the done lists in rcar_dmac_chan_get_resi=
due()

Yufen Yu (2):
      md raid10: fix NULL deference in handle_write_completed()
      md/raid1: fix NULL pointer dereference

leilei.lin (1):
      perf/core: Fix installing cgroup events on CPU

lionel.debieve@st.com (1):
      hwrng: stm32 - add reset during probe

=C3=98rjan Eide (1):
      drm/rockchip: Respect page offset for PRIME mmap calls


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsOU8oACgkQONu9yGCS
aT5ExA//Q/oaf6h9lcLeTNgbTwV0nRRQv09qy0m+9SSbsT6Wc5Fvd3CXlEtNZ36z
0idlcDMKUAVIa5EhP/Q3wkXN6r3qELhm7O0kpQtxDasnI0LMqlVMfBjXKW6EQi3H
3Gw2K1S+NLhvMI4YRTbVglcUW8+1UpRr/xL7vWrmiXDKS7QT90Nmb3DKhSxSOZeq
cDX58SwyJSrFinVSgNWlQ7+6gbgf8Ts5WEJWubPvByXmJ9TZfe4CnpHPutZrT51Z
DWkFbx3hxRUIMQWuLV+Tm6vDWPRQvNVupJ/ye0aCz5oPQ8xDwn6DKtu6dAkwc4xo
W3U21MoNLSqlGCk8refEwKDBBLAgSIkPCD20nlfem+UljJDVgbtQUuGyu2VoOM2T
51dX7Ek9tleTX6zGnVC/3AbdS9m/yO/BNpf8V06D/8NQGwqMPZB6vXtUtq12+x21
tvBHzyGSrKFolVTFEoo1u4iP7KPzosxKwgDi6JQBoGZdS65K7MKske9AFw6ISKRZ
WXYhOMOaS4C+BQpxy4jmeTlWeHkuOllx+lAQbb4S8R/GDXg6sptFFw1Lzwo/moH8
H6+TmNsq/cZTKvaSBRudjVOkwgJCL1Z5qO/gMhBYUZxp1Zo48rRKfq+HFjaDfL0F
Nvg++Rg45a3UwKYAw+9y/lRWpPJ0ynsYSFe/YKmpPftC4L+xK7k=
=f23H
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
