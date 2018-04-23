Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755383AbeDWNZ1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:25:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39293 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755297AbeDWNZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:25:19 -0400
X-Google-Smtp-Source: AB8JxZox32KmnlM5lG3z7c1+kyjcQGGWwW9nnK62mmK09Mr37jKEw2LvElcNKyN8qx2KXx1MQrpyy24r48/DFwNNo10=
MIME-Version: 1.0
References: <20180423023150.GA21533@linux.vnet.ibm.com> <1524450747-22778-7-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180423085430.GT4064@hirez.programming.kicks-ass.net>
In-Reply-To: <20180423085430.GT4064@hirez.programming.kicks-ass.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Apr 2018 13:25:06 +0000
Message-ID: <CANn89iJShqinnNkBqw2CoqDJRLerAg=U_JV2-Uxb4LRU6sL5yQ@mail.gmail.com>
Subject: Re: [PATCH tip/core/rcu 07/22] softirq: Eliminate unused
 cond_resched_softirq() macro
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>, oleg@redhat.com,
        joel.opensrc@gmail.com, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 1:54 AM Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Apr 22, 2018 at 07:32:12PM -0700, Paul E. McKenney wrote:
> > The cond_resched_softirq() macro is not used anywhere in mainline, so
> > this commit simplifies the kernel by eliminating it.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Ingo Molnar <mingo@redhat.com>

> Fair enough,

> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Yes, I suggested this removal in
https://www.spinics.net/lists/netdev/msg375161.html

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks Paul.
