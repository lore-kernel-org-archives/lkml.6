Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4D5ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289B52081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289B52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbeKADZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:25:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56213 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbeKADZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:25:23 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHvBz-0005cu-9S; Wed, 31 Oct 2018 19:26:11 +0100
Message-Id: <20181031182253.047449481@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 31 Oct 2018 19:21:11 +0100
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
Subject: [patch 4/9] time/debug: Remove license boilerplate
References: <20181031182107.726051323@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=time-debug--Remove-license-boilerplate.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPDX identifier is enough. Remove the license boilerplate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Riley <davidriley@chromium.org>
Cc: Colin Cross <ccross@android.com>
---
 kernel/time/test_udelay.c       |    9 ---------
 kernel/time/timekeeping_debug.c |   10 ----------
 2 files changed, 19 deletions(-)

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


