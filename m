Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF487C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B6C2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550515950;
	bh=BCayeuDWCo9SEK7k7iVM6a96RvrOgdfifnlCZeS/3HA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=GVCi7+/HrMhjaUzENrLBo3ywLUI1uxSZqDcdfSQa3ss5SKpS1dLtVvchtfR0M7lmQ
	 jTs6LbMIYH7CcCVCteZwYCXi5j8TfruKACaQF73hyE7ny6hoFQwJv3QVa1L5sIIjtW
	 xOZcJ92kERBJxExdtcwEMSKKO2HgSXBXwo1sOVzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfBRSw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:52:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46838 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfBRSw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9je/8gluzR/OK6MxRiuz19zq5Cvy4bhUiUoGTFoYAbk=; b=SiBYiAEjm+aT
        VcUF5VkQijMxzk2jfgkfqv5yu2fEeZAUmqi1pi+GSqmssX5ku6ouyXWsXumKaQDnayWJL0uSIqGmC
        7L3IjyqWe9HBfi225FpBJhLWgIJH7ySi5ym3wA8vy/rvfaThpSqmQ/fTKpGLyRd/FyClzUIbmlue2
        ZeLYA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvo1f-0001iI-OF; Mon, 18 Feb 2019 18:52:23 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3FF701128008; Mon, 18 Feb 2019 18:52:23 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, sbkim73@samsung.com,
        lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: odroid: Ensure proper sample rate on pri/sec PCM" to the asoc tree
In-Reply-To:  <20190214160011.3940-1-s.nawrocki@samsung.com>
X-Patchwork-Hint: ignore
Message-Id: <20190218185223.3FF701128008@debutante.sirena.org.uk>
Date:   Mon, 18 Feb 2019 18:52:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: odroid: Ensure proper sample rate on pri/sec PCM

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

From b5c16a24efc809554c4c651df6bd9b48b084a5a3 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 14 Feb 2019 17:00:11 +0100
Subject: [PATCH] ASoC: samsung: odroid: Ensure proper sample rate on pri/sec
 PCM

Currently when playing sound with different sample rates actual
sample rate will be determined by audio stream which starts first
on either primary or secondary PCM. The audio root clock will be
configured appropriately only for the first stream. As the hardware
is limited to same sample rate on both interfaces we need to disallow
streams with different sample rates. It is done by this patch by
returning error in FE hw_params if there is already active stream
running with different sample rate.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/odroid.c | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index 18bb3bfe0300..941e8c3f67a4 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -20,6 +20,11 @@ struct odroid_priv {
 	struct snd_soc_card card;
 	struct clk *clk_i2s_bus;
 	struct clk *sclk_i2s;
+
+	/* Spinlock protecting fields below */
+	spinlock_t lock;
+	unsigned int be_sample_rate;
+	bool be_active;
 };
 
 static int odroid_card_fe_startup(struct snd_pcm_substream *substream)
@@ -31,8 +36,25 @@ static int odroid_card_fe_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static int odroid_card_fe_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct odroid_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	if (priv->be_active && priv->be_sample_rate != params_rate(params))
+		ret = -EINVAL;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
 static const struct snd_soc_ops odroid_card_fe_ops = {
 	.startup = odroid_card_fe_startup,
+	.hw_params = odroid_card_fe_hw_params,
 };
 
 static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
@@ -41,6 +63,7 @@ static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct odroid_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	unsigned int pll_freq, rclk_freq, rfs;
+	unsigned long flags;
 	int ret;
 
 	switch (params_rate(params)) {
@@ -87,11 +110,43 @@ static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
 			return ret;
 	}
 
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->be_sample_rate = params_rate(params);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int odroid_card_be_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct odroid_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		priv->be_active = true;
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		priv->be_active = false;
+		break;
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	return 0;
 }
 
 static const struct snd_soc_ops odroid_card_be_ops = {
 	.hw_params = odroid_card_be_hw_params,
+	.trigger = odroid_card_be_trigger,
 };
 
 static struct snd_soc_dai_link odroid_card_dais[] = {
@@ -150,6 +205,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	card->owner = THIS_MODULE;
 	card->fully_routed = true;
 
+	spin_lock_init(&priv->lock);
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = snd_soc_of_parse_card_name(card, "model");
-- 
2.20.1

