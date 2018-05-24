Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964955AbeEXHMJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:12:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58860 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935346AbeEXHMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:12:06 -0400
Date: Thu, 24 May 2018 09:11:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Ivan Babrou <ibobrik@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/3] sched/fair: add tracepoints for cfs throttle
Message-ID: <20180524071152.GB12198@hirez.programming.kicks-ass.net>
References: <20180522062017.5193-1-xiyou.wangcong@gmail.com>
 <20180522062017.5193-4-xiyou.wangcong@gmail.com>
 <CANWdNRCQCteO7L+Of7T2vWBW7GbMHyvyF5aSQMVYNGg_afxNhg@mail.gmail.com>
 <20180523090944.GV12217@hirez.programming.kicks-ass.net>
 <CAM_iQpUEvWrMPWQussA31kEAiutLR4WUVOtsohHm5hg4wt59Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpUEvWrMPWQussA31kEAiutLR4WUVOtsohHm5hg4wt59Hw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 09:40:47PM -0700, Cong Wang wrote:
> On Wed, May 23, 2018 at 2:09 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > Yeah, don't worry. I hate tracepoints, I regret the existing ones, no
> > new ones will happen.
> 
> No matter you hate them or not, they are useful:

No argument there.

> Unlike in sched, tracepoints are welcome in networking:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/include/trace/events/tcp.h

They are also absolutely disallowed in the vfs..

> I don't want to change your mind, just want to show the facts.

The problem with tracepoints is that they can become ABI and you cannot
change them without breaking tools. This is a crap situation and I'm fed
up with it.
