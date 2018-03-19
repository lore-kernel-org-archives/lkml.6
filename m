Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755397AbeCSINZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:13:25 -0400
Received: from ozlabs.org ([103.22.144.67]:49731 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751747AbeCSINU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:13:20 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 19 Mar 2018 19:12:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Kelly <jamespeterkelly@gmail.com>
Subject: linux-next: Signed-off-by missing for commit in the sound-asoc tree
Message-ID: <20180319191244.34ac823a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/w=T39DbJ=uH1yGrW8gVly_R"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w=T39DbJ=uH1yGrW8gVly_R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  b9f6c09ae07c ("ASoC: ssm2602: Replace reg_default_raw with reg_default")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/w=T39DbJ=uH1yGrW8gVly_R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqvcPwACgkQAVBC80lX
0GxhfAf/adJMGmmYuDS7UJqj5G15sTkVuFJQgp3gYeydhUxlgCnGO6ah49kY/kOI
te1vXAu+XKwaCzctyVp3GTmeMSZwupo+AgFb7BPYW2YFM4hAZE63RHKg5tPLP4Ct
NYMDHqxE/AxJctxVr0xzjMqtYH1jdvd250NOI57EnZloSRZzS5NXJcOVgaGlKapS
No0GEw2kE41B54aDAT2W8lyh0iKUJVMR6Rj3dV8OAQl+ULXYnghKgIYVWSYYO9PW
oIlPbjhlqbclBUeOT97gUb+ow1yX7rxI+vHd28iCytpKbNjTdrMSwcNBVROBJBZz
BkOoWOg5Ai94ILyeM1ED+44ewNVFyA==
=93dT
-----END PGP SIGNATURE-----

--Sig_/w=T39DbJ=uH1yGrW8gVly_R--
