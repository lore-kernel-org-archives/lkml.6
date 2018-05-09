Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935479AbeEIRf2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:35:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38701 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935374AbeEIRfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:35:25 -0400
X-Google-Smtp-Source: AB8JxZo/wUl698xl/s54MDHmqXh/NVTJAa36FT2qoLOjlYXjUZOjb0Xoa+fFBagzD1yR87M8F7xj6Q==
Date: Wed, 9 May 2018 19:35:17 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>, mingo@kernel.org
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 jc_docs tree
Message-ID: <20180509173517.GA17579@andrea>
References: <20180509202508.15c3435a@canb.auug.org.au>
 <20180509132824.GA14503@andrea>
 <20180509085920.5fbb32f5@lwn.net>
 <20180509165249.GA16976@andrea>
 <20180509111136.127756a8@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509111136.127756a8@lwn.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 11:11:36AM -0600, Jonathan Corbet wrote:
> On Wed, 9 May 2018 18:53:28 +0200
> Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> 
> > > Now that I look a little closer, I think the real issue is that the
> > > "features" documentation assumes that there's a Kconfig option for each,
> > > but there isn't in this case.  The lack of a Kconfig option does not,
> > > this time around, imply that the feature has gone away.
> > > 
> > > I think that I should probably revert this patch in the short term.
> > > Longer-term, it would be good to have an alternative syntax for "variable
> > > set in the arch headers" to describe situations like this.  
> > 
> > Both matters were discussed during v1:
> > 
> >   http://lkml.kernel.org/r/1522774551-9503-1-git-send-email-andrea.parri@amarulasolutions.com
> > 
> > ... (and the glory details are documented in features-refresh.sh ;-) ).
> 
> So I'll admit to being confused, since I don't see discussion of the
> actual topic at hand.

A couple of clicks on "next in thread"  :-)

  https://marc.info/?l=linux-kernel&m=152284705204400&w=2
  https://marc.info/?l=linux-kernel&m=152294150600751&w=2


> 
> > As I suggested above, simply reverting this patch will leave this file,
> > (and only this file!) out-of-date (and won't resolve the conflict with
> > Laurent's patch ...).
> 
> Reverting this patch retains the updates from earlier in the series, and
> does indeed make the conflict go away, so I'm still confused.  What am I
> missing?

The updates from earlier added "TODO" rows for nds32 and riscv, but missed
the "TODO -> ok" update for riscv.

  Andrea


> 
> Thanks,
> 
> jon
