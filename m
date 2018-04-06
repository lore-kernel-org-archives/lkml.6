Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeDFCOI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 22:14:08 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35488 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeDFCOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 22:14:07 -0400
Date: Thu, 05 Apr 2018 22:14:04 -0400 (EDT)
Message-Id: <20180405.221404.539421444734816274.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net] net: mvpp2: Fix parser entry init boundary check
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180405095548.14433-1-maxime.chevallier@bootlin.com>
References: <20180405095548.14433-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Thu,  5 Apr 2018 11:55:48 +0200

> Boundary check in mvpp2_prs_init_from_hw must be done according to the
> passed "tid" parameter, not the mvpp2_prs_entry index, which is not yet
> initialized at the time of the check.
> 
> Fixes: 47e0e14eb1a6 ("net: mvpp2: Make mvpp2_prs_hw_read a parser entry init function")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Applied, thanks.
