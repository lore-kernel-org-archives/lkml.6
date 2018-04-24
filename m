Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeDXLgE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:36:04 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:36364 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756972AbeDXLec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:34:32 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 7/7] arm64: dts: allwinner: h5: Add Libre Computer Board ALL-H3-CC H5 ver.
Date: Tue, 24 Apr 2018 19:34:24 +0800
Message-Id: <20180424113424.13196-8-wens@csie.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424113424.13196-1-wens@csie.org>
References: <20180424113424.13196-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a device tree file for the H5 version of the Libre
Computer Board ALL-H3-CC. It is the same board first introduced in
commit 6ca358645d4d ("ARM: dts: sun8i: h3: Add dts file for Libre
Computer Board ALL-H3-CC H3 ver."), with the H3 SoC replaced with
the H5 SoC, and has 4Gb DDR3 chips instead of 2Gb ones.

The device tree utilizes the common board design file for ALL-H3-CC,
providing just the model strings and SoC specifics.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/Makefile             |  1 +
 .../allwinner/sun50i-h5-libretech-all-h3-cc.dts    | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 6ec126e86183..c31f90a49481 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-libretech-all-h3-cc.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-plus2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
new file mode 100644
index 000000000000..f851bfbc13ed
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 Chen-Yu Tsai <wens@csie.org>
+ */
+
+/dts-v1/;
+#include "sun50i-h5.dtsi"
+#include "arm/sunxi-hx-libretech-all-h3-cc.dtsi"
+
+/ {
+	model = "Libre Computer Board ALL-H3-CC H5";
+	compatible = "libretech,all-h3-cc-h5", "allwinner,sun50i-h5";
+};
+
-- 
2.17.0
