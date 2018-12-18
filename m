Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD0AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA346218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545147048;
	bh=d6j2qgSUmoIOC1Dl9nzFVV7FW+93BTWHNacnJaOMTmQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=lOg1uxyI87gVfPwkULg4OFas6GqorfoPjOCr65lWujjay3OxYZkyMm/My9hPh8gWG
	 gbwFUfCK809Bni91QU8zIXm7ABVIA3uZz7h0tJnOQ05i+9Kv2Rl3czgo5OfRzLdFZd
	 ShT3BSLDRwLWlNwafHYLHSZ/C4J5oknn6V4EWMVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeLRPar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:30:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47078 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeLRPar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RvNXk5145uv/kzsKFqqWbxqBNcWAPQ28q7zBEtuUJDE=; b=gsUcMenkxSVy
        qfaHsq5f6zZt4fChJVlLOjMR+6uGa57egfebqHob6UaH/BU7gv96jpeBlD6I5qdqRzSBFmWIyW2xf
        gLwgIcWtmVg7y5h+ANTLEi8d1W5ztUFLUOaEeX/ky4eg92vX3oze4MIT7Y9nBzdjmDq+isUWFEEfr
        1jsjc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gZHKK-0007Gt-Vx; Tue, 18 Dec 2018 15:30:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AA3191125500; Tue, 18 Dec 2018 15:30:32 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, asishb@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: sdm845: set jack only for a specific backend" to the asoc tree
In-Reply-To:  <1544781703-9585-1-git-send-email-rohitkr@codeaurora.org>
X-Patchwork-Hint: ignore
Message-Id: <20181218153032.AA3191125500@debutante.sirena.org.uk>
Date:   Tue, 18 Dec 2018 15:30:32 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sdm845: set jack only for a specific backend

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

From d62805014ee8632e117fd061c18ff15ba90b9f61 Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Fri, 14 Dec 2018 15:31:43 +0530
Subject: [PATCH] ASoC: sdm845: set jack only for a specific backend

Headset codec is connected over PRIMARY_MI2S interface. Call
set_jack for codec associated with Primary Mi2s interface.
Also, set_jack to NULL when jack is freed.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 1db8ef668223..6f66a58e23ca 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -158,17 +158,24 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static void sdm845_jack_free(struct snd_jack *jack)
+{
+	struct snd_soc_component *component = jack->private_data;
+
+	snd_soc_component_set_jack(component, NULL, NULL);
+}
+
 static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *component;
-	struct snd_soc_dai_link *dai_link = rtd->dai_link;
 	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(card);
-	int i, rval;
+	struct snd_jack *jack;
+	int rval;
 
 	if (!pdata->jack_setup) {
-		struct snd_jack *jack;
-
 		rval = snd_soc_card_jack_new(card, "Headset Jack",
 				SND_JACK_HEADSET |
 				SND_JACK_HEADPHONE |
@@ -190,16 +197,22 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 		pdata->jack_setup = true;
 	}
 
-	for (i = 0 ; i < dai_link->num_codecs; i++) {
-		struct snd_soc_dai *dai = rtd->codec_dais[i];
+	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX:
+		jack  = pdata->jack.jack;
+		component = codec_dai->component;
 
-		component = dai->component;
-		rval = snd_soc_component_set_jack(
-				component, &pdata->jack, NULL);
+		jack->private_data = component;
+		jack->private_free = sdm845_jack_free;
+		rval = snd_soc_component_set_jack(component,
+						  &pdata->jack, NULL);
 		if (rval != 0 && rval != -ENOTSUPP) {
 			dev_warn(card->dev, "Failed to set jack: %d\n", rval);
 			return rval;
 		}
+		break;
+	default:
+		break;
 	}
 
 	return 0;
-- 
2.19.0.rc2

