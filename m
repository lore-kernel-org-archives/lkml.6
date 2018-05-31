Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754985AbeEaLvp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:51:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754950AbeEaLvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:51:41 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <anirudh@xilinx.com>, <John.Linn@xilinx.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: axienet: remove stale comment of axienet_open
Date: Thu, 31 May 2018 19:51:15 +0800
Message-ID: <20180531115115.11920-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

axienet_open no longer return -ENODEV when PHY cannot be connected to
since commit d7cc3163e026 ("net: axienet: Support phy-less mode of operation")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index e74e1e8..f24f48f 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -900,7 +900,6 @@ static void axienet_dma_err_handler(unsigned long data);
  * @ndev:	Pointer to net_device structure
  *
  * Return: 0, on success.
- *	    -ENODEV, if PHY cannot be connected to
  *	    non-zero error value on failure
  *
  * This is the driver open routine. It calls phy_start to start the PHY device.
-- 
2.7.0
