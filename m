Date: Fri, 13 Apr 2018 22:23:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.94
Message-ID: <20180413202359.GA22934@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.94 kernel.

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

 Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt |   11 -
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt    |   11 -
 Makefile                                                         |    2=20
 arch/arm/boot/dts/imx53-qsrb.dts                                 |    2=20
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi                         |    1=20
 arch/arm/boot/dts/ls1021a.dtsi                                   |    2=20
 arch/arm/boot/dts/qcom-ipq4019.dtsi                              |    4=20
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts                    |    2=20
 arch/arm/boot/dts/rk322x.dtsi                                    |    6=20
 arch/arm/include/asm/xen/events.h                                |    2=20
 arch/arm/kvm/hyp/switch.c                                        |    2=20
 arch/arm/mach-davinci/devices-da8xx.c                            |   10 +
 arch/arm/mach-imx/cpu.c                                          |    3=20
 arch/arm/mach-imx/mxc.h                                          |    6=20
 arch/arm64/include/asm/futex.h                                   |    8=20
 arch/arm64/kernel/pci.c                                          |    4=20
 arch/arm64/kernel/perf_event.c                                   |   23 +-
 arch/arm64/kvm/hyp/switch.c                                      |    1=20
 arch/arm64/mm/mmap.c                                             |   19 +
 arch/mips/include/asm/kprobes.h                                  |    3=20
 arch/mips/include/asm/pgtable-32.h                               |    7=20
 arch/mips/mm/pgtable-32.c                                        |    6=20
 arch/powerpc/include/asm/module.h                                |    4=20
 arch/powerpc/include/asm/page.h                                  |   12 +
 arch/powerpc/kernel/time.c                                       |   14 +
 arch/powerpc/kvm/book3s_pr_papr.c                                |   34 ++-
 arch/powerpc/platforms/cell/spufs/coredump.c                     |    2=20
 arch/powerpc/sysdev/mpc8xx_pic.c                                 |    2=20
 arch/s390/kernel/vmlinux.lds.S                                   |    8=20
 arch/sparc/kernel/ldc.c                                          |    7=20
 arch/x86/boot/compressed/error.h                                 |    4=20
 arch/x86/include/asm/asm.h                                       |    1=20
 arch/x86/kernel/tsc.c                                            |    2=20
 arch/x86/kvm/lapic.c                                             |    2=20
 arch/x86/kvm/svm.c                                               |   24 +-
 arch/x86/kvm/vmx.c                                               |   10 -
 arch/x86/lib/csum-copy_64.S                                      |   12 -
 arch/x86/lib/kaslr.c                                             |    3=20
 arch/x86/platform/efi/efi.c                                      |    6=20
 block/bio-integrity.c                                            |    3=20
 block/blk-mq.c                                                   |   11 -
 block/partition-generic.c                                        |    4=20
 crypto/asymmetric_keys/x509_cert_parser.c                        |    1=20
 crypto/async_tx/async_pq.c                                       |    5=20
 drivers/acpi/acpi_video.c                                        |   14 +
 drivers/acpi/acpica/evxfevnt.c                                   |   18 +
 drivers/acpi/acpica/psobject.c                                   |   14 +
 drivers/acpi/ec.c                                                |    2=20
 drivers/acpi/ec_sys.c                                            |    2=20
 drivers/acpi/internal.h                                          |    2=20
 drivers/ata/libahci_platform.c                                   |    5=20
 drivers/block/loop.c                                             |    3=20
 drivers/bus/brcmstb_gisb.c                                       |   42 ++=
--
 drivers/char/ipmi/ipmi_ssif.c                                    |    2=20
 drivers/char/random.c                                            |   10 -
 drivers/clk/at91/clk-generated.c                                 |    4=20
 drivers/clk/clk-conf.c                                           |    2=20
 drivers/clk/clk-scpi.c                                           |    6=20
 drivers/clk/meson/Kconfig                                        |    6=20
 drivers/clk/meson/meson8b.c                                      |    5=20
 drivers/clk/renesas/clk-rcar-gen2.c                              |   23 +-
 drivers/cpuidle/dt_idle_states.c                                 |    4=20
 drivers/crypto/omap-sham.c                                       |   31 ++-
 drivers/devfreq/devfreq.c                                        |    3=20
 drivers/dma/imx-sdma.c                                           |   23 +-
 drivers/edac/mv64x60_edac.c                                      |    2=20
 drivers/gpio/gpio-crystalcove.c                                  |   54 ++=
+--
 drivers/gpio/gpiolib.c                                           |    3=20
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                         |    3=20
 drivers/gpu/drm/msm/msm_gem.c                                    |    6=20
 drivers/gpu/drm/omapdrm/omap_gem.c                               |    4=20
 drivers/gpu/drm/sun4i/sun4i_drv.c                                |   12 +
 drivers/gpu/drm/vc4/vc4_gem.c                                    |   13 -
 drivers/hid/i2c-hid/i2c-hid.c                                    |   13 +
 drivers/hwmon/ina2xx.c                                           |   87 ++=
+++---
 drivers/hwtracing/coresight/coresight-tmc.c                      |    7=20
 drivers/hwtracing/coresight/coresight.c                          |   15 +
 drivers/i2c/muxes/i2c-mux-reg.c                                  |   17 +
 drivers/iio/adc/hi8435.c                                         |   27 ++
 drivers/iio/light/rpr0521.c                                      |   17 +
 drivers/iio/magnetometer/st_magn_spi.c                           |    2=20
 drivers/iio/pressure/zpa2326.c                                   |   18 +
 drivers/infiniband/hw/cxgb4/cm.c                                 |    6=20
 drivers/infiniband/hw/hfi1/sysfs.c                               |    3=20
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c                         |    6=20
 drivers/infiniband/hw/i40iw/i40iw_d.h                            |    1=20
 drivers/infiniband/hw/i40iw/i40iw_puda.c                         |    2=20
 drivers/infiniband/sw/rdmavt/cq.c                                |   10 -
 drivers/infiniband/ulp/srpt/ib_srpt.c                            |    9=20
 drivers/input/mouse/elan_i2c_core.c                              |    7=20
 drivers/input/mouse/elan_i2c_i2c.c                               |    9=20
 drivers/input/mouse/elantech.c                                   |   11 +
 drivers/input/touchscreen/goodix.c                               |    8=20
 drivers/irqchip/irq-gic-v3.c                                     |   11 +
 drivers/irqchip/irq-mbigen.c                                     |    5=20
 drivers/isdn/mISDN/stack.c                                       |    2=20
 drivers/leds/leds-pca955x.c                                      |    2=20
 drivers/md/bcache/alloc.c                                        |   19 +
 drivers/md/bcache/super.c                                        |    6=20
 drivers/md/md-cluster.c                                          |    4=20
 drivers/md/raid5.c                                               |   17 -
 drivers/media/i2c/cx25840/cx25840-core.c                         |   36 ++-
 drivers/media/platform/pxa_camera.c                              |   14 +
 drivers/media/rc/mceusb.c                                        |    9=20
 drivers/media/v4l2-core/videobuf2-core.c                         |    4=20
 drivers/misc/cxl/flash.c                                         |    8=20
 drivers/misc/vmw_vmci/vmci_queue_pair.c                          |   10 -
 drivers/mmc/host/sdhci-pci-core.c                                |    2=20
 drivers/mmc/host/sdhci.c                                         |    7=20
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c                           |   10 -
 drivers/mtd/nand/nand_base.c                                     |    5=20
 drivers/mtd/tests/oobtest.c                                      |   21 ++
 drivers/mtd/ubi/fastmap.c                                        |   33 ++-
 drivers/net/bonding/bond_main.c                                  |   84 ++=
++----
 drivers/net/ethernet/amazon/ena/ena_com.c                        |   35 ++-
 drivers/net/ethernet/amazon/ena/ena_netdev.c                     |   17 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c                  |   19 +
 drivers/net/ethernet/brocade/bna/bfa_ioc.c                       |    2=20
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c                  |   11 +
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c                       |   32 ++-
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c                       |   23 +-
 drivers/net/ethernet/freescale/fec_main.c                        |    4=20
 drivers/net/ethernet/freescale/fsl_pq_mdio.c                     |    9=20
 drivers/net/ethernet/ibm/emac/core.c                             |   26 ++
 drivers/net/ethernet/intel/e1000e/netdev.c                       |   17 +
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c              |    1=20
 drivers/net/ethernet/intel/igb/igb_ptp.c                         |   12 +
 drivers/net/ethernet/marvell/sky2.c                              |    2=20
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c                   |   77 ++=
++---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c                  |   33 +--
 drivers/net/ethernet/mellanox/mlx4/en_main.c                     |    4=20
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c                   |    7=20
 drivers/net/ethernet/mellanox/mlx4/mcg.c                         |   15 +
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h                     |    1=20
 drivers/net/ethernet/mellanox/mlx4/qp.c                          |   19 +
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c            |   17 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                |   10 -
 drivers/net/ethernet/mellanox/mlx5/core/main.c                   |   14 -
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c         |    6=20
 drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c              |    2=20
 drivers/net/ethernet/qlogic/qed/qed_dev.c                        |    5=20
 drivers/net/ethernet/qlogic/qed/qed_main.c                       |    6=20
 drivers/net/ethernet/qlogic/qed/qed_mcp.h                        |    1=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c                   |    2=20
 drivers/net/ethernet/qlogic/qlge/qlge_dbg.c                      |    4=20
 drivers/net/ethernet/qualcomm/qca_spi.c                          |   10 -
 drivers/net/ethernet/realtek/r8169.c                             |    4=20
 drivers/net/ethernet/renesas/sh_eth.c                            |    2=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                |   15 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h                 |    3=20
 drivers/net/ethernet/ti/cpsw.c                                   |   16 +
 drivers/net/geneve.c                                             |   36 ++-
 drivers/net/hamradio/hdlcdrv.c                                   |    2=20
 drivers/net/macsec.c                                             |   13 +
 drivers/net/phy/mdio-mux.c                                       |   11 -
 drivers/net/phy/micrel.c                                         |   42 ++=
--
 drivers/net/phy/phy.c                                            |    6=20
 drivers/net/ppp/pptp.c                                           |    1=20
 drivers/net/team/team.c                                          |   12 -
 drivers/net/usb/cdc_ncm.c                                        |   11 -
 drivers/net/virtio_net.c                                         |   16 +
 drivers/net/vmxnet3/vmxnet3_drv.c                                |    5=20
 drivers/net/vrf.c                                                |    8=20
 drivers/net/vxlan.c                                              |    2=20
 drivers/net/wan/fsl_ucc_hdlc.c                                   |   18 -
 drivers/net/wireless/ath/ath10k/bmi.h                            |    2=20
 drivers/net/wireless/ath/ath10k/core.c                           |   16 +
 drivers/net/wireless/ath/ath5k/debug.c                           |    5=20
 drivers/net/wireless/intel/iwlwifi/iwl-7000.c                    |    4=20
 drivers/net/wireless/intel/iwlwifi/iwl-8000.c                    |    4=20
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h                    |    1=20
 drivers/net/wireless/intel/iwlwifi/mvm/fw-dbg.c                  |   12 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                     |    6=20
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                     |   32 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c                      |    8=20
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                  |    6=20
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c                   |   22 +-
 drivers/net/wireless/ray_cs.c                                    |    7=20
 drivers/net/wireless/ti/wl1251/main.c                            |    3=20
 drivers/nvme/host/core.c                                         |    4=20
 drivers/nvme/host/pci.c                                          |   13 -
 drivers/pinctrl/intel/pinctrl-baytrail.c                         |    6=20
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c                       |    1=20
 drivers/powercap/powercap_sys.c                                  |    1=20
 drivers/rtc/interface.c                                          |    9=20
 drivers/rtc/rtc-m41t80.c                                         |   12 +
 drivers/rtc/rtc-opal.c                                           |   10 +
 drivers/rtc/rtc-snvs.c                                           |    2=20
 drivers/s390/block/dasd.c                                        |    8=20
 drivers/scsi/bnx2fc/bnx2fc.h                                     |    1=20
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                                |   10 -
 drivers/scsi/csiostor/csio_hw.c                                  |    5=20
 drivers/scsi/libiscsi.c                                          |   24 ++
 drivers/scsi/libsas/sas_expander.c                               |    4=20
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                             |   28 +-
 drivers/staging/wlan-ng/prism2mgmt.c                             |    2=20
 drivers/thermal/power_allocator.c                                |    2=20
 drivers/tty/n_gsm.c                                              |   17 +
 drivers/tty/serial/8250/8250_omap.c                              |    4=20
 drivers/tty/serial/sccnxp.c                                      |   15 +
 drivers/tty/serial/sh-sci.c                                      |   16 +
 drivers/uio/uio.c                                                |    8=20
 drivers/usb/chipidea/core.c                                      |   29 ++
 drivers/usb/dwc3/dwc3-keystone.c                                 |    4=20
 drivers/usb/host/xhci-plat.c                                     |    1=20
 drivers/usb/storage/ene_ub6250.c                                 |   11 -
 drivers/vhost/net.c                                              |    4=20
 drivers/vhost/vhost.c                                            |   17 -
 drivers/video/backlight/backlight.c                              |   15 +
 drivers/video/backlight/corgi_lcd.c                              |    2=20
 drivers/video/backlight/tdo24m.c                                 |    2=20
 drivers/video/backlight/tosa_lcd.c                               |    2=20
 drivers/video/fbdev/vfb.c                                        |   17 +
 drivers/watchdog/Kconfig                                         |    7=20
 drivers/watchdog/f71808e_wdt.c                                   |   27 ++
 fs/btrfs/extent_io.c                                             |    2=20
 fs/cifs/file.c                                                   |    2=20
 fs/cifs/smb2pdu.c                                                |   14 -
 fs/dcache.c                                                      |   23 +-
 fs/ext4/file.c                                                   |    2=20
 fs/ext4/mballoc.c                                                |   23 +-
 fs/lockd/svc.c                                                   |    6=20
 fs/nfs/flexfilelayout/flexfilelayout.c                           |    1=20
 fs/nfs/nfs4proc.c                                                |   13 +
 fs/nfs/nfs4state.c                                               |   10 -
 fs/overlayfs/dir.c                                               |    3=20
 fs/overlayfs/inode.c                                             |   12 +
 include/acpi/platform/acgcc.h                                    |   10 +
 include/acpi/platform/acintel.h                                  |    2=20
 include/linux/mlx4/qp.h                                          |    1=20
 include/linux/mlx5/device.h                                      |   10 -
 include/linux/pci.h                                              |    6=20
 include/linux/sched.h                                            |    1=20
 include/linux/skbuff.h                                           |    8=20
 include/net/cfg80211.h                                           |    2=20
 include/net/x25.h                                                |    4=20
 include/soc/fsl/qe/qe.h                                          |    4=20
 kernel/cpu.c                                                     |   13 +
 kernel/events/callchain.c                                        |    6=20
 kernel/events/core.c                                             |   19 +
 kernel/pid.c                                                     |    4=20
 kernel/sched/core.c                                              |    2=20
 kernel/sched/deadline.c                                          |   98 ++=
++++++--
 kernel/sched/fair.c                                              |    3=20
 mm/vmstat.c                                                      |    2=20
 net/8021q/vlan_dev.c                                             |    6=20
 net/bluetooth/hci_core.c                                         |   17 +
 net/ceph/osdmap.c                                                |    1=20
 net/core/dev.c                                                   |    4=20
 net/core/neighbour.c                                             |   14 +
 net/core/net_namespace.c                                         |   19 +
 net/core/skbuff.c                                                |   75 ++=
++---
 net/core/sysctl_net_core.c                                       |    2=20
 net/hsr/hsr_forward.c                                            |    3=20
 net/hsr/hsr_framereg.c                                           |    9=20
 net/hsr/hsr_framereg.h                                           |    2=20
 net/ieee802154/socket.c                                          |    8=20
 net/ipv4/ah4.c                                                   |    8=20
 net/ipv4/arp.c                                                   |   18 +
 net/ipv4/esp4.c                                                  |   13 -
 net/ipv4/fib_semantics.c                                         |   20 +-
 net/ipv4/ip_tunnel.c                                             |   11 -
 net/ipv4/ipmr.c                                                  |   18 +
 net/ipv4/tcp_input.c                                             |   24 +-
 net/ipv6/addrconf.c                                              |    5=20
 net/ipv6/ah6.c                                                   |    8=20
 net/ipv6/esp6.c                                                  |   12 -
 net/ipv6/ip6_gre.c                                               |    8=20
 net/ipv6/ip6_output.c                                            |   20 +-
 net/ipv6/ip6_tunnel.c                                            |   14 +
 net/ipv6/ip6_vti.c                                               |    7=20
 net/ipv6/route.c                                                 |    3=20
 net/ipv6/sit.c                                                   |    9=20
 net/key/af_key.c                                                 |    2=20
 net/l2tp/l2tp_netlink.c                                          |    2=20
 net/llc/af_llc.c                                                 |    3=20
 net/mac80211/cfg.c                                               |   28 ++
 net/mac80211/driver-ops.h                                        |    3=20
 net/mac80211/mlme.c                                              |    4=20
 net/netfilter/nf_conntrack_core.c                                |   39 ++-
 net/netfilter/nf_conntrack_netlink.c                             |    7=20
 net/netlink/af_netlink.c                                         |    3=20
 net/rds/bind.c                                                   |    1=20
 net/rxrpc/rxkad.c                                                |   19 +
 net/sched/act_api.c                                              |    4=20
 net/sched/act_bpf.c                                              |   12 -
 net/sched/act_skbmod.c                                           |    3=20
 net/sched/act_tunnel_key.c                                       |    9=20
 net/sctp/ipv6.c                                                  |    4=20
 net/sctp/socket.c                                                |   17 +
 net/strparser/strparser.c                                        |    4=20
 net/sunrpc/xprtsock.c                                            |    7=20
 net/x25/af_x25.c                                                 |   24 +-
 net/x25/sysctl_net_x25.c                                         |    5=20
 net/xfrm/xfrm_state.c                                            |    2=20
 scripts/tags.sh                                                  |    1=20
 security/selinux/hooks.c                                         |   10 -
 sound/soc/generic/simple-card.c                                  |    2=20
 sound/soc/intel/atom/sst/sst_stream.c                            |    2=20
 sound/soc/intel/boards/cht_bsw_rt5645.c                          |    7=20
 sound/soc/intel/skylake/skl-messages.c                           |    4=20
 sound/soc/intel/skylake/skl-pcm.c                                |    4=20
 sound/soc/sh/rcar/ssi.c                                          |   11 -
 tools/perf/builtin-trace.c                                       |    4=20
 tools/perf/tests/code-reading.c                                  |   20 +-
 tools/perf/util/dso.c                                            |   16 +
 tools/perf/util/header.c                                         |   12 +
 tools/perf/util/probe-event.c                                    |    8=20
 tools/perf/util/unwind-libdw.c                                   |   14 +
 tools/perf/util/unwind-libunwind-local.c                         |   11 +
 tools/perf/util/util.c                                           |    2=20
 tools/testing/selftests/powerpc/tm/tm-resched-dscr.c             |    2=20
 tools/testing/selftests/seccomp/seccomp_bpf.c                    |    2=20
 313 files changed, 2423 insertions(+), 917 deletions(-)

A Sun (1):
      mceusb: sporadic RX truncation corruption fix

Alan Stern (2):
      USB: ene_usb6250: fix first command execution
      USB: ene_usb6250: fix SCSI residue overwriting

Alexander Potapenko (1):
      netlink: make sure nladdr has correct size in netlink_connect()

Alexandre Belloni (2):
      clk: at91: fix clk-generated parenting
      clk: at91: fix clk-generated compilation

Amir Goldstein (1):
      ovl: persistent inode numbers for upper hardlinks

Andrea della Porta (1):
      staging: wlan-ng: prism2mgmt.c: fixed a double endian conversion befo=
re calling hfa384x_drvr_setconfig16, also fixes relative sparse warning

Andy Shevchenko (1):
      sdhci: Advertise 2.0v supply on SDIO host controller

Anilkumar Kolli (1):
      ath10k: add BMI parameters to fix calibration from DT/pre-cal

Antony Antony (1):
      xfrm: fix state migration copy replay sequence numbers

Anup Patel (1):
      async_tx: Fix DMA_PREP_FENCE usage in do_async_gen_syndrome()

Ard Biesheuvel (1):
      arm64: kernel: restrict /dev/mem read() calls to linear region

Arjun Vynipadath (3):
      cxgb4: FW upgrade fixes
      cxgb4: Fix netdev_features flag
      cxgb4vf: Fix SGE FL buffer initialization logic for 64K pages

Arnd Bergmann (2):
      net/mlx5: avoid build warning for uniprocessor
      xen: avoid type warning in xchg_xen_ulong

Arvind Yadav (1):
      dmaengine: imx-sdma: Handle return value of clk_prepare_enable

Bart Van Assche (2):
      IB/srpt: Fix abort handling
      IB/srpt: Avoid that aborting a command triggers a kernel warning

Bob Moore (1):
      ACPICA: Disassembler: Abort on an invalid/unknown AML opcode

Boris Brezillon (1):
      mtd: nand: gpmi: Fix gpmi_nand_init() error path

Bryan O'Donoghue (1):
      clk: Fix __set_clk_rates error print-string

Chaitra P B (1):
      scsi: mpt3sas: Proper handling of set/clear of "ATA command pending" =
flag.

Chris Wilson (1):
      e1000e: Undo e1000e_pm_freeze if __e1000_shutdown fails

Christian Lamparter (2):
      ARM: dts: qcom: ipq4019: fix i2c_0 node
      net: emac: fix reset timeout with AR8035 phy

Christoph Hellwig (1):
      PCI/msi: fix the pci_alloc_irq_vectors_affinity stub

Christophe JAILLET (4):
      SMB2: Fix share type handling
      ASoC: Intel: sst: Fix the return value of 'sst_send_byte_stream_mrfld=
()'
      drm/vc4: Fix resource leak in 'vc4_get_hang_state_ioctl()' in error h=
andling path
      EDAC, mv64x60: Fix an error handling path

Christophe Jaillet (1):
      cpuidle: dt: Add missing 'of_node_put()'

Christophe Leroy (1):
      powerpc/8xx: fix mpc8xx_get_irq() return on no irq

Colin Ian King (4):
      netxen_nic: set rcode to the return status from the call to netxen_is=
sue_cmd
      btrfs: fix incorrect error return ret being passed to mapping_set_err=
or
      ath5k: fix memory leak on buf on failed eeprom read
      wl1251: check return from call to wl1251_acx_arp_ip_filter

Craig Dillabaugh (1):
      net sched actions: fix dumping which requires several messages to use=
r space

Dan Carpenter (10):
      ipmi_ssif: unlock on allocation failure
      drivers/misc/vmw_vmci/vmci_queue_pair.c: fix a couple integer overflo=
w tests
      PowerCap: Fix an error code in powercap_register_zone()
      perf/core: Fix error handling in perf_event_alloc()
      block: fix an error code in add_partition()
      libceph: NULL deref on crush_decode() error path
      pNFS/flexfiles: missing error code in ff_layout_alloc_lseg()
      drm/amdkfd: NULL dereference involving create_process()
      cxl: Unlock on error in probe
      X.509: Fix error code in x509_cert_parse()

Daniel Bristot de Oliveira (1):
      sched/deadline: Use the revised wakeup rule for suspending constraine=
d dl tasks

Dave Watson (1):
      strparser: Fix sign of err codes

David Ahern (2):
      net/ipv6: Fix route leaking between VRFs
      vrf: Fix use after free and double free in vrf_finish_output

Davide Caratti (3):
      net/sched: fix NULL dereference in the error path of tcf_bpf_init()
      net/sched: fix NULL dereference in the error path of tunnel_key_init()
      net/sched: fix NULL dereference on the error path of tcf_skbmod_init()

Dmitry Monakhov (1):
      bio-integrity: Do not allocate integrity context for bio w/o data

Dmitry Torokhov (1):
      Input: elan_i2c - check if device is there before really probing

Doug Berger (2):
      bus: brcmstb_gisb: Use register offsets with writes too
      bus: brcmstb_gisb: correct support for 64-bit address output

Emmanuel Grumbach (1):
      iwlwifi: mvm: fix firmware debug restart recording

Eran Ben Elisha (1):
      net/mlx4_en: Fix mixed PFC and Global pause user control requests

Eric Dumazet (11):
      tcp: better validation of received ack sequences
      net: fix possible out-of-bound read in skb_network_protocol()
      pptp: remove a buggy dst release in pptp_connect()
      sctp: do not leak kernel memory to user space
      sctp: sctp_sockaddr_af must check minimal addr length for AF_INET6
      net: fool proof dev_valid_name()
      ip_tunnel: better validate user provided tunnel names
      ipv6: sit: better validate user provided tunnel names
      ip6_gre: better validate user provided tunnel names
      ip6_tunnel: better validate user provided tunnel names
      vti6: better validate user provided tunnel names

Eryu Guan (1):
      ext4: fix off-by-one on max nr_pages in ext4_find_unwritten_pgoff()

Fabio Estevam (3):
      ARM: dts: imx53-qsrb: Pulldown PMIC IRQ pin
      ARM: dts: imx6qdl-wandboard: Fix audio channel swap
      net: fec: Add a fec_enet_clear_ethtool_stats() stub for CONFIG_M5272

Firo Yang (1):
      hdlcdrv: Fix divide by zero in hdlcdrv_ioctl

Florian Westphal (1):
      netfilter: conntrack: don't call iter for non-confirmed conntracks

Ganapatrao Kulkarni (1):
      arm64: perf: Ignore exclude_hv when kernel is running in HYP

Ganesh Goudar (1):
      cxgb4: fix incorrect cim_la output for T6

Gary Bisson (1):
      rtc: m41t80: fix SQW dividers override when setting a date

Geert Uytterhoeven (5):
      clk: renesas: rcar-gen2: Fix PLL0 on R-Car V2H and E2
      serial: sh-sci: Fix race condition causing garbage during shutdown
      sh_eth: Use platform device for printing before register_netdev()
      ACPI: EC: Fix debugfs_create_*() usage
      ARM: dts: armadillo800eva: Split LCD mux and gpio

Girish Moodalbail (1):
      geneve: add missing rx stats accounting

Greg Hackmann (1):
      Revert "xhci: plat: Register shutdown for xhci_plat"

Greg Kroah-Hartman (1):
      Linux 4.9.94

Grygorii Strashko (1):
      net: ethernet: ti: cpsw: adjust cpsw fifos depth for fullduplex flow =
control

Guoqing Jiang (1):
      md-cluster: fix potential lock issue in add_new_disk

Gustavo A. R. Silva (2):
      PM / devfreq: Fix potential NULL pointer dereference in governor_store
      net: freescale: fix potential null pointer dereference

Haim Dreyfuss (1):
      iwlwifi: mvm: Fix command queue number on d0i3 flow

Haishuang Yan (1):
      sit: reload iphdr in ipip6_rcv

Hangbin Liu (2):
      l2tp: fix missing print session offset info
      vlan: also check phy_driver ts_info for vlan's real device

Hans de Goede (6):
      gpio: crystalcove: Do not write regular gpio registers for virtual GP=
IOs
      ACPI / video: Default lcd_only to true on Win8-ready and newer machin=
es
      ASoC: Intel: cht_bsw_rt5645: Analog Mic support
      pinctrl: baytrail: Enable glitch filter for GPIOs used as interrupts
      HID: i2c: Call acpi_device_fix_up_power for ACPI-enumerated devices
      Input: goodix - disable IRQs while suspended

Heiko Carstens (1):
      s390: move _text symbol to address higher than zero

Heiner Kallweit (2):
      pinctrl: meson-gxbb: remove non-existing pin GPIOX_22
      r8169: fix setting driver_data after register_netdev

Holger Brunck (4):
      net/wan/fsl_ucc_hdlc: fix unitialized variable warnings
      net/wan/fsl_ucc_hdlc: fix incorrect memory allocation
      fsl/qe: add bit description for SYNL register for GUMR
      net/wan/fsl_ucc_hdlc: fix muram allocation error

Ido Schimmel (1):
      mlxsw: spectrum: Avoid possible NULL pointer dereference

Ido Shamay (1):
      net/mlx4: Check if Granular QoS per VF has been enabled before updati=
ng QP qos_vport

Ihar Hrachyshka (2):
      neighbour: update neigh timestamps iff update is effective
      arp: honour gratuitous ARP _replies_

Ivan Mikhaylov (1):
      powerpc/[booke|4xx]: Don't clobber TCR[WP] when setting TCR[DIE]

J. Bruce Fields (1):
      lockd: fix lockd shutdown race

Jacob Keller (2):
      e1000e: fix race condition around skb_tstamp_tx()
      igb: fix race condition with PTP_TX_IN_PROGRESS bits

Jag Raman (1):
      sparc64: ldc abort during vds iso boot

James Morse (2):
      KVM: arm: Restore banked registers and physical timer access on hyp_p=
anic()
      KVM: arm64: Restore host physical timer access on hyp_panic()

James Wang (1):
      Fix loop device flush before configure v3

Jan H. Sch=F6nherr (1):
      KVM: nVMX: Fix handling of lmsw instruction

Jason A. Donenfeld (5):
      skbuff: return -EMSGSIZE in skb_to_sgvec to prevent overflow
      macsec: check return value of skb_to_sgvec always
      ipsec: check return value of skb_to_sgvec always
      rxrpc: check return value of skb_to_sgvec always
      virtio_net: check return value of skb_to_sgvec always

Jason Wang (3):
      vhost: correctly remove wait queue during poll failure
      vhost: validate log when IOTLB is enabled
      vhost_net: add missing lock nesting notation

Jason Yan (2):
      scsi: libsas: fix memory leak in sas_smp_get_phy_events()
      scsi: libsas: fix error when getting phy events

Jeff Barnhill (1):
      net/ipv6: Increment OUTxxx counters after netfilter hook

Jesper Dangaard Brouer (1):
      mlx5: fix bug reading rss_hash_type from CQE

Jesse Brandeburg (1):
      i40evf: fix merge error in older patch

Jia-Ju Bai (2):
      qlcnic: Fix a sleep-in-atomic bug in qlcnic_82xx_hw_write_wx_2M and q=
lcnic_82xx_hw_read_wx_2M
      mISDN: Fix a sleep-in-atomic bug

Jim Baxter (1):
      net: cdc_ncm: Fix TX zero padding

Jim Mattson (1):
      KVM: nVMX: Update vmcs12->guest_linear_address on nested VM-exit

Jiri Olsa (2):
      perf trace: Add mmap alias for s390
      perf tools: Fix copyfile_offset update of output offset

Jisheng Zhang (1):
      usb: chipidea: properly handle host or gadget initialization failure

Johannes Berg (2):
      cfg80211: make RATE_INFO_BW_20 the default
      iwlwifi: tt: move ucode_loaded check under mutex

Jon Mason (1):
      mdio: mux: Correct mdio_mux_init error path issues

Jordan Crouse (1):
      drm/msm: Take the mutex before calling msm_gem_new_impl

Josh Poimboeuf (1):
      x86/asm: Don't use RBP as a temporary register in csum_partial_copy_g=
eneric()

Julia Cartwright (1):
      md/raid5: make use of spin_lock_irq over local_irq_disable + spin_lock

Julia Lawall (1):
      mdio: mux: fix device_node_continue.cocci warnings

KT Liao (2):
      Input: elantech - force relative mode on a certain module
      Input: elan_i2c - clear INT before resetting controller

Kai-Heng Feng (1):
      sky2: Increase D3 delay to sky2 stops working after suspend

Karicheri, Muralidharan (1):
      hsr: fix incorrect warning

Kees Cook (4):
      x86/boot: Declare error() as noreturn
      bna: Avoid reading past end of buffer
      qlge: Avoid reading past end of buffer
      ray_cs: Avoid reading past end of buffer

Kirill Tkhai (1):
      pidns: disable pid allocation if pid_ns_prepare_proc() is failed in a=
lloc_pid()

Konstantin Khlebnikov (1):
      ext4: handle the rest of ext4_mb_load_buddy() ENOMEM errors

Kuninori Morimoto (1):
      ASoC: rsnd: SSI PIO adjust to 24bit mode

Leonard Crestez (2):
      net: phy: micrel: Restore led_mode and clk_sel on resume
      ARM: imx: Add MXC_CPU_IMX6ULL and cpu_is_imx6ull

Liam McBirnie (1):
      ip6_tunnel: fix traffic class routing for tunnels

Lin Zhang (1):
      net: ieee802154: fix net_device reference release too early

Linus Walleij (1):
      gpio: label descriptors using the device name

Liping Zhang (1):
      netfilter: ctnetlink: fix incorrect nf_ct_put during hash resize

Lorenzo Bianconi (1):
      iio: magnetometer: st_magn_spi: fix spi_device_id table

Luca Coelho (3):
      mac80211: bail out from prep_connection() if a reconfig is ongoing
      iwlwifi: pcie: only use d0i3 in suspend/resume if system_pm is set to=
 d0i3
      iwlwifi: fix min API version for 7265D, 3168, 8000 and 8265

Lv Zheng (2):
      ACPICA: OSL: Add support to exclude stdarg.h
      ACPICA: Events: Add runtime stub support for event APIs

MaJun (1):
      irqchip/mbigen: Fix the clear register offset calculation

Maciej Purski (1):
      hwmon: (ina2xx) Make calibration register value fixed

Maciej S. Szmigiero (1):
      watchdog: f71808e_wdt: Add F71868 support

Mahesh Bandewar (1):
      ipv6: avoid dad-failures for addresses with NODAD

Marcel Holtmann (1):
      Bluetooth: Send HCI Set Event Mask Page 2 command only when needed

Marcin Nowakowski (3):
      MIPS: mm: fixed mappings: correct initialisation
      MIPS: mm: adjust PKMAP location
      MIPS: kprobes: flush_insn_slot should flush only if probe initialised

Mario Molitor (1):
      stmmac: fix ptp header for GMAC3 hw timestamp

Martin Blumenstingl (1):
      clk: meson: meson8b: add compatibles for Meson8 and Meson8m2

Masahiro Yamada (1):
      mtd: nand: check ecc->total sanity in nand_scan_tail

Masami Hiramatsu (1):
      perf probe: Add warning message if there is unexpected event name

Matthias Kaehlcke (1):
      x86/mm/kaslr: Use the _ASM_MUL macro for multiplication to work aroun=
d Clang incompatibility

Maurizio Lombardi (1):
      scsi: bnx2fc: fix race condition in bnx2fc_get_host_stats()

Mauro Carvalho Chehab (1):
      media: videobuf2-core: don't go out of the buffer range

Maxime Ripard (2):
      drm/sun4i: Ignore the generic connectors for components
      dt-bindings: display: sun4i: Add allwinner,tcon-channel property

Michael Ellerman (4):
      powerpc/modules: If mprofile-kernel is enabled add it to vermagic
      powerpc/mm: Fix virt_addr_valid() etc. on 64-bit hash
      selftests/powerpc: Fix TM resched DSCR test with some compilers
      powerpc/spufs: Fix coredump of SPU contexts

Michael Schmitz (1):
      fix race in drivers/char/random.c:get_reg()

Micka=EBl Sala=FCn (1):
      selftests: kselftest_harness: Fix compile warning

Miguel Fadon Perlines (1):
      arp: fix arp_filter on l3slave devices

Mike Marciniszyn (1):
      IB/rdmavt: Allocate CQ memory on the correct node

Mikko Koivunen (1):
      iio: light: rpr0521 poweroff for probe fails

Miklos Szeredi (1):
      ovl: filter trusted xattr for non-admin

Milian Wolff (2):
      perf report: Fix off-by-one for non-activation frames
      perf report: Ensure the perf DSO mapping matches what libdw sees

Ming Lei (3):
      blk-mq: fix race between updating nr_hw_queues and switching io sched
      nvme: fix hang in remove path
      blk-mq: fix kernel oops in blk_mq_tag_idle()

Mintz, Yuval (1):
      bnx2x: Allow vfs to disable txvlan offload

Miquel Raynal (1):
      mtd: mtd_oobtest: Handle bitflips during reads

Moni Shoua (1):
      net/mlx4_en: Change default QoS settings

Moshe Shemesh (1):
      net/mlx4_core: Fix memory leak while delete slave's resources

Namhyung Kim (3):
      perf header: Set proper module name when build-id event found
      perf tools: Decompress kernel module when reading DSO data
      perf tests: Decompress kernel module before objdump

Nathan Chancellor (1):
      virtio_net: check return value of skb_to_sgvec in one more location

Neil Horman (1):
      vmxnet3: ensure that adapter is in proper state during force_close

NeilBrown (2):
      VFS: close race between getcwd() and d_move()
      SUNRPC: ensure correct error is reported by xs_tcp_setup_socket()

Netanel Belgazal (5):
      net: ena: fix rare uncompleted admin command false alarm
      net: ena: fix race condition between submit and completion admin comm=
and
      net: ena: add missing return when ena_com_get_io_handlers() fails
      net: ena: add missing unmap bars on device removal
      net: ena: disable admin msix while working in polling mode

Nicholas Mc Guire (1):
      iio: pressure: zpa2326: report interrupted case as failure

Nikita Yushchenko (2):
      iio: hi8435: avoid garbage event at first enable
      iio: hi8435: cleanup reset gpio

Nithin Sujir (1):
      bonding: Don't update slave->link until ready to commit

Pan Bian (3):
      rtc: snvs: fix an incorrect check of return value
      usb: dwc3: keystone: check return value
      cx25840: fix unchecked return values

Paolo Abeni (1):
      ipv6: the entire IPv6 header chain must fit the first fragment

Pardha Saradhi K (1):
      ASoC: Intel: Skylake: Disable clock gating during firmware and librar=
y download

Paul Mackerras (1):
      KVM: PPC: Book3S PR: Check copy_to/from_user return values

Peter Gro=DFe (1):
      mac80211: Fix setting TX power on monitor interfaces

Peter Rosin (1):
      i2c: mux: reg: put away the parent i2c adapter on probe failure

Peter Zijlstra (2):
      x86/tsc: Provide 'tsc=3Dunstable' boot parameter
      perf/core: Correct event creation with PERF_FORMAT_GROUP

Petr Cvek (1):
      pxa_camera: fix module remove codepath for v4l2 clock

Pieter \"PoroCYon\" Sluys (1):
      vfb: fix video mode and line_length being set when loaded

Rabin Vincent (2):
      ubi: fastmap: Fix slab corruption
      CIFS: silence lockdep splat in cifs_relock_file()

Rafael David Tinoco (1):
      scsi: libiscsi: Allow sd_shutdown on bad transport

Raju Rangoju (1):
      RDMA/iw_cxgb4: Avoid touch after free error in ARP failure handlers

Rakesh Pandit (1):
      nvme-pci: fix multiple ctrl removal scheduling

Ram Amrani (1):
      qed: Correct doorbell configuration for !4Kb pages

Rasmus Villemoes (1):
      ARM: dts: ls1021a: add "fsl,ls1021a-esdhc" compatible string to esdhc=
 node

Reza Arbab (1):
      mm, vmstat: Remove spurious WARN() during zoneinfo print

Robert Jarzmik (2):
      backlight: tdo24m: Fix the SPI CS between transfers
      tags: honor COMPILED_SOURCE with apart output directory

Robin Murphy (1):
      coresight: tmc: Configure DMA mask appropriately

Roman Kapl (1):
      net: move somaxconn init from sysctl code

Roman Pen (1):
      KVM: SVM: do not zero out segment attributes if segment is unusable o=
r not present

Roopa Prabhu (1):
      vxlan: dont migrate permanent fdb entries during learn

Russell King (1):
      net: phy: avoid genphy_aneg_done() for PHYs without clause 22 support

Sai Praneeth (1):
      x86/efi: Disable runtime services on kexec kernel if booted with efi=
=3Dold_map

Shahar Klein (1):
      net/mlx5e: Sync netdev vxlan ports at open

Shanker Donthineni (1):
      irqchip/gic-v3: Fix the driver probe() fail due to disabled GICC entry

Shiraz Saleem (2):
      i40iw: Fix sequence number for the first partial FPDU
      i40iw: Correct Q1/XF object count equation

Sowmini Varadhan (1):
      rds; Reset rs->rs_bound_addr in rds_add_bound() failure path

Stanislaw Gruszka (1):
      rt2x00: do not pause queue unconditionally on error path

Stefan Agner (1):
      ASoC: simple-card: fix mic jack initialization

Stefan Haberland (1):
      s390/dasd: fix hanging safe offline

Stefan Wahren (1):
      net: qca_spi: Fix alignment issues in rx path

Steffen Klassert (1):
      af_key: Fix slab-out-of-bounds in pfkey_compile_policy.

Stephen Smalley (1):
      selinux: do not check open permission on sockets

Steven L. Roberts (1):
      RDMA/hfi1: fix array termination by appending NULL to attr array

Sudeep Holla (1):
      clk: scpi: fix return type of __scpi_dvfs_round_rate

Sudip Mukherjee (1):
      backlight: Report error on failure

Sugar Zhang (1):
      ARM: dts: rockchip: fix rk322x i2s1 pinctrl error

Suman Anna (2):
      uio: fix incorrect memory leak cleanup
      ARM: davinci: da8xx: Create DSP device only when assigned memory

Suzuki K Poulose (1):
      coresight: Fix reference count for software sources

Talat Batheesh (2):
      net/mlx4_en: Avoid adding steering rules with invalid ring
      net/mlx4: Fix the check in attaching steering rules

Tang Junhui (2):
      bcache: stop writeback thread after detaching
      bcache: segregate flash only volume write streams

Tariq Toukan (1):
      net/mlx5: Tolerate irq_set_affinity_hint() failures

Tero Kristo (2):
      crypto: omap-sham - buffer handling fixes for hashing later
      crypto: omap-sham - fix closing of hash with separate finalize call

Theodore Ts'o (1):
      random: use lockless method of accessing and updating f->reg_idx

Thomas Bogendoerfer (1):
      Fix serial console on SNI RM400 machines

Thomas Gleixner (1):
      cpuhotplug: Link lock stacks for hotplug callbacks

Thomas Petazzoni (1):
      ata: libahci: properly propagate return value of platform_get_irq()

Thomas Winter (1):
      ipmr: vrf: Find VIFs using the actual device

Timmy Li (1):
      ARM64: PCI: Fix struct acpi_pci_root_ops allocation failure path

Tin Huynh (1):
      leds: pca955x: Correct I2C Functionality

Tomi Valkeinen (1):
      drm/omap: fix tiled buffer stride calculations

Tony Lindgren (1):
      tty: n_gsm: Allow ADM response in addition to UA for control dlci

Trond Myklebust (2):
      NFSv4.1: RECLAIM_COMPLETE must handle NFS4ERR_CONN_NOT_BOUND_TO_SESSI=
ON
      NFSv4.1: Work around a Linux server bug...

Vaibhav Jain (2):
      rtc: opal: Handle disabled TPO in opal_get_tpo_time()
      rtc: interface: Validate alarm-time before handling rollover

Varun Prakash (1):
      scsi: csiostor: fix use after free in csio_hw_use_fwconfig()

Vignesh R (1):
      serial: 8250: omap: Disable DMA for console UART

Vlastimil Babka (1):
      sched/numa: Use down_read_trylock() for the mmap_sem

Wanpeng Li (1):
      KVM: X86: Fix preempt the preemption timer cancel

Wen Xiong (1):
      blk-mq: NVMe 512B/4K+T10 DIF/DIX format returns I/O error on dd with =
split op

Will Deacon (2):
      perf/callchain: Force USER_DS when invoking perf_callchain_user()
      arm64: futex: Fix undefined behaviour with FUTEX_OP_OPARG_SHIFT usage

Willem de Bruijn (1):
      skbuff: only inherit relevant tx_flags

Xin Long (6):
      sctp: fix recursive locking warning in sctp_do_peeloff
      bonding: fix the err path for dev hwaddr sync in bond_enslave
      bonding: move dev_mc_sync after master_upper_dev_link in bond_enslave
      bonding: process the err returned by dev_set_allmulti properly in bon=
d_enslave
      route: check sysctl_fib_multipath_use_neigh earlier than hash
      team: move dev_mc_sync after master_upper_dev_link in team_port_add

Yi Zeng (1):
      thermal: power_allocator: fix one race condition issue for thermal_in=
stances list

chenxiang (1):
      scsi: libsas: initialize sas_phy status according to response of DISC=
OVER

linzhang (2):
      net: x25: fix one potential use-after-free issue
      net: llc: add lock_sock in llc_ui_bind to avoid a race condition

sudarsana.kalluru@cavium.com (1):
      qed: Fix overriding of supported autoneg value.


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrREdgACgkQONu9yGCS
aT41mRAAjY6ZmTeh/jZS0alS3APWs9u2RSzNU6HF8RCDr9AFlum16eMfpIbIsmzK
lwM2Nver0nZiKnwb5rHOFeLGONh22L3MOt3LtkXrftyFcdplyQxgFQdohiC86wk/
7xIh/BIYRGJoPiLBj6wOt6aWouiyS/Vl5ZSCCxuqqfl7bN11Z5yKua0QWTKSk9H3
AMJCuZkTnZU/ZpxasFHmaIQjoACqeieyQV9ubIlvLoJDVkdqEL+vRxlvt6jYhyd2
5hlMemhC17fb5JaE/n7idRghEZHXNrR+1WFWCVSAZFg50wqVCJXLQX3z94U8N2aS
MYmbzqBo7PRD2PMB9qUZEcrKAbwBBhXGxuRNuC4+hJp3OIexWAqDzDygS/tlB4eU
h4wPQgZiMwXRhs0z8Z3J/IGevh53T7acoYRU9aiFyxg12cOUVKUsFGTXZgXAwyQu
z/XiII1gzdMUWJo072wAkpc/CMk1gFtDcJqeOHpcFbGDKkcrl49jCzfz11M9IL+d
QVnUUrUpciEOCzY5CpBUPIboHpOouUF/FkWIcfE6Vrnb9ttE6KF/MuKDcIxpl0Yb
gYWv69bn7tnUlHWA5kDbNagzt7R1KK+aJJtsE9LD//H3JyX7cD3qjii6n6s3AUGX
4mOt2H6yS01MbyYaVKyqVsVdHpoXDub2N6CO446kbw0Ghz9/gh4=
=KBOR
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
