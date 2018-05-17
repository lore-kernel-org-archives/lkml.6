Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeEQJT1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:19:27 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56058 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbeEQJTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:19:24 -0400
Date: Thu, 17 May 2018 10:18:56 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, kishon@ti.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 00/10] net: mvpp2: phylink conversion
Message-ID: <20180517091856.GA17671@n2100.armlinux.org.uk>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517082939.14598-1-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 10:29:29AM +0200, Antoine Tenart wrote:
> Since v2:
>   - Removed the SFP description from the DB boards, as their SFP cages
>     are wired properly. We now use fixed-link.

I think you mean "improperly" here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
