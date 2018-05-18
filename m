Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeERJ70 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:59:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56856 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbeERJ7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:59:24 -0400
Date: Fri, 18 May 2018 11:59:13 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 00/26] arm64: allwinner: Add A64 DE2 HDMI support
Message-ID: <20180518095913.nzl3sr5wn6cg4ra5@flea>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lqbqmyz32rvoa32o"
Content-Disposition: inline
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lqbqmyz32rvoa32o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 03:15:10PM +0530, Jagan Teki wrote:
> Allwinner A64 has display engine pipeline like other Allwinner SOC's A83T=
/H3/H5.
>=20
> A64 behaviour similar to Allwinner A83T where
> Mixer0 =3D> TCON0 =3D> LVDS/RGB/MIPI-DSI
> Mixer1 =3D> TCON1 =3D> HDMI
> as per Display System Block DiagramAllwinner_A64_User_Manual_V1.1.pdf
>=20
> This is second patch-set followed with previous RFC[1] and first series[2]
> and merely concentrated on HDMI pipeline through TCON1 and rest will add =
eventually.
>=20
> This series fixed previous version comments
> - about documenting fallback compatibles
> - adding new compatible for mixer1
> - support for multiple DW HDMI PHY clock parents (thanks, to Jernej)
>=20
> Note:
> Pine64 boards are unable to get edid by default like other A64 boards,
> but forcing 'video=3DHDMI-A-1:1920x1080@60D' kernel command line can
> create edid with display on penel.

There's no point in trying to push this without the SRAM issue being
solved. It is required, and won't be merged unless this is addressed.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--lqbqmyz32rvoa32o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr+o/AACgkQ0rTAlCFN
r3Qsvw/+IYCEl9D8E5EokAzm6aRTGeD6yW8l6UcG9E1m/9qe8YqtTD4gZr7xbJVu
Lqzxd2SZ8v2yE8S+0HWma2g3jx5Fn4sjGqiKQsq9ncazecWvfF8Pl5nknqtjm4IQ
w4/6vStoe6tQ+Ur3dmY5DmQMLEHDJT9RwmHYwrRRMpXtPWz1FENq7+xFAvX/gjPa
IEoepWgFkMK3wOCx6j/5ig+E3BCjL5ImqFTZt0LmTGnt+0j9kxSKQ9qJqKU12E7S
tVGOOc5jDbyw+Bt4wG2nCagjB5XAEH+Nnghi4TvR8Vk4J4b/q/jfVQOhFubRLPmQ
EdBfabw3Hr8Uojpc70etX8q7dlHOQNlhuKmp38GtHAU1EaeeyAbSIHhNIP6hGMY8
6kqNg68TUuwraNMYbNSHUX0yOM/9AtQgIvUUa73DwrgQa2u3SHdwNrIoS5xDAnj/
+Dkc97P2l9torcdzNDBcUwJf6tQxB9bhyCRu92EaVhsafV+Fwpe+x3fDR7tem9lp
MA/i0mx/7pBpmcVVbxo9cvKQBdsA5HjHf+KLrGjayITQf4GTPS488KM5IjoAppXw
O5xnq/VniGUDj1vsGFj6ZFU2SJAz+A4FIrYHAEfgTzueyh0vQE0Mtvkbh4n+2/U1
gpjukrLRgGVPUHnsQg67tcJ7VCLCn9SykiX4PAK9WowBHtLaKKs=
=S4r8
-----END PGP SIGNATURE-----

--lqbqmyz32rvoa32o--
