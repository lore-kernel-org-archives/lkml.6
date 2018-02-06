Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeBFJLa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:11:30 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46065 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752544AbeBFJLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:11:23 -0500
Date: Tue, 6 Feb 2018 10:10:57 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 07/10] ARM: sun8i: h3: add SY8113B regulator used by
 Orange Pi One board
Message-ID: <20180206091057.6uy4fdcfztgmjjlz@flea>
References: <20180206044905.30508-1-icenowy@aosc.io>
 <20180206044905.30508-8-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dn475h2o6sub6pou"
Content-Disposition: inline
In-Reply-To: <20180206044905.30508-8-icenowy@aosc.io>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dn475h2o6sub6pou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2018 at 12:49:02PM +0800, Icenowy Zheng wrote:
> Orange Pi One board has a SY8113B regulator, which is controlled via
> GPIO and capable of outputing 1.1V when the PL6 GPIO is set to output 0
> or 1.3V when the PL6 GPIO is set to input or output 1, and the output is
> the power supply of the ARM cores in H3 SoC.
>=20
> Add the device tree node of this regulator and set the cpu's cpu-supply
> property to it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> New patch in v2.
>=20
>  arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/=
dts/sun8i-h3-orangepi-one.dts
> index 82e5d28cd698..d8250aacfda1 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
> @@ -88,6 +88,27 @@
>  			gpios =3D <&r_pio 0 3 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> +
> +	reg_sy8113b: gpio-regulator {

There's multiple of them on those boards, so the name and label should
avoid conflicting names (this also applies to your other patches).

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--dn475h2o6sub6pou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp5cSAACgkQ0rTAlCFN
r3SOUg//fnVRDjyAwTPYoxoIrsLciXHBYENYcxay4PQOlVCeN4J1bKr3CxhcBWn7
hy4fGJbdwebtLFbNhyWZ3KY5+BLiSXVPXmb6IK7huIbbs5bIM66eFhXUF3z7TaJV
R69MT0vPU3DT8J5w4qj7u5G11bEzPotVBDF/elU0+DAXICKG9JEb6BGxcc7Qu2QA
9uOISxvD5HPYs3QJSpLMjZPqrjkPmw6+eEgorRBSAddGxBZ6vS85u6B1WfQ5nynK
ep4KQpHdLXJlUSY/67Zo9PkjD2XdY8LT1O7ZC98D2SF4IE2dRf/IxLIXcxhI9GIu
/a6LfXumelOzeqR2qHgx3rvJSx7XDnYMTniXwRZWknq5hLb18WX5YnnlyfbZPgLy
x6matRubkp0RGOrjoJsJ3oPHVnrYxcCB8T3Lpj2ICnoZ5MzJomD5caqvXXQoFuuw
pulyqT7FKVtGX7DIGAbo7vrA7JZiQLwihua02D94UOOtbbhk4DjnVn+lyXxkEnPZ
xsRD2rcrizr9r3Oy8tm6G7VDBgBgi/oAl135jiwzkNOblxOS8aKunm3xme40Hvrj
s2s4Ik22uaPCLs3fgXS10sz+sAnROuUMoOBJ+rZHw+uvUz8ZoVOXnBHM6nFMTVA4
AQ6punpHhpQ2s8bmHow4OteRZd8SgGjJRXJ8VxMfOvF3ruiD0iY=
=1FM/
-----END PGP SIGNATURE-----

--dn475h2o6sub6pou--
