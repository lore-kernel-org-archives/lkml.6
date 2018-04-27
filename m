Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758869AbeD0Q5c (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:57:32 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53178 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758792AbeD0Q52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:57:28 -0400
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To: linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 01/11] dt-bindings: display: renesas: Add R-Car M3-N HDMI TX DT bindings
Date: Fri, 27 Apr 2018 17:57:12 +0100
Message-Id: <20180427165722.19445-2-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The M3-N HDMI TX controller is compatible with the M3-W and H3. No
extension to the DT bindings are needed.

Add an SoC-specific compatible string in case differences between the IP
versions are found later and require model-specific handling.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 .../devicetree/bindings/display/bridge/renesas,dw-hdmi.txt       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
index 3a72a103a18a..a41d280c3f9f 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
@@ -14,6 +14,7 @@ Required properties:
 - compatible : Shall contain one or more of
   - "renesas,r8a7795-hdmi" for R8A7795 (R-Car H3) compatible HDMI TX
   - "renesas,r8a7796-hdmi" for R8A7796 (R-Car M3-W) compatible HDMI TX
+  - "renesas,r8a77965-hdmi" for R8A77965 (R-Car M3-N) compatible HDMI TX
   - "renesas,rcar-gen3-hdmi" for the generic R-Car Gen3 compatible HDMI TX
 
     When compatible with generic versions, nodes must list the SoC-specific
-- 
2.17.0
