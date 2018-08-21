Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2D2C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0901F21837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0901F21837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeHVBZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:25:26 -0400
Received: from sauhun.de ([88.99.104.3]:45332 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbeHVBYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:24:49 -0400
Received: from localhost (p54B3375F.dip0.t-ipconnect.de [84.179.55.95])
        by pokefinder.org (Postfix) with ESMTPSA id 986392DA3F2;
        Wed, 22 Aug 2018 00:02:51 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] phy: renesas: use SPDX identifier for Renesas drivers
Date:   Wed, 22 Aug 2018 00:02:20 +0200
Message-Id: <20180821220233.9202-8-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

To be applied individually per subsystem tree. Morimoto-san, could you maybe
ack this with your Renesas address?

 drivers/phy/renesas/phy-rcar-gen2.c      | 5 +----
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 5 +----
 drivers/phy/renesas/phy-rcar-gen3-usb3.c | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen2.c b/drivers/phy/renesas/phy-rcar-gen2.c
index 97d4dd6ea924..72eeb066912d 100644
--- a/drivers/phy/renesas/phy-rcar-gen2.c
+++ b/drivers/phy/renesas/phy-rcar-gen2.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car Gen2 PHY driver
  *
  * Copyright (C) 2014 Renesas Solutions Corp.
  * Copyright (C) 2014 Cogent Embedded, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index fb8f05e39cf7..3d57ea1e1437 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car Gen3 for USB2.0 PHY driver
  *
@@ -6,10 +7,6 @@
  * This is based on the phy-rcar-gen2 driver:
  * Copyright (C) 2014 Renesas Solutions Corp.
  * Copyright (C) 2014 Cogent Embedded, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/extcon-provider.h>
diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb3.c b/drivers/phy/renesas/phy-rcar-gen3-usb3.c
index 88c83c9b8ff9..566b4cf4ff38 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb3.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb3.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car Gen3 for USB3.0 PHY driver
  *
  * Copyright (C) 2017 Renesas Electronics Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/clk.h>
-- 
2.11.0

