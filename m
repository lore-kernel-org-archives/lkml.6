Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeBIQXF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:23:05 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:49951 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBIQXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:23:04 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: netdev@vger.kernel.org
Cc: Niklas Cassel <niklass@axis.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] stmmac irq fixes/cleanups
Date: Fri,  9 Feb 2018 17:22:44 +0100
Message-Id: <20180209162247.3724-1-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of small stmmac irq fixes/cleanups.

Niklas Cassel (3):
  net: stmmac: discard disabled flags in interrupt status register
  net: stmmac: rename GMAC_INT_DEFAULT_MASK for dwmac4
  net: stmmac: remove redundant enable of PMT irq

 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c |  2 --
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h         |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c    | 13 +++++++------
 3 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.14.2
