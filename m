Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeC3S2N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 14:28:13 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:34260 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeC3S2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 14:28:11 -0400
Date: Fri, 30 Mar 2018 14:28:09 -0400 (EDT)
Message-Id: <20180330.142809.999625397182275884.davem@davemloft.net>
To: gregory.clement@bootlin.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, antoine.tenart@bootlin.com,
        miquel.raynal@bootlin.com, maxime.chevallier@bootlin.com,
        stefanc@marvell.com, ymarkman@marvell.com, yelena@marvell.com
Subject: Re: [PATCH] net: mvneta: fix enable of all initialized RXQs
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180330100531.5995-1-gregory.clement@bootlin.com>
References: <20180330100531.5995-1-gregory.clement@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Fri, 30 Mar 2018 12:05:31 +0200

> From: Yelena Krivosheev <yelena@marvell.com>
> 
> In mvneta_port_up() we enable relevant RX and TX port queues by write
> queues bit map to an appropriate register.
> 
> q_map must be ZERO in the beginning of this process.
> 
> Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Applied, thank you.
