Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11F6C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9082025D02
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9082025D02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966373AbeF0WVE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:21:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39176 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965806AbeF0WVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:21:03 -0400
Received: from localhost (113x41x139x141.ap113.ftth.ucom.ne.jp [113.41.139.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 16ECECAC;
        Wed, 27 Jun 2018 22:21:01 +0000 (UTC)
Date:   Thu, 28 Jun 2018 06:20:58 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guy Chronister <guylovesbritt@gmail.com>
Cc:     guychronister@outlook.com, Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed typo on USB device ID number.
Message-ID: <20180627222058.GC30938@kroah.com>
References: <1530115467-3771-1-git-send-email-guylovesbritt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530115467-3771-1-git-send-email-guylovesbritt@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:04:27AM -0500, Guy Chronister wrote:
> Signed-off-by: Guy Chronister <guylovesbritt@gmail.com>

I can't take patches without any changelog text at all, sorry.


> ---
>  drivers/usb/host/xhci-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 6372edf..6ec766b 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -196,7 +196,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
>  	}
>  	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
> -	    pdev->device == 0x0014) {
> +	    pdev->device == 0x0015) {

Why do you think that 14 is not the valid number here?

Why is 15 the valid number?

thanks,

greg k-h
