Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982CCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6902146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550685174;
	bh=2Mtxk6twNL6LqiqATd54JIIoCUMky9uq8E6tSELsE58=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=sE/rAzWsGAoC58HeRHJHRAWJXzmqK80SNuluXgaIBKudrB7HnnxgYFjyA6SS8qej1
	 rkvzB46r+zQbHF5ZNF/GkuOuG2sfIOItRZM2RYhwBuLvCgV0HSVFaJzp6wLNnwThrY
	 OFglghKjlV7OWW1jmbFRnhrhcGTTJQYY0OCPHiFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfBTRwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:52:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55564 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfBTRww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=jC3W3UTsefz5QzOBezUZzeX9PIEHZrPF8oV9yNTGOJA=; b=W7ZbVh5wgugx
        fYENA0hJtzKnSf+/UMTAmXbNoJvSc5EZD2+0Qrsz8kgdteQlAcDOHzvJMD+q+7+/62dRAH8MeSLhW
        ZXjH0xKMFyDOkjrP66BHwUgk6lNfB0uzhcQjSpqztZtVRg1tUfK2Dn1Ph+osSizrK2R/1Z/uA7bMM
        LbhjA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwW35-0005SF-3t; Wed, 20 Feb 2019 17:52:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AB72A112882C; Wed, 20 Feb 2019 17:52:46 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, tiwai@suse.de,
        linux-kernel@vger.kernel.org, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: odroid: Fix of_node refcount unbalance" to the asoc tree
In-Reply-To:  <20190220110607.13293-1-s.nawrocki@samsung.com>
X-Patchwork-Hint: ignore
Message-Id: <20190220175246.AB72A112882C@debutante.sirena.org.uk>
Date:   Wed, 20 Feb 2019 17:52:46 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: odroid: Fix of_node refcount unbalance

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

From d832d2b246c516eacb2d0ba53ec17ed59c3cd62b Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Wed, 20 Feb 2019 12:06:07 +0100
Subject: [PATCH] ASoC: samsung: odroid: Fix of_node refcount unbalance

In odroid_audio_probe() some OF nodes are left without reference count
decrease after use. Fix it by ensuring required of_node_calls() are done
before exiting probe.

Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/odroid.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index bd2c5163dc7f..c3b0f6c612cb 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -257,27 +257,31 @@ static int odroid_audio_probe(struct platform_device *pdev)
 		ret = of_parse_phandle_with_args(cpu, "sound-dai",
 						 "#sound-dai-cells", i, &args);
 		if (ret < 0)
-			return ret;
+			break;
 
 		if (!args.np) {
 			dev_err(dev, "sound-dai property parse error: %d\n", ret);
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
 
 		ret = snd_soc_get_dai_name(&args, &link->cpu_dai_name);
 		of_node_put(args.np);
 
 		if (ret < 0)
-			return ret;
+			break;
 	}
+	if (ret == 0)
+		cpu_dai = of_parse_phandle(cpu, "sound-dai", 0);
 
-	cpu_dai = of_parse_phandle(cpu, "sound-dai", 0);
 	of_node_put(cpu);
 	of_node_put(codec);
+	if (ret < 0)
+		return ret;
 
 	ret = snd_soc_of_get_dai_link_codecs(dev, codec, codec_link);
 	if (ret < 0)
-		goto err_put_codec_n;
+		goto err_put_cpu_dai;
 
 	/* Set capture capability only for boards with the MAX98090 CODEC */
 	if (codec_link->num_codecs > 1) {
@@ -288,7 +292,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	priv->sclk_i2s = of_clk_get_by_name(cpu_dai, "i2s_opclk1");
 	if (IS_ERR(priv->sclk_i2s)) {
 		ret = PTR_ERR(priv->sclk_i2s);
-		goto err_put_codec_n;
+		goto err_put_cpu_dai;
 	}
 
 	priv->clk_i2s_bus = of_clk_get_by_name(cpu_dai, "iis");
@@ -310,7 +314,8 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	clk_put(priv->clk_i2s_bus);
 err_put_sclk:
 	clk_put(priv->sclk_i2s);
-err_put_codec_n:
+err_put_cpu_dai:
+	of_node_put(cpu_dai);
 	snd_soc_of_put_dai_link_codecs(codec_link);
 	return ret;
 }
-- 
2.20.1

