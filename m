Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753434AbeC1TFq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:05:46 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33916 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752894AbeC1TFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:05:43 -0400
X-Google-Smtp-Source: AIpwx4/5dySkv0n7ETE3+7rDU/R9ayObGfYDh+ByhHfApN+5o/Q2U5Y25fX+KnrueoDvdAUAsIcn5g==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list),
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Yan Markman <ymarkman@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH net-next 0/2] phylink: API changes
Date: Wed, 28 Mar 2018 12:03:37 -0700
Message-Id: <20180328190339.31433-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series contains two API changes to PHYLINK which will later be used
by DSA to migrate to PHYLINK. Because these are API changes that impact other
outstanding work (e.g: MVPP2) I would rather get them included sooner to minimize
conflicts.

Thank you!

Florian Fainelli (1):
  net: phy: phylink: Provide PHY interface to mac_link_{up,down}

Russell King (1):
  sfp/phylink: move module EEPROM ethtool access into netdev core
    ethtool

 drivers/net/ethernet/marvell/mvneta.c | 22 +++-------------------
 drivers/net/phy/phylink.c             | 32 +++-----------------------------
 drivers/net/phy/sfp-bus.c             |  6 ++----
 include/linux/netdevice.h             |  3 +++
 include/linux/phylink.h               | 13 ++++++++-----
 net/core/ethtool.c                    |  7 +++++++
 6 files changed, 26 insertions(+), 57 deletions(-)

-- 
2.14.1
