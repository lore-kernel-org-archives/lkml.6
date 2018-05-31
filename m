Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755151AbeEaMaA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:30:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35399 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754733AbeEaM36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:29:58 -0400
Date: Thu, 31 May 2018 05:29:32 -0700
From: tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Message-ID: <tip-595058b6675e4d2a70dcd867c84d922975f9d22b@git.kernel.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, dbueso@suse.de,
        dave@stgolabs.net, tglx@linutronix.de, peterz@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: dave@stgolabs.net, mingo@kernel.org, dbueso@suse.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20180530224940.17839-1-dave@stgolabs.net>
References: <20180530224940.17839-1-dave@stgolabs.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/headers: Fix typo
Git-Commit-ID: 595058b6675e4d2a70dcd867c84d922975f9d22b
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

Commit-ID:  595058b6675e4d2a70dcd867c84d922975f9d22b
Gitweb:     https://git.kernel.org/tip/595058b6675e4d2a70dcd867c84d922975f9d22b
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Wed, 30 May 2018 15:49:40 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 31 May 2018 12:27:13 +0200

sched/headers: Fix typo

I cannot spell 'throttling'.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180530224940.17839-1-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f0a4bc6a39d..cb467c221b15 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -983,7 +983,7 @@ static inline void rq_clock_skip_update(struct rq *rq)
 }
 
 /*
- * See rt task throttoling, which is the only time a skip
+ * See rt task throttling, which is the only time a skip
  * request is cancelled.
  */
 static inline void rq_clock_cancel_skipupdate(struct rq *rq)
