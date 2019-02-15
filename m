Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F5AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A37A206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550256112;
	bh=pf1DQS4jxlIZnvyGiJ0mpm4KBsWTJCx8XpAvSwrTOhc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=pWdlZLwTCUMOKv/6Gmgp1AYLvibW0aso9Xg5cJxrAecwJ3HPbTG/OZlDJD+wolx6B
	 xhZMlaNLEJ4TlFwKARspEFFwwFvTbzTRF4iNLkDIuoJ0/h7KfP+CzKFaxoZfT1LJWf
	 3oJxIK98cNDWenNzkipbfqjGATshods51Is0Ue/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbfBOSlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:41:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34714 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbfBOSlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2I7PSRBfTKLL+3W6PxIS/hTNQx26zx2oJWQMpkxQpqg=; b=rdLCJDjrKi+j
        5DqKLxByI8Wf30jnB0RkZSoQDQF7g+nC77U/jyI32hSOwZkYdfN5iO31KoQgPVh1KNgp5rx+UJbv6
        KD1GfyLxbpa+Jtmrr+GWxVsKABgdC5sTYXKAG+PTy5WMeOr3IA6+G91o3Ed0KvydLUOhUewoP8qlY
        RGznE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guiQf-0000h7-Nu; Fri, 15 Feb 2019 18:41:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0B3A011286B7; Fri, 15 Feb 2019 18:41:41 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, sbkim73@samsung.com,
        lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: i2s: Prevent potential NULL platform data dereference" to the asoc tree
In-Reply-To:  <20190214155840.3764-1-s.nawrocki@samsung.com>
X-Patchwork-Hint: ignore
Message-Id: <20190215184141.0B3A011286B7@debutante.sirena.org.uk>
Date:   Fri, 15 Feb 2019 18:41:41 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: i2s: Prevent potential NULL platform data dereference

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

From 6e434122d9041c48841709385e823eef3225663e Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 14 Feb 2019 16:58:40 +0100
Subject: [PATCH] ASoC: samsung: i2s: Prevent potential NULL platform data
 dereference

When np is NULL i2s_pdata could also be NULL but i2s_pdata is now being
dereferenced without proper check. Fix this and shorten the error message
so we don't exceed 80 characters limit.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 03fff1c657be..02472f576e17 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1369,7 +1369,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
 	struct s3c_audio_pdata *i2s_pdata = pdev->dev.platform_data;
 	struct resource *res;
-	u32 regs_base, quirks = 0, idma_addr = 0;
+	u32 regs_base, idma_addr = 0;
 	struct device_node *np = pdev->dev.of_node;
 	const struct samsung_i2s_dai_data *i2s_dai_data;
 	int num_dais, ret;
@@ -1389,11 +1389,19 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	quirks = np ? i2s_dai_data->quirks : i2s_pdata->type.quirks;
-	num_dais = (quirks & QUIRK_SEC_DAI) ? 2 : 1;
+	if (np) {
+		priv->quirks = i2s_dai_data->quirks;
+	} else {
+		if (!i2s_pdata) {
+			dev_err(&pdev->dev, "Missing platform data\n");
+			return -EINVAL;
+		}
+		priv->quirks = i2s_pdata->type.quirks;
+	}
+
+	num_dais = (priv->quirks & QUIRK_SEC_DAI) ? 2 : 1;
 	priv->pdev = pdev;
 	priv->variant_regs = i2s_dai_data->i2s_variant_regs;
-	priv->quirks = quirks;
 
 	ret = i2s_alloc_dais(priv, i2s_dai_data, num_dais);
 	if (ret < 0)
@@ -1405,11 +1413,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	spin_lock_init(&priv->pcm_lock);
 
 	if (!np) {
-		if (i2s_pdata == NULL) {
-			dev_err(&pdev->dev, "Can't work without s3c_audio_pdata\n");
-			return -EINVAL;
-		}
-
 		pri_dai->dma_playback.filter_data = i2s_pdata->dma_playback;
 		pri_dai->dma_capture.filter_data = i2s_pdata->dma_capture;
 		pri_dai->filter = i2s_pdata->dma_filter;
@@ -1418,7 +1421,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	} else {
 		if (of_property_read_u32(np, "samsung,idma-addr",
 					 &idma_addr)) {
-			if (quirks & QUIRK_SUPPORTS_IDMA) {
+			if (priv->quirks & QUIRK_SUPPORTS_IDMA) {
 				dev_info(&pdev->dev, "idma address is not"\
 						"specified");
 			}
@@ -1451,7 +1454,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->dma_capture.addr_width = 4;
 	pri_dai->priv = priv;
 
-	if (quirks & QUIRK_PRI_6CHAN)
+	if (priv->quirks & QUIRK_PRI_6CHAN)
 		pri_dai->drv->playback.channels_max = 6;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, pri_dai->filter,
@@ -1459,7 +1462,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_disable_clk;
 
-	if (quirks & QUIRK_SEC_DAI) {
+	if (priv->quirks & QUIRK_SEC_DAI) {
 		sec_dai = &priv->dai[SAMSUNG_I2S_ID_SECONDARY - 1];
 
 		sec_dai->dma_playback.addr = regs_base + I2STXDS;
-- 
2.20.1

