Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeEOXsc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:48:32 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45392 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeEOXsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:48:31 -0400
X-Google-Smtp-Source: AB8JxZoIzATzgtpCSu/nJh4OeIR8BJib5xZvIbqyfZsFkxqUPRq82mherNOkh+YeHWLlqqgCkzeWJQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 0/3] net: Allow more drivers with COMPILE_TEST
Date: Tue, 15 May 2018 16:48:22 -0700
Message-Id: <20180515234825.11240-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

This patch series includes more drivers to be build tested with COMPILE_TEST
enabled. This helps cover some of the issues I just ran into with missing
a driver *sigh*.

Florian Fainelli (3):
  net: ethernet: ti: Allow most drivers with COMPILE_TEST
  net: ethernet: freescale: Allow FEC with COMPILE_TEST
  net: phy: Allow MDIO_MOXART and MDIO_SUN4I with COMPILE_TEST

 drivers/net/ethernet/freescale/Kconfig |  2 +-
 drivers/net/ethernet/ti/Kconfig        | 14 +++++++-------
 drivers/net/phy/Kconfig                |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.14.1
