Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933425AbeBUKlY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:41:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40417 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932706AbeBUKlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:41:22 -0500
Date: Wed, 21 Feb 2018 02:40:56 -0800
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-8f32543b61d7daeddb5b64c80b5ad5f05cc97722@git.kernel.org>
Cc: hpa@zytor.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org
Reply-To: hpa@zytor.com, torvalds@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org
In-Reply-To: <1519169112-20593-4-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1519169112-20593-4-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] EXP litmus_tests: Add comments explaining tests'
 purposes
Git-Commit-ID: 8f32543b61d7daeddb5b64c80b5ad5f05cc97722
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

Commit-ID:  8f32543b61d7daeddb5b64c80b5ad5f05cc97722
Gitweb:     https://git.kernel.org/tip/8f32543b61d7daeddb5b64c80b5ad5f05cc97722
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Tue, 20 Feb 2018 15:25:04 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:58:13 +0100

EXP litmus_tests: Add comments explaining tests' purposes

This commit adds comments to the litmus tests summarizing what these
tests are intended to demonstrate.

[ paulmck: Apply Andrea's and Alan's feedback. ]
Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
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
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/1519169112-20593-4-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 .../memory-model/litmus-tests/CoRR+poonceonce+Once.litmus  |  7 +++++++
 .../memory-model/litmus-tests/CoRW+poonceonce+Once.litmus  |  7 +++++++
 .../memory-model/litmus-tests/CoWR+poonceonce+Once.litmus  |  7 +++++++
 tools/memory-model/litmus-tests/CoWW+poonceonce.litmus     |  7 +++++++
 .../litmus-tests/IRIW+mbonceonces+OnceOnce.litmus          | 10 ++++++++++
 .../litmus-tests/IRIW+poonceonces+OnceOnce.litmus          | 10 ++++++++++
 tools/memory-model/litmus-tests/ISA2+poonceonces.litmus    |  9 +++++++++
 ...SA2+pooncerelease+poacquirerelease+poacquireonce.litmus | 11 +++++++++++
 .../litmus-tests/LB+ctrlonceonce+mbonceonce.litmus         | 11 +++++++++++
 .../litmus-tests/LB+poacquireonce+pooncerelease.litmus     |  8 ++++++++
 tools/memory-model/litmus-tests/LB+poonceonces.litmus      |  7 +++++++
 .../litmus-tests/MP+onceassign+derefonce.litmus            | 11 ++++++++++-
 tools/memory-model/litmus-tests/MP+polocks.litmus          | 11 +++++++++++
 tools/memory-model/litmus-tests/MP+poonceonces.litmus      |  7 +++++++
 .../litmus-tests/MP+pooncerelease+poacquireonce.litmus     |  8 ++++++++
 tools/memory-model/litmus-tests/MP+porevlocks.litmus       | 11 +++++++++++
 .../litmus-tests/MP+wmbonceonce+rmbonceonce.litmus         |  8 ++++++++
 tools/memory-model/litmus-tests/R+mbonceonces.litmus       |  9 +++++++++
 tools/memory-model/litmus-tests/R+poonceonces.litmus       |  8 ++++++++
 tools/memory-model/litmus-tests/S+poonceonces.litmus       |  9 +++++++++
 .../litmus-tests/S+wmbonceonce+poacquireonce.litmus        |  7 +++++++
 tools/memory-model/litmus-tests/SB+mbonceonces.litmus      |  9 +++++++++
 tools/memory-model/litmus-tests/SB+poonceonces.litmus      |  8 ++++++++
 .../memory-model/litmus-tests/WRC+poonceonces+Once.litmus  |  8 ++++++++
 .../litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus |  8 ++++++++
 .../Z6.0+pooncelock+poonceLock+pombonce.litmus             |  9 +++++++++
 .../Z6.0+pooncelock+pooncelock+pombonce.litmus             |  8 ++++++++
 .../Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus  | 14 ++++++++++++++
 28 files changed, 246 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
index 5b83d57..967f9f2 100644
--- a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
@@ -1,5 +1,12 @@
 C CoRR+poonceonce+Once
 
+(*
+ * Result: Never
+ *
+ * Test of read-read coherence, that is, whether or not two successive
+ * reads from the same variable are ordered.
+ *)
+
 {}
 
 P0(int *x)
diff --git a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
index fab91c1..4635739 100644
--- a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
@@ -1,5 +1,12 @@
 C CoRW+poonceonce+Once
 
+(*
+ * Result: Never
+ *
+ * Test of read-write coherence, that is, whether or not a read from
+ * a given variable and a later write to that same variable are ordered.
+ *)
+
 {}
 
 P0(int *x)
diff --git a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
index 6a35ec2..bb068c9 100644
--- a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
@@ -1,5 +1,12 @@
 C CoWR+poonceonce+Once
 
+(*
+ * Result: Never
+ *
+ * Test of write-read coherence, that is, whether or not a write to a
+ * given variable and a later read from that same variable are ordered.
+ *)
+
 {}
 
 P0(int *x)
diff --git a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
index 32a96b8..0d9f0a9 100644
--- a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
+++ b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
@@ -1,5 +1,12 @@
 C CoWW+poonceonce
 
+(*
+ * Result: Never
+ *
+ * Test of write-write coherence, that is, whether or not two successive
+ * writes to the same variable are ordered.
+ *)
+
 {}
 
 P0(int *x)
diff --git a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
index 7eba2c6..50d5db9 100644
--- a/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+mbonceonces+OnceOnce.litmus
@@ -1,5 +1,15 @@
 C IRIW+mbonceonces+OnceOnce
 
+(*
+ * Result: Never
+ *
+ * Test of independent reads from independent writes with smp_mb()
+ * between each pairs of reads.  In other words, is smp_mb() sufficient to
+ * cause two different reading processes to agree on the order of a pair
+ * of writes, where each write is to a different variable by a different
+ * process?
+ *)
+
 {}
 
 P0(int *x)
diff --git a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
index b0556c6..4b54dd6 100644
--- a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
@@ -1,5 +1,15 @@
 C IRIW+poonceonces+OnceOnce
 
+(*
+ * Result: Sometimes
+ *
+ * Test of independent reads from independent writes with nothing
+ * between each pairs of reads.  In other words, is anything at all
+ * needed to cause two different reading processes to agree on the order
+ * of a pair of writes, where each write is to a different variable by a
+ * different process?
+ *)
+
 {}
 
 P0(int *x)
diff --git a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
index 9a1a233..b321aa6 100644
--- a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
@@ -1,5 +1,14 @@
 C ISA2+poonceonces
 
+(*
+ * Result: Sometimes
+ *
+ * Given a release-acquire chain ordering the first process's store
+ * against the last process's load, is ordering preserved if all of the
+ * smp_store_release() invocations are replaced by WRITE_ONCE() and all
+ * of the smp_load_acquire() invocations are replaced by READ_ONCE()?
+ *)
+
 {}
 
 P0(int *x, int *y)
diff --git a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
index 235195e..025b046 100644
--- a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
@@ -1,5 +1,16 @@
 C ISA2+pooncerelease+poacquirerelease+poacquireonce
 
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that a release-acquire chain suffices
+ * to order P0()'s initial write against P2()'s final read.  The reason
+ * that the release-acquire chain suffices is because in all but one
+ * case (P2() to P0()), each process reads from the preceding process's
+ * write.  In memory-model-speak, there is only one non-reads-from
+ * (AKA non-rf) link, so release-acquire is all that is needed.
+ *)
+
 {}
 
 P0(int *x, int *y)
diff --git a/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus b/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
index dd5ac3a..de67082 100644
--- a/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/LB+ctrlonceonce+mbonceonce.litmus
@@ -1,5 +1,16 @@
 C LB+ctrlonceonce+mbonceonce
 
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that lightweight ordering suffices for
+ * the load-buffering pattern, in other words, preventing all processes
+ * reading from the preceding process's write.  In this example, the
+ * combination of a control dependency and a full memory barrier are enough
+ * to do the trick.  (But the full memory barrier could be replaced with
+ * another control dependency and order would still be maintained.)
+ *)
+
 {}
 
 P0(int *x, int *y)
diff --git a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
index 47bd613..07b9904 100644
--- a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
+++ b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
@@ -1,5 +1,13 @@
 C LB+poacquireonce+pooncerelease
 
+(*
+ * Result: Never
+ *
+ * Does a release-acquire pair suffice for the load-buffering litmus
+ * test, where each process reads from one of two variables then writes
+ * to the other?
+ *)
+
 {}
 
 P0(int *x, int *y)
diff --git a/tools/memory-model/litmus-tests/LB+poonceonces.litmus b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
index a5cdf02..74c49cb 100644
--- a/tools/memory-model/litmus-tests/LB+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
@@ -1,5 +1,12 @@
 C LB+poonceonces
 
+(*
+ * Result: Sometimes
+ *
+ * Can the counter-intuitive outcome for the load-buffering pattern
+ * be prevented even with no explicit ordering?
+ *)
+
 {}
 
 P0(int *x, int *y)
diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
index 1a2fe58..97731b4 100644
--- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
@@ -1,4 +1,13 @@
-C MP+onceassign+derefonce.litmus
+C MP+onceassign+derefonce
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that rcu_assign_pointer() and
+ * rcu_dereference() suffice to ensure that an RCU reader will not see
+ * pre-initialization garbage when it traverses an RCU-protected data
+ * structure containing a newly inserted element.
+ *)
 
 {
 y=z;
diff --git a/tools/memory-model/litmus-tests/MP+polocks.litmus b/tools/memory-model/litmus-tests/MP+polocks.litmus
index 5fe6f1e..712a4fcd 100644
--- a/tools/memory-model/litmus-tests/MP+polocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
@@ -1,5 +1,16 @@
 C MP+polocks
 
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates how lock acquisitions and releases can
+ * stand in for smp_load_acquire() and smp_store_release(), respectively.
+ * In other words, when holding a given lock (or indeed after releasing a
+ * given lock), a CPU is not only guaranteed to see the accesses that other
+ * CPUs made while previously holding that lock, it is also guaranteed
+ * to see all prior accesses by those other CPUs.
+ *)
+
 {}
 
 P0(int *x, int *y, spinlock_t *mylock)
diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
index 46e1ac7b..b2b60b8 100644
--- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
@@ -1,5 +1,12 @@
 C MP+poonceonces
 
+(*
+ * Result: Maybe
+ *
+ * Can the counter-intuitive message-passing outcome be prevented with
+ * no ordering at all?
+ *)
+
 {}
 
 P0(int *x, int *y)
diff --git a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
index 0b00cc7..d52c684 100644
--- a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
@@ -1,5 +1,13 @@
 C MP+pooncerelease+poacquireonce
 
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that smp_store_release() and
+ * smp_load_acquire() provide sufficient ordering for the message-passing
+ * pattern.
+ *)
+
 {}
 
 P0(int *x, int *y)
diff --git a/tools/memory-model/litmus-tests/MP+porevlocks.litmus b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
index 90d011c..72c9276 100644
--- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
@@ -1,5 +1,16 @@
 C MP+porevlocks
 
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates how lock acquisitions and releases can
+ * stand in for smp_load_acquire() and smp_store_release(), respectively.
+ * In other words, when holding a given lock (or indeed after releasing a
+ * given lock), a CPU is not only guaranteed to see the accesses that other
+ * CPUs made while previously holding that lock, it is also guaranteed to
+ * see all prior accesses by those other CPUs.
+ *)
+
 {}
 
 P0(int *x, int *y, spinlock_t *mylock)
diff --git a/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus b/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
index 604ad41..c078f38 100644
--- a/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+wmbonceonce+rmbonceonce.litmus
@@ -1,5 +1,13 @@
 C MP+wmbonceonce+rmbonceonce
 
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that smp_wmb() and smp_rmb() provide
+ * sufficient ordering for the message-passing pattern.  However, it
+ * is usually better to use smp_store_release() and smp_load_acquire().
+ *)
+
 {}
 
 P0(int *x, int *y)
diff --git a/tools/memory-model/litmus-tests/R+mbonceonces.litmus b/tools/memory-model/litmus-tests/R+mbonceonces.litmus
index e69b9e3..a0e884a 100644
--- a/tools/memory-model/litmus-tests/R+mbonceonces.litmus
+++ b/tools/memory-model/litmus-tests/R+mbonceonces.litmus
@@ -1,5 +1,14 @@
 C R+mbonceonces
 
+(*
+ * Result: Never
+ *
+ * This is the fully ordered (via smp_mb()) version of one of the classic
+ * counterintuitive litmus tests that illustrates the effects of store
+ * propagation delays.  Note that weakening either of the barriers would
+ * cause the resulting test to be allowed.
+ *)
+
 {}
 
 P0(int *x, int *y)
diff --git a/tools/memory-model/litmus-tests/R+poonceonces.litmus b/tools/memory-model/litmus-tests/R+poonceonces.litmus
index f7a12e0..5386f12 100644
--- a/tools/memory-model/litmus-tests/R+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/R+poonceonces.litmus
@@ -1,5 +1,13 @@
 C R+poonceonces
 
+(*
+ * Result: Sometimes
+ *
+ * This is the unordered (thus lacking smp_mb()) version of one of the
+ * classic counterintuitive litmus tests that illustrates the effects of
+ * store propagation delays.
+ *)
+
 {}
 
 P0(int *x, int *y)
diff --git a/tools/memory-model/litmus-tests/S+poonceonces.litmus b/tools/memory-model/litmus-tests/S+poonceonces.litmus
index d0d541c..8c9c2f8 100644
--- a/tools/memory-model/litmus-tests/S+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/S+poonceonces.litmus
@@ -1,5 +1,14 @@
 C S+poonceonces
 
+(*
+ * Result: Sometimes
+ *
+ * Starting with a two-process release-acquire chain ordering P0()'s
+ * first store against P1()'s final load, if the smp_store_release()
+ * is replaced by WRITE_ONCE() and the smp_load_acquire() replaced by
+ * READ_ONCE(), is ordering preserved?
+ *)
+
 {}
 
 P0(int *x, int *y)
diff --git a/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
index 1d292d0..c533502 100644
--- a/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/S+wmbonceonce+poacquireonce.litmus
@@ -1,5 +1,12 @@
 C S+wmbonceonce+poacquireonce
 
+(*
+ * Result: Never
+ *
+ * Can a smp_wmb(), instead of a release, and an acquire order a prior
+ * store against a subsequent store?
+ *)
+
 {}
 
 P0(int *x, int *y)
diff --git a/tools/memory-model/litmus-tests/SB+mbonceonces.litmus b/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
index b76caa5..74b874f 100644
--- a/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+mbonceonces.litmus
@@ -1,5 +1,14 @@
 C SB+mbonceonces
 
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that full memory barriers suffice to
+ * order the store-buffering pattern, where each process writes to the
+ * variable that the preceding process reads.  (Locking and RCU can also
+ * suffice, but not much else.)
+ *)
+
 {}
 
 P0(int *x, int *y)
diff --git a/tools/memory-model/litmus-tests/SB+poonceonces.litmus b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
index c1797e03..10d5507 100644
--- a/tools/memory-model/litmus-tests/SB+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
@@ -1,5 +1,13 @@
 C SB+poonceonces
 
+(*
+ * Result: Sometimes
+ *
+ * This litmus test demonstrates that at least some ordering is required
+ * to order the store-buffering pattern, where each process writes to the
+ * variable that the preceding process reads.
+ *)
+
 {}
 
 P0(int *x, int *y)
diff --git a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
index f5e7c92..6a2bc12 100644
--- a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
@@ -1,5 +1,13 @@
 C WRC+poonceonces+Once
 
+(*
+ * Result: Sometimes
+ *
+ * This litmus test is an extension of the message-passing pattern,
+ * where the first write is moved to a separate process.  Note that this
+ * test has no ordering at all.
+ *)
+
 {}
 
 P0(int *x)
diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
index e3d0018..97fcbff 100644
--- a/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+rmbonceonce+Once.litmus
@@ -1,5 +1,13 @@
 C WRC+pooncerelease+rmbonceonce+Once
 
+(*
+ * Result: Never
+ *
+ * This litmus test is an extension of the message-passing pattern, where
+ * the first write is moved to a separate process.  Because it features
+ * a release and a read memory barrier, it should be forbidden.
+ *)
+
 {}
 
 P0(int *x)
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
index 9c2cb53..415248f 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
@@ -1,5 +1,14 @@
 C Z6.0+pooncelock+poonceLock+pombonce
 
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates how smp_mb__after_spinlock() may be
+ * used to ensure that accesses in different critical sections for a
+ * given lock running on different CPUs are nevertheless seen in order
+ * by CPUs not holding that lock.
+ *)
+
 {}
 
 P0(int *x, int *y, spinlock_t *mylock)
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
index c9a1f1a..10a2aa0 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
@@ -1,5 +1,13 @@
 C Z6.0+pooncelock+pooncelock+pombonce
 
+(*
+ * Result: Sometimes
+ *
+ * This example demonstrates that a pair of accesses made by different
+ * processes each while holding a given lock will not necessarily be
+ * seen as ordered by a third process not holding that lock.
+ *)
+
 {}
 
 P0(int *x, int *y, spinlock_t *mylock)
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
index 25409a0..a20fc3f 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+mbonceonce.litmus
@@ -1,5 +1,19 @@
 C Z6.0+pooncerelease+poacquirerelease+mbonceonce
 
+(*
+ * Result: Sometimes
+ *
+ * This litmus test shows that a release-acquire chain, while sufficient
+ * when there is but one non-reads-from (AKA non-rf) link, does not suffice
+ * if there is more than one.  Of the three processes, only P1() reads from
+ * P0's write, which means that there are two non-rf links: P1() to P2()
+ * is a write-to-write link (AKA a "coherence" or just "co" link) and P2()
+ * to P0() is a read-to-write link (AKA a "from-reads" or just "fr" link).
+ * When there are two or more non-rf links, you typically will need one
+ * full barrier for each non-rf link.  (Exceptions include some cases
+ * involving locking.)
+ *)
+
 {}
 
 P0(int *x, int *y)
