Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933034AbeCSNNq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:13:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58870 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932793AbeCSNNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:13:45 -0400
Date: Mon, 19 Mar 2018 14:13:43 +0100
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stefan Chulski <stefanc@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kishon@ti.com" <kishon@ti.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
 interface to use in-band negotiation
Message-ID: <20180319131343.GK4519@kwain>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <20180319125227.GI4519@kwain>
 <20180319125953.GD19795@lunn.ch>
 <54e290a192734831b5db22191f056a81@IL-EXCH01.marvell.com>
 <20180319130823.GA22306@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180319130823.GA22306@lunn.ch>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 02:08:23PM +0100, Andrew Lunn wrote:
> > > If they don't have PHYs, how are the connected to the outside world?
> > 
> > By external SFP or direct attached cable.
> 
> Maybe i'm missing something, but don't you just need to add an SFP
> device in the device tree. The SFP code and PHYLINK will work
> together, query what the SFP module is, use the GPIOs to determine
> link up/down and module present, and tell the MAC how to configure the
> MAC-SFP link?

This would definitively work for SFP connectors with a PHY, but would
that work when using direct attached cable? As in the second case
phylink wouldn't be able to ask the SFP PHY for the link state.

Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
