Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbeBAOCl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:02:41 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:49707 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeBAOCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:02:39 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: kishon@ti.com, Niklas Cassel <niklass@axis.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: designware-ep: Fix typo in error message
Date: Thu,  1 Feb 2018 15:02:23 +0100
Message-Id: <20180201140224.28229-1-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in error message. s/deb_base2/dbi_base2/

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/dwc/pcie-designware-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
index 3a6feeff5f5b..9236b998327f 100644
--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -322,7 +322,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device_node *np = dev->of_node;
 
 	if (!pci->dbi_base || !pci->dbi_base2) {
-		dev_err(dev, "dbi_base/deb_base2 is not populated\n");
+		dev_err(dev, "dbi_base/dbi_base2 is not populated\n");
 		return -EINVAL;
 	}
 
-- 
2.14.2
