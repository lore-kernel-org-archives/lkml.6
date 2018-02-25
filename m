Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeBYNwj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 08:52:39 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33137 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbeBYNwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 08:52:36 -0500
X-Google-Smtp-Source: AH8x227zd0aNqkRbQ8QcCUou/X9OTOtCu0ny7orz9/TxkJVPCmuKHsoKuX03/XahwtyZFDrzqvIRcw==
Date: Sun, 25 Feb 2018 21:52:25 +0800
From: hao_zhang <hao5781286@gmail.com>
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, wens@csie.org, maxime.ripard@free-electrons.com,
        Claudiu.Beznea@microchip.com
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com,
        hao5781286@gmail.com
Subject: [PATCH v2 3/4] ARM: dts: add pwm status for r40.
Message-ID: <20180225135225.GA14544@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds pwm status for r40.

Signed-off-by: hao_zhang <hao5781286@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 8c5efe2..e4eb074 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -196,6 +196,12 @@
 	status = "okay";
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_ch0_pin>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.7.4
