Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeENIhH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:37:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34424 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752155AbeENIhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:37:04 -0400
Date: Mon, 14 May 2018 10:37:03 +0200
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        kishon@ti.com, gregory.clement@bootlin.com, andrew@lunn.ch,
        jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 06/13] phy: add 2.5G SGMII mode to the
 phy_mode enum
Message-ID: <20180514083703.GG24660@kwain>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-7-antoine.tenart@bootlin.com>
 <20180508123408.GK16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180508123408.GK16141@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Tue, May 08, 2018 at 01:34:08PM +0100, Russell King - ARM Linux wrote:
> On Fri, May 04, 2018 at 03:56:36PM +0200, Antoine Tenart wrote:
> > This patch adds one more generic PHY mode to the phy_mode enum, to allow
> > configuring generic PHYs to the 2.5G SGMII mode by using the set_mode
> > callback.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Would it be possible to get the 2.5G SGMII comphy support merged
> ahead of the rest of this series please - I don't think there's been
> any objections to it, and having it in mainline would then mean I can
> drop the Marvell Comphy code from my tree and transition to the bootlin
> Comphy code instead.
> 
> Of course, the perfect solution would be to get the whole series merged,
> but I'm just thinking about the situation where we're still discussing
> points when the next merge window opens.

That would be great, and there are no dependency issue if patches 6 and
7 are taken ahead.

Kishon: since there are no objection to these two phy patches, could you
take them?

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
