Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F28C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A919021773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549990745;
	bh=zRypxjGL/4LeyGtzza1fONminKHcA55BT8KlHDeIpW8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=WdggKFi/wHr9r9OQLm9R142BIx/Y4nhIQBrpnngCf6FKMeGYEDiH8Fs85JWBcU38s
	 ECriKTYpX4K23QBU4+Z3XrL0jpeOL2PIDLuCWiDgOBJEPcuBVmgm+nmWiGsPV7/h57
	 /RLf0yAgAiySQ4evp0VD98muuCBXTdtkt4KxAXVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbfBLQ7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:59:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36322 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfBLQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=BRp37zSiil75c9dlD3WuYafPCPZ8U/dJ51S73cRPN7g=; b=Q8baFDRtSEBX
        DYm2/nBDDO7aSOTpeVr9k2jqZxR3+WValaLyZvl3ZRqXSXZ7acKScUJ/81b3pOObUD6oIzOe8zsTX
        jnUM1Rffk0qZXqegcDNa6EuhdcrpE5L5SVG/FQw0nN4t4lAcfL+DYA3kb7iWVvHRVge1tApZc+BTd
        ZjTFw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtbOX-0005iF-V0; Tue, 12 Feb 2019 16:58:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 799BD1128113; Tue, 12 Feb 2019 16:58:53 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, lgirdwood@gmail.com,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: dmaengine: Extend use of chan_names provided in custom DMA config" to the asoc tree
In-Reply-To:  <20190207170028.720-3-s.nawrocki@samsung.com>
X-Patchwork-Hint: ignore
Message-Id: <20190212165853.799BD1128113@debutante.sirena.org.uk>
Date:   Tue, 12 Feb 2019 16:58:53 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dmaengine: Extend use of chan_names provided in custom DMA config

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

From 10cbf3507bcb9baa82bf3445502e8ccafaa09fc8 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 7 Feb 2019 18:00:10 +0100
Subject: [PATCH] ASoC: dmaengine: Extend use of chan_names provided in custom
 DMA config

There are currently two ways to specify custom DMA channel names:
 - through the SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag and
   snd_dmaengine_dai_dma_data data structure,
 - through chan_names field of struct snd_dmaengine_pcm_config.

In order to replace the DAI DMA data method with the custom DMA config
one on non-DT platforms the dmaengine_pcm_new() function is extended
to also consider channel names specified in the custom DMA config.
If both config->chan_names and dma_data->chan_name are provided
the former will be used.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 6d7638c1233d..1b44e363c50c 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -288,9 +288,16 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 		if (!pcm->chan[i] &&
-		    (pcm->flags & SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME))
+		    ((pcm->flags & SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME) ||
+		     (config && config->chan_names[i]))) {
+			const char *chan_name = dma_data->chan_name;
+
+			if (config && config->chan_names[i])
+				chan_name = config->chan_names[i];
+
 			pcm->chan[i] = dma_request_slave_channel(dev,
-				dma_data->chan_name);
+				chan_name);
+		}
 
 		if (!pcm->chan[i] && (pcm->flags & SND_DMAENGINE_PCM_FLAG_COMPAT)) {
 			pcm->chan[i] = dmaengine_pcm_compat_request_channel(rtd,
-- 
2.20.1

