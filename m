Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E89FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6972083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6972083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeIZPMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:12:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34106 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbeIZPMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:12:33 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1BEA210A3;
        Wed, 26 Sep 2018 09:00:34 +0000 (UTC)
Date:   Wed, 26 Sep 2018 11:00:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.72
Message-ID: <20180926090032.GA12184@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.72 kernel.

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

 Makefile                                                      |    2=20
 arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts      |    2=20
 arch/arm/mach-exynos/suspend.c                                |    1=20
 arch/arm/mach-hisi/hotplug.c                                  |   41 ++-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi                     |    2=20
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi              |    2=20
 arch/arm64/kernel/ptrace.c                                    |   19 +
 arch/mips/ath79/setup.c                                       |    1=20
 arch/mips/include/asm/mach-ath79/ath79.h                      |    1=20
 arch/mips/jz4740/Platform                                     |    2=20
 arch/mips/loongson64/common/cs5536/cs5536_ohci.c              |    2=20
 arch/powerpc/kvm/book3s_hv.c                                  |    2=20
 arch/powerpc/platforms/powernv/opal.c                         |    2=20
 arch/s390/crypto/paes_s390.c                                  |    2=20
 arch/x86/kernel/eisa.c                                        |   10=20
 arch/x86/mm/pti.c                                             |   25 +-
 arch/xtensa/platforms/iss/setup.c                             |   25 +-
 block/blk-core.c                                              |    8=20
 block/blk-mq-sched.c                                          |    3=20
 block/blk-settings.c                                          |    2=20
 crypto/api.c                                                  |    2=20
 drivers/base/core.c                                           |    3=20
 drivers/char/ipmi/ipmi_ssif.c                                 |   19 -
 drivers/clk/clk-fixed-factor.c                                |    9=20
 drivers/clk/clk.c                                             |    3=20
 drivers/clk/imx/clk-imx6ul.c                                  |    1=20
 drivers/clk/tegra/clk-bpmp.c                                  |   12 -
 drivers/crypto/sahara.c                                       |    4=20
 drivers/dma/mv_xor_v2.c                                       |    2=20
 drivers/dma/pl330.c                                           |    5=20
 drivers/firmware/efi/arm-init.c                               |    1=20
 drivers/firmware/efi/arm-runtime.c                            |    4=20
 drivers/firmware/efi/esrt.c                                   |    3=20
 drivers/gpio/gpio-pxa.c                                       |    2=20
 drivers/gpio/gpiolib.h                                        |    2=20
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                      |    2=20
 drivers/gpu/drm/i915/i915_gem.c                               |    4=20
 drivers/gpu/drm/nouveau/nouveau_debugfs.c                     |    4=20
 drivers/gpu/drm/nouveau/nouveau_drm.c                         |    6=20
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c            |   13 +
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c                 |    2=20
 drivers/gpu/ipu-v3/ipu-csi.c                                  |   20 +
 drivers/hwtracing/coresight/coresight-etm4x.c                 |   31 +-
 drivers/hwtracing/coresight/coresight-tpiu.c                  |    7=20
 drivers/hwtracing/coresight/coresight.c                       |    7=20
 drivers/i2c/busses/i2c-aspeed.c                               |    4=20
 drivers/infiniband/core/cma.c                                 |   12 -
 drivers/infiniband/sw/rxe/rxe_recv.c                          |    9=20
 drivers/infiniband/ulp/ipoib/ipoib_cm.c                       |    2=20
 drivers/infiniband/ulp/ipoib/ipoib_main.c                     |    3=20
 drivers/input/touchscreen/rohm_bu21023.c                      |    4=20
 drivers/iommu/arm-smmu-v3.c                                   |    1=20
 drivers/iommu/io-pgtable-arm-v7s.c                            |    7=20
 drivers/media/i2c/ov5645.c                                    |   13 -
 drivers/media/pci/tw686x/tw686x-video.c                       |   11 -
 drivers/media/v4l2-core/videobuf2-core.c                      |    5=20
 drivers/mfd/88pm860x-i2c.c                                    |    8=20
 drivers/misc/hmc6352.c                                        |    2=20
 drivers/misc/mei/bus-fixup.c                                  |    2=20
 drivers/misc/mei/bus.c                                        |    9=20
 drivers/misc/mei/hbm.c                                        |    9=20
 drivers/mmc/host/omap_hsmmc.c                                 |    1=20
 drivers/mmc/host/sdhci-of-esdhc.c                             |    6=20
 drivers/mmc/host/sdhci-tegra.c                                |    3=20
 drivers/mmc/host/sdhci.c                                      |    9=20
 drivers/mtd/maps/solutionengine.c                             |    6=20
 drivers/mtd/mtdchar.c                                         |   10=20
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c                     |    7=20
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c       |    3=20
 drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c       |    3=20
 drivers/net/ethernet/emulex/benet/be_cmds.c                   |    2=20
 drivers/net/ethernet/intel/e1000e/defines.h                   |   21 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c                   |   42 +--
 drivers/net/ethernet/intel/e1000e/mac.c                       |   25 --
 drivers/net/ethernet/intel/e1000e/netdev.c                    |   33 +--
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                 |    1=20
 drivers/net/ethernet/mellanox/mlx5/core/dev.c                 |   15 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c    |    1=20
 drivers/net/ethernet/mellanox/mlx5/core/health.c              |   10=20
 drivers/net/ethernet/mellanox/mlx5/core/main.c                |   12 -
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c           |   13 -
 drivers/net/ethernet/qualcomm/qca_7k.c                        |   76 +++---
 drivers/net/ethernet/qualcomm/qca_spi.c                       |  110 +++++=
-----
 drivers/net/ethernet/qualcomm/qca_spi.h                       |    5=20
 drivers/net/hyperv/rndis_filter.c                             |    2=20
 drivers/net/wan/fsl_ucc_hdlc.c                                |    6=20
 drivers/net/xen-netfront.c                                    |   30 +-
 drivers/nvme/host/rdma.c                                      |    2=20
 drivers/parport/parport_sunbpp.c                              |    8=20
 drivers/pinctrl/pinctrl-rza1.c                                |   24 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                            |   14 +
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                      |   32 ++
 drivers/platform/x86/toshiba_acpi.c                           |    3=20
 drivers/reset/reset-imx7.c                                    |    2=20
 drivers/rtc/rtc-bq4802.c                                      |    4=20
 drivers/s390/net/qeth_core_main.c                             |    3=20
 drivers/s390/net/qeth_core_sys.c                              |    1=20
 drivers/scsi/libfc/fc_disc.c                                  |    7=20
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c   |   16 -
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c |    7=20
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c     |   11 -
 drivers/tty/serial/earlycon.c                                 |    5=20
 drivers/tty/tty_baudrate.c                                    |   13 -
 drivers/usb/class/cdc-acm.c                                   |   73 ------
 drivers/usb/class/cdc-acm.h                                   |    1=20
 drivers/usb/class/cdc-wdm.c                                   |    2=20
 drivers/usb/core/hcd-pci.c                                    |    2=20
 drivers/usb/core/message.c                                    |   11 +
 drivers/usb/core/quirks.c                                     |    7=20
 drivers/usb/dwc3/gadget.h                                     |    2=20
 drivers/usb/gadget/udc/net2280.c                              |   16 +
 drivers/usb/gadget/udc/renesas_usb3.c                         |    5=20
 drivers/usb/host/u132-hcd.c                                   |    2=20
 drivers/usb/host/xhci.c                                       |   30 ++
 drivers/usb/misc/uss720.c                                     |    4=20
 drivers/usb/misc/yurex.c                                      |    5=20
 drivers/usb/serial/io_ti.h                                    |    2=20
 drivers/usb/serial/ti_usb_3410_5052.c                         |    2=20
 drivers/usb/storage/scsiglue.c                                |    9=20
 drivers/usb/storage/uas.c                                     |   21 +
 drivers/usb/storage/unusual_devs.h                            |    7=20
 drivers/video/fbdev/core/modedb.c                             |   41 ++-
 drivers/video/fbdev/goldfishfb.c                              |    1=20
 drivers/video/fbdev/omap/omapfb_main.c                        |    2=20
 drivers/video/fbdev/pxafb.c                                   |    4=20
 drivers/video/fbdev/via/viafbdev.c                            |    3=20
 fs/binfmt_elf.c                                               |    2=20
 fs/cifs/readdir.c                                             |   11 -
 fs/cifs/smb2pdu.c                                             |   25 +-
 fs/configfs/dir.c                                             |   11 +
 fs/gfs2/bmap.c                                                |    2=20
 fs/gfs2/rgrp.c                                                |    3=20
 fs/namespace.c                                                |    7=20
 fs/nfs/nfs4proc.c                                             |   10=20
 fs/nfs/nfs4state.c                                            |    2=20
 fs/pstore/ram_core.c                                          |   17 +
 include/linux/crypto.h                                        |    5=20
 include/linux/mlx5/driver.h                                   |    2=20
 kernel/audit_watch.c                                          |   12 +
 kernel/events/core.c                                          |    4=20
 kernel/sched/fair.c                                           |   10=20
 kernel/sched/wait.c                                           |   47 +---
 net/bluetooth/af_bluetooth.c                                  |    2=20
 net/core/skbuff.c                                             |    3=20
 net/ipv4/ip_gre.c                                             |    4=20
 net/ipv4/tcp.c                                                |    2=20
 net/ipv6/route.c                                              |   13 -
 net/mac80211/cfg.c                                            |    2=20
 net/mac80211/key.c                                            |   24 +-
 net/rds/bind.c                                                |    5=20
 net/tls/tls_sw.c                                              |    6=20
 net/xfrm/xfrm_policy.c                                        |    5=20
 scripts/Kbuild.include                                        |    3=20
 security/integrity/evm/evm_crypto.c                           |    3=20
 security/security.c                                           |    2=20
 security/smack/smack_lsm.c                                    |   14 -
 sound/core/pcm_lib.c                                          |   14 -
 sound/isa/msnd/msnd_pinnacle.c                                |    4=20
 sound/soc/codecs/rt5514.c                                     |    8=20
 sound/soc/samsung/i2s.c                                       |    5=20
 sound/soc/samsung/tm2_wm5110.c                                |    3=20
 sound/usb/quirks-table.h                                      |    3=20
 tools/hv/hv_kvp_daemon.c                                      |    2=20
 tools/perf/arch/powerpc/util/skip-callchain-idx.c             |   10=20
 tools/perf/tests/builtin-test.c                               |    2=20
 tools/perf/util/comm.c                                        |   16 +
 tools/perf/util/header.c                                      |    2=20
 tools/testing/selftests/timers/raw_skew.c                     |    5=20
 virt/kvm/arm/vgic/vgic-init.c                                 |    4=20
 virt/kvm/arm/vgic/vgic-mmio-v2.c                              |    3=20
 170 files changed, 1013 insertions(+), 605 deletions(-)

Aaron Knister (1):
      IB/ipoib: Avoid a race condition between start_xmit and cm_rep_handler

Alan Stern (1):
      USB: net2280: Fix erroneous synchronization change

Alexander Usyskin (1):
      mei: ignore not found client in the enumeration

Andrea Parri (1):
      sched/core: Use smp_mb() in wake_woken_function()

Andreas Gruenbacher (1):
      gfs2: Special-case rindex for gfs2_grow

Andreas Kemnade (1):
      mmc: omap_hsmmc: fix wakeirq handling on removal

Andy Shevchenko (1):
      gpiolib: Mark gpio_suffixes array with __maybe_unused

Anton Vasilyev (1):
      video: goldfishfb: fix memory leak on driver remove

Ard Biesheuvel (2):
      efi/arm: preserve early mapping of UEFI memory map longer for BGRT
      efi/esrt: Only call efi_mem_reserve() for boot services memory

Ben Hutchings (1):
      USB: yurex: Fix buffer over-read in yurex_write()

Benjamin Poirier (7):
      e1000e: Remove Other from EIAC
      Partial revert "e1000e: Avoid receiver overrun interrupt bursts"
      e1000e: Fix queue interrupt re-raising in Other interrupt
      e1000e: Avoid missed interrupts following ICR read
      Revert "e1000e: Separate signaling for link check/link up"
      e1000e: Fix link check race condition
      e1000e: Fix check_for_link return value with autoneg off

Bhushan Shah (1):
      ARM: dts: qcom: msm8974-hammerhead: increase load on l20 for sdhci

Bin Yang (1):
      pstore: Fix incorrect persistent ram buffer mapping

Bob Peterson (1):
      gfs2: Don't reject a supposedly full bitmap if we have blocks reserved

Boris Ostrovsky (1):
      x86/EISA: Don't probe EISA bus for Xen PV guests

Chris Wilson (1):
      drm/i915: Apply the GTT write flush for all !llc machines

Christoffer Dall (1):
      KVM: arm/arm64: Fix vgic init race

Christophe Jaillet (1):
      ASoC: samsung: i2s: Fix error handling path in i2s_set_sysclk()

Cong Wang (1):
      rds: fix two RCU related problems

Corey Minyard (1):
      ipmi: Fix I2C client removal in the SSIF driver

Dan Carpenter (5):
      fbdev: omapfb: off by one in omapfb_register_client()
      cifs: prevent integer overflow in nxt_dir_entry()
      CIFS: fix wrapping bugs in num_entries()
      drm/panel: type promotion bug in s6e8aa0_read_mtp_id()
      mei: bus: type promotion bug in mei_nfc_if_version()

Daniel Mack (1):
      video: fbdev: pxafb: clear allocated memory for video modes

David Ahern (1):
      net/ipv6: prevent use after free in ip6_route_mpath_notify

Douglas Anderson (2):
      pinctrl: msm: Fix msm_config_group_get() to be compliant
      pinctrl: qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant

Enrico Scholz (1):
      gpu: ipu-v3: csi: pass back mbus_code_to_bus_cfg error codes

Eric Biggers (1):
      security: check for kstrdup() failure in lsm_append()

Erich E. Hoover (1):
      usb: dwc3: change stream event enable bit back to 13

Felix Fietkau (1):
      MIPS: ath79: fix system restart

Fredrik Noring (1):
      fbdev: Distinguish between interlaced and progressive modes

Greg Kroah-Hartman (1):
      Linux 4.14.72

Gustavo A. R. Silva (1):
      misc: hmc6352: fix potential Spectre v1

Haishuang Yan (2):
      erspan: fix error handling for erspan tunnel
      erspan: return PACKET_REJECT when the appropriate tunnel is not found

Hanna Hawa (1):
      dmaengine: mv_xor_v2: kill the tasklets upon exit

Hannes Reinecke (1):
      scsi: libfc: fixup 'sleeping function called from invalid context'

Hans Verkuil (1):
      media: videobuf2-core: check for q->error in vb2_core_qbuf()

Huy Nguyen (1):
      net/mlx5: Check for error in mlx5_attach_interface

Ingo Franzki (1):
      s390/crypto: Fix return code checking in cbc_paes_crypt()

Jack Morgenstein (2):
      net/mlx5: Fix use-after-free in self-healing flow
      net/mlx5: Fix debugfs cleanup in the device init/remove flow

Jae Hyun Yoo (1):
      i2c: aspeed: Fix initial values of master and slave state

Jaechul Lee (1):
      ASoC: samsung: Fix invalid argument when devm_gpiod_get is called

Jakub Kicinski (1):
      nfp: avoid buffer leak when FW communication fails

Jann Horn (1):
      mtdchar: fix overflows in adjustment of `count`

Jean-Philippe Brucker (1):
      iommu/io-pgtable-arm-v7s: Abort allocation when table address overflo=
ws the PTE

Jia-Ju Bai (3):
      usb: host: u132-hcd: Fix a sleep-in-atomic-context bug in u132_get_fr=
ame()
      usb: misc: uss720: Fix two sleep-in-atomic-context bugs
      usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstandin=
g_interrupt()

Jiang Biao (2):
      x86/pti: Check the return value of pti_user_pagetable_walk_p4d()
      x86/pti: Check the return value of pti_user_pagetable_walk_pmd()

Jiri Olsa (2):
      perf tools: Synthesize GROUP_DESC feature in pipe mode
      perf tools: Fix struct comm_str removal crash

Joerg Roedel (1):
      x86/mm/pti: Add an overflow check to pti_clone_pmds()

Johan Hovold (4):
      USB: serial: io_ti: fix array underflow in completion handler
      USB: serial: ti_usb_3410_5052: fix array underflow in completion hand=
ler
      tty: fix termios input-speed encoding when using BOTHER
      tty: fix termios input-speed encoding

John Keeping (1):
      dmaengine: pl330: fix irq race with terminate_all

John Stultz (1):
      selftest: timers: Tweak raw_skew to SKIP when ADJ_OFFSET/other clock =
adjustments are in progress

Juergen Gross (1):
      xen/netfront: fix waiting for xenbus state change

Julia Lawall (1):
      parport: sunbpp: fix error return code

Julian Wiedmann (2):
      s390/qeth: fix race in used-buffer accounting
      s390/qeth: reset layer2 attribute on layer switch

K. Y. Srinivasan (1):
      Tools: hv: Fix a bug in the key delete code

Karol Herbst (1):
      drm/nouveau/debugfs: Wake up GPU before doing any reclocking

Krzysztof Ha?asa (1):
      media: tw686x: Fix oops on buffer alloc failure

Krzysztof Kozlowski (1):
      ARM: exynos: Clear global variable on init error path

Laurentiu Tudor (1):
      mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips

Leonard Crestez (1):
      reset: imx7: Fix always writing bits as 0

Loic Poulain (1):
      arm64: dts: qcom: db410c: Fix Bluetooth LED trigger

Lyude Paul (1):
      drm/nouveau: Fix runtime PM leak in drm_open()

Maciej W. Rozycki (1):
      binfmt_elf: Respect error return from `regset->active'

Manikanta Pubbisetty (1):
      mac80211: restrict delayed tailroom needed decrement

Mark Rutland (2):
      KVM: arm/arm64: vgic: Fix possible spectre-v1 write in vgic_mmio_writ=
e_apr()
      arm64: fix possible spectre-v1 write in ptrace_hbp_set_event()

Masahiro Yamada (1):
      kbuild: add .DELETE_ON_ERROR special target

Mathias Nyman (3):
      xhci: Fix use after free for URB cancellation on a reallocated endpoi=
nt
      usb: Don't die twice if PCI xhci host is not responding in resume
      usb: Avoid use-after-free by flushing endpoints early in usb_set_inte=
rface()

Matthew Garrett (1):
      evm: Don't deadlock if a crypto algorithm is unavailable

Max Filippov (1):
      xtensa: ISS: don't allocate memory in platform_setup

Maxence Dupr=E8s (1):
      USB: add quirk for WORLDE Controller KS49 or Prodipe MIDI 49C USB con=
troller

Miao Zhong (1):
      iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer register

Michael M=FCller (1):
      crypto: sharah - Unregister correct algorithms for SAHARA 3

Michal Simek (2):
      earlycon: Initialize port->uartclk based on clock-frequency property
      earlycon: Remove hardcoded port->uartclk initialization in of_setup_e=
arlycon

Mike Christie (1):
      configfs: fix registered group removal

Mike Snitzer (1):
      block: allow max_discard_segments to be stacked

Mikko Perttunen (2):
      clk: core: Potentially free connection id
      clk: tegra: bpmp: Don't crash when a clock fails to register

Miklos Szeredi (1):
      vfs: fix freeze protection in mnt_want_write_file() for overlayfs

Ming Lei (2):
      blk-mq: only attempt to merge bio if there is rq in sw queue
      blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()

Nicholas Mc Guire (7):
      clk: imx6ul: fix missing of_node_put()
      staging: bcm2835-camera: fix timeout handling in wait_for_completion_=
timeout
      staging: bcm2835-camera: handle wait_for_completion_timeout return pr=
operly
      KVM: PPC: Book3S HV: Add of_node_put() in success path
      ARM: hisi: handle of_iomap and fix missing of_node_put
      ARM: hisi: fix error handling and missing of_node_put
      ARM: hisi: check of_iomap and fix missing of_node_put

Nicholas Piggin (1):
      powerpc/powernv: opal_put_chars partial write fix

Noa Osherovich (1):
      net/mlx5: Add missing SET_DRIVER_VERSION command translation

Oder Chiou (1):
      ASoC: rt5514: Fix the issue of the delay volume applied

Oliver Neukum (2):
      usb: uas: add support for more quirk flags
      Revert "cdc-acm: implement put_char() and flush_chars()"

Parav Pandit (1):
      RDMA/cma: Protect cma dev list with lock

Paul Burton (1):
      MIPS: loongson64: cs5536: Fix PCI_OHCI_INT_REG reads

Paul Cercueil (1):
      MIPS: jz4740: Bump zload address

Peter Rosin (2):
      mfd: 88pm860x-i2c: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
      input: rohm_bu21023: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Petr Oros (1):
      be2net: Fix memory leak in be_cmd_get_profile_config()

Philipp Puschmann (1):
      Bluetooth: Use lock_sock_nested in bt_accept_enqueue

Pingfan Liu (1):
      drivers/base: stop new probing during shutdown

Piotr Sawicki (1):
      Smack: Fix handling of IPv4 traffic received by PF_INET6 sockets

Quentin Perret (1):
      sched/fair: Fix util_avg of new tasks for asymmetric systems

Raed Salem (1):
      net/mlx5: E-Switch, Fix memory leak when creating switchdev mode FDB =
tables

Rajan Vaja (1):
      clk: clk-fixed-factor: Clear OF_POPULATED flag in case of failure

Randy Dunlap (3):
      mtd/maps: fix solutionengine.c printk format warnings
      fbdev/via: fix defined but not used warning
      platform/x86: toshiba_acpi: Fix defined but not used build warnings

Rick Farrington (1):
      liquidio: fix hang when re-binding VF host drv after running DPDK VF =
driver

Robin Murphy (1):
      coresight: tpiu: Fix disabling timeouts

Ronny Chevalier (1):
      audit: fix use-after-free in audit_add_watch

Sagi Grimberg (1):
      nvme-rdma: unquiesce queues when deleting the controller

Sandipan Das (2):
      perf powerpc: Fix callchain ip filtering when return address is in a =
register
      perf powerpc: Fix callchain ip filtering

Stefan Agner (2):
      mmc: tegra: prevent HS200 on Tegra 3
      mmc: sdhci: do not try to use 3.3V signaling if not supported

Stefan Wahren (1):
      net: qca_spi: Fix race condition in spi transfers

Suzuki K Poulose (2):
      coresight: Handle errors in finding input/output ports
      coresight: ETM: Add support for Arm Cortex-A73 and Cortex-A35

Takashi Iwai (3):
      hv/netvsc: Fix NULL dereference at single queue mode fallback
      ALSA: msnd: Fix the default sample sizes
      ALSA: usb-audio: Fix multiple definitions in AU0828_DEVICE() macro

Thierry Reding (1):
      drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping

Thomas Richter (1):
      perf test: Fix subtest number when showing results

Tim Anderson (1):
      USB: Add quirk to support DJI CineSSD

Timo Wischer (1):
      ALSA: pcm: Fix snd_interval_refine first/last with open min/max

Todor Tomov (1):
      media: ov5645: Supported external clock is 24MHz

Tomas Winkler (1):
      mei: bus: need to unlink client before freeing

Tony Lindgren (1):
      pinctrl: rza1: Fix selector use for groups and functions

Trond Myklebust (1):
      NFSv4.1 fix infinite loop on I/O.

Tuomas Tynkkynen (1):
      staging: bcm2835-audio: Don't leak workqueue if open fails

Vakul Garg (1):
      net/tls: Set count of SG entries if sk_alloc_sg returns -ENOSPC

Vincent Whitchurch (1):
      tcp: really ignore MSG_ZEROCOPY if no SO_ZEROCOPY

Viresh Kumar (1):
      arm64: dts: uniphier: Add missing cooling device properties for CPUs

Vitaly Kuznetsov (1):
      xen-netfront: fix queue name setting

Wei Lu (1):
      drm/amdkfd: Fix error codes in kfd_get_process

Wei Yongjun (2):
      IB/ipoib: Fix error return code in ipoib_dev_init()
      gpio: pxa: Fix potential NULL dereference

Xiao Liang (1):
      xen-netfront: fix warn message as irq device name has '/'

Yabin Cui (1):
      perf/core: Force USER_DS when recording user stack data

Yoshihiro Shimoda (1):
      usb: gadget: udc: renesas_usb3: fix maxpacket size of ep0

YueHaibing (3):
      xfrm: fix 'passing zero to ERR_PTR()' warning
      amd-xgbe: use dma_mapping_error to check map errors
      wan/fsl_ucc_hdlc: use IS_ERR_VALUE() to check return value of qe_mura=
m_alloc

Zhouyang Jia (1):
      rtc: bq4802: add error handling for devm_ioremap

Zhu Yanjun (1):
      IB/rxe: Drop QP0 silently


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlurSrAACgkQONu9yGCS
aT4bdg//Uy7LuKhK1K7+iJ/9E3LQ8BSleaUxPzaTBnWAJ7aT+e1mtEl694J3yRrz
kikmM3R4GmrKgdwKhEBBq80yiq5JOQ/PHm9tmbEYo5tw9WWgRMlAWnChqeaUVLVZ
Fvr0hCGDDM6fJSOKR7eUbUlfIkuIFnCSJQKabKTCb04oEfpAvbZjiy0CtDjH23Zl
ZIryu7gj10W3FW4OyQaAWGD3wxfGAto+9NUl4Dee6jMpsmq50z/xFbAc7uRDnmf2
oQm9wxK3XPThJUYHqxjtYTCJ3rk5Sb7HvmO1CN0BVw5XXr+dElCMSYG9bkIJevkp
dCAY6kosauAG3DkO338stGOEAhZUCk4cUqXc4vQqiEqhfGJjvEijeUK4/pDLab5S
f2ZoAq0qN9AKVnOlk1i8pWZq31eAheAdF/4hMbEvbf90dhuXRHHcqRtd1yNEnD55
7v/UqjLgwctewhRXMxush7FBxluGu6RDCK5B9HsNhDxxFYnC+B9OEOtOw8JfpxKd
iEMqzyLJ3wzys0HGeoDswclE1j8TuLhQ/8ixFnxxuyS5ECcwv/bpWUxzY1SoNKpX
5m6xj7fkrJhdGWWbMlad3c0rnfS4kf760kDTq4wX4FjW6lxA4R5kxRXiPZgZANKe
Ql9tP51/YF9048HkxkB+dJTwA+0tSuL4EE9FP7pSAn8nX8QOdDs=
=vr3Q
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
