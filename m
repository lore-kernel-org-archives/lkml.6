Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965567AbeBMSde (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:33:34 -0500
Received: from 8bytes.org ([81.169.241.247]:43086 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965544AbeBMSdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:33:32 -0500
Date: Tue, 13 Feb 2018 19:33:30 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: will.deacon@arm.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/io-pgtable: use size_t return type for all
 foo_unmap
Message-ID: <20180213183330.6su6gc3uctpvaa2e@8bytes.org>
References: <1517853559-5869-1-git-send-email-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517853559-5869-1-git-send-email-vivek.gautam@codeaurora.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 11:29:19PM +0530, Vivek Gautam wrote:
> Unmap returns a size_t all throughout the IOMMU framework.
> Make io-pgtable match this convention.
> Moreover, there isn't a need to have a signed int return type
> as we return 0 in case of failures.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 21 +++++++++++----------
>  drivers/iommu/io-pgtable-arm.c     | 24 ++++++++++++------------
>  drivers/iommu/io-pgtable.h         |  4 ++--
>  3 files changed, 25 insertions(+), 24 deletions(-)

Applied, thanks.
