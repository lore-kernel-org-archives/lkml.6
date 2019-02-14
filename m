Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A418FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD0E222CF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405819AbfBNGkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:40:04 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:34572 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbfBNGkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:40:04 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 7B944A431C371AD1231F;
        Thu, 14 Feb 2019 14:39:52 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1E6di54049397;
        Thu, 14 Feb 2019 14:39:44 +0800 (GMT-8)
        (envelope-from huang.zijiang@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019021414401401-26035457 ;
          Thu, 14 Feb 2019 14:40:14 +0800 
From:   Huang Zijiang <huang.zijiang@zte.com.cn>
To:     davem@davemloft.net
Cc:     quentin.monnet@netronome.com, jakub.kicinski@netronome.com,
        henrik@austad.us, dsahern@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: [PATCH] net:dl2k: Modify the code style escaping the warning
Date:   Thu, 14 Feb 2019 14:40:31 +0800
Message-Id: <1550126431-28152-1-git-send-email-huang.zijiang@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-14 14:40:14,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-14 14:39:32,
        Serialize complete at 2019-02-14 14:39:32
X-MAIL: mse01.zte.com.cn x1E6di54049397
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modify the code style in order to removing the following warning
when excute the script checkpatch.pl
WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
---
 drivers/net/ethernet/dlink/dl2k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index f0536b1..228654a 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -843,9 +843,9 @@ rio_free_tx (struct net_device *dev, int irq)
 				  desc_to_dma(&np->tx_ring[entry]),
 				  skb->len, PCI_DMA_TODEVICE);
 		if (irq)
-			dev_kfree_skb_irq (skb);
+			dev_kfree_skb_irq(skb);
 		else
-			dev_kfree_skb (skb);
+			dev_kfree_skb(skb);
 
 		np->tx_skbuff[entry] = NULL;
 		entry = (entry + 1) % TX_RING_SIZE;
-- 
1.8.3.1

