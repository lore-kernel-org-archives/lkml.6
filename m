Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E02C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C994D222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550058857;
	bh=AFIvG1cSwnU1Vavxf7XtIZZO6q985eqlpE3+uHjcip8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yP2X+PyOhGhgKlV1bPAUgXqenMHXeATqTpRX1csvR5WT7fjuOriB3mn5WT/1+yb5L
	 L3Q6/KAEtl4PNw8GhpkQJ4Y3gkjoHYCCA6ZFxQiM4crwosAWi3YUYMAs6AX0Xj/Qys
	 dEY7PjqOQxoCCfIOk8VVPH6KccEB00MmXJ9dkbLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392013AbfBMLyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:54:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49920 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391919AbfBMLxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=d+AWqIkDQ/XvBMZHmAJg9wE4iJMxTjOVhinS59xMf34=; b=UAY+5jTmb+t9
        PVEHcIz//0dVX5rteIsqMgbg6TDh357OaQGvBIJ1vrC45mEnMCaq3Cv3qa2A9Cqd9tT7CBGUiqx1a
        19whcWM8kQhAra67VogjLlvYi4HuKeSaYVzeXkNf8gmCPxO7b0DLRXTX0ntftdH/60LMwmwKV8g5n
        IJcqM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtt6a-00045k-6O; Wed, 13 Feb 2019 11:53:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C15821128158; Wed, 13 Feb 2019 11:53:31 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Matthias@sirena.org.uk,
        Brugger <matthias.bgg@gmail.com>,
        Shunli Wang <shunli.wang@mediatek.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: mediatek: mt8183: make some functions static" to the asoc tree
In-Reply-To:  <20190213062944.146366-1-weiyongjun1@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190213115331.C15821128158@debutante.sirena.org.uk>
Date:   Wed, 13 Feb 2019 11:53:31 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: mt8183: make some functions static

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

From 03bf3aeb03a8562a7ad6ed629e49953f132217c1 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Wed, 13 Feb 2019 06:29:44 +0000
Subject: [PATCH] ASoC: mediatek: mt8183: make some functions static

Fixes the following sparse warnings:

sound/soc/mediatek/mt8183/mt8183-dai-i2s.c:966:5: warning:
 symbol 'mt8183_dai_i2s_get_share' was not declared. Should it be static?
sound/soc/mediatek/mt8183/mt8183-dai-i2s.c:986:5: warning:
 symbol 'mt8183_dai_i2s_set_priv' was not declared. Should it be static?

Fixes: a94aec035a12 ("ASoC: mediatek: mt8183: add platform driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
index c25024f72e72..777e93d70bea 100644
--- a/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
+++ b/sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
@@ -963,7 +963,7 @@ static const struct mtk_afe_i2s_priv mt8183_i2s_priv[DAI_I2S_NUM] = {
 	},
 };
 
-int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
+static int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
 {
 	struct mt8183_afe_private *afe_priv = afe->platform_priv;
 	const struct device_node *of_node = afe->dev->of_node;
@@ -983,7 +983,7 @@ int mt8183_dai_i2s_get_share(struct mtk_base_afe *afe)
 	return 0;
 }
 
-int mt8183_dai_i2s_set_priv(struct mtk_base_afe *afe)
+static int mt8183_dai_i2s_set_priv(struct mtk_base_afe *afe)
 {
 	struct mt8183_afe_private *afe_priv = afe->platform_priv;
 	struct mtk_afe_i2s_priv *i2s_priv;
-- 
2.20.1

