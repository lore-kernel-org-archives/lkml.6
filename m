Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB070C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A80320850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544127949;
	bh=UV+OSeUtLVj5LI7EeCUnhf5KksmaUJNXBomV1/9nt3Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=K2iN018qw6sfebtgDLEU1J9DgHOFt/bvLDR2k5F5I6omxdLAcDEAOekikzvjj1n3k
	 pKaGmJhV3bXenPL4tW+1Bq/KfE2b/KU51/vYcmCKTvUe7o4wAtHWNvjbZMMyhSqQIR
	 QbqLGkLyrDV1dEe7EbiVPzFNm1OR6FGjSfKn7v5U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A80320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLFUZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:25:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36188 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLFUZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NxR6Sngaos64k0bU68KuHOWuEV7L5qj+QzolACtoLr8=; b=NDjpk1knTNR/
        X76Qoj3XfTDA/5FLqCdrpYS7Pp6rMRfRLwQXAulJANOnphePhksYRUyQZlb3XbcIpxC+CaVLfAhqZ
        SAPrwn/YbQGPazV7wFhiBFqb5oLBHzONwq/3VGD78R6aDSMXTeVVwYKBRcAxyn6iqkPo5jXceGw/3
        AUuGw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gV0DO-0001g2-Lk; Thu, 06 Dec 2018 20:25:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5151311252F7; Thu,  6 Dec 2018 20:25:42 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, tzungbi@chromium.org,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: sdm845: Add configuration for headset codec" to the asoc tree
In-Reply-To:  <20181128090037.257359-4-cychiang@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20181206202542.5151311252F7@debutante.sirena.org.uk>
Date:   Thu,  6 Dec 2018 20:25:42 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sdm845: Add configuration for headset codec

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

From f7485875a68792d3e5d3984d521f2498ee385fa3 Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Wed, 28 Nov 2018 17:00:36 +0800
Subject: [PATCH] ASoC: sdm845: Add configuration for headset codec

Set DAI format and sysclk for headset codec.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index d0df7ec6042e..1db8ef668223 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -14,6 +14,7 @@
 #include <uapi/linux/input-event-codes.h>
 #include "common.h"
 #include "qdsp6/q6afe.h"
+#include "../codecs/rt5663.h"
 
 #define DEFAULT_SAMPLE_RATE_48K		48000
 #define DEFAULT_MCLK_RATE		24576000
@@ -125,9 +126,27 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret = 0;
 
 	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX:
+	case PRIMARY_MI2S_TX:
+		/*
+		 * Use ASRC for internal clocks, as PLL rate isn't multiple
+		 * of BCLK.
+		 */
+		rt5663_sel_asrc_clk_src(
+			codec_dai->component,
+			RT5663_DA_STEREO_FILTER | RT5663_AD_STEREO_FILTER,
+			RT5663_CLK_SEL_I2S1_ASRC);
+		ret = snd_soc_dai_set_sysclk(
+			codec_dai, RT5663_SCLK_S_MCLK, DEFAULT_MCLK_RATE,
+			SND_SOC_CLOCK_IN);
+		if (ret < 0)
+			dev_err(rtd->dev,
+				"snd_soc_dai_set_sysclk err = %d\n", ret);
+		break;
 	case QUATERNARY_TDM_RX_0:
 	case QUATERNARY_TDM_TX_0:
 		ret = sdm845_tdm_snd_hw_params(substream, params);
@@ -202,6 +221,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 	switch (cpu_dai->id) {
 	case PRIMARY_MI2S_RX:
 	case PRIMARY_MI2S_TX:
+		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF;
 		if (++(data->pri_mi2s_clk_count) == 1) {
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_MCLK_1,
@@ -211,6 +231,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 				MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
 		break;
 
 	case SECONDARY_MI2S_TX:
-- 
2.19.0.rc2

