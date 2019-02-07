Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD4AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F96A2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549541804;
	bh=BS8bE99I87tggQHpQrME3+6K8OWyoeYfkDjQNVsk1FQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=HTe03alhj0uFwTpe284UDJdjYk4tQPIdEme1aNgealdMxd9QObX2XsAONNNOsrCoU
	 JGkr8YQitEpqM5AeXRzziUU+YaSoNjtQGvEh4eXOntjHWiH5Fg2NYnl+OmggEF55Lr
	 1KOA+52sFs7D3U6wEYkJch4dU3ag9WXf4MgUs+m0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfBGMQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:16:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42248 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfBGMQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Mw+ty8+4zZUiIlK0e47kp8Cfbox1CrvRun7jYsD3Ar4=; b=lc3Tss6hd9aa
        2rB/kGovKGo33yy7oGfmu8m2/Tzgc9RUB43mYgZos/h9o6BdVgg6OHH/bgIA5M7i1S1+caPKtBdqa
        aksPMj1CpgThJ4/TCxwnaMnVAnrwbdAXWc32a+pcl0qoheemmeE040Y7dwZMqoS3aUB7y0fC7dEJd
        qAUZw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grib1-0004ux-1z; Thu, 07 Feb 2019 12:15:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9E0071127EF9; Thu,  7 Feb 2019 12:15:58 +0000 (GMT)
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
Subject: Applied "ASoC: sun4i-codec: Add sun7i_codec_controls, sun7i_codec_codec" to the asoc tree
In-Reply-To:  <20190130103945.26692-4-dannym@scratchpost.org>
X-Patchwork-Hint: ignore
Message-Id: <20190207121558.9E0071127EF9@debutante.sirena.org.uk>
Date:   Thu,  7 Feb 2019 12:15:58 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-codec: Add sun7i_codec_controls, sun7i_codec_codec

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

From b71a7eb56c958ffb8c90cef74f3dff6f87e6b554 Mon Sep 17 00:00:00 2001
From: Danny Milosavljevic <dannym@scratchpost.org>
Date: Wed, 30 Jan 2019 11:39:39 +0100
Subject: [PATCH] ASoC: sun4i-codec: Add sun7i_codec_controls,
 sun7i_codec_codec

Introduce sun7i_codec_controls because some of the controls are different
on Allwinner A20 compared to Allwinner A10.

Also introduce sun7i_codec_codec in order to use sun7i_codec_controls and
make sun7i_codec_quirks use sun7i_codec_codec.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 060a40b45ab0..52453c46b409 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -686,6 +686,15 @@ static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 		       sun4i_codec_micin_loopback_gain_scale),
 };
 
+static const struct snd_kcontrol_new sun7i_codec_controls[] = {
+	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
+		       sun4i_codec_pa_volume_scale),
+	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
+		       sun4i_codec_micin_loopback_gain_scale),
+};
+
 static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
@@ -820,6 +829,19 @@ static const struct snd_soc_component_driver sun4i_codec_codec = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static const struct snd_soc_component_driver sun7i_codec_codec = {
+	.controls		= sun7i_codec_controls,
+	.num_controls		= ARRAY_SIZE(sun7i_codec_controls),
+	.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
+	.dapm_routes		= sun4i_codec_codec_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
 /*** sun6i Codec ***/
 
 /* mixer controls */
@@ -1500,7 +1522,7 @@ static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
 
 static const struct sun4i_codec_quirks sun7i_codec_quirks = {
 	.regmap_config	= &sun7i_codec_regmap_config,
-	.codec		= &sun4i_codec_codec,
+	.codec		= &sun7i_codec_codec,
 	.create_card	= sun4i_codec_create_card,
 	.reg_adc_fifoc	= REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
-- 
2.20.1

