Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164821AbeCBPR7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:17:59 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:36120 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S936165AbeCBPR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:17:56 -0500
Date: Fri, 2 Mar 2018 10:17:55 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Boqun Feng <boqun.feng@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2 v2 RFC] tools/memory-model: redefine rb in terms of
 rcu-fence
In-Reply-To: <20180302045015.GO3777@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1803021017150.1408-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018, Paul E. McKenney wrote:

> On Fri, Mar 02, 2018 at 12:31:41PM +0800, Boqun Feng wrote:
> > On Thu, Mar 01, 2018 at 10:37:58AM -0800, Paul E. McKenney wrote:
> > > On Thu, Mar 01, 2018 at 09:49:06AM -0800, Paul E. McKenney wrote:
> 
> [ . . . ]
> 
> > > And as Andrea pointed out off-list, I did indeed mess up Boqun's change.
> > > I forgot to change the "irreflexive" into "acyclic".  Applying that change
> > > makes everything work.
> > > 
> > > Please accept my apologies for my confusion!
> > > 
> > 
> > np, also I should have provided a proper patch for your testing.
> > 
> > For this Alan's patch, feel free to add:
> > 
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Alan's last submission was still RFC, so I have not yet queued it.
> So this ball is still in Alan's court.

I'll wait a few more days to see if there are any other comments and 
then submit it officially.

Alan
