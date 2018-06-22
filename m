Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1ACC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F383A23F78
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F383A23F78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeFVJQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:16:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39539 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeFVJQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:16:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5M9Fp2q018691
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 02:15:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5M9FoSd018688;
        Fri, 22 Jun 2018 02:15:50 -0700
Date:   Fri, 22 Jun 2018 02:15:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masami Hiramatsu <tipbot@zytor.com>
Message-ID: <tip-01bdee64f9cf8e15f998bf52789ed9d0ebdfa621@git.kernel.org>
Cc:     corbet@lwn.net, torvalds@linux-foundation.org, hpa@zytor.com,
        rdunlap@infradead.org, mhiramat@kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        ananth@linux.vnet.ibm.com
Reply-To: peterz@infradead.org, rdunlap@infradead.org, mhiramat@kernel.org,
          corbet@lwn.net, hpa@zytor.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, akpm@linux-foundation.org,
          ananth@linux.vnet.ibm.com, mingo@kernel.org, rostedt@goodmis.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180622150740.bd26241032c972d86e23bf73@kernel.org>
References: <20180622150740.bd26241032c972d86e23bf73@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] kprobes/Documentation: Fix various typos
Git-Commit-ID: 01bdee64f9cf8e15f998bf52789ed9d0ebdfa621
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

Commit-ID:  01bdee64f9cf8e15f998bf52789ed9d0ebdfa621
Gitweb:     https://git.kernel.org/tip/01bdee64f9cf8e15f998bf52789ed9d0ebdfa621
Author:     Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate: Fri, 22 Jun 2018 15:07:40 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 22 Jun 2018 11:10:55 +0200

kprobes/Documentation: Fix various typos

Fix typos and clean up the wording, with the help of Randy Dunlap.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/20180622150740.bd26241032c972d86e23bf73@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/kprobes.txt | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 13d8efdb9718..10f4499e677c 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -83,22 +83,22 @@ Execution then continues with the instruction following the probepoint.
 Changing Execution Path
 -----------------------
 
-Since the kprobes can probe into a running kernel code, it can change
-the register set, including instruction pointer. This operation
-requires maximum attention, such as keeping the stack frame, recovering
-execution path etc. Since it is operated on running kernel and need deep
-knowladge of the archtecture and concurrent computing, you can easily
-shot your foot.
+Since kprobes can probe into a running kernel code, it can change the
+register set, including instruction pointer. This operation requires
+maximum care, such as keeping the stack frame, recovering the execution
+path etc. Since it operates on a running kernel and needs deep knowledge
+of computer architecture and concurrent computing, you can easily shoot
+your foot.
 
 If you change the instruction pointer (and set up other related
-registers) in pre_handler, you must return !0 so that the kprobes
-stops single stepping and just returns to given address.
+registers) in pre_handler, you must return !0 so that kprobes stops
+single stepping and just returns to the given address.
 This also means post_handler should not be called anymore.
 
-Note that this operation may be harder on some architectures which
-use TOC (Table of Contents) for function call, since you have to
-setup new TOC for your function in your module, and recover old
-one after back from it.
+Note that this operation may be harder on some architectures which use
+TOC (Table of Contents) for function call, since you have to setup a new
+TOC for your function in your module, and recover the old one after
+returning from it.
 
 Return Probes
 -------------
