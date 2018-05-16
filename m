Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeEPL0Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:26:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39744 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752243AbeEPL0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:26:23 -0400
Date: Wed, 16 May 2018 13:26:22 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: James Hogan <jhogan@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next v3 0/7] Microsemi Ocelot Ethernet switch support
Message-ID: <20180516112622.GA3254@piout.net>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
 <20180514205844.GG1057@lunn.ch>
 <20180514214734.GB29541@jamesdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514214734.GB29541@jamesdev>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2018 22:47:35+0100, James Hogan wrote:
> On Mon, May 14, 2018 at 10:58:44PM +0200, Andrew Lunn wrote:
> > Hi Alexandre
> > > 
> > > The ocelot dts changes are here for reference and should probably go
> > > through the MIPS tree once the bindings are accepted.
> > 
> > For your next version, you probably want to drop those patches, so
> > that David can apply the network patches to net-next.
> 
> Since it sounds like the net patches are ready now, I'll apply the MIPS
> DTS ones for 4.18.
> 

They are in now, tell me if you want me to resend.

Anyway, I'll probably send another patch to enable the driver in
board-ocelot.config


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
