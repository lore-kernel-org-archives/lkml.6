Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933352AbeCGCCc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 21:02:32 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35062 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbeCGCC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 21:02:28 -0500
X-Google-Smtp-Source: AG47ELuk4M9cl0VEUdWJwbZmjhYgIKoYl86JbnD79/uhznDz80K+Z+7uhhT7IHdhejJag0FbChEG1A==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH v3 2/2] dt-bindings: input: Add binding for RAVE SP input driver
Date: Tue,  6 Mar 2018 18:01:34 -0800
Message-Id: <20180307020134.26293-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180307020134.26293-1-andrew.smirnov@gmail.com>
References: <20180307020134.26293-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Tree bindings for RAVE SP input drvier - an MFD cell of
parent RAVE SP driver (documented in
Documentation/devicetree/bindings/mfd/zii,rave-sp.txt).

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since [v2]:

	- Collected Acked-by from Lucas

	- Removed unnecessary status="okay"

No changes between v1 and v2, so v1 is not referenced here.

[v2] lkml.kernel.org/r/20180301165527.22274-2-andrew.smirnov@gmail.com

 .../bindings/input/zii,rave-sp-pwrbutton.txt       | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt

diff --git a/Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt b/Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
new file mode 100644
index 000000000000..b217018d03e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
@@ -0,0 +1,23 @@
+Zodiac Inflight Innovations RAVE Supervisory Processor Power Button Bindings
+
+RAVE SP input device is a "MFD cell" device corresponding to power
+button functionality of RAVE Supervisory Processor. It is expected
+that its Device Tree node is specified as a child of the node
+corresponding to the parent RAVE SP device (as documented in
+Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
+
+Required properties:
+
+- compatible: Should be "zii,rave-sp-pwrbutton"
+
+Example:
+
+	rave-sp {
+		compatible = "zii,rave-sp-rdu1";
+		current-speed = <38400>;
+
+		pwrbutton {
+			compatible = "zii,rave-sp-pwrbutton";
+		};
+	}
+
-- 
2.14.3
