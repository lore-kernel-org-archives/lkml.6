Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F2C65BA7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561542082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561542082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeJCDuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:50:13 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:46753 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJCDuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:50:12 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mq33i-1fKNqf2Gpe-00n9xG; Tue, 02 Oct 2018 23:04:31 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mq33i-1fKNqf2Gpe-00n9xG; Tue, 02 Oct 2018 23:04:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Oza Pawandeep <poza@codeaurora.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Alan Brady <alan.brady@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Shannon Nelson <shannon.nelson@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH] XXX PCI/AER: remove unused variables
Date:   Tue,  2 Oct 2018 23:02:49 +0200
Message-Id: <20181002210426.2447078-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:TUaN67X+02X+EMKP+hSGNGkckQwTSrG1GZm1Rp8wzdVRgJ0/msV
 +Lqs2e2/fzCFdbuoTP96rWq7TfSecHVEmIVKvVBn8nDwdtOQWNY0HCoMUqMUlWjfYNrX80S
 06R7zyF9gV4K+CbolRuboeiGMwT9fbHJmoSUgLiHSxn8aI0wrBnwqT7NwUYJYOLv3nA+pO5
 C6DiC/NXMmSuAgtBSA2ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KKWO7N0/Hl0=:pqjrm2NPGvnf+wEoqC0x7b
 cul3KaqJ9/98//C6V8WF1anZXr+lin8S+3usOg4BmiAucy9LK9Ga9wR9sEcv7y9utl9k3Bbi1
 NQCi5qJjSiTyFET2pcT5srVBbJuY5d1eoUEGLmwdRL93xzLFf8bRZWFUTs2NT3CnFWWPrRAIT
 GTWd+73I7G2vVHGpn8YdYdlbNEUUehfj1qjOxdXtg/qdSgWTJ8yxJyscntBYX5qagBMEUnMgg
 VV68K3tZ/bW4u76ZH7HeRr5IBKWrdwm2KLCPECVetLjNw8Qne2okxDX1CfCf0R8Hfqhnr1kgW
 eZfeA994zaiqkG8lnnKNK0EXhlhyET+sBZkYQOjvhdHV1/6WEcKShyzLZWYNdbeoGsL2dY+if
 dSSwXgp5eL9zeeruGOr81dDpl+ybmrTdTkJXLOzpdRt6SJxXcuIRrVNyBdOSJjdLPFWrD+SnD
 vTzMaz08eXDPHFVEit99Ru2EYq/qB2p844U+5x0y1sxOx25vy8xEY7JKx/C3BgTOM0Ui2Asvx
 0cx4Ca6sdPXsmnt3466oQmnAAJ6VYMMQZ7HO0uq9j360WqFMFGe6XOcdqUwon59wK1AoE7aoO
 4/eVxcvtV1PVyB/rtRwVu4NGQ4XqMHp1CMw2isJNdBPj0DodfXOzemgwlmv/SyLOMPuP7Y1Tg
 7X3rJR+PDGy4OH4NYUD3xzOYQT3HEfC11/0xsUxQ2oy2T0YVFS0v3NOmqOz6JxGtXUkU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of files now contain a function with a return
code variable that is no longer used:

drivers/net/ethernet/sfc/efx.c: In function 'efx_io_slot_reset':
drivers/net/ethernet/sfc/efx.c:3824:6: error: unused variable 'rc' [-Werror=unused-variable]
  int rc;
      ^~
drivers/net/ethernet/sfc/falcon/efx.c: In function 'ef4_io_slot_reset':
Oza Pawandeep <poza@codeaurora.org>
drivers/net/ethernet/sfc/falcon/efx.c:3163:6: error: unused variable 'rc' [-Werror=unused-variable]
  int rc;
      ^~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_io_slot_reset':
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:11143:6: error: unused variable 'err' [-Werror=unused-variable]
  int err;
      ^~~
drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_pci_error_slot_reset':
drivers/net/ethernet/intel/i40e/i40e_main.c:14555:6: error: unused variable 'err' [-Werror=unused-variable]
  int err;

drivers/dma/ioat/init.c: In function 'ioat_pcie_error_slot_reset':
drivers/dma/ioat/init.c:1255:6: error: unused variable 'err' [-Werror=unused-variable]
  int err;

This removes all the ones I found during randconfig build testing.

Fixes: 6dcde3e574b2 ("XXX PCI/AER: Remove pci_cleanup_aer_uncorrect_error_status() calls")
Cc: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/ioat/init.c                       | 1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 1 -
 drivers/net/ethernet/sfc/efx.c                | 1 -
 drivers/net/ethernet/sfc/falcon/efx.c         | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 80c475fb8ede..bd8db5c99597 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1252,7 +1252,6 @@ static pci_ers_result_t ioat_pcie_error_detected(struct pci_dev *pdev,
 static pci_ers_result_t ioat_pcie_error_slot_reset(struct pci_dev *pdev)
 {
 	pci_ers_result_t result = PCI_ERS_RESULT_RECOVERED;
-	int err;
 
 	dev_dbg(&pdev->dev, "%s post reset handling\n", DRV_NAME);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4654ac69dfb6..bc71a21c1dc2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14552,7 +14552,6 @@ static pci_ers_result_t i40e_pci_error_slot_reset(struct pci_dev *pdev)
 {
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 	pci_ers_result_t result;
-	int err;
 	u32 reg;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9bee51d900ac..0a2b9cad4b1c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11140,7 +11140,6 @@ static pci_ers_result_t ixgbe_io_slot_reset(struct pci_dev *pdev)
 {
 	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
 	pci_ers_result_t result;
-	int err;
 
 	if (pci_enable_device_mem(pdev)) {
 		e_err(probe, "Cannot re-enable PCI device after reset.\n");
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index ec941ca967b3..98fe7e762e17 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -3821,7 +3821,6 @@ static pci_ers_result_t efx_io_slot_reset(struct pci_dev *pdev)
 {
 	struct efx_nic *efx = pci_get_drvdata(pdev);
 	pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
-	int rc;
 
 	if (pci_enable_device(pdev)) {
 		netif_err(efx, hw, efx->net_dev,
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index 9b728efd71a4..8b1f94d7a6c5 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -3160,7 +3160,6 @@ static pci_ers_result_t ef4_io_slot_reset(struct pci_dev *pdev)
 {
 	struct ef4_nic *efx = pci_get_drvdata(pdev);
 	pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
-	int rc;
 
 	if (pci_enable_device(pdev)) {
 		netif_err(efx, hw, efx->net_dev,
-- 
2.18.0

