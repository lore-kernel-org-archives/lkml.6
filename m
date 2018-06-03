Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbeFCQBe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 12:01:34 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46083 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeFCQB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 12:01:26 -0400
X-Google-Smtp-Source: ADUXVKJo2f7mlNuOPs9hQ/lmRYbhe8P2xCOijfSBDuDHaw6vpU31TIantg/Uzot93sqIuWzpH1amfQ==
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: gregkh@linuxfoundation.org
Cc: matthias.bgg@gmail.com, neil@brown.name, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 6/7] staging: mt7621-pci: add space after '==' symbol
Date: Sun,  3 Jun 2018 21:30:03 +0530
Message-Id: <e02b77f8a6eff5d66b68999252d304102860d082.1528040188.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch error:

ERROR: spaces required around that '==' (ctx:WxV)

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 3bd715a4b139..510aa633589a 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -417,13 +417,13 @@ pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 			irq = RALINK_INT_PCIE1;
 		}
 		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n", dev->bus->number, slot, dev->irq);
-	} else if ((dev->bus->number ==3) && (slot == 0x0)) {
+	} else if ((dev->bus->number == 3) && (slot == 0x0)) {
 		irq = RALINK_INT_PCIE2;
 		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n", dev->bus->number, slot, dev->irq);
-	} else if ((dev->bus->number ==3) && (slot == 0x1)) {
+	} else if ((dev->bus->number == 3) && (slot == 0x1)) {
 		irq = RALINK_INT_PCIE2;
 		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n", dev->bus->number, slot, dev->irq);
-	} else if ((dev->bus->number ==3) && (slot == 0x2)) {
+	} else if ((dev->bus->number == 3) && (slot == 0x2)) {
 		irq = RALINK_INT_PCIE2;
 		printk("bus=0x%x, slot = 0x%x, irq=0x%x\n", dev->bus->number, slot, dev->irq);
 	} else {
-- 
2.17.0
