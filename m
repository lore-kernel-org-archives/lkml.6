Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52A3ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6859C20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6859C20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbeKADZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:25:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56232 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbeKADZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:25:26 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHvC1-0005dE-LL; Wed, 31 Oct 2018 19:26:13 +0100
Message-Id: <20181031182253.300140921@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 31 Oct 2018 19:21:14 +0100
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
Subject: [patch 7/9] sched/clock: Remove license boilerplate
References: <20181031182107.726051323@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=sched-clock--Remove-license-boilerplate.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPDX identifier defines the license of the file already. No need for
the boilerplate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: John Stultz <john.stultz@linaro.org>
---
 kernel/time/sched_clock.c |    4 ----
 1 file changed, 4 deletions(-)

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


