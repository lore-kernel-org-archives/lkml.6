Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeCSKxt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 06:53:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56786 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932296AbeCSKxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 06:53:45 -0400
From: Colin King <colin.king@canonical.com>
To: qla2xxx-upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: fix spelling mistake: "existant" -> "existent"
Date: Mon, 19 Mar 2018 10:53:41 +0000
Message-Id: <20180319105341.487-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in debug message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/qla2xxx/qla_target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 245005f1e93e..e002dd61e110 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -2023,7 +2023,7 @@ static void qlt_24xx_handle_abts(struct scsi_qla_host *vha,
 	sess = ha->tgt.tgt_ops->find_sess_by_s_id(vha, s_id);
 	if (!sess) {
 		ql_dbg(ql_dbg_tgt_mgt, vha, 0xf012,
-		    "qla_target(%d): task abort for non-existant session\n",
+		    "qla_target(%d): task abort for non-existent session\n",
 		    vha->vp_idx);
 		spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
 
-- 
2.15.1
