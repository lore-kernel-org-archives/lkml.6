Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54909C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F4321872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfADRLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:11:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48156 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfADRLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:11:34 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gfSzK-000264-FX; Fri, 04 Jan 2019 17:10:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Achim Leubner <achim_leubner@adaptec.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: gdth: fix indentation issue, remove a tab
Date:   Fri,  4 Jan 2019 17:10:25 +0000
Message-Id: <20190104171025.8448-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A goto statement is indented incorrectly, fix this by removing a tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/gdth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
index 194c294f9b6c..159a4e301c4d 100644
--- a/drivers/scsi/gdth.c
+++ b/drivers/scsi/gdth.c
@@ -5039,7 +5039,7 @@ static int gdth_pci_probe_one(gdth_pci_str *pcistr, gdth_ha_str **ha_out)
 		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32))) {
 			printk(KERN_WARNING "GDT-PCI %d: "
 				"Unable to set 32-bit DMA\n", ha->hanum);
-				goto out_free_coal_stat;
+			goto out_free_coal_stat;
 		}
 	} else {
 		shp->max_cmd_len = 16;
-- 
2.19.1

