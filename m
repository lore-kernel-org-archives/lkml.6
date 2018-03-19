Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755506AbeCSNAG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:00:06 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:35238 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755299AbeCSNAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:00:05 -0400
Date: Mon, 19 Mar 2018 13:59:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, davem@davemloft.net,
        kishon@ti.com, gregory.clement@bootlin.com, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR interface
 to use in-band negotiation
Message-ID: <20180319125953.GD19795@lunn.ch>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <20180319125227.GI4519@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319125227.GI4519@kwain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antoine

> You guessed right, that's exactly my use case. The DB boards (7k and 8k)
> have 10G interfaces without PHYs.

If they don't have PHYs, how are the connected to the outside world?

   Andrew
