Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbeFCQBV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 12:01:21 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35694 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeFCQBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 12:01:19 -0400
X-Google-Smtp-Source: ADUXVKIQEUdS2g/u+VADzeNXjsEfCYS2OpgJYqvel3UvVcuAN9rjWQIJ9/e8qSdnfDu4X1jsAtylOA==
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: gregkh@linuxfoundation.org
Cc: matthias.bgg@gmail.com, neil@brown.name, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 4/7] staging: mt7621-pci: add space after comma symbol
Date: Sun,  3 Jun 2018 21:30:01 +0530
Message-Id: <2204d11fb9c2ff5ccb0ae003a6a81e5415d4e65e.1528040188.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch error:

ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 36 ++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 28b9a11e9ecb..f347eaf9063c 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -373,17 +373,17 @@ pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 		write_config(0, 0, 0, PCI_BASE_ADDRESS_0, MEMORY_BASE);
 		read_config(0, 0, 0, PCI_BASE_ADDRESS_0, (unsigned long *)&val);
 		printk("BAR0 at slot 0 = %x\n", val);
-		printk("bus=0x%x, slot = 0x%x\n",dev->bus->number, slot);
+		printk("bus=0x%x, slot = 0x%x\n", dev->bus->number, slot);
 	} else if ((dev->bus->number == 0) && (slot == 0x1)) {
 		write_config(0, 1, 0, PCI_BASE_ADDRESS_0, MEMORY_BASE);
 		read_config(0, 1, 0, PCI_BASE_ADDRESS_0, (unsigned long *)&val);
 		printk("BAR0 at slot 1 = %x\n", val);
-		printk("bus=0x%x, slot = 0x%x\n",dev->bus->number, slot);
+		printk("bus=0x%x, slot = 0x%x\n", dev->bus->number, slot);
 	} else if ((dev->bus->number == 0) && (slot == 0x2)) {
 		write_config(0, 2, 0, PCI_BASE_ADDRESS_0, MEMORY_BASE);
 		read_config(0, 2, 0, PCI_BASE_ADDRESS_0, (unsigned long *)&val);
 		printk("BAR0 at slot 2 = %x\n", val);
-		printk("bus=0x%x, slot = 0x%x\n",dev->bus->number, slot);
+		printk("bus=0x%x, slot = 0x%x\n", dev->bus->number, slot);
 	} else if ((dev->bus->number == 1) && (slot == 0x0)) {
 		switch (pcie_link_status) {
 		case 2:
@@ -396,7 +396,7 @@ pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 		default:
 			irq = RALINK_INT_PCIE0;
 		}
-		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n",dev->bus->number, slot, dev->irq);
+		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n", dev->bus->number, slot, dev->irq);
 	} else if ((dev->bus->number == 2) && (slot == 0x0)) {
 		switch (pcie_link_status) {
 		case 5:
@@ -406,7 +406,7 @@ pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 		default:
 			irq = RALINK_INT_PCIE1;
 		}
-		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n",dev->bus->number, slot, dev->irq);
+		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n", dev->bus->number, slot, dev->irq);
 	} else if ((dev->bus->number == 2) && (slot == 0x1)) {
 		switch (pcie_link_status) {
 		case 5:
@@ -416,18 +416,18 @@ pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 		default:
 			irq = RALINK_INT_PCIE1;
 		}
-		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n",dev->bus->number, slot, dev->irq);
+		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n", dev->bus->number, slot, dev->irq);
 	} else if ((dev->bus->number ==3) && (slot == 0x0)) {
 		irq = RALINK_INT_PCIE2;
-		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n",dev->bus->number, slot, dev->irq);
+		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n", dev->bus->number, slot, dev->irq);
 	} else if ((dev->bus->number ==3) && (slot == 0x1)) {
 		irq = RALINK_INT_PCIE2;
-		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n",dev->bus->number, slot, dev->irq);
+		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n", dev->bus->number, slot, dev->irq);
 	} else if ((dev->bus->number ==3) && (slot == 0x2)) {
 		irq = RALINK_INT_PCIE2;
-		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n",dev->bus->number, slot, dev->irq);
+		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n", dev->bus->number, slot, dev->irq);
 	} else {
-		printk("bus=0x%x, slot = 0x%x\n",dev->bus->number, slot);
+		printk("bus=0x%x, slot = 0x%x\n", dev->bus->number, slot);
 		return 0;
 	}
 
@@ -501,10 +501,10 @@ set_phy_for_ssc(void)
 		if (reg >= 6) {
 			printk("***** Xtal 25MHz *****\n");
 			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4bc),  4, 2, 0x01);	// RG_PE1_H_PLL_FBKSEL             //Feedback clock select
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x49c),  0,31, 0x18000000);	// RG_PE1_H_LCDDS_PCW_NCPO         //DDS NCPO PCW (for host mode)
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a4),  0,16, 0x18d);	// RG_PE1_H_LCDDS_SSC_PRD          //DDS SSC dither period control
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a8),  0,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA        //DDS SSC dither amplitude control
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a8), 16,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA1       //DDS SSC dither amplitude control for initial
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x49c),  0, 31, 0x18000000);	// RG_PE1_H_LCDDS_PCW_NCPO         //DDS NCPO PCW (for host mode)
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a4),  0, 16, 0x18d);	// RG_PE1_H_LCDDS_SSC_PRD          //DDS SSC dither period control
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a8),  0, 12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA        //DDS SSC dither amplitude control
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x4a8), 16, 12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA1       //DDS SSC dither amplitude control for initial
 		} else {
 			printk("***** Xtal 20MHz *****\n");
 		}
@@ -539,10 +539,10 @@ set_phy_for_ssc(void)
 		set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x490),  6, 2, 0x00);	// RG_PE1_H_PLL_PREDIV             //Pre-divider ratio (for host mode)
 		if (reg >= 6) { 	// 25MHz Xtal
 			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4bc),  4, 2, 0x01);	// RG_PE1_H_PLL_FBKSEL             //Feedback clock select
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x49c),  0,31, 0x18000000);	// RG_PE1_H_LCDDS_PCW_NCPO         //DDS NCPO PCW (for host mode)
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a4),  0,16, 0x18d);	// RG_PE1_H_LCDDS_SSC_PRD          //DDS SSC dither period control
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a8),  0,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA        //DDS SSC dither amplitude control
-			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a8), 16,12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA1       //DDS SSC dither amplitude control for initial
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x49c),  0, 31, 0x18000000);	// RG_PE1_H_LCDDS_PCW_NCPO         //DDS NCPO PCW (for host mode)
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a4),  0, 16, 0x18d);	// RG_PE1_H_LCDDS_SSC_PRD          //DDS SSC dither period control
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a8),  0, 12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA        //DDS SSC dither amplitude control
+			set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a8), 16, 12, 0x4a);	// RG_PE1_H_LCDDS_SSC_DELTA1       //DDS SSC dither amplitude control for initial
 		}
 	}
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x4a0),  5, 1, 0x01);	// RG_PE1_LCDDS_CLK_PH_INV         //DDS clock inversion
-- 
2.17.0
