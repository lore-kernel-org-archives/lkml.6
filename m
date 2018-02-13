Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935216AbeBMMQ4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:16:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59299 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935049AbeBMMQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:16:09 -0500
Date: Tue, 13 Feb 2018 04:15:44 -0800
From: tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-43d1b29b27c76e7454cd6c85bec4d0e9cbb039f3@git.kernel.org>
Cc: viresh.kumar@linaro.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, markivx@codeaurora.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
        leo.yan@linaro.org, rafael.j.wysocki@intel.com, mingo@kernel.org
Reply-To: viresh.kumar@linaro.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, hpa@zytor.com, leo.yan@linaro.org,
        markivx@codeaurora.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org, rafael.j.wysocki@intel.com
In-Reply-To: <1518097702-9665-1-git-send-email-leo.yan@linaro.org>
References: <1518097702-9665-1-git-send-email-leo.yan@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/cpufreq: Remove unused
 SUGOV_KTHREAD_PRIORITY macro
Git-Commit-ID: 43d1b29b27c76e7454cd6c85bec4d0e9cbb039f3
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

Commit-ID:  43d1b29b27c76e7454cd6c85bec4d0e9cbb039f3
Gitweb:     https://git.kernel.org/tip/43d1b29b27c76e7454cd6c85bec4d0e9cbb039f3
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Thu, 8 Feb 2018 21:48:22 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 13:04:03 +0100

sched/cpufreq: Remove unused SUGOV_KTHREAD_PRIORITY macro

Since schedutil kernel thread directly set priority to 0, the macro
SUGOV_KTHREAD_PRIORITY is not used.  So remove it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vikram Mulukutla <markivx@codeaurora.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: http://lkml.kernel.org/r/1518097702-9665-1-git-send-email-leo.yan@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index dd062a1..7936f54 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -19,8 +19,6 @@
 
 #include "sched.h"
 
-#define SUGOV_KTHREAD_PRIORITY	50
-
 struct sugov_tunables {
 	struct gov_attr_set attr_set;
 	unsigned int rate_limit_us;
