Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeBHPMI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:12:08 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46976 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeBHPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:12:07 -0500
Date: Thu, 8 Feb 2018 16:11:55 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5] ARM: sun8i: h2+: add support for Banana Pi M2 Zero
 board
Message-ID: <20180208151155.ncmsoeofjjj6nrid@flea>
References: <20180208100613.4761-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="24hj64woalvrjqff"
Content-Disposition: inline
In-Reply-To: <20180208100613.4761-1-icenowy@aosc.io>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24hj64woalvrjqff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2018 at 06:06:13PM +0800, Icenowy Zheng wrote:
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

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--24hj64woalvrjqff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp8aLoACgkQ0rTAlCFN
r3T8MQ/9GeHsZVivf8XAtlFfiWTDM4IJqr/9cV1/oZLmRR4prVWAfKLpgDAWG5N9
ipSp68Djxx+3klSdJ/A/yPUekr9FKzkQ8krAGlOabnHRRMywGtMa0Ej6P8EO8W1+
sUFOwB2xKfOZxuZnlCmjIpnEtvpXKDlJqFmf7JkNrm4Fz5OcQ6EysWibbKE/aL6F
Tr4gxYt5F4LL4S4U4HAnVPGDgXwql4tk5GdKwl6OS7lnZUs1VWHyv/hty+lxgsbu
XqXG8/58PdROp17HbekUt0x5ReIFj2e+5A5iqgq1Wur4zvmC1ZmNN2W72H0nvOxt
GaOHX6Q9DUgal5Rz91ehKbd61mDjhRUH2VFvuGI8O7YKkQF8xR1O5UkzBi3wgImH
oAXaPaVA9IOFOdgF4ggIXkKyeN59UEe++ZVipT+CcjI2SVAplsYpSnANZBZ5rVIg
f5wxfCcEHESnZBX3Tpw9+9aqXPmMeVJKX3O/mSAoBTGcxuJjs0EKYP7Ke6rUZZYO
kdIdom6KhEBnJPsbc2ke828KPOYtO+0+qLYUMw42mEqgyA9W6oR+CygN4usiUDNb
BGwCmYYaOyNZnaOPn+FbkrVctxFt/oB0owWABAvfdm3LEdE0HIn1sY5qGunlVL+f
iUs9Ab0m9yeghSKUFO5O75VxsJb/4w7hHmYouZxSTae+MuaNcaw=
=E2px
-----END PGP SIGNATURE-----

--24hj64woalvrjqff--
