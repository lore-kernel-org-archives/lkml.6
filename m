Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967071AbeEYQOf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:14:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39270 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966725AbeEYQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:14:34 -0400
Date: Fri, 25 May 2018 18:14:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com
Subject: Re: [PATCH v5 01/10] sched/pelt: Move pelt related code in a
 dedicated file
Message-ID: <20180525161423.GP12180@hirez.programming.kicks-ass.net>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-2-git-send-email-vincent.guittot@linaro.org>
 <20180525142648.GC15173@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525142648.GC15173@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 03:26:48PM +0100, Quentin Perret wrote:
> (both quite old TBH -- 4.9.4 for arm64, 4.8.4 for x86).

You really should try with a more recent compiler.
