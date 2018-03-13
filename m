Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbeCMXCn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 19:02:43 -0400
Received: from ozlabs.org ([103.22.144.67]:60781 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932580AbeCMXCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 19:02:42 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 14 Mar 2018 10:02:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: please clean up the clockevents tree
Message-ID: <20180314100213.61168207@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FtgiuxeN0AyWZ0ozvNNEojc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FtgiuxeN0AyWZ0ozvNNEojc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

The clockevents tree appears to only contain an old version of patches
that have been committed upstream.  As such, it is only causing conflicts.
Please resync with your upstream tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/FtgiuxeN0AyWZ0ozvNNEojc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqoWHUACgkQAVBC80lX
0Gxw/QgAkj/fcDRvqCHZMAjRmjkpRjKs+k35cLS3XLtcjnL0MTu92gOmuyL0cwJa
CUu/Y0+V2WWPV3Toq0vLxjHpB4s1iN6wxGJdrNBQi0yKinBHnErDU+EcsQENJ3de
5Ic9zfwD4EcwBDxiwUH749yyAcBuIu2ZbDhxvdNvmeLivQMpmmrjMSEoBOOvxLcK
AtU7p/PgvqiEgBY2M1k0OZtvDELkadmw0s//cCA9mhJbV3+5o2j1xf131abR6Mht
lktqUvQhFm+NMeDyDvGvjXVuJJRjz/PYQjMQbycnKu4iJAHkSKKWCgd+zJB/fUmy
uPORv2q49PgyAXFgtiPGZpBFS4uyUg==
=aNuD
-----END PGP SIGNATURE-----

--Sig_/FtgiuxeN0AyWZ0ozvNNEojc--
