Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbeCOGGp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 02:06:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750726AbeCOGGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 02:06:43 -0400
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: peterx@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] trace: fix missing tab for hwlat_detector
Date: Thu, 15 Mar 2018 14:06:39 +0800
Message-Id: <20180315060639.9578-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been missing for a while but no one is touching that up.  Fix it.

CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 kernel/trace/trace_entries.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index e954ae3d82c0..e3a658bac10f 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -356,7 +356,7 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 		__field(	unsigned int,		seqnum		)
 	),
 
-	F_printk("cnt:%u\tts:%010llu.%010lu\tinner:%llu\touter:%llunmi-ts:%llu\tnmi-count:%u\n",
+	F_printk("cnt:%u\tts:%010llu.%010lu\tinner:%llu\touter:%llu\tnmi-ts:%llu\tnmi-count:%u\n",
 		 __entry->seqnum,
 		 __entry->tv_sec,
 		 __entry->tv_nsec,
-- 
2.14.3
