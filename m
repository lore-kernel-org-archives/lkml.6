Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB45CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788B621884
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="aw1ac3zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788B621884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbeHFSQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:16:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51040 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFSQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Hlp0BRXdu38s8UdeZ/s4cVIN2IbTcfdJfbxhA5COqHI=; b=aw1ac3zyf0Du
        YfFJ3r0dNP/7h0SdG8sLYnpwor9L8KaxqAmAonsbJ48PX+aado0yfDfRw3TaFattZMI/RnjpHCmpP
        lq1eaFnann9qQgm1rPQrtYkqtHtVcJ/6oTYvDCK3gx8NDbqONIG81YoubmUEMvVZv5hpkdkaS0Now
        nKTFQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fmi1H-00085W-39; Mon, 06 Aug 2018 16:06:07 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8E541440078; Mon,  6 Aug 2018 17:06:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Mark Brown <broonie@kernel.org>,
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
Subject: Applied "ASoC: AMD: Set delay value for the capture case" to the asoc tree
In-Reply-To:  <1533540439-18735-3-git-send-email-akshu.agrawal@amd.com>
Message-Id: <20180806160606.8E541440078@finisterre.ee.mobilebroadband>
Date:   Mon,  6 Aug 2018 17:06:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Set delay value for the capture case

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

From c21c834adb5bc81e7081aa93ac50619c6d060506 Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Mon, 6 Aug 2018 12:57:16 +0530
Subject: [PATCH] ASoC: AMD: Set delay value for the capture case

ACP->SYSMEM DMA happens at every I2S->SYSMEM period
completion. Thus, there is delay of x frames till
I2S->SYSMEM reaches a period length. This delay is
communicated to user space.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 32f27c5e4d93..e359938e3d7e 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -922,6 +922,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
 			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_11;
 			adata->capture_i2sbt_stream = substream;
 			break;
@@ -942,6 +946,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
 			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_15;
 			adata->capture_i2ssp_stream = substream;
 		}
@@ -997,7 +1005,7 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	u32 pos = 0;
 	u64 bytescount = 0;
 	u16 dscr;
-	u32 period_bytes;
+	u32 period_bytes, delay;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -1012,6 +1020,11 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 			pos = period_bytes;
 		else
 			pos = 0;
+		bytescount = acp_get_byte_count(rtd);
+		if (bytescount > rtd->bytescount)
+			bytescount -= rtd->bytescount;
+		delay = do_div(bytescount, period_bytes);
+		runtime->delay = bytes_to_frames(runtime, delay);
 	} else {
 		buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 		bytescount = acp_get_byte_count(rtd);
-- 
2.18.0

