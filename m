Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F05C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E915C206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887513;
	bh=31ZE9/XUldzrGxsjBonvXr4dU8PiqTImNBuj58M9DRc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=FUfdOv7hPQ3/hhfAkNYCV3rTv197xmeuE+uEN647XHRKRQxrahH22RC5egdMBxFSZ
	 3BC5rRcMTll62oh1lLh4C8F6rKb57iTVsTv3CXmCNevLYsMH/eeqCLUY6xhXlIug/r
	 FdUNHkTtWGC3HCzN2MnKMjaimqp28nQYZG2oYlFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfAGS6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:58:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41384 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfAGS6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qTfSCi7tt6hjoLCZ23t3/aAvY2EFosl8SDEaWXiIjyA=; b=hGJCuoftxEmN
        8KYnIg+/p0q688ZrU5kmlXFcp0Xh68JTqDXc0EnkwlOD6dXsko9KYQJMh6FDHpodtdhIOxVqTs7m+
        NdQq1refPW2QOcwS52mroWHSKciqSmFWEug2tiiZf3hO4KlAMVSEFkR5xcZCVlaRitxxwJiO5VHZD
        sGlvU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6Q-0007nt-TJ; Mon, 07 Jan 2019 18:58:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 85B8D1127491; Mon,  7 Jan 2019 18:58:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>,
        Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, liam.r.girdwood@linux.intel.com,
        Grant Grundler <grundler@chromium.org>, broonie@kernel.org,
        Benson Leung <bleung@chromium.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: max98383: fix boolean assignments to true/false" to the asoc tree
In-Reply-To:  <20190105020249.8639-8-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185822.85B8D1127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98383: fix boolean assignments to true/false

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

From 7c3727ba7de2b94a066e38776660e648fa4ed28a Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:35 -0600
Subject: [PATCH] ASoC: max98383: fix boolean assignments to true/false

Reported by Coccinelle:

sound/soc/codecs/max98373.c:411:2-20: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98373.c:922:2-27: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98373.c:924:2-27: WARNING: Assignment of bool to 0/1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 9c8616a7b61c..528695cd6a1c 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -408,7 +408,7 @@ static int max98373_dac_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(max98373->regmap,
 			MAX98373_R20FF_GLOBAL_SHDN,
 			MAX98373_GLOBAL_EN_MASK, 0);
-		max98373->tdm_mode = 0;
+		max98373->tdm_mode = false;
 		break;
 	default:
 		return 0;
@@ -919,9 +919,9 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 
 	/* update interleave mode info */
 	if (device_property_read_bool(&i2c->dev, "maxim,interleave_mode"))
-		max98373->interleave_mode = 1;
+		max98373->interleave_mode = true;
 	else
-		max98373->interleave_mode = 0;
+		max98373->interleave_mode = false;
 
 
 	/* regmap initialization */
-- 
2.20.1

