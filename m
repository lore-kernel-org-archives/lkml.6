Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C88C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B14C2173A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="L7Z1/FpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B14C2173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbeHNRMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:12:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42304 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeHNRMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=iedwjAgb4nUZB/LSkdK3adN6MPELQQaorrJGa8TDwTc=; b=L7Z1/FpFxI9p
        Ab6v4BrGVUAKwm/OfVHHDyyznpgV3XNqH8XsOvqductyFpvtW0xroUAfWXk5NG9p17zwgZ+UYHp8p
        RwhEMlpWHJF6rs4KkbOamSfoGRffy2+/UHp76nri5+VlSq0OOQ00NnT+LBw5LaAm+cv0L1wAj5rdq
        toRao=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fpaG8-0000sa-1B; Tue, 14 Aug 2018 14:25:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BB8D41124449; Tue, 14 Aug 2018 15:25:19 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: wm9712: fix replace codec to component" to the asoc tree
In-Reply-To:  <20180813223556.16262-1-marcel@ziswiler.com>
Message-Id: <20180814142519.BB8D41124449@debutante.sirena.org.uk>
Date:   Tue, 14 Aug 2018 15:25:19 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm9712: fix replace codec to component

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

From 5e4cfadaf5b73a0801b2fa7fb007f98400ebfe6e Mon Sep 17 00:00:00 2001
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Date: Tue, 14 Aug 2018 00:35:56 +0200
Subject: [PATCH] ASoC: wm9712: fix replace codec to component

Since commit 143b44845d87 ("ASoC: wm9712: replace codec to component")
"wm9712-codec" got renamed to "wm9712-component", however, this change
never got propagated down to the actual board/platform drivers. E.g. on
Colibri T20 this lead to the following spew upon boot with sound/touch
being broken:

[    2.214121] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.222137] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    2.344384] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.351885] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    2.668339] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    2.675811] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    3.208408] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    3.216312] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[    3.235397] tegra-snd-wm9712 sound: ASoC: CODEC DAI wm9712-hifi not registered
[    3.248938] tegra-snd-wm9712 sound: snd_soc_register_card failed (-517)
...
[   14.970443] ALSA device list:
[   14.996628]   No soundcards found.

This commit finally fixes this again.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/wm9712.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 953d94d50586..ade34c26ad2f 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -719,7 +719,7 @@ static int wm9712_probe(struct platform_device *pdev)
 
 static struct platform_driver wm9712_component_driver = {
 	.driver = {
-		.name = "wm9712-component",
+		.name = "wm9712-codec",
 	},
 
 	.probe = wm9712_probe,
-- 
2.18.0

