Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeEQH5o (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:57:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59959 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeEQH5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:57:43 -0400
From: Colin King <colin.king@canonical.com>
To: Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: snic: fix a couple of spelling mistakes: "COMPLETE"
Date: Thu, 17 May 2018 08:57:38 +0100
Message-Id: <20180517075738.22821-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes/typos:
"SNIC_IOREQ_ABTS_COMPELTE" -> "SNIC_IOREQ_ABTS_COMPLETE"
"SNIC_IOREQ_LR_COMPELTE"   -> "SNIC_IOREQ_LR_COMPLETE"
"SNIC_IOREQ_CMD_COMPELTE"  -> "SNIC_IOREQ_CMD_COMPLETE"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/snic/snic_scsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/snic/snic_scsi.c b/drivers/scsi/snic/snic_scsi.c
index d8a376b7882d..d9b2e46424aa 100644
--- a/drivers/scsi/snic/snic_scsi.c
+++ b/drivers/scsi/snic/snic_scsi.c
@@ -47,10 +47,10 @@ static const char * const snic_req_state_str[] = {
 	[SNIC_IOREQ_NOT_INITED]	= "SNIC_IOREQ_NOT_INITED",
 	[SNIC_IOREQ_PENDING]	= "SNIC_IOREQ_PENDING",
 	[SNIC_IOREQ_ABTS_PENDING] = "SNIC_IOREQ_ABTS_PENDING",
-	[SNIC_IOREQ_ABTS_COMPLETE] = "SNIC_IOREQ_ABTS_COMPELTE",
+	[SNIC_IOREQ_ABTS_COMPLETE] = "SNIC_IOREQ_ABTS_COMPLETE",
 	[SNIC_IOREQ_LR_PENDING]	= "SNIC_IOREQ_LR_PENDING",
-	[SNIC_IOREQ_LR_COMPLETE] = "SNIC_IOREQ_LR_COMPELTE",
-	[SNIC_IOREQ_COMPLETE]	= "SNIC_IOREQ_CMD_COMPELTE",
+	[SNIC_IOREQ_LR_COMPLETE] = "SNIC_IOREQ_LR_COMPLETE",
+	[SNIC_IOREQ_COMPLETE]	= "SNIC_IOREQ_CMD_COMPLETE",
 };
 
 /* snic cmd status strings */
-- 
2.17.0
