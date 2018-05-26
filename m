Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032391AbeEZTXV (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 15:23:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60216 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032357AbeEZTXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 15:23:19 -0400
Date: Sat, 26 May 2018 21:23:08 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 4/7] x86: remove a stray reference to pci-nommu.c
In-Reply-To: <20180525143512.1466-5-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1805262120210.1585@nanos.tec.linutronix.de>
References: <20180525143512.1466-1-hch@lst.de> <20180525143512.1466-5-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018, Christoph Hellwig wrote:

Subject should be: Documentation/x86: Remove .....

please

> This is just the minimal workaround.  The file file is mostly either stale

file file?

> and/or duplicative of Documentation/admin-guide/kernel-parameters.txt,
> but that is much more work than I'm willing to do right now.

Yeah, this thing is on the todo list ...

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Other than the above nits:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  Documentation/x86/x86_64/boot-options.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/x86/x86_64/boot-options.txt b/Documentation/x86/x86_64/boot-options.txt
> index b297c48389b9..153b3a57fba2 100644
> --- a/Documentation/x86/x86_64/boot-options.txt
> +++ b/Documentation/x86/x86_64/boot-options.txt
> @@ -187,9 +187,9 @@ PCI
>  
>  IOMMU (input/output memory management unit)
>  
> - Currently four x86-64 PCI-DMA mapping implementations exist:
> + Multiple x86-64 PCI-DMA mapping implementations exist, for example:
>  
> -   1. <arch/x86_64/kernel/pci-nommu.c>: use no hardware/software IOMMU at all
> +   1. <lib/dma-direct.c>: use no hardware/software IOMMU at all
>        (e.g. because you have < 3 GB memory).
>        Kernel boot message: "PCI-DMA: Disabling IOMMU"
>  
> -- 
> 2.17.0
> 
> 
