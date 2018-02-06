Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeBFSgi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:36:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42004 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753026AbeBFSg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:36:29 -0500
Date: Tue, 6 Feb 2018 18:36:24 +0000
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Message-ID: <20180206183623.GH5739@e110439-lin>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <f574036c-7572-9b97-79a0-794ff48e4d49@evidence.eu.com>
 <20180206154319.GF5739@e110439-lin>
 <68afaf84-893e-6770-b9f1-619cd2b6dc9c@evidence.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68afaf84-893e-6770-b9f1-619cd2b6dc9c@evidence.eu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Feb 19:14, Claudio Scordino wrote:
> Hi Patrick,

> >At first glance, your proposal below makes to make sense.
> >
> >However, I'm wondering if we cannot get it working using
> >rq->dl's provided information instead of flags?
> 
> Yes, we can use the value of rq->dl to check if there has been an increase of the deadline utilization.
> Even if schedutil might have been triggered by a different scheduling class, the effect should be almost the same.
> 
> Below a potential patch. I've kept all frequency update decisions in a single point (i.e. sugov_should_update_freq).
> Not yet tested (waiting for further comments).

I have a todo list entry to backport/test Peter's series on Android...
will add this patch too. Thanks.

-- 
#include <best/regards.h>

Patrick Bellasi
