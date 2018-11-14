Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52991C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FBB2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwDdFqLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FBB2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbeKNKI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731066AbeKNKI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:08:27 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C27E223C8;
        Wed, 14 Nov 2018 00:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542154061;
        bh=SCeKLCK26yVIjdN2NiGpnuaX1x8+4NJO0R8KzkfkHgw=;
        h=Date:From:To:Cc:Subject:From;
        b=HwDdFqLGl6mbTIk+TCPu5u49vR5wTgyTr4k/ExkqiWKIVgTilVJZUtDp0oFtjFvij
         YkaPYhRZvAH0wMksLIrnwdJxZ49AcyQ9b5q+ZvjDU+OoFFwkohwbXK8ZQKG3Zda6WJ
         +0VsLISR1nnsS1mJoQDTyXW14AqPw3t0KqMUugP8=
Date:   Tue, 13 Nov 2018 16:07:38 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.137
Message-ID: <20181114000738.GA10920@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.137 kernel.

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

 Makefile                                                                  =
                  |    2=20
 arch/arm/boot/dts/exynos3250.dtsi                                         =
                  |   16 +
 arch/arm/boot/dts/exynos4210.dtsi                                         =
                  |   15 +
 arch/arm/boot/dts/exynos4412.dtsi                                         =
                  |    2=20
 arch/arm/boot/dts/exynos5250.dtsi                                         =
                  |  116 +++++++---
 arch/arm/boot/dts/exynos5420-cpus.dtsi                                    =
                  |   16 -
 arch/arm/boot/dts/exynos5422-cpus.dtsi                                    =
                  |   16 -
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi                         =
                  |    2=20
 arch/arm64/lib/Makefile                                                   =
                  |    2=20
 arch/mips/cavium-octeon/executive/cvmx-helper.c                           =
                  |    2=20
 arch/parisc/kernel/entry.S                                                =
                  |    2=20
 arch/parisc/kernel/traps.c                                                =
                  |    3=20
 arch/parisc/mm/init.c                                                     =
                  |    8=20
 arch/powerpc/include/asm/mpic.h                                           =
                  |    7=20
 arch/s390/kvm/sthyi.c                                                     =
                  |    8=20
 arch/sparc/include/asm/cpudata_64.h                                       =
                  |    2=20
 arch/sparc/kernel/perf_event.c                                            =
                  |   17 +
 arch/x86/boot/tools/build.c                                               =
                  |    7=20
 arch/x86/include/asm/cpufeatures.h                                        =
                  |    1=20
 arch/x86/include/asm/nospec-branch.h                                      =
                  |    1=20
 arch/x86/kernel/check.c                                                   =
                  |   15 +
 arch/x86/kernel/cpu/bugs.c                                                =
                  |   77 +++++-
 arch/x86/kernel/cpu/common.c                                              =
                  |    3=20
 arch/x86/kernel/fpu/signal.c                                              =
                  |    1=20
 arch/x86/platform/olpc/olpc-xo1-rtc.c                                     =
                  |    3=20
 arch/x86/xen/spinlock.c                                                   =
                  |   35 +--
 crypto/lrw.c                                                              =
                  |    7=20
 crypto/tcrypt.c                                                           =
                  |    3=20
 drivers/acpi/acpi_lpss.c                                                  =
                  |    2=20
 drivers/block/ataflop.c                                                   =
                  |   25 +-
 drivers/block/swim.c                                                      =
                  |   13 -
 drivers/block/xen-blkfront.c                                              =
                  |    3=20
 drivers/bluetooth/btbcm.c                                                 =
                  |    1=20
 drivers/char/ipmi/ipmi_ssif.c                                             =
                  |   10=20
 drivers/char/tpm/tpm-interface.c                                          =
                  |    3=20
 drivers/char/tpm/xen-tpmfront.c                                           =
                  |    2=20
 drivers/cpufreq/cpufreq-dt.c                                              =
                  |   34 +-
 drivers/crypto/caam/regs.h                                                =
                  |   28 +-
 drivers/dma/dma-jz4780.c                                                  =
                  |    5=20
 drivers/dma/ioat/init.c                                                   =
                  |    9=20
 drivers/edac/i7core_edac.c                                                =
                  |    1=20
 drivers/edac/sb_edac.c                                                    =
                  |    1=20
 drivers/edac/skx_edac.c                                                   =
                  |    3=20
 drivers/hid/usbhid/hiddev.c                                               =
                  |   18 +
 drivers/hwmon/pmbus/pmbus.c                                               =
                  |    2=20
 drivers/hwmon/pmbus/pmbus_core.c                                          =
                  |    5=20
 drivers/hwmon/pwm-fan.c                                                   =
                  |   12 -
 drivers/hwtracing/coresight/coresight-etb10.c                             =
                  |    4=20
 drivers/i2c/busses/i2c-rcar.c                                             =
                  |    6=20
 drivers/iio/adc/at91_adc.c                                                =
                  |    6=20
 drivers/iio/adc/fsl-imx25-gcq.c                                           =
                  |    6=20
 drivers/iio/dac/ad5064.c                                                  =
                  |   53 +++-
 drivers/infiniband/core/sysfs.c                                           =
                  |   19 +
 drivers/infiniband/ulp/ipoib/ipoib_cm.c                                   =
                  |    8=20
 drivers/md/bcache/btree.c                                                 =
                  |    2=20
 drivers/md/dm-ioctl.c                                                     =
                  |   18 -
 drivers/md/raid1.c                                                        =
                  |    1=20
 drivers/md/raid10.c                                                       =
                  |    1=20
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c                             =
                  |    2=20
 drivers/media/i2c/tvp5150.c                                               =
                  |    2=20
 drivers/media/usb/em28xx/em28xx-cards.c                                   =
                  |    4=20
 drivers/media/usb/em28xx/em28xx-video.c                                   =
                  |    8=20
 drivers/misc/genwqe/card_base.h                                           =
                  |    2=20
 drivers/misc/genwqe/card_dev.c                                            =
                  |    9=20
 drivers/misc/vmw_vmci/vmci_driver.c                                       =
                  |    2=20
 drivers/misc/vmw_vmci/vmci_resource.c                                     =
                  |    3=20
 drivers/mmc/host/sdhci-pci-o2micro.c                                      =
                  |    3=20
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c                         =
                  |    4=20
 drivers/net/ethernet/qlogic/qla3xxx.c                                     =
                  |    2=20
 drivers/net/tun.c                                                         =
                  |    2=20
 drivers/net/wireless/ath/ath10k/wmi.c                                     =
                  |    6=20
 drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c                    =
                  |   34 ++
 drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h              =
                  |    2=20
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c                               =
                  |   24 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                              =
                  |   32 +-
 drivers/net/wireless/marvell/libertas/if_usb.c                            =
                  |    2=20
 drivers/nvdimm/bus.c                                                      =
                  |    4=20
 drivers/pci/msi.c                                                         =
                  |    9=20
 drivers/pci/quirks.c                                                      =
                  |    4=20
 drivers/pcmcia/ricoh.h                                                    =
                  |   35 +++
 drivers/pcmcia/yenta_socket.c                                             =
                  |    3=20
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c                                   =
                  |   27 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c                                  =
                  |   28 +-
 drivers/rpmsg/qcom_smd.c                                                  =
                  |    7=20
 drivers/scsi/esp_scsi.c                                                   =
                  |    1=20
 drivers/scsi/esp_scsi.h                                                   =
                  |    2=20
 drivers/scsi/lpfc/lpfc_sli.c                                              =
                  |    7=20
 drivers/scsi/mac_esp.c                                                    =
                  |    2=20
 drivers/scsi/megaraid/megaraid_sas_base.c                                 =
                  |    3=20
 drivers/soc/tegra/pmc.c                                                   =
                  |    2=20
 drivers/tc/tc.c                                                           =
                  |    8=20
 drivers/tty/serial/kgdboc.c                                               =
                  |    5=20
 drivers/uio/uio.c                                                         =
                  |    9=20
 drivers/usb/chipidea/otg.h                                                =
                  |    3=20
 drivers/usb/gadget/udc/atmel_usba_udc.c                                   =
                  |    2=20
 drivers/usb/usbip/vudc_main.c                                             =
                  |   10=20
 drivers/w1/masters/omap_hdq.c                                             =
                  |    2=20
 drivers/xen/swiotlb-xen.c                                                 =
                  |    6=20
 fs/btrfs/extent-tree.c                                                    =
                  |   47 +++-
 fs/btrfs/free-space-cache.c                                               =
                  |   32 +-
 fs/btrfs/inode.c                                                          =
                  |    1=20
 fs/btrfs/qgroup.c                                                         =
                  |    1=20
 fs/btrfs/relocation.c                                                     =
                  |    2=20
 fs/btrfs/tree-log.c                                                       =
                  |   39 ++-
 fs/cifs/cifs_debug.c                                                      =
                  |    3=20
 fs/cifs/cifs_spnego.c                                                     =
                  |    6=20
 fs/cifs/inode.c                                                           =
                  |   10=20
 fs/cramfs/inode.c                                                         =
                  |    3=20
 fs/ext4/inline.c                                                          =
                  |    2=20
 fs/ext4/ioctl.c                                                           =
                  |    4=20
 fs/ext4/move_extent.c                                                     =
                  |    8=20
 fs/gfs2/ops_fstype.c                                                      =
                  |    3=20
 fs/jbd2/checkpoint.c                                                      =
                  |    4=20
 fs/jffs2/super.c                                                          =
                  |    4=20
 fs/lockd/host.c                                                           =
                  |    2=20
 fs/nfs/nfs4client.c                                                       =
                  |   16 -
 include/linux/tc.h                                                        =
                  |    1=20
 kernel/bounds.c                                                           =
                  |    4=20
 kernel/cpu.c                                                              =
                  |   11=20
 kernel/irq/manage.c                                                       =
                  |    8=20
 kernel/kprobes.c                                                          =
                  |   27 +-
 kernel/locking/lockdep.c                                                  =
                  |    4=20
 kernel/printk/printk.c                                                    =
                  |    7=20
 kernel/sched/fair.c                                                       =
                  |    2=20
 kernel/signal.c                                                           =
                  |    2=20
 lib/debug_locks.c                                                         =
                  |    2=20
 mm/hugetlb.c                                                              =
                  |    6=20
 net/core/netclassid_cgroup.c                                              =
                  |    1=20
 net/ipv4/cipso_ipv4.c                                                     =
                  |   11=20
 net/sunrpc/svc_xprt.c                                                     =
                  |    2=20
 net/xfrm/xfrm_policy.c                                                    =
                  |    8=20
 security/integrity/ima/ima_fs.c                                           =
                  |    6=20
 sound/pci/ca0106/ca0106.h                                                 =
                  |    2=20
 sound/pci/hda/hda_controller.h                                            =
                  |    1=20
 sound/pci/hda/hda_intel.c                                                 =
                  |   11=20
 sound/pci/hda/patch_conexant.c                                            =
                  |    1=20
 sound/pci/hda/patch_realtek.c                                             =
                  |   20 +
 sound/soc/intel/skylake/skl-topology.c                                    =
                  |    1=20
 tools/perf/util/event.c                                                   =
                  |    1=20
 tools/perf/util/pmu.c                                                     =
                  |   13 -
 tools/perf/util/strbuf.c                                                  =
                  |   10=20
 tools/perf/util/trace-event-info.c                                        =
                  |    2=20
 tools/perf/util/trace-event-read.c                                        =
                  |    5=20
 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-syntheti=
c-event-syntax.tc |   80 ++++++
 tools/testing/selftests/net/reuseport_bpf.c                               =
                  |   13 -
 145 files changed, 1102 insertions(+), 359 deletions(-)

Aaro Koskinen (1):
      MIPS: OCTEON: fix out of bounds array access on CN68XX

Al Viro (1):
      gfs2_meta: ->mount() can get NULL dev_name

Alex Stanoev (1):
      ALSA: ca0106: Disable IZD on SB0570 DAC to fix audio pops

Alexander Duyck (1):
      libnvdimm: Hold reference on parent while scheduling async init

Alexandre Belloni (2):
      usb: gadget: udc: atmel: handle at91sam9rl PMC
      uio: ensure class is registered before devices

Alexey Khoroshilov (1):
      iio: adc: imx25-gcq: Fix leak of device_node in mx25_gcq_setup_cfgs()

Amir Goldstein (1):
      lockd: fix access beyond unterminated strings in prints

Andreas Kemnade (1):
      w1: omap-hdq: fix missing bus unregister at removal

Arend van Spriel (1):
      brcmfmac: fix for proper support of 160MHz bandwidth

Arnd Bergmann (1):
      kbuild: fix kernel/bounds.c 'W=3D1' warning

Ben Hutchings (1):
      x86: boot: Fix EFI stub alignment

Bin Meng (1):
      PCI: Add Device IDs for Intel GPU "spurious interrupt" quirk

Breno Leitao (1):
      HID: hiddev: fix potential Spectre v1

Christian Hewitt (1):
      Bluetooth: btbcm: Add entry for BCM4335C0 UART bluetooth

Christophe Leroy (1):
      powerpc/msi: Fix compile error on mpc83xx

Colin Ian King (1):
      rpmsg: smd: fix memory leak on channel create

David Miller (1):
      perf cpu_map: Align cpu map synthesized events properly.

David S. Miller (2):
      sparc: Fix single-pcr perf event counter management.
      sparc64: Make proc_id signed.

Denis Drozdov (1):
      IB/ipoib: Clear IPCB before icmp_send

Dmitry Bazhenov (1):
      hwmon: (pmbus) Fix page count auto-detection.

Douglas Anderson (2):
      pinctrl: spmi-mpp: Fix pmic_mpp_config_get() to be compliant
      pinctrl: ssbi-gpio: Fix pm8xxx_pin_config_get() to be compliant

Dr. Greg Wettstein (1):
      tpm: Restore functionality to xen vtpm driver.

Eric Biggers (1):
      ima: fix showing large 'violations' or 'runtime_measurements_count'

Eric Dumazet (1):
      bpf: do not blindly change rlimit in reuseport net selftest

Eric W. Biederman (2):
      signal: Always deliver the kernel's SIGKILL and SIGSTOP to a pid name=
space init
      signal/GenWQE: Fix sending of SIGKILL

Eugen Hristev (2):
      iio: adc: at91: fix acking DRDY irq on simple conversions
      iio: adc: at91: fix wrong channel number in triggered buffer mode

Filipe Manana (2):
      Btrfs: fix wrong dentries after fsync of file that got its parent rep=
laced
      Btrfs: fix null pointer dereference on compressed write path error

Finn Thain (1):
      scsi: esp_scsi: Track residual for PIO transfers

Florian Westphal (1):
      xfrm: policy: use hlist rcu variants on insert

Greg Kroah-Hartman (1):
      Linux 4.9.137

Hans Verkuil (1):
      media: v4l2-tpg: fix kernel oops when enabling HFLIP and OSD

Hans de Goede (1):
      ACPI / LPSS: Add alternative ACPI HIDs for Cherry Trail DMA controlle=
rs

He Zhe (3):
      x86/corruption-check: Fix panic in memory_corruption_check() when boo=
t option without value is provided
      printk: Fix panic caused by passing log_buf_len to command line
      kgdboc: Passing ekgdboc to command line causes panic

Helge Deller (1):
      parisc: Fix map_pages() to not overwrite existing pte entries

Horia Geant=C4=83 (2):
      crypto: caam - fix implicit casts in endianness helpers
      crypto: tcrypt - fix ghash-generic speed test

Hou Tao (1):
      jffs2: free jffs2_sb_info through jffs2_kill_sb()

James Smart (1):
      scsi: lpfc: Correct soft lockup when running mds diagnostics

Jan Glauber (1):
      ipmi: Fix timer race with module unload

Jan Kara (1):
      jbd2: fix use after free in jbd2_log_do_checkpoint()

Janosch Frank (1):
      s390/sthyi: Fix machine name validity indication

Javier Martinez Canillas (1):
      tpm: suppress transmit cmd error logs when TPM 1.2 is disabled/deacti=
vated

Jeff Mahoney (3):
      btrfs: fix error handling in free_log_tree
      btrfs: iterate all devices during trim, instead of fs_devices::alloc_=
list
      btrfs: don't attempt to trim devices that don't support it

Jeremy Cline (1):
      ALSA: hda - Add mic quirk for the Lenovo G50-30 (17aa:3905)

Jiri Kosina (1):
      x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigation

Jiri Olsa (1):
      Revert "perf tools: Fix PMU term format max value calculation"

Joe Jin (1):
      xen-swiotlb: use actually allocated size on check physical continuous

Johan Hovold (1):
      soc/tegra: pmc: Fix child-node lookup

John David Anglin (1):
      parisc: Fix address in HPMC IVA

Jorgen Hansen (1):
      VMCI: Resource wildcard match fixed

Josef Bacik (4):
      btrfs: wait on caching when putting the bg cache
      btrfs: reset max_extent_size on clear in a bitmap
      btrfs: make sure we create all new block groups
      btrfs: set max_extent_size properly

Juergen Gross (3):
      xen: fix race in xen_qlock_wait()
      xen: make xen_qlock_wait() nestable
      xen: fix xen_qlock_wait()

Lars-Peter Clausen (1):
      iio: ad5064: Fix regulator handling

Loic Poulain (1):
      usb: chipidea: Prevent unbalanced IRQ disable

Lubomir Rintel (2):
      x86/olpc: Indicate that legacy PC XO-1 platform should not register R=
TC
      libertas: don't set URB_ZERO_PACKET on IN USB transfer

Luca Coelho (1):
      iwlwifi: mvm: check return value of rs_rate_from_ucode_rate()

Lukas Czerner (1):
      ext4: initialize retries variable in ext4_da_write_inline_data_begin()

Lukas Wunner (1):
      genirq: Fix race on spurious interrupt detection

Maciej S. Szmigiero (1):
      pcmcia: Implement CLKRUN protocol disabling for Ricoh bridges

Maciej W. Rozycki (1):
      TC: Set DMA masks for devices

Marek Szyprowski (2):
      ARM: dts: exynos: Convert exynos5250.dtsi to opp-v2 bindings
      ARM: dts: exynos: Mark 1 GHz CPU OPP as suspend OPP on Exynos5250

Martin Willi (1):
      ath10k: schedule hardware restart if WMI command times out

Masami Hiramatsu (2):
      selftests: ftrace: Add synthetic event syntax testcase
      kprobes: Return error if we fail to reuse kprobe instead of BUG_ON()

Mauro Carvalho Chehab (4):
      media: em28xx: use a default format if TRY_FMT fails
      media: tvp5150: avoid going past array on v4l2_querymenu()
      media: em28xx: fix input name for Terratec AV 350
      media: em28xx: make v4l2-compliance happier by starting sequence on z=
ero

Michal Hocko (1):
      cgroup, netclassid: add a preemption point to write_classid

Mike Kravetz (1):
      hugetlbfs: dirty pages as they are added to pagecache

Nathan Chancellor (1):
      net: qla3xxx: Remove overflowing shift statement

Nicolas Pitre (1):
      Cramfs: fix abad comparison when wrap-arounds occur

Omar Sandoval (2):
      ataflop: fix error handling during setup
      swim: fix cleanup on setup error

Ondrej Mosnacek (1):
      crypto: lrw - Fix out-of bounds access on counter overflow

Parav Pandit (1):
      RDMA/core: Do not expose unsupported counters

Paul Cercueil (1):
      dmaengine: dma-jz4780: Return error if not probed from DT

Qiuxu Zhuo (1):
      EDAC, skx_edac: Fix logical channel intermediate decoding

Qu Wenruo (3):
      btrfs: Handle owner mismatch gracefully when walking up tree
      btrfs: locking: Add extra check in btrfs_init_new_buffer() to avoid d=
eadlock
      btrfs: qgroup: Dirty all qgroups before rescan

Sai Praneeth (1):
      x86/speculation: Support Enhanced IBRS on future CPUs

Sanskriti Sharma (3):
      perf tools: Free temporary 'sys' string in read_event_files()
      perf tools: Cleanup trace-event-info 'tdata' leak
      perf strbuf: Match va_{add,copy} with va_end

Sebastian Andrzej Siewior (1):
      x86/fpu: Remove second definition of fpu in __fpu__restore_sig()

Sebastian Basierski (1):
      ixgbevf: VF2VF TCP RSS

Serhey Popovych (1):
      tun: Consistently configure generic netdev params via rtnetlink

Shaohua Li (2):
      MD: fix invalid stored role for a disk
      MD: fix invalid stored role for a disk - try2

Shaul Triebitz (1):
      iwlwifi: pcie: avoid empty free RB queue

Shuah Khan (Samsung OSG) (1):
      usbip:vudc: BUG kmalloc-2048 (Not tainted): Poison overwritten

Song Muchun (1):
      sched/fair: Fix the min_vruntime update logic in dequeue_entity()

Stefan Nuernberger (1):
      net/ipv4: defensive cipso option parsing

Stephen Boyd (1):
      pinctrl: qcom: spmi-mpp: Fix drive strength setting

Steve French (3):
      smb3: allow stats which track session and share reconnects to be reset
      smb3: do not attempt cifs operation in smb3 query info error path
      smb3: on kerberos mount if server doesn't specify auth type use krb5

Suzuki K Poulose (1):
      coresight: etb10: Fix handling of perf mode

Takashi Iwai (4):
      ALSA: hda - Add quirk for ASUS G751 laptop
      ALSA: hda - Fix headphone pin config for ASUS G751
      ALSA: hda: Check the non-cached stream buffers more explicitly
      ASoC: intel: skylake: Add missing break in skl_tplg_get_token()

Tang Junhui (1):
      bcache: fix miss key refill->end in writeback

Theodore Ts'o (1):
      ext4: fix argument checking in EXT4_IOC_MOVE_EXT

Thierry Reding (1):
      hwmon: (pwm-fan) Set fan speed to 0 on suspend

Thor Thayer (1):
      arm64: dts: stratix10: Correct System Manager register size

Tonghao Zhang (1):
      PCI/MSI: Warn and return error if driver enables MSI/MSI-X twice

Tony Luck (1):
      EDAC, {i7core,sb,skx}_edac: Fix uncorrected error counting

Tri Vo (1):
      arm64: lse: remove -fcall-used-x0 flag

Trond Myklebust (2):
      NFSv4.1: Fix the r/wsize checking
      nfsd: Fix an Oops in free_session()

Vasilis Liaskovitis (1):
      xen/blkfront: avoid NULL blkfront_info dereference on device removal

Viresh Kumar (3):
      cpufreq: dt: Try freeing static OPPs only if we have added them
      ARM: dts: exynos: Remove "cooling-{min|max}-level" for CPU nodes
      arm: dts: exynos: Add missing cooling device properties for CPUs

Waiman Long (2):
      locking/lockdep: Fix debug_locks off performance problem
      driver/dma/ioat: Call del_timer_sync() without holding prep_lock

Wang Shilong (1):
      ext4: propagate error from dquot_initialize() in EXT4_IOC_FSSETXATTR

Wenwen Wang (2):
      scsi: megaraid_sas: fix a missing-check bug
      dm ioctl: harden copy_params()'s copy_from_user() from malicious users

Wolfram Sang (1):
      i2c: rcar: cleanup DMA for all kinds of failure

Yu Zhao (1):
      mmc: sdhci-pci-o2micro: Add quirk for O2 Micro dev 0x8620 rev 0x01

YueHaibing (1):
      pinctrl: qcom: spmi-mpp: Fix err handling of pmic_mpp_set_mux


--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvrZ0oACgkQONu9yGCS
aT714Q//W+xrMoMIGQpexaNcFov7aUVbLdocesorBhDktDSMNNLRLYdwrNu/xU+p
uLMR0o4QYp5yheBN4Twqxz3J6Bt4rkizQf67qJfbfDy3WBGABnKPjcFFAI8WcmPN
4g4PsI6HYG9b66oEcwfb/1LurpdW0ZBPDSKOLuwZL76jqtFeCkY0p+ATiIxxD3He
wR4NHF66rWWc2MHperz8ZecDPR4TEmQlgTnqjJhdskmzhTxJHNOWpGBE/tZUt50y
tCwTjx34U1Z5O+h4a17oxJeIIgCfdh2GSUJr6eY1cvxVakmAiSkFfqBpls8qMQI1
C2c4Go9RIgdkMM7RG7VTk8D+vYl3ceQRnBDOpTgB1HI3rg4ACoCMsUko8uoa29cq
wFz8PHRpaO9NN9XLIabNTVzGdBSQxF6XQ+z/cPRyPkfeEuBs56bMILaq6IGStYIg
0K/t5MqDHCxo9jYWslbR9CHzL6dryqRBZIfJDY2y1Iw7s8Uk5RQQ9mbU3IC9+KmM
Xkti/Dz5ehNIk5bbrWzHcmlZ3GOYXWve8XQhZs1OyQeR3fvQRuXbXYbzH20fdVcP
m5xSUdI+k9kCeEnmpy7udHjlUljLdAxOfbDW+dxK9b5mzIA9cPYQ6XnVSUD5lEGG
gS25wQ4TW6SNs/hYaVboiV05OWXRrZRu2DoWwOgqfLeSL9VcA6I=
=cGZN
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
