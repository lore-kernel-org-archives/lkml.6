Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbeFCIKR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 04:10:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54088 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750847AbeFCIKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 04:10:16 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <linus.walleij@linaro.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: gemini: fix spelling mistake: "it" -> "is"
Date: Sun, 3 Jun 2018 16:10:01 +0800
Message-ID: <20180603081001.23396-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix to spelling mistake in gemini dev_warn message

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/cortina/gemini.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index bd3f6e4..ff9eb45 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -539,7 +539,7 @@ static int gmac_setup_txqs(struct net_device *netdev)
 	}
 
 	if (port->txq_dma_base & ~DMA_Q_BASE_MASK) {
-		dev_warn(geth->dev, "TX queue base it not aligned\n");
+		dev_warn(geth->dev, "TX queue base is not aligned\n");
 		kfree(skb_tab);
 		return -ENOMEM;
 	}
@@ -680,7 +680,7 @@ static int gmac_setup_rxq(struct net_device *netdev)
 	if (!port->rxq_ring)
 		return -ENOMEM;
 	if (port->rxq_dma_base & ~NONTOE_QHDR0_BASE_MASK) {
-		dev_warn(geth->dev, "RX queue base it not aligned\n");
+		dev_warn(geth->dev, "RX queue base is not aligned\n");
 		return -ENOMEM;
 	}
 
@@ -905,7 +905,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	if (!geth->freeq_ring)
 		return -ENOMEM;
 	if (geth->freeq_dma_base & ~DMA_Q_BASE_MASK) {
-		dev_warn(geth->dev, "queue ring base it not aligned\n");
+		dev_warn(geth->dev, "queue ring base is not aligned\n");
 		goto err_freeq;
 	}
 
-- 
2.7.0
