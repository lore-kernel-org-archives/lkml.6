Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24CBC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B9820854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfAVOh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:37:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58614 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfAVOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:37:58 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1glxBb-0007ng-Ul; Tue, 22 Jan 2019 14:37:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: amd8111e: clean up two minor indentation issues
Date:   Tue, 22 Jan 2019 14:37:55 +0000
Message-Id: <20190122143755.32527-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Two statements are incorrecly indented, fix these by removing a space.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/amd/amd8111e.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/amd8111e.c b/drivers/net/ethernet/amd/amd8111e.c
index a90080f12e67..b9632928496e 100644
--- a/drivers/net/ethernet/amd/amd8111e.c
+++ b/drivers/net/ethernet/amd/amd8111e.c
@@ -435,7 +435,7 @@ static int amd8111e_restart(struct net_device *dev)
 	int i,reg_val;
 
 	/* stop the chip */
-	 writel(RUN, mmio + CMD0);
+	writel(RUN, mmio + CMD0);
 
 	if(amd8111e_init_ring(dev))
 		return -ENOMEM;
@@ -1720,7 +1720,7 @@ static void amd8111e_config_ipg(struct timer_list *t)
 		writew((u32)tmp_ipg, mmio + IPG);
 		writew((u32)(tmp_ipg - IFS1_DELTA), mmio + IFS1);
 	}
-	 mod_timer(&lp->ipg_data.ipg_timer, jiffies + IPG_CONVERGE_JIFFIES);
+	mod_timer(&lp->ipg_data.ipg_timer, jiffies + IPG_CONVERGE_JIFFIES);
 	return;
 
 }
-- 
2.19.1

