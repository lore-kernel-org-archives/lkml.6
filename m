Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIM_INVALID,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A78EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F122087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="kf/87zQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F122087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeH2AWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:22:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38336 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH2AWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ySIMcWhfYvces2vIVzWXmFD+kaB62b7tn6Em3UNd3ow=; b=kf/87zQjxrtz
        Lzhrg7ttpldkwmrRR8cER9hTm+igFI/WjTjxpX5A9+Xjy9ZgkV2Ov3lY9Z/pzSo2uj5sV9G82bpOA
        y7YUtEwOTrU3i3QRTGhXTVHMR/qCAdqxKTBRlvLKJeHHjiZXxlV0PTeerzBKHp6kNn160hIPA25oJ
        f9a+k=;
Received: from 188.29.165.122.threembb.co.uk ([188.29.165.122] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fukbV-0007gP-4p; Tue, 28 Aug 2018 20:28:45 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 09FE4440078; Tue, 28 Aug 2018 21:28:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        M R Swami Reddy <mr.swami.reddy@ti.com>,
        Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
        M R Swami Reddy <mr.swami.reddy@ti.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: pcm3060: Add codec driver" to the asoc tree
In-Reply-To:  <20180821165246.9479-2-kmarinushkin@birdec.tech>
Message-Id: <20180828202824.09FE4440078@finisterre.ee.mobilebroadband>
Date:   Tue, 28 Aug 2018 21:28:23 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: pcm3060: Add codec driver

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

From 6ee47d4a8dacfa484d526c0475730568d979de24 Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Date: Tue, 21 Aug 2018 18:52:46 +0200
Subject: [PATCH] ASoC: pcm3060: Add codec driver

This commit adds support for TI PCM3060 CODEC.
The technical documentation is available at [1].

[1] http://ti.com/product/pcm3060

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: M R Swami Reddy <mr.swami.reddy@ti.com>
Cc: Vishwas A Deshpande <vishwas.a.deshpande@ti.com>
Cc: Kevin Cernekee <cernekee@chromium.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/pcm3060.txt     |  17 +
 MAINTAINERS                                   |   7 +
 sound/soc/codecs/Kconfig                      |  17 +
 sound/soc/codecs/Makefile                     |   6 +
 sound/soc/codecs/pcm3060-i2c.c                |  61 ++++
 sound/soc/codecs/pcm3060-spi.c                |  60 ++++
 sound/soc/codecs/pcm3060.c                    | 290 ++++++++++++++++++
 sound/soc/codecs/pcm3060.h                    |  88 ++++++
 8 files changed, 546 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/pcm3060.txt
 create mode 100644 sound/soc/codecs/pcm3060-i2c.c
 create mode 100644 sound/soc/codecs/pcm3060-spi.c
 create mode 100644 sound/soc/codecs/pcm3060.c
 create mode 100644 sound/soc/codecs/pcm3060.h

diff --git a/Documentation/devicetree/bindings/sound/pcm3060.txt b/Documentation/devicetree/bindings/sound/pcm3060.txt
new file mode 100644
index 000000000000..90fcb8523099
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/pcm3060.txt
@@ -0,0 +1,17 @@
+PCM3060 audio CODEC
+
+This driver supports both I2C and SPI.
+
+Required properties:
+
+- compatible: "ti,pcm3060"
+
+- reg : the I2C address of the device for I2C, the chip select
+        number for SPI.
+
+Examples:
+
+	pcm3060: pcm3060@46 {
+		 compatible = "ti,pcm3060";
+		 reg = <0x46>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..161b26e05732 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14597,6 +14597,13 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/ti/netcp*
 
+TI PCM3060 ASoC CODEC DRIVER
+M:	Kirill Marinushkin <kmarinushkin@birdec.tech>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/pcm3060.txt
+F:	sound/soc/codecs/pcm3060*
+
 TI TAS571X FAMILY ASoC CODEC DRIVER
 M:	Kevin Cernekee <cernekee@chromium.org>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index bf0b949eb7e8..adaf26e1989c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -120,6 +120,8 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_PCM186X_I2C if I2C
 	select SND_SOC_PCM186X_SPI if SPI_MASTER
 	select SND_SOC_PCM3008
+	select SND_SOC_PCM3060_I2C if I2C
+	select SND_SOC_PCM3060_SPI if SPI_MASTER
 	select SND_SOC_PCM3168A_I2C if I2C
 	select SND_SOC_PCM3168A_SPI if SPI_MASTER
 	select SND_SOC_PCM5102A
@@ -737,6 +739,21 @@ config SND_SOC_PCM186X_SPI
 config SND_SOC_PCM3008
        tristate
 
+config SND_SOC_PCM3060
+       tristate
+
+config SND_SOC_PCM3060_I2C
+	tristate "Texas Instruments PCM3060 CODEC - I2C"
+	depends on I2C
+	select SND_SOC_PCM3060
+	select REGMAP_I2C
+
+config SND_SOC_PCM3060_SPI
+	tristate "Texas Instruments PCM3060 CODEC - SPI"
+	depends on SPI_MASTER
+	select SND_SOC_PCM3060
+	select REGMAP_SPI
+
 config SND_SOC_PCM3168A
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 3046b33ca9d3..3d694c26192c 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -120,6 +120,9 @@ snd-soc-pcm186x-objs := pcm186x.o
 snd-soc-pcm186x-i2c-objs := pcm186x-i2c.o
 snd-soc-pcm186x-spi-objs := pcm186x-spi.o
 snd-soc-pcm3008-objs := pcm3008.o
+snd-soc-pcm3060-objs := pcm3060.o
+snd-soc-pcm3060-i2c-objs := pcm3060-i2c.o
+snd-soc-pcm3060-spi-objs := pcm3060-spi.o
 snd-soc-pcm3168a-objs := pcm3168a.o
 snd-soc-pcm3168a-i2c-objs := pcm3168a-i2c.o
 snd-soc-pcm3168a-spi-objs := pcm3168a-spi.o
@@ -381,6 +384,9 @@ obj-$(CONFIG_SND_SOC_PCM186X)	+= snd-soc-pcm186x.o
 obj-$(CONFIG_SND_SOC_PCM186X_I2C)	+= snd-soc-pcm186x-i2c.o
 obj-$(CONFIG_SND_SOC_PCM186X_SPI)	+= snd-soc-pcm186x-spi.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
+obj-$(CONFIG_SND_SOC_PCM3060)	+= snd-soc-pcm3060.o
+obj-$(CONFIG_SND_SOC_PCM3060_I2C)	+= snd-soc-pcm3060-i2c.o
+obj-$(CONFIG_SND_SOC_PCM3060_SPI)	+= snd-soc-pcm3060-spi.o
 obj-$(CONFIG_SND_SOC_PCM3168A)	+= snd-soc-pcm3168a.o
 obj-$(CONFIG_SND_SOC_PCM3168A_I2C)	+= snd-soc-pcm3168a-i2c.o
 obj-$(CONFIG_SND_SOC_PCM3168A_SPI)	+= snd-soc-pcm3168a-spi.o
diff --git a/sound/soc/codecs/pcm3060-i2c.c b/sound/soc/codecs/pcm3060-i2c.c
new file mode 100644
index 000000000000..03d2b4323626
--- /dev/null
+++ b/sound/soc/codecs/pcm3060-i2c.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCM3060 I2C driver
+ *
+ * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <sound/soc.h>
+
+#include "pcm3060.h"
+
+static int pcm3060_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
+{
+	struct pcm3060_priv *priv;
+
+	priv = devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, priv);
+
+	priv->regmap = devm_regmap_init_i2c(i2c, &pcm3060_regmap);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	return pcm3060_probe(&i2c->dev);
+}
+
+static const struct i2c_device_id pcm3060_i2c_id[] = {
+	{ .name = "pcm3060" },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, pcm3060_i2c_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id pcm3060_of_match[] = {
+	{ .compatible = "ti,pcm3060" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pcm3060_of_match);
+#endif /* CONFIG_OF */
+
+static struct i2c_driver pcm3060_i2c_driver = {
+	.driver = {
+		.name = "pcm3060",
+#ifdef CONFIG_OF
+		.of_match_table = pcm3060_of_match,
+#endif /* CONFIG_OF */
+	},
+	.id_table = pcm3060_i2c_id,
+	.probe = pcm3060_i2c_probe,
+};
+
+module_i2c_driver(pcm3060_i2c_driver);
+
+MODULE_DESCRIPTION("PCM3060 I2C driver");
+MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.tech>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm3060-spi.c b/sound/soc/codecs/pcm3060-spi.c
new file mode 100644
index 000000000000..8961e095ae73
--- /dev/null
+++ b/sound/soc/codecs/pcm3060-spi.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCM3060 SPI driver
+ *
+ * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
+ */
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <sound/soc.h>
+
+#include "pcm3060.h"
+
+static int pcm3060_spi_probe(struct spi_device *spi)
+{
+	struct pcm3060_priv *priv;
+
+	priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, priv);
+
+	priv->regmap = devm_regmap_init_spi(spi, &pcm3060_regmap);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	return pcm3060_probe(&spi->dev);
+}
+
+static const struct spi_device_id pcm3060_spi_id[] = {
+	{ .name = "pcm3060" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, pcm3060_spi_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id pcm3060_of_match[] = {
+	{ .compatible = "ti,pcm3060" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pcm3060_of_match);
+#endif /* CONFIG_OF */
+
+static struct spi_driver pcm3060_spi_driver = {
+	.driver = {
+		.name = "pcm3060",
+#ifdef CONFIG_OF
+		.of_match_table = pcm3060_of_match,
+#endif /* CONFIG_OF */
+	},
+	.id_table = pcm3060_spi_id,
+	.probe = pcm3060_spi_probe,
+};
+
+module_spi_driver(pcm3060_spi_driver);
+
+MODULE_DESCRIPTION("PCM3060 SPI driver");
+MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.tech>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
new file mode 100644
index 000000000000..ef7c627c9ac5
--- /dev/null
+++ b/sound/soc/codecs/pcm3060.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCM3060 codec driver
+ *
+ * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
+ */
+
+#include <linux/module.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "pcm3060.h"
+
+/* dai */
+
+static int pcm3060_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+			      unsigned int freq, int dir)
+{
+	struct snd_soc_component *comp = dai->component;
+	struct pcm3060_priv *priv = snd_soc_component_get_drvdata(comp);
+
+	if (dir != SND_SOC_CLOCK_IN) {
+		dev_err(comp->dev, "unsupported sysclock dir: %d\n", dir);
+		return -EINVAL;
+	}
+
+	priv->dai[dai->id].sclk_freq = freq;
+
+	return 0;
+}
+
+static int pcm3060_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *comp = dai->component;
+	struct pcm3060_priv *priv = snd_soc_component_get_drvdata(comp);
+	unsigned int reg;
+	unsigned int val;
+
+	if ((fmt & SND_SOC_DAIFMT_INV_MASK) != SND_SOC_DAIFMT_NB_NF) {
+		dev_err(comp->dev, "unsupported DAI polarity: 0x%x\n", fmt);
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		priv->dai[dai->id].is_master = true;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		priv->dai[dai->id].is_master = false;
+		break;
+	default:
+		dev_err(comp->dev, "unsupported DAI master mode: 0x%x\n", fmt);
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		val = PCM3060_REG_FMT_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		val = PCM3060_REG_FMT_RJ;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		val = PCM3060_REG_FMT_LJ;
+		break;
+	default:
+		dev_err(comp->dev, "unsupported DAI format: 0x%x\n", fmt);
+		return -EINVAL;
+	}
+
+	reg = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG67 : PCM3060_REG72);
+
+	regmap_update_bits(priv->regmap, reg, PCM3060_REG_MASK_FMT, val);
+
+	return 0;
+}
+
+static int pcm3060_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *comp = dai->component;
+	struct pcm3060_priv *priv = snd_soc_component_get_drvdata(comp);
+	unsigned int rate;
+	unsigned int ratio;
+	unsigned int reg;
+	unsigned int val;
+
+	if (!priv->dai[dai->id].is_master) {
+		val = PCM3060_REG_MS_S;
+		goto val_ready;
+	}
+
+	rate = params_rate(params);
+	if (!rate) {
+		dev_err(comp->dev, "rate is not configured\n");
+		return -EINVAL;
+	}
+
+	ratio = priv->dai[dai->id].sclk_freq / rate;
+
+	switch (ratio) {
+	case 768:
+		val = PCM3060_REG_MS_M768;
+		break;
+	case 512:
+		val = PCM3060_REG_MS_M512;
+		break;
+	case 384:
+		val = PCM3060_REG_MS_M384;
+		break;
+	case 256:
+		val = PCM3060_REG_MS_M256;
+		break;
+	case 192:
+		val = PCM3060_REG_MS_M192;
+		break;
+	case 128:
+		val = PCM3060_REG_MS_M128;
+		break;
+	default:
+		dev_err(comp->dev, "unsupported ratio: %d\n", ratio);
+		return -EINVAL;
+	}
+
+val_ready:
+	reg = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG67 : PCM3060_REG72);
+
+	regmap_update_bits(priv->regmap, reg, PCM3060_REG_MASK_MS, val);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops pcm3060_dai_ops = {
+	.set_sysclk = pcm3060_set_sysclk,
+	.set_fmt = pcm3060_set_fmt,
+	.hw_params = pcm3060_hw_params,
+};
+
+#define PCM3060_DAI_RATES_ADC	(SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_32000 | \
+				 SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | \
+				 SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+
+#define PCM3060_DAI_RATES_DAC	(PCM3060_DAI_RATES_ADC | \
+				 SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000)
+
+static struct snd_soc_dai_driver pcm3060_dai[] = {
+	{
+		.name = "pcm3060-dac",
+		.id = PCM3060_DAI_ID_DAC,
+		.playback = {
+			.stream_name = "Playback",
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = PCM3060_DAI_RATES_DAC,
+			.formats = SNDRV_PCM_FMTBIT_S24_LE,
+		},
+		.ops = &pcm3060_dai_ops,
+	},
+	{
+		.name = "pcm3060-adc",
+		.id = PCM3060_DAI_ID_ADC,
+		.capture = {
+			.stream_name = "Capture",
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = PCM3060_DAI_RATES_ADC,
+			.formats = SNDRV_PCM_FMTBIT_S24_LE,
+		},
+		.ops = &pcm3060_dai_ops,
+	},
+};
+
+/* dapm */
+
+static DECLARE_TLV_DB_SCALE(pcm3060_dapm_tlv, -10050, 50, 1);
+
+static const struct snd_kcontrol_new pcm3060_dapm_controls[] = {
+	SOC_DOUBLE_R_RANGE_TLV("Master Playback Volume",
+			       PCM3060_REG65, PCM3060_REG66, 0,
+			       PCM3060_REG_AT2_MIN, PCM3060_REG_AT2_MAX,
+			       0, pcm3060_dapm_tlv),
+	SOC_DOUBLE("Master Playback Switch", PCM3060_REG68,
+		   PCM3060_REG_SHIFT_MUT21, PCM3060_REG_SHIFT_MUT22, 1, 1),
+
+	SOC_DOUBLE_R_RANGE_TLV("Master Capture Volume",
+			       PCM3060_REG70, PCM3060_REG71, 0,
+			       PCM3060_REG_AT1_MIN, PCM3060_REG_AT1_MAX,
+			       0, pcm3060_dapm_tlv),
+	SOC_DOUBLE("Master Capture Switch", PCM3060_REG73,
+		   PCM3060_REG_SHIFT_MUT11, PCM3060_REG_SHIFT_MUT12, 1, 1),
+};
+
+static const struct snd_soc_dapm_widget pcm3060_dapm_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("OUTL+"),
+	SND_SOC_DAPM_OUTPUT("OUTR+"),
+	SND_SOC_DAPM_OUTPUT("OUTL-"),
+	SND_SOC_DAPM_OUTPUT("OUTR-"),
+
+	SND_SOC_DAPM_INPUT("INL"),
+	SND_SOC_DAPM_INPUT("INR"),
+};
+
+static const struct snd_soc_dapm_route pcm3060_dapm_map[] = {
+	{ "OUTL+", NULL, "Playback" },
+	{ "OUTR+", NULL, "Playback" },
+	{ "OUTL-", NULL, "Playback" },
+	{ "OUTR-", NULL, "Playback" },
+
+	{ "Capture", NULL, "INL" },
+	{ "Capture", NULL, "INR" },
+};
+
+/* soc component */
+
+static const struct snd_soc_component_driver pcm3060_soc_comp_driver = {
+	.controls = pcm3060_dapm_controls,
+	.num_controls = ARRAY_SIZE(pcm3060_dapm_controls),
+	.dapm_widgets = pcm3060_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(pcm3060_dapm_widgets),
+	.dapm_routes = pcm3060_dapm_map,
+	.num_dapm_routes = ARRAY_SIZE(pcm3060_dapm_map),
+};
+
+/* regmap */
+
+static bool pcm3060_reg_writeable(struct device *dev, unsigned int reg)
+{
+	return (reg >= PCM3060_REG64);
+}
+
+static bool pcm3060_reg_readable(struct device *dev, unsigned int reg)
+{
+	return (reg >= PCM3060_REG64);
+}
+
+static bool pcm3060_reg_volatile(struct device *dev, unsigned int reg)
+{
+	/* PCM3060_REG64 is volatile */
+	return (reg == PCM3060_REG64);
+}
+
+static const struct reg_default pcm3060_reg_defaults[] = {
+	{ PCM3060_REG64,  0xF0 },
+	{ PCM3060_REG65,  0xFF },
+	{ PCM3060_REG66,  0xFF },
+	{ PCM3060_REG67,  0x00 },
+	{ PCM3060_REG68,  0x00 },
+	{ PCM3060_REG69,  0x00 },
+	{ PCM3060_REG70,  0xD7 },
+	{ PCM3060_REG71,  0xD7 },
+	{ PCM3060_REG72,  0x00 },
+	{ PCM3060_REG73,  0x00 },
+};
+
+const struct regmap_config pcm3060_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.writeable_reg = pcm3060_reg_writeable,
+	.readable_reg = pcm3060_reg_readable,
+	.volatile_reg = pcm3060_reg_volatile,
+	.max_register = PCM3060_REG73,
+	.reg_defaults = pcm3060_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(pcm3060_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+EXPORT_SYMBOL(pcm3060_regmap);
+
+/* device */
+
+int pcm3060_probe(struct device *dev)
+{
+	int rc;
+
+	rc = devm_snd_soc_register_component(dev, &pcm3060_soc_comp_driver,
+					     pcm3060_dai,
+					     ARRAY_SIZE(pcm3060_dai));
+	if (rc) {
+		dev_err(dev, "failed to register component, rc=%d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(pcm3060_probe);
+
+MODULE_DESCRIPTION("PCM3060 codec driver");
+MODULE_AUTHOR("Kirill Marinushkin <kmarinushkin@birdec.tech>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
new file mode 100644
index 000000000000..fd89a68aa8a7
--- /dev/null
+++ b/sound/soc/codecs/pcm3060.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCM3060 codec driver
+ *
+ * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
+ */
+
+#ifndef _SND_SOC_PCM3060_H
+#define _SND_SOC_PCM3060_H
+
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+extern const struct regmap_config pcm3060_regmap;
+
+#define PCM3060_DAI_ID_DAC	0
+#define PCM3060_DAI_ID_ADC	1
+#define PCM3060_DAI_IDS_NUM	2
+
+struct pcm3060_priv_dai {
+	bool is_master;
+	unsigned int sclk_freq;
+};
+
+struct pcm3060_priv {
+	struct regmap *regmap;
+	struct pcm3060_priv_dai dai[PCM3060_DAI_IDS_NUM];
+};
+
+int pcm3060_probe(struct device *dev);
+int pcm3060_remove(struct device *dev);
+
+/* registers */
+
+#define PCM3060_REG64			0x40
+#define PCM3060_REG_MRST		0x80
+#define PCM3060_REG_SRST		0x40
+#define PCM3060_REG_ADPSV		0x20
+#define PCM3060_REG_DAPSV		0x10
+#define PCM3060_REG_SE			0x01
+
+#define PCM3060_REG65			0x41
+#define PCM3060_REG66			0x42
+#define PCM3060_REG_AT2_MIN		0x36
+#define PCM3060_REG_AT2_MAX		0xFF
+
+#define PCM3060_REG67			0x43
+#define PCM3060_REG72			0x48
+#define PCM3060_REG_CSEL		0x80
+#define PCM3060_REG_MASK_MS		0x70
+#define PCM3060_REG_MS_S		0x00
+#define PCM3060_REG_MS_M768		(0x01 << 4)
+#define PCM3060_REG_MS_M512		(0x02 << 4)
+#define PCM3060_REG_MS_M384		(0x03 << 4)
+#define PCM3060_REG_MS_M256		(0x04 << 4)
+#define PCM3060_REG_MS_M192		(0x05 << 4)
+#define PCM3060_REG_MS_M128		(0x06 << 4)
+#define PCM3060_REG_MASK_FMT		0x03
+#define PCM3060_REG_FMT_I2S		0x00
+#define PCM3060_REG_FMT_LJ		0x01
+#define PCM3060_REG_FMT_RJ		0x02
+
+#define PCM3060_REG68			0x44
+#define PCM3060_REG_OVER		0x40
+#define PCM3060_REG_DREV2		0x04
+#define PCM3060_REG_SHIFT_MUT21	0x00
+#define PCM3060_REG_SHIFT_MUT22	0x01
+
+#define PCM3060_REG69			0x45
+#define PCM3060_REG_FLT		0x80
+#define PCM3060_REG_MASK_DMF		0x60
+#define PCM3060_REG_DMC		0x10
+#define PCM3060_REG_ZREV		0x02
+#define PCM3060_REG_AZRO		0x01
+
+#define PCM3060_REG70			0x46
+#define PCM3060_REG71			0x47
+#define PCM3060_REG_AT1_MIN		0x0E
+#define PCM3060_REG_AT1_MAX		0xFF
+
+#define PCM3060_REG73			0x49
+#define PCM3060_REG_ZCDD		0x10
+#define PCM3060_REG_BYP		0x08
+#define PCM3060_REG_DREV1		0x04
+#define PCM3060_REG_SHIFT_MUT11	0x00
+#define PCM3060_REG_SHIFT_MUT12	0x01
+
+#endif /* _SND_SOC_PCM3060_H */
-- 
2.18.0

