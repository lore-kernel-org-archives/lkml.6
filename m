Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbeDQN5h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:57:37 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38240 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753392AbeDQN5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:57:34 -0400
X-Google-Smtp-Source: AIpwx4/WjxSZxvfVIA5Imx3v+sEKMiTsHzjN/4cdYLGEBbVAFmiKQioWFzTZfclVGQjNyOKwZ6Y/5g==
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tanmay Inamdar <tinamdar@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Rodolfo Giometti <giometti@enneenne.com>
Subject: [PATCH] dt-bindings: more status property removal from examples
Date: Tue, 17 Apr 2018 08:57:32 -0500
Message-Id: <20180417135732.10100-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whack-a-mole some more occurrences of status in examples.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rodolfo Giometti <giometti@enneenne.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/k3dma.txt       | 1 -
 Documentation/devicetree/bindings/dma/ti-edma.txt     | 1 -
 Documentation/devicetree/bindings/mips/lantiq/rcu.txt | 2 --
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt    | 4 ----
 Documentation/devicetree/bindings/mtd/mtk-nand.txt    | 4 ----
 Documentation/devicetree/bindings/pci/xgene-pci.txt   | 7 -------
 Documentation/devicetree/bindings/pps/pps-gpio.txt    | 1 -
 7 files changed, 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
index 23f8d712c3ce..4945aeac4dc4 100644
--- a/Documentation/devicetree/bindings/dma/k3dma.txt
+++ b/Documentation/devicetree/bindings/dma/k3dma.txt
@@ -23,7 +23,6 @@ Controller:
 			dma-requests = <27>;
 			interrupts = <0 12 4>;
 			clocks = <&pclk>;
-			status = "disable";
 		};
 
 Client:
diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
index 66026dcf53e1..3f15f6644527 100644
--- a/Documentation/devicetree/bindings/dma/ti-edma.txt
+++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
@@ -190,7 +190,6 @@ mmc0: mmc@23000000 {
 	power-domains = <&k2g_pds 0xb>;
 	clocks = <&k2g_clks 0xb 1>, <&k2g_clks 0xb 2>;
 	clock-names = "fck", "mmchsdb_fck";
-	status = "disabled";
 };
 
 ------------------------------------------------------------------------------
diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
index a086f1e1cdd7..7f0822b4beae 100644
--- a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
+++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
@@ -61,7 +61,6 @@ Example of the RCU bindings on a xRX200 SoC:
 		usb_phy0: usb2-phy@18 {
 			compatible = "lantiq,xrx200-usb2-phy";
 			reg = <0x18 4>, <0x38 4>;
-			status = "disabled";
 
 			resets = <&reset1 4 4>, <&reset0 4 4>;
 			reset-names = "phy", "ctrl";
@@ -71,7 +70,6 @@ Example of the RCU bindings on a xRX200 SoC:
 		usb_phy1: usb2-phy@34 {
 			compatible = "lantiq,xrx200-usb2-phy";
 			reg = <0x34 4>, <0x3C 4>;
-			status = "disabled";
 
 			resets = <&reset1 5 4>, <&reset0 4 4>;
 			reset-names = "phy", "ctrl";
diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index 2d5287eeed95..634bb66fc49c 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -67,7 +67,6 @@ Example: R8A7790 (R-Car H2) SDHI controller nodes
 		max-frequency = <195000000>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		resets = <&cpg 314>;
-		status = "disabled";
 	};
 
 	sdhi1: sd@ee120000 {
@@ -81,7 +80,6 @@ Example: R8A7790 (R-Car H2) SDHI controller nodes
 		max-frequency = <195000000>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		resets = <&cpg 313>;
-		status = "disabled";
 	};
 
 	sdhi2: sd@ee140000 {
@@ -95,7 +93,6 @@ Example: R8A7790 (R-Car H2) SDHI controller nodes
 		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		resets = <&cpg 312>;
-		status = "disabled";
 	};
 
 	sdhi3: sd@ee160000 {
@@ -109,5 +106,4 @@ Example: R8A7790 (R-Car H2) SDHI controller nodes
 		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
 		resets = <&cpg 311>;
-		status = "disabled";
 	};
diff --git a/Documentation/devicetree/bindings/mtd/mtk-nand.txt b/Documentation/devicetree/bindings/mtd/mtk-nand.txt
index 1c88526dedfc..c5ba6a4ba1f2 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/mtk-nand.txt
@@ -20,7 +20,6 @@ Required NFI properties:
 - interrupts:			Interrupts of NFI.
 - clocks:			NFI required clocks.
 - clock-names:			NFI clocks internal name.
-- status:			Disabled default. Then set "okay" by platform.
 - ecc-engine:			Required ECC Engine node.
 - #address-cells:		NAND chip index, should be 1.
 - #size-cells:			Should be 0.
@@ -34,7 +33,6 @@ Example:
 		clocks = <&pericfg CLK_PERI_NFI>,
 			 <&pericfg CLK_PERI_NFI_PAD>;
 		clock-names = "nfi_clk", "pad_clk";
-		status = "disabled";
 		ecc-engine = <&bch>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -152,7 +150,6 @@ Required BCH properties:
 - interrupts:	Interrupts of ECC.
 - clocks:	ECC required clocks.
 - clock-names:	ECC clocks internal name.
-- status:	Disabled default. Then set "okay" by platform.
 
 Example:
 
@@ -162,5 +159,4 @@ Example:
 		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&pericfg CLK_PERI_NFI_ECC>;
 		clock-names = "nfiecc_clk";
-		status = "disabled";
 	};
diff --git a/Documentation/devicetree/bindings/pci/xgene-pci.txt b/Documentation/devicetree/bindings/pci/xgene-pci.txt
index 6fd2decfa66c..92490330dc1c 100644
--- a/Documentation/devicetree/bindings/pci/xgene-pci.txt
+++ b/Documentation/devicetree/bindings/pci/xgene-pci.txt
@@ -25,8 +25,6 @@ Optional properties:
 
 Example:
 
-SoC-specific DT Entry:
-
 	pcie0: pcie@1f2b0000 {
 		status = "disabled";
 		device_type = "pci";
@@ -50,8 +48,3 @@ SoC-specific DT Entry:
 		clocks = <&pcie0clk 0>;
 	};
 
-
-Board-specific DT Entry:
-	&pcie0 {
-		status = "ok";
-	};
diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
index 0de23b793657..3683874832ae 100644
--- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
+++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
@@ -20,5 +20,4 @@ Example:
 		assert-falling-edge;
 
 		compatible = "pps-gpio";
-		status = "okay";
 	};
-- 
2.14.1
