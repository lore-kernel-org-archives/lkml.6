Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E6FC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91770216B7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="kCnP55WR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91770216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeHHN1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:27:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35182 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbeHHN1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DKWNj616dCfKeYNCzDts1vb2dOlyVJQD2Vvz2OXjG5w=; b=kCnP55WRFjeF
        x0U6wQf9pJMfJ0Q1AkoCoXPzL4RvvQhnga2z1xfoYQ0kgYMoz4Ag4ahmvqwni32/xAXCsOejntJ41
        JxlUaEm8tl1Oc2IIj3s9tbSG2BOuh+JqMjvJf5AB3ZcE4JXgvFqC4uxOicNcoCpkoMrZl4lGmIwvK
        ydGbo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fnMK2-0001tK-My; Wed, 08 Aug 2018 11:08:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 70A601124340; Wed,  8 Aug 2018 12:08:10 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: samsung: Add SPDX license identifiers" to the regulator tree
In-Reply-To: 
Message-Id: <20180808110810.70A601124340@debutante.sirena.org.uk>
Date:   Wed,  8 Aug 2018 12:08:10 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: samsung: Add SPDX license identifiers

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From 4f3fb287358337d739bd2186769a8c74aae19ac6 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 7 Aug 2018 18:18:26 +0200
Subject: [PATCH] regulator: samsung: Add SPDX license identifiers

Replace GPL v2.0+ license statements with SPDX license
identifiers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/s2mpa01.c | 14 ++++----------
 drivers/regulator/s2mps11.c | 21 ++++-----------------
 drivers/regulator/s5m8767.c | 16 ++++------------
 3 files changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/regulator/s2mpa01.c b/drivers/regulator/s2mpa01.c
index 48f0ca90743c..095d25f3d2ea 100644
--- a/drivers/regulator/s2mpa01.c
+++ b/drivers/regulator/s2mpa01.c
@@ -1,13 +1,7 @@
-/*
- * Copyright (c) 2013 Samsung Electronics Co., Ltd
- *		http://www.samsung.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2013 Samsung Electronics Co., Ltd
+//		http://www.samsung.com
 
 #include <linux/bug.h>
 #include <linux/err.h>
diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index d1207ec683db..5bb6f4ca48db 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -1,20 +1,7 @@
-/*
- * s2mps11.c
- *
- * Copyright (c) 2012-2014 Samsung Electronics Co., Ltd
- *              http://www.samsung.com
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2012-2014 Samsung Electronics Co., Ltd
+//              http://www.samsung.com
 
 #include <linux/bug.h>
 #include <linux/err.h>
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 0cbc980753c2..667d16dc83ce 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -1,15 +1,7 @@
-/*
- * s5m8767.c
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd
- *              http://www.samsung.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2011 Samsung Electronics Co., Ltd
+//              http://www.samsung.com
 
 #include <linux/err.h>
 #include <linux/of_gpio.h>
-- 
2.18.0

