Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E6EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F4A2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887489;
	bh=khVUdKzAIpyS8JgShlse1hOac7n4SrNYHOYL52H4E3o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=e/N5QtNchoAhEIPFJQ8xGE2lGRhlu0nUWjnHkB879Bz6RLAkMw8jttkOu92t+mBn2
	 L+bjd6zodjPZhbItpydb4Iwo8JbxYkXmKWnKtRqyK8xOCXgF7IQrVqhtMtW/S6ux34
	 RYbLYk8zdTKrif+DJh0DDm/6Vqbb1w8jfIypzJek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfAGS6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:58:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40494 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfAGS6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fTwMlQKSQwvZm+tfYTBeMwwCikjBXHVLtMlJtOzyiSY=; b=Lff8YIbXTigP
        LZt39ZE30gqKyTcIu4K7FUaLPDMnwDjWjEgITQdp3mPZgc2x+76Voeu29vWopVVwqnwhVLhA9CHqM
        0QbwJ85gLSTOxhZJvek3rv0eHl/YiD56xhAF0Cs9YbDJJ+KjlRimU4UNh+TBWmdF3h2uAtw3ZHtQd
        /kPBI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga60-0007lc-Pq; Mon, 07 Jan 2019 18:57:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 762791127491; Mon,  7 Jan 2019 18:57:56 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Oder Chiou <oder_chiou@realtek.com>, tiwai@suse.de,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rt298: fix boolean tests" to the asoc tree
In-Reply-To:  <20190105020249.8639-9-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185756.762791127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:57:56 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt298: fix boolean tests

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

From f0627d006047299e427f026942fed22b111f04f5 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:36 -0600
Subject: [PATCH] ASoC: rt298: fix boolean tests

Reported by Coccinelle:

sound/soc/codecs/rt298.c:992:6-8: WARNING: Comparison to bool
sound/soc/codecs/rt298.c:995:6-9: WARNING: Comparison to bool
sound/soc/codecs/rt298.c:317:5-7: WARNING: Comparison to bool
sound/soc/codecs/rt298.c:320:5-8: WARNING: Comparison to bool
sound/soc/codecs/rt298.c:348:5-7: WARNING: Comparison to bool
sound/soc/codecs/rt298.c:351:5-8: WARNING: Comparison to bool

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt298.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 06cdba4edfe2..bcf5bab31969 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -314,10 +314,10 @@ static void rt298_jack_detect_work(struct work_struct *work)
 	if (rt298_jack_detect(rt298, &hp, &mic) < 0)
 		return;
 
-	if (hp == true)
+	if (hp)
 		status |= SND_JACK_HEADPHONE;
 
-	if (mic == true)
+	if (mic)
 		status |= SND_JACK_MICROPHONE;
 
 	snd_soc_jack_report(rt298->jack, status,
@@ -345,10 +345,10 @@ int rt298_mic_detect(struct snd_soc_component *component, struct snd_soc_jack *j
 	regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x2, 0x2);
 
 	rt298_jack_detect(rt298, &hp, &mic);
-	if (hp == true)
+	if (hp)
 		status |= SND_JACK_HEADPHONE;
 
-	if (mic == true)
+	if (mic)
 		status |= SND_JACK_MICROPHONE;
 
 	snd_soc_jack_report(rt298->jack, status,
@@ -989,10 +989,10 @@ static irqreturn_t rt298_irq(int irq, void *data)
 	regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x1, 0x1);
 
 	if (ret == 0) {
-		if (hp == true)
+		if (hp)
 			status |= SND_JACK_HEADPHONE;
 
-		if (mic == true)
+		if (mic)
 			status |= SND_JACK_MICROPHONE;
 
 		snd_soc_jack_report(rt298->jack, status,
-- 
2.20.1

