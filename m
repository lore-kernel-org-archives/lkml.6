Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933827AbeCGR1y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:27:54 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:32198 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933733AbeCGR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:27:45 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180307172743epoutp016d90b771c7dbfb3c557b9c8b5cf0cd57~Zs3TguGct2424424244epoutp01I
X-AuditID: b6c32a46-3a9ff70000001029-35-5aa0210f9777
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: kgene@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 4/4] ARM: dts: Enable HDMI audio on Snow Chromebook
Date: Wed, 07 Mar 2018 18:27:11 +0100
Message-id: <20180307172711.15697-4-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180307172711.15697-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCmmS6/4oIogx0vRS02zljPajH/yDlW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JYu2Ru+wWh9+0szpwemxa1cnmsXlJvUffllWM
        Hp83yQWwRHHZpKTmZJalFunbJXBl/PqxlLFgEU/FxRtzWBoYV3N1MXJySAiYSJw5Pou5i5GL
        Q0hgB6PE5d072CCc74wSF5afZISperztMSNEYjejxJpZX9khnF+MEvt+bWQHqWITMJToPdoH
        1iEiICxxb+lysCJmgX+MEutW7mUDSQgLOEs0HTjJAmKzCKhKzD72kBnE5hWwlvj3cDobxDp5
        ifcL7oMN4hSwkVh4ZzoLyCAJgSlsEosu7WGFKHKR2P11NzuELSzx6vgWKFta4tmqjVB3V0t0
        tnWxQzS3MEr8mXYJaoO1xOHjF8EGMQvwSXQc/gtUxAEU55XoaBOCKPGQ+LD3LNQuR4mLx/ZC
        /d/PKPHr0hqWCYxSCxgZVjGKpRYU56anFhsVGOkVJ+YWl+al6yXn525iBMeoltsOxiXnfA4x
        CnAwKvHwSvyZHyXEmlhWXJl7iFGCg1lJhNdIfkGUEG9KYmVValF+fFFpTmrxIUZpDhYlcd7W
        AJcoIYH0xJLU7NTUgtQimCwTB6dUA+PReyvPnNJa1vnptPxjDrHM6tPh6z45i1x+tUPtjf1s
        yRSDFZa3WyxU9u5XFYy8uSehb0b9ooe+jgq37R/2zfitInhdUZuf5egFJ9eSRd9v8lpJr/i7
        /sVxoXl3nteua7K97h6cU6r19fTUdxMEpY0nPw5peftqs66K/4yKi3/Orn5bc/forrRCJZbi
        jERDLeai4kQA92srfM0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsVy+t9jAV0+xQVRBmv6eCw2zljPajH/yDlW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JYu2Ru+wWh9+0szpwemxa1cnmsXlJvUffllWM
        Hp83yQWwRHHZpKTmZJalFunbJXBl/PqxlLFgEU/FxRtzWBoYV3N1MXJySAiYSDze9pixi5GL
        Q0hgJ6PEwn3tzBDOL0aJi4+PsoJUsQkYSvQe7WMEsUUEhCXuLV3ODlLELPCPUeLZ9MdsIAlh
        AWeJpgMnWUBsFgFVidnHHjKD2LwC1hL/Hk5ng1gnL/F+wX2wQZwCNhIL70wHqxcCqnmzp4l9
        AiPPAkaGVYySqQXFuem5xUYFRnmp5XrFibnFpXnpesn5uZsYgQG17bBW/w7Gx0viDzEKcDAq
        8fBK/JkfJcSaWFZcmXuIUYKDWUmE10h+QZQQb0piZVVqUX58UWlOavEhRmkOFiVxXv78Y5FC
        AumJJanZqakFqUUwWSYOTqkGRifPr5vMJmW+spx5K/XpJtG/FbaJCuHm1fnlbRb98d3M8ZrH
        pyWfiU39Ih4ZFeH+2HhGmJKz6Twxxzze/R5MBnOU3z9kcVu880Tlcq7C2ObwuXOa9SZYz5vn
        a5l+O+MO7+IzTt/MXlsmL/hY+zR9+87vUtkbdinPmGwjd7f7wtVs1uO9GY/eKLEUZyQaajEX
        FScCACHTuhAkAgAA
X-CMS-MailID: 20180307172742epcas2p2c0ef2394412da71b6d0ee172c47c3420
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180307172742epcas2p2c0ef2394412da71b6d0ee172c47c3420
X-RootMTR: 20180307172742epcas2p2c0ef2394412da71b6d0ee172c47c3420
References: <20180307172711.15697-1-s.nawrocki@samsung.com>
        <CGME20180307172742epcas2p2c0ef2394412da71b6d0ee172c47c3420@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new cpu, codec subnodes according to the updated
"google,snow-audio-max98095" bindings and the I2S clock tree
configuration so sound on the HDMI interface can also be supported.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 4 ++++
 arch/arm/boot/dts/exynos5250-snow.dts         | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index bdf59dd3654b..932a00cfd716 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/maxim,max77686.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5250.dtsi"

 / {
@@ -523,6 +524,9 @@
 };

 &i2s0 {
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_I2S_BUS>;
+	#clock-cells = <1>;
 	status = "okay";
 };

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 16e37c337a3f..8c3f1573a994 100644
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
+			sound-dai = <&hdmi>, <&max98095 0>;
+		};
 	};
 };

--
2.14.2
