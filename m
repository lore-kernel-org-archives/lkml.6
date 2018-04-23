Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbeDWHrh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:47:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55085 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbeDWHrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:47:36 -0400
Date: Mon, 23 Apr 2018 09:47:34 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: allwinner: h6: restore the usage of CCU slice
 macros
Message-ID: <20180423074734.rb4ddxtymbxtrpzp@flea>
References: <20180403134024.43156-1-icenowy@aosc.io>
 <1524466728.25095.0.camel@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="od5hmecmkchcbpwp"
Content-Disposition: inline
In-Reply-To: <1524466728.25095.0.camel@aosc.io>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--od5hmecmkchcbpwp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 02:58:48PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2018-04-03=E4=BA=8C=E7=9A=84 21:40 +0800=EF=BC=8CIcenowy Zheng=
=E5=86=99=E9=81=93=EF=BC=9A
> > As the definition of CCU slice macros are already merged into the
> > source
> > tree, restore the usage of the macros now.
>=20
> Maxime, could you check this patch and pick it?

Applied, thanks!
maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--od5hmecmkchcbpwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrdj5UACgkQ0rTAlCFN
r3S4uA/+LcsK/bDAliFoDSFRJ4xs1DdCE4twZ3RO3CxMuQ4IkaJaCp1La8fj65lf
AWorEo4wHYL0OfJyyxurYlBUI1COaBdTPx2AdeV9sX6W+X+qyYzidsytSKL3PjPq
5EZCWX503QiTbzBaDkHacUirGg735wrSDky+/GP+9cHGYcIHWkxTXegOAryEqjUj
lG1yJebA3fpwugLJTp1URFdNoAQGjXzJ5QDID7SUJ7HfoZ2WHVmoJYzkBV64nGqy
5qQ/rL3nMG+X/kuios/J4wbpvoJx7cLUZl9bjtjLvIWP+EM4je0EABDdYaz7Lc1j
sniZW9aNciW9tKa4hHCDqhlqjmBU9ZQcHIZtqC7BlociWmfBEwYq3BsIsbzgGe3R
LUxNBjXaBsrGaxZ0AB1QcU5VXxYn+Uu8NxINk3eeh519l8Y9P4KRY1OixCP+hJDa
StNvXlK6KOpxJrjMVTT6LJsaA696wMfVuEOrf0+OzjLLRRJ1ribucC2WTLKPgKM9
tX3Igy7ax/p/nf1pG1lF8zTkp+ciYgypa0Y3cdbsn3J7yrqtCTb038lOWxiBc0Db
aehxkLeU6uTVb+gFr0/i7MUWtuP8WuUlLO5/tB6xLchHPymArd/L6+sLJP3rvgfT
r5uPxE7rR4dY9oT1cM0DLysz484GTI3X645GmrFWbwcMbpe3cDU=
=WPoO
-----END PGP SIGNATURE-----

--od5hmecmkchcbpwp--
