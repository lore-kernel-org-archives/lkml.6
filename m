Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeDKK0a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:26:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbeDKK02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:26:28 -0400
Date: Wed, 11 Apr 2018 12:26:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Zhou Chengming <zhouchengming1@huawei.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        huawei.libin@huawei.com
Subject: Re: [PATCH] sched/rt.c: pick and check task if double_lock_balance()
 unlock the rq
Message-ID: <20180411102622.GK4082@hirez.programming.kicks-ass.net>
References: <1505112709-102019-1-git-send-email-zhouchengming1@huawei.com>
 <20180410180546.4159134c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410180546.4159134c@gandalf.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 06:05:46PM -0400, Steven Rostedt wrote:
> 
> Peter,
> 
> Going through my inbox, I stumbled across this one. And it doesn't
> appear to be addressed.
> 
> I think this patch is a reasonable solution.

Urgh, yeah, also seem to have forgotten about it. The proposed solution
is in fact simpler than the existing code. Also, I think deadline.c has
the exact same problem.

Zhou, could you respin and fix both?
