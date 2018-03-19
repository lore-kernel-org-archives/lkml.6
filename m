Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755533AbeCSNYg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:24:36 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:35320 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753151AbeCSNYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:24:32 -0400
Date: Mon, 19 Mar 2018 14:24:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: Stefan Chulski <stefanc@marvell.com>,
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
Message-ID: <20180319132426.GB26039@lunn.ch>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <20180319125227.GI4519@kwain>
 <20180319125953.GD19795@lunn.ch>
 <54e290a192734831b5db22191f056a81@IL-EXCH01.marvell.com>
 <20180319130823.GA22306@lunn.ch>
 <20180319131343.GK4519@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319131343.GK4519@kwain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This would definitively work for SFP connectors with a PHY, but would
> that work when using direct attached cable?

Then you need to know what is on the other end of the cable? A switch?
A PHY? and SFP module?

  Andrew
