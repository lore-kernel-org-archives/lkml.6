Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74EBC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826E120880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548678939;
	bh=vZLAiDcQkltVnLoUnE3nNBreZrjrq3PhBNgk31TQ+5Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=DkaJPaEkwGbyzgXZu6mSU7jgA8xCiUKrCPiqdGPhjuzTM6yruNvCdRGPZArlnaihH
	 RsubBDYofE4mb8JxAnE/VJVUt3ScM8tro8TBeKbhkpwBlNUN6JjA9kEgCUk9FBWlF5
	 dwpLYG6Chjcbt4IzttjnqyAiSGwLfw3xcXmTZaFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfA1Mfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:35:37 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42040 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1Mfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sQ8+0y0sQCLkZ4YMPKbZ+r1vtF3pj6RIhvaRRJiz9s4=; b=au98KwBlV3pf
        1JLsFePlg7ECtnM8nFGYLeVY6IHm2xeKyPPpwgFuJ8dmdbH/uTswHSPdTgWJGe2W/8gi50qME98o6
        Ec1irBlRPZdi0kqRVmonjadOzborzdSU+QCXoP86QYbdb498lMC8ZuZIOFpfzPbvC5k/Mc5Lkp2vs
        xGAoE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go68U-0002Sf-W6; Mon, 28 Jan 2019 12:35:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8339B1127D29; Mon, 28 Jan 2019 12:35:34 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: rk808: Update module description to include RK805" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190128123534.8339B1127D29@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 12:35:34 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: rk808: Update module description to include RK805

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

From a7567663bece82798e1c595999948524ac0d521a Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 27 Jan 2019 22:23:44 +0800
Subject: [PATCH] regulator: rk808: Update module description to include RK805

This driver also supports RK805 now.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/rk808-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index c18ed632c95d..08578f6d737d 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1,5 +1,5 @@
 /*
- * Regulator driver for Rockchip RK808/RK818
+ * Regulator driver for Rockchip RK805/RK808/RK818
  *
  * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
  *
@@ -796,7 +796,7 @@ static struct platform_driver rk808_regulator_driver = {
 
 module_platform_driver(rk808_regulator_driver);
 
-MODULE_DESCRIPTION("regulator driver for the RK808/RK818 series PMICs");
+MODULE_DESCRIPTION("regulator driver for the RK805/RK808/RK818 series PMICs");
 MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
 MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
 MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
-- 
2.20.1

