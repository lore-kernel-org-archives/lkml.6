Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeCCHGW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 02:06:22 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:38726 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbeCCHGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 02:06:20 -0500
X-Auth-Info: xxrCm75/D/3jGkAi5facMVSF5WWneMDFkysSHIbqzyk=
Date: Sat, 3 Mar 2018 08:06:04 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: tpc: Device tree description of the TPC board
Message-ID: <20180303080604.6fe8a9d3@jawa>
In-Reply-To: <CAOMZO5BTnfHRkGnROh3LJoGVPcBcQk=rroYip4V1DDBUbkRuKw@mail.gmail.com>
References: <20180302121750.12865-1-lukma@denx.de>
        <CAOMZO5BTnfHRkGnROh3LJoGVPcBcQk=rroYip4V1DDBUbkRuKw@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VuCQwDrQ.000F+hDuAQzenc"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VuCQwDrQ.000F+hDuAQzenc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> In addition to Sascha's comments:

Thanks for your input - please see my reply below.

>=20
> On Fri, Mar 2, 2018 at 9:17 AM, Lukasz Majewski <lukma@denx.de> wrote:
>=20
> > diff --git a/arch/arm/boot/dts/imx6q-kp-tpc.dts
> > b/arch/arm/boot/dts/imx6q-kp-tpc.dts new file mode 100644
> > index 000000000000..955462e778c9
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6q-kp-tpc.dts
> > @@ -0,0 +1,84 @@
> > +/*
> > + * Copyright 2018
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + *
> > + * This file is dual-licensed: you can use it either under the
> > terms
> > + * of the GPL or the X11 license, at your option. Note that this
> > dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This file is licensed under the terms of the GNU General
> > Public
> > + *     License version 2.  This program is licensed "as is" without
> > + *     any warranty of any kind, whether express or implied.
> > + *
> > + * Or, alternatively,
> > + *
> > + *  b) Permission is hereby granted, free of charge, to any person
> > + *     obtaining a copy of this software and associated
> > documentation
> > + *     files (the "Software"), to deal in the Software without
> > + *     restriction, including without limitation the rights to use,
> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
> > + *     sell copies of the Software, and to permit persons to whom
> > the
> > + *     Software is furnished to do so, subject to the following
> > + *     conditions:
> > + *
> > + *     The above copyright notice and this permission notice shall
> > be
> > + *     included in all copies or substantial portions of the
> > Software.
> > + *
> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> > KIND,
> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
> > WARRANTIES
> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > OR
> > + *     OTHER DEALINGS IN THE SOFTWARE.
> > + */
> > + =20
>=20
> Please consider using SPDX tag instead.

Ok.

>=20
> > +/dts-v1/;
> > +
> > +#include "imx6q-kp.dtsi"
> > +
> > +/ {
> > +       model =3D "Freescale i.MX6 Quad K+P TPC Board";
> > +       compatible =3D "fsl,imx6q-tpc", "fsl,imx6q"; =20
>=20
> Use the board manufacturer symbol instead.
>=20
> If needed, add an entry for the vendor at
> Documentation/devicetree/bindings/vendor-prefixes.txt

I see.

>=20
> > +};
> > +
> > +&lcd_display {
> > +       display-timings {
> > +               800x480x60 {
> > +                       clock-frequency =3D <34209000>;
> > +                       hactive =3D <800>;
> > +                       vactive =3D <480>;
> > +                       hback-porch =3D <85>;
> > +                       hfront-porch =3D <15>;
> > +                       vback-porch =3D <34>;
> > +                       vfront-porch =3D <10>;
> > +                       hsync-len =3D <28>;
> > +                       vsync-len =3D <1>;
> > +                       hsync-active =3D <1>;
> > +                       vsync-active =3D <1>;
> > +                       de-active =3D <1>;
> > +               };
> > +       };
> > +}; =20
>=20
> We prefer to use a compatible panel entry instead of keeping the panel
> timings inside the dts.

Previously (for other imx6q board) I've added entry to e.g.
panel-simple.c file [1] to describe the display.

I thought that adding timings to DTS is more welcome - hence we do not
need to add any extra code to Linux when porting new board?

>=20
> > +
> > +&ipu1_di0_disp0 {
> > +       remote-endpoint =3D <&lcd_display_in>;
> > +};
> > +
> > +&can1 {
> > +       status =3D "disabled";
> > +};
> > +
> > +&can2 {
> > +       status =3D "disabled";
> > +};
> > +
> > +&uart1 {
> > +       status =3D "okay";
> > +};
> > +
> > +&uart2 {
> > +       status =3D "disabled";
> > +};
> > diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi
> > b/arch/arm/boot/dts/imx6q-kp.dtsi new file mode 100644
> > index 000000000000..47a10fb1d46b
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6q-kp.dtsi
> > @@ -0,0 +1,468 @@
> > +/*
> > + * Copyright 2018
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + *
> > + * This file is dual-licensed: you can use it either under the
> > terms
> > + * of the GPL or the X11 license, at your option. Note that this
> > dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This file is licensed under the terms of the GNU General
> > Public
> > + *     License version 2.  This program is licensed "as is" without
> > + *     any warranty of any kind, whether express or implied.
> > + *
> > + * Or, alternatively,
> > + *
> > + *  b) Permission is hereby granted, free of charge, to any person
> > + *     obtaining a copy of this software and associated
> > documentation
> > + *     files (the "Software"), to deal in the Software without
> > + *     restriction, including without limitation the rights to use,
> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
> > + *     sell copies of the Software, and to permit persons to whom
> > the
> > + *     Software is furnished to do so, subject to the following
> > + *     conditions:
> > + *
> > + *     The above copyright notice and this permission notice shall
> > be
> > + *     included in all copies or substantial portions of the
> > Software.
> > + *
> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> > KIND,
> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
> > WARRANTIES
> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > OR
> > + *     OTHER DEALINGS IN THE SOFTWARE.
> > + */ =20
>=20
> SPDX, please.

The other upstreamed imx6q board used dual license - GPLv2 or X11
(which is also called MIT license).

I suppose that this license header shall be replaced with:

SPDX-License-Identifier: (GPL-2.0+ OR MIT)

Am I correct?

>=20
>=20
> > +       leds {
> > +               compatible =3D "gpio-leds";
> > +
> > +               green {
> > +                       label =3D "led1";
> > +                       gpios =3D <&gpio3 16 0>; =20
>=20
> gpios =3D <&gpio3 16 GPIO_ACTIVE_HIGH>;
>=20
> > +                       linux,default-trigger =3D "gpio";
> > +                       default-state =3D "off";
> > +               };
> > +
> > +               red {
> > +                       label =3D "led0";
> > +                       gpios =3D <&gpio3 23 0>; =20
>=20
> GPIO_ACTIVE_HIGH

Ok.

>=20
> > +                       linux,default-trigger =3D "gpio";
> > +                       default-state =3D "off";
> > +               };
> > +       };
> > +
> > +       memory: memory {
> > +               reg =3D <0x10000000 0x40000000>;
> > +       }; =20
>=20
>  memory@10000000 otherwise warnings are seen when building with W=3D1.
>=20
> Make sure that building the dtb with W=3D1 introduces no warnings.

Ok. Thanks for pointing this out.

>=20
> > +&i2c1 {
> > +       clock-frequency =3D <400000>;
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_i2c1>;
> > +       status =3D "okay";
> > +
> > +       goodix_ts@5d {
> > +               compatible =3D "goodix,gt911";
> > +               reg =3D <0x5d>;
> > +
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&pinctrl_ts>;
> > + =20
>=20
> No need for these blank lines.

Ok.

>=20
> > +               interrupt-parent =3D <&gpio1>;
> > +               interrupts =3D <9 2>; =20
>=20
> Please use an IRQ flag.
>=20
> > +               irq-gpios =3D <&gpio1 9 0>; =20
>=20
> GPIO_ACTIVE_HIGH
>=20
> > +               reset-gpios =3D <&gpio5 2 0>; =20
>=20
> GPIO_ACTIVE_HIGH.
>=20
> > +&i2c2 {
> > +       clock-frequency =3D <400000>;
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_i2c2>;
> > +       status =3D "okay";
> > +
> > +       codec: sgtl5000@a {
> > +               compatible =3D "fsl,sgtl5000";
> > +               #sound-dai-cells =3D <0>;
> > +               reg =3D <0x0a>;
> > +
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&pinctrl_codec>;
> > + =20
>=20
> No need for these blank lines.
>=20
> > +               clocks =3D <&clks IMX6QDL_CLK_CKO>;
> > +               VDDA-supply =3D <&reg_3p3v>;
> > +               VDDIO-supply =3D <&reg_3p3v>; =20
>=20
> > +&uart2 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_uart2>;
> > +       fsl,uart-has-rtscts; =20
>=20
>  fsl,uart-has-rtscts has been deprecated. Please use  uart-has-rtscts
> instead.

Ok.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/VuCQwDrQ.000F+hDuAQzenc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlqaSVwACgkQAR8vZIA0
zr17lggAqcenqa7YaJXLYjAtl7KuBxSeAfeumO4wLj4fWzg0sDr3IEIJkydRsya8
vtahdMElKH8r2CI6yY0I8Bg+wNr+94kfTQZ3/pCFNzeIGJqJBviLUpVuliOmYDRy
VMAN4TUOw8OXV6CLpey0SA4Vs/UQ09lvpZc3gdHHn93xQlcfaZU08kQzRZTOOYXU
mmlZJOOqSUEsf3ns5UQ8Dh0OGq5Sh1W/eHLZVWCK2ZdXFZzpPyC93w7Qy6QRwAd0
cqVNVv5dlM4xwaW+21HrmJK9EV8ZBPtsDQInb1rPeIU5FgYPq0vfcGyOA54z1aiw
vijChwGl3PIwYuJfJJ7tWhJ/ES3Hlg==
=wTXT
-----END PGP SIGNATURE-----

--Sig_/VuCQwDrQ.000F+hDuAQzenc--
