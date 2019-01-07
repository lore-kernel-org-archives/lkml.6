Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A743C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D4F206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887526;
	bh=JC5PJ0JaeCYjk0olG7osfvIKTonqSdwVhrbb/6qy3G4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=VQn2T0QKhcpb8m9kf+1MT4T2zNcN4XjscG7zBDYyPzsx/JC52f2F4C7RHqtacU07E
	 yWjTrqqmPFSElS/483JxGbDv35av2g7V4HN5qEv5dKOpo5Hkp5gqrYt0+6B+lsJY+k
	 J62SDfHdTzHKx3DSDD3iq19cxoEpYvxeLvXb5R9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfAGS6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:58:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41772 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfAGS6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=i5FB8tX8mOYDHtXFBqKyVzxAaeRrGCI+bjjrmiNODqs=; b=BHflXeqij1fp
        5eFayghG2aVrKBjnCisjs2e3dh/9xACenWHn8frcVY7uhis2u6iJBLy48LbT4KwCWehJPuVm9i24K
        c8vlT0GEeataSpQ8tJ+1+Pa4rNYFHBRas7jqEmPeEYX4TNzW08WSv1+Rr6/njJrYBVLwH5S0K9252
        UDS4g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga6a-0007or-6e; Mon, 07 Jan 2019 18:58:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D68081127491; Mon,  7 Jan 2019 18:58:31 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: max98090: remove unused constant variables" to the asoc tree
In-Reply-To:  <20190105020249.8639-3-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185831.D68081127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:31 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98090: remove unused constant variables

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

From 97d8f6b71f56865e52d472247fe728700ef7128d Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:30 -0600
Subject: [PATCH] ASoC: max98090: remove unused constant variables

Fix warnings with W=1

If these variables are useful then this driver should be modified to
expose them.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98090.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index c97f21836c66..30c242c38d99 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -314,9 +314,6 @@ static const DECLARE_TLV_DB_SCALE(max98090_av_tlv, -1200, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_dvg_tlv, 0, 600, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_dv_tlv, -1500, 100, 0);
 
-static const DECLARE_TLV_DB_SCALE(max98090_sidetone_tlv, -6050, 200, 0);
-
-static const DECLARE_TLV_DB_SCALE(max98090_alc_tlv, -1500, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_alcmakeup_tlv, 0, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_alccomp_tlv, -3100, 100, 0);
 static const DECLARE_TLV_DB_SCALE(max98090_drcexp_tlv, -6600, 100, 0);
@@ -817,18 +814,6 @@ static SOC_ENUM_SINGLE_VIRT_DECL(dmic_mux_enum, dmic_mux_text);
 static const struct snd_kcontrol_new max98090_dmic_mux =
 	SOC_DAPM_ENUM("DMIC Mux", dmic_mux_enum);
 
-static const char *max98090_micpre_text[] = { "Off", "On" };
-
-static SOC_ENUM_SINGLE_DECL(max98090_pa1en_enum,
-			    M98090_REG_MIC1_INPUT_LEVEL,
-			    M98090_MIC_PA1EN_SHIFT,
-			    max98090_micpre_text);
-
-static SOC_ENUM_SINGLE_DECL(max98090_pa2en_enum,
-			    M98090_REG_MIC2_INPUT_LEVEL,
-			    M98090_MIC_PA2EN_SHIFT,
-			    max98090_micpre_text);
-
 /* LINEA mixer switch */
 static const struct snd_kcontrol_new max98090_linea_mixer_controls[] = {
 	SOC_DAPM_SINGLE("IN1 Switch", M98090_REG_LINE_INPUT_CONFIG,
-- 
2.20.1

