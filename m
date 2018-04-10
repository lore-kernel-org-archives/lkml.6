Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeDJLmA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 07:42:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:22532 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752172AbeDJLl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 07:41:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,431,1517904000";
   d="scan'208";a="219225770"
Message-ID: <1523360515.21176.434.camel@linux.intel.com>
Subject: Re: [PATCH v4 4/9] vsprintf: Consolidate handling of unknown
 pointer specifiers
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2018 14:41:55 +0300
In-Reply-To: <20180409135028.ymyvsqxup7zm5vgc@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-5-pmladek@suse.com>
         <1523111200.21176.416.camel@linux.intel.com>
         <20180409135028.ymyvsqxup7zm5vgc@pathway.suse.cz>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-09 at 15:50 +0200, Petr Mladek wrote:
> On Sat 2018-04-07 17:26:40, Andy Shevchenko wrote:
> > On Wed, 2018-04-04 at 10:58 +0200, Petr Mladek wrote:

> > This change collides with my patch series. Can you elaborate what
> > your
> > thoughts are about my patches? Are you going incorporate them to
> > your
> > series? Should I send them independently?
> 
> Good question. I think that the best solution will be that I go
> over your patchset and just add all valid ones into printk.git
> for-4.18.

I think about 1-7 and 9 that can go as is before your changes.
And patch 8 postpone

>  Then I will base v5 of this patchset on top of it.

I'm going for vacation tomorrow. Can you just take them into your series
or apply to your tree?

> I should have done this earlier. But I did not expect that long
> way for the access-check stuff. We originally planned to
> do the access check first, see
> https://lkml.kernel.org/r/1520000254.10722.389.camel@linux.intel.com

Yeah, I didn't consider that your one patch became a series...

> But the access check patchset still need some love, so it makes
> sense to switch the order.

I agree.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
