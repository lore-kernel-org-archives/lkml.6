Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6976CC282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F7F21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfAWHTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:19:35 -0500
Received: from verein.lst.de ([213.95.11.211]:40975 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfAWHTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:19:35 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 649D36FA7F; Wed, 23 Jan 2019 08:19:33 +0100 (CET)
Date:   Wed, 23 Jan 2019 08:19:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: linux-next: Fixes tags need some work in the dma-mapping-fixes
 tree
Message-ID: <20190123071933.GA24861@lst.de>
References: <20190123074747.7cd44f12@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123074747.7cd44f12@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 07:47:47AM +1100, Stephen Rothwell wrote:
> Hi Christoph,
> 
> In commit
> 
>   702e8ed37bed ("arm64/xen: fix xen-swiotlb cache flushing")
> 
> Fixes tag
> 
>   Fixes: 356da6d0cd ("dma-mapping: bypass indirect calls for dma-direct")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long

When did we decide on that?  As far as I know it was bumped to 10
a while ago.  12 basically makes the line even more unreadable.

> In commit
> 
>   8218a55b6b91 ("sbitmap: Protect swap_lock from hardirq")
> 
> Fixes tag
> 
>   Fixes: ab53dcfb3e7b ("sbitmap: Protect swap_lock from hardirq")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> This later patch appears to already be in Linus' tree as commit
> fe76fc6aaf53 (also with an incorrect Fixes tag :-()

That commit is not from the dma-mapping tree..
