Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162147AbeCAVfJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:35:09 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:33137 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162122AbeCAVfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:35:07 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 05/16] dt-bindings: display: sun4i-drm: Add compatibles for H3 HDMI pipeline
Date: Thu,  1 Mar 2018 22:34:31 +0100
Message-Id: <20180301213442.16677-6-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180301213442.16677-1-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing compatibles for H3 HDMI pipeline. These compatibles can also
be used with H5 SoC.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index b995bfee734a..8bdef4920edc 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -102,6 +102,7 @@ DWC HDMI PHY
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun8i-a83t-hdmi-phy
+    * allwinner,sun8i-h3-hdmi-phy
   - reg: base address and size of memory-mapped region
   - clocks: phandles to the clocks feeding the HDMI PHY
     * bus: the HDMI PHY interface clock
@@ -110,6 +111,9 @@ Required properties:
   - resets: phandle to the reset controller driving the PHY
   - reset-names: must be "phy"
 
+H3 HDMI PHY requires additional clock:
+  - pll-0: parent of phy clock
+
 TV Encoder
 ----------
 
@@ -275,6 +279,7 @@ Required properties:
   - compatible: value must be one of:
     * allwinner,sun8i-a83t-de2-mixer-0
     * allwinner,sun8i-a83t-de2-mixer-1
+    * allwinner,sun8i-h3-de2-mixer-0
     * allwinner,sun8i-v3s-de2-mixer
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the mixer
@@ -305,6 +310,7 @@ Required properties:
     * allwinner,sun7i-a20-display-engine
     * allwinner,sun8i-a33-display-engine
     * allwinner,sun8i-a83t-display-engine
+    * allwinner,sun8i-h3-display-engine
     * allwinner,sun8i-v3s-display-engine
 
   - allwinner,pipelines: list of phandle to the display engine
-- 
2.16.2
