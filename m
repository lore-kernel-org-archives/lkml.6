Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968886AbeEXL1m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 07:27:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967768AbeEXL1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 07:27:37 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <fugang.duan@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: fec: remove stale comment
Date: Thu, 24 May 2018 19:27:07 +0800
Message-ID: <20180524112707.3580-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This comment is outdated as fec_ptp_ioctl has been replaced by fec_ptp_set/fec_ptp_get 
since commit 1d5244d0e43b ("fec: Implement the SIOCGHWTSTAMP ioctl")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index f814397..d438ef8 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -466,12 +466,6 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 	return -EOPNOTSUPP;
 }
 
-/**
- * fec_ptp_hwtstamp_ioctl - control hardware time stamping
- * @ndev: pointer to net_device
- * @ifreq: ioctl data
- * @cmd: particular ioctl requested
- */
 int fec_ptp_set(struct net_device *ndev, struct ifreq *ifr)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-- 
2.7.0
