Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF94EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653AF216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="UF/r20Fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653AF216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeI1FAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:00:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54968 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeI1FAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=91PXV22JAQEkvDM3HYpdadO54RDQTnjpVLBYUPH+4f0=; b=UF/r20Fddcau
        ZrPl2as9e0n4sbM9u4iLxoEgRW1LpJHmApSor76fnk3JoVnbIrdLAl8OooDhoNvhCn4GJ1QuXyk89
        YoA4op3r4BEv4yP8SxQhf1yEXHmWlbCt+uDdECQL4x5Ua/EzULALnU1FFi2jRB/3y+d70WtMij6LJ
        u+/kI=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5ewS-0007Sy-S6; Thu, 27 Sep 2018 22:39:29 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 154F7440078; Thu, 27 Sep 2018 23:39:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: wm9712: fix unused variable warning" to the asoc tree
In-Reply-To:  <20180926193750.2468414-1-arnd@arndb.de>
Message-Id: <20180927223928.154F7440078@finisterre.ee.mobilebroadband>
Date:   Thu, 27 Sep 2018 23:39:28 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm9712: fix unused variable warning

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

From 18380dcc52cc8965e5144ce33fdfad7e168679a5 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 26 Sep 2018 21:37:40 +0200
Subject: [PATCH] ASoC: wm9712: fix unused variable warning

The 'ret' variable is now only used in an #ifdef, and causes a
warning if it is declared outside of that block:

sound/soc/codecs/wm9712.c: In function 'wm9712_soc_probe':
sound/soc/codecs/wm9712.c:641:6: error: unused variable 'ret' [-Werror=unused-variable]

Fixes: 2ed1a8e0ce8d ("ASoC: wm9712: add ac97 new bus support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm9712.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index ade34c26ad2f..e873baa9e778 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -638,13 +638,14 @@ static int wm9712_soc_probe(struct snd_soc_component *component)
 {
 	struct wm9712_priv *wm9712 = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap;
-	int ret;
 
 	if (wm9712->mfd_pdata) {
 		wm9712->ac97 = wm9712->mfd_pdata->ac97;
 		regmap = wm9712->mfd_pdata->regmap;
 	} else {
 #ifdef CONFIG_SND_SOC_AC97_BUS
+		int ret;
+
 		wm9712->ac97 = snd_soc_new_ac97_component(component, WM9712_VENDOR_ID,
 						      WM9712_VENDOR_ID_MASK);
 		if (IS_ERR(wm9712->ac97)) {
-- 
2.19.0

