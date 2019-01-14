Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C392C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40D420657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547507062;
	bh=q/uZTnvK1XcGpCpLn0LFSW/JefttaNOmCp8n0mFhf9s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Smzlllpa9s45Ulv67GccbL0UK96hh5xyQrtNGBX/SQ0y1l6Z7WaAD6AxrkdDdrjKZ
	 zGCjfok0h4cjG4D7JAEEJDbNTDoQUHj+0qPsXFp/bTL35yab/jVudaq5NDg4Dud0Gs
	 6w12eb1VIzv7cUS8AXeBss8GMQpLleGUPeykA5e4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfANXEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:04:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40136 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfANXEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3DVs2c49389/wtLag423gUNgCd2dQSyEhrJdyzBJn+Y=; b=M+A7G2+Vx5JY
        qCxCJJF5etNna9cmabdYeucpVsNTmD3zXJC9fUwtsbdY+ksuzrdB4U99Y+JY/Mrbjwv8HCkpEz7T0
        wopTI+rlkG+15Uw8HCzNLcv+VU/DokNeWug5b7/iUfPpa47DfBaBy/ox18eZaMUTxdDVHo/BAVOMR
        wSxYo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjBGt-0000Sa-4q; Mon, 14 Jan 2019 23:03:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C91F61127AD2; Mon, 14 Jan 2019 23:03:54 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: xlnx: parse AES audio parameters" to the asoc tree
In-Reply-To:  <1547126083-44466-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Patchwork-Hint: ignore
Message-Id: <20190114230354.C91F61127AD2@debutante.sirena.org.uk>
Date:   Mon, 14 Jan 2019 23:03:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: xlnx: parse AES audio parameters

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

From c284d4e31a0b66e6fe3734b36080afd237ff9fb0 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Thu, 10 Jan 2019 18:44:43 +0530
Subject: [PATCH] ASoC: xlnx: parse AES audio parameters

AES channel status carries various audio parameters. If channel status is
detected, current patch extracts sample rate and bit depth parameters of
the incoming stream during capture.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/xilinx/xlnx_formatter_pcm.c | 143 ++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index d2194da928e7..97177d35652e 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -13,6 +13,7 @@
 #include <linux/of_irq.h>
 #include <linux/sizes.h>
 
+#include <sound/asoundef.h>
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
@@ -63,6 +64,7 @@
 #define PERIODS_MAX		6
 #define PERIOD_BYTES_MIN	192
 #define PERIOD_BYTES_MAX	(50 * 1024)
+#define XLNX_PARAM_UNKNOWN	0
 
 enum bit_depth {
 	BIT_DEPTH_8,
@@ -117,6 +119,129 @@ static const struct snd_pcm_hardware xlnx_pcm_hardware = {
 	.periods_max = PERIODS_MAX,
 };
 
+enum {
+	AES_TO_AES,
+	AES_TO_PCM,
+	PCM_TO_PCM,
+	PCM_TO_AES
+};
+
+static void xlnx_parse_aes_params(u32 chsts_reg1_val, u32 chsts_reg2_val,
+				  struct device *dev)
+{
+	u32 padded, srate, bit_depth, status[2];
+
+	if (chsts_reg1_val & IEC958_AES0_PROFESSIONAL) {
+		status[0] = chsts_reg1_val & 0xff;
+		status[1] = (chsts_reg1_val >> 16) & 0xff;
+
+		switch (status[0] & IEC958_AES0_PRO_FS) {
+		case IEC958_AES0_PRO_FS_44100:
+			srate = 44100;
+			break;
+		case IEC958_AES0_PRO_FS_48000:
+			srate = 48000;
+			break;
+		case IEC958_AES0_PRO_FS_32000:
+			srate = 32000;
+			break;
+		case IEC958_AES0_PRO_FS_NOTID:
+		default:
+			srate = XLNX_PARAM_UNKNOWN;
+			break;
+		}
+
+		switch (status[1] & IEC958_AES2_PRO_SBITS) {
+		case IEC958_AES2_PRO_WORDLEN_NOTID:
+		case IEC958_AES2_PRO_SBITS_20:
+			padded = 0;
+			break;
+		case IEC958_AES2_PRO_SBITS_24:
+			padded = 4;
+			break;
+		default:
+			bit_depth = XLNX_PARAM_UNKNOWN;
+			goto log_params;
+		}
+
+		switch (status[1] & IEC958_AES2_PRO_WORDLEN) {
+		case IEC958_AES2_PRO_WORDLEN_20_16:
+			bit_depth = 16 + padded;
+			break;
+		case IEC958_AES2_PRO_WORDLEN_22_18:
+			bit_depth = 18 + padded;
+			break;
+		case IEC958_AES2_PRO_WORDLEN_23_19:
+			bit_depth = 19 + padded;
+			break;
+		case IEC958_AES2_PRO_WORDLEN_24_20:
+			bit_depth = 20 + padded;
+			break;
+		case IEC958_AES2_PRO_WORDLEN_NOTID:
+		default:
+			bit_depth = XLNX_PARAM_UNKNOWN;
+			break;
+		}
+
+	} else {
+		status[0] = (chsts_reg1_val >> 24) & 0xff;
+		status[1] = chsts_reg2_val & 0xff;
+
+		switch (status[0] & IEC958_AES3_CON_FS) {
+		case IEC958_AES3_CON_FS_44100:
+			srate = 44100;
+			break;
+		case IEC958_AES3_CON_FS_48000:
+			srate = 48000;
+			break;
+		case IEC958_AES3_CON_FS_32000:
+			srate = 32000;
+			break;
+		default:
+			srate = XLNX_PARAM_UNKNOWN;
+			break;
+		}
+
+		if (status[1] & IEC958_AES4_CON_MAX_WORDLEN_24)
+			padded = 4;
+		else
+			padded = 0;
+
+		switch (status[1] & IEC958_AES4_CON_WORDLEN) {
+		case IEC958_AES4_CON_WORDLEN_20_16:
+			bit_depth = 16 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_22_18:
+			bit_depth = 18 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_23_19:
+			bit_depth = 19 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_24_20:
+			bit_depth = 20 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_21_17:
+			bit_depth = 17 + padded;
+			break;
+		case IEC958_AES4_CON_WORDLEN_NOTID:
+		default:
+			bit_depth = XLNX_PARAM_UNKNOWN;
+			break;
+		}
+	}
+
+log_params:
+	if (srate != XLNX_PARAM_UNKNOWN)
+		dev_info(dev, "sample rate = %d\n", srate);
+	else
+		dev_info(dev, "sample rate = unknown\n");
+
+	if (bit_depth != XLNX_PARAM_UNKNOWN)
+		dev_info(dev, "bit_depth = %d\n", bit_depth);
+	else
+		dev_info(dev, "bit_depth = unknown\n");
+}
+
 static int xlnx_formatter_pcm_reset(void __iomem *mmio_base)
 {
 	u32 val, retries = 0;
@@ -302,8 +427,12 @@ static int xlnx_formatter_pcm_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
 	u32 low, high, active_ch, val, bytes_per_ch, bits_per_sample;
+	u32 aes_reg1_val, aes_reg2_val;
 	int status;
 	u64 size;
+	struct snd_soc_pcm_runtime *prtd = substream->private_data;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
+								    DRV_NAME);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct xlnx_pcm_stream_param *stream_data = runtime->private_data;
 
@@ -311,6 +440,20 @@ static int xlnx_formatter_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (active_ch > stream_data->ch_limit)
 		return -EINVAL;
 
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
+	    stream_data->xfer_mode == AES_TO_PCM) {
+		val = readl(stream_data->mmio + XLNX_AUD_STS);
+		if (val & AUD_STS_CH_STS_MASK) {
+			aes_reg1_val = readl(stream_data->mmio +
+					     XLNX_AUD_CH_STS_START);
+			aes_reg2_val = readl(stream_data->mmio +
+					     XLNX_AUD_CH_STS_START + 0x4);
+
+			xlnx_parse_aes_params(aes_reg1_val, aes_reg2_val,
+					      component->dev);
+		}
+	}
+
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
 	if (status < 0)
-- 
2.20.1

