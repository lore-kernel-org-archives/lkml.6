Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934519AbeCGUyO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:54:14 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:57120 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934240AbeCGUyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:54:12 -0500
Date: Wed, 07 Mar 2018 15:54:10 -0500 (EST)
Message-Id: <20180307.155410.724183535049256132.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, antoine.tenart@bootlin.com,
        miquel.raynal@bootlin.com, gregory.clement@bootlin.com,
        mw@semihalf.com, ymarkman@marvell.com, nadavh@marvell.com,
        stefanc@marvell.com
Subject: Re: [PATCH net-next 0/2] net: mvpp2: Add Unicast filtering
 capabilities
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180307141804.348-1-maxime.chevallier@bootlin.com>
References: <20180307141804.348-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Wed,  7 Mar 2018 15:18:02 +0100

> This series adds unicast filtering support to the Marvell PPv2 controller.
> 
> This is implemented using the header parser cababilities of the PPv2,
> which allows for generic packet filtering based on matching patterns in
> the packet headers.
> 
> PPv2 controller only has 256 of these entries, and we need to share them
> with other features, such as VLAN filtering.
> 
> For each interface, we have 5 entries dedicated to unicast filtering (the
> controller's own address, and 4 other), and 21 to multicast filtering.
> 
> When this number is reached, the controller switches to unicast or
> multicast promiscuous mode.
> 
> The first patch reworks the function that adds and removes addresses to the
> filter. This is preparatory work to ease UC filter implementation.
> 
> The second patch adds the UC filtering feature.

Series applied, thanks.
