Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754555AbeDTKFa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:05:30 -0400
Received: from verein.lst.de ([213.95.11.211]:41286 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754519AbeDTKF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:05:29 -0400
Date: Fri, 20 Apr 2018 12:06:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] dma-direct: Try reallocation with GFP_DMA32 if
        possible
Message-ID: <20180420100625.GA6728@lst.de>
References: <20180416151819.27520-1-tiwai@suse.de> <20180420094702.GA6530@lst.de> <s5hfu3qw659.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hfu3qw659.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 11:58:58AM +0200, Takashi Iwai wrote:
> It's because it's written on the tree with another fix patch I sent
> beforehand ("[PATCH 1/2] dma-direct: Don't repeat allocation for no-op
> GFP_DMA").
> 
> Could you check that one at first?  I'm fine to rebase and resubmit
> this one, if still preferred, though.

That one looks fine, too.  I'll add it to my patch queue.
