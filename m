Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbeDSRNJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:13:09 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60742 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbeDSRNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:13:08 -0400
Date: Thu, 19 Apr 2018 13:13:05 -0400 (EDT)
Message-Id: <20180419.131305.1385490904148860354.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net] net: mvpp2: Fix DMA address mask size
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180418091444.14039-1-maxime.chevallier@bootlin.com>
References: <20180418091444.14039-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Wed, 18 Apr 2018 11:14:44 +0200

> PPv2 TX/RX descriptors uses 40bits DMA addresses, but 41 bits masks were
> used (GENMASK_ULL(40, 0)).
> 
> This commit fixes that by using the correct mask.
> 
> Fixes: e7c5359f2eed ("net: mvpp2: introduce PPv2.2 HW descriptors and adapt accessors")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Applied and queued up for -stable, thank you.
