Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932377AbeCOOzO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:55:14 -0400
Received: from 8bytes.org ([81.169.241.247]:44446 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752244AbeCOOzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:55:13 -0400
Date: Thu, 15 Mar 2018 15:55:11 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/omap: Increase group ref in .device_group()
Message-ID: <20180315145511.2avsuncglw7yviyh@8bytes.org>
References: <20180301112208.25284-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301112208.25284-1-jeffy.chen@rock-chips.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 07:22:08PM +0800, Jeffy Chen wrote:
> Increase group refcounting in omap_iommu_device_group().
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Applied, thanks.
