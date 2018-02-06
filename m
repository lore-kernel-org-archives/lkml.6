Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeBFNDE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:03:04 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:61975 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753019AbeBFM7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:59:06 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 06/15] ARM: dts: am57xx-beagle-x15: Add "vqmmc-supply" property for mmc2
Date: Tue, 6 Feb 2018 18:27:57 +0530
Message-ID: <20180206125806.19350-7-kishon@ti.com>
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
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 441c25677679..7539096fe4d8 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -442,6 +442,7 @@
 	pinctrl-0 = <&mmc2_pins_default>;
 
 	vmmc-supply = <&vdd_3v3>;
+	vqmmc-supply = <&vdd_3v3>;
 	bus-width = <8>;
 	ti,non-removable;
 	cap-mmc-dual-data-rate;
-- 
2.11.0
