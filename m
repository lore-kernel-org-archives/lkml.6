Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752385AbeEOGbL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:31:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54693 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbeEOGbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:31:10 -0400
Date: Mon, 14 May 2018 23:30:44 -0700
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-d17013e0bac66bb4d1be44f061754c7e53292b64@git.kernel.org>
Cc: andrea.parri@amarulasolutions.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@kernel.org, will.deacon@arm.com
Reply-To: peterz@infradead.org, akpm@linux-foundation.org, will.deacon@arm.com,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        andrea.parri@amarulasolutions.com, linux-kernel@vger.kernel.org
In-Reply-To: <1526340837-12222-8-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526340837-12222-8-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Fix coding style in
 'linux-kernel.def'
Git-Commit-ID: d17013e0bac66bb4d1be44f061754c7e53292b64
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

Commit-ID:  d17013e0bac66bb4d1be44f061754c7e53292b64
Gitweb:     https://git.kernel.org/tip/d17013e0bac66bb4d1be44f061754c7e53292b64
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Mon, 14 May 2018 16:33:46 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:17 +0200

tools/memory-model: Fix coding style in 'linux-kernel.def'

This commit fixes white spaces around semicolons.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Link: http://lkml.kernel.org/r/1526340837-12222-8-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/linux-kernel.def | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index acf86f6f360a..6bd3bc431b3d 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -17,12 +17,12 @@ rcu_dereference(X) __load{once}(X)
 smp_store_mb(X,V) { __store{once}(X,V); __fence{mb}; }
 
 // Fences
-smp_mb() { __fence{mb} ; }
-smp_rmb() { __fence{rmb} ; }
-smp_wmb() { __fence{wmb} ; }
-smp_mb__before_atomic() { __fence{before-atomic} ; }
-smp_mb__after_atomic() { __fence{after-atomic} ; }
-smp_mb__after_spinlock() { __fence{after-spinlock} ; }
+smp_mb() { __fence{mb}; }
+smp_rmb() { __fence{rmb}; }
+smp_wmb() { __fence{wmb}; }
+smp_mb__before_atomic() { __fence{before-atomic}; }
+smp_mb__after_atomic() { __fence{after-atomic}; }
+smp_mb__after_spinlock() { __fence{after-spinlock}; }
 
 // Exchange
 xchg(X,V)  __xchg{mb}(X,V)
@@ -35,26 +35,26 @@ cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)
 cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
 
 // Spinlocks
-spin_lock(X) { __lock(X) ; }
-spin_unlock(X) { __unlock(X) ; }
+spin_lock(X) { __lock(X); }
+spin_unlock(X) { __unlock(X); }
 spin_trylock(X) __trylock(X)
 
 // RCU
 rcu_read_lock() { __fence{rcu-lock}; }
-rcu_read_unlock() { __fence{rcu-unlock};}
+rcu_read_unlock() { __fence{rcu-unlock}; }
 synchronize_rcu() { __fence{sync-rcu}; }
 synchronize_rcu_expedited() { __fence{sync-rcu}; }
 
 // Atomic
 atomic_read(X) READ_ONCE(*X)
-atomic_set(X,V) { WRITE_ONCE(*X,V) ; }
+atomic_set(X,V) { WRITE_ONCE(*X,V); }
 atomic_read_acquire(X) smp_load_acquire(X)
 atomic_set_release(X,V) { smp_store_release(X,V); }
 
-atomic_add(V,X) { __atomic_op(X,+,V) ; }
-atomic_sub(V,X) { __atomic_op(X,-,V) ; }
-atomic_inc(X)   { __atomic_op(X,+,1) ; }
-atomic_dec(X)   { __atomic_op(X,-,1) ; }
+atomic_add(V,X) { __atomic_op(X,+,V); }
+atomic_sub(V,X) { __atomic_op(X,-,V); }
+atomic_inc(X)   { __atomic_op(X,+,1); }
+atomic_dec(X)   { __atomic_op(X,-,1); }
 
 atomic_add_return(V,X) __atomic_op_return{mb}(X,+,V)
 atomic_add_return_relaxed(V,X) __atomic_op_return{once}(X,+,V)
