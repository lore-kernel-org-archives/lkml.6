Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeC2Iiq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 04:38:46 -0400
Received: from 8bytes.org ([81.169.241.247]:44720 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeC2Iip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 04:38:45 -0400
Date: Thu, 29 Mar 2018 10:38:42 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Scott Wood <swood@redhat.com>
Subject: Re: [PATCH 00/10 v3] iommu/amd: lock splitting & GFP_KERNEL
 allocation
Message-ID: <20180329083842.ik7rxmfajhj5x3sq@8bytes.org>
References: <20180322152242.12705-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322152242.12705-1-bigeasy@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 04:22:32PM +0100, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> this is the rebase on top of iommu/x86/amd of my last series. It takes
> Scotts comments into consideration from my v2.
> 
> It contains lock splitting and GFP_KERNEL allocation of remap-table.
> Mostly cleanup.
> 
> The patches were boot tested on an AMD EPYC 7601.

Applied, thanks.
