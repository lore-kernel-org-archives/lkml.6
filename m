Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680D6C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240E3208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="PUcRidz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240E3208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934953AbeFRMAc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:00:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45880 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933575AbeFRMA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+7ew39sr4Feny/u0aX5Molqap3LpGBm3vj42I3g413E=; b=PUcRidz6Q8cm
        GiDvZe0qamj5FFaDgxqqzgb7V5l4w2LQDteVCTrkRTJygyZygOlW1Og6QAF/ToCJuo3E/mHx6Lhwd
        zls9MI+0EnjQRlyyjW1jjWJ521i4hcr8qkeKQL9jCsFngJbjoFoABR+pStG58GNcfO2y5AuuhMOSV
        4sdxk=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspf-0007z8-1B; Mon, 18 Jun 2018 12:00:27 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspe-0000H5-Il; Mon, 18 Jun 2018 13:00:26 +0100
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
Subject: Applied "ASoC: AMD: Add NULL pointer check" to the asoc tree
In-Reply-To:  <1528354129-5023-1-git-send-email-akshu.agrawal@amd.com>
Message-Id: <E1fUspe-0000H5-Il@debutante>
Date:   Mon, 18 Jun 2018 13:00:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Add NULL pointer check

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

From 6e56e5d04191aa20e08430dcb203c081fa247e93 Mon Sep 17 00:00:00 2001
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Date: Thu, 7 Jun 2018 14:48:43 +0800
Subject: [PATCH] ASoC: AMD: Add NULL pointer check

Fix crash in those platforms whose machine driver does not expose
platform_info. For those platforms we rely on default value and
select I2SSP channel.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 77203841c535..1458b5048498 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -773,7 +773,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (WARN_ON(!rtd))
 		return -EINVAL;
 
-	rtd->i2s_instance = pinfo->i2s_instance;
+	if (pinfo)
+		rtd->i2s_instance = pinfo->i2s_instance;
 	if (adata->asic_type == CHIP_STONEY) {
 		val = acp_reg_read(adata->acp_mmio,
 				   mmACP_I2S_16BIT_RESOLUTION_EN);
-- 
2.17.1

