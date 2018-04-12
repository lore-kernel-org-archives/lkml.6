Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbeDLMUP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 08:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752813AbeDLMUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 08:20:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F07F217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 12 Apr 2018 08:20:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Li Bin <huawei.libin@huawei.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, guohanjun@huawei.com
Subject: Re: [PATCH 0/2] sched: pick and check task if double_lock_balance()
 unlock the rq
Message-ID: <20180412082010.3f088370@gandalf.local.home>
In-Reply-To: <20180412121145.GA4082@hirez.programming.kicks-ass.net>
References: <1523530735-20011-1-git-send-email-huawei.libin@huawei.com>
        <20180412121145.GA4082@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2018 14:11:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Apr 12, 2018 at 06:58:53PM +0800, Li Bin wrote:
> > Li Bin (1):
> >   sched/deadline.c: pick and check task if double_lock_balance() unlock
> >     the rq
> > 
> > Zhou Chengming (1):
> >   sched/rt.c: pick and check task if double_lock_balance() unlock the
> >     rq
> >   
> 
> Much thanks!
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Ingo, please apply.

You can add my:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

but I would still like to see the declaration of next_task before the
comment, just for style concerns.

-- Steve
