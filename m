Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F4CC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D2D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551198164;
	bh=+6qfe16bvOpodZGYQCBP6ajPXkhwawcK3GvCCiM1pH0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=gH531CEqpkvdCWpcLEEOvChz36grMLi1QQxNFGECgfK6GaDlPqO6hs9PrI6lyj10Y
	 9AuAZt4DualgZOVolbNNW28wlSolyeGftcvW+cvFOQtkmFIyzkb6RamKTHoxqi056A
	 YDNQZVINMp9RoTGOJjRHX6Sp2/+mEW3Agx0Y59YY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfBZQWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:22:42 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36038 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfBZQWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=kacyJVHrI2bgXHeMK6B1LJPVjPr/vUqbxONyCmF568k=; b=T1x2/WyrHqMb
        1H3+byDTW3bVHCAnB99nTCaa8LXO5FXnPzygznHpYKv6KjD5lL1sx3QhnS6KWHOf4ibdU1TG/AW4J
        MrN4R8BEvdRMVUqoa2kS/3Y8ZSaHJTtUURaGW2edYzSd+yWmYJRCG8Llxw4H4ZYGPFVr2Bi6nixb1
        kg3vc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gyfV0-000099-1i; Tue, 26 Feb 2019 16:22:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 980C41121A0A; Tue, 26 Feb 2019 16:22:29 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: i2s: fix dma configuration" to the asoc tree
In-Reply-To:  <1551189070-15469-5-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190226162229.980C41121A0A@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 16:22:29 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: i2s: fix dma configuration

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

From 1ac2bd16448997d9ec01922423486e1e85535eda Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Tue, 26 Feb 2019 14:51:07 +0100
Subject: [PATCH] ASoC: stm32: i2s: fix dma configuration

DMA configuration is not balanced on start/stop.
Move DMA configuration to trigger callback.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 7f56d7b51ba3..95fffb61faa5 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -488,7 +488,7 @@ static int stm32_i2s_configure(struct snd_soc_dai *cpu_dai,
 {
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
 	int format = params_width(params);
-	u32 cfgr, cfgr_mask, cfg1, cfg1_mask;
+	u32 cfgr, cfgr_mask, cfg1;
 	unsigned int fthlv;
 	int ret;
 
@@ -529,15 +529,11 @@ static int stm32_i2s_configure(struct snd_soc_dai *cpu_dai,
 	if (ret < 0)
 		return ret;
 
-	cfg1 = I2S_CFG1_RXDMAEN | I2S_CFG1_TXDMAEN;
-	cfg1_mask = cfg1;
-
 	fthlv = STM32_I2S_FIFO_SIZE * I2S_FIFO_TH_ONE_QUARTER / 4;
-	cfg1 |= I2S_CFG1_FTHVL_SET(fthlv - 1);
-	cfg1_mask |= I2S_CFG1_FTHVL_MASK;
+	cfg1 = I2S_CFG1_FTHVL_SET(fthlv - 1);
 
 	return regmap_update_bits(i2s->regmap, STM32_I2S_CFG1_REG,
-				  cfg1_mask, cfg1);
+				  I2S_CFG1_FTHVL_MASK, cfg1);
 }
 
 static int stm32_i2s_startup(struct snd_pcm_substream *substream,
@@ -592,6 +588,10 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		/* Enable i2s */
 		dev_dbg(cpu_dai->dev, "start I2S\n");
 
+		cfg1_mask = I2S_CFG1_RXDMAEN | I2S_CFG1_TXDMAEN;
+		regmap_update_bits(i2s->regmap, STM32_I2S_CFG1_REG,
+				   cfg1_mask, cfg1_mask);
+
 		ret = regmap_update_bits(i2s->regmap, STM32_I2S_CR1_REG,
 					 I2S_CR1_SPE, I2S_CR1_SPE);
 		if (ret < 0) {
-- 
2.20.1

