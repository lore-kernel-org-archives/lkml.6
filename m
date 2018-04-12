Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeDLML5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 08:11:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56950 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeDLML4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 08:11:56 -0400
Date: Thu, 12 Apr 2018 14:11:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Li Bin <huawei.libin@huawei.com>
Cc: rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com
Subject: Re: [PATCH 0/2] sched: pick and check task if double_lock_balance()
 unlock the rq
Message-ID: <20180412121145.GA4082@hirez.programming.kicks-ass.net>
References: <1523530735-20011-1-git-send-email-huawei.libin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523530735-20011-1-git-send-email-huawei.libin@huawei.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 06:58:53PM +0800, Li Bin wrote:
> Li Bin (1):
>   sched/deadline.c: pick and check task if double_lock_balance() unlock
>     the rq
> 
> Zhou Chengming (1):
>   sched/rt.c: pick and check task if double_lock_balance() unlock the
>     rq
> 

Much thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Ingo, please apply.
