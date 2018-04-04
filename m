Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbeDDT77 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:59:59 -0400
Received: from muru.com ([72.249.23.125]:35278 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751519AbeDDT75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:59:57 -0400
Date: Wed, 4 Apr 2018 12:59:51 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pali.rohar@gmail.com, sre@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi,
        ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com,
        abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl,
        sakari.ailus@linux.intel.com,
        Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Subject: Re: ARM compile failure in Re: linux-next: Tree for Apr 4
Message-ID: <20180404195951.GJ5700@atomide.com>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404074856.GA9342@amd>
 <20180404175852.GI5700@atomide.com>
 <20180404184622.GA8608@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404184622.GA8608@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180404 18:47]:
> Hi!
> 
> > > When trying to build kernel for N900, I get:
> > > 
> > >   CC      lib/timerqueue.o
> > >     CC      lib/vsprintf.o
> > >     lib/string.c: In function 'strstr':
> > >     lib/string.c:478:8: error: inlining failed in call to
> > >     always_inline 'strlen': function not inlinable
> > >     lib/string.c:903:5: error: called from here
> > >     lib/string.c:478:8: error: inlining failed in call to
> > >     always_inline 'strlen': function not inlinable
> > >     lib/string.c:906:5: error: called from here
> > >     lib/string.c:855:15: error: inlining failed in call to
> > >     always_inline 'memcmp': function not inlinable
> > >     ...
> > > pavel@duo:/data/l/linux-next-n900$ git branch -l
> > > * (detached from next-20180403)
> > > 
> > > I'm using
> > > 
> > > eval ` eldk-switch.sh -r 5.4 armv7a`
> > > 
> > > for cross-compilation.
> > 
> > Hmm I'm not seeing build issues with next-20180404, did this somehow
> > already get sorted out?
> 
> It seems it is config-dependend. omap2plus_defconfig compiles ok for
> me.
> 
> Can you try with attached .config?

That still builds for me. This with plain gcc-7.3.0 binutils-2.30
built with buildall script.

Regards,

Tony
