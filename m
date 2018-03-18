Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3842254-1521371857-2-3244568599253340325
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521371852; b=efrhcjcesrqBma+3DrcQrOeePTqMlkvEETBYYtgo7f97Ry2
    ShFNo9P6llkXP5nEewuHlKagZjmnr9jju48TotluqbAdU24/Z78cSodaNUGb2+eF
    iSU8VR50LTsgjDcsP7a1rlJUTqaTVdKmHv8Y3HFyhZhC/+lM8BPnkOIhcuMx3D1k
    d7saGfAHodR/JgtlysKodnLVf64RAa1BYrlBs1Z5roZa3rNZd1IHgW2oho1Joycz
    6OywZo05fCrchy2bKik5Q0ExkoK9ycMNfyuZPr6ARF862K0Pk9kcDcK24FU0DzwF
    bEIhpIB7LCNuqM+CLDzu0LXu+gHtro/W/P43U+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521371852; bh=9sBzW+F6ldJGYawV0GOFkROd3XSg0bZyaq6A4ZGm8G0=; b=V
    oH4yw/M7dtX0RibDwQOzQJklbow2Db95S+nVV0EYbs8rxT5wEDKTbWdnqco84YWJ
    Pa71Anbf2PKXJ5WAT8d8RCaMkvzmmgdtxA3duZgxVTlR0EuM0mYewZaF3h7U2zfc
    KP8SIH//4ibBofy0I6lw65MXnUc8rkBlUCJ/NPLntUhKDarx16681NA4YWxUoXoE
    xy3z2UiSqOEPgPnCA99WM5i55GFAW+mQHJWdwZa5KAsNtGcS9hztdSpbnzouxVHf
    LfPR6+qm1bCRIu21cgZOUGeyqVX7lpQvq/BfOPL+vO9XutMSaftU+0ijUiE90XAt
    IIjsSjK1x2BItmnSre+Yw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbeCRLRK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 07:17:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58822 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753837AbeCRLRH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 07:17:07 -0400
Date: Sun, 18 Mar 2018 12:17:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.88
Message-ID: <20180318111705.GA14060@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.88 kernel.

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

 Makefile                                       |    2=20
 arch/arm/mach-omap2/omap-secure.c              |    2=20
 arch/mips/ath25/board.c                        |    2=20
 arch/mips/cavium-octeon/octeon-irq.c           |    2=20
 arch/mips/kernel/smp-bmips.c                   |    8=20
 arch/s390/kvm/kvm-s390.c                       |    1=20
 arch/x86/Makefile                              |    5=20
 arch/x86/entry/entry_32.S                      |    3=20
 arch/x86/entry/entry_64.S                      |    3=20
 arch/x86/include/asm/apm.h                     |    6=20
 arch/x86/include/asm/asm-prototypes.h          |    3=20
 arch/x86/include/asm/cpufeatures.h             |    1=20
 arch/x86/include/asm/efi.h                     |   17=20
 arch/x86/include/asm/nospec-branch.h           |  138 +++++-
 arch/x86/include/asm/paravirt.h                |   16=20
 arch/x86/include/asm/paravirt_types.h          |    5=20
 arch/x86/kernel/cpu/bugs.c                     |   12=20
 arch/x86/kernel/cpu/intel.c                    |    7=20
 arch/x86/kernel/cpu/mcheck/mce.c               |   22 +
 arch/x86/kernel/head_64.S                      |    2=20
 arch/x86/kernel/machine_kexec_64.c             |    1=20
 arch/x86/kernel/module.c                       |   14=20
 arch/x86/lib/Makefile                          |    1=20
 arch/x86/lib/retpoline.S                       |   56 --
 arch/x86/tools/relocs.c                        |    3=20
 drivers/block/loop.c                           |    2=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c       |    3=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |   58 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c        |   13=20
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c          |   30 -
 drivers/gpu/drm/drm_probe_helper.c             |   20=20
 drivers/gpu/drm/i915/i915_drv.c                |    2=20
 drivers/gpu/drm/i915/intel_hdmi.c              |   14=20
 drivers/gpu/drm/nouveau/nouveau_connector.c    |   18=20
 drivers/gpu/drm/radeon/cik.c                   |   31 -
 drivers/gpu/drm/radeon/radeon_connectors.c     |   74 ++-
 drivers/infiniband/core/ucma.c                 |    6=20
 drivers/infiniband/hw/mlx5/cq.c                |    7=20
 drivers/infiniband/hw/mlx5/mr.c                |    2=20
 drivers/input/keyboard/matrix_keypad.c         |    4=20
 drivers/input/keyboard/tca8418_keypad.c        |    2=20
 drivers/md/bcache/super.c                      |   27 +
 drivers/media/i2c/tc358743.c                   |    2=20
 drivers/mtd/ubi/vmt.c                          |   15=20
 drivers/pci/host/pcie-designware.c             |    2=20
 drivers/scsi/qla2xxx/qla_init.c                |    1=20
 drivers/scsi/qla2xxx/qla_target.c              |    2=20
 drivers/staging/android/ashmem.c               |   15=20
 drivers/staging/comedi/drivers.c               |    3=20
 drivers/tty/serial/8250/8250_pci.c             |   11=20
 drivers/tty/serial/atmel_serial.c              |    1=20
 drivers/tty/serial/earlycon.c                  |    3=20
 drivers/tty/serial/serial_core.c               |    2=20
 drivers/tty/serial/sh-sci.c                    |    2=20
 drivers/usb/core/message.c                     |    4=20
 drivers/usb/core/quirks.c                      |    3=20
 drivers/usb/gadget/function/f_fs.c             |    1=20
 drivers/usb/mon/mon_text.c                     |  126 +++---
 drivers/usb/storage/uas.c                      |    2=20
 drivers/usb/storage/unusual_devs.h             |    7=20
 drivers/usb/usbip/vudc_sysfs.c                 |    8=20
 drivers/virtio/virtio_ring.c                   |    2=20
 drivers/watchdog/hpwdt.c                       |  507 --------------------=
-----
 fs/ext4/xattr.c                                |    3=20
 fs/nfs/direct.c                                |    2=20
 fs/nfs/write.c                                 |   83 ++--
 include/drm/drm_crtc_helper.h                  |    1=20
 include/linux/compiler-clang.h                 |    5=20
 include/linux/compiler-gcc.h                   |    4=20
 include/linux/init.h                           |    8=20
 include/linux/netfilter/x_tables.h             |   38 -
 include/linux/nospec.h                         |   23 -
 include/linux/usb/quirks.h                     |    3=20
 include/linux/workqueue.h                      |    1=20
 kernel/workqueue.c                             |   16=20
 net/bridge/netfilter/ebt_among.c               |   21 -
 net/bridge/netfilter/ebtables.c                |   13=20
 net/ipv4/netfilter/arp_tables.c                |   20=20
 net/ipv4/netfilter/ip_tables.c                 |   23 -
 net/ipv6/netfilter/ip6_tables.c                |   21 -
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c       |    4=20
 net/netfilter/nf_nat_proto_common.c            |    7=20
 net/netfilter/x_tables.c                       |   55 ++
 net/netfilter/xt_IDLETIMER.c                   |    9=20
 net/netfilter/xt_LED.c                         |   12=20
 scripts/Makefile.lib                           |    8=20
 sound/core/seq/seq_clientmgr.c                 |   21 -
 sound/core/seq/seq_fifo.c                      |    2=20
 sound/core/seq/seq_memory.c                    |   14=20
 sound/core/seq/seq_memory.h                    |    3=20
 sound/pci/hda/patch_conexant.c                 |    2=20
 sound/pci/hda/patch_realtek.c                  |   18=20
 sound/soc/codecs/rt5651.c                      |    1=20
 sound/soc/codecs/sgtl5000.c                    |   11=20
 tools/perf/util/trigger.h                      |    9=20
 95 files changed, 875 insertions(+), 950 deletions(-)

Adrian Hunter (1):
      perf tools: Fix trigger class trigger_on()

Alex Deucher (2):
      drm/radeon: fix KV harvesting
      drm/amdgpu: fix KV harvesting

Arnd Bergmann (2):
      watchdog: hpwdt: fix unused variable warning
      ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds

Benjamin Berg (1):
      ALSA: hda/realtek: Limit mic boost on T480

Clay McClure (1):
      ubi: Fix race condition between ubi volume creation and udev

Colin Ian King (3):
      MIPS: ath25: Check for kzalloc allocation failure
      MIPS: OCTEON: irq: Check for null return on kzalloc allocation
      usbip: vudc: fix null pointer dereference on udc->lock

Dan Williams (2):
      nospec: Kill array_index_nospec_mask_check()
      nospec: Include <asm/barrier.h> dependency

Danilo Krummrich (1):
      usb: quirks: add control message delay for 1b1c:1b20

David Hildenbrand (1):
      KVM: s390: fix memory overwrites when not using SCA entries

David Woodhouse (3):
      Revert "x86/retpoline: Simplify vmexit_fill_RSB()"
      x86/speculation: Use IBRS if available before calling into firmware
      x86/retpoline: Support retpoline builds with Clang

Dennis Wassenberg (3):
      ALSA: hda/realtek - Make dock sound work on ThinkPad L570
      ALSA: hda: add dock and led support for HP EliteBook 820 G3
      ALSA: hda: add dock and led support for HP ProBook 640 G2

Dmitry Torokhov (1):
      Input: tca8418_keypad - remove double read of key event register

Eric Dumazet (1):
      netfilter: IDLETIMER: be syzkaller friendly

Fabio Estevam (1):
      ASoC: sgtl5000: Fix suspend/resume

Florian Westphal (7):
      netfilter: add back stackpointer size checks
      netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets
      netfilter: bridge: ebt_among: add missing match size checks
      netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt
      netfilter: x_tables: pass xt_counters struct instead of packet counter
      netfilter: x_tables: pass xt_counters struct to counter allocator
      netfilter: x_tables: pack percpu counter allocations

Frank Mori Hess (1):
      staging: comedi: fix comedi_nsamples_left.

Greentime Hu (1):
      earlycon: add reg-offset to physical address before mapping

Greg Kroah-Hartman (1):
      Linux 4.9.88

H.J. Lu (1):
      x86: Treat R_X86_64_PLT32 as R_X86_64_PC32

Hans de Goede (1):
      ASoC: rt5651: Fix regcache sync errors on resume

Ingo Molnar (1):
      x86/speculation: Move firmware_restrict_branch_speculation_*() from C=
 to CPP

James Hogan (1):
      kbuild: Handle builtin dtb file names containing hyphens

James Zhu (2):
      drm/amdgpu:Correct max uvd handles
      drm/amdgpu:Always save uvd vcpu_bo in VM Mode

Jerry Hoemann (3):
      watchdog: hpwdt: SMBIOS check
      watchdog: hpwdt: Check source of NMI
      watchdog: hpwdt: Remove legacy NMI sourcing.

Joel Fernandes (1):
      staging: android: ashmem: Fix lockdep issue during llseek

Jonas Danielsson (1):
      tty/serial: atmel: add new version check for usart

Josh Poimboeuf (1):
      x86/module: Detect and skip invalid relocations

Justin Chen (1):
      MIPS: BMIPS: Do not mask IPIs during suspend

Koen Vandeputte (1):
      PCI: dwc: Fix enumeration end when reaching root subordinate

Konrad Rzeszutek Wilk (1):
      x86/spectre_v2: Don't check microcode versions when running under hyp=
ervisors

Leon Romanovsky (3):
      RDMA/ucma: Limit possible option size
      RDMA/ucma: Check that user doesn't overflow QP state
      RDMA/mlx5: Fix integer overflow while resizing CQ

Lukas Wunner (5):
      workqueue: Allow retrieval of current task's work struct
      drm: Allow determining if current task is output poll worker
      drm/nouveau: Fix deadlock on runtime suspend
      drm/radeon: Fix deadlock on runtime suspend
      drm/amdgpu: Fix deadlock on runtime suspend

Maarten Lankhorst (1):
      drm/i915: Always call to intel_display_set_init_power() in resume_ear=
ly.

Michael Lyle (1):
      bcache: don't attach backing with duplicate UUID

Nikola Ciprich (1):
      serial: 8250_pci: Add Brainboxes UC-260 4 port serial device

Oliver Neukum (1):
      uas: fix comparison for error code

Paolo Abeni (2):
      netfilter: x_tables: fix missing timer initialization in xt_LED
      netfilter: nat: cope with negative port range

Pete Zaitcev (1):
      usb: usbmon: Read text within supplied buffer size

Peter Zijlstra (3):
      x86/speculation, objtool: Annotate indirect calls/jumps for objtool
      x86/boot, objtool: Annotate indirect jump in secondary_startup_64()
      x86/paravirt, objtool: Annotate indirect calls

Philipp Zabel (1):
      tc358743: fix register i2c_rd/wr function fix

Quinn Tran (1):
      scsi: qla2xxx: Replace fcport alloc with qla2x00_alloc_fcport

Rex Zhu (1):
      drm/amdgpu: Notify sbios device ready before send request

Ross Zwisler (1):
      loop: Fix lost writes caused by missing flag

Sebastian Andrzej Siewior (1):
      serial: core: mark port as initialized in autoconfig

Sergey Gorenko (1):
      IB/mlx5: Fix incorrect size of klms in the memory region

Seunghun Han (1):
      x86/MCE: Serialize sysfs changes

Stefan Br=FCns (1):
      drm/i915: Try EDID bitbanging on HDMI after failed read

Tahsin Erdogan (1):
      ext4: inplace xattr block update fails to deduplicate blocks

Takashi Iwai (3):
      ALSA: hda/realtek - Fix dock line-out volume on Dell Precision 7520
      ALSA: seq: Don't allow resizing pool in use
      ALSA: seq: More protection for concurrent write and ioctl races

Tang Junhui (1):
      bcache: fix crashes in duplicate cache device register

Teijo Kinnunen (1):
      USB: storage: Add JMicron bridge 152d:2567 to unusual_devs.h

Tiwei Bie (1):
      virtio_ring: fix num_free handling in error case

Trond Myklebust (2):
      NFS: Fix an incorrect type in struct nfs_direct_req
      NFS: Fix unstable write completion

Ulrich Hecht (1):
      serial: sh-sci: prevent lockup on full TTY buffers

Xinyong (1):
      usb: gadget: f_fs: Fix use-after-free in ffs_fs_kill_sb()

Zhang Bo (1):
      Input: matrix_keypad - fix race when disabling interrupts

himanshu.madhani@cavium.com (1):
      scsi: qla2xxx: Fix NULL pointer crash due to active timer for ABTS


--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlquSrAACgkQONu9yGCS
aT6zrQ/4guRKWY2mrVQn3UuXaL5tkx1IjfojO7AiKnVeo0v3QcpzEs0Ov5/+eKh7
1KFwbeTCuzQYzlRetZbNL1w+5XFWi/rf6ekzKyZfX5U+wkMLh+eqz/u03AmfmRe5
zcwmcakiWYyig2+Q/2C8lJmBToM8wn6cUkJNL/I/F2+TZvqrfCrxJeH8Sj68Eqga
ixaQDotU8qzQdWY5nRk5yUGAo1YfMN1/qPJs0nUX+yk0AsxmA4yGds1pZoimTtxy
1FVP97gqvLCI5BTcyorPnEvFee/BkqL85y1hWUcLu75DwTfkb9M9DPtDTN2H+bIX
egtOr3Y9scPWMEAcCB26078yjGKvDcENjEjexvv99zs3knFIcB5vVY3QI4g47IZQ
yQzp3lzilk4Jd9y+gzl4hZqz8WpSCszEWHj20+quV7fUGR3BGs1ePfgk0BkWFiFV
uY1bcPs1ElTw8gaxuvixcMGYP8CYhZwMfoD926PBdo2EM/bWso1f3tGUnuAW6/kL
P7HDMnM7evZNXOHmYTiMnQmBkeTsjcZKE0aRUWpIAuQqBvYQWSi8zM9SJ9eAC0KU
y4O5uNG2iUaePpkMmPfkNsl+xnBH2ZH99KFRmq9nMDQXmxyhd2dormg4ccTsdKpg
xjilZ0OpjqbvV9w58SZnSFnrfM/92LRpW8OIZMYJMS8zOQOhVA==
=V6CO
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
