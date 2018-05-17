Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeEQUUc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:20:32 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:34476 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeEQUTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:19:17 -0400
Date: Thu, 17 May 2018 16:19:14 -0400 (EDT)
Message-Id: <20180517.161914.1906294163392051214.davem@davemloft.net>
To: antoine.tenart@bootlin.com
Cc: ymarkman@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 1/3] net: mvpp2: avoid checking for free
 aggregated descriptors twice
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180517083427.15793-2-antoine.tenart@bootlin.com>
References: <20180517083427.15793-1-antoine.tenart@bootlin.com>
        <20180517083427.15793-2-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Thu, 17 May 2018 10:34:25 +0200

> From: Yan Markman <ymarkman@marvell.com>
> 
> Avoid repeating the check for free aggregated descriptors when it
> already failed at the beginning of the function.
> 
> Signed-off-by: Yan Markman <ymarkman@marvell.com>
> [Antoine: commit message]
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied.
