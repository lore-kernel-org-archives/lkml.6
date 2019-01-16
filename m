Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422E5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2D920873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547662022;
	bh=jo53Mup14T/v/AZoCNwxMsMz0yMW181Zf8oCCuRWX64=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=sAZyLgAgoNRv1CJx+s8Z+sg5ELTnuE8CB4/k+Aj7Q5seWHNBhDX4LkZ42o6QJYjVC
	 5oo48IeeRPoBKSYkPXR8yTf7rXYnK5T6JalHu9S1iB+07r7rkHP6qW8fbhBKlBIbCz
	 dclGNwXKhkeuW5DJa0tEPpqAP7vQO9SWfndUlhYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfAPSHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:07:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55366 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbfAPSG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=oGstHByNYvXdISvva2ed34wo98vsqou08mH4dzCEedQ=; b=eG+bOlUH+mD/
        l60aihAVHrz3fp/vx5wVX5FqrjW0qjNEjkxW6AlzmwYsIOdvsu2fxhxPblrd9/KtZeNPyBtUczyM6
        caAPJ3h+vhslpZRRXjlCMnVI1HPevyiUbE+uMm8S7/pXX731f/89fZs+HlOFppBjgDSWKnStfOIb4
        SkgJs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjpaX-0002SR-VP; Wed, 16 Jan 2019 18:06:54 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 563621126FFD; Wed, 16 Jan 2019 18:06:53 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, tzungbi@chromium.org,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: sdm845: Set DAI format for dmic codec" to the asoc tree
In-Reply-To:  <20190115084159.135113-1-cychiang@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20190116180653.563621126FFD@debutante.sirena.org.uk>
Date:   Wed, 16 Jan 2019 18:06:53 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sdm845: Set DAI format for dmic codec

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

From 9019ab102fe8d741f873e6f630fb7aa74c38818a Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Tue, 15 Jan 2019 16:41:59 +0800
Subject: [PATCH] ASoC: sdm845: Set DAI format for dmic codec

Set codec DAI format for dmic codec in startup.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 6f66a58e23ca..882f52ed8231 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -248,12 +248,14 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 		break;
 
 	case SECONDARY_MI2S_TX:
+		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S;
 		if (++(data->sec_mi2s_clk_count) == 1) {
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT,
 				MI2S_BCLK_RATE,	SNDRV_PCM_STREAM_CAPTURE);
 		}
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
 		break;
 
 	case QUATERNARY_TDM_RX_0:
-- 
2.20.1

