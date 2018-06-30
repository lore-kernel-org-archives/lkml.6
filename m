Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10E6C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 16:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B00A208FA
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 16:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B00A208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbeF3QJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 12:09:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36154 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbeF3QJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 12:09:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB7CE92F;
        Sat, 30 Jun 2018 16:09:27 +0000 (UTC)
Date:   Sat, 30 Jun 2018 18:09:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tamir Suliman <tsuliman@linuxvaults.com>
Cc:     ganesanr@broadcom.com, jchandra@broadcom.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] NETLOGIC: Kconfig: Fixed help  and coding style
 warnings
Message-ID: <20180630160925.GA20625@kroah.com>
References: <1530369044-23734-1-git-send-email-tsuliman@linuxvaults.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530369044-23734-1-git-send-email-tsuliman@linuxvaults.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 02:30:44PM +0000, Tamir Suliman wrote:
> Fixed Coding style issues
> 
> Signed-off-by: Tamir Suliman <tsuliman@linuxvaults.com>
> ---
>  drivers/staging/netlogic/Kconfig | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/netlogic/Kconfig b/drivers/staging/netlogic/Kconfig
> index d660de5..6e8e56a 100644
> --- a/drivers/staging/netlogic/Kconfig
> +++ b/drivers/staging/netlogic/Kconfig
> @@ -2,6 +2,8 @@ config NETLOGIC_XLR_NET
>  	tristate "Netlogic XLR/XLS network device"
>  	depends on CPU_XLR
>  	select PHYLIB
> -	---help---
> +	help
>  	This driver support Netlogic XLR/XLS on chip gigabit
> -	Ethernet.
> +	Ethernet.The XLR/XLS NAE blocks can be configured as one 10G
> +	interface or four 1G interfaces. This driver supports blocks
> +	with 1G ports.
> -- 
> 1.8.3.1

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
