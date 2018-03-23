Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeCWJcS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:32:18 -0400
Received: from mx1.emlix.com ([46.4.235.150]:33612 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeCWJcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:32:16 -0400
From: Philipp Puschmann <pp@emlix.com>
To: dinguyen@kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Philipp Puschmann <pp@emlix.com>
Subject: [PATCH] arm: dts: socfpga: fix GIC PPI warning
Date: Fri, 23 Mar 2018 10:22:15 +0100
Message-Id: <20180323092215.1307-1-pp@emlix.com>
Organization: emlix gmbh, Goettingen, Germany
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the warning "GIC: PPI13 is secure or misconfigured" by
changing the interrupt type from level_low to edge_raising

Signed-off-by: Philipp Puschmann <pp@emlix.com>
---
 arch/arm/boot/dts/socfpga.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 595eb4f1a761..e9417551d7ea 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -815,7 +815,7 @@
 		timer@fffec600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xfffec600 0x100>;
-			interrupts = <1 13 0xf04>;
+			interrupts = <1 13 0xf01>;
 			clocks = <&mpu_periph_clk>;
 		};
 
-- 
2.16.2
