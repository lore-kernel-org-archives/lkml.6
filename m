Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932692AbeEWLij (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:38:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51146 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932543AbeEWLid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:38:33 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v4 0/2] Fix and cleanup iowait boost
Date: Wed, 23 May 2018 13:37:52 +0200
Message-ID: <1864026.X9Jp3j4sSN@aspire.rjw.lan>
In-Reply-To: <20180522110754.20832-1-patrick.bellasi@arm.com>
References: <20180522110754.20832-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 22, 2018 1:07:52 PM CEST Patrick Bellasi wrote:
> Here is the (hopefully) final update of:
> 
>    https://lkml.org/lkml/2018/5/21/114
>    20180521085120.7902-1-patrick.bellasi@arm.com
> 
> which just includes the small typo fixes suggested by Jeol and the ack
> and review tags collected so far.
> 
> Cheers Patrick
> 
> Changes in v4:
>  - fixed typos in changelog (Joel)
>  - added Reviewed-by Joel Fernandes
>  - added Acked-by Viresh and Peter
> 
> Changes in v3:
>  - renamed the iowait boost functions (Peter)
>  - moved boost reset into a dedicated function (Peter)
>  - split the fix into a separated patch (Viresh)
>  - added "Fixes" tag (Viresh)
> 
> Patrick Bellasi (2):
>   cpufreq: schedutil: Fix iowait boost reset
>   cpufreq: schedutil: Cleanup and document iowait boost
> 
>  kernel/sched/cpufreq_schedutil.c | 152 +++++++++++++++++++++++++++------------
>  1 file changed, 108 insertions(+), 44 deletions(-)
> 
> 

Both patches applied, thanks!
