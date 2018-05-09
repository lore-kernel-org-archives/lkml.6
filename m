Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934390AbeEIJKV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:10:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58855 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S934195AbeEIJKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:10:20 -0400
Subject: Re: [PATCH] swiotlb: Update the comment of swiotlb
To: Christoph Hellwig <hch@lst.de>
References: <1525691185-55657-1-git-send-email-xieyisheng1@huawei.com>
 <20180509073838.GA20874@lst.de>
CC: <konrad.wilk@oracle.com>, <mingo@kernel.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <b6246d95-7d9c-2904-6298-9c5ca3506a5f@huawei.com>
Date: Wed, 9 May 2018 17:08:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20180509073838.GA20874@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2018/5/9 15:38, Christoph Hellwig wrote:
> Thanks,
> 
> applied to the dma-mapping tree.

Thanks

BTW, should lib/swiotlb.c also add to DMA MAPPING HELPERS, or
add yourself as a maintainer of SWIOTLB SUBSYSTEM ? It will make
get_maintainer.pl get you :)

Thanks
Yisheng
> 
> .
> 
