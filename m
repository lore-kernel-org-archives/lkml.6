Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A5FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1572B20823
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1572B20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbeKAD0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:26:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56210 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbeKADZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:25:22 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHvBy-0005cj-FN; Wed, 31 Oct 2018 19:26:10 +0100
Message-Id: <20181031182252.963632760@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 31 Oct 2018 19:21:10 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        John Stultz <john.stultz@linaro.org>,
        Peter Anvin <hpa@zytor.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Corey Minyard <cminyard@mvista.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        David Riley <davidriley@chromium.org>,
        Colin Cross <ccross@android.com>,
        Mark Brown <broonie@kernel.org>
Subject: [patch 3/9] hrtimers/tick/clockevents: Remove sloppy license
 references
References: <20181031182107.726051323@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=hrtimers--Remove-sloppy-license-references.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"For licencing details see kernel-base/COPYING" and similar license
references have no value over the SPDX identifier. Remove them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/hrtimer.h      |    2 --
 kernel/time/clockevents.c    |    3 ---
 kernel/time/hrtimer.c        |    2 --
 kernel/time/tick-broadcast.c |    3 ---
 kernel/time/tick-common.c    |    3 ---
 kernel/time/tick-oneshot.c   |    3 ---
 kernel/time/tick-sched.c     |    2 --
 kernel/time/timer_list.c     |    4 ----
 8 files changed, 22 deletions(-)

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


