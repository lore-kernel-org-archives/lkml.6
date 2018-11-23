Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD5EC04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7293520820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7293520820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503718AbeKWWEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:04:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57673 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbeKWWEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:04:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wANBKAU14176245
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Nov 2018 03:20:10 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wANBK9Gc4176241;
        Fri, 23 Nov 2018 03:20:09 -0800
Date:   Fri, 23 Nov 2018 03:20:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-f49c174b5f431db9fa17315269e288d4548b651c@git.kernel.org>
Cc:     nicolas.pitre@linaro.org, rmk+kernel@armlinux.org.uk,
        peterz@infradead.org, mingo@kernel.org, richardcochran@gmail.com,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        broonie@kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, cminyard@mvista.com,
        ccross@android.com, tglx@linutronix.de, john.stultz@linaro.org,
        paulmck@linux.vnet.ibm.com, davidriley@chromium.org
Reply-To: tglx@linutronix.de, ccross@android.com, davidriley@chromium.org,
          paulmck@linux.vnet.ibm.com, john.stultz@linaro.org,
          broonie@kernel.org, pombredanne@nexb.com,
          kstewart@linuxfoundation.org, richardcochran@gmail.com,
          rmk+kernel@armlinux.org.uk, mingo@kernel.org,
          peterz@infradead.org, nicolas.pitre@linaro.org,
          cminyard@mvista.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          keescook@chromium.org
In-Reply-To: <20181031182252.963632760@linutronix.de>
References: <20181031182252.963632760@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] hrtimers/tick/clockevents: Remove sloppy license
 references
Git-Commit-ID: f49c174b5f431db9fa17315269e288d4548b651c
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

Commit-ID:  f49c174b5f431db9fa17315269e288d4548b651c
Gitweb:     https://git.kernel.org/tip/f49c174b5f431db9fa17315269e288d4548b651c
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 31 Oct 2018 19:21:10 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 23 Nov 2018 11:51:21 +0100

hrtimers/tick/clockevents: Remove sloppy license references

"For licencing details see kernel-base/COPYING" and similar license
references have no value over the SPDX identifier. Remove them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: John Stultz <john.stultz@linaro.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Peter Anvin <hpa@zytor.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: David Riley <davidriley@chromium.org>
Cc: Colin Cross <ccross@android.com>
Cc: Mark Brown <broonie@kernel.org>
Link: https://lkml.kernel.org/r/20181031182252.963632760@linutronix.de

---
 include/linux/hrtimer.h      | 2 --
 kernel/time/clockevents.c    | 3 ---
 kernel/time/hrtimer.c        | 2 --
 kernel/time/tick-broadcast.c | 3 ---
 kernel/time/tick-common.c    | 3 ---
 kernel/time/tick-oneshot.c   | 3 ---
 kernel/time/tick-sched.c     | 2 --
 kernel/time/timer_list.c     | 4 ----
 8 files changed, 22 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 851e4231d3ab..2e8957eac4d4 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -8,8 +8,6 @@
  *  data type definitions, declarations, prototypes
  *
  *  Started by: Thomas Gleixner and Ingo Molnar
- *
- *  For licencing details see kernel-base/COPYING
  */
 #ifndef _LINUX_HRTIMER_H
 #define _LINUX_HRTIMER_H
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 0fdbdf17f8a2..5e77662dd2d9 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -5,9 +5,6 @@
  * Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  * Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  * Copyright(C) 2006-2007, Timesys Corp., Thomas Gleixner
- *
- * This code is licenced under the GPL version 2. For details see
- * kernel-base/COPYING.
  */
 
 #include <linux/clockchips.h>
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 16dacc8d3ca2..f5cfa1b73d6f 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -20,8 +20,6 @@
  *
  *	George Anzinger, Andrew Morton, Steven Rostedt, Roman Zippel
  *	et. al.
- *
- *  For licencing details see kernel-base/COPYING
  */
 
 #include <linux/cpu.h>
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index f4725f53d852..803fa67aace9 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -6,9 +6,6 @@
  * Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  * Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  * Copyright(C) 2006-2007, Timesys Corp., Thomas Gleixner
- *
- * This code is licenced under the GPL version 2. For details see
- * kernel-base/COPYING.
  */
 #include <linux/cpu.h>
 #include <linux/err.h>
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 455b8d65a2b7..529143b4c8d2 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -6,9 +6,6 @@
  * Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  * Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  * Copyright(C) 2006-2007, Timesys Corp., Thomas Gleixner
- *
- * This code is licenced under the GPL version 2. For details see
- * kernel-base/COPYING.
  */
 #include <linux/cpu.h>
 #include <linux/err.h>
diff --git a/kernel/time/tick-oneshot.c b/kernel/time/tick-oneshot.c
index 1c8ad0fb33c0..f9745d47425a 100644
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -6,9 +6,6 @@
  * Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  * Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  * Copyright(C) 2006-2007, Timesys Corp., Thomas Gleixner
- *
- * This code is licenced under the GPL version 2. For details see
- * kernel-base/COPYING.
  */
 #include <linux/cpu.h>
 #include <linux/err.h>
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 62ecb2a802ca..6fa52cd6df0b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -7,8 +7,6 @@
  *  No idle tick implementation for low and high resolution timers
  *
  *  Started by: Thomas Gleixner and Ingo Molnar
- *
- *  Distribute under GPLv2.
  */
 #include <linux/cpu.h>
 #include <linux/err.h>
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index f81693cdf981..98ba50dcb1b2 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -3,10 +3,6 @@
  * List pending timers
  *
  * Copyright(C) 2006, Red Hat, Inc., Ingo Molnar
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/proc_fs.h>
