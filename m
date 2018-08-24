Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C450C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9608B21567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9608B21567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeHXPoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:44:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51498 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeHXPoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:44:00 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E59B73EE;
        Fri, 24 Aug 2018 12:09:34 +0000 (UTC)
Date:   Fri, 24 Aug 2018 14:09:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.19
Message-ID: <20180824120931.GA26200@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.17.19 kernel.

Note, this is the LAST 4.17.y kernel to be released, it is now
end-of-life.  Pleas move to 4.18.y at this time.

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

 Makefile                                                |    8 -
 arch/arc/Makefile                                       |   15 -
 arch/arc/include/asm/mach_desc.h                        |    2=20
 arch/arc/kernel/irq.c                                   |    2=20
 arch/arc/kernel/process.c                               |   47 ++++--
 arch/arc/plat-hsdk/platform.c                           |   62 ++++++++
 arch/arm/boot/dts/am3517.dtsi                           |    5=20
 arch/arm/boot/dts/am437x-sk-evm.dts                     |    2=20
 arch/arm/boot/dts/armada-385-synology-ds116.dts         |    2=20
 arch/arm/boot/dts/bcm-cygnus.dtsi                       |   24 +--
 arch/arm/boot/dts/bcm-hr2.dtsi                          |   24 +--
 arch/arm/boot/dts/bcm-nsp.dtsi                          |   32 ++--
 arch/arm/boot/dts/bcm5301x.dtsi                         |    2=20
 arch/arm/boot/dts/da850.dtsi                            |    6=20
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi                 |    2=20
 arch/arm/boot/dts/omap4-droid4-xt894.dts                |    9 -
 arch/arm/configs/imx_v4_v5_defconfig                    |    2=20
 arch/arm/configs/imx_v6_v7_defconfig                    |    2=20
 arch/arm/crypto/speck-neon-core.S                       |    6=20
 arch/arm/mach-davinci/board-da850-evm.c                 |    2=20
 arch/arm/mach-omap2/omap-smp.c                          |   41 +++++
 arch/arm/mach-pxa/irq.c                                 |    4=20
 arch/arm/mm/init.c                                      |    9 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts          |   15 +
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi         |    2=20
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi        |    8 -
 arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts    |    4=20
 arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts    |    4=20
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi     |    4=20
 arch/arm64/boot/dts/qcom/msm8916.dtsi                   |    4=20
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts  |    2=20
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts  |    2=20
 arch/arm64/include/asm/alternative.h                    |    7=20
 arch/arm64/kernel/alternative.c                         |   51 +++++-
 arch/arm64/kernel/module.c                              |    5=20
 arch/arm64/kernel/smp.c                                 |    2=20
 arch/arm64/mm/dma-mapping.c                             |    9 -
 arch/ia64/kernel/perfmon.c                              |    6=20
 arch/ia64/mm/init.c                                     |   12 -
 arch/m68k/include/asm/mcf_pgalloc.h                     |    4=20
 arch/nds32/kernel/setup.c                               |    3=20
 arch/openrisc/kernel/entry.S                            |    8 -
 arch/openrisc/kernel/head.S                             |    9 -
 arch/openrisc/kernel/traps.c                            |    2=20
 arch/parisc/include/asm/spinlock.h                      |    8 -
 arch/parisc/kernel/syscall.S                            |   24 +--
 arch/powerpc/kernel/smp.c                               |    6=20
 arch/riscv/kernel/irq.c                                 |    4=20
 arch/riscv/kernel/module.c                              |    4=20
 arch/riscv/kernel/ptrace.c                              |    2=20
 arch/s390/net/bpf_jit_comp.c                            |    1=20
 arch/x86/include/asm/processor.h                        |    1=20
 arch/x86/include/asm/set_memory.h                       |    1=20
 arch/x86/kernel/cpu/microcode/intel.c                   |    5=20
 arch/x86/kernel/kvmclock.c                              |    1=20
 arch/x86/kernel/smpboot.c                               |    5=20
 arch/x86/kvm/vmx.c                                      |    9 -
 arch/x86/mm/init.c                                      |   37 ++++
 arch/x86/mm/init_64.c                                   |    8 -
 arch/x86/mm/pageattr.c                                  |   13 +
 block/blk-mq-debugfs.c                                  |    2=20
 block/blk-mq.c                                          |   12 +
 block/sed-opal.c                                        |    4=20
 drivers/acpi/ec.c                                       |   20 ++
 drivers/acpi/nfit/core.c                                |    4=20
 drivers/ata/libahci.c                                   |    7=20
 drivers/block/drbd/drbd_req.c                           |    4=20
 drivers/block/nbd.c                                     |   40 ++++-
 drivers/char/ipmi/kcs_bmc.c                             |   31 +---
 drivers/clk/Makefile                                    |    2=20
 drivers/clk/davinci/da8xx-cfgchip.c                     |    2=20
 drivers/clk/sunxi-ng/Makefile                           |   39 +----
 drivers/clocksource/timer-stm32.c                       |    4=20
 drivers/dax/device.c                                    |   12 +
 drivers/dma/k3dma.c                                     |    2=20
 drivers/dma/omap-dma.c                                  |    6=20
 drivers/dma/pl330.c                                     |    2=20
 drivers/edac/edac_mc.c                                  |    1=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c                  |    3=20
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                   |    4=20
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c |   19 ++
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c      |    1=20
 drivers/gpu/drm/arm/malidp_drv.c                        |    3=20
 drivers/gpu/drm/arm/malidp_hw.c                         |    3=20
 drivers/gpu/drm/arm/malidp_planes.c                     |    9 -
 drivers/gpu/drm/armada/armada_crtc.c                    |   12 +
 drivers/gpu/drm/armada/armada_hw.h                      |    1=20
 drivers/gpu/drm/armada/armada_overlay.c                 |   30 ++-
 drivers/gpu/drm/bridge/sil-sii8620.c                    |  121 ++++++++---=
-----
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c           |    6=20
 drivers/gpu/drm/exynos/exynos_drm_gsc.c                 |   29 ++-
 drivers/gpu/drm/exynos/regs-gsc.h                       |    1=20
 drivers/gpu/drm/i915/gvt/kvmgt.c                        |    9 +
 drivers/gpu/drm/nouveau/nouveau_gem.c                   |    4=20
 drivers/gpu/drm/sun4i/Makefile                          |    5=20
 drivers/gpu/drm/tegra/drm.c                             |    2=20
 drivers/gpu/host1x/dev.c                                |    3=20
 drivers/gpu/host1x/job.c                                |    3=20
 drivers/hid/hid-google-hammer.c                         |    2=20
 drivers/hid/hid-ids.h                                   |    1=20
 drivers/hid/wacom_wac.c                                 |   10 +
 drivers/hwmon/dell-smm-hwmon.c                          |    7=20
 drivers/hwmon/nct6775.c                                 |    2=20
 drivers/i2c/busses/i2c-imx.c                            |    8 -
 drivers/i2c/i2c-core-acpi.c                             |   11 +
 drivers/iio/pressure/bmp280-core.c                      |    5=20
 drivers/infiniband/hw/mlx4/mr.c                         |    7=20
 drivers/infiniband/hw/mlx5/srq.c                        |   18 +-
 drivers/infiniband/hw/qedr/verbs.c                      |    3=20
 drivers/infiniband/sw/rxe/rxe_req.c                     |    5=20
 drivers/input/rmi4/rmi_2d_sensor.c                      |   34 ++--
 drivers/irqchip/irq-gic-v2m.c                           |    2=20
 drivers/irqchip/irq-gic-v3-its.c                        |   10 +
 drivers/md/raid10.c                                     |    7=20
 drivers/mtd/devices/mtd_dataflash.c                     |    4=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h             |    1=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c         |    6=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c        |    6=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c               |   15 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h               |    1=20
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c            |   30 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c           |    2=20
 drivers/net/ethernet/cadence/macb_main.c                |   11 -
 drivers/net/ethernet/cavium/Kconfig                     |   12 -
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c        |   14 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c         |    2=20
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c              |   35 +---
 drivers/net/ethernet/cisco/enic/enic_clsf.c             |    3=20
 drivers/net/ethernet/cisco/enic/enic_main.c             |    3=20
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c          |   15 +
 drivers/net/ethernet/freescale/fman/fman_port.c         |    8 +
 drivers/net/ethernet/ibm/ibmvnic.c                      |   43 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c         |   12 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c          |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c       |   12 -
 drivers/net/ethernet/mellanox/mlx5/core/vport.c         |    2=20
 drivers/net/ethernet/netronome/nfp/bpf/main.c           |    6=20
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nffw.c   |    2=20
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c              |   11 -
 drivers/net/ethernet/qlogic/qed/qed_debug.c             |    2=20
 drivers/net/ethernet/qlogic/qed/qed_ll2.c               |   11 +
 drivers/net/ethernet/qlogic/qed/qed_main.c              |   12 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c       |    2=20
 drivers/net/ethernet/qualcomm/qca_spi.c                 |   21 +-
 drivers/net/ethernet/realtek/r8169.c                    |    1=20
 drivers/net/ethernet/renesas/ravb_main.c                |   56 ++-----
 drivers/net/ethernet/renesas/sh_eth.c                   |   59 ++-----
 drivers/net/ethernet/sfc/ef10.c                         |   30 ++-
 drivers/net/ethernet/sfc/efx.c                          |   17 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig             |    2=20
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c     |   18 +-
 drivers/net/ethernet/ti/davinci_emac.c                  |    4=20
 drivers/net/hamradio/bpqether.c                         |    8 -
 drivers/net/hyperv/rndis_filter.c                       |    1=20
 drivers/net/ieee802154/adf7242.c                        |   34 ++++
 drivers/net/ieee802154/at86rf230.c                      |   15 -
 drivers/net/ieee802154/fakelb.c                         |    2=20
 drivers/net/ieee802154/mcr20a.c                         |    3=20
 drivers/net/ipvlan/ipvlan_main.c                        |   36 +++-
 drivers/net/phy/marvell.c                               |   54 ++++---
 drivers/net/phy/sfp-bus.c                               |   35 +++-
 drivers/net/usb/rtl8150.c                               |    2=20
 drivers/net/usb/smsc75xx.c                              |   62 ++++++++
 drivers/net/wireless/ath/ath10k/mac.c                   |   16 +-
 drivers/net/wireless/ath/ath10k/wmi.h                   |    1=20
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c |    7=20
 drivers/nfc/pn533/usb.c                                 |    4=20
 drivers/nvme/host/core.c                                |   52 +++---
 drivers/nvme/host/pci.c                                 |    2=20
 drivers/nvme/host/rdma.c                                |   28 ++-
 drivers/nvme/target/core.c                              |    8 +
 drivers/nvmem/core.c                                    |    4=20
 drivers/of/base.c                                       |    6=20
 drivers/of/of_private.h                                 |    2=20
 drivers/of/overlay.c                                    |   11 +
 drivers/pci/dwc/pcie-designware-host.c                  |    3=20
 drivers/pci/host/pci-aardvark.c                         |    2=20
 drivers/pci/host/pci-ftpci100.c                         |    4=20
 drivers/pci/host/pci-v3-semi.c                          |    2=20
 drivers/pci/host/pci-versatile.c                        |    2=20
 drivers/pci/host/pci-xgene.c                            |    2=20
 drivers/pci/host/pcie-mediatek.c                        |    2=20
 drivers/pci/host/pcie-xilinx-nwl.c                      |    2=20
 drivers/pci/host/pcie-xilinx.c                          |    1=20
 drivers/pci/hotplug/pci_hotplug_core.c                  |    9 +
 drivers/pci/hotplug/pciehp.h                            |    1=20
 drivers/pci/hotplug/pciehp_core.c                       |    7=20
 drivers/pci/hotplug/pciehp_hpc.c                        |   18 --
 drivers/pci/of.c                                        |    2=20
 drivers/pci/pci-acpi.c                                  |    6=20
 drivers/pci/pci.c                                       |   66 ++++++++
 drivers/pci/probe.c                                     |    4=20
 drivers/perf/xgene_pmu.c                                |    2=20
 drivers/pinctrl/bcm/pinctrl-nsp-mux.c                   |    6=20
 drivers/pinctrl/pinctrl-ingenic.c                       |    2=20
 drivers/platform/x86/dell-laptop.c                      |    2=20
 drivers/rtc/interface.c                                 |    8 -
 drivers/s390/cio/vfio_ccw_drv.c                         |    5=20
 drivers/s390/net/qeth_core.h                            |    2=20
 drivers/s390/net/qeth_core_main.c                       |   23 +--
 drivers/s390/net/qeth_l2_main.c                         |    5=20
 drivers/s390/net/qeth_l3_main.c                         |    3=20
 drivers/scsi/hpsa.c                                     |   25 ++-
 drivers/scsi/hpsa.h                                     |    1=20
 drivers/scsi/qedf/qedf_main.c                           |   12 +
 drivers/scsi/qedi/qedi_main.c                           |   11 +
 drivers/scsi/xen-scsifront.c                            |   33 +++-
 drivers/soc/imx/gpc.c                                   |   21 ++
 drivers/soc/imx/gpcv2.c                                 |   13 +
 drivers/tty/pty.c                                       |    2=20
 drivers/usb/chipidea/host.c                             |    5=20
 drivers/usb/dwc2/core.h                                 |    3=20
 drivers/usb/dwc2/gadget.c                               |   15 +
 drivers/usb/dwc2/hcd.c                                  |   93 +++++++++++-
 drivers/usb/dwc2/hcd.h                                  |    8 +
 drivers/usb/dwc2/hcd_intr.c                             |   11 +
 drivers/usb/dwc2/hcd_queue.c                            |    3=20
 drivers/usb/dwc3/dwc3-of-simple.c                       |    3=20
 drivers/usb/dwc3/dwc3-pci.c                             |    2=20
 drivers/usb/gadget/composite.c                          |    3=20
 drivers/usb/gadget/function/f_fs.c                      |   26 ++-
 drivers/usb/host/xhci-dbgcap.c                          |   12 +
 drivers/usb/host/xhci-tegra.c                           |    2=20
 drivers/usb/host/xhci.c                                 |    7=20
 drivers/usb/typec/tcpm.c                                |    3=20
 drivers/xen/manage.c                                    |   18 +-
 drivers/xen/xen-scsiback.c                              |   16 +-
 fs/btrfs/scrub.c                                        |   17 +-
 fs/ceph/inode.c                                         |    1=20
 fs/cifs/smb2pdu.c                                       |    5=20
 fs/exec.c                                               |    6=20
 fs/ext4/mballoc.c                                       |    4=20
 fs/nfs/nfs4proc.c                                       |   17 +-
 fs/reiserfs/xattr.c                                     |    4=20
 include/linux/fsl/guts.h                                |    1=20
 include/linux/kthread.h                                 |    1=20
 include/linux/marvell_phy.h                             |    2=20
 include/linux/mm.h                                      |    4=20
 include/linux/pci.h                                     |    2=20
 include/linux/sched.h                                   |    2=20
 include/net/ipv6.h                                      |    9 -
 include/net/net_namespace.h                             |    1=20
 include/net/netns/ipv6.h                                |    1=20
 include/net/tc_act/tc_csum.h                            |    1=20
 include/net/tc_act/tc_tunnel_key.h                      |    1=20
 include/net/tcp.h                                       |    2=20
 include/uapi/linux/nbd.h                                |    3=20
 kernel/bpf/hashtab.c                                    |   16 +-
 kernel/fork.c                                           |   35 +++-
 kernel/kthread.c                                        |   30 +++
 kernel/locking/lockdep.c                                |   12 -
 kernel/sched/core.c                                     |   67 ++++----
 kernel/sched/deadline.c                                 |   11 +
 kernel/sched/fair.c                                     |   30 +--
 kernel/sched/sched.h                                    |    6=20
 kernel/trace/trace.c                                    |    5=20
 mm/kasan/kasan.c                                        |    5=20
 mm/mmap.c                                               |   35 +---
 mm/nommu.c                                              |   10 -
 mm/page_alloc.c                                         |   16 +-
 net/9p/client.c                                         |    3=20
 net/batman-adv/bat_iv_ogm.c                             |    4=20
 net/batman-adv/bat_v.c                                  |    4=20
 net/batman-adv/debugfs.c                                |   40 +++++
 net/batman-adv/debugfs.h                                |   11 +
 net/batman-adv/hard-interface.c                         |   37 ++++
 net/batman-adv/translation-table.c                      |    7=20
 net/core/dev.c                                          |    4=20
 net/core/filter.c                                       |    3=20
 net/ieee802154/6lowpan/core.c                           |    6=20
 net/ipv4/inet_fragment.c                                |    2=20
 net/ipv4/netfilter/ip_tables.c                          |    1=20
 net/ipv4/tcp.c                                          |    4=20
 net/ipv4/tcp_dctcp.c                                    |   25 ---
 net/ipv4/tcp_output.c                                   |    4=20
 net/ipv6/calipso.c                                      |    9 -
 net/ipv6/exthdrs.c                                      |  111 +++--------=
---
 net/ipv6/ipv6_sockglue.c                                |   27 ++-
 net/ipv6/mcast.c                                        |    9 -
 net/ipv6/netfilter/ip6_tables.c                         |    1=20
 net/ipv6/netfilter/nf_conntrack_reasm.c                 |    6=20
 net/mac80211/tx.c                                       |    2=20
 net/netfilter/nf_conntrack_core.c                       |    2=20
 net/netfilter/nf_conntrack_helper.c                     |    5=20
 net/netfilter/nf_conntrack_proto_dccp.c                 |    8 -
 net/netfilter/nf_log.c                                  |    4=20
 net/netfilter/nft_compat.c                              |   13 +
 net/packet/af_packet.c                                  |   12 +
 net/qrtr/qrtr.c                                         |   13 +
 net/rds/connection.c                                    |   11 +
 net/rds/loop.c                                          |   56 +++++++
 net/rds/loop.h                                          |    2=20
 net/sched/act_csum.c                                    |    6=20
 net/sched/act_tunnel_key.c                              |    6=20
 net/sctp/chunk.c                                        |    4=20
 net/smc/af_smc.c                                        |    3=20
 net/smc/smc_clc.c                                       |    3=20
 net/tipc/discover.c                                     |   18 +-
 net/tipc/net.c                                          |   17 +-
 net/tipc/node.c                                         |    7=20
 net/tls/tls_sw.c                                        |    5=20
 net/wireless/nl80211.c                                  |   35 +---
 net/xfrm/xfrm_user.c                                    |    8 -
 samples/bpf/parse_varlen.c                              |    6=20
 samples/bpf/test_overhead_user.c                        |   19 +-
 samples/bpf/trace_event_user.c                          |   27 +++
 samples/bpf/xdp2skb_meta.sh                             |    6=20
 scripts/kconfig/zconf.y                                 |    4=20
 security/smack/smack_lsm.c                              |    1=20
 sound/core/seq/seq_clientmgr.c                          |    3=20
 tools/build/Build.include                               |    2=20
 tools/build/Makefile                                    |    2=20
 tools/objtool/elf.c                                     |   41 +++--
 tools/perf/Makefile.config                              |    3=20
 tools/perf/arch/powerpc/util/skip-callchain-idx.c       |    2=20
 tools/perf/arch/x86/util/perf_regs.c                    |    2=20
 tools/perf/bench/numa.c                                 |    5=20
 tools/perf/builtin-annotate.c                           |   11 +
 tools/perf/builtin-report.c                             |    3=20
 tools/perf/builtin-script.c                             |   25 +++
 tools/perf/jvmti/jvmti_agent.c                          |    3=20
 tools/perf/pmu-events/Build                             |    2=20
 tools/perf/tests/builtin-test.c                         |    2=20
 tools/perf/tests/parse-events.c                         |    8 -
 tools/perf/tests/topology.c                             |    1=20
 tools/perf/util/c++/clang.cpp                           |   11 +
 tools/perf/util/header.c                                |   12 +
 tools/perf/util/llvm-utils.c                            |    6=20
 tools/perf/util/parse-events.y                          |    5=20
 tools/perf/util/scripting-engines/trace-event-python.c  |    8 -
 tools/testing/nvdimm/test/nfit.c                        |    3=20
 tools/testing/selftests/bpf/test_kmod.sh                |    9 +
 tools/testing/selftests/bpf/test_offload.py             |   12 +
 tools/testing/selftests/net/config                      |    2=20
 tools/testing/selftests/pstore/pstore_post_reboot_tests |    5=20
 tools/testing/selftests/static_keys/test_static_keys.sh |   13 +
 tools/testing/selftests/sync/config                     |    4=20
 tools/testing/selftests/sysctl/sysctl.sh                |   20 +-
 tools/testing/selftests/user/test_user_copy.sh          |    7=20
 tools/testing/selftests/vm/compaction_test.c            |    4=20
 tools/testing/selftests/vm/mlock2-tests.c               |   12 -
 tools/testing/selftests/vm/run_vmtests                  |    5=20
 tools/testing/selftests/vm/userfaultfd.c                |    4=20
 tools/testing/selftests/x86/sigreturn.c                 |   59 ++++---
 tools/testing/selftests/zram/zram.sh                    |    5=20
 tools/testing/selftests/zram/zram_lib.sh                |    5=20
 virt/kvm/arm/vgic/vgic-v3.c                             |    5=20
 347 files changed, 2651 insertions(+), 1284 deletions(-)

Adam Ford (2):
      ARM: davinci: board-da850-evm: fix WP pin polarity for MMC/SD
      ARM: dts: am3517.dtsi: Disable reference to OMAP3 OTG controller

Ajay Gupta (1):
      usb: xhci: increase CRS timeout value

Alex Deucher (1):
      drm/amdgpu: fix swapped emit_ib_size in vce3

Alexander Duyck (1):
      ixgbe: Be more careful when modifying MAC filters

Alexander Sverdlin (2):
      octeon_mgmt: Fix MIX registers configuration on MTU setup
      net: cavium: Add fine-granular dependencies on PCI

Alexandre Belloni (1):
      rtc: fix alarm read and set offset

Alexey Brodkin (2):
      ARC: Explicitly add -mmedium-calls to CFLAGS
      ARC: Enable machine_desc->init_per_cpu for !CONFIG_SMP

Alison Wang (1):
      drm: mali-dp: Enable Global SE interrupts mask for DP500

Anders Roxell (1):
      selftests: net: add config fragments

Andreas Schwab (1):
      RISC-V: fix R_RISCV_ADD32/R_RISCV_SUB32 relocations

Andrey Ryabinin (1):
      netfilter: nf_conntrack: Fix possible possible crash on module loadin=
g.

Andrzej Hajda (1):
      drm/bridge/sii8620: fix loops in EDID fetch logic

Andy Lutomirski (2):
      selftests/x86/sigreturn/64: Fix spurious failures on AMD CPUs
      selftests/x86/sigreturn: Do minor cleanups

Anson Huang (2):
      soc: imx: gpcv2: correct PGC offset
      soc: imx: gpc: restrict register range for regmap access

Ard Biesheuvel (1):
      KVM: arm/arm64: Drop resource size check for GICV window

Arnd Bergmann (2):
      ieee802154: mcr20a: add missing includes
      drm/sun4i: link in front-end code if needed

Artur Petrosyan (1):
      usb: dwc2: Fix host exit from hibernation flow.

Arun Kumar Neelakantam (2):
      net: qrtr: Broadcast messages only from control port
      net: qrtr: Reset the node and port ID of broadcast messages

Ayan Kumar Halder (3):
      drm/arm/malidp: Ensure that the crtcs are shutdown before removing an=
y encoder/connector
      drm/arm/malidp: Preserve LAYER_FORMAT contents when setting format
      drm/mali-dp: Rectify the width and height passed to rotmem_required()

Bart Van Assche (1):
      drbd: Fix drbd_request_prepare() discard handling

Bartosz Golaszewski (1):
      net: davinci_emac: match the mdio device against its compatible if po=
ssible

Bert Kenward (2):
      sfc: avoid hang from nested use of the filter_sem
      sfc: hold filter_sem consistently during reset

BingJing Chang (1):
      md/raid10: fix that replacement cannot complete recovery after reasse=
mble

Bob Copeland (1):
      nl80211: relax ht operation checks for mesh

Casey Leedom (1):
      cxgb4: assume flash part size to be 4MB, if it can't be determined

Casey Schaufler (1):
      Smack: Mark inode instant in smack_task_to_inode

Chengguang Xu (1):
      nfp: cast sizeof() to int when comparing with error code

Christian K=F6nig (1):
      PCI: Restore resized BAR state on resume

Christophe Jaillet (1):
      IB/mlx4: Fix an error handling path in 'mlx4_ib_rereg_user_mr()'

Chunfeng Yun (1):
      usb: gadget: composite: fix delayed_status race condition when set_in=
terface

Damien Th=E9bault (1):
      platform/x86: dell-laptop: Fix backlight detection

Dan Carpenter (10):
      blk-mq-debugfs: Off by one in blk_mq_rq_state_name()
      block: sed-opal: Fix a couple off by one bugs
      typec: tcpm: Fix a msecs vs jiffies bug
      clk: davinci: cfgchip: testing the wrong variable
      dmaengine: k3dma: Off by one in k3_of_dma_simple_xlate()
      qed: off by one in qed_parse_mcp_trace_buf()
      ixgbe: Off by one in ixgbe_ipsec_tx()
      qlogic: check kstrtoul() for errors
      pinctrl: nsp: off by ones in nsp_pinmux_enable()
      drm/nouveau/gem: off by one bugs in nouveau_gem_pushbuf_reloc_apply()

Daniel Borkmann (1):
      bpf, s390: fix potential memleak when later bpf_jit_prog fails

Daniel Mack (2):
      ARM: dts: am437x: make edt-ft5x06 a wakeup source
      ARM: pxa: irq: fix handling of ICMR registers in suspend/resume

Dave Hansen (4):
      mm: Allow non-direct-map arguments to free_reserved_area()
      x86/mm/init: Pass unconverted symbol addresses to free_init_pages()
      x86/mm/init: Add helper for freeing kernel image pages
      x86/mm/init: Remove freed kernel image areas from alias mapping

Dave Jiang (2):
      acpi/nfit: fix cmd_rc for acpi_nfit_ctl to always return a value
      nfit: fix unchecked dereference in acpi_nfit_ctl

David Francis (1):
      amd/dc/dce100: On dce100, set clocks to 0 on suspend

David Lechner (1):
      net: usb: rtl8150: demote allmulti message to dev_dbg()

Davide Caratti (2):
      net/sched: act_csum: fix NULL dereference when 'goto chain' is used
      net/sched: act_tunnel_key: fix NULL dereference when 'goto chain' is =
used

Denis Kenzior (1):
      mac80211: disable BHs/preemption in ieee80211_tx_control_port()

Dinh Nguyen (1):
      net: stmmac: socfpga: add additional ocp reset line for Stratix10

Dirk Gouders (1):
      kconfig: fix line numbers for if-entries in menu tree

Dmitry Osipenko (2):
      gpu: host1x: Skip IOMMU initialization if firewall is enabled
      gpu: host1x: Check whether size of unpin isn't 0

Don Brace (1):
      scsi: hpsa: correct enclosure sas address

Dong Jia Shi (1):
      vfio: ccw: fix error return in vfio_ccw_sch_event

Dongjiu Geng (1):
      usb: xhci: remove the code build warning

Doron Roberts-Kedes (2):
      nbd: Add the nbd NBD_DISCONNECT_ON_CLOSE config flag.
      tls: fix skb_to_sgvec returning unhandled error.

Douglas Anderson (1):
      nvmem: Don't let a NULL cell_id for nvmem_cell_get() crash us

Eli Cohen (1):
      net/mlx5: E-Switch, Disallow vlan/spoofcheck setup if not being esw m=
anager

Eric Biggers (1):
      crypto: arm/speck - fix building in Thumb2 mode

Eric Dumazet (2):
      netfilter: ipv6: nf_defrag: reduce struct net memory waste
      xfrm_user: prevent leaking 2 bytes of kernel memory

Esben Haabendal (1):
      i2c: imx: Fix race condition in dma read

Evan Quan (1):
      drm/amd/powerplay: correct vega12 thermal support as true

Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Select ULPI support
      ARM: imx_v4_v5_defconfig: Select ULPI support

Fathi Boudra (1):
      selftests: sync: add config fragment for testing sync framework

Florian Fainelli (4):
      ARM: dts: NSP: Fix i2c controller interrupt type
      ARM: dts: NSP: Fix PCIe controllers interrupt types
      ARM: dts: HR2: Fix interrupt types for i2c and PCIe
      ARM: dts: BCM5301x: Fix i2c controller interrupt type

Florian Westphal (3):
      netfilter: x_tables: set module owner for icmp(6) matches
      netfilter: nft_compat: explicitly reject ERROR and standard target
      netfilter: conntrack: dccp: treat SYNC/SYNCACK as invalid if no prior=
 state

Frank Rowand (1):
      of: overlay: update phandle cache on overlay apply and remove

Frederic Weisbecker (1):
      sched/nohz: Skip remote tick on idle task entirely

Ganesh Goudar (1):
      cxgb4: when disabling dcb set txq dcb priority to 0

Gao Feng (1):
      netfilter: nf_ct_helper: Fix possible panic after nf_conntrack_helper=
_unregister

Geert Uytterhoeven (1):
      mtd: dataflash: Use ULL suffix for 64-bit constants

Govindarajulu Varadarajan (1):
      enic: initialize enic->rfs_h.lock in enic_probe

Greentime Hu (1):
      nds32: Fix the dts pointer is not passed correctly issue.

Greg Kroah-Hartman (1):
      Linux 4.17.19

Greg Ungerer (1):
      m68k: fix "bad page state" oops on ColdFire boot

Grigor Tovmasyan (1):
      usb: gadget: dwc2: fix memory leak in gadget_init()

Guenter Roeck (1):
      hwmon: (nct6775) Fix loop limit

Gustavo A. R. Silva (2):
      drm/i915/kvmgt: Fix potential Spectre v1
      drm/amdgpu/pm: Fix potential Spectre v1

Gustavo Pimentel (1):
      ARC: [plat-hsdk]: Configure APB GPIO controller on ARC HSDK platform

Haiyue Wang (1):
      ipmi: kcs_bmc: fix IRQ exception if the channel is not open

Hangbin Liu (2):
      ipv6: mcast: fix unsolicited report interval after receiving querys
      ipvlan: call dev_change_flags when ipvlan mode is reset

Hans de Goede (2):
      NFC: pn533: Fix wrong GFP flag usage
      i2c: core: ACPI: Properly set status byte to 0 for multi-byte writes

Harini Katakam (1):
      net: macb: Free RX ring for all queues

Heikki Krogerus (1):
      usb: dwc3: pci: add support for Intel IceLake

Heiner Kallweit (1):
      r8169: fix mac address change

Helge Eichelberg (1):
      hwmon: (dell-smm) Disable fan support for Dell XPS13 9333

Hoan Tran (1):
      drivers/perf: xgene_pmu: Fix IOB SLOW PMU parser error

Israel Rukshin (1):
      nvme-rdma: Fix command completion race at error recovery

Jakub Kicinski (2):
      selftests/bpf: test offloads even with BPF programs present
      nfp: bpf: don't stop offload if replace failed

Jann Horn (2):
      netfilter: nf_log: fix uninit read in nf_log_proc_dostring
      reiserfs: fix broken xattr handling (heap corruption, bad retval)

Janne Huttunen (1):
      perf script python: Fix dict reference counting

Janusz Krzysztofik (1):
      dmaengine: ti: omap-dma: Fix OMAP1510 incorrect residue_granularity

Jason Gerecke (1):
      HID: wacom: Correct touch maximum XY of 2nd-gen Intuos

Jeff Moyer (1):
      dev-dax: check_vma: ratelimit dev_info-s

Jeffrin Jose T (1):
      selftests: bpf: notification about privilege required to run test_kmo=
d.sh testing script

Jens Axboe (1):
      blk-mq: don't queue more if we get a busy return

Jeremy Cline (2):
      perf tools: Use python-config --includes rather than --cflags
      ext4: fix spectre gadget in ext4_mb_regular_allocator()

Jerome Brunet (1):
      ARM64: dts: meson-axg: fix ethernet stability issue

Jianchao Wang (1):
      nvme-pci: move nvme_kill_queues to nvme_remove_dead_ctrl

Jim Mattson (1):
      kvm: nVMX: Restore exit qual for VM-entry failure due to MSR loading

Jim Wilson (1):
      RISC-V: Fix PTRACE_SETREGSET bug.

Jiri Olsa (4):
      perf tools: Fix error index for pmu event parser
      perf tests: Add event parsing error handling to parse events test
      perf bench: Fix numa report output code
      perf tools: Fix compilation errors on gcc8

Johan Hovold (1):
      usb: dwc3: of-simple: fix use-after-free on remove

Johannes Berg (1):
      nl80211: check nla_parse_nested() return values

John Allen (1):
      ibmvnic: Fix error recovery on login failure

John David Anglin (2):
      parisc: Remove unnecessary barriers from spinlock.h
      parisc: Remove ordered stores from syscall.S

John Fastabend (1):
      bpf: fix sk_skb programs without skb->dev assigned

John Garry (1):
      libahci: Fix possible Spectre-v1 pmp indexing in ahci_led_store()

Jon Maloy (4):
      tipc: fix wrong return value from function tipc_node_try_addr()
      tipc: correct discovery message handling during address trial period
      tipc: fix correct setting of message type in second discoverer
      tipc: make function tipc_net_finalize() thread safe

Josh Poimboeuf (1):
      objtool: Support GCC 8 '-fnoreorder-functions'

Julia Lawall (1):
      clocksource/drivers/stm32: Fix error return code

Julian Wiedmann (1):
      s390/qeth: consistently re-enable device features

Juri Lelli (1):
      sched/deadline: Fix switched_from_dl() warning

Kai-Heng Feng (1):
      usb: xhci: dbc: Don't decrement runtime PM counter if DBC is not star=
ted

Kalderon, Michal (1):
      RDMA/qedr: Fix NULL pointer dereference when running over iWARP witho=
ut RDMA-CM

Kamal Heib (1):
      RDMA/mlx5: Fix memory leak in mlx5_ib_create_srq() error path

Karsten Graul (1):
      net/smc: reset recv timeout after clc handshake

Katsuhiro Suzuki (1):
      arm64: dts: uniphier: fix widget name of headphone for LD11/LD20 boar=
ds

Keerthy (1):
      ARM: dts: da850: Fix interrups property for gpio

Kim Phillips (2):
      perf llvm-utils: Remove bashism from kernel include fetch script
      perf test shell: Prevent temporary editor files from being considered=
 test scripts

Laura Abbott (2):
      tools: build: Fixup host c flags
      tools: build: Use HOSTLDFLAGS with fixdep

Li RongQing (1):
      net: propagate dev_get_valid_name return code

Linus L=FCssing (2):
      batman-adv: Avoid storing non-TT-sync flags on singular entries too
      batman-adv: Fix multicast TT issues with bogus ROAM flags

Linus Torvalds (3):
      mm: use helper functions for allocating and freeing vm_area structs
      mm: make vm_area_dup() actually copy the old vma data
      mm: make vm_area_alloc() initialize core fields

Lubomir Rintel (1):
      ieee802154: 6lowpan: set IFLA_LINK

Lucas Stach (1):
      Input: synaptics-rmi4 - fix axis-swap behavior

Lukas Wunner (3):
      PCI: hotplug: Don't leak pci_slot on registration failure
      PCI: pciehp: Fix use-after-free on unplug
      PCI: pciehp: Fix unprotected list iteration in IRQ handler

Maciej Purski (4):
      drm/bridge/sii8620: fix display modes validation
      drm/bridge/sii8620: fix potential buffer overflow
      drm/bridge/sii8620: fix display of packed pixel modes in MHL2
      drm/bridge/sii8620: Fix display of packed pixel modes

Madalin Bucur (2):
      fsl/fman: fix parser reporting bad checksum on short frames
      dpaa_eth: DPAA SGT needs to be 256B

Manish Rangankar (1):
      scsi: qedi: Send driver state to MFW

Marc Zyngier (2):
      irqchip/gic-v2m: Fix SPI release on error path
      irqchip/gic-v3-its: Fix reprogramming of redistributors on CPU hotplug

Marcelo Ricardo Leitner (1):
      sctp: fix erroneous inc of snmp SctpFragUsrMsgs

Marek Szyprowski (5):
      arm64: dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag
      dmaengine: pl330: report BURST residue granularity
      drm/exynos: gsc: Fix support for NV16/61, YUV420/YVU420 and YUV422 mo=
des
      drm/exynos: decon5433: Fix per-plane global alpha for XRGB modes
      drm/exynos: decon5433: Fix WINCONx reset value

Martin Blumenstingl (1):
      ARM64: dts: meson-gxl: fix Mali GPU compatible string

Masahiro Yamada (2):
      clk: sunxi-ng: replace lib-y with obj-y
      kbuild: suppress warnings from 'getconf LFS_*'

Mathieu Malaterre (1):
      tracing: Use __printf markup to silence compiler

Matthijs van Duin (1):
      pty: fix O_CLOEXEC for TIOCGPTPEER

Mauricio Vasquez B (1):
      bpf: hash map: decrement counter on error

Max Gurtuvoy (1):
      nvmet: reset keep alive timer in controller enable

Michael Chan (3):
      bnxt_en: Fix inconsistent BNXT_FLAG_AGG_RINGS logic.
      bnxt_en: Always set output parameters in bnxt_get_max_rings().
      bnxt_en: Do not modify max IRQ count after RDMA driver requests/frees=
 IRQs.

Michael Hennerich (2):
      net: ieee802154: adf7242: Fix erroneous RX enable
      net: ieee802154: adf7242: Fix OCL calibration runs

Michael Trimarchi (1):
      brcmfmac: stop watchdog before detach and free everything

Mika Westerberg (1):
      ACPI / EC: Use ec_no_wakeup on Thinkpad X1 Carbon 6th

Mikko Perttunen (1):
      drm/tegra: Fix comparison operator for buffer size

Minas Harutyunyan (2):
      usb: dwc2: gadget: Fix issue in dwc2_gadget_start_isoc()
      dwc2: gadget: Fix ISOC IN DDMA PID bitfield value calculation

Myron Stowe (1):
      PCI: Skip MPS logic for Virtual Functions (VFs)

Nicholas Mc Guire (3):
      PCI: xilinx: Add missing of_node_put()
      PCI: xilinx-nwl: Add missing of_node_put()
      PCI: faraday: Add missing of_node_put()

Nicholas Piggin (1):
      powerpc: smp_send_stop do not offline stopped CPUs

Nicolas Boichat (1):
      HID: google: Add support for whiskers

Nishanth Menon (1):
      ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of BTB) for seco=
ndary cores

Palmer Dabbelt (1):
      RISC-V: Don't include irq-riscv-intc.h

Paolo Abeni (1):
      ipfrag: really prevent allocation on netns exit

Paul Cercueil (1):
      pinctrl: ingenic: Fix inverted direction for < JZ4770

Paul Moore (1):
      ipv6: make ipv6_renew_options() interrupt/kernel safe

Pavel Machek (1):
      ARM: dts: omap4-droid4: fix dts w.r.t. pwm

Peng Hao (1):
      kvmclock: fix TSC calibration for nested guests

Peter Chen (1):
      usb: chipidea: host: fix disconnection detect issue

Peter Zijlstra (2):
      kthread, sched/core: Fix kthread_parkme() (again...)
      ARC: Improve cmpxchg syscall implementation

Qu Wenruo (1):
      btrfs: scrub: Don't use inode page cache in scrub_handle_errored_bloc=
k()

Rafael J. Wysocki (1):
      PCI / ACPI / PM: Resume all bridges on suspend-to-RAM

Randy Dunlap (2):
      net/ethernet/freescale/fman: fix cross-build error
      tcp: identify cryptic messages as TCP seq # bugs

Ravi Bangoria (2):
      perf script: Fix crash because of missing evsel->priv
      perf tools: Fix crash caused by accessing feat_ops[HEADER_LAST_FEATUR=
E]

Ray Jui (5):
      ARM: dts: Cygnus: Fix I2C controller interrupt type
      ARM: dts: Cygnus: Fix PCIe controller interrupt type
      arm64: dts: ns2: Fix I2C controller interrupt type
      arm64: dts: ns2: Fix PCIe controller interrupt type
      arm64: dts: Stingray: Fix I2C controller interrupt type

Rob Herring (1):
      arm64: dts: msm8916: fix Coresight ETF graph connections

Robin H. Johnson (1):
      ACPI / EC: Use ec_no_wakeup on more Thinkpad X1 Carbon 6th systems

Roland Dreier (1):
      nvme: fix handling of metadata_len for NVME_IOCTL_IO_CMD

Russell King (4):
      drm/armada: fix colorkey mode property
      drm/armada: fix irq handling
      sfp: ensure we clean up properly on bus registration failure
      sfp: fix module initialisation with netdev already up

Ryan Hsu (1):
      ath10k: update the phymode along with bandwidth change request

Sagi Grimberg (1):
      nvme-rdma: fix possible double free condition when failing to create =
a controller

Sandipan Das (1):
      perf report powerpc: Fix crash if callchain is empty

Saurav Kashyap (1):
      scsi: qedf: Send the driver state to MFW

Scott Bauer (1):
      nvme: ensure forward progress during Admin passthru

Scott Branden (2):
      arm64: dts: specify 1.8V EMMC capabilities for bcm958742k
      arm64: dts: specify 1.8V EMMC capabilities for bcm958742t

Sergei Shtylyov (8):
      PCI: OF: Fix I/O space page leak
      PCI: xgene: Fix I/O space page leak
      PCI: versatile: Fix I/O space page leak
      PCI: designware: Fix I/O space page leak
      PCI: aardvark: Fix I/O space page leak
      PCI: faraday: Fix I/O space page leak
      PCI: mediatek: Fix I/O space page leak
      PCI: v3-semi: Fix I/O space page leak

Shuah Khan (Samsung OSG) (6):
      selftests: pstore: return Kselftest Skip code for skipped tests
      selftests: static_keys: return Kselftest Skip code for skipped tests
      selftests: sysctl: return Kselftest Skip code for skipped tests
      selftests: user: return Kselftest Skip code for skipped tests
      selftests: zram: return Kselftest Skip code for skipped tests
      selftests: vm: return Kselftest Skip code for skipped tests

Sowmini Varadhan (1):
      rds: clean up loopback rds_connections on netns deletion

Stafford Horne (1):
      openrisc: entry: Fix delay slot exception detection

Stefan Agner (1):
      net: hamradio: use eth_broadcast_addr

Stefan Schmidt (3):
      ieee802154: at86rf230: switch from BUG_ON() to WARN_ON() on problem
      ieee802154: at86rf230: use __func__ macro for debug messages
      ieee802154: fakelb: switch from BUG_ON() to WARN_ON() on problem

Stefan Wahren (3):
      net: qca_spi: Avoid packet drop during initial sync
      net: qca_spi: Make sure the QCA7000 reset is triggered
      net: qca_spi: Fix log level if probe fails

Stephen Hemminger (1):
      hv/netvsc: fix handling of fallback to single queue mode

Steve French (1):
      smb3: increase initial number of credits requested to allow write

Steven Rostedt (VMware) (2):
      locking/lockdep: Do not record IRQ state within lockdep code
      ARM: 8780/1: ftrace: Only set kernel memory back to read-only after b=
oot

Sudarsana Reddy Kalluru (4):
      qed: Fix possible memory leak in Rx error path handling.
      qed: Add sanity check for SIMD fastpath handler.
      qed: Do not advertise DCBX_LLD_MANAGED capability.
      bnx2x: Fix receiving tx-timeout in error or recovery state.

Sven Eckelmann (4):
      batman-adv: Fix bat_ogm_iv best gw refcnt after netlink dump
      batman-adv: Fix bat_v best gw refcnt after netlink dump
      batman-adv: Fix debugfs path for renamed hardif
      batman-adv: Fix debugfs path for renamed softif

Taeung Song (4):
      samples/bpf: add missing <linux/if_vlan.h>
      samples/bpf: Check the result of system()
      samples/bpf: Check the error of write() and read()
      samples/bpf: Fix tc and ip paths in xdp2skb_meta.sh

Takashi Iwai (2):
      ALSA: seq: Fix UBSAN warning at SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT ioc=
tl
      EDAC: Add missing MEM_LRDDR4 entry in edac_mem_types[]

Thomas Falcon (1):
      ibmvnic: Revise RX/TX queue error messages

Thomas Richter (2):
      perf record: Support s390 random socket_id assignment
      perf test session topology: Fix test on s390

Tomasz Duszynski (1):
      iio: pressure: bmp280: fix relative humidity unit

Trond Myklebust (1):
      pNFS: Always free the session slot on error in nfs4_layoutget_handle_=
exception

Ursula Braun (1):
      net/smc: no shutdown in state SMC_LISTEN

Uwe Kleine-K=F6nig (1):
      ARM: dts: imx6: RDU2: fix irq type for mv88e6xxx switch

Venkat Duvvuru (1):
      bnxt_en: Fix the vlan_tci exact match check.

Vijay Immanuel (1):
      IB/rxe: Fix missing completion for mem_reg work requests

Vikas Gupta (1):
      bnxt_en: Fix for system hang if request_irq fails

Vincent Guittot (1):
      sched/util_est: Fix util_est_dequeue() for throttled cfs_rq

Vincent Pelletier (1):
      usb: gadget: ffs: Fix BUG when userland exits with submitted AIO tran=
sfers

Viresh Kumar (1):
      arm: dts: armada: Fix "#cooling-cells" property's name

Vishal Verma (1):
      tools/testing/nvdimm: advertise a write cache for nfit_test

Vladimir Zapolskiy (4):
      sh_eth: fix invalid context bug while calling auto-negotiation by eth=
tool
      sh_eth: fix invalid context bug while changing link options by ethtool
      ravb: fix invalid context bug while calling auto-negotiation by ethto=
ol
      ravb: fix invalid context bug while changing link options by ethtool

Wang Dongsheng (1):
      net: phy: marvell: change default m88e1510 LED configuration

Wei Yongjun (1):
      pinctrl: nsp: Fix potential NULL dereference

Will Deacon (1):
      arm64: Avoid flush_icache_range() in alternatives patching code

Willem de Bruijn (2):
      packet: reset network header if packet shorter than ll reserved space
      packet: refine ring v3 block size test to hold one frame

William Wu (2):
      usb: dwc2: alloc dma aligned buffer for isoc split in
      usb: dwc2: fix isoc split in transfer with no data

Xunlei Pang (1):
      sched/fair: Fix bandwidth timer clock drift condition

Yan, Zheng (1):
      ceph: fix dentry leak in splice_dentry()

Yonghong Song (1):
      perf tools: Fix a clang 7.0 compilation error

Yuchung Cheng (1):
      tcp: remove DELAYED ACK events in DCTCP

Yuiko Oshino (1):
      smsc75xx: Add workaround for gigabit link up hardware errata.

Zhen Lei (1):
      kasan: fix shadow_size calculation error in kasan_module_alloc

Zhenzhong Duan (2):
      x86/microcode/intel: Fix memleak in save_microcode_patch()
      x86/mm/32: Initialize the CR4 shadow before __flush_tlb_all()

Zhizhou Zhang (1):
      arm64: make secondary_start_kernel() notrace

Zhouyang Jia (3):
      xen: add error handling for xenbus_printf
      scsi: xen-scsifront: add error handling for xenbus_printf
      xen/scsiback: add error handling for xenbus_printf

Zhu Yanjun (1):
      IB/rxe: avoid double kfree skb

piaojun (1):
      net/9p/client.c: put refcount of trans_mod in error case in parse_opt=
s()


--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt/9XsACgkQONu9yGCS
aT4c9Q/+Npja/0V4wPuLi1hDXCBKQDgH+HMIvFUzryVXWc5VO+rOXl1A1dcAA5Vr
Oz8DVES2XybpTb4OZxQogo5BDYvdUfCEps5KN+lXkr5BZ2nvWGQmfHXjElER1k2K
L540aQd6SreZa2Y43R4zrQ98SHbte3uE74vvwPWrtqdkNZTMLcT4FGapqEo1VI+2
553mlX2kisuLNdDpr5FXKB+lY10FtzoF2DZpWRgY59KXqfokD3sidiQfI7YMaZmF
jFJ5Ts5ogiHH1ZRPV2Ww320k3yxwCuyeZylVUY30zOVynVuPq4aCwSp08o9fpaaz
YyRFJt2e5d0DmNJ/H4JhuWGcvRhm/W3YHVcsrehTU1tX9eWGfZ2IB8/Ib2SjokDl
KrGl+vA+Yd1Ju3wX072qAW/5fGNvzqLyZBVoriYBwSavEQhU0YUdboxGldj+Z4Ra
NjezjNIIAeELHzRQzICAJg1YSxnw13k6MSp+KZOgLenZX181RD31s/HBl3Tgpg7R
mbNZFJ7NovGl2WfOsMPhjZ4yenjMC0cu4901GkXxc3roeOxWNPmEg98yZ6BHNsB5
NF795WPrMhNhP7l5gxkfDIvvoJ8bpvV98Wx0Oz5f0LQ8Z4PjvMJ101ikvQ8oaIgA
PK972/+0ih3/lp9y1HNvb/42IdgcQwyh2rhjdmeR78qnsnXcpfw=
=WlbZ
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
