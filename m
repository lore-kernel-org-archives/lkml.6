Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934025AbeBMP3Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:29:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39555 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933791AbeBMP3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:29:11 -0500
Date: Tue, 13 Feb 2018 07:28:46 -0800
From: tip-bot for Tycho Andersen <tipbot@zytor.com>
Message-ID: <tip-2dd6fd2e999774041397f2a7da2e1d30b3a27c3a@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tycho@tycho.ws,
        torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, tycho@tycho.ws, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
In-Reply-To: <20180201114119.1090-1-tycho@tycho.ws>
References: <20180201114119.1090-1-tycho@tycho.ws>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/semaphore: Update the file path in
 documentation
Git-Commit-ID: 2dd6fd2e999774041397f2a7da2e1d30b3a27c3a
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

Commit-ID:  2dd6fd2e999774041397f2a7da2e1d30b3a27c3a
Gitweb:     https://git.kernel.org/tip/2dd6fd2e999774041397f2a7da2e1d30b3a27c3a
Author:     Tycho Andersen <tycho@tycho.ws>
AuthorDate: Thu, 1 Feb 2018 12:41:19 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 15:00:06 +0100

locking/semaphore: Update the file path in documentation

While reading this header I noticed that the locking stuff has moved to
kernel/locking/*, so update the path in semaphore.h to point to that.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180201114119.1090-1-tycho@tycho.ws
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/semaphore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
index dc368b8..11c86fb 100644
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
