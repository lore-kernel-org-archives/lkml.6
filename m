Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238CFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3AB224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="agGYFybV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3AB224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbeKNFpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:45:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51614 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeKNFpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=trMIJ1FMsjfBcJvXYYdYD+dH5THaajvdGfBlqDNUXPk=; b=agGYFybVKOx3
        Oejqzj+gCpCGWVAM5A7laQ+1QxZrdbWPEp23YhS29VKxfkp0I3H4YQDmLqenzqYMYN8s9QGRV6c4e
        hoMRwHKZa8MglANV6iVzUnxAriAFaEpAChVCKqPVWE7rjK0l8ThtjWRsBBspLIUx2hAVKgqQKpj7H
        xbjV4=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMedY-0002W5-8l; Tue, 13 Nov 2018 19:46:12 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AC5F4440078; Tue, 13 Nov 2018 19:46:06 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Ravulapati Vishnu vardhan Rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER, MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vishnuvardhanrao.Ravulapati@amd.com,
        Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: amd: Interrupt handler changes for ACP3x DMA driver" to the asoc tree
In-Reply-To:  <1542000903-19020-6-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <20181113194606.AC5F4440078@finisterre.ee.mobilebroadband>
Date:   Tue, 13 Nov 2018 19:46:06 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: Interrupt handler changes for ACP3x DMA driver

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

From 32feac95f646aebaafdaf12a610898b6e5db54ae Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Mon, 12 Nov 2018 11:04:56 +0530
Subject: [PATCH] ASoC: amd: Interrupt handler changes for ACP3x DMA driver

Whenever audio data equal to the I2S FIFO watermark level are
produced/consumed, interrupt is generated.
Acknowledge the interrupt.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 3e806f74c6f7..94f915afd1b3 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -27,6 +27,7 @@
 #define DRV_NAME "acp3x-i2s-audio"
 
 struct i2s_dev_data {
+	unsigned int i2s_irq;
 	void __iomem *acp3x_base;
 	struct snd_pcm_substream *play_stream;
 	struct snd_pcm_substream *capture_stream;
@@ -132,6 +133,38 @@ static int acp3x_deinit(void __iomem *acp3x_base)
 	return 0;
 }
 
+static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
+{
+	u16 play_flag, cap_flag;
+	u32 val;
+	struct i2s_dev_data *rv_i2s_data = dev_id;
+
+	if (!rv_i2s_data)
+		return IRQ_NONE;
+
+	play_flag = 0;
+	cap_flag = 0;
+	val = rv_readl(rv_i2s_data->acp3x_base + mmACP_EXTERNAL_INTR_STAT);
+	if ((val & BIT(BT_TX_THRESHOLD)) && rv_i2s_data->play_stream) {
+		rv_writel(BIT(BT_TX_THRESHOLD), rv_i2s_data->acp3x_base +
+			  mmACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(rv_i2s_data->play_stream);
+		play_flag = 1;
+	}
+
+	if ((val & BIT(BT_RX_THRESHOLD)) && rv_i2s_data->capture_stream) {
+		rv_writel(BIT(BT_RX_THRESHOLD), rv_i2s_data->acp3x_base +
+			  mmACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(rv_i2s_data->capture_stream);
+		cap_flag = 1;
+	}
+
+	if (play_flag | cap_flag)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
+}
+
 static struct snd_pcm_ops acp3x_dma_ops = {
 	.open = NULL,
 	.close = NULL,
@@ -205,6 +238,13 @@ static int acp3x_audio_probe(struct platform_device *pdev)
 	adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,
 					 resource_size(res));
 
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
+		return -ENODEV;
+	}
+
+	adata->i2s_irq = res->start;
 	adata->play_stream = NULL;
 	adata->capture_stream = NULL;
 
@@ -220,6 +260,12 @@ static int acp3x_audio_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Fail to register acp i2s dai\n");
 		goto dev_err;
 	}
+	status = devm_request_irq(&pdev->dev, adata->i2s_irq, i2s_irq_handler,
+				  irqflags, "ACP3x_I2S_IRQ", adata);
+	if (status) {
+		dev_err(&pdev->dev, "ACP3x I2S IRQ request failed\n");
+		goto dev_err;
+	}
 
 	return 0;
 dev_err:
-- 
2.19.1

