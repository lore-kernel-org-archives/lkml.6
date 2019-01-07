Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7D5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BF52147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887502;
	bh=VpzSbNiHd7o5Ci3oIOC/l+KWxgbag+tzkHfZO8KGMFY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=rBe8jRBlhrXMBbBhGpBJljZQh4uZ2n53JyNExsw9aWfOVuwNBI79H6gV+9tNBUw8j
	 XUr2tn34e9erZi3Pt4y/6T2ond9NMzZ35L4xd9qHXCXXRGsd/4IGf1+DcYQlG1nC2u
	 MJOdTZp9AV3VTdDmsf98Ks1/Eaj0k8bwi6A+O0oI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfAGS6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:58:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40990 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbfAGS6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ySZgogXzCIwuMC4gA8nOYWZCcV820xihZVZ6d49nLg4=; b=lLFJ8tJJTvCl
        uJcANC1/pDl85PkDl/VNoQPaqlVsslwwHzv6ZvRVjYLW5zJWyZtMDinXJ4MLYNDoVnKz8afR61LCd
        r2TB+hm2XpKg6jEsogVjz3HlpXLSsSv3ulZDvVhlyz6YEEdRlQj4am5wOVJiCixN2QtcfKpXQwf/r
        b5fc0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6H-0007mn-HT; Mon, 07 Jan 2019 18:58:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1B96C1127492; Mon,  7 Jan 2019 18:58:13 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: max98927: fix boolean assignments" to the asoc tree
In-Reply-To:  <20190105020249.8639-14-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185813.1B96C1127492@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:13 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98927: fix boolean assignments

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

From 091cd877d8d6b2b934d565134172db771907d50a Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:41 -0600
Subject: [PATCH] ASoC: max98927: fix boolean assignments

Reported by Coccinelle:
sound/soc/codecs/max98927.c:508:2-20: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98927.c:889:3-28: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98927.c:891:3-28: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98927.c:893:2-27: WARNING: Assignment of bool to 0/1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98927.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 065303a46535..e53d2007f3be 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -505,7 +505,7 @@ static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		max98927->tdm_mode = 0;
+		max98927->tdm_mode = false;
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		regmap_update_bits(max98927->regmap,
@@ -886,11 +886,11 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
 	if (!of_property_read_u32(i2c->dev.of_node,
 		"interleave_mode", &value)) {
 		if (value > 0)
-			max98927->interleave_mode = 1;
+			max98927->interleave_mode = true;
 		else
-			max98927->interleave_mode = 0;
+			max98927->interleave_mode = false;
 	} else
-		max98927->interleave_mode = 0;
+		max98927->interleave_mode = false;
 
 	/* regmap initialization */
 	max98927->regmap
-- 
2.20.1

