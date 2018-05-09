Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934164AbeEIIvN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:51:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50508 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934089AbeEIIvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:51:10 -0400
Date: Wed, 9 May 2018 10:51:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rohit Jain <rohit.k.jain@oracle.com>
Cc: matt@codeblueprint.co.uk, mingo@kernel.org, dhaval.giani@oracle.com,
        subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] sched: Distinguish between idle_cpu calls based on desired
 effect
Message-ID: <20180509085105.GG12217@hirez.programming.kicks-ass.net>
References: <1525736477-8184-1-git-send-email-rohit.k.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525736477-8184-1-git-send-email-rohit.k.jain@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 04:41:17PM -0700, Rohit Jain wrote:
> In commit 247f2f6f3c706b40b5f3886646f3eb53671258bf we distinguish
> between idle_cpu when the vcpu is not running for scheduling threads.
> However, idle_cpu function is used at other places for actually checking
> whether the state of the CPU is idle or not. Hence splitting the use of
> that function based on the desired return value.

Yes, that looks OK.

for your gitconfig:

[core]
	abbrev = 12
[alias]
        one = show -s --pretty='format:%h (\"%s\")'

$ git one 247f2f6f3c706b40b5f3886646f3eb53671258bf
247f2f6f3c70 ("sched/core: Don't schedule threads on pre-empted vCPUs")

which gives the normal commit quote style.
