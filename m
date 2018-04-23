Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754598AbeDWIyq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:54:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47728 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754231AbeDWIym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:54:42 -0400
Date: Mon, 23 Apr 2018 10:54:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel.opensrc@gmail.com, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 07/22] softirq: Eliminate unused
 cond_resched_softirq() macro
Message-ID: <20180423085430.GT4064@hirez.programming.kicks-ass.net>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
 <1524450747-22778-7-git-send-email-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524450747-22778-7-git-send-email-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 07:32:12PM -0700, Paul E. McKenney wrote:
> The cond_resched_softirq() macro is not used anywhere in mainline, so
> this commit simplifies the kernel by eliminating it.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Ingo Molnar <mingo@redhat.com>

Fair enough,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
