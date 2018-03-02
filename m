Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428563AbeCBOPS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:15:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:42938 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424338AbeCBOPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:15:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="21557207"
Message-ID: <1520000106.10722.386.camel@linux.intel.com>
Subject: Re: [PATCH v2 8/9] lib/vsprintf: Remove useless NULL checks
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>
Date: Fri, 02 Mar 2018 16:15:06 +0200
In-Reply-To: <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
         <20180216210711.79901-8-andriy.shevchenko@linux.intel.com>
         <20180227155047.o74ohmoyj56up6pa@pathway.suse.cz>
         <1519752950.10722.231.camel@linux.intel.com>
         <20180228100437.o4juwxbzomkqjvjx@pathway.suse.cz>
         <1519814544.10722.266.camel@linux.intel.com>
         <20180302125118.bjd3tbuu72vgfczo@pathway.suse.cz>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-02 at 13:51 +0100, Petr Mladek wrote:

> BTW: I am not sure who is going to pass this patchset to Linus.
> If nobody is against, I could eventually do so via printk.git.

Usually Andrew Morton takes care.
But perhaps it's a time to unload Andrew in this part at least?

Would you agree to be a maintainer of lib/vsprinf.c and
lib/test_printf.c ?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
