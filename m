Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C1AECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E96208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BrC3c4wu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E96208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeGPO6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:58:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51820 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeGPO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=I0kO0dD9uD56KBhRjHtckzQLvnIZy+kruZTEeMxYRcM=; b=BrC3c4wuF8OP
        WxUCKLjZ/iJyqF8ydVtKl+0K/radimxKZkOFWJwuzHtMDls6498QMvYexXjtyPtyPeqJjK7BnCJqe
        xLc7xhx2McvaI5qVWXAiEmkXDO7yTr8M2643MdzfQslYKw2ELWUnqPuQSFmu8DN6zPb6HdwTGqBn0
        CLem4=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ff4WD-0000Nz-87; Mon, 16 Jul 2018 14:30:29 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ff4WC-0005St-2u; Mon, 16 Jul 2018 15:30:28 +0100
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
Subject: Applied "ASoC: AMD: For capture have interrupts on I2S->ACP channel" to the asoc tree
In-Reply-To:  <1531724566-4019-2-git-send-email-akshu.agrawal@amd.com>
Message-Id: <E1ff4WC-0005St-2u@debutante>
Date:   Mon, 16 Jul 2018 15:30:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: For capture have interrupts on I2S->ACP channel

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

From 19e023e3befb4cb64b4a81b47a92a0c687672661 Mon Sep 17 00:00:00 2001
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Date: Mon, 16 Jul 2018 15:02:41 +0800
Subject: [PATCH] ASoC: AMD: For capture have interrupts on I2S->ACP channel

Having interrupts enabled for ACP<->SYSMEM DMA transfer, we are in
for an interrupt storm.
For both playback and capture interrupts should be enabled for
I2S<->ACP DMA.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index eeb867767252..94bcf69008df 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -224,13 +224,11 @@ static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
 			switch (asic_type) {
 			case CHIP_STONEY:
 				dmadscr[i].xfer_val |=
-				BIT(22) |
 				(ACP_DMA_ATTR_SHARED_MEM_TO_DAGB_GARLIC << 16) |
 				(size / 2);
 				break;
 			default:
 				dmadscr[i].xfer_val |=
-				BIT(22) |
 				(ACP_DMA_ATTR_SHAREDMEM_TO_DAGB_ONION << 16) |
 				(size / 2);
 			}
@@ -421,9 +419,9 @@ static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
 
 	switch (ch_num) {
 	case ACP_TO_I2S_DMA_CH_NUM:
-	case ACP_TO_SYSRAM_CH_NUM:
+	case I2S_TO_ACP_DMA_CH_NUM:
 	case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
-	case ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM:
+	case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
 		dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
 		break;
 	default:
@@ -705,18 +703,18 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
-		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) << 16,
+		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-	if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
+	if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
 		acp_reg_write((intr_flag &
-			      BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) << 16,
+			      BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) << 16,
 			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
-- 
2.18.0.rc2

