Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeCOQZe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:25:34 -0400
Received: from h1.radempa.de ([176.9.142.194]:52210 "EHLO mail.cosmopool.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752084AbeCOQZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:25:30 -0400
From: Harald Geyer <harald@ccbib.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>, info@olimex.com,
        Harald Geyer <harald@ccbib.org>
Subject: [PATCHv2 1/5] arm64: dts: allwinner: a64: Add i2c0 pins
Date: Thu, 15 Mar 2018 16:25:06 +0000
Message-Id: <20180315162510.11669-2-harald@ccbib.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180315162510.11669-1-harald@ccbib.org>
References: <20180315162510.11669-1-harald@ccbib.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the proper pin group node to reference in board files.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Harald Geyer <harald@ccbib.org>
---
changes since v1: none

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b6dc31e7d91..64e452a758fa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -309,6 +309,11 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			i2c0_pins: i2c0_pins {
+				pins = "PH0", "PH1";
+				function = "i2c0";
+			};
+
 			i2c1_pins: i2c1_pins {
 				pins = "PH2", "PH3";
 				function = "i2c1";
-- 
2.11.0
