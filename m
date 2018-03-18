Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754523AbeCRUO4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:14:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37997 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754463AbeCRUOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:14:54 -0400
Date: Sun, 18 Mar 2018 21:14:47 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 1/9] pinctrl: sunxi: refactor irq related register
 function to have desc
Message-ID: <20180318201447.grzt5yxt64s7terr@flea>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180316140215.28663-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ugtukvfxpk66fpis"
Content-Disposition: inline
In-Reply-To: <20180316140215.28663-2-icenowy@aosc.io>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ugtukvfxpk66fpis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2018 at 10:02:07PM +0800, Icenowy Zheng wrote:
> As the new H6 SoC has holes in the IRQ registers, refactor the IRQ
> related register function for getting the full pinctrl desc structure.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ugtukvfxpk66fpis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlquyLMACgkQ0rTAlCFN
r3Q33A/+NXnDGqCoPIBSpO6iqweFIsLh9I33euKBwZi2mGF0CxUGpW9FZLXN6wqb
G/RUUygJ/QZD44c7QLqNWCoyLrGQllLHQCo/kTDEzjxr3xFblADHZm6M+HRlB1VR
EO2BwNjw2MAwnpFzzrj7t1lD0QxEKhRfjcOzdXwlu+5awCTOXLY25aw+BzCTVphu
tEFnc6oRsMVBN752nH1LJpMnaQHZUw2qF3JG3DPOZ2kKsq+BcwSqrlPEX7bAcbYW
EU2UCy/u/2UkRY4Ih2KuHkWg8N4UnH/tcKvwsrDeC/bKl80XRaLombD8GFtvvNCa
YANcWkLaLiYn3H79Pd+E57qaLUQogI7mm0dE04g4nUESx+zwRh3PLIMQcLN41Ob+
0b84AyfLFYyllfZhl6VbOrAtICqcFx5wzZhD2KgTU+mlMt/JducIGkXEdP/ygxZX
57h7LouRRkFv2O3z142K+xTvYHONn7jtqVE67YdbnbmgVsa/u3Ib4H3biDVML/en
n2n7wX/ytdSqKTjaWvlIG0ZZsx0Wvk+MUOl406KlrRxAZREi1SGKqtni4iJvUyO2
DE3fjrGT2ZpuiJ8E+qtU/5rFNKV0UtMpYgYTEax+dp7bI5F24rx534U6/Y/vDuS7
1DasG7MiRaX1ajU8L4CEv9DtB48taSx3dnYI4bD8TkE+yBGc9hI=
=t380
-----END PGP SIGNATURE-----

--ugtukvfxpk66fpis--
