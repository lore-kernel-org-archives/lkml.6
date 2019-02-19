Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54A8C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899052087B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550661232;
	bh=ZbKN+64r1HSS+TbwFY9CTTWInt11N95xh9aX03EAqrc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1dqfF0e7TssGEFkY50t0AtUshyqCFUmQRIXyEVtKEJTLNlTzezwQ6PNsd6ft3qJ8A
	 r6kdHaUvHSXqXVQmlMa6/qPaD1nULGBcFEGn4zyswAu2D467leNOKIdod2tDcapqzs
	 AQUSak16zwL+3Lk5Oxe9fC+5UE/NLY8e/ZDdz7iA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfBTLNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:13:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45062 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfBTLNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=5a9zKw2eSUcz77NUFjUpGYNDUVyazIqQEz09C8lddxA=; b=FbeTJQj4Repv
        Uv3zQEif4WY6sjCmcAKF86ToBbO+mVaTlBekKITAVeVT0hoPssrAV1XXhlzldiq3rXUcDzgdNpjNc
        GrjttCnlHnWp11sMbSyeB1bXKDE1OEKfh/v66YGL0tfzyyQVr5B5jyY/YEmFc5BSlrPF5rXGB0olf
        Ilp10=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwPom-00011g-Mo; Wed, 20 Feb 2019 11:13:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 29FAB11284BB; Tue, 19 Feb 2019 15:50:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: sunxi: sun50i-codec-analog: Rename hpvcc regulator supply to cpvdd" to the asoc tree
In-Reply-To:  <20190213070457.26049-2-wens@csie.org>
X-Patchwork-Hint: ignore
Message-Id: <20190219155016.29FAB11284BB@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 15:50:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sunxi: sun50i-codec-analog: Rename hpvcc regulator supply to cpvdd

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

From 5fd812e6f5ae0376134234ceb70e8de541ccb10d Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 13 Feb 2019 15:04:56 +0800
Subject: [PATCH] ASoC: sunxi: sun50i-codec-analog: Rename hpvcc regulator
 supply to cpvdd

The A64 datasheet lists the supply rail for the headphone amp's charge
pump as "CPVDD". cpvdd-supply is the name of the property for this power
rail specified in the device tree bindings. "HPVCC" was the name used in
the A33 datasheet for the same function.

Rename the supply so it matches the datasheet, bindings, and the subject
from the original commit.

Fixes: ca0412a05756 ("ASoC: sunxi: sun50i-codec-analog: Add support for cpvdd regulator supply")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index df1fed0aa001..d105c90c3706 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -274,7 +274,7 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 	 * stream widgets at the card level.
 	 */
 
-	SND_SOC_DAPM_REGULATOR_SUPPLY("hpvcc", 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("cpvdd", 0, 0),
 	SND_SOC_DAPM_MUX("Headphone Source Playback Route",
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
 	SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUN50I_ADDA_HP_CTRL,
@@ -362,7 +362,7 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "Headphone Source Playback Route", "Mixer", "Left Mixer" },
 	{ "Headphone Source Playback Route", "Mixer", "Right Mixer" },
 	{ "Headphone Amp", NULL, "Headphone Source Playback Route" },
-	{ "Headphone Amp", NULL, "hpvcc" },
+	{ "Headphone Amp", NULL, "cpvdd" },
 	{ "HP", NULL, "Headphone Amp" },
 
 	/* Microphone Routes */
-- 
2.20.1

