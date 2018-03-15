Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeCOH7t (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:59:49 -0400
Received: from ozlabs.org ([103.22.144.67]:42699 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbeCOH7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:59:47 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 18:59:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the rtc tree with the asm-generic tree
Message-ID: <20180315185917.3316d781@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/b6CSQU/PkJDhO/EygTvpcBL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/b6CSQU/PkJDhO/EygTvpcBL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

Today's linux-next merge of the rtc tree got a conflict in:

  drivers/rtc/rtc-tile.c

between commit:

  909ce75a0665 ("rtc: remove tile driver")

from the asm-generic tree and commit:

  1fbcb2aa1d64 ("rtc: tile: remove useless message")

from the rtc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/b6CSQU/PkJDhO/EygTvpcBL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqJ9UACgkQAVBC80lX
0GweIAgAgcZMYSNV59Rx8Tunj7Wyrpz/ZlAqV1vEceqUSKAaM9rxZAunjKWq8xJU
gVsNhFjrt7Ec5SNiMKwYdKzaAZsLo5XT+N/fM8kUYl2lgPiiPgiLtxewgZoAKYaN
ar8++/+iOgC4VPTK0Q6ZWAxBBvlLdQnPSRdjMURTuMVWMBLzmDnkz1rk7RjCGvMk
tSWVXE6jiieUZMMzEhjrSpoXMROflr6WTtvHEC5Wkww+xK5nityCMQMhxfFBqqHj
SSe1H/Q4AR4SOLGjXD9CvC183VP54Ye9yxTfhAOz7ZH2EiGwaYMR+57TjV1r7a6L
RDwYWzWYnuEu0dCWIPQkHlKJyZdiyA==
=LUMj
-----END PGP SIGNATURE-----

--Sig_/b6CSQU/PkJDhO/EygTvpcBL--
