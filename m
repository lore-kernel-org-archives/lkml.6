Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeEBMla (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:41:30 -0400
Received: from verein.lst.de ([213.95.11.211]:39019 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbeEBMl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:41:29 -0400
Date: Wed, 2 May 2018 14:44:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Mike Galbraith <efault@gmx.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swiotlb: Suppress "Out of SW-IOMMU" errors for NO_WARN
Message-ID: <20180502124402.GC22857@lst.de>
References: <20180502100501.28440-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502100501.28440-1-chris@chris-wilson.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 11:05:01AM +0100, Chris Wilson wrote:
> This extends the warning suppression from commit d0bc0c2a31c9 ("swiotlb:
> suppress warning when __GFP_NOWARN is set") to suppress the warnings
> when DMA_ATTR_NO_WARN is given by caller. In such cases the caller wants
> to handle the error themselves.

I have patches that remove swiotlb_full entirely to be posted soon.
I'll defer the patch for now.
