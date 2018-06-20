Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08A4C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6075F20875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6075F20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933481AbeFTUnF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:43:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56492 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933154AbeFTUmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:42:49 -0400
Received: from localhost (113x41x139x141.ap113.ftth.ucom.ne.jp [113.41.139.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A2F2ACB8;
        Wed, 20 Jun 2018 20:42:48 +0000 (UTC)
Date:   Thu, 21 Jun 2018 05:42:46 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.17
Message-ID: <20180620204246.GA12773@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.17 kernel.

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

 Documentation/devicetree/bindings/display/panel/panel-common.txt          =
                |    2=20
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt               =
                |    1=20
 Documentation/devicetree/bindings/net/renesas,ravb.txt                    =
                |    1=20
 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt     =
                |    6=20
 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt           =
                |    2=20
 Documentation/devicetree/bindings/serial/mvebu-uart.txt                   =
                |    2=20
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt           =
                |    2=20
 Documentation/devicetree/bindings/vendor-prefixes.txt                     =
                |    1=20
 Makefile                                                                  =
                |    2=20
 arch/arm/boot/compressed/Makefile                                         =
                |    8=20
 arch/arm/boot/compressed/head.S                                           =
                |   20=20
 arch/arm/boot/dts/bcm-cygnus.dtsi                                         =
                |    2=20
 arch/arm/boot/dts/da850.dtsi                                              =
                |    2=20
 arch/arm/boot/dts/dm8148-evm.dts                                          =
                |    2=20
 arch/arm/boot/dts/dm8148-t410.dts                                         =
                |    2=20
 arch/arm/boot/dts/dm8168-evm.dts                                          =
                |    2=20
 arch/arm/boot/dts/dra62x-j5eco-evm.dts                                    =
                |    2=20
 arch/arm/boot/dts/imx51-zii-rdu1.dts                                      =
                |    6=20
 arch/arm/boot/dts/logicpd-som-lv.dtsi                                     =
                |   11=20
 arch/arm/boot/dts/omap4.dtsi                                              =
                |    8=20
 arch/arm/include/uapi/asm/siginfo.h                                       =
                |   13=20
 arch/arm/kernel/machine_kexec.c                                           =
                |   34 -
 arch/arm/mach-davinci/board-da830-evm.c                                   =
                |    9=20
 arch/arm/mach-davinci/board-da850-evm.c                                   =
                |    9=20
 arch/arm/mach-davinci/board-dm355-evm.c                                   =
                |   15=20
 arch/arm/mach-davinci/board-dm644x-evm.c                                  =
                |   10=20
 arch/arm/mach-davinci/board-dm646x-evm.c                                  =
                |    5=20
 arch/arm/mach-davinci/board-omapl138-hawk.c                               =
                |   10=20
 arch/arm/mach-davinci/dm646x.c                                            =
                |    3=20
 arch/arm/mach-keystone/pm_domain.c                                        =
                |    1=20
 arch/arm/mach-omap1/ams-delta-fiq.c                                       =
                |   28=20
 arch/arm/mach-omap2/powerdomain.c                                         =
                |    4=20
 arch/arm/vfp/vfpmodule.c                                                  =
                |    2=20
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi                       =
                |    4=20
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts              =
                |   12=20
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts               =
                |    4=20
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi                     =
                |    4=20
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                                =
                |   61 +
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts                     =
                |    4=20
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi                                =
                |   17=20
 arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi                  =
                |   80 +-
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi                            =
                |    2=20
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi                          =
                |    2=20
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi                          =
                |    2=20
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi                          =
                |    2=20
 arch/arm64/include/asm/cputype.h                                          =
                |    6=20
 arch/arm64/kernel/ptrace.c                                                =
                |   20=20
 arch/arm64/kernel/traps.c                                                 =
                |    3=20
 arch/arm64/mm/kasan_init.c                                                =
                |    4=20
 arch/hexagon/include/asm/io.h                                             =
                |    6=20
 arch/hexagon/lib/checksum.c                                               =
                |    1=20
 arch/mips/boot/dts/img/boston.dts                                         =
                |    6=20
 arch/mips/include/asm/io.h                                                =
                |    4=20
 arch/parisc/kernel/drivers.c                                              =
                |    7=20
 arch/parisc/kernel/smp.c                                                  =
                |    3=20
 arch/parisc/kernel/time.c                                                 =
                |    2=20
 arch/powerpc/include/asm/topology.h                                       =
                |   13=20
 arch/powerpc/kernel/setup_64.c                                            =
                |   11=20
 arch/powerpc/kvm/booke.c                                                  =
                |    7=20
 arch/powerpc/platforms/cell/spufs/sched.c                                 =
                |    2=20
 arch/powerpc/platforms/powernv/memtrace.c                                 =
                |   17=20
 arch/riscv/Kconfig                                                        =
                |    4=20
 arch/riscv/kernel/vdso/Makefile                                           =
                |    2=20
 arch/sh/Kconfig                                                           =
                |    1=20
 arch/sh/kernel/cpu/sh2/probe.c                                            =
                |    4=20
 arch/sh/kernel/setup.c                                                    =
                |    1=20
 arch/sh/mm/init.c                                                         =
                |   68 --
 arch/sh/mm/numa.c                                                         =
                |   19=20
 arch/x86/events/intel/core.c                                              =
                |    9=20
 arch/x86/include/asm/insn.h                                               =
                |   18=20
 arch/x86/include/asm/kvm_host.h                                           =
                |    1=20
 arch/x86/kernel/cpu/intel.c                                               =
                |    3=20
 arch/x86/kernel/kexec-bzimage64.c                                         =
                |    5=20
 arch/x86/kernel/kprobes/core.c                                            =
                |    4=20
 arch/x86/kernel/uprobes.c                                                 =
                |    4=20
 arch/x86/kvm/hyperv.c                                                     =
                |    2=20
 arch/x86/kvm/svm.c                                                        =
                |   31=20
 arch/x86/kvm/vmx.c                                                        =
                |   95 +-
 arch/x86/kvm/x86.c                                                        =
                |   33 -
 arch/x86/net/bpf_jit_comp.c                                               =
                |   18=20
 arch/x86/xen/enlighten_hvm.c                                              =
                |   13=20
 block/blk-cgroup.c                                                        =
                |   22=20
 block/blk-mq.c                                                            =
                |   19=20
 block/blk-mq.h                                                            =
                |    4=20
 block/genhd.c                                                             =
                |   12=20
 block/partition-generic.c                                                 =
                |   10=20
 drivers/acpi/acpi_watchdog.c                                              =
                |   59 +
 drivers/acpi/scan.c                                                       =
                |    2=20
 drivers/acpi/sleep.c                                                      =
                |   13=20
 drivers/ata/ahci.c                                                        =
                |    6=20
 drivers/ata/ahci.h                                                        =
                |    7=20
 drivers/ata/ahci_mvebu.c                                                  =
                |   56 +
 drivers/ata/ahci_qoriq.c                                                  =
                |    2=20
 drivers/ata/ahci_xgene.c                                                  =
                |    4=20
 drivers/ata/libahci.c                                                     =
                |   20=20
 drivers/ata/libata-eh.c                                                   =
                |    4=20
 drivers/ata/sata_highbank.c                                               =
                |    2=20
 drivers/char/agp/uninorth-agp.c                                           =
                |    4=20
 drivers/clk/clk-mux.c                                                     =
                |   10=20
 drivers/clk/clk.c                                                         =
                |    7=20
 drivers/clk/imx/clk-imx6ul.c                                              =
                |    2=20
 drivers/clocksource/timer-imx-tpm.c                                       =
                |    8=20
 drivers/cpufreq/Kconfig.arm                                               =
                |   10=20
 drivers/cpufreq/brcmstb-avs-cpufreq.c                                     =
                |  323 ----------
 drivers/firmware/efi/libstub/arm64-stub.c                                 =
                |   10=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c                                   =
                |    6=20
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                                  =
                |   13=20
 drivers/gpu/drm/drm_dumb_buffers.c                                        =
                |    7=20
 drivers/gpu/drm/exynos/exynos_mixer.c                                     =
                |   22=20
 drivers/gpu/drm/exynos/regs-mixer.h                                       =
                |    1=20
 drivers/gpu/drm/msm/dsi/dsi_host.c                                        =
                |    2=20
 drivers/gpu/drm/msm/msm_fbdev.c                                           =
                |   11=20
 drivers/gpu/drm/msm/msm_gem.c                                             =
                |   20=20
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                                       =
                |    2=20
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c                                  =
                |    7=20
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                                       =
                |    2=20
 drivers/gpu/drm/omapdrm/omap_connector.c                                  =
                |   10=20
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c                                  =
                |    6=20
 drivers/gpu/drm/omapdrm/tcm-sita.c                                        =
                |    2=20
 drivers/gpu/drm/vc4/vc4_dpi.c                                             =
                |   25=20
 drivers/hid/Kconfig                                                       =
                |    7=20
 drivers/hid/hid-ids.h                                                     =
                |    9=20
 drivers/hid/hid-lenovo.c                                                  =
                |   36 +
 drivers/hid/i2c-hid/i2c-hid.c                                             =
                |    2=20
 drivers/hid/intel-ish-hid/ishtp/bus.c                                     =
                |    2=20
 drivers/hid/wacom_sys.c                                                   =
                |    4=20
 drivers/i2c/busses/i2c-pmcmsp.c                                           =
                |    4=20
 drivers/i2c/busses/i2c-sprd.c                                             =
                |   22=20
 drivers/i2c/busses/i2c-viperboard.c                                       =
                |    2=20
 drivers/infiniband/Kconfig                                                =
                |    5=20
 drivers/infiniband/core/cma.c                                             =
                |   60 +
 drivers/infiniband/core/iwpm_util.c                                       =
                |    5=20
 drivers/infiniband/core/mad.c                                             =
                |    4=20
 drivers/infiniband/core/uverbs_ioctl.c                                    =
                |    9=20
 drivers/infiniband/hw/hfi1/affinity.c                                     =
                |   11=20
 drivers/infiniband/hw/hfi1/init.c                                         =
                |   41 -
 drivers/infiniband/hw/hfi1/platform.c                                     =
                |    1=20
 drivers/infiniband/hw/hfi1/qsfp.c                                         =
                |    2=20
 drivers/infiniband/hw/hns/hns_roce_hem.c                                  =
                |    8=20
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                                =
                |   11=20
 drivers/infiniband/hw/mlx4/mr.c                                           =
                |    2=20
 drivers/infiniband/hw/mlx5/main.c                                         =
                |    4=20
 drivers/infiniband/sw/rxe/rxe_opcode.c                                    =
                |    2=20
 drivers/infiniband/sw/rxe/rxe_req.c                                       =
                |    1=20
 drivers/infiniband/sw/rxe/rxe_resp.c                                      =
                |    6=20
 drivers/infiniband/ulp/srp/Kconfig                                        =
                |    2=20
 drivers/infiniband/ulp/srpt/Kconfig                                       =
                |    2=20
 drivers/input/rmi4/rmi_spi.c                                              =
                |    7=20
 drivers/input/touchscreen/atmel_mxt_ts.c                                  =
                |  186 +++--
 drivers/iommu/dmar.c                                                      =
                |    2=20
 drivers/iommu/intel_irq_remapping.c                                       =
                |    2=20
 drivers/mtd/onenand/omap2.c                                               =
                |  105 +--
 drivers/net/can/dev.c                                                     =
                |    2=20
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c                           =
                |    3=20
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h                           =
                |    1=20
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c                      =
                |   21=20
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c                           =
                |    3=20
 drivers/net/ethernet/hisilicon/hns/hnae.h                                 =
                |    2=20
 drivers/net/ethernet/ibm/ibmvnic.c                                        =
                |    3=20
 drivers/net/ethernet/intel/igb/igb_main.c                                 =
                |   17=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c                            =
                |    2=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c                             =
                |    3=20
 drivers/net/ethernet/marvell/mvpp2.c                                      =
                |   15=20
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c                          =
                |   38 +
 drivers/net/ethernet/netronome/nfp/flower/cmsg.h                          =
                |    2=20
 drivers/net/ethernet/netronome/nfp/flower/main.c                          =
                |    8=20
 drivers/net/ethernet/netronome/nfp/flower/main.h                          =
                |    8=20
 drivers/net/ethernet/netronome/nfp/nfp_app_nic.c                          =
                |    2=20
 drivers/net/ethernet/netronome/nfp/nfp_main.h                             =
                |    4=20
 drivers/net/ethernet/netronome/nfp/nfp_net_main.c                         =
                |   31=20
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c                      =
                |    3=20
 drivers/net/ethernet/qlogic/qed/qed_l2.c                                  =
                |    6=20
 drivers/net/ethernet/qlogic/qede/qede_rdma.c                              =
                |    2=20
 drivers/net/phy/broadcom.c                                                =
                |   10=20
 drivers/net/phy/marvell.c                                                 =
                |    9=20
 drivers/net/phy/microchip.c                                               =
                |  178 +++++
 drivers/nvme/host/Kconfig                                                 =
                |    2=20
 drivers/nvme/host/core.c                                                  =
                |   32=20
 drivers/nvme/host/fabrics.c                                               =
                |    6=20
 drivers/nvme/host/multipath.c                                             =
                |   24=20
 drivers/nvme/host/nvme.h                                                  =
                |   12=20
 drivers/nvme/target/Kconfig                                               =
                |    2=20
 drivers/pci/dwc/pcie-kirin.c                                              =
                |    2=20
 drivers/pinctrl/intel/pinctrl-cherryview.c                                =
                |   16=20
 drivers/pinctrl/meson/pinctrl-meson-axg.c                                 =
                |    2=20
 drivers/platform/x86/Kconfig                                              =
                |    2=20
 drivers/remoteproc/qcom_q6v5_pil.c                                        =
                |    2=20
 drivers/reset/reset-uniphier.c                                            =
                |    6=20
 drivers/rpmsg/rpmsg_char.c                                                =
                |    2=20
 drivers/s390/net/qeth_core_main.c                                         =
                |   51 -
 drivers/s390/net/qeth_core_mpc.h                                          =
                |   12=20
 drivers/s390/net/qeth_l2_main.c                                           =
                |    4=20
 drivers/s390/net/smsgiucv.c                                               =
                |    2=20
 drivers/scsi/isci/port_config.c                                           =
                |    3=20
 drivers/scsi/megaraid/megaraid_sas_fusion.c                               =
                |    6=20
 drivers/scsi/scsi_transport_iscsi.c                                       =
                |   29=20
 drivers/scsi/storvsc_drv.c                                                =
                |    7=20
 drivers/scsi/vmw_pvscsi.c                                                 =
                |    2=20
 drivers/soc/bcm/raspberrypi-power.c                                       =
                |    2=20
 drivers/spi/spi-bcm2835aux.c                                              =
                |    5=20
 drivers/spi/spi-cadence.c                                                 =
                |    8=20
 drivers/spi/spi-sh-msiof.c                                                =
                |    1=20
 drivers/target/target_core_pscsi.c                                        =
                |    2=20
 drivers/tee/tee_core.c                                                    =
                |   11=20
 drivers/thermal/int340x_thermal/int3403_thermal.c                         =
                |    3=20
 drivers/usb/musb/musb_host.c                                              =
                |    5=20
 drivers/usb/musb/musb_host.h                                              =
                |    7=20
 drivers/usb/musb/musb_virthub.c                                           =
                |   25=20
 drivers/usb/typec/tps6598x.c                                              =
                |   47 +
 drivers/usb/typec/ucsi/Makefile                                           =
                |    2=20
 drivers/xen/xenbus/xenbus_dev_frontend.c                                  =
                |    3=20
 fs/afs/addr_list.c                                                        =
                |   25=20
 fs/afs/callback.c                                                         =
                |   56 +
 fs/afs/cmservice.c                                                        =
                |    6=20
 fs/afs/internal.h                                                         =
                |    7=20
 fs/afs/rotate.c                                                           =
                |   20=20
 fs/afs/rxrpc.c                                                            =
                |    7=20
 fs/afs/server.c                                                           =
                |   22=20
 fs/afs/server_list.c                                                      =
                |    7=20
 fs/cifs/Kconfig                                                           =
                |    2=20
 fs/cifs/smb2ops.c                                                         =
                |    6=20
 fs/cifs/smb2pdu.c                                                         =
                |   68 +-
 fs/cifs/transport.c                                                       =
                |    5=20
 fs/ecryptfs/crypto.c                                                      =
                |   41 -
 fs/ecryptfs/file.c                                                        =
                |   21=20
 fs/isofs/inode.c                                                          =
                |    3=20
 fs/namespace.c                                                            =
                |    2=20
 fs/notify/fsnotify.c                                                      =
                |   25=20
 fs/ocfs2/refcounttree.c                                                   =
                |   14=20
 fs/proc/base.c                                                            =
                |    6=20
 fs/proc/kcore.c                                                           =
                |   23=20
 fs/proc/loadavg.c                                                         =
                |    2=20
 fs/proc/task_mmu.c                                                        =
                |    6=20
 include/linux/brcmphy.h                                                   =
                |    1=20
 include/linux/clk-provider.h                                              =
                |    3=20
 include/linux/ethtool.h                                                   =
                |    2=20
 include/linux/genhd.h                                                     =
                |    4=20
 include/linux/kthread.h                                                   =
                |    1=20
 include/linux/kvm_host.h                                                  =
                |    8=20
 include/linux/microchipphy.h                                              =
                |    8=20
 include/linux/mtd/map.h                                                   =
                |    2=20
 include/linux/mtd/rawnand.h                                               =
                |   16=20
 include/linux/percpu-rwsem.h                                              =
                |    6=20
 include/linux/rwsem.h                                                     =
                |    6=20
 include/linux/sched.h                                                     =
                |   50 +
 include/linux/sched/signal.h                                              =
                |    2=20
 include/linux/stringhash.h                                                =
                |    4=20
 include/soc/bcm2835/raspberrypi-firmware.h                                =
                |    4=20
 init/main.c                                                               =
                |    7=20
 kernel/bpf/syscall.c                                                      =
                |   19=20
 kernel/kthread.c                                                          =
                |   50 -
 kernel/locking/rwsem-xadd.c                                               =
                |   19=20
 kernel/locking/rwsem.c                                                    =
                |    2=20
 kernel/locking/rwsem.h                                                    =
                |   30=20
 kernel/module.c                                                           =
                |    5=20
 kernel/sched/core.c                                                       =
                |   49 -
 kernel/sched/deadline.c                                                   =
                |    4=20
 kernel/sched/rt.c                                                         =
                |    2=20
 kernel/sched/sched.h                                                      =
                |    5=20
 kernel/signal.c                                                           =
                |   17=20
 kernel/stop_machine.c                                                     =
                |   19=20
 lib/find_bit_benchmark.c                                                  =
                |    7=20
 mm/memcontrol.c                                                           =
                |    2=20
 net/ipv6/ip6_vti.c                                                        =
                |    4=20
 net/ipv6/netfilter/Kconfig                                                =
                |   55 -
 net/mac80211/agg-tx.c                                                     =
                |    4=20
 net/mac80211/mlme.c                                                       =
                |   25=20
 net/mac80211/tx.c                                                         =
                |    3=20
 net/netfilter/nf_tables_api.c                                             =
                |    2=20
 net/rds/ib_cm.c                                                           =
                |    3=20
 net/rxrpc/af_rxrpc.c                                                      =
                |    2=20
 net/rxrpc/ar-internal.h                                                   =
                |    1=20
 net/rxrpc/input.c                                                         =
                |    2=20
 net/rxrpc/local_object.c                                                  =
                |   57 +
 net/rxrpc/output.c                                                        =
                |   11=20
 net/rxrpc/sendmsg.c                                                       =
                |   10=20
 net/sched/act_skbedit.c                                                   =
                |    3=20
 net/smc/af_smc.c                                                          =
                |    6=20
 net/sunrpc/xprtrdma/fmr_ops.c                                             =
                |    5=20
 net/sunrpc/xprtrdma/frwr_ops.c                                            =
                |    9=20
 net/sunrpc/xprtrdma/verbs.c                                               =
                |    5=20
 net/sunrpc/xprtrdma/xprt_rdma.h                                           =
                |    2=20
 net/tipc/monitor.c                                                        =
                |    2=20
 net/tipc/node.c                                                           =
                |   28=20
 scripts/Makefile.gcc-plugins                                              =
                |    2=20
 sound/soc/codecs/msm8916-wcd-analog.c                                     =
                |    9=20
 sound/soc/codecs/rt5514.c                                                 =
                |    3=20
 sound/soc/intel/Kconfig                                                   =
                |   22=20
 sound/soc/soc-topology.c                                                  =
                |    6=20
 tools/bpf/bpf_dbg.c                                                       =
                |    7=20
 tools/objtool/arch/x86/include/asm/insn.h                                 =
                |   18=20
 tools/perf/util/cs-etm.c                                                  =
                |   24=20
 tools/perf/util/pmu.c                                                     =
                |   20=20
 tools/perf/util/symbol.c                                                  =
                |    8=20
 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-ac=
tions-accept.tc |   44 +
 tools/testing/selftests/x86/Makefile                                      =
                |    2=20
 tools/testing/selftests/x86/mov_ss_trap.c                                 =
                |  285 ++++++++
 tools/testing/selftests/x86/mpx-mini-test.c                               =
                |    7=20
 tools/testing/selftests/x86/pkey-helpers.h                                =
                |   20=20
 tools/testing/selftests/x86/protection_keys.c                             =
                |  254 +++++--
 virt/kvm/arm/vgic/vgic-mmio-v2.c                                          =
                |    5=20
 virt/kvm/arm/vgic/vgic.c                                                  =
                |    8=20
 302 files changed, 2996 insertions(+), 1621 deletions(-)

Adam Ford (2):
      ARM: dts: logicpd-som-lv: Fix WL127x Startup Issues
      ARM: dts: logicpd-som-lv: Fix Audio Mute

Alexey Dobriyan (2):
      proc: revalidate kernel thread inodes to root:root
      proc: fix /proc/loadavg regression

Amir Goldstein (2):
      fsnotify: fix ignore mask logic in send_to_group()
      <linux/stringhash.h>: fix end_name_hash() for 64bit long

Andre Przywara (1):
      KVM: arm/arm64: vgic: Kick new VCPU on interrupt migration

Andres Rodriguez (1):
      drm/amdkfd: fix clock counter retrieval for node without GPU

Andrey Grodzovsky (1):
      drm/amdgpu: Switch to interruptable wait to recover from ring hang.

Andrzej Hajda (1):
      drm/exynos/mixer: fix synchronization check in interlaced mode

Andy Lutomirski (1):
      x86/selftests: Add mov_to_ss test

Anson Huang (1):
      clocksource/drivers/imx-tpm: Correct some registers operation flow

Arnaldo Carvalho de Melo (1):
      perf report: Fix switching to another perf.data file

Arnd Bergmann (2):
      hexagon: add memset_io() helper
      hexagon: export csum_partial_copy_nocheck

Arvind Yadav (2):
      HID: wacom: Release device resource data obtained by devres_alloc()
      HID: intel-ish-hid: use put_device() instead of kfree()

Ashish Samant (1):
      ocfs2: take inode cluster lock before moving reflinked inode from orp=
han dir

Aurelien Jarno (1):
      RISC-V: build vdso-dummy.o with -no-pie

Balbir Singh (1):
      powerpc/powernv/memtrace: Let the arch hotunplug code flush cache

Baolin Wang (3):
      parisc: time: Convert read_persistent_clock() to read_persistent_cloc=
k64()
      i2c: sprd: Prevent i2c accesses after suspend is called
      i2c: sprd: Fix the i2c count issue

Ben Hutchings (2):
      drm/msm: Fix possible null dereference on failure of get_pages()
      mtd: Fix comparison in map_word_andequal()

Bhadram Varka (2):
      arm64: tegra: Make BCM89610 PHY interrupt as active low
      net: phy: broadcom: add support for BCM89610 PHY

Changbin Du (1):
      iommu/vt-d: fix shift-out-of-bounds in bug checking

Chen Yu (1):
      ACPI / PM: Blacklist Low Power S0 Idle _DSM for ThinkPad X1 Tablet(20=
16)

Chengguang Xu (2):
      isofs: fix potential memory leak in mount option parsing
      nvme: fix potential memory leak in option parsing

Chris Leech (1):
      scsi: iscsi: respond to netlink with unicast when appropriate

Christoph Hellwig (1):
      riscv: select DMA_DIRECT_OPS instead of redefining it

Christophe JAILLET (1):
      Input: synaptics-rmi4 - fix an unchecked out of memory error path

Chuck Lever (1):
      xprtrdma: Fix list corruption / DMAR errors during MR recovery

Cl=C3=A9ment P=C3=A9ron (1):
      ARM: dts: cygnus: fix irq type for arm global timer

Colin Ian King (4):
      scsi: isci: Fix infinite loop in while loop
      RDMA/iwpm: fix memory leak on map_info
      net: aquantia: fix unsigned numvecs comparison with less than zero
      ixgbe: fix memory leak on ipsec allocation

Dag Moxnes (1):
      rds: ib: Fix missing call to rds_ib_dev_put in rds_ib_setup_qp

Dan Carpenter (2):
      drm/omap: silence unititialized variable warning
      drm/dumb-buffers: Integer overflow in drm_mode_create_ioctl()

Daniel Borkmann (3):
      bpf, x64: fix memleak when not converging after image
      bpf, x64: fix memleak when not converging on calls
      bpf: use array_index_nospec in find_prog_type

Daniel Gl=C3=B6ckner (1):
      usb: musb: fix remote wakeup racing with suspend

Darren Hart (1):
      platform/x86: DELL_WMI use depends on instead of select for DELL_SMBI=
OS

Dave Hansen (11):
      x86/pkeys/selftests: Give better unexpected fault error messages
      x86/pkeys/selftests: Stop using assert()
      x86/pkeys/selftests: Remove dead debugging code, fix dprint_in_signal
      x86/pkeys/selftests: Avoid printf-in-signal deadlocks
      x86/pkeys/selftests: Allow faults on unknown keys
      x86/pkeys/selftests: Factor out "instruction page"
      x86/pkeys/selftests: Add PROT_EXEC test
      x86/pkeys/selftests: Fix pkey exhaustion test off-by-one
      x86/pkeys/selftests: Fix pointer math
      x86/pkeys/selftests: Save off 'prot' for allocations
      x86/pkeys/selftests: Add a test for pkey 0

Dave Young (1):
      kexec_file: do not add extra alignment to efi memmap

David Gilhooley (1):
      arm64: Add MIDR encoding for NVIDIA CPUs

David Howells (11):
      afs: Fix server record deletion
      vfs: Undo an overly zealous MS_RDONLY -> SB_RDONLY conversion
      rxrpc: Fix missing start of call timeout
      rxrpc: Fix error reception on AF_INET6 sockets
      rxrpc: Fix the min security level for kernel calls
      afs: Fix address list parsing
      afs: Fix refcounting in callback registration
      afs: Fix server rotation's handling of fileserver probe failure
      afs: Fix VNOVOL handling in address rotation
      afs: Fix the handling of CB.InitCallBackState3 to find the server by =
UUID
      afs: Fix the non-encryption of calls

Emil Tantilov (1):
      ixgbe: return error on unsupported SFP module when resetting

Emil Velikov (1):
      drm/msm: don't deref error pointer in the msm_fbdev_create error path

Eric Anholt (1):
      drm/vc4: Fix oops dereferencing DPI's connector since panel_bridge.

Etienne Carriere (1):
      tee: check shm references are consistent in offset/size

Evan Wang (2):
      libahci: Allow drivers to override stop_engine
      ata: ahci: mvebu: override ahci_stop_engine for mvebu AHCI

Florian Fainelli (2):
      soc: bcm: raspberrypi-power: Fix use of __packed
      net: ethtool: Add missing kernel doc for FEC parameters

Ganesh Goudar (1):
      cxgb4: copy mbox log size to PF0-3 adap instances

Geert Uytterhoeven (5):
      soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies return failure
      dt-bindings: meson-uart: DT fix s/clocks-names/clock-names/
      dt-bindings: mvebu-uart: DT fix s/interrupts-names/interrupt-names/
      dt-bindings: panel: lvds: Fix path to display timing bindings
      mtd: rawnand: Fix return type of __DIVIDE() when called with 32-bit

Gianluca Borello (1):
      bpf, x64: fix JIT emission for dead code

Graeme Smecher (1):
      ARM: dts: correct missing "compatible" entry for ti81xx SoCs

Greg Kroah-Hartman (1):
      Linux 4.16.17

Greg Thelen (6):
      nvme: depend on INFINIBAND_ADDR_TRANS
      nvmet-rdma: depend on INFINIBAND_ADDR_TRANS
      ib_srpt: depend on INFINIBAND_ADDR_TRANS
      cifs: smbd: depend on INFINIBAND_ADDR_TRANS
      ib_srp: depend on INFINIBAND_ADDR_TRANS
      IB: make INFINIBAND_ADDR_TRANS configurable

Hans de Goede (2):
      thermal: int3403_thermal: Fix NULL pointer deref on module load / pro=
be
      HID: i2c-hid: Add RESEND_REPORT_DESCR quirk for Toshiba Click Mini L9=
W-B

Heikki Krogerus (1):
      usb: typec: tps6598x: handle block reads separately with plain-I2C ad=
apters

Helge Deller (2):
      parisc: drivers.c: Fix section mismatches
      parisc: Move setup_profiling_timer() out of init section

Huang Ying (1):
      mm, pagemap: fix swap offset value for PMD migration entry

H=C3=A5kon Bugge (1):
      IB/core: Make ib_mad_client_id atomic

Igor Russkikh (2):
      net: aquantia: driver should correctly declare vlan_features bits
      net: aquantia: Limit number of vectors to actually allocated irqs

Ilan Peer (1):
      mac80211: Adjust SAE authentication timeout

Ingo Molnar (3):
      objtool, kprobes/x86: Sync the latest <asm/insn.h> header with tools/=
objtool/arch/x86/include/asm/insn.h
      x86/pkeys/selftests: Adjust the self-test to fresh distros that expor=
t the pkeys ABI
      x86/mpx/selftests: Adjust the self-test to fresh distros that export =
the MPX ABI

Jack Morgenstein (1):
      IB/mlx4: Fix integer overflow when calculating optimal MTT size

Jacopo Mondi (3):
      dt-bindings: net: ravb: Add support for r8a77965 SoC
      dt-bindings: serial: sh-sci: Add support for r8a77965 (H)SCIF
      dt-bindings: dmaengine: rcar-dmac: document R8A77965 support

Jagannathan Raman (1):
      iommu/vt-d: Fix usage of force parameter in intel_ir_reconfigure_irte=
()

Jakob Unterwurzacher (1):
      can: dev: increase bus-off message severity

Jakub Kicinski (2):
      nfp: ignore signals when communicating with management FW
      nfp: don't depend on eth_tbl being available

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: fix deferred_fiq handler

Jeffrey Hugo (1):
      init: fix false positives in W+X checking

Jerome Brunet (1):
      clk: honor CLK_MUX_ROUND_CLOSEST in generic clk mux

Jianchao Wang (2):
      IB/rxe: add RXE_START_MASK for rxe_opcode IB_OPCODE_RC_SEND_ONLY_INV
      nvme: fix use-after-free in nvme_free_ns_head

Jiang Biao (2):
      blkcg: don't hold blkcg lock when deactivating policy
      blkcg: init root blkcg_gq under lock

Jim Gill (1):
      scsi: vmw-pvscsi: return DID_BUS_BUSY for adapter-initated aborts

Jingju Hou (1):
      net: phy: marvell: clear wol event before setting it

John Fastabend (1):
      bpf: fix uninitialized variable in bpf tools

Jon Maloy (1):
      tipc: fix bug in function tipc_nl_node_dump_monitor

Julian Wiedmann (1):
      s390/qeth: fix request-side race during cmd IO timeout

Junaid Shahid (1):
      kvm: apic: Flush TLB after APIC mode/address change if VPIDs are in u=
se

Kan Liang (2):
      perf pmu: Fix core PMU alias list for X86 platform
      perf/x86/intel: Don't enable freeze-on-smi for PerfMon V1

KarimAllah Ahmed (1):
      X86/KVM: Properly update 'tsc_offset' to represent the running guest

Keith Busch (3):
      nvme: Set integrity flag for user passthrough commands
      nvme/multipath: Disable runtime writable enabling parameter
      nvme/multipath: Fix multipath disabled naming collisions

Krish Sadhukhan (1):
      x86: Add check for APIC access address for vmentry of L2 guests

Ladislav Michl (1):
      mtd: onenand: omap2: Disable DMA for HIGHMEM buffers

Laura Abbott (1):
      proc/kcore: don't bounds check against address 0

Laurentiu Tudor (1):
      powerpc/kvm/booke: Fix altivec related build break

Leo Yan (1):
      perf cs-etm: Support unknown_thread in cs_etm_auxtrace

Leon Romanovsky (1):
      RDMA/mlx5: Properly check return value of mlx5_get_uars_page

Liam Girdwood (1):
      ASoC: topology: Check widget kcontrols before deref.

Loic Poulain (1):
      PCI: kirin: Fix reset gpio name

Long Li (2):
      scsi: storvsc: Set up correct queue depth values for IDE devices
      cifs: Allocate validate negotiation request through kmalloc

Lukasz Majewski (1):
      doc: Add vendor prefix for Kieback & Peter GmbH

Madhavan Srinivasan (1):
      powerpc/64s: Default l1d_size to 64K in RFI fallback flush

Marc Dionne (1):
      afs: Fix afs_find_server search loop

Marian Rotariu (1):
      x86: Delay skip of emulated hypercall instruction

Mark Rutland (7):
      arm64: kasan: avoid pfn_to_nid() before page array is initialized
      arm64: ptrace: remove addr_limit manipulation
      arm64: only advance singlestep for user instruction traps
      arm64: fix possible spectre-v1 in ptrace_hbp_get_event()
      KVM: arm/arm64: vgic: fix possible spectre-v1 in vgic_mmio_read_apr()
      bpf: fix possible spectre-v1 in find_and_alloc_map()
      efi/libstub/arm64: Handle randomized TEXT_OFFSET

Markus Mayer (1):
      cpufreq: brcmstb-avs-cpufreq: remove development debug support

Martin Blumenstingl (7):
      ARM64: dts: meson-gxl: add USB host support
      ARM64: dts: meson-gxm: add GXM specific USB host configuration
      ARM64: dts: meson-gxl-s905x-p212: enable the USB controller
      ARM64: dts: meson-gx-p23x-q20x: enable the USB controller
      ARM64: dts: meson-gxl-s905x-libretech-cc: enable the USB controller
      ARM64: dts: meson-gxl-nexbox-a95x: enable the USB controller
      ARM64: dts: meson-gxm-khadas-vim2: enable the USB controller

Martin Schwidefsky (1):
      s390/smsgiucv: disable SMSG on module unload

Masahiro Yamada (3):
      arm64: dts: uniphier: fix input delay value for legacy mode of eMMC
      reset: uniphier: fix USB clock line for LD20
      gcc-plugins: fix build condition of SANCOV plugin

Masami Hiramatsu (3):
      selftests: ftrace: Add a testcase for multiple actions on trigger
      kprobes/x86: Prohibit probing on exception masking instructions
      uprobes/x86: Prohibit probing on MOV SS instruction

Matan Barak (1):
      IB/uverbs: Fix validating mandatory attributes

Matheus Castello (1):
      dt-bindings: pinctrl: sunxi: Fix reference to driver

Mathieu Malaterre (4):
      driver core: add __printf verification to __ata_ehi_pushv_desc
      agp: uninorth: make two functions static
      sched/debug: Move the print_rt_rq() and print_dl_rq() declarations to=
 kernel/sched/sched.h
      sched/deadline: Make the grub_reclaim() function static

Matt Redfearn (1):
      MIPS: dts: Boston: Fix PCI bus dtc warnings:

Maxime Chevallier (1):
      net: mvpp2: Fix clk error path in mvpp2_probe

Michael Ellerman (1):
      powerpc/pseries: Fix CONFIG_NUMA=3Dn build

Michael J. Ruhl (1):
      IB/hfi1 Use correct type for num_user_context

Michal Kalderon (2):
      qed: Fix l2 initializations over iWARP personality
      qede: Fix gfp flags sent to rdma event node allocation

Mika Westerberg (3):
      ACPI / scan: Initialize watchdog before PNP
      ACPI / watchdog: Prefer iTCO_wdt on Lenovo Z50-70
      pinctrl: cherryview: Associate IRQ descriptors to irqdomain

Minchan Kim (1):
      mm: memcg: add __GFP_NOWARN in __memcg_schedule_kmem_cache_create()

Ming Lei (1):
      scsi: target: fix crash with iscsi target and dvd

Nathan Fontenot (1):
      ibmvnic: Do not notify peers on parameter change resets

Nick Dyer (1):
      Input: atmel_mxt_ts - fix the firmware update

Nikita Yushchenko (1):
      ARM: dts: imx51-zii-rdu1: fix touchscreen bindings

Omar Sandoval (1):
      blk-mq: fix sysfs inflight counter

Pablo Neira Ayuso (1):
      netfilter: nf_tables: NAT chain and extensions require NF_TABLES

Paolo Bonzini (1):
      kvm: x86: move MSR_IA32_TSC handling to x86.c

Parav Pandit (2):
      RDMA/cma: Fix use after destroy access to net namespace for IPoIB
      RDMA/cma: Do not query GID during QP state transition to RTR

Paulo Alcantara (1):
      cifs: smb2ops: Fix listxattr() when there are no EAs

Peter Rosin (3):
      i2c: pmcmsp: return message count on master_xfer success
      i2c: pmcmsp: fix error return from master_xfer
      i2c: viperboard: return message count on master_xfer success

Peter Zijlstra (4):
      stop_machine, sched: Fix migrate_swap() vs. active_balance() deadlock
      kthread, sched/wait: Fix kthread_parkme() wait-loop
      kthread, sched/wait: Fix kthread_parkme() completion issue
      sched/core: Introduce set_special_state()

Pierre-Louis Bossart (1):
      ASoC: Intel: atom: fix ACPI/PCI Kconfig

Pieter Jansen van Vuuren (1):
      nfp: flower: split and limit cmsg skb lists

Raghuram Chary J (1):
      lan78xx: PHY DSP registers initialization to address EEE link drop is=
sues with long cables

Ramon Fried (1):
      rpmsg: added MODULE_ALIAS for rpmsg_char

Rich Felker (1):
      sh: fix build failure for J2 cpu with SMP disabled

Rob Herring (2):
      spi: bcm2835aux: ensure interrupts are enabled for shared handler
      sh: switch to NO_BOOTMEM

Roman Mashak (1):
      net sched actions: fix invalid pointer dereferencing if skbedit flags=
 missing

Russell King (4):
      ARM: keystone: fix platform_domain_notifier array overrun
      ARM: kexec: fix kdump register saving on panic()
      ARM: replace unnecessary perl with sed and the shell $(( )) operator
      ARM: fix kill( ,SIGFPE) breakage

Sara Sharon (1):
      mac80211: use timeout from the AddBA response instead of the request

Sebastian Sanchez (2):
      IB/{hfi1, rdmavt}: Fix memory leak in hfi1_alloc_devdata() upon failu=
re
      IB/hfi1: Fix memory leak in exception path in get_irq_affinity()

Sekhar Nori (9):
      ARM: dts: da850: fix W=3D1 warnings with pinmux node
      ARM: davinci: board-da830-evm: fix GPIO lookup for MMC/SD
      ARM: davinci: board-da850-evm: fix GPIO lookup for MMC/SD
      ARM: davinci: board-omapl138-hawk: fix GPIO numbers for MMC/SD lookup
      ARM: davinci: board-dm355-evm: fix broken networking
      ARM: davinci: fix GPIO lookup for I2C
      ARM: davinci: dm646x: fix timer interrupt generation
      ARM: davinci: board-dm646x-evm: pass correct I2C adapter id for VPIF
      ARM: davinci: board-dm646x-evm: set VPIF capture card name

Simon Gaiser (1):
      xen: xenbus_dev_frontend: Really return response string

Sinan Kaya (2):
      MIPS: io: Prevent compiler reordering writeX()
      MIPS: io: Add barrier after register read in readX()

Srinath Mannam (1):
      arm64: dts: correct SATA addresses for Stingray

Srinivas Kandagatla (1):
      ASoC: msm8916-wcd-analog: use threaded context for mbhc events

Stefan Agner (2):
      drm/msm/dsi: use correct enum in dsi_get_cmd_fmt
      clk: imx6ull: use OSC clock during AXI rate change

Stefan Raspl (1):
      smc: fix sendpage() call

Stefano Brivio (1):
      vti6: Change minimum MTU to IPV4_MIN_MTU, vti6 can carry IPv4 too

Steve French (1):
      CIFS: set *resp_buf_type to NO_BUFFER on error

Taehee Yoo (1):
      netfilter: nf_tables: fix out-of-bounds in nft_chain_commit_update

Tero Kristo (1):
      ARM: OMAP2+: powerdomain: use raw_smp_processor_id() for trace

Tobias Jakobi (1):
      drm/exynos: mixer: avoid Oops in vp_video_buffer()

Tobias Jordan (1):
      remoteproc: qcom: Fix potential device node leaks

Tobias Regnery (1):
      usb: typec: ucsi: fix tracepoint related build error

Tomi Valkeinen (4):
      drm/omap: fix uninitialized ret variable
      drm/omap: fix possible NULL ref issue in tiler_reserve_2d
      drm/omap: check return value from soc_device_match
      drm/omap: handle alloc failures in omap_connector

Tony Lindgren (1):
      ARM: dts: Fix cm2 and prm sizes for omap4

Tung Nguyen (1):
      tipc: fix infinite loop when dumping link monitor summary

Tyler Hicks (1):
      eCryptfs: don't pass up plaintext names when using filename encryption

Vinicius Costa Gomes (1):
      igb: Fix the transmission mode of queue 0 for Qav mode

Vinson Lee (1):
      scsi: megaraid_sas: Do not log an error if FW successfully initialize=
s.

Vladimir Zapolskiy (1):
      spi: sh-msiof: Fix bit field overflow writes to TSCR/RSCR

Waiman Long (2):
      locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED flag
      locking/percpu-rwsem: Annotate rwsem ownership transfer by setting RW=
SEM_OWNER_UNKNOWN

Wanpeng Li (2):
      KVM: Extend MAX_IRQ_ROUTES to 4096 for all archs
      KVM: X86: Lower the default timer frequency limit to 200us

Yan Wang (1):
      ASoC: topology: Fix bugs of freeing soc topology

Ying Xue (1):
      tipc: eliminate KMSAN uninit-value in strcmp complaint

Yixun Lan (1):
      pinctrl: meson-axg: fix the range of aobus bank

Yury Norov (1):
      lib/find_bit_benchmark.c: avoid soft lockup in test_find_first_bit()

Zhu Yanjun (1):
      IB/rxe: avoid double kfree_skb

dann frazier (1):
      net: hns: Avoid action name truncation

hu huajun (1):
      KVM: X86: fix incorrect reference of trace_kvm_pi_irte_update

jacek.tomaka@poczta.fm (1):
      x86/cpu/intel: Add missing TLB cpuid values

oder_chiou@realtek.com (1):
      ASoC: rt5514: Add the missing register in the readable table

oulijun (4):
      RDMA/hns: Bugfix for init hem table
      RDMA/hns: Intercept illegal RDMA operation when use inline data
      RDMA/hns: Fix the qp context state diagram
      RDMA/hns: Submit bad wr

pgzh (1):
      HID: lenovo: Add support for IBM/Lenovo Scrollpoint mice

sxauwsk (1):
      spi: cadence: Add usleep_range() for cdns_spi_fill_tx_fifo()

van der Linden, Frank (1):
      x86/xen: Reset VCPU0 info pointer after shared_info remap

=C5=81ukasz Stelmach (2):
      ARM: 8753/1: decompressor: add a missing parameter to the addruart ma=
cro
      ARM: 8758/1: decompressor: restore r1 and r2 just before jumping to t=
he kernel


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsqvEMACgkQONu9yGCS
aT6veA//UFMCbyUqjX7OvxtKY8iHlFoBDV30pCL9HTsImbLfwVqKweOIjvKrx6wv
PCXljrsxsLZ7yphZKNGzJlqRCooxIqnhQ9XMXm5PJzCRbRTlB7XXSFJprWL1IKrn
yaE3SU9VaW5rHx8VNDjd28aH39UalysFVitq8PcfB5xM+eWnRJ52k9IUCLMeTVcY
EVmizoLSzRMhmRXi2wxIZkdepJ7Ps5l56f7srCA0FrfDT5TsOr+JZUgAk5SocxGF
rkdKqWDrJtUrTxz7eP19rs2j5f/KsYy3To4kbCP/WGh5umqoaR43U4oowFinbnzN
cDeH96yS9vQjL9A29GpiO+1rsoQ1e8oZwuzuq7GZPIo2TKXKl5KG7MCMBukq0M+8
uS11ljwzHycP7wySPpFxDvnL4hNbZl/AR42kw/r2BUS5ywoT1a1Sufxu/KrHU7jf
1iCBUA1Ega22W1cARzSaFnRi1xkVg6cGrE/EvXqB4jjqpoaRP72TDdk6lamnFrWG
GnnfuBxFoPkejXpRewCdwPBr9Nt0pcBrVlshrS8ZpKutzSOByiDiyEYQmzCsQf8d
r8/eBo0e2jmaBXZ1UGSOLxxsPJ1G9vSC/KFRydgFrCMUbvPtF36gXF6ileCOs6Z6
fcp+apbLCNAiC2agDNSGEx0JWQOzTNMRlZ1ks4uBTw9tjGHamJg=
=VSzS
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
