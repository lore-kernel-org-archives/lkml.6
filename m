Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeFCQBd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 12:01:33 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35692 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeFCQBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 12:01:30 -0400
X-Google-Smtp-Source: ADUXVKLMsFXCsNK9KJTgEqdHuHH4un2WtFKhpG8vzwnkk6g8yzzEycWoRMh7JSoCcmqvAxkm/EwYyA==
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: gregkh@linuxfoundation.org
Cc: matthias.bgg@gmail.com, neil@brown.name, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 7/7] staging: mt7621-pci: fix coding style error
Date: Sun,  3 Jun 2018 21:30:04 +0530
Message-Id: <dd5a61ff6074778d813183464fd65020098978c1.1528040188.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch error:

ERROR: that open brace { should be on the previous line

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 510aa633589a..96cae1e1838b 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -663,8 +663,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 
 	mdelay(500);
 #if defined (CONFIG_PCIE_PORT0)
-	if ((RALINK_PCI0_STATUS & 0x1) == 0)
-	{
+	if ((RALINK_PCI0_STATUS & 0x1) == 0) {
 		printk("PCIE0 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE0_RST);
 		RALINK_CLKCFG1 = (RALINK_CLKCFG1 & ~RALINK_PCIE0_CLK_EN);
@@ -675,8 +674,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	}
 #endif
 #if defined (CONFIG_PCIE_PORT1)
-	if ((RALINK_PCI1_STATUS & 0x1) == 0)
-	{
+	if ((RALINK_PCI1_STATUS & 0x1) == 0) {
 		printk("PCIE1 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE1_RST);
 		RALINK_CLKCFG1 = (RALINK_CLKCFG1 & ~RALINK_PCIE1_CLK_EN);
-- 
2.17.0
