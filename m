Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756057AbeCHPv1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:51:27 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:50104 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755696AbeCHPv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:51:26 -0500
Date: Thu, 8 Mar 2018 16:51:16 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Simek <monstr@monstr.eu>, Andi Kleen <ak@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-cris-kernel@axis.com, Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesper Nilsson <jesper@jni.nu>, Greentime Hu <green.hu@gmail.com>,
        Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Vincent Chen <deanbo422@gmail.com>, Dave Young <dyoung@redhat.com>
Subject: Re: CRIS port status, was: [PATCH] dump_stack: convert generic
 dump_stack into a weak symbol
Message-ID: <20180308155116.GW17177@axis.com>
References: <CAK8P3a1KE_0+vDC48-NzzW8eT1YZ8MZRun-1GeRMNg+o8dqZUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1KE_0+vDC48-NzzW8eT1YZ8MZRun-1GeRMNg+o8dqZUg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 03:09:27PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 7, 2018 at 2:40 PM, Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> > On (03/07/18 13:48), Arnd Bergmann wrote:
> > [..]
> >> >
> >> > I can easily stop building blackfin - and, if the intention is to
> >> > remove it, there is not much point in wasting resources building it any
> >> > anyway.
> >>
> >> Right. At the moment, the plan is to remove metag, score, unicore32,
> >> m32r, frv and blackfin. If you are building any more of those, you can
> >> stop that as well.
> >>
> >> The fate of tile and mn10300 is still open, but I suspect they won't
> >> last long either.
> >
> > That's a huge list.
> >
> > I heard that CRIS is having some problems as well:
> > https://lkml.org/lkml/2018/1/11/403
> 
> Interesting. I thought I looked at cris when I made the list and found that
> it was still (semi-)regularly updated, so I assumed it was still needed.

Yeah, I've tried to keep it chugging along, but as I mentioned
in that thread, time and working hardware are running low.

I've not heard of anyone using real CRIS-hardware with mainline
releases for a couple of years now (except me :-)

> Jesper/Mikael: If you are considering to drop the port, I think it
> would make sense to do it at the same time as the others, so feel
> free to send me a removal pull request for 4.17 that I'll merge with
> the other removal patches, or I can offer to remove it myself.

I'm having mixed feelings, but I think it's time for Linux to
drop the CRIS-port. I'll prepare some patches for you in the CRIS-tree.

> Obviously if your plans have changed in the meantime and you
> prefer to keep it for a while longer, just let me know and I'll document
> the state in the tag description for the arch removal for future reference.
> 
> If we remove cris, it's probably also appropriate to ask the question
> about microblaze: Michal, I know your work on microblaze linux has
> been winding down over the years as the user base shrinks (just
> like for all others above). Should we keep it for a few more years for
> the remaining users, or is it time to let go? I would guess we still
> have active users on modern kernels, but that's what I thought
> about cris as well ;-)
> 
>       Arnd

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
