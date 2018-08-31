Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D28C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3732083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3732083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeHaNxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:53:32 -0400
Received: from mout.perfora.net ([74.208.4.194]:54519 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbeHaNxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:53:32 -0400
Received: from localhost.localdomain ([89.217.215.226]) by mrelay.perfora.net
 (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LjKvJ-1fLmIL3mn9-00dKk6;
 Fri, 31 Aug 2018 11:46:31 +0200
Message-ID: <1535708786.8035.41.camel@ziswiler.com>
Subject: Re: [PATCH v3] ARM: dts: pxa: add mioa701 board description
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 31 Aug 2018 11:46:26 +0200
In-Reply-To: <20180830195941.6118-1-robert.jarzmik@free.fr>
References: <20180830195941.6118-1-robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vduGkDkO8OFoI/JVoyVcP6Tu1dMiML0Aix3CNcW5F4d9blPtYL5
 VEFM1B4mkxmPZspDctw06w+iT3kqAYfnzCA4DBbOCY4dXLbx5RbBboJnUb3Z+9yuv+jsVg0
 5VQHgx5nzewp0kgaO2rLRbIly5KkHEKvjIDqI48YQ7Pr/65QR8ZY6eGnaW/vQDQ5y0oCxqS
 BOyd/i58VgFY2OnjOd9VA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qrHaukgoAtI=:ddlq0HoOHFZyieGr+KKMmz
 U5N15ZJ5kotYBEJsDhYX3r2eyLopgUZ8lvkubAbGyvYWTAArv1OsHsY6q8tWpmKMDU0XO5R4y
 3qUelqX9SzznbkIo8rbtqMKPvTdeO7rDgyJdP8LgejAQvH3Lw9FjbCydat1CF8UFAGaFWVtXx
 U0WEzRN0frt2a7xQbostXfJ/4+c4dhWdKD0EAo4w4N1HM3gu9RlTEZEpnB+WL7ucWtiY4rMO2
 2edvPrMb22Bd15+IRpXcgYbMimeqG/ENT91etU9oBzK+F7FFKU60opfrnIu5wkRJL6JO3yAJg
 TWdz0r8K0Me0YTD8CmL1TwTsX9aUBpmS/r8fSDLuT8OF00taLibjmJK0D2CakbDRTjGkFbMPL
 2hAnYzl4HfmcPhHaJcpLPkd4MVxxfifha4F6WSJ3xjVfpNrXFq547H9MV1jnwhDo8P6CQQ9uR
 eIw9H8jax4tHHb0N6xIgzxPxs2RaxrVMNnRU9CtO3ZuQ8/0EXQe+3si/OyrOIsz/3+78AMYy/
 tKMcuofkwaF90tGKAv0+uSUTLnrEp4qqjFrbuvN8/3n5tAjz2SrXndy1guvBSHVTGd2N/PMBN
 inwFaUPCOgKmuFNiQBTGpD/Vnch75RfwUTVr3oBqA/v+SZwlZHFZ2W9CE0RHpcxglFi7G0OZT
 hzzRgSePtTcK0RNxbkrOt1Cfoeak8xy8uW2qi7ik8Tqr7PCM6t+IyIhGRhGD+2kY00x+5PVuj
 aZRdP1gTenShRkcZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert

On Thu, 2018-08-30 at 21:59 +0200, Robert Jarzmik wrote:
> Add device-tree description of the Mitac MIO A701 board.
> This is aimed at replacing mioa701.c board file, and once stabilized,
> the leftover, such as the suspend resume mechanics will rely on a new
> IPL, and not the legacy Windows CE one.

Cool, I did work on a Colibri PXA270 device tree off and on just never
came around submitting it. Yours is now definitely a good start!

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: fix lcd_supply and lcd_backlight
>           These were depending on my internal tree changes, fit it.
> Since v2: take into account Rob's comments
> 
> This patch deserves some special "love review". As it will probably
> serve for a more broad pxa conversion to devicetree of the other
> boards,
> and because it touches almost all domains for a pxa platform (camera,
> video, audio, i2c, ...), it should be as clean as possible so that
> mistakes are not carried on ...
> 
> Therefore I expect the review of this one to be long (ie. it won't
> land
> for v4.19), until it looks good enough.
> ---
>  arch/arm/boot/dts/Makefile    |   2 +
>  arch/arm/boot/dts/mioa701.dts | 558 

Isn't that one supposed to be prefixed by pxa270-?

> ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 560 insertions(+)
>  create mode 100644 arch/arm/boot/dts/mioa701.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b5bd3de87c33..8809f4e2244d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -775,6 +775,8 @@ dtb-$(CONFIG_ARCH_PRIMA2) += \
>  dtb-$(CONFIG_ARCH_OXNAS) += \
>  	ox810se-wd-mbwe.dtb \
>  	ox820-cloudengines-pogoplug-series-3.dtb
> +dtb-$(CONFIG_ARCH_PXA) += \

Wouldn't it rather make more sense to use CONFIG_MACH_PXA27X_DT
instead?

> +	mioa701.dtb
>  dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-apq8060-dragonboard.dtb \
>  	qcom-apq8064-arrow-sd-600eval.dtb \
> diff --git a/arch/arm/boot/dts/mioa701.dts
> b/arch/arm/boot/dts/mioa701.dts
> new file mode 100644
> index 000000000000..3791bc69e155
> --- /dev/null
> +++ b/arch/arm/boot/dts/mioa701.dts
> @@ -0,0 +1,558 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2018 Robert Jarzmik <robert.jarzmik@free.fr>
> + *
> + *  This program is free software; you can redistribute it and/or
> modify
> + *  it under the terms of the GNU General Public License version 2
> as
> + *  publishhed by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +#include "pxa27x.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/pxa-clock.h>
> +
> +/ {
> +	model = "Mitac Mio A701 Board";
> +	compatible = "marvell,pxa270";

Usually, there is also a compatible for the particular board e.g.
"mitac,mioa701", not? You might have to check on the vendor prefix
though.

> +	chosen {
> +		bootargs = "mtdparts=docg3.0:256k@3456k(barebox)ro,2
> 56k(barebox-logo),128k(barebox-env),4M(kernel),-(root) ubi.mtd=4
> rootfstype=ubifs root=ubi0:linux_root ro";
> +	};
> +
> +	memory {
> +		reg = <0xa0000000 0x04000000>;
> +
> +		reserved-memory {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			pstore_region:region@a2000000 {
> +				compatible = "linux,contiguous-
> memory-region";
> +				reg = <0xa2000000 0x100000>;
> +			};
> +		};
> +	};
> +
> +	cpus {
> +		cpu {
> +			cpu-supply = <&vcc_core>;
> +		};
> +	};
> +
> +	pxabus {
> +		pinctrl: pinctrl@40e00000 {
> +			status = "okay";
> +			pinctrl_ac97_default: ac97-default {
> +				PMMUX(hpjack-detect, 12, gpio_in);
> +				PMMUX(ac97-bitclk, 28, AC97_BITCLK);
> +				PMMUX(ac97-sdata-in-0, 29,
> AC97_SDATA_IN_0);
> +				PMMUX(ac97-sdata-out, 30,
> AC97_SDATA_OUT);
> +				PMMUX(ac97-sync, 31, AC97_SYNC);
> +				PMMUX(ac97-sysclk, 89, AC97_SYSCLK);
> +			};
> +			pinctrl_btuart_default: btuart-default {
> +				PMMUX(btuart-nactivity, 14,
> gpio_in);
> +				PMMUX(btuart-rxd, 42, BTRXD);
> +				PMMUX(btuart-txd, 43, BTTXD);
> +				PMMUX(btuart-cts, 44, BTCTS);
> +				PMMUX(btuart-rts, 45, BTRTS);
> +				PMMUX_LPM_LOW(bt-on, 83, gpio_out);
> +				PMMUX_LPM_HIGH(bt-unknown, 77,
> gpio_out);
> +				PMMUX_LPM_HIGH(bt-nreset, 86,
> gpio_out);
> +			};
> +			pinctrl_ffuart_default: ffuart-default {
> +				PMMUX(ffuart-rxd, 34, FFRXD);
> +				PMMUX(ffuart-cts, 35, FFCTS);
> +				PMMUX(ffuart-dcd, 36, FFDCD);
> +				PMMUX(ffuart-dsr, 37, FFDSR);
> +				PMMUX(ffuart-txd, 39, FFTXD);
> +				PMMUX(ffuart-dtr, 40, FFDTR);
> +				PMMUX(ffuart-rts, 41, FFRTS);
> +				PMMUX_LPM_LOW(gsm-reset, 24,
> gpio_out);
> +				PMMUX(gsm-is-on, 25, gpio_in);
> +				PMMUX_LPM_HIGH(gsm-nset-on, 88,
> gpio_out);
> +				PMMUX_LPM_HIGH(gsm-nset-off, 90,
> gpio_out);
> +				PMMUX(gsm-event-available, 113,
> gpio_in);
> +				PMMUX_LPM_HIGH(gsm-dte-state, 114,
> gpio_out);
> +			};
> +			pinctrl_gpiokeys_default: gpiokeys-default {
> +				PMMUX(key-power, 0, gpio_in);
> +				PMMUX(key-volume_up, 93, gpio_in);
> +				PMMUX(key-volume_down, 94, gpio_in);
> +			};
> +			pinctrl_keypad_default: keypad-default {
> +				PMMUX(keypad-mkin0, 100,
> KP_MKIN<0>);
> +				PMMUX(keypad-mkin1, 101,
> KP_MKIN<1>);
> +				PMMUX(keypad-mkin2, 102,
> KP_MKIN<2>);
> +				PMMUX(keypad-mkout0, 103,
> KP_MKOUT<0>);
> +				PMMUX(keypad-mkout1, 104,
> KP_MKOUT<1>);
> +				PMMUX(keypad-mkout2, 105,
> KP_MKOUT<2>);
> +			};
> +			pinctrl_i2c_default: i2c-default {
> +				PMMUX(i2c-scl, 117, SCL);
> +				PMMUX(i2c-sda, 118, SDA);
> +			};
> +			pinctrl_lcd_default: lcd-default {
> +				PMMUX(ldd0, 58, LDD<0>);
> +				PMMUX(ldd1, 59, LDD<1>);
> +				PMMUX(ldd2, 60, LDD<2>);
> +				PMMUX(ldd3, 61, LDD<3>);
> +				PMMUX(ldd4, 62, LDD<4>);
> +				PMMUX(ldd5, 63, LDD<5>);
> +				PMMUX(ldd6, 64, LDD<6>);
> +				PMMUX(ldd7, 65, LDD<7>);
> +				PMMUX(ldd8, 66, LDD<8>);
> +				PMMUX(ldd9, 67, LDD<9>);
> +				PMMUX(ldd10, 68, LDD<10>);
> +				PMMUX(ldd11, 69, LDD<11>);
> +				PMMUX(ldd12, 70, LDD<12>);
> +				PMMUX(ldd13, 71, LDD<13>);
> +				PMMUX(ldd14, 72, LDD<14>);
> +				PMMUX(ldd16, 73, LDD<15>);
> +				PMMUX(lcd-fclk, 74, L_FCLK_RD);
> +				PMMUX(lcd-lclk, 75, L_LCLK_A0);
> +				PMMUX(lcd-pclk, 76, L_PCLK_WR);
> +				PMMUX(lcd-power, 87, gpio_out);
> +			};
> +			pinctrl_leds_default: leds-default {
> +				PMMUX_LPM_HIGH(led-charging, 10,
> gpio_out);
> +				PMMUX_LPM_HIGH(led-vibra, 82,
> gpio_out);
> +				PMMUX_LPM_HIGH(led-blue, 97,
> gpio_out);
> +				PMMUX_LPM_HIGH(led-orange, 98,
> gpio_out);
> +				PMMUX_LPM_HIGH(led-keyboard, 115,
> gpio_out);
> +			};
> +			pinctrl_pwm0_default: pwm0-defaut {
> +				PMMUX(pwm0, 16, PWM_OUT<0>);
> +			};
> +			pinctrl_qci_default: qci-defaut {
> +				PMMUX(cif-dd6, 17, CIF_DD<6>);
> +				PMMUX(cif-dd3, 50, CIF_DD<3>);
> +				PMMUX(cif-dd2, 51, CIF_DD<2>);
> +				PMMUX(cif-dd4, 52, CIF_DD<4>);
> +				PMMUX(cif-mclk, 53, CIF_MCLK);
> +				PMMUX(cif-pclk, 54, CIF_PCLK);
> +				PMMUX_LPM_HIGH(mt9m111-nOE, 56,
> gpio_out);
> +				PMMUX(cif-dd1, 55, CIF_DD<1>);
> +				PMMUX(cif-dd0, 81, CIF_DD<0>);
> +				PMMUX(cif-dd5, 48, CIF_DD<5>);
> +				PMMUX(cif-fv, 84, CIF_FV);
> +				PMMUX(cif-lv, 85, CIF_LV);
> +				PMMUX(cif-dd7, 108, CIF_DD<7>);
> +			};
> +			pinctrl_mmc_default: mmc-default {
> +				PMMUX(sd-insert, 15, gpio_in);
> +				PMMUX(mmclk, 32, MMCLK);
> +				PMMUX(sd-ro, 78, gpio_in);
> +				PMMUX_LPM_LOW(sd-enable, 91,
> gpio_out);
> +				PMMUX(mmdat0, 92, MMDAT<0>);
> +				PMMUX(mmdat1, 109, MMDAT<1>);
> +				PMMUX(mmdat2, 110, MMDAT<2>);
> +				PMMUX(mmdat3, 111, MMDAT<3>);
> +				PMMUX(mmcmd, 112, MMCMD);
> +			};
> +			pinctrl_stuart_default: stuart-default {
> +				PMMUX_LPM_LOW(gps-unknown1, 23,
> gpio_out);
> +				PMMUX_LPM_LOW(gps-on, 26, gpio_out);
> +				PMMUX_LPM_LOW(gps-nreset, 27,
> gpio_out);
> +				PMMUX(stuart-rxd, 46, STRXD);
> +				PMMUX(stuart-txd, 47, STTXD);
> +				PMMUX_LPM_LOW(gps-unknown2, 106,
> gpio_out);
> +				PMMUX_LPM_LOW(gps-unknown3, 107,
> gpio_out);
> +			};
> +			pinctrl_usb_default: usb-default {
> +				PMMUX(n-usb-detect, 13, gpio_in);
> +				PMMUX_LPM_LOW(n-dplus-pullup, 22,
> gpio_out);
> +			};
> +			pinctrl_power_default: power-default {
> +				PMMUX_LPM_LOW(charge-enable, 9,
> gpio_out);
> +				PMMUX(charge-vdrop, 80, gpio_out);
> +				PMMUX(ac-detect, 96, gpio_in);
> +			};

I guess usually, one would add newlines in front and between those
pinctrls but its kind of a matter of taste.

> +		};
> +
> +		pwm0: pwm@40b00000 {
> +		      status = "okay";
> +		};
> +
> +		gpio: gpio@40e00000 {
> +			status = "okay";
> +		};
> +
> +		ffuart: serial@40100000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_ffuart_default>;
> +			status = "okay";
> +		};
> +
> +		btuart: serial@40200000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_btuart_default>;
> +			status = "okay";
> +		};
> +
> +		stuart: serial@40700000 {
> +			status = "okay";
> +		};

I believe pxa2xx.dtsi calls them uart rather than serial so unless you
plan to change this we will have to stick to using uart instead.

I also don't think those serial port labels buy us anything, so I would
get rid of them.

> +		usb2phy: gpio-vbus@13 {
> +			compatible = "usb-nop-xceiv";
> +			#phy-cells = <1>;
> +			vbus-detect-gpio = <&gpio 13
> GPIO_ACTIVE_LOW>;
> +			wakeup;
> +		};
> +
> +		pxa27x_udc: udc@40600000 {
> +			status = "okay";
> +			gpios = <&gpio 22 0>;
> +			phys = <&usb2phy>;
> +			phys-names = "usb2phy";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usb_default>;
> +		};

Same with that pxa27x_udc label.

> +		pwri2c: i2c@40f000180 {

Uups, I guess that address is wrong, not? I will send a patch to fix it
in pxa27x.dtsi as well.

> +			status = "okay";
> +
> +			core_regulator@14 {
> +				compatible = "maxim,max1586";
> +				reg = <0x14>;
> +				v3-gain = <1000000>;
> +
> +				regulators {
> +					vcc_core: v3 {
> +						regulator-name =
> "vcc_core";
> +						regulator-compatible 
> = "Output_V3";
> +						regulator-min-
> microvolt = <1000000>;
> +						regulator-max-
> microvolt = <1705000>;
> +						regulator-always-on;
> +					};
> +				};
> +			};

Haven't seen core_regulator before. Just regulator would do unless it
would be a more complex pmic.

> +		};

And the pwri2c.

> +		pxai2c1: i2c@40301680 {
> +			mrvl,i2c-fast-mode;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_i2c_default>;
> +			status = "okay";
> +
> +			mt9m111: camera@5d {
> +				compatible = "micron,mt9m111";
> +				reg = <0x5d>;
> +				gpios = <&gpio 56 GPIO_ACTIVE_HIGH>;
> +

Spurious newline.

> +				remote = <&pxa_camera>;

Missing newline.

> +				port {
> +					mt9m111_1: endpoint {
> +						bus-width = <8>;
> +						remote-endpoint =
> <&pxa_camera>;
> +					};
> +				};
> +			};
> +		};

Same with pxai2c1 and mt9m111.

> +		keypad: keypad@41500000 {
> +			status = "okay";
> +

Spurious newline.

> +			keypad,num-rows = <3>;
> +			keypad,num-columns = <3>;
> +			linux,keymap = <
> +				0x00000067	/* KEY_UP */
> +				0x0001006a	/* KEY_RIGHT */
> +				0x000200e2	/* KEY_MEDIA */
> +				0x0100006c	/* KEY_DOWN */
> +				0x0101001c	/* KEY_ENTER */
> +				0x010200da	/* KEY_CONNECT */
> +				0x02000069	/* KEY_LEFT */
> +				0x020100a9	/* KEY_PHONE */
> +				0x020200d4>;	/* KEY_CAMERA */
> +			marvell,debounce-interval = <0>;
> +

Spurious newline.

> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_keypad_default>;
> +		};

Same with keypad.

> +		gpio-keys {
> +			compatible = "gpio-keys";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			autorepeat;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_gpiokeys_default>;
> +			status = "okay";
> +
> +			power-button {
> +				label = "GPIO Key Power";
> +				linux,code = <174>;
> +				gpios = <&gpio 0 0>;
> +				gpio-key,wakeup;

I believe that got deprecated in favour of just wakeup-source.

> +			};

Missing newline.

> +			hp-jack-detect {
> +				label = "HP jack detect";
> +				linux,code = <211>;
> +				gpios = <&gpio 12 0>;
> +			};

Newline.

> +			volume-up {
> +				label = "Volume Up Key";
> +				linux,code = <115>;
> +				gpios = <&gpio 93 0>;
> +			};

Newline.

> +			volume-down {
> +				label = "Volume Down Key";
> +				linux,code = <114>;
> +				gpios = <&gpio 94 0>;
> +			};
> +		};
> +
> +		mmc0: mmc@41100000 {
> +			vmmc-supply = <&reg_vmmc>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_mmc_default>;
> +			bus-width = <4>;
> +			cd-gpios = <&gpio 15 0>;
> +			wp-gpios = <&gpio 78 0>;
> +			status = "okay";
> +		};

Another useless label being mmc0.

> +		pxa_camera: imaging@50000000 {
> +			status = "okay";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_qci_default>;
> +
> +			port {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* Parallel bus endpoint */
> +				qci: endpoint@0 {
> +					reg = <0>;
> +					remote-endpoint =
> <&mt9m111_1>;
> +					bus-width = <8>;
> +

Spurious newline.

> +					hsync-active = <0>;
> +					vsync-active = <0>;
> +					pclk-sample = <1>;
> +				};

And qci.

> +			};
> +		};
> +
> +		rtc@40900000 {
> +			status = "okay";
> +		};
> +
> +		lcd-controller@40500000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_lcd_default>;
> +			status = "okay";

Missing newline.

> +			port {
> +				lcdc_out: endpoint {
> +					remote-endpoint =
> <&panel_in>;
> +					bus-width = <16>;
> +				};
> +			};
> +		};
> +
> +		ac97: sound@40500000 {
> +			compatible = "marvell,pxa270-ac97";
> +			reg = < 0x40500000 0x1000 >;
> +			interrupts = <14>;
> +			reset-gpios = <&gpio 95 GPIO_ACTIVE_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = < &pinctrl_ac97_default >;
> +			clocks = <&clks CLK_AC97>, <&clks
> CLK_AC97CONF>;
> +			clock-names = "AC97CLK", "AC97CONFCLK";
> +			dmas = <&pdma 8 0
> +				&pdma 9 0
> +				&pdma 10 0
> +				&pdma 11 0
> +				&pdma 12 0>;
> +			dma-names = "pcm_pcm_mic_mono",
> "pcm_pcm_aux_mono_in",
> +				    "pcm_pcm_aux_mono_out",
> "pcm_pcm_stereo_in",
> +				    "pcm_pcm_stereo_out";
> +

Spurious newline.

> +			#sound-dai-cells = <0>;
> +

Spurious newline.

> +			#address-cells = <1>;
> +			#size-cells = <0>;

Missing newline.

> +			wm9713: audio-codec@0 {
> +				reg = <0>;
> +				compatible = "ac97,574d,4c13";
> +				clocks = <&wm9713_bitclk>;
> +				clock-names = "ac97_clk";
> +				#sound-dai-cells = <0>;
> +
> +				wm9713_bitclk: ac97_bitclk {
> +					compatible = "fixed-clock";
> +					#clock-cells = <0>;
> +					clock-frequency =
> <12285000>;
> +					status = "okay";
> +				};
> +			};

While a few device trees seem to use audio-codec just codec would work
too.

> +		};
> +
> +		pxa_pcm_audio: snd_soc_pxa_audio {
> +			compatible = "mrvl,pxa-pcm-audio";
> +			#sound-dai-cells = <0>;
> +			status = "okay";
> +		};

I believe node names should not contain underscores therefore suggest
chaning snd_soc_pxa_audio to snd-soc-pxa-audio.

> +		lcd-controller@40500000 {
> +			lcd-supply = <&lcd_vmmc>;
> +		};
> +
> +		docg3: flash@0 {
> +			compatible = "m-systems,diskonchip-g3";
> +			reg = <0x0 0x2000>;
> +		};
> +

Spurious newline.

> +	};
> +
> +	reg_vmmc: regulator@0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmmc";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +

Spurious newline.

> +		gpio = <&gpio 91 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};

I guess that @0 is a legacy from when we used a fake regulator simple
bus and nowadays regulator-vmmc is more common.

> +	lcd_vmmc: regulator@1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "lcd-supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +

Spurious newline.

> +		gpio = <&gpio 87 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};

Same for the @1 here and usually, for regulator labels the reg_ prefix
is used.

> +	lcd_backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm0 4096000>;
> +		pwm-names = "backlight";
> +

Newline.

> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <2>;
> +

Newline.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pwm0_default>;
> +	};
> +
> +	panel {
> +		compatible = "toshiba,ltm0305a776";
> +		lcd-type = "color-tft";
> +

Newline.

> +		backlight = <&lcd_backlight>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&lcdc_out>;
> +			};
> +		};
> +
> +		display-timings {
> +			native-mode = <&timing0>;
> +			timing0: 240p {
> +				/* 240x320p24 */
> +				clock-frequency = <4545000>;
> +				hactive = <240>;
> +				vactive = <320>;
> +				hfront-porch = <4>;
> +				hback-porch = <6>;
> +				hsync-len = <4>;
> +				vback-porch = <5>;
> +				vfront-porch = <3>;
> +				vsync-len = <2>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +

Newline.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_leds_default>;
> +
> +		charger-led {
> +			label = "mioa701:charging";
> +			gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +
> +		vibrator {
> +			label = "mioa701:vibra";
> +			gpios = <&gpio 82 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +
> +		bluetooth-led {
> +			label = "mioa701:blue";
> +			gpios = <&gpio 97 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +
> +		orange-led {
> +			label = "mioa701:orange";
> +			gpios = <&gpio 98 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +
> +		keyboard-led {
> +			label = "mioa701:keyboard";
> +			gpios = <&gpio 115 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "MioA701";
> +		simple-audio-card,widgets =
> +		"Speaker", "Front Speaker",
> +		"Speaker", "Rear Speaker",
> +		"Microphone", "Headset",
> +		"Microphone", "GSM Line Out",
> +		"Line", "GSM Line In",
> +		"Microphone", "Headset Mic",
> +		"Microphone", "Front Mic";
> +		simple-audio-card,routing =
> +			/* Call Mic */
> +			"Mic Bias", "Front Mic",
> +			"MIC1", "Mic Bias",
> +			/* Headset Mic */
> +			"LINEL", "Headset Mic",
> +			"LINER", "Headset Mic",
> +			/* GSM Module */
> +			"MONOIN", "GSM Line Out",
> +			"PCBEEP", "GSM Line Out",
> +			"GSM Line In", "MONO",
> +			/* headphone connected to HPL, HPR */
> +			"Headset", "HPL",
> +			"Headset", "HPR",
> +			/* front speaker connected to HPL, OUT3 */
> +			"Front Speaker", "HPL",
> +			"Front Speaker", "OUT3",
> +			/* rear speaker connected to SPKL, SPKR */
> +			"Rear Speaker", "SPKL",
> +			"Rear Speaker", "SPKR";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&ac97>;
> +		};

Missing newline.

> +		simple-audio-card,codec {
> +			sound-dai = <&wm9713>;
> +		};

Missing newline.

> +		simple-audio-card,plat {
> +			sound-dai = <&pxa_pcm_audio>;
> +		};
> +	};
> +
> +	ac_charger: charger {
> +		compatible = "gpio-charger";
> +		charger-type = "usb-aca";
> +		gpios = <&gpio 96 GPIO_ACTIVE_HIGH>;
> +	};
> +};

Cheers

Marcel
