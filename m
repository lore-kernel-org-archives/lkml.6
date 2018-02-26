Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753754AbeBZOPZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:15:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50778 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753862AbeBZOPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:15:14 -0500
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, mw@semihalf.com,
        stefanc@marvell.com, ymarkman@marvell.com,
        thomas.petazzoni@free-electrons.com,
        gregory.clement@free-electrons.com, miquel.raynal@free-electrons.com,
        nadavh@marvell.com, maxime.chevallier@bootlin.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] net: mvpp2: align the ethtool ops definition
Date: Mon, 26 Feb 2018 15:14:27 +0100
Message-Id: <20180226141427.31536-3-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180226141427.31536-1-antoine.tenart@bootlin.com>
References: <20180226141427.31536-1-antoine.tenart@bootlin.com>
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
index 1a893ef70eab..babbb1ceba2a 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -7435,18 +7435,18 @@ static const struct net_device_ops mvpp2_netdev_ops = {
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
2.14.3
