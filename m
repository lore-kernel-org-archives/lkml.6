Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47549C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB94124A3A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB94124A3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeGCL3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:29:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752949AbeGCL3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:29:07 -0400
Received: from localhost (mobile-166-137-176-030.mycingular.net [166.137.176.30])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5FFADF34;
        Tue,  3 Jul 2018 11:29:04 +0000 (UTC)
Date:   Tue, 3 Jul 2018 13:27:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.114
Message-ID: <20180703112754.GA17985@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.114 kernel.

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
                |    7 -
 arch/arm/boot/compressed/head.S                                           =
                |   16 +--
 arch/arm/include/asm/kgdb.h                                               =
                |    2=20
 arch/arm/mach-davinci/board-dm355-evm.c                                   =
                |    6 +
 arch/arm/mach-davinci/board-dm646x-evm.c                                  =
                |    3=20
 arch/arm/mach-keystone/pm_domain.c                                        =
                |    1=20
 arch/arm64/kernel/ptrace.c                                                =
                |    6 -
 arch/hexagon/include/asm/io.h                                             =
                |    6 +
 arch/hexagon/lib/checksum.c                                               =
                |    1=20
 arch/m68k/mm/kmap.c                                                       =
                |    3=20
 arch/mips/bcm47xx/setup.c                                                 =
                |    6 +
 arch/mips/include/asm/io.h                                                =
                |    4=20
 arch/mips/include/asm/mipsregs.h                                          =
                |    3=20
 arch/mips/kernel/mcount.S                                                 =
                |   27 ++----
 arch/parisc/kernel/time.c                                                 =
                |    2=20
 arch/powerpc/kernel/entry_64.S                                            =
                |    1=20
 arch/powerpc/kernel/fadump.c                                              =
                |    3=20
 arch/powerpc/kernel/hw_breakpoint.c                                       =
                |    4=20
 arch/powerpc/kernel/ptrace.c                                              =
                |    1=20
 arch/x86/kernel/cpu/intel.c                                               =
                |    3=20
 arch/xtensa/kernel/traps.c                                                =
                |    2=20
 drivers/ata/libata-core.c                                                 =
                |    3=20
 drivers/ata/libata-eh.c                                                   =
                |    4=20
 drivers/ata/libata-zpodd.c                                                =
                |    4=20
 drivers/char/agp/uninorth-agp.c                                           =
                |    4=20
 drivers/char/ipmi/ipmi_bt_sm.c                                            =
                |    3=20
 drivers/gpu/drm/msm/msm_gem.c                                             =
                |   20 ++--
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c                                  =
                |    6 +
 drivers/i2c/busses/i2c-pmcmsp.c                                           =
                |    4=20
 drivers/i2c/busses/i2c-viperboard.c                                       =
                |    2=20
 drivers/md/dm-thin.c                                                      =
                |   11 ++
 drivers/media/dvb-core/dvb_frontend.c                                     =
                |   23 +++--
 drivers/media/usb/cx231xx/cx231xx-cards.c                                 =
                |    3=20
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c                             =
                |    2=20
 drivers/mtd/chips/cfi_cmdset_0002.c                                       =
                |   21 ++--
 drivers/net/can/dev.c                                                     =
                |    2=20
 drivers/net/phy/marvell.c                                                 =
                |    9 ++
 drivers/pci/hotplug/pciehp.h                                              =
                |    2=20
 drivers/pci/hotplug/pciehp_core.c                                         =
                |    2=20
 drivers/pci/hotplug/pciehp_hpc.c                                          =
                |   13 ++
 drivers/s390/net/smsgiucv.c                                               =
                |    2=20
 drivers/scsi/isci/port_config.c                                           =
                |    3=20
 drivers/scsi/qla2xxx/qla_init.c                                           =
                |    3=20
 drivers/scsi/scsi_transport_iscsi.c                                       =
                |   29 ++++--
 drivers/scsi/vmw_pvscsi.c                                                 =
                |    2=20
 drivers/usb/core/hub.c                                                    =
                |    4=20
 drivers/usb/musb/musb_host.c                                              =
                |    5 -
 drivers/usb/musb/musb_host.h                                              =
                |    7 +
 drivers/usb/musb/musb_virthub.c                                           =
                |   25 +++--
 drivers/video/backlight/as3711_bl.c                                       =
                |   33 +++++--
 drivers/video/backlight/max8925_bl.c                                      =
                |    4=20
 drivers/video/backlight/tps65217_bl.c                                     =
                |    4=20
 drivers/video/fbdev/uvesafb.c                                             =
                |    3=20
 drivers/w1/masters/mxc_w1.c                                               =
                |   20 ++--
 drivers/xen/events/events_base.c                                          =
                |    2=20
 fs/binfmt_misc.c                                                          =
                |   12 ++
 fs/btrfs/scrub.c                                                          =
                |    2=20
 fs/ext4/inode.c                                                           =
                |   36 ++++----
 fs/ext4/resize.c                                                          =
                |    2=20
 fs/fuse/dir.c                                                             =
                |   13 ++
 fs/fuse/inode.c                                                           =
                |    1=20
 fs/isofs/inode.c                                                          =
                |    3=20
 fs/nfsd/nfs4xdr.c                                                         =
                |    5 -
 fs/notify/fsnotify.c                                                      =
                |   25 ++---
 fs/ubifs/journal.c                                                        =
                |    2=20
 fs/udf/directory.c                                                        =
                |    3=20
 include/linux/blkdev.h                                                    =
                |    4=20
 include/linux/compiler.h                                                  =
                |    2=20
 kernel/kthread.c                                                          =
                |    7 -
 kernel/time/time.c                                                        =
                |    6 -
 net/ipv4/tcp_input.c                                                      =
                |    2=20
 net/key/af_key.c                                                          =
                |   45 +++++++---
 net/mac80211/mlme.c                                                       =
                |   25 ++++-
 net/rds/ib_cm.c                                                           =
                |    3=20
 sound/pci/hda/hda_controller.c                                            =
                |    4=20
 sound/soc/cirrus/edb93xx.c                                                =
                |    2=20
 sound/soc/cirrus/ep93xx-i2s.c                                             =
                |   26 +++--
 sound/soc/cirrus/snappercl15.c                                            =
                |    2=20
 sound/soc/soc-dapm.c                                                      =
                |    2=20
 tools/Makefile                                                            =
                |   20 +++-
 tools/net/bpf_dbg.c                                                       =
                |    7 +
 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-ac=
tions-accept.tc |   44 +++++++++
 82 files changed, 466 insertions(+), 230 deletions(-)

Alexander Sverdlin (2):
      ASoC: cirrus: i2s: Fix LRCLK configuration
      ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData setup

Amir Goldstein (1):
      fsnotify: fix ignore mask logic in send_to_group()

Aneesh Kumar K.V (1):
      powerpc/mm/hash: Add missing isync prior to kernel stack SLB switch

Arnd Bergmann (2):
      hexagon: add memset_io() helper
      hexagon: export csum_partial_copy_nocheck

Baolin Wang (1):
      parisc: time: Convert read_persistent_clock() to read_persistent_cloc=
k64()

Ben Hutchings (1):
      drm/msm: Fix possible null dereference on failure of get_pages()

Bo Chen (1):
      ALSA: hda - Handle kzalloc() failure in snd_hda_attach_pcm_stream()

Boris Ostrovsky (1):
      xen: Remove unnecessary BUG_ON from __unbind_from_irq()

Chengguang Xu (1):
      isofs: fix potential memory leak in mount option parsing

Chris Leech (1):
      scsi: iscsi: respond to netlink with unicast when appropriate

Colin Ian King (2):
      scsi: isci: Fix infinite loop in while loop
      libata: zpodd: make arrays cdb static, reduces object code size

Corey Minyard (1):
      ipmi:bt: Set the timeout before doing a capabilities check

Dag Moxnes (1):
      rds: ib: Fix missing call to rds_ib_dev_put in rds_ib_setup_qp

Dan Carpenter (1):
      libata: zpodd: small read overflow in eject_tray()

Daniel Gl=C3=B6ckner (1):
      usb: musb: fix remote wakeup racing with suspend

David Rivshin (1):
      ARM: 8764/1: kgdb: fix NUMREGBYTES so that gdb_regs[] is the correct =
size

Eric Dumazet (1):
      tcp: do not overshoot window_clamp in tcp_rcv_space_adjust()

Eric W. Biederman (1):
      signal/xtensa: Consistenly use SIGBUS in do_unaligned_user

Geert Uytterhoeven (1):
      time: Make sure jiffies_to_msecs() preserves non-zero time periods

Greg Kroah-Hartman (1):
      Linux 3.18.114

Hans de Goede (1):
      libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk

Himanshu Madhani (1):
      scsi: qla2xxx: Fix setting lower transfer speed if GPSC fails

Huacai Chen (1):
      MIPS: io: Add barrier after register read in inX()

Ilan Peer (1):
      mac80211: Adjust SAE authentication timeout

Jakob Unterwurzacher (1):
      can: dev: increase bus-off message severity

Jan Kara (2):
      ext4: fix fencepost error in check for inode count overflow during re=
size
      udf: Detect incorrect directory size

Jim Gill (1):
      scsi: vmw-pvscsi: return DID_BUS_BUSY for adapter-initated aborts

Jingju Hou (1):
      net: phy: marvell: clear wol event before setting it

Jiri Olsa (2):
      tools build: No need to make libapi for perf explicitly
      tools build: Fix Makefile(s) to properly invoke tools build

Joakim Tjernlund (4):
      mtd: cfi_cmdset_0002: Use right chip in do_ppb_xxlock()
      mtd: cfi_cmdset_0002: fix SEGV unlocking multiple chips
      mtd: cfi_cmdset_0002: Fix unlocking requests crossing a chip boudary
      mtd: cfi_cmdset_0002: Avoid walking all chips when unlocking.

Johan Hovold (3):
      backlight: as3711_bl: Fix Device Tree node lookup
      backlight: max8925_bl: Fix Device Tree node lookup
      backlight: tps65217_bl: Fix Device Tree node lookup

John Fastabend (1):
      bpf: fix uninitialized variable in bpf tools

Kai-Heng Feng (1):
      media: cx231xx: Add support for AverMedia DVD EZMaker 7

Kees Cook (1):
      video: uvesafb: Fix integer overflow in allocation

Keith Busch (1):
      block: Fix transfer when chunk sectors exceeds max

Kevin Easton (1):
      af_key: Always verify length of provided sadb_key

Lukas Czerner (1):
      ext4: update mtime in ext4_punch_hole even if no blocks are released

Mahesh Salgaonkar (1):
      powerpc/fadump: Unregister fadump on kexec down path.

Mark Rutland (1):
      arm64: ptrace: remove addr_limit manipulation

Martin Schwidefsky (1):
      s390/smsgiucv: disable SMSG on module unload

Masami Hiramatsu (1):
      selftests: ftrace: Add a testcase for multiple actions on trigger

Mathieu Malaterre (2):
      driver core: add __printf verification to __ata_ehi_pushv_desc
      agp: uninorth: make two functions static

Matthias Schiffer (1):
      mips: ftrace: fix static function graph tracing

Mauro Carvalho Chehab (2):
      media: v4l2-compat-ioctl32: prevent go past max size
      media: dvb_frontend: fix locking issues at dvb_frontend_get_event()

Maxim Moseychuk (1):
      usb: do not reset if a low-speed or full-speed device timed out

Michael Neuling (2):
      powerpc/ptrace: Fix setting 512B aligned breakpoints with PTRACE_SET_=
DEBUGREG
      powerpc/ptrace: Fix enforcement of DAWR constraints

Michael Schmitz (1):
      m68k/mm: Adjust VM area to be unmapped by gap size for __iounmap()

Mika Westerberg (1):
      PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed=
 on resume

Mike Snitzer (1):
      dm thin: handle running out of data space vs concurrent discard

Miklos Szeredi (1):
      fuse: atomic_o_trunc should truncate pagecache

Mikulas Patocka (1):
      branch-check: fix long->int truncation when profiling branches

Peter Rosin (3):
      i2c: pmcmsp: return message count on master_xfer success
      i2c: pmcmsp: fix error return from master_xfer
      i2c: viperboard: return message count on master_xfer success

Peter Zijlstra (1):
      kthread, sched/wait: Fix kthread_parkme() wait-loop

Qu Wenruo (1):
      btrfs: scrub: Don't use inode pages for device replace

Russell King (1):
      ARM: keystone: fix platform_domain_notifier array overrun

Scott Mayhew (1):
      nfsd: restrict rd_maxcount to svc_max_payload in nfsd_encode_readdir

Sekhar Nori (2):
      ARM: davinci: board-dm355-evm: fix broken networking
      ARM: davinci: board-dm646x-evm: set VPIF capture card name

Silvio Cesare (1):
      UBIFS: Fix potential integer overflow in allocation

Sinan Kaya (1):
      MIPS: io: Add barrier after register read in readX()

Srinivas Kandagatla (1):
      ASoC: dapm: delete dapm_kcontrol_data paths list before freeing it

Stefan Potyra (1):
      w1: mxc_w1: Enable clock before calling clk_get_rate() on it

Tetsuo Handa (1):
      fuse: don't keep dead fuse_conn at fuse_fill_super().

Thadeu Lima de Souza Cascardo (1):
      fs/binfmt_misc.c: do not allow offset overflow

Tokunori Ikegami (2):
      mtd: cfi_cmdset_0002: Change write buffer to check correct value
      MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum

Tomi Valkeinen (1):
      drm/omap: fix possible NULL ref issue in tiler_reserve_2d

jacek.tomaka@poczta.fm (1):
      x86/cpu/intel: Add missing TLB cpuid values

=C5=81ukasz Stelmach (1):
      ARM: 8753/1: decompressor: add a missing parameter to the addruart ma=
cro


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAls7XbYACgkQONu9yGCS
aT4sxxAAmvFX6Q6qWKAhiW3JIZhLKwXrVPjLTW3kt+HY+xT4qIqwHDIJgGoyzDmW
rjJGDvD44C9f5Hs1kd1k0LasGZiIE/nmuMhN6hObL/HEVugND1Dnq4JNWd10UVRH
5r4sGx6TCb7E10ISipFtX4zzg08MV885BsC9+6DF2wCpVBdlRb0Zgd0mng19d+nD
JB7YJmVyca6DDkAvqD0RpgKDbV9aaAEYZDQOSIUMChKi9CzanfP/yXcXWUYMPH1O
CIki+8l8kffjg0ua6OVdqo1iRE7GMHmEh+0rNa1lw8wjf8sRb0kb9/7CnoZpl9Sw
zEEqzfRGxw7Vh8NRVePIL0J9el5Foun7kJpdskMe1Us/1mHLepULqMWWe2mrFot/
rZs2FEtCmCmMNDQ2Hx4YhqcYcn9dIqCkrfB8MiOw+KBbc0BhQ9ZVmhkDPDuaSPp6
1KfHimYvb/Xdco5mr48pjL98d3ZsscLk5KkF4GBklBqXmokLY6n+rBQ1qu95EMDv
FUnHcFcPGNn7gXhzq9FtWnKf0OlukQyvOPeTtvYwZ112A+0KZDGBCwlTbae+/Rhb
9CyZEYwLg6qYx5mB7NzofDbM2uM8zLVOCkpCaDs2rAfmLBh0Y4muF0uKF/7rw/Zc
7uKaK62aZxcKWmHoOwOLtJwYsAAoiGJkHMS5FREUmI+5/be5YP4=
=5BfH
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
