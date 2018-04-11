Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeDKJqg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:46:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:34344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbeDKJqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:46:35 -0400
Date: Wed, 11 Apr 2018 11:46:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Tobin C . Harding" <me@tobin.cc>, linux@rasmusvillemoes.dk,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 6/9] lib/vsprintf: Deduplicate pointer_string()
Message-ID: <20180411094633.be4ssir2t24l4fdq@pathway.suse.cz>
References: <20180216210711.79901-1-andriy.shevchenko@linux.intel.com>
 <20180216210711.79901-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216210711.79901-6-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-02-16 23:07:08, Andy Shevchenko wrote:
> There is an exact code at the end of ptr_to_id().
> Replace it by calling pointer_string() directly.
> 
> This is followup to the commit
>   ad67b74d2469 ("printk: hash addresses printed with %p").
> 
> Cc: Tobin C. Harding <me@tobin.cc>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

I have pushed it into printk.git, branch for-4.18-vsprintf-cleanup.

Best Regards,
Petr
