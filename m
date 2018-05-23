Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754581AbeEWJJx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:09:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36510 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754378AbeEWJJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:09:52 -0400
Date: Wed, 23 May 2018 11:09:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ivan Babrou <ibobrik@gmail.com>
Cc: xiyou.wangcong@gmail.com, linux-kernel@vger.kernel.org, pjt@google.com,
        efault@gmx.de, tglx@linutronix.de, mingo@kernel.org
Subject: Re: [PATCH 3/3] sched/fair: add tracepoints for cfs throttle
Message-ID: <20180523090944.GV12217@hirez.programming.kicks-ass.net>
References: <20180522062017.5193-1-xiyou.wangcong@gmail.com>
 <20180522062017.5193-4-xiyou.wangcong@gmail.com>
 <CANWdNRCQCteO7L+Of7T2vWBW7GbMHyvyF5aSQMVYNGg_afxNhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANWdNRCQCteO7L+Of7T2vWBW7GbMHyvyF5aSQMVYNGg_afxNhg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 11:35:38PM -0700, Ivan Babrou wrote:
> > +       TP_printk("path=%s cpu=%d runtime_remaining=%lld",
> > __get_str(cfs_path),
> > +                 __entry->cpu, __entry->runtime_remaining)
> >
> 
> Can you add "[ns]" as the unit to runtime_remaining? We have it in
> "sched:sched_stat_runtime".

Yeah, don't worry. I hate tracepoints, I regret the existing ones, no
new ones will happen.
