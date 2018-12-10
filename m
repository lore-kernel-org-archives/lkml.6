Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D16C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C5A20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C5A20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeLJJ3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:29:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60922 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeLJJ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:29:54 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gWHsr-0006gH-09; Mon, 10 Dec 2018 09:29:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Shiju Jose <shiju.jose@huawei.com>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][net-next] net: hns3: fix spelling mistake "offser" -> "offset"
Date:   Mon, 10 Dec 2018 09:29:48 +0000
Message-Id: <20181210092948.4244-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a msg string, fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 77deea0beeba..d0f654123b9b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -183,7 +183,7 @@ static const struct hclge_hw_error hclge_qcn_fifo_rint[] = {
 	{ .int_msk = BIT(6), .msg = "qcn_shap_gp3_sch_fifo_rd_err" },
 	{ .int_msk = BIT(7), .msg = "qcn_shap_gp3_sch_fifo_wr_err" },
 	{ .int_msk = BIT(8), .msg = "qcn_shap_gp0_offset_fifo_rd_err" },
-	{ .int_msk = BIT(9), .msg = "qcn_shap_gp0_offser_fifo_wr_err" },
+	{ .int_msk = BIT(9), .msg = "qcn_shap_gp0_offset_fifo_wr_err" },
 	{ .int_msk = BIT(10), .msg = "qcn_shap_gp1_offset_fifo_rd_err" },
 	{ .int_msk = BIT(11), .msg = "qcn_shap_gp1_offset_fifo_wr_err" },
 	{ .int_msk = BIT(12), .msg = "qcn_shap_gp2_offset_fifo_rd_err" },
-- 
2.19.1

