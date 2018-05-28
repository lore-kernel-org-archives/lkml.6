Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeE1IfD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:35:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36939 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753995AbeE1Ie6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:34:58 -0400
Date: Mon, 28 May 2018 10:34:49 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 7/7] x86: switch the VIA 32-bit DMA quirk to use the
 struct device flag
In-Reply-To: <20180528083931.GA7169@lst.de>
Message-ID: <alpine.DEB.2.21.1805281034150.1578@nanos.tec.linutronix.de>
References: <20180525143512.1466-1-hch@lst.de> <20180525143512.1466-8-hch@lst.de> <alpine.DEB.2.21.1805280808280.1585@nanos.tec.linutronix.de> <20180528061859.GA4145@lst.de> <alpine.DEB.2.21.1805280817310.1585@nanos.tec.linutronix.de> <20180528062725.GA4309@lst.de>
 <alpine.DEB.2.21.1805280823240.1585@nanos.tec.linutronix.de> <20180528083931.GA7169@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018, Christoph Hellwig wrote:
> On Mon, May 28, 2018 at 08:23:35AM +0200, Thomas Gleixner wrote:
> > > > They remove the commandline switch before having the replacement in place
> > > > unless I'm misreading something.
> > > 
> > > The command line switch to force 32-bit dma is removed without
> > > replacement.   The PCI quirk for force the 32-bit dma for VIA bridges
> > > is kept in place, and switch to a different mechanism in this patch.
> > 
> > Fair enough
> 
> Thanks.  Do you want me to repost them for the x86 tree, or should
> just pull the changes with the commit logs fixed to the dma-mapping
> tree?

Just take them through your tree. There is nothing conflicting in tip.

Thanks,

	tglx
