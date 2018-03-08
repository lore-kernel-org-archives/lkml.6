Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755430AbeCHPAa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:00:30 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:47254 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751239AbeCHPA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:00:28 -0500
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Mylene Josserand <mylene.josserand@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/4] ARM: dts: sun9i: Add enable-method for SMP support for the A80 SoC
Date: Thu,  8 Mar 2018 23:00:11 +0800
Message-Id: <20180308150012.19045-4-wens@csie.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180308150012.19045-1-wens@csie.org>
References: <20180308150012.19045-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the enable-method property for SMP support would allow future PSCI
implementations to override any in-OS support. This is better than just
matching against the machine compatible, and then having to determine
whether other methods are available or not.

This adds enable-method properties to all CPU nodes.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index b1c86b76ac3c..82a770a5ba46 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -65,6 +65,7 @@
 			device_type = "cpu";
 			cci-control-port = <&cci_control0>;
 			clock-frequency = <12000000>;
+			enable-method = "allwinner,sun9i-a80-smp";
 			reg = <0x0>;
 		};
 
@@ -73,6 +74,7 @@
 			device_type = "cpu";
 			cci-control-port = <&cci_control0>;
 			clock-frequency = <12000000>;
+			enable-method = "allwinner,sun9i-a80-smp";
 			reg = <0x1>;
 		};
 
@@ -81,6 +83,7 @@
 			device_type = "cpu";
 			cci-control-port = <&cci_control0>;
 			clock-frequency = <12000000>;
+			enable-method = "allwinner,sun9i-a80-smp";
 			reg = <0x2>;
 		};
 
@@ -89,6 +92,7 @@
 			device_type = "cpu";
 			cci-control-port = <&cci_control0>;
 			clock-frequency = <12000000>;
+			enable-method = "allwinner,sun9i-a80-smp";
 			reg = <0x3>;
 		};
 
@@ -97,6 +101,7 @@
 			device_type = "cpu";
 			cci-control-port = <&cci_control1>;
 			clock-frequency = <18000000>;
+			enable-method = "allwinner,sun9i-a80-smp";
 			reg = <0x100>;
 		};
 
@@ -105,6 +110,7 @@
 			device_type = "cpu";
 			cci-control-port = <&cci_control1>;
 			clock-frequency = <18000000>;
+			enable-method = "allwinner,sun9i-a80-smp";
 			reg = <0x101>;
 		};
 
@@ -113,6 +119,7 @@
 			device_type = "cpu";
 			cci-control-port = <&cci_control1>;
 			clock-frequency = <18000000>;
+			enable-method = "allwinner,sun9i-a80-smp";
 			reg = <0x102>;
 		};
 
@@ -121,6 +128,7 @@
 			device_type = "cpu";
 			cci-control-port = <&cci_control1>;
 			clock-frequency = <18000000>;
+			enable-method = "allwinner,sun9i-a80-smp";
 			reg = <0x103>;
 		};
 	};
-- 
2.16.2
