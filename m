Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeCOPaV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:30:21 -0400
Received: from 8bytes.org ([81.169.241.247]:46820 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752018AbeCOPaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:30:20 -0400
Date: Thu, 15 Mar 2018 16:30:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/14] iommu/amd_iommu: use dma_direct_{alloc,free}
Message-ID: <20180315153018.GB11365@8bytes.org>
References: <20180314175213.20256-1-hch@lst.de>
 <20180314175213.20256-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314175213.20256-8-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 06:52:06PM +0100, Christoph Hellwig wrote:
> This cleans up the code a lot by removing duplicate logic.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/iommu/Kconfig     |  1 +
>  drivers/iommu/amd_iommu.c | 68 +++++++++++++++--------------------------------
>  2 files changed, 22 insertions(+), 47 deletions(-)

Tested-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
