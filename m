Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9076AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521F4206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887651;
	bh=mivpxZESE7G0LPy/M+uXHsqM0xK8Poy3xT/0twoEyVY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0spsYWT/hg0z9oGWO2qgzdQUoG+fHiAVUFRh9ciOQeCo/EYY9Dfij+Da9gsjKEDbW
	 f79WrPtO29EWxKkVxhzBWAjYx9X2SGxh1RXcrN2ld/+LKo/H2FyuInQbG28UYQ0Ojv
	 hpWedr0LWlW34WnrakWtJjsv0BisEcCG+VAUErqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfAGTAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:00:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41904 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfAGS6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tBPNHJMsq3He/TG9Jf/XcgxGcupI88yskBoA5pzYEmI=; b=K19Gdrh1FdNW
        t6/Gs5TBPqnBxAX7oOCdhN2rXqCjhJVxgbK6yR1RNqkuQUE5lUT41pYfppgiugVZYdvJUAYDwcTec
        phL1bJ4LGJuV1gpEaDZS5HoXiTmKOjTh31lVjlGt/ilFUCcmmE6CmHXQklQyg78YdQ3uuMmwItRek
        jx45E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6f-0007pJ-Of; Mon, 07 Jan 2019 18:58:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 660231127491; Mon,  7 Jan 2019 18:58:37 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: ak4458: Add support for AK4497" to the asoc tree
In-Reply-To:  <20190104162649.13103-2-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185837.660231127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ak4458: Add support for AK4497

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

From ee6047b82888148e688e46f17017cae8e088b246 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Fri, 4 Jan 2019 16:27:03 +0000
Subject: [PATCH] ASoC: ak4458: Add support for AK4497

AK4497 is a 32-bit 2ch DAC and has the same register
map as AK4458 with few exceptions:

* AK4497 has one more register at the end of register space
  DFS_READ which is a read only register that allows users
  to read FS Auto Detection mode. We currently do not use
  this register so we use the same regmap structure as for ak4458.

* Because AK4458 is an 8ch DAC there are some fields that are
  only used by AK4458 and marked as reserved for AK4497, so for
  this reason we need to have a distinct set of controls, widgets
  and routes.

Datasheet for AK4497 is at:
https://www.akm.com/akm/en/file/ev-board-manual/AK4497EQ.pdf

Datasheet for AK4458 is at:
https://www.akm.com/akm/en/file/datasheet/AK4458VN.pdf

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4458.c | 79 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 70d4c89bd6fc..eab7c76cfcd9 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -21,6 +21,11 @@
 
 #include "ak4458.h"
 
+struct ak4458_drvdata {
+	struct snd_soc_dai_driver *dai_drv;
+	const struct snd_soc_component_driver *comp_drv;
+};
+
 /* AK4458 Codec Private Data */
 struct ak4458_priv {
 	struct device *dev;
@@ -258,6 +263,33 @@ static const struct snd_soc_dapm_route ak4458_intercon[] = {
 	{"AK4458 AOUTD",	NULL,	"AK4458 DAC4"},
 };
 
+/* ak4497 controls */
+static const struct snd_kcontrol_new ak4497_snd_controls[] = {
+	SOC_DOUBLE_R_TLV("DAC Playback Volume", AK4458_03_LCHATT,
+			 AK4458_04_RCHATT, 0, 0xFF, 0, dac_tlv),
+	SOC_ENUM("AK4497 De-emphasis Response DAC", ak4458_dac1_dem_enum),
+	SOC_ENUM_EXT("AK4497 Digital Filter Setting", ak4458_digfil_enum,
+		     get_digfil, set_digfil),
+	SOC_ENUM("AK4497 Inverting Enable of DZFB", ak4458_dzfb_enum),
+	SOC_ENUM("AK4497 Sound Mode", ak4458_sm_enum),
+	SOC_ENUM("AK4497 Attenuation transition Time Setting",
+		 ak4458_ats_enum),
+};
+
+/* ak4497 dapm widgets */
+static const struct snd_soc_dapm_widget ak4497_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("AK4497 DAC", NULL, AK4458_0A_CONTROL6, 2, 0),
+	SND_SOC_DAPM_AIF_IN("AK4497 SDTI", "Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("AK4497 AOUT"),
+};
+
+/* ak4497 dapm routes */
+static const struct snd_soc_dapm_route ak4497_intercon[] = {
+	{"AK4497 DAC",		NULL,	"AK4497 SDTI"},
+	{"AK4497 AOUT",		NULL,	"AK4497 DAC"},
+
+};
+
 static int ak4458_rstn_control(struct snd_soc_component *component, int bit)
 {
 	int ret;
@@ -476,6 +508,18 @@ static struct snd_soc_dai_driver ak4458_dai = {
 	.ops = &ak4458_dai_ops,
 };
 
+static struct snd_soc_dai_driver ak4497_dai = {
+	.name = "ak4497-aif",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_KNOT,
+		.formats = AK4458_FORMATS,
+	},
+	.ops = &ak4458_dai_ops,
+};
+
 static void ak4458_power_off(struct ak4458_priv *ak4458)
 {
 	if (ak4458->reset_gpiod) {
@@ -573,6 +617,21 @@ static const struct snd_soc_component_driver soc_codec_dev_ak4458 = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static const struct snd_soc_component_driver soc_codec_dev_ak4497 = {
+	.probe			= ak4458_probe,
+	.remove			= ak4458_remove,
+	.controls		= ak4497_snd_controls,
+	.num_controls		= ARRAY_SIZE(ak4497_snd_controls),
+	.dapm_widgets		= ak4497_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ak4497_dapm_widgets),
+	.dapm_routes		= ak4497_intercon,
+	.num_dapm_routes	= ARRAY_SIZE(ak4497_intercon),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
 static const struct regmap_config ak4458_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -583,6 +642,16 @@ static const struct regmap_config ak4458_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+static const struct ak4458_drvdata ak4458_drvdata = {
+	.dai_drv = &ak4458_dai,
+	.comp_drv = &soc_codec_dev_ak4458,
+};
+
+static const struct ak4458_drvdata ak4497_drvdata = {
+	.dai_drv = &ak4497_dai,
+	.comp_drv = &soc_codec_dev_ak4497,
+};
+
 static const struct dev_pm_ops ak4458_pm = {
 	SET_RUNTIME_PM_OPS(ak4458_runtime_suspend, ak4458_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
@@ -592,6 +661,7 @@ static const struct dev_pm_ops ak4458_pm = {
 static int ak4458_i2c_probe(struct i2c_client *i2c)
 {
 	struct ak4458_priv *ak4458;
+	const struct ak4458_drvdata *drvdata;
 	int ret;
 
 	ak4458 = devm_kzalloc(&i2c->dev, sizeof(*ak4458), GFP_KERNEL);
@@ -605,6 +675,8 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 	i2c_set_clientdata(i2c, ak4458);
 	ak4458->dev = &i2c->dev;
 
+	drvdata = of_device_get_match_data(&i2c->dev);
+
 	ak4458->reset_gpiod = devm_gpiod_get_optional(ak4458->dev, "reset",
 						      GPIOD_OUT_LOW);
 	if (IS_ERR(ak4458->reset_gpiod))
@@ -615,8 +687,8 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 	if (IS_ERR(ak4458->mute_gpiod))
 		return PTR_ERR(ak4458->mute_gpiod);
 
-	ret = devm_snd_soc_register_component(ak4458->dev, &soc_codec_dev_ak4458,
-				     &ak4458_dai, 1);
+	ret = devm_snd_soc_register_component(ak4458->dev, drvdata->comp_drv,
+					      drvdata->dai_drv, 1);
 	if (ret < 0) {
 		dev_err(ak4458->dev, "Failed to register CODEC: %d\n", ret);
 		return ret;
@@ -635,7 +707,8 @@ static int ak4458_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct of_device_id ak4458_of_match[] = {
-	{ .compatible = "asahi-kasei,ak4458", },
+	{ .compatible = "asahi-kasei,ak4458", .data = &ak4458_drvdata},
+	{ .compatible = "asahi-kasei,ak4497", .data = &ak4497_drvdata},
 	{ },
 };
 
-- 
2.20.1

