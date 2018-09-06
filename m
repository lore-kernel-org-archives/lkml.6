Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6548C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE812075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8SaNRV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE812075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbeIFXyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729596AbeIFXyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:54:14 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 489CD20659;
        Thu,  6 Sep 2018 19:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536261441;
        bh=s246hBWVViLp2pZubkwn3QqragUyekWpVNK7CJmW8Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8SaNRV32OH1qJiwGbuausCnvdDI/mL0sn60j30PcVDYfToPuUq4BOmCABgQGwX0B
         FwS+M18CLMJgRrC49Ss48WpCbp/hif3uC2Nwavr7nwzB94zEB8PPZ7HgxqKHTskefE
         0GzCDZ9UG8Gs/66fDG8alOblpUcpPVE/9bWYgJSQ=
Date:   Thu, 6 Sep 2018 14:17:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add maintainer entries for RPA pci hotplug
 drivers
Message-ID: <20180906191720.GG214747@bhelgaas-glaptop.roam.corp.google.com>
References: <1534814431-20112-1-git-send-email-tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534814431-20112-1-git-send-email-tyreld@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 06:20:31PM -0700, Tyrel Datwyler wrote:
> Adding myself as maintiner of the IBM RPA hotplug modules located in
> drivers/pci/hotplug directory. These modules provide kernel interfaces
> for support of Dynamic Logical Partitioning (DLPAR) of Logical and
> Physical IO slots, and hotplug of physical PCI slots of a PHB on
> RPA-compliant ppc64 platforms (pseries).
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Applied to for-linus for v4.19, thanks!

> ---
>  MAINTAINERS | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5df1b36..7b5dc3f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6984,6 +6984,20 @@ F:	drivers/crypto/vmx/aes*
>  F:	drivers/crypto/vmx/ghash*
>  F:	drivers/crypto/vmx/ppc-xlate.pl
>  
> +IBM Power PCI Hotplug Driver for RPA-compliant PPC64 platform
> +M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> +L:	linux-pci@vger.kernel.org
> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Supported
> +F:	drivers/pci/hotplug/rpaphp*
> +
> +IBM Power IO DLPAR Driver for RPA-compliant PPC64 platform
> +M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> +L:	linux-pci@vger.kernel.org
> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Supported
> +F:	drivers/pci/hotplug/rpadlpar*
> +
>  IBM ServeRAID RAID DRIVER
>  S:	Orphan
>  F:	drivers/scsi/ips.*
> -- 
> 1.8.3.1
> 
