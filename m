Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeCUCY0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752010AbeCUCVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348FE21857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022130.195605219@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 37/46] tracing: Add inter-event blurb to HIST_TRIGGERS config option
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0037-tracing-Add-inter-event-blurb-to-HIST_TRIGGERS-confi.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

So that users know that inter-event tracing is supported as part of
the HIST_TRIGGERS option, include text to that effect in the help
text.

Link: http://lkml.kernel.org/r/a38e24231d8d980be636b56d35814570acfd167a.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 0b249e2f0c3c..c4f0f2e4126e 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -606,7 +606,10 @@ config HIST_TRIGGERS
 	  event activity as an initial guide for further investigation
 	  using more advanced tools.
 
-	  See Documentation/trace/events.txt.
+	  Inter-event tracing of quantities such as latencies is also
+	  supported using hist triggers under this option.
+
+	  See Documentation/trace/histogram.txt.
 	  If in doubt, say N.
 
 config MMIOTRACE_TEST
-- 
2.15.1
