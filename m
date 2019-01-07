Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06FDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F54321855
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887507;
	bh=BqTU/NZub2a5dqaz/zxzK12ojdjUwCS5siDTMgdl4m8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UOvX2omajVq5cySHBZxUE5bpegILOoEETITJGPpCptay48wuOliEnA/A1UmMzAi+p
	 bTyXX96Y8BbZhvOrvr/9+jkYbfErcvkkJp3KcmXdaxY9+8UilCJsQ4SL5adl88m0BR
	 63i1rznnJZMIQy306nev0ffj2r5npOTtykX+XGR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfAGS60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:58:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41180 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbfAGS6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=g99U2pmVAZezQ+Vu68b6TfajWVUt3AQ3D7XYpSJfzX0=; b=WS50BhI1FWtp
        qQxLvekprp3cJ9ofTW3CuTmG01DYi9PR+Dy94/SmF4iVuPaFEhANOmNSAKM7f+GKOxglusn6gNgEW
        KeDsBS8cMiUlUyMozRKFShAXaS9fLqGkI2ImecySV2GChRFb9wh8ko3SMojPxd6J6VbuvBk2MlVmx
        PWpmc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6M-0007nT-VE; Mon, 07 Jan 2019 18:58:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 983281127491; Mon,  7 Jan 2019 18:58:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Oder Chiou <oder_chiou@realtek.com>, tiwai@suse.de,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rt274: fix boolean tests" to the asoc tree
In-Reply-To:  <20190105020249.8639-11-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185818.983281127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt274: fix boolean tests

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

From b793a1e4ebad5c9066f404dee13fec875fb9b4e5 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:38 -0600
Subject: [PATCH] ASoC: rt274: fix boolean tests

Reported by Coccinelle:

sound/soc/codecs/rt274.c:958:6-8: WARNING: Comparison to bool
sound/soc/codecs/rt274.c:961:6-9: WARNING: Comparison to bool
sound/soc/codecs/rt274.c:384:5-7: WARNING: Comparison to bool
sound/soc/codecs/rt274.c:387:5-8: WARNING: Comparison to bool

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt274.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index e2855ab9a2c6..9e88f7b25d38 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -381,10 +381,10 @@ static void rt274_jack_detect_work(struct work_struct *work)
 	if (rt274_jack_detect(rt274, &hp, &mic) < 0)
 		return;
 
-	if (hp == true)
+	if (hp)
 		status |= SND_JACK_HEADPHONE;
 
-	if (mic == true)
+	if (mic)
 		status |= SND_JACK_MICROPHONE;
 
 	snd_soc_jack_report(rt274->jack, status,
@@ -955,10 +955,10 @@ static irqreturn_t rt274_irq(int irq, void *data)
 	ret = rt274_jack_detect(rt274, &hp, &mic);
 
 	if (ret == 0) {
-		if (hp == true)
+		if (hp)
 			status |= SND_JACK_HEADPHONE;
 
-		if (mic == true)
+		if (mic)
 			status |= SND_JACK_MICROPHONE;
 
 		snd_soc_jack_report(rt274->jack, status,
-- 
2.20.1

