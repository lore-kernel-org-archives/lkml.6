Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbeDMLXO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:23:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37364 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754155AbeDMLXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:23:13 -0400
From: Mark Brown <broonie@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: max9860: fix whitespace issues caused by mindless conversion" to the asoc tree
In-Reply-To: <20180412211437.21599-2-peda@axentia.se>
Message-Id: <E1f6wnP-0008US-AI@debutante>
Date: Fri, 13 Apr 2018 12:23:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max9860: fix whitespace issues caused by mindless conversion

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

>From 5c1dd6eee4923c89930f35bbc820c5c6af85e096 Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Thu, 12 Apr 2018 23:14:33 +0200
Subject: [PATCH] ASoC: max9860: fix whitespace issues caused by mindless
 conversion

Long lines and bad alignment disturbs the reading pleasure.

Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9860.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 96b2db3f2ddd..c1bd9de5e4a3 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -443,7 +443,8 @@ static int max9860_hw_params(struct snd_pcm_substream *substream,
 		ret = regmap_update_bits(max9860->regmap, MAX9860_AUDIOCLKHIGH,
 					 MAX9860_PLL, MAX9860_PLL);
 		if (ret) {
-			dev_err(component->dev, "Failed to enable PLL: %d\n", ret);
+			dev_err(component->dev, "Failed to enable PLL: %d\n",
+				ret);
 			return ret;
 		}
 	}
@@ -515,7 +516,8 @@ static int max9860_set_bias_level(struct snd_soc_component *component,
 		ret = regmap_update_bits(max9860->regmap, MAX9860_PWRMAN,
 					 MAX9860_SHDN, MAX9860_SHDN);
 		if (ret) {
-			dev_err(component->dev, "Failed to remove SHDN: %d\n", ret);
+			dev_err(component->dev, "Failed to remove SHDN: %d\n",
+				ret);
 			return ret;
 		}
 		break;
@@ -697,7 +699,7 @@ static int max9860_probe(struct i2c_client *i2c)
 	pm_runtime_idle(dev);
 
 	ret = devm_snd_soc_register_component(dev, &max9860_component_driver,
-				     &max9860_dai, 1);
+					      &max9860_dai, 1);
 	if (ret) {
 		dev_err(dev, "Failed to register CODEC: %d\n", ret);
 		goto err_pm;
-- 
2.17.0
