Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbeCOFMF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 01:12:05 -0400
Received: from ozlabs.org ([103.22.144.67]:57185 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbeCOFME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 01:12:04 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 16:11:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Magnusson <ulfalizer@gmail.com>
Subject: linux-next: manual merge of the spi tree with the asm-generic tree
Message-ID: <20180315161133.0d3867a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oXD8UiSXlv0iMz.JlU4Zz4b"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oXD8UiSXlv0iMz.JlU4Zz4b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

Today's linux-next merge of the spi tree got a conflict in:

  drivers/spi/Kconfig

between commit:

  588020dcb92a ("treewide: simplify Kconfig dependencies for removed archs")

from the asm-generic tree and commit:

  e3d001a0c29d ("spi: kconfig: Remove AVR32 dep. from SPI_ATMEL")

from the spi tree.

I fixed it up (I just used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/oXD8UiSXlv0iMz.JlU4Zz4b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqAIUACgkQAVBC80lX
0GzLhgf/cGOau1IOxt7Md9dTRl8VtYOrbE2JApg/ePcu5W6xVjbQSxJpqTrZPv1H
Wd0ZsiUqznszPFN+E4r8rqfOBs6cbUp+Rs0MwqBwp4aTh4Rgtn6hU+2QovKGcOsr
hRmgg2SY5Kjd1/fAZihpWIjMfoRUgwgyEb3RpFzTkLkWd7bLzE5MJG0FCzJAoA9+
d/iD2Cq6hkfaSfyku1vVeeP+SZpY475wqnr+n7RJKvNzsb5Wj7h9Rsv/f9e6Ux28
3JCSLa3/MLE4SS4pY4cldbW3gziZXaFZxsYxHC8gmYFNH7oJ91/jVtEC3JavzPzz
6BwcvHUoEjQkZ7IqNmzRfRxdT7CohA==
=bxD8
-----END PGP SIGNATURE-----

--Sig_/oXD8UiSXlv0iMz.JlU4Zz4b--
