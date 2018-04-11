Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeDKFRQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 01:17:16 -0400
Received: from mx57.baidu.com ([61.135.168.57]:47359 "EHLO
        tc-sys-mailedm02.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751734AbeDKFRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 01:17:14 -0400
From: Li RongQing <lirongqing@baidu.com>
To: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Subject: [PATCH] sched/fair: remove stale comments about tg_unthrottle_up
Date: Wed, 11 Apr 2018 13:16:56 +0800
Message-Id: <1523423816-18322-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.10.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 82958366cfea ("sched: Replace update_shares weight
distribution with per-entity computation"), tg_unthrottle_up
did not update the weight

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/sched/fair.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0951d1c58d2f..b885ed6fd97b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4703,7 +4703,6 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	       throttled_hierarchy(dest_cfs_rq);
 }
 
-/* updated child weight may affect parent so we have to do this bottom up */
 static int tg_unthrottle_up(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
-- 
2.11.0
