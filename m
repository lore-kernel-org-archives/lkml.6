Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeEQIel (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:34:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41789 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751179AbeEQIa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:30:29 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, linux@armlinux.org.uk
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 0/2] net: sfp: small improvements
Date: Thu, 17 May 2018 10:29:05 +0200
Message-Id: <20180517082907.14420-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

This series was part of the mvpp2 phylink one but as we reworked it to
use fixed-link on the DB boards, the SFP commits weren't needed
anymore for our use case. Two of the three patches still are needed I
believe (I ditched the one about non-wired SFP cages), so they are sent
here in a separate series.

Thanks!
Antoine

Since last time:
  - s/-EOPNOTSUPP/-ENODEV/ in patch 1/2.
  - I added the acked-by tag in patch 2/2.

Antoine Tenart (2):
  net: phy: sfp: make the i2c-bus property really optional
  net: phy: sfp: warn the user when no tx_disable pin is available

 drivers/net/phy/sfp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
2.17.0
