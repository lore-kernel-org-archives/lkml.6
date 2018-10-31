Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911B9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FC320657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FC320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbeKADZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:25:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56204 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbeKADZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:25:22 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHvBw-0005ca-27; Wed, 31 Oct 2018 19:26:08 +0100
Message-Id: <20181031182107.726051323@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 31 Oct 2018 19:21:07 +0100
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
Subject: [patch 0/9] time: Add SPDX identifiers and cleanup boilerplates
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX identifiers to all files in kernel/time and remove the license
boiler plates.

Aside of that use the chance to get rid of (stale) file references and tidy
up the top of file comments as they are touched anyway by this work.

This work is based on a script and data from Philippe Ombredanne, Kate
Stewart and myself. The data has been created with two independent license
scanners and manual inspection.

Thanks,

	tglx

---
 include/linux/hrtimer.h              |    5 +----
 kernel/time/alarmtimer.c             |    5 +----
 kernel/time/clockevents.c            |    6 +-----
 kernel/time/clocksource.c            |   20 +-------------------
 kernel/time/hrtimer.c                |   19 +++++--------------
 kernel/time/itimer.c                 |    2 --
 kernel/time/jiffies.c                |   28 ++++++----------------------
 kernel/time/posix-clock.c            |   17 ++---------------
 kernel/time/posix-stubs.c            |    5 +----
 kernel/time/posix-timers.c           |   25 ++-----------------------
 kernel/time/sched_clock.c            |    9 +++------
 kernel/time/test_udelay.c            |   10 +---------
 kernel/time/tick-broadcast-hrtimer.c |    4 +---
 kernel/time/tick-broadcast.c         |    6 +-----
 kernel/time/tick-common.c            |    6 +-----
 kernel/time/tick-oneshot.c           |    6 +-----
 kernel/time/tick-sched.c             |    5 +----
 kernel/time/time.c                   |   13 +++++--------
 kernel/time/timeconst.bc             |    2 ++
 kernel/time/timeconv.c               |    1 +
 kernel/time/timecounter.c            |   17 ++---------------
 kernel/time/timekeeping.c            |   11 +++--------
 kernel/time/timekeeping_debug.c      |   11 +----------
 kernel/time/timer.c                  |    3 +--
 kernel/time/timer_list.c             |    7 +------
 25 files changed, 45 insertions(+), 198 deletions(-)



