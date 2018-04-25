Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755552AbeDYRBZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:01:25 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52274 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754585AbeDYRBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:01:22 -0400
Date: Wed, 25 Apr 2018 13:01:20 -0400 (EDT)
Message-Id: <20180425.130120.435606346755827260.davem@davemloft.net>
To: alexandre.belloni@bootlin.com
Cc: andrew@lunn.ch, f.fainelli@gmail.com, Allan.Nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: allow scanning busses with missing phys
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180424160904.32457-1-alexandre.belloni@bootlin.com>
References: <20180424160904.32457-1-alexandre.belloni@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Tue, 24 Apr 2018 18:09:04 +0200

> Some MDIO busses will error out when trying to read a phy address with no
> phy present at that address. In that case, probing the bus will fail
> because __mdiobus_register() is scanning the bus for all possible phys
> addresses.
> 
> In case MII_PHYSID1 returns -EIO or -ENODEV, consider there is no phy at
> this address and set the phy ID to 0xffffffff which is then properly
> handled in get_phy_device().
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied, thank you.
