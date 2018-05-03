Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeECNTG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:19:06 -0400
Received: from 8bytes.org ([81.169.241.247]:54552 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbeECNTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:19:04 -0400
Date: Thu, 3 May 2018 15:19:02 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 24/61] iommu: simplify getting .drvdata
Message-ID: <20180503131901.c5vm4w3mskcnef4s@8bytes.org>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-25-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419140641.27926-25-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:05:54PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/iommu/qcom_iommu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.
