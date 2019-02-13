Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0442C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDE0222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550058830;
	bh=/6Q7u9iZTNnjZqX+OeuxwSTh4pFcqmuZPn7ti/uDap4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dgicth5+zFsETBESfa0UwDi1OKHIwrTWhg/ONcYCTBWj6603CkwM4/qMAJ164rwLr
	 NTMZjH15/HjVH4oPOifk/AqncLqaAZd5X7pdTYklhn3EIh+g1+b5sC6QtEQMhRqc/H
	 W3XSm8Fls47097K5b2V4ZCKM0nfuB498dpf8iI4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391940AbfBMLxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:53:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49776 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391919AbfBMLxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=q+u/SWVyBPAxNz5MCCsxL5esEg5sHH7+4ZkIQ20U36A=; b=QYg5u0ms066E
        YsaapePizJsWYd5T9qVVO4z/B33+4d81kd9dbKiAm1WObMtURIWkZiUGODOKm5IdPMNHoWywCD4PC
        cew2MAsSeXqGDuHsCQH2UR4cr7C/IX0ZA0BwwtKkIABQUMO66fDHfkqCe84ZiQpzBcDCj1OtJDeDv
        gL5tc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtt6Y-00045f-4X; Wed, 13 Feb 2019 11:53:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9F9DE1128158; Wed, 13 Feb 2019 11:53:29 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, Liam@sirena.org.uk,
        Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav@sirena.org.uk, Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: cros_ec_codec: Make symbol 'cros_ec_dai' static" to the asoc tree
In-Reply-To:  <20190213062956.146536-1-weiyongjun1@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190213115329.9F9DE1128158@debutante.sirena.org.uk>
Date:   Wed, 13 Feb 2019 11:53:29 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cros_ec_codec: Make symbol 'cros_ec_dai' static

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

From a4cbb465bcc98f1c5740c887d4be3a68f1a47279 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Wed, 13 Feb 2019 06:29:56 +0000
Subject: [PATCH] ASoC: cros_ec_codec: Make symbol 'cros_ec_dai' static

Fixes the following sparse warning:

sound/soc/codecs/cros_ec_codec.c:209:27: warning:
 symbol 'cros_ec_dai' was not declared. Should it be static?

Fixes: b291f42a3718 ("ASoC: cros_ec_codec: Add codec driver for Cros EC")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cros_ec_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index b14100b6a939..99a3af8a15ff 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -206,7 +206,7 @@ static const struct snd_soc_dai_ops cros_ec_i2s_dai_ops = {
 	.set_fmt = cros_ec_i2s_set_dai_fmt,
 };
 
-struct snd_soc_dai_driver cros_ec_dai[] = {
+static struct snd_soc_dai_driver cros_ec_dai[] = {
 	{
 		.name = "cros_ec_codec I2S",
 		.id = 0,
-- 
2.20.1

