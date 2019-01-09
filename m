Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D959DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4D521773
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547057738;
	bh=6mtylfYi0nL7JfMTusPbAvjEpAFNkmI2/TVwbnNSykM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ilPx+kQS1I0fx3cVT3Y+YyY9SmVKBLVoEjquWZMvQJo+oleAToj91uJODSHwzM+lw
	 2o87UkmMo/lIwq5UFvEgdR/dwu2FvO08e8baRNYihh3pwhdGV0J4+RiAKHNevYCFmZ
	 I6xQraanqrq01bTpSF1OuU6dlsZq2J/2Ht9mk/PU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfAISPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:15:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32910 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfAISP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xATHhQDh7dQc9jkNTvDIHoCdDPTo85TUHQBqjMJubus=; b=tucEozyab62L
        temBgel5hTxwVw4NQ8Gj+VWmKIEAx0PocCs/+6+YGDnm72YDviycp1CcU1ZCr4W2KCvkV5FfnTcKK
        mS5IBNX/w3hJTac5a03r9tEzoWuIOLhPRIV9q/xDQpEdKlGog0UAPPAn8vC6fe03we1hHnGJPEVRv
        th1C0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghINp-0000ZZ-Ps; Wed, 09 Jan 2019 18:15:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 343F61127528; Wed,  9 Jan 2019 18:15:17 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Daniel Kurtz <djkurtz@google.com>,
        linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: da7219: Add recalc_rate function to return DAI clock rate" to the asoc tree
In-Reply-To:  <ef671ed1c4a5b86036da5b2adf5be7d79ec56c7d.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
X-Patchwork-Hint: ignore
Message-Id: <20190109181517.343F61127528@debutante.sirena.org.uk>
Date:   Wed,  9 Jan 2019 18:15:17 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: da7219: Add recalc_rate function to return DAI clock rate

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

From a58943abcb08cfbe6c36648602d796c5834ee8a9 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 8 Jan 2019 09:13:28 +0000
Subject: [PATCH] ASoC: da7219: Add recalc_rate function to return DAI clock
 rate

By making MCLK parent of DAI clocks, when querying the rate of the
clock the rate returned is now given from the parent clock so
gives the MCLK rate rather than 0 as previously returned. This is
a bit misleading, and actually there's no major reason why we can't
at least return the DAI WCLK rate, as set in HW, so that's what we
now do.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 45 ++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/da7219.h |  1 +
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index a20a610c7ee5..b1df4bb36105 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1767,7 +1767,7 @@ static int da7219_dai_clks_prepare(struct clk_hw *hw)
 {
 	struct da7219_priv *da7219 =
 		container_of(hw, struct da7219_priv, dai_clks_hw);
-	struct snd_soc_component *component = da7219->aad->component;
+	struct snd_soc_component *component = da7219->component;
 
 	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
 				      DA7219_DAI_CLK_EN_MASK,
@@ -1780,7 +1780,7 @@ static void da7219_dai_clks_unprepare(struct clk_hw *hw)
 {
 	struct da7219_priv *da7219 =
 		container_of(hw, struct da7219_priv, dai_clks_hw);
-	struct snd_soc_component *component = da7219->aad->component;
+	struct snd_soc_component *component = da7219->component;
 
 	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
 				      DA7219_DAI_CLK_EN_MASK, 0);
@@ -1790,7 +1790,7 @@ static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
 {
 	struct da7219_priv *da7219 =
 		container_of(hw, struct da7219_priv, dai_clks_hw);
-	struct snd_soc_component *component = da7219->aad->component;
+	struct snd_soc_component *component = da7219->component;
 	u8 clk_reg;
 
 	clk_reg = snd_soc_component_read32(component, DA7219_DAI_CLK_MODE);
@@ -1798,10 +1798,47 @@ static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
 	return !!(clk_reg & DA7219_DAI_CLK_EN_MASK);
 }
 
+static unsigned long da7219_dai_clks_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct da7219_priv *da7219 =
+		container_of(hw, struct da7219_priv, dai_clks_hw);
+	struct snd_soc_component *component = da7219->component;
+	u8 fs = snd_soc_component_read32(component, DA7219_SR);
+
+	switch (fs & DA7219_SR_MASK) {
+	case DA7219_SR_8000:
+		return 8000;
+	case DA7219_SR_11025:
+		return 11025;
+	case DA7219_SR_12000:
+		return 12000;
+	case DA7219_SR_16000:
+		return 16000;
+	case DA7219_SR_22050:
+		return 22050;
+	case DA7219_SR_24000:
+		return 24000;
+	case DA7219_SR_32000:
+		return 32000;
+	case DA7219_SR_44100:
+		return 44100;
+	case DA7219_SR_48000:
+		return 48000;
+	case DA7219_SR_88200:
+		return 88200;
+	case DA7219_SR_96000:
+		return 96000;
+	default:
+		return 0;
+	}
+}
+
 static const struct clk_ops da7219_dai_clks_ops = {
 	.prepare = da7219_dai_clks_prepare,
 	.unprepare = da7219_dai_clks_unprepare,
 	.is_prepared = da7219_dai_clks_is_prepared,
+	.recalc_rate = da7219_dai_clks_recalc_rate,
 };
 
 static int da7219_register_dai_clks(struct snd_soc_component *component)
@@ -1825,6 +1862,7 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
 
 	init.name = pdata->dai_clks_name;
 	init.ops = &da7219_dai_clks_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
 	da7219->dai_clks_hw.init = &init;
 
 	dai_clks = devm_clk_register(dev, &da7219->dai_clks_hw);
@@ -1912,6 +1950,7 @@ static int da7219_probe(struct snd_soc_component *component)
 	unsigned int rev;
 	int ret;
 
+	da7219->component = component;
 	mutex_init(&da7219->ctrl_lock);
 	mutex_init(&da7219->pll_lock);
 
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 3a006862f0e7..366cf46118a0 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -809,6 +809,7 @@ struct da7219_aad_priv;
 
 /* Private data */
 struct da7219_priv {
+	struct snd_soc_component *component;
 	struct da7219_aad_priv *aad;
 	struct da7219_pdata *pdata;
 
-- 
2.20.1

