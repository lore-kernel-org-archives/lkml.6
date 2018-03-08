Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeCHQnN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:43:13 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:28084 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752082AbeCHQnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:43:11 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180308164309epoutp027eb8c2ad7d91e65b9bac3d4050477913~Z-5qy-Gx61993519935epoutp02q
X-AuditID: b6c32a36-c91ff70000001028-34-5aa1681cd4b0
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: javierm@redhat.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ARM: dts: Enable HDMI audio support on exynos5800-peach-pi
Date: Thu, 08 Mar 2018 17:42:52 +0100
Message-id: <20180308164252.1252-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCmga5MxsIog/U/LS02zljPajH/yDlW
        i4XTljNa9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWa4/cZbc4/Kad1YHLY9OqTjaPzUvq
        Pd7vu8rm0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBnLDv9iL+jlr2g/OZGtgXELTxcjJ4eE
        gInEsvVbWboYuTiEBHYwSqx71ccG4XxnlHi86TFTFyMHWNX3Jz4Q8d2MEm/b10F1/GKUWHD2
        AwvIKDYBQ4neo32MILaIgLDEvaXL2UGKmAUmMUlMeHAbLCEs4C3xddICRpCpLAKqEksWOoGE
        eQWsJN6/PccGcZK8xPsF9xlBeiUEetgken49YoO4wkViZ5MvRI2wxKvjW9ghwtISl47aQoSr
        JTrbutghWlsYJf5MuwQ101ri8PGLrCA2swCfxLuvPawQvbwSHW1CECUeEi8PdLBD2I4SR44t
        ZwKxhQRiJQ43XGObwCi5gJFhFaNYakFxbnpqsWGBkV5xYm5xaV66XnJ+7iZGcFRqme1gXHTO
        5xCjAAejEg/vA8eFUUKsiWXFlbmHGCU4mJVEeAP0gUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        AwJcooQE0hNLUrNTUwtSi2CyTBycUg2Mri0F05kMTI5Ipgn63GOVuM7Uxuz7eI7FyWf2Z8+/
        C3Px4hX0m2BXcfOCeNwXY7uoVnW7dtNmP8NNV/lLhSZuOhsosPnA04OvsjNm/5T9pij+7c3s
        5pMG4Y19q0vSr8aqZeh7Fmvd7t+e9Jc19e5yK96uBHVj/3KJdetM3MJSVSVbJST+mCqxFGck
        GmoxFxUnAgDxHBouxgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42I5/e+xgK5MxsIog3NLmC02zljPajH/yDlW
        i4XTljNa9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWa4/cZbc4/Kad1YHLY9OqTjaPzUvq
        Pd7vu8rm0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBnLDv9iL+jlr2g/OZGtgXELTxcjB4eE
        gInE9yc+XYxcHEICOxklfv66wgzh/GKUaFu0grWLkZODTcBQovdoHyOILSIgLHFv6XJ2kCJm
        gUlMEn9m7mYCSQgLeEt8nbSAEWQqi4CqxJKFTiBhXgErifdvz7GB2BIC8hLvF9xnnMDItYCR
        YRWjZGpBcW56brFRgWFearlecWJucWleul5yfu4mRmDAbDus1beD8f6S+EOMAhyMSjy8Fi4L
        o4RYE8uKK3MPMUpwMCuJ8AboA4V4UxIrq1KL8uOLSnNSiw8xSnOwKInz3s47FikkkJ5Ykpqd
        mlqQWgSTZeLglGpgVD734GnenbtySpsKRW86tOzaWePDlF2Zmz3b4t0js6Ll644LT+mUk0p3
        N2vjWrbY4kGdo7xgWFtgnMLTXcsels1dyszzcEU1U6fS+jOVyxR76iY8ObPog4+x1Q/HIqG8
        irab//0q7JnXtZ14UNZ7f1PbBudEub0eD5ccPpcdsoZHMD1UJ+63EktxRqKhFnNRcSIAecXW
        PxQCAAA=
X-CMS-MailID: 20180308164308epcas1p2ca9ecc14b6dd68492456d41f2215267c
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180308164308epcas1p2ca9ecc14b6dd68492456d41f2215267c
X-RootMTR: 20180308164308epcas1p2ca9ecc14b6dd68492456d41f2215267c
References: <CGME20180308164308epcas1p2ca9ecc14b6dd68492456d41f2215267c@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new cpu, codec subnodes according to the updated
"google,snow-audio-max98091" DT bindings and the I2S clock tree
configuration so sound on the HDMI interface can be also supported.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---

NOTE:
I couldn't test this patch as I have no access to Peach-pi Chromebook.
I think it shoudn't be applied unless some acutally tests it.

 arch/arm/boot/dts/exynos5800-peach-pi.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 0029ec27819c..0a4766e0484e 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -14,6 +14,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/maxim,max77802.h>
 #include <dt-bindings/regulator/maxim,max77802.h>
+#include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5800.dtsi"
 #include "exynos5420-cpus.dtsi"

@@ -89,6 +90,14 @@
 		samsung,model = "Peach-Pi-I2S-MAX98091";
 		samsung,i2s-controller = <&i2s0>;
 		samsung,audio-codec = <&max98091>;
+
+		cpu {
+			sound-dai = <&i2s0 0>;
+		};
+
+		codec {
+			sound-dai = <&max98091>, <&hdmi>;
+		};
 	};

 	usb300_vbus_reg: regulator-usb300 {
@@ -145,6 +154,11 @@
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
@@ -609,6 +623,7 @@
 		pinctrl-0 = <&max98091_irq>;
 		clocks = <&pmu_system_controller 0>;
 		clock-names = "mclk";
+		#sound-dai-cells = <0>;
 	};

 	light-sensor@44 {
@@ -661,6 +676,8 @@
 };

 &i2s0 {
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_I2S_BUS>;
 	status = "okay";
 };

--
2.14.2
