Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbeDKOxa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:53:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47960 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbeDKOx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:53:28 -0400
Date: Wed, 11 Apr 2018 16:53:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info
 available
Message-ID: <20180411145316.GJ4043@hirez.programming.kicks-ass.net>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406172835.20078-1-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 06:28:35PM +0100, Patrick Bellasi wrote:
> is maintained although there are not actual usages so far in mainline
> for this hint... do we really need it?

There were intel_pstate patches that I expected to have shown up
already, and I meant to have a look at sugov, except I got side-tracked
again :/
