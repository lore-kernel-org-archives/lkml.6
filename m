Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2313652-1521709768-2-18251477965063405825
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
    t=1521709767; b=C1voxEPHQ+b/fsw0hDyUJcXFMRKQKIszw0NTvdZcpjMxOJc
    NUlGUZGpsxMAA0lqFuPggOmIiVk/WHrbTc7u7QBuB1Rl63LiURygpFW6+dZ/DCEh
    IHCO3yxkHLr2XQATz/Y32AB/ZrdG5CTv+uYsJr943wsVBvzNjjId2V+fdHqncdY/
    L825H/kGpiyrPRio3s8cl8ulCNxb4bDrI1Ew3ttkqdavUb02bAQoE6R8pOaS1K6U
    tedohEmZ2XS5N5uMbluviCpepN05Gt5fpK32ExRE+cE+N+h03xuqIcG3EKNoMdtm
    /+hm07WS/NG8VIqYmZJjlkegt5Hol8hCYNSH4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521709767; bh=MU4XcMjHMZJLkEtTyiTXBnFtW6YdT/EBn3NB+yobja0=; b=M
    O+xnhCcn6sOoK1X70BeIuu6+wYCSGh1X+WZ9eEiilLVbU10NON2Yv4IVUyBEEFRH
    1jfsbXwJy3EnsH4EXCl4m5AC0ChPOj45zRqf667s3SKe/EWbtO4fDWzOizkjxQ0v
    XjoNTrz1QJZcB78969d7UNjsmjluAzaeCtRUO2gEOALDGGXck+aedK6uncGPCbK5
    NZHAJaIQgou0Mz5OL32NeaEsZTvvmDHGw6od8hJCp/dj78izJrR+gYc0sTqNyM2X
    5n1j7zhvoi2KeuRJam7+Jq7xF0veKUaF9PkhjzJxYaQfad9AGUVvHwAJMu9VxySN
    ySZAOz/ZG6yei27KTWGPA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbeCVJGu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 05:06:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbeCVJDp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 05:03:45 -0400
Date: Thu, 22 Mar 2018 10:03:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.101
Message-ID: <20180322090342.GA19711@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.101 kernel.

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

 Makefile                                             |    2=20
 arch/arm/boot/dts/am335x-pepper.dts                  |    2=20
 arch/arm/boot/dts/moxart-uc7112lx.dts                |    2=20
 arch/arm/boot/dts/moxart.dtsi                        |   17 ++++---
 arch/arm/boot/dts/omap3-n900.dts                     |    4 -
 arch/arm/boot/dts/r8a7790.dtsi                       |    7 ++-
 arch/arm/boot/dts/r8a7791.dtsi                       |    7 ++-
 arch/mips/net/bpf_jit.c                              |   16 +++++--
 arch/powerpc/mm/fault.c                              |    2=20
 arch/x86/kernel/kprobes/core.c                       |    6 ++
 arch/x86/kernel/kprobes/opt.c                        |    3 +
 block/blk-throttle.c                                 |   11 ++++
 drivers/gpu/drm/drm_irq.c                            |   14 +++++-
 drivers/gpu/drm/radeon/radeon_display.c              |    6 ++
 drivers/hid/hid-elo.c                                |    6 ++
 drivers/hid/hid-input.c                              |   20 ++++++---
 drivers/input/touchscreen/tsc2007.c                  |    8 +++
 drivers/iommu/iova.c                                 |    2=20
 drivers/media/i2c/soc_camera/ov6650.c                |    2=20
 drivers/media/usb/cpia2/cpia2_v4l.c                  |    4 -
 drivers/mtd/nand/nand_base.c                         |    9 +++-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c       |    1=20
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h       |    1=20
 drivers/net/ethernet/faraday/ftgmac100.c             |    1=20
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c     |    2=20
 drivers/net/veth.c                                   |    3 +
 drivers/net/wireless/ath/ath10k/debug.c              |    9 ++++
 drivers/net/wireless/ath/wil6210/main.c              |   20 +++++++--
 drivers/of/device.c                                  |    2=20
 drivers/pci/pci-driver.c                             |    2=20
 drivers/scsi/ipr.c                                   |   16 +++++--
 drivers/scsi/scsi_devinfo.c                          |    2=20
 drivers/scsi/sg.c                                    |   36 +++++++++-----=
--
 drivers/spi/spi-omap2-mcspi.c                        |    9 ++--
 drivers/spi/spi-sun6i.c                              |    2=20
 drivers/usb/gadget/udc/dummy_hcd.c                   |   20 +++------
 drivers/video/fbdev/amba-clcd.c                      |    4 -
 fs/aio.c                                             |   42 +++++++++++++-=
-----
 fs/dcache.c                                          |   11 +++-
 fs/reiserfs/journal.c                                |    2=20
 fs/reiserfs/reiserfs.h                               |    1=20
 fs/reiserfs/super.c                                  |   21 ++++++---
 include/linux/pagemap.h                              |    4 -
 include/linux/platform_data/isl9305.h                |    2=20
 include/net/tcp.h                                    |    8 ++-
 kernel/printk/braille.c                              |   15 +++---
 kernel/printk/braille.h                              |   13 ++++-
 kernel/sched/core.c                                  |    3 -
 kernel/time/sched_clock.c                            |    5 ++
 net/batman-adv/bridge_loop_avoidance.c               |   20 +++++++--
 net/mac80211/iface.c                                 |    2=20
 net/sched/act_csum.c                                 |   12 +++++
 net/xfrm/xfrm_policy.c                               |    2=20
 net/xfrm/xfrm_state.c                                |    7 +++
 security/apparmor/lsm.c                              |    2=20
 security/integrity/ima/ima_appraise.c                |    3 -
 security/selinux/hooks.c                             |    8 +++
 sound/core/oss/pcm_oss.c                             |   10 ++--
 sound/core/seq/seq_clientmgr.c                       |    4 -
 sound/core/seq/seq_prioq.c                           |   28 ++++++------
 sound/core/seq/seq_prioq.h                           |    6 --
 sound/core/seq/seq_queue.c                           |   28 ++++--------
 sound/soc/nuc900/nuc900-ac97.c                       |    4 -
 tools/perf/util/event.c                              |    4 -
 tools/perf/util/ordered-events.c                     |    3 -
 tools/perf/util/session.c                            |   17 ++++++-
 tools/testing/selftests/rcutorture/bin/configinit.sh |    2=20
 tools/usb/usbip/src/usbipd.c                         |    2=20
 68 files changed, 389 insertions(+), 182 deletions(-)

Akinobu Mita (1):
      spi: omap2-mcspi: poll OMAP2_MCSPI_CHSTAT_RXS for PIO transfer

Al Viro (1):
      lock_parent() needs to recheck if dentry got __dentry_kill'ed under it

Alexander Potapenko (1):
      selinux: check for address length in selinux_socket_bind()

Andreas Pape (1):
      batman-adv: handle race condition for claims between gateways

Andrew F. Davis (2):
      ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin
      ARM: dts: omap3-n900: Fix the audio CODEC's reset pin

Andrew Lunn (1):
      net/faraday: Add missing include of of.h

Anton Blanchard (1):
      powerpc: Avoid taking a data miss on every userspace instruction miss

Brian King (1):
      scsi: ipr: Fix missed EH wakeup

Chris Wilson (1):
      drm: Defer disabling the vblank IRQ until the next interrupt (for ins=
tant-off)

Christopher James Halse Rogers (1):
      drm/radeon: Fail fb creation from imported dma-bufs.

Dan Carpenter (2):
      media: cpia2: Fix a couple off by one bugs
      ASoC: nuc900: Fix a loop timeout test

David Carrillo-Cisneros (2):
      perf inject: Copy events when reordering events in pipe mode
      perf session: Don't rely on evlist in pipe mode

David Daney (1):
      MIPS: BPF: Quit clobbering callee saved registers in JIT code.

David Engraf (1):
      timers, sched_clock: Update timeout for clock wrap

Davide Caratti (1):
      sched: act_csum: don't mangle TCP and UDP GSO packets

Dedy Lansky (1):
      wil6210: fix memory access violation in wil_memcpy_from/toio_32

Gao Feng (1):
      tcp: sysctl: Fix a race to avoid unexpected 0 window from space

Geert Uytterhoeven (2):
      ARM: dts: r8a7790: Correct parent of SSI[0-9] clocks
      ARM: dts: r8a7791: Correct parent of SSI[0-9] clocks

Greg Kroah-Hartman (1):
      Linux 3.18.101

H. Nikolaus Schaller (1):
      Input: tsc2007 - check for presence and power down tsc2007 during pro=
be

Hannes Reinecke (1):
      scsi: sg: close race condition in sg_remove_sfp_usercontext()

Jan Kara (1):
      reiserfs: Make cancel_old_flush() reliable

Janusz Krzysztofik (1):
      media: i2c/soc_camera: fix ov6650 sensor getting wrong clock

Jiri Kosina (1):
      HID: elo: clear BTN_LEFT mapping

Johannes Thumshirn (4):
      scsi: sg: check for valid direction before starting the request
      scsi: sg: fix SG_DXFER_FROM_DEV transfers
      scsi: sg: fix static checker warning in sg_is_valid_dxfer
      scsi: sg: only check for dxfer_len greater than 256M

John Johansen (1):
      apparmor: Make path_max parameter readonly

Julien BOIBESSOT (1):
      tools/usbip: fixes build with musl libc toolchain

Kirill A. Shutemov (1):
      mm: Fix false-positive VM_BUG_ON() in page_cache_{get,add}_speculativ=
e()

Liam Beguin (1):
      video: ARM CLCD: fix dma allocation size

Linus Walleij (1):
      ARM: dts: Adjust moxart IRQ controller and flags

Lorenzo Colitti (1):
      net: xfrm: allow clearing socket xfrm policies.

Luca Coelho (1):
      mac80211: remove BUG() when interface type is invalid

Masami Hiramatsu (2):
      kprobes/x86: Fix kprobe-booster not to boost far call instructions
      kprobes/x86: Set kprobes pages read-only

Mimi Zohar (1):
      ima: relax requiring a file signature for new files with zero length

Miquel Raynal (1):
      mtd: nand: fix interpretation of NAND_CMD_NONE in nand_command[_lp]()

Mohammed Shafi Shajakhan (1):
      ath10k: disallow DFS simulation if DFS channel is not enabled

Nate Watterson (1):
      iommu/iova: Fix underflow bug in __alloc_and_insert_iova_range

Paul E. McKenney (1):
      sched: Stop resched_cpu() from sending IPIs to offline CPUs

Phil Turnbull (1):
      fm10k: correctly check if interface is removed

Prarit Bhargava (1):
      PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()

Quan Nguyen (1):
      drivers: net: xgene: Fix hardware checksum setting

Rob Herring (1):
      of: fix of_device_get_modalias returned length when truncating buffers

Samuel Thibault (1):
      braille-console: Fix value returned by _braille_console_setup

SeongJae Park (1):
      rcutorture/configinit: Fix build directory error message

Shaohua Li (1):
      blk-throttle: make sure expire time isn't too big

Stephane Eranian (1):
      perf tools: Make perf_event__synthesize_mmap_events() scale

Stephen Hemminger (1):
      veth: set peer GSO values

Takashi Iwai (3):
      ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()
      ALSA: seq: Fix possible UAF in snd_seq_check_queue()
      ALSA: seq: Clear client entry before deleting else at closing

Tejun Heo (2):
      fs/aio: Add explicit RCU grace period when freeing kioctx
      fs/aio: Use RCU accessors for kioctx_table->table[]

Tobias Jordan (1):
      spi: sun6i: disable/unprepare clocks on remove

Tomasz Kramkowski (1):
      HID: clamp input to logical range if no null state

Valtteri Heikkil=E4 (1):
      HID: reject input outside logical range only if null state is set

Vincent Stehl=E9 (1):
      regulator: isl9305: fix array size

Xose Vazquez Perez (1):
      scsi: devinfo: apply to HP XP the same flags as Hitachi VSP

Yuyang Du (1):
      usb: gadget: dummy_hcd: Fix wrong power status bit clear/reset in dum=
my_hub_control()


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqzcW0ACgkQONu9yGCS
aT41ZBAAxSlI7jd6EYgz9fWGtTP1Qqodyl41oPd5FFU66SwqYgOEWvjlPQLa2moD
eX7ZlehuuwOhZ73Dr2TWcTs84jQ5PgzpJ1ry/W29XI9DJXpPvy7CwLpr7HjDLmrZ
btH753mKfvM0ya5MJsuVfvbvE1nTydG9Sfkje+7r8IKSb8phgJenToolLQNWTokm
lFrLVUEOoKbRvvtnSGu5JKnArMhY/AxvJFg32wH3yVbQ7gpzfJHvdDfT1dYFX/FS
kMnq3x/QDWKdjFExwr+Tn/i0M+CTgGt48icbAhgVviV35JZ05X3HHvN2VFlNHzXn
ILpRouj7RAF6v4kqzlNMH0KC1VHbvV2Obms5+PyKWTJkxIJVuI/g5z6xE7O2Q/3Z
B/zxCGsUDAaoGCGN5tCpLPGXN5ZGFkrs0CIuiD6eeNWPnP5ZiWBm7V1CfvjemUnQ
6HDa0knEU/KVN9K8xdk84MJQMYosX5jQS6TwydCofg8NpLa1bPB1O091jOErF453
umi5PsDAUf6s0uHoKJtewbij50qUI0QOXV9WbBmsOH3dmztGH414VV9XIuNYuV4n
ItIpGZvulKN028CA+HRJBNYyui2mgrkuDiwn1M3j1YSRSbclhZeiK8pPoPfD9AAr
in1SFZNZnkUjB5cAfvT3BLqBZVirkfuYc5/nmyofSNSIbLXebR0=
=0y35
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
