Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C67C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DD621872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfAXIy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:54:59 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57089 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfAXIy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:54:59 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 70D9A207B6; Thu, 24 Jan 2019 09:54:56 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 428CF207AC;
        Thu, 24 Jan 2019 09:54:56 +0100 (CET)
Date:   Thu, 24 Jan 2019 09:54:56 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        sd@queasysnail.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 02/10] net: macsec: convert to SPDX
Message-ID: <20190124085456.GB3662@kwain>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
 <20190123155638.13852-3-antoine.tenart@bootlin.com>
 <20190123170306.GG5310@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190123170306.GG5310@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Jan 23, 2019 at 06:03:06PM +0100, Andrew Lunn wrote:
> On Wed, Jan 23, 2019 at 04:56:30PM +0100, Antoine Tenart wrote:
> > This cosmetic patch converts the macsec implementation license header to
> > the now recommended format, SPDX.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > ---
> >  drivers/net/macsec.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> > index 64a982563d59..56e354305f76 100644
> > --- a/drivers/net/macsec.c
> > +++ b/drivers/net/macsec.c
> > @@ -1,12 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> >  /*
> >   * drivers/net/macsec.c - MACsec device
> >   *
> >   * Copyright (c) 2015 Sabrina Dubroca <sd@queasysnail.net>
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> >   */
> >  
> >  #include <linux/types.h>
> 
> linux$ tail -4 drivers/net/macsec.c
> MODULE_ALIAS_GENL_FAMILY("macsec");
> 
> MODULE_DESCRIPTION("MACsec IEEE 802.1AE");
> MODULE_LICENSE("GPL v2");
> 
> The license text and the MODULE_LICENSE() don't agree with each other.
> It would be good to fix this as well.

That's right, I'll fix it in v2. In such cases, the license text takes
precedence over the MODULE_LICENSE() definition ?

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
