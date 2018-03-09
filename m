Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932504AbeCIRYm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:24:42 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:54098 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbeCIRYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:24:39 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180309172437epoutp040060d8601273901da0ed5d2efc0a8b3a~aUHK7u5Oj0385803858epoutp04Q
X-AuditID: b6c32a48-9adff70000000ff0-df-5aa2c3541c6a
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: kgene@kernel.org, devicetree@vger.kernel.org, javierm@redhat.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 4/6] ARM: dts: exynos: Enable HDMI audio on Snow
 Chromebook
Date: Fri, 09 Mar 2018 18:22:48 +0100
Message-id: <20180309172250.23019-4-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180309172250.23019-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCmqW7I4UVRBts3mFpsnLGe1WL+kXOs
        FgunLWe06H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y25x+E07qwOXx6ZVnWwem5fU
        e7zfd5XNo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDLu7njJWrBWsOLcgy9MDYwb+boYOTkk
        BEwkHvQ3snQxcnEICexglFh74S4rSEJI4DujxO5/ATBF6w92sUMUbQCKn3zICuH8YpSYs6eN
        BaSKTcBQovdoHyOILSIgLHFv6XJ2EJtZYBKTxKz5siC2sECAxOXJt8DiLAKqEgdv3AQaxMHB
        K2AtcegpK8QyeYn3C+6DjeEUsJFYMvMwG8guCYEFbBK75s5nB6mXEHCRmHBGDKJeWOLV8S3s
        ELa0xLNVGxkh7GqJzjaIoyUEWhgl/ky7xAaRsJY4fPwiK8RtfBIdh/9CzeSV6GgTgijxkJje
        sIUZwnaUmNC0hg3i335GiceftjNOYJRawMiwilEstaA4Nz212KjARK84Mbe4NC9dLzk/dxMj
        OF61PHYwHjjnc4hRgINRiYdXYMaiKCHWxLLiytxDjBIczEoivO9rgEK8KYmVValF+fFFpTmp
        xYcYpTlYlMR52wJcooQE0hNLUrNTUwtSi2CyTBycUg2McpkTNkg5nK+dnPzF+NGmFrU+iydH
        hPZl1SgsP2vDMyXmIIthuHf+puWt5gKbLwlNPaJy0Hy5wGUf7ZKYT95HZWctPvkv/nohD8vK
        T93KAo+nFF3Mat38vfRF6qmIj+sXvryb+WfdKqW5cWu2pilZqHr4Mfr/e7ni/yeZtM3r77bO
        u/BORebeOSWW4oxEQy3mouJEACMwpcLTAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsVy+t9jQd2Qw4uiDNbskLTYOGM9q8X8I+dY
        LRZOW85o0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl93i8Jt2Vgcuj02rOtk8Ni+p
        93i/7yqbR9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGXc3fGStWCtYMW5B1+YGhg38nUxcnJI
        CJhIrD/Yxd7FyMUhJLCOUeLtk35GCOcXo8SeqRdZQarYBAwleo/2MYLYIgLCEveWLgfrYBaY
        xCTRtPMnWEJYwE9i1eFOFhCbRUBV4uCNm0DNHBy8AtYSh56yQmyTl3i/4D5YOaeAjcSSmYfZ
        QEqEgEq2HguYwMizgJFhFaNkakFxbnpusVGBUV5quV5xYm5xaV66XnJ+7iZGYIBtO6zVv4Px
        8ZL4Q4wCHIxKPLwCMxZFCbEmlhVX5h5ilOBgVhLhfV8DFOJNSaysSi3Kjy8qzUktPsQozcGi
        JM7Ln38sUkggPbEkNTs1tSC1CCbLxMEp1cCorv3LdtFicUGPqTbrMopXpwXZBZZf0N/aNbP/
        w5E20Y9qHvoTnF2udhkV7Nvv/0P47LrYCDPW0AcXbIQNn+1wZzOc4Gqv1LiufaeC4rWKd/6v
        NrS5TG455bPXdEfJWe/f1r57l9afShbb3ua+YE3ANa9fOs9uv80qjgq6/GLzeU71EKPkIDcl
        luKMREMt5qLiRACgKBeCLAIAAA==
X-CMS-MailID: 20180309172436epcas2p20e1da46084c1dcc67d6dd6cd1bf24368
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180309172436epcas2p20e1da46084c1dcc67d6dd6cd1bf24368
X-RootMTR: 20180309172436epcas2p20e1da46084c1dcc67d6dd6cd1bf24368
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
        <CGME20180309172436epcas2p20e1da46084c1dcc67d6dd6cd1bf24368@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new cpu, codec subnodes according to the updated
"google,snow-audio-max98095" DT bindings and the I2S clock tree
configuration so sound on the HDMI interface can also be supported.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v2:
 - i2s0/#clock-cells property moved to exynos5250.dtsi
 - edited commit summary line.

Changes since v1:
 - changed order of codec in codec/cpu-dai property
   to match the DT bindings documentation.
---
 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 3 +++
 arch/arm/boot/dts/exynos5250-snow.dts         | 8 ++++++++
 arch/arm/boot/dts/exynos5250.dtsi             | 1 +
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index bdf59dd3654b..fd9226d3b207 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/maxim,max77686.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5250.dtsi"
 
 / {
@@ -523,6 +524,8 @@
 };
 
 &i2s0 {
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_I2S_BUS>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 16e37c337a3f..75fdc5e6d423 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -18,6 +18,14 @@
 
 		samsung,model = "Snow-I2S-MAX98095";
 		samsung,audio-codec = <&max98095>;
+
+		cpu {
+			sound-dai = <&i2s0 0>;
+		};
+
+		codec {
+			sound-dai = <&max98095 0>, <&hdmi>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 71d2ede118e3..f6c6c94d3d7d 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -500,6 +500,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2s0_bus>;
 			power-domains = <&pd_mau>;
+			#clock-cells = <1>;
 		};
 
 		i2s1: i2s@12d60000 {
-- 
2.14.2
