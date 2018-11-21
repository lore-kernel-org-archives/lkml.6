Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F01C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB9021104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrVXDlj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB9021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbeKUVGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:06:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeKUVGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:06:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6717D21104;
        Wed, 21 Nov 2018 10:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542796340;
        bh=jsJKI4tSkh1vfCXM8tR14qrtNfURcS2N2fxyv7YG2so=;
        h=Date:From:To:Cc:Subject:From;
        b=PrVXDlj8eWIuPl4OrTIf4DKTYrQ6vXQOV4dl6iQd3OEAgQBUEyzk1YmPIL/rTwTn8
         X4rekMCtXu5LwZudFrTNQTtd+lQDXI1/oXLw9Tc/n0c2OFuewSpg35pSsxnFkNkd0K
         t6PRi72USNyV36NGDPifDKo8PwJxt+/jZpx1+X3Y=
Date:   Wed, 21 Nov 2018 11:32:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.164
Message-ID: <20181121103217.GA9346@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.164 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                                  =
                  |    2=20
 arch/alpha/include/asm/termios.h                                          =
                  |    8 -
 arch/alpha/include/uapi/asm/ioctls.h                                      =
                  |    5=20
 arch/alpha/include/uapi/asm/termbits.h                                    =
                  |   17 ++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi                         =
                  |    2=20
 arch/mips/cavium-octeon/executive/cvmx-helper.c                           =
                  |    2=20
 arch/mips/include/asm/mach-loongson64/irq.h                               =
                  |    2=20
 arch/mips/kernel/crash.c                                                  =
                  |    3=20
 arch/mips/kernel/machine_kexec.c                                          =
                  |    3=20
 arch/mips/loongson64/loongson-3/irq.c                                     =
                  |   56 -------
 arch/parisc/kernel/entry.S                                                =
                  |    2=20
 arch/parisc/kernel/traps.c                                                =
                  |    3=20
 arch/parisc/mm/init.c                                                     =
                  |    8 -
 arch/powerpc/boot/crt0.S                                                  =
                  |    4=20
 arch/powerpc/include/asm/mpic.h                                           =
                  |    7=20
 arch/powerpc/mm/tlb_nohash.c                                              =
                  |    3=20
 arch/sparc/kernel/perf_event.c                                            =
                  |   17 +-
 arch/x86/Kconfig                                                          =
                  |    1=20
 arch/x86/boot/tools/build.c                                               =
                  |    7=20
 arch/x86/kernel/check.c                                                   =
                  |   15 +
 arch/x86/kernel/fpu/signal.c                                              =
                  |    1=20
 arch/x86/xen/spinlock.c                                                   =
                  |   35 +---
 arch/xtensa/boot/Makefile                                                 =
                  |    2=20
 arch/xtensa/include/asm/processor.h                                       =
                  |    6=20
 arch/xtensa/kernel/head.S                                                 =
                  |    7=20
 arch/xtensa/kernel/vmlinux.lds.S                                          =
                  |    1=20
 crypto/lrw.c                                                              =
                  |    7=20
 drivers/acpi/acpi_lpss.c                                                  =
                  |    2=20
 drivers/block/ataflop.c                                                   =
                  |   25 +--
 drivers/block/swim.c                                                      =
                  |   13 +
 drivers/bluetooth/btbcm.c                                                 =
                  |    1=20
 drivers/cdrom/cdrom.c                                                     =
                  |    2=20
 drivers/char/ipmi/ipmi_ssif.c                                             =
                  |   10 -
 drivers/char/tpm/tpm-interface.c                                          =
                  |    3=20
 drivers/char/tpm/xen-tpmfront.c                                           =
                  |    2=20
 drivers/clk/clk-s2mps11.c                                                 =
                  |   30 +++
 drivers/clocksource/i8253.c                                               =
                  |   14 +
 drivers/dma/dma-jz4780.c                                                  =
                  |    5=20
 drivers/dma/ioat/init.c                                                   =
                  |    9 +
 drivers/gpu/drm/drm_dp_mst_topology.c                                     =
                  |    3=20
 drivers/gpu/drm/i915/intel_audio.c                                        =
                  |   17 ++
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c                                  =
                  |   11 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c                               =
                  |    6=20
 drivers/hid/usbhid/hiddev.c                                               =
                  |   18 +-
 drivers/hwmon/pmbus/pmbus.c                                               =
                  |    2=20
 drivers/hwmon/pmbus/pmbus_core.c                                          =
                  |    5=20
 drivers/iio/adc/at91_adc.c                                                =
                  |    6=20
 drivers/md/bcache/btree.c                                                 =
                  |    2=20
 drivers/md/dm-ioctl.c                                                     =
                  |   18 --
 drivers/md/raid1.c                                                        =
                  |    1=20
 drivers/md/raid10.c                                                       =
                  |    1=20
 drivers/media/i2c/tvp5150.c                                               =
                  |   14 +
 drivers/media/pci/cx23885/altera-ci.c                                     =
                  |   10 +
 drivers/media/usb/em28xx/em28xx-cards.c                                   =
                  |    4=20
 drivers/media/usb/em28xx/em28xx-video.c                                   =
                  |    8 -
 drivers/misc/genwqe/card_base.h                                           =
                  |    2=20
 drivers/misc/genwqe/card_dev.c                                            =
                  |    9 -
 drivers/mmc/host/sdhci-pci-o2micro.c                                      =
                  |    3=20
 drivers/mtd/devices/Kconfig                                               =
                  |    2=20
 drivers/net/ethernet/brocade/bna/bnad_ethtool.c                           =
                  |    4=20
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c                          =
                  |    9 -
 drivers/net/ethernet/intel/e1000/e1000_main.c                             =
                  |   11 +
 drivers/net/ethernet/qlogic/qla3xxx.c                                     =
                  |    2=20
 drivers/net/tun.c                                                         =
                  |    2=20
 drivers/net/wireless/ath/ath10k/wmi.c                                     =
                  |    6=20
 drivers/nvdimm/bus.c                                                      =
                  |    4=20
 drivers/pci/quirks.c                                                      =
                  |    4=20
 drivers/pcmcia/ricoh.h                                                    =
                  |   35 ++++
 drivers/pcmcia/yenta_socket.c                                             =
                  |    3=20
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c                                   =
                  |   27 ++-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c                                  =
                  |   28 ++-
 drivers/rtc/hctosys.c                                                     =
                  |    4=20
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
 drivers/scsi/qla2xxx/qla_mbx.c                                            =
                  |    5=20
 drivers/soc/tegra/pmc.c                                                   =
                  |    2=20
 drivers/tc/tc.c                                                           =
                  |    8 -
 drivers/tty/serial/kgdboc.c                                               =
                  |    5=20
 drivers/tty/serial/sc16is7xx.c                                            =
                  |   19 +-
 drivers/tty/tty_io.c                                                      =
                  |    2=20
 drivers/tty/tty_ioctl.c                                                   =
                  |    4=20
 drivers/uio/uio.c                                                         =
                  |    9 +
 drivers/usb/chipidea/otg.h                                                =
                  |    3=20
 drivers/vhost/scsi.c                                                      =
                  |    4=20
 drivers/video/fbdev/aty/mach64_accel.c                                    =
                  |   28 +--
 drivers/w1/masters/omap_hdq.c                                             =
                  |    2=20
 drivers/xen/swiotlb-xen.c                                                 =
                  |    6=20
 fs/9p/vfs_file.c                                                          =
                  |   16 +-
 fs/binfmt_elf.c                                                           =
                  |   46 +++--
 fs/btrfs/extent-tree.c                                                    =
                  |   48 ++++--
 fs/btrfs/free-space-cache.c                                               =
                  |   32 ++--
 fs/btrfs/inode.c                                                          =
                  |    1=20
 fs/btrfs/ioctl.c                                                          =
                  |   12 +
 fs/btrfs/qgroup.c                                                         =
                  |    1=20
 fs/btrfs/relocation.c                                                     =
                  |    2=20
 fs/btrfs/tree-log.c                                                       =
                  |   30 +++
 fs/cifs/cifs_debug.c                                                      =
                  |    3=20
 fs/cifs/cifs_spnego.c                                                     =
                  |    6=20
 fs/cifs/inode.c                                                           =
                  |   10 +
 fs/configfs/symlink.c                                                     =
                  |    2=20
 fs/cramfs/inode.c                                                         =
                  |    3=20
 fs/ext4/ext4.h                                                            =
                  |    3=20
 fs/ext4/inline.c                                                          =
                  |   40 -----
 fs/ext4/move_extent.c                                                     =
                  |    8 -
 fs/ext4/namei.c                                                           =
                  |    5=20
 fs/ext4/resize.c                                                          =
                  |   28 ++-
 fs/ext4/super.c                                                           =
                  |   16 +-
 fs/ext4/xattr.c                                                           =
                  |   22 --
 fs/fuse/dev.c                                                             =
                  |   29 ++-
 fs/gfs2/ops_fstype.c                                                      =
                  |    3=20
 fs/jbd2/checkpoint.c                                                      =
                  |    4=20
 fs/jffs2/super.c                                                          =
                  |    4=20
 fs/lockd/host.c                                                           =
                  |    2=20
 fs/namespace.c                                                            =
                  |   22 ++
 fs/nfs/nfs4client.c                                                       =
                  |   16 +-
 fs/ocfs2/dir.c                                                            =
                  |    3=20
 include/linux/ceph/libceph.h                                              =
                  |    8 -
 include/linux/hugetlb.h                                                   =
                  |   14 +
 include/linux/i8253.h                                                     =
                  |    1=20
 include/linux/mm.h                                                        =
                  |    6=20
 include/linux/tc.h                                                        =
                  |    1=20
 kernel/bounds.c                                                           =
                  |    4=20
 kernel/irq/manage.c                                                       =
                  |    8 -
 kernel/kprobes.c                                                          =
                  |   27 ++-
 kernel/locking/lockdep.c                                                  =
                  |    4=20
 kernel/printk/printk.c                                                    =
                  |    7=20
 kernel/signal.c                                                           =
                  |    2=20
 lib/debug_locks.c                                                         =
                  |    2=20
 mm/gup.c                                                                  =
                  |    2=20
 mm/hugetlb.c                                                              =
                  |   66 +++++++-
 mm/mempolicy.c                                                            =
                  |   32 +++-
 mm/mmap.c                                                                 =
                  |   13 +
 mm/rmap.c                                                                 =
                  |   56 +++++++
 net/9p/protocol.c                                                         =
                  |    5=20
 net/ipv4/cipso_ipv4.c                                                     =
                  |   11 -
 net/sunrpc/svc_xprt.c                                                     =
                  |    2=20
 net/sunrpc/xdr.c                                                          =
                  |    5=20
 security/integrity/ima/ima_fs.c                                           =
                  |    6=20
 sound/pci/ca0106/ca0106.h                                                 =
                  |    2=20
 sound/pci/hda/hda_controller.h                                            =
                  |    1=20
 sound/pci/hda/hda_intel.c                                                 =
                  |   11 +
 sound/pci/hda/patch_conexant.c                                            =
                  |    1=20
 tools/perf/util/trace-event-info.c                                        =
                  |    2=20
 tools/perf/util/trace-event-read.c                                        =
                  |    5=20
 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-syntheti=
c-event-syntax.tc |   80 ++++++++++
 148 files changed, 1114 insertions(+), 422 deletions(-)

Aaro Koskinen (1):
      MIPS: OCTEON: fix out of bounds array access on CN68XX

Al Viro (1):
      gfs2_meta: ->mount() can get NULL dev_name

Alex Stanoev (1):
      ALSA: ca0106: Disable IZD on SB0570 DAC to fix audio pops

Alexander Duyck (1):
      libnvdimm: Hold reference on parent while scheduling async init

Alexandre Belloni (1):
      uio: ensure class is registered before devices

Amir Goldstein (1):
      lockd: fix access beyond unterminated strings in prints

Andrea Arcangeli (1):
      mm: thp: relax __GFP_THISNODE for MADV_HUGEPAGE mappings

Andreas Kemnade (1):
      w1: omap-hdq: fix missing bus unregister at removal

Arnd Bergmann (2):
      kbuild: fix kernel/bounds.c 'W=3D1' warning
      mtd: docg3: don't set conflicting BCH_CONST_PARAMS option

Ben Hutchings (1):
      x86: boot: Fix EFI stub alignment

Bin Meng (1):
      PCI: Add Device IDs for Intel GPU "spurious interrupt" quirk

Breno Leitao (1):
      HID: hiddev: fix potential Spectre v1

Changwei Ge (1):
      ocfs2: fix a misuse a of brelse after failing ocfs2_check_dir_entry

Christian Hewitt (1):
      Bluetooth: btbcm: Add entry for BCM4335C0 UART bluetooth

Christophe Leroy (1):
      powerpc/msi: Fix compile error on mpc83xx

Clint Taylor (1):
      drm/i915/hdmi: Add HDMI 2.0 audio clock recovery N values

Colin Ian King (1):
      e1000: avoid null pointer dereference on invalid stat type

Daniel Axtens (1):
      powerpc/nohash: fix undefined behaviour when testing page size support

Daniel Wagner (1):
      x86/kconfig: Fall back to ticket spinlocks

David S. Miller (1):
      sparc: Fix single-pcr perf event counter management.

Dengcheng Zhu (1):
      MIPS: kexec: Mark CPU offline before disabling local IRQ

Dmitry Bazhenov (1):
      hwmon: (pmbus) Fix page count auto-detection.

Dominique Martinet (2):
      9p locks: fix glock.client_id leak in do_lock
      9p: clear dangling pointers in p9stat_free

Douglas Anderson (2):
      pinctrl: spmi-mpp: Fix pmic_mpp_config_get() to be compliant
      pinctrl: ssbi-gpio: Fix pm8xxx_pin_config_get() to be compliant

Dr. Greg Wettstein (1):
      tpm: Restore functionality to xen vtpm driver.

Eric Biggers (1):
      ima: fix showing large 'violations' or 'runtime_measurements_count'

Eric W. Biederman (5):
      signal: Always deliver the kernel's SIGKILL and SIGSTOP to a pid name=
space init
      signal/GenWQE: Fix sending of SIGKILL
      mount: Retest MNT_LOCKED in do_umount
      mount: Don't allow copying MNT_UNBINDABLE|MNT_LOCKED mounts
      mount: Prevent MNT_DETACH from disconnecting locked mounts

Eugen Hristev (2):
      iio: adc: at91: fix acking DRDY irq on simple conversions
      iio: adc: at91: fix wrong channel number in triggered buffer mode

Filipe Manana (3):
      Btrfs: fix wrong dentries after fsync of file that got its parent rep=
laced
      Btrfs: fix null pointer dereference on compressed write path error
      Btrfs: fix data corruption due to cloning of eof block

Finn Thain (1):
      scsi: esp_scsi: Track residual for PIO transfers

Frank Sorenson (1):
      sunrpc: correct the computation for page_ptr when truncating

Greg Edwards (1):
      vhost/scsi: truncate T10 PI iov_iter to prot_bytes

Greg Kroah-Hartman (1):
      Linux 4.4.164

Guenter Roeck (1):
      configfs: replace strncpy with memcpy

H. Peter Anvin (1):
      termios, tty/tty_baudrate.c: fix buffer overrun

H. Peter Anvin (Intel) (1):
      arch/alpha, termios: implement BOTHER, IBSHIFT and termios2

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

Himanshu Madhani (1):
      scsi: qla2xxx: Fix incorrect port speed being set for FC adapters

Hou Tao (1):
      jffs2: free jffs2_sb_info through jffs2_kill_sb()

Huacai Chen (2):
      MIPS: Loongson-3: Fix CPU UART irq delivery problem
      MIPS: Loongson-3: Fix BRIDGE irq delivery problem

Ilya Dryomov (1):
      libceph: bump CEPH_MSG_MAX_DATA_LEN

James Smart (1):
      scsi: lpfc: Correct soft lockup when running mds diagnostics

Jan Glauber (1):
      ipmi: Fix timer race with module unload

Jan Kara (1):
      jbd2: fix use after free in jbd2_log_do_checkpoint()

Javier Martinez Canillas (1):
      tpm: suppress transmit cmd error logs when TPM 1.2 is disabled/deacti=
vated

Jeff Mahoney (2):
      btrfs: iterate all devices during trim, instead of fs_devices::alloc_=
list
      btrfs: don't attempt to trim devices that don't support it

Jeremy Cline (1):
      ALSA: hda - Add mic quirk for the Lenovo G50-30 (17aa:3905)

Joe Jin (1):
      xen-swiotlb: use actually allocated size on check physical continuous

Joel Stanley (1):
      powerpc/boot: Ensure _zimage_start is a weak symbol

Johan Hovold (1):
      soc/tegra: pmc: Fix child-node lookup

John David Anglin (1):
      parisc: Fix address in HPMC IVA

Josef Bacik (4):
      btrfs: wait on caching when putting the bg cache
      btrfs: reset max_extent_size on clear in a bitmap
      btrfs: make sure we create all new block groups
      btrfs: set max_extent_size properly

Juergen Gross (3):
      xen: fix race in xen_qlock_wait()
      xen: make xen_qlock_wait() nestable
      xen: fix xen_qlock_wait()

Kees Cook (3):
      binfmt_elf: fix calculations for bss padding
      mm: refuse wrapped vm_brk requests
      bna: ethtool: Avoid reading past end of buffer

Kirill Tkhai (2):
      fuse: Fix use-after-free in fuse_dev_do_read()
      fuse: Fix use-after-free in fuse_dev_do_write()

Krzysztof Kozlowski (1):
      clk: s2mps11: Fix matching when built as module and DT node contains =
compatible

Loic Poulain (1):
      usb: chipidea: Prevent unbalanced IRQ disable

Lukas Czerner (1):
      ext4: initialize retries variable in ext4_da_write_inline_data_begin()

Lukas Wunner (1):
      genirq: Fix race on spurious interrupt detection

Maciej S. Szmigiero (1):
      pcmcia: Implement CLKRUN protocol disabling for Ricoh bridges

Maciej W. Rozycki (2):
      TC: Set DMA masks for devices
      rtc: hctosys: Add missing range error reporting

Marc Zyngier (1):
      drm/rockchip: Allow driver to be shutdown on reboot/kexec

Marco Felsch (1):
      media: tvp5150: fix width alignment during set_selection()

Martin Willi (1):
      ath10k: schedule hardware restart if WMI command times out

Masami Hiramatsu (2):
      selftests: ftrace: Add synthetic event syntax testcase
      kprobes: Return error if we fail to reuse kprobe instead of BUG_ON()

Mauro Carvalho Chehab (3):
      media: em28xx: use a default format if TRY_FMT fails
      media: em28xx: fix input name for Terratec AV 350
      media: em28xx: make v4l2-compliance happier by starting sequence on z=
ero

Max Filippov (3):
      xtensa: add NOTES section to the linker script
      xtensa: make sure bFLT stack is 16 byte aligned
      xtensa: fix boot parameters address translation

Michael Kelley (1):
      clockevents/drivers/i8253: Add support for PIT shutdown quirk

Michal Hocko (2):
      mm, elf: handle vm_brk error
      mm: do not bug_on on incorrect length in __mm_populate()

Mike Kravetz (3):
      hugetlbfs: dirty pages as they are added to pagecache
      hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!
      mm: migration: fix migration of huge PMD shared pages

Miklos Szeredi (3):
      fuse: fix blocked_waitq wakeup
      fuse: set FR_SENT while locked
      fuse: fix leaked notify reply

Mikulas Patocka (2):
      mach64: fix display corruption on big endian machines
      mach64: fix image corruption due to reading accelerator registers

Miles Chen (1):
      tty: check name length in tty_find_polling_driver()

Nathan Chancellor (1):
      net: qla3xxx: Remove overflowing shift statement

Nicholas Mc Guire (1):
      media: pci: cx23885: handle adding to list failure

Nicolas Pitre (1):
      Cramfs: fix abad comparison when wrap-arounds occur

Omar Sandoval (2):
      ataflop: fix error handling during setup
      swim: fix cleanup on setup error

Ondrej Mosnacek (1):
      crypto: lrw - Fix out-of bounds access on counter overflow

Oscar Salvador (1):
      fs, elf: make sure to page align bss in load_elf_library

Paul Cercueil (1):
      dmaengine: dma-jz4780: Return error if not probed from DT

Phil Elwell (1):
      sc16is7xx: Fix for multi-channel stall

Qu Wenruo (3):
      btrfs: Handle owner mismatch gracefully when walking up tree
      btrfs: locking: Add extra check in btrfs_init_new_buffer() to avoid d=
eadlock
      btrfs: qgroup: Dirty all qgroups before rescan

Sanskriti Sharma (2):
      perf tools: Free temporary 'sys' string in read_event_files()
      perf tools: Cleanup trace-event-info 'tdata' leak

Sebastian Andrzej Siewior (1):
      x86/fpu: Remove second definition of fpu in __fpu__restore_sig()

Serhey Popovych (1):
      tun: Consistently configure generic netdev params via rtnetlink

Shaohua Li (2):
      MD: fix invalid stored role for a disk
      MD: fix invalid stored role for a disk - try2

Stanislav Lisovskiy (1):
      drm/dp_mst: Check if primary mstb is null

Stefan Nuernberger (1):
      net/ipv4: defensive cipso option parsing

Stephen Boyd (1):
      pinctrl: qcom: spmi-mpp: Fix drive strength setting

Steve French (3):
      smb3: allow stats which track session and share reconnects to be reset
      smb3: do not attempt cifs operation in smb3 query info error path
      smb3: on kerberos mount if server doesn't specify auth type use krb5

Takashi Iwai (1):
      ALSA: hda: Check the non-cached stream buffers more explicitly

Tang Junhui (1):
      bcache: fix miss key refill->end in writeback

Theodore Ts'o (4):
      ext4: fix argument checking in EXT4_IOC_MOVE_EXT
      ext4: avoid running out of journal credits when appending to an inlin=
e file
      ext4: avoid possible double brelse() in add_new_gdb() on error path
      ext4: fix possible leak of sbi->s_group_desc_leak in error path

Thor Thayer (1):
      arm64: dts: stratix10: Correct System Manager register size

Tomi Valkeinen (1):
      drm/omap: fix memory barrier bug in DMM driver

Trond Myklebust (2):
      NFSv4.1: Fix the r/wsize checking
      nfsd: Fix an Oops in free_session()

Vasily Averin (10):
      ext4: add missing brelse() update_backups()'s error path
      ext4: add missing brelse() in set_flexbg_block_bitmap()'s error path
      ext4: add missing brelse() add_new_gdb_meta_bg()'s error path
      ext4: avoid potential extra brelse in setup_new_flex_group_blocks()
      ext4: fix possible inode leak in the retry loop of ext4_resize_fs()
      ext4: avoid buffer leak in ext4_orphan_add() after prior errors
      ext4: fix missing cleanup if ext4_alloc_flex_bg_array() fails while r=
esizing
      ext4: release bs.bh before re-using in ext4_xattr_block_find()
      ext4: fix buffer leak in ext4_xattr_move_to_block() on error path
      ext4: fix buffer leak in __ext4_read_dirblock() on error path

Vincenzo Maffione (1):
      e1000: fix race condition between e1000_down() and e1000_watchdog

Waiman Long (2):
      locking/lockdep: Fix debug_locks off performance problem
      driver/dma/ioat: Call del_timer_sync() without holding prep_lock

Wenwen Wang (2):
      scsi: megaraid_sas: fix a missing-check bug
      dm ioctl: harden copy_params()'s copy_from_user() from malicious users

Young_X (1):
      cdrom: fix improper type cast, which can leat to information leak.

Yu Zhao (1):
      mmc: sdhci-pci-o2micro: Add quirk for O2 Micro dev 0x8620 rev 0x01

YueHaibing (1):
      pinctrl: qcom: spmi-mpp: Fix err handling of pmic_mpp_set_mux


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlv1NDEACgkQONu9yGCS
aT7rUhAAyqhuI0vZ8bdteaoK8O0Z0bU/cLbqQfbCC6klribgoYfGanDu5w3bBC1M
SGRDo/YQ664Z7ajvItfK2xPPCgkZlXRBS8gyBBFaqwHMuG6OLR+Zc19T0aBejsCa
VXTr/XtKR9XQBabVbTdeWiQROWCEqAQhPPktLrulUEkc5orPo97sth/MK2o9IVw8
/OnYg/v9SScBAKmJo52rsRy6TPeArgkjz9PAgjg9IAcOckoNgPleN/zNAhIQAUqY
bQbGaD7Qzwfi+F9w2WUQgvwwbatFjKApSTFimFDtUeh59U5kJIOcQignh7xEBKFf
x+htJu/prMnjFNt19ekVhyleT8a/GL3VSWo8TT7PaZM4P8GsxRZZ46Gds0pQSN41
6eOeaNJfGZtx/iPrwFGDX1MY3pRj/RkcyjylgHzWMz/VuqeRfnU6UpPnAPLIi+Wr
+1SDDnUu8hd+Z9aehwlKlfq+K5zuFA73hSLeXb4aZwoRUGWugndNnCz7JHXBhSpR
42gA9I6HaO0v8GKolL0yYldajJ6Akx/GJv/Zm4HHYv2Ry8IRytnq4DLLsjRNqNcf
4Va5EAwgapaSZhPEuxA6+xudxQOQHYIdOt4rtL+k6o8oAcQCyMvcEuUklBWbsNhR
F1xnBep4bA3jTVF+nUd+D9vz4Yoqv+YQmWA9adkAIK+ntIpbNlY=
=j9lm
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
