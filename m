Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D49C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4286C20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oLYl71C3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbfA3Qi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:38:26 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:32768 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfA3Qi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Awb+e7KyeVsQY0L1pRZuEHWubonzwcbqoNNQPfvskxY=; b=oLYl71C3EZwLUlZPRYSbe0nUXy
        C34Ofv0t26OdOMUNAiOoACSOArAQnP3VTqsPWUj+Hi1lvSJ1ohWiYWdECwQ5t+iEbddx9xb7NMRMP
        /AIiwYlXlJ4EN4acSu5kp24FEbCPA10gihRfnZx/9cCbrxjK/HGt7IJIrXwKLNXQI3Lw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gossT-0004w7-1U; Wed, 30 Jan 2019 17:38:17 +0100
Date:   Wed, 30 Jan 2019 17:38:17 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Carlos Henrique Lima Melara <charlesmelara@outlook.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "neil@brown.name" <neil@brown.name>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] staging: mt7621-eth/ethtool.c: Correction of SPDX
 license identifier
Message-ID: <20190130163817.GF21904@lunn.ch>
References: <SC1P15201MB2014C3E0CAB4DA9ADF330797A8900@SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SC1P15201MB2014C3E0CAB4DA9ADF330797A8900@SC1P15201MB2014.LAMP152.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 02:48:27PM +0000, Carlos Henrique Lima Melara wrote:
> 	This patch fix the checkpatch.p1 warning:
> 
> 	WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> 	+/*
> 
> 	It includes the SPDX expression for GPL-2.0 and corrects the comment format to suit the kernel's coding style.
> 
> Signed-off-by: Carlos (Charles) Henrique Lima Melara <charlesmelara@outlook.com>
> ---
>  drivers/staging/mt7621-eth/ethtool.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt7621-eth/ethtool.c
> index 40a7d47be913..49d417de64c8 100644
> --- a/drivers/staging/mt7621-eth/ethtool.c
> +++ b/drivers/staging/mt7621-eth/ethtool.c
> @@ -1,15 +1,17 @@
> -/*   This program is free software; you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; version 2 of the License
> +// SPDX-License-Identifier: GPL-2.0

Hi Carlos

drivers/staging/mt7621-eth$ grep LICENSE *
gsw_mt7621.c:MODULE_LICENSE("GPL");
mtk_eth_soc.c:MODULE_LICENSE("GPL");

And include/linux/module.h 
says:

/*
 * The following license idents are currently accepted as indicating free
 * software modules
 *
 *      "GPL"                           [GNU Public License v2 or later]
 *      "GPL v2"                        [GNU Public License v2]

So the SPDX string probably does not match the MODULE_LICENSE.

   Andrew
