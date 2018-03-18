Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754719AbeCRUPf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:15:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38066 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754670AbeCRUP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:15:28 -0400
Date: Sun, 18 Mar 2018 21:15:19 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 3/9] pinctrl: sunxi: change irq_bank_base to
 irq_bank_map
Message-ID: <20180318201519.smbzfswz4wxdw45q@flea>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180316140215.28663-4-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z2sqvwi4q4veb6mo"
Content-Disposition: inline
In-Reply-To: <20180316140215.28663-4-icenowy@aosc.io>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z2sqvwi4q4veb6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2018 at 10:02:09PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC have its pin controllers with the first IRQ-capable
> GPIO bank at IRQ bank 1 and the second bank at IRQ bank 5.
>=20
> Change the current code that uses IRQ bank base to a IRQ bank map, in
> order to support the case that holes exist among IRQ banks.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--z2sqvwi4q4veb6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlquyNYACgkQ0rTAlCFN
r3TW1Q/6AhP+y1a59KM4kK2xfXsQnuIBbS5Ud38VfpLSyZXRP6G5OHuXAImFJlJK
iWzPlKiPWHfy94e8fX9jWGLZDJ58mCLLNJ8YKwtNS4GmpeFvtxWTckRMLKs/WKCt
z0vcYazmfkbvUzeAfgGCpIG0yPifdOK/KT+Kk9vC8W0kyIRegRSqwzwqZJ5b3FMF
rzqHBNDiARDgVSmT/rCtKMtESJo24G69Oqhe8EEImQWvRqVz5D0RG/Wc65MfUJcT
xN3wxsLcL5oBrxrOq+ktgAkOx8nAgKd+hkLlj8DZzHMa7JJXSNa15N8lm5Qd6zW6
TbllyJpgb6rnOPSY3EqkeyuAycf5WuIMHDnNRLrVCGvSQ2qIWWSFdTvT/keVPbd3
NZD0iAK1H+xBxg7jvZq2aNaCbEPVoIAGaglQvUVfWSDFkIc50Z8ENoiyLNYwHSNT
a403vIFpJOw+k/Bzu2XPFe5rN2FdGki+pwjphuhYatwT/JnUMW/DGmf18YwzqMVF
fJEmN5OTaHyOdMDFRhqtNNXDuQlKYwE3E066bQGcOxskHImdo37wbhqL7nYm4KSq
b8qgqq+1pMAFxH0Untu/+jbrcVGdtPfRS8ouVIy+1mHR1uNm/+j1DItZx+XTqVG4
8N3I7YmT0ZT73EGAWwINr1a1dtKS4IN46Q8QB5RtltciCYvRhh0=
=z7zK
-----END PGP SIGNATURE-----

--z2sqvwi4q4veb6mo--
