Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCF0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCBE20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550749332;
	bh=Olfw7Nkn2b9NBy2lofnrqLbFRTLlBCygaRwl+p7nkwA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=q91MA3MwEcGJKV1GjQ8PysntzCrilXmxcmn4HoU7LUk5cvv9omh+eIuuM5ZzYebxe
	 VUe0geM9oZh3aEbDV3/VfQRq71EDdbYAWTMkDB6ikRf2F9MrX1mlnRIesT4eR/zfMC
	 CVKDsgUxikfANIGnII9yYoQ9Gj+bXywkjmiQS0PY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfBULmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:42:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43180 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBULmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=CVR+iBJbpbn4OqW3QW6dXr8iS9BsDIAhONp1g576iQA=; b=L36gue+17t9h
        k2LlD1G37HyoSVdCRs3sSSNNCKkFzCiHFDZf3JwxQb5QB1Ju4fidhpLQ6RMLXd/RYFcs8KsgNrLJG
        ZsPouhj6VDlnvYIKc81g3IitUmWTlGKHjKpKbB6bou+36ug/Mgxgziq+NAF2xEp6wNFQDSvakDDEq
        a2yAM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwmjs-00039a-Um; Thu, 21 Feb 2019 11:42:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 61F641122744; Thu, 21 Feb 2019 11:42:04 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-samsung-soc@vger.kernel.org, sbkim73@samsung.com,
        linux-kernel@vger.kernel.org, krzk@kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: odroid: Prevent uninitialized variable use" to the asoc tree
In-Reply-To:  <20190221094228.3778-1-s.nawrocki@samsung.com>
X-Patchwork-Hint: ignore
Message-Id: <20190221114204.61F641122744@debutante.sirena.org.uk>
Date:   Thu, 21 Feb 2019 11:42:04 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: odroid: Prevent uninitialized variable use

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

From 3af8160028bfac4116d80edcb7eb04095323d112 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 21 Feb 2019 10:42:28 +0100
Subject: [PATCH] ASoC: samsung: odroid: Prevent uninitialized variable use
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This addresses an issue pointed out by compiler warning:

sound/soc/samsung/odroid.c: In function ‘odroid_audio_probe’:
sound/soc/samsung/odroid.c:298:22: warning: ‘cpu_dai’ may be used
uninitialized in this function [-Wmaybe-uninitialized]
  priv->clk_i2s_bus = of_clk_get_by_name(cpu_dai, "iis");
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/odroid.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index c3b0f6c612cb..694512f980fd 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -194,7 +194,8 @@ static struct snd_soc_dai_link odroid_card_dais[] = {
 static int odroid_audio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *cpu, *cpu_dai, *codec;
+	struct device_node *cpu_dai = NULL;
+	struct device_node *cpu, *codec;
 	struct odroid_priv *priv;
 	struct snd_soc_card *card;
 	struct snd_soc_dai_link *link, *codec_link;
@@ -271,8 +272,11 @@ static int odroid_audio_probe(struct platform_device *pdev)
 		if (ret < 0)
 			break;
 	}
-	if (ret == 0)
+	if (ret == 0) {
 		cpu_dai = of_parse_phandle(cpu, "sound-dai", 0);
+		if (!cpu_dai)
+			ret = -EINVAL;
+	}
 
 	of_node_put(cpu);
 	of_node_put(codec);
-- 
2.20.1

