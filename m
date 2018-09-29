Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9108C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC0820666
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC0820666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbeI2RrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 13:47:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36198 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbeI2RrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 13:47:14 -0400
Received: from localhost (c-73-221-170-44.hsd1.wa.comcast.net [73.221.170.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8AAACCCA;
        Sat, 29 Sep 2018 11:19:09 +0000 (UTC)
Date:   Sat, 29 Sep 2018 04:19:08 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.130
Message-ID: <20180929111908.GA22135@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.130 kernel.

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

 Makefile                                    |    2 -
 arch/x86/xen/pmu.c                          |    2 -
 drivers/gpu/drm/nouveau/nouveau_connector.c |   20 ++++++-----
 drivers/gpu/drm/nouveau/nouveau_display.c   |   33 ++++++++++++++----
 drivers/gpu/drm/vc4/vc4_plane.c             |   25 ++++++--------
 drivers/hid/hid-core.c                      |    3 +
 drivers/hid/hid-ids.h                       |    2 +
 drivers/hid/hid-sony.c                      |    6 +++
 drivers/infiniband/hw/cxgb4/qp.c            |    6 +++
 drivers/misc/vmw_balloon.c                  |    1=20
 drivers/net/appletalk/ipddp.c               |    8 +++-
 drivers/net/ethernet/hp/hp100.c             |    2 -
 drivers/net/xen-netfront.c                  |    8 ++++
 drivers/pci/host/pci-aardvark.c             |    1=20
 drivers/pci/quirks.c                        |    6 ---
 drivers/platform/x86/alienware-wmi.c        |    1=20
 drivers/target/iscsi/iscsi_target_auth.c    |   30 ++++++++---------
 drivers/tty/vt/vt_ioctl.c                   |    4 ++
 fs/ext4/dir.c                               |   20 +++++------
 fs/ext4/inline.c                            |    4 +-
 fs/ext4/mmp.c                               |    1=20
 fs/ext4/namei.c                             |    6 +++
 fs/ext4/resize.c                            |   23 ++++++++++++-
 fs/ext4/super.c                             |    4 ++
 fs/ocfs2/buffer_head_io.c                   |    1=20
 include/net/nfc/hci.h                       |    2 -
 kernel/sched/fair.c                         |    3 +
 kernel/trace/ring_buffer.c                  |    2 +
 mm/shmem.c                                  |    2 +
 net/core/neighbour.c                        |   13 ++++---
 net/ipv4/af_inet.c                          |    1=20
 net/ipv4/udp.c                              |   49 ++++++++++++++---------=
-----
 net/ipv6/ip6_offload.c                      |    1=20
 net/ipv6/ip6_output.c                       |    6 +--
 net/nfc/hci/core.c                          |   10 +++++
 sound/firewire/bebob/bebob.c                |    2 +
 sound/firewire/bebob/bebob_maudio.c         |   28 ++++++++--------
 sound/firewire/digi00x/digi00x.c            |    1=20
 sound/firewire/fireworks/fireworks.c        |    2 +
 sound/firewire/oxfw/oxfw.c                  |   10 +++++
 sound/firewire/tascam/tascam.c              |    1=20
 sound/pci/emu10k1/emufx.c                   |    2 -
 sound/soc/codecs/cs4265.c                   |    4 +-
 43 files changed, 235 insertions(+), 123 deletions(-)

Boris Brezillon (1):
      drm/vc4: Fix the "no scaling" case on multi-planar YUV formats

Boris Ostrovsky (1):
      xen/x86/vpmu: Zero struct pt_regs before calling into sample handling=
 code

Colin Ian King (1):
      net: hp100: fix always-true check for link up state

Eric Biggers (1):
      ext4: show test_dummy_encryption mount option in /proc/mounts

Eric Dumazet (1):
      ipv6: fix possible use-after-free in ip6_xmit()

Greg Kroah-Hartman (1):
      Linux 4.9.130

Gustavo A. R. Silva (1):
      tty: vt_ioctl: fix potential Spectre v1

Joel Fernandes (Google) (1):
      mm: shmem.c: Correctly annotate new inodes for lockdep

Juergen Gross (1):
      xen/netfront: don't bug in case of too many frags

Junxiao Bi (1):
      ocfs2: fix ocfs2 read block panic

Li Dongyang (1):
      ext4: don't mark mmp buffer head dirty

Lyude Paul (3):
      drm/nouveau/drm/nouveau: Fix bogus drm_kms_helper_poll_enable() place=
ment
      drm/nouveau/drm/nouveau: Use pm_runtime_get_noresume() in connector_d=
etect()
      drm/nouveau/drm/nouveau: Prevent handling ACPI HPD events too early

Mario Limonciello (1):
      platform/x86: alienware-wmi: Correct a memory leak

Mika Westerberg (1):
      Revert "PCI: Add ACS quirk for Intel 300 series"

Nadav Amit (1):
      vmw_balloon: include asm/io.h

Paolo Abeni (1):
      udp4: fix IP_CMSG_CHECKSUM for connected sockets

Roderick Colenbrander (2):
      HID: sony: Update device ids
      HID: sony: Support DS4 dongle

Steve Muckle (1):
      sched/fair: Fix vruntime_normalized() for remote non-migration wakeup

Steve Wise (1):
      iw_cxgb4: only allow 1 flush on user qps

Suren Baghdasaryan (2):
      NFC: Fix possible memory corruption when handling SHDLC I-Frame comma=
nds
      NFC: Fix the number of pipes

S=E9bastien Szymanski (1):
      ASoC: cs4265: fix MMTLR Data switch control

Takashi Sakamoto (8):
      ALSA: bebob: fix memory leak for M-Audio FW1814 and ProjectMix I/O at=
 error path
      ALSA: bebob: use address returned by kmalloc() instead of kernel stac=
k for streaming DMA mapping
      ALSA: firewire-digi00x: fix memory leak of private data
      ALSA: firewire-tascam: fix memory leak of private data
      ALSA: fireworks: fix memory leak of response buffer at error path
      ALSA: oxfw: fix memory leak for model-dependent data at error path
      ALSA: oxfw: fix memory leak of discovered stream formats at error path
      ALSA: oxfw: fix memory leak of private data

Theodore Ts'o (5):
      ext4: check to make sure the rename(2)'s destination is not freed
      ext4: avoid divide by zero fault when deleting corrupted inline direc=
tories
      ext4: recalucate superblock checksum after updating free blocks/inodes
      ext4: fix online resize's handling of a too-small final block group
      ext4: fix online resizing for bigalloc file systems with a 1k block s=
ize

Toke H=F8iland-J=F8rgensen (1):
      gso_segment: Reset skb->mac_len after modifying network header

Vaibhav Nagarnaik (1):
      ring-buffer: Allow for rescheduling when removing pages

Vasily Khoruzhick (1):
      neighbour: confirm neigh entries when ARP packet is received

Vincent Pelletier (1):
      scsi: target: iscsi: Use hex2bin instead of a re-implementation

Willy Tarreau (2):
      ALSA: emu10k1: fix possible info leak to userspace on SNDRV_EMU10K1_I=
OCTL_INFO
      net/appletalk: fix minor pointer leak to userspace in SIOCFINDIPDDPRT

Zachary Zhang (1):
      PCI: aardvark: Size bridges before resources allocation


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluvX6wACgkQONu9yGCS
aT6AgQ//RDNjBte0W2/JUXMBI9Tyh1ORzBS2RZSgxJz8pV5KWCWrcdY51aAcUvK1
ZXAOCX3Bury/mzo3ACIT0lW0llR7qdrmwqyD15M20GaU6ehBfs9gOdjyDKcwEptK
d+Zxp5mmoMJLRKCdV5+eTckewV43TbOljsqytDi9xmCmHT+5SzILfCAviVQhzfMT
bR+QBlsaHtTmXK1Z1fxPdUKJuO9M73m4HAmGeCFW+D9IeZlflXinzsdbhG6G0nvU
AGkf1UieXkfRH7O4BbPif0+ixTz8CJUlPoANrlDpJvp/jiQrqMDXg8bEnV1fTx4i
tIgO/S5E8+2zcHqsn5Q63SkhgH0O7FSSYeLDE/mvpwazqRCJ1vplXQG7YxcPPcKI
bnKJ6aAvNzsma1qK4DgktJ9pqcezNP/TGj7LfUAEZRbMmwA/gIsTNr33wl+3uL2b
xG5zf75KBzoeRghuwn7UEUp2E7o2iI2EsjrwU8M7jPVGo1ihpTSEaSwXldfeGNIf
/6rBUSYTTa/MXPZtaLPqDk4Ekx7LP7vWENVXSfghh9EBZ77i/mcWzn5B0D/zqIdg
DDKj3bQDTeufZLFWBomF7WIbcjmUELHAq1oIO8AqmezAZw99yky0cO118fSppCYR
bsxObZupIlves4tvLsM6B9eoBo+TvPU/Yh9P6r+d6/nw/wee1d4=
=zSOk
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
