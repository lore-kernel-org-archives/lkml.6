Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753404AbeCYOSN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 10:18:13 -0400
Received: from 220.107.128.77.rev.sfr.net ([77.128.107.220]:42898 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbeCYOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 10:18:10 -0400
Message-ID: <1521986953.5301.4.camel@paulk.fr>
Subject: Re: [PATCH 4/7] ARM: dts: sun7i: Add pinmux settings for LCD0
 RGB888 output.
From: Paul Kocialkowski <contact@paulk.fr>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org
Date: Sun, 25 Mar 2018 16:09:13 +0200
In-Reply-To: <1521662593-25468-4-git-send-email-giulio.benetti@micronovasrl.com>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
         <1521662593-25468-4-git-send-email-giulio.benetti@micronovasrl.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5Aab1FspCjS0Hic48SE1"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5Aab1FspCjS0Hic48SE1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 21 mars 2018 =C3=A0 21:03 +0100, Giulio Benetti a =C3=A9crit :
> The A20 supports RGB888 with H/V sync from LCD0. Add a pinmux setting
> for the needed pins.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi
> b/arch/arm/boot/dts/sun7i-a20.dtsi
> index efb5607..bfe6728 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -922,6 +922,14 @@
>  				pins =3D "PI20", "PI21";
>  				function =3D "uart7";
>  			};
> +
> +			lcd0_rgb888_pins: lcd0-rgb888-pins {

It would be more consistent with other pins definitions to have
underscores in both names and to indicate the index, such as:
lcd0_rgb888_pins: lcd0_rgb888_pins@0 {

This way, other set of pins for LCD (PH0-PH27) can be declared as @1
when they are needed in the future.

> +				pins =3D "PD0", "PD1", "PD2", "PD3",
> "PD4", "PD5", "PD6", "PD7",
> +				       "PD8", "PD9", "PD10", "PD11",
> "PD12", "PD13", "PD14", "PD15",
> +				       "PD16", "PD17", "PD18",
> "PD19", "PD20", "PD21", "PD22", "PD23",
> +				       "PD24", "PD25", "PD26",
> "PD27";
> +				function =3D "lcd0";
> +			};
>  		};
> =20
>  		timer@1c20c00 {

--=20
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-5Aab1FspCjS0Hic48SE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlq3rYkACgkQhP3B6o/u
lQyFPA/+Jq5sS60mJuYOB7A13KfzwH1rfVlhJN8VkAaTONyxAyhhv1nwUROI61v0
A/+k7FI6cfMKjjO9vh4g9WZo95EUgkzt6SkEwrhxX0/10U2Wp8ruUhAxT/JsOHX5
ETOIIzOKP2FIrx5KKFCKAayIxiyH272Dshtcr7hfUj+SIVF5FU+ccxPZEyXbk3fH
MnFhNvwg2EWDZSq0jdXfMQnlKIympTustwG09oOrHhZLW6J56RCcZbNrCI5AggvZ
b+IxQGjkfYcbuW704QWhyLAKJo53EEF5szPxrbN6KEa3WXXBK2w5wu8ys5XAHXH8
D6ULM60z+8/5dQ0cL1t3+8srvMLwjxrj3NbygD4dmMd6k27/4/XGNerHeAERIsiq
8+FgjRsp5LzjoSbL6GIYG6XkQ55w4D0j/jlOkg9EoiSt2uHGFi23GhmQGwIyb9q+
rZCv8tnU7jkWswKwofNlMHq5WRlx4dfeD6jeRHzF9jQNhCl8baq/1zRs2scxjvXe
xkGgEb4QP5xTKl2IcFAPtBNQUjQEPbs6mnVTb6Jf6B3jx7Z98KSD2Osi4quoh44y
s1NVkeI+YUICcdpG8OzyxaHBVQOj1+1LCKAmeF2JbZD7TUUgplpksGjfOHG5/5rM
ABAbj0IXioEpRiYIy4ZHfRR6IJkkUIWrAA/IAl0EBs7hx2OW6oE=
=H5Th
-----END PGP SIGNATURE-----

--=-5Aab1FspCjS0Hic48SE1--
