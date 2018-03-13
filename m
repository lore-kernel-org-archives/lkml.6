Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeCMJ0p (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:26:45 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:48102 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752394AbeCMJ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:26:42 -0400
Date: Tue, 13 Mar 2018 10:26:38 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jesper Nilsson <jespern@axis.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
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
Subject: Re: [GIT PULL] CRIS: Drop support for the CRIS-port
Message-ID: <20180313092638.GC17177@axis.com>
References: <CAK8P3a1KE_0+vDC48-NzzW8eT1YZ8MZRun-1GeRMNg+o8dqZUg@mail.gmail.com>
 <20180308155116.GW17177@axis.com>
 <20180311110551.GX17177@axis.com>
 <CAK8P3a2LRyHmQ1=bFwrW9a3RR53W0CiiakNTg2823utAnVpBmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2LRyHmQ1=bFwrW9a3RR53W0CiiakNTg2823utAnVpBmQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 09:21:25PM +0100, Arnd Bergmann wrote:
> On Sun, Mar 11, 2018 at 12:05 PM, Jesper Nilsson
> <jesper.nilsson@axis.com> wrote:
> > Hi Arnd,
> >
> > As promised, pull the below tag for the removal of the CRIS-port.
> > There are still a few references to the CRIS port left, and they
> > can be grouped into two categories:
> >
> > - Examples or references to the CRIS port as provenance.
> >         These I believe can be left as is.
> >
> > - The workarounds for CRIS not having "unpacked" structs.
> >         When I looked at it 10 years ago, CRIS was the only port
> >         that needed explicit alignment of some structs,
> >         due to pointers being valid at any byte offset in CRIS,
> >         which would wreak havoc with code that assumed that the
> >         lower bits of a pointer are free to use as flags.
> >         I'm leaving these in until we can say that no newer
> >         port has the same problem.
> >
> > Best regards,
> 
> Hi Jesper,
> 
> Thanks for the patch! I had done a slightly different approach, but
> am merging your changes into my tree now. I already have separate
> patches for each driver subsystem, so I'll keep my versions, having
> already made sure that your changes were identical.
> 
> For Documentation/features and the Kconfig files that have lists
> of architectures, I also have separate patches that do the changes
> for all architectures, to avoid touching those files (up to) eight times
> for one trivial change each. I could redo those, but since your patch
> conflicts with David Howell's patch for mn10300, it's easier to keep
> what I already have.
> 
> This leaves basically the removal of arch/cris along with the MAINTAINER
> file update. I'm keeping the patch I did, but change the author and
> changelog text to what you sent, with my Signed-off-by and a list
> of my modifications) added below.
> 
> Hope that works for you.

Yeah, no problem, and thanks.

>      Arnd

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
