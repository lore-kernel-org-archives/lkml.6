Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeBYNu7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 08:50:59 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50375 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbeBYNu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 08:50:56 -0500
X-Google-Smtp-Source: AH8x225NsdPArqLtPXT2G+of56KaRvhxj67KOxcwgWoYEdPM7l0PoziX9j1Db173YsuT7CDyD6q7ng==
Date: Sun, 25 Feb 2018 21:50:45 +0800
From: hao_zhang <hao5781286@gmail.com>
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, wens@csie.org, maxime.ripard@free-electrons.com,
        Claudiu.Beznea@microchip.com
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com,
        hao5781286@gmail.com
Subject: [PATCH v2 1/4] dt-bindings: pwm: binding allwinner sun8i.
Message-ID: <20180225135045.GA14508@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds allwinner sun8i pwm binding documents.

Signed-off-by: hao_zhang <hao5781286@gmail.com>
---
 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
new file mode 100644
index 0000000..e8c48be
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
@@ -0,0 +1,18 @@
+Allwinner sun8i R40/V40/T3 SoC PWM controller
+
+Required properties:
+  - compatible: should be one of:
+    - "allwinner,sun8i-r40-pwm"
+  - reg: physical base address and length of the controller's registers
+  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+    the cells format.
+  - clocks: From common clock binding, handle to the parent clock.
+
+Example:
+
+pwm: pwm@1c23400 {
+	     compatible = "allwinner,sun8i-pwm";
+	     reg = <0x01c23400 0x154>;
+	     clocks = <&osc24M>;
+	     #pwm-cells = <3>;
+};
-- 
2.7.4
