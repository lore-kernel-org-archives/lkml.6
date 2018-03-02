Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932587AbeCBUG1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 15:06:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932131AbeCBUG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 15:06:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40978217A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 2 Mar 2018 15:06:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 06/10] trace: Eliminate
 cond_resched_rcu_qs() in favor of cond_resched()
Message-ID: <20180302150621.069d1443@vmware.local.home>
In-Reply-To: <20180301204858.GH3777@linux.vnet.ibm.com>
References: <1512156104-20104-6-git-send-email-paulmck@linux.vnet.ibm.com>
        <20180224151240.0d63a059@vmware.local.home>
        <20180225174927.GC2855@linux.vnet.ibm.com>
        <20180225181730.GA3963@linux.vnet.ibm.com>
        <20180225183944.GA8840@linux.vnet.ibm.com>
        <20180226212920.43e25d6e@vmware.local.home>
        <20180227153646.GD3777@linux.vnet.ibm.com>
        <20180228181252.55e0590c@vmware.local.home>
        <20180301012144.GX3777@linux.vnet.ibm.com>
        <20180301000404.64828a0e@vmware.local.home>
        <20180301204858.GH3777@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018 12:48:58 -0800
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> So how about I rename cond_resched_rcu_qs() to cond_resched_tasks_rcu_qs(),
> which at least gives a hint as to where it needs to be used?
> 
> Would that work for you?

Yes, definitely!

-- Steve
