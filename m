Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeBSKrV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:47:21 -0500
Received: from smtprelay09.ispgateway.de ([134.119.228.114]:56539 "EHLO
        smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbeBSKrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:47:19 -0500
From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Cc: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH] ARM: dts: imx6dl: remove 'lcdif' node
Date: Mon, 19 Feb 2018 11:47:05 +0100
Message-Id: <1519037225-22872-1-git-send-email-LW@KARO-electronics.de>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the "i.MX 6Solo/6DualLite Applications Processor
Reference Manual" Rev. 3, 09/2017 there is no LCDIF unit on the
i.MX6DL.

Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6dl.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index c01674f..d9c502a 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -80,11 +80,6 @@
 				reg = <0x020f4000 0x4000>;
 				interrupts = <0 97 IRQ_TYPE_LEVEL_HIGH>;
 			};
-
-			lcdif: lcdif@20f8000 {
-				reg = <0x020f8000 0x4000>;
-				interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
-			};
 		};
 
 		aips2: aips-bus@2100000 {
-- 
2.1.4
