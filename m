Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeB1Ozt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:55:49 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:26251 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbeB1OzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:55:25 -0500
X-IronPort-AV: E=Sophos;i="5.47,406,1515481200";
   d="scan'208";a="11853706"
From: Nicolas Ferre <nicolas.ferre@microchip.com>
To: <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <linux-kernel@vger.kernel.org>, ARM Maintainers <arm@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 3/3] ARM: at91: Kconfig: Update company to Microchip
Date: Wed, 28 Feb 2018 15:56:43 +0100
Message-ID: <2263d1871f18b8134187d53070830fd5398fb10a.1519829594.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <c00e7bf21945e844c6154b374924b7ff520d1316.1519829594.git.nicolas.ferre@microchip.com>
References: <c00e7bf21945e844c6154b374924b7ff520d1316.1519829594.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update AT91 Kconfig text and help to move from Atmel to Microchip.
The AT91 wording is kept in the title for historical reasons.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/mach-at91/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 6d870421a7a6..1254bf9d91b4 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -1,5 +1,5 @@
 menuconfig ARCH_AT91
-	bool "Atmel SoCs"
+	bool "AT91/Microchip SoCs"
 	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
 	select ARM_CPU_SUSPEND if PM && ARCH_MULTI_V7
 	select COMMON_CLK_AT91
@@ -13,7 +13,7 @@ config SOC_SAMV7
 	select COMMON_CLK_AT91
 	select PINCTRL_AT91
 	help
-	  Select this if you are using an SoC from Atmel's SAME7, SAMS7 or SAMV7
+	  Select this if you are using an SoC from Microchip's SAME7, SAMS7 or SAMV7
 	  families.
 
 config SOC_SAMA5D2
@@ -29,7 +29,7 @@ config SOC_SAMA5D2
 	select HAVE_AT91_AUDIO_PLL
 	select PINCTRL_AT91PIO4
 	help
-	  Select this if ou are using one of Atmel's SAMA5D2 family SoC.
+	  Select this if ou are using one of Microchip's SAMA5D2 family SoC.
 
 config SOC_SAMA5D3
 	bool "SAMA5D3 family"
@@ -41,7 +41,7 @@ config SOC_SAMA5D3
 	select HAVE_AT91_USB_CLK
 	select PINCTRL_AT91
 	help
-	  Select this if you are using one of Atmel's SAMA5D3 family SoC.
+	  Select this if you are using one of Microchip's SAMA5D3 family SoC.
 	  This support covers SAMA5D31, SAMA5D33, SAMA5D34, SAMA5D35, SAMA5D36.
 
 config SOC_SAMA5D4
@@ -56,7 +56,7 @@ config SOC_SAMA5D4
 	select HAVE_AT91_H32MX
 	select PINCTRL_AT91
 	help
-	  Select this if you are using one of Atmel's SAMA5D4 family SoC.
+	  Select this if you are using one of Microchip's SAMA5D4 family SoC.
 
 config SOC_AT91RM9200
 	bool "AT91RM9200"
@@ -70,7 +70,7 @@ config SOC_AT91RM9200
 	select SOC_SAM_V4_V5
 	select SRAM if PM
 	help
-	  Select this if you are using Atmel's AT91RM9200 SoC.
+	  Select this if you are using Microchip's AT91RM9200 SoC.
 
 config SOC_AT91SAM9
 	bool "AT91SAM9"
@@ -88,7 +88,7 @@ config SOC_AT91SAM9
 	select SOC_SAM_V4_V5
 	select SRAM if PM
 	help
-	  Select this if you are using one of those Atmel SoC:
+	  Select this if you are using one of those Microchip SoC:
 	    AT91SAM9260
 	    AT91SAM9261
 	    AT91SAM9263
-- 
2.15.1
