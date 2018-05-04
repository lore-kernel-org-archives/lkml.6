Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbeEDOAR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:00:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60417 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751654AbeEDOAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:00:14 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 04/13] net: mvpp2: align the ethtool ops definition
Date: Fri,  4 May 2018 15:56:34 +0200
Message-Id: <20180504135643.23466-5-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cosmetic patch to align the ethtool functions to ops definitions. This
patch does not change in any way the driver's behaviour.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 6f410235987c..77dd91e3d962 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -7859,18 +7859,18 @@ static const struct net_device_ops mvpp2_netdev_ops = {
 };
 
 static const struct ethtool_ops mvpp2_eth_tool_ops = {
-	.nway_reset	= phy_ethtool_nway_reset,
-	.get_link	= ethtool_op_get_link,
-	.set_coalesce	= mvpp2_ethtool_set_coalesce,
-	.get_coalesce	= mvpp2_ethtool_get_coalesce,
-	.get_drvinfo	= mvpp2_ethtool_get_drvinfo,
-	.get_ringparam	= mvpp2_ethtool_get_ringparam,
-	.set_ringparam	= mvpp2_ethtool_set_ringparam,
-	.get_strings	= mvpp2_ethtool_get_strings,
-	.get_ethtool_stats = mvpp2_ethtool_get_stats,
-	.get_sset_count	= mvpp2_ethtool_get_sset_count,
-	.get_link_ksettings = phy_ethtool_get_link_ksettings,
-	.set_link_ksettings = phy_ethtool_set_link_ksettings,
+	.nway_reset		= phy_ethtool_nway_reset,
+	.get_link		= ethtool_op_get_link,
+	.set_coalesce		= mvpp2_ethtool_set_coalesce,
+	.get_coalesce		= mvpp2_ethtool_get_coalesce,
+	.get_drvinfo		= mvpp2_ethtool_get_drvinfo,
+	.get_ringparam		= mvpp2_ethtool_get_ringparam,
+	.set_ringparam		= mvpp2_ethtool_set_ringparam,
+	.get_strings		= mvpp2_ethtool_get_strings,
+	.get_ethtool_stats	= mvpp2_ethtool_get_stats,
+	.get_sset_count		= mvpp2_ethtool_get_sset_count,
+	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 };
 
 /* Used for PPv2.1, or PPv2.2 with the old Device Tree binding that
-- 
2.17.0
