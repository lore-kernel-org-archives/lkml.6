Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeBZVrX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:47:23 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:54795 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeBZVrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:47:21 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: netdev@vger.kernel.org
Cc: Jose.Abreu@synopsys.com, pavel@ucw.cz,
        Niklas Cassel <niklass@axis.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] stmmac barrier fixes and cleanup
Date: Mon, 26 Feb 2018 22:47:05 +0100
Message-Id: <20180226214709.4359-1-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stmmac barrier fixes and cleanup

Niklas Cassel (4):
  net: stmmac: ensure that the MSS desc is the last desc to set the own
    bit
  net: stmmac: use correct barrier between coherent memory and MMIO
  net: stmmac: ensure that the device has released ownership before
    reading data
  net: stmmac: make dwmac4_release_tx_desc() clear all descriptor fields

 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.14.2
