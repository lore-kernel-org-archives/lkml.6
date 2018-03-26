Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeCZOVl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751730AbeCZOVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:21:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79D820C48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 26 Mar 2018 11:21:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Daniel Bristot de Oliveira <daniel@bristot.me>,
        Luis Claudio =?iso-8859-1?Q?R=2E_Gon=E7alves?=
        <lclaudio@redhat.com>,
        Clark Williams <williams@redhat.com>,
        target-devel <target-devel@vger.kernel.org>
Subject: Re: [PATCH] target: Use WARNON_NON_RT(!irqs_disabled())
Message-ID: <20180326142136.GD18897@kernel.org>
References: <20180321153854.GB24312@kernel.org>
 <CA+55aFwKN_JijmCt=0S4jF8KzGPmoKNbuYF59va7U4ziJLLryA@mail.gmail.com>
 <20180322093745.GC4229@kernel.org>
 <20180323155513.dwbgvblenlji33as@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323155513.dwbgvblenlji33as@linutronix.de>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 23, 2018 at 04:55:13PM +0100, Sebastian Andrzej Siewior escreveu:
> Arnaldo, please do "[PATCH RT]" while sending patches. Then the bots
> don't complain if it applies but does not compile on !RT kernel (or so
> I've been told).

Ok, I'll try to remember that for future patches.

- Arnaldo
