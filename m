Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC6BC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC1621904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549541778;
	bh=Q0fkQD8b/lguXKXCf0+iHVBKDlOZoXBSDYq9UCHmoDc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=rlvPzzrZuxV+CDh6swBBWLhjOZYD4sdazm0LFpOaaH8XNe3nJsD+E4b1jVu0mR7g+
	 d+XKYMmd2qs+xKx5pvibcSVLY1SZN2vXOyMSFlh3YfLVAQLExfp5Q2rN/aDaPwKxgU
	 +TCoO/xnrZg+Ymuh4mt6VIAponSXGxMVRPzaoiuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfBGMQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:16:17 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41446 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfBGMQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=V76Z8YZTg9N28qpEuPH+fzbWFazRwxSS32fWgKYnR2o=; b=CIl2X1E0BR5C
        kFGK4Th2ZdR0dAF1n4hF7dFbJHyXUGqygYkE3o+M1iTkSDVvyyD4vCY5RA2b2Xli6ELp4mK/6LSOH
        aMzhvcT5JwW/5kaifuL75F7Zhi1zA/oHAwcMhPF8gE+cRfT1sogbQowSWma+cF2K6BC71meXwXXAp
        Ztg7s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grib7-0004vX-NQ; Thu, 07 Feb 2019 12:16:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 476781127EF9; Thu,  7 Feb 2019 12:16:05 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Cercueil <paul@crapouillou.net>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: codecs: jz4725b: fix spelling mistake "Deemphatize" -> "Deemphasize"" to the asoc tree
In-Reply-To:  <20190207092642.6655-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190207121605.476781127EF9@debutante.sirena.org.uk>
Date:   Thu,  7 Feb 2019 12:16:05 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: jz4725b: fix spelling mistake "Deemphatize" -> "Deemphasize"

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

From 6c3e6302364aa5d152e0f5f81d550fdbc7bb8d38 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 7 Feb 2019 09:26:42 +0000
Subject: [PATCH] ASoC: codecs: jz4725b: fix spelling mistake "Deemphatize" ->
 "Deemphasize"

There is a spelling mistake in the SOC_SINGLE control name. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/jz4725b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index e3dba92f30bd..24b1b23b99c9 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -161,7 +161,7 @@ static const struct snd_kcontrol_new jz4725b_codec_controls[] = {
 	SOC_SINGLE("Master Playback Switch", JZ4725B_CODEC_REG_CR1,
 		   REG_CR1_DAC_MUTE_OFFSET, 1, 1),
 
-	SOC_SINGLE("Deemphatize Filter Playback Switch",
+	SOC_SINGLE("Deemphasize Filter Playback Switch",
 		   JZ4725B_CODEC_REG_CR2,
 		   REG_CR2_DAC_DEEMP_OFFSET, 1, 0),
 
-- 
2.20.1

