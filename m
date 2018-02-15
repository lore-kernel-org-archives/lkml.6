Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755313AbeBOIis (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 03:38:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755293AbeBOIin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 03:38:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012BD217C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=kbingham@kernel.org
From: Kieran Bingham <kbingham@kernel.org>
To: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>, geert@glider.be,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/8] dt-bindings: display: renesas,lvds: Add LVDS binding for D3
Date: Thu, 15 Feb 2018 08:38:18 +0000
Message-Id: <1518683903-10681-4-git-send-email-kbingham@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

The D3 supports two LVDS channels. Extend the binding to support them.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
index 79860f58a7ad..0dcf488b70df 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
@@ -14,6 +14,7 @@ Required properties:
 - compatible : Shall contain one of
   - "renesas,lvds-r8a7795" for R8A7795 (R-Car H3) compatible LVDS encoders
   - "renesas,lvds-r8a7796" for R8A7796 (R-Car M3-W) compatible LVDS encoders
+  - "renesas,lvds-r8a77995" for R8A77995 (R-Car D3) compatible LVDS encoders
 
 - reg: Base address and length for the memory-mapped registers
 - clocks: A phandle + clock-specifier pair for the functional clock
-- 
2.7.4
