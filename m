Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757175AbeDXLem (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:34:42 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:36326 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756905AbeDXLea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:34:30 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/7] ARM: dts: sun8i: h2+: Add Libre Computer Board ALL-H3-CC H2+ ver.
Date: Tue, 24 Apr 2018 19:34:21 +0800
Message-Id: <20180424113424.13196-5-wens@csie.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424113424.13196-1-wens@csie.org>
References: <20180424113424.13196-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a device tree file for the H2+ version of the Libre
Computer Board ALL-H3-CC. It is the same board first introduced in
commit 6ca358645d4d ("ARM: dts: sun8i: h3: Add dts file for Libre
Computer Board ALL-H3-CC H3 ver."), with the H3 SoC replaced with
the H2+ SoC, and has only two 2Gb DDR3 chips instead of four.

The device tree utilizes the common board design file for ALL-H3-CC,
providing just the model strings and SoC specifics.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/Makefile                          |  1 +
 .../boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dts  | 13 +++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5c979ed6c77b..1064d3acb607 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -993,6 +993,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a83t-cubietruck-plus.dtb \
 	sun8i-a83t-tbs-a711.dtb \
 	sun8i-h2-plus-bananapi-m2-zero.dtb \
+	sun8i-h2-plus-libretech-all-h3-cc.dtb \
 	sun8i-h2-plus-orangepi-r1.dtb \
 	sun8i-h2-plus-orangepi-zero.dtb \
 	sun8i-h3-bananapi-m2-plus.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dts b/arch/arm/boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dts
new file mode 100644
index 000000000000..2e7e13ab7eec
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 Chen-Yu Tsai <wens@csie.org>
+ */
+
+/dts-v1/;
+#include "sun8i-h3.dtsi"
+#include "sunxi-hx-libretech-all-h3-cc.dtsi"
+
+/ {
+	model = "Libre Computer Board ALL-H3-CC H2+";
+	compatible = "libretech,all-h3-cc-h2-plus", "allwinner,sun8i-h2-plus";
+};
-- 
2.17.0
