Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C02C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969002172E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="CF2zHE4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969002172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeI1FAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:00:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55240 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeI1FAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KnPppPt0ZyEq8D6yc5Tjpdi4b6ZJaTdKP9Rn/shU1AE=; b=CF2zHE4LY83W
        1q+QDu2KCzdCxuSTN77JgR5ut/DUiICzFU9+WIXmt4lFdw4ZOHbYZANzB6pQEQbNS2pUjDFPVwpmP
        9AZXDj1uj39svRjpnD/71lyE/bOPfIzOwKoMS7kNQ6L20HLrZELSNS7+AU8Pq5UHq85iqTC6sJLzW
        wa1sg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5ewc-0007TA-Tr; Thu, 27 Sep 2018 22:39:39 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 753FF440078; Thu, 27 Sep 2018 23:39:38 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Takashi Iwai <tiwai@suse.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Meier <florian.meier@koalo.de>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: atmel: add SND_SOC_I2C_AND_SPI dependency" to the asoc tree
In-Reply-To:  <20180926125957.2256982-1-arnd@arndb.de>
Message-Id: <20180927223938.753FF440078@finisterre.ee.mobilebroadband>
Date:   Thu, 27 Sep 2018 23:39:38 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: atmel: add SND_SOC_I2C_AND_SPI dependency

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

From 53c156ab9d8aae2083d3c895365a3e39b864a5a7 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 26 Sep 2018 14:59:40 +0200
Subject: [PATCH] ASoC: atmel: add SND_SOC_I2C_AND_SPI dependency

Selecting SND_SOC_WM8731 is only allowed when all its dependencies
are already there:

WARNING: unmet direct dependencies detected for SND_SOC_WM8731
  Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_I2C_AND_SPI [=m]
  Selected by [y]:
  - SND_SOC_MIKROE_PROTO [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_ATMEL_SOC [=y] && OF [=y]
  Selected by [m]:
  - SND_AT91_SOC_SAM9X5_WM8731 [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_ATMEL_SOC [=y] && (ARCH_AT91 [=y] || COMPILE_TEST [=y]) && ATMEL_SSC [=y] && SND_SOC_I2C_AND_SPI [=m]
  - SND_SOC_ALL_CODECS [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && COMPILE_TEST [=y] && SND_SOC_I2C_AND_SPI [=m]

Fixes: a45f8853a5f9 ("ASoC: Add driver for PROTO Audio CODEC (with a WM8731)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 81a0712d4f14..64f86f0b87e5 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -101,6 +101,7 @@ config SND_ATMEL_SOC_I2S
 config SND_SOC_MIKROE_PROTO
 	tristate "Support for Mikroe-PROTO board"
 	depends on OF
+	depends on SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8731
 	help
 	  Say Y or M if you want to add support for MikroElektronika PROTO Audio
-- 
2.19.0

