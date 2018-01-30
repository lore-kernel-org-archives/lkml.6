Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeA3Mkf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:40:35 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:38849 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751977AbeA3Mjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:39:41 -0500
From: Klaus Goger <klaus.goger@theobroma-systems.com>
To: linux-rockchip@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: [PATCH 1/4] dt-bindings: add RK3368-uQ7 SoM and EVK base board
Date: Tue, 30 Jan 2018 13:39:28 +0100
Message-Id: <20180130123931.50781-2-klaus.goger@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180130123931.50781-1-klaus.goger@theobroma-systems.com>
References: <20180130123931.50781-1-klaus.goger@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3368-uQ7 is a Qseven compatible system-on-module by Theobroma Systems.

This adds the module and the EVK baseboard "Haikou"

Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
---

 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index 326d24bca1a9..408b1761dbc3 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -185,6 +185,10 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "rockchip,rk3399-sapphire-excavator", "rockchip,rk3399";
 
+- Theobroma Systems RK3368-uQ7 Haikou Baseboard:
+    Required root node properties:
+      - compatible = "tsd,rk3368-uq7-haikou", "rockchip,rk3368";
+
 - Theobroma Systems RK3399-Q7 Haikou Baseboard:
     Required root node properties:
       - compatible = "tsd,rk3399-q7-haikou", "rockchip,rk3399";
-- 
2.11.0
