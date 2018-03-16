Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbeCPRzW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:55:22 -0400
Received: from hermes.aosc.io ([199.195.250.187]:52724 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752302AbeCPRzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:55:19 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/7] dt-bindings: add compatible string for the A64 DE2 CCU
Date: Sat, 17 Mar 2018 01:53:48 +0800
Message-Id: <20180316175354.21437-2-icenowy@aosc.io>
In-Reply-To: <20180316175354.21437-1-icenowy@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner A64 SoC has a DE2 CCU like the one in the DE2 of Allwinner
H5 SoC.

Add a compatible string for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/clock/sun8i-de2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/sun8i-de2.txt b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
index f2fa87c4765c..e94582e8b8a9 100644
--- a/Documentation/devicetree/bindings/clock/sun8i-de2.txt
+++ b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
@@ -6,6 +6,7 @@ Required properties :
 		- "allwinner,sun8i-a83t-de2-clk"
 		- "allwinner,sun8i-h3-de2-clk"
 		- "allwinner,sun8i-v3s-de2-clk"
+		- "allwinner,sun50i-a64-de2-clk"
 		- "allwinner,sun50i-h5-de2-clk"
 
 - reg: Must contain the registers base address and length
-- 
2.15.1
