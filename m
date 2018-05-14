Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeENUHS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:07:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:32948 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752027AbeENUFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:05:25 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH net-next v3 6/7] MIPS: mscc: connect phys to ports on ocelot_pcb123
Date: Mon, 14 May 2018 22:04:59 +0200
Message-Id: <20180514200500.2953-7-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
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
