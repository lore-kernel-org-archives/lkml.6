Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93061C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EED20666
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47EED20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeI2Rrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 13:47:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbeI2Rrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 13:47:46 -0400
Received: from localhost (c-73-221-170-44.hsd1.wa.comcast.net [73.221.170.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 556F0CCA;
        Sat, 29 Sep 2018 11:19:41 +0000 (UTC)
Date:   Sat, 29 Sep 2018 04:19:40 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.159
Message-ID: <20180929111940.GA22213@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.159 kernel.

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

 Makefile                                    |    2 -
 arch/arm64/kernel/entry.S                   |    3 ++
 arch/x86/xen/pmu.c                          |    2 -
 drivers/gpu/drm/nouveau/nouveau_connector.c |   20 ++++++++++--------
 drivers/hid/hid-core.c                      |    3 ++
 drivers/hid/hid-ids.h                       |    2 +
 drivers/hid/hid-sony.c                      |    6 +++++
 drivers/infiniband/hw/cxgb4/qp.c            |    6 +++++
 drivers/net/appletalk/ipddp.c               |    8 +++++--
 drivers/net/ethernet/hp/hp100.c             |    2 -
 drivers/net/xen-netfront.c                  |    8 ++++++-
 drivers/platform/x86/alienware-wmi.c        |    1=20
 drivers/target/iscsi/iscsi_target_auth.c    |   30 +++++++++++++----------=
-----
 drivers/tty/vt/vt_ioctl.c                   |    4 +++
 fs/ext4/dir.c                               |   20 ++++++++----------
 fs/ext4/inline.c                            |    4 ++-
 fs/ext4/mmp.c                               |    1=20
 fs/ext4/resize.c                            |   23 ++++++++++++++++++++-
 fs/ext4/super.c                             |    2 +
 fs/ocfs2/buffer_head_io.c                   |    1=20
 include/net/nfc/hci.h                       |    2 -
 kernel/trace/ring_buffer.c                  |    2 +
 mm/shmem.c                                  |    2 +
 net/core/neighbour.c                        |   13 +++++++-----
 net/ipv4/af_inet.c                          |    1=20
 net/ipv6/ip6_offload.c                      |    1=20
 net/ipv6/ip6_output.c                       |    6 +----
 net/nfc/hci/core.c                          |   10 +++++++++
 sound/firewire/bebob/bebob_maudio.c         |   24 +++++++++++++---------
 sound/pci/emu10k1/emufx.c                   |    2 -
 sound/soc/codecs/cs4265.c                   |    4 +--
 31 files changed, 147 insertions(+), 68 deletions(-)

Boris Ostrovsky (1):
      xen/x86/vpmu: Zero struct pt_regs before calling into sample handling=
 code

Catalin Marinas (1):
      arm64: Add trace_hardirqs_off annotation in ret_to_user

Colin Ian King (1):
      net: hp100: fix always-true check for link up state

Eric Dumazet (1):
      ipv6: fix possible use-after-free in ip6_xmit()

Greg Kroah-Hartman (1):
      Linux 4.4.159

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

Lyude Paul (1):
      drm/nouveau/drm/nouveau: Use pm_runtime_get_noresume() in connector_d=
etect()

Mario Limonciello (1):
      platform/x86: alienware-wmi: Correct a memory leak

Roderick Colenbrander (2):
      HID: sony: Update device ids
      HID: sony: Support DS4 dongle

Steve Wise (1):
      iw_cxgb4: only allow 1 flush on user qps

Suren Baghdasaryan (2):
      NFC: Fix possible memory corruption when handling SHDLC I-Frame comma=
nds
      NFC: Fix the number of pipes

S=E9bastien Szymanski (1):
      ASoC: cs4265: fix MMTLR Data switch control

Takashi Sakamoto (1):
      ALSA: bebob: use address returned by kmalloc() instead of kernel stac=
k for streaming DMA mapping

Theodore Ts'o (4):
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


--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluvX8wACgkQONu9yGCS
aT4hAg/+M5EMbcg6+r+iX9lYk3rxDFH7JKfJPNPLg73zbSf/BzWwqUDVg4Sio9LE
vZQGUgdd4p16yvfT5FJ+D4Mea9xjIKdF4W57zcqNNb9lPm61XzVLng65wxGWv1sQ
rmOhKQZDLhNMBYKms1j1IZ1rZlSnRY08OjDqXjXL9ojTtZOYrrg8YQGVx8GOK4FC
cMZX0XKXCFPfxtvWq7D1zK4EjiyEsZIvLbufYXJiYEBKjgHG86wUYhUUiadYNgbP
y4h0WFDiBIbaRHYm5YJkR46cavLuV+zWvOuKoLaE1uN6e1CcANBzqEN6XpRv0zdD
FozaDuRAcYoSa4bl8Y/bmJU3vgILXucspxDZGhme7WRFtfPjamnWPhrjloMGOz2m
i5ZURs2bVh9DBt9Z62/qFSEIda3s2uRFDDjhE38QXZTqx0ZjoUXraqZquzBEhHrw
Ptf2LwV3RFxtYugxqMVRTOK7KA5P6nB8ExHkVMwjA+JQV0+NPb+L1nfudEa0mRDB
FVZpXmkw9xmX4I8Uy0dvwTW6lh3cny67i8Nz7HPqBohpnnrIdmF+gFqHnS5+Z2E/
AwPDGSMBjDzkIXmugPqmV6Y2K2D5ipAMzeCiGxiwSczV5FKGjxS9CeQUObtS04TT
JKS/5OD0Ogr2ouLeq+ktWdqy1FmZedYoqfO8KCVz7qF77hA+be8=
=rkY/
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
