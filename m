Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeEOGga (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:36:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39483 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeEOGg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:36:29 -0400
Date: Mon, 14 May 2018 23:35:48 -0700
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-1a00b4554d477f05199e22ee71ba4c2525ca44cb@git.kernel.org>
Cc: andrea.parri@amarulasolutions.com, hpa@zytor.com, mingo@kernel.org,
        luc.maranget@inria.fr, torvalds@linux-foundation.org,
        peterz@infradead.org, will.deacon@arm.com, j.alglave@ucl.ac.uk,
        paulmck@linux.vnet.ibm.com, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        dhowells@redhat.com, stern@rowland.harvard.edu, npiggin@gmail.com,
        tglx@linutronix.de, akpm@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, j.alglave@ucl.ac.uk, akiyks@gmail.com,
        paulmck@linux.vnet.ibm.com, will.deacon@arm.com, peterz@infradead.org,
        torvalds@linux-foundation.org, luc.maranget@inria.fr, mingo@kernel.org,
        hpa@zytor.com, andrea.parri@amarulasolutions.com,
        akpm@linux-foundation.org, tglx@linutronix.de, dhowells@redhat.com,
        npiggin@gmail.com, stern@rowland.harvard.edu, boqun.feng@gmail.com
In-Reply-To: <1526340837-12222-18-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526340837-12222-18-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Update ASPLOS information
Git-Commit-ID: 1a00b4554d477f05199e22ee71ba4c2525ca44cb
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

Commit-ID:  1a00b4554d477f05199e22ee71ba4c2525ca44cb
Gitweb:     https://git.kernel.org/tip/1a00b4554d477f05199e22ee71ba4c2525ca44cb
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Mon, 14 May 2018 16:33:56 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:18 +0200

tools/memory-model: Update ASPLOS information

ASPLOS 2018 was held in March: make sure this is reflected in
header comments and references.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: parri.andrea@gmail.com
Link: http://lkml.kernel.org/r/1526340837-12222-18-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/Documentation/references.txt | 11 ++++++-----
 tools/memory-model/linux-kernel.bell            |  4 ++--
 tools/memory-model/linux-kernel.cat             |  4 ++--
 tools/memory-model/linux-kernel.def             |  4 ++--
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
index ba2e34c2ec3f..74f448f2616a 100644
--- a/tools/memory-model/Documentation/references.txt
+++ b/tools/memory-model/Documentation/references.txt
@@ -67,11 +67,12 @@ o	Shaked Flur, Susmit Sarkar, Christopher Pulte, Kyndylan Nienhuis,
 Linux-kernel memory model
 =========================
 
-o	Andrea Parri, Alan Stern, Luc Maranget, Paul E. McKenney,
-	and Jade Alglave.  2017. "A formal model of
-	Linux-kernel memory ordering - companion webpage".
-	http://moscova.inria.fr/∼maranget/cats7/linux/. (2017). [Online;
-	accessed 30-January-2017].
+o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
+	Alan Stern.  2018. "Frightening small children and disconcerting
+	grown-ups: Concurrency in the Linux kernel". In Proceedings of
+	the 23rd International Conference on Architectural Support for
+	Programming Languages and Operating Systems (ASPLOS 2018). ACM,
+	New York, NY, USA, 405-418.  Webpage: http://diy.inria.fr/linux/.
 
 o	Jade Alglave, Luc Maranget, Paul E. McKenney, Andrea Parri, and
 	Alan Stern.  2017.  "A formal kernel memory-ordering model (part 1)"
diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 432c7cf71b23..64f5740e0e75 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -5,10 +5,10 @@
  * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
  *                    Andrea Parri <parri.andrea@gmail.com>
  *
- * An earlier version of this file appears in the companion webpage for
+ * An earlier version of this file appeared in the companion webpage for
  * "Frightening small children and disconcerting grown-ups: Concurrency
  * in the Linux kernel" by Alglave, Maranget, McKenney, Parri, and Stern,
- * which is to appear in ASPLOS 2018.
+ * which appeared in ASPLOS 2018.
  *)
 
 "Linux-kernel memory consistency model"
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 1e5c4653dd12..59b5cbe6b624 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -5,10 +5,10 @@
  * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
  *                    Andrea Parri <parri.andrea@gmail.com>
  *
- * An earlier version of this file appears in the companion webpage for
+ * An earlier version of this file appeared in the companion webpage for
  * "Frightening small children and disconcerting grown-ups: Concurrency
  * in the Linux kernel" by Alglave, Maranget, McKenney, Parri, and Stern,
- * which is to appear in ASPLOS 2018.
+ * which appeared in ASPLOS 2018.
  *)
 
 "Linux-kernel memory consistency model"
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index f0553bd37c08..6fa3eb28d40b 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 //
-// An earlier version of this file appears in the companion webpage for
+// An earlier version of this file appeared in the companion webpage for
 // "Frightening small children and disconcerting grown-ups: Concurrency
 // in the Linux kernel" by Alglave, Maranget, McKenney, Parri, and Stern,
-// which is to appear in ASPLOS 2018.
+// which appeared in ASPLOS 2018.
 
 // ONCE
 READ_ONCE(X) __load{once}(X)
