Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeEDPMK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:12:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35669 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEDPMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:12:09 -0400
Date: Fri, 4 May 2018 17:12:06 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 6/7] arm64: allwinner: h6: add R_I2C controller
Message-ID: <20180504151206.c6oi7vtaskg4sbys@flea>
References: <20180503183847.11046-1-icenowy@aosc.io>
 <20180503183847.11046-7-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e4pavb2hql2yh5gb"
Content-Disposition: inline
In-Reply-To: <20180503183847.11046-7-icenowy@aosc.io>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e4pavb2hql2yh5gb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 02:38:46AM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC has a R_I2C controller wired to the PL0/PL1 pins, which
> are used in the reference design to connect AXP805 PMIC.
>=20
> Add support for it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Dropped the headers (that should have been in your previous patch to
maintain the bisectability) and changed for indices, and applied.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--e4pavb2hql2yh5gb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrseEUACgkQ0rTAlCFN
r3QUsQ//URVfSDc5Gz4bXmIK8/quSPewUaV8JdrK0TedXbHiHiEkCGsB6dJlbgQ9
FiRMi24HjHn4/7y/7ohgS4guT3XqkCtHo2EZiNBh4yMouEJyj+hdxJ+EVWOo3yW1
f6iWUEadO2MQcb+imqFUrKF2pEOv01wRuXB74p3IxuLP2zFbqVykjBzIa3ZDEmV1
uUieZrCs5FCJ08Untop6G+mW3ajWZvmuhhrI7xt6+h4M8pqSEfuXwElkNEnwnWcf
5BuVvYuJi0z/mNamFgYyCjF6YSEV3GllMt/Tw7eCPKEL30J+1Ct3lGk2DBWpCYWJ
esaFElrKzlzWU/7mxZjyme2vE6fIXoOrwO6gXJSU+gcxd61+lBTjaIMpo3TakcyJ
FNTlpeQ8x4cjaULRBfbm9PDsVFlaxxRtXztqMy9yN7nvZIm/9saEBxQLEUYQKvaA
XF3nRubWdgUKC0EpBDup5jQEri4d2sJ6BWh5UxR3qNW9qOlZ9mprk7ttOUF5CiMK
TSKcsqGUFz9S8zHL7AKD2CvjI5eC5rExuR8yXitkwUSCoFkJGQHZ0yqUful3b7PK
aEvewHBBErow4Q3/kxlvNwx1DjE58+gTTHmEHG3LDfLQJxv7gptoaIjhPZ9l8I3h
dTcaUCvuookEYUA5L6YDHwbk+03KZjpRXuUn+3gY74d3iY5Zxu4=
=+Zz3
-----END PGP SIGNATURE-----

--e4pavb2hql2yh5gb--
