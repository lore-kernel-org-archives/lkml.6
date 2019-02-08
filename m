Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAA6C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD4021929
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549631493;
	bh=sEFpOrYhF12661QyB2CAsM8ykHJsbt+FeMYV4KWedX4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=JEKlu3w7RglXPyCo9HHKywY++PU2loLbFWQUMyC2TJsqUWgeZr3txeS3S4Vf7+jpM
	 /bgMQ1diMX/TwGFTErchz3n4oY+zuHclSp5U4h68049D8MfKVqiC2sQUh1Th3RJY0T
	 E/KjSGwkcx/ISqpcGYQIDAFEOBTYcQdZ2KcYWneA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfBHNLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:11:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38250 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbfBHNLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Wq+gTG33ZZ+P5TrZ67SqSRUugfdvZ/7dLsRjzL07nXc=; b=Nx7Db1kxPa+M
        rF88Ewr+tohOFXRTmQOUMXhw/7yTsgoEv6YRSq0Wv7IIpIvkMhGJ1qYZk/E4e4s5a+RmMhJP7D/f9
        LqL9R9uQ/2xqvNEaKvQIT+SMLpCyHcA0i2zbN0soemrx1m2Zlx3uJpVg5K9SkMiPdLrHhNF9HrQdW
        xyzzY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gs5w6-0001K6-Of; Fri, 08 Feb 2019 13:11:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 691071127F30; Fri,  8 Feb 2019 13:11:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, lgirdwood@gmail.com,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: doc: Fix typos in dpcm.rst" to the asoc tree
In-Reply-To:  <20190207172256.1972-1-s.nawrocki@samsung.com>
X-Patchwork-Hint: ignore
Message-Id: <20190208131118.691071127F30@debutante.sirena.org.uk>
Date:   Fri,  8 Feb 2019 13:11:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: doc: Fix typos in dpcm.rst

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

From 511d53ac86746f397791e7c4bd47993244fc7420 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 7 Feb 2019 18:22:56 +0100
Subject: [PATCH] ASoC: doc: Fix typos in dpcm.rst

This patch fixes a few typos in the DPCM documentation.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/sound/soc/dpcm.rst | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/sound/soc/dpcm.rst b/Documentation/sound/soc/dpcm.rst
index f6845b2278ea..77f67ded53de 100644
--- a/Documentation/sound/soc/dpcm.rst
+++ b/Documentation/sound/soc/dpcm.rst
@@ -13,7 +13,7 @@ drivers that expose several ALSA PCMs and can route to multiple DAIs.
 The DPCM runtime routing is determined by the ALSA mixer settings in the same
 way as the analog signal is routed in an ASoC codec driver. DPCM uses a DAPM
 graph representing the DSP internal audio paths and uses the mixer settings to
-determine the patch used by each ALSA PCM.
+determine the path used by each ALSA PCM.
 
 DPCM re-uses all the existing component codec, platform and DAI drivers without
 any modifications.
@@ -101,7 +101,7 @@ The audio driver processes this as follows :-
 
 4. Machine driver or audio HAL enables the speaker path.
 
-5. DPCM runs the PCM ops for startup(), hw_params(), prepapre() and
+5. DPCM runs the PCM ops for startup(), hw_params(), prepare() and
    trigger(start) for DAI1 Speakers since the path is enabled.
 
 In this example, the machine driver or userspace audio HAL can alter the routing
@@ -221,7 +221,7 @@ like a BT phone call :-
 This allows the host CPU to sleep while the DSP, MODEM DAI and the BT DAI are
 still in operation.
 
-A BE DAI link can also set the codec to a dummy device if the code is a device
+A BE DAI link can also set the codec to a dummy device if the codec is a device
 that is managed externally.
 
 Likewise a BE DAI can also set a dummy cpu DAI if the CPU DAI is managed by the
@@ -249,7 +249,7 @@ configuration.
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
 
-	/* The DSP will covert the FE rate to 48k, stereo */
+	/* The DSP will convert the FE rate to 48k, stereo */
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
 
@@ -386,5 +386,3 @@ This means creating a new FE that is connected with a virtual path to both
 DAI links. The DAI links will be started when the FE PCM is started and stopped
 when the FE PCM is stopped. Note that the FE PCM cannot read or write data in
 this configuration.
-
-
-- 
2.20.1

