Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03409C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADE02177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550515790;
	bh=qqoSZvYO+TWeTp9y1l84fc7jsm/LE2/BveAX7v8GhWw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=okih1VW7XTS4E8R84WM+Wlg5ejMOf9gWeodRTk4awF1sgY50NnYPbKvtFd8wFfLam
	 Fg/AyyCwH2/JmRIhjpQ80sS5xjAe2XoKK2DtBZTbQ9TiCzivFhzeRrh5xe2pavay4Q
	 e8weZyV3mGf2dCHIEwrAj0WJoaRYRCLIajpqLzDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfBRStt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:49:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42252 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfBRStq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gh9CirCd86fYr37lcRNJseSj/vabTYOQxaEKl4c4nnY=; b=hIfmenDMYjrS
        AseQrT+iGCYiGMSg2ESn+ACcqsQn7R8R5aPHewz5VURwvj1i6kPOSgCR29TBbzmxQgQ2ttVxAuIFD
        bQq+i/HW2/k6TgE9UyrUN3gGGHAxZsNARmDbfhVa2op+VNEzCsOBsOjwg+LzZF8XlVG6baKMdFokb
        8eZ8M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvnz2-0001fH-CT; Mon, 18 Feb 2019 18:49:40 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C1A051128008; Mon, 18 Feb 2019 18:49:39 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, Codrin.Ciubotariu@microchip.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: codecs: ad193x: Remove capture support for codecs without ADC" to the asoc tree
In-Reply-To:  <20190218160954.13929-2-codrin.ciubotariu@microchip.com>
X-Patchwork-Hint: ignore
Message-Id: <20190218184939.C1A051128008@debutante.sirena.org.uk>
Date:   Mon, 18 Feb 2019 18:49:39 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: ad193x: Remove capture support for codecs without ADC

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

From 7aac8d13fc60db3ec2422f26c4dc2425a7fef20c Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Mon, 18 Feb 2019 16:10:28 +0000
Subject: [PATCH] ASoC: codecs: ad193x: Remove capture support for codecs
 without ADC

Some ad193x codecs don't have ADCs, so they have no capture capabilities.
This way, we can use this driver in multicodec cards.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 4b60ebee491d..21a38cc9e3da 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -351,6 +351,20 @@ static struct snd_soc_dai_driver ad193x_dai = {
 	.ops = &ad193x_dai_ops,
 };
 
+/* codec DAI instance for DAC only */
+static struct snd_soc_dai_driver ad193x_no_adc_dai = {
+	.name = "ad193x-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+	.ops = &ad193x_dai_ops,
+};
+
 static int ad193x_component_probe(struct snd_soc_component *component)
 {
 	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(component);
@@ -444,8 +458,11 @@ int ad193x_probe(struct device *dev, struct regmap *regmap,
 
 	dev_set_drvdata(dev, ad193x);
 
+	if (ad193x_has_adc(ad193x))
+		return devm_snd_soc_register_component(dev, &soc_component_dev_ad193x,
+						       &ad193x_dai, 1);
 	return devm_snd_soc_register_component(dev, &soc_component_dev_ad193x,
-		&ad193x_dai, 1);
+		&ad193x_no_adc_dai, 1);
 }
 EXPORT_SYMBOL_GPL(ad193x_probe);
 
-- 
2.20.1

