Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757121AbeDXLxZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:53:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44668 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbeDXLxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:53:22 -0400
Date: Tue, 24 Apr 2018 13:53:11 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 3/7] ARM: dts: sun8i: h2-plus: Sort dtb entries in
 Makefile
Message-ID: <20180424115311.5s5p5ryyswq7xmat@flea>
References: <20180424113424.13196-1-wens@csie.org>
 <20180424113424.13196-4-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h55geail6mxujuov"
Content-Disposition: inline
In-Reply-To: <20180424113424.13196-4-wens@csie.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h55geail6mxujuov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 07:34:20PM +0800, Chen-Yu Tsai wrote:
> The dtb entry for the Banana Pi M2 Zero in the device tree makefile
> somehow ended up in between two Orange Pi boards.
>=20
> Move it so the list is properly sorted.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--h55geail6mxujuov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrfGqYACgkQ0rTAlCFN
r3Q1jA/+J4xTm5B8V5zBadHxzetyfHtaQhX1C5aF6TxRUvYlxsovcCd51nMay0B/
CKbwjAob9oL2NpN/9wQlrPID9pQKOeNS/Y3X4YANcDk6d0uQNzLydZ8Dq7aDHwaK
WiHXgUk/yqzvI9q0JGS0YjpAPXbAby/jYj1thhsGs0LCLIeVuoPl+dgLSSIRw/Kp
x6w7SfRYD51vyGmPHjeRYTpg2c3coqDGwbYXhYMmkp0mMglTmY55QbROnHoN9Ux1
mqAVaXZW2q09ftC1OIbvMx/LiNUYzzlLJMw4Unr+S+gJ3KxSOrvUGLQUR9NAfN7b
1qv6trROOE/fzVq5k8qvcRoKv9A5/L3mmoZ8MgP25t4XgLyopP553uvnHzbU9+O2
TCrUxoeaUvkfPd/BDIqOJz03PrlpNkxl4kT0PHaAeHV1Pen3nnBc3356zUCctypL
Cg5cJusE4wT//ehSPdoFicvOUx2UeZ284LKKlSt6Slm52raOVA5ns/J+nEJuml8i
fr7SykL7kkqpGQ4bN+fX658wxMW3yQb+/Tp7xsDZ/UJf+G2hCjS6ct4PbfB3Lvfx
995A1Awpgq4/zAFDX/z49fPK2ClbMrI2kx+eIrHOFIt5oEqwWAm+Fa7wqH50br37
4bS+j6sB+S8Ff9+9Pv6S/y5vocW2K55twJwvbPJCobfSzs721D0=
=6XcU
-----END PGP SIGNATURE-----

--h55geail6mxujuov--
