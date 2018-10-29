Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFAEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E792082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E792082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeJ3AKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:10:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38819 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbeJ3AKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:10:09 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8A3F3208BE; Mon, 29 Oct 2018 16:21:02 +0100 (CET)
Received: from localhost (unknown [185.94.189.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 40684208AF;
        Mon, 29 Oct 2018 16:20:52 +0100 (CET)
Date:   Mon, 29 Oct 2018 16:20:52 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] dts: sun8i-h3: Add DTS for Mapleboard MP130
Message-ID: <20181029152052.q75feg6ipsbysvfg@flea>
References: <20181025195519.hil6o66h4ev2m62q@earth.li>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yufxv5mqeyy3fj6l"
Content-Disposition: inline
In-Reply-To: <20181025195519.hil6o66h4ev2m62q@earth.li>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yufxv5mqeyy3fj6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thanks for your patch.

On Thu, Oct 25, 2018 at 08:55:19PM +0100, Jonathan McDowell wrote:
>=20
> The Mapleboard MP130 is a single board computer based on the Allwinner
> H3 SoC, with all schematics freely available. The Lite version includes
> 1GB main memory and 8GB eMMC.
>=20
> https://www.mapleboard.org/en (still mostly in Chinese even when English
> is selected)
>=20
> This DTS is based upon the DTS shipped with the board which uses
> mapleboard,mp130- prefixes instead of the allwinner,sun8i variants.
>=20
> Signed-off-by: Jonathan McDowell <noodles@earth.li>

The prefix of your patch should be "ARM: dts: sun8i-h3: ..."

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b5bd3de87c33..dcf1b9e7f71e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1035,6 +1035,7 @@ dtb-$(CONFIG_MACH_SUN8I) +=3D \
>  	sun8i-h3-bananapi-m2-plus.dtb \
>  	sun8i-h3-beelink-x2.dtb \
>  	sun8i-h3-libretech-all-h3-cc.dtb \
> +	sun8i-h3-mapleboard-mp130.dtb \
>  	sun8i-h3-nanopi-m1.dtb	\
>  	sun8i-h3-nanopi-m1-plus.dtb \
>  	sun8i-h3-nanopi-neo.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts b/arch/arm/b=
oot/dts/sun8i-h3-mapleboard-mp130.dts
> new file mode 100644
> index 000000000000..bf948128af94
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts
> @@ -0,0 +1,179 @@
> +/*
> + * Copyright (C) 2017 Centrum Embedded Systems, Jia-Bin Huang <jb@ces.co=
m.tw>
> + * Copyright (C) 2018 Jonathan McDowell <noodles@earth.li>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.

You should add a SPDX tag instead of the license.

We're also trying to license the DT under a dual GPL/MIT license,
since they can be used by projects under a license that is not the
GPL. But that's your call, obviously.

> + */
> +
> +/dts-v1/;
> +#include "sun8i-h3.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model =3D "MapleBoard MP130 Board";
> +	compatible =3D "mapleboard,mp130_board", "allwinner,sun8i-h3";

The "board" in both the model and compatible is redundant.

> +
> +	aliases {
> +		ethernet0 =3D &emac;
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&leds_pio>, <&leds_r_pio>;

You can drop those pinctrl nodes

> +		pwr_led {
> +			label =3D "mp130_board:orange:pwr";
> +			gpios =3D <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
> +			default-state =3D "on";
> +		};

A new line here would be nice

> +		status_led {
> +			label =3D "mp130_board:orange:status";
> +			gpios =3D <&pio 0 10 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	r_gpio_keys {
> +		compatible =3D "gpio-keys";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&sw_r_pio>;

Samething the pinctrl reference can be dropped

> +		power {
> +			label =3D "power";
> +			linux,code =3D <KEY_POWER>;
> +			gpios =3D <&r_pio 0 3 GPIO_ACTIVE_LOW>; /* PL3 */
> +		};
> +
> +		user {
> +			label =3D "user";
> +			linux,code =3D <BTN_0>;
> +			gpios =3D <&r_pio 0 4 GPIO_ACTIVE_LOW>;
> +		};

The labels should be under the form "board:color:function"

> +	};
> +};
> +
> +&codec {
> +	allwinner,audio-routing =3D
> +		"Line Out", "LINEOUT",
> +		"LINEIN", "Line In";
> +	status =3D "okay";
> +};
> +
> +&ehci1 {
> +	status =3D "okay";
> +};
> +
> +&ehci2 {
> +	status =3D "okay";
> +};
> +
> +&ehci3 {
> +	status =3D "okay";
> +};
> +
> +&ir {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&ir_pins_a>;
> +	status =3D "okay";
> +};
> +
> +&mmc0 {
> +	vmmc-supply =3D <&reg_vcc3v3>;
> +	bus-width =3D <4>;
> +	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
> +	cd-inverted;
> +	status =3D "okay";
> +};
> +
> +&mmc2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mmc2_8bit_pins>;
> +	vmmc-supply =3D <&reg_vcc3v3>;
> +	bus-width =3D <8>;
> +	non-removable;
> +	cap-mmc-hw-reset;
> +	status =3D "okay";
> +};
> +
> +&ohci1 {
> +	status =3D "okay";
> +};
> +
> +&ohci2 {
> +	status =3D "okay";
> +};
> +
> +&ohci3 {
> +	status =3D "okay";
> +};
> +
> +&pio {
> +	leds_pio: led_pins {
> +		pins =3D "PA15";
> +		function =3D "gpio_out";
> +	};
> +};
> +
> +&r_pio {
> +	leds_r_pio: led_pins {
> +		pins =3D "PL10";
> +		function =3D "gpio_out";
> +	};
> +
> +	sw_r_pio: key_pins {
> +		pins =3D "PL3", "PL4";
> +		function =3D "gpio_in";
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart0_pins_a>;
> +	status =3D "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart1_pins>;
> +	status =3D "disabled";
> +};
> +
> +&uart2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart2_pins>;
> +	status =3D "disabled";
> +};
> +
> +&uart3 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart3_pins>;
> +	status =3D "disabled";
> +};
> +
> +&usb_otg {
> +	dr_mode =3D "peripheral";
> +	status =3D "okay";
> +};
> +
> +&usbphy {
> +	/* USB VBUS is always on */
> +	status =3D "okay";
> +};
> +
> +&emac {
> +	phy-handle =3D <&int_mii_phy>;
> +	phy-mode =3D "mii";
> +	allwinner,leds-active-low;
> +	status =3D "okay";
> +};
> +

This should be ordered alphabetically

> J.
>=20
> --=20
> Revd Jonathan McDowell, ULC | Do you believe in happy endings?

Please don't send patches through your mailer. git send-email can be
configured to send the patches directly, this should be your preferred
option.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--yufxv5mqeyy3fj6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW9clVAAKCRDj7w1vZxhR
xYm1AQDXWuhJJmjONlnQFG7mcYuNZJf2rtFzpCXzxq/QMB7GOAEA8m3v7PxVjOM3
zZR1Ina5Cb65I6sjWephajNYkGuc6gg=
=ERbu
-----END PGP SIGNATURE-----

--yufxv5mqeyy3fj6l--
