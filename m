Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8A1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FE22086E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FE22086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeIDVvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeIDVvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:51:36 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FFA52054F;
        Tue,  4 Sep 2018 17:25:31 +0000 (UTC)
Date:   Tue, 4 Sep 2018 13:25:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        contact@linuxplumbersconf.org
Cc:     Julia Cartwright <julia@ni.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Mark Brown <mark.brown@linaro.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Darren Hart <darren@dvhart.com>
Subject: [ANNOUNCE] Submit a topic for the RT Microconference at Linux
 Plumbers
Message-ID: <20180904132529.6ae7166e@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi RT folks!

The call for proposals (CfP) is now open for the RT Microconference at
Linux Plumbers in Vancouver, Canada. The topics we are looking at this
year are:

 - How will PREEMPT_RT be maintained (is it a subsystem?)

 - Who will maintain it?

 - How do we teach the rest of the kernel developers how not to break PREEMPT_RT?

 - How do we catch when it breaks?

 - What tools can we add into tools/ that other kernel developers can use to test and learn about PREEMPT_RT?

 - What tests can we add into tools/testing/selftests?

 - What kernel boot selftests can be added?

 - How can we modify lockdep to catch problems that can break PREEMPT_RT?

 - Discuss various types of failures that can happen with PREEMPT_RT that normally would not happen in the vanilla kernel.

 - How do we handle stable backports?

 - Interaction with Safety Critical domains?

 - Interrupt threads are RT and are not protected by the RT Throttling.
   How can we prevent interrupt thread starvation from a rogue RT task?

 - How to determine if a kernel is booted with PREEMPT_RT enabled?

 - librtpi: "solving" long-standing glibc pthread condvar internal lock inversion with a new implementation; motivations, technical details, etc.

 - SCHED_DEADLINE - Lots of research has been made to various issues like CPU affinity, Bandwidth inheritance, cgroup support; but nothing has been done to the kernel. Let's make a commitment and push these ideas forward into mainline.

 - How can we modify lockdep to catch problems that can break PREEMPT_RT?

 - Discuss various types of failures that can happen with PREEMPT_RT that normally would not happen in the vanilla kernel.

If you want to lead one of the above sessions, or if you have a new
session you want to submit, please do so here:

  https://linuxplumbersconf.org/event/2/abstracts/

Set up an account, and then click "Submit new proposal".

Fill out the "Title", "Content", select the "Authors" as the one leading
the session (yourself), and then for "Track" select "RT MC Topics CfP".
Select "Yes" to agree with the anti-harassment policy, and then hit
Submit.

The RT Microconference is only 4 hours (including breaks), thus we may
not be able to fit all the topics in. But if a session is not
submitted, then it will not have any chance of being on the agenda.

Looking forward to seeing you in Vancouver, Canada in November!

-- Steve
