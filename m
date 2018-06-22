Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84FBC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848B3243FF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="fWJfBBLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848B3243FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeFVOuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:50:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32852 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbeFVOue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SJYqqvvE+YugFkDPYa8JA8+unWsDuRVwL9fW3XMZdsE=; b=fWJfBBLyFL1R
        LylUjltN2305rMmhrq22oo8QLPYBSpaQINOTr2KDGxotnizVXNH6+wNmnR6Y6kesWBUnKf20VC4D8
        vRL6b4cxaxjroTDQlJEh4WMKVK3pVpvPHZYS+sWiN7+RNwwv17qLyTb06c7DhblYoCtgq5A4VWkUc
        +r1k0=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fWNOQ-0003ue-GR; Fri, 22 Jun 2018 14:50:30 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fWNOQ-0002et-2X; Fri, 22 Jun 2018 15:50:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Agrawal@sirena.org.uk, Akshu <Akshu.Agrawal@amd.com>
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org,
        Mark Brown <broonie@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alexander.Deucher@amd.com, akshu.agrawal@amd.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: AMD: Change codec to channel link as per hardware redesign" to the asoc tree
In-Reply-To:  <1525840011-14077-1-git-send-email-akshu.agrawal@amd.com>
Message-Id: <E1fWNOQ-0002et-2X@debutante>
Date:   Fri, 22 Jun 2018 15:50:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Change codec to channel link as per hardware redesign

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

From 3bec6fa3cdd338860d4b7d4110a49292646d801e Mon Sep 17 00:00:00 2001
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Date: Thu, 21 Jun 2018 12:58:16 +0800
Subject: [PATCH] ASoC: AMD: Change codec to channel link as per hardware
 redesign

This is a correction to match acutal hardware configuration.
The hardware configuration looks like:
I2S_BT -> SPK(Max) + DMIC(Adau)
I2S_SP -> DA7219 Headset

No actual products have been shipped with previous configuration.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index ccddc6650b9c..566bd268be3a 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -148,7 +148,7 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	machine->i2s_instance = I2S_BT_INSTANCE;
+	machine->i2s_instance = I2S_SP_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -163,7 +163,7 @@ static int cz_max_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
-	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -178,7 +178,7 @@ static int cz_dmic_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
-	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -204,16 +204,27 @@ static const struct snd_soc_ops cz_dmic_cap_ops = {
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 	{
-		.name = "amd-da7219-play-cap",
-		.stream_name = "Playback and Capture",
+		.name = "amd-da7219-play",
+		.stream_name = "Playback",
 		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.3.auto",
+		.cpu_dai_name = "designware-i2s.1.auto",
 		.codec_dai_name = "da7219-hifi",
 		.codec_name = "i2c-DLGS7219:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.init = cz_da7219_init,
 		.dpcm_playback = 1,
+		.ops = &cz_da7219_cap_ops,
+	},
+	{
+		.name = "amd-da7219-cap",
+		.stream_name = "Capture",
+		.platform_name = "acp_audio_dma.0.auto",
+		.cpu_dai_name = "designware-i2s.2.auto",
+		.codec_dai_name = "da7219-hifi",
+		.codec_name = "i2c-DLGS7219:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
 		.ops = &cz_da7219_cap_ops,
 	},
@@ -221,7 +232,7 @@ static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 		.name = "amd-max98357-play",
 		.stream_name = "HiFi Playback",
 		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.1.auto",
+		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "HiFi",
 		.codec_name = "MX98357A:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
@@ -233,7 +244,7 @@ static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 		.name = "dmic",
 		.stream_name = "DMIC Capture",
 		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.2.auto",
+		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "adau7002-hifi",
 		.codec_name = "ADAU7002:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-- 
2.18.0.rc2

