Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbeBJGlp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 01:41:45 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:51629 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeBJGlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 01:41:44 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] ARM: dts: armada: netgear-rn*: fix rtc node name
Date: Sat, 10 Feb 2018 07:41:30 +0100
Message-Id: <20180210064130.6422-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node name should be generic and must not contain the part number.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts | 2 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index b1a96e95e921..d2225bd4a76f 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -103,7 +103,7 @@
 
 				status = "okay";
 
-				isl12057: isl12057@68 {
+				isl12057: rtc@68 {
 					compatible = "isil,isl12057";
 					reg = <0x68>;
 					wakeup-source;
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index d67e7aa42b54..b73cae836bc1 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -105,7 +105,7 @@
 
 				status = "okay";
 
-				isl12057: isl12057@68 {
+				isl12057: rtc@68 {
 					compatible = "isil,isl12057";
 					reg = <0x68>;
 					wakeup-source;
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index 40c6fe21e720..e66fe80cf279 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -115,7 +115,7 @@
 					reg = <0x4c>;
 				};
 
-				isl12057: isl12057@68 {
+				isl12057: rtc@68 {
 					compatible = "isil,isl12057";
 					reg = <0x68>;
 					wakeup-source;
-- 
2.16.1
