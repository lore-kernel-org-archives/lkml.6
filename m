Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756891AbeDZUBU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:01:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35293 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755811AbeDZT7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 15:59:40 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH net-next v2 6/7] MIPS: mscc: connect phys to ports on ocelot_pcb123
Date: Thu, 26 Apr 2018 21:59:30 +0200
Message-Id: <20180426195931.5393-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
References: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add phy to switch port connections for PCB123 for internal PHYs.

Cc: James Hogan <jhogan@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
index 29d6414f8886..4ccd65379059 100644
--- a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
+++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
@@ -25,3 +25,23 @@
 &uart2 {
 	status = "okay";
 };
+
+&mdio0 {
+	status = "okay";
+};
+
+&port0 {
+	phy-handle = <&phy0>;
+};
+
+&port1 {
+	phy-handle = <&phy1>;
+};
+
+&port2 {
+	phy-handle = <&phy2>;
+};
+
+&port3 {
+	phy-handle = <&phy3>;
+};
-- 
2.17.0
