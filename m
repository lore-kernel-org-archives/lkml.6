Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757139AbeDZQ7e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:59:34 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58064 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756519AbeDZQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:53:54 -0400
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR RENESAS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/17] dt-bindings: display: renesas: du: Document the R8A77965 bindings
Date: Thu, 26 Apr 2018 17:53:31 +0100
Message-Id: <20180426165346.494-3-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 Documentation/devicetree/bindings/display/renesas,du.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt b/Documentation/devicetree/bindings/display/renesas,du.txt
index a36a6e7ee54f..7c6854bd0a04 100644
--- a/Documentation/devicetree/bindings/display/renesas,du.txt
+++ b/Documentation/devicetree/bindings/display/renesas,du.txt
@@ -13,6 +13,7 @@ Required Properties:
     - "renesas,du-r8a7794" for R8A7794 (R-Car E2) compatible DU
     - "renesas,du-r8a7795" for R8A7795 (R-Car H3) compatible DU
     - "renesas,du-r8a7796" for R8A7796 (R-Car M3-W) compatible DU
+    - "renesas,du-r8a77965" for R8A77965 (R-Car M3-N) compatible DU
     - "renesas,du-r8a77970" for R8A77970 (R-Car V3M) compatible DU
     - "renesas,du-r8a77995" for R8A77995 (R-Car D3) compatible DU
 
@@ -59,6 +60,7 @@ corresponding to each DU output.
  R8A7794 (R-Car E2)     DPAD 0         DPAD 1         -              -
  R8A7795 (R-Car H3)     DPAD 0         HDMI 0         HDMI 1         LVDS 0
  R8A7796 (R-Car M3-W)   DPAD 0         HDMI 0         LVDS 0         -
+ R8A77965 (R-Car M3-N)  DPAD 0         HDMI 0         LVDS 0         -
  R8A77970 (R-Car V3M)   DPAD 0         LVDS 0         -              -
  R8A77995 (R-Car D3)    DPAD 0         LVDS 0         LVDS 1         -
 
-- 
2.17.0
