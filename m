Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbeERGlT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:41:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48584 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeERGlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:41:17 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH net-next 0/2] net: mscc; ocelot: add more features
Date: Fri, 18 May 2018 08:41:04 +0200
Message-Id: <20180518064106.10122-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds link aggregation and VLAN filtering hardware offload
support to the ocelot driver.

PTP is also on the list of features but it will probably not be
submitted this cycle.

Alexandre Belloni (1):
  net: mscc: ocelot: add bonding support

Antoine Tenart (1):
  net: mscc: ocelot: add VLAN filtering

 drivers/net/ethernet/mscc/ocelot.c | 462 ++++++++++++++++++++++++++++-
 drivers/net/ethernet/mscc/ocelot.h |   2 +-
 2 files changed, 461 insertions(+), 3 deletions(-)

-- 
2.17.0
