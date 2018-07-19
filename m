Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7DEC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9B720673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9B720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbeGSPbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:31:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731847AbeGSPbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:31:48 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4CF49F04FAFC1;
        Thu, 19 Jul 2018 22:47:59 +0800 (CST)
Received: from S00293818-DELL1.huawei.com (10.202.226.54) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 19 Jul 2018 22:47:54 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 3/9] net: hns3: Remove extra space and brackets
Date:   Thu, 19 Jul 2018 15:47:00 +0100
Message-ID: <20180719144706.644-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180719144706.644-1-salil.mehta@huawei.com>
References: <20180719144706.644-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

Remove extra space and brackets.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 656c3e6..e66a762 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -37,7 +37,7 @@ struct hclge_cmq_ring {
 	dma_addr_t desc_dma_addr;
 	struct hclge_desc *desc;
 	struct hclge_desc_cb *desc_cb;
-	struct hclge_dev  *dev;
+	struct hclge_dev *dev;
 	u32 head;
 	u32 tail;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index cca5b2f..b097988 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4288,7 +4288,7 @@ static int hclge_add_mc_addr(struct hnae3_handle *handle,
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 
-	return	hclge_add_mc_addr_common(vport, addr);
+	return hclge_add_mc_addr_common(vport, addr);
 }
 
 int hclge_add_mc_addr_common(struct hclge_vport *vport,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index a5abf8e..b01a51d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -77,11 +77,11 @@
 /* Copper Specific Status Register */
 #define HCLGE_PHY_CSS_REG		17
 
-#define HCLGE_PHY_MDIX_CTRL_S		(5)
+#define HCLGE_PHY_MDIX_CTRL_S		5
 #define HCLGE_PHY_MDIX_CTRL_M		GENMASK(6, 5)
 
-#define HCLGE_PHY_MDIX_STATUS_B	(6)
-#define HCLGE_PHY_SPEED_DUP_RESOLVE_B	(11)
+#define HCLGE_PHY_MDIX_STATUS_B		6
+#define HCLGE_PHY_SPEED_DUP_RESOLVE_B	11
 
 /* Factor used to calculate offset and bitmap of VF num */
 #define HCLGE_VF_NUM_PER_CMD           64
-- 
2.7.4


