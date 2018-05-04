Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeEDDGw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 23:06:52 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49023 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbeEDDGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 23:06:49 -0400
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andrew@lunn.ch, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: armada-xp-98dx: Add NAND pinctrl information
Date: Fri,  4 May 2018 15:06:38 +1200
Message-Id: <20180504030638.31521-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504030638.31521-1-chris.packham@alliedtelesis.co.nz>
References: <20180504030638.31521-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pin control information for the NAND interface on the Armada
98DX3236 and variants.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index 9a589abd0379..099dc2520082 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -312,6 +312,19 @@
 &pinctrl {
 	compatible = "marvell,98dx3236-pinctrl";
 
+	nand_pins: nand-pins {
+		marvell,pins = "mpp20", "mpp21", "mpp22",
+			       "mpp23", "mpp24", "mpp25",
+			       "mpp26", "mpp27", "mpp28",
+			       "mpp29", "mpp30";
+		marvell,function = "dev";
+	};
+
+	nand_rb: nand-rb {
+		marvell,pins = "mpp19";
+		marvell,function = "nand";
+	};
+
 	spi0_pins: spi0-pins {
 		marvell,pins = "mpp0", "mpp1",
 			       "mpp2", "mpp3";
-- 
2.17.0
