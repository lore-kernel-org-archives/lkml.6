Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeEQQsA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:48:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58950 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752830AbeEQQo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:44:56 -0400
Date: Thu, 17 May 2018 14:06:11 +0900
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 19/19 v3] ARM: s3c64xx: Tidy up handling of regulator
 GPIO lookups
Message-ID: <20180517050611.GG20254@sirena.org.uk>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-20-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
Content-Disposition: inline
In-Reply-To: <20180514080640.12515-20-linus.walleij@linaro.org>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 10:06:40AM +0200, Linus Walleij wrote:
> From: Charles Keepax <ckeepax@opensource.cirrus.com>
>=20
> Rather than unconditionally registering the GPIO lookup table only do so
> for devices that require it.
>=20
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> [Fixed up to also handle wm5102 and wm5102 reva]
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Including this in my patch series.
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

You need to send this patch to the Samsung platform maintainers...

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9DcIACgkQJNaLcl1U
h9BO6Qf3QIs2J03yk4W3q7mErdQtaoch7R2UYRCOD9cgn1ZtcmAbnvHViU7KRFGK
w+MEFkQAb89AOwwj7laeMTYuZLZO2RPK11WwhEdsX9q+79alfmKXacQeNrTkYvaG
RnfrhTN3DmoTi2QuzdjVeLcgJU4cc1PR1u6Bin4lbO4BIlFWpsXnY3Hoz8y+sY/N
fcXCUrWtLfE3IMuuirn2doSX76y7wvI86E8zseyVrH78HQhT1NKx/b7NFwDrJZ5k
grp4Fwfw97yl3N8wTACpbH06T7Ikdv8SRUbH0cgWSfzGLUH/WnGjuSE0Tl3umb2U
7JB5m8BMKUKi2Jge8Wu0pxW+7OJR
=vsN7
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--
