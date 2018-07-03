Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE40C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259B224AB4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259B224AB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeGCO37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:29:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46648 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752734AbeGCO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:29:58 -0400
Received: from localhost (unknown [213.138.59.42])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 22353E3A;
        Tue,  3 Jul 2018 14:29:56 +0000 (UTC)
Date:   Tue, 3 Jul 2018 16:29:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Razvan Stefanescu <razvan.stefanescu@nxp.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ruxandra.radulescu@nxp.com,
        ioana.ciornei@nxp.com
Subject: Re: [PATCH] staging: fsl-dpaa2/ethsw: Update maintainers for
 Ethernet Switch driver
Message-ID: <20180703142954.GA2043@kroah.com>
References: <1530626724-20833-1-git-send-email-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530626724-20833-1-git-send-email-razvan.stefanescu@nxp.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 05:05:24PM +0300, Razvan Stefanescu wrote:
> Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>

No changelog text?

> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b6d0cc0..0d36546 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4434,7 +4434,8 @@ S:	Maintained
>  F:	drivers/staging/fsl-dpaa2/ethernet
>  
>  DPAA2 ETHERNET SWITCH DRIVER
> -M:	Razvan Stefanescu <razvan.stefanescu@nxp.com>
> +M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
> +M:	Ioana Ciornei <ioana.ciornei@nxp.com>

No ack/signed-off-by from either of these developers?

I can't take this as-is :(

thanks,

greg k-h
