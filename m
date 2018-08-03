Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60613C46463
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BBC216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BBC216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbeHCIYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:24:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47132 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeHCIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:24:16 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4EA5B3EE;
        Fri,  3 Aug 2018 06:29:28 +0000 (UTC)
Date:   Fri, 3 Aug 2018 08:29:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.117
Message-ID: <20180803062925.GA13049@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.117 kernel.

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

 Documentation/devicetree/bindings/net/dsa/qca8k.txt         |   23 +++++
 Documentation/devicetree/bindings/net/meson-dwmac.txt       |    1=20
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt |    2=20
 Makefile                                                    |    2=20
 arch/arm/boot/dts/emev2.dtsi                                |    5 -
 arch/arm/boot/dts/sh73a0.dtsi                               |    5 -
 arch/arm64/configs/defconfig                                |    2=20
 arch/arm64/include/asm/cmpxchg.h                            |    4=20
 arch/arm64/mm/init.c                                        |    4=20
 arch/microblaze/boot/Makefile                               |   10 +-
 arch/powerpc/kernel/eeh_driver.c                            |   28 +++---
 arch/powerpc/kernel/head_8xx.S                              |    2=20
 arch/powerpc/kernel/pci_32.c                                |    1=20
 arch/powerpc/mm/slb.c                                       |    8 -
 arch/powerpc/net/bpf_jit_comp64.c                           |   34 +++++--
 arch/powerpc/platforms/chrp/time.c                          |    6 -
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c               |    5 +
 arch/powerpc/platforms/powermac/bootx_init.c                |    4=20
 arch/powerpc/platforms/powermac/setup.c                     |    1=20
 arch/s390/include/asm/cpu_mf.h                              |    6 -
 arch/x86/events/intel/uncore.c                              |    2=20
 arch/x86/events/intel/uncore_nhmex.c                        |    2=20
 arch/x86/kvm/mmu.c                                          |    2=20
 crypto/authenc.c                                            |    1=20
 crypto/authencesn.c                                         |    1=20
 drivers/acpi/pci_root.c                                     |    4=20
 drivers/ata/libata-eh.c                                     |   12 +-
 drivers/bluetooth/btusb.c                                   |    3=20
 drivers/bluetooth/hci_qca.c                                 |    2=20
 drivers/bus/arm-ccn.c                                       |   20 ++--
 drivers/char/random.c                                       |   10 ++
 drivers/edac/altera_edac.c                                  |    2=20
 drivers/gpu/drm/drm_atomic.c                                |    4=20
 drivers/gpu/drm/gma500/psb_intel_drv.h                      |    2=20
 drivers/gpu/drm/gma500/psb_intel_lvds.c                     |    2=20
 drivers/gpu/drm/radeon/radeon_connectors.c                  |   10 +-
 drivers/hid/hid-plantronics.c                               |    6 +
 drivers/hid/i2c-hid/i2c-hid.c                               |    8 +
 drivers/infiniband/core/mad.c                               |   11 +-
 drivers/infiniband/core/ucma.c                              |    6 +
 drivers/infiniband/core/uverbs_cmd.c                        |    5 +
 drivers/input/mouse/elan_i2c_core.c                         |    2=20
 drivers/input/serio/i8042-x86ia64io.h                       |    7 +
 drivers/md/md.c                                             |    3=20
 drivers/media/common/siano/smsendian.c                      |   14 +--
 drivers/media/i2c/smiapp/smiapp-core.c                      |   11 +-
 drivers/media/media-device.c                                |   21 ++--
 drivers/media/pci/saa7164/saa7164-fw.c                      |    3=20
 drivers/media/pci/tw686x/tw686x-video.c                     |    3=20
 drivers/media/platform/omap3isp/isp.c                       |    7 -
 drivers/media/platform/rcar_jpu.c                           |    4=20
 drivers/media/radio/si470x/radio-si470x-i2c.c               |    6 -
 drivers/media/v4l2-core/videobuf2-core.c                    |    9 +-
 drivers/memory/tegra/mc.c                                   |   22 +----
 drivers/memory/tegra/mc.h                                   |    9 ++
 drivers/memory/tegra/tegra114.c                             |    2=20
 drivers/memory/tegra/tegra124.c                             |    6 +
 drivers/memory/tegra/tegra210.c                             |    3=20
 drivers/memory/tegra/tegra30.c                              |    2=20
 drivers/mfd/cros_ec.c                                       |    6 +
 drivers/mmc/core/pwrseq_simple.c                            |   14 ++-
 drivers/mmc/host/dw_mmc.c                                   |    4=20
 drivers/mtd/nand/fsl_ifc_nand.c                             |   17 ++-
 drivers/net/dsa/qca8k.c                                     |   52 +++++++=
++++-
 drivers/net/dsa/qca8k.h                                     |    7 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                   |    3=20
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c           |    1=20
 drivers/net/ethernet/ti/cpsw-phy-sel.c                      |    8 +
 drivers/net/wireless/ath/regd.h                             |    5 +
 drivers/net/wireless/ath/regd_common.h                      |   13 +++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c   |    1=20
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                |    2=20
 drivers/net/wireless/marvell/mwifiex/usb.c                  |    3=20
 drivers/net/wireless/marvell/mwifiex/util.c                 |    8 +
 drivers/net/wireless/rsi/rsi_91x_sdio.c                     |    2=20
 drivers/net/wireless/ti/wlcore/sdio.c                       |    5 +
 drivers/net/xen-netfront.c                                  |    4=20
 drivers/nvmem/core.c                                        |    7 +
 drivers/pci/pci-sysfs.c                                     |   15 ++-
 drivers/pinctrl/pinctrl-at91-pio4.c                         |    4=20
 drivers/regulator/pfuze100-regulator.c                      |    1=20
 drivers/rtc/interface.c                                     |    5 +
 drivers/scsi/3w-9xxx.c                                      |    5 +
 drivers/scsi/3w-xxxx.c                                      |    3=20
 drivers/scsi/megaraid.c                                     |    3=20
 drivers/scsi/megaraid/megaraid_sas_fusion.c                 |    3=20
 drivers/scsi/scsi_dh.c                                      |    5 -
 drivers/scsi/ufs/ufshcd.c                                   |    2=20
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c      |   18 ++--
 drivers/staging/lustre/lustre/ldlm/ldlm_lock.c              |    6 +
 drivers/staging/lustre/lustre/llite/xattr.c                 |    6 +
 drivers/thermal/samsung/exynos_tmu.c                        |    1=20
 drivers/tty/hvc/hvc_opal.c                                  |    1=20
 drivers/tty/pty.c                                           |    3=20
 drivers/usb/core/hub.c                                      |    4=20
 drivers/usb/dwc2/hcd.c                                      |   44 +++++--=
---
 drivers/vfio/platform/vfio_platform_common.c                |   15 ++-
 fs/btrfs/qgroup.c                                           |   19 ++++
 fs/btrfs/tree-log.c                                         |   10 +-
 fs/crypto/crypto.c                                          |   11 ++
 fs/ext4/balloc.c                                            |    3=20
 fs/ext4/ialloc.c                                            |    3=20
 fs/ext4/inline.c                                            |   19 ++--
 fs/ext4/inode.c                                             |   16 +--
 fs/f2fs/file.c                                              |   14 ++-
 fs/f2fs/gc.c                                                |   11 +-
 fs/f2fs/segment.c                                           |    5 +
 fs/f2fs/super.c                                             |    6 +
 fs/nfs/nfs4proc.c                                           |    3=20
 fs/nfsd/nfs4xdr.c                                           |    2=20
 fs/squashfs/cache.c                                         |    3=20
 fs/squashfs/file.c                                          |    8 +
 fs/squashfs/fragment.c                                      |    4=20
 fs/squashfs/squashfs_fs.h                                   |    6 +
 include/drm/drm_dp_helper.h                                 |    1=20
 include/linux/dma-iommu.h                                   |    1=20
 include/linux/mmc/sdio_ids.h                                |    1=20
 include/linux/netfilter/ipset/ip_set_timeout.h              |   10 +-
 include/linux/serial_core.h                                 |    3=20
 include/soc/tegra/mc.h                                      |    2=20
 kernel/auditfilter.c                                        |    2=20
 kernel/auditsc.c                                            |    2=20
 kernel/bpf/verifier.c                                       |    4=20
 kernel/kcov.c                                               |    3=20
 kernel/kthread.c                                            |    8 +
 kernel/stop_machine.c                                       |   24 ++---
 kernel/trace/trace_events_trigger.c                         |   18 +++-
 kernel/trace/trace_kprobe.c                                 |   15 +++
 mm/slub.c                                                   |    2=20
 mm/vmalloc.c                                                |    3=20
 net/ipv4/ipconfig.c                                         |   13 +++
 net/netfilter/nf_tables_api.c                               |   11 +-
 security/integrity/ima/ima_main.c                           |    1=20
 sound/pci/emu10k1/emupcm.c                                  |    4=20
 sound/pci/emu10k1/memory.c                                  |    6 -
 sound/pci/fm801.c                                           |   16 ++-
 sound/pci/hda/patch_ca0132.c                                |    8 +
 sound/soc/soc-pcm.c                                         |    6 -
 sound/usb/pcm.c                                             |    2=20
 tools/perf/util/parse-events.y                              |   14 +++
 tools/testing/selftests/intel_pstate/run.sh                 |   24 ++---
 tools/usb/usbip/src/usbip_detach.c                          |    9 +-
 142 files changed, 766 insertions(+), 298 deletions(-)

Alexandre Belloni (1):
      rtc: ensure rtc_set_alarm fails when alarms are not supported

Alexey Kodanev (1):
      netfilter: nf_tables: check msg_type before nft_trans_set(trans)

Anatoly Pugachev (1):
      disable loading f2fs module on PAGE_SIZE > 4KB

Anson Huang (1):
      regulator: pfuze100: add .is_enable() for pfuze100_swb_regulator_ops

Antti Sepp=C3=A4l=C3=A4 (1):
      usb: dwc2: Fix DMA alignment to start at allocated boundary

Artem Savkov (1):
      tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failu=
re

Bartlomiej Zolnierkiewicz (1):
      thermal: exynos: fix setting rising_threshold for Exynos5433

Brad Love (1):
      media: saa7164: Fix driver name in debug output

Chao Yu (4):
      f2fs: fix error path of move_data_page
      f2fs: fix to don't trigger writeback during recovery
      f2fs: fix to wait page writeback during revoking atomic write
      f2fs: fix race in between GC and atomic open

Chen-Yu Tsai (1):
      Input: i8042 - add Lenovo LaVie Z to the i8042 reset list

Chintan Pandya (1):
      mm: vmalloc: avoid racy handling of debugobjects in vunmap

Chris Novakovic (1):
      ipconfig: Correctly initialise ic_nameservers

Christoph Hellwig (1):
      PCI: Prevent sysfs disable of device while driver is attached

Christophe Leroy (1):
      powerpc/8xx: fix invalid register expression in head_8xx.S

Colin Ian King (1):
      media: smiapp: fix timeout checking in smiapp_read_nvm

Cong Wang (1):
      infiniband: fix a possible use-after-free bug

DaeRyong Jeong (1):
      tty: Fix data race in tty_insert_flip_string_fixed_flag

Damien Le Moal (1):
      libata: Fix command retry decision

Dan Carpenter (1):
      scsi: megaraid: silence a static checker bug

Daniel D=C3=ADaz (1):
      selftests/intel_pstate: Improve test, minor fixes

David Sterba (1):
      btrfs: add barriers to btrfs_sync_log before log_commit_wait wakeups

Dmitry Osipenko (2):
      memory: tegra: Do not handle spurious interrupts
      memory: tegra: Apply interrupts mask per SoC

Dmitry Torokhov (1):
      HID: i2c-hid: check if device is there before really probing

Dominik Bozek (1):
      usb: hub: Don't wait for connect state at resume for powered-off ports

Donald Shanty III (1):
      Input: elan_i2c - add ACPI ID for lenovo ideapad 330

Doug Oucahrek (1):
      staging: lustre: o2iblnd: fix race at kiblnd_connect_peer

Douglas Anderson (1):
      serial: core: Make sure compiler barfs for 16-byte earlycon names

Emil Tantilov (1):
      ixgbevf: fix MAC address changes through ixgbevf_set_mac()

Enric Balletbo i Serra (1):
      arm64: defconfig: Enable Rockchip io-domain driver

Eric Biggers (1):
      fscrypt: use unbound workqueue for decryption

Eyal Reizer (1):
      wlcore: sdio: check for valid platform device data before suspend

Ezequiel Garcia (1):
      media: tw686x: Fix incorrect vb2_mem_ops GFP flags

Ganapathi Bhat (1):
      mwifiex: handle race during mwifiex_usb_disconnect

Geert Uytterhoeven (3):
      vfio: platform: Fix reset module leak in error path
      ARM: dts: emev2: Add missing interrupt-affinity to PMU node
      ARM: dts: sh73a0: Add missing interrupt-affinity to PMU node

Greg Kroah-Hartman (1):
      Linux 4.9.117

Grygorii Strashko (1):
      net: ethernet: ti: cpsw-phy-sel: check bus_find_device() ret value

Hans Verkuil (1):
      media: videobuf2-core: don't call memop 'finish' when queueing

Jakub Kicinski (1):
      bpf: fix references to free_bpf_prog_info() in comments

James Simmons (1):
      staging: lustre: llite: correct removexattr detection

Jane Wan (1):
      mtd: rawnand: fsl_ifc: fix FSL NAND driver to read all ONFI parameter=
 pages

Jian-Hong Pan (1):
      Bluetooth: btusb: Add a new Realtek 8723DE ID 2ff8:b011

Jiri Olsa (1):
      perf tools: Fix pmu events parsing rule

Johannes Weiner (1):
      arm64: fix vmemmap BUILD_BUG_ON() triggering on !vmemmap setups

Jonathan Neusch=C3=A4fer (1):
      powerpc/embedded6xx/hlwd-pic: Prevent interrupts from being handled b=
y Starlet

Jos=C3=A9 Roberto de Souza (1):
      drm: Add DP PSR2 sink enable bit

Jozsef Kadlecsik (1):
      netfilter: ipset: List timing out entries with "timeout 1" instead of=
 zero

Juergen Gross (1):
      xen/netfront: raise max number of slots in xennet_get_responses()

Julia Lawall (1):
      pinctrl: at91-pio4: add missing of_node_put

KT Liao (1):
      Input: elan_i2c - add another ACPI ID for Lenovo Ideapad 330-15AST

Kai Chieh Chuang (1):
      ASoC: dpcm: fix BE dai not hw_free and shutdown

Kan Liang (2):
      perf/x86/intel/uncore: Correct fixed counter index check in generic c=
ode
      perf/x86/intel/uncore: Correct fixed counter index check for NHM

Leon Romanovsky (2):
      RDMA/mad: Convert BUG_ONs to error flows
      RDMA/uverbs: Protect from attempts to create flows on unsupported QP

Linus Torvalds (1):
      squashfs: be more careful about metadata corruption

Luc Van Oostenryck (2):
      drm/radeon: fix mode_valid's return type
      drm/gma500: fix psb_intel_lvds_mode_valid()'s return type

Marc Zyngier (1):
      dma-iommu: Fix compilation when !CONFIG_IOMMU_DMA

Mark Rutland (2):
      kcov: ensure irq code sees a valid area
      drivers/perf: arm-ccn: don't log to dmesg in event_init

Martin Blumenstingl (1):
      dt-bindings: pinctrl: meson: add support for the Meson8m2 SoC

Mathieu Malaterre (6):
      mm/slub.c: add __printf verification to slab_err()
      powerpc/32: Add a missing include header
      powerpc/chrp/time: Make some functions static, add missing header inc=
lude
      powerpc/powermac: Add missing prototype for note_bootable_part()
      powerpc/powermac: Mark variable x as unused
      nvmem: properly handle returned value nvmem_reg_read

Mauro Carvalho Chehab (2):
      media: siano: get rid of __le32/__le16 cast warnings
      media: si470x: fix __be16 annotations

Maya Erez (1):
      scsi: ufs: fix exception event handling

Michael Chan (1):
      bnxt_en: Check unsupported speeds in bnxt_update_link() on PF only.

Michal Simek (1):
      microblaze: Fix simpleImage format generation

Michal Vok=C3=A1=C4=8D (5):
      net: dsa: qca8k: Add support for QCA8334 switch
      net: dsa: qca8k: Force CPU port to its highest bandwidth
      net: dsa: qca8k: Enable RXMAC when bringing up a port
      net: dsa: qca8k: Add QCA8334 binding documentation
      net: dsa: qca8k: Allow overwriting CPU port setting

Mika Westerberg (1):
      PCI: pciehp: Request control of native hotplug only if supported

Mimi Zohar (1):
      ima: based on policy verify firmware signatures (pre-allocated buffer)

NeilBrown (1):
      staging: lustre: ldlm: free resource when ldlm_lock_create() fails.

Nicholas Piggin (1):
      powerpc/64s: Fix compiler store ordering to SLB shadow area

Ondrej Mosn=C3=A1=C4=8Dek (1):
      audit: allow not equal op for audit by executable

Qu Wenruo (1):
      btrfs: qgroup: Finish rescan when hit the last leaf of extent tree

Sahitya Tummala (1):
      f2fs: Fix deadlock in shutdown ioctl

Sam Bobroff (1):
      powerpc/eeh: Fix use-after-release of EEH driver

Sami Tolvanen (1):
      media: media-device: fix ioctl function types

Sandipan Das (1):
      bpf: powerpc64: pad function address loads with NOPs

Satendra Singh Thakur (1):
      drm/atomic: Handling the case when setting old crtc for plane

Scott Mayhew (1):
      nfsd: fix potential use-after-free in nfsd4_decode_getdeviceinfo

Sean Lanigan (1):
      brcmfmac: Add support for bcm43364 wireless chipset

Shakeel Butt (1):
      kvm, mm: account shadow page tables to kmemcg

Shaul Triebitz (1):
      iwlwifi: pcie: fix race in Rx buffer allocator

Shawn Lin (1):
      mmc: dw_mmc: update actual clock for mmc debugfs

Shivasharan S (1):
      scsi: megaraid_sas: Increase timeout by 1 sec for non-RAID fastpath I=
Os

Shuah Khan (Samsung OSG) (1):
      usbip: usbip_detach: Fix memory, udev context and udev leak

Siva Rebbagondla (1):
      rsi: Fix 'invalid vdd' warning in mmc

Snild Dolkow (1):
      kthread, tracing: Don't expose half-written comm when creating kthrea=
ds

Steven Rostedt (VMware) (3):
      tracing: Fix double free of event_trigger_data
      tracing: Fix possible double free in event_enable_trigger_func()
      tracing: Quiet gcc warning about maybe unused link variable

Stewart Smith (1):
      hvc_opal: don't set tb_ticks_per_usec in udbg_init_opal_common()

Suman Anna (1):
      media: omap3isp: fix unbalanced dma_iommu_mapping

Sven Eckelmann (9):
      ath: Add regulatory mapping for FCC3_ETSIC
      ath: Add regulatory mapping for ETSI8_WORLD
      ath: Add regulatory mapping for APL13_WORLD
      ath: Add regulatory mapping for APL2_FCCA
      ath: Add regulatory mapping for Uganda
      ath: Add regulatory mapping for Tanzania
      ath: Add regulatory mapping for Serbia
      ath: Add regulatory mapping for Bermuda
      ath: Add regulatory mapping for Bahamas

Takashi Iwai (2):
      ALSA: emu10k1: Rate-limit error messages about page errors
      ALSA: usb-audio: Apply rate limit to warning messages in URB complete=
 callback

Takashi Sakamoto (1):
      ALSA: hda/ca0132: fix build failure when a local macro is defined

Terry Junge (1):
      HID: hid-plantronics: Re-resend Update to map button for PTT products

Theodore Ts'o (3):
      random: mix rdrand with entropy sent in from userspace
      ext4: fix inline data updates with checksums enabled
      ext4: check for allocation block validity with block group locked

Thierry Escande (1):
      Bluetooth: hci_qca: Fix "Sleep inside atomic section" warning

Thomas Gleixner (1):
      stop_machine: Use raw spinlocks

Thomas Richter (2):
      s390/cpum_sf: Add data entry sizes to sampling trailer entry
      perf: fix invalid bit in diagnostic entry

Thor Thayer (1):
      EDAC, altera: Fix ARM64 build warning

Tobin C. Harding (1):
      mmc: pwrseq: Use kmalloc_array instead of stack VLA

Trond Myklebust (1):
      pnfs: Don't release the sequence slot until we've processed layoutget=
 on open

Tudor-Dan Ambarus (2):
      crypto: authencesn - don't leak pointers to authenc keys
      crypto: authenc - don't leak pointers to authenc keys

Vincent Palatin (1):
      mfd: cros_ec: Fail early if we cannot identify the EC

Wei Yongjun (1):
      media: rcar_jpu: Add missing clk_disable_unprepare() on error in jpu_=
open()

Wenwen Wang (2):
      scsi: 3w-9xxx: fix a missing-check bug
      scsi: 3w-xxxx: fix a missing-check bug

Will Deacon (1):
      arm64: cmpwait: Clear event register before arming exclusive monitor

Xinming Hu (1):
      mwifiex: correct histogram data with appropriate index

Xose Vazquez Perez (1):
      scsi: scsi_dh: replace too broad "TP9" string with the exact models

Yixun Lan (1):
      dt-bindings: net: meson-dwmac: new compatible name for AXG SoC

Yufen Yu (1):
      md: fix NULL dereference of mddev->pers in remove_and_add_spares()

Zhouyang Jia (2):
      ALSA: emu10k1: add error handling for snd_ctl_add
      ALSA: fm801: add error handling for snd_ctl_add


--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltj9kUACgkQONu9yGCS
aT6Whg/+K1FgN6DLG/k/wDFp2S0bGpUwA3novngHBkvXJaO23yTsYa2HFzY8Ccg7
ZswEKeRpx2engzlXqy4aScYx7qNFmhzcUfpsYq33nhRNzLPoeRnvzTB/96bpzQcO
fH8istkVFcXs6xPfmWkAhlCbcJ5A0OqtYbcqM4le3D1PHQM/RG72MCKY0SYPKJLl
c2/8F2nkh5B/fdPtD6+nijXX7iRMeG4NvfxA2NOGmL/k9oMAhFI5GVm7pmxfOQnq
+0N+H68iywje8rjvo3DoemvbfEZsmwKz5kGJ1Q4QklEB/MnrmlTn39R8rTYx3f/G
czb5kWPHjwfdj1vIEkfkhq6aVT7EGmfs/5hkMmsAKfJ8QPfX+P0PHuAowoRuTNZq
TOaw5C6Cw+1xd0GCUg9ME65sAl5Y072qQpolRNm/5AYtCMIE/ivdK+XlQXUCb4Fi
MIwTl/CzTeEnv08ya55AKy2GPWRlqHcFBbpCMV7WpCQtKKVdq/WhH/gEJ36lteU3
EFsURa8hAtbB0BbDRd7fZ+9Y39sqIsc+G0pioqnTpRE7I9szE0FaslXxFUB4LYx4
tLkIj1tL2YDFcAny2Vm/nxsyFq/JgvPD1JYw19iyYCq5GJ7gEBoDnyYaJ2k2jUHI
RXAmI2Moq7ardfIR/VsDYO1tlXnHTtzwUdUEOZRkxBhqnK4GcUA=
=6dmp
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
