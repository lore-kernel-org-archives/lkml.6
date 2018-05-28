Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165061AbeE1MOK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422973AbeE1LD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:03:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aapo Vienamo <aapo@tuxera.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 490/496] ARM: dts: imx7d: cl-som-imx7: fix pinctrl_enet
Date: Mon, 28 May 2018 12:04:35 +0200
Message-Id: <20180528100340.538421558@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aapo Vienamo <aapo@tuxera.com>

[ Upstream commit 2bada7ac1fdcbf79a9689bd2ff65fa515ca7a31f ]

The missing last digit of the CONFIG values is added. Looks like a typo
of some sort when comparing to the downstream dt. This fixes
intermittent behavior behaviour of the ethernet controllers.

Signed-off-by: Aapo Vienamo <aapo@tuxera.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts |   52 ++++++++++++++++----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

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
 
