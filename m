Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeEUPvV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 11:51:21 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56006 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeEUPvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 11:51:18 -0400
Date: Mon, 21 May 2018 11:51:15 -0400 (EDT)
Message-Id: <20180521.115115.102542572797022222.davem@davemloft.net>
To: antoine.tenart@bootlin.com
Cc: linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next 0/2] net: sfp: small improvements
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180517082907.14420-1-antoine.tenart@bootlin.com>
References: <20180517082907.14420-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Thu, 17 May 2018 10:29:05 +0200

> This series was part of the mvpp2 phylink one but as we reworked it to
> use fixed-link on the DB boards, the SFP commits weren't needed
> anymore for our use case. Two of the three patches still are needed I
> believe (I ditched the one about non-wired SFP cages), so they are sent
> here in a separate series.

Based upon the discussion of patch #1, it seems there is a desire to make
the i2c-bus property mandatory since it isn't clear if access to the SFP
module without it really all that doable.
