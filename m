Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeDKMn3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:43:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49655 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753120AbeDKMn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:43:27 -0400
Date: Wed, 11 Apr 2018 14:43:25 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 0/8] drm/sun4i: Allwinner MIPI-DSI support
Message-ID: <20180411124325.youvfpws27l2wesf@flea>
References: <cover.a3617c4362eac8783f412525e52cf5552d19095d.1522835818.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zfwx22vfp4b5ttk"
Content-Disposition: inline
In-Reply-To: <cover.a3617c4362eac8783f412525e52cf5552d19095d.1522835818.git-series.maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zfwx22vfp4b5ttk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 11:57:08AM +0200, Maxime Ripard wrote:
> Hi,
>=20
> Here is an preliminary version of the MIPI-DSI support for the Allwinner
> SoCs.
>=20
> This controller can be found on a number of recent SoCs, such as the
> A31, A33 or the A64.
>=20
> Given the sparse documentation, there's a number of obscure areas, but
> the current implementation has been tested with a 4-lanes DSI panel on
> an A33.
>=20
> The support is a bit rough around the edges at the time, and some artifac=
ts
> are still shown on the screen for some reasons. Wider testing with
> different display will hopefully nail those down.
>=20
> This needs the regmap_mmio_attach_clk, on its way to Linus in 4.17.
>=20
> Let me know what you think,
> Maxime
>=20
> Changes from v3:
>   - Rebased on top of current drm-misc-next
>   - Switched to SPDX license header
>   - Made the ECC array const
>   - Split the big DSI patch into two, one to add the DSI driver and one to
>     add the TCON bits.
>   - Removed the dithering code
>   - Changed the DT labels to remove the indices
>   - Used sleeps instead of delays in the panel driver
>   - Used the backlight_enable / _disable functions
>   - Added Chen-Yu's Reviewed-by
>=20
> Changes from v2:
>   - Added a ports node under the DSI node
>   - Changed the huarui panel driver to an ili9881c driver
>   - Changed the panel vendor to bananapi
>   - Made the init table static in the panel driver
>   - Dropped the huarui vendor patch for the DT doc.
>=20
> Changes from v1:
>   - Rebased on 4.16-rc1
>   - Constified a few function arguments and structures
>   - Reworked the DT binding example a bit
>   - Reworked the panel driver to check for DSI return codes, and use DCS
>     helpers when possible
>=20
> Maxime Ripard (8):
>   drm/sun4i: tcon: Add TRI finish interrupt for vblank
>   dt-bindings: display: Add Allwinner MIPI-DSI bindings
>   drm/sun4i: Add Allwinner A31 MIPI-DSI controller support
>   drm/sun4i: Tie the DSI controller in the TCON
>   dt-bindings: panel: Add the Ilitek ILI9881c panel documentation
>   drm/panel: Add Ilitek ILI9881c panel driver
>   ARM: dts: sun8i: a33: Add the DSI-related nodes
>   [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI display

I just pushed the patches 1-4 and 7. I'll wait for some feedback from
Thierry for the panel driver.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--4zfwx22vfp4b5ttk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrOAuwACgkQ0rTAlCFN
r3RtbA/+MY1ciW/H1rpoYuORTd6yp21/tO4dqQXmM6XgDsnOcMbwQKjzSISD282K
OJQn3ymle7r12icKlyBqtBkPIRxw7lXpjze9ymKpQ4CS96ge+g09LGOA+p6q5s1J
+6H53S2xuLyjpv38Nl3E4F5xWGmKeqLx246mWGbdfBJzk5XUEJTWiPjjHrCFtG6R
zxSjXTCy0frvN8t8SLZDdITzb9j4YLw/mE4MG1gaksWi0eAS6UYYK6TuykaVjGpZ
3AOLrQokwzNQzSQzHNmnm6vqZkYXavfFrw4NmDViqz3mb61TffDztbTPSfg/jX2S
bkZBEBseqYjjMEtf6uxwxWGRdeebax1aih/buXXDdYwNhmXsVuxPUXKY4vZD8bJA
tD8s/ItEz5OMeWYa4u8EzWDx2gg4lC3R/Cl8Wwa1Dvo7dnGfamo2G1UA+B/CyYb6
UYFXjSV9P0cZQsR5z/RL48hFDE2zvxGXc5S38WiBSfQSyQRtPynC8aiHgg+5PnzO
CSFrG9qvo/nUaAYn18x5dCXLwt8kMmfEfwtkNyNJvdAyJ/4361JT+0My/dvozvyI
v0BLKUoug0E3fnO9TXXNVnbjnnMZwIlD5bup+NtA9mmwPbA3G+ldZxdJPBiba6Jh
DDv2h0igQRrHl376RPn88zidMR2/nFycvoc1vIOYQLNU5Oy2nLY=
=80pr
-----END PGP SIGNATURE-----

--4zfwx22vfp4b5ttk--
