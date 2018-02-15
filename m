Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755074AbeBOIVS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 03:21:18 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:14383 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754879AbeBOIVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 03:21:14 -0500
From: Philippe Cornu <philippe.cornu@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Vincent Abriou" <vincent.abriou@st.com>
Subject: [PATCH 1/3] ARM: dts: stm32: Add dt-bindings gpio.h include on stm32f469-disco
Date: Thu, 15 Feb 2018 09:20:12 +0100
Message-ID: <20180215082014.30383-2-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215082014.30383-1-philippe.cornu@st.com>
References: <20180215082014.30383-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.6.172]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings/gpio/gpio.h include and use it on vcc5v_otg.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index bdd03ac7a4b5..7d53b794d27b 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -48,6 +48,7 @@
 /dts-v1/;
 #include "stm32f429.dtsi"
 #include "stm32f469-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "STMicroelectronics STM32F469i-DISCO board";
@@ -74,7 +75,7 @@
 	vcc5v_otg: vcc5v-otg-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpiob 2 0>;
+		gpio = <&gpiob 2 GPIO_ACTIVE_HIGH>;
 		regulator-name = "vcc5_host1";
 		regulator-always-on;
 	};
-- 
2.15.1
