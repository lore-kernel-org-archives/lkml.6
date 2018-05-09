Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934383AbeEILnq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:43:46 -0400
Received: from ozlabs.org ([203.11.71.1]:33259 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933832AbeEILnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:43:45 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 9 May 2018 21:43:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: linux-next: Signed-off-by missing for commits in the thermal tree
Message-ID: <20180509214341.1d490677@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6y1WxWGFFE1sCTC830RL8g6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6y1WxWGFFE1sCTC830RL8g6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Zhang,

Commits

  a2ace598c00a ("thermal: exynos: Reading temperature makes sense only when=
 TMU is turned on")
  f9cd6a904e6e ("thermal: exynos: Propagate error value from tmu_read()")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/6y1WxWGFFE1sCTC830RL8g6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlry3u0ACgkQAVBC80lX
0GxERwf/WvjO5TL1qR9yVxGf+BMoIVbhaA7qwslel1k94mN7QNERgt1OIF1NSZkl
TtyoNnNP1TSt4ZW+HBDDsCJoewTuKjX0BbIhpdkBo4GSZG9HAH3wgfux8v9VDR1j
M+2qQsk5H9CaLnFY1uzpMFz24foS7FxdGIhzlBDLJbzLgz5r1JefhoQfeE1GPM3c
jztwfaCqUsjgysq1nEwivp/nuW7j5lBJl9vBxPJ0WYbW/etXty1RAsdddrt7QITW
lSwmMcEIdyLeHmdrJNc367Ub0ipT2nGWsEEPdNcEcmS4gRKKpWK7hxS78MJ//jfY
o5/s7z+q+wbjQAR7ZELD0xP1aCwfrg==
=qOM9
-----END PGP SIGNATURE-----

--Sig_/6y1WxWGFFE1sCTC830RL8g6--
