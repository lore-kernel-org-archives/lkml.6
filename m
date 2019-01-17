Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB888C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AE820851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547728827;
	bh=LC0AkDc08Cfmowyd5z8Y2QD69Yj41oIUYOD1mE44tiQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=By+j8bFdE02zCCSyVUMJEW/esmgeIsDt0Mvu8zRNcyRmDVxz5hMcCI3FxYuGp6DnS
	 kE4AdJXR5X5u0Crm6zVvM8Ns955yzIvEfW5ud9P+QIzmUSEEMzwU5JMlFtYwzK3FuI
	 b1pqcridBXhZXGFXjnsM79qPSDWlDCagHLNg8tIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfAQMkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:40:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60488 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfAQMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4PVycBjPPbUxHUaYW/x0jPrQQ2cvtFkz8/zNOWlbkk4=; b=anchVuTiD0RV
        +V4t/POmaVjFyi9L2Fymkuw5PhUNJVKJLvZzcgOsdN2h0ixEyHtXo8GUq4AsorfqOVG3MuXWkOUUm
        4PyGMwdZZbE9oh3fpUhhzjbJDGvW3tid2iMn4i5kqiriNUrTC9DxsatXB0IwQu+tqt30hdmNfktwl
        nrLUs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gk6y2-0000ZL-QF; Thu, 17 Jan 2019 12:40:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6B9621126FE2; Thu, 17 Jan 2019 12:40:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Alban Bedel <albeu@free.fr>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: ath79: Simplify ath79_spi_chipselect()" to the spi tree
In-Reply-To:  <20190116185549.23295-2-albeu@free.fr>
X-Patchwork-Hint: ignore
Message-Id: <20190117124018.6B9621126FE2@debutante.sirena.org.uk>
Date:   Thu, 17 Jan 2019 12:40:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: ath79: Simplify ath79_spi_chipselect()

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

From 797622d7a3ab5192ff575288bdbec15c3a006280 Mon Sep 17 00:00:00 2001
From: Alban Bedel <albeu@free.fr>
Date: Wed, 16 Jan 2019 19:55:45 +0100
Subject: [PATCH] spi: ath79: Simplify ath79_spi_chipselect()

First of all this callback was slightly misused to setup the clock
polarity at the beginning of a transfer. Beside being at the wrong
place, it is also useless as only SPI mode 1 is supported. Instead
just make sure the base value used for IOC is suitable to start a
transfer by clearing the clock and data bits during the controller
setup.

This also remove the last direct usage of the GPIO API, so we can
remove the direct dependency on GPIOLIB.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig     |  2 +-
 drivers/spi/spi-ath79.c | 40 +++++++++-------------------------------
 2 files changed, 10 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index dc67eda1788a..128892c7e21e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -63,7 +63,7 @@ config SPI_ALTERA
 
 config SPI_ATH79
 	tristate "Atheros AR71XX/AR724X/AR913X SPI controller driver"
-	depends on ATH79 && GPIOLIB
+	depends on ATH79
 	select SPI_BITBANG
 	help
 	  This enables support for the SPI controller present on the
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index ed1068ac055f..edf695a359f4 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -21,7 +21,6 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/bitops.h>
-#include <linux/gpio/consumer.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 
@@ -67,38 +66,14 @@ static void ath79_spi_chipselect(struct spi_device *spi, int is_active)
 {
 	struct ath79_spi *sp = ath79_spidev_to_sp(spi);
 	int cs_high = (spi->mode & SPI_CS_HIGH) ? is_active : !is_active;
+	u32 cs_bit = AR71XX_SPI_IOC_CS(spi->chip_select);
 
-	if (is_active) {
-		/* set initial clock polarity */
-		if (spi->mode & SPI_CPOL)
-			sp->ioc_base |= AR71XX_SPI_IOC_CLK;
-		else
-			sp->ioc_base &= ~AR71XX_SPI_IOC_CLK;
-
-		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
-	}
-
-	if (spi->cs_gpiod) {
-		/*
-		 * SPI chipselect is normally active-low, but
-		 * inversion semantics are handled by gpiolib.
-		 *
-		 * FIXME: is this ever used? The driver doesn't
-		 * set SPI_MASTER_GPIO_SS so this callback should not
-		 * get called if a CS GPIO is found by the SPI core.
-		 */
-		gpiod_set_value_cansleep(spi->cs_gpiod, is_active);
-	} else {
-		u32 cs_bit = AR71XX_SPI_IOC_CS(spi->chip_select);
-
-		if (cs_high)
-			sp->ioc_base |= cs_bit;
-		else
-			sp->ioc_base &= ~cs_bit;
-
-		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
-	}
+	if (cs_high)
+		sp->ioc_base |= cs_bit;
+	else
+		sp->ioc_base &= ~cs_bit;
 
+	ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
 }
 
 static void ath79_spi_enable(struct ath79_spi *sp)
@@ -110,6 +85,9 @@ static void ath79_spi_enable(struct ath79_spi *sp)
 	sp->reg_ctrl = ath79_spi_rr(sp, AR71XX_SPI_REG_CTRL);
 	sp->ioc_base = ath79_spi_rr(sp, AR71XX_SPI_REG_IOC);
 
+	/* clear clk and mosi in the base state */
+	sp->ioc_base &= ~(AR71XX_SPI_IOC_DO | AR71XX_SPI_IOC_CLK);
+
 	/* TODO: setup speed? */
 	ath79_spi_wr(sp, AR71XX_SPI_REG_CTRL, 0x43);
 }
-- 
2.20.1

