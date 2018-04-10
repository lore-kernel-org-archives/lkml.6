Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753621AbeDJM7C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:59:02 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:58176 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752752AbeDJM6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:58:51 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v3 05/10] PCI: Adds device ID for Synopsys Sample Endpoint.
Date: Tue, 10 Apr 2018 13:58:37 +0100
Message-Id: <5d99b4073ccf9927b52ba2f1ae671d64ff220b7b.1523360166.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1523360166.git.gustavo.pimentel@synopsys.com>
References: <cover.1523360166.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523360166.git.gustavo.pimentel@synopsys.com>
References: <cover.1523360166.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe controller dual mode is capable of operating in host mode as well
as endpoint mode by configuration.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
- Register new device id following Kishon's suggestion.
Change v2->v3:
- Nothing changed, just to follow the patch set version.

 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f22124e..887c04e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2349,6 +2349,7 @@
 #define PCI_DEVICE_ID_CENATEK_IDE	0x0001
 
 #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
+#define PCI_DEVICE_ID_SYNOPSYS_SMPL_EP	0xedda
 
 #define PCI_VENDOR_ID_VITESSE		0x1725
 #define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
-- 
2.7.4
