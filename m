Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeBUXoP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:44:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbeBUXlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:41:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E77C217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From: James Hogan <jhogan@kernel.org>
To: linux-metag@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 03/13] docs: Remove remaining references to metag
Date: Wed, 21 Feb 2018 23:38:15 +0000
Message-Id: <20180221233825.10024-4-jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180221233825.10024-1-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove any remaining references to the Meta architecture in
Documentation/, primarily from Documentation/features/.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-metag@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/dev-tools/kmemleak.rst                               | 2 +-
 Documentation/features/core/BPF-JIT/arch-support.txt               | 1 -
 Documentation/features/core/generic-idle-thread/arch-support.txt   | 1 -
 Documentation/features/core/jump-labels/arch-support.txt           | 1 -
 Documentation/features/core/tracehook/arch-support.txt             | 1 -
 Documentation/features/debug/KASAN/arch-support.txt                | 1 -
 Documentation/features/debug/gcov-profile-all/arch-support.txt     | 1 -
 Documentation/features/debug/kgdb/arch-support.txt                 | 1 -
 Documentation/features/debug/kprobes-on-ftrace/arch-support.txt    | 1 -
 Documentation/features/debug/kprobes/arch-support.txt              | 1 -
 Documentation/features/debug/kretprobes/arch-support.txt           | 1 -
 Documentation/features/debug/optprobes/arch-support.txt            | 1 -
 Documentation/features/debug/stackprotector/arch-support.txt       | 1 -
 Documentation/features/debug/uprobes/arch-support.txt              | 1 -
 Documentation/features/debug/user-ret-profiler/arch-support.txt    | 1 -
 Documentation/features/io/dma-api-debug/arch-support.txt           | 1 -
 Documentation/features/io/dma-contiguous/arch-support.txt          | 1 -
 Documentation/features/io/sg-chain/arch-support.txt                | 1 -
 Documentation/features/lib/strncasecmp/arch-support.txt            | 1 -
 Documentation/features/locking/cmpxchg-local/arch-support.txt      | 1 -
 Documentation/features/locking/lockdep/arch-support.txt            | 1 -
 Documentation/features/locking/queued-rwlocks/arch-support.txt     | 1 -
 Documentation/features/locking/queued-spinlocks/arch-support.txt   | 1 -
 Documentation/features/locking/rwsem-optimized/arch-support.txt    | 1 -
 Documentation/features/perf/kprobes-event/arch-support.txt         | 1 -
 Documentation/features/perf/perf-regs/arch-support.txt             | 1 -
 Documentation/features/perf/perf-stackdump/arch-support.txt        | 1 -
 Documentation/features/sched/membarrier-sync-core/arch-support.txt | 1 -
 Documentation/features/sched/numa-balancing/arch-support.txt       | 1 -
 Documentation/features/seccomp/seccomp-filter/arch-support.txt     | 1 -
 Documentation/features/time/arch-tick-broadcast/arch-support.txt   | 1 -
 Documentation/features/time/clockevents/arch-support.txt           | 1 -
 Documentation/features/time/context-tracking/arch-support.txt      | 1 -
 Documentation/features/time/irq-time-acct/arch-support.txt         | 1 -
 Documentation/features/time/modern-timekeeping/arch-support.txt    | 1 -
 Documentation/features/time/virt-cpuacct/arch-support.txt          | 1 -
 Documentation/features/vm/ELF-ASLR/arch-support.txt                | 1 -
 Documentation/features/vm/PG_uncached/arch-support.txt             | 1 -
 Documentation/features/vm/THP/arch-support.txt                     | 1 -
 Documentation/features/vm/TLB/arch-support.txt                     | 1 -
 Documentation/features/vm/huge-vmap/arch-support.txt               | 1 -
 Documentation/features/vm/ioremap_prot/arch-support.txt            | 1 -
 Documentation/features/vm/numa-memblock/arch-support.txt           | 1 -
 Documentation/features/vm/pte_special/arch-support.txt             | 1 -
 44 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
index cb8862659178..e6f51260ff32 100644
--- a/Documentation/dev-tools/kmemleak.rst
+++ b/Documentation/dev-tools/kmemleak.rst
@@ -8,7 +8,7 @@ with the difference that the orphan objects are not freed but only
 reported via /sys/kernel/debug/kmemleak. A similar method is used by the
 Valgrind tool (``memcheck --leak-check``) to detect the memory leaks in
 user-space applications.
-Kmemleak is supported on x86, arm, powerpc, sparc, sh, microblaze, ppc, mips, s390, metag and tile.
+Kmemleak is supported on x86, arm, powerpc, sparc, sh, microblaze, ppc, mips, s390 and tile.
 
 Usage
 -----
diff --git a/Documentation/features/core/BPF-JIT/arch-support.txt b/Documentation/features/core/BPF-JIT/arch-support.txt
index 5575d2d09625..b0634ec01881 100644
--- a/Documentation/features/core/BPF-JIT/arch-support.txt
+++ b/Documentation/features/core/BPF-JIT/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index abb5f271a792..e2a1a385efd3 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: |  ok  |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: |  ok  |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index dbdaffcc5110..dafcea38fe5e 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index dfb638c2f842..3d7886fcb6a9 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: |  ok  |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: |  ok  |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: |  ok  |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index 3406fae833c3..63598b0e8ea6 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index 830dbe801aaf..13b3b3dfe7f2 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: |  ok  |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
index 0217bf6e942d..cb4792cf0f98 100644
--- a/Documentation/features/debug/kgdb/arch-support.txt
+++ b/Documentation/features/debug/kgdb/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
     |     mn10300: |  ok  |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 1e84be3c142e..2046539489fe 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index 529f66eda679..bfb3546a70d0 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: |  ok  |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index 43353242e439..cb2213bfadc5 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: |  ok  |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index f559f1ba5416..219aa64ca3f5 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 59a4c9ffb7f3..904864c3f18c 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index 53ed42b0e7e5..d092f000e6bb 100644
--- a/Documentation/features/debug/uprobes/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
index 149443936de9..9e9e195b6d30 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/io/dma-api-debug/arch-support.txt b/Documentation/features/io/dma-api-debug/arch-support.txt
index 6be920643be6..ba9e169859c4 100644
--- a/Documentation/features/io/dma-api-debug/arch-support.txt
+++ b/Documentation/features/io/dma-api-debug/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: |  ok  |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index 0eb08e1e32b8..35b501f2c117 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/io/sg-chain/arch-support.txt b/Documentation/features/io/sg-chain/arch-support.txt
index 514ad3468aa5..42c078dff18b 100644
--- a/Documentation/features/io/sg-chain/arch-support.txt
+++ b/Documentation/features/io/sg-chain/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: |  ok  |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/lib/strncasecmp/arch-support.txt b/Documentation/features/lib/strncasecmp/arch-support.txt
index 532c6f0fc15c..b10c21f14739 100644
--- a/Documentation/features/lib/strncasecmp/arch-support.txt
+++ b/Documentation/features/lib/strncasecmp/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index f3eec26c8cf8..3b87fd37bae8 100644
--- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index 9756abc680a7..cefcd720f04e 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: |  ok  |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index 62f4ee5c156c..da6c7e37141c 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index 321b32f6e63c..1e5dbcdd1c76 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/locking/rwsem-optimized/arch-support.txt b/Documentation/features/locking/rwsem-optimized/arch-support.txt
index 79bfa4d6e41f..b79e92288112 100644
--- a/Documentation/features/locking/rwsem-optimized/arch-support.txt
+++ b/Documentation/features/locking/rwsem-optimized/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: |  ok  |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 00f1606bbf45..6418ccc6fc34 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index 7d516eacf7b9..3b3392ac6466 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index f974b8df5d82..4594cb28fbc8 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 2c815a7f1ba7..42eaab4d439d 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -42,7 +42,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
index 1d3c0f669152..4e67833aae66 100644
--- a/Documentation/features/sched/numa-balancing/arch-support.txt
+++ b/Documentation/features/sched/numa-balancing/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: |  ..  |
     |        m68k: |  ..  |
-    |       metag: |  ..  |
     |  microblaze: |  ..  |
     |        mips: | TODO |
     |     mn10300: |  ..  |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index a32d5b207679..c5d8b397a693 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
index caee8f64d1bc..9e4999136881 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index 1cd87f6cd07d..f90cb64c640b 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: |  ok  |
-    |       metag: |  ok  |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
     |     mn10300: |  ok  |
diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index e6d7c7b2253c..eb4e5d32a2e9 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
index 15c6071788ae..02b7441f360f 100644
--- a/Documentation/features/time/irq-time-acct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: |  ..  |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/time/modern-timekeeping/arch-support.txt b/Documentation/features/time/modern-timekeeping/arch-support.txt
index baee7611ba3d..b3eb6fe6bc27 100644
--- a/Documentation/features/time/modern-timekeeping/arch-support.txt
+++ b/Documentation/features/time/modern-timekeeping/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: |  ok  |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: |  ok  |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
     |     mn10300: |  ok  |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index 9129530cb73c..a1bd77fd723a 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: |  ok  |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index f6829af3255f..3f926177833c 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/vm/PG_uncached/arch-support.txt b/Documentation/features/vm/PG_uncached/arch-support.txt
index 1a09ea99d486..4c8f65d525d7 100644
--- a/Documentation/features/vm/PG_uncached/arch-support.txt
+++ b/Documentation/features/vm/PG_uncached/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: |  ok  |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
index d170e6236503..d121dc2e3e5e 100644
--- a/Documentation/features/vm/THP/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: |  ..  |
     |        m68k: |  ..  |
-    |       metag: | TODO |
     |  microblaze: |  ..  |
     |        mips: |  ok  |
     |     mn10300: |  ..  |
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index abfab4080a91..af233d2d82cf 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: |  ..  |
-    |       metag: | TODO |
     |  microblaze: |  ..  |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index f81f09b22b08..45c74fbe6805 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index 0cc3e11c42e2..6cd436af0cc8 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
diff --git a/Documentation/features/vm/numa-memblock/arch-support.txt b/Documentation/features/vm/numa-memblock/arch-support.txt
index 9a3fdac42ce1..2db895856da6 100644
--- a/Documentation/features/vm/numa-memblock/arch-support.txt
+++ b/Documentation/features/vm/numa-memblock/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: |  ok  |
     |        m32r: | TODO |
     |        m68k: |  ..  |
-    |       metag: |  ok  |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
     |     mn10300: | TODO |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index dfaa39e664ff..ccb15b6da42f 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -19,7 +19,6 @@
     |        ia64: | TODO |
     |        m32r: | TODO |
     |        m68k: | TODO |
-    |       metag: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |     mn10300: | TODO |
-- 
2.13.6
