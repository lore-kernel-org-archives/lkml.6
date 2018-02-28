Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeB1Oz0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:55:26 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:13679 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752662AbeB1OzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:55:24 -0500
X-IronPort-AV: E=Sophos;i="5.47,406,1515481200";
   d="scan'208";a="12468265"
From: Nicolas Ferre <nicolas.ferre@microchip.com>
To: <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <linux-kernel@vger.kernel.org>, ARM Maintainers <arm@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 2/3] Documentation: at91: Update Microchip SoC documentation
Date: Wed, 28 Feb 2018 15:56:42 +0100
Message-ID: <761f49f4a1b8be4fd423a3db586bdca563ea5575.1519829594.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <c00e7bf21945e844c6154b374924b7ff520d1316.1519829594.git.nicolas.ferre@microchip.com>
References: <c00e7bf21945e844c6154b374924b7ff520d1316.1519829594.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We move the former Atmel wording to the the new Microchip name for this SoC
family. With the name of the directory we also change the content
in relation with the update of the MAINTAINERS file.
The Datasheet links now point to real documents instead of 404s.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 Documentation/arm/{Atmel => Microchip}/README | 52 +++++++++++++--------------
 1 file changed, 25 insertions(+), 27 deletions(-)
 rename Documentation/arm/{Atmel => Microchip}/README (64%)

diff --git a/Documentation/arm/Atmel/README b/Documentation/arm/Microchip/README
similarity index 64%
rename from Documentation/arm/Atmel/README
rename to Documentation/arm/Microchip/README
index afb13c15389d..a366f37d38f1 100644
--- a/Documentation/arm/Atmel/README
+++ b/Documentation/arm/Microchip/README
@@ -1,54 +1,54 @@
-ARM Atmel SoCs (aka AT91)
-=========================
+ARM Microchip SoCs (aka AT91)
+=============================
 
 
 Introduction
 ------------
-This document gives useful information about the ARM Atmel SoCs that are
+This document gives useful information about the ARM Microchip SoCs that are
 currently supported in Linux Mainline (you know, the one on kernel.org).
 
-It is important to note that the Atmel | SMART ARM-based MPU product line is
-historically named "AT91" or "at91" throughout the Linux kernel development
-process even if this product prefix has completely disappeared from the
-official Atmel product name. Anyway, files, directories, git trees,
+It is important to note that the Microchip (previously Atmel) ARM-based MPU
+product line is historically named "AT91" or "at91" throughout the Linux kernel
+development process even if this product prefix has completely disappeared from
+the official Microchip product name. Anyway, files, directories, git trees,
 git branches/tags and email subject always contain this "at91" sub-string.
 
 
 AT91 SoCs
 ---------
 Documentation and detailed datasheet for each product are available on
-the Atmel website: http://www.atmel.com.
+the Microchip website: http://www.microchip.com.
 
   Flavors:
     * ARM 920 based SoC
       - at91rm9200
         + Datasheet
-          http://www.atmel.com/Images/doc1768.pdf
+          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-1768-32-bit-ARM920T-Embedded-Microprocessor-AT91RM9200_Datasheet.pdf
 
     * ARM 926 based SoCs
       - at91sam9260
         + Datasheet
-          http://www.atmel.com/Images/doc6221.pdf
+          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6221-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9260_Datasheet.pdf
 
       - at91sam9xe
         + Datasheet
-          http://www.atmel.com/Images/Atmel-6254-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9XE_Datasheet.pdf
+          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6254-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9XE_Datasheet.pdf
 
       - at91sam9261
         + Datasheet
-          http://www.atmel.com/Images/doc6062.pdf
+          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6062-ARM926EJ-S-Microprocessor-SAM9261_Datasheet.pdf
 
       - at91sam9263
         + Datasheet
-          http://www.atmel.com/Images/Atmel_6249_32-bit-ARM926EJ-S-Microcontroller_SAM9263_Datasheet.pdf
+          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6249-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9263_Datasheet.pdf
 
       - at91sam9rl
         + Datasheet
-          http://www.atmel.com/Images/doc6289.pdf
+          http://ww1.microchip.com/downloads/en/DeviceDoc/doc6289.pdf
 
       - at91sam9g20
         + Datasheet
-          http://www.atmel.com/Images/doc6384.pdf
+          http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001516A.pdf
 
       - at91sam9g45 family
         - at91sam9g45
@@ -56,7 +56,7 @@ the Atmel website: http://www.atmel.com.
         - at91sam9m10
         - at91sam9m11 (device superset)
         + Datasheet
-          http://www.atmel.com/Images/Atmel-6437-32-bit-ARM926-Embedded-Microprocessor-SAM9M11_Datasheet.pdf
+          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6437-32-bit-ARM926-Embedded-Microprocessor-SAM9M11_Datasheet.pdf
 
       - at91sam9x5 family (aka "The 5 series")
         - at91sam9g15
@@ -65,11 +65,11 @@ the Atmel website: http://www.atmel.com.
         - at91sam9x25
         - at91sam9x35
         + Datasheet (can be considered as covering the whole family)
-          http://www.atmel.com/Images/Atmel_11055_32-bit-ARM926EJ-S-Microcontroller_SAM9X35_Datasheet.pdf
+          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11055-32-bit-ARM926EJ-S-Microcontroller-SAM9X35_Datasheet.pdf
 
       - at91sam9n12
         + Datasheet
-          http://www.atmel.com/Images/Atmel_11063_32-bit-ARM926EJ-S-Microcontroller_SAM9N12CN11CN12_Datasheet.pdf
+          http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001517A.pdf
 
     * ARM Cortex-A5 based SoCs
       - sama5d3 family
@@ -79,7 +79,7 @@ the Atmel website: http://www.atmel.com.
         - sama5d35
         - sama5d36 (device superset)
         + Datasheet
-          http://www.atmel.com/Images/Atmel-11121-32-bit-Cortex-A5-Microcontroller-SAMA5D3_Datasheet.pdf
+          http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11121-32-bit-Cortex-A5-Microcontroller-SAMA5D3_Datasheet.pdf
 
     * ARM Cortex-A5 + NEON based SoCs
       - sama5d4 family
@@ -88,7 +88,7 @@ the Atmel website: http://www.atmel.com.
         - sama5d43
         - sama5d44 (device superset)
         + Datasheet
-          http://www.atmel.com/Images/Atmel-11238-32-bit-Cortex-A5-Microcontroller-SAMA5D4_Datasheet.pdf
+          http://ww1.microchip.com/downloads/en/DeviceDoc/60001525A.pdf
 
       - sama5d2 family
         - sama5d21
@@ -99,7 +99,7 @@ the Atmel website: http://www.atmel.com.
         - sama5d27 (device superset)
         - sama5d28 (device superset + environmental monitors)
         + Datasheet
-          http://www.atmel.com/Images/Atmel-11267-32-bit-Cortex-A5-Microcontroller-SAMA5D2_Datasheet.pdf
+          http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf
 
     * ARM Cortex-M7 MCUs
       - sams70 family
@@ -112,8 +112,6 @@ the Atmel website: http://www.atmel.com.
         - sams70q19
         - sams70q20
         - sams70q21
-        + Datasheet
-          http://www.atmel.com/Images/Atmel-11242-32-bit-Cortex-M7-Microcontroller-SAM-S70Q-SAM-S70N-SAM-S70J_Datasheet.pdf
 
       - samv70 family
         - samv70j19
@@ -122,8 +120,6 @@ the Atmel website: http://www.atmel.com.
         - samv70n20
         - samv70q19
         - samv70q20
-        + Datasheet
-          http://www.atmel.com/Images/Atmel-11297-32-bit-Cortex-M7-Microcontroller-SAM-V70Q-SAM-V70N-SAM-V70J_Datasheet.pdf
 
       - samv71 family
         - samv71j19
@@ -135,13 +131,15 @@ the Atmel website: http://www.atmel.com.
         - samv71q19
         - samv71q20
         - samv71q21
+
         + Datasheet
-          http://www.atmel.com/Images/Atmel-44003-32-bit-Cortex-M7-Microcontroller-SAM-V71Q-SAM-V71N-SAM-V71J_Datasheet.pdf
+          http://ww1.microchip.com/downloads/en/DeviceDoc/60001527A.pdf
+
 
 Linux kernel information
 ------------------------
 Linux kernel mach directory: arch/arm/mach-at91
-MAINTAINERS entry is: "ARM/ATMEL AT91RM9200 AND AT91SAM ARM ARCHITECTURES"
+MAINTAINERS entry is: "ARM/Microchip (AT91) SoC support"
 
 
 Device Tree for AT91 SoCs and boards
-- 
2.15.1
