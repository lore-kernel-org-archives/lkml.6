Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DACEECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009C020852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mVg1ovD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009C020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388925AbeGWSLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:11:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45396 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388628AbeGWSLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=kaRebApwsm0Oph4L+tR949m78bTZqIlnBOrRTqDBKz4=; b=mVg1ovD17xEQ
        QH4CQhdvlB/1c3CMx8amlk4nRBDF9SI/rhT19WwYTdYHGKa8JzgDkfC1t+6AxsifeXZibKGcsmGqi
        3A7i88sboXF8GzgWvNqNyv22rUZ3J67LOeCFaQdSXb0xkt10nyzWHSsvZQJcoJ+rVZqM33rCNBTEQ
        Hppos=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fheKl-0004Nu-6p; Mon, 23 Jul 2018 17:09:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DF633112387B; Mon, 23 Jul 2018 18:09:18 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: sccb: fix typo and sort headers alphabetically" to the regmap tree
In-Reply-To: 
Message-Id: <20180723170918.DF633112387B@debutante.sirena.org.uk>
Date:   Mon, 23 Jul 2018 18:09:18 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: sccb: fix typo and sort headers alphabetically

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 75eb3a67a29e9f87c07c8bd184a7ed4274a58ef0 Mon Sep 17 00:00:00 2001
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 23 Jul 2018 00:45:46 +0900
Subject: [PATCH] regmap: sccb: fix typo and sort headers alphabetically

Fix typos 's/wit/with/' in the comments and sort headers alphabetically
in order to avoid duplicate includes in future.

Fixes: bcf7eac3d97f ("regmap: add SCCB support")
Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-sccb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-sccb.c b/drivers/base/regmap/regmap-sccb.c
index b6eb876ea819..597042e2d009 100644
--- a/drivers/base/regmap/regmap-sccb.c
+++ b/drivers/base/regmap/regmap-sccb.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 // Register map access API - SCCB support
 
-#include <linux/regmap.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 
 #include "internal.h"
 
@@ -29,7 +29,7 @@ static bool sccb_is_available(struct i2c_adapter *adap)
 
 /**
  * regmap_sccb_read - Read data from SCCB slave device
- * @context: Device that will be interacted wit
+ * @context: Device that will be interacted with
  * @reg: Register to be read from
  * @val: Pointer to store read value
  *
@@ -65,7 +65,7 @@ static int regmap_sccb_read(void *context, unsigned int reg, unsigned int *val)
 
 /**
  * regmap_sccb_write - Write data to SCCB slave device
- * @context: Device that will be interacted wit
+ * @context: Device that will be interacted with
  * @reg: Register to write to
  * @val: Value to be written
  *
-- 
2.18.0

