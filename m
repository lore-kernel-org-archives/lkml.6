Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeEMXTQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 19:19:16 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40102 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbeEMXTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 19:19:13 -0400
X-Google-Smtp-Source: AB8JxZoImnE/nBEjLfLujpNC/I/yQHKGcwYOx5N47dG8zEFJQIfR40TAoDLDq0qhGp52DEVZiYcWbg==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: bcousson@baylibre.com
Cc: tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH] ARM: dts: am335x-baltos.dtsi: Use IRQ_TYPE specifier
Date: Sun, 13 May 2018 20:19:03 -0300
Message-Id: <1526253543-3395-1-git-send-email-hernan@vanguardiasur.com.ar>
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
 arch/arm/boot/dts/am335x-baltos.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
index ec6052c..ed7a5a3 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -249,7 +249,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <28 GPIO_ACTIVE_LOW>;
+		interrupts = <28 IRQ_TYPE_EDGE_RISING>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tps65910_pins>;
 	};
-- 
2.7.4
