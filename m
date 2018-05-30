Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932570AbeE3WuA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:50:00 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:39403 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753691AbeE3Wt6 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 30 May 2018 18:49:58 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] sched: Fix throttling typo
Date: Wed, 30 May 2018 15:49:40 -0700
Message-Id: <20180530224940.17839-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot spell 'throttling'.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 67702b4d9ac7..6601baf2361c 100644
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
-- 
2.16.3
