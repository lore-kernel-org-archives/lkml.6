Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681BDECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2569F2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2569F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeGPGwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:52:00 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:10624 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728440AbeGPGwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:52:00 -0400
X-Greylist: delayed 932 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2018 02:51:59 EDT
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 0C0521BB5669037925AD;
        Mon, 16 Jul 2018 14:10:42 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6G6ARnY023977;
        Mon, 16 Jul 2018 14:10:27 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018071614102923-500840 ;
          Mon, 16 Jul 2018 14:10:29 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tglx@linutronix.de
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Yi Wang <wang.yi59@zte.com.cn>
Subject: [PATCH] timer: Fix coding style
Date:   Mon, 16 Jul 2018 14:08:57 +0800
Message-Id: <1531721337-30284-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-16 14:10:29,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-16 14:10:27,
        Serialize complete at 2018-07-16 14:10:27
X-MAIL: mse01.zte.com.cn w6G6ARnY023977
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Wang <wang.yi59@zte.com.cn>

There are two tab at the end of function trigger_dyntick_cpu(),
so remove one and correct indentation.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index cc2d23e..baa528a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -581,7 +581,7 @@ static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
 	 * wheel:
 	 */
 	base->next_expiry = timer->expires;
-		wake_up_nohz_cpu(base->cpu);
+	wake_up_nohz_cpu(base->cpu);
 }
 
 static void
-- 
1.8.3.1

