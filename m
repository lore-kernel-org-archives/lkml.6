Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755162AbeENQdU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:33:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46224 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755147AbeENQdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:33:18 -0400
Date: Mon, 14 May 2018 17:33:14 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 1/3] sched/cpufreq: always consider blocked FAIR
 utilization
Message-ID: <20180514163314.GG30654@e110439-lin>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-2-patrick.bellasi@arm.com>
 <20180511054407.qxwyyqsgyzqsf6e4@vireshk-i7>
 <20180511091242.GE30654@e110439-lin>
 <CAKfTPtCqoQOiJZktGu-QgCe2A7Cb0N7=eaqqSPN6vy=sKAkQHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCqoQOiJZktGu-QgCe2A7Cb0N7=eaqqSPN6vy=sKAkQHQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-May 11:18, Vincent Guittot wrote:
> On 11 May 2018 at 11:12, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> 
> >>
> >> Do we need a Fixes tag and Cc stable ?
> >
> > Mmm... no sure, I would say that's not a fix.
> >
> > As I say in the changelog above, 8f111bc357aa was doing the correct
> > thing but, since the recent Vincent's commit 31e77c93e432, this is an
> > update worth to have, since now we can trust the decay of blocked
> > utilization.
> >
> > Regarding stable, well... if Vincent patches are not going to be
> > considered for stable, then we should not consider this too, do we?
> 
> commit 31e77c93e432 is not for stable so this patch should not go too

Right, will not add stable in cc.

Thanks

-- 
#include <best/regards.h>

Patrick Bellasi
