Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeDYHto (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:49:44 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:34332 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeDYHtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:49:41 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: panel: lvds: Fix path to display timing bindings
Date: Wed, 25 Apr 2018 09:49:38 +0200
Message-Id: <1524642578-2885-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 14da3ed8dd08c581 ("devicetree/bindings: display: Document common
panel properties")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/display/panel/panel-common.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.txt b/Documentation/devicetree/bindings/display/panel/panel-common.txt
index 557fa765adcb9450..5d2519af4bb5ca5e 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-common.txt
+++ b/Documentation/devicetree/bindings/display/panel/panel-common.txt
@@ -38,7 +38,7 @@ Display Timings
   require specific display timings. The panel-timing subnode expresses those
   timings as specified in the timing subnode section of the display timing
   bindings defined in
-  Documentation/devicetree/bindings/display/display-timing.txt.
+  Documentation/devicetree/bindings/display/panel/display-timing.txt.
 
 
 Connectivity
-- 
2.7.4
