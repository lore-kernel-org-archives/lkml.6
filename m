Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeEQUTZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:19:25 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:34486 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeEQUTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:19:22 -0400
Date: Thu, 17 May 2018 16:19:20 -0400 (EDT)
Message-Id: <20180517.161920.1442577639507022791.davem@davemloft.net>
To: antoine.tenart@bootlin.com
Cc: ymarkman@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 2/3] net: mvpp2: set mac address does not
 require the stop/start sequence
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180517083427.15793-3-antoine.tenart@bootlin.com>
References: <20180517083427.15793-1-antoine.tenart@bootlin.com>
        <20180517083427.15793-3-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Thu, 17 May 2018 10:34:26 +0200

> From: Yan Markman <ymarkman@marvell.com>
> 
> Remove special stop/start handling from the set_mac_address callback.
> All this special care is not needed, and can be removed. It also
> simplifies the up/down status in the driver and helps avoiding possible
> link status mismatch issues.
> 
> Signed-off-by: Yan Markman <ymarkman@marvell.com>
> [Antoine: commit message]
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied.
