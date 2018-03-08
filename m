Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeCHUzV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:55:21 -0500
Received: from ozlabs.org ([103.22.144.67]:34123 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750857AbeCHUzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:55:20 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 9 Mar 2018 07:54:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jessica Yu <jeyu@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the modules tree
Message-ID: <20180309075457.5fb444d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iv3AWUYQh9ry3AgmJsSKH/j"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iv3AWUYQh9ry3AgmJsSKH/j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

Commit

  934ccf7248dd ("module: propagate error in modules_open()")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/iv3AWUYQh9ry3AgmJsSKH/j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqhoyEACgkQAVBC80lX
0GzcMAf/a0Kga2lq0fFUrPt/V7lqSjlGLk3jms5XJBPHZWd52HS7u+kczuo3ZA9Y
ybZ62eAJQq3WAT12m8YzBgL11YdiFBFqNymrLbZqhEbWIs00Zdz8eDdJQhQKRN61
kTRgAIysaa5zc93X680XUsV9+m+cdP4LtwHrzkMbW/K4SMsZo5RpG0gGhKsvR/W9
eV1D95/hcyKHKhbjnz/AqUSLkbOmcliXL37XzBZDVgyVY7ZN2+mUa1y4Mmdy2pBm
o/EZi3vZqCTin4P16ILVk+PxCkQfuSr444oVfJkiam47p2KwPzFfBBNeW2sWjipI
0WT06IW1IBK6J37ewipwBK2aVjYz2A==
=5wn+
-----END PGP SIGNATURE-----

--Sig_/iv3AWUYQh9ry3AgmJsSKH/j--
