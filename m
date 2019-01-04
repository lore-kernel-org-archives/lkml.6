Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE362C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DCA218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfADRGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:06:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48111 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfADRGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:06:30 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gfSvQ-0001tg-RV; Fri, 04 Jan 2019 17:06:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Varun Prakash <varun@chelsio.com>, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: csiostor: fix two minor indentation issues
Date:   Fri,  4 Jan 2019 17:06:24 +0000
Message-Id: <20190104170624.8287-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Two statements are indented incorrectly, fix these by removing
a tab and a space.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/csiostor/csio_mb.c   | 2 +-
 drivers/scsi/csiostor/csio_scsi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_mb.c b/drivers/scsi/csiostor/csio_mb.c
index 6f13673d6aa0..94810b19e747 100644
--- a/drivers/scsi/csiostor/csio_mb.c
+++ b/drivers/scsi/csiostor/csio_mb.c
@@ -1210,7 +1210,7 @@ csio_mb_issue(struct csio_hw *hw, struct csio_mb *mbp)
 		   !csio_is_hw_intr_enabled(hw)) {
 		csio_err(hw, "Cannot issue mailbox in interrupt mode 0x%x\n",
 			 *((uint8_t *)mbp->mb));
-			goto error_out;
+		goto error_out;
 	}
 
 	if (mbm->mcurrent != NULL) {
diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
index bc5547a62c00..c7db0777300a 100644
--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -1383,7 +1383,7 @@ csio_device_reset(struct device *dev,
 		return -EINVAL;
 
 	/* Delete NPIV lnodes */
-	 csio_lnodes_exit(hw, 1);
+	csio_lnodes_exit(hw, 1);
 
 	/* Block upper IOs */
 	csio_lnodes_block_request(hw);
-- 
2.19.1

