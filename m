Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeBJBoH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:44:07 -0500
Received: from mout.perfora.net ([74.208.4.194]:48063 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751371AbeBJBoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:44:02 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] ARM: dts: tegra: apalis-tk1: copyright period, spurious newlines
Date: Sat, 10 Feb 2018 02:38:05 +0100
Message-Id: <20180210013806.28496-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180210013806.28496-1-marcel@ziswiler.com>
References: <20180210013806.28496-1-marcel@ziswiler.com>
X-Provags-ID: V03:K0:R3OSbxibVpFqYTawGU60tTb2Oud7LLVhLLRQdFmUmdWWyZe6GKN
 tW5aj1jzAZwiOd1aci5BSZX0fOoWFB90flelGVHDocwXARKh/Z8P8NZNMQVLWRCrofmHrOM
 /BW8tU17r+rhRtmt5h8IMQxgvpXF7cg4cNoDesWq+VDtktGp34HHU7kURkOmFVBEMDVLgpp
 SvTbXyeszfEqoPVq8Jv6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oGv7YX/3SIM=:o+Osqv2N5SJjUQeMyTW/x8
 eyus1Uynewfu+d+/amPDX2/GrjDhm+HYcZsrQc/dNXNh2NRHCqn6vtnRe6vu/2IfPKXlJmK4E
 7/5uv/tXJyhXY1ioxWLgFpEuGCcdQxVaQ53NBdbNdpG55MOkPlECiuC4p+RvPEx2p/4yDYxx1
 z8EKYEhUjket6RefQAXVHQfYdlNahZw9gtPhUGW+cp2TNBhDVrU8uzpc+7TLmdM5goVwT3chq
 hqnTgyZN/U7qNUfFhQ2JmOKjpUveDq6+uwxyxJnqJW52wdEVdp2mgo+SUc1vJpHlWmjkIf6kl
 s2O6zuHHXAZ+wQoMs2dTszxZWO44ir9pAAgldMrIFMF8SBprNq64ZDjggxwKcX2Rp30OmbDYM
 dGDNrDwAWSk14tZA5RiQDI9+OrG0stKvHgh47BOy/KFHgbbLzXH9c3Am40lO12/eQmkf/POtu
 /Ibd/Yd1T4CeaMzgUK7lxZh5iuxn4CGcW/v6bPy0D4iToCiK5L9f9P+S70aKgRSVt4jyBwIFt
 mCmXxXJi9s8Ruma62BQUAXRfvyolCG4d5UbYGtXGB9K5bf4XcokYR4/ueddajOpAbYFd9z+J5
 /oGHIgJxf+RQqnGamCOoxVW6VXSX5IUaOqju+Qowc/eJQ2FSD0DILsDeHJZxzqoagohIE/nHm
 VpMPf3SZ/oNbu7ZyoHt+yea5/hO0Js5HA/JGbGkLf9ZM3jOT7KCozbpIBLQRZy+0QiTXoXzbb
 j0QaFIdXiOnT+r+FvhcorxV3o/HwGK0kKYwE0w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Update the copyright period and get rid of some spurious newlines.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-eval.dts |  6 ++----
 arch/arm/boot/dts/tegra124-apalis.dtsi     | 11 +----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index f1010cefb993..a6ad759dddb4 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2016 Toradex AG
+ * Copyright 2016-2018 Toradex AG
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -225,9 +225,7 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-
-		/* BKL1_PWM */
-		pwms = <&pwm 3 5000000>;
+		pwms = <&pwm 3 5000000>; /* BKL1_PWM */
 		brightness-levels = <255 231 223 207 191 159 127 0>;
 		default-brightness-level = <6>;
 		/* BKL1_ON */
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index b7648ce4565d..65a2161b9b8e 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1,5 +1,5 @@
 /*
- * Copyright 2016 Toradex AG
+ * Copyright 2016-2018 Toradex AG
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -56,7 +56,6 @@
 
 	pcie@1003000 {
 		status = "okay";
-
 		avddio-pex-supply = <&vdd_1v05>;
 		avdd-pex-pll-supply = <&vdd_1v05>;
 		avdd-pll-erefe-supply = <&avdd_1v05>;
@@ -85,7 +84,6 @@
 		hdmi@54280000 {
 			pll-supply = <&reg_1v05_avdd_hdmi_pll>;
 			vdd-supply = <&reg_3v3_avdd_hdmi>;
-
 			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
@@ -1600,15 +1598,11 @@
 			compatible = "ams,as3722";
 			reg = <0x40>;
 			interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
-
 			ams,system-power-controller;
-
 			#interrupt-cells = <2>;
 			interrupt-controller;
-
 			gpio-controller;
 			#gpio-cells = <2>;
-
 			pinctrl-names = "default";
 			pinctrl-0 = <&as3722_default>;
 
@@ -1783,7 +1777,6 @@
 			reg = <0x4c>;
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
-
 			#thermal-sensor-cells = <1>;
 		};
 	};
@@ -1816,7 +1809,6 @@
 	sata@70020000 {
 		phys = <&{/padctl@7009f000/pads/sata/lanes/sata-0}>;
 		phy-names = "sata-0";
-
 		avdd-supply = <&vdd_1v05>;
 		hvdd-supply = <&reg_3v3>;
 		vddio-supply = <&vdd_1v05>;
@@ -1830,7 +1822,6 @@
 		       <&{/padctl@7009f000/pads/usb2/lanes/usb2-2}>,
 		       <&{/padctl@7009f000/pads/pcie/lanes/pcie-0}>;
 		phy-names = "usb2-0", "usb3-1", "usb2-1", "usb2-2", "usb3-0";
-
 		avddio-pex-supply = <&vdd_1v05>;
 		avdd-pll-erefe-supply = <&avdd_1v05>;
 		avdd-pll-utmip-supply = <&vddio_1v8>;
-- 
2.14.3
