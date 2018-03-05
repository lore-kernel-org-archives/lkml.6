Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeCEO5J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:57:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:59078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751311AbeCEO5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:57:06 -0500
Date: Mon, 5 Mar 2018 15:57:05 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2 8/9] lib/vsprintf: Remove useless NULL checks
Message-ID: <20180305145704.un2ncgflrmc7zzm2@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
 <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
 <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
 <1519752950.10722.231.camel@linux.intel.com>
 <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
 <1519814544.10722.266.camel@linux.intel.com>
 <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
 <1520000106.10722.386.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520000106.10722.386.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-03-02 16:15:06, Andy Shevchenko wrote:
> On Fri, 2018-03-02 at 13:51 +0100, Petr Mladek wrote:
> 
> > BTW: I am not sure who is going to pass this patchset to Linus.
> > If nobody is against, I could eventually do so via printk.git.
> 
> Usually Andrew Morton takes care.
> But perhaps it's a time to unload Andrew in this part at least?

I think that Andrew took these patches as the last resort.

> Would you agree to be a maintainer of lib/vsprinf.c and
> lib/test_printf.c ?

If nobody is against, I could do so.

Best Regards,
Petr
