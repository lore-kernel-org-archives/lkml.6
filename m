Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeDQJpT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:45:19 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33226 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeDQJpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:45:17 -0400
X-Google-Smtp-Source: AIpwx4+uI+5Hqlo87/FMeMrcEvcJ7i0j+NLzK1myPembtpD35BLkKk9CGFJZS+1T3jaGXxnxAeAnHA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH] ARM: dts: consistently use 'atmel' as at24 manufacturer in cyclone5
Date: Tue, 17 Apr 2018 11:45:13 +0200
Message-Id: <20180417094513.7627-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using 'at' or 'at24' as the <manufacturer> part of the compatible
string is now deprecated. Use a correct value: 'atmel,<model>'.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
index 2459d133f1be..f50b19447de6 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
@@ -161,7 +161,7 @@
 	};
 
 	at24@50 {
-		compatible = "at24,24c01";
+		compatible = "atmel,24c01";
 		pagesize = <8>;
 		reg = <0x50>;
 	};
@@ -213,7 +213,7 @@
 			#size-cells = <0>;
 			reg = <6>;
 			eeprom@51 {
-				compatible = "at,24c01";
+				compatible = "atmel,24c01";
 				pagesize = <8>;
 				reg = <0x51>;
 			};
@@ -224,7 +224,7 @@
 			#size-cells = <0>;
 			reg = <7>;
 			eeprom@51 {
-				compatible = "at,24c01";
+				compatible = "atmel,24c01";
 				pagesize = <8>;
 				reg = <0x51>;
 			};
-- 
2.17.0
