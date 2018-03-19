Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521483828-2-5548228374239596867
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483827; b=reFn67xY64lQJ9hHWvk/PgflOXjCNRiIiWSzcJt9/zo07vp
    RUcH/mVLD3DuJK+RX5e/Frgj4gwEYyZZa9qT7CunB9mYtzIGLhBwn9L/MhJR9djU
    pXp3KrCQLx/l3DF/yldJ4T8trOWpMX5/wgBwJfiYXbcuaVXTHx1ct6EWMN+GQs/m
    PQYWwiMM9AS++vq7E3IQAogBPesCc4NC0pQkJUZW+xfebUyKxEpMsCRVqnYdA/VL
    qSHiKYOKQVPF8DlqKKQCztPDyQAkRDcq8o1MfG0ClUIU4hULCAq9X2H+XZRmcqGw
    E2rbloHj3kvzAQdEt72gXq7n0OAV1a37Hx4upwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483827; bh=rpuQkzWiu2UWBPvCv8Qi1uESQ3
    +RzBMwMp/s2bGVthM=; b=DyV58gvHR9VyiNeVtXrhEoYTn/+I2kC2dCBnN2k7E3
    JlT2vreXMq61DfF6hpsUqsuk5UTGagXZO+yZa3UPeMrfc9jNBVPq1Lc5JRGPMqOG
    19wc972hvyoN/Ttt88nEOGbLNE+8DhSPjnUbFsH75SAMbuzW8DbjEY/QQ+injB2C
    HXCtR2S9+tYLEqaHpT38wfDwPUHv48js2KwVKpa2JDz+NTUpC9+1iw4yziOjc+MD
    Ksk361r/DMlT9UE5RAzxtJMItdkupwp7IcIC4CkZNBH/3JrXPLmRdEwyXdcnlQdR
    H3VManjwXs9qO8p0uiQ8v0FCc/ARrf2dyHNVifaD+O2A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheehleehnecuvehluhhsthgvrhfuihiivgepudeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduuddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheehleehnecuvehluhhsthgvrhfuihiivgepudeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031463AbeCSSXo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:23:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031459AbeCSSXl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:23:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-fbdev@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 102/241] printk: Correctly handle preemption in console_unlock()
Date: Mon, 19 Mar 2018 19:06:07 +0100
Message-Id: <20180319180755.427526044@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Mladek <pmladek@suse.com>


[ Upstream commit 257ab443118bffc7fdcef38f49cf59be68a3e362 ]

Some console drivers code calls console_conditional_schedule()
that looks at @console_may_schedule. The value must be cleared
when the drivers are called from console_unlock() with
interrupts disabled. But rescheduling is fine when the same
code is called, for example, from tty operations where the
console semaphore is taken via console_lock().

This is why @console_may_schedule is cleared before calling console
drivers. The original value is stored to decide if we could sleep
between lines.

Now, @console_may_schedule is not cleared when we call
console_trylock() and jump back to the "again" goto label.
This has become a problem, since the commit 6b97a20d3a7909daa066
("printk: set may_schedule for some of console_trylock() callers").
@console_may_schedule might get enabled now.

There is also the opposite problem. console_lock() can be called
only from preemptive context. It can always enable scheduling in
the console code. But console_trylock() is not able to detect it
when CONFIG_PREEMPT_COUNT is disabled. Therefore we should use the
original @console_may_schedule value after re-acquiring
the console semaphore in console_unlock().

This patch solves both problems by moving the "again" goto label.

Alternative solution was to clear and restore the value around
call_console_drivers(). Then console_conditional_schedule() could
be used also inside console_unlock(). But there was a potential race
with console_flush_on_panic() as reported by Sergey Senozhatsky.
That function should be called only where there is only one CPU
and with interrupts disabled. But better be on the safe side
because stopping CPUs might fail.

Fixes: 6b97a20d3a7909 ("printk: set may_schedule for some of console_trylock() callers")
Link: http://lkml.kernel.org/r/1490372045-22288-1-git-send-email-pmladek@suse.com
Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/printk/printk.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2342,7 +2342,7 @@ void console_unlock(void)
 	}
 
 	/*
-	 * Console drivers are called under logbuf_lock, so
+	 * Console drivers are called with interrupts disabled, so
 	 * @console_may_schedule should be cleared before; however, we may
 	 * end up dumping a lot of lines, for example, if called from
 	 * console registration path, and should invoke cond_resched()
@@ -2350,11 +2350,15 @@ void console_unlock(void)
 	 * scheduling stall on a slow console leading to RCU stall and
 	 * softlockup warnings which exacerbate the issue with more
 	 * messages practically incapacitating the system.
+	 *
+	 * console_trylock() is not able to detect the preemptive
+	 * context reliably. Therefore the value must be stored before
+	 * and cleared after the the "again" goto label.
 	 */
 	do_cond_resched = console_may_schedule;
+again:
 	console_may_schedule = 0;
 
-again:
 	/*
 	 * We released the console_sem lock, so we need to recheck if
 	 * cpu is online and (if not) is there at least one CON_ANYTIME
