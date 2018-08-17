Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C527C43615
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC590218F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC590218F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeHQPsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbeHQPsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:48:12 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37DD72191E;
        Fri, 17 Aug 2018 12:44:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fqe7Z-0004vU-2Z; Fri, 17 Aug 2018 08:44:53 -0400
Message-Id: <20180817124452.976087171@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 17 Aug 2018 08:44:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 8/8] tracing: Fix SPDX format headers to use C++ style comments
References: <20180817124418.038744612@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The Linux kernel adopted the SPDX License format headers to ease license
compliance management, and uses the C++ '//' style comments for the SPDX
header tags. Some files in the tracing directory used the C style /* */
comments for them. To be consistent across all files, replace the /* */
C style SPDX tags with the C++ // SPDX tags.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                    | 2 +-
 kernel/trace/trace_benchmark.h          | 2 +-
 kernel/trace/trace_entries.h            | 2 +-
 kernel/trace/trace_events_filter_test.h | 2 +-
 kernel/trace/trace_kprobe_selftest.h    | 2 +-
 kernel/trace/trace_output.h             | 2 +-
 kernel/trace/trace_stat.h               | 2 +-
 kernel/trace/tracing_map.h              | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a62b678731e3..3b8c0e24ab30 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 
 #ifndef _LINUX_KERNEL_TRACE_H
 #define _LINUX_KERNEL_TRACE_H
diff --git a/kernel/trace/trace_benchmark.h b/kernel/trace/trace_benchmark.h
index be1d86ff753d..79e6fbe5b365 100644
--- a/kernel/trace/trace_benchmark.h
+++ b/kernel/trace/trace_benchmark.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM benchmark
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 1d67464ed95e..06bb2fd9a56c 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file defines the trace event structures that go into the ring
  * buffer directly. They are created via macros so that changes for them
diff --git a/kernel/trace/trace_events_filter_test.h b/kernel/trace/trace_events_filter_test.h
index 39d7ef4f57cb..e651dfbd345e 100644
--- a/kernel/trace/trace_events_filter_test.h
+++ b/kernel/trace/trace_events_filter_test.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM test
 
diff --git a/kernel/trace/trace_kprobe_selftest.h b/kernel/trace/trace_kprobe_selftest.h
index 4e10ec41c013..c4fc7268ba7c 100644
--- a/kernel/trace/trace_kprobe_selftest.h
+++ b/kernel/trace/trace_kprobe_selftest.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Function used during the kprobe self test. This function is in a separate
  * compile unit so it can be compile with CC_FLAGS_FTRACE to ensure that it
diff --git a/kernel/trace/trace_output.h b/kernel/trace/trace_output.h
index dbba03ed96de..2f742b74e7e6 100644
--- a/kernel/trace/trace_output.h
+++ b/kernel/trace/trace_output.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 #ifndef __TRACE_EVENTS_H
 #define __TRACE_EVENTS_H
 
diff --git a/kernel/trace/trace_stat.h b/kernel/trace/trace_stat.h
index 76d30b4ebe83..8786d17caf49 100644
--- a/kernel/trace/trace_stat.h
+++ b/kernel/trace/trace_stat.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 #ifndef __TRACE_STAT_H
 #define __TRACE_STAT_H
 
diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index 053eb92b2d31..a6de61fc22de 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 #ifndef __TRACING_MAP_H
 #define __TRACING_MAP_H
 
-- 
2.18.0


