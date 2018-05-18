Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeERQFH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:05:07 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36805 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751496AbeERQFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:05:03 -0400
Date: Fri, 18 May 2018 18:04:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: mscc: ocelot: add bonding support
Message-ID: <20180518160455.GD26377@lunn.ch>
References: <20180518064106.10122-1-alexandre.belloni@bootlin.com>
 <20180518064106.10122-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518064106.10122-2-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 08:41:05AM +0200, Alexandre Belloni wrote:
> Add link aggregation hardware offload support for Ocelot.

Hi Alexandre

What i don't see here is anything checking the mode being
requested. If the user requests 'random' but the hardware only
supports 'roundrobin', you probably should not do the offload.

	 Andrew
