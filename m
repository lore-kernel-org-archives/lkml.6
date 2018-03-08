Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935932AbeCHQ3V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:29:21 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:42339 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933478AbeCHQ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:29:19 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180308162917epoutp04cc0ae93463530eee6ee738456e80d960~Z-tj_E3b31917019170epoutp04D
X-AuditID: b6c32a36-c91ff70000001028-fb-5aa164dceba0
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: kgene@kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ARM: dts: Enable HDMI audio support on exynos5420-peach-pit
Date: Thu, 08 Mar 2018 17:29:04 +0100
Message-id: <20180308162904.632-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCmge6dlIVRBktfy1tsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+Txdojd9ktDr9pZ3Xg9Ni0qpPNY/OSeo++LasY
        PT5vkgtgieKySUnNySxLLdK3S+DKeH3rHGtBB1/FzL6nLA2MJ7i7GDk4JARMJN7uYeti5OIQ
        EtjBKPHz4h9GCOc7o8TpL7+Yuhg5wYrOty1hgUjsZpQ4tv0lVNUvRom717cyg1SxCRhK9B7t
        YwSxRQSEJe4tXc4OUsQs8I9R4vitaWBFwgI+Es8+7mcDsVkEVCXOr5wM1sArYCnR//o21Dp5
        ifcL7oNtkBD4yiqx9sYEqISLxPctC9kgbGGJV8e3sEM8IS1x6agtRLhaorOtix2it4VR4s+0
        S1D11hKHj19kBbGZBfgk3n3tYYXo5ZXoaBOCKPGQaH59kBHCdpT49mY6O4gtJBAr8fDNCbYJ
        jJILGBlWMYqlFhTnpqcWGxYY6RUn5haX5qXrJefnbmIER6GW2Q7GRed8DjEKcDAq8fA+cFwY
        JcSaWFZcmXuIUYKDWUmEN0AfKMSbklhZlVqUH19UmpNafIhRmoNFSZw3IMAlSkggPbEkNTs1
        tSC1CCbLxMEp1cDYrfYguXe791ynGewLXihM/huUyK8rJ8LyiKlL7YXghNk/1p5kWS5cqxzQ
        fpep4AX/Hn/pHMn+RXyPv+1ODwk7vfXywYcs75+c285x5nUhU6rEhv41ig+OXPHb9DdVoCB+
        nuovw+rGOUovmPxe5mh/5Ge0FYvkiZC15Zlnofct8Izor+WKa3yVWIozEg21mIuKEwEi/y0t
        vgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBJMWRmVeSWpSXmKPExsVy+t9jAd07KQujDB418FpsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+Txdojd9ktDr9pZ3Xg9Ni0qpPNY/OSeo++LasY
        PT5vkgtgieKySUnNySxLLdK3S+DKeH3rHGtBB1/FzL6nLA2MJ7i7GDk5JARMJM63LWHpYuTi
        EBLYySixd+kBJgjnF6PEmq9X2UGq2AQMJXqP9jGC2CICwhL3li4HizML/GOU+LBVH8QWFvCR
        ePZxPxuIzSKgKnF+5WSwel4BS4n+17eZILbJS7xfcJ9xAiPXAkaGVYySqQXFuem5xUYFhnmp
        5XrFibnFpXnpesn5uZsYgeGx7bBW3w7G+0viDzEKcDAq8fBauCyMEmJNLCuuzD3EKMHBrCTC
        G6APFOJNSaysSi3Kjy8qzUktPsQozcGiJM57O+9YpJBAemJJanZqakFqEUyWiYNTqoHRSPZU
        fJZ4z2MP20q3aG/Weypvz5ee0GbIeeoT+c14686Hj329FjTNnr5e9PWp9xlJLbzNRQfYfQ1D
        Yicuvjov57xtz81DrCWfVwtnTOcRfctxvsjdQWjriWM7A/juln20WiZ7bJfLjWW28VPLIue/
        XX6hp3D+jB1T/ypqHbe7z6zQ7ZSa2VivxFKckWioxVxUnAgAl7wQ8QsCAAA=
X-CMS-MailID: 20180308162916epcas1p4bec3b6702b1f49f2313b04e713313d92
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180308162916epcas1p4bec3b6702b1f49f2313b04e713313d92
X-RootMTR: 20180308162916epcas1p4bec3b6702b1f49f2313b04e713313d92
References: <CGME20180308162916epcas1p4bec3b6702b1f49f2313b04e713313d92@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new cpu, codec subnodes according to the updated
"google,snow-audio-max98090" DT bindings and the I2S clock tree
configuration so sound on the HDMI interface can also be supported.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 5a76ed77dda1..244f0091c21f 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/maxim,max77802.h>
 #include <dt-bindings/regulator/maxim,max77802.h>
+#include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5420.dtsi"
 #include "exynos5420-cpus.dtsi"
 
@@ -86,6 +87,14 @@
 		samsung,model = "Peach-Pit-I2S-MAX98090";
 		samsung,i2s-controller = <&i2s0>;
 		samsung,audio-codec = <&max98090>;
+
+		cpu {
+			sound-dai = <&i2s0 0>;
+		};
+
+		codec {
+			sound-dai = <&max98090>, <&hdmi>;
+		};
 	};
 
 	usb300_vbus_reg: regulator-usb300 {
@@ -142,6 +151,11 @@
 	vdd-supply = <&ldo9_reg>;
 };
 
+&clock_audss {
+	assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>;
+	assigned-clock-parents = <&clock CLK_FOUT_EPLL>;
+};
+
 &cpu0 {
 	cpu-supply = <&buck2_reg>;
 };
@@ -606,6 +620,7 @@
 		pinctrl-0 = <&max98090_irq>;
 		clocks = <&pmu_system_controller 0>;
 		clock-names = "mclk";
+		#sound-dai-cells = <0>;
 	};
 
 	light-sensor@44 {
@@ -690,6 +705,8 @@
 };
 
 &i2s0 {
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_I2S_BUS>;
 	status = "okay";
 };
 
-- 
2.14.2
