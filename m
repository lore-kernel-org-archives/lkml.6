Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeDHG77 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 02:59:59 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:44175 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeDHG75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 02:59:57 -0400
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
Subject: [PATCH 1/3] dt-bindings: interrupt-controller: fix the double quotes
Date: Sun, 8 Apr 2018 14:56:58 +0000
Message-ID: <20180408145700.23520-2-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180408145700.23520-1-yixun.lan@amlogic.com>
References: <20180408145700.23520-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double quotes seems not ASCII type, fix it here.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
index a83f9a5734ca..c753d99d43db 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -9,11 +9,11 @@ number of interrupt exposed depends on the SoC.
 
 Required properties:
 
-- compatible : must have "amlogic,meson8-gpio-intc” and either
-   “amlogic,meson8-gpio-intc” for meson8 SoCs (S802) or
-   “amlogic,meson8b-gpio-intc” for meson8b SoCs (S805) or
-   “amlogic,meson-gxbb-gpio-intc” for GXBB SoCs (S905) or
-   “amlogic,meson-gxl-gpio-intc” for GXL SoCs (S905X, S912)
+- compatible : must have "amlogic,meson8-gpio-intc" and either
+    "amlogic,meson8-gpio-intc" for meson8 SoCs (S802) or
+    "amlogic,meson8b-gpio-intc" for meson8b SoCs (S805) or
+    "amlogic,meson-gxbb-gpio-intc" for GXBB SoCs (S905) or
+    "amlogic,meson-gxl-gpio-intc" for GXL SoCs (S905X, S912)
 - interrupt-parent : a phandle to the GIC the interrupts are routed to.
    Usually this is provided at the root level of the device tree as it is
    common to most of the SoC.
-- 
2.16.2
