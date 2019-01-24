Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF671C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DC0218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfAXN3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:29:50 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37924 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfAXN3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:29:49 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5B2742084E; Thu, 24 Jan 2019 14:29:47 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2C00B2077B;
        Thu, 24 Jan 2019 14:29:37 +0100 (CET)
Date:   Thu, 24 Jan 2019 14:29:37 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        sd@queasysnail.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 02/10] net: macsec: convert to SPDX
Message-ID: <20190124132937.GF3662@kwain>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
 <20190123155638.13852-3-antoine.tenart@bootlin.com>
 <20190123170306.GG5310@lunn.ch>
 <20190124085456.GB3662@kwain>
 <20190124131118.GA28903@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190124131118.GA28903@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, Jan 24, 2019 at 02:11:18PM +0100, Andrew Lunn wrote:
> > That's right, I'll fix it in v2. In such cases, the license text takes
> > precedence over the MODULE_LICENSE() definition ?
>  
> I've also not seen any real discussion about this. But when i recently
> proposed patches to cleanup similar issues in drivers/net/phy, i gave
> the license text precedence, since it is a lot easier for a human to
> understand, and it is likely a human made the error....

I would go for this as well, it seems logical for MODULE_LICENSE() to
only be an identifier of what the license described in the license text
is.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
