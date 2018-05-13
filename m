Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeEMXaD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 19:30:03 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40107 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbeEMXaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 19:30:02 -0400
X-Google-Smtp-Source: AB8JxZra7knslZTWMfdQLPBb4SlHFAICDp4rcOd4QukfVV29/JypJqUEQmAJm70bLTyvk6SYZ0xUvA==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: bcousson@baylibre.com
Cc: tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH] ARM: dts: omap3-pandora-common: Use IRQ_TYPE specifier
Date: Sun, 13 May 2018 20:29:52 -0300
Message-Id: <1526254192-4078-1-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace magic number with the proper IRQ_TYPE specifier to improve DT
readability.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index f83b102..2c98e23 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -611,7 +611,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&penirq_pins>;
 		interrupt-parent = <&gpio3>;
-		interrupts = <30 0>;	/* GPIO_94 */
+		interrupts = <30 IRQ_TYPE_NONE>;	/* GPIO_94 */
 		pendown-gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
 		vcc-supply = <&vaux4>;
 
-- 
2.7.4
