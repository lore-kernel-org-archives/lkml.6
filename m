Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D48ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD6C2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD6C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeIXOb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:31:57 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52758 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbeIXOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:31:57 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42Jcq50vS9z1qvCD;
        Mon, 24 Sep 2018 10:30:57 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42Jcq46GDFz1qqkp;
        Mon, 24 Sep 2018 10:30:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Mgy4kyS7wgqF; Mon, 24 Sep 2018 10:30:54 +0200 (CEST)
X-Auth-Info: keJ4U9B0H87t4U82vQn8UDjDZwRgK+8u0sT12joMc4g=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 24 Sep 2018 10:30:54 +0200 (CEST)
Date:   Mon, 24 Sep 2018 10:30:45 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] ARM: dts: Add support for Liebherr's BK4 device (vf610
 based)
Message-ID: <20180924103045.524c6855@jawa>
In-Reply-To: <CAOMZO5DPnWNJ_UVdE9Lvh05R84seP8VPP=35eEUaor4-pppXGQ@mail.gmail.com>
References: <20180921152726.31742-1-lukma@denx.de>
        <CAOMZO5DPnWNJ_UVdE9Lvh05R84seP8VPP=35eEUaor4-pppXGQ@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5BDm3QG0=cl.1V1CQsGjFCa"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5BDm3QG0=cl.1V1CQsGjFCa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

Thanks for your review.

> On Fri, Sep 21, 2018 at 12:27 PM, Lukasz Majewski <lukma@denx.de>
> wrote:
> > This commit adds DTS support for BK4 device from Liebherr. It
> > uses vf610 SoC from NXP.
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  arch/arm/boot/dts/Makefile      |   1 +
> >  arch/arm/boot/dts/vf610-bk4.dts | 504
> > ++++++++++++++++++++++++++++++++++++++++ 2 files changed, 505
> > insertions(+) create mode 100644 arch/arm/boot/dts/vf610-bk4.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index b5bd3de87c33..e6f159895fa9 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -577,6 +577,7 @@ dtb-$(CONFIG_SOC_LS1021A) +=3D \
> >         ls1021a-twr.dtb
> >  dtb-$(CONFIG_SOC_VF610) +=3D \
> >         vf500-colibri-eval-v3.dtb \
> > +       vf610-bk4.dtb \
> >         vf610-colibri-eval-v3.dtb \
> >         vf610m4-colibri.dtb \
> >         vf610-cosmic.dtb \
> > diff --git a/arch/arm/boot/dts/vf610-bk4.dts
> > b/arch/arm/boot/dts/vf610-bk4.dts new file mode 100644
> > index 000000000000..4ad7e739a0ad
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/vf610-bk4.dts
> > @@ -0,0 +1,504 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2018
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +
> > +/dts-v1/;
> > +#include "vf610.dtsi"
> > +
> > +/ {
> > +       model =3D "Liebherr BK4 controller";
> > +       compatible =3D "lwn,bk4", "fsl,vf610";
> > +
> > +       chosen {
> > +               bootargs =3D "console=3DttyLP1,115200"; =20
>=20
> You could pass stdout-path instead.

Ok.

>=20
> > +       };
> > +
> > +       memory@80000000 {
> > +               reg =3D <0x80000000 0x8000000>;
> > +       };
> > +
> > +       audio_ext: mclk_osc {
> > +               compatible =3D "fixed-clock";
> > +               #clock-cells =3D <0>;
> > +               clock-frequency =3D <24576000>;
> > +       }; =20
>=20
> This seems to be unused.

The audio_ext label is used (referenced) in the "clks".

>=20
> > +
> > +       enet_ext: eth_osc {
> > +               compatible =3D "fixed-clock";
> > +               #clock-cells =3D <0>;
> > +               clock-frequency =3D <50000000>;
> > +       };
> > +
> > +       leds {
> > +               compatible =3D "gpio-leds";
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&pinctrl_gpio_leds>;
> > +
> > +               /* LED D5 */
> > +               led0: heartbeat {
> > +                       label =3D "heartbeat";
> > +                       gpios =3D <&gpio3 21 GPIO_ACTIVE_HIGH>;
> > +                       default-state =3D "on";
> > +                       linux,default-trigger =3D "heartbeat";
> > +               };
> > +       };
> > +
> > +       regulators {
> > +               compatible =3D "simple-bus";
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <0>;
> > +
> > +               reg_3p3v: regulator@0 { =20
>=20
> Please move all regulators outside of the simple-bus container and use
> this naming convention:
>=20
> reg_3p3v: regulator-3p3v {

Ok.

>=20
> > +&dspi3 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_dspi3>;
> > +       bus-num =3D <3>;
> > +       status =3D "okay";
> > +
> > +       spidev3@0 {
> > +               compatible =3D "fsl,vf610-dspi";
> > +               spi-max-frequency =3D <30000000>;
> > +               reg =3D <0>;
> > +               fsl,spi-slave-mode; =20
>=20
> Such property does not exist.

It has been added in the other patch sent to ML:
https://lkml.org/lkml/2018/9/18/792

But till now no comments/reply.

>=20
> I also thought that spidev nodes in dt were not recommended.

This is a bit "unusual" on BK4, as the spidev driver is the only "user"
of the SPI subsystem on this board. In other words - the /dev/spidevX.Y
provided by spidev is solely used for communication.

Hence, I would prefer to make it explicit in the DTS.

>=20
> > +&iomuxc { =20
>=20
> Like Stefan mentioned it is common practice on imx dts files to place
> the iomuxc node as the last one.

Ok.

>=20
>=20
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_bk4_common>; =20
>=20
> This seems to be not called from any driver.

Yes. This is "base" setup for the board. Those configured pins are
thereafter used by several user space programs.

>=20
> We usually use a hog group for such purpose.

I wanted to name it explicit that we do use it for this controller.
However, no problem to rename it to hog.

>=20
> > +
> > +       pinctrl_bk4_common: commongrp {
> > +               fsl,pins =3D <
> > +                       /* One_Wire_PSU_EN */
> > +                       VF610_PAD_PTC29__GPIO_102
> > 0x1183
> > +                       /* SPI */
> > +                       VF610_PAD_PTB26__GPIO_96
> > 0x1183
> > +                       VF610_PAD_PTE14__GPIO_119
> > 0x1183
> > +                       VF610_PAD_PTE4__GPIO_109
> > 0x1181
> > +                       /* Feedback_Lines */
> > +                       VF610_PAD_PTC31__GPIO_104
> > 0x1181
> > +                       VF610_PAD_PTA7__GPIO_134
> > 0x1181
> > +                       VF610_PAD_PTD9__GPIO_88         0x1181
> > +                       VF610_PAD_PTE1__GPIO_106
> > 0x1183
> > +                       VF610_PAD_PTB2__GPIO_24         0x1181
> > +                       VF610_PAD_PTB3__GPIO_25         0x1181
> > +                       VF610_PAD_PTB1__GPIO_23         0x1181
> > +                       /* SDHC */
> > +                       VF610_PAD_PTE19__GPIO_124
> > 0x1183
> > +                       VF610_PAD_PTB23__GPIO_93
> > 0x1181 =20
>=20
> If they are related to SDHC they should be better placed under the
> sdhc nodes.
>=20

I will double check this.

>=20
> > +                       /* GPI */
> > +                       VF610_PAD_PTE2__GPIO_107
> > 0x1181
> > +                       VF610_PAD_PTE3__GPIO_108
> > 0x1181
> > +                       VF610_PAD_PTE5__GPIO_110
> > 0x1181
> > +                       VF610_PAD_PTE6__GPIO_111
> > 0x1181
> > +                       /* GPO */
> > +                       VF610_PAD_PTE0__GPIO_105
> > 0x1183
> > +                       VF610_PAD_PTE7__GPIO_112
> > 0x1183
> > +                       /* RS485 */
> > +                       VF610_PAD_PTB8__GPIO_30         0x1183
> > +                       VF610_PAD_PTB9__GPIO_31         0x1183
> > +                       VF610_PAD_PTE8__GPIO_113
> > 0x1183
> > +                       /* MPBUS MPB_EN */
> > +                       VF610_PAD_PTE28__GPIO_133
> > 0x1183
> > +                       /* LEDS */
> > +                       VF610_PAD_PTE15__GPIO_120
> > 0x1183
> > +                       VF610_PAD_PTA12__GPIO_5         0x1183
> > +                       VF610_PAD_PTA16__GPIO_6         0x1183
> > +                       VF610_PAD_PTE9__GPIO_114
> > 0x1183
> > +                       VF610_PAD_PTE20__GPIO_125
> > 0x1183
> > +                       VF610_PAD_PTE23__GPIO_128
> > 0x1183
> > +                       VF610_PAD_PTE16__GPIO_121
> > 0x1183
> > +                       /* MISC */
> > +                       VF610_PAD_PTE10__GPIO_115
> > 0x1183
> > +                       VF610_PAD_PTE11__GPIO_116
> > 0x1183
> > +                       VF610_PAD_PTE17__GPIO_122
> > 0x1183
> > +                       VF610_PAD_PTC30__GPIO_103
> > 0x1183
> > +                       VF610_PAD_PTB0__GPIO_22         0x1181
> > +                       /* RESETINFO */
> > +                       VF610_PAD_PTE26__GPIO_131
> > 0x1183
> > +                       VF610_PAD_PTD6__GPIO_85         0x1181
> > +                       VF610_PAD_PTE27__GPIO_132
> > 0x1181
> > +                       VF610_PAD_PTE13__GPIO_118
> > 0x1181
> > +                       VF610_PAD_PTE21__GPIO_126
> > 0x1181
> > +                       VF610_PAD_PTE22__GPIO_127
> > 0x1181
> > +                       /* EE_5V_EN */
> > +                       VF610_PAD_PTE18__GPIO_123
> > 0x1183
> > +                       /* EE_5V_OC_N */
> > +                       VF610_PAD_PTE25__GPIO_130
> > 0x1181 =20
>=20
> Seems like a long list of pins without any driver associated.

Not kernel driver associated. The user space code uses those pins
directly.

>=20
> Please review such list carefully and assign to nodes that have a
> driver associated, such as rs485,LEDS, etc.

For example - the user space is not using in-kernel rs485 driver.

But as said above - I will double check this.

>=20
> > +
> > +&usbphy0 {
> > +       status =3D "okay";
> > +};
> > +
> > +&usbphy1 {
> > +       status =3D "okay";
> > +};
> > +
> > +&qspi0 { =20
>=20
> This is not placed in alphabetical order.

Ok.=20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/5BDm3QG0=cl.1V1CQsGjFCa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAluooLUACgkQAR8vZIA0
zr1uEggA16OlvAYKCEfUrftoxqibHeGUSJexXE2VsEx8M6zBQ5eQ5TFhhkJapZpJ
7Wtn2V8sI/SsBzOaBjFMIkohc2VRLZo9BRIge2QPlLAnUr9tP6JRjTEFO7WwdAmW
yY9406YInqdZmpAJsW2eJB+LFQvXXhrQ/5FJJ8Wcw+JEqitqcoBQDWOfj2TCTO+f
taZ5bI7VquojXV1YKcKR7HixcoY8koHyDaw3OcGd+Zta//U2hiOIB6iak5e2/ZEQ
6XjE1eOoT09kbU3emqUuZkt+sr6esVIMwTNXOalQxEu1BnPmLMKMR9Gukg17Y6/1
OqgBDkYK8LJ6RKVolyAjDbBb4OqtJg==
=HSms
-----END PGP SIGNATURE-----

--Sig_/5BDm3QG0=cl.1V1CQsGjFCa--
