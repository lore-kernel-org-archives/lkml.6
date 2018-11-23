Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B3DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8323F20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8323F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503766AbeKWWHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:07:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46969 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390447AbeKWWHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:07:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wANBN2pQ4176633
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Nov 2018 03:23:02 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wANBN2H34176629;
        Fri, 23 Nov 2018 03:23:02 -0800
Date:   Fri, 23 Nov 2018 03:23:02 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c804efeb58229e6040b9a200cbab1fc8c150f99d@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, pombredanne@nexb.com,
        manfred.rudigier@omicronenergy.com, cminyard@mvista.com,
        davidriley@chromium.org, broonie@kernel.org,
        paulmck@linux.vnet.ibm.com, ccross@android.com,
        richardcochran@gmail.com, linux-kernel@vger.kernel.org,
        rmk+kernel@armlinux.org.uk, peterz@infradead.org,
        john.stultz@linaro.org, keescook@chromium.org,
        nicolas.pitre@linaro.org, mingo@kernel.org,
        kstewart@linuxfoundation.org
Reply-To: pombredanne@nexb.com, manfred.rudigier@omicronenergy.com,
          hpa@zytor.com, tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
          cminyard@mvista.com, broonie@kernel.org, davidriley@chromium.org,
          john.stultz@linaro.org, keescook@chromium.org,
          rmk+kernel@armlinux.org.uk, peterz@infradead.org,
          ccross@android.com, richardcochran@gmail.com,
          linux-kernel@vger.kernel.org, kstewart@linuxfoundation.org,
          nicolas.pitre@linaro.org, mingo@kernel.org
In-Reply-To: <20181031182253.385909804@linutronix.de>
References: <20181031182253.385909804@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-clocks: Remove license boiler plate
Git-Commit-ID: c804efeb58229e6040b9a200cbab1fc8c150f99d
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

Commit-ID:  c804efeb58229e6040b9a200cbab1fc8c150f99d
Gitweb:     https://git.kernel.org/tip/c804efeb58229e6040b9a200cbab1fc8c150f99d
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 31 Oct 2018 19:21:15 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 23 Nov 2018 11:51:22 +0100

posix-clocks: Remove license boiler plate

The SPDX identifier defines the license of the file already. No need for
the boilerplate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
Acked-by: John Stultz <john.stultz@linaro.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Peter Anvin <hpa@zytor.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: David Riley <davidriley@chromium.org>
Cc: Colin Cross <ccross@android.com>
Cc: Mark Brown <broonie@kernel.org>
Link: https://lkml.kernel.org/r/20181031182253.385909804@linutronix.de

---
 kernel/time/posix-clock.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 339e35e4605f..425bbfce6819 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -3,20 +3,6 @@
  * Support for dynamic clock devices
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/device.h>
 #include <linux/export.h>
