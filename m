Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeDKITk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:19:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43217 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbeDKITh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:19:37 -0400
Date: Wed, 11 Apr 2018 10:19:25 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Tuomas Tynkkynen <tuomas@tuxera.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sunxi: Change sun7i-a20-olimex-som204-evb to
 not use cd-inverted
Message-ID: <20180411081925.hjhobvessykaiqoq@flea>
References: <20180410145119.27362-1-tuomas@tuxera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ejriaccedkaw7yec"
Content-Disposition: inline
In-Reply-To: <20180410145119.27362-1-tuomas@tuxera.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ejriaccedkaw7yec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2018 at 05:51:19PM +0300, Tuomas Tynkkynen wrote:
> Commit 45e01f401a2a16 ("ARM: dts: sunxi: Switch MMC nodes away from
> cd-inverted property") changed most of the sunxi boards away from using
> the cd-inverted property in MMC nodes. However, the
> sun7i-a20-olimex-som204-evb board which got merged concurrently with
> that commit is now using cd-inverted. Switch it away from using
> cd-inverted to be consistent with rest of the sunxi boards.
>=20
> Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ejriaccedkaw7yec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrNxQwACgkQ0rTAlCFN
r3QSaA//YBgKR8GjceuTd2+KP7HCuu058FpFl1+HbX6am2RBi4/wMzQUP2fWktfG
uv87VGTqU9odcSA+Q9uzZJ4fIuS/a9stYLJmOuKK5U/MecufkLdn0c/wFiXM/nkf
3EX7VUj6FzF9647+rFUE1A1M9a4cckBjiWQD+U5L+A2P5cDU9SicII91DTx6tiyD
DfhvHx0Z5fkSbPRxYRw+nKmlU7M/9I51sTjSR6GHDyBo01v32hl0tvRN/rjEudwP
YM6G16h4ecIUrUG46twNXioxzzFG2/9O7NKaq3alcKRTi4suZjgHYH8bsK2XeepN
4pmNK4hetxBcd+tzAcdrFoS2aynGS9Jz6rP0E9vXrOmG2mM6DfIULvOPKFcyGMKm
3XRWIdlXuxLmkpnTvFRMW0CmHWK9YUTwzX5Tg8DsKNhLbdE7gPmoTrDE6eZenCwo
zuUDwrGnJVdjWUg8cU57n/sFFKWhXDBYP2sxHgdp6+86od4BcgwYeI28lJ/cSsSB
eZ8xCUfw/OFcRkuCljnKUIFwaEWt6TJDqNRwGqHHexoq+4rHjQoEjFRPkgNk4A1v
P1eiZKhc+JXjbEMS98D9kV6DEU71avbdnajFOhVlt13O4fNua+R4WhRaunUncTXj
FJLTBJPSzM3wzJytdiEyowWRvUmKt19SOe0fR/WNnm+k+nGEtG8=
=yET0
-----END PGP SIGNATURE-----

--ejriaccedkaw7yec--
