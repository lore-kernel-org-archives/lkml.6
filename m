Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EA4C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76A3262C8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="KrUz7PAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76A3262C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753631AbeF0LaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:30:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34524 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeF0LaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=wyvL3dP518e36+dWPiQYfC7BQycPbWkUwcRs2qncXBQ=; b=KrUz7PAuszYU
        5e+uj5Z2XeVXw08z1b+F9f9KG/8+/VRtTRyRZucjkCuDC/JzlL42E3trMmh4eL1L+Pddej5HITEMn
        O/AbOOaaRzqlG82YqTyXSRmoZibZpjfqF6rGAd1hM3R5Sk1Si2qj8GpsFxH6LORfHfAoSPrP1k39+
        dZEYA=;
Received: from 188.29.164.103.threembb.co.uk ([188.29.164.103] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fY8eL-0002vF-Gk; Wed, 27 Jun 2018 11:30:13 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AE553440070; Wed, 27 Jun 2018 12:30:11 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: tas517x: add tas5707 support" to the asoc tree
In-Reply-To:  <20180627073937.29912-3-jbrunet@baylibre.com>
Message-Id: <20180627113011.AE553440070@finisterre.ee.mobilebroadband>
Date:   Wed, 27 Jun 2018 12:30:11 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tas517x: add tas5707 support

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

From f516d32262a4c0fef3fccdf2a82671f54f5c1e33 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 27 Jun 2018 09:39:37 +0200
Subject: [PATCH] ASoC: tas517x: add tas5707 support

Add support for the tas5707 audio power amplifier.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig   |   5 +-
 sound/soc/codecs/tas571x.c | 110 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tas571x.h |  16 ++++++
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 53c2d726bedf..6d1674699385 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -959,8 +959,11 @@ config SND_SOC_TAS5086
 	depends on I2C
 
 config SND_SOC_TAS571X
-	tristate "Texas Instruments TAS5711/TAS5717/TAS5719/TAS5721 power amplifiers"
+	tristate "Texas Instruments TAS571x power amplifiers"
 	depends on I2C
+	help
+	  Enable support for Texas Instruments TAS5707, TAS5711, TAS5717,
+	  TAS5719 and TAS5721 power amplifiers
 
 config SND_SOC_TAS5720
 	tristate "Texas Instruments TAS5720 Mono Audio amplifier"
diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 52f34c94ec25..ca2dfe12344e 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -7,6 +7,9 @@
  * TAS5721 support:
  * Copyright (C) 2016 Petr Kulhavy, Barix AG <petr@barix.com>
  *
+ * TAS5707 support:
+ * Copyright (C) 2018 Jerome Brunet, Baylibre SAS <jbrunet@baylibre.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -444,6 +447,111 @@ static const struct tas571x_chip tas5711_chip = {
 	.vol_reg_size			= 1,
 };
 
+static const struct regmap_range tas5707_volatile_regs_range[] = {
+	regmap_reg_range(TAS571X_CLK_CTRL_REG,  TAS571X_ERR_STATUS_REG),
+	regmap_reg_range(TAS571X_OSC_TRIM_REG,  TAS571X_OSC_TRIM_REG),
+	regmap_reg_range(TAS5707_CH1_BQ0_REG, TAS5707_CH2_BQ6_REG),
+};
+
+static const struct regmap_access_table tas5707_volatile_regs = {
+	.yes_ranges =	tas5707_volatile_regs_range,
+	.n_yes_ranges =	ARRAY_SIZE(tas5707_volatile_regs_range),
+
+};
+
+static const DECLARE_TLV_DB_SCALE(tas5707_volume_tlv, -7900, 50, 1);
+
+static const char * const tas5707_volume_slew_step_txt[] = {
+	"256", "512", "1024", "2048",
+};
+
+static const unsigned int tas5707_volume_slew_step_values[] = {
+	3, 0, 1, 2,
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(tas5707_volume_slew_step_enum,
+				  TAS571X_VOL_CFG_REG, 0, 0x3,
+				  tas5707_volume_slew_step_txt,
+				  tas5707_volume_slew_step_values);
+
+static const struct snd_kcontrol_new tas5707_controls[] = {
+	SOC_SINGLE_TLV("Master Volume",
+		       TAS571X_MVOL_REG,
+		       0, 0xff, 1, tas5707_volume_tlv),
+	SOC_DOUBLE_R_TLV("Speaker Volume",
+			 TAS571X_CH1_VOL_REG,
+			 TAS571X_CH2_VOL_REG,
+			 0, 0xff, 1, tas5707_volume_tlv),
+	SOC_DOUBLE("Speaker Switch",
+		   TAS571X_SOFT_MUTE_REG,
+		   TAS571X_SOFT_MUTE_CH1_SHIFT, TAS571X_SOFT_MUTE_CH2_SHIFT,
+		   1, 1),
+
+	SOC_ENUM("Slew Rate Steps", tas5707_volume_slew_step_enum),
+
+	BIQUAD_COEFS("CH1 - Biquad 0", TAS5707_CH1_BQ0_REG),
+	BIQUAD_COEFS("CH1 - Biquad 1", TAS5707_CH1_BQ1_REG),
+	BIQUAD_COEFS("CH1 - Biquad 2", TAS5707_CH1_BQ2_REG),
+	BIQUAD_COEFS("CH1 - Biquad 3", TAS5707_CH1_BQ3_REG),
+	BIQUAD_COEFS("CH1 - Biquad 4", TAS5707_CH1_BQ4_REG),
+	BIQUAD_COEFS("CH1 - Biquad 5", TAS5707_CH1_BQ5_REG),
+	BIQUAD_COEFS("CH1 - Biquad 6", TAS5707_CH1_BQ6_REG),
+
+	BIQUAD_COEFS("CH2 - Biquad 0", TAS5707_CH2_BQ0_REG),
+	BIQUAD_COEFS("CH2 - Biquad 1", TAS5707_CH2_BQ1_REG),
+	BIQUAD_COEFS("CH2 - Biquad 2", TAS5707_CH2_BQ2_REG),
+	BIQUAD_COEFS("CH2 - Biquad 3", TAS5707_CH2_BQ3_REG),
+	BIQUAD_COEFS("CH2 - Biquad 4", TAS5707_CH2_BQ4_REG),
+	BIQUAD_COEFS("CH2 - Biquad 5", TAS5707_CH2_BQ5_REG),
+	BIQUAD_COEFS("CH2 - Biquad 6", TAS5707_CH2_BQ6_REG),
+};
+
+static const struct reg_default tas5707_reg_defaults[] = {
+	{TAS571X_CLK_CTRL_REG,		0x6c},
+	{TAS571X_DEV_ID_REG,		0x70},
+	{TAS571X_ERR_STATUS_REG,	0x00},
+	{TAS571X_SYS_CTRL_1_REG,	0xa0},
+	{TAS571X_SDI_REG,		0x05},
+	{TAS571X_SYS_CTRL_2_REG,	0x40},
+	{TAS571X_SOFT_MUTE_REG,		0x00},
+	{TAS571X_MVOL_REG,		0xff},
+	{TAS571X_CH1_VOL_REG,		0x30},
+	{TAS571X_CH2_VOL_REG,		0x30},
+	{TAS571X_VOL_CFG_REG,		0x91},
+	{TAS571X_MODULATION_LIMIT_REG,	0x02},
+	{TAS571X_IC_DELAY_CH1_REG,	0xac},
+	{TAS571X_IC_DELAY_CH2_REG,	0x54},
+	{TAS571X_IC_DELAY_CH3_REG,	0xac},
+	{TAS571X_IC_DELAY_CH4_REG,	0x54},
+	{TAS571X_START_STOP_PERIOD_REG,	0x0f},
+	{TAS571X_OSC_TRIM_REG,		0x82},
+	{TAS571X_BKND_ERR_REG,		0x02},
+	{TAS571X_INPUT_MUX_REG,		0x17772},
+	{TAS571X_PWM_MUX_REG,		0x1021345},
+};
+
+static const struct regmap_config tas5707_regmap_config = {
+	.reg_bits			= 8,
+	.val_bits			= 32,
+	.max_register			= 0xff,
+	.reg_read			= tas571x_reg_read,
+	.reg_write			= tas571x_reg_write,
+	.reg_defaults			= tas5707_reg_defaults,
+	.num_reg_defaults		= ARRAY_SIZE(tas5707_reg_defaults),
+	.cache_type			= REGCACHE_RBTREE,
+	.wr_table			= &tas571x_write_regs,
+	.volatile_table			= &tas5707_volatile_regs,
+};
+
+static const struct tas571x_chip tas5707_chip = {
+	.supply_names			= tas5711_supply_names,
+	.num_supply_names		= ARRAY_SIZE(tas5711_supply_names),
+	.controls			= tas5707_controls,
+	.num_controls			= ARRAY_SIZE(tas5707_controls),
+	.regmap_config			= &tas5707_regmap_config,
+	.vol_reg_size			= 1,
+};
+
 static const char *const tas5717_supply_names[] = {
 	"AVDD",
 	"DVDD",
@@ -775,6 +883,7 @@ static int tas571x_i2c_remove(struct i2c_client *client)
 }
 
 static const struct of_device_id tas571x_of_match[] = {
+	{ .compatible = "ti,tas5707", .data = &tas5707_chip, },
 	{ .compatible = "ti,tas5711", .data = &tas5711_chip, },
 	{ .compatible = "ti,tas5717", .data = &tas5717_chip, },
 	{ .compatible = "ti,tas5719", .data = &tas5717_chip, },
@@ -784,6 +893,7 @@ static const struct of_device_id tas571x_of_match[] = {
 MODULE_DEVICE_TABLE(of, tas571x_of_match);
 
 static const struct i2c_device_id tas571x_i2c_id[] = {
+	{ "tas5707", (kernel_ulong_t) &tas5707_chip },
 	{ "tas5711", (kernel_ulong_t) &tas5711_chip },
 	{ "tas5717", (kernel_ulong_t) &tas5717_chip },
 	{ "tas5719", (kernel_ulong_t) &tas5717_chip },
diff --git a/sound/soc/codecs/tas571x.h b/sound/soc/codecs/tas571x.h
index c45677bc26ad..bd23e89cfe79 100644
--- a/sound/soc/codecs/tas571x.h
+++ b/sound/soc/codecs/tas571x.h
@@ -53,6 +53,22 @@
 #define TAS571X_PWM_MUX_REG		0x25
 
 /* 20-byte biquad registers */
+#define TAS5707_CH1_BQ0_REG		0x29
+#define TAS5707_CH1_BQ1_REG		0x2a
+#define TAS5707_CH1_BQ2_REG		0x2b
+#define TAS5707_CH1_BQ3_REG		0x2c
+#define TAS5707_CH1_BQ4_REG		0x2d
+#define TAS5707_CH1_BQ5_REG		0x2e
+#define TAS5707_CH1_BQ6_REG		0x2f
+
+#define TAS5707_CH2_BQ0_REG		0x30
+#define TAS5707_CH2_BQ1_REG		0x31
+#define TAS5707_CH2_BQ2_REG		0x32
+#define TAS5707_CH2_BQ3_REG		0x33
+#define TAS5707_CH2_BQ4_REG		0x34
+#define TAS5707_CH2_BQ5_REG		0x35
+#define TAS5707_CH2_BQ6_REG		0x36
+
 #define TAS5717_CH1_BQ0_REG		0x26
 #define TAS5717_CH1_BQ1_REG		0x27
 #define TAS5717_CH1_BQ2_REG		0x28
-- 
2.17.1

