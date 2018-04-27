Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757882AbeD0Jor (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:44:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45775 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757842AbeD0Jon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:44:43 -0400
Date: Fri, 27 Apr 2018 02:44:20 -0700
From: tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-baa8c6ddf7be33f2b0ddeb68906d668caf646baa@git.kernel.org>
Cc: will.deacon@arm.com, longman@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org, hpa@zytor.com,
        longman@redhat.com, will.deacon@arm.com
In-Reply-To: <1524738868-31318-15-git-send-email-will.deacon@arm.com>
References: <1524738868-31318-15-git-send-email-will.deacon@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] MAINTAINERS: Add myself as a co-maintainer for
 the locking subsystem
Git-Commit-ID: baa8c6ddf7be33f2b0ddeb68906d668caf646baa
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

Commit-ID:  baa8c6ddf7be33f2b0ddeb68906d668caf646baa
Gitweb:     https://git.kernel.org/tip/baa8c6ddf7be33f2b0ddeb68906d668caf646baa
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Thu, 26 Apr 2018 11:34:28 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 27 Apr 2018 09:48:54 +0200

MAINTAINERS: Add myself as a co-maintainer for the locking subsystem

I've been heavily involved with concurrency and memory ordering stuff
(see ATOMIC INFRASTRUCTURE and LINUX KERNEL MEMORY CONSISTENCY MODEL)
and with arm64 now using qrwlock with a view to using qspinlock in the
near future, I'm going to continue being involved with the core locking
primitives. Reflect this by adding myself as a co-maintainer alongside
Ingo and Peter.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-15-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd66ae9a847e..e4585e33862c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8328,6 +8328,7 @@ F:	Documentation/admin-guide/LSM/LoadPin.rst
 LOCKING PRIMITIVES
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
+M:	Will Deacon <will.deacon@arm.com>
 L:	linux-kernel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
 S:	Maintained
