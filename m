Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7A2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA6421738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547057734;
	bh=4Hy2TEKys1Z8ZZyVueZ7fWRdCkUq0jTZoo9GEBhhBxk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=QGPB0HMiYxpuXHD/1D6YTWIV+ecFscN0cjgV8vsOWTa1s9BQWC+tc90PFFXfo/kbO
	 yrhATBnoAjkL4Ym6gso15KmZPODEfJLLAgkQ1nsrz1wJY50sQDC6QbN/Ypc9gWOghb
	 uYD+h9wML489C+Dk57Cm7N5Wj3sl/7T9LG5Um13M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfAISPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:15:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32968 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfAISPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=W0HcHL8GkNvoGeOp2cMstDjgAoykMMiXd7oElG/n4YI=; b=NSNbh6qNOOdr
        b540GtSaaF8VQJyE1SFeMtaFFh0WNToUWDznSr+R8lqOS2x6eSHA9LD6k0E1p/3+CZKAA4J+/Ulc5
        5rxkB+muGtzt4TIgnIkNBfFmu6Jx6KMuLqGuCA3oTzSOIQN+8a0cJ0DhZ9RuLEnAaK/FbBScRw7hp
        cccYw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghINr-0000Zc-Dk; Wed, 09 Jan 2019 18:15:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0E7791127528; Wed,  9 Jan 2019 18:15:19 +0000 (GMT)
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
Subject: Applied "ASoC: da7219: MCLK should be enabled before DAI clocks" to the asoc tree
In-Reply-To:  <ac23ca274965f4c811c0bbbbfe953589a20610c2.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
X-Patchwork-Hint: ignore
Message-Id: <20190109181519.0E7791127528@debutante.sirena.org.uk>
Date:   Wed,  9 Jan 2019 18:15:19 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: da7219: MCLK should be enabled before DAI clocks

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

From a6028cc60aad18d5d7c25d99b5cb8c24399387c3 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Mon, 7 Jan 2019 16:11:46 +0000
Subject: [PATCH] ASoC: da7219: MCLK should be enabled before DAI clocks

For platforms using the Common Clock Framework to control the
codec's DAI clocks, MCLK should be enabled prior to DAI clocks
being turned on. For some platforms the codec is already
provided with an MCLK reference and can therefore control MCLK
itself as it needs to.

To improve functionality MCLK is now added as a parent to the
DAI clocks, if MCLK was provided, so that if they are enabled MCLK
will automatically be enabled as a prerequisite by the CCF.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 513ec0368653..a20a610c7ee5 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1804,7 +1804,7 @@ static const struct clk_ops da7219_dai_clks_ops = {
 	.is_prepared = da7219_dai_clks_is_prepared,
 };
 
-static void da7219_register_dai_clks(struct snd_soc_component *component)
+static int da7219_register_dai_clks(struct snd_soc_component *component)
 {
 	struct device *dev = component->dev;
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
@@ -1812,9 +1812,17 @@ static void da7219_register_dai_clks(struct snd_soc_component *component)
 	struct clk_init_data init = {};
 	struct clk *dai_clks;
 	struct clk_lookup *dai_clks_lookup;
+	const char *parent_name;
+
+	if (da7219->mclk) {
+		parent_name = __clk_get_name(da7219->mclk);
+		init.parent_names = &parent_name;
+		init.num_parents = 1;
+	} else {
+		init.parent_names = NULL;
+		init.num_parents = 0;
+	}
 
-	init.parent_names = NULL;
-	init.num_parents = 0;
 	init.name = pdata->dai_clks_name;
 	init.ops = &da7219_dai_clks_ops;
 	da7219->dai_clks_hw.init = &init;
@@ -1823,7 +1831,7 @@ static void da7219_register_dai_clks(struct snd_soc_component *component)
 	if (IS_ERR(dai_clks)) {
 		dev_warn(dev, "Failed to register DAI clocks: %ld\n",
 			 PTR_ERR(dai_clks));
-		return;
+		return PTR_ERR(dai_clks);
 	}
 	da7219->dai_clks = dai_clks;
 
@@ -1835,13 +1843,18 @@ static void da7219_register_dai_clks(struct snd_soc_component *component)
 		dai_clks_lookup = clkdev_create(dai_clks, pdata->dai_clks_name,
 						"%s", dev_name(dev));
 		if (!dai_clks_lookup)
-			dev_warn(dev, "Failed to create DAI clkdev");
+			return -ENOMEM;
 		else
 			da7219->dai_clks_lookup = dai_clks_lookup;
 	}
+
+	return 0;
 }
 #else
-static inline void da7219_register_dai_clks(struct snd_soc_component *component) {}
+static inline int da7219_register_dai_clks(struct snd_soc_component *component)
+{
+	return 0;
+}
 #endif /* CONFIG_COMMON_CLK */
 
 static void da7219_handle_pdata(struct snd_soc_component *component)
@@ -1854,8 +1867,6 @@ static void da7219_handle_pdata(struct snd_soc_component *component)
 
 		da7219->wakeup_source = pdata->wakeup_source;
 
-		da7219_register_dai_clks(component);
-
 		/* Mic Bias voltages */
 		switch (pdata->micbias_lvl) {
 		case DA7219_MICBIAS_1_6V:
@@ -1947,6 +1958,11 @@ static int da7219_probe(struct snd_soc_component *component)
 		}
 	}
 
+	/* Register CCF DAI clock control */
+	ret = da7219_register_dai_clks(component);
+	if (ret)
+		return ret;
+
 	/* Default PC counter to free-running */
 	snd_soc_component_update_bits(component, DA7219_PC_COUNT, DA7219_PC_FREERUN_MASK,
 			    DA7219_PC_FREERUN_MASK);
-- 
2.20.1

