Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29463C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE66320838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549981336;
	bh=PvmRm0rR9gogp7y5w6bG7aET8+GMqnvFb/mX4stMF7A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=k8OxR8enFy67VS/34VoGjFh4hM5fbnVXzfCqNqPFyldTGU6jkfdxcAnZGRjyEXK9e
	 sndRNQZg0dMtnVJgwetThZ2Qr8RcEuXFtouze69sa11UbG9wxmuBfazCiShFf5jqBW
	 ZH+RDEGaytkXpWP+DDNgxB0vKZmKtKMjQpLeRLGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfBLOWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:22:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55428 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfBLOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=c2IySaf1BhAIrpqbv/uwPEye7H2Cb1OEX4E3A9VRmN0=; b=mYUKej2XvrdS
        sfmgwqtvkrBD1ggp5VuhoencBn0pzwznk+1y1a3ysM9onWjhWwzQmNWeHb4GG4OfbPkxyIC52aEoP
        2PQjv0Y3aD6JbNwcnBYlGx0+tvAFp9iwwMlyhi75gKlV/BpHSaQWvjG33W85eRJCOg0NN7df/x8uk
        ppmac=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtYwk-0004bK-PL; Tue, 12 Feb 2019 14:22:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5F4AF1128113; Tue, 12 Feb 2019 14:22:02 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: pcm3060: Add clock select" to the asoc tree
In-Reply-To:  <20190211060839.21417-2-kmarinushkin@birdec.tech>
X-Patchwork-Hint: ignore
Message-Id: <20190212142202.5F4AF1128113@debutante.sirena.org.uk>
Date:   Tue, 12 Feb 2019 14:22:02 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: pcm3060: Add clock select

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

From 1e61405e201515d5767106babb4d750661ba5dcd Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Date: Mon, 11 Feb 2019 07:08:39 +0100
Subject: [PATCH] ASoC: pcm3060: Add clock select

ADC and DAC can be clocked from separate or same sources CLK1 and CLK2.
By default, ADC is clocked from CLK1, and DAC - from CLK2.

This commits allows sound cards to selest a proper clock source during
`hw_params()` via `snd_soc_dai_set_sysclk()`. It makes possible to have a
single clock source for both ADC and DAC.

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3060.c | 27 +++++++++++++++++++++++++++
 sound/soc/codecs/pcm3060.h |  5 +++++
 2 files changed, 32 insertions(+)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 543cb86fd764..32b26f1c2282 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -18,12 +18,39 @@ static int pcm3060_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 {
 	struct snd_soc_component *comp = dai->component;
 	struct pcm3060_priv *priv = snd_soc_component_get_drvdata(comp);
+	unsigned int reg;
+	unsigned int val;
 
 	if (dir != SND_SOC_CLOCK_IN) {
 		dev_err(comp->dev, "unsupported sysclock dir: %d\n", dir);
 		return -EINVAL;
 	}
 
+	switch (clk_id) {
+	case PCM3060_CLK_DEF:
+		val = 0;
+		break;
+
+	case PCM3060_CLK1:
+		val = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG_CSEL : 0);
+		break;
+
+	case PCM3060_CLK2:
+		val = (dai->id == PCM3060_DAI_ID_DAC ? 0 : PCM3060_REG_CSEL);
+		break;
+
+	default:
+		dev_err(comp->dev, "unsupported sysclock id: %d\n", clk_id);
+		return -EINVAL;
+	}
+
+	if (dai->id == PCM3060_DAI_ID_DAC)
+		reg = PCM3060_REG67;
+	else
+		reg = PCM3060_REG72;
+
+	regmap_update_bits(priv->regmap, reg, PCM3060_REG_CSEL, val);
+
 	priv->dai[dai->id].sclk_freq = freq;
 
 	return 0;
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index 6a027b4a845d..75931c9a9d85 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -17,6 +17,11 @@ extern const struct regmap_config pcm3060_regmap;
 #define PCM3060_DAI_ID_ADC	1
 #define PCM3060_DAI_IDS_NUM	2
 
+/* ADC and DAC can be clocked from separate or same sources CLK1 and CLK2 */
+#define PCM3060_CLK_DEF	0 /* default: CLK1->ADC, CLK2->DAC */
+#define PCM3060_CLK1		1
+#define PCM3060_CLK2		2
+
 struct pcm3060_priv_dai {
 	bool is_master;
 	unsigned int sclk_freq;
-- 
2.20.1

