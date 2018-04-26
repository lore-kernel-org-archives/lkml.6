Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756148AbeDZUqR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:46:17 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42230 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753393AbeDZUqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:46:15 -0400
Date: Thu, 26 Apr 2018 22:46:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH net-next v2 2/7] net: mscc: Add MDIO driver
Message-ID: <20180426204603.GC23481@lunn.ch>
References: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
 <20180426195931.5393-3-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426195931.5393-3-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 09:59:26PM +0200, Alexandre Belloni wrote:
> Add a driver for the Microsemi MII Management controller (MIIM) found on
> Microsemi SoCs.
> On Ocelot, there are two controllers, one is connected to the internal
> PHYs, the other one can communicate with external PHYs.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
