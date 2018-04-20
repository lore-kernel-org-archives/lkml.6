Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeDTQa6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:30:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42562 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbeDTQay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:30:54 -0400
X-Google-Smtp-Source: AIpwx49byn37rGDdcasPeTresJWFfadevPU88u0HLQWpanr0yfvLuqPqYGcN0SBpjmWzjbTF/f2ozQ==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 1/2] tools/memory-model: Update ASPLOS information
Date: Fri, 20 Apr 2018 18:30:12 +0200
Message-Id: <1524241813-14045-2-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524241813-14045-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1524241813-14045-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASPLOS 2018 was held in March: make sure this is reflected in
header comments and references.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
---
 tools/memory-model/Documentation/references.txt | 11 ++++++-----
 tools/memory-model/linux-kernel.bell            |  4 ++--
 tools/memory-model/linux-kernel.cat             |  4 ++--
 tools/memory-model/linux-kernel.def             |  4 ++--
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
index ba2e34c2ec3f5..74f448f2616a3 100644
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
index 432c7cf71b237..64f5740e0e751 100644
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
index 1e5c4653dd12e..59b5cbe6b6240 100644
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
index f0553bd37c085..6fa3eb28d40b5 100644
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
-- 
2.7.4
