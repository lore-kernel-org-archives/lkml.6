Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932989AbeBVPXk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:23:40 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:37618 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932796AbeBVPXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:23:38 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Jesper Nilsson <jespern@axis.com>, Lars Persson <larper@axis.com>,
        Niklas Cassel <niklass@axis.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@axis.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pinctrl: artpec6: add missing pin group uart5nocts
Date: Thu, 22 Feb 2018 16:22:46 +0100
Message-Id: <20180222152247.10554-1-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing pin group uart5nocts (all pins except cts), which has been
supported by the artpec6 pinctrl driver since its initial submission.

Fixes: 00df0582eab1 ("pinctrl: Add pincontrol driver for ARTPEC-6 SoC")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
index 47284f85ec80..c3f9826692bc 100644
--- a/Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
@@ -20,7 +20,8 @@ Required subnode-properties:
 		gpio: cpuclkoutgrp0, udlclkoutgrp0, i2c1grp0, i2c2grp0,
 		      i2c3grp0, i2s0grp0, i2s1grp0, i2srefclkgrp0, spi0grp0,
 		      spi1grp0, pciedebuggrp0, uart0grp0, uart0grp1, uart1grp0,
-		      uart2grp0, uart2grp1, uart3grp0, uart4grp0, uart5grp0
+		      uart2grp0, uart2grp1, uart3grp0, uart4grp0, uart5grp0,
+		      uart5nocts
 		cpuclkout: cpuclkoutgrp0
 		udlclkout: udlclkoutgrp0
 		i2c1: i2c1grp0
@@ -37,7 +38,7 @@ Required subnode-properties:
 		uart2: uart2grp0, uart2grp1
 		uart3: uart3grp0
 		uart4: uart4grp0
-		uart5: uart5grp0
+		uart5: uart5grp0, uart5nocts
 		nand: nandgrp0
 		sdio0: sdio0grp0
 		sdio1: sdio1grp0
-- 
2.14.2
