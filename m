Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754388AbeDMLXD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:23:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36956 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754066AbeDMLW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:22:59 -0400
From: Mark Brown <broonie@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: tfa9879: fix whitespace issues caused by mindless conversion" to the asoc tree
In-Reply-To: <20180412211437.21599-3-peda@axentia.se>
Message-Id: <E1f6wnB-0008ST-D7@debutante>
Date: Fri, 13 Apr 2018 12:22:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tfa9879: fix whitespace issues caused by mindless conversion

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

>From 0d9c948bf87ef48a9c729fbe0ec279733f356d06 Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Thu, 12 Apr 2018 23:14:34 +0200
Subject: [PATCH] ASoC: tfa9879: fix whitespace issues caused by mindless
 conversion

Long lines and bad alignment disturbs the reading pleasure.

Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tfa9879.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index 6d213c6d3920..c30e0efdbe39 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -88,13 +88,14 @@ static int tfa9879_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (tfa9879->lsb_justified)
-		snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
-				    TFA9879_I2S_SET_MASK,
-				    i2s_set << TFA9879_I2S_SET_SHIFT);
+		snd_soc_component_update_bits(component,
+					      TFA9879_SERIAL_INTERFACE_1,
+					      TFA9879_I2S_SET_MASK,
+					      i2s_set << TFA9879_I2S_SET_SHIFT);
 
 	snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
-			    TFA9879_I2S_FS_MASK,
-			    fs << TFA9879_I2S_FS_SHIFT);
+				      TFA9879_I2S_FS_MASK,
+				      fs << TFA9879_I2S_FS_SHIFT);
 	return 0;
 }
 
@@ -103,8 +104,8 @@ static int tfa9879_digital_mute(struct snd_soc_dai *dai, int mute)
 	struct snd_soc_component *component = dai->component;
 
 	snd_soc_component_update_bits(component, TFA9879_MISC_CONTROL,
-			    TFA9879_S_MUTE_MASK,
-			    !!mute << TFA9879_S_MUTE_SHIFT);
+				      TFA9879_S_MUTE_MASK,
+				      !!mute << TFA9879_S_MUTE_SHIFT);
 
 	return 0;
 }
@@ -152,11 +153,11 @@ static int tfa9879_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
-			    TFA9879_SCK_POL_MASK,
-			    sck_pol << TFA9879_SCK_POL_SHIFT);
+				      TFA9879_SCK_POL_MASK,
+				      sck_pol << TFA9879_SCK_POL_SHIFT);
 	snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
-			    TFA9879_I2S_SET_MASK,
-			    i2s_set << TFA9879_I2S_SET_SHIFT);
+				      TFA9879_I2S_SET_MASK,
+				      i2s_set << TFA9879_I2S_SET_SHIFT);
 	return 0;
 }
 
@@ -298,7 +299,7 @@ static int tfa9879_i2c_probe(struct i2c_client *i2c,
 			     tfa9879_regs[i].reg, tfa9879_regs[i].def);
 
 	return devm_snd_soc_register_component(&i2c->dev, &tfa9879_component,
-				      &tfa9879_dai, 1);
+					       &tfa9879_dai, 1);
 }
 
 static const struct i2c_device_id tfa9879_i2c_id[] = {
-- 
2.17.0
