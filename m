Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeBHOE5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:04:57 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:45837 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeBHOEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:04:55 -0500
X-Google-Smtp-Source: AH8x2249ftPUpWHNIhjG95GQe3Si+c/RYszI71pEzFtGRJLS+ZwBN+nVnOHbt3eGatbWKPKMtFL2IZxYbKL8zYiW+Do=
MIME-Version: 1.0
In-Reply-To: <1518097702-9665-1-git-send-email-leo.yan@linaro.org>
References: <1518097702-9665-1-git-send-email-leo.yan@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 8 Feb 2018 19:34:54 +0530
X-Google-Sender-Auth: FUeOrfgYYQoBtcrm2-beqctGlfc
Message-ID: <CAOh2x==puw3JaGYFGRN4y7ZGxmb7iHf6BDUif8c+utzvz1uXLA@mail.gmail.com>
Subject: Re: [PATCH] sched/cpufreq: Remove unused macro SUGOV_KTHREAD_PRIORITY
To: Leo Yan <leo.yan@linaro.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vikram Mulukutla <markivx@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot Cc'ing me ? :)

On Thu, Feb 8, 2018 at 7:18 PM, Leo Yan <leo.yan@linaro.org> wrote:
> Since schedutil kernel thread directly set priority to 0, the macro
> SUGOV_KTHREAD_PRIORITY is not used.  So remove it.
>
> Cc: Vikram Mulukutla <markivx@codeaurora.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
