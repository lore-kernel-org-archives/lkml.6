Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67669C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251942190C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549541766;
	bh=TfFfDZEXutV1GqbzqEtgV8HDvmv3sRn41kTqSnoeiyo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=iGp4vy7BMBhC+/ttao8aNzI0mXGCJazMbOkKghAf292MNckrARz9KK4oiYLDCwD6Z
	 DYREAgx/rKdVPnDi5mtqqLiPaQajYwQRTlP8i8zjbNQVP5SKQJfZttMAvbvDm/DFIz
	 sf4Hhr9rr952zCXnK6ZtP0JwpgCQjd/waM7Eyu2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfBGMQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:16:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41008 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfBGMQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=J1iv1qMi9nR9rEypeqgwcZSI3LEdHU1azLZOvWsG3yw=; b=XRupUlkfTx6R
        UhygqRrppmPcxlKpq+n7bQERXv5hVW8NSJRtKsVAK3PjbXxx4xE/+UVbSVH0vN1Q5exEZZedP3sI7
        dfuk7l+OnPTWVfciTSHnf+6PChCrJf4J+KZYxiT6ePpVuGPVOzGbZfMIAbOP3Nrg1iuaTlWtAQiap
        WsEBI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1griaq-0004uH-Mw; Thu, 07 Feb 2019 12:15:48 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 07A861127EF9; Thu,  7 Feb 2019 12:15:48 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Danny Milosavljevic <dannym@scratchpost.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: sun4i-codec: Add Line Playback Volume, Line Boost Volume, Line Right, Line Left, Line Playback Switch" to the asoc tree
In-Reply-To:  <20190130103945.26692-9-dannym@scratchpost.org>
X-Patchwork-Hint: ignore
Message-Id: <20190207121548.07A861127EF9@debutante.sirena.org.uk>
Date:   Thu,  7 Feb 2019 12:15:48 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-codec: Add Line Playback Volume, Line Boost Volume, Line Right, Line Left, Line Playback Switch

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

From 67690c286de6afa0dc954b19a9878e3623153cb7 Mon Sep 17 00:00:00 2001
From: Danny Milosavljevic <dannym@scratchpost.org>
Date: Wed, 30 Jan 2019 11:39:44 +0100
Subject: [PATCH] ASoC: sun4i-codec: Add Line Playback Volume, Line Boost
 Volume, Line Right, Line Left, Line Playback Switch

Add Line Playback Volume for Allwinner A10 and Allwinner A20.
Add Line Boost Volume for Allwinner A10 and Allwinner A20.
Add Line Right, Line Left, Line Playback Switch for Allwinner A10 and
Allwinner A20.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 2ec7a43975f6..15d08e343b47 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -64,8 +64,11 @@
 #define SUN4I_CODEC_DAC_ACTL_DACAENR			(31)
 #define SUN4I_CODEC_DAC_ACTL_DACAENL			(30)
 #define SUN4I_CODEC_DAC_ACTL_MIXEN			(29)
+#define SUN4I_CODEC_DAC_ACTL_LNG			(26)
 #define SUN4I_CODEC_DAC_ACTL_FMG			(23)
 #define SUN4I_CODEC_DAC_ACTL_MICG			(20)
+#define SUN4I_CODEC_DAC_ACTL_LLNS			(19)
+#define SUN4I_CODEC_DAC_ACTL_RLNS			(18)
 #define SUN4I_CODEC_DAC_ACTL_LFMS			(17)
 #define SUN4I_CODEC_DAC_ACTL_RFMS			(16)
 #define SUN4I_CODEC_DAC_ACTL_LDACLMIXS			(15)
@@ -106,6 +109,7 @@
 #define SUN4I_CODEC_ADC_ACTL_PREG2			(23)
 #define SUN4I_CODEC_ADC_ACTL_VADCG			(20)
 #define SUN4I_CODEC_ADC_ACTL_ADCIS			(17)
+#define SUN4I_CODEC_ADC_ACTL_LNPREG			(13)
 #define SUN4I_CODEC_ADC_ACTL_PA_EN			(4)
 #define SUN4I_CODEC_ADC_ACTL_DDE			(3)
 #define SUN4I_CODEC_ADC_DEBUG			(0x2c)
@@ -686,6 +690,10 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 			SUN4I_CODEC_DAC_ACTL_PA_MUTE, 1, 0);
 
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
+static DECLARE_TLV_DB_SCALE(sun4i_codec_linein_loopback_gain_scale, -150, 150,
+			    0);
+static DECLARE_TLV_DB_SCALE(sun4i_codec_linein_preamp_gain_scale, -1200, 300,
+			    0);
 static DECLARE_TLV_DB_SCALE(sun4i_codec_fmin_loopback_gain_scale, -450, 150,
 			    0);
 static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale, -450, 150,
@@ -701,6 +709,12 @@ static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
+	SOC_SINGLE_TLV("Line Playback Volume", SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_LNG, 1, 0,
+		       sun4i_codec_linein_loopback_gain_scale),
+	SOC_SINGLE_TLV("Line Boost Volume", SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_LNPREG, 7, 0,
+		       sun4i_codec_linein_preamp_gain_scale),
 	SOC_SINGLE_TLV("FM Playback Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_FMG, 3, 0,
 		       sun4i_codec_fmin_loopback_gain_scale),
@@ -719,6 +733,12 @@ static const struct snd_kcontrol_new sun7i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
+	SOC_SINGLE_TLV("Line Playback Volume", SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_LNG, 1, 0,
+		       sun4i_codec_linein_loopback_gain_scale),
+	SOC_SINGLE_TLV("Line Boost Volume", SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_LNPREG, 7, 0,
+		       sun4i_codec_linein_preamp_gain_scale),
 	SOC_SINGLE_TLV("FM Playback Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_FMG, 3, 0,
 		       sun4i_codec_fmin_loopback_gain_scale),
@@ -743,6 +763,9 @@ static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
 			SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
+	SOC_DAPM_DOUBLE("Line Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_LLNS,
+			SUN4I_CODEC_DAC_ACTL_RLNS, 1, 0),
 	SOC_DAPM_DOUBLE("FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LFMS,
 			SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
@@ -814,6 +837,8 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Power Amplifier Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
 
+	SND_SOC_DAPM_INPUT("Line Right"),
+	SND_SOC_DAPM_INPUT("Line Left"),
 	SND_SOC_DAPM_INPUT("FM Right"),
 	SND_SOC_DAPM_INPUT("FM Left"),
 	SND_SOC_DAPM_INPUT("Mic1"),
@@ -836,6 +861,7 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right Mixer", NULL, "Mixer Enable" },
 	{ "Right Mixer", "Right Mixer Left DAC Playback Switch", "Left DAC" },
 	{ "Right Mixer", "Right Mixer Right DAC Playback Switch", "Right DAC" },
+	{ "Right Mixer", "Line Playback Switch", "Line Right" },
 	{ "Right Mixer", "FM Playback Switch", "FM Right" },
 	{ "Right Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
 	{ "Right Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
@@ -843,6 +869,7 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	/* Left Mixer Routes */
 	{ "Left Mixer", NULL, "Mixer Enable" },
 	{ "Left Mixer", "Left Mixer Left DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "Line Playback Switch", "Line Left" },
 	{ "Left Mixer", "FM Playback Switch", "FM Left" },
 	{ "Left Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
 	{ "Left Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
-- 
2.20.1

