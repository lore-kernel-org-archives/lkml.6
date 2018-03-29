Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeC2O5f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:57:35 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46366 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752106AbeC2O5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:57:34 -0400
Date: Thu, 29 Mar 2018 16:57:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 3/8] net: mscc: Add MDIO driver
Message-ID: <20180329145727.GB25752@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-4-alexandre.belloni@bootlin.com>
 <20180323204939.GS24361@lunn.ch>
 <20180329140544.GB12066@piout.net>
 <20180329144041.GA25752@lunn.ch>
 <20180329145352.GD12066@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329145352.GD12066@piout.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > It sounds like the correct fix is for get_phy_id() to look at the
> > error code for mdiobus_read(bus, addr, MII_PHYSID1). If it is EIO and
> > maybe ENODEV, set *phy_id to 0xffffffff and return. The scan code
> > should then do the correct thing.
> > 
> 
> That could work indeed. Do you want me to test and send a patch?

Yes please.

Thanks
	Andrew
