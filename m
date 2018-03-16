Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeCPKfp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:35:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35008 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753450AbeCPKfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:35:41 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 04/10] phy: add 2.5G SGMII mode to the phy_mode enum
Date: Fri, 16 Mar 2018 11:33:45 +0100
Message-Id: <20180316103351.16616-5-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180316103351.16616-1-antoine.tenart@bootlin.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds one more generic PHY mode to the phy_mode enum, to allow
configuring generic PHYs to the 2.5G SGMII mode by using the set_mode
callback.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 include/linux/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 4f8423a948d5..5a80e9de3686 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -28,6 +28,7 @@ enum phy_mode {
 	PHY_MODE_USB_DEVICE,
 	PHY_MODE_USB_OTG,
 	PHY_MODE_SGMII,
+	PHY_MODE_2500SGMII,
 	PHY_MODE_10GKR,
 	PHY_MODE_UFS_HS_A,
 	PHY_MODE_UFS_HS_B,
-- 
2.14.3
