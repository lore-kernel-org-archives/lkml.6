Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943FDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C9D20659
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C9D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503692AbeKWWDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:03:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbeKWWDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:03:47 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wANBJ1fx4176107
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Nov 2018 03:19:01 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wANBIvmN4176100;
        Fri, 23 Nov 2018 03:18:57 -0800
Date:   Fri, 23 Nov 2018 03:18:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-58c5fc2b96e4ae65068d815a1c3ca81da92fa1c9@git.kernel.org>
Cc:     mingo@kernel.org, paulmck@linux.vnet.ibm.com, ccross@android.com,
        kstewart@linuxfoundation.org, keescook@chromium.org,
        davidriley@chromium.org, cminyard@mvista.com,
        linux-kernel@vger.kernel.org, rmk+kernel@armlinux.org.uk,
        hpa@zytor.com, pombredanne@nexb.com, peterz@infradead.org,
        tglx@linutronix.de, john.stultz@linaro.org,
        richardcochran@gmail.com, broonie@kernel.org, nico@linaro.org
Reply-To: kstewart@linuxfoundation.org, ccross@android.com,
          paulmck@linux.vnet.ibm.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, cminyard@mvista.com,
          keescook@chromium.org, davidriley@chromium.org,
          pombredanne@nexb.com, hpa@zytor.com, rmk+kernel@armlinux.org.uk,
          nico@linaro.org, broonie@kernel.org, richardcochran@gmail.com,
          john.stultz@linaro.org, tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20181031182252.794898238@linutronix.de>
References: <20181031182252.794898238@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] time: Remove useless filenames in top level
 comments
Git-Commit-ID: 58c5fc2b96e4ae65068d815a1c3ca81da92fa1c9
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

Commit-ID:  58c5fc2b96e4ae65068d815a1c3ca81da92fa1c9
Gitweb:     https://git.kernel.org/tip/58c5fc2b96e4ae65068d815a1c3ca81da92fa1c9
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 31 Oct 2018 19:21:08 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 23 Nov 2018 11:51:20 +0100

time: Remove useless filenames in top level comments

Remove the pointless filenames in the top level comments. They have no
value at all and just occupy space. While at it tidy up some of the
comments and remove a stale one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Nicolas Pitre <nico@linaro.org>
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
Cc: David Riley <davidriley@chromium.org>
Cc: Colin Cross <ccross@android.com>
Cc: Mark Brown <broonie@kernel.org>
Link: https://lkml.kernel.org/r/20181031182252.794898238@linutronix.de

---
 include/linux/hrtimer.h              |  2 --
 kernel/time/clockevents.c            |  2 --
 kernel/time/clocksource.c            |  5 -----
 kernel/time/hrtimer.c                | 16 ++++------------
 kernel/time/itimer.c                 |  2 --
 kernel/time/jiffies.c                |  2 --
 kernel/time/posix-clock.c            |  2 +-
 kernel/time/posix-timers.c           |  4 ----
 kernel/time/sched_clock.c            |  4 ++--
 kernel/time/tick-broadcast-hrtimer.c |  4 +---
 kernel/time/tick-broadcast.c         |  2 --
 kernel/time/tick-common.c            |  2 --
 kernel/time/tick-oneshot.c           |  2 --
 kernel/time/tick-sched.c             |  2 --
 kernel/time/time.c                   | 12 ++++--------
 kernel/time/timecounter.c            |  6 +-----
 kernel/time/timekeeping.c            | 10 ++--------
 kernel/time/timer.c                  |  2 --
 kernel/time/timer_list.c             |  2 --
 19 files changed, 15 insertions(+), 68 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 3892e9c8b2de..50ebe2ad43e0 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -1,6 +1,4 @@
 /*
- *  include/linux/hrtimer.h
- *
  *  hrtimers - High-resolution kernel timers
  *
  *   Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index af58898d9ebf..9b8c7c0fd113 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/time/clockevents.c
- *
  * This file contains functions which manage clock event devices.
  *
  * Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index ffe081623aec..1c5273fbd500 100644
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
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 9cdd74bd2d27..223548bb81c6 100644
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
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 9a65713c8309..02068b2d5862 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/itimer.c
- *
  * Copyright (C) 1992 Darren Senn
  */
 
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 497719127bf9..9c3957fe9317 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -1,6 +1,4 @@
 /***********************************************************************
-* linux/kernel/time/jiffies.c
-*
 * This file contains the jiffies based clocksource.
 *
 * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index fe56c4e06c51..4959815f4fd7 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -1,5 +1,5 @@
 /*
- * posix-clock.c - support for dynamic clock devices
+ * Support for dynamic clock devices
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
  *
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index bd62b5eeb5a0..c72307c119d9 100644
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
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index cbc72c2c1fca..b38b6628f89b 100644
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
diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index a59641fb88b6..5be6154e2fd2 100644
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
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index be0aac2b4300..4f5abde2dfa7 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/time/tick-broadcast.c
- *
  * This file contains functions which emulate a local clock-event
  * device via a broadcast event source.
  *
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 14de3727b18e..7b5008039c2d 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/time/tick-common.c
- *
  * This file contains the base functions to manage periodic tick
  * related events.
  *
diff --git a/kernel/time/tick-oneshot.c b/kernel/time/tick-oneshot.c
index 6fe615d57ebb..77989efe13d2 100644
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/time/tick-oneshot.c
- *
  * This file contains functions which manage high resolution tick
  * related events.
  *
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 69e673b88474..cb557e56a19f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1,6 +1,4 @@
 /*
- *  linux/kernel/time/tick-sched.c
- *
  *  Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  *  Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  *  Copyright(C) 2006-2007  Timesys Corp., Thomas Gleixner
diff --git a/kernel/time/time.c b/kernel/time/time.c
index ad204cf6d001..13ffa9950ffc 100644
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
diff --git a/kernel/time/timecounter.c b/kernel/time/timecounter.c
index 8afd78932bdf..400f3456d564 100644
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
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 2d110c948805..30fdf48f50c2 100644
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
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index fa49cd753dea..2f248bbedb4a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1,6 +1,4 @@
 /*
- *  linux/kernel/timer.c
- *
  *  Kernel internal timers
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index d647dabdac97..5d64fff384c8 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -1,6 +1,4 @@
 /*
- * kernel/time/timer_list.c
- *
  * List pending timers
  *
  * Copyright(C) 2006, Red Hat, Inc., Ingo Molnar
