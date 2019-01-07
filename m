Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD7EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E98D206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887689;
	bh=PdhdAJ8Z9ax1Xqlm3H0O+4WVvNVoJkiXrhALVE4FGTQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=zhAFUX8XymKvXYcj9dZ1joIkHvIMeaTCbSzIpW503UhjGImdzVWquhx5BT41mHL/4
	 iPMrML7L+QLm4MJ4GlEwyHHwSbFR+M2/YhJu88VhGHQIYEiO2yRluIuOmBNefqktTY
	 Z1x265q6SlghTFtDv2vAgzTJgM8ZDzwlUTDUjaT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfAGS60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:58:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41106 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbfAGS6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=dDdDkEBX26nTt0Sq+KRwI9S+fZ4Gvzc22GZc+fXzHQU=; b=v9fsPWbzWRuf
        Rw+FTKXE0p/ocaFhG392UL4nRpATOZL1GYb0v3S8Eq7uja+73gf4s4je5bDF9kWpGPGbLZW24A5WL
        Sh5+Ok4qBQSoakfLmmGMfa0l6pIR8uWmHx84AcVsvGMgBgqbUNHWBvGT7ioVIfkHSFV+u46/wH6Q4
        RZPLk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6L-0007nD-2m; Mon, 07 Jan 2019 18:58:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BF8051127491; Mon,  7 Jan 2019 18:58:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Oder Chiou <oder_chiou@realtek.com>, tiwai@suse.de,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoc: rt286: fix boolean tests" to the asoc tree
In-Reply-To:  <20190105020249.8639-12-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185816.BF8051127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoc: rt286: fix boolean tests

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

From af3b2b54cb294b997ad9a2a88ed3c6c9af7d03c0 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:39 -0600
Subject: [PATCH] ASoc: rt286: fix boolean tests

Reported by Coccinelle:
sound/soc/codecs/rt286.c:927:5-7: WARNING: Comparison to bool
sound/soc/codecs/rt286.c:930:5-8: WARNING: Comparison to bool
sound/soc/codecs/rt286.c:299:5-7: WARNING: Comparison to bool
sound/soc/codecs/rt286.c:302:5-8: WARNING: Comparison to bool

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt286.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 0b0f748bffbe..c9457c247a03 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -296,10 +296,10 @@ static void rt286_jack_detect_work(struct work_struct *work)
 
 	rt286_jack_detect(rt286, &hp, &mic);
 
-	if (hp == true)
+	if (hp)
 		status |= SND_JACK_HEADPHONE;
 
-	if (mic == true)
+	if (mic)
 		status |= SND_JACK_MICROPHONE;
 
 	snd_soc_jack_report(rt286->jack, status,
@@ -924,10 +924,10 @@ static irqreturn_t rt286_irq(int irq, void *data)
 	/* Clear IRQ */
 	regmap_update_bits(rt286->regmap, RT286_IRQ_CTRL, 0x1, 0x1);
 
-	if (hp == true)
+	if (hp)
 		status |= SND_JACK_HEADPHONE;
 
-	if (mic == true)
+	if (mic)
 		status |= SND_JACK_MICROPHONE;
 
 	snd_soc_jack_report(rt286->jack, status,
-- 
2.20.1

