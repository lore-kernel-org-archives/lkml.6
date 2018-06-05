Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeFEVsk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:48:40 -0400
Received: from ozlabs.org ([203.11.71.1]:35147 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753129AbeFEVsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:48:37 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 6 Jun 2018 07:48:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb tree
Message-ID: <20180606074829.2c8687e7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NUJCacTjC_M013vPBX2+1u+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NUJCacTjC_M013vPBX2+1u+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

Commit

  f2809d20b925 ("media: omap2: fix compile-testing with FB_OMAP2=3Dm")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/NUJCacTjC_M013vPBX2+1u+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsXBS0ACgkQAVBC80lX
0Gxrlgf/bwcr4xb5Z+HUMHSeoACRYrEuyvU6k34ZOqMUAtmdoAzAouJamoXTM+HA
EPZiAZHE9fgfIdwAAPN60MXLQOMpJqp5E8b1cgm07b9txRzeaCnwYJKa/GsDX7dJ
+2E0A50XaleDLhH05sgrzGDsTNj/+KSuuJy3ZS9VWVCMC+KQVELsi/nZ0boNmRq6
kTzlxEFKWgOggtmnivER38HW2+jeFg8sgU9m1vJfzjmFR6RIaHSaMgtSrbW7SLuv
uSFsoPCp58tjxK96ihy/cRpBrpE6FMJY/Wav8rc7whYw99tloNcqRHV6Um3POxvg
W7mc+aOguxvByZ/fOxsKVnlEBgyUMA==
=BAa6
-----END PGP SIGNATURE-----

--Sig_/NUJCacTjC_M013vPBX2+1u+--
