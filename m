Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeDXLzN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:55:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44788 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757244AbeDXLzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:55:08 -0400
Date: Tue, 24 Apr 2018 13:54:56 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 6/7] arm64: dts: allwinner: Sort dtb entries in Makefile
Message-ID: <20180424115456.ekjvctlic6al6hn3@flea>
References: <20180424113424.13196-1-wens@csie.org>
 <20180424113424.13196-7-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ici7o52ukjpgxb4"
Content-Disposition: inline
In-Reply-To: <20180424113424.13196-7-wens@csie.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ici7o52ukjpgxb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 07:34:23PM +0800, Chen-Yu Tsai wrote:
> The dtb entries for NanoPi boards in the device tree makefile somehow
> ended up after the Orange Pi boards.
>=20
> Move them so the list is properly sorted.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--3ici7o52ukjpgxb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrfGw8ACgkQ0rTAlCFN
r3TurA//Xms12VhpqXeNZ7EwfPmn47dyWMzkKgudCm68KTiywdkvo708G/VNwOID
lR+Z+2YytyrMN1LNNIRXxGsO88FTupl/XquAVYcj754Le1iKTQzoAucUNohts6+/
fXpADIGioHBzpnO+/iPOuWtmY4Lh+fvqdQbrzqbZ+xOO+lC5y0zPoZiGrLYrBBYX
GoqVajJWZQGeHvrHDpMA+92rUJUjBju8JMsd1q/2Y8eO58rlV2GIRrI7arD0qCen
3FGq5pdy92M3wPbQwbvYFjZk6onvDFc4mrIMWSteyk8D2hI689SPUJ5xTio9uCMO
jBGVKMucx8FYF8D25Xb6tBSnY+d6g6hH2nDXUAYHho8VA0zbrFkL7JI1y6XVj+cX
mGv9GWqFe9gETN23wqk9sQkbv6/mY/DhoKIhbdwNBWZXR+igq6vURuzVK+DVp7Db
3QquHR2cMCyeQmD5gE8Z0u3oEnZf6Ax+NngxuGUz81oRQdAtMGvh+Njmi8J4rgBx
Od4x40rcFnQtd4/fAkLUTGkxK78rDy0U/JkNy1sqEycLzbWsnm+s6x0CvcXg81fx
joNJwyM9gHJaAJuUxvOOvwTAlAyiC9nhl6n2bL2ENTxkuYf5om6cI+kf8xBXNou/
EVydjHwONC4gOacaeKMlQR6ZOiMeFtG+GlD7iZpetj62SHjHccU=
=xNrO
-----END PGP SIGNATURE-----

--3ici7o52ukjpgxb4--
