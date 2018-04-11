Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeDKHgz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:36:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38990 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeDKHgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:36:53 -0400
From: Colin King <colin.king@canonical.com>
To: Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: fnic: fix spelling mistake in fnic stats "Abord" -> "Abort"
Date: Wed, 11 Apr 2018 08:36:49 +0100
Message-Id: <20180411073649.21529-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in fnic stats message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/fnic/fnic_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index abddde11982b..98597b59c12a 100644
--- a/drivers/scsi/fnic/fnic_trace.c
+++ b/drivers/scsi/fnic/fnic_trace.c
@@ -296,7 +296,7 @@ int fnic_get_stats_data(struct stats_debug_info *debug,
 		  "Number of Abort FW Timeouts: %lld\n"
 		  "Number of Abort IO NOT Found: %lld\n"
 
-		  "Abord issued times: \n"
+		  "Abort issued times: \n"
 		  "            < 6 sec : %lld\n"
 		  "     6 sec - 20 sec : %lld\n"
 		  "    20 sec - 30 sec : %lld\n"
-- 
2.15.1
