Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D02C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22A820851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544490971;
	bh=5v2cJd3eCYGEmbnwVWJZiu5HQY4EV6fFKraHTs8tgRE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FL/yuH+2Ff3gBlwNGuyo9o070RbxeJPBlgDB+3q75N0Hv4403Zbh+OqXfmsglPDdm
	 C8+Ehk+yzWjdcg1+9u/vBhhz/r+t+Jp4mg/hYzvp80pNQFTth/aZRaXTLC1mxie9Pf
	 ti999yHmYmG5WLMhDh68v3JI5WqQuxybmRl06zjo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22A820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbeLKBQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:16:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50896 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbeLKBQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KfCEJOvtD8Q7R65fY65n2mr5t7NiIihjBcg/AV7VjN4=; b=UKf83ONE/P2Y
        sXxyvJ+9bbjcFzFGUpOON9g+bVFbSAXeZc9OzSv+eji6bZQsFJ2Cd4E8a9obJoiIpu9AGMGr8CmIu
        Nk0U7zqPirxTaQXS3DsDRJuiYI8gIDe3feQDk+3IWx3kDJ1dTrDZi9VpuuZd2D4NIsDIyVYh/m6Vc
        lqCTY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWeZ-0000LN-Mr; Tue, 11 Dec 2018 01:16:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6531111254C7; Tue, 11 Dec 2018 01:16:03 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: s5m8767: Hand over GPIO to regulator core" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181211011603.6531111254C7@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 01:16:03 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: s5m8767: Hand over GPIO to regulator core

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

From 1f5163fcf1523e2890d3e8909daed777661765ab Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Dec 2018 13:43:49 +0100
Subject: [PATCH] regulator: s5m8767: Hand over GPIO to regulator core

The GPIO descriptors used by the S5M8767 driver are retrieved
during probe() and it is really helpful to have those under
devres management because of all the errorpaths in the
intialization.

Using the new dev_gpiod_unhinge() call we can remove the
devres management of the descriptor right before handing
it over to the regulators core.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/s5m8767.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 654f65abcb5a..b581f01f3395 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -956,10 +956,17 @@ static int s5m8767_pmic_probe(struct platform_device *pdev)
 		config.regmap = iodev->regmap_pmic;
 		config.of_node = pdata->regulators[i].reg_node;
 		config.ena_gpiod = NULL;
-		if (pdata->regulators[i].ext_control_gpiod)
+		if (pdata->regulators[i].ext_control_gpiod) {
+			/* Assigns config.ena_gpiod */
 			s5m8767_regulator_config_ext_control(s5m8767,
 					&pdata->regulators[i], &config);
 
+			/*
+			 * Hand the GPIO descriptor management over to the
+			 * regulator core, remove it from devres management.
+			 */
+			devm_gpiod_unhinge(s5m8767->dev, config.ena_gpiod);
+		}
 		rdev = devm_regulator_register(&pdev->dev, &regulators[id],
 						  &config);
 		if (IS_ERR(rdev)) {
-- 
2.19.0.rc2

