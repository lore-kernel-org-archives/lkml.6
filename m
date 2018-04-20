Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754921AbeDTM5E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:57:04 -0400
Received: from mail3.emtrion.de ([80.150.99.69]:18380 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754591AbeDTM47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:56:59 -0400
From: <jan.tuerk@emtrion.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Fabio Estevam" <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "Jan Tuerk" <jan.tuerk@emtrion.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 3/6] dt-bindings: display: Document the EDT et* displays in one file.
Date: Fri, 20 Apr 2018 14:50:50 +0200
Message-ID: <20180420125108.14197-4-jan.tuerk@emtrion.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180420125108.14197-1-jan.tuerk@emtrion.com>
References: <20171220134710.64479-2-jan.tuerk@emtrion.com>
 <20180420125108.14197-1-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-11.0.0.4283-8.100.1062-23794.006
X-TM-AS-Result: No--10.228400-8.000000-31
X-TM-AS-MatchedID: 705441-700378-702796-702311-188019-700016-703529-704410-8
        47575-704425-700324-702900-704568-702890-712124-711139-702762-139504-148004
        -148036-42000-42003-55
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

Document the Emerging Display Technology Corp. (EDT) using the
simple-panel binding in one single file.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
 .../bindings/display/panel/edt,et-series.txt       | 39 ++++++++++++++++++++++
 .../bindings/display/panel/edt,et057090dhu.txt     |  7 ----
 .../bindings/display/panel/edt,et070080dh6.txt     | 10 ------
 .../bindings/display/panel/edt,etm0700g0dh6.txt    | 10 ------
 4 files changed, 39 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/edt,et-series.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt

diff --git a/Documentation/devicetree/bindings/display/panel/edt,et-series.txt b/Documentation/devicetree/bindings/display/panel/edt,et-series.txt
new file mode 100644
index 000000000000..f56b99ebd9be
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/edt,et-series.txt
@@ -0,0 +1,39 @@
+Emerging Display Technology Corp. Displays
+==========================================
+
+
+Display bindings for EDT Display Technology Corp. Displays which are
+compatible with the simple-panel binding, which is specified in
+simple-panel.txt
+
+
+5,7" WVGA TFT Panels
+--------------------
+
++-----------------+---------------------+-------------------------------------+
+| Identifier      | compatbile          | description                         |
++=================+=====================+=====================================+
+| ET057090DHU     | edt,et057090dhu     | 5.7" VGA TFT LCD panel              |
++-----------------+---------------------+-------------------------------------+
+
+
+7,0" WVGA TFT Panels
+--------------------
+
++-----------------+---------------------+-------------------------------------+
+| Identifier      | compatbile          | description                         |
++=================+=====================+=====================================+
+| ETM0700G0DH6    | edt,etm070080dh6    | WVGA TFT Display with capacitive    |
+|                 |                     | Touchscreen                         |
++-----------------+---------------------+-------------------------------------+
+| ETM0700G0BDH6   | edt,etm070080bdh6   | Same as ETM0700G0DH6 but with       |
+|                 |                     | inverted pixel clock.               |
++-----------------+---------------------+-------------------------------------+
+| ETM0700G0EDH6   | edt,etm070080edh6   | Same display as the ETM0700G0BDH6,  |
+|                 |                     | but with changed Hardware for the   |
+|                 |                     | backlight and the touch interface   |
++-----------------+---------------------+-------------------------------------+
+| ET070080DH6     | edt,etm070080dh6    | Same timings as the ETM0700G0DH6,   |
+|                 |                     | but with resistive touch.           |
++-----------------+---------------------+-------------------------------------+
+
diff --git a/Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt b/Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
deleted file mode 100644
index 4903d7b1d947..000000000000
--- a/Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-Emerging Display Technology Corp. 5.7" VGA TFT LCD panel
-
-Required properties:
-- compatible: should be "edt,et057090dhu"
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt b/Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
deleted file mode 100644
index 20cb38e836e4..000000000000
--- a/Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Emerging Display Technology Corp. ET070080DH6 7.0" WVGA TFT LCD panel
-
-Required properties:
-- compatible: should be "edt,et070080dh6"
-
-This panel is the same as ETM0700G0DH6 except for the touchscreen.
-ET070080DH6 is the model with resistive touch.
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
diff --git a/Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt b/Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt
deleted file mode 100644
index ee4b18053e40..000000000000
--- a/Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Emerging Display Technology Corp. ETM0700G0DH6 7.0" WVGA TFT LCD panel
-
-Required properties:
-- compatible: should be "edt,etm0700g0dh6"
-
-This panel is the same as ET070080DH6 except for the touchscreen.
-ETM0700G0DH6 is the model with capacitive multitouch.
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
-- 
2.11.0
