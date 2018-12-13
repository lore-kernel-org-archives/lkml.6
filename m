Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE06C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A21820851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544702957;
	bh=2K92L8lAFPTKUgUTivMAkgAoKtQ3ZvLk1FhWZscbgEg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=QCkr42I55qsV37OIshU9a0De7hZB9mtjH7O6rv7PpIIf8+dYgLKPbPrXHAilZocRf
	 hZ0XUbJ+5wcYzLjxPz5WzWW2dJIMek5g3oal34lfww8hXCgeRcRblLTrLpBYz0UmNG
	 MywYZXZKIM3v5iTjt6iCS+pnVDziqvWwtGOWl5tU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A21820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeLMMJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:09:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50320 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbeLMMJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=IgkGwTZutA+TuWgVOlX/WYojg1fRC+NZuHvCX/Dk9AY=; b=Ly5djVz2Vd5H
        nsfKBBVY5OkicczI1j5Pvy8h+BsUi33mB3cZjB7vy/C2ZuTPh62kZBXaBcg3zMsO8Lbqdw8Jet78b
        6XyQ7cRVb/NTGZubat8Qd9cztQ7aLWycbpJe6vBdOJIjrgr1xW9cR2MasHeGkHh3b6xUwyY3002Ld
        +5FGo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXPnh-0000zT-S3; Thu, 13 Dec 2018 12:09:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8502211254D1; Thu, 13 Dec 2018 12:09:09 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: wm8994: Rely on core to handle GPIO descriptor" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181213120909.8502211254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 12:09:09 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm8994: Rely on core to handle GPIO descriptor

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

From daa531db8a09dc00084a6030c81f2555a8de70ac Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Dec 2018 10:53:18 +0100
Subject: [PATCH] regulator: wm8994: Rely on core to handle GPIO descriptor

After making sure that the regulator core always take over
handling of the GPIO descriptors, the gpiod_put()
on the errorpath of the wm8994 driver becomes redundant.

Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/wm8994-regulator.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index 46e6b4ee1491..38928cdcb6e6 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -172,6 +172,11 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 		ldo->init_data = *pdata->ldo[id].init_data;
 	}
 
+	/*
+	 * At this point the GPIO descriptor is handled over to the
+	 * regulator core and we need not worry about it on the
+	 * error path.
+	 */
 	ldo->regulator = devm_regulator_register(&pdev->dev,
 						 &wm8994_ldo_desc[id],
 						 &config);
@@ -179,16 +184,12 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
 		ret = PTR_ERR(ldo->regulator);
 		dev_err(wm8994->dev, "Failed to register LDO%d: %d\n",
 			id + 1, ret);
-		goto err;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, ldo);
 
 	return 0;
-
-err:
-	gpiod_put(gpiod);
-	return ret;
 }
 
 static struct platform_driver wm8994_ldo_driver = {
-- 
2.19.0.rc2

