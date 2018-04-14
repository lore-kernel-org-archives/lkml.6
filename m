Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbeDNKHh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 06:07:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42106 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeDNKHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 06:07:36 -0400
Date: Sat, 14 Apr 2018 12:07:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH 0/4 v4] sched/rt: track rt rq utilization
Message-ID: <20180414100720.GW4064@hirez.programming.kicks-ass.net>
References: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



What I don't see in this patch-set is removal of the current rt_avg
stuff.

And I didn't look closely enough; but are the root cfs and rt pelt
windows aligned? They really should be; otherwise you can't combine them
sanely.
