Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA24C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B45217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548266296;
	bh=vEpEg/bjJFb1wlQXuItbOlHG7U4r8touM8P9ajxL3eg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Jwfz5gBOzaK1yCQVy8RYaHPtA3++0fo8DwL0mWqi+sAf3bD/VzvUr4SgKHyeTC7S9
	 SRrMjCM/WwQ6aUFQZV8RmqD4C2OjvGzrphTvpGOryvebUtcY9uQNNrcXtG+FMNlqpg
	 qwBwFjesi4M+Mo7CvfgOT6bhBKpDCK9zOyG3rcLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfAWR6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:58:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46416 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfAWR6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=FDVGUh97QlabIV1YIkxnB38rVPUOuVzxvF1p0Xb8kr8=; b=v9xI2SBLXKzb
        6V8rDf1e1/oqByQo+wjqcTGLBeuZWjMt0Uk8OjASAgzqSlgVykZ2+ypKJd2V5D2wvmT5F6+6KzuN4
        kCaazOlBRzzXJnuW3TU8OxgnZ8FXsOXHFgtzqXQGOFK2C2nHoIXQ9xMzq07WRrnt+Ok5YzeloXhRX
        xASAI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmMmn-0006qq-FW; Wed, 23 Jan 2019 17:58:01 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7DF351127ABA; Wed, 23 Jan 2019 17:58:00 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: bcm2835aux: remove unneeded NULL check of devm_clk_get" to the spi tree
In-Reply-To:  <20190123070507.15404-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190123175800.7DF351127ABA@debutante.sirena.org.uk>
Date:   Wed, 23 Jan 2019 17:58:00 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: bcm2835aux: remove unneeded NULL check of devm_clk_get

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

From bfc7af6d6df8d75b9c693b8eb98c21aa75c1e377 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 23 Jan 2019 15:05:07 +0800
Subject: [PATCH] spi: bcm2835aux: remove unneeded NULL check of devm_clk_get

Fix a static code checker warning:
drivers/spi/spi-bcm2835aux.c:460
 bcm2835aux_spi_probe() warn: passing zero to 'PTR_ERR'

In case of error, the function devm_clk_get() returns ERR_PTR()
and not returns NULL.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 671e374e1b01..f7e054848ca5 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -456,7 +456,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	}
 
 	bs->clk = devm_clk_get(&pdev->dev, NULL);
-	if ((!bs->clk) || (IS_ERR(bs->clk))) {
+	if (IS_ERR(bs->clk)) {
 		err = PTR_ERR(bs->clk);
 		dev_err(&pdev->dev, "could not get clk: %d\n", err);
 		goto out_master_put;
-- 
2.20.1

