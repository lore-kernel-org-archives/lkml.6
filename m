Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD2FECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2404D2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="sUFV3wXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2404D2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeJTANZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:13:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41434 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeJTANZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=pG3O/74d/YKnt8AARAlNvwHtk4Kmy7vx5sPn6OPv1oM=; b=sUFV3wXWI63B
        VBWFk62RhpKhbG9Vl0dSqW0NLvARXChYZGhBa6hgYVmnPSdMgxt205CPA3YwPzU9z6yql5kMygAPY
        Slr8GEf2R9VDm10n2xgWZkRQoJwR2a6KB5jCkEGQwuQDMQ1JSzOZB4fWIx7T9yFShfEoj69tdigwq
        3f/g0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDXIJ-0000PD-0J; Fri, 19 Oct 2018 16:06:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B5A0E1122548; Fri, 19 Oct 2018 17:06:34 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lochnagar: Use a consisent comment style for SPDX header" to the regulator tree
In-Reply-To: 
Message-Id: <20181019160634.B5A0E1122548@debutante.sirena.org.uk>
Date:   Fri, 19 Oct 2018 17:06:34 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lochnagar: Use a consisent comment style for SPDX header

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

From d8b2a8e9c06bc389659716e81d1c2b1f147611d1 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Fri, 19 Oct 2018 13:44:38 +0100
Subject: [PATCH] regulator: lochnagar: Use a consisent comment style for SPDX
 header

Update the rest of the comment at the start of the file to also use C++
style comments to match the required style of the SPDX header.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lochnagar-regulator.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index 54d791d20408..2b5073b9ff86 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Lochnagar regulator driver
- *
- * Copyright (c) 2017-2018 Cirrus Logic, Inc. and
- *                         Cirrus Logic International Semiconductor Ltd.
- *
- * Author: Charles Keepax <ckeepax@opensource.cirrus.com>
- */
+//
+// Lochnagar regulator driver
+//
+// Copyright (c) 2017-2018 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
+//
+// Author: Charles Keepax <ckeepax@opensource.cirrus.com>
 
 #include <linux/bitops.h>
 #include <linux/device.h>
-- 
2.19.0.rc2

