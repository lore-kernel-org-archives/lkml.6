Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D70C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6360217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550515803;
	bh=2HauBEx2Qdtv8fyMr8OsRdvr2yGmnKnwWBHSpy8oAiY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bKW3FmpWgUrLiHbfYAnYGKU0jQuVjcVDV4BAKwOZz3viyukPcbDQt3f52RHz7CxgP
	 xw6At/GN3ozVePE8a8EG/YksA+BWZYrDnVWmjW5BKT/WzhBpnRnx4l6V8k+myNmuL/
	 LhkOd4en7CbAYtIxRF/0QKNxddm2FtLgR41hPQRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfBRSuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:50:02 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42372 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfBRSty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hgkkgjXd7cfvUAFliA6I4VRanwFsbcmTtS8eFelkOsA=; b=rCEepe5glGpU
        Tq9oUpRttY23Mk5t8iVnc1VIQ6CaAFJhl24is4hR1oXS1+g7fBTTqi+6zZlBuYXt0MaEokJg5PXgP
        M9QZ8oRv/DEXbBFL1pUxf6GMLWyv9i0450jryam1R0Sl80cSE36B2qM/JgKn8BdpY0YAXooXhkq9k
        ZKRVU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gvnz0-0001fA-4y; Mon, 18 Feb 2019 18:49:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 98EA21128008; Mon, 18 Feb 2019 18:49:37 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, Codrin.Ciubotariu@microchip.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: codecs: ad193x: Set constraint to always have 32 sample bits" to the asoc tree
In-Reply-To:  <20190218160954.13929-3-codrin.ciubotariu@microchip.com>
X-Patchwork-Hint: ignore
Message-Id: <20190218184937.98EA21128008@debutante.sirena.org.uk>
Date:   Mon, 18 Feb 2019 18:49:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: ad193x: Set constraint to always have 32 sample bits

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

From 75c2ecb4bda296f89d4ea6a42750f48bfcd8a1d9 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Mon, 18 Feb 2019 16:10:30 +0000
Subject: [PATCH] ASoC: codecs: ad193x: Set constraint to always have 32 sample
 bits

DACs and ADCs on ad193x codecs require a 32 bit slot size. We should
assure that no other size is used.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 21a38cc9e3da..c16c9969d1a0 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -37,6 +37,13 @@ static SOC_ENUM_SINGLE_DECL(ad193x_deemp_enum, AD193X_DAC_CTRL2, 1,
 
 static const DECLARE_TLV_DB_MINMAX(adau193x_tlv, -9563, 0);
 
+static const unsigned int ad193x_sb[] = {32};
+
+static struct snd_pcm_hw_constraint_list constr = {
+	.list = ad193x_sb,
+	.count = ARRAY_SIZE(ad193x_sb),
+};
+
 static const struct snd_kcontrol_new ad193x_snd_controls[] = {
 	/* DAC volume control */
 	SOC_DOUBLE_R_TLV("DAC1 Volume", AD193X_DAC_L1_VOL,
@@ -321,7 +328,16 @@ static int ad193x_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int ad193x_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+				   &constr);
+}
+
 static const struct snd_soc_dai_ops ad193x_dai_ops = {
+	.startup = ad193x_startup,
 	.hw_params = ad193x_hw_params,
 	.digital_mute = ad193x_mute,
 	.set_tdm_slot = ad193x_set_tdm_slot,
-- 
2.20.1

