Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5ACC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A19222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550058835;
	bh=ntfX+re9Z3azblNwKwEcnDYE0QL1h/G/WCKWpQiWbNI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=heOs2j6jYjO/5jWNL24dlHx5I/q3jpG+MB+NM69FtgFUdQ3nkf23Sa8uKUrhbiODT
	 ek8DWVKXb49yNPDsQ2wcLCDc7FtwWratNmsKIoYk8wMOdafVxAAD0y7G4qCtXIVNcg
	 N6BUDhzpJOlyi2n4/bky+oTWR/ytX4Z2f/awI24Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391969AbfBMLxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:53:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49950 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391943AbfBMLxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=b9/ixePSYtIv34D3PsLA1ZwGMGUj1YuG6YECp8w1iXQ=; b=i9N0gYj/efZn
        sRkIijhWpOY5hEAL59DN/8WIOoczLoHRQb59gxabkVDxcG6FLO/CsOjv9hBrPJTxCmMx5HEmxdCFR
        TBtD/Cyz/2FKzof413FMjaUhBecoUAVQmdNiTV6671T6zurimYzQKLCg8Kv5PIuDyLw2IPQZxcl5Y
        AWH2o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtt6p-00046t-4K; Wed, 13 Feb 2019 11:53:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 92B4A1128158; Wed, 13 Feb 2019 11:53:46 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, lgirdwood@gmail.com,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: i2s: Restore support for the secondary PCM" to the asoc tree
In-Reply-To:  <20190212180342.32040-2-s.nawrocki@samsung.com>
X-Patchwork-Hint: ignore
Message-Id: <20190213115346.92B4A1128158@debutante.sirena.org.uk>
Date:   Wed, 13 Feb 2019 11:53:46 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: i2s: Restore support for the secondary PCM

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 7196c64c7d0c6d421c9bb721d8d66c6d0edc5385 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 12 Feb 2019 19:03:22 +0100
Subject: [PATCH] ASoC: samsung: i2s: Restore support for the secondary PCM

This patch introduces again registration of additional platform device as
we still need it for registering the secondary dmaengine PCM component.

This patch in most part is a revert of changes done in commit
be2c92eb64023e ("ASoC: samsung: i2s: Remove virtual device for secondary DAI")

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 52 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 455bc65d115a..cc983afae735 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -109,6 +109,7 @@ static DEFINE_SPINLOCK(lock);
 
 struct samsung_i2s_priv {
 	struct platform_device *pdev;
+	struct platform_device *pdev_sec;
 
 	/* Spinlock protecting access to the device's registers */
 	spinlock_t spinlock;
@@ -1306,6 +1307,34 @@ static int i2s_register_clock_provider(struct platform_device *pdev)
 	return ret;
 }
 
+/* Create platform device for the secondary PCM */
+static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_register_simple("samsung-i2s-sec", -1, NULL, 0);
+	if (!pdev)
+		return -ENOMEM;
+
+	ret = device_attach(&pdev->dev);
+	if (ret < 0) {
+		dev_info(&pdev->dev, "device_attach() failed\n");
+		return ret;
+	}
+
+	priv->pdev_sec = pdev;
+
+	return 0;
+}
+
+static void i2s_delete_secondary_device(struct samsung_i2s_priv *priv)
+{
+	if (priv->pdev_sec) {
+		platform_device_del(priv->pdev_sec);
+		priv->pdev_sec = NULL;
+	}
+}
 static int samsung_i2s_probe(struct platform_device *pdev)
 {
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
@@ -1323,13 +1352,15 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		i2s_dai_data = (struct samsung_i2s_dai_data *)
 				platform_get_device_id(pdev)->driver_data;
 
+	/* Nothing to do if it is the secondary device probe */
+	if (!i2s_dai_data)
+		return 0;
+
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	quirks = np ? i2s_dai_data->quirks : i2s_pdata->type.quirks;
-	quirks &= ~(QUIRK_SEC_DAI | QUIRK_SUPPORTS_IDMA);
-
 	num_dais = (quirks & QUIRK_SEC_DAI) ? 2 : 1;
 	priv->pdev = pdev;
 
@@ -1419,8 +1450,13 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		sec_dai->pri_dai = pri_dai;
 		pri_dai->sec_dai = sec_dai;
 
-		ret = samsung_asoc_dma_platform_register(&pdev->dev,
-					sec_dai->filter, "tx-sec", NULL, NULL);
+		ret = i2s_create_secondary_device(priv);
+		if (ret < 0)
+			goto err_disable_clk;
+
+		ret = samsung_asoc_dma_platform_register(&priv->pdev_sec->dev,
+						sec_dai->filter, "tx-sec", NULL,
+						&pdev->dev);
 		if (ret < 0)
 			goto err_disable_clk;
 
@@ -1455,6 +1491,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 err_disable_clk:
 	clk_disable_unprepare(pri_dai->clk);
+	i2s_delete_secondary_device(priv);
 	return ret;
 }
 
@@ -1463,12 +1500,17 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	struct samsung_i2s_priv *priv = dev_get_drvdata(&pdev->dev);
 	struct i2s_dai *pri_dai = samsung_i2s_get_pri_dai(&pdev->dev);
 
+	/* The secondary device has no driver data assigned */
+	if (!priv)
+		return 0;
+
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	i2s_unregister_clock_provider(pdev);
 	clk_disable_unprepare(pri_dai->clk);
 	pm_runtime_put_noidle(&pdev->dev);
+	i2s_delete_secondary_device(priv);
 
 	return 0;
 }
@@ -1566,6 +1608,8 @@ static const struct platform_device_id samsung_i2s_driver_ids[] = {
 	{
 		.name           = "samsung-i2s",
 		.driver_data	= (kernel_ulong_t)&i2sv3_dai_type,
+	}, {
+		.name           = "samsung-i2s-sec",
 	},
 	{},
 };
-- 
2.20.1

