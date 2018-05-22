Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeEVP1k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbeEVP1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:27:38 -0400
Date: Tue, 22 May 2018 11:27:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU branching for the v4.19 merge window
Message-ID: <20180522112736.4b44ae3c@gandalf.local.home>
In-Reply-To: <20180517144044.GA6089@linux.vnet.ibm.com>
References: <20180517144044.GA6089@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018 07:40:44 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> Hello, Steve!
> 
> Another year, another difficult-to-branch set of RCU commits.
> 
> In happy contrast to last year, I can make some branches (SRCU, some
> of the torture commits, and a few miscellaneous commits), but I will
> likely end up with several short branches and one huge one.  My thought
> is to keep the long branch, but email the patches out in a few separate
> serieses, with each depending on its predecessor.  For example, one series
> from the big branch would be folding the ->gpnum and ->completed fields
> into a single ->gp_seq, which helps the RCU-flavor consolidation task.
> Another series suppresses some rare false-positive splats that have been
> plaguing me for more than a year.  Yet another series within this huge
> branch applies and optimizes funnel locking for grace-period startup.
> 
> The problem is that the conversion to ->gp_seq has a very large footprint,
> which of course generates lots of conflicts.  I could of course collapse
> these commits into a single commit, but if I did that I would also defer
> to the merge window following v4.19 due to the resulting loss of bisection
> within that change.
> 
> Any advice?
> 
> The commits are for-mingo..rcu/dev in my -rcu tree.

I don't see these branches (and I don't pull tags).

How bad are the conflicts? Or is it too late to respond to help (sorry,
was on vacation :-)

-- Steve
