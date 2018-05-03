Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbeECMw0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:52:26 -0400
Received: from 8bytes.org ([81.169.241.247]:54276 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbeECMwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:52:23 -0400
Date: Thu, 3 May 2018 14:52:20 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Tegra GART fixes and improvements
Message-ID: <20180503125220.er6fnjlas4jtr344@8bytes.org>
References: <cover.1523304324.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1523304324.git.digetx@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 11:07:18PM +0300, Dmitry Osipenko wrote:
> GART driver wasn't ever been utilized in upstream, but finally this should
> change sometime soon with Tegra's DRM driver rework. In general GART driver
> works fine, though there are couple things that could be improved.
> 
> Dmitry Osipenko (4):
>   iommu/tegra: gart: Add debugging facility
>   iommu/tegra: gart: Fix gart_iommu_unmap()

Applied these two patches, thanks.
