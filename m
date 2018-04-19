Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbeDSPFV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:05:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40992 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752144AbeDSPFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:05:20 -0400
Date: Thu, 19 Apr 2018 17:05:18 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: kevans@FreeBSD.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3] ARM: dts: sunxi: Add sid for a83t
Message-ID: <20180419150518.nbeq5zelrl236grv@flea>
References: <20180419141103.38196-1-kevans@FreeBSD.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kdx76qelsr5r5vbe"
Content-Disposition: inline
In-Reply-To: <20180419141103.38196-1-kevans@FreeBSD.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kdx76qelsr5r5vbe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 09:11:03AM -0500, kevans@FreeBSD.org wrote:
> Allwinner a83t has a 1 KB sid block with efuse for security rootkey and t=
hermal
> calibration data, add node to describe it.
>=20
> a83t-sid is not currently supported by nvmem/sunxi-sid, but it is
> supported in an external driver for FreeBSD.
>=20
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--kdx76qelsr5r5vbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrYsC0ACgkQ0rTAlCFN
r3TFDRAAmuUj4T/690oCZynzuvR0l53SQ8BsNlvj57JWwDat3XSMgUald6/7CBFI
lNvQ4pMLqR+MjiBynCFJJXNto82uRXzhyrLiHdU66bIJgQWQXaLFVUaXKq+vvB55
pA0nkyLpN1p6H8YuIykDc9hcyBb5dUAdQcctTwcKnwT/+Y1IvaOBZC6j1oBmNfB5
j7Bve42RGcwCIoehgMh0BaNSLrml0IrNIe3YpsGMRpUW/zlldTCmrlqsCDyA5UW1
9stAXbouvxqsE9/E3yqH/izrGlZEYTLBt9dIC1PIq3Sgvup6MM72VU74apTmvKlY
bubugWun88fh6hYM3XqkAkQtJh5V7LeoOnKIZaN3CNh2h8dq5SacVjiiWHzGFcFt
140xQoie5g0AFJPQ2ZWdhVxPwtQmfEAn5DIeiuinJtH7ndSDGjDEB897ZsoyiBi5
huN+oUsniHT5q+dJKFf5cA02I7Qi3n7RhtQvxF02iWydeRG9FUnRLNUx+EeNumum
N1j1fDD2Bqk5ZyiAZ1LKiPDW/kQ021SlCPQGjv68cIIcD4nL02bB/SNrVj61z74J
YvRzqHv4SLHSFsbMt1XiGy4MkFI2S51zDsi3b5M7+JgZrIgnSZSdh+MPzW0SST10
LkEhPl4bLawFBCSCOY+FloJOGWhSs8ytkVIidO+2jm5p6bOe4ns=
=kNVI
-----END PGP SIGNATURE-----

--kdx76qelsr5r5vbe--
