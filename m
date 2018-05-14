Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeENU5A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:57:00 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:58727 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbeENU47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:56:59 -0400
Date: Mon, 14 May 2018 22:56:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next v3 4/7] net: mscc: Add initial Ocelot switch
 support
Message-ID: <20180514205653.GF1057@lunn.ch>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
 <20180514200500.2953-5-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514200500.2953-5-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:04:57PM +0200, Alexandre Belloni wrote:
> Add a driver for Microsemi Ocelot Ethernet switch support.
> 
> This makes two modules:
> mscc_ocelot_common handles all the common features that doesn't depend on
> how the switch is integrated in the SoC. Currently, it handles offloading
> bridging to the hardware. ocelot_io.c handles register accesses. This is
> unfortunately needed because the register layout is packed and then depends
> on the number of ports available on the switch. The register definition
> files are automatically generated.
> 
> ocelot_board handles the switch integration on the SoC and on the board.
> 
> Frame injection and extraction to/from the CPU port is currently done using
> register accesses which is quite slow. DMA is possible but the port is not
> able to absorb the whole switch bandwidth.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Hi Alexandre

There are a few Christmas trees which are not fully reversed. DaveM
might want them putting right.

But otherwise i think this is good enough to be merged.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
