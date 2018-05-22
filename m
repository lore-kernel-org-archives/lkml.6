Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeEVJYp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:24:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49004 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEVJYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:24:42 -0400
Date: Tue, 22 May 2018 11:24:30 +0200
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: David Miller <davem@davemloft.net>
Cc: antoine.tenart@bootlin.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 0/2] net: sfp: small improvements
Message-ID: <20180522092430.GC2871@kwain>
References: <20180517082907.14420-1-antoine.tenart@bootlin.com>
 <20180521.115115.102542572797022222.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180521.115115.102542572797022222.davem@davemloft.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, May 21, 2018 at 11:51:15AM -0400, David Miller wrote:
> From: Antoine Tenart <antoine.tenart@bootlin.com>
> Date: Thu, 17 May 2018 10:29:05 +0200
> 
> > This series was part of the mvpp2 phylink one but as we reworked it to
> > use fixed-link on the DB boards, the SFP commits weren't needed
> > anymore for our use case. Two of the three patches still are needed I
> > believe (I ditched the one about non-wired SFP cages), so they are sent
> > here in a separate series.
> 
> Based upon the discussion of patch #1, it seems there is a desire to make
> the i2c-bus property mandatory since it isn't clear if access to the SFP
> module without it really all that doable.

Thanks for the clarification, I was about to ask for it. I'll make a v2
making i2c-bus mandatory then.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
