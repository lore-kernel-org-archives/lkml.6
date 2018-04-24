Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757488AbeDXMOd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:14:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45615 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757473AbeDXMOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:14:30 -0400
Date: Tue, 24 Apr 2018 14:14:28 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: wens@csie.org, clabbe@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm: dts: sun8i: h3: libretech-all-h3-cc: Move
 board definition to common dtsi
Message-ID: <20180424121428.bd7zir646sl64t7t@flea>
References: <1524570434-17814-1-git-send-email-narmstrong@baylibre.com>
 <1524570434-17814-2-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q6vo43hzloeajes6"
Content-Disposition: inline
In-Reply-To: <1524570434-17814-2-git-send-email-narmstrong@baylibre.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q6vo43hzloeajes6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 01:47:13PM +0200, Neil Armstrong wrote:
> Since the libretech-all-h3-cc can use either the H2+, H3 or H5, move the
> content of the dts file to a common dtsi file to be included by the H3
> variant and in a following patch the H5 variant.
>=20
> By the way, update the SPDX licence tag position.
>=20
> Suggested-by: Corentin Labbe <clabbe@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--q6vo43hzloeajes6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrfH6QACgkQ0rTAlCFN
r3QKXRAAjwKKALeOvNxs07En/AmPyMS1QszCzKBjt+cm1IbGLWgCqNEIq+GAKXpg
4HagywrV4y2MCXxeOeWiJ18gJA3yF/91U+nc8TcLeR+FUd6vdWsLRW/pUvzLMMYb
5CHv4CaD4fQcvVNQuNp/1cuZ/LXadSj2JGU4mLmeV5VCq9zfFEE1K8Knaby6kD3b
dBR/yjiS5hPUORbof1Ngs6QZFpaDQXLvbtzpUa6ZS0yy3YCUmIC5wt2/I3HuvV1C
Ot3k0RTyKMPGZ5+Ddtqcw9YjuCm8cHWpg2+ZC/Ui3XV3ipqT/eIFCNoDQTjRaa0P
oWeUsw4qKc81s+Eq/jLQV3KgSRiT/Xsq6fKsN0MKI+5swyVgGWf9ncmTrlvwn+LI
sCDAjZ+3tg0lq3ElcqBz9UO9zv/3BjU88yR4Ur+mZMiyhCsutvR/RqkK3mc2nZyo
AgQpz9VbLLLjtKSiRgwMz9+ncPFKfd1XTiQyeLPsIOOqJMBjv98lxUplsg1BZ2Lh
z/gnboFRyJBEHCt05xp34tKYdxjDfot+4UBRv7MW+Xx6x5+f44SPHOcaYfHTYsci
lBXJcEpeD6gwELpfwYxWzAAQhJq+izr4cDNbh5Hd2SI1QJPGW7tVD02K5L2BwDbh
UuQTCNrttwAD5znCi+pLegzAFjlIrPcbwpU7Bku8j7/Yv7FYcQk=
=C0gy
-----END PGP SIGNATURE-----

--q6vo43hzloeajes6--
