Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeCOCwY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 22:52:24 -0400
Received: from ozlabs.org ([103.22.144.67]:36195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751532AbeCOCwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 22:52:23 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 13:51:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Kamil Konieczny <k.konieczny@partner.samsung.com>
Subject: linux-next: manual merge of the crypto tree with the asm-generic
 tree
Message-ID: <20180315135153.493712ac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fUabfP7OpigJFAOAKd/3fN2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fUabfP7OpigJFAOAKd/3fN2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

Today's linux-next merge of the crypto tree got a conflict in:

  drivers/crypto/bfin_crc.c

between commit:

  1d77094897bc ("crypto: remove blackfin CRC driver")

from the asm-generic tree and commits:

  f1b298103e14 ("crypto: bfin_crc - Add empty hash export and import")
  5471f2e2b5ea ("crypto: bfin_crc - Delete an error message for a failed me=
mory allocation in bfin_crypto_crc_probe()")

from the crypto tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/fUabfP7OpigJFAOAKd/3fN2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqp38kACgkQAVBC80lX
0Gy3lgf+Odtdzp3zexoe/cthTjIKijFco6kZa3xN06GMqnIXfWmpuiSfgXySjpjW
a4mA/w4FIChLIuoM984qsHZQ8g58njFhMgbqiPnaR2+sC7B88HUo3AoWM7eBiv0a
k6JO4Exr3q3eVtVfo940CRfRytb3S2/6n9BfUKUSah+4Fl2J19bHAJ+f0t+5LWaO
Vxiap0h45rSyPMdAFO6nQ6/16JesM8SBr1u9mCt6Zs8Won2HYlkU7iJXcfKHVuWY
7VKkJdzM+8gew4Fbv+gIJheKOE1o5YO8cMijQPJ/Fpfx346cOiO1BN3bRO6GOMzQ
9YoeX8Hu8G8fzcSztCW1jm7KJYb7fw==
=Femr
-----END PGP SIGNATURE-----

--Sig_/fUabfP7OpigJFAOAKd/3fN2--
