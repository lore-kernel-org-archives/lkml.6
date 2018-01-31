Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753383AbeAaOe2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 09:34:28 -0500
Received: from mx1.mpynet.fi ([82.197.21.84]:53262 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752549AbeAaOe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:34:27 -0500
From: Aapo Vienamo <aapo@tuxera.com>
To: <devicetree@vger.kernel.org>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Ilya Ledvich" <ilya@compulab.co.il>, Aapo Vienamo <aapo@tuxera.com>
Subject: [RFC] ARM: dts: imx7d: cl-som-imx7: fix pinctrl_enet
Date: Wed, 31 Jan 2018 14:34:07 +0000
Message-ID: <20180131143407.8324-1-aapo@tuxera.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The missing last digit of the CONFIG values is added. Looks like a typo
of some sort when comparing to the downstream dt. This fixes
intermittent behavior behaviour of the ethernet controllers.

Signed-off-by: Aapo Vienamo <aapo@tuxera.com>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 52 ++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index ae45af1ad062..3cc1fb9ce441 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -213,37 +213,37 @@
 &iomuxc {
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
-			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x3
-			MX7D_PAD_SD2_WP__ENET1_MDC			0x3
-			MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC	0x1
-			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x1
-			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x1
-			MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2	0x1
-			MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3	0x1
-			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x1
-			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC	0x1
-			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x1
-			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x1
-			MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
-			MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
-			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
+			MX7D_PAD_SD2_CD_B__ENET1_MDIO			0x30
+			MX7D_PAD_SD2_WP__ENET1_MDC			0x30
+			MX7D_PAD_ENET1_RGMII_TXC__ENET1_RGMII_TXC	0x11
+			MX7D_PAD_ENET1_RGMII_TD0__ENET1_RGMII_TD0	0x11
+			MX7D_PAD_ENET1_RGMII_TD1__ENET1_RGMII_TD1	0x11
+			MX7D_PAD_ENET1_RGMII_TD2__ENET1_RGMII_TD2	0x11
+			MX7D_PAD_ENET1_RGMII_TD3__ENET1_RGMII_TD3	0x11
+			MX7D_PAD_ENET1_RGMII_TX_CTL__ENET1_RGMII_TX_CTL	0x11
+			MX7D_PAD_ENET1_RGMII_RXC__ENET1_RGMII_RXC	0x11
+			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x11
+			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x11
+			MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x11
+			MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x11
+			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x11
 		>;
 	};
 
 	pinctrl_enet2: enet2grp {
 		fsl,pins = <
-			MX7D_PAD_EPDC_GDSP__ENET2_RGMII_TXC		0x1
-			MX7D_PAD_EPDC_SDCE2__ENET2_RGMII_TD0		0x1
-			MX7D_PAD_EPDC_SDCE3__ENET2_RGMII_TD1		0x1
-			MX7D_PAD_EPDC_GDCLK__ENET2_RGMII_TD2		0x1
-			MX7D_PAD_EPDC_GDOE__ENET2_RGMII_TD3		0x1
-			MX7D_PAD_EPDC_GDRL__ENET2_RGMII_TX_CTL		0x1
-			MX7D_PAD_EPDC_SDCE1__ENET2_RGMII_RXC		0x1
-			MX7D_PAD_EPDC_SDCLK__ENET2_RGMII_RD0		0x1
-			MX7D_PAD_EPDC_SDLE__ENET2_RGMII_RD1		0x1
-			MX7D_PAD_EPDC_SDOE__ENET2_RGMII_RD2		0x1
-			MX7D_PAD_EPDC_SDSHR__ENET2_RGMII_RD3		0x1
-			MX7D_PAD_EPDC_SDCE0__ENET2_RGMII_RX_CTL		0x1
+			MX7D_PAD_EPDC_GDSP__ENET2_RGMII_TXC		0x11
+			MX7D_PAD_EPDC_SDCE2__ENET2_RGMII_TD0		0x11
+			MX7D_PAD_EPDC_SDCE3__ENET2_RGMII_TD1		0x11
+			MX7D_PAD_EPDC_GDCLK__ENET2_RGMII_TD2		0x11
+			MX7D_PAD_EPDC_GDOE__ENET2_RGMII_TD3		0x11
+			MX7D_PAD_EPDC_GDRL__ENET2_RGMII_TX_CTL		0x11
+			MX7D_PAD_EPDC_SDCE1__ENET2_RGMII_RXC		0x11
+			MX7D_PAD_EPDC_SDCLK__ENET2_RGMII_RD0		0x11
+			MX7D_PAD_EPDC_SDLE__ENET2_RGMII_RD1		0x11
+			MX7D_PAD_EPDC_SDOE__ENET2_RGMII_RD2		0x11
+			MX7D_PAD_EPDC_SDSHR__ENET2_RGMII_RD3		0x11
+			MX7D_PAD_EPDC_SDCE0__ENET2_RGMII_RX_CTL		0x11
 		>;
 	};
 
-- 
2.11.0
