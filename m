Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeCGGOR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 01:14:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751234AbeCGGOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 01:14:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267B6217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Subject: [PATCH v1 8/9] PCI/portdrv: Remove unnecessary include of
 <linux/pci-aspm.h>
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>, Lukas Wunner <lukas@wunner.de>
Date: Wed, 07 Mar 2018 00:14:07 -0600
Message-ID: <152040324781.240786.5608927859426538659.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

portdrv_pci.c doesn't use anything from <linux/pci-aspm.h>.  Remove the
include of it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_pci.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 9475886eeb62..d12b58db18a1 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -18,7 +18,6 @@
 #include <linux/pcieport_if.h>
 #include <linux/aer.h>
 #include <linux/dmi.h>
-#include <linux/pci-aspm.h>
 
 #include "../pci.h"
 #include "portdrv.h"
