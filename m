Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4694C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1252087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfARPDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:03:09 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50191 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbfARPDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:03:09 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DA27120898; Fri, 18 Jan 2019 16:03:06 +0100 (CET)
Received: from localhost (alyon-652-1-26-46.w109-213.abo.wanadoo.fr [109.213.9.46])
        by mail.bootlin.com (Postfix) with ESMTPSA id 850402247E;
        Fri, 18 Jan 2019 16:01:50 +0100 (CET)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH] phy: armada375-usb2: switch to SPDX license identifier
Date:   Fri, 18 Jan 2019 16:01:46 +0100
Message-Id: <20190118150146.31590-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/phy/marvell/phy-armada375-usb2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/phy/marvell/phy-armada375-usb2.c b/drivers/phy/marvell/phy-armada375-usb2.c
index 1a3db288c0a9..362c0af71566 100644
--- a/drivers/phy/marvell/phy-armada375-usb2.c
+++ b/drivers/phy/marvell/phy-armada375-usb2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * USB cluster support for Armada 375 platform.
  *
@@ -5,10 +6,6 @@
  *
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2 or later. This program is licensed "as is"
- * without any warranty of any kind, whether express or implied.
- *
  * Armada 375 comes with an USB2 host and device controller and an
  * USB3 controller. The USB cluster control register allows to manage
  * common features of both USB controllers.
-- 
2.20.1

