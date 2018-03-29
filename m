Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeC2Ic0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 04:32:26 -0400
Received: from 8bytes.org ([81.169.241.247]:44408 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeC2IcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 04:32:25 -0400
Date: Thu, 29 Mar 2018 10:32:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] iommu/vt-d, trivial: Remove unused variable
Message-ID: <20180329083220.gov323bcknoh7amn@8bytes.org>
References: <1521713886-87177-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521713886-87177-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 06:18:06PM +0800, Shaokun Zhang wrote:
> Unused after commit <42e8c186b595> ("iommu/vt-d: Simplify io/tlb flushing
> in intel_iommu_unmap"), cleanup it.
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/iommu/intel-iommu.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Applied, thanks.
