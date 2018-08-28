Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CCEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83518205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="P9LOms+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83518205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeH2BCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:02:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47892 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbeH2BCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GWgWn/T48xLftNcdv8LIhiMqwh0YY3fj2SxmwscbX8U=; b=P9LOms+rFglL
        LCs1qXAq9FdcvHu4/k+ZyB9LJ/c2cw2NecxQzOvQ5X543OuacT5NXWcplGMBRdXsjCtr9nA87uMz1
        6iYj7auo8bYJJknQhwDWF7toUHoyu8LnL9h50EDNl4VzhQ4TtR1sBW46m0dIVl40Mf1M8I2rTIq61
        0BRUk=;
Received: from 94.197.121.204.threembb.co.uk ([94.197.121.204] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fulE2-0007lz-05; Tue, 28 Aug 2018 21:08:34 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8314F4400A4; Tue, 28 Aug 2018 21:59:36 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: use SPDX identifier for Renesas drivers" to the spi tree
In-Reply-To:  <20180821220233.9202-11-wsa+renesas@sang-engineering.com>
Message-Id: <20180828205936.8314F4400A4@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:59:36 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: use SPDX identifier for Renesas drivers

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 9135bac325052be8a131a8a75bbcc583451ebb1f Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Wed, 22 Aug 2018 00:02:23 +0200
Subject: [PATCH] spi: use SPDX identifier for Renesas drivers

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c     | 10 +---------
 drivers/spi/spi-sh-hspi.c  | 12 ++----------
 drivers/spi/spi-sh-msiof.c |  6 +-----
 drivers/spi/spi-sh.c       | 12 ++----------
 4 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 95dc4d78618d..018dec2fac4b 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH RSPI driver
  *
@@ -6,15 +7,6 @@
  *
  * Based on spi-sh.c:
  * Copyright (C) 2011 Renesas Solutions Corp.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 20e800e70442..dc0926e43665 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SuperH HSPI bus driver
  *
@@ -7,15 +8,6 @@
  * Based on pxa2xx_spi.c:
  * Copyright (C) 2011 Renesas Solutions Corp.
  * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/clk.h>
@@ -316,6 +308,6 @@ static struct platform_driver hspi_driver = {
 module_platform_driver(hspi_driver);
 
 MODULE_DESCRIPTION("SuperH HSPI bus driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
 MODULE_ALIAS("platform:sh-hspi");
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 539d6d1a277a..3eb7bcd33f22 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SuperH MSIOF SPI Master Interface
  *
  * Copyright (c) 2009 Magnus Damm
  * Copyright (C) 2014 Renesas Electronics Corporation
  * Copyright (C) 2014-2017 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <linux/bitmap.h>
diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 50e0ea9acf8b..f1ee58208216 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH SPI bus driver
  *
@@ -5,15 +6,6 @@
  *
  * Based on pxa2xx_spi.c:
  * Copyright (C) 2005 Stephen Street / StreetFire Sound Labs
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
@@ -522,6 +514,6 @@ static struct platform_driver spi_sh_driver = {
 module_platform_driver(spi_sh_driver);
 
 MODULE_DESCRIPTION("SH SPI bus driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Yoshihiro Shimoda");
 MODULE_ALIAS("platform:sh_spi");
-- 
2.18.0

