Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843B0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F8F217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550515845;
	bh=NuHeaDMfTX2psv2L9dqhSkTSVcTTO8pFjHXTaB54uPw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=pNEM2GtXjQfErnl3nM6x37ljDQUqX0xzHZIaJsMCCfd4IAdjpGrjhuzVrzuORashV
	 6H73gELVNmW3tduo+Of68aBctubN1oGeN9Ad3Tigce8zYRrH4zs0Vq2JWbL0t/mEmQ
	 zMwHryNuDLzWFwjmMd9qpgztuuRbiqwiEVPTYSTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfBRSul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:50:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42052 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBRStm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=kkcCCbEVAeopxo4OYLu/yuE6mrCwvwYeWMTMzA4rIBw=; b=Gb5WxoJ+A/j/
        Xy4XX2bDGBAnunV/f4Xaq/o7jW4X8Zhu0yq3ukVIbl2DzvG3zjnHriHIKSEsNkbAgwoza1tYGtj34
        Cm/3yAQjPdDJ6bz7Dqo3DNYt2NYl5aFz7P049DJLaK/aJUiSJJnWKx9X4VVIGO5eIwDjgHe5YvYri
        3D4AQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvnyw-0001en-2Q; Mon, 18 Feb 2019 18:49:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 433021128008; Mon, 18 Feb 2019 18:49:33 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, Codrin.Ciubotariu@microchip.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: codecs: ad193x: Add runtime support for DSP_A and I2S modes" to the asoc tree
In-Reply-To:  <20190218160954.13929-5-codrin.ciubotariu@microchip.com>
X-Patchwork-Hint: ignore
Message-Id: <20190218184933.433021128008@debutante.sirena.org.uk>
Date:   Mon, 18 Feb 2019 18:49:33 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: ad193x: Add runtime support for DSP_A and I2S modes

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

From bccf9c7e14830af0004399d42d861b33c92eacff Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Mon, 18 Feb 2019 16:10:34 +0000
Subject: [PATCH] ASoC: codecs: ad193x: Add runtime support for DSP_A and I2S
 modes

The driver only supports DPS_A for DAC, which is configured at probe.
This patch adds support for DSP_A and I2S modes by using the set_fmt()
callback.

A trivial break is also removed from a case's default branch.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 315ec9775118..f8cf182518a3 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -188,23 +188,26 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 {
 	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(codec_dai->component);
 	unsigned int adc_serfmt = 0;
+	unsigned int dac_serfmt = 0;
 	unsigned int adc_fmt = 0;
 	unsigned int dac_fmt = 0;
 
 	/* At present, the driver only support AUX ADC mode(SND_SOC_DAIFMT_I2S
-	 * with TDM) and ADC&DAC TDM mode(SND_SOC_DAIFMT_DSP_A)
+	 * with TDM), ADC&DAC TDM mode(SND_SOC_DAIFMT_DSP_A) and DAC I2S mode
+	 * (SND_SOC_DAIFMT_I2S)
 	 */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		adc_serfmt |= AD193X_ADC_SERFMT_TDM;
+		dac_serfmt |= AD193X_DAC_SERFMT_STEREO;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		adc_serfmt |= AD193X_ADC_SERFMT_AUX;
+		dac_serfmt |= AD193X_DAC_SERFMT_TDM;
 		break;
 	default:
 		if (ad193x_has_adc(ad193x))
 			return -EINVAL;
-		break;
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -261,6 +264,8 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL2,
 				   AD193X_ADC_FMT_MASK, adc_fmt);
 	}
+	regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL0,
+			   AD193X_DAC_SERFMT_MASK, dac_serfmt);
 	regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL1,
 		AD193X_DAC_FMT_MASK, dac_fmt);
 
-- 
2.20.1

