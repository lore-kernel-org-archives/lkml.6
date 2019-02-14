Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC25C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009D62229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550155885;
	bh=Ws23cxBDcALVuuav7RPAS6g71+Nwew/2M/uw89l0Crc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UpQzQtX0AAFlYkn15+807aefbeGddNDdtcw/8JgVo8lOsUj6RRfrV1ixx1qvqGDUS
	 EGmRSBA0iROOOgT9j9VWLHOsQEFvBC1cHamf6GuCUHrNH/8viv3t4qjNzU7WaRYXG5
	 geiQizSBturysT/LlTYeEG5vFrF2nn+TvDzPoMik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407370AbfBNOvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:51:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54482 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407285AbfBNOvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EXZrpjoHhZqYQfpRSVVStW7o4M/Do/wAOwnBBUNyM34=; b=aL2qlbyPvzJk
        ycC/vgerUKaaFsWR5zAlhgHor+qWX80BI7p1WY8xN6B7RlRQvnrNv+61zOM1mAaPo82FOwsFiasS4
        vxBxQZr2Hwv1V0mwTOrPSm2k1oAcy83x1L6A5mlgqM+pN+gasyj2cG4lFR8Z00pcH4Fb42hXRf3fv
        K+TBc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guIM2-00057e-7y; Thu, 14 Feb 2019 14:51:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B3B6D1126F78; Thu, 14 Feb 2019 14:51:09 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: da7219: Add support for master mode BCLK rate adjustment" to the asoc tree
In-Reply-To:  <2a1ae702cb3cfb9029e04b69d68f9c9d0e92dbf5.1550138803.git.Adam.Thomson.Opensource@diasemi.com>
X-Patchwork-Hint: ignore
Message-Id: <20190214145109.B3B6D1126F78@debutante.sirena.org.uk>
Date:   Thu, 14 Feb 2019 14:51:09 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: da7219: Add support for master mode BCLK rate adjustment

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

From 9fd729542cf4aff3c70b8e5be6f510e6722bc369 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Thu, 14 Feb 2019 10:13:29 +0000
Subject: [PATCH] ASoC: da7219: Add support for master mode BCLK rate
 adjustment

Previously the driver would default the BCLK periods per WCLK to
64, to cover all possible non-TDM scenarios when the codec was
DAI clock master. However some devices require a lower BCLK rate
to operate correctly so with this in mind, this commit updates
the code to be more dynamic, with BCLK rate now based on SR and
word length provided to hw_params().

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 36 ++++++++++++++++++++++++++----------
 sound/soc/codecs/da7219.h |  1 +
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index b1df4bb36105..c599aa9f609b 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1376,11 +1376,7 @@ static int da7219_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	/* By default 64 BCLKs per WCLK is supported */
-	dai_clk_mode |= DA7219_DAI_BCLKS_PER_WCLK_64;
-
 	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
-			    DA7219_DAI_BCLKS_PER_WCLK_MASK |
 			    DA7219_DAI_CLK_POL_MASK | DA7219_DAI_WCLK_POL_MASK,
 			    dai_clk_mode);
 	snd_soc_component_update_bits(component, DA7219_DAI_CTRL, DA7219_DAI_FORMAT_MASK,
@@ -1399,14 +1395,12 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	__le16 offset;
 	u32 frame_size;
 
-	/* No channels enabled so disable TDM, revert to 64-bit frames */
+	/* No channels enabled so disable TDM */
 	if (!tx_mask) {
 		snd_soc_component_update_bits(component, DA7219_DAI_TDM_CTRL,
 				    DA7219_DAI_TDM_CH_EN_MASK |
 				    DA7219_DAI_TDM_MODE_EN_MASK, 0);
-		snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
-				    DA7219_DAI_BCLKS_PER_WCLK_MASK,
-				    DA7219_DAI_BCLKS_PER_WCLK_64);
+		da7219->tdm_en = false;
 		return 0;
 	}
 
@@ -1458,6 +1452,8 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 			    (tx_mask << DA7219_DAI_TDM_CH_EN_SHIFT) |
 			    DA7219_DAI_TDM_MODE_EN_MASK);
 
+	da7219->tdm_en = true;
+
 	return 0;
 }
 
@@ -1466,10 +1462,13 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
-	u8 dai_ctrl = 0, fs;
+	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
+	u8 dai_ctrl = 0, dai_bclks_per_wclk = 0, fs;
 	unsigned int channels;
+	int word_len = params_width(params);
+	int frame_size;
 
-	switch (params_width(params)) {
+	switch (word_len) {
 	case 16:
 		dai_ctrl |= DA7219_DAI_WORD_LENGTH_S16_LE;
 		break;
@@ -1533,6 +1532,23 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/*
+	 * If we're master, then we have a limited set of BCLK rates we
+	 * support. For slave mode this isn't the case and the codec can detect
+	 * the BCLK rate automatically.
+	 */
+	if (da7219->master && !da7219->tdm_en) {
+		frame_size = word_len * 2;
+		if (frame_size <= 32)
+			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_32;
+		else
+			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_64;
+
+		snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
+					      DA7219_DAI_BCLKS_PER_WCLK_MASK,
+					      dai_bclks_per_wclk);
+	}
+
 	snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
 			    DA7219_DAI_WORD_LENGTH_MASK |
 			    DA7219_DAI_CH_NUM_MASK,
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 366cf46118a0..018819c631fb 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -830,6 +830,7 @@ struct da7219_priv {
 	int clk_src;
 
 	bool master;
+	bool tdm_en;
 	bool alc_en;
 	bool micbias_on_event;
 	unsigned int mic_pga_delay;
-- 
2.20.1

