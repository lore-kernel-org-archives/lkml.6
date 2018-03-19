Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932678AbeCSIo0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:44:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49226 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932143AbeCSIoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:44:24 -0400
Date: Mon, 19 Mar 2018 09:44:22 +0100
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        kishon@ti.com, linux@armlinux.org.uk, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        ymarkman@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
        nadavh@marvell.com, thomas.petazzoni@bootlin.com,
        miquel.raynal@bootlin.com, stefanc@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 05/10] phy: cp110-comphy: 2.5G SGMII mode
Message-ID: <20180319084422.GD4519@kwain>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-6-antoine.tenart@bootlin.com>
 <20180318044247.kp3i2ymvrj5fdoj3@sapphire.tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180318044247.kp3i2ymvrj5fdoj3@sapphire.tkos.co.il>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baruch,

On Sun, Mar 18, 2018 at 06:42:48AM +0200, Baruch Siach wrote:
> On Fri, Mar 16, 2018 at 11:33:46AM +0100, Antoine Tenart wrote:
> > This patch allow the CP100 comphy to configure some lanes in the
> 
> Should be 'CP110'.

That's right, I'll update.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
