Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeBUJAe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:00:34 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:43249 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbeBUJAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:00:31 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: arm@kernel.org, Jesper Nilsson <jespern@axis.com>,
        Lars Persson <larper@axis.com>, Niklas Cassel <niklass@axis.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@axis.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] ARM: dts: artpec: remove 0x prefix from clkctrl unit address
Date: Wed, 21 Feb 2018 09:59:55 +0100
Message-Id: <20180221090000.18091-4-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180221090000.18091-1-niklas.cassel@axis.com>
References: <20180221090000.18091-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 0x prefix from clkctrl unit address.

This silences the following dtc warning:
Warning (unit_address_format):
 Node /clkctrl@0xf8000000 unit name should not have leading "0x"

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 arch/arm/boot/dts/artpec6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index d9776a97d8ff..f4b39738f1ac 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -98,7 +98,7 @@
 		clock-frequency = <125000000>;
 	};
 
-	clkctrl: clkctrl@0xf8000000 {
+	clkctrl: clkctrl@f8000000 {
 		#clock-cells = <1>;
 		compatible = "axis,artpec6-clkctrl";
 		reg = <0xf8000000 0x48>;
-- 
2.14.2
