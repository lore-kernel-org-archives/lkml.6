Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754292AbeD2VS4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 17:18:56 -0400
Received: from ozlabs.org ([203.11.71.1]:51947 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753855AbeD2VSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 17:18:53 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 30 Apr 2018 07:18:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Israel Rukshin <israelr@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20180430071843.2687dd5b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/R4ZTTxk_jW_VrOsu/tDUFwa"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R4ZTTxk_jW_VrOsu/tDUFwa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  6082d9c9c94a ("net/mlx5: Fix mlx5_get_vector_affinity function")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/R4ZTTxk_jW_VrOsu/tDUFwa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrmNrMACgkQAVBC80lX
0Gyl0Af/bNVJi5EVgz6s1yiV72JSz5AjvM0d9+ZX9cgOj5Sb52OeAEAMUKFc3ixH
VHXPGnueGIUL0AtPH+VnrQH5NWvXL1yCx19sPJ18cPUJg4TYWAR/gx/EeHatsN2V
6jd0ADv6vbxUViPToNT1QZa+68Hhl1Lll3oTiAktDGsnEm7KgkzlN09+Dugzw7lK
FVN0KlF8qWGu2TBQpfFAFoMA2EGRlb/ASgkqrUN11+lisIEbQKrndX8KXtQG7oIy
TGel5TQi1JAs5c7xR4Bdacu3/lNTl5J+Dc3Fj5NoiE096O0gPgR23TwIGmPYFoaS
VsbkpDy/MZrpi/S+xVo+Z5RTdxGbig==
=Vg+g
-----END PGP SIGNATURE-----

--Sig_/R4ZTTxk_jW_VrOsu/tDUFwa--
