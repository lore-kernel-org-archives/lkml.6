Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934972AbeBMLtx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:49:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934231AbeBMLtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:49:52 -0500
Date: Tue, 13 Feb 2018 10:05:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: typo: remove space in #ifdef
Message-ID: <20180213090544.GE25201@hirez.programming.kicks-ass.net>
References: <1518512382-29426-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518512382-29426-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 09:59:42AM +0100, Vincent Guittot wrote:
> Remove a useless space in # ifdef and align it with others
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1070803..cad1932 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2823,7 +2823,7 @@ void reweight_task(struct task_struct *p, int prio)
>  }
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -# ifdef CONFIG_SMP
> +#ifdef CONFIG_SMP

Heh, so this is one where Ingo and me disagree ;-) He likes that
indented preprocessor nonsense, whereas I just find it really
bothersome.

I try and hide these in patches that touch the surrounding code.
