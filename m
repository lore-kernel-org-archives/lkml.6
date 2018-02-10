Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeBJKYm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 05:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbeBJKYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 05:24:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA6721726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Sat, 10 Feb 2018 11:24:37 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 0/6] isolation: 1Hz residual tick offloading v5
Message-ID: <20180210102436.GB14047@lerouge>
References: <1518112779-30196-1-git-send-email-frederic@kernel.org>
 <20180209070006.ndi57j2llrywo4yt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209070006.ndi57j2llrywo4yt@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 08:00:06AM +0100, Ingo Molnar wrote:
> 
> * Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> >       sched/isolation: Residual 1Hz scheduler tick offload
> >       sched/isolation: Tick offload documentation
> 
> Please try to start each title with a verb.
> 
> [ ... and preferably not by prepending 'do' ;-) ]
> 
> Beyond making changelogs more consistent, this will actually also add real 
> information to the title, because, for example, any of these possible variants:
> 
>        sched/isolation: Fix tick offload documentation
>        sched/isolation: Update tick offload documentation
>        sched/isolation: Add tick offload documentation
>        sched/isolation: Remove tick offload documentation
> 
>        sched/isolation: Fix residual 1Hz scheduler tick offload
>        sched/isolation: Update residual 1Hz scheduler tick offload
>        sched/isolation: Introduce residual 1Hz scheduler tick offload
>        sched/isolation: Remove residual 1Hz scheduler tick offload
> 
> will tell us _a lot more_ about the nature of the changes from the shortlog alone!

Good point, I get strange habits over the years.

Thanks.
