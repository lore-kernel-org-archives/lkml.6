Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeEBLeM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:34:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37235 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeEBLeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:34:09 -0400
X-Google-Smtp-Source: AB8JxZo+nPglcLNbRQtxseBVqJVLOh3Y9E8hY8lsCEihCWXA0WdRWOQJb48BVZ5d+uVqHuZoq374ww==
From: Michal Simek <michal.simek@xilinx.com>
To: devicetree@vger.kernel.org
Cc: monstr@monstr.eu, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: zynqmp: Remove #address/#size-cells from gpio-keys
Date: Wed,  2 May 2018 13:34:06 +0200
Message-Id: <cc96e8372881438fb069d49126ab713fa03fb074.1525260692.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dts reports incorrect usage of these properties in gpio-keys node.
Warning (avoid_unnecessary_addr_size): /gpio-keys: unnecessary

The patch is removing these useless properties.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 --
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 2 --
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 2 --
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 2 --
 4 files changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index c7f713c8e69e..eb5e8bddb610 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -44,8 +44,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 		sw4 {
 			label = "sw4";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 5b4ffe646a9b..25dd57485323 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -41,8 +41,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 		sw19 {
 			label = "sw19";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 668f7f26716a..259f21b0c001 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -41,8 +41,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 		sw19 {
 			label = "sw19";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 9a9dd6a0142b..a61b3cc6f4c9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -41,8 +41,6 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		autorepeat;
 		sw19 {
 			label = "sw19";
-- 
2.17.0
