Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933045AbeCSNKS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:10:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58673 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932998AbeCSNKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:10:16 -0400
Date: Mon, 19 Mar 2018 14:10:09 +0100
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>, davem@davemloft.net,
        kishon@ti.com, gregory.clement@bootlin.com, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR interface
 to use in-band negotiation
Message-ID: <20180319131009.GJ4519@kwain>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <20180319125227.GI4519@kwain>
 <20180319125953.GD19795@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180319125953.GD19795@lunn.ch>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, Mar 19, 2018 at 01:59:53PM +0100, Andrew Lunn wrote:
> 
> If they don't have PHYs, how are the connected to the outside world?

On 7k/8k you have the following scheme for 10G only interfaces:

   MAC -- Comphy -- PHY -- SFP cage -- ...

Or

   MAC -- Comphy -- SFP cage -- ...

The comphy provides serdes lanes, and can be configured in various
modes (SGMII, 2500SGMII, 10GKR...).

Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
