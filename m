Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932957AbeDXIcQ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:32:16 -0400
Received: from mail3.emtrion.de ([80.150.99.69]:39122 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932837AbeDXIcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:32:12 -0400
From: =?iso-8859-1?Q?T=FCrk=2C_Jan?= <Jan.Tuerk@emtrion.de>
To: "'Shawn Guo'" <shawnguo@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LinuxArmKernelMailingListe <linux-arm-kernel@lists.infradead.org>
Date: Tue, 24 Apr 2018 10:32:07 +0200
Subject: AW: [PATCH v3 5/6] ARM: dts: Add support for emtrion emCON-MX6
 series
Thread-Topic: [PATCH v3 5/6] ARM: dts: Add support for emtrion emCON-MX6
 series
Thread-Index: AdPa3342RWfgG+uDSo6dKcsBBd8LYAACQERQ
Message-ID: <95F51F4B902CAC40AF459205F6322F01B83109E5B1@BMK019S01.emtrion.local>
References: <20171220134710.64479-2-jan.tuerk@emtrion.com>
 <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180420125108.14197-6-jan.tuerk@emtrion.com>
 <20180423084454.GZ25429@dragon>
In-Reply-To: <20180423084454.GZ25429@dragon>
Accept-Language: de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: de-DE
x-tm-as-product-ver: SMEX-11.0.0.4283-8.100.1062-23802.006
x-tm-as-result: No--19.065300-8.000000-31
x-tm-as-matchedid: 701625-704425-700685-853813-139010-705386-853802-710556-7
        04421-700075-110462-701762-186035-705753-704713-701433-700752-702609-700918
        -707788-700016-704410-708855-707410-701236-704636-702762-701016-703529-1880
        19-700324-121336-703969-188198-843086-701040-700264-106230-700624-121504-71
        1664-705167-701482-700901-703454-700869-703707-701837-703378-707570-709584-
        704195-702900-708797-853541-105640-705468-712124-704496-702126-709009-70871
        2-710207-702311-702898-700019-702747-702807-705567-186003-702106-704307-701
        350-709185-700735-701698-703523-106420-148004-148133-20043-29997-42000-4200
        3-63
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Ursprüngliche Nachricht-----
> Von: Shawn Guo Gesendet: Montag, 23. April 2018 10:45
> Re: [PATCH v3 5/6] ARM: dts: Add support for emtrion emCON-MX6 series
> 
> On Fri, Apr 20, 2018 at 02:50:52PM +0200, jan.tuerk@emtrion.com wrote:
> > From: Jan Tuerk <jan.tuerk@emtrion.com>
> >
> > This patch adds support for the emtrion GmbH emCON-MX6 modules.
> > They are available with imx.6 Solo, Dual-Lite, Dual and Quad equipped
> > with Memory from 512MB to 2GB (configured by U-Boot).
> >
> > Our default developer-Kit ships with the Avari baseboard and the EDT
> > ETM0700G0BDH6 Display (imx6[q|dl]-emcon-avari).
> >
> > The devicetree is split into the common part providing all module
> > components and the basic support for all SoC versions
> > (imx6qdl-emcon.dtsi) and parts which are i.mx6 S|DL and D|Q relevant.
> > Finally the support for the avari baseboard in the developer-kit
> > configuration is provided by the emcon-avari dts files.
> >
> > Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
> > ---
> >  Documentation/devicetree/bindings/arm/emtrion.txt |  13 +
> 
> It's better to have a separate patch for bindings doc, which needs to be
> acknowledged by DT maintainers.

I can change that, but nobody complained in the first 2 revisions of the patch. 
Also I though having the documentation is required for merging new bindings?

> 
> >  arch/arm/boot/dts/Makefile                        |   2 +
> >  arch/arm/boot/dts/imx6dl-emcon-avari.dts          | 224 ++++++
> >  arch/arm/boot/dts/imx6dl-emcon.dtsi               |  27 +
> >  arch/arm/boot/dts/imx6q-emcon-avari.dts           | 224 ++++++
> >  arch/arm/boot/dts/imx6q-emcon.dtsi                |  27 +
> >  arch/arm/boot/dts/imx6qdl-emcon.dtsi              | 838
> ++++++++++++++++++++++
> >  7 files changed, 1355 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt
> >  create mode 100644 arch/arm/boot/dts/imx6dl-emcon-avari.dts
> >  create mode 100644 arch/arm/boot/dts/imx6dl-emcon.dtsi
> >  create mode 100644 arch/arm/boot/dts/imx6q-emcon-avari.dts
> >  create mode 100644 arch/arm/boot/dts/imx6q-emcon.dtsi
> >  create mode 100644 arch/arm/boot/dts/imx6qdl-emcon.dtsi
> >
> > diff --git a/Documentation/devicetree/bindings/arm/emtrion.txt
> > b/Documentation/devicetree/bindings/arm/emtrion.txt
> > new file mode 100644
> > index 000000000000..3ff6c6c2034d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/emtrion.txt
> > @@ -0,0 +1,13 @@
> > +Emtrion Devicetree Bindings
> > +===========================
> > +
> > +emCON Series:
[..]
> > index 000000000000..2344fb9498e3
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6dl-emcon-avari.dts
> > @@ -0,0 +1,224 @@
> > +// SPDX-License-Identifier: (GPL-2.0 or MIT)
> > +/* Copyright (C) 2018 emtrion GmbH
> > + * Author: Jan Tuerk  <jan.tuerk@emtrion.com>  */
> 
> /*
>  * Copyright ...
>  */
Ack
> > +
> > +/dts-v1/;
> > +#include "imx6dl.dtsi"
> > +#include "imx6qdl-emcon.dtsi"
> > +#include "imx6dl-emcon.dtsi" /*Include camera2 pinmux*/
> 
> /* bla bla */
> 
> > +
> > +/ {
> > +	model = "emtrion SoM emCON-MX6 Solo/Dual-Lite Avari";
> > +	compatible = "emtrion,emcon-mx6-avari", "fsl,imx6dl";
> > +
> > +	aliases {
> > +		mmc0 = &usdhc3;
> > +		mmc2 = &usdhc1;
> > +		mmc1 = &usdhc2;
> > +		mmc3 = &usdhc4;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = <&uart1>;
> > +	};
> > +
> > +	memory {
> 
> The unit-address is missing.

Ack

> 
> > +		reg = <0x10000000 0x40000000>;
> > +	};
> > +
> > +	supplies {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> 
> DT maintainers do not like this fake container node.  Please put the
> fixed regulator nodes directly under root with a unique name like below.

Ok I'll change this
> 
> 	reg_xxx: regulator-xxx {
> 		...
> 	};
> 
> > +
> > +		wallplug5p0: supply@0 {
> > +			compatible = "regulator-fixed";
> > +			reg = <0>;
> > +			regulator-name = "WALL-PLUG";
> > +			regulator-min-microvolt = <5000000>;
> > +			regulator-max-microvolt = <5000000>;
> > +			regulator-always-on;
> > +			regulator-boot-on;
> > +		};
[...]
> > +		reg_usb_otg: otgvbus@3 {
> > +			compatible = "regulator-fixed";
> > +			reg = <3>;
> > +			vin-supply = <&wallplug5p0>;
> > +			regulator-name = "OTG_VBUS";
> > +			regulator-min-microvolt = <5000000>;
> > +			regulator-max-microvolt = <5000000>;
> > +			gpio = <&gpio1 8 GPIO_ACTIVE_LOW>;
> > +			regulator-always-on;
> > +		};
> > +
> > +	};
> > +
> > +
> > +	sndosc: 12MHZosc {
> 
> 	clock-xxx {
> 		...
> 	};

ok
> 
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency  = <12000000>;
> > +	};
> > +
> > +	sound {
> > +		compatible = "fsl,imx-audio-sgtl5000";
> > +		model = "emCON-avari-sgtl5000";
> > +		ssi-controller = <&ssi2>;
> > +		audio-codec = <&sgtl5000>;
> > +		audio-routing =
> > +			"Headphone Jack", "HP_OUT";
> > +		mux-int-port = <2>;
> > +		mux-ext-port = <3>;
> > +	};
> > +
> > +};
> > +
> > +
> 
> One newline is good enough.
ack
> 
> > +&iomuxc {
> > +	pinctrl-names = "default";
> > +	/*Unused emCON-MX6 outputs on AVARI*/
> > +	pinctrl-0 = <
> > +				 &pinctrl_emcon_gpio1
> &pinctrl_emcon_gpio2
> > +				 &pinctrl_emcon_gpio3
> &pinctrl_emcon_gpio5
> > +				 &pinctrl_emcon_gpio6
> &pinctrl_emcon_gpio7
> > +				 &pinctrl_emcon_gpio8
> &pinctrl_emcon_irq_a
> > +				 &pinctrl_emcon_irq_b &pinctrl_emcon_irq_c
> > +				 &pinctrl_emcon_irq_pwr &pinctrl_nor_flash
> > +				 &pinctrl_usdhc2
> > +				 &pinctrl_spdif_out     &pinctrl_spdif_in
> > +				 &pinctrl_cpi1          &pinctrl_cpi2
> > +				>;
> 
> Only pins without clear consumer should be put into hog group.  Also the
> indent seems broken.

Yes the consumer is currently "not-defined" on the Avari baseboard, as those pins are signals on the emCON Interface.
I've added them there to force a basic initialization matching the Interfaces specified function blocks in the SoC.  
I'll rework the indent as well.

> 
> > +};
> > +
> > +&audmux {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_audmux>;
> > +	status = "okay";
> > +};
> > +
> > +
> > +
> 
> One newline is good enough.  Also, please try to sort these labelled
> nodes alphabetically.
> 
> > +&i2c3 {
> > +	clock-frequency = <100000>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c3>;
> > +	status = "okay";
> > +
> > +	sgtl5000: audio-codec@a {
> > +		compatible = "fsl,sgtl5000";
> > +		reg = <0x0a>;
> > +		clocks = <&sndosc>;
> > +		VDDA-supply = <&base3p3>;
> > +		VDDIO-supply = <&base3p3>;
> 
> #sound-dai-cells is missing.
yes, I'll change that
> 
> > +	};
> > +
> > +	boardID: pca8754a@3a {
> 
> Please find a more generic node name for it.

you mean boardID@3a?
This chip identifies the baseboard type for the bootloader.

> 
> > +		compatible = "nxp,pca8574";
> > +		reg = <0x3a>;
> > +		gpio-controller;
> > +		#gpio-cells = <1>;
> > +	};
> > +
> > +	captouch: touchscreen@38 {
> > +		compatible = "edt,edt-ft5406";
> > +		reg = <0x38>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_irq_touch2 &pinctrl_emcon_gpio4>;
> > +		interrupt-parent = <&gpio6>;
> > +		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
> > +		wake-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
> > +		wakeup-source;
> > +		status = "okay";
> 
> The "okay" status is only needed to flip the default "disabled" device.
> 
> > +	};
[...]
> +};
> diff --git a/arch/arm/boot/dts/imx6q-emcon-avari.dts b/arch/arm/boot/dts/imx6q-emcon-avari.dts
> new file mode 100644
> index 000000000000..0c85b5ee011c
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-emcon-avari.dts
There are so many things duplicated between imx6dl-emcon-avari.dts and
imx6q-emcon-avari.dts.  Can you do something to avoid that?

I could try to merge them into a "common", but it will be an additional file.

> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: (GPL-2.0 or MIT)
> +/* Copyright (C) 2018 emtrion GmbH
> + * Author: Jan Tuerk  <jan.tuerk@emtrion.com>
> + */
> +
> +/dts-v1/;
> +#include "imx6q.dtsi"
> +#include "imx6qdl-emcon.dtsi"
> +#include "imx6q-emcon.dtsi" /*Include camera2 pinmux*/
> +
> +/ {
> +	model = "emtrion SoM emCON-MX6 Dual/Quad on Avari";
> +	compatible = "emtrion,emcon-mx6-avari", "fsl,imx6q";
> +
> +	aliases {
> +		mmc0 = &usdhc3;
> +		mmc2 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		mmc3 = &usdhc4;
> +	};
[...]
> > +};
> > +
> > +&ssi2 {
> > +	pwm_fan: pwm-fan {
> > +		compatible = "pwm-fan";
> > +		cooling-min-state = <0>;
> > +		cooling-max-state = <4>;
> > +		#cooling-cells = <2>;
> > +		pwms = <&pwm4 0 50000>;
> > +		cooling-levels = <0 64 127 191 255>;
> > +		status = "disabled";
> > +	};
> > +
> > +	rgb_encoder: disp0 {
> 
> s/disp0/display
Ack

> 
> > +		compatible = "fsl,imx-parallel-display";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_rgb24_display>;
> > +		status = "disabled";
> > +
> > +		port@0 {
> > +			reg = <0>;
> 
> Have a newline between property list and child node.
Ok
> 
> > +			rgb_encoder_in: endpoint {
> > +				remote-endpoint = <&ipu1_di0_disp0>;
> > +			};
> > +		};
> > +
> > +		port@1 {
> > +			reg = <1>;
> > +			rgb_encoder_out: endpoint {
> > +				remote-endpoint = <&rgb_panel_in>;
> > +			};
> > +		};
> > +	};
> > +
> > +	rgb_panel: panel {
> > +		backlight = <&rgb_backlight>;
> > +		power-supply = <&reg_parallel_disp>;
> > +		port {
> > +			rgb_panel_in: endpoint {
> > +				remote-endpoint = <&rgb_encoder_out>;
> > +			};
> > +		};
> > +	};
> > +
> > +	rgb_backlight: rgb-backlight {
> > +		compatible = "pwm-backlight";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_rgb_bl>;
> > +		enable-gpios = <&gpio6 8 GPIO_ACTIVE_HIGH>;
> > +		pwms = <&pwm3 0 5000000>;
> > +		brightness-levels = <250 176 160 144 128 112
> > +							96 80 64 48 32 16 8 1
> > +							>;
> 
> Broken indent.
ack
> 
> > +		default-brightness-level = <13>;
> > +		status = "okay";
> > +	};
> > +
> > +	lvds_backlight: lvds-backlight {
> > +		compatible = "pwm-backlight";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_lvds_bl>;
> > +		enable-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>;
> > +		pwms = <&pwm1 0 50000>;
> > +		brightness-levels = <0 4 8 16 32 64 80 96 112
> > +							128 144 160 176 250
> > +							>;
> > +		default-brightness-level = <13>;
> > +		status = "okay";
> > +	};
> > +};
> > +
> > +
> > +&iomuxc {
> > +
> > +	pinctrl_secure: securegrp {
> 
> Unused?

in this configuration, yes. 
The imx6qdl-emcon.dtsi defines all pinctrl values for the Interfaces defined in the emCON specification.

> 
> > +		fsl,pins = <
> > +			MX6QDL_PAD_GPIO_18__GPIO7_IO13
> 		0x1b0b1
> > +		>;
> > +	};
> > +
> > +	pinctrl_uart1: uart1grp {
> > +		fsl,pins = <
> > +			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA
> 	0x1b0b1
> > +			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA
> 	0x1b0b1
> > +		>;
> > +	};
> > +
[...]
> > +
> > +	pinctrl_uart5: uart5grp {
> > +		fsl,pins = <
> > +			MX6QDL_PAD_KEY_COL1__UART5_TX_DATA
> 	0x1b0b1
> > +			MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA
> 	0x1b0b1
> > +		>;
> > +	};
> > +
> > +	pinctrl_emcon_gpio1: emcongpio1 {
> > +		fsl,pins = <
> > +			MX6QDL_PAD_NANDF_D0__GPIO2_IO00
> 		0x0b0b1
> > +		>;
> > +	};
> 
> Try to keep these pinctrl entries alphabetically sorted.
If this helps to merge it, I'll change that
> 
> > +
> > +	pinctrl_emcon_gpio2: emcongpio2 {
> > +		fsl,pins = <
> > +			MX6QDL_PAD_NANDF_D1__GPIO2_IO01
> 		0x0b0b1
> > +		>;
> > +	};
> > +
[...]
> > +
> > +		wdt {
> 
> s/wdt/watchdog
Ack.

> 
> > +			compatible = "dlg,da9063-watchdog";
> > +			timeout-sec = <0>;
> > +		};
> > +
> > +		regulators {
> > +			vddcore_reg: bcore1 {
> > +				regulator-min-microvolt = <1100000>;
> > +
[...]
> > +/*******Disabled HW following***********/
> > +
> > +
> > +&weim {
> > +	status = "disabled";
> > +};
> 
> Isn't weim disabled by default?

Yes, the patch was originally done for our internal "vendor" kernel, which was based on 4.9 where it was enabled by default.
I remove the node, as it became obsolete now.
> 
> Shawn
> 
> > +
> > +&snvs_rtc {
> > +	status = "disabled";
> > +};
> > --
> > 2.11.0
> >
