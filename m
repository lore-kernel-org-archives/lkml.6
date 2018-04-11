Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeDKJwW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:52:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:34853 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbeDKJwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:52:21 -0400
Date: Wed, 11 Apr 2018 11:52:18 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown pointer
 specifiers
Message-ID: <20180411095218.zth5edjth2cxrrwc@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
 <20180404085843.16050-5-pmladek@suse.com>
 <1523111200.21176.416.camel@linux.intel.com>
 <20180409135028.ymyvsqxup7zm5vgc@pathway.suse.cz>
 <1523360515.21176.434.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523360515.21176.434.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-04-10 14:41:55, Andy Shevchenko wrote:
> On Mon, 2018-04-09 at 15:50 +0200, Petr Mladek wrote:
> > On Sat 2018-04-07 17:26:40, Andy Shevchenko wrote:
> > > On Wed, 2018-04-04 at 10:58 +0200, Petr Mladek wrote:
> 
> > > This change collides with my patch series. Can you elaborate what
> > > your
> > > thoughts are about my patches? Are you going incorporate them to
> > > your
> > > series? Should I send them independently?
> > 
> > Good question. I think that the best solution will be that I go
> > over your patchset and just add all valid ones into printk.git
> > for-4.18.
> 
> I think about 1-7 and 9 that can go as is before your changes.
> And patch 8 postpone

Done. All the 8 patches are in printk.git, branch
for-4.18-vsprintf-cleanup.

I am sorry that we have missed 4.17. In theory, it still might be
possible to push them there. But there does not seem to be a real
reason to rush them.

> >  Then I will base v5 of this patchset on top of it.
> 
> I'm going for vacation tomorrow. Can you just take them into your series
> or apply to your tree?

Good to know.

Enjoy vacation,
Petr
