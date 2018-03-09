Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932526AbeCIRZA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:25:00 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:26557 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbeCIRYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:24:53 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180309172451epoutp033f79cc6f20f2fae54a5d9235c55475cb~aUHX2S-ky1152511525epoutp03Z
X-AuditID: b6c32a36-ca9ff70000001028-09-5aa2c3638da4
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: kgene@kernel.org, devicetree@vger.kernel.org, javierm@redhat.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 6/6] ARM: dts: exynos: Enable HDMI audio support on
 exynos5800-peach-pi
Date: Fri, 09 Mar 2018 18:22:50 +0100
Message-id: <20180309172250.23019-6-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180309172250.23019-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCmgW7y4UVRBvcmCFlsnLGe1WL+kXOs
        FgunLWe06H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y25x+E07qwOXx6ZVnWwem5fU
        e7zfd5XNo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDK+X/vDWnCOv2Lilp2sDYyPeboYOTkk
        BEwk7iydydLFyMUhJLCDUWJe4xU2COc7o8TZV68ZYare919iArGFBDYwSuxemQFR9ItR4l7/
        A2aQBJuAoUTv0T6wBhEBYYl7S5ezg9jMApOYJGbNlwWxhQViJNZM2Qi0gYODRUBV4vfdIpAw
        r4C1xPcbD5ggdslLvF9wH2wMp4CNxJKZh9kg4kvYJE41Z0PYLhJrzk2Buk1Y4tXxLewgIyUE
        pCUuHbWFCFdLdLZ1sYOcKSHQwijxZ9olqDnWEoePX2SFOI1P4t3XHlaIXl6JjjYhiBIPiedv
        Z7BD2I4ST2dfgAZQP6PE9munWScwSi1gZFjFKJZaUJybnlpsWGCkV5yYW1yal66XnJ+7iREc
        rVpmOxgXnfM5xCjAwajEw7tj6qIoIdbEsuLK3EOMEhzMSiK872uAQrwpiZVVqUX58UWlOanF
        hxilOViUxHkDAlyihATSE0tSs1NTC1KLYLJMHJxSDYxpN6N6Hf3Pfzl5Ze/PmZo7MiLf1NUr
        v/3N2vKV3X2vYLB10nRW51Pf4sMCnylruPJYG00Q+vI+rE51trnp3AQd2xCuLC2ueeHc92d/
        C5wY+mszp7vBpOySv2euNzr9ClOao3ppLYPe6hs//27vM05c1b7/2uwnppdlUjculNtjKd/4
        x53H/7gSS3FGoqEWc1FxIgDT9qMk0gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsVy+t9jQd2kw4uiDGbckLLYOGM9q8X8I+dY
        LRZOW85o0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl93i8Jt2Vgcuj02rOtk8Ni+p
        93i/7yqbR9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGV8v/aHteAcf8XELTtZGxgf83QxcnJI
        CJhIvO+/xNTFyMUhJLCOUeL/rpvMEM4vRonPR+6zgFSxCRhK9B7tYwSxRQSEJe4tXc4OUsQs
        MIlJomnnT7CEsECMxJopG9m6GDk4WARUJX7fLQIJ8wpYS3y/8YAJYpu8xPsF98HKOQVsJJbM
        PAxWLgRUs/VYwARGngWMDKsYJVMLinPTc4uNCgzzUsv1ihNzi0vz0vWS83M3MQIDbNthrb4d
        jPeXxB9iFOBgVOLhFZixKEqINbGsuDL3EKMEB7OSCO/7GqAQb0piZVVqUX58UWlOavEhRmkO
        FiVx3tt5xyKFBNITS1KzU1MLUotgskwcnFINjGFlh59mBb/NCTxzqFKN453iv5TdCikPHj9b
        tXd2I4ueBkOT2s+2s+Ipre0XHz9IiLrjrLX8ms2N8BVlf9b9cnR6svWLbcQBTRvnpbEefjmX
        BN4fZKh41mo14SnLvJPCLxZbvN7Knr3k+aRLs0MqM/ZY8x5/JLD+t0CIpOW9e6wVi3bInlgQ
        YKDEUpyRaKjFXFScCACvan/7LAIAAA==
X-CMS-MailID: 20180309172450epcas1p2b845a521afbadc81da991330bdbc588c
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180309172450epcas1p2b845a521afbadc81da991330bdbc588c
X-RootMTR: 20180309172450epcas1p2b845a521afbadc81da991330bdbc588c
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
        <CGME20180309172450epcas1p2b845a521afbadc81da991330bdbc588c@epcas1p2.samsung.com>
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
I think it shouldn't be applied unless someone actually tests it.

Changes since v1:
 - edited commit summary line.
---
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
