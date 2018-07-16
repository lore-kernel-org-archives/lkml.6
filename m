Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4E5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2A620877
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="kyJJ0WVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2A620877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeGPO6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:58:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51884 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeGPO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Yv1bOCT4MFrMSLHXenDquwaFUIk8LW8vvogZIDr+7po=; b=kyJJ0WVavzEO
        iqxIA4RdLYlldMly1d1wdfvvC0TK50ccejCS4q2WSPvK77l0ZgY3m72uGroIX44C952S0fJxW6FZS
        WluRvFRUYmjhhV03ve9XJgbqiQdNq0dcMq4v2uTYsXCmxZNZV7cWFNoGMnaWu9pePwx6N1KVUBVyT
        qspos=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ff4WE-0000O2-MT; Mon, 16 Jul 2018 14:30:30 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ff4WE-0005U2-7q; Mon, 16 Jul 2018 15:30:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Agrawal@sirena.org.uk, Akshu <Akshu.Agrawal@amd.com>
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org,
        Mark Brown <broonie@kernel.org>,
        "Mukunda,, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        akshu.agrawal@amd.com, Guenter Roeck <linux@roeck-us.net>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: AMD: Send correct channel for configuring DMA descriptors" to the asoc tree
In-Reply-To:  <1531724566-4019-1-git-send-email-akshu.agrawal@amd.com>
Message-Id: <E1ff4WE-0005U2-7q@debutante>
Date:   Mon, 16 Jul 2018 15:30:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Send correct channel for configuring DMA descriptors

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

From fa9d2f17c23fb3ea6b659b1bfe4ca10551a19e56 Mon Sep 17 00:00:00 2001
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Date: Mon, 16 Jul 2018 15:02:40 +0800
Subject: [PATCH] ASoC: AMD: Send correct channel for configuring DMA
 descriptors

Earlier, ch1 was used to define ACP-SYSMEM transfer and ch2 for
ACP-I2S transfer. With recent patches ch1 is used to define channel
order number 1 and ch2 as channel order number 2. Thus,
Playback:
ch1:SYSMEM->ACP
ch2:ACP->I2S
Capture:
ch1:I2S->ACP
ch1:ACP->SYSMEM

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 65c1033bd51c..eeb867767252 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -322,17 +322,27 @@ static void config_acp_dma(void __iomem *acp_mmio,
 			   struct audio_substream_data *rtd,
 			   u32 asic_type)
 {
+	u16 ch_acp_sysmem, ch_acp_i2s;
+
 	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
 		       rtd->pte_offset);
+
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		ch_acp_sysmem = rtd->ch1;
+		ch_acp_i2s = rtd->ch2;
+	} else {
+		ch_acp_i2s = rtd->ch1;
+		ch_acp_sysmem = rtd->ch2;
+	}
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
 				       rtd->direction, rtd->pte_offset,
-				       rtd->ch1, rtd->sram_bank,
+				       ch_acp_sysmem, rtd->sram_bank,
 				       rtd->dma_dscr_idx_1, asic_type);
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
 	set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
 				       rtd->direction, rtd->sram_bank,
-				       rtd->destination, rtd->ch2,
+				       rtd->destination, ch_acp_i2s,
 				       rtd->dma_dscr_idx_2, asic_type);
 }
 
@@ -995,16 +1005,24 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
+	u16 ch_acp_sysmem, ch_acp_i2s;
 
 	if (!rtd)
 		return -EINVAL;
 
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		ch_acp_sysmem = rtd->ch1;
+		ch_acp_i2s = rtd->ch2;
+	} else {
+		ch_acp_i2s = rtd->ch1;
+		ch_acp_sysmem = rtd->ch2;
+	}
 	config_acp_dma_channel(rtd->acp_mmio,
-			       rtd->ch1,
+			       ch_acp_sysmem,
 			       rtd->dma_dscr_idx_1,
 			       NUM_DSCRS_PER_CHANNEL, 0);
 	config_acp_dma_channel(rtd->acp_mmio,
-			       rtd->ch2,
+			       ch_acp_i2s,
 			       rtd->dma_dscr_idx_2,
 			       NUM_DSCRS_PER_CHANNEL, 0);
 	return 0;
-- 
2.18.0.rc2

