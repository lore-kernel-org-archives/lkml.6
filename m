Date: Thu, 22 Mar 2018 10:02:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.89
Message-ID: <20180322090253.GA14923@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.89 kernel.

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

 Makefile                                             |    2=20
 arch/arm/boot/dts/am335x-pepper.dts                  |    2=20
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi          |    2=20
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi          |    2=20
 arch/arm/boot/dts/exynos4412-trats2.dts              |    2=20
 arch/arm/boot/dts/moxart-uc7112lx.dts                |    2=20
 arch/arm/boot/dts/moxart.dtsi                        |   17 +-
 arch/arm/boot/dts/omap3-n900.dts                     |    4=20
 arch/arm/boot/dts/r7s72100.dtsi                      |    2=20
 arch/arm/boot/dts/r8a7790.dtsi                       |    7 -
 arch/arm/boot/dts/r8a7791-koelsch.dts                |    2=20
 arch/arm/boot/dts/r8a7791.dtsi                       |   10 -
 arch/arm/boot/dts/r8a7792.dtsi                       |    3=20
 arch/arm/boot/dts/r8a7793.dtsi                       |   10 -
 arch/arm/boot/dts/r8a7794-silk.dts                   |    2=20
 arch/arm/boot/dts/r8a7794.dtsi                       |   13 +-
 arch/arm/configs/bcm2835_defconfig                   |    4=20
 arch/arm/mach-bcm/Kconfig                            |    1=20
 arch/arm64/boot/dts/renesas/r8a7796.dtsi             |    3=20
 arch/mips/kernel/mips-r2-to-r6-emul.c                |   16 ++
 arch/mips/net/bpf_jit.c                              |   16 +-
 arch/mips/net/bpf_jit_asm.S                          |   23 +--
 arch/parisc/kernel/cache.c                           |   41 +++++-
 arch/powerpc/include/asm/code-patching.h             |    1=20
 arch/powerpc/kernel/module_64.c                      |   12 +
 arch/powerpc/lib/code-patching.c                     |    5=20
 arch/powerpc/mm/fault.c                              |    2=20
 arch/powerpc/mm/hugetlbpage.c                        |   18 ++
 arch/powerpc/mm/tlb_nohash.c                         |    2=20
 arch/s390/kernel/early.c                             |    2=20
 arch/x86/include/asm/cpufeatures.h                   |    1=20
 arch/x86/include/asm/nospec-branch.h                 |    5=20
 arch/x86/include/asm/reboot.h                        |    1=20
 arch/x86/kernel/cpu/intel.c                          |    3=20
 arch/x86/kernel/cpu/mcheck/mce.c                     |   48 +++++--
 arch/x86/kernel/kprobes/core.c                       |    6=20
 arch/x86/kernel/kprobes/opt.c                        |    3=20
 arch/x86/kernel/reboot.c                             |    5=20
 arch/x86/kernel/setup_percpu.c                       |   21 +++
 arch/x86/kernel/sys_x86_64.c                         |    5=20
 arch/x86/kernel/vm86_32.c                            |    3=20
 arch/x86/kvm/svm.c                                   |    7 +
 arch/x86/kvm/x86.c                                   |    3=20
 arch/x86/mm/fault.c                                  |    6=20
 block/blk-cgroup.c                                   |    4=20
 block/blk-throttle.c                                 |   11 +
 drivers/char/agp/intel-gtt.c                         |    2=20
 drivers/clk/meson/gxbb.c                             |    4=20
 drivers/clk/qcom/gcc-msm8916.c                       |    1=20
 drivers/clk/qcom/mmcc-msm8996.c                      |    2=20
 drivers/dma/imx-sdma.c                               |   17 ++
 drivers/edac/altera_edac.c                           |   22 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c       |   31 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c          |    6=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c              |    2=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c           |    2=20
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c            |   10 +
 drivers/gpu/drm/drm_edid.c                           |    9 +
 drivers/gpu/drm/drm_irq.c                            |   14 +-
 drivers/gpu/drm/qxl/qxl_fb.c                         |    9 +
 drivers/gpu/drm/radeon/radeon_display.c              |    6=20
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c               |    7 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c          |   29 +++-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                   |    5=20
 drivers/gpu/drm/sun4i/sun4i_drv.c                    |   16 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                   |   22 ++-
 drivers/gpu/drm/ttm/ttm_bo.c                         |   12 +
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                   |    4=20
 drivers/hid/hid-elo.c                                |    6=20
 drivers/hid/hid-input.c                              |   20 ++-
 drivers/hwmon/pmbus/adm1275.c                        |    4=20
 drivers/hwtracing/coresight/of_coresight.c           |    2=20
 drivers/infiniband/hw/hfi1/chip.c                    |    7 -
 drivers/input/keyboard/qt1070.c                      |    9 +
 drivers/input/touchscreen/tsc2007.c                  |    8 +
 drivers/iommu/iova.c                                 |    2=20
 drivers/irqchip/irq-gic-v3-its.c                     |    9 -
 drivers/leds/leds-pm8058.c                           |    2=20
 drivers/md/md.c                                      |    4=20
 drivers/md/raid5.c                                   |   13 +-
 drivers/media/i2c/soc_camera/ov6650.c                |    2=20
 drivers/media/pci/solo6x10/solo6x10-v4l2.c           |   11 +
 drivers/media/platform/vsp1/vsp1_drm.c               |    1=20
 drivers/media/platform/vsp1/vsp1_drv.c               |   16 ++
 drivers/media/platform/vsp1/vsp1_video.c             |   13 ++
 drivers/media/usb/cpia2/cpia2_v4l.c                  |    4=20
 drivers/misc/Makefile                                |    2=20
 drivers/misc/enclosure.c                             |    7 -
 drivers/mtd/nand/fsl_ifc_nand.c                      |    7 +
 drivers/mtd/nand/nand_base.c                         |    9 +
 drivers/net/bonding/bond_main.c                      |   35 +++--
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c       |    1=20
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h       |    1=20
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c     |   31 +++--
 drivers/net/ethernet/broadcom/bgmac-bcma.c           |   39 +++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c            |   10 +
 drivers/net/ethernet/cavium/thunder/nicvf_main.c     |    5=20
 drivers/net/ethernet/faraday/ftgmac100.c             |    1=20
 drivers/net/ethernet/freescale/fec_main.c            |   26 ++--
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c    |   23 ++-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c   |   11 -
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h   |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c    |    1=20
 drivers/net/ethernet/hisilicon/hns/hns_enet.c        |    5=20
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c     |    8 -
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c     |    2=20
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c       |    5=20
 drivers/net/ethernet/intel/i40e/i40e_main.c          |   19 +--
 drivers/net/ethernet/intel/i40e/i40e_nvm.c           |   12 -
 drivers/net/ethernet/intel/i40e/i40e_txrx.c          |    1=20
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c        |    1=20
 drivers/net/ethernet/qlogic/qed/qed_cxt.c            |   32 ++++-
 drivers/net/ethernet/qlogic/qed/qed_main.c           |    3=20
 drivers/net/ethernet/qlogic/qed/qed_sriov.c          |   13 +-
 drivers/net/ieee802154/adf7242.c                     |    4=20
 drivers/net/ipvlan/ipvlan_core.c                     |    4=20
 drivers/net/phy/mdio-xgene.c                         |    2=20
 drivers/net/veth.c                                   |    3=20
 drivers/net/vxlan.c                                  |    5=20
 drivers/net/wireless/ath/ath10k/ce.c                 |    2=20
 drivers/net/wireless/ath/ath10k/debug.c              |    9 +
 drivers/net/wireless/ath/ath10k/mac.c                |   12 +
 drivers/net/wireless/ath/ath10k/wmi.c                |    5=20
 drivers/net/wireless/ath/ath10k/wmi.h                |    3=20
 drivers/net/wireless/ath/wil6210/main.c              |   20 ++-
 drivers/net/wireless/ath/wil6210/wmi.c               |   11 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c          |    4=20
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c          |   18 ++
 drivers/net/wireless/mac80211_hwsim.c                |   26 ++--
 drivers/net/wireless/marvell/mwifiex/cfg80211.c      |    6=20
 drivers/net/wireless/marvell/mwifiex/sdio.c          |    4=20
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c         |    3=20
 drivers/nfc/nfcmrvl/fw_dnld.c                        |    2=20
 drivers/nfc/nfcmrvl/spi.c                            |    5=20
 drivers/nfc/pn533/i2c.c                              |    4=20
 drivers/of/device.c                                  |    2=20
 drivers/pci/host/pci-hyperv.c                        |   24 +++
 drivers/pci/pci-driver.c                             |    2=20
 drivers/pci/quirks.c                                 |    3=20
 drivers/perf/arm_pmu.c                               |   12 +
 drivers/power/supply/ab8500_charger.c                |    6=20
 drivers/pwm/pwm-stmpe.c                              |    2=20
 drivers/pwm/pwm-tegra.c                              |    7 -
 drivers/regulator/core.c                             |    9 +
 drivers/scsi/be2iscsi/be_cmds.c                      |    6=20
 drivers/scsi/fnic/fnic_scsi.c                        |   16 +-
 drivers/scsi/ipr.c                                   |   16 +-
 drivers/scsi/qla2xxx/qla_os.c                        |    8 -
 drivers/scsi/scsi_devinfo.c                          |    9 -
 drivers/scsi/scsi_dh.c                               |    5=20
 drivers/scsi/ses.c                                   |   12 +
 drivers/scsi/sg.c                                    |   35 +++--
 drivers/spi/spi-omap2-mcspi.c                        |    9 -
 drivers/spi/spi-sun6i.c                              |    2=20
 drivers/staging/speakup/kobjects.c                   |    8 -
 drivers/staging/wilc1000/host_interface.c            |    2=20
 drivers/tty/serial/amba-pl011.c                      |   23 ++-
 drivers/tty/serial/imx.c                             |   36 +++--
 drivers/usb/dwc2/hcd.c                               |    1=20
 drivers/usb/dwc3/core.c                              |    6=20
 drivers/usb/dwc3/core.h                              |   17 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c                |    2=20
 drivers/usb/gadget/udc/bdc/bdc_pci.c                 |    1=20
 drivers/usb/gadget/udc/dummy_hcd.c                   |   20 +--
 drivers/usb/misc/lvstest.c                           |    1=20
 drivers/vfio/vfio_iommu_spapr_tce.c                  |   13 ++
 drivers/video/fbdev/amba-clcd.c                      |    4=20
 drivers/video/fbdev/omap2/omapfb/dss/dss.c           |   16 +-
 drivers/video/hdmi.c                                 |   51 +++++---
 fs/aio.c                                             |   44 ++++---
 fs/btrfs/volumes.c                                   |   12 +
 fs/dcache.c                                          |   11 +
 fs/f2fs/gc.c                                         |    6=20
 fs/namei.c                                           |    8 -
 fs/nfs/super.c                                       |    2=20
 fs/reiserfs/journal.c                                |    2=20
 fs/reiserfs/reiserfs.h                               |    1=20
 fs/reiserfs/super.c                                  |   21 ++-
 include/dt-bindings/clock/r8a7794-clock.h            |    1=20
 include/linux/fs.h                                   |    1=20
 include/linux/pagemap.h                              |    4=20
 include/linux/platform_data/isl9305.h                |    2=20
 include/linux/regulator/driver.h                     |    2=20
 include/net/tcp.h                                    |    8 -
 include/uapi/linux/eventpoll.h                       |    8 -
 kernel/locking/locktorture.c                         |   76 +++++++-----
 kernel/locking/rtmutex.c                             |   29 ++++
 kernel/locking/rtmutex_common.h                      |    1=20
 kernel/printk/braille.c                              |   15 +-
 kernel/printk/braille.h                              |   13 +-
 kernel/printk/printk.c                               |    8 -
 kernel/sched/core.c                                  |    3=20
 kernel/sched/rt.c                                    |    2=20
 kernel/time/sched_clock.c                            |    5=20
 kernel/time/timer_list.c                             |    6=20
 net/8021q/vlan_dev.c                                 |    3=20
 net/batman-adv/bridge_loop_avoidance.c               |   20 ++-
 net/bluetooth/6lowpan.c                              |   10 +
 net/bluetooth/af_bluetooth.c                         |   24 +++
 net/mac80211/iface.c                                 |    2=20
 net/sched/act_csum.c                                 |   12 +
 net/sched/sch_netem.c                                |   26 ++--
 net/xfrm/xfrm_policy.c                               |    2=20
 net/xfrm/xfrm_state.c                                |    7 +
 security/apparmor/lsm.c                              |    2=20
 security/integrity/ima/ima_appraise.c                |    3=20
 security/selinux/hooks.c                             |    8 +
 sound/core/oss/pcm_oss.c                             |   10 -
 sound/core/seq/seq_clientmgr.c                       |    4=20
 sound/core/seq/seq_prioq.c                           |   28 ++--
 sound/core/seq/seq_prioq.h                           |    6=20
 sound/core/seq/seq_queue.c                           |   28 +---
 sound/firewire/amdtp-stream.c                        |    5=20
 sound/firewire/amdtp-stream.h                        |    3=20
 sound/firewire/digi00x/amdtp-dot.c                   |   55 ++++++--
 sound/firewire/digi00x/digi00x.c                     |   13 +-
 sound/firewire/digi00x/digi00x.h                     |    1=20
 sound/pci/hda/hda_intel.c                            |   13 +-
 sound/soc/codecs/rt5677.c                            |    7 +
 sound/soc/nuc900/nuc900-ac97.c                       |    4=20
 sound/soc/sh/rcar/ssi.c                              |    9 +
 tools/perf/builtin-probe.c                           |    6=20
 tools/perf/builtin-stat.c                            |   23 +++
 tools/perf/builtin-trace.c                           |   43 +++++-
 tools/perf/util/annotate.c                           |   10 +
 tools/perf/util/build-id.c                           |    6=20
 tools/perf/util/event.c                              |    4=20
 tools/perf/util/evsel.c                              |   12 +
 tools/perf/util/ordered-events.c                     |    3=20
 tools/perf/util/probe-event.c                        |    2=20
 tools/perf/util/session.c                            |   17 ++
 tools/perf/util/sort.c                               |    5=20
 tools/testing/selftests/firmware/fw_filesystem.sh    |    5=20
 tools/testing/selftests/rcutorture/bin/configinit.sh |    2=20
 tools/testing/selftests/x86/entry_from_vm86.c        |  117 ++++++++++++++=
++++-
 tools/usb/usbip/src/usbipd.c                         |    2=20
 236 files changed, 1751 insertions(+), 677 deletions(-)

Aaron Salter (1):
      i40e: Acquire NVM lock before reads on all devices

Adiel Aloni (1):
      mac80211_hwsim: enforce PS_MANUAL_POLL to be set after PS_ENABLED

Akinobu Mita (1):
      spi: omap2-mcspi: poll OMAP2_MCSPI_CHSTAT_RXS for PIO transfer

Al Cooper (1):
      ARM: brcmstb: Enable ZONE_DMA for non 64-bit capable peripherals

Al Viro (1):
      lock_parent() needs to recheck if dentry got __dentry_kill'ed under it

Aleksandar Markovic (1):
      MIPS: r2-on-r6-emu: Clear BLTZALL and BGEZALL debugfs counters

Alexander Duyck (1):
      i40e/i40evf: Fix use after free in Rx cleanup path

Alexander Potapenko (1):
      selinux: check for address length in selinux_socket_bind()

Alexander Sergeyev (1):
      x86/speculation: Remove Skylake C2 from Speculation Control microcode=
 blacklist

Alexey Kardashevskiy (2):
      vfio/powerpc/spapr_tce: Enforce IOMMU type compatibility check
      vfio/spapr_tce: Check kzalloc() return when preregistering memory

Andreas Pape (1):
      batman-adv: handle race condition for claims between gateways

Andrew F. Davis (2):
      ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin
      ARM: dts: omap3-n900: Fix the audio CODEC's reset pin

Andrew Lunn (1):
      net/faraday: Add missing include of of.h

Andrey Rusalin (1):
      NFC: pn533: change order of free_irq and dev unregistration

Andrey Vagin (1):
      net/8021q: create device with all possible features in wanted_features

Andy Lutomirski (5):
      x86/boot/32: Defer resyncing initial_page_table until per-cpu is set =
up
      x86/boot/32: Fix UP boot on Quark and possibly other platforms
      selftests/x86/entry_from_vm86: Exit with 1 if we fail
      selftests/x86/entry_from_vm86: Add test cases for POPF
      x86/vm86/32: Fix POPF emulation

Andy Whitcroft (1):
      x86/speculation, objtool: Annotate indirect calls/jumps for objtool o=
n 32-bit kernels

Aneesh Kumar K.V (1):
      powerpc/mm/hugetlb: Filter out hugepage size not supported by page ta=
ble layout

Anton Blanchard (1):
      powerpc: Avoid taking a data miss on every userspace instruction miss

Anton Sviridenko (1):
      solo6x10: release vb2 buffers in solo_stop_streaming()

Ard Biesheuvel (1):
      irqchip/gic-v3-its: Ensure nr_ites >=3D nr_lpis

Arnaldo Carvalho de Melo (1):
      perf trace: Handle unpaired raw_syscalls:sys_exit event

Arnd Bergmann (1):
      lkdtm: turn off kcov for lkdtm_rodata_do_nothing:

Arvind Yadav (1):
      omapfb: dss: Handle return errors in dss_init_ports()

Axel Lin (1):
      pwm: stmpe: Fix wrong register offset for hwpwm=3D2 case

Bart Van Assche (1):
      scsi: core: scsi_get_device_flags_keyed(): Always return device flags

Baruch Siach (1):
      ARM: dts: bcm2835: add index to the ethernet alias

Ben Greear (1):
      ath10k: fix invalid STS_CAP_OFFSET_MASK

Bill Kuzeja (1):
      scsi: qla2xxx: Fix extraneous ref on sp's after adapter break

Bjorn Andersson (1):
      leds: pm8058: Silence pointer to integer size warning

Borislav Petkov (2):
      perf stat: Issue a HW watchdog disable hint
      kvm/svm: Setup MCG_CAP on AMD properly

Brian King (1):
      scsi: ipr: Fix missed EH wakeup

Changbin Du (1):
      perf sort: Fix segfault with basic block 'cycles' sort dimension

Chen-Yu Tsai (3):
      drm/sun4i: Fix up error path cleanup for master bind function
      drm/sun4i: Set drm_crtc.port to the underlying TCON's output port node
      drm/sun4i: Fix TCON clock and regmap initialization sequence

Chris Brandt (1):
      ARM: dts: r7s72100: fix ethernet clock parent

Chris Wilson (2):
      drm: Defer disabling the vblank IRQ until the next interrupt (for ins=
tant-off)
      agp/intel: Flush all chipset writes after updating the GGTT

Christian K=F6nig (1):
      drm/amdgpu: fix prime teardown order

Christophe JAILLET (2):
      power: supply: ab8500_charger: Fix an error handling path
      power: supply: ab8500_charger: Bail out in case of error in 'ab8500_c=
harger_init_hw_registers()'

Christopher James Halse Rogers (2):
      drm/radeon: Fail fb creation from imported dma-bufs.
      drm/amdgpu: Fail fb creation from imported dma-bufs. (v2)

Colin Ian King (1):
      staging: wilc1000: add check for kmalloc allocation failure.

Dan Carpenter (3):
      NFC: nfcmrvl: double free on error path
      media: cpia2: Fix a couple off by one bugs
      ASoC: nuc900: Fix a loop timeout test

David Carrillo-Cisneros (2):
      perf inject: Copy events when reordering events in pipe mode
      perf session: Don't rely on evlist in pipe mode

David Daney (2):
      MIPS: BPF: Quit clobbering callee saved registers in JIT code.
      MIPS: BPF: Fix multiple problems in JIT skb access helpers.

David Engraf (1):
      timers, sched_clock: Update timeout for clock wrap

Davide Caratti (1):
      sched: act_csum: don't mangle TCP and UDP GSO packets

Davidlohr Bueso (1):
      locking/locktorture: Fix num reader/writer corner cases

Dean Jenkins (1):
      Bluetooth: Avoid bt_accept_unlink() double unlinking

Dedy Lansky (1):
      wil6210: fix memory access violation in wil_memcpy_from/toio_32

Dmitry Safonov (1):
      x86/mm: Make mmap(MAP_32BIT) work correctly

Easwar Hariharan (1):
      IB/hfi1: Check for QSFP presence before attempting reads

Emmanuel Grumbach (1):
      iwlwifi: mvm: rs: don't override the rate history in the search cycle

Eric Dumazet (1):
      bonding: refine bond_fold_stats() wrap detection

Eric W. Biederman (2):
      userns: Don't fail follow_automount based on s_user_ns
      fs: Teach path_connected to handle nfs filesystems with multiple root=
s.

Felipe Balbi (1):
      usb: dwc3: make sure UX_EXIT_PX is cleared

Felix Manlunas (1):
      vxlan: vxlan dev should inherit lowerdev's gso_max_size

Fugang Duan (1):
      net: fec: add phy-reset-gpios PROBE_DEFER check

Gabriel Krisman Bertazi (1):
      drm: qxl: Don't alloc fbdev if emulation is not supported

Ganapathi Bhat (1):
      mwifiex: Fix invalid port issue

Gao Feng (1):
      tcp: sysctl: Fix a race to avoid unexpected 0 window from space

Geert Uytterhoeven (12):
      ARM: dts: r8a7791: Remove unit-address and reg from integrated cache
      ARM: dts: r8a7792: Remove unit-address and reg from integrated cache
      ARM: dts: r8a7793: Remove unit-address and reg from integrated cache
      ARM: dts: r8a7794: Remove unit-address and reg from integrated cache
      arm64: dts: r8a7796: Remove unit-address and reg from integrated cache
      ARM: dts: r8a7794: Add DU1 clock to device tree
      ARM: dts: r8a7794: Correct clock of DU1
      ARM: dts: silk: Correct clock of DU1
      ARM: dts: r8a7790: Correct parent of SSI[0-9] clocks
      ARM: dts: r8a7791: Correct parent of SSI[0-9] clocks
      ARM: dts: r8a7793: Correct parent of SSI[0-9] clocks
      ARM: dts: koelsch: Correct clock frequency of X2 DU clock input

Greg KH (1):
      eventpoll.h: fix epoll event masks

Greg Kroah-Hartman (1):
      Linux 4.9.89

H. Nikolaus Schaller (1):
      Input: tsc2007 - check for presence and power down tsc2007 during pro=
be

Hamad Kadmany (1):
      wil6210: fix protection against connections during reset

Hannes Reinecke (1):
      scsi: sg: close race condition in sg_remove_sfp_usercontext()

Hans van Kranenburg (1):
      btrfs: alloc_chunk: fix DUP stripe size handling

Heiko Carstens (1):
      s390/topology: fix typo in early topology code

Hou Tao (1):
      blkcg: fix double free of new_blkg in blkcg_init_queue

Iyappan Subramanian (1):
      drivers: net: xgene: Fix Rx checksum validation logic

Jaegeuk Kim (1):
      f2fs: relax node version check for victim data in gc

Jagdish Gediya (1):
      mtd: nand: ifc: update bufnum mask for ver >=3D 2.0.0

Jan Kara (1):
      reiserfs: Make cancel_old_flush() reliable

Jani Nikula (1):
      drm/edid: set ELD connector type in drm_edid_to_eld()

Janusz Krzysztofik (1):
      media: i2c/soc_camera: fix ov6650 sensor getting wrong clock

Javier Martinez Canillas (2):
      Input: qt1070 - add OF device ID table
      ASoC: rt5677: Add OF device ID table

Jayachandran C (1):
      tty: amba-pl011: Fix spurious TX interrupts

Jeffy Chen (1):
      drm/rockchip: vop: Enable pm domain before vop_initial

Jiada Wang (1):
      dmaengine: imx-sdma: add 1ms delay to ensure SDMA channel is stopped

Jim Mattson (1):
      kvm: nVMX: Disallow userspace-injected exceptions in guest mode

Jin Yao (1):
      perf evsel: Return exact sub event which failed with EPERM for wildca=
rds

Jiri Kosina (1):
      HID: elo: clear BTN_LEFT mapping

Jitendra Bhivare (1):
      scsi: be2iscsi: Check tag in beiscsi_mccq_compl_wait

Johan Hovold (1):
      zd1211rw: fix NULL-deref at probe

Johannes Berg (2):
      iwlwifi: mvm: fix RX SKB header size and align it properly
      mac80211_hwsim: use per-interface power level

Johannes Thumshirn (4):
      scsi: sg: check for valid direction before starting the request
      scsi: sg: fix SG_DXFER_FROM_DEV transfers
      scsi: sg: fix static checker warning in sg_is_valid_dxfer
      scsi: sg: only check for dxfer_len greater than 256M

John David Anglin (1):
      parisc: Handle case where flush_cache_range is called with no context

John Johansen (1):
      apparmor: Make path_max parameter readonly

John Stultz (1):
      usb: dwc2: Make sure we disconnect the gadget state

Josh Poimboeuf (1):
      powerpc/modules: Don't try to restore r2 after a sibling call

Julien BOIBESSOT (1):
      tools/usbip: fixes build with musl libc toolchain

Kefeng Wang (1):
      perf probe: Return errno when not hitting any event

Kieran Bingham (3):
      v4l: vsp1: Prevent multiple streamon race commencing pipeline early
      v4l: vsp1: Register pipe with output WPF
      media: vsp1: Prevent suspending and resuming DRM pipelines

Kirill A. Shutemov (2):
      mm: Fix false-positive VM_BUG_ON() in page_cache_{get,add}_speculativ=
e()
      x86/cpufeatures: Add Intel PCONFIG cpufeature

Kuninori Morimoto (1):
      ASoC: rcar: ssi: don't set SSICR.CKDV =3D 000 with SSIWSR.CONT

Laurent Pinchart (1):
      drm: rcar-du: Handle event when disabling CRTCs

Laxman Dewangan (1):
      pwm: tegra: Increase precision in PWM rate calculation

Leonid Yegoshin (1):
      MIPS: r2-on-r6-emu: Fix BLEZL and BGTZL identification

Li Dongyang (1):
      scsi: ses: don't ask for diagnostic pages repeatedly during probe

Liam Beguin (1):
      video: ARM CLCD: fix dma allocation size

Lihong Yang (1):
      i40e: fix ethtool to get EEPROM data from X722 interface

Limin Zhu (1):
      mwifiex: cfg80211: do not change virtual interface during scan proces=
sing

Linus Walleij (1):
      ARM: dts: Adjust moxart IRQ controller and flags

Long Li (2):
      PCI: hv: Properly handle PCI bus remove
      PCI: hv: Lock PCI bus on device eject

Lorenzo Colitti (1):
      net: xfrm: allow clearing socket xfrm policies.

Luca Coelho (1):
      mac80211: remove BUG() when interface type is invalid

Luis R. Rodriguez (1):
      test_firmware: fix setting old custom fw path back on exit

Mahesh Bandewar (2):
      bonding: make speed, duplex setting consistent with link state
      ipvlan: add L2 check for packets arriving via virtual devices

Manikanta Pubbisetty (1):
      ath10k: update tdls teardown state to target

Manish Jaggi (1):
      PCI: Apply Cavium ACS quirk only to CN81xx/CN83xx/CN88xx devices

Mark Rutland (1):
      drivers/perf: arm_pmu: handle no platform_device

Masami Hiramatsu (2):
      kprobes/x86: Fix kprobe-booster not to boost far call instructions
      kprobes/x86: Set kprobes pages read-only

Matthias Kaehlcke (1):
      regulator: core: Limit propagation of parent voltage count and list

Mauricio Faria de Oliveira (1):
      scsi: ses: don't get power status of SES device slot on probe

Michael Chan (1):
      bnxt_en: Don't print "Link speed -1 no longer supported" messages.

Michael Ellerman (1):
      powerpc/nohash: Fix use of mmu_has_feature() in setup_initial_memory_=
limit()

Michael Hennerich (1):
      net: ieee802154: adf7242: Fix bug if defined DEBUG

Michael Scott (1):
      Bluetooth: 6lowpan: fix delay work init in add_peer_chan()

Michal Kalderon (1):
      qed: Fix TM block ILT allocation

Michel D=E4nzer (1):
      drm/amdgpu/dce: Don't turn off DP sink when disconnected

Mike Leach (1):
      coresight: Fixes coresight DT parse to get correct output port ID.

Mimi Zohar (1):
      ima: relax requiring a file signature for new files with zero length

Mintz, Yuval (2):
      qed: Always publish VF link from leading hwfn
      qed: Correct MSI-x for storage

Miquel Raynal (1):
      mtd: nand: fix interpretation of NAND_CMD_NONE in nand_command[_lp]()

Mitch Williams (1):
      i40e: only register client on iWarp-capable devices

Mohammed Shafi Shajakhan (4):
      ath10k: fix a warning during channel switch with multiple vaps
      ath10k: disallow DFS simulation if DFS channel is not enabled
      ath10k: fix fetching channel during potential radar detection
      ath10k: fix compile time sanity check for CE4 buffer size

Nate Watterson (1):
      iommu/iova: Fix underflow bug in __alloc_and_insert_iova_range

NeilBrown (1):
      md/raid6: Fix anomily when recovering a single device in RAID6.

Nicolai H=E4hnle (1):
      drm/ttm: never add BO that failed to validate to the LRU list

Nik Unger (1):
      netem: apply correct delay when rate throttling

Nikolay Borisov (1):
      btrfs: Fix use-after-free when cleaning up fs_devs with a single stal=
e device

Oliver Neukum (1):
      usb: misc: lvs: fix race condition in disconnect handling

Paul E. McKenney (2):
      sched: Stop switched_to_rt() from sending IPIs to offline CPUs
      sched: Stop resched_cpu() from sending IPIs to offline CPUs

Peter Zijlstra (1):
      rtmutex: Fix PI chain order integrity

Petr Mladek (1):
      printk: Correctly handle preemption in console_unlock()

Phil Turnbull (1):
      fm10k: correctly check if interface is removed

Prarit Bhargava (1):
      PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()

Quan Nguyen (3):
      drivers: net: xgene: Fix hardware checksum setting
      drivers: net: phy: xgene: Fix mdio write
      drivers: net: xgene: Fix wrong logical operation

Rajendra Nayak (1):
      clk: qcom: msm8996: Fix the vfe1 powerdomain name

Ravi Bangoria (1):
      perf probe: Fix concat_probe_trace_events

Ricardo Neri (2):
      selftests/x86: Add tests for User-Mode Instruction Prevention
      selftests/x86: Add tests for the STR and SLDT instructions

Rob Herring (1):
      of: fix of_device_get_modalias returned length when truncating buffers

Salil (1):
      net: hns: Some checkpatch.pl script & warning fixes

Samuel Thibault (1):
      braille-console: Fix value returned by _braille_console_setup

Satish Kharat (1):
      scsi: fnic: Fix for "Number of Active IOs" in fnicstats becoming nega=
tive

SeongJae Park (1):
      rcutorture/configinit: Fix build directory error message

Shaohua Li (1):
      blk-throttle: make sure expire time isn't too big

Shikhar Dogra (1):
      driver: (adm1275) set the m,b and R coefficients correctly for power

Simon Shields (1):
      ARM: dts: exynos: Correct Trats2 panel reset line

Sinclair Yeh (1):
      drm/vmwgfx: Fixes to vmwgfx_fb

Srinath Mannam (1):
      usb: gadget: bdc: 64-bit pointer capability check

Srinivas Kandagatla (1):
      clk: qcom: msm8916: fix mnd_width for codec_digcodec

Stefan Wahren (1):
      ARM: bcm2835: Enable missing CMA settings for VC4 driver

Stephane Eranian (2):
      perf tools: Make perf_event__synthesize_mmap_events() scale
      perf stat: Fix bug in handling events in error state

Stephen Hemminger (1):
      veth: set peer GSO values

Steve Lin (1):
      net: ethernet: bgmac: Allow MAC address to be specified in DTB

Subhransu S. Prusty (1):
      ALSA: hda: Add Geminilake id to SKL_PLUS

Sunil Goutham (1):
      net: thunderx: Set max queue count taking XDP_TX into account

Taeung Song (1):
      perf annotate: Fix a bug following symbolic link of a build-id file

Takashi Iwai (4):
      ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()
      ALSA: hda - Revert power_save option default value
      ALSA: seq: Fix possible UAF in snd_seq_check_queue()
      ALSA: seq: Clear client entry before deleting else at closing

Takashi Sakamoto (3):
      ALSA: firewire-lib: add a quirk of packet without valid EOH in CIP fo=
rmat
      ALSA: firewire-digi00x: add support for console models of Digi00x ser=
ies
      ALSA: firewire-digi00x: handle all MIDI messages on streaming packets

Tejun Heo (2):
      fs/aio: Add explicit RCU grace period when freeing kioctx
      fs/aio: Use RCU accessors for kioctx_table->table[]

Thinh Nguyen (1):
      usb: dwc3: Fix GDBGFIFOSPACE_TYPE values

Thor Thayer (1):
      EDAC, altera: Fix peripheral warnings for Cyclone5

Tobias Jordan (1):
      spi: sun6i: disable/unprepare clocks on remove

Tobias Klauser (1):
      NFC: nfcmrvl: Include unaligned.h instead of access_ok.h

Tom Hromatka (1):
      sysrq: Reset the watchdog timers while displaying high-resolution tim=
ers

Tomasz Kramkowski (1):
      HID: clamp input to logical range if no null state

Tommi Rantala (1):
      perf buildid: Do not assume that readlink() returns a null terminated=
 string

Toshi Kani (1):
      x86/mm: Fix vmalloc_fault to use pXd_large

Uwe Kleine-K=F6nig (1):
      serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off

Valtteri Heikkil=E4 (1):
      HID: reject input outside logical range only if null state is set

Varsha Rao (1):
      staging: speakup: Replace BUG_ON() with WARN_ON().

Ville Syrj=E4l=E4 (1):
      video/hdmi: Allow "empty" HDMI infoframes

Vincent Stehl=E9 (1):
      regulator: isl9305: fix array size

Wei Yongjun (1):
      USB: gadget: udc: Add missing platform_device_put() on error in bdc_p=
ci_probe()

Xose Vazquez Perez (2):
      scsi: devinfo: apply to HP XP the same flags as Hitachi VSP
      scsi: dh: add new rdac devices

Xunlei Pang (1):
      x86/mce: Handle broadcasted MCE gracefully with kexec

Yazen Ghannam (1):
      x86/mce: Init some CPU features early

Yixun Lan (1):
      clk: meson: gxbb: fix wrong clock for SARADC/SANA

Yong Zhao (1):
      drm/amdkfd: Fix memory leaks in kfd topology

Yuyang Du (1):
      usb: gadget: dummy_hcd: Fix wrong power status bit clear/reset in dum=
my_hub_control()

Zhilong Liu (1):
      md.c:didn't unlock the mddev before return EINVAL in array_size_store

lipeng (1):
      net: hns: Correct HNS RSS key set function


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqzcTkACgkQONu9yGCS
aT6IPw//QdQiE+DnjYlEiCist3wlOoXJNedPGQ25VgN+/hOqG1cz+UUrgsOuN1m+
TF5zg1VGHXeoZzcPPS8DgcKnBP0piYC40VILqV89zX8b3nrVUrvOyrVz52WuY2rO
nYu4VeXSIMw4Jv5NDozcSVoazz1tbw1nljjzuBro2azmJTnuV+5muTqbzUUZFa10
4BpGPVb7FhCkGsvSHapTKC+cf6oUhZAUkzRsg+2wcxCg2pMWSURT31TkTd/vRkm9
VbawtjhUA5dyuTeR4cT2s4MqGzMf1XAoXDDY+2rTkdiGuD9Tjmj8LBGOiAw9UKvF
TuQF4q4AnNvEqeI3GOl13ToVQ5Mb5Aqao2gPfQMzbJT3thWAiC3U51z4kXavQDlI
JHjA30r4fRwL2nHTnQt2l/sysqfGGEPcobyMjKg/bv0AhJfP0UKqIdVhDtXSbKxB
zfNzk/A3w+QZ3tfbdSh8ruzLij1LUTY4Ns6hDUivJ7bryfRA7T0V2XYR2AO8Ik2A
dmsIAxT/c7KPntaBvsJLLRFOvcWyOp5brYLaYgrTI25Hn7g6bQbEY/wXextzzh1F
6CM2FOIF2i7I/YNkTIGNg5MeJvUbBmbscAEUvd3MBsveOYlN3oa493nFAlNAobnk
w5WyFLOf/AAPx4njaLJN3XSvl2Nf3eSR/fMGthJMzl+gG8mUCtQ=
=e/6V
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
