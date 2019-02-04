Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4133C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01C920820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfBDIuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:50:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38057 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDIuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:50:10 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148nwQ1357043
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:49:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148nwHU357040;
        Mon, 4 Feb 2019 00:49:58 -0800
Date:   Mon, 4 Feb 2019 00:49:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-8e86e01526764e8cdc77b80a8f24f33e6847b9e7@git.kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org, jolsa@redhat.com,
        hpa@zytor.com, gregkh@linuxfoundation.org, acme@redhat.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com
Reply-To: gregkh@linuxfoundation.org, acme@redhat.com,
          kstewart@linuxfoundation.org, tglx@linutronix.de,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, jolsa@redhat.com,
          torvalds@linux-foundation.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20190116111308.012666937@linutronix.de>
References: <20190116111308.012666937@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Convert to SPDX license identifiers
Git-Commit-ID: 8e86e01526764e8cdc77b80a8f24f33e6847b9e7
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

Commit-ID:  8e86e01526764e8cdc77b80a8f24f33e6847b9e7
Gitweb:     https://git.kernel.org/tip/8e86e01526764e8cdc77b80a8f24f33e6847b9e7
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 16 Jan 2019 12:10:59 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:46:11 +0100

perf/core: Convert to SPDX license identifiers

Use proper SPDX license identifiers instead of the bogus reference to
kernel-base/COPYING.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190116111308.012666937@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/callchain.c   | 3 +--
 kernel/events/core.c        | 3 +--
 kernel/events/ring_buffer.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 24a77c34e9ad..c2b41a263166 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Performance events callchain code, extracted from core.c:
  *
@@ -5,8 +6,6 @@
  *  Copyright (C) 2008-2011 Red Hat, Inc., Ingo Molnar
  *  Copyright (C) 2008-2011 Red Hat, Inc., Peter Zijlstra
  *  Copyright  ©  2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
- *
- * For licensing details see kernel-base/COPYING
  */
 
 #include <linux/perf_event.h>
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 280a72b3a553..5b89de7918d0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Performance events core code:
  *
@@ -5,8 +6,6 @@
  *  Copyright (C) 2008-2011 Red Hat, Inc., Ingo Molnar
  *  Copyright (C) 2008-2011 Red Hat, Inc., Peter Zijlstra
  *  Copyright  ©  2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
- *
- * For licensing details see kernel-base/COPYING
  */
 
 #include <linux/fs.h>
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 309ef5a64af5..ed6409300ef5 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Performance events ring-buffer code:
  *
@@ -5,8 +6,6 @@
  *  Copyright (C) 2008-2011 Red Hat, Inc., Ingo Molnar
  *  Copyright (C) 2008-2011 Red Hat, Inc., Peter Zijlstra
  *  Copyright  ©  2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
- *
- * For licensing details see kernel-base/COPYING
  */
 
 #include <linux/perf_event.h>
