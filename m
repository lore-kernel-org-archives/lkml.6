Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E220421B68
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550002331;
	bh=k8ytCRVA2dLvzpBbw6qU0tndQuT7TwXOCPu8Y0H+Izk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xkUxRFMGPokKfya5BNVSf+Dve/SxOOHrdlgLv/MxjoMvNa928pEXXCeJEOD4zbXkD
	 1tpulehNK+q0rlpXe9wPp9BIDN6dg8l99tJVgzajwLG8XqJMmOejKGxrDMGfHc/7YZ
	 8pgCHy2ffW+/5Vno4rfleyLSAyEBewr65d8P3uL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfBLUMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:12:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728251AbfBLUMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:12:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF53621B68;
        Tue, 12 Feb 2019 20:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550002326;
        bh=k8ytCRVA2dLvzpBbw6qU0tndQuT7TwXOCPu8Y0H+Izk=;
        h=Date:From:To:Cc:Subject:From;
        b=z3YnLmc9NXq/g3ay1dath/tiXL5gRo1bJzs2a6tGEon8CY+MknKE8PKDjvY1N/E3Y
         E6iJyBRLQ6WLqZH6+UQP2mAO8Ylg7z7W+7EB99EgR0Ag4RDu/WiEJcrEARdqTsLHE1
         65bE6EwStGGYadK7Nz3ThU8S0w+S2L9txpZ0XE1E=
Date:   Tue, 12 Feb 2019 21:12:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.156
Message-ID: <20190212201203.GA10316@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.156 kernel.

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

 Makefile                                              |    2=20
 arch/arm/boot/dts/mmp2.dtsi                           |    9 +
 arch/arm/boot/dts/omap4-sdp.dts                       |    1=20
 arch/arm/kernel/smp.c                                 |   15 ++
 arch/arm/kvm/mmio.c                                   |   11 +-
 arch/arm/mach-omap2/omap_hwmod.c                      |    6 -
 arch/arm/mach-pxa/cm-x300.c                           |    2=20
 arch/arm/mach-pxa/littleton.c                         |    2=20
 arch/arm/mach-pxa/zeus.c                              |    2=20
 arch/arm64/kernel/entry-ftrace.S                      |    1=20
 arch/mips/include/uapi/asm/inst.h                     |    2=20
 arch/mips/ralink/Kconfig                              |    1=20
 arch/powerpc/include/asm/uaccess.h                    |    2=20
 arch/powerpc/platforms/pseries/dlpar.c                |    2=20
 arch/um/include/asm/pgtable.h                         |    9 +
 arch/x86/events/intel/core.c                          |   10 +
 arch/x86/events/intel/uncore_snbep.c                  |    4=20
 arch/x86/include/asm/fpu/internal.h                   |    3=20
 arch/x86/kernel/cpu/mcheck/mce.c                      |    1=20
 arch/x86/kvm/svm.c                                    |    7 +
 arch/x86/kvm/vmx.c                                    |    1=20
 arch/x86/kvm/x86.c                                    |    7 +
 arch/x86/pci/broadcom_bus.c                           |    4=20
 drivers/ata/sata_rcar.c                               |    4=20
 drivers/block/drbd/drbd_nl.c                          |   15 +-
 drivers/block/drbd/drbd_receiver.c                    |   13 +-
 drivers/block/sunvdc.c                                |    5=20
 drivers/block/swim3.c                                 |    6 -
 drivers/cdrom/gdrom.c                                 |    1=20
 drivers/clk/imx/clk-imx6sl.c                          |    6 +
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c                  |    6 -
 drivers/cpuidle/cpuidle-big_little.c                  |    7 +
 drivers/crypto/ux500/cryp/cryp_core.c                 |    4=20
 drivers/crypto/ux500/hash/hash_core.c                 |    2=20
 drivers/dma/bcm2835-dma.c                             |   70 ++++--------
 drivers/dma/imx-dma.c                                 |    8 -
 drivers/dma/xilinx/zynqmp_dma.c                       |    2=20
 drivers/firmware/efi/vars.c                           |   99 +++++++++++++=
+----
 drivers/gpu/drm/drm_bufs.c                            |    3=20
 drivers/gpu/drm/vc4/vc4_plane.c                       |   12 +-
 drivers/gpu/ipu-v3/ipu-image-convert.c                |   10 +
 drivers/hid/hid-lenovo.c                              |   10 +
 drivers/hwmon/lm80.c                                  |   26 +++-
 drivers/i2c/busses/i2c-axxia.c                        |   32 ++---
 drivers/iio/accel/kxcjk-1013.c                        |    1=20
 drivers/infiniband/hw/hfi1/ruc.c                      |    7 +
 drivers/infiniband/hw/qib/qib_ruc.c                   |    7 +
 drivers/iommu/amd_iommu.c                             |    9 +
 drivers/iommu/arm-smmu-v3.c                           |    8 +
 drivers/iommu/arm-smmu.c                              |    3=20
 drivers/isdn/hisax/hfc_pci.c                          |    2=20
 drivers/media/i2c/ad9389b.c                           |    2=20
 drivers/media/i2c/adv7511.c                           |    2=20
 drivers/media/i2c/adv7604.c                           |    4=20
 drivers/media/i2c/adv7842.c                           |    4=20
 drivers/media/i2c/tc358743.c                          |    2=20
 drivers/media/i2c/ths8200.c                           |    2=20
 drivers/media/platform/davinci/vpbe.c                 |    7 -
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c |   10 +
 drivers/memstick/core/memstick.c                      |    3=20
 drivers/net/ethernet/broadcom/bcmsysport.c            |   25 +---
 drivers/net/ethernet/broadcom/bcmsysport.h            |    2=20
 drivers/net/ethernet/cisco/enic/enic_main.c           |    2=20
 drivers/net/ethernet/freescale/fman/fman_memac.c      |    2=20
 drivers/net/ethernet/freescale/fman/fman_tgec.c       |    2=20
 drivers/net/ethernet/intel/i40e/i40e_main.c           |    3=20
 drivers/net/ethernet/intel/igb/igb_main.c             |    8 -
 drivers/net/ethernet/marvell/skge.c                   |    6 -
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c       |   14 ++
 drivers/net/ethernet/sun/niu.c                        |   10 +
 drivers/net/phy/dp83640.c                             |   13 +-
 drivers/net/wireless/ath/ath9k/ath9k.h                |    2=20
 drivers/net/wireless/ath/ath9k/dynack.c               |   35 ++++--
 drivers/net/wireless/ath/ath9k/dynack.h               |    6 -
 drivers/net/wireless/ath/ath9k/xmit.c                 |    5=20
 drivers/net/wireless/st/cw1200/scan.c                 |   13 +-
 drivers/pci/host/vmd.c                                |   15 ++
 drivers/pinctrl/meson/pinctrl-meson8.c                |    3=20
 drivers/pinctrl/meson/pinctrl-meson8b.c               |   13 +-
 drivers/ptp/ptp_chardev.c                             |    5=20
 drivers/scsi/aic94xx/aic94xx_init.c                   |    8 -
 drivers/scsi/lpfc/lpfc_els.c                          |    3=20
 drivers/scsi/smartpqi/smartpqi_init.c                 |    6 +
 drivers/soc/bcm/brcmstb/common.c                      |    6 -
 drivers/soc/tegra/common.c                            |    6 -
 drivers/staging/iio/adc/ad7280a.c                     |   17 ++-
 drivers/staging/iio/adc/ad7780.c                      |    6 -
 drivers/staging/iio/resolver/ad2s90.c                 |    7 +
 drivers/thermal/thermal-generic-adc.c                 |   12 +-
 drivers/thermal/thermal_core.c                        |   12 +-
 drivers/thermal/thermal_hwmon.h                       |    4=20
 drivers/tty/serial/fsl_lpuart.c                       |    4=20
 drivers/tty/serial/samsung.c                          |    3=20
 drivers/tty/serial/serial_core.c                      |    6 +
 drivers/usb/core/hub.c                                |   10 +
 drivers/usb/gadget/udc/net2272.c                      |    2=20
 drivers/usb/musb/musb_gadget.c                        |   13 --
 drivers/usb/musb/musbhsdma.c                          |   21 ++-
 drivers/usb/phy/phy-am335x.c                          |    5=20
 drivers/video/console/fbcon.c                         |    2=20
 drivers/video/fbdev/clps711x-fb.c                     |    5=20
 drivers/video/fbdev/core/fbmem.c                      |    8 +
 fs/binfmt_script.c                                    |   10 +
 fs/cifs/readdir.c                                     |    9 +
 fs/dlm/ast.c                                          |   10 +
 fs/eventpoll.c                                        |    2=20
 fs/f2fs/acl.c                                         |   14 +-
 fs/f2fs/f2fs.h                                        |   11 +-
 fs/f2fs/file.c                                        |    3=20
 fs/f2fs/shrinker.c                                    |    2=20
 fs/fuse/dev.c                                         |    4=20
 fs/fuse/file.c                                        |    2=20
 fs/nfs/super.c                                        |    3=20
 fs/nfsd/nfsctl.c                                      |    2=20
 fs/ocfs2/buffer_head_io.c                             |    2=20
 fs/udf/inode.c                                        |    6 +
 include/linux/genl_magic_struct.h                     |    5=20
 include/linux/sched.h                                 |    1=20
 include/sound/compress_driver.h                       |    6 -
 kernel/events/ring_buffer.c                           |    3=20
 kernel/hung_task.c                                    |    8 -
 kernel/sysctl.c                                       |    2=20
 kernel/time/timekeeping.c                             |    4=20
 lib/seq_buf.c                                         |    6 -
 mm/oom_kill.c                                         |    4=20
 net/bluetooth/hci_event.c                             |    6 +
 net/dccp/ccid.h                                       |    4=20
 net/dsa/slave.c                                       |   12 +-
 net/ipv6/xfrm6_tunnel.c                               |    3=20
 net/mac80211/rx.c                                     |    5=20
 net/rds/bind.c                                        |    6 -
 net/rxrpc/recvmsg.c                                   |    3=20
 scripts/decode_stacktrace.sh                          |    2=20
 scripts/mod/modpost.c                                 |   50 ++++-----
 security/smack/smack_lsm.c                            |   12 +-
 sound/pci/hda/hda_bind.c                              |    3=20
 sound/pci/hda/hda_codec.h                             |    1=20
 sound/pci/hda/hda_intel.c                             |    2=20
 sound/soc/fsl/Kconfig                                 |    2=20
 sound/soc/intel/atom/sst/sst_loader.c                 |    8 -
 tools/perf/arch/x86/util/kvm-stat.c                   |    2=20
 tools/perf/tests/evsel-tp-sched.c                     |    2=20
 tools/perf/util/header.c                              |    2=20
 tools/perf/util/probe-file.c                          |    2=20
 virt/kvm/kvm_main.c                                   |    3=20
 145 files changed, 760 insertions(+), 357 deletions(-)

Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      i2c-axxia: check for error conditions first

Aditya Pakki (1):
      HID: lenovo: Add checks to fix of_led_classdev_register

Alexey Khoroshilov (3):
      media: mtk-vcodec: Release device nodes in mtk_vcodec_init_enc_pm()
      media: DaVinci-VPBE: fix error handling in vpbe_initialize()
      video: clps711x-fb: release disp device node in probe()

Andy Duan (1):
      serial: fsl_lpuart: clear parity enable bit when disable parity

Anson Huang (1):
      clk: imx6sl: ensure MMDC CH0 handshake is bypassed

Anton Ivanov (1):
      um: Avoid marking pages with "changed protection"

Arend van Spriel (1):
      firmware/efi: Add NULL pointer checks in efivars API functions

Arnaldo Carvalho de Melo (2):
      perf header: Fix unchecked usage of strncpy()
      perf probe: Fix unchecked usage of strncpy()

Arnd Bergmann (2):
      ASoC: Intel: mrfld: fix uninitialized variable access
      ARM: pxa: avoid section mismatch warning

Bart Van Assche (1):
      timekeeping: Use proper seqcount initializer

Beomho Seo (1):
      tty: serial: samsung: Properly set flags in autoCTS mode

Bin Liu (1):
      usb: phy: am335x: fix race condition in _probe

Bjorn Andersson (1):
      thermal: generic-adc: Fix adc to temp interpolation

Bob Peterson (1):
      dlm: Don't swamp the CPU with callbacks queued during recovery

Boris Brezillon (1):
      drm/vc4: ->x_scaling[1] should never be set to VC4_SCALING_NONE

Charles Keepax (1):
      ALSA: compress: Fix stop handling on compressed capture streams

Chen-Yu Tsai (1):
      clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for all audio module cloc=
ks

Cheng Lin (1):
      proc/sysctl: fix return error for proc_doulongvec_minmax()

Chris Perl (1):
      NFS: nfs_compare_mount_options always compare auth flavors.

Christophe Leroy (1):
      powerpc/uaccess: fix warning/error with access_ok()

Colin Ian King (1):
      x86/PCI: Fix Broadcom CNB20LE unintended sign extension (redux)

Cong Wang (1):
      net/mlx5e: Force CHECKSUM_UNNECESSARY for short ethernet frames

Dan Carpenter (1):
      skge: potential memory corruption in skge_get_regs()

Dave Carroll (1):
      scsi: smartpqi: correct volume status

Davidlohr Bueso (1):
      fs/epoll: drop ovflist branch prediction

Eduardo Valentin (1):
      thermal: hwmon: inline helpers when CONFIG_THERMAL_HWMON is not set

Eric Dumazet (3):
      dccp: fool proof ccid_hc_[rt]x_parse_options()
      rxrpc: bad unlock balance in rxrpc_recvmsg
      rds: fix refcount bug in rds_sock_addref

Fabio Estevam (1):
      ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M

Finn Thain (1):
      block/swim3: Fix -EBUSY error when re-opening device after unmount

Florian Fainelli (1):
      net: systemport: Fix WoL with password after deep sleep

Frank Rowand (1):
      powerpc/pseries: add of_node_put() in dlpar_detach_node()

Govindarajulu Varadarajan (1):
      enic: fix checksum validation for IPv6

Greg Kroah-Hartman (2):
      serial: fix race between flush_to_ldisc and tty_open
      Linux 4.9.156

Gustavo A. R. Silva (3):
      drm/bufs: Fix Spectre v1 vulnerability
      usb: gadget: udc: net2272: Fix bitwise and boolean operations
      perf tests evsel-tp-sched: Fix bitwise operator

Hans Verkuil (1):
      media: adv*/tc358743/ths8200: fill in min width/height/pixelclock

Hans de Goede (1):
      iio: accel: kxcjk1013: Add KIOX010A ACPI Hardware-ID

J. Bruce Fields (1):
      nfsd4: fix crash on writing v4_end_grace before nfsd startup

James Bottomley (1):
      scsi: aic94xx: fix module loading

James Smart (1):
      scsi: lpfc: Correct LCB RJT handling

Jan Kara (1):
      udf: Fix BUG on corrupted inode

Jann Horn (2):
      fuse: call pipe_buf_release() under pipe lock
      kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)

Jia-Ju Bai (2):
      cw1200: Fix concurrency use-after-free bugs in cw1200_hw_scan()
      isdn: hisax: hfc_pci: Fix a possible concurrency use-after-free bug i=
n HFCPCI_l1hw()

Jiong Wang (1):
      mips: bpf: fix encoding bug for mm_srlv32_op

Johan Hedberg (1):
      Bluetooth: Fix unnecessary error message for HCI request completion

Johannes Berg (1):
      mac80211: fix radiotap vendor presence bitmap handling

Junxiao Bi (1):
      ocfs2: don't clear bh uptodate for block read

Kai-Heng Feng (2):
      memstick: Prevent memstick host from getting runtime suspended during=
 card detection
      igb: Fix an issue that PME is not enabled during runtime suspend

Kan Liang (1):
      perf/x86/intel/uncore: Add Node ID mask

Kangjie Lu (3):
      hwmon: (lm80) fix a missing check of the status of SMBus read
      hwmon: (lm80) fix a missing check of bus read in lm80 probe
      niu: fix missing checks of niu_pci_eeprom_read

Konstantin Khorenko (1):
      i40e: define proper net_device::neigh_priv_len

Lars Ellenberg (2):
      drbd: disconnect, if the wrong UUIDs are attached on a connected peer
      drbd: skip spurious timeout (ping-timeo) when failing promote

Leonid Iziumtsev (1):
      dmaengine: imx-dma: fix wrong callback invoke

Lorenzo Bianconi (3):
      ath9k: dynack: use authentication messages for 'late' ack
      ath9k: dynack: make ewma estimation faster
      ath9k: dynack: check da->enabled first in sampling routines

Lubomir Rintel (1):
      ARM: dts: mmp2: fix TWSI2

Lukas Wunner (2):
      dmaengine: bcm2835: Fix interrupt race on RT
      dmaengine: bcm2835: Fix abort of transactions

Mahesh Rajashekhara (1):
      scsi: smartpqi: correct host serial num for ssa

Marc Zyngier (1):
      scripts/decode_stacktrace: only strip base path when a prefix of the =
path

Mark Rutland (3):
      arm64: ftrace: don't adjust the LR value
      arm64: KVM: Skip MMIO insn after emulation
      perf/core: Don't WARN() for impossible ring-buffer sizes

Martin Blumenstingl (2):
      pinctrl: meson: meson8: fix the GPIO function for the GPIOAO pins
      pinctrl: meson: meson8b: fix the GPIO function for the GPIOAO pins

Matheus Tavares (1):
      staging:iio:ad2s90: Make probe handle spi_setup failure

Mathias Nyman (1):
      usb: hub: delay hub autosuspend if USB3 port is still link training

Michael Ellerman (1):
      seq_buf: Make seq_buf_puts() null-terminate the buffer

Mike Marciniszyn (1):
      IB/hfi1: Add limit test for RC/UC send via loopback

Miklos Szeredi (2):
      fuse: decrement NR_WRITEBACK_TEMP on the right page
      fuse: handle zero sized retrieve correctly

Miroslav Lichvar (1):
      ptp: check gettime64 return code in PTP_SYS_OFFSET ioctl

Nathan Chancellor (5):
      ARM: OMAP2+: hwmod: Fix some section annotations
      dmaengine: xilinx_dma: Remove __aligned attribute on zynqmp_dma_desc_=
ll
      drbd: Avoid Clang warning about pointless switch statment
      crypto: ux500 - Use proper enum in cryp_set_dma_transfer
      crypto: ux500 - Use proper enum in hash_set_dma_transfer

Noralf Tr=F8nnes (1):
      fbdev: fbcon: Fix unregister crash when more than one framebuffer

Oleg Nesterov (1):
      exec: load_script: don't blindly truncate shebang string

Paolo Bonzini (1):
      KVM: x86: work around leak of uninitialized stack contents (CVE-2019-=
7222)

Paul Elder (1):
      usb: gadget: musb: fix short isoc packets with inventra dma

Peter Rosin (1):
      fbdev: fbmem: behave better with small rotated displays and many CPUs

Peter Shier (1):
      KVM: nVMX: unconditionally cancel preemption timer in free_nested (CV=
E-2019-7221)

Peter Zijlstra (1):
      perf/x86/intel: Delay memory deallocation until x86_pmu_dead_cpu()

Pu Wen (1):
      perf tools: Add Hygon Dhyana support

Renato Lui Geh (1):
      staging: iio: ad7780: update voltage on read

Roland Kammerer (1):
      drbd: narrow rcu_read_lock in drbd_sync_handshake

Ronnie Sahlberg (1):
      cifs: check ntwrk_buf_start for NULL before dereferencing it

Rundong Ge (1):
      net: dsa: slave: Don't propagate flag changes on down slave interfaces

Russell King - ARM Linux (1):
      ARM: dts: Fix OMAP4430 SDP Ethernet startup

Sahitya Tummala (1):
      f2fs: fix sbi->extent_list corruption issue

Sami Tolvanen (1):
      modpost: validate symbol names also in find_elf_symbol

Scott Bauer (1):
      PCI: vmd: Free up IRQs on suspend path

Scott Wood (1):
      fsl/fman: Use GFP_ATOMIC in {memac,tgec}_add_hash_mac_address()

Sebastian Andrzej Siewior (2):
      x86/fpu: Add might_fault() to user_insn()
      net: dp83640: expire old TX-skb

Sergei Shtylyov (1):
      sata_rcar: fix deferred probing

Slawomir Stepien (1):
      staging: iio: adc: ad7280a: handle error from __ad7280_read32()

Stefan Roese (1):
      MIPS: ralink: Select CONFIG_CPU_MIPSR2_IRQ_VI on MT7620/8

Steve Longerbeam (1):
      gpu: ipu-v3: image-convert: Prevent race between run and unprepare

Takashi Iwai (1):
      ALSA: hda - Serialize codec registrations

Tetsuo Handa (2):
      kernel/hung_task.c: break RCU locks based on jiffies
      oom, oom_reaper: do not enqueue same task twice

Tiezhu Yang (1):
      f2fs: fix wrong return value of f2fs_acl_create

Tony Luck (1):
      x86/MCE: Initialize mce.bank in the case of a fatal error in mce_no_w=
ay_out()

Vitaly Kuznetsov (1):
      KVM: x86: svm: report MSR_IA32_MCG_EXT_CTL as unsupported

Vivek Gautam (1):
      iommu/arm-smmu: Add support for qcom,smmu-v2 variant

Wei Wang (1):
      Thermal: do not clear passive state during system sleep

Wenwen Wang (1):
      gdrom: fix a memory leak bug

Will Deacon (1):
      iommu/arm-smmu-v3: Use explicit mb() when moving cons pointer

Yangtao Li (3):
      soc/tegra: Don't leak device tree node reference
      soc: bcm: brcmstb: Don't leak device tree node reference
      cpuidle: big.LITTLE: fix refcount leak

Young Xiao (1):
      sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns E=
AGAIN

Yu Zhao (1):
      iommu/amd: Fix amd_iommu=3Dforce_isolation

YueHaibing (1):
      xfrm6_tunnel: Fix spi check in __xfrm6_tunnel_alloc_spi

Yufen Wang (1):
      ARM: 8808/1: kexec:offline panic_smp_self_stop CPU

Yunlei He (1):
      f2fs: move dir data flush to write checkpoint process

Zoran Markovic (1):
      smack: fix access permissions for keyring


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxjKJEACgkQONu9yGCS
aT7xURAAkgIrc/m9H5q/K8EWURLsFeklAaufegCxUmjXdVUwt5moDLSYNSheyvVs
QZa5AOF0IFXCXwZCRNyP1PLC7906talcvewkjlmrbyO5Khn5ABeGwpxv53RgkyIf
smCJpYaBfPWjWJRLkg7+h5+EUU4pM6Mft088ERSA8tpplj5KQJ22QK2TIIW5Oh1L
6SXsGoK2ivv4GjRqefyzJWyifSKoErNgmQUrCFtXV7JjPeK3gMq//ckO9L936yNV
4crBGwj3wYa2nv3tYXf9Sv0NypQMTIJsGMRgaP+EJIcHHpFpWUxkyj21jE5DBxG6
qgb2TNqgQlNz2Ec+pAO9VqWZ3Kn7lvqsRBQNh0gMvt1SQ3Erq9zAa/S8XvOr7hWy
Szsvhthh0po6TcgazPlo/CguKwxWUOhrj1M6R/pmYxC6WHyq3fMCU6Tg7CgcO8ap
TsWVq9Nm/wcnRpLdp3iuPcgLCFdCIv9W8eN1/KyotfQiqrT+Ahp4BQNPxKKejuh8
RhQGM6cGvgUt4kAi/C0ad5+h/WDqdFJN5jV4F3ZHTwfJxysTfS0CZI0vahMSs2mD
b/1VLHTijc/XapiYuKOba70wQmuSpMMPSlsPF7816I3eC4+FxzmXwYzcwgQwGniX
tvadLnGm2UixGJ/wADcLrp8Ri4nsgBw37eB+qReQ9JvixUZyhTw=
=Qrfv
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
