Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964843AbeCGUjy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:39:54 -0500
Received: from ozlabs.org ([103.22.144.67]:58671 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934800AbeCGUjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:39:51 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 8 Mar 2018 07:39:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pinctrl tree
Message-ID: <20180308073921.5c104e74@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AY4ut3Ltsegz7HJcIBs+xRe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AY4ut3Ltsegz7HJcIBs+xRe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Commit

  fc08fa6009a0 ("pinctrl: sh-pfc: r8a7795: remove duplicate of CLKOUT pin i=
n pinmux_pins[]")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/AY4ut3Ltsegz7HJcIBs+xRe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqgTfkACgkQAVBC80lX
0Gy0jQf/dOK5CE+vY9IR8xZ0gNZWtMpff6wH2R+si5pElt/kFi3oZS/uWA06YDoA
kgOwRJOMG+5VEYomVbI0uRP8EcCxtVOGK1yhkzaHw/j5APVwRsdspNOqJzUB6KEk
ot4ix3cPosZgSCdOddpk8yzXW3cc3cgx/DvFooPcuLwvIpg5Q3vBCLNKN/+DB7lC
R6wMnPDn7IwUYfYDtQa0PRYT1YVenISQWYrn7gO+MtG1iMvVgIaNZZ8GZ0ECTNWp
OARcakW+AuKSCTYxnU5Sgf7k67A+Y9MpWjIl7VGfk/r6Z9rekxGPOxBjCGN+f2jQ
bTTRmwPt1iwovO2iBzWugv3MRjfeNg==
=B4R3
-----END PGP SIGNATURE-----

--Sig_/AY4ut3Ltsegz7HJcIBs+xRe--
