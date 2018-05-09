Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933287AbeEIAOx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 20:14:53 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37526 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933175AbeEIAOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 20:14:51 -0400
Date: Tue, 08 May 2018 20:14:49 -0400 (EDT)
Message-Id: <20180508.201449.398803363821420826.davem@davemloft.net>
To: antoine.tenart@bootlin.com
Cc: linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next] net: phy: sfp: handle cases where neither
 BR,min nor BR,max is given
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180504152103.18152-1-antoine.tenart@bootlin.com>
References: <20180504152103.18152-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Fri,  4 May 2018 17:21:03 +0200

> When computing the bitrate using values read from an SFP module EEPROM,
> we use the nominal BR plus BR,min and BR,max to determine the
> boundaries. But in some cases BR,min and BR,max aren't provided, which
> led the SFP code to end up having the nominal value for both the minimum
> and maximum bitrate values. When using a passive cable, the nominal
> value should be used as the maximum one, and there is no minimum one
> so we should use 0.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied, thank you.
