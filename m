Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbeEGWFT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 18:05:19 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:42904 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753003AbeEGWFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 18:05:18 -0400
From: Paul Kocialkowski <contact@paulk.fr>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v4 2/3] ARM: dts: sun7i: Add RGB666 pins definition
Date: Tue,  8 May 2018 00:04:12 +0200
Message-Id: <20180507220413.21990-2-contact@paulk.fr>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180507220413.21990-1-contact@paulk.fr>
References: <20180507220413.21990-1-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the pins definition for RGB666 LCD panels on the A20. It was
inspired by the A33 definition, that concernes the same set of pins.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e529e4ff2174..b3ee36cd7fa7 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -781,6 +781,14 @@
 				function = "ir1";
 			};
 
+			lcd0_rgb666_pins: lcd0-rgb666 {
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
2.17.0
