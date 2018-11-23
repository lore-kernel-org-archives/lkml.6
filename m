Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EFAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BF120672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BF120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503780AbeKWWIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:08:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42503 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390447AbeKWWID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:08:03 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wANBNb3l4176688
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Nov 2018 03:23:37 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wANBNb014176685;
        Fri, 23 Nov 2018 03:23:37 -0800
Date:   Fri, 23 Nov 2018 03:23:37 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-0141de741e0710d5e2e68087577329606f59ed71@git.kernel.org>
Cc:     cminyard@mvista.com, hpa@zytor.com, rmk+kernel@armlinux.org.uk,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, broonie@kernel.org,
        kstewart@linuxfoundation.org, john.stultz@linaro.org,
        richardcochran@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, nicolas.pitre@linaro.org, ccross@android.com,
        tglx@linutronix.de, davidriley@chromium.org
Reply-To: keescook@chromium.org, richardcochran@gmail.com,
          john.stultz@linaro.org, broonie@kernel.org,
          kstewart@linuxfoundation.org, pombredanne@nexb.com,
          davidriley@chromium.org, tglx@linutronix.de, ccross@android.com,
          nicolas.pitre@linaro.org, hpa@zytor.com,
          rmk+kernel@armlinux.org.uk, cminyard@mvista.com,
          peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com
In-Reply-To: <20181031182253.479792883@linutronix.de>
References: <20181031182253.479792883@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers: Remove license boilerplate
Git-Commit-ID: 0141de741e0710d5e2e68087577329606f59ed71
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

Commit-ID:  0141de741e0710d5e2e68087577329606f59ed71
Gitweb:     https://git.kernel.org/tip/0141de741e0710d5e2e68087577329606f59ed71
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 31 Oct 2018 19:21:16 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 23 Nov 2018 11:51:22 +0100

posix-timers: Remove license boilerplate

The SPDX identifier defines the license of the file already. No need for
the boilerplate.

Remove also the completely outdated Montavista snail mail address.

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
Link: https://lkml.kernel.org/r/20181031182253.479792883@linutronix.de

---
 kernel/time/posix-timers.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e8cd9aa6c9cf..dd70ced15a36 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -7,25 +7,7 @@
  * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
  *			     Copyright (C) 2004 Boris Hu
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
-
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * MontaVista Software | 1237 East Arques Avenue | Sunnyvale | CA 94085 | USA
- */
-
-/* These are all the functions necessary to implement
- * POSIX clocks & timers
+ * These are all the functions necessary to implement POSIX clocks & timers
  */
 #include <linux/mm.h>
 #include <linux/interrupt.h>
