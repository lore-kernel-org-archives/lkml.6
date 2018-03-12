Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932506AbeCLBkf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 21:40:35 -0400
Received: from ozlabs.org ([103.22.144.67]:35315 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932419AbeCLBkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 21:40:33 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 12 Mar 2018 12:40:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sebastian Reichel <sre@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pierre Bourdon <delroth@google.com>, Andre Heider <a.heider@gmail.com>
Subject: linux-next: Signed-off-by missing for commit in the battery tree
Message-ID: <20180312124007.61288892@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tdX_uVXC7iujCXZws49o4cF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tdX_uVXC7iujCXZws49o4cF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

Commit

  5e0dfcbb1194 ("max17042: propagate of_node to power supply device")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/tdX_uVXC7iujCXZws49o4cF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlql2ncACgkQAVBC80lX
0GzxvQgAh5kFT4cwqJnq1X856kadaoIoDRmaOJX1BL6XqNQ/RAlgy8v6tU8GozUp
8GEqbS5Xlr5gCWsYuEHaXMHLjO15dwPz5JCg0W2c89OeBY/XT21M1+MYXxs9m4TI
eUUKeG60OhUQuOc9A3KdFKkdErm8MyxfQfq0hhZjfIRIcwRAjbXFCuFEANaFibI4
+Ym3X+J0XkXjjABy3/J5X45Y6VX+4aBi0mFmsr23FKlg355orH4Th0B+Z1zUnDws
mMBDud+Odep0tASj1EO84GLPAUKc8gH1mw5cWP+9AVdKzTqfMTz6MCeYHIbbU9ZV
XgWL/Ja406X4qDsAexNqdS0e81xfxw==
=1sfl
-----END PGP SIGNATURE-----

--Sig_/tdX_uVXC7iujCXZws49o4cF--
