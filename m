Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeCCEwt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 23:52:49 -0500
Received: from ozlabs.org ([103.22.144.67]:52749 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751732AbeCCEwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 23:52:47 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sat, 3 Mar 2018 15:52:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pinctrl tree
Message-ID: <20180303155232.1e9eecce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CtjNEGvDgOecl_cLh2ytXYQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CtjNEGvDgOecl_cLh2ytXYQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Commit

  77bd5bf24c08 ("pinctrl: sh-pfc: r8a7795: remove duplicate of CLKOUT pin i=
n pinmux_pins[]")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/CtjNEGvDgOecl_cLh2ytXYQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqaKhAACgkQAVBC80lX
0Gznlgf+NxWNxQ4N4qI1Jn5GEaFMY8VNwLLfPaAzK8G8TvFACdXPelhQ+G1PzcUY
Hi+eDG9CoHP87Fyt0/GOZIyOo7e+00foKchk5GW4wlZLGb2VlpmfJPvgKUitg5Dl
2dytg3hdSdz6NKwSXMZzJn5JNMLbbnBj6LUEqNEy6DiZSn4+fenWC6YIokpBHdh1
qB0UhoHWP+Ykp6eCoGl2wManOqsTmnSaroT0DQYDgA/JPB4d8vgtfAUrBPOL1uux
9J8NohFCx1/8oMzSjlqdr6cs5Rw404DGQsd9r734IbzaWnwGjXZl23lbOV4UDEBK
xmMBYxaEqc/ocFfQ2FgyFGIrPwMDCg==
=XzWR
-----END PGP SIGNATURE-----

--Sig_/CtjNEGvDgOecl_cLh2ytXYQ--
