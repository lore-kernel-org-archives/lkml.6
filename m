Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933218AbeBLJYN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:24:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42516 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeBLJYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:24:12 -0500
Date: Mon, 12 Feb 2018 10:24:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: Export kthread_data()
Message-ID: <20180212092405.GB25314@hirez.programming.kicks-ass.net>
References: <1518187941-29275-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518187941-29275-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 09:52:21AM -0500, Waiman Long wrote:
> When multiple kernel threads are created to cooperatively work on
> a common task, we may need a convenient way to access data that are
> specific to each kthread.
> 
> The kthread_data() function fits this need.  However, it was not
> visible to kthreads started in a kernel module. To solve this problem,
> the kthread_data() function is now exported allowing kthreads from
> kernel modules to use it.

No. Without an in-tree user, no export.
