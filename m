Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeERJrj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:47:39 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40176 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeERJrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:47:36 -0400
X-Google-Smtp-Source: AB8JxZqIQqRjfxMVNKfnQPd0MVZerQ3zF1xwVtdhbwQnfqBZViQCv0Vt+0n0xNlPbfr5YzkDeFokBA==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 14/26] dt-bindings: display: Add compatible for A64 HDMI
Date: Fri, 18 May 2018 15:15:24 +0530
Message-Id: <20180518094536.17201-15-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDMI on Allwinner A64 has similar like H3/H5/A83T.

Add compatible a64 and update A83T compatible as fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Add fallback compatible

 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 863afad6a4df..1a5ff416dea4 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -78,6 +78,7 @@ Required properties:
 
   - compatible: value must be one of:
     * "allwinner,sun8i-a83t-dw-hdmi"
+    * "allwinner,sun50i-a64-dw-hdmi", "allwinner,sun8i-a83t-dw-hdmi"
   - reg: base address and size of memory-mapped region
   - reg-io-width: See dw_hdmi.txt. Shall be 1.
   - interrupts: HDMI interrupt number
-- 
2.14.3
