Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68DFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7850E206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864235;
	bh=zR/CUkkZyN6m/uYCImEhY7M+n5J2xLOcVLIP3AtiBo8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=WVSo5zWMzXfmCUH32ivNPVlt8/3MVizmaRpEMqdomPCHY+Kkrs43R1TX5M2cK7/nk
	 eX8wEVc1XdnilCmam0UZuA/7f46OODTCWmTXWhia5L3yhT/uPLxRXXqeWpQp+zR/AH
	 4DerhKNOhFTJMKnwaDCeNvRpPsxpvKd/zGXCLS7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfAGMae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:30:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38818 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfAGMae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aOtoosd4+lraNWrm4UzXbozQUEiWpsK/L4DGakb1hcw=; b=BhXRDzClGkiL
        uhso7z5uT+mGqpdwVwmQIBoizppXYgkrzYh+3/EluxFFFV8Jn7pK2MojDmxWIGNUsutuOtREclRpE
        U6fwCXGJnRvCqDw230flhCfgrZF3XLoezl9VbtY5y18WiJoXtxu1LxUUzC28E0yWhmAIwZVAi/+Tt
        ingbo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ggU34-0006j4-HR; Mon, 07 Jan 2019 12:30:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 128F21127490; Mon,  7 Jan 2019 12:30:30 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        jsarha@ti.com, robh+dt@kernel.org, misael.lopez@ti.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: ti: davinci-mcasp: Add support for GPIO mode of the pins" to the asoc tree
In-Reply-To:  <20190103140552.29809-4-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107123030.128F21127490@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 12:30:30 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ti: davinci-mcasp: Add support for GPIO mode of the pins

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

From 540f1ba7b3a5596827a3bfeaae9c5e754347c933 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 3 Jan 2019 16:05:52 +0200
Subject: [PATCH] ASoC: ti: davinci-mcasp: Add support for GPIO mode of the
 pins

All McASP pin can be configured as GPIO.
Add gpiochip support for McASP and only enable it when the
gpio-controller is present in the DT node.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 159 ++++++++++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 3 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index a6a470a76900..a3a67a8f0f54 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -29,6 +29,7 @@
 #include <linux/platform_data/davinci_asp.h>
 #include <linux/math64.h>
 #include <linux/bitmap.h>
+#include <linux/gpio/driver.h>
 
 #include <sound/asoundef.h>
 #include <sound/core.h>
@@ -54,6 +55,7 @@ static u32 context_regs[] = {
 	DAVINCI_MCASP_AHCLKXCTL_REG,
 	DAVINCI_MCASP_AHCLKRCTL_REG,
 	DAVINCI_MCASP_PDIR_REG,
+	DAVINCI_MCASP_PFUNC_REG,
 	DAVINCI_MCASP_RXMASK_REG,
 	DAVINCI_MCASP_TXMASK_REG,
 	DAVINCI_MCASP_RXTDM_REG,
@@ -108,6 +110,10 @@ struct davinci_mcasp {
 	/* Used for comstraint setting on the second stream */
 	u32	channels;
 
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gpio_chip;
+#endif
+
 #ifdef CONFIG_PM
 	struct davinci_mcasp_context context;
 #endif
@@ -818,9 +824,6 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 	if (mcasp->version < MCASP_VERSION_3)
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
 
-	/* All PINS as McASP */
-	mcasp_set_reg(mcasp, DAVINCI_MCASP_PFUNC_REG, 0x00000000);
-
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_XEVTCTL_REG, TXDATADMADIS);
@@ -1845,6 +1848,147 @@ static u32 davinci_mcasp_rxdma_offset(struct davinci_mcasp_pdata *pdata)
 	return offset;
 }
 
+#ifdef CONFIG_GPIOLIB
+static int davinci_mcasp_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+
+	if (mcasp->num_serializer && offset < mcasp->num_serializer &&
+	    mcasp->serial_dir[offset] != INACTIVE_MODE) {
+		dev_err(mcasp->dev, "AXR%u pin is  used for audio\n", offset);
+		return -EBUSY;
+	}
+
+	/* Do not change the PIN yet */
+
+	return pm_runtime_get_sync(mcasp->dev);
+}
+
+static void davinci_mcasp_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+
+	/* Set the direction to input */
+	mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(offset));
+
+	/* Set the pin as McASP pin */
+	mcasp_clr_bits(mcasp, DAVINCI_MCASP_PFUNC_REG, BIT(offset));
+
+	pm_runtime_put_sync(mcasp->dev);
+}
+
+static int davinci_mcasp_gpio_direction_out(struct gpio_chip *chip,
+					    unsigned offset, int value)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+	u32 val;
+
+	if (value)
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDOUT_REG, BIT(offset));
+	else
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDOUT_REG, BIT(offset));
+
+	val = mcasp_get_reg(mcasp, DAVINCI_MCASP_PFUNC_REG);
+	if (!(val & BIT(offset))) {
+		/* Set the pin as GPIO pin */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PFUNC_REG, BIT(offset));
+
+		/* Set the direction to output */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(offset));
+	}
+
+	return 0;
+}
+
+static void davinci_mcasp_gpio_set(struct gpio_chip *chip, unsigned offset,
+				  int value)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+
+	if (value)
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDOUT_REG, BIT(offset));
+	else
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDOUT_REG, BIT(offset));
+}
+
+static int davinci_mcasp_gpio_direction_in(struct gpio_chip *chip,
+					   unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+	u32 val;
+
+	val = mcasp_get_reg(mcasp, DAVINCI_MCASP_PFUNC_REG);
+	if (!(val & BIT(offset))) {
+		/* Set the direction to input */
+		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(offset));
+
+		/* Set the pin as GPIO pin */
+		mcasp_set_bits(mcasp, DAVINCI_MCASP_PFUNC_REG, BIT(offset));
+	}
+
+	return 0;
+}
+
+static int davinci_mcasp_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+	u32 val;
+
+	val = mcasp_get_reg(mcasp, DAVINCI_MCASP_PDSET_REG);
+	if (val & BIT(offset))
+		return 1;
+
+	return 0;
+}
+
+static int davinci_mcasp_gpio_get_direction(struct gpio_chip *chip,
+					    unsigned offset)
+{
+	struct davinci_mcasp *mcasp = gpiochip_get_data(chip);
+	u32 val;
+
+	val = mcasp_get_reg(mcasp, DAVINCI_MCASP_PDIR_REG);
+	if (val & BIT(offset))
+		return 0;
+
+	return 1;
+}
+
+static const struct gpio_chip davinci_mcasp_template_chip = {
+	.owner			= THIS_MODULE,
+	.request		= davinci_mcasp_gpio_request,
+	.free			= davinci_mcasp_gpio_free,
+	.direction_output	= davinci_mcasp_gpio_direction_out,
+	.set			= davinci_mcasp_gpio_set,
+	.direction_input	= davinci_mcasp_gpio_direction_in,
+	.get			= davinci_mcasp_gpio_get,
+	.get_direction		= davinci_mcasp_gpio_get_direction,
+	.base			= -1,
+	.ngpio			= 32,
+};
+
+static int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
+{
+	if (!of_property_read_bool(mcasp->dev->of_node, "gpio-controller"))
+		return 0;
+
+	mcasp->gpio_chip = davinci_mcasp_template_chip;
+	mcasp->gpio_chip.label = dev_name(mcasp->dev);
+	mcasp->gpio_chip.parent = mcasp->dev;
+#ifdef CONFIG_OF_GPIO
+	mcasp->gpio_chip.of_node = mcasp->dev->of_node;
+#endif
+
+	return devm_gpiochip_add_data(mcasp->dev, &mcasp->gpio_chip, mcasp);
+}
+
+#else /* CONFIG_GPIOLIB */
+static inline int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
+{
+	return 0;
+}
+#endif /* CONFIG_GPIOLIB */
+
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
@@ -2069,6 +2213,15 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	mcasp_reparent_fck(pdev);
 
+	/* All PINS as McASP */
+	pm_runtime_get_sync(mcasp->dev);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_PFUNC_REG, 0x00000000);
+	pm_runtime_put(mcasp->dev);
+
+	ret = davinci_mcasp_init_gpiochip(mcasp);
+	if (ret)
+		goto err;
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					&davinci_mcasp_component,
 					&davinci_mcasp_dai[pdata->op_mode], 1);
-- 
2.20.1

