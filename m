Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758246AbeD0MMJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 08:12:09 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:62419 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758094AbeD0MJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 08:09:43 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <kishon@ti.com>
Subject: [PATCH v4 07/14] ARM: dts: am57xx-beagle-x15/am57xx-idk: Fix pinctrl-names
Date: Fri, 27 Apr 2018 17:38:58 +0530
Message-ID: <20180427120905.3665-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427120905.3665-1-kishon@ti.com>
References: <20180427120905.3665-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IO lines of MMC2 in am57xx-beagle-x15/am57xx-idk is connected to
3.3v. Use "ddr_3_3v" instead of "ddr_1_8v" to indicate DDR mode
works in 3.3v on these boards.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts        | 2 +-
 arch/arm/boot/dts/am572x-idk.dts        | 2 +-
 arch/arm/boot/dts/am574x-idk.dts        | 2 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index f7de03eb4377..5bb9d68d6e90 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -113,7 +113,7 @@
 };
 
 &mmc2 {
-	pinctrl-names = "default", "hs", "ddr_1_8v";
+	pinctrl-names = "default", "hs", "ddr_3_3v";
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_hs>;
 	pinctrl-2 = <&mmc2_pins_ddr_rev20 &mmc2_iodelay_ddr_conf>;
diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index 98b42ef33c46..3ef9111d0e8b 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -31,7 +31,7 @@
 };
 
 &mmc2 {
-	pinctrl-names = "default", "hs", "ddr_1_8v";
+	pinctrl-names = "default", "hs", "ddr_3_3v";
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_hs>;
 	pinctrl-2 = <&mmc2_pins_ddr_rev20>;
diff --git a/arch/arm/boot/dts/am574x-idk.dts b/arch/arm/boot/dts/am574x-idk.dts
index c7718b2d9fdf..378dfa780ac1 100644
--- a/arch/arm/boot/dts/am574x-idk.dts
+++ b/arch/arm/boot/dts/am574x-idk.dts
@@ -35,7 +35,7 @@
 };
 
 &mmc2 {
-	pinctrl-names = "default", "hs", "ddr_1_8v";
+	pinctrl-names = "default", "hs", "ddr_3_3v";
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_default>;
 	pinctrl-2 = <&mmc2_pins_default>;
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index d6689106d2a8..c76ea6579a81 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -28,7 +28,7 @@
 };
 
 &mmc2 {
-	pinctrl-names = "default", "hs", "ddr_1_8v";
+	pinctrl-names = "default", "hs", "ddr_3_3v";
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_hs>;
 	pinctrl-2 = <&mmc2_pins_ddr_3_3v_rev11 &mmc2_iodelay_ddr_3_3v_rev11_conf>;
-- 
2.17.0
