Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1121C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36D72084D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549990740;
	bh=3ECur8Dd+DCAc8hOjqmW+tvQ307FXnt+yUzAgDTb+ss=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=hc1m8QKQcun3en4iGFL/zsoWuE5lp2cZhhCByMAKSFGsWq/ec0GONRhHd7gK9lIbV
	 irp7rOR3yFeWwbgNIeMqljQnaaB2EVJEMoCb95LM0NcyKaVVpnNmF1YeN741Fw81j/
	 VgezEqRSKNs/pg84Ww2/qQYC2HnjoJNN63I+z59A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbfBLQ67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:58:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36256 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbfBLQ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=jzNefMzuk04PyforSEkjDACz5ii+i3XfoAdvSI9iaE4=; b=pKEjr3nMTwrq
        7W0M5N8z2c9TAsjWioP5scvszGSDyAnugNb2Z+bt8enenKUiaUbEHikbaaVUdmG7l1CmzWmrAHqjE
        Ix2aSjv0IGVzIY/VCr+6K+d2t0/vwU9+29baXNMW8y3PRwtKLe6pSX7R2VrE0v6n1DLe9nl2oMZOW
        of08w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtbOV-0005i4-P8; Tue, 12 Feb 2019 16:58:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5862C1128113; Tue, 12 Feb 2019 16:58:51 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, lgirdwood@gmail.com,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: dmaengine: Allow to specify custom DMA device" to the asoc tree
In-Reply-To:  <20190207170028.720-4-s.nawrocki@samsung.com>
X-Patchwork-Hint: ignore
Message-Id: <20190212165851.5862C1128113@debutante.sirena.org.uk>
Date:   Tue, 12 Feb 2019 16:58:51 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: dmaengine: Allow to specify custom DMA device

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

From 96f06cde2c00d78395f5200cbbdf216c5ce3bc3f Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 7 Feb 2019 18:00:11 +0100
Subject: [PATCH] ASoC: samsung: dmaengine: Allow to specify custom DMA device

The additional function argument will allow to select proper DMA device
for requesting DMA channel for the secondary CPU DAI.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/dma.h         | 3 ++-
 sound/soc/samsung/dmaengine.c   | 4 +++-
 sound/soc/samsung/i2s.c         | 4 ++--
 sound/soc/samsung/pcm.c         | 2 +-
 sound/soc/samsung/s3c2412-i2s.c | 2 +-
 sound/soc/samsung/s3c24xx-i2s.c | 2 +-
 sound/soc/samsung/spdif.c       | 2 +-
 7 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/soc/samsung/dma.h b/sound/soc/samsung/dma.h
index 7ae580d677c8..0ae15d01a3f6 100644
--- a/sound/soc/samsung/dma.h
+++ b/sound/soc/samsung/dma.h
@@ -17,5 +17,6 @@
  * otherwise actual DMA channel names must be passed to this function.
  */
 int samsung_asoc_dma_platform_register(struct device *dev, dma_filter_fn filter,
-				       const char *tx, const char *rx);
+				       const char *tx, const char *rx,
+				       struct device *dma_dev);
 #endif /* _SAMSUNG_DMA_H */
diff --git a/sound/soc/samsung/dmaengine.c b/sound/soc/samsung/dmaengine.c
index 9104c98deeb7..84601fa9aa46 100644
--- a/sound/soc/samsung/dmaengine.c
+++ b/sound/soc/samsung/dmaengine.c
@@ -25,7 +25,8 @@
 #include "dma.h"
 
 int samsung_asoc_dma_platform_register(struct device *dev, dma_filter_fn filter,
-				       const char *tx, const char *rx)
+				       const char *tx, const char *rx,
+				       struct device *dma_dev)
 {
 	unsigned int flags = SND_DMAENGINE_PCM_FLAG_COMPAT;
 	struct snd_dmaengine_pcm_config *pcm_conf;
@@ -36,6 +37,7 @@ int samsung_asoc_dma_platform_register(struct device *dev, dma_filter_fn filter,
 
 	pcm_conf->prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
 	pcm_conf->compat_filter_fn = filter;
+	pcm_conf->dma_dev = dma_dev;
 
 	if (dev->of_node) {
 		pcm_conf->chan_names[SNDRV_PCM_STREAM_PLAYBACK] = tx;
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index d6c62aa13041..efc8704d36e3 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1345,7 +1345,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		pri_dai->i2s_dai_drv.playback.channels_max = 6;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, pri_dai->filter,
-						 NULL, NULL);
+						 NULL, NULL, NULL);
 	if (ret < 0)
 		goto err_disable_clk;
 
@@ -1382,7 +1382,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		pri_dai->sec_dai = sec_dai;
 
 		ret = samsung_asoc_dma_platform_register(&pdev->dev,
-					sec_dai->filter, "tx-sec", NULL);
+					sec_dai->filter, "tx-sec", NULL, NULL);
 		if (ret < 0)
 			goto err_disable_clk;
 
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 37f95eee1558..3c7baa561084 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -553,7 +553,7 @@ static int s3c_pcm_dev_probe(struct platform_device *pdev)
 	pcm->dma_playback = &s3c_pcm_stereo_out[pdev->id];
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, filter,
-						 NULL, NULL);
+						 NULL, NULL, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get register DMA: %d\n", ret);
 		goto err_dis_pclk;
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index cc0840fff5aa..67dfa27ae321 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -177,7 +177,7 @@ static int s3c2412_iis_dev_probe(struct platform_device *pdev)
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev,
 						 pdata->dma_filter,
-						 NULL, NULL);
+						 NULL, NULL, NULL);
 	if (ret) {
 		pr_err("failed to register the DMA: %d\n", ret);
 		return ret;
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 8d58d02183bf..ba0f2b94f8d4 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -446,7 +446,7 @@ static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
 	s3c24xx_i2s_pcm_stereo_in.addr = res->start + S3C2410_IISFIFO;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, NULL,
-						 NULL, NULL);
+						 NULL, NULL, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register the DMA: %d\n", ret);
 		return ret;
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index cb59911e65c0..5e4afb330416 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -430,7 +430,7 @@ static int spdif_probe(struct platform_device *pdev)
 	spdif->dma_playback = &spdif_stereo_out;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, filter,
-						 NULL, NULL);
+						 NULL, NULL, NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register DMA: %d\n", ret);
 		goto err4;
-- 
2.20.1

