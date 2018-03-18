Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbeCRUQs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:16:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38187 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754471AbeCRUQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:16:45 -0400
Date: Sun, 18 Mar 2018 21:16:18 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 4/9] pinctrl: sunxi: add support for the Allwinner H6
 main pin controller
Message-ID: <20180318201618.wk6ypgjljhkwpei7@flea>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180316140215.28663-5-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="czeyzjeg3gm3fdy3"
Content-Disposition: inline
In-Reply-To: <20180316140215.28663-5-icenowy@aosc.io>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--czeyzjeg3gm3fdy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2018 at 10:02:10PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC has two pin controllers, one main controller
> (called CPUX-PORT in user manual) and one controller in CPUs power
> domain (called CPUS-PORT in user manual).
>=20
> This commit introduces support for the main pin controller on H6.
>=20
> The pin bank A and B are not wired out and hidden from the SoC's
> documents, however it's shown that the "ATE" (an AC200 chip
> co-packaged with the H6 die) is connected to the main SoC die via these
> pin banks. The information about these banks is just copied from the BSP
> pinctrl driver, but re-formatted to fit the mainline pinctrl driver
> format. The GPIO functions are dropped, as they're impossible to use --
> except a GPIO&IRQ only pin (PB20) which might be the IRQ of ATE.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--czeyzjeg3gm3fdy3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlquyREACgkQ0rTAlCFN
r3Rq4A/8DcJWJHup9/bUO/SRXYyqPzJ/20bsVUg534Ev/PfoDpq15j4ygd32o5Bk
LZ0SPBKeKnS27DIeHwBuJTx+RCewBzdfSQC6gMH1q+7/0D9dlGHz+9XdpSpSeXpg
azpPLDC0fE7TMNIqQW3EtFDm2j1hxNwQJshcnQ1A+58t/CksdSZB+JNNKyZaeuqe
04NS6KnbUDTj0Kk1F6CidQvXDhwWMM6jLTiAKH4y13nG263eMxXMMkt88sqKXGrY
yY5AUQMA+TpAvEX5EDOz07DdWTcHgp8cddV9JBNH87B8+4fAAp3Vb3tis0lY/Whx
OhFtFvlsC/SV/mor9l+xlDfjnDWjwIwvcETCkgZppP9XRZ3e6BNbKWElnEhvWpgN
j1eD1jQ9L0PY7VdxwsHZVO7CRvSZ/QbedaU+oYMSd8NIKKE3/SnjpnPRIlAm+v69
2LllOHUOXVzilIf6fK06w5KjAwCrwn7KoHnBAE7O67Uqv5ivHKSsHHTBd19OC1kM
Fy2n9PHMaFFgmrzhomcN0FHefZdKc4PKKB+V88KSqrpQPJ2kVh9ovYcBexpxugff
uRSQQnupy5TaFf9MC4CGnWJjo6YfHq2y2ocAu8Se/xvAI1E9UAIq4p6vr4wf3CPl
ZrKmlT4LM+1MahpjttsWsyQCTDvvlOWF+PoQKMC5cFeb0qNJu4I=
=LKmd
-----END PGP SIGNATURE-----

--czeyzjeg3gm3fdy3--
