Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbeDMKEo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:04:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34389 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbeDMKEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:04:42 -0400
X-Google-Smtp-Source: AIpwx4/rgfF2GKGISv1bPzGEkw3hpog5qtccS0/DN2up2KfWMfqiMz+Qu5ZQfgGfgP5kFpgm1KMo6w==
Date: Fri, 13 Apr 2018 12:04:34 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] tools/memory-model: Model 'smp_store_mb()'
Message-ID: <20180413100434.GA10701@andrea>
References: <1523535770-10781-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180412210627.GF3948@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412210627.GF3948@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 02:06:27PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 12, 2018 at 02:22:48PM +0200, Andrea Parri wrote:
> > Hi,
> > 
> > This (tiny) series adds 'smp_store_mb()' to the model (patch 1/2), and
> > it fixes a stylistic discrepancy in 'linux-kernel.def (patch 2/2).
> 
> I applied them both, thank you!
> 
> I had to apply 2/2 by hand for reasons that are not at all clear to
> me.  Please check to make sure I got it right.

It's OK for me.  Thanks,

  Andrea


> 
> 							Thanx, Paul
> 
> > Cheers,
> >   Andrea
> > 
> > Andrea Parri (2):
> >   tools/memory-model: Model 'smp_store_mb()'
> >   tools/memory-model: Fix coding style in 'linux-kernel.def'
> > 
> >  tools/memory-model/linux-kernel.def | 29 +++++++++++++++--------------
> >  1 file changed, 15 insertions(+), 14 deletions(-)
> > 
> > -- 
> > 2.7.4
> > 
> 
