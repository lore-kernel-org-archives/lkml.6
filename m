Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCCBECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E818208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E818208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbeGMQCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:02:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37745 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729736AbeGMQCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:02:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 896E5207AB; Fri, 13 Jul 2018 17:47:28 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 577B520714;
        Fri, 13 Jul 2018 17:47:28 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     kishon@ti.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] phy: berlin-usb: switch to SPDX identifier
Date:   Fri, 13 Jul 2018 17:47:03 +0200
Message-Id: <20180713154704.16769-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the appropriate SPDX license identifier and drop the license text.
This patch is only cosmetic.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/phy/marvell/phy-berlin-usb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/phy/marvell/phy-berlin-usb.c b/drivers/phy/marvell/phy-berlin-usb.c
index 8f2b5cae360f..a43df63007c5 100644
--- a/drivers/phy/marvell/phy-berlin-usb.c
+++ b/drivers/phy/marvell/phy-berlin-usb.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014 Marvell Technology Group Ltd.
  *
  * Antoine Tenart <antoine.tenart@free-electrons.com>
  * Jisheng Zhang <jszhang@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/io.h>
-- 
2.17.1

