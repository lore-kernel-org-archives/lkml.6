Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E973C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC86206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887694;
	bh=9puYaTb1xIozFKEh+3JBUNlmYVQiwDIBrcZ1NLQrB8E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=nITYwiRosYSTNjeLzo1pt2VUv/48qz/puBnRprcYuIUzlj1K8H3HygN+Ac+q/mrnU
	 di6wniH5oikt7hZNRCEZsnJBcS9sO41HidUfVvZeUp+knax71VU4rNvNZ+NPyyFY+z
	 PGLFWhCndMOfVboC8FIor29RlpHaMQAAvEcgiHIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfAGTBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:01:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41186 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfAGS60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=PaZ+YfQlIvYjG77V9ZXFCJAbem2SmoCOWWtH8HKVsPU=; b=hS1lStVEagBB
        KqqqNZFQAPE4qyQQ44X1W7PFrQwdieqfRv4sZwSt9qecgU5++1VSJGHCAyZDY6Z+Ehn8yb9L5EVgF
        HYgMQjZbn1w+p8bGtY7M/GMib7paaxCdzlbxkPJr8HyBd75pkpVL2YPRsdLMwwlIPI3r9gYECldKh
        8ZtM4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6J-0007n0-AB; Mon, 07 Jan 2019 18:58:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E8CCB1127492; Mon,  7 Jan 2019 18:58:14 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Oder Chiou <oder_chiou@realtek.com>, tiwai@suse.de,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rt5640: fix boolean assignments" to the asoc tree
In-Reply-To:  <20190105020249.8639-13-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185814.E8CCB1127492@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:14 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5640: fix boolean assignments

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

From e0a99927ff5f395f24e09e6297858cd2006793f7 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:40 -0600
Subject: [PATCH] ASoC: rt5640: fix boolean assignments

Reported by Coccinelle:
sound/soc/codecs/rt5640.c:980:2-17: WARNING: Assignment of bool to 0/1
sound/soc/codecs/rt5640.c:984:2-17: WARNING: Assignment of bool to 0/1
sound/soc/codecs/rt5640.c:2825:1-16: WARNING: Assignment of bool to 0/1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index fc530481a6e4..b3580ecadecf 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -977,11 +977,11 @@ static int rt5640_hp_event(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		rt5640_pmu_depop(component);
-		rt5640->hp_mute = 0;
+		rt5640->hp_mute = false;
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-		rt5640->hp_mute = 1;
+		rt5640->hp_mute = true;
 		msleep(70);
 		break;
 
@@ -2822,7 +2822,7 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt5640->regmap, RT5640_DUMMY1,
 				RT5640_MCLK_DET, RT5640_MCLK_DET);
 
-	rt5640->hp_mute = 1;
+	rt5640->hp_mute = true;
 	rt5640->irq = i2c->irq;
 	INIT_DELAYED_WORK(&rt5640->bp_work, rt5640_button_press_work);
 	INIT_WORK(&rt5640->jack_work, rt5640_jack_work);
-- 
2.20.1

