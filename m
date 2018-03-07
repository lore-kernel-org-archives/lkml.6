Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933616AbeCGRfX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:35:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47134 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932759AbeCGRfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:35:21 -0500
Date: Wed, 7 Mar 2018 18:35:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v5 1/4] sched/fair: add util_est on top of PELT
Message-ID: <20180307173504.GP25181@hirez.programming.kicks-ass.net>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-2-patrick.bellasi@arm.com>
 <20180306185851.GG25201@hirez.programming.kicks-ass.net>
 <20180307113149.GA2211@e110439-lin>
 <20180307122437.GM25181@hirez.programming.kicks-ass.net>
 <20180307152458.GE2211@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307152458.GE2211@e110439-lin>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 03:24:58PM +0000, Patrick Bellasi wrote:

> Maybe that's the tricky bit: we remove the value we enqueued, _not_
> the current util_avg. Notice we use _task_util_est(p)... with the
> leading "_".

ARGH, ok let me try that again ;-)
