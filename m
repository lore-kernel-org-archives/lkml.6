Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeCOOMN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:12:13 -0400
Received: from 8bytes.org ([81.169.241.247]:42772 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751535AbeCOOMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:12:12 -0400
Date: Thu, 15 Mar 2018 15:12:10 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/rockchip: Perform a reset on shutdown
Message-ID: <20180315141210.yb6c6tbzietiuty3@8bytes.org>
References: <20180220202504.19275-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220202504.19275-1-marc.zyngier@arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 08:25:04PM +0000, Marc Zyngier wrote:
> Trying to do a kexec whilst the iommus are still on is proving to be
> a challenging exercise. It is terribly unsafe, as we're reusing the
> memory allocated for the page tables, leading to a likely crash.
> 
> Let's implement a shutdown method that will at least try to stop
> DMA from going crazy behind our back. Note that we need to be
> extra cautious when doing so, as the IOMMU may not be clocked
> if controlled by a another master, as typical on Rockchip system.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Applied, thanks.
