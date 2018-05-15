Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbeEOOcL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:32:11 -0400
Received: from 8bytes.org ([81.169.241.247]:50496 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752725AbeEOOcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:32:10 -0400
Date: Tue, 15 May 2018 16:32:08 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Peter Xu <peterx@redhat.com>
Cc: Linux IOMMU Mailing List <iommu@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jintack Lim <jintack@cs.columbia.edu>,
        Alexander Witte <alexander.witte@baicanada.com>
Subject: Re: [PATCH v3 0/2] iommu/vt-d: Fix mapping PSI missing for
 iommu_map()
Message-ID: <20180515143208.2z3xgge3jifyhzep@8bytes.org>
References: <20180504023453.25682-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504023453.25682-1-peterx@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 10:34:51AM +0800, Peter Xu wrote:
> Peter Xu (2):
>   iommu/vt-d: Introduce __mapping_notify_one()
>   iommu/vt-d: Fix iotlb psi missing for mappings
> 
>  drivers/iommu/intel-iommu.c | 65 ++++++++++++++++++++++++++-----------
>  1 file changed, 46 insertions(+), 19 deletions(-)

Applied, thanks.
