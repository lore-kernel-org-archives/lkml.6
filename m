Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeBVTHp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:07:45 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53064 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeBVTGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:06:49 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: arnd@arndb.de, geert@linux-m68k.org, horms@verge.net.au,
        magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arm64: dts: renesas: r8a77965: Add #phy-cells property
Date: Thu, 22 Feb 2018 20:06:08 +0100
Message-Id: <1519326370-15805-5-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "#phy-cells" property to "usb-phy@e65ee000" device node.

This silences the following DTC compiler warning:
Warning (phys_property): Missing property '#phy-cells' in node
/soc/usb-phy@e65ee000 or bad phandle (referred from
/soc/usb@ee020000:phys[0])

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index be4f25c..cd12176 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -795,6 +795,7 @@
 
 		usb3_phy0: usb-phy@e65ee000 {
 			reg = <0 0xe65ee000 0 0x90>;
+			#phy-cells = <0>;
 			/* placeholder */
 		};
 
-- 
2.7.4
