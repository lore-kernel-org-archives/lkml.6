Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C821C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A3520851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544490983;
	bh=85YMVMhYaOTXlaE/Dxwmmj7lAoowDYKdQM60LQZU8TY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=V8/Jo73aemSV6SUyPGlqbIrW3ijn68W7BbN8Un4lXS/turLEvsklpKvCVeWV7JSN0
	 6Q/64AK39KTlaDoycHQHs5MtLuDrZ7ULo6WOyjRsqLRK7LFJhSLfhCQzm5ROvm0IOW
	 5mighvco24J2YuQXrdcmJXcXJpsghL2zytIEa4+Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A3520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeLKBQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:16:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51192 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbeLKBQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HLeYB78qRjRKsb2QgM8O5Wa4o/mUpnsvaU1+CL8uJNc=; b=Yb2nBpENF2vD
        ZYGfO7YrA2Up9jQH2S+RLOixsTEPS1HTZSKZtYxBBpKPrjSaCJfc87eG2Sae1pT3Hy0lgD4WGwhHy
        btGUY5nPeLVT50NvjY1vMwaQrWokNjFkHpfZS1+U1ncN8cmsIuZOye+su9v55qmmveL4BAiSbEeJ0
        PtN6o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWej-0000M1-De; Tue, 11 Dec 2018 01:16:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1D9F411254C7; Tue, 11 Dec 2018 01:16:13 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: max77686: Let core handle GPIO descriptor" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181211011613.1D9F411254C7@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 01:16:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77686: Let core handle GPIO descriptor

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

From d03c63dbcaa1ee570d0435a7f79c7083ffb59245 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Dec 2018 13:43:43 +0100
Subject: [PATCH] regulator: max77686: Let core handle GPIO descriptor

Use the gpiod_get_from_of_node() rather than the devm_*
version so that the regulator core can handle the lifecycle
of these descriptors.

Fix up the errorpath so that we free this descriptor if
an error occurs in the callback. Rely on the regulator
core to deal with it after this point: a previous patch
fixed up the regulator core to properly dispose any
GPIO descriptors once you call regulator_register().

Fixes: 96392c3d8ca4 ("regulator: max77686: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77686-regulator.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index f5cee1775905..8020eb57374a 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -250,13 +250,13 @@ static int max77686_of_parse_cb(struct device_node *np,
 		struct regulator_config *config)
 {
 	struct max77686_data *max77686 = config->driver_data;
+	int ret;
 
 	switch (desc->id) {
 	case MAX77686_BUCK8:
 	case MAX77686_BUCK9:
 	case MAX77686_LDO20 ... MAX77686_LDO22:
-		config->ena_gpiod = devm_gpiod_get_from_of_node(max77686->dev,
-				np,
+		config->ena_gpiod = gpiod_get_from_of_node(np,
 				"maxim,ena",
 				0,
 				GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
@@ -271,9 +271,13 @@ static int max77686_of_parse_cb(struct device_node *np,
 	if (config->ena_gpiod) {
 		set_bit(desc->id, max77686->gpio_enabled);
 
-		return regmap_update_bits(config->regmap, desc->enable_reg,
-					  desc->enable_mask,
-					  MAX77686_GPIO_CONTROL);
+		ret = regmap_update_bits(config->regmap, desc->enable_reg,
+					 desc->enable_mask,
+					 MAX77686_GPIO_CONTROL);
+		if (ret) {
+			gpiod_put(config->ena_gpiod);
+			config->ena_gpiod = NULL;
+		}
 	}
 
 	return 0;
-- 
2.19.0.rc2

