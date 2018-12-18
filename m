Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F623C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6C121871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeLRPwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:52:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38685 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeLRPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:52:46 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1gZHfl-0007oZ-TA; Tue, 18 Dec 2018 16:52:41 +0100
Received: from mfe by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <mfe@pengutronix.de>)
        id 1gZHfl-00010G-CF; Tue, 18 Dec 2018 16:52:41 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     sakari.ailus@linux.intel.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] device property: fix fwnode_graph_get_next_endpoint documentation
Date:   Tue, 18 Dec 2018 16:52:39 +0100
Message-Id: <20181218155239.3643-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync documentation with code.

Fixes: 07bb80d40b0e ("device property: Add support for remote endpoints")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/base/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 240ab5230ff6..e5a58614f8e0 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1341,7 +1341,7 @@ int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index)
 EXPORT_SYMBOL(fwnode_irq_get);
 
 /**
- * device_graph_get_next_endpoint - Get next endpoint firmware node
+ * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
  * @fwnode: Pointer to the parent firmware node
  * @prev: Previous endpoint node or %NULL to get the first
  *
-- 
2.19.1

