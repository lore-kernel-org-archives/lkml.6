Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756694AbeDXJ5C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:57:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41166 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754189AbeDXJ45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:56:57 -0400
Date: Tue, 24 Apr 2018 11:56:56 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: wens@csie.org, clabbe@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: sun8i-h3-libretech-all-h3-cc: Move board
 definition to common dtsi
Message-ID: <20180424095656.oormsyru7nw6hypn@flea>
References: <1524561576-2201-1-git-send-email-narmstrong@baylibre.com>
 <1524561576-2201-2-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ht5tniasepybhfkw"
Content-Disposition: inline
In-Reply-To: <1524561576-2201-2-git-send-email-narmstrong@baylibre.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ht5tniasepybhfkw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 24, 2018 at 11:19:35AM +0200, Neil Armstrong wrote:
> Since the libretech-all-h3-cc can use either the H2+, H3 or H5, move the
> content of the dts file to a common dtsi file to be included by the H3 va=
riant
> and in a following patch the H5 variant.
>=20
> By the way, update the SPDX licence tag position.
>=20
> Suggested-by: Corentin Labbe <clabbe@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

This patch looks fine, but doesn't apply anymore. Please resend it.

While you're at it, the prefix should be "arm: dts: sun8i: h3:" (with
arm being lowercase).

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ht5tniasepybhfkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlre/2cACgkQ0rTAlCFN
r3RTxQ/+MZIEloUjpeVv1/17x1GYOXFWOl0RNn2yHhw7JChKzieTXkyvzFKPMLGe
p+ymYr97CGuH1c6z9ojPTz5eE4cZLEp/Y3fJr75JoYm4O8VNLjVn3Zi84LQnp04B
3TgMHuYINPt4coiRT2WBAxJd8blvWFppJEcfH6PX4xqukerXsAEbo7x31CDA2h9q
yCnLCYvAtX7jfEKEL7OIObjCgspC8+6Bo1L6R2FBid8UoApQgoM6GdjFQXNP6Pj9
RVTkmquiwt46P4kc3z3uipVqyThSBZQ0gpdVbe9j2Uql7kMVlGcPUW1eX1axi9GR
ZeSPfS5ddIeVXTfDvXQOCcGc/hKe4uk06DpxT1272DbBGAeRiwt4ysRyQG0u/RDG
vWuDcpMdng5cNo5v+Wg8uCWDZ56Y8LzhEUYufkL4p5JzdFqJdIOs6Mmhu1QiSZ4Z
aoI+3wDB3ni6K/AxvO4sLP/MSwpNrlEFiJ6NTB3/9ARrp+G/Gq1qOj3CKagiSG9q
8jpHwWV3Bm6S4eItPDbVB9ydzl+CDhcFVcmuWH9QrcZ/03fD0HKHsCyOhkBDKQLf
A7eFlAx1c4IwNLHjQ4esweRXixyhVhh/AFnjh7NydIFp3NYOHD4cuKB04FrRVFgK
Nm96rT1tGvHHG9LNdmGvNZ7G4Rf3dUO8Mcp7XpbnVjfZy8zf0jc=
=ud8h
-----END PGP SIGNATURE-----

--ht5tniasepybhfkw--
