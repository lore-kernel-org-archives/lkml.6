Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbeCHUrZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:47:25 -0500
Received: from ozlabs.org ([103.22.144.67]:41379 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbeCHUrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:47:24 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 9 Mar 2018 07:46:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb tree
Message-ID: <20180309074653.03c1081e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YNOFvf57PC5ExV4CTwQRpER"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YNOFvf57PC5ExV4CTwQRpER
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

Commit

  3f127ce11353 ("media: em28xx-cards: fix em28xx_duplicate_dev()")

is missing a Signed-off-by from its commiter.

--=20
Cheers,
Stephen Rothwell

--Sig_/YNOFvf57PC5ExV4CTwQRpER
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqhoT0ACgkQAVBC80lX
0Gxibwf+JgHbpJG7mwNK5mqgDFUOZy+ZWW1WxeJZKIn3wUGPJJBjfw8QqJsk6YWN
+QQ1QvINJy7DaJ82SuQcdMcF/Zli4en+qx/coGFeAR7rJao/k+ivNrhyVJE1IvzQ
mz1zPcaK9xOFK4PmdXkqvtIws8oNzSLUvEOgZh+skDAJovyPnsxxRllsZ3dumxiB
PqqeUHEcZgNHyqRASogeZ25iCoOgGKWBgTxICuwuLmz6u1I+lJq23FPX4r/GPzE0
BIWE1r4eZKx9t9OwcyoQ/WvTxBG/lOQ0tVHzh2PK7Sa+rkZh5K16xUxq3r+/a1iH
94gf0zig4Sdvb99aoW6+6rdaJhUxsg==
=LaH+
-----END PGP SIGNATURE-----

--Sig_/YNOFvf57PC5ExV4CTwQRpER--
