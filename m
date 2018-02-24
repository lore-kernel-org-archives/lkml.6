Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeBXOhI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 09:37:08 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35403 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBXOhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 09:37:06 -0500
X-Google-Smtp-Source: AH8x227VTvIoGYx/FY0ukQAa4OO8a/3xtGyViKBGPNph6PrB659sx2zSWNbDUcLy4OlB1lJ9RDFGmA==
Date: Sat, 24 Feb 2018 15:36:58 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] tools/memory-model: update: remove rb-dep,
 smp_read_barrier_depends, and lockless_dereference
Message-ID: <20180224143658.GA3556@andrea>
References: <Pine.LNX.4.44L0.1802211214070.2032-100000@iolanthe.rowland.org>
 <74dbcbd4-6034-0be9-7674-ccb058de6177@gmail.com>
 <ea223820-6a1a-b1a6-58c5-c4c720ef58ea@gmail.com>
 <20180224033013.GR2855@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224033013.GR2855@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 07:30:13PM -0800, Paul E. McKenney wrote:
> On Sat, Feb 24, 2018 at 12:22:24PM +0900, Akira Yokosawa wrote:
> > On 2018/02/22 07:29:02 +0900, Akira Yokosawa wrote:
> > > On 2018/02/22 2:15, Alan Stern wrote:

[...]

> > >>
> > >> Akira pointed out some typos in the original patch, and he noted that
> > >> cheatsheet.txt should be updated to indicate how unsuccessful RMW
> > >> operations relate to address dependencies.
> > > 
> > > My point was to separate unannotated loads from READ_ONCE(), if the
> > > cheatsheet should concern such accesses as well.
> > > Unsuccessful RMW operations were brought up by Andrea.
> > >
> > 
> > Paul, can you amend above paragraph in the change log to something like:
> > 
> >     Akira pointed out some typos in the original patch, and he noted that
> >     cheatsheet.txt should be updated to indicate READ_ONCE() implies
> >     address dependency, which invited Andrea's observation that it should
> >     also be updated to indicate how unsuccessful RMW operations relate to
> >     address dependencies.
> > 
> > , if Alan and Andrea are OK with the amendment.
> > 
> > Also, please append my Acked-by.
> > 
> > Acked-by: Akira Yokosawa <akiyks@gmail.com>
> 
> I can still amend this, and have added your Acked-by.  If Alan and Andrea
> OK with your change, I will apply that also.

LGTM. Thanks,

  Andrea


> 
