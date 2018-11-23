Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C51DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAF720659
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAF720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503753AbeKWWFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:05:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36301 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbeKWWFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:05:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wANBLIaq4176530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Nov 2018 03:21:18 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wANBLIS34176527;
        Fri, 23 Nov 2018 03:21:18 -0800
Date:   Fri, 23 Nov 2018 03:21:18 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-6c7811c628a96fe00965622f3aa1cf272cb898f7@git.kernel.org>
Cc:     rmk+kernel@armlinux.org.uk, john.stultz@linaro.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        keescook@chromium.org, davidriley@chromium.org, mingo@kernel.org,
        tglx@linutronix.de, nicolas.pitre@linaro.org, hpa@zytor.com,
        peterz@infradead.org, cminyard@mvista.com, ccross@android.com,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        broonie@kernel.org, richardcochran@gmail.com, paulmck@linux.ibm.com
Reply-To: broonie@kernel.org, richardcochran@gmail.com,
          paulmck@linux.ibm.com, cminyard@mvista.com, ccross@android.com,
          paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          davidriley@chromium.org, keescook@chromium.org, mingo@kernel.org,
          tglx@linutronix.de, nicolas.pitre@linaro.org, hpa@zytor.com,
          peterz@infradead.org, rmk+kernel@armlinux.org.uk,
          john.stultz@linaro.org, pombredanne@nexb.com,
          kstewart@linuxfoundation.org
In-Reply-To: <20181031182253.132458951@linutronix.de>
References: <20181031182253.132458951@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] time: Remove license boilerplate
Git-Commit-ID: 6c7811c628a96fe00965622f3aa1cf272cb898f7
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

Commit-ID:  6c7811c628a96fe00965622f3aa1cf272cb898f7
Gitweb:     https://git.kernel.org/tip/6c7811c628a96fe00965622f3aa1cf272cb898f7
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 31 Oct 2018 19:21:12 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 23 Nov 2018 11:51:21 +0100

time: Remove license boilerplate

The SPDX identifier defines the license of the files already. No need for
the boilerplates.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: John Stultz <john.stultz@linaro.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Peter Anvin <hpa@zytor.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: David Riley <davidriley@chromium.org>
Cc: Colin Cross <ccross@android.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/r/20181031182253.132458951@linutronix.de

---
 kernel/time/alarmtimer.c  |  4 ----
 kernel/time/clocksource.c | 14 --------------
 kernel/time/jiffies.c     | 25 +++++--------------------
 kernel/time/timecounter.c | 10 ----------
 4 files changed, 5 insertions(+), 48 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 69070d399d70..2c97e8c2d29f 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -11,10 +11,6 @@
  * Copyright (C) 2010 IBM Corperation
  *
  * Author: John Stultz <john.stultz@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/time.h>
 #include <linux/hrtimer.h>
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b1abeac5f3f7..3bcc19ceb073 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -3,20 +3,6 @@
  * This file contains the functions which manage clocksource drivers.
  *
  * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 0deb0be2c445..dc1b6f1929f9 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -1,24 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
-/***********************************************************************
-* This file contains the jiffies based clocksource.
-*
-* Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-* GNU General Public License for more details.
-*
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*
-************************************************************************/
+/*
+ * This file contains the jiffies based clocksource.
+ *
+ * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
+ */
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
diff --git a/kernel/time/timecounter.c b/kernel/time/timecounter.c
index 933462326489..85b98e727306 100644
--- a/kernel/time/timecounter.c
+++ b/kernel/time/timecounter.c
@@ -1,16 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Based on clocksource code. See commit 74d23cc704d1
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #include <linux/export.h>
 #include <linux/timecounter.h>
