Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbeERP1G (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:27:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53565 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeERP1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:27:03 -0400
Date: Fri, 18 May 2018 17:26:51 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 12/26] drm/sun4i: Add support for multiple DW HDMI PHY
 clock parents
Message-ID: <20180518152651.lfymc3kj7npj5tww@flea>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
 <20180518094536.17201-13-jagan@amarulasolutions.com>
 <20180518100116.4bf2qcffg7ekxa7u@flea>
 <4909574.Q3IFWM0xt6@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tvit4m5thudok37l"
Content-Disposition: inline
In-Reply-To: <4909574.Q3IFWM0xt6@jernej-laptop>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tvit4m5thudok37l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 04:46:41PM +0200, Jernej =C5=A0krabec wrote:
> > And this is a bit sloppy, since if phy_clk_num =3D=3D 3, you won't try =
to
> > lookup pll-2 either.
>=20
> It is highly unlikely this will be higher than 2, at least for this HDMI =
PHY,=20
> since it has only 1 bit reserved for parent selection. But since I have t=
o fix=20
> it, I'll add ">=3D 2"

If we're only going to have two parents at most, ever, why don't we
had just a single other boolean. This would be less intrusive, and we
wouldn't have to check for those corner cases.

> BTW, I'll resend fixed version of this patch for my R40 HDMI series, sinc=
e=20
> there is nothing to hold it back, unlike for this.

Awesome, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--tvit4m5thudok37l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr+8LoACgkQ0rTAlCFN
r3RbhhAAiPiS0oBKrE4SXuEZWn62ARBw1jMOVxivZlxbDkKSK+fpfxr2hAVKYxtZ
nIpt5ribBWn98C2K5oqbwIg/Xino6lGKP3AGTKm6468rtHviVT5YnyRk5xSP1PRi
IDL9CdfCK+G5GMmC14Ht1OIxqenqQjPcT0UAkftjV+gkwPzipIVy7Tgff5Uz7BOk
wRaiMpxrc2DAa2B/xDdrQkwP+wkuXLkYR52NYBJMsQsxl69v/qjwaKK1svb1ewKm
qyi7Bebtfwh77scOWahjAIjCKInqqLn8uMYmoe/GqeH6TThyeDNBJTmyi8Eo3sxc
8YY1yvNc1aSfQ6ds8H0bNweRLxI3aigqLeRaPczL6pILNMXQOZciVAezqhtZ3U7P
b7wNfC4aoXdveVy60vLpTo2hWKQdgmixvV8VBILgvct4Zq1IJytet/7+mFvcL7Eh
VXJOCYNXy+VOser93hcWdKSouvAj5oBSD+f9Nhoi6iv8ezKeQBhXsMeyhe/7rhDt
fAIeLBPJtRyEoM8aMWYDmtCWj6jITYZ+ZOsbe0fCMVbJqsAHOQK7e8BSlcKceC81
Iw5Vi9Cbz/ZE4fADrt/HxlJy9o4WCqswPJBroq4s43gRXz8SYC3bq72+GrLojGp1
TX98j3eQKkYQDp3C3nVJS16JTF0TEb/907K2lSavyIhu4JmLl2M=
=AUyt
-----END PGP SIGNATURE-----

--tvit4m5thudok37l--
