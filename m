Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753693AbeDKQvo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:51:44 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39574 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753413AbeDKQvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:51:42 -0400
X-Google-Smtp-Source: AIpwx4/P4br5L1/9S/PvxwnC0qmoooPx02l+nT5WIOva1r2magmOpy8CkWGKjs2cz0ZFIsXoW85/MYrTIp6NExA5VcQ=
MIME-Version: 1.0
In-Reply-To: <20180411161548.GP4082@hirez.programming.kicks-ass.net>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
 <20180410110412.GG14248@e110439-lin> <20180411151450.GK4043@hirez.programming.kicks-ass.net>
 <CAKfTPtC+-FR3ZD_t1vkGR2gVoUyxXpE=i4g9zqqLXu4jKKqgUA@mail.gmail.com>
 <20180411153710.GN4082@hirez.programming.kicks-ass.net> <CAKfTPtCNdxSmDfDO0Etf7fbYPeryrjdQChSGwMWxSRH8CcXqqg@mail.gmail.com>
 <20180411160000.GO4082@hirez.programming.kicks-ass.net> <CAKfTPtDjyjC5R7bhjGxhV8BN5J+LdzJmMgwaaVuE9ypvcSKapA@mail.gmail.com>
 <20180411161548.GP4082@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 11 Apr 2018 18:51:21 +0200
Message-ID: <CAKfTPtA+79WitkoBHeaGxjxJzr=8A4aH7iimz54Doj2ok8JXcA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info available
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 April 2018 at 18:15, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Apr 11, 2018 at 06:10:47PM +0200, Vincent Guittot wrote:
>> > Could is be that for some reason the nohz balancer now takes a very long
>> > time to run?
>>
>> Heiner mentions that is was a relatively slow celeron and he uses
>> ondemand governor. So I was about to ask him to use performance
>> governor to see if it can be because cpu runs slow and takes too muche
>> time to enter idle
>
> Maybe also hand him a patch with some trace_printk()s in and ask him to
> send /debug/tracing/trace after it happens or somesuch. Maybe we can
> find a clue that way.

yes
