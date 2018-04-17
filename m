Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753597AbeDQOrA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:47:00 -0400
Received: from verein.lst.de ([213.95.11.211]:53470 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbeDQOq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:46:59 -0400
Date: Tue, 17 Apr 2018 16:47:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        iommu@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: remove pci-nommu.c
Message-ID: <20180417144732.GA17571@lst.de>
References: <20180416124442.13831-1-hch@lst.de> <alpine.DEB.2.21.1804171112190.1694@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804171112190.1694@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 11:13:14AM +0200, Thomas Gleixner wrote:
> On Mon, 16 Apr 2018, Christoph Hellwig wrote:
> 
> > The commit that switches x86 to dma_direct_ops stopped using and building
> > this file, but accidentally left it in the tree.  Remove it.
> 
> There is also stale documentation in
> 
>       Documentation/x86/x86_64/boot-options.txt
> 
> which mentiones that file. Could you please have a look and update that as
> well?

Sure, will do.  From a quick looks it has been out of date for a long
time.

> 
> Thanks,
> 
> 	tglx
---end quoted text---
