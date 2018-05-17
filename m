Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeEQTXK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:23:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37488 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeEQTXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:23:09 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH net-next ] net: mscc: Add SPDX identifier
Date: Thu, 17 May 2018 21:23:05 +0200
Message-Id: <20180517192305.17517-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ocelot_qsys.h is missing the SPDX identfier, fix that.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot_qsys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_qsys.h b/drivers/net/ethernet/mscc/ocelot_qsys.h
index aa7267d5ca77..d8c63aa761be 100644
--- a/drivers/net/ethernet/mscc/ocelot_qsys.h
+++ b/drivers/net/ethernet/mscc/ocelot_qsys.h
@@ -1,7 +1,7 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
  * Microsemi Ocelot Switch driver
  *
- * License: Dual MIT/GPL
  * Copyright (c) 2017 Microsemi Corporation
  */
 
-- 
2.17.0
