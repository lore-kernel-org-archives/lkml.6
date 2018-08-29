Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D17C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B5720850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B5720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbeH2S33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:29:29 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:38404 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeH2S32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:29:28 -0400
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="18999120"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Aug 2018 07:32:15 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Wed, 29 Aug 2018 07:32:14 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <miquel.raynal@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Boris BREZILLON <boris.brezillon@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 10/11] MAINTAINERS: move former ATMEL entries to proper MICROCHIP location
Date:   Wed, 29 Aug 2018 16:31:46 +0200
Message-ID: <f3231dd16d24c4c995cc2af7848d51a76bb49982.1535552609.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standardize the Microchip / Atmel entries with the same form and move them
so that they are all located at the same place, under the newer MICROCHIP
banner.
Only modifications to the titles of the entries are done in this patch.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 154 ++++++++++++++++++++++++++--------------------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e9b9a52bc6e..78044223d90f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2471,42 +2471,6 @@ F:	drivers/atm/
 F:	include/linux/atm*
 F:	include/uapi/linux/atm*
 
-ATMEL AT91 / AT32 MCI DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-S:	Maintained
-F:	drivers/mmc/host/atmel-mci.c
-
-ATMEL AT91 SAMA5D2-Compatible Shutdown Controller
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-S:	Supported
-F:	drivers/power/reset/at91-sama5d2_shdwc.c
-
-ATMEL Audio ALSA driver
-M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-S:	Supported
-F:	sound/soc/atmel
-
-ATMEL I2C DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-L:	linux-i2c@vger.kernel.org
-S:	Supported
-F:	drivers/i2c/busses/i2c-at91.c
-
-ATMEL ISI DRIVER
-M:	Eugen Hristev <eugen.hristev@microchip.com>
-L:	linux-media@vger.kernel.org
-S:	Supported
-F:	drivers/media/platform/atmel/atmel-isi.c
-F:	include/media/atmel-isi.h
-
-ATMEL LCDFB DRIVER
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-L:	linux-fbdev@vger.kernel.org
-S:	Maintained
-F:	drivers/video/fbdev/atmel_lcdfb.c
-F:	include/video/atmel_lcdc.h
-
 ATMEL MACB ETHERNET DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 S:	Supported
@@ -2519,46 +2483,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/input/atmel,maxtouch.txt
 F:	drivers/input/touchscreen/atmel_mxt_ts.c
 
-ATMEL SAMA5D2 ADC DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-M:	Eugen Hristev <eugen.hristev@microchip.com>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-F:	drivers/iio/adc/at91-sama5d2_adc.c
-F:	Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
-F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
-
 ATMEL SDMMC DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-mmc@vger.kernel.org
 S:	Supported
 F:	drivers/mmc/host/sdhci-of-at91.c
 
-ATMEL SPI DRIVER
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-S:	Supported
-F:	drivers/spi/spi-atmel.*
-
-ATMEL SSC DRIVER
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Supported
-F:	drivers/misc/atmel-ssc.c
-F:	include/linux/atmel-ssc.h
-
-ATMEL Timer Counter (TC) AND CLOCKSOURCE DRIVERS
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Supported
-F:	drivers/misc/atmel_tclib.c
-F:	drivers/clocksource/tcb_clksrc.c
-
-ATMEL USBA UDC DRIVER
-M:	Cristian Birsan <cristian.birsan@microchip.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Supported
-F:	drivers/usb/gadget/udc/atmel_usba_udc.*
-
 ATMEL WIRELESS DRIVER
 M:	Simon Kelley <simon@thekelleys.org.uk>
 L:	linux-wireless@vger.kernel.org
@@ -2567,13 +2497,6 @@ W:	http://atmelwlandriver.sourceforge.net/
 S:	Maintained
 F:	drivers/net/wireless/atmel/atmel*
 
-ATMEL XDMA DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-L:	linux-arm-kernel@lists.infradead.org
-L:	dmaengine@vger.kernel.org
-S:	Supported
-F:	drivers/dma/at_xdmac.c
-
 ATOMIC INFRASTRUCTURE
 M:	Will Deacon <will.deacon@arm.com>
 M:	Peter Zijlstra <peterz@infradead.org>
@@ -9507,6 +9430,12 @@ S:	Maintained
 F:	drivers/tty/serial/atmel_serial.c
 F:	drivers/tty/serial/atmel_serial.h
 
+MICROCHIP AUDIO ASOC DRIVERS
+M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Supported
+F:	sound/soc/atmel
+
 MICROCHIP DMA DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -9524,6 +9453,12 @@ L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/atmel-ecc.*
 
+MICROCHIP I2C DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+L:	linux-i2c@vger.kernel.org
+S:	Supported
+F:	drivers/i2c/busses/i2c-at91.c
+
 MICROCHIP ISC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-media@vger.kernel.org
@@ -9532,6 +9467,13 @@ F:	drivers/media/platform/atmel/atmel-isc.c
 F:	drivers/media/platform/atmel/atmel-isc-regs.h
 F:	devicetree/bindings/media/atmel-isc.txt
 
+MICROCHIP ISI DRIVER
+M:	Eugen Hristev <eugen.hristev@microchip.com>
+L:	linux-media@vger.kernel.org
+S:	Supported
+F:	drivers/media/platform/atmel/atmel-isi.c
+F:	include/media/atmel-isi.h
+
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
@@ -9549,6 +9491,18 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan743x_*
 
+MICROCHIP LCDFB DRIVER
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+L:	linux-fbdev@vger.kernel.org
+S:	Maintained
+F:	drivers/video/fbdev/atmel_lcdfb.c
+F:	include/video/atmel_lcdc.h
+
+MICROCHIP MMC/SD/SDIO MCI DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+S:	Maintained
+F:	drivers/mmc/host/atmel-mci.c
+
 MICROCHIP NAND DRIVER
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
 L:	linux-mtd@lists.infradead.org
@@ -9564,6 +9518,45 @@ S:	Supported
 F:	drivers/pwm/pwm-atmel.c
 F:	Documentation/devicetree/bindings/pwm/atmel-pwm.txt
 
+MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+M:	Eugen Hristev <eugen.hristev@microchip.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/adc/at91-sama5d2_adc.c
+F:	Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
+F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
+
+MICROCHIP SAMA5D2-COMPATIBLE SHUTDOWN CONTROLLER
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+S:	Supported
+F:	drivers/power/reset/at91-sama5d2_shdwc.c
+
+MICROCHIP SPI DRIVER
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+S:	Supported
+F:	drivers/spi/spi-atmel.*
+
+MICROCHIP SSC DRIVER
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/misc/atmel-ssc.c
+F:	include/linux/atmel-ssc.h
+
+MICROCHIP TIMER COUNTER (TC) AND CLOCKSOURCE DRIVERS
+M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/misc/atmel_tclib.c
+F:	drivers/clocksource/tcb_clksrc.c
+
+MICROCHIP USBA UDC DRIVER
+M:	Cristian Birsan <cristian.birsan@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/usb/gadget/udc/atmel_usba_udc.*
+
 MICROCHIP USB251XB DRIVER
 M:	Richard Leitner <richard.leitner@skidata.com>
 L:	linux-usb@vger.kernel.org
@@ -9571,6 +9564,13 @@ S:	Maintained
 F:	drivers/usb/misc/usb251xb.c
 F:	Documentation/devicetree/bindings/usb/usb251xb.txt
 
+MICROCHIP XDMA DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+L:	linux-arm-kernel@lists.infradead.org
+L:	dmaengine@vger.kernel.org
+S:	Supported
+F:	drivers/dma/at_xdmac.c
+
 MICROSEMI MIPS SOCS
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
 L:	linux-mips@linux-mips.org
-- 
2.17.1

