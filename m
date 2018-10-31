Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E32ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF81D20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF81D20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbeKADZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:25:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56208 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbeKADZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:25:23 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHvBx-0005cg-LS; Wed, 31 Oct 2018 19:26:09 +0100
Message-Id: <20181031182252.879109557@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 31 Oct 2018 19:21:09 +0100
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
        Mark Brown <broonie@kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [patch 2/9] time: Add SPDX license identifiers
References: <20181031182107.726051323@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=time--Add-SPDX-license-identifiers.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the time(r) core files files with the correct SPDX license
identifier based on the license text in the file itself. The SPDX
identifier is a legally binding shorthand, which can be used instead of the
full boiler plate text.

This work is based on a script and data from Philippe Ombredanne, Kate
Stewart and myself. The data has been created with two independent license
scanners and manual inspection.

The following files do not contain any direct license information and have
been omitted from the big initial SPDX changes:

  timeconst.bc: The .bc files were not touched
  time.c, timer.c, timekeeping.c: Licence was deduced from EXPORT_SYMBOL_GPL

As those files do not contain direct license references they fall under the
project license, i.e. GPL V2 only.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Corey Minyard <cminyard@mvista.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: David Riley <davidriley@chromium.org>
Cc: Colin Cross <ccross@android.com>
Cc: Mark Brown <broonie@kernel.org>
---
 include/linux/hrtimer.h         |    1 +
 kernel/time/alarmtimer.c        |    1 +
 kernel/time/clockevents.c       |    1 +
 kernel/time/clocksource.c       |    1 +
 kernel/time/hrtimer.c           |    1 +
 kernel/time/jiffies.c           |    1 +
 kernel/time/posix-clock.c       |    1 +
 kernel/time/posix-stubs.c       |    1 +
 kernel/time/posix-timers.c      |    1 +
 kernel/time/sched_clock.c       |    1 +
 kernel/time/test_udelay.c       |    1 +
 kernel/time/tick-broadcast.c    |    1 +
 kernel/time/tick-common.c       |    1 +
 kernel/time/tick-oneshot.c      |    1 +
 kernel/time/tick-sched.c        |    1 +
 kernel/time/time.c              |    1 +
 kernel/time/timeconst.bc        |    2 ++
 kernel/time/timeconv.c          |    1 +
 kernel/time/timecounter.c       |    1 +
 kernel/time/timekeeping.c       |    1 +
 kernel/time/timekeeping_debug.c |    1 +
 kernel/time/timer.c             |    1 +
 kernel/time/timer_list.c        |    1 +
 23 files changed, 24 insertions(+)

--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  hrtimers - High-resolution kernel timers
  *
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Alarmtimer interface
  *
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains functions which manage clock event devices.
  *
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * This file contains the functions which manage clocksource drivers.
  *
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  *  Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /***********************************************************************
 * This file contains the jiffies based clocksource.
 *
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Support for dynamic clock devices
  *
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Dummy stubs used when CONFIG_POSIX_TIMERS=n
  *
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * 2002-10-15  Posix Clocks & timers
  *                           by George Anzinger george@mvista.com
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic sched_clock() support, to extend low level hardware time
  * counters to full 64-bit ns values.
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * udelay() test kernel module
  *
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains functions which emulate a local clock-event
  * device via a broadcast event source.
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains the base functions to manage periodic tick
  * related events.
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains functions which manage high resolution tick
  * related events.
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  *  Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
--- a/kernel/time/timeconst.bc
+++ b/kernel/time/timeconst.bc
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 scale=0
 
 define gcd(a,b) {
--- a/kernel/time/timeconv.c
+++ b/kernel/time/timeconv.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.0+
 /*
  * Copyright (C) 1993, 1994, 1995, 1996, 1997 Free Software Foundation, Inc.
  * This file is part of the GNU C Library.
--- a/kernel/time/timecounter.c
+++ b/kernel/time/timecounter.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Based on clocksource code. See commit 74d23cc704d1
  *
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Kernel timekeeping code and accessor functions. Based on code from
  *  timer.c, moved in commit 8524070b7982.
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * debugfs file to track time spent in suspend
  *
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Kernel internal timers
  *
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * List pending timers
  *


