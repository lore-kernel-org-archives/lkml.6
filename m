Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeEDPGj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:06:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35181 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbeEDPGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:06:37 -0400
Date: Fri, 4 May 2018 17:06:35 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 3/7] pinctrl: sunxi: add support for H6 R_PIO pin
 controller
Message-ID: <20180504150635.cmtypedk55oxyg2n@flea>
References: <20180503183847.11046-1-icenowy@aosc.io>
 <20180503183847.11046-4-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="saqtoq4pvu6fszm2"
Content-Disposition: inline
In-Reply-To: <20180503183847.11046-4-icenowy@aosc.io>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--saqtoq4pvu6fszm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 02:38:43AM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC has a R_PIO pin controller like other Allwinner SoCs,
> which controls the PL and PM pin banks.
>=20
> Add support for it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--saqtoq4pvu6fszm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrsdvoACgkQ0rTAlCFN
r3QF9A//dypcxtWiVRia46qEZzZVvWdsP0XWZlTE6UJH0jOL3liy/56hLTyW9gyu
3sv/o9sNmp+tx92feTHTt3OBv3xezUyfUeOux0vmydPS792md7KCOfnZV2eIHGqN
aMUCZ/6Cr3w4BjC8lvqHFdli9gVJa0a8t5gN1jFkRfFd0y6qss7U/BGv/t1WZHY7
5Zrk9wGO3FRc4+k7ftfhsmSeBn9h6NxA/pKIWgniyJ5mbw4HCTlQJLYda3FMEnK1
S4KNMbmgEBuU9AQDRXGGIa59sV6oNSUoSJk6go8keZ+lMFI+Q8ALgAYSu27Turu1
uY7eSa6ZAcU1Ul8cjN/+npqTzLSooo7gZrBRGO/q3TJryzvglZtQo7pNZbWeXqEZ
rcfulzJFx7SkYjy/IpeOleIfbV/ScjuqZh42YG+M1TFXVXPZkSdrMN88w/6o1v9a
OYduzxF3dDHHnTAjIbK+HbAZmZdCUUnmz8pnw/PSoR7x6FSHE2aOB3gyBO1IztBF
pIpJQAUdJ9yZVLf6SZaSBy/CBF4TARh0wWU45ewX2Jr5zyDVp51UgRlKXI1EqU3v
8gxLc9KFn4mC5ulRYwyLxUvZj+DYGE06LB4GmTkrs0AkCm8NDqECfRCIBZurdlqp
G9NkYFWf01P53a2BxJf+V0Ri1QM4DTSjBpdldSrBTjcgY78qUqg=
=kJur
-----END PGP SIGNATURE-----

--saqtoq4pvu6fszm2--
