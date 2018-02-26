Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeBZLQD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:16:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46474 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752376AbeBZLP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:15:59 -0500
Date: Mon, 26 Feb 2018 12:15:47 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v2,03/10] drm/sun4i: Protect the TCON pixel clocks
Message-ID: <20180226111547.adm6cfvccceipgqh@flea.lan>
References: <d5224d2e81ecf73dc09f234e580ada52c00eaee3.1519204731.git-series.maxime.ripard@bootlin.com>
 <7ed0fad9-6b3d-aafc-08a6-fb18761897aa@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lzhodxwy2knl7pia"
Content-Disposition: inline
In-Reply-To: <7ed0fad9-6b3d-aafc-08a6-fb18761897aa@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lzhodxwy2knl7pia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2018 at 12:31:36AM +0100, Giulio Benetti wrote:
> Il 21/02/2018 10:20, Maxime Ripard ha scritto:
> > From: Maxime Ripard <maxime.ripard@free-electrons.com>
> >=20
> > Both TCON clocks are very sensitive to clock changes, since any change
> > might lead to improper timings.
> >=20
> > Make sure our rate is never changed.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Tested-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>=20
> Tested on A20-LiNova1-4_3i-ctp with Mali r6p2 installed.
> Before Mali changed dotclock, now it doesn't anymore.

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--lzhodxwy2knl7pia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqT7GIACgkQ0rTAlCFN
r3QPbA//d6OYNiqPr2qB2rLuV5iXbdz3GBaL/OdOqzZTxZukDuZMSjR4g2Ne/0JN
qMVIgXOA3kmbHQ+LU7vor4vqH6Qr1CplFPyp61dB+/kgajwHv14C/5UWNiCtVYl1
8EdruBIHZqpBI9VVV44F3JLFLt8j6ti031sIWYtqnm64gj2+ECeMN1g+0dwlTZO6
axSkijL8Lmu431+BQoZrqmqBeuugxDwUdBoZug4cYxltTzFQbFdH9gkKubkr/2Hn
iLIjjSK/F5ovA8kUvynaOLYB4ltvBfvnXwUMUMGyjboV6yem6638klMGqlzNaoWt
+UUQWEbesz8YaQV8afqs7wh+dPTaOG6nv9UXaRD1iqQdi3x441XQdcuLUBNYOfo7
GPalYwjstfa9fszc/WSfXt2muudY6n5hK+1AoYiclaM0lV2MlLu0uVpTIl8wjRDA
cEZULuM42oPg3Mk05hyBoUmOPE8vCpzzPnLrTM3W+hajFXpSAMeXrUZPyMsc4cPG
1Sxf5R38WNGPyvwo3liZVXSbGX6L9Ip+4I4yUerlLvlWmiz6YfiTeCLiahJ+wz4D
2ihv2D2J7GCDErf+/8CDxwbSKEoCN3vt1Qys9yujH58xRfCIQ/l2+X3ll5qKBMaz
EZErYZflqwjZN0+N2BtYByEolm8nQswc1H0uv1kkifpBO6ixA2c=
=mVNx
-----END PGP SIGNATURE-----

--lzhodxwy2knl7pia--
