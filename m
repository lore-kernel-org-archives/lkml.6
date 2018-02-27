Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeB0Upj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 15:45:39 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33664 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeB0Upi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 15:45:38 -0500
X-Google-Smtp-Source: AG47ELuDDvKMQelXFmGNOY4QCpGFCz5snxm0nSFhl3OsZaWv6V268WjWz4xvKU7yj4HnaY11S/Wf3g==
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: andrew@lunn.ch, vivien.didelot@savoirfairelinux.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: NSP: Switch to port 8 for CPU port
Date: Tue, 27 Feb 2018 12:45:19 -0800
Message-Id: <20180227204520.24122-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have added support for pre-pended Broadcom tags with commit
11606039604c ("net: dsa: b53: Support prepended Broadcom tags") we can
switch all the Northstar Plus reference boards to use port 8 for the CPU
port. This allows us to prepare room for supporting the Flow Accelerator
2 NAPT offload, and frees up port 5 to be made fully configurable for
the modes that it supports: internal, SGMII, RGMII etc.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm958622hr.dts | 6 +++---
 arch/arm/boot/dts/bcm958623hr.dts | 6 +++---
 arch/arm/boot/dts/bcm958625hr.dts | 6 +++---
 arch/arm/boot/dts/bcm958625k.dts  | 6 +++---
 arch/arm/boot/dts/bcm988312hr.dts | 6 +++---
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/bcm958622hr.dts
index fd8b8c689ffe..ecd05e26c262 100644
--- a/arch/arm/boot/dts/bcm958622hr.dts
+++ b/arch/arm/boot/dts/bcm958622hr.dts
@@ -204,10 +204,10 @@
 			reg = <4>;
 		};
 
-		port@5 {
-			ethernet = <&amac0>;
+		port@8 {
+			ethernet = <&amac2>;
 			label = "cpu";
-			reg = <5>;
+			reg = <8>;
 			fixed-link {
 				speed = <1000>;
 				full-duplex;
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index b8bde13de90a..f5e85b301497 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -208,10 +208,10 @@
 			reg = <4>;
 		};
 
-		port@5 {
-			ethernet = <&amac0>;
+		port@8 {
+			ethernet = <&amac2>;
 			label = "cpu";
-			reg = <5>;
+			reg = <8>;
 			fixed-link {
 				speed = <1000>;
 				full-duplex;
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index 6a44b8021702..094db4ba8eb3 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -210,10 +210,10 @@
 			reg = <4>;
 		};
 
-		port@5 {
-			ethernet = <&amac0>;
+		port@8 {
+			ethernet = <&amac2>;
 			label = "cpu";
-			reg = <5>;
+			reg = <8>;
 			fixed-link {
 				speed = <1000>;
 				full-duplex;
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index 2cf2392483b2..3ea5f739e90b 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -245,10 +245,10 @@
 			reg = <4>;
 		};
 
-		port@5 {
-			ethernet = <&amac0>;
+		port@8 {
+			ethernet = <&amac2>;
 			label = "cpu";
-			reg = <5>;
+			reg = <8>;
 			fixed-link {
 				speed = <1000>;
 				full-duplex;
diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/bcm988312hr.dts
index bce251a68591..ea9a0806b446 100644
--- a/arch/arm/boot/dts/bcm988312hr.dts
+++ b/arch/arm/boot/dts/bcm988312hr.dts
@@ -216,10 +216,10 @@
 			reg = <4>;
 		};
 
-		port@5 {
-			ethernet = <&amac0>;
+		port@8 {
+			ethernet = <&amac2>;
 			label = "cpu";
-			reg = <5>;
+			reg = <8>;
 			fixed-link {
 				speed = <1000>;
 				full-duplex;
-- 
2.14.1
