Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbeCYJCz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 05:02:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:4473 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751824AbeCYJCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 05:02:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,358,1517904000";
   d="asc'?scan'208";a="214623381"
Date: Sun, 25 Mar 2018 14:37:06 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dma <dmaengine@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for 4.16-rc7
Message-ID: <20180325090705.GE15443@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

We have a small buffer over flow fix for stm32 driver, please pull to
receive this.

Also note that somehow I was not able to push it at regular git.infradead.o=
rg
server I use, so updated on kernel.org tree


The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git tags/dm=
aengine-fix-4.16-rc7

for you to fetch changes up to 3e4543bf20531d1cdb8672d25b3f2ff6d3d07627:

  dmaengine: stm32-dmamux: fix a potential buffer overflow (2018-03-22 10:5=
1:35 +0530)

----------------------------------------------------------------
dmaengine fixes for v4.16-rc7

One small fix for stm32-dmamux fixing buffer overflow.

----------------------------------------------------------------
Pierre-Yves MORDRET (1):
      dmaengine: stm32-dmamux: fix a potential buffer overflow

 drivers/dma/stm32-dmamux.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Thanks
--=20
~Vinod

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJat2a5AAoJEHwUBw8lI4NHO7AP/i6XSXnzzN8l5RKRqBRdfp4f
vcoDSgcTrVWZFWqxyCKGLlbLr+m3E38BpYNHHtcMvk6ZQW+MdUfdJg7LGfG1uBz8
zd190m1CgGrvvL1bnUGmHqTpE0G5kikpvh6eEEH3jr4zihki7TBnJqTQb2tRdyiV
mn9MFEb3+5xjgvDZvHjv3x8a3gGxZvwyeeUuMwKEnTgS4SYJ4vEuxJ2ZR8bZGTr/
c0FHAvl0ul+aBzFI3ZGiLW8iQIkHtl19U3vpgpUDtPNICxLdv5Miq2b1EnP/DgOc
Bo3YOcebpcp7lutccbdOF4RCaXLZCD9DHAKbtKSRj9aNAvp2GiZnEtzQcm9JBfO3
JkjXUs+5YQzJJBzhMy/1HyGO6Og57Owp5poPUorxlIDvuTY39iYzCN7qNt4MvgyF
ebFFEy7tnn9lt1DBRbvPwbj1MwuENkcPhJhboS3eZ7upZPuz3ju2WHYXW0Vl2DtD
1sZhgk/1DfYVCve/9hlXzhCK3Sys5n4/JZ60pZBwtO/lE/M8A/a8s/IIIfrN4oQb
+1Bv9ttC2HQZKQy6P+SNYz3S/Phy0cZz/C4IpweeO2uxEtjsDs/fQsuTJ6PrzZn+
+mBsg22XDT1IrCKiDCXWf73wymQUuy4zuwYNREBXNg/aiG6M724xi8wkp1KT3UeN
OBkzGy1vvXcSUEp/Iam1
=UIRb
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
