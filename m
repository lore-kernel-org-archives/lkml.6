Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AG47ELv/jUfBwyVp+YCC+cMcEIMDK1id725SEfEigOVFL9Jg0vO8PFU9Xm9P+DOj3txxfmkLrDcl
ARC-Seal: i=1; a=rsa-sha256; t=1521455378; cv=none;
        d=google.com; s=arc-20160816;
        b=lHr24tLrOSrtdQyeUQoDjW0Uq9xYRznhktS7wwfovXfpa5eRzVn9hUGYKL5aqEMOwu
         GrD9A1WDCrdtSMMVkIWbnXfgaypkjq5NkBN9MRTkHJYF3eYZc4HuSKkwG21fjdZpceFF
         yPdsCDQwjgHSFgVZfAT6iunqoH6s6PWzne0veGP+EkPCTJLuXTyOcSkOb4ABp8JZZ9zT
         9b/rm4NGm5jcdBL88BJSSxGdvQFC6pyqiQTSWPcFcALKHC29TGQOo1XNUrAFWlg8XNce
         qc5J3se7xOQHN+cHaJ6YURJgbZ78U/rH8Qo5rbHZy6GJpYLDDMZfWySrT5O7Rpbz95xc
         Ydfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:cc:to:from:date:user-agent:message-id
         :arc-authentication-results;
        bh=ujt+mQypCpGxf/t4zv9S4hUdlV+2YixcQVjyKaitCX4=;
        b=Rqj3n52Xrpi9WCI9vQugGNEcOUaITooe8bkZ29HcjwonvNVAG5GD2lOiYeB/O0yiQ3
         e8P6FXDnEgjzwb6Km+ImCKfnbrC9PUbfsy67htUBRhhcVhF49xgSIaJ1KMUj8f9Z6Izx
         kPpgDbnDgBa/3ow8Vrc9hEBziGg4hX+W3XbTHToavpujd5jqrWUOp/tWt/QF4lvpvdVL
         4d28f3daqdqMC0MUAjg1fKEUlgZFBk/HhFaJZFi3QT48gYU3JJwGe7ql68HLp2eNhSs2
         87dlhiQFn9i7w1yP8813OkOylB60iStdYwe1ZhxjAWVOZ/6UitkGfK02Zjt6VpRtnkpJ
         Yi0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180319100441.809595337@linutronix.de>
User-Agent: quilt/0.63-1
Date: Mon, 19 Mar 2018 11:04:41 +0100
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
Subject: [patch 00/3] time: Cleanup license information
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595361594483834502?=
X-GMAIL-MSGID: =?utf-8?q?1595361594483834502?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following patch series cleans up the licensing information in the
time subsystem.

  * Replace boiler plate language and sloppy references with SPDX

  * Add missing SPDX identifiers to files with no license reference

While at it clean up the top of file comments by removing pointless
references to the filename itself and condense the information where
appropriate.

Thanks,

        tglx
---
 include/linux/hrtimer.h         |    5 +----
 kernel/time/alarmtimer.c        |    5 +----
 kernel/time/clockevents.c       |    6 +-----
 kernel/time/clocksource.c       |   20 +-------------------
 kernel/time/hrtimer.c           |   17 ++++-------------
 kernel/time/jiffies.c           |   28 ++++++----------------------
 kernel/time/posix-clock.c       |   17 ++---------------
 kernel/time/posix-stubs.c       |    5 +----
 kernel/time/posix-timers.c      |   25 ++-----------------------
 kernel/time/sched_clock.c       |    9 +++------
 kernel/time/test_udelay.c       |   10 +---------
 kernel/time/tick-broadcast.c    |    6 +-----
 kernel/time/tick-common.c       |    6 +-----
 kernel/time/tick-oneshot.c      |    6 +-----
 kernel/time/tick-sched.c        |    5 +----
 kernel/time/time.c              |   13 +++++--------
 kernel/time/timeconst.bc        |    2 ++
 kernel/time/timeconv.c          |   18 +-----------------
 kernel/time/timecounter.c       |   16 ++--------------
 kernel/time/timekeeping.c       |    8 +++-----
 kernel/time/timekeeping_debug.c |   11 +----------
 kernel/time/timer.c             |    3 +--
 kernel/time/timer_list.c        |    7 +------
 23 files changed, 43 insertions(+), 205 deletions(-)
