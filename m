Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeDHHA0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 03:00:26 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:44175 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeDHG76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 02:59:58 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
CC: Yixun Lan <yixun.lan@amlogic.com>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: interrupt-controller: New binding for Meson-AXG SoC
Date: Sun, 8 Apr 2018 14:56:59 +0000
Message-ID: <20180408145700.23520-3-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180408145700.23520-1-yixun.lan@amlogic.com>
References: <20180408145700.23520-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the dt-binding documentation to support new compatible string
for the GPIO interrupt controller which found in Amlogic's Meson-AXG SoC.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 .../devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
index c753d99d43db..89674ad8a097 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -14,6 +14,7 @@ Required properties:
     "amlogic,meson8b-gpio-intc" for meson8b SoCs (S805) or
     "amlogic,meson-gxbb-gpio-intc" for GXBB SoCs (S905) or
     "amlogic,meson-gxl-gpio-intc" for GXL SoCs (S905X, S912)
+    "amlogic,meson-axg-gpio-intc" for AXG SoCs (A113D, A113X)
 - interrupt-parent : a phandle to the GIC the interrupts are routed to.
    Usually this is provided at the root level of the device tree as it is
    common to most of the SoC.
-- 
2.16.2
