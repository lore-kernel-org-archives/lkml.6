Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73661ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD4720840
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD4720840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeGPAAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:00:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40363 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeGPAAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:00:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6FNZEAg922305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Jul 2018 16:35:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6FNZCdR922301;
        Sun, 15 Jul 2018 16:35:12 -0700
Date:   Sun, 15 Jul 2018 16:35:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tobias Tefke <tipbot@zytor.com>
Message-ID: <tip-788faab70d5a882693286b8d5022779559c79904@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        peterz@infradead.org, tobias.tefke@gmail.com,
        tobias.tefke@tutanota.com
Reply-To: tglx@linutronix.de, mingo@kernel.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, peterz@infradead.org, tobias.tefke@tutanota.com,
          tobias.tefke@gmail.com
In-Reply-To: <20180709105715.22938-1-tobias.tefke@tutanota.com>
References: <20180709105715.22938-1-tobias.tefke@tutanota.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf, tools: Use correct articles in comments
Git-Commit-ID: 788faab70d5a882693286b8d5022779559c79904
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  788faab70d5a882693286b8d5022779559c79904
Gitweb:     https://git.kernel.org/tip/788faab70d5a882693286b8d5022779559c79904
Author:     Tobias Tefke <tobias.tefke@gmail.com>
AuthorDate: Mon, 9 Jul 2018 12:57:15 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 16 Jul 2018 00:21:03 +0200

perf, tools: Use correct articles in comments

Some of the comments in the perf events code use articles incorrectly,
using 'a' for words beginning with a vowel sound, where 'an' should be
used.

Signed-off-by: Tobias Tefke <tobias.tefke@tutanota.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: alexander.shishkin@linux.intel.com
Cc: jolsa@redhat.com
Cc: namhyung@kernel.org
Link: http://lkml.kernel.org/r/20180709105715.22938-1-tobias.tefke@tutanota.com
[ Fix a few more perf related 'a event' typo fixes from all around the kernel and tooling tree. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/powerpc/perf/core-book3s.c          |  6 +++---
 include/linux/perf_event.h               |  2 +-
 kernel/events/core.c                     | 16 ++++++++--------
 kernel/events/uprobes.c                  |  6 +++---
 tools/perf/Documentation/perf-list.txt   |  2 +-
 tools/perf/Documentation/perf-record.txt |  4 ++--
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 3f66fcf8ad99..19d8ab49d1bd 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1469,7 +1469,7 @@ static int collect_events(struct perf_event *group, int max_count,
 }
 
 /*
- * Add a event to the PMU.
+ * Add an event to the PMU.
  * If all events are not already frozen, then we disable and
  * re-enable the PMU in order to get hw_perf_enable to do the
  * actual work of reconfiguring the PMU.
@@ -1548,7 +1548,7 @@ nocheck:
 }
 
 /*
- * Remove a event from the PMU.
+ * Remove an event from the PMU.
  */
 static void power_pmu_del(struct perf_event *event, int ef_flags)
 {
@@ -1742,7 +1742,7 @@ static int power_pmu_commit_txn(struct pmu *pmu)
 /*
  * Return 1 if we might be able to put event on a limited PMC,
  * or 0 if not.
- * A event can only go on a limited PMC if it counts something
+ * An event can only go on a limited PMC if it counts something
  * that a limited PMC can count, doesn't require interrupts, and
  * doesn't exclude any processor mode.
  */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1fa12887ec02..e6dd3a2f8ec4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -490,7 +490,7 @@ struct perf_addr_filters_head {
 };
 
 /**
- * enum perf_event_state - the states of a event
+ * enum perf_event_state - the states of an event:
  */
 enum perf_event_state {
 	PERF_EVENT_STATE_DEAD		= -4,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a4d5ac6d74af..86b31e5a5a9a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1656,7 +1656,7 @@ perf_event_groups_next(struct perf_event *event)
 				typeof(*event), group_node))
 
 /*
- * Add a event from the lists for its context.
+ * Add an event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
  */
 static void
@@ -1844,7 +1844,7 @@ static void perf_group_attach(struct perf_event *event)
 }
 
 /*
- * Remove a event from the lists for its context.
+ * Remove an event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
  */
 static void
@@ -2148,7 +2148,7 @@ static void __perf_event_disable(struct perf_event *event,
 }
 
 /*
- * Disable a event.
+ * Disable an event.
  *
  * If event->ctx is a cloned context, callers must make sure that
  * every task struct that event->ctx->task could possibly point to
@@ -2677,7 +2677,7 @@ static void __perf_event_enable(struct perf_event *event,
 }
 
 /*
- * Enable a event.
+ * Enable an event.
  *
  * If event->ctx is a cloned context, callers must make sure that
  * every task struct that event->ctx->task could possibly point to
@@ -2755,7 +2755,7 @@ static int __perf_event_stop(void *info)
 	 * events will refuse to restart because of rb::aux_mmap_count==0,
 	 * see comments in perf_aux_output_begin().
 	 *
-	 * Since this is happening on a event-local CPU, no trace is lost
+	 * Since this is happening on an event-local CPU, no trace is lost
 	 * while restarting.
 	 */
 	if (sd->restart)
@@ -4827,7 +4827,7 @@ __perf_read(struct perf_event *event, char __user *buf, size_t count)
 	int ret;
 
 	/*
-	 * Return end-of-file for a read on a event that is in
+	 * Return end-of-file for a read on an event that is in
 	 * error state (i.e. because it was pinned but it couldn't be
 	 * scheduled on to the CPU at some point).
 	 */
@@ -9898,7 +9898,7 @@ enabled:
 }
 
 /*
- * Allocate and initialize a event structure
+ * Allocate and initialize an event structure
  */
 static struct perf_event *
 perf_event_alloc(struct perf_event_attr *attr, int cpu,
@@ -11229,7 +11229,7 @@ const struct perf_event_attr *perf_event_attrs(struct perf_event *event)
 }
 
 /*
- * Inherit a event from parent task to child task.
+ * Inherit an event from parent task to child task.
  *
  * Returns:
  *  - valid pointer on success
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ccc579a7d32e..aed1ba569954 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -918,7 +918,7 @@ int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *
 EXPORT_SYMBOL_GPL(uprobe_register);
 
 /*
- * uprobe_apply - unregister a already registered probe.
+ * uprobe_apply - unregister an already registered probe.
  * @inode: the file in which the probe has to be removed.
  * @offset: offset from the start of the file.
  * @uc: consumer which wants to add more or remove some breakpoints
@@ -947,7 +947,7 @@ int uprobe_apply(struct inode *inode, loff_t offset,
 }
 
 /*
- * uprobe_unregister - unregister a already registered probe.
+ * uprobe_unregister - unregister an already registered probe.
  * @inode: the file in which the probe has to be removed.
  * @offset: offset from the start of the file.
  * @uc: identify which probe if multiple probes are colocated.
@@ -1403,7 +1403,7 @@ static struct return_instance *free_ret_instance(struct return_instance *ri)
 
 /*
  * Called with no locks held.
- * Called in context of a exiting or a exec-ing thread.
+ * Called in context of an exiting or an exec-ing thread.
  */
 void uprobe_free_utask(struct task_struct *t)
 {
diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 11300dbe35c5..14e13512c05f 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -234,7 +234,7 @@ perf also supports group leader sampling using the :S specifier.
   perf record -e '{cycles,instructions}:S' ...
   perf report --group
 
-Normally all events in a event group sample, but with :S only
+Normally all events in an event group sample, but with :S only
 the first event (the leader) samples, and it only reads the values of the
 other events in the group.
 
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 04168da4268e..246dee081efd 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -94,7 +94,7 @@ OPTIONS
 	  "perf report" to view group events together.
 
 --filter=<filter>::
-        Event filter. This option should follow a event selector (-e) which
+        Event filter. This option should follow an event selector (-e) which
 	selects either tracepoint event(s) or a hardware trace PMU
 	(e.g. Intel PT or CoreSight).
 
@@ -153,7 +153,7 @@ OPTIONS
 
 --exclude-perf::
 	Don't record events issued by perf itself. This option should follow
-	a event selector (-e) which selects tracepoint event(s). It adds a
+	an event selector (-e) which selects tracepoint event(s). It adds a
 	filter expression 'common_pid != $PERFPID' to filters. If other
 	'--filter' exists, the new filter expression will be combined with
 	them by '&&'.
