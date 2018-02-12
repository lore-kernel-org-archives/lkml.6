Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeBLUAj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:00:39 -0500
Received: from casper.infradead.org ([85.118.1.10]:39466 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeBLUAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:00:38 -0500
Date: Mon, 12 Feb 2018 20:57:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] sched/fair: Do not migrate on wake_affine_weight if
 weights are equal
Message-ID: <20180212195720.GC25201@hirez.programming.kicks-ass.net>
References: <20180212145857.8056-1-mgorman@techsingularity.net>
 <20180212145857.8056-4-mgorman@techsingularity.net>
 <20180212172926.GY25201@hirez.programming.kicks-ass.net>
 <1518462889.7104.78.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518462889.7104.78.camel@gmx.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 08:14:49PM +0100, Mike Galbraith wrote:
> On Mon, 2018-02-12 at 18:29 +0100, Peter Zijlstra wrote:

> > Except for sync wakeups, where you say, if everything else is equal,
> > pull, which also makes sense, because sync says 'current' promises to go
> > away.
> 
> Tasks tend to not honor that promise.. a lot.

Yes I know.. still its something and its a very small bias in this case.
