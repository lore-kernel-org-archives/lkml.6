Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935635AbeE2PXl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935444AbeE2PX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:29 -0400
Message-Id: <20180529152326.148099543@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 29 May 2018 11:23:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: [for-next][PATCH 02/19] tracepoints: Fix the descriptions of tracepoint_probe_register{_prio}
References: <20180529152304.885389740@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0002-tracepoints-Fix-the-descriptions-of-tracepoint_probe.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>

The description of tracepoint_probe_register duplicates
with tracepoint_probe_register_prio. This patch cleans up
the descriptions.

Link: http://lkml.kernel.org/r/20170616082643.7311-1-jlee@suse.com

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/tracepoint.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 1e37da2e0c25..6dc6356c3327 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -257,7 +257,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 }
 
 /**
- * tracepoint_probe_register -  Connect a probe to a tracepoint
+ * tracepoint_probe_register_prio -  Connect a probe to a tracepoint with priority
  * @tp: tracepoint
  * @probe: probe handler
  * @data: tracepoint data
@@ -290,7 +290,6 @@ EXPORT_SYMBOL_GPL(tracepoint_probe_register_prio);
  * @tp: tracepoint
  * @probe: probe handler
  * @data: tracepoint data
- * @prio: priority of this function over other registered functions
  *
  * Returns 0 if ok, error value on error.
  * Note: if @tp is within a module, the caller is responsible for
-- 
2.17.0
