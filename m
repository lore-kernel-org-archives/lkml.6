Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeFEA7J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 20:59:09 -0400
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:55574 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751099AbeFEA7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 20:59:07 -0400
Date: Tue, 5 Jun 2018 10:59:04 +1000
From: Dave Chinner <david@fromorbit.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, linux-xfs@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the xfs tree with Linus' tree
Message-ID: <20180605005904.GY10363@dastard>
References: <20180605103403.3e5b2c91@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605103403.3e5b2c91@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:34:03AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the xfs tree got a conflict in:
> 
>   fs/gfs2/bmap.c
> 
> between commit:
> 
>   628e366df11c ("gfs2: Iomap cleanups and improvements")
> 
> from Linus' tree and commit:
> 
>   7ee66c03e40a ("iomap: move IOMAP_F_BOUNDARY to gfs2")
> 
> from the xfs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

We should have seen this before the gfs2 tree was merged into Linus'
tree. Does that mean the gfs2 tree is not being pulled into the
linux-next tree?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
