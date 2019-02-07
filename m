Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D663CC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BC921919
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549541770;
	bh=qIjngaDAQgA5t8faX/UbXQvmE3MVjNXt93MjBrOYiPY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=eEjilJrb5+Lx3c4V9DFRxcLi5HMib1LcwH5BViEEcbAw3PjY6gLna4od+GXBeH16o
	 osf2Dsi20mH0p0HGpfBNadqFD58CYpMVZbqgHCAnyQDf6oVFS+b+73Qmpj0WMnIz3P
	 aaVI2zxNDiRuQXrW/zIwtb9P79SEYQMu50Swr0O0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfBGMQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:16:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41106 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfBGMQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bf46GNpglyGMcK4ZqqZxL5F2J1YqMPKaCsn5qPkDrMQ=; b=SewiX49BiS8L
        cG6umJLQbWNhx6FpXxkqKbb8H3BIeHS8zxf4KSi8LPZw7QFAZLWA5BuaiziJltWqP5RTrpAfo6Ie9
        jJFS10QsJl+4VUtPyGaQUkGVG8CA2n+H+DgiekdybcATVUuT+FHe4zGdL28pgeipS8GMmi2PBHwYZ
        6BNAE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1griay-0004ul-RW; Thu, 07 Feb 2019 12:15:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7FA641127EF9; Thu,  7 Feb 2019 12:15:56 +0000 (GMT)
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
Subject: Applied "ASoC: sun4i-codec: Add Mic1 Boost Volume, Mic2 Boost Volume" to the asoc tree
In-Reply-To:  <20190130103945.26692-5-dannym@scratchpost.org>
X-Patchwork-Hint: ignore
Message-Id: <20190207121556.7FA641127EF9@debutante.sirena.org.uk>
Date:   Thu,  7 Feb 2019 12:15:56 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-codec: Add Mic1 Boost Volume, Mic2 Boost Volume

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

From b329c78eb0c80bf17e877edde6d42c0793f19024 Mon Sep 17 00:00:00 2001
From: Danny Milosavljevic <dannym@scratchpost.org>
Date: Wed, 30 Jan 2019 11:39:40 +0100
Subject: [PATCH] ASoC: sun4i-codec: Add Mic1 Boost Volume, Mic2 Boost Volume

Add Mic1 Boost Volume and Mic2 Boost Volume for Allwinner A10 and for
Allwinner A20.

Those controls are in different registers per chip model, so put the
Allwinner A10 controls and the Allwinner A20 controls into the newly
split sun4i_codec_controls and sun7i_codec_controls, respectively.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 52453c46b409..9d509ede22c7 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -95,6 +95,8 @@
 #define SUN4I_CODEC_ADC_ACTL_PREG1EN			(29)
 #define SUN4I_CODEC_ADC_ACTL_PREG2EN			(28)
 #define SUN4I_CODEC_ADC_ACTL_VMICEN			(27)
+#define SUN4I_CODEC_ADC_ACTL_PREG1			(25)
+#define SUN4I_CODEC_ADC_ACTL_PREG2			(23)
 #define SUN4I_CODEC_ADC_ACTL_VADCG			(20)
 #define SUN4I_CODEC_ADC_ACTL_ADCIS			(17)
 #define SUN4I_CODEC_ADC_ACTL_PA_EN			(4)
@@ -111,6 +113,9 @@
 /* Microphone controls (sun7i only) */
 #define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
 
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1		(29)
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2		(26)
+
 /*
  * sun6i specific registers
  *
@@ -676,6 +681,12 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
 static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale, -450, 150,
 			    0);
+static DECLARE_TLV_DB_RANGE(sun4i_codec_micin_preamp_gain_scale,
+			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+			    1, 7, TLV_DB_SCALE_ITEM(3500, 300, 0));
+static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
+			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+			    1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0));
 
 static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
@@ -684,6 +695,12 @@ static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
 		       sun4i_codec_micin_loopback_gain_scale),
+	SOC_SINGLE_TLV("Mic1 Boost Volume", SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_PREG1, 3, 0,
+		       sun4i_codec_micin_preamp_gain_scale),
+	SOC_SINGLE_TLV("Mic2 Boost Volume", SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_PREG2, 3, 0,
+		       sun4i_codec_micin_preamp_gain_scale),
 };
 
 static const struct snd_kcontrol_new sun7i_codec_controls[] = {
@@ -693,6 +710,12 @@ static const struct snd_kcontrol_new sun7i_codec_controls[] = {
 	SOC_SINGLE_TLV("Mic Playback Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_MICG, 7, 0,
 		       sun4i_codec_micin_loopback_gain_scale),
+	SOC_SINGLE_TLV("Mic1 Boost Volume", SUN7I_CODEC_AC_MIC_PHONE_CAL,
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1, 7, 0,
+		       sun7i_codec_micin_preamp_gain_scale),
+	SOC_SINGLE_TLV("Mic2 Boost Volume", SUN7I_CODEC_AC_MIC_PHONE_CAL,
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2, 7, 0,
+		       sun7i_codec_micin_preamp_gain_scale),
 };
 
 static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
-- 
2.20.1

