Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752490AbeEQIae (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:30:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41827 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752392AbeEQIa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:30:29 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v3 03/10] phy: add 2.5G SGMII mode to the phy_mode enum
Date: Thu, 17 May 2018 10:29:32 +0200
Message-Id: <20180517082939.14598-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517082939.14598-1-antoine.tenart@bootlin.com>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds one more generic PHY mode to the phy_mode enum, to allow
configuring generic PHYs to the 2.5G SGMII mode by using the set_mode
callback.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index c9d14eeee7f5..9713aebdd348 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -36,6 +36,7 @@ enum phy_mode {
 	PHY_MODE_USB_DEVICE_SS,
 	PHY_MODE_USB_OTG,
 	PHY_MODE_SGMII,
+	PHY_MODE_2500SGMII,
 	PHY_MODE_10GKR,
 	PHY_MODE_UFS_HS_A,
 	PHY_MODE_UFS_HS_B,
-- 
2.17.0
