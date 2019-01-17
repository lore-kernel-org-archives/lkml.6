Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223F5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF18F20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfAQNAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:00:08 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfAQNAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:00:08 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2CF2AB75ED296D5B3C3F;
        Thu, 17 Jan 2019 21:00:06 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Thu, 17 Jan 2019
 20:59:58 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <grygorii.strashko@ti.com>,
        <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: ethernet: ti: cpsw-phy-sel: remove unneeded semicolon
Date:   Thu, 17 Jan 2019 20:59:19 +0800
Message-ID: <20190117125919.15248-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded semicolon.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ti/cpsw-phy-sel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw-phy-sel.c b/drivers/net/ethernet/ti/cpsw-phy-sel.c
index 396e1cd..fec275e 100644
--- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
+++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
@@ -78,7 +78,7 @@ static void cpsw_gmii_sel_am3352(struct cpsw_phy_sel_priv *priv,
 	case PHY_INTERFACE_MODE_MII:
 		mode = AM33XX_GMII_SEL_MODE_MII;
 		break;
-	};
+	}
 
 	mask = GMII_SEL_MODE_MASK << (slave * 2) | BIT(slave + 6);
 	mask |= BIT(slave + 4);
@@ -133,7 +133,7 @@ static void cpsw_gmii_sel_dra7xx(struct cpsw_phy_sel_priv *priv,
 	case PHY_INTERFACE_MODE_MII:
 		mode = AM33XX_GMII_SEL_MODE_MII;
 		break;
-	};
+	}
 
 	switch (slave) {
 	case 0:
-- 
2.7.0


