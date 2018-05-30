Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935605AbeE3HeD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964780AbeE3Hd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:33:26 -0400
Date: Wed, 30 May 2018 09:33:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.104
Message-ID: <20180530073302.GA22629@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.104 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/device-mapper/thin-provisioning.txt                  |    8=
=20
 Documentation/devicetree/bindings/dma/mv-xor-v2.txt                |    6=
=20
 Makefile                                                           |    2=
=20
 arch/alpha/include/asm/xchg.h                                      |   30=
=20
 arch/arc/Kconfig                                                   |    1=
=20
 arch/arm/boot/dts/bcm283x.dtsi                                     |    4=
=20
 arch/arm/boot/dts/bcm958625hr.dts                                  |    2=
=20
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts                            |   52=
=20
 arch/arm/boot/dts/r8a7791-porter.dts                               |    2=
=20
 arch/arm/boot/dts/socfpga.dtsi                                     |    2=
=20
 arch/arm/include/asm/vdso.h                                        |    2=
=20
 arch/arm/kernel/vdso.c                                             |   12=
=20
 arch/arm/mach-omap1/clock.c                                        |    6=
=20
 arch/arm/mach-omap2/pm.c                                           |    4=
=20
 arch/arm/mach-omap2/timer.c                                        |   19=
=20
 arch/arm/mach-orion5x/Kconfig                                      |    3=
=20
 arch/arm/mach-orion5x/dns323-setup.c                               |   53=
=20
 arch/arm/mach-orion5x/tsx09-common.c                               |   49=
=20
 arch/arm/plat-omap/dmtimer.c                                       |    7=
=20
 arch/arm64/boot/dts/qcom/msm8996.dtsi                              |    4=
=20
 arch/arm64/include/asm/spinlock.h                                  |    4=
=20
 arch/arm64/include/asm/stacktrace.h                                |    2=
=20
 arch/arm64/kernel/cpu_errata.c                                     |    4=
=20
 arch/arm64/kernel/stacktrace.c                                     |    5=
=20
 arch/arm64/kernel/time.c                                           |    2=
=20
 arch/ia64/kernel/err_inject.c                                      |    2=
=20
 arch/m68k/coldfire/device.c                                        |   12=
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
 arch/mips/txx9/rbtx4939/setup.c                                    |    4=
=20
 arch/powerpc/boot/Makefile                                         |    3=
=20
 arch/powerpc/include/asm/irq_work.h                                |    1=
=20
 arch/powerpc/kvm/book3s_hv.c                                       |   12=
=20
 arch/powerpc/mm/numa.c                                             |   78=
=20
 arch/powerpc/net/bpf_jit_comp.c                                    |    3=
=20
 arch/powerpc/perf/core-book3s.c                                    |   25=
=20
 arch/powerpc/sysdev/mpic.c                                         |    2=
=20
 arch/s390/kvm/vsie.c                                               |    2=
=20
 arch/sh/kernel/entry-common.S                                      |    2=
=20
 arch/sparc/include/asm/atomic_64.h                                 |    6=
=20
 arch/sparc/include/asm/pgtable_64.h                                |    2=
=20
 arch/sparc/mm/tlb.c                                                |   23=
=20
 arch/x86/events/core.c                                             |   15=
=20
 arch/x86/events/intel/core.c                                       |   12=
=20
 arch/x86/events/intel/ds.c                                         |  117 +
 arch/x86/events/perf_event.h                                       |    2=
=20
 arch/x86/include/asm/i8259.h                                       |    5=
=20
 arch/x86/kernel/apic/apic.c                                        |    2=
=20
 arch/x86/kernel/devicetree.c                                       |   21=
=20
 arch/x86/kernel/smpboot.c                                          |    1=
=20
 arch/x86/kernel/tsc.c                                              |   18=
=20
 arch/x86/kvm/cpuid.c                                               |    7=
=20
 arch/x86/kvm/lapic.c                                               |   10=
=20
 arch/x86/kvm/vmx.c                                                 |   20=
=20
 arch/x86/kvm/x86.c                                                 |   12=
=20
 arch/x86/mm/init_64.c                                              |    3=
=20
 arch/x86/mm/pageattr.c                                             |    6=
=20
 arch/x86/mm/pgtable.c                                              |    9=
=20
 arch/x86/power/hibernate_32.c                                      |    2=
=20
 arch/x86/power/hibernate_64.c                                      |    2=
=20
 crypto/asymmetric_keys/pkcs7_trust.c                               |    1=
=20
 drivers/acpi/acpi_pad.c                                            |    3=
=20
 drivers/acpi/acpica/evevent.c                                      |    9=
=20
 drivers/acpi/acpica/nseval.c                                       |    8=
=20
 drivers/acpi/processor_perflib.c                                   |    2=
=20
 drivers/acpi/scan.c                                                |   20=
=20
 drivers/ata/libata-core.c                                          |    6=
=20
 drivers/ata/libata-scsi.c                                          |    2=
=20
 drivers/base/regmap/regmap.c                                       |    2=
=20
 drivers/block/paride/pcd.c                                         |    2=
=20
 drivers/cdrom/cdrom.c                                              |    3=
=20
 drivers/cdrom/gdrom.c                                              |    3=
=20
 drivers/char/hw_random/stm32-rng.c                                 |    9=
=20
 drivers/char/ipmi/ipmi_powernv.c                                   |    5=
=20
 drivers/char/ipmi/ipmi_ssif.c                                      |    4=
=20
 drivers/clocksource/fsl_ftm_timer.c                                |    2=
=20
 drivers/cpufreq/cppc_cpufreq.c                                     |   23=
=20
 drivers/cpufreq/cpufreq.c                                          |    6=
=20
 drivers/dma/mv_xor_v2.c                                            |   25=
=20
 drivers/dma/pl330.c                                                |    6=
=20
 drivers/dma/qcom/bam_dma.c                                         |   27=
=20
 drivers/dma/sh/rcar-dmac.c                                         |   11=
=20
 drivers/firewire/ohci.c                                            |    8=
=20
 drivers/firmware/dmi_scan.c                                        |   22=
=20
 drivers/gpu/drm/exynos/exynos_drm_g2d.c                            |    6=
=20
 drivers/gpu/drm/exynos/regs-fimc.h                                 |    2=
=20
 drivers/gpu/drm/imx/ipuv3-crtc.c                                   |    5=
=20
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/gf100.fuc3.h           |  746 =
+++----
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/gk208.fuc5.h           |  802 =
+++----
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/gt215.fuc3.h           | 1006 =
+++++-----
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/memx.fuc               |   30=
=20
 drivers/gpu/drm/panel/panel-simple.c                               |    2=
=20
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                        |    7=
=20
 drivers/gpu/drm/sun4i/sun4i_dotclock.c                             |    5=
=20
 drivers/gpu/drm/virtio/virtgpu_ioctl.c                             |   17=
=20
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.h                                |   25=
=20
 drivers/hid/hid-roccat-kovaplus.c                                  |    2=
=20
 drivers/hwmon/nct6775.c                                            |   10=
=20
 drivers/hwmon/pmbus/adm1275.c                                      |    4=
=20
 drivers/hwmon/pmbus/max8688.c                                      |    2=
=20
 drivers/i2c/busses/i2c-mv64xxx.c                                   |    8=
=20
 drivers/ide/ide-cd.c                                               |    2=
=20
 drivers/infiniband/core/multicast.c                                |   26=
=20
 drivers/infiniband/core/sa_query.c                                 |    7=
=20
 drivers/infiniband/core/ucma.c                                     |    2=
=20
 drivers/infiniband/hw/hfi1/chip.c                                  |    4=
=20
 drivers/infiniband/hw/i40iw/i40iw_verbs.c                          |    1=
=20
 drivers/infiniband/hw/mlx4/main.c                                  |   11=
=20
 drivers/infiniband/hw/mlx5/qp.c                                    |    9=
=20
 drivers/infiniband/hw/qedr/main.c                                  |    3=
=20
 drivers/infiniband/hw/qedr/verbs.c                                 |   38=
=20
 drivers/infiniband/ulp/ipoib/ipoib_main.c                          |    3=
=20
 drivers/input/mouse/psmouse-base.c                                 |   34=
=20
 drivers/iommu/intel-iommu.c                                        |    3=
=20
 drivers/irqchip/irq-gic-v3-its-pci-msi.c                           |    2=
=20
 drivers/irqchip/irq-gic-v3-its-platform-msi.c                      |    2=
=20
 drivers/irqchip/irq-gic-v3-its.c                                   |    2=
=20
 drivers/irqchip/irq-gic-v3.c                                       |    2=
=20
 drivers/macintosh/rack-meter.c                                     |    4=
=20
 drivers/md/bcache/alloc.c                                          |    4=
=20
 drivers/md/bcache/bcache.h                                         |    2=
=20
 drivers/md/bcache/btree.c                                          |    9=
=20
 drivers/md/bcache/request.c                                        |    2=
=20
 drivers/md/bcache/super.c                                          |   23=
=20
 drivers/md/bcache/sysfs.c                                          |   11=
=20
 drivers/md/bcache/writeback.c                                      |   27=
=20
 drivers/md/md.c                                                    |   13=
=20
 drivers/md/raid1.c                                                 |   11=
=20
 drivers/md/raid10.c                                                |   14=
=20
 drivers/md/raid5.c                                                 |   15=
=20
 drivers/mmc/host/sdhci-iproc.c                                     |   31=
=20
 drivers/net/ethernet/broadcom/bgmac.c                              |    3=
=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                          |    3=
=20
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c                    |   11=
=20
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c                     |    1=
=20
 drivers/net/ethernet/cisco/enic/enic_main.c                        |   10=
=20
 drivers/net/ethernet/freescale/fman/fman_dtsec.c                   |    2=
=20
 drivers/net/ethernet/freescale/gianfar.c                           |   16=
=20
 drivers/net/ethernet/ibm/ibmvnic.c                                 |    1=
=20
 drivers/net/ethernet/intel/e1000e/ich8lan.c                        |    2=
=20
 drivers/net/ethernet/intel/e1000e/mac.c                            |    2=
=20
 drivers/net/ethernet/intel/e1000e/netdev.c                         |    4=
=20
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c                    |   14=
=20
 drivers/net/ethernet/marvell/mvneta.c                              |    1=
=20
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                      |    2=
=20
 drivers/net/ethernet/qualcomm/emac/emac-mac.c                      |   23=
=20
 drivers/net/ethernet/smsc/smsc911x.c                               |    4=
=20
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c                |    6=
=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                  |   14=
=20
 drivers/net/ethernet/sun/sunvnet.c                                 |    2=
=20
 drivers/net/macvlan.c                                              |    2=
=20
 drivers/net/phy/dp83640.c                                          |   18=
=20
 drivers/net/usb/qmi_wwan.c                                         |    1=
=20
 drivers/net/usb/r8152.c                                            |    2=
=20
 drivers/net/usb/smsc75xx.c                                         |    7=
=20
 drivers/net/virtio_net.c                                           |    2=
=20
 drivers/net/wireless/ath/ath10k/mac.c                              |   10=
=20
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c        |    2=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                  |    4=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c                        |   28=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                      |   39=
=20
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                        |    7=
=20
 drivers/net/wireless/mac80211_hwsim.c                              |    4=
=20
 drivers/net/xen-netfront.c                                         |   46=
=20
 drivers/ntb/ntb_transport.c                                        |    3=
=20
 drivers/nvme/host/fabrics.c                                        |    4=
=20
 drivers/nvme/host/pci.c                                            |    5=
=20
 drivers/nvme/target/core.c                                         |    9=
=20
 drivers/parisc/lba_pci.c                                           |   20=
=20
 drivers/pci/pci-driver.c                                           |   17=
=20
 drivers/pci/quirks.c                                               |    5=
=20
 drivers/pinctrl/qcom/pinctrl-msm.c                                 |    2=
=20
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c                               |   40=
=20
 drivers/regulator/gpio-regulator.c                                 |   16=
=20
 drivers/regulator/of_regulator.c                                   |    1=
=20
 drivers/s390/cio/device_fsm.c                                      |    7=
=20
 drivers/s390/cio/device_ops.c                                      |   72=
=20
 drivers/s390/cio/io_sch.h                                          |    1=
=20
 drivers/scsi/sr.c                                                  |   21=
=20
 drivers/soc/qcom/wcnss_ctrl.c                                      |    2=
=20
 drivers/spi/spi-bcm-qspi.c                                         |    4=
=20
 drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c             |    2=
=20
 drivers/video/fbdev/sbuslib.c                                      |    4=
=20
 drivers/watchdog/f71808e_wdt.c                                     |    3=
=20
 drivers/watchdog/sbsa_gwdt.c                                       |    3=
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
 drivers/zorro/zorro.c                                              |   12=
=20
 fs/affs/namei.c                                                    |   10=
=20
 fs/aio.c                                                           |    4=
=20
 fs/btrfs/ctree.c                                                   |   12=
=20
 fs/btrfs/disk-io.c                                                 |    8=
=20
 fs/btrfs/extent-tree.c                                             |    1=
=20
 fs/btrfs/file.c                                                    |    9=
=20
 fs/btrfs/inode.c                                                   |   16=
=20
 fs/btrfs/raid56.c                                                  |   18=
=20
 fs/btrfs/send.c                                                    |    3=
=20
 fs/btrfs/tests/qgroup-tests.c                                      |    2=
=20
 fs/btrfs/tree-log.c                                                |   12=
=20
 fs/btrfs/volumes.c                                                 |    9=
=20
 fs/ceph/super.c                                                    |   16=
=20
 fs/cifs/cifssmb.c                                                  |    4=
=20
 fs/dcache.c                                                        |   32=
=20
 fs/ecryptfs/inode.c                                                |    3=
=20
 fs/ext2/namei.c                                                    |    6=
=20
 fs/ext4/namei.c                                                    |    6=
=20
 fs/f2fs/extent_cache.c                                             |    3=
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
 fs/jffs2/fs.c                                                      |    1=
=20
 fs/jfs/namei.c                                                     |   12=
=20
 fs/nfs/nfs4proc.c                                                  |   12=
=20
 fs/nfs/nfs4state.c                                                 |    5=
=20
 fs/nfs/nfs4sysctl.c                                                |    2=
=20
 fs/nilfs2/namei.c                                                  |    6=
=20
 fs/ocfs2/acl.c                                                     |    6=
=20
 fs/ocfs2/dlm/dlmdomain.c                                           |   14=
=20
 fs/ocfs2/dlm/dlmdomain.h                                           |   25=
=20
 fs/ocfs2/dlm/dlmrecovery.c                                         |    9=
=20
 fs/ocfs2/journal.c                                                 |   23=
=20
 fs/ocfs2/super.c                                                   |    5=
=20
 fs/ocfs2/xattr.c                                                   |    2=
=20
 fs/orangefs/namei.c                                                |    9=
=20
 fs/proc/base.c                                                     |   29=
=20
 fs/proc/kcore.c                                                    |    4=
=20
 fs/proc/proc_sysctl.c                                              |    3=
=20
 fs/reiserfs/namei.c                                                |   12=
=20
 fs/udf/namei.c                                                     |    6=
=20
 fs/udf/super.c                                                     |    5=
=20
 fs/ufs/namei.c                                                     |    6=
=20
 fs/xfs/xfs_discard.c                                               |   14=
=20
 include/asm-generic/pgtable.h                                      |   15=
=20
 include/linux/cpumask.h                                            |    2=
=20
 include/linux/dcache.h                                             |    1=
=20
 include/linux/kcore.h                                              |    1=
=20
 include/linux/kvm_host.h                                           |    3=
=20
 include/linux/property.h                                           |   10=
=20
 include/linux/ptr_ring.h                                           |    2=
=20
 include/linux/suspend.h                                            |    2=
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
 include/trace/events/timer.h                                       |   20=
=20
 include/uapi/drm/virtgpu_drm.h                                     |    1=
=20
 include/uapi/linux/if_ether.h                                      |    1=
=20
 ipc/shm.c                                                          |   19=
=20
 kernel/audit.c                                                     |    2=
=20
 kernel/debug/kdb/kdb_main.c                                        |   27=
=20
 kernel/events/core.c                                               |   24=
=20
 kernel/locking/qspinlock.c                                         |    8=
=20
 kernel/power/power.h                                               |    3=
=20
 kernel/rcu/tree_plugin.h                                           |   14=
=20
 kernel/relay.c                                                     |    2=
=20
 kernel/sched/rt.c                                                  |    2=
=20
 kernel/signal.c                                                    |    4=
=20
 kernel/sys.c                                                       |    1=
=20
 kernel/workqueue.c                                                 |    2=
=20
 lib/test_bpf.c                                                     |   31=
=20
 mm/fadvise.c                                                       |   10=
=20
 mm/huge_memory.c                                                   |    5=
=20
 mm/kasan/kasan.c                                                   |    2=
=20
 mm/khugepaged.c                                                    |   20=
=20
 mm/kmemleak.c                                                      |   12=
=20
 mm/ksm.c                                                           |   28=
=20
 mm/mempolicy.c                                                     |   36=
=20
 mm/swapfile.c                                                      |    4=
=20
 mm/vmscan.c                                                        |   22=
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
 net/batman-adv/gateway_client.c                                    |    3=
=20
 net/batman-adv/multicast.c                                         |    8=
=20
 net/batman-adv/routing.c                                           |   15=
=20
 net/batman-adv/soft-interface.c                                    |    8=
=20
 net/bridge/netfilter/ebtables.c                                    |   33=
=20
 net/core/skbuff.c                                                  |    9=
=20
 net/ipv4/ip_vti.c                                                  |    2=
=20
 net/ipv4/route.c                                                   |   26=
=20
 net/ipv4/tcp_illinois.c                                            |    2=
=20
 net/ipv4/tcp_nv.c                                                  |    2=
=20
 net/ipv4/xfrm4_policy.c                                            |    1=
=20
 net/ipv6/ip6_tunnel.c                                              |   12=
=20
 net/ipv6/netfilter/nf_conntrack_reasm.c                            |   16=
=20
 net/ipv6/sit.c                                                     |    7=
=20
 net/llc/llc_c_ac.c                                                 |   15=
=20
 net/llc/llc_conn.c                                                 |   32=
=20
 net/mac80211/rx.c                                                  |    2=
=20
 net/mac80211/spectmgmt.c                                           |    7=
=20
 net/mac80211/sta_info.c                                            |    3=
=20
 net/netlabel/netlabel_unlabeled.c                                  |   10=
=20
 net/nfc/llcp_commands.c                                            |    4=
=20
 net/nfc/netlink.c                                                  |    3=
=20
 net/openvswitch/conntrack.c                                        |   34=
=20
 net/qrtr/smd.c                                                     |    1=
=20
 net/rds/ib.c                                                       |    3=
=20
 net/rxrpc/input.c                                                  |   15=
=20
 net/rxrpc/recvmsg.c                                                |    5=
=20
 net/rxrpc/sendmsg.c                                                |    4=
=20
 scripts/adjust_autoksyms.sh                                        |    7=
=20
 scripts/kconfig/expr.c                                             |    2=
=20
 scripts/kconfig/menu.c                                             |    1=
=20
 scripts/kconfig/zconf.y                                            |   33=
=20
 scripts/package/builddeb                                           |    2=
=20
 security/integrity/digsig.c                                        |    1=
=20
 security/integrity/ima/ima_crypto.c                                |    2=
=20
 security/integrity/ima/ima_main.c                                  |   13=
=20
 sound/core/timer.c                                                 |    4=
=20
 sound/core/vmaster.c                                               |    5=
=20
 sound/pci/hda/Kconfig                                              |    1=
=20
 sound/pci/hda/patch_realtek.c                                      |    5=
=20
 tools/lib/bpf/libbpf.c                                             |   26=
=20
 tools/lib/traceevent/event-parse.c                                 |   17=
=20
 tools/lib/traceevent/parse-filter.c                                |   10=
=20
 tools/perf/arch/x86/util/header.c                                  |    2=
=20
 tools/perf/builtin-stat.c                                          |    9=
=20
 tools/perf/builtin-top.c                                           |    6=
=20
 tools/perf/tests/vmlinux-kallsyms.c                                |    2=
=20
 tools/perf/util/evsel.c                                            |    8=
=20
 tools/perf/util/hist.c                                             |    4=
=20
 tools/perf/util/hist.h                                             |    1=
=20
 tools/testing/selftests/Makefile                                   |    1=
=20
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc |   46=
=20
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc |   97=
=20
 tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc         |   43=
=20
 tools/testing/selftests/memfd/config                               |    1=
=20
 tools/testing/selftests/net/psock_fanout.c                         |    3=
=20
 tools/testing/selftests/net/reuseport_bpf.c                        |   21=
=20
 tools/testing/selftests/powerpc/mm/subpage_prot.c                  |   14=
=20
 tools/testing/selftests/pstore/config                              |    1=
=20
 tools/thermal/tmon/sysfs.c                                         |   12=
=20
 tools/thermal/tmon/tmon.c                                          |    1=
=20
 virt/kvm/kvm_main.c                                                |    7=
=20
 349 files changed, 3822 insertions(+), 2235 deletions(-)

Aapo Vienamo (1):
      ARM: dts: imx7d: cl-som-imx7: fix pinctrl_enet

Aaro Koskinen (1):
      drivers: macintosh: rack-meter: really fix bogus memsets

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

Alexey Kodanev (1):
      macvlan: fix use-after-free in macvlan_common_newlink()

Anand Jain (1):
      btrfs: fail mount when sb flag is not in BTRFS_SUPER_FLAG_SUPP

Anders Roxell (1):
      selftests: memfd: add config fragment for fuse

Andrea Parri (2):
      locking/xchg/alpha: Add unconditional memory barrier to cmpxchg()
      locking/xchg/alpha: Fix xchg() and cmpxchg() memory ordering bugs

Andreas Gruenbacher (1):
      gfs2: Fix fallocate chunk size

Andy Shevchenko (1):
      device property: Define type of PROPERTY_ENRTY_*() macros

Andy Spencer (1):
      gianfar: prevent integer wrapping in the rx handler

Anna-Maria Gleixner (1):
      tracing/hrtimer: Fix tracing bugs by taking all clock bases and modes=
 into account

Arjun Vynipadath (2):
      cxgb4: Setup FW queues before registering netdev
      cxgb4: Fix queue free path of ULD drivers

Arnaldo Carvalho de Melo (1):
      perf callchain: Fix attr.sample_max_stack setting

Arnd Bergmann (4):
      x86/power: Fix swsusp_arch_resume prototype
      cifs: silence compiler warnings showing up with gcc-8.0.0
      drm/exynos: g2d: use monotonic timestamps
      md: raid5: avoid string overflow warning

Arvind Yadav (2):
      xen: xenbus: use put_device() instead of kfree()
      workqueue: use put_device() instead of kfree()

Baoquan He (1):
      x86/apic: Set up through-local-APIC mode on the boot CPU if 'noapic' =
specified

Ben Hutchings (1):
      ALSA: timer: Fix pause event notification

Benjamin Poirier (1):
      e1000e: Fix check_for_link return value with autoneg off

BingJing Chang (1):
      md: fix a potential deadlock of raid5/raid10 reshape

Bjorn Andersson (2):
      soc: qcom: wcnss_ctrl: Fix increment in NV upload
      pinctrl: msm: Use dynamic GPIO numbering

Carlos Maiolino (1):
      Force log to disk before reading the AGF during a fstrim

Cathy Zhou (1):
      sunvnet: does not support GSO for sctp

Chao Yu (1):
      f2fs: fix to check extent cache in f2fs_drop_extent_tree

Charles Keepax (1):
      regmap: Correct comparison in regmap_cached

Chen Yu (1):
      ACPI: processor_perflib: Do not send _PPC change notification if not =
ready

Chengguang Xu (1):
      ceph: fix dentry leak when failing to init debugfs

Chien Tin Tung (1):
      RDMA/ucma: Correct option size check using optlen

Christophe JAILLET (1):
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

Colin Ian King (2):
      KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"
      clocksource/drivers/fsl_ftm_timer: Fix error return checking

Coly Li (2):
      bcache: properly set task state in bch_writeback_thread()
      bcache: quit dc->writeback_thread when BCACHE_DEV_DETACHING is set

Cong Wang (1):
      llc: properly handle dev_queue_xmit() return value

Corneliu Doban (1):
      mmc: sdhci-iproc: fix 32bit writes for TRANSFER_MODE register

Dan Carpenter (3):
      HID: roccat: prevent an out of bounds read in kovaplus_profile_activa=
ted()
      IB/mlx5: Fix an error code in __mlx5_ib_modify_qp()
      xen/acpi: off by one in read_acpi_id()

Daniel Borkmann (1):
      bpf: fix rlimit in reuseport net selftest

Danilo Krummrich (1):
      fs/proc/proc_sysctl.c: fix potential page fault while unregistering s=
ysctl table

Dave Airlie (1):
      virtio-gpu: fix ioctl and expose the fixed status to userspace.

Dave Hansen (1):
      x86/mm: Do not forbid _PAGE_RW before init for __ro_after_init

David Hildenbrand (2):
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

Davidlohr Bueso (4):
      Revert "ipc/shm: Fix shmat mmap nil-page protection"
      ipc/shm: fix shmat() nil address after round-down when remapping
      ia64/err-inject: Use get_user_pages_fast()
      sched/rt: Fix rq->clock_update_flags < RQCF_ACT_SKIP warning

Denis Kirjanov (1):
      fsl/fman: avoid sleeping in atomic context while adding an address

Dmitry Torokhov (1):
      Input: psmouse - fix Synaptics detection when protocol is disabled

Dong Bo (1):
      libata: Fix compile warning with ATA_DEBUG enabled

Ed Swierk (1):
      openvswitch: Remove padding from packet before L3+ conntrack processi=
ng

Eric Anholt (1):
      drm/panel: simple: Fix the bus format for the Ontat panel

Eric Biggers (1):
      PKCS#7: fix direct verification of SignerInfo signature

Eric Dumazet (2):
      smsc75xx: fix smsc75xx_set_features()
      r8152: fix tx packets accounting

Erik Schmauss (1):
      ACPICA: Events: add a return on failure from acpi_hw_register_read

Esben Haabendal (1):
      dp83640: Ensure against premature access to PHY registers after reset

Felix Fietkau (2):
      mac80211: round IEEE80211_TX_STATUS_HEADROOM up to multiple of 4
      mac80211: drop frames with unexpected DS bits from fast-rx to slow pa=
th

Filipe Manana (2):
      Btrfs: send, fix issuing write op when processing hole in no data mode
      Btrfs: fix copy_items() return value when logging an inode

Florian Fainelli (2):
      ARM: dts: NSP: Fix amount of RAM on BCM958625HR
      net: bgmac: Fix endian access in bgmac_dma_tx_ring_free()

Florian Westphal (2):
      netfilter: ebtables: convert BUG_ONs to WARN_ONs
      netfilter: ebtables: fix erroneous reject of last rule

Frank Asseg (1):
      tools/thermal: tmon: fix for segfault

Geert Uytterhoeven (1):
      ARM: OMAP1: clock: Fix debugfs_create_*() usage

Giulio Benetti (1):
      drm/sun4i: Fix dclk_set_phase

Govindarajulu Varadarajan (1):
      enic: enable rq before updating rq descriptors

Greg Kroah-Hartman (1):
      Linux 4.9.104

Greg Ungerer (1):
      m68k: set dma and coherent masks for platform FEC ethernets

Gregory CLEMENT (2):
      dmaengine: mv_xor_v2: Fix clock resource by adding a register clock
      i2c: mv64xxx: Apply errata delay only in standard mode

Guanglei Li (1):
      RDS: IB: Fix null pointer issue

Guenter Roeck (5):
      watchdog: sp5100_tco: Fix watchdog disable bit
      powerpc/boot: Fix random libfdt related build errors
      hwmon: (nct6775) Fix writing pwmX_mode
      hwmon: (pmbus/max8688) Accept negative page register values
      hwmon: (pmbus/adm1275) Accept negative page register values

Gustavo A. R. Silva (2):
      kernel/sys.c: fix potential Spectre v1 issue
      tcp_nv: fix potential integer overflow in tcpnv_acked

Hans de Goede (1):
      ACPI / scan: Use acpi_bus_get_status() to initialize ACPI_TYPE_DEVICE=
 devs

Hector Martin (1):
      firewire-ohci: work around oversized DMA reads on JMicron controllers

Helge Deller (1):
      parisc/pci: Switch LBA PCI bus from Hard Fail to Soft Fail mode

Hemanth Puranik (1):
      net: qcom/emac: Use proper free methods during TX

Huang Ying (1):
      mm: fix races between address_space dereference and free in page_evic=
atable

Igor Pylypiv (1):
      watchdog: f71808e_wdt: Fix magic close handling

Ilan Peer (1):
      mac80211: Do not disconnect on invalid operating class

Ilia Lin (1):
      arm64: dts: qcom: Fix SPI5 config on MSM8996

Ivan Gorinov (2):
      x86/devicetree: Initialize device tree before using it
      x86/devicetree: Fix device IRQ settings in DT

Jack M (1):
      IB/mlx4: Include GID type when deleting GIDs from HW table under RoCE

Jack Morgenstein (1):
      IB/mlx4: Fix corruption of RoCEv2 IPv4 GIDs

Jake Daryll Obina (1):
      jffs2: Fix use-after-free bug in jffs2_iget()'s error handling path

James Hogan (1):
      MIPS: generic: Fix machine compatible matching

Jan Chochol (1):
      nfs: Do not convert nfs_idmap_cache_timeout to jiffies

Jan Kara (1):
      udf: Provide saner default for invalid uid / gid

Jan Kiszka (1):
      builddeb: Fix header package regarding dtc source links

Jason Wang (1):
      ptr_ring: prevent integer overflow when calculating size

Jay Vosburgh (1):
      virtio-net: Fix operstate for virtio when no VIRTIO_NET_F_STATUS

Jayachandran C (1):
      watchdog: sbsa: use 32-bit read for WCV

Jean Delvare (1):
      firmware: dmi_scan: Fix handling of empty DMI strings

Jeff Mahoney (1):
      btrfs: fix lockdep splat in btrfs_alloc_subvolume_writers

Jens Axboe (1):
      sr: get/drop reference to device in revalidate and check_events

Jeremy Linton (1):
      net: smsc911x: Fix unload crash when link is up

Jesper Dangaard Brouer (1):
      tools/libbpf: handle issues with bpf ELF objects containing .eh_frames

Jia Zhang (1):
      vfs/proc/kcore, x86/mm/kcore: Fix SMAP fault when dumping vsyscall us=
er page

Jianchao Wang (1):
      nvme-pci: Fix nvme queue cleanup if IRQ setup fails

Jim Mattson (1):
      kvm: x86: IA32_ARCH_CAPABILITIES is always supported

Jinbum Park (1):
      ARM: 8748/1: mm: Define vdso_start, vdso_end as array

Jiri Olsa (2):
      perf tests: Use arch__compare_symbol_names to compare symbols
      perf report: Fix memory corruption in --branch-history mode --branch-=
history

Joe Jin (1):
      xen-swiotlb: fix the check condition for xen_swiotlb_free_coherent

Joe Perches (1):
      MIPS: Octeon: Fix logging messages with spurious periods after newlin=
es

Joerg Roedel (1):
      x86/pgtable: Don't set huge PUD/PMD on non-leaf entries

Joey Pabalinas (1):
      net/tcp/illinois: replace broken algorithm reference link

Johannes Berg (1):
      regulatory: add NUL to request alpha2

Johannes Thumshirn (1):
      nvme: don't send keep-alives to the discovery controller

Jun Piao (1):
      ocfs2/dlm: don't handle migrate lockres if already in shutdown

Kalderon, Michal (4):
      RDMA/qedr: Fix kernel panic when running fio over NFSoRDMA
      RDMA/qedr: Fix iWARP write and send with immediate
      RDMA/qedr: fix QP's ack timeout configuration
      RDMA/qedr: Fix rc initialization on CNQ allocation failure

Kamlakant Patel (1):
      ipmi_ssif: Fix kernel panic at msg_done_handler

Kan Liang (3):
      perf/x86/intel: Properly save/restore the PMU state in the NMI handler
      perf/x86/intel: Fix large period handling on Broadwell CPUs
      perf/x86/intel: Fix event update for auto-reload

KarimAllah Ahmed (1):
      kvm: Map PFN-type memory regions as writable (if possible)

Karol Herbst (1):
      drm/nouveau/pmu/fuc: don't use movw directly anymore

Karthikeyan Periyasamy (1):
      ath10k: Fix kernel panic while using worker (ath10k_sta_rc_update_wk)

Kees Cook (1):
      NFC: llcp: Limit size of SDP URI

Kirill A. Shutemov (1):
      asm-generic: provide generic_pmdp_establish()

Konrad Rzeszutek Wilk (1):
      KVM/VMX: Expose SSBD properly to guests

Laurent Pinchart (1):
      ARM: dts: porter: Fix HDMI output routing

Lenny Szubowicz (1):
      ACPI: acpi_pad: Fix memory leak in power saving threads

Leon Romanovsky (2):
      RDMA/mlx5: Avoid memory leak in case of XRCD dealloc failure
      net/mlx5: Protect from command bit overflow

Linus L=FCssing (3):
      batman-adv: Fix multicast packet loss with a single WANT_ALL_IPV4/6 f=
lag
      batman-adv: fix multicast-via-unicast transmission with AP isolation
      batman-adv: fix packet loss for broadcasted DHCP packets to a server

Liu Bo (4):
      Btrfs: set plug for fsync
      Btrfs: fix scrub to repair raid6 corruption
      Btrfs: bail out on error during replay_dir_deletes
      Btrfs: fix NULL pointer dereference in log_dir_items

Logan Gunthorpe (1):
      ntb_transport: Fix bug with max_mw_size parameter

Lucas Stach (1):
      drm/imx: move arming of the vblank event to atomic_flush

Maciej W. Rozycki (2):
      MIPS: ptrace: Expose FIR register through FP regset
      MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32=
 FGRs

Madhavan Srinivasan (1):
      powerpc/perf: Prevent kernel address leak to userspace via BHRB buffer

Marc Zyngier (1):
      arm64: Relax ARM_SMCCC_ARCH_WORKAROUND_1 discovery

Mark Lord (1):
      powerpc/bpf/jit: Fix 32-bit JIT for seccomp_data access

Mark Salter (1):
      irqchip/gic-v3: Change pr_debug message to pr_devel

Martin Blumenstingl (2):
      net: stmmac: dwmac-meson8b: fix setting the RGMII TX clock on Meson8b
      net: stmmac: dwmac-meson8b: propagate rate changes to the parent clock

Masami Hiramatsu (3):
      selftests: ftrace: Add probe event argument syntax testcase
      selftests: ftrace: Add a testcase for string type with kprobe_event
      selftests: ftrace: Add a testcase for probepoint

Mathias Kresin (1):
      MIPS: ath79: Fix AR724X_PLL_REG_PCIE_CONFIG offset

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

Max Gurtovoy (1):
      nvmet: fix PSDT field check in command format

Mel Gorman (1):
      mm: pin address_space before dereferencing it while isolating an LRU =
page

Michael Bringmann (2):
      powerpc/numa: Use ibm,max-associativity-domains to discover possible =
nodes
      powerpc/numa: Ensure nodes initialized for hotplug

Michael Chan (1):
      bnxt_en: Check valid VNIC ID in bnxt_hwrm_vnic_set_tpa().

Michael Ellerman (4):
      selftests/powerpc: Skip the subpage_prot tests if the syscall is unav=
ailable
      powerpc/mpic: Check if cpu_possible() in mpic_physmask()
      powerpc/perf: Fix kernel address leak via sampling registers
      selftests: Print the test we're running to /dev/kmsg

Michael J. Ruhl (1):
      IB/hfi1: Use after free race condition in send context error path

Michael Kelley (1):
      cpumask: Make for_each_cpu_wrap() available on UP as well

Michael Schmitz (1):
      zorro: Set up z->dev.dma_mask for the DMA API

Naftali Goldstein (1):
      iwlwifi: mvm: always init rs with 20mhz bandwidth rates

Naresh Kamboju (1):
      selftests: pstore: Adding config fragment CONFIG_PSTORE_RAM=3Dm

NeilBrown (2):
      MIPS: c-r4k: Fix data corruption related to cache coherence
      NFSv4: always set NFS_LOCK_LOST when a lock is lost.

Ngai-Mint Kwan (1):
      fm10k: fix "failed to kill vid" message for VF

Nicolas Pitre (1):
      kbuild: make scripts/adjust_autoksyms.sh robust against timestamp rac=
es

Niklas Cassel (2):
      net: stmmac: ensure that the device has released ownership before rea=
ding data
      net: stmmac: ensure that the MSS desc is the last desc to set the own=
 bit

Nikolay Borisov (2):
      btrfs: Fix out of bounds access in btrfs_search_slot
      btrfs: Fix possible softlock on single core machines

Nitin Gupta (1):
      sparc64: update pmdp_invalidate() to return old pmd value

Paolo Bonzini (1):
      kvm: x86: fix KVM_XEN_HVM_CONFIG ioctl

Parav Pandit (2):
      IB/core: Fix possible crash to access NULL netdev
      IB/core: Honor port_num while resolving GID for IB link layer

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Fix VRMA initialization with 2MB or 1GB memory b=
acking

Pawel Dembicki (1):
      net: qmi_wwan: add BroadMobi BM806U 2020:2033

Peter Malone (1):
      fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbus=
fb_ioctl_helper().

Peter Xu (1):
      iommu/vt-d: Use domain instead of cache fetching

Peter Zijlstra (2):
      x86/tsc: Allow TSC calibration without PIT
      perf/core: Fix perf_output_read_group()

Petr Vorel (1):
      ima: Fallback to the builtin hash algorithm

Philipp Puschmann (1):
      arm: dts: socfpga: fix GIC PPI warning

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

Qu Wenruo (1):
      btrfs: tests/qgroup: Fix wrong tree backref level

Rafael J. Wysocki (1):
      PCI: Restore config space on runtime resume despite being unbound

Ramon Fried (1):
      qrtr: add MODULE_ALIAS macro to smd

Randy Dunlap (2):
      integrity/security: fix digsig.c build error with header file
      kdb: make "mdr" command repeat

Rich Felker (1):
      sh: fix debug trap failure to process signals before return to user

Richard Guy Briggs (1):
      audit: return on memory error to avoid null pointer dereference

Richard Haines (1):
      netlabel: If PF_INET6, check sk_buff ip header version

Roger Pau Monne (1):
      xen/pirq: fix error path cleanup when binding MSIs

Ross Lagerwall (2):
      xen-netfront: Fix race between device setup and open
      xen/grant-table: Use put_page instead of free_page

Sabrina Dubroca (1):
      ipv4: lock mtu in fnhe when received PMTU < net.ipv4.route.min_pmtu

Samuel Neves (1):
      x86/topology: Update the 'cpu cores' field in /proc/cpuinfo correctly=
 across CPU hotplug operations

Sara Sharon (4):
      iwlwifi: mvm: fix security bug in PN checking
      mac80211: fix a possible leak of station stats
      mac80211: fix calling sleeping function in atomic context
      iwlwifi: mvm: fix TX of CCMP 256

Sean Christopherson (1):
      KVM: VMX: raise internal error for exception during invalid protected=
 mode state

Sebastian Ott (4):
      s390/cio: fix ccw_device_start_timeout API
      s390/cio: fix return code after missing interrupt
      s390/cio: clear timer when terminating driver I/O
      kvm: fix warning for CONFIG_HAVE_KVM_EVENTFD builds

Seunghun Han (1):
      ACPICA: acpi: acpica: fix acpi operand cache leak in nseval.c

Shiraz Saleem (1):
      i40iw: Zero-out consumer key on allocate stag for FMR

Shunyong Yang (1):
      cpufreq: CPPC: Initialize shared perf capabilities of CPUs

Song Liu (1):
      perf/cgroup: Fix child event counting bug

Srinath Mannam (1):
      mmc: sdhci-iproc: remove hard coded mmc cap 1.8v

Srinivas Kandagatla (1):
      dmaengine: qcom: bam_dma: get num-channels and num-ees from dt

Stefan Wahren (2):
      brcmfmac: Fix check for ISO3166 code
      ARM: dts: bcm283x: Fix probing of bcm2835-i2s

Stefano Brivio (2):
      vti4: Don't count header length twice on tunnel setup
      vti4: Don't override MTU passed on link creation via IFLA_MTU

Stephane Eranian (1):
      perf/x86/intel: Fix linear IP of PEBS real_ip on Haswell and later CP=
Us

Stephen Boyd (1):
      irqchip/gic-v3: Ignore disabled ITS nodes

Steven Rostedt (VMware) (2):
      tools lib traceevent: Simplify pointer print logic and fix %pF
      tools lib traceevent: Fix get_field_str() for dynamic strings

Subash Abhinov Kasiviswanathan (2):
      netfilter: ipv6: nf_defrag: Pass on packets to stack per RFC2460
      netfilter: ipv6: nf_defrag: Kill frag queue on RFC2460 failure

Sudip Mukherjee (1):
      libata: blacklist Micron 500IT SSD with MU01 firmware

Sven Eckelmann (5):
      batman-adv: Ignore invalid batadv_iv_gw during netlink send
      batman-adv: Ignore invalid batadv_v_gw during netlink send
      batman-adv: Fix netlink dumping of BLA claims
      batman-adv: Fix netlink dumping of BLA backbones
      batman-adv: Fix skbuff rcsum on packet reroute

Takashi Iwai (2):
      ALSA: hda - Use IS_REACHABLE() for dependency on input
      ALSA: vmaster: Propagate slave error

Takeshi Kihara (1):
      pinctrl: sh-pfc: r8a7796: Fix MOD_SEL register pin assignment for SSI=
 pins group

Tang Junhui (4):
      bcache: fix for allocator and register thread race
      bcache: fix for data collapse after re-attaching an attached device
      bcache: return attach error when no cache set exist
      bcache: fix kcrashes with fio in RAID5 backend dev

Tejun Heo (2):
      libata: Blacklist some Sandisk SSDs for NCQ
      rcu: Call touch_nmi_watchdog() while printing stall warnings

Thomas Falcon (1):
      ibmvnic: Free RX socket buffer in case of adapter error

Thomas Hellstrom (1):
      drm/vmwgfx: Fix 32-bit VMW_PORT_HB_[IN|OUT] macros

Thomas Richter (2):
      perf record: Fix failed memory allocation for get_cpuid_str
      perf stat: Fix core dump when flag T is used

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

Ulf Magnusson (4):
      kconfig: Don't leak main menus during parsing
      kconfig: Fix automatic menu creation mem leak
      kconfig: Fix expr_free() E_NOT leak
      ARC: Fix malformed ARC_EMUL_UNALIGNED default

Vinayak Menon (1):
      mm/kmemleak.c: wait for scan completion before disabling free

Viresh Kumar (1):
      cpufreq: Reorder cpufreq_online() error code path

Vitaly Kuznetsov (1):
      KVM: lapic: stop advertising DIRECTED_EOI when in-kernel IOAPIC is in=
 use

Wei Huang (1):
      KVM: x86: Update cpuid properly when CR4.OSXAVE or CR4.PKE is changed

Wei Yongjun (1):
      ipmi/powernv: Fix error return code in ipmi_powernv_probe()

Will Deacon (4):
      arm64: spinlock: Fix theoretical trylock() A-B-A with LSE atomics
      locking/qspinlock: Ensure node->count is updated before initialising =
node
      fs: dcache: Avoid livelock between d_alloc_parallel and __d_add
      fs: dcache: Use READ_ONCE when accessing i_dir_seq

Wolfram Sang (1):
      drm/exynos: fix comparison to bitshift when dealing with a mask

Xin Long (2):
      ip6_tunnel: fix IFLA_MTU ignored on NEWLINK
      sit: fix IFLA_MTU ignored on NEWLINK

Yang Shi (1):
      mm: thp: use down_read_trylock() in khugepaged to avoid long block

Yelena Krivosheev (1):
      net: mvneta: fix enable of all initialized RXQs

Yisheng Xie (4):
      mm/mempolicy: fix the check of nodemask from user
      mm/mempolicy: add nodes_empty check in SYSC_migrate_pages
      mm/mempolicy.c: avoid use uninitialized preferred_node
      perf top: Fix top.call-graph config option reading

Yonghong Song (1):
      bpf: fix selftests/bpf test_kmod.sh failure when CONFIG_BPF_JIT_ALWAY=
S_ON=3Dy

Yoshihiro Shimoda (2):
      dmaengine: rcar-dmac: fix max_chunk_size for R-Car Gen3
      dmaengine: rcar-dmac: Check the done lists in rcar_dmac_chan_get_resi=
due()

Yufen Yu (2):
      md raid10: fix NULL deference in handle_write_completed()
      md/raid1: fix NULL pointer dereference

lionel.debieve@st.com (1):
      hwrng: stm32 - add reset during probe

mulhern (1):
      dm thin: fix documentation relative to low water mark threshold

piaojun (3):
      ocfs2: return -EROFS to mount.ocfs2 if inode block is invalid
      ocfs2/acl: use 'ip_xattr_sem' to protect getting extended attribute
      ocfs2: return error when we attempt to access a dirty bh in jbd2

shidao.ytt (1):
      mm/fadvise: discard partial page if endbyte is also EOF

weiyongjun (A) (1):
      mac80211_hwsim: fix possible memory leak in hwsim_new_radio_nl()

zhongjiang (1):
      kernel/signal.c: avoid undefined behaviour in kill_something_info

=D8rjan Eide (1):
      drm/rockchip: Respect page offset for PRIME mmap calls


--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsOU60ACgkQONu9yGCS
aT4KEhAAm+/tveKM6D+VItPx4+R/fT5FkRRsts7gdm0UfqoaimfEJrWaW+aAQGqD
u+evlUj5j8K+McEDxvvypOWXmv3lrondyjTFim1kJCLYG/tsBH+hLDDmBJLrnC33
+MEWsz8Fqvvt5lYsSXFMSUOzXMUx3uCgXiAYat8qS+q5SJRnGTT6h80XwVmwFOTr
R4gNv3ZZzmdOL6AFiwvyo3jsBpmtJ4iSYmZ7lLS6cQAMjcLkdmsZEI1hwAWk6uD7
5Nn0/7HintDFHY3Bv/XQll2W/6rXtRTnGwgICexDWeMov0fxlSnJGIINIIl6vpVZ
duYwZkUE18PS1GKY8s52gEQWo68ZX6iiyr1j7QqTwzIfihj+zTCMSw2kFXwoayLq
Kbbri66/lZCY+XXMsHD75QdtUyfBDS6+r+2+89uxVDyQwczzH689uCpOdbmG/Rg0
hHmH4fozWG+oRR20J7NPfOtfWHMLa/ln4NEiCtQ2F4LJaCfB5I2vHaGSBdCpLnrY
4+szdrwH5ncRoMNhPEBdMiB9nxnizoj6K47i+rkDXmaNkLeei56KLYgZ7rsRxeW6
sQNRt4eWiq5XDlrnUJgMhBuayQElf428p/dFQ1pHqpKbTjF5oePKLwsU80SRYii+
CmqpnxBxi/IujIulSXPZt1BMvPw6cwvmfw1cIt1D3j67TS5E/cI=
=hiJm
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
