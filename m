Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DF5C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61D120672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61D120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409620AbeKWWGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:06:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38807 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405404AbeKWWGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:06:21 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wANBLqB74176558
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Nov 2018 03:21:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wANBLqP24176555;
        Fri, 23 Nov 2018 03:21:52 -0800
Date:   Fri, 23 Nov 2018 03:21:52 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-3c8f2515ac0a986c8af6ba17c376f874306e71f4@git.kernel.org>
Cc:     rmk+kernel@armlinux.org.uk, mingo@kernel.org,
        kstewart@linuxfoundation.org, davidriley@chromium.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, peterz@infradead.org,
        john.stultz@linaro.org, hpa@zytor.com, pombredanne@nexb.com,
        tglx@linutronix.de, broonie@kernel.org, paulmck@linux.vnet.ibm.com,
        nico@linaro.org, ccross@android.com, richardcochran@gmail.com,
        cminyard@mvista.com, keescook@chromium.org
Reply-To: paulmck@linux.vnet.ibm.com, nico@linaro.org,
          keescook@chromium.org, cminyard@mvista.com,
          richardcochran@gmail.com, ccross@android.com,
          john.stultz@linaro.org, tglx@linutronix.de, pombredanne@nexb.com,
          broonie@kernel.org, hpa@zytor.com, peterz@infradead.org,
          davidriley@chromium.org, arnd@arndb.de,
          linux-kernel@vger.kernel.org, rmk+kernel@armlinux.org.uk,
          kstewart@linuxfoundation.org, mingo@kernel.org
In-Reply-To: <20181031182253.215825217@linutronix.de>
References: <20181031182253.215825217@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers/stubs: Remove license boilerplate
Git-Commit-ID: 3c8f2515ac0a986c8af6ba17c376f874306e71f4
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

Commit-ID:  3c8f2515ac0a986c8af6ba17c376f874306e71f4
Gitweb:     https://git.kernel.org/tip/3c8f2515ac0a986c8af6ba17c376f874306e71f4
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 31 Oct 2018 19:21:13 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 23 Nov 2018 11:51:21 +0100

posix-timers/stubs: Remove license boilerplate

The SPDX identifier defines the license of the file already. No need for
the boilerplate.

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
Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20181031182253.215825217@linutronix.de

---
 kernel/time/posix-stubs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index b9f9f6f02e11..a51895486e5e 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -4,10 +4,6 @@
  *
  * Created by:  Nicolas Pitre, July 2016
  * Copyright:   (C) 2016 Linaro Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/linkage.h>
