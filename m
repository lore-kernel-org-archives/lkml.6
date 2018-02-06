Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeBFNAU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:00:20 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:23855 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbeBFM70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:59:26 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ravikumar Kattekola <rk@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 11/15] ARM: dts: dra71-evm: Correct evm_sd regulator max voltage
Date: Tue, 6 Feb 2018 18:28:02 +0530
Message-ID: <20180206125806.19350-12-kishon@ti.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180206125806.19350-1-kishon@ti.com>
References: <20180206125806.19350-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravikumar Kattekola <rk@ti.com>

Correct vpo_sd_1v8_3v3 regulator max voltage to 3.3V

Fixes: 9868bc585ae2 ("ARM: dts: Add support for dra718-evm")
Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra71-evm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
index 41c9132eb550..64363f75c01a 100644
--- a/arch/arm/boot/dts/dra71-evm.dts
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -24,13 +24,13 @@
 
 		regulator-name = "vddshv8";
 		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3000000>;
+		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
 		vin-supply = <&evm_5v0>;
 
 		gpios = <&gpio7 11 GPIO_ACTIVE_HIGH>;
 		states = <1800000 0x0
-			  3000000 0x1>;
+			  3300000 0x1>;
 	};
 
 	evm_1v8_sw: fixedregulator-evm_1v8 {
-- 
2.11.0
