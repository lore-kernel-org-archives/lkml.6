Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeEQJ0e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:26:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45732 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752562AbeEQJ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:26:32 -0400
Date: Thu, 17 May 2018 11:26:20 +0200
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        kishon@ti.com, gregory.clement@bootlin.com, andrew@lunn.ch,
        jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 00/10] net: mvpp2: phylink conversion
Message-ID: <20180517092620.GL32746@kwain>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517091856.GA17671@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180517091856.GA17671@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Thu, May 17, 2018 at 10:18:56AM +0100, Russell King - ARM Linux wrote:
> On Thu, May 17, 2018 at 10:29:29AM +0200, Antoine Tenart wrote:
> > Since v2:
> >   - Removed the SFP description from the DB boards, as their SFP cages
> >     are wired properly. We now use fixed-link.
> 
> I think you mean "improperly" here.

Right :)

Thanks,
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
