Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4033C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C256F20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544724684;
	bh=JaKtde/uE9wp5aPoWm87MaAV9UoU5nuCXRDV5RzPu3M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=z5HNh5DGETTph5ZSCv7Mp8C6HKvd39QUBQ3s1XIladUC9BJ2ffxtAE7jdS/yWasG0
	 5cqJ/cgUWfJEEkVGXH80a2eMi0EZ9AxauM/ay3FmN/RkCp/2NwvRU3ZA3Jeu4QKE4H
	 ZUsOkapA/kIgA8wBpGmU4zH1X3PDcl+RDXhhlSfg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C256F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbeLMSLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:11:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36974 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeLMSLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=kQqCsWcCkuBNLrVD5TkOHzLsbOMO0XE5sCMDGIpEz+4=; b=Pjmmt8NpVlBW
        lXdeFvGq7ufyB+o2NRUaOg0eaBr6k+NuWmGxBUdH1NgK45le7shBJ8swfU/ezezMxZugO0H/vgQdk
        1U6POYchJGgQ2O75IbdXJaovMjnkaK0Ervsu098hpbrfymylq0KAaLZdRZ+86mZt91NIm0oT44j82
        Y65ks=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXVS4-0002Pp-Ga; Thu, 13 Dec 2018 18:11:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3561611254D1; Thu, 13 Dec 2018 18:11:12 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: pcm3060: Add powersaving widgets for DAC and ADC" to the asoc tree
In-Reply-To:  <20181207190234.12040-1-kmarinushkin@birdec.tech>
X-Patchwork-Hint: ignore
Message-Id: <20181213181112.3561611254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 18:11:12 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: pcm3060: Add powersaving widgets for DAC and ADC

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

From bb9963b850ea9e1ef39f4368eae83a9462f60166 Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Date: Fri, 7 Dec 2018 20:02:34 +0100
Subject: [PATCH] ASoC: pcm3060: Add powersaving widgets for DAC and ADC

Enable DAC/ADC only when playing/capturing

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3060.c | 14 ++++++++++----
 sound/soc/codecs/pcm3060.h |  2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 1dd851a7b43b..6714aa8d9026 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -198,19 +198,25 @@ static const struct snd_kcontrol_new pcm3060_dapm_controls[] = {
 };
 
 static const struct snd_soc_dapm_widget pcm3060_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", "Playback", PCM3060_REG64,
+			 PCM3060_REG_SHIFT_DAPSV, 1),
+
 	SND_SOC_DAPM_OUTPUT("OUTL"),
 	SND_SOC_DAPM_OUTPUT("OUTR"),
 
 	SND_SOC_DAPM_INPUT("INL"),
 	SND_SOC_DAPM_INPUT("INR"),
+
+	SND_SOC_DAPM_ADC("ADC", "Capture", PCM3060_REG64,
+			 PCM3060_REG_SHIFT_ADPSV, 1),
 };
 
 static const struct snd_soc_dapm_route pcm3060_dapm_map[] = {
-	{ "OUTL", NULL, "Playback" },
-	{ "OUTR", NULL, "Playback" },
+	{ "OUTL", NULL, "DAC" },
+	{ "OUTR", NULL, "DAC" },
 
-	{ "Capture", NULL, "INL" },
-	{ "Capture", NULL, "INR" },
+	{ "ADC", NULL, "INL" },
+	{ "ADC", NULL, "INR" },
 };
 
 /* soc component */
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index c895cf40ee10..6a027b4a845d 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -37,7 +37,9 @@ int pcm3060_remove(struct device *dev);
 #define PCM3060_REG_MRST		0x80
 #define PCM3060_REG_SRST		0x40
 #define PCM3060_REG_ADPSV		0x20
+#define PCM3060_REG_SHIFT_ADPSV	0x05
 #define PCM3060_REG_DAPSV		0x10
+#define PCM3060_REG_SHIFT_DAPSV	0x04
 #define PCM3060_REG_SE			0x01
 
 #define PCM3060_REG65			0x41
-- 
2.19.0.rc2

