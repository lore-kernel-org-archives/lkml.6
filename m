Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeCUVLa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:11:30 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35406 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbeCUVL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:11:28 -0400
X-Google-Smtp-Source: AG47ELuxpVIGI0bvUOMxKC4xkFi3AN2CtsJ4EQeHnKtvnafCDxtx2nxypJxeJdz0OrO0xH2c+76Jng==
From: Vasyl Gomonovych <gomonovych@gmail.com>
To: mporter@kernel.crashing.org, alexandre.bounine@idt.com,
        linux-kernel@vger.kernel.org, gomonovych@gmail.com
Subject: [PATCH] rapidio: fix typo in comment
Date: Wed, 21 Mar 2018 22:10:35 +0100
Message-Id: <20180321211035.8904-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the words 'receiver', 'specified', 'during'

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/rapidio/rio-scan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 23429bdaca84..161b927d9de1 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -76,7 +76,7 @@ static u16 rio_destid_alloc(struct rio_net *net)
 }
 
 /**
- * rio_destid_reserve - Reserve the specivied destID
+ * rio_destid_reserve - Reserve the specified destID
  * @net: RIO network
  * @destid: destID to reserve
  *
@@ -885,7 +885,7 @@ static struct rio_net *rio_scan_alloc_net(struct rio_mport *mport,
  *
  * For each enumerated device, ensure that each switch in a system
  * has correct routing entries. Add routes for devices that where
- * unknown dirung the first enumeration pass through the switch.
+ * unknown during the first enumeration pass through the switch.
  */
 static void rio_update_route_tables(struct rio_net *net)
 {
@@ -983,7 +983,7 @@ static int rio_enum_mport(struct rio_mport *mport, u32 flags)
 		/* reserve mport destID in new net */
 		rio_destid_reserve(net, mport->host_deviceid);
 
-		/* Enable Input Output Port (transmitter reviever) */
+		/* Enable Input Output Port (transmitter receiver) */
 		rio_enable_rx_tx_port(mport, 1, 0, 0, 0);
 
 		/* Set component tag for host */
-- 
2.14.1
