Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbeEOOfV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:35:21 -0400
Received: from 8bytes.org ([81.169.241.247]:50726 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753174AbeEOOfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:35:20 -0400
Date: Tue, 15 May 2018 16:35:18 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] iommu/vt-d: Several cleanup patches
Message-ID: <20180515143517.dyabef7n2xnmecaa@8bytes.org>
References: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 01:08:15PM +0800, Lu Baolu wrote:
> Lu Baolu (4):
>   iommu: Clean up the comments for iommu_group_alloc
>   iommu/vt-d: Clean up unused variable in find_or_alloc_domain
>   iommu/vt-d: Clean up pasid quirk for pre-production devices
>   iommu/vt-d: Remove unnecessary parentheses
> 
>  drivers/iommu/intel-iommu.c | 36 +++---------------------------------
>  drivers/iommu/intel-svm.c   |  2 +-
>  drivers/iommu/iommu.c       |  1 -
>  include/linux/intel-iommu.h |  1 -
>  4 files changed, 4 insertions(+), 36 deletions(-)

Applied, thanks.
