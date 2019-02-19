Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C076CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9007B206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfBSREn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:04:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47658 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBSREm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:04:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9922BEBD;
        Tue, 19 Feb 2019 09:04:42 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FB1D3F690;
        Tue, 19 Feb 2019 09:04:41 -0800 (PST)
Date:   Tue, 19 Feb 2019 17:04:37 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Tom Joseph <tjoseph@cadence.com>
Cc:     mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: pci/cadence: Updating maintainer
 information.  Removing Alan and adding myself(tjoseph@cadence.com) as the
 maintainer.
Message-ID: <20190219170437.GC21833@e107981-ln.cambridge.arm.com>
References: <1550592294-1768-1-git-send-email-tjoseph@cadence.com>
 <1550592294-1768-2-git-send-email-tjoseph@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550592294-1768-2-git-send-email-tjoseph@cadence.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

the $SUBJECT should be reformatted, please read:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Also, while using get_maintainer.pl to derive a sane CC list is good,
it has to be used with some common sense, it is not really needed for
this patch.

There is no need for a cover-letter either it is a trivial patch (but
it must still be properly formatted - see above - and a commit log).

I will update my patch:

https://patchwork.ozlabs.org/patch/1041327/

with your entry, resend it to linux-pci@vger.kernel.org and merge it.

Please keep in mind that PCI patches must always be copied/to to
linux-pci@vger.kernel.org otherwise Bjorn and I won't be able
to apply them.

Thanks,
Lorenzo

On Tue, Feb 19, 2019 at 04:04:54PM +0000, Tom Joseph wrote:
> Signed-off-by: Tom Joseph <tjoseph@cadence.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41ce5f4..7938e3f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11592,7 +11592,7 @@ F:	Documentation/devicetree/bindings/pci/pci-armada8k.txt
>  F:	drivers/pci/controller/dwc/pcie-armada8k.c
>  
>  PCI DRIVER FOR CADENCE PCIE IP
> -M:	Alan Douglas <adouglas@cadence.com>
> +M:	Tom Joseph <tjoseph@cadence.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/cdns,*.txt
> -- 
> 2.2.2
> 
