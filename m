Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeC3D2r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 23:28:47 -0400
Received: from ozlabs.org ([103.22.144.67]:48527 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752487AbeC3D2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 23:28:46 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 30 Mar 2018 14:27:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: linux-next: Signed-off-by missing for commits in the spi-nor tree
Message-ID: <20180330142741.4266629f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cuQvGAT2=nved=W9mFj71Ft"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cuQvGAT2=nved=W9mFj71Ft
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Cyrille,

Commits

  3efa50903ff3 ("mtd: fsl-quadspi: Distinguish the mtd device names")
  85da6da22843 ("dt-bindings: fsl-quadspi: Add the example of two SPI NOR")

are missing a Signed-off-by from their committer.

P.S. should I be changing the contact I have for the spi-nor trees?

--=20
Cheers,
Stephen Rothwell

--Sig_/cuQvGAT2=nved=W9mFj71Ft
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq9rq4ACgkQAVBC80lX
0GxG/Af/TiE7jaWI/bEPIs3ME5Qy7DClrh+MHtUDH7AQmHG5gfbMfpvQM8P/r1di
+QamUDVCqDd856veO8CtfKtJulVmpzdXMcxCcfsqROtRHMofJPDPQsH6ILfikZZP
IjmqQPx3HZj3ArUcXVx9geaSqQKEbvvjKLCng8+/zGQJ8JBlIhDqp5WEp+ZGTTKl
V/QwR0vAU3Z0ZpvhNUFIxLWwYN7bvkvkT538RP8NJmPhfeRFpPKeW/IRRndvUUW2
znuHZT1kEbHLhkwa0LtwZB+QMFuJcwsj1WEHo4YSqGYiYi2gHOYWRXkLSvakEgGs
xOqbMdJ35ifpWW3B9eyI4UsKXC4Khw==
=Rdnd
-----END PGP SIGNATURE-----

--Sig_/cuQvGAT2=nved=W9mFj71Ft--
