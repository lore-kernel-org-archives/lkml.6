Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CFCC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9469E20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544491027;
	bh=tJj4lPKOqWi3q3yIFZW2Iv9qlvLOuTW3A0Oa9y4N/PI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=iyZqAHXpe2jjdcVNwokNCmupaaHsLK8qRp0iFEBfwTWsivSRUB0+4jUYffM/yMrS2
	 8DURpiESxmYvN1RWVWZwqgTiZIEwfs/+ODo+d+KGNnDQPPsplmekIpLWRdBi3fa30d
	 N0DtxELyMHVQ+2l+G77LeiGn+KWmcddhNvlyZyj0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9469E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeLKBQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:16:17 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50964 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbeLKBQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mcbjoMALSqFBxYomWWgXcxG7FVxeGlhMttcb3tzfJ9M=; b=JRfyiVa7I1Wn
        BrdfWplSuuxi0GxQj2uFcT4KHLmEIeFrK3kqbo0AZ7septDw3Akm+AmG+VdHtPN95Bef/fE0isvOi
        8+n0UjDtlr1UimFJiBHSnOgbBZcatW8DPqjUjevLnO/1eEoQY69vD4QSg8SLN5JY+0MKYkcNqaCPN
        2zW1E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWec-0000La-Vo; Tue, 11 Dec 2018 01:16:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9DCA211254C7; Tue, 11 Dec 2018 01:16:06 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max8973: Let core handle GPIO descriptor" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181211011606.9DCA211254C7@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 01:16:06 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max8973: Let core handle GPIO descriptor

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

From 48bd226f0ab3b91a837213cbfa15319f377effad Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Dec 2018 13:43:47 +0100
Subject: [PATCH] regulator: max8973: Let core handle GPIO descriptor

The probe path of this driver is a bit complex: sometimes the
GPIO descriptor is passed to the regulator core, sometimes
it is not.

To handle it in a simple way: stick with the devm_* resource
management and unhinge the GPIO descriptor devres handling
right before passing it to the regulator core, if we pass it
to the regulator core.

Fixes: e7d2be696faa ("regulator: max8973: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max8973-regulator.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index e7a58b509032..9aee1444181d 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -808,7 +808,13 @@ static int max8973_probe(struct i2c_client *client,
 	config.of_node = client->dev.of_node;
 	config.regmap = max->regmap;
 
-	/* Register the regulators */
+	/*
+	 * Register the regulators
+	 * Turn the GPIO descriptor over to the regulator core for
+	 * lifecycle management if we pass an ena_gpiod.
+	 */
+	if (config.ena_gpiod)
+		devm_gpiod_unhinge(&client->dev, config.ena_gpiod);
 	rdev = devm_regulator_register(&client->dev, &max->desc, &config);
 	if (IS_ERR(rdev)) {
 		ret = PTR_ERR(rdev);
-- 
2.19.0.rc2

