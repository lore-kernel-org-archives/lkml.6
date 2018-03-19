Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AG47ELvRiVE/mKXWSZtyZlgxTifETXKqBme6GXtcz3Qjf+H0rFSNvIDx0al3VY0nU3Uoz714rKw6
ARC-Seal: i=1; a=rsa-sha256; t=1521455378; cv=none;
        d=google.com; s=arc-20160816;
        b=F1cS8MikcovEUKYCGD5CS+Hi1pgyvtpvzdjVhurGBJMtVq9wjCDhyA5bX+HUEtDxsn
         Dn2VW7qHLuQ57slZtBSG5D+6iUnfYw2RBiMMZ3eKUAb6p/jqMRHX8nLspJEVudyh+ruo
         6qqPIp4gUbNi/8GcJ5dnJKIaCltNo2YbpG6ezFI3QjQF9X5/wo9MgbVG6k9S26gjbejn
         lGyScQSr1UGpkOMZluu2DS4BTZw+ggpVcBlpA0p7X68MmQHyiyzdFJ8FyVMQThzDjW55
         3/8xY/GluN13rZIxMARcmlHEPQz7Bg15fP0nCmxLsiPODEKYdM7gPEvqHjFdfH9fXmIP
         IQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=5tKN3P78Sqa8GrMEUAbiH9zILViT52OKljuRkVG8ZtQ=;
        b=Imp3IaBd3PZv7iOoS2qcs/OG8ptiIT8PmnB8lROtrR5z75R1UTO1i1+mjHnDhhWYMq
         ttfIckmxSz4Rgj1sFFHIqIzJH99Jo65opUStdUNfnZikMUBl0IcEI/VxI9EVSKFUvY3N
         vFBIHyXjYdyh9kxDY7nVhXSnO8dk7GphpXkij8t1leXOkSn7cZItvdJtEInTax2D8G9E
         9iCbt51efRBd+ZWeAh8YnFQfmTxL9XfnzVAi/yk/3CHDaErxFEj4GXbU7l65Z25hcV+m
         BOO2gGZLBG2B5jvlafDGMddx0atQ2+0/WknjyaVBibeueXLQLLpsARzXcJp28cttc94i
         UYgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180319100810.345952155@linutronix.de>
User-Agent: quilt/0.63-1
Date: Mon, 19 Mar 2018 11:04:43 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 "H. Peter Anvin" <hpa@zytor.com>, John Stultz <john.stultz@linaro.org>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Stephen Boyd <sboyd@codeaurora.org>, Colin Cross <ccross@android.com>,
 David Riley <davidriley@chromium.org>
Subject: [patch 02/3] time: Add SPDX license identifiers
References: <20180319100441.809595337@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=time--Add-SPDX-license-identifiers.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595361595317851685?=
X-GMAIL-MSGID: =?utf-8?q?1595361595317851685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
+/* SPDX-License-Identifier: GPL2.0 */
 /*
  *  hrtimers - High-resolution kernel timers
  *
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0
 /*
  * Alarmtimer interface
  *
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0
 /*
  * This file contains functions which manage clock event devices.
  *
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0+
 /*
  * This file contains the functions which manage clocksource drivers.
  *
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0
 /*
  *  Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  *  Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0+
 /***********************************************************************
 * This file contains the jiffies based clocksource.
 *
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0+
 /*
  * Support for dynamic clock devices
  *
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0
 /*
  * Dummy stubs used when CONFIG_POSIX_TIMERS=n
  *
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0+
 /*
  * 2002-10-15  Posix Clocks & timers
  *                           by George Anzinger george@mvista.com
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0
 /*
  * Generic sched_clock() support, to extend low level hardware time
  * counters to full 64-bit ns values.
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0
 /*
  * udelay() test kernel module
  *
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0
 /*
  * This file contains functions which emulate a local clock-event
  * device via a broadcast event source.
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0
 /*
  * This file contains the base functions to manage periodic tick
  * related events.
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0
 /*
  * This file contains functions which manage high resolution tick
  * related events.
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0
 /*
  *  Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  *  Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0
 /*
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
--- a/kernel/time/timeconst.bc
+++ b/kernel/time/timeconst.bc
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL2.0 */
+
 scale=0
 
 define gcd(a,b) {
--- a/kernel/time/timeconv.c
+++ b/kernel/time/timeconv.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL2.0+
 /*
  * Copyright (C) 1993, 1994, 1995, 1996, 1997 Free Software Foundation, Inc.
  * This file is part of the GNU C Library.
--- a/kernel/time/timecounter.c
+++ b/kernel/time/timecounter.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0+
 /*
  * based on code that migrated away from linux/kernel/time/clocksource.c
  *
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0
 /*
  *  Kernel timekeeping code and accessor functions
  *
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0+
 /*
  * debugfs file to track time spent in suspend
  *
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0
 /*
  *  Kernel internal timers
  *
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL2.0
 /*
  * List pending timers
  *
