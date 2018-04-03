Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755252AbeDCJPx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:15:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:38437 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753292AbeDCJPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:15:52 -0400
Date: Tue, 3 Apr 2018 11:15:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, pantelis.antoniou@konsulko.com,
        mark.rutland@arm.com, joe@perches.com, corbet@lwn.net, me@tobin.cc,
        sergey.senozhatsky@gmail.com
Subject: Re: [PATCH 1/2] lib: vsprintf: Implement %pCOW
Message-ID: <20180403091549.abksetlxs3mqropt@pathway.suse.cz>
References: <20180401085622.7754-1-richard@nod.at>
 <20180401085622.7754-2-richard@nod.at>
 <1522678692.21176.179.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522678692.21176.179.camel@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-04-02 17:18:12, Andy Shevchenko wrote:
> On Sun, 2018-04-01 at 10:56 +0200, Richard Weinberger wrote:
> > Add a new format string to print in cowsay format.
> > 
> 
> Apparently NAK b/c missed test cases!

This is really sad. I'll miss the cows.

Moo,
Petr
