Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbeDXQrJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:47:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:1502 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751513AbeDXQrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:47:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="53290221"
Message-ID: <1524588420.21176.505.camel@linux.intel.com>
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
Date: Tue, 24 Apr 2018 19:47:00 +0300
In-Reply-To: <20180411095218.zth5edjth2cxrrwc@pathway.suse.cz>
References: <20180404085843.16050-1-pmladek@suse.com>
         <20180404085843.16050-5-pmladek@suse.com>
         <1523111200.21176.416.camel@linux.intel.com>
         <20180409135028.ymyvsqxup7zm5vgc@pathway.suse.cz>
         <1523360515.21176.434.camel@linux.intel.com>
         <20180411095218.zth5edjth2cxrrwc@pathway.suse.cz>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-11 at 11:52 +0200, Petr Mladek wrote:
> On Tue 2018-04-10 14:41:55, Andy Shevchenko wrote:
> > On Mon, 2018-04-09 at 15:50 +0200, Petr Mladek wrote:
> > > On Sat 2018-04-07 17:26:40, Andy Shevchenko wrote:

> > I think about 1-7 and 9 that can go as is before your changes.
> > And patch 8 postpone
> 
> Done. All the 8 patches are in printk.git, branch
> for-4.18-vsprintf-cleanup.

Thanks!

> I am sorry that we have missed 4.17. In theory, it still might be
> possible to push them there. But there does not seem to be a real
> reason to rush them.

Agree.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
