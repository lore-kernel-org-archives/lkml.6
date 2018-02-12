Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934419AbeBLMKQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:10:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35758 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933136AbeBLMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:10:14 -0500
From: Mark Brown <broonie@kernel.org>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, clabbe.montjoie@gmail.com,
        viresh.kumar@linaro.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, b.zolnierkie@samsung.com,
        daniel.vetter@ffwll.ch, christophe.leroy@c-s.fr, seanpaul@chromium.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: kconfig: Remove AVR32 dep. from SPI_ATMEL" to the spi tree
In-Reply-To: <20180208024414.jjcxvd2q4o5rifgh@huvuddator>
Message-Id: <E1elCvt-0007br-Ss@debutante>
Date: Mon, 12 Feb 2018 12:10:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: kconfig: Remove AVR32 dep. from SPI_ATMEL

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From e3d001a0c29d6c9a87dd9e86bcb84fc66c2ddbe8 Mon Sep 17 00:00:00 2001
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 8 Feb 2018 23:00:16 +0100
Subject: [PATCH] spi: kconfig: Remove AVR32 dep. from SPI_ATMEL

The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
support for AVR32 architecture").

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 603783976b81..6fb0347a24f2 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -72,10 +72,10 @@ config SPI_ARMADA_3700
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
 	depends on HAS_DMA
-	depends on (ARCH_AT91 || AVR32 || COMPILE_TEST)
+	depends on (ARCH_AT91 || COMPILE_TEST)
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
-	  many AT32 (AVR32) and AT91 (ARM) chips.
+	  many AT91 (ARM) chips.
 
 config SPI_AU1550
 	tristate "Au1550/Au1200/Au1300 SPI Controller"
-- 
2.16.1
