Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A8FC43613
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957DA2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbfAPLUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:20:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44739 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbfAPLUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:20:08 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjjEt-000609-Fi; Wed, 16 Jan 2019 12:20:07 +0100
Message-Id: <20190116111308.012666937@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 16 Jan 2019 12:10:59 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [patch 1/3] perf/core: Convert to SPDX license identifiers
References: <20190116111058.444514201@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use proper SPDX license identifiers instead of the bogus reference to
kernel-base/COPYING.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/events/callchain.c   |    3 +--
 kernel/events/core.c        |    3 +--
 kernel/events/ring_buffer.c |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

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


