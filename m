Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756614AbeDXJ71 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:59:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41275 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754189AbeDXJ7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:59:25 -0400
Date: Tue, 24 Apr 2018 11:59:14 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: wens@csie.org, clabbe@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM64: dts: allwinner: Add dts file for Libre
 Computer Board ALL-H3-CC H5 ver.
Message-ID: <20180424095914.cs362x4zdwxzo6ru@flea>
References: <1524561576-2201-1-git-send-email-narmstrong@baylibre.com>
 <1524561576-2201-3-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huulggejdgptj5ba"
Content-Disposition: inline
In-Reply-To: <1524561576-2201-3-git-send-email-narmstrong@baylibre.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huulggejdgptj5ba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 24, 2018 at 11:19:36AM +0200, Neil Armstrong wrote:
> The Libre Computer Board ALL-H3-CC from Libre Technology is a Raspberry
> Pi B+ form factor single board computer based on the Allwinner H2+, H3, o=
r H5
> SoCs with the same PCB.
> The board has 1GB DDR3 SDRAM, provided by 4 2Gb chips. The mounting holes
> and connectors are in the exact same position as on the Raspberry Pi B+.
>=20
> This patch enables the H5 variant using the H3 board definition moved to
> a common dtsi in an earlier patch. The dts simply include the common dtsi
> and declares the correct compatible and model of the H5 variant.
>=20
> Suggested-by: Corentin Labbe <clabbe@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

prefix should be "arm64: dts: allwinner"

You had this issue with the first patch as well, your commit log
should be wrapped, checkpatch complains at the moment.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--huulggejdgptj5ba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlre//EACgkQ0rTAlCFN
r3T4Ag//YfUqs9TN4iq3czTJJ3xKpE3wQSy/8wIsx+iq2OO8gHb6qREvzkEVqHMF
CapBYefGdY1AQ/lwd4O2YCeZl7iFxXUdjwq/rDIcYQuB2uQ3NQ4fiLY6AHGkgW0w
2pp7jRkt6t+EpJyC5pCVkjrjW21YUqylsM6iFv1IH/4eJH6apJnDoQOWxXR+500I
WFlhc+pGTvUPl11ON2ZAXDD6bi5YIF3Y+AnsMZ68zePV07o3mI/8BXgjNrViMmVW
3H7mI1PjpExEJ3kSABl/5+lU4x/pD/DAxfqiBdNZdOMRLEZBiMId6UeAm9W7gbBC
MbfewY61AN19zRMCaZtZhiCeG/pOmqdh6dYo/31KlNXuQsyAVI66CyRl9V8Vvuu8
z1jF0jxYiNCz8CebQ6PHixfQRDclwtJ2la3MwqJPYLfoNYYB2IbRjiab/yc3iTNx
VxDZTvshGoh0+cL9FDGARa89FMsGHUf81hvQ5zvfT/lBk3Wo8WFCJHwA6/575C5P
9TIgEUItUDpW4wfk0BD6rHp/Sb6KkThLzzz0d60Fyp2LBsra0cxkHnPf/ikIEAiL
zb7xvif8Ee0nvlPx2qsPGPxHtyzESkfF99B1GAzO7l9WwieV/fOecwILs2YJ7m6H
vAmxYlZMDYpa5HQ0LWBV86Twl2wQHz7E7kl/xK6Zf03eYW+Rp3k=
=g2UV
-----END PGP SIGNATURE-----

--huulggejdgptj5ba--
