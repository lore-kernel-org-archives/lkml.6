Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755609AbeDWOff (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755384AbeDWOfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:35:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D2220C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 23 Apr 2018 10:35:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com
Subject: Re: [PATCH tip/core/rcu 01/22] sched: Make non-production PREEMPT
 cond_resched() help Tasks RCU
Message-ID: <20180423103529.36848ae1@gandalf.local.home>
In-Reply-To: <20180423141038.GA4064@hirez.programming.kicks-ass.net>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
        <1524450747-22778-1-git-send-email-paulmck@linux.vnet.ibm.com>
        <20180423085127.GR4064@hirez.programming.kicks-ass.net>
        <20180423124000.GL26088@linux.vnet.ibm.com>
        <20180423094742.6582e19d@gandalf.local.home>
        <20180423141038.GA4064@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018 16:10:38 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> >  http://lkml.kernel.org/r/20180227153646.GD3777@linux.vnet.ibm.com  
> 
> That thread using cond_resched_task_rcu_qs() seems like a _lot_ better
> than having cond_resched() semantics change depending on random
> !scheduler config parameters.

Yeah, I agree. Not sure why Paul didn't push it. Maybe because I never
replied to that final email and he forgot?

Paul?

-- Steve
