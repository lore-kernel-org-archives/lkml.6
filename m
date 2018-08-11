Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3456FC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98A221A00
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98A221A00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeHKTAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 15:00:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeHKTAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 15:00:51 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 012E4904;
        Sat, 11 Aug 2018 16:26:07 +0000 (UTC)
Date:   Sat, 11 Aug 2018 18:26:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Anckaert <michael.anckaert@sinax.be>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: netlogic: Fixed comments to include
 SPDX-License-Identifier
Message-ID: <20180811162605.GA20944@kroah.com>
References: <20180811161505.GA7309@winston.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811161505.GA7309@winston.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 06:15:05PM +0200, Michael Anckaert wrote:
> This patch fixes some issues with missing SPDX-License-Identifier
> comments. 
> 
> Disclaimer: this is my first patch and instructions were taken from the
> KernelNewbies project. 

This does not belong in a changelog comment.  If you want to put info
like this, put it below the --- line.

> 
> Signed-off-by: Michael Anckaert <michael.anckaert@sinax.be>
> ---
>  drivers/staging/netlogic/Kconfig        | 6 +++---
>  drivers/staging/netlogic/platform_net.c | 1 +
>  drivers/staging/netlogic/platform_net.h | 1 +
>  drivers/staging/netlogic/xlr_net.c      | 1 +
>  drivers/staging/netlogic/xlr_net.h      | 1 +
>  5 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/netlogic/Kconfig b/drivers/staging/netlogic/Kconfig
> index d660de51b541..ab0b756bc08b 100644
> --- a/drivers/staging/netlogic/Kconfig
> +++ b/drivers/staging/netlogic/Kconfig
> @@ -2,6 +2,6 @@ config NETLOGIC_XLR_NET
>  	tristate "Netlogic XLR/XLS network device"
>  	depends on CPU_XLR
>  	select PHYLIB
> -	---help---
> -	This driver support Netlogic XLR/XLS on chip gigabit
> -	Ethernet.
> +	help
> +		This driver support Netlogic XLR/XLS on chip gigabit
> +		Ethernet.

This change has nothing to do with spdx identifiers :(

Please fix up and resend as 2 different patches.

thanks,

greg k-h
