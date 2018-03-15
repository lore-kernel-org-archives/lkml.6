Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeCONoN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:44:13 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:44230 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbeCONoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:44:12 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH] ARM: dts: sun7i: Add pinmux settings for LCD0 RGB888 output.
Date: Thu, 15 Mar 2018 14:43:30 +0100
Message-Id: <1521121410-17103-1-git-send-email-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A20 supports RGB888 with H/V sync from LCD0. Add a pinmux setting
for the needed pins.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index bd0cd32..d4b2d18 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -922,6 +922,14 @@
 				pins = "PI20", "PI21";
 				function = "uart7";
 			};
+
+			lcd0_rgb888_pins: lcd0-rgb888-pins {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
+				       "PD8", "PD9", "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
+				       "PD16", "PD17", "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
+				       "PD24", "PD25", "PD26", "PD27";
+				function = "lcd0";
+			};
 		};
 
 		timer@1c20c00 {
-- 
2.7.4
