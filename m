Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32641C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F4F21532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 12:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F4F21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbeIVSes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 14:34:48 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57077 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbeIVSes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 14:34:48 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42HVSr4Mj0z1qxQk;
        Sat, 22 Sep 2018 14:41:16 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42HVSr3FrTz1qrWl;
        Sat, 22 Sep 2018 14:41:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id v1T-6mpJfYnh; Sat, 22 Sep 2018 14:41:14 +0200 (CEST)
X-Auth-Info: rIizYKOwDuu+/a5+4EzqDKtG3p/1yPsM0ekOPZQb0+M=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 22 Sep 2018 14:41:14 +0200 (CEST)
Date:   Sat, 22 Sep 2018 14:41:03 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] ARM: dts: Add support for Liebherr's BK4 device (vf610
 based)
Message-ID: <20180922144103.479b64f6@jawa>
In-Reply-To: <6208c70880286ec061f02f1ce679dcdc@agner.ch>
References: <20180921152726.31742-1-lukma@denx.de>
        <6208c70880286ec061f02f1ce679dcdc@agner.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RO9tyBSd6zN.CCTtjTQef/2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RO9tyBSd6zN.CCTtjTQef/2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

Thanks for review,

> On 21.09.2018 08:27, Lukasz Majewski wrote:
> > This commit adds DTS support for BK4 device from Liebherr. It
> > uses vf610 SoC from NXP.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  arch/arm/boot/dts/Makefile      |   1 +
> >  arch/arm/boot/dts/vf610-bk4.dts | 504
> > ++++++++++++++++++++++++++++++++++++++++ 2 files changed, 505
> > insertions(+) create mode 100644 arch/arm/boot/dts/vf610-bk4.dts
> >=20
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index b5bd3de87c33..e6f159895fa9 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -577,6 +577,7 @@ dtb-$(CONFIG_SOC_LS1021A) +=3D \
> >  	ls1021a-twr.dtb
> >  dtb-$(CONFIG_SOC_VF610) +=3D \
> >  	vf500-colibri-eval-v3.dtb \
> > +	vf610-bk4.dtb \
> >  	vf610-colibri-eval-v3.dtb \
> >  	vf610m4-colibri.dtb \
> >  	vf610-cosmic.dtb \
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
> > +	model =3D "Liebherr BK4 controller";
> > +	compatible =3D "lwn,bk4", "fsl,vf610";
> > +
> > +	chosen {
> > +		bootargs =3D "console=3DttyLP1,115200";
> > +	};
> > +
> > +	memory@80000000 {
> > +		reg =3D <0x80000000 0x8000000>;
> > +	};
> > +
> > +	audio_ext: mclk_osc { =20
>=20
> Node name should be somewhat generic. I know its the same in twr
> board, we probably should fix it there. The device tree spec has some
> recommendation, I would suggest using just "oscillator-audio".

So it shall be audio_ext: oscillator-audio { ...

>=20
> > +		compatible =3D "fixed-clock";
> > +		#clock-cells =3D <0>;
> > +		clock-frequency =3D <24576000>;
> > +	};
> > +
> > +	enet_ext: eth_osc { =20
>=20
> Same here, oscillator-ethernet maybe.

Ok - enet_ext: oscillator-ethernet { ...

>=20
>=20
> > +		compatible =3D "fixed-clock";
> > +		#clock-cells =3D <0>;
> > +		clock-frequency =3D <50000000>;
> > +	};
> > +
> > +	leds {
> > +		compatible =3D "gpio-leds";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_gpio_leds>;
> > +
> > +		/* LED D5 */
> > +		led0: heartbeat {
> > +			label =3D "heartbeat";
> > +			gpios =3D <&gpio3 21 GPIO_ACTIVE_HIGH>;
> > +			default-state =3D "on";
> > +			linux,default-trigger =3D "heartbeat";
> > +		};
> > +	};
> > +
> > +	regulators {
> > +		compatible =3D "simple-bus";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>; =20
>=20
> We stopped using a regulator subnode. Just move the regulators to the
> top and use unique names such as "regulator-3p3v".

Ok.

>=20
> > +
> > +		reg_3p3v: regulator@0 {
> > +			compatible =3D "regulator-fixed";
> > +			reg =3D <0>;
> > +			regulator-name =3D "3P3V";
> > +			regulator-min-microvolt =3D <3300000>;
> > +			regulator-max-microvolt =3D <3300000>;
> > +			regulator-always-on;
> > +		};
> > +
> > +		reg_vcc_3v3_mcu: regulator@1 {
> > +			compatible =3D "regulator-fixed";
> > +			reg =3D <1>;
> > +			regulator-name =3D "vcc_3v3_mcu";
> > +			regulator-min-microvolt =3D <3300000>;
> > +			regulator-max-microvolt =3D <3300000>;
> > +		};
> > +	};
> > +};
> > +
> > +&adc0 {
> > +	vref-supply =3D <&reg_vcc_3v3_mcu>;
> > +	status =3D "okay";
> > +};
> > +
> > +&adc1 {
> > +	vref-supply =3D <&reg_vcc_3v3_mcu>;
> > +	status =3D "okay";
> > +};
> > +
> > +&can0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_can0>;
> > +	status =3D "okay";
> > +};
> > +
> > +&can1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_can1>;
> > +	status =3D "okay";
> > +};
> > +
> > +&clks {
> > +	clocks =3D <&sxosc>, <&fxosc>, <&enet_ext>, <&audio_ext>;
> > +	clock-names =3D "sxosc", "fxosc", "enet_ext", "audio_ext";
> > +};
> > +
> > +&dspi0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_dspi0>;
> > +	bus-num =3D <0>;
> > +	status =3D "okay";
> > +
> > +	spidev0@0 {
> > +		compatible =3D "fsl,vf610-dspi"; =20
>=20
> I don't think this is right. A subnode of the dspi controller should
> use a device tree binding of SPI device. What is connected to that
> SPI in your case?=20

The dspi IP block provides SPI communication with variety of devices
(connected via external cable).

=46rom SW point of view, the spidev driver is used. User space program(s)
via the /dev/spidevX.Y device communicate with connected HW.

I would need "just" to add:
+       { .compatible =3D "fsl,vf610-dspi" },

in drivers/spi/spidev.c


I'm wondering what is the actual policy - such "adjustments" are in the
end very board specific.

>=20
> > +		spi-max-frequency =3D <30000000>;
> > +		reg =3D <0>;
> > +		fsl,spi-cs-sck-delay =3D <200>;
> > +		fsl,spi-sck-cs-delay =3D <400>;
> > +	};
> > +};
> > +
> > +&dspi3 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_dspi3>;
> > +	bus-num =3D <3>;
> > +	status =3D "okay";
> > +
> > +	spidev3@0 {
> > +		compatible =3D "fsl,vf610-dspi"; =20
>=20
> Same here...
>=20
> > +		spi-max-frequency =3D <30000000>;
> > +		reg =3D <0>;
> > +		fsl,spi-slave-mode;
> > +	};
> > +};
> > +
> > +&edma0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&edma1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&esdhc1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_esdhc1>;
> > +	bus-width =3D <4>;
> > +	cd-gpios =3D <&gpio3 2 GPIO_ACTIVE_LOW>;
> > +	status =3D "okay";
> > +};
> > +
> > +&fec0 {
> > +	phy-mode =3D "rmii";
> > +	phy-handle =3D <&ethphy0>;
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_fec0>;
> > +	status =3D "okay";
> > +
> > +	mdio {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +		ethphy0: ethernet-phy@1 {
> > +			reg =3D <1>;
> > +			clocks =3D <&clks VF610_CLK_ENET_50M>;
> > +			clock-names =3D "rmii-ref";
> > +		};
> > +	};
> > +};
> > +
> > +&fec1 {
> > +	phy-mode =3D "rmii";
> > +	phy-handle =3D <&ethphy1>;
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_fec1>;
> > +	status =3D "okay";
> > +
> > +	mdio {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +		ethphy1: ethernet-phy@1 {
> > +			reg =3D <1>;
> > +			clocks =3D <&clks VF610_CLK_ENET_50M>;
> > +			clock-names =3D "rmii-ref";
> > +		};
> > +	};
> > +};
> > +
> > +&i2c2 {
> > +	clock-frequency =3D <400000>;
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_i2c2>;
> > +	status =3D "okay";
> > +
> > +	eeprom: eeprom@50 {
> > +		compatible =3D "at24,24c256";
> > +		reg =3D <0x50>;
> > +	};
> > +
> > +	rtc: rtc@68 {
> > +		compatible =3D "stm,rv4162";
> > +		reg =3D <0x68>;
> > +	};
> > +};
> > +
> > +&iomuxc { =20
>=20
> This node should go to the very end since it is so large..

I'm not sure - last time I've submitted DTS for imx6q board the
maintainer required to make it _all_ alphabetically sorted.

(I haven't heard about the rule to put some node to the end of file
because of its size).

>=20
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_bk4_common>;
> > +
> > +	pinctrl_bk4_common: commongrp { =20
>=20
> Are those pins all controlled from user space?=20

Yes, they are used by user space programs.

> If they are controlled
> by a particular kernel driver, you should add those pins to the
> pinctrl node assigned to the particular device tree node.

Yes, I'm aware of that.

>=20
> --
> Stefan
>=20
> > +		fsl,pins =3D <
> > +			/* One_Wire_PSU_EN */
> > +			VF610_PAD_PTC29__GPIO_102
> > 0x1183
> > +			/* SPI */
> > +			VF610_PAD_PTB26__GPIO_96
> > 0x1183
> > +			VF610_PAD_PTE14__GPIO_119
> > 0x1183
> > +			VF610_PAD_PTE4__GPIO_109
> > 0x1181
> > +			/* Feedback_Lines */
> > +			VF610_PAD_PTC31__GPIO_104
> > 0x1181
> > +			VF610_PAD_PTA7__GPIO_134
> > 0x1181
> > +			VF610_PAD_PTD9__GPIO_88
> > 0x1181
> > +			VF610_PAD_PTE1__GPIO_106
> > 0x1183
> > +			VF610_PAD_PTB2__GPIO_24
> > 0x1181
> > +			VF610_PAD_PTB3__GPIO_25
> > 0x1181
> > +			VF610_PAD_PTB1__GPIO_23
> > 0x1181
> > +			/* SDHC */
> > +			VF610_PAD_PTE19__GPIO_124
> > 0x1183
> > +			VF610_PAD_PTB23__GPIO_93
> > 0x1181
> > +			/* GPI */
> > +			VF610_PAD_PTE2__GPIO_107
> > 0x1181
> > +			VF610_PAD_PTE3__GPIO_108
> > 0x1181
> > +			VF610_PAD_PTE5__GPIO_110
> > 0x1181
> > +			VF610_PAD_PTE6__GPIO_111
> > 0x1181
> > +			/* GPO */
> > +			VF610_PAD_PTE0__GPIO_105
> > 0x1183
> > +			VF610_PAD_PTE7__GPIO_112
> > 0x1183
> > +			/* RS485 */
> > +			VF610_PAD_PTB8__GPIO_30
> > 0x1183
> > +			VF610_PAD_PTB9__GPIO_31
> > 0x1183
> > +			VF610_PAD_PTE8__GPIO_113
> > 0x1183
> > +			/* MPBUS MPB_EN */
> > +			VF610_PAD_PTE28__GPIO_133
> > 0x1183
> > +			/* LEDS */
> > +			VF610_PAD_PTE15__GPIO_120
> > 0x1183
> > +			VF610_PAD_PTA12__GPIO_5
> > 0x1183
> > +			VF610_PAD_PTA16__GPIO_6
> > 0x1183
> > +			VF610_PAD_PTE9__GPIO_114
> > 0x1183
> > +			VF610_PAD_PTE20__GPIO_125
> > 0x1183
> > +			VF610_PAD_PTE23__GPIO_128
> > 0x1183
> > +			VF610_PAD_PTE16__GPIO_121
> > 0x1183
> > +			/* MISC */
> > +			VF610_PAD_PTE10__GPIO_115
> > 0x1183
> > +			VF610_PAD_PTE11__GPIO_116
> > 0x1183
> > +			VF610_PAD_PTE17__GPIO_122
> > 0x1183
> > +			VF610_PAD_PTC30__GPIO_103
> > 0x1183
> > +			VF610_PAD_PTB0__GPIO_22
> > 0x1181
> > +			/* RESETINFO */
> > +			VF610_PAD_PTE26__GPIO_131
> > 0x1183
> > +			VF610_PAD_PTD6__GPIO_85
> > 0x1181
> > +			VF610_PAD_PTE27__GPIO_132
> > 0x1181
> > +			VF610_PAD_PTE13__GPIO_118
> > 0x1181
> > +			VF610_PAD_PTE21__GPIO_126
> > 0x1181
> > +			VF610_PAD_PTE22__GPIO_127
> > 0x1181
> > +			/* EE_5V_EN */
> > +			VF610_PAD_PTE18__GPIO_123
> > 0x1183
> > +			/* EE_5V_OC_N */
> > +			VF610_PAD_PTE25__GPIO_130
> > 0x1181
> > +		>;
> > +	};
> > +
> > +	pinctrl_can0: can0grp {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTB14__CAN0_RX
> > 0x1181
> > +			VF610_PAD_PTB15__CAN0_TX
> > 0x1182
> > +		>;
> > +	};
> > +
> > +	pinctrl_can1: can1grp {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTB16__CAN1_RX
> > 0x1181
> > +			VF610_PAD_PTB17__CAN1_TX
> > 0x1182
> > +		>;
> > +	};
> > +
> > +	pinctrl_dspi0: dspi0grp {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTB18__DSPI0_CS1
> > 0x1182
> > +			VF610_PAD_PTB19__DSPI0_CS0
> > 0x1182
> > +			VF610_PAD_PTB20__DSPI0_SIN
> > 0x1181
> > +			VF610_PAD_PTB21__DSPI0_SOUT
> > 0x1182
> > +			VF610_PAD_PTB22__DSPI0_SCK
> > 0x1182
> > +		>;
> > +	};
> > +
> > +	pinctrl_dspi3: dspi3grp {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTD10__DSPI3_CS0
> > 0x1181
> > +			VF610_PAD_PTD11__DSPI3_SIN
> > 0x1181
> > +			VF610_PAD_PTD12__DSPI3_SOUT
> > 0x1182
> > +			VF610_PAD_PTD13__DSPI3_SCK
> > 0x1181
> > +		>;
> > +	};
> > +
> > +	pinctrl_esdhc1: esdhc1grp {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTA24__ESDHC1_CLK
> > 0x31ef
> > +			VF610_PAD_PTA25__ESDHC1_CMD
> > 0x31ef
> > +
> > VF610_PAD_PTA26__ESDHC1_DAT0		0x31ef
> > +
> > VF610_PAD_PTA27__ESDHC1_DAT1		0x31ef
> > +
> > VF610_PAD_PTA28__ESDHC1_DATA2		0x31ef
> > +
> > VF610_PAD_PTA29__ESDHC1_DAT3		0x31ef
> > +			VF610_PAD_PTB28__GPIO_98
> > 0x219d
> > +		>;
> > +	};
> > +
> > +	pinctrl_fec0: fec0grp {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTA6__RMII_CLKIN
> > 0x30dd
> > +
> > VF610_PAD_PTC0__ENET_RMII0_MDC		0x30de
> > +			VF610_PAD_PTC1__ENET_RMII0_MDIO
> > 0x30df
> > +
> > VF610_PAD_PTC2__ENET_RMII0_CRS		0x30dd
> > +			VF610_PAD_PTC3__ENET_RMII0_RXD1
> > 0x30dd
> > +			VF610_PAD_PTC4__ENET_RMII0_RXD0
> > 0x30dd
> > +			VF610_PAD_PTC5__ENET_RMII0_RXER
> > 0x30dd
> > +			VF610_PAD_PTC6__ENET_RMII0_TXD1
> > 0x30de
> > +			VF610_PAD_PTC7__ENET_RMII0_TXD0
> > 0x30de
> > +			VF610_PAD_PTC8__ENET_RMII0_TXEN
> > 0x30de
> > +		>;
> > +	};
> > +
> > +	pinctrl_fec1: fec1grp {
> > +		fsl,pins =3D <
> > +
> > VF610_PAD_PTC9__ENET_RMII1_MDC		0x30de
> > +			VF610_PAD_PTC10__ENET_RMII1_MDIO
> > 0x30df
> > +			VF610_PAD_PTC11__ENET_RMII1_CRS
> > 0x30dd
> > +			VF610_PAD_PTC12__ENET_RMII1_RXD1
> > 0x30dd
> > +			VF610_PAD_PTC13__ENET_RMII1_RXD0
> > 0x30dd
> > +			VF610_PAD_PTC14__ENET_RMII1_RXER
> > 0x30dd
> > +			VF610_PAD_PTC15__ENET_RMII1_TXD1
> > 0x30de
> > +			VF610_PAD_PTC16__ENET_RMII1_TXD0
> > 0x30de
> > +			VF610_PAD_PTC17__ENET_RMII1_TXEN
> > 0x30de
> > +		>;
> > +	};
> > +
> > +	pinctrl_gpio_leds: gpio_leds {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTE12__GPIO_117	0x1183
> > +		>;
> > +	};
> > +
> > +	pinctrl_i2c2: i2c2grp {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTA22__I2C2_SCL
> > 0x34df
> > +			VF610_PAD_PTA23__I2C2_SDA
> > 0x34df
> > +		>;
> > +	};
> > +
> > +	pinctrl_nfc: nfcgrp {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTD23__NF_IO7
> > 0x28df
> > +			VF610_PAD_PTD22__NF_IO6
> > 0x28df
> > +			VF610_PAD_PTD21__NF_IO5
> > 0x28df
> > +			VF610_PAD_PTD20__NF_IO4
> > 0x28df
> > +			VF610_PAD_PTD19__NF_IO3
> > 0x28df
> > +			VF610_PAD_PTD18__NF_IO2
> > 0x28df
> > +			VF610_PAD_PTD17__NF_IO1
> > 0x28df
> > +			VF610_PAD_PTD16__NF_IO0
> > 0x28df
> > +			VF610_PAD_PTB24__NF_WE_B
> > 0x28c2
> > +			VF610_PAD_PTB25__NF_CE0_B
> > 0x28c2
> > +			VF610_PAD_PTB27__NF_RE_B
> > 0x28c2
> > +			VF610_PAD_PTC26__NF_RB_B
> > 0x283d
> > +			VF610_PAD_PTC27__NF_ALE
> > 0x28c2
> > +			VF610_PAD_PTC28__NF_CLE
> > 0x28c2
> > +		>;
> > +	};
> > +
> > +	pinctrl_uart0: uart0grp {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTB10__UART0_TX
> > 0x21a2
> > +			VF610_PAD_PTB11__UART0_RX
> > 0x21a1
> > +		>;
> > +	};
> > +
> > +	pinctrl_uart1: uart1grp {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTB4__UART1_TX
> > 0x21a2
> > +			VF610_PAD_PTB5__UART1_RX
> > 0x21a1
> > +		>;
> > +	};
> > +
> > +	pinctrl_uart2: uart2grp {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTB6__UART2_TX
> > 0x21a2
> > +			VF610_PAD_PTB7__UART2_RX
> > 0x21a1
> > +		>;
> > +	};
> > +
> > +	pinctrl_uart3: uart3grp {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTA20__UART3_TX
> > 0x21a2
> > +			VF610_PAD_PTA21__UART3_RX
> > 0x21a1
> > +		>;
> > +	};
> > +
> > +	pinctrl_qspi0: qspi0grp {
> > +		fsl,pins =3D <
> > +			VF610_PAD_PTD0__QSPI0_A_QSCK	0x397f
> > +			VF610_PAD_PTD1__QSPI0_A_CS0	0x397f
> > +			VF610_PAD_PTD2__QSPI0_A_DATA3	0x397f
> > +			VF610_PAD_PTD3__QSPI0_A_DATA2	0x397f
> > +			VF610_PAD_PTD4__QSPI0_A_DATA1	0x397f
> > +			VF610_PAD_PTD5__QSPI0_A_DATA0	0x397f
> > +			VF610_PAD_PTD7__QSPI0_B_QSCK	0x397f
> > +			VF610_PAD_PTD8__QSPI0_B_CS0	0x397f
> > +			VF610_PAD_PTD11__QSPI0_B_DATA1
> > 0x397f
> > +			VF610_PAD_PTD12__QSPI0_B_DATA0
> > 0x397f
> > +		>;
> > +	};
> > +};
> > +
> > +&nfc {
> > +	assigned-clocks =3D <&clks VF610_CLK_NFC>;
> > +	assigned-clock-rates =3D <33000000>;
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_nfc>;
> > +	status =3D "okay";
> > +
> > +	nand@0 {
> > +		compatible =3D "fsl,vf610-nfc-nandcs";
> > +		reg =3D <0>;
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		nand-bus-width =3D <16>;
> > +		nand-ecc-mode =3D "hw";
> > +		nand-ecc-strength =3D <24>;
> > +		nand-ecc-step-size =3D <2048>;
> > +		nand-on-flash-bbt;
> > +	};
> > +};
> > +
> > +&uart0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_uart0>;
> > +	status =3D "okay";
> > +};
> > +
> > +&uart1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_uart1>;
> > +	status =3D "okay";
> > +};
> > +
> > +&uart2 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_uart2>;
> > +	status =3D "okay";
> > +};
> > +
> > +&uart3 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_uart3>;
> > +	status =3D "okay";
> > +};
> > +
> > +&usbdev0 {
> > +	disable-over-current;
> > +	status =3D "okay";
> > +};
> > +
> > +&usbh1 {
> > +	disable-over-current;
> > +	status =3D "okay";
> > +};
> > +
> > +&usbmisc0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&usbmisc1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&usbphy0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&usbphy1 {
> > +	status =3D "okay";
> > +};
> > +
> > +&qspi0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_qspi0>;
> > +	status =3D "okay";
> > +
> > +	flash0: n25q128a13@0 {
> > +		compatible =3D "n25q128a13", "jedec,spi-nor";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		spi-max-frequency =3D <66000000>;
> > +		spi-rx-bus-width =3D <4>;
> > +		reg =3D <0>;
> > +	};
> > +
> > +	flash1: n25q128a13@1 {
> > +		compatible =3D "n25q128a13", "jedec,spi-nor";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		spi-max-frequency =3D <66000000>;
> > +		spi-rx-bus-width =3D <2>;
> > +		reg =3D <1>;
> > +	};
> > +}; =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/RO9tyBSd6zN.CCTtjTQef/2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlumOF8ACgkQAR8vZIA0
zr2bTAf5ARjIKc9zWwTXxZJ4VM/vZQ2oLtvfA+QPlA3/gkwvlNXITkNGz1sLugde
E1q1egLt4HkOb5KDCWNmuqN9LFPcMY/dvu9riLd2sahZBlf8fknd7EQN4ZUp5nWs
RaL9t+bH15mOX7qeiZ1xNRtDUMqGjnrDLO+jRaiyr7BuoEj1NMrE1JwenQyGH6Ee
TpUmjNbg4p0EnYm46ghimC5hsPjxuFKy/epulYWtpJa3fPc96RHrYV/nW84boLVH
Yn3WB2pAyXLSMJmLIZzC1nIGU/0u3VuyP9fYdKqABQc8OtL3am/OzV0xNwaftmlj
a5KGrCMOii+tG/ZzJ7BHGqBRnamh+g==
=Cn1L
-----END PGP SIGNATURE-----

--Sig_/RO9tyBSd6zN.CCTtjTQef/2--
