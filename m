Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D975C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088382084A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfBBOk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 09:40:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2721 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbfBBOkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 09:40:52 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 895EAFDD63A56BBFBE0A;
        Sat,  2 Feb 2019 22:40:50 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.97.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Sat, 2 Feb 2019 22:40:40 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 01/12] net: hns3: fix a code style issue for hns3_update_new_int_gl()
Date:   Sat, 2 Feb 2019 22:39:26 +0800
Message-ID: <20190202143937.8924-2-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190202143937.8924-1-tanhuazhong@huawei.com>
References: <20190202143937.8924-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.97.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

Use the same code style for rx_group and tx_group in the
hns3_update_new_int_gl().

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index c546b874d659..1d3f167ee1e4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2880,7 +2880,7 @@ static void hns3_update_new_int_gl(struct hns3_enet_tqp_vector *tqp_vector)
 	}
 
 	if (tx_group->coal.gl_adapt_enable) {
-		tx_update = hns3_get_new_int_gl(&tqp_vector->tx_group);
+		tx_update = hns3_get_new_int_gl(tx_group);
 		if (tx_update)
 			hns3_set_vector_coalesce_tx_gl(tqp_vector,
 						       tx_group->coal.int_gl);
-- 
2.20.1


