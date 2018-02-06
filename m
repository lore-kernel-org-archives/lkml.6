Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753128AbeBFM7e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:59:34 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:61993 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752921AbeBFM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:59:25 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 10/15] ARM: dts: dra76-evm: Add "vqmmc-supply" property for mmc2
Date: Tue, 6 Feb 2018 18:28:01 +0530
Message-ID: <20180206125806.19350-11-kishon@ti.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180206125806.19350-1-kishon@ti.com>
References: <20180206125806.19350-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "vqmmc-supply" property for mmc2 to indicate the supply connected
to the IO lines.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra76-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index 088853001c81..2deb96405d06 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -322,6 +322,7 @@
 &mmc2 {
 	status = "okay";
 	vmmc-supply = <&vio_1v8>;
+	vqmmc-supply = <&vio_1v8>;
 	bus-width = <8>;
 	pinctrl-names = "default", "hs", "ddr_1_8v", "hs200_1_8v";
 	pinctrl-0 = <&mmc2_pins_default>;
-- 
2.11.0
