Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F12C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706DF24A3A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706DF24A3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeGCL3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:29:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbeGCL3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:29:20 -0400
Received: from localhost (mobile-166-137-176-030.mycingular.net [166.137.176.30])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7DB73F3C;
        Tue,  3 Jul 2018 11:29:17 +0000 (UTC)
Date:   Tue, 3 Jul 2018 13:28:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.139
Message-ID: <20180703112832.GA18109@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.139 kernel.

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

 Documentation/printk-formats.txt                        |    3=20
 Makefile                                                |    2=20
 arch/arm/include/asm/kgdb.h                             |    2=20
 arch/m68k/mm/kmap.c                                     |    3=20
 arch/mips/bcm47xx/setup.c                               |    6=20
 arch/mips/include/asm/io.h                              |    2=20
 arch/mips/include/asm/mipsregs.h                        |    3=20
 arch/mips/kernel/mcount.S                               |   27 +--
 arch/powerpc/kernel/entry_64.S                          |    1=20
 arch/powerpc/kernel/fadump.c                            |    3=20
 arch/powerpc/kernel/hw_breakpoint.c                     |    4=20
 arch/powerpc/kernel/ptrace.c                            |    1=20
 arch/x86/include/asm/barrier.h                          |    2=20
 arch/xtensa/kernel/traps.c                              |    2=20
 drivers/ata/libata-core.c                               |    3=20
 drivers/ata/libata-zpodd.c                              |    4=20
 drivers/atm/zatm.c                                      |    4=20
 drivers/base/core.c                                     |   14 +
 drivers/bluetooth/hci_qca.c                             |    6=20
 drivers/char/ipmi/ipmi_bt_sm.c                          |    3=20
 drivers/cpufreq/cpufreq.c                               |    2=20
 drivers/cpuidle/cpuidle-powernv.c                       |   32 +++-
 drivers/iio/buffer/kfifo_buf.c                          |    4=20
 drivers/infiniband/hw/mlx4/mad.c                        |    1=20
 drivers/infiniband/hw/qib/qib.h                         |    3=20
 drivers/infiniband/hw/qib/qib_file_ops.c                |   10 -
 drivers/infiniband/hw/qib/qib_user_pages.c              |   20 +-
 drivers/input/mouse/elan_i2c.h                          |    2=20
 drivers/input/mouse/elan_i2c_core.c                     |    3=20
 drivers/input/mouse/elan_i2c_smbus.c                    |   10 +
 drivers/input/mouse/elantech.c                          |   11 +
 drivers/md/dm-thin.c                                    |   11 +
 drivers/md/md.c                                         |    4=20
 drivers/media/dvb-core/dvb_frontend.c                   |   23 +-
 drivers/media/usb/cx231xx/cx231xx-cards.c               |    3=20
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c           |    2=20
 drivers/mfd/intel-lpss.c                                |    4=20
 drivers/mtd/chips/cfi_cmdset_0002.c                     |   21 +-
 drivers/mtd/ubi/build.c                                 |    3=20
 drivers/mtd/ubi/wl.c                                    |    4=20
 drivers/net/bonding/bond_options.c                      |    1=20
 drivers/net/ethernet/natsemi/sonic.c                    |    2=20
 drivers/net/usb/cdc_ncm.c                               |    4=20
 drivers/net/usb/qmi_wwan.c                              |    1=20
 drivers/nvdimm/bus.c                                    |   14 +
 drivers/of/unittest.c                                   |    8 -
 drivers/pci/hotplug/pciehp.h                            |    2=20
 drivers/pci/hotplug/pciehp_core.c                       |    2=20
 drivers/pci/hotplug/pciehp_hpc.c                        |   13 +
 drivers/s390/scsi/zfcp_dbf.c                            |   40 +++++
 drivers/s390/scsi/zfcp_erp.c                            |  123 +++++++++++=
+----
 drivers/s390/scsi/zfcp_ext.h                            |    5=20
 drivers/s390/scsi/zfcp_scsi.c                           |   18 +-
 drivers/scsi/qla2xxx/qla_init.c                         |    3=20
 drivers/spi/spi.c                                       |   10 +
 drivers/tty/serial/sh-sci.c                             |    8 -
 drivers/usb/core/hub.c                                  |    4=20
 drivers/usb/musb/musb_host.c                            |    5=20
 drivers/usb/musb/musb_host.h                            |    7=20
 drivers/usb/musb/musb_virthub.c                         |   25 +--
 drivers/video/backlight/as3711_bl.c                     |   33 ++--
 drivers/video/backlight/max8925_bl.c                    |    4=20
 drivers/video/backlight/tps65217_bl.c                   |    4=20
 drivers/video/fbdev/uvesafb.c                           |    3=20
 drivers/w1/masters/mxc_w1.c                             |   20 +-
 drivers/w1/w1.c                                         |    2=20
 drivers/xen/events/events_base.c                        |    2=20
 fs/binfmt_misc.c                                        |   12 +
 fs/btrfs/inode.c                                        |   33 +++-
 fs/btrfs/ioctl.c                                        |   12 -
 fs/btrfs/scrub.c                                        |    2=20
 fs/ext4/inode.c                                         |   36 ++--
 fs/ext4/resize.c                                        |    2=20
 fs/fuse/control.c                                       |   13 +
 fs/fuse/dir.c                                           |   13 +
 fs/fuse/inode.c                                         |    1=20
 fs/nfs/nfs4idmap.c                                      |    5=20
 fs/nfsd/nfs4xdr.c                                       |    5=20
 fs/ubifs/journal.c                                      |    2=20
 fs/udf/directory.c                                      |    3=20
 include/linux/blkdev.h                                  |    4=20
 include/linux/compiler.h                                |    2=20
 include/linux/iio/buffer.h                              |    6=20
 include/net/bluetooth/hci_core.h                        |    2=20
 kernel/time/time.c                                      |    6=20
 lib/vsprintf.c                                          |    3=20
 net/bluetooth/hci_conn.c                                |   27 ++-
 net/bluetooth/hci_event.c                               |   15 +
 net/bridge/netfilter/ebtables.c                         |    3=20
 net/ipv4/tcp_input.c                                    |    2=20
 net/ipv4/tcp_ipv4.c                                     |    4=20
 net/ipv6/tcp_ipv6.c                                     |    4=20
 net/ipv6/xfrm6_policy.c                                 |    2=20
 net/netfilter/ipvs/ip_vs_ctl.c                          |   21 +-
 net/xfrm/xfrm_policy.c                                  |    5=20
 sound/pci/hda/hda_controller.c                          |    4=20
 sound/pci/hda/patch_conexant.c                          |    2=20
 sound/pci/hda/patch_realtek.c                           |    1=20
 sound/soc/cirrus/edb93xx.c                              |    2=20
 sound/soc/cirrus/ep93xx-i2s.c                           |   26 +--
 sound/soc/cirrus/snappercl15.c                          |    2=20
 sound/soc/soc-dapm.c                                    |    2=20
 tools/perf/util/dso.c                                   |    2=20
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c     |   23 ++
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h     |    9 +
 tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c |    2=20
 tools/perf/util/intel-pt.c                              |    5=20
 107 files changed, 684 insertions(+), 272 deletions(-)

??? (1):
      Input: elantech - fix V4 report decoding for module with middle key

Aaron Ma (1):
      Input: elantech - enable middle button of touchpads on ThinkPad P52

Adrian Hunter (6):
      perf tools: Fix symbol and object code resolution for vdso32 and vdso=
x32
      perf intel-pt: Fix sync_switch INTEL_PT_SS_NOT_TRACING
      perf intel-pt: Fix decoding to accept CBR between FUP and correspondi=
ng TIP
      perf intel-pt: Fix MTC timing after overflow
      perf intel-pt: Fix "Unexpected indirect branch" error
      perf intel-pt: Fix packet decoding of CYC packets

Alexander Sverdlin (2):
      ASoC: cirrus: i2s: Fix LRCLK configuration
      ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData setup

Alexandr Savca (1):
      Input: elan_i2c - add ELAN0618 (Lenovo v330 15IKB) ACPI ID

Amit Pundir (1):
      Bluetooth: hci_qca: Avoid missing rampatch failure with userspace fw =
loader

Andy Shevchenko (1):
      mfd: intel-lpss: Program REMAP register in PIO mode

Aneesh Kumar K.V (1):
      powerpc/mm/hash: Add missing isync prior to kernel stack SLB switch

Ben Hutchings (1):
      Input: elan_i2c_smbus - fix more potential stack buffer overflows

Bj=F8rn Mork (1):
      cdc_ncm: avoid padding beyond end of skb

Bo Chen (1):
      ALSA: hda - Handle kzalloc() failure in snd_hda_attach_pcm_stream()

Boris Ostrovsky (1):
      xen: Remove unnecessary BUG_ON from __unbind_from_irq()

Colin Ian King (1):
      libata: zpodd: make arrays cdb static, reduces object code size

Corey Minyard (1):
      ipmi:bt: Set the timeout before doing a capabilities check

Dan Carpenter (1):
      libata: zpodd: small read overflow in eject_tray()

Dan Williams (1):
      x86/spectre_v1: Disable compiler optimizations over array_index_mask_=
nospec()

Daniel Gl=F6ckner (1):
      usb: musb: fix remote wakeup racing with suspend

Daniel Wagner (1):
      serial: sh-sci: Use spin_{try}lock_irqsave instead of open coding ver=
sion

Dave Wysochanski (1):
      NFSv4: Fix possible 1-byte stack overflow in nfs_idmap_read_and_verif=
y_message

David Rivshin (1):
      ARM: 8764/1: kgdb: fix NUMREGBYTES so that gdb_regs[] is the correct =
size

Dennis Wassenberg (2):
      ALSA: hda: add dock and led support for HP EliteBook 830 G5
      ALSA: hda: add dock and led support for HP ProBook 640 G4

Eric Dumazet (2):
      xfrm6: avoid potential infinite loop in _decode_session6()
      tcp: do not overshoot window_clamp in tcp_rcv_space_adjust()

Eric W. Biederman (1):
      signal/xtensa: Consistenly use SIGBUS in do_unaligned_user

Finn Thain (1):
      net/sonic: Use dma_mapping_error()

Florian Westphal (1):
      xfrm: skip policies marked as dead while rehashing

Frank van der Linden (1):
      tcp: verify the checksum of the first data segment in a new connection

Gautham R. Shenoy (1):
      cpuidle: powernv: Fix promotion from snooze if next state disabled

Geert Uytterhoeven (2):
      lib/vsprintf: Remove atomic-unsafe support for %pCr
      time: Make sure jiffies_to_msecs() preserves non-zero time periods

Greg Kroah-Hartman (1):
      Linux 4.4.139

Hans de Goede (1):
      libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk

Himanshu Madhani (1):
      scsi: qla2xxx: Fix setting lower transfer speed if GPSC fails

Huacai Chen (1):
      MIPS: io: Add barrier after register read in inX()

Ingo Flaschberger (1):
      1wire: family module autoload fails because of upper/lower case misma=
tch.

Ivan Bornyakov (1):
      atm: zatm: fix memcmp casting

Jan Kara (2):
      ext4: fix fencepost error in check for inode count overflow during re=
size
      udf: Detect incorrect directory size

Joakim Tjernlund (4):
      mtd: cfi_cmdset_0002: Use right chip in do_ppb_xxlock()
      mtd: cfi_cmdset_0002: fix SEGV unlocking multiple chips
      mtd: cfi_cmdset_0002: Fix unlocking requests crossing a chip boudary
      mtd: cfi_cmdset_0002: Avoid walking all chips when unlocking.

Johan Hovold (3):
      backlight: as3711_bl: Fix Device Tree node lookup
      backlight: max8925_bl: Fix Device Tree node lookup
      backlight: tps65217_bl: Fix Device Tree node lookup

Josh Hill (1):
      net: qmi_wwan: Add Netgear Aircard 779S

Julian Anastasov (1):
      ipvs: fix buffer overflow with sync daemon and service

Kai-Heng Feng (1):
      media: cx231xx: Add support for AverMedia DVD EZMaker 7

Kees Cook (1):
      video: uvesafb: Fix integer overflow in allocation

Keith Busch (1):
      block: Fix transfer when chunk sectors exceeds max

Leon Romanovsky (1):
      RDMA/mlx4: Discard unknown SQP work requests

Liu Bo (2):
      Btrfs: make raid6 rebuild retry more
      Btrfs: fix unexpected cow in run_delalloc_nocow

Lukas Czerner (1):
      ext4: update mtime in ext4_punch_hole even if no blocks are released

Mahesh Salgaonkar (1):
      powerpc/fadump: Unregister fadump on kexec down path.

Martin Kelly (1):
      iio:buffer: make length types match kfifo types

Matthias Schiffer (1):
      mips: ftrace: fix static function graph tracing

Mauro Carvalho Chehab (2):
      media: v4l2-compat-ioctl32: prevent go past max size
      media: dvb_frontend: fix locking issues at dvb_frontend_get_event()

Maxim Moseychuk (1):
      usb: do not reset if a low-speed or full-speed device timed out

Maxime Chevallier (1):
      spi: Fix scatterlist elements size in spi_map_buf

Michael Neuling (2):
      powerpc/ptrace: Fix setting 512B aligned breakpoints with PTRACE_SET_=
DEBUGREG
      powerpc/ptrace: Fix enforcement of DAWR constraints

Michael Schmitz (1):
      m68k/mm: Adjust VM area to be unmapped by gap size for __iounmap()

Mika Westerberg (1):
      PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed=
 on resume

Mike Marciniszyn (1):
      IB/qib: Fix DMA api warning with debug kernel

Mike Snitzer (1):
      dm thin: handle running out of data space vs concurrent discard

Miklos Szeredi (2):
      fuse: atomic_o_trunc should truncate pagecache
      fuse: fix control dir setup and teardown

Mikulas Patocka (1):
      branch-check: fix long->int truncation when profiling branches

NeilBrown (1):
      md: fix two problems with setting the "re-add" device state.

Omar Sandoval (1):
      Btrfs: fix clone vs chattr NODATASUM race

Paolo Abeni (1):
      netfilter: ebtables: handle string from userspace with care

Qu Wenruo (1):
      btrfs: scrub: Don't use inode pages for device replace

Richard Weinberger (1):
      ubi: fastmap: Cancel work upon detach

Robert Elliott (1):
      linvdimm, pmem: Preserve read-only setting for pmem devices

Sasha Levin (1):
      Revert "Btrfs: fix scrub to repair raid6 corruption"

Scott Mayhew (1):
      nfsd: restrict rd_maxcount to svc_max_payload in nfsd_encode_readdir

Silvio Cesare (1):
      UBIFS: Fix potential integer overflow in allocation

Srinivas Kandagatla (1):
      ASoC: dapm: delete dapm_kcontrol_data paths list before freeing it

Stefan M Schaeckeler (1):
      of: unittest: for strings, account for trailing \0 in property length=
 field

Stefan Potyra (1):
      w1: mxc_w1: Enable clock before calling clk_get_rate() on it

Steffen Maier (7):
      scsi: zfcp: fix missing SCSI trace for result of eh_host_reset_handler
      scsi: zfcp: fix missing SCSI trace for retry of abort / scsi_eh TMF
      scsi: zfcp: fix misleading REC trigger trace where erp_action setup f=
ailed
      scsi: zfcp: fix missing REC trigger trace on terminate_rport_io early=
 return
      scsi: zfcp: fix missing REC trigger trace on terminate_rport_io for E=
RP_FAILED
      scsi: zfcp: fix missing REC trigger trace for all objects in ERP_FAIL=
ED
      scsi: zfcp: fix missing REC trigger trace on enqueue without ERP thre=
ad

Szymon Janc (1):
      Bluetooth: Fix connection if directed advertising and privacy is used

Takashi Iwai (1):
      ALSA: hda/realtek - Add a quirk for FSC ESPRIMO U9210

Tao Wang (1):
      cpufreq: Fix new policy initialization during limits updates via sysfs

Tetsuo Handa (2):
      driver core: Don't ignore class_dir_create_and_add() failure.
      fuse: don't keep dead fuse_conn at fuse_fill_super().

Thadeu Lima de Souza Cascardo (1):
      fs/binfmt_misc.c: do not allow offset overflow

Tobias Brunner (1):
      xfrm: Ignore socket policies when rebuilding hash tables

Tokunori Ikegami (2):
      mtd: cfi_cmdset_0002: Change write buffer to check correct value
      MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum

Xiangning Yu (1):
      bonding: re-evaluate force_primary when the primary slave name changes


--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAls7Xd8ACgkQONu9yGCS
aT56+w/9G4zblIb5H+Mzpy00eNINr2pFkko2JwfbDAwJw4UYLs5NGMWsIR3Rqfac
CT7JnPHduKTRqR7FbqDQJjV+eaWVPh8elfYEqN72ac5GcKfjCC1PL/k5cQeeL1dp
ktTRH1KuHJqkpdY1t4+aLWja98lYue6ZquxeUSBhQNjcsvIAiEtAcW98saX/YBEO
VsLEzmFkv8m7UmT7M7Z/JVwYmEqspIXFaNE7C9g+iugxyyINhmjdB0O5/ilB4gZg
p1DMjnXPxzrg7fW7EKnfaSCaDrNHh9imfdEPdOzM5+HjgxAvlbESqd6J59xYxhl8
a0tKcwRGUH+3ifK8RJJw7YS5MqZ0mBgEwsCnVM9I25BU3tNjOCB+cR3M17uK42aF
YLfW7/ITMhBPgYT1nydKV05sf4oi6oLQCZEBUQXrxhZd1mahI6GAN/TF80ilc9XD
TlI7E9/X9hOmDpzLnKv58/1MeqFVRKOBpo/PjBr/+d3/eGF9TE62/TJixz75Xik3
O+/Q3lBan2YmRKvF0Dgz2EWtmqyRO32rnXA1Ar3FRJZezzTBKoF5ikd1cwOwcd6m
D5Uyd+UF9s2GHJFRY2d1inmuxZc4HomJHN/z1jW+9PGVSVH6zAc67BGEFUoJbn88
vdylLNkrs75U4n4NmIXxR7EESE3F+zuWwU7YrgnHeBloM43aYZM=
=Od8o
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
