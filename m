Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EC4C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FF7218A4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfADBlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 20:41:12 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33192 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfADBlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 20:41:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id d15so6293843qkj.0;
        Thu, 03 Jan 2019 17:41:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=ZGFhud/si8vg/N36E17BPr7LYDjCfXkDc52GiIyxOko=;
        b=VZcDu5ZHO9rgemSAOGO2OIIA9ogvMgi+hEbv71SPP8FvUW5UCYu83QbHCWVJGiruRW
         IWqX4cSMaPggiWW4R6/pzu1zhnBbDEuA0K4aZkiplU7WzaZryjCtyBHCtr9qLZZcavcv
         j3gZYEA/rglps8rRt6N85bPDYpYPELuOcBKwtQu+bUCiAAv6W7Jfch+Zk1ex+6KVUkiQ
         5+wLhbhgd1Q5z79+bANsdA9L2JhmqB4vXsxFvFRrQrJdU6iKZWUQsqnCjMXHDMaMpjAC
         ZTX6u9BRiXvv3YaySkdsjOfNc+mXZdgSDMmSA474otW5e0fQC5wYzXd02WDeMwc4U5hv
         unuA==
X-Gm-Message-State: AJcUukcnicPHltYg1U2htfvV+a1N/uXFU8LYz5aZ1Gp/96ZFs+dhZs1x
        zMOavNfzMJY0zQvQDy501ac=
X-Google-Smtp-Source: ALg8bN6SDKMP6HJ5wVjNXtkle2JXBZF/AED00Zv9yfL3DBKua5DZ98D39igbcZGUM6ZnOC9bFVufAA==
X-Received: by 2002:a37:474b:: with SMTP id u72mr45242329qka.106.1546566069199;
        Thu, 03 Jan 2019 17:41:09 -0800 (PST)
Received: from localhost.localdomain ([181.220.84.254])
        by smtp.gmail.com with ESMTPSA id g5sm21615704qkd.55.2019.01.03.17.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 17:41:08 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 03 Jan 2019 23:41:02 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Jason Zhu <jason.zhu@rock-chips.com>,
        Vicent Chi <vicent.chi@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 4/4] ARM: dts: rv1108: Add support for rv1108-elgin-r1 board
Date:   Thu,  3 Jan 2019 23:40:23 -0200
Message-Id: <20190104014023.17973-4-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104014023.17973-1-otavio@ossystems.com.br>
References: <20190104014023.17973-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rv1108-elgin-r1 board is based on Rockchip RV1108 SoC.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/rv1108-elgin-r1.dts         | 206 ++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 arch/arm/boot/dts/rv1108-elgin-r1.dts

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index b12958bda09c..d30fff4b4676 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -60,6 +60,11 @@ properties:
           - const: chipspark,rayeager-px2
           - const: rockchip,rk3066a
 
+      - description: Elgin RV1108 R1
+        items:
+          - const: elgin,rv1108-r1
+          - const: rockchip,rv1108
+
       - description: Firefly Firefly-RK3288
         items:
           - enum:
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 78551c4375d5..9e31d4b94320 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -865,6 +865,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r9a06g032-rzn1d400-db.dtb \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
+	rv1108-elgin-r1.dtb \
 	rv1108-evb.dtb \
 	rk3036-evb.dtb \
 	rk3036-kylin.dtb \
diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
new file mode 100644
index 000000000000..7b24558f13e0
--- /dev/null
+++ b/arch/arm/boot/dts/rv1108-elgin-r1.dts
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/*
+ * Copyright (C) 2018 O.S. Systems Software LTDA.
+ */
+
+/dts-v1/;
+
+#include "rv1108.dtsi"
+
+/ {
+	model = "Elgin RV1108 R1 board";
+	compatible = "elgin,rv1108-r1", "rockchip,rv1108";
+
+	memory@60000000 {
+		device_type = "memory";
+		reg = <0x60000000 0x08000000>;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	vcc_sys: vsys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_core>;
+};
+
+&emmc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	disable-wp;
+	no-sd;
+	no-sdio;
+	non-removable;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rmii_pins>;
+	snps,reset-gpio = <&gpio1 RK_PC1 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	clock_in_out = "output";
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	i2c-scl-rising-time-ns = <275>;
+	i2c-scl-falling-time-ns = <16>;
+	clock-frequency = <400000>;
+
+	rk805: pmic@18 {
+		compatible = "rockchip,rk805";
+		reg = <0x18>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
+		rockchip,system-power-controller;
+
+		vcc1-supply = <&vcc_sys>;
+		vcc2-supply = <&vcc_sys>;
+		vcc3-supply = <&vcc_sys>;
+		vcc4-supply = <&vcc_sys>;
+		vcc5-supply = <&vcc_sys>;
+		vcc6-supply = <&vcc_sys>;
+
+		regulators {
+			vdd_core: DCDC_REG1 {
+				regulator-name= "vdd_core";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-state-enabled;
+					regulator-state-uv = <900000>;
+				};
+			};
+
+			vdd_cam: DCDC_REG2 {
+				regulator-name= "vdd_cam";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-state-mem {
+					regulator-state-disabled;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name= "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-state-enabled;
+				};
+			};
+
+			vcc_io: DCDC_REG4 {
+				regulator-name= "vcc_io";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-state-enabled;
+					regulator-state-uv = <3300000>;
+				};
+			};
+
+			vdd_10: LDO_REG1 {
+				regulator-name= "vdd_10";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-state-disabled;
+				};
+			};
+
+			vcc_18: LDO_REG2 {
+				regulator-name= "vcc_18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-state-disabled;
+				};
+			};
+
+			vdd10_pmu: LDO_REG3 {
+				regulator-name= "vdd10_pmu";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-state-enabled;
+					regulator-state-uv = <1000000>;
+				};
+			};
+		};
+	};
+};
+
+&spi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spim1_clk &spim1_cs0 &spim1_tx &spim1_rx>;
+	status = "okay";
+
+	dh2228fv: dac@0 {
+		compatible = "rohm,dh2228fv";
+		reg = <0>;
+		spi-max-frequency = <24000000>;
+		spi-cpha;
+		spi-cpol;
+	};
+};
+
+&u2phy {
+	status = "okay";
+
+	u2phy_host: host-port {
+		status = "okay";
+	};
+
+	u2phy_otg: otg-port {
+		status = "okay";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_host_ehci {
+	status = "okay";
+};
+
+&usb_host_ohci {
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+};
-- 
2.20.1

