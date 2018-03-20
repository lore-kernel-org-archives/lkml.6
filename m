Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeCTJYk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:24:40 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42949 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbeCTJYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:24:39 -0400
X-Google-Smtp-Source: AG47ELvoUDg3HqC+NjzQdFlSM/6qelo7oDvt+B+dkV+U809j3FrTjpD1OW2O4lfvkn+BJb+FLY64SQ==
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] workqueue: remove the comment about the old manager_arb mutex
Date: Tue, 20 Mar 2018 17:24:32 +0800
Message-Id: <20180320092432.13141-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The manager_arb mutex doesn't exist any more.

Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 19785a092026..698b6f1ecddd 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -165,7 +165,6 @@ struct worker_pool {
 	DECLARE_HASHTABLE(busy_hash, BUSY_WORKER_HASH_ORDER);
 						/* L: hash of busy workers */
 
-	/* see manage_workers() for details on the two manager mutexes */
 	struct worker		*manager;	/* L: purely informational */
 	struct mutex		attach_mutex;	/* attach/detach exclusion */
 	struct list_head	workers;	/* A: attached workers */
-- 
2.14.3 (Apple Git-98)
