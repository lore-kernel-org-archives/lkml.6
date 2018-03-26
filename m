Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeCZTxj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 15:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbeCZTxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 15:53:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804E521773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Mon, 26 Mar 2018 14:53:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: linux-next: build failure after merge of the pci tree
Message-ID: <20180326195336.GB224629@bhelgaas-glaptop.roam.corp.google.com>
References: <20180326123143.38630ea3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326123143.38630ea3@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 12:31:43PM +1100, Stephen Rothwell wrote:
> Hi Bjorn,
> 
> After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> In file included from /home/sfr/next/next/drivers/pci/host/pcie-iproc.c:16:0:  
> /home/sfr/next/next/include/linux/irqchip/arm-gic-v3.h:560:10: fatal error: asm/arch_gicv3.h: No such file or directory
>  #include <asm/arch_gicv3.h>
>           ^~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   af3c73473d10 ("PCI: Improve host drivers compile test coverage")
> 
> I used the pci tree from next-20180323 for today.

Thanks, I updated my tree to drop af3c73473d10 ("PCI: Improve host
drivers compile test coverage") for now.

I know Lorenzo is out this week, so he may not be able to do an
update, but if you post a new version, Rob, I'll see if I can pull it
in.

Bjorn
