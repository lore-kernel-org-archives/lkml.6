Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeFALgn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:36:43 -0400
Received: from ozlabs.org ([203.11.71.1]:37801 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbeFALgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:36:42 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 1 Jun 2018 21:36:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haruka Kawajiri <yukx00@gmail.com>
Subject: linux-next: Signed-off-by missing for commit in the drivers-x86
 tree
Message-ID: <20180601213639.74f49e51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pI65d33I1.Qw.zG9FR/PSYn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pI65d33I1.Qw.zG9FR/PSYn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  bba074f926d1 ("platform/x86: silead_dmi: Add entry for Chuwi Hi8 S806_206=
 tablet touchscreen")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/pI65d33I1.Qw.zG9FR/PSYn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsRL8cACgkQAVBC80lX
0GwdxQf+POnkkwzFMbVudyMG9B7aD/vudIOfSgiIj6IUlVAn5PrvJv1Jb0FpdiKq
nFPo56yOvJCy4osiXdKdDgs1CkJ41Uy1HuPnnqEfYNyMUdjpfY4dMrnt9Si88POq
f2GUnmKlVHMe3jvvdMPJkGe/6PzTPQ+qFvOhTnXu+Rq3JoyUwxLM7g8nIH5Xvurk
LMVkAD9oxu2znC/PzPtE+fvIYf8ptE/G5gvIVzL7NVLXmEyfuYyk9TXODuBZZPu6
YTKTtPQkgLZ1SCO2ktJUOtQxv04MU04hQslCoouNTNXDGpQpQlOMAvNkDy/ZWif6
tnVgyEGIX9L1bP2VL02f5zOALXTsEA==
=blwO
-----END PGP SIGNATURE-----

--Sig_/pI65d33I1.Qw.zG9FR/PSYn--
