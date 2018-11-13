Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EE7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30622216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="IGpEP7FE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30622216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbeKNFpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:45:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51256 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbeKNFpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=klF9s93jeBC9bL/1A7ssdNAq22QYUQB6gs9ab7PCJvo=; b=IGpEP7FEQPFh
        XVJAIQNJNfU0N/YkB/LTO2Piyh4zupGt+MPX+47N0SC1JSb+FshL1qzhjL9XDkrPhrXeWaJRyQy3Q
        x9CCuUyY9FiEW0yZXbRWC1OeiQq38Z7kRcw8OUXA9ooNZ1E53fdYFiANhPEkqMkp3NsZ80BwMluvh
        pMb00=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMedM-0002Vl-5H; Tue, 13 Nov 2018 19:46:00 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2C3AB440078; Tue, 13 Nov 2018 19:45:54 +0000 (GMT)
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
Subject: Applied "ASoC: amd: add acp3x i2s ops" to the asoc tree
In-Reply-To:  <1542000903-19020-8-git-send-email-Vijendar.Mukunda@amd.com>
Message-Id: <20181113194554.2C3AB440078@finisterre.ee.mobilebroadband>
Date:   Tue, 13 Nov 2018 19:45:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: amd: add acp3x i2s ops

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

From 2b5f290e10266037338631c03ab6bea51f0a7ebf Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Mon, 12 Nov 2018 11:04:58 +0530
Subject: [PATCH] ASoC: amd: add acp3x i2s ops

ACP3x has a i2s controller block for playback and capture.
This patch adds ACP3x i2s DAI operations.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 89 ++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 06c1985c4d56..ed2c16379d2c 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -423,10 +423,93 @@ static struct snd_pcm_ops acp3x_dma_ops = {
 	.mmap = acp3x_dma_mmap,
 };
 
+static int acp3x_dai_i2s_hwparams(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	u32 val = 0;
+	struct i2s_stream_instance *rtd = substream->runtime->private_data;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_U8:
+	case SNDRV_PCM_FORMAT_S8:
+		rtd->xfer_resolution = 0x0;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		rtd->xfer_resolution = 0x02;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		rtd->xfer_resolution = 0x04;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		rtd->xfer_resolution = 0x05;
+		break;
+	default:
+		return -EINVAL;
+	}
+	val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
+	val = val | (rtd->xfer_resolution  << 3);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
+	else
+		rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_IRER);
+
+	return 0;
+}
+
+static int acp3x_dai_i2s_trigger(struct snd_pcm_substream *substream,
+				 int cmd, struct snd_soc_dai *dai)
+{
+	int ret = 0;
+	struct i2s_stream_instance *rtd = substream->runtime->private_data;
+	u32 val, period_bytes;
+
+	period_bytes = frames_to_bytes(substream->runtime,
+				       substream->runtime->period_size);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			rv_writel(period_bytes, rtd->acp3x_base +
+				  mmACP_BT_TX_INTR_WATERMARK_SIZE);
+			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
+			val = val | BIT(0);
+			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
+		} else {
+			rv_writel(period_bytes, rtd->acp3x_base +
+				  mmACP_BT_RX_INTR_WATERMARK_SIZE);
+			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_IRER);
+			val = val | BIT(0);
+			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_IRER);
+		}
+		rv_writel(1, rtd->acp3x_base + mmACP_BTTDM_IER);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
+			val = val & ~BIT(0);
+			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
+		} else {
+			val = rv_readl(rtd->acp3x_base + mmACP_BTTDM_IRER);
+			val = val & ~BIT(0);
+			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_IRER);
+		}
+		rv_writel(0, rtd->acp3x_base + mmACP_BTTDM_IER);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 struct snd_soc_dai_ops acp3x_dai_i2s_ops = {
-	.hw_params = NULL,
-	.trigger   = NULL,
-	.set_fmt = NULL,
+	.hw_params = acp3x_dai_i2s_hwparams,
+	.trigger   = acp3x_dai_i2s_trigger,
 };
 
 static struct snd_soc_dai_driver acp3x_i2s_dai_driver = {
-- 
2.19.1

