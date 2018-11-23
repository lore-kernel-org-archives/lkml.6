Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6479BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100CA20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100CA20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409631AbeKWWGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:06:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59891 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390447AbeKWWGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:06:52 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wANBMRXH4176590
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Nov 2018 03:22:27 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wANBMRt14176587;
        Fri, 23 Nov 2018 03:22:27 -0800
Date:   Fri, 23 Nov 2018 03:22:27 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-2fa6d420c22268b30dc46c8cbfe8bec0e361e03e@git.kernel.org>
Cc:     cminyard@mvista.com, linux-kernel@vger.kernel.org,
        davidriley@chromium.org, keescook@chromium.org, hpa@zytor.com,
        kstewart@linuxfoundation.org, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, ccross@android.com,
        rmk+kernel@armlinux.org.uk, mingo@kernel.org, tglx@linutronix.de,
        john.stultz@linaro.org, broonie@kernel.org,
        nicolas.pitre@linaro.org, richardcochran@gmail.com,
        pombredanne@nexb.com
Reply-To: kstewart@linuxfoundation.org, peterz@infradead.org,
          keescook@chromium.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, davidriley@chromium.org,
          cminyard@mvista.com, ccross@android.com,
          rmk+kernel@armlinux.org.uk, paulmck@linux.vnet.ibm.com,
          john.stultz@linaro.org, mingo@kernel.org, tglx@linutronix.de,
          pombredanne@nexb.com, nicolas.pitre@linaro.org,
          broonie@kernel.org, richardcochran@gmail.com
In-Reply-To: <20181031182253.300140921@linutronix.de>
References: <20181031182253.300140921@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] sched/clock: Remove license boilerplate
Git-Commit-ID: 2fa6d420c22268b30dc46c8cbfe8bec0e361e03e
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

Commit-ID:  2fa6d420c22268b30dc46c8cbfe8bec0e361e03e
Gitweb:     https://git.kernel.org/tip/2fa6d420c22268b30dc46c8cbfe8bec0e361e03e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 31 Oct 2018 19:21:14 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 23 Nov 2018 11:51:22 +0100

sched/clock: Remove license boilerplate

The SPDX identifier defines the license of the file already. No need for
the boilerplate.

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
Link: https://lkml.kernel.org/r/20181031182253.300140921@linutronix.de

---
 kernel/time/sched_clock.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 11570ba451cc..094b82ca95e5 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -2,10 +2,6 @@
 /*
  * Generic sched_clock() support, to extend low level hardware time
  * counters to full 64-bit ns values.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/clocksource.h>
 #include <linux/init.h>
