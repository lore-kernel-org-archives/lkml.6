Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeCUCV0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbeCUCVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D16217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022123.271656937@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:20:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 02/46] tracing: Add Documentation for log2 modifier
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0002-tracing-Add-Documentation-for-log2-modifier.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add a line for the log2 modifier, to keep it aligned with
tracing/README.

Link: http://lkml.kernel.org/r/a419028bccab155749a4b8702d5b97af75f1578f.1516069914.git.tom.zanussi@linux.intel.com

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/histogram.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
index b2145f44b190..a4143f04a097 100644
--- a/Documentation/trace/histogram.txt
+++ b/Documentation/trace/histogram.txt
@@ -73,6 +73,7 @@
 	.sym-offset display an address as a symbol and offset
 	.syscall    display a syscall id as a system call name
 	.execname   display a common_pid as a program name
+	.log2       display log2 value rather than raw number
 
   Note that in general the semantics of a given field aren't
   interpreted when applying a modifier to it, but there are some
-- 
2.15.1
