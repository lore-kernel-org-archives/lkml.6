Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbeECNQw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:16:52 -0400
Received: from 8bytes.org ([81.169.241.247]:54522 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750922AbeECNQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:16:49 -0400
Date: Thu, 3 May 2018 15:16:48 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: alex.williamson@redhat.com, eric.auger@redhat.com,
        pmorel@linux.vnet.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, john.garry@huawei.com, xuwei5@hisilicon.com
Subject: Re: [PATCH v6 4/7] iommu/dma: Move PCI window region reservation
 back into dma specific path.
Message-ID: <20180503131648.GX15462@8bytes.org>
References: <20180418114045.7968-1-shameerali.kolothum.thodi@huawei.com>
 <20180418114045.7968-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418114045.7968-5-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 12:40:42PM +0100, Shameer Kolothum wrote:
> This pretty much reverts commit 273df9635385 ("iommu/dma: Make PCI
> window reservation generic")  by moving the PCI window region
> reservation back into the dma specific path so that these regions
> doesn't get exposed via the IOMMU API interface. With this change,
> the vfio interface will report only iommu specific reserved regions
> to the user space.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 54 ++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)

Applied to my iommu/fixes branch.

Thanks,

	Joerg
