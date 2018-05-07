Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeEGJgV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:36:21 -0400
Received: from osg.samsung.com ([64.30.133.232]:52363 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752376AbeEGJgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:36:04 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 13/18] wait: wait.h: Get rid of a kernel-doc/Sphinx warnings
Date: Mon,  7 May 2018 06:35:49 -0300
Message-Id: <6b9b3184cbfabab1ad89c974ddf1c61631e8f1bf.1525684985.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flow diagram should be inside a code-block to avoid those
warnings:
	./include/linux/wait.h:110: WARNING: Block quote ends without a blank line; unexpected unindent.
	./include/linux/wait.h:113: WARNING: Unexpected indentation.
	./include/linux/wait.h:115: WARNING: Block quote ends without a blank line; unexpected unindent.

This is easily done by using "::" instead of just ":".

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 include/linux/wait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index d9f131ecf708..d907ed761a7f 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -101,7 +101,7 @@ init_waitqueue_func_entry(struct wait_queue_entry *wq_entry, wait_queue_func_t f
  * lead to sporadic and non-obvious failure.
  *
  * Use either while holding wait_queue_head::lock or when used for wakeups
- * with an extra smp_mb() like:
+ * with an extra smp_mb() like::
  *
  *      CPU0 - waker                    CPU1 - waiter
  *
-- 
2.17.0
