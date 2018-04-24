Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757518AbeDXMOs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:14:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45645 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756236AbeDXMOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:14:42 -0400
Date: Tue, 24 Apr 2018 14:14:40 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: wens@csie.org, clabbe@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: allwinner: Add dts file for Libre
 Computer Board ALL-H3-CC H5 ver.
Message-ID: <20180424121440.qmiubwdgcisn4g4m@flea>
References: <1524570434-17814-1-git-send-email-narmstrong@baylibre.com>
 <1524570434-17814-3-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ud4y7trwgqercrkb"
Content-Disposition: inline
In-Reply-To: <1524570434-17814-3-git-send-email-narmstrong@baylibre.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ud4y7trwgqercrkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 01:47:14PM +0200, Neil Armstrong wrote:
> The Libre Computer Board ALL-H3-CC from Libre Technology is a Raspberry
> Pi B+ form factor single board computer based on the Allwinner H2+, H3,
> or H5 SoCs with the same PCB.
> The board has 1GB DDR3 SDRAM, provided by 4 2Gb chips. The mounting holes
> and connectors are in the exact same position as on the Raspberry Pi B+.
>=20
> This patch enables the H5 variant using the H3 board definition moved to
> a common dtsi in an earlier patch. The dts sinmply include the common dtsi
> and declares the correct compatible and model of the H5 variant.
>=20
> Suggested-by: Corentin Labbe <clabbe@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--ud4y7trwgqercrkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrfH68ACgkQ0rTAlCFN
r3TK9w/9FNqK4YMrvCRLPOVHDLxc8O/QV0zNvAwlPZCt35O6kv0+1obOIDLt/HNe
fThCz5E1kIk6npbaOnf0rcAl8rQoKvIJeQVT6y45huvvYWFC1UZwmx4DL+tQ71zZ
OggcCscUNIUInoWjONyWYXNjX+qu7OahmY9lA3KYPpurGuJGHujbGlcyJ967+Ayy
e65OyLnfjZY0KBPZRKtVwZVJmo7KsuffgltByrvS1Fmb1X0KUEiIFvhcMOlN+RAY
4C2CaBt+50Y+OUCJ04auCgZ/EaOl/+rhXezr078Rfqaf6xhCZcLFZ/3N4CeCDF1u
chhlTvvbrQYSn8G0UmPQvdwnIgPozyW6/ZgjbECVo1Sd0MSeauOD43dhtasoOB3I
h3ja8ZXSlB1Z6TY0avjw71KMGQyMglUAdyHPtryQxpu79mKuCmud//gChGt2PNcp
mQ0QPKrlTKo4PPhFBTs8zfy9COxdp5rFjaZTsElOF14jnye1s1GZ+I+MRYmEGZBQ
MQcoLjCFzT7psExGgrSIaCiJgNOtKdI2qajgkm1/S01vsYwhUWGxGyOER/mG37Ey
6OPQyAWfPl/M4QwPx0LU4B36HeNQcFvsPJ1XtDDbObygRNBmL+BYQQ5Jmaep8fq4
L827+eGsuwVhPIJZ7H6BYwR414Rlrf4LQ6CtqYC9itN6BIV9gXk=
=yDfs
-----END PGP SIGNATURE-----

--ud4y7trwgqercrkb--
