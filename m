Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeC2Ho0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:44:26 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33088 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeC2HoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:44:25 -0400
Date: Thu, 29 Mar 2018 08:44:09 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Yan Markman <ymarkman@marvell.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Yelena Krivosheev <yelena@marvell.com>
Subject: Re: [EXT] [PATCH net-next v2 0/2] phylink: API changes
Message-ID: <20180329074409.GA3359@n2100.armlinux.org.uk>
References: <20180328224416.6981-1-f.fainelli@gmail.com>
 <98b31575864f474fa7177c39ff06f81b@IL-EXCH01.marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98b31575864f474fa7177c39ff06f81b@IL-EXCH01.marvell.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 05:58:43AM +0000, Yan Markman wrote:
> Hi Florian
> Please keep CC 		Yelena Krivosheev <yelena@marvell.com>
> for changes with 	drivers/net/ethernet/marvell/mvneta.c
> Thanks

We have a way to ensure such things happen - it's the MAINTAINERS
file.  Please use the established community methods rather than
sending emails asking for people to remember such quirks.  Thanks.

> Yan Markman
> Tel. 05-44732819
> 
> 
> -----Original Message-----
> From: Florian Fainelli [mailto:f.fainelli@gmail.com] 
> Sent: Thursday, March 29, 2018 1:44 AM
> To: netdev@vger.kernel.org
> Cc: Florian Fainelli <f.fainelli@gmail.com>; Thomas Petazzoni <thomas.petazzoni@free-electrons.com>; Andrew Lunn <andrew@lunn.ch>; David S. Miller <davem@davemloft.net>; Russell King <rmk+kernel@armlinux.org.uk>; open list <linux-kernel@vger.kernel.org>; Antoine Tenart <antoine.tenart@bootlin.com>; Yan Markman <ymarkman@marvell.com>; Stefan Chulski <stefanc@marvell.com>; Maxime Chevallier <maxime.chevallier@bootlin.com>; Miquel Raynal <miquel.raynal@free-electrons.com>; Marcin Wojtas <mw@semihalf.com>
> Subject: [EXT] [PATCH net-next v2 0/2] phylink: API changes
> 
> External Email
> 
> ----------------------------------------------------------------------
> Hi all,
> 
> This patch series contains two API changes to PHYLINK which will later be used by DSA to migrate to PHYLINK. Because these are API changes that impact other outstanding work (e.g: MVPP2) I would rather get them included sooner to minimize conflicts.
> 
> Thank you!
> 
> Changes in v2:
> 
> - added missing documentation to mac_link_{up,down} that the interface
>   must be configured in mac_config()
> 
> - added Russell's, Andrew's and my tags
> 
> Florian Fainelli (1):
>   net: phy: phylink: Provide PHY interface to mac_link_{up,down}
> 
> Russell King (1):
>   sfp/phylink: move module EEPROM ethtool access into netdev core
>     ethtool
> 
>  drivers/net/ethernet/marvell/mvneta.c | 22 +++-------------------
>  drivers/net/phy/phylink.c             | 32 +++-----------------------------
>  drivers/net/phy/sfp-bus.c             |  6 ++----
>  include/linux/netdevice.h             |  3 +++
>  include/linux/phylink.h               | 17 +++++++++++------
>  net/core/ethtool.c                    |  7 +++++++
>  6 files changed, 29 insertions(+), 58 deletions(-)
> 
> --
> 2.14.1
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
