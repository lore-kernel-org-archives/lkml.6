Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C88BECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD12A2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD12A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbeKADZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:25:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56207 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729874AbeKADZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:25:23 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHvBw-0005cd-R7; Wed, 31 Oct 2018 19:26:09 +0100
Message-Id: <20181031182252.794898238@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 31 Oct 2018 19:21:08 +0100
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
Subject: [patch 1/9] time: Remove useless filenames in top level comments
References: <20181031182107.726051323@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=time--Remove-useless-filenames-in-top-level-comments.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the pointless filenames in the top level comments. They have no
value at all and just occupy space. While at it tidy up some of the
comments and remove a stale one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/hrtimer.h              |    2 --
 kernel/time/clockevents.c            |    2 --
 kernel/time/clocksource.c            |    5 -----
 kernel/time/hrtimer.c                |   16 ++++------------
 kernel/time/itimer.c                 |    2 --
 kernel/time/jiffies.c                |    2 --
 kernel/time/posix-clock.c            |    2 +-
 kernel/time/posix-timers.c           |    4 ----
 kernel/time/sched_clock.c            |    4 ++--
 kernel/time/tick-broadcast-hrtimer.c |    4 +---
 kernel/time/tick-broadcast.c         |    2 --
 kernel/time/tick-common.c            |    2 --
 kernel/time/tick-oneshot.c           |    2 --
 kernel/time/tick-sched.c             |    2 --
 kernel/time/time.c                   |   12 ++++--------
 kernel/time/timecounter.c            |    6 +-----
 kernel/time/timekeeping.c            |   10 ++--------
 kernel/time/timer.c                  |    2 --
 kernel/time/timer_list.c             |    2 --
 19 files changed, 15 insertions(+), 68 deletions(-)

--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -1,6 +1,4 @@
 /*
- *  include/linux/hrtimer.h
- *
  *  hrtimers - High-resolution kernel timers
  *
  *   Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/time/clockevents.c
- *
  * This file contains functions which manage clock event devices.
  *
  * Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/time/clocksource.c
- *
  * This file contains the functions which manage clocksource drivers.
  *
  * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
@@ -18,9 +16,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * TODO WishList:
- *   o Allow clocksource drivers to be unregistered
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1,26 +1,18 @@
 /*
- *  linux/kernel/hrtimer.c
- *
  *  Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  *  Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  *  Copyright(C) 2006-2007  Timesys Corp., Thomas Gleixner
  *
  *  High-resolution kernel timers
  *
- *  In contrast to the low-resolution timeout API implemented in
- *  kernel/timer.c, hrtimers provide finer resolution and accuracy
- *  depending on system configuration and capabilities.
- *
- *  These timers are currently used for:
- *   - itimers
- *   - POSIX timers
- *   - nanosleep
- *   - precise in-kernel timing
+ *  In contrast to the low-resolution timeout API, aka timer wheel,
+ *  hrtimers provide finer resolution and accuracy depending on system
+ *  configuration and capabilities.
  *
  *  Started by: Thomas Gleixner and Ingo Molnar
  *
  *  Credits:
- *	based on kernel/timer.c
+ *	Based on the original timer wheel code
  *
  *	Help, testing, suggestions, bugfixes, improvements were
  *	provided by:
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/itimer.c
- *
  * Copyright (C) 1992 Darren Senn
  */
 
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -1,6 +1,4 @@
 /***********************************************************************
-* linux/kernel/time/jiffies.c
-*
 * This file contains the jiffies based clocksource.
 *
 * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -1,5 +1,5 @@
 /*
- * posix-clock.c - support for dynamic clock devices
+ * Support for dynamic clock devices
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
  *
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1,10 +1,6 @@
 /*
- * linux/kernel/posix-timers.c
- *
- *
  * 2002-10-15  Posix Clocks & timers
  *                           by George Anzinger george@mvista.com
- *
  *			     Copyright (C) 2002 2003 by MontaVista Software.
  *
  * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -1,6 +1,6 @@
 /*
- * sched_clock.c: Generic sched_clock() support, to extend low level
- *                hardware time counters to full 64-bit ns values.
+ * Generic sched_clock() support, to extend low level hardware time
+ * counters to full 64-bit ns values.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/time/tick-broadcast-hrtimer.c
- * This file emulates a local clock event device
- * via a pseudo clock device.
+ * Emulate a local clock event device via a pseudo clock device.
  */
 #include <linux/cpu.h>
 #include <linux/err.h>
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/time/tick-broadcast.c
- *
  * This file contains functions which emulate a local clock-event
  * device via a broadcast event source.
  *
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/time/tick-common.c
- *
  * This file contains the base functions to manage periodic tick
  * related events.
  *
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/time/tick-oneshot.c
- *
  * This file contains functions which manage high resolution tick
  * related events.
  *
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1,6 +1,4 @@
 /*
- *  linux/kernel/time/tick-sched.c
- *
  *  Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  *  Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  *  Copyright(C) 2006-2007  Timesys Corp., Thomas Gleixner
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -1,14 +1,10 @@
 /*
- *  linux/kernel/time.c
- *
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
- *  This file contains the interface functions for the various
- *  time related system calls: time, stime, gettimeofday, settimeofday,
- *			       adjtime
- */
-/*
- * Modification history kernel/time.c
+ *  This file contains the interface functions for the various time related
+ *  system calls: time, stime, gettimeofday, settimeofday, adjtime
+ *
+ * Modification history:
  *
  * 1993-09-02    Philip Gladstone
  *      Created file with time related functions from sched/core.c and adjtimex()
--- a/kernel/time/timecounter.c
+++ b/kernel/time/timecounter.c
@@ -1,8 +1,5 @@
 /*
- * linux/kernel/time/timecounter.c
- *
- * based on code that migrated away from
- * linux/kernel/time/clocksource.c
+ * Based on clocksource code. See commit 74d23cc704d1
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -14,7 +11,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-
 #include <linux/export.h>
 #include <linux/timecounter.h>
 
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1,13 +1,7 @@
 /*
- *  linux/kernel/time/timekeeping.c
- *
- *  Kernel timekeeping code and accessor functions
- *
- *  This code was moved from linux/kernel/timer.c.
- *  Please see that file for copyright and history logs.
- *
+ *  Kernel timekeeping code and accessor functions. Based on code from
+ *  timer.c, moved in commit 8524070b7982.
  */
-
 #include <linux/timekeeper_internal.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1,6 +1,4 @@
 /*
- *  linux/kernel/timer.c
- *
  *  Kernel internal timers
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -1,6 +1,4 @@
 /*
- * kernel/time/timer_list.c
- *
  * List pending timers
  *
  * Copyright(C) 2006, Red Hat, Inc., Ingo Molnar


