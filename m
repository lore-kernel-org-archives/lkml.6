Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61402C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2949D2183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887515;
	bh=kaHprC45OJ/3EicTBRnS1DpxjoB1xUiZ94DMHILhPvQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=EvC9KSb2jJkz1oy1653jgnXQzVUJaRcPuFQXmfqTn1o34jr7TEMiDREGCO9Mvps7f
	 jVGjdLrsv6fKXxtkoz32iRVP4N+uzxqycROuG6tQInJLhrdNqg+doXOArNJDEGDoRP
	 00giRVgZygz6zi3mkBoi8k1wHALIULnemdX6xjYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfAGS6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:58:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41386 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfAGS6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SH9kzvDJH067a+jq/JKApncj8HjPoGjRz+kBcD04Yr4=; b=wJMfH635Vb++
        FCCbqNc7Bwd4qVe0QAs4b8YjgEngEspsMwvCZm8tu3I783hCVHgeUUfdZF8zpq1WfPuzJcg5O/QBs
        82RH1mmurrJo6LS3aUyMmrby0YtkKzVzuJLfHIGyFA4viIgW3NdmMo5YVestn7DgBf6iopIOgGnbH
        a/DpM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6S-0007o6-QW; Mon, 07 Jan 2019 18:58:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 62D671127491; Mon,  7 Jan 2019 18:58:24 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Bard liao <yung-chuan.liao@linux.intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Oder Chiou <oder_chiou@realtek.com>, tiwai@suse.de,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rt5670: remove unused mux/mixer define" to the asoc tree
In-Reply-To:  <20190105020249.8639-7-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185824.62D671127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:24 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5670: remove unused mux/mixer define

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

From 6606f9df60bcb632e047e0f8a268e327cebcc3db Mon Sep 17 00:00:00 2001
From: Bard liao <yung-chuan.liao@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:34 -0600
Subject: [PATCH] ASoC: rt5670: remove unused mux/mixer define

Some mux/mixer are not used. Remove them from the driver.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 54 ---------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 453328c988c0..9a037108b1ae 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -1057,20 +1057,6 @@ static const struct snd_kcontrol_new rt5670_lout_mix[] = {
 			RT5670_M_OV_R_LM_SFT, 1, 1),
 };
 
-static const struct snd_kcontrol_new rt5670_hpl_mix[] = {
-	SOC_DAPM_SINGLE("DAC L1 Switch", RT5670_HPO_MIXER,
-			RT5670_M_DACL1_HML_SFT, 1, 1),
-	SOC_DAPM_SINGLE("INL1 Switch", RT5670_HPO_MIXER,
-			RT5670_M_INL1_HML_SFT, 1, 1),
-};
-
-static const struct snd_kcontrol_new rt5670_hpr_mix[] = {
-	SOC_DAPM_SINGLE("DAC R1 Switch", RT5670_HPO_MIXER,
-			RT5670_M_DACR1_HMR_SFT, 1, 1),
-	SOC_DAPM_SINGLE("INR1 Switch", RT5670_HPO_MIXER,
-			RT5670_M_INR1_HMR_SFT, 1, 1),
-};
-
 static const struct snd_kcontrol_new lout_l_enable_control =
 	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5670_LOUT1,
 		RT5670_L_MUTE_SFT, 1, 1);
@@ -1196,24 +1182,6 @@ static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_adc2_enum, RT5670_STO2_ADC_MIXER,
 static const struct snd_kcontrol_new rt5670_sto2_adc_2_mux =
 	SOC_DAPM_ENUM("Stereo2 ADC 2 Mux", rt5670_stereo2_adc2_enum);
 
-
-/* MX-27 MX26 [10] */
-static const char * const rt5670_stereo_adc_src[] = {
-	"ADC1L ADC2R", "ADC3"
-};
-
-static SOC_ENUM_SINGLE_DECL(rt5670_stereo1_adc_enum, RT5670_STO1_ADC_MIXER,
-	RT5670_ADC_SRC_SFT, rt5670_stereo_adc_src);
-
-static const struct snd_kcontrol_new rt5670_sto_adc_mux =
-	SOC_DAPM_ENUM("Stereo1 ADC source", rt5670_stereo1_adc_enum);
-
-static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_adc_enum, RT5670_STO2_ADC_MIXER,
-	RT5670_ADC_SRC_SFT, rt5670_stereo_adc_src);
-
-static const struct snd_kcontrol_new rt5670_sto2_adc_mux =
-	SOC_DAPM_ENUM("Stereo2 ADC source", rt5670_stereo2_adc_enum);
-
 /* MX-27 MX-26 [9:8] */
 static const char * const rt5670_stereo_dmic_src[] = {
 	"DMIC1", "DMIC2", "DMIC3"
@@ -1231,17 +1199,6 @@ static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_dmic_enum, RT5670_STO2_ADC_MIXER,
 static const struct snd_kcontrol_new rt5670_sto2_dmic_mux =
 	SOC_DAPM_ENUM("Stereo2 DMIC source", rt5670_stereo2_dmic_enum);
 
-/* MX-27 [0] */
-static const char * const rt5670_stereo_dmic3_src[] = {
-	"DMIC3", "PDM ADC"
-};
-
-static SOC_ENUM_SINGLE_DECL(rt5670_stereo_dmic3_enum, RT5670_STO1_ADC_MIXER,
-	RT5670_DMIC3_SRC_SFT, rt5670_stereo_dmic3_src);
-
-static const struct snd_kcontrol_new rt5670_sto_dmic3_mux =
-	SOC_DAPM_ENUM("Stereo DMIC3 source", rt5670_stereo_dmic3_enum);
-
 /* Mono ADC source */
 /* MX-28 [12] */
 static const char * const rt5670_mono_adc_l1_src[] = {
@@ -1334,17 +1291,6 @@ static SOC_ENUM_SINGLE_DECL(rt5670_if2_adc_in_enum, RT5670_DIG_INF1_DATA,
 static const struct snd_kcontrol_new rt5670_if2_adc_in_mux =
 	SOC_DAPM_ENUM("IF2 ADC IN source", rt5670_if2_adc_in_enum);
 
-/* MX-30 [5:4] */
-static const char * const rt5670_if4_adc_in_src[] = {
-	"IF_ADC1", "IF_ADC2", "IF_ADC3"
-};
-
-static SOC_ENUM_SINGLE_DECL(rt5670_if4_adc_in_enum, RT5670_DIG_INF2_DATA,
-	RT5670_IF4_ADC_IN_SFT, rt5670_if4_adc_in_src);
-
-static const struct snd_kcontrol_new rt5670_if4_adc_in_mux =
-	SOC_DAPM_ENUM("IF4 ADC IN source", rt5670_if4_adc_in_enum);
-
 /* MX-31 [15] [13] [11] [9] */
 static const char * const rt5670_pdm_src[] = {
 	"Mono DAC", "Stereo DAC"
-- 
2.20.1

