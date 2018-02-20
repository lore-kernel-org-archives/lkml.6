Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeBTMJw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:09:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33380 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeBTMJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:09:51 -0500
From: Mark Brown <broonie@kernel.org>
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: evea: fix typo 'eva' -> 'evea'" to the asoc tree
In-Reply-To: <20180220095310.13464-1-suzuki.katsuhiro@socionext.com>
Message-Id: <E1eo6jp-0003Aq-Hk@debutante>
Date: Tue, 20 Feb 2018 12:09:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: evea: fix typo 'eva' -> 'evea'

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

>From 09ad28a31c27df439e838ee5700d4e2dfea0e462 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Tue, 20 Feb 2018 18:53:10 +0900
Subject: [PATCH] ASoC: uniphier: evea: fix typo 'eva' -> 'evea'

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Reviewed-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/evea.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/uniphier/evea.c b/sound/soc/uniphier/evea.c
index cad7e60de21d..ac2d30b55fb6 100644
--- a/sound/soc/uniphier/evea.c
+++ b/sound/soc/uniphier/evea.c
@@ -292,7 +292,7 @@ static int evea_set_switch_hp(struct snd_kcontrol *kcontrol,
 	return evea_update_switch_hp(evea);
 }
 
-static const struct snd_kcontrol_new eva_controls[] = {
+static const struct snd_kcontrol_new evea_controls[] = {
 	SOC_SINGLE_BOOL_EXT("Line Capture Switch", 0,
 			    evea_get_switch_lin, evea_set_switch_lin),
 	SOC_SINGLE_BOOL_EXT("Line Playback Switch", 0,
@@ -384,8 +384,8 @@ static struct snd_soc_component_driver soc_codec_evea = {
 	.num_dapm_widgets	= ARRAY_SIZE(evea_widgets),
 	.dapm_routes		= evea_routes,
 	.num_dapm_routes	= ARRAY_SIZE(evea_routes),
-	.controls		= eva_controls,
-	.num_controls		= ARRAY_SIZE(eva_controls),
+	.controls		= evea_controls,
+	.num_controls		= ARRAY_SIZE(evea_controls),
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-- 
2.16.1
