Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82316C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB8320883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="HncpOtX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB8320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbeKHAea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:34:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44534 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeKHAea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=yJbVVOPDbgh7nsjX5fvW1U3U3vCDDK95tB2zy72b6Yk=; b=HncpOtX2sV3F
        WzOTz2MkNtQmh3uqn4ivKFv+IGx8u8OsXd0+dQRGIdsvlunXX/JDbK2H/qi572e1S9EUETs6c7Hhy
        eRqrUCccFsc3eBadZDotX9uOhZqJ7XyebRxfDNhPR23QffJY5itqdEUpvM2hknJnnIPba3uqOdEyY
        c2/ZA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKPMe-0006bX-0m; Wed, 07 Nov 2018 15:03:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B6DC41124E14; Wed,  7 Nov 2018 15:03:27 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Piotr Bugalski <bugalski.piotr@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: Add QuadSPI driver for Atmel SAMA5D2" to the spi tree
In-Reply-To:  <20181105103625.9644-6-bugalski.piotr@gmail.com>
Message-Id: <20181107150327.B6DC41124E14@debutante.sirena.org.uk>
Date:   Wed,  7 Nov 2018 15:03:27 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: Add QuadSPI driver for Atmel SAMA5D2

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

From 0e6aae08e9ae7c2dc3c83bf6960d824feb14b706 Mon Sep 17 00:00:00 2001
From: Piotr Bugalski <bugalski.piotr@gmail.com>
Date: Mon, 5 Nov 2018 11:36:24 +0100
Subject: [PATCH] spi: Add QuadSPI driver for Atmel SAMA5D2

Kernel contains QSPI driver strongly tied to MTD and nor-flash memory.
New spi-mem interface allows usage also other memory types, especially
much larger NAND with SPI interface. This driver works as SPI controller
and is not related to MTD, however can work with NAND-flash or other
peripherals using spi-mem interface.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <bugalski.piotr@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mtd/spi-nor/Kconfig                  | 9 ---------
 drivers/mtd/spi-nor/Makefile                 | 1 -
 drivers/spi/Kconfig                          | 9 +++++++++
 drivers/spi/Makefile                         | 1 +
 drivers/{mtd/spi-nor => spi}/atmel-quadspi.c | 0
 5 files changed, 10 insertions(+), 10 deletions(-)
 rename drivers/{mtd/spi-nor => spi}/atmel-quadspi.c (100%)

diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index 6cc9c929ff57..44fe8018733c 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -39,15 +39,6 @@ config SPI_ASPEED_SMC
 	  and support for the SPI flash memory controller (SPI) for
 	  the host firmware. The implementation only supports SPI NOR.
 
-config SPI_ATMEL_QUADSPI
-	tristate "Atmel Quad SPI Controller"
-	depends on ARCH_AT91 || (ARM && COMPILE_TEST)
-	depends on OF && HAS_IOMEM
-	help
-	  This enables support for the Quad SPI controller in master mode.
-	  This driver does not support generic SPI. The implementation only
-	  supports SPI NOR.
-
 config SPI_CADENCE_QUADSPI
 	tristate "Cadence Quad SPI controller"
 	depends on OF && (ARM || ARM64 || COMPILE_TEST)
diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index f4c61d282abd..a552efd22958 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
 obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
-obj-$(CONFIG_SPI_ATMEL_QUADSPI)	+= atmel-quadspi.o
 obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= cadence-quadspi.o
 obj-$(CONFIG_SPI_FSL_QUADSPI)	+= fsl-quadspi.o
 obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 7d3a5c94727e..ca68ac63c6c3 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -91,6 +91,15 @@ config SPI_AT91_USART
 	  This selects a driver for the AT91 USART Controller as SPI Master,
 	  present on AT91 and SAMA5 SoC series.
 
+config SPI_ATMEL_QUADSPI
+	tristate "Atmel Quad SPI Controller"
+	depends on ARCH_AT91 || (ARM && COMPILE_TEST)
+	depends on OF && HAS_IOMEM
+	help
+	  This enables support for the Quad SPI controller in master mode.
+	  This driver does not support generic SPI. The implementation only
+	  supports spi-mem interface.
+
 config SPI_AU1550
 	tristate "Au1550/Au1200/Au1300 SPI Controller"
 	depends on MIPS_ALCHEMY
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 3575205c5c27..258917db3f56 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
 obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
 obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
+obj-$(CONFIG_SPI_ATMEL_QUADSPI)		+= atmel-quadspi.o
 obj-$(CONFIG_SPI_AT91_USART)		+= spi-at91-usart.o
 obj-$(CONFIG_SPI_ATH79)			+= spi-ath79.o
 obj-$(CONFIG_SPI_AU1550)		+= spi-au1550.o
diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
similarity index 100%
rename from drivers/mtd/spi-nor/atmel-quadspi.c
rename to drivers/spi/atmel-quadspi.c
-- 
2.19.0.rc2

