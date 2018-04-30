Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756627AbeD3Tm5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:42:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754638AbeD3Tm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:42:56 -0400
Date: Mon, 30 Apr 2018 21:42:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, Paul Turner <pjt@google.com>,
        Mike Galbraith <efault@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched/fair: make CFS bandwidth slice per cpu group
Message-ID: <20180430194251.GB12217@hirez.programming.kicks-ass.net>
References: <20180430192925.12589-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430192925.12589-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 12:29:25PM -0700, Cong Wang wrote:
> Currently, the sched_cfs_bandwidth_slice_us is a global setting which
> affects all cgroups. Different groups may want different values based
> on their own workload, one size doesn't fit all. The global pool filled
> periodically is per cgroup too, they should have the right to distribute
> their own quota to each local CPU with their own frequency.

Why.. what happens? This doesn't really tell us anything.
