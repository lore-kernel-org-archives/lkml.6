Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753922AbeD3Kg3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:36:29 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:1059 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbeD3KfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:35:21 -0400
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="13403009"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v4 8/9] ARM: dts: at91: sama5d2: add channel cells for ADC device
Date: Mon, 30 Apr 2018 13:32:14 +0300
Message-ID: <1525084335-11276-9-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525084335-11276-1-git-send-email-eugen.hristev@microchip.com>
References: <1525084335-11276-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparing the ADC device to connect channel consumer drivers

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 61f68e5..f06ba99 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -47,6 +47,7 @@
 #include <dt-bindings/dma/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
 
 / {
 	model = "Atmel SAMA5D2 family SoC";
@@ -1437,6 +1438,7 @@
 				atmel,max-sample-rate-hz = <20000000>;
 				atmel,startup-time-ms = <4>;
 				atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
+				#io-channel-cells = <1>;
 				status = "disabled";
 			};
 
-- 
2.7.4
