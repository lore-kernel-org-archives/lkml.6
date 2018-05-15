Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbeEOV2B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:28:01 -0400
Received: from ozlabs.org ([203.11.71.1]:48995 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752357AbeEOV17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:27:59 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 16 May 2018 07:27:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: linux-next: Signed-off-by missing for commit in the pinctrl tree
Message-ID: <20180516072753.49dd4d88@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Esv/mj_+i4EI9eXRJgfxgNo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Esv/mj_+i4EI9eXRJgfxgNo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Commit

  f18fab4bcb4f ("pinctrl: sh-pfc: Add r8a77470 PFC support")

is missing a Signed-off-by from its comitter.

--=20
Cheers,
Stephen Rothwell

--Sig_/Esv/mj_+i4EI9eXRJgfxgNo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr7UNkACgkQAVBC80lX
0Gyt9Af/Srrk1V+BIzb9JPSHNejyLMfpMmeohjYukPtnTS9i9mjGAoda6sCfZASz
Os2rCvv6H8DOd3WE6oAT/pGgd7zzA7hLynuYFgLvCaB+3GgkLZLo9KELt37IzqBo
6ts6OTGcZFrb/+L00enkEzDRS7TJtWZuca2LsSYLhjzvQZ//PQwrNmfsek0v7M0Q
UQjXCknbGf5CWwmFkgGI1Bj+5/ijwQ5pwyS/9/1OGZslbAYu0QrjdB40MUDLggII
StW0CbIcc3dUw5eqFzzxXCVeZd+NRl0RAPao8GMOB48RVIby9+0NSz1niHSeqmQ7
rd0x90Tur+NC40x0JwRfC9r3bxOoiQ==
=fO50
-----END PGP SIGNATURE-----

--Sig_/Esv/mj_+i4EI9eXRJgfxgNo--
