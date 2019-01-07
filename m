Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE56C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E802147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887717;
	bh=1e9hlTKLlvWNld7J8NLCagp0kxzl2IYicE24LzcKb3A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=K7+R2wl1XLW1iB7o/6UkEydS7mft4IX5jx2aiRh4xQe4Pl0P3Gbc5dq/dWC8X5cl5
	 4MpJh4g7o3/SZv0ZVgT3o0fY06vdkn6qLqH4nTvX8gkjHs9lpBSW38Xt+03ugN56iX
	 VzMEbOjz16X+Fp0teNniovOnN+nlz5lyDzLZUmjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfAGTB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:01:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40502 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfAGS6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ExSbMjyXOvkpN+sqJ2mk8nWQhe5iHuXQRC86J+bjjtk=; b=O+J8Pbebt1ec
        mrxLaTa4n8++XoJrKq5h42CLBId8U+BxfCmrcb5IQ1qeFNZ3h5Wqg5S11tPFTx+P/oFDPmhwrV2EQ
        yi5QyTJjb2eHm6pFU4t7K91F3Dfc1WtIyGLnyDUI8aOcOQDwzOm0y4oVd/SfLh932UKXyavVfqQZd
        l0ZWY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga64-0007ls-H4; Mon, 07 Jan 2019 18:58:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2D1431127491; Mon,  7 Jan 2019 18:58:00 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Bard liao <yung-chuan.liao@linux.intel.com>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Oder Chiou <oder_chiou@realtek.com>, tiwai@suse.de,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: rt5645: store eq kcontrol byte in __be" to the asoc tree
In-Reply-To:  <20190105020249.8639-21-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185800.2D1431127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:00 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5645: store eq kcontrol byte in __be

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

From 60b52ed627213d1782e70b9810f5668f61bba3a8 Mon Sep 17 00:00:00 2001
From: Bard liao <yung-chuan.liao@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:48 -0600
Subject: [PATCH] ASoC: rt5645: store eq kcontrol byte in __be

The eq parameters binary is stored in __be. However, it is unsigned short
in rt5645_eq_param_s{} which will cause incorrect type assignment. So add
struct rt5645_eq_param_s_be16{} to store the eq binary and convert it to
unsigned short in rt5645->eq_param.

Cc: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 52ce380c8f3a..9a0751978090 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -401,6 +401,11 @@ struct rt5645_eq_param_s {
 	unsigned short val;
 };
 
+struct rt5645_eq_param_s_be16 {
+	__be16 reg;
+	__be16 val;
+};
+
 static const char *const rt5645_supply_names[] = {
 	"avdd",
 	"cpvdd",
@@ -672,8 +677,8 @@ static int rt5645_hweq_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
-	struct rt5645_eq_param_s *eq_param =
-		(struct rt5645_eq_param_s *)ucontrol->value.bytes.data;
+	struct rt5645_eq_param_s_be16 *eq_param =
+		(struct rt5645_eq_param_s_be16 *)ucontrol->value.bytes.data;
 	int i;
 
 	for (i = 0; i < RT5645_HWEQ_NUM; i++) {
@@ -698,36 +703,33 @@ static int rt5645_hweq_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
-	struct rt5645_eq_param_s *eq_param =
-		(struct rt5645_eq_param_s *)ucontrol->value.bytes.data;
+	struct rt5645_eq_param_s_be16 *eq_param =
+		(struct rt5645_eq_param_s_be16 *)ucontrol->value.bytes.data;
 	int i;
 
 	for (i = 0; i < RT5645_HWEQ_NUM; i++) {
-		eq_param[i].reg = be16_to_cpu(eq_param[i].reg);
-		eq_param[i].val = be16_to_cpu(eq_param[i].val);
+		rt5645->eq_param[i].reg = be16_to_cpu(eq_param[i].reg);
+		rt5645->eq_param[i].val = be16_to_cpu(eq_param[i].val);
 	}
 
 	/* The final setting of the table should be RT5645_EQ_CTRL2 */
 	for (i = RT5645_HWEQ_NUM - 1; i >= 0; i--) {
-		if (eq_param[i].reg == 0)
+		if (rt5645->eq_param[i].reg == 0)
 			continue;
-		else if (eq_param[i].reg != RT5645_EQ_CTRL2)
+		else if (rt5645->eq_param[i].reg != RT5645_EQ_CTRL2)
 			return 0;
 		else
 			break;
 	}
 
 	for (i = 0; i < RT5645_HWEQ_NUM; i++) {
-		if (!rt5645_validate_hweq(eq_param[i].reg) &&
-			eq_param[i].reg != 0)
+		if (!rt5645_validate_hweq(rt5645->eq_param[i].reg) &&
+		    rt5645->eq_param[i].reg != 0)
 			return 0;
-		else if (eq_param[i].reg == 0)
+		else if (rt5645->eq_param[i].reg == 0)
 			break;
 	}
 
-	memcpy(rt5645->eq_param, eq_param,
-		RT5645_HWEQ_NUM * sizeof(struct rt5645_eq_param_s));
-
 	return 0;
 }
 
-- 
2.20.1

