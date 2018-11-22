Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9C1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F87320864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdWJH8G0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F87320864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392950AbeKVTDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:03:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbeKVTDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:03:23 -0500
Received: from localhost (unknown [95.99.132.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDBF220864;
        Thu, 22 Nov 2018 08:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542875099;
        bh=rjiI4cO/X+vhPnNNXB13dR1Vf3zMkwPweJ7ow4sBLHc=;
        h=Date:From:To:Cc:Subject:From;
        b=EdWJH8G0Tyo3uYKt8a/GHd/A9xJ7DDcsbpJbWlf9Ffu6X1z/LJafo2b5QWSg16Ixa
         q7PzKpShfMvRLKjzX6RQ9AOUkPqL2v2xc4O4zriSEaLnNWRiK5BPeZogwcyIIJGZ3O
         6e5E1mh8+2/ypIwP0oYWwmwHe52QoAV1tnseiuME=
Date:   Thu, 22 Nov 2018 09:24:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.126
Message-ID: <20181122082452.GA20754@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.126 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
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
 arch/mips/kernel/crash.c                                                  =
                  |    3=20
 arch/mips/kernel/machine_kexec.c                                          =
                  |    3=20
 arch/powerpc/boot/crt0.S                                                  =
                  |    4=20
 arch/powerpc/mm/tlb_nohash.c                                              =
                  |    3=20
 arch/sparc/kernel/perf_event.c                                            =
                  |   26 ++-
 arch/x86/boot/tools/build.c                                               =
                  |    7=20
 arch/x86/kernel/check.c                                                   =
                  |   15 +
 arch/xtensa/kernel/head.S                                                 =
                  |    7=20
 crypto/lrw.c                                                              =
                  |    7=20
 drivers/block/ataflop.c                                                   =
                  |   25 +--
 drivers/block/swim.c                                                      =
                  |   13 +
 drivers/cdrom/cdrom.c                                                     =
                  |    2=20
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c                                  =
                  |   11 +
 drivers/iio/adc/at91_adc.c                                                =
                  |    6=20
 drivers/md/bcache/btree.c                                                 =
                  |    2=20
 drivers/md/dm-ioctl.c                                                     =
                  |   18 --
 drivers/md/dm.c                                                           =
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
 drivers/net/ethernet/qlogic/qla3xxx.c                                     =
                  |    2=20
 drivers/net/tun.c                                                         =
                  |    2=20
 drivers/net/wireless/ath/ath10k/wmi.c                                     =
                  |    6=20
 drivers/pcmcia/ricoh.h                                                    =
                  |   35 ++++
 drivers/pcmcia/yenta_socket.c                                             =
                  |    3=20
 drivers/scsi/esp_scsi.c                                                   =
                  |    1=20
 drivers/scsi/esp_scsi.h                                                   =
                  |    2=20
 drivers/scsi/lpfc/lpfc_sli.c                                              =
                  |    7=20
 drivers/scsi/mac_esp.c                                                    =
                  |    2=20
 drivers/tc/tc.c                                                           =
                  |    8 -
 drivers/tty/serial/kgdboc.c                                               =
                  |    5=20
 drivers/tty/tty_io.c                                                      =
                  |    2=20
 drivers/tty/tty_ioctl.c                                                   =
                  |    4=20
 drivers/uio/uio.c                                                         =
                  |    9 +
 drivers/usb/chipidea/otg.h                                                =
                  |    3=20
 drivers/video/fbdev/aty/mach64_accel.c                                    =
                  |   28 +--
 drivers/w1/masters/omap_hdq.c                                             =
                  |    2=20
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
 fs/ext4/inline.c                                                          =
                  |    2=20
 fs/ext4/move_extent.c                                                     =
                  |    8 -
 fs/ext4/namei.c                                                           =
                  |    5=20
 fs/ext4/resize.c                                                          =
                  |   28 ++-
 fs/ext4/super.c                                                           =
                  |   16 +-
 fs/ext4/xattr.c                                                           =
                  |    4=20
 fs/fuse/dev.c                                                             =
                  |    4=20
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
 include/linux/tc.h                                                        =
                  |    1=20
 kernel/bounds.c                                                           =
                  |    4=20
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
 mm/hugetlb.c                                                              =
                  |   23 ++
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
 tools/perf/util/trace-event-info.c                                        =
                  |    2=20
 tools/perf/util/trace-event-read.c                                        =
                  |    5=20
 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-syntheti=
c-event-syntax.tc |   80 ++++++++++
 83 files changed, 540 insertions(+), 159 deletions(-)

Al Viro (1):
      gfs2_meta: ->mount() can get NULL dev_name

Alex Stanoev (1):
      ALSA: ca0106: Disable IZD on SB0570 DAC to fix audio pops

Alexandre Belloni (1):
      uio: ensure class is registered before devices

Amir Goldstein (1):
      lockd: fix access beyond unterminated strings in prints

Andreas Kemnade (1):
      w1: omap-hdq: fix missing bus unregister at removal

Arnd Bergmann (2):
      kbuild: fix kernel/bounds.c 'W=3D1' warning
      mtd: docg3: don't set conflicting BCH_CONST_PARAMS option

Ben Hutchings (1):
      x86: boot: Fix EFI stub alignment

Changwei Ge (1):
      ocfs2: fix a misuse a of brelse after failing ocfs2_check_dir_entry

Corey Wright (1):
      dm: remove duplicate dm_get_live_table() in __dm_destroy()

Daniel Axtens (1):
      powerpc/nohash: fix undefined behaviour when testing page size support

David S. Miller (2):
      sparc: Fix single-pcr perf event counter management.
      sparc: Throttle perf events properly.

Dengcheng Zhu (1):
      MIPS: kexec: Mark CPU offline before disabling local IRQ

Dominique Martinet (1):
      9p: clear dangling pointers in p9stat_free

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

Finn Thain (1):
      scsi: esp_scsi: Track residual for PIO transfers

Frank Sorenson (1):
      sunrpc: correct the computation for page_ptr when truncating

Greg Kroah-Hartman (1):
      Linux 3.18.126

Guenter Roeck (1):
      configfs: replace strncpy with memcpy

H. Peter Anvin (1):
      termios, tty/tty_baudrate.c: fix buffer overrun

H. Peter Anvin (Intel) (1):
      arch/alpha, termios: implement BOTHER, IBSHIFT and termios2

He Zhe (3):
      x86/corruption-check: Fix panic in memory_corruption_check() when boo=
t option without value is provided
      printk: Fix panic caused by passing log_buf_len to command line
      kgdboc: Passing ekgdboc to command line causes panic

Hou Tao (1):
      jffs2: free jffs2_sb_info through jffs2_kill_sb()

Ilya Dryomov (1):
      libceph: bump CEPH_MSG_MAX_DATA_LEN

James Smart (1):
      scsi: lpfc: Correct soft lockup when running mds diagnostics

Jan Kara (1):
      jbd2: fix use after free in jbd2_log_do_checkpoint()

Joel Stanley (1):
      powerpc/boot: Ensure _zimage_start is a weak symbol

Loic Poulain (1):
      usb: chipidea: Prevent unbalanced IRQ disable

Lukas Czerner (1):
      ext4: initialize retries variable in ext4_da_write_inline_data_begin()

Maciej S. Szmigiero (1):
      pcmcia: Implement CLKRUN protocol disabling for Ricoh bridges

Maciej W. Rozycki (1):
      TC: Set DMA masks for devices

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

Max Filippov (1):
      xtensa: fix boot parameters address translation

Mike Kravetz (1):
      hugetlbfs: fix kernel BUG at fs/hugetlbfs/inode.c:444!

Miklos Szeredi (1):
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

Sanskriti Sharma (2):
      perf tools: Free temporary 'sys' string in read_event_files()
      perf tools: Cleanup trace-event-info 'tdata' leak

Serhey Popovych (1):
      tun: Consistently configure generic netdev params via rtnetlink

Stefan Nuernberger (1):
      net/ipv4: defensive cipso option parsing

Steve French (3):
      smb3: allow stats which track session and share reconnects to be reset
      smb3: do not attempt cifs operation in smb3 query info error path
      smb3: on kerberos mount if server doesn't specify auth type use krb5

Tang Junhui (1):
      bcache: fix miss key refill->end in writeback

Theodore Ts'o (3):
      ext4: fix argument checking in EXT4_IOC_MOVE_EXT
      ext4: avoid possible double brelse() in add_new_gdb() on error path
      ext4: fix possible leak of sbi->s_group_desc_leak in error path

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

Waiman Long (1):
      locking/lockdep: Fix debug_locks off performance problem

Wenwen Wang (1):
      dm ioctl: harden copy_params()'s copy_from_user() from malicious users

Young_X (1):
      cdrom: fix improper type cast, which can leat to information leak.

Yu Zhao (1):
      mmc: sdhci-pci-o2micro: Add quirk for O2 Micro dev 0x8620 rev 0x01


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlv2Z9IACgkQONu9yGCS
aT6o1g//eLsoOiK9OoHOMwrWoTmA8l5PTfoQESJeQD2BMdB0/SmVobFAH4MQ+HtJ
g8yulhqD0lXmrxdgAjsidMEj8oTb0Qn3PJd1ZucvSEnlnMguc6ZX3CaGKrAFwA+Q
yjy7BZ9ImL1MUMwhAFlUbncQNmh/RKCmSzTJR1lN8i8LKi6bQqKvu+5p+QM6Gaet
QaYy5c7byCwIn/w4MfteQ0xQOmZqtrY14wPKZxwZ/Rj2FWF7OgImE4ZcOd6IJEBv
Th7wPZXscUHDd33GWu1y2HbtojNb3bVXL6PZwOUg2vNTixYhlgYfJ0HNMbZe/q/7
1uk6akiRTZjtwpfH1iCkF6wgr/TH8DRimcUVTqRWHw1D3YrfV+/hlhfFbavH+NDm
lYdaiOlzgyCm4+iztcWmRF0ntejuAad4EC+kXniD05DUnr5VuF+Qq3qTAFAkYnEW
zJSL7Y39mgsWoV8xvuo+tQsslxQto0VTJKhYevpBhC4e48ZduY3okmsb3w442lsP
WAso8/b5W1RMbQfYm4ve5CzwOTvbaXBig+Gr1TWCSglKHsUHFOKOAAXFgcg572QJ
i9eiXLpArIrmRtfIX80PzTswkR7fl47QyesKkT/ri0fwy4vRa8yVPViru3BwR1vI
t4yiDcjcRSrRNtaE8vGvqVrXhdHyArfg1jXWP/UL2f4qU+bvtrs=
=a6t3
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
