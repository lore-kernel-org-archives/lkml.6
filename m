Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932767AbeD0TJa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:09:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33486 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932609AbeD0TJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:09:29 -0400
From: Colin King <colin.king@canonical.com>
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: systemport: fix spelling mistake: "asymetric" -> "asymmetric"
Date: Fri, 27 Apr 2018 20:09:25 +0100
Message-Id: <20180427190925.17097-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in netdev_warn warning message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index effc651a2a2f..54ad1171e75e 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2178,7 +2178,7 @@ static int bcm_sysport_map_queues(struct net_device *dev,
 
 	if (priv->per_port_num_tx_queues &&
 	    priv->per_port_num_tx_queues != num_tx_queues)
-		netdev_warn(slave_dev, "asymetric number of per-port queues\n");
+		netdev_warn(slave_dev, "asymmetric number of per-port queues\n");
 
 	priv->per_port_num_tx_queues = num_tx_queues;
 
-- 
2.17.0
