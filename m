Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeFCQB1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 12:01:27 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36256 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeFCQBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 12:01:22 -0400
X-Google-Smtp-Source: ADUXVKLHHm741+GspCbUIapakr8fXd3EVcdEcK0G+VLtySLA2ZOrHnrJjF4ISgyfI0xidAXa/Teoag==
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: gregkh@linuxfoundation.org
Cc: matthias.bgg@gmail.com, neil@brown.name, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 5/7] staging: mt7621-pci: add spaces around equal symbol
Date: Sun,  3 Jun 2018 21:30:02 +0530
Message-Id: <1e90044ff2eff4012fbdf546607354074a580fcf.1528040188.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
In-Reply-To: <cover.1528040188.git.abdun.nihaal@gmail.com>
References: <cover.1528040188.git.abdun.nihaal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch error:

ERROR: spaces required around that '=' (ctx:VxW)

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index f347eaf9063c..3bd715a4b139 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -308,7 +308,7 @@ pci_config_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u
 	}
 }
 
-struct pci_ops mt7621_pci_ops= {
+struct pci_ops mt7621_pci_ops = {
 	.read		=  pci_config_read,
 	.write		= pci_config_write,
 };
@@ -584,8 +584,8 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	unsigned long val = 0;
 
 	iomem_resource.start = 0;
-	iomem_resource.end= ~0;
-	ioport_resource.start= 0;
+	iomem_resource.end = ~0;
+	ioport_resource.start = 0;
 	ioport_resource.end = ~0;
 
 #if defined (CONFIG_PCIE_PORT0)
-- 
2.17.0
