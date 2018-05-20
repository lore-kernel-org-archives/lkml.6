Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeETCz6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 22:55:58 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37478 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbeETCz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 22:55:56 -0400
Date: Sat, 19 May 2018 22:55:54 -0400 (EDT)
Message-Id: <20180519.225554.2228035284410636067.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next] net: mvpp2: Add missing VLAN tag detection
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180518073339.5353-1-maxime.chevallier@bootlin.com>
References: <20180518073339.5353-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Fri, 18 May 2018 09:33:39 +0200

> Marvell PPv2 Header Parser sets some bits in the 'result_info' field in
> each lookup iteration, to identify different packet attributes such as
> DSA / VLAN tag, protocol infos, etc. This is used in further
> classification stages in the controller.
> 
> It's the DSA tag detection entry that is in charge of detecting when there
> is a single VLAN tag.
> 
> This commits adds the missing update of the result_info in this case.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Applied, thanks.
