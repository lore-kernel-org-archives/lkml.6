Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D56C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 05:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E5C223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 05:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E5C223E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeHJHbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 03:31:01 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:42404 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbeHJHbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 03:31:01 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 7A5163469457DF6DC013;
        Fri, 10 Aug 2018 13:02:48 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w7A52kju008957;
        Fri, 10 Aug 2018 13:02:46 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018081013025408-3783401 ;
          Fri, 10 Aug 2018 13:02:54 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH] sched/fair : fix typos
Date:   Fri, 10 Aug 2018 21:18:14 +0800
Message-Id: <1533907094-66560-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-10 13:02:54,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-10 13:02:30,
        Serialize complete at 2018-08-10 13:02:30
X-MAIL: mse01.zte.com.cn w7A52kju008957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2f0a0be..b7ab23d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3315,7 +3315,7 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
  *
  * XXX collapse load_sum and runnable_load_sum
  *
- * cfq_rs:
+ * cfs_rq:
  *
  *   load_sum = \Sum se_weight(se) * se->avg.load_sum
  *   load_avg = \Sum se->avg.load_avg
-- 
1.8.3.1

