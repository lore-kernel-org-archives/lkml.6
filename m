Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeBZIte (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:49:34 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40174 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751740AbeBZItb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:49:31 -0500
Date: Mon, 26 Feb 2018 09:49:19 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: hao_zhang <hao5781286@gmail.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, wens@csie.org, Claudiu.Beznea@microchip.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/4] ARM: dtsi: add pwm node for sun8i.
Message-ID: <20180226084919.wt2yljq3nxr5g2vu@flea.lan>
References: <20180225135134.GA14529@arx-s1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fexov7z6xzyq67m7"
Content-Disposition: inline
In-Reply-To: <20180225135134.GA14529@arx-s1>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fexov7z6xzyq67m7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2018 at 09:51:34PM +0800, hao_zhang wrote:
> This patch adds pwm node for sun8i.
>=20
> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r=
40.dtsi
> index 173dcc1..99a0261 100644
> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> @@ -295,6 +295,11 @@
>  				bias-pull-up;
>  			};
> =20
> +			pwm_ch0_pin: pwm-ch0-pin {
> +				pins =3D "PB2";
> +				function =3D "pwm";
> +			};
> +
>  			uart0_pb_pins: uart0-pb-pins {
>  				pins =3D "PB22", "PB23";
>  				function =3D "uart0";
> @@ -306,6 +311,14 @@
>  			reg =3D <0x01c20c90 0x10>;
>  		};
> =20
> +		pwm: pwm@1c23400 {
> +			     compatible =3D "allwinner,sun8i-r40-pwm";
> +			     reg =3D <0x01c23400 0x154>;

The size must be the size of the whole memory block allocated to the
controller, so that would be 0x400 in this case.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--fexov7z6xzyq67m7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqTyg4ACgkQ0rTAlCFN
r3Rkig/9GI/xqfLzW6iT4OlKaSseYWJWJ6rvEt1oY8o7bkVa4mMLV7POVS12FbCc
fGQeq9vDI4ohMwW6Wgu7PARNXRTMaVUkt2CKVewaniGiWoFshUTvmw8UiEWKtshK
Nu8P9DfhfTIEU1SPWBTy3y6LcPwbCTVMbNzqFthNCI5/ac3yzHPP4UrYhwFPQh3M
JYVfG5c+pard1iSIt4+kX3P9AEnmDuX3SY2QHxsDTwYG2v6GT/ExazLidBb1JeFn
scMeZvXmpK7X+XmNaAMECU59m41W6exkbPAYu5o1XqQFKvrkjpbVB1rEaCdc6RWH
T7dh+G6KJi/1J+PE9MScYFkJIiEXugnVygKGhq7La3lrXDuv5QmnasBTVJvUlf2L
lUpe7OMy8+WfqUaR4n7smhCU2/IFWODp6UxHg0ZpXjjlQjWN7n+iyQYLfHti8iVk
2EoB1EhOTtB6dcxHN53MirTw3jy4XtHYuRthODDkMmdC+qBJJgI9VSqtBHkrznnT
uc5V6lRfpyIiqI3Mhzqfyvs2mqZrZO1P/m2iFF37ngN1uHDvzej/bNPiuWb4rNxO
Eqg9TLroJfnaKw/f+asfdF3JmIrHUHl7fmL4RqPYFMFJaVDgqHM63o4vlecMO8zD
uby9ebszip4put0K3SMa/egmkkCdrRlagMSsiJyasAoldZBb9CY=
=ZRzc
-----END PGP SIGNATURE-----

--fexov7z6xzyq67m7--
