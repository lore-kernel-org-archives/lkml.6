Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755400AbeDZLAz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:00:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754805AbeDZLAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:00:51 -0400
Date: Thu, 26 Apr 2018 04:00:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: Matthew Wilcox <willy@infradead.org>, dsterba@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-m68k@vger.kernel.org
Subject: Re: moving affs + RDB partition support to staging? (was: Re: Moving
 unmaintained filesystems to staging)
Message-ID: <20180426110048.GA398@infradead.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org>
 <1613268.lKBQxPXt8J@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613268.lKBQxPXt8J@merkaba>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 12:28:40PM +0200, Martin Steigerwald wrote:
> Added in linux-m68k mailing list, as they likely have an opinion on how 
> to treat affs + RDB partition support. Also added in Jens Axboe about 
> patching that RDB support broken with 2 TB or larger harddisks issue 
> which had been in Linux kernel for 6 years while a patch exists that to 
> my testing back then solves the issue.

Jens can't do much unless you actually sent said patch to the
linux-block list.
