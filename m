Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDFEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17BC2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550515832;
	bh=osMQM4LRc6uAlORfGNIq0IQ12Epj6H/f5wZUSxRb7+g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=IpZtk4SyGVHaAUykWymgijqcvQohLJmaz9WLbiF3LQINkNNtHnVrbsF5EHYNlYWqg
	 tZycwWcVr9v/9mll0S/m+FLCxwfGlgbVjH5DJQJ3RjugQe38azIFN4xsl72qJWVb7r
	 tpRJQrtFvZWWPuT7/ZVH7l+OSU7Dh1x+IVJPUcSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfBRSua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:50:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42466 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfBRStx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=W1gsUMiLEbeWMTVS3jKPejmRZbMzUdLeBmtMgFrJaPM=; b=RSotHbzHjtvY
        hNClOq/yopfqROj0UbTBc2ZeBz0bt2MAUMtW45zXXJSsJajHWt0cDSh3CVr9XdiHJdRSUhiSVJyIH
        ESPb/+dYlE3r6Fx4r1L56BS2ulwWOv7Xtsw/x7Psv7m6Quue1MHv126OY+w2BfmoQQpkfQOQ2UkGx
        0Qzw4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvnyt-0001eV-HT; Mon, 18 Feb 2019 18:49:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F3E631128008; Mon, 18 Feb 2019 18:49:30 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, Codrin.Ciubotariu@microchip.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: codecs: ad193x: Add support to disable on-chip PLL" to the asoc tree
In-Reply-To:  <20190218160954.13929-6-codrin.ciubotariu@microchip.com>
X-Patchwork-Hint: ignore
Message-Id: <20190218184930.F3E631128008@debutante.sirena.org.uk>
Date:   Mon, 18 Feb 2019 18:49:30 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: ad193x: Add support to disable on-chip PLL

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

From 59529473751e987e28c926838f70aaef588b83b0 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Mon, 18 Feb 2019 16:10:36 +0000
Subject: [PATCH] ASoC: codecs: ad193x: Add support to disable on-chip PLL

The on-chip PLL can be disabled if on the MCLKI pin we have an external
clock at 512 x fs. This clock can be used as direct internal clock for
ADCs or DACs.
To support this, we add an extra clock id that can be configured
using the set_sysclk() callback.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 26 +++++++++++++++++++++++++-
 sound/soc/codecs/ad193x.h |  8 ++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index f8cf182518a3..96d7cb2e4a56 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -100,6 +100,15 @@ static const struct snd_soc_dapm_widget ad193x_adc_widgets[] = {
 	SND_SOC_DAPM_INPUT("ADC2IN"),
 };
 
+static int ad193x_check_pll(struct snd_soc_dapm_widget *source,
+			    struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
+	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(component);
+
+	return !!ad193x->sysclk;
+}
+
 static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "DAC", NULL, "SYSCLK" },
 	{ "DAC Output", NULL, "DAC" },
@@ -108,7 +117,7 @@ static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "DAC2OUT", NULL, "DAC Output" },
 	{ "DAC3OUT", NULL, "DAC Output" },
 	{ "DAC4OUT", NULL, "DAC Output" },
-	{ "SYSCLK", NULL, "PLL_PWR" },
+	{ "SYSCLK", NULL, "PLL_PWR", &ad193x_check_pll },
 };
 
 static const struct snd_soc_dapm_route ad193x_adc_audio_paths[] = {
@@ -276,7 +285,22 @@ static int ad193x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_component *component = codec_dai->component;
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(component);
+
+	if (clk_id == AD193X_SYSCLK_MCLK) {
+		/* MCLK must be 512 x fs */
+		if (dir == SND_SOC_CLOCK_OUT || freq != 24576000)
+			return -EINVAL;
+
+		regmap_update_bits(ad193x->regmap, AD193X_PLL_CLK_CTRL1,
+				   AD193X_PLL_SRC_MASK,
+				   AD193X_PLL_DAC_SRC_MCLK |
+				   AD193X_PLL_CLK_SRC_MCLK);
+
+		snd_soc_dapm_sync(dapm);
+		return 0;
+	}
 	switch (freq) {
 	case 12288000:
 	case 18432000:
diff --git a/sound/soc/codecs/ad193x.h b/sound/soc/codecs/ad193x.h
index 8b1e65f928d2..27d6afbd7dfb 100644
--- a/sound/soc/codecs/ad193x.h
+++ b/sound/soc/codecs/ad193x.h
@@ -31,6 +31,11 @@ int ad193x_probe(struct device *dev, struct regmap *regmap,
 #define AD193X_PLL_INPUT_512    (2 << 1)
 #define AD193X_PLL_INPUT_768    (3 << 1)
 #define AD193X_PLL_CLK_CTRL1    0x01
+#define AD193X_PLL_SRC_MASK	0x03
+#define AD193X_PLL_DAC_SRC_PLL  0
+#define AD193X_PLL_DAC_SRC_MCLK 1
+#define AD193X_PLL_CLK_SRC_PLL  (0 << 1)
+#define AD193X_PLL_CLK_SRC_MCLK	(1 << 1)
 #define AD193X_DAC_CTRL0        0x02
 #define AD193X_DAC_POWERDOWN           0x01
 #define AD193X_DAC_SERFMT_MASK		0xC0
@@ -96,4 +101,7 @@ int ad193x_probe(struct device *dev, struct regmap *regmap,
 
 #define AD193X_NUM_REGS          17
 
+#define AD193X_SYSCLK_PLL	0
+#define AD193X_SYSCLK_MCLK	1
+
 #endif
-- 
2.20.1

