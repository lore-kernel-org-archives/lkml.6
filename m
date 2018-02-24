Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeBXQtW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 11:49:22 -0500
Received: from netrider.rowland.org ([192.131.102.5]:37347 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751326AbeBXQtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 11:49:21 -0500
Date: Sat, 24 Feb 2018 11:49:20 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Andrea Parri <parri.andrea@gmail.com>
cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <mingo@kernel.org>, Will Deacon <will.deacon@arm.com>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>, <npiggin@gmail.com>,
        <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: update: remove rb-dep,
 smp_read_barrier_depends, and lockless_dereference
In-Reply-To: <20180224143658.GA3556@andrea>
Message-ID: <Pine.LNX.4.44L0.1802241149090.14116-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Feb 2018, Andrea Parri wrote:

> On Fri, Feb 23, 2018 at 07:30:13PM -0800, Paul E. McKenney wrote:
> > On Sat, Feb 24, 2018 at 12:22:24PM +0900, Akira Yokosawa wrote:
> > > On 2018/02/22 07:29:02 +0900, Akira Yokosawa wrote:
> > > > On 2018/02/22 2:15, Alan Stern wrote:
> 
> [...]
> 
> > > >>
> > > >> Akira pointed out some typos in the original patch, and he noted that
> > > >> cheatsheet.txt should be updated to indicate how unsuccessful RMW
> > > >> operations relate to address dependencies.
> > > > 
> > > > My point was to separate unannotated loads from READ_ONCE(), if the
> > > > cheatsheet should concern such accesses as well.
> > > > Unsuccessful RMW operations were brought up by Andrea.
> > > >
> > > 
> > > Paul, can you amend above paragraph in the change log to something like:
> > > 
> > >     Akira pointed out some typos in the original patch, and he noted that
> > >     cheatsheet.txt should be updated to indicate READ_ONCE() implies
> > >     address dependency, which invited Andrea's observation that it should
> > >     also be updated to indicate how unsuccessful RMW operations relate to
> > >     address dependencies.
> > > 
> > > , if Alan and Andrea are OK with the amendment.
> > > 
> > > Also, please append my Acked-by.
> > > 
> > > Acked-by: Akira Yokosawa <akiyks@gmail.com>
> > 
> > I can still amend this, and have added your Acked-by.  If Alan and Andrea
> > OK with your change, I will apply that also.
> 
> LGTM. Thanks,

Me too.

Alan
