Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeEMXZG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 19:25:06 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42229 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbeEMXZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 19:25:04 -0400
X-Google-Smtp-Source: AB8JxZoIV5I0CAx1b5556NcgeUDBppAurfQS/IRall0yecsIioaO13uWC3TZ47FZ/Si3Uyfpe+jeBQ==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: shawnguo@kernel.org
Cc: s.hauer@pengutronix.de, kernel@pengutronix.de, stefan@agner.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH] ARM: dts: vf-colibri-eval-v3.dtsi: Use IRQ_TYPE specifier
Date: Sun, 13 May 2018 20:24:54 -0300
Message-Id: <1526253894-3709-1-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ACTIVE_LOW was being used to specify an interrupt, use
IRQ_TYPE_EDGE_RISING instead. This improves DT readability.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index d8b2972..e2da122 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -117,7 +117,7 @@
 		clocks = <&clk16m>;
 		spi-max-frequency = <10000000>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <11 GPIO_ACTIVE_LOW>;
+		interrupts = <11 IRQ_TYPE_EDGE_RISING>;
 	};
 };
 
-- 
2.7.4
