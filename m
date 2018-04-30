Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754006AbeD3Lmb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:42:31 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34382 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753910AbeD3Lm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:42:26 -0400
X-Google-Smtp-Source: AB8JxZoO8QwweoqkKmxkJ9rJX5NPXpC0/VPhjziO+QyFzjIQNOWp5dcHW3VBfS4bVY3r9IWFkbnmWQ==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 11/21] bindings: display: Add compatible for A64 Mixer1
Date: Mon, 30 Apr 2018 17:10:48 +0530
Message-Id: <20180430114058.5061-12-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180430114058.5061-1-jagan@amarulasolutions.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mixer1 on Allwinner A64 has similar behavior like Allwinner A83T.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 7dcd1d64dfe4..5d448ef2132f 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -313,6 +313,7 @@ Required properties:
     * allwinner,sun8i-a83t-de2-mixer-1
     * allwinner,sun8i-h3-de2-mixer-0
     * allwinner,sun8i-v3s-de2-mixer
+    * allwinner,sun50i-a64-de2-mixer-1
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the mixer
     * bus: the mixer interface clock
-- 
2.14.3
