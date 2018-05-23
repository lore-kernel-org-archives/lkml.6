Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932219AbeEWJoC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:44:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7739 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932237AbeEWJnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:43:53 -0400
From: "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
To: <dledford@redhat.com>, <jgg@ziepe.ca>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 rdma-next 2/4] RDMA/hns: Increase checking CMQ status timeout value
Date: Wed, 23 May 2018 18:16:28 +0800
Message-ID: <1527070590-94399-3-git-send-email-xavier.huwei@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527070590-94399-1-git-send-email-xavier.huwei@huawei.com>
References: <1527070590-94399-1-git-send-email-xavier.huwei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch increases checking CMQ status timeout value and
uses the same value with NIC driver to avoid deficiency of
time.

Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 182b672..f16df1b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -76,7 +76,7 @@
 #define HNS_ROCE_V2_PAGE_SIZE_SUPPORTED		0xFFFFF000
 #define HNS_ROCE_V2_MAX_INNER_MTPT_NUM		2
 #define HNS_ROCE_INVALID_LKEY			0x100
-#define HNS_ROCE_CMQ_TX_TIMEOUT			200
+#define HNS_ROCE_CMQ_TX_TIMEOUT			30000
 
 #define HNS_ROCE_CONTEXT_HOP_NUM		1
 #define HNS_ROCE_MTT_HOP_NUM			1
-- 
1.9.1
