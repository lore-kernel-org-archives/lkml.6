Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeEQIfH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:35:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42387 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752500AbeEQIfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:35:03 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 0/3] net: mvpp2: small improvements
Date: Thu, 17 May 2018 10:34:24 +0200
Message-Id: <20180517083427.15793-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Those 3 patches are small improvements to the Marvell PPv2 driver. The
series does not conflict with the one sent about phylink and
1000/2500baseX support, so the two series can live in parallel.

Thanks!
Antoine

Yan Markman (3):
  net: mvpp2: avoid checking for free aggregated descriptors twice
  net: mvpp2: set mac address does not require the stop/start sequence
  net: mvpp2: print rx error with rate-limit

 drivers/net/ethernet/marvell/mvpp2.c | 59 +++++++++-------------------
 1 file changed, 18 insertions(+), 41 deletions(-)

-- 
2.17.0
