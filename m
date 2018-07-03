Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8811DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331C023E80
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="QHURTkoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331C023E80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbeGCPfr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:35:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37848 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933628AbeGCPeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mnTvY/df1XfM7nVKhBrkclLv/tS6+29w6b9z8Z69X7w=; b=QHURTkoPDawF
        s2SIfjdt3Dh2kfsW1i6e9++9msTs1FOI8gle32t+o47hXnO7aIBnhWzWcmIVMGh6I5jH4Moo5j59T
        iSvp9J1/mUnwxkqeI+RLUJvI6fn0ejVhnQ6ZNjZeGJzuJPin/fMQnhU4ohbRfBld5FsDBXWJ+9QWn
        igYyo=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJq-0006An-4H; Tue, 03 Jul 2018 15:34:18 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJp-0003mJ-Mm; Tue, 03 Jul 2018 16:34:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Kurtz <djkurtz@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Mukunda,, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: AMD: Fix Capture DMA channel names" to the asoc tree
In-Reply-To:  <20180702211956.149355-4-djkurtz@chromium.org>
Message-Id: <E1faNJp-0003mJ-Mm@debutante>
Date:   Tue, 03 Jul 2018 16:34:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Fix Capture DMA channel names

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

From 55af49ac1b8627dfbfa2689af118d994d7a0ba1b Mon Sep 17 00:00:00 2001
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Mon, 2 Jul 2018 15:19:53 -0600
Subject: [PATCH] ASoC: AMD: Fix Capture DMA channel names

On capture, audio data is first copied from I2S to ACP memory, and then
to SYSRAM.  For each step the channel number increases, so the names in
the driver were wrong.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 24 ++++++++++++------------
 sound/soc/amd/acp.h         |  8 ++++----
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 034fac3de037..df53412967e1 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -697,31 +697,31 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
-		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
+		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
-		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) << 16,
+		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
 		acp_reg_write((intr_flag &
-			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
+			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
 		acp_reg_write((intr_flag &
-			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
+			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
@@ -899,8 +899,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		switch (rtd->i2s_instance) {
 		case I2S_BT_INSTANCE:
 			rtd->pte_offset = ACP_ST_BT_CAPTURE_PTE_OFFSET;
-			rtd->ch1 = ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM;
-			rtd->ch2 = I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM;
+			rtd->ch1 = I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM;
+			rtd->ch2 = ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM;
 			rtd->sram_bank = ACP_SRAM_BANK_4_ADDRESS;
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
@@ -914,8 +914,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		case I2S_SP_INSTANCE:
 		default:
 			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
-			rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
-			rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
+			rtd->ch1 = I2S_TO_ACP_DMA_CH_NUM;
+			rtd->ch2 = ACP_TO_SYSRAM_CH_NUM;
 			switch (adata->asic_type) {
 			case CHIP_STONEY:
 				rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 3190fdce6307..0a2240bff62e 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -74,16 +74,16 @@
 #define ACP_TO_I2S_DMA_CH_NUM 13
 
 /* Capture DMA channels */
-#define ACP_TO_SYSRAM_CH_NUM 14
-#define I2S_TO_ACP_DMA_CH_NUM 15
+#define I2S_TO_ACP_DMA_CH_NUM 14
+#define ACP_TO_SYSRAM_CH_NUM 15
 
 /* Playback DMA Channels for I2S BT instance */
 #define SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM  8
 #define ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM 9
 
 /* Capture DMA Channels for I2S BT Instance */
-#define ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM 10
-#define I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM 11
+#define I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM 10
+#define ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM 11
 
 #define NUM_DSCRS_PER_CHANNEL 2
 
-- 
2.18.0.rc2

