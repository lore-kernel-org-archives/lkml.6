Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeCPRm4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:42:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55306 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbeCPRmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:42:55 -0400
Date: Fri, 16 Mar 2018 18:42:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rohit Jain <rohit.k.jain@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        steven.sistare@oracle.com, joelaf@google.com, jbacik@fb.com,
        juri.lelli@redhat.com, dhaval.giani@oracle.com, efault@gmx.de,
        riel@surriel.com
Subject: Re: [RESEND PATCH v2] sched/fair: Remove check in idle_balance
 against migration_cost
Message-ID: <20180316174241.GB4043@hirez.programming.kicks-ass.net>
References: <1521052607-24622-1-git-send-email-rohit.k.jain@oracle.com>
 <20180316143550.GH4064@hirez.programming.kicks-ass.net>
 <48b63847-123c-6a28-d558-392b8122cd7e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48b63847-123c-6a28-d558-392b8122cd7e@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 10:21:54AM -0700, Rohit Jain wrote:
> Hi Peter,
> 
> On 03/16/2018 07:35 AM, Peter Zijlstra wrote:
> > On Wed, Mar 14, 2018 at 11:36:47AM -0700, Rohit Jain wrote:
> > > Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
> > > 
> > > Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
> > Surely you only need a single on of those.
> 
> Oh wow! I don't know how I missed this :) Thanks!

> However, when I clone from
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/
> I cannot see the commit.

You need to look at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/

my queue.git is the sporadic push of my quilt tree on top of that.
