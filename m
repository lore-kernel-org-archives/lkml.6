Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968700AbeE3Hfe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935712AbeE3HeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:34:25 -0400
Date: Wed, 30 May 2018 09:33:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.13
Message-ID: <20180530073354.GA22769@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.13 kernel.

All users of the 4.16 kernel series must upgrade.

The updated 4.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.16.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/clock/sunxi-ccu.txt              |    4=
=20
 Documentation/devicetree/bindings/display/msm/dsi.txt              |    4=
=20
 Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt |    5=
=20
 Makefile                                                           |    2=
=20
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts                        |    2=
=20
 arch/arm/boot/dts/at91-tse850-3.dts                                |    2=
=20
 arch/arm/boot/dts/bcm283x.dtsi                                     |    6=
=20
 arch/arm/boot/dts/dra71-evm.dts                                    |    4=
=20
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts                            |   52 -
 arch/arm/boot/dts/keystone-k2e-clocks.dtsi                         |    2=
=20
 arch/arm/boot/dts/r8a7791-porter.dts                               |    2=
=20
 arch/arm/boot/dts/socfpga.dtsi                                     |    2=
=20
 arch/arm/boot/dts/sun4i-a10.dtsi                                   |    6=
=20
 arch/arm64/boot/dts/qcom/msm8996.dtsi                              |    4=
=20
 arch/arm64/include/asm/atomic_lse.h                                |   24=
=20
 arch/arm64/kernel/arm64ksyms.c                                     |    8=
=20
 arch/arm64/lib/tishift.S                                           |   15=
=20
 arch/m68k/coldfire/device.c                                        |   12=
=20
 arch/mips/boot/compressed/uart-16550.c                             |    6=
=20
 arch/mips/boot/dts/xilfpga/Makefile                                |    2=
=20
 arch/mips/cavium-octeon/octeon-irq.c                               |   10=
=20
 arch/mips/generic/Platform                                         |    1=
=20
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h                     |    2=
=20
 arch/mips/kernel/ptrace.c                                          |   22=
=20
 arch/mips/kernel/ptrace32.c                                        |    4=
=20
 arch/mips/kvm/mips.c                                               |    2=
=20
 arch/mips/mm/c-r4k.c                                               |    9=
=20
 arch/powerpc/include/asm/book3s/64/slice.h                         |   27=
=20
 arch/powerpc/include/asm/irq_work.h                                |    1=
=20
 arch/powerpc/include/asm/mmu-8xx.h                                 |    6=
=20
 arch/powerpc/include/asm/nohash/32/slice.h                         |   18=
=20
 arch/powerpc/include/asm/nohash/64/slice.h                         |   12=
=20
 arch/powerpc/include/asm/page.h                                    |    1=
=20
 arch/powerpc/include/asm/page_64.h                                 |   59 -
 arch/powerpc/include/asm/slice.h                                   |   42 +
 arch/powerpc/kernel/cpu_setup_power.S                              |    6=
=20
 arch/powerpc/kernel/dt_cpu_ftrs.c                                  |    1=
=20
 arch/powerpc/kernel/idle_book3s.S                                  |    2=
=20
 arch/powerpc/kernel/setup-common.c                                 |    2=
=20
 arch/powerpc/kernel/traps.c                                        |   47 -
 arch/powerpc/mm/8xx_mmu.c                                          |    2=
=20
 arch/powerpc/mm/hugetlbpage.c                                      |    2=
=20
 arch/powerpc/mm/mmu_context_nohash.c                               |   18=
=20
 arch/powerpc/mm/slice.c                                            |   49 -
 arch/powerpc/perf/core-book3s.c                                    |   25=
=20
 arch/powerpc/platforms/Kconfig.cputype                             |    1=
=20
 arch/powerpc/platforms/powernv/npu-dma.c                           |  229 =
+++---
 arch/powerpc/platforms/powernv/vas-debug.c                         |   11=
=20
 arch/powerpc/platforms/powernv/vas.c                               |    6=
=20
 arch/powerpc/sysdev/mpic.c                                         |    2=
=20
 arch/riscv/include/asm/fence.h                                     |   12=
=20
 arch/riscv/include/asm/spinlock.h                                  |   29=
=20
 arch/s390/kvm/vsie.c                                               |    2=
=20
 arch/sh/kernel/entry-common.S                                      |    2=
=20
 arch/sparc/include/asm/atomic_64.h                                 |    6=
=20
 arch/x86/events/core.c                                             |   15=
=20
 arch/x86/events/intel/core.c                                       |   12=
=20
 arch/x86/events/intel/ds.c                                         |   92 =
++
 arch/x86/events/perf_event.h                                       |    2=
=20
 arch/x86/include/asm/tlbflush.h                                    |    7=
=20
 arch/x86/kernel/apic/apic.c                                        |    2=
=20
 arch/x86/kernel/devicetree.c                                       |   21=
=20
 arch/x86/kvm/cpuid.c                                               |    9=
=20
 arch/x86/kvm/lapic.c                                               |   26=
=20
 arch/x86/kvm/vmx.c                                                 |   20=
=20
 arch/x86/kvm/x86.c                                                 |    5=
=20
 arch/x86/mm/pageattr.c                                             |    6=
=20
 arch/x86/mm/pgtable.c                                              |    9=
=20
 drivers/acpi/acpi_pad.c                                            |    3=
=20
 drivers/acpi/acpica/evevent.c                                      |    9=
=20
 drivers/acpi/acpica/nseval.c                                       |    8=
=20
 drivers/acpi/acpica/psargs.c                                       |    4=
=20
 drivers/ata/ahci.c                                                 |    1=
=20
 drivers/ata/libata-core.c                                          |    6=
=20
 drivers/base/firmware_class.c                                      |   12=
=20
 drivers/base/power/main.c                                          |    7=
=20
 drivers/base/regmap/regmap.c                                       |    2=
=20
 drivers/bcma/driver_mips.c                                         |    2=
=20
 drivers/block/null_blk.c                                           |   46 -
 drivers/block/paride/pcd.c                                         |    2=
=20
 drivers/cdrom/cdrom.c                                              |    3=
=20
 drivers/cdrom/gdrom.c                                              |    3=
=20
 drivers/char/hw_random/bcm2835-rng.c                               |    2=
=20
 drivers/char/hw_random/stm32-rng.c                                 |    9=
=20
 drivers/char/ipmi/ipmi_ssif.c                                      |    4=
=20
 drivers/cpufreq/cppc_cpufreq.c                                     |   23=
=20
 drivers/cpufreq/cpufreq.c                                          |    6=
=20
 drivers/dma/pl330.c                                                |    6=
=20
 drivers/dma/qcom/bam_dma.c                                         |   27=
=20
 drivers/dma/sh/rcar-dmac.c                                         |   13=
=20
 drivers/firmware/dmi_scan.c                                        |    2=
=20
 drivers/firmware/efi/arm-runtime.c                                 |    3=
=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h                         |    1=
=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c                             |   33=
=20
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                              |    8=
=20
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c                             |    7=
=20
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                  |    4=
=20
 drivers/gpu/drm/bridge/sii902x.c                                   |   20=
=20
 drivers/gpu/drm/drm_vblank.c                                       |    8=
=20
 drivers/gpu/drm/meson/meson_drv.c                                  |   29=
=20
 drivers/gpu/drm/omapdrm/dss/dss.c                                  |  193 =
++---
 drivers/gpu/drm/panel/panel-simple.c                               |    2=
=20
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c                          |   18=
=20
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                        |    7=
=20
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.h                                |   25=
=20
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c                               |   31=
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
 drivers/infiniband/core/multicast.c                                |   26=
=20
 drivers/infiniband/core/umem.c                                     |    7=
=20
 drivers/infiniband/hw/hfi1/chip.c                                  |    4=
=20
 drivers/infiniband/hw/mlx5/main.c                                  |    3=
=20
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
 drivers/md/bcache/bcache.h                                         |    9=
=20
 drivers/md/bcache/super.c                                          |   39 -
 drivers/md/bcache/sysfs.c                                          |    3=
=20
 drivers/md/bcache/writeback.c                                      |   60 +
 drivers/md/bcache/writeback.h                                      |    2=
=20
 drivers/misc/cxl/cxl.h                                             |    4=
=20
 drivers/misc/cxl/native.c                                          |   11=
=20
 drivers/misc/cxl/pci.c                                             |   19=
=20
 drivers/mmc/core/block.c                                           |    2=
=20
 drivers/mmc/host/sdhci-iproc.c                                     |   33=
=20
 drivers/net/ethernet/broadcom/bgmac.c                              |    3=
=20
 drivers/net/ethernet/broadcom/bgmac.h                              |    6=
=20
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c                  |    8=
=20
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c                       |    4=
=20
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c                    |   11=
=20
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c                     |    1=
=20
 drivers/net/ethernet/cisco/enic/enic_main.c                        |   10=
=20
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                     |   23=
=20
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c                 |    2=
=20
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                    |    2=
=20
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c                 |    4=
=20
 drivers/net/ethernet/ibm/ibmvnic.c                                 |   30=
=20
 drivers/net/ethernet/intel/i40e/i40e_main.c                        |   30=
=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                      |    3=
=20
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                      |    2=
=20
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                  |   61 -
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c                 |    2=
=20
 drivers/net/ethernet/renesas/sh_eth.c                              |    6=
=20
 drivers/net/ethernet/renesas/sh_eth.h                              |    1=
=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                  |   16=
=20
 drivers/net/hyperv/netvsc.c                                        |    8=
=20
 drivers/net/hyperv/netvsc_drv.c                                    |    2=
=20
 drivers/net/hyperv/rndis_filter.c                                  |    4=
=20
 drivers/net/ieee802154/ca8210.c                                    |   14=
=20
 drivers/net/phy/dp83640.c                                          |   18=
=20
 drivers/net/usb/lan78xx.c                                          |   34=
=20
 drivers/net/virtio_net.c                                           |    2=
=20
 drivers/net/wireless/ath/ath10k/mac.c                              |   12=
=20
 drivers/net/wireless/ath/ath9k/common-spectral.c                   |   12=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c                     |    6=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c                     |   11=
=20
 drivers/net/wireless/mediatek/mt76/mt76x2_main.c                   |   11=
=20
 drivers/net/wireless/mediatek/mt76/mt76x2_tx.c                     |    5=
=20
 drivers/net/wireless/rsi/rsi_91x_sdio.c                            |   32=
=20
 drivers/net/wireless/rsi/rsi_sdio.h                                |    2=
=20
 drivers/nvme/host/core.c                                           |   17=
=20
 drivers/nvme/host/fabrics.c                                        |   83 =
++
 drivers/nvme/host/fabrics.h                                        |   33=
=20
 drivers/nvme/host/fc.c                                             |   17=
=20
 drivers/nvme/host/nvme.h                                           |    1=
=20
 drivers/nvme/host/pci.c                                            |    7=
=20
 drivers/nvme/host/rdma.c                                           |   14=
=20
 drivers/nvme/target/loop.c                                         |   11=
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
 drivers/phy/rockchip/phy-rockchip-emmc.c                           |   27=
=20
 drivers/pinctrl/devicetree.c                                       |    6=
=20
 drivers/pinctrl/pinctrl-mcp23s08.c                                 |   37=
=20
 drivers/pinctrl/qcom/pinctrl-msm.c                                 |    2=
=20
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c                               |   40 -
 drivers/platform/x86/dell-smbios-base.c                            |    4=
=20
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
 drivers/s390/cio/vfio_ccw_fsm.c                                    |    5=
=20
 drivers/scsi/sr.c                                                  |   21=
=20
 drivers/scsi/sr_ioctl.c                                            |   10=
=20
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c                            |    6=
=20
 drivers/soc/qcom/wcnss_ctrl.c                                      |    2=
=20
 drivers/soc/renesas/r8a77970-sysc.c                                |   12=
=20
 drivers/spi/spi-bcm-qspi.c                                         |    4=
=20
 drivers/watchdog/asm9260_wdt.c                                     |    8=
=20
 drivers/watchdog/aspeed_wdt.c                                      |   13=
=20
 drivers/watchdog/davinci_wdt.c                                     |   15=
=20
 drivers/watchdog/dw_wdt.c                                          |   23=
=20
 drivers/watchdog/sprd_wdt.c                                        |    4=
=20
 drivers/xen/swiotlb-xen.c                                          |    2=
=20
 drivers/xen/xen-acpi-processor.c                                   |    6=
=20
 drivers/zorro/zorro.c                                              |   12=
=20
 fs/affs/namei.c                                                    |   10=
=20
 fs/aio.c                                                           |    4=
=20
 fs/btrfs/dev-replace.c                                             |    2=
=20
 fs/btrfs/disk-io.c                                                 |    5=
=20
 fs/btrfs/extent-tree.c                                             |    1=
=20
 fs/btrfs/inode.c                                                   |   19=
=20
 fs/btrfs/tests/qgroup-tests.c                                      |    2=
=20
 fs/btrfs/transaction.c                                             |   10=
=20
 fs/btrfs/tree-log.c                                                |   75 =
+-
 fs/dcache.c                                                        |   22=
=20
 fs/ecryptfs/inode.c                                                |    3=
=20
 fs/ext2/namei.c                                                    |    6=
=20
 fs/ext4/namei.c                                                    |    6=
=20
 fs/ext4/super.c                                                    |   12=
=20
 fs/f2fs/checkpoint.c                                               |   71 +
 fs/f2fs/extent_cache.c                                             |    3=
=20
 fs/f2fs/file.c                                                     |    8=
=20
 fs/f2fs/namei.c                                                    |   12=
=20
 fs/fscache/page.c                                                  |   13=
=20
 fs/gfs2/bmap.c                                                     |   10=
=20
 fs/gfs2/file.c                                                     |    5=
=20
 fs/gfs2/quota.h                                                    |    2=
=20
 fs/jffs2/dir.c                                                     |   12=
=20
 fs/jfs/namei.c                                                     |   12=
=20
 fs/nilfs2/namei.c                                                  |    6=
=20
 fs/ocfs2/dlm/dlmdomain.c                                           |   14=
=20
 fs/ocfs2/dlm/dlmdomain.h                                           |   25=
=20
 fs/ocfs2/dlm/dlmrecovery.c                                         |    9=
=20
 fs/orangefs/namei.c                                                |    9=
=20
 fs/proc/proc_sysctl.c                                              |    3=
=20
 fs/reiserfs/namei.c                                                |   12=
=20
 fs/super.c                                                         |   30=
=20
 fs/udf/namei.c                                                     |    6=
=20
 fs/udf/super.c                                                     |    5=
=20
 fs/ufs/namei.c                                                     |    6=
=20
 fs/xfs/xfs_discard.c                                               |   14=
=20
 include/drm/drm_vblank.h                                           |    2=
=20
 include/linux/dcache.h                                             |    1=
=20
 include/rdma/ib_umem.h                                             |    1=
=20
 ipc/shm.c                                                          |   19=
=20
 kernel/audit.c                                                     |    2=
=20
 kernel/debug/kdb/kdb_main.c                                        |   27=
=20
 kernel/events/core.c                                               |   49 -
 kernel/irq/affinity.c                                              |   15=
=20
 kernel/rcu/tree_plugin.h                                           |   14=
=20
 kernel/sched/rt.c                                                  |    2=
=20
 kernel/sys.c                                                       |    2=
=20
 lib/radix-tree.c                                                   |    4=
=20
 lib/test_kasan.c                                                   |    8=
=20
 mm/kasan/kasan.c                                                   |   66 +
 mm/ksm.c                                                           |   28=
=20
 mm/page_idle.c                                                     |   12=
=20
 mm/slub.c                                                          |   57 -
 mm/swapfile.c                                                      |    4=
=20
 mm/vmscan.c                                                        |    8=
=20
 mm/z3fold.c                                                        |    9=
=20
 net/netlabel/netlabel_unlabeled.c                                  |   10=
=20
 net/rxrpc/call_event.c                                             |    2=
=20
 net/rxrpc/input.c                                                  |   15=
=20
 net/rxrpc/sendmsg.c                                                |    4=
=20
 net/smc/smc_ib.c                                                   |   10=
=20
 net/smc/smc_wr.h                                                   |    1=
=20
 security/integrity/ima/Kconfig                                     |    1=
=20
 security/integrity/ima/ima_crypto.c                                |    2=
=20
 security/integrity/ima/ima_main.c                                  |   13=
=20
 security/integrity/ima/ima_policy.c                                |    2=
=20
 security/selinux/hooks.c                                           |   20=
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
 tools/perf/builtin-stat.c                                          |    9=
=20
 tools/perf/builtin-top.c                                           |    6=
=20
 tools/perf/tests/dwarf-unwind.c                                    |   46 -
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
 tools/perf/util/mmap.c                                             |    6=
=20
 tools/testing/radix-tree/idr-test.c                                |    7=
=20
 tools/testing/selftests/Makefile                                   |    1=
=20
 tools/testing/selftests/net/fib-onlink-tests.sh                    |  375 =
++++++++++
 tools/testing/selftests/net/psock_fanout.c                         |    3=
=20
 tools/thermal/tmon/sysfs.c                                         |   12=
=20
 tools/thermal/tmon/tmon.c                                          |    1=
=20
 295 files changed, 3058 insertions(+), 1183 deletions(-)

Aapo Vienamo (1):
      ARM: dts: imx7d: cl-som-imx7: fix pinctrl_enet

Aaro Koskinen (1):
      drivers: macintosh: rack-meter: really fix bogus memsets

Al Viro (4):
      affs_lookup(): close a race with affs_remove_link()
      fix breakage caused by d_find_alias() semantics change
      aio: fix io_destroy(2) vs. lookup_ioctx() race
      do d_instantiate/unlock_new_inode combinations safely

Alexander Graf (1):
      lan78xx: Connect phy early

Alexander Shishkin (1):
      intel_th: Use correct method of finding hub

Alexandre Belloni (2):
      MIPS: xilfpga: Stop generating useless dtb.o
      MIPS: xilfpga: Actually include FDT in fitImage

Alexey Khoroshilov (3):
      watchdog: davinci_wdt: fix error handling in davinci_wdt_probe()
      watchdog: sprd_wdt: Fix error handling in sprd_wdt_enable()
      watchdog: asm9260_wdt: fix error handling in asm9260_wdt_probe()

Alistair Popple (1):
      powerpc/powernv/npu: Fix deadlock in mmio_invalidate()

Amitkumar Karwar (1):
      rsi: fix kernel panic observed on 64bit machine

Anand Jain (1):
      btrfs: fix null pointer deref when target device is missing

Andrea Parri (1):
      riscv/spinlock: Strengthen implementations with fences

Andreas Gruenbacher (2):
      gfs2: Check for the end of metadata in punch_hole
      gfs2: Fix fallocate chunk size

Andrey Konovalov (2):
      kasan: fix invalid-free test crashing the kernel
      kasan, slub: fix handling of kasan_slab_free hook

Andrey Ryabinin (1):
      mm/kasan: don't vfree() nonexistent vm_area

Anilkumar Kolli (1):
      ath10k: advertize beacon_int_min_gcd

Anshuman Khandual (1):
      powerpc/fscr: Enable interrupts earlier before calling get_user()

Archit Taneja (1):
      dt-bindings: display: msm/dsi: Fix the PHY regulator supply props

Arjun Vynipadath (2):
      cxgb4: Setup FW queues before registering netdev
      cxgb4: Fix queue free path of ULD drivers

Baoquan He (1):
      x86/apic: Set up through-local-APIC mode on the boot CPU if 'noapic' =
specified

Ben Hutchings (1):
      ALSA: timer: Fix pause event notification

Bjorn Andersson (2):
      soc: qcom: wcnss_ctrl: Fix increment in NV upload
      pinctrl: msm: Use dynamic GPIO numbering

Bob Moore (1):
      ACPICA: Fix memory leak on unusual memory leak

Brian Norris (1):
      watchdog: dw: RMW the control register

Carlos Maiolino (1):
      Force log to disk before reading the AGF during a fstrim

Chao Yu (3):
      f2fs: fix to set KEEP_SIZE bit in f2fs_zero_range
      f2fs: fix to clear CP_TRIMMED_FLAG
      f2fs: fix to check extent cache in f2fs_drop_extent_tree

Charles Keepax (1):
      regmap: Correct comparison in regmap_cached

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

Christophe Leroy (4):
      powerpc/mm/slice: Remove intermediate bitmap copy
      powerpc/mm/slice: create header files dedicated to slices
      powerpc/mm/slice: Enhance for supporting PPC32
      powerpc/mm/slice: Fix hugepage allocation at hint address on 8xx

Chunyu Hu (1):
      cpufreq: cppc_cpufreq: Fix cppc_cpufreq_init() failure path

Claudio Imbrenda (1):
      mm/ksm: fix interaction with THP

Colin Ian King (2):
      KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"
      net: qualcomm: rmnet: check for null ep to avoid null pointer derefer=
ence

Coly Li (3):
      bcache: quit dc->writeback_thread when BCACHE_DEV_DETACHING is set
      bcache: fix cached_dev->count usage for bch_cache_set_error()
      bcache: stop dc->writeback_rate_update properly

Cornelia Huck (1):
      vfio-ccw: fence off transport mode

Corneliu Doban (2):
      mmc: sdhci-iproc: fix 32bit writes for TRANSFER_MODE register
      mmc: sdhci-iproc: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for cygnus

Dan Carpenter (2):
      platform/x86: dell-smbios: Fix memory leaks in build_tokens_sysfs()
      xen/acpi: off by one in read_acpi_id()

Danilo Krummrich (1):
      fs/proc/proc_sysctl.c: fix potential page fault while unregistering s=
ysctl table

Dave Chinner (1):
      fs: don't scan the inode cache before SB_BORN is set

Dave Hansen (1):
      x86/mm: Do not forbid _PAGE_RW before init for __ro_after_init

David Ahern (1):
      selftests: Add FIB onlink tests

David Hildenbrand (3):
      kasan: free allocated shadow memory on MEM_CANCEL_ONLINE
      kasan: fix memory hotplug during boot
      KVM: s390: vsie: fix < 8k check for the itdba

David Howells (3):
      fscache: Fix hanging wait on page discarded by writeback
      rxrpc: Fix Tx ring annotation after initial Tx failure
      rxrpc: Don't treat call aborts as conn aborts

David S. Miller (1):
      sparc64: Make atomic_xchg() an inline function rather than a macro.

David Vrabel (1):
      x86/kvm: fix LAPIC timer drift when guest uses periodic mode

Davidlohr Bueso (3):
      Revert "ipc/shm: Fix shmat mmap nil-page protection"
      ipc/shm: fix shmat() nil address after round-down when remapping
      sched/rt: Fix rq->clock_update_flags < RQCF_ACT_SKIP warning

Deepak Rawat (1):
      drm/vmwgfx: Set dmabuf_size when vmw_dmabuf_init is successful

Dexuan Cui (1):
      tools: hv: fix compiler warnings about major/target_fname

Dhinakaran Pandiyan (1):
      drm/vblank: Data type fixes for 64-bit vblank sequences.

Emily Deng (1):
      drm/amdgpu: Clean sdma wptr register when only enable wptr polling

Eran Ben Elisha (1):
      net/mlx5e: Move all TX timeout logic to be under state lock

Eric Anholt (1):
      drm/panel: simple: Fix the bus format for the Ontat panel

Eric Sandeen (1):
      ext4: don't complain about incorrect features when probing

Erik Schmauss (1):
      ACPICA: Events: add a return on failure from acpi_hw_register_read

Esben Haabendal (1):
      dp83640: Ensure against premature access to PHY registers after reset

Filip Sadowski (1):
      i40e: Add delay after EMP reset for firmware to recover

Filipe Manana (2):
      Btrfs: fix loss of prealloc extents past i_size after fsync log replay
      Btrfs: fix copy_items() return value when logging an inode

Florian Fainelli (2):
      net: bgmac: Fix endian access in bgmac_dma_tx_ring_free()
      net: bgmac: Correctly annotate register space

Frank Asseg (1):
      tools/thermal: tmon: fix for segfault

Fuyun Liang (3):
      net: hns3: fix for the wrong shift problem in hns3_set_txbd_baseinfo
      net: hns3: fix for returning wrong value problem in hns3_get_rss_indi=
r_size
      net: hns3: fix for returning wrong value problem in hns3_get_rss_key_=
size

Gao Xiang (1):
      f2fs: flush cp pack except cp pack 2 page at first

Geert Uytterhoeven (1):
      dmaengine: rcar-dmac: Fix too early/late system suspend/resume callba=
cks

Govindarajulu Varadarajan (1):
      enic: enable rq before updating rq descriptors

Greg Kroah-Hartman (1):
      Linux 4.16.13

Greg Ungerer (1):
      m68k: set dma and coherent masks for platform FEC ethernets

Gregory CLEMENT (1):
      i2c: mv64xxx: Apply errata delay only in standard mode

Guenter Roeck (3):
      hwmon: (nct6775) Fix writing pwmX_mode
      hwmon: (pmbus/max8688) Accept negative page register values
      hwmon: (pmbus/adm1275) Accept negative page register values

Gustavo A. R. Silva (1):
      kernel/sys.c: fix potential Spectre v1 issue

Haiyang Zhang (1):
      hv_netvsc: Fix the return status in RX path

Harry Morris (1):
      ieee802154: ca8210: fix uninitialised data read

Heiner Kallweit (1):
      soc: amlogic: meson-gx-pwrc-vpu: fix error on shutdown when domain is=
 powered off

Helge Deller (1):
      parisc/pci: Switch LBA PCI bus from Hard Fail to Soft Fail mode

Henry Zhang (1):
      ARM: dts: bcm283x: Fix pin function of JTAG pins

Honggang Li (1):
      IB/mlx5: Set the default active rate and width to QDR and 4X

Huang Ying (1):
      mm: fix races between address_space dereference and free in page_evic=
atable

Icenowy Zheng (1):
      dt-bindings: add device tree binding for Allwinner H6 main CCU

Ilia Lin (1):
      arm64: dts: qcom: Fix SPI5 config on MSM8996

Ivan Gorinov (2):
      x86/devicetree: Initialize device tree before using it
      x86/devicetree: Fix device IRQ settings in DT

Jacob Keller (2):
      i40e: hold the RTNL lock while changing interrupt schemes
      ixgbe: prevent ptp_rx_hang from running when in FILTER_ALL mode

Jake Moroni (1):
      dpaa_eth: fix pause capability advertisement logic

James Smart (2):
      nvme: expand nvmf_check_if_ready checks
      nvme_fc: fix abort race on teardown with lld reject

Jan Kara (1):
      udf: Provide saner default for invalid uid / gid

Jan Kundr=C3=A1t (1):
      pinctrl: mcp23s08: spi: Fix regmap debugfs entries

Jaros=C5=82aw Janik (1):
      nvme-pci: disable APST for Samsung NVMe SSD 960 EVO + ASUS PRIME Z370=
-A

Jason A. Donenfeld (1):
      arm64: export tishift functions to modules

Jay Vosburgh (1):
      virtio-net: Fix operstate for virtio when no VIRTIO_NET_F_STATUS

Jean Delvare (1):
      firmware: dmi_scan: Fix UUID length safety check

Jeff Mahoney (1):
      btrfs: fix lockdep splat in btrfs_alloc_subvolume_writers

Jens Axboe (2):
      sr: pass down correctly sized SCSI sense buffer
      sr: get/drop reference to device in revalidate and check_events

Jiandi An (1):
      ima: Fix Kconfig to select TPM 2.0 CRB interface

Jim Mattson (1):
      kvm: x86: IA32_ARCH_CAPABILITIES is always supported

Jin Yao (1):
      perf report: Fix wrong jump arrow

Jiri Olsa (3):
      perf tests: Use arch__compare_symbol_names to compare symbols
      perf report: Fix memory corruption in --branch-history mode --branch-=
history
      perf tests: Fix dwarf unwind for stripped binaries

Joe Jin (1):
      xen-swiotlb: fix the check condition for xen_swiotlb_free_coherent

Joe Perches (1):
      MIPS: Octeon: Fix logging messages with spurious periods after newlin=
es

Joerg Roedel (1):
      x86/pgtable: Don't set huge PUD/PMD on non-leaf entries

Johannes Thumshirn (1):
      nvme: don't send keep-alives to the discovery controller

John Allen (1):
      ibmvnic: Fix reset return from closed state

Jun Piao (1):
      ocfs2/dlm: don't handle migrate lockres if already in shutdown

Kamlakant Patel (1):
      ipmi_ssif: Fix kernel panic at msg_done_handler

Kan Liang (4):
      perf mmap: Fix accessing unmapped mmap in perf_mmap__read_done()
      perf/x86/intel: Properly save/restore the PMU state in the NMI handler
      perf/x86/intel: Fix large period handling on Broadwell CPUs
      perf/x86/intel: Fix event update for auto-reload

Karthikeyan Periyasamy (1):
      ath10k: Fix kernel panic while using worker (ath10k_sta_rc_update_wk)

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

Lidong Chen (1):
      IB/umem: Use the correct mm during ib_umem_release

Linus Walleij (1):
      drm/bridge: sii902x: Retry status read after DDI I2C

Liu Bo (3):
      Btrfs: clean up resources during umount after trans is aborted
      Btrfs: bail out on error during replay_dir_deletes
      Btrfs: fix NULL pointer dereference in log_dir_items

Lorenzo Bianconi (2):
      mt76x2: fix possible NULL pointer dereferencing in mt76x2_tx()
      mt76x2: fix warning in ieee80211_get_key_rx_seq()

Luca Coelho (1):
      iwlwifi: mvm: check if mac80211_queue is valid in iwl_mvm_disable_txq

Luis R. Rodriguez (1):
      firmware: fix checking for return values for fw_add_devm_name()

Maciej W. Rozycki (2):
      MIPS: ptrace: Expose FIR register through FP regset
      MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32=
 FGRs

Madalin Bucur (1):
      dpaa_eth: fix SG mapping

Madhavan Srinivasan (1):
      powerpc/perf: Prevent kernel address leak to userspace via BHRB buffer

Marc Dionne (1):
      rxrpc: Fix resend event time calculation

Mark Rutland (1):
      efi/arm*: Only register page tables when they exist

Mathias Kresin (1):
      MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset

Mathieu Malaterre (2):
      mmc: block: propagate correct returned value in mmc_rpmb_ioctl
      powerpc: Add missing prototype for arch_irq_work_raise()

Matthew Wilcox (1):
      idr: fix invalid ptr dereference on item delete

Maurizio Lombardi (1):
      cdrom: do not call check_disk_change() inside cdrom_open()

Michael Ellerman (3):
      powerpc/mpic: Check if cpu_possible() in mpic_physmask()
      powerpc/perf: Fix kernel address leak via sampling registers
      selftests: Print the test we're running to /dev/kmsg

Michael J. Ruhl (1):
      IB/hfi1: Use after free race condition in send context error path

Michael Neuling (1):
      powerpc/64s: Clear PCR on boot

Michael Schmitz (1):
      zorro: Set up z->dev.dma_mask for the DMA API

Mika Westerberg (1):
      ahci: Add PCI ID for Cannon Lake PCH-LP AHCI

Mikhail Malygin (1):
      IB/rxe: Fix for oops in rxe_register_device on ppc64le arch

Milton Miller (2):
      watchdog: aspeed: Allow configuring for alternate boot
      watchdog: aspeed: Fix translation of reset mode to ctrl register

Mimi Zohar (1):
      ima: clear IMA_HASH

Ming Lei (1):
      block: null_blk: fix 'Invalid parameters' when loading module

Monk Liu (2):
      drm/amdgpu: disable GFX ring and disable PQ wptr in hw_fini
      drm/amdgpu: adjust timeout for ib_ring_tests(v2)

NeilBrown (1):
      MIPS: c-r4k: Fix data corruption related to cache coherence

Nicholas Piggin (2):
      powerpc/64s/idle: Fix restore of AMOR on POWER9 after deep sleep
      powerpc/64s: sreset panic if there is no debugger or crash dump handl=
ers

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

Omar Sandoval (1):
      Btrfs: fix error handling in btrfs_truncate()

Parav Pandit (1):
      IB/core: Honor port_num while resolving GID for IB link layer

Pascal Roeleven (1):
      ARM: dts: sun4i: Fix incorrect clocks for displays

Paul Cercueil (1):
      MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4770

Peter Rosin (2):
      ARM: dts: at91: nattis: use the correct compatible for the eeprom
      ARM: dts: at91: tse850: use the correct compatible for the eeprom

Peter Zijlstra (1):
      perf/core: Fix perf_output_read_group()

Petr Vorel (1):
      ima: Fallback to the builtin hash algorithm

Philipp Puschmann (1):
      arm: dts: socfpga: fix GIC PPI warning

Pierre Bourdon (1):
      max17042: propagate of_node to power supply device

Prashant Bhole (1):
      selftests/net: fixes psock_fanout eBPF test case

Qi Hou (1):
      dmaengine: pl330: fix a race condition in case of threaded irqs

Qu Wenruo (2):
      btrfs: tests/qgroup: Fix wrong tree backref level
      btrfs: qgroup: Fix root item corruption when multiple same source sna=
pshots are created with quota enabled

Rafael J. Wysocki (3):
      PM / core: Fix direct_complete handling for devices with no callbacks
      PCI: Restore config space on runtime resume despite being unbound
      PCMCIA / PM: Avoid noirq suspend aborts during suspend-to-idle

Rafa=C5=82 Mi=C5=82ecki (1):
      bcma: fix buffer size caused crash in bcma_core_mips_print_irq()

Randy Dunlap (1):
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

Sai Praneeth (1):
      x86/mm: Fix bogus warning during EFI bootup, use boot_cpu_has() inste=
ad of this_cpu_has() in build_cr3_noflush()

Sandipan Das (2):
      perf tools: Fix perf builds with clang support
      perf clang: Add support for recent clang versions

Sara Sharon (1):
      iwlwifi: mvm: take RCU lock before dereferencing

Scott Branden (1):
      bnxt_en: fix clear flags in ethtool reset handling

Sean Christopherson (1):
      KVM: VMX: raise internal error for exception during invalid protected=
 mode state

Sebastian Andrzej Siewior (1):
      iommu/amd: Take into account that alloc_dev_data() may return NULL

Sebastian Gottschall (1):
      ath9k: fix crash in spectral scan

Sergei Shtylyov (4):
      sh_eth: fix TSU init on SH7734/R8A7740
      soc: renesas: r8a77970-sysc: fix power area parents
      drm: rcar-du: lvds: Fix LVDS startup on R-Car Gen3
      drm: rcar-du: lvds: Fix LVDS startup on R-Car Gen2

Seunghun Han (1):
      ACPICA: acpi: acpica: fix acpi operand cache leak in nseval.c

Shawn Lin (1):
      phy: rockchip-emmc: retry calpad busy trimming

Shunyong Yang (1):
      cpufreq: CPPC: Initialize shared perf capabilities of CPUs

Sriharsha Basavapatna (1):
      bnxt_en: Ignore src port field in decap filter nodes

Srinath Mannam (1):
      mmc: sdhci-iproc: remove hard coded mmc cap 1.8v

Srinivas Kandagatla (1):
      dmaengine: qcom: bam_dma: get num-channels and num-ees from dt

Stefan Wahren (2):
      ARM: dts: bcm283x: Fix probing of bcm2835-i2s
      hwrng: bcm2835 - Handle deferred clock properly

Sudip Mukherjee (1):
      libata: blacklist Micron 500IT SSD with MU01 firmware

Sukadev Bhattiprolu (1):
      powerpc/vas: Fix cleanup when VAS is not configured

Suman Anna (1):
      ARM: dts: keystone-k2e-clocks: Fix missing unit address separator

Takashi Iwai (1):
      ALSA: vmaster: Propagate slave error

Takeshi Kihara (1):
      pinctrl: sh-pfc: r8a7796: Fix MOD_SEL register pin assignment for SSI=
 pins group

Tao (1):
      drm/amd/display: Set vsc pack revision when DPCD revision is >=3D 1.2

Tejun Heo (2):
      libata: Blacklist some Sandisk SSDs for NCQ
      rcu: Call touch_nmi_watchdog() while printing stall warnings

Thomas Falcon (2):
      ibmvnic: Zero used TX descriptor counter on reset
      ibmvnic: Allocate statistics buffers during probe

Thomas Gleixner (1):
      genirq/affinity: Don't return with empty affinity masks on error

Thomas Hellstrom (2):
      drm/vmwgfx: Fix 32-bit VMW_PORT_HB_[IN|OUT] macros
      drm/vmwgfx: Unpin the screen object backup buffer when not used

Thomas Richter (2):
      perf stat: Fix core dump when flag T is used
      perf test: Fix test case inet_pton to accept inlines.

Thomas Vincent-Cross (1):
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9220

Tom Abraham (1):
      swap: divide-by-zero when zero length swap file on ssd

Ursula Braun (1):
      net/smc: pay attention to MAX_ORDER for CQ entries

Vaibhav Jain (1):
      cxl: Check if PSL data-cache is available before issue flush request

Viresh Kumar (1):
      cpufreq: Reorder cpufreq_online() error code path

Vitaly Kuznetsov (1):
      KVM: lapic: stop advertising DIRECTED_EOI when in-kernel IOAPIC is in=
 use

Vivek Gautam (1):
      phy: qcom-qmp: Fix phy pipe clock gating

Wei Huang (1):
      KVM: x86: Update cpuid properly when CR4.OSXAVE or CR4.PKE is changed

Will Deacon (1):
      arm64: lse: Add early clobbers to some input/output asm operands

Xidong Wang (1):
      z3fold: fix memory leak

Yang Shi (1):
      mm: thp: fix potential clearing to referenced flag in page_idle_clear=
_pte_refs_one()

Yisheng Xie (1):
      perf top: Fix top.call-graph config option reading

Yong Wu (1):
      iommu/mediatek: Fix protect memory setting

Yoshihiro Shimoda (1):
      dmaengine: rcar-dmac: Check the done lists in rcar_dmac_chan_get_resi=
due()

leilei.lin (1):
      perf/core: Fix installing cgroup events on CPU

lionel.debieve@st.com (1):
      hwrng: stm32 - add reset during probe

=C3=98rjan Eide (1):
      drm/rockchip: Respect page offset for PRIME mmap calls


--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsOU+IACgkQONu9yGCS
aT420xAAscD6sHynfHwvHUzk/XcjMLwBAJrIgateWmeQWUmFYaZMtCZsJMEkCvDu
nUs16N7b9IpT5Ro/JL439ZGvrFIOQSKgSXIEGGWmWQcSKBwt7myY+0CmJBhXueJM
05G2effFPXCmbxZp4YMozYTUNoyFXQIATgjwyFEjwA77pgnKYblNpNAT90r4lq/g
MZt6CL5+QtsIsuX5UcmrhtloI35f23QJV003yQ4L+Co/ScTM4bwK20/qWgI8K83C
Lxhx6ADWQaYRRXdlS1uY5jNja2qdrgM2CtNjt5/R6/PEFFGtYIJrqbTY+4qJAQp1
GQMadE1W9p4T6y3BO5IZ7SGIwgvANC2I8deZlPaKnICdWxtx+I817pu5W7bE4Ib9
n9Zvi8z9ioIuQV96yzUN1jNwBulAZqgBnfc9S/zV/A+/HM9wBCjWc4Q9pFpVNsCT
c+y0g1Yy7WLCquL/ffkNZ+SM4r2c3CUjXVD3nam8/rqW5s6LnN+OqFsw8wEucnFL
qcc46z1muMDS4nTubEjXihSnAYJvN2dab1V256lggcJyjk+4SLCGr5/xWYtJPTED
+fGsyPNHIqSYyOpO24RObaXH2WcRZMDiXaFiEH0jOSOjxEiLxcJY1FZYhndkJ0Lh
Ol7YqNqsqTk0P3yH+AdK9CkSNpUYh7dvHj8LDCnGBy1NSKqOVoY=
=1THS
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
