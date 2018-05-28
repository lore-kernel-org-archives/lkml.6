Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753365AbeE1GKu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:10:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36393 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbeE1GKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:10:47 -0400
Date: Mon, 28 May 2018 08:10:40 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 7/7] x86: switch the VIA 32-bit DMA quirk to use the
 struct device flag
In-Reply-To: <20180525143512.1466-8-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1805280808280.1585@nanos.tec.linutronix.de>
References: <20180525143512.1466-1-hch@lst.de> <20180525143512.1466-8-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n Fri, 25 May 2018, Christoph Hellwig wrote:

x86/pci-dma: ...

Please

> Instead of globally disabling > 32bit DMA using the arch_dma_supported
> hook walk the PCI bus under the actually affected bridge and mark every
> device with the dma_32bit_limit flag.  This also gets rid of the
> arch_dma_supported hook entirely.

Shouldn't this go before the other two? 
 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
