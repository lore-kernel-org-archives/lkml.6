Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbeFEOPa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:15:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeFEOP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:15:27 -0400
Date: Tue, 5 Jun 2018 16:15:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH 2/7] atomics/treewide: rework ordering barriers
Message-ID: <20180605141520.GX12198@hirez.programming.kicks-ass.net>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180529180746.29684-3-mark.rutland@arm.com>
 <20180605121623.GI12258@hirez.programming.kicks-ass.net>
 <20180605132802.lqkmbroqmcxergrr@lakrids.cambridge.arm.com>
 <20180605135616.GV12198@hirez.programming.kicks-ass.net>
 <20180605140256.chenuacq7s34ye7u@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605140256.chenuacq7s34ye7u@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 03:02:56PM +0100, Mark Rutland wrote:
> Locally I've made this:
> 
> __atomic_acquire_fence()
> __atomic_release_fence()
> __atomic_pre_fence()
> __atomic_post_fence()
> 
> ... but I'm more than happy to rename however you prefer.

No that's fine. As long as we're rid of the whole mb_before_release and
friends.

Thanks!
