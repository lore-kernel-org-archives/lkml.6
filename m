Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeENIC2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:02:28 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:11170 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752022AbeENICX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:02:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180514080221epoutp030489356cb315eb333a775f63c84cc2df~udBE5a-kD1987719877epoutp03H
X-AuditID: b6c32a48-c49ff70000000fef-28-5af9428cfed7
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2] ARM: dts: exynos: Add support for audio over HDMI for
 Odroid X/X2/U3
Date: Mon, 14 May 2018 10:01:48 +0200
Message-id: <20180514080148.10150-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWy7bCmmW6P088og4ubNSw2zljPajH/yDlW
        i/PnN7BbbHp8jdXi8q45bBYzzu9jslh75C67ReveI+wWh9+0szpwemxa1cnmsXlJvUffllWM
        Hp83yQWwRHHZpKTmZJalFunbJXBlrHlyn73gnnTF2lvPmRsYv4t1MXJySAiYSJxvnMDaxcjF
        ISSwg1Fi7seXjBDOd0aJY92rmGCqVl7ZD1W1gVFi+uLV7BDOL0aJmfsPsYJUsQkYSvQe7WME
        sUUEhCXuLV0OVsQs0MAk8e/BLrBRwgJREkd+/QYrYhFQlTi8fQdYnFfAWuLx9t2sEOvkJd4v
        uA92h4TAT1aJdTOWsEAkXCQ65zYxQtjCEq+Ob2GHsKUlnq3aCBWvluhs62KHaG5hlPgz7RIb
        RMJa4vDxi2AbmAX4JDoO/wUq4gCK80p0tAlBlHhItK36DvWzo8Tzax+YQWwhgViJZScesExg
        lFzAyLCKUSy1oDg3PbXYqMBErzgxt7g0L10vOT93EyM4ErU8djAeOOdziFGAg1GJh3fFyh9R
        QqyJZcWVuYcYJTiYlUR4dxv9jBLiTUmsrEotyo8vKs1JLT7EKM3BoiTOu0bpa5SQQHpiSWp2
        ampBahFMlomDU6qBcdEPtbuP/jwUfPbq4tdzVoma9XaujJJ7d2hG/li6MeLP8k1Jj60Cd71y
        r5AS0pOYti73f+C5hty3Z/hKjQp/bI5rmlj80l6rRWnNg+UG1v5ayesFLjPe4LxrOu1LeVxk
        ovd1ntfxp4u/Hq+8s+SUtdvN2skNOa7Gt3K8S3xLFK9F8lWerWt3U2Ipzkg01GIuKk4EACyP
        SQ/AAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJJMWRmVeSWpSXmKPExsVy+t9jQd0ep59RBvP2sltsnLGe1WL+kXOs
        FufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i9a9R9gtDr9pZ3Xg9Ni0qpPNY/OSeo++LasY
        PT5vkgtgieKySUnNySxLLdK3S+DKWPPkPnvBPemKtbeeMzcwfhfrYuTkkBAwkVh5ZT9rFyMX
        h5DAOkaJy6d/Qzm/GCXeHW5lBqliEzCU6D3axwhiiwgIS9xbupwdpIhZoIFJ4u2hr2wgCWGB
        KIkjv36DFbEIqEoc3r6DCcTmFbCWeLx9NyvEOnmJ9wvuM05g5FrAyLCKUTK1oDg3PbfYqMAo
        L7Vcrzgxt7g0L10vOT93EyMwQLYd1urfwfh4SfwhRgEORiUe3oDlP6KEWBPLiitzDzFKcDAr
        ifDuNvoZJcSbklhZlVqUH19UmpNafIhRmoNFSZyXP/9YpJBAemJJanZqakFqEUyWiYNTqoHR
        XH/a37pd8hPn6uaXMkZ7rhe5sf/ltWlb2xfx3n2avoFF9WK+8v5Fqs+3eu/+FLT8kJdjlY5Z
        xNezhmK7p03aJbRm/sJJmxXzpzz8LXZ3rp5N4OW0Y2Kn+9IOPFM3ML9a99X4nEmt1sY6Ky6P
        DbyZq9b+vcPgODUxeodw1Y2km0eaDuUuebJOSYmlOCPRUIu5qDgRALM+cVQMAgAA
X-CMS-MailID: 20180514080220epcas2p110497f1deca1e9c10db9b9edb890d76b
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180514080220epcas2p110497f1deca1e9c10db9b9edb890d76b
X-RootMTR: 20180514080220epcas2p110497f1deca1e9c10db9b9edb890d76b
References: <CGME20180514080220epcas2p110497f1deca1e9c10db9b9edb890d76b@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches Odroid X/X2/U3 to use dedicated Odroid audio subsystem
DT bindings instead of the simple-card in order to add support for audio
over HDMI.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 33 +++++++++++++++----------
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |  6 ++---
 arch/arm/boot/dts/exynos4412-odroidx.dts        |  6 ++---
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index d7ad07fd48f9..a09e46c9dbc0 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -37,20 +37,14 @@
 	};
 
 	sound: sound {
-		compatible = "simple-audio-card";
+		compatible = "hardkernel,odroid-xu4-audio";
 
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
 
@@ -142,14 +136,25 @@
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
@@ -498,6 +503,8 @@
 	pinctrl-0 = <&i2s0_bus>;
 	pinctrl-names = "default";
 	status = "okay";
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>;
 };
 
 &mixer {
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index bdcd4523cc1c..459919b65df8 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -113,11 +113,11 @@
 };
 
 &sound {
-	simple-audio-card,name = "Odroid-U3";
-	simple-audio-card,widgets =
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
index 2dff129bc2ad..348556fcdd9d 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -97,12 +97,12 @@
 };
 
 &sound {
-	simple-audio-card,name = "Odroid-X";
-	simple-audio-card,widgets =
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
