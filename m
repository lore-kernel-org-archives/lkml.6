Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209C9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E596220659
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E596220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503742AbeKWWFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:05:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45413 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbeKWWFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:05:07 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wANBKhHC4176292
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Nov 2018 03:20:43 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wANBKhqn4176289;
        Fri, 23 Nov 2018 03:20:43 -0800
Date:   Fri, 23 Nov 2018 03:20:43 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-9281a7857b91cf4d283be7c86d80e5d091bfb3d9@git.kernel.org>
Cc:     paulmck@linux.vnet.ibm.com, john.stultz@linaro.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        nicolas.pitre@linaro.org, hpa@zytor.com, keescook@chromium.org,
        ccross@android.com, davidriley@chromium.org, broonie@kernel.org,
        rmk+kernel@armlinux.org.uk, richardcochran@gmail.com,
        kstewart@linuxfoundation.org, cminyard@mvista.com,
        tglx@linutronix.de, pombredanne@nexb.com, mingo@kernel.org
Reply-To: cminyard@mvista.com, pombredanne@nexb.com, tglx@linutronix.de,
          mingo@kernel.org, rmk+kernel@armlinux.org.uk, broonie@kernel.org,
          richardcochran@gmail.com, kstewart@linuxfoundation.org,
          ccross@android.com, davidriley@chromium.org,
          paulmck@linux.vnet.ibm.com, john.stultz@linaro.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          keescook@chromium.org, hpa@zytor.com, nicolas.pitre@linaro.org
In-Reply-To: <20181031182253.047449481@linutronix.de>
References: <20181031182253.047449481@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] time/debug: Remove license boilerplate
Git-Commit-ID: 9281a7857b91cf4d283be7c86d80e5d091bfb3d9
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

Commit-ID:  9281a7857b91cf4d283be7c86d80e5d091bfb3d9
Gitweb:     https://git.kernel.org/tip/9281a7857b91cf4d283be7c86d80e5d091bfb3d9
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 31 Oct 2018 19:21:11 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 23 Nov 2018 11:51:21 +0100

time/debug: Remove license boilerplate

The SPDX identifier is enough. Remove the license boilerplate.

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
Link: https://lkml.kernel.org/r/20181031182253.047449481@linutronix.de

---
 kernel/time/test_udelay.c       |  9 ---------
 kernel/time/timekeeping_debug.c | 10 ----------
 2 files changed, 19 deletions(-)

diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
index d6a87bb2040f..77c63005dc4e 100644
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -8,15 +8,6 @@
  * Specifying usecs of 0 or negative values will run multiples tests.
  *
  * Copyright (C) 2014 Google, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/debugfs.h>
diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index d06f09209fb7..f811882cfd13 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -3,16 +3,6 @@
  * debugfs file to track time spent in suspend
  *
  * Copyright (c) 2011, Google, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 
 #include <linux/debugfs.h>
