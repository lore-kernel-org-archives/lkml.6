Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751288AbeFCQBF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 12:01:05 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38035 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeFCQBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 12:01:04 -0400
X-Google-Smtp-Source: ADUXVKJMV+KfOeKqXLfq+JT/8o1i3eYpYOAeyJaWkjzHq5f24jVEqLYCc8sDKTZ/iZQarkf6c+OjOA==
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: gregkh@linuxfoundation.org
Cc: matthias.bgg@gmail.com, neil@brown.name, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 1/7] staging: mt7621-pci: Remove space after open parenthesis
Date: Sun,  3 Jun 2018 21:29:58 +0530
Message-Id: <e1ebc6d90b6a35239dd477a91bb64699461c87f7.1528040188.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch error:

ERROR: space prohibited after that open parenthesis '('

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 1fa41eb8a87f..44f1a592a7a5 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -221,7 +221,7 @@ static int config_access(unsigned char access_type, struct pci_bus *bus,
 		MV_WRITE(data_reg, *data);
 		break;
 	case PCI_ACCESS_READ_1:
-		MV_READ_8( data_reg+(where&0x3), data);
+		MV_READ_8(data_reg+(where&0x3), data);
 		break;
 	case PCI_ACCESS_READ_2:
 		MV_READ_16(data_reg+(where&0x3), data);
@@ -663,7 +663,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 
 	mdelay(500);
 #if defined (CONFIG_PCIE_PORT0)
-	if(( RALINK_PCI0_STATUS & 0x1) == 0)
+	if((RALINK_PCI0_STATUS & 0x1) == 0)
 	{
 		printk("PCIE0 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE0_RST);
@@ -675,7 +675,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	}
 #endif
 #if defined (CONFIG_PCIE_PORT1)
-	if(( RALINK_PCI1_STATUS & 0x1) == 0)
+	if((RALINK_PCI1_STATUS & 0x1) == 0)
 	{
 		printk("PCIE1 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE1_RST);
@@ -687,7 +687,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	}
 #endif
 #if defined (CONFIG_PCIE_PORT2)
-	if (( RALINK_PCI2_STATUS & 0x1) == 0) {
+	if ((RALINK_PCI2_STATUS & 0x1) == 0) {
 		printk("PCIE2 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE2_RST);
 		RALINK_CLKCFG1 = (RALINK_CLKCFG1 & ~RALINK_PCIE2_CLK_EN);
-- 
2.17.0
