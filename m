Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754143AbeEHDSs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:18:48 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51804 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753771AbeEHDSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:18:46 -0400
Date: Mon, 07 May 2018 23:18:41 -0400 (EDT)
Message-Id: <20180507.231841.206393937472731641.davem@davemloft.net>
To: antoine.tenart@bootlin.com
Cc: kishon@ti.com, linux@armlinux.org.uk, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 00/13] net: mvpp2: phylink conversion
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Fri,  4 May 2018 15:56:30 +0200

> Also as the SFP cages on both DB boards can be considered as non-wired,
> the SFP code was reworked to really support when some pins of the SFP
> cage aren't described in the device tree. Also a warning was added when
> no Tx disable pin is available. (Patches 1-3).

I guess there is still discussion about whether fixed-link should be
used for this instead of SFP.
