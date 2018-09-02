Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DDEC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62E520841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62E520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeIBOZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:47 -0400
Received: from mout.perfora.net ([74.208.4.197]:58329 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbeIBOZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:46 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MPWlD-1g0Vvs2NeL-004psQ; Sun, 02 Sep 2018 12:10:26 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 37/37] ARM: tegra: colibri_t20: add eval board device tree
Date:   Sun,  2 Sep 2018 12:09:06 +0200
Message-Id: <20180902100906.25792-38-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:HSaynXc4c7N2dJXOTSPkvEDpeulXXekQjlPFT5EJiZ97D2RhdZ1
 DTrgF3oIF2qr7R16KKZ9TYAKuI/muHtZg6g+3EnDKfQOn3L7vISqOMv8B48qwoht43NM3E0
 cHk5Hq+Yz39oNQFS7b0aJcMszyK6cSGpIRbb3OcTKpfr/7PBGStCaaStHGwSjU6N2vZtAks
 8DCFLnvvPpw2er4F8czaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y/76/p8ZRtk=:ZbtMgIxWyLT33GG1uw1PeM
 mFSjnvYh0dq2uRCsuJ9KjxDaJRQEEzgZclAhmZkOud1eTgJUd4kd7gYNCMiGTN9gTQI2LEwpZ
 mS1Fv/x0EG7CI9vPDmZRFXFOeYfjEIyCvEDQvLZYpyQnA6+Zz+GM5mrl2WrOr+5M1r5gNEflk
 4z+ZNB8OR0xbmMKLKvbVSZy/f5DAD8JY5i0XFaLpGoD/ZNU/ftG32/7aYCh3EEyk1FtdL2oRf
 aeFL3rkcp+kM/dn9ryB0+M3nLxhJmje1OhI/xDp59p23xKYiR/68GrheOHMjsA2stVO6hoYNy
 FNCMV5zeBNZGbJIUCMk5YrhaELS+7zzXXWCCBBbSd27NWG5z9lJ1nIonmSaHntwxKCbtsQ0gq
 kZvMTqztVgTL2XGNqQMJ264lAgrQ6T/I0Tnej63iDzM7yt+5uC3O+MTRzc2/t2gHHWQg18PVQ
 nF2MsiJr/qWKYViPOcZPr9mLi/1UYQR/KTuycBokJbiJ5tHee+iFRCexGxJwZ7khcQCNOl8CC
 GX9c3yQQ87WL1Yra3irQRA9RN3ejN97jpxRmHD7aJXUxuICxlwHWiJ4rZL3sHju9vTEKJuy9y
 yYslrt8aBStsvt7Coj7wQOUyXMB4xxDzaaNi30kTDV0vzRqIJX0O4DSSvhs/v+x/SjJxCLUbP
 /z7tKPEuTZBJ5DP7IF1aRUGMH+Iq3ylySdlfI++mIYq6SXCsWrjd/mBEuQ5c5/1j93a4Qz315
 rVQgEpYnoxrG2t+HsY8HzbBIyQ0h1wqfVaiEt7U0dcYwDX3KfI9BB6YTxh8+Hxaswub5CFvUp
 nsU187l
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add an evaluation board device tree more in-line with all our other
device trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Updated evaluation board device tree with all applicable previous
  fixes.
- Also reflect this addition in the device tree bindings documentation.

 Documentation/devicetree/bindings/arm/tegra.txt |   1 +
 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts   | 262 ++++++++++++++++++++++++
 3 files changed, 264 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts

diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
index 0909122a2bee..c59b15f64346 100644
--- a/Documentation/devicetree/bindings/arm/tegra.txt
+++ b/Documentation/devicetree/bindings/arm/tegra.txt
@@ -54,6 +54,7 @@ board-specific compatible values:
   toradex,apalis-tk1-v1.2
   toradex,apalis-tk1-v1.2-eval
   toradex,colibri_t20
+  toradex,colibri_t20-eval-v3
   toradex,colibri_t20-iris
   toradex,colibri_t30
   toradex,colibri_t30-eval-v3
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f67a87c66e9e..34f5b0135efd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1062,6 +1062,7 @@ dtb-$(CONFIG_ARCH_TANGO) += \
 	tango4-vantage-1172.dtb
 dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
 	tegra20-harmony.dtb \
+	tegra20-colibri-eval-v3.dtb \
 	tegra20-colibri-iris.dtb \
 	tegra20-medcom-wide.dtb \
 	tegra20-paz00.dtb \
diff --git a/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
new file mode 100644
index 000000000000..3c0f2681fcde
--- /dev/null
+++ b/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "tegra20-colibri.dtsi"
+
+/ {
+	model = "Toradex Colibri T20 on Colibri Evaluation Board";
+	compatible = "toradex,colibri_t20-eval-v3", "toradex,colibri_t20",
+		     "nvidia,tegra20";
+
+	aliases {
+		rtc0 = "/i2c@7000c000/rtc@68";
+		rtc1 = "/i2c@7000d000/pmic@34";
+		rtc2 = "/rtc@7000e000";
+		serial0 = &uarta;
+		serial1 = &uartd;
+		serial2 = &uartb;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	host1x@50000000 {
+		dc@54200000 {
+			rgb {
+				status = "okay";
+				nvidia,panel = <&panel>;
+			};
+		};
+
+		hdmi@54280000 {
+			status = "okay";
+			hdmi-supply = <&reg_5v0>;
+		};
+	};
+
+	pinmux@70000014 {
+		state_default: pinmux {
+			bl-on {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			ddc {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			hotplug-detect {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			i2c {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			lcd {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			lm1 {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			mmc {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			mmccd {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			pwm-a-b {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			pwm-c-d {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			ssp {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			uart-a {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			uart-b {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			uart-c {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			usbh-pen {
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+		};
+	};
+
+	/* Colibri UART-A */
+	serial@70006000 {
+		status = "okay";
+	};
+
+	/* Colibri UART-C */
+	serial@70006040 {
+		status = "okay";
+	};
+
+	/* Colibri UART-B */
+	serial@70006300 {
+		status = "okay";
+	};
+
+	pwm@7000a000 {
+		status = "okay";
+	};
+
+	/*
+	 * GEN1_I2C: I2C_SDA/SCL on SODIMM pin 194/196 (e.g. RTC on carrier
+	 * board)
+	 */
+	i2c@7000c000 {
+		status = "okay";
+		clock-frequency = <400000>;
+
+		/* M41T0M6 real time clock on carrier board */
+		rtc@68 {
+			compatible = "st,m41t0";
+			reg = <0x68>;
+		};
+	};
+
+	/* GEN2_I2C: unused */
+
+	/* CAM_I2C (I2C3): unused */
+
+	/* DDC_CLOCK/DATA on X3 pin 15/16 (e.g. display EDID) */
+	i2c@7000c400 {
+		status = "okay";
+	};
+
+	/* EHCI instance 0: USB1_DP/N -> USBC_P/N */
+	usb@c5000000 {
+		status = "okay";
+		dr_mode = "otg";
+	};
+
+	usb-phy@c5000000 {
+		status = "okay";
+		vbus-supply = <&reg_usbc_vbus>;
+	};
+
+	/* EHCI instance 2: USB3_DP/N -> USBH_P/N */
+	usb@c5008000 {
+		status = "okay";
+	};
+
+	usb-phy@c5008000 {
+		status = "okay";
+		vbus-supply = <&reg_usbh_vbus>;
+	};
+
+	/* SPI4: Colibri SSP */
+	spi@7000da00 {
+		status = "okay";
+		spi-max-frequency = <25000000>;
+
+		can@0 {
+			compatible = "microchip,mcp2515";
+			reg = <0>;
+			clocks = <&clk16m>;
+			interrupt-parent = <&gpio>;
+			/* CAN_INT */
+			interrupts = <TEGRA_GPIO(A, 0) IRQ_TYPE_EDGE_FALLING>;
+			spi-max-frequency = <10000000>;
+			vdd-supply = <&reg_3v3>;
+			xceiver-supply = <&reg_5v0>;
+		};
+	};
+
+	/* SD/MMC */
+	sdhci@c8000600 {
+		status = "okay";
+		bus-width = <4>;
+		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>; /* MMCD */
+		no-1-8-v;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <255 128 64 32 16 8 4 0>;
+		default-brightness-level = <6>;
+		/* BL_ON */
+		enable-gpios = <&gpio TEGRA_GPIO(T, 4) GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_3v3>;
+		pwms = <&pwm 0 5000000>; /* PWM<A> */
+	};
+
+	clk16m: osc3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <16000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		wakeup {
+			label = "SODIMM pin 45 wakeup";
+			gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_WAKEUP>;
+			debounce-interval = <10>;
+			wakeup-source;
+		};
+	};
+
+	panel: panel {
+		/*
+		 * edt,et057090dhu: EDT 5.7" LCD TFT
+		 * edt,et070080dh6: EDT 7.0" LCD TFT
+		 */
+		compatible = "edt,et057090dhu", "simple-panel";
+		backlight = <&backlight>;
+		power-supply = <&reg_3v3>;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V_SW";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5V_SW";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usbc_vbus: regulator-usbc-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_USB5";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&reg_5v0>;
+	};
+
+	/* USBH_PEN resp. USB_P_EN */
+	reg_usbh_vbus: regulator-usbh-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_USB[1-4]";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
+		vin-supply = <&reg_5v0>;
+	};
+};
-- 
2.14.4

