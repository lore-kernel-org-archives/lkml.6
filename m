Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeBHJA4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:00:56 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37761 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeBHJAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:00:54 -0500
Date: Thu, 8 Feb 2018 10:00:42 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4] ARM: sun8i: h2+: add support for Banana Pi M2 Zero
 board
Message-ID: <20180208090042.364is5ctofhuao4i@flea>
References: <20180206131647.41700-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="swnqjz6kerpolfyi"
Content-Disposition: inline
In-Reply-To: <20180206131647.41700-1-icenowy@aosc.io>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--swnqjz6kerpolfyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2018 at 09:16:47PM +0800, Icenowy Zheng wrote:
> Banana Pi M2 Zero board is a H2+-based board by Sinovoip, with a form
> factor and GPIO holes similar to Raspberry Pi Zero.
>=20
> It features:
> - Allwinner H2+ SoC
> - Single-chip (16-bit) 512MiB DDR3 DRAM
> - Ampak AP6212 Wi-Fi/Bluetooth module
> - MicroSD slot
> - Two MicroUSB Type-B ports (one can only be used to power the board and
>   the other features OTG functionality)
> - Two keys, a reset and a GPIO-connected key.
> - HDMI Type-C (miniHDMI) connector connected to the HDMI part of H2+.
> - CSI connector to connect the camera sensor provided by Sinovoip.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v4:
> - Use SPDX license identifier.
>=20
> Changes in v3:
> - Add comments about Vbus problem in &usbphy node.
>=20
> Changes in v2:
> - Use high active SD card detect on the production batch.
>=20
>  arch/arm/boot/dts/Makefile                         |   1 +
>  .../boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 126 +++++++++++++++=
++++++
>  2 files changed, 127 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38543dc..d5a17e6e8b0f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -974,6 +974,7 @@ dtb-$(CONFIG_MACH_SUN8I) +=3D \
>  	sun8i-a83t-cubietruck-plus.dtb \
>  	sun8i-a83t-tbs-a711.dtb \
>  	sun8i-h2-plus-orangepi-r1.dtb \
> +	sun8i-h2-plus-bananapi-m2-zero.dtb \
>  	sun8i-h2-plus-orangepi-zero.dtb \
>  	sun8i-h3-bananapi-m2-plus.dtb \
>  	sun8i-h3-beelink-x2.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/=
arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> new file mode 100644
> index 000000000000..e2ee65a5bf92
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> @@ -0,0 +1,126 @@
> +/*
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * Based on sun8i-h3-bananapi-m2-plus.dts, which is:
> + *   Copyright (C) 2016 Chen-Yu Tsai <wens@csie.org>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Sorry to be a bit picky about this, but this should be your very first
line, see arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts for example.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--swnqjz6kerpolfyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp8EbkACgkQ0rTAlCFN
r3ThsBAAjdH63wl4wc/ksPMxWj2MwX3B8P+BfHfb07FLTNQOzk4dzy8mufaEBr52
wwIY1xQsxGo2YLwdOD27ROIwXXqGSC8ti29hr9KQkY3ZJh03UTN5sglNZhbFpphj
q1cHFsKogibGmiMbmgiFukDOHD1qKLIh2HsLfLxdTr2Jn8gls8892IMOhTPriUwE
L2wr1zSuZyHS5PalePdYTWhnT6EXgNzVPE4PZ9kP/e+/IOSRl7t+uANflJuznq05
HLci6syZv0jZAGuigUn6b8mMJOCSSOANLcLjrkn0MEVgnkDWkxbpxE7p6Y4wqVUo
7rvp7/czvE/wtMKmp749wYKddz0m+h+MGjdywmirWJYrWo88GILCMpVoS4Uu3Akn
TLsZ0XvWu9wP2Kj2jkT2O5xNVetufzLFLntrmgwDy5D3DZVWcmvRiRwRI4d2iHv1
lPh6ikznvrgaspCvP568LscPzHHnED33+NpDcdWMiEhhOHeLhKNNMvOWu7mnV14j
j0An/1+FOBOzgoRkrAiZyfeoBjAWY61jnRhd+4GVgSkoMNKZn2ccuChMDEaTDMG1
pLNkL8m7gr5xpyo8AnMJlxWNYYNurBebfqoL+HAeZwrXxc2EHZ2Zsm9PHS7R9XA8
zWus6ryakOQ6bCoEiAfu4jrP7qkOjq++1xoKZZG8tCZtSEJ8YRo=
=2hba
-----END PGP SIGNATURE-----

--swnqjz6kerpolfyi--
