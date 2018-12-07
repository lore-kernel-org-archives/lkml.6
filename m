Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CF9C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A5C20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544185405;
	bh=Yj2PwiZMIK3qxzPRdIdYrsUK9o0xrN8nYE8jXddT+4U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=LvdYmSqyf58AJMaCg01Q7dYmE0KihZulO0C/ma4YG/eZ8cgI0RImzBZEhawsZkVmU
	 2ip1ubDuhMIZvx2QYWhnXNrnk5UShGXge9RDrHzH/5i2N3Z1urtNEp7EgtxXyn7Loj
	 zD2e00ar6wW9OqmnRImDn6021hntbScTdE4jg+yY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A5C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbeLGMXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:23:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33252 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeLGMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=f7d5HdNpj+zhLYgq6cTrQvOtXR/IkWHrW8LsVTTFNgY=; b=Ogr/SRvKtZJ0
        5FSk9N/QLjsiDMUZ5OF+bCdc7GMWk5ZTXS3OVoYcmzJDepGsKMmUwcritkeAcV3YfFavP2XAV4Rzu
        HCZVxbKFgF1cxEbJm8OnqNTeLgu/ooCfwGyP2nX1atj5HaVHKiU5DlRqw0B7na+CCda+NQW5dLIoC
        xj/NY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gVFA6-0003YG-LQ; Fri, 07 Dec 2018 12:23:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5788111253E4; Fri,  7 Dec 2018 12:23:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, tzungbi@chromium.org,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: sdm845: Add TDM configuration for speaker" to the asoc tree
In-Reply-To:  <20181128090037.257359-3-cychiang@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20181207122318.5788111253E4@debutante.sirena.org.uk>
Date:   Fri,  7 Dec 2018 12:23:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sdm845: Add TDM configuration for speaker

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

From 09b382007aa54dbe2cc142ef78d69b9a7645fcd6 Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Wed, 28 Nov 2018 17:00:35 +0800
Subject: [PATCH] ASoC: sdm845: Add TDM configuration for speaker

Set TDM time slots and DAI format for speaker codec.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 69 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 43c03f8e8cdc..d0df7ec6042e 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -6,9 +6,11 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
+#include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/jack.h>
+#include <sound/soc.h>
 #include <uapi/linux/input-event-codes.h>
 #include "common.h"
 #include "qdsp6/q6afe.h"
@@ -17,6 +19,10 @@
 #define DEFAULT_MCLK_RATE		24576000
 #define TDM_BCLK_RATE		6144000
 #define MI2S_BCLK_RATE		1536000
+#define LEFT_SPK_TDM_TX_MASK    0x30
+#define RIGHT_SPK_TDM_TX_MASK   0xC0
+#define SPK_TDM_RX_MASK         0x03
+#define NUM_TDM_SLOTS           8
 
 struct sdm845_snd_data {
 	struct snd_soc_jack jack;
@@ -34,7 +40,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0;
+	int ret = 0, j;
 	int channels, slot_width;
 
 	switch (params_format(params)) {
@@ -81,6 +87,35 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 			goto end;
 		}
 	}
+
+	for (j = 0; j < rtd->num_codecs; j++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
+
+		if (!strcmp(codec_dai->component->name_prefix, "Left")) {
+			ret = snd_soc_dai_set_tdm_slot(
+					codec_dai, LEFT_SPK_TDM_TX_MASK,
+					SPK_TDM_RX_MASK, NUM_TDM_SLOTS,
+					slot_width);
+			if (ret < 0) {
+				dev_err(rtd->dev,
+					"DEV0 TDM slot err:%d\n", ret);
+				return ret;
+			}
+		}
+
+		if (!strcmp(codec_dai->component->name_prefix, "Right")) {
+			ret = snd_soc_dai_set_tdm_slot(
+					codec_dai, RIGHT_SPK_TDM_TX_MASK,
+					SPK_TDM_RX_MASK, NUM_TDM_SLOTS,
+					slot_width);
+			if (ret < 0) {
+				dev_err(rtd->dev,
+					"DEV1 TDM slot err:%d\n", ret);
+				return ret;
+			}
+		}
+	}
+
 end:
 	return ret;
 }
@@ -155,10 +190,14 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 {
 	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
+	unsigned int codec_dai_fmt = SND_SOC_DAIFMT_CBS_CFS;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_card *card = rtd->card;
 	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int j;
+	int ret;
 
 	switch (cpu_dai->id) {
 	case PRIMARY_MI2S_RX:
@@ -190,6 +229,34 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
 				TDM_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
+
+		codec_dai_fmt |= SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_DSP_B;
+
+		for (j = 0; j < rtd->num_codecs; j++) {
+			codec_dai = rtd->codec_dais[j];
+
+			if (!strcmp(codec_dai->component->name_prefix,
+				    "Left")) {
+				ret = snd_soc_dai_set_fmt(
+						codec_dai, codec_dai_fmt);
+				if (ret < 0) {
+					dev_err(rtd->dev,
+						"Left TDM fmt err:%d\n", ret);
+					return ret;
+				}
+			}
+
+			if (!strcmp(codec_dai->component->name_prefix,
+				    "Right")) {
+				ret = snd_soc_dai_set_fmt(
+						codec_dai, codec_dai_fmt);
+				if (ret < 0) {
+					dev_err(rtd->dev,
+						"Right TDM slot err:%d\n", ret);
+					return ret;
+				}
+			}
+		}
 		break;
 
 	default:
-- 
2.19.0.rc2

