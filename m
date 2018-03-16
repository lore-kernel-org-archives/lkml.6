Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753719AbeCPLLw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:11:52 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:62630 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753585AbeCPLLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:11:49 -0400
From: Roger Quadros <rogerq@ti.com>
To: <tony@atomide.com>
CC: <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH] ARM: dts: am43xx: Enable dual-role mode for USB1
Date: Fri, 16 Mar 2018 13:11:43 +0200
Message-ID: <1521198703-27352-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB1 port is micro-AB type and can function as peripheral
as well as host. Enable dual-role mode for USB1.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
Tony,

The USB driver side patches are already in Felipe's next branch.

 arch/arm/boot/dts/am437x-gp-evm.dts  | 2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts  | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index c3b1a3f..8fe95cd 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -805,7 +805,7 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 3fa3b22..4118802 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -600,7 +600,7 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_pins>;
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 00c3d1d..a669418 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -856,7 +856,7 @@
 };
 
 &usb1 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
 	status = "okay";
 };
 
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
