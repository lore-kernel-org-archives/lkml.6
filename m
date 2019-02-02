Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57466C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 23:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CB721773
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 23:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="mhtTxBwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfBBXUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 18:20:04 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:53020 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfBBXUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 18:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549149599; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=b0d38BwMGpDc67q2oujUEIMCCcbjv5EknBWgAlGcsZo=;
        b=mhtTxBwObmtt+VSfs1JHqWalD5wSAi4wP4EpUKuqiBPwVqdYY9rwaAbuq1lKxgLeBNoJr1
        XhjRifYbFjp6akC/6cwqtAyoJe9Q94NFrIJ9bqLDiHA2K4Dqur37dI7g1CQRbkslrHlArF
        LPb/R6L+S+eXOIhjY3xr51jbD3bNTg8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/9] mtd: rawnand: jz4780: Use SPDX license notifiers
Date:   Sat,  2 Feb 2019 20:19:20 -0300
Message-Id: <20190202231926.2444-4-paul@crapouillou.net>
In-Reply-To: <20190202231926.2444-1-paul@crapouillou.net>
References: <20190202231926.2444-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPDX license notifiers instead of GPLv2 license text in the headers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---

Changes:

v2: No changes

 drivers/mtd/nand/raw/ingenic/jz4780_bch.c  | 5 +----
 drivers/mtd/nand/raw/ingenic/jz4780_bch.h  | 5 +----
 drivers/mtd/nand/raw/ingenic/jz4780_nand.c | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_bch.c b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
index 7201827809e9..7e4e5e627603 100644
--- a/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
+++ b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * JZ4780 BCH controller
  *
  * Copyright (c) 2015 Imagination Technologies
  * Author: Alex Smith <alex.smith@imgtec.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
  */
 
 #include <linux/bitops.h>
diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_bch.h b/drivers/mtd/nand/raw/ingenic/jz4780_bch.h
index bf4718088a3a..451e0c770160 100644
--- a/drivers/mtd/nand/raw/ingenic/jz4780_bch.h
+++ b/drivers/mtd/nand/raw/ingenic/jz4780_bch.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * JZ4780 BCH controller
  *
  * Copyright (c) 2015 Imagination Technologies
  * Author: Alex Smith <alex.smith@imgtec.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
  */
 
 #ifndef __DRIVERS_MTD_NAND_JZ4780_BCH_H__
diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_nand.c b/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
index 22e58975f0d5..7f55358b860f 100644
--- a/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * JZ4780 NAND driver
  *
  * Copyright (c) 2015 Imagination Technologies
  * Author: Alex Smith <alex.smith@imgtec.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
  */
 
 #include <linux/delay.h>
-- 
2.20.1

