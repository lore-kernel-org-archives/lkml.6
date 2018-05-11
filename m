Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeEKIKk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:10:40 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:50796 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbeEKIKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:10:34 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180511081032epoutp0130c34873df7e1aa56ec53782a6209ead~tiMYA2Q3y0922009220epoutp01F
X-AuditID: b6c32a47-bdfff70000001011-7c-5af54ff8eec3
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ARM: dts: exynos: Use dedicated DT bindings for Odroid
 X/X2, U3
Date: Fri, 11 May 2018 10:09:47 +0200
Message-id: <20180511080947.3057-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCmue4P/69RBucWiltsnLGe1WL+kXOs
        FufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i9a9R9gtDr9pZ3Xg9Ni0qpPNY/OSeo++LasY
        PT5vkgtgieKySUnNySxLLdK3S+DKOLMqsOCddMXt/jlMDYzd4l2MnBwSAiYSJzesZuli5OIQ
        EtjBKHGw8SU7hPOdUeLztGtsMFW7Hp5khUjsZpQ49PoaVNUvRom5W14wgVSxCRhK9B7tYwSx
        RQSEJe4tXQ5WxCzQwCTx78EusCJhgSCJ92fmgtksAqoSK95NYAGxeQWsJL5f2scEsU5e4v2C
        +4wgzRICX1klrt1bAJVwkVjRP50VwhaWeHV8CzuELS3xbNVGRgi7WqKzrYsdormFUeLPtEtQ
        T1hLHD5+EayZWYBPouPwX6AiDqA4r0RHmxBEiYfElJ1dUDMdJWZuvAC2V0ggVmLmy6tsExgl
        FzAyrGIUSy0ozk1PLTYqMNYrTswtLs1L10vOz93ECI5DLfcdjNvO+RxiFOBgVOLhlYj5EiXE
        mlhWXJl7iFGCg1lJhHffCqAQb0piZVVqUX58UWlOavEhRmkOFiVx3jVKX6OEBNITS1KzU1ML
        UotgskwcnFINjDN3btPxXnKNo6Dq9mUr81nnnz96sWWDRNjKwiur5Xb/j/4b9kPQ1l9A3GW6
        4Owbj7+JLeiRMExYHfjTZwb33nkTd8v9UeNQtzh0ZAnjC3d+y7Af7UHq2wQeGFRmGcr5x3eu
        PL/z3uqa3eEFy5iuMm9YzjtrAs+vB02iMQ4TxdednPO9Joxr2VwlluKMREMt5qLiRADbKF4U
        vwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOJMWRmVeSWpSXmKPExsVy+t9jAd3v/l+jDOYsN7PYOGM9q8X8I+dY
        Lc6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFq17j7BbHH7TzurA6bFpVSebx+Yl9R59W1Yx
        enzeJBfAEsVlk5Kak1mWWqRvl8CVcWZVYME76Yrb/XOYGhi7xbsYOTkkBEwkdj08yQpiCwns
        ZJTobtftYuQCsn8xSly/t4EZJMEmYCjRe7SPEcQWERCWuLd0OTtIEbNAA5PE20Nf2UASwgIB
        ErMO32MHsVkEVCVWvJvAAmLzClhJfL+0jwlim7zE+wX3GScwci1gZFjFKJlaUJybnltsVGCU
        l1quV5yYW1yal66XnJ+7iREYHNsOa/XvYHy8JP4QowAHoxIPb0POlygh1sSy4srcQ4wSHMxK
        Irz7VgCFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MBoc
        NixLmV3cOD/tGKtqeJBBgPuZaVOfLTAstXY5sF9foHGTQN0UL1cOgTVSAWr2j9/8aJKSlnBu
        vqLfklf/Qbvh4eKFXywaJsgsiQn79r7TsvPXDKUtSWd3dB84zlIdzLv89utFrJIb3E+msVcd
        d/+5eobPo1Uz5lX+Tm77eKiZSyO8523xTSWW4oxEQy3mouJEAL8eyWoKAgAA
X-CMS-MailID: 20180511081032epcas2p30f381cf699cb7524d9a143390e9c74b5
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180511081032epcas2p30f381cf699cb7524d9a143390e9c74b5
X-RootMTR: 20180511081032epcas2p30f381cf699cb7524d9a143390e9c74b5
References: <CGME20180511081032epcas2p30f381cf699cb7524d9a143390e9c74b5@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dedicated Odroid audio subsystem DT bindings instead of the simple-card.
This adds support for audio on the HDMI interface.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 33 ++++++++++++++-----------
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |  7 +++---
 arch/arm/boot/dts/exynos4412-odroidx.dts        |  7 +++---
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index d7ad07fd48f9..bad08e70358a 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -37,20 +37,12 @@
 	};
 
 	sound: sound {
-		compatible = "simple-audio-card";
-
-		simple-audio-card,format = "i2s";
-		simple-audio-card,bitclock-master = <&link0_codec>;
-		simple-audio-card,frame-master = <&link0_codec>;
-
-		simple-audio-card,cpu {
+		cpu {
 			sound-dai = <&i2s0 0>;
-			system-clock-frequency = <19200000>;
 		};
 
-		link0_codec: simple-audio-card,codec {
-			sound-dai = <&max98090>;
-			clocks = <&i2s0 CLK_I2S_CDCLK>;
+		codec {
+			sound-dai = <&hdmi>, <&max98090>;
 		};
 	};
 
@@ -142,14 +134,25 @@
 	pinctrl-0 = <>;
 };
 
+&clock {
+	assigned-clocks = <&clock CLK_FOUT_EPLL>;
+	assigned-clock-rates = <45158401>;
+};
+
 &clock_audss {
 	assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
 			<&clock_audss EXYNOS_MOUT_I2S>,
 			<&clock_audss EXYNOS_DOUT_SRP>,
-			<&clock_audss EXYNOS_DOUT_AUD_BUS>;
+			<&clock_audss EXYNOS_DOUT_AUD_BUS>,
+			<&clock_audss EXYNOS_DOUT_I2S>;
+
 	assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
-			<&clock_audss EXYNOS_MOUT_AUDSS>;
-	assigned-clock-rates = <0>, <0>, <192000000>, <19200000>;
+			  <&clock_audss EXYNOS_MOUT_AUDSS>;
+
+	assigned-clock-rates = <0>, <0>,
+			<196608001>,
+			<(196608001 / 2)>,
+			<(196608001 / 8)>;
 };
 
 &cpu0 {
@@ -498,6 +501,8 @@
 	pinctrl-0 = <&i2s0_bus>;
 	pinctrl-names = "default";
 	status = "okay";
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>;
 };
 
 &mixer {
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index bdcd4523cc1c..7a94a423097d 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -113,11 +113,12 @@
 };
 
 &sound {
-	simple-audio-card,name = "Odroid-U3";
-	simple-audio-card,widgets =
+	compatible = "hardkernel,odroid-xu4-audio";
+	model = "Odroid-U3";
+	samsung,audio-widgets =
 		"Headphone", "Headphone Jack",
 		"Speakers", "Speakers";
-	simple-audio-card,routing =
+	samsung,audio-routing =
 		"Headphone Jack", "HPL",
 		"Headphone Jack", "HPR",
 		"Headphone Jack", "MICBIAS",
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 2dff129bc2ad..f0d5037f3a5d 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -97,12 +97,13 @@
 };
 
 &sound {
-	simple-audio-card,name = "Odroid-X";
-	simple-audio-card,widgets =
+	compatible = "hardkernel,odroid-xu4-audio";
+	model = "Odroid-X";
+	samsung,audio-widgets =
 		"Headphone", "Headphone Jack",
 		"Microphone", "Mic Jack",
 		"Microphone", "DMIC";
-	simple-audio-card,routing =
+	samsung,audio-routing =
 		"Headphone Jack", "HPL",
 		"Headphone Jack", "HPR",
 		"IN1", "Mic Jack",
-- 
2.14.2
