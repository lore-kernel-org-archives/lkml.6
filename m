Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936296AbeEYOuc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936200AbeEYOua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:50:30 -0400
Date: Fri, 25 May 2018 16:50:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 1/7] core, dma-direct: add a flag 32-bit dma limits
Message-ID: <20180525145012.GA3863@kroah.com>
References: <20180525143512.1466-1-hch@lst.de>
 <20180525143512.1466-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525143512.1466-2-hch@lst.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 04:35:06PM +0200, Christoph Hellwig wrote:
> Various PCI bridges (VIA PCI, Xilinx PCIe) limit DMA to only 32-bits
> even if the device itself supports more.  Add a single bit flag to
> struct device (to be moved into the dma extension once we around it)

"once we around it"?  I don't understand, sorry.

> to flag such devices and reject larger DMA to them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/device.h | 3 +++
>  lib/dma-direct.c       | 6 ++++++
>  2 files changed, 9 insertions(+)

For the patch, no objection from me:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
