Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094DFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF3221773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfBTCdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:33:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727085AbfBTCdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:33:39 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EE03EEBD6F25125E341A;
        Wed, 20 Feb 2019 10:33:36 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Feb 2019 10:33:30 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 08/12] net: hns3: fix 6th bit of ppp mpf abnormal errors
Date:   Wed, 20 Feb 2019 10:32:47 +0800
Message-ID: <1550629971-23999-9-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
References: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weihang Li <liweihang@hisilicon.com>

This patch modify print message of 6th bit of ppp mpf abnormal errors,
there is a extra letter e in it.

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index f0f1221..b9d363f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -80,7 +80,7 @@ static const struct hclge_hw_error hclge_ppp_mpf_abnormal_int_st1[] = {
 	{ .int_msk = BIT(3), .msg = "umv_key_mem1_ecc_mbit_err" },
 	{ .int_msk = BIT(4), .msg = "umv_key_mem2_ecc_mbit_err" },
 	{ .int_msk = BIT(5), .msg = "umv_key_mem3_ecc_mbit_err" },
-	{ .int_msk = BIT(6), .msg = "umv_ad_mem_ecc_mbit_erre" },
+	{ .int_msk = BIT(6), .msg = "umv_ad_mem_ecc_mbit_err" },
 	{ .int_msk = BIT(7), .msg = "rss_tc_mode_mem_ecc_mbit_err" },
 	{ .int_msk = BIT(8), .msg = "rss_idt_mem0_ecc_mbit_err" },
 	{ .int_msk = BIT(9), .msg = "rss_idt_mem1_ecc_mbit_err" },
-- 
2.7.4

