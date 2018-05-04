Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeEDRb2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:31:28 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36276 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeEDRb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:31:26 -0400
Date: Fri, 04 May 2018 13:31:24 -0400 (EDT)
Message-Id: <20180504.133124.1418203002698359321.davem@davemloft.net>
To: antoine.tenart@bootlin.com
Cc: linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net] net: phy: sfp: fix the BR,min computation
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180504151054.17525-1-antoine.tenart@bootlin.com>
References: <20180504151054.17525-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Fri,  4 May 2018 17:10:54 +0200

> In an SFP EEPROM values can be read to get information about a given SFP
> module. One of those is the bitrate, which can be determined using a
> nominal bitrate in addition with min and max values (in %). The SFP code
> currently compute both BR,min and BR,max values thanks to this nominal
> and min,max values.
> 
> This patch fixes the BR,min computation as the min value should be
> subtracted to the nominal one, not added.
> 
> Fixes: 9962acf7fb8c ("sfp: add support for 1000Base-PX and 1000Base-BX10")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied and queued up for -stable, thanks.
