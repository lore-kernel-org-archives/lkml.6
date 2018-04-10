Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeDJVcX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 17:32:23 -0400
Received: from 220.107.128.77.rev.sfr.net ([77.128.107.220]:53860 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeDJVcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 17:32:21 -0400
From: Paul Kocialkowski <contact@paulk.fr>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 2/3] ARM: dts: sun7i: Add RGB666 pins definition
Date: Tue, 10 Apr 2018 23:31:28 +0200
Message-Id: <20180410213129.24049-2-contact@paulk.fr>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180410213129.24049-1-contact@paulk.fr>
References: <20180410213129.24049-1-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the pins definition for RGB666 LCD panels on the A20. It was
imported from the A33 definition, that concernes the same set of pins.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e529e4ff2174..f46af8675cfa 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -781,6 +781,14 @@
 				function = "ir1";
 			};
 
+			lcd_rgb666_pins: lcd_rgb666@0 {
+				pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
+				       "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
+				       "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
+				       "PD24", "PD25", "PD26", "PD27";
+				function = "lcd0";
+			};
+
 			mmc0_pins_a: mmc0@0 {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
-- 
2.16.3
