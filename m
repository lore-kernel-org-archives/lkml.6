Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58063ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6DE20840
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6DE20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeGOX6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:58:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56661 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOX6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:58:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNXfpx922148
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:33:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNXfQ8922145;
        Sun, 15 Jul 2018 16:33:41 -0700
Date:   Sun, 15 Jul 2018 16:33:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-5fd778915ad29184a5ff8eb82d1118f6916b79e4@git.kernel.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        mcgrof@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        vincent.guittot@linaro.org
Reply-To: mcgrof@kernel.org, vincent.guittot@linaro.org,
          tglx@linutronix.de, mingo@kernel.org,
          torvalds@linux-foundation.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, keescook@chromium.org,
          hpa@zytor.com
In-Reply-To: <1530200714-4504-12-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-12-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/sysctl: Remove unused sched_time_avg_ms
 sysctl
Git-Commit-ID: 5fd778915ad29184a5ff8eb82d1118f6916b79e4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5fd778915ad29184a5ff8eb82d1118f6916b79e4
Gitweb:     https://git.kernel.org/tip/5fd778915ad29184a5ff8eb82d1118f6916b79e4
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Thu, 28 Jun 2018 17:45:14 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:16:29 +0200

sched/sysctl: Remove unused sched_time_avg_ms sysctl

/proc/sys/kernel/sched_time_avg_ms entry is not used anywhere,
remove it.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten.Rasmussen@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: claudio@evidence.eu.com
Cc: daniel.lezcano@linaro.org
Cc: dietmar.eggemann@arm.com
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: luca.abeni@santannapisa.it
Cc: patrick.bellasi@arm.com
Cc: quentin.perret@arm.com
Cc: rjw@rjwysocki.net
Cc: valentin.schneider@arm.com
Cc: viresh.kumar@linaro.org
Link: http://lkml.kernel.org/r/1530200714-4504-12-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/sysctl.h | 1 -
 kernel/sched/core.c          | 8 --------
 kernel/sched/sched.h         | 1 -
 kernel/sysctl.c              | 8 --------
 4 files changed, 18 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 1c1a1512ec55..913488d828cb 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -40,7 +40,6 @@ extern unsigned int sysctl_numa_balancing_scan_size;
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
-extern __read_mostly unsigned int sysctl_sched_time_avg;
 
 int sched_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *length,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a691b07390ab..ba6bb805693a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -46,14 +46,6 @@ const_debug unsigned int sysctl_sched_features =
  */
 const_debug unsigned int sysctl_sched_nr_migrate = 32;
 
-/*
- * period over which we average the RT time consumption, measured
- * in ms.
- *
- * default: 1s
- */
-const_debug unsigned int sysctl_sched_time_avg = MSEC_PER_SEC;
-
 /*
  * period over which we measure -rt task CPU usage in us.
  * default: 1s
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14aac2d2de80..ebb4b3c3ece7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1713,7 +1713,6 @@ extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
 extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 
-extern const_debug unsigned int sysctl_sched_time_avg;
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2d9837c0aff4..f22f76b7a138 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -368,14 +368,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{
-		.procname	= "sched_time_avg_ms",
-		.data		= &sysctl_sched_time_avg,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-	},
 #ifdef CONFIG_SCHEDSTATS
 	{
 		.procname	= "sched_schedstats",
