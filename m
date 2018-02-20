Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeBTJxW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 04:53:22 -0500
Received: from mx.socionext.com ([202.248.49.38]:56431 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751329AbeBTJxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 04:53:20 -0500
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] ASoC: uniphier: evea: fix typo 'eva' -> 'evea'
Date: Tue, 20 Feb 2018 18:53:10 +0900
Message-Id: <20180220095310.13464-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
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
