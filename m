Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934363AbeBMJhx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:37:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933937AbeBMJhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:37:47 -0500
Date: Tue, 13 Feb 2018 01:37:23 -0800
From: tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-387f77cc8249c847b4fa4d8c93694818b79efee3@git.kernel.org>
Cc: vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org, mingo@kernel.org, hpa@zytor.com
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, tglx@linutronix.de
In-Reply-To: <1518512382-29426-1-git-send-email-vincent.guittot@linaro.org>
References: <1518512382-29426-1-git-send-email-vincent.guittot@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Remove stray space in #ifdef
Git-Commit-ID: 387f77cc8249c847b4fa4d8c93694818b79efee3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  387f77cc8249c847b4fa4d8c93694818b79efee3
Gitweb:     https://git.kernel.org/tip/387f77cc8249c847b4fa4d8c93694818b79efee3
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Tue, 13 Feb 2018 09:59:42 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 10:32:36 +0100

sched/fair: Remove stray space in #ifdef

Remove a useless space in # ifdef and align it with others.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1518512382-29426-1-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5eb3ffc..820f94c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2823,7 +2823,7 @@ void reweight_task(struct task_struct *p, int prio)
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-# ifdef CONFIG_SMP
+#ifdef CONFIG_SMP
 /*
  * All this does is approximate the hierarchical proportion which includes that
  * global sum we all love to hate.
@@ -2974,7 +2974,7 @@ static long calc_group_runnable(struct cfs_rq *cfs_rq, long shares)
 
 	return clamp_t(long, runnable, MIN_SHARES, shares);
 }
-# endif /* CONFIG_SMP */
+#endif /* CONFIG_SMP */
 
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
 
