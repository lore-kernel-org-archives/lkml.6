Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeEQUMQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:12:16 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:34362 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeEQUMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:12:12 -0400
Date: Thu, 17 May 2018 16:12:08 -0400 (EDT)
Message-Id: <20180517.161208.130123623065708877.davem@davemloft.net>
To: antoine.tenart@bootlin.com
Cc: kishon@ti.com, linux@armlinux.org.uk, gregory.clement@bootlin.com,
        andrew@lunn.ch, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 00/10] net: mvpp2: phylink conversion
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180517082939.14598-1-antoine.tenart@bootlin.com>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Thu, 17 May 2018 10:29:29 +0200

> @Dave: patches 7 to 10 should go through the mvebu tree (Gregory in
> Cc.) to avoid any conflict with the other mvebu dt patches taken during
> this cycle.
> 
> The series is based on today's net-next.

Ok, patches 1-6 applied to net-next, thank you.
