Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2118EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92B4206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549990737;
	bh=6WnqF/fdFoI5rg4rvQMrMBC9gJJ+bebp1ZjRpvjuWE4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Ny6+Ohri1dcCbWocOAwuFREELlsuM1hZTmN/vvMiXd6AGBWMBh2Qu+LYpQ2OtBdWw
	 O1dXUdWfnJX/pCcA+YEeQoyM0iCQMZkEVDP2O9E49PqG5BzWPgHIlNrGNZnAfBCAKZ
	 aLdN7C2SpZA1cGgwtjsl/MSb9KGXDoMgQhIZh7QM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfBLQ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:58:55 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36224 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfBLQ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GdTTxOmrYcPAB4VskWyGWmr7Ebj6D0e5wER9lhHsr3I=; b=dfTBQbkIE6nP
        7Yz5aaH4pdUD07Z+mtPzsoOyW1HH7qgXTr8aAyThxXppLfN5Jysq6Pck5sJDPoHVqW2n06r6DmNEQ
        3yJle/tTsMOXYFxUtTe9N6yTQDJfftwQKwVv+B4CYpW5p3lyMvTYH5NuRF8tYs15IIrLMEJiKkIY8
        RK1Nc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtbOT-0005hw-K0; Tue, 12 Feb 2019 16:58:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2EC401128113; Tue, 12 Feb 2019 16:58:49 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, lgirdwood@gmail.com,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: i2s: Convert to single component with multiple DAIs" to the asoc tree
In-Reply-To:  <20190207170028.720-6-s.nawrocki@samsung.com>
X-Patchwork-Hint: ignore
Message-Id: <20190212165849.2EC401128113@debutante.sirena.org.uk>
Date:   Tue, 12 Feb 2019 16:58:49 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: i2s: Convert to single component with multiple DAIs

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

From a404b72d2bdd45878e1441650967a75452d5e420 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 7 Feb 2019 18:00:13 +0100
Subject: [PATCH] ASoC: samsung: i2s: Convert to single component with multiple
 DAIs

This patch includes minimal changes as a prerequisite for adding support
for the Exynos secondary I2S interface as second DAI of the I2S component.
Doing it that way allows to avoid problems as indicated in commmit
6b01e0365b1689 ("ASoC: samsung: i2s: disable secondary DAI until it gets fixed")

The samsung_i2s_get_pri_dai() helper added in this patch is temporary and
will be removed in one of subsequent patches.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 192 ++++++++++++++++++++++++----------------
 1 file changed, 115 insertions(+), 77 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index efc8704d36e3..455bc65d115a 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -34,6 +34,9 @@
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 
+#define SAMSUNG_I2S_ID_PRIMARY		1
+#define SAMSUNG_I2S_ID_SECONDARY	2
+
 struct samsung_i2s_variant_regs {
 	unsigned int	bfs_off;
 	unsigned int	rfs_off;
@@ -79,8 +82,10 @@ struct i2s_dai {
 #define DAI_OPENED	(1 << 0) /* Dai is opened */
 #define DAI_MANAGER	(1 << 1) /* Dai is the manager */
 	unsigned mode;
+
 	/* Driver for this DAI */
-	struct snd_soc_dai_driver i2s_dai_drv;
+	struct snd_soc_dai_driver *drv;
+
 	/* DMA parameters */
 	struct snd_dmaengine_dai_dma_data dma_playback;
 	struct snd_dmaengine_dai_dma_data dma_capture;
@@ -92,8 +97,6 @@ struct i2s_dai {
 	u32	suspend_i2spsr;
 	const struct samsung_i2s_variant_regs *variant_regs;
 
-	/* Spinlock protecting access to the device's registers */
-	spinlock_t spinlock;
 	spinlock_t *lock;
 
 	/* Below fields are only valid if this is the primary FIFO */
@@ -104,10 +107,29 @@ struct i2s_dai {
 /* Lock for cross i/f checks */
 static DEFINE_SPINLOCK(lock);
 
-/* If this is the 'overlay' stereo DAI */
+struct samsung_i2s_priv {
+	struct platform_device *pdev;
+
+	/* Spinlock protecting access to the device's registers */
+	spinlock_t spinlock;
+
+	/* CPU DAIs and their corresponding drivers */
+	struct i2s_dai *dai;
+	struct snd_soc_dai_driver *dai_drv;
+	int num_dais;
+};
+
+struct i2s_dai *samsung_i2s_get_pri_dai(struct device *dev)
+{
+	struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
+
+	return &priv->dai[SAMSUNG_I2S_ID_PRIMARY - 1];
+}
+
+/* Returns true if this is the 'overlay' stereo DAI */
 static inline bool is_secondary(struct i2s_dai *i2s)
 {
-	return i2s->pri_dai ? true : false;
+	return i2s->drv->id == SAMSUNG_I2S_ID_SECONDARY;
 }
 
 /* If operating in SoC-Slave mode */
@@ -202,7 +224,9 @@ static inline bool any_active(struct i2s_dai *i2s)
 
 static inline struct i2s_dai *to_info(struct snd_soc_dai *dai)
 {
-	return snd_soc_dai_get_drvdata(dai);
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
+
+	return &priv->dai[dai->id - 1];
 }
 
 static inline bool is_opened(struct i2s_dai *i2s)
@@ -1059,7 +1083,7 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 
 static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 {
-	struct i2s_dai *i2s = snd_soc_dai_get_drvdata(dai);
+	struct i2s_dai *i2s = to_info(dai);
 	unsigned long flags;
 
 	pm_runtime_get_sync(dai->dev);
@@ -1096,47 +1120,63 @@ static const struct snd_soc_component_driver samsung_i2s_component = {
 					SNDRV_PCM_FMTBIT_S16_LE | \
 					SNDRV_PCM_FMTBIT_S24_LE)
 
-static struct i2s_dai *i2s_alloc_dai(struct platform_device *pdev,
-				const struct samsung_i2s_dai_data *i2s_dai_data,
-				bool sec)
+static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
+			  const struct samsung_i2s_dai_data *i2s_dai_data,
+			  int num_dais)
 {
-	struct i2s_dai *i2s;
-
-	i2s = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dai), GFP_KERNEL);
-	if (i2s == NULL)
-		return NULL;
-
-	i2s->pdev = pdev;
-	i2s->pri_dai = NULL;
-	i2s->sec_dai = NULL;
-	i2s->i2s_dai_drv.id = 1;
-	i2s->i2s_dai_drv.symmetric_rates = 1;
-	i2s->i2s_dai_drv.probe = samsung_i2s_dai_probe;
-	i2s->i2s_dai_drv.remove = samsung_i2s_dai_remove;
-	i2s->i2s_dai_drv.ops = &samsung_i2s_dai_ops;
-	i2s->i2s_dai_drv.suspend = i2s_suspend;
-	i2s->i2s_dai_drv.resume = i2s_resume;
-	i2s->i2s_dai_drv.playback.channels_min = 1;
-	i2s->i2s_dai_drv.playback.channels_max = 2;
-	i2s->i2s_dai_drv.playback.rates = i2s_dai_data->pcm_rates;
-	i2s->i2s_dai_drv.playback.formats = SAMSUNG_I2S_FMTS;
-
-	if (!sec) {
-		i2s->i2s_dai_drv.name = SAMSUNG_I2S_DAI;
-		i2s->i2s_dai_drv.capture.channels_min = 1;
-		i2s->i2s_dai_drv.capture.channels_max = 2;
-		i2s->i2s_dai_drv.capture.rates = i2s_dai_data->pcm_rates;
-		i2s->i2s_dai_drv.capture.formats = SAMSUNG_I2S_FMTS;
-	} else {
-		i2s->i2s_dai_drv.name = SAMSUNG_I2S_DAI_SEC;
+	static const char *dai_names[] = { "samsung-i2s", "samsung-i2s-sec" };
+	struct snd_soc_dai_driver *dai_drv;
+	struct i2s_dai *dai;
+	int i;
+
+	priv->dai = devm_kcalloc(&priv->pdev->dev, num_dais,
+				     sizeof(*dai), GFP_KERNEL);
+	if (!priv->dai)
+		return -ENOMEM;
+
+	priv->dai_drv = devm_kcalloc(&priv->pdev->dev, num_dais,
+				     sizeof(*dai_drv), GFP_KERNEL);
+	if (!priv->dai_drv)
+		return -ENOMEM;
+
+	for (i = 0; i < num_dais; i++) {
+		dai_drv = &priv->dai_drv[i];
+
+		dai_drv->probe = samsung_i2s_dai_probe;
+		dai_drv->remove = samsung_i2s_dai_remove;
+		dai_drv->suspend = i2s_suspend;
+		dai_drv->resume = i2s_resume;
+
+		dai_drv->symmetric_rates = 1;
+		dai_drv->ops = &samsung_i2s_dai_ops;
+
+		dai_drv->playback.channels_min = 1;
+		dai_drv->playback.channels_max = 2;
+		dai_drv->playback.rates = i2s_dai_data->pcm_rates;
+		dai_drv->playback.formats = SAMSUNG_I2S_FMTS;
+
+		dai_drv->id = i + 1;
+		dai_drv->name = dai_names[i];
+
+		priv->dai[i].drv = &priv->dai_drv[i];
+		priv->dai[i].pdev = priv->pdev;
 	}
-	return i2s;
+
+	/* Initialize capture only for the primary DAI */
+	dai_drv = &priv->dai_drv[SAMSUNG_I2S_ID_PRIMARY - 1];
+
+	dai_drv->capture.channels_min = 1;
+	dai_drv->capture.channels_max = 2;
+	dai_drv->capture.rates = i2s_dai_data->pcm_rates;
+	dai_drv->capture.formats = SAMSUNG_I2S_FMTS;
+
+	return 0;
 }
 
 #ifdef CONFIG_PM
 static int i2s_runtime_suspend(struct device *dev)
 {
-	struct i2s_dai *i2s = dev_get_drvdata(dev);
+	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 
 	i2s->suspend_i2smod = readl(i2s->addr + I2SMOD);
 	i2s->suspend_i2scon = readl(i2s->addr + I2SCON);
@@ -1151,7 +1191,7 @@ static int i2s_runtime_suspend(struct device *dev)
 
 static int i2s_runtime_resume(struct device *dev)
 {
-	struct i2s_dai *i2s = dev_get_drvdata(dev);
+	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 	int ret;
 
 	ret = clk_prepare_enable(i2s->clk);
@@ -1186,7 +1226,7 @@ static void i2s_unregister_clocks(struct i2s_dai *i2s)
 
 static void i2s_unregister_clock_provider(struct platform_device *pdev)
 {
-	struct i2s_dai *i2s = dev_get_drvdata(&pdev->dev);
+	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(&pdev->dev);
 
 	of_clk_del_provider(pdev->dev.of_node);
 	i2s_unregister_clocks(i2s);
@@ -1194,11 +1234,12 @@ static void i2s_unregister_clock_provider(struct platform_device *pdev)
 
 static int i2s_register_clock_provider(struct platform_device *pdev)
 {
+
 	const char * const i2s_clk_desc[] = { "cdclk", "rclk_src", "prescaler" };
 	const char *clk_name[2] = { "i2s_opclk0", "i2s_opclk1" };
 	const char *p_names[2] = { NULL };
 	struct device *dev = &pdev->dev;
-	struct i2s_dai *i2s = dev_get_drvdata(dev);
+	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 	const struct samsung_i2s_variant_regs *reg_info = i2s->variant_regs;
 	const char *i2s_clk_name[ARRAY_SIZE(i2s_clk_desc)];
 	struct clk *rclksrc;
@@ -1273,7 +1314,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	u32 regs_base, quirks = 0, idma_addr = 0;
 	struct device_node *np = pdev->dev.of_node;
 	const struct samsung_i2s_dai_data *i2s_dai_data;
-	int ret;
+	int num_dais, ret;
+	struct samsung_i2s_priv *priv;
 
 	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
 		i2s_dai_data = of_device_get_match_data(&pdev->dev);
@@ -1281,14 +1323,24 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		i2s_dai_data = (struct samsung_i2s_dai_data *)
 				platform_get_device_id(pdev)->driver_data;
 
-	pri_dai = i2s_alloc_dai(pdev, i2s_dai_data, false);
-	if (!pri_dai) {
-		dev_err(&pdev->dev, "Unable to alloc I2S_pri\n");
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
-	}
 
-	spin_lock_init(&pri_dai->spinlock);
-	pri_dai->lock = &pri_dai->spinlock;
+	quirks = np ? i2s_dai_data->quirks : i2s_pdata->type.quirks;
+	quirks &= ~(QUIRK_SEC_DAI | QUIRK_SUPPORTS_IDMA);
+
+	num_dais = (quirks & QUIRK_SEC_DAI) ? 2 : 1;
+	priv->pdev = pdev;
+
+	ret = i2s_alloc_dais(priv, i2s_dai_data, num_dais);
+	if (ret < 0)
+		return ret;
+
+	pri_dai = &priv->dai[SAMSUNG_I2S_ID_PRIMARY - 1];
+
+	spin_lock_init(&priv->spinlock);
+	pri_dai->lock = &priv->spinlock;
 
 	if (!np) {
 		if (i2s_pdata == NULL) {
@@ -1300,10 +1352,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		pri_dai->dma_capture.filter_data = i2s_pdata->dma_capture;
 		pri_dai->filter = i2s_pdata->dma_filter;
 
-		quirks = i2s_pdata->type.quirks;
 		idma_addr = i2s_pdata->type.idma_addr;
 	} else {
-		quirks = i2s_dai_data->quirks;
 		if (of_property_read_u32(np, "samsung,idma-addr",
 					 &idma_addr)) {
 			if (quirks & QUIRK_SUPPORTS_IDMA) {
@@ -1312,7 +1362,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 			}
 		}
 	}
-	quirks &= ~(QUIRK_SEC_DAI | QUIRK_SUPPORTS_IDMA);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pri_dai->addr = devm_ioremap_resource(&pdev->dev, res);
@@ -1342,28 +1391,17 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->variant_regs = i2s_dai_data->i2s_variant_regs;
 
 	if (quirks & QUIRK_PRI_6CHAN)
-		pri_dai->i2s_dai_drv.playback.channels_max = 6;
+		pri_dai->drv->playback.channels_max = 6;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, pri_dai->filter,
 						 NULL, NULL, NULL);
 	if (ret < 0)
 		goto err_disable_clk;
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					&samsung_i2s_component,
-					&pri_dai->i2s_dai_drv, 1);
-	if (ret < 0)
-		goto err_disable_clk;
-
 	if (quirks & QUIRK_SEC_DAI) {
-		sec_dai = i2s_alloc_dai(pdev, i2s_dai_data, true);
-		if (!sec_dai) {
-			dev_err(&pdev->dev, "Unable to alloc I2S_sec\n");
-			ret = -ENOMEM;
-			goto err_disable_clk;
-		}
+		sec_dai = &priv->dai[SAMSUNG_I2S_ID_SECONDARY - 1];
 
-		sec_dai->lock = &pri_dai->spinlock;
+		sec_dai->lock = &priv->spinlock;
 		sec_dai->variant_regs = pri_dai->variant_regs;
 		sec_dai->dma_playback.addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.chan_name = "tx-sec";
@@ -1386,11 +1424,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto err_disable_clk;
 
-		ret = devm_snd_soc_register_component(&pdev->dev,
-						&samsung_i2s_component,
-						&sec_dai->i2s_dai_drv, 1);
-		if (ret < 0)
-			goto err_disable_clk;
 	}
 
 	if (i2s_pdata && i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
@@ -1399,7 +1432,13 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	dev_set_drvdata(&pdev->dev, pri_dai);
+	dev_set_drvdata(&pdev->dev, priv);
+
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					&samsung_i2s_component,
+					priv->dai_drv, num_dais);
+	if (ret < 0)
+		goto err_disable_clk;
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -1421,9 +1460,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 static int samsung_i2s_remove(struct platform_device *pdev)
 {
-	struct i2s_dai *pri_dai;
-
-	pri_dai = dev_get_drvdata(&pdev->dev);
+	struct samsung_i2s_priv *priv = dev_get_drvdata(&pdev->dev);
+	struct i2s_dai *pri_dai = samsung_i2s_get_pri_dai(&pdev->dev);
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.20.1

