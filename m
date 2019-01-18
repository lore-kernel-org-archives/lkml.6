Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040D5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74E92087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="CYvxr3lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfARBHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:07:04 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:32936 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfARBHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547773621; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SGmuj7JI+VAz5QLPlw+lRrE4ntToSIhZIpSRdsrvRZU=;
        b=CYvxr3lwNQ5gMJc/3mDlWSWSb1ljgh3RgpDcbbWrLREUSmKBuJ9/9kr2hNJp8TSnDSwaGI
        INA/qW2/16he0Dh+BBSLZKEdPrJcwf7Frx2E0IZ7PwA04lMBunSVcPHStOOUMPhEflCco6
        CnQqiimemizfkKLL+gdVSd9u96kqNd8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/8] mtd: rawnand: jz4780: Use SPDX license notifiers
Date:   Thu, 17 Jan 2019 22:06:29 -0300
Message-Id: <20190118010634.27399-3-paul@crapouillou.net>
In-Reply-To: <20190118010634.27399-1-paul@crapouillou.net>
References: <20190118010634.27399-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPDX license notifiers instead of GPLv2 license text in the headers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mtd/nand/raw/jz4780_bch.c  | 5 +----
 drivers/mtd/nand/raw/jz4780_bch.h  | 5 +----
 drivers/mtd/nand/raw/jz4780_nand.c | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/jz4780_bch.c b/drivers/mtd/nand/raw/jz4780_bch.c
index 7201827809e9..7e4e5e627603 100644
--- a/drivers/mtd/nand/raw/jz4780_bch.c
+++ b/drivers/mtd/nand/raw/jz4780_bch.c
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
diff --git a/drivers/mtd/nand/raw/jz4780_bch.h b/drivers/mtd/nand/raw/jz4780_bch.h
index bf4718088a3a..451e0c770160 100644
--- a/drivers/mtd/nand/raw/jz4780_bch.h
+++ b/drivers/mtd/nand/raw/jz4780_bch.h
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
diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index 22e58975f0d5..7f55358b860f 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
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
2.11.0

