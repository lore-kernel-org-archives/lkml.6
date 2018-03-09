Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932513AbeCIRYu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:24:50 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:26539 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbeCIRYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:24:45 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180309172443epoutp034a7895e797e1fa3aba06d8d31079332c~aUHQavm1u1152511525epoutp03Y
X-AuditID: b6c32a45-3ebff70000001023-8a-5aa2c35bd7a2
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: kgene@kernel.org, devicetree@vger.kernel.org, javierm@redhat.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 5/6] ARM: dts: exynos: Enable HDMI audio support on
 exynos5420-peach-pit
Date: Fri, 09 Mar 2018 18:22:49 +0100
Message-id: <20180309172250.23019-5-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180309172250.23019-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCmuW704UVRBne/S1hsnLGe1WL+kXOs
        FgunLWe06H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y25x+E07qwOXx6ZVnWwem5fU
        e7zfd5XNo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDJ2X57GXnCAr+Ld6suMDYyfubsYOTkk
        BEwkfl1azdLFyMUhJLCDUeLplD3sEM53Rol9Fy6wwlR9vTuRDSKxgVHiZM9dJpCEkMAvRokN
        u6NBbDYBQ4neo32MILaIgLDEvaXL2UFsZoFJTBKz5suC2MICsRKLdq4C62URUJVY0rsYqIaD
        g1fAWqK/PRZil7zE+wX3wcZwCthILJl5GGyvhMACNomJS7qYIYpcJFZ13GGBsIUlXh3fwg5h
        S0s8W7WREcKuluhs62KHaG5hlPgz7RIbRMJa4vDxi6wQx/FJdBz+C3aEhACvREebEESJh8SP
        ndugdjlKzL+6Dhoq/YwS/xt2M01glFrAyLCKUSy1oDg3PbXYqMBQrzgxt7g0L10vOT93EyM4
        YrVcdzDOOOdziFGAg1GJh3fH1EVRQqyJZcWVuYcYJTiYlUR439cAhXhTEiurUovy44tKc1KL
        DzFKc7AoifO2BbhECQmkJ5akZqemFqQWwWSZODilGhhtLsc+mqmT8e/0pgXJuS+3THLSv8mV
        1XhJ8VDTG0snPw5l7/4lLWLrttT6NCsm7F+dfSXx06cFsVIKi1577Frvmbznz7uXayKntcve
        fSJ+21Vu9WKdRlV3l9lrXZ6Y/X9zT66iS8Fs7ueHvz7Yth00sXj8KvSs1AWLiVLlZq+bt1xU
        /rk+trdGiaU4I9FQi7moOBEAyEtTctQCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsVy+t9jQd2ow4uiDL5PEbXYOGM9q8X8I+dY
        LRZOW85o0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl93i8Jt2Vgcuj02rOtk8Ni+p
        93i/7yqbR9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGXsvjyNveAAX8W71ZcZGxg/c3cxcnJI
        CJhIfL07ka2LkYtDSGAdo8TsnhNQzi9GiTPvd7GCVLEJGEr0Hu1jBLFFBIQl7i1dzg5SxCww
        iUmiaedPsISwQKzEop2rmEBsFgFViSW9i4GKODh4Bawl+ttjIbbJS7xfcB+snFPARmLJzMNs
        ICVCQCVbjwVMYORZwMiwilEytaA4Nz232KjAKC+1XK84Mbe4NC9dLzk/dxMjMMC2Hdbq38H4
        eEn8IUYBDkYlHl6BGYuihFgTy4orcw8xSnAwK4nwvq8BCvGmJFZWpRblxxeV5qQWH2KU5mBR
        Euflzz8WKSSQnliSmp2aWpBaBJNl4uCUamDsj47YP+vQcktpb8F0dvWwxrvS77QW2T5a8cpc
        P7tl+6WUQ2uzXylKnjyidXT65aUaDgL7avfeU9b03qYQ92DhEtOsrFmiTvu+6K0V0rnnXML5
        +nhnK9/Jw6uV2JfO5vj2sEDmZ0mRtazkJa2b399OSj5bed/ow8OIrtitnCv3pTUqXL2evcpX
        iaU4I9FQi7moOBEAD6BMLCwCAAA=
X-CMS-MailID: 20180309172442epcas2p16d82d119fea8471383ccacee501c539a
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180309172442epcas2p16d82d119fea8471383ccacee501c539a
X-RootMTR: 20180309172442epcas2p16d82d119fea8471383ccacee501c539a
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
        <CGME20180309172442epcas2p16d82d119fea8471383ccacee501c539a@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new cpu, codec subnodes according to the updated
"google,snow-audio-max98090" DT bindings and the I2S clock tree
configuration so sound on the HDMI interface can also be supported.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1:
 - edited commit summary line.
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
