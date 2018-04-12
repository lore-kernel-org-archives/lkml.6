Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeDLViR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:38:17 -0400
Received: from ozlabs.org ([203.11.71.1]:35713 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeDLViQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:38:16 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 13 Apr 2018 07:37:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: linux-next: Signed-off-by missing for commit in the overlayfs tree
Message-ID: <20180413073705.55178d78@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=jziDdFKrKp=Ao4wRXrhWi1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=jziDdFKrKp=Ao4wRXrhWi1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miklos,

Commit

  0471a9cdb00f ("ovl: cleanup setting OVL_INDEX")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/=jziDdFKrKp=Ao4wRXrhWi1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrP0YIACgkQAVBC80lX
0GzPewf9F60GFetJCJpgvZ33cwjf8YMvbYnPexvnm5kn2GOahMUhIS1zqnmJERz5
+Ly1EaXjd3kOmjNYjx7Smgl6IcW6PulaH676j+jA2uwrB/9+bqrEU36VGZ4OvaUu
Mi8V0TsJbw1bcpq9ckcf/um19VTlM4vbj2A/4WvO4dx/gAn276Xmp7YOsNaNrckS
9kxwxncyfA+rW8Uaux9gXTaN7UEKvRLEAJkhBL1xV7XAxkjX9eb2yOMRMO84Z5nI
oz1mx1mSx6vZbop+PHqpJKIcHRWNr90BoeovPQaxfteU1UmiMcLRahvzToB+jvCY
L0j3iaM7cHNJ/sQ/ONpP+vnEqH8RDg==
=9O6G
-----END PGP SIGNATURE-----

--Sig_/=jziDdFKrKp=Ao4wRXrhWi1--
