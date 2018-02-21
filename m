Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933441AbeBUKl1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:41:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33377 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933412AbeBUKlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:41:24 -0500
Date: Wed, 21 Feb 2018 02:39:57 -0800
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-e7d74c9f900a12ea0bd5cabb3be142441530e24e@git.kernel.org>
Cc: paulmck@linux.vnet.ibm.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org, peterz@infradead.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will.deacon@arm.com, tglx@linutronix.de
Reply-To: paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        mingo@kernel.org, stern@rowland.harvard.edu, tglx@linutronix.de,
        will.deacon@arm.com, parri.andrea@gmail.com
In-Reply-To: <1519169112-20593-2-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1519169112-20593-2-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] MAINTAINERS: Add the Memory Consistency Model
 subsystem
Git-Commit-ID: e7d74c9f900a12ea0bd5cabb3be142441530e24e
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

Commit-ID:  e7d74c9f900a12ea0bd5cabb3be142441530e24e
Gitweb:     https://git.kernel.org/tip/e7d74c9f900a12ea0bd5cabb3be142441530e24e
Author:     Andrea Parri <parri.andrea@gmail.com>
AuthorDate: Tue, 20 Feb 2018 15:25:02 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:58:12 +0100

MAINTAINERS: Add the Memory Consistency Model subsystem

Move the contents of tools/memory-model/MAINTAINERS into the main
MAINTAINERS file, removing tools/memory-model/MAINTAINERS. This
allows get_maintainer.pl to correctly identify the maintainers of
tools/memory-model/.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: nborisov@suse.com
Cc: npiggin@gmail.com
Link: http://lkml.kernel.org/r/1519169112-20593-2-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 MAINTAINERS                    | 16 ++++++++++++++++
 tools/memory-model/MAINTAINERS | 15 ---------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a7f76e..654c6c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8148,6 +8148,22 @@ M:	Kees Cook <keescook@chromium.org>
 S:	Maintained
 F:	drivers/misc/lkdtm*
 
+LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)
+M:	Alan Stern <stern@rowland.harvard.edu>
+M:	Andrea Parri <parri.andrea@gmail.com>
+M:	Will Deacon <will.deacon@arm.com>
+M:	Peter Zijlstra <peterz@infradead.org>
+M:	Boqun Feng <boqun.feng@gmail.com>
+M:	Nicholas Piggin <npiggin@gmail.com>
+M:	David Howells <dhowells@redhat.com>
+M:	Jade Alglave <j.alglave@ucl.ac.uk>
+M:	Luc Maranget <luc.maranget@inria.fr>
+M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
+F:	tools/memory-model/
+
 LINUX SECURITY MODULE (LSM) FRAMEWORK
 M:	Chris Wright <chrisw@sous-sol.org>
 L:	linux-security-module@vger.kernel.org
diff --git a/tools/memory-model/MAINTAINERS b/tools/memory-model/MAINTAINERS
deleted file mode 100644
index db3bd3f..0000000
--- a/tools/memory-model/MAINTAINERS
+++ /dev/null
@@ -1,15 +0,0 @@
-LINUX KERNEL MEMORY CONSISTENCY MODEL
-M:	Alan Stern <stern@rowland.harvard.edu>
-M:	Andrea Parri <parri.andrea@gmail.com>
-M:	Will Deacon <will.deacon@arm.com>
-M:	Peter Zijlstra <peterz@infradead.org>
-M:	Boqun Feng <boqun.feng@gmail.com>
-M:	Nicholas Piggin <npiggin@gmail.com>
-M:	David Howells <dhowells@redhat.com>
-M:	Jade Alglave <j.alglave@ucl.ac.uk>
-M:	Luc Maranget <luc.maranget@inria.fr>
-M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
-L:	linux-kernel@vger.kernel.org
-S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
-F:	tools/memory-model/
