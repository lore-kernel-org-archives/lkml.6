Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAA8C282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8877217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548266288;
	bh=8mQ9nXYKWHHdpfD0zhoaumDmHThJQOlTsbuoU7gWLCU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=WlaM5A1PsRJNPZOE6FABTUQbf6LYehdoB4/rYDc6xs9R5XpRppui+DP3bSocsYyvL
	 jNVl3j5LkrR56SITbuqsYpbHdxkQx8mxL9mHbL+zQ09zoxL7vsA1Ip4B1FnyWefrx0
	 v/4r4rFgffG3e3uNRml+ryc8UT4Ht7DccT+Qz2mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfAWR6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:58:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46112 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfAWR6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=01oZ1qs+S4uD+YLQTk8eFaGzvT0PHeTdcWuG76qwFvg=; b=It/eqF0IBnpq
        W8adVFAwFIAs84KCBxYQg1n4w/+2TWXQJhr7sQa1DKTfzdxPE7oiwUfky38xsmbuH9IJ+s+oa8X2Q
        WIGx/4/vHt5JMTi9Jtnle6hlrpo2ll9b7DbC3TPfQWy0gwn+O/jKZwsCTJnBhjZk3y8zElZCVSs2f
        lnkhE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmMmk-0006qh-Tj; Wed, 23 Jan 2019 17:57:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D4C101127ABA; Wed, 23 Jan 2019 17:57:57 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "pxa2xx: replace spi_master with spi_controller" to the spi tree
In-Reply-To:  <20190116151330.1971861-1-lkundrak@v3.sk>
X-Patchwork-Hint: ignore
Message-Id: <20190123175757.D4C101127ABA@debutante.sirena.org.uk>
Date:   Wed, 23 Jan 2019 17:57:57 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   pxa2xx: replace spi_master with spi_controller

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

From 51eea52d26d4939b788b7244c28cf47e902b4c4c Mon Sep 17 00:00:00 2001
From: Lubomir Rintel <lkundrak@v3.sk>
Date: Wed, 16 Jan 2019 16:13:31 +0100
Subject: [PATCH] pxa2xx: replace spi_master with spi_controller

It's also a slave controller driver now, calling it "master" is slightly
misleading.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/spi/pxa2xx       |  10 +--
 arch/arm/mach-pxa/cm-x255.c    |   2 +-
 arch/arm/mach-pxa/cm-x270.c    |   2 +-
 arch/arm/mach-pxa/corgi.c      |   2 +-
 arch/arm/mach-pxa/devices.c    |   2 +-
 arch/arm/mach-pxa/em-x270.c    |   4 +-
 arch/arm/mach-pxa/hx4700.c     |   2 +-
 arch/arm/mach-pxa/icontrol.c   |   4 +-
 arch/arm/mach-pxa/littleton.c  |   2 +-
 arch/arm/mach-pxa/lubbock.c    |   2 +-
 arch/arm/mach-pxa/magician.c   |   2 +-
 arch/arm/mach-pxa/pcm027.c     |   2 +-
 arch/arm/mach-pxa/poodle.c     |   2 +-
 arch/arm/mach-pxa/spitz.c      |   2 +-
 arch/arm/mach-pxa/stargate2.c  |   6 +-
 arch/arm/mach-pxa/tosa.c       |   2 +-
 arch/arm/mach-pxa/z2.c         |   4 +-
 arch/arm/mach-pxa/zeus.c       |   2 +-
 drivers/spi/spi-pxa2xx-dma.c   |  58 ++++++------
 drivers/spi/spi-pxa2xx-pci.c   |   4 +-
 drivers/spi/spi-pxa2xx.c       | 156 ++++++++++++++++-----------------
 drivers/spi/spi-pxa2xx.h       |   4 +-
 include/linux/spi/pxa2xx_spi.h |   4 +-
 23 files changed, 140 insertions(+), 140 deletions(-)

diff --git a/Documentation/spi/pxa2xx b/Documentation/spi/pxa2xx
index 13a0b7fb192f..551325b66b23 100644
--- a/Documentation/spi/pxa2xx
+++ b/Documentation/spi/pxa2xx
@@ -21,15 +21,15 @@ Typically a SPI master is defined in the arch/.../mach-*/board-*.c as a
 "platform device".  The master configuration is passed to the driver via a table
 found in include/linux/spi/pxa2xx_spi.h:
 
-struct pxa2xx_spi_master {
+struct pxa2xx_spi_controller {
 	u16 num_chipselect;
 	u8 enable_dma;
 };
 
-The "pxa2xx_spi_master.num_chipselect" field is used to determine the number of
+The "pxa2xx_spi_controller.num_chipselect" field is used to determine the number of
 slave device (chips) attached to this SPI master.
 
-The "pxa2xx_spi_master.enable_dma" field informs the driver that SSP DMA should
+The "pxa2xx_spi_controller.enable_dma" field informs the driver that SSP DMA should
 be used.  This caused the driver to acquire two DMA channels: rx_channel and
 tx_channel.  The rx_channel has a higher DMA service priority the tx_channel.
 See the "PXA2xx Developer Manual" section "DMA Controller".
@@ -51,7 +51,7 @@ static struct resource pxa_spi_nssp_resources[] = {
 	},
 };
 
-static struct pxa2xx_spi_master pxa_nssp_master_info = {
+static struct pxa2xx_spi_controller pxa_nssp_master_info = {
 	.num_chipselect = 1, /* Matches the number of chips attached to NSSP */
 	.enable_dma = 1, /* Enables NSSP DMA */
 };
@@ -206,7 +206,7 @@ DMA and PIO I/O Support
 -----------------------
 The pxa2xx_spi driver supports both DMA and interrupt driven PIO message
 transfers.  The driver defaults to PIO mode and DMA transfers must be enabled
-by setting the "enable_dma" flag in the "pxa2xx_spi_master" structure.  The DMA
+by setting the "enable_dma" flag in the "pxa2xx_spi_controller" structure.  The DMA
 mode supports both coherent and stream based DMA mappings.
 
 The following logic is used to determine the type of I/O to be used on
diff --git a/arch/arm/mach-pxa/cm-x255.c b/arch/arm/mach-pxa/cm-x255.c
index fa8e7dd4d898..4401dfcd7e68 100644
--- a/arch/arm/mach-pxa/cm-x255.c
+++ b/arch/arm/mach-pxa/cm-x255.c
@@ -98,7 +98,7 @@ static unsigned long cmx255_pin_config[] = {
 };
 
 #if defined(CONFIG_SPI_PXA2XX)
-static struct pxa2xx_spi_master pxa_ssp_master_info = {
+static struct pxa2xx_spi_controller pxa_ssp_master_info = {
 	.num_chipselect	= 1,
 };
 
diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
index f7081a50dc67..279eeca7add0 100644
--- a/arch/arm/mach-pxa/cm-x270.c
+++ b/arch/arm/mach-pxa/cm-x270.c
@@ -313,7 +313,7 @@ static inline void cmx270_init_mmc(void) {}
 #endif
 
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
-static struct pxa2xx_spi_master cm_x270_spi_info = {
+static struct pxa2xx_spi_controller cm_x270_spi_info = {
 	.num_chipselect	= 1,
 	.enable_dma	= 1,
 };
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index c9732cace5e3..7ecf559bd71c 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -530,7 +530,7 @@ static struct pxa2xx_udc_mach_info udc_info __initdata = {
 };
 
 #if IS_ENABLED(CONFIG_SPI_PXA2XX)
-static struct pxa2xx_spi_master corgi_spi_info = {
+static struct pxa2xx_spi_controller corgi_spi_info = {
 	.num_chipselect	= 3,
 };
 
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index a24783a03827..524d6093e0c7 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -1065,7 +1065,7 @@ struct platform_device pxa93x_device_gpio = {
 
 /* pxa2xx-spi platform-device ID equals respective SSP platform-device ID + 1.
  * See comment in arch/arm/mach-pxa/ssp.c::ssp_probe() */
-void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_master *info)
+void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_controller *info)
 {
 	struct platform_device *pd;
 
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 32c1edeb3f14..5e372760f16e 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -689,7 +689,7 @@ static inline void em_x270_init_lcd(void) {}
 #endif
 
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
-static struct pxa2xx_spi_master em_x270_spi_info = {
+static struct pxa2xx_spi_controller em_x270_spi_info = {
 	.num_chipselect	= 1,
 };
 
@@ -703,7 +703,7 @@ static struct tdo24m_platform_data em_x270_tdo24m_pdata = {
 	.model = TDO35S,
 };
 
-static struct pxa2xx_spi_master em_x270_spi_2_info = {
+static struct pxa2xx_spi_controller em_x270_spi_2_info = {
 	.num_chipselect	= 1,
 	.enable_dma	= 1,
 };
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index b79b757fdd41..c3b47557b3f2 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -629,7 +629,7 @@ static struct spi_board_info tsc2046_board_info[] __initdata = {
 	},
 };
 
-static struct pxa2xx_spi_master pxa_ssp2_master_info = {
+static struct pxa2xx_spi_controller pxa_ssp2_master_info = {
 	.num_chipselect = 1,
 	.enable_dma     = 1,
 };
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index cbaf4f6edcda..7e30452e3840 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -115,12 +115,12 @@ static struct spi_board_info mcp251x_board_info[] = {
 	}
 };
 
-static struct pxa2xx_spi_master pxa_ssp3_spi_master_info = {
+static struct pxa2xx_spi_controller pxa_ssp3_spi_master_info = {
 	.num_chipselect = 2,
 	.enable_dma     = 1
 };
 
-static struct pxa2xx_spi_master pxa_ssp4_spi_master_info = {
+static struct pxa2xx_spi_controller pxa_ssp4_spi_master_info = {
 	.num_chipselect = 2,
 	.enable_dma     = 1
 };
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 39db4898dc4a..464b8bd2bcb9 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -191,7 +191,7 @@ static inline void littleton_init_lcd(void) {};
 #endif /* CONFIG_FB_PXA || CONFIG_FB_PXA_MODULE */
 
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
-static struct pxa2xx_spi_master littleton_spi_info = {
+static struct pxa2xx_spi_controller littleton_spi_info = {
 	.num_chipselect		= 1,
 };
 
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index a1391e113ef4..c1bd0d544981 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -197,7 +197,7 @@ static struct platform_device sa1111_device = {
  * (to J5) and poking board registers (as done below).  Else it's only useful
  * for the temperature sensors.
  */
-static struct pxa2xx_spi_master pxa_ssp_master_info = {
+static struct pxa2xx_spi_controller pxa_ssp_master_info = {
 	.num_chipselect	= 1,
 };
 
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 08b079653c3f..618bcff4cdc9 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -932,7 +932,7 @@ struct pxa2xx_spi_chip tsc2046_chip_info = {
 	.gpio_cs	= GPIO14_MAGICIAN_TSC2046_CS,
 };
 
-static struct pxa2xx_spi_master magician_spi_info = {
+static struct pxa2xx_spi_controller magician_spi_info = {
 	.num_chipselect	= 1,
 	.enable_dma	= 1,
 };
diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
index ccca9f7575c3..e2e613449660 100644
--- a/arch/arm/mach-pxa/pcm027.c
+++ b/arch/arm/mach-pxa/pcm027.c
@@ -132,7 +132,7 @@ static struct platform_device smc91x_device = {
 /*
  * SPI host and devices
  */
-static struct pxa2xx_spi_master pxa_ssp_master_info = {
+static struct pxa2xx_spi_controller pxa_ssp_master_info = {
 	.num_chipselect	= 1,
 };
 
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index c2a43d4cfd3e..9450a523cd0b 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -196,7 +196,7 @@ struct platform_device poodle_locomo_device = {
 EXPORT_SYMBOL(poodle_locomo_device);
 
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
-static struct pxa2xx_spi_master poodle_spi_info = {
+static struct pxa2xx_spi_controller poodle_spi_info = {
 	.num_chipselect	= 1,
 };
 
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 306818e2cf54..8dac824a85df 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -572,7 +572,7 @@ static struct spi_board_info spitz_spi_devices[] = {
 	},
 };
 
-static struct pxa2xx_spi_master spitz_spi_info = {
+static struct pxa2xx_spi_controller spitz_spi_info = {
 	.num_chipselect	= 3,
 };
 
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index e0d6c872270a..c28d19b126a7 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -337,15 +337,15 @@ static struct platform_device stargate2_flash_device = {
 	.num_resources = 1,
 };
 
-static struct pxa2xx_spi_master pxa_ssp_master_0_info = {
+static struct pxa2xx_spi_controller pxa_ssp_master_0_info = {
 	.num_chipselect = 1,
 };
 
-static struct pxa2xx_spi_master pxa_ssp_master_1_info = {
+static struct pxa2xx_spi_controller pxa_ssp_master_1_info = {
 	.num_chipselect = 1,
 };
 
-static struct pxa2xx_spi_master pxa_ssp_master_2_info = {
+static struct pxa2xx_spi_controller pxa_ssp_master_2_info = {
 	.num_chipselect = 1,
 };
 
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index e8a93c088c35..7439798d58e4 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -813,7 +813,7 @@ static struct platform_device tosa_bt_device = {
 	.dev.platform_data = &tosa_bt_data,
 };
 
-static struct pxa2xx_spi_master pxa_ssp_master_info = {
+static struct pxa2xx_spi_controller pxa_ssp_master_info = {
 	.num_chipselect	= 1,
 };
 
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index e2353e75bb28..ad082e11e2a4 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -607,12 +607,12 @@ static struct spi_board_info spi_board_info[] __initdata = {
 },
 };
 
-static struct pxa2xx_spi_master pxa_ssp1_master_info = {
+static struct pxa2xx_spi_controller pxa_ssp1_master_info = {
 	.num_chipselect	= 1,
 	.enable_dma	= 1,
 };
 
-static struct pxa2xx_spi_master pxa_ssp2_master_info = {
+static struct pxa2xx_spi_controller pxa_ssp2_master_info = {
 	.num_chipselect	= 1,
 };
 
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index c411f79d4cb5..bdbcf46595f9 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -391,7 +391,7 @@ static struct platform_device zeus_sram_device = {
 };
 
 /* SPI interface on SSP3 */
-static struct pxa2xx_spi_master pxa2xx_spi_ssp3_master_info = {
+static struct pxa2xx_spi_controller pxa2xx_spi_ssp3_master_info = {
 	.num_chipselect = 1,
 	.enable_dma     = 1,
 };
diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 2fa7f4b43492..15592598273e 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -23,7 +23,7 @@
 static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data,
 					     bool error)
 {
-	struct spi_message *msg = drv_data->master->cur_msg;
+	struct spi_message *msg = drv_data->controller->cur_msg;
 
 	/*
 	 * It is possible that one CPU is handling ROR interrupt and other
@@ -59,7 +59,7 @@ static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data,
 			msg->status = -EIO;
 		}
 
-		spi_finalize_current_transfer(drv_data->master);
+		spi_finalize_current_transfer(drv_data->controller);
 	}
 }
 
@@ -74,7 +74,7 @@ pxa2xx_spi_dma_prepare_one(struct driver_data *drv_data,
 			   struct spi_transfer *xfer)
 {
 	struct chip_data *chip =
-		spi_get_ctldata(drv_data->master->cur_msg->spi);
+		spi_get_ctldata(drv_data->controller->cur_msg->spi);
 	enum dma_slave_buswidth width;
 	struct dma_slave_config cfg;
 	struct dma_chan *chan;
@@ -102,14 +102,14 @@ pxa2xx_spi_dma_prepare_one(struct driver_data *drv_data,
 		cfg.dst_maxburst = chip->dma_burst_size;
 
 		sgt = &xfer->tx_sg;
-		chan = drv_data->master->dma_tx;
+		chan = drv_data->controller->dma_tx;
 	} else {
 		cfg.src_addr = drv_data->ssdr_physical;
 		cfg.src_addr_width = width;
 		cfg.src_maxburst = chip->dma_burst_size;
 
 		sgt = &xfer->rx_sg;
-		chan = drv_data->master->dma_rx;
+		chan = drv_data->controller->dma_rx;
 	}
 
 	ret = dmaengine_slave_config(chan, &cfg);
@@ -130,8 +130,8 @@ irqreturn_t pxa2xx_spi_dma_transfer(struct driver_data *drv_data)
 	if (status & SSSR_ROR) {
 		dev_err(&drv_data->pdev->dev, "FIFO overrun\n");
 
-		dmaengine_terminate_async(drv_data->master->dma_rx);
-		dmaengine_terminate_async(drv_data->master->dma_tx);
+		dmaengine_terminate_async(drv_data->controller->dma_rx);
+		dmaengine_terminate_async(drv_data->controller->dma_tx);
 
 		pxa2xx_spi_dma_transfer_complete(drv_data, true);
 		return IRQ_HANDLED;
@@ -171,15 +171,15 @@ int pxa2xx_spi_dma_prepare(struct driver_data *drv_data,
 	return 0;
 
 err_rx:
-	dmaengine_terminate_async(drv_data->master->dma_tx);
+	dmaengine_terminate_async(drv_data->controller->dma_tx);
 err_tx:
 	return err;
 }
 
 void pxa2xx_spi_dma_start(struct driver_data *drv_data)
 {
-	dma_async_issue_pending(drv_data->master->dma_rx);
-	dma_async_issue_pending(drv_data->master->dma_tx);
+	dma_async_issue_pending(drv_data->controller->dma_rx);
+	dma_async_issue_pending(drv_data->controller->dma_tx);
 
 	atomic_set(&drv_data->dma_running, 1);
 }
@@ -187,30 +187,30 @@ void pxa2xx_spi_dma_start(struct driver_data *drv_data)
 void pxa2xx_spi_dma_stop(struct driver_data *drv_data)
 {
 	atomic_set(&drv_data->dma_running, 0);
-	dmaengine_terminate_sync(drv_data->master->dma_rx);
-	dmaengine_terminate_sync(drv_data->master->dma_tx);
+	dmaengine_terminate_sync(drv_data->controller->dma_rx);
+	dmaengine_terminate_sync(drv_data->controller->dma_tx);
 }
 
 int pxa2xx_spi_dma_setup(struct driver_data *drv_data)
 {
-	struct pxa2xx_spi_master *pdata = drv_data->master_info;
+	struct pxa2xx_spi_controller *pdata = drv_data->controller_info;
 	struct device *dev = &drv_data->pdev->dev;
-	struct spi_controller *master = drv_data->master;
+	struct spi_controller *controller = drv_data->controller;
 	dma_cap_mask_t mask;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	master->dma_tx = dma_request_slave_channel_compat(mask,
+	controller->dma_tx = dma_request_slave_channel_compat(mask,
 				pdata->dma_filter, pdata->tx_param, dev, "tx");
-	if (!master->dma_tx)
+	if (!controller->dma_tx)
 		return -ENODEV;
 
-	master->dma_rx = dma_request_slave_channel_compat(mask,
+	controller->dma_rx = dma_request_slave_channel_compat(mask,
 				pdata->dma_filter, pdata->rx_param, dev, "rx");
-	if (!master->dma_rx) {
-		dma_release_channel(master->dma_tx);
-		master->dma_tx = NULL;
+	if (!controller->dma_rx) {
+		dma_release_channel(controller->dma_tx);
+		controller->dma_tx = NULL;
 		return -ENODEV;
 	}
 
@@ -219,17 +219,17 @@ int pxa2xx_spi_dma_setup(struct driver_data *drv_data)
 
 void pxa2xx_spi_dma_release(struct driver_data *drv_data)
 {
-	struct spi_controller *master = drv_data->master;
+	struct spi_controller *controller = drv_data->controller;
 
-	if (master->dma_rx) {
-		dmaengine_terminate_sync(master->dma_rx);
-		dma_release_channel(master->dma_rx);
-		master->dma_rx = NULL;
+	if (controller->dma_rx) {
+		dmaengine_terminate_sync(controller->dma_rx);
+		dma_release_channel(controller->dma_rx);
+		controller->dma_rx = NULL;
 	}
-	if (master->dma_tx) {
-		dmaengine_terminate_sync(master->dma_tx);
-		dma_release_channel(master->dma_tx);
-		master->dma_tx = NULL;
+	if (controller->dma_tx) {
+		dmaengine_terminate_sync(controller->dma_tx);
+		dma_release_channel(controller->dma_tx);
+		controller->dma_tx = NULL;
 	}
 }
 
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 869f188b02eb..1727fdfbac28 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -197,7 +197,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	struct platform_device_info pi;
 	int ret;
 	struct platform_device *pdev;
-	struct pxa2xx_spi_master spi_pdata;
+	struct pxa2xx_spi_controller spi_pdata;
 	struct ssp_device *ssp;
 	struct pxa_spi_info *c;
 	char buf[40];
@@ -265,7 +265,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
 {
 	struct platform_device *pdev = pci_get_drvdata(dev);
-	struct pxa2xx_spi_master *spi_pdata;
+	struct pxa2xx_spi_controller *spi_pdata;
 
 	spi_pdata = dev_get_platdata(&pdev->dev);
 
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index d84b893a64d7..69e874a2ad1e 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -328,7 +328,7 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
 
 	/* Enable multiblock DMA transfers */
-	if (drv_data->master_info->enable_dma) {
+	if (drv_data->controller_info->enable_dma) {
 		__lpss_ssp_write_priv(drv_data, config->reg_ssp, 1);
 
 		if (config->reg_general >= 0) {
@@ -368,7 +368,7 @@ static void lpss_ssp_select_cs(struct spi_device *spi,
 		__lpss_ssp_write_priv(drv_data,
 				      config->reg_cs_ctrl, value);
 		ndelay(1000000000 /
-		       (drv_data->master->max_speed_hz / 2));
+		       (drv_data->controller->max_speed_hz / 2));
 	}
 }
 
@@ -567,7 +567,7 @@ static int u32_reader(struct driver_data *drv_data)
 static void reset_sccr1(struct driver_data *drv_data)
 {
 	struct chip_data *chip =
-		spi_get_ctldata(drv_data->master->cur_msg->spi);
+		spi_get_ctldata(drv_data->controller->cur_msg->spi);
 	u32 sccr1_reg;
 
 	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1) & ~drv_data->int_cr1;
@@ -599,8 +599,8 @@ static void int_error_stop(struct driver_data *drv_data, const char* msg)
 
 	dev_err(&drv_data->pdev->dev, "%s\n", msg);
 
-	drv_data->master->cur_msg->status = -EIO;
-	spi_finalize_current_transfer(drv_data->master);
+	drv_data->controller->cur_msg->status = -EIO;
+	spi_finalize_current_transfer(drv_data->controller);
 }
 
 static void int_transfer_complete(struct driver_data *drv_data)
@@ -611,7 +611,7 @@ static void int_transfer_complete(struct driver_data *drv_data)
 	if (!pxa25x_ssp_comp(drv_data))
 		pxa2xx_spi_write(drv_data, SSTO, 0);
 
-	spi_finalize_current_transfer(drv_data->master);
+	spi_finalize_current_transfer(drv_data->controller);
 }
 
 static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
@@ -747,7 +747,7 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg & ~drv_data->int_cr1);
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
 
-	if (!drv_data->master->cur_msg) {
+	if (!drv_data->controller->cur_msg) {
 		handle_bad_msg(drv_data);
 		/* Never fail */
 		return IRQ_HANDLED;
@@ -879,7 +879,7 @@ static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
 
 static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 {
-	unsigned long ssp_clk = drv_data->master->max_speed_hz;
+	unsigned long ssp_clk = drv_data->controller->max_speed_hz;
 	const struct ssp_device *ssp = drv_data->ssp;
 
 	rate = min_t(int, ssp_clk, rate);
@@ -894,7 +894,7 @@ static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
 					   int rate)
 {
 	struct chip_data *chip =
-		spi_get_ctldata(drv_data->master->cur_msg->spi);
+		spi_get_ctldata(drv_data->controller->cur_msg->spi);
 	unsigned int clk_div;
 
 	switch (drv_data->ssp_type) {
@@ -908,7 +908,7 @@ static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
 	return clk_div << 8;
 }
 
-static bool pxa2xx_spi_can_dma(struct spi_controller *master,
+static bool pxa2xx_spi_can_dma(struct spi_controller *controller,
 			       struct spi_device *spi,
 			       struct spi_transfer *xfer)
 {
@@ -919,12 +919,12 @@ static bool pxa2xx_spi_can_dma(struct spi_controller *master,
 	       xfer->len >= chip->dma_burst_size;
 }
 
-static int pxa2xx_spi_transfer_one(struct spi_controller *master,
+static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 				   struct spi_device *spi,
 				   struct spi_transfer *transfer)
 {
-	struct driver_data *drv_data = spi_controller_get_devdata(master);
-	struct spi_message *message = master->cur_msg;
+	struct driver_data *drv_data = spi_controller_get_devdata(controller);
+	struct spi_message *message = controller->cur_msg;
 	struct chip_data *chip = spi_get_ctldata(message->spi);
 	u32 dma_thresh = chip->dma_threshold;
 	u32 dma_burst = chip->dma_burst_size;
@@ -1006,9 +1006,9 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 					     "DMA burst size reduced to match bits_per_word\n");
 	}
 
-	dma_mapped = master->can_dma &&
-		     master->can_dma(master, message->spi, transfer) &&
-		     master->cur_msg_mapped;
+	dma_mapped = controller->can_dma &&
+		     controller->can_dma(controller, message->spi, transfer) &&
+		     controller->cur_msg_mapped;
 	if (dma_mapped) {
 
 		/* Ensure we have the correct interrupt handler */
@@ -1036,12 +1036,12 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 	cr0 = pxa2xx_configure_sscr0(drv_data, clk_div, bits);
 	if (!pxa25x_ssp_comp(drv_data))
 		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
-			master->max_speed_hz
+			controller->max_speed_hz
 				/ (1 + ((cr0 & SSCR0_SCR(0xfff)) >> 8)),
 			dma_mapped ? "DMA" : "PIO");
 	else
 		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
-			master->max_speed_hz / 2
+			controller->max_speed_hz / 2
 				/ (1 + ((cr0 & SSCR0_SCR(0x0ff)) >> 8)),
 			dma_mapped ? "DMA" : "PIO");
 
@@ -1092,7 +1092,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 		}
 	}
 
-	if (spi_controller_is_slave(master)) {
+	if (spi_controller_is_slave(controller)) {
 		while (drv_data->write(drv_data))
 			;
 		if (drv_data->gpiod_ready) {
@@ -1111,9 +1111,9 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 	return 1;
 }
 
-static int pxa2xx_spi_slave_abort(struct spi_master *master)
+static int pxa2xx_spi_slave_abort(struct spi_controller *controller)
 {
-	struct driver_data *drv_data = spi_controller_get_devdata(master);
+	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
 	/* Stop and reset SSP */
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
@@ -1126,16 +1126,16 @@ static int pxa2xx_spi_slave_abort(struct spi_master *master)
 
 	dev_dbg(&drv_data->pdev->dev, "transfer aborted\n");
 
-	drv_data->master->cur_msg->status = -EINTR;
-	spi_finalize_current_transfer(drv_data->master);
+	drv_data->controller->cur_msg->status = -EINTR;
+	spi_finalize_current_transfer(drv_data->controller);
 
 	return 0;
 }
 
-static void pxa2xx_spi_handle_err(struct spi_controller *master,
+static void pxa2xx_spi_handle_err(struct spi_controller *controller,
 				 struct spi_message *msg)
 {
-	struct driver_data *drv_data = spi_controller_get_devdata(master);
+	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
 	/* Disable the SSP */
 	pxa2xx_spi_write(drv_data, SSCR0,
@@ -1159,9 +1159,9 @@ static void pxa2xx_spi_handle_err(struct spi_controller *master,
 		pxa2xx_spi_dma_stop(drv_data);
 }
 
-static int pxa2xx_spi_unprepare_transfer(struct spi_controller *master)
+static int pxa2xx_spi_unprepare_transfer(struct spi_controller *controller)
 {
-	struct driver_data *drv_data = spi_controller_get_devdata(master);
+	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
 	/* Disable the SSP now */
 	pxa2xx_spi_write(drv_data, SSCR0,
@@ -1260,7 +1260,7 @@ static int setup(struct spi_device *spi)
 		break;
 	default:
 		tx_hi_thres = 0;
-		if (spi_controller_is_slave(drv_data->master)) {
+		if (spi_controller_is_slave(drv_data->controller)) {
 			tx_thres = 1;
 			rx_thres = 2;
 		} else {
@@ -1287,7 +1287,7 @@ static int setup(struct spi_device *spi)
 
 			chip->frm = spi->chip_select;
 		}
-		chip->enable_dma = drv_data->master_info->enable_dma;
+		chip->enable_dma = drv_data->controller_info->enable_dma;
 		chip->timeout = TIMOUT_DFLT;
 	}
 
@@ -1310,7 +1310,7 @@ static int setup(struct spi_device *spi)
 		if (chip_info->enable_loopback)
 			chip->cr1 = SSCR1_LBM;
 	}
-	if (spi_controller_is_slave(drv_data->master)) {
+	if (spi_controller_is_slave(drv_data->controller)) {
 		chip->cr1 |= SSCR1_SCFR;
 		chip->cr1 |= SSCR1_SCLKDIR;
 		chip->cr1 |= SSCR1_SFRMDIR;
@@ -1497,10 +1497,10 @@ static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
 
 #endif /* CONFIG_PCI */
 
-static struct pxa2xx_spi_master *
+static struct pxa2xx_spi_controller *
 pxa2xx_spi_init_pdata(struct platform_device *pdev)
 {
-	struct pxa2xx_spi_master *pdata;
+	struct pxa2xx_spi_controller *pdata;
 	struct acpi_device *adev;
 	struct ssp_device *ssp;
 	struct resource *res;
@@ -1568,10 +1568,10 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	return pdata;
 }
 
-static int pxa2xx_spi_fw_translate_cs(struct spi_controller *master,
+static int pxa2xx_spi_fw_translate_cs(struct spi_controller *controller,
 				      unsigned int cs)
 {
-	struct driver_data *drv_data = spi_controller_get_devdata(master);
+	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
 	if (has_acpi_companion(&drv_data->pdev->dev)) {
 		switch (drv_data->ssp_type) {
@@ -1595,8 +1595,8 @@ static int pxa2xx_spi_fw_translate_cs(struct spi_controller *master,
 static int pxa2xx_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct pxa2xx_spi_master *platform_info;
-	struct spi_controller *master;
+	struct pxa2xx_spi_controller *platform_info;
+	struct spi_controller *controller;
 	struct driver_data *drv_data;
 	struct ssp_device *ssp;
 	const struct lpss_config *config;
@@ -1622,37 +1622,37 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	}
 
 	if (platform_info->is_slave)
-		master = spi_alloc_slave(dev, sizeof(struct driver_data));
+		controller = spi_alloc_slave(dev, sizeof(struct driver_data));
 	else
-		master = spi_alloc_master(dev, sizeof(struct driver_data));
+		controller = spi_alloc_master(dev, sizeof(struct driver_data));
 
-	if (!master) {
-		dev_err(&pdev->dev, "cannot alloc spi_master\n");
+	if (!controller) {
+		dev_err(&pdev->dev, "cannot alloc spi_controller\n");
 		pxa_ssp_free(ssp);
 		return -ENOMEM;
 	}
-	drv_data = spi_controller_get_devdata(master);
-	drv_data->master = master;
-	drv_data->master_info = platform_info;
+	drv_data = spi_controller_get_devdata(controller);
+	drv_data->controller = controller;
+	drv_data->controller_info = platform_info;
 	drv_data->pdev = pdev;
 	drv_data->ssp = ssp;
 
-	master->dev.of_node = pdev->dev.of_node;
+	controller->dev.of_node = pdev->dev.of_node;
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
-
-	master->bus_num = ssp->port_id;
-	master->dma_alignment = DMA_ALIGNMENT;
-	master->cleanup = cleanup;
-	master->setup = setup;
-	master->set_cs = pxa2xx_spi_set_cs;
-	master->transfer_one = pxa2xx_spi_transfer_one;
-	master->slave_abort = pxa2xx_spi_slave_abort;
-	master->handle_err = pxa2xx_spi_handle_err;
-	master->unprepare_transfer_hardware = pxa2xx_spi_unprepare_transfer;
-	master->fw_translate_cs = pxa2xx_spi_fw_translate_cs;
-	master->auto_runtime_pm = true;
-	master->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
+	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
+
+	controller->bus_num = ssp->port_id;
+	controller->dma_alignment = DMA_ALIGNMENT;
+	controller->cleanup = cleanup;
+	controller->setup = setup;
+	controller->set_cs = pxa2xx_spi_set_cs;
+	controller->transfer_one = pxa2xx_spi_transfer_one;
+	controller->slave_abort = pxa2xx_spi_slave_abort;
+	controller->handle_err = pxa2xx_spi_handle_err;
+	controller->unprepare_transfer_hardware = pxa2xx_spi_unprepare_transfer;
+	controller->fw_translate_cs = pxa2xx_spi_fw_translate_cs;
+	controller->auto_runtime_pm = true;
+	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
 
 	drv_data->ssp_type = ssp->type;
 
@@ -1661,10 +1661,10 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	if (pxa25x_ssp_comp(drv_data)) {
 		switch (drv_data->ssp_type) {
 		case QUARK_X1000_SSP:
-			master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+			controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 			break;
 		default:
-			master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
+			controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
 			break;
 		}
 
@@ -1673,7 +1673,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		drv_data->clear_sr = SSSR_ROR;
 		drv_data->mask_sr = SSSR_RFS | SSSR_TFS | SSSR_ROR;
 	} else {
-		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+		controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 		drv_data->int_cr1 = SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE;
 		drv_data->dma_cr1 = DEFAULT_DMA_CR1;
 		drv_data->clear_sr = SSSR_ROR | SSSR_TINT;
@@ -1685,7 +1685,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 			drv_data);
 	if (status < 0) {
 		dev_err(&pdev->dev, "cannot get IRQ %d\n", ssp->irq);
-		goto out_error_master_alloc;
+		goto out_error_controller_alloc;
 	}
 
 	/* Setup DMA if requested */
@@ -1695,7 +1695,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 			dev_dbg(dev, "no DMA channels available, using PIO\n");
 			platform_info->enable_dma = false;
 		} else {
-			master->can_dma = pxa2xx_spi_can_dma;
+			controller->can_dma = pxa2xx_spi_can_dma;
 		}
 	}
 
@@ -1704,7 +1704,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	if (status)
 		goto out_error_dma_irq_alloc;
 
-	master->max_speed_hz = clk_get_rate(ssp->clk);
+	controller->max_speed_hz = clk_get_rate(ssp->clk);
 
 	/* Load default SSP configuration */
 	pxa2xx_spi_write(drv_data, SSCR0, 0);
@@ -1727,7 +1727,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		break;
 	default:
 
-		if (spi_controller_is_slave(master)) {
+		if (spi_controller_is_slave(controller)) {
 			tmp = SSCR1_SCFR |
 			      SSCR1_SCLKDIR |
 			      SSCR1_SFRMDIR |
@@ -1740,7 +1740,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		}
 		pxa2xx_spi_write(drv_data, SSCR1, tmp);
 		tmp = SSCR0_Motorola | SSCR0_DataSize(8);
-		if (!spi_controller_is_slave(master))
+		if (!spi_controller_is_slave(controller))
 			tmp |= SSCR0_SCR(2);
 		pxa2xx_spi_write(drv_data, SSCR0, tmp);
 		break;
@@ -1765,24 +1765,24 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 			platform_info->num_chipselect = config->cs_num;
 		}
 	}
-	master->num_chipselect = platform_info->num_chipselect;
+	controller->num_chipselect = platform_info->num_chipselect;
 
 	count = gpiod_count(&pdev->dev, "cs");
 	if (count > 0) {
 		int i;
 
-		master->num_chipselect = max_t(int, count,
-			master->num_chipselect);
+		controller->num_chipselect = max_t(int, count,
+			controller->num_chipselect);
 
 		drv_data->cs_gpiods = devm_kcalloc(&pdev->dev,
-			master->num_chipselect, sizeof(struct gpio_desc *),
+			controller->num_chipselect, sizeof(struct gpio_desc *),
 			GFP_KERNEL);
 		if (!drv_data->cs_gpiods) {
 			status = -ENOMEM;
 			goto out_error_clock_enabled;
 		}
 
-		for (i = 0; i < master->num_chipselect; i++) {
+		for (i = 0; i < controller->num_chipselect; i++) {
 			struct gpio_desc *gpiod;
 
 			gpiod = devm_gpiod_get_index(dev, "cs", i, GPIOD_ASIS);
@@ -1815,9 +1815,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 
 	/* Register with the SPI framework */
 	platform_set_drvdata(pdev, drv_data);
-	status = devm_spi_register_controller(&pdev->dev, master);
+	status = devm_spi_register_controller(&pdev->dev, controller);
 	if (status != 0) {
-		dev_err(&pdev->dev, "problem registering spi master\n");
+		dev_err(&pdev->dev, "problem registering spi controller\n");
 		goto out_error_clock_enabled;
 	}
 
@@ -1832,8 +1832,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	pxa2xx_spi_dma_release(drv_data);
 	free_irq(ssp->irq, drv_data);
 
-out_error_master_alloc:
-	spi_controller_put(master);
+out_error_controller_alloc:
+	spi_controller_put(controller);
 	pxa_ssp_free(ssp);
 	return status;
 }
@@ -1854,7 +1854,7 @@ static int pxa2xx_spi_remove(struct platform_device *pdev)
 	clk_disable_unprepare(ssp->clk);
 
 	/* Release DMA */
-	if (drv_data->master_info->enable_dma)
+	if (drv_data->controller_info->enable_dma)
 		pxa2xx_spi_dma_release(drv_data);
 
 	pm_runtime_put_noidle(&pdev->dev);
@@ -1876,7 +1876,7 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	struct ssp_device *ssp = drv_data->ssp;
 	int status;
 
-	status = spi_controller_suspend(drv_data->master);
+	status = spi_controller_suspend(drv_data->controller);
 	if (status != 0)
 		return status;
 	pxa2xx_spi_write(drv_data, SSCR0, 0);
@@ -1901,7 +1901,7 @@ static int pxa2xx_spi_resume(struct device *dev)
 	}
 
 	/* Start the queue running */
-	return spi_controller_resume(drv_data->master);
+	return spi_controller_resume(drv_data->controller);
 }
 #endif
 
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 4e324da66ef7..aba777b4502d 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -31,10 +31,10 @@ struct driver_data {
 
 	/* SPI framework hookup */
 	enum pxa_ssp_type ssp_type;
-	struct spi_controller *master;
+	struct spi_controller *controller;
 
 	/* PXA hookup */
-	struct pxa2xx_spi_master *master_info;
+	struct pxa2xx_spi_controller *controller_info;
 
 	/* SSP register addresses */
 	void __iomem *ioaddr;
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index b0674e330ef6..c1c59473cef9 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -22,7 +22,7 @@
 struct dma_chan;
 
 /* device.platform_data for SSP controller devices */
-struct pxa2xx_spi_master {
+struct pxa2xx_spi_controller {
 	u16 num_chipselect;
 	u8 enable_dma;
 	bool is_slave;
@@ -54,7 +54,7 @@ struct pxa2xx_spi_chip {
 
 #include <linux/clk.h>
 
-extern void pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_master *info);
+extern void pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_controller *info);
 
 #endif
 #endif
-- 
2.20.1

