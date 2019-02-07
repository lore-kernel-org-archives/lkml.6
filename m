Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC155C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9526D2192D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549552965;
	bh=Yfj/Y7YUlPXkw7+ExA18DrhingUCajmF6PNXbxLKXbI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=R4wz/r3zGFOis16tloyaTScayscP3SYWe+5no9i5FdO3EMsxrpS+zjX/zMIr1QUJd
	 JR4/gaieYdUdaZSkAUboyM4W3rvfYgVFBpRUsqQEqB0uiqdG9AVvzc16b6morGA0xy
	 4RG7DdCfcTmWj9q/xrC/aBXkC6Qyyvy/ZapAy/zI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBGPWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:22:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43736 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfBGPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=kU2KW2rywpG66NA7e0Yr5xFScyriDrAQWXTZDDO59KE=; b=Q368CF8ngXuC
        Z8nJxoS1w7Ztt2r92TnjiCsqc6niZEgetzhY6PtEch+EYu39gg/tamugCsCh5SsgYOOqs72r61zyI
        kjcldOZpJK2PPSYj+yiso6EdD/NuMHOzoKjskaL7ERcd0X2SEemm6hUVRfcRkVIVSFV/oa0G/PVWL
        riJIo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grlVX-0006OC-O4; Thu, 07 Feb 2019 15:22:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 68AC11127EF9; Thu,  7 Feb 2019 15:22:31 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: codecs: Kconfig: Show knob, and depend on MIPS || COMPILE_TEST" to the asoc tree
In-Reply-To:  <20190207133143.5232-5-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Message-Id: <20190207152231.68AC11127EF9@debutante.sirena.org.uk>
Date:   Thu,  7 Feb 2019 15:22:31 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: Kconfig: Show knob, and depend on MIPS || COMPILE_TEST

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

From edcd3ed182f804ebec71b063bab32c424ddd8b6a Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Thu, 7 Feb 2019 10:31:42 -0300
Subject: [PATCH] ASoC: codecs: Kconfig: Show knob, and depend on MIPS ||
 COMPILE_TEST

Show the knob to enable or disable the jz4740-codec driver, add a
proper description, and add a dependency on MIPS || COMPILE_TEST, as
this driver is only useful on MIPS.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index fec894c725d3..e6ce18c21b98 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -579,8 +579,15 @@ config SND_SOC_CX20442
 	depends on TTY
 
 config SND_SOC_JZ4740_CODEC
+	depends on MIPS || COMPILE_TEST
 	select REGMAP_MMIO
-	tristate
+	tristate "Ingenic JZ4740 internal CODEC"
+	help
+	  Enable support for the internal CODEC found in the JZ4740 SoC
+	  from Ingenic.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called snd-soc-jz4740-codec.
 
 config SND_SOC_JZ4725B_CODEC
 	depends on MIPS || COMPILE_TEST
-- 
2.20.1

