Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933853AbeBMI7v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 03:59:51 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36754 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933740AbeBMI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 03:59:50 -0500
X-Google-Smtp-Source: AH8x227ckZO+NpFDcdamI9c8pLl5bF5ElvHDRvOe9hVdSG1xomHYNRv7BYtWGedJZ8EjA5moJ0v0bg==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched: typo: remove space in #ifdef
Date: Tue, 13 Feb 2018 09:59:42 +0100
Message-Id: <1518512382-29426-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a useless space in # ifdef and align it with others

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1070803..cad1932 100644
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
 
-- 
2.7.4
