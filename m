Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeBWOCO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:02:14 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38073 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbeBWOCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:02:12 -0500
X-Google-Smtp-Source: AH8x225cXbwT6YPlUvg1W8avI7jufJYVF4fpYtXgSeDDfKhZA3biCj+0/ttrxjuqkv/PyvgBNS7Hsg==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
Cc: robh+dt@kernel.org,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        devicetree@vger.kernel.org, monstr@monstr.eu,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Rob Herring <robherring2@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Cartwright <josh.cartwright@ni.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH] arm: zynq: Use i2c-mux instead of i2cswitch for pca9548
Date: Fri, 23 Feb 2018 15:02:09 +0100
Message-Id: <5ea002abef0c3c2ef7fe04360c916c0db72f2619.1519394527.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i2c muxes should described like this.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Based on Rob's comment https://patchwork.kernel.org/patch/10175211/

---
 arch/arm/boot/dts/zynq-zc702.dts | 2 +-
 arch/arm/boot/dts/zynq-zc706.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index d96979644e49..c0384376d7e0 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -105,7 +105,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c0_default>;
 
-	i2cswitch@74 {
+	i2c-mux@74 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index d0f51d0d6c95..886d20c4fdd5 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -61,7 +61,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c0_default>;
 
-	i2cswitch@74 {
+	i2c-mux@74 {
 		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.9.1
