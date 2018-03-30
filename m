Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeC3RTh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 13:19:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58780 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbeC3RSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 13:18:41 -0400
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
Subject: [PATCHv3 5/8] dt-bindings: panel: common: document orientation property
Date: Fri, 30 Mar 2018 19:18:19 +0200
Message-Id: <20180330171822.25896-6-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge "rotation" property description into common panel
binding.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 .../devicetree/bindings/display/panel/panel-common.txt       | 12 ++++++++++++
 Documentation/devicetree/bindings/display/panel/panel.txt    |  4 ----
 2 files changed, 12 insertions(+), 4 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/panel.txt

diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.txt b/Documentation/devicetree/bindings/display/panel/panel-common.txt
index 557fa765adcb..46ff3c2d0811 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-common.txt
+++ b/Documentation/devicetree/bindings/display/panel/panel-common.txt
@@ -18,6 +18,18 @@ Descriptive Properties
   physical area where images are displayed. These properties are expressed in
   millimeters and rounded to the closest unit.
 
+- rotation: Display rotation in degrees counter clockwise (0,90,180,270).
+  The following values are possible:
+
+    0 = The top side of the panel matches the top side of the
+        device's casing (default).
+   90 = The top side of the panel matches the left side of the
+        device's casing.
+  180 = The top side of the panel matches the bottom side of
+        the device's casing. The panel is mounted upside-down.
+  270 = The top side of the panel matches the right side of
+        the device's casing.
+
 - label: The label property specifies a symbolic name for the panel as a
   string suitable for use by humans. It typically contains a name inscribed on
   the system (e.g. as an affixed label) or specified in the system's
diff --git a/Documentation/devicetree/bindings/display/panel/panel.txt b/Documentation/devicetree/bindings/display/panel/panel.txt
deleted file mode 100644
index e2e6867852b8..000000000000
--- a/Documentation/devicetree/bindings/display/panel/panel.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-Common display properties
--------------------------
-
-- rotation:	Display rotation in degrees counter clockwise (0,90,180,270)
-- 
2.16.2
