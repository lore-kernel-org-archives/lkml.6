Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeBQUpr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 15:45:47 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36394 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeBQUpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 15:45:41 -0500
X-Google-Smtp-Source: AH8x224mslIYtoJvgNj1cwoQjAVbtEoOipkaQ4QBet0dFqhGbVUZvNKK4JHsk7Ios3+BbSYpjTqYuw==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 05/10] dt-bindings: gpio: Add gpio nodes for Actions S900 SoC
Date: Sun, 18 Feb 2018 02:14:28 +0530
Message-Id: <20180217204433.3095-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio nodes for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/gpio/actions,owl-gpio.txt         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
new file mode 100644
index 000000000000..4cd4cb7bfd1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
@@ -0,0 +1,15 @@
+* Actions Semi OWL GPIO controller bindings
+
+- compatible      : Should be "actions,s900-gpio"
+- reg             : Address and range of the GPIO controller registers.
+- gpio-controller : Marks the device node as a GPIO controller.
+- #gpio-cells     : Should be <2>. The first cell is the gpio number and
+                    the second cell is used to specify optional parameters.
+
+Example:
+       gpio: gpio@e01b0000 {
+               compatible = "actions,s900-gpio";
+               reg = <0x0 0xe01b0000 0x0 0x1000>;
+               gpio-controller;
+               #gpio-cells = <2>;
+       };
-- 
2.14.1
