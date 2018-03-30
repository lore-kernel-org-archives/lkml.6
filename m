Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeC3RTD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 13:19:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58824 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbeC3RSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 13:18:48 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv3 8/8] ARM: dts: omap4-droid4: Add LCD panel rotation property
Date: Fri, 30 Mar 2018 19:18:22 +0200
Message-Id: <20180330171822.25896-9-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a LCD panel rotation hint to the Droid 4. If the
display is rotated this way the keyboard can be used properly.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
index bdf73cbcec3a..3ed090a9db6c 100644
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -214,6 +214,7 @@
 
 		width-mm = <50>;
 		height-mm = <89>;
+		rotation = <90>;
 		backlight = <&lcd_backlight>;
 
 		panel-timing {
-- 
2.16.2
