Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966105AbeCHTU7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:20:59 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41240 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934329AbeCHTU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:20:57 -0500
X-Google-Smtp-Source: AG47ELuFMCF3G2r00+kWWFAPsCT+3kdJsd7yZiw8IW2tkH8WGcLt8/2d3bswGZ8h3JbPgLsksJ4qTA==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: backlight: Add binding for RAVE SP backlight driver
Date: Thu,  8 Mar 2018 11:20:46 -0800
Message-Id: <20180308192046.27670-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308192046.27670-1-andrew.smirnov@gmail.com>
References: <20180308192046.27670-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Tree bindings for RAVE SP backlight driver - an MFD cell of
parent RAVE SP driver (documented in
Documentation/devicetree/bindings/mfd/zii,rave-sp.txt).

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Aleksander Morgado <aleksander@aleksander.es>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since [v1]:

 - Fixed typos in commit message and incorrect node name in example section

[v1] https://lkml.kernel.org/r/20180307024011.25033-2-andrew.smirnov@gmail.com

 .../leds/backlight/zii,rave-sp-backlight.txt       | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt

diff --git a/Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
new file mode 100644
index 000000000000..ff5c92138650
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/zii,rave-sp-backlight.txt
@@ -0,0 +1,23 @@
+Zodiac Inflight Innovations RAVE Supervisory Processor Backlight Bindings
+
+RAVE SP backlight device is a "MFD cell" device corresponding to
+backlight functionality of RAVE Supervisory Processor. It is expected
+that its Device Tree node is specified as a child of the node
+corresponding to the parent RAVE SP device (as documented in
+Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
+
+Required properties:
+
+- compatible: Should be "zii,rave-sp-backlight"
+
+Example:
+
+	rave-sp {
+		compatible = "zii,rave-sp-rdu1";
+		current-speed = <38400>;
+
+		backlight {
+			compatible = "zii,rave-sp-backlight";
+		};
+	}
+
-- 
2.14.3
