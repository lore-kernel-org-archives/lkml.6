Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6727FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30656222D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550222554;
	bh=Ix3+at9N5NWgifr3J2AcFGa0rj3oS4dLVhXoxfn+qdA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=H0agFiW6vuwEDpa1Fm2FrDGhBQZcbeatC3GOGwsCp1JmplKE4CwxYsMBCc1JPHehC
	 CqEzcPDHymBok7JhM6AUczEdPfsB0Ev/lq/mKO8HD0IWzrcgdeJbzh3hCqlK/wHTzX
	 TxGCjQxo8EBurk3nwQu0NM5oPKY9Gw5rXrvOFLiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392516AbfBOJWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:22:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389954AbfBOJWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:22:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A918321925;
        Fri, 15 Feb 2019 09:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550222536;
        bh=Ix3+at9N5NWgifr3J2AcFGa0rj3oS4dLVhXoxfn+qdA=;
        h=Date:From:To:Cc:Subject:From;
        b=sFW1EFjS3BbsF9WTeU++Mnp7peb2D5XTvNbtF9KMUa5dMKYW9amsott12TjKb8hZe
         Go4kTeVWwVbLo8+B5S6L0HbI5XUqxqFyDdSpb0/gTyjGueTxKjyQpVwykWrl5j55og
         iZNjAY+WwkmzWJ7ToOfaH8y2qw/r7FYcbXk1q3rA=
Date:   Fri, 15 Feb 2019 10:21:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.157
Message-ID: <20190215092147.GA864@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.157 kernel.

No one should upgrade to this release, use 4.9.158 instead.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                |    2=20
 arch/arm/mach-iop32x/n2100.c            |    3=20
 arch/arm/mach-tango/pm.c                |    6 -
 arch/arm/mach-tango/pm.h                |    7 +
 arch/arm/mach-tango/setup.c             |    2=20
 arch/mips/kernel/mips-cm.c              |    2=20
 arch/mips/pci/pci-octeon.c              |   10 +-
 arch/mips/vdso/Makefile                 |    4 -
 drivers/gpu/drm/drm_modes.c             |    2=20
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |    9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c |    2=20
 drivers/hid/hid-debug.c                 |  122 ++++++++++++---------------=
-----
 drivers/iio/chemical/atlas-ph-sensor.c  |    7 -
 drivers/misc/vexpress-syscfg.c          |    2=20
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c   |   15 +--
 fs/cifs/Kconfig                         |    2=20
 fs/debugfs/inode.c                      |    7 +
 fs/nfsd/nfs4state.c                     |   57 +++++++++++++-
 fs/nfsd/state.h                         |    2=20
 fs/nfsd/xdr4.h                          |   13 ++-
 include/linux/hid-debug.h               |    9 +-
 kernel/signal.c                         |   58 ++++++++++++++-
 net/batman-adv/hard-interface.c         |    5 -
 net/batman-adv/soft-interface.c         |    2=20
 net/ceph/messenger.c                    |    5 -
 net/mac80211/tx.c                       |   12 ++-
 net/xfrm/xfrm_user.c                    |   13 ++-
 samples/mei/mei-amt-version.c           |    2=20
 28 files changed, 248 insertions(+), 134 deletions(-)

Aaro Koskinen (1):
      MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled

Dan Carpenter (1):
      misc: vexpress: Off by one in vexpress_syscfg_exec()

Eric W. Biederman (2):
      signal: Always notice exiting tasks
      signal: Better detection of synchronous signals

Felix Fietkau (1):
      mac80211: ensure that mgmt tx skbs have tailroom for encryption

Florian Westphal (1):
      xfrm: refine validation of template and selector families

Greg Kroah-Hartman (3):
      debugfs: fix debugfs_rename parameter checking
      Revert "cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (i=
nsecure cifs)"
      Linux 4.9.157

Ilya Dryomov (1):
      libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()

J. Bruce Fields (2):
      nfsd4: fix cached replies to solo SEQUENCE compounds
      nfsd4: catch some false session retries

Marc Gonzalez (1):
      ARM: tango: Improve ARCH_MULTIPLATFORM compatibility

Martin Kepplinger (1):
      mtd: rawnand: gpmi: fix MX28 bus master lockup problem

Matt Ranostay (1):
      iio: chemical: atlas-ph-sensor: correct IIO_TEMP values to millicelsi=
us

Paul Burton (1):
      MIPS: VDSO: Include $(ccflags-vdso) in o32,n32 .lds builds

Russell King (1):
      ARM: iop32x/n2100: fix PCI IRQ mapping

Sven Eckelmann (2):
      batman-adv: Avoid WARN on net_device without parent in netns
      batman-adv: Force mac header to start of data on xmit

Thomas Hellstrom (2):
      drm/vmwgfx: Fix setting of dma masks
      drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user

Tina Zhang (1):
      drm/modes: Prevent division by zero htotal

Tomas Winkler (1):
      samples: mei: use /dev/mei0 instead of /dev/mei

Vladimir Kondratiev (1):
      mips: cm: reprime error cause

Vladis Dronov (1):
      HID: debug: fix the ring buffer implementation


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxmhKkACgkQONu9yGCS
aT6HbhAAs58ujWqmzhlROkD4ZpmSN5nW3A6R9gxILsVXd0IqvHu1061hrQqLlfyk
09YlaU/R2HlQguDM8Y0otQtteunwV0wuM5sptg984DriVuhochRo/2mjNi/FvAAW
ATGE30Qdx6/Hhi7Hi0yE0v45RipkXl69hZiv+hDwy1VdSVtGMhJl+b8LUxOlcRf1
jA+kDpEOyUeWvHinMj0QTtSWtOZZJDRWY2YbQKEeXeWQAPD8QKq5uK6U9iWQAtyv
xt5v76LmfzY6CdWC2wt60EE+uXCBYq95633NQpPqzS0ap3iKyL4JFWDKTVz7UAE3
DxJFTX0vRWU5Mi3d2LGrET0+vOgUIoPfF3RzCqNjTx6m5TdTlkwIWYhLIytHBghw
1oqhhoi3QvjVopngWLajm5paB+1G1Ib5bLX9VnO5t3RywVQPnINJBBZGiwdnedYz
tdSuWqFKBtkt5BlZgtb8zqeCAZwfYmbdRHooU2ncpIzEtcPtv+MfiM6/g1R2XeGS
hZ4Hyok9JCTV26VAUG9/ht1Xgy/5gnxkl2jnOw/hvSePl8Z619dcU2uJHQ/16U2/
dQ23y9g6ynxZT68Lx5Qya3YTZ4R7l9O1afiZsjKa2YVpbdok49J8JaIQ/KS/2NUv
O/Uoo7EuIJJQEZQQxcS0pYrXi8+M1Vs1qaWe+sMYvPggZeMMuQg=
=/LXk
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
