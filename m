Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeECNbu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:31:50 -0400
Received: from 8bytes.org ([81.169.241.247]:54676 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbeECNbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:31:47 -0400
Date: Thu, 3 May 2018 15:31:45 +0200
From: Joerg Roedel <joro@8bytes.org>
To: YueHaibing <yuehaibing@huawei.com>
Cc: will.deacon@arm.com, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/io-pgtable-arm: Use for_each_set_bit to simplify
 code
Message-ID: <20180503133145.z6rpl3qd64tgfpm6@8bytes.org>
References: <20180426044929.16896-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426044929.16896-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 12:49:29PM +0800, YueHaibing wrote:
> We can use for_each_set_bit() to simplify code slightly in the
> ARM io-pgtable self tests while unmapping.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 5 +----
>  drivers/iommu/io-pgtable-arm.c     | 5 +----
>  2 files changed, 2 insertions(+), 8 deletions(-)

Applied, thanks.
