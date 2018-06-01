Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753194AbeFAQnn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:43:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeFAQnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:43:40 -0400
Date: Fri, 1 Jun 2018 09:43:37 -0700
From: Darren Hart <dvhart@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haruka Kawajiri <yukx00@gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the drivers-x86
 tree
Message-ID: <20180601164307.GA3505@localhost.localdomain>
References: <20180601213639.74f49e51@canb.auug.org.au>
 <CAHp75VeULdbi3_V8JPffYCocmGtjC3QPdE-yPz5eDrkpONeE-A@mail.gmail.com>
 <20180601220832.73ad5b84@canb.auug.org.au>
 <7EC66A28-4E57-4B3C-A5AC-4D7D9CAF727E@infradead.org>
 <20180602012646.2a0801e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180602012646.2a0801e8@canb.auug.org.au>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 02, 2018 at 01:26:46AM +1000, Stephen Rothwell wrote:
> Hi,
> 
> On Fri, 01 Jun 2018 07:38:42 -0700 dvhart@infradead.org wrote:
> >
> > Stephen, are the tests you use available publicly?
> 
> I use the script below when I am fetching trees.  You don't want the
> "gitk" invocation if you are doing this automatically, of course.  The
> script just takes a commit range.

Thanks for sharing Stephen.
-- 
Darren Hart
VMware Open Source Technology Center
