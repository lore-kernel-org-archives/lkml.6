Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082B2C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F2E20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544702981;
	bh=7ywETw7ijWxbKxj7UgEno/MRazMByzFpqzeyXouAz5I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bw9VBqFE7kOWcsjBmXTsaMix8VrhxHZEF1tS4mmFvCnKzvYjsin9bi/RYOvg7ag1e
	 FPxfFc8TofEJ7wEBtnWmpd3AJCPRAKE91xhzswx22jFyhy8iLtSIF6f6Qw7RU5a15R
	 Bh/qXwxAZzqA0oMicTlrahwcablQjjV2kjv3OWHE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F2E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbeLMMJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:09:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50126 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbeLMMJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Ixo3sfGEacve1OwFyxuMVyccDUTAC0pmwvgOrXHJTJ8=; b=Cizs9jqSdX7J
        ulJ4wOJQ624/Jo5bpN5JFo2LwIpR55YPc395QIktLCoQN3ztXKJC/OVObw6A7Lfhya8jbPEVN+HBI
        ohiJKPEwAG+/4FjdV1BY1CIlEFXH/Hup6tmVoDw1DYGrga9Mjxd8mkU8dPH20tzN/1nIz1y++Vwcp
        xm8sw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXPnJ-0000yB-M1; Thu, 13 Dec 2018 12:08:45 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5A29511254D1; Thu, 13 Dec 2018 12:08:45 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: axg-toddr: add support for spdifin backend" to the asoc tree
In-Reply-To:  <20181211134713.4908-2-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20181213120845.5A29511254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 12:08:45 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-toddr: add support for spdifin backend

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

From 984463a94d5cb23120bfe7d689077b940c25128b Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 11 Dec 2018 14:47:10 +0100
Subject: [PATCH] ASoC: meson: axg-toddr: add support for spdifin backend

add IEC958_SUBFRAME_LE to the list of format accepted by the fifo frontend.

As opposed to what was initially noted in the toddr dai driver, the spdifin
does not place the msb at bit 28, it just output a whole spdif subframe.

Placing the msb at bit 28 in the toddr driver just filters out the parity,
user, channel status and validity bits. It is better to just provide the
whole spdif subframe to the userspace and let the iec958 plugin deal with
it.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-fifo.h  |  3 ++-
 sound/soc/meson/axg-toddr.c | 15 +++++----------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index cb6c4013ca33..d9f516cfbeda 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -25,7 +25,8 @@ struct snd_soc_pcm_runtime;
 					 SNDRV_PCM_FMTBIT_S16_LE |	\
 					 SNDRV_PCM_FMTBIT_S20_LE |	\
 					 SNDRV_PCM_FMTBIT_S24_LE |	\
-					 SNDRV_PCM_FMTBIT_S32_LE)
+					 SNDRV_PCM_FMTBIT_S32_LE |	\
+					 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
 
 #define AXG_FIFO_BURST			8
 #define AXG_FIFO_MIN_CNT		64
diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index c2c9bb312586..0e9ca3882ae5 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -25,6 +25,8 @@
 #define CTRL0_TODDR_LSB_POS_MASK	GENMASK(7, 3)
 #define CTRL0_TODDR_LSB_POS(x)		((x) << 3)
 
+#define TODDR_MSB_POS	31
+
 static int axg_toddr_pcm_new(struct snd_soc_pcm_runtime *rtd,
 			     struct snd_soc_dai *dai)
 {
@@ -36,14 +38,7 @@ static int axg_toddr_dai_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_soc_dai *dai)
 {
 	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
-	unsigned int type, width, msb = 31;
-
-	/*
-	 * NOTE:
-	 * Almost all backend will place the MSB at bit 31, except SPDIF Input
-	 * which will put it at index 28. When adding support for the SPDIF
-	 * Input, we'll need to find which type of backend we are connected to.
-	 */
+	unsigned int type, width;
 
 	switch (params_physical_width(params)) {
 	case 8:
@@ -66,8 +61,8 @@ static int axg_toddr_dai_hw_params(struct snd_pcm_substream *substream,
 			   CTRL0_TODDR_MSB_POS_MASK |
 			   CTRL0_TODDR_LSB_POS_MASK,
 			   CTRL0_TODDR_TYPE(type) |
-			   CTRL0_TODDR_MSB_POS(msb) |
-			   CTRL0_TODDR_LSB_POS(msb - (width - 1)));
+			   CTRL0_TODDR_MSB_POS(TODDR_MSB_POS) |
+			   CTRL0_TODDR_LSB_POS(TODDR_MSB_POS - (width - 1)));
 
 	return 0;
 }
-- 
2.19.0.rc2

