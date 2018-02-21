Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754360AbeBUQ45 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:56:57 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:53112 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752006AbeBUQ44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:56:56 -0500
From: Christopher Diaz Riveros <chrisadr@gentoo.org>
To: juri.lelli@gmail.com, peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [RFC] sched/headers: comments clean up <linux/sched.h>
Date: Wed, 21 Feb 2018 11:56:46 -0500
Message-Id: <20180221165646.15432-1-chrisadr@gentoo.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <1518787521.2464.20.camel@gentoo.org>
References: <1518787521.2464.20.camel@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove inline comments to merge them into comment blocks.

Enhance readability from source code by giving descriptions from the
structures and data in comment blocks instead from inline comments.

Signed-off-by: Christopher Diaz Riveros <chrisadr@gentoo.org>
---
 include/linux/sched.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b161ef8a902e..693a6e51ed0c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -221,12 +221,21 @@ struct task_cputime {
 #define prof_exp			stime
 #define sched_exp			sum_exec_runtime
 
+/*
+ * vtime_state states:
+ *
+ * @VTIME_INACTIVE tells if task is sleeping or running in a CPU with
+ * VTIME inactive.
+ *
+ * @VTIME_USER tells if task is running in userspace in a CPU with
+ * VTIME active.
+ *
+ * @VTIME_SYS tells if task is running in kernelspace in a CPU with
+ * VTIME active.
+ */
 enum vtime_state {
-	/* Task is sleeping or running in a CPU with VTIME inactive: */
 	VTIME_INACTIVE = 0,
-	/* Task runs in userspace in a CPU with VTIME active: */
 	VTIME_USER,
-	/* Task runs in kernelspace in a CPU with VTIME active: */
 	VTIME_SYS,
 };
 
-- 
2.16.2
