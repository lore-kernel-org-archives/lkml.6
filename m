Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934304AbeEILg2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:36:28 -0400
Received: from verein.lst.de ([213.95.11.211]:42780 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933832AbeEILg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:36:27 -0400
Date: Wed, 9 May 2018 13:39:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, konrad.wilk@oracle.com,
        mingo@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: Update the comment of swiotlb
Message-ID: <20180509113957.GA25787@lst.de>
References: <1525691185-55657-1-git-send-email-xieyisheng1@huawei.com> <20180509073838.GA20874@lst.de> <b6246d95-7d9c-2904-6298-9c5ca3506a5f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6246d95-7d9c-2904-6298-9c5ca3506a5f@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 05:08:30PM +0800, Yisheng Xie wrote:
> Hi Christoph,
> 
> On 2018/5/9 15:38, Christoph Hellwig wrote:
> > Thanks,
> > 
> > applied to the dma-mapping tree.
> 
> Thanks
> 
> BTW, should lib/swiotlb.c also add to DMA MAPPING HELPERS, or
> add yourself as a maintainer of SWIOTLB SUBSYSTEM ? It will make
> get_maintainer.pl get you :)

Konrad is the maintainer, but due to me touching the file a lot
lately I keep merging the patches for now.  But anything non-trivial
absolutely requires an Ack from Konrad.
