Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751992AbeEMV5v (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 17:57:51 -0400
Received: from ozlabs.org ([203.11.71.1]:60309 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbeEMV5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 17:57:49 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 14 May 2018 07:57:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, Mark Brown <broonie@kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mediatek tree
Message-ID: <20180514075745.168494a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/svJhzfUwds8bOQU2QaR_QVm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/svJhzfUwds8bOQU2QaR_QVm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

Commit

  f039c4193c93 ("iregmap: include <linux/ktime.h> from include/linux/regmap=
.h")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/svJhzfUwds8bOQU2QaR_QVm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr4tNkACgkQAVBC80lX
0Gy8wAf/TiaQxUgRZnzuNbJJjV0ZrlkJ1nS7M6+41HHWzp1TS2hOSK5R8tV/SaZx
NgYjRNKD/cAItztDhMTSYR+HBdPsFTbc+9dp7YpUXAW8sGsJhgCbK6qVsqwLBuFD
vSbxBbFjY6rOshbwBwCME6r6/cgyZlng9lDqMkGMTI6FrS33F1GcSHEsOmnA0+f7
KpYCh/DBX7HmXPoZ6bY15Hcavn/6evc586sTcXmCEmwsBEQJ9gFTW7UP7XOr7h2W
2XRkibexOmEeQli4TutOVaRge/UgCVGX6Be9n/Rk/LLeqgktfWv5R4smF1jkpWRt
GfC/mFOTE3XP4xfkVAvGX3W4Ng3I8Q==
=/gme
-----END PGP SIGNATURE-----

--Sig_/svJhzfUwds8bOQU2QaR_QVm--
