Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeFEOQY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:16:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeFEOQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:16:22 -0400
Date: Tue, 5 Jun 2018 16:16:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: yang <yellowriver2010@hotmail.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: make function static to avoid compile
 warnings
Message-ID: <20180605141617.GY12198@hirez.programming.kicks-ass.net>
References: <SG2PR0201MB09364888584EA71C70C90BA7B2660@SG2PR0201MB0936.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2PR0201MB09364888584EA71C70C90BA7B2660@SG2PR0201MB0936.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 01:46:59PM +0000, yang wrote:
> Fix compile warnings:
>   CC      kernel/sched/fair.o
> kernel/sched/fair.c:2461:6: warning: no previous prototype for ‘task_numa_work’ [-Wmissing-prototypes]
>  void task_numa_work(struct callback_head *work)
>       ^
> kernel/sched/fair.c:2606:6: warning: no previous prototype for ‘task_tick_numa’ [-Wmissing-prototypes]
>  void task_tick_numa(struct rq *rq, struct task_struct *curr)
>       ^
> kernel/sched/fair.c:3853:6: warning: no previous prototype for ‘sync_entity_load_avg’ [-Wmissing-prototypes]
>  void sync_entity_load_avg(struct sched_entity *se)
>       ^
> kernel/sched/fair.c:3866:6: warning: no previous prototype for ‘remove_entity_load_avg’ [-Wmissing-prototypes]
>  void remove_entity_load_avg(struct sched_entity *se)

What compiler does that? Seems like a pretty annoying warning.
