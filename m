Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeCZCHN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 22:07:13 -0400
Received: from ozlabs.org ([103.22.144.67]:50327 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbeCZCHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 22:07:12 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 26 Mar 2018 13:06:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Wolfram Sang <wsa@the-dreams.de>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the i2c tree with the asm-generic tree
Message-ID: <20180326130625.46b94712@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Vw/+VGODpb3pYak+6voHrrM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vw/+VGODpb3pYak+6voHrrM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

Today's linux-next merge of the i2c tree got a conflict in:

  arch/blackfin/mach-bf561/boards/acvilon.c

between commit:

  120090af2745 ("arch: remove blackfin port")

from the asm-generic tree and commit:

  eb49778c8c6c ("i2c: pca-platform: drop gpio from platform data")

from the i2c tree.

I fixed it up (I removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Vw/+VGODpb3pYak+6voHrrM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq4VaEACgkQAVBC80lX
0Gxdlwf+Puj4YXCpigp37W29PKgBvMwJl9a45CEgdMEz1MfdY1aT6cr/Cqv/kAFE
wmw3S/ZFiqniPGEHJr5fgV252d1Ma6jR9G6NqW2hK80C2c/2Hki8490UIdFfsGl9
2Hq+iOy5lUlG2pKiHuMLn+w118738GEpZ85UCHAU3cc8RBulHZdYlVfXR4ufhso7
kBgMvLqf5BSzJaP5xHBAF6liJ59f54jzealy8/2/nyv09UKEqfBZrSsdJL6QjADS
5kL+ALjcsXP7+6W0N3Fmj1Iwr889ITLJbKPeTnB+KqLk35y9X+sig5HCioa433LZ
eCYyvxnGMcLy8heSqxD1BTpNenJzgg==
=KFGQ
-----END PGP SIGNATURE-----

--Sig_/Vw/+VGODpb3pYak+6voHrrM--
