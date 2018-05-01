Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755729AbeEAMch (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:32:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46166 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755670AbeEAMce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:32:34 -0400
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org,
        horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com
Subject: [PATCH v8 11/12] ARM: dts: sun8i: Add enable-method for SMP support for the A83T SoC
Date: Tue,  1 May 2018 14:31:30 +0200
Message-Id: <20180501123131.7738-12-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180501123131.7738-1-mylene.josserand@bootlin.com>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the use of enable-method property for SMP support which allows
to handle the SMP support for this specific SoC.

This commit adds enable-method properties to all CPU nodes.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 0669b8dc499d..2be23d600957 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -67,6 +67,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0>;
 		};
 
@@ -75,6 +76,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <1>;
 		};
 
@@ -83,6 +85,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <2>;
 		};
 
@@ -91,6 +94,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <3>;
 		};
 
@@ -101,6 +105,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x100>;
 		};
 
@@ -109,6 +114,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x101>;
 		};
 
@@ -117,6 +123,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x102>;
 		};
 
@@ -125,6 +132,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x103>;
 		};
 	};
-- 
2.11.0
