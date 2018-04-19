Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752914AbeDSJcl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 05:32:41 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:35754 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752786AbeDSJch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 05:32:37 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jonathan Liu <net147@gmail.com>
Subject: [PATCH 5/6] ARM: dts: sun7i: add pinmux setting for RGB888 output for LCD0
Date: Thu, 19 Apr 2018 17:32:24 +0800
Message-Id: <20180419093225.614-6-wens@csie.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419093225.614-1-wens@csie.org>
References: <20180419093225.614-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the A20, as well as many other Allwinner SoCs, the PD pingroup has
the LCD0 RGB output functions.

Add a pinmux setting for RGB888 output from LCD0, so boards and tablets
with parallel RGB LCD panels may reference it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e529e4ff2174..e06c14649d22 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -920,6 +920,17 @@
 				pins = "PI20", "PI21";
 				function = "uart7";
 			};
+
+			lcd0_rgb888_pins: lcd0-rgb888-pins {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4",
+				       "PD5", "PD6", "PD7", "PD8", "PD9",
+				       "PD10", "PD11", "PD12", "PD13",
+				       "PD14", "PD15", "PD16", "PD17",
+				       "PD18", "PD19", "PD20", "PD21",
+				       "PD22", "PD23", "PD24", "PD25",
+				       "PD26", "PD27";
+				function = "lcd0";
+			};
 		};
 
 		timer@1c20c00 {
-- 
2.17.0
