Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBCCC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891022183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887517;
	bh=MTC1OzUKTjCjkN2Axb2VFIRbbHTErEbqeMah1Wo4WI0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=wFqJhLey1t1BeVQBxsgiGB59I7z1Jj3NaFm77kdHoaCWHeX+cmIE4/PUjIk0HywzC
	 MV6aLdn8RvMo9fOSMvey6tuSIOGciSP6YtFEKS9axAemIIkWZmmdzDUr8vuX4+keQl
	 SVpl/loApzqgEv9Vj+WVv/pso2Iz4xNNtVgT8ydU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfAGS6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:58:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41528 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbfAGS6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=n4CR0s/sAHX3Jmyo1rxud2rBl816iwSwZ6KU31f6RcU=; b=rPilN5hJDcvl
        jhkU3KO/crUK74Iuze5mEp8Df3p8BLKFBoPPI6yLqINpxOguifN5uVid8YLT20rrYmee+Nt9aKKyA
        rohH+iRdApUFaiHm3OSa6q+WD2/Ta3mUMsanluNbccSQMtlEnsRH29pKsGbAs6WFf2mX9dSBr+bzj
        LcZRw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6F-0007mQ-3H; Mon, 07 Jan 2019 18:58:11 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B04001127491; Mon,  7 Jan 2019 18:58:05 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Kai Chieh Chuang <kaichieh.chuang@mediatek.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: mt6351: remove unneeded variable" to the asoc tree
In-Reply-To:  <20190105020249.8639-18-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185805.B04001127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:05 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mt6351: remove unneeded variable

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

From d61780c155e8bef8dceb3ac98d29f79c24e264eb Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:45 -0600
Subject: [PATCH] ASoC: mt6351: remove unneeded variable

Reported by Coccinelle:
mt6351.c:1418:5-8: Unneeded variable: "ret". Return "0" on line 1437

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/mt6351.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/mt6351.c b/sound/soc/codecs/mt6351.c
index f73dcd753584..4b3ce01c5a93 100644
--- a/sound/soc/codecs/mt6351.c
+++ b/sound/soc/codecs/mt6351.c
@@ -1415,8 +1415,6 @@ static const struct snd_soc_dapm_route mt6351_dapm_routes[] = {
 
 static int mt6351_codec_init_reg(struct snd_soc_component *cmpnt)
 {
-	int ret = 0;
-
 	/* Disable CLKSQ 26MHz */
 	regmap_update_bits(cmpnt->regmap, MT6351_TOP_CLKSQ, 0x0001, 0x0);
 	/* disable AUDGLB */
@@ -1434,7 +1432,7 @@ static int mt6351_codec_init_reg(struct snd_soc_component *cmpnt)
 	/* Reverse the PMIC clock*/
 	regmap_update_bits(cmpnt->regmap, MT6351_AFE_PMIC_NEWIF_CFG2,
 			   0x8000, 0x8000);
-	return ret;
+	return 0;
 }
 
 static int mt6351_codec_probe(struct snd_soc_component *cmpnt)
-- 
2.20.1

