Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C715C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCEA206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887673;
	bh=Z/64+ai/ScdGA8D9ruSyz/B+1SVAwTzfgq4zH6Sw3FQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=iP07u4byOAHV1b54s/9nfVRs3May9iZ1Syef0lkCUFc/RyMKZl9/cq2aWVnqri1H3
	 /MeiurfRG6gZV4PucCmBg8m95+0AXPeDVurwWJKh40eAfpLbftIJbKDKpdyhzT5x6z
	 3/zVHKKu/G/n95ppgGKtFz6lITRE9MdY7SmGAkUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfAGTBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:01:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41456 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbfAGS6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=boVUgfP4fjTSD8RRTg3eIDX1I/g7Z81HLtimQC1prcM=; b=qrOVQmJHaTfp
        ilqzv5XNUyK1yMtyPxpMTi2wkRjnhtuAcAL/A/9PIWza31lfwg3ORfsctcYrIVWGPAK3+QfDxM1bz
        RvW2Rdpa1dmXrjqaQWUJEW80EgBfK864gsrDvmLS9LrO69UUsLNpszP+/K4T9JodK0CIGRT3vNrR0
        XI9ME=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6U-0007oK-JL; Mon, 07 Jan 2019 18:58:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3FE911127491; Mon,  7 Jan 2019 18:58:26 +0000 (GMT)
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
Subject: Applied "ASoC: rt5645: remove unused mux define" to the asoc tree
In-Reply-To:  <20190105020249.8639-6-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185826.3FE911127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:26 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5645: remove unused mux define

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

From c3db21324442137552041711a878d75358c993ae Mon Sep 17 00:00:00 2001
From: Bard liao <yung-chuan.liao@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:33 -0600
Subject: [PATCH] ASoC: rt5645: remove unused mux define

rt5645_if3_adc_in_mux, rt5645_inr_mux, and rt5645_inl_mux are not used.
Remove them from the driver.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index be674688dc40..52ce380c8f3a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1288,30 +1288,6 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5645_dac_r2_mux =
 	SOC_DAPM_ENUM("DAC2 R source", rt5645_dac2r_enum);
 
-
-/* INL/R source */
-static const char * const rt5645_inl_src[] = {
-	"IN2P", "MonoP"
-};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5645_inl_enum, RT5645_INL1_INR1_VOL,
-	RT5645_INL_SEL_SFT, rt5645_inl_src);
-
-static const struct snd_kcontrol_new rt5645_inl_mux =
-	SOC_DAPM_ENUM("INL source", rt5645_inl_enum);
-
-static const char * const rt5645_inr_src[] = {
-	"IN2N", "MonoN"
-};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5645_inr_enum, RT5645_INL1_INR1_VOL,
-	RT5645_INR_SEL_SFT, rt5645_inr_src);
-
-static const struct snd_kcontrol_new rt5645_inr_mux =
-	SOC_DAPM_ENUM("INR source", rt5645_inr_enum);
-
 /* Stereo1 ADC source */
 /* MX-27 [12] */
 static const char * const rt5645_stereo_adc1_src[] = {
@@ -1611,18 +1587,6 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5645_if2_adc_in_mux =
 	SOC_DAPM_ENUM("IF2 ADC IN source", rt5645_if2_adc_in_enum);
 
-/* MX-2F [1:0] */
-static const char * const rt5645_if3_adc_in_src[] = {
-	"IF_ADC1", "IF_ADC2", "VAD_ADC"
-};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5645_if3_adc_in_enum, RT5645_DIG_INF1_DATA,
-	RT5645_IF3_ADC_IN_SFT, rt5645_if3_adc_in_src);
-
-static const struct snd_kcontrol_new rt5645_if3_adc_in_mux =
-	SOC_DAPM_ENUM("IF3 ADC IN source", rt5645_if3_adc_in_enum);
-
 /* MX-31 [15] [13] [11] [9] */
 static const char * const rt5645_pdm_src[] = {
 	"Mono DAC", "Stereo DAC"
-- 
2.20.1

