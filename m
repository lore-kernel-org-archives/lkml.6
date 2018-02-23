Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeBWNlw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:41:52 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40006 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752200AbeBWNlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:41:49 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: arnd@arndb.de, geert@linux-m68k.org, horms@verge.net.au,
        magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] arm64: dts: renesas: r8a77965: Move usb2_phy1 up
Date: Fri, 23 Feb 2018 14:40:59 +0100
Message-Id: <1519393259-26108-8-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519393259-26108-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519393259-26108-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move "usb2_ph1" place-holder device node next to "usb2_phy0" one.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 0118956..8c9648a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -604,6 +604,11 @@
 			/* placeholder */
 		};
 
+		usb2_phy1: usb-phy@ee0a0200 {
+			reg = <0 0xee0a0200 0 0x700>;
+			/* placeholder */
+		};
+
 		ohci1: usb@ee0a0000 {
 			reg = <0 0xee0a0000 0 0x100>;
 			/* placeholder */
@@ -771,11 +776,6 @@
 			};
 		};
 
-		usb2_phy1: usb-phy@ee0a0200 {
-			reg = <0 0xee0a0200 0 0x700>;
-			/* placeholder */
-		};
-
 		sdhi0: sd@ee100000 {
 			reg = <0 0xee100000 0 0x2000>;
 			/* placeholder */
-- 
2.7.4
