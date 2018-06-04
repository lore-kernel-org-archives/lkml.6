Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753966AbeFDHJd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:09:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752352AbeFDHJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:09:30 -0400
Date: Mon, 4 Jun 2018 00:09:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Dilger <adilger@dilger.ca>,
        Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        James Simmons <jsimmons@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        lustre-devel <lustre-devel@lists.lustre.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] staging: lustre: delete the filesystem from the tree.
Message-ID: <20180604070922.GA13156@infradead.org>
References: <20180601091133.GA27521@kroah.com>
 <6A5E4E02-AE72-4068-BF93-38791BF38B4F@dilger.ca>
 <20180601190839.GA20734@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601190839.GA20734@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 09:08:39PM +0200, Greg Kroah-Hartman wrote:
> Please, compare yourself to orangefs.  That is the perfect example of
> how to do everything right.  They got their code into staging, cleaned
> it up, talked to us about what was needed to do to get the remaining
> bits in proper shape, they assigned dedicated developers to do that
> work, talked with all of us at different conferences around the world to
> check up and constantly ensure that they were doing the right thing, and
> most importantly, they asked for feedback and acted on it.  In the end,
> their codebase is much smaller, works better, is in the "real" part of
> the kernel, and available to every Linux user out there.

FYI, orangefs never went through the statging tree.  Which might be
one reason why it got merged so quickly - allowing rapid iteration
without respect to merged windows, and doing all the trivial cleanups
either before or after (but not at the same time as) the feature
work really does help productivity.
