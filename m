Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbeBALle (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 06:41:34 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53023 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbeBALlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 06:41:31 -0500
X-Google-Smtp-Source: AH8x226JV/h+njPLtlXYS+i8I9go/OmRgV6u2CJ85NXmdmZnSGHWpLH//OO8mG4NtT68XatgjlcoiA==
From: Tycho Andersen <tycho@tycho.ws>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH] semaphore.h: correct path in documentation
Date: Thu,  1 Feb 2018 12:41:19 +0100
Message-Id: <20180201114119.1090-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reading this header, I noticed that the locking stuff has moved to
kernel/locking/*, so update the path in semaphore.h to point to that.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 include/linux/semaphore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
index dc368b8ce215..11c86fbfeb98 100644
--- a/include/linux/semaphore.h
+++ b/include/linux/semaphore.h
@@ -4,7 +4,7 @@
  *
  * Distributed under the terms of the GNU GPL, version 2
  *
- * Please see kernel/semaphore.c for documentation of these functions
+ * Please see kernel/locking/semaphore.c for documentation of these functions
  */
 #ifndef __LINUX_SEMAPHORE_H
 #define __LINUX_SEMAPHORE_H
-- 
2.14.1
