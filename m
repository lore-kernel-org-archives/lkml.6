Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5F6C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800452070C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 03:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546573085;
	bh=MufWpyPROpFcgpKdatLlAP0pSvE+OH0Jz6XMWjMLJtU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yAxSsswjD6Itf2gonsuk7F8OivUNHxp9aRIABfPNSpTjWfr7WuCCzPdqD4EfT2Fco
	 OwYckiSg3SleKzT60gJuVZdIrO+1ko3c7so5WQ9shS4o34cyZWlV2GHn8Sj8ONSIa7
	 iqEa5aSNClhRZvDVlPhX/q2xFnsvD+HNCoDEFMnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfADDhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 22:37:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfADDhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 22:37:24 -0500
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A9942070C;
        Fri,  4 Jan 2019 03:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546573041;
        bh=MufWpyPROpFcgpKdatLlAP0pSvE+OH0Jz6XMWjMLJtU=;
        h=From:To:Cc:Subject:Date:From;
        b=cvUwZQFcNJ2/4zfWGFh52ok72F2G6VX/1lu96vfdWBEPn9pHsoBfyanG2Z7CpegEV
         1EFeAdhUcl/gj2XufY0wex079SGnKCIdyiq0qlHX9ATLp+oqZhdH8VjW93g5DEfUqe
         Wm6Y5mtLhU5AFt6wsNyOGoQctgeGxQEyV8rtzU3Y=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] Documentation/features: Add csky kernel features
Date:   Fri,  4 Jan 2019 11:34:26 +0800
Message-Id: <1546572866-31657-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

      core/ cBPF-JIT             : TODO |
      core/ eBPF-JIT             : TODO |
      core/ generic-idle-thread  :  ok  |
      core/ jump-labels          : TODO |
      core/ tracehook            :  ok  |
     debug/ KASAN                : TODO |
     debug/ gcov-profile-all     : TODO |
     debug/ kgdb                 : TODO |
     debug/ kprobes-on-ftrace    : TODO |
     debug/ kprobes              : TODO |
     debug/ kretprobes           : TODO |
     debug/ optprobes            : TODO |
     debug/ stackprotector       : TODO |
     debug/ uprobes              : TODO |
     debug/ user-ret-profiler    : TODO |
        io/ dma-contiguous       :  ok  |
        io/ sg-chain             : TODO |
   locking/ cmpxchg-local        : TODO |
   locking/ lockdep              : TODO |
   locking/ queued-rwlocks       :  ok  |
   locking/ queued-spinlocks     : TODO |
   locking/ rwsem-optimized      : TODO |
      perf/ kprobes-event        : TODO |
      perf/ perf-regs            : TODO |
      perf/ perf-stackdump       : TODO |
     sched/ membarrier-sync-core : TODO |
     sched/ numa-balancing       :  ..  |
   seccomp/ seccomp-filter       : TODO |
      time/ arch-tick-broadcast  : TODO |
      time/ clockevents          :  ok  |
      time/ context-tracking     : TODO |
      time/ irq-time-acct        : TODO |
      time/ modern-timekeeping   :  ok  |
      time/ virt-cpuacct         : TODO |
        vm/ ELF-ASLR             : TODO |
        vm/ PG_uncached          : TODO |
        vm/ THP                  :  ..  |
        vm/ batch-unmap-tlb-flush: TODO |
        vm/ huge-vmap            : TODO |
        vm/ ioremap_prot         : TODO |
        vm/ numa-memblock        :  ..  |
        vm/ pte_special          : TODO |

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/features/core/cBPF-JIT/arch-support.txt              | 1 +
 Documentation/features/core/eBPF-JIT/arch-support.txt              | 1 +
 Documentation/features/core/generic-idle-thread/arch-support.txt   | 1 +
 Documentation/features/core/jump-labels/arch-support.txt           | 1 +
 Documentation/features/core/tracehook/arch-support.txt             | 1 +
 Documentation/features/debug/KASAN/arch-support.txt                | 1 +
 Documentation/features/debug/gcov-profile-all/arch-support.txt     | 1 +
 Documentation/features/debug/kgdb/arch-support.txt                 | 1 +
 Documentation/features/debug/kprobes-on-ftrace/arch-support.txt    | 1 +
 Documentation/features/debug/kprobes/arch-support.txt              | 1 +
 Documentation/features/debug/kretprobes/arch-support.txt           | 1 +
 Documentation/features/debug/optprobes/arch-support.txt            | 1 +
 Documentation/features/debug/stackprotector/arch-support.txt       | 1 +
 Documentation/features/debug/uprobes/arch-support.txt              | 1 +
 Documentation/features/debug/user-ret-profiler/arch-support.txt    | 1 +
 Documentation/features/io/dma-contiguous/arch-support.txt          | 1 +
 Documentation/features/io/sg-chain/arch-support.txt                | 1 +
 Documentation/features/locking/cmpxchg-local/arch-support.txt      | 1 +
 Documentation/features/locking/lockdep/arch-support.txt            | 1 +
 Documentation/features/locking/queued-rwlocks/arch-support.txt     | 1 +
 Documentation/features/locking/queued-spinlocks/arch-support.txt   | 1 +
 Documentation/features/locking/rwsem-optimized/arch-support.txt    | 1 +
 Documentation/features/perf/kprobes-event/arch-support.txt         | 1 +
 Documentation/features/perf/perf-regs/arch-support.txt             | 1 +
 Documentation/features/perf/perf-stackdump/arch-support.txt        | 1 +
 Documentation/features/sched/membarrier-sync-core/arch-support.txt | 1 +
 Documentation/features/sched/numa-balancing/arch-support.txt       | 1 +
 Documentation/features/seccomp/seccomp-filter/arch-support.txt     | 1 +
 Documentation/features/time/arch-tick-broadcast/arch-support.txt   | 1 +
 Documentation/features/time/clockevents/arch-support.txt           | 1 +
 Documentation/features/time/context-tracking/arch-support.txt      | 1 +
 Documentation/features/time/irq-time-acct/arch-support.txt         | 1 +
 Documentation/features/time/modern-timekeeping/arch-support.txt    | 1 +
 Documentation/features/time/virt-cpuacct/arch-support.txt          | 1 +
 Documentation/features/vm/ELF-ASLR/arch-support.txt                | 1 +
 Documentation/features/vm/PG_uncached/arch-support.txt             | 1 +
 Documentation/features/vm/THP/arch-support.txt                     | 1 +
 Documentation/features/vm/TLB/arch-support.txt                     | 1 +
 Documentation/features/vm/huge-vmap/arch-support.txt               | 1 +
 Documentation/features/vm/ioremap_prot/arch-support.txt            | 1 +
 Documentation/features/vm/numa-memblock/arch-support.txt           | 1 +
 Documentation/features/vm/pte_special/arch-support.txt             | 1 +
 42 files changed, 42 insertions(+)

diff --git a/Documentation/features/core/cBPF-JIT/arch-support.txt b/Documentation/features/core/cBPF-JIT/arch-support.txt
index 90459cd..8620c38 100644
--- a/Documentation/features/core/cBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/cBPF-JIT/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
index c90a038..9ae6e8d 100644
--- a/Documentation/features/core/eBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index 0ef6acd..365df2c 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: |  ok  |
diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index 27cbd63a..c29146c 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index f44c274..d344b99 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: |  ok  |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: |  ok  |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index 282ecc8..304dcd4 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index 01b2b30..059d58a 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
index 3b4dff2..3e6b8f0 100644
--- a/Documentation/features/debug/kgdb/arch-support.txt
+++ b/Documentation/features/debug/kgdb/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 7e963d0..68f2669 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index 4ada027..f4e45bd 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index 044e13f..1d5651e 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index dce7669..fb297a8 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: | TODO |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 954ac1c..9999ea5 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index 1a3f9d3..1c577d0 100644
--- a/Documentation/features/debug/uprobes/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
index 1d78d10..6bfa36b 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index 30c072d..eb28b5c 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/io/sg-chain/arch-support.txt b/Documentation/features/io/sg-chain/arch-support.txt
index 6554f03..eac96f9 100644
--- a/Documentation/features/io/sg-chain/arch-support.txt
+++ b/Documentation/features/io/sg-chain/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index 51704a2..242ff5a 100644
--- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index bd39c5e..941fd5b 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index da7aff3..c683da1 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index 478e910..e3080b8 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/locking/rwsem-optimized/arch-support.txt b/Documentation/features/locking/rwsem-optimized/arch-support.txt
index e54b1f1..7521d75 100644
--- a/Documentation/features/locking/rwsem-optimized/arch-support.txt
+++ b/Documentation/features/locking/rwsem-optimized/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 7331402..d8278bf 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index 53feeee..687d049 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index 1616434..90996e3 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index c7858dd..8a521a6 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -34,6 +34,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
index c68bb2c..3508236 100644
--- a/Documentation/features/sched/numa-balancing/arch-support.txt
+++ b/Documentation/features/sched/numa-balancing/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ..  |
     |       arm64: |  ok  |
     |         c6x: |  ..  |
+    |        csky: |  ..  |
     |       h8300: |  ..  |
     |     hexagon: |  ..  |
     |        ia64: | TODO |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index d4271b4..4fe6c3c 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
index 83d9e68..593536f7 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index 3d4908f..7a27157 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: |  ok  |
+    |        csky: |  ok  |
     |       h8300: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index c29974a..048bfb6 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
index 8d73c46..a14bbad 100644
--- a/Documentation/features/time/irq-time-acct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ..  |
diff --git a/Documentation/features/time/modern-timekeeping/arch-support.txt b/Documentation/features/time/modern-timekeeping/arch-support.txt
index e7c6ea6..2855dfe 100644
--- a/Documentation/features/time/modern-timekeeping/arch-support.txt
+++ b/Documentation/features/time/modern-timekeeping/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: |  ok  |
     |         c6x: |  ok  |
+    |        csky: |  ok  |
     |       h8300: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: |  ok  |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index 4646457..fb0d0ca 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index 1f71d09..adc2587 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/vm/PG_uncached/arch-support.txt b/Documentation/features/vm/PG_uncached/arch-support.txt
index fbd5aa4..f05588f 100644
--- a/Documentation/features/vm/PG_uncached/arch-support.txt
+++ b/Documentation/features/vm/PG_uncached/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
index 5d7ecc3..cdfe892 100644
--- a/Documentation/features/vm/THP/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: |  ..  |
+    |        csky: |  ..  |
     |       h8300: |  ..  |
     |     hexagon: |  ..  |
     |        ia64: | TODO |
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index f7af967..2bdd3b6 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: |  ..  |
+    |        csky: | TODO |
     |       h8300: |  ..  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index d0713cc..019131c 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index 8527601..c6f3e4d 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/vm/numa-memblock/arch-support.txt b/Documentation/features/vm/numa-memblock/arch-support.txt
index 1a98805..3004beb 100644
--- a/Documentation/features/vm/numa-memblock/arch-support.txt
+++ b/Documentation/features/vm/numa-memblock/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ..  |
     |       arm64: |  ok  |
     |         c6x: |  ..  |
+    |        csky: |  ..  |
     |       h8300: |  ..  |
     |     hexagon: |  ..  |
     |        ia64: |  ok  |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index a837842..2dc5df6 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-- 
2.7.4

