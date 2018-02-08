Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeBHSb2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:31:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48684 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeBHSbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:31:04 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 7/8] ARM: dts: omap4-droid4: Add LCD panel orientation property
Date: Thu,  8 Feb 2018 19:30:34 +0100
Message-Id: <20180208183035.8461-8-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
References: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a LCD panel orientation hint to the Droid 4. If the
display is rotated this way the keyboard can be used properly.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index b21084da490b..e11a24397163 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/display/common.h>
 #include "omap443x.dtsi"
 #include "motorola-cpcap-mapphone.dtsi"
 
@@ -181,6 +182,8 @@
 		height-mm = <89>;
 		backlight = <&lcd_backlight>;
 
+		orientation = <PANEL_ORIENTATION_RIGHT_UP>;
+
 		panel-timing {
 			clock-frequency = <0>;		/* Calculated by dsi */
 
-- 
2.15.1
