Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeBHPXn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:23:43 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33001 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeBHPXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:23:41 -0500
X-Google-Smtp-Source: AH8x225D7o3Fl0QoAKLUVj4ZLlE88nE+Ndf9tZCI7VhVv1+if3kYF28uYuNR/Ob/CtHOfBNPx5BiAA==
Date: Thu, 8 Feb 2018 23:23:30 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vikram Mulukutla <markivx@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] sched/cpufreq: Remove unused macro SUGOV_KTHREAD_PRIORITY
Message-ID: <20180208152330.GA16412@leoy-ThinkPad-X240s>
References: <1518097702-9665-1-git-send-email-leo.yan@linaro.org>
 <CAOh2x==puw3JaGYFGRN4y7ZGxmb7iHf6BDUif8c+utzvz1uXLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOh2x==puw3JaGYFGRN4y7ZGxmb7iHf6BDUif8c+utzvz1uXLA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 07:34:54PM +0530, Viresh Kumar wrote:
> Forgot Cc'ing me ? :)

I meant to copy you, but I wrongly added Vikram :)

> On Thu, Feb 8, 2018 at 7:18 PM, Leo Yan <leo.yan@linaro.org> wrote:
> > Since schedutil kernel thread directly set priority to 0, the macro
> > SUGOV_KTHREAD_PRIORITY is not used.  So remove it.
> >
> > Cc: Vikram Mulukutla <markivx@codeaurora.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 2 --
> >  1 file changed, 2 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for acking, Viresh and Daniel.
