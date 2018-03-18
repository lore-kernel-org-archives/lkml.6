Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754891AbeCRXuV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 19:50:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33593 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754537AbeCRXuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 19:50:18 -0400
X-Google-Smtp-Source: AG47ELuQ1T64/9SHidgUqyLF3oV4wJqS5OxeTuoJXDZ3F96dMDDGuAgcxgdJoGcYWj61Bq9uTOdSag==
Subject: Re: [PATCH v1 11/19] arm: dts: mt7623: use - instead of _ in DT node
 name
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <eb782e65f83246f0747ee21fbfb03ab13bddcc12.1519378872.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <4b7707b0-d2d5-7af2-216a-91015ad85173@gmail.com>
Date: Mon, 19 Mar 2018 00:50:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <eb782e65f83246f0747ee21fbfb03ab13bddcc12.1519378872.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/23/2018 11:16 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> It should be good that no use "_" is in DT node name. Consequently,
> those nodes in certain files which have an inappropriate name containing
> "_" are all being replaced with "-".
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org

Pushed to v4.16-next/dts32

Thanks!

> ---
>  arch/arm/boot/dts/mt7623.dtsi                 | 12 +++----
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 50 +++++++++++++--------------
>  arch/arm/boot/dts/mt7623n-rfb-nand.dts        |  6 ++--
>  3 files changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index 5cf93a4..4b68448 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -28,7 +28,7 @@
>  	compatible = "mediatek,mt7623";
>  	interrupt-parent = <&sysirq>;
>  
> -	cpu_opp_table: opp_table {
> +	cpu_opp_table: opp-table {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -145,32 +145,32 @@
>  	};
>  
>  	thermal-zones {
> -			cpu_thermal: cpu_thermal {
> +			cpu_thermal: cpu-thermal {
>  				polling-delay-passive = <1000>;
>  				polling-delay = <1000>;
>  
>  				thermal-sensors = <&thermal 0>;
>  
>  				trips {
> -					cpu_passive: cpu_passive {
> +					cpu_passive: cpu-passive {
>  						temperature = <47000>;
>  						hysteresis = <2000>;
>  						type = "passive";
>  					};
>  
> -					cpu_active: cpu_active {
> +					cpu_active: cpu-active {
>  						temperature = <67000>;
>  						hysteresis = <2000>;
>  						type = "active";
>  					};
>  
> -					cpu_hot: cpu_hot {
> +					cpu_hot: cpu-hot {
>  						temperature = <87000>;
>  						hysteresis = <2000>;
>  						type = "hot";
>  					};
>  
> -					cpu_crit {
> +					cpu-crit {
>  						temperature = <107000>;
>  						hysteresis = <2000>;
>  						type = "critical";
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index f2d3cfb..a6295ef 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -66,7 +66,7 @@
>  		regulator-always-on;
>  	};
>  
> -	gpio_keys {
> +	gpio-keys {
>  		compatible = "gpio-keys";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&key_pins_a>;
> @@ -263,14 +263,14 @@
>  
>  &pio {
>  	cir_pins_a:cir@0 {
> -		pins_cir {
> +		pins-cir {
>  			pinmux = <MT7623_PIN_46_IR_FUNC_IR>;
>  			bias-disable;
>  		};
>  	};
>  
>  	i2c0_pins_a: i2c@0 {
> -		pins_i2c0 {
> +		pins-i2c0 {
>  			pinmux = <MT7623_PIN_75_SDA0_FUNC_SDA0>,
>  				 <MT7623_PIN_76_SCL0_FUNC_SCL0>;
>  			bias-disable;
> @@ -278,7 +278,7 @@
>  	};
>  
>  	i2c1_pins_a: i2c@1 {
> -		pin_i2c1 {
> +		pin-i2c1 {
>  			pinmux = <MT7623_PIN_57_SDA1_FUNC_SDA1>,
>  				 <MT7623_PIN_58_SCL1_FUNC_SCL1>;
>  			bias-disable;
> @@ -286,7 +286,7 @@
>  	};
>  
>  	i2s0_pins_a: i2s@0 {
> -		pin_i2s0 {
> +		pin-i2s0 {
>  			pinmux = <MT7623_PIN_49_I2S0_DATA_FUNC_I2S0_DATA>,
>  				 <MT7623_PIN_72_I2S0_DATA_IN_FUNC_I2S0_DATA_IN>,
>  				 <MT7623_PIN_73_I2S0_LRCK_FUNC_I2S0_LRCK>,
> @@ -298,7 +298,7 @@
>  	};
>  
>  	i2s1_pins_a: i2s@1 {
> -		pin_i2s1 {
> +		pin-i2s1 {
>  			pinmux = <MT7623_PIN_33_I2S1_DATA_FUNC_I2S1_DATA>,
>  				 <MT7623_PIN_34_I2S1_DATA_IN_FUNC_I2S1_DATA_IN>,
>  				 <MT7623_PIN_35_I2S1_BCK_FUNC_I2S1_BCK>,
> @@ -310,7 +310,7 @@
>  	};
>  
>  	key_pins_a: keys@0 {
> -		pins_keys {
> +		pins-keys {
>  			pinmux = <MT7623_PIN_256_GPIO256_FUNC_GPIO256>,
>  				 <MT7623_PIN_257_GPIO257_FUNC_GPIO257> ;
>  			input-enable;
> @@ -318,7 +318,7 @@
>  	};
>  
>  	led_pins_a: leds@0 {
> -		pins_leds {
> +		pins-leds {
>  			pinmux = <MT7623_PIN_239_EXT_SDIO0_FUNC_GPIO239>,
>  				 <MT7623_PIN_240_EXT_XCS_FUNC_GPIO240>,
>  				 <MT7623_PIN_241_EXT_SCK_FUNC_GPIO241>;
> @@ -326,7 +326,7 @@
>  	};
>  
>  	mmc0_pins_default: mmc0default {
> -		pins_cmd_dat {
> +		pins-cmd-dat {
>  			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
>  				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_MSDC0_DAT6>,
>  				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_MSDC0_DAT5>,
> @@ -340,19 +340,19 @@
>  			bias-pull-up;
>  		};
>  
> -		pins_clk {
> +		pins-clk {
>  			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
>  			bias-pull-down;
>  		};
>  
> -		pins_rst {
> +		pins-rst {
>  			pinmux = <MT7623_PIN_115_MSDC0_RSTB_FUNC_MSDC0_RSTB>;
>  			bias-pull-up;
>  		};
>  	};
>  
>  	mmc0_pins_uhs: mmc0 {
> -		pins_cmd_dat {
> +		pins-cmd-dat {
>  			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_MSDC0_DAT7>,
>  				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_MSDC0_DAT6>,
>  				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_MSDC0_DAT5>,
> @@ -367,20 +367,20 @@
>  			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
>  		};
>  
> -		pins_clk {
> +		pins-clk {
>  			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_CLK>;
>  			drive-strength = <MTK_DRIVE_2mA>;
>  			bias-pull-down = <MTK_PUPD_SET_R1R0_01>;
>  		};
>  
> -		pins_rst {
> +		pins-rst {
>  			pinmux = <MT7623_PIN_115_MSDC0_RSTB_FUNC_MSDC0_RSTB>;
>  			bias-pull-up;
>  		};
>  	};
>  
>  	mmc1_pins_default: mmc1default {
> -		pins_cmd_dat {
> +		pins-cmd-dat {
>  			pinmux = <MT7623_PIN_107_MSDC1_DAT0_FUNC_MSDC1_DAT0>,
>  				 <MT7623_PIN_108_MSDC1_DAT1_FUNC_MSDC1_DAT1>,
>  				 <MT7623_PIN_109_MSDC1_DAT2_FUNC_MSDC1_DAT2>,
> @@ -391,26 +391,26 @@
>  			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
>  		};
>  
> -		pins_clk {
> +		pins-clk {
>  			pinmux = <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_CLK>;
>  			bias-pull-down;
>  			drive-strength = <MTK_DRIVE_4mA>;
>  		};
>  
> -		pins_wp {
> +		pins-wp {
>  			pinmux = <MT7623_PIN_29_EINT7_FUNC_MSDC1_WP>;
>  			input-enable;
>  			bias-pull-up;
>  		};
>  
> -		pins_insert {
> +		pins-insert {
>  			pinmux = <MT7623_PIN_261_MSDC1_INS_FUNC_GPIO261>;
>  			bias-pull-up;
>  		};
>  	};
>  
>  	mmc1_pins_uhs: mmc1 {
> -		pins_cmd_dat {
> +		pins-cmd-dat {
>  			pinmux = <MT7623_PIN_107_MSDC1_DAT0_FUNC_MSDC1_DAT0>,
>  				 <MT7623_PIN_108_MSDC1_DAT1_FUNC_MSDC1_DAT1>,
>  				 <MT7623_PIN_109_MSDC1_DAT2_FUNC_MSDC1_DAT2>,
> @@ -421,7 +421,7 @@
>  			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
>  		};
>  
> -		pins_clk {
> +		pins-clk {
>  			pinmux = <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_CLK>;
>  			drive-strength = <MTK_DRIVE_4mA>;
>  			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> @@ -437,7 +437,7 @@
>  	};
>  
>  	pwm_pins_a: pwm@0 {
> -		pins_pwm {
> +		pins-pwm {
>  			pinmux = <MT7623_PIN_203_PWM0_FUNC_PWM0>,
>  				 <MT7623_PIN_204_PWM1_FUNC_PWM1>,
>  				 <MT7623_PIN_205_PWM2_FUNC_PWM2>,
> @@ -447,7 +447,7 @@
>  	};
>  
>  	spi0_pins_a: spi@0 {
> -		pins_spi {
> +		pins-spi {
>  			pinmux = <MT7623_PIN_53_SPI0_CSN_FUNC_SPI0_CS>,
>  				<MT7623_PIN_54_SPI0_CK_FUNC_SPI0_CK>,
>  				<MT7623_PIN_55_SPI0_MI_FUNC_SPI0_MI>,
> @@ -457,21 +457,21 @@
>  	};
>  
>  	uart0_pins_a: uart@0 {
> -		pins_dat {
> +		pins-dat {
>  			pinmux = <MT7623_PIN_79_URXD0_FUNC_URXD0>,
>  				 <MT7623_PIN_80_UTXD0_FUNC_UTXD0>;
>  		};
>  	};
>  
>  	uart1_pins_a: uart@1 {
> -		pins_dat {
> +		pins-dat {
>  			pinmux = <MT7623_PIN_81_URXD1_FUNC_URXD1>,
>  				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
>  		};
>  	};
>  
>  	uart2_pins_a: uart@2 {
> -		pins_dat {
> +		pins-dat {
>  			pinmux = <MT7623_PIN_14_GPIO14_FUNC_URXD2>,
>  				 <MT7623_PIN_15_GPIO15_FUNC_UTXD2>;
>  		};
> diff --git a/arch/arm/boot/dts/mt7623n-rfb-nand.dts b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
> index e66de86..f729c71 100644
> --- a/arch/arm/boot/dts/mt7623n-rfb-nand.dts
> +++ b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
> @@ -81,13 +81,13 @@
>  
>  &pio {
>  	nand_pins_default: nanddefault {
> -		pins_ale {
> +		pins-ale {
>  			pinmux = <MT7623_PIN_116_MSDC0_CMD_FUNC_NALE>;
>  			drive-strength = <MTK_DRIVE_8mA>;
>  			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>  		};
>  
> -		pins_dat {
> +		pins-dat {
>  			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_NLD7>,
>  				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_NLD6>,
>  				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_NLD4>,
> @@ -102,7 +102,7 @@
>  			bias-pull-up;
>  		};
>  
> -		pins_we {
> +		pins-we {
>  			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_NWEB>;
>  			drive-strength = <MTK_DRIVE_8mA>;
>  			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
> 
