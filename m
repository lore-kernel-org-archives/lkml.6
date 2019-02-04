Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42FBC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E842175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549297043;
	bh=4KWDdYuHksCulnUON8pASo9PIj2XNr1zMyD10xXUoXc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=N3ahyx60B+OfeI9qSe3csDHp8D9yTKcw3HWbrLmCX9X8MP7BItVTeySrtEq90JppI
	 MUveKj4oeoqLwi6qKgswEIXZSQi57iEUfx5+4DJDR7jxHZrYNNo2tHLGr2P9v2nCBw
	 irYdiOSRoeCa0DVeS7IJ0D4Qwj3mekMAXoTNm0vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfBDQRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:17:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55572 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfBDQRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=w7CTFj1lJXx1I80TUZBaOKsdD+0QvpOevpJFiOZ9k0M=; b=cL50nUcgfCMV
        v6spnEiD3KZI96FxFx8RbHYvg/eqoQM1vI+DEVmLrllCqaGFuywy9gExFhRAizqVuvk8IYmSMuBQm
        xI5r9ERnxXCQyFBVOXQNZQnwGxDL7isDjcjJtxM4DllBtvPeUCqmqXjP4caqncLFAGwQXgIstuzpL
        SC4l0=;
Received: from 53.97-247-81.adsl-dyn.isp.belgacom.be ([81.247.97.53] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gqgvi-0004lJ-A4; Mon, 04 Feb 2019 16:17:06 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 9E221440083; Mon,  4 Feb 2019 16:17:05 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: mediatek: btcvsd: fix spelling mistake "offest" -> "offset"" to the asoc tree
In-Reply-To:  <20190204153105.20214-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190204161705.9E221440083@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Feb 2019 16:17:05 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: btcvsd: fix spelling mistake "offest" -> "offset"

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

From 766cc4965a3a2a8a62e70e9d98e1d946a71368d5 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 4 Feb 2019 15:31:05 +0000
Subject: [PATCH] ASoC: mediatek: btcvsd: fix spelling mistake "offest" ->
 "offset"

There is a spelling mistake in a dev_warn message. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/common/mtk-btcvsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index 349a9120a0dd..e408c1b270ab 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -1309,7 +1309,7 @@ static int mtk_btcvsd_snd_probe(struct platform_device *pdev)
 					 offset,
 					 ARRAY_SIZE(offset));
 	if (ret) {
-		dev_warn(dev, "%s(), get offest fail, ret %d\n", __func__, ret);
+		dev_warn(dev, "%s(), get offset fail, ret %d\n", __func__, ret);
 		return ret;
 	}
 	btcvsd->infra_misc_offset = offset[0];
-- 
2.20.1

