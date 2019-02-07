Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94E6C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA80121904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549541792;
	bh=QsO1SXIRGzM2AJqYAdbSp29DSgblrggXsWBAz9aKhio=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=d1PUpGAph4voE/vC4jU7XgYCMDoXlUlgKFMxHp1Ct2avUNLGL7t53AYYO9yw6yknk
	 Y00aBOmh5yzau/f+5OCMeH6aVKPHkvY54P0iGoLorofBtnTcskMdJ8lwhONAv2SIqD
	 FW1O3BuVwDZs5aDkjGSAwShFqSSd9zdoe39kdSBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfBGMQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:16:31 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41766 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfBGMQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=yFkwKMvykrDydXmI294G9wD/aqb9Rwvefm4MYvh9e0o=; b=Dqw/Q0HlQwLr
        pOOzDspNJIdUR3sZ3HrHkhtzZNiHK+4Kex3fLl5zjYnkYruUfgwqF4azmJY7zMJ/krfbl4vLy/Uyf
        TygQ8RZH7AvVEBUM7FXxrzol9mnNkdG07vSII6hkY8tP7GsYkDtqtV/kfl72lmpWmawOJpLpKEfQg
        xyxTE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grib5-0004vM-H5; Thu, 07 Feb 2019 12:16:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1BB971127EF9; Thu,  7 Feb 2019 12:16:03 +0000 (GMT)
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
Subject: Applied "ASoC: sun4i-codec: Add MIC2 Pre-Amplifier, Mic2 input" to the asoc tree
In-Reply-To:  <20190130103945.26692-2-dannym@scratchpost.org>
X-Patchwork-Hint: ignore
Message-Id: <20190207121603.1BB971127EF9@debutante.sirena.org.uk>
Date:   Thu,  7 Feb 2019 12:16:03 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-codec: Add MIC2 Pre-Amplifier, Mic2 input

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

From 63bd84890fc41f280809a9bce7326529d044e2f9 Mon Sep 17 00:00:00 2001
From: Danny Milosavljevic <dannym@scratchpost.org>
Date: Wed, 30 Jan 2019 11:39:37 +0100
Subject: [PATCH] ASoC: sun4i-codec: Add MIC2 Pre-Amplifier, Mic2 input

Add MIC2 Pre-Amplifier, Mic2 input for Allwinner A10 and Allwinner A20.

Previously, there only the Mic1 input and MIC1 Pre-Amplifier was exposed.
This exposes the Mic2 input and MIC2 Pre-Amplifier.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 9a3cb7704810..7b965bc50042 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -64,6 +64,7 @@
 #define SUN4I_CODEC_DAC_ACTL_DACAENR			(31)
 #define SUN4I_CODEC_DAC_ACTL_DACAENL			(30)
 #define SUN4I_CODEC_DAC_ACTL_MIXEN			(29)
+#define SUN4I_CODEC_DAC_ACTL_MICG			(20)
 #define SUN4I_CODEC_DAC_ACTL_LDACLMIXS			(15)
 #define SUN4I_CODEC_DAC_ACTL_RDACRMIXS			(14)
 #define SUN4I_CODEC_DAC_ACTL_LDACRMIXS			(13)
@@ -673,6 +674,8 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 			SUN4I_CODEC_DAC_ACTL_PA_MUTE, 1, 0);
 
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
+static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale, -450, 150,
+			    0);
 
 static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
@@ -741,6 +744,8 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	/* Mic Pre-Amplifiers */
 	SND_SOC_DAPM_PGA("MIC1 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
 			 SUN4I_CODEC_ADC_ACTL_PREG1EN, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("MIC2 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
+			 SUN4I_CODEC_ADC_ACTL_PREG2EN, 0, NULL, 0),
 
 	/* Power Amplifier */
 	SND_SOC_DAPM_MIXER("Power Amplifier", SUN4I_CODEC_ADC_ACTL,
@@ -751,6 +756,7 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 			    &sun4i_codec_pa_mute),
 
 	SND_SOC_DAPM_INPUT("Mic1"),
+	SND_SOC_DAPM_INPUT("Mic2"),
 
 	SND_SOC_DAPM_OUTPUT("HP Right"),
 	SND_SOC_DAPM_OUTPUT("HP Left"),
@@ -790,6 +796,12 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right ADC", NULL, "MIC1 Pre-Amplifier" },
 	{ "MIC1 Pre-Amplifier", NULL, "Mic1"},
 	{ "Mic1", NULL, "VMIC" },
+
+	/* Mic2 Routes */
+	{ "Left ADC", NULL, "MIC2 Pre-Amplifier" },
+	{ "Right ADC", NULL, "MIC2 Pre-Amplifier" },
+	{ "MIC2 Pre-Amplifier", NULL, "Mic2"},
+	{ "Mic2", NULL, "VMIC" },
 };
 
 static const struct snd_soc_component_driver sun4i_codec_codec = {
-- 
2.20.1

